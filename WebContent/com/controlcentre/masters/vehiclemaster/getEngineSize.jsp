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
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>
