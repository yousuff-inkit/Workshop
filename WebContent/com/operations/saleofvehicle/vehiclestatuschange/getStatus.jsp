<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
System.out.println("herestatusagent");
ClsConnection objconn=new ClsConnection();
 	Connection conn = objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select status,st_desc from gl_status where statu=1";
	ResultSet rs = stmt.executeQuery(strSql);
	String status="";
	String id="";
	while(rs.next()) {
		status+=rs.getString("st_desc")+",";		
		id+=rs.getString("status")+",";
  		} 
	status=status.substring(0, status.length()-1);
	response.getWriter().write(status+"***"+id);
	stmt.close();
	conn.close();
	%>
  
