
<%@page import="com.dashboard.integration.gps.*" %>

<%
	ClsGPSDAO gpsdao=new ClsGPSDAO();
	int val=0;
	try{
		val=gpsdao.downloadXMLData();
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