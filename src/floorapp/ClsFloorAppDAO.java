package floorapp;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsFloorAppDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public String updateBayMoveSimpler(String jobcarddocno,String cmbbaymovupdate,String baymovupdateindate,String baymovupdateintime,
			String baymovupdateoutdate,String baymovupdateouttime,String baymovupdateremarks,HttpServletRequest request,HttpSession session,String baystatus) throws SQLException{
		String msg="";
		Connection conn=null;
		int errorstatus=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			java.sql.Date sqlindate=null,sqloutdate=null;
			if(!baymovupdateindate.equalsIgnoreCase("") && baymovupdateindate!=null && !baymovupdateindate.equalsIgnoreCase("null")){
				sqlindate=objcommon.changeStringtoSqlDate(baymovupdateindate);
			}
			if(!baymovupdateoutdate.equalsIgnoreCase("") && baymovupdateoutdate!=null && !baymovupdateoutdate.equalsIgnoreCase("null")){
				sqloutdate=objcommon.changeStringtoSqlDate(baymovupdateoutdate);
			}
			String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
			//Insert Query
			int baymovcount=0;
			String strgetbaymovcount="select count(*) movcount from ws_baymove where status=3 and jobcarddocno="+jobcarddocno+" and bayid="+cmbbaymovupdate;
			ResultSet rsgetbaymovcount=stmt.executeQuery(strgetbaymovcount);
			while(rsgetbaymovcount.next()){
				baymovcount=rsgetbaymovcount.getInt("movcount");
			}
			if(baymovcount==0){
				String strinsertmov="";
				if(sqloutdate==null){
					strinsertmov="insert into ws_baymove(jobcarddocno, bayid, indate, intime,engaged, inuserid,inremarks)values ("+jobcarddocno+","+cmbbaymovupdate+",'"+sqlindate+"','"+baymovupdateintime+"',1,'"+userid+"','"+baymovupdateremarks+"')";
				}else {
					strinsertmov="insert into ws_baymove(jobcarddocno, bayid, indate, intime,engaged, inuserid,inremarks,outdate,outtime,outuserid,outremarks)values("+jobcarddocno+","+cmbbaymovupdate+",'"+sqlindate+"','"+baymovupdateintime+"',1,'"+userid+"','"+baymovupdateremarks+"','"+sqloutdate+"','"+baymovupdateouttime+"','"+userid+"','"+baymovupdateremarks+"')";
				}
				System.out.println(strinsertmov);
				int insertmov=stmt.executeUpdate(strinsertmov);
				if(insertmov<=0){
					errorstatus=1;
				}
			}
			else{
				//Getting last outdate
				String strdatevalidate="select cast(concat(indate,' ',intime) as datetime)>cast(concat('"+sqloutdate+"',' ','"+baymovupdateouttime+"') as datetime) status from ws_baymove where rowno=(select max(rowno) from ws_baymove where status=3 and jobcarddocno="+jobcarddocno+" and bayid="+cmbbaymovupdate+")";
				int invaliddate=0;
				ResultSet rsdatevalidate=stmt.executeQuery(strdatevalidate);
				while(rsdatevalidate.next()){
					invaliddate=rsdatevalidate.getInt("status");
				}
				if(invaliddate==1){
					errorstatus=1;
					msg="Outdate and time must be greater than in date";
					return errorstatus+"::"+msg;
				}
				String strinsertmov="update ws_baymove set outdate='"+sqloutdate+"',outtime='"+baymovupdateouttime+"',outuserid='"+userid+"',outremarks='"+baymovupdateremarks+"' where jobcarddocno="+jobcarddocno+" and bayid="+cmbbaymovupdate;
				System.out.println(strinsertmov);
				int insertmov=stmt.executeUpdate(strinsertmov);
				if(insertmov<=0){
					errorstatus=1;
				}
			}
			
			int movcount=0;
			String strgetmovcount="select count(*) movcount from ws_baymove where status=3 and jobcarddocno="+jobcarddocno;
			ResultSet rsgetmovcount=stmt.executeQuery(strgetmovcount);
			while(rsgetmovcount.next()){
				movcount=rsgetmovcount.getInt("movcount");
			}
			
			if(movcount==0){
				String strgetzonestatus="select coalesce(z"+cmbbaymovupdate+",'') zonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
				System.out.println(strgetzonestatus);
				ResultSet rsgetzonestatus=stmt.executeQuery(strgetzonestatus);
				String zonedata="";
				while(rsgetzonestatus.next()){
					zonedata=rsgetzonestatus.getString("zonedata");
				}
				String strnumber=zonedata.replaceAll("[^0-9]", "");
				String strzoneupdated=strnumber+"PN";
				String strupdatezonestatus="update ws_floormgmtdata set z"+cmbbaymovupdate+"='"+strzoneupdated+"',currentbay='"+cmbbaymovupdate+"' where jobdocno="+jobcarddocno;
				System.out.println(strupdatezonestatus);
				int updatezonestatus=stmt.executeUpdate(strupdatezonestatus);
				if(updatezonestatus<=0){
					//Validation : Floor Mgmt Update Error
					msg="Floor Mgmt Update Error";
					errorstatus=6;
					return errorstatus+"::"+msg;
				}
			}
			else{
				String strgetlastbay="select bayid from ws_baymove where rowno=(select max(rowno) from ws_baymove where status=3 and jobcarddocno="+jobcarddocno+")";
				ResultSet rsgetlastbay=stmt.executeQuery(strgetlastbay);
				int lastbay=0;
				while(rsgetlastbay.next()){
					lastbay=rsgetlastbay.getInt("bayid");
				}
				String strgetzonestatus="select coalesce(z"+lastbay+",'') zonedata,coalesce(z"+cmbbaymovupdate+",'') currentzonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
				System.out.println(strgetzonestatus);
				ResultSet rsgetzonestatus=stmt.executeQuery(strgetzonestatus);
				String zonedata="";
				String currentzonedata="";
				while(rsgetzonestatus.next()){
					zonedata=rsgetzonestatus.getString("zonedata");
					currentzonedata=rsgetzonestatus.getString("currentzonedata");
				}
				String strnumber=zonedata.replaceAll("[^0-9]", "");
				String strcurrentnumber=currentzonedata.replaceAll("[^0-9]", "");
				String updatedzone="";
				if(zonedata.contains("C")){
					updatedzone=strnumber+"C";
				}
				else if(zonedata.contains("S")){
					updatedzone=strnumber+"S";
				}
				else{
					updatedzone=strnumber+"-";
				}
				String strupdatezone="update ws_floormgmtdata set z"+lastbay+"='"+updatedzone+"',z"+cmbbaymovupdate+"='"+strcurrentnumber+"PN',currentbay='"+cmbbaymovupdate+"' where jobdocno="+jobcarddocno;
				System.out.println(strupdatezone);
				int updatezone=stmt.executeUpdate(strupdatezone);
				if(updatezone<=0){
					//Validation : Floor Mgmt Update Error
					msg="Floor Mgmt Update Error";
					errorstatus=6;
					return errorstatus+"::"+msg;
				}
			}
			
			String strsql="select z"+cmbbaymovupdate+" zonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
			ResultSet rs=stmt.executeQuery(strsql);
			String zonedata="";
			while(rs.next()){
				zonedata=rs.getString("zonedata");
			}
			
			String strnumber=zonedata.replaceAll("[^0-9]", "");
			String newzonedata="";
			if(zonedata.contains("P")){
				newzonedata=strnumber+"P"+baystatus;
			}
			else{  
				newzonedata=strnumber+baystatus;
			}
			String strupdate="update ws_floormgmtdata set z"+cmbbaymovupdate+"='"+newzonedata+"' where jobdocno="+jobcarddocno;
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval<0){
				msg="Zone Status Update Error";
				errorstatus=1;
				return errorstatus+"::"+msg;
			}
			String strcheckdelivery="select coalesce(z12,'') z12 from ws_floormgmtdata where jobdocno="+jobcarddocno;
			ResultSet rscheckdelivery=stmt.executeQuery(strcheckdelivery);
			String deliveryzonedata="";
			while(rscheckdelivery.next()){
				deliveryzonedata=rscheckdelivery.getString("z12");
			}
			if(deliveryzonedata.contains("P")){
				String strupdatedelout="update ws_baymove set outdate='"+sqlindate+"',outtime='"+baymovupdateintime+"',engaged=0,outuserid="+userid+",outremarks='Closed On Delivery' where jobcarddocno="+jobcarddocno+" and bayid="+cmbbaymovupdate;
				int updatedelout=stmt.executeUpdate(strupdatedelout);
				if(updatedelout<=0){
					msg="Bay Movement Delivery Update Error";
					errorstatus=6;
					return errorstatus+"::"+msg;
				}
				String strupdatedelivery="update ws_floormgmtdata set deliverystatus=1 where jobdocno="+jobcarddocno;
				int updatedelivery=stmt.executeUpdate(strupdatedelivery);
				if(updatedelivery<=0){
					msg="Delivery Status Update Error";
					errorstatus=7;
					return errorstatus+"::"+msg;
				}
			}
			if(errorstatus==0){
				conn.commit();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			errorstatus=1;
		}
		finally{
			conn.close();
		}
		return errorstatus+"::"+msg;
	}
	
	public String updateBayMove(String jobcarddocno,String cmbbaymovupdate,String baymovupdateindate,String baymovupdateintime,
			String baymovupdateoutdate,String baymovupdateouttime,String baymovupdateremarks,HttpServletRequest request,HttpSession session)throws SQLException{
			String msg="";
			int errorstatus=0;
			Connection conn=null;
			try{
				conn=objconn.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmt=conn.createStatement();
				java.sql.Date sqlindate=null,sqloutdate=null;
				if(!baymovupdateindate.equalsIgnoreCase("")){
					sqlindate=objcommon.changeStringtoSqlDate(baymovupdateindate);
				}
				if(!baymovupdateoutdate.equalsIgnoreCase("")){
					sqloutdate=objcommon.changeStringtoSqlDate(baymovupdateoutdate);
				}
				int engaged=0;
				int engagedbay=0;
				String strcheckengaged="select coalesce(engaged,0) engaged,bayid engagedbay from ws_baymove where status=3 and jobcarddocno="+jobcarddocno;
				ResultSet rscheckengaged=stmt.executeQuery(strcheckengaged);
				while(rscheckengaged.next()){
					engaged=rscheckengaged.getInt("engaged");
					engagedbay=rscheckengaged.getInt("engagedbay");
				}
				if(engaged==1 && engagedbay!=(Integer.parseInt(cmbbaymovupdate))){
					//Validation : You Must Close Opened Movement at z+engagedbay
					msg="You Must Close the Movement Opened at z"+engagedbay;
					errorstatus=2;
					return errorstatus+"::"+msg;
				}
				String strgetcurrentbay="select coalesce(currentbay,'') currentbay from ws_floormgmtdata where jobdocno="+jobcarddocno;
				String currentbay="";
				ResultSet rsgetcurrentbay=stmt.executeQuery(strgetcurrentbay);
				while(rsgetcurrentbay.next()){
					currentbay=rsgetcurrentbay.getString("currentbay");
				}
				if(engaged==0 && currentbay.equalsIgnoreCase(cmbbaymovupdate)){
					//Validation : Cannot update to same bay
					msg="Cannot Update to Same Bay";
					errorstatus=1;
					return errorstatus+"::"+msg;
				}
				
				if(engaged==1){
					String strgetengageddata="select indate,intime from ws_baymove where status=3 and engaged=1 and jobcarddocno="+jobcarddocno;
					java.sql.Date sqlengagedindate=null;
					String sqlengagedintime="";
					ResultSet rsgetengageddata=stmt.executeQuery(strgetengageddata);
					while(rsgetengageddata.next()){
						sqlengagedindate=rsgetengageddata.getDate("indate");
						sqlengagedintime=rsgetengageddata.getString("intime");
					}
					if(sqloutdate.compareTo(sqlengagedindate)<0){
						//Validation: Out Date must be greater than in date
						msg="Out Date must be greater than in date";
						errorstatus=3;
						return errorstatus+"::"+msg;
					}
					else if(sqloutdate.compareTo(sqlengagedindate)==0){
						if(Integer.parseInt(baymovupdateouttime.split(":")[0])<Integer.parseInt(sqlengagedintime.split(":")[0])){
							//Validation: Out Time must be greater than in time
							msg="Out Time must be greater than in time";
							errorstatus=4;
							return errorstatus+"::"+msg;
						}
						else if(Integer.parseInt(baymovupdateouttime.split(":")[0])==Integer.parseInt(sqlengagedintime.split(":")[0])){
							if(Integer.parseInt(baymovupdateouttime.split(":")[1])<Integer.parseInt(sqlengagedintime.split(":")[1])){
								//Validation: Out Time must be greater than in time
								msg="Out Time must be greater than in time";
								errorstatus=4;
								return errorstatus+"::"+msg;
							}
						}
					}
				}
				int movcount=0;
				String strgetmovcount="select count(*) movcount from ws_baymove where status=3 and jobcarddocno="+jobcarddocno;
				ResultSet rsgetmovcount=stmt.executeQuery(strgetmovcount);
				while(rsgetmovcount.next()){
					movcount=rsgetmovcount.getInt("movcount");
				}
				
				if(engaged==0){
					if(movcount==0){
						String strgetzonestatus="select coalesce(z"+cmbbaymovupdate+",'') zonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
						System.out.println(strgetzonestatus);
						ResultSet rsgetzonestatus=stmt.executeQuery(strgetzonestatus);
						String zonedata="";
						while(rsgetzonestatus.next()){
							zonedata=rsgetzonestatus.getString("zonedata");
						}
						String strnumber=zonedata.replaceAll("[^0-9]", "");
						String strzoneupdated=strnumber+"PN";
						String strupdatezonestatus="update ws_floormgmtdata set z"+cmbbaymovupdate+"='"+strzoneupdated+"',currentbay='"+cmbbaymovupdate+"' where jobdocno="+jobcarddocno;
						System.out.println(strupdatezonestatus);
						int updatezonestatus=stmt.executeUpdate(strupdatezonestatus);
						if(updatezonestatus<=0){
							//Validation : Floor Mgmt Update Error
							msg="Floor Mgmt Update Error";
							errorstatus=6;
							return errorstatus+"::"+msg;
						}
					}
					else{
						String strgetlastbay="select bayid from ws_baymove where rowno=(select max(rowno) from ws_baymove where status=3 and jobcarddocno="+jobcarddocno+")";
						ResultSet rsgetlastbay=stmt.executeQuery(strgetlastbay);
						int lastbay=0;
						while(rsgetlastbay.next()){
							lastbay=rsgetlastbay.getInt("bayid");
						}
						String strgetzonestatus="select coalesce(z"+lastbay+",'') zonedata,coalesce(z"+cmbbaymovupdate+",'') currentzonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
						System.out.println(strgetzonestatus);
						ResultSet rsgetzonestatus=stmt.executeQuery(strgetzonestatus);
						String zonedata="";
						String currentzonedata="";
						while(rsgetzonestatus.next()){
							zonedata=rsgetzonestatus.getString("zonedata");
							currentzonedata=rsgetzonestatus.getString("currentzonedata");
						}
						String strnumber=zonedata.replaceAll("[^0-9]", "");
						String strcurrentnumber=currentzonedata.replaceAll("[^0-9]", "");
						String updatedzone="";
						if(zonedata.contains("C")){
							updatedzone=strnumber+"C";
						}
						else if(zonedata.contains("S")){
							updatedzone=strnumber+"S";
						}
						else{
							updatedzone=strnumber+"-";
						}
						String strupdatezone="update ws_floormgmtdata set z"+lastbay+"='"+updatedzone+"',z"+cmbbaymovupdate+"='"+strcurrentnumber+"PN',currentbay='"+cmbbaymovupdate+"' where jobdocno="+jobcarddocno;
						System.out.println(strupdatezone);
						int updatezone=stmt.executeUpdate(strupdatezone);
						if(updatezone<=0){
							//Validation : Floor Mgmt Update Error
							msg="Floor Mgmt Update Error";
							errorstatus=6;
							return errorstatus+"::"+msg;
						}
					}
				}
				String strsql="";
				String userid=session.getAttribute("USERID").toString();
				if(engaged==0){
					strsql="insert into ws_baymove(jobcarddocno, bayid, indate, intime,engaged, inuserid,inremarks)values("+jobcarddocno+","+cmbbaymovupdate+",'"+sqlindate+"','"+baymovupdateintime+"',1,"+userid+",'"+baymovupdateremarks+"')";
				}
				else{
					strsql="update ws_baymove set outdate='"+sqloutdate+"',outtime='"+baymovupdateouttime+"',engaged=0,outuserid="+userid+",outremarks='"+baymovupdateremarks+"' where jobcarddocno="+jobcarddocno+" and bayid="+cmbbaymovupdate;
				}
				System.out.println(strsql);
				int sqlupdate=stmt.executeUpdate(strsql);
				if(sqlupdate<=0){
					//Validation : Bay Movement Insert/Update Error
					msg="Bay Movement Insert/Update Error";
					errorstatus=5;
					return errorstatus+"::"+msg;
				}
				String strcheckdelivery="select coalesce(z12,'') z12 from ws_floormgmtdata where jobdocno="+jobcarddocno;
				ResultSet rscheckdelivery=stmt.executeQuery(strcheckdelivery);
				String deliveryzonedata="";
				while(rscheckdelivery.next()){
					deliveryzonedata=rscheckdelivery.getString("z12");
				}
				if(deliveryzonedata.contains("P")){
					String strupdatedelout="update ws_baymove set outdate='"+sqlindate+"',outtime='"+baymovupdateintime+"',engaged=0,outuserid="+userid+",outremarks='Closed On Delivery' where jobcarddocno="+jobcarddocno+" and bayid="+cmbbaymovupdate;
					int updatedelout=stmt.executeUpdate(strupdatedelout);
					if(updatedelout<=0){
						msg="Bay Movement Delivery Update Error";
						errorstatus=6;
						return errorstatus+"::"+msg;
					}
					String strupdatedelivery="update ws_floormgmtdata set deliverystatus=1 where jobdocno="+jobcarddocno;
					int updatedelivery=stmt.executeUpdate(strupdatedelivery);
					if(updatedelivery<=0){
						msg="Delivery Status Update Error";
						errorstatus=7;
						return errorstatus+"::"+msg;
					}
				}
			if(errorstatus==0){
					conn.commit();
				}
			}
			catch(Exception e){
				e.printStackTrace();
				errorstatus=1;
			}
			finally{
				conn.close();
			}
			return errorstatus+"::"+msg;
		}
	public JSONArray getTeamData(String id,String brhid) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn =null;
		try {
			String sqlfilters="";
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and (m.avbrchid="+brhid+" or m.avbrchid='a') ";
			}
			conn = objconn.getMyConnection();
			Statement stmt =conn.createStatement();
			ResultSet resultSet = stmt.executeQuery ("select m.grpcode,m.description desc1,m.doc_no docno,m.ismulemp,m.serteamuserlink teamuserlinkid,u.user_name teamuserlinkname from ws_teammasterm m left join my_user u on u.doc_no=m.serteamuserlink where m.status=3"+sqlfilters);
			RESULTDATA=objcommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
}
