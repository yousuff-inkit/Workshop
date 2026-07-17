<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
String larefdocno=request.getParameter("larefdocno")==null?"":request.getParameter("larefdocno");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
double advance=0.0;
int installments=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select round(advance,0) advance,installments from gl_leaseappd where rdocno="+larefdocno;
	System.out.println("====== "+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		advance=rs.getDouble("advance");
		installments=rs.getInt("installments");
	}
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
	
}
response.getWriter().write(advance+"::"+installments);

%>