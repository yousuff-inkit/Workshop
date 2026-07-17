<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");

System.out.println("Inside Checking Depr");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int status=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select last_day(date_sub(indate,interval 1 month))<depr_date status from gl_vehmaster  v "+
			"left join gl_lagmtclosem l on l.fleet_no=v.fleet_no where v.fleet_no= "+fleetno;
	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		status=rs.getInt("status");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
System.out.println("Depr Status: "+status);
response.getWriter().write(status+"");
%>