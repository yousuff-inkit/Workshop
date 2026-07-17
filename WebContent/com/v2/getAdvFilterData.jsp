<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
String widgettype=request.getParameter("widgettype")==null?"":request.getParameter("widgettype");
String widgetvalue=request.getParameter("widgetvalue")==null?"":request.getParameter("widgetvalue");
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	JSONArray widgetarray=new JSONArray();
	if(widgettype.equalsIgnoreCase("Brand")){
		String strsql="select model.vtype name,model.doc_no docno from ws_gateinpass gate left join gl_vehmodel model on gate.modid=model.doc_no where gate.brdid="+widgetvalue+" and gate.processstatus<>8 group by model.doc_no";
		ResultSet rswidget=conn.createStatement().executeQuery(strsql);
		while(rswidget.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("name",rswidget.getString("name"));
			objtemp.put("docno",rswidget.getString("docno"));
			widgetarray.add(objtemp);
		}
	}
	objdata.put("widgetdata",widgetarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>