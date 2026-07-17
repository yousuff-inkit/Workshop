 
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


String aa=request.getParameter("aa");
 

	 String upsql=null;

	 int val=0;
	 int docval=0;

	 Connection conn=null;

	 try{
		 ClsConnection connDAO=new ClsConnection();
		 ClsCommon Common=new ClsCommon();
    conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
		
				

		upsql="select method from gl_config where  field_nme='Tarifautoset'";
					 
				 
				   ResultSet resultSet = stmt.executeQuery(upsql);
				 
				   while (resultSet.next()) {
				    	
				    	val=resultSet.getInt("method");
				    }		  
				  
		
	 
		 response.getWriter().print(val);
		 
	 	
	 	stmt.close();
	 	conn.close();
	 	  
	 }
	 catch(Exception e){
			
			conn.close();
			
		} 

	%>
 