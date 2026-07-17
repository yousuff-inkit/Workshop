package com.operations.commtransactions.rentalrefund;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;

public class ClsRentalRefundDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	 ClsRentalRefundBean rentalRefundBean = new ClsRentalRefundBean();
	 
		public int trno,docno;
		public double rate;
		public String dtype;
		Connection conn;
	 
	 public int insert(Date rentalRefundDate, String cmbpaytype, int txtdocno, String cmbcardtype, String txtchequeno, Date referenceDate, String txtdescription,int hidchckib, String cmbbranch,
			int txtcldocno, int txtacno, String cmbratype, String txtagreement, String cmbpayedas,int txtsecurityacno, double txtamount, double txtdeduction, double txtaddamount, double txtnetamount,double txtonaccountamount,
			String txtdescriptions,String txtpaidto,ArrayList<String> applysecurityarray,HttpSession session, HttpServletRequest request) throws SQLException {
			
	 		try{
	 			conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
	 			String branch=session.getAttribute("BRANCHID").toString().trim();
	 			String currency=session.getAttribute("CURRENCYID").toString().trim();
	 			String userid=session.getAttribute("USERID").toString().trim();
	 			String currencytype="";
				int srno;
				
				if(cmbcardtype.equalsIgnoreCase("")){
					cmbcardtype="0";
				}
				
				if(cmbratype==null){
					cmbratype="";
				}
				
				CallableStatement stmtRRP = conn.prepareCall("{CALL rentalRefundDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRRP.registerOutParameter(23, java.sql.Types.INTEGER);
				stmtRRP.setDate(1,rentalRefundDate); //date
				stmtRRP.setString(2,cmbpaytype); //paytype
				stmtRRP.setInt(3,txtdocno); //docno of my_head
				stmtRRP.setString(4,cmbcardtype==null?"0":cmbcardtype); //card Type
				stmtRRP.setString(5,txtchequeno.equalsIgnoreCase("")?"0":txtchequeno); //Cheque no
				stmtRRP.setDate(6,referenceDate); //Cheque Date
				stmtRRP.setString(7,txtdescription); //description
				
				stmtRRP.setInt(8,hidchckib); //Inter-branch
				stmtRRP.setString(9,cmbbranch.equalsIgnoreCase("")?"0":cmbbranch); //branch
				stmtRRP.setInt(10,txtcldocno); //client docno
				stmtRRP.setString(11,cmbratype); //agreement type
				stmtRRP.setString(12,txtagreement.equalsIgnoreCase("")?"0":txtagreement); //agreement no.
				stmtRRP.setString(13,cmbpayedas); //payed as
				stmtRRP.setDouble(14,txtamount); //amount
				stmtRRP.setDouble(15,txtdeduction); //deduction
				stmtRRP.setDouble(16,txtaddamount); //additional amount
				stmtRRP.setDouble(17,txtnetamount); //netamount
				stmtRRP.setDouble(18,txtonaccountamount); //on account amount
				stmtRRP.setString(19,txtdescriptions); //description
				stmtRRP.setString(20,txtpaidto); //Paid To
				
				stmtRRP.setString(21,branch);
				stmtRRP.setString(22,userid);
				stmtRRP.setString(24,"A");
				int data=stmtRRP.executeUpdate();
				if(data<=0){
					stmtRRP.close();
					conn.close();
					return 0;
				}
				srno=stmtRRP.getInt("isrno");
				
				rentalRefundBean.setTxtsrno(srno);
				
				if(cmbpaytype.equalsIgnoreCase("3")){

				     String cardtype = "",cardexist="";
					 if(!(cmbcardtype.equalsIgnoreCase(""))){
						    String strSql = "select mode from my_cardm where id=1 and dtype='card' and doc_no="+cmbcardtype+"";
							ResultSet rs = stmtRRP.executeQuery(strSql);
							
							while(rs.next()) {
								cardtype=rs.getString("mode");
							} 
					 }
					 
					 /*Checking Card details in my_clbankdet*/
					 String sqlcard="select * from my_clbankdet where type='"+cardtype+"' and cardno='"+txtchequeno+"' and exp_date='"+referenceDate+"' and rdocno="+txtcldocno+"";
					 ResultSet resultSetcard = stmtRRP.executeQuery(sqlcard);
					   
				     while (resultSetcard.next()) {
				        cardexist="1";
				     }
				     
				     /*Checking Card details in my_clbankdet Ends*/
				     
				     if(cardexist.equalsIgnoreCase("0")){
				    	 int rowno = 0;
						/*Selecting Rowno*/
						String sqlrow=("select coalesce(max(rowno)+1) srno from my_clbankdet where rdocno='"+txtcldocno+"'");
						ResultSet resultSetRow = stmtRRP.executeQuery(sqlrow);
						    
						 while (resultSetRow.next()) {
							 rowno=resultSetRow.getInt("srno");
						 }
						 /*Selecting Rowno Ends*/
				    	 
				    	 /*Inserting into my_clbankdet*/
						 String sqlcards=("insert into my_clbankdet (rowno, rdocno, type, cardno, exp_date, defaultcard) values ("+rowno+", '"+txtcldocno+"', '"+cardtype+"', '"+txtchequeno+"', '"+referenceDate+"', 0)");
						 int datacards = stmtRRP.executeUpdate(sqlcards);
						 /*Inserting into my_clbankdet Ends*/
						
						 if(datacards<=0){
							 	stmtRRP.close();
								conn.close();
								return 0;
							}
				       }
					 }
					 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+srno+"','"+branch+"','RRP',now(),'"+userid+"','A')");
				 int datas = stmtRRP.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				int total=0;
				/*Selecting Currency Rate*/
				
				String sql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						 +"where  coalesce(toDate,curdate())>='"+rentalRefundDate+"' and frmDate<='"+rentalRefundDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+currency+"'";
				
				ResultSet resultSet = stmtRRP.executeQuery(sql);
				    
				 while (resultSet.next()) {
				 rate=resultSet.getDouble("rate");
				 currencytype=resultSet.getString("type");
				 }
				 /*Selecting Currency Rate Ends*/
				 
				 int account=0,accountno=0;
				 ArrayList<String> refundarray= new ArrayList<String>();
				 
				 if(cmbpayedas.equalsIgnoreCase("1")){
					   accountno=txtsecurityacno;
					   account=txtacno;

					   if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)*rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}else{
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)/rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}
					   
					   if(currencytype.equalsIgnoreCase("M")){
						   refundarray.add(account+":: "+txtdeduction*-1+":: "+(txtdeduction)*rate*-1+":: false:: "+txtdescriptions+":: "+cmbbranch); //Deduction
					   }else{
						   refundarray.add(account+":: "+txtdeduction*-1+":: "+(txtdeduction)/rate*-1+":: false:: "+txtdescriptions+":: "+cmbbranch); //Deduction
					   }
					   
					   if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)*rate+":: true:: "+txtdescription+":: "+cmbbranch); //Amount
					 	}else{
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)/rate+":: true::"+txtdescription+":: "+cmbbranch); //Amount
					 	}
					   
					   if(currencytype.equalsIgnoreCase("M")){
						   refundarray.add(account+":: "+txtaddamount+":: "+(txtaddamount)*rate+":: true:: "+txtdescriptions+":: "+cmbbranch); //Additional Amount
					   }else{
						   refundarray.add(account+":: "+txtaddamount+":: "+(txtaddamount)/rate+":: true:: "+txtdescriptions+":: "+cmbbranch); //Additional Amount
					   }
					   
					}
				 else if(cmbpayedas.equalsIgnoreCase("2")){
					 accountno=txtacno;
					 txtamount=txtonaccountamount;
					 txtnetamount=txtonaccountamount;
					 
					 if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)*rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}else{
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)/rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}
					
					 	if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)*rate+":: true:: "+txtdescription+":: "+cmbbranch); //Amount
					 	}else{
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)/rate+":: true::"+txtdescription+":: "+cmbbranch); //Amount
					 	}
				 }
				 	
				if(hidchckib==0 && (cmbpaytype.equalsIgnoreCase("1")|| cmbpaytype.equalsIgnoreCase("3"))){
					int masterDocno=cashPaymentMasterInsertion(conn,srno,rentalRefundDate, txtdescription, txtdeduction, txtnetamount, txtonaccountamount, session, request);
					if(masterDocno>0){
						int detailInsertion=cashPaymentDetailInsertion(conn,srno,txtdocno, txtacno, txtsecurityacno, rentalRefundDate, txtchequeno, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction,txtnetamount, txtdescriptions, txtdescription, refundarray, applysecurityarray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
					
							 if(total == 0){
								conn.commit();
								stmtRRP.close();
								conn.close();
								return srno;
							 } else {
									System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
									stmtRRP.close();
									return 0;
							 }
						 }
					 }
				}
				
				else if(hidchckib==1 && (cmbpaytype.equalsIgnoreCase("1")|| cmbpaytype.equalsIgnoreCase("3"))){
					int masterDocno=ibCashPaymentMasterInsertion(conn, srno,rentalRefundDate, txtdescription, txtdeduction, txtnetamount, txtonaccountamount, session, request);
					if(masterDocno>0){
					    int detailInsertion=ibCashPaymentDetailInsertion(conn,srno,txtdocno, txtacno, txtsecurityacno, rentalRefundDate, txtchequeno, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction, txtnetamount, txtdescriptions, cmbbranch, txtdescription, refundarray, applysecurityarray, session);
					    if(detailInsertion>0){
					    	String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								conn.commit();
								stmtRRP.close();
								conn.close();
								return srno;
							 } else {
									System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
									stmtRRP.close();
									return 0;
							 }					    	
					     }
					 }
				}

				else if(hidchckib==0 && cmbpaytype.equalsIgnoreCase("2")){
					int masterDocno=bankPaymentMasterInsertion(conn, srno,rentalRefundDate, txtdescription, txtacno, txtpaidto, txtchequeno, referenceDate, txtdeduction, txtnetamount, txtonaccountamount, session, request);
					if(masterDocno>0){
					int detailInsertion=bankPaymentDetailInsertion(conn,srno,txtdocno, txtacno, txtsecurityacno, rentalRefundDate, txtchequeno, referenceDate, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction, txtnetamount, txtdescriptions, txtdescription, refundarray, applysecurityarray, session);
					if(detailInsertion>0){
						String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
						ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
					    
						 while (resultSet8.next()) {
						 total=resultSet8.getInt("jvtotal");
						 }
						 
						 if(total == 0){
							conn.commit();
							stmtRRP.close();
							conn.close();
							return srno;
						 } else {
								System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
								stmtRRP.close();
								return 0;
						 }
					  }
					}
				}
				
				else if(hidchckib==1 && cmbpaytype.equalsIgnoreCase("2")){
					int masterDocno=ibBankPaymentMasterInsertion(conn,srno,rentalRefundDate, txtdescription, txtacno, txtpaidto, txtchequeno, referenceDate, txtdeduction, txtnetamount, txtonaccountamount, session, request);
					if(masterDocno>0){
					int detailInsertion=ibBankPaymentDetailInsertion(conn,srno,txtdocno, txtacno, txtsecurityacno, rentalRefundDate, txtchequeno, referenceDate, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction, txtnetamount, txtdescriptions, cmbbranch, txtdescription, refundarray, applysecurityarray, session);
					if(detailInsertion>0){
						String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
						ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
					    
						 while (resultSet8.next()) {
						 total=resultSet8.getInt("jvtotal");
						 }
						 
						 if(total == 0){
							conn.commit();
							stmtRRP.close();
							conn.close();
							return srno;
						 } else {
								System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
								stmtRRP.close();
								return 0;
						 }
					  }
					}
				}
				stmtRRP.close();
			    conn.close();
			 }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
			 }finally{
				 conn.close();
			 }
			return 0;
		}

	 public boolean edit(int txtrentalrefunddocno, String formdetailcode,Date rentalRefundDate, int txttranno, String txtdoctype,int txtsrno, String cmbpaytype, 
			int txtdocno, String cmbcardtype, String txtchequeno,Date referenceDate, String txtdescription, int hidchckib,String cmbbranch, int txtcldocno, int txtacno, String cmbratype,
			String txtagreement, String cmbpayedas,int txtsecurityacno, double txtamount, double txtdeduction,  double txtaddamount, double txtnetamount, double txtonaccountamount, String txtdescriptions,
			String txtpaidto, ArrayList<String> applysecurityarray,HttpSession session) throws SQLException {

		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtRRP = conn.createStatement();
				
			    trno = txttranno;
				int srno = txtsrno;
				int total = 0,datacards=0;
			    docno = txtrentalrefunddocno;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String currencytype="",cardexist="0";
				
				if(cmbbranch=="null"){
					cmbbranch="0";
				}
				
				if(cmbcardtype==null){
					cmbcardtype="0";
				}
				
				/*Updating gl_rentrefund*/
	            String sql=("update gl_rentrefund set date='"+rentalRefundDate+"',cardtype="+cmbcardtype+",chequeno='"+txtchequeno+"',chequedate='"+referenceDate+"',refunddesc='"+txtdescription+"',"
	            		+ "cldocno="+txtcldocno+",rtype='"+cmbratype+"',aggno="+txtagreement+",paidas="+cmbpayedas+",amount="+txtamount+",deduction="+txtdeduction+",addamount="+txtaddamount+","
	            		+ "netamt="+txtnetamount+",onaccountamt="+txtonaccountamount+",desc1='"+txtdescriptions+"',paidto='"+txtpaidto+"',userid="+userid+",brhId="+branch+",audit=0 where brhId='"+branch+"' "
	            		+ "and srno="+srno+" and tr_no="+trno+"");
	            
	            int data = stmtRRP.executeUpdate(sql);
	            if(data<=0){
					stmtRRP.close();
					conn.close();
					return false;
				}
				/*Updating gl_rentrefund Ends*/
	            
				if(cmbpaytype.equalsIgnoreCase("3")){

	            	 String cardtype = "";
					 if(!(cmbcardtype.equalsIgnoreCase(""))){
						    String strSql = "select mode from my_cardm where id=1 and dtype='card' and doc_no="+cmbcardtype+"";
							ResultSet rs = stmtRRP.executeQuery(strSql);
							
							while(rs.next()) {
								cardtype=rs.getString("mode");
							} 
					 }
					 
					 /*Checking Card details in my_clbankdet*/
					 String sqlcard="select * from my_clbankdet where type='"+cardtype+"' and cardno='"+txtchequeno+"' and exp_date='"+referenceDate+"' and rdocno="+txtcldocno+"";
					 ResultSet resultSetcard = stmtRRP.executeQuery(sqlcard);
					   
				     while (resultSetcard.next()) {
				        cardexist="1";
				     }
				     
				     /*Checking Card details in my_clbankdet Ends*/
				     if(cardexist.equalsIgnoreCase("1")){
				    	 /*Inserting into my_clbankdet*/
						 String sqlcards=("update my_clbankdet set type='"+cardtype+"', cardno='"+txtchequeno+"', exp_date='"+referenceDate+"' where rdocno='"+txtcldocno+"'");
						 datacards = stmtRRP.executeUpdate(sqlcards);
						 /*Inserting into my_clbankdet Ends*/
						 if(datacards<=0){
							    stmtRRP.close();
								conn.close();
								return false;
							}
				    	 
				     }
				     
				     if(cardexist.equalsIgnoreCase("0")){
				    	 int rowno = 0;
						/*Selecting Rowno*/
						String sqlrow=("select coalesce(max(rowno)+1) srno from my_clbankdet where rdocno='"+txtcldocno+"'");
						ResultSet resultSetRow = stmtRRP.executeQuery(sqlrow);
						    
						 while (resultSetRow.next()) {
							 rowno=resultSetRow.getInt("srno");
						 }
						 /*Selecting Rowno Ends*/
				    	 
				    	 /*Inserting into my_clbankdet*/
						 String sqlcards=("insert into my_clbankdet (rowno, rdocno, type, cardno, exp_date, defaultcard) values ("+rowno+", '"+txtcldocno+"', '"+cardtype+"', '"+txtchequeno+"', '"+referenceDate+"', 0)");
						 datacards = stmtRRP.executeUpdate(sqlcards);
						 /*Inserting into my_clbankdet Ends*/
						
						 if(datacards<=0){
							    stmtRRP.close();
								conn.close();
								return false;
							}
				         }
					 }
					 
				/*Selecting Currency-Rate*/
	            
				String sqls = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						 +"where  coalesce(toDate,curdate())>='"+rentalRefundDate+"' and frmDate<='"+rentalRefundDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+currency+"'";
				
				ResultSet resultSets = stmtRRP.executeQuery(sqls);
				    
				 while (resultSets.next()) {
					 rate=resultSets.getDouble("rate");
					 currencytype=resultSets.getString("type");
				 }
				 
				 /*Selecting Currency-Rate Ends*/
				
				CallableStatement stmtRRV1 = conn.prepareCall("{CALL raRefundDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRRV1.setDate(1,rentalRefundDate); //date
				stmtRRV1.setString(2,"RRP"+srno); //ref no
				stmtRRV1.setString(3,txtdescription); //description
				stmtRRV1.setDouble(4,(txtnetamount+txtonaccountamount)); //total Amount
				stmtRRV1.setDouble(5,rate); //rate
				stmtRRV1.setString(6,txtchequeno); // cheque no
				stmtRRV1.setDate(7,referenceDate); //cheque Date
				
				stmtRRV1.setString(8,txtdoctype); //dtype
				stmtRRV1.setInt(9,txtdocno); //acno
				stmtRRV1.setInt(10,srno); // serial no
				stmtRRV1.setString(11,formdetailcode); //code
				stmtRRV1.setString(12,company); //company
				stmtRRV1.setString(13,branch); //branch
				stmtRRV1.setString(14,userid); //userid
				stmtRRV1.setInt(15,trno); //trno
				stmtRRV1.setInt(16,docno); //doc No
				stmtRRV1.setString(17,"E");
				stmtRRV1.executeQuery();
				if(docno<=0){
					stmtRRV1.close();
					conn.close();
					return false;
				 }
				
				int account=0,accountno=0;
				 ArrayList<String> refundarray= new ArrayList<String>();
				 
				 if(cmbpayedas.equalsIgnoreCase("1")){
					   accountno=txtsecurityacno;
					   account=txtacno;

					   if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)*rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}else{
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)/rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}
					   
					   if(currencytype.equalsIgnoreCase("M")){
						   refundarray.add(account+":: "+txtdeduction*-1+":: "+(txtdeduction)*rate*-1+":: false:: "+txtdescriptions+":: "+cmbbranch); //Deduction
					   }else{
						   refundarray.add(account+":: "+txtdeduction*-1+":: "+(txtdeduction)/rate*-1+":: false:: "+txtdescriptions+":: "+cmbbranch); //Deduction
					   }
					   
					   if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)*rate+":: true:: "+txtdescription+":: "+cmbbranch); //Amount
					 	}else{
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)/rate+":: true::"+txtdescription+":: "+cmbbranch); //Amount
					 	}
					   
					   if(currencytype.equalsIgnoreCase("M")){
						   refundarray.add(account+":: "+txtaddamount+":: "+(txtaddamount)*rate+":: true:: "+txtdescriptions+":: "+cmbbranch); //Additional Amount
					   }else{
						   refundarray.add(account+":: "+txtaddamount+":: "+(txtaddamount)/rate+":: true:: "+txtdescriptions+":: "+cmbbranch); //Additional Amount
					   }
					   
					}
				 else if(cmbpayedas.equalsIgnoreCase("2")){
					 accountno=txtacno;
					 txtamount=txtonaccountamount;
					 txtnetamount=txtonaccountamount;
					 
					 if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)*rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}else{
					 		refundarray.add(txtdocno+":: "+txtnetamount*-1+":: "+(txtnetamount)/rate*-1+":: false:: "+txtdescriptions+":: "+branch); //Net-Total
					 	}
					
					 	if(currencytype.equalsIgnoreCase("M")){
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)*rate+":: true:: "+txtdescription+":: "+cmbbranch); //Amount
					 	}else{
					 		refundarray.add(accountno+":: "+txtamount+":: "+(txtamount)/rate+":: true::"+txtdescription+":: "+cmbbranch); //Amount
					 	}
				 }
				 
				if(txtdoctype.equalsIgnoreCase("CPV")){
				    				
					/*Details Updating*/
					int detailInsertion=cashPaymentDetailInsertion(conn,srno,txtdocno, txtacno,txtsecurityacno, rentalRefundDate, txtchequeno, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction,txtnetamount, txtdescriptions, txtdescription, refundarray, applysecurityarray, session);
					if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }

							 if(total == 0){
								conn.commit();
								stmtRRP.close();
								conn.close();
								return true;
							 } else {
									System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
									stmtRRP.close();
									return false;
							 }
					 }
				  /*Details Updating Ends*/
				}
				
				if(txtdoctype.equalsIgnoreCase("ICPV")){
							
					/*Details Updating*/
					int detailInsertion=ibCashPaymentDetailInsertion(conn,srno,txtdocno, txtacno, txtsecurityacno, rentalRefundDate, txtchequeno, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction, txtnetamount, txtdescriptions, cmbbranch, txtdescription, refundarray, applysecurityarray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
							ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								conn.commit();
								stmtRRP.close();
								conn.close();
								return true;
							 }  else {
									System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
									stmtRRP.close();
									return false;
							 }
					 }
				   /*Details Updating Ends*/
				}
				
				if(txtdoctype.equalsIgnoreCase("BPV")){
										
					/*Details Updating*/
					int detailInsertion=bankPaymentDetailInsertion(conn,srno,txtdocno, txtacno, txtsecurityacno, rentalRefundDate, txtchequeno, referenceDate, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction, txtnetamount, txtdescriptions, txtdescription, refundarray, applysecurityarray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								conn.commit();
								stmtRRP.close();
								conn.close();
								return true;
							 }  else {
									System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
									stmtRRP.close();
									return false;
							 }
					 }
				   /*Details Updating Ends*/
				}
				
				if(txtdoctype.equalsIgnoreCase("IBP")){
										
					/*Details Updating*/
					int detailInsertion=ibBankPaymentDetailInsertion(conn,srno,txtdocno, txtacno, txtsecurityacno, rentalRefundDate, txtchequeno, referenceDate, cmbratype, txtagreement, cmbpayedas, txtamount, txtdeduction, txtnetamount, txtdescriptions, cmbbranch, txtdescription, refundarray, applysecurityarray, session);
						if(detailInsertion>0){
							String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
							ResultSet resultSet8 = stmtRRP.executeQuery(sql8);
						    
							 while (resultSet8.next()) {
							 total=resultSet8.getInt("jvtotal");
							 }
							 
							 if(total == 0){
								conn.commit();
								stmtRRP.close();
								conn.close();
								return true;
							 }  else {
									System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
									stmtRRP.close();
									return false;
							 }
					 }
				   /*Details Updating Ends*/
				}
				
				stmtRRP.close();
			    conn.close();
	      }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return false;
        }finally{
        	conn.close();
        }
	return false;
	}

	 public boolean delete(int txtrentalreceiptdocno, String formdetailcode, int txtsrno,int txttranno, String txtdoctype, int txtdocno, ArrayList<String> applysecurityupdatearray, HttpSession session) throws SQLException {
			
		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtRRP = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				trno = txttranno;
				docno = txtrentalreceiptdocno;
				int srno = txtsrno;
				int trid = 0;
				
				 /*Status change in gl_rentrefund*/
				 String sql=("update gl_rentrefund set STATUS=7 where brhId='"+branch+"' and srno="+srno+" and tr_no="+trno+"");
				 int data = stmtRRP.executeUpdate(sql);
				 if(data<=0){
						stmtRRP.close();
						conn.close();
						return false;
					}
				/*Status change in gl_rentrefund Ends*/
				 
				/*Selecting Tran Id*/
				String sql1=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txtdocno+"");
				ResultSet resultSet = stmtRRP.executeQuery(sql1);
				    
				 while (resultSet.next()) {
					 trid=resultSet.getInt("TRANID");
				 }
				 /*Selecting Tran Id Ends*/
				 
				 /*Apply-Invoicing Grid Updating*/
					for(int i=0;i< applysecurityupdatearray.size();i++){
					String[] applyupdate=applysecurityupdatearray.get(i).split("::");

					if(!applyupdate[0].equalsIgnoreCase("undefined") && !applyupdate[0].equalsIgnoreCase("NaN")){
					String sql2="update my_jvtran set out_amount='"+(applyupdate[0].equalsIgnoreCase("undefined") || applyupdate[0].equalsIgnoreCase("NaN") || applyupdate[0].isEmpty()?0:applyupdate[0])+"' where TRANID='"+(applyupdate[1].equalsIgnoreCase("undefined") || applyupdate[1].equalsIgnoreCase("NaN") || applyupdate[1].isEmpty()?0:applyupdate[1])+"'";
					int data1 = stmtRRP.executeUpdate(sql2);
						if(data1<=0){
							stmtRRP.close();
							conn.close();
							return false;
						}
					 }
					}
				/*Apply-Invoicing Grid Updating Ends*/
				
				 /*Deleting from my_outd*/
				 String sql3=("DELETE FROM my_outd WHERE TRANID="+trid);
				 int data3 = stmtRRP.executeUpdate(sql3);
				 /*Deleting from my_outd Ends*/
				 
				 if(txtdoctype.equalsIgnoreCase("CPV") || txtdoctype.equalsIgnoreCase("ICPV")){
				/*Status change in my_cashbm*/
				 String sql4=("update my_cashbm set STATUS=7 where doc_no="+docno+" and TR_NO="+trno);
				 int data4 = stmtRRP.executeUpdate(sql4);
				 if(data4<=0){
						stmtRRP.close();
						conn.close();
						return false;
					}
				/*Status change in my_cashbm Ends*/
				 }
				 
				 if(txtdoctype.equalsIgnoreCase("BPV") || txtdoctype.equalsIgnoreCase("IBP")){
				 /*Status change in my_chqbm*/
				 String sql5=("update my_chqbm set STATUS=7 where tr_no="+trno+" and doc_no="+docno+"");
				 int data5 = stmtRRP.executeUpdate(sql5);
				 if(data5<=0){
						stmtRRP.close();
						conn.close();
						return false;
					}
				/*Status change in my_chqbm Ends*/
				 
				 /*Deleting from my_chqdet*/
				 String sql6=("DELETE FROM my_chqdet WHERE tr_no="+trno+"");
				 int data6 = stmtRRP.executeUpdate(sql6);
				 /*Deleting from my_chqdet Ends*/
				 }
				
				/*Status change in my_cashbd*/
				 String sql7=("update my_jvtran set STATUS=7 where doc_no="+docno+" and TR_NO="+trno+"");
				 int data7 = stmtRRP.executeUpdate(sql7);
				 if(data7<=0){
						stmtRRP.close();
						conn.close();
						return false;
					}
				/*Status change in my_cashbd Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+srno+",'"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtRRP.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
			rentalRefundBean.setTxtrentalrefunddocno(docno);
			if (docno > 0) {
				
				conn.commit();
				stmtRRP.close();
				conn.close();
				return true;
			}
		stmtRRP.close();
		conn.close();
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return false;
	 }finally{
		 conn.close();
	 }
			return false;
		}
     
		public  ClsRentalRefundBean getViewDetails(HttpSession session,int srNo) throws SQLException {
			ClsRentalRefundBean rentalRefundBean = new ClsRentalRefundBean();
			Connection conn = null;
			
			try {
				conn = ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtRRP = conn.createStatement();
				
				String branch = session.getAttribute("BRANCHID").toString();
				
	            String sql= ("select (select t.doc_no from my_account ac inner JOIN MY_HEAD t on ac.acno=t.doc_no where ac.codeno='RSECURITY') securityacno,r.tr_no, r.date, r.dtype, r.rdocno, "
	            		+ "r.paytype, r.acno, r.cardtype, r.chequeno, r.chequedate, r.refunddesc, r.ib, r.ibbrchid, r.cldocno,r.rtype,r.aggno, if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)) aggvocno, "
	            		+ "r.paidas, r.amount, r.deduction,  r.addamount, r.netamt, r.onaccountamt, r.desc1, r.paidto,t.description clientname,t.doc_no clientacno,t.account clientaccount,a.account rentalaccount,"
	            		+ "a.description rentalaccountname from gl_rentrefund r left join my_acbook m on r.cldocno=m.cldocno and m.dtype='CRM' left join gl_ragmt ra on r.aggno=ra.doc_no left join "
	            		+ "gl_lagmt la on r.aggno=la.doc_no left join my_head t on t.doc_no=m.acno left join my_head a on r.acno=a.doc_no where r.brhid="+branch+" and r.srno="+srNo+"");
	            
				ResultSet resultSet = stmtRRP.executeQuery(sql);
							
				while (resultSet.next()) {
					rentalRefundBean.setJqxRentalRefundDate(resultSet.getDate("date").toString());
					rentalRefundBean.setTxtdoctype(resultSet.getString("dtype"));
					rentalRefundBean.setTxtrentalrefunddocno(resultSet.getInt("rdocno"));
					rentalRefundBean.setTxtsrno(srNo);
					
					rentalRefundBean.setHidcmbpaytype(resultSet.getString("paytype"));
					rentalRefundBean.setTxtaccid(resultSet.getInt("rentalaccount"));
					rentalRefundBean.setTxtaccname(resultSet.getString("rentalaccountname"));
					rentalRefundBean.setTxtdocno(resultSet.getInt("acno"));
					rentalRefundBean.setTxttranno(resultSet.getInt("tr_no"));
					rentalRefundBean.setHidcmbcardtype(resultSet.getString("cardtype"));
					rentalRefundBean.setTxtchequeno(resultSet.getString("chequeno"));
					rentalRefundBean.setJqxReferenceDate(resultSet.getDate("chequedate").toString());
					rentalRefundBean.setTxtdescription(resultSet.getString("refunddesc"));
					
					rentalRefundBean.setHidchckib(resultSet.getInt("ib"));
					rentalRefundBean.setHidcmbbranch(resultSet.getString("ibbrchid"));
					rentalRefundBean.setTxtcldocno(resultSet.getInt("cldocno"));
					rentalRefundBean.setTxtacno(resultSet.getInt("clientacno"));
					rentalRefundBean.setTxtclientid(resultSet.getString("clientaccount"));
					rentalRefundBean.setTxtclientname(resultSet.getString("clientname"));
					rentalRefundBean.setHidcmbratype(resultSet.getString("rtype"));
					rentalRefundBean.setTxtagreement(resultSet.getString("aggno"));
					rentalRefundBean.setTxtagreementvocher(resultSet.getString("aggvocno"));
					rentalRefundBean.setHidcmbpayedas(resultSet.getString("paidas"));
					
					rentalRefundBean.setTxtamount(resultSet.getInt("amount"));
					rentalRefundBean.setTxtdeduction(resultSet.getInt("deduction"));
					rentalRefundBean.setTxtaddamount(resultSet.getDouble("addamount"));
					rentalRefundBean.setTxtnetamount(resultSet.getInt("netamt"));
					rentalRefundBean.setTxtonaccountamount(resultSet.getInt("onaccountamt"));
					rentalRefundBean.setTxtdescriptions(resultSet.getString("desc1"));
					rentalRefundBean.setTxtpaidto(resultSet.getString("paidto"));
					rentalRefundBean.setTxtsecurityacno(resultSet.getInt("securityacno"));
				   }
				
				stmtRRP.close();
				conn.close();
			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
			}finally{
				conn.close();
			}
			return rentalRefundBean;
			}
		
		public  JSONArray accountsDetails(HttpSession session,String den) throws SQLException {
	        List<ClsRentalRefundBean> accountsDetailsBean = new ArrayList<ClsRentalRefundBean>();
	        String branch = session.getAttribute("BRANCHID").toString();
		    String company = session.getAttribute("COMPANYID").toString();
	        
		    JSONArray RESULTDATA=new JSONArray();
		    
		    Connection conn = null;
			
	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRP = conn.createStatement();
	            	
					String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
	            			+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
	            			+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den="+den+"";
	            	
					ResultSet resultSet = stmtRRP.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtRRP.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
		
		public  JSONArray securityGridDetails(String rentalDocNo, String rType) throws SQLException {
	        List<ClsRentalRefundBean> securityGridDetailsBean = new ArrayList<ClsRentalRefundBean>();
	        
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			
	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRP = conn.createStatement();
	            	
					String sql = "select (select t.doc_no from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where a.codeno='RSECURITY') securityacno,doc_no,dtype,"
							+ "date,description,tranid,curid currency,(dramount*id) amount,(out_amount*id) out_amount,(dramount-out_amount)*id balance,(dramount-out_amount)*id tobepaid "
							+ "from my_jvtran where status=3 and rdocno="+rentalDocNo+" and acno=(select t.doc_no from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where a.codeno='RSECURITY') "
							+ "and rtype='"+rType+"' and dramount<0 and (dramount-out_amount)<>0";
	            	
					ResultSet resultSet = stmtRRP.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtRRP.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
		
		public  JSONArray securityGridDetailsGridReloading(String trno,String accountno) throws SQLException {
	        List<ClsRentalRefundBean> securityGridDetailsGridReloadingBean = new ArrayList<ClsRentalRefundBean>();
	        
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRP = conn.createStatement();
					
					if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
	            	
					String sql="select jv.acno securityacno,jv.doc_no,jv.dtype,jv.date,jv.description,jv.tranid,jv.curid currency,jv.dramount*jv.id amount,"
							+ "(jv.out_amount*jv.id) out_amount,((jv.dramount)-jv.out_amount)*id balance,((jv.dramount)-jv.out_amount)*id tobepaid from my_outd d left join my_jvtran jv on d.ap_trid=jv.tranid "
							+ "where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO="+trno+"  and acno=(select t.doc_no from my_account ac inner JOIN MY_HEAD t on ac.acno=t.doc_no where ac.codeno='RSECURITY'))";
							
					ResultSet resultSet = stmtRRP.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);

					stmtRRP.close();
					conn.close();
					}
					stmtRRP.close();
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
	        List<ClsRentalRefundBean> clientDetailsSearchBean = new ArrayList<ClsRentalRefundBean>();
	        
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			
	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRP = conn.createStatement();
	            	
					ResultSet resultSet = stmtRRP.executeQuery ("select t.account,t.description,c.cldocno,c.acno from my_acbook c left join  my_head t on t.doc_no=c.acno where "
							+ "t.atype='AR'");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtRRP.close();
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
			    Statement stmtRRP= conn.createStatement();
			    
			    if(rentaltype.equalsIgnoreCase("RAG")){
				    
			    	String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
				      + " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where r.clstatus=1 and r.cldocno="+clientId+""+sqltest+" group by doc_no");
			    
			    ResultSet resultSet = stmtRRP.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtRRP.close();
			    conn.close();
			    }
			    
			    else if(rentaltype.equalsIgnoreCase("LAG")){
				     
			    	String sql=("select l.voc_no,l.doc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
				       + " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where l.clstatus=1 and l.cldocno="+clientId+""+sqltest+" group by doc_no"); 
			     
			     ResultSet resultSet = stmtRRP.executeQuery(sql);
			     RESULTDATA=ClsCommon.convertToJSON(resultSet);
			     
			     stmtRRP.close();
			     conn.close();
		       }
			 stmtRRP.close();
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

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			
	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtRRV = conn.createStatement();
	            	
					ResultSet resultSet = stmtRRV.executeQuery ("SELECT c.doc_no type,m.type cardtype,m.cardno,m.exp_date FROM my_clbankdet m left join my_cardm c on "
							+ "m.type=c.mode and c.id=1 and c.dtype='card' where m.rdocno='"+cldocno+"'");
					
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
		
		public  JSONArray rrpMainSearch(HttpSession session,String accountName,String srNo,String date,String total,String refNo) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
	        java.sql.Date sqlRARefundDate=null;
	        
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
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
	        	sqlRARefundDate = ClsCommon.changeStringtoSqlDate(date);
	        }
	        
	        String sqltest="";
	        
	        if(!(sqlRARefundDate==null)){
		         sqltest=sqltest+" and r.date='"+sqlRARefundDate+"'";
		        } 
	        if(!(srNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and r.srno like '%"+srNo+"%'";
	        }
	        if(!(refNo.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and r.chequeno like '%"+refNo+"%'";
		        }
	        if(!(accountName.equalsIgnoreCase(""))){
	        	 sqltest=sqltest+" and t.description like '%"+accountName+"%'";
	        }
	        if(!(total.equalsIgnoreCase(""))){
	        	 sqltest=sqltest+" and if(r.paidas=2,r.onaccountamt,r.netamt) like '%"+total+"%'";
	        }
	        
	           
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmtRRP = conn.createStatement();
		       
		       String sql = "select r.srno,r.date,r.rdocno,r.chequeno refno,if(r.paidas=2,r.onaccountamt,r.netamt) netamt,t.description from gl_rentrefund r left join my_acbook m on r.cldocno=m.cldocno"
			       		+ " and m.dtype='CRM' left join my_head t on t.doc_no=m.acno where r.brhid="+branch+" and r.STATUS <> 7" +sqltest;
		       
		       ResultSet resultSet = stmtRRP.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);

		       stmtRRP.close();
		       conn.close();
	     }catch(Exception e){
	    	 e.printStackTrace();
	    	 conn.close();
	     }finally{
	    	 conn.close();
	     }
	        return RESULTDATA;
	   }
		
		public  ClsRentalRefundBean getPrint(int srno,int branch) throws SQLException {
			ClsRentalRefundBean bean = new ClsRentalRefundBean();
			
			Connection conn = null;
			
		try {
			
			conn = ClsConnection.getMyConnection();
			Statement stmtRRP = conn.createStatement();
			
			String sqls="select c.company,c.address,c.web,c.tel,c.tel,c.tel2,c.email,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentrefund r inner join my_brch b on "
					+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid "
					+ "from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.branch) where r.brhid="+branch+" and  r.srno="+srno+"";
				
				ResultSet resultSets = stmtRRP.executeQuery(sqls);

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
			
			String sql="";
			
			sql="select d.refname,if(paidas=1,round(r.netamt,2),round(r.onaccountamt,2)) amount,r.srno,DATE_FORMAT(r.date ,'%d-%m-%Y') date,if(r.chequeno=0,'  ',if(r.paytype=3,lpad(substr(r.chequeno,-4),16,'X'),r.chequeno)) cardchqno,"
				+ "r.desc1,if(paytype=1,'Cash',if(paytype=2,'Cheque/Online','Paid to Card')) paytype,if(paidas=1,'Security','On Account') payas,r.rtype,DATE_FORMAT(r.chequedate,'%d-%m-%Y') chqdate,"
				+ "if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)) aggvocno,if(r.rtype='RAG',ra.mrano,la.manualra) mrano,coalesce(DATE_FORMAT(ra.odate,'%d-%m-%Y'),"
				+ "DATE_FORMAT(la.outdate,'%d-%m-%Y')) contractdate,u.user_name from gl_rentrefund r left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') left join "
				+ "gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_acbook d on r.cldocno=d.cldocno and d.dtype='CRM' left join my_user u on r.userid=u.doc_no "
				+ "where r.brhid="+branch+" and r.srno="+srno+"";
			
			ResultSet resultSet = stmtRRP.executeQuery(sql);
			
			while(resultSet.next()){
				
				bean.setReceivedfrom(resultSet.getString("refname"));
				
				bean.setLbladvancesecurity(resultSet.getString("payas"));
				bean.setLbldescription(resultSet.getString("desc1"));
				
				bean.setReceiptno(resultSet.getString("srno"));
				bean.setReceiptdate(resultSet.getString("date"));
				bean.setRentalno(resultSet.getString("aggvocno"));
				bean.setRentaltype(resultSet.getString("rtype"));
				bean.setRefno(resultSet.getString("mrano"));
				bean.setContractstart(resultSet.getString("contractdate"));
				if(resultSet.getString("paytype").equalsIgnoreCase("Paid to Card")){
					bean.setCardno(resultSet.getString("cardchqno"));
					bean.setCardexp(resultSet.getString("chqdate"));
				}
				if(resultSet.getString("paytype").equalsIgnoreCase("Cheque/Online")){
					bean.setChqno(resultSet.getString("cardchqno"));
					bean.setChqdate(resultSet.getString("chqdate"));
				}
				bean.setPaymode(resultSet.getString("paytype"));
				bean.setAmount(resultSet.getString("amount"));

				ClsNumberToWord obj=new ClsNumberToWord();
				bean.setAmtinwords(obj.convertNumberToWords(resultSet.getInt("amount"))+" only");
				
				bean.setTotal(resultSet.getString("amount"));
				bean.setPreparedby(resultSet.getString("user_name"));
			}
			stmtRRP.close();
			conn.close();
		}catch(Exception e){
			 e.printStackTrace();
	    	 conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	
		public  ClsRentalRefundBean getChequePrint(int docno,String dtype,int branch) throws SQLException {
			 ClsRentalRefundBean bean = new ClsRentalRefundBean();
			 Connection conn = null;
				
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRRP = conn.createStatement();
				String amountwordslength="";
				int accountno=0;
				
				String sqls="select d.acno from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='"+dtype+"' and m.brhid="+branch+" and "
						+ "m.doc_no="+docno+"";

				ResultSet resultSets = stmtRRP.executeQuery(sqls);
				
				while(resultSets.next()){
					accountno=resultSets.getInt("acno");
				}
				
				/* 1 pixel = 0.02645833333333 centimeter ## 1 centimeter = 37.79527559055 pixel */
				
				String sql="select round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
					+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
					+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
					+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
					+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
					+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
					+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status=3 and bankdocno="+accountno+"";
				
				ResultSet resultSet = stmtRRP.executeQuery(sql);
				
				while(resultSet.next()){
					
					bean.setLblpagesheight(resultSet.getString("chqheightin"));
					bean.setLblpageswidth(resultSet.getString("chqwidthin"));
					bean.setLblpageheight(resultSet.getString("chqheight"));
					bean.setLblpagewidth(resultSet.getString("chqwidth"));
					bean.setLblpaytovertical(resultSet.getString("paytover"));
					bean.setLblpaytohorizontal(resultSet.getString("paytohor"));
					bean.setLblpaytolength(resultSet.getString("paytolen"));
					bean.setLbldatex(resultSet.getString("chqdate_x"));
					bean.setLbldatey(resultSet.getString("chqdate_y"));
					
					bean.setLblaccountpayingx(resultSet.getString("accountpay_x"));
					bean.setLblaccountpayingy(resultSet.getString("accountpay_y"));
					bean.setLblamtwordsvertical(resultSet.getString("amtver"));
					bean.setLblamtwordshorizontal(resultSet.getString("amthor"));
					bean.setLblamtwordslength(resultSet.getString("amtlen"));
					bean.setLblamountx(resultSet.getString("amount_x"));
					bean.setLblamounty(resultSet.getString("amount_y"));
					bean.setLblamtwords1vertical(resultSet.getString("amt1ver"));
					bean.setLblamtwords1horizontal(resultSet.getString("amt1hor"));
					bean.setLblamtwords1length(resultSet.getString("amt1len"));
					
					amountwordslength=resultSet.getString("amtlen");
				}
				
					String sql1="select c.chqno,DATE_FORMAT(c.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN "  
						+ "t.description Else m.chqname END as 'description',(select round(if(d.amount<0,d.amount*-1,d.amount),2) amount from my_chqbm m "  
						+ "left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='"+dtype+"' and m.brhid="+branch+" and m.doc_no="+docno+") amount from my_chqbm m " 
						+ "left join my_chqbd d on m.tr_no=d.tr_no left join my_chqdet c on d.tr_no=c.tr_no left join my_head t on c.opsacno=t.doc_no "  
						+ "where m.dtype='"+dtype+"' and m.status=3 and m.brhid="+branch+" and m.doc_no="+docno+" group by m.tr_no";
				
					ResultSet resultSet1 = stmtRRP.executeQuery(sql1);
					
					while(resultSet1.next()){

						/* 1 character = 0.2116666666667 centimeter ## 1 centimeter = 4.724409448819 character
						   1 character = 8 pixel ## 1 pixel = 0.125 character */
						
						bean.setLblchequedate(resultSet1.getString("chqdt"));
						bean.setLblpaidto(resultSet1.getString("description"));
						bean.setLblamount(resultSet1.getString("amount"));
						
						ClsAmountToWords c = new ClsAmountToWords();
						
						double chequelength = Double.parseDouble(amountwordslength)*0.125;
						
						String amountwords = c.convertAmountToWords(resultSet1.getString("amount"));
						
						if(amountwords.length()>chequelength){
							
							String breakedstring = ClsCommon.addLinebreaks(amountwords, chequelength);
							
							if(breakedstring.contains("::")){
								String[] breakedstringarray = breakedstring.split("::");
							
								String amountinwords1 = breakedstringarray[0]; 
								String amountinwords2 = breakedstringarray[1];
							
								bean.setLblamountwords(amountinwords1);
								bean.setLblamountwords1(amountinwords2);
							}else{
								bean.setLblamountwords(breakedstring);
							}
						}else{
							bean.setLblamountwords(amountwords);
						}
					}
					
					stmtRRP.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return bean;
		}
		
		public int cashPaymentMasterInsertion(Connection conn,int srno,Date rentalRefundDate,String txtdescription,double txtdeduction, double txtnettotal,
	    		double txtonaccountamount, HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
	    		
				CallableStatement stmtRRP;
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
		    	stmtRRP = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRRP.registerOutParameter(10, java.sql.Types.INTEGER);
				stmtRRP.registerOutParameter(11, java.sql.Types.INTEGER);
				
				stmtRRP.setDate(1,rentalRefundDate);
				stmtRRP.setString(2,"RRP"+srno);
				stmtRRP.setString(3,txtdescription);
				stmtRRP.setDouble(4,(txtnettotal+txtonaccountamount));
				stmtRRP.setDouble(5,rate);
				stmtRRP.setString(6,"CPV");
				stmtRRP.setString(7,company);
				stmtRRP.setString(8,branch);
				stmtRRP.setString(9,userid);
				stmtRRP.setString(12,"A");
				int paymentmastercheck=stmtRRP.executeUpdate();
				if(paymentmastercheck<=0){
					stmtRRP.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRP.getInt("docNo");
				trno=stmtRRP.getInt("itranNo");
				dtype="CPV";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				
				rentalRefundBean.setTxtrentalrefunddocno(docno);
				stmtRRP.close();
				return docno;
								
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	  }
	}
	    
	    public int cashPaymentDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,int txtsecurityacno,Date rentalRefundDate, String txtchequeno, 
			 String cmbratype, String txtagreement, String cmbpayedas, double txtamount, double txtdeduction, double txtnettotal, String txtdescriptions, 
			 String txtdescription, ArrayList<String> refundarray, ArrayList<String> applysecurityarray, HttpSession session) throws SQLException{
		
		  try{
			    
				Statement stmtRRP2 = conn.createStatement();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				if (docno > 0) {
					/*Details Saving*/
					for(int i=0;i< refundarray.size();i++){
						String[] cashpayment=refundarray.get(i).split("::");
						if(!cashpayment[0].trim().equalsIgnoreCase("undefined") && !cashpayment[0].trim().equalsIgnoreCase("NaN")){
						int cash = 0;
						int id = 0;
						if(cashpayment[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=1;
						}
						else if(cashpayment[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=-1;
						}
						else{}
						
						CallableStatement stmtRRP = conn.prepareCall("{CALL cashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_cashbd*/
						stmtRRP.setInt(19,trno); 
						stmtRRP.setInt(20,docno);
						stmtRRP.registerOutParameter(21, java.sql.Types.INTEGER);
						stmtRRP.setInt(1,i); //SR_NO
						stmtRRP.setString(2,(cashpayment[0].trim().equalsIgnoreCase("undefined") || cashpayment[0].trim().equalsIgnoreCase("NaN") || cashpayment[0].trim().isEmpty()?0:cashpayment[0].trim()).toString());  //doc_no of my_head
						stmtRRP.setString(3,currency); //curId
						stmtRRP.setDouble(4,rate); //rate 
						stmtRRP.setInt(5,id); //#credit -1 / debit 1 
						stmtRRP.setString(6,(cashpayment[1].trim().equalsIgnoreCase("undefined") || cashpayment[1].trim().equalsIgnoreCase("NaN") || cashpayment[1].trim().isEmpty()?0:cashpayment[1].trim()).toString()); //amount
						stmtRRP.setString(7,(cashpayment[4].trim().equalsIgnoreCase("undefined") || cashpayment[4].trim().equalsIgnoreCase("NaN") || cashpayment[4].trim().isEmpty()?0:cashpayment[4].trim()).toString()); //description
						stmtRRP.setString(8,(cashpayment[2].trim().equalsIgnoreCase("undefined") || cashpayment[2].trim().equalsIgnoreCase("NaN") || cashpayment[2].trim().isEmpty()?0:cashpayment[2].trim()).toString()); //baseamount
						stmtRRP.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRP.setString(10,"0"); //Cost Type
						stmtRRP.setString(11,"0"); //Cost Code
						/*my_cashbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRP.setDate(12,rentalRefundDate);
						stmtRRP.setString(13,"RRP"+srno);
						stmtRRP.setInt(14,id);  //id
						stmtRRP.setInt(15,0);  //out-amount
						/*my_jvtran Ends*/
						
						stmtRRP.setString(16,"CPV");
						stmtRRP.setString(17,branch);
						stmtRRP.setString(18,userid);
						stmtRRP.setString(22,"A");
						int paymentdetailcheck=stmtRRP.executeUpdate();
						if(paymentdetailcheck<=0){
							stmtRRP.close();
							conn.close();
							return 0;
						   }
	      				  }
					    }
					    /*Details Saving Ends*/
				    
					/*Security-Apply Grid Saving*/
					for(int i=0;i< applysecurityarray.size();i++){
					String[] apply=applysecurityarray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("0") && !apply[0].trim().equalsIgnoreCase("")){
					
					CallableStatement stmtRRP1 = conn.prepareCall("{CALL raRefundApplyInvoiceDML(?,?,?,?,?,?,?)}");
					
					/*Insertion to my_outd*/
					stmtRRP1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtRRP1.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtRRP1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtRRP1.setInt(4,trno);  //tr_no
					stmtRRP1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtRRP1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtRRP1.setString(7,"A");
					int applysecuritycheck=stmtRRP1.executeUpdate();
						if(applysecuritycheck<=0){
							stmtRRP1.close();
							conn.close();
							return 0;
						}
						/*Security-Apply Grid Saving Ends*/
					 }
				  }				
					
					/*Updating my_jvtran*/
					if(!(cmbratype.equalsIgnoreCase("0"))){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno+"");
						int data2 = stmtRRP2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRP2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					 int accountsno=0,trid = 0;
					 if(cmbpayedas.equalsIgnoreCase("1")){
						 accountsno=txtsecurityacno;
						}
					 else if(cmbpayedas.equalsIgnoreCase("2")){
						 accountsno=txtacno;
					 }
					
					/*Selecting Tran-Id*/
					String sqls=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+accountsno);
					ResultSet resultSet = stmtRRP2.executeQuery(sqls);
					    
					 while (resultSet.next()) {
					 trid=resultSet.getInt("TRANID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					if(cmbpayedas.equalsIgnoreCase("1")){
						String sql3=("update my_jvtran set out_amount="+txtamount+" where tranid="+trid);
						int data3 = stmtRRP2.executeUpdate(sql3);
						if(data3<=0){
							stmtRRP2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					/*Updating gl_rentrefund*/
					String sql4=("update gl_rentrefund set TR_NO="+trno+",rdocno="+docno+",dtype='CPV' where brhid="+branch+" and srno="+srno);
					int data4 = stmtRRP2.executeUpdate(sql4);
					if(data4<=0){
						stmtRRP2.close();
						conn.close();
						return 0;
					}
					/*Updating gl_rentrefund Ends*/
					
					/*Deleting account of value zero*/
					String sql5=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRP2.executeUpdate(sql5);
				     
				    String sql6=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRP2.executeUpdate(sql6);
				    /*Deleting account of value zero ends*/
				    
				    /*Deleting amount of value zero*/
					String sql7=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
				    int data7 = stmtRRP2.executeUpdate(sql7);
				     
				    String sql8=("DELETE FROM my_cashbd where TR_NO="+trno+" and amount=0");
				    int data8 = stmtRRP2.executeUpdate(sql8);
				    /*Deleting amount of value zero ends*/
				
				return docno;
			 }					
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 0;
	}
	    
	    public int ibCashPaymentMasterInsertion(Connection conn,int srno,Date rentalRefundDate,String txtdescription,double txtdeduction, double txtnettotal,
	    		 double txtonaccountamount, HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
				CallableStatement stmtRRP;
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
		    	stmtRRP = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRRP.registerOutParameter(10, java.sql.Types.INTEGER);
				stmtRRP.registerOutParameter(11, java.sql.Types.INTEGER);
				
				stmtRRP.setDate(1,rentalRefundDate);
				stmtRRP.setString(2,"RRP"+srno);
				stmtRRP.setString(3,txtdescription);
				stmtRRP.setDouble(4,(txtnettotal+txtonaccountamount));
				stmtRRP.setDouble(5,rate);
				stmtRRP.setString(6,"ICPV");
				stmtRRP.setString(7,company);
				stmtRRP.setString(8,branch);
				stmtRRP.setString(9,userid);
				stmtRRP.setString(12,"A");
				int paymentmastercheck=stmtRRP.executeUpdate();
				if(paymentmastercheck<=0){
					stmtRRP.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRP.getInt("docNo");
				trno=stmtRRP.getInt("itranNo");
				dtype="ICPV";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				rentalRefundBean.setTxtrentalrefunddocno(docno);
				stmtRRP.close();
				return docno;
								
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
	}
	    
	 
	 public int ibCashPaymentDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,int txtsecurityacno, Date rentalRefundDate, String txtchequeno, 
			 String cmbratype, String txtagreement, String cmbpayedas, double txtamount, double txtdeduction, double txtnettotal,  String txtdescriptions,String cmbbranch, 
			 String txtdescription, ArrayList<String> refundarray, ArrayList<String> applysecurityarray, HttpSession session) throws SQLException{
		
		  try{
                Statement stmtRRP2 = conn.createStatement();
				
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				if (docno > 0) {
					/*Details Saving*/
					for(int i=0;i< refundarray.size();i++){
						String[] cashpayment=refundarray.get(i).split("::");
						if(!cashpayment[0].trim().equalsIgnoreCase("undefined") && !cashpayment[0].trim().equalsIgnoreCase("NaN")){
						
						int cash = 0;
						int id = 0;
						if(cashpayment[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=1;
						}
						else if(cashpayment[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=-1;
						}
						else{}
						
						CallableStatement stmtRRP = conn.prepareCall("{CALL ibCashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_cashbd*/
						stmtRRP.setInt(20,trno); 
						stmtRRP.setInt(21,docno);
						stmtRRP.registerOutParameter(22, java.sql.Types.INTEGER);
						stmtRRP.setInt(1,i); //SR_NO
						stmtRRP.setString(2,(cashpayment[0].trim().equalsIgnoreCase("undefined") || cashpayment[0].trim().equalsIgnoreCase("NaN") || cashpayment[0].trim().isEmpty()?0:cashpayment[0].trim()).toString());  //doc_no of my_head
						stmtRRP.setString(3,currency); //curId
						stmtRRP.setDouble(4,rate); //rate 
						stmtRRP.setInt(5,id); //#credit -1 / debit 1 
						stmtRRP.setString(6,(cashpayment[1].trim().equalsIgnoreCase("undefined") || cashpayment[1].trim().equalsIgnoreCase("NaN") || cashpayment[1].trim().isEmpty()?0:cashpayment[1].trim()).toString()); //amount
						stmtRRP.setString(7,(cashpayment[4].trim().equalsIgnoreCase("undefined") || cashpayment[4].trim().equalsIgnoreCase("NaN") || cashpayment[4].trim().isEmpty()?0:cashpayment[4].trim()).toString()); //description
						stmtRRP.setString(8,(cashpayment[2].trim().equalsIgnoreCase("undefined") || cashpayment[2].trim().equalsIgnoreCase("NaN") || cashpayment[2].trim().isEmpty()?0:cashpayment[2].trim()).toString()); //baseamount
						stmtRRP.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRP.setString(10,"0"); //Cost Type
						stmtRRP.setString(11,"0"); //Cost Code
						/*my_cashbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRP.setDate(12,rentalRefundDate);
						stmtRRP.setString(13,"RRP"+srno);
						stmtRRP.setInt(14,id);  //id
						stmtRRP.setInt(15,0);  //out-amount
						/*my_jvtran Ends*/
						
						stmtRRP.setString(16,"ICPV");
						stmtRRP.setString(17,(cashpayment[5].trim().equalsIgnoreCase("undefined") || cashpayment[5].trim().equalsIgnoreCase("NaN") || cashpayment[5].trim().isEmpty()?0:cashpayment[5].trim()).toString());  //branch
						stmtRRP.setString(18,branch); //Main Branch
						stmtRRP.setString(19,userid);
						stmtRRP.setString(23,"A");
						int paymentdetailcheck=stmtRRP.executeUpdate();
						if(paymentdetailcheck<=0){
							stmtRRP.close();
							conn.close();
							return 0;
						   }
	      				 }
					    }
					    /*Details Saving Ends*/
					
					/*Security-Apply Grid Saving*/
					for(int i=0;i< applysecurityarray.size();i++){
					String[] apply=applysecurityarray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("0") && !apply[0].trim().equalsIgnoreCase("")){
					
					CallableStatement stmtRRP1 = conn.prepareCall("{CALL raRefundApplyInvoiceDML(?,?,?,?,?,?,?)}");
					
					/*Insertion to my_outd*/
					stmtRRP1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtRRP1.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtRRP1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtRRP1.setInt(4,trno);  //tr_no
					stmtRRP1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtRRP1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtRRP1.setString(7,"A");	
					int applysecuritycheck=stmtRRP1.executeUpdate();
						if(applysecuritycheck<=0){
							stmtRRP1.close();
							conn.close();
							return 0;
						}
						/*Security-Apply Grid Saving Ends*/
					 }
				  }
					
					/*Updating my_jvtran*/
					if(!(cmbratype.equalsIgnoreCase("0"))){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno+"");
						int data2 = stmtRRP2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRP2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					
					int accountsno=0,trid = 0;
					 if(cmbpayedas.equalsIgnoreCase("1")){
						 accountsno=txtsecurityacno;
						}
					 else if(cmbpayedas.equalsIgnoreCase("2")){
						 accountsno=txtacno;
					 }
					 
					/*Selecting Tran-Id*/
					String sqls=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+accountsno+"");
					ResultSet resultSet = stmtRRP2.executeQuery(sqls);
					    
					 while (resultSet.next()) {
					 trid=resultSet.getInt("TRANID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					if(cmbpayedas.equalsIgnoreCase("1")){
						String sql3=("update my_jvtran set out_amount="+txtamount+" where tranid="+trid+"");
						int data3 = stmtRRP2.executeUpdate(sql3);
						if(data3<=0){
							stmtRRP2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					/*Updating gl_rentrefund*/
					String sql4=("update gl_rentrefund set TR_NO="+trno+",rdocno="+docno+",dtype='ICPV' where brhid="+branch+" and srno="+srno+"");
					int data4 = stmtRRP2.executeUpdate(sql4);
					if(data4<=0){
						stmtRRP2.close();
						conn.close();
						return 0;
					}
					/*Updating gl_rentrefund Ends*/
					
					/*Deleting account of value zero*/
					String sql5=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRP2.executeUpdate(sql5);
				     
				    String sql6=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRP2.executeUpdate(sql6);
				    /*Deleting account of value zero ends*/

				    /*Deleting amount of value zero*/
					String sql7=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
				    int data7 = stmtRRP2.executeUpdate(sql7);
				     
				    String sql8=("DELETE FROM my_cashbd where TR_NO="+trno+" and amount=0");
				    int data8 = stmtRRP2.executeUpdate(sql8);
				    /*Deleting amount of value zero ends*/
				    
				return docno;
			}					
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
	 }
		return 1;
	}
	 
	 public int bankPaymentMasterInsertion(Connection conn,int srno,Date rentalRefundDate,String txtdescription,int txtacno,String txtpaidto,String txtchequeno, Date referenceDate, double txtdeduction, 
			    double txtnettotal,double txtonaccountamount, HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
				CallableStatement stmtRRP;
				Statement stmtRRP1 = conn.createStatement();
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				String accdescription = "";
				accdescription=txtpaidto;
				if(accdescription.trim().equalsIgnoreCase("")){
					/*Selecting Account Name*/
					String sql=("SELECT description FROM my_head where doc_no="+txtacno+"");
					ResultSet resultSet = stmtRRP1.executeQuery(sql);
					    
					 while (resultSet.next()) {
						 accdescription=resultSet.getString("description");
					 }
					 /*Selecting Account Name Ends*/
				}
				 
		    	stmtRRP = conn.prepareCall("{CALL chqbmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		    	stmtRRP.registerOutParameter(13, java.sql.Types.INTEGER);
		    	stmtRRP.registerOutParameter(14, java.sql.Types.INTEGER);
		    	stmtRRP.setDate(1,rentalRefundDate);
		    	stmtRRP.setString(2,"RRP"+srno);
		    	stmtRRP.setString(3,txtdescription);
		    	stmtRRP.setString(4,txtchequeno);
		    	stmtRRP.setDate(5,referenceDate);
		    	stmtRRP.setString(6,accdescription);
		    	stmtRRP.setDouble(7,(txtnettotal+txtonaccountamount));
		    	stmtRRP.setDouble(8,rate);
		    	stmtRRP.setString(9,"BPV");
		    	stmtRRP.setString(10,company);
		    	stmtRRP.setString(11,branch);
		    	stmtRRP.setString(12,userid);
		    	stmtRRP.setString(15,"A");
				int receiptmastercheck=stmtRRP.executeUpdate();
				if(receiptmastercheck<=0){
					stmtRRP.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRP.getInt("docNo");
				trno=stmtRRP.getInt("itranNo");
				dtype="BPV";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				
				rentalRefundBean.setTxtrentalrefunddocno(docno);
				stmtRRP.close();
				return docno;
								
	   }catch(Exception e){
		 	e.printStackTrace();
		 	 conn.close();
		 	return 0;
	 }
	}
	 
	public int bankPaymentDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,int txtsecurityacno,Date rentalRefundDate, String txtchequeno, 
			 Date referenceDate, String cmbratype, String txtagreement, String cmbpayedas, double txtamount, double txtdeduction, double txtnettotal, String txtdescriptions, 
			 String txtdescription, ArrayList<String> refundarray, ArrayList<String> applysecurityarray, HttpSession session) throws SQLException{
		
		  try{
                Statement stmtRRP2 = conn.createStatement();
				
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String pdc="0",pdcaccount="0",method="0";
				int days=0;
				
				if(cmbratype==null){
					cmbratype="0";
				}
				
				String sqld = "select DATEDIFF('"+referenceDate+"','"+rentalRefundDate+"') days";
				ResultSet rs = stmtRRP2.executeQuery(sqld);
				
				while(rs.next()) {
					days=rs.getInt("days");
				} 
				
				if(days>0){
					
					String strSql = "select acno from my_account where codeno='PDCPV'";
					ResultSet rs1 = stmtRRP2.executeQuery(strSql);
					
					while(rs1.next()) {
						pdcaccount=rs1.getString("acno");
					} 
					
					pdc="1";
				}
				
				String strSql = "select method from gl_config where field_nme='refundChequePDC'";
				ResultSet rs1 = stmtRRP2.executeQuery(strSql);
				
				while(rs1.next()) {
					method=rs1.getString("method");
				} 
				
				if(method.equalsIgnoreCase("1")) {
					
					String strSqls = "select acno from my_account where codeno='PDCPV'";
					ResultSet rs2 = stmtRRP2.executeQuery(strSqls);
					
					while(rs2.next()) {
						pdcaccount=rs2.getString("acno");
					}
					
					pdc="1";
				}
				
				if (docno > 0) {
					/*Insertion to my_chqdet*/
					String sql=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtchequeno+"','"+referenceDate+"',"+txtacno+","+pdc+",'E',0,'"+trno+"','"+branch+"')");
					int data = stmtRRP2.executeUpdate(sql);
					if(data<=0){
						stmtRRP2.close();
						conn.close();
						return 0;
					}
					/*my_chqdet Ends*/
					 
					/*Details Saving*/
					for(int i=0;i< refundarray.size();i++){
						String[] bankpayment=refundarray.get(i).split("::");
						if(!bankpayment[0].trim().equalsIgnoreCase("undefined") && !bankpayment[0].trim().equalsIgnoreCase("NaN")){
						int cash = 0;
						int id = 0;
						if(bankpayment[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=1;
						}
						else if(bankpayment[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=-1;
						}
						
						CallableStatement stmtRRP = conn.prepareCall("{CALL chqbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_chqbd*/
						stmtRRP.setInt(21,trno); 
						stmtRRP.setInt(22,docno);
						stmtRRP.registerOutParameter(23, java.sql.Types.INTEGER);
						stmtRRP.setInt(1,i); //SR_NO
						stmtRRP.setString(2,(bankpayment[0].trim().equalsIgnoreCase("undefined") || bankpayment[0].trim().equalsIgnoreCase("NaN") || bankpayment[0].trim().isEmpty()?0:bankpayment[0].trim()).toString());  //doc_no of my_head
						stmtRRP.setString(3,currency); //curId
						stmtRRP.setDouble(4,rate); //rate 
						stmtRRP.setInt(5,id); //#credit -1 / debit 1 
						stmtRRP.setString(6,(bankpayment[1].trim().equalsIgnoreCase("undefined") || bankpayment[1].trim().equalsIgnoreCase("NaN") || bankpayment[1].trim().isEmpty()?0:bankpayment[1].trim()).toString()); //amount
						stmtRRP.setString(7,(bankpayment[4].trim().equalsIgnoreCase("undefined") || bankpayment[4].trim().equalsIgnoreCase("NaN") || bankpayment[4].trim().isEmpty()?0:bankpayment[4].trim()).toString()); //description
						stmtRRP.setString(8,(bankpayment[2].trim().equalsIgnoreCase("undefined") || bankpayment[2].trim().equalsIgnoreCase("NaN") || bankpayment[2].trim().isEmpty()?0:bankpayment[2].trim()).toString()); //baseamount
						stmtRRP.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRP.setString(10,"0"); //Cost Type
						stmtRRP.setString(11,"0"); //Cost Code
						/*my_chqbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRP.setDate(12,rentalRefundDate);
						stmtRRP.setString(13,pdc); //pdc
						stmtRRP.setString(14,pdcaccount); //pdc Account No
						stmtRRP.setString(15,"RRP"+srno);
						stmtRRP.setInt(16,id);  //id
						stmtRRP.setInt(17,0);  //out-amount
						/*my_jvtran Ends*/
						
						stmtRRP.setString(18,"BPV");
						stmtRRP.setString(19,branch);
						stmtRRP.setString(20,userid);
						stmtRRP.setString(24,"A");
						stmtRRP.execute();
						 if(stmtRRP.getInt("irowsNo")<=0){
							stmtRRP.close();
							conn.close();
							return 0;
						   }
	      				  }
					    }
					 /*Details Saving Ends*/
					
					/*Security-Apply Grid Saving*/
					for(int i=0;i< applysecurityarray.size();i++){
					String[] apply=applysecurityarray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("0") && !apply[0].trim().equalsIgnoreCase("")){
					
					CallableStatement stmtRRP1 = conn.prepareCall("{CALL raRefundApplyBankInvoiceDML(?,?,?,?,?,?,?)}");
					
					/*Insertion to my_outd*/
					stmtRRP1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtRRP1.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtRRP1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtRRP1.setInt(4,trno);  //tr_no
					stmtRRP1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtRRP1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtRRP1.setString(7,"A");	
					int applysecuritycheck=stmtRRP1.executeUpdate();
						if(applysecuritycheck<=0){
							stmtRRP1.close();
							conn.close();
							return 0;
						}
						/*Security-Apply Grid Saving Ends*/
					 }
				  }
					
					/*Updating my_jvtran*/
					if(!(cmbratype==null || cmbratype.equalsIgnoreCase(""))){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno);
						int data2 = stmtRRP2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRP2.close();
							conn.close();
							return 0;					
						}
					}
					/*Updating my_jvtran Ends*/
					
					int accountsno=0,trid = 0;
					 if(cmbpayedas.equalsIgnoreCase("1")){
						 accountsno=txtsecurityacno;
						}
					 else if(cmbpayedas.equalsIgnoreCase("2")){
						 accountsno=txtacno;
					 }

					 
					/*Selecting Tran-Id*/
					String sqls=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+accountsno);
					ResultSet resultSet = stmtRRP2.executeQuery(sqls);
					    
					 while (resultSet.next()) {
					 trid=resultSet.getInt("TRANID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					if(cmbpayedas.equalsIgnoreCase("1")){
						String sql3=("update my_jvtran set out_amount="+txtamount+" where tranid="+trid);
						int data3 = stmtRRP2.executeUpdate(sql3);
						if(data3<=0){
							stmtRRP2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
										
					/*Updating gl_rentrefund*/
					String sql4=("update gl_rentrefund set TR_NO="+trno+",rdocno="+docno+",dtype='BPV' where brhid="+branch+" and srno="+srno);
					int data4 = stmtRRP2.executeUpdate(sql4);
					if(data4<=0){
						stmtRRP2.close();
						conn.close();
						return 0;					
					}
					/*Updating gl_rentrefund Ends*/

					/*Deleting account of value zero*/
					String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRP2.executeUpdate(sql2);
				     
				    String sql5=("DELETE FROM my_chqbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRP2.executeUpdate(sql5);
				    /*Deleting account of value zero ends*/
				    
				    /*Deleting amount of value zero*/
					String sql7=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
				    int data7 = stmtRRP2.executeUpdate(sql7);
				     
				    String sql8=("DELETE FROM my_chqbd where TR_NO="+trno+" and amount=0");
				    int data8 = stmtRRP2.executeUpdate(sql8);
				    /*Deleting amount of value zero ends*/
				    
				return docno;
			}					
	   }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	 
	 public int ibBankPaymentMasterInsertion(Connection conn,int srno,Date rentalRefundDate,String txtdescription,int txtacno,String txtpaidto,String txtchequeno, Date referenceDate, double txtdeduction, 
			    double txtnettotal,double txtonaccountamount, HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
				CallableStatement stmtRRP;
				Statement stmtRRP1 = conn.createStatement();
				
				String company=session.getAttribute("COMPANYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				String accdescription = "";
				accdescription=txtpaidto;
				if(accdescription.trim().equalsIgnoreCase("")){
					/*Selecting Account Name*/
					String sql=("SELECT description FROM my_head where doc_no="+txtacno+"");
					ResultSet resultSet = stmtRRP1.executeQuery(sql);
					    
					 while (resultSet.next()) {
						 accdescription=resultSet.getString("description");
					 }
					 /*Selecting Account Name Ends*/
				}
				 
		    	stmtRRP = conn.prepareCall("{CALL chqbmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		    	stmtRRP.registerOutParameter(13, java.sql.Types.INTEGER);
		    	stmtRRP.registerOutParameter(14, java.sql.Types.INTEGER);
		    	stmtRRP.setDate(1,rentalRefundDate);
		    	stmtRRP.setString(2,"RRP"+srno);
		    	stmtRRP.setString(3,txtdescription);
		    	stmtRRP.setString(4,txtchequeno);
		    	stmtRRP.setDate(5,referenceDate);
		    	stmtRRP.setString(6,accdescription);
		    	stmtRRP.setDouble(7,(txtnettotal+txtonaccountamount));
		    	stmtRRP.setDouble(8,rate);
		    	stmtRRP.setString(9,"IBP");
		    	stmtRRP.setString(10,company);
		    	stmtRRP.setString(11,branch);
		    	stmtRRP.setString(12,userid);
		    	stmtRRP.setString(15,"A");
				int receiptmastercheck=stmtRRP.executeUpdate();
				if(receiptmastercheck<=0){
					stmtRRP.close();
					conn.close();
					return 0;
				 }
				docno=stmtRRP.getInt("docNo");
				trno=stmtRRP.getInt("itranNo");
				dtype="IBP";
				
				request.setAttribute("documentNo", docno);
				request.setAttribute("transactionno", trno);
				request.setAttribute("doctype", dtype);
				
				rentalRefundBean.setTxtrentalrefunddocno(docno);
				stmtRRP.close();
				return docno;
								
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
	}
	 
	
	 public int ibBankPaymentDetailInsertion(Connection conn,int srno,int txtdocno, int txtacno,int txtsecurityacno,Date rentalRefundDate, String txtchequeno, Date referenceDate,
			 String cmbratype, String txtagreement, String cmbpayedas, double txtamount, double txtdeduction, double txtnettotal,  String txtdescriptions,String cmbbranch, 
			 String txtdescription, ArrayList<String> refundarray, ArrayList<String> applysecurityarray, HttpSession session) throws SQLException{
		
		  try{
                Statement stmtRRP2 = conn.createStatement();
				
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String pdc="0",pdcaccount="0",method="0";
				int days=0;
				
				if(cmbratype==null){
					cmbratype="0";
				}
				
				String sqld = "select DATEDIFF('"+referenceDate+"','"+rentalRefundDate+"') days";
				ResultSet rs = stmtRRP2.executeQuery(sqld);
				
				while(rs.next()) {
					days=rs.getInt("days");
				} 
				
				if(days>0){
					
					String strSql = "select acno from my_account where codeno='PDCPV'";
					ResultSet rs1 = stmtRRP2.executeQuery(strSql);
					
					while(rs1.next()) {
						pdcaccount=rs1.getString("acno");
					} 
					
					pdc="1";
				}
				
				String strSql = "select method from gl_config where field_nme='refundChequePDC'";
			    ResultSet rs1 = stmtRRP2.executeQuery(strSql);
			    
			    while(rs1.next()) {
			     method=rs1.getString("method");
			    } 
			    
			    if(method.equalsIgnoreCase("1")) {
			    	String strSqls = "select acno from my_account where codeno='PDCPV'";
					ResultSet rs2 = stmtRRP2.executeQuery(strSqls);
					
					while(rs2.next()) {
						pdcaccount=rs2.getString("acno");
					}
					
					pdc="1";
			    }
				
				if (docno > 0) {
					/*Insertion to my_chqdet*/
					String sql=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtchequeno+"','"+referenceDate+"',"+txtacno+","+pdc+",'E',0,'"+trno+"','"+branch+"')");
					int data = stmtRRP2.executeUpdate(sql);
					if(data<=0){
						stmtRRP2.close();
						conn.close();
						return 0;					
					}
					/*my_chqdet Ends*/
					
					/*Details Saving*/
					for(int i=0;i< refundarray.size();i++){
						String[] bankpayment=refundarray.get(i).split("::");
						if(!bankpayment[0].trim().equalsIgnoreCase("undefined") && !bankpayment[0].trim().equalsIgnoreCase("NaN")){
						
						int cash = 0;
						int id = 0;
						if(bankpayment[3].trim().equalsIgnoreCase("true")){
							cash=0;
							id=1;
						}
						else if(bankpayment[3].trim().equalsIgnoreCase("false")){
							cash=1;
							id=-1;
						}
						else{}
						
						CallableStatement stmtRRP = conn.prepareCall("{CALL ibChqbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_chqbd*/
						stmtRRP.setInt(22,trno); 
						stmtRRP.setInt(23,docno);
						stmtRRP.registerOutParameter(24, java.sql.Types.INTEGER);
						stmtRRP.setInt(1,i); //SR_NO
						stmtRRP.setString(2,(bankpayment[0].trim().equalsIgnoreCase("undefined") || bankpayment[0].trim().equalsIgnoreCase("NaN") || bankpayment[0].trim().isEmpty()?0:bankpayment[0].trim()).toString());  //doc_no of my_head
						stmtRRP.setString(3,currency); //curId
						stmtRRP.setDouble(4,rate); //rate 
						stmtRRP.setInt(5,id); //#credit -1 / debit 1 
						stmtRRP.setString(6,(bankpayment[1].trim().equalsIgnoreCase("undefined") || bankpayment[1].trim().equalsIgnoreCase("NaN") || bankpayment[1].trim().isEmpty()?0:bankpayment[1].trim()).toString()); //amount
						stmtRRP.setString(7,(bankpayment[4].trim().equalsIgnoreCase("undefined") || bankpayment[4].trim().equalsIgnoreCase("NaN") || bankpayment[4].trim().isEmpty()?0:bankpayment[4].trim()).toString()); //description
						stmtRRP.setString(8,(bankpayment[2].trim().equalsIgnoreCase("undefined") || bankpayment[2].trim().equalsIgnoreCase("NaN") || bankpayment[2].trim().isEmpty()?0:bankpayment[2].trim()).toString()); //baseamount
						stmtRRP.setInt(9,cash); //For cash = 0/ party = 1
						stmtRRP.setString(10,"0"); //Cost Type
						stmtRRP.setString(11,"0"); //Cost Code
						/*my_chqbd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtRRP.setDate(12,rentalRefundDate);
						stmtRRP.setString(13,pdc); //pdc
						stmtRRP.setString(14,pdcaccount); //pdc Account No
						stmtRRP.setString(15,"RRP"+srno);
						stmtRRP.setInt(16,id);  //id
						stmtRRP.setInt(17,0);  //out-amount
						/*my_jvtran Ends*/
						stmtRRP.setString(18,"IBP");
						stmtRRP.setString(19,(bankpayment[5].trim().equalsIgnoreCase("undefined") || bankpayment[5].trim().equalsIgnoreCase("NaN") || bankpayment[5].trim().isEmpty()?0:bankpayment[5].trim()).toString());  //branch
						stmtRRP.setString(20,branch); //Main Branch
						stmtRRP.setString(21,userid);
						stmtRRP.setString(25,"A");
                        stmtRRP.execute();
						 if(stmtRRP.getInt("irowsNo")<=0){
							stmtRRP.close();
							conn.close();
							return 0;
						   }
	      				  }
					    }
					    /*Details Saving Ends*/
					
					/*Security-Apply Grid Saving*/
					for(int i=0;i< applysecurityarray.size();i++){
					String[] apply=applysecurityarray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN") && !apply[0].trim().equalsIgnoreCase("0") && !apply[0].trim().equalsIgnoreCase("")){
					
					CallableStatement stmtRRP1 = conn.prepareCall("{CALL raRefundApplyBankInvoiceDML(?,?,?,?,?,?,?)}");
					
					/*Insertion to my_outd*/
					stmtRRP1.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtRRP1.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtRRP1.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtRRP1.setInt(4,trno);  //tr_no
					stmtRRP1.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtRRP1.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtRRP1.setString(7,"A");	
					int applysecuritycheck=stmtRRP1.executeUpdate();
						if(applysecuritycheck<=0){
							stmtRRP1.close();
							conn.close();
							return 0;
						}
						/*Security-Apply Grid Saving Ends*/
					 }
				  }
					
					/*Updating my_jvtran*/
					if(!(cmbratype==null || cmbratype.equalsIgnoreCase(""))){
						String sql2=("update my_jvtran set rdocno="+txtagreement+",rtype='"+cmbratype+"' where tr_no="+trno);
						int data2 = stmtRRP2.executeUpdate(sql2);
						if(data2<=0){
							stmtRRP2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					int accountsno=0,trid = 0;
					 if(cmbpayedas.equalsIgnoreCase("1")){
						 accountsno=txtsecurityacno;
						}
					 else if(cmbpayedas.equalsIgnoreCase("2")){
						 accountsno=txtacno;
					 }
					 
					/*Selecting Tran-Id*/
					String sqls=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+accountsno);
					ResultSet resultSet = stmtRRP2.executeQuery(sqls);
					    
					 while (resultSet.next()) {
					 trid=resultSet.getInt("TRANID");
					 }
					 /*Selecting Tran-Id Ends*/
					
					/*Updating my_jvtran*/
					if(cmbpayedas.equalsIgnoreCase("1")){
						String sql3=("update my_jvtran set out_amount="+txtamount+" where tranid="+trid);
						int data3 = stmtRRP2.executeUpdate(sql3);
						if(data3<=0){
							stmtRRP2.close();
							conn.close();
							return 0;
						}
					}
					/*Updating my_jvtran Ends*/
					
					/*Updating gl_rentrefund*/
					String sql4=("update gl_rentrefund set TR_NO="+trno+",rdocno="+docno+",dtype='IBP' where brhid="+branch+" and srno="+srno);
					int data4 = stmtRRP2.executeUpdate(sql4);
					if(data4<=0){
						stmtRRP2.close();
						conn.close();
						return 0;
					}
					/*Updating gl_rentrefund Ends*/
				
					/*Deleting account of value zero*/
					String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data5 = stmtRRP2.executeUpdate(sql2);
				     
				    String sql5=("DELETE FROM my_chqbd where TR_NO="+trno+" and acno=0");
				    int data6 = stmtRRP2.executeUpdate(sql5);
				    /*Deleting account of value zero ends*/
				    
				    /*Deleting amount of value zero*/
					String sql7=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
				    int data7 = stmtRRP2.executeUpdate(sql7);
				     
				    String sql8=("DELETE FROM my_chqbd where TR_NO="+trno+" and amount=0");
				    int data8 = stmtRRP2.executeUpdate(sql8);
				    /*Deleting amount of value zero ends*/
				    
				return docno;
			}					
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
