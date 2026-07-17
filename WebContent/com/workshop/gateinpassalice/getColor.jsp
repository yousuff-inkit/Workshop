<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = null;
 	String brand="";
	String brandid="";
try{	
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,color from my_color where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	
	while(rs.next()) {
		brand+=rs.getString("color")+",";		
		brandid+=rs.getString("doc_no")+",";
  		} 
	if(brand.length()>0){
		brand=brand.substring(0, brand.length()-1);	
	}
	stmt.close();
	conn.close();
	
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(brand+"***"+brandid);
%>
  
