
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

	String srno=request.getParameter("srno");
	String brhid=request.getParameter("brhid");
	
	 String upsql=null;
	 int val=0;
		Connection conn=null;

	 try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   
	
	
		upsql="update  gl_rdriver  set status=7 where srno='"+srno+"' ";
		
		 val= stmt.executeUpdate(upsql);
		 
		 
		
		 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+srno+",'"+brhid+"','BDRR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 
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
