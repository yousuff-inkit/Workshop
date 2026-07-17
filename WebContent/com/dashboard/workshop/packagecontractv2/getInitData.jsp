<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connection.*"%>
<%
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").trim();
String modelid=request.getParameter("modelid")==null?"":request.getParameter("modelid").trim();
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").trim();
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno").trim();
Connection conn=null;
JSONObject objdata=new JSONObject();
JSONArray gridarray=new JSONArray();
try{
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetbranch=" select b.branchname refname,b.doc_no docno,u.permission from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
			+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
			+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";
//			System.out.println(strgetbranch);
			ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
			JSONArray brancharray=new JSONArray();
			int cnt=0;
			while(rsgetbranch.next()){
				JSONObject objtemp=new JSONObject();
//				System.out.println(cnt +"  "+rsgetbranch.getString("permission"));
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
	if(mode.equalsIgnoreCase("1")){
		String strgetclient="select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		ResultSet rsgetclient=stmt.executeQuery(strgetclient);
		JSONArray clientarray=new JSONArray();
		while(rsgetclient.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("cldocno",rsgetclient.getInt("cldocno"));
			objtemp.put("refname",rsgetclient.getString("refname"));
			clientarray.add(objtemp);
		}
		JSONArray packagearray=new JSONArray();
		String strgetpackage="select doc_no,packagename from ws_packagem where status=3";
		ResultSet rsgetpackage=stmt.executeQuery(strgetpackage);
		while(rsgetpackage.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetpackage.getInt("doc_no"));
			objtemp.put("name",rsgetpackage.getString("packagename"));
			packagearray.add(objtemp);
		}
		
		JSONArray modelarray=new JSONArray();
		String strgetmodel="select doc_no,vtype from gl_vehmodel where status=3";
		ResultSet rsgetmodel=stmt.executeQuery(strgetmodel);
		while(rsgetmodel.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetmodel.getInt("doc_no"));
			objtemp.put("name",rsgetmodel.getString("vtype"));
			modelarray.add(objtemp);
		}
		
		String strgetmenu="select func,menu_name from my_menu where menu_name in ('Estimation','Job Card')";
		ResultSet rsgetmenu=stmt.executeQuery(strgetmenu);
		while(rsgetmenu.next()){
			if(rsgetmenu.getString("menu_name").equalsIgnoreCase("Estimation")){
				objdata.put("estimationpath",rsgetmenu.getString("func"));
				if(rsgetmenu.getString("func").contains("estimationpal")){
					objdata.put("estimationaction","com/workshop/estimationpal/estimationPalView.action");
					objdata.put("estimationaddaction","com/workshop/estimationadditionpal/estimationAdditionPalView.action");
				}
				else if(rsgetmenu.getString("func").contains("estimationv3")){
					objdata.put("estimationaction","com/workshop/estimationv3/estimationV3View.action");
					objdata.put("estimationaddaction","com/workshop/estimationadditionv3/estimationAdditionV3View.action");
				}
				else if(rsgetmenu.getString("func").contains("estimationv4")){
					objdata.put("estimationaction","com/workshop/estimationv4/estimationV4View.action");
					objdata.put("estimationaddaction","com/workshop/estimationadditionv4/estimationAdditionV4View.action");
				}
			}
			else if(rsgetmenu.getString("menu_name").equalsIgnoreCase("Job Card")){
				objdata.put("jobcardpath",rsgetmenu.getString("func"));
			}
		}
		String strcontractpath="select path from gl_bibd where description='Package Contract' and status=1";
		ResultSet rscontractpath=stmt.executeQuery(strcontractpath);
		while(rscontractpath.next()){
			String contractpath=rscontractpath.getString("path");
			if(contractpath.contains("v2")){
				objdata.put("contractprintaction","com/dashboard/workshop/packagecontractv2/packageContractV2Print.action");
			}
		}
		objdata.put("clientdata",clientarray);
		objdata.put("packagedata",packagearray);
		objdata.put("modeldata",modelarray);
	}
	else if(mode.equalsIgnoreCase("2")){
		String strgetpackage="select cnt.brhid,coalesce(model.vtype,'') modelname,coalesce(cnt.regno,'') regno,coalesce(cnt.chassisno,'') chassisno,convert(coalesce(srs.srsvocno,''),char(10)) srsvocno,coalesce(srs.outstatus,1) outstatus,cnt.srsdocno,cnt.doc_no,cnt.voc_no,cnt.date,cnt.fromdate,cnt.todate,ac.cldocno,ac.refname,cnt.remarks,"+
		" pkg.packagename from ws_packagecontract cnt "+
		" left join my_acbook ac on (cnt.cldocno=ac.cldocno and ac.dtype='CRM') "+
		" left join ws_packagem pkg on cnt.packagedocno=pkg.doc_no "+
		" left join gl_vehmodel model on cnt.modeldocno=model.doc_no"+
		" left join (select if(sum(dramount)-sum(out_amount)<>0.0,0,1) outstatus,m.doc_no srsdocno,m.voc_no srsvocno from my_srvsalem m left join my_jvtran jv on"+
		" m.tr_no=jv.tr_no and jv.id=1 group by m.doc_no) srs on (cnt.srsdocno=srs.srsdocno) where cnt.status=3";
		ResultSet rsgetpackage=stmt.executeQuery(strgetpackage);
		gridarray=objcommon.convertToJSON(rsgetpackage);
	}
	else if(mode.equalsIgnoreCase("3")){
		String strgetenginesize="select engsizeid from gl_vehmodel where doc_no="+modelid;
		ResultSet rsgetenginesize=stmt.executeQuery(strgetenginesize);
		int enginesize=0;
		while(rsgetenginesize.next()){
			enginesize=rsgetenginesize.getInt("engsizeid");
		}
		
		//Getting Packages corresponding to Engine Size
		
		String strgetpackage="select doc_no,packagename,date_format(fromdate,'%d.%m.%Y') pkgfromdate,date_format(todate,'%d.%m.%Y') pkgtodate from ws_packagem where engsizeid="+enginesize;
		JSONArray packagearray=new JSONArray();
		ResultSet rsgetpackage=stmt.executeQuery(strgetpackage);
		while(rsgetpackage.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetpackage.getInt("doc_no"));
			objtemp.put("name",rsgetpackage.getString("packagename"));
			objtemp.put("pkgfromdate", rsgetpackage.getString("pkgfromdate"));
			objtemp.put("pkgtodate",rsgetpackage.getString("pkgtodate"));
			packagearray.add(objtemp);
		}
		objdata.put("packagedata",packagearray);
	}
	else if (mode.equalsIgnoreCase("4")){
		String strfilters="";
		if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
			strfilters=" and cnt.brhid="+brhid;			
		}
		String strgetpackage="select sum(if(cnt.srsdocno>0,0,1)) pendingcount,sum(coalesce(srs.outstatus,1)) notrcvcount from ws_packagecontract cnt "+
		" left join (select if(sum(dramount)-sum(out_amount)<>0.0,0,1) outstatus,m.doc_no srsdocno from my_srvsalem m left join my_jvtran jv on"+
		" m.tr_no=jv.tr_no and jv.id=1 group by m.doc_no) srs on (cnt.srsdocno=srs.srsdocno)where cnt.status=3 "+strfilters;
		
		ResultSet rsgetpackage=stmt.executeQuery(strgetpackage);
		int pending=0,notrcvcount=0;
		while(rsgetpackage.next()){
			pending=rsgetpackage.getInt("pendingcount");
			notrcvcount=rsgetpackage.getInt("notrcvcount");
		}
		objdata.put("pendingcount",pending);
		objdata.put("notrcvcount",notrcvcount);
	}
	else if(mode.equalsIgnoreCase("5")){
		//Getting Utilization Log
		
		String strsql="select doc_no,voc_no,date_format(date,'%d-%m-%Y') date,gipno gatedocno,brhid from ws_estm where pkgcontractdocno="+contractdocno;
		ResultSet rs=stmt.executeQuery(strsql);
		JSONArray utilarray=new JSONArray();
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("doc_no",rs.getString("doc_no"));
			objtemp.put("voc_no",rs.getString("voc_no"));
			objtemp.put("date",rs.getString("date"));
			objtemp.put("gatedocno",rs.getString("gatedocno"));
			objtemp.put("brhid",rs.getString("brhid"));
			
			utilarray.add(objtemp);
		}
		
		objdata.put("utildata",utilarray);
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}

if(mode.equalsIgnoreCase("1") || mode.equalsIgnoreCase("3") || mode.equalsIgnoreCase("4") || mode.equalsIgnoreCase("5")){
	response.getWriter().write(objdata+"");
}
else if(mode.equalsIgnoreCase("2")){
	response.getWriter().write(gridarray+"");
}
%>