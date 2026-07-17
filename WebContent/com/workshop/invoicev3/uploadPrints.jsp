<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.workshop.wsinvoicepal.*"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
int errorstatus=0;
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String header=request.getParameter("header")==null?"":request.getParameter("header");
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
	String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
	String type=request.getParameter("type")==null?"":request.getParameter("type");
	
	ClsWSInvoiceAction objinvaction=new ClsWSInvoiceAction();
	
	request.setAttribute("mail","1");
	request.setAttribute("docno",docno);
	request.setAttribute("header",header);
	request.setAttribute("branch",branch);
	request.setAttribute("jobcarddocno",jobcarddocno);
	request.setAttribute("type",type);

	String strprint=objinvaction.printAction();
	System.out.println("Print Value:"+strprint);
	
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select concat('Invoice - ',coalesce(inv.voc_no,''),' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,'')) sub,coalesce(mail1,'') mailid,concat('Dear ',coalesce(ac.refname,''),'<br>','Please find the attached invoice - ',coalesce(est.voc_no,''),"+
	" ' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,''),' created on ',date_format(inv.date,'%d-%M-%Y')) msg from"+
	" ws_invm inv left join ws_jobcard job on (inv.refno=job.doc_no and inv.reftype='JC') left join ws_estm est on"+
	" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on"+
	" inv.invoicetoacno=ac.acno  where inv.doc_no="+docno;
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