<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
int returnval=0;
try{
	
	String docno=request.getParameter("docno").equalsIgnoreCase("")?null:request.getParameter("docno");
	String leasereqdocno=request.getParameter("leasereqdocno").equalsIgnoreCase("")?null:request.getParameter("leasereqdocno");
	String srno=request.getParameter("srno").equalsIgnoreCase("")?null:request.getParameter("srno");
	conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	int val=stmt.executeUpdate("update gl_leasecalcreq set confirmstatus=1 where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+"");
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