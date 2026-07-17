<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);

	Statement stmt=conn.createStatement();
	String strsql="update ws_jobcard set partsconfirm=1 where doc_no="+jobcarddocno+";";
	int insertval=stmt.executeUpdate(strsql);
	if(insertval<=0){
		errorstatus=1;
	}
	
	String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+jobcarddocno+"','"+session.getAttribute("BRANCHID").toString()+"','BWPPR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	int loginsert=stmt.executeUpdate(strlog);
	if(loginsert<=0){
		errorstatus=1;
	}
	
	if(errorstatus==0){
		conn.commit();
		conn.close();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>