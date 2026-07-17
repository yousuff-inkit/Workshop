<%@page import="com.common.ClsCommon"%>
<%@page import="com.common.ClsRentalInvoiceCalc"%>
<%@page import="com.dashboard.invoices.rental.ClsRentalInvoiceDAO"%>
<%@page import="com.operations.agreement.rentalclose.ClsRentalCloseDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
ClsRentalInvoiceCalc cr=new ClsRentalInvoiceCalc();


try{
	//System.out.println("Conn Created Inv Amount.jsp");
	
	String rano=request.getParameter("rano");
String cldocno=request.getParameter("cldocno");
String fromdate=request.getParameter("fromdate");
String todate=request.getParameter("todate");
String rentaltype=request.getParameter("rentaltype");
String invtype=request.getParameter("invtype");
String index=request.getParameter("index");
java.sql.Date fromdate1=null,todate1=null;
if(!(fromdate.equalsIgnoreCase("")||(fromdate.equalsIgnoreCase(null)))){
	fromdate1=ClsCommon.changetstmptoSqlDate(fromdate);
}
if(!(todate.equalsIgnoreCase("")||(todate.equalsIgnoreCase(null)))){
	todate1=ClsCommon.changetstmptoSqlDate(todate);
}


//System.out.println("===========before=========");
ArrayList invoicearray=cr.getInvoiceCalc(rano, cldocno, fromdate1, todate1,rentaltype,invtype);
ArrayList salikarray=ClsCommon.getSalik(fromdate1, todate1, cldocno, rano,"RAG");
//System.out.println("salikarray"+salikarray);
double finalamount=0.0;
for(int i=0;i<4;i++){
	//System.out.println("salik Final Amount of "+rano+"::"+finalamount);	
	finalamount+=Double.parseDouble(salikarray.get(i).toString());
	
}

for(int i=0;i<invoicearray.size();i++){
	//System.out.println("Other Final Amount of "+rano+"::"+finalamount);	
	finalamount+=Double.parseDouble(invoicearray.get(i).toString());
}
String finalamount1=finalamount+"";
//System.out.println("PASSING DATA of Agmt:"+rano+"::"+finalamount1+":"+invoicearray.get(0)+":"+invoicearray.get(1)+":"+salikarray.get(0)+":"+salikarray.get(1)+":"+salikarray.get(2)+":"+salikarray.get(3)+":"+invoicearray.get(2)+":"+salikarray.get(4)+":"+salikarray.get(5)+":"+salikarray.get(6)+":"+salikarray.get(7)+":"+index);


response.getWriter().write(finalamount1+":"+invoicearray.get(0)+":"+invoicearray.get(1)+":"+salikarray.get(0)+":"+salikarray.get(1)+":"+salikarray.get(2)+":"+salikarray.get(3)+":"+invoicearray.get(2)+":"+salikarray.get(4)+":"+salikarray.get(5)+":"+salikarray.get(6)+":"+salikarray.get(7)+":"+index);

}
catch(Exception e1){
	e1.printStackTrace();
	
}
finally{
	//System.out.println("Finally Close Inv Amount.jsp");
	
}
%>
  
