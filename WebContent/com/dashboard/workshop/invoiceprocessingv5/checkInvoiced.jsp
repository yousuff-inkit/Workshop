<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
JSONObject objtemp=new JSONObject();
try{
	conn=objconn.getMyConnection();
	String strsql="select count(*) itemcount from ws_invcalctemp where jobdocno="+jobdocno+" and invno>0";
	ResultSet rs=conn.createStatement().executeQuery(strsql);
	int invstatus=0;
	while(rs.next()){
		invstatus=rs.getInt("itemcount");
	}
	objtemp.put("invstatus",invstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objtemp+"");
%>