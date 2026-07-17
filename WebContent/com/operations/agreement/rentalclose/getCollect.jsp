<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@page import="com.common.*"%>

<%	
System.out.println("Here");
 	Connection conn =null;
 	ClsConnection objconn=new ClsConnection();
 	try{
 		conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();

	JSONArray jsonArray = new JSONArray();
	 String strSql = "select doc_no,sal_name,lic_no,lic_exp_dt from my_salesman where sal_type='DRV' and status<>7";
	
	 System.out.println(strSql);
	ResultSet resultSet = stmt.executeQuery(strSql);

	stmt.close();
	conn.close();
	System.out.println(jsonArray);
	response.getWriter().write(jsonArray.toString());
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		conn.close();
 	}
	%>