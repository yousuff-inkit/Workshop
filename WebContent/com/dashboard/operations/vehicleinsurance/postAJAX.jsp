<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.finance.transactions.journalvouchers.*"%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String invamount=request.getParameter("invamount")==null?"":request.getParameter("invamount");
String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String insurfromdate=request.getParameter("insurfromdate")==null?"":request.getParameter("insurfromdate");
String insurtodate=request.getParameter("insurtodate")==null?"":request.getParameter("insurtodate");
String vendoracno=request.getParameter("vendoracno")==null?"":request.getParameter("vendoracno");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
ClsJournalVouchersDAO journaldao=new ClsJournalVouchersDAO();
int errorstatus=0;
int journalinsert=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	java.sql.Date sqlinvdate=null,sqlinsurfromdate=null,sqlinsurtodate=null;
	if(!invdate.equalsIgnoreCase("")){
		sqlinvdate=objcommon.changeStringtoSqlDate(invdate);
	}
	if(!insurfromdate.equalsIgnoreCase("")){
		sqlinsurfromdate=objcommon.changeStringtoSqlDate(insurfromdate);
	}
	if(!insurtodate.equalsIgnoreCase("")){
		sqlinsurtodate=objcommon.changeStringtoSqlDate(insurtodate);
	}
	Statement stmt=conn.createStatement();
	int insuracno=0,insurcurid=0,jvrefid=0;
	double insurcurrate=0.0;
	ArrayList<String> journalarray=new ArrayList();
	int agmtbranch=0;
	String stragmtbranch="select brhid from gl_lagmt where doc_no="+agmtno;
	ResultSet rsagmtbranch=stmt.executeQuery(stragmtbranch);
	while(rsagmtbranch.next()){
		agmtbranch=rsagmtbranch.getInt("brhid");
	}
	session.setAttribute("BRANCHID", agmtbranch);
	String strinsuracno="select head.doc_no,head.curid,head.rate from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='VEHICLE INSURANCE PREPAID'";
	ResultSet rsinsuracno=stmt.executeQuery(strinsuracno);
	while(rsinsuracno.next()){
		insuracno=rsinsuracno.getInt("doc_no");
		insurcurid=rsinsuracno.getInt("curid");
		insurcurrate=rsinsuracno.getDouble("rate");
	}
	String strinsertmaster="insert into gl_vehinsur(agmtno,BRHID,vendorid,invno,invdate,amount,insurfromdate,insurtodate,status,postdate)values("+agmtno+","+agmtbranch+","+vendoracno+","+invno+",'"+sqlinvdate+"',"+invamount+",'"+sqlinsurfromdate+"','"+sqlinsurtodate+"',3,'"+sqlinsurfromdate+"')";
	System.out.println(strinsertmaster);
	int masterinsert=stmt.executeUpdate(strinsertmaster);
	if(masterinsert<=0){
		System.out.println("Master Error");
		errorstatus=1;
	}
	else{
		String strgetjvrefid="select jvid from my_jvidentifyingid where menu_name='Vehicle Insurance'";
		ResultSet rsjvrefid=stmt.executeQuery(strgetjvrefid);
		while(rsjvrefid.next()){
			jvrefid=rsjvrefid.getInt("jvid");
		}
		String stragmtdetail="select voc_no,if(perfleet=0,tmpfleet,perfleet) fleetno from gl_lagmt where doc_no="+agmtno;
		ResultSet rsagmtdetail=stmt.executeQuery(stragmtdetail);
		String stragmtvocno="",stragmtfleetno="";
		while(rsagmtdetail.next()){
			stragmtvocno=" with Agmt "+rsagmtdetail.getString("voc_no");
			stragmtfleetno=" and Fleet "+rsagmtdetail.getString("fleetno");
			
		}
		/* String txtdescription="Vehicle Insurance is passed as JVT on "+postdate+stragmtvocno+stragmtfleetno; */
		String txtdescription="Vehicle Insurance - "+stragmtvocno+stragmtfleetno;
		journalarray.add(vendoracno+"::"+txtdescription+"::"+insurcurid+"::"+insurcurrate+"::"+Double.parseDouble(invamount)*-1+"::"+((Double.parseDouble(invamount))*insurcurrate)*-1+"::"+"0"+"::"+"-1"+"::"+"0"+"::"+"0");
		journalarray.add(insuracno+"::"+txtdescription+"::"+insurcurid+"::"+insurcurrate+"::"+Double.parseDouble(invamount)+"::"+((Double.parseDouble(invamount))*insurcurrate)+"::"+"1"+"::"+"1"+"::"+"0"+"::"+"0");
		//Inserting JV
		journalinsert=journaldao.insert(sqlinvdate, "JVT", jvrefid+"", txtdescription, Double.parseDouble(invamount), Double.parseDouble(invamount), journalarray, session, request);
		if(journalinsert<=0){
			System.out.println("Journal Error");
			errorstatus=1;
		}
		else{
			int docno=0;
			ResultSet rsgetinserteddoc=stmt.executeQuery("select max(doc_no) maxdoc from gl_vehinsur");
			while(rsgetinserteddoc.next()){
				docno=rsgetinserteddoc.getInt("maxdoc");
			}
			String strupdatejvno="update gl_vehinsur set jvdoc="+journalinsert+",insurtrno="+request.getAttribute("tranno")+"  where doc_no="+docno;
			int updatejvno=stmt.executeUpdate(strupdatejvno);
			if(updatejvno<=0){
				System.out.println("Update JV Error");
				errorstatus=1;
			}
		}
	}

	if(errorstatus==0){
		System.out.println("No Errors");
		conn.commit();
		stmt.close();
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
String result="";
if(errorstatus==0){
	result=journalinsert+"";
}
else{
	result="0";
}
response.getWriter().write(result+"");
%>