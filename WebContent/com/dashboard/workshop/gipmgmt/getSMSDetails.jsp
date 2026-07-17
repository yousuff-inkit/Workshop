
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetmessage="select msg from my_msgsettings where brhid="+brhid+" and dtype='GIPMGMT' and status=3";
	System.out.println(strgetmessage);
	String rawmsg="";
	ResultSet rsraw=stmt.executeQuery(strgetmessage);
	while(rsraw.next()){
		rawmsg=rsraw.getString("msg");
	}
	rawmsg=rawmsg.replace("documentno",gatedocno);
	System.out.println(rawmsg);
	ResultSet rs=stmt.executeQuery(rawmsg);
	String msg="";
	while(rs.next()){
		msg=rs.getString("msg");
	}
	objdata.put("msg",msg);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(!conn.isClosed()){
		conn.close();	
	}
	
}
response.getWriter().write(objdata+"");
%>
