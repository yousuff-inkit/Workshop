<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String employee=request.getParameter("employee")==null?"":request.getParameter("employee");
String actionstatus=request.getParameter("actionstatus")==null?"":request.getParameter("actionstatus");

ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;
int errorstatus=0;
String errormsg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	/* if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	} */
	String strtechexist="select count(*) rowcount from ws_technician where doc_no="+employee;
	int techexistcount=0;
	ResultSet rstechexist=stmt.executeQuery(strtechexist);
	while(rstechexist.next()){
		techexistcount=rstechexist.getInt("rowcount");
	}
	if(techexistcount==0){
		errorstatus=1;
		errormsg="No Employee Found";
	}
	if(errorstatus==0){
	
		String time="";
		String strgetdatetime="select curdate() strdate,DATE_FORMAT(now(), '%H:%i') strtime";
		ResultSet rsgetdatetime=stmt.executeQuery(strgetdatetime);
		while(rsgetdatetime.next()){
			sqldate=rsgetdatetime.getDate("strdate");
			time=rsgetdatetime.getString("strtime");
		}
		String strgetjobvocno="select doc_no,voc_no from ws_jobcard where doc_no="+jobcard;
		ResultSet rsgetjobvocno=stmt.executeQuery(strgetjobvocno);
		int jobdocno=0,jobvocno=0;
		while(rsgetjobvocno.next()){
			jobdocno=rsgetjobvocno.getInt("doc_no");
			jobvocno=rsgetjobvocno.getInt("voc_no");
		}
		if(actionstatus.equalsIgnoreCase("1")){
			int existjobcard=0;
			String strgetjobcard="select jcno from ws_clockin where technicianid="+employee+" and closedate is null";
			ResultSet rsgetjobcard=stmt.executeQuery(strgetjobcard);
			while(rsgetjobcard.next()){
				existjobcard=rsgetjobcard.getInt("jcno");
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
			}		
			String strinsertnew="insert into ws_clockin(jcno, technicianid, startdate, starttime) values("+jobdocno+","+employee+",'"+sqldate+"','"+time+"')";
			System.out.println(strinsertnew);
			int insertnew=stmt.executeUpdate(strinsertnew);
			if(insertnew<=0){
				errorstatus=1;
				errormsg="Couldn't create new clockin";
				System.out.println("Error While Inserting New Job");
			}
			if(errorstatus==0){
				errormsg="Clock In Successfull";
			}
		}
		else if(actionstatus.equalsIgnoreCase("2")){
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
			String strupdatefloor="update ws_floormgmtdata set actualhrs="+actualhrs+",hrsdiff="+hrsdiff+" where jobdocno="+existjobcard;
			System.out.println(strupdatefloor);
			int updatefloor=stmt.executeUpdate(strupdatefloor);
			if(updatefloor<=0){
				errorstatus=1;
				System.out.println("Update Floor Mgmt Error");
			}
			if(errorstatus==0){
				errormsg="Clock Out Successfull";
			}
		}
		else if(actionstatus.equalsIgnoreCase("3")){
			if(jobdocno==0){
				errorstatus=1;
				errormsg="Couldn't find jobcard "+jobcard;
			}
			String strnewjob="insert into ws_clockin(jcno, technicianid, startdate, starttime) values("+jobdocno+","+employee+",'"+sqldate+"','"+time+"')";
			System.out.println(strnewjob);
			int newjob=stmt.executeUpdate(strnewjob);
			if(newjob<=0){
				errorstatus=1;
				errormsg="Couldn't create new clockin";
				System.out.println("Error While Inserting Job");
			}
			if(newjob>0){
				errormsg="Clock In Successfull";
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