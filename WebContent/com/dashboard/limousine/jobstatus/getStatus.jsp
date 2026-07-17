<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection objconn=new ClsConnection();
Connection conn = null;
try{
conn=objconn.getMyConnection();
Statement stmt=conn.createStatement();
String strsql="select doc_no,statusdesc from gl_limostatus where status=1";
ResultSet rs=stmt.executeQuery(strsql);
String statusid="",status="";
while(rs.next()){
	status+=rs.getString("statusdesc")+",";
	statusid+=rs.getString("doc_no")+",";
}
if(status.length()>0){
	status=status.substring(0, status.length()-1);	
}
response.getWriter().write(status+"::"+statusid);
stmt.close();
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>