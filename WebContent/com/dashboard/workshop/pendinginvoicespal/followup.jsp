<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String followupdate=request.getParameter("followupdate")==null?"":request.getParameter("followupdate");
String cmbstatus=request.getParameter("cmbstatus")==null?"":request.getParameter("cmbstatus");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String userid=session.getAttribute("USERID").toString();
	java.sql.Date sqldate=null;
	if(!followupdate.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(followupdate);
	}
	String strsql="insert into ws_pendinginvfollowup(rdocno,userid,followupdate,remarks)values("+jobcarddocno+","+userid+",'"+sqldate+"','"+remarks+"')";
	int insertval=stmt.executeUpdate(strsql);
	if(insertval<=0){
		errorstatus=1;
	}
	int branch=0;
	String strbranch="select brhid from ws_jobcard where doc_no="+jobcarddocno;
	ResultSet rsbranch=stmt.executeQuery(strbranch);
	while(rsbranch.next()){
		branch=rsbranch.getInt("brhid");
	}
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,Integer.parseInt(jobcarddocno));
	stmtlog.setInt(2,branch);
	stmtlog.setString(3,"BWPI");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, "A");
	int log=stmtlog.executeUpdate();
	if(log<=0){
		errorstatus=1;
	}
	if(cmbstatus.equalsIgnoreCase("WIP")){
		String strupdatejcc="update ws_jobcard set complete=0 where doc_no="+jobcarddocno;
		int updatejcc=stmt.executeUpdate(strupdatejcc);
		if(updatejcc<=0){
			errorstatus=1;
		}
		String strupdategate="update ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST')"+
				"left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
				"set gp.processstatus=5 where jc.doc_no="+jobcarddocno;
		int updategate=stmt.executeUpdate(strupdategate);
		if(updategate<=0){
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