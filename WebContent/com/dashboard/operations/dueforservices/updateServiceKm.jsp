<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
int fleetno=Integer.parseInt(request.getParameter("fleetno")==null?"0":request.getParameter("fleetno"));
int servicekm=Integer.parseInt(request.getParameter("servicekm")==null?"0":request.getParameter("servicekm"));
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int updateval=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String str="update gl_vehmaster set lst_srv="+servicekm+" where fleet_no="+fleetno;
	updateval=stmt.executeUpdate(str);
	if(updateval>0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(updateval+"");
%>