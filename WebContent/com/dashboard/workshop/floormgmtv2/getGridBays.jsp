<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	Connection conn=null;
	JSONObject data=new JSONObject();
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strsql="select doc_no,code,name,status from ws_bay";
		ResultSet rs=stmt.executeQuery(strsql);
		JSONArray bayarray=new JSONArray();
		
		while(rs.next()){
			JSONObject temp=new JSONObject();
			temp.put("docno",rs.getString("doc_no"));
			temp.put("code",rs.getString("code"));
			temp.put("status",rs.getInt("status"));
			bayarray.add(temp);
		}
		data.put("baydata",bayarray);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(data+"");
%>