<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;
String result="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="select (select count(*) from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno where lab.confirmed=0 and job.doc_no="+jobcarddocno+" group by lab.rdocno) pendingconfirm,"+
	" (select count(*) from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno where lab.approved=0 and job.doc_no="+jobcarddocno+" group by lab.rdocno) pendingapproval";
	ResultSet rs=stmt.executeQuery(strsql);
	int pendingconfirm=0,pendingapproval=0;
	while(rs.next()){
		pendingconfirm=rs.getInt("pendingconfirm");
		pendingapproval=rs.getInt("pendingapproval");
	}
	
	result=pendingconfirm+"::"+pendingapproval;
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>