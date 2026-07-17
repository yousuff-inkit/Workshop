<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connection.*"%>
<%
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").trim();
Connection conn=null;
JSONObject objdata=new JSONObject();
JSONArray gridarray=new JSONArray();
try{
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	if(mode.equalsIgnoreCase("1")){
		String strgetclient="select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		ResultSet rsgetclient=stmt.executeQuery(strgetclient);
		JSONArray clientarray=new JSONArray();
		while(rsgetclient.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("cldocno",rsgetclient.getInt("cldocno"));
			objtemp.put("refname",rsgetclient.getString("refname"));
			clientarray.add(objtemp);
		}
		JSONArray packagearray=new JSONArray();
		String strgetpackage="select doc_no,packagename from ws_packagem where status=3";
		ResultSet rsgetpackage=stmt.executeQuery(strgetpackage);
		while(rsgetpackage.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetpackage.getInt("doc_no"));
			objtemp.put("name",rsgetpackage.getString("packagename"));
			packagearray.add(objtemp);
		}
		objdata.put("clientdata",clientarray);
		objdata.put("packagedata",packagearray);
	}
	else if(mode.equalsIgnoreCase("2")){
		String strgetpackage="select cnt.doc_no,cnt.voc_no,cnt.date,cnt.fromdate,cnt.todate,ac.cldocno,ac.refname,cnt.remarks,pkg.packagename from ws_packagecontract cnt left join my_acbook ac on (cnt.cldocno=ac.cldocno and ac.dtype='CRM') left join ws_packagem"+
		" pkg on cnt.packagedocno=pkg.doc_no where cnt.status=3";
		ResultSet rsgetpackage=stmt.executeQuery(strgetpackage);
		gridarray=objcommon.convertToJSON(rsgetpackage);
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}

if(mode.equalsIgnoreCase("1")){
	response.getWriter().write(objdata+"");
}
else if(mode.equalsIgnoreCase("2")){
	response.getWriter().write(gridarray+"");
}
%>