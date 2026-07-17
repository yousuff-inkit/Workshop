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
	int processstatus=0;
	String str="select gate.processstatus from ws_estm est left join ws_gateinpass gate on est.gipno=gate.doc_no where est.doc_no="+docno;
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		processstatus=rs.getInt("processstatus");
	}
	if(processstatus>=5){
		status=0;
	}
	else{
		status=1;
	}
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