
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");

Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String brhid="",gatedocno="";
	String strmisc="select gate.doc_no gatedocno,gate.brhid gatebrhid from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on est.gipno=gate.doc_no where job.doc_no="+jobdocno;
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	while(rsmisc.next()){
		brhid=rsmisc.getString("gatebrhid");
		gatedocno=rsmisc.getString("gatedocno");
	}
	String strgetmessage="select msg from my_msgsettings where brhid="+brhid+" and dtype='FLRDELAY' and status=3";
	System.out.println(strgetmessage);
	String rawmsg="";
	ResultSet rsraw=stmt.executeQuery(strgetmessage);
	while(rsraw.next()){
		rawmsg=rsraw.getString("msg");
	}
	rawmsg=rawmsg.replace("documentno",gatedocno);
	System.out.println(rawmsg);
	ResultSet rs=stmt.executeQuery(rawmsg);
	String msg="";
	while(rs.next()){
		msg=rs.getString("msg");
	}
	objdata.put("msg",msg);
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
