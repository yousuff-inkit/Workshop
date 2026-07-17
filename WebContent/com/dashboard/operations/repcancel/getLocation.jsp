<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
ClsConnection ClsConnection=new ClsConnection();

	String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
 	Connection conn = null;
 	try{
 		conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,loc_name from my_locm where status<>7 and brhid="+branch;
	ResultSet rs = stmt.executeQuery(strSql);
	String loc="";
	String locid="";
	while(rs.next()) {
		loc+=rs.getString("loc_name")+",";		
		locid+=rs.getString("doc_no")+",";
  		} 
	if(loc.length()>0){
		loc=loc.substring(0, loc.length()-1);	
	}
	
	stmt.close();

	response.getWriter().write(loc+"***"+locid);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	
 	}
 	finally{
 		conn.close();
 	}
	%>
  
