<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>
<%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%> 
<%@page import= "com.common.ClsCommon"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%

Connection conn = null;
ClsCommon commonDAO = new ClsCommon();
ClsConnection ClsConnection=new ClsConnection();
ClspurchaseorderDAO orderobj= new ClspurchaseorderDAO();


String date=request.getParameter("date");
String jobno=request.getParameter("jobno");


int vndno=Integer.parseInt(request.getParameter("vndno"));
double vendorprice=Double.parseDouble(request.getParameter("vendorprice"));
double nettotal=Double.parseDouble(request.getParameter("nettotal"));
java.sql.Date sqldate=null;
sqldate=commonDAO.changeStringtoSqlDate(date);


ArrayList<String> masterarray= new ArrayList<String>();
String purchaseorderarray=request.getParameter("purchaseorderarray");
String[] temparray=purchaseorderarray.split(",");
for(int i=0;i<temparray.length;i++){
 masterarray.add(temparray[i]);
}
ArrayList<String> rownorarray= new ArrayList<String>();
String rownorarr=request.getParameter("rownorarray");
String[] rowno=rownorarr.split(",");
for(int i=0;i<rowno.length;i++){
	rownorarray.add(rowno[i]);
}


ArrayList<String> descarray= new ArrayList<String>();
ArrayList<String> termsarray= new ArrayList<String>();
ArrayList<String> shiparray= new ArrayList<String>();

int n=orderobj.insert(sqldate, sqldate, "JOB-"+jobno, vndno,1,1,"", "", "Job card costing - Job No - "+jobno, vendorprice,0.00,0.00,0.00,nettotal,0.0,vendorprice,0,session,"A", "PO",request, descarray, masterarray,"DIR","0",0.00,termsarray, shiparray,0, 0.00, 0.00, 0.00, 0.00, 0.00, 0,9,Integer.parseInt(jobno) );
System.out.println("===== "+masterarray);
	 
for(int i=0;i<rownorarray.size();i++){
	conn=ClsConnection.getMyConnection();
	Statement stmt=conn.createStatement();
	int processstatus=0;
	String str="update ws_estspare set pono="+n+",potype='PO' where rowno="+rownorarray.get(i);
	stmt.executeUpdate(str);
		
	}


response.getWriter().write(n+"");
%>