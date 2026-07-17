<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String cmbbaystatusupdate=request.getParameter("cmbbaystatusupdate")==null?"":request.getParameter("cmbbaystatusupdate");
String cmbbaystatus=request.getParameter("cmbbaystatus")==null?"":request.getParameter("cmbbaystatus");
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="select z"+cmbbaystatusupdate+" zonedata from ws_floormgmtdata where jobdocno="+jobcarddocno;
	ResultSet rs=stmt.executeQuery(strsql);
	String zonedata="";
	while(rs.next()){
		zonedata=rs.getString("zonedata");
	}
	
	String strnumber=zonedata.replaceAll("[^0-9]", "");
	String strupdate="update ws_floormgmtdata set z"+cmbbaystatusupdate+"='"+(strnumber+(cmbbaystatus.equalsIgnoreCase("P")?"P":("P"+cmbbaystatus)))+"' where jobdocno="+jobcarddocno;
	int updateval=stmt.executeUpdate(strupdate);
	if(updateval<=0){
		errorstatus=1;
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