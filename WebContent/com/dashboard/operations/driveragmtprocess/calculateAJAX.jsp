<%@page import="com.common.*"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
double normalovertime=Double.parseDouble((request.getParameter("normalovertime")==null || request.getParameter("normalovertime").equalsIgnoreCase("")?0.0:request.getParameter("normalovertime").toString())+"");
double holidayovertime=Double.parseDouble((request.getParameter("holidayovertime")==null || request.getParameter("holidayovertime").equalsIgnoreCase("")?0.0:request.getParameter("holidayovertime").toString())+"");
String closedate=request.getParameter("closedate")==null?"":request.getParameter("closedate");
String type=request.getParameter("type")==null?"":request.getParameter("type");

Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
double normalovertimeamt=0.0,holidayovertimeamt=0.0;
double ratesum=0.0;
java.sql.Date sqlclosedate=null;
if(!closedate.equalsIgnoreCase("")){
	sqlclosedate=objcommon.changeStringtoSqlDate(closedate);
}
int invpendingstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	double rate=0.0,normalovertimerate=0.0,holidayovertimerate=0.0;
	String invtype="",contracttype="";
	java.sql.Date invdate=null,invtodate=null;
	String stragmtdetails="select rate,normalovertime,holidayovertime,invdate,invtodate,invtype,contracttype from gl_drvagmt where doc_no="+agmtno;
	ResultSet rsagmtdetails=stmt.executeQuery(stragmtdetails);
	while(rsagmtdetails.next()){
		rate=rsagmtdetails.getDouble("rate");
		normalovertimerate=rsagmtdetails.getDouble("normalovertime");
		holidayovertimerate=rsagmtdetails.getDouble("holidayovertime");
		invtype=rsagmtdetails.getString("invtype");
		invdate=rsagmtdetails.getDate("invdate");
		invtodate=rsagmtdetails.getDate("invtodate");
		contracttype=rsagmtdetails.getString("contracttype");
		
	}
	String strmonthcal="select method,value from gl_config where field_nme='drvmonthlycal'";
	ResultSet rsmonthcal=stmt.executeQuery(strmonthcal);
	int monthcalmethod=0,monthcalvalue=0;
	while(rsmonthcal.next()){
		monthcalmethod=rsmonthcal.getInt("method");
		monthcalvalue=rsmonthcal.getInt("value");
	}
	
	normalovertimeamt=normalovertime*normalovertimerate;
	holidayovertimeamt=holidayovertime*holidayovertimerate;
	String strfrom="";
	
	if(invtype.equalsIgnoreCase("1")){
		strfrom="select if((select method from gl_config where field_nme='drvmonthlycal')=1,(select (DAY(LAST_DAY('"+invtodate+"')))) ,"+
				"(select value from gl_config where field_nme='drvmonthlycal')) monthcal";
	}
	else if(invtype.equalsIgnoreCase("2")){
		strfrom="select if((select method from gl_config where field_nme='drvmonthlycal')=1,"+
				" datediff('"+invtodate+"','"+invdate+"'),(select value from gl_config where field_nme='drvmonthlycal')) monthcal";
		
	}
	int monthcal=0;
	ResultSet rsmonthcalnew=stmt.executeQuery(strfrom);
	while(rsmonthcalnew.next()){
		monthcal=rsmonthcalnew.getInt("monthcal");
	}
	if(contracttype.equalsIgnoreCase("Daily")){
		monthcal=1;
	}
	String strtarifsum="";
	if(type.equalsIgnoreCase("invoice")){
		strtarifsum="select if((select method from gl_config where field_nme='drvmonthlycal')=1,(select (DAY(LAST_DAY('"+invtodate+"')))) ,"+
				"(select value from gl_config where field_nme='drvmonthlycal')) monthcal,"+
				" DATEDIFF('"+invtodate+"','"+invdate+"') datediff,"+
				" round(((select datediff)/(select "+monthcal+"))*rate,0) ratesum from gl_drvagmt where doc_no="+agmtno+"";		
	}

	else if(type.equalsIgnoreCase("close")){
		strtarifsum="select if((select method from gl_config where field_nme='drvmonthlycal')=1,(select (DAY(LAST_DAY('"+sqlclosedate+"')))) ,"+
				"(select value from gl_config where field_nme='drvmonthlycal')) monthcal,"+
				" DATEDIFF('"+sqlclosedate+"','"+invdate+"') datediff,"+
				" round(((select datediff)/(select "+monthcal+"))*rate,0) ratesum from gl_drvagmt where doc_no="+agmtno+"";		

	}
	
	ResultSet rstarifsum=stmt.executeQuery(strtarifsum);
	while(rstarifsum.next()){
		ratesum=rstarifsum.getDouble("ratesum");
	}
	
	if(invdate.compareTo(sqlclosedate)>0){
		invpendingstatus=1;
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(normalovertimeamt+"::"+holidayovertimeamt+"::"+ratesum+"::"+invpendingstatus);
%>