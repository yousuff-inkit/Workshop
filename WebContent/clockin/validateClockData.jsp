<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String cmbjobcard=request.getParameter("cmbjobcard")==null?"":request.getParameter("cmbjobcard");
String cmbemployee=request.getParameter("cmbemployee")==null?"":request.getParameter("cmbemployee");
String clocktype=request.getParameter("clocktype")==null?"":request.getParameter("clocktype");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String time=request.getParameter("time")==null?"":request.getParameter("time");
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;
int errorstatus=0;
String errormsg="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	String strgetdatetime="select curdate() strdate,DATE_FORMAT(now(), '%H:%i') strtime";
	ResultSet rsgetdatetime=stmt.executeQuery(strgetdatetime);
	while(rsgetdatetime.next()){
		sqldate=rsgetdatetime.getDate("strdate");
		time=rsgetdatetime.getString("strtime");
	}
	int jobvocno=0,jobdocno=0;
	//Getting jobvocno
	String strjobvocno="select voc_no,doc_no from ws_jobcard where voc_no="+cmbjobcard;
	ResultSet rsjobvocno=stmt.executeQuery(strjobvocno);
	while(rsjobvocno.next()){
		jobdocno=rsjobvocno.getInt("doc_no");
		jobvocno=rsjobvocno.getInt("voc_no");
	}
	int tempjobcard=0;
	clocktype="1";
	String strcheck1="select clk.startdate,clk.closedate,clk.jcno,clk.technicianid,job.voc_no from ws_clockin clk left join ws_jobcard job on clk.jcno=job.doc_no where clk.technicianid="+cmbemployee+" and  clk.closedate is null";
	ResultSet rscheck1=stmt.executeQuery(strcheck1);
	while(rscheck1.next()){
		tempjobcard=rscheck1.getInt("voc_no");
		clocktype="2";
	}
	if((clocktype.equalsIgnoreCase("1") && tempjobcard>0) || clocktype.equalsIgnoreCase("2") && tempjobcard>0 && tempjobcard!=Integer.parseInt(cmbjobcard)){
		errorstatus=1;
		errormsg="You are In Job Card #"+tempjobcard+",Please Clock Out";
	}
	if(errorstatus==0){
		String strcheck2="select clk.startdate,clk.closedate,clk.starttime,clk.jcno,clk.technicianid,job.voc_no,date_format(clk.startdate,'%d.%m.%Y') strstartdate from ws_clockin clk left join ws_jobcard job on clk.jcno=job.doc_no where clk.technicianid="+cmbemployee+" and clk.jcno="+jobdocno+" and clk.startdate is not null and  clk.closedate is null";
		ResultSet rscheck2=stmt.executeQuery(strcheck2);
		int check2flag=0;
		while(rscheck2.next()){
			if(clocktype.equalsIgnoreCase("2")){
				errormsg="You are going to clock out having in date "+rscheck2.getString("strstartdate")+" and time "+rscheck2.getString("starttime");
			}
			check2flag++;
		}
		if(check2flag==0 && clocktype.equalsIgnoreCase("1")){
			errormsg="You are going to be IN";
		}
		if(check2flag==0 && clocktype.equalsIgnoreCase("2")){
			errorstatus=1;
			errormsg="Please clock In first";
		}
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+errormsg);
%>