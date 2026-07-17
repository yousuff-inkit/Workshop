
<%@page import="com.sms.SmsAction"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String message=request.getParameter("message")==null?"":request.getParameter("message");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	SmsAction smsaction=new SmsAction();
	int errorstatus=0;
	String brhid="",mobile="",clientname="",gatedocno="";
	String strmisc="select gate.doc_no gatedocno,gate.brhid gatebrhid,coalesce(gate.mobile,ac.per_mob) mobile,coalesce(case when ac.refname='' then gate.clientname else ac.refname end,gate.clientname) clientname from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on gate.cldocno=ac.cldocno and ac.dtype='CRM' where job.doc_no="+jobdocno;
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	while(rsmisc.next()){
		brhid=rsmisc.getString("gatebrhid");
		gatedocno=rsmisc.getString("gatedocno");
		mobile=rsmisc.getString("mobile");
		clientname=rsmisc.getString("clientname");
	}
	
	String action=smsaction.doSendSmsBasic(mobile, clientname, message, gatedocno, "FLRDELAY", brhid, conn);
	if(action.equalsIgnoreCase("success")){
		String strupdate="update ws_floormgmtdata set delaysms=1 where jobdocno="+jobdocno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
		if(errorstatus==0){
			conn.commit();	
		}
		
	}
	else{
		errorstatus=1;
	}
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(!conn.isClosed()){
		conn.close();	
	}
	
}
response.getWriter().write(objdata+"");
%>
