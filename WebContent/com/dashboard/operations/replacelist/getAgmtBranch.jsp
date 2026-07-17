<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();


 	Connection conn = null;
	try{
		conn=ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		ResultSet rsbranch=stmt.executeQuery("select doc_no,branchname from my_brch where status<>7");
		String branch="";
		String branchid="";
		while(rsbranch.next()){
			branchid+=rsbranch.getString("doc_no")+",";
			branch+=rsbranch.getString("branchname")+",";
		}
		if(branch.length()>0){
			branch=branch.substring(0, branch.length()-1);
			}
		stmt.close();
		response.getWriter().write(branchid+"###"+branch);
		}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>