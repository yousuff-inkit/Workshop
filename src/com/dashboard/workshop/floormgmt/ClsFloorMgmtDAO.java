package com.dashboard.workshop.floormgmt;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsFloorMgmtDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getSelectedTechData(String id,String jobdocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!jobdocno.trim().equalsIgnoreCase("")){
				sqltest+=" and m.jobdocno="+jobdocno;
			}
			String strsql="select tech.name techname,m.remarks,m.esthrs from ws_floortech m left join ws_technician tech on m.techdocno=tech.doc_no where m.status=3"+sqltest;
//			System.out.println(strsql);
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
	
	public JSONArray getFloorMgmtData(String id,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqltest+=" and flr.brhid="+brhid;
			}
			String strsql="select coalesce(flr.delaysms,0) delaysms,gate.doc_no gatedocno,est.doc_no estdocno,flr.totalloss,flr.brhid,br.branchname,flr.esttotal,flr.jobdate,flr.regno,flr.rowno,case when flr.z1 like '%N%' or flr.z2 like '%N%'  or flr.z3 like '%N%'  or flr.z4 like '%N%'  or flr.z5 like '%N%'"+
			" or flr.z12 like '%N%'  or flr.z6 like '%N%'  or flr.z7 like '%N%'  or flr.z8 like '%N%'  or flr.z9 like '%N%'  or flr.z10 like '%N%'  or flr.z11 like '%N%'"+
			" or flr.z14 like '%N%' or flr.z13 like '%N%' then 1 else 0 end unattendedstatus,flr.jobdocno, flr.jobvocno, flr.vehicledetails, flr.billto, flr.client refname, flr.service,  datediff(curdate(),flr.jobdate) age, flr.z1,"+
			" flr.z2, flr.z3, flr.z4, flr.z5, flr.z6, flr.z7, flr.z8, flr.z9, flr.z10, flr.z11, flr.z12, flr.z13, flr.z14, flr.priority, coalesce(flr.partsstatus,'') partsstatus, flr.partsexpdate, flr.promiseddate, flr.extdate, flr.esthrs, flr.actualhrs, flr.hrsdiff, flr.grpname, flr.estimator, flr.srvcadvisor, "+
			" flr.salesman, flr.insursurvivor, flr.referredby from ws_floormgmtdata flr left join my_brch br on flr.brhid=br.doc_no left join ws_jobcard job on flr.jobdocno=job.doc_no left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no where completestatus=0 and deliverystatus=0 "+sqltest+" order by brhid,jobvocno";
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
			String strsql="select jobvocno 'Job No',date_format(jobdate,'%d.%m.%Y') 'Job Date', vehicledetails 'Vehicle Details', billto 'Bill To', client 'Client', datediff(curdate(),jobdate) 'Age',coalesce(z1,'') 'WT1', coalesce(z2,'') 'WT2', coalesce(z3,'') 'DNT', coalesce(z4,'') 'PNT', coalesce(z5,'') 'DRY', coalesce(z6,'') 'POL', coalesce(z7,'') 'FIT', coalesce(z8,'') 'MWT', coalesce(z9,'') 'MEC', coalesce(z10,'') 'WAS', coalesce(z11,'') 'PDI', coalesce(z12,'') 'DEL', coalesce(z13,'') 'OTS', coalesce(z14,'') 'QSE', priority 'Priority', case when partsstatus=1 then 'Available' when partsstatus=3 then 'Delayed' end 'Parts Status', date_format(partsexpdate,'%d.%m.%Y') 'Parts Exp.Date', date_format(promiseddate,'%d.%m.%Y') 'Promised Date', date_format(extdate,'%d.%m.%Y') 'Extended Date', esthrs 'Estimate Hrs', actualhrs 'Actual Hrs', hrsdiff 'Hrs Diff.',round(esttotal,2) 'Est.Total',service 'Service', grpname 'Group', estimator 'Estimator', srvcadvisor 'Service Advisor', salesman 'Salesman', insursurvivor 'Insurance Survivor', referredby 'Referred By' from ws_floormgmtdata where completestatus=0  and deliverystatus=0";
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
			//System.out.println("jobcarddocno=====>>>>>"+jobcarddocno);
			String strsql="select spr.availability,spr.outqty,spr.description,spr.qty requestqty,spr.qty qty,spr.qty-spr.outqty balanceqty from ws_estm em inner JOIN  ws_estspare spr on spr.rdocno=em.doc_no inner JOIN ws_jobcard jb on (jb.refno=em.gipno and jb.reftype='gip') or (jb.refno=em.doc_no and jb.reftype='est')  where spr.qty!=0 and jb.doc_no='"+jobcarddocno+"'";
			System.out.println("sparedetails====>>>"+strsql);
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
			//add for apex jameel was not able to do movement so opened 
            engaged=0;
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
	
	
	public JSONArray getBayData(String id, String jobno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		
		try{     
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sql="select  coalesce(b.seqno,0) checked,bm.doc_no, date, code, name, jobtypeid, type jobtype,coalesce(b.seqno,bm.doc_no) seqno from ws_bay bm left join "
					+ " ws_jobtype jt on bm.jobtypeid=jt.doc_no left join ws_jobplanbay b on b.baydocno=bm.doc_no and b.jobdocno="+jobno 
					+ " where bm.status=3 order by bm.doc_no";
			System.out.println(sql);
			ResultSet rs=stmt.executeQuery(sql);
			data=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return data;
		
	}
	
	//Bay Status Update for other forms
	//In Floor Mgmt-Bay status is working through AJAX
	public int bayStatusUpdate(String jobdocno,String baydocno,String baystatus,Connection conn)throws SQLException{
		int errorstatus=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(z"+baydocno+",'') zonedata from ws_floormgmtdata where jobdocno="+jobdocno;
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
			String strupdate="update ws_floormgmtdata set z"+baydocno+"='"+newzonedata+"' where jobdocno="+jobdocno;
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval<=0){
				errorstatus=1;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			System.err.println("Bay Status Update Error");
		}
		return errorstatus;
	}
	
	
	public String updateBayMove2(String jobcarddocno,String cmbbaymovupdate,String baymovupdateindate,String baymovupdateintime,
			String baymovupdateoutdate,String baymovupdateouttime,String baymovupdateremarks,HttpServletRequest request,HttpSession session,Connection conn)throws SQLException{
			String msg="";
			int errorstatus=0;
			try{
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
					String strclockincount="select count(*) itemcount from ws_clockin where jcno="+jobcarddocno+" and bayid="+cmbbaymovupdate+" and closedate is null";
					int clockincount=0;
					ResultSet rsclockincount=stmt.executeQuery(strclockincount);
					while(rsclockincount.next()){
						clockincount=rsclockincount.getInt("itemcount");
					}
					if(clockincount==0){
						strsql="update ws_baymove set outdate='"+sqloutdate+"',outtime='"+baymovupdateouttime+"',engaged=0,outuserid="+userid+",outremarks='"+baymovupdateremarks+"' where jobcarddocno="+jobcarddocno+" and bayid="+cmbbaymovupdate;
					}
					
				}
				if(!strsql.trim().equalsIgnoreCase("")){
					System.out.println(strsql);
					int sqlupdate=stmt.executeUpdate(strsql);
					if(sqlupdate<=0){
						//Validation : Bay Movement Insert/Update Error
						msg="Bay Movement Insert/Update Error";
						errorstatus=5;
						return errorstatus+"::"+msg;
					}
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
					//conn.commit();
				}
			}
			catch(Exception e){
				e.printStackTrace();
				errorstatus=1;
			}
			finally{
				//conn.close();
			}
			return errorstatus+"::"+msg;
		}
	
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
}
