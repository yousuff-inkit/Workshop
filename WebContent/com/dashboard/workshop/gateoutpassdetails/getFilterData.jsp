<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	
	String sqltest="",sqlbranch="";
	if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("undefined")){
		sqltest+=" and gip.brhid="+brhid;
		sqlbranch+=" and brhid="+brhid;
	}
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//getting card data
	String strgetcarddata="select count(*) totalcount,sum(if(gip.processstatus=1,1,0)) gipcount,sum(if(gip.processstatus in(2,3,4),1,0)) estcount,sum(if(gip.processstatus=10,1,0)) relcount,sum(if(gip.processstatus=5,1,0))"+
	" jobcount,sum(if(gip.processstatus=6,1,0)) jcccount,sum(if(gip.processstatus=7,1,0)) invcount from ws_gateinpass gip where gip.processstatus<>8 and gip.status=3"+sqltest;
	ResultSet rsgetcarddata=stmt.executeQuery(strgetcarddata);
	while(rsgetcarddata.next()){
		objdata.put("totalcount",rsgetcarddata.getInt("totalcount"));
		objdata.put("gipcount",rsgetcarddata.getInt("gipcount"));
		objdata.put("estcount",rsgetcarddata.getInt("estcount"));
		objdata.put("relcount",rsgetcarddata.getInt("relcount"));
		objdata.put("jobcount",rsgetcarddata.getInt("jobcount"));
		objdata.put("jcccount",rsgetcarddata.getInt("jcccount"));
		objdata.put("invcount",rsgetcarddata.getInt("invcount"));
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>