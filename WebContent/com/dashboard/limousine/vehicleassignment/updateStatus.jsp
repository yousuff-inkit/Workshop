
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
 <%@page import="com.dashboard.limousine.vehicleassignment.*"%> 
<%@page import="com.common.*"%>
<%@page import="com.operations.vehicletransactions.movement.*"%>
<%@page import="java.sql.Statement"%>

<%
/* int fleetno=Integer.parseInt(request.getParameter("fleetno"));
java.sql.Date fleetdate=ClsCommon.changetstmptoSqlDate(request.getParameter("fleetdate"));
 String fleettime=request.getParameter("fleettime");
 
String branchid=request.getParameter("branch");
String status=request.getParameter("fuel"); */
ClsConnection ClsConnection=new ClsConnection();
ClsMovementDAO movdao=new ClsMovementDAO();
ClsCommon ClsCommon=new ClsCommon();

String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String driverdocno=request.getParameter("driverdocno")==null?"":request.getParameter("driverdocno");
String fleetdate=request.getParameter("fleetdate")==null?"":request.getParameter("fleetdate");
String fleettime=request.getParameter("fleettime")==null?"":request.getParameter("fleettime");
String km=request.getParameter("km")==null?"":request.getParameter("km");
String fuel=request.getParameter("fuel")==null?"":request.getParameter("fuel");
String userid=session.getAttribute("USERID").toString();
String companyid=session.getAttribute("COMPANYID").toString();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
Connection conn=null;

	java.sql.Date sqlfleetdate = null;
    System.out.println("FleetDate: "+fleetdate);
 	if(!fleetdate.equalsIgnoreCase("undefined") && !fleetdate.equalsIgnoreCase("") && !fleetdate.equalsIgnoreCase("0")){
 		sqlfleetdate=ClsCommon.changeStringtoSqlDate(fleetdate);
 	}
 	String tempstatus="";
 
 	try{
	 	conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		//
		
		java.sql.Date sqlcurrentdate=null;
		String strgetmovdetails="select CURDATE() currentdate";
		ResultSet rsmovdetails=stmt.executeQuery(strgetmovdetails);
		while(rsmovdetails.next()){
			sqlcurrentdate=rsmovdetails.getDate("currentdate");
		}
		String strvehtrancode="select (select tran_code from gl_vehmaster where fleet_no="+fleetno+") tran_code,(select doc_no from my_locm where brhid="+branch+""+
		" and status=3 limit 1) locid";
		String vehtrancode="",outlocation="";
		ResultSet rsveh=stmt.executeQuery(strvehtrancode);
		while(rsveh.next()){
			vehtrancode=rsveh.getString("tran_code");
			outlocation=rsveh.getString("locid");
		}
		String remarks="Limousine vehicle movement of fleet "+fleetno;
		
		int movinsert=movdao.insert(sqlcurrentdate,sqlfleetdate,Integer.parseInt(fleetno),outlocation,fleettime,km,fuel,"TR",driverdocno,remarks,userid,null,0,null,0.0,null,null,
		"A", session, 0, 0, 0, 0,0, "MOV", branch, vehtrancode);
		if(movinsert>0){
			//conn.commit();
			conn.setAutoCommit(false);
			String strinsert="insert into gl_lvehassign (fleet_no, drid, date, time, km, fuel, brhid, userid, ins_date,movdocno) values"+
					" ("+fleetno+",'"+driverdocno+"','"+sqlfleetdate+"','"+fleettime+"','"+km+"','"+fuel+"','"+branch+"','"+userid+"', NOW(),"+movinsert+")";
			int assigninsert=stmt.executeUpdate(strinsert);
			if(assigninsert>0){
				String masterupdate="update gl_vehmaster set assign=1 WHERE fleet_no="+fleetno;	
				int vehupdate=stmt.executeUpdate(masterupdate);
				if(vehupdate>0){
					conn.commit();	
					tempstatus="1";		
				}
			}
		}
		stmt.close();
		
 	}catch(Exception e){	
		 e.printStackTrace();
		
	}
 	finally{
 		conn.close();
 	}
		
	//String tempstatus="1";
	response.getWriter().write(tempstatus); 
	
  %>