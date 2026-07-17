<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
int errorstatus=0;
Connection conn=null;
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="";
	if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
		sqltest+=" and brhid="+brhid;
	}
	
	//Config for Hide data which are Gate Out Pass
	int hidegop=0;
	String strconfig="select method from gl_config where field_nme='HideGOPFloorDel'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	while(rsconfig.next()) {
		hidegop=rsconfig.getInt("method");
	}
	String sqljoin="";
	if(hidegop>0) {
		sqljoin="flr left join ws_jobcard job on flr.jobdocno=job.doc_no left join ws_estm est on job.refno=est.doc_no and job.reftype='EST' left join ws_gateinpass gate on est.gipno=gate.doc_no";
		sqltest+=" and gate.processstatus<8";
	}
	String strcountdata="select (select count(*) from ws_floormgmtdata "+sqljoin+" where totalloss=1 and deliverystatus=1 "+sqltest+") totallosscount,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and partsstatus like '%Delayed%' and deliverystatus=1 "+sqltest+") partsdelaycount,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and hrsdiff>0 and deliverystatus=1 "+sqltest+") hrsexceededcount,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and promiseddate<CURDATE() and deliverystatus=1 "+sqltest+") overduecount,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and extdate is not null and deliverystatus=1 "+sqltest+") extendeddatecount,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and priority='High' and deliverystatus=1 "+sqltest+") prioritycount,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where (z1 like '%N%' or z2 like '%N%'  or z3 like '%N%'  or z4 "+
	" like '%N%'  or z5 like '%N%' or z6 like '%N%'  or z7 like '%N%'  or z8 like '%N%'  or z12 like '%N%'  or z9 "+
	" like '%N%'  or z10 like '%N%'  or z11 like '%N%'  or z14 like '%N%' or z13 like '%N%') and deliverystatus=1 and completestatus=0 "+sqltest+") unattendedcount,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z1 like '%P%' and deliverystatus=1 "+sqltest+") z1count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z2 like '%P%' and deliverystatus=1 "+sqltest+") z2count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z3 like '%P%' and deliverystatus=1 "+sqltest+") z3count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z4 like '%P%' and deliverystatus=1 "+sqltest+") z4count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z5 like '%P%' and deliverystatus=1 "+sqltest+") z5count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z6 like '%P%' and deliverystatus=1 "+sqltest+") z6count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z7 like '%P%' and deliverystatus=1 "+sqltest+") z7count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z8 like '%P%' and deliverystatus=1 "+sqltest+") z8count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z9 like '%P%' and deliverystatus=1 "+sqltest+") z9count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z10 like '%P%' and deliverystatus=1 "+sqltest+") z10count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z11 like '%P%' and deliverystatus=1 "+sqltest+") z11count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z12 like '%P%' and deliverystatus=1 "+sqltest+") z12count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z13 like '%P%' and deliverystatus=1 "+sqltest+") z13count,"+
	" (select count(*) from ws_floormgmtdata "+sqljoin+" where completestatus=0 and z14 like '%P%' and deliverystatus=1 "+sqltest+") z14count";
	
	ResultSet rs=stmt.executeQuery(strcountdata);
	while(rs.next()){
		result=rs.getString("partsdelaycount")+"::"+rs.getString("hrsexceededcount")+"::"+rs.getString("overduecount")+"::"+rs.getString("extendeddatecount")+"::"+rs.getString("prioritycount")+"::"+rs.getString("unattendedcount")+"::"+rs.getString("z1count")+"::"+rs.getString("z2count")+"::"+rs.getString("z3count")+"::"+rs.getString("z4count")+"::"+rs.getString("z5count")+"::"+rs.getString("z6count")+"::"+rs.getString("z7count")+"::"+rs.getString("z8count")+"::"+rs.getString("z9count")+"::"+rs.getString("z10count")+"::"+rs.getString("z11count")+"::"+rs.getString("z12count")+"::"+rs.getString("z13count")+"::"+rs.getString("z14count")+"::"+rs.getString("totallosscount");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>