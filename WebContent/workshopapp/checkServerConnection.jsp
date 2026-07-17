<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
objdata.put("errorstatus",0);
response.getWriter().write(objdata+"");
%>