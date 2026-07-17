<%@page import="workshopapp.ClsWorkshopAppDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String brandid=request.getParameter("brandid")==null?"":request.getParameter("brandid").toString();
try{
	ClsConnection objconn=new ClsConnection();
	ClsWorkshopAppDAO dao=new ClsWorkshopAppDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	objdata.put("modeldata",dao.getModelData(conn,brandid));	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>