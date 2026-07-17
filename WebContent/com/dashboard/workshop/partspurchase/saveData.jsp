<%@page import="com.finance.nipurchase.nipurchaseorder.ClsnipurchaseorderDAO"%>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
String strpartsarray[]=request.getParameterValues("partsarray[]");
String normalpartsarray[]=request.getParameterValues("normalpartsarray[]");
String vendor=request.getParameter("vendor")==null?"":request.getParameter("vendor");
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String purchasedetails=request.getParameter("purchasedetails")==null?"":request.getParameter("purchasedetails");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype");
int refno=(request.getParameter("refno")==null || request.getParameter("refno")=="")?0:Integer.parseInt(request.getParameter("refno"));

Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	
	Statement stmt=conn.createStatement();
	if(mode.equalsIgnoreCase("1")){
		conn.setAutoCommit(false);
		for(int i=0;i<strpartsarray.length;i++){
			String strmaxsrno="select coalesce(max(srno),0)+1 maxsrno from ws_estspare where rdocno="+estdocno;
			int maxsrno=0;
			ResultSet rsmaxsrno=stmt.executeQuery(strmaxsrno);
			while(rsmaxsrno.next()){
				maxsrno=rsmaxsrno.getInt("maxsrno");
			}
			String rowno=strpartsarray[i].split("::")[0].trim();
			String desc=strpartsarray[i].split("::")[1].trim();
			String qty=strpartsarray[i].split("::")[2].trim();
			String rate=strpartsarray[i].split("::")[3].trim();
			String psrno=strpartsarray[i].split("::")[4].trim();
			psrno=psrno==null || psrno.trim().equalsIgnoreCase("") || psrno.trim().equalsIgnoreCase("undefined")?"0":psrno;
			desc=desc==null || desc.trim().equalsIgnoreCase("") || desc.trim().equalsIgnoreCase("undefined")?"":desc;
			qty=qty==null || qty.trim().equalsIgnoreCase("") || qty.trim().equalsIgnoreCase("undefined")?"0":qty;
			rate=rate==null || rate.trim().equalsIgnoreCase("") || rate.trim().equalsIgnoreCase("undefined")?"0":rate;
			
			String strupdaterows="";
			if(rowno!=null && !rowno.trim().equalsIgnoreCase("") && !rowno.trim().equalsIgnoreCase("undefined")){
				//Existing row
				strupdaterows="update ws_estspare set psrno="+psrno+" where rdocno="+estdocno+" and rowno="+rowno.trim();
				int update=stmt.executeUpdate(strupdaterows);
				if(update<0){
					errorstatus=1;
				}
			}
			else{
				//New Row
				double total=Double.parseDouble(qty)*Double.parseDouble(rate);
				strupdaterows="insert into ws_estspare(rdocno,srno,psrno,qty,rate,total,addition,approvedvalue,description)values("+estdocno+","+maxsrno+","+psrno+","+qty+","+rate+","+total+",0,"+total+",'"+desc+"')";
				int update=stmt.executeUpdate(strupdaterows);
				if(update<=0){
					errorstatus=1;
				}
			}
			
		}
		if(errorstatus==0){
			conn.commit();
			conn.close();
		}
	}
	else if(mode.equalsIgnoreCase("2")){
		//NI Purchase Order 
		
		String jobvocno="";
		java.sql.Date sqlbasedate=null;
		String strmisc="select (select job.brhid from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobbrhid,(select tax from my_acbook where status=3 and cldocno="+vendor+" and dtype='VND') vendortax,(select acno from my_acbook where status=3 and cldocno="+vendor+" and dtype='VND') vendoracno,(select curdate()) basedate,(select job.voc_no from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobvocno";
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		int vendoracno=0;
		int vendortax=0;
		while(rsmisc.next()){
			sqlbasedate=rsmisc.getDate("basedate");
			jobvocno=rsmisc.getString("jobvocno");
			vendoracno=rsmisc.getInt("vendoracno");
			vendortax=rsmisc.getInt("vendortax");
			session.setAttribute("BRANCHID",rsmisc.getString("jobbrhid"));
		}
		ClsnipurchaseorderDAO npodao=new ClsnipurchaseorderDAO();
		String purchasedesc="NI Purchase Order for "+remarks;
		ArrayList<String> detailarray=new ArrayList();
		double nettotal=0.0;
		for(int i=0;i<strpartsarray.length;i++){
			detailarray.add(strpartsarray[i]);
			nettotal+=Double.parseDouble(strpartsarray[i].split("::")[strpartsarray[i].split("::").length-1]);
		}
		
		String strgetvendor="select head.curid,head.rate,head.doc_no,head.atype,head.description from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.dtype='VND' and ac.acno="+vendoracno;
		ResultSet rsgetvendor=stmt.executeQuery(strgetvendor);
		String acctype="",curid="",currate="";
		while(rsgetvendor.next()){
			curid=rsgetvendor.getString("curid");
			currate=rsgetvendor.getString("rate");
			acctype=rsgetvendor.getString("atype");
		}
	
		int nidocno=npodao.insert(sqlbasedate, sqlbasedate, "JOB-"+jobvocno, acctype, vendoracno+"", "", curid, currate,
				"", purchasedetails, purchasedesc, session, "A", nettotal, detailarray, "NPO", request, 0);
		
		if(nidocno<=0){
			errorstatus=1;
		}
		conn.setAutoCommit(false);
		//Updating NI Purchase Order Doc No
		for(int i=0;i<normalpartsarray.length;i++){
			String strmaxsrno="select coalesce(max(srno),0)+1 maxsrno from ws_estspare where rdocno="+estdocno;
			int maxsrno=0;
			ResultSet rsmaxsrno=stmt.executeQuery(strmaxsrno);
			while(rsmaxsrno.next()){
				maxsrno=rsmaxsrno.getInt("maxsrno");
			}
			String rowno=normalpartsarray[i].split("::")[0].trim();
			String desc=normalpartsarray[i].split("::")[1].trim();
			String qty=normalpartsarray[i].split("::")[2].trim();
			String rate=normalpartsarray[i].split("::")[3].trim();
			String psrno=normalpartsarray[i].split("::")[4].trim();
			String purchaseprice=normalpartsarray[i].split("::")[5].trim();
			psrno=psrno==null || psrno.trim().equalsIgnoreCase("") || psrno.trim().equalsIgnoreCase("undefined")?"0":psrno;
			desc=desc==null || desc.trim().equalsIgnoreCase("") || desc.trim().equalsIgnoreCase("undefined")?"":desc;
			qty=qty==null || qty.trim().equalsIgnoreCase("") || qty.trim().equalsIgnoreCase("undefined")?"0":qty;
			rate=rate==null || rate.trim().equalsIgnoreCase("") || rate.trim().equalsIgnoreCase("undefined")?"0":rate;
			purchaseprice=purchaseprice==null || purchaseprice.trim().equalsIgnoreCase("") || purchaseprice.trim().equalsIgnoreCase("undefined")?"0":purchaseprice;
			
			String estspare_rowno=rowno.trim();
			
			String strupdaterows="update ws_estspare set pono="+nidocno+",potype='NPO',nipoqty=nipoqty+"+qty+",nipoprice="+purchaseprice+" where rdocno="+estdocno+" and rowno="+rowno.trim();
			int update=stmt.executeUpdate(strupdaterows);
			if(update<0){
				errorstatus=1;
			}
			
			String strins="insert into ws_estsparepurchased(estdocno, estspare_rowno, dtype, doc_no, qty, price) values ("+estdocno+","+estspare_rowno+",'NPO',"+nidocno+","+qty+","+purchaseprice+")";
			int update2=stmt.executeUpdate(strins);
			if(update2<0){
				errorstatus=1;
			}
		}
		
		if(errorstatus==0){
			/* String strgetvocno="select voc_no from my_srvlpom where doc_no="+nidocno;
			ResultSet rsnivocno=stmt.executeQuery(strgetvocno);
			while(rsnivocno.next()){
				objdata.put("refdocno",rsnivocno.getString("voc_no"));	
			} */
			objdata.put("refdocno",request.getAttribute("vocno"));
			conn.commit();
			conn.close();
		}
	}
	else if(mode.equalsIgnoreCase("3")){
		java.sql.Date sqlinvdate=null;
		if(!invdate.trim().equalsIgnoreCase("")){
			sqlinvdate=objcommon.changeStringtoSqlDate(invdate);
		}
		String jobvocno="";
		java.sql.Date sqlbasedate=null;
		String strmisc="select (select job.brhid from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobbrhid,(select tax from my_acbook where status=3 and cldocno="+vendor+" and dtype='VND') vendortax,(select acno from my_acbook where status=3 and cldocno="+vendor+" and dtype='VND') vendoracno,(select curdate()) basedate,(select job.voc_no from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobvocno";
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		int vendoracno=0;
		int vendortax=0;
		while(rsmisc.next()){
			sqlbasedate=rsmisc.getDate("basedate");
			jobvocno=rsmisc.getString("jobvocno");
			vendoracno=rsmisc.getInt("vendoracno");
			vendortax=rsmisc.getInt("vendortax");
			session.setAttribute("BRANCHID",rsmisc.getString("jobbrhid"));
		}
		ClsnipurchaseDAO nipurchasedao=new ClsnipurchaseDAO();
		String purchasedesc="NI Purchase for "+remarks;
		ArrayList<String> detailarray=new ArrayList();
		double nettotal=0.0;
		for(int i=0;i<strpartsarray.length;i++){
			detailarray.add(strpartsarray[i]);
			nettotal+=Double.parseDouble(strpartsarray[i].split("::")[strpartsarray[i].split("::").length-1]);
		}
		
		String strgetvendor="select head.curid,head.rate,head.doc_no,head.atype,head.description from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.dtype='VND' and ac.acno="+vendoracno;
		ResultSet rsgetvendor=stmt.executeQuery(strgetvendor);
		String acctype="",curid="",currate="";
		while(rsgetvendor.next()){
			curid=rsgetvendor.getString("curid");
			currate=rsgetvendor.getString("rate");
			acctype=rsgetvendor.getString("atype");
		}
		
		int nidocno=nipurchasedao.insert(sqlbasedate,sqlbasedate,reftype,refno,acctype,vendoracno+"","",curid,currate,"",purchasedetails,
			purchasedesc,session,"A",nettotal,detailarray,"CPU",request,sqlbasedate,invno,invdate,vendortax,0.0,nettotal,1);
		if(nidocno<=0){
			errorstatus=1;
		}
		conn.setAutoCommit(false);
		//Updating NI Purchase Doc No
		for(int i=0;i<normalpartsarray.length;i++){
			String strmaxsrno="select coalesce(max(srno),0)+1 maxsrno from ws_estspare where rdocno="+estdocno;
			int maxsrno=0;
			ResultSet rsmaxsrno=stmt.executeQuery(strmaxsrno);
			while(rsmaxsrno.next()){
				maxsrno=rsmaxsrno.getInt("maxsrno");
			}
			String rowno=normalpartsarray[i].split("::")[0].trim();
			String desc=normalpartsarray[i].split("::")[1].trim();
			String qty=normalpartsarray[i].split("::")[2].trim();
			String rate=normalpartsarray[i].split("::")[3].trim();
			String psrno=normalpartsarray[i].split("::")[4].trim();
			String purchaseprice=normalpartsarray[i].split("::")[5].trim();
			psrno=psrno==null || psrno.trim().equalsIgnoreCase("") || psrno.trim().equalsIgnoreCase("undefined")?"0":psrno;
			desc=desc==null || desc.trim().equalsIgnoreCase("") || desc.trim().equalsIgnoreCase("undefined")?"":desc;
			qty=qty==null || qty.trim().equalsIgnoreCase("") || qty.trim().equalsIgnoreCase("undefined")?"0":qty;
			rate=rate==null || rate.trim().equalsIgnoreCase("") || rate.trim().equalsIgnoreCase("undefined")?"0":rate;
			//psrno=psrno==null || psrno.trim().equalsIgnoreCase("") || psrno.trim().equalsIgnoreCase("undefined")?"0":psrno;
			purchaseprice=purchaseprice==null || purchaseprice.trim().equalsIgnoreCase("") || purchaseprice.trim().equalsIgnoreCase("undefined")?"0":purchaseprice;
			String strupdaterows="";
			
			String estspare_rowno="";
			
			if(rowno!=null && !rowno.trim().equalsIgnoreCase("") && !rowno.trim().equalsIgnoreCase("undefined")){
				//Existing row
				strupdaterows="update ws_estspare set psrno="+psrno+",purchaseprice="+purchaseprice+",nipurchasedocno="+nidocno+",nipurchaseqty=nipurchaseqty+"+qty+" where rdocno="+estdocno+" and rowno="+rowno.trim();
				int update=stmt.executeUpdate(strupdaterows);
				if(update<0){
					errorstatus=1;
				}
				
				estspare_rowno=rowno.trim();
			}else{
				//New Row
				double total=Double.parseDouble(qty)*Double.parseDouble(rate);
				strupdaterows="insert into ws_estspare(rdocno,srno,psrno,qty,rate,total,addition,approvedvalue,description,nipurchasedocno,nipurchaseqty,purchaseprice)values("+estdocno+","+maxsrno+","+psrno+","+qty+","+rate+","+total+",0,"+total+",'"+desc+"',"+nidocno+","+qty+","+purchaseprice+")";
				int update=stmt.executeUpdate(strupdaterows);
				if(update<=0){
					errorstatus=1;
				}
				
				String strrowno="select rowno from ws_estspare where rdocno="+estdocno+" and psrno="+psrno+" and nipurchasedocno="+nidocno;
				ResultSet rsrowno=stmt.executeQuery(strrowno);
				while(rsrowno.next()){
					estspare_rowno=rsrowno.getString("rowno");
				}
			}
			
			String strins="insert into ws_estsparepurchased(estdocno, estspare_rowno, dtype, doc_no, qty, price) values ("+estdocno+","+estspare_rowno+",'CPU',"+nidocno+","+qty+","+purchaseprice+")";
			int update2=stmt.executeUpdate(strins);
			if(update2<0){
				errorstatus=1;
			}
		}
		
		if(errorstatus==0){
			objdata.put("refdocno",request.getAttribute("vocno"));	
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
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>