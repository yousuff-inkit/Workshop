<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject data=new JSONObject();
Connection conn=null;
try{
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="",sqlbranch="";
	
	String strgetclient="select ac.refname,ac.cldocno from my_acbook ac where dtype='CRM' and status=3";
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);
	JSONArray clientarray=new JSONArray();
	while(rsgetclient.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsgetclient.getString("refname"));
		objtemp.put("cldocno",rsgetclient.getString("cldocno"));
		clientarray.add(objtemp);
	}
	
	String strgetclientcat="select doc_no docno,cat_name refname from my_clcatm where dtype='CRM' and status=3";
	ResultSet rsgetclientcat=stmt.executeQuery(strgetclientcat);
	JSONArray clientcatarray=new JSONArray();
	while(rsgetclientcat.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsgetclientcat.getString("refname"));
		objtemp.put("docno",rsgetclientcat.getString("docno"));
		clientcatarray.add(objtemp);
	}
	
	String strgetinsur="select ac.refname,ac.cldocno from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.dtype='crm' and ac.status=3"
			+ " and cat.status=3 and cat.insurance=1";
	ResultSet rsgetinsur=stmt.executeQuery(strgetinsur);
	JSONArray insurarray=new JSONArray();
	while(rsgetinsur.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsgetinsur.getString("refname"));
		objtemp.put("cldocno",rsgetinsur.getString("cldocno"));
		insurarray.add(objtemp);
	}
	
	//String strgetbranch="select doc_no docno,branchname refname from my_brch where status=3";
	String strgetbranch=" select b.branchname refname,b.doc_no docno,u.permission from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
	+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
	+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";
	 System.out.println(strgetbranch);
	ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
	JSONArray brancharray=new JSONArray();
	int cnt=0;
	while(rsgetbranch.next()){
		JSONObject objtemp=new JSONObject();
		//System.out.println(cnt +"  "+rsgetbranch.getString("permission"));
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
	String strgetmenu="select func,menu_name from my_menu where menu_name in ('Estimation','Job Card')";
	System.out.println("strgetmenu == "+strgetmenu);
	ResultSet rsgetmenu=stmt.executeQuery(strgetmenu);
	while(rsgetmenu.next()){
		if(rsgetmenu.getString("menu_name").equalsIgnoreCase("Estimation")){
			data.put("estimationpath",rsgetmenu.getString("func"));
			if(rsgetmenu.getString("func").contains("estimationpal")){
				data.put("estimationaction","com/workshop/estimationpal/estimationPalView.action");
				data.put("estimationaddaction","com/workshop/estimationadditionpal/estimationAdditionPalView.action");
			}
			else if(rsgetmenu.getString("func").contains("estimationv3")){
				data.put("estimationaction","com/workshop/estimationv3/estimationV3View.action");
				data.put("estimationaddaction","com/workshop/estimationadditionv3/estimationAdditionV3View.action");
			}
			else if(rsgetmenu.getString("func").contains("estimationv4")){
				data.put("estimationaction","com/workshop/estimationv4/estimationV4View.action");
				data.put("estimationaddaction","com/workshop/estimationadditionv4/estimationAdditionV4View.action");
			}
			else if(rsgetmenu.getString("func").contains("estimationv5")){
				data.put("estimationaction","com/workshop/estimationv5/estimationV5View.action");
				data.put("estimationaddaction","com/workshop/estimationadditionv5/estimationAdditionV5View.action");
			}
		}
		
		else if(rsgetmenu.getString("menu_name").equalsIgnoreCase("Job Card")){
			data.put("jobcardpath",rsgetmenu.getString("func"));
		}
	}
	System.out.println("data == "+data);
	data.put("clientdata",clientarray);
	data.put("clientcatdata",clientcatarray);
	data.put("insurdata",insurarray);
	data.put("branchdata",brancharray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>