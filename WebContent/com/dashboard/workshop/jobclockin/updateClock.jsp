<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<% 

ClsConnection connDAO = new ClsConnection();
ClsCommon commonDAO= new ClsCommon();
Connection conn=null;
String clockDocno=request.getParameter("clockDocno")==null?"":request.getParameter("clockDocno");
String jobcard=request.getParameter("jobcard")==null?"":request.getParameter("jobcard");
String techid=request.getParameter("techid")==null?"":request.getParameter("techid");
String startdate=request.getParameter("startdate")==null?"":request.getParameter("startdate");

java.sql.Date sqlstartdate=null;
if(!startdate.equalsIgnoreCase("") && startdate!=null){
	sqlstartdate=commonDAO.changeStringtoSqlDate(startdate);
}

String starttime=request.getParameter("starttime")==null?"":request.getParameter("starttime");

//String excessamt=request.getParameter("excessamt")==null || request.getParameter("excessamt").equalsIgnoreCase("")?"0":request.getParameter("excessamt");


int errorstatus=0;
int x=0,y=0,z=0,p=0,q=0;
try{
	 conn=connDAO.getMyConnection();
	 conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement();
		
		
		
		String strSql1 = "insert into ws_clockin(jcno,technicianid,startdate,starttime) values(?,?,?,?)";
		
		PreparedStatement ps=conn.prepareStatement(strSql1);	
		ps.setString(1, jobcard);
		ps.setString(2, techid);
		ps.setDate(3, sqlstartdate);
		ps.setString(4, starttime);	
		x=ps.executeUpdate();
		

		

		if(x<=0){
			errorstatus=1;
		}
		
		if(errorstatus==0){
			conn.commit();
		}
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>