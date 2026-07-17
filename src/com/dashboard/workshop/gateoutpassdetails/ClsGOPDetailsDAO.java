package com.dashboard.workshop.gateoutpassdetails;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsGOPDetailsDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getGOPMgmtData(String fromdate,String todate,String id,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		java.sql.Date sqlfromdate = null,sqltodate=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		    }else{}
		    
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		    } else{} 
			String sqltest="";
			if(!brhid.trim().equalsIgnoreCase("")){
				sqltest+=" and gip.brhid="+brhid;
			}
			String strsql="select coalesce(wsa.sal_name,'') serviceadvisor , coalesce(gip.backjob,0) backjob,trim(both ' , ' from concat(coalesce(est.claimno,''),' , ',group_concat(distinct coalesce(estadd.claimno,''),if(coalesce(estadd.claimno,'')<>'',' , ','')))) estclaimno,coalesce(gip.chkvirtual,0) chkvirtual,coalesce(insur.refname,'') insurcompname,coalesce(ac.address,'') gipclientaddress,convert(coalesce(ac.catid,''),char(25)) gipclientcat,coalesce(ac.trnnumber,'') gipclienttrn,coalesce(gip.mobile,'') gipclientmobile,coalesce(gip.email,'') gipclientemail,coalesce(lpo,'') pono,coalesce(excess,0) chkexcess,round(coalesce(excessamt,0.0),2) excessamt,coalesce(est.voc_no,0) estvocno,coalesce(job.doc_no,0) jobdocno,coalesce(job.voc_no,0) jobvocno,concat(gip.regno,' ',gip.pltid,' ',brd.brand_name,' ',model.vtype) fleetdetails,gip.brhid,case when gip.processstatus=1 then 'Gate In Pass' when gip.processstatus=2 then 'Estimation' when gip.processstatus=3 then"+
			" 'Confirm Est.' when processstatus=4 then 'Quotation Approval' when gip.processstatus=5 then 'Job Card' when gip.processstatus=6"+
			" then 'Job Card Complete' when gip.processstatus=7 then 'Invoiced' when gip.processstatus=8 then 'Gate Out Pass' when gip.processstatus=10"+
			" then 'Vehicle Release' else '' end gipprocess,gip.brhid,gip.cldocno,gip.insurcldocno,gip.voc_no vocno,coalesce(est.doc_no,0) estdocno,gip.processstatus,coalesce(gip.email,ac.mail1) email,rt.name repairtype,br.branchname,case when gip.cldocno=0 then 'New' else 'Existing' end customertype,gip.doc_no docno,gip.voc_no,gip.cldocno,coalesce(case when ac.refname='' then gip.clientname else ac.refname end,gip.clientname) refname,gip.mobile,gip.email,gip.estdeldate date,gip.estdeltime time,gip.policerep,gip.policerepdate,gip.drvlicence,gip.emiratesid,gip.colorid,gip.insutype,gip.priority,coalesce(gip.marketingperson,'') estimatorid,ms.sal_name estimator,gip.regexpirydate,gip.referencedby,ms1.sal_name referencedbyname,gip.faulttype,gip.remarks chklistremarks,wsa.sal_name referencedbyname,gip.faulttype,gip.remarks chklistremarks from"+
			" ws_gateinpass gip left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM' left join my_acbook insur on gip.insurcldocno=insur.cldocno and insur.dtype='CRM' left join my_brch br on gip.brhid=br.doc_no left join ws_gartype rt on gip.repairtype=rt.row_no left join ws_estm est on gip.doc_no=est.gipno left join ws_jobcard job on (job.refno=est.doc_no and job.reftype='EST') left join gl_vehbrand brd on brd.doc_no=gip.brdid left join"+
			" gl_vehmodel model on model.doc_no=gip.modid left join ws_estmadd estadd on est.doc_no=estadd.doc_no left join my_salesman ms on ms.doc_no=gip.marketingperson and ms.sal_type='WMP'"+
			" left join my_salesman ms1 on ms1.doc_no=gip.referencedby and ms1.sal_type='WRB'left join my_salesman wsa on (gip.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) where gip.status=3 and gip.processstatus>=8 "+sqltest+" and gip.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"  group by gip.doc_no order by gip.doc_no desc";
		//System.out.println("yyyy===="+strsql);
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
	
	/*public JSONArray getFloorMgmtDataExcel(String id) throws SQLException{
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
	}*/
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
	
	 public  JSONArray getMarketingPersonData(String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn=objconn.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	String sqldata="select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description from my_salesman "+
	            			" sal left join my_head head on (sal.acc_no=head.doc_no) where status=3 and sal_type='WMP'";
	            	
					ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					 return RESULTDATA;

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }

	 public JSONArray getReferencedByData(String id) throws SQLException {
		 JSONArray data=new JSONArray();
		 if(!id.equalsIgnoreCase("1")){
			 return data;
		 }
		 Connection conn = null;
			try {
					conn = objconn.getMyConnection();
					Statement stmtSalesAgent = conn.createStatement();
		        	
					ResultSet resultSet = stmtSalesAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.mail,m2.description "+
					" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='WRB'");
					data=objcommon.convertToJSON(resultSet);
					stmtSalesAgent.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		    return data;
		}
	
	
}
