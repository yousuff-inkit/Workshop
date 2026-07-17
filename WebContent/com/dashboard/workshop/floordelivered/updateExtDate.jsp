<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String extdate=request.getParameter("extdate")==null?"":request.getParameter("extdate");
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	if(!extdate.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(extdate);
	}
	String userid=session.getAttribute("USERID").toString();
	String strinsert="insert into ws_extdatedetail(jobcarddocno, extdate, remarks, userid)values("+jobcarddocno+",'"+sqldate+"','"+remarks+"',"+userid+")";
	int insertval=stmt.executeUpdate(strinsert);
	if(insertval<=0){
		errorstatus=1;
	}
	String strupdate="update ws_floormgmtdata set extdate='"+sqldate+"' where jobdocno="+jobcarddocno;
	int updateval=stmt.executeUpdate(strupdate);
	if(updateval<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
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