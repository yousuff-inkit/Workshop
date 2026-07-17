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
Connection conn=null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


try{
	String damagedate=request.getParameter("damagedate");
	String fleetno=request.getParameter("fleetno");
	String reftype=request.getParameter("reftype");
	String amount=request.getParameter("amount");
	String reason=request.getParameter("reason");
    String docno=request.getParameter("docno");
    String brnchid=request.getParameter("brnchid");
    String refdocno=request.getParameter("refdocno");
    String action=request.getParameter("action");
    String type=request.getParameter("type");
    

    
   
	java.sql.Date sqldamagedate=ClsCommon.changeStringtoSqlDate(damagedate);

	 String upsql=null;
	
	 int val=0;
	
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	   upsql="update gl_vinspm set amount='"+amount+"'  where doc_no='"+docno+"' ";
        stmt.executeUpdate(upsql);
		
       upsql="insert into gl_bvdr(date,type,reftype,refdocno,fleetno,action,amount,reason,rdocno)values('"+sqldamagedate+"','"+type+"','"+reftype+"','"+refdocno+"', '"+fleetno+"','"+action+"','"+amount+"','"+reason+"','"+docno+"') ";
		 val= stmt.executeUpdate(upsql);
		 
		 if(action.equalsIgnoreCase("Chargeable"))
		 {
			 
			 if(reftype.equalsIgnoreCase("RAG"))
			 {	 
			 
	       upsql="insert into gl_rcalc(rdocno,dtype,idno,amount,brhid)values('"+refdocno+"','RAG',10,'"+amount+"','"+session.getAttribute("USERID").toString()+"') ";
			 val= stmt.executeUpdate(upsql);		 
		     }
			 else if(reftype.equalsIgnoreCase("LAG"))
			 {	 
			 
	       upsql="insert into gl_lcalc(rdocno, dtype, idno, amount,brhid)values('"+refdocno+"','LAG',10,'"+amount+"','"+session.getAttribute("USERID").toString()+"') ";
			 val= stmt.executeUpdate(upsql);		 
		     }
			 
			 
		 }
	 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+brnchid+"','BVDR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 
	 int aaa= stmt.executeUpdate(upsql);

	
		 response.getWriter().print(val);
	 	
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	    
	
	%>
