<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
Connection conn=null;
int status=1;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int processstatus=1;
	String str="select gate.processstatus from ws_estm est inner join ws_gateinpass gate on gate.doc_no=est.gipno where est.doc_no="+docno;
	System.out.println(str);
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		processstatus=rs.getInt("processstatus");
		if(processstatus>=6){
			status=0;	
		}
	}
	
	System.out.println("Status:"+status+"///");
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>