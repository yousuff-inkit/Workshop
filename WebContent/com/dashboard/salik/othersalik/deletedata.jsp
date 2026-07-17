
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

Connection conn=null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


try{

	String trans=request.getParameter("trans");
 

 

	 String upsql=null;

	 int val=0;
	 int docval=0;
	
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement (); 
	
	
	     upsql="update gl_salik set inv_no=9999999,status=7  where trans='"+trans+"' ";
	     
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
