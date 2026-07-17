
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

	String ticketno=request.getParameter("ticketno");
 

 

	 String upsql=null;

	 int val=0;
	 int docval=0;
	
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement (); 
	
	
	     upsql="update gl_traffic set inv_no=9999999,status=7  where TICKET_NO='"+ticketno+"' ";
	     
	  //   System.out.println("---upsql---"+upsql);
	     
	     stmt.executeUpdate(upsql);
	   
	  
		 
	 
	
		 response.getWriter().print(99);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	}
		 catch(Exception e){
			 response.getWriter().print(00);
	 			conn.close();
	 			e.printStackTrace();
	 		}
	    
	
	%>
