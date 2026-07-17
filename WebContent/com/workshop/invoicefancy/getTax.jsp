<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String hidrefno=request.getParameter("hidrefno")==null?"":request.getParameter("hidrefno");
double vatpercent=0.0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	int insurtodocno=0;
	String strdecideinvoiceto="select if(gate.insurancecomp>0,gate.insurcldocno,gate.cldocno) invoicetodocno from ws_jobcard job "+
	" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) "+
	" where job.doc_no="+hidrefno;
	ResultSet rsinvoicetodetails=stmt.executeQuery(strdecideinvoiceto);
	while(rsinvoicetodetails.next()){
		insurtodocno=rsinvoicetodetails.getInt("invoicetodocno");
	}
	String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+insurtodocno+" and dtype='CRM') clienttaxmethod";
	System.out.println(strchecktax);
	ResultSet rschecktax=stmt.executeQuery(strchecktax);
	int taxstatus=0;
	int clienttaxmethod=0;
	while(rschecktax.next()){
		taxstatus=rschecktax.getInt("taxmethod");
		clienttaxmethod=rschecktax.getInt("clienttaxmethod");
	}
	if(taxstatus==1 && clienttaxmethod==1){
		String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
		ResultSet rsgettax=stmt.executeQuery(strgettax);
		while(rsgettax.next()){
			vatpercent=rsgettax.getDouble("vat_per");
		}
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(vatpercent+"");
%>