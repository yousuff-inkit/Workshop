
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


	String rdocno=request.getParameter("rdocno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String folldate=request.getParameter("folldate");
	String clname=request.getParameter("clname");
	String reftype=request.getParameter("reftype");



	 Connection conn=null;

	 try{

java.sql.Date sqlprocessdate=null;

if(!(folldate.equalsIgnoreCase("undefined"))&&!(folldate.equalsIgnoreCase(""))&&!(folldate.equalsIgnoreCase("0")))
	{
	sqlprocessdate=ClsCommon.changeStringtoSqlDate(folldate);
		
	}
	else{

	}

	 String upsql=null;

	 int val=0;
	 int docval=0;
	
	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   if(cmbinfo.equalsIgnoreCase("18"))
	   {
		   

		   upsql="update  gl_quotm  set clstatus=1 where doc_no='"+rdocno+"' ";
		
		     val= stmt.executeUpdate(upsql);
		     upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bqot";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	 
		   upsql="insert into gl_bqot (doc_no,date, rdocno, bibpid, fdate,reftype, name, remarks, userid, status)values('"+docval+"',now(),'"+rdocno+"','"+cmbinfo+"','"+sqlprocessdate+"','"+reftype+"','"+clname+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3) ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BQOT',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			  }

	   else  if(cmbinfo.equalsIgnoreCase("19"))
	   {
		   
		   upsql="update  gl_quotm  set clstatus=2 where doc_no='"+rdocno+"' ";
		     val= stmt.executeUpdate(upsql);
		     upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bqot";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	     
	
			     
		     upsql="insert into gl_bqot(doc_no,date,rdocno,bibpid,ddate,reftype, name, remarks, userid, status)values('"+docval+"',now(),'"+rdocno+"','"+cmbinfo+"','"+sqlprocessdate+"','"+reftype+"','"+clname+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3) ";
			 val= stmt.executeUpdate(upsql);
			 
					 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BQOT',now(),'"+session.getAttribute("USERID").toString()+"','A')";
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
