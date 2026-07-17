<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@page import="java.util.Date"%>

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
<%@page import="com.dashboard.workshop.jobexecution.*" %> 
<%@page import="java.text.SimpleDateFormat" %>  
<%

ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Statement stmt=null;
	ClsJobExecutionDAO jedao= new ClsJobExecutionDAO();
    String temp="0";

	try{
		conn=ClsConnection.getMyConnection();
		String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
		String servicearray=request.getParameter("servicearray")==null?"":request.getParameter("servicearray");
		/* System.out.println("array--------------"+servicearray); */
		ArrayList<String> descarray= new ArrayList<String>();
		
		String spltpurreq[]=servicearray.split(","); 
		 for(int i=0;i<spltpurreq.length;i++)
		 {
		 
			 String temp21=spltpurreq[i];
			
				descarray.add(temp21);
		 }
		 
		 /* System.out.println(descarray+"docno"+docno); */
		int reqval=jedao.updateService(descarray,docno);
		
		/* System.out.println(descarray+"docno"+docno); */
		
			 if(reqval>0)
			 {
				 temp="1";
				 //conn.commit();
			 }
		 response.getWriter().print(temp);
 		
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	
   }finally{
	   conn.close();
   }
%>
