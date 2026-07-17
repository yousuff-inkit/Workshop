
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
 
  
  String outdate=request.getParameter("jqxDateOut");
  
  
  String excessinsur=request.getParameter("excessinsur");
  
  String saveval=request.getParameter("saveval");
  
  String branchid=request.getParameter("branchid");
  
  
  
  String invoicevalue=request.getParameter("invoicevalue");
  
  String advance=request.getParameter("advance");
  
  String orentaltype=request.getParameter("orentaltype");
  String oinvdate=request.getParameter("oinvdate");
  String oadvchk=request.getParameter("oadvchk");
  String oinvtype=request.getParameter("oinvtype");
  String nrentaltype=request.getParameter("nrentaltype");
  String rvocno=request.getParameter("rvocno");
  String rcldocno=request.getParameter("rcldocno");
  
  String list=request.getParameter("list")==null?"0":request.getParameter("list");
  
//System.out.println("=="+rvocno+"=="+rcldocno);
  java.sql.Date sqloutDate = null;
  
  java.sql.Date invtodate=null;
  
  java.sql.Date oldinvdate=null;
  
	if(!(outdate.equalsIgnoreCase("undefined"))&&!(outdate.equalsIgnoreCase(""))&&!(outdate.equalsIgnoreCase("0")))
	{
		sqloutDate=ClsCommon.changeStringtoSqlDate(outdate);
		
	}
	else{

	}
	if(!(oinvdate.equalsIgnoreCase("undefined"))&&!(oinvdate.equalsIgnoreCase(""))&&!(oinvdate.equalsIgnoreCase("0")))
	{
		oldinvdate=ClsCommon.changeStringtoSqlDate(oinvdate);
		
	}
	else{

	}
  
  
  String rstatus = request.getParameter("rstatus");  
  String docno = request.getParameter("docno");
  
//System.out.println("-----docno---"+docno);
  String upsql=null;

	 int val=0;
	 
	 ArrayList<String> psrnoarray= new ArrayList<String>();
		String aa[]=list.split(",");
		 
			 
		for(int i=0;i<aa.length;i++){
			// System.out.println("----------"+aa[i]);
			 String bb[]=aa[i].split("::");
			// System.out.println("Col Len----------"+bb.length);
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
				 
			}
			 psrnoarray.add(temp);
			 
		} 
		 
	//	 System.out.println("Array----"+psrnoarray);
	 
		Connection conn=null;

		 try{
	 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
		
String methodval="";
	
	int cofval=0;
	int id_brex=0;
	int brexrstatus=0;
	
	for(int k=0;k<psrnoarray.size();k++)
	{
		brexrstatus++;
			 if(k==3)
				 {
				 brexrstatus=brexrstatus+1;
				 }
		
		String[] pmgntarr=((String) psrnoarray.get(k)).split("::"); 
		
		 String rentaltype = ""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";
		  String rate = ""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
		  String cdw = ""+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"";

		  
		  String pai = ""+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"";
		  String cdw1 = ""+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"";
		  String pai1 = ""+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"";
		 
		  
		  String gps = ""+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"";
		  String baby = ""+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"";
		  
		  String cooler = ""+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"";
		 
		  
		  String kmrest = ""+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?0:pmgntarr[9].trim())+"";
		  String exkm = ""+(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("NaN")|| pmgntarr[10].trim().equalsIgnoreCase("")|| pmgntarr[10].isEmpty()?0:pmgntarr[10].trim())+"";
		  
		  String insuchg = ""+(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("NaN")|| pmgntarr[11].trim().equalsIgnoreCase("")|| pmgntarr[11].isEmpty()?0:pmgntarr[11].trim())+"";
		 
		  String exhrchg = ""+(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("NaN")|| pmgntarr[12].trim().equalsIgnoreCase("")|| pmgntarr[12].isEmpty()?0:pmgntarr[12].trim())+"";
		  
		  String chafchg = ""+(pmgntarr[13].trim().equalsIgnoreCase("undefined") || pmgntarr[13].trim().equalsIgnoreCase("NaN")|| pmgntarr[13].trim().equalsIgnoreCase("")|| pmgntarr[13].isEmpty()?0:pmgntarr[13].trim())+"";
		  
		  String chaufexchg = ""+(pmgntarr[14].trim().equalsIgnoreCase("undefined") || pmgntarr[14].trim().equalsIgnoreCase("NaN")|| pmgntarr[14].trim().equalsIgnoreCase("")|| pmgntarr[14].isEmpty()?0:pmgntarr[14].trim())+"";
		  			 
		if(k==0)
		{
			String sqlbrex="insert into gl_brex(rano,orenttype,nrenttype,userid,invdate,oadvchk,oinvtype,nadvchk,ninvtype,date,cldocno,brchid,rvocno) values ('"+docno+"','"+orentaltype+"','"+nrentaltype+"','"+session.getAttribute("USERID").toString()+"','"+oldinvdate+"',"+oadvchk+","+oinvtype+","+advance+","+invoicevalue+",CURDATE(),"+rcldocno+","+branchid+","+rvocno+")";
			int valbrex=stmt.executeUpdate(sqlbrex); 
		
		 	if(valbrex==1)
		 	{
		 	 String sqls="SELECT MAX(idgl_brex) idgl_brex from gl_brex where rano='"+docno+"' ";
		 	
				 ResultSet rsbrex=stmt.executeQuery(sqls);
				 
				 if(rsbrex.next())
				 {
					
					id_brex=rsbrex.getInt("idgl_brex");
					 
				 }
		 	} 
		}
		
		
		 upsql="insert into gl_brexd(rdocno,refno,rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg, chaufchg, chaufexchg,rstatus) values("+docno+","+id_brex+",'"+rentaltype+"','"+rate+"', '"+cdw+"','"+pai+"', '"+cdw1+"' ,'"+pai1+"', '"+gps+"', '"+baby+"','"+cooler+"','"+kmrest+"','"+exkm+"','"+insuchg+"','"+exhrchg+"', '"+chafchg+"','"+chaufexchg+"',"+brexrstatus+")  ";
		
		 val= stmt.executeUpdate(upsql);  

	 
	}
	
	  
	
/* 	
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
 			  
 			  
 		      int result = invtodate.compareTo(invtodate);
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
 			     	 
 			    	   String lastsql="SELECT DATE_ADD('"+sqloutDate+"',INTERVAL '"+cofval+"' DAY) todate";
 			    	  // System.out.println("--lastsql--"+lastsql);
 				     	  ResultSet rss4=  stmt.executeQuery(lastsql);
 				     		 
 				     		 if(rss4.next())
 				     		 {
 				     			 invtodate=rss4.getDate("todate"); 
 				     		 }
 			    	 
 			    	 
 			        }
 			       

 			     
 			 	      
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
	 			      
 			
		     			     
		} 

 */		  			
		 response.getWriter().print(1);
	  
	 	stmt.close();
	 	conn.close();
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 			response.getWriter().print(2);
	 		}
	    
	
	%>