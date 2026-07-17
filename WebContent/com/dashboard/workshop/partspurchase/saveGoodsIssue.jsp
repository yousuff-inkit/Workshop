<%@page import="com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
String strpartsarray[]=request.getParameterValues("partsarray[]");
String strpartsrowarray[]=request.getParameterValues("partsrowarray[]");
String normalpartsarray[]=request.getParameterValues("normalpartsarray[]");
String vendor=request.getParameter("vendor")==null?"":request.getParameter("vendor");
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	
	Statement stmt=conn.createStatement();
	
	 if(mode.equalsIgnoreCase("2")){
		//Goods issue
		
		ClsGoodsissuenoteDAO reqdao=new ClsGoodsissuenoteDAO();
		java.sql.Date sqlbasedate=null;
		
		int jobvocno=0,jobdocno=0,joblocid=0,jobclient=0;
		String strmisc="select (select lc.doc_no from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join my_locm lc on  job.brhid=lc.brhid where est.doc_no="+estdocno+") joblocid,(select job.brhid from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobbrhid,(select curdate()) basedate,(select job.voc_no from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobvocno,(select job.doc_no from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobdocno,(select ac.cldocno from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass g on (job.refno=g.doc_no and reftype='gip') or (est.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where est.doc_no="+estdocno+") jobclient";
		
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		while(rsmisc.next()){
			sqlbasedate=rsmisc.getDate("basedate");
			jobvocno=rsmisc.getInt("jobvocno");
			jobdocno=rsmisc.getInt("jobdocno");
			joblocid=rsmisc.getInt("joblocid");
			jobclient=rsmisc.getInt("jobclient");
			session.setAttribute("BRANCHID",rsmisc.getString("jobbrhid"));
		}
		String purchasedesc="Goods Issue Note for Job Card #"+jobvocno;
		ArrayList<String> masterarray=new ArrayList();
		
		for(int i=0;i<strpartsarray.length;i++){
			String bb[]=strpartsarray[i].split("::");
			String temp="";
			for(int j=0;j<bb.length;j++){ 
				temp=temp+bb[j]+"::";				 
			}
			masterarray.add(temp);
		} 
		int update=0;
		int reqdocno=reqdao.insert(sqlbasedate, "", purchasedesc, 0.0, session, "A", "GIS", request, masterarray, joblocid, jobclient, 0, 1, 9, jobdocno);
		if(reqdocno>0){
			conn.setAutoCommit(false);
			for(int i=0;i<strpartsarray.length;i++){
				String bb[]=strpartsarray[i].split("::");
				String dd[]=strpartsrowarray[i].split("::");
				String strupdaterows="update ws_estspare set goodsissuedocno="+reqdocno+",goodsissueqty=goodsissueqty+"+bb[3]+",psrno="+bb[1]+" where rdocno="+estdocno+" and rowno="+dd[0];
				update=stmt.executeUpdate(strupdaterows);
				if(update<0){
					errorstatus=1;
				}
				String strins="insert into ws_estsparepurchased(estdocno, estspare_rowno, dtype, doc_no, qty) values ("+estdocno+","+dd[0]+",'GIS',"+reqdocno+","+bb[3]+")";
				update=stmt.executeUpdate(strins);
				if(update<0){
					errorstatus=1;
					break;
				}
				else{
					reqdocno=Integer.parseInt(request.getAttribute("vocno").toString());
				}
			}
		}
		
		if(reqdocno<=0){
			errorstatus=1;
		}
		
		if(errorstatus==0){
			objdata.put("refdocno",reqdocno);	
			conn.commit();
			conn.close();
		}
	}

	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>