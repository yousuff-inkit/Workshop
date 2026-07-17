<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="com.operations.saleofvehicle.vehiclestatuschange.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.Statement"%>

<%
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
int fleetno=Integer.parseInt(request.getParameter("fleetno"));
java.sql.Date sqlfleetdate=null;
String fleetdate=request.getParameter("fleetdate")==null?"":request.getParameter("fleetdate");
if(!fleetdate.equalsIgnoreCase("")){
	sqlfleetdate=objcommon.changetstmptoSqlDate(fleetdate);
}
String fleettime=request.getParameter("fleettime");
String branchid=request.getParameter("branch");
String status=request.getParameter("status");
String tempstatus="";
ClsFleetStatusChangeDAO objstatus=new ClsFleetStatusChangeDAO();
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int val=objstatus.insert(sqlfleetdate,fleettime,fleetno,"UR",status,"",session,"A","VSC",branchid);
	if(val>0){
		String strinsert="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values"+
				" ("+val+",'"+branchid+"','BVSC',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		int val2=stmt.executeUpdate(strinsert);
		if(val2>0){
			tempstatus="1";
		}
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();	
}
finally{
	conn.close();
}

response.getWriter().write(tempstatus);
	
  %>