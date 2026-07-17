<%@page import="com.operations.vehicletransactions.movement.ClsMovementDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
 	Connection conn = null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsMovementDAO objmov=new ClsMovementDAO();
	int status=0;
	String assignno=request.getParameter("assignno")==null?"":request.getParameter("assignno");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
	String time=request.getParameter("time")==null?"":request.getParameter("time");
	String km=request.getParameter("km")==null?"":request.getParameter("km");
	String fuel=request.getParameter("fuel")==null?"":request.getParameter("fuel");
	String movdocno=request.getParameter("movdocno")==null?"":request.getParameter("movdocno");
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String fleetno="",vehtrancode="",locationid="",totalkm="",outdriver="",closeremarks="";
	String strupdate="",strlocation="",strnrmdetails="",strassign="";
	java.sql.Date sqlclosedate=null;
	strlocation="select doc_no from my_locm where brhid="+branch+" and status=3 limit 1";
	System.out.println(strlocation);
	ResultSet rslocation =stmt.executeQuery(strlocation);
	
	while(rslocation.next()){
		locationid=rslocation.getString("doc_no");
	}
	
	if(!date.equalsIgnoreCase("")){
		sqlclosedate=objcommon.changeStringtoSqlDate(date);
	}
	
	strnrmdetails="select fleet_no,vehtrancode from gl_nrm where doc_no="+movdocno;
	System.out.println(strnrmdetails);
	ResultSet rsnrm=stmt.executeQuery(strnrmdetails);
	while(rsnrm.next()){
		fleetno=rsnrm.getString("fleet_no");
		vehtrancode=rsnrm.getString("vehtrancode");
	}
	strassign="select "+km+"-km totalkm,drid from gl_lvehassign where srno="+assignno;
	System.out.println(strassign);
	ResultSet rsassign=stmt.executeQuery(strassign);
	
	while(rsassign.next()){
		totalkm=rsassign.getString("totalkm");
		outdriver=rsassign.getString("drid");
	}
	closeremarks="Close Limousine Vehicle Movement of fleet"+fleetno;
	int movval=objmov.close(Integer.parseInt(movdocno), locationid, fuel, sqlclosedate, time, Float.parseFloat(km), closeremarks,Float.parseFloat(totalkm), 
	session,Integer.parseInt(fleetno), "", Float.parseFloat("0.0"),0, 0, null, "",Float.parseFloat("0.0"),"", locationid, "TR",0, outdriver, branch, branch, vehtrancode);
/* 	1711::1::0.750::2016-09-24::11:27::105380.0::Close Remarks of mov 1711::2.0::session::1010241::::0.0::0::0::null::::0.0::::1::TR::0::1::1::1::FS
	int docno,String cmbcloselocation,String cmbclosefuel,Date closedate,String closetime,float closekm,String closeremarks,float totalkm,
	HttpSession session,int txtfleetno,String accdetails,float accfines,int hidaccidents,int hidgaragecollect,Date garagecollectdate,String garagecollecttime,
	float garagecollectkm,String cmbgaragecollectfuel,String cmblocation,String cmbstatus,int hidchkgaragecollect,String hidclosedriver,
	String cmbclosebranch,String cmbbranch,String vehtrancode */
	if(movval>0){
		conn.setAutoCommit(false);
		strupdate="update gl_lvehassign set closedate='"+sqlclosedate+"',closetime='"+time+"',closekm="+km+",closefuel="+fuel+",clstatus=1 where srno="+assignno;
		System.out.println(strupdate);
		int val=stmt.executeUpdate(strupdate);
		if(val<0){
			status=0;
		}
		else{
			conn.commit();
			status=1;
		}	
	}
	
	stmt.close();
	response.getWriter().write(status+"");
}
catch(Exception e){
e.printStackTrace();
}
finally{
	conn.close();
}
%>