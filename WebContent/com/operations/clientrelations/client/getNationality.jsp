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
		
		String strSql = "SELECT nation,doc_no FROM my_natm order by nation;";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String nation="";
		String nationid="";
		while(rs.next()) {
			nation+=rs.getString("nation")+",";		
			nationid+=rs.getString("doc_no")+",";
	  		} 
		
		nation=nation.substring(0, nation.length()>0?nation.length()-1:0);
		
		response.getWriter().write(nation+"####"+nationid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
