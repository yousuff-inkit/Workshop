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
		
		String strSql = "select desc1,doc_no from my_language where status=3 order by doc_no";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String language="";
		String languageid="";
		while(rs.next()) {
			language+=rs.getString("desc1")+",";		
			languageid+=rs.getString("doc_no")+",";
	  		} 
		
		language=language.substring(0, language.length()>0?language.length()-1:0);
		
		response.getWriter().write(language+"####"+languageid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
