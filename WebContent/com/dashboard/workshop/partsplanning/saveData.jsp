<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.procurement.purchase.purchaserequest.ClsPurchaserequestDAO"%>
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
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");

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
			System.out.println(strpartsarray[i]);
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
			//psrno=psrno==null || psrno.trim().equalsIgnoreCase("") || psrno.trim().equalsIgnoreCase("undefined")?"0":psrno;
			
			String strupdaterows="";
			if(rowno!=null && !rowno.trim().equalsIgnoreCase("") && !rowno.trim().equalsIgnoreCase("undefined")){
				//Existing row
				strupdaterows="update ws_estspare set psrno="+psrno+" where rdocno="+estdocno+" and rowno="+rowno.trim();
				System.out.println(strupdaterows);
				int update=stmt.executeUpdate(strupdaterows);
				if(update<0){
					errorstatus=1;
				}
			}
			else{
				//New Row
				double total=Double.parseDouble(qty)*Double.parseDouble(rate);
				strupdaterows="insert into ws_estspare(rdocno,srno,psrno,qty,rate,total,addition,approvedvalue,description)values("+estdocno+","+maxsrno+","+psrno+","+qty+","+rate+","+total+",0,"+total+",'"+desc+"')";
				System.out.println(strupdaterows);
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
		//Purchase Request 
		
		ClsPurchaserequestDAO reqdao=new ClsPurchaserequestDAO();
		java.sql.Date sqlbasedate=null;
		String jobvocno="";
		String strmisc="select (select job.brhid from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobbrhid,(select curdate()) basedate,(select job.voc_no from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no where est.doc_no="+estdocno+") jobvocno";
		System.out.println(strmisc);
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		while(rsmisc.next()){
			sqlbasedate=rsmisc.getDate("basedate");
			jobvocno=rsmisc.getString("jobvocno");
			session.setAttribute("BRANCHID",rsmisc.getString("jobbrhid"));
		}
		String purchasedesc="Purchase Request for Job Card #"+jobvocno;
		ArrayList<String> masterarray=new ArrayList();
		for(int i=0;i<strpartsarray.length;i++){
			System.out.println(strpartsarray[i]);
			String rowno=strpartsarray[i].split("::")[0].trim();
			String desc=strpartsarray[i].split("::")[1].trim();
			String qty=strpartsarray[i].split("::")[2].trim();
			String rate=strpartsarray[i].split("::")[3].trim();
			String psrno=strpartsarray[i].split("::")[4].trim();
			String prdid=strpartsarray[i].split("::")[5].trim();
			String unitdocno=strpartsarray[i].split("::")[6].trim();
			String specid=strpartsarray[i].split("::")[7].trim();
			psrno=psrno==null || psrno.trim().equalsIgnoreCase("") || psrno.trim().equalsIgnoreCase("undefined")?"0":psrno;
			desc=desc==null || desc.trim().equalsIgnoreCase("") || desc.trim().equalsIgnoreCase("undefined")?"":desc;
			qty=qty==null || qty.trim().equalsIgnoreCase("") || qty.trim().equalsIgnoreCase("undefined")?"0":qty;
			rate=rate==null || rate.trim().equalsIgnoreCase("") || rate.trim().equalsIgnoreCase("undefined")?"0":rate;
			prdid=prdid==null || prdid.trim().equalsIgnoreCase("") || prdid.trim().equalsIgnoreCase("undefined")?"0":prdid;
			unitdocno=unitdocno==null || unitdocno.trim().equalsIgnoreCase("") || unitdocno.trim().equalsIgnoreCase("undefined")?"":unitdocno;
			specid=specid==null || specid.trim().equalsIgnoreCase("") || specid.trim().equalsIgnoreCase("undefined")?"0":specid;
			
			masterarray.add(psrno+"::"+prdid+"::"+unitdocno+"::"+qty+"::"+specid);
		}
		
		int reqdocno=reqdao.insert(sqlbasedate,"",purchasedesc, session, "A", "PR", request, 
			masterarray, 0, 0);
		System.out.println("Request Doc No:"+reqdocno);
		if(reqdocno<=0){
			errorstatus=1;
		}
		conn.setAutoCommit(false);
		//Updating purchase Req Doc No
		for(int i=0;i<strpartsarray.length;i++){
			System.out.println(strpartsarray[i]);
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
			//psrno=psrno==null || psrno.trim().equalsIgnoreCase("") || psrno.trim().equalsIgnoreCase("undefined")?"0":psrno;
			
			String strupdaterows="";
			if(rowno!=null && !rowno.trim().equalsIgnoreCase("") && !rowno.trim().equalsIgnoreCase("undefined")){
				//Existing row
				strupdaterows="update ws_estspare set psrno="+psrno+",purchasereqdocno="+reqdocno+" where rdocno="+estdocno+" and rowno="+rowno.trim();
				System.out.println(strupdaterows);
				int update=stmt.executeUpdate(strupdaterows);
				if(update<0){
					errorstatus=1;
				}
			}
			else{
				//New Row
				double total=Double.parseDouble(qty)*Double.parseDouble(rate);
				strupdaterows="insert into ws_estspare(rdocno,srno,psrno,qty,rate,total,addition,approvedvalue,description,purchasereqdocno)values("+estdocno+","+maxsrno+","+psrno+","+qty+","+rate+","+total+",0,"+total+",'"+desc+"',"+reqdocno+")";
				System.out.println(strupdaterows);
				int update=stmt.executeUpdate(strupdaterows);
				if(update<=0){
					errorstatus=1;
				}
			}
		}
		if(errorstatus==0){
			String strgetvocno="select voc_no from my_reqm where doc_no="+reqdocno;
			ResultSet rsnivocno=stmt.executeQuery(strgetvocno);
			while(rsnivocno.next()){
				objdata.put("refdocno",rsnivocno.getString("voc_no"));	
			}
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
		System.out.println(strmisc);
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
		String purchasedesc="NI Purchase for Job Card #"+jobvocno;
		ArrayList<String> detailarray=new ArrayList();
		double nettotal=0.0;
		for(int i=0;i<strpartsarray.length;i++){
			detailarray.add(strpartsarray[i]);
			nettotal+=Double.parseDouble(strpartsarray[i].split("::")[strpartsarray[i].split("::").length-1]);
		}
		int nidocno=nipurchasedao.insert(sqlbasedate,sqlbasedate,"DIR",0,"AP",vendoracno+"","","1","1","","",
			purchasedesc,session,"A",nettotal,detailarray,"CPU",request,sqlbasedate,invno,invdate,vendortax,0.0,nettotal,1);
		if(nidocno<=0){
			errorstatus=1;
		}
		conn.setAutoCommit(false);
		//Updating NI Purchase Doc No
		for(int i=0;i<normalpartsarray.length;i++){
			System.out.println(strpartsarray[i]);
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
			if(rowno!=null && !rowno.trim().equalsIgnoreCase("") && !rowno.trim().equalsIgnoreCase("undefined")){
				//Existing row
				strupdaterows="update ws_estspare set psrno="+psrno+",purchaseprice="+purchaseprice+",nipurchasedocno="+nidocno+" where rdocno="+estdocno+" and rowno="+rowno.trim();
				System.out.println(strupdaterows);
				int update=stmt.executeUpdate(strupdaterows);
				if(update<0){
					errorstatus=1;
				}
			}
			else{
				//New Row
				double total=Double.parseDouble(qty)*Double.parseDouble(rate);
				strupdaterows="insert into ws_estspare(rdocno,srno,psrno,qty,rate,total,addition,approvedvalue,description,nipurchasedocno,purchaseprice)values("+estdocno+","+maxsrno+","+psrno+","+qty+","+rate+","+total+",0,"+total+",'"+desc+"',"+nidocno+","+purchaseprice+")";
				System.out.println(strupdaterows);
				int update=stmt.executeUpdate(strupdaterows);
				if(update<=0){
					errorstatus=1;
				}
			}
		}
		if(errorstatus==0){
			String strgetvocno="select voc_no from my_srvpurm where doc_no="+nidocno;
			ResultSet rsnivocno=stmt.executeQuery(strgetvocno);
			while(rsnivocno.next()){
				objdata.put("refdocno",rsnivocno.getString("voc_no"));	
			}
			
			conn.commit();
			conn.close();
		}
		
		
		/* Date sqlStartDate,Date purdeldate, String reftype,int refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
		HttpServletRequest request, Date sqlinvdate, String invno,String indateval, int ptype,double rval,double oval */
		//insert(sqlinvdate, sqlinvdate, "DIR", refno, acctype, accdoc, puraccname, cmbcurr, currate, delterms, payterms, purdesc, session, mode, nettotal, descarray, Formdetailcode, request, sqlinvdate, invno, indateval, ptype, rval, oval);
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