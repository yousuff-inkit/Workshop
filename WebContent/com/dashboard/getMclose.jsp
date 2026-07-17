<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	java.sql.Date mclosedate=null;
String branch=request.getParameter("branch")==null || request.getParameter("branch").equalsIgnoreCase("")?"0":request.getParameter("branch");
ClsConnection ClsConnection=new ClsConnection();	
Connection conn = null;
	try{
		conn=ClsConnection.getMyConnection();
	
	Statement stmt = conn.createStatement ();
	String strSql = "select mclose from my_brch where doc_no="+branch;
	ResultSet rs = stmt.executeQuery(strSql);
	while(rs.next()) {
			mclosedate=rs.getDate("mclose");
			} 
	stmt.close();
	conn.close();
	response.getWriter().write(mclosedate+"");
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
		
	}
	finally{
		conn.close();
	}
	
  %>
  