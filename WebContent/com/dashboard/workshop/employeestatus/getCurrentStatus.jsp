<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select availability from gw_empavailability where status=3 and userid='"+session.getAttribute("USERID").toString()+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String availability="0";
		while(rs.next()) {
			availability=rs.getString("availability");
		} 
		
		response.getWriter().write(availability);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  