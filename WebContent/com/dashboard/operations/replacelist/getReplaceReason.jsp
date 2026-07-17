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
		ResultSet rsbranch=stmt.executeQuery("select status,st_desc from gl_status where rep=1");
		String replace="";
		String replaceid="";
		while(rsbranch.next()){
			replaceid+=rsbranch.getString("status")+",";
			replace+=rsbranch.getString("st_desc")+",";
		}
		if(replace.length()>0){
			replace=replace.substring(0, replace.length()-1);
			}
		stmt.close();
		response.getWriter().write(replaceid+"###"+replace);
		}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>