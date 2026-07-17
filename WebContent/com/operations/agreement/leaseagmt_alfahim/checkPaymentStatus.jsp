<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
Connection conn=null;
int status=0;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();

try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select if(pyttotalrent is null,1,0) status from gl_lagmt where status=3 and clstatus=0 and doc_no="+docno+" and brhid="+brhid;
	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		status=rs.getInt("status");
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>