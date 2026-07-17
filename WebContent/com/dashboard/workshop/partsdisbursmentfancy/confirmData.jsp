<%@page import="java.util.ArrayList"%>
<%@page import="com.finance.transactions.contratrans.ClsContraTransDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String amount=request.getParameter("amount")==null?"":request.getParameter("amount");
String rows=request.getParameter("rows")==null?"":request.getParameter("rows");
int errorstatus=0;
String errormsg="";
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	String strgetjobdetails="select brhid,voc_no from ws_jobcard where doc_no="+jobdocno;
	ResultSet rsjobdetails=stmt.executeQuery(strgetjobdetails);
	String branch="";
	String jobvocno="";
	while(rsjobdetails.next()){
		branch=rsjobdetails.getString("brhid");
		jobvocno=rsjobdetails.getString("voc_no");
	}
	String userid=session.getAttribute("USERID").toString();
	String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+jobdocno+"','"+branch+"','BCPO',now(),'"+userid+"','A')";
	int datalog= stmt.executeUpdate(strlog);
	if(datalog<=0){
		conn.close();
		errorstatus=1;
		errormsg="Not Confirmed";
	}
	String strupdatespare="update ws_estspare set disbursconfirmstatus=1 where rowno in ("+rows+")";
	int updatespare=stmt.executeUpdate(strupdatespare);
	if(updatespare<=0){
		errorstatus=1;
		errormsg="Not Confirmed";
	}
	if(errorstatus==0){
		conn.commit();
		errormsg="Confirmed Successfully";
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	errormsg="Not Confirmed";
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+errormsg);
/*  */
%>