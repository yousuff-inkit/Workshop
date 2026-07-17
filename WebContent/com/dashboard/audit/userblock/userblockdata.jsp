
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

	String doc_no=request.getParameter("doc_no");
	

	 Connection conn=null;

	 try{


//System.out.println(testdate);
 String upsql=null,insql=null;

	 int val=0;
	 int updqty=0;
	 int laqty=0;
	 int laupdqty=0;
	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	if(!(doc_no.equalsIgnoreCase("NA")))
    {
  
     insql="update my_user set block=1 where doc_no='"+doc_no+"' ";
     
    System.out.println(insql);
       val= stmt.executeUpdate(insql);
     // System.out.println(testdate);
        String sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+doc_no+"','"+session.getAttribute("BRANCHID").toString()+"','BUBD',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	     int data= stmt.executeUpdate(sql);
       
		
		 System.out.println(sql);
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
