<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = null;
 	try{
 		conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,branchname from my_brch where status<>7";
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String branch="";
	String brhid="";
	while(rs.next()) {
		branch+=rs.getString("branchname")+",";		
		brhid+=rs.getString("doc_no")+",";
  		} 
	 if(branch.length()>0){
		branch=branch.substring(0, branch.length()-1);	
	} 
	
	stmt.close();

	response.getWriter().write(branch+"***"+brhid);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	
 	}
 	finally{
 		conn.close();
 	}
	%>
  
