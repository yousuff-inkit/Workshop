
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

	String ra_no=request.getParameter("ra_no");
	String mrano=request.getParameter("mrano");
	String oldmrano=request.getParameter("oldmrano");
	
System.out.println("--------ra_no----------"+ra_no);

java.sql.Date sqlprocessdate=null;



	 String upsql=null;

	 int val=0;
	 int docval=0;
	 

	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	  
	   if(!(mrano.equalsIgnoreCase("")|| mrano.equalsIgnoreCase("NA")))
	   {
	   
	    upsql="update  gl_ragmt  set mrano='" +mrano+ "'  where doc_no='"+ra_no+"' ";
		   System.out.println("----upsql-1--"+upsql);
		     val= stmt.executeUpdate(upsql);
		    
			    
		   upsql="insert into gl_blpo(rano, mrano,new_mrano, userid,edate)values('"+ra_no+"','"+oldmrano+"','"+mrano+"','"+session.getAttribute("USERID").toString()+"',now()) ";
		   System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 //upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BVBR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			
			 
			  } 
	   
	  
		 				
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
