<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int docdateconfig=0;
int discountconfig=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strconfig="select method from gl_config where field_nme='invDocCurrentDate'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	while(rsconfig.next()){
		docdateconfig=rsconfig.getInt("method");
	}
	String strdiscountconfig="select method from gl_config where field_nme='WSInvDiscountDet'";
	ResultSet rsdiscountconfig=stmt.executeQuery(strdiscountconfig);
	while(rsdiscountconfig.next()){
		discountconfig=rsdiscountconfig.getInt("method");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(docdateconfig+"::"+discountconfig);
%>