
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String outdate=request.getParameter("outdate")==null?"":request.getParameter("outdate");
String outtime=request.getParameter("outtime")==null?"":request.getParameter("outtime");
String amount=request.getParameter("amount")==null?"":request.getParameter("amount");
Connection conn=null;
String status="";
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqloutdate=null;
	if(!outdate.equalsIgnoreCase("")){
		sqloutdate=objcommon.changeStringtoSqlDate(outdate);
	}
	if(amount.equalsIgnoreCase("")){
		amount="0.0";
	}
	String str="update gl_workgateinpassm set processstatus=3,outstatus=1,outdate='"+sqloutdate+"',outtime='"+outtime+"',invamount="+amount+" where doc_no="+gatedocno;
	int updateval=stmt.executeUpdate(str);
	if(updateval<=0){
		errorstatus=1;
	}
	int floormgmtconfig=0;
	String strfloormgmtconfig="select method from gl_config where field_nme='floorMgmt'";
	ResultSet rsfloorconfig=stmt.executeQuery(strfloormgmtconfig);
	while(rsfloorconfig.next()){
		floormgmtconfig=rsfloorconfig.getInt("method");
	}
	
	if(floormgmtconfig>0){
		String strgetjobdocno="select jc.doc_no from ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST')"+
		" left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
		" where gp.doc_no="+gatedocno;
		int jobdocno=0;
		ResultSet rsjobdocno=stmt.executeQuery(strgetjobdocno);
		while(rsjobdocno.next()){
			jobdocno=rsjobdocno.getInt("doc_no");
		}
		String strupdatefloormgmt="update ws_floormgmtdata set completestatus=1 where jobdocno="+jobdocno;
		int updatefloormgmt=stmt.executeUpdate(strupdatefloormgmt);
		if(updatefloormgmt<=0){
			errorstatus=1;
		}
	}
	if(errorstatus==0){
		status=updateval+"";
		conn.commit();
	}
	else{
		status="0";
	}
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(status);
%>