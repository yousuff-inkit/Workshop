<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String packagedocno=request.getParameter("package")==null?"":request.getParameter("package");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String cmbmodel=request.getParameter("cmbmodel")==null?"":request.getParameter("cmbmodel");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String chassisno=request.getParameter("chassisno")==null?"":request.getParameter("chassisno");

Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
String errormsg="";
try{
	ClsCommon objcommon=new ClsCommon();
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("undefined")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	if(brhid.trim().equalsIgnoreCase("") || brhid.trim().equalsIgnoreCase("a")){
		brhid=session.getAttribute("BRANCHID").toString();
	}
	int docno=0,vocno=0;
	String strgetmaxdocno="select (select coalesce(max(doc_no),0)+1 from ws_packagecontract) maxdocno,(select coalesce(max(voc_no),0)+1 from ws_packagecontract where brhid="+brhid+") maxvocno";
	ResultSet rsmaxdocno=stmt.executeQuery(strgetmaxdocno);
	while(rsmaxdocno.next()){
		docno=rsmaxdocno.getInt("maxdocno");
		vocno=rsmaxdocno.getInt("maxvocno");
	}
	String userid=session.getAttribute("USERID").toString();
	String strinsertmaster="insert into ws_packagecontract(doc_no,voc_no,date, cldocno, packagedocno, fromdate, todate, remarks, brhid, userid, status,modeldocno,regno,chassisno)values("+docno+","+vocno+",CURDATE(),"+cldocno+","+packagedocno+",'"+sqlfromdate+"','"+sqltodate+"','"+remarks+"',"+brhid+","+userid+",3,"+cmbmodel+",'"+regno+"','"+chassisno+"')";
	int insertmaster=stmt.executeUpdate(strinsertmaster);
	if(insertmaster<=0){
		errorstatus=1;
		errormsg="Master Error";
	}
	
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,docno);
	stmtlog.setInt(2,Integer.parseInt(brhid));
	stmtlog.setString(3,"BWPC");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, "A");
	int log=stmtlog.executeUpdate();
	if(log<=0){
		errorstatus=1;
		errormsg="Log Insert Error";
	}
	
	//Saving Package Details
	String strlabour="insert into ws_pkgcontractlabour(detaildocno, rdocno, jobtypeid, strjobtype, jobdesc, jobqty, remarks, seqno,pkgqty,contractdocno,pkgorgqty)"+
	" select doc_no, rdocno, jobtypeid, strjobtype, jobdesc, jobqty, remarks, seqno,jobqty,"+docno+",jobqty from ws_packagelabour lab where rdocno="+packagedocno;
	int insertlabour=stmt.executeUpdate(strlabour);
	if(insertlabour<=0){
		errorstatus=1;
		errormsg="Labour Insert Error";
	}
	String strspare="insert into ws_pkgcontractspare(detaildocno, rdocno, spdesc, psrno, qty, seqno,pkgqty,contractdocno,pkgorgqty)"+
	" select doc_no, rdocno, spdesc, psrno, qty, seqno,qty,"+docno+",qty from ws_packagespare lab where rdocno="+packagedocno;
	int insertspare=stmt.executeUpdate(strspare);
	if(insertspare<=0){
		errorstatus=1;
		errormsg="Spare Insert Error";
	}
	if(errorstatus==0){
		conn.commit();
	}
	objdata.put("errorstatus",errorstatus);
	objdata.put("errormsg",errormsg);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>