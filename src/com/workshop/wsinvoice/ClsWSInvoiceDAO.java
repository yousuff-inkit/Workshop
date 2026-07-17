package com.workshop.wsinvoice;

import java.sql.*;

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.workshop.jobcardcompletenew.ClsJobCardCompleteNewDAO;
import com.workshop.wsjobcard.ClsWSJobCardBean;

import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.DataValidation.ErrorStyle;

import net.sf.json.JSONArray;
public class ClsWSInvoiceDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public boolean edit(Date sqldate, String cmbreftype, String hidrefno,
			String cldocno, String invoicetoacno, String excessamountacno,
			String total, String discount, String excessamount,
			String nettotal, String remarks, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode, 
			String branch, ArrayList<String> invoicearray,Connection conn, String taxpercent, 
			String taxamount, String taxtotal,String hidchksaperateinvoice,String billtoacno,int docno,
			String strroundamt) throws SQLException {
		// TODO Auto-generated method stub
		int vocno=0,trno=0;
		try{
			excessamountacno=excessamountacno.trim().equalsIgnoreCase("")?"0":excessamountacno.trim();
			hidchksaperateinvoice=hidchksaperateinvoice.trim().equalsIgnoreCase("")?"0":hidchksaperateinvoice.trim();
			Statement stmt=conn.createStatement();
			System.out.println("Saperate Invoice Check"+hidchksaperateinvoice);
			CallableStatement stmtEst = conn.prepareCall("{call WSinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.setInt(14, docno);
			stmtEst.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,cmbreftype);
			stmtEst.setString(3,hidrefno);
			stmtEst.setString(4, invoicetoacno);
			stmtEst.setString(5,excessamountacno);
			stmtEst.setString(6,remarks);
			stmtEst.setString(7,total);
			stmtEst.setString(8,discount);
			stmtEst.setString(9,excessamount==null || excessamount.equalsIgnoreCase("null") ?"0":excessamount);
			stmtEst.setString(10,nettotal);
			stmtEst.setString(11,formdetailcode);
			stmtEst.setString(12,session.getAttribute("USERID").toString());
			stmtEst.setString(13,branch);
			stmtEst.setString(16,mode);
			stmtEst.setString(18,taxpercent);
			stmtEst.setString(19,taxamount);
			stmtEst.setString(20,taxtotal);
			stmtEst.setString(21,hidchksaperateinvoice);
			int masterval=stmtEst.executeUpdate();
			vocno=stmtEst.getInt("voucher");
			trno=stmtEst.getInt("vtrNo");
			request.setAttribute("WSINVVOCNO", vocno);
			String strupdateacno="update ws_invm set invoicetoacno="+billtoacno+" where doc_no="+docno;
			System.out.println(strupdateacno);
			System.out.println("TRNO:"+trno+" , VOCNO:"+vocno);
			int updateacno=stmt.executeUpdate(strupdateacno);
			int errorstatus=0;
			if(updateacno<=0){
				System.out.println("Update InvoiceToAcno Error");
				errorstatus=0;
				return false;
			}
			//System.out.println("Master Value:"+masterval);
			if(masterval<=0){
				System.out.println("Master Value Error");
				errorstatus=1;
				//conn.close();
				return false;
			}
			else{
				
				int invdrowno=0;
				int deleteinvd=stmt.executeUpdate("delete from ws_invd where rdocno="+docno);
				ClsApplyDelete applydel=new ClsApplyDelete();
				applydel.getFinanceApplyDelete(conn, trno);
				int deletejv=stmt.executeUpdate("delete from my_jvtran where tr_no="+trno);
				int deletecost=stmt.executeUpdate("delete from my_costtran where tr_no="+trno);
				for(int i=0,j=1;i<invoicearray.size();i++,j++){
					String temp[]=invoicearray.get(i).split("::");
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					String str="insert into ws_invd(rdocno,srno,desc1,amount)values("+docno+","+j+",'"+temp[0]+"',"+temp[1]+")";
					System.out.println(str);
					int insertval=stmt.executeUpdate(str);
					if(insertval<=0){
						System.out.println("Invd edit insert error");
						errorstatus=1;
//						conn.close();
						return false;
					}
					invdrowno=j;
				}
				if(hidchksaperateinvoice.equalsIgnoreCase("1") && Double.parseDouble(excessamount)>0.0){
					String strexcessinvd="insert into ws_invd(rdocno,srno,desc1,amount)values("+docno+","+(invdrowno+1)+",'Excess Amount',"+Double.parseDouble(excessamount)*-1+")";
					int insertexcessinvd=stmt.executeUpdate(strexcessinvd);
					if(insertexcessinvd<=0){
						System.out.println("saperate excess Invd edit insert error");
						errorstatus=1;
//						conn.close();
						return false;
					}
				}
				double totalamt=0.0,discountamt=0.0,excessamt=0.0,netamt=0.0,remaintotal=0.0;
				totalamt=Double.parseDouble(total);
				discountamt=Double.parseDouble(discount);
				if(excessamount!=null){
					excessamt=Double.parseDouble(excessamount);
				}
				
				netamt=Double.parseDouble(nettotal);
				if(excessamt>0.0 && hidchksaperateinvoice.equalsIgnoreCase("1")){
					netamt-=excessamt;
				}
				int insurtodocno=0;
				String strdecideinvoiceto="select if(gate.insurancecomp>0,gate.insurcldocno,gate.cldocno) invoicetodocno from ws_jobcard job "+
				" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) "+
				" where job.doc_no="+hidrefno;
				ResultSet rsinvoicetodetails=stmt.executeQuery(strdecideinvoiceto);
				while(rsinvoicetodetails.next()){
					insurtodocno=rsinvoicetodetails.getInt("invoicetodocno");
				}
				
				ArrayList<String> acnodetailarray=getWorkshopAccountDetails(conn,cmbreftype,hidrefno);
				//Excess Amt Corresponding to Client
				int compacno=0,clientacno=0,insuracno=0,curid=0;
				double currate=0.0,partydramt=0.0,compdramt=0.0,partyldramt=0.0,compldramt=0.0;
				String note="";
				compacno=Integer.parseInt(acnodetailarray.get(2));
				insuracno=Integer.parseInt(acnodetailarray.get(0));
				clientacno=Integer.parseInt(acnodetailarray.get(1));
				curid=Integer.parseInt(acnodetailarray.get(3));
				currate=Double.parseDouble(acnodetailarray.get(4));
				String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+insurtodocno+" and dtype='CRM') clienttaxmethod";
//				System.out.println(strchecktax);
				Statement stmtchecktax=conn.createStatement();
				ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				double vatval=0.0,setval=0.0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				if(taxstatus==1 && clienttaxmethod==1){
					double generalamttax=netamt;
					String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
					double setpercent=0.0;
					double vatpercent=0.0;
					ResultSet rsgettax=stmt.executeQuery(strgettax);
					ArrayList<String> temptaxarray=new ArrayList<>();
					while(rsgettax.next()){
						setpercent=rsgettax.getDouble("set_per");
						vatpercent=rsgettax.getDouble("vat_per");
						vatval=(generalamttax*(vatpercent/100));
						setval=generalamttax*(setpercent/100);
						setval=objcommon.Round(setval, 2);
						vatval=objcommon.Round(vatval, 2);
						if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
							if(vatval>0.0){
								temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+taxamount+"::"+rsgettax.getString("description"));
								netamt+=Double.parseDouble(taxamount);
							}
						}
					}
					
					if(setpercent>0.0 || vatpercent>0.0){
						double generalldr=0.0;
						netamt=objcommon.Round(netamt, 2);
						generalldr=netamt*currate;
						int tempsrno=invoicearray.size()+1;
						note="VAT Entry of Workshop Invoice "+docno;
						note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
						for(int j=0;j<temptaxarray.size();j++){
							String[] tax=temptaxarray.get(j).split("::");
							if(Double.parseDouble(tax[2])>0){
								String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
								" '"+Double.parseDouble(tax[2])*-1+"','"+currate+"','"+curid+"',0,-1,'"+(tempsrno)+"',"+
								" '"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*currate)*-1+"','"+docno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
								"'"+curid+"','5',1,'"+cldocno+"',3)";
								System.out.println("Tax Jv1:"+strtaxjv);
								tempsrno++;
								Statement stmttaxjv=conn.createStatement();
								//System.out.println("Jvtran Sql:"+strtaxjv);
								int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
								if(taxjvval>0){
									
								}
								else{
									System.out.println("Jvtran Tax Error");
									conn.close();
									return false;
								}
								/*
								String strtaxjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
										"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+(insuracno>0?insuracno:clientacno)+"',"+
										" '"+Double.parseDouble(tax[2])+"','"+currate+"','"+curid+"',0,-1,'"+(tempsrno)+"',"+
										" '"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*currate)*-1+"','"+docno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
										"'"+curid+"','5',1,'"+cldocno+"',3)";
								System.out.println("Tax Jv2:"+strtaxjv);
										tempsrno++;
										System.out.println("Jvtran Sql:"+strtaxjv);
										int taxjvval2=stmttaxjv.executeUpdate(strtaxjv2);
										if(taxjvval2>0){
											
										}
										else{
											System.out.println("Jvtran Tax Error");
											return 0;
										}*/
								stmttaxjv.close();
							}
						}
					}
				}
				//Jvtran Entries
				if(excessamt>0.0 && hidchksaperateinvoice.equalsIgnoreCase("0")){
					remaintotal=netamt-excessamt;
				}
				else{
					remaintotal=netamt;
				}
				int i=0;
				/*if(excessamt>0.0 && hidchksaperateinvoice.equalsIgnoreCase("0")){
					partydramt=excessamt;
					compdramt=excessamt;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					note="Excess Amt JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					if(partydramt!=0.0){
						String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+clientacno+"',"+
								" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+sqldate+"',"+
								" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
//								System.out.println("Excess JV 1:"+strjvparty);
								int jvparty=stmt.executeUpdate(strjvparty);
								if(jvparty<=0){
									System.out.println("Jv party edit error");
									errorstatus=1;
								}
								i++;

					}
					String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
					" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+excessamountacno+"',"+
					" '"+compdramt+"','"+currate+"','"+curid+"',0,1,1,'"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"',"+
					" '"+compldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,"+cldocno+",3)";
					System.out.println("Excess JV 2:"+strjvcomp);
					int jvcomp=stmt.executeUpdate(strjvcomp);
					if(jvcomp<=0){
						errorstatus=1;
					}
					i++;
				}*/
				double ramt=0.0;
				double roundamt=0.0;
				if(insuracno>0){
					note="JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					if(strroundamt==null || strroundamt.trim().equalsIgnoreCase("") || strroundamt.trim().equalsIgnoreCase("undefined")){
						strroundamt="0.0";
					}
					double roundldr=0.0;
					roundamt=Double.parseDouble(strroundamt);
					if(roundamt!=0.0){
						ramt=remaintotal-roundamt;
					}
					else{
						ramt=remaintotal;
					}
					roundamt=objcommon.Round(roundamt, 2);
					roundldr=roundamt*currate;
					
					double ramtldr=ramt*currate;
					// discount a/c jvtran  discount*-1   
					Statement stmtdiscount=conn.createStatement();
					String strdiscount="select acno discountacno from gl_invmode where idno=13";
					ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
					int  discac=0;
					while(rsdiscount.next()){
						discac=rsdiscount.getInt("discountacno");
					}
					if(roundamt!=0.0){
						
						int discid=0;
						if(roundamt>0.0){
							discid=1;
						}
						else if(roundamt<0.0){
							discid=-1;
						}
						note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
						if(roundamt!=0.0){
							String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
									"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+discac+"',"+
									"'"+roundamt+"','"+currate+"','"+curid+"',0,"+discid+",1,"+
									"'"+branch+"','"+note+"',"+
									"0,'"+sqldate+"','"+formdetailcode+"','"+roundldr+"','"+docno+"','"+note+"',"+
									"'"+curid+"','5',1,"+cldocno+",3)";
							System.out.println(sqljvdisc);
							i++;
							int discval=stmt.executeUpdate(sqljvdisc);
							if(discval<=0){
								System.out.println("Jv discount edit error");
								errorstatus=1;
							}

						}
					}
					partydramt=ramt;
					compdramt=remaintotal;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(partydramt!=0.0){
						String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+insuracno+"',"+
								" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+sqldate+"',"+
								" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
								System.out.println("Insur Company Jv1:"+strjvparty);
								int jvparty=stmt.executeUpdate(strjvparty);
								if(jvparty<=0){
									System.out.println("Insur JV edit error");
									errorstatus=1;
								}
								i++;

					}
					if(hidchksaperateinvoice.equalsIgnoreCase("0")){
						remaintotal+=excessamt;
					}
					remaintotal-=vatval;
					partydramt=remaintotal;
					compdramt=remaintotal*-1;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(compdramt!=0.0){
						String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
								" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+compacno+"',"+
								" '"+compdramt+"','"+currate+"','"+curid+"',0,-1,1,'"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"',"+
								" '"+compldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,"+cldocno+",3)";
								System.out.println("Insur Company Jv2:"+strjvcomp);
								int jvcomp=stmt.executeUpdate(strjvcomp);
								if(jvcomp<=0){
									System.out.println("Insur Company Jv2 error");
									errorstatus=1;
								}
								i++;

					}
				}
				else{
					note="JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					if(strroundamt==null || strroundamt.trim().equalsIgnoreCase("") || strroundamt.trim().equalsIgnoreCase("undefined")){
						strroundamt="0.0";
					}
					double roundldr=0.0;
					roundamt=Double.parseDouble(strroundamt);
					if(roundamt!=0.0){
						ramt=remaintotal-roundamt;
					}
					else{
						ramt=remaintotal;
					}
					roundamt=objcommon.Round(roundamt, 2);
					roundldr=roundamt*currate;
					
					double ramtldr=ramt*currate;
					// discount a/c jvtran  discount*-1   
					Statement stmtdiscount=conn.createStatement();
					String strdiscount="select acno discountacno from gl_invmode where idno=13";
					ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
					int  discac=0;
					while(rsdiscount.next()){
						discac=rsdiscount.getInt("discountacno");
					}
					if(roundamt!=0.0){
						
						int discid=0;
						if(roundamt>0.0){
							discid=1;
						}
						else if(roundamt<0.0){
							discid=-1;
						}
						if(roundamt!=0.0){
							String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
									"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+discac+"',"+
									"'"+roundamt+"','"+currate+"','"+curid+"',0,"+discid+",1,"+
									"'"+branch+"','"+note+"',"+
									"0,'"+sqldate+"','"+formdetailcode+"','"+roundldr+"','"+docno+"','"+note+"',"+
									"'"+curid+"','5',1,"+cldocno+",3)";
							System.out.println(sqljvdisc);
							int discval=stmt.executeUpdate(sqljvdisc);
							i++;
							if(discval<=0){
								System.out.println("jv disc edit error");
								errorstatus=1;
							}

						}
					}
					partydramt=ramt;
					compdramt=remaintotal;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(partydramt!=0.0){
						String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+clientacno+"',"+
								" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+sqldate+"',"+
								" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
								System.out.println("Client Jv1:"+strjvparty);
								int jvparty=stmt.executeUpdate(strjvparty);
								if(jvparty<=0){
									errorstatus=1;
								}
								i++;

					}
					if(hidchksaperateinvoice.equalsIgnoreCase("0")){
						remaintotal+=excessamt;
					}
					remaintotal-=vatval;
					partydramt=remaintotal;
					compdramt=remaintotal*-1;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(compdramt!=0.0){
						String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
								" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+compacno+"',"+
								" '"+compdramt+"','"+currate+"','"+curid+"',0,-1,1,'"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"',"+
								" '"+compldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,"+cldocno+",3)";
								System.out.println("Client Jv2:"+strjvcomp);
								int jvcomp=stmt.executeUpdate(strjvcomp);
								if(jvcomp<=0){
									errorstatus=1;
								}
								i++;

					}
				}
				String strupdatediscount="update ws_invm set taxtotal="+ramt+",roundamt="+roundamt+" where doc_no="+docno;
				int updatediscount=stmt.executeUpdate(strupdatediscount);
				if(updatediscount<0){
					errorstatus=1;
				}
				int invduplicatecount=0;
				String strinvduplicatecount="select count(*) rowcount from ws_invm where reftype='"+cmbreftype+"' and refno="+hidrefno+" and status=3 AND DOC_NO!="+docno ;
				System.out.println("Duplicate Check:"+strinvduplicatecount);
				ResultSet rsinvduplicatecount=stmt.executeQuery(strinvduplicatecount);
				while(rsinvduplicatecount.next()){
					invduplicatecount=rsinvduplicatecount.getInt("rowcount");
				}
				if(invduplicatecount>0){
					System.out.println("Duplicate Found");
					return false;
				}
				String strgetamtforcost="select jv.acno,jv.dramount,jv.tranid from my_jvtran jv left join my_head head on jv.acno=head.doc_no where jv.tr_no="+trno+" and head.gr_type in (4,5) and jv.status=3";
				ResultSet rsamtforcost=stmt.executeQuery(strgetamtforcost);
				ArrayList<String> costarray=new ArrayList<>();
				int costcounter=1;
				while(rsamtforcost.next()){
					costarray.add(rsamtforcost.getInt("acno")+"::"+rsamtforcost.getDouble("dramount")+"::"+rsamtforcost.getInt("tranid")+"::"+costcounter);
					costcounter++;
				}
				for(int arrindex=0;arrindex<costarray.size();arrindex++){
					String temp[]=costarray.get(arrindex).split("::");
					String strcostinsert="insert into my_costtran(acno,costType,amount,sr_no,tranid,projectId,jobId,tr_no)values("+
					""+temp[0]+",9,"+temp[1]+","+temp[3]+","+temp[2]+",0,"+hidrefno+","+trno+")";
					System.out.println(strcostinsert);
					int costinsert=stmt.executeUpdate(strcostinsert);
					if(costinsert<=0){
						System.out.println("Cost Insert Error:"+strcostinsert);
						return false;
					}
					String strupdatejv="update my_jvtran set costtype=9,costcode="+hidrefno+" where status=3 and tr_no="+trno+" and tranid="+temp[2];
					int updatejv=stmt.executeUpdate(strupdatejv);
					if(updatejv<=0){
						System.out.println("JV Update Error :"+strupdatejv);
						return false;
					}
				}
				String testjv1="select dramount from my_jvtran where tr_no="+trno;
				ResultSet rstestjv1=stmt.executeQuery(testjv1);
				while(rstestjv1.next()){
					System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
				}
				//Updating in ws_invcalctemp
				double discountpercent=0.0;
				if(discountamt>0.0){
					discountpercent=(discountamt/totalamt)*100;
					discountpercent=objcommon.Round(discountpercent, 1);
				}
				ResultSet rsgetnetamtbeforeedit=stmt.executeQuery("select netamount from ws_invcalctemp where invno="+docno);
				double netamtbeforeedit=0.0;
				while(rsgetnetamtbeforeedit.next()){
					netamtbeforeedit=rsgetnetamtbeforeedit.getDouble("netamount");
				}
				String strinvcalc="update ws_invcalctemp set amount="+total+",discount="+discountamt+",netamount="+netamt+",vatamount="+taxamount+",totalamount="+taxtotal+",excessamount="+excessamount+",roundoff="+roundamt+",netbill="+ramt+",discountpercent="+discountpercent+" where invno="+docno;
				int updateinvcalc=stmt.executeUpdate(strinvcalc);
				if(updateinvcalc<=0){
					System.out.println("Update ws_invcalctemp error:"+strinvcalc);
					errorstatus=1;
					return false;
				}
				//Updating in ws_invinsurtype
				String strgetinsurtype="select * from ws_invinsurtype where invno="+docno;
				ArrayList<String> insurarray=new ArrayList<>();
				ResultSet rsgetinsurtype=stmt.executeQuery(strgetinsurtype);
				while(rsgetinsurtype.next()){
					double insurpercent=(rsgetinsurtype.getDouble("amount")/netamtbeforeedit)*100;
					insurpercent=objcommon.Round(insurpercent, 2);
					//System.out.println("Check:"+insurpercent+"::"+rsgetinsurtype.getDouble("amount")+"::"+netamtbeforeedit);
					insurarray.add(rsgetinsurtype.getString("srno")+"::"+rsgetinsurtype.getString("insurtype")+"::"+rsgetinsurtype.getString("amount")+"::"+insurpercent);
				}
				for(int j=0;j<insurarray.size();j++){
					//System.out.println("Insur:"+insurarray.get(j));
					String srno=insurarray.get(j).split("::")[0];
					String insurpercent=insurarray.get(j).split("::")[3];
					String insurtype=insurarray.get(j).split("::")[1];
					double insuramt=(Double.parseDouble(insurpercent)/100)*netamt;
					//System.out.println("Insur Amount:"+insuramt);
					String strupdateinsur="update ws_invinsurtype set amount="+insuramt+" where srno="+srno;
					int updateinsur=stmt.executeUpdate(strupdateinsur);
					if(updateinsur<=0){
						System.out.println("Update Insur Type Error:"+strupdateinsur);
						errorstatus=1;
						return false;
					}
				}
				if (docno > 0) {
					
					String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+trno;
					ResultSet rstestjv=stmt.executeQuery(testjv);
					while(rstestjv.next()){
						if(rstestjv.getDouble("dramount")==0.00){
							if(errorstatus==0){
								//conn.close();
								//System.out.println("Error status 0");
								return true;
							}
							else{
								conn.close();
								System.out.println("Error status != 0");
								return false;
							}
						}
						else{
							conn.close();
							System.out.println("Jv tally Error");
							return false;
						}
					}

				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			// conn.close();
		}
		//System.out.println("======== last return  ===== ");
		return false;
	}
	public boolean delete(Date sqldate, String cmbreftype, String hidrefno,
			String cldocno, String invoicetoacno, String excessamountacno,
			String total, String discount, String excessamount,
			String nettotal, String remarks, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode,
			String brchName, ArrayList<String> invoicearray, Connection conn,
			String taxpercent, String taxamount, String taxtotal,
			String hidchksaperateinvoice, String tempinvoicetoacno,
			int docno, String roundamt) throws SQLException {
		// TODO Auto-generated method stub
		int vocno=0,trno=0;
		try{
			excessamountacno=excessamountacno.trim().equalsIgnoreCase("")?"0":excessamountacno.trim();
			Statement stmt=conn.createStatement();
			
			CallableStatement stmtEst = conn.prepareCall("{call WSinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.setInt(14, docno);
			stmtEst.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,cmbreftype);
			stmtEst.setString(3,hidrefno);
			stmtEst.setString(4, invoicetoacno);
			stmtEst.setString(5,excessamountacno);
			stmtEst.setString(6,remarks);
			stmtEst.setString(7,total);
			stmtEst.setString(8,discount);
			stmtEst.setString(9,excessamount==null || excessamount.equalsIgnoreCase("null") ?"0":excessamount);
			stmtEst.setString(10,nettotal);
			stmtEst.setString(11,formdetailcode);
			stmtEst.setString(12,session.getAttribute("USERID").toString());
			stmtEst.setString(13,brchName);
			stmtEst.setString(16,mode);
			stmtEst.setString(18,taxpercent);
			stmtEst.setString(19,taxamount);
			stmtEst.setString(20,taxtotal);
			stmtEst.setString(21,hidchksaperateinvoice);
			int masterval=stmtEst.executeUpdate();
			vocno=stmtEst.getInt("voucher");
			trno=stmtEst.getInt("vtrNo");
			request.setAttribute("WSINVVOCNO", vocno);
			
			if(masterval>=0){
				ClsApplyDelete applydel=new ClsApplyDelete();
				applydel.getFinanceApplyDelete(conn, trno);
				return true;
			}
			else{
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		return false;
	}
	public JSONArray getRefData(String docno,String date,String cldocno,String clientname,
			String rtype,String id,String brhid)throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strgetconfig="select method from gl_config where field_nme='WSEarlyInv'";
			int jobconfig=0;
			ResultSet rsconfig=stmt.executeQuery(strgetconfig);
			while(rsconfig.next()){
				jobconfig=rsconfig.getInt("method");
			}
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no like '%"+docno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and job.date='"+sqldate+"'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(jobconfig==1){
				sqltest+=" and gate.processstatus>=5 and gate.processstatus<=7";
			}
			else{
				sqltest+=" and gate.processstatus=6";
			}
			if(!brhid.equalsIgnoreCase("")){
				sqltest+=" and job.brhid="+brhid;
			}
			if(rtype.equalsIgnoreCase("JC")){
				/*String strsql="select bill.acno billtoacno,billhead.account billtoaccount,billhead.description billtoacname,coalesce(gate.insurancecomp,0) billtoinsurance,est.nettotal,ac.refname,job.date,ac.cldocno,gate.regno,head.account,head.doc_no acno,head.description acname,job.voc_no,job.doc_no,"+
				" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
				" ' , Contact Person ',ac.contactperson) userdetails, convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',"+
				" coalesce(yom.yom,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicledetails from "
				+ " ws_gateinpass gate left join ws_estm est on est.gipno=gate.doc_no left join "
				+ " ws_jobcard job  on ((job.reftype='GIP' and job.refno=gate.doc_no) or "
				+ "(job.reftype='est' and job.refno=est.doc_no )) left join my_acbook ac "
				+ "on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_acbook bill "
				+ "on (((gate.insurancecomp=1 and gate.insurcldocno=bill.cldocno) or "
				+ " (gate.insurancecomp=0 and gate.cldocno=bill.cldocno)) and bill.dtype='CRM') left join gl_vehbrand brd on "+
				" gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on "+
				" gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no  left join my_head head on ac.acno=head.doc_no left join my_head billhead on bill.acno=billhead.doc_no where job.status=3 "+sqltest;*/
				String strsql="select job.doc_no,job.voc_no,ac.refname,ac.cldocno,job.date from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on ((job.reftype='EST' and est.gipno=gate.doc_no) or (job.reftype='GIP' and job.refno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where job.status=3 "+sqltest;
				System.out.println(strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getAccountData(String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select doc_no,account,description from my_head where atype='GL' and m_s=0";
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return data;
	}

	public int insert(Date sqldate, String cmbreftype, String hidrefno,
			String cldocno, String invoicetoacno, String excessamountacno,
			String total, String discount, String excessamount,
			String nettotal, String remarks, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode, 
			String branch, ArrayList<String> invoicearray,Connection conn, String taxpercent, 
			String taxamount, String taxtotal,String hidchksaperateinvoice,String billtoacno) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0,vocno=0,trno=0;
		try{
			excessamountacno=excessamountacno.trim().equalsIgnoreCase("")?"0":excessamountacno.trim();
			Statement stmt=conn.createStatement();
			
			CallableStatement stmtEst = conn.prepareCall("{call WSinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,cmbreftype);
			stmtEst.setString(3,hidrefno);
			stmtEst.setString(4, invoicetoacno);
			stmtEst.setString(5,excessamountacno);
			stmtEst.setString(6,remarks);
			stmtEst.setString(7,total);
			stmtEst.setString(8,discount);
			stmtEst.setString(9,excessamount==null || excessamount.equalsIgnoreCase("null") ?"0":excessamount);
			stmtEst.setString(10,nettotal);
			stmtEst.setString(11,formdetailcode);
			stmtEst.setString(12,session.getAttribute("USERID").toString());
			stmtEst.setString(13,branch);
			stmtEst.setString(16,mode);
			stmtEst.setString(18,taxpercent);
			stmtEst.setString(19,taxamount);
			stmtEst.setString(20,taxtotal);
			stmtEst.setString(21,hidchksaperateinvoice);
			stmtEst.executeQuery();
			docno=stmtEst.getInt("docNo");
			vocno=stmtEst.getInt("voucher");
			trno=stmtEst.getInt("vtrNo");
			request.setAttribute("WSINVVOCNO", vocno);
			String strupdateacno="update ws_invm set invoicetoacno="+billtoacno+" where doc_no="+docno;
			int updateacno=stmt.executeUpdate(strupdateacno);
			int errorstatus=0;
			if(updateacno<=0){
				errorstatus=0;
				return 0;
			}
			
			if(docno<=0){
				errorstatus=1;
				//conn.close();
				return 0;
			}
			else{
				
				int invdrowno=0;
				for(int i=0,j=1;i<invoicearray.size();i++,j++){
					String temp[]=invoicearray.get(i).split("::");
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					String str="insert into ws_invd(rdocno,srno,desc1,amount)values("+docno+","+j+",'"+temp[0]+"',"+temp[1]+")";
					int insertval=stmt.executeUpdate(str);
					if(insertval<=0){
						errorstatus=1;
//						conn.close();
						return 0;
					}
					invdrowno=j;
				}
				if(hidchksaperateinvoice.equalsIgnoreCase("1") && Double.parseDouble(excessamount)>0.0){
					String strexcessinvd="insert into ws_invd(rdocno,srno,desc1,amount)values("+docno+","+(invdrowno+1)+",'Excess Amount',"+Double.parseDouble(excessamount)*-1+")";
					int insertexcessinvd=stmt.executeUpdate(strexcessinvd);
					if(insertexcessinvd<=0){
						errorstatus=1;
//						conn.close();
						return 0;
					}
				}
				double totalamt=0.0,discountamt=0.0,excessamt=0.0,netamt=0.0,remaintotal=0.0;
				totalamt=Double.parseDouble(total);
				discountamt=Double.parseDouble(discount);
				if(excessamount!=null){
					excessamt=Double.parseDouble(excessamount);
				}
				
				netamt=Double.parseDouble(nettotal);
				if(excessamt>0.0 && hidchksaperateinvoice.equalsIgnoreCase("1")){
					netamt-=excessamt;
				}
				int insurtodocno=0;
				String strdecideinvoiceto="select if(gate.insurancecomp>0,gate.insurcldocno,gate.cldocno) invoicetodocno from ws_jobcard job "+
				" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) "+
				" where job.doc_no="+hidrefno;
				ResultSet rsinvoicetodetails=stmt.executeQuery(strdecideinvoiceto);
				while(rsinvoicetodetails.next()){
					insurtodocno=rsinvoicetodetails.getInt("invoicetodocno");
				}
				
				ArrayList<String> acnodetailarray=getWorkshopAccountDetails(conn,cmbreftype,hidrefno);
				//Excess Amt Corresponding to Client
				int compacno=0,clientacno=0,insuracno=0,curid=0;
				double currate=0.0,partydramt=0.0,compdramt=0.0,partyldramt=0.0,compldramt=0.0;
				String note="";
				compacno=Integer.parseInt(acnodetailarray.get(2));
				insuracno=Integer.parseInt(acnodetailarray.get(0));
				clientacno=Integer.parseInt(acnodetailarray.get(1));
				curid=Integer.parseInt(acnodetailarray.get(3));
				currate=Double.parseDouble(acnodetailarray.get(4));
				String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+insurtodocno+" and dtype='CRM') clienttaxmethod";
//				System.out.println(strchecktax);
				Statement stmtchecktax=conn.createStatement();
				ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				double vatval=0.0,setval=0.0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				if(taxstatus==1 && clienttaxmethod==1){
					double generalamttax=netamt;
					String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
					double setpercent=0.0;
					double vatpercent=0.0;
					ResultSet rsgettax=stmt.executeQuery(strgettax);
					ArrayList<String> temptaxarray=new ArrayList<>();
					while(rsgettax.next()){
						setpercent=rsgettax.getDouble("set_per");
						vatpercent=rsgettax.getDouble("vat_per");
						vatval=(generalamttax*(vatpercent/100));
						setval=generalamttax*(setpercent/100);
						setval=objcommon.Round(setval, 2);
						vatval=objcommon.Round(vatval, 2);
						if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
							if(vatval>0.0){
								temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
								netamt+=vatval;
							}
						}
					}
					if(setpercent>0.0 || vatpercent>0.0){
						double generalldr=0.0;
						netamt=objcommon.Round(netamt, 2);
						generalldr=netamt*currate;
						int tempsrno=invoicearray.size()+1;
						note="VAT Entry of Workshop Invoice "+docno;
						note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
						for(int j=0;j<temptaxarray.size();j++){
							String[] tax=temptaxarray.get(j).split("::");
							if(Double.parseDouble(tax[2])>0){
								String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
								" '"+Double.parseDouble(tax[2])*-1+"','"+currate+"','"+curid+"',0,-1,'"+(tempsrno)+"',"+
								" '"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*currate)*-1+"','"+docno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
								"'"+curid+"','5',1,'"+cldocno+"',3)";
//								System.out.println("Tax Jv1:"+strtaxjv);
								tempsrno++;
								Statement stmttaxjv=conn.createStatement();
								//System.out.println("Jvtran Sql:"+strtaxjv);
								int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
								if(taxjvval>0){
									
								}
								else{
									System.out.println("Jvtran Tax Error");
									conn.close();
									return 0;
								}
								/*
								String strtaxjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
										"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+(insuracno>0?insuracno:clientacno)+"',"+
										" '"+Double.parseDouble(tax[2])+"','"+currate+"','"+curid+"',0,-1,'"+(tempsrno)+"',"+
										" '"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*currate)*-1+"','"+docno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
										"'"+curid+"','5',1,'"+cldocno+"',3)";
								System.out.println("Tax Jv2:"+strtaxjv);
										tempsrno++;
										System.out.println("Jvtran Sql:"+strtaxjv);
										int taxjvval2=stmttaxjv.executeUpdate(strtaxjv2);
										if(taxjvval2>0){
											
										}
										else{
											System.out.println("Jvtran Tax Error");
											return 0;
										}*/
								stmttaxjv.close();
							}
						}
					}
				}
				//Jvtran Entries
				if(excessamt>0.0 && hidchksaperateinvoice.equalsIgnoreCase("0")){
					remaintotal=netamt-excessamt;
				}
				else{
					remaintotal=netamt;
				}
				int i=0;
				if(excessamt>0.0 && hidchksaperateinvoice.equalsIgnoreCase("0")){
					partydramt=excessamt;
					compdramt=excessamt;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					note="Excess Amt JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					if(partydramt!=0.0){
						String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+clientacno+"',"+
								" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+sqldate+"',"+
								" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
//								System.out.println("Excess JV 1:"+strjvparty);
								int jvparty=stmt.executeUpdate(strjvparty);
								if(jvparty<=0){
									errorstatus=1;
								}
								i++;

					}
					/*String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
					" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+excessamountacno+"',"+
					" '"+compdramt+"','"+currate+"','"+curid+"',0,1,1,'"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"',"+
					" '"+compldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,"+cldocno+",3)";
					System.out.println("Excess JV 2:"+strjvcomp);
					int jvcomp=stmt.executeUpdate(strjvcomp);
					if(jvcomp<=0){
						errorstatus=1;
					}
					i++;*/
				}
				double ramt=0.0;
				double roundamt=0.0;
				if(insuracno>0){
					note="JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					int discountconfig=getDiscountConfig(conn);
					
					double roundldr=0.0;
					if(discountconfig==1){
						ramt=Math.round(remaintotal);
						roundamt= (remaintotal-ramt);
						roundamt=objcommon.Round(roundamt, 2);
						roundldr=roundamt*currate;
					}
					else{
						ramt=remaintotal;
						
					}
					double ramtldr=ramt*currate;
					// discount a/c jvtran  discount*-1   
					Statement stmtdiscount=conn.createStatement();
					String strdiscount="select acno discountacno from gl_invmode where idno=13";
					ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
					int  discac=0;
					while(rsdiscount.next()){
						discac=rsdiscount.getInt("discountacno");
					}
					if(roundamt!=0.0){
						
						int discid=0;
						if(roundamt>0.0){
							discid=1;
						}
						else if(roundamt<0.0){
							discid=-1;
						}
						note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
						if(roundamt!=0.0){
							String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
									"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+discac+"',"+
									"'"+roundamt+"','"+currate+"','"+curid+"',0,"+discid+",1,"+
									"'"+branch+"','"+note+"',"+
									"0,'"+sqldate+"','"+formdetailcode+"','"+roundldr+"','"+docno+"','"+note+"',"+
									"'"+curid+"','5',1,"+cldocno+",3)";
							i++;
							int discval=stmt.executeUpdate(sqljvdisc);
							if(discval<=0){
								errorstatus=1;
							}

						}
					}
					partydramt=ramt;
					compdramt=remaintotal;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(partydramt!=0.0){
						String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+insuracno+"',"+
								" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+sqldate+"',"+
								" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
//								System.out.println("Insur Company Jv1:"+strjvparty);
								int jvparty=stmt.executeUpdate(strjvparty);
								if(jvparty<=0){
									errorstatus=1;
								}
								i++;

					}
					if(hidchksaperateinvoice.equalsIgnoreCase("0")){
						remaintotal+=excessamt;
					}
					remaintotal-=vatval;
					partydramt=remaintotal;
					compdramt=remaintotal*-1;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(compdramt!=0.0){
						String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
								" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+compacno+"',"+
								" '"+compdramt+"','"+currate+"','"+curid+"',0,-1,1,'"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"',"+
								" '"+compldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,"+cldocno+",3)";
//								System.out.println("Insur Company Jv2:"+strjvcomp);
								int jvcomp=stmt.executeUpdate(strjvcomp);
								if(jvcomp<=0){
									errorstatus=1;
								}
								i++;

					}
				}
				else{
					note="JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					int discountconfig=getDiscountConfig(conn);
					
					double roundldr=0.0;
					if(discountconfig==1){
						ramt=Math.round(remaintotal);
						roundamt= (remaintotal-ramt);
						roundamt=objcommon.Round(roundamt, 2);
						roundldr=roundamt*currate;
					}
					else{
						ramt=remaintotal;
						
					}
					double ramtldr=ramt*currate;
					// discount a/c jvtran  discount*-1   
					Statement stmtdiscount=conn.createStatement();
					String strdiscount="select acno discountacno from gl_invmode where idno=13";
					ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
					int  discac=0;
					while(rsdiscount.next()){
						discac=rsdiscount.getInt("discountacno");
					}
					if(roundamt!=0.0){
						
						int discid=0;
						if(roundamt>0.0){
							discid=1;
						}
						else if(roundamt<0.0){
							discid=-1;
						}
						if(roundamt!=0.0){
							String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
									"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+discac+"',"+
									"'"+roundamt+"','"+currate+"','"+curid+"',0,"+discid+",1,"+
									"'"+branch+"','"+note+"',"+
									"0,'"+sqldate+"','"+formdetailcode+"','"+roundldr+"','"+docno+"','"+note+"',"+
									"'"+curid+"','5',1,"+cldocno+",3)";
							int discval=stmt.executeUpdate(sqljvdisc);
							i++;
							if(discval<=0){
								errorstatus=1;
							}

						}
					}
					partydramt=ramt;
					compdramt=remaintotal;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(partydramt!=0.0){
						String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+clientacno+"',"+
								" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+sqldate+"',"+
								" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
//								System.out.println("Client Jv1:"+strjvparty);
								int jvparty=stmt.executeUpdate(strjvparty);
								if(jvparty<=0){
									errorstatus=1;
								}
								i++;

					}
					if(hidchksaperateinvoice.equalsIgnoreCase("0")){
						remaintotal+=excessamt;
					}
					remaintotal-=vatval;
					partydramt=remaintotal;
					compdramt=remaintotal*-1;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					if(compdramt!=0.0){
						String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
								" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+compacno+"',"+
								" '"+compdramt+"','"+currate+"','"+curid+"',0,-1,1,'"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"',"+
								" '"+compldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,"+cldocno+",3)";
//								System.out.println("Client Jv2:"+strjvcomp);
								int jvcomp=stmt.executeUpdate(strjvcomp);
								if(jvcomp<=0){
									errorstatus=1;
								}
								i++;

					}
				}
				String strupdatediscount="update ws_invm set taxtotal="+ramt+",roundamt="+roundamt+" where doc_no="+docno;
				int updatediscount=stmt.executeUpdate(strupdatediscount);
				if(updatediscount<0){
					errorstatus=1;
				}
				int invduplicatecount=0;
				String strinvduplicatecount="select count(*) rowcount from ws_invm where reftype='"+cmbreftype+"' and refno="+hidrefno+" and status=3 AND DOC_NO!="+docno ;
				System.out.println("Duplicate Check:"+strinvduplicatecount);
				ResultSet rsinvduplicatecount=stmt.executeQuery(strinvduplicatecount);
				while(rsinvduplicatecount.next()){
					invduplicatecount=rsinvduplicatecount.getInt("rowcount");
				}
				if(invduplicatecount>0){
					return 0;
				}
				
				String testjv1="select dramount from my_jvtran where tr_no="+trno;
				ResultSet rstestjv1=stmt.executeQuery(testjv1);
				while(rstestjv1.next()){
//					System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
				}
				if (docno > 0) {
					
					String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+trno;
					ResultSet rstestjv=stmt.executeQuery(testjv);
					while(rstestjv.next()){
						if(rstestjv.getDouble("dramount")==0.00){
							if(errorstatus==0){
								//conn.close();
								System.out.println("Error status 0");
								return docno;
							}
							else{
								conn.close();
								System.out.println("Error status != 0");
								return 0;
							}
						}
						else{
							conn.close();
							System.out.println("Jv tally Error");
							return 0;
						}
					}

				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			// conn.close();
		}
		System.out.println("======== last return  ===== ");
		return 0;
	}

	public String getJvDescription(Connection conn, String remarks,
			String cmbreftype, String hidrefno) throws SQLException {
		// TODO Auto-generated method stub
		String desc="";
		try{
			Statement stmt=conn.createStatement();
			String strsql="select concat('"+remarks+"',' ','Job Card ',job.voc_no,' ','Reg No ',gate.regno,' ',gate.pltid,' - ',concat(brd.brand_name,' ',model.vtype)) description "+
			" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass"+
			" gate on est.gipno=gate.doc_no left join gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on "+
			" gate.modid=model.doc_no where job.doc_no="+hidrefno;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				desc=rs.getString("description");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		
		return desc;
	}

	public int getDiscountConfig(Connection conn) throws SQLException {
		// TODO Auto-generated method stub
	int discount=0;
	try{
		Statement stmt=conn.createStatement();
		String str="select method from gl_config where field_nme='invDiscount'";
		ResultSet rs=stmt.executeQuery(str);
		while(rs.next()){
			discount=rs.getInt("method");
		}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		
		return discount;
	}
	
	
	public ArrayList<String> getWorkshopAccountDetails(Connection conn, String cmbreftype, String hidrefno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> acdetailsarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select head.curid,COALESCE(head.rate,0) currate,coalesce(insur.acno,0) insuracno,coalesce(ac.acno) clientacno,(select head.doc_no from my_account ac "+
			" inner join my_head head on (ac.acno=head.doc_no) where ac.codeno='WORKSHOPACCOUNT') compacno from ws_jobcard job left join "+
			" ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',"+
			" job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" left join my_acbook insur on (gate.insurancecomp=1 and gate.insurcldocno=insur.cldocno) left join my_head head on (ac.acno=head.doc_no) where job.status=3 and job.doc_no="+hidrefno;
//			System.out.println("AC Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				acdetailsarray.add(rs.getString("insuracno"));
				acdetailsarray.add(rs.getString("clientacno"));
				acdetailsarray.add(rs.getString("compacno"));
				acdetailsarray.add(rs.getString("curid"));
				acdetailsarray.add(rs.getString("currate"));
			}
			for(int i=0;i<acdetailsarray.size();i++){
				System.out.println("Testing Ac Details:"+acdetailsarray.get(i));
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		//conn.close();
		return acdetailsarray;
	}
	
	public JSONArray getSearchData(String docno,String date,String jobcardno,String regno,String cldocno,
			String clientname,String id,HttpSession session,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and invm.voc_no like '%"+docno+"%'";
			}
			if(!brhid.equalsIgnoreCase("")){
				sqltest+=" and invm.brhid="+brhid;
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and invm.date='"+sqldate+"'";
			}
			if(!jobcardno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no like '%"+jobcardno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+regno+"%'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			/*if(!session.getAttribute("BRANCHID").toString().equalsIgnoreCase("")){
				sqltest+=" and invm.brhid="+session.getAttribute("BRANCHID").toString();
			}*/
			String strsql="select invm.excessinvdocno,billhead.account billtoaccount,billhead.description billtoacname,invm.roundamt,invm.taxpercent,invm.taxamount,invm.taxtotal,est.nettotal,round(invm.total,2) total,round(invm.discount,2) discount,round(invm.excess,2)excessamt,round(invm.nettotal,2) "+
			" nettotal,invm.remarks,invoiceto.account invoicetoaccount,invoiceto.doc_no invoicetoacno,invoiceto.description invoicetoacname,"+
			" excess.account excessaccount,excess.doc_no excessacno,excess.description excessacname,invm.doc_no,invm.voc_no,invm.date,"+
			" invm.reftype,convert(if(invm.reftype='JC',job.voc_no,''),char(25)) refvocno,convert(if(invm.reftype='JC',job.doc_no,''),char(25)) refno,gate.regno,ac.cldocno,"+
			" ac.refname,concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
			" ' , Contact Person ',ac.contactperson) userdetails, convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',"+
			" coalesce(yom.yom,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicledetails from ws_invm invm left join ws_jobcard job"+
			" on (invm.reftype='JC' and invm.refno=job.doc_no) left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left"+
			" join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on"+
			" (gate.cldocno=ac.cldocno and ac.dtype='CRM')  left join my_acbook bill on (if(gate.insurancecomp=1,gate.insurcldocno=bill.cldocno,gate.cldocno=bill.cldocno) and bill.dtype='CRM') left join gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on"+
			" gate.modid=model.doc_no left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no"+
			" left join my_head invoiceto on invm.acno=invoiceto.doc_no left join my_head excess on invm.excessacno=excess.doc_no  left join my_head billhead on bill.acno=billhead.doc_no where invm.status=3"+sqltest;
//			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getGridData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select desc1,amount from ws_invd where rdocno="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getDetailGridData(String jobcarddocno,String id, String docno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			String addition="";
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String straddition="select group_concat(distinct t.addition) addition from ws_invm m left join ws_invcalctemp t on m.doc_no=t.invno where m.doc_no="+docno;
			System.out.println(addition+"==="+straddition);
					ResultSet rsadd=stmt.executeQuery(straddition);
					while(rsadd.next()){
						addition=rsadd.getString("addition");
					}
			String strcheck="select est.chklumsum from ws_jobcard card left join ws_estm est on "+
			" (card.reftype='EST' and card.refno=est.doc_no) where card.doc_no="+jobcarddocno+" and card.status=3";
			ResultSet rscheck=stmt.executeQuery(strcheck);
			int lumsum=0;
			while(rscheck.next()){
				lumsum=rscheck.getInt("chklumsum");
			}
			String strtest="";
			String strconfig="select method from gl_config where field_nme='WSJCProforma'";
			ResultSet rsconfig=stmt.executeQuery(strconfig);
			int proformaconfig=0;
			while(rsconfig.next()){
				proformaconfig=rsconfig.getInt("method");
			}
			/*if(lumsum==1){
				strtest="select @j:=0 count,'Lum Sum' description,round(est.lumsumamount,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on"+
			" (card.reftype='EST' and card.refno=est.doc_no) where card.doc_no="+jobcarddocno+" and card.status=3";
			}
			else{*/
				if(proformaconfig==1){
					strtest="select @j:=0 count,if(spare.description='',m.productname,spare.description) description,round(spare.customeramt,2) amount,est.voc_no from ws_jccspare spare left join ws_jobcard card on spare.jobcarddocno=card.doc_no left join "+
					" ws_estm est on (card.reftype='EST' and card.refno=est.doc_no)  left join my_main m on m.psrno=spare.psrno "+
					" where card.doc_no="+jobcarddocno+" and card.status=3 and spare.addition in ("+addition+")";
				}
				else{
					strtest="select @j:=0 count,spare.description,round(spare.approvedvalue,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on"+
							" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estspare spare on est.doc_no=spare.rdocno  where card.doc_no="+jobcarddocno+" "+
							" and card.status=3  and spare.addition in ("+addition+")";
				}
			//}
			String strsql="";
			if(proformaconfig==1){
				strsql="select convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) serialno,a.description,a.amount from ("+
						" select @i:=0 count,lab.strjobdesc description,round(lab.invoiceamt,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
						" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+jobcarddocno+" and card.status=3 and lab.confirmed=1 and lab.approved=1  and lab.addition in ("+addition+") union all "+
						" select @i:=0 count,extra.description,round(extra.amount,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_jccextra extra "+
						" on card.doc_no=extra.jobcarddocno where card.doc_no="+jobcarddocno+" and card.status=3  and coalesce(extra.jobcarddocno,0)<>0)a union all"+
						" select convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount from ("+
						" "+strtest+")a";
			}
			else{
				strsql="select convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) serialno,a.description,a.amount from ("+
						" select @i:=0 count,lab.strjobdesc description,round(lab.total,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
						" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+jobcarddocno+" and lab.addition in ("+addition+") and card.status=3 and lab.confirmed=1 and lab.approved=1 )a union all"+
						" select convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount from ("+
						" "+strtest+")a";
			}
			System.out.println("Detail Grid Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return data;
	}

	public ClsWSInvoiceBean printDetails(String doc, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		ClsWSInvoiceBean bean=new ClsWSInvoiceBean();
		DecimalFormat df=new DecimalFormat("###,##0.00");
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(inv.claimno,'') fancyclaimno,coalesce(inv.lpono,'') fancylpono,coalesce(finalclient.trnnumber,'') finalclienttrn,concat(finalclient.cldocno,' - ',finalclient.refname) finalclient,coalesce(finalclient.address,'') "+
			" finalclientaddress,coalesce(finalclient.per_mob) finalclientmobile,coalesce(finalclient.mail1,'') finalclientmail,round(taxtotal+roundamt,2) woround,gate.policerep policereport,gate.claim claimno,gate.lpo lpono,(INV.NETTOTAL-INV.EXCESS)!=0 TOTAL,inv.remarks,gate.insurancecomp,inv.excessinvdocno,round(coalesce(inv.roundamt*-1,0),2) roundamt,est.doc_no estdocno,ac.cldocno,job.date sqljobdate,date_format(job.date,'%d-%m-%Y') jobdate,coalesce(br.tinno,'') comptrn,coalesce(bill.trnnumber,'') clienttrn,coalesce(ac.trnnumber,'') orgclienttrn,u.user_name,DATE_FORMAT(CURDATE(),'%d.%m.%Y') finaldate,inv.doc_no,round(inv.total,2) total, round(inv.discount,2) discount, round(inv.excess,2) excess, round(inv.nettotal,2) nettotal,"+
			" round(inv.taxpercent,2) taxpercent, round(inv.taxamount,2) taxamount,round(inv.taxtotal,2) taxtotal,br.branchname,comp.company,"+
			" comp.address compaddress,comp.tel,comp.fax,inv.voc_no invno,date_format(inv.date,'%d.%m.%Y') date,concat(inv.reftype,' - ',case "+
			" when inv.reftype='JC' then job.voc_no else '' end) refno,concat(bill.cldocno,' - ',bill.refname) client,coalesce(bill.address,'') "+
			" address,coalesce(bill.per_mob) mobile,coalesce(bill.mail1,'') mail,concat(ac.cldocno,' - ',ac.refname) orgclient,coalesce(ac.address,'') "+
			" orgaddress,coalesce(ac.per_mob) orgmobile,coalesce(ac.mail1,'') orgmail,concat(gate.regno,' - ',gate.pltid,' - ',coalesce(brd.brand_name,''),"+
			" ' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gate.vehother,''),'Mileage: ',coalesce(gate.kmin,0)) vehicle,concat(gate.regno,'-',gate.pltid )regno,coalesce(brd.brand_name,'')brand,coalesce(yom.yom,'')model,coalesce(model.vtype,'') vehdetails,coalesce(gate.other,'') "+
			" chassis,coalesce(gate.kmin,0)kilometer,job.compremarks compremark ,concat(gate.regno,' - ',gate.pltid,' - ',coalesce(brd.brand_name,''),"+
			" ' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gate.vehother,'')) carfarevehicle from ws_invm inv left join ws_jobcard job on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on"+
			" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.reftype='GIP' and"+
			" job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
			" my_acbook bill on (if(gate.insurancecomp=1,gate.insurcldocno=bill.cldocno,gate.cldocno=bill.cldocno) and bill.dtype='CRM') left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on"+
			" gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no left join my_head invoiceto on inv.acno=invoiceto.doc_no"+
			" left join my_head excess on inv.excessacno=excess.doc_no left join my_brch br on inv.brhid=br.doc_no left join my_comp comp on"+
			" br.cmpid=comp.doc_no left join my_user u on u.doc_no=inv.userid left join my_acbook finalclient on inv.acno=finalclient.acno where inv.status=3 and inv.doc_no="+doc;
			System.out.println("query=============="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			int gatedocno=0,estdocno=0;
			int docno=0,cldocno=0;
			java.sql.Date sqljobdate=null;
			ClsAmountToWords objamount=new ClsAmountToWords();
			while(rs.next()){
				/*gatedocno=rs.getInt("gatedocno");*/
				bean.setLblremarks(rs.getString("remarks"));
				int excessinvdocno=rs.getInt("excessinvdocno");
				if(rs.getInt("insurancecomp")>0){
					if(rs.getInt("TOTAL")==0){
						bean.setLblclient(rs.getString("orgclient"));
						bean.setLbladdress(rs.getString("orgaddress"));
						bean.setLblmobile(rs.getString("orgmobile"));
						bean.setLblemail(rs.getString("orgmail"));
						bean.setLblclienttrn(rs.getString("orgclienttrn"));
					}
					else if(rs.getInt("TOTAL")!=0){
						bean.setLblclient(rs.getString("client"));
						bean.setLbladdress(rs.getString("address"));
						bean.setLblmobile(rs.getString("mobile"));
						bean.setLblemail(rs.getString("mail"));
						bean.setLblclienttrn(rs.getString("clienttrn"));
					}
				}
				else{
					bean.setLblclient(rs.getString("client"));
					bean.setLbladdress(rs.getString("address"));
					bean.setLblmobile(rs.getString("mobile"));
					bean.setLblemail(rs.getString("mail"));
					bean.setLblclienttrn(rs.getString("clienttrn"));
				}
				System.out.println("===excess == "+rs.getInt("excess"));
				if(rs.getInt("excess")!=0){
					bean.setLblclientfancy(rs.getString("client"));
					bean.setLbladdressfancy(rs.getString("address"));
					bean.setLblmobilefancy(rs.getString("mobile"));
					bean.setLblemailfancy(rs.getString("mail"));
					bean.setLblclienttrnfancy(rs.getString("clienttrn"));
				}else{
					System.out.println("else ==== ");
					bean.setLblclientfancy(rs.getString("orgclient"));
					bean.setLbladdressfancy(rs.getString("orgaddress"));
					bean.setLblmobilefancy(rs.getString("orgmobile"));
					bean.setLblemailfancy(rs.getString("orgmail"));
					bean.setLblclienttrnfancy(rs.getString("orgclienttrn"));
					System.out.println("==="+bean.getLblclientfancy()+"====="+bean.getLbladdressfancy());
					
				}
				sqljobdate=rs.getDate("sqljobdate");
				estdocno=rs.getInt("estdocno");
				docno=rs.getInt("doc_no");
				cldocno=rs.getInt("cldocno");
				bean.setLblround(df.format(rs.getDouble("roundamt")));
				bean.setLblbranch(rs.getString("branchname"));
				bean.setLblcompname(rs.getString("company"));
				bean.setLblcompaddress(rs.getString("compaddress"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblprintname("Job Card");
				bean.setLblchassis(rs.getString("chassis"));
				bean.setLblrefno(rs.getString("refno"));
				/*bean.setLblclient(rs.getString("client"));*/
				bean.setLbldate(rs.getString("date"));
				bean.setLblinvno(rs.getString("invno"));
				/*bean.setLbladdress(rs.getString("address"));
				bean.setLblmobile(rs.getString("mobile"));
				bean.setLblemail(rs.getString("mail"));*/
				bean.setLblvehicle(rs.getString("vehicle"));
				bean.setVehdetails(rs.getString("vehdetails"));
				bean.setLbltotal(df.format(rs.getDouble("nettotal")));
				bean.setTotalfancy(df.format(rs.getDouble("nettotal")+rs.getDouble("excess")));
				bean.setLbltax(df.format(rs.getDouble("taxamount")));
				bean.setLblnetamount(df.format(rs.getDouble("taxtotal")));
				bean.setWoroundof(df.format(rs.getDouble("woround")));
				bean.setLblcheckedby(rs.getString("user_name"));
				bean.setLblfinaldate(rs.getString("finaldate"));
				bean.setPolicereportno(rs.getString("policereport"));
				bean.setLpo(rs.getString("lpono"));
				bean.setClaim(rs.getString("claimno"));
				bean.setBrand(rs.getString("brand"));
				bean.setLblregno(rs.getString("regno"));
				bean.setModel(rs.getString("model"));
				bean.setLblamountwords(objamount.convertAmountToWords(rs.getString("taxtotal")));
				bean.setAmtinwords(objamount.convertAmountToWords(rs.getString("woround")));
				bean.setLblcomptrn(rs.getString("comptrn"));
				bean.setPreparedby(rs.getString("user_name"));
				bean.setExcessamount(rs.getString("excess"));
				bean.setLblclientfancy(rs.getString("finalclient"));
				bean.setLbladdressfancy(rs.getString("finalclientaddress"));
				bean.setLblclienttrnfancy(rs.getString("finalclienttrn"));
				bean.setLblclaimnofancy(rs.getString("fancyclaimno"));
				bean.setLbllponofancy(rs.getString("fancylpono"));
				bean.setLblkilometer(rs.getString("kilometer"));
				bean.setLbljobdate(rs.getString("jobdate"));
				bean.setLblcompremarks(rs.getString("compremark"));
				bean.setLblcarfarevehicle(rs.getString("carfarevehicle"));
				System.out.println("check-----------"+objamount.convertAmountToWords(rs.getString("woround"))+df.format(rs.getDouble("woround")));
				
			}
			
			String sqljrxml1="select @i:=@i+1 as srno,a.* from(select desc1,format(amount,2) amount,round(amount,2) jamount from ws_invd where rdocno="+docno+") a,(select @i:=0) r";
			bean.setWsinvqry(sqljrxml1);
			
			String sqljrxml2="select @i:=@i+1 as srno,a.* from(select lab.rowno,format(lab.invoiceamt,2) invoiceamt,round(lab.invoiceamt,2) jinvoiceamt,lab.strjobdesc jobdesc,t.type jobtype"
							+" from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no"
							+" where m.status=3 and lab.rdocno="+estdocno+" and lab.confirmed=1 and lab.approved=1"
							+" union all select 0,format(amount,2) invoiceamt,round(amount,2) jinvoiceamt,description jobdesc,'' jobtype from ws_jccextra where estdocno="+estdocno+" and status=3) a,(select @i:=0) r;";
			System.out.println("Job Query: "+sqljrxml2);
			bean.setWsjobqry(sqljrxml2);
			
			
			String strgetdefaultpsrnoconfig="select method,value from gl_config where field_nme='defaultConsumable'";
			int defaultpsrnomethod=0,defaultpsrno=0;
			ResultSet rsdefaultpsrno=stmt.executeQuery(strgetdefaultpsrnoconfig);
			while(rsdefaultpsrno.next()){
				defaultpsrnomethod=rsdefaultpsrno.getInt("method");
				defaultpsrno=rsdefaultpsrno.getInt("value");
			}
			String sqljrxml3="";
			if(defaultpsrnomethod==1 && defaultpsrno>0){
				sqljrxml3="select @i:=@i+1 as srno,a.* from(select * from (select cs.description,round(cs.qty,2)qty,format(cs.customeramt,2) customeramt,round(cs.customeramt,2) jcustomeramt,format(cs.customeramt/cs.qty,2) rate,round(cs.customeramt/cs.qty,2) jrate,main.part_no partno,main.productname partname"
				+" from ws_jccspare cs left join my_main main on cs.psrno=main.psrno where cs.estdocno="+estdocno+" and catid!=3 and main.part_no is not null"
				+" union all"
				+" select cs.description,round(sum(cs.qty),2) qty,format(sum(cs.customeramt),2) customeramt, round(sum(cs.customeramt),2) jcustomeramt,format(sum(cs.customeramt)/sum(cs.qty),2) rate,round(sum(cs.customeramt)/sum(cs.qty),2) jrate,main.part_no partno,'Consumable ' partname"
				+" from ws_jccspare cs left join my_main main on cs.psrno=main.psrno where cs.estdocno="+estdocno+" and catid=3 and main.part_no is not null "
				/*+" union all"
				+" select cs.description,sum(cs.qty) qty,format(sum(cs.customeramt),2) customeramt, round(sum(cs.customeramt),2) jcustomeramt,format(cs.customeramt/cs.qty,2) rate,round(cs.customeramt/cs.qty,2) jrate,main.part_no partno,'Consumable' partname"
				+" from ws_jccspare cs left join my_main main on "+defaultpsrno+"=main.psrno where cs.estdocno="+estdocno+" and catid=3 and coalesce(cs.psrno,0)=0 and cs.description in ('Consumable','Consumables') and cs.customeramt>0.0*/ 
				+" ) a ) a,(select @i:=0) r;";
				System.out.println("Spare Parts Invoice Query:"+sqljrxml3);
				//ResultSet temp=stmt.executeQuery(sqljrxml3);
			}
			else{
				sqljrxml3="select @i:=@i+1 as srno,a.* from (select * from (select cs.description,cs.qty,format(cs.customeramt,2) customeramt,round(cs.customeramt,2) jcustomeramt,format(cs.customeramt/cs.qty,2) rate,round(cs.customeramt/cs.qty,2) jrate,main.part_no partno,main.productname partname"
						+" from ws_jccspare cs left join my_main main on cs.psrno=main.psrno where cs.estdocno="+estdocno+" and catid!=3"
						+" union all"
						+" select cs.description,sum(cs.qty) qty,format(sum(cs.customeramt),2) customeramt, round(sum(cs.customeramt),2) jcustomeramt,format(cs.customeramt/cs.qty,2) rate,round(cs.customeramt/cs.qty,2) jrate,main.part_no partno,'Consumable ' partname"
						+" from ws_jccspare cs left join my_main main on cs.psrno=main.psrno where cs.estdocno="+estdocno+" and catid=3  ) a where a.partno is not null) a,(select @i:=0) r;";
				System.out.println("Spare Parts Invoice Query: Wsspareqry"+sqljrxml3);
			}
			
			bean.setWsspareqry(sqljrxml3);
			
			String spareqry="select @i:=@i+1 as srno,a. * from (select * from (select cs.description,round(cs.qty,2)qty,format(cs.customeramt,2) customeramt,"+
                            " round(cs.customeramt,2) jcustomeramt,format(cs.customeramt/cs.qty,2) rate,round(cs.customeramt/cs.qty,2) jrate,main.part_no partno,"+
                            " coalesce(main.productname,cs.description) partname from ws_jccspare cs left join my_main main on cs.psrno=main.psrno where cs.estdocno="+estdocno+" ) a ) a,(select @i:=0) r ";
			
			bean.setLblsparequery(spareqry);
			System.out.println("Spare Parts Invoice Query new:"+spareqry);
			ClsJobCardCompleteNewDAO jobcarddao=new ClsJobCardCompleteNewDAO();
			ArrayList<String> amountarray=new ArrayList<>();
			amountarray=getAmountPrint(conn,docno);
			request.setAttribute("INVPRINT", amountarray);
			ArrayList<String> labourarray=new ArrayList<>();
			labourarray=jobcarddao.getLabourPrint(conn,estdocno);
			request.setAttribute("LABOURPRINT", labourarray);
			ArrayList<String> partsarray=new ArrayList<>();
			partsarray=jobcarddao.getPartsPrint(conn,estdocno);
			request.setAttribute("PARTSPRINT", partsarray);
			double total=0.0,nettotal=0.0;
			
			for(int i=0;i<labourarray.size()-1;i++){
				total+=Double.parseDouble(labourarray.get(i).split("::")[3]);
			}
			for(int i=0;i<partsarray.size()-1;i++){
				System.out.println(partsarray.get(i));
				if(!partsarray.get(i).split("::")[4].equalsIgnoreCase("")|| partsarray.get(i).split("::")[4]!=null){
					total+=Double.parseDouble(partsarray.get(i).split("::")[4]);
				}
				
			}
			
			//bean.setLblproformatotal(jobcarddao.customRound(conn,total)+"");
			bean.setLblproformatotal(df.format(total));

//			System.out.println("Total:"+total);
			nettotal=total;
			String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttaxmethod";
//			System.out.println(strchecktax);
			ResultSet rschecktax=stmt.executeQuery(strchecktax);
			int taxstatus=0;
			int clienttaxmethod=0;
			while(rschecktax.next()){
				taxstatus=rschecktax.getInt("taxmethod");
				clienttaxmethod=rschecktax.getInt("clienttaxmethod");
			}
			double vatval=0.0;
			System.out.println(" tax value  == "+taxstatus+"===== "+clienttaxmethod);
			if(taxstatus==1 && clienttaxmethod==1){
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqljobdate+"' between tax.fromdate and tax.todate";
				System.out.println("===="+strgettax);
				double vatpercent=0.0;
				ResultSet rsgettax=stmt.executeQuery(strgettax);
				while(rsgettax.next()){
					vatpercent=rsgettax.getDouble("vat_per");
					vatval=total*(vatpercent/100);
					vatval=objcommon.Round(vatval, 2);
				}
			System.out.println("======"+vatpercent+"===="+vatval);
				nettotal+=vatval;
			}
			/*bean.setLblproformatax(jobcarddao.customRound(conn,vatval)+"");
			bean.setLblproformanetamount(jobcarddao.customRound(conn,nettotal)+"");
//			System.out.println("//////"+nettotal+"////"+vatval);
			bean.setLblproformaamountwords(objamount.convertAmountToWords(jobcarddao.customRound(conn,nettotal)+""));*/
			bean.setLblproformatax(jobcarddao.customRound(conn,vatval)+"");
			double roundedvalue=Math.round(nettotal);
			double roundoff=nettotal-roundedvalue;
			roundoff=objcommon.Round(roundoff, 2);
			System.out.println(roundedvalue+"//"+roundoff+"//"+nettotal);
			/*bean.setLblproformanetamount(jobcarddao.customRound(conn,roundedvalue)+"");
			bean.setLblproformaround(jobcarddao.customRound(conn,roundoff)+"");
			bean.setLblproformaamountwords(objamount.convertAmountToWords(roundedvalue+""));
			bean.setLblproformanetamount(jobcarddao.customRound(conn,roundedvalue)+"");*/
			
			bean.setLblproformanetamount(df.format(roundedvalue));
			bean.setLblproformaround(df.format(roundoff));
			bean.setLblproformaamountwords(objamount.convertAmountToWords(roundedvalue+""));
			bean.setLblproformanetamount(df.format(roundedvalue));
			
			System.out.println(roundedvalue+"//"+roundoff+"//"+nettotal);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return bean;
	}

	public ArrayList<String> getAmountPrint(Connection conn, int docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> data=new ArrayList<>();	
		try{
				Statement stmt=conn.createStatement();
				String strsql="select desc1,round(amount,2) amount from ws_invd where rdocno="+docno;
//				System.out.println(strsql);				
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				while(rs.next()){
					data.add(i+"::"+rs.getString("desc1")+"::"+rs.getString("amount"));
					i++;
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				
			}
			finally{
			}
		return data;

	}
	
	public String getRoundAmount(String docno) throws SQLException {
		// TODO Auto-generated method stub
		String roundamt="";
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select round(coalesce(roundamt,0),2) roundamt from ws_invm where doc_no="+docno;
//			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				roundamt=rs.getString("roundamt");
//				System.out.println("Asd"+roundamt);
			}
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return roundamt;
	}
	
	public int saperateInvInsert(Date sqldate, String cmbreftype,
			String hidrefno, String cldocno, String invoicetoacno,
			String excessamountacno, String total, String discount,
			String excessamount, String nettotal, String remarks,
			HttpSession session, HttpServletRequest request, String mode,
			String formdetailcode, String brchName,
			ArrayList<String> invoicearray, Connection conn, String taxpercent,
			String taxamount, String taxtotal,int masterinv,String billtoacno) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0,vocno=0,trno=0;
		try{
			excessamountacno=excessamountacno.trim().equalsIgnoreCase("")?"0":excessamountacno.trim();
			total=excessamount;
			nettotal=excessamount;
			double temptaxtotal=0.0;
			temptaxtotal=Double.parseDouble(nettotal);
			Statement stmt=conn.createStatement();
			int insurtodocno=0;
		/*	String strdecideinvoiceto="select if(gate.insurancecomp>0,gate.insurcldocno,gate.cldocno) invoicetodocno from ws_jobcard job "+
			" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) "+
			" where job.doc_no="+hidrefno;*/
			String strdecideinvoiceto="select gate.cldocno invoicetodocno from ws_jobcard job "+
					" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) "+
					" where job.doc_no="+hidrefno;
			ResultSet rsinvoicetodetails=stmt.executeQuery(strdecideinvoiceto);
			while(rsinvoicetodetails.next()){
				insurtodocno=rsinvoicetodetails.getInt("invoicetodocno");
			}
			insurtodocno=Integer.parseInt(cldocno);
			ArrayList<String> acnodetailarray=getWorkshopAccountDetails(conn,cmbreftype,hidrefno);
			//Excess Amt Corresponding to Client
			int compacno=0,clientacno=0,insuracno=0,curid=0;
			double currate=0.0,partydramt=0.0,compdramt=0.0,partyldramt=0.0,compldramt=0.0;
			String note="";
			compacno=Integer.parseInt(acnodetailarray.get(2));
			insuracno=Integer.parseInt(acnodetailarray.get(0));
			clientacno=Integer.parseInt(acnodetailarray.get(1));
			curid=Integer.parseInt(acnodetailarray.get(3));
			currate=Double.parseDouble(acnodetailarray.get(4));
			String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+insurtodocno+" and dtype='CRM') clienttaxmethod";
//			System.out.println(strchecktax);
			ResultSet rschecktax=stmt.executeQuery(strchecktax);
			int taxstatus=0;
			int clienttaxmethod=0;
			double vatval=0.0,setval=0.0;
			while(rschecktax.next()){
				taxstatus=rschecktax.getInt("taxmethod");
				clienttaxmethod=rschecktax.getInt("clienttaxmethod");
			}
//			System.out.println("seperate invoice 2 - client tax"+clienttaxmethod);
			if(taxstatus==1 && clienttaxmethod==1){
				double generalamttax=Double.parseDouble(nettotal);
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
				double setpercent=0.0;
				double vatpercent=0.0;
				ResultSet rsgettax=stmt.executeQuery(strgettax);
				
				while(rsgettax.next()){
					setpercent=rsgettax.getDouble("set_per");
					vatpercent=rsgettax.getDouble("vat_per");
					taxpercent=vatpercent+"";
					vatval=(generalamttax*(vatpercent/100));
					setval=generalamttax*(setpercent/100);
					setval=objcommon.Round(setval, 2);
					vatval=objcommon.Round(vatval, 2);
					taxamount=vatval+"";
					if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
						if(vatval>0.0){
							temptaxtotal+=vatval;
						}
					}
				}
			}
			CallableStatement stmtEst = conn.prepareCall("{call WSinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,cmbreftype);
			stmtEst.setString(3,hidrefno);
			stmtEst.setString(4, invoicetoacno);
			stmtEst.setString(5,excessamountacno);
			stmtEst.setString(6,remarks);
			stmtEst.setString(7,total);
			stmtEst.setString(8,discount);
			stmtEst.setString(9,excessamount);
			stmtEst.setString(10,nettotal);
			stmtEst.setString(11,formdetailcode);
			stmtEst.setString(12,session.getAttribute("USERID").toString());
			stmtEst.setString(13,brchName);
			stmtEst.setString(16,mode);
			stmtEst.setString(18,taxpercent);
			stmtEst.setString(19,taxamount);
			stmtEst.setString(20,temptaxtotal+"");
			stmtEst.setString(21,"0");
//			System.out.println(stmtEst);
			stmtEst.executeQuery();
			docno=stmtEst.getInt("docNo");
			vocno=stmtEst.getInt("voucher");
			trno=stmtEst.getInt("vtrNo");
			//request.setAttribute("WSINVVOCNO", vocno);
			int errorstatus=0;
			String strupdateacno="update ws_invm set invoicetoacno="+billtoacno+" where doc_no="+docno;
			int updateacno=stmt.executeUpdate(strupdateacno);
			if(updateacno<=0){
				errorstatus=0;
				return 0;
			}
			if(docno<=0){
				System.out.println("Excess Master Insert Error");
				errorstatus=1;
				return 0;
			}
			else{
				for(int i=0,j=1;i<invoicearray.size();i++,j++){
					String temp[]=invoicearray.get(i).split("::");
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					String str="insert into ws_invd(rdocno,srno,desc1,amount)values("+docno+","+j+",'"+temp[0]+"',"+temp[1]+")";
					int insertval=stmt.executeUpdate(str);
					if(insertval<=0){
//						System.out.println("Excess Detail Insert Error");
						errorstatus=1;
						return 0;
					}
				}
				
				double totalamt=0.0,discountamt=0.0,excessamt=0.0,netamt=0.0,remaintotal=0.0;
				
				if(excessamount!=null){
					excessamt=Double.parseDouble(excessamount);
				}
				
				netamt=excessamt;
				
				if(taxstatus==1 && clienttaxmethod==1){
					double generalamttax=netamt;
					String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
					double setpercent=0.0;
					double vatpercent=0.0;
					ResultSet rsgettax=stmt.executeQuery(strgettax);
					
					ArrayList<String> temptaxarray=new ArrayList<>();
					while(rsgettax.next()){
						setpercent=rsgettax.getDouble("set_per");
						vatpercent=rsgettax.getDouble("vat_per");
						vatval=(generalamttax*(vatpercent/100));
						setval=generalamttax*(setpercent/100);
						setval=objcommon.Round(setval, 2);
						vatval=objcommon.Round(vatval, 2);
						if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
							if(vatval>0.0){
								temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
								netamt+=vatval;
							}
						}
					}
					if(setpercent>0.0 || vatpercent>0.0){
						double generalldr=0.0;
						netamt=objcommon.Round(netamt, 2);
						generalldr=netamt*currate;
						int tempsrno=invoicearray.size()+1;
						note="VAT Entry of Workshop Invoice "+docno;
						note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
						for(int j=0;j<temptaxarray.size();j++){
							String[] tax=temptaxarray.get(j).split("::");
							if(Double.parseDouble(tax[2])>0){
								String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
								" '"+Double.parseDouble(tax[2])*-1+"','"+currate+"','"+curid+"',0,-1,'"+(tempsrno)+"',"+
								" '"+brchName+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*currate)*-1+"','"+docno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
								"'"+curid+"','5',1,'"+cldocno+"',3)";
//								System.out.println("Tax Jv1:"+strtaxjv);
								tempsrno++;
								Statement stmttaxjv=conn.createStatement();
								//System.out.println("Jvtran Sql:"+strtaxjv);
								int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
								if(taxjvval>0){
									
								}
								else{
									System.out.println("Excess Jvtran Tax Error");
									return 0;
								}
								/*
								String strtaxjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
										"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+(insuracno>0?insuracno:clientacno)+"',"+
										" '"+Double.parseDouble(tax[2])+"','"+currate+"','"+curid+"',0,-1,'"+(tempsrno)+"',"+
										" '"+branch+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*currate)*-1+"','"+docno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
										"'"+curid+"','5',1,'"+cldocno+"',3)";
								System.out.println("Tax Jv2:"+strtaxjv);
										tempsrno++;
										System.out.println("Jvtran Sql:"+strtaxjv);
										int taxjvval2=stmttaxjv.executeUpdate(strtaxjv2);
										if(taxjvval2>0){
											
										}
										else{
											System.out.println("Jvtran Tax Error");
											return 0;
										}*/
								stmttaxjv.close();
							}
						}
					}
				}
				//Jvtran Entries
				remaintotal=netamt-excessamt;
				int i=0;
				if(excessamt>0.0){
					partydramt=netamt;
					compdramt=excessamt*-1;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					note="Excess Amt JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+clientacno+"',"+
					" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+brchName+"','"+note+"',0,'"+sqldate+"',"+
					" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
//					System.out.println("Excess JV 1:"+strjvparty);
					int jvparty=stmt.executeUpdate(strjvparty);
					if(jvparty<=0){
						System.out.println("Jvtran Excess Error1");
						errorstatus=1;
					}
					i++;
					String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
					" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+compacno+"',"+
					" '"+compdramt+"','"+currate+"','"+curid+"',0,-1,1,'"+brchName+"','"+note+"',0,'"+sqldate+"','"+formdetailcode+"',"+
					" '"+compldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,"+cldocno+",3)";
//					System.out.println("Excess JV 2:"+strjvcomp);
					int jvcomp=stmt.executeUpdate(strjvcomp);
					if(jvcomp<=0){
						System.out.println("Jvtran Excess Error2");
						errorstatus=1;
					}
					i++;
				}
				String testjv1="select dramount from my_jvtran where tr_no="+trno;
				ResultSet rstestjv1=stmt.executeQuery(testjv1);
				while(rstestjv1.next()){
					System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
				}
				if (docno > 0) {
					String strupdateinv="update ws_invm set excessinvdocno="+docno+" where doc_no="+masterinv;
					int updateinv=stmt.executeUpdate(strupdateinv);
					if(updateinv<=0){
						System.out.println("Excess Update Inv Error");
						return 0;
					}
					String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+trno;
					ResultSet rstestjv=stmt.executeQuery(testjv);
					while(rstestjv.next()){
						if(rstestjv.getDouble("dramount")==0.00){
							if(errorstatus==0){
								return docno;
							}
							else{
								return 0;
							}
						}
						else{
							
							System.out.println("Jv tally Error");
							return 0;
						}
					}

				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			
		}
		return 0;
	}

	public ArrayList<String> getExcessInvDetails(Connection conn,
			String hidrefno, String excessamount) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> excessinvrray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			int gipno=0;
			String strgetgipno="select gate.voc_no from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+hidrefno;
			ResultSet rsgetgipno=stmt.executeQuery(strgetgipno);
			while(rsgetgipno.next()){
				gipno=rsgetgipno.getInt("voc_no");
			}
			excessinvrray.add("Excess Amount Invoice for Gate In Pass "+gipno+"::"+excessamount);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		return excessinvrray;
	}

	public int checkBillToInsurance(String hidrefno, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int billtoinsurance=0;
		try{
			Statement stmt=conn.createStatement();
			String strgetgipno="select gate.insurancecomp from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+hidrefno;
			ResultSet rsgetgipno=stmt.executeQuery(strgetgipno);
			while(rsgetgipno.next()){
				billtoinsurance=rsgetgipno.getInt("insurancecomp");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		return billtoinsurance;
	}
}
