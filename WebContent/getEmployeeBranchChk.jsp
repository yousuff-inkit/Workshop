<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select coalesce(method,0) method from gl_config where field_nme='EmployeeBranchCheck'";  
		ResultSet rs = stmt.executeQuery(strSql);
		
		String method="0";  
		while(rs.next()) {
			method=rs.getString("method");
				} 
		response.getWriter().write(method);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  