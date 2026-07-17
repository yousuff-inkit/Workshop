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
	String strSql = "update profitandlossanalysis set code='Main' where trim(description) in('NET PROFIT / (LOSS)','GROSS PROFIT')";
	stmt.executeUpdate(strSql);           
	stmt.close();
	conn.close();  

	response.getWriter().print(rowslen);        
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>