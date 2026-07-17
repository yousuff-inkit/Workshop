<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String categoryId=request.getParameter("categoryId");
		
		String strSql = "select round(per_salikrate,2) salikrate,round(per_trafficharge,2) trafficrate from my_clcatm where status<>7 and dtype='CRM' and doc_no="+categoryId+"";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String salikrate="";
		String trafficrate="";
		while(rs.next()) {
			salikrate=rs.getString("salikrate");
			trafficrate=rs.getString("trafficrate");
	  	} 
		
		response.getWriter().write(salikrate+"####"+trafficrate);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
