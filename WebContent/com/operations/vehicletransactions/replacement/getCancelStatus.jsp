<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
 	Connection conn = null;
	String value=request.getParameter("id")==null?"0":request.getParameter("id");
	ClsConnection objconn=new ClsConnection();
try{
	conn= objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select cancelstatus from gl_vehreplace where doc_no="+value;
	ResultSet rs = stmt.executeQuery(strSql);
	String cancelstatus="";
	while(rs.next()) {
		cancelstatus=rs.getString("cancelstatus");		
  		} 
	stmt.close();
	response.getWriter().write(cancelstatus);
	}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
	%>