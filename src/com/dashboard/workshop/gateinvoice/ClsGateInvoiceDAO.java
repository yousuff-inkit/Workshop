package com.dashboard.workshop.gateinvoice;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.connection.*;
import com.common.*;
public class ClsGateInvoiceDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getInvoiceData(String fromdate,String todate,String id,String client,String cmbbranch)throws SQLException
	{
		JSONArray gatedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return gatedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and m.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and m.date<='"+sqltodate+"'";
			}
			if(!client.equalsIgnoreCase("") && client!=null){
				sqltest+=" and m.cldocno="+client;
			}
			if(!cmbbranch.equalsIgnoreCase("") && cmbbranch.equalsIgnoreCase("a") && cmbbranch!=null){
				sqltest+=" and m.brhid="+cmbbranch;
			}
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) serviceduekm,ac.refname,m.invamount,m.processstatus,m.doc_no,m.date,m.brhid,br.branchname,veh.fleet_no,veh.reg_no,veh.flname,case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end driver,"+
			" m.indate,m.intime,m.inkm,CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN"+
			" 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN"+
			" m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END as infuel"+
			"  from gl_workgateinpassm m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.processstatus in (3) and m.invno=0 "+sqltest+" order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			gatedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return gatedata;
	}
	
	
	public int gateInvoiceInsert(String client ,String gatedocno,java.sql.Date sqlfromdate,java.sql.Date sqltodate,double amount,String cmbbranch,HttpSession session,HttpServletRequest request,Connection conn) throws SQLException{
	
		int invdocno=0,invtrno=0;
		System.out.println("DAO gatedocno"+gatedocno);
		try{
			Statement stmt=conn.createStatement();
			int clientacno=0,workshopacno=0,currencyid=0,workshopidno=0;
			String strclient="select (select inv.idno from my_account ac inner join gl_invmode inv on (ac.acno=inv.acno) where ac.codeno='WORKSHOP INCOME') workshopidno,(select head.curid from my_acbook ac inner join my_head head on (ac.dtype='CRM' and ac.acno=head.doc_no) where ac.cldocno="+client+" and status=3) currencyid,(select head.doc_no from my_account ac inner join my_head head on (ac.acno=head.doc_no) where ac.codeno='WORKSHOP INCOME') workshopacno,(select head.doc_no from my_acbook ac inner join my_head head on (ac.dtype='CRM' and ac.acno=head.doc_no) where ac.cldocno="+client+" and status=3) clientacno";
			ResultSet rsclient=stmt.executeQuery(strclient);
			while(rsclient.next()){
				clientacno=rsclient.getInt("clientacno");
				workshopacno=rsclient.getInt("workshopacno");
				currencyid=rsclient.getInt("currencyid");
				workshopidno=rsclient.getInt("workshopidno");
			}
			String userid=session.getAttribute("USERID").toString();
			String branchid=session.getAttribute("BRANCHID").toString();
			String note="Gate Invoice of Doc No "+gatedocno;
			CallableStatement stmtManual = conn.prepareCall("{call invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtManual.setDate(1,sqlfromdate);
			stmtManual.setString(2,"RAG");
			stmtManual.setString(3,client);
			stmtManual.setInt(4, 0);
			stmtManual.setString(5,note);
			stmtManual.setString(6,note);
			stmtManual.setString(7,currencyid+"");
			stmtManual.setString(8,clientacno+"");
			stmtManual.setDate(9,sqlfromdate);
			stmtManual.setDate(10,sqltodate);
			stmtManual.setString(11,"INW");
			stmtManual.setString(12,userid);
			stmtManual.setString(13,cmbbranch);
			stmtManual.setString(16,"A");
			stmtManual.executeQuery();
			invdocno=stmtManual.getInt("docNo");
			invtrno=stmtManual.getInt("vtrNo");
			
			ArrayList<String> invoicearray=new ArrayList<>();
			if(amount>0.0){
				invoicearray.add(workshopidno+"::"+workshopacno+"::"+note+"::1::"+amount+"::"+amount);
			}
			int gateqty=0;
			if(gatedocno.contains(",")){
				String gatedoc[]=gatedocno.split(",");
				for(int i=0;i<gatedoc.length;i++){
					gateqty++;
				}
			}
			else{
				gateqty++;
			}
			double currencyrate=0.0;
			ResultSet rscurr=stmt.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+currencyid+"'");
			if(rscurr.next()){
				//testcurid=rscurr.getInt("doc_no");
				currencyrate=rscurr.getDouble("c_rate");
			}
			else{
				System.out.println("Currency Error");
				return 0;
			}
			java.sql.Date duedate=null;
			String stracperiod="select DATE_ADD(if("+sqltodate+" is null,null,'"+sqltodate+"'), INTERVAL (select period2 from my_acbook where cldocno="+client+" and dtype='CRM') DAY) duedate";
			//System.out.println(stracperiod);
			ResultSet rsacperiod=stmt.executeQuery(stracperiod);
			while(rsacperiod.next()){
				duedate=rsacperiod.getDate("duedate");
			}
			String formdetailcode="INW";
			if(invdocno>0 && invoicearray.size()>0){
				for(int i=0;i<invoicearray.size();i++){
					
					String invoice[]=invoicearray.get(i).split("::");
					double invamount=Double.parseDouble(invoice[5]);
					String strinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values("+(i+1)+","+branchid+","+
					" "+invdocno+","+invtrno+",'"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+gateqty+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+")";
					System.out.println(strinvd);
					int invdval=stmt.executeUpdate(strinvd);
					if(invdval<=0){
						System.out.println("INVD Error");
						return 0;
					}
					double jvcompanydramt=invamount*-1;
					double jvcompanyldramt=jvcompanydramt*currencyrate;
					String strjvcompany="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+invtrno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
					"'"+jvcompanydramt+"','"+currencyrate+"','"+currencyid+"',0,-1,'"+(i+1)+"',"+
					"'"+branchid+"','"+note+"',0,'"+sqltodate+"','"+formdetailcode+"','"+jvcompanyldramt+"','"+invdocno+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
					"'"+currencyid+"','5',1,0,3,'"+0+"','"+""+"')";
					int jvcompany=stmt.executeUpdate(strjvcompany);
					if(jvcompany<=0){
						System.out.println("JV Entry Error");
						return 0;
					}
					String strupdateinv="update gl_workgateinpassm set invno="+invdocno+" where doc_no in ("+gatedocno+")";
					System.out.println(strupdateinv);
					int updateinv=stmt.executeUpdate(strupdateinv);
					if(updateinv<=0){
						return 0;
					}
					Statement stmtcostentry=conn.createStatement();
					String strcostentry="select costentry from gl_invmode where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1]);
					int costentry=0;
					ResultSet rscostentry=stmtcostentry.executeQuery(strcostentry);
					while(rscostentry.next()){
						costentry=rscostentry.getInt("costentry");
					}
					
					 if(costentry==1){
						 Statement stmtgettran=conn.createStatement();
						 String strgettran="select tranid from my_jvtran where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+" and tr_no="+invtrno;
						 //	System.out.println("GetTran Query:"+strgettran);
						 ResultSet rsgettran=stmtgettran.executeQuery(strgettran);
						 int temptranid=0;
						 while(rsgettran.next()){
							 temptranid=rsgettran.getInt("tranid");
						 }
						 int count=0;
						 ArrayList<String> costmovarray=new ArrayList<String>();
						 Statement stmtcostmov=conn.createStatement();
						 double temptimediff=0.0;
						 String tempcostfleet="";
						 String strcostmov="select invamount,fleet_no from gl_workgateinpassm where doc_no in ("+gatedocno+")";

						 ResultSet rscostmov=stmtcostmov.executeQuery(strcostmov);
						 int counter=0;
						 while(rscostmov.next()){
							 costmovarray.add(rscostmov.getString("invamount")+""+"::"+rscostmov.getString("fleet_no"));
							 counter++;
						 }
						 stmtcostmov.close();
						 Statement stmtcostinsert=conn.createStatement();
						 int srno=1;
						 for(int j=0;j<costmovarray.size();j++){
							 if(counter==1){
								 String costmov=costmovarray.get(j);
								 String costmovamt=costmov.split("::")[0];
								 String costmovfleet=costmov.split("::")[1];
								 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
										 ",6,"+jvcompanydramt+","+srno+","+temptranid+",0,"+costmovfleet+","+invtrno+")";
								 srno++;
								 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
								 if(costinsertval<0){
									 //conn.close();
									 System.out.println("Cost Insert Error");
									 return 0;
								 }

							 }
							 else if(counter>1){
								 String costmov=costmovarray.get(j);
								 String costmovamt=costmov.split("::")[0];
								 String costmovfleet=costmov.split("::")[1];
								 double amt=Double.parseDouble(costmovamt)*-1;
								 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
										 ",6,"+amt+","+srno+","+temptranid+",0,"+costmovfleet+","+invtrno+")";
								 srno++;
								 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
								 if(costinsertval<0){
									 //conn.close();
									 System.out.println("Cost Insert Error2");
									 return 0;
								 }

							 }
						 }
						 stmtcostinsert.close();

					 }
					 else{

					 }

				}
				
				double generalamt=amount;
				double generalldr=generalamt*currencyrate;
				int tempsrno=0;
				Statement stmtchecktax=conn.createStatement();
				String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+client+" and dtype='CRM') clienttaxmethod";
				System.out.println(strchecktax);
				ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				if(taxstatus==1 && clienttaxmethod==1){
						System.out.println("Inside TaxDetail");
					
					// Getting amount in which tax is applicable
					Statement stmtgettax=conn.createStatement();
					String strtaxapplied="select total from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+invdocno;
					ResultSet rsapplied=stmtgettax.executeQuery(strtaxapplied);
					double generalamttax=0.0;
					while(rsapplied.next()){
						generalamttax+=rsapplied.getDouble("total");
					}
					int igststatus=0;
					/*String strigst="select igststatus from gl_ragmt where doc_no="+agmtno;
					ResultSet rsigst=stmtchecktax.executeQuery(strigst);
					while(rsigst.next()){
						igststatus=rsigst.getInt("igststatus");
					}*/
					String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqltodate+"' between tax.fromdate and tax.todate";
					double setpercent=0.0;
					double vatpercent=0.0;
					ResultSet rsgettax=stmtgettax.executeQuery(strgettax);
					double vatval=0.0,setval=0.0;
					ArrayList<String> temptaxarray=new ArrayList<>();
					while(rsgettax.next()){
						setpercent=rsgettax.getDouble("set_per");
						vatpercent=rsgettax.getDouble("vat_per");
						vatval=(generalamttax*(vatpercent/100));
						setval=generalamttax*(setpercent/100);
						setval=objcommon.Round(setval, 2);
						vatval=objcommon.Round(vatval, 2);
						if(igststatus==1){
							if(rsgettax.getInt("idno")==21){
								if(setval>0.0){
									temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+setval+"::"+rsgettax.getString("description"));
									generalamt+=setval;
								}
							}
						}
						else{
							if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
								if(vatval>0.0){
									temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
									generalamt+=vatval;
								}
							}
						}
					}
					if(setpercent>0.0 || vatpercent>0.0){
						generalamt=objcommon.Round(generalamt, 2);
						generalamt=objcommon.Round(generalamt, 2);
						generalldr=generalamt*currencyrate;

						/*Statement stmtgetinvmode=conn.createStatement();
						String strgetinvmode="select (select acno from gl_invmode where idno=19) setacno,(select acno from gl_invmode where idno=20) vatacno";
						ResultSet rsinvmode=stmtgetinvmode.executeQuery(strgetinvmode);
						ArrayList<String> temptaxarray=new ArrayList<>();
						while(rsinvmode.next()){
							temptaxarray.add(19+"::"+rsinvmode.getString("setacno")+"::"+setval+"::"+"SET");
							temptaxarray.add(20+"::"+rsinvmode.getString("vatacno")+"::"+vatval+"::"+"VAT");
						}*/
						tempsrno=invoicearray.size()+1;
						for(int j=0;j<temptaxarray.size();j++){
							String[] tax=temptaxarray.get(j).split("::");
							Statement stmttaxinvd=conn.createStatement();
							if(Double.parseDouble(tax[2])>0){
								String strtaxinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+branchid+"','"+invdocno+"'"+
										",'"+invtrno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
											System.out.println("Invd Sql:"+strtaxinvd);
								int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
								if(taxinvdval>0){
									String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
											"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+invtrno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
											"'"+Double.parseDouble(tax[2])*-1+"','"+currencyrate+"','"+currencyid+"',0,-1,'"+(tempsrno)+"',"+
											"'"+branchid+"','"+note+"',"+
											"0,'"+sqltodate+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*currencyrate)*-1+"','"+invdocno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
											"'"+currencyid+"','5',1,'"+client+"',3,'"+0+"','"+""+"')";
									tempsrno++;
									Statement stmttaxjv=conn.createStatement();
									System.out.println("Jvtran Sql:"+strtaxjv);
									int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
									if(taxjvval>0){

									}
									else{
										System.out.println("Jvtran Tax Error");
										return 0;
									}
									stmttaxjv.close();
									stmttaxinvd.close();
								}
								else{
									System.out.println("Tax Invd Error");
									return 0;
								}
							}
						}
						stmtchecktax.close();
						//stmtgetinvmode.close();
						stmtgettax.close();
					}

				}


			//}//Closing for origin (Tax)
			//If Tax Method is Disabled in gl_config
			if(generalamt>0){

				double ramt=Math.round(generalamt);
				double ramtldr=ramt*currencyrate;
				double discount = (generalamt-ramt);
				discount=objcommon.Round(discount, 2);
				/*discount=Math.round(discount*-1);*/
				//System.out.println("Check:"+Math.scalb(discount, 2));
				double discountldr=discount*currencyrate;
				// System.out.println("R Amt:"+ramt+"::::::::::Discount:"+discount+"General Amt:"+generalamt);
				// discount a/c jvtran  discount*-1   
				Statement stmtdiscount=conn.createStatement();
				String strdiscount="select acno discountacno from gl_invmode where idno=13";
				ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
				int  discac=0;
				while(rsdiscount.next()){
					discac=rsdiscount.getInt("discountacno");
				}
				int tempno=tempsrno;
				if(discount!=0.0){
					Statement stmtdiscjv=conn.createStatement();
					Statement stmtdiscinvd=conn.createStatement();
					String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+branchid+"','"+invdocno+"'"+
							",'"+invtrno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
					int discinvd=stmtdiscinvd.executeUpdate(sql);
					if(discinvd<=0){
						stmtdiscinvd.close();
						stmtdiscjv.close();
						stmtdiscount.close();
						conn.close();
						return 0;
					}
					stmtdiscinvd.close();
								System.out.println(" Invd Sql"+sql);
					int discid=0;
					if(discount>0.0){
						discid=1;
					}
					else if(discount<0.0){
						discid=-1;
					}
					
					String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+invtrno+"','"+discac+"',"+
							"'"+discount+"','"+currencyrate+"','"+currencyid+"',0,"+discid+",1,"+
							"'"+branchid+"','Discount',"+
							"0,'"+sqltodate+"','"+formdetailcode+"','"+discountldr+"','"+invdocno+"','"+gateqty+"',"+
							"'"+currencyid+"','5',1,"+client+",3,'"+0+"','"+""+"','"+duedate+"')";
					int discval=stmtdiscjv.executeUpdate(sqljvdisc);
					if(discval<=0){
						stmtdiscjv.close();
						stmtdiscount.close();
						conn.close();
						return 0;

					}
					stmtdiscjv.close();
					stmtdiscount.close();
				}

				String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+invtrno+"','"+clientacno+"',"+
						"'"+ramt+"','"+currencyrate+"','"+currencyid+"',0,1,1,"+
						"'"+branchid+"','"+note+"',"+
						"0,'"+sqltodate+"','"+formdetailcode+"','"+ramtldr+"','"+invdocno+"','"+gateqty+"',"+
						"'"+currencyid+"','5',1,"+client+",3,'"+0+"','"+""+"','"+duedate+"')";
						System.out.println("General Jv sql:"+sqljv);
				int rsjv=stmt.executeUpdate(sqljv);
				if(rsjv>0){
							System.out.println("Inside general jv");	
				}
				else{
					System.out.println("General jvtran error");
					//conn.close();
					return 0;
				}
				stmtdiscount.close();
			}	
//			System.out.println("no====="+aaa);
			//invoicebean.setDocno(aaa);
			String testjv1="select dramount from my_jvtran where tr_no="+invtrno;
			ResultSet rstestjv1=stmt.executeQuery(testjv1);
//						 System.out.println("Test Sum Jvtran"+testjv1);
				while(rstestjv1.next()){
//				System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
				}
			if (invdocno > 0) {
					
				//			System.out.println("InvNo > 0");

				String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+invtrno;
				ResultSet rstestjv=stmt.executeQuery(testjv);
				//			System.out.println("Test Sum Jvtran"+testjv);
				while(rstestjv.next()){
					//	System.out.println("jv vvalue"+rstestjv.getDouble("dramount"));
					if(rstestjv.getDouble("dramount")==0.00){
						//	System.out.println("testjv"+rstestjv.getDouble("dramount"));
						//	System.out.println("Success"+invoicebean.getDocno());

						//stmtinvoice.close();
						//stmtManual.close();
						//	conn.close();
						return invdocno;
					}
					else{
/*						stmtinvoice.close();
						stmtManual.close();*/
						//conn.close();
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
			//conn.close();
		}
		return invdocno;
	}


	public String getVoucherNo(int val, Connection conn)throws SQLException {
		String vocno="";
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			String strinv="select voc_no from gl_invm where doc_no="+val;
			System.out.println("Voucher Query");
			ResultSet rs=stmt.executeQuery(strinv);
			while(rs.next()){
				vocno=rs.getString("voc_no");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return vocno;
	}
}
