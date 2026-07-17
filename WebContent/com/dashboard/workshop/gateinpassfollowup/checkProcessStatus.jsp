<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String pstatus="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strlabour="select processstatus from ws_gateinpass where status=3 and doc_no="+docno;
	ResultSet rslabour=stmt.executeQuery(strlabour);
	while(rslabour.next()){
		pstatus=rslabour.getString("processstatus");
	}
	//System.out.print("process status --- :"+pstatus);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(pstatus);
%>