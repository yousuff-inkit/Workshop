<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String cmbteamupdatebay=request.getParameter("cmbteamupdatebay")==null?"":request.getParameter("cmbteamupdatebay");
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String cmbteamupdate=request.getParameter("cmbteamupdate")==null?"":request.getParameter("cmbteamupdate");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	for(int i=0;i<cmbteamupdate.split(",").length;i++){
		String teamid=cmbteamupdate.split(",")[i];
		/* String strsql="insert into ws_jobcardteamselect(jobcarddocno,bayid,teamid,userid)values("+jobcarddocno+","+cmbteamupdatebay+","+teamid+","+userid+")";
		int updateval=stmt.executeUpdate(strsql);
		if(updateval<=0){
			errorstatus=1;
		} */
		String strsql="insert into ws_jobplanteam(jobdocno,teamdocno,baydocno,userid)values("+jobcarddocno+","+teamid+","+cmbteamupdatebay+","+userid+")";
		int insert=stmt.executeUpdate(strsql);
		if(insert<=0){
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