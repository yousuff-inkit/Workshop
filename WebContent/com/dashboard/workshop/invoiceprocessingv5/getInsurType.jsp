<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String insurcldocno=request.getParameter("insurcldocno")==null?"":request.getParameter("insurcldocno");
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ResultSet rs=conn.createStatement().executeQuery("select * from my_acinsurtype where rdocno="+insurcldocno+" and status=3");
	JSONArray dataarray=new JSONArray();
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getInt("rowno"));
		objtemp.put("typename",rs.getString("typename"));
		dataarray.add(objtemp);
	}
	objdata.put("typedata",dataarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
