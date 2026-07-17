package com.dashboard.workshop.invoiceprocessingv3;

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
import net.sf.json.JSONObject;

public class ClsInvProcessingV3DAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsWSInvoiceDAO invoicedao=new ClsWSInvoiceDAO();
	
	public double getVATAmount(String jobcarddocno,String detaddition,Connection conn) throws SQLException{
		double vatamt=0.0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select a.estdocno,a.addition,a.jobtype,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) serialno,a.description,a.hrs qty,a.rate,a.jobdiscount,a.jobtotal,a.jobvatpercent,a.jobvatamount,a.jobnetamount from ("+
					" select est.doc_no estdocno,lab.addition, @i:=0 count,coalesce(lab.strjobtype,lab.strjobdesc) jobtype,lab.strjobdesc description,est.voc_no,round(coalesce(lab.hrs,0),2) hrs,"+
					" round(coalesce(lab.rate,0),2) rate,round(if(lab.hrs*lab.rate-lab.invoiceamt>0,lab.hrs*lab.rate-lab.invoiceamt,coalesce(lab.jobdiscount,0)),2) jobdiscount,"+
					" round(coalesce(lab.invoiceamt,0),2) jobtotal,"+
					" round(coalesce(lab.jobvatpercent,0),2) jobvatpercent,round(coalesce(lab.invoiceamt*(lab.jobvatpercent/100),0),2) jobvatamount,"+
					" round(coalesce((lab.invoiceamt*(lab.jobvatpercent/100))+lab.invoiceamt,0),2) jobnetamount from ws_jobcard card left join ws_estm est"+
					" on  (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno"+
					" where card.doc_no="+jobcarddocno+" and card.status=3 and lab.confirmed=1 and"+
					" lab.approved=1  and lab.addition in ("+detaddition+") and lab.chkcomplete=1"+
					" union all  select est.doc_no estdocno,0 addition,@i:=0 count,'Extra' jobtype,extra.description,est.voc_no,1 hrs,round(coalesce(extra.amount,0),2),0.0 labjobdiscount,round(coalesce(extra.amount,0),2) labjobtotal,5 jobvatpercent,round(coalesce(extra.amount*0.05,0),2) jobvatamount,round(coalesce(extra.amount,0),2) from ws_jobcard card left join ws_estm est on  (card.reftype='EST' and card.refno=est.doc_no)"+
					" left join ws_jccextra extra  on card.doc_no=extra.jobcarddocno where card.doc_no="+jobcarddocno+" and card.status=3  and"+
					" coalesce(extra.jobcarddocno,0)<>0)a"+
					" union all"+
					" select a.estdocno,a.addition,'Parts' jobtype,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.qty,a.rate,a.jobdiscount,a.jobtotal,a.jobvatpercent,a.jobvatamount,a.jobnetamount from ("+
					" select est.doc_no estdocno,spare.addition,@j:=0 count,if(spare.description='',m.productname,spare.description) description, round(coalesce(spare.qty,0),2) qty,"+
					" round(coalesce(spare.rate,0),2) rate,round(if(spare.qty*spare.rate-jcc.customeramt>0,spare.qty*spare.rate-jcc.customeramt,coalesce(spare.spdiscount,0)),2) jobdiscount,"+
					" round(coalesce(jcc.customeramt,0),2) jobtotal,"+
					" round(coalesce(spare.spvatpercent,0),2) jobvatpercent,round(coalesce(jcc.customeramt*(spare.spvatpercent/100),0),2) jobvatamount,"+
					" round(coalesce((jcc.customeramt*(spare.spvatpercent/100))+jcc.customeramt,0),2) jobnetamount,"+
					" est.voc_no from ws_jobcard card left join ws_estm est"+
					" on  (card.reftype='EST' and card.refno=est.doc_no)"+
					" left join ws_jccspare jcc on est.doc_no=jcc.estdocno"+
					" left join ws_estspare spare on (jcc.detdocno=spare.rowno and spare.confirmed=1 and spare.approved=1)"+
					" left join my_main m on m.psrno=spare.psrno"+
					" where card.doc_no="+jobcarddocno+" and card.status=3  and jcc.addition in ("+detaddition+") and jcc.lumsumstatus=0 union all"+
					" select est.doc_no estdocno,jcc.addition,@j:=0 count,if(jcc.description='',m.productname,jcc.description) description,"+
					" round(coalesce(1,0),2) qty,"+
					" round(coalesce(jcc.esttotal,0),2) rate,round(if(jcc.esttotal-jcc.customeramt>0,jcc.esttotal-jcc.customeramt,0.0),2) jobdiscount,"+
					" round(coalesce(jcc.customeramt,0),2) jobtotal,"+
					" round(coalesce(5,0),2) jobvatpercent,"+
					" round(coalesce(jcc.customeramt*0.05,0),2) jobvatamount,"+
					" round(coalesce((jcc.customeramt)*0.05+jcc.customeramt,0),2) jobnetamount,"+
					" est.voc_no from ws_jobcard card left join ws_estm est"+
					" on  (card.reftype='EST' and card.refno=est.doc_no)"+
					" left join ws_jccspare jcc on est.doc_no=jcc.estdocno"+
					" left join ws_estspare spare on (jcc.detdocno=spare.rowno and spare.confirmed=1 and spare.approved=1)"+
					" left join my_main m on m.psrno=spare.psrno"+
					" where card.doc_no="+jobcarddocno+" and card.status=3  and jcc.addition in ("+detaddition+") and jcc.lumsumstatus>0)a";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				vatamt+=rs.getDouble("jobvatamount");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return vatamt;
	}
	public JSONObject insertNonTaxData(String jobdocno,String invdate,String branch,HttpSession session,HttpServletRequest request) throws SQLException{
		int errorstatus=0;
		Connection conn=null;
		JSONObject objdata=new JSONObject();
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String strdeleteEst="delete from ws_investdata where jobdocno="+jobdocno;
			int deleteEstval=stmt.executeUpdate(strdeleteEst);
			ArrayList<String> estarray=new ArrayList();
			int estdocno=0;
			String strgetestdata="select b.*,if(b.addition=0,b.estclaim,ad.claimno) claimno from (select estdocno,0 chkmultiple, estclaim,lpo pono,0 excess,doc_no,"+
			" addition, estno, sum(sparetotal) sparetotal, sum(labtot) labourtotal,sum(sparetotal)+sum(labtot) nettotal from ("+
			" select est.doc_no estdocno,est.claimno estclaim,gate.lpo,gate.excessamt,job.doc_no,coalesce(spare.addition,0) addition,"+
			" convert(concat(est.voc_no,' - ', coalesce(spare.addition,0)),char(20)) estno,"+
			" coalesce(sum(spare.customeramt),0) sparetotal,0 labtot from ws_jobcard job"+
			" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) "+
			" left join ws_jccspare spare on est.doc_no=spare.estdocno"+
			" left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+jobdocno+" group by spare.addition"+
			" union all"+
			" select est.doc_no estdocno,est.claimno estclaim,gate.lpo,gate.excessamt,job.doc_no,coalesce(lab.addition,0) addition,"+
			" convert(concat(est.voc_no,' - ',lab.addition),char(20)) estno,0,coalesce(sum(lab.invoiceamt),0) labourtotal from ws_jobcard job"+
			" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) "+
			" left join ws_gateinpass gate on est.gipno=gate.doc_no"+
			" left join ws_estlabour lab on est.doc_no=lab.rdocno where"+
			" job.doc_no="+jobdocno+" group by lab.addition) a group by addition)b left join ws_estmadd ad on ad.estdocno=b.estdocno and ad.addition=b.addition";
			System.out.println(strgetestdata);
			ResultSet rsgetestdata=stmt.executeQuery(strgetestdata);
			while(rsgetestdata.next()){
				estdocno=rsgetestdata.getInt("estdocno");
				estarray.add(rsgetestdata.getString("estno")+"::"+rsgetestdata.getString("labourtotal")+"::"+rsgetestdata.getString("sparetotal")+"::"+rsgetestdata.getString("nettotal")+"::"+0+"::"+0+"::"+0.0+"::"+rsgetestdata.getString("pono")+"::"+null+"::"+1+"::"+rsgetestdata.getString("addition")+"::"+"-1");
			}
			for(int i=0;i<estarray.size();i++){
				int chkmultiple=1;
				String estno=estarray.get(i).split("::")[0];
				String labourtotal=estarray.get(i).split("::")[1];
				String sparetotal=estarray.get(i).split("::")[2];
				String nettotal=estarray.get(i).split("::")[3];
				String chkclaim=estarray.get(i).split("::")[4].equalsIgnoreCase("true")?"1":"0";
				String claimno=(estarray.get(i).split("::")[5].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[5].equalsIgnoreCase(""))?"":estarray.get(i).split("::")[5];
				String excess=(estarray.get(i).split("::")[6].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[6].equalsIgnoreCase(""))?"0.0":estarray.get(i).split("::")[6];
				String pono=(estarray.get(i).split("::")[7].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[7].equalsIgnoreCase(""))?"":estarray.get(i).split("::")[7];
				String podate=estarray.get(i).split("::")[8];
				String vattype=estarray.get(i).split("::")[9].equalsIgnoreCase("Insur.Company")?"2":"1";
				String addition=estarray.get(i).split("::")[10];
				String insurtypedocno=(estarray.get(i).split("::")[11].equalsIgnoreCase("undefined") || estarray.get(i).split("::")[11].equalsIgnoreCase(""))?"0":estarray.get(i).split("::")[11];

				String strestinsert="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
						" vattype, status ,addition,insurtypedocno )values("+jobdocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+","+chkclaim+","+
						" '"+claimno+"',"+excess+",'"+pono+"',"+vattype+",3,"+addition+","+insurtypedocno+")";
				int estinsert=stmt.executeUpdate(strestinsert);
				if(estinsert<=0){
					errorstatus=1;
				}
				
			}
			
			//Inserting into ws_invcalctemp
			String strdeletecalc="delete from ws_invcalctemp where jobdocno="+jobdocno+" and invno=0";
			int deletecalcval=stmt.executeUpdate(strdeletecalc);
			
			String strgetvatamt="select sum(jobvat) jobvat,sum(sparevat) sparevat from ("+
			" select 0 jobvat,sum(spvatamount) sparevat from ws_estspare where approved=1 and  rdocno="+estdocno+" union all"+
			" select sum(jobvatamount) jobvat,0 sparevat from ws_estlabour where approved=1 and  rdocno="+estdocno+") a";
			ResultSet rsgetvatamt=stmt.executeQuery(strgetvatamt);
			double sparevat=0.0,labourvat=0.0;
			while(rsgetvatamt.next()){
				sparevat=rsgetvatamt.getDouble("sparevat");
				labourvat=rsgetvatamt.getDouble("jobvat");
			}
			/*String strgetamount="select concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,m.addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',"+
			" coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')))"+
			" description,0 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,m.nettotal amount,0 discount,m.nettotal nettotal,"+
			" "+(sparevat+labourvat)+" vatamt,(m.nettotal)+("+(sparevat+labourvat)+") total,0.0 excess,(m.nettotal)+"+
			" ("+(sparevat+labourvat)+") netbill from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join"+
			" ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',"+
			" job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" where chkclaim=0 and m.excess=0 and m.jobdocno="+jobdocno;*/
			/*String strgetamount="select concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,0 addition,concat('CL - ',coalesce(est.claimno,''),' PO - ',"+
			" '',' JCB - ',coalesce(job.voc_no,''),' Regn - ',concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')))"+
			" description,0 insurstatus,0 claimno,job.doc_no jobdocno,ac.acno,x.rdocno estdocno,sum(x.amount) amount,sum(x.discount) discount,sum(x.subtotal) subtotal,max(x.vatpercent) vatpercent,sum(x.vatamount) vatamount,sum(x.netamount) netamount from ("+
			" select rdocno,hrs qty,rate,hrs*rate amount,jobdiscount discount,(hrs*rate)-jobdiscount subtotal,jobvatpercent vatpercent,jobvatamount vatamount,jobnetamount netamount from ws_estlabour where rdocno="+estdocno+" and approved=1 union all"+
			" select rdocno,qty,rate,qty*rate amount,spdiscount discount,(qty*rate)-spdiscount subtotal,spvatpercent vatpercent,spvatamount vatamount,spnetamount netamount from ws_estspare where rdocno="+estdocno+" and approved=1 ) x"+
			" left join ws_estm est on x.rdocno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no"+
			" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" left join ws_jobcard job on (x.rdocno=job.refno and job.reftype='EST')";*/
			String strgetamount="select concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,0 addition,concat('CL - ',coalesce(est.claimno,''),' PO - ',"+
					" '',' JCB - ',coalesce(job.voc_no,''),' Regn - ',concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')))"+
					" description,0 insurstatus,0 claimno,job.doc_no jobdocno,ac.acno,x.rdocno estdocno,sum(x.amount) amount,sum(x.discount) discount,sum(x.subtotal) subtotal,max(x.vatpercent) vatpercent,sum(x.vatamount) vatamount,sum(x.netamount) netamount from ("+
					" select rdocno,hrs qty,rate,round(hrs*rate,2) amount,round(hrs*rate-invoiceamt,2) discount,round((hrs*rate)-round(hrs*rate-invoiceamt,2),2) subtotal,jobvatpercent vatpercent,"+
					" round(coalesce(invoiceamt,0)*(coalesce(jobvatpercent,0)/100),2) vatamount,round(coalesce(invoiceamt,0)*(coalesce(jobvatpercent,0)/100)+coalesce(invoiceamt,0),2) netamount from ws_estlabour where rdocno="+estdocno+" and approved=1 union all"+
					" select sp.rdocno,sp.qty,sp.rate,sp.qty*sp.rate amount,round((coalesce(sp.qty,0)*coalesce(sp.rate,0))-coalesce(jcc.customeramt,0),2) discount,"+
					" coalesce(sp.qty*sp.rate,0)-round((coalesce(sp.qty,0)*coalesce(sp.rate,0))-coalesce(jcc.customeramt,0),2) subtotal,sp.spvatpercent vatpercent,"+
					" round(coalesce(jcc.customeramt,0)*(coalesce(sp.spvatpercent,0)/100),2) vatamount,"+
					" round(coalesce(jcc.customeramt,0)*(coalesce(sp.spvatpercent,0)/100)+coalesce(jcc.customeramt,0),2) netamount from ws_estspare sp"+
					" left join ws_jccspare jcc on sp.rowno=jcc.detdocno and jcc.dettype='ESP' where sp.rdocno="+estdocno+" and sp.approved=1 ) x"+
					" left join ws_estm est on x.rdocno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no"+
					" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
					" left join ws_jobcard job on (x.rdocno=job.refno and job.reftype='EST')";
			System.out.println(strgetamount);
			ResultSet rsgetamount=stmt.executeQuery(strgetamount);
			ArrayList<String> calcarray=new ArrayList();
			while(rsgetamount.next()){
				calcarray.add(rsgetamount.getInt("insurstatus")+" :: "+rsgetamount.getInt("acno")+" :: "+rsgetamount.getString("claimno")+" :: "+rsgetamount.getInt("jobdocno")+" :: "+rsgetamount.getDouble("amount")+" :: "+rsgetamount.getDouble("subtotal")+" :: "+rsgetamount.getDouble("vatamount")+" :: "+rsgetamount.getDouble("netamount")+" :: "+0.0+" :: "+rsgetamount.getDouble("netamount")+" :: "+0+" :: "+rsgetamount.getString("description")+" :: "+0+" :: "+rsgetamount.getString("regno")+" :: "+rsgetamount.getString("discount"));
			}
			for(int i=0;i<calcarray.size();i++){
				String temp[]=calcarray.get(i).split("::");
				String desc1="";
				if(temp[0].equalsIgnoreCase("0") || temp[0].equalsIgnoreCase("1")){
					desc1="ALL INCLUSIVE OF PARTS AND LABOUR";
				}
				else{
					desc1="Excess on Insurance Claim";
				}
				desc1=temp[11].trim();
				String discount=temp[14].trim();
				System.out.println("DEsc"+desc1+"::"+temp[11]);
				String strinsert="insert into ws_invcalctemp(jobdocno, billtoacno, claimno, amount, netamount, "+
				" vatamount, totalamount,excessamount, netbill,insurstatus,description,pono,addition,regno,discount)values("+
				" "+temp[3].trim()+","+temp[1].trim()+",'"+temp[2].trim()+"',"+temp[4].trim()+","+temp[5].trim()+","+temp[6].trim()+","+temp[7].trim()+","+temp[8].trim()+","+temp[9].trim()+","+temp[0].trim()+",'"+desc1+"','"+temp[10].trim()+"','"+temp[12].trim()+"','"+temp[13].trim()+"',"+discount+")";
				System.out.println(strinsert);
				int insert=stmt.executeUpdate(strinsert);
				if(insert<=0){
					errorstatus=1;
				}
			}
			
			//Generating Invoice
			ArrayList<String> invarray=new ArrayList();
			String strgetamt="select round(calc.discountpercent,2) discountpercent,coalesce(calc.remarks,'') remarks,inv.brhid invbrhid,calc.rowno, calc.jobdocno, calc.billtoacno,head.description acname, calc.claimno, calc.description, round(calc.amount,2) amount, "+
			" round(calc.discount,2) discount, round(calc.netamount,2) net, round(calc.vatamount,2) vat, round(calc.totalamount,2) total, round(calc.excessamount,2) excess,round(calc.roundoff,2) roundoff, round(calc.netbill,2) netbill , calc.invno, "+
			" calc.confirmstatus, calc.insurstatus from ws_invcalctemp calc left join my_head head on calc.billtoacno=head.doc_no left join ws_invm inv on inv.doc_no=calc.invno where jobdocno="+jobdocno;
			ResultSet rsgetamt=stmt.executeQuery(strgetamt);
			while(rsgetamt.next()){
				invarray.add(rsgetamt.getString("rowno")+" :: "+rsgetamt.getString("insurstatus")+" :: "+
				rsgetamt.getString("billtoacno")+" :: "+rsgetamt.getString("claimno")+" :: "+rsgetamt.getString("description")+" :: "+rsgetamt.getString("amount")+
				" :: "+rsgetamt.getString("discount")+" :: "+rsgetamt.getString("net")+" :: "+rsgetamt.getString("vat")+" :: "+rsgetamt.getString("total")+
				" :: "+rsgetamt.getString("excess")+" :: "+rsgetamt.getString("roundoff")+" :: "+rsgetamt.getString("netbill")+" :: "+rsgetamt.getString("remarks")+" :: "+rsgetamt.getString("discountpercent"));
			}
			
			int cldocno=0;
			java.sql.Date sqldate=null;
			String strsql="select curdate() curdate,gate.cldocno from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) "+
			" left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+jobdocno;
			System.out.println(strsql);
			ResultSet rsgetvalues=stmt.executeQuery(strsql);
			while(rsgetvalues.next()){
				sqldate=rsgetvalues.getDate("curdate");
				cldocno=rsgetvalues.getInt("cldocno");
			}
			if(!invdate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(invdate);	
			}
			String invvoucher="";
			for(int i=0;i<invarray.size();i++){
				String temp[]=invarray.get(i).split("::");
				int rowno=Integer.parseInt(temp[0].trim());
				int invoicetoacno=Integer.parseInt(temp[2].trim());
				String description=temp[4].trim();
				String remarks="";
				if(!temp[13].trim().equalsIgnoreCase("undefined") && temp[13]!=null && !temp[13].trim().equalsIgnoreCase("")){
					remarks=temp[13].trim();	
				}
				double amount=objcommon.Round(Double.parseDouble(temp[5].trim()), 2);
				double discount=objcommon.Round(Double.parseDouble(temp[6].trim()), 2);
				double net=objcommon.Round(Double.parseDouble(temp[7].trim()), 2);
				double vat=objcommon.Round(Double.parseDouble(temp[8].trim()), 2);
				double total=objcommon.Round(Double.parseDouble(temp[9].trim()), 2);
				double excess=objcommon.Round(Double.parseDouble(temp[10].trim()), 2);
				double roundoff=objcommon.Round(Double.parseDouble(temp[11].trim()), 2);
				double netbill=objcommon.Round(Double.parseDouble(temp[12].trim()), 2);
				double discountpercent=objcommon.Round(Double.parseDouble(temp[14].trim()), 2);
				ArrayList<String>invoicearray=new ArrayList();
				String descar[]=description.split("###");
				invoicearray.add(descar[0].trim()+"::"+amount)	;
				for(int l=1;l<descar.length;l++){
					System.out.println("====="+descar[l]);
					invoicearray.add(descar[l].trim()+"::0.0")	;
				}
				String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and curdate() between tax.fromdate and tax.todate";
				ResultSet rs=stmt.executeQuery(strgettax);
				double vatpercent=0.0;
				while(rs.next()){
					vatpercent=rs.getDouble("vat_per");
				}
				double nontaxamt=0.0;
				int value=insertWorkshopInvoice(sqldate, "JC", jobdocno, cldocno+"", invoicetoacno+"", "0", amount+"", discount+"", 0+"", net+"", remarks, 
				session, request, "A", "MNT", branch, invoicearray, conn, vatpercent+"", vat+"", total+"", "0",invoicetoacno+"",roundoff,netbill);
				System.out.println("Invoice Value: "+value);
				int invvocno=0;
				
				if(value<=0){
					errorstatus=1;
					break;
				}
				if(value>0){
					invvocno=Integer.parseInt(request.getAttribute("WSINVVOCNO").toString());
					String strupdate1="update ws_invcalctemp set remarks='"+remarks+"',invno="+value+",description='"+description+"', amount="+amount+", discount="+discount+", netamount="+net+", vatamount="+vat+", totalamount="+total+", excessamount="+excess+", roundoff="+roundoff+", netbill="+netbill+",discountpercent="+discountpercent+" where rowno="+rowno;
					System.out.println("Update Query: "+strupdate1);
					int updateval1=stmt.executeUpdate(strupdate1);
					if(updateval1<=0){
						errorstatus=1;	
					}
					String strgetclaimdata="select coalesce(claimno,'') claimno,coalesce(pono,'') pono,addition,jobdocno from ws_invcalctemp where invno="+value;
					String claimno="",lpono="",addition="";
					ArrayList ARjob=new ArrayList();
					ResultSet rsgetclaimdata=stmt.executeQuery(strgetclaimdata);
					while(rsgetclaimdata.next()){
						claimno=rsgetclaimdata.getString("claimno");
						lpono=rsgetclaimdata.getString("pono");
						addition=rsgetclaimdata.getString("addition");
						ARjob.add(rsgetclaimdata.getString("jobdocno")+"::"+rsgetclaimdata.getString("addition"));
					}
					
					String strupdate="update ws_invm set excess="+excess+",claimno='"+claimno+"',lpono='"+lpono+"' where tr_no="+request.getAttribute("WSINVtrNO");
					System.out.println("Update Query: "+strupdate);
					int updateval=stmt.executeUpdate(strupdate);
					
					for(int q=0;q<ARjob.size();q++){
					String strins="select insurtypedocno, nettotal,round((nettotal/(select round(sum(nettotal),2) from ws_investdata where jobdocno="+ARjob.get(q).toString().split("::")[0]+" and addition in ("+ARjob.get(q).toString().split("::")[1]+")))* "
						+" (select sum(netamount) from ws_invcalctemp where invno="+value+" and jobdocno="+ARjob.get(q).toString().split("::")[0]+"),2) insamt from ws_investdata"+ 
						 " where jobdocno="+ARjob.get(q).toString().split("::")[0]+" and addition in ("+ARjob.get(q).toString().split("::")[1]+") ";
					System.out.println("Update Query: "+strins);
					ResultSet rsins=stmt.executeQuery(strins);
					String sqlins="insert into ws_invinsurtype( invno, insurtype, amount) values ";
					while(rsins.next()){
						sqlins+=" ("+value+","+rsins.getString("insurtypedocno")+","+rsins.getString("insamt")+ ") , ";
					}
					System.out.println("===="+sqlins.substring(0, sqlins.length()-2));
					stmt.execute(sqlins.substring(0, sqlins.length()-2));
					}
					if(updateval1>0){
						if(invvoucher.equalsIgnoreCase("")){
							invvoucher=invvocno+"";
						}
						else{
							invvoucher+=","+invvocno;
						}
					}
					String detaddition="";
					String straddition="select group_concat(distinct t.addition) addition from ws_invm m left join ws_invcalctemp t on m.doc_no=t.invno where m.doc_no="+value;
					System.out.println(addition+"==="+straddition);
					ResultSet rsadd=stmt.executeQuery(straddition);
					while(rsadd.next()){
						detaddition=rsadd.getString("addition");
					}
					System.out.println("Addition:"+detaddition);
					String jobcarddocno=jobdocno;
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
							" where card.doc_no="+jobcarddocno+" and card.status=3 and spare.addition in ("+detaddition+") and spare.chkcomplete=1";
						}
						else{
							strtest="select @j:=0 count,spare.description,round(spare.approvedvalue,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on"+
									" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estspare spare on est.doc_no=spare.rdocno  where card.doc_no="+jobcarddocno+" "+
									" and card.status=3  and spare.addition in ("+detaddition+") and spare.chkcomplete=1";
						}
					//}
					String strdetsql="";
					if(proformaconfig==1){
						strdetsql="select convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) serialno,a.description,a.amount from ("+
								" select @i:=0 count,lab.strjobdesc description,round(lab.invoiceamt,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
								" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
								" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+jobcarddocno+" and card.status=3 and lab.confirmed=1 and lab.approved=1  and lab.addition in ("+detaddition+") and lab.chkcomplete=1 union all "+
								" select @i:=0 count,extra.description,round(extra.amount,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
								" (card.reftype='EST' and card.refno=est.doc_no) left join ws_jccextra extra "+
								" on card.doc_no=extra.jobcarddocno where card.doc_no="+jobcarddocno+" and card.status=3  and coalesce(extra.jobcarddocno,0)<>0)a union all"+
								" select convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount from ("+
								" "+strtest+")a";
					}
					else{
						strdetsql="select convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) serialno,a.description,a.amount from ("+
								" select @i:=0 count,lab.strjobdesc description,round(lab.total,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
								" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
								" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+jobcarddocno+" and lab.addition in ("+detaddition+") and card.status=3 and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1)a union all"+
								" select convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount from ("+
								" "+strtest+")a";
					}
					
					//Custom for Liwa
					
					strsql="select a.estdocno,a.addition,a.jobtype,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) serialno,a.description,a.hrs qty,a.rate,a.jobdiscount,a.jobtotal,a.jobvatpercent,a.jobvatamount,a.jobnetamount from ("+
							" select est.doc_no estdocno,lab.addition, @i:=0 count,coalesce(lab.strjobtype,lab.strjobdesc) jobtype,lab.strjobdesc description,est.voc_no,round(coalesce(lab.hrs,0),2) hrs,"+
							" round(coalesce(lab.rate,0),2) rate,round(if(lab.hrs*lab.rate-lab.invoiceamt>0,lab.hrs*lab.rate-lab.invoiceamt,coalesce(lab.jobdiscount,0)),2) jobdiscount,"+
							" round(coalesce(lab.invoiceamt,0),2) jobtotal,"+
							" round(coalesce(lab.jobvatpercent,0),2) jobvatpercent,round(coalesce(lab.invoiceamt*(lab.jobvatpercent/100),0),2) jobvatamount,"+
							" round(coalesce((lab.invoiceamt*(lab.jobvatpercent/100))+lab.invoiceamt,0),2) jobnetamount from ws_jobcard card left join ws_estm est"+
							" on  (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno"+
							" where card.doc_no="+jobcarddocno+" and card.status=3 and lab.confirmed=1 and"+
							" lab.approved=1  and lab.addition in ("+detaddition+") and lab.chkcomplete=1"+
							" union all  select est.doc_no estdocno,0 addition,@i:=0 count,'Extra' jobtype,extra.description,est.voc_no,1 hrs,round(coalesce(extra.amount,0),2),0.0 labjobdiscount,round(coalesce(extra.amount,0),2) labjobtotal,5 jobvatpercent,round(coalesce(extra.amount*0.05,0),2) jobvatamount,round(coalesce(extra.amount,0),2) from ws_jobcard card left join ws_estm est on  (card.reftype='EST' and card.refno=est.doc_no)"+
							" left join ws_jccextra extra  on card.doc_no=extra.jobcarddocno where card.doc_no="+jobcarddocno+" and card.status=3  and"+
							" coalesce(extra.jobcarddocno,0)<>0)a"+
							" union all"+
							" select a.estdocno,a.addition,'Parts' jobtype,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.qty,a.rate,a.jobdiscount,a.jobtotal,a.jobvatpercent,a.jobvatamount,a.jobnetamount from ("+
							" select est.doc_no estdocno,spare.addition,@j:=0 count,if(spare.description='',m.productname,spare.description) description, round(coalesce(spare.qty,0),2) qty,"+
							" round(coalesce(spare.rate,0),2) rate,round(if(spare.qty*spare.rate-jcc.customeramt>0,spare.qty*spare.rate-jcc.customeramt,coalesce(spare.spdiscount,0)),2) jobdiscount,"+
							" round(coalesce(jcc.customeramt,0),2) jobtotal,"+
							" round(coalesce(spare.spvatpercent,0),2) jobvatpercent,round(coalesce(jcc.customeramt*(spare.spvatpercent/100),0),2) jobvatamount,"+
							" round(coalesce((jcc.customeramt*(spare.spvatpercent/100))+jcc.customeramt,0),2) jobnetamount,"+
							" est.voc_no from ws_jobcard card left join ws_estm est"+
							" on  (card.reftype='EST' and card.refno=est.doc_no)"+
							" left join ws_jccspare jcc on est.doc_no=jcc.estdocno"+
							" left join ws_estspare spare on (jcc.detdocno=spare.rowno and spare.confirmed=1 and spare.approved=1)"+
							" left join my_main m on m.psrno=spare.psrno"+
							" where card.doc_no="+jobcarddocno+" and card.status=3  and jcc.addition in ("+detaddition+") and jcc.lumsumstatus=0 union all"+
							" select est.doc_no estdocno,jcc.addition,@j:=0 count,if(jcc.description='',m.productname,jcc.description) description,"+
							" round(coalesce(1,0),2) qty,"+
							" round(coalesce(jcc.esttotal,0),2) rate,round(if(jcc.esttotal-jcc.customeramt>0,jcc.esttotal-jcc.customeramt,0.0),2) jobdiscount,"+
							" round(coalesce(jcc.customeramt,0),2) jobtotal,"+
							" round(coalesce(5,0),2) jobvatpercent,"+
							" round(coalesce(jcc.customeramt*0.05,0),2) jobvatamount,"+
							" round(coalesce((jcc.customeramt)*0.05+jcc.customeramt,0),2) jobnetamount,"+
							" est.voc_no from ws_jobcard card left join ws_estm est"+
							" on  (card.reftype='EST' and card.refno=est.doc_no)"+
							" left join ws_jccspare jcc on est.doc_no=jcc.estdocno"+
							" left join ws_estspare spare on (jcc.detdocno=spare.rowno and spare.confirmed=1 and spare.approved=1)"+
							" left join my_main m on m.psrno=spare.psrno"+
							" where card.doc_no="+jobcarddocno+" and card.status=3  and jcc.addition in ("+detaddition+") and jcc.lumsumstatus>0)a";
					System.out.println(strsql);
					ResultSet rsgetdetail=stmt.executeQuery(strsql);
					ArrayList<String> detailarray=new ArrayList();
					while(rsgetdetail.next()){
						detailarray.add(rsgetdetail.getString("estdocno")+"::"+rsgetdetail.getString("addition")+"::"+rsgetdetail.getString("serialno")+"::"+rsgetdetail.getString("jobtype")+"::"+rsgetdetail.getString("description")+"::"+rsgetdetail.getString("qty")+"::"+rsgetdetail.getString("rate")+"::"+rsgetdetail.getString("jobdiscount")+"::"+rsgetdetail.getString("jobtotal")+"::"+rsgetdetail.getString("jobvatpercent")+"::"+rsgetdetail.getString("jobvatamount")+"::"+rsgetdetail.getString("jobnetamount"));
					}
					for(int detindex=0;detindex<detailarray.size();detindex++){
						String tempdet[]=detailarray.get(detindex).split("::");
						String tempestdocno=tempdet[0];
						String detadditon=tempdet[1];
						String serialno=tempdet[2];
						String type=tempdet[3];
						String desc=tempdet[4];
						String qty=tempdet[5];
						String rate=tempdet[6];
						String jobdiscount=tempdet[7];
						String jobtotal=tempdet[8];
						String jobvatpercent=tempdet[9];
						String jobvatamount=tempdet[10];
						String jobnetamount=tempdet[11];
						
						String strinsertdetail="insert into ws_investdetail(type,serialno,description,qty,rate,discount,amount,vatpercent,vatamount,netamount,estdocno,addition,jobdocno,invno)values("+
						"'"+type+"','"+serialno+"','"+desc+"',"+qty+","+rate+","+jobdiscount+","+jobtotal+","+jobvatpercent+","+jobvatamount+","+jobnetamount+","+tempestdocno+","+detadditon+","+jobcarddocno+","+value+")";
						int insertdetail=stmt.executeUpdate(strinsertdetail);
						if(insertdetail<=0){
							errorstatus=1;
							break;
						}
					}
					if(errorstatus==0){
						conn.commit();
					}
					objdata.put("invvoucher",invvoucher);
					
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			errorstatus=1;
			conn.close();
		}
		finally{
			conn.close();
		}
		objdata.put("errorstatus", errorstatus);
		return objdata;
	}
	public JSONArray getNonTaxGridData(String jobdocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strgetestdocno="select est.doc_no from ws_jobcard job inner join ws_estm est on job.refno=est.doc_no and job.reftype='EST' where job.doc_no="+jobdocno+" and job.status=3";
			ResultSet rsgetestdocno=stmt.executeQuery(strgetestdocno);
			int estdocno=0;
			while(rsgetestdocno.next()){
				estdocno=rsgetestdocno.getInt("doc_no");
			}
			/*String strgetnontax="select coalesce(lab.strjobdesc,'') description,coalesce(lab.hrs,0) qty,round(coalesce(lab.rate,0),2) rate,"+
			" round(coalesce(lab.jobdiscount,0),2) discount,(round(coalesce(lab.hrs,0),2)*round(coalesce(lab.rate,0),2))-round(coalesce(lab.jobdiscount,0),2) amount,"+
			" round(coalesce(lab.jobvatpercent,0),2) vatpercent,round(coalesce(lab.jobvatamount,0),2) vatamount,round(coalesce(lab.jobnetamount,0),2) netamount from ws_estlabour lab where approved=1 and rdocno="+estdocno+" union all"+
			" select coalesce(sp.description,'') description,round(coalesce(sp.qty,0),2) qty,round(coalesce(sp.rate,0),2) rate,"+
			" round(coalesce(sp.spdiscount,0),2) discount,(round(coalesce(sp.qty,0),2)*round(coalesce(sp.rate,0),2))-round(coalesce(sp.spdiscount,0),2) amount,"+
			" round(coalesce(sp.spvatpercent,0),2) vatpercent,round(coalesce(sp.spvatamount,0),2) vatamount,round(coalesce(sp.spnetamount,0),2) netamount from ws_estspare sp where approved=1 and rdocno="+estdocno;
			*/
			String strgetnontax="select coalesce(lab.strjobdesc,'') description,coalesce(lab.hrs,0) qty,round(coalesce(lab.rate,0),2) rate,"+
			" round((coalesce(lab.hrs,0)*coalesce(lab.rate,0))-coalesce(lab.invoiceamt,0),2) discount,round(coalesce(lab.invoiceamt,0),2) amount,"+
			" round(coalesce(lab.jobvatpercent,0),2) vatpercent,round(coalesce(lab.invoiceamt,0)*(coalesce(lab.jobvatpercent,0)/100),2) vatamount,"+
			" round(coalesce(lab.invoiceamt,0)*(coalesce(lab.jobvatpercent,0)/100)+coalesce(lab.invoiceamt,0),2) netamount from ws_estlabour lab where approved=1 and rdocno="+estdocno+" union all"+
			" select coalesce(sp.description,'') description,round(coalesce(sp.qty,0),2) qty,round(coalesce(sp.rate,0),2) rate,"+
			" round((coalesce(sp.qty,0)*coalesce(sp.rate,0))-coalesce(jcc.customeramt,0),2) discount,round(coalesce(jcc.customeramt,0),2) amount,"+
			" round(coalesce(sp.spvatpercent,0),2) vatpercent,round(coalesce(jcc.customeramt,0)*(coalesce(sp.spvatpercent,0)/100),2) vatamount,"+
			" round(coalesce(jcc.customeramt,0)*(coalesce(sp.spvatpercent,0)/100)+coalesce(jcc.customeramt,0),2) netamount from ws_estspare sp left join "+
			" ws_jccspare jcc on sp.rowno=jcc.detdocno and jcc.dettype='ESP' where approved=1 and rdocno="+estdocno;
			
			System.out.println(strgetnontax);
			ResultSet rs=stmt.executeQuery(strgetnontax);
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
			
			
			String strsql="select gp.processstatus,coalesce(d1.nontaxrow,0) nontaxrow,coalesce(insur.refname,'') insurcompname,gp.insurcldocno,gp.insurancecomp insurcomp,es.doc_no estdocno,es.voc_no estvocno,jc.doc_no doc_no,jc.voc_no voc_no, jc.date date, jc.reftype reftype, convert(case when jc.reftype='EST' then es.voc_no when"+
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
			" ws_vehrelease where clstatus=0 group by jobcarddocno) rls on jc.doc_no=rls.jobdocno left join my_acbook insur on (insur.cldocno=gp.insurcldocno and insur.dtype='CRM') "+
			" left join (select sum(nontaxrow) nontaxrow,estdocno from ("+
			" select coalesce(if(entitytype=0,1,0),0) nontaxrow,doc_no estdocno from ws_estm where entitytype=0 group by doc_no union all"+
			" select coalesce(if(entitytype=0,1,0),0) nontaxrow,doc_no estdocno from ws_estmadd where entitytype=0 group by doc_no,addition)c1 "+
			" group by c1.estdocno) d1 on (jc.refno=d1.estdocno and jc.reftype='EST')"+
			" where jc.complete=1 "+sqltest+" and "+
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
		if(jobcard.trim().equalsIgnoreCase("")){
			return data;
		}
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
				strsql="select w.rowno, jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal,nontaxamt, if(chkmultiple=0,0,chkclaim) chkclaim, if(chkmultiple=0,'',claimno) claimno, if(chkmultiple=0,0.0,excess) excess, if(chkmultiple=0,'',pono) pono,  if(chkmultiple=0,null,podate) podate,	if(chkmultiple=0,'',if(vattype=1,'Shared','Insur.Company')) vattype, w.status, claimno downclaimno,excess downexcess, pono downpono, podate downpodate,vattype downvattype,addition,i.rowno insurtypedocno,i.typename insurtype from ws_investdata w left join my_acinsurtype i on w.insurtypedocno=i.rowno  where jobdocno="+jobcard;
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
				int defaultvatconfig=0;
				String strvatconfig="select method from gl_config where field_nme='DefaultWSInvVAT'";
				ResultSet rsvatconfig=stmt.executeQuery(strvatconfig);
				while(rsvatconfig.next()){
					defaultvatconfig=rsvatconfig.getInt("method");
				}
				String defaultvatselect="",defaultvatjoin="";
				if(defaultvatconfig>0){
					defaultvatselect="'Shared' vattype,insur.rowno insurtypedocno,insur.typename insurtype,";
					defaultvatjoin=",(select typename,rowno from my_acinsurtype where rowno=(select min(rowno) from my_acinsurtype where status=3)) insur";
				}
				strsql=" select "+defaultvatselect+"b.*,if(b.addition=0,b.estclaim,ad.claimno) claimno from (select estdocno,0 chkmultiple, estclaim,lpo pono,0 excess,doc_no, addition, estno, sum(sparetotal) sparetotal, sum(labtot) labourtotal,sum(sparetotal)+sum(labtot) nettotal,sum(nontaxamt) nontaxamt from (select est.doc_no estdocno,est.claimno estclaim,gate.lpo,gate.excessamt,job.doc_no,coalesce(spare.addition,0) addition,convert(concat(est.voc_no,' - ',"+
				" coalesce(spare.addition,0)),char(20)) estno,coalesce(sum(spare.customeramt),0) sparetotal,0 labtot,0 nontaxamt  from ws_jobcard job left join ws_estm est"+
				" on (job.reftype='EST' and job.refno=est.doc_no) left join ws_jccspare spare on est.doc_no=spare.estdocno"+
				" left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+jobcard+" group by spare.addition"+
				"  union all"+
				"  select est.doc_no estdocno,est.claimno estclaim,gate.lpo,gate.excessamt,job.doc_no,coalesce(lab.addition,0) addition,"+
				"  convert(concat(est.voc_no,' - ',lab.addition),char(20)) estno,0 sparetotal,"+
				" coalesce(sum(if(coalesce(jt.taxable,1)=1,lab.invoiceamt,0.0)),0) labtot,"+
				" coalesce(sum(if(coalesce(jt.taxable,1)=0,lab.jobnetamount,0.0)),0) nontaxamt from ws_jobcard job"+
				" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) "+
				" left join ws_gateinpass gate on est.gipno=gate.doc_no left join ws_estlabour lab on est.doc_no=lab.rdocno "+
				" left join ws_jobtype jt on lab.jobid=jt.doc_no where"+
				"  job.doc_no="+jobcard+" group by lab.addition) a group by addition)b"+
				" left join ws_estmadd ad on ad.estdocno=b.estdocno and ad.addition=b.addition "+defaultvatjoin;
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
			
			String strsql="select round(calc.nontaxamt,2) nontaxamt,round(calc.discountpercent,2) discountpercent,coalesce(calc.remarks,'') remarks,inv.brhid invbrhid,calc.rowno, calc.jobdocno, calc.billtoacno,head.description acname, calc.claimno, calc.description, round(calc.amount,2) amount, "+
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
			System.out.println("Net Total:"+nettotal);
			
		// TODO Auto-generated method stub
		int docno=0,vocno=0,trno=0;
		try{
			
			excessamountacno=excessamountacno.trim().equalsIgnoreCase("")?"0":excessamountacno.trim();
			Statement stmt=conn.createStatement();
			String calcrowno=request.getAttribute("WSINVCALCNO").toString();
			ResultSet rsduplicate=stmt.executeQuery("select * from ws_invcalctemp where rowno="+calcrowno);
			int calcacno=0,calcaddition=0,calcjobdocno=0;
			while(rsduplicate.next()){
				calcacno=rsduplicate.getInt("billtoacno");
				calcjobdocno=rsduplicate.getInt("jobdocno");
				calcaddition=rsduplicate.getInt("addition");
			}
			ResultSet rsdupcount=stmt.executeQuery("select count(*) itemcount from ws_invcalctemp where billtoacno="+calcacno+" and jobdocno="+calcjobdocno+" and addition="+calcaddition+" and invno>0");
			int dupcount=0;
			while(rsdupcount.next()){
				dupcount=rsdupcount.getInt("itemcount");
			}
			if(dupcount>0){
				System.out.println("Duplicate Invoices Found");
				return 0;
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
				//netamt+=nontaxamt;
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
					    ramt=netbill;
                        roundamt= roundoff;
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
							System.out.println(sqljvdisc);
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
					System.out.println("excess:"+excessamt);
					if(hidchksaperateinvoice.equalsIgnoreCase("0")){
						remaintotal+=excessamt;
					}
					System.out.println("Check before subtracting vat:"+remaintotal+"::"+vatval);
					remaintotal-=vatval;
					System.out.println("Check after subtracting vat:"+remaintotal+"::"+vatval);
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
			String strsql="select concat('"+remarks+"',' ' ,gate.regno,' - ',gate.pltid,' - ',concat(brd.brand_name,' ',model.vtype)) description "+
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
