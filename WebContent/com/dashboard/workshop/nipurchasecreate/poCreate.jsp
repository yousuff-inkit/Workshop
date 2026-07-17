<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
ClsnipurchaseDAO purchaseDAO= new ClsnipurchaseDAO(); 


String orderno=request.getParameter("orderno")==null?"":request.getParameter("orderno");
String acno=request.getParameter("acno")==null?"":request.getParameter("acno");
String acname=request.getParameter("acname")==null?"":request.getParameter("acname");
String atype=request.getParameter("atype")==null?"":request.getParameter("atype");
String rate=request.getParameter("rate")==null?"0":request.getParameter("rate");
String curid=request.getParameter("curid")==null?"":request.getParameter("curid");
String orderdate=request.getParameter("orderdate")==null?"":request.getParameter("orderdate");
String descarray=request.getParameter("descarray")==null?"":request.getParameter("descarray");
String amount=request.getParameter("amount")==null?"0.0":request.getParameter("amount");
String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String vendorname=request.getParameter("vendorname")==null?"":request.getParameter("vendorname");
String curdate=request.getParameter("curdate")==null?"":request.getParameter("curdate");


int errorstatus=0;
int x=0;
try{
		int orderefno=Integer.parseInt(orderno);
		double nettotal=Double.parseDouble(amount);
		String data[]=descarray.split(",");
		
		java.sql.Date sqlorderdate=null,sqlinvdate=null,sqlcurrentdate=null;
	    if(!orderdate.equalsIgnoreCase("") && orderdate!=null){
			sqlorderdate=commonDAO.changeStringtoSqlDate(orderdate);
		} 
		if(!invdate.equalsIgnoreCase("") && invdate!=null){
			sqlinvdate=commonDAO.changeStringtoSqlDate(invdate);
		}
		 if(!curdate.equalsIgnoreCase("") && curdate!=null){
			sqlcurrentdate=commonDAO.changeStringtoSqlDate(curdate);
			System.out.println(sqlcurrentdate);
		} 
		
		ArrayList<String> detailarray= new ArrayList();
		for(int i=0;i<data.length;i++){
			detailarray.add(data[i]);
		}
		System.out.println("-inside ajax-");
		int val=0;
	/* 	purchaseDAO.insert(sqlcurrentdate, sqlorderdate, "NPO", orderefno, atype, acno, vendorname, curid, rate, "", "", "", session, "a", nettotal, detailarray, "CPU", request, sqlinvdate, invno, invdate, 1,0,0); */
		
		System.out.println("---"+val);
		
		if(val<=0){
			errorstatus=1;
		}
		
}catch(Exception e){
	e.printStackTrace();
}
finally{
}
response.getWriter().write(errorstatus+"");
%>