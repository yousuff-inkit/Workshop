<%@page import="com.common.ClsCommon"%>
<%@page import="com.common.ClsLeaseInvoiceCalc"%>
<%@page import="com.dashboard.invoices.rental.ClsRentalInvoiceDAO"%>
<%@page import="com.operations.agreement.rentalclose.ClsRentalCloseDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
ClsLeaseInvoiceCalc cl=new ClsLeaseInvoiceCalc();

try{	
String rano=request.getParameter("rano");
String cldocno=request.getParameter("cldocno");
String fromdate=request.getParameter("fromdate");
String todate=request.getParameter("todate");
String rentaltype=request.getParameter("rentaltype");
String invtype=request.getParameter("invtype");
java.sql.Date fromdate1=null,todate1=null;
if(!(fromdate.equalsIgnoreCase("")||(fromdate.equalsIgnoreCase(null)))){
	fromdate1=ClsCommon.changetstmptoSqlDate(fromdate);
}
if(!(todate.equalsIgnoreCase("")||(todate.equalsIgnoreCase(null)))){
	todate1=ClsCommon.changetstmptoSqlDate(todate);
}

ArrayList<Double> invoicearray=cl.getInvoiceCalc(rano, cldocno, fromdate1, todate1,rentaltype,invtype);
ArrayList<Double> salikarray=ClsCommon.getSalik(fromdate1, todate1, cldocno, rano,"LAG");
double finalamount=0.0;
for(int i=0;i<4;i++){
	finalamount+=Double.parseDouble(salikarray.get(i).toString());
}
//System.out.println("Salik Array Size:"+salikarray.size());
for(int i=0;i<invoicearray.size();i++){
	finalamount+=Double.parseDouble(invoicearray.get(i).toString());
}
//System.out.println("Invoice Array Size:"+invoicearray.size());
String finalamount1=finalamount+"";
double inv0=invoicearray.size()>0?invoicearray.get(0):0;
double inv1=invoicearray.size()>0?invoicearray.get(1):0;
double inv2=invoicearray.size()>0?invoicearray.get(2):0;
double salik0=salikarray.size()>0?salikarray.get(0):0;
double salik1=salikarray.size()>0?salikarray.get(1):0;
double salik2=salikarray.size()>0?salikarray.get(2):0;
double salik3=salikarray.size()>0?salikarray.get(3):0;
double salik4=salikarray.size()>0?salikarray.get(4):0;
double salik5=salikarray.size()>0?salikarray.get(5):0;
double salik6=salikarray.size()>0?salikarray.get(6):0;
double salik7=salikarray.size()>0?salikarray.get(7):0;

//System.out.println("PASSING DATA"+finalamount1+":"+invoicearray.get(0)+":"+invoicearray.get(1)+":"+salikarray.get(0)+":"+salikarray.get(1)+":"+salikarray.get(2)+":"+salikarray.get(3));
//response.getWriter().write(finalamount1+":"+invoicearray.get(0)+":"+invoicearray.get(1)+":"+salikarray.get(0)+":"+salikarray.get(1)+":"+salikarray.get(2)+":"+salikarray.get(3)+":"+invoicearray.get(2)+":"+salikarray.get(4)+":"+salikarray.get(5)+":"+salikarray.get(6)+":"+salikarray.get(7));

response.getWriter().write(finalamount1+":"+inv0+":"+inv1+":"+salik0+":"+salik1+":"+salik2+":"+salik3+":"+inv2+":"+salik4+":"+salik5+":"+salik6+":"+salik7);
}
catch(Exception e1){
	e1.printStackTrace();
}


%>
  
