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
		
		String strSql = "select concat(upper(comp_code)) company,doc_no from gw_complist where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String company="";
		String companyid="";
		while(rs.next()) {
			company+=rs.getString("company")+",";		
			companyid+=rs.getString("doc_no")+",";
	  		} 
		
		company=company.substring(0, company.length()>0?company.length()-1:0);
		
		response.getWriter().write(company+"####"+companyid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
