<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*"%>
<%
Connection conn=null;
String date=request.getParameter("date")==null?"":request.getParameter("date");
java.sql.Date sqldate=null;
try{
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select if('"+sqldate+"'=last_day('"+sqldate+"'),last_day('"+sqldate+"'),last_day(date_sub('"+sqldate+"',interval 1 month))) sqldate";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		sqldate=rs.getDate("sqldate");
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(sqldate+"");

%>