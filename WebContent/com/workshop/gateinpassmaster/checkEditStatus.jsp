<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
Connection conn=null;
int status=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select coalesce(processstatus,0) processstatus from ws_gateinpass where doc_no="+docno+" and status<>7";
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		int processstatus=rs.getInt("processstatus");
		if(processstatus==1){
			status=1;
		}
		else{
			status=0;
		}
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
	status=0;
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>