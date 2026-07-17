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
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>