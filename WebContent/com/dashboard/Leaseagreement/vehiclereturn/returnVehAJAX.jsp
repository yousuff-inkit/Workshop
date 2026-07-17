<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
Connection conn=null;
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
ClsJournalVouchersDAO journaldao=new ClsJournalVouchersDAO();
String branchid=request.getParameter("branchid")==null?"":request.getParameter("branchid");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String calcstrarray=request.getParameter("calcarray")==null?"":request.getParameter("calcarray");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String salesprice=request.getParameter("salesvalue")==null?"":request.getParameter("salesvalue");
String stockvehiclestatus=request.getParameter("stockvehiclestatus")==null?"":request.getParameter("stockvehiclestatus");
java.sql.Date sqldate=null;
if(!date.equalsIgnoreCase("")){
	sqldate=objcommon.changeStringtoSqlDate(date);
}
ArrayList<String> calcarray=new ArrayList<String>();
if(!calcstrarray.equalsIgnoreCase("")){
	String temp[]=calcstrarray.split(",");
	for(int i=0;i<temp.length;i++){
		calcarray.add(temp[i]);
	}	
}
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	double currate=0.0;
	String userid=session.getAttribute("USERID").toString();
	
	int maxdocno=0;
	
	//Inserting into master
	
	String txtrefno="",vocno="";
	double txtdrtotal=0.0,txtcrtotal=0.0;
	int costtranacno=0;
	String txtdescription="";
	txtdescription="JV Posted on "+date+" for Lease Agreement "+vocno+" with fleet "+fleetno+"";
	if(stockvehiclestatus.equalsIgnoreCase("1")){
		txtdescription="JV Posted on "+date+" for Stock Vehicle "+fleetno+"";
	}
	ResultSet rsjvid=stmt.executeQuery("select (select jvid from my_jvidentifyingid where menu_name='Vehicle Return') jvid,"+
	"(select voc_no from gl_lagmt where doc_no="+agmtno+") vocno,"+
	"(select sum(amount*id) from gl_vehreturncalc where agmtno="+agmtno+" and fleetno="+fleetno+" and id=1) drtotal,"+
	"(select sum(amount*id) from gl_vehreturncalc where agmtno="+agmtno+" and fleetno="+fleetno+" and id=-1) crtotal,"+
	"(select head.doc_no from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='VDE') costtranacno"); 
	while(rsjvid.next()){
		txtrefno=rsjvid.getString("jvid");
		vocno=rsjvid.getString("vocno");
		txtdrtotal=rsjvid.getDouble("drtotal");
		txtcrtotal=rsjvid.getDouble("crtotal");
		costtranacno=rsjvid.getInt("costtranacno");
	}
	ArrayList<String> journalarray=new ArrayList();
	ArrayList<String> assetarray=new ArrayList();
	String vadacno="",vehacno="";
	String acnodetails="select (select acno from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='VAD') vadacno,"+
	" (select acno from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='VEH') vehacno";
	ResultSet rsacnodetails=stmt.executeQuery(acnodetails);
	while(rsacnodetails.next()){
		vadacno=rsacnodetails.getString("vadacno");
		vehacno=rsacnodetails.getString("vehacno");
	}
	String strcalc="select head.doc_no acno,head.curid,head.rate currate,amount*id amount,(amount*id)*head.rate amountwithrate,if(amount*id<0,-1,1) id from gl_vehreturncalc calc inner join my_head head on calc.acno=head.doc_no where "+
	" calc.fleetno="+fleetno+" and calc.agmtno="+agmtno;
	ResultSet rscalc=stmt.executeQuery(strcalc);
	while(rscalc.next()){
		if(rscalc.getString("acno").equalsIgnoreCase(vadacno) || rscalc.getString("acno").equalsIgnoreCase(vehacno)){
			assetarray.add(rscalc.getString("acno")+"::"+rscalc.getString("amount")+"::"+rscalc.getString("id"));
		}
		journalarray.add(rscalc.getString("acno")+"::"+txtdescription+"::"+rscalc.getString("curid")+"::"+rscalc.getString("currate")+"::"+rscalc.getString("amount")+"::"+rscalc.getString("amountwithrate")+"::"+"0"+"::"+rscalc.getString("id")+"::"+"0"+"::"+"0");
	}
	int journalval=journaldao.insert(sqldate, "JVT", txtrefno, txtdescription, txtdrtotal, txtcrtotal, journalarray, session, request);
	if(journalval>0){

		conn.setAutoCommit(false);
		int tranid=0;
		double costtranamt=0.0;
		
		String strtranid="select tranid,dramount from my_jvtran where tr_no="+request.getAttribute("tranno")+" and acno="+costtranacno;
		ResultSet rstranid=stmt.executeQuery(strtranid);
		while(rstranid.next()){
			tranid=rstranid.getInt("tranid");
			costtranamt=rstranid.getDouble("dramount");
		}
		String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+costtranacno+",6,"+costtranamt+",1,"+tranid+",0,"+fleetno+","+request.getAttribute("tranno")+")";
		int costinsert=stmt.executeUpdate(strcostinsert);
		if(costinsert<=0){
			errorstatus=1;
		}
	}
	String strupdateveh="update gl_vehmaster set fstatus='Z' where fleet_no="+fleetno;
	System.out.println("vehupdate: "+strupdateveh);
	
	int updateveh=stmt.executeUpdate(strupdateveh);
	if(updateveh<0){
		errorstatus=1;
	}
	else{
		String strupdateagmt="";
		strupdateagmt="update gl_lagmt set vehreturnstatus=1 where doc_no="+agmtno;
		if(stockvehiclestatus.equalsIgnoreCase("1")){
			strupdateagmt="update gl_stockvehicles set vehreturnstatus=1 where doc_no="+agmtno;
		}
		int updateagmt=stmt.executeUpdate(strupdateagmt);
		if(updateagmt<0){
			errorstatus=1;
		}
		else{
			String strmaxdocno="select coalesce(max(doc_no)+1,1) maxdocno from gl_vehreturn ";
			ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
			while(rsmaxdocno.next()){
				maxdocno=rsmaxdocno.getInt("maxdocno");
			}
			String strinsertmaster="insert into gl_vehreturn(date,agmtno,fleetno,status,defleetstatus,cldocno,salesprice)values('"+sqldate+"',"+agmtno+","+fleetno+",3,1,"+cldocno+","+salesprice+")";
			System.out.println("Master: "+strinsertmaster);

			int insertmaster=stmt.executeUpdate(strinsertmaster);
			if(insertmaster<=0){
				errorstatus=1;
			}
			else{
				//Insertion to gc_assettran
				for(int i=0;i<assetarray.size();i++){
					String temp[]=assetarray.get(i).split("::");
					double amount=Double.parseDouble(temp[1]);
					String dtype="";
					if(i==1 && temp[0].equalsIgnoreCase(vadacno)){
						dtype="VPO";
					}
					else{
						dtype="VSI";
					}
					String strasset="insert into gc_assettran(date,doc_no,tr_no,fleet_no,acno,dramount,book_value,brhid,ttype,ftype)values('"+sqldate+"',"+maxdocno+","+request.getAttribute("tranno")+","+fleetno+","+temp[0]+","+amount+","+amount+","+branchid+",'"+dtype+"',1)";
					int assetinsert=stmt.executeUpdate(strasset);
					if(assetinsert<=0){
						errorstatus=1;
						break;
					}
					
				}
			}
			
			String sqllog="insert into gl_biblog (doc_no,brhId,dtype,edate,userId,ENTRY) values ('"+maxdocno+"','"+branchid+"','BLVR',now(),'"+userid+"','A')";
			int loginsert=stmt.executeUpdate(sqllog);
			if(loginsert<=0){
				errorstatus=1;
			}
		}
	}
	if(errorstatus!=1){
		conn.commit();
		
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>