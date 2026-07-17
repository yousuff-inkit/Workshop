package com.limousine.limoinvoice;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class ClsLimoInvoiceDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public JSONArray getClientSearchData(String docno,String name,String mobile,String mail,String date,String id)throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqldate!=null){
				sqltest+=" and ac.date='"+sqldate+"'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+docno+"%'";
			}
			if(!name.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+name+"%'";
			}
			if(!mobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+mobile+"%'";
			}
			if(!mail.equalsIgnoreCase("")){
				sqltest+=" and ac.mail1 like '%"+mail+"%'";
			}
			String strsql="select ac.cldocno,ac.refname,ac.address,ac.per_mob mobile,ac.mail1 mail,ac.date from my_acbook ac where status=3 and dtype='CRM'"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
	
	
	public JSONArray getGuestSearchData() throws SQLException{
		JSONArray guestdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select doc_no,guest,guestcontactno from gl_limoguest where status=3";
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			guestdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return guestdata;
		
	}
	
	public JSONArray getLocationSearchData() throws SQLException{
		JSONArray guestdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select  doc_no,location from gl_cordinates where status=3";
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			guestdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return guestdata;
		
	}
	
	public JSONArray getFleetSearchData(String fleetno,String fleetname,String regno,String brand,String model,String group,String id) throws SQLException{
		JSONArray fleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return fleetdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!fleetname.equalsIgnoreCase("")){
				sqltest+=" and veh.flname like '%"+fleetname+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(!brand.equalsIgnoreCase("")){
				sqltest+=" and veh.brdid="+brand;
			}
			if(!model.equalsIgnoreCase("")){
				sqltest+=" and veh.vmodid="+model;
			}
			if(!group.equalsIgnoreCase("")){
				sqltest+=" and veh.vgrpid="+group;
			}
			String strsql="select veh.fleet_no,veh.flname,veh.reg_no,brd.brand_name brand,model.vtype model,grp.gname from gl_vehmaster veh left join gl_vehbrand brd "+
			" on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no where veh.statu=3 "+
			" and veh.limostatus=1"+sqltest;
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			fleetdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return fleetdata;
		
	}
	
	
	public JSONArray getTypeSearchData() throws SQLException{
		JSONArray typedata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,details from gl_limoservices where status=1 order by srno";
			ResultSet rs=stmt.executeQuery(strsql);
			typedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return typedata;
	}


	public JSONArray getInvoiceGridData(String docno,String id)throws SQLException{
		JSONArray invoicedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return invoicedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			if(!docno.equalsIgnoreCase("")){
			String strsql="select invd.guestno,guest.guest,invd.jobtype,invd.jobdocno,invd.bookdocno,invd.jobname jobnametemp,invd.total,invd.tarif,invd.nighttarif,"+
			" invd.exkmchg excesskmchg,invd.exhrchg excesshrchg,invd.exnighthrchg excessnighthrchg,invd.fuelchg,invd.parkingchg,invd.otherchg,invd.greetchg,invd.vipchg,"+
			" invd.boquechg from gl_limoinvm inv left join gl_limoinvd invd on inv.doc_no=invd.rdocno left join gl_limoguest guest on invd.guestno=guest.doc_no where "+
			" invd.rdocno="+docno+" and inv.status=3";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			invoicedata=objcommon.convertToJSON(rs);
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicedata;
	}
	
	
	public JSONArray getSearchData(String docno,String client,String clientmob,String date,String chkallbranch,String id,String branch) throws SQLException{
		JSONArray searchdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return searchdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and inv.doc_no like '%"+docno+"%'";
			}
			if(!client.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+client+"%'";
			}
			if(!clientmob.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+clientmob+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqldate!=null){
				sqltest+=" and inv.date='"+sqldate+"'";
			}
			
			if(!chkallbranch.equalsIgnoreCase("1")){
				sqltest+=" and inv.brhid="+branch;
			}
			String strsql="select inv.doc_no,inv.voc_no,inv.date,inv.cldocno,ac.refname,ac.per_mob,ac.mail1,ac.address,inv.fromdate,inv.todate,inv.ledgernote,"+
			" inv.invoicenote,inv.fromdate,inv.todate from gl_limoinvm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" where inv.status=3"+sqltest;
		
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return searchdata;
	}

	public JSONArray getJobSearchData(String client,String guest,String jobtype,String id) throws SQLException{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!client.equalsIgnoreCase("")){
				sqltest+=" and m.cldocno="+client;
			}
			if(!guest.equalsIgnoreCase("")){
				sqltest+=" and m.guestno="+guest;
			}
			
			String strsql="";
			if(jobtype.equalsIgnoreCase("Transfer")){
				strsql="select tran.doc_no jobdocno,tran.bookdocno,'Transfer' jobtype,convert(concat(tran.bookdocno,' - ',tran.docname),char(25)) jobname from gl_limobookm m "+
			" inner join gl_limobooktransfer tran on m.doc_no=tran.bookdocno where tran.masterstatus<>4 and m.status=3 "+sqltest;
			}
			else if(jobtype.equalsIgnoreCase("Limo")){
				strsql="select hours.doc_no jobdocno,hours.bookdocno,'Limo' jobtype,convert(concat(hours.bookdocno,' - ',hours.docname),char(25)) jobname from gl_limobookm m inner join "+
			" gl_limobookhours hours on m.doc_no=hours.bookdocno where hours.masterstatus<>4 and m.status=3 "+sqltest;
			}

			ResultSet rsjob=stmt.executeQuery(strsql);
			jobdata=objcommon.convertToJSON(rsjob);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}
	public int insert(Date sqldate, Date sqlfromdate, Date sqltodate,
			String hidclient, String ledgernote, String invoicenote,
			ArrayList<String> invoicearray, String mode, String formdetailcode,
			HttpServletRequest request, String brchName, HttpSession session,String manual,double mastertotal,String lpono,String eventno) throws SQLException {
		// TODO Auto-generated method stub
	
		Connection conn=null;
		int docno=0,vocno=0,trno=0;
		try{
			System.out.println(sqldate+"::"+sqlfromdate+"::"+hidclient+"::"+ledgernote+"::"+invoicenote+"::"+brchName+"::"+manual+"::"+mastertotal);
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmttax=conn.createStatement();
			int setacno=0,vatacno=0,taxmethod=0,clienttaxmethod=0,clientacno=0,rentalacno=0,clientcurid=0;
			double clientcurrate=0.0;
			
			String strtaxacno="select (select acno from gl_invmode where idno=19) setacno,(select acno from gl_invmode where idno=20) vatacno,"+
			" (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+hidclient+" and dtype='CRM') clienttaxmethod,"+
			" (select head.doc_no from my_acbook ac inner join my_head head on (ac.acno=head.doc_no) where ac.cldocno="+hidclient+" and ac.dtype='CRM') clientacno,"+
			" (select head.curid from my_acbook ac inner join my_head head on (ac.acno=head.doc_no) where ac.cldocno="+hidclient+" and ac.dtype='CRM') clientcurid,"+
			" (select head.rate from my_acbook ac inner join my_head head on (ac.acno=head.doc_no) where ac.cldocno="+hidclient+" and ac.dtype='CRM') clientcurrate,"+
			" (select acno from gl_invmode where idno=1 and limo=1) rentalacno";
			ResultSet rstaxacno=stmttax.executeQuery(strtaxacno);
			while(rstaxacno.next()){
				setacno=rstaxacno.getInt("setacno");
				vatacno=rstaxacno.getInt("vatacno");
				taxmethod=rstaxacno.getInt("taxmethod");
				clienttaxmethod=rstaxacno.getInt("clienttaxmethod");
				clientacno=rstaxacno.getInt("clientacno");
				rentalacno=rstaxacno.getInt("rentalacno");
				clientcurid=rstaxacno.getInt("clientcurid");
				clientcurrate=rstaxacno.getDouble("clientcurrate");
			}
			CallableStatement stmtInvoice = conn.prepareCall("{call limoInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtInvoice.setDate(1,sqldate);
			stmtInvoice.setDate(2,sqlfromdate);
			stmtInvoice.setDate(3,sqltodate);
			stmtInvoice.setString(4, hidclient);
			stmtInvoice.setString(5,ledgernote);
			stmtInvoice.setString(6,invoicenote);
			stmtInvoice.setString(7,"0");//Acno
			stmtInvoice.setString(8,formdetailcode);
			stmtInvoice.setString(9,session.getAttribute("USERID").toString());
			stmtInvoice.setString(10,brchName);
			stmtInvoice.setString(11,session.getAttribute("CURRENCYID").toString());
			stmtInvoice.setString(12,session.getAttribute("COMPANYID").toString());
			stmtInvoice.setString(13,manual);
			stmtInvoice.setDouble(14,mastertotal);
			stmtInvoice.setString(15, mode);
			stmtInvoice.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtInvoice.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtInvoice.registerOutParameter(18, java.sql.Types.INTEGER);
			stmtInvoice.executeQuery();
			docno=stmtInvoice.getInt("docNo");
			vocno=stmtInvoice.getInt("voucher");
			trno=stmtInvoice.getInt("vtrNo");
			if(docno>0){
				Statement stmt=conn.createStatement();
				String strlpono="update gl_limoinvm set limolpono='"+lpono+"',limoevent='"+eventno+"' where doc_no="+docno;
				int updatelpo=stmt.executeUpdate(strlpono);
				if(updatelpo<0){
					return 0;
				}
				for(int i=0;i<invoicearray.size();i++){
					String[] temp=invoicearray.get(i).split("::");
					/*
					
					if(!temp[10].equalsIgnoreCase("") && temp[10]!=null && !temp[10].isEmpty() && !temp[10].equalsIgnoreCase("undefined")){
						
						String strsql="insert into gl_limoinvd(rdocno,guestno,fleetno,typeno,blockhrs,pickupdate,pickuptime,pickuploc,dropoffloc,"+
						" amount,discount,total,status)values("+docno+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+",'"+pickupdate+"','"+temp[5]+"',"+temp[6]+","+
						temp[7]+","+temp[8]+","+temp[9]+","+temp[10]+",3)";
						System.out.println(strsql);
						int value=stmt.executeUpdate(strsql);
						if(value<=0){
							request.setAttribute("VOUCHER",0);
							request.setAttribute("LIMOTRNO", 0);
							return 0;
						}
					}*/
					
					
					CallableStatement stmtinvd = conn.prepareCall("{call limoInvoiceDetailDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					System.out.println("//"+temp[2]+"//");
					stmtinvd.setInt(1,docno);
					stmtinvd.setString(2,temp[0].equalsIgnoreCase("undefined") || temp[0].equalsIgnoreCase("")?"0":temp[0]);
					stmtinvd.setString(3,temp[1].equalsIgnoreCase("undefined") || temp[1].equalsIgnoreCase("")?"0":temp[1]);
					stmtinvd.setString(4, temp[2].equalsIgnoreCase("undefined") || temp[2].equalsIgnoreCase("")?"0":temp[2]);
					stmtinvd.setString(5,temp[3].equalsIgnoreCase("undefined") || temp[3].equalsIgnoreCase("")?"0":temp[3]);
					stmtinvd.setString(6,temp[4].equalsIgnoreCase("undefined") || temp[4].equalsIgnoreCase("")?"0":temp[4]);
					stmtinvd.setString(7,temp[5].equalsIgnoreCase("undefined") || temp[5].equalsIgnoreCase("")?"0":temp[5]);
					stmtinvd.setString(8,temp[6].equalsIgnoreCase("undefined") || temp[6].equalsIgnoreCase("")?"0":temp[6]);
					stmtinvd.setString(9,temp[7].equalsIgnoreCase("undefined") || temp[7].equalsIgnoreCase("")?"0":temp[7]);
					stmtinvd.setString(10,temp[8].equalsIgnoreCase("undefined") || temp[8].equalsIgnoreCase("")?"0":temp[8]);
					stmtinvd.setString(11,temp[9].equalsIgnoreCase("undefined") || temp[9].equalsIgnoreCase("")?"0":temp[9]);
					stmtinvd.setString(12,temp[10].equalsIgnoreCase("undefined") || temp[10].equalsIgnoreCase("")?"0":temp[10]);
					stmtinvd.setString(13,temp[11].equalsIgnoreCase("undefined") || temp[11].equalsIgnoreCase("")?"0":temp[11]);
					stmtinvd.setString(14,temp[12].equalsIgnoreCase("undefined") || temp[12].equalsIgnoreCase("")?"0":temp[12]);
					stmtinvd.setString(15, temp[13].equalsIgnoreCase("undefined") || temp[13].equalsIgnoreCase("")?"0":temp[13]);
					stmtinvd.setString(16, temp[14].equalsIgnoreCase("undefined") || temp[14].equalsIgnoreCase("")?"0":temp[14]);
					stmtinvd.setString(17, temp[15].equalsIgnoreCase("undefined") || temp[15].equalsIgnoreCase("")?"0":temp[15]);
					stmtinvd.setString(18, temp[16].equalsIgnoreCase("undefined") || temp[16].equalsIgnoreCase("")?"0":temp[16]);
					stmtinvd.setString(19, temp[17].equalsIgnoreCase("") || temp[17].equalsIgnoreCase("undefined")?"0":temp[17]);
					stmtinvd.setString(20, temp[18].equalsIgnoreCase("") || temp[18].equalsIgnoreCase("undefined")?"0":temp[18]);
					stmtinvd.setString(21, temp[19].equalsIgnoreCase("") || temp[19].equalsIgnoreCase("undefined")?"0":temp[19]);
					stmtinvd.setString(22, temp[20].equalsIgnoreCase("") || temp[20].equalsIgnoreCase("undefined")?"0":temp[20]);
					stmtinvd.setString(23, formdetailcode);
					stmtinvd.setString(24, manual);
					stmtinvd.setString(25, mode);
					stmtinvd.setString(26, session.getAttribute("CURRENCYID").toString());
					stmtinvd.setString(27, brchName);
					stmtinvd.setString(28, hidclient);
					int val=stmtinvd.executeUpdate();
					if(val<0){
						request.setAttribute("VOUCHER",0);
						request.setAttribute("LIMOTRNO", 0);
						return 0;
					}
					//Tax Portion Starts Here
					
					//Getting sum of tax applied amounts
					double generaltaxamt=0.0;
					double setpercent=0.0;
					double vatpercent=0.0;
					double setval=0.0,vatval=0.0;
					String stramtsum="select sum(total) sumtotal from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+docno;
					System.out.println(stramtsum);
					ResultSet rsamtsum=stmttax.executeQuery(stramtsum);
					while(rsamtsum.next()){
						generaltaxamt=rsamtsum.getDouble("sumtotal");
					}
					double generalamt=0.0;
					String stramtsum1="select sum(total) sumtotal from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where inv.rdocno="+docno;
					System.out.println(stramtsum1);
					ResultSet rsamtsum1=stmttax.executeQuery(stramtsum1);
					while(rsamtsum1.next()){
						generalamt=rsamtsum1.getDouble("sumtotal");
					}
					String strgettax="select set_per,vat_per from gl_taxdetail where status<>7 and '"+sqldate+"' between fromdate and todate";
					System.out.println(strgettax);
					ResultSet rsgettax=stmttax.executeQuery(strgettax);
					while(rsgettax.next()){
						setpercent=rsgettax.getDouble("set_per");
						vatpercent=rsgettax.getDouble("vat_per");
						vatval+=(generaltaxamt*(vatpercent/100));
						setval+=(generaltaxamt*(setpercent/100));
					}
					vatval=objcommon.Round(vatval, 2);
					setval=objcommon.Round(setval, 2);
					String strlpo="";
					if(!lpono.equalsIgnoreCase("")){
						strlpo=" with LPO "+lpono;
					}
					if(!eventno.equalsIgnoreCase("")){
						strlpo+=" for event "+eventno;
					}
					String note="Limousine Invoice of "+temp[4]+strlpo;
					String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values("+trno+","+clientacno+","+generalamt*-1+","+clientcurrate+","+clientcurid+",0,-1,"+i+++","+
					" "+brchName+",'"+note+"',0,CURDATE(),'"+formdetailcode+"',("+generalamt+"*-1)*"+clientcurrate+","+docno+",'"+note+"',"+clientcurid+",'5',1,"+hidclient+",3)";
					System.out.println(strjvparty);
					int jvparty=stmttax.executeUpdate(strjvparty);
					if(jvparty<=0){
						request.setAttribute("VOUCHER",0);
						request.setAttribute("LIMOTRNO", 0);
						return 0;
					}
					if(taxmethod==1 && clienttaxmethod==1){
						generalamt=generalamt+setval+vatval;
						String strupdate="update gl_limoinvd set setpercent="+setpercent+",vatpercent="+vatpercent+",setvalue="+setval+",vatvalue="+vatval+" where rdocno="+docno+" and jobdocno="+temp[2]+" and bookdocno="+temp[3];
						int update=stmttax.executeUpdate(strupdate);
						if(update<=0){
							request.setAttribute("VOUCHER",0);
							request.setAttribute("LIMOTRNO", 0);
							return 0;
						}						
					}
					String strjvcomp="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values("+trno+","+rentalacno+","+generalamt+","+clientcurrate+","+clientcurid+",0,1,"+i+++","+brchName+",'"+note+"',0,"+
					" CURDATE(),'"+formdetailcode+"',"+generalamt*clientcurrate+","+docno+",'"+note+"',"+clientcurid+",'5',1,0,3)";
					System.out.println(strjvcomp);
					int jvcomp=stmttax.executeUpdate(strjvcomp);
					if(jvcomp<=0){
						request.setAttribute("VOUCHER",0);
						request.setAttribute("LIMOTRNO", 0);
						return 0;
					}
					
					if(taxmethod==1 && clienttaxmethod==1){
						if(setval>0){
							String strjvset="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values("+trno+","+setacno+","+setval*-1+","+clientcurrate+","+clientcurid+",0,-1,"+i+++","+
						" "+brchName+",'"+note+"',0,CURDATE(),'"+formdetailcode+"',("+setval+"*-1)*"+clientcurrate+","+docno+",'"+note+"',"+clientcurid+",'5',1,"+hidclient+",3)";
							System.out.println(strjvset);
							int jvset=stmttax.executeUpdate(strjvset);
							if(jvset<=0){
								request.setAttribute("VOUCHER",0);
								request.setAttribute("LIMOTRNO", 0);
								return 0;
							}
						}
						if(vatval>0){
							String strjvvat="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values("+trno+","+vatacno+","+vatval*-1+","+clientcurrate+","+clientcurid+",0,-1,"+i+++","+
						" "+brchName+",'"+note+"',0,CURDATE(),'"+formdetailcode+"',("+vatval+"*-1)*"+clientcurrate+","+docno+",'"+note+"',"+clientcurid+",'5',1,"+hidclient+",3)";
							System.out.println(strjvvat);
							int jvvat=stmttax.executeUpdate(strjvvat);
							if(jvvat<=0){
								request.setAttribute("VOUCHER",0);
								request.setAttribute("LIMOTRNO", 0);
								return 0;
							}
						}
					}

				}
				conn.commit();
				request.setAttribute("VOUCHER",vocno);
				request.setAttribute("LIMOTRNO", trno);
				return docno;
			}
			else{
				request.setAttribute("VOUCHER",0);
				request.setAttribute("LIMOTRNO", 0);
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	
	
	public String getClientName(String cldocno) throws SQLException {
		Connection conn=null;
		String clientname="";
		try{
			conn=objconn.getMyConnection();
		if(!cldocno.equalsIgnoreCase("")){
			Statement stmt=conn.createStatement();
			String strname="select refname from my_acbook where status=3 and dtype='CRM' and cldocno="+cldocno;
			ResultSet rs=stmt.executeQuery(strname);
			while(rs.next()){
				clientname=rs.getString("refname");
			}
			stmt.close();
		}
		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientname;
	}
   
   
   	public ClsLimoInvoiceBean getPrint(int docno, HttpServletRequest request) {
		// TODO Auto-generated method stub
		ClsLimoInvoiceBean bean=new ClsLimoInvoiceBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(inv.limolpono,'') lpono,coalesce(inv.limoevent,'') eventno,cur.code currencycode,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,u.user_name,coalesce(ac.address,'') address,coalesce(ac.per_mob,'') "+
			" mobileno,coalesce(ac.mail1) mail,concat('Address :',coalesce(ac.address,''),', Mobile :',coalesce(ac.per_mob,''),', Mail :',"+
			" coalesce(ac.mail1)) clientdetails,comp.company,comp.address ,comp.tel,comp.fax,br.branchname,inv.voc_no vocno,inv.cldocno ,"+
			" date_format(inv.date,'%d-%m-%Y') date,date_format(inv.fromdate,'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,"+
			" ac.refname from gl_limoinvm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
			" inv.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join my_curr cur on inv.curid=cur.doc_no left join my_user u on u.doc_no=inv.userid where inv.doc_no="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				bean.setLbldetails(rs.getString("clientdetails"));
				bean.setLblcldocno(rs.getString("cldocno"));
				bean.setLblclient(rs.getString("refname"));
				bean.setLbldate(rs.getString("date"));
				bean.setLblfromdate(rs.getString("fromdate"));
				bean.setLbltodate(rs.getString("todate"));
				bean.setLblvocno(rs.getString("vocno"));
				bean.setLblcompname(rs.getString("company"));
				bean.setLblcompaddress(rs.getString("address"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblbranch(rs.getString("branchname"));
				bean.setLblfinaldate(rs.getString("finaldate"));
				bean.setLblcheckedby(rs.getString("user_name"));
				bean.setLbladdress(rs.getString("address"));
				bean.setLblmobileno(rs.getString("mobileno"));
				bean.setLblmail(rs.getString("mail"));
				bean.setLblcurrencycode(rs.getString("currencycode"));
				bean.setLbllpo(rs.getString("lpono"));
				bean.setLblevent(rs.getString("eventno"));
			}
			
			ArrayList<String> printarray=new ArrayList<>();
			printarray=getPrintDetailArray(docno,conn);
			request.setAttribute("INVDETAIL", printarray);
			
			double totalamt=0.0;
			for(int i=0;i<printarray.size();i++){
				totalamt+=(Double.parseDouble(printarray.get(i).split("::")[8]));
			}
			ClsAmountToWords objamount=new ClsAmountToWords();
			bean.setLbltotal(totalamt+"");
			bean.setLblnetamount(totalamt+"");
			bean.setLblamountwords(objamount.convertAmountToWords(totalamt+""));
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return bean;
	}



	private ArrayList<String> getPrintDetailArray(int docno, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> printarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select inv.jobname,date_format(if(inv.jobtype='Transfer',tran.pickupdate,hours.pickupdate),'%d-%m-%Y') pickupdate,if(inv.jobtype='Transfer',tran.pickuptime,"+
			" hours.pickuptime) pickuptime,concat(brd.brand_name,' ',model.vtype) vehicle,pickup.location pickuplocation,coalesce(dropoff.location,'') dropofflocation,"+
			" inv.jobtype,round(inv.total,2) total from gl_limoinvd inv left join gl_limobooktransfer tran on (inv.jobtype='Transfer' and inv.jobdocno=tran.doc_no and"+
			" inv.bookdocno=tran.bookdocno) left join gl_limobookhours hours on (inv.jobtype='Transfer' and inv.jobdocno=hours.doc_no and inv.bookdocno=hours.bookdocno) "+
			" left join gl_cordinates pickup on(if(inv.jobtype='Transfer',tran.pickuplocid=pickup.doc_no,hours.pickuplocid)) left join gl_cordinates dropoff on "+
			" (if(inv.jobtype='Transfer',tran.dropfflocid=dropoff.doc_no,0=dropoff.doc_no)) left join gl_vehbrand brd on (if(inv.jobtype='Transfer',"+
			" tran.brandid=brd.doc_no,hours.brandid=brd.doc_no)) left join gl_vehmodel model on (if(inv.jobtype='Transfer',tran.modelid=model.doc_no,"+
			" hours.modelid=model.doc_no)) where inv.rdocno="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			int i=1;
			while(rs.next()){
				String temp=i+" :: "+rs.getString("jobname")+" :: "+rs.getString("pickupdate")+" :: "+rs.getString("pickuptime")+" :: "+rs.getString("vehicle")+" :: "+rs.getString("pickuplocation")+" :: "+rs.getString("dropofflocation")+" :: "+rs.getString("jobtype")+" :: "+rs.getString("total");
				printarray.add(temp);
				i++;
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return printarray;
	}
}
