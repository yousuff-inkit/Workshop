
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
	String codename=request.getParameter("codename")==null?"0":request.getParameter("codename").trim();
	String acno=request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
	

	
//String aa=session.getAttribute("BRANCHID").toString();
//System.out.println("---------"+aa);



	 Connection conn=null;

	 try{
	 int val=0;
	
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	Statement stmt1 = conn.createStatement();
		String insql="update my_account set acno='"+acno+"' where codeno='"+codename+"'";
		val= stmt.executeUpdate(insql);
    response.getWriter().print(val);
    System.out.println("val="+val);
	 	stmt.close();
	 	conn.close();
	 	  
	 }
	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
