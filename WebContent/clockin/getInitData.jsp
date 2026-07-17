<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//get bays
	JSONArray bayarray=new JSONArray();
	String strgetbays="select doc_no docno,name refname from ws_bay where status=3";
	ResultSet rsgetbays=stmt.executeQuery(strgetbays);
	while(rsgetbays.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetbays.getString("docno"));
		objtemp.put("refname",rsgetbays.getString("refname"));
		bayarray.add(objtemp);
	}
	
	//getting config to show bay in clockin
	int bayconfig=0;
	String strbayconfig="select method from gl_config where field_nme='bayClockIn'";
	ResultSet rsbayconfig=stmt.executeQuery(strbayconfig);
	while(rsbayconfig.next()){
		bayconfig=rsbayconfig.getInt("method");
	}
	
	int autoSubmit=0;
	String strautosubmit="select method from gl_config where field_nme='clockinAutoSubmit'";
	ResultSet rsautosubmit=stmt.executeQuery(strautosubmit);
	while(rsautosubmit.next()){
		autoSubmit=rsautosubmit.getInt("method");
	}
	objdata.put("autosubmitconfig",autoSubmit);
	objdata.put("bayconfig",bayconfig);
	objdata.put("baydata",bayarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>