<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String virtual=request.getParameter("virtual")==null?"0":request.getParameter("virtual");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int errorstatus=0;
JSONObject objdata=new JSONObject();
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	
	String strsql="update ws_gateinpass set chkvirtual="+virtual+" where doc_no="+docno;
	int insert=stmt.executeUpdate(strsql);
	if(insert<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>