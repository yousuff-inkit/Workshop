<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    Connection conn = null;   
	JSONObject objdata=new JSONObject();
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0;
	String strSql = "select coalesce(method,0) method from gl_config where field_nme='alicevehiclehistoryprint'";                  
	//System.out.println("strSql===="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		val=rs.getInt("method");
  	}       
	String strrepairtype="select row_no,name from (select row_no,name,if(name='All',0,1) seqno from ws_gartype order by name) a order by a.seqno,a.name";
	JSONArray repairarray=new JSONArray();
	ResultSet rsrepair=stmt.executeQuery(strrepairtype);
	while(rsrepair.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("id",rsrepair.getString("row_no"));
		objtemp.put("name",rsrepair.getString("name"));
		repairarray.add(objtemp);
	}
	objdata.put("repairdata",repairarray);
	stmt.close();
	conn.close();  
	response.getWriter().print(val+"::"+objdata);           
}
catch(Exception e){
	e.printStackTrace();  
	conn.close();
}
	%>