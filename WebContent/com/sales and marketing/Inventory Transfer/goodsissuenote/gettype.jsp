<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

Connection conn =null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection ClsConnection=new ClsConnection();
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	String strSql = "select doc_no,type from my_issuetype where status=3;";
	ResultSet rs = stmt.executeQuery(strSql);
	JSONArray typearray=new JSONArray();
	while(rs.next()) {
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getString("doc_no"));
		objtemp.put("refname",rs.getString("type"));
		typearray.add(objtemp);
	}
	stmt.close();
	conn.close();
	objdata.put("typedata",typearray);
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
finally{
	if(!conn.isClosed()){
		conn.close();
	}
}
response.getWriter().write(objdata+"");
%>
  
