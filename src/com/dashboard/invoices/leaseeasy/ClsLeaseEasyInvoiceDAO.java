package com.dashboard.invoices.leaseeasy;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.connection.*;
import com.common.*;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsLeaseEasyInvoiceDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
	public JSONArray getLeaseInvoice(String branch,String date,String cldocno,String cmbtype,String id) throws SQLException{
		
		JSONArray leasedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return leasedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and agmt.cldocno="+cldocno;
			}
			if(!date.equalsIgnoreCase("") && date!=null){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqldate!=null){
				sqltest+=" and agmt.invtodate='"+sqldate+"'";
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and agmt.brhid="+branch;
			}
			/*String strsql="select a.cldocno,count(a.agmtno) agmtcount,a.invdate fromdate,a.invtodate todate,head.account,head.doc_no,head.description acname,sum(round((a.datediff/a.monthcal)*a.rate,2)) "+
			" rentalsum,sum(round((a.datediff/a.monthcal)*a.inssum,2)) insurchg,sum(round((a.datediff/a.monthcal)*a.accsum,2)) accsum,sum(round((a.datediff/a.monthcal)*a.rate,2))+sum(round((a.datediff/a.monthcal)*a.inssum,2))+sum(round((a.datediff/a.monthcal)*a.accsum,2)) amount from ("+
			" select agmt.doc_no agmtno,agmt.cldocno,if((select method from gl_config where field_nme='lesmonthlycal')=1,day(last_day(agmt.invtodate)),"+
			" (select value from gl_config where field_nme='lesmonthlycal')) monthcal,ltf.rate,(ltf.cdw+ltf.pai+ltf.cdw1+ltf.pai1) inssum,"+
			" (ltf.gps+ltf.babyseater+ltf.cooler) accsum,agmt.invdate,agmt.invtodate,datediff(invtodate,invdate) datediff from gl_lagmt agmt"+
			" left join gl_ltarif ltf on agmt.doc_no=ltf.rdocno where agmt.clstatus=0 "+sqltest+")a left join my_acbook ac on"+
			" (a.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no group by a.cldocno";
			*/
			String strsql="select c.cldocno,sum(c.agmtcount) agmtcount,c.fromdate,c.todate,c.account,c.doc_no,c.acname,sum(c.rentalsum) rentalsum,sum(c.insurchg) insurchg,sum(c.accsum) accsum,sum(c.amount) amount from (select a.cldocno,count(a.agmtno) agmtcount,a.invdate fromdate,a.invtodate todate,head.account,head.doc_no,head.description acname,sum(round((a.datediff/a.monthcal)*a.rate,2)) "+
			" rentalsum,sum(round((a.datediff/a.monthcal)*a.inssum,2)) insurchg,sum(round((a.datediff/a.monthcal)*a.accsum,2)) accsum,sum(round((a.datediff/a.monthcal)*a.rate,2))+sum(round((a.datediff/a.monthcal)*a.inssum,2))+sum(round((a.datediff/a.monthcal)*a.accsum,2)) amount from ("+
			" select agmt.doc_no agmtno,agmt.cldocno,if((select method from gl_config where field_nme='lesmonthlycal')=1,day(last_day(agmt.invtodate)),"+
			" (select value from gl_config where field_nme='lesmonthlycal')) monthcal,ltf.rate,(ltf.cdw+ltf.pai+ltf.cdw1+ltf.pai1) inssum,"+
			" (ltf.gps+ltf.babyseater+ltf.cooler) accsum,agmt.invdate,agmt.invtodate,datediff(invtodate,invdate) datediff from gl_lagmt agmt"+
			" left join gl_ltarif ltf on agmt.doc_no=ltf.rdocno where agmt.clstatus=0 "+sqltest+""+
			" )a left join my_acbook ac on"+
			" (a.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no group by a.cldocno"+
			" union all"+
			" select b.cldocno,count(b.doc_no) agmtcount,b.invdate fromdate,b.invtodate todate,head.account,head.doc_no,head.description acname,"+
			" sum(b.rentalsum) rentalsum,sum(b.inssum) insurchg,sum(b.accsum) accsum,sum(b.rentalsum)+sum(b.inssum)+sum(b.accsum) amount from ("+
			" select a.doc_no,a.cldocno,a.invdate,a.invtodate,round(sum(a.rate),2) rentalsum,round(sum(a.accsum),2) accsum,"+
			" round(sum(a.inssum),2) inssum  from ("+
			" select agmt.doc_no,agmt.cldocno,calc.oldinvdate invdate,calc.oldinvtodate invtodate,calc.rdocno,if(calc.idno=1,amount,0.0) rate,if(calc.idno=2,amount,0.0) accsum,"+
			" if(calc.idno=17,amount,0.0) inssum,if((select method from gl_config where field_nme='lesmonthlycal')=1,"+
			" day(last_day(agmt.invtodate)),(select value from gl_config where field_nme='lesmonthlycal')) monthcal from gl_lagmt agmt left join gl_lcalc calc on agmt.doc_no=calc.rdocno left join gl_lagmtclosem"+
			" closem on agmt.doc_no=closem.agmtno where agmt.brhid="+branch+" and closem.indate<='"+sqldate+"' and agmt.clstatus=1 and calc.calcstatus=1 and calc.afterclose=0 and calc.amount>0 and"+
			" calc.idno in (1,2,17) group by calc.rdocno,idno)a group by a.rdocno) b left join my_acbook ac on (b.cldocno=ac.cldocno and"+
			" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no group by b.cldocno) c group by c.cldocno";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			leasedata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return leasedata;
	}
	
	
	public JSONArray getAgmtDetailData(String branch,String date,String cldocno,String cmbtype,String id) throws SQLException{
	
		JSONArray agmtdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return agmtdata;
		}
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and agmt.cldocno="+cldocno;
			}
			if(!date.equalsIgnoreCase("") && date!=null){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqldate!=null){
				sqltest+=" and agmt.invtodate='"+sqldate+"'";
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and agmt.brhid="+branch;
			}
			/*String strsql="select a.brhid,a.voc_no,a.rano,'LAG' ratype,a.cldocno,a.invdate fromdate,a.invtodate todate,head.curid,head.account,head.doc_no acno,head.description acname,"+
			" round((a.datediff/a.monthcal)*a.rate,2) rentalsum,round((a.datediff/a.monthcal)*a.inssum,2) insurchg,round((a.datediff/a.monthcal)*a.accsum,2) accsum,"+
			" round((a.datediff/a.monthcal)*a.rate,2)+round((a.datediff/a.monthcal)*a.inssum,2)+round((a.datediff/a.monthcal)*a.accsum,2) amount from ("+
			" select agmt.brhid,agmt.voc_no,agmt.doc_no rano,agmt.cldocno,if((select method from gl_config where field_nme='lesmonthlycal')=1,"+
			" day(last_day(agmt.invtodate)),(select value from gl_config where field_nme='lesmonthlycal')) monthcal,ltf.rate,"+
			" (ltf.cdw+ltf.pai+ltf.cdw1+ltf.pai1) inssum,(ltf.gps+ltf.babyseater+ltf.cooler) accsum,agmt.invdate,agmt.invtodate,"+
			" datediff(invtodate,invdate) datediff from gl_lagmt agmt left join gl_ltarif ltf on agmt.doc_no=ltf.rdocno  where agmt.clstatus=0 "+sqltest+")a "+
			" left join my_acbook ac on (a.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no";*/
			
			String strsql="select a.brhid,a.voc_no,a.rano,'LAG' ratype,a.cldocno,a.invdate fromdate,a.invtodate todate,head.curid,head.account,head.doc_no acno,head.description acname,"+
			" round((a.datediff/a.monthcal)*a.rate,2) rentalsum,round((a.datediff/a.monthcal)*a.inssum,2) insurchg,round((a.datediff/a.monthcal)*a.accsum,2) accsum,"+
			" round((a.datediff/a.monthcal)*a.rate,2)+round((a.datediff/a.monthcal)*a.inssum,2)+round((a.datediff/a.monthcal)*a.accsum,2) amount from ("+
			" select agmt.brhid,agmt.voc_no,agmt.doc_no rano,agmt.cldocno,if((select method from gl_config where field_nme='lesmonthlycal')=1,"+
			" day(last_day(agmt.invtodate)),(select value from gl_config where field_nme='lesmonthlycal')) monthcal,ltf.rate,"+
			" (ltf.cdw+ltf.pai+ltf.cdw1+ltf.pai1) inssum,(ltf.gps+ltf.babyseater+ltf.cooler) accsum,agmt.invdate,agmt.invtodate,"+
			" datediff(invtodate,invdate) datediff from gl_lagmt agmt left join gl_ltarif ltf on agmt.doc_no=ltf.rdocno  where agmt.clstatus=0 "+sqltest+" )a "+
			" left join my_acbook ac on (a.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no"+
			" union all"+
			" select a.brhid,a.doc_no rano,a.voc_no,'LAG' ratype,a.cldocno,a.invdate fromdate,a.invtodate todate,head.curid,head.account,head.doc_no acno,"+
			" head.description acname,round(sum(a.rate),2) rentalsum,round(sum(a.inssum),2) insurchg,round(sum(a.accsum),2) accsum,round(sum(a.rate),2)+"+
			" round(sum(a.inssum),2)+round(sum(a.accsum),2) amount from ("+
			" select agmt.brhid,agmt.doc_no,agmt.voc_no,agmt.cldocno,calc.oldinvdate invdate,calc.oldinvtodate invtodate,calc.rdocno,if(calc.idno=1,amount,0.0) rate,"+
			" if(calc.idno=2,amount,0.0) accsum,if(calc.idno=17,amount,0.0) inssum,if((select method from gl_config where field_nme='lesmonthlycal')=1,"+
			" day(last_day(agmt.invtodate)),(select value from gl_config where field_nme='lesmonthlycal')) monthcal from gl_lagmt agmt left join gl_lcalc calc "+
			" on agmt.doc_no=calc.rdocno left join gl_lagmtclosem closem on agmt.doc_no=closem.agmtno where agmt.brhid="+branch+" and closem.indate<='"+sqldate+"' and agmt.clstatus=1"+
			" and calc.calcstatus=1 and calc.afterclose=0 and calc.amount>0 and calc.idno in (1,2,17) and agmt.cldocno="+cldocno+" group by calc.rdocno,idno)a "+
			" left join my_acbook ac on (a.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no group by a.rdocno";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			agmtdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return agmtdata;
	}


	public int insert(String selectedagmt, String cmbtype,
			String hidclient, Date sqldate,String cmbbranch,ArrayList<String> agmtarray,String date, HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ClsManualInvoiceDAO invoicedao=new ClsManualInvoiceDAO();
		int invdocno=0;
		int errorstatus=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			
			Statement stmt=conn.createStatement();
			double finalamt=0.0,rentalamt=0.0,accamt=0.0,insuramt=0.0,currencyrate=0.0;
			int acno=0,brhid=0,rentalid=0,accid=0,insurid=0,rentalacno=0,accacno=0,insuracno=0,agmtno=0,cldocno=0;
			String currencyid="",acname="";
			java.sql.Date duedate=null;
			/*rano+"::"+ratype+"::"+fromdate+"::"+todate+"::"+acno+"::"+amount+"::"+cldocno+"::"+rentalsum+"::"+accsum+"::"+datediff+"::"+brhid+"::"+curid+"::"+insurchg*/
			
			for(int i=0;i<agmtarray.size();i++){
				finalamt+=Double.parseDouble(agmtarray.get(i).split("::")[5]);
				rentalamt+=Double.parseDouble(agmtarray.get(i).split("::")[7]);
				accamt+=Double.parseDouble(agmtarray.get(i).split("::")[8]);
				insuramt+=Double.parseDouble(agmtarray.get(i).split("::")[12]);
				acno=Integer.parseInt(agmtarray.get(i).split("::")[4]);
				currencyid=agmtarray.get(i).split("::")[11];
				acname=agmtarray.get(i).split("::")[13];
				agmtno=Integer.parseInt(agmtarray.get(i).split("::")[0]);
				cldocno=Integer.parseInt(agmtarray.get(i).split("::")[6]);
				String stracperiod="select DATE_ADD(if('"+sqldate+"' is null,null,'"+sqldate+"'), INTERVAL (select period2 from my_acbook where cldocno="+cldocno+" and dtype='CRM') DAY) duedate";
				System.out.println(stracperiod);
				ResultSet rsacperiod=stmt.executeQuery(stracperiod);
				while(rsacperiod.next()){
					duedate=rsacperiod.getDate("duedate");
				}			

			}
			if(finalamt>0){
				String stracno="select (select acno from gl_invmode where idno=1) rentalacno,(select acno from gl_invmode where idno=2) accacno,"+
				"(select acno from gl_invmode where idno=17) insuracno";
				ResultSet rsacno=stmt.executeQuery(stracno);
				while(rsacno.next()){
					rentalid=1;
					rentalacno=rsacno.getInt("rentalacno");
					accid=2;
					accacno=rsacno.getInt("accacno");
					insurid=17;
					insuracno=rsacno.getInt("insuracno");
					
				}
				
				ResultSet rscurr=stmt.executeQuery("select c_rate from my_curr where doc_no='"+currencyid+"'");
				if(rscurr.next()){
					currencyrate=rscurr.getDouble("c_rate");
				}
				else{
					System.out.println("Currency Error");
					errorstatus=1;
					return 0;
				}
				String strgetmonthname="select concat(monthname('"+sqldate+"'),' ',year('"+sqldate+"')) monthname,DATE_SUB('"+sqldate+"', INTERVAL DAYOFMONTH('"+sqldate+"')-1 DAY) firstday";
				String monthname="";
				java.sql.Date sqlfirstday=null;
				ResultSet rsmonthname=stmt.executeQuery(strgetmonthname);
				while(rsmonthname.next()){
					monthname=rsmonthname.getString("monthname");
					sqlfirstday=rsmonthname.getDate("firstday");
				}
				ArrayList<String> invoicearray=new ArrayList<>();
				String note="Lease Invoice of "+acname+" for "+monthname+"";
				if(rentalamt>0.0){
					invoicearray.add(rentalid+"::"+rentalacno+"::"+note+"::"+agmtarray.size()+"::"+rentalamt+"::"+rentalamt);
				}
				if(accamt>0.0){
					invoicearray.add(accid+"::"+accacno+"::"+note+"::"+agmtarray.size()+"::"+accamt+"::"+accamt);
				}
				if(insuramt>0.0){
					invoicearray.add(insurid+"::"+insuracno+"::"+note+" "+"::"+agmtarray.size()+"::"+insuramt+"::"+insuramt);
				}
				
				//Inserting into Master Invoice Table
				CallableStatement stmtManual = conn.prepareCall("{call invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
				stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
				stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
				stmtManual.setDate(1,sqldate);
				stmtManual.setString(2,"LAG");
				stmtManual.setString(3,cldocno+"");
				stmtManual.setInt(4, agmtno);
				stmtManual.setString(5,note);
				stmtManual.setString(6,note);
				stmtManual.setString(7,currencyid);
				stmtManual.setString(8,acno+"");
				stmtManual.setDate(9,sqlfirstday);
				stmtManual.setDate(10,sqldate);
				stmtManual.setString(11,"INV");
				stmtManual.setString(12,session.getAttribute("USERID").toString());
				stmtManual.setString(13,cmbbranch);
				stmtManual.setString(16,"A");
				//		System.out.println(stmtManual);
				stmtManual.executeQuery();
				invdocno=stmtManual.getInt("docNo");
				int invtrno=stmtManual.getInt("vtrNo");
				request.setAttribute("INVTRNO", invtrno);
				
				
				//Updating Manual of Invoice
				String strupdatemanual="update gl_invm set manual=11 where doc_no="+invdocno;
				int updatemanual=stmt.executeUpdate(strupdatemanual);
				if(updatemanual<0){
					errorstatus=1;
					return 0;
				}
				
				//Inserting Detail Data
				int tempno=1;
				for(int i=0;i<invoicearray.size();i++){
					System.out.println("Displaying Invoice Array Data "+invoicearray.get(i));
					String invoice[]=invoicearray.get(i).split("::");
					if(!invoice[5].equalsIgnoreCase("") && !invoice[5].equalsIgnoreCase("undefined") && invoice[5]!=null){
						
						double testldramt=currencyrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
						double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
						double partyldramt=testldramt*-1;
						String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+cmbbranch+"','"+invdocno+"'"+
								 ",'"+invtrno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
						int detailinsert=stmt.executeUpdate(sql);
						if(detailinsert<0){
							errorstatus=1;
							return 0;
						}
						tempno++;
						//Inserting to Lcalc
						/*
						String strlcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+cmbbranch+"','"+invtrno+"',"+
								 "'"+agmtno+"','LAG','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+invdocno+"','"+sqldate+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
						int lcalcinsert=stmt.executeUpdate(strlcalc);
						if(lcalcinsert<0){
							errorstatus=1;
							return 0;
						}*/
						
						
						String strjvcompany="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								 "doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,costtype,costcode)values('"+invtrno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
								 "'"+partydramt+"','"+currencyrate+"','"+currencyid+"',0,-1,'"+(i+1)+"',"+
								 "'"+cmbbranch+"','"+note+"',"+
								 "0,'"+sqldate+"','INV','"+partyldramt+"','"+invdocno+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
								 "'"+currencyid+"','5',1,0,3,'"+agmtno+"','LAG',7,9999)";
						int sqljvcompany=stmt.executeUpdate(strjvcompany);
						if(sqljvcompany<0){
							errorstatus=1;
							return 0;
						}
						
					}
				}
				
				//Inserting Every Master Data
				
				boolean masterstatus=customAgmtInsert(conn,session,request,agmtarray,invdocno,invtrno,sqldate);
				System.out.println("Agmt Master Status: "+masterstatus);
				if(masterstatus==false){
					
					return 0;
				}
				
				boolean mastercosttran=customCosttranInsert(conn,session,request,agmtarray,invdocno,invtrno,sqldate);
				if(mastercosttran==false){
					return 0;
				}
				
				if(finalamt>0){

					double ramt=Math.round(finalamt);
					double ramtldr=ramt*currencyrate;
					double discount = (finalamt-ramt);
					discount=objcommon.Round(discount, 2);
					double discountldr=discount*currencyrate;
					Statement stmtdiscount=conn.createStatement();
					String strdiscount="select acno discountacno from gl_invmode where idno=13";
					ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
					int  discac=0;
					while(rsdiscount.next()){
						discac=rsdiscount.getInt("discountacno");
					}
					if(discount!=0.0){
						Statement stmtdiscjv=conn.createStatement();
						Statement stmtdiscinvd=conn.createStatement();
						String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+cmbbranch+"','"+invdocno+"'"+
						",'"+invtrno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
						int discinvd=stmtdiscinvd.executeUpdate(sql);
						if(discinvd<=0){
							stmtdiscinvd.close();
							stmtdiscjv.close();
							stmtdiscount.close();
							//conn.close();
							return 0;
						}
						stmtdiscinvd.close();
						int discid=0;
						if(discount>0.0){
							discid=1;
						}
						else if(discount<0.0){
							discid=-1;
						}
						String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+invtrno+"','"+discac+"',"+
						"'"+discount+"','"+currencyrate+"','"+currencyid+"',0,"+discid+",1,'"+cmbbranch+"','Discount',"+
						"0,'"+sqldate+"','INV','"+discountldr+"','"+invdocno+"','"+note+"','"+currencyid+"','5',1,"+cldocno+",3,'"+agmtno+"','LAG','"+duedate+"')";
						int discval=stmtdiscjv.executeUpdate(sqljvdisc);
						if(discval<=0){
							stmtdiscjv.close();
							stmtdiscount.close();
							//conn.close();
							return 0;
						}
						stmtdiscjv.close();
						stmtdiscount.close();
					}

					String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+invtrno+"','"+acno+"',"+
					"'"+ramt+"','"+currencyrate+"','"+currencyid+"',0,1,1,'"+cmbbranch+"','"+note+"',"+
					"0,'"+sqldate+"','INV','"+ramtldr+"','"+invdocno+"',1,'"+currencyid+"','5',1,"+cldocno+",3,'"+agmtno+"','LAG','"+duedate+"')";
					int rsjv=stmt.executeUpdate(sqljv);
					if(rsjv>0){
						
					}
					else{
						System.out.println("General jvtran error");
						//conn.close();
						return 0;
					}
					stmtdiscount.close();
				
					if (invdocno > 0) {
						
						String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+invtrno;
						ResultSet rstestjv=stmt.executeQuery(testjv);
						while(rstestjv.next()){
							if(rstestjv.getDouble("dramount")==0.00){
								stmt.close();
								stmtManual.close();
								conn.commit();
								return invdocno;
							}
							else{
								stmt.close();
								stmtManual.close();
								//conn.close();
								System.out.println("Jv tally Error");
								return 0;
							}
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
			conn.close();
		}
		return invdocno;
	}


	private boolean customCosttranInsert(Connection conn, HttpSession session,
			HttpServletRequest request, ArrayList<String> agmtarray,
			int invdocno, int invtrno, Date sqldate) throws SQLException {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			int rentalid=0,rentalacno=0,accid=0,accacno=0,insurid=0,insuracno=0;
			int rentaltranid=0,acctranid=0,insurtranid=0;
			
			String stracno="select (select head.doc_no from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=1) rentalacno,"+
			" (select head.doc_no from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=2) accacno,"+
			" (select head.doc_no from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=17) insuracno";
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				rentalid=1;
				rentalacno=rsacno.getInt("rentalacno");
				accid=2;
				accacno=rsacno.getInt("accacno");
				insurid=17;
				insuracno=rsacno.getInt("insuracno");
			}
			
			 
			 
			/*String strgettranid="select (select tranid from my_jvtran where tr_no="+invtrno+" and acno="+rentalacno+") rentaltranid,"+
			" (select tranid from my_jvtran where tr_no="+invtrno+" and acno="+accacno+") acctranid,"+
			" (select tranid from my_jvtran where tr_no="+invtrno+" and acno="+insuracno+") insurtranid";*/
			String strgettranid="select coalesce(rentaltranid,0) rentaltranid,coalesce(acctranid,0) acctranid,coalesce(insurtranid,0) insurtranid "+
			" from ("+
			" select (select tranid from my_jvtran where tr_no="+invtrno+" and acno="+rentalacno+") rentaltranid,"+
			" (select tranid from my_jvtran where tr_no="+invtrno+" and acno="+accacno+") acctranid,"+
			" (select tranid from my_jvtran where tr_no="+invtrno+" and acno="+insuracno+") insurtranid)a";
			System.out.println(strgettranid);
			ResultSet rsgettranid=stmt.executeQuery(strgettranid);
			while(rsgettranid.next()){
				rentaltranid=rsgettranid.getInt("rentaltranid");
				acctranid=rsgettranid.getInt("acctranid");
				insurtranid=rsgettranid.getInt("insurtranid");
			}
			System.out.println("Rental Tranid: "+rentaltranid);
			 int srno=1;
			String strgetagmt="select round(curr.c_rate,2) rate,inv.agmtno,inv.fromdate,inv.todate,inv.amount,inv.rentalamt,inv.accamt,inv.insuramt,inv.cldocno,inv.curid from gl_inveasylease inv left join my_curr curr on inv.curid=curr.doc_no where invdocno="+invdocno+" and inv.status=3";
			ResultSet rsgetagmt=stmt.executeQuery(strgetagmt);
			while(rsgetagmt.next()){
				java.sql.Date sqlfromdate=rsgetagmt.getDate("fromdate");
				java.sql.Date sqltodate=rsgetagmt.getDate("todate");
				int agmtno=rsgetagmt.getInt("agmtno");
				double rentalamt=rsgetagmt.getDouble("rentalamt");
				double accamt=rsgetagmt.getDouble("accamt");
				double insuramt=rsgetagmt.getDouble("insuramt");
				double currencyrate=rsgetagmt.getDouble("rate");
				srno=costtranProcess(conn,sqlfromdate,sqltodate,agmtno,rentalamt,accamt,insuramt,invdocno,invtrno,srno,rentaltranid,acctranid,insurtranid,rentalid,rentalacno,accid,accacno,insurid,insuracno,currencyrate);
				if(srno==0){
					return false;
				}
				//srno++;
			}
		}
		
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}
		return true;
	}


	private int costtranProcess(Connection conn, Date sqlfromdate,
			Date sqltodate, int agmtno, double rentalamt, double accamt,
			double insuramt, int invdocno, int invtrno,int srno, int rentaltranid, int acctranid, int insurtranid, int rentalid, int rentalacno, int accid, int accacno, int insurid, int insuracno, double currencyrate) throws SQLException {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			int delcal=0;
			 //Deciding outddate or deliverydate
			 String strdelcal="select method from gl_config where field_nme='delcal'";
			 ResultSet rsdelcal=stmt.executeQuery(strdelcal);

			 while(rsdelcal.next()){
				 delcal=rsdelcal.getInt("method");
			 }
			//Update Invdate
			Statement stmtinner=conn.createStatement();
			double invtype=0;
			 String todatecalc="";
			 int monthcalmethod=0;
			 int monthcalvalue=0;
			 //		System.out.println("Origin: "+origin+"//////");

			 //Extra Block for updating agmt invtodate in case of agreement started in monthend
			 
			 String strcheckdate="";
			 java.sql.Date temptodate=null;
			 //when delivery date must be considered
			 if(delcal==0){
				 strcheckdate="select if(delivery=1 and delstatus=1,(select min(din) from gl_vmove where rdocno="+agmtno+" and rdtype='LAG' and "+
							 "  trancode='DL' and repno=0),outdate) temptodate from gl_lagmt where doc_no="+agmtno;	
				 
			 }
			 //When Outdate is considered
			 else{
				strcheckdate="select outdate temptodate from gl_lagmt where doc_no="+agmtno;
				
			 }
			 //System.out.println("Check Date Query: "+strcheckdate);
			 ResultSet rstemptodate=stmtinner.executeQuery(strcheckdate);
			 while(rstemptodate.next()){
				 temptodate=rstemptodate.getDate("temptodate");
			 }

			 int samedatestatus=0;
			 String strchecksame="";
			 int startday=0;
			 int closestatus=0;
			 //System.out.println("Check invtype: "+invtype);
			 
			 ResultSet rsgetinvtype=stmtinner.executeQuery("select inv_type,clstatus from gl_lagmt where doc_no="+agmtno);
			 if(rsgetinvtype.next()){
				 invtype=rsgetinvtype.getDouble("inv_type");
				 closestatus=rsgetinvtype.getInt("clstatus");
			 }
			 
			 if(invtype==2){
				 //Checking Out Date and Month End of Out date is same
				 strchecksame="select if('"+temptodate+"'=last_day('"+temptodate+"'),1,0) samedatestatus,day('"+temptodate+"') startday";
				 //System.out.println("Check Same Date Query: "+strchecksame);
				 ResultSet rssamedatestatus=stmtinner.executeQuery(strchecksame);
				 while(rssamedatestatus.next()){
					 samedatestatus=rssamedatestatus.getInt("samedatestatus");
					 startday=rssamedatestatus.getInt("startday");
				 }
			 }
			 //Extra Block for updating agmt invtodate in case of agreement started in monthend Ends

			 /**
			  * 
			  * invoice agreements with zero value
			  * 05 august 2017
			  */
			  // if(rentalamt>0.0){
				
					 String tempdate="'"+sqltodate+"'";
					 ResultSet rsgetmonthcal=stmtinner.executeQuery("select method,value from GL_CONFIG WHERE FIELD_NME='lesmonthlycal'");
					 while(rsgetmonthcal.next()){
						 monthcalmethod=rsgetmonthcal.getInt("method");
						 monthcalvalue=rsgetmonthcal.getInt("value");
					 }
					 if(monthcalmethod==1){
						 if(invtype==1){
							 todatecalc="SELECT LAST_DAY(DATE_ADD('"+sqltodate+"',INTERVAL 1 month))";
						 }
						 if(invtype==2){
							 todatecalc="DATE_ADD('"+sqltodate+"',INTERVAL 1 month)";
						 }
					 }
					 else if(monthcalmethod==0){
						 if(invtype==1){
							 todatecalc="SELECT LAST_DAY(DATE_ADD('"+sqltodate+"',INTERVAL 1 month))";
						 }
						 if(invtype==2){
							 todatecalc="DATE_ADD('"+sqltodate+"',INTERVAL '"+monthcalvalue+"' DAY)";
						 }
					 }

					 if(samedatestatus==1 && invtype==2 && monthcalmethod==0){
						 todatecalc="select LAST_DAY(("+todatecalc+"))";

						 todatecalc="select if("+startday+">(select day(("+todatecalc+"))),"+
								 " (SELECT DATE_ADD('"+sqltodate+"',INTERVAL 1 month)),(select LAST_DAY((SELECT DATE_ADD('"+sqltodate+"',INTERVAL 1 month)))))";	

					 }

					 if(closestatus==0){
						 String strupdate="update gl_lagmt set invdate='"+sqltodate+"',invtodate=("+todatecalc+") where doc_no="+agmtno;

						 int agmtupdate=stmt.executeUpdate(strupdate);
						 if(agmtupdate<0){
							 System.out.println("Lagmt Error");
							 return 0;
						 }
					 }
				 // }


			ArrayList<String> invoicearray=new ArrayList<>();
			if(rentalamt>0.0){
				invoicearray.add(rentalid+"::"+rentalacno+"::Lease Invoice::"+"1 Month"+"::"+rentalamt+"::"+rentalamt);
			}
			if(accamt>0.0){
				invoicearray.add(accid+"::"+accacno+"::Lease Invoice::"+"1 Month"+"::"+accamt+"::"+accamt);
			}
			if(insuramt>0.0){
				invoicearray.add(insurid+"::"+insuracno+"::Lease Invoice::"+"1 Month"+"::"+insuramt+"::"+insuramt);
			}
			
			for(int i=0;i<invoicearray.size();i++){
				int temptranid=0;
				
				String invoice[]=invoicearray.get(i).split("::");
				
				double testldramt=currencyrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
				double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
				double partyldramt=testldramt*-1;
				Statement stmtcostentry=conn.createStatement();
				String strcostentry="select costentry from gl_invmode where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1]);
				int costentry=0;
				ResultSet rscostentry=stmtcostentry.executeQuery(strcostentry);
				while(rscostentry.next()){
					costentry=rscostentry.getInt("costentry");
				}
				if(costentry==1){
					
					int count=0;
					ArrayList<String> costmovarray=new ArrayList<String>();
					Statement stmtcostmov=conn.createStatement();
					double temptimediff=0.0;
					String tempcostfleet="";
					String strtemptimediff="select (TIMESTAMPDIFF(second,'"+sqlfromdate+" 00:00:00' ,'"+sqltodate+" 23:59:59'))/(60*60) temptimediff";
					Statement stmttemptimediff=conn.createStatement();
								System.out.println("TemptimeDiff Sql:"+strtemptimediff);
					ResultSet rstemptimediff=stmtcostmov.executeQuery(strtemptimediff);
					while(rstemptimediff.next()){
						temptimediff=rstemptimediff.getDouble("temptimediff");

					}
					System.out.println("TimeDiffer In Hours:"+temptimediff);
					stmttemptimediff.close();
					String strcostmov="";
					strcostmov="select sum(aa.hourdiff) hourdiff,aa.fleet_no from("+
								 " select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno from ("+
								 " select repno,fleet_no,if(dout<'"+sqlfromdate+"',cast(concat('"+sqlfromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout) as datetime))"+
								 " dout,tout,if(din>'"+sqltodate+"',cast(concat('"+sqltodate+" 23:59:59') as datetime),cast(coalesce(concat(din,' ',tin),'"+sqltodate+" 23:59:59') as datetime)) din,tin"+
								 " from gl_vmove where rdocno="+agmtno+" and rdtype='LAG'  and trancode<>'DL'  and (dout between '"+sqlfromdate+"' and '"+sqltodate+"' or  coalesce(din,'"+sqltodate+"')"+
								 " between '"+sqlfromdate+"' and '"+sqltodate+"')) kk)aa group by aa.fleet_no ";
					ResultSet rscostmov=stmtcostmov.executeQuery(strcostmov);
					int counter=0;
					while(rscostmov.next()){
						costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
						counter++;
					}
					stmtcostmov.close();
					
					for(int j=0;j<costmovarray.size();j++){
						 				//System.out.println("============================================="+j);
						 if(counter==1){
							 Statement stmtcostinsert=conn.createStatement();
							 String costmov=costmovarray.get(j);
							 String costmovamt=costmov.split("::")[0];
							 String costmovfleet=costmov.split("::")[1];
							 if(Integer.parseInt(invoice[1])==rentalacno){
								 System.out.println("Rental"+Integer.parseInt(invoice[1])+"::"+rentalacno);
								 temptranid=rentaltranid;
							 }
							 else if(Integer.parseInt(invoice[1])==accacno){
								 System.out.println("Acc"+Integer.parseInt(invoice[1])+"::"+accacno);
								 temptranid=acctranid;
							 }
							 else if(Integer.parseInt(invoice[1])==insuracno){
								 System.out.println("Insur"+Integer.parseInt(invoice[1])+"::"+insuracno);
								 temptranid=insurtranid;
							 }
							 System.out.println("Tranid: "+temptranid);
							 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
									 ",6,"+partydramt+","+srno+","+temptranid+",0,"+costmovfleet+","+invtrno+")";
							 //System.out.println("Insert Costtran Sql:"+strcostinsert);
							 srno++;
							 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
							 if(costinsertval<0){
								 //conn.close();
								 System.out.println("Cost Insert Error");
								 return 0;
							 }

						 }
						 else if(counter>1){
							 Statement stmtcostinsert=conn.createStatement();
							 String costmov=costmovarray.get(j);
							 String costmovamt=costmov.split("::")[0];
							 String costmovfleet=costmov.split("::")[1];
							 double amt=(Double.parseDouble(costmovamt)/temptimediff)*partydramt;
							 if(Integer.parseInt(invoice[1])==rentalacno){
								 System.out.println("Rental"+Integer.parseInt(invoice[1])+"::"+rentalacno);
								 temptranid=rentaltranid;
							 }
							 else if(Integer.parseInt(invoice[1])==accacno){
								 System.out.println("Acc"+Integer.parseInt(invoice[1])+"::"+accacno);
								 temptranid=acctranid;
							 }
							 else if(Integer.parseInt(invoice[1])==insuracno){
								 System.out.println("Insur"+Integer.parseInt(invoice[1])+"::"+insuracno);
								 temptranid=insurtranid;
							 }
							 System.out.println("Tranid: "+temptranid);
							 //System.out.println("Total Amt:"+amt+":::costmovamt="+costmovamt+":::::::::TempTime Diff="+temptimediff+":::::::::Amount="+partydramt);
							 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
									 ",6,"+amt+","+srno+","+temptranid+",0,"+costmovfleet+","+invtrno+")";
							 		//System.out.println("Insert Costtran Sql:"+strcostinsert);
							 srno++;
							 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
							 if(costinsertval<0){
								 //conn.close();
								 System.out.println("Cost Insert Error2");
								 return 0;
							 }

						 }
					 }

				 }
				 else{

				 }
				
			}
		
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return srno;
	}


	private boolean customAgmtInsert(Connection conn, HttpSession session,
			HttpServletRequest request, ArrayList<String> agmtarray,
			int invdocno, int invtrno, Date sqldate) throws SQLException {
		// TODO Auto-generated method stub
		
		try{
			Statement stmt=conn.createStatement();
			for(int i=0;i<agmtarray.size();i++){
				System.out.println(agmtarray.get(i));
				String temp[]=agmtarray.get(i).split("::");
				java.sql.Date sqlfromdate=null;
				java.sql.Date sqltodate=null;
				if(!temp[2].equalsIgnoreCase("") && !temp[2].equalsIgnoreCase("undefined") && temp[2]!=null){
					sqlfromdate=objcommon.changeStringtoSqlDate(temp[2]);
				}
				if(!temp[3].equalsIgnoreCase("") && !temp[3].equalsIgnoreCase("undefined") && temp[3]!=null){
					sqltodate=objcommon.changeStringtoSqlDate(temp[3]);
				}
				/*rano+"::"+ratype+"::"+fromdate+"::"+todate+"::"+acno+"::"+amount+"::"+cldocno+"::"+rentalsum+"::"+accsum+"::"+datediff+"::"+brhid+"::"+curid+"::"+insurchg+"::"+acname);*/
				String strsql="insert into gl_inveasylease(agmtno,fromdate,todate,amount,rentalamt,accamt,insuramt,cldocno,invdocno,invtrno,brhid,curid)values("+temp[0]+",'"+sqlfromdate+"','"+sqltodate+"',"+temp[5]+","+temp[7]+","+temp[8]+","+temp[12]+","+temp[6]+","+invdocno+","+invtrno+","+temp[10]+","+temp[11]+")";
				System.out.println(strsql);
				int val=stmt.executeUpdate(strsql);
				if(val<=0){
					System.out.println("Agmt Insert Error");
					return false;
				}
				
				
				/*
				 * Marking As Invoiced for already closed
				 * Only for EasyLease
				 * */
				
				//Checking Agreement is closed
				
				String stragmt="select clstatus from gl_lagmt where doc_no="+temp[0];
				int clstatus=0;
				ResultSet rsclstatus=stmt.executeQuery(stragmt);
				while(rsclstatus.next()){
					clstatus=rsclstatus.getInt("clstatus");
				}
				
				if(clstatus==1){
					//Update afterclose in gl_lcalc
					String strafterclose="update gl_lcalc set afterclose=1 where rdocno="+temp[0]+" and calcstatus=1";
					int afterclose=stmt.executeUpdate(strafterclose);
					if(afterclose<=0){
						System.out.println("After Close Update Error");
						return false;
					}
				}
				
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}
		
		return true;
	}
		
		
	}

