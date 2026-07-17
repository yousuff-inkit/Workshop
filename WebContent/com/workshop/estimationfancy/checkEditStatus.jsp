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
	int processstatus=0;
	String str="select gate.doc_no processstatus from ws_estm est inner join ws_jobcard gate on (est.doc_no=gate.refno and reftype='est' and gate.status=3 ) where est.doc_no="+docno;
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		processstatus=rs.getInt("processstatus");
		status=0;
	}
	/* if(processstatus>=5){
		status=0;
	}
	else{
		status=1;
	} */
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