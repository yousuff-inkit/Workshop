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
	Connection conn = null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	conn= objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String docno=request.getParameter("docno");
	String fleet=request.getParameter("fleet");
	String regno=request.getParameter("regno");
	String client=request.getParameter("client");
	String date=request.getParameter("date");
	String agmttype=request.getParameter("agmttype");
	java.sql.Date sqlStartDate = objcommon.changeStringtoSqlDate(date);
	System.out.println("Date"+sqlStartDate);
	String mobile=request.getParameter("mobile");
	String sqltest="";
	if(!(docno.equalsIgnoreCase(""))){
		sqltest=" and agmt.doc_no='"+docno+"'";
	}
	if(!(fleet.equalsIgnoreCase(""))){
		sqltest=sqltest+" and agmt.fleet_no='"+fleet+"'";
	}
	if(!(regno.equalsIgnoreCase(""))){
		sqltest=sqltest+" and veh.reg_no='"+regno+"'";
	}
	if(!(client.equalsIgnoreCase(""))){
		sqltest=sqltest+" and ac.refname='"+client+"'";
	}
	if(!(mobile.equalsIgnoreCase(""))){
		sqltest=sqltest+" and ac.per_mob='"+mobile+"'";
	}
	System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
	JSONArray jsonArray = new JSONArray();
String strSql="";
	if(agmttype.equalsIgnoreCase("RA")){
	strSql="select agmt.doc_no,,agmt.date,agmt.fleet_no,mov.dout,mov.tout,mov.kmout,mov.fout,mov.obrhid,mov.olocid,veh.flname,veh.reg_no,ac.refname,br.branchname,"+
	" loc.loc_name from gl_ragmt agmt left join gl_vmove mov on(agmt.doc_no=mov.rdocno and mov.rdtype='RAG') left join gl_vehmaster veh"+
	" on agmt.fleet_no=veh.fleet_no left join my_acbook ac on agmt.cldocno=ac.cldocno left join my_brch br on mov.obrhid=br.doc_no"+
	" left join my_locm loc on mov.olocid=loc.doc_no where mov.status='OUT'"+sqltest;
	}
	/*  strSql = "select m1.doc_no,m1.edate,m1.flno,m1.branch,m2.reg_no,c1.color,g1.gid,m3.refname,m3.address,m3.mail1,m3.per_mob from gl_rentalagmt m1"+ 
	 " left join gl_vehmaster m2 on m1.flno=m2.fleet_no left join my_color c1 on m2.clrid=c1.doc_no left join gl_vehgroup g1 on m2.vgrpid=g1.doc_no "+
	 "left join my_acbook m3 on m1.acc_no=m3.acno where m1.clstatus=0"+sqltest; */
	 
	 
	 
		/* 	 select m1.doc_no,m1.edate,m1.flno,m1.branch,m2.flname,m2.reg_no,c1.color,g1.gid,m3.refname,m3.address,m3.mail1,m3.per_mob from gl_rentalagmt m1"+ 
	 " left join gl_vehmaster m2 on m1.flno=m2.fleet_no left join my_color c1 on m2.clrid=c1.doc_no left join gl_vehgroup g1 on m2.vgrpid=g1.doc_no "+
	 "left join my_acbook m3 on m1.acc_no=m3.acno where m1.clstatus=0 */
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