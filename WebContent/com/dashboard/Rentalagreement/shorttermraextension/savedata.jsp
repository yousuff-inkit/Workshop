
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

/* function ajaxcall(rentaltype,rate,cdw,pai,cdw1,pai1,gps,baby,cooler,kmrest,exkm,insuchg,chafchg,chaufexchg);  */
  String rentaltype = request.getParameter("rentaltype")==null||request.getParameter("rentaltype").equalsIgnoreCase("undefined") ||request.getParameter("rentaltype").equalsIgnoreCase("") ||request.getParameter("rentaltype").equalsIgnoreCase("NaN") ||request.getParameter("rentaltype").isEmpty()?"0":request.getParameter("rentaltype").trim();
  String rate = request.getParameter("rate")==null||request.getParameter("rate").equalsIgnoreCase("undefined") ||request.getParameter("rate").equalsIgnoreCase("") ||request.getParameter("rate").equalsIgnoreCase("NaN") ||request.getParameter("rate").isEmpty()?"0":request.getParameter("rate").trim();
  String cdw = request.getParameter("cdw")==null||request.getParameter("cdw").equalsIgnoreCase("undefined") ||request.getParameter("cdw").equalsIgnoreCase("") ||request.getParameter("cdw").equalsIgnoreCase("NaN") ||request.getParameter("cdw").isEmpty()?"0":request.getParameter("cdw").trim();

  
  String pai = request.getParameter("pai")==null||request.getParameter("pai").equalsIgnoreCase("undefined") ||request.getParameter("pai").equalsIgnoreCase("") ||request.getParameter("pai").equalsIgnoreCase("NaN") ||request.getParameter("pai").isEmpty()?"0":request.getParameter("pai").trim();
  String cdw1 = request.getParameter("cdw1")==null||request.getParameter("cdw1").equalsIgnoreCase("undefined") ||request.getParameter("cdw1").equalsIgnoreCase("") ||request.getParameter("cdw1").equalsIgnoreCase("NaN") ||request.getParameter("cdw1").isEmpty()?"0":request.getParameter("cdw1").trim();
  String pai1 = request.getParameter("pai1")==null||request.getParameter("pai1").equalsIgnoreCase("undefined") ||request.getParameter("pai1").equalsIgnoreCase("") ||request.getParameter("pai1").equalsIgnoreCase("NaN") ||request.getParameter("pai1").isEmpty()?"0":request.getParameter("pai1").trim();
 

  
  String gps = request.getParameter("gps")==null||request.getParameter("gps").equalsIgnoreCase("undefined") ||request.getParameter("gps").equalsIgnoreCase("") ||request.getParameter("gps").equalsIgnoreCase("NaN") ||request.getParameter("gps").isEmpty()?"0":request.getParameter("gps").trim();
  String baby = request.getParameter("baby")==null||request.getParameter("baby").equalsIgnoreCase("undefined") ||request.getParameter("baby").equalsIgnoreCase("") ||request.getParameter("baby").equalsIgnoreCase("NaN") ||request.getParameter("baby").isEmpty()?"0":request.getParameter("baby").trim();
  
  String cooler = request.getParameter("cooler")==null||request.getParameter("cooler").equalsIgnoreCase("undefined") ||request.getParameter("cooler").equalsIgnoreCase("") ||request.getParameter("cooler").equalsIgnoreCase("NaN") ||request.getParameter("cooler").isEmpty()?"0":request.getParameter("cooler").trim();
 
  
  String kmrest = request.getParameter("kmrest")==null||request.getParameter("kmrest").equalsIgnoreCase("undefined") ||request.getParameter("kmrest").equalsIgnoreCase("") ||request.getParameter("kmrest").equalsIgnoreCase("NaN") ||request.getParameter("kmrest").isEmpty()?"0":request.getParameter("kmrest").trim();
  String exkm = request.getParameter("exkm")==null||request.getParameter("exkm").equalsIgnoreCase("undefined") ||request.getParameter("exkm").equalsIgnoreCase("") ||request.getParameter("exkm").equalsIgnoreCase("NaN") ||request.getParameter("exkm").isEmpty()?"0":request.getParameter("exkm").trim();
  
  String insuchg = request.getParameter("insuchg")==null||request.getParameter("insuchg").equalsIgnoreCase("undefined") ||request.getParameter("insuchg").equalsIgnoreCase("") ||request.getParameter("insuchg").equalsIgnoreCase("NaN") ||request.getParameter("insuchg").isEmpty()?"0":request.getParameter("insuchg").trim();
 
  String exhrchg = request.getParameter("exhrchg")==null||request.getParameter("exhrchg").equalsIgnoreCase("undefined") ||request.getParameter("exhrchg").equalsIgnoreCase("") ||request.getParameter("exhrchg").equalsIgnoreCase("NaN") ||request.getParameter("exhrchg").isEmpty()?"0":request.getParameter("exhrchg").trim();
  
  String chafchg = request.getParameter("chafchg")==null||request.getParameter("chafchg").equalsIgnoreCase("undefined") ||request.getParameter("chafchg").equalsIgnoreCase("") ||request.getParameter("chafchg").equalsIgnoreCase("NaN") ||request.getParameter("chafchg").isEmpty()?"0":request.getParameter("chafchg").trim();
  
  String chaufexchg = request.getParameter("chaufexchg")==null||request.getParameter("chaufexchg").equalsIgnoreCase("undefined") ||request.getParameter("chaufexchg").equalsIgnoreCase("") ||request.getParameter("chaufexchg").equalsIgnoreCase("NaN") ||request.getParameter("chaufexchg").isEmpty()?"0":request.getParameter("chaufexchg").trim();
  
  
  String outdate=request.getParameter("jqxDateOut");
  
  
  String excessinsur=request.getParameter("excessinsur");
  
  String saveval=request.getParameter("saveval");
  
  String branchid=request.getParameter("branchid");
  
  
  
  
  String invoicevalue=request.getParameter("invoicevalue");
  
  String advance=request.getParameter("advance");
  
  
  
  

  java.sql.Date sqloutDate = null;
  
  java.sql.Date invtodate=null;
  
	if(!(outdate.equalsIgnoreCase("undefined"))&&!(outdate.equalsIgnoreCase(""))&&!(outdate.equalsIgnoreCase("0")))
	{
		sqloutDate=ClsCommon.changeStringtoSqlDate(outdate);
		
	}
	else{

	}
  
  
	
   
	
	
	
  
  
  String rstatus = request.getParameter("rstatus");  
  String docno = request.getParameter("docno");
  
//System.out.println("-----docno---"+docno);
  String upsql=null;

	 int val=0;
		Connection conn=null;

		 try{
	 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	 
	
String methodval="";
	
	int cofval=0;
	
	if(rstatus.equalsIgnoreCase("7")){

	  
	  
	}
	  
	  
	 	 upsql="update  gl_rtarif set rentaltype='"+rentaltype+"', rate='"+rate+"', cdw='"+cdw+"', pai='"+pai+"', cdw1='"+cdw1+"' , pai1='"+pai1+"', gps='"+gps+"', babyseater='"+baby+"', cooler='"+cooler+"', kmrest='"+kmrest+"', exkmrte='"+exkm+"', oinschg='"+insuchg+"', exhrchg='"+exhrchg+"', chaufchg='"+chafchg+"', chaufexchg='"+chaufexchg+"'  where rdocno='"+docno+"' and rstatus='"+rstatus+"' ";
	 
		     val= stmt.executeUpdate(upsql);  
	
 		if(rstatus.equalsIgnoreCase("7")){
			 
 			
 			  if(invoicevalue.equalsIgnoreCase("1")) 
 			  {
 			  String sqls="SELECT LAST_DAY('"+sqloutDate+"') outdate";
 			  
 			//  System.out.println("--1--sqls--"+sqls);
 			  
 			 ResultSet rss=  stmt.executeQuery(sqls);
 			 
 			 if(rss.next())
 			 {
 				 invtodate=rss.getDate("outdate"); 
 			 }
 			 
 			  
 			// System.out.println("----invtodate--"+invtodate);
 			  
 			  
 		      int result = invtodate.compareTo(sqloutDate);
 		   //  System.out.println("--result--"+result);
 		      
 		        if(result==0)
 		    	  
 		      {
 		      	 
 		       
 		    	  String zerosql="SELECT LAST_DAY(DATE_ADD('"+sqloutDate+"',INTERVAL 1 month)) todate";
 		    	//  System.out.println("----zerosql--"+zerosql);
 		    	  ResultSet rss1=  stmt.executeQuery(zerosql);
 		    		 
 		    		 if(rss1.next())
 		    		 {
 		    			 invtodate=rss1.getDate("todate"); 
 		    		 }

 			  }  
 		        
 		      //  System.out.println("----invtodate2-"+invtodate);
 		        
 			  }
 			

 			  else if(invoicevalue.equalsIgnoreCase("2")) 
 			  {

 				  String consql="select method,value from GL_CONFIG WHERE FIELD_NME='monthlycal'";
 				  
 				 //    System.out.println("--consql--"+consql);
 				  ResultSet rss2=  stmt.executeQuery(consql);
 		 		 
 		 		 if(rss2.next())
 		 		 {
 		 			methodval=rss2.getString("method"); 
 		 			cofval=rss2.getInt("value"); 
 		 		 }

 			    // System.out.println("--methodval--"+methodval);
 			    // System.out.println("--cofval--"+cofval);
 			          //select value into cofval from GL_CONFIG WHERE FIELD_NME='monthlycal';

 			     if(methodval.equalsIgnoreCase("1"))
 			    		 {
 					    	 //  SELECT DATE_ADD(sqloutDate,INTERVAL 1 month) into invtodate;
 					    	   
 					    	   String onesql="SELECT DATE_ADD('"+sqloutDate+"',INTERVAL 1 month) todate";
 					    	   
 					    	  // System.out.println("--onesql--"+onesql);
 				
 					     	  ResultSet rss3=  stmt.executeQuery(onesql);
 					     		 
 					     		 if(rss3.next())
 					     		 {
 					     			 invtodate=rss3.getDate("todate"); 
 					     		 }
 					    	   
 					    	   
 			    		 }
 			     
 			     
 			     
 			     else if(methodval.equalsIgnoreCase("0"))
 			     {
 			    	// SELECT DATE_ADD(sqloutDate,INTERVAL cofval DAY) into invtodate;
 			    	 
 			    	 
 			    	 
 			    	   String lastsql="SELECT DATE_ADD('"+sqloutDate+"',INTERVAL '"+cofval+"' DAY) todate";
 			    	  // System.out.println("--lastsql--"+lastsql);
 				     	  ResultSet rss4=  stmt.executeQuery(lastsql);
 				     		 
 				     		 if(rss4.next())
 				     		 {
 				     			 invtodate=rss4.getDate("todate"); 
 				     		 }
 			    	 
 			    	 
 			        }
 			       

 			     
 			         

 			    // System.out.println("----invtodate3-"+invtodate);
 			      
 			     }
 			
 			
 			  java.sql.Date sqldueDate = null;
 			   String onesqls="SELECT DATE_ADD('"+sqloutDate+"',INTERVAL 1 month) todate";
		    	   
		    	 //  System.out.println("--onesqls--"+onesqls);
	
		     	  ResultSet rss31=  stmt.executeQuery(onesqls);
		     		 
		     		 if(rss31.next())
		     		 {
		     			sqldueDate=rss31.getDate("todate"); 
		     		 }
		     		// System.out.println("----sqldueDate-"+sqldueDate);
	 			      
 			
		     upsql="update  gl_ragmt set ddate='"+sqldueDate+"',invtodate='"+invtodate+"',insex='"+excessinsur+"',advchk='"+advance+"',  invtype='"+invoicevalue+"'   where doc_no='"+docno+"'  ";
				 
				     val= stmt.executeUpdate(upsql);
				     
				 	String sqlsave="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+branchid+"','BREX',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 	stmt.executeUpdate(sqlsave);  
				     
				     
		}
		  				
		 response.getWriter().print(saveval);
	 
	  
	 	stmt.close();
	 	conn.close();
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	    
	
	%>