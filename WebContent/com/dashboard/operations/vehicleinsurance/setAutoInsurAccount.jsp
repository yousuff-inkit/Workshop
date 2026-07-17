<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>

<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int method=0,value=0;
int acno=0,account=0;
String name="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetconfig="select method,value from gl_config where field_nme='autoInsurAccount'";
	ResultSet rsgetconfig=stmt.executeQuery(strgetconfig);
	while(rsgetconfig.next()){
		method=rsgetconfig.getInt("method");
		value=rsgetconfig.getInt("value");
	}
	if(method==1 && value>0){
		String strgetacno="select h.doc_no ACNO,h.DESCRIPTION REFNAME,h.account  from my_head h where H.ATYPE in ('GL','AP') and h.doc_no="+value;
		ResultSet rsgetacno=stmt.executeQuery(strgetacno);
		while(rsgetacno.next()){
			acno=rsgetacno.getInt("acno");
			account=rsgetacno.getInt("account");
			name=rsgetacno.getString("refname");
		}
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(method+"###"+acno+"###"+account+"###"+name);
%>