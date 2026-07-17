
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


	String valfleet=request.getParameter("valfleet");
	String docnos=request.getParameter("docnos");

	
	


	 String upsql=null;

	 int val=0;
	 int docval=0;

	 Connection conn=null;

	 try{

		 ClsConnection connDAO=new ClsConnection();
    conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
		
				   String upsql1="select * from my_jvtran where rdocno='"+docnos+"' and  rtype='RAG' and status=3" ;		   
					//System.out.println("--------upsql1---------"+upsql1)	;	  
				   ResultSet reSet = stmt.executeQuery(upsql1);   
				   
					
				   
				   while(reSet.next()) {
				    	
					  // System.out.println("--------first---------")	;	  
				    	val=1;
					  
				    }	
				  
             String upsql2=" select * from gl_vmove where repno!=0 and rdocno='"+docnos+"' and rdtype='RAG' and fleet_no='"+valfleet+"' " ;		   
           //  System.out.println("-------upsql2-------"+upsql2)	;	   
				   ResultSet reSet2 = stmt.executeQuery(upsql2);   
				   
					
				   
				   while(reSet2.next()) {
					  
					 //  System.out.println("--------sec---------")	;	  
					 
				    	val=1;
					  
				    }	
				       
				   
		
			//System.out.println("--------val---------"+val)	;	      	   
		
		 if(val==1)
		 {
		 
		 }
		 else
		 {
			 
		     String upsql3=" delete from gl_vmove where repno=0 and rdocno='"+docnos+"' and rdtype='RAG'  and fleet_no='"+valfleet+"' " ;		   
		 	 //  System.out.println("--------upsql3----"+upsql3);
			int aaa = stmt.executeUpdate(upsql3);   
			
		    String upsql4=" update  gl_vehmaster set status='IN',tran_code='RR' where   fleet_no='"+valfleet+"' " ;		   
		 	//   System.out.println("--------upsql4----"+upsql4);   
		   int a1 = stmt.executeUpdate(upsql4);   
			
		   String upsql5=" update  gl_ragmt set status=7,clstatus=1 where   doc_no='"+docnos+"' " ;		   
	 	  // System.out.println("--------upsql5----"+upsql5);  
		   int a2 = stmt.executeUpdate(upsql5);  
		
		 }
		 if(val==1)
		 {
			 response.getWriter().print(val); 
		 }
		 else
		 {
			  response.getWriter().print(val);  
		 }
	 	stmt.close();
	 	conn.close();
	 	  
	 }
	 catch(Exception e){
			
			conn.close();
			
		} 

	%>
