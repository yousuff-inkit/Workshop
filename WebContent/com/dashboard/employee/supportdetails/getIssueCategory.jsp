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
		
		String strSql = "select type,doc_no from gw_issuecategory where status=1";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String type="";
		String typeid="";
		while(rs.next()) {
			type+=rs.getString("type")+",";		
			typeid+=rs.getString("doc_no")+",";
	  		} 
		
		type=type.substring(0, type.length()>0?type.length()-1:0);
		
		response.getWriter().write(type+"####"+typeid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
