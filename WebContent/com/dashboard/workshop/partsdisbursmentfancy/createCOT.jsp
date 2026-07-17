<%@page import="java.util.ArrayList"%>
<%@page import="com.finance.transactions.contratrans.ClsContraTransDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String amount=request.getParameter("amount")==null?"":request.getParameter("amount");
String fromacno=request.getParameter("fromacno")==null?"":request.getParameter("fromacno");
String toacno=request.getParameter("toacno")==null?"":request.getParameter("toacno");
String rows=request.getParameter("rows")==null?"":request.getParameter("rows");
int errorstatus=0;
String errormsg="";
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();

ClsContraTransDAO contradao=new ClsContraTransDAO();
java.sql.Date contradate=null;
String fromden="",toden="";
String fromcurrency="",tocurrency="";
double fromcurrate=0.0,tocurrate=0.0;
String fromtype="",totype="";
String strgetjobdetails="select brhid,voc_no from ws_jobcard where doc_no="+jobdocno;
ResultSet rsjobdetails=stmt.executeQuery(strgetjobdetails);
String branch="";
String jobvocno="";
while(rsjobdetails.next()){
	branch=rsjobdetails.getString("brhid");
	jobvocno=rsjobdetails.getString("voc_no");
}
String strgetfromacnodetails="select curdate() contradate,den,curid,rate from my_head where doc_no="+fromacno;
ResultSet rsfromacno=stmt.executeQuery(strgetfromacnodetails);
while(rsfromacno.next()){
	contradate=rsfromacno.getDate("contradate");
	fromden=rsfromacno.getString("den");
	fromcurrency=rsfromacno.getString("curid");
	fromcurrate=rsfromacno.getDouble("rate");
}
String strgettoacnodetails="select den,curid,rate from my_head where doc_no="+toacno;
ResultSet rstoacno=stmt.executeQuery(strgettoacnodetails);
while(rstoacno.next()){
	toden=rstoacno.getString("den");
	tocurrency=rstoacno.getString("curid");
	tocurrate=rstoacno.getDouble("rate");
}
//604,305
if(fromden.equalsIgnoreCase("604")){
	fromtype="CASH";
}
else{
	fromtype="BANK";
}
totype="CASH";
String desc="Passed from Parts Disbursment for Job Card "+jobvocno;
/*Cash Payment Saving*/
ArrayList cashpaymentarray= new ArrayList();
cashpaymentarray.add(fromacno+"::"+fromcurrency+"::"+fromcurrate+"::false::"+Double.parseDouble(amount)*-1+"::"+desc+"::"+Double.parseDouble(amount)*-1+"::0::0::0");
cashpaymentarray.add(toacno+"::"+tocurrency+"::"+tocurrate+"::true::"+Double.parseDouble(amount)+"::"+desc+"::"+Double.parseDouble(amount)+"::0::0::0");
/*Cash Payment Saving Ends*/

/*Ib-Cash Payment Grid Saving*/
ArrayList ibcashpaymentarray= new ArrayList();
ibcashpaymentarray.add(fromacno+"::"+fromcurrency+"::"+fromcurrate+"::false::"+Double.parseDouble(amount)*-1+"::"+desc+"::"+Double.parseDouble(amount)*-1+"::0::0::0::"+branch+"::"+branch);
ibcashpaymentarray.add(toacno+"::"+tocurrency+"::"+tocurrate+"::true::"+Double.parseDouble(amount)+"::"+desc+"::"+Double.parseDouble(amount)+"::0::0::0::"+branch+"::"+branch);
/*Ib-Cash Payment Grid Saving Ends*/

/*Bank Payment Saving*/
ArrayList bankpaymentarray= new ArrayList();
bankpaymentarray.add(fromacno+"::"+fromcurrency+"::"+fromcurrate+"::false::"+Double.parseDouble(amount)*-1+"::"+desc+"::"+Double.parseDouble(amount)*-1+"::0::0::0::"+0+"::"+0);
bankpaymentarray.add(toacno+"::"+tocurrency+"::"+tocurrate+"::true::"+Double.parseDouble(amount)+"::"+desc+"::"+Double.parseDouble(amount)+"::0::0::0::"+0+"::"+0);
/*Bank Payment Saving Ends*/

/*Ib-Bank Payment Saving*/
ArrayList ibbankpaymentarray= new ArrayList();
ibbankpaymentarray.add(fromacno+"::"+fromcurrency+"::"+fromcurrate+"::false::"+Double.parseDouble(amount)*-1+"::"+desc+"::"+Double.parseDouble(amount)*-1+"::0::0::0::"+branch+"::"+branch+"::"+0+"::"+0);
ibbankpaymentarray.add(toacno+"::"+tocurrency+"::"+tocurrate+"::true::"+Double.parseDouble(amount)+"::"+desc+"::"+Double.parseDouble(amount)+"::0::0::0::"+branch+"::"+branch+"::"+0+"::"+0);
/*Ib-Bank Payment Saving Ends*/

System.out.println("////"+jobvocno+" - BWPD/////");
int value=contradao.insert(contradate, "COT", jobvocno+" - BWPD", fromtype, Integer.parseInt(fromacno), fromcurrency, fromcurrate, 0, 
	0, "", contradate, Double.parseDouble(amount), Double.parseDouble(amount), desc, 0, branch, totype, Integer.parseInt(toacno), 
	tocurrency, tocurrate, Double.parseDouble(amount), Double.parseDouble(amount), cashpaymentarray, ibcashpaymentarray, bankpaymentarray, ibbankpaymentarray, 
	session, request, "A");
/* Date contraTransDate, String formdetailcode,String txtrefno, String cmbtype, int txtfromdocno,String cmbfromcurrency, double txtfromrate,
int hidchckpdc,int txtpdcacno, String txtchequeno, Date chequeDate,double txtfromamount, double txtfrombaseamount,String txtdescription,int hidchckib, 
String cmbbranch,String cmbtotype, int txttodocno, String cmbtocurrency,double txttorate, double txttoamount, double txttobaseamount,
ArrayList<String> cashpaymentarray, ArrayList<String> ibcashpaymentarray, ArrayList<String> bankpaymentarray, ArrayList<String> ibbankpaymentarray,
HttpSession session, HttpServletRequest request, String mode */
if(value<=0){
	errorstatus=1;
	errormsg="Contra Trans Not Generated";
}
if(value>0){
	
	String userid=session.getAttribute("USERID").toString();
	String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+jobdocno+"','"+branch+"','BCPO',now(),'"+userid+"','A')";
	int datalog= stmt.executeUpdate(strlog);
	if(datalog<=0){
		conn.close();
		errorstatus=1;
		errormsg="Contra Trans Not Generated";
	}
	String trno=request.getAttribute("tranno").toString();
	String strupdatespare="update ws_estspare set contrastatus=1,trno="+trno+" where rowno in ("+rows+")";
	int updatespare=stmt.executeUpdate(strupdatespare);
	if(updatespare<=0){
		errorstatus=1;
		errormsg="Contra Trans Not Generated";
	}
	if(errorstatus==0){
		conn.commit();
		errormsg="Contra Trans "+value+" Generated";
	}
}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	errormsg="Contra Trans Not Generated";
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+errormsg);
/*  */
%>