
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

	String rentaldocno=request.getParameter("rentaldocno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String exdate=request.getParameter("exdate");

	String grgid=request.getParameter("grgid");
	String fleetno=request.getParameter("fleetno");

	 Connection conn=null;

	 try{
java.sql.Date sqlexdate=null;

if(!(exdate.equalsIgnoreCase("undefined"))&&!(exdate.equalsIgnoreCase(""))&&!(exdate.equalsIgnoreCase("0")))
	{
		 sqlexdate=ClsCommon.changeStringtoSqlDate(exdate);
		
	}
	else{

	}

	 String upsql=null;

	 int val=0;
	 int docval=0;
	
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   if(cmbinfo.equalsIgnoreCase("25"))
	   {
		   
		
				   upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bmfu";
				   ResultSet resultSet = stmt.executeQuery(upsql);
				   
				    if (resultSet.next()) {
				    	docval=resultSet.getInt("doc_no");
				    }		  
			 
		   upsql="insert into gl_bmfu(doc_no,date, rdocno,bibpid,remarks,fdate,userid,fleet_no,garageid)values('"+docval+"',now(),'"+rentaldocno+"','"+cmbinfo+"','"+remarks+"','"+sqlexdate+"','"+session.getAttribute("USERID").toString()+"','"+fleetno+"','"+grgid+"') ";
			
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BMFU',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			
	   }
	   else  if(cmbinfo.equalsIgnoreCase("26"))
	   {
		   upsql="update  gl_nrm set  extdt='"+sqlexdate+"'  where doc_no='"+rentaldocno+"'";
		 
		    val= stmt.executeUpdate(upsql); 	  
		  

				  upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bmfu";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }
		   
		    upsql="insert into gl_bmfu (doc_no,date, rdocno, bibpid, extdt,remarks,userid,fleet_no,garageid)values('"+docval+"',now(),'"+rentaldocno+"','"+cmbinfo+"', '"+sqlexdate+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"','"+fleetno+"','"+grgid+"') ";
		 
	
		    
			 val= stmt.executeUpdate(upsql); 
				
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BVDD',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			
	   }
	 
		 				
		 response.getWriter().print(val);
	 
	 	
	 	stmt.close();
	 	conn.close();
	 }
		 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	      
	
	%>
