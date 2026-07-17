<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String jobcarddocno=request.getParameter("jobcarddocno")==null?"0":request.getParameter("jobcarddocno").toString();
	Connection conn=null;
	JSONObject data=new JSONObject();
	int errorstatus=0;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String strsql="update ws_floormgmtdata set totalloss=1 where jobdocno="+jobcarddocno;
		int update=stmt.executeUpdate(strsql);
		if(update<=0){
			errorstatus=1;
		}
		if(errorstatus==0){
			conn.commit();
		}
		data.put("errorstatus",errorstatus);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(data+"");
%>