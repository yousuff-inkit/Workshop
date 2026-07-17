
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
String branchid=request.getParameter("branchid");
	String docno=request.getParameter("docno");
	
	
	String sql=null;

	int val=0;
	 

 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();

		 /*Audit */
    	 sql="update gl_ragmt set audit=1 where doc_no='"+docno+"'";
     	 val= stmt.executeUpdate(sql);
	 	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branchid+"','BRAA',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 	 int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	 	
	%>
