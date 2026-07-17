<%@page import="com.workshop.wsestimationpal.ClsWSEstimationPalAction"%>
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
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String printchk=request.getParameter("printchk")==null?"":request.getParameter("printchk");
	String withvat=request.getParameter("withvat")==null?"":request.getParameter("withvat");
	String addition=request.getParameter("addition")==null?"0":request.getParameter("addition");
	
	ClsWSEstimationPalAction objestaction=new ClsWSEstimationPalAction();
	
	request.setAttribute("mail","1");
	request.setAttribute("estDocno",estdocno);
	request.setAttribute("docno",docno);
	request.setAttribute("gatedocno",gatedocno);
	request.setAttribute("branch",brhid);
	request.setAttribute("addition",addition);
	request.setAttribute("withvat",withvat);
	request.setAttribute("printchk",printchk);

	String strprint=objestaction.printAction();
	System.out.println("Print Value:"+strprint);
	
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="";
	if(printchk.equalsIgnoreCase("1")){
		strsql="select concat('Estimation - ',coalesce(est.voc_no,''),' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,'')) sub,coalesce(mail1,'') mailid,concat('Dear ',coalesce(ac.refname,''),'<br>','Please find the attached estimation - ',coalesce(est.voc_no,''),"+
				" ' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,''),' created on ',date_format(est.date,'%d-%M-%Y')) msg from"+
				" ws_estm est left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on"+
				" (ac.cldocno=gate.cldocno and ac.dtype='CRM') where est.doc_no="+docno;
	}
	else{
		strsql="select concat('Estimation - ',coalesce(est.voc_no,''),' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,'')) sub,coalesce(mail1,'') mailid,concat('Dear ',coalesce(ac.refname,''),'<br>','Please find the attached estimation - ',coalesce(est.voc_no,''),"+
				" ' for vehicle ',coalesce(gate.regno,''),' - ',coalesce(gate.pltid,''),' created on ',date_format(est.date,'%d-%M-%Y')) msg from"+
				" ws_estm est left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on"+
				" (ac.cldocno=gate.insurcldocno and ac.dtype='VND') where est.doc_no="+docno;
	}
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