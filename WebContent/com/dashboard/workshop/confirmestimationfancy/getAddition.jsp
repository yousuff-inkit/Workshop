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
	String strlabour="select coalesce(addition,0) addition,rdocno, coalesce(max(addition),0) maxaddition from ws_estlabour where  addition>0  and rdocno="+docno+" and confirmed=0";
	System.out.println(strlabour);
	ResultSet rslabour=stmt.executeQuery(strlabour);
	while(rslabour.next()){
		labouraddition=rslabour.getString("maxaddition");
		labourmaxaddition=rslabour.getString("maxaddition");
	}
	String strspare="select coalesce(addition,0) addition,rdocno, coalesce(max(addition),0) maxaddition from ws_estspare where  addition>0  and rdocno="+docno+" and confirmed=0";
	System.out.println(strspare);
	ResultSet rsspare=stmt.executeQuery(strspare);
	while(rsspare.next()){
		spareaddition=rsspare.getString("maxaddition");
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