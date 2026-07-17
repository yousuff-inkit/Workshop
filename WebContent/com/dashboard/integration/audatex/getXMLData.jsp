
<%@page import="com.dashboard.integration.audatex.*" %>

<%
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String assessmentno=request.getParameter("assessmentno")==null?"":request.getParameter("assessmentno");
ClsAudattexDAO dao=new ClsAudattexDAO();
	int val=0;
	try{
		val=dao.downloadXMLData(gatedocno,assessmentno);
		if(val>0){
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
	}
	response.getWriter().write(val+"");
%>