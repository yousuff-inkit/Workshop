<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobdata="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="";
	strsql="select doc_no,name from ws_technician where status=3";
	ResultSet rs=stmt.executeQuery(strsql);
	int i=0;
	while(rs.next()){
		if(i==0){
			jobdata=rs.getString("doc_no")+"::"+rs.getString("name");
		}
		else{
			jobdata+=","+rs.getString("doc_no")+"::"+rs.getString("name");
		}
		i++;
	}

	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(jobdata);
%>