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
		
		String strSql = "select method,round(coalesce(value,0),0) value from gl_config where field_nme='crmInvoicingMethod'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String method="",value="";
		while(rs.next()) {
			method=rs.getString("method");
			value=rs.getString("value");
		} 
		
		if(method.equalsIgnoreCase("0")) {
			value="";
		}
		
		response.getWriter().write(value);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  