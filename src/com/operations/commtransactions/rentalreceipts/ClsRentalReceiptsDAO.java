package com.operations.commtransactions.rentalreceipts;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.common.ClsApplyDelete;
import com.connection.ClsConnection;

public class ClsRentalReceiptsDAO {

	 ClsRentalReceiptsBean rentalReceiptsBean = new ClsRentalReceiptsBean();
	 
		public int trno,docno;
		public String dtype;
		public double rate;
	 
	 public int insert(Connection conn, Date rentalReceiptsDate, String formdetailcode, String cmbpaytype, int txtdocno, String cmbcardtype, String txtrefno, Date referenceDate, 
			 String txtdescription,int hidchckib, String cmbbranch, int txtcldocno,int txtacno,String cmbratype, String txtagreement, String cmbpayedas,double txtamount, 
			 double txtdiscount, double txtaddcharges,double txtamounts, double txtnetvalue, String txtdescriptions,String txtreceivedfrom, double txtapplyinvoiceapply,
			 ArrayList<String> applyinvoicearray,HttpSession session,HttpServletRequest request) throws SQLException {
			
		 		try{
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
		 			String currencytype="";
		 			
					int srno;
					String cardexist="0";
					
					if(cmbbranch==null){
						cmbbranch="";
					}
					
					CallableStatement stmtRRV = conn.prepareCall("{CALL rentalReceiptDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					stmtRRV.registerOutParameter(22, java.sql.Types.INTEGER);
					stmtRRV.setDate(1,rentalReceiptsDate); //date
					stmtRRV.setString(2,cmbpaytype); //paytype
					stmtRRV.setInt(3,txtdocno); //docno of my_head
					stmtRRV.setString(4,cmbcardtype==null?"0":cmbcardtype); //card Type
					stmtRRV.setString(5,txtrefno.equalsIgnoreCase("")?"0":txtrefno); //ref no
					stmtRRV.setDate(6,referenceDate); //referenceDate
					stmtRRV.setString(7,txtdescription); //description
					
					stmtRRV.setInt(8,hidchckib); //Inter-branch
					stmtRRV.setString(9,cmbbranch.equalsIgnoreCase("")?"0":cmbbranch); //branch
					stmtRRV.setInt(10,txtcldocno); //client docno
					stmtRRV.setString(11,txtagreement.trim().equalsIgnoreCase("")?"0":txtagreement); //agreement no.
					stmtRRV.setString(12,cmbpayedas); //payed as
					stmtRRV.setDouble(13,txtamount); //amount
					stmtRRV.setDouble(14,txtdiscount); //discount
					stmtRRV.setDouble(15,txtaddcharges); //additional charges
					stmtRRV.setDouble(16,txtamounts); //amounts
					stmtRRV.setDouble(17,txtnetvalue); //net amount
					stmtRRV.setString(18,txtdescriptions); //description
					stmtRRV.setString(19,txtreceivedfrom); //received from
					
					stmtRRV.setString(20,branch);
					stmtRRV.setString(21,userid);
					stmtRRV.setString(23,"A");
					int data=stmtRRV.executeUpdate();
					if(data<=0){
						stmtRRV.close();
						conn.close();
						return 0;
					}
					srno=stmtRRV.getInt("isrno");
					rentalReceiptsBean.setTxtsrno(srno);
					request.setAttribute("isrno", srno);
					
					 if(cmbpaytype.equalsIgnoreCase("2")){

				     String cardtype = "";
					 if(cmbcardtype.equalsIgnoreCase("1")){
						 cardtype="VISA";
					 }else{
						 cardtype="MASTER";
					 }
					 
					 /*Checking Card details in my_clbankdet*/
					 String sqlcard="select * from my_clbankdet where type='"+cardtype+"' and cardno='"+txtrefno+"' and exp_date='"+referenceDate+"' and rdocno="+txtcldocno+"";
					 ResultSet resultSetcard = stmtRRV.executeQuery(sqlcard);
					   
				     while (resultSetcard.next()) {
				        cardexist="1";
				     }
				     
				     /*Checking Card details in my_clbankdet Ends*/
				     
				     if(cardexist.equalsIgnoreCase("0")){
				    	 int rowno = 0;
						/*Selecting Rowno*/
						String sqlrow=("select coalesce(max(rowno)+1) srno from my_clbankdet where rdocno='"+txtcldocno+"'");
						ResultSet resultSetRow = stmtRRV.executeQuery(sqlrow);
						    
						 while (resultSetRow.next()) {
							 rowno=resultSetRow.getInt("srno");
						 }
						 /*Selecting Rowno Ends*/
				    	 
				    	 /*Inserting into my_clbankdet*/
						 String sqlcards=("insert into my_clbankdet (rowno, rdocno, type, cardno, exp_date, defaultcard) values ("+rowno+", '"+txtcldocno+"', '"+cardtype+"', '"+txtrefno+"', '"+referenceDate+"', 0)");
						 int datacards = stmtRRV.executeUpdate(sqlcards);
						 /*Inserting into my_clbankdet Ends*/
						
						 if(datacards<=0){
							    stmtRRV.close();
								conn.close();
								return 0;
							}
				       }
					 }
					 
					 /*Inserting into datalog*/
					 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+srno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','A')");
					 int datas = stmtRRV.executeUpdate(sqls);
					 /*Inserting into datalog Ends*/
					 
					int total = 0;
					
					/*Selecting Currency Rate*/
					
					String sql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							 +"where  coalesce(toDate,curdate())>='"+rentalReceiptsDate+"' and frmDate<='"+rentalReceiptsDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+currency+"'";
					
					ResultSet resultSet = stmtRRV.executeQuery(sql);
					    
					 while (resultSet.next()) {
					 rate=resultSet.getDouble("rate");
					 currencytype=resultSet.getString("type");
					 }
					 /*Selecting Currency Rate Ends*/

					
					 /*Selecting Accounts*/
						String sql1=("select acno,costtype,costcode from my_account where codeno in ('radditionalcharge','rdiscount','rsecurity')");
						ResultSet resultSet1 = stmtRRV.executeQuery(sql1);
						    
						String accounts="",costTypes="",costCodes="";
						while(resultSet1.next()) {
							 accounts+=resultSet1.getString("acno")+",";
							 costTypes+=resultSet1.getString("costtype")+",";
							 costCodes+=resultSet1.getString("costcode")+",";
						} 
						String account[]=accounts.split(",");
						String costType[]=costTypes.split(",");
						String costCode[]=costCodes.split(",");
						
						if(cmbpayedas.equalsIgnoreCase("3")){
						   txtacno=Integer.parseInt(account[2].toString());
						}
						 /*Selecting Accounts Ends*/
						
					 ArrayList<String> receiptarray= new ArrayList<String>();
					 
					    if(currencytype.equalsIgnoreCase("M")){
					    	receiptarray.add(txtdocno+"::"+txtnetvalue+"::"+(txtnetvalue)*rate+"::false:: "+txtdescriptions+"::0::0::"+branch); //Net-Total
					    }else{
					    	receiptarray.add(txtdocno+"::"+txtnetvalue+"::"+(txtnetvalue)/rate+"::false:: "+txtdescriptions+"::0::0::"+branch); //Net-Total
					    }
					 
					 	if(currencytype.equalsIgnoreCase("M")){
					 		receiptarray.add(txtacno+"::"+txtamount*-1+"::"+(txtamount)*rate*-1+"::true:: "+txtdescription+"::0::0::"+cmbbranch); //Amount
					 	}else{
					 		receiptarray.add(txtacno+"::"+txtamount*-1+"::"+(txtamount)/rate*-1+"::true:: "+txtdescription+"::0::0::"+cmbbranch); //Amount
					 	}
					 	
					    if(!(txtdiscount==0)){
					    	if(currencytype.equalsIgnoreCase("M")){
					    		receiptarray.add(account[1]+"::"+txtdiscount+"::"+(txtdiscount)*rate+"::false:: "+txtdescriptions+"::"+costType[1]+"::"+costCode[1]+"::"+cmbbranch); //Discount
					    	}else{
					    		receiptarray.add(account[1]+"::"+txtdiscount+"::"+(txtdiscount)/rate+"::false:: "+txtdescriptions+"::"+costType[1]+"::"+costCode[1]+"::"+cmbbranch); //Discount
					    	}
					    }
					    if(!(txtamounts==0)){
					    	if(currencytype.equalsIgnoreCase("M")){
					    		receiptarray.add(account[0]+"::"+txtamounts*-1+"::"+(txtamounts)*rate*-1+"::true:: "+txtdescriptions+"::"+costType[0]+"::"+costCode[0]+"::"+cmbbranch); //Additional Charge
					    	}else{
					    		receiptarray.add(account[0]+"::"+txtamounts*-1+"::"+(txtamounts)/rate*-1+"::true:: "+txtdescriptions+"::"+costType[0]+"::"+costCode[0]+"::"+cmbbranch); //Additional Charge
					    	}
					    }
					   
					if(hidchckib==0 && (cmbpaytype.equalsIgnoreCase("1")|| cmbpaytype.equalsIgnoreCase("2"))){
						int masterDocno=cashReceiptMasterInsertion(conn,srno,rentalReceiptsDate, txtdescription, txtdiscount, txtnetvalue, session, request);
						if(masterDocno>0){
							int detailInsertion=cashReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
							if(detailInsertion>0){
								String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
								ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
							    
								 while (resultSet8.next()) {
								 total=resultSet8.getInt("jvtotal");
								 }

								 if(total == 0){
									stmtRRV.close();
									return srno;
								 }
							 }
						 }
					}
					
					else if(hidchckib==1 && (cmbpaytype.equalsIgnoreCase("1")|| cmbpaytype.equalsIgnoreCase("2"))){
						int masterDocno=ibCashReceiptMasterInsertion(conn, srno,rentalReceiptsDate, txtdescription, txtdiscount, txtnetvalue, session, request);
						if(masterDocno>0){
						    int detailInsertion=ibCashReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, cmbbranch, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
						    if(detailInsertion>0){
						    	String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
								ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
							    
								 while (resultSet8.next()) {
								 total=resultSet8.getInt("jvtotal");
								 }
								 
								 if(total == 0){
									stmtRRV.close();
									return srno;
								 }
						    }
						 }
					}

					else if(hidchckib==0 && cmbpaytype.equalsIgnoreCase("3")){
						int masterDocno=bankReceiptMasterInsertion(conn, srno,rentalReceiptsDate, txtdescription, txtacno, txtrefno, referenceDate, txtdiscount, txtnetvalue, session, request);
						if(masterDocno>0){
						int detailInsertion=bankReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, referenceDate, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
							ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								stmtRRV.close();
								return srno;
							 }
						  }
						}
					}
					
					else if(hidchckib==1 && cmbpaytype.equalsIgnoreCase("3")){
						int masterDocno=ibBankReceiptMasterInsertion(conn,srno,rentalReceiptsDate, txtdescription, txtacno, txtrefno, referenceDate, txtdiscount, txtnetvalue, session, request);
						if(masterDocno>0){
						int detailInsertion=ibBankReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, referenceDate, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, cmbbranch, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
							ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								stmtRRV.close();
								return srno;
							 }
						  }
						}
					}
					stmtRRV.close();
			 }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }
			return 0;
		}

	 public boolean edit(Connection conn, int txtrentalreceiptdocno, String formdetailcode, Date rentalReceiptsDate,int txttranno, String txtdoctype, int txtsrno, String cmbpaytype, int txtdocno,String cmbcardtype, String txtrefno, 
			    Date referenceDate,String txtdescription, int hidchckib, String cmbbranch,int txtcldocno, int txtacno, String cmbratype,String txtagreement, 
			    String cmbpayedas, double txtamount,double txtdiscount, double txtaddcharges, double txtamounts,double txtnetvalue, String txtdescriptions,
				String txtreceivedfrom, double txtapplyinvoiceapply,ArrayList<String> applyinvoicearray, ArrayList<String> applyinvoiceupdatearray,HttpSession session) throws SQLException {

		 try{
				Statement stmtRRV = conn.createStatement();
			    trno = txttranno;
				int srno = txtsrno;
				int total = 0;
				String cardexist="0";
				int datacards=0;
			    docno = txtrentalreceiptdocno;
			    
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String currencytype="";
				
				if(cmbbranch==null){cmbbranch="0";}
				if(cmbcardtype==null){cmbcardtype="0";}
				if(cmbratype==null){cmbratype="0";}
				if(txtagreement==null){txtagreement="0";}
				if(txtagreement.equalsIgnoreCase("")){txtagreement="0";}
				
				/*Updating gl_rentreceipt*/
	            String sql=("update gl_rentreceipt set date='"+rentalReceiptsDate+"',cardtype="+cmbcardtype+",refno='"+txtrefno+"',refdate='"+referenceDate+"',paydesc='"+txtdescription+"',cldocno="+txtcldocno+","
	            		+ "rtype='"+cmbratype+"',aggno="+txtagreement+",payas="+cmbpayedas+",amount="+txtamount+",discount="+txtdiscount+",addchrgper="+txtaddcharges+",addchrgamt="+txtamounts+","
	            		+ "netamt="+txtnetvalue+",desc1='"+txtdescriptions+"',receivedfrm='"+txtreceivedfrom+"',brhId="+branch+",userId="+userid+" where brhid="+branch+" and srno="+srno+" and TR_NO="+trno+"");
	            int data = stmtRRV.executeUpdate(sql);
	            if(data<=0){
					stmtRRV.close();
					conn.close();
					return false;
				}
				/*Updating gl_rentreceipt Ends*/
	            
	            if(cmbpaytype.equalsIgnoreCase("2")){

				     String cardtype = "";
					 if(cmbcardtype.equalsIgnoreCase("1")){
						 cardtype="VISA";
					 }else{
						 cardtype="MASTER";
					 }
					 
					 /*Checking Card details in my_clbankdet*/
					 String sqlcard="select * from my_clbankdet where type='"+cardtype+"' and cardno='"+txtrefno+"' and exp_date='"+referenceDate+"' and rdocno="+txtcldocno+"";
					 ResultSet resultSetcard = stmtRRV.executeQuery(sqlcard);
					   
				     while (resultSetcard.next()) {
				        cardexist="1";
				     }
				     
				     /*Checking Card details in my_clbankdet Ends*/
				     if(cardexist.equalsIgnoreCase("1")){
				    	 /*Inserting into my_clbankdet*/
						 String sqlcards=("update my_clbankdet set type='"+cardtype+"', cardno='"+txtrefno+"', exp_date='"+referenceDate+"' where rdocno='"+txtcldocno+"'");
						 datacards = stmtRRV.executeUpdate(sqlcards);
						 /*Inserting into my_clbankdet Ends*/
						 if(datacards<=0){
							    stmtRRV.close();
								conn.close();
								return false;
							}
				    	 
				     }
				     
				     if(cardexist.equalsIgnoreCase("0")){
				    	 int rowno = 0;
						/*Selecting Rowno*/
						String sqlrow=("select coalesce(max(rowno)+1) srno from my_clbankdet where rdocno='"+txtcldocno+"'");
						ResultSet resultSetRow = stmtRRV.executeQuery(sqlrow);
						    
						 while (resultSetRow.next()) {
							 rowno=resultSetRow.getInt("srno");
						 }
						 /*Selecting Rowno Ends*/
				    	 
				    	 /*Inserting into my_clbankdet*/
						 String sqlcards=("insert into my_clbankdet (rowno, rdocno, type, cardno, exp_date, defaultcard) values ("+rowno+", '"+txtcldocno+"', '"+cardtype+"', '"+txtrefno+"', '"+referenceDate+"', 0)");
						 datacards = stmtRRV.executeUpdate(sqlcards);
						 /*Inserting into my_clbankdet Ends*/
						
						 if(datacards<=0){
							    stmtRRV.close();
								conn.close();
								return false;
							}
				         }
					 }
	            
	            /*Selecting Currency Rate*/
				
				String sqls = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						 +"where  coalesce(toDate,curdate())>='"+rentalReceiptsDate+"' and frmDate<='"+rentalReceiptsDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+currency+"'";
				ResultSet resultSets = stmtRRV.executeQuery(sqls);
				    
				 while (resultSets.next()) {
				 rate=resultSets.getDouble("rate");
				 currencytype=resultSets.getString("type");
				 }
				 /*Selecting Currency Rate Ends*/
				
				CallableStatement stmtRRV1 = conn.prepareCall("{CALL raReceiptDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRRV1.setDate(1,rentalReceiptsDate); //date
				stmtRRV1.setString(2,"RRV"+srno); //ref no
				stmtRRV1.setString(3,txtdescription); //description
				stmtRRV1.setDouble(4,(txtnetvalue+txtdiscount)); //total Amount
				stmtRRV1.setDouble(5,rate); //rate
				stmtRRV1.setString(6,txtrefno); // cheque no
				stmtRRV1.setDate(7,referenceDate); //cheque Date
				stmtRRV1.setInt(8,txtdocno); //accno
				
				stmtRRV1.setString(9,txtdoctype); //dtype
				stmtRRV1.setInt(10,txtacno); //acno
				stmtRRV1.setInt(11,srno); // serial no
				stmtRRV1.setString(12,formdetailcode); //code
				stmtRRV1.setString(13,company); //company
				stmtRRV1.setString(14,branch); //branch
				stmtRRV1.setString(15,userid); //userid
				stmtRRV1.setInt(16,trno); //trno
				stmtRRV1.setInt(17,docno); //doc No
				stmtRRV1.setString(18,"E");
				stmtRRV1.executeQuery();
				if(docno<=0){
					stmtRRV1.close();
					conn.close();
					return false;
				 }
				
				 /*Selecting Accounts*/
				String sql1=("select acno,costtype,costcode  from my_account where codeno in ('radditionalcharge','rdiscount','rsecurity')");
				ResultSet resultSet1 = stmtRRV.executeQuery(sql1);
				    
				String accounts="",costTypes="",costCodes="";
				while(resultSet1.next()) {
					 accounts+=resultSet1.getString("acno")+",";
					 costTypes+=resultSet1.getString("costtype")+",";
					 costCodes+=resultSet1.getString("costcode")+",";
				} 
				String account[]=accounts.split(",");
				String costType[]=costTypes.split(",");
				String costCode[]=costCodes.split(",");
				
				if(cmbpayedas.equalsIgnoreCase("3")){
				   txtacno=Integer.parseInt(account[2].toString());
				}
				 /*Selecting Accounts Ends*/
				
			 ArrayList<String> receiptarray= new ArrayList<String>();
			 
				 if(currencytype.equalsIgnoreCase("M")){
				 		receiptarray.add(txtdocno+"::"+txtnetvalue+"::"+(txtnetvalue)*rate+"::false:: "+txtdescriptions+"::0::0::"+branch); //Net-Total
				    }else{
				 		receiptarray.add(txtdocno+"::"+txtnetvalue+"::"+(txtnetvalue)/rate+"::false:: "+txtdescriptions+"::0::0::"+branch); //Net-Total
			    }
			 
				 if(currencytype.equalsIgnoreCase("M")){
				    receiptarray.add(txtacno+"::"+txtamount*-1+"::"+(txtamount)*rate*-1+"::true:: "+txtdescription+"::0::0::"+cmbbranch); //Amount
				 }else{
				    receiptarray.add(txtacno+"::"+txtamount*-1+"::"+(txtamount)/rate*-1+"::true:: "+txtdescription+"::0::0::"+cmbbranch); //Amount
				 }
			 
			    if(!(txtdiscount==0)){
			    	if(currencytype.equalsIgnoreCase("M")){
				 		receiptarray.add(account[1]+"::"+txtdiscount+"::"+(txtdiscount)*rate+"::false:: "+txtdescriptions+"::"+costType[1]+"::"+costCode[1]+"::"+cmbbranch); //Discount
			    	}else{
			    		receiptarray.add(account[1]+"::"+txtdiscount+"::"+(txtdiscount)/rate+"::false:: "+txtdescriptions+"::"+costType[1]+"::"+costCode[1]+"::"+cmbbranch); //Discount
			    	}
			    }
			    
			    if(!(txtamounts==0)){
			    	if(currencytype.equalsIgnoreCase("M")){
			    		receiptarray.add(account[0]+"::"+txtamounts*-1+"::"+(txtamounts)*rate*-1+"::true:: "+txtdescriptions+"::"+costType[0]+"::"+costCode[0]+"::"+cmbbranch); //Additional Charge
			    	}else{
			    		receiptarray.add(account[0]+"::"+txtamounts*-1+"::"+(txtamounts)/rate*-1+"::true:: "+txtdescriptions+"::"+costType[0]+"::"+costCode[0]+"::"+cmbbranch); //Additional Charge
			    	}
			    }
			    
				if(txtdoctype.equalsIgnoreCase("CRV")){
				    /*Apply-Invoicing Grid Updating*/
					for(int i=0;i< applyinvoiceupdatearray.size();i++){
					String[] applyupdate=applyinvoiceupdatearray.get(i).split("::");
					if(!applyupdate[0].equalsIgnoreCase("undefined") && !applyupdate[0].equalsIgnoreCase("NaN")){
					String sql6="update my_jvtran set out_amount='"+(applyupdate[0].equalsIgnoreCase("undefined") || applyupdate[0].equalsIgnoreCase("NaN") || applyupdate[0].isEmpty()?0:applyupdate[0])+"' where TRANID='"+(applyupdate[1].equalsIgnoreCase("undefined") || applyupdate[1].equalsIgnoreCase("NaN") || applyupdate[1].isEmpty()?0:applyupdate[1])+"'";
					int data6 = stmtRRV.executeUpdate(sql6);
						if(data6<=0){
							stmtRRV.close();
							conn.close();
							return false;
						}
					  }
					}
					/*Apply-Invoicing Grid Updating Ends*/
					
					/*Details Updating*/
					int detailInsertion = cashReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
					if(detailInsertion>0){
							
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }

							 if(total == 0){
								stmtRRV.close();
								return true;
							 }
					 }
				  /*Details Updating Ends*/
				}
				
				if(txtdoctype.equalsIgnoreCase("ICRV")){
					
					/*Apply-Invoicing Grid Updating*/
					for(int i=0;i< applyinvoiceupdatearray.size();i++){
					String[] applyupdate=applyinvoiceupdatearray.get(i).split("::");

					if(!applyupdate[0].equalsIgnoreCase("undefined") && !applyupdate[0].equalsIgnoreCase("NaN")){
					String sql6="update my_jvtran set out_amount='"+(applyupdate[0].equalsIgnoreCase("undefined") || applyupdate[0].equalsIgnoreCase("NaN") || applyupdate[0].isEmpty()?0:applyupdate[0])+"' where TRANID='"+(applyupdate[1].equalsIgnoreCase("undefined") || applyupdate[1].equalsIgnoreCase("NaN") || applyupdate[1].isEmpty()?0:applyupdate[1])+"'";
					int data6 = stmtRRV.executeUpdate(sql6);
						if(data6<=0){
							stmtRRV.close();
							conn.close();
							return false;
						}
					  }
					}
				/*Apply-Invoicing Grid Updating Ends*/
					
					/*Details Updating*/
					int detailInsertion = ibCashReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, cmbbranch, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								stmtRRV.close();
								return true;
							 }
					 }
				   /*Details Updating Ends*/
				}
				
				if(txtdoctype.equalsIgnoreCase("BRV")){
					/*Apply-Invoicing Grid Updating*/
					for(int i=0;i< applyinvoiceupdatearray.size();i++){
					String[] applyupdate=applyinvoiceupdatearray.get(i).split("::");

					if(!applyupdate[0].equalsIgnoreCase("undefined") && !applyupdate[0].equalsIgnoreCase("NaN")){
					String sql6="update my_jvtran set out_amount='"+(applyupdate[0].equalsIgnoreCase("undefined") || applyupdate[0].equalsIgnoreCase("NaN") || applyupdate[0].isEmpty()?0:applyupdate[0])+"' where TRANID='"+(applyupdate[1].equalsIgnoreCase("undefined") || applyupdate[1].equalsIgnoreCase("NaN") || applyupdate[1].isEmpty()?0:applyupdate[1])+"'";
					int data6 = stmtRRV.executeUpdate(sql6);
						if(data6<=0){
							stmtRRV.close();
							conn.close();
							return false;
						}
					  }
					}
				/*Apply-Invoicing Grid Updating Ends*/
					
					/*Details Updating*/
					int detailInsertion = bankReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, referenceDate, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								stmtRRV.close();
								return true;
							 }
					 }
				   /*Details Updating Ends*/
				}
				
				if(txtdoctype.equalsIgnoreCase("IBR")){
					/*Apply-Invoicing Grid Updating*/
					for(int i=0;i< applyinvoiceupdatearray.size();i++){
					String[] applyupdate=applyinvoiceupdatearray.get(i).split("::");

					if(!applyupdate[0].equalsIgnoreCase("undefined") && !applyupdate[0].equalsIgnoreCase("NaN")){
					String sql6="update my_jvtran set out_amount='"+(applyupdate[0].equalsIgnoreCase("undefined") || applyupdate[0].equalsIgnoreCase("NaN") || applyupdate[0].isEmpty()?0:applyupdate[0])+"' where TRANID='"+(applyupdate[1].equalsIgnoreCase("undefined") || applyupdate[1].equalsIgnoreCase("NaN") || applyupdate[1].isEmpty()?0:applyupdate[1])+"'";
					int data6 = stmtRRV.executeUpdate(sql6);
						if(data6<=0){
							stmtRRV.close();
							conn.close();
							return false;
						}
					  }
					}
				/*Apply-Invoicing Grid Updating Ends*/
					
					/*Details Updating*/
					int detailInsertion = ibBankReceiptDetailInsertion(conn,srno,txtdocno, txtacno, rentalReceiptsDate, txtrefno, referenceDate, cmbratype, txtagreement, txtamount, txtdiscount, txtaddcharges, txtamounts, txtnetvalue, txtdescriptions, cmbbranch, txtdescription, txtapplyinvoiceapply, receiptarray, applyinvoicearray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRV.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								stmtRRV.close();
								return true;
							 }
					 }
				   /*Details Updating Ends*/
				}
				
				stmtRRV.close();
	      }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
	        }
		return false;
		}

		public boolean delete(Connection conn, int txtrentalreceiptdocno, String formdetailcode, int txtsrno,int txttranno, String txtdoctype, int txtacno,  String cmbpayedas,String cmbratype,String txtagreement,HttpSession session) throws SQLException {
			
		 try{
				Statement stmtRRV = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				trno = txttranno;
				docno = txtrentalreceiptdocno;
				int srno = txtsrno,ap_trid=0;
				double amount=0.00,outamount=0.00;
				
				 /*Status change in gl_rentreceipt*/
				 String sql=("update gl_rentreceipt set STATUS=7 where brhid="+branch+" and srno="+srno+" and tr_no="+trno+"");
				 int data = stmtRRV.executeUpdate(sql);
				 if(data<=0){
						stmtRRV.close();
						conn.close();
						return false;
					}
				/*Status change in gl_rentreceipt Ends*/
				
				/*Deleting from gl_rpyt & gl_lpyt*/
				 if(cmbpayedas.equalsIgnoreCase("2") || cmbpayedas.equalsIgnoreCase("3")){
					 if(cmbratype.equalsIgnoreCase("RAG")){
						 String sql1=("Delete from gl_rpyt where rdocno="+txtagreement+" and recieptno="+srno+"");
						 int data1 = stmtRRV.executeUpdate(sql1);
					 }else if(cmbratype.equalsIgnoreCase("LAG")){
						 String sql1=("Delete from gl_lpyt where rdocno="+txtagreement+" and recieptno="+srno+"");
						 int data1 = stmtRRV.executeUpdate(sql1);
					 }
				 }
				 /*Deleting from gl_rpyt & gl_lpyt Ends*/
				        
				 /*ArrayList<String> tranidarray=new ArrayList<>();
				  String sql1="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txtacno+"";
				  ResultSet resultSet=stmtRRV.executeQuery(sql1);
				  
				  while(resultSet.next()){
				   tranidarray.add(resultSet.getString("tranid"));
				  }
				  
				  if(tranidarray.size()>0){
				  
				  ArrayList<String> outamtarray=new ArrayList<>();

				  for(int i=0;i<tranidarray.size();i++){
				   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i);
				   ResultSet resultSet1=stmtRRV.executeQuery(sql2);
				   
				   while(resultSet1.next()){
				    outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
				   } 

				  }
					
				  if(outamtarray.size()>0){
				  
				  for(int i=0;i<outamtarray.size();i++){
				   
				   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
				   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

				   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
				   int data1=stmtRRV.executeUpdate(sql4);
				   
				  }
				  
			     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0);
			     ResultSet resultSet2=stmtRRV.executeQuery(sql5);
			   
			     while(resultSet2.next()){
				   outamount= resultSet2.getDouble("outamount");
			     }
			   
			     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
			     int data3=stmtRRV.executeUpdate(sql4);
				   
				  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
				  int data2=stmtRRV.executeUpdate(sql3);
				   }
				 }*/   
				 int applydelete=0;
				 ClsApplyDelete applyDelete = new ClsApplyDelete();
				 applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				 if(applydelete<0){
				  		 System.out.println("*** ERROR IN APPLY DELETE ***");
				  		 stmtRRV.close();
				  		 conn.close();
				  		 return false;  
				 }
				 if(txtdoctype.equalsIgnoreCase("CRV") || txtdoctype.equalsIgnoreCase("ICRV")){
				/*Status change in my_cashbm*/
				 String sql6=("update my_cashbm set STATUS=7 where doc_no="+docno+" and TR_NO="+trno+"");
				 int data4 = stmtRRV.executeUpdate(sql6);
				 if(data4<=0){
						stmtRRV.close();
						conn.close();
						return false;
					}
				/*Status change in my_cashbm Ends*/
				 }
				 
				 if(txtdoctype.equalsIgnoreCase("BRV") || txtdoctype.equalsIgnoreCase("IBR")){
				 /*Status change in my_chqbm*/
				 String sql6=("update my_chqbm set STATUS=7 where tr_no="+trno+" and doc_no="+docno+"");
				 int data5 = stmtRRV.executeUpdate(sql6);
				 if(data5<=0){
						stmtRRV.close();
						conn.close();
						return false;
					}
				/*Status change in my_chqbm Ends*/
				 
				 /*Deleting from my_chqdet*/
				 String sql7=("DELETE FROM my_chqdet WHERE tr_no="+trno+"");
				 int data6 = stmtRRV.executeUpdate(sql7);
				 /*Deleting from my_chqdet Ends*/
				 }
				
				/*Status change in my_cashbd*/
				 String sql8=("update my_jvtran set STATUS=7 where doc_no="+docno+" and TR_NO="+trno+"");
				 int data7 = stmtRRV.executeUpdate(sql8);
				 if(data7<=0){
						stmtRRV.close();
						conn.close();
						return false;
					}
				/*Status change in my_cashbd Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+srno+",'"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtRRV.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
			rentalReceiptsBean.setTxtrentalreceiptdocno(docno);
			if (docno > 0) {
				stmtRRV.close();
				return true;
			}
		stmtRRV.close();
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return false;
	 }
		return false;
	}
     
		public  ClsRentalReceiptsBean getViewDetails(HttpSession session,int srNo) throws SQLException {
			ClsRentalReceiptsBean rentalReceiptsBean = new ClsRentalReceiptsBean();
			Connection conn = null;
			ClsConnection ClsConnection=new ClsConnection();

			
			try {
				conn = ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				Statement stmtRRV = conn.createStatement();
				
				String branch = session.getAttribute("BRANCHID").toString();
				
	            String sql= ("select m.mail1 as email,r.tr_no,r.rdocno,r.date,r.dtype,r.paytype,r.acno,r.cardtype,r.refno,r.refdate,r.paydesc,r.ib,r.ibbrchid,r.cldocno,r.rtype,r.aggno,if(r.posttrno>0,'POSTED',' ') posted,"
	            	+ "if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)) aggvocno,r.payas,r.amount,r.discount,r.addchrgper,r.addchrgamt,r.netamt,r.desc1,r.receivedfrm,t.description clientname,"
	            	+ "t.doc_no clientacno,t.account clientaccount,a.account rentalaccount,a.description rentalaccountname,sum(o.amount) appliedamount from gl_rentreceipt r left join "
	            	+ "my_jvtran j on r.tr_no=j.tr_no left join my_outd o on o.tranid=j.tranid left join my_acbook m on r.cldocno=m.cldocno  and m.dtype='CRM' left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') "
	            	+ "left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_head t on t.doc_no=m.acno left join my_head a on r.acno=a.doc_no where r.brhid='"+branch+"' "
	            	+ "and r.srno="+srNo);
	            
				ResultSet resultSet = stmtRRV.executeQuery(sql);
							
				while (resultSet.next()) {
					rentalReceiptsBean.setJqxRentalReceiptDate(resultSet.getDate("date").toString());
					rentalReceiptsBean.setTxtdoctype(resultSet.getString("dtype"));
					rentalReceiptsBean.setTxtrentalreceiptdocno(resultSet.getInt("rdocno"));
					rentalReceiptsBean.setTxtsrno(srNo);
					rentalReceiptsBean.setEmail(resultSet.getString("email"));
					rentalReceiptsBean.setHidcmbpaytype(resultSet.getString("paytype"));
					rentalReceiptsBean.setTxtaccid(resultSet.getInt("rentalaccount"));
					rentalReceiptsBean.setTxtaccname(resultSet.getString("rentalaccountname"));
					rentalReceiptsBean.setTxtdocno(resultSet.getInt("acno"));
					rentalReceiptsBean.setTxttranno(resultSet.getInt("tr_no"));
					rentalReceiptsBean.setHidcmbcardtype(resultSet.getString("cardtype"));
					rentalReceiptsBean.setTxtrefno(resultSet.getString("refno"));
					rentalReceiptsBean.setJqxReferenceDate(resultSet.getDate("refdate").toString());
					rentalReceiptsBean.setTxtdescription(resultSet.getString("paydesc"));
					
					rentalReceiptsBean.setHidchckib(resultSet.getInt("ib"));
					rentalReceiptsBean.setHidcmbbranch(resultSet.getString("ibbrchid"));
					rentalReceiptsBean.setTxtcldocno(resultSet.getInt("cldocno"));
					rentalReceiptsBean.setTxtacno(resultSet.getInt("clientacno"));
					rentalReceiptsBean.setTxtclientid(resultSet.getString("clientaccount"));
					rentalReceiptsBean.setTxtclientname(resultSet.getString("clientname"));
					rentalReceiptsBean.setHidcmbratype(resultSet.getString("rtype"));
					rentalReceiptsBean.setTxtagreement(resultSet.getString("aggno"));
					rentalReceiptsBean.setTxtagreementvocher(resultSet.getString("aggvocno"));
					rentalReceiptsBean.setHidcmbpayedas(resultSet.getString("payas"));
					
					rentalReceiptsBean.setTxtamount(resultSet.getInt("amount"));
					rentalReceiptsBean.setTxtdiscount(resultSet.getInt("discount"));
					rentalReceiptsBean.setTxtaddcharges(resultSet.getInt("addchrgper"));
					rentalReceiptsBean.setTxtamounts(resultSet.getInt("addchrgamt"));
					rentalReceiptsBean.setTxtnetvalue(resultSet.getInt("netamt"));
					rentalReceiptsBean.setTxtdescriptions(resultSet.getString("desc1"));
					rentalReceiptsBean.setTxtreceivedfrom(resultSet.getString("receivedfrm"));
					
					rentalReceiptsBean.setTxtapplyinvoiceamt(resultSet.getDouble("amount"));
					rentalReceiptsBean.setTxtapplyinvoiceapply(resultSet.getDouble("appliedamount"));
					rentalReceiptsBean.setTxtapplyinvoicebalance(resultSet.getDouble("amount")-resultSet.getDouble("appliedamount"));
					
					rentalReceiptsBean.setLblformposted(resultSet.getString("posted"));
				}
				stmtRRV.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return rentalReceiptsBean;
			}
		
		public  JSONArray applyInvoicingGrid(String accountno) throws SQLException {
	        List<ClsRentalReceiptsBean> applyInvoicingGridBean = new ArrayList<ClsRentalReceiptsBean>();
	        
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        ClsConnection ClsConnection=new ClsConnection();

	        ClsCommon ClsCommon=new ClsCommon();

	        
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRV1 = conn.createStatement();
					String joins="",casestatement="";
					
					joins=ClsCommon.getFinanceVocTablesJoins(conn);
	        		casestatement=ClsCommon.getFinanceVocTablesCase(conn);
					
					String sql="Select a.*,"+casestatement+"'0' dummy from (Select t1.doc_no transno,t1.acno,t1.tranid,t1.id,t1.date,t1.out_amount,t1.dtype transType,t1.curid currency,"
							+ "if(t1.rtype='RAG','Rental Agreement','Lease Agreement') rtype,t1.rdocno,t1.description, (t1.dramount - t1.out_amount) tramt, t1.brhid from my_jvtran t1 "
							+ "inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no where t1.status=3 and t1.acno="+accountno+" and t1.dramount > 0 "
							+ "and (t1.dramount - out_amount) != 0 group by t1.tranid) a"+joins+" order by date";
					
					ResultSet resultSet = stmtRRV1.executeQuery(sql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtRRV1.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
		
		public  JSONArray applyInvoicingGridReloading(String trno,String accountno) throws SQLException {
	        List<ClsRentalReceiptsBean> applyInvoicingGridReloadingBean = new ArrayList<ClsRentalReceiptsBean>();
	        
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        ClsConnection ClsConnection=new ClsConnection();

	        ClsCommon ClsCommon=new ClsCommon();

	        
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRV = conn.createStatement();
					String joins="",casestatement="";
					
					if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
	            	
					joins=ClsCommon.getFinanceVocTablesJoins(conn);
    		        casestatement=ClsCommon.getFinanceVocTablesCase(conn);
							
					String sql="Select a.*,"+casestatement+"'0' dummy from (select t.doc_no transno,t.id,t.dtype transType,if(t.rtype='RAG','Rental Agreement','Lease Agreement') rtype,"
	        				+ "t.rdocno,t.description description,t.date date,(t.dramount-t.out_amount+d.amount) tramt,d.amount applying,(t.dramount-t.out_amount) balance,"
	        				+ "t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM "
	        				+ "my_jvtran where TR_NO='"+trno+"'  and acno='"+accountno+"')) a"+joins+" order by date";
					
					ResultSet resultSet = stmtRRV.executeQuery (sql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtRRV.close();
					conn.close();
					}
				stmtRRV.close();
				conn.close();	
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
    
		public  JSONArray clientDetailsSearch() throws SQLException {
	        List<ClsRentalReceiptsBean> clientDetailsSearchBean = new ArrayList<ClsRentalReceiptsBean>();

	        JSONArray RESULTDATA=new JSONArray();
	        ClsConnection ClsConnection=new ClsConnection();

	        ClsCommon ClsCommon=new ClsCommon();

	        
	        Connection conn = null;
			
	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRV = conn.createStatement();
	            	
					ResultSet resultSet = stmtRRV.executeQuery ("select t.account,t.description,c.cldocno,c.acno from my_acbook c left join  my_head t on t.doc_no=c.acno where "
							+ "t.atype='AR'");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtRRV.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
		
		public  JSONArray agreementSearch(String sclname,String smob,String rno,String flno,String sregno,String rentaltype,String clientId) throws SQLException {
			
			ClsConnection ClsConnection=new ClsConnection();

			ClsCommon ClsCommon=new ClsCommon();

		     JSONArray RESULTDATA=new JSONArray();
		     String sqltest="";
		     
		     if(rentaltype.equalsIgnoreCase("RAG")){
		         if(!(sclname.equalsIgnoreCase(""))){
		          sqltest+=" and a.RefName like '%"+sclname+"%'";
		         }
		         if(!(smob.equalsIgnoreCase(""))){
		          sqltest+=" and a.per_mob like '%"+smob+"%'";
		         }
		         if(!(rno.equalsIgnoreCase(""))){
		          sqltest+=" and r.voc_no like '%"+rno+"%'";
		         }
		         if(!(flno.equalsIgnoreCase(""))){
		          sqltest+=" and r.fleet_no like '%"+flno+"%'";
		         }
		         if(!(sregno.equalsIgnoreCase(""))){
		          sqltest+=" and v.reg_no like '%"+sregno+"%'";
		         }
		     }
		     
		     else if(rentaltype.equalsIgnoreCase("LAG")){
		         if(!(sclname.equalsIgnoreCase(""))){
		          sqltest+=" and a.RefName like '%"+sclname+"%'";
		         }
		         if(!(smob.equalsIgnoreCase(""))){
		          sqltest+=" and a.per_mob like '%"+smob+"%'";
		         }
		         if(!(rno.equalsIgnoreCase(""))){
		          sqltest+=" and l.voc_no like '%"+rno+"%'";
		         }
		         if(!(flno.equalsIgnoreCase(""))){
		          sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
		         }
		         if(!(sregno.equalsIgnoreCase(""))){
		          sqltest+=" and v.reg_no like '%"+sregno+"%'";
		         }
		     }
		     
		     Connection conn=null;
		     
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtRRV = conn.createStatement();
			    
			    if(rentaltype.equalsIgnoreCase("RAG")){
				    
			    	String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
				      + " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where r.cldocno="+clientId+""+sqltest+" group by doc_no");
			    
			    ResultSet resultSet = stmtRRV.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtRRV.close();
			    conn.close();
			    }
			    
			    else if(rentaltype.equalsIgnoreCase("LAG")){
				     String sql=("select l.voc_no,l.doc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
				       + " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where l.cldocno="+clientId+""+sqltest+" group by doc_no"); 
			     
			     ResultSet resultSet = stmtRRV.executeQuery(sql);
			     RESULTDATA=ClsCommon.convertToJSON(resultSet);
			     
			     stmtRRV.close();
			     conn.close();
		       }
			 stmtRRV.close();
			 conn.close(); 
		  }catch(Exception e){
		     e.printStackTrace();
		     conn.close();
		  }finally{
			  conn.close();
		  }
	        return RESULTDATA;
	    }

		public  JSONArray cardSearch(String cldocno) throws SQLException {
	        List<ClsRentalReceiptsBean> clientDetailsSearchBean = new ArrayList<ClsRentalReceiptsBean>();
	        ClsConnection ClsConnection=new ClsConnection();

	        ClsCommon ClsCommon=new ClsCommon();

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			
	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRV = conn.createStatement();
	            	
					ResultSet resultSet = stmtRRV.executeQuery ("SELECT if(type='VISA',1,2) type,type cardtype,cardno,exp_date FROM my_clbankdet where rdocno='"+cldocno+"'");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtRRV.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
		
		public  JSONArray rrvMainSearch(HttpSession session,String accountName,String srNo,String date,String total,String refNo) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        ClsConnection ClsConnection=new ClsConnection();

	        ClsCommon ClsCommon=new ClsCommon();

	        
	        Connection conn = null;
	        
	        java.sql.Date sqlRAReceiptDate=null;
	        
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
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlRAReceiptDate = ClsCommon.changeStringtoSqlDate(date);
	        }
	        
	        String sqltest="";
	        
	        if(!(sqlRAReceiptDate==null)){
		         sqltest=sqltest+" and r.date='"+sqlRAReceiptDate+"'";
		        } 
	        if(!(srNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and r.srno like '%"+srNo+"%'";
	        }
	        if(!(refNo.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and r.refno like '%"+refNo+"%'";
		        }
	        if(!(accountName.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and t.description like '%"+accountName+"%'";
	        }
	        if(!(total.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and r.netamt like '%"+total+"%'";
	        }
	           
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmtRRV = conn.createStatement();
		       
		       String sql = "select r.srno,r.date,r.rdocno,r.refno,r.netamt,t.description,m.mail1 as email from gl_rentreceipt r left join my_acbook m on r.cldocno=m.cldocno"
			       		+ " and m.dtype='CRM' left join my_head t on t.doc_no=m.acno where r.brhid="+branch+" and r.STATUS <> 7" +sqltest;

		       ResultSet resultSet = stmtRRV.executeQuery(sql);
	
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
		       
		       stmtRRV.close();
		       conn.close();
	     }catch(Exception e){
	    	 e.printStackTrace();
	    	 conn.close();
	     }finally{
	    	 conn.close();
	     }
           return RESULTDATA;
       }
		
		public  ClsRentalReceiptsBean getPrint(HttpServletRequest request,int srno,int branch) throws SQLException {
			ClsRentalReceiptsBean bean = new ClsRentalReceiptsBean();
			ClsConnection ClsConnection=new ClsConnection();

			ClsCommon ClsCommon=new ClsCommon();

			Connection conn = null;
			
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtRRV = conn.createStatement();
			
			String sqls="select c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentreceipt r inner join my_brch b on "
				+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid "
				+ "from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.branch) where r.brhid="+branch+" and  r.srno="+srno+"";
			
			ResultSet resultSets = stmtRRV.executeQuery(sqls);

			while(resultSets.next()){
				bean.setLblcompname(resultSets.getString("company"));
				bean.setLblcompaddress(resultSets.getString("address"));
				bean.setLblcomptel(resultSets.getString("tel"));
				bean.setLblcompfax(resultSets.getString("fax"));
				bean.setLbllocation(resultSets.getString("location"));
				bean.setLblbranch(resultSets.getString("branchname"));
				bean.setLblcstno(resultSets.getString("cstno"));
				bean.setLblpan(resultSets.getString("pbno"));
				bean.setLblservicetax(resultSets.getString("stcno"));
				bean.setLblcomptel2(resultSets.getString("tel2"));
				bean.setLblcompwebsite(resultSets.getString("web"));
				bean.setLblcompemail(resultSets.getString("email"));
			}
			
			String accNo="",trno="";
			
			String sql="select r.tr_no,d.acno,coalesce(r.receivedfrm,' ') receivedfrm,coalesce(d.refname,' ') refname,r.aggno,r.rtype,round(r.amount,2) amount,r.srno,DATE_FORMAT(r.date ,'%d-%m-%Y') date,if(r.paytype=2,lpad(substr(r.refno,-4),16,'X'),r.refno) cardchqno,r.paydesc,"
				+ "CONCAT('( ',r.dtype,' - ',r.rdocno,' )') receiptdetails,if(paytype=1,'Cash',if(paytype=2,'Card','Cheque/Online')) paytype,if(payas=1,'On Account',if(payas=2,'Advance','Security')) payas,DATE_FORMAT(r.refdate,'%d-%m-%Y') chqdate,"
				+ "if(r.rtype='0','',if(r.rtype='RAG',rag.voc_no,lag.voc_no)) aggvocno,if(r.rtype='RAG',rag.mrano,lag.manualra) mrano,coalesce(DATE_FORMAT(rag.odate,'%d-%m-%Y'), DATE_FORMAT(lag.outdate,'%d-%m-%Y')) contractdate,u.user_name from "
				+ "gl_rentreceipt r left join gl_ragmt rag on (r.aggno=rag.doc_no and r.rtype='RAG') left join gl_lagmt lag on (r.aggno=lag.doc_no and r.rtype='LAG') left join my_acbook d "
				+ "on r.cldocno=d.cldocno and d.dtype='CRM' left join my_user u on r.userid=u.doc_no where r.brhid="+branch+" and r.srno="+srno+"";

			ResultSet resultSet = stmtRRV.executeQuery(sql);
			
			while(resultSet.next()){
				
				bean.setReceivedfrom(resultSet.getString("receivedfrm"));
				bean.setClientinfo(resultSet.getString("refname"));
				bean.setLbladvancesecurity(resultSet.getString("payas"));
				bean.setLbldescription(resultSet.getString("paydesc"));
				
				bean.setReceiptno(resultSet.getString("srno"));
				bean.setReceiptinfomore(resultSet.getString("receiptdetails"));
				bean.setReceiptdate(resultSet.getString("date"));
				bean.setRentalno(resultSet.getString("aggvocno"));
				bean.setRentaltype(resultSet.getString("rtype"));
				bean.setRefno(resultSet.getString("mrano"));
				bean.setContractstart(resultSet.getString("contractdate"));
				if(resultSet.getString("paytype").equalsIgnoreCase("Card")){
					bean.setCardno(resultSet.getString("cardchqno"));
					bean.setCardexp(resultSet.getString("chqdate"));
				}
				if(resultSet.getString("paytype").equalsIgnoreCase("Cheque/Online")){
					bean.setChqno(resultSet.getString("cardchqno"));
					bean.setChqdate(resultSet.getString("chqdate"));
				}
				bean.setPaymode(resultSet.getString("paytype"));
				bean.setAmount(resultSet.getString("amount"));

				ClsAmountToWords obj=new ClsAmountToWords();
				bean.setAmtinwords(obj.convertAmountToWords(resultSet.getString("amount")));
				
				bean.setTotal(resultSet.getString("amount"));
				bean.setPreparedby(resultSet.getString("user_name"));
				accNo=resultSet.getString("acno");
				trno=resultSet.getString("tr_no");
			}
			
			String sql1 = "",joins="",casestatement="";
			
			joins=ClsCommon.getFinanceVocTablesJoins(conn);
    		casestatement=ClsCommon.getFinanceVocTablesCase(conn);
    		
			sql1="Select "+casestatement+"a.id, a.transType, a.rtype, a.rdocno, a.description, a.date, a.tramt, a.applying, a.balance, a.out_amount, a.tranid, a.acno, a.currency from ("
					+ "select t.doc_no transno,t.id,t.dtype transType,t.rtype,t.rdocno,t.description description,DATE_FORMAT(t.date,'%d-%m-%Y') date,"
					+ "round((t.dramount-t.out_amount+d.amount),2) tramt,round(d.amount,2) applying,round((t.dramount-t.out_amount),2) balance,t.out_amount,t.tranid,t.acno,t.brhid,"
					+ "t.curId currency from my_outd d left join my_jvtran t on d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+accNo+"')) a"+joins+"";
			
			ResultSet resultSet1 = stmtRRV.executeQuery(sql1);
			
			ArrayList<String> printapplyingarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("transno")+"::"+resultSet1.getString("transtype")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("rtype")+"::"+resultSet1.getString("rdocno")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("tramt")+"::"+resultSet1.getString("applying")+"::"+resultSet1.getString("balance");
				printapplyingarray.add(temp1);
			}
			
			request.setAttribute("printapplyingsarray", printapplyingarray);
		
			stmtRRV.close();
		    conn.close();
		}catch(Exception e){
			 e.printStackTrace();
	    	 conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
		
		
		public int cashReceiptMasterInsertion(Connection conn,int srno,Date rentalReceiptsDate,String txtdescription,double txtdiscount, double txtnetvalue,
	    		HttpSession session,HttpServletRequest request) throws SQLException{
			
	    	try{
				CallableStatement stmtRRV;
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
		    	stmtRRV = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRRV.registerOutParameter(10, java.sql.Types.INTEGER);
				stmtRRV.registerOutParameter(11, java.sql.Types.INTEGER);
				
				stmtRRV.setDate(1,rentalReceiptsDate);
				stmtRRV.setString(2,"RRV"+srno);
				stmtRRV.setString(3,txtdescription);
				stmtRRV.setDouble(4,(txtnetvalue+txtdiscount));
				stmtRRV.setDouble(5,rate);
				stmtRRV.setString(6,"CRV");
				stmtRRV.setString(7,company);
				stmtRRV.setString(8,branch);
				stmtRRV.setString(9,userid);
				stmtRRV.setString(12,"A");
				int receiptmastercheck=stmtRRV.executeUpdate();
				if(receiptmastercheck<=0){
					stmtRRV.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRV.getInt("docNo");
				trno=stmtRRV.getInt("itranNo");
				dtype="CRV";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				
				rentalReceiptsBean.setTxtrentalreceiptdocno(docno);
				stmtRRV.close();
				return docno;
								
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	  }
	}
	    
	    public int cashReceiptDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,Date rentalReceiptsDate, String txtrefno, 
			 String cmbratype, String txtagreement, double txtamount, double txtdiscount, double txtaddcharges,double txtamounts, double txtnetvalue, String txtdescriptions, 
			 String txtdescription, double txtapplyinvoiceapply, ArrayList<String> receiptarray, ArrayList<String> applyinvoicearray, HttpSession session) throws SQLException{
		
		  try{
				Statement stmtRRV2 = conn.createStatement ();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				if(cmbratype==null){
					cmbratype="0";
				}
						
				if (docno > 0) {
					/*Details Saving*/
					for(int i=0;i< receiptarray.size();i++){
						String[] cashreceipt=receiptarray.get(i).split("::");
						if(!cashreceipt[0].trim().equalsIgnoreCase("undefined") && !cashreceipt[0].trim().equalsIgnoreCase("NaN")){
						int cash = 0;
						int id = 0;
						if(cashreceipt[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=-1;
						}
						else if(cashreceipt[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=1;
						}
						
						CallableStatement stmtRRV = conn.prepareCall("{CALL cashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_cashbd*/
						stmtRRV.setInt(19,trno); 
						stmtRRV.setInt(20,docno);
						stmtRRV.registerOutParameter(21, java.sql.Types.INTEGER);
						stmtRRV.setInt(1,i); //SR_NO
						stmtRRV.setString(2,(cashreceipt[0].trim().equalsIgnoreCase("undefined") || cashreceipt[0].trim().equalsIgnoreCase("NaN") || cashreceipt[0].trim().equalsIgnoreCase("") || cashreceipt[0].trim().isEmpty()?0:cashreceipt[0].trim()).toString());  //doc_no of my_head
						stmtRRV.setString(3,currency); //curId
						stmtRRV.setDouble(4,rate); //rate 
						stmtRRV.setInt(5,id); //#credit -1 / debit 1 
						stmtRRV.setString(6,(cashreceipt[1].trim().equalsIgnoreCase("undefined") || cashreceipt[1].trim().equalsIgnoreCase("NaN") || cashreceipt[1].trim().equalsIgnoreCase("") || cashreceipt[1].trim().isEmpty()?0:cashreceipt[1].trim()).toString()); //amount
						stmtRRV.setString(7,(cashreceipt[4].trim().equalsIgnoreCase("undefined") || cashreceipt[4].trim().equalsIgnoreCase("NaN") || cashreceipt[4].trim().equalsIgnoreCase("") || cashreceipt[4].trim().isEmpty()?0:cashreceipt[4].trim()).toString()); //description
						stmtRRV.setString(8,(cashreceipt[2].trim().equalsIgnoreCase("undefined") || cashreceipt[2].trim().equalsIgnoreCase("NaN") || cashreceipt[2].trim().equalsIgnoreCase("") || cashreceipt[2].trim().isEmpty()?0:cashreceipt[2].trim()).toString()); //baseamount
						stmtRRV.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRV.setString(10,(cashreceipt[5].trim().equalsIgnoreCase("undefined") || cashreceipt[5].trim().equalsIgnoreCase("NaN") || cashreceipt[5].trim().equalsIgnoreCase("") || cashreceipt[5].trim().isEmpty()?0:cashreceipt[5].trim()).toString()); //Cost Type
						stmtRRV.setString(11,(cashreceipt[6].trim().equalsIgnoreCase("undefined") || cashreceipt[6].trim().equalsIgnoreCase("NaN") || cashreceipt[6].trim().equalsIgnoreCase("") || cashreceipt[6].trim().isEmpty()?0:cashreceipt[6].trim()).toString()); //Cost Code
						/*my_cashbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRV.setDate(12,rentalReceiptsDate);
						stmtRRV.setString(13,"RRV"+srno);
						stmtRRV.setInt(14,id);  //id
						stmtRRV.setInt(15,0);  //out-amount
						/*my_jvtran Ends*/
						
						stmtRRV.setString(16,"CRV");
						stmtRRV.setString(17,branch);
						stmtRRV.setString(18,userid);
						stmtRRV.setString(22,"A");
						int receiptdetailcheck=stmtRRV.executeUpdate();
						if(receiptdetailcheck<=0){
							stmtRRV.close();
							conn.close();
							return 0;
						   }
	      				  }
					    }
					    /*Details Saving Ends*/
					
						/*Apply-Invoicing Grid Saving*/
						for(int i=0;i< applyinvoicearray.size();i++){
						String[] apply=applyinvoicearray.get(i).split("::");
						
						if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("0") && !apply[0].trim().equalsIgnoreCase("")){
						
						CallableStatement stmtRRV1 = conn.prepareCall("{CALL raReceiptApplyInvoiceDML(?,?,?,?,?,?,?)}");
						
						/*Insertion to my_outd*/
						stmtRRV1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
						stmtRRV1.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
						stmtRRV1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
						stmtRRV1.setInt(4,trno);  //tr_no
						stmtRRV1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
						stmtRRV1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
						stmtRRV1.setString(7,"A");	
						int applyreceiptcheck=stmtRRV1.executeUpdate();
							if(applyreceiptcheck<=0){
								stmtRRV1.close();
								conn.close();
								return 0;
							}
							/*Apply-Invoicing Grid Saving Ends*/
						 }
					}				
					
					/*Updating my_jvtran*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno+"");
						int data2 = stmtRRV2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					int trid = 0;
					int id = 0;
					/*Selecting Tran-Id*/
					String sql=("SELECT TRANID,ID FROM my_jvtran where TR_NO="+trno+" and acno="+txtacno+"");
					ResultSet resultSet = stmtRRV2.executeQuery(sql);
					    
					 while (resultSet.next()) {
					 trid=resultSet.getInt("TRANID");
					 id=resultSet.getInt("ID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid+"");
					int data3 = stmtRRV2.executeUpdate(sql3);
					if(data3<=0){
						stmtRRV2.close();
						conn.close();
						return 0;
					}
					/*Updating my_jvtran Ends*/
					
					/*Updating gl_rentreceipt*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rtype='"+cmbratype+"',rdocno="+docno+",dtype='CRV' where brhid="+branch+" and srno="+srno+"");
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}else{
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rdocno="+docno+",dtype='CRV' where brhid="+branch+" and srno="+srno+"");
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating gl_rentreceipt Ends*/
					
					/*Deleting account of value zero*/
					String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRV2.executeUpdate(sql2);
				     
				    String sql4=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRV2.executeUpdate(sql4);
				     /*Deleting account of value zero ends*/
				
				return docno;
			 }					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 0;
	}
	    
	    public int ibCashReceiptMasterInsertion(Connection conn,int srno,Date rentalReceiptsDate,String txtdescription,double txtdiscount, double txtnetvalue,
	    		HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
				CallableStatement stmtRRV;
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
		    	stmtRRV = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRRV.registerOutParameter(10, java.sql.Types.INTEGER);
				stmtRRV.registerOutParameter(11, java.sql.Types.INTEGER);
				
				stmtRRV.setDate(1,rentalReceiptsDate);
				stmtRRV.setString(2,"RRV"+srno);
				stmtRRV.setString(3,txtdescription);
				stmtRRV.setDouble(4,(txtnetvalue+txtdiscount));
				stmtRRV.setDouble(5,rate);
				stmtRRV.setString(6,"ICRV");
				stmtRRV.setString(7,company);
				stmtRRV.setString(8,branch);
				stmtRRV.setString(9,userid);
				stmtRRV.setString(12,"A");
				int receiptmastercheck=stmtRRV.executeUpdate();
				if(receiptmastercheck<=0){
					stmtRRV.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRV.getInt("docNo");
				trno=stmtRRV.getInt("itranNo");
				dtype="ICRV";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				rentalReceiptsBean.setTxtrentalreceiptdocno(docno);
				stmtRRV.close();
				return docno;
								
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
	}
	    
	 
	 public int ibCashReceiptDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,Date rentalReceiptsDate, String txtrefno, 
			 String cmbratype, String txtagreement, double txtamount, double txtdiscount, double txtaddcharges,double txtamounts, double txtnetvalue,  String txtdescriptions,String cmbbranch, 
			 String txtdescription, double txtapplyinvoiceapply, ArrayList<String> receiptarray, ArrayList<String> applyinvoicearray, HttpSession session) throws SQLException{
		
		  try{
                Statement stmtRRV2 = conn.createStatement ();
				
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				if(cmbratype==null){
					cmbratype="0";
				}
				
				if (docno > 0) {
					/*Details Saving*/
					for(int i=0;i< receiptarray.size();i++){
						String[] cashreceipt=receiptarray.get(i).split("::");
						if(!cashreceipt[0].trim().equalsIgnoreCase("undefined") && !cashreceipt[0].trim().equalsIgnoreCase("NaN")){
						
						int cash = 0;
						int id = 0;
						if(cashreceipt[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=-1;
						}
						else if(cashreceipt[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=1;
						}
						else{}
						
						CallableStatement stmtRRV = conn.prepareCall("{CALL ibCashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_cashbd*/
						stmtRRV.setInt(20,trno); 
						stmtRRV.setInt(21,docno);
						stmtRRV.registerOutParameter(22, java.sql.Types.INTEGER);
						stmtRRV.setInt(1,i); //SR_NO
						stmtRRV.setString(2,(cashreceipt[0].trim().equalsIgnoreCase("undefined") || cashreceipt[0].trim().equalsIgnoreCase("NaN") || cashreceipt[0].trim().equalsIgnoreCase("") || cashreceipt[0].trim().isEmpty()?0:cashreceipt[0].trim()).toString());  //doc_no of my_head
						stmtRRV.setString(3,currency); //curId
						stmtRRV.setDouble(4,rate); //rate 
						stmtRRV.setInt(5,id); //#credit -1 / debit 1 
						stmtRRV.setString(6,(cashreceipt[1].trim().equalsIgnoreCase("undefined") || cashreceipt[1].trim().equalsIgnoreCase("NaN") || cashreceipt[1].trim().equalsIgnoreCase("") || cashreceipt[1].trim().isEmpty()?0:cashreceipt[1].trim()).toString()); //amount
						stmtRRV.setString(7,(cashreceipt[4].trim().equalsIgnoreCase("undefined") || cashreceipt[4].trim().equalsIgnoreCase("NaN") || cashreceipt[4].trim().equalsIgnoreCase("") || cashreceipt[4].trim().isEmpty()?0:cashreceipt[4].trim()).toString()); //description
						stmtRRV.setString(8,(cashreceipt[2].trim().equalsIgnoreCase("undefined") || cashreceipt[2].trim().equalsIgnoreCase("NaN") || cashreceipt[2].trim().equalsIgnoreCase("") || cashreceipt[2].trim().isEmpty()?0:cashreceipt[2].trim()).toString()); //baseamount
						stmtRRV.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRV.setString(10,(cashreceipt[5].trim().equalsIgnoreCase("undefined") || cashreceipt[5].trim().equalsIgnoreCase("NaN") || cashreceipt[5].trim().equalsIgnoreCase("") || cashreceipt[5].trim().isEmpty()?0:cashreceipt[5].trim()).toString()); //Cost Type
						stmtRRV.setString(11,(cashreceipt[6].trim().equalsIgnoreCase("undefined") || cashreceipt[6].trim().equalsIgnoreCase("NaN") || cashreceipt[6].trim().equalsIgnoreCase("") || cashreceipt[6].trim().isEmpty()?0:cashreceipt[6].trim()).toString()); //Cost Code
						/*my_cashbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRV.setDate(12,rentalReceiptsDate);
						stmtRRV.setString(13,"RRV"+srno);
						stmtRRV.setInt(14,id);  //id
						stmtRRV.setInt(15,0);  //out-amount
						/*my_jvtran Ends*/
						
						stmtRRV.setString(16,"ICRV");
						stmtRRV.setString(17,(cashreceipt[7].trim().equalsIgnoreCase("undefined") || cashreceipt[7].trim().equalsIgnoreCase("NaN") || cashreceipt[7].trim().equalsIgnoreCase("") || cashreceipt[7].trim().isEmpty()?0:cashreceipt[7].trim()).toString());  //branch
						stmtRRV.setString(18,branch); //Main Branch
						stmtRRV.setString(19,userid);
						stmtRRV.setString(23,"A");
						int receiptdetailcheck=stmtRRV.executeUpdate();
						if(receiptdetailcheck<=0){
							stmtRRV.close();
							conn.close();
							return 0;
						   }
	      				 }
					    }
					    /*Details Saving Ends*/
					
					/*Apply-Invoicing Grid Saving*/
					for(int i=0;i< applyinvoicearray.size();i++){
					String[] apply=applyinvoicearray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("")){
					
					CallableStatement stmtRRV1 = conn.prepareCall("{CALL raReceiptApplyInvoiceDML(?,?,?,?,?,?,?)}");
					
					/*Insertion to my_outd*/
					stmtRRV1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtRRV1.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtRRV1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtRRV1.setInt(4,trno);  //tr_no
					stmtRRV1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtRRV1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtRRV1.setString(7,"A");	
					int applyreceiptcheck=stmtRRV1.executeUpdate();
					if(applyreceiptcheck==0){
						stmtRRV1.close();
						conn.close();
						return 0;
					  }
					/*Apply-Invoicing Grid Saving Ends*/
				     }
				    }				
					
					/*Updating my_jvtran*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno);
						int data2 = stmtRRV2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					int trid = 0,id = 0;
					/*Selecting Tran-Id & Id*/
					String sql=("SELECT TRANID,ID FROM my_jvtran where TR_NO="+trno+" and acno="+txtacno);
					ResultSet resultSet = stmtRRV2.executeQuery(sql);
					    
					 while (resultSet.next()) {
					 trid=resultSet.getInt("TRANID");
					 id=resultSet.getInt("ID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid);
					int data3 = stmtRRV2.executeUpdate(sql3);
					if(data3<=0){
						stmtRRV2.close();
						conn.close();
						return 0;
					}
					/*Updating my_jvtran Ends*/
					
					/*Updating gl_rentreceipt*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rtype='"+cmbratype+"',rdocno="+docno+",dtype='ICRV' where brhid="+branch+" and srno="+srno);
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					else{
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rdocno="+docno+",dtype='ICRV' where brhid="+branch+" and srno="+srno);
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating gl_rentreceipt Ends*/
					
				/*Deleting account of value zero*/
					String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRV2.executeUpdate(sql2);
				     
				    String sql4=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRV2.executeUpdate(sql4);
				/*Deleting account of value zero ends*/	
				
				return docno;
			}					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
	 }
		return 1;
	}
	 
	 public int bankReceiptMasterInsertion(Connection conn,int srno,Date rentalReceiptsDate,String txtdescription,int txtacno,String txtrefno, Date referenceDate,  
			 	double txtdiscount,double txtnetvalue,HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
				CallableStatement stmtRRV;
				Statement stmtRRV1 = conn.createStatement();
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				String accdescription = "";
				/*Selecting Account Name*/
				String sql=("SELECT description FROM my_head where doc_no="+txtacno+"");
				ResultSet resultSet = stmtRRV1.executeQuery(sql);
				    
				 while (resultSet.next()) {
					 accdescription=resultSet.getString("description");
				 }
				 /*Selecting Account Name Ends*/
				
		    	stmtRRV = conn.prepareCall("{CALL chqbmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		    	stmtRRV.registerOutParameter(13, java.sql.Types.INTEGER);
		    	stmtRRV.registerOutParameter(14, java.sql.Types.INTEGER);
		    	stmtRRV.setDate(1,rentalReceiptsDate);
		    	stmtRRV.setString(2,"RRV"+srno);
		    	stmtRRV.setString(3,txtdescription);
		    	stmtRRV.setString(4,txtrefno);
		    	stmtRRV.setDate(5,referenceDate);
		    	stmtRRV.setString(6,accdescription);
		    	stmtRRV.setDouble(7,(txtnetvalue+txtdiscount));
		    	stmtRRV.setDouble(8,rate);
		    	stmtRRV.setString(9,"BRV");
		    	stmtRRV.setString(10,company);
		    	stmtRRV.setString(11,branch);
		    	stmtRRV.setString(12,userid);
		    	stmtRRV.setString(15,"A");
				int receiptmastercheck=stmtRRV.executeUpdate();
				if(receiptmastercheck<=0){
					stmtRRV.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRV.getInt("docNo");
				trno=stmtRRV.getInt("itranNo");
				dtype="BRV";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				
				rentalReceiptsBean.setTxtrentalreceiptdocno(docno);
				stmtRRV.close();
				return docno;
								
	   }catch(Exception e){
		 	e.printStackTrace();	
		 	conn.close();
		 	return 0;
	 }
	}
	 
	 public int bankReceiptDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,Date rentalReceiptsDate, String txtrefno, 
			 Date referenceDate, String cmbratype, String txtagreement, double txtamount, double txtdiscount, double txtaddcharges,double txtamounts, double txtnetvalue, String txtdescriptions, 
			 String txtdescription, double txtapplyinvoiceapply, ArrayList<String> receiptarray, ArrayList<String> applyinvoicearray, HttpSession session) throws SQLException{
		
		  try{
                Statement stmtRRV2 = conn.createStatement();
				
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String pdc="0",pdcaccount="0";
				int days=0;
				
				if(cmbratype==null){
					cmbratype="0";
				}
				
				String sqld = "select DATEDIFF('"+referenceDate+"','"+rentalReceiptsDate+"') days";
				ResultSet rs = stmtRRV2.executeQuery(sqld);
				
				while(rs.next()) {
					days=rs.getInt("days");
				} 
				
				if(days>0){
					
					String strSql = "select acno from my_account where codeno='PDCRV'";
					ResultSet rs1 = stmtRRV2.executeQuery(strSql);
					
					while(rs1.next()) {
						pdcaccount=rs1.getString("acno");
					} 
					
					pdc="1";
				}
				
				if (docno > 0) {
					/*Insertion to my_chqdet*/
					String sql=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtrefno+"','"+referenceDate+"',"+txtacno+","+pdc+",'E',0,'"+trno+"','"+branch+"')");
					int data = stmtRRV2.executeUpdate(sql);
					if(data<=0){
						stmtRRV2.close();
						conn.close();
						return 0;
					}
					/*my_chqdet Ends*/
					 
					/*Details Saving*/
					for(int i=0;i< receiptarray.size();i++){
						String[] bankreceipt=receiptarray.get(i).split("::");
						if(!bankreceipt[0].trim().equalsIgnoreCase("undefined") && !bankreceipt[0].trim().equalsIgnoreCase("NaN")){
						int cash = 0;
						int id = 0;
						if(bankreceipt[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=-1;
						}
						else if(bankreceipt[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=1;
						}
						else{}
						
						CallableStatement stmtRRV = conn.prepareCall("{CALL chqbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_chqbd*/
						stmtRRV.setInt(21,trno); 
						stmtRRV.setInt(22,docno);
						stmtRRV.registerOutParameter(23, java.sql.Types.INTEGER);
						stmtRRV.setInt(1,i); //SR_NO
						stmtRRV.setString(2,(bankreceipt[0].trim().equalsIgnoreCase("undefined") || bankreceipt[0].trim().equalsIgnoreCase("NaN") || bankreceipt[0].trim().equalsIgnoreCase("") || bankreceipt[0].trim().isEmpty()?0:bankreceipt[0].trim()).toString());  //doc_no of my_head
						stmtRRV.setString(3,currency); //curId
						stmtRRV.setDouble(4,rate); //rate 
						stmtRRV.setInt(5,id); //#credit -1 / debit 1 
						stmtRRV.setString(6,(bankreceipt[1].trim().equalsIgnoreCase("undefined") || bankreceipt[1].trim().equalsIgnoreCase("NaN") || bankreceipt[1].trim().equalsIgnoreCase("") || bankreceipt[1].trim().isEmpty()?0:bankreceipt[1].trim()).toString()); //amount
						stmtRRV.setString(7,(bankreceipt[4].trim().equalsIgnoreCase("undefined") || bankreceipt[4].trim().equalsIgnoreCase("NaN") || bankreceipt[4].trim().equalsIgnoreCase("") || bankreceipt[4].trim().isEmpty()?0:bankreceipt[4].trim()).toString()); //description
						stmtRRV.setString(8,(bankreceipt[2].trim().equalsIgnoreCase("undefined") || bankreceipt[2].trim().equalsIgnoreCase("NaN") || bankreceipt[2].trim().equalsIgnoreCase("") || bankreceipt[2].trim().isEmpty()?0:bankreceipt[2].trim()).toString()); //baseamount
						stmtRRV.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRV.setString(10,(bankreceipt[5].trim().equalsIgnoreCase("undefined") || bankreceipt[5].trim().equalsIgnoreCase("NaN") || bankreceipt[5].trim().equalsIgnoreCase("") || bankreceipt[5].trim().isEmpty()?0:bankreceipt[5].trim()).toString()); //Cost Type
						stmtRRV.setString(11,(bankreceipt[6].trim().equalsIgnoreCase("undefined") || bankreceipt[6].trim().equalsIgnoreCase("NaN") || bankreceipt[6].trim().equalsIgnoreCase("") || bankreceipt[6].trim().isEmpty()?0:bankreceipt[6].trim()).toString()); //Cost Code
						/*my_chqbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRV.setDate(12,rentalReceiptsDate);
						stmtRRV.setString(13,pdc); //pdc
						stmtRRV.setString(14,pdcaccount); //pdc Account No
						stmtRRV.setString(15,"RRV"+srno);
						stmtRRV.setInt(16,id);  //id
						stmtRRV.setInt(17,0);  //out-amount
						/*my_jvtran Ends*/
						
						stmtRRV.setString(18,"BRV");
						stmtRRV.setString(19,branch);
						stmtRRV.setString(20,userid);
						stmtRRV.setString(24,"A");
						stmtRRV.execute();
						 if(stmtRRV.getInt("irowsNo")<=0){
							stmtRRV.close();
							conn.close();
							return 0;
						   }
	      				  }
					    }
					    /*Details Saving Ends*/
					
					/*Apply-Bank Invoicing Grid Saving*/
					for(int i=0;i< applyinvoicearray.size();i++){
					String[] apply=applyinvoicearray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("")){
					
					CallableStatement stmtRRV1 = conn.prepareCall("{CALL raReceiptApplyBankInvoiceDML(?,?,?,?,?,?,?)}");
					/*Insertion to my_outd*/
					stmtRRV1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtRRV1.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtRRV1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtRRV1.setInt(4,trno);  //tr_no
					stmtRRV1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtRRV1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtRRV1.setString(7,"A");	
					int applyreceiptcheck=stmtRRV1.executeUpdate();
					if(applyreceiptcheck<=0){
						stmtRRV1.close();
						conn.close();
						return 0;
					}
					/*Apply-Bank Invoicing Grid Saving Ends*/
				  }
					
				}
					
					/*Updating my_jvtran*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno);
						int data2 = stmtRRV2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRV2.close();
							conn.close();
							return 0;					
						}
					}
					/*Updating my_jvtran Ends*/
					
					int trid = 0,id = 0;
					/*Selecting Tran-Id & Id*/
					String sqls=("SELECT TRANID,ID FROM my_jvtran where TR_NO="+trno+" and acno="+txtacno);
					ResultSet resultSets = stmtRRV2.executeQuery(sqls);
					    
					 while (resultSets.next()) {
					 trid=resultSets.getInt("TRANID");
					 id=resultSets.getInt("ID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid);
					int data3 = stmtRRV2.executeUpdate(sql3);
					if(data3<=0){
						stmtRRV2.close();
						conn.close();
						return 0;					
					}
					/*Updating my_jvtran Ends*/
					
					/*Updating gl_rentreceipt*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rtype='"+cmbratype+"',rdocno="+docno+",dtype='BRV' where brhid="+branch+" and srno="+srno);
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;					
						}
					}
					else{
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rdocno="+docno+",dtype='BRV' where brhid="+branch+" and srno="+srno);
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;					
						}
					}
					/*Updating gl_rentreceipt Ends*/
					
					/*Deleting account of value zero*/
					String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRV2.executeUpdate(sql2);
				     
				    String sql4=("DELETE FROM my_chqbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRV2.executeUpdate(sql4);
				     /*Deleting account of value zero ends*/
				
				return docno;
			}					
	   }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	 
	 public int ibBankReceiptMasterInsertion(Connection conn,int srno,Date rentalReceiptsDate,String txtdescription,int txtacno,String txtrefno, Date referenceDate, double txtdiscount, 
			    double txtnetvalue,HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
				CallableStatement stmtRRV;
				Statement stmtRRV1 = conn.createStatement();
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				String accdescription = "";
				/*Selecting Account Name*/
				String sql=("SELECT description FROM my_head where doc_no="+txtacno+"");
				ResultSet resultSet = stmtRRV1.executeQuery(sql);
				    
				 while (resultSet.next()) {
					 accdescription=resultSet.getString("description");
				 }
				 /*Selecting Account Name Ends*/
				 
		    	stmtRRV = conn.prepareCall("{CALL chqbmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		    	stmtRRV.registerOutParameter(13, java.sql.Types.INTEGER);
		    	stmtRRV.registerOutParameter(14, java.sql.Types.INTEGER);
		    	stmtRRV.setDate(1,rentalReceiptsDate);
		    	stmtRRV.setString(2,"RRV"+srno);
		    	stmtRRV.setString(3,txtdescription);
		    	stmtRRV.setString(4,txtrefno);
		    	stmtRRV.setDate(5,referenceDate);
		    	stmtRRV.setString(6,accdescription);
		    	stmtRRV.setDouble(7,(txtnetvalue+txtdiscount));
		    	stmtRRV.setDouble(8,rate);
		    	stmtRRV.setString(9,"IBR");
		    	stmtRRV.setString(10,company);
		    	stmtRRV.setString(11,branch);
		    	stmtRRV.setString(12,userid);
		    	stmtRRV.setString(15,"A");
				int receiptmastercheck=stmtRRV.executeUpdate();
				if(receiptmastercheck<=0){
					stmtRRV.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRV.getInt("docNo");
				trno=stmtRRV.getInt("itranNo");
				dtype="IBR";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				
				rentalReceiptsBean.setTxtrentalreceiptdocno(docno);
				stmtRRV.close();
				return docno;
								
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
	}
	 
	
	 public int ibBankReceiptDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,Date rentalReceiptsDate, String txtrefno, Date referenceDate,
			 String cmbratype, String txtagreement, double txtamount, double txtdiscount, double txtaddcharges,double txtamounts, double txtnetvalue,  String txtdescriptions,String cmbbranch, 
			 String txtdescription,  double txtapplyinvoiceapply, ArrayList<String> receiptarray, ArrayList<String> applyinvoicearray, HttpSession session) throws SQLException{
		
		  try{
                Statement stmtRRV2 = conn.createStatement();
				
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String pdc="0",pdcaccount="0";
				int days=0;
				
				if(cmbratype==null){
					cmbratype="0";
				}
				
				String sqld = "select DATEDIFF('"+referenceDate+"','"+rentalReceiptsDate+"') days";
				ResultSet rs = stmtRRV2.executeQuery(sqld);
				
				while(rs.next()) {
					days=rs.getInt("days");
				} 
				
				if(days>0){
					
					String strSql = "select acno from my_account where codeno='PDCRV'";
					ResultSet rs1 = stmtRRV2.executeQuery(strSql);
					
					while(rs1.next()) {
						pdcaccount=rs1.getString("acno");
					} 
					
					pdc="1";
				}
				
				if (docno > 0) {
					/*Insertion to my_chqdet*/
					String sql=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtrefno+"','"+referenceDate+"',"+txtacno+","+pdc+",'E',0,'"+trno+"','"+branch+"')");
					int data = stmtRRV2.executeUpdate(sql);
					if(data<=0){
						stmtRRV2.close();
						conn.close();
						return 0;					
					}
					/*my_chqdet Ends*/
					
					/*Details Saving*/
					for(int i=0;i< receiptarray.size();i++){
						String[] bankreceipt=receiptarray.get(i).split("::");
						if(!bankreceipt[0].trim().equalsIgnoreCase("undefined") && !bankreceipt[0].trim().equalsIgnoreCase("NaN")){
						
						int cash = 0;
						int id = 0;
						if(bankreceipt[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=-1;
						}
						else if(bankreceipt[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=1;
						}
						else{}
						
						CallableStatement stmtRRV = conn.prepareCall("{CALL ibChqbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_chqbd*/
						stmtRRV.setInt(22,trno); 
						stmtRRV.setInt(23,docno);
						stmtRRV.registerOutParameter(24, java.sql.Types.INTEGER);
						stmtRRV.setInt(1,i); //SR_NO
						stmtRRV.setString(2,(bankreceipt[0].trim().equalsIgnoreCase("undefined") || bankreceipt[0].trim().equalsIgnoreCase("NaN") || bankreceipt[0].trim().equalsIgnoreCase("") || bankreceipt[0].trim().isEmpty()?0:bankreceipt[0].trim()).toString());  //doc_no of my_head
						stmtRRV.setString(3,currency); //curId
						stmtRRV.setDouble(4,rate); //rate 
						stmtRRV.setInt(5,id); //#credit -1 / debit 1 
						stmtRRV.setString(6,(bankreceipt[1].trim().equalsIgnoreCase("undefined") || bankreceipt[1].trim().equalsIgnoreCase("NaN") || bankreceipt[1].trim().equalsIgnoreCase("") || bankreceipt[1].trim().isEmpty()?0:bankreceipt[1].trim()).toString()); //amount
						stmtRRV.setString(7,(bankreceipt[4].trim().equalsIgnoreCase("undefined") || bankreceipt[4].trim().equalsIgnoreCase("NaN") || bankreceipt[4].trim().equalsIgnoreCase("") || bankreceipt[4].trim().isEmpty()?0:bankreceipt[4].trim()).toString()); //description
						stmtRRV.setString(8,(bankreceipt[2].trim().equalsIgnoreCase("undefined") || bankreceipt[2].trim().equalsIgnoreCase("NaN") || bankreceipt[2].trim().equalsIgnoreCase("") || bankreceipt[2].trim().isEmpty()?0:bankreceipt[2].trim()).toString()); //baseamount
						stmtRRV.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRV.setString(10,(bankreceipt[5].trim().equalsIgnoreCase("undefined") || bankreceipt[5].trim().equalsIgnoreCase("NaN") || bankreceipt[5].trim().equalsIgnoreCase("") || bankreceipt[5].trim().isEmpty()?0:bankreceipt[5].trim()).toString()); //Cost Type
						stmtRRV.setString(11,(bankreceipt[6].trim().equalsIgnoreCase("undefined") || bankreceipt[6].trim().equalsIgnoreCase("NaN") || bankreceipt[6].trim().equalsIgnoreCase("") || bankreceipt[6].trim().isEmpty()?0:bankreceipt[6].trim()).toString()); //Cost Code
						/*my_chqbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRV.setDate(12,rentalReceiptsDate);
						stmtRRV.setString(13,pdc); //pdc
						stmtRRV.setString(14,pdcaccount); //pdc Account No
						stmtRRV.setString(15,"RRV"+srno);
						stmtRRV.setInt(16,id);  //id
						stmtRRV.setInt(17,0);  //out-amount
						/*my_jvtran Ends*/
						stmtRRV.setString(18,"IBR");
						stmtRRV.setString(19,(bankreceipt[7].trim().equalsIgnoreCase("undefined") || bankreceipt[7].trim().equalsIgnoreCase("NaN") || bankreceipt[7].trim().equalsIgnoreCase("") || bankreceipt[7].trim().isEmpty()?0:bankreceipt[7].trim()).toString()); //Branch
						stmtRRV.setString(20,branch); //Main Branch
						stmtRRV.setString(21,userid);
						stmtRRV.setString(25,"A");
                        stmtRRV.execute();
						 if(stmtRRV.getInt("irowsNo")<=0){
							stmtRRV.close();
							conn.close();
							return 0;
						   }
	      				  }
					    }
					    /*Details Saving Ends*/
					
					/*Apply-Bank Invoicing Grid Saving*/
					for(int i=0;i< applyinvoicearray.size();i++){
					String[] apply=applyinvoicearray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("")){
					
					CallableStatement stmtRRV1 = conn.prepareCall("{CALL raReceiptApplyBankInvoiceDML(?,?,?,?,?,?,?)}");
					/*Insertion to my_outd*/
					stmtRRV1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtRRV1.setString(2,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Applied amount
					stmtRRV1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtRRV1.setInt(4,trno);  //tr_no
					stmtRRV1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtRRV1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtRRV1.setString(7,"A");	
					int applyreceiptcheck=stmtRRV1.executeUpdate();
					if(applyreceiptcheck<=0){
						stmtRRV1.close();
						conn.close();
						return 0;
					}
					/*Apply-Bank Invoicing Grid Saving Ends*/
				  }
					
				}
					
					/*Updating my_jvtran*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno+"");
						int data2 = stmtRRV2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					int trid = 0,id = 0;
					/*Selecting Tran-Id*/
					String sqls=("SELECT TRANID,ID FROM my_jvtran where TR_NO="+trno+" and acno="+txtacno+"");
					ResultSet resultSets = stmtRRV2.executeQuery(sqls);
					    
					 while (resultSets.next()) {
					 trid=resultSets.getInt("TRANID");
					 id=resultSets.getInt("ID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid+"");
					int data3 = stmtRRV2.executeUpdate(sql3);
					if(data3<=0){
						stmtRRV2.close();
						conn.close();
						return 0;
					}
					/*Updating my_jvtran Ends*/
					
					/*Updating gl_rentreceipt*/
					if(!cmbratype.equalsIgnoreCase("0")){
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rtype='"+cmbratype+"',rdocno="+docno+",dtype='IBR' where brhid="+branch+" and srno="+srno+"");
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					else{
						String sql4=("update gl_rentreceipt set TR_NO="+trno+",rdocno="+docno+",dtype='IBR' where brhid="+branch+" and srno="+srno+"");
						int data4 = stmtRRV2.executeUpdate(sql4);
						if(data4<=0){
							stmtRRV2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating gl_rentreceipt Ends*/
					
					/*Deleting account of value zero*/
					String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRV2.executeUpdate(sql2);
				     
				    String sql4=("DELETE FROM my_chqbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRV2.executeUpdate(sql4);
				     /*Deleting account of value zero ends*/
				
				return docno;
			}					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

    public  ClsRentalReceiptsBean getPdf(HttpServletRequest request,int srno,int branch) throws SQLException {
			ClsRentalReceiptsBean bean = new ClsRentalReceiptsBean();
			Connection conn = null;
			ClsConnection ClsConnection=new ClsConnection();

			ClsCommon ClsCommon=new ClsCommon();

			
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtRRV = conn.createStatement();
			
			String sqls="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentreceipt r inner join my_brch b on "
				+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid "
				+ "from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.branch) where r.brhid="+branch+" and  r.srno="+srno+"";
			
			ResultSet resultSets = stmtRRV.executeQuery(sqls);

			while(resultSets.next()){
				bean.setLblcompname(resultSets.getString("company"));
				bean.setLblcompaddress(resultSets.getString("address"));
				bean.setLblcomptel(resultSets.getString("tel"));
				bean.setLblcompfax(resultSets.getString("fax"));
				bean.setLbllocation(resultSets.getString("location"));
				bean.setLblbranch(resultSets.getString("branchname"));
				bean.setLblcstno(resultSets.getString("cstno"));
				bean.setLblpan(resultSets.getString("pbno"));
				bean.setLblservicetax(resultSets.getString("stcno"));
			}
			
			String accNo="",trno="";
			
			String sql="select coalesce(r.tr_no,'') as tr_no,coalesce(d.acno,'') as acno,coalesce(r.receivedfrm,'') as receivedfrm,coalesce(d.refname,'') as refname,coalesce(r.aggno,'') as aggno,coalesce(r.rtype,'') as rtype,round(r.amount,2) amount,r.srno,DATE_FORMAT(r.date ,'%d-%m-%Y') date,coalesce(r.refno,'') cardchqno,coalesce(r.paydesc,'') as paydesc,"
				+ "CONCAT('( ',r.dtype,' - ',r.rdocno,' )') receiptdetails,if(paytype=1,'Cash',if(paytype=2,'Card','Cheque/Online')) paytype,if(payas=1,'On Account',if(payas=2,'Advance','Security')) payas,coalesce(DATE_FORMAT(r.refdate,'%d-%m-%Y'),'') as  chqdate,"
				+ "if(r.rtype='0','',if(r.rtype='RAG',rag.voc_no,lag.voc_no)) aggvocno,coalesce(if(r.rtype='RAG',rag.mrano,lag.manualra),'') as mrano,coalesce(DATE_FORMAT(rag.odate,'%d-%m-%Y'), coalesce(DATE_FORMAT(lag.outdate,'%d-%m-%Y')),'') as contractdate,coalesce(u.user_name,'') as user_name from "
				+ "gl_rentreceipt r left join gl_ragmt rag on (r.aggno=rag.doc_no and r.rtype='RAG') left join gl_lagmt lag on (r.aggno=lag.doc_no and r.rtype='LAG') left join my_acbook d "
				+ "on r.cldocno=d.cldocno and d.dtype='CRM' left join my_user u on r.userid=u.doc_no where r.brhid="+branch+" and r.srno="+srno+"";

			ResultSet resultSet = stmtRRV.executeQuery(sql);
			
			while(resultSet.next()){
				
				bean.setReceivedfrom(resultSet.getString("refname"));
				bean.setLbladvancesecurity(resultSet.getString("payas"));
				bean.setLbldescription(resultSet.getString("paydesc"));
				
				bean.setReceiptno(resultSet.getString("srno"));
				bean.setReceiptinfomore(resultSet.getString("receiptdetails"));
				bean.setReceiptdate(resultSet.getString("date"));
				bean.setRentalno(resultSet.getString("aggvocno"));
				bean.setRentaltype(resultSet.getString("rtype"));
				bean.setRefno(resultSet.getString("mrano"));
				bean.setContractstart(resultSet.getString("contractdate"));
				if(resultSet.getString("paytype").equalsIgnoreCase("Card")){
					bean.setCardno(resultSet.getString("cardchqno"));
					bean.setCardexp(resultSet.getString("chqdate"));
				}
				if(resultSet.getString("paytype").equalsIgnoreCase("Cheque")){
					bean.setChqno(resultSet.getString("cardchqno"));
					bean.setChqdate(resultSet.getString("chqdate"));
				}
				bean.setPaymode(resultSet.getString("paytype"));
				bean.setAmount(resultSet.getString("amount"));

				ClsNumberToWord obj=new ClsNumberToWord();
				bean.setAmtinwords(obj.convertNumberToWords(resultSet.getInt("amount"))+" only");
				
				bean.setTotal(resultSet.getString("amount"));
				bean.setPreparedby(resultSet.getString("user_name"));
				accNo=resultSet.getString("acno");
				trno=resultSet.getString("tr_no");
			}
			
			String sql1 = "";
			
			sql1="select @s:=@s+1 as srno,doc_no,id,dtype,rtype,rdocno,description,date,tramt,applying,balance,out_amount,tranid,acno,currency from"
					+ "(select coalesce(t.doc_no,'') doc_no,coalesce(t.id,'') id,coalesce(t.dtype,'') dtype,coalesce(t.rtype,'') as rtype,coalesce(t.rdocno,'') as rdocno,coalesce(t.description,'') as description,DATE_FORMAT(t.date,'%d-%m-%Y') date,"
					+ "round((t.dramount-t.out_amount+d.amount),2) tramt,round(d.amount,2) applying,round((t.dramount-t.out_amount),2) balance,"
					+ "coalesce(t.out_amount,'') as out_amount,coalesce(t.tranid,'') as tranid,coalesce(t.acno,'') as acno,coalesce(t.curId,'') currency from my_outd d "
				+ "left join my_jvtran t on d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"'  and acno='"+accNo+"'))as a,(SELECT @s:= 0) AS s;";
			
			ResultSet resultSet1 = stmtRRV.executeQuery(sql1);
			
			ArrayList<String> printapplyingarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp1="";
				temp1=resultSet1.getString("srno")+"::"+resultSet1.getString("doc_no")+"::"+resultSet1.getString("dtype")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("rtype")+"::"+resultSet1.getString("rdocno")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("tramt")+"::"+resultSet1.getString("applying")+"::"+resultSet1.getString("balance");
				printapplyingarray.add(temp1);
			}
			
			request.setAttribute("printapplyingsarray", printapplyingarray);
		
			stmtRRV.close();
		    conn.close();
		}catch(Exception e){
			 e.printStackTrace();
	    	 conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
 
		public  int getCompChk() throws SQLException {

			ClsConnection ClsConnection=new ClsConnection();

	        
	        Connection conn = null;
	        int isindian=0;
	    	
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmt1 = conn.createStatement ();
					HttpServletRequest request=ServletActionContext.getRequest();
					HttpSession session=request.getSession();
	            	
	           
					String strSql1 = "select method from gl_config where field_nme='indian'";

					ResultSet rs1 = stmt1.executeQuery(strSql1);
					while(rs1.next ()) {
						isindian=rs1.getInt("method");
					}
				

	              
					
			   	 stmt1.close();
					conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			
	        return isindian;
	    }	
		
		
	public  String getFileName(String formcode) throws SQLException {

		ClsConnection ClsConnection=new ClsConnection();

	        
	        Connection conn = null;
	        String path="";
	    	String fileName ="";
	    	String filepath="";
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmt1 = conn.createStatement ();
					HttpServletRequest request=ServletActionContext.getRequest();
					HttpSession session=request.getSession();
	            	
	            /*	Calendar now = GregorianCalendar.getInstance();
	       		 
	        		SimpleDateFormat df = new SimpleDateFormat("HH");
	        		String formattedDate = df.format(new Date())*/;
	        		
	        		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
	        		java.util.Date date = new java.util.Date();
	        		
	        		 //String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";
	            	
	        		String currdate=dateFormat.format(date);
	        		
					String strSql1 = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");

					ResultSet rs1 = stmt1.executeQuery(strSql1);
					while(rs1.next ()) {
						path=rs1.getString("imgPath");
					}
					
					 fileName = formcode+"["+request.getParameter("docno")+"]"+currdate+".pdf";
					
					 filepath=path+ "/attachment/"+formcode+"/"+fileName;
					 
//			    	ServletContext context = request.getServletContext();
			    	File dir = new File(path+ "/attachment/"+formcode);
			   	 	dir.mkdirs();

			   	 	stmt1.close();
					conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}

			return filepath;
	    }	 
	 



}
