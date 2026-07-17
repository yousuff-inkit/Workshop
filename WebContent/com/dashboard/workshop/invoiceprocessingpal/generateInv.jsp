<%@page import="com.dashboard.workshop.invoiceprocessingpal.*"%>
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
String invvoucher="";
int errorstatus=0;
try{
	System.out.println("Job card:"+jobdocno);
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	/* ClsWSInvoiceDAO invoicedao=new ClsWSInvoiceDAO(); */
	ClsInvProcessingDAO processdao=new ClsInvProcessingDAO();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	ArrayList<String>invarray=new ArrayList();
	
	for(int i=0;i<strinvoicearray.split(",").length;i++){
		invarray.add(strinvoicearray.split(",")[i]);
		System.out.println(invarray.get(i));
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
		double amount=objcommon.Round(Double.parseDouble(temp[5].trim()), 2);
		double discount=objcommon.Round(Double.parseDouble(temp[6].trim()), 2);
		double net=objcommon.Round(Double.parseDouble(temp[7].trim()), 2);
		double vat=objcommon.Round(Double.parseDouble(temp[8].trim()), 2);
		double total=objcommon.Round(Double.parseDouble(temp[9].trim()), 2);
		double excess=objcommon.Round(Double.parseDouble(temp[10].trim()), 2);
		double roundoff=objcommon.Round(Double.parseDouble(temp[11].trim()), 2);
		double netbill=objcommon.Round(Double.parseDouble(temp[12].trim()), 2);
		double discountpercent=objcommon.Round(Double.parseDouble(temp[14].trim()), 2);
		
	//	System.out.println("====="+amount+"==="+discount+"==="+net+"==="+vat+"==="+total+"==="+excess+"==="+roundoff+"==="+netbill);
		ArrayList<String>invoicearray=new ArrayList();
		String descar[]=description.split("###");
		invoicearray.add(descar[0].trim()+"::"+amount)	;
		for(int l=1;l<descar.length;l++){
			System.out.println("====="+descar[l]);
			invoicearray.add(descar[l].trim()+"::0.0")	;
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
		
		/* invoicedao.insert(sqldate, cmbreftype, hidrefno, cldocno, invoicetoacno, excessamountacno, total, discount, excessamount, nettotal,
				remarks, session, request, mode, formdetailcode, branch, invoicearray, conn, taxpercent, taxamount, taxtotal, 
				hidchksaperateinvoice, billtoacno); */
				
/* 		
System.out.println("====="+sqldate+ "JC"+ jobdocno +" = "+ cldocno +" = "+ invoicetoacno +" = "+ "0" +" = "+ amount+"", discount+"", excess+"", net+"", description, 
				session, request, "A", "MNT", branch, invoicearray, conn, "5", vat+"", total+"", "0",invoicetoacno+"",roundoff,netbill);
 */		
		int value=processdao.insertWorkshopInvoice(sqldate, "JC", jobdocno, cldocno+"", invoicetoacno+"", "0", amount+"", discount+"", 0+"", net+"", remarks, 
		session, request, "A", "MNT", branch, invoicearray, conn, "5", vat+"", total+"", "0",invoicetoacno+"",roundoff,netbill);
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