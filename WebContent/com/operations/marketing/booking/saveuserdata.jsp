
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


	String userids=request.getParameter("userids");
	String userdesc=request.getParameter("userdesc");


    


	 String upsql=null;
	 Connection conn=null;
	 int val=0;

	 ClsConnection viewDAO=new  ClsConnection();



	
	 try{
		 conn = viewDAO.getMyConnection();
			
		 Statement stmt = conn.createStatement ();
		 
			String sqlsave="insert into  gl_rdisclevel(nuserid,desc1, date, ouserid) values ('"+userids+"','"+userdesc+"',now(),'"+session.getAttribute("USERID").toString()+"')";


				 val=stmt.executeUpdate(sqlsave); 
			response.getWriter().print(val);
			 

	


		}catch(Exception e){
			
			conn.close();
			e.printStackTrace();
		}

	
		 
	 
	 	//System.out.println("aaaaaa"+accode);


				conn.close();
	 	  
	    
	
	%>
