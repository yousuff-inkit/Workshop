<%@page import="com.dashboard.workshop.invoiceprocessingv3.ClsInvProcessingV3DAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
try{
	int errorstatus=0;
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	ClsInvProcessingV3DAO processdao=new ClsInvProcessingV3DAO();
	objdata=processdao.insertNonTaxData(jobdocno, invdate, branch, session, request);
	System.out.println(objdata);
	
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(objdata+"");
%>