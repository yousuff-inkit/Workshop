<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String policereport=request.getParameter("policereport")==null?"":request.getParameter("policereport");
String policedate=request.getParameter("policedate")==null?"":request.getParameter("policedate");
String policestation=request.getParameter("policestation")==null?"":request.getParameter("policestation");
String cmbinsurtype=request.getParameter("cmbinsurtype")==null || request.getParameter("cmbinsurtype").trim().equalsIgnoreCase("null")  || request.getParameter("cmbinsurtype").trim().equalsIgnoreCase("")?"0":request.getParameter("cmbinsurtype").trim();
String cmbfaulttype=request.getParameter("cmbfaulttype")==null || request.getParameter("cmbfaulttype").trim().equalsIgnoreCase("null")  || request.getParameter("cmbfaulttype").trim().equalsIgnoreCase("")?"0":request.getParameter("cmbfaulttype").trim();
String claim=request.getParameter("claim")==null?"0":request.getParameter("claim");
String lpo=request.getParameter("lpo")==null?"":request.getParameter("lpo");
String lpoamount=request.getParameter("lpoamount")==null || request.getParameter("lpoamount").trim().equalsIgnoreCase("")?"0":request.getParameter("lpoamount");
String chkexcess=request.getParameter("chkexcess")==null || request.getParameter("chkexcess").trim().equalsIgnoreCase("")?"0":request.getParameter("chkexcess");
String excessamount=request.getParameter("excessamount")==null || request.getParameter("excessamount").trim().equalsIgnoreCase("")?"0":request.getParameter("excessamount");

String chassisno=request.getParameter("chassisno")==null?"":request.getParameter("chassisno");
String username=request.getParameter("username")==null?"":request.getParameter("username");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String email=request.getParameter("email")==null?"":request.getParameter("email");
String vehregno=request.getParameter("vehregno")==null?"":request.getParameter("vehregno");
String vehplatecode=request.getParameter("vehplatecode")==null?"":request.getParameter("vehplatecode");
String group=request.getParameter("group")==null?"":request.getParameter("group");
String brandid=request.getParameter("brandid")==null || request.getParameter("brandid").equalsIgnoreCase("")?"0":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null || request.getParameter("modelid").equalsIgnoreCase("")?"0":request.getParameter("modelid");

String color=request.getParameter("color")==null || request.getParameter("color").trim().equalsIgnoreCase("")?"0":request.getParameter("color");
String yom=request.getParameter("yom")==null || request.getParameter("yom").trim().equalsIgnoreCase("")?"0":request.getParameter("yom");
String vehothers=request.getParameter("vehothers")==null || request.getParameter("vehothers").trim().equalsIgnoreCase("")?"":request.getParameter("vehothers");
String vehkm=request.getParameter("vehkm")==null || request.getParameter("vehkm").trim().equalsIgnoreCase("")?"0":request.getParameter("vehkm");
String fuel=request.getParameter("fuel")==null || request.getParameter("fuel").trim().equalsIgnoreCase("")?"0.000":request.getParameter("fuel");
String repairtype=request.getParameter("repairtype")==null || request.getParameter("repairtype").trim().equalsIgnoreCase("")?"0":request.getParameter("repairtype");
String priority=request.getParameter("priority")==null || request.getParameter("priority").trim().equalsIgnoreCase("")?"0":request.getParameter("priority");
String estdeldate=request.getParameter("estdeldate")==null || request.getParameter("estdeldate").trim().equalsIgnoreCase("")?"":request.getParameter("estdeldate");
String estdeltime=request.getParameter("estdeltime")==null || request.getParameter("estdeltime").trim().equalsIgnoreCase("")?"":request.getParameter("estdeltime");
String regexpdate=request.getParameter("regexpdate")==null || request.getParameter("regexpdate").trim().equalsIgnoreCase("")?"":request.getParameter("regexpdate");
System.out.println(docno+"::"+branch+"::"+remarks+"::"+policereport+"::"+policedate+"::"+policestation+"::"+cmbinsurtype+"::"+cmbfaulttype+"::"+lpo+"::"+lpoamount+"::"+chkexcess+"::"+excessamount);

String status="0";
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqlpolicedate=null,sqlestdeldate=null,sqlregexpdate=null;
	if(!policedate.equalsIgnoreCase("") && !policedate.equalsIgnoreCase("")){
		sqlpolicedate=objcommon.changeStringtoSqlDate(policedate);
	}
	if(!estdeldate.equalsIgnoreCase("") && !estdeldate.equalsIgnoreCase("undefined")){
		sqlestdeldate=objcommon.changeStringtoSqlDate(estdeldate);
	}
	if(!regexpdate.equalsIgnoreCase("") && !regexpdate.equalsIgnoreCase("undefined")){
		sqlregexpdate=objcommon.changeStringtoSqlDate(regexpdate);
	}
	int process=0;
	conn.setAutoCommit(false);
	String strprocess="select processstatus from ws_gateinpass where doc_no="+docno+" and brhid="+branch;
	System.out.println("Select Query:"+strprocess);
	ResultSet rsprocess=stmt.executeQuery(strprocess);
	while(rsprocess.next()){
		process=rsprocess.getInt("processstatus");
	}
	String sqltest="";
	
	if(sqlpolicedate!=null){
		sqltest+=",policerepdate='"+sqlpolicedate+"'";
	}
	else{
		sqltest+=",policerepdate=null";
	}
	if(sqlestdeldate!=null){
		sqltest+=",estdeldate='"+sqlestdeldate+"'";
	}
	else{
		sqltest+=",estdeldate=null";
	}
	if(estdeltime!=null && !estdeltime.trim().equalsIgnoreCase("undefined") && !estdeltime.trim().equalsIgnoreCase("")){
		sqltest+=",estdeltime='"+estdeltime+"'";
	}
	else{
		sqltest+=",estdeltime=''";
	}
	if(sqlregexpdate!=null){
		sqltest+=",regexpirydate='"+sqlregexpdate+"'";
	}
	else{
		sqltest+=",regexpirydate=null";
	}
	sqltest+=",colorid="+color+",yom="+yom+",vehother='"+vehothers+"',kmin="+vehkm+",fuel='"+fuel+"',repairtype="+repairtype+",priority="+priority+"";
	System.out.println("Process:"+process);
	if(process<7){
		String str="update ws_gateinpass set brdid="+brandid+",modid="+modelid+",username='"+username+"',mobile='"+mobile+"',email='"+email+"',other='"+chassisno+"',regno='"+vehregno+"',pltid='"+vehplatecode+"',mainremarks='"+remarks+"',policerep='"+policereport+"',stationname='"+policestation+"',"+
		" insutype='"+cmbinsurtype+"',faulttype='"+cmbfaulttype+"',claim='"+claim+"',lpo='"+lpo+"',lpoamount="+(lpoamount.equalsIgnoreCase("")?null:lpoamount)+","+
		" excess="+chkexcess+",excessamt="+(excessamount.equalsIgnoreCase("")?null:excessamount)+" "+sqltest+" where doc_no="+docno+" and brhid="+branch;
		System.out.println("Update Query:"+str);
		int updateval=stmt.executeUpdate(str);
		if(updateval>=0){
			status="1";
			conn.commit();
		}
		else{
			status="0";
		}
	}
	else{
		status="2";
	}
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
	status="0";
}
finally{
	conn.close();
}
response.getWriter().write(status);
%>