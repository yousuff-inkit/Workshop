<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%
String invoice=request.getParameter("invoice")==null?"":request.getParameter("invoice");
String reciepts=request.getParameter("reciepts")==null?"":request.getParameter("reciepts");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int val=0;
try{
	int invupdateval=0,rentalupdateval=0;
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	if(!invoice.equalsIgnoreCase("")){
		String str="update gl_invm set exportstatus=1 where doc_no in ("+invoice+")";
		System.out.println(str);
		invupdateval=stmt.executeUpdate(str);
		
	}
	if(!reciepts.equalsIgnoreCase("")){
		String str="update gl_rentreceipt set exportstatus=1 where srno in ("+reciepts+")";
		System.out.println(str);
		rentalupdateval=stmt.executeUpdate(str);
		
	}
	if(invupdateval>0 || rentalupdateval>0){
		conn.commit();
		val=1;
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(val+"");
%>