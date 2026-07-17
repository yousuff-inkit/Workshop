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
		
		String strSql = "select doc_no,salutation from my_clsalutn where status<>7";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String salutn="";
		String salutnid="";
		while(rs.next()) {
			salutn+=rs.getString("salutation")+",";	
			salutnid+=rs.getString("doc_no")+",";
	  		} 
		
		salutn=salutn.substring(0, salutn.length()>0?salutn.length()-1:0);
		
		response.getWriter().write(salutn+"####"+salutnid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
