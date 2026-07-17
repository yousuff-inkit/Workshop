
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
	String disputedate=request.getParameter("disputedate");
	String caseno=request.getParameter("caseno");
	String station=request.getParameter("station");
	String value=request.getParameter("value");
	String casenote=request.getParameter("casenote");
   String cldocno=request.getParameter("cldocno");

//System.out.println("------rentaldocno----"+rentaldocno);

java.sql.Date sqldisputedate=null;

if(!(disputedate.equalsIgnoreCase("undefined"))&&!(disputedate.equalsIgnoreCase(""))&&!(disputedate.equalsIgnoreCase("0")))
	{
	sqldisputedate=ClsCommon.changeStringtoSqlDate(disputedate);
		
	}
	else{

	}

	 String upsql=null;

	 int val=0;
	 int docval=0;
		Connection conn=null;

		 try{
	 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   if(cmbinfo.equalsIgnoreCase("4"))
	   {
		   
		   upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bdis";
		   ResultSet resultSet = stmt.executeQuery(upsql);
		   
		    if (resultSet.next()) {
		    	docval=resultSet.getInt("doc_no");
		    }	
				  
			 
		   upsql="insert into gl_bdis (doc_no,rdtype, rdocno, bibpid, remarks,status,fdate,date,userid)values('"+docval+"','BDIS','"+rentaldocno+"','"+cmbinfo+"','"+remarks+"',3,'"+sqldisputedate+"',now(),'"+session.getAttribute("USERID").toString()+"') ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BDIS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			  }
	
	   else  if(cmbinfo.equalsIgnoreCase("5"))
	   {
		   
	
			   upsql="update  gl_ragmt  set dispute=2 where doc_no='"+rentaldocno+"' ";
			
			     val= stmt.executeUpdate(upsql);
			     upsql="update  my_acbook  set pcase=1 where cldocno='"+cldocno+"' and dtype='CRM' ";
					
			      val= stmt.executeUpdate(upsql);
			      
			      
			      upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bdis";
				   ResultSet resultSet = stmt.executeQuery(upsql);
				   
				    if (resultSet.next()) {
				    	docval=resultSet.getInt("doc_no");
				    }	
						
			      
				  upsql="insert into gl_bdis (doc_no,rdtype, rdocno, bibpid, remarks, caseno, station, casedate, value, casenote, status,date,userid)values('"+docval+"','BDIS','"+rentaldocno+"','"+cmbinfo+"','"+remarks+"','"+caseno+"','"+station+"','"+sqldisputedate+"','"+value+"','"+casenote+"',3,now(),'"+session.getAttribute("USERID").toString()+"') ";
				 
					 val= stmt.executeUpdate(upsql);
					 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BDIS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
					 
					 int aaa= stmt.executeUpdate(upsql);
			  
	   }
	   else  if(cmbinfo.equalsIgnoreCase("6"))
	   {
		   
		   
			upsql="update  gl_ragmt  set dispute=0 where doc_no='"+rentaldocno+"' ";
			
			 val= stmt.executeUpdate(upsql);
			 
			 upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bdis";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	
					
			 
			 
			  upsql="insert into gl_bdis (doc_no,rdtype, rdocno, bibpid, remarks,status,date,userid)values('"+docval+"','BDIS','"+rentaldocno+"','"+cmbinfo+"','"+remarks+"',3,now(),'"+session.getAttribute("USERID").toString()+"') ";
			 
				 val= stmt.executeUpdate(upsql);
			 
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BDIS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);

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
