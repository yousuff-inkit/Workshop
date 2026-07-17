<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="",sqlbranch="";
	int method=0;
	String strgetclient="select coalesce(method,0) method from  gl_config where field_nme='Inspection'";
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);
	while(rsgetclient.next()){
		method= rsgetclient.getInt("method");
	}
	int qotapprconfig=0;
	String strqotappr="select coalesce(method,0) method from  gl_config where field_nme='WSQotApprHide'";
	ResultSet rsqotappr=stmt.executeQuery(strqotappr);
	while(rsqotappr.next()){
		qotapprconfig= rsqotappr.getInt("method");
	}
	int checklistconfig=0;
	String strchecklist="select coalesce(method,0) method from  gl_config where field_nme='gipmgmtchecklist'";
	ResultSet rschecklist=stmt.executeQuery(strchecklist);
	while(rschecklist.next()){
		checklistconfig= rschecklist.getInt("method");
	}

	int smsconfig=0;
	String strsmsconfig="select coalesce(method,0) method from  gl_config where field_nme='GIPMgmtSMS'";
	ResultSet rssmsconfig=stmt.executeQuery(strsmsconfig);
	while(rssmsconfig.next()){
		smsconfig=rssmsconfig.getInt("method");
	}	
	
	//System.out.println("attachcount=="+attachcount);
	response.getWriter().print(method+"::"+qotapprconfig+"::"+checklistconfig+"::"+smsconfig);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}

%>