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
		
		String strSql = "select desc1,doc_no from my_cltax where status=3 order by doc_no";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String tax="";
		String taxid="";
		while(rs.next()) {
			tax+=rs.getString("desc1")+",";		
			taxid+=rs.getString("doc_no")+",";
	  		} 
		
		tax=tax.substring(0, tax.length()>0?tax.length()-1:0);
		
		response.getWriter().write(tax+"####"+taxid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
