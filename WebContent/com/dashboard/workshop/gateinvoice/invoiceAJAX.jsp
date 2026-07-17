<%@page import="com.dashboard.workshop.gateinvoice.ClsGateInvoiceDAO"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%
String client=request.getParameter("client")==null?"":request.getParameter("client");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String amount=request.getParameter("amount")==null?"":request.getParameter("amount");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
Connection conn=null;
int status=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsGateInvoiceDAO invoicedao=new ClsGateInvoiceDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("") && todate!=null){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	
	if(amount.equalsIgnoreCase("")){
		amount="0.0";
	}
	int val=invoicedao.gateInvoiceInsert(client,gatedocno,sqlfromdate,sqltodate,Double.parseDouble(amount)," ",session,request,conn);
	if(val>0){
		conn.commit();
		status=1;
	}
	else{
		status=0;
	}
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>