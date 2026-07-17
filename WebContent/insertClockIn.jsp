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
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	String strsql="";
	if(clocktype.equalsIgnoreCase("1")){
		strsql="insert into ws_clockin(jcno, technicianid, startdate, starttime) values("+cmbjobcard+","+cmbemployee+",'"+sqldate+"','"+time+"')";
		System.out.println(strsql);
		int value=stmt.executeUpdate(strsql);
		if(value>0){
			errormsg="Clock In Successfull";
		}
		else{
			errorstatus=1;
			errormsg="Clock In Not Successfull";
		}
	}
	else if(clocktype.equalsIgnoreCase("2")){
		strsql="update ws_clockin set closedate='"+date+"',closetime='"+time+"' where jcno="+cmbjobcard+" and technicianid="+cmbemployee+" and closedate is null";
		System.out.println(strsql);
		int value=stmt.executeUpdate(strsql);
		if(value>0){
			errormsg="Clock Out Successfull";
		}
		else{
			errorstatus=1;
			errormsg="Clock Out Not Successfull";
		}
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