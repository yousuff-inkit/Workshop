<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
Connection conn=null;
String startdate=request.getParameter("startdate")==null?"":request.getParameter("startdate");
String enddate=request.getParameter("enddate")==null?"":request.getParameter("enddate");
String brandfilterarray=request.getParameter("brandarray")==null?"":request.getParameter("brandarray");
String modelfilterarray=request.getParameter("modelarray")==null?"":request.getParameter("modelarray");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
JSONObject objdata=new JSONObject();
System.out.println("Parameters:"+startdate+"::"+enddate+"::"+brandfilterarray+"::"+modelfilterarray+"::"+brhid);
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="",sqlbranch="";
	if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("undefined")){
		sqltest+=" and gip.brhid="+brhid;
		sqlbranch+=" and brhid="+brhid;
	}
	if(!brandfilterarray.equalsIgnoreCase("") && brandfilterarray!=null && !brandfilterarray.trim().equalsIgnoreCase("[]")){
		brandfilterarray = brandfilterarray.substring(1, brandfilterarray.length() - 1);
		sqltest+=" and gip.brdid in ("+brandfilterarray+")";
	}
	if(!modelfilterarray.equalsIgnoreCase("") && modelfilterarray!=null && !modelfilterarray.trim().equalsIgnoreCase("[]")){
		modelfilterarray = modelfilterarray.substring(1, modelfilterarray.length() - 1);
		sqltest+=" and gip.modelid in ("+modelfilterarray+")";
	}
	java.sql.Date sqlfromdate=null;
	java.sql.Date sqltodate=null;
	
	if(!startdate.equalsIgnoreCase("") && startdate!=null){
		sqlfromdate=objcommon.changeStringtoSqlDate(startdate);
	}
	if(!enddate.equalsIgnoreCase("") && enddate!=null){
		sqltodate=objcommon.changeStringtoSqlDate(enddate);
	}
	if(sqlfromdate!=null){
		sqltest+=" and gip.date>='"+sqlfromdate+"' and gip.date<='"+sqltodate+"'";
	
	}
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
	
	//Getting GIP List
	String strgetcardlist="select gip.processstatus,case when gip.processstatus=1 then gip.voc_no when gip.processstatus in (2,3,4) then est.voc_no when"+
	" gip.processstatus in (5,6,10) then job.voc_no when gip.processstatus=7 then inv.voc_no end vocno,"+
	" case when gip.processstatus=1 then date_format(gip.date,'%d.%m.%Y') when gip.processstatus in (2,3,4) then"+
	" date_format(est.date,'%d.%m.%Y') when gip.processstatus in (5,6) then date_format(job.date,'%d.%m.%Y')"+
	" when gip.processstatus=7 then date_format(inv.date,'%d.%m.%Y') when gip.processstatus=10 then date_format(rls.releasedate,'%d.%m.%Y') end date,"+
	" coalesce(ac.refname,gip.clientname) clientname,concat(coalesce(gip.regno,''),' ',coalesce(gip.pltid,''),' ',coalesce(brd.brand_name,''),' ',coalesce(model.vtype,'')) vehicledet from ws_gateinpass gip"+
	" left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM'"+
	" left join ws_estm est on (est.gipno=gip.doc_no)"+
	" left join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no)"+
	" left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no)"+
	" left join ws_vehrelease rls on (rls.jobcarddocno=job.doc_no)"+
	" left join gl_vehbrand brd on brd.doc_no=gip.brdid"+
	" left join gl_vehmodel model on model.doc_no=gip.modid"+
	" where gip.status=3 and gip.processstatus in (1,2,3,4,5,6,7,10)"+sqltest+" group by gip.doc_no";
	ResultSet rsgetcardlist=stmt.executeQuery(strgetcardlist);
	JSONArray gipcardarray=new JSONArray();
	JSONArray estcardarray=new JSONArray();
	JSONArray jobcardarray=new JSONArray();
	JSONArray jcccardarray=new JSONArray();
	JSONArray invcardarray=new JSONArray();
	JSONArray rlscardarray=new JSONArray();
	while(rsgetcardlist.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("vocno", rsgetcardlist.getString("vocno"));
		objtemp.put("date", rsgetcardlist.getString("date"));
		objtemp.put("clientname", rsgetcardlist.getString("clientname"));
		objtemp.put("vehicledet", rsgetcardlist.getString("vehicledet"));
		if(rsgetcardlist.getInt("processstatus")==1){
			gipcardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")>=2 && rsgetcardlist.getInt("processstatus")<=4){
			estcardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")==5){
			jobcardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")==6){
			jcccardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")==7){
			invcardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")==10){
			rlscardarray.add(objtemp);
		}
	}
	
	objdata.put("gipcarddata",gipcardarray);
	objdata.put("estcarddata",estcardarray);
	objdata.put("jobcarddata",jobcardarray);
	objdata.put("jcccarddata",jcccardarray);
	objdata.put("invcarddata",invcardarray);
	objdata.put("rlscarddata",rlscardarray);
	JSONArray montharray=new JSONArray();
	int initialmonthdiff=12;
	int initialdatestatus=1;
	if(sqlfromdate!=null && sqltodate!=null){
		String strgetmonthdiff="SELECT TIMESTAMPDIFF(MONTH, '"+sqlfromdate+"', '"+sqltodate+"') monthdiff";
		ResultSet rsgetmonthdiff=stmt.executeQuery(strgetmonthdiff);
		while(rsgetmonthdiff.next()){
			initialmonthdiff=rsgetmonthdiff.getInt("monthdiff");
		}
		initialdatestatus=0;
	}
	for(int i=initialmonthdiff;i>0;i--){
		String strgetmonths="";
		if(initialdatestatus==1){
			strgetmonths="select date_format(date_sub(curdate(),interval "+i+" month),'%b %Y') monthname,month(date_sub(curdate(),interval "+i+" month)) month,year(date_sub(curdate(),interval "+i+" month)) year";	
		}
		else{
			strgetmonths="select date_format(date_sub('"+sqltodate+"',interval "+i+" month),'%b %Y') monthname,month(date_sub('"+sqltodate+"',interval "+i+" month)) month,year(date_sub('"+sqltodate+"',interval "+i+" month)) year";
		}
		System.out.println(strgetmonths);
		ResultSet rsgetmonths=stmt.executeQuery(strgetmonths);
		while(rsgetmonths.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("monthname",rsgetmonths.getString("monthname"));
			objtemp.put("month",rsgetmonths.getString("month"));
			objtemp.put("year",rsgetmonths.getString("year"));
			montharray.add(objtemp);
		}
	}
	ArrayList<String> gipseries=new ArrayList();
	ArrayList<String> estseries=new ArrayList();
	ArrayList<String> jobseries=new ArrayList();
	ArrayList<String> invseries=new ArrayList();
	ArrayList<String> rlsseries=new ArrayList();
	ArrayList<String> last12months=new ArrayList();
	ArrayList<String> labourseries=new ArrayList();
	ArrayList<String> spareseries=new ArrayList();
	ArrayList<String> customerseries=new ArrayList();
	for(int i=0;i<montharray.size();i++){
		JSONObject objtemp=montharray.getJSONObject(i);
		String basemonth=objtemp.get("month").toString();
		String baseyear=objtemp.get("year").toString();
		last12months.add(objtemp.get("monthname").toString());
		String strgetmonthcount="select (select count(*) from ws_gateinpass gip where gip.processstatus<>8 and gip.status=3 and month(gip.date)="+basemonth+" and year(gip.date)="+baseyear+" "+sqltest+") gipcount,"+
		" (select count(*) from ws_gateinpass gip left join ws_estm est on est.gipno=gip.doc_no where gip.processstatus<>8 and est.status=3 and month(est.date)="+basemonth+" and year(est.date)="+baseyear+" "+sqltest+") estcount,"+
		" (select count(*) from ws_gateinpass gip left join ws_estm est on est.gipno=gip.doc_no left join ws_jobcard job on job.reftype='EST' and job.refno=est.doc_no where gip.processstatus<>8 and job.status=3 and month(job.date)="+basemonth+" and year(job.date)="+baseyear+" "+sqltest+") jobcount,"+
		" (select count(*) from ws_gateinpass gip left join ws_estm est on est.gipno=gip.doc_no left join ws_jobcard job on job.reftype='EST' and job.refno=est.doc_no left join ws_invm inv on inv.reftype='JC' and inv.refno=job.doc_no where gip.processstatus<>8 and inv.status=3 and month(inv.date)="+basemonth+" and year(inv.date)="+baseyear+" "+sqltest+") invcount,"+
		" (select count(*) from ws_gateinpass gip left join ws_estm est on est.gipno=gip.doc_no left join ws_jobcard job on job.reftype='EST' and job.refno=est.doc_no left join ws_vehrelease rls on rls.jobcarddocno=job.doc_no where gip.processstatus<>8 and month(rls.releasedate)="+basemonth+" and year(rls.releasedate)="+baseyear+" "+sqltest+") rlscount,"+
		" (select count(*) from my_acbook where dtype='crm' and status=3 and month(date)="+basemonth+" and year(date)="+baseyear+" "+sqlbranch+") customercount";
		System.out.println(strgetmonthcount);
		ResultSet rsgetmonthcount=stmt.executeQuery(strgetmonthcount);
		while(rsgetmonthcount.next()){
			gipseries.add(rsgetmonthcount.getString("gipcount"));
			estseries.add(rsgetmonthcount.getString("estcount"));
			jobseries.add(rsgetmonthcount.getString("jobcount"));
			invseries.add(rsgetmonthcount.getString("invcount"));
			rlsseries.add(rsgetmonthcount.getString("rlscount"));
			customerseries.add(rsgetmonthcount.getString("customercount"));
		}
		
		String strstackedamount="select (select sum(lab.invoiceamt) from ws_gateinpass gip left join ws_estm est on est.gipno=gip.doc_no left join "+
		" ws_jobcard job on job.reftype='EST' and job.refno=est.doc_no left join ws_estlabour lab on lab.rdocno=est.doc_no where job.status=3 "+
		" and month(job.date)="+basemonth+" and year(job.date)="+baseyear+" "+sqltest+") labourtotal,"+
		" (select sum(spare.customeramt) from ws_gateinpass gip left join ws_estm est on est.gipno=gip.doc_no"+
		" left join ws_jobcard job on job.reftype='EST' and job.refno=est.doc_no left join ws_jccspare spare on"+
		" spare.estdocno=est.doc_no where job.status=3 and month(job.date)="+basemonth+" and year(job.date)="+baseyear+" "+sqltest+") sparetotal";
		ResultSet rsstackedamount=stmt.executeQuery(strstackedamount);
		while(rsstackedamount.next()){
			labourseries.add(rsstackedamount.getString("labourtotal"));
			spareseries.add(rsstackedamount.getString("sparetotal"));
		}
		
	}
	
	objdata.put("gipseries",gipseries);
	objdata.put("estseries",estseries);
	objdata.put("jobseries",jobseries);
	objdata.put("invseries",invseries);
	objdata.put("rlsseries",rlsseries);
	objdata.put("last12months",last12months);
	
	objdata.put("labourseries",labourseries);
	objdata.put("spareseries",spareseries);
	objdata.put("customerseries",customerseries);
	JSONArray brandarray=new JSONArray();
	String strbrandlist="select count(*) itemcount,brd.brand_name,brd.doc_no from ws_gateinpass gip left join gl_vehbrand brd on "+
	" gip.brdid=brd.doc_no where gip.status=3 "+sqltest+" group by gip.brdid order by brd.brand_name";
	ResultSet rsbrandlist=stmt.executeQuery(strbrandlist);
	while(rsbrandlist.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("brandname",rsbrandlist.getString("brand_name"));
		objtemp.put("branddocno",rsbrandlist.getString("doc_no"));
		objtemp.put("totalcount",rsbrandlist.getString("itemcount"));
		String strmodellist="select count(*) itemcount,model.vtype,model.doc_no from ws_gateinpass gip left join gl_vehmodel model on "+
		" gip.modid=model.doc_no where	gip.status=3 and gip.brdid="+rsbrandlist.getString("doc_no")+" "+sqltest+" group by gip.modid order by model.vtype";
		ResultSet rsmodellist=conn.createStatement().executeQuery(strmodellist);
		JSONArray modelarray=new JSONArray();
		while(rsmodellist.next()){
			JSONObject objmodel=new JSONObject();
			objmodel.put("name",rsmodellist.getString("vtype"));
			objmodel.put("totalcount",rsmodellist.getString("itemcount"));
			modelarray.add(objmodel);
		}
		objtemp.put("modelarray",modelarray);
		brandarray.add(objtemp);
	}
	objdata.put("vehiclelistdata",brandarray);
	int repairtypetotal=0;
	String strgetrepairtype="select count(*) itemcount,rtype.name from ws_gateinpass gip left join ws_gartype rtype on "+
	" gip.repairtype=rtype.row_no where processstatus<>8 and rtype.row_no is not null "+sqltest+" group by rtype.row_no";
	ResultSet rsgetrepairtype=stmt.executeQuery(strgetrepairtype);
	ArrayList<String> repairtypevalues=new ArrayList();
	ArrayList<String> repairtypelabels=new ArrayList();
	while(rsgetrepairtype.next()){
		repairtypevalues.add(rsgetrepairtype.getString("itemcount"));
		repairtypelabels.add(rsgetrepairtype.getString("name"));
		repairtypetotal+=rsgetrepairtype.getInt("itemcount");
	}
	//System.out.println(repairtypevalues);
	objdata.put("repairtypevalues",repairtypevalues);
	objdata.put("repairtypelabels",repairtypelabels);
	objdata.put("repairtypetotal",repairtypetotal);
	
	//Getting Technician values
	String strtechdata="select  coalesce(tech.name,'') refname,tech.doc_no refno,sum(lab.hrs) totalhours,  sum(if((amt.labtotal=0 or estl.totalestlab=0),0,round((amt.labtotal/estl.totalestlab)*lab.total,2))) total, sum(if((amt.labtotal=0 or estl.investlab=0),0,round((amt.labtotal/estl.investlab)*lab.invoiceamt,2))) invoicetotal from (select inv.refno,inv.reftype from ws_invm inv where inv.date between '2021-06-17' and '2021-07-17' and inv.status=3 group by inv.refno,inv.reftype) inv left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC' left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_technician tech on lab.technicianid=tech.doc_no left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no left join ws_gateinpass gip on (est.gipno=gip.doc_no) left join my_acbook ac on (gip.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on ac.catid=cat.doc_no left join (select rdocno,sum(total) totalestlab,sum(invoiceamt) investlab from ws_estlabour group by rdocno) estl on estl.rdocno=est.doc_no left join (select SUM(inv.nettotal) nettotal,IF(coalesce(jc.sparetot,0)>SUM(INV.NETTOTAL),SUM(INV.NETTOTAL),coalesce(jc.sparetot,0)) sparetot, IF(SUM(inv.nettotal)-coalesce(jc.sparetot,0)<0,0,sum(inv.nettotal)-coalesce(jc.sparetot,0)) labtotal,job.doc_no from ws_invm inv left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC' left join (select sum(customeramt) sparetot,jobcarddocno from ws_jccspare group by jobcarddocno) jc on job.doc_no=jc.jobcarddocno  where inv.date between '2021-01-01' and curdate()  and inv.status=3 GROUP BY inv.refno,inv.reftype ) amt on amt.doc_no=job.doc_no where 1=1 "+sqltest+"  group by tech.doc_no";
	ResultSet rstechdata=stmt.executeQuery(strtechdata);
	JSONArray techarray=new JSONArray();
	while(rstechdata.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rstechdata.getString("refname"));
		objtemp.put("totalhrs",rstechdata.getString("totalhours"));
		objtemp.put("total",rstechdata.getString("total"));
		objtemp.put("invoicetotal",rstechdata.getString("invoicetotal"));
		techarray.add(objtemp);
	}
	objdata.put("techniciandata",techarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
System.out.println(objdata);
response.getWriter().write(objdata+"");
%>