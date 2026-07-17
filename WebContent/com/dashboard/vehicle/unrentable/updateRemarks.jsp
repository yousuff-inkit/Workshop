<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String movdocno=request.getParameter("movdocno")==null?"":request.getParameter("movdocno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String status="0";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="select movdocno from gl_unrentable where movdocno="+movdocno;
	ResultSet rscheck=stmt.executeQuery(strsql);
	int movdocnotemp=0;
	while(rscheck.next()){
		movdocnotemp=rscheck.getInt("movdocno");
	}
	String strinsert="";
	if(movdocnotemp==0){
		strinsert="insert into gl_unrentable(movdocno,fleetno,remarks)values("+movdocno+","+fleetno+",'"+remarks+"')";
	}
	else{
		strinsert="update gl_unrentable set remarks='"+remarks+"' where movdocno="+movdocno+"";
	}
	int updateval=stmt.executeUpdate(strinsert);
	if(updateval>=0){
		status="1";
		conn.commit();
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status);
%>