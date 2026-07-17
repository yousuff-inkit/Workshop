<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

Connection conn = null;
try{
conn=ClsConnection.getMyConnection();
Statement stmt=conn.createStatement();
String strdoc="select doc_no from gl_bibd where description='Booking Followup'";
ResultSet rsdoc=stmt.executeQuery(strdoc);
int docno=0;
while(rsdoc.next()){
	docno=rsdoc.getInt("doc_no");
}
String strsql="select srno,process from gl_bibp where bibdid="+docno+" order by srno";
ResultSet rs=stmt.executeQuery(strsql);
String processid="",process="";
while(rs.next()){
	process+=rs.getString("process")+",";
	processid+=rs.getString("srno")+",";
}
if(process.length()>0){
	process=process.substring(0, process.length()-1);	
}
response.getWriter().write(process+"***"+processid);
stmt.close();
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>