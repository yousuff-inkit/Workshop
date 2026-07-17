<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String employee=request.getParameter("employee")==null?"":request.getParameter("employee");
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;
int errorstatus=0;
String errormsg="";
int actionstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	String time="";
	String strgetdatetime="select curdate() strdate,DATE_FORMAT(now(), '%H:%i') strtime";
	ResultSet rsgetdatetime=stmt.executeQuery(strgetdatetime);
	while(rsgetdatetime.next()){
		sqldate=rsgetdatetime.getDate("strdate");
		time=rsgetdatetime.getString("strtime");
	}
	String strgetjobvocno="select doc_no,voc_no from ws_jobcard where voc_no="+jobcard;
	ResultSet rsgetjobvocno=stmt.executeQuery(strgetjobvocno);
	int jobdocno=0,jobvocno=0;
	while(rsgetjobvocno.next()){
		jobdocno=rsgetjobvocno.getInt("doc_no");
		jobvocno=rsgetjobvocno.getInt("voc_no");
	}
	int tempjobcard=0;
	int tempjobcardflag=0;
	String strcheck1="select clk.startdate,clk.closedate,clk.jcno,clk.technicianid,job.voc_no from ws_clockin clk left join ws_jobcard job on clk.jcno=job.doc_no where clk.technicianid="+employee+" and  clk.closedate is null";
	System.out.println(strcheck1);
	ResultSet rscheck1=stmt.executeQuery(strcheck1);
	while(rscheck1.next()){
		tempjobcard=rscheck1.getInt("voc_no");
		tempjobcardflag++;
	}
	System.out.println(tempjobcard+"::"+tempjobcardflag+"::"+jobcard);
	if(Integer.parseInt(jobcard)!=tempjobcard && tempjobcardflag>0){
		//errorstatus=1;
		errormsg="You are In Job Card #"+tempjobcard+",Do you want to clock out and continue with current job card?";
		actionstatus=1;
	}
	System.out.println("Error Status:"+errorstatus+"::::Action Status:"+actionstatus);
	if(errorstatus==0 && actionstatus!=1){
		String strcheck2="select clk.startdate,clk.closedate,clk.starttime,clk.jcno,clk.technicianid,job.voc_no,date_format(clk.startdate,'%d.%m.%Y') strstartdate from ws_clockin clk left join ws_jobcard job on clk.jcno=job.doc_no where clk.technicianid="+employee+" and clk.jcno="+jobdocno+" and clk.startdate is not null and  clk.closedate is null";
		System.out.println(strcheck2);
		ResultSet rscheck2=stmt.executeQuery(strcheck2);
		int check2flag=0;
		while(rscheck2.next()){
			errormsg="You are going to clock out with Job Card #"+jobvocno+" and Employee #"+employee;
			check2flag++;
			actionstatus=2;
		}
		System.out.println(tempjobcard+"::"+tempjobcardflag+"::"+jobcard);
		if(check2flag==0){
			errormsg="You are going to clock in with Job Card #"+jobvocno+" and Employee #"+employee;
			actionstatus=3;
		}
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+errormsg+"::"+actionstatus);
%>