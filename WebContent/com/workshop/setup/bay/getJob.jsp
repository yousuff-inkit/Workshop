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
		
		String strSql = "select doc_no,type from ws_jobtype where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String job="";
		String jobid="";
		while(rs.next()) {
			job+=rs.getString("type")+",";		
			jobid+=rs.getString("doc_no")+",";
	  		} 
		
		job=job.substring(0, job.length()>0?job.length()-1:0);
		
		response.getWriter().write(job+"####"+jobid);
		
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
  
