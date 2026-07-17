<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
Connection conn = null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	String date=request.getParameter("indate")==null?"":request.getParameter("indate");
	java.sql.Date sqldate=null;
	if(!(date.equalsIgnoreCase(""))){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	conn=objconn.getMyConnection();
	int fuelstatus=0;
	int fuelmethod=0;
	Statement stmtfuel=conn.createStatement();
	String strfuelconfig="select method from gl_config where field_nme='fuelrate'";
	ResultSet rsfuelconfig=stmtfuel.executeQuery(strfuelconfig);
	while(rsfuelconfig.next()){
		fuelmethod=rsfuelconfig.getInt("method");
	}
	if(fuelmethod==1){
		fuelstatus=0;
	}
	else if(fuelmethod==0){
		String strfuelcharge="select ptlchg prate,deslchg drate from gl_fuelcharge where status<>7 and doc_no=(select max(doc_no)"+
				" from gl_fuelcharge where '"+sqldate+"' between frmdate and todate)";
		ResultSet rsfuelcharge=stmtfuel.executeQuery(strfuelcharge);
		if(rsfuelcharge.next()){
			fuelstatus=0;
		}
		else{
			fuelstatus=1;
		}
	}
	stmtfuel.close();
	//System.out.println("Fuel Status:"+fuelstatus);
	response.getWriter().print(fuelstatus+"");

}
catch(Exception e1){
	e1.printStackTrace();
	conn.close();
}
finally{
	
	conn.close();
}
%>