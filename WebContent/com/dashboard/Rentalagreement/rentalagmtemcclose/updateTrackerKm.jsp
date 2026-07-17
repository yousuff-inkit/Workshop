
<%@page import="com.dashboard.integration.gps.*" %>

<%
	ClsGPSDAO gpsdao=new ClsGPSDAO();
	int val=0;
	boolean status=false;
	try{
		val=gpsdao.downloadXMLData();
		if(val>0){
			status=gpsdao.updateKm(val+"");
		}
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
	}
	response.getWriter().write(val+"");
%>