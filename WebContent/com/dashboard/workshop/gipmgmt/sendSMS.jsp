
<%@page import="com.sms.SmsAction"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String smstext=request.getParameter("smstext")==null?"":request.getParameter("smstext");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	SmsAction smsaction=new SmsAction();
	int errorstatus=0;
	String action=smsaction.doSendSmsBasic(mobile, clientname, smstext, gatedocno, "GIPMGMT", brhid, conn);
	if(action.equalsIgnoreCase("success")){
		
		String strupdate="update ws_gateinpass set gipmgmtsms=1 where doc_no="+gatedocno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
		if(errorstatus==0){
			conn.commit();	
		}
		
	}
	else{
		errorstatus=1;
	}
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(!conn.isClosed()){
		conn.close();	
	}
	
}
response.getWriter().write(objdata+"");
%>
