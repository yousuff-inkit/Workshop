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

    String docno=request.getParameter("docno");
   	String branchid=request.getParameter("branchid");
   
	
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	Statement stmtlog = conn.createStatement ();

	String updatesql="update gl_vinspm set clacc=1 where doc_no='"+docno+"'";
	 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+branchid+"','BACR',now(),'"+session.getAttribute("USERID").toString()+"','C')";
	 int logval=0;
	 System.out.println("Clear Sql:"+updatesql);
	 System.out.println("Log Sql:"+logsql);
	 int updateval= stmt.executeUpdate(updatesql);
		if(updateval>0){
			 logval=stmtlog.executeUpdate(logsql);
		}
	
		 response.getWriter().print(logval);
	 	
	 	stmt.close();
	 	stmtlog.close();
	 	conn.close();
	 	  
	    
	
	%>