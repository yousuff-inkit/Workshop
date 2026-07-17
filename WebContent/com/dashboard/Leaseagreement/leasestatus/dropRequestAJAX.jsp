<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
System.out.println("inside");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String reqsrno=request.getParameter("reqsrno")==null?"":request.getParameter("reqsrno");
String reqdocno=request.getParameter("reqdocno")==null?"":request.getParameter("reqdocno");
String reason=request.getParameter("reason")==null?"":request.getParameter("reason");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String userid=session.getAttribute("USERID").toString();
int status=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	conn.setAutoCommit(false);
	String strupdatedrop="update gl_lprd set dropstatus=1,masterstatus=4 where rdocno="+reqdocno+" and sr_no="+reqsrno;
	System.out.println(strupdatedrop);
	int val=stmt.executeUpdate(strupdatedrop);
	if(val>0){
		String strinsert="insert into gl_leasestatusdrop(date,leasereqdocno,leasereqsrno,reason,brhid,userid)values(CURDATE(),"+reqdocno+","+reqsrno+",'"+reason+"',"+branch+","+userid+")";
		int insertval=stmt.executeUpdate(strinsert);
		if(insertval>0){
			conn.commit();
			status=1;
		}
		else{
			status=0;
		}
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