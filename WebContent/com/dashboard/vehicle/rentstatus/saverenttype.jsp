
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


	String fleet=request.getParameter("fleet");
	
String renttype=request.getParameter("renttype");





	 String upsql=null;

	 int val=0;
	 int docval=0;
	 
	 Connection conn=null;

	 try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String sqllimo="";
	if(renttype.equalsIgnoreCase("LM")){
		sqllimo+=",limostatus=1";
	}
	

	
    upsql="update gl_vehmaster set renttype='"+renttype+"'"+sqllimo+"  where fleet_no='"+fleet+"' ";
    val=stmt.executeUpdate(upsql);
  
		
		 				
		 response.getWriter().print(val);
	 
	 	
	 	stmt.close();
	 	conn.close();
	
	 	}
    catch(Exception e){

	 conn.close();
	 e.printStackTrace();
	 		}	  
	    
	
	%>
