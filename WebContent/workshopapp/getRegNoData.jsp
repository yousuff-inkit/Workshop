<%@page import="workshopapp.ClsWorkshopAppDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
try{
	ClsConnection objconn=new ClsConnection();
	ClsWorkshopAppDAO dao=new ClsWorkshopAppDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	objdata.put("regnodata",dao.getRegNoData(conn,brhid));
	//System.out.println("reg print"+objdata);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>