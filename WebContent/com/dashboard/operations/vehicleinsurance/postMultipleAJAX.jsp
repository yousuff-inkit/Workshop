<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.common.*" %>
<%@page import="com.finance.transactions.journalvouchers.*" %>
<%
ClsJournalVouchersDAO journaldao=new ClsJournalVouchersDAO();
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;
String strmultiplearray=request.getParameter("multiplearray")==null?"":request.getParameter("multiplearray");
System.out.println("Checking Parameter as recieved: "+strmultiplearray);
ArrayList<String> multiplearray=new ArrayList();
String[] temparray=strmultiplearray.split(",");
for(int i=0;i<temparray.length;i++){
	multiplearray.add(temparray[i]);
	System.out.println("Checking Parameter:"+temparray[i]);
}
String percentage=request.getParameter("percentage")==null?"":request.getParameter("percentage");
String insuruptodate=request.getParameter("insuruptodate")==null?"":request.getParameter("insuruptodate");
String postdate=request.getParameter("postdate")==null?"":request.getParameter("postdate");
String vendoracno=request.getParameter("vendoracno")==null?"":request.getParameter("vendoracno");

int errorstatus=0;
int journalinsert=0;
try{
	conn=objconn.getMyConnection();
	
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqlinsuruptodate=null;
	java.sql.Date sqlpostdate=null;
	int insuracno=0,insurcurid=0;
	double insurcurrate=0.0;
	if(!insuruptodate.equalsIgnoreCase("") && insuruptodate!=null){
		sqlinsuruptodate=objcommon.changeStringtoSqlDate(insuruptodate);
	}
	if(!postdate.equalsIgnoreCase("") && postdate!=null){
		sqlpostdate=objcommon.changeStringtoSqlDate(postdate);
	}
	int agmtbranch=0;
	System.out.println("checking First Agmt: "+multiplearray.get(0).split("///")[0]);
	System.out.println("checking First Agmt: "+multiplearray);
	String stragmtbranch="select brhid from gl_lagmt where doc_no="+multiplearray.get(0).split("///")[0];
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
	double jvsum=0.0;
	ArrayList<String> inserteddocarray=new ArrayList();
	String stragmtvocno="",stragmtfleetno="";
	
	for(int i=0;i<multiplearray.size();i++){
		String[] temp=multiplearray.get(i).split("///");
		String agmtno=temp[0];
		
		java.sql.Date sqlinsurfromdate=null;
		/* String strgetfromdate="select coalesce(date_add(insurfromdate,interval 1 day),outdate) insurfromdate from gl_lagmt where doc_no="+agmtno;
		ResultSet rsgetfromdate=stmt.executeQuery(strgetfromdate);
		while(rsgetfromdate.next()){
			sqlinsurfromdate=rsgetfromdate.getDate("insurfromdate");
		} */
		String strinsurdate="select (select outdate from gl_lagmt where status=3 and doc_no="+agmtno+") outdate,(select insurtodate from gl_vehinsur where doc_no=(select max(doc_no) from gl_vehinsur where agmtno="+agmtno+" and status=3 and terminatestatus=0 group by agmtno))insurtodate";
		System.out.println(strinsurdate);
		ResultSet rsinsurdate=stmt.executeQuery(strinsurdate);
		while(rsinsurdate.next()){
			if(rsinsurdate.getDate("insurtodate")!=null){
				sqlinsurfromdate=rsinsurdate.getDate("insurtodate");
			}
			else{
				sqlinsurfromdate=rsinsurdate.getDate("outdate");
			}
		}
		String strinsurdatediff="select datediff('"+sqlinsuruptodate+"','"+sqlinsurfromdate+"') insurdatediff";
		ResultSet rsinsurdatediff=stmt.executeQuery(strinsurdatediff);
		int insurdatediff=0;
		while(rsinsurdatediff.next()){
			insurdatediff=rsinsurdatediff.getInt("insurdatediff");
		}
		double invamount=(Double.parseDouble(percentage)/100)*(Double.parseDouble(temp[2]));
		System.out.println("Amount: "+invamount);
		invamount=objcommon.Round((invamount/365)*insurdatediff, 2);
		System.out.println("Amount2: "+invamount);
		jvsum+=invamount;
		
		String strinsertmaster="insert into gl_vehinsur(agmtno,BRHID,vendorid,invdate,amount,insurfromdate,insurtodate,status,postdate) values("+agmtno+","+agmtbranch+","+vendoracno+",'"+sqlpostdate+"',"+invamount+",'"+sqlinsurfromdate+"','"+sqlinsuruptodate+"',3,'"+sqlinsurfromdate+"')";
		System.out.println(strinsertmaster);
		int masterinsert=stmt.executeUpdate(strinsertmaster);
		if(masterinsert<=0){
			System.out.println("Master Error");
			errorstatus=1;
		}
		String strgetmaxinserteddoc="select max(doc_no) maxdoc from gl_vehinsur";
		ResultSet rsmaxinserteddoc=stmt.executeQuery(strgetmaxinserteddoc);
		while(rsmaxinserteddoc.next()){
			inserteddocarray.add(rsmaxinserteddoc.getString("maxdoc"));
		}
		String strupdatefromdate="update gl_lagmt set insurfromdate='"+sqlinsuruptodate+"' where doc_no="+agmtno;
		int updateagmt=stmt.executeUpdate(strupdatefromdate);
		if(updateagmt<0){
			errorstatus=1;
		}
		String stragmtdetail="select voc_no,if(perfleet=0,tmpfleet,perfleet) fleetno from gl_lagmt where doc_no="+agmtno;
		ResultSet rsagmtdetail=stmt.executeQuery(stragmtdetail);
		
		while(rsagmtdetail.next()){
			if(i==0){
				stragmtvocno=" with Agmt "+rsagmtdetail.getString("voc_no");
				stragmtfleetno=" and Fleet "+rsagmtdetail.getString("fleetno");
			}
			else{
				stragmtvocno+=","+rsagmtdetail.getString("voc_no");
				stragmtfleetno+=","+rsagmtdetail.getString("fleetno");
			}
			
		}
	}
	int jvrefid=0;
	String strgetjvrefid="select jvid from my_jvidentifyingid where menu_name='Vehicle Insurance'";
	ResultSet rsjvrefid=stmt.executeQuery(strgetjvrefid);
	while(rsjvrefid.next()){
		jvrefid=rsjvrefid.getInt("jvid");
	}
	ArrayList<String> journalarray=new ArrayList();
	/* String txtdescription="Vehicle Insurance is passed as JVT on "+postdate+stragmtvocno+stragmtfleetno; */
	String txtdescription="Vehicle Insurance - "+stragmtvocno+stragmtfleetno;
	journalarray.add(vendoracno+"::"+txtdescription+"::"+insurcurid+"::"+insurcurrate+"::"+jvsum*-1+"::"+(jvsum*insurcurrate)*-1+"::"+"0"+"::"+"-1"+"::"+"0"+"::"+"0");
	journalarray.add(insuracno+"::"+txtdescription+"::"+insurcurid+"::"+insurcurrate+"::"+jvsum+"::"+(jvsum*insurcurrate)+"::"+"1"+"::"+"1"+"::"+"0"+"::"+"0");
	//Inserting JV
	journalinsert=journaldao.insert(sqlpostdate, "JVT", jvrefid+"", txtdescription, jvsum, jvsum, journalarray, session, request);
	if(journalinsert<=0){
		System.out.println("Journal Error");
		errorstatus=1;
	}
	
	for(int i=0;i<inserteddocarray.size();i++){
		String strupdate="update gl_vehinsur set jvdoc="+journalinsert+",insurtrno="+request.getAttribute("tranno")+" where doc_no="+inserteddocarray.get(i);
		int updatedoc=stmt.executeUpdate(strupdate);
		if(updatedoc<0){
			System.out.println("Journal Error");
			errorstatus=1;
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
String result="";
if(errorstatus==0){
	result=journalinsert+"";
}
else{
	result="0";
}
response.getWriter().write(result);
%>