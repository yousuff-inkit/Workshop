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
		sqltest+=" and job.brhid="+brhid;
	}

	String strcountdata="select count(pd.rdocno) pendingcount, count(nicd.rdocno) nipendingoncdcount, count(nipo.rdocno) nipendingonpocount " + 
			"from ws_jobcard job " + 
			"left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no  " + 
			"left join ws_gateinpass gate on est.gipno=gate.doc_no " + 
			"left join (select distinct rdocno from ws_estspare where approved=1 and (coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(cotqty,0)+coalesce(nipoqty,0)))>0) pd on pd.rdocno=est.doc_no  " + 
			"left join (select distinct rdocno from ws_estspare where approved=1 and (coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(nipurchaseqty,0)))>0 and coalesce(cotqty,0)>0) nicd on nicd.rdocno=est.doc_no  " + 
			"left join (select distinct rdocno from ws_estspare where approved=1 and (coalesce(qty,0)-(coalesce(goodsissueqty,0)+coalesce(nipurchaseqty,0)))>0 and coalesce(nipoqty,0)>0) nipo on nipo.rdocno=est.doc_no  " + 
			"where gate.processstatus<6" + sqltest;
	
	ResultSet rs=stmt.executeQuery(strcountdata);
	while(rs.next()){
		result=rs.getString("pendingcount")+"::"+rs.getString("nipendingoncdcount")+"::"+rs.getString("nipendingonpocount");
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