<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%

 	Connection conn =null;
	ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select st_desc,status from gl_status where rep=1";
	ResultSet rs = stmt.executeQuery(strSql);
	String desc="";
	String id="";
	while(rs.next()) {
		desc+=rs.getString("st_desc")+",";		
		id+=rs.getString("status")+",";
  		} 
	desc=desc.substring(0, desc.length()-1);
	stmt.close();
	conn.close();

	response.getWriter().write(desc+"***"+id);
	System.out.println("Status:"+desc+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>