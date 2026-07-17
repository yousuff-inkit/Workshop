package com.dashboard.workshop.invoiceprocessingpal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.workshop.wsinvoicepal.ClsWSInvoiceDAO;

import net.sf.json.JSONArray;

public class ClsInvProcessingDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsWSInvoiceDAO invoicedao=new ClsWSInvoiceDAO();
	
	public JSONArray getInsurTypeData(String id,String cldocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			// select -1 docno,'Private' typename, -1 union all select -2 docno,'Mechanical' typename, -2 union all 
			System.out.println("select insur.rowno docno,insur.typename,insur.srno from my_acinsurtype insur where status=3 and rdocno IN (0,"+(cldocno.equalsIgnoreCase("")?0:cldocno)+")");
			ResultSet rs=conn.createStatement().executeQuery("select insur.rowno docno,insur.typename,insur.srno from my_acinsurtype insur where status=3 and rdocno IN (0,"+(cldocno.equalsIgnoreCase("")?0:cldocno)+")");
			
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getJobcardWithoutInvoiceData(String fromdate,String todate,String id,String branch,String jobcard) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				
			}
			if(sqlfromdate!=null){
				sqltest+=" and jc.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and jc.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jc.brhid="+branch;
			}
			if(!jobcard.equalsIgnoreCase("")){
				sqltest+=" and jc.doc_no="+jobcard;
			}
			
			
			String strsql="select coalesce(insur.refname,'') insurcompname,gp.insurcldocno,gp.insurancecomp insurcomp,es.doc_no estdocno,es.voc_no estvocno,jc.doc_no doc_no,jc.voc_no voc_no, jc.date date, jc.reftype reftype, convert(case when jc.reftype='EST' then es.voc_no when"+
			" jc.reftype='GIP' then gp.voc_no else ''  end,char(25)) refno, jc.brhid brhid, convert(concat(coalesce(brd.brand_name,''),' ',"+
			" coalesce(model.vtype,''),' Reg No: ',coalesce(gp.regno,''),' Plate Code: ',coalesce(gp.pltid,''),' YoM: ',coalesce(yom.yom,''),"+
			" ' Others: ',coalesce(gp.vehother,'')),char(200)) vehicledetails, concat(coalesce(ac.refname,''),' , Address: ',"+
			" coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',coalesce(ac.per_mob,''),' , Mail: ',"+
			" coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_jobcard jc left join ws_estm es on "+
			" (jc.refno=es.doc_no and jc.reftype='EST') left join (select sum(invoiceamt) invoiceamt,"+
			" rdocno from ws_estlabour lab where  lab.confirmed=1 and lab.approved=1 group by rdocno ) lab on (es.doc_no=lab.rdocno) left join"+
			" (select sum(customeramt) customeramt,estdocno from ws_jccspare group by estdocno) spare on (es.doc_no=spare.estdocno) left join"+
			" ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST')) left join my_acbook ac"+
			" on (gp.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gp.pltid=plate.doc_no left join gl_vehbrand brd"+
			" on (gp.brdid=brd.doc_no) left join gl_vehmodel model on brd.doc_no=gp.modid left join gl_yom yom on gp.yom=yom.doc_no"+
			" left join ws_floormgmtdata flr on jc.doc_no=flr.jobdocno left join (select count(*) releasecount,jobcarddocno jobdocno from "+
			" ws_vehrelease where clstatus=0 group by jobcarddocno) rls on jc.doc_no=rls.jobdocno left join my_acbook insur on (insur.cldocno=gp.insurcldocno and insur.dtype='CRM') where jc.complete=1 "+sqltest+" and "+
			" jc.confirmstatus=0 and coalesce(rls.releasecount,0)=0 group by jc.doc_no order by jc.doc_no";
			
			System.out.println("Job Card Without Invoice Query:"+strsql);
			
			ResultSet resultSet = stmt.executeQuery(strsql);
			
			data=objcommon.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
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
	
	
	public JSONArray getEstimateData(String jobcard,String id)throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strgetcount="select count(*) rowcount from ws_investdata where jobdocno="+jobcard;
			ResultSet rscount=stmt.executeQuery(strgetcount);
			int count=0;
			while(rscount.next()){
				count=rscount.getInt("rowcount");
			}
			String strsql="";
			if(count>0){
				/*strsql="select rowno, jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, podate, if(vattype=1,'Shared','Insur.Company') vattype, status from ws_investdata where jobdocno="+jobcard;*/
				strsql="select w.rowno, jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, if(chkmultiple=0,0,chkclaim) chkclaim, if(chkmultiple=0,'',claimno) claimno, if(chkmultiple=0,0.0,excess) excess, if(chkmultiple=0,'',pono) pono,  if(chkmultiple=0,null,podate) podate,	if(chkmultiple=0,'',if(vattype=1,'Shared','Insur.Company')) vattype, w.status, claimno downclaimno,excess downexcess, pono downpono, podate downpodate,vattype downvattype,addition,i.rowno insurtypedocno,i.typename insurtype from ws_investdata w left join my_acinsurtype i on w.insurtypedocno=i.rowno  where jobdocno="+jobcard;
			}
			else{
			/*	strsql="select convert(concat(est.doc_no,' - 0'),char(10)) estno,est.netservices labourtotal,est.sparenettotal sparetotal,"+
				" est.netservices+est.sparenettotal nettotal from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) "+
				" where job.status=3 and job.doc_no="+jobcard+" union all"+
				" select convert(concat(est.doc_no,' - ',est.addition),char(10)) estno,est.netservices labourtotal,est.sparenettotal sparetotal,"+
				" est.netservices+est.sparenettotal nettotal from ws_jobcard job left join ws_estmadd est on (job.doc_no=est.jobcarddocno) "+
				" where job.status=3 and job.doc_no="+jobcard;*/
				
			/*	strsql="select a.estno,coalesce(a.sparetotal,0) sparetotal,coalesce(b.labourtotal,0) labourtotal,coalesce(a.sparetotal,0)+coalesce(b.labourtotal,0) nettotal  from ws_jobcard jc left join (select  "+
				" job.doc_no,convert(concat(est.voc_no,' - ',coalesce(spare.addition,0)),char(10)) estno,coalesce(sum(spare.customeramt),0)  sparetotal from ws_jobcard job"+
				" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_jccspare spare on est.doc_no=spare.estdocno"+
				" where job.doc_no="+jobcard+" group by spare.addition ) a on a.doc_no=jc.doc_no left join "+
				" (select  job.doc_no,convert(concat(est.voc_no,' - ',lab.addition),char(10)) estno,coalesce(sum(lab.invoiceamt),0) labourtotal from ws_jobcard job left join"+
				" ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno where job.doc_no="+jobcard+" group by lab.addition) b"+
				" on b.doc_no=jc.doc_no and a.estno=b.estno where jc.doc_no="+jobcard;*/
				strsql=" select b.*,if(b.addition=0,b.estclaim,ad.claimno) claimno from (select estdocno,0 chkmultiple, estclaim,lpo pono,0 excess,doc_no, addition, estno, sum(sparetotal) sparetotal, sum(labtot) labourtotal,sum(sparetotal)+sum(labtot) nettotal from (select est.doc_no estdocno,est.claimno estclaim,gate.lpo,gate.excessamt,job.doc_no,coalesce(spare.addition,0) addition,convert(concat(est.voc_no,' - ',"+
				" coalesce(spare.addition,0)),char(20)) estno,coalesce(sum(spare.customeramt),0) sparetotal,0 labtot from ws_jobcard job left join ws_estm est"+
				" on (job.reftype='EST' and job.refno=est.doc_no) left join ws_jccspare spare on est.doc_no=spare.estdocno"+
				" left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+jobcard+" group by spare.addition"+
				"  union all"+
				"  select est.doc_no estdocno,est.claimno estclaim,gate.lpo,gate.excessamt,job.doc_no,coalesce(lab.addition,0) addition,"+
				"  convert(concat(est.voc_no,' - ',lab.addition),char(20)) estno,0,coalesce(sum(lab.invoiceamt),0) labourtotal from ws_jobcard job"+
				"  left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no left join ws_estlabour lab on est.doc_no=lab.rdocno where"+
				"  job.doc_no="+jobcard+" group by lab.addition) a group by addition)b"+
				" left join ws_estmadd ad on ad.estdocno=b.estdocno and ad.addition=b.addition";
			}
			System.out.println("==="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getAmountData(String jobcard,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select round(calc.discountpercent,2) discountpercent,coalesce(calc.remarks,'') remarks,inv.brhid invbrhid,calc.rowno, calc.jobdocno, calc.billtoacno,head.description acname, calc.claimno, calc.description, round(calc.amount,2) amount, "+
			" round(calc.discount,2) discount, round(calc.netamount,2) net, round(calc.vatamount,2) vat, round(calc.totalamount,2) total, round(calc.excessamount,2) excess,round(calc.roundoff,2) roundoff, round(calc.netbill,2) netbill , calc.invno, "+
			" calc.confirmstatus, calc.insurstatus from ws_invcalctemp calc left join my_head head on calc.billtoacno=head.doc_no left join ws_invm inv on inv.doc_no=calc.invno where jobdocno="+jobcard;
			
			System.out.println("=== "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	public int insertWorkshopInvoice(Date sqldate, String cmbreftype, String hidrefno,
			String cldocno, String invoicetoacno, String excessamountacno,
			String total, String discount, String excessamount,
			String nettotal, String remarks, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode, 
			String branch, ArrayList<String> invoicearray,Connection conn, String taxpercent, 
			String taxamount, String taxtotal,String hidchksaperateinvoice,String billtoacno,double roundoff,double netbill) throws SQLException {
			System.out.println("Net Bill:"+netbill);
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
			request.setAttribute("WSINVtrNO", trno);
			if(docno<=0){
				int errorstatus=1;
				//conn.close();
				return 0;
			}
			String strupdateacno="update ws_invm set invoicetoacno="+billtoacno+" where doc_no="+docno;
			int updateacno=stmt.executeUpdate(strupdateacno);
			int errorstatus=0;
			if(updateacno<=0){
				errorstatus=0;
				return 0;
			}
			String strupdatefloormgmt="update ws_floormgmtdata set invstatus=1 where jobdocno="+hidrefno;
			int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
			if(updatefloormgmt<0){
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
				
				ArrayList<String> acnodetailarray=invoicedao.getWorkshopAccountDetails(conn,cmbreftype,hidrefno);
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
						/*
						 * Commented for fancy total vat to insurance company case
						 */
						// vatval=objcommon.Round(vatval, 2);
						vatval=objcommon.Round(Double.parseDouble(taxamount), 2);
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
								System.out.println("Tax Jv1:"+strtaxjv);
								tempsrno++;
								Statement stmttaxjv=conn.createStatement();
								System.out.println("Jvtran Sql:"+strtaxjv);
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
								System.out.println("Excess JV 1:"+strjvparty);
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
				roundamt=roundoff;
				if(insuracno>0){
					note="JV Entry for Workshop Invoice "+vocno;
					note=getJvDescription(conn,remarks,cmbreftype,hidrefno);
					int discountconfig=invoicedao.getDiscountConfig(conn);
					
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
					/// changed for fancy  insuracno
					if(partydramt!=0.0){
						String strjvparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								" doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+invoicetoacno+"',"+
								" '"+partydramt+"','"+currate+"','"+curid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+sqldate+"',"+
								" '"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+note+"','"+curid+"','5',1,0,3)";
								System.out.println("Insur Company Jv1:"+strjvparty);
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
								System.out.println("Insur Company Jv2:"+strjvcomp);
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
					int discountconfig=invoicedao.getDiscountConfig(conn);
					
					double roundldr=0.0;
					if(discountconfig==1){
						//Overridden
						ramt=netbill;
						roundamt= roundoff;
						roundamt=objcommon.Round(roundamt, 2);
						roundldr=roundamt*currate;
					}
					else{
						ramt=netbill;
						
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
							System.out.println("Round Jv:"+sqljvdisc);
							int discval=stmt.executeUpdate(sqljvdisc);
							i++;
							if(discval<=0){
								errorstatus=1;
							}

						}
					}
					System.out.println("Ramt:"+ramt);
					partydramt=ramt;
					compdramt=remaintotal;
					partyldramt=partydramt*currate;
					compldramt=compdramt*currate;
					System.out.println(ramt+"////"+partydramt);
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
					int costinsert=stmt.executeUpdate(strcostinsert);
					if(costinsert<=0){
						return 0;
					}
					String strupdatejv="update my_jvtran set costtype=9,costcode="+hidrefno+" where status=3 and tr_no="+trno+" and tranid="+temp[2];
					int updatejv=stmt.executeUpdate(strupdatejv);
					if(updatejv<=0){
						return 0;
					}
				}
				String testjv1="select dramount from my_jvtran where tr_no="+trno;
				ResultSet rstestjv1=stmt.executeQuery(testjv1);
				while(rstestjv1.next()){
					System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
				}
				if (docno > 0) {
					
					String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+trno;
					ResultSet rstestjv=stmt.executeQuery(testjv);
					while(rstestjv.next()){
						if(rstestjv.getDouble("dramount")==0.00){
							if(errorstatus==0){
								//conn.close();
								return docno;
							}
							else{
								conn.close();
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
		return 0;
	}
	
	public String getJvDescription(Connection conn, String remarks,
			String cmbreftype, String hidrefno) throws SQLException {
		// TODO Auto-generated method stub
		String desc="";
		try{
			Statement stmt=conn.createStatement();
			String strsql="select concat('"+remarks+"',' ',gate.pltid,' - ',concat(brd.brand_name,' ',model.vtype)) description "+
			" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass"+
			" gate on est.gipno=gate.doc_no left join gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on "+
			" gate.modid=model.doc_no where job.doc_no="+hidrefno;
			
			System.out.println("description==="+strsql);
			
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
}
