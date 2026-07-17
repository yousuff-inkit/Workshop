<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsHRDashboardDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsHRDashboardDAO hrdao=new ClsHRDashboardDAO();
JSONArray deptdata=new JSONArray();
JSONArray desigdata=new JSONArray();
try{
	deptdata=hrdao.getInitDeptData(request,session);
	desigdata=hrdao.getInitDesigData(request,session);
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(deptdata+"::"+desigdata);
%>