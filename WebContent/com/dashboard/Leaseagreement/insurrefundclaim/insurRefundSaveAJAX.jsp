<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>