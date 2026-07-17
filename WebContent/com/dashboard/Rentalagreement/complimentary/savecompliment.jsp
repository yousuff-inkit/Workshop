
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

	String radocno=request.getParameter("rentaldoc");
	
	
	 String upsql=null;
	 String upsql1=null;
	 int val=0;
	Connection conn=null;

	 try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   
	
	
		 upsql="update  gl_ragmt  set invtype=3 where doc_no='"+radocno+"' ";
		//System.out.println("------upsql----"+upsql);
		  stmt.executeUpdate(upsql);
		 
		 upsql="update gl_rtarif set  rate=0, cdw=0, pai=0, cdw1=0, pai1=0, gps=0, babyseater=0, cooler=0,kmrest=0, exkmrte=0, oinschg=0, exhrchg=0, chaufchg=0, chaufexchg=0 where rdocno='"+radocno+"' ";
			
		 val= stmt.executeUpdate(upsql);
		
		 
	
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
