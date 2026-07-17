<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null?"0":request.getParameter("gatedocno");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Getting Client Invoice Mandatory Config

	String strgopconfig="select method from gl_config where field_nme='GOPWithoutInvoice'";
	int gopconfig=0;
	ResultSet rsgopconfig=stmt.executeQuery(strgopconfig);
	while(rsgopconfig.next()) {
		gopconfig=rsgopconfig.getInt("method");
	}
	int clientinvpending=0;
	if(gopconfig==2){
		String strsql="select case when coalesce(sum(estbase.estclientcount),0)>0 and coalesce(calcbase.clientinvcount,0)=0 then 1 else 0 end clientinvpending from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"+
		" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"+
		" left join (select count(*) estclientcount,est.doc_no estdocno from ws_estm est left join ws_estlabour lab on (est.doc_no=lab.rdocno and lab.addition=0) left join ws_jccspare jcc on (est.doc_no=jcc.estdocno and jcc.addition=0) where est.billto=1 group by est.doc_no having sum(jcc.customeramt)>0 or sum(lab.invoiceamt)>0 union all"+
		" select count(*) estclientcount,est.doc_no estdocno from ws_estmadd est left join ws_estlabour lab on (est.doc_no=lab.rdocno and est.addition=lab.addition) left join ws_jccspare jcc on (est.doc_no=jcc.estdocno and est.addition=jcc.addition) where est.billto=1 group by est.doc_no having sum(jcc.customeramt)>0 or sum(lab.invoiceamt)>0) estbase on est.doc_no=estbase.estdocno "+
		" left join (select count(*) clientinvcount,calc.jobdocno from ws_invcalctemp calc left join ws_jobcard job on calc.jobdocno=job.doc_no left join ws_estm est on job.refno=est.doc_no and job.reftype='EST' left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on gate.cldocno=ac.cldocno and ac.dtype='CRM'"+
		" where calc.billtoacno=ac.acno and calc.invno>0 group by calc.jobdocno) calcbase on calcbase.jobdocno=job.doc_no where gate.doc_no="+gatedocno;
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			clientinvpending=rs.getInt("clientinvpending");
		}
	}
	
	if(gopconfig>0 && clientinvpending>0){
		objdata.put("restrictgop","1");
	}
	else{
		objdata.put("restrictgop","0");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	//System.out.println("Inside Finally");
	conn.close();
}
response.getWriter().write(objdata+"");
%>