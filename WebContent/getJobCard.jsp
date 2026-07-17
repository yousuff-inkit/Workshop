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
	strsql="select doc_no,voc_no from ws_jobcard where complete=0 and status=3";
	ResultSet rs=stmt.executeQuery(strsql);
	int i=0;
	while(rs.next()){
		if(i==0){
			jobdata=rs.getString("doc_no")+"::"+rs.getString("voc_no");
		}
		else{
			jobdata+=","+rs.getString("doc_no")+"::"+rs.getString("voc_no");
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