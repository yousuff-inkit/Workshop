<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();

try{
	Statement stmt = conn.createStatement ();
	String strSql = "select row_no,name from ws_gartype order by name";
	ResultSet rs = stmt.executeQuery(strSql);
	String rtype="";
	String rtypeid="";
	while(rs.next()) {
		rtype+=rs.getString("name")+",";		
		rtypeid+=rs.getString("row_no")+",";
  		} 
	if(rtype.length()>0){
		rtype=rtype.substring(0, rtype.length()-1);	
	}
	
	response.getWriter().write(rtype+"####"+rtypeid);
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
	%>
  
