<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String seccldocno=request.getParameter("seccldocno")==null?"":request.getParameter("seccldocno");

Connection conn=null;
ClsConnection objconn=new ClsConnection();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	int tax=0,clienttax=0,cldocno=0;
	Double vatpercent=0.0;
	
	String strgetclient="select cldocno from ws_gateinpass g left join ws_estm m on m.gipno=g.doc_no left join ws_jobcard j on j.refno=m.doc_no and j.reftype='est' where j.doc_no="+jobdocno+" and j.status=3 ";
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);
	while(rsgetclient.next()){
		cldocno=rsgetclient.getInt("cldocno");
	}
	cldocno=Integer.parseInt(seccldocno);
	String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttax";
	ResultSet rschecktax=stmt.executeQuery(strchecktax);
	while(rschecktax.next()){
		tax=rschecktax.getInt("taxmethod");
		clienttax=rschecktax.getInt("clienttax");
	}
	if(tax==1 && clienttax==1){
		String strtax="select coalesce(vat_per,0.0) vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and curdate() between tax.fromdate and tax.todate";
		ResultSet rstax=stmt.executeQuery(strtax);
		while(rstax.next()){
			vatpercent=rstax.getDouble("vat_per");
		}
		
	}
	
	String strclaimconfig="select method from gl_config where field_nme='wsInvClaimGrouping'";
	ResultSet rsclaimconfig=stmt.executeQuery(strclaimconfig);
	int claimconfig=0;
	while(rsclaimconfig.next()){
		claimconfig=rsclaimconfig.getInt("method");
	}
	System.out.println("Config Method:"+claimconfig);
	String strsql="";
	if(claimconfig==1){
		strsql="select  concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,group_concat(m.addition) addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.nettotal)-sum(m.excess) amount,0 discount,"+
		" sum(m.nettotal)-sum(m.excess) nettotal,(sum(m.nettotal))*("+vatpercent+"/100) vatamt,(sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal))*("+vatpercent+"/100)) total, sum(m.excess) excess,"+
		" ((sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal))*("+vatpercent+"/100)))+m.nontaxamt netbill,round(m.nontaxamt,2) nontaxamt from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left"+
		" join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',"+
		" job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM') where"+
		" chkclaim=1 and m.vattype=2 and  m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 group by m.claimno union all"+
		
		" select  concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,group_concat(m.addition) addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.nettotal)-sum(m.excess) amount,0 discount,"+
		" sum(m.nettotal)-sum(m.excess) nettotal,(sum(m.nettotal)-sum(m.excess))*("+vatpercent+"/100) vatamt,(sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal)-sum(m.excess))*("+vatpercent+"/100)) total,"+
		" sum(m.excess) excess,(sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal)-sum(m.excess))*("+vatpercent+"/100))+m.nontaxamt netbill,round(m.nontaxamt,2) nontaxamt from ws_investdata m left join ws_jobcard job on"+
		" job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on"+
		" (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno"+
		" and ac.dtype='CRM') where chkclaim=1 and m.vattype=1  and m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 group by m.claimno union all"+
		
		" select  concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,group_concat(m.addition) addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,2 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.excess) amount,0 discount,sum(m.excess) nettotal,"+
		" if(m.vattype=1,sum((m.excess))*("+vatpercent+"/100),0) vatamt,sum((m.excess))+(if(m.vattype=1,sum((m.excess))*("+vatpercent+"/100),0)) total,0 excess,sum((m.excess))+("+
		" if(m.vattype=1,sum((m.excess))*("+vatpercent+"/100),0))+m.nontaxamt netbill,round(m.nontaxamt,2) nontaxamt from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join"+
		" ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',"+
		" job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on ("+seccldocno+"=ac.cldocno and ac.dtype='CRM') where"+
		" chkclaim=1 and m.excess!=0  and m.jobdocno="+jobdocno+"  and m.seccldocno="+seccldocno+" group by m.claimno union all"+
		
		" select concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,group_concat(m.addition) addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,0 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.nettotal) amount,0 discount,sum(m.nettotal)"+
		" nettotal,sum((m.nettotal))*("+vatpercent+"/100) vatamt,sum((m.nettotal))+sum(((m.nettotal))*("+vatpercent+"/100)) total,0.0 excess,sum((m.nettotal))+sum(((m.nettotal))*("+vatpercent+"/100))+m.nontaxamt netbill,round(m.nontaxamt,2) nontaxamt"+
		" from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and"+
		" job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left"+
		" join my_acbook ac on ("+seccldocno+"=ac.cldocno and ac.dtype='CRM') where chkclaim=0 and m.excess=0 and m.jobdocno="+jobdocno+"  and m.seccldocno="+seccldocno+" group by m.claimno";
	}
	else{
		strsql="select  concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,m.addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,round(m.nettotal-m.excess,2) amount,0 discount,round(m.nettotal-m.excess,2) nettotal,round((m.nettotal)*("+vatpercent+"/100),2) vatamt,round((m.nettotal-m.excess)+((m.nettotal)*("+vatpercent+"/100)),2) total, round(m.excess,2) excess,round(((m.nettotal-m.excess)+((m.nettotal)*("+vatpercent+"/100)))+m.nontaxamt,2) netbill,round(m.nontaxamt,2) nontaxamt from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM') where chkclaim=1 and m.vattype=2 and m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 and m.seccldocno="+seccldocno+" union all"+
		" select  concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,m.addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,round(m.nettotal-m.excess,2) amount,0 discount,round(m.nettotal-m.excess,2) nettotal,round((m.nettotal-m.excess)*("+vatpercent+"/100),2) vatamt,round((m.nettotal-m.excess)+((m.nettotal-m.excess)*("+vatpercent+"/100)),2) total, round(m.excess,2) excess,round((m.nettotal-m.excess)+((m.nettotal-m.excess)*("+vatpercent+"/100))+m.nontaxamt,2) netbill,round(m.nontaxamt,2) nontaxamt from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM') where chkclaim=1 and m.vattype=1  and m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 and m.seccldocno="+seccldocno+" union all "+
		" select  concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,m.addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,2 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,round(m.excess,2) amount,0 discount,round(m.excess,2) nettotal,round(if(m.vattype=1,(m.excess)*("+vatpercent+"/100),0),2) vatamt,round((m.excess)+(if(m.vattype=1,(m.excess)*("+vatpercent+"/100),0)),2) total,0 excess,round((m.excess)+(if(m.vattype=1,(m.excess)*("+vatpercent+"/100),0)),2) netbill,round(m.nontaxamt,2) nontaxamt from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on ("+seccldocno+"=ac.cldocno and ac.dtype='CRM') where chkclaim=1 and m.excess!=0  and m.jobdocno="+jobdocno+" and m.seccldocno="+seccldocno+" union all"+
		" select  concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,'')) regno,m.addition,concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''))) description,0 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,round(m.nettotal,2) amount,0 discount,round(m.nettotal,2) nettotal,round((m.nettotal)*("+vatpercent+"/100),2) vatamt,round((m.nettotal)+((m.nettotal)*("+vatpercent+"/100)),2) total,0.0 excess,round((m.nettotal)+((m.nettotal)*("+vatpercent+"/100))+m.nontaxamt,2) netbill,round(m.nontaxamt,2) nontaxamt from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on ("+seccldocno+"=ac.cldocno and ac.dtype='CRM') where chkclaim=0 and m.excess=0 and m.jobdocno="+jobdocno+" and m.seccldocno="+seccldocno;
	}
	// and m.excess!=0  REMOVED FROM FIRST UNION ALL  
	System.out.println("Calculate SQL:"+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	ArrayList<String> calcarray=new ArrayList();
	while(rs.next()){
		if(rs.getDouble("amount")>0.0){
			calcarray.add(rs.getInt("insurstatus")+" :: "+rs.getInt("acno")+" :: "+rs.getString("claimno")+" :: "+rs.getInt("jobdocno")+" :: "+rs.getDouble("amount")+" :: "+rs.getDouble("nettotal")+" :: "+rs.getDouble("vatamt")+" :: "+rs.getDouble("total")+" :: "+rs.getDouble("excess")+" :: "+rs.getDouble("netbill")+" :: "+rs.getString("pono")+" :: "+rs.getString("description")+" :: "+rs.getString("addition")+" :: "+rs.getString("regno")+" :: "+rs.getString("nontaxamt"));	
		}
	}
	String strdelete="delete from ws_invcalctemp where jobdocno="+jobdocno+" and invno=0 and seccldocno="+seccldocno;
	int deleteval=stmt.executeUpdate(strdelete);
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
		System.out.println("DEsc"+desc1+"::"+temp[11]);
		String strinsert="insert into ws_invcalctemp(jobdocno, billtoacno, claimno, amount, netamount, "+
		" vatamount, totalamount,excessamount, netbill,insurstatus,description,pono,addition,regno,nontaxamt,seccldocno)values("+
		" "+temp[3].trim()+","+temp[1].trim()+",'"+temp[2].trim()+"',"+temp[4].trim()+","+temp[5].trim()+","+temp[6].trim()+","+temp[7].trim()+","+temp[8].trim()+","+temp[9].trim()+","+temp[0].trim()+",'"+desc1+"','"+temp[10].trim()+"','"+temp[12].trim()+"','"+temp[13].trim()+"',"+temp[14]+","+seccldocno+")";
		System.out.println("SECCLDOCNO:"+seccldocno+"::"+strinsert);
		int insert=stmt.executeUpdate(strinsert);
		if(insert<=0){
			errorstatus=1;
		}
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>