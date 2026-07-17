<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.sms.SmsAction"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
	String dtype=request.getParameter("dtype")==null?"":request.getParameter("dtype");
	String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");

	int errorstatus=0;
	Connection conn=null;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		
		int smsconfig=0;
        String  strsmsconfig="select method from gl_config where field_nme='sms'";
        ResultSet rssmsconfig=conn.createStatement().executeQuery(strsmsconfig);
        while(rssmsconfig.next()){
        	smsconfig=rssmsconfig.getInt("method");
        }
        if(smsconfig==1){
        	SmsAction smsaction=new SmsAction();
        	int estdocno=0,gipdocno=0;
        	String strgetmobile="select gip.brhid,gip.doc_no gipdocno,date_format(gip.date,'%d.%m.%Y') basedate,ac.cldocno,coalesce(if(coalesce(ac.per_mob,'')='',gip.mobile,ac.per_mob),gip.mobile) clientmobile,coalesce(if(coalesce(ac.refname,'')='',gip.username,ac.refname),gip.username) clientname from ws_gateinpass gip left join ws_estm est on gip.doc_no=est.gipno left join ws_jobcard job on (est.doc_no=job.refno and job.reftype='EST') left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM' where job.doc_no="+jobdocno;
	        ResultSet rsgetmobile=conn.createStatement().executeQuery(strgetmobile);
	        String mobile="",clientname="",cldocno="",basedate="",gipbrhid="";
	        while(rsgetmobile.next()){
	        	mobile=rsgetmobile.getString("clientmobile");
	        	clientname=rsgetmobile.getString("clientname");
	        	cldocno=rsgetmobile.getString("cldocno");
	        	basedate=rsgetmobile.getString("basedate");
	        	gipdocno=rsgetmobile.getInt("gipdocno");
	        	gipbrhid=rsgetmobile.getString("brhid");
	        }
	        
        	String smsstatus=smsaction.doSendSms(session, mobile, clientname, cldocno, "0.0", gipdocno+"", basedate, dtype, gipbrhid, conn);
        	if(smsstatus.equalsIgnoreCase("success")){
        		//System.out.println("SMS Success");
        	}
        	else{
        		errorstatus=3;
        		//Errors from SMS
        	}
        }
        else{
        	errorstatus=1;
        	//Config not Updated
        }
        
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=2;
	}
	finally{
		conn.close();
	}
	JSONObject objdata=new JSONObject();
	objdata.put("errorstatus",errorstatus);
	response.getWriter().write(objdata+"");
%>