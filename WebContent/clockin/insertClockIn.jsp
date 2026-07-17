<%@page import="com.dashboard.workshop.floormgmt.ClsFloorMgmtDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String employee=request.getParameter("employee")==null?"":request.getParameter("employee");
String actionstatus=request.getParameter("actionstatus")==null?"":request.getParameter("actionstatus");
String baydocno=request.getParameter("baydocno")==null?"":request.getParameter("baydocno");
String bayconfig=request.getParameter("bayconfig")==null?"":request.getParameter("bayconfig");
// bayconfig="0";
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
ClsFloorMgmtDAO floordao=new ClsFloorMgmtDAO();
Connection conn=null;
int errorstatus=0;
String errormsg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	String strdate="";
	String baycode="",bayname="";
	/* if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	} */
	if(baydocno.equalsIgnoreCase("")){
		baydocno="0";
	}
	System.out.println("Job No Recieved:"+jobcard);
	System.out.println("Action Status:"+actionstatus);
	String strtechexist="select count(*) rowcount from ws_technician where doc_no="+employee;
	int techexistcount=0;
	ResultSet rstechexist=stmt.executeQuery(strtechexist);
	while(rstechexist.next()){
		techexistcount=rstechexist.getInt("rowcount");
	}
	if(techexistcount==0){
		errorstatus=1;
		errormsg="No Employee Found";
		System.out.println(errormsg);
	}
	if(errorstatus==0){
	
		String time="";
		String strgetdatetime="select date_format(curdate(),'%d.%m.%Y') strformatteddate,curdate() strdate,DATE_FORMAT(now(), '%H:%i') strtime";
		ResultSet rsgetdatetime=stmt.executeQuery(strgetdatetime);
		while(rsgetdatetime.next()){
			sqldate=rsgetdatetime.getDate("strdate");
			time=rsgetdatetime.getString("strtime");
			strdate=rsgetdatetime.getString("strformatteddate");
		}
		String strgetjobvocno="select doc_no,voc_no from ws_jobcard where voc_no="+jobcard;
		ResultSet rsgetjobvocno=stmt.executeQuery(strgetjobvocno);
		int jobdocno=0,jobvocno=0;
		while(rsgetjobvocno.next()){
			jobdocno=rsgetjobvocno.getInt("doc_no");
			jobvocno=rsgetjobvocno.getInt("voc_no");
		}
		if(bayconfig.trim().equalsIgnoreCase("1")){
			String strgetbayname="select code,name from ws_bay where doc_no="+baydocno;
			ResultSet rsgetbayname=stmt.executeQuery(strgetbayname);
			while(rsgetbayname.next()){
				baycode=rsgetbayname.getString("code");
				bayname=rsgetbayname.getString("name");
			}
		}
		if(actionstatus.equalsIgnoreCase("1")){
			//Existing Job Card-clockout and continue with new jobcard
			int existjobcard=0;
			String existjobcardvocno="";
			String existbaydocno="",existbaycode="";
			String strgetjobcard="select jcno from ws_clockin where technicianid="+employee+" and closedate is null";
			ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
			while(rsgetjobcard.next()){
				existjobcard=rsgetjobcard.getInt("jcno");
			}
			if(existjobcard>0){
				String strexistjobcardvocno="select voc_no from ws_jobcard where doc_no="+existjobcard;
				ResultSet rsgetexistjobcardvocno=stmt.executeQuery(strexistjobcardvocno);
				while(rsgetexistjobcardvocno.next()){
					existjobcardvocno=rsgetexistjobcardvocno.getString("voc_no");
				}
				String strexistbay="select bay.doc_no existbaydocno,bay.code existbaycode from ws_baymove baymov left join ws_bay bay on baymov.bayid=bay.doc_no where jobcarddocno="+existjobcard;
				ResultSet rsgetexistbay=stmt.executeQuery(strexistbay);
				while(rsgetexistbay.next()){
					existbaydocno=rsgetexistbay.getString("existbaydocno");
					existbaycode=rsgetexistbay.getString("existbaycode");
				}
			}
			String strupdateexist="update ws_clockin set closedate='"+sqldate+"',closetime='"+time+"' where technicianid="+employee+" and closedate is null";
			System.out.println(strupdateexist);
			int updateexist=stmt.executeUpdate(strupdateexist);
			if(updateexist<=0){
				errorstatus=1;
				errormsg="Couldn't close existing clockin";
				System.out.println("Error While Updating Existing Job");
			}
			
			String strgetlabhrs="select sum(lab.hrs) labhrs from ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST') left "+
			" join ws_estlabour lab on es.doc_no=lab.rdocno where jc.doc_no="+existjobcard+" group by jc.doc_no";
			ResultSet rsgetlabhrs=stmt.executeQuery(strgetlabhrs);
			double labhrs=0.0;
			while(rsgetlabhrs.next()){
				labhrs=rsgetlabhrs.getDouble("labhrs");
			}
			String strgetsumclock="select sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),cast(concat(clk.closedate,' ',clk.closetime)as"+
					" datetime))/60)) actualhrs,sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),"+
							" cast(concat(clk.closedate,' ',clk.closetime)as datetime))/60))-"+labhrs+" hrsdiff from ws_clockin clk where jcno="+existjobcard;
			ResultSet rsgetsumclock=stmt.executeQuery(strgetsumclock);
			double actualhrs=0.0,hrsdiff=0.0;
			while(rsgetsumclock.next()){
				actualhrs=rsgetsumclock.getDouble("actualhrs");
				hrsdiff=rsgetsumclock.getDouble("hrsdiff");
			}
			if(bayconfig.trim().equalsIgnoreCase("1")){
				//Updating bay movemnet entry
				String remarks="Moved to Bay "+existbaycode+" of Job Card "+existjobcardvocno;
				String strstatus=floordao.updateBayMove2(existjobcard+"",existbaydocno,strdate,time,strdate,time,remarks,request,session,conn);
				System.out.println(strstatus);
				if(!strstatus.trim().split("::")[0].equalsIgnoreCase("0")){
					errorstatus=1;
					errormsg=strstatus.trim().split("::")[1];
					System.out.println("Bay Move Error:"+errormsg);
				}
				int baystatusupdate=floordao.bayStatusUpdate(existjobcard+"", existbaydocno, "C", conn);
				if(baystatusupdate==1){
					errorstatus=1;
					errormsg="Couldn't create new clockin";
					System.out.println("Bay Status Update Error");
				}
			}
			String strupdatefloor="update ws_floormgmtdata set actualhrs="+actualhrs+",hrsdiff="+hrsdiff+" where jobdocno="+existjobcard;
			System.out.println(strupdatefloor);
			int updatefloor=stmt.executeUpdate(strupdatefloor);
			if(updatefloor<=0){
				errorstatus=1;
				System.out.println("Update Floor Mgmt Error");
			} 
			if(jobdocno==0){
				errorstatus=1;
				errormsg="Couldn't find jobcard "+jobcard;
				System.out.println(errormsg);
			}		
			String strinsertnew="insert into ws_clockin(date,jcno, technicianid, startdate, starttime,bayid) values(CURDATE(),"+jobdocno+","+employee+",'"+sqldate+"','"+time+"',"+baydocno+")";
			System.out.println(strinsertnew);
			int insertnew=stmt.executeUpdate(strinsertnew);
			if(insertnew<=0){
				errorstatus=1;
				errormsg="Couldn't create new clockin";
				System.out.println("Error While Inserting New Job");
			}
			if(errorstatus==0){
				errormsg="Clock In Successfull";
				System.out.println(errormsg);
			}
			if(bayconfig.trim().equalsIgnoreCase("1")){
				//Updating bay movemnet entry
				String remarks="Moved to Bay "+baycode+" of Job Card "+jobvocno;
				String strstatus=floordao.updateBayMove2(jobdocno+"",baydocno,strdate,time,strdate,time,remarks,request,session,conn);
				System.out.println(strstatus);
				if(!strstatus.trim().split("::")[0].equalsIgnoreCase("0")){
					errorstatus=1;
					errormsg=strstatus.trim().split("::")[1];
					System.out.println("Bay Move Update Error:"+errormsg);
				}
				int baystatusupdate=floordao.bayStatusUpdate(jobdocno+"", baydocno, "S", conn);
				if(baystatusupdate==1){
					errorstatus=1;
					errormsg="Couldn't create new clockin";
					System.out.println("Bay Status Update Error");
				}
			}
		}
		else if(actionstatus.equalsIgnoreCase("2")){
			//Clockout
			int existjobcard=0;
			String strgetjobcard="select jcno from ws_clockin where technicianid="+employee+" and closedate is null";
			ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
			while(rsgetjobcard.next()){
				existjobcard=rsgetjobcard.getInt("jcno");
			}
			String strclosejob="update ws_clockin set closedate='"+sqldate+"',closetime='"+time+"' where jcno="+jobdocno+" and technicianid="+employee+" and closedate is null";
			System.out.println(strclosejob);
			int closejob=stmt.executeUpdate(strclosejob);
			if(closejob<=0){
				errorstatus=1;
				errormsg="Couldn't close existing clockin";
				System.out.println("Error While Closing Job");
			}
			
			String strgetlabhrs="select sum(lab.hrs) labhrs from ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST') left "+
			" join ws_estlabour lab on es.doc_no=lab.rdocno where jc.doc_no="+existjobcard+" group by jc.doc_no";
			ResultSet rsgetlabhrs=stmt.executeQuery(strgetlabhrs);
			double labhrs=0.0;
			while(rsgetlabhrs.next()){
				labhrs=rsgetlabhrs.getDouble("labhrs");
			}
			String strgetsumclock="select sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),cast(concat(clk.closedate,' ',clk.closetime)as"+
				" datetime))/60)) actualhrs,sum((TIMESTAMPDIFF(minute,cast(concat(clk.startdate,' ',clk.starttime)as datetime),"+
				" cast(concat(clk.closedate,' ',clk.closetime)as datetime))/60))-"+labhrs+" hrsdiff from ws_clockin clk where jcno="+existjobcard;
			ResultSet rsgetsumclock=stmt.executeQuery(strgetsumclock);
			double actualhrs=0.0,hrsdiff=0.0;
			while(rsgetsumclock.next()){
				actualhrs=rsgetsumclock.getDouble("actualhrs");
				hrsdiff=rsgetsumclock.getDouble("hrsdiff");
			}
			
			if(bayconfig.trim().equalsIgnoreCase("1")){
				//Updating bay movemnet entry
				String remarks="Moved to Bay "+baycode+" of Job Card "+jobvocno;
				String strstatus=floordao.updateBayMove2(jobdocno+"",baydocno,strdate,time,strdate,time,remarks,request,session,conn);
				if(!strstatus.trim().split("::")[0].equalsIgnoreCase("0")){
					errorstatus=1;
					errormsg=strstatus.trim().split("::")[1];
					System.out.println("Bay Move Update Error:"+errormsg);
				}
				int baystatusupdate=floordao.bayStatusUpdate(jobdocno+"", baydocno, "C", conn);
				if(baystatusupdate==1){
					errorstatus=1;
					errormsg="Couldn't create new clockin";
					System.out.println("Bay Status Update Error");
				}
			}
			
			String strupdatefloor="update ws_floormgmtdata set actualhrs="+actualhrs+",hrsdiff="+hrsdiff+" where jobdocno="+existjobcard;
			System.out.println(strupdatefloor);
			int updatefloor=stmt.executeUpdate(strupdatefloor);
			if(updatefloor<=0){
				errorstatus=1;
				System.out.println("Update Floor Mgmt Error");
			}
			if(errorstatus==0){
				errormsg="Clock Out Successfull";
				System.out.println(errormsg);
			}
		}
		else if(actionstatus.equalsIgnoreCase("3")){
			//clock in
			if(jobdocno==0){
				errorstatus=1;
				errormsg="Couldn't find jobcard "+jobcard;
				System.out.println(errormsg);
			}
			String strnewjob="insert into ws_clockin(date,jcno, technicianid, startdate, starttime,bayid) values(CURDATE(),"+jobdocno+","+employee+",'"+sqldate+"','"+time+"',"+baydocno+")";
			System.out.println(strnewjob);
			int newjob=stmt.executeUpdate(strnewjob);
			if(newjob<=0){
				errorstatus=1;
				errormsg="Couldn't create new clockin";
				System.out.println("Error While Inserting Job");
			}
			
			System.out.println("Bay Config:"+bayconfig);
			if(newjob>0){
				errormsg="Clock In Successfull";
				System.out.println(errormsg);	
				if(bayconfig.trim().equalsIgnoreCase("1")){
					//Updating bay movemnet entry
					String remarks="Moved to Bay "+baycode+" of Job Card "+jobvocno;
					String strstatus=floordao.updateBayMove2(jobdocno+"",baydocno,strdate,time,strdate,time,remarks,request,session,conn);
					System.out.println(strstatus);
					if(!strstatus.trim().split("::")[0].equalsIgnoreCase("0")){
						errorstatus=1;
						errormsg=strstatus.trim().split("::")[1];
						System.out.println("Bay Move Error:"+errormsg);
					}
					int baystatusupdate=floordao.bayStatusUpdate(jobdocno+"", baydocno, "S", conn);
					if(baystatusupdate==1){
						errorstatus=1;
						errormsg="Couldn't create new clockin";
						System.out.println("Bay Status Update Error");
					}
				}
			}
		}
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	errormsg="Not Saved";
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+errormsg);
%>