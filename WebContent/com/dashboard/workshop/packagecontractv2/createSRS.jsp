<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleAction"%>
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno");
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0,srsdocno=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsServiceSaleDAO objsrs=new ClsServiceSaleDAO();
	conn=objconn.getMyConnection();
	String strgetmisc="select coalesce(wp.regno,'') regno,coalesce(wp.chassisno,'') chassisno,(select acno from my_account where codeno='WORKSHOPPKGAMT') compacno,wp.brhid,coalesce(ac.tax,0) tax,"+
	" round(coalesce(p.amount,0.0),2) packamt,concat(date_format(wp.fromdate,'%d.%m.%Y'),' to ',date_format(wp.fromdate,'%d.%m.%Y'),' - ',p.packagename) customdesc,"+
	" head.curid,head.rate,head.atype,head.account,head.doc_no acno,head.description acname,wp.voc_no contractvocno,CURDATE() sqlbasedate from "+
	" ws_packagecontract wp left join my_acbook ac on wp.cldocno=ac.cldocno and ac.dtype='CRM' left join my_head head on ac.acno=head.doc_no "+
	" left join gl_vehmodel model on wp.modeldocno=model.doc_no left join ws_packagem p on wp.packagedocno=p.doc_no where wp.doc_no="+contractdocno;
	Statement stmt=conn.createStatement();
	ResultSet rsgetmisc=stmt.executeQuery(strgetmisc);
	java.sql.Date sqlbasedate=null;
	java.sql.Date sqlfromdate=null,sqltodate=null;
	String contractvocno="",clientactype="",clientacname="",clientacno="",clientcurid="",clientcurrate="",customdesc="";
	String regno="",chassisno="";
	int clienttax=0,brhid=0,compacno=0;
	Double packamt=0.0;
	while(rsgetmisc.next()){
		sqlbasedate=rsgetmisc.getDate("sqlbasedate");
		contractvocno=rsgetmisc.getString("contractvocno");
		clientacname=rsgetmisc.getString("acname");
		clientactype=rsgetmisc.getString("atype");
		clientacno=rsgetmisc.getString("acno");
		clientcurid=rsgetmisc.getString("curid");
		clientcurrate=rsgetmisc.getString("rate");
		customdesc=rsgetmisc.getString("customdesc");
		packamt=rsgetmisc.getDouble("packamt");
		clienttax=rsgetmisc.getInt("tax");
		brhid=rsgetmisc.getInt("brhid");
		compacno=rsgetmisc.getInt("compacno");
		regno=rsgetmisc.getString("regno");
		chassisno=rsgetmisc.getString("chassisno");
	}
	
	if(!regno.equalsIgnoreCase("")){
		customdesc+=" ,Reg No: "+regno;
	}
	if(!chassisno.equalsIgnoreCase("")){
		customdesc+=" ,Chassis No: "+chassisno;
	}
	//Getting Tax Percent
	Double taxpercent=0.0;
	if(clienttax==1){
		String strgettax="select coalesce(d.vat_per,0) vat_per from gl_taxmaster m inner join gl_taxdetail d on m.doc_no=d.doc_no left join my_brch br on br.prvdocno=m.provid"+
		" where br.doc_no="+brhid+" and '"+sqlbasedate+"' between d.fromdate and d.todate";
		ResultSet rsgettax=stmt.executeQuery(strgettax);
		while(rsgettax.next()){
			taxpercent=rsgettax.getDouble("vat_per");
		}
	}
	ClsServiceSaleAction masteraction=new ClsServiceSaleAction();
	masteraction.setDelno("");
	
	ArrayList<String> srsarray=new ArrayList();
	String maindesc="Package Charges of Contract "+contractvocno;	
	ClsCommon objcommon=new ClsCommon();
	Double taxamt=(packamt*(taxpercent/100));
	taxamt=objcommon.Round(taxamt, 2);
	Double taxtotal=taxamt+packamt;
	taxtotal=objcommon.Round(taxtotal,2);
	srsarray.add(1+"::"+1+" :: "+customdesc+" :: "+packamt+" :: "+packamt+" :: "+0.0+" :: "+packamt+" :: "+taxpercent+" :: "+taxamt+" :: "+taxtotal+" :: "+packamt+" :: "+0+" :: "+0+" :: "+customdesc+" :: "+compacno+" :: "+0);
	if(conn!=null){
		conn.close();
	}
	srsdocno=objsrs.insert(sqlbasedate, sqlbasedate, "DIR", "WPC "+contractvocno,clientactype,clientacno,clientacname, clientcurid, clientcurrate, 
			"", "", customdesc, session, "A", packamt, srsarray, "SRS", request, sqlbasedate, "0", "", 0, taxpercent, masteraction);
	
	if(srsdocno>0){
		//Updating Contract
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
		//Getting SRS Voc No
		String srsvocno="";
		String strsrs="select voc_no from my_srvsalem where doc_no="+srsdocno;
		ResultSet rssrs=stmt.executeQuery(strsrs);
		while(rssrs.next()){
			srsvocno=rssrs.getString("voc_no");
		}
		objdata.put("srsvocno",srsvocno);
		String strupdate="update ws_packagecontract set srsdocno="+srsdocno+" where doc_no="+contractdocno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
		else{
			conn.commit();
		}
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	if(conn!=null){
		conn.close();
	}
}
objdata.put("errorstatus",errorstatus);
objdata.put("srsdocno",srsdocno);
response.getWriter().write(objdata+"");
%>