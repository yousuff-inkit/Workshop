<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%Connection conn=null;
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
int updateval=0;
try{
ClsConnection objconn=new ClsConnection();
conn=objconn.getMyConnection();
Statement stmt=conn.createStatement();
conn.setAutoCommit(false);
String strdeletelabour="delete from ws_estlabour where rdocno=(select refno from ws_jobcard where doc_no="+jobcarddocno+" and reftype='EST' and status=3) and lumsumstatus>0";
int deletelabour=stmt.executeUpdate(strdeletelabour);
String strsql="update ws_jobcard set savestatus=0 where doc_no="+jobcarddocno;
updateval=stmt.executeUpdate(strsql);
if(updateval>0){
	conn.commit();
}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(updateval+"");
%>