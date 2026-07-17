package com.dashboard.workshop.floordelivered;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFloorDeliveredDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getFloorMgmtData(String id,String brhid,String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			String sqltest="";
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqltest+=" and flr.brhid="+brhid;
			}
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and job.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and job.date<='"+sqltodate+"'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();

			String strsql="select gate.doc_no gatedocno,est.doc_no estdocno,flr.totalloss,flr.brhid,br.branchname,flr.esttotal,flr.jobdate,flr.deliverystatus,flr.regno,flr.rowno,case when flr.z1 like "+
			" '%N%' or flr.z2 like '%N%'  or flr.z3 like '%N%'  or flr.z4 like '%N%'  or flr.z5 like '%N%' or flr.z12 like '%N%'  or flr.z6 like "+
			" '%N%'  or flr.z7 like '%N%' or flr.z8 like '%N%'  or flr.z9 like '%N%'  or flr.z10 like '%N%'  or flr.z11 like '%N%' or flr.z13 like '%N%' or flr.z14 "+
			" like '%N%' then 1 else 0 end unattendedstatus,flr.jobdocno, flr.jobvocno, flr.vehicledetails, flr.billto, flr.client refname, "+
			" flr.service,datediff(curdate(),flr.jobdate) age, flr.z1,flr.z2, flr.z3, flr.z4, flr.z5, flr.z6, flr.z7, flr.z8, flr.z9, flr.z10, "+
			" flr.z11,flr.z12, flr.z13, flr.z14, flr.priority, coalesce(flr.partsstatus,'') partsstatus, flr.partsexpdate, flr.promiseddate,"+
			" flr.extdate, flr.esthrs, flr.actualhrs, flr.hrsdiff, flr.grpname, flr.estimator, flr.srvcadvisor,flr.salesman, flr.insursurvivor,"+
			" flr.referredby from ws_floormgmtdata flr left join my_brch br on flr.brhid=br.doc_no left join ws_jobcard job on "+
			" flr.jobdocno=job.doc_no left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on "+
			" est.gipno=gate.doc_no where flr.deliverystatus=1 "+sqltest+" order by brhid,jobvocno";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getFloorMgmtDataExcel(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select flr.jobvocno 'Job No',date_format(flr.jobdate,'%d.%m.%Y') 'Job Date', flr.vehicledetails 'Vehicle Details', "+
			" flr.billto 'Bill To', flr.client 'Client', datediff(curdate(),flr.jobdate) 'Age',coalesce(flr.z1,'') 'WT1', coalesce(flr.z2,'') "+
			" 'WT2', coalesce(flr.z3,'') 'DNT', coalesce(flr.z4,'') 'PNT', coalesce(flr.z5,'') 'DRY', coalesce(flr.z6,'') 'POL', coalesce(flr.z7,'') "+
			" 'FIT', coalesce(flr.z8,'') 'MWT', coalesce(flr.z9,'') 'MEC', coalesce(flr.z10,'') 'WAS', coalesce(flr.z11,'') 'PDI', "+
			" coalesce(flr.z12,'') 'DEL', coalesce(flr.z13,'') 'OTS', coalesce(flr.z14,'') 'QSE', flr.priority 'Priority', case when "+
			" flr.partsstatus=1 then 'Available' when flr.partsstatus=3 then 'Delayed' end 'Parts Status', date_format(flr.partsexpdate,'%d.%m.%Y') "+
			" 'Parts Exp.Date', date_format(flr.promiseddate,'%d.%m.%Y') 'Promised Date',coalesce(date_format(delbaymov.indate,'%d.%m.%Y'),'') "+
			" 'Del.In Date', date_format(flr.extdate,'%d.%m.%Y') 'Extended Date', flr.esthrs 'Estimate Hrs', flr.actualhrs 'Actual Hrs', "+
			" flr.hrsdiff 'Hrs Diff.',round(flr.esttotal,2) 'Est.Total',flr.service 'Service', flr.grpname 'Group', flr.estimator 'Estimator', "+
			" flr.srvcadvisor 'Service Advisor', flr.salesman 'Salesman', flr.insursurvivor 'Insurance Survivor', flr.referredby 'Referred By' "+
			" from ws_floormgmtdata flr left join (select jobcarddocno jobdocno,indate from ws_baymove where bayid=12 group by "+
			" jobcarddocno) delbaymov on flr.jobdocno=delbaymov.jobdocno where completestatus=0 and invstatus=0";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getBayMovData(String id,String jobcarddocno)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select TIMESTAMPDIFF(minute,cast(concat(indate,' ',intime)as datetime),cast(concat(outdate,' ',outtime)as datetime))/60/24 useddays,bay.name bay,mov.indate,mov.intime,mov.outdate,mov.outtime,mov.inremarks,mov.outremarks,inuser.user_name inuser,outuser.user_name outuser from ws_baymove mov left join ws_bay bay on mov.bayid=bay.doc_no left join my_user inuser on mov.inuserid=inuser.doc_no left join my_user outuser on mov.outuserid=outuser.doc_no where mov.jobcarddocno="+jobcarddocno;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getPartsData(String id,String jobcarddocno,String rowno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			/*String strgetestno="select refno from ws_jobcard where doc_no="+jobcarddocno;
			int estdocno=0;
			ResultSet rsgetestno=stmt.executeQuery(strgetestno);
			while(rsgetestno.next()){
				estdocno=rsgetestno.getInt("refno");
			}*/
			String strsql="select spr.availability,spr.outqty purchaseqty,spr.description,spr.qty requestqty,spr.qty qty,spr.qty-spr.outqty balanceqty from ws_estm em inner JOIN  ws_estspare spr on spr.rdocno=em.doc_no inner JOIN ws_jobcard jb on (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est')  where  jb.doc_no='"+rowno+"'";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getJobWorkersData(String id,String jobcarddocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select TIMESTAMPDIFF(minute,cast(concat(startdate,' ',starttime)as datetime),cast(concat(closedate,' ',closetime)as datetime))/60 workhours,tech.name technician,startdate,starttime,closedate,closetime"+
			" from ws_clockin clk left join ws_technician tech on clk.technicianid=tech.doc_no left join ws_jobcard jc on clk.jcno=jc.doc_no where clk.jcno="+jobcarddocno;

			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getSelectedTeamsData(String id,String jobcarddocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select bay.name bay,team.description from ws_jobplanteam m left join ws_teammasterm team on (m.teamdocno=team.doc_no) left join ws_bay bay on (m.baydocno=bay.doc_no) where m.jobdocno="+jobcarddocno;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
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
					String strgetzonestatus="select z"+cmbbaymovupdate+" zonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
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
					String strgetzonestatus="select z"+lastbay+" zonedata,z"+cmbbaymovupdate+" currentzonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
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
}

