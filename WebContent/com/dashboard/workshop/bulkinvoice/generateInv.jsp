<%@page import="com.dashboard.workshop.invoiceprocessing.ClsInvProcessingDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String invoicedate=request.getParameter("invoicedate")==null?"":request.getParameter("invoicedate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String strinvoicearray=request.getParameter("invoicearray")==null?"":request.getParameter("invoicearray");
String invvoucher="";
int errorstatus=0;
try{
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsInvProcessingDAO processdao=new ClsInvProcessingDAO();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqlinvoicedate=null;
	if(!invoicedate.equalsIgnoreCase("")){
		sqlinvoicedate=objcommon.changeStringtoSqlDate(invoicedate);
	}
	ArrayList<String>invarray=new ArrayList();
	for(int i=0;i<strinvoicearray.split(",").length;i++){
		invarray.add(strinvoicearray.split(",")[i]);
		System.out.println(invarray.get(i));
	}
	int invoicetoacno=0;
	String clientname="";
	String strgetacno="select acno,refname from my_acbook where cldocno="+cldocno+" and dtype='CRM'";
	ResultSet rsgetacno=stmt.executeQuery(strgetacno);
	while(rsgetacno.next()){
		invoicetoacno=rsgetacno.getInt("acno");
		clientname=rsgetacno.getString("refname");
	}
	ArrayList<String>invoicearray=new ArrayList();
	double amount=0.0,vat=0.0,discount=0.0,net=0.0,total=0.0,excess=0.0,roundoff=0.0,netbill=0.0;
	String strjobdocno="";
	
	for(int i=0;i<invarray.size();i++){
		String temp[]=invarray.get(i).split("::");
		int rowno=Integer.parseInt(temp[0].trim());
		//int invoicetoacno=Integer.parseInt(temp[2].trim());
		String description=temp[4].trim();
		int jobdocno=Integer.parseInt(temp[temp.length-1].trim());
		if(i==0){
			strjobdocno+=temp[temp.length-1].trim();
		}
		else{
			strjobdocno+=","+temp[temp.length-1].trim();
		}
		amount+=objcommon.Round(Double.parseDouble(temp[5].trim()), 2);
		discount+=objcommon.Round(Double.parseDouble(temp[6].trim()), 2);
		net+=objcommon.Round(Double.parseDouble(temp[7].trim()), 2);
		vat+=objcommon.Round(Double.parseDouble(temp[8].trim()), 2);
		total+=objcommon.Round(Double.parseDouble(temp[9].trim()), 2);
		excess+=objcommon.Round(Double.parseDouble(temp[10].trim()), 2);
		roundoff+=objcommon.Round(Double.parseDouble(temp[11].trim()), 2);
		netbill+=objcommon.Round(Double.parseDouble(temp[12].trim()), 2);
	//	system.out.println("====="+amount+"==="+discount+"==="+net+"==="+vat+"==="+total+"==="+excess+"==="+roundoff+"==="+netbill);
		//ResultSet rsjobvocno=conn.createStatement().executeQuery("select voc_no from ws_jobcard where docno="+jobdocno);
		invoicearray.add(temp[4].trim()+"::"+objcommon.Round(Double.parseDouble(temp[5].trim()), 2))	;
		
		String strupdate1="update ws_invcalctemp set description='"+temp[4]+"', amount="+temp[5]+", discount="+temp[6]+", netamount="+temp[7]+", vatamount="+temp[8]+", totalamount="+temp[9]+", excessamount="+temp[10]+", roundoff="+temp[11]+", netbill="+temp[12]+" where rowno="+rowno;
	}
	String description="Bulk Invoice of "+clientname;
	String firstjobcard=invarray.get(0).split("::")[invarray.get(0).split("::").length-1].trim();
	int value=processdao.insertWorkshopInvoice(sqlinvoicedate, "JC", firstjobcard, cldocno+"", invoicetoacno+"", "0", amount+"", discount+"", 0+"", net+"", description, 
	session, request, "A", "MNT", branch, invoicearray, conn, "5", vat+"", total+"", "0",invoicetoacno+"",roundoff,netbill);
	//System.out.println("Invoice Value: "+value);
	int invvocno=0;
			
	if(value<=0){
		errorstatus=1;
	}
	if(value>0){
		invvocno=Integer.parseInt(request.getAttribute("WSINVVOCNO").toString());
		String strupdate1="update ws_invcalctemp set invno="+value+" where jobdocno in ("+strjobdocno+")";
		System.out.println("Update Query: "+strupdate1);
		int updateval1=stmt.executeUpdate(strupdate1);
		if(updateval1<=0){
			errorstatus=1;	
		}
		String strgetclaimdata="select coalesce(claimno,'') claimno,coalesce(pono,'') pono,addition,jobdocno from ws_invcalctemp where invno="+value;
		String claimno="",lpono="";
		ArrayList ARjob=new ArrayList();
		ResultSet rsgetclaimdata=stmt.executeQuery(strgetclaimdata);
		while(rsgetclaimdata.next()){
			if(!claimno.equalsIgnoreCase("")){
				claimno=rsgetclaimdata.getString("claimno");	
			}
			else{
				claimno+=","+rsgetclaimdata.getString("claimno");
			}
			if(!lpono.equalsIgnoreCase("")){
				lpono=rsgetclaimdata.getString("pono");	
			}
			else{
				lpono=","+rsgetclaimdata.getString("pono");
			}
			ARjob.add(rsgetclaimdata.getString("jobdocno")+"::"+rsgetclaimdata.getString("addition"));
		}
		String strupdate="update ws_invm set excess="+excess+",claimno='"+claimno+"',lpono='"+lpono+"' where tr_no="+request.getAttribute("WSINVtrNO");
		System.out.println("Update Query: "+strupdate);
		int updateval=stmt.executeUpdate(strupdate);
		
		for(int i=0;i<ARjob.size();i++){
			String strins="select insurtypedocno, nettotal,round(coalesce((nettotal/(select round(sum(nettotal),2) from ws_investdata where jobdocno="+ARjob.get(i).toString().split("::")[0]+" and addition in ("+ARjob.get(i).toString().split("::")[1]+")))* "
				+" (select sum(netamount) from ws_invcalctemp where invno="+value+" and jobdocno="+ARjob.get(i).toString().split("::")[0]+"),0),2) insamt from ws_investdata"+ 
				 " where jobdocno="+ARjob.get(i).toString().split("::")[0]+" and addition in ("+ARjob.get(i).toString().split("::")[1]+") ";
			System.out.println("Update Query: "+strins);
			ResultSet rsins=stmt.executeQuery(strins);
			String sqlins="insert into ws_invinsurtype( invno, insurtype, amount) values ";
			while(rsins.next()){
				sqlins+=" ("+value+","+rsins.getString("insurtypedocno")+","+rsins.getString("insamt")+ ") , ";
			}
			System.out.println("===="+sqlins.substring(0, sqlins.length()-2));
			stmt.execute(sqlins.substring(0, sqlins.length()-2));
			}
		//Updating Process Status
		
		String strprocessupdate="update ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no set gate.processstatus=7 where job.doc_no in ("+strjobdocno+")";
		System.out.println(strprocessupdate);
		int processupdate=stmt.executeUpdate(strprocessupdate);
		if(processupdate<=0){
			errorstatus=1;
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
	if(errorstatus==0){
		conn.commit();
	}
	
	
	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+invvoucher);
%>