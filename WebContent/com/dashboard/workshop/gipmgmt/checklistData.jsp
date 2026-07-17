<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null||request.getParameter("gatedocno")==""?"0":request.getParameter("gatedocno");
String policereportno=request.getParameter("policereportno")==null|| request.getParameter("policereportno")==""?"":request.getParameter("policereportno");
String policereportdate=request.getParameter("policereportdate")==null|| request.getParameter("policereportdate")==""?"":request.getParameter("policereportdate");
String regexpirydate=request.getParameter("regexpirydate")==null|| request.getParameter("regexpirydate")==""?"":request.getParameter("regexpirydate");
String drvlicence=request.getParameter("drvlicence")==null|| request.getParameter("drvlicence")==""?"0":request.getParameter("drvlicence");
String emiratesid=request.getParameter("emiratesid")==null|| request.getParameter("emiratesid")==""?"0":request.getParameter("emiratesid");
String carcolor=request.getParameter("carcolor")==null|| request.getParameter("carcolor")==""?"0":request.getParameter("carcolor");
String claimtype=request.getParameter("claimtype")==null|| request.getParameter("claimtype")==""?"0":request.getParameter("claimtype");
String priority=request.getParameter("priority")==null|| request.getParameter("priority")==""?"0":request.getParameter("priority");
String estimator=request.getParameter("estimator")==null|| request.getParameter("estimator")==""?"0":request.getParameter("estimator");
String instype=request.getParameter("instype")==null|| request.getParameter("instype")==""?"0":request.getParameter("instype");
String chklistremarks=request.getParameter("chklistremarks")==null|| request.getParameter("chklistremarks")==""?"":request.getParameter("chklistremarks");
String referencedby=request.getParameter("referencedby")==null|| request.getParameter("referencedby")==""?"0":request.getParameter("referencedby");

//System.out.println("policereportno"+policereportno+"policereportdate"+policereportdate+"regexpirydate"+regexpirydate+"drvlicence"+drvlicence+"emiratesid"+emiratesid+"carcolor"+carcolor+"claimtype"+claimtype+"priority"+priority+"estimator"+estimator);
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();

Connection conn=null;
int errorstatus=0, value=0;
try{
	conn=objconn.getMyConnection();

	conn.setAutoCommit(false);
	java.sql.Date sqlpolicereportdate=null,sqlregexpirydate=null;
String sqlspolicereportdate="",sqlsregexpirydate="";
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	ArrayList<String> estarray=new ArrayList();
	if(!(policereportdate.equalsIgnoreCase("") || policereportdate.equalsIgnoreCase("null"))){
		sqlpolicereportdate=objcommon.changeStringtoSqlDate(policereportdate);
		sqlspolicereportdate=",policerepdate='"+sqlpolicereportdate+"' ";
	}
	if(!(regexpirydate.equalsIgnoreCase("") || regexpirydate.equalsIgnoreCase("null"))){
		sqlregexpirydate=objcommon.changeStringtoSqlDate(regexpirydate);
		sqlsregexpirydate=",regexpirydate='"+sqlregexpirydate+"' ";

	}
	
		String strsql="";
			
				strsql="update ws_gateinpass set policerep='"+policereportno+"'"+sqlspolicereportdate+""+sqlsregexpirydate+",drvlicence='"+drvlicence+"',emiratesid='"+emiratesid+"',colorid='"+carcolor+"',faulttype='"+claimtype+"',priority='"+priority+"',marketingperson='"+estimator+"',insutype='"+instype+"',remarks='"+chklistremarks+"',referencedby='"+referencedby+"' where doc_no='"+gatedocno+"'" ;
				System.out.println(" update: "+strsql);
			
			 value=stmt.executeUpdate(strsql);
			//System.out.println("Insert Value:"+value);
			if(value>0 ){
				conn.commit();

				errorstatus=1;
			}
			//System.out.println("errorstatus Value:"+errorstatus);
		
	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>