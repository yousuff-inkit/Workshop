<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject data =new JSONObject();
String formname=request.getParameter("formname")==null?"":request.getParameter("formname");
String formdocno=request.getParameter("formdocno")==null?"":request.getParameter("formdocno");
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetbranch=" select b.branchname refname,b.doc_no docno,u.permission from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
			+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
			+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";
	System.out.println(strgetbranch);
	ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
	JSONArray brancharray=new JSONArray();
	int cnt=0;
	while(rsgetbranch.next()){
		JSONObject objtemp=new JSONObject();
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
	
	String dtype="";
	String strdtype="select dtype from gl_bibd where status=1 and (description='"+formname+"' or doc_no="+formdocno+") ";
	ResultSet rsdtype=stmt.executeQuery(strdtype);
	while(rsdtype.next()){
		dtype=rsdtype.getString("dtype");
	}
	String strgetcountdata="SELECT (SELECT COUNT(*)  FROM ws_gateinpass gate LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno "+
	" WHERE gate.processstatus=1 AND COALESCE(mat.doc_no,0)=0) matreqpending,"+
	" (SELECT COUNT(*)  FROM ws_gateinpass gate LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno"+ 
	" WHERE gate.processstatus=1 AND COALESCE(mat.techapproval,0)=0) techpending,"+
	" (SELECT COUNT(*)  FROM ws_gateinpass gate LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno"+
	" WHERE gate.processstatus=1 AND COALESCE(mat.finapproval,0)=0) finpending";
	ResultSet rscountdata=stmt.executeQuery(strgetcountdata);
	int matreqpending=0,techpending=0,finpending=0;
	while(rscountdata.next()){
		matreqpending=rscountdata.getInt("matreqpending");
		techpending=rscountdata.getInt("techpending");
		finpending=rscountdata.getInt("finpending");
	}
	data.put("matreqpending",matreqpending);
	data.put("techpending",techpending);
	data.put("finpending",finpending);
	data.put("branchdata",brancharray);
	data.put("dtype",dtype);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>