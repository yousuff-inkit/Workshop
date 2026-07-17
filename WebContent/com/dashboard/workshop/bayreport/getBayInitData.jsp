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
	
	String str="select bay.name from gl_workbay bay where status=3";
	ResultSet rs=stmt.executeQuery(str);
	int i=0;
	String temp="";
	while(rs.next()){
		if(i==0){
			temp+=rs.getString("name");
		}
		else{
			temp+=","+rs.getString("name");
		}
		i++;
	}
	stmt.close();
	response.getWriter().write(temp);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
