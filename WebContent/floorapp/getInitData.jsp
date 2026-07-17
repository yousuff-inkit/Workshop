<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	/*
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
	*/
	String sqlfilters="";
	if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
		sqlfilters+=" and job.brhid="+brhid;
	}
	String strgetregno="select job.doc_no jobdocno,job.voc_no jobvocno,gate.doc_no gatedocno,gate.voc_no gatevocno,est.doc_no estdocno,est.voc_no estvocno,"+
	" concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' - ',coalesce(brd.brand_name,''),' ',coalesce(model.vtype,'')) refname from ws_gateinpass gate left join gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on"+
	" gate.modid=model.doc_no inner join ws_estm est on est.gipno=gate.doc_no inner join ws_jobcard job on job.refno=est.doc_no"+
	" and job.reftype='EST' left join ws_floormgmtdata flr on job.doc_no=flr.jobdocno where gate.status=3 and gate.processstatus<6 and flr.deliverystatus<>1 "+sqlfilters+" group by gate.regno,gate.pltid";
	ResultSet rsgetregno=stmt.executeQuery(strgetregno);
	JSONArray regnoarray=new JSONArray();
	while(rsgetregno.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("jobdocno",rsgetregno.getString("jobdocno"));
		objtemp.put("jobvocno",rsgetregno.getString("jobvocno"));
		objtemp.put("refname",rsgetregno.getString("refname"));
		regnoarray.add(objtemp);
	}
	objdata.put("regnodata",regnoarray);
	
	String strgetjobno="select job.doc_no jobdocno,job.voc_no jobvocno from ws_jobcard job inner join ws_estm est on job.refno=est.doc_no"+
	" and job.reftype='EST' left join ws_gateinpass gate on est.gipno=gate.doc_no left join ws_floormgmtdata flr on job.doc_no=flr.jobdocno where job.status=3 and gate.processstatus<6 and flr.deliverystatus<>1 "+sqlfilters;
	System.out.println("strgetjobno : "+strgetjobno);
	ResultSet rsgetjobno=stmt.executeQuery(strgetjobno);
	JSONArray jobnoarray=new JSONArray();
	while(rsgetjobno.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("jobdocno",rsgetjobno.getString("jobdocno"));
		objtemp.put("jobvocno",rsgetjobno.getString("jobvocno"));
		jobnoarray.add(objtemp);
	}
	System.out.println("jobnoarray : "+jobnoarray);
	objdata.put("jobnodata",jobnoarray);
	objdata.put("username",session.getAttribute("USERNAME").toString());
	String strgettechnian="select doc_no docno,name refname from ws_technician where status=3";
	ResultSet rsgettech=stmt.executeQuery(strgettechnian);
	JSONArray technicianarray=new JSONArray();
	while(rsgettech.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgettech.getString("docno"));
		objtemp.put("refname",rsgettech.getString("refname"));
		technicianarray.add(objtemp);
	}
	objdata.put("techniciandata",technicianarray);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>