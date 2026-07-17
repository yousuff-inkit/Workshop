<%@page import="com.dashboard.workshop.floormgmt.ClsFloorMgmtDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String cmbbaymovupdate=request.getParameter("cmbbaymovupdate")==null?"":request.getParameter("cmbbaymovupdate");
String baymovupdateindate=request.getParameter("baymovupdateindate")==null?"":request.getParameter("baymovupdateindate");
String baymovupdateintime=request.getParameter("baymovupdateintime")==null?"":request.getParameter("baymovupdateintime");
String baymovupdateoutdate=request.getParameter("baymovupdateoutdate")==null?"":request.getParameter("baymovupdateoutdate");
String baymovupdateouttime=request.getParameter("baymovupdateouttime")==null?"":request.getParameter("baymovupdateouttime");
String baymovupdateremarks=request.getParameter("baymovupdateremarks")==null?"":request.getParameter("baymovupdateremarks");
ClsFloorMgmtDAO floordao=new ClsFloorMgmtDAO();
String strstatus=floordao.updateBayMove(jobcarddocno,cmbbaymovupdate,baymovupdateindate,baymovupdateintime,baymovupdateoutdate,baymovupdateouttime,
		baymovupdateremarks,request,session);
response.getWriter().write(strstatus);
%>