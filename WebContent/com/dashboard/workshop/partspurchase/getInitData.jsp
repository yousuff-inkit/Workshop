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
	String strgetbranch=" select b.branchname refname,b.doc_no docno,coalesce(u.permission,1) permission  from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
	+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
	+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";
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
	String strgetvendor="SELECT (select vat_per from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and curdate() between tax.fromdate and tax.todate) taxpercent,(select acno from my_account where codeno='WORKSHOPPARTPURCH') gridacno,RefName,tax,acno,cldocno docno FROM my_acbook where dtype='VND' and status<>7";
	ResultSet rsgetvendor=stmt.executeQuery(strgetvendor);
	JSONArray vendorarray=new JSONArray();
	while(rsgetvendor.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsgetvendor.getString("refname"));
		objtemp.put("docno",rsgetvendor.getString("docno"));
		objtemp.put("tax",rsgetvendor.getString("tax"));
		objtemp.put("gridacno",rsgetvendor.getString("gridacno"));
		objtemp.put("taxpercent",rsgetvendor.getDouble("taxpercent"));
		vendorarray.add(objtemp);		
	}
	objdata.put("branchdata",brancharray);
	objdata.put("vendordata",vendorarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>