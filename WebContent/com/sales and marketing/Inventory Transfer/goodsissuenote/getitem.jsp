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
	
	String strSql = "select costtype,costgroup from my_costunit where status=1";
	ResultSet rs = stmt.executeQuery(strSql);
	JSONArray itemarray=new JSONArray();
	while(rs.next()) {
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getString("costtype"));
		objtemp.put("refname",rs.getString("costgroup"));
		itemarray.add(objtemp);
	}
	stmt.close();
	conn.close();
	objdata.put("itemdata",itemarray);
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
  
 