<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int status=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select leaseappstatus from gl_leasecalcm where doc_no="+docno;
	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		status=rs.getInt("leaseappstatus");
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