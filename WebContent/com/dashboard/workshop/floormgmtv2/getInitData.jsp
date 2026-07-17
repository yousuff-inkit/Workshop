<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetbranch=" select b.branchname refname,b.doc_no docno,u.permission from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
	+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
	+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";
//	System.out.println(strgetbranch);
	ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
	JSONArray brancharray=new JSONArray();
	int cnt=0;
	while(rsgetbranch.next()){
		JSONObject objtemp=new JSONObject();
//		System.out.println(cnt +"  "+rsgetbranch.getString("permission"));
		if(cnt==0 && rsgetbranch.getString("permission").equalsIgnoreCase("0")){
			objtemp.put("refname","All");
			objtemp.put("docno","");
			brancharray.add(objtemp);
			cnt=1;
		}
		objtemp=new JSONObject();
		objtemp.put("refname",rsgetbranch.getString("refname"));
		objtemp.put("docno",rsgetbranch.getString("docno"));
		brancharray.add(objtemp);
	}
	objdata.put("branchdata",brancharray);
	
	int smsconfig=0;
    String  strsmsconfig="select method from gl_config where field_nme='sms'";
    ResultSet rssmsconfig=conn.createStatement().executeQuery(strsmsconfig);
    while(rssmsconfig.next()){
    	smsconfig=rssmsconfig.getInt("method");
    }
    int techconfig=0;
    String  strtechconfig="select method from gl_config where field_nme='floorTechProcess'";
    ResultSet rstechconfig=conn.createStatement().executeQuery(strtechconfig);
    while(rstechconfig.next()){
    	techconfig=rstechconfig.getInt("method");
    }
    
    int delaysmsconfig=0;
    String  strdelaysms="select method from gl_config where field_nme='delaySMS'";
    ResultSet rsdelaysms=conn.createStatement().executeQuery(strdelaysms);
    while(rsdelaysms.next()){
    	delaysmsconfig=rsdelaysms.getInt("method");
    }
    objdata.put("delaysms",delaysmsconfig);
    objdata.put("techconfig",techconfig);
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