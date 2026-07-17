
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


	String fleetno=request.getParameter("fleetno");
	String vmdocno=request.getParameter("vmdocno");
	String dtype=request.getParameter("dtype");
	String vmrdocno=request.getParameter("vmrdocno");
	
 
/* java.sql.Date sqloutdate=null;

  if(!(dateout.equalsIgnoreCase("undefined"))&&!(dateout.equalsIgnoreCase(""))&&!(dateout.equalsIgnoreCase("0")))
	{
	sqloutdate=ClsCommon.changeStringtoSqlDate(dateout);
		
	}
	else{

	}     */
	
	

	 String upsql=null;

	 int val=0;
	 int docval=0;

	 Connection conn=null;

	 try{

		 String curtran=""; 
		 int branchs=0; 
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
		if(dtype.equalsIgnoreCase("VSC"))
		{
			
			
			
			  String upsqlss="select currst from gl_flchange where  doc_no='"+vmrdocno+"'";		   
			   ResultSet resultSet = stmt.executeQuery(upsqlss);
			 
			   while (resultSet.next()) {
			    	
				 curtran=resultSet.getString("currst");
				 
			    }		  
			 
			   
				 
				String upsql3="update gl_vehmaster set tran_code='"+curtran+"',status='IN'  where  fleet_no='"+fleetno+"' ";		
				
				 
	         	stmt.executeUpdate(upsql3 );   
			   
			String upsql1="delete from gl_flchange where doc_no='"+vmrdocno+"' and fleetno='"+fleetno+"' ";		
			
			 
         	stmt.executeUpdate(upsql1);   	
			   
			upsql="delete from gl_vmove where rdocno='"+vmrdocno+"' and rdtype='VSC' and fleet_no='"+fleetno+"' ";	
				
		
				
	        stmt.executeUpdate(upsql);
	         
		}
		
		else if(dtype.equalsIgnoreCase("MOV"))
		{
			
			
			String upsqlss="select outbranch,vehtrancode from gl_nrm where  doc_no='"+vmrdocno+"'";		   
			   ResultSet resultSet = stmt.executeQuery(upsqlss);
			 
			   while (resultSet.next()) {
				   branchs=resultSet.getInt("outbranch");
				 curtran=resultSet.getString("vehtrancode");
			    }	
			   
			 
				String upsql3="update gl_vehmaster set tran_code='"+curtran+"',status='IN',a_br='"+branchs+"'  where  fleet_no='"+fleetno+"' ";		
				
			 
	         	stmt.executeUpdate(upsql3 );   
	
			   String upsql1="delete from gl_nrm where doc_no='"+vmrdocno+"' and fleet_no='"+fleetno+"' ";	
			 
			   stmt.executeUpdate(upsql1);   
				upsql="delete from gl_vmove where rdocno='"+vmrdocno+"' and rdtype='MOV' and fleet_no='"+fleetno+"' ";		
				
			 
				   stmt.executeUpdate(upsql);
				   
			 
		}
		
			
 
	
		response.getWriter().print(10); 
		
	 	
	 	stmt.close();
	 	conn.close();
	 	  
	 }
	 catch(Exception e){
		 response.getWriter().print(11); 
			e.printStackTrace();
			conn.close();
			
		} 

	%>
