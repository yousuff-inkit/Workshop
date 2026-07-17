<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ResultSet rsconfig=conn.createStatement().executeQuery("select method from gl_config where field_nme='insurTypeGrid'");
	int method=0;
	while(rsconfig.next()){
		method=rsconfig.getInt("method");
	}
	objdata.put("insurtypeconfig",method);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");

%>