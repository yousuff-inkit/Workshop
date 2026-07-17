<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String billtype=request.getParameter("billtype")==null?"":request.getParameter("billtype");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");

JSONObject objdata=new JSONObject();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	if(!mode.equalsIgnoreCase("2")){
		String strsql="";
		if(billtype.equalsIgnoreCase("1")){
			strsql="select coalesce(ac.refname,'') refname,ac.cldocno from ws_gateinpass gate left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where gate.doc_no="+gatedocno;
		}
		else if(billtype.equalsIgnoreCase("2")){
			strsql="select coalesce(ac.refname,'') refname,ac.cldocno from ws_gateinpass gate left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM' and gate.insurancecomp=1) where gate.doc_no="+gatedocno;
		}
		String cldocno="",refname="";
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			cldocno=rs.getString("cldocno");
			refname=rs.getString("refname");
		}
		objdata.put("cldocno",cldocno);
		objdata.put("refname", refname);
			
	}
	String strinsur="select ac.refname,ac.cldocno from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.dtype='CRM' and ac.status=3"+
	" and cat.status=3 and cat.insurance=1";
	JSONArray insurarray=new JSONArray();
	ResultSet rsinsur=stmt.executeQuery(strinsur);
	while(rsinsur.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsinsur.getString("refname"));
		objtemp.put("cldocno",rsinsur.getString("cldocno"));
		insurarray.add(objtemp);
	}
	objdata.put("insurarray",insurarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
