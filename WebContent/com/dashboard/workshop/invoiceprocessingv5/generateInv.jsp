<%@page import="com.dashboard.workshop.invoiceprocessingv5.*"%>
<%@page import="java.util.ArrayList"%>
<%-- <%@page import="com.workshop.wsinvoice.ClsWSInvoiceDAO"%> --%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String strinvoicearray=request.getParameter("invoicearray")==null?"":request.getParameter("invoicearray");
String seccldocno=request.getParameter("seccldocno")==null?"":request.getParameter("seccldocno");
String invvoucher="";
int errorstatus=0;
try{
	System.out.println("Job card:"+jobdocno);
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	/* ClsWSInvoiceDAO invoicedao=new ClsWSInvoiceDAO(); */
	ClsInvProcessingV5DAO processdao=new ClsInvProcessingV5DAO();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	ArrayList<String>invarray=new ArrayList();
	
	for(int i=0;i<strinvoicearray.split(",").length;i++){
		invarray.add(strinvoicearray.split(",")[i]);
		System.out.println(invarray.get(i));
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
	for(int i=0;i<invarray.size();i++){
		String temp[]=invarray.get(i).split("::");
		int rowno=Integer.parseInt(temp[0].trim());
		int invoicetoacno=Integer.parseInt(temp[2].trim());
		String description=temp[4].trim();
		String remarks="";
		if(!temp[13].trim().equalsIgnoreCase("undefined") && temp[13]!=null && !temp[13].trim().equalsIgnoreCase("")){
			remarks=temp[13].trim();	
		}
		//Getting Corresponding cldocno
		String strclient="select cldocno from my_acbook where status=3 and acno="+invoicetoacno;
		ResultSet rsclient=conn.createStatement().executeQuery(strclient);
		while(rsclient.next()){
			cldocno=rsclient.getInt("cldocno");
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
		double nontaxamt=objcommon.Round(Double.parseDouble(temp[15].trim()), 2);
		
	//	System.out.println("====="+amount+"==="+discount+"==="+net+"==="+vat+"==="+total+"==="+excess+"==="+roundoff+"==="+netbill);
		ArrayList<String>invoicearray=new ArrayList();
		String descar[]=description.split("###");
		invoicearray.add(descar[0].trim()+"::"+(amount+nontaxamt));
		for(int l=1;l<descar.length;l++){
			System.out.println("====="+descar[l]);
			invoicearray.add(descar[l].trim()+"::0.0");
		}
		
		if(!invdate.equalsIgnoreCase("")){
			sqldate=objcommon.changeStringtoSqlDate(invdate);	
		}
		
		/* invoicedao.insert(sqldate, cmbreftype, hidrefno, cldocno, invoicetoacno, excessamountacno, total, discount, excessamount, nettotal,
				remarks, session, request, mode, formdetailcode, branch, invoicearray, conn, taxpercent, taxamount, taxtotal, 
				hidchksaperateinvoice, billtoacno); */
				
/* 		
System.out.println("====="+sqldate+ "JC"+ jobdocno +" = "+ cldocno +" = "+ invoicetoacno +" = "+ "0" +" = "+ amount+"", discount+"", excess+"", net+"", description, 
				session, request, "A", "MNT", branch, invoicearray, conn, "5", vat+"", total+"", "0",invoicetoacno+"",roundoff,netbill);
 */		
 		
 		request.setAttribute("WSINVCALCNO",rowno);
		int value=processdao.insertWorkshopInvoice(sqldate, "JC", jobdocno, cldocno+"", invoicetoacno+"", "0", (amount+nontaxamt)+"", discount+"", 0+"", (net+nontaxamt)+"", remarks, 
		session, request, "A", "MNT", branch, invoicearray, conn, "5", vat+"", (total+nontaxamt)+"", "0",invoicetoacno+"",roundoff,netbill);
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
				String strins="select insurtypedocno, nontaxamt +nettotal nettotal,round(((nettotal+nontaxamt)/(select round(sum(nettotal+nontaxamt),2) from ws_investdata where jobdocno="+ARjob.get(q).toString().split("::")[0]+" and addition in ("+ARjob.get(q).toString().split("::")[1]+")))* "
						+" (select sum(netamount+nontaxamt) from ws_invcalctemp where invno="+value+" and jobdocno="+ARjob.get(q).toString().split("::")[0]+"),2) insamt from ws_investdata"+ 
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
" lab.approved=1  and lab.addition in ("+detaddition+") and lab.chkcomplete=1 and lab.seccldocno="+seccldocno+" "+
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
" where card.doc_no="+jobcarddocno+" and card.status=3  and jcc.addition in ("+detaddition+") and jcc.lumsumstatus=0   and jcc.seccldocno="+seccldocno+"  and jcc.dettype='esp' and jcc.chkcomplete=1 "+ 
		" union all select est.doc_no estdocno,jcc.addition,@j:=0 count,if(jcc.description='',m.productname,jcc.description) description, round(coalesce(jcc.qty,0),2) qty, round(coalesce(jcc.customeramt,0)/coalesce(jcc.qty,0),2) rate, 0 jobdiscount, round(coalesce(jcc.customeramt,0),2) jobtotal, round(coalesce(5,0),2) jobvatpercent, round(coalesce(jcc.customeramt*(5/100),0),2) jobvatamount, round(coalesce((jcc.customeramt*(5/100))+jcc.customeramt,0),2) jobnetamount, est.voc_no from ws_jobcard card left join ws_estm est on  (card.reftype='EST' and card.refno=est.doc_no) " 
		+" left join ws_jccspare jcc on est.doc_no=jcc.estdocno  left join my_main m on m.psrno=jcc.psrno "+ 
		" where card.doc_no="+jobcarddocno+" and card.status=3  and jcc.addition in ("+detaddition+") and jcc.lumsumstatus=0  and jcc.seccldocno="+seccldocno+" and jcc.dettype='gis' and jcc.chkcomplete=1 union all "+
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
" where card.doc_no="+jobcarddocno+" and card.status=3  and jcc.addition in ("+detaddition+") and jcc.lumsumstatus>0  and jcc.seccldocno="+seccldocno+")a";
			System.out.println(strsql);
			ResultSet rsgetdetail=stmt.executeQuery(strsql);
			ArrayList<String> detailarray=new ArrayList();
			while(rsgetdetail.next()){
				detailarray.add(rsgetdetail.getString("estdocno")+"::"+rsgetdetail.getString("addition")+"::"+rsgetdetail.getString("serialno")+"::"+rsgetdetail.getString("jobtype")+"::"+rsgetdetail.getString("description")+"::"+rsgetdetail.getString("qty")+"::"+rsgetdetail.getString("rate")+"::"+rsgetdetail.getString("jobdiscount")+"::"+rsgetdetail.getString("jobtotal")+"::"+rsgetdetail.getString("jobvatpercent")+"::"+rsgetdetail.getString("jobvatamount")+"::"+rsgetdetail.getString("jobnetamount"));
			}
			for(int detindex=0;detindex<detailarray.size();detindex++){
				String tempdet[]=detailarray.get(detindex).split("::");
				String estdocno=tempdet[0];
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
				"'"+type+"','"+serialno+"','"+desc+"',"+qty+","+rate+","+jobdiscount+","+jobtotal+","+jobvatpercent+","+jobvatamount+","+jobnetamount+","+estdocno+","+detadditon+","+jobcarddocno+","+value+")";
				int insertdetail=stmt.executeUpdate(strinsertdetail);
				if(insertdetail<=0){
					errorstatus=1;
					break;
				}
			}
			
		}
	}
	if(errorstatus==0){
		conn.commit();
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
response.getWriter().write(errorstatus+"::"+invvoucher);
%>