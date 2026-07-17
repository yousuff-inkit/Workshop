<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="";
	//Getting Tax Method
	int tax=0;
	String strtax="select method from gl_config where field_nme='tax'";
	ResultSet rstax=stmt.executeQuery(strtax);
	while(rstax.next()){
		tax=rstax.getInt("method");
	}
	stmt.close();
	response.getWriter().write(tax+"");
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>
