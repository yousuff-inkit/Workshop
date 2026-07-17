<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
String refno=request.getParameter("refno")==null?"":request.getParameter("refno").toString();
String errormsg="";
Connection conn=null;
double balance=0.0;
int exceedstatus=0;
double creditlimit=0.0;

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int cldocno=0;
	String strgetcldocno="";
	if(reftype.equalsIgnoreCase("GIP")){
		strgetcldocno="select gate.cldocno,round(coalesce(ac.credit,0),2) creditlimit from ws_gateinpass gate left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where gate.doc_no="+refno;
	}
	else if (reftype.equalsIgnoreCase("EST")){
		strgetcldocno="select gate.cldocno,round(coalesce(ac.credit,0),2) creditlimit from ws_estm est left join ws_gateinpass gate on est.gipno=gate.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where est.doc_no="+refno;
	}
	ResultSet rsgetcldocno=stmt.executeQuery(strgetcldocno);
	while(rsgetcldocno.next()){
		cldocno=rsgetcldocno.getInt("cldocno");
		creditlimit=rsgetcldocno.getDouble("creditlimit");
	}
	String strsql="select round(sum(j.dramount),2) balance,j.acno from my_jvtran j left join my_head h on h.doc_no=j.acno "+
	" left join my_acbook ac on (h.doc_no=ac.acno) where j.status=3 and j.yrid=0 and h.atype='AR' and ac.cldocno="+cldocno+" group by j.acno";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		balance=rs.getDouble("balance");
	}
	if(balance>creditlimit){
		exceedstatus=1;
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(balance+"::"+exceedstatus+"::"+creditlimit);
%>