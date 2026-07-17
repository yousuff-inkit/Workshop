package com.operations.vehicletransactions.maintenanceupdate;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;



public class ClsmaintenanceDAO {
	ClsJournalVouchersDAO journalVouchersDAO= new ClsJournalVouchersDAO();
	ClsConnection connDAO=new ClsConnection(); 
	
	ClsCommon commDAO=new ClsCommon();
	
	Connection conn;	
	int lbrAcc;
	int partsAcc;
	int garrageAcc;
	String mainUp="maintenanceupdate";
	int Vahname=6;
	Double crate;
	
	//@SuppressWarnings("unused")
	public int insert(String invdateval,String garragename,int invno,Date sqlInvDate,Date sqlStartDate, String mtfleetno, String mtremark,
			String maintype, String currkm, String nextserdue,
			String garrageid, Double lbrtotalcost, Double partstotalcost,
			Double totalcost, HttpSession session, String mode,
			String formdetailcode,ArrayList<String> mainarray,ArrayList<String> servicearray,HttpServletRequest request) throws SQLException {
	
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtmaint= conn.prepareCall("{call maintUpdateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtmaint.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtmaint.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtmaint.setDate(1,sqlStartDate);
			stmtmaint.setString(2,mtfleetno);
			stmtmaint.setString(3,mtremark);
			stmtmaint.setString(4,maintype);
			stmtmaint.setString(5,currkm);
			stmtmaint.setString(6,nextserdue=="null"?"0":nextserdue);
			stmtmaint.setString(7,garrageid);
			stmtmaint.setDouble(8,lbrtotalcost==null?0.00:lbrtotalcost);
			stmtmaint.setDouble(9,partstotalcost==null?0.00:partstotalcost);
			stmtmaint.setDouble(10,totalcost==null?0.00:totalcost);
			stmtmaint.setString(11,formdetailcode);
			stmtmaint.setString(12,session.getAttribute("USERID").toString());
			stmtmaint.setString(13,session.getAttribute("BRANCHID").toString());
			stmtmaint.setString(15,mode);
			stmtmaint.executeQuery();
			int doc=stmtmaint.getInt("docNo");
			int vocno=stmtmaint.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(doc<=0){
				conn.close();
				return 0;
				
			      }
			String upsqldate="update gl_vmcostm set invno='"+invno+"',invdate='"+sqlInvDate+"' where doc_no="+doc;
			//System.out.println("-----------"+upsql);
			 int resup12 = stmtmaint.executeUpdate(upsqldate);
			 if(resup12<=0)
				{
					
					conn.close();
					return 0;
				}
			
			 mainUp="MRU-"+""+invno+""+":-Dated :- "+invdateval+""+":-"+garragename+"";  
			for(int i=0;i< mainarray.size();i++){
				int clear;
			     String[] maingridarray=mainarray.get(i).split("::");
			  
			
			    if(maingridarray[1].trim().equalsIgnoreCase("true"))
					{
			    	
			    	
					 clear=1;	
					}
					else {
				     clear=0;
					}
			    
			     if(clear==1)
			     {
			    	// System.out.println("time"+maingridarray[4]); 
				     String sql1="INSERT INTO gl_vmcostdet(rowno,cldate,cleared,clremarks,refno,cltime,rdocno)VALUES"
				  	           + " ("+(i+1)+","
						       + "'"+(maingridarray[0].trim().equalsIgnoreCase("undefined") || maingridarray[0].trim().equalsIgnoreCase("null")|| maingridarray[0].trim().equalsIgnoreCase("NaN")||maingridarray[0].trim().equalsIgnoreCase("")|| maingridarray[0].isEmpty()?0:commDAO.changeStringtoSqlDate(maingridarray[0].trim()))+"',"
						       + ""+clear+","
						       + "'"+(maingridarray[2].trim().equalsIgnoreCase("undefined") || maingridarray[2].trim().equalsIgnoreCase("null") || maingridarray[2].trim().equalsIgnoreCase("NaN")||maingridarray[2].trim().equalsIgnoreCase("")|| maingridarray[2].isEmpty()?0:maingridarray[2].trim())+"',"
						       + "'"+(maingridarray[3].trim().equalsIgnoreCase("undefined") || maingridarray[3].trim().equalsIgnoreCase("null")|| maingridarray[3].trim().equalsIgnoreCase("NaN")||maingridarray[3].trim().equalsIgnoreCase("")|| maingridarray[3].isEmpty()?0:maingridarray[3].trim())+"',"
						        + "'"+(maingridarray[4].trim().equalsIgnoreCase("undefined") || maingridarray[4].trim().equalsIgnoreCase("null")|| maingridarray[4].trim().equalsIgnoreCase("NaN")||maingridarray[4].trim().equalsIgnoreCase("")|| maingridarray[4].isEmpty()?0:maingridarray[4].trim())+"',"
						       +"'"+doc+"')";
				     int resultSet2 = stmtmaint.executeUpdate(sql1);
				              if(resultSet2<=0)
				                   {
				                       return 0;
			                       }
			    	 
			    	  String sql="update gl_vinspd  set cldate='"+(maingridarray[0].trim().equalsIgnoreCase("undefined") || maingridarray[0].trim().equalsIgnoreCase("NaN")||maingridarray[0].trim().equalsIgnoreCase("")|| maingridarray[0].isEmpty()?0:commDAO.changeStringtoSqlDate(maingridarray[0].trim()))+"',"
				       + "clstatus="+clear+","
				        + "cltime='"+(maingridarray[4].trim().equalsIgnoreCase("undefined") || maingridarray[4].trim().equalsIgnoreCase("null")|| maingridarray[4].trim().equalsIgnoreCase("NaN")||maingridarray[4].trim().equalsIgnoreCase("")|| maingridarray[4].isEmpty()?0:maingridarray[4].trim())+"',"
				       + "cldocno='"+doc+"',"
				       + "cldtype='"+formdetailcode+"'  where srno='"+(maingridarray[3].trim().equalsIgnoreCase("undefined") || maingridarray[3].trim().equalsIgnoreCase("null")|| maingridarray[3].trim().equalsIgnoreCase("NaN")|| maingridarray[3].trim().equalsIgnoreCase("")|| maingridarray[3].isEmpty()?0:maingridarray[3].trim())+"'";
		
				     int resultSet3 = stmtmaint.executeUpdate(sql);
				if(resultSet3<=0)
				{
					conn.close(); 
				 return 0;
			     }
				
			}
			}
			
			for(int i=0;i<servicearray.size();i++){
				
			     String[] serarray=servicearray.get(i).split("::");  
			     if(!(serarray[1].trim().equalsIgnoreCase("undefined")|| serarray[1].trim().equalsIgnoreCase("null")|| serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()))
			     {
			     String sql2="INSERT INTO gl_vcostd(rowno,type,repdesc,remarks,labcost,partcost,total,rdocno,status)VALUES"
			  	           + " ("+(i+1)+","
					       + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"',"
					       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
					       + "'"+(serarray[2].trim().equalsIgnoreCase("undefined") || serarray[2].trim().equalsIgnoreCase("null")|| serarray[2].trim().equalsIgnoreCase("NaN")||serarray[2].trim().equalsIgnoreCase("")|| serarray[2].isEmpty()?0:serarray[2].trim())+"',"
					       + "'"+(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null")|| serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?0:serarray[3].trim())+"',"
					       + "'"+(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null")|| serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?0:serarray[4].trim())+"',"
					       + "'"+(serarray[5].trim().equalsIgnoreCase("undefined") || serarray[5].trim().equalsIgnoreCase("null")|| serarray[5].trim().equalsIgnoreCase("NaN")||serarray[5].trim().equalsIgnoreCase("")|| serarray[5].isEmpty()?0:serarray[5].trim())+"',"
					       +"'"+doc+"',3)";
			    // System.out.println("--------------------------------"+sql2);
			     int resultSet4 = stmtmaint.executeUpdate(sql2);
			     if(resultSet4<=0)
                 {
			    	 conn.close();
                     return 0;
                    }
			     
			}      
			}
			Double totalval=lbrtotalcost+partstotalcost;
			
				request.setAttribute("forchk", "0"); // if down grid not saved;
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
								+"::"+totalval*crate*-1+"::"+"1"+"::"+"-1"+":::::: ");
					
					//System.out.println("------------"+labarray);
			
				Double garrageval=totalval*-1;
				
	
			int jvmdoc=journalVouchersDAO.insert(sqlStartDate,formdetailcode,formdetailcode+vocno,mainUp,garrageval,totalval,labarray,session,request);
			
			if(jvmdoc<=0)
			{
				
				conn.close();
				return 0;
			}
			
			
			request.setAttribute("jvmdocno", jvmdoc);
			request.setAttribute("forchk", "1");
		
		
		
		int trno=(int) request.getAttribute("tranno");
		String upsql="update gl_vmcostm set trno="+trno+" where doc_no="+doc;
		//System.out.println("-----------"+upsql);
		 int resup1 = stmtmaint.executeUpdate(upsql);
		 if(resup1<=0)
			{
				
				conn.close();
				return 0;
			}
			 }
			if (doc > 0) {
				conn.commit();
				stmtmaint.close();
				conn.close();
				return doc;
			}
			
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }

	public boolean edit(int vocno,String invdateval,String garragename,int invno,Date sqlInvDate,int docno, Date sqlStartDate, String mtfleetno,
			String mtremark, String maintype, String currkm, String nextserdue,
			String garrageid, Double lbrtotalcost, Double partstotalcost,
			Double totalcost, HttpSession session, String mode,
			String formdetailcode,ArrayList<String> mainarray,ArrayList<String> servicearray,int tranno,int jvmdoc,HttpServletRequest request) throws SQLException {
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtmaint= conn.prepareCall("{call maintUpdateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtmaint.setDate(1,sqlStartDate);
			stmtmaint.setString(2,mtfleetno);
			stmtmaint.setString(3,mtremark);
			stmtmaint.setString(4,maintype);
			stmtmaint.setString(5,currkm);
			stmtmaint.setString(6,nextserdue=="null"?"0":nextserdue);
			stmtmaint.setString(7,garrageid);
			stmtmaint.setDouble(8,lbrtotalcost==null?0.00:lbrtotalcost);
			stmtmaint.setDouble(9,partstotalcost==null?0.00:partstotalcost);
			stmtmaint.setDouble(10,totalcost==null?0.00:totalcost);
			stmtmaint.setString(11,formdetailcode);
			stmtmaint.setString(12,session.getAttribute("USERID").toString());
			stmtmaint.setString(13,session.getAttribute("BRANCHID").toString());
			stmtmaint.setInt(14,docno);
			stmtmaint.setString(15,mode);
			stmtmaint.setInt(16,0);
			//System.out.println("----------"+stmtmaint);
			int aaa=stmtmaint.executeUpdate();
			//docno=stmtmaint.getInt("docNo");
					
			
             if(aaa<=0){
            	 conn.close();
				return false;
				
			      }
             String upsqldate="update gl_vmcostm set invno='"+invno+"',invdate='"+sqlInvDate+"' where doc_no="+docno;
  			//System.out.println("-----------"+upsql);
  			 int resup12 = stmtmaint.executeUpdate(upsqldate);
  			 if(resup12<=0)
  				{
  					
  					conn.close();
  					return false;
  				}
  			 mainUp="MRU-"+""+invno+""+":-Dated :- "+invdateval+""+":-"+garragename+"";  
             String delsql="Delete from gl_vmcostdet where rdocno="+docno+" ";
             stmtmaint.executeUpdate(delsql);
             
             String delsql1="Delete from gl_vcostd where rdocno="+docno+" ";
             stmtmaint.executeUpdate(delsql1);
             
			for(int i=0;i< mainarray.size();i++){
				int clear;
			     String[] maingridarray=mainarray.get(i).split("::");
			
			    if(maingridarray[1].trim().equalsIgnoreCase("true"))
					{
					 clear=1;	
					}
					else {
				     clear=0;
					}
			    
			     if(clear==1)  
			     {
			    	 String sql1="INSERT INTO gl_vmcostdet(rowno,cldate,cleared,clremarks,refno,cltime,rdocno)VALUES"
				  	           + " ("+(i+1)+","
						       + "'"+(maingridarray[0].trim().equalsIgnoreCase("undefined") || maingridarray[0].trim().equalsIgnoreCase("null")|| maingridarray[0].trim().equalsIgnoreCase("NaN")||maingridarray[0].trim().equalsIgnoreCase("")|| maingridarray[0].isEmpty()?0:commDAO.changeStringtoSqlDate(maingridarray[0].trim()))+"',"
						       + ""+clear+","
						       + "'"+(maingridarray[2].trim().equalsIgnoreCase("undefined") || maingridarray[2].trim().equalsIgnoreCase("null") || maingridarray[2].trim().equalsIgnoreCase("NaN")||maingridarray[2].trim().equalsIgnoreCase("")|| maingridarray[2].isEmpty()?0:maingridarray[2].trim())+"',"
						       + "'"+(maingridarray[3].trim().equalsIgnoreCase("undefined") || maingridarray[3].trim().equalsIgnoreCase("null")|| maingridarray[3].trim().equalsIgnoreCase("NaN")||maingridarray[3].trim().equalsIgnoreCase("")|| maingridarray[3].isEmpty()?0:maingridarray[3].trim())+"',"
						        + "'"+(maingridarray[4].trim().equalsIgnoreCase("undefined") || maingridarray[4].trim().equalsIgnoreCase("null")|| maingridarray[4].trim().equalsIgnoreCase("NaN")||maingridarray[4].trim().equalsIgnoreCase("")|| maingridarray[4].isEmpty()?0:maingridarray[4].trim())+"',"
						       +"'"+docno+"')";
				     int resultSet2 = stmtmaint.executeUpdate(sql1);
				              if(resultSet2<=0)
				                   {
				            	      conn.close();
				                       return false;
			                          }
			    	 
				              String sql="update gl_vinspd  set cldate='"+(maingridarray[0].trim().equalsIgnoreCase("undefined") || maingridarray[0].trim().equalsIgnoreCase("NaN")||maingridarray[0].trim().equalsIgnoreCase("")|| maingridarray[0].isEmpty()?0:commDAO.changeStringtoSqlDate(maingridarray[0].trim()))+"',"
								       + "clstatus="+clear+","
								        + "cltime='"+(maingridarray[4].trim().equalsIgnoreCase("undefined") || maingridarray[4].trim().equalsIgnoreCase("null")|| maingridarray[4].trim().equalsIgnoreCase("NaN")||maingridarray[4].trim().equalsIgnoreCase("")|| maingridarray[4].isEmpty()?0:maingridarray[4].trim())+"',"
								       + "cldocno='"+docno+"',"
								       + "cldtype='"+formdetailcode+"'  where srno='"+(maingridarray[3].trim().equalsIgnoreCase("undefined") || maingridarray[3].trim().equalsIgnoreCase("null")|| maingridarray[3].trim().equalsIgnoreCase("NaN")|| maingridarray[3].trim().equalsIgnoreCase("")|| maingridarray[3].isEmpty()?0:maingridarray[3].trim())+"'";
						
				     int resultSet3 = stmtmaint.executeUpdate(sql);
				if(resultSet3<=0)
				{
					conn.close();
				 return false;
			     }
				
			}
			}
			
			for(int i=0;i< servicearray.size();i++){
				
			     String[] serarray=servicearray.get(i).split("::");  
			     if(!(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null")|| serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()))
			     {
			    	 String sql2="INSERT INTO gl_vcostd(rowno,type,repdesc,remarks,labcost,partcost,total,rdocno,status)VALUES"
				  	           + " ("+(i+1)+","
						       + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"',"
						       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
						       + "'"+(serarray[2].trim().equalsIgnoreCase("undefined") || serarray[2].trim().equalsIgnoreCase("null")|| serarray[2].trim().equalsIgnoreCase("NaN")||serarray[2].trim().equalsIgnoreCase("")|| serarray[2].isEmpty()?0:serarray[2].trim())+"',"
						       + "'"+(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null")|| serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?0:serarray[3].trim())+"',"
						       + "'"+(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null")|| serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?0:serarray[4].trim())+"',"
						       + "'"+(serarray[5].trim().equalsIgnoreCase("undefined") || serarray[5].trim().equalsIgnoreCase("null")|| serarray[5].trim().equalsIgnoreCase("NaN")||serarray[5].trim().equalsIgnoreCase("")|| serarray[5].isEmpty()?0:serarray[5].trim())+"',"
						       +"'"+docno+"',3)";
			
			     int resultSet4 = stmtmaint.executeUpdate(sql2);
			     if(resultSet4<=0)
                 {
			    	 conn.close();
                     return  false;
                 }
			     
			}      
		    }
			
			 Double totalval=lbrtotalcost+partstotalcost;
			 request.setAttribute("forchk", "0");
			 if(totalval>0)
			 {
			if(tranno==0)
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
						
					 if(lbrtotalcost>0)
						{
						labarray.add(lbrAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+lbrtotalcost
								+"::"+lbrtotalcost*crate+"::"+"1"+"::"+"1"+"::"+Vahname+"::"+mtfleetno+"::");
						
						}
					 if(partstotalcost>0)
						{	
						labarray.add(partsAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+partstotalcost
								+"::"+partstotalcost*crate+"::"+"1"+"::"+"1"+"::"+Vahname+"::"+mtfleetno+"::");
						
						}
							
						 labarray.add(garrageAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+totalval*-1
									+"::"+totalval*crate*-1+"::"+"1"+"::"+"-1"+":::::: ");
						
						 
						 
						
					
				
					Double garrageval=totalval*-1;
					
					
				
				int jvmdoc1=journalVouchersDAO.insert(sqlStartDate,formdetailcode,formdetailcode+vocno,mainUp,garrageval,totalval,labarray,session,request);
				
			if(jvmdoc1<=0)
				{
					
					conn.close();
					return false;
				}
				
				
				request.setAttribute("jvmdocno", jvmdoc1);
				request.setAttribute("forchk", "1");
			
			
			
			int trno=(int) request.getAttribute("tranno");
			String upsql="update gl_vmcostm set trno="+trno+" where doc_no="+docno;
			//System.out.println("-----------"+upsql);
			 int resup1 = stmtmaint.executeUpdate(upsql);
			 if(resup1<=0)
				{
					
					conn.close();
					return false;
				}	 
			}
			if(tranno>0)
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
					
						 if(lbrtotalcost>0)
							{
					labarray.add(lbrAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+lbrtotalcost
							+"::"+lbrtotalcost*crate+"::"+"1"+"::"+"1"+"::"+Vahname+"::"+mtfleetno+"::");
					
							}
							if(partstotalcost>0)
							{
					labarray.add(partsAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+partstotalcost
							+"::"+partstotalcost*crate+"::"+"1"+"::"+"1"+"::"+Vahname+"::"+mtfleetno+"::");
					
							}
					 labarray.add(garrageAcc+"::"+mainUp+"::"+session.getAttribute("CURRENCYID").toString()+"::"+crate+"::"+totalval*-1
								+"::"+totalval*crate*-1+"::"+"1"+"::"+"-1"+":::::: ");
					
					
					
				Double garrageval=totalval*-1;
				
				//boolean Status=journalVouchersDAO.edit(getTxtjournalvouchersdocno(), getFormdetailcode(),journalVouchersDate, getTxtrefno(), getTxtdescription(), getTxttrno(), getTxtdrtotal(), getTxtcrtotal(),journalvouchersarray,session);	
				boolean Status=journalVouchersDAO.edit(jvmdoc,formdetailcode,sqlStartDate,formdetailcode+vocno,mainUp,tranno,garrageval,totalval,labarray,session);
			
				//System.out.println("------Status------"+Status);
				
				if(Status==false)
			 {
					conn.close();
					 return false;
			 }
			 }
			 }
		if (aaa > 0) {
			conn.commit();
			stmtmaint.close();
			conn.close();
			System.out.println("Sucess");
			return true;
		}	
	     }catch(Exception e){
	    	 e.printStackTrace();
		conn.close();
	   }
	   return false;
}
	public boolean delete(int docno, HttpSession session, String mode,
			String formdetailcode,int tranno,int jvmdoc) throws SQLException {
		
			try{
				conn=connDAO.getMyConnection();
				CallableStatement stmtmaint= conn.prepareCall("{call maintUpdateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtmaint.setDate(1,null);
				stmtmaint.setString(2,null);
				stmtmaint.setString(3,null);
				stmtmaint.setString(4,null);
				stmtmaint.setString(5,null);
				stmtmaint.setString(6,null);
				stmtmaint.setString(7,null);
				stmtmaint.setDouble(8,0.0);
				stmtmaint.setDouble(9,0.0);
				stmtmaint.setDouble(10,0.0);
				stmtmaint.setString(11,formdetailcode);
				stmtmaint.setString(12,session.getAttribute("USERID").toString());
				stmtmaint.setString(13,session.getAttribute("BRANCHID").toString());
				stmtmaint.setInt(14,docno);
				stmtmaint.setString(15,mode);
				stmtmaint.setInt(16,0);
			
			int aaa=stmtmaint.executeUpdate();
			if(aaa<=0)
			{
				conn.close();
				return false;
			}
			
			if(tranno>0)
			{
			boolean Status=journalVouchersDAO.delete(jvmdoc,formdetailcode,tranno,session);
			if(Status==false)
			 {
					conn.close();
					 return false;
			 }
			}

			
			
			if (aaa > 0) {
				
				stmtmaint.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}	
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
	
	
	public   JSONArray searchfleet(HttpSession session ,String fleetno, String regno,String flname,String color,String group,String aa) throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	   	    Enumeration<String> Enumeration = session.getAttributeNames();
	   	    int a=0;
	   	    while(Enumeration.hasMoreElements()){
	   	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	   	      a=1;
	   	     }
	   	    }
	   	    if(a==0){
	   	  return RESULTDATA;
	   	     }
	   	        
	   	 String sqltest="";
	    	
	    	if((!(fleetno.equalsIgnoreCase(""))) && (!(fleetno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and veh.fleet_no like '%"+fleetno+"%'";
	    	}
	    	if((!(regno.equalsIgnoreCase(""))) && (!(regno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'  ";
	    	}
	    	if((!(flname.equalsIgnoreCase(""))) && (!(flname.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and veh.FLNAME like '%"+flname+"%'";
	    	}
	    	if((!(color.equalsIgnoreCase(""))) && (!(color.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and c.color like '%"+color+"%'";
	    	}
	    	if((!(group.equalsIgnoreCase(""))) && (!(group.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and g.gname like '%"+group+"%'";
	    	}
	     	
	        String brcid=session.getAttribute("BRANCHID").toString();
	    	//
	        Connection conn = null;
       
		try {
				 conn = connDAO.getMyConnection();
					if(aa.equalsIgnoreCase("yes"))
					{
						
						
						Statement stmt=conn.createStatement();
						String brsql="";
						int method=0;
						String sqlss="select method from gl_config where field_nme='mrufleetchk'";
						ResultSet rss=stmt.executeQuery(sqlss);
						
						if(rss.next())
						{
							method=rss.getInt("method");
							
						}
						
						if(method==1)
						{
							brsql = "and veh.a_br='"+brcid+"' ";
						}
						
						
					
				Statement stmtVeh = conn.createStatement ();
            
				/*String sqls=("select distinct(rfleet),veh.flname,veh.reg_no,c.color,g.gname from gl_vinspm m inner join gl_vinspd d on (m.doc_no=d.rdocno)  "
						+ " left join gl_vehmaster veh on (veh.fleet_no=m.rfleet) left join my_color c on veh.clrid=c.doc_no "
						+ " left join gl_vehgroup g on g.doc_no=veh.vgrpid where d.clstatus=0 and m.status<>7 and m.brhid='"+brcid+"' "+sqltest);*/
				
				String sqls=("select veh.fleet_no rfleet,veh.flname,veh.reg_no,c.color,g.gname from gl_vehmaster veh  left join my_color c on veh.clrid=c.doc_no "
						+ " left join gl_vehgroup g on g.doc_no=veh.vgrpid where veh.statu=3 "+brsql+" "+sqltest);
				
				System.out.println("-----sqls------"+sqls);
				
				ResultSet resultSet = stmtVeh.executeQuery (sqls);
				
				
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh.close();
					}
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public   JSONArray searchgarrage() throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	/*   	    Enumeration<String> Enumeration = session.getAttributeNames();
	   	    int a=0;
	   	    while(Enumeration.hasMoreElements()){
	   	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	   	      a=1;
	   	     }
	   	    }
	   	    if(a==0){
	   	  return RESULTDATA;
	   	     }
	   	        
	    	    	
	        String brcid=session.getAttribute("BRANCHID").toString();
	    	//
       */
	        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
           	
				ResultSet resultSet = stmtVeh.executeQuery ("select doc_no,name from gl_garrage where status<>7");

				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
       return RESULTDATA;
   }
	public   JSONArray searchservicetype() throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	        
	   	Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
           	
				ResultSet resultSet = stmtVeh.executeQuery ("select distinct mtype from gl_vrepm where status=3;");

				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
       return RESULTDATA;
   }
public   JSONArray searchserdesc(String type) throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	   	   
	   	        
	    	    	  	//
      
	   	Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
          	
				ResultSet resultSet = stmtVeh.executeQuery ("select docno,name from gl_vrepm where mtype='"+type+"';");

				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
      return RESULTDATA;
  }
	
	public   JSONArray searchMaster(HttpSession session) throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	   	    Enumeration<String> Enumeration = session.getAttributeNames();
	   	    int a=0;
	   	    while(Enumeration.hasMoreElements()){
	   	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	   	      a=1;
	   	     }
	   	    }
	   	    if(a==0){
	   	  return RESULTDATA;
	   	     }
	   	        
	    	    	
	        String brcid=session.getAttribute("BRANCHID").toString();
	    	//
       
	        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection(); 
				Statement stmtVeh = conn.createStatement (); 
           	
				String sql= ("select  m.invno,m.invdate,m.voc_no vocno,m.doc_no masterdoc, m.date, m.fleetno, m.mtype ,v.reg_no, "
						+ "round(m.currkm) currkm,round(m.serduekm) serduekm,m.trno, m.gargid,m.remarks,m.status,m.tlabcost,m.tpartcost,m.tcost, "
						+ "		v.flname,g.name,j.doc_no jvmdoc from gl_vmcostm m left join gl_vehmaster v on v.fleet_no=m.fleetno left join  gl_garrage g "
						+ "        on g.doc_no=m.gargid left join my_jvma j on j.tr_no=m.trno  where m.brhid='"+brcid+"' and m.status<>7");
//System.out.println("------------"+sql);
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
       return RESULTDATA;
   }
	
	public   JSONArray searchfleetgridrelode(String Fleetno) throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	   	   
       
	   	Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
           	
			
			String fleetsql=("select d.srno,d.remarks,if(d.dm=1,'M','D') as maintype,m.date, DATE_FORMAT(m.date,'%d.%m.%Y') AS "
					+ "	hidrefdate,dm.name description from gl_vinspm m inner join gl_vinspd d on (m.doc_no=d.rdocno)  "
					+ "inner join gl_damage dm on (dm.doc_no=d.dmid)  where d.clstatus=0 and m.rfleet='"+Fleetno+"';");
			//System.out.println("========"+fleetsql);
			ResultSet resultSet = stmtVeh.executeQuery (fleetsql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
       return RESULTDATA;
   }






public   JSONArray searchmaingridrelode(String maindoc) throws SQLException {

  	 JSONArray RESULTDATA=new JSONArray();
  	   
  	Connection conn = null;
 
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
      	
			
		String mainsql=("select d.srno,d.remarks,if(d.dm=1,'M','D') as maintype,m.date,DATE_FORMAT(m.date,'%d.%m.%Y') AS hidrefdate "
				+ ",dm.name description,vm.clremarks,vm.cleared clear,vm.cldate,vm.cltime,vm.cltime hidcltime,DATE_FORMAT(vm.cldate,'%d.%m.%Y') AS hidcldate "
				+ " from gl_vinspm m inner join gl_vinspd d on (m.doc_no=d.rdocno) "
				+ "inner join gl_damage dm on (dm.doc_no=d.dmid) inner join gl_vmcostdet vm on (vm.refno=d.srno) where  vm.rdocno='"+maindoc+"'");
	
		ResultSet resultSet = stmtVeh.executeQuery (mainsql);
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
  return RESULTDATA;
}
public   JSONArray searchservicegridrelode(String maindoc1) throws SQLException {

 	 JSONArray RESULTDATA=new JSONArray();
 	   
 	Connection conn = null;

	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
     	
		
		String fleetsql=("select type,repdesc description,labcost lbrcost,partcost partscost,total,remarks from gl_vcostd  where rdocno='"+maindoc1+"'");
		//System.out.println("========"+fleetsql);
		ResultSet resultSet = stmtVeh.executeQuery (fleetsql);
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
 return RESULTDATA;
}









public   ClsmaintenanceBean getPrint(int docno, HttpServletRequest request) throws SQLException {
	ClsmaintenanceBean bean = new ClsmaintenanceBean();
	  Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtprint = conn.createStatement ();
      	
			String resql=("select v.reg_no, m.voc_no, DATE_FORMAT(m.date,'%d-%m-%Y') date, m.fleetno, ucase(m.mtype) mtype, "
					+ "round(m.currkm) currkm,coalesce(round(m.serduekm),'') serduekm,m.trno, m.gargid,m.remarks,m.status,round(m.tlabcost,2) tlabcost,round(m.tpartcost,2) tpartcost,round(m.tcost,2) tcost, "
					+ "v.flname,g.name garname from gl_vmcostm m left join gl_vehmaster v on v.fleet_no=m.fleetno left join  gl_garrage g on g.doc_no=m.gargid  "
					+ " where m.doc_no="+docno+" ");
			
			ResultSet pintrs = stmtprint.executeQuery(resql);
			
		     
		       while(pintrs.next()){
		    	   // cldatails
		    	   
		    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
		    	   
		    	   
		    	   bean.setLblgarage(pintrs.getString("garname"));
		    	    bean.setLblfleetno(pintrs.getString("fleetno"));
		    	    bean.setLblfleetname(pintrs.getString("flname"));
		    	    bean.setLblservtype(pintrs.getString("mtype"));
		    	    bean.setLblcurrkm(pintrs.getString("currkm"));
		    	    //upper
		    	    bean.setLblnextserkm(pintrs.getString("serduekm"));
		    	    bean.setLbldate(pintrs.getString("date"));
		    	    bean.setDocvals(pintrs.getInt("voc_no"));
		    	    
		    	    bean.setLblnettotallabour(pintrs.getString("tlabcost"));
		    	    bean.setLblnettotalparts(pintrs.getString("tpartcost"));
		    	    bean.setLblnettotalamount(pintrs.getString("tcost"));
		    	    bean.setLblreg_no(pintrs.getString("reg_no"));
		    	  //  getLblreg_no()
		    	      
		    	    
		       }
			

			stmtprint.close();
			
			
			
			 Statement stmtinvoice10 = conn.createStatement ();
			    /*String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_vmcostm r  "
			    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
			    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";
*/  String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_vmcostm r inner join my_brch b on  "
		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
//System.out.println("--------"+companysql);

		         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
			       
			       while(resultsetcompany.next()){
			    	   
			    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
			    	   bean.setLblcompname(resultsetcompany.getString("company"));
			    	  
			    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
			    	 
			    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
			    	  
			    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
			    	   bean.setLbllocation(resultsetcompany.getString("location"));
			    	  
			    	 
			    	   
			       } 
			       stmtinvoice10.close();
			       ArrayList<String> arr=new ArrayList<String>();
					Statement stmtinvoice2 = conn.createStatement ();
				
					String strSqldetail="select type,repdesc description,round(labcost,2) lbrcost,round(partcost,2) partscost,round(total,2) total,remarks from gl_vcostd   where  rdocno="+docno+" ";
				
		
				ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
				
				int rowcount=1;
		
				while(rsdetail.next()){
					  bean.setFirstarray(1); 
						String temp="";
						String spci="";
				
						if(rsdetail.getString("remarks").equalsIgnoreCase("0"))
						{
							spci="";
						}
						else
						{
							spci=rsdetail.getString("remarks");
						}
						temp=rowcount+"::"+rsdetail.getString("type")+"::"+rsdetail.getString("description")+"::"+spci+"::"+rsdetail.getString("lbrcost")+"::"+rsdetail.getString("partscost")+"::"+rsdetail.getString("total") ;
	
						arr.add(temp);
						rowcount++;
		
				
					
			              }
				stmtinvoice2.close();  
				request.setAttribute("details",arr); 
			
			conn.close();



			
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	return bean;
	

}
	/*public  ArrayList<String> getPrintdetails(int docno) {
		ArrayList<String> arr=new ArrayList<String>();
		try {
			Connection conn = connDAO.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";
		strSqldetail="select eq.sr_no,eq.spec,if(eq.unit>0,round(eq.unit),'') unit,DATE_FORMAT(frmdate,'%d.%m.%Y') AS fromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS todate, "
				+ "if(eq.rtype='0','',eq.rtype) rtype,vb.brand_name brand,coalesce(vm.vtype,'') model,coalesce(vc.color,'') color     FROM gl_enqd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
				+ "	  left join gl_vehmodel vm on vm.doc_no=eq.MODID   left join my_color vc on vc.doc_no=eq.clrid  where rdocno="+docno+" ";
		

		ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);
		
		int rowcount=1;

		while(rsdetail.next()){

				String temp="";
				String spci="";
				if(rsdetail.getString("spec").equalsIgnoreCase("0"))
				{
					spci="";
				}
				else
				{
					spci=rsdetail.getString("spec");
				}
				temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("fromdate")+"::"+rsdetail.getString("todate")+"::"+rsdetail.getString("unit") ;

				arr.add(temp);
				rowcount++;

		
			
	}
		stmtinvoice.close();
		conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return arr;
	}*/

}

