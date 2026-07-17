<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();	
	ResultSet rs=conn.createStatement().executeQuery("select concat(case when action='A' then 'Created' when action='E' then 'Edited' when action='D' then 'Deleted' else '' end,' on ',date_format(actiondate,'%d-%m-%Y %H:%i')) msg from ws_invm where doc_no="+docno);
	while(rs.next()){
		objdata.put("msg",rs.getString("msg"));
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>