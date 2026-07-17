
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

	String rentaldocno=request.getParameter("rentaldocno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String underdate=request.getParameter("underdate");
    String cldocno=request.getParameter("cldocno");
    
    
// System.out.println("----cldocno----"+cldocno);
	String disdoc=request.getParameter("disdoc");
    String choice=request.getParameter("choice");

	
 
     java.sql.Date sqlunderdate=null;

    if(!(underdate.equalsIgnoreCase("undefined"))&&!(underdate.equalsIgnoreCase(""))&&!(underdate.equalsIgnoreCase("0")))
	{
	sqlunderdate=ClsCommon.changeStringtoSqlDate(underdate);
		
	}
	else{

	}

	 String upsql=null;
     int docval=0;
	 int val=0;
	 

	
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   if(cmbinfo.equalsIgnoreCase("10"))
	   {
			   upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcul";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }

			 
		     upsql="insert into gl_bcul (doc_no,fdate, bibpid, cldocno, rdocno,remarks,date,userid,status)values('"+docval+"','"+sqlunderdate+"','"+cmbinfo+"','"+cldocno+"','"+disdoc+"','"+remarks+"',now(),'"+session.getAttribute("USERID").toString()+"',3) ";
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+session.getAttribute("BRANCHID").toString()+"','BCUL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 int aaa= stmt.executeUpdate(upsql);
			 
			
	   }
	   else  if(cmbinfo.equalsIgnoreCase("11"))
	   {
		   
		   if(choice.equalsIgnoreCase("RA"))
		   {
		   upsql="update  gl_ragmt set  dispute=0  where doc_no='"+rentaldocno+"'";
		 
		    val= stmt.executeUpdate(upsql); 	
		   }
		   
		    upsql="update  my_acbook set  pcase=0  where cldocno='"+cldocno+"'  and  dtype='CRM' ";
		    val= stmt.executeUpdate(upsql);
		   
		    upsql="update  gl_bdis set  status=7  where cldocno='"+cldocno+"'";
		    val= stmt.executeUpdate(upsql);
		   
		    upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcul";
		    ResultSet resultset=stmt.executeQuery(upsql);
		    if(resultset.next())
		    {
		    	docval=resultset.getInt("doc_no");
		    }
		    
		  
		     upsql="insert into gl_bcul (doc_no,rcdate, bibpid, cldocno, rdocno,remarks,date,userid,status)values('"+docval+"','"+sqlunderdate+"','"+cmbinfo+"','"+cldocno+"','"+disdoc+"','"+remarks+"',now(),'"+session.getAttribute("USERID").toString()+"',3) ";
			 val= stmt.executeUpdate(upsql);
				
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+session.getAttribute("BRANCHID").toString()+"','BCUL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
	
	   }
	   else  if(cmbinfo.equalsIgnoreCase("12"))
	   {
		   if(choice.equalsIgnoreCase("RA"))
		   {
		   
		    upsql="update  gl_ragmt set  dispute=0  where doc_no='"+rentaldocno+"'";
		    val= stmt.executeUpdate(upsql); 
		   }

		    upsql="update  my_acbook set  pcase=0  where cldocno='"+cldocno+"'  and  dtype='CRM'";
		    val= stmt.executeUpdate(upsql);
		    
		    upsql="update  gl_bdis set  status=7  where cldocno='"+cldocno+"'";
		    val= stmt.executeUpdate(upsql);
		    
		    upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcul";
		    ResultSet resultset=stmt.executeQuery(upsql);
		    if(resultset.next()){
		    	docval=resultset.getInt("doc_no");
		    }
		    
		    upsql="insert into gl_bcul (doc_no,rcdate, bibpid, cldocno, rdocno,remarks,date,userid,status)values('"+docval+"','"+sqlunderdate+"','"+cmbinfo+"','"+cldocno+"','"+disdoc+"','"+remarks+"',now(),'"+session.getAttribute("USERID").toString()+"',3) ";
			val= stmt.executeUpdate(upsql);
					
			upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+session.getAttribute("BRANCHID").toString()+"','BCUL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
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
