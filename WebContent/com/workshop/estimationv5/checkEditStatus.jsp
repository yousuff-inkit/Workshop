<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
System.out.println("Parameter Recieved:"+docno);
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
	String str1="select * from ws_estspare where rdocno="+docno+" and  purchasereqdocno!=0 and  nipurchasedocno!=0 and goodsissuedocno!=0  ";
	System.out.println(str1);
	ResultSet rs1=stmt.executeQuery(str1);
	while(rs1.next()){
			status=2;	
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