<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String cldocno="",clientname="",clientdetails="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select cldocno,refname,concat('ADDRESS: ',coalesce(address,''),', MOBILE: ',coalesce(per_mob,''),', MAIL: ',coalesce(mail1,''),', CONTACT PERSON: ',coalesce(contactperson,'')) clientdetails from my_acbook where cldocno=1 and dtype='CRM'";
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		cldocno=rs.getString("cldocno");
		clientname=rs.getString("refname");
		clientdetails=rs.getString("clientdetails");
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(cldocno+"***"+clientname+"***"+clientdetails);
%>