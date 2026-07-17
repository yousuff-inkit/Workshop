<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%
String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
String updatestatus=request.getParameter("updatestatus")==null?"0":request.getParameter("updatestatus");
Connection conn=null;
ClsConnection ClsConnection=new ClsConnection();

try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	int status=-1;
	String strsql="update gl_vehmaster set limostatus="+updatestatus+" where fleet_no="+fleetno;
	System.out.println("SQL:"+strsql);
	int updateval=stmt.executeUpdate(strsql);
	if(updateval<=0){
		status=0;
	}
	else{
		conn.commit();
		status=1;
	}
	response.getWriter().write(status+"");
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>