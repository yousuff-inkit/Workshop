<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
try{
	String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date datein=null;
	String timein="";
	int outstatus=0;
	double kmin=0.0,fuelin=0.0;
	String sql="select (select count(*) count from gl_vmove where fleet_no="+fleetno+" and status='OUT') outstatus,din,tin,kmin,fin from gl_vmove where fleet_no="+fleetno+" and doc_no=(select max(doc_no) from gl_vmove where fleet_no="+fleetno+")";
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){
		datein=rs.getDate("din");
		timein=rs.getString("tin");
		kmin=rs.getDouble("kmin");
		fuelin=rs.getDouble("fin");
		
	}

	stmt.close();
	conn.close();
	response.getWriter().write(datein+"::"+timein+"::"+kmin+"::"+fuelin+"::"+outstatus);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>