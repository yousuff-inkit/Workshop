<%@page import="net.sf.json.JSONArray"%>
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
        String  strclient="select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
        ResultSet rsclient=conn.createStatement().executeQuery(strclient);
        JSONArray clientarray=new JSONArray();
        while(rsclient.next()){
        	JSONObject objtemp=new JSONObject();
        	objtemp.put("cldocno",rsclient.getString("cldocno"));
        	objtemp.put("refname",rsclient.getString("refname"));
        	clientarray.add(objtemp);
        }
        objdata.put("sms",smsconfig);
        objdata.put("clientdata",clientarray);
    
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>