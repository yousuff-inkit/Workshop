<%@page import="java.util.ArrayList"%>
<%@page import="com.procurement.purchase.purchaseorder.*"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
String podate=request.getParameter("podate")==null?"":request.getParameter("podate");
String poarray=request.getParameter("poarray")==null?"":request.getParameter("poarray");
int vndacno=request.getParameter("vndacno")==null?0:Integer.parseInt(request.getParameter("vndacno"));
String pay=request.getParameter("paydetails")==null?"":request.getParameter("paydetails");
String del=request.getParameter("deldetails")==null?"":request.getParameter("deldetails");
String rrefno=request.getParameter("rrefno")==null?"":request.getParameter("rrefno");
double prdtotal=request.getParameter("prdtotal")==null?0.0:Double.parseDouble(request.getParameter("prdtotal"));
double nettotaldown=request.getParameter("nettotaldown")==null?0.0:Double.parseDouble(request.getParameter("nettotaldown"));
double ordervalue=request.getParameter("ordervalue")==null?0.0:Double.parseDouble(request.getParameter("ordervalue"));
double nettax=request.getParameter("nettax")==null?0.0:Double.parseDouble(request.getParameter("nettax"));
int errorstatus=0;
int docval=0;
String povoc="";
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClspurchaseorderDAO podao=new ClspurchaseorderDAO();
	ArrayList<String>descarray=new ArrayList();
	ArrayList<String>termsarray=new ArrayList();
	ArrayList<String>shiparray=new ArrayList();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	ArrayList<String> masterarray= new ArrayList<String>();
	java.sql.Date sqlprocessdate=null;
	java.sql.Date sqldeldate=null;
	String aa[]=poarray.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			 masterarray.add(temp);
		  }
		 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0")))
			{
			sqlprocessdate=objcommon.changeStringtoSqlDate(podate);
				
			}
			else{

			}
		 docval=podao.insert(sqlprocessdate, sqlprocessdate, "0", vndacno, 1, 1.0, del, pay, "purchase order create bi", prdtotal, 0.0, 0.0, 0.0, nettotaldown, 0.0, ordervalue, 0, session, "A", "PO", request, descarray, masterarray, "PR", rrefno, 0.0, termsarray, shiparray, 0, 0.0, 0.0, 0.0, 0.0, nettax, 1, 0, 0);
if (docval>0){
	povoc=request.getAttribute("vocno").toString();
}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
response.getWriter().write(docval+"::"+povoc);
%>