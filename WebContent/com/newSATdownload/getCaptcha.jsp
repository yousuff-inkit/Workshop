<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@ page import="java.io.*"%>


<%	
   ClsConnection connobj=new  ClsConnection();
 	Connection conn = connobj.getMyConnection();
	Statement stmt = conn.createStatement ();
	//String strSql = "select captchaPath from gl_webid where username='"+uname+"'";
	String strSql = "select captchapath from my_comp";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String  path="";
	byte[ ] imgData =null;
	while(rs.next()) {
		path=rs.getString("captchapath");
		//imgData = path.getBytes(1,(int)path.length());
  		} 
	//System.out.println("--path-----path----"+path);
		response.getWriter().print(path);
	
		stmt.close();
		conn.close();
  %>
  
