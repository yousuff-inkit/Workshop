
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


	String srno=request.getParameter("srno");
	String brhid=request.getParameter("brhid");
	String remarks=request.getParameter("remarks");
	String bibid=request.getParameter("bibid").trim();
	String cmbinfo=request.getParameter("cmbinfo").trim();
	String folldate=request.getParameter("folldate");
	
	 Connection conn=null;

	 try{

java.sql.Date sqlprocessdate=null;

if(!(folldate.equalsIgnoreCase("undefined"))&&!(folldate.equalsIgnoreCase(""))&&!(folldate.equalsIgnoreCase("0")))
	{
	sqlprocessdate=ClsCommon.changeStringtoSqlDate(folldate);
		
	}
	else{

	}

	 String upsql=null,sql=null;

	 int val=0;
	 int docval=0;
	
	 
 	conn = ClsConnection.getMyConnection();
 	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	
	   if(cmbinfo.equalsIgnoreCase("Foll"))
	   {
		   
		   
		 
		   upsql="insert into gl_blqf (date, rdocno, reftype, fdate, remarks, bibpid, brhid, userid, status)values(now(),'"+srno+"','LCQT','"+sqlprocessdate+"','"+remarks+"','"+bibid+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"',3) ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 upsql="select max(doc_no) doc_no from gl_blqf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	 
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+brhid+"','BLQF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 val= stmt.executeUpdate(upsql);
			 
			  }

	   else  if(cmbinfo.equalsIgnoreCase("Drop"))
	   {
		   
		   sql="update gl_blqf set status=7 where rdocno="+srno+" ";
	    	val= stmt.executeUpdate(sql);
	    	sql="insert into gl_blqf (date, rdocno, reftype, fdate, remarks, bibpid, brhid, userid, status)values(now(),'"+srno+"','LCQT','"+sqlprocessdate+"','"+remarks+"','"+bibid+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"',7) ";
			 val= stmt.executeUpdate(sql);
			 upsql="select max(doc_no) doc_no from gl_blqf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	
			sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+brhid+"','BLQF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			val=stmt.executeUpdate(sql);
			 
	   }
	   else  if(cmbinfo.equalsIgnoreCase("Decl"))
	   {
			     
		     upsql="update gl_leasecalcreq req  left join gl_lprd ld on req.leasereqdocno=ld.rdocno and req.reqsrno=ld.sr_no set ld.dropstatus=1,req.status=6 where req.srno='"+srno+"' ";
			 val= stmt.executeUpdate(upsql);
			 sql="insert into gl_blqf (date, rdocno, reftype, fdate, remarks, bibpid, brhid, userid, status)values(now(),'"+srno+"','LCQT','"+sqlprocessdate+"','"+remarks+"','"+bibid+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"',7) ";
			 val= stmt.executeUpdate(sql);
			 upsql="select max(doc_no) doc_no from gl_blqf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	
			sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+brhid+"','BLQF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			val=stmt.executeUpdate(sql);
			 
	   }
	  
		 	conn.commit();			
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
