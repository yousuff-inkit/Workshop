<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%
Connection conn=null;
String mdoc=request.getParameter("mdoc")==null?"0":request.getParameter("mdoc");
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int val=stmt.executeUpdate("delete from gl_vsaletempjv");
	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
  %>