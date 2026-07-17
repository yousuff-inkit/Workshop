<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String labouraddition="",labourmaxaddition="",spareaddition="",sparemaxaddition="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strlabour="select count(addition) addition,max(addition) maxaddition,rdocno from ws_estlabour where  addition>0  WHERE rdocno="+docno;
	ResultSet rslabour=stmt.executeQuery(strlabour);
	while(rslabour.next()){
		labouraddition=rslabour.getString("addition");
		labourmaxaddition=rslabour.getString("maxaddition");
	}
	String strspare="select count(addition) addition,rdocno, max(addition) maxaddition from ws_estspare where  addition>0  WHERE rdocno="+docno;
	ResultSet rsspare=stmt.executeQuery(strspare);
	while(rsspare.next()){
		spareaddition=rsspare.getString("addition");
		sparemaxaddition=rsspare.getString("maxaddition");
	}
	
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(labouraddition+"::"+labourmaxaddition+"::"+spareaddition+"::"+sparemaxaddition);
%>