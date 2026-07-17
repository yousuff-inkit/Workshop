<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.sms.SmsAction"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		
		int smsconfig=0;
        String  strsmsconfig="select method from gl_config where field_nme='sms'";
        ResultSet rssmsconfig=conn.createStatement().executeQuery(strsmsconfig);
        while(rssmsconfig.next()){
        	smsconfig=rssmsconfig.getInt("method");
        }
        objdata.put("sms",smsconfig);
    
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>