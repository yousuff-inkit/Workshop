
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


	String fleetno=request.getParameter("fleetno");
	String vmdocno=request.getParameter("vmdocno");
	String status=request.getParameter("status");
	
	


/* java.sql.Date sqloutdate=null;

  if(!(dateout.equalsIgnoreCase("undefined"))&&!(dateout.equalsIgnoreCase(""))&&!(dateout.equalsIgnoreCase("0")))
	{
	sqloutdate=ClsCommon.changeStringtoSqlDate(dateout);
		
	}
	else{

	}     */

	 String upsql=null;

	 int val=0;
	 int docval=0;

	 Connection conn=null;

	 try{

	 
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
		
			

		upsql="select status,doc_no from gl_vmove where rdtype!='veh' and fleet_no='"+fleetno+"' and doc_no>'"+vmdocno+"'";		   
				   ResultSet resultSet = stmt.executeQuery(upsql);
				 
				   while (resultSet.next()) {
				    	
				    	val=1;
				    }		  
				  
				   
	
		response.getWriter().print(val); 
		
	 	
	 	stmt.close();
	 	conn.close();
	 	  
	 }
	 catch(Exception e){
			
			conn.close();
			
		} 

	%>
