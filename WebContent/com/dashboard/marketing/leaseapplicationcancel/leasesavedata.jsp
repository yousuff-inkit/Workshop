
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	String leasereqdocno=request.getParameter("leasereqdocno");
	String srno=request.getParameter("srno");
	String testdate=request.getParameter("testdate");
	String remarks=request.getParameter("remarks");
	String refno=request.getParameter("refno");
	String clientname=request.getParameter("clientname");
	//String username=request.getParameter("username");
	//String qty=request.getParameter("qty");

	 Connection conn=null;

	 try{

java.sql.Date sqlpodate=null;

 if(!(testdate.equalsIgnoreCase("undefined"))&&!(testdate.equalsIgnoreCase(""))&&!(testdate.equalsIgnoreCase("0")))
	{
	sqlpodate=ClsCommon.changeStringtoSqlDate(testdate);
		
	}
	else{

	} 
//System.out.println(testdate);
 String upsql=null,insql=null;

	 int val=0;
	 int updqty=0;
	 int laqty=0;
	 int laupdqty=0;
	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	if(!(srno.equalsIgnoreCase("NA")))
    {
  
     insql="update gl_leasecalcreq set lastatus=7 where leasereqdocno='"+leasereqdocno+"' and srno='"+srno+"' ";
     
    // System.out.println(insql);
       val= stmt.executeUpdate(insql);
     // System.out.println(testdate);
       insql="insert into gl_blac (userid,srno,leasereqdocno,testdate,remarks,clientname,refno) values("+session.getAttribute("USERID").toString()+",'"+srno+"','"+leasereqdocno+"','"+sqlpodate+"','NA - "+remarks+"','"+clientname+"','"+refno+"')";
       System.out.println(insql);
       val= stmt.executeUpdate(insql);
		
		// System.out.println("done");
	  }
	
		 	conn.commit();
	 	 response.getWriter().print(val);
	 	stmt.close();
	 	
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 			 response.getWriter().print(2);
	 		}
	
	%>
