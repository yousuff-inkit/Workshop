
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


	String radocno=request.getParameter("radocno");
 
	
	 String upsql=null;
	 int val=0;
		Connection conn=null;

	 try{
		 ClsConnection ClsConnection=new ClsConnection();
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   
	
	
		upsql="update  my_ordd  set clstatus=1 where rowno='"+radocno+"' ";
		
		 val= stmt.executeUpdate(upsql);
		 
		 
		
/* 		 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+radocno+",'"+branchval+"','BLRTA',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 
		 int aaa= stmt.executeUpdate(upsql); */

	
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
