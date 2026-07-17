package com.operations.vehicleprocurement.purchase;





import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.securitycheque.ClsSecurityChequeDAO;
import com.finance.transactions.unclearedchequepayment.ClsUnclearedChequePaymentDAO;
import com.mysql.jdbc.PreparedStatement;
import com.operations.vehicleprocurement.purchaseorder.ClsvehpurchaseorderBean;



public class ClsvehpurchaseDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	Connection conn;
	ClsUnclearedChequePaymentDAO unclearedChequePayDAO= new ClsUnclearedChequePaymentDAO();	
	ClsSecurityChequeDAO securityChqDAO= new ClsSecurityChequeDAO();
	public int insert(Date sqlStartDate, Date sqlpurdeldate,Date invDate,
			String headacccode, String vehtype, String vehrefno,
			Double nettotal, String vehdesc, HttpSession session, String mode,
			String formdetailcode,ArrayList<String> descarray,String invno, HttpServletRequest request)  throws SQLException {
		if(vehrefno.equalsIgnoreCase("")|| vehrefno.equalsIgnoreCase("null") || vehrefno.equalsIgnoreCase("NA"))
		{
			vehrefno=null;
		}
		
		try{
			int docno;
			
		//	System.out.println("------branch--------"+session.getAttribute("BRANCHID").toString());
		
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtvehpurchase= conn.prepareCall("{call vahpurchaseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtvehpurchase.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtvehpurchase.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtvehpurchase.setDate(1,sqlStartDate);
			stmtvehpurchase.setString(2,headacccode);
			stmtvehpurchase.setString(3,vehtype);
			stmtvehpurchase.setString(4,vehrefno=="null"?"":vehrefno);
			stmtvehpurchase.setDouble(5,0);
			stmtvehpurchase.setString(6,vehdesc);
			stmtvehpurchase.setDate(7,sqlpurdeldate);
			stmtvehpurchase.setString(8,session.getAttribute("USERID").toString());
			stmtvehpurchase.setString(9,session.getAttribute("BRANCHID").toString());
			stmtvehpurchase.setString(10,formdetailcode);
			stmtvehpurchase.setDate(11,invDate);
			stmtvehpurchase.setString(12,invno);
			stmtvehpurchase.setString(14,mode);
			stmtvehpurchase.executeQuery();
			docno=stmtvehpurchase.getInt("docNo");
			int vocno=stmtvehpurchase.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			
			
	/*		
			int tranno=0;
			int j=0;
			int sno=0;
			
			double fdramt=0;
			double tdramt=0;
			
			String refdetails="CPU"+""+docno;
			
			String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
		
			ResultSet tass = stmtvehpurchase.executeQuery (trsql);
			
			if (tass.next()) {
		
				tranno=tass.getInt("trno");		
				
		     }
			
			request.setAttribute("trans",tranno);
			
			
			String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
			
			int dd=stmtvehpurchase.executeUpdate(trnosql);
		     
					 if(dd<=0)
						{
							conn.close();
							return 0;
							
						}*/
			
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] vehpurreqarray=descarray.get(i).split("::");
			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
			    	 
			    		if(vehtype.equalsIgnoreCase("VPO"))
				    	{
				    	
			    			
               String tempsrnos=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
			   int  tempsrno=Integer.parseInt(tempsrnos);
			   String tempvals=""+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"";
			   int  tempval=Integer.parseInt(tempvals);
			   
			   int tempqty=0;
			   int upqty=0;
			    	
			    	String sqls="select pqty from  gl_vpod  where rdocno='"+vehrefno+"' and srno='"+tempsrno+"'";
			    	ResultSet rss=stmtvehpurchase.executeQuery(sqls);
			    	if(rss.next())
			    		{
			    		
			    		tempqty=rss.getInt("pqty");
			    	     }
			    	upqty=tempqty+tempval;
			    	
			    	
			    	String sqlss="update  gl_vpod  set pqty='"+upqty+"' where rdocno='"+vehrefno+"' and srno='"+tempsrno+"'"; 
			    	     int aa=stmtvehpurchase.executeUpdate(sqlss);
			    	
			    	   /*  0     1      2        3         4     5      6      7     8       9            ;
			    	    srno,brdid,modid,specification,clrid,price,tempval,diff,chaseno,enginno; */
			    	  	 
			    	     if(aa<=0)
							{
			    	    	 
								conn.close();
								return 0;
								
							}
			    
			    	    
			    	}
			    	 
			    	 
			    	   /*  0     1      2        3         4     5      6      7     8       9            ;
			    	    srno,brdid,modid,specification,clrid,price,tempval,diff,chaseno,enginno;
			    	    
			    	    rdocno,srno,brdid,modid,spec,clrid,price,chaseno,enginno;*/
			    	 
		     String sql="INSERT INTO gl_vpurd(srno,brdid,modid,spec,clrid,price,chaseno,enginno,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
				       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
				       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
				       + "'"+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"',"
				       + "'"+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+"',"
				       +"'"+docno+"')";
		     
		     
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtvehpurchase.executeUpdate(sql);
				    
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
			     }
				     
				     }
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtvehpurchase.close();
				conn.close();			
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
	
	/*public int update(ArrayList<String> descarray, HttpServletRequest request,HttpSession session, double pricetottal,
			String venderaccount,int docno, String vendercurr, double vendorrate) throws SQLException {
	
		try
		{
		
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
		   	Statement stmt = conn.createStatement(); 	
		   	
		   	
			for(int i=0;i< descarray.size();i++){
		    	
			          String[] vehpurreqarray=descarray.get(i).split("::");
					     if(!(vehpurreqarray[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()))
					     {
					    	 
					    	 String fleetnos=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
							   int  fleetno=Integer.parseInt(fleetnos);
							   String rownos=""+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"";
							   int  rowno=Integer.parseInt(rownos);	 
					    	 
						    	
						    	String sqlss="update  gl_vpurd  set fleet_no='"+fleetno+"', flstatus=1 where rowno='"+rowno+"'"; 
						    	     int aa=stmt.executeUpdate(sqlss); 
						    	     
						    	     
						    	     if(aa<=0)
										{
											conn.close();
											return 0;
											
										}
					    	 
					     }
		               }
			     
			     
			     
					String refdetails="VPU"+""+docno;
			     
			     
			        int tranno=0;
					
					String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
				
					ResultSet tass = stmt.executeQuery (trsql);
					
					if (tass.next()) {
				
						tranno=tass.getInt("trno");		
						
				     }
					
			
							
					String confirm="";		 
							 
					for(int j=0;j<descarray.size();j++){
							    	
								 
					String[] vehpurreqarray2=descarray.get(j).split("::");
					  if(!(vehpurreqarray2[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray2[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray2[0].trim().equalsIgnoreCase("")|| vehpurreqarray2[0].isEmpty()))
						  {	 
						  
						 // System.out.println("--------1---------");
						  
						 if(j==(descarray.size()-1))
							
						{
						
							 
							//  System.out.println("--------j---------"+j);		 
							 
							 
							 
							 
								String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
								
								int dd=stmt.executeUpdate(trnosql);
							     
										 if(dd<=0)
											{
												conn.close();
												return 0;
												
											}
							 
								//System.out.println("-------1---"); 
							 
							 confirm="confirm";	
							 
							 String vendorcur=""; 
							 double venrate=0.00;
							 
							 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
								//System.out.println("-----sqls10-----"+sqls10);
							   ResultSet tass11 = stmt.executeQuery (sqls10);
							   if(tass11.next()) {
							
								   vendorcur=tass11.getString("curid");	
								   venrate=tass11.getDouble("rate");	
									
							     }
								//System.out.println("pricetottal="+pricetottal);
							 
							   double	dramount=pricetottal*-1; 
							   
								//System.out.println("dramount="+dramount);
								//System.out.println("venrate="+venrate);
							  // 
						double ldramount=dramount*venrate ; 
							
						
						
						//System.out.println("ldramount"+ldramount);
						
							
							 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							 		+ "values(curdate(),'"+refdetails+"',"+docno+",'"+venderaccount+"','Vehicle Purchase','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,0,'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
						     
							 
							//System.out.println("----sql1-------"+sql1);
							 int ss = stmt.executeUpdate(sql1);

						     if(ss<=0)
								{
									conn.close();
									return 0;
									
								}
						     
						     int acnos=0;
						     String curris="";
						     double rates=0.00;
						     
						     
						     
						   String sql2="select  acno from my_account where codeno='VEH'";
						    
						   // select  acno  from my_account where codeno='VEH';
							//System.out.println("-----sql2-----"+sql2);
							

						   ResultSet tass1 = stmt.executeQuery (sql2);
							
							if (tass1.next()) {
						
								acnos=tass1.getInt("acno");		
								
						     }
							
							
							
							 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
								//System.out.println("-----sqls3-----"+sqls3);
							   ResultSet tass3 = stmt.executeQuery (sqls3);
								
								if (tass3.next()) {
							
									curris=tass3.getString("curid");	
									rates=tass3.getDouble("rate");	
									
							     }
							 
								 
								 //  double	dramounts=pricetottal; 
								   
									//System.out.println("dramount="+dramount);
									//System.out.println("venrate="+venrate);
								  // 
							double ldramounts=pricetottal*venrate ;  
						     
							 String sql10="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								 		+ "values(curdate(),'"+refdetails+"',"+docno+",'"+acnos+"','Vehicle Purchase','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,0,'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
							     
								 
							//	System.out.println("---sql10-------"+sql10);
								 int ss1 = stmt.executeUpdate(sql10);

							     if(ss1<=0)
									{
										conn.close();
										return 0;
										
									}
						     
							

							    	String sqlsss="update  gl_vpurm  set tr_no='"+tranno+"',flcomplete=1 where doc_no='"+docno+"'"; 
							    	     int aaa=stmt.executeUpdate(sqlsss); 
							    	     
							    	     
							    	     if(aaa<=0)
											{
												conn.close();
												return 0;
												
											}
							     
			     
						
				    }  
						 
						  }
						
						 
						 
			  }
								
					if(confirm.equalsIgnoreCase("confirm"))			
					{
								
								
								for(int k=0;k<descarray.size();k++){
									
								       String[] vehpurreqarray1=descarray.get(k).split("::");
								  int accnoss=0;     
									   String sql2="select  acno from my_account where codeno='VEH'";
									    
									   // select  acno  from my_account where codeno='VEH';
										//System.out.println("-----sql2-----"+sql2);
										

									   ResultSet tass1 = stmt.executeQuery (sql2);
										
										if (tass1.next()) {
									
											accnoss=tass1.getInt("acno");		
											
									     }
										
										int assetdoc=0;
										   String sql99="select coalesce((max(doc_no)+1),1) docno from gc_assettran";
										    
										   // select  acno  from my_account where codeno='VEH';
											//System.out.println("-----sql2-----"+sql2);
											

										   ResultSet tass99 = stmt.executeQuery (sql99);
											
											if (tass99.next()) {
										
												assetdoc=tass99.getInt("docno");		
												
										     }
									    
									    	 
									    	 String fleetnos=""+(vehpurreqarray1[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray1[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray1[0].trim().equalsIgnoreCase("")|| vehpurreqarray1[0].isEmpty()?0:vehpurreqarray1[0].trim())+"";
											 int  fleetnoss=Integer.parseInt(fleetnos);
										     String amounts=""+(vehpurreqarray1[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray1[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray1[2].trim().equalsIgnoreCase("")|| vehpurreqarray1[2].isEmpty()?0:vehpurreqarray1[2].trim())+"";
												 //  int  fleetnoss=Integer.parseInt(fleetnos);
											   
											   insert into gc_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)values(vdate,docNo,fleetNo,
													   vehacno,VTVAL,branchid,'FAD',1,0);	
											   
										    	 
											     String sqla="INSERT INTO gc_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)VALUES"
													       + " (curdate(),'"+assetdoc+"',"
													       + "'"+fleetnoss+"',"
													       + "'"+accnoss+"',"
													       + "'"+amounts+"',"
													       + "'"+session.getAttribute("BRANCHID").toString()+"',"
													       +"'VPU',1,'"+tranno+"' )";
											     
											 	//System.out.println("---sqla-------"+sqla);
													     int resultSet3 = stmt.executeUpdate(sqla);
													    
													     if(resultSet3<=0)
															{
																conn.close();
																return 0;
																
															}					   
											   
									     
									     
								}
					}
								
								
			     
			     
			
			if(docno>0)
			{
			conn.commit();
			 stmt.close();
				conn.close(); 
				return 1;
			}
		
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
		return 0;
	}
		
		
		return 0;
	}
	
	*/
	
	
	public int update(ArrayList<String> descarray, HttpServletRequest request,HttpSession session, double pricetottal,
			String venderaccount,int docno, String vendercurr, double vendorrate , Date docdate) throws SQLException {
	
		try
		{
		
			conn=ClsConnection.getMyConnection();
			//conn.setAutoCommit(false);
		   	Statement stmt = conn.createStatement(); 	
		   	
		   	
			for(int i=0;i< descarray.size();i++){
		    	
			          String[] vehpurreqarray=descarray.get(i).split("::");
//			          System.out.println("===== "+descarray.get(i));
					     if(!(vehpurreqarray[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()))
					     {
					    	 
					    	 String fleetnos=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
							   int  fleetno=Integer.parseInt(fleetnos);
							   String rownos=""+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"";
							   int  rowno=Integer.parseInt(rownos);	 
							   String totper=""+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"";
					    	 
							   
							   String clrid=""+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"";
							   
						    	
						    	String sqlss="update  gl_vpurd  set fleet_no='"+fleetno+"', flstatus=1,totper='"+totper+"',clrid='"+clrid+"' where rowno='"+rowno+"'"; 
						    	     int aa=stmt.executeUpdate(sqlss); 
						    	     
						    	     
						    	     if(aa<=0)
										{
											conn.close();
											return 0;
											
										}
						    	     
						    	     
						    	    
						    	     
						    	     if(!(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN") || vehpurreqarray[3].trim().equalsIgnoreCase("") ||  vehpurreqarray[3].isEmpty()))
								     {
						    	    	 
						    	    	 if(vehpurreqarray[3].trim().equalsIgnoreCase("0"))
						    	    	  
						    	    	 {
						    	    	 
						    	    	 }
						    	    	 else{
						    	    	 	String sqlsss="update  gl_vehmaster  set CH_NO='"+vehpurreqarray[3].trim()+"' where fleet_no='"+fleetno+"'"; 
						    	    	 	
						    	    	  
						    	    	 	
								    	     int aaa=stmt.executeUpdate(sqlsss); 
								    	    	String sqlss1="update  gl_vpurd  set chaseno='"+vehpurreqarray[3].trim()+"' where rowno='"+rowno+"'"; 
								    	    	aaa=stmt.executeUpdate(sqlss1); 
								    	     
								    	     
								    	     if(aaa<=0)
												{
													conn.close();
													return 0;
													
												}
						    	    	 }   
						    	    	 
						    	    	 
								     }
						    	     
						    	   
						    	     
						    	     if(!(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN") || vehpurreqarray[4].trim().equalsIgnoreCase("") || vehpurreqarray[4].isEmpty() || vehpurreqarray[4].trim().equalsIgnoreCase("0")))
								     {
						    	      	 if(vehpurreqarray[4].trim().equalsIgnoreCase("0"))
							    	    	  
						    	    	 {
						    	    	 
						    	    	 }
						    	      	 else
						    	      	 {
						    	    	 	String sqlssss="update  gl_vehmaster  set ENG_NO='"+vehpurreqarray[4].trim()+"' where fleet_no='"+fleetno+"'"; 
						    	    	 	
						    	    	  
								    	     int aaaa=stmt.executeUpdate(sqlssss); 
								    	     String sqlss2="update  gl_vpurd  set enginno='"+vehpurreqarray[4].trim()+"' where rowno='"+rowno+"'"; 
								    	     aaaa=stmt.executeUpdate(sqlss2); 
								    	     
								    	     if(aaaa<=0)
												{
													conn.close();
													return 0;
													
												} 
						    	      	 } 
								     }
						    	     

					    	    	 /*	String sqldepr="update  gl_vehmaster  set depr_date='"+docdate+"' where fleet_no='"+fleetno+"'"; 
					    	    	  
							    	     int aaaa=stmt.executeUpdate(sqldepr); 
							    	     if(aaaa<=0)
											{
												conn.close();
												return 0;
												
											} */
					    	      		 
					     }
		               }
			     
			if(docno>0)
			{
			
			 stmt.close();
				conn.close(); 
				return 1;
			}	     
			     		
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
		return 0;
	}
		
		
		return 0;
	}
	public int postingupdate(Date deldate,ArrayList<String> descarray, HttpServletRequest request,HttpSession session, double pricetottal,
			String venderaccount,int docno, String vendercurr, double vendorrate, Date invDate, String invno) throws SQLException {
	
		try
		{
		
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
		   	Statement stmt = conn.createStatement(); 	
		   	
		   	

			     
			     
			        int tranno=0;
					String dates="";
					String trsql="SELECT tr_no,date FROM  gl_vpurm where doc_no='"+docno+"' ";	
				
					ResultSet tass = stmt.executeQuery (trsql);
					
					if (tass.next()) {
				
						tranno=tass.getInt("tr_no");		
						dates=tass.getString("date");
				     }
					
					 String upsqls2="update my_jvtran set status=3  where tr_no='"+tranno+"'";
					 stmt.executeUpdate(upsqls2);
					 
					 
					 
							
					String confirm="confirm";		 
	/*						 
					for(int j=0;j<descarray.size();j++){
							    	
								 
					String[] vehpurreqarray2=descarray.get(j).split("::");
					  if(!(vehpurreqarray2[0].trim().equalsIgnoreCase("undefined")|| vehpurreqarray2[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray2[0].trim().equalsIgnoreCase("")|| vehpurreqarray2[0].isEmpty()))
						  {	 
						  
						 // System.out.println("--------1---------");
						  
						 if(j==0)
							
						{
						
							 
							//  System.out.println("--------j---------"+j);		 
							 
							 
							 
							 
								String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
								
								int dd=stmt.executeUpdate(trnosql);
							     
										 if(dd<=0)
											{
												conn.close();
												return 0;
												
											}
							 
								//System.out.println("-------1---"); 
							 
							 confirm="confirm";	
							 
							 String vendorcur="0"; 
							 double venrate=0.00;
							 
							 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
								//System.out.println("-----sqls10-----"+sqls10);
							   ResultSet tass11 = stmt.executeQuery (sqls10);
							   if(tass11.next()) {
							
								   vendorcur=tass11.getString("curid");	
								 //  venrate=tass11.getDouble("rate");	
									
							     }
							 
							 Selecting Currency Rate
						     String currencytype="";
						     String sqlss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						        +"where  coalesce(toDate,curdate())>='"+deldate+"' and frmDate<='"+deldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 //   System.out.println("-----------sqlss---------"+sqlss);
						     ResultSet resultSet33 = stmt.executeQuery(sqlss);
						         
						      while (resultSet33.next()) {
						    	  venrate=resultSet33.getDouble("rate");
						     currencytype=resultSet33.getString("type");
						      }
						      Selecting Currency Rate Ends
							 
								//System.out.println("pricetottal="+pricetottal);
						      
						     // System.out.println("--------currencytype------------"+currencytype);
							 
							   double	dramount=pricetottal*-1; 
							   
								//System.out.println("dramount="+dramount);
								//System.out.println("venrate="+venrate);
							  // 
							   double ldramount=0;
							   if(currencytype.equalsIgnoreCase("D"))
							   {
							   
					           	
					           	 ldramount=dramount/venrate ;  
							   }
							   
							   else
							   {
								    ldramount=dramount*venrate ;  
							   }
							   
						
						//System.out.println("ldramount"+ldramount);
						
							
							 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							 		+ "values(curdate(),'"+refdetails+"',"+docno+",'"+venderaccount+"','Vehicle Purchase','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'VPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
						     
							 
							//System.out.println("----sql1-------"+sql1);
							 int ss = stmt.executeUpdate(sql1);

						     if(ss<=0)
								{
									conn.close();
									return 0;
									
								}
						     
						     int acnos=0;
						     String curris="0";
						     double rates=0.00;
						     
						     //noushad
						     
						   String sql2="select  acno from my_account where codeno='VEH'";
						    
						   // select  acno  from my_account where codeno='VEH';
							//System.out.println("-----sql2-----"+sql2);
							

				              		   ResultSet tass1 = stmt.executeQuery (sql2);
							
							if (tass1.next()) {
						
								acnos=tass1.getInt("acno");		
								
						     }
							
							
							
							 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
						//	System.out.println("-----sqls3-----"+sqls3); 
							   ResultSet tass3 = stmt.executeQuery (sqls3);
								
								if (tass3.next()) {
							
									curris=tass3.getString("curid");	
									//rates=tass3.getDouble("rate");	
									
							     }
								String currencytype1="";
								 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									        +"where  coalesce(toDate,curdate())>='"+deldate+"' and frmDate<='"+deldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
								//   System.out.println("-----------sqlveh---------"+sqlveh);    
									     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
									         
									      while (resultSet44.next()) {
									    	  rates=resultSet44.getDouble("rate");
									      currencytype1=resultSet44.getString("type");
									      } 
								 //  double	dramounts=pricetottal; 
								   
									//System.out.println("dramount="+dramount);
									//System.out.println("venrate="+venrate);
								  // 
									      
									    //  System.out.println("--------currencytype1------------"+currencytype1);
									      
									      double ldramounts=0 ;     
									      if(currencytype1.equalsIgnoreCase("D"))
									      {
									      
							                   ldramounts=pricetottal/venrate ;  
									      }
									      
									      else
									      {
									    	   ldramounts=pricetottal*venrate ;  
									      }
						     
							 String sql10="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								 		+ "values(curdate(),'"+refdetails+"',"+docno+",'"+acnos+"','Vehicle Purchase','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'VPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
							     
								 
							//	System.out.println("---sql10-------"+sql10);
								 int ss1 = stmt.executeUpdate(sql10);

							     if(ss1<=0)
									{
										conn.close();
										return 0;
										
									}
						     
							

							  
							     
			     
						
				    }  
						 
						  }
						
						 
						 
			  }*/
								
					if(confirm.equalsIgnoreCase("confirm"))			
					{
								
								
								for(int k=0;k<descarray.size();k++){
									
								       String[] vehpurreqarray1=descarray.get(k).split("::");
								  int accnoss=0;     
									   String sql2="select  acno from my_account where codeno='VEH'";
									    
									   // select  acno  from my_account where codeno='VEH';
										//System.out.println("-----sql2-----"+sql2);
										

									   ResultSet tass1 = stmt.executeQuery (sql2);
										
										if (tass1.next()) {
									
											accnoss=tass1.getInt("acno");		
											
									     }
										
										int assetdoc=0;
										   String sql99="select coalesce((max(doc_no)+1),1) docno from gc_assettran";
										    
										   // select  acno  from my_account where codeno='VEH';
											//System.out.println("-----sql2-----"+sql2);
											

										   ResultSet tass99 = stmt.executeQuery (sql99);
											
											if (tass99.next()) {
										
												assetdoc=tass99.getInt("docno");		
												
										     }
									    
									    	 
									    	 String fleetnos=""+(vehpurreqarray1[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray1[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray1[0].trim().equalsIgnoreCase("")|| vehpurreqarray1[0].isEmpty()?0:vehpurreqarray1[0].trim())+"";
											 int  fleetnoss=Integer.parseInt(fleetnos);
										     String amounts=""+(vehpurreqarray1[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray1[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray1[2].trim().equalsIgnoreCase("")|| vehpurreqarray1[2].isEmpty()?0:vehpurreqarray1[2].trim())+"";
												 //  int  fleetnoss=Integer.parseInt(fleetnos);
											   
										/*	   insert into gc_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)values(vdate,docNo,fleetNo,
													   vehacno,VTVAL,branchid,'FAD',1,0);	
											   */
										    	 
											     String sqla="INSERT INTO gc_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)VALUES"
													       + " ('"+dates+"','"+assetdoc+"',"
													       + "'"+fleetnoss+"',"
													       + "'"+accnoss+"',"
													       + "'"+amounts+"',"
													       + "'"+session.getAttribute("BRANCHID").toString()+"',"
													       +"'FAD',1,'"+tranno+"' )";
											     
											 	//System.out.println("---sqla-------"+sqla);
													     int resultSet3 = stmt.executeUpdate(sqla);
													    
													     if(resultSet3<=0)
															{
																conn.close();
																return 0;
																
															}					   
											   
									     
									     
								}
					}
						
					
				String sqlupdates="update gl_vpurm set psgstatus=1,purno='"+invno+"',purdate='"+invDate+"' where doc_no='"+docno+"' ";	
			//	System.out.println("-------sqlupdates-"+sqlupdates);	
				
					int lastval=stmt.executeUpdate(sqlupdates);
					
					if(lastval<=0)
					{
						conn.close();
						return 0;
					}
								
			     
			     for(int i=0;i<descarray.size();i++){
			    	 String temp[]=descarray.get(i).split("::");
			    	 
			    	 String sqldepr="update  gl_vehmaster  set depr_date='"+invDate+"' where fleet_no='"+temp[0]+"'"; 
		    	    	  
			    	     int aaaa=stmt.executeUpdate(sqldepr); 
			    	     if(aaaa<=0)
							{
								conn.close();
								return 0;
								
							}
			     }
			
			if(docno>0)
			{
			conn.commit();
			 stmt.close();
				conn.close(); 
				return 1;
			}
		
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
		return 0;
	}
		
		
		return 0;
	}
	
	public int detupdate(String dealno,int docno, Date sqldetDate, String secchaqueno, String nameincheque,
			String txtdescription, int calcumethod, int finaccdocno,
			int banckaccdocno, int interestaccdocno, int loanaccdocno,
			int paymentmethod, BigDecimal downpaymet, BigDecimal loanamount,
			BigDecimal chqamount, ArrayList<String> descarray,
			HttpServletRequest request, double percentage, int installmaent,HttpSession session, String bankcurr, String inertcurr, String loancurr, 
			double bankrate, double interrate, double loanrate, Date sqluptoDate,String vehdesc) throws SQLException {
		
		
	//	System.out.println("----vehdesc-------"+vehdesc);
		
		try
		{
			///HttpSession session=request.getSession();	
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtvehpurchase= conn.prepareCall("{call vahpurchasedetailDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtvehpurchase.setDate(1,sqldetDate);
		stmtvehpurchase.setString(2,secchaqueno);
		stmtvehpurchase.setString(3,nameincheque);
		stmtvehpurchase.setString(4,txtdescription);
		stmtvehpurchase.setInt(5,calcumethod);
		stmtvehpurchase.setInt(6,finaccdocno);
		stmtvehpurchase.setInt(7,banckaccdocno);
		stmtvehpurchase.setInt(8,interestaccdocno);
		stmtvehpurchase.setInt(9,loanaccdocno);
		stmtvehpurchase.setInt(10,paymentmethod);
		stmtvehpurchase.setBigDecimal(11,downpaymet);
		stmtvehpurchase.setBigDecimal(12,loanamount);
		stmtvehpurchase.setBigDecimal(13,chqamount);
		stmtvehpurchase.setInt(14,docno);
		stmtvehpurchase.setDouble(15,percentage);
		stmtvehpurchase.setInt(16,installmaent);
		stmtvehpurchase.setDate(17,sqluptoDate);
		stmtvehpurchase.setString(18,dealno);
		
		int aaa=stmtvehpurchase.executeUpdate();
	//	int srno=stmtvehpurchase.getInt("srno");
			
		
	
		
		if(aaa<=0)
		{
			conn.close();
			return 0;
			
		}
		int finsc=0;
		String sqls ="select h.doc_no account ,h.description fname,v.doc_no from gl_vehfin v left join my_head h on h.doc_no=v.acc_no where v.doc_no='"+finaccdocno+"'";
		System.out.println("Financiar Acno: "+sqls);
		ResultSet rs=stmtvehpurchase.executeQuery(sqls);
		
		if(rs.first())
		{
			finsc=rs.getInt("account");	
		}
		
		
		  Calendar now = Calendar.getInstance();
		  Date docdate = ClsCommon.changeStringtoSqlDate(now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+"."+now.get(Calendar.YEAR));
	     
		  double chqamounts = chqamount.doubleValue();
		  
		int val1=securityChqDAO.insert(docdate,"SEC","GL",finsc,banckaccdocno,secchaqueno,sqluptoDate,"0",docdate,"1",chqamounts,vehdesc,"",session,"A");
		
		if(val1<=0)
		{
			conn.close();
			return 0;
			
		}

		
	/*	public int insert(Date securityChequeDate, String formdetailcode,String cmbtotype, int txttodocno, int txtfromdocno,String txtchequeno, Date validUpToDate, 
				String hidchckchqdate, Date chequeDate, String hidchckamount, double txtamount, HttpSession session, String mode)
		*/
/*		
		Calendar now = Calendar.getInstance();
		  Date docdate = ClsCommon.changeStringtoSqlDate(now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+"."+now.get(Calendar.YEAR));*/
		 // Date docdate = now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+"."+now.get(Calendar.YEAR));
		
		for(int i=0;i< descarray.size();i++){
	    	
		     String[] vehpurreqarray=descarray.get(i).split("::");
				//System.out.println("---dao----vehpurreqarray----"+vehpurreqarray);
		     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
		     {
		    	
		    	 
		    //	 srno, rdocno, date, pramt, intstamt, totamt, bpvno 
		    	 
		    	 String date =""+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"";
		    	 
		    	 Date chedate= ClsCommon.changeStringtoSqlDate(date); 
		    	 
		    	 String amounts=""+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"";
		    	 
		         double totamount=Double.parseDouble(amounts);
		         
	    	     String interstamounts=""+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")||vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"";
		    	 
		         double interstamount=Double.parseDouble(interstamounts);
		         
		         String txtinterst=""+chedate+" "+"Interest Amount is"+" "+interstamounts;
		         
		         double baseintamt=interstamount*interrate;
		         
		    	 
		 	     String prinamounts=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
		    	 
		         double prinamount=Double.parseDouble(prinamounts);
		         String txtprinci=""+chedate+" "+"Principal Amount is"+" "+prinamounts;
		         
		         
		         double baseprincamt=prinamount*loanrate;
		         
		         double bankamount=totamount*-1;
		         
		         double basebankamount=totamount*bankrate*-1;
		         
		         String txtbank=""+chedate+" "+"Amount is"+" "+"-"+amounts;
		         
		         String chqnos =""+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"";
		         
		     	/* public int detupdate(int docno, Date sqldetDate, String secchaqueno, String nameincheque,
		    			String txtdescription, int calcumethod, int finaccdocno,
		    			int banckaccdocno, int interestaccdocno, int loanaccdocno,
		    			int paymentmethod, BigDecimal downpaymet, BigDecimal loanamount,
		    			BigDecimal chqamount, ArrayList<String> descarray,
		    			HttpServletRequest request, double percentage, int installmaent,HttpSession session, String bankcurr, String inertcurr, String loancurr, 
		    			double bankrate, double interrate, double loanrate) throws SQLException {   */ 
		            
		           ArrayList <String> unclearedchequepaymentarray= new ArrayList<String>();
		       	// bank  array      		
					unclearedchequepaymentarray.add(banckaccdocno+"::"+bankcurr+"::"+bankrate+"::false::"+bankamount+"::"+txtbank+"::"+basebankamount+"::0::0::0");
					// bank  for zero      		
					unclearedchequepaymentarray.add("0::0::0::0::0::0::0::0::0::0");
		    // interest array      
					unclearedchequepaymentarray.add(interestaccdocno+"::"+inertcurr+"::"+interrate+"::true::"+interstamount+"::"+txtinterst+"::"+baseintamt+"::0::0::0");
			// loan  array      		
					unclearedchequepaymentarray.add(loanaccdocno+"::"+loancurr+"::"+loanrate+"::true::"+prinamount+"::"+txtprinci+"::"+baseprincamt+"::0::0::0");
					
					
				//	System.out.println("--------------------"+unclearedchequepaymentarray);
					
			/*// bank  array      		
					unclearedchequepaymentarray.add(banckaccdocno+"::"+bankcurr+"::"+bankrate+"::false::"+bankamount+"::"+txtbank+"::"+basebankamount+"::0::0::0");
					*/
				//	unclearedchequepaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());  
		            //System.out.println("unclearedchequepaymentarray===="+unclearedchequepaymentarray);

					int val=unclearedChequePayDAO.insert(docdate,"UCP","VPU-"+docno,bankrate,chedate,chqnos,nameincheque,0,txtdescription,totamount,0,unclearedchequepaymentarray,session,request,"A");
			    	 
			    	 
		            
					if(val<=0)
					{
						conn.close();
						return 0;
						
					}
		
			     String sql="INSERT INTO gl_vpurdetd(sr_no,pramt,date,intstamt,totamt,chqno,rdocno,bpvno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"',"
					       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:ClsCommon.changeStringtoSqlDate(vehpurreqarray[1].trim()))+"',"
					       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
					       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
					       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
					       +"'"+docno+"','"+val+"')";
			     int resultSet3 = stmtvehpurchase.executeUpdate(sql);
				    
			     if(resultSet3<=0)
					{
						conn.close();
						return 0;
						
					}
		    	 
		    	 
		     }
		 }
		
		
		if (aaa > 0) {
			conn.commit();
			stmtvehpurchase.close();
			conn.close();
			return 1;
		}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return 0;
			
			
			//return 1;
		
		
	}
	/*public boolean edit(int docno,Date sqlStartDate, Date sqlpurdeldate,Date invDate,
			String headacccode, String vehtype, String vehrefno,
			Double nettotal, String vehdesc, HttpSession session, String mode,
			String formdetailcode,ArrayList<String> descarray,String invno) throws SQLException  {
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtvehpurchase= conn.prepareCall("{call vahpurchaseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtvehpurchase.setDate(1,sqlStartDate);
			stmtvehpurchase.setString(2,headacccode);
			stmtvehpurchase.setString(3,vehtype);
			stmtvehpurchase.setString(4,vehrefno=="null"?"0":vehrefno);
			stmtvehpurchase.setDouble(5,nettotal);
			stmtvehpurchase.setString(6,vehdesc);
			stmtvehpurchase.setDate(7,sqlpurdeldate);
			stmtvehpurchase.setString(8,session.getAttribute("USERID").toString());
			stmtvehpurchase.setString(9,session.getAttribute("BRANCHID").toString());
			stmtvehpurchase.setString(10,formdetailcode);
			stmtvehpurchase.setDate(11,invDate);
			stmtvehpurchase.setString(12,invno);
			stmtvehpurchase.setInt(13,docno);
			stmtvehpurchase.setString(14,"E");
			int aaa=stmtvehpurchase.executeUpdate();
			docno=stmtvehpurchase.getInt("docNo");
					
			if(aaa<=0)
			{
				conn.close();
				return false;
				
			}
			  String delsql="Delete from gl_vpurd where rdocno="+docno+" ";
			  stmtvehpurchase.executeUpdate(delsql);
			for(int i=0;i<descarray.size();i++){
		    	
			     String[] vehpurreqarray=descarray.get(i).split("::");
			    
			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
				     String sql="INSERT INTO gl_vpurd(srno,brdid,modid,spec,clrid,qty,price,total,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
						       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
						       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
						       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
						       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
						       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
						        + "'"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"',"
						       +"'"+docno+"')";  	 
		     String sql="update  gl_vpurd set srno="+(i+1)+","
		     		   + "brdid='"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "modid='"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				       + "spec='"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
				       + "clrid='"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
				       + "price='"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
				       + "qty='"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"' ,"
				       + "total='"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"' where rdocno="+docno+"";
		    
		  //   System.out.println(""+sql);
		     int resultSet4 = stmtvehpurchase.executeUpdate(sql);
		     if(resultSet4<=0)
				{
					conn.close();
					return false;
					
				} 
			     }
				     
				     }
			
						
			if (aaa > 0) {
				conn.commit();
				stmtvehpurchase.close();
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
*/
	/*public boolean delete(int docno, HttpSession session, String mode,
			String formdetailcode)  throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
		//	conn.setAutoCommit(false);
			CallableStatement stmtvehpurchase= conn.prepareCall("{call vahpurchaseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtvehpurchase.setDate(1,null);
			stmtvehpurchase.setString(2,null);
			stmtvehpurchase.setString(3,null);
			stmtvehpurchase.setString(4,null);
			stmtvehpurchase.setDouble(5,0.0);
			stmtvehpurchase.setString(6,null);
			stmtvehpurchase.setDate(7,null);
			stmtvehpurchase.setString(8,session.getAttribute("USERID").toString());
			stmtvehpurchase.setString(9,session.getAttribute("BRANCHID").toString());
			stmtvehpurchase.setString(10,formdetailcode);
			stmtvehpurchase.setDate(11,null);
			stmtvehpurchase.setString(12,null);
	
			stmtvehpurchase.setInt(13,docno);
			stmtvehpurchase.setString(14,"D");
			
			int aaa=stmtvehpurchase.executeUpdate();
			
			
		
			if (aaa > 0) {
			//	conn.commit();
				stmtvehpurchase.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}	
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
	
	*/
	
	
	
	public  JSONArray searchBrand() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn=null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	
	public  JSONArray searchModel(String brandval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn=null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh3 = conn.createStatement ();
            	
				String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid="+brandval+" and status<>7;");
				
				//System.out.println("========"+modelsql);
				
				ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh3.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public  JSONArray searchColor() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn=null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
	        	
				ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color  from my_color  where status<>7 order by  doc_no;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

		}
		catch(Exception e){
			
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	public  JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
                     if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and c.code like '%"+currency+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmtCPV = conn.createStatement ();
          /*   String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
               + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
               + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') ";*/
   
    String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
   // System.out.println("sql===="+sql);
    
            /* String sql=" select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,a1.cldocno,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
            	        + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
            	        + "and t.cldocno=a1.cldocno and a1.dtype='VND' and t.atype='AP' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
            	        + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')";*/
             
             
          //  System.out.println("==============="+sql); 
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmtCPV.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	public  JSONArray orderSearchMasters(HttpSession session,String accno) throws SQLException {

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
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select voc_no,doc_no,date,venid, rtype type, rno, expdeldt, desc1, nettotal "
	        			+ "	        			from gl_vpom  where status=3 and brhid='"+brcid+"' and venid='"+accno+"'" );
	        //	System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public  JSONArray refsearchrelode(String orderdocno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select rq.srno,rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.qty,rq.qty qutval,rq.price, rq.total,"
						+ " vb.brand_name brand,vm.vtype model,vc.color color "
						+ " from gl_vpod rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
						+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID   "
						+ "left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and rq.rdocno='"+orderdocno+"' ");
			//	System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	public  JSONArray gridsearchrelode(String masterdocno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	           Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
		/*		String resql=("select rq.srno,rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.price,rq.chaseno,rq.enginno,rq.rowno,convert(coalesce(rq.fleet_no,''),char(20)) fleet_no,rq.flstatus, "
						+ "  vb.brand_name brand,vm.vtype model,vc.color color "
						+ "  from gl_vpurd rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
						+ "  left join gl_vehmodel vm on vm.doc_no=rq.MODID   "
						+ "  left join my_color vc on vc.doc_no=rq.clrid  where rq.rdocno='"+masterdocno+"' ");*/
				String resql=("select rq.inactive,rq.srno,rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.price,if(rq.flstatus=1,v.ch_no,rq.chaseno) chaseno, "
						+ "	if(rq.flstatus=1,v.eng_no,rq.enginno)  enginno,if(rq.flstatus=1,v.reg_no,'') reg_no,rq.rowno, convert(coalesce(rq.fleet_no,''),char(20)) fleet_no,rq.flstatus,  "
						+ " vb.brand_name brand,vm.vtype model,vc.color color  from gl_vpurd rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID  "
						+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID 	 left join my_color vc on vc.doc_no=rq.clrid  "
						+ " left join gl_vehmaster v on v.fleet_no=rq.fleet_no and rq.flstatus=1  where  rq.rdocno='"+masterdocno+"' ");
				
			//	System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	public  JSONArray fleetSearch(String fleetval,String brandid,String modid) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    String sqltest="";
	    if((!fleetval.equalsIgnoreCase("0"))||(!fleetval.equalsIgnoreCase("NA"))||(!fleetval.equalsIgnoreCase("NA")))
	    		{
	    	sqltest=fleetval;
	    	
	    		}
		Connection conn = null;
		try {
			conn= ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement (); 
	        	
				String resql=("select v.fleet_no,v.flname,v.reg_no,v.ch_no,v.eng_no,c.color,v.clrid from gl_vehmaster v\r\n" + 
						" left join (select fleet_no,rdocno from gl_vpurd p inner join gl_vpurm m on p.rdocno=m.doc_no and m.status=3) p on p.fleet_no=v.fleet_no left join my_color c on c.doc_no=v.clrid   where v.statu=3 "
						+ " and  p.fleet_no  is null  and v.dtype='VEH' and v.brdid='"+brandid+"' and  v.vmodid='"+modid+"' "+sqltest);
		     	//System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	public  JSONArray slnosearch(String docno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	   
		Connection conn = null;
		try {
			conn= ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select rq.rdocno,rq.srno, rq.brdid, rq.modid, rq.spec specification, rq.clrid, (rq.qty-rq.pqty) qty, rq.price ,vb.brand_name brand,vm.vtype model,vc.color color "
						+ " from gl_vpod rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ " left join my_color vc on vc.doc_no=rq.clrid where rq.clstatus=0 and  rq.rdocno='"+docno+"' ");
		   //  System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	
	
	
	
	
	
	
	
/*	public  JSONArray distributionGrid(String date,String cmbfrequency,String txtamount, String txtinstnos,String txtinstamt,String txtdueafter) throws SQLException {
      

        JSONArray jsonArray = new JSONArray();
        
        Connection conn = null; 
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtPREP = conn.createStatement();
			
				java.sql.Date xdate=null;
				double xtotal=0.0;
				double amount=0.0;
				int xsrno=0;
		        
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		        	xdate = ClsCommon.changeStringtoSqlDate(date);
		        }
		        
		        String xsql="";
		        
				xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
				
				do							
				{	
					++xsrno;
					if (Integer.parseInt(txtinstnos)>0 && xsrno>Integer.parseInt(txtinstnos))
					break;
					
					int sr_no= xsrno;							
					int actualNoOfInst=xsrno;
					
					amount=((xtotal+Integer.parseInt(txtinstamt))>Integer.parseInt(txtamount)?(Integer.parseInt(txtamount)-xtotal):Integer.parseInt(txtinstamt));
					xtotal+=amount;
					
					//setting values to grid
					JSONObject obj = new JSONObject();
					obj.put("sr_no",String.valueOf(sr_no));

					if(!(xdate==null)){
						obj.put("date",xdate.toString());
					}
					obj.put("amount",String.valueOf(amount));
					obj.put("posted",0);
					
					jsonArray.add(obj);
					
					if(xtotal>=Integer.parseInt(txtamount)) break;
					//if (Integer.parseInt(txtinstnos)>0 && xsrno==Integer.parseInt(txtinstnos) && MyLib.getSum(txtamount, xtotal*-1, 2)>0)
					//{
						//preBrowse.cache.setData("Amount",MyLib.getSum(preBrowse.cache.getDouble("Amount"),
							//	MyLib.getSum(txtamount, xtotal*-1, 2),2));
								
                    //	xtotal+=MyLib.getSum(txtamount, xtotal*-1, 2);
					//}
					ResultSet rs = stmtPREP.executeQuery("Select DATE_ADD(date('"+xdate+"'),INTERVAL "+xsql+") fdate ");
					if(rs.next()) xdate=rs.getDate("fdate");
					rs.close();
			}while(true);
				stmtPREP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return jsonArray;
    }*/

/*public  JSONArray distributionGridReloading(HttpSession session,String tranId) throws SQLException {
     
       
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
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
        String branch = session.getAttribute("BRANCHID").toString();
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtPREP = conn.createStatement();
			
				String sqlnew=("select sr_no,date,amount,posted,rowno from my_prepd where tranid="+tranId);
				ResultSet resultSet = stmtPREP.executeQuery (sqlnew);
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtPREP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    } */
	public  JSONArray searchmaster(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String reftypess,String aa) throws SQLException {

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
	    java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.voc_no like '%"+docnoss+"%'";
    	}
    	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
    	}
    	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
    	}
    	if((!(reftypess.equalsIgnoreCase(""))) && (!(reftypess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.rtype like '%"+reftypess+"%'";
    	}
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and vo.date='"+sqlStartDate+"'";
    	} 
    	Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select convert(coalesce(vo.tr_no,'0'),char(30)) tr_no,o.voc_no refno,vo.voc_no,vo.doc_no,vo.date,vo.venid, vo.rtype type, vo.rno, vo.expdeldt, vo.desc1, vo.nettotal,vo.purno,vo.purdate,h.description,h.account,h.doc_no headdoc "
	        			+ " from gl_vpurm vo  left  join my_head h on h.doc_no=vo.venid  left join gl_vpom o on o.doc_no=vo.rno where vo.status=3 and vo.brhid='"+brcid+"' "+sqltest );
	 
	        //	System.out.println("-----------"+pySql);
	        	
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			}
			conn.close();
			 return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}


	public  JSONArray bankaccountsDetails(HttpSession session,String accountno,String accountname,String currency,String check) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       

		        
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		 
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
		            String branch=session.getAttribute("BRANCHID").toString();
		            String company = session.getAttribute("COMPANYID").toString();
		            String den= "";
		            
		            
		            
		          String sqltest="";
		          String sql="";
		          
		          if(check.equalsIgnoreCase("bankaac"))
		        	  
		          {
		        	  
		        	  sqltest=sqltest+" and den=305 ";  
		          }
		          
		         
		          if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		              sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		          }
		          if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		          }
		          if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and c.code like '%"+currency+"%'";
		                 }
		          
		        //  if(check.equalsIgnoreCase("1")){
		          
		          if(check.equalsIgnoreCase("bankaac")||check.equalsIgnoreCase("intrestacc")||check.equalsIgnoreCase("loanacc"))
		          {
		           
		          sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type from my_head t,"
		              + "(select curId from my_brch where doc_no='"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
		              + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') "+sqltest;
		              		
		       //   System.out.println("-------"+sql);    		
		                    
		  	/*	          sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type, from my_head t,"
		  		          		+ " (select curId from my_brch where doc_no=  '1') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
		  		          		+ " and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'01') and t.brhid in(0,'1') and den=305 "+sqltest;      */
		  		          
		              		
		          
		         // System.out.println("-------"+sql);
		          
		          
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		          }
		         stmt.close();
		         conn.close();
		         
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }
	public JSONArray financesearch(String accountno,String accountname,String check) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		         String sqltest="";
		        //  String sql="";
		          
		          if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		              sqltest=sqltest+" and acc_no like '%"+accountno+"%'";
		          }
		          if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and fname like '%"+accountname+"%'";
		          }
		          
		          if(check.equalsIgnoreCase("1"))
		          {
		       /*  String sql="select acc_no,fname,doc_no from gl_vehfin where status=3 "+sqltest;*/
		        	  
		        	  
		        String sql="select h.account acc_no,h.description fname,v.doc_no from gl_vehfin v left join my_head h on h.doc_no=v.acc_no where v.status=3"+sqltest;
		          
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		          } 
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }
	public  JSONArray description(String docno) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		       ///  sr_no     bpvno
		         
		         /**
		          *  left join my_unclrchqbm m on m.doc_no=d.bpvno
		          *  connection with unclrchq removed to control branch condition 
		          */
	
		         String sql="select  d.sr_no, d.rdocno, DATE_FORMAT(d.date,'%d.%m.%Y') date, d.pramt priamount,d.intstamt interest, d.totamt amount,convert(coalesce(d.chqno,''),char(50)) chqno,d.bpvno  "
		         		+ " from gl_vpurdetd d  where d.rdocno='"+docno+"'  ";
		         
		        // System.out.println("-------------"+sql);
		         
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }

	
	public  JSONArray exportdescription(String docno) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		       ///  sr_no     bpvno
	
		         String sql="select   (@cnt := @cnt + 1) sr_no,DATE_FORMAT(date,'%d.%m.%Y') date,round(pramt,2) priamount,round(intstamt,2) interest,(round(pramt,2)+round(intstamt,2)) amount,convert(coalesce(chqno,''),char(50)) chqno  "
		         		+ " from gl_vpu_excel , (SELECT @cnt := 0) reno  where id='"+docno+"' ";
		         
		        //System.out.println("-------------"+sql);
		         
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }

	 public  ClsvehpurchaseBean getViewDetails(HttpSession session,int docNo) throws SQLException {
	    	
			
		 ClsvehpurchaseBean masterBean = new ClsvehpurchaseBean();
			Connection conn=null;
			try {
			  conn = ClsConnection.getMyConnection();
			Statement stmtCPV0 = conn.createStatement ();
			String branch = session.getAttribute("BRANCHID").toString();

    String sqls=" select (select restructure from gl_vpurdetm where rdocno="+docNo+") restructure,vo.date,vo.venid, vo.rtype type, vo.rno, vo.expdeldt,vo.nettotal,vo.purno,vo.purdate,h.description,h.account,"
		+ "h.doc_no headdoc,round(dt.dwnpyt,2) dwnpyt,dt.dealno, round(dt.loanamt,2) loanamt, dt.stdate, dt.perintst, dt.clcumtd,dt.noinstmt,dt.sectychqno, dt.chqname,"
		+ "round(dt.amt,2) chqamount, dt.pytmtd, dt.desc1,dt.uptodate, "
		+ " hh.description finaccname,hh.account finaccid ,dt.finaccno findocno,h1.description bankaccname,h1.account bankaccid,dt.bankaccno bankdocno, "
		+ "h2.description intstaccname,h2.account intstaccid,dt.intstaccno instdocno,h3.description loanaccname,h3.account loanaccid,dt.loanaccno loandocno "
		+ "    from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid  left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
		+ "  left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no left join my_head h1 on h1.doc_no=dt.bankaccno left join "
		+ "  my_head h2 on h2.doc_no=dt.intstaccno left join my_head h3 on h3.doc_no=dt.loanaccno    where vo.clstatus=1 and vo.status=3  and vo.brhid='"+branch+"' and vo.doc_no='"+docNo+"' ";
    
    //System.out.println("----------"+sqls);
			
			ResultSet resultSet = stmtCPV0.executeQuery(sqls);
	
	
			while (resultSet.next()) {
				
				masterBean.setRestructure(resultSet.getString("restructure"));
				masterBean.setJqxStartDate(resultSet.getString("stdate"));
				masterBean.setUptoDate(resultSet.getString("uptodate"));
				
				
				masterBean.setDownpayment(resultSet.getBigDecimal("dwnpyt"));
				masterBean.setLoanamount(resultSet.getBigDecimal("loanamt"));
				masterBean.setSecchaqueno(resultSet.getString("sectychqno"));
				masterBean.setNameincheque(resultSet.getString("chqname"));
				masterBean.setTxtdescription(resultSet.getString("desc1"));
				masterBean.setCalcumethod(resultSet.getInt("clcumtd"));
				masterBean.setDealno(resultSet.getString("dealno"));
				masterBean.setFinaccdocno(resultSet.getInt("findocno"));
				masterBean.setBanckaccdocno(resultSet.getInt("bankdocno"));
				masterBean.setInterestaccdocno(resultSet.getInt("instdocno"));
				masterBean.setLoanaccdocno(resultSet.getInt("loandocno"));
				
				masterBean.setPaymentmethod(resultSet.getInt("pytmtd"));
			
				masterBean.setChqamount(resultSet.getBigDecimal("chqamount"));
				
				

				masterBean.setFinanceaccid(resultSet.getString("finaccid"));
				masterBean.setFinanceaccname(resultSet.getString("finaccname"));
				masterBean. setBankaccid(resultSet.getString("bankaccid"));
				masterBean. setBankaccname(resultSet.getString("bankaccname"));
				masterBean.setInterestaccid(resultSet.getString("intstaccid")); 
				masterBean. setIntaccname(resultSet.getString("intstaccname"));
				masterBean. setLoanaccid(resultSet.getString("loanaccid"));
				masterBean.setLoanaccname(resultSet.getString("loanaccname"));
				
				masterBean.setPerinterest(resultSet.getDouble("perintst"));
				masterBean.setInstnos(resultSet.getInt("noinstmt"));
				
				masterBean.setInstnos(resultSet.getInt("noinstmt"));
				
				
				masterBean.setDetval(10);
				
				masterBean.setClstatus(1);
				
				 masterBean.setMasterstatus(1);
				
				//setDetval(10);
				//setClstatus
				
			}
				
		
				
			stmtCPV0.close();
			conn.close();
			}
			catch(Exception e){
				
			e.printStackTrace();
			conn.close();
			}
			
			return masterBean;
			}
	 
	 
	 
	 
	 
	 
	 
	 
	 
		
	 public  ClsvehpurchaseBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsvehpurchaseBean bean = new ClsvehpurchaseBean();
		  ClsAmountToWords c = new ClsAmountToWords();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
				String resql=("  select o.voc_no refno,vo.voc_no,vo.doc_no,DATE_FORMAT(vo.date,'%d.%m.%Y') date,vo.venid, if(vo.rtype='DIR','Direct',concat('Purchase Order (',o.voc_no,')')) type, vo.rno,"
						+ " DATE_FORMAT(vo.expdeldt,'%d.%m.%Y')  expdeldt, vo.desc1, round(vo.nettotal,2) nettotal,vo.purno,DATE_FORMAT(vo.purdate,'%d.%m.%Y') purdate,h.description,h.account,h.doc_no headdoc "
	        			+ " from gl_vpurm vo  left  join my_head h on h.doc_no=vo.venid  left join gl_vpom o on o.doc_no=vo.rno where vo.doc_no='"+docno+"'" );
	 
			//	System.out.println("-----resql----"+resql);
				
			//	String resql=("select voc_no,doc_no,DATE_FORMAT(date,'%d.%m.%Y') AS date,type,DATE_FORMAT(expdeldt,'%d.%m.%Y') AS expdeldt,desc1 from gl_vprm where doc_no='"+docno+"' ");
		
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLbldesc1(pintrs.getString("desc1"));
			    	    bean.setExpdeldate(pintrs.getString("expdeldt"));
			    	    
			    	    bean.setLblvendoeacc(pintrs.getString("account"));
			    	    bean.setLblvendoeaccName(pintrs.getString("description"));
			    	    bean.setLbltotal(pintrs.getString("nettotal"));
			    	    
			    	    bean.setLblinvno(pintrs.getString("purno"));
			    	    
			    	    bean.setLblpurchaseDate(pintrs.getString("purdate"));
			    	    
			    	   // setLbltotal(pintbean.getLbltotal());
			       }
				

		
				
				String resql1=("select round(sum(price),2) price   from gl_vpurd  where rdocno='"+docno+"'" );
	 
			
				ResultSet pintrs1 = stmtprint.executeQuery(resql1);
				
				   if(pintrs1.next()){
			  
			    	    bean.setLbltotal(pintrs1.getString("price"));
			    		bean.setAmountinwords(c.convertAmountToWords(pintrs1.getString("price")));	
				   }
				
				
					stmtprint.close();
				
				 Statement stmtinvoice10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_vpurm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


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
					
						
							Statement stmtinvoice1 = conn.createStatement ();
							String strSqldetail1="";
					
							 strSqldetail1=("select  v.fleet_no,rq.fleet_no,rq.srno,rq.brdid,rq.modid,rq.spec ,rq.clrid,round(rq.price,2) price,\r\n" + 
							 		" if(rq.flstatus=1,v.ch_no,if(rq.chaseno='0','',rq.chaseno)) chaseno,\r\n" + 
							 		" if(rq.flstatus=1,v.eng_no,if(rq.enginno='0','',rq.enginno)) \r\n" + 
							 		" enginno, if(rq.flstatus=1,v.reg_no,'') reg_no, rq.rowno,convert(coalesce(rq.fleet_no,''),char(20)) fleet_no,rq.flstatus,\r\n" + 
							 		"    vb.brand_name brand,vm.vtype model,coalesce(vc.color,'') color   from gl_vpurd rq left join gl_vehbrand vb\r\n" + 
							 		"     on vb.doc_no=rq.BRDID   left join gl_vehmodel vm on vm.doc_no=rq.MODID\r\n" + 
							 		"     left join my_color vc on vc.doc_no=rq.clrid left join gl_vehmaster v on v.fleet_no=rq.fleet_no\r\n" + 
							 		"     and rq.flstatus=1  where rq.rdocno='"+docno+"' ");
				//System.out.println("------------strSqldetail1----"+strSqldetail1);
						ResultSet rsdetail=stmtinvoice1.executeQuery(strSqldetail1);
						
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
								temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("chaseno")+"::"+rsdetail.getString("enginno")+"::"+rsdetail.getString("price")+"::"+rsdetail.getString("fleet_no")+"::"+rsdetail.getString("reg_no");

								arr.add(temp);
								rowcount++;
				
						
							
					}
						
						
						request.setAttribute("details",arr); 
						stmtinvoice1.close();
						
						  ArrayList<String> arrdet=new ArrayList<String>();
							
							
							Statement stmti = conn.createStatement ();
						 
					
							 String sqldetgrid="select  d.sr_no, d.rdocno, DATE_FORMAT(d.date,'%d.%m.%Y') date,round(d.pramt,2) priamount,round(d.intstamt,2) interest, round(d.totamt,2) amount,convert(coalesce(m.chqno,''),char(50)) chqno,d.bpvno  "
						         		+ " from gl_vpurdetd d  left join my_unclrchqbm m on m.doc_no=d.bpvno where d.rdocno='"+docno+"'  and m.status<>7 order by d.sr_no  ";
				//System.out.println("------------strSqldetail1----"+strSqldetail1);
						ResultSet rsdetailgrid=stmti.executeQuery(sqldetgrid);
						
						int rowcounts=1;
				
						while(rsdetailgrid.next()){

								String temp="";
							 
								 
								temp=rowcounts+"::"+rsdetailgrid.getString("date")+"::"+rsdetailgrid.getString("chqno")+"::"+rsdetailgrid.getString("priamount")+"::"+rsdetailgrid.getString("interest")+"::"+rsdetailgrid.getString("amount")+"::"+rsdetailgrid.getString("bpvno");

								arrdet.add(temp);
								rowcounts++;
				
						
							
					}
						
						
						
						
						
						request.setAttribute("detailsarr",arrdet); 
						stmti.close();
						
						//bean.setRowdatascount(rowcounts);
				       
						
						
						
						
						
						
						 
						 Statement stmttotal = conn.createStatement ();
						 
					
							String sqls11=("select  round(sum(d.pramt),2) priamount,round(sum(d.intstamt),2) interest, round(sum(d.totamt),2) amount \r\n" + 
									"  from gl_vpurdetd d  left join my_unclrchqbm m on m.doc_no=d.bpvno where d.rdocno='"+docno+"' group  by d.rdocno ");
				//System.out.println("------------strSqldetail1----"+strSqldetail1);
						ResultSet rsdetail1=stmttotal.executeQuery(sqls11);
						
						 
				
						if(rsdetail1.next()){

							bean.setLblpricitotalamount(rsdetail1.getString("priamount"));
							bean.setLblinttotalamount(rsdetail1.getString("interest"));
							bean.setLbltotalgridamount(rsdetail1.getString("amount"));
							bean.setLbltotalint(rsdetail1.getString("interest"));
						
							
					                 }
						stmttotal.close();
						 
						
						
						
						
						
						
						
						
						
						
						
						Statement stmtCPV0 = conn.createStatement ();
					//	String branch = session.getAttribute("BRANCHID").toString();

			    String sqls=" select vo.date,vo.venid, vo.rtype type, vo.rno, vo.expdeldt,vo.nettotal,vo.purno,vo.purdate,h.description,h.account,"
					+ "h.doc_no headdoc,round(dt.dwnpyt,2) dwnpyt, round(dt.loanamt,2) loanamt,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate, round(dt.perintst,2) perintst, "
					+ " if(dt.clcumtd=1,'Flat Rate','Diminishing Rate') clcumtd,dt.noinstmt,dt.sectychqno, dt.chqname,"
					+ "round(dt.amt,2) chqamount, if(dt.pytmtd=1,'Cheque','Direct Debit') pytmtd, dt.desc1,DATE_FORMAT(dt.uptodate,'%d.%m.%Y') uptodate, "
					+ " hh.description finaccname , hh.account finaccid,dt.finaccno findocno,h1.description bankaccname,h1.account bankaccid,dt.bankaccno bankdocno, "
					+ "h2.description intstaccname,h2.account intstaccid,dt.intstaccno instdocno,h3.description loanaccname,h3.account loanaccid,dt.bankaccno loandocno "
					+ "    from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid  left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
					+ "  left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no left join my_head h1 on h1.doc_no=dt.bankaccno left join "
					+ "  my_head h2 on h2.doc_no=dt.intstaccno left join my_head h3 on h3.doc_no=dt.loanaccno    where vo.clstatus=1  and vo.doc_no='"+docno+"' ";
			    
			  //  System.out.println("----------"+sqls);
			    
			    
			    
			    
			    
			    

						
						ResultSet resultSet1 = stmtCPV0.executeQuery(sqls);
				
				
						while (resultSet1.next()) {   
							bean.setFirstarray(1);
							bean.setLblstartdate(resultSet1.getString("stdate"));
							bean.setLbluptodate(resultSet1.getString("uptodate"));
							
							
							bean.setLbldownpayment(resultSet1.getString("dwnpyt"));
							bean.setLblloanamt(resultSet1.getString("loanamt"));
							bean.setLblsecucqNo(resultSet1.getString("sectychqno"));
							bean.setLblnameinchq(resultSet1.getString("chqname"));
							bean.setLblDesc(resultSet1.getString("desc1"));
							
							bean.setLblcalcumethod(resultSet1.getString("clcumtd"));
							
						
							
							bean.setLblpayval(resultSet1.getString("pytmtd"));
							
						
							bean.setLblanamt(resultSet1.getString("chqamount"));
							
							//setLblfinacc setLblfinaccName setLblbankacc setLblbankaccName setLblintacc getLblintaccName getLblloanacc setLblloanaccName

							bean.setLblfinacc(resultSet1.getString("finaccid"));
							bean.setLblfinaccName(resultSet1.getString("finaccname"));
							bean.setLblbankacc(resultSet1.getString("bankaccid"));
							bean.setLblbankaccName(resultSet1.getString("bankaccname"));
							bean.setLblintacc(resultSet1.getString("intstaccid")); 
							bean.setLblintaccName(resultSet1.getString("intstaccname"));
							bean.setLblloanacc(resultSet1.getString("loanaccid"));
							bean.setLblloanaccName(resultSet1.getString("loanaccname"));
							
							bean.setLblperinterst(resultSet1.getString("perintst"));
							bean.setLblnoofinst(resultSet1.getString("noinstmt"));
							
						
							
							
						}
				       
						stmtCPV0.close();    
				       
				       
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	 
	 
	 
	 
		
		public  JSONArray journalVoucherGridReloading(HttpSession session,String docNo) throws SQLException {
	     
	        
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
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
	        String branch = session.getAttribute("BRANCHID").toString();
	        
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtJVT = conn.createStatement();
	   
	   String sql= ("SELECT j.acno docno,j.description,j.curId currencyid,round(j.rate,2) rate,if(j.dramount>0,round(j.dramount*j.id,2),0) debit ,"
	     + "if(j.dramount<0,round(j.dramount*j.id,2),0) credit,round(j.ldramount*j.id,2) baseamount,j.ref_row sr_no, j.costtype,if(j.costcode=0,'',j.costcode) costcode,coalesce(c.costgroup,'') costgroup,t.atype type,"
	     + "t.account accounts,t.description accountname1,t.gr_type grtype,cr.type currencytype FROM my_jvtran j left join my_costunit c on j.costtype=c.costtype left join "
	     + "my_head t on j.acno=t.doc_no left join my_curr cr on cr.doc_no=j.curId WHERE j.dtype='VPU' and j.brhId='"+branch+"' and j.tr_no='"+docNo+"'");
	  // System.out.println("---------sql--"+sql);
	   ResultSet resultSet = stmtJVT.executeQuery (sql);
	  
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    
	    stmtJVT.close();
	    conn.close();
	  }catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }finally{
	    conn.close();
	   }
	  return RESULTDATA;
	    }
}
