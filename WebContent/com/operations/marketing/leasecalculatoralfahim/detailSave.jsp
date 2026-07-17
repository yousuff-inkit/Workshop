<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
int returnval=0;
try{
	String dealer=request.getParameter("dealer").equalsIgnoreCase("")?null:request.getParameter("dealer");
	String purchcost=request.getParameter("purchcost").equalsIgnoreCase("")?null:request.getParameter("purchcost");
	String downpytper=request.getParameter("downpytper").equalsIgnoreCase("")?null:request.getParameter("downpytper");
	String interestper=request.getParameter("interestper").equalsIgnoreCase("")?null:request.getParameter("interestper");
	String creditper=request.getParameter("creditper").equalsIgnoreCase("")?null:request.getParameter("creditper");
	String authority=request.getParameter("authority").equalsIgnoreCase("")?null:request.getParameter("authority");
	String profitper=request.getParameter("profitper").equalsIgnoreCase("")?null:request.getParameter("profitper");
	String overheadper=request.getParameter("overheadper").equalsIgnoreCase("")?null:request.getParameter("overheadper");
	String others=request.getParameter("others").equalsIgnoreCase("")?null:request.getParameter("others");
	String discount=request.getParameter("discount").equalsIgnoreCase("")?null:request.getParameter("discount");
	String docno=request.getParameter("docno").equalsIgnoreCase("")?null:request.getParameter("docno");
	String leasereqdocno=request.getParameter("leasereqdocno").equalsIgnoreCase("")?null:request.getParameter("leasereqdocno");
	String srno=request.getParameter("srno").equalsIgnoreCase("")?null:request.getParameter("srno");
	String totalvalue=request.getParameter("totalvalue").equalsIgnoreCase("")?null:request.getParameter("totalvalue");
	conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	int val=stmt.executeUpdate("update gl_leasecalcreq set dealerid="+dealer+",prchcost="+purchcost+",downpytper="+downpytper+",interestper="+interestper+",creditcardper="+creditper+",authid="+authority+",profitper="+profitper+",overheadper="+overheadper+",others="+others+",discount="+discount+",totalvalue="+totalvalue+",savestatus=1 where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+"");
	if(val<=0){
		returnval=0;
	}
	else{
		conn.commit();
		returnval=1;
	}
stmt.close();


}
catch(Exception e){
	e.printStackTrace();
	returnval=0;	
}
finally{
	conn.close();
}
response.getWriter().write(returnval+"");
  %>