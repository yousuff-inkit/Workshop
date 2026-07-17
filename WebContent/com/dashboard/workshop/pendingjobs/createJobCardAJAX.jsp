<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gipno=request.getParameter("gipno")==null?"":request.getParameter("gipno");
Connection conn=null;
String status="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select count(*) count from ws_jobcard job left join ws_estm est on (job.refno=est.doc_no and job.reftype='EST') left join"+
	" ws_gateinpass gate on (est.gipno=gate.doc_no) where gate.doc_no="+gipno+" and gate.status<>7";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		status=rs.getString("count");
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(status);
%>