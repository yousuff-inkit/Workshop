
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

<%@page import="java.sql.ResultSet"%>
<%	


	String userids=request.getParameter("userids");
	String userdesc=request.getParameter("userdesc");
	String fleetno=request.getParameter("fleetno");

	 ClsConnection connDAO=new ClsConnection();
    


	 String upsql=null;
	 Connection conn=null;
	 int val=0;


	 int docno=0;


	
	 try{
		 conn = connDAO.getMyConnection();
			
		 Statement stmt = conn.createStatement ();
		 
		
		 String sqls="select coalesce((max(doc_no)+1),1) docno from gl_rdisclevel";
		 ResultSet rs=stmt.executeQuery(sqls);
		 
		 if(rs.next())
		 {
			 docno=rs.getInt("docno");
			 
			 
		 }
		 
		 
		 
			String sqlsave="insert into  gl_rdisclevel(doc_no,nuserid,desc1, date, ouserid,fleet_no) values ('"+docno+"','"+userids+"','"+userdesc+"',now(),'"+session.getAttribute("USERID").toString()+"','"+fleetno+"')";
             val=stmt.executeUpdate(sqlsave); 
             
             
             
			response.getWriter().print(docno);
			 

	


		}catch(Exception e){
			
			conn.close();
			e.printStackTrace();
		}

	
		 
	 
	 	//System.out.println("aaaaaa"+accode);


				conn.close();
	 	  
	    
	
	%>
