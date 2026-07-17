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

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String docno=request.getParameter("docno");
		String date=request.getParameter("date");
		String branchid=request.getParameter("branchid");
		String cldocno=request.getParameter("cldocno");
		String agreement=request.getParameter("agreement");
	    String remarks=request.getParameter("remarks");
	    String amount=request.getParameter("amount");
	    String process=request.getParameter("process");
	    String rdocno=request.getParameter("rdocno");
	    String rtype=request.getParameter("rtype");
		String typeid=request.getParameter("typeid");
	    
	    java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

		String sql=null;
		int val=0,docNo=0;
		
		  sql="select coalesce(max(doc_no)+1,1) doc_no from gl_borq;";
		  ResultSet resultSet = stmt.executeQuery(sql);
		  
		   while (resultSet.next()) {
				 docNo=resultSet.getInt("doc_no");
		   }
		  
		   if(process.equalsIgnoreCase("7")){
				 /*Process */
			     sql="update gl_othreqd set borq=7 where brhid="+branchid+" and rdocno='"+docno+"' and type_id='"+typeid+"'";
			     val= stmt.executeUpdate(sql);
			     sql="insert into gl_borq (doc_no,date, cldocno, agreement, amount, remarks, bibpid, brhid) values("+docNo+",'"+sqlDate+"', '"+cldocno+"', '"+agreement+"', '"+amount+"', '"+remarks+"', '"+process+"', '"+branchid+"');";
				 val= stmt.executeUpdate(sql);
				 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BORQ',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 int data= stmt.executeUpdate(sql);
		   }
		   
		   else  if(process.equalsIgnoreCase("8")){
			   /*Cancel */
			    sql="update gl_othreqd set borq=8 where brhid="+branchid+" and rdocno='"+docno+"' and type_id='"+typeid+"'";
			    val= stmt.executeUpdate(sql); 	  
			    sql="insert into gl_borq (doc_no, date, cldocno, agreement, amount, remarks, bibpid, brhid) values("+docNo+",'"+sqlDate+"', '"+cldocno+"', '"+agreement+"', '"+amount+"', '"+remarks+"', '"+process+"', '"+branchid+"');";
				val= stmt.executeUpdate(sql);
				sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BORQ',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				int data= stmt.executeUpdate(sql);
		   }
		   
		   else  if(process.equalsIgnoreCase("9")){
			   /*Complete */
			    sql="update gl_othreqd set borq=9 where brhid="+branchid+" and rdocno='"+docno+"' and type_id='"+typeid+"'";
			    val= stmt.executeUpdate(sql); 	  
			    sql="insert into gl_borq (doc_no, date, cldocno, agreement, amount, remarks, bibpid, brhid) values("+docNo+",'"+sqlDate+"', '"+cldocno+"', '"+agreement+"', '"+amount+"', '"+remarks+"', '"+process+"', '"+branchid+"');";
				val= stmt.executeUpdate(sql);
				if(rtype.equalsIgnoreCase("RAG") || rtype.equalsIgnoreCase("rag")){
					sql="insert into gl_rcalc (idno, rdocno, dtype, amount, brhid) values(7, '"+rdocno+"', 'BORQ', '"+amount+"', '"+branchid+"');";
					val= stmt.executeUpdate(sql);
				}
				
				if(rtype.equalsIgnoreCase("LAG") || rtype.equalsIgnoreCase("lag")){
					sql="insert into gl_lcalc (idno, rdocno, dtype, amount, brhid) values(7, '"+rdocno+"', 'BORQ', '"+amount+"', '"+branchid+"');";
					val= stmt.executeUpdate(sql);
				}
				
				sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BORQ',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				int data= stmt.executeUpdate(sql);
		   }
			 				
			response.getWriter().print(val);
	
		 	stmt.close();
		 	conn.close();
		}catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
	   }finally{
		   conn.close();
	   }
	
	%>
