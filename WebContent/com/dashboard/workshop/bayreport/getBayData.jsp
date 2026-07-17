<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	conn=objconn.getMyConnection();
	
	Statement stmt=conn.createStatement();
	String strsql="";
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
	String sqltest="";
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	if(sqlfromdate!=null){
		sqltest+=" and gatein.indate>='"+sqlfromdate+"'";
	}
	if(sqltodate!=null){
		sqltest+=" and gatein.indate<='"+sqltodate+"'";
	}
	if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
		sqltest+=" and gatein.brhid="+branch;
	}
	String str="select veh.flname,veh.reg_no,bay.name,gatein.fleet_no,date_format(gatein.indate,'%d-%m-%Y') indate,gatein.intime,m.esttime,"+
	" date_format(m.estdate,'%d-%m-%Y') estdate,round((timestampdiff(minute,concat(gatein.indate,' ',gatein.intime),concat(CURDATE(),' ',"+
	" CURTIME())))/60,2) usedtime,round((timestampdiff(minute,concat(gatein.indate,' ',gatein.intime),concat(m.estdate,' ',m.esttime)))"+
	" /60,2) esttimediff from gl_worksrvcadvisorm m left join gl_workgateinpassm gatein on m.gateinpassdocno=gatein.doc_no left join"+
	" gl_workbay bay on m.bayid=bay.doc_no left join gl_vehmaster veh on gatein.fleet_no=veh.fleet_no where gatein.outstatus=0 "+
	" "+sqltest+" order by m.bayid,timestamp(concat(gatein.indate,' ',gatein.intime)) desc";
	System.out.println(str);
	ResultSet rs=stmt.executeQuery(str);
	int i=0;
	String temp="";
	
	while(rs.next()){
		int delaystatus=0;
		if(rs.getDouble("usedtime")>rs.getDouble("esttimediff")){
			delaystatus=1;
		}
		if(i==0){
			temp+=rs.getString("name")+"::"+rs.getString("fleet_no")+"::"+rs.getString("indate")+"::"+rs.getString("intime")+"::"+rs.getString("esttime")+"::"+rs.getString("usedtime")+"::"+delaystatus+"::"+rs.getString("flname")+"::"+rs.getString("reg_no")+"::"+rs.getString("estdate");
		}
		else{
			temp+=","+rs.getString("name")+"::"+rs.getString("fleet_no")+"::"+rs.getString("indate")+"::"+rs.getString("intime")+"::"+rs.getString("esttime")+"::"+rs.getString("usedtime")+"::"+delaystatus+"::"+rs.getString("flname")+"::"+rs.getString("reg_no")+"::"+rs.getString("estdate");
		}
		i++;
	}
	stmt.close();
	response.getWriter().write(temp);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
