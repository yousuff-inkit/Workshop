<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = null;
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select doc_no,branchname from my_brch where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String branch="";
		String branchid="";
		while(rs.next()) {
			branch+=rs.getString("branchname")+",";  		
			branchid+=rs.getString("doc_no")+",";
	  		} 
		
		branch=branch.substring(0, branch.length()>0?branch.length()-1:0);
		
		response.getWriter().write(branch+"####"+branchid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
	finally{
		conn.close();
	}
  %>
  
