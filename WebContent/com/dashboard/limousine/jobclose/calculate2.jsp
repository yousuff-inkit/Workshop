<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String jobname=request.getParameter("jobname")==null?"":request.getParameter("jobname");
String tarifdocno=request.getParameter("tarifdocno")==null?"":request.getParameter("tarifdocno");
String tarifdetaildocno=request.getParameter("tarifdetaildocno")==null?"":request.getParameter("tarifdetaildocno");
String startdate=request.getParameter("startdate")==null?"":request.getParameter("startdate");
String starttime=request.getParameter("starttime")==null?"":request.getParameter("starttime");
String startkm=request.getParameter("startkm")==null?"":request.getParameter("startkm");
String enddate=request.getParameter("enddate")==null?"":request.getParameter("enddate");
String endtime=request.getParameter("endtime")==null?"":request.getParameter("endtime");
String endkm=request.getParameter("endkm")==null?"":request.getParameter("endkm");
String fuelchg=request.getParameter("fuelchg")==null || request.getParameter("fuelchg").equalsIgnoreCase("undefined") || request.getParameter("fuelchg").equalsIgnoreCase("")?"0.0":request.getParameter("fuelchg");
String parkingchg=request.getParameter("parkingchg")==null || request.getParameter("parkingchg").equalsIgnoreCase("undefined") || request.getParameter("parkingchg").equalsIgnoreCase("")?"0.0":request.getParameter("parkingchg");
String otherchg=request.getParameter("otherchg")==null || request.getParameter("otherchg").equalsIgnoreCase("undefined") || request.getParameter("otherchg").equalsIgnoreCase("")?"0.0":request.getParameter("otherchg");
String greetchg=request.getParameter("greetchg")==null || request.getParameter("greetchg").equalsIgnoreCase("undefined") || request.getParameter("greetchg").equalsIgnoreCase("")?"0.0":request.getParameter("greetchg");
String vipchg=request.getParameter("vipchg")==null || request.getParameter("vipchg").equalsIgnoreCase("undefined") || request.getParameter("vipchg").equalsIgnoreCase("")?"0.0":request.getParameter("vipchg");
String boquechg=request.getParameter("boquechg")==null || request.getParameter("boquechg").equalsIgnoreCase("undefined") || request.getParameter("boquechg").equalsIgnoreCase("")?"0.0":request.getParameter("boquechg");
System.out.println(bookdocno+"::"+jobdocno+"::"+jobname+"::"+tarifdocno+"::"+tarifdetaildocno);

Connection conn=null;
int insertval=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();

	//Getting tarif details.
	int guestno=0;
	int pickuplocid=0,dropofflocid=0;
	double kmrestrict=0.0,tarif=0.0,exkmrate=0.0,extimerate=0.0,exhourrate=0.0,nighttarif=0.0,nightexhourrate=0.0,totalhours=0.0,
			transferextrahours=0.0,totalkm=0.0,extrakm=0.0,extrakmamt=0.0,extrahouramt=0.0,extranighthouramt=0.0,limoexcesshours=0.0,limoexcessdayhours=0.0,limoexcessnighthours=0.0,limonighttarifamt=0.0;
	String timerestrict="",nightstarttime="",nightendtime="",timeafteraddhours="",timeafteraddmins="",jobtype="";
	int blockhrs=0,nightstartmethod=0,nightendmethod=0;
	String strtarif="",strnighttarif="",strtotalhours="",strtransferaddhours="",strtransferaddmins="",strtransferextrahours="",strmaster="",strinsert="",
			strlimoaddhours="",limotimeafteraddhours="",strlimocheckexcesshrs="",strlimo="",strnightlimohours="";
	java.sql.Date sqlstartdate=null,sqlenddate=null;
	ArrayList<String> queryarray=new ArrayList<String>();
	jobtype=jobname.charAt(0)=='T'?"Transfer":"Limo";
	if(!startdate.equalsIgnoreCase("undefined") && !startdate.equalsIgnoreCase("")){
		sqlstartdate=objcommon.changetstmptoSqlDate(startdate);
	}
	if(!enddate.equalsIgnoreCase("undefined") && !enddate.equalsIgnoreCase("")){
		sqlenddate=objcommon.changetstmptoSqlDate(enddate);
	}
	strmaster="select guestno from gl_limobookm where status=3 and doc_no="+bookdocno;
	System.out.println("Master Query: "+strmaster);
	ResultSet rsmaster=stmt.executeQuery(strmaster);
	while(rsmaster.next()){
		guestno=rsmaster.getInt("guestno");
	}
	
	if(jobtype.equalsIgnoreCase("Transfer")){
		//Getting Pickup Location and Dropoff Location
		String strgetlocation="select pickuplocid pickuplocid,dropfflocid dropofflocid from gl_limobooktransfer where bookdocno="+bookdocno+" and doc_no="+jobdocno;
		ResultSet rslocation=stmt.executeQuery(strgetlocation);
		while(rslocation.next()){
			pickuplocid=rslocation.getInt("pickuplocid");
			dropofflocid=rslocation.getInt("dropofflocid");
		}
		//strtarif="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limotariftransfer where doc_no="+tarifdetaildocno;
		strtarif="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limotariftransfer where "+
		" gid="+tarifdetaildocno+" and tarifdocno="+tarifdocno+" and pickuplocid="+pickuplocid+" and dropofflocid="+dropofflocid;
		System.out.println(strtarif);
		
		
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		strtarif="select blockhrs,tarif,exhrrate,nighttarif,nightexhrrate from gl_limotarifhours where tarifdocno="+tarifdocno+" and gid="+tarifdetaildocno;
	}
	ResultSet rstarif=stmt.executeQuery(strtarif);
	while(rstarif.next()){
		if(jobtype.equalsIgnoreCase("Transfer")){
			kmrestrict=rstarif.getDouble("kmrestrict");
			timerestrict=rstarif.getString("timerestrict");
			tarif=rstarif.getDouble("tarif");
			exkmrate=rstarif.getDouble("exkmrate");
			extimerate=rstarif.getDouble("extimerate");
		}
		else if(jobtype.equalsIgnoreCase("Limo")){
			blockhrs=rstarif.getInt("blockhrs");
			tarif=rstarif.getDouble("tarif");
			exhourrate=rstarif.getDouble("exhrrate");
			nighttarif=rstarif.getDouble("nighttarif");
			nightexhourrate=rstarif.getDouble("nightexhrrate");
		}
	}

	//Getting Night start and end from gl_config

	strnighttarif="select (select method from gl_config where field_nme='nightendtime') nightendmethod,"+
		" (select description from gl_config where field_nme='nightendtime') nightendvalue,"+
		" (select method from gl_config where field_nme='nightstarttime') nightstartmethod,"+
		" (select description from gl_config where field_nme='nightstarttime')nightstartvalue";
	ResultSet rsnighttarif=stmt.executeQuery(strnighttarif);
	while(rsnighttarif.next()){
		nightstartmethod=rsnighttarif.getInt("nightstartmethod");
		nightstarttime=rsnighttarif.getString("nightstartvalue");
		nightendmethod=rsnighttarif.getInt("nightendmethod");
		nightendtime=rsnighttarif.getString("nightendvalue");
	}
	
	strtotalhours="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+starttime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 totalhours";
	ResultSet rstotalhours=stmt.executeQuery(strtotalhours);
	while(rstotalhours.next()){
		totalhours=rstotalhours.getDouble("totalhours");
	}
	
	if(jobtype.equalsIgnoreCase("Transfer")){
		
		//To subtract the time restrict;here we add the time restrict with the startdate and time
		
		strtransferaddhours="select DATE_FORMAT(TIMESTAMPADD(HOUR,"+timerestrict.split(":")[0]+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') timeafteraddhours";
		System.out.println(strtransferaddhours);
		ResultSet rstimeafteraddhours=stmt.executeQuery(strtransferaddhours);
		while(rstimeafteraddhours.next()){
			timeafteraddhours=rstimeafteraddhours.getString("timeafteraddhours");
		}
		
		strtransferaddmins="select DATE_FORMAT(TIMESTAMPADD(MINUTE,"+timerestrict.split(":")[1]+",concat('"+sqlstartdate+"',' ','"+timeafteraddhours+"')), '%H:%i') timeafteraddmins";
		System.out.println(strtransferaddmins);
		ResultSet rstimeafteraddmins=stmt.executeQuery(strtransferaddmins);
		while(rstimeafteraddmins.next()){
			timeafteraddmins=rstimeafteraddmins.getString("timeafteraddmins");
		}
		
		strtransferextrahours="select TIMESTAMPDIFF(MINUTE,concat('"+sqlstartdate+"',' ','"+timeafteraddmins+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 transferextrahours";
		System.out.println(strtransferextrahours);
		ResultSet rstransferextrahours=stmt.executeQuery(strtransferextrahours);
		while(rstransferextrahours.next()){
			transferextrahours=rstransferextrahours.getDouble("transferextrahours");
		}
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		
		//To subtract the time restrict,here we add the block hours whith the start date and time.
		
		strlimoaddhours="select DATE_FORMAT(TIMESTAMPADD(HOUR,"+blockhrs+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') limotimeafteraddhours";
		
		ResultSet rslimoafteraddhours=stmt.executeQuery(strlimoaddhours);
		while(rslimoafteraddhours.next()){
			limotimeafteraddhours=rslimoafteraddhours.getString("limotimeafteraddhours");
		}
		
		//Checking end time is less than time after adding block hours and therby finding excess hours.
		
		strlimocheckexcesshrs="select if(endtime<blocktime,0,timestampdiff(minute,blocktime,endtime)/60) limoexcesshrs from ("+
		" select timestamp(concat('"+sqlenddate+"',' ','"+endtime+"')) endtime,timestamp(concat('"+sqlstartdate+"',' ','"+limotimeafteraddhours+"')) blocktime)m";
		ResultSet rslimocheckblockhrs=stmt.executeQuery(strlimocheckexcesshrs);
		System.out.println("Total Limo Excess Hours Query: "+strlimocheckexcesshrs);
		while(rslimocheckblockhrs.next()){
			limoexcesshours=rslimocheckblockhrs.getDouble("limoexcesshrs");
		}
		//Getting Night Hours
		//1.Check End time is greater than night starttime then nighthours=endtime-nightstarttime
		//2.Check end time is greater than night nightendtime then nighthours=nightendtime-nightstarttime
		//3.Check end time is less than night starttime then nighthours=0;
		//4.Day hours=totalexcesshours-nighthours.
		if(sqlstartdate.compareTo(sqlenddate)==0){
			strnightlimohours="select case when (endtime>=nightstarttime and endtime<=nightendtime) then timestampdiff(minute,nightstarttime,endtime)/60"+
			" when (endtime>=nightstarttime and endtime>nightendtime) then timestampdiff(minute,nightstarttime,nightendtime)/60"+
			" when endtime<nightstarttime then 0 else 0 end nighthours from (select concat('"+sqlenddate+"',' ','"+endtime+"') endtime,"+
			" concat('"+sqlstartdate+"',' ','"+nightstarttime+"') nightstarttime,concat(date_add('"+sqlenddate+"',interval 1 day),' ','"+nightendtime+"') nightendtime)m";
		}
		else if(sqlstartdate.compareTo(sqlenddate)>0){
			strnightlimohours="select case when (endtime>=nightstarttime and endtime<=nightendtime) then timestampdiff(minute,nightstarttime,endtime)/60"+
			" when (endtime>=nightstarttime and endtime>nightendtime) then timestampdiff(minute,nightstarttime,nightendtime)/60"+
			" when endtime<nightstarttime then 0 else 0 end nighthours from (select concat('"+sqlenddate+"',' ','"+endtime+"') endtime,"+
			" concat('"+sqlstartdate+"',' ','"+nightstarttime+"') nightstarttime,concat('"+sqlenddate+"',' ','"+nightendtime+"') nightendtime)m";
		}
		else{
			System.out.println("else condition");

		}
			System.out.println("Night Checking"+strnightlimohours);
			ResultSet rsnightlimohours=stmt.executeQuery(strnightlimohours);
			while(rsnightlimohours.next()){
				limoexcessnighthours=rsnightlimohours.getDouble("nighthours");
			}	
			limoexcessnighthours=limoexcessnighthours<0?limoexcessnighthours*-1:limoexcessnighthours;
		
		limoexcessdayhours=limoexcesshours-limoexcessnighthours;
		
	}
	
	//Calculating Total kms and charges
	totalkm=Double.parseDouble(endkm)-Double.parseDouble(startkm);
	extrakm=totalkm-kmrestrict;
	if(extrakm>0){
		extrakmamt=extrakm*exkmrate;
	}
		
	//Calculating extra hour charge.
	if(jobtype.equalsIgnoreCase("Transfer")){
		if(transferextrahours>0){
			extrahouramt=transferextrahours*extimerate;
		}
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		if(limoexcessdayhours>0){
			extrahouramt=limoexcessdayhours*exhourrate;
		}
		if(limoexcessnighthours>0){
			extranighthouramt=limoexcessnighthours*nightexhourrate;
			limonighttarifamt=nighttarif;
		}
	}
	

	if(jobtype.equalsIgnoreCase("Transfer")){
		double tot=0.0;
		String strtot="select "+tarif+"+"+extrakmamt+"+"+extrahouramt+"+"+fuelchg+"+"+parkingchg+"+"+otherchg+"+"+greetchg+"+"+vipchg+"+"+boquechg+" total";
		ResultSet rstotal=stmt.executeQuery(strtot);
		while(rstotal.next()){
			tot=rstotal.getDouble("total");
		}
		System.out.println("Tot: "+tot);
		strinsert="insert into gl_limojobclosecalc(bookdocno,jobdocno,jobtype,jobname,guestno,total,tarif,exkmchg,exhrchg,fuelchg,parkingchg,otherchg,greetchg,vipchg,boquechg,status,startdate,starttime,startkm,closedate,closetime,closekm)values("+bookdocno+","+jobdocno+",'"+jobtype+"','"+jobname+"',"+guestno+","+tot+","+tarif+","+extrakmamt+","+extrahouramt+","+fuelchg+","+parkingchg+","+otherchg+","+greetchg+","+vipchg+","+boquechg+",3,'"+sqlstartdate+"','"+starttime+"',"+startkm+",'"+sqlenddate+"','"+endtime+"',"+endkm+")";
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		double tot=0.0;
		String strtot="select "+tarif+"+"+extrahouramt+"+"+extranighthouramt+"+"+limonighttarifamt+"+"+fuelchg+"+"+parkingchg+"+"+otherchg+"+"+greetchg+"+"+vipchg+"+"+boquechg+" total";
		ResultSet rstotal=stmt.executeQuery(strtot);
		while(rstotal.next()){
			tot=rstotal.getDouble("total");
		}
		strinsert="insert into gl_limojobclosecalc(bookdocno,jobdocno,jobtype,jobname,guestno,total,tarif,nighttarif,exhrchg,exnighthrchg,fuelchg,parkingchg,otherchg,greetchg,vipchg,boquechg,status,startdate,starttime,startkm,closedate,closetime,closekm)values("+bookdocno+","+jobdocno+",'"+jobtype+"','"+jobname+"',"+guestno+","+tot+","+tarif+","+limonighttarifamt+","+extrahouramt+","+extranighthouramt+","+fuelchg+","+parkingchg+","+otherchg+","+greetchg+","+vipchg+","+boquechg+",3,'"+sqlstartdate+"','"+starttime+"',"+startkm+",'"+sqlenddate+"','"+endtime+"',"+endkm+")";
		
	}
	conn.setAutoCommit(false);
	Statement stmtinsert=conn.createStatement();
	Statement stmtdelete=conn.createStatement();
	String strdelete="delete from gl_limojobclosecalc where bookdocno="+bookdocno+" and jobdocno="+jobdocno+" and jobtype='"+jobtype+"'";
	int deleteval=stmtdelete.executeUpdate(strdelete);
	insertval=stmtinsert.executeUpdate(strinsert);
	if(insertval>0){
		conn.commit();
	}
	response.getWriter().write(insertval+"");
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>