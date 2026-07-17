<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strbrand="select doc_no docno,brand_name refname from gl_vehbrand where status=3";
	ResultSet rsbrand=stmt.executeQuery(strbrand);
	JSONArray brandarray=new JSONArray();
	while(rsbrand.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsbrand.getString("docno"));
		objtemp.put("refname",rsbrand.getString("refname"));
		brandarray.add(objtemp);
	}
	String strsql="select doc_no docno,enginesize from ws_enginesize where status<>7";
	ResultSet rs=conn.createStatement().executeQuery(strsql);
	JSONArray enginearray=new JSONArray();
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getString("docno"));
		objtemp.put("enginesize",rs.getString("enginesize"));
		enginearray.add(objtemp);
	}
	objdata.put("enginedata",enginearray);
	objdata.put("branddata",brandarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>