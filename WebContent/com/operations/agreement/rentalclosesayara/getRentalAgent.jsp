<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
System.out.println("hererentalagent");
 	Connection conn = null;
 	ClsConnection objconn=new ClsConnection();
 	try{
 		conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,sal_name from my_salesman where status<>7 and sal_type='RLA'";
	ResultSet rs = stmt.executeQuery(strSql);
	String rental="";
	String id="";
	while(rs.next()) {
		rental+=rs.getString("sal_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	rental=rental.substring(0, rental.length()-1);
	stmt.close();
	conn.close();

	response.getWriter().write(rental+"***"+id);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		conn.close();
 	}
	%>
  
