<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String employee=request.getParameter("employee")==null?"":request.getParameter("employee");
String employeename="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="";
	if(!employee.equalsIgnoreCase("")){
		strsql="select name from ws_technician where status=3 and doc_no="+employee;
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			employeename=rs.getString("name");
		}		
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(employeename);
%>