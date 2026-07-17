<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String residualval=request.getParameter("residualval")==null?"":request.getParameter("residualval");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
Connection conn=null;
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqlfromdate=null,sqltodate=null;
	conn.setAutoCommit(false);
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	String strvehupdate="update gl_vehmaster set residual_val="+residualval+",stockrelease=1 where fleet_no="+fleetno;
	int vehupdate=stmt.executeUpdate(strvehupdate);
	if(vehupdate<0){
		errorstatus=1;
	}
	int maxdoc=0;
	String strmaxdoc="select coalesce(max(doc_no)+1,1) maxdoc from gl_stockvehicles";
	ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
	while(rsmaxdoc.next()){
		maxdoc=rsmaxdoc.getInt("maxdoc");
	}
	String strinsert="insert into gl_stockvehicles(doc_no,date,fleet_no,fromdate,todate,residualval,status)values("+maxdoc+",CURDATE(),"+fleetno+",'"+sqlfromdate+"','"+sqltodate+"',"+residualval+",3)";
	int insertval=stmt.executeUpdate(strinsert);
	if(insertval<=0){
		errorstatus=1;
	}
	String sqlbiblog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+maxdoc+"','"+branch+"','BSTV',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	int bibval=stmt.executeUpdate(sqlbiblog);  
	if(bibval<=0){
		errorstatus=1;
	}
	if(errorstatus!=1){
		conn.commit();
	}
	stmt.close();
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>