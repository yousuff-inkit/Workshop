<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	String strconfig="select method from gl_config where field_nme='locationMap'";
	ResultSet rsconfig=conn.createStatement().executeQuery(strconfig);
	int locationmap=0;
	while(rsconfig.next()){
		locationmap=rsconfig.getInt("method");
	}
	objdata.put("locationmap",locationmap);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>