
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


Connection conn=null;

try{

	String pnoval=request.getParameter("pnoval");
	String exdate=request.getParameter("exdate");
	String remarks=request.getParameter("remarks");
	String fleetno=request.getParameter("fleetno");
	String invexpdate=request.getParameter("invexpdate");
	String instype=request.getParameter("invtype");
	String comdoc=request.getParameter("comdoc");
    String docno=request.getParameter("docno");
    String branchid=request.getParameter("branchid");


	java.sql.Date sqlinvDate = ClsCommon.changeStringtoSqlDate(invexpdate);
	
	java.sql.Date sqlexdate=ClsCommon.changeStringtoSqlDate(exdate);

	 String upsql=null;

	 int val=0;
	 int docval=0;
	
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
	     upsql="update gl_vehmaster set pno='"+pnoval+"',ins_comp='"+comdoc+"',ins_exp='"+sqlexdate+"',itype='"+instype+"' where fleet_no='"+fleetno+"' ";
	     stmt.executeUpdate(upsql);
	   
	  
			  upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_vinsexp";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	 
		
		upsql="insert into gl_vinsexp (doc_no,fleetno, expirydt, renewdt, remarks)values('"+docval+"','"+fleetno+"','"+sqlinvDate+"','"+sqlexdate+"', '"+remarks+"') ";
		
		 val= stmt.executeUpdate(upsql);
		 
		 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docval+",'"+branchid+"','BVIS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 
		 int aaa= stmt.executeUpdate(upsql);
		 
	
	
		 response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	}
		 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	    
	
	%>
