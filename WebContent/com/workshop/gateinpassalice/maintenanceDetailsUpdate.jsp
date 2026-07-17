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
String cmbinsurtype=request.getParameter("cmbinsurtype")==null?"":request.getParameter("cmbinsurtype");
String cmbfaulttype=request.getParameter("cmbfaulttype")==null?"":request.getParameter("cmbfaulttype");
String claim=request.getParameter("claim")==null?"":request.getParameter("claim");
String lpo=request.getParameter("lpo")==null?"":request.getParameter("lpo");
String lpoamount=request.getParameter("lpoamount")==null?"":request.getParameter("lpoamount");
String chkexcess=request.getParameter("chkexcess")==null?"0":request.getParameter("chkexcess");
String excessamount=request.getParameter("excessamount")==null?"":request.getParameter("excessamount");
System.out.println(docno+"::"+branch+"::"+remarks+"::"+policereport+"::"+policedate+"::"+policestation+"::"+cmbinsurtype+"::"+cmbfaulttype+"::"+lpo+"::"+lpoamount+"::"+chkexcess+"::"+excessamount);
String status="0";
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqlpolicedate=null;
	if(!policedate.equalsIgnoreCase("")){
		sqlpolicedate=objcommon.changeStringtoSqlDate(policedate);
	}
	int process=0;
	conn.setAutoCommit(false);
	String strprocess="select processstatus from ws_gateinpass where doc_no="+docno+" and brhid="+branch;
	System.out.println("Select Query:"+strprocess);
	ResultSet rsprocess=stmt.executeQuery(strprocess);
	while(rsprocess.next()){
		process=rsprocess.getInt("processstatus");
	}
	System.out.println("Process:"+process);
	if(process<7){
		String str="update ws_gateinpass set mainremarks='"+remarks+"',policerep='"+policereport+"',policerepdate='"+sqlpolicedate+"',stationname='"+policestation+"',"+
		" insutype='"+cmbinsurtype+"',faulttype='"+cmbfaulttype+"',claim='"+claim+"',lpo='"+lpo+"',lpoamount="+(lpoamount.equalsIgnoreCase("")?null:lpoamount)+","+
		" excess="+chkexcess+",excessamt="+(excessamount.equalsIgnoreCase("")?null:excessamount)+" where doc_no="+docno+" and brhid="+branch;
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