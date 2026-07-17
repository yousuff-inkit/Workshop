<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@page import="com.common.*"%>

<%
	System.out.println("Here");
 	Connection conn = null;
 	ClsConnection objconn=new ClsConnection();
 	ClsCommon objcommon=new ClsCommon();
 	try{
 		conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String docno=request.getParameter("docno");
	String fleet=request.getParameter("fleet");
	String regno=request.getParameter("regno");
	String client=request.getParameter("client");
	String date=request.getParameter("date");
	java.sql.Date sqlStartDate=null;
	if(!((date.equalsIgnoreCase(""))||(date.equalsIgnoreCase(null)))){
		sqlStartDate = objcommon.changeStringtoSqlDate(date);
	}
	
	System.out.println("Date"+sqlStartDate);
	String mobile=request.getParameter("mobile");
	String sqltest="";
	if(!(docno.equalsIgnoreCase(""))){
		sqltest=" and m1.doc_no='"+docno+"'";
	}
	if(!(fleet.equalsIgnoreCase(""))){
		sqltest=sqltest+" and m1.fleet_no='"+fleet+"'";
	}
	if(!(regno.equalsIgnoreCase(""))){
		sqltest=sqltest+" and m2.reg_no='"+regno+"'";
	}
	if(!(client.equalsIgnoreCase(""))){
		sqltest=sqltest+" and m3.refname='"+client+"'";
	}
	if(!(mobile.equalsIgnoreCase(""))){
		sqltest=sqltest+" and m3.per_mob='"+mobile+"'";
	}
	if(!(sqlStartDate==null)){
		sqltest=sqltest+" and m1.date='"+sqlStartDate+"'";
	}
	System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
	JSONArray jsonArray = new JSONArray();
	 String strSql = "select m1.doc_no,m1.date,m1.fleet_no,m1.brhid,m2.reg_no,c1.color,g1.gid,m3.refname,m3.address,m3.mail1,m3.per_mob from"+
		 " gl_ragmt m1 left join gl_vehmaster m2 on m1.fleet_no=m2.fleet_no left join my_color c1 on m2.clrid=c1.doc_no left"+
	 " join gl_vehgroup g1 on m2.vgrpid=g1.doc_no left join my_acbook m3 on m1.acno=m3.acno where m1.clstatus=0 "+sqltest;
	 System.out.println(strSql);
	ResultSet resultSet = stmt.executeQuery(strSql);
	stmt.close();
	conn.close();
	System.out.println(jsonArray);
	response.getWriter().write(jsonArray.toString());
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		conn.close();
 	}
%>