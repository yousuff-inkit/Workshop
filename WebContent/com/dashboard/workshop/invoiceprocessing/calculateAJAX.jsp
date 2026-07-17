<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	String strclaimconfig="select method from gl_config where field_nme='wsInvClaimGrouping'";
	ResultSet rsclaimconfig=stmt.executeQuery(strclaimconfig);
	int claimconfig=0;
	while(rsclaimconfig.next()){
		claimconfig=rsclaimconfig.getInt("method");
	}
	System.out.println("Config Method:"+claimconfig);
	String strsql="";
	if(claimconfig==1){
		strsql="select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" coalesce(gate.regno,'')) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.nettotal)-sum(m.excess) amount,0 discount,"+
		" sum(m.nettotal)-sum(m.excess) nettotal,(sum(m.nettotal))*0.05 vatamt,(sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal))*0.05) total, sum(m.excess) excess,"+
		" ((sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal))*0.05)) netbill from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left"+
		" join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',"+
		" job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM') where"+
		" chkclaim=1 and m.vattype=2 and m.excess!=0 and m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 group by m.claimno union all"+
		" select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" coalesce(gate.regno,'')) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.nettotal)-sum(m.excess) amount,0 discount,"+
		" sum(m.nettotal)-sum(m.excess) nettotal,(sum(m.nettotal)-sum(m.excess))*0.05 vatamt,(sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal)-sum(m.excess))*0.05) total,"+
		" sum(m.excess) excess,(sum(m.nettotal)-sum(m.excess))+((sum(m.nettotal)-sum(m.excess))*0.05) netbill from ws_investdata m left join ws_jobcard job on"+
		" job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on"+
		" (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno"+
		" and ac.dtype='CRM') where chkclaim=1 and m.vattype=1  and m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 group by m.claimno union all"+
		" select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" coalesce(gate.regno,'')) description,2 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.excess) amount,0 discount,sum(m.excess) nettotal,"+
		" if(m.vattype=1,sum((m.excess))*0.05,0) vatamt,sum((m.excess))+(if(m.vattype=1,sum((m.excess))*0.05,0)) total,0 excess,sum((m.excess))+("+
		" if(m.vattype=1,sum((m.excess))*0.05,0)) netbill from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join"+
		" ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',"+
		" job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where"+
		" chkclaim=1 and m.excess!=0  and m.jobdocno="+jobdocno+" group by m.claimno union all"+
		" select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',"+
		" coalesce(gate.regno,'')) description,0 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,sum(m.nettotal) amount,0 discount,sum(m.nettotal)"+
		" nettotal,sum((m.nettotal))*0.05 vatamt,sum((m.nettotal))+sum(((m.nettotal))*0.05) total,0.0 excess,sum((m.nettotal))+sum(((m.nettotal))*0.05) netbill"+
		" from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and"+
		" job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left"+
		" join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where chkclaim=0 and m.excess=0 and m.jobdocno="+jobdocno+" group by m.claimno";
	}
	else{
		strsql="select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',coalesce(gate.regno,'')) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,m.nettotal-m.excess amount,0 discount,m.nettotal-m.excess nettotal,(m.nettotal)*0.05 vatamt,(m.nettotal-m.excess)+((m.nettotal)*0.05) total, m.excess,((m.nettotal-m.excess)+((m.nettotal)*0.05)) netbill from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM') where chkclaim=1 and m.vattype=2 and m.excess!=0 and m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 union all"+
		" select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',coalesce(gate.regno,'')) description,1 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,m.nettotal-m.excess amount,0 discount,m.nettotal-m.excess nettotal,(m.nettotal-m.excess)*0.05 vatamt,(m.nettotal-m.excess)+((m.nettotal-m.excess)*0.05) total, m.excess,(m.nettotal-m.excess)+((m.nettotal-m.excess)*0.05) netbill from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM') where chkclaim=1 and m.vattype=1  and m.jobdocno="+jobdocno+" and (m.nettotal-m.excess)!=0 union all "+
		" select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',coalesce(gate.regno,'')) description,2 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,m.excess amount,0 discount,m.excess nettotal,if(m.vattype=1,(m.excess)*0.05,0) vatamt,(m.excess)+(if(m.vattype=1,(m.excess)*0.05,0)) total,0 excess,(m.excess)+(if(m.vattype=1,(m.excess)*0.05,0)) netbill from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where chkclaim=1 and m.excess!=0  and m.jobdocno="+jobdocno+" union all"+
		" select concat('CL - ',coalesce(m.claimno,''),' PO - ',coalesce(m.pono,''),' JCB - ',coalesce(job.voc_no,''),' Regn - ',coalesce(gate.regno,'')) description,0 insurstatus,ac.acno,m.claimno,m.pono,m.jobdocno,m.nettotal amount,0 discount,m.nettotal nettotal,(m.nettotal)*0.05 vatamt,(m.nettotal)+((m.nettotal)*0.05) total,0.0 excess,(m.nettotal)+((m.nettotal)*0.05) netbill from ws_investdata m left join ws_jobcard job on job.doc_no=m.jobdocno left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where chkclaim=0 and m.excess=0 and m.jobdocno="+jobdocno;
	}
	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	ArrayList<String> calcarray=new ArrayList();
	while(rs.next()){
		calcarray.add(rs.getInt("insurstatus")+" :: "+rs.getInt("acno")+" :: "+rs.getString("claimno")+" :: "+rs.getInt("jobdocno")+" :: "+rs.getDouble("amount")+" :: "+rs.getDouble("nettotal")+" :: "+rs.getDouble("vatamt")+" :: "+rs.getDouble("total")+" :: "+rs.getDouble("excess")+" :: "+rs.getDouble("netbill")+" :: "+rs.getString("pono")+" :: "+rs.getString("description"));
	}
	String strdelete="delete from ws_invcalctemp where jobdocno="+jobdocno+" and invno=0";
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
		desc1=temp[11];
		System.out.println("DEsc"+desc1+"::"+temp[11]);
		String strinsert="insert into ws_invcalctemp(jobdocno, billtoacno, claimno, amount, netamount, "+
		" vatamount, totalamount,excessamount, netbill,insurstatus,description,pono)values("+
		" "+temp[3]+","+temp[1]+",'"+temp[2]+"',"+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+","+temp[8]+","+temp[9]+","+temp[0]+",'"+desc1+"','"+temp[10]+"')";
		System.out.println(strinsert);
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