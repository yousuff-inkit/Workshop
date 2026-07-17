<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
JSONObject objdata=new JSONObject();
String baydata="";
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetbays="select baydocno from ws_jobplanbay where jobdocno="+jobdocno;
	ResultSet rsgetbays=stmt.executeQuery(strgetbays);
	String bays="";
	int j=0;
	while(rsgetbays.next()){
		if(j==0){
			bays+=rsgetbays.getString("baydocno");
		}
		else{
			bays+=","+rsgetbays.getString("baydocno");
		}
		j++;
	}
	
	String strsql="";
	JSONArray bayarray=new JSONArray();
	if(!bays.equalsIgnoreCase("")){		
		strsql="select doc_no,name from ws_bay where status=3 and doc_no in ("+bays+")";
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rs.getString("doc_no"));
			objtemp.put("name",rs.getString("name"));
			bayarray.add(objtemp);
		}
	}
	
	objdata.put("baydata",bayarray);
	//Getting Last Movement Details;
	int invaliddata=1;
	String strgetlastdata="select date_format(outdate,'%d.%m.%Y') outdate,outtime,date_format(indate,'%d.%m.%Y') indate,intime from ws_baymove where rowno=(select max(rowno) from ws_baymove where status=3 and jobcarddocno="+jobdocno+")";
	ResultSet rsgetlastdata=stmt.executeQuery(strgetlastdata);
	while(rsgetlastdata.next()){
		invaliddata=0;
		objdata.put("outdate",rsgetlastdata.getString("outdate"));
		objdata.put("outtime",rsgetlastdata.getString("outtime"));
		objdata.put("indate",rsgetlastdata.getString("indate"));
		objdata.put("intime",rsgetlastdata.getString("intime"));
	}
	objdata.put("invaliddata",invaliddata);
	System.out.println(objdata);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>