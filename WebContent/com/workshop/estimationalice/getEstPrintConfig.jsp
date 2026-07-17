<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
int status=0;   
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select method from gl_config where field_nme='PAGEstimationPrint'";   
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		status=rs.getInt("method");    
	}  
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().print(status);
%>