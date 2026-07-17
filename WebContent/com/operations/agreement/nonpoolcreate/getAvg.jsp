<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	
	String indate=request.getParameter("indate")==null?"":request.getParameter("indate");
	String closedate=request.getParameter("closedate")==null?"":request.getParameter("closedate");
	double inkm=Double.parseDouble(request.getParameter("inkm")==null?"0":request.getParameter("inkm"));
	double closekm=Double.parseDouble(request.getParameter("closekm")==null?"0":request.getParameter("closekm"));
	conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	java.sql.Date sqlindate=null,sqlclosedate=null;
	if(!(indate.equalsIgnoreCase(""))){
		sqlindate=objcommon.changeStringtoSqlDate(indate);
	}
	if(!(closedate.equalsIgnoreCase(""))){
		sqlclosedate=objcommon.changeStringtoSqlDate(closedate);
	}
	String strSql = "SELECT TIMESTAMPDIFF(MONTH, '"+sqlindate+"', '"+sqlclosedate+"') monthdiff";
	System.out.println("Month Difference Query:"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	int monthdiff=0;
	while(rs.next()){
		monthdiff=rs.getInt("monthdiff");
	}
	System.out.println("Month Difference:"+monthdiff);
	double totalkm=closekm-inkm;
	double avgkm=0.0;
	if(monthdiff==0){
		avgkm=totalkm;
	}
	else{
		avgkm=totalkm/monthdiff;
	}
			
	stmt.close();
	conn.close();

	response.getWriter().write(totalkm+"::"+avgkm);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>