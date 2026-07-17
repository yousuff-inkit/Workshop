<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String masterdocno=request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno");
int status=0;
int count=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select count(*) rowcount from gl_leasecalcm where status=3 and reqdoc="+masterdocno;
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		count=rs.getInt("rowcount");
	}
	
	if(count>=1){
		status=0;
	}
	else{
		status=1;
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>