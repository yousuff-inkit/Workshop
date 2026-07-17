<%@page import="com.workshop.gateinpassmaster.ClsGateInPassAction"%>
<%@page import="com.workshop.invoicev3.ClsInvoiceV3Action"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.workshop.estimationv3.ClsEstimationV3Action"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
int errorstatus=0;
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
	String invdocno=request.getParameter("invdocno")==null?"":request.getParameter("invdocno");
	String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
	String actype=request.getParameter("actype")==null?"":request.getParameter("actype");
	String addition=request.getParameter("addition")==null?"":request.getParameter("addition");
	String estvocno=request.getParameter("estvocno")==null?"":request.getParameter("estvocno");
	
	ClsEstimationV3Action objestaction=new ClsEstimationV3Action();
	ClsInvoiceV3Action objinvaction=new ClsInvoiceV3Action();
	ClsGateInPassAction objgateaction=new ClsGateInPassAction();
	request.setAttribute("mail","1");
	request.setAttribute("estDocno",estdocno);
	request.setAttribute("invdocno",invdocno);
	request.setAttribute("gatedocno",gatedocno);
	request.setAttribute("branch",brhid);
	request.setAttribute("addition",addition);
	request.setAttribute("jobdocno",jobdocno);
	request.setAttribute("mailsource","Dispatch");
	request.setAttribute("header","1");
	request.setAttribute("estvocno",estvocno);
	request.setAttribute("withvat","1");
	if(actype.equalsIgnoreCase("CRM")){
		request.setAttribute("type","1");
	}
	else{
		request.setAttribute("type","2");
	}
	String strprintest=objestaction.printAction();
	if(actype.equalsIgnoreCase("CRM")){
		request.setAttribute("type","2");
	}
	else{
		request.setAttribute("type","1");
	}
	String strprintinv=objinvaction.printAction();
	String strprintgate=objgateaction.printAction();
	//System.out.println("Print Value:"+strprint);
	
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="";
	System.out.println("Ac Type:"+actype);
	strsql="select concat('Invoice - ',coalesce(inv.voc_no,''),' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,'')) sub,coalesce(mail1,'') mailid,concat('Dear ',coalesce(ac.refname,''),'<br>','Please find the attached Invoice ',coalesce(inv.voc_no,''),' , Estimation - ',coalesce(est.voc_no,''),' , GIP ',coalesce(gate.voc_no,''),"+
			" ' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,''),' created on ',date_format(est.date,'%d-%M-%Y')) msg from"+
			" ws_invm inv left join ws_jobcard job on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on"+
			" (ac.acno=inv.invoicetoacno) where inv.doc_no="+invdocno;

	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	String msg="",subject="",mailid="";
	while(rs.next()){
		msg=rs.getString("msg");
		subject=rs.getString("sub");
		mailid=rs.getString("mailid");
	}
	objdata.put("msg",msg);
	objdata.put("subject",subject);
	objdata.put("mailid",mailid);
	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>