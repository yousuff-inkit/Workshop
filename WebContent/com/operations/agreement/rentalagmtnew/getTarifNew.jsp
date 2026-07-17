<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.*"%>
<%

Connection conn=null;
ClsConnection objconn=new ClsConnection();
String value="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select desc1,doc_no from gl_tariftype where status=1 and desc1 not in ('Promotion','Client','Corporate')";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		value+=rs.getString("desc1")+",";
	}
	if(value.length()>0){
		value=value.substring(0, value.length()-1);	
	}
	stmt.close();
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(value+"####"+value);
%>