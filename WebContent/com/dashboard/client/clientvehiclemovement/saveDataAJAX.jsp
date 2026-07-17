<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String time=request.getParameter("time")==null?"":request.getParameter("time");
String km=request.getParameter("km")==null?"":request.getParameter("km");
String fuel=request.getParameter("fuel")==null?"":request.getParameter("fuel");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String driver=request.getParameter("driver")==null?"":request.getParameter("driver");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String licenseno=request.getParameter("licenseno")==null?"":request.getParameter("licenseno");
String licenseexp=request.getParameter("licenseexp")==null?"":request.getParameter("licenseexp");
String idno=request.getParameter("idno")==null?"":request.getParameter("idno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String clientmovdocno=request.getParameter("clientmovdocno")==null?"":request.getParameter("clientmovdocno");
int status=0;
try{
	java.sql.Date sqldate=null,sqllicenseexp=null;
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	if(!licenseexp.equalsIgnoreCase("")){
		sqllicenseexp=objcommon.changeStringtoSqlDate(licenseexp);
	}
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	conn.setAutoCommit(false);
	int errorstatus=0;
	int maxdoc=0;
	if(desc.equalsIgnoreCase("IN")){
		String strmaxdoc="select coalesce(max(doc_no)+1,1) maxdoc from gl_clientvehmov";
		System.out.println("Max Doc Query :"+strmaxdoc);
		ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
		while(rsmaxdoc.next()){
			maxdoc=rsmaxdoc.getInt("maxdoc");
		}
		
		String strinsert="insert into gl_clientvehmov(doc_no,date,cldocno,fleetno,agmtno,drvname,drvlicense,drvlicenseexp,drvidno,drvmobile,status,branch)values("+
		" "+maxdoc+",CURDATE(),"+client+","+fleetno+","+agmtno+",'"+driver+"','"+licenseno+"','"+sqllicenseexp+"','"+idno+"','"+mobile+"',3,"+branch+")";
		System.out.println("Master Insert Query :"+strinsert);
		int insertval=stmt.executeUpdate(strinsert);
		if(insertval<=0){
			errorstatus=1;
		}
		else{
			String strupdateagmt="update gl_lagmt set clientvehstatus=1 where doc_no="+agmtno;
			System.out.println("Update Agmt Query :"+strupdateagmt);
	
			int updateagmt=stmt.executeUpdate(strupdateagmt);
			if(updateagmt<0){
				errorstatus=1;
			}
			else{
				String strinsertmov="insert into gl_clientmov(rdocno,fleet_no,opendate,opentime,openkm,openfuel,status)values("+maxdoc+","+fleetno+",'"+sqldate+"','"+time+"',"+km+","+fuel+",'OUT')";
				System.out.println("Mov Insert Query :"+strinsertmov);
				int insertmov=stmt.executeUpdate(strinsertmov);
				if(insertmov<=0){
					errorstatus=1;
				}
				else{
					
				}
			}
		}
	}
	else if(desc.equalsIgnoreCase("OUT")){
		String strupdatemov="update gl_clientmov set closedate='"+sqldate+"',closetime='"+time+"',closekm="+km+",closefuel='"+fuel+"',status='IN' where rdocno="+clientmovdocno;
		System.out.println("Mov Update Query :"+strupdatemov);
		int movupdate=stmt.executeUpdate(strupdatemov);
		if(movupdate<0){
			errorstatus=1;
		}
		else{
			String strupdateagmt="update gl_lagmt set clientvehstatus=0 where doc_no="+agmtno;
			System.out.println("Update Agmt Query :"+strupdateagmt);

			int updateagmt=stmt.executeUpdate(strupdateagmt);
			if(updateagmt<0){
				errorstatus=1;
			}
		}
	}
	if(errorstatus!=1){
		status=1;
		conn.commit();
	}
	else{
		status=0;
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