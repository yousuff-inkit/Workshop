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
<%@ page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %>

<%
ClsConnection viewDAO=new ClsConnection();
ClsJournalVouchersDAO journalVouchersDAO= new ClsJournalVouchersDAO();
Connection conn=null;	
int lbrAcc=0;
int partsAcc=0;
int garrageAcc=0;
String mainUp="";
int Vahname=6;
Double crate=0.00;

	String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
	String garragename=request.getParameter("garragename")==null?"0":request.getParameter("garragename");
	String garrageid=request.getParameter("garrageid")==null?"0":request.getParameter("garrageid");
	
	try{
	conn=viewDAO.getMyConnection();   
	 mainUp="MWO-"+garragename;
	 
	 
	 int  mtfleetno=0;
	 
	 int vocno=0;
	 
	 java.sql.Date sqlStartDate=null;
	 Double lbrtotalcost=0.0;
	 Double partstotalcost=0.0;
	 
		
	 Statement stmtmaint= conn.createStatement();
	
	 String sqls="select sum(labcost) labcost,sum(partcost) partcost from gl_vcostd where rdocno='"+docno+"'";
	 
	 ResultSet rs=stmtmaint.executeQuery(sqls);

	 
	 if(rs.next())
	 {
		 lbrtotalcost=rs.getDouble("labcost");
		 partstotalcost=rs.getDouble("partcost");
		 
	 }
	 
	 
 String sqlss="select date,voc_no,fleetno from gl_vmcostm where doc_no='"+docno+"'";
	 
	 ResultSet rs1=stmtmaint.executeQuery(sqlss);

	 
	 if(rs1.next())
	 {
		 vocno=rs1.getInt("voc_no");
		 mtfleetno=rs1.getInt("fleetno");
		 sqlStartDate=rs1.getDate("date");
		 
	 }
	 


		Double totalval=lbrtotalcost+partstotalcost;
		


		 if(totalval>0)
		 {
         
         String selectsql="select acno from my_account where codeno='maintlab'";
		 ResultSet resSet7 = stmtmaint.executeQuery(selectsql);
		     while (resSet7.next()) {
		    	 lbrAcc = resSet7.getInt("acno");
		         }
		     String selectsql2="select acno from my_account where codeno='maintsp'";
			 ResultSet resSet8 = stmtmaint.executeQuery(selectsql2);
			     while (resSet8.next()) {
			    	 partsAcc = resSet8.getInt("acno");
			            }
			     String selectsql3="select acc_no from gl_garrage where doc_no='"+garrageid+"'";
	 
			     
				 ResultSet resSet9 = stmtmaint.executeQuery(selectsql3);
				     while (resSet9.next()) {
				    	 garrageAcc = resSet9.getInt("acc_no");
				         }
				     String selectsql5="select c_rate  from my_curr where doc_no="+session.getAttribute("CURRENCYID").toString();
					 ResultSet resSet2 = stmtmaint.executeQuery(selectsql5);
					     while (resSet2.next()) {
					    	 crate = resSet2.getDouble("c_rate");
					              }
				
			
				ArrayList<String> labarray= new ArrayList<String>();
				//System.out.println("------lbrtotalcost--"+lbrtotalcost);
				if(lbrtotalcost>0)
				{
				labarray.add(lbrAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+lbrtotalcost
						+"::"+lbrtotalcost*crate+"::"+"1"+"::"+"1"+"::"+Vahname+"::"+mtfleetno+"::");
				
				}
				//System.out.println("------partstotalcost--"+partstotalcost);
				if(partstotalcost>0)
				{
				labarray.add(partsAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+partstotalcost
						+"::"+partstotalcost*crate+"::"+"1"+"::"+"1"+"::"+Vahname+"::"+mtfleetno+"::");
				//System.out.println("------partstotalcostasss--"+partstotalcost);
				}
				//System.out.println("------totalval--"+totalval);	
				 labarray.add(garrageAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+totalval*-1
							+"::"+totalval*crate*-1+"::"+"1"+"::"+"-1"+"::0::0::");
				
				//System.out.println("------------"+labarray);
		
			Double garrageval=totalval*-1;
			
			
			//System.out.println("------1------");
			

		int jvmdoc=journalVouchersDAO.insert(sqlStartDate,"MWO","MWO"+vocno,mainUp,garrageval,totalval,labarray,session,request);
		

		
		
		int trno=Integer.parseInt(request.getAttribute("tranno").toString());
		String upsql="update gl_vmcostm set trno="+trno+" where doc_no="+docno;
		stmtmaint.executeUpdate(upsql);
		 
		 String upsqls1="update my_jvma set status=7 where tr_no='"+trno+"'";
		  stmtmaint.executeUpdate(upsqls1);
		  
			 String upsqls2="update my_jvtran set status=7  where tr_no='"+trno+"'";
			  stmtmaint.executeUpdate(upsqls2);
	
			
		response.getWriter().print(trno);
		 
		conn.close(); 
		stmtmaint.close();
		 
	conn.close();
		 }
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    }
	 	
	 	
	 	
%>



