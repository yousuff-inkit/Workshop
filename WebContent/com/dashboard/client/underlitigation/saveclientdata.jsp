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

	String changestatus=request.getParameter("changestatus");
	String cmbinfos=request.getParameter("cmbinfos");
	String disputedate=request.getParameter("disputedate");
	String caseno=request.getParameter("caseno");
	String station=request.getParameter("station");
	String value=request.getParameter("value").equalsIgnoreCase("")?"0.00":request.getParameter("value");
	String casenote=request.getParameter("casenote");
   	String cldocno=request.getParameter("cldocno");

	java.sql.Date sqldisputedate=null;

	String upsql=null;

	int val=0;
	int docval=0;
	Connection conn=null;
		 
	try{
	 	 conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement();

		 if(!(disputedate.equalsIgnoreCase("undefined"))&&!(disputedate.equalsIgnoreCase(""))&&!(disputedate.equalsIgnoreCase("0"))) {
				sqldisputedate=ClsCommon.changeStringtoSqlDate(disputedate);
		 }

		 upsql="update  my_acbook  set pcase='"+changestatus+"' where cldocno='"+cldocno+"' and dtype='CRM' ";
		 val= stmt.executeUpdate(upsql);
			      
		 upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bdis";
		 ResultSet resultSet = stmt.executeQuery(upsql);
				    
		 if (resultSet.next()) {
			docval=resultSet.getInt("doc_no");
		 }	
				     
		 upsql="insert into gl_bdis (change_status, doc_no, rdtype,  bibpid,  caseno, station, casedate, value, casenote, status, date, userid, cldocno)values('"+changestatus+"','"+docval+"','BDIS','5','"+caseno+"','"+station+"','"+sqldisputedate+"','"+value+"','"+casenote+"',3,now(),'"+session.getAttribute("USERID").toString()+"','"+cldocno+"') ";
		 val= stmt.executeUpdate(upsql);

		 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+session.getAttribute("BRANCHID").toString()+"','BDIS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 int aaa= stmt.executeUpdate(upsql);
	
	  /*   else  if(cmbinfo.equalsIgnoreCase("6"))
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
		  */				
		 
		response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	} catch(Exception e){
		 conn.close();
		 e.printStackTrace();
	} finally {
		conn.close();
	}
		    
	
%>
