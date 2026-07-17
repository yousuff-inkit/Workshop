<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String teamdata="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select doc_no,description from ws_teammasterm where status=3";
	ResultSet rs=stmt.executeQuery(strsql);
	int i=0;
	while(rs.next()){
		if(i==0){
			teamdata=rs.getString("doc_no")+"::"+rs.getString("description");
		}
		else{
			teamdata+=","+rs.getString("doc_no")+"::"+rs.getString("description");
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
response.getWriter().write(teamdata);
%>