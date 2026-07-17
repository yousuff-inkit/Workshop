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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

 
	String ticketno=request.getParameter("ticketno");
String rtype=request.getParameter("trftype");
String branchsss=request.getParameter("branchsss");
String rentaldoc=request.getParameter("rentaldoc");
String leasedoc=request.getParameter("leasedoc");
String drdoc=request.getParameter("drdoc");
String staffdoc=request.getParameter("staffdoc");
String fleet_no=request.getParameter("fleet_no");


 


	 String upsql=null;

	 int val=0;
	int chafid=0; 
	int  empid=0;
	String emptype="";
	int laradocno=0;
	
 	Connection conn = null;

 
	
	 try{
	 
		 
		 conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			
		 
		     
		 //    System.out.println("rowValues-------"+rowValues);	     
		     
		     
		
	
						      	
						    		 if(rtype.equalsIgnoreCase("RAG"))
						    		 {
						    				Statement stmt11 = conn.createStatement (); 
						    		String ragsql="select chif,drid,cldocno from  gl_ragmt where doc_no='"+rentaldoc+"'";	 
						           
						    		 ResultSet newone = stmt11.executeQuery(ragsql);
								     if(newone.next())
								     {
								    	 
								    	 chafid=newone.getInt("chif");
								    	if(chafid==1) 
								    	{
								    	
								    		empid=newone.getInt("drid");	
								    		emptype="DRV";
								    	}
								    	else{
								    		
								    		empid=newone.getInt("cldocno");	
								    		emptype="CRM";
								    		
								    	}
						    			 
						    		 }
								     stmt11.close();
								     
								     Statement stmt2 = conn.createStatement ();
							    		String sqlup2="update GL_TRAFFIC set isallocated=1,reason='Allocated',ra_no='"+rentaldoc+"',branch='"+branchsss+"',emp_id='"+empid+"',emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='RM' where TICKET_NO='"+ticketno+"' ";
							            
							    		stmt2.executeUpdate(sqlup2);
							    		 stmt2.close();
								     
								     
						    		 
						    		 }
						    		 
						    		 
						    		 
						    		 else if(rtype.equalsIgnoreCase("LAG"))
						    		 {
						    			 Statement stmt12 = conn.createStatement (); 
						    			 String lagsql="select chif,drid,cldocno  from  gl_lagmt where doc_no='"+leasedoc+"'";	 
						              	 
							    		 ResultSet leasers = stmt12.executeQuery(lagsql);
									     if(leasers.next())
									     {
									    	 
									    	 chafid=leasers.getInt("chif");
									    	if(chafid==1) 
									    	{
									    	
									    		empid=leasers.getInt("drid");	
									    		emptype="DRV";
									    	}
									    	else{
									    		
									    		empid=leasers.getInt("cldocno");	
									    		emptype="CRM";
									    		
									    	}
							    	
							    		 }
									     stmt12.close();
									     Statement stmt2 = conn.createStatement ();
								    		String sqlup2="update GL_TRAFFIC set isallocated=1,reason='Allocated',ra_no='"+leasedoc+"',branch='"+branchsss+"',emp_id='"+empid+"',emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='LA' where TICKET_NO='"+ticketno+"' ";
								           	 
								    		stmt2.executeUpdate(sqlup2);
								    		 stmt2.close();
									     
									     
									     
						    		 }
						    		 else if(rtype.equalsIgnoreCase("DRV"))
						    		 {
						    			 
						    			 empid=Integer.parseInt(drdoc); 
								    		emptype="DRV";
							    		 Statement stmt2 = conn.createStatement ();
							    		String sqlup2="update GL_TRAFFIC set isallocated=1,reason='Allocated',emp_id='"+empid+"',branch='"+branchsss+"',emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='DR'  where TICKET_NO='"+ticketno+"' ";
							            
							    		stmt2.executeUpdate(sqlup2);
							    		 stmt2.close();
							    		  
						    			 
						    		 }
						    		 
						    		 else if(rtype.equalsIgnoreCase("STF"))
						    		 {
						    			 
						    			 empid=Integer.parseInt(staffdoc); 
						    		 
								    		emptype="STF";
						        		 Statement stmt2 = conn.createStatement ();
								    		String sqlup2="update GL_TRAFFIC set isallocated=1,reason='Allocated',emp_id='"+empid+"',branch='"+branchsss+"',emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='ST'  where TICKET_NO='"+ticketno+"' ";
								           
								    		stmt2.executeUpdate(sqlup2);
								    		 stmt2.close();
								    		   
						    		 }
						    		 

						      		
						    	
						    		 
						    	
						    		 
						    	
						    


            			
		 response.getWriter().print(10);
			stmt.close();
	          conn.close();	
	 
	 	
	 
 }catch(Exception e){
	
		e.printStackTrace();

		 response.getWriter().print("12");
			conn.close();
	
	}

	 	
	 	
	 	
%>



