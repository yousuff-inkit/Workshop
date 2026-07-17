<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
String brdid=request.getParameter("brdid")==null?"0":request.getParameter("brdid");
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strbrand="select doc_no docno,vtype refname from gl_vehmodel where status=3 and brandid="+brdid;
	ResultSet rsbrand=stmt.executeQuery(strbrand);
	JSONArray brandarray=new JSONArray();
	while(rsbrand.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsbrand.getString("docno"));
		objtemp.put("refname",rsbrand.getString("refname"));
		brandarray.add(objtemp);
	}
	objdata.put("modeldata",brandarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>