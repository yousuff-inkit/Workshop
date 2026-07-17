<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int rowslen=0;
	String strSql = "select coalesce(count(*)+100,0) rowslen from my_head";
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		rowslen=rs.getInt("rowslen");    
	}
	stmt.close();
	conn.close();  

	response.getWriter().print(rowslen);        
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>