<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
System.out.println("Passed Doc No:"+docno);
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	String strsql="select bill.acno billtoacno,billhead.account billtoaccount,billhead.description billtoacname,coalesce(gate.insurancecomp,0) billtoinsurance,est.nettotal,ac.refname,job.date,ac.cldocno,gate.regno,head.account,head.doc_no acno,head.description acname,job.voc_no,job.doc_no, concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1, ' , Contact Person ',ac.contactperson) userdetails, convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ', coalesce(yom.yom,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicledetails from   ws_jobcard job left join ws_estm est on  (job.reftype='est' and job.refno=est.doc_no ) left join"+
	" ws_gateinpass gate   on est.gipno=gate.doc_no   or ((job.reftype='GIP' and job.refno=gate.doc_no)) left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_acbook bill on (((gate.insurancecomp=1 and gate.insurcldocno=bill.cldocno) or  (gate.insurancecomp=0 and gate.cldocno=bill.cldocno)) and bill.dtype='CRM') left join gl_vehbrand brd on  gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on  gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no  left join my_head head on ac.acno=head.doc_no left join my_head billhead on bill.acno=billhead.doc_no where job.status=3 and job.doc_no="+docno;
	System.out.println("Search Ajax:"+strsql);
	Statement stmt=conn.createStatement();
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		objdata.put("billtoacno",rs.getString("billtoacno"));
		objdata.put("billtoaccount",rs.getString("billtoaccount"));
		objdata.put("billtoacname",rs.getString("billtoacname"));
		objdata.put("billtoinsurance",rs.getString("billtoinsurance"));
		objdata.put("nettotal",rs.getString("nettotal"));
		objdata.put("refname",rs.getString("refname"));
		objdata.put("date",rs.getString("date"));
		objdata.put("cldocno",rs.getString("cldocno"));
		objdata.put("regno",rs.getString("regno"));
		objdata.put("account",rs.getString("account"));
		objdata.put("acno",rs.getString("acno"));
		objdata.put("acname",rs.getString("acname"));
		objdata.put("voc_no",rs.getString("voc_no"));
		objdata.put("doc_no",rs.getString("doc_no"));
		objdata.put("userdetails",rs.getString("userdetails"));
		objdata.put("vehicledetails",rs.getString("vehicledetails"));
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>