<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
String status=request.getParameter("status")==null?"":request.getParameter("status");
System.out.println("Status:"+status);
Connection conn=null;
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="";
	int method=0;
	double value=0.0;
	if(status.equalsIgnoreCase("close")){
		strsql="select method,value from gl_config where field_nme='Lease Prior closing'";
	}
	else if(status.equalsIgnoreCase("create")){
		strsql="select method,value from gl_config where field_nme='Lease Prior opening'";
	}
	if(!strsql.equalsIgnoreCase("")){
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			method=rs.getInt("method");
			value=rs.getDouble("value");
		}
	}
	
	stmt.close();
	response.getWriter().write(method+"***"+value);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>
