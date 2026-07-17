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
Connection conn=null;
try{
	System.out.println(bookdocno+":::"+jobdocno);
	java.sql.Date sqlstartdate=null,sqlenddate=null;
	double totalkm=Double.parseDouble(endkm)-Double.parseDouble(startkm);
	double kmrestrict=0.0,tarif=0.0,exkmrate=0.0,extimerate=0.0;
	double blockhrs=0.0,exhrrate=0.0,nighttarif=0.0,nightexhrrate=0.0;
	double excesskm=0.0,excesskmchg=0.0;
	double exhrchg=0.0,exnighthrchg=0.0;
	String timerestrict="";
	String strtarifdetails="";
	int nightstartmethod=0,nightendmethod=0;
	String nightstarttime="",nightendtime="";
	int restricthours=0;
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	//Converting String Dates to Sql
	if(!startdate.equalsIgnoreCase("")){
		sqlstartdate=objcommon.changetstmptoSqlDate(startdate);
	}
	if(!enddate.equalsIgnoreCase("")){
		sqlenddate=objcommon.changetstmptoSqlDate(enddate);
	}
	
	//Getting first char of jobname.ie; Deciding Job is Transfer/Limo
	char jobtype=jobname.charAt(0);
	if(jobtype=='T'){
		strtarifdetails="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limotariftransfer where doc_no="+tarifdetaildocno;
	}
	else if(jobtype=='L'){
		strtarifdetails="select blockhrs,tarif,exhrrate,nighttarif,nightexhrrate from gl_limotarifhours where doc_no="+tarifdetaildocno;
	}
	if(!strtarifdetails.equalsIgnoreCase("")){
		ResultSet rstarifdetails=stmt.executeQuery(strtarifdetails);
		while(rstarifdetails.next()){
			if(jobtype=='T'){
				kmrestrict=rstarifdetails.getDouble("kmrestrict");
				timerestrict=rstarifdetails.getString("timerestrict");
				tarif=rstarifdetails.getDouble("tarif");
				exkmrate=rstarifdetails.getDouble("exkmrate");
				extimerate=rstarifdetails.getDouble("extimerate");
			}
			else if(jobtype=='L'){
				blockhrs=rstarifdetails.getDouble("blockhrs");
				tarif=rstarifdetails.getDouble("tarif");
				exhrrate=rstarifdetails.getDouble("exhrrate");
				nighttarif=rstarifdetails.getDouble("nighttarif");
				nightexhrrate=rstarifdetails.getDouble("nightexhrrate");
			}
		}
	}
	
	//Getting Night Tarif Hours from gl_config
	
	String strnight="select (select method from gl_config where field_nme='nightendtime') nightendmethod,"+
	" (select description from gl_config where field_nme='nightendtime') nightendvalue,"+
	" (select method from gl_config where field_nme='nightstarttime') nightstartmethod,"+
	" (select description from gl_config where field_nme='nightstarttime')nightstartvalue";
	ResultSet rs=stmt.executeQuery(strnight);
	while(rs.next()){
		nightstartmethod=rs.getInt("nightstartmethod");
		nightstarttime=rs.getString("nightstartvalue");
		nightendmethod=rs.getInt("nightendmethod");
		nightendtime=rs.getString("nightendvalue");
	}
	
	double totaldiffhours=0.0;
	double nightdiffhours=0,daydiffhours=0,extrahours=0,nighthours=0;
	String remaintime="";
	String strremaintime="";
	//Getting Total Difference
	String strtotaldiff="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+starttime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 totalhours";
	ResultSet rstotaldiff=stmt.executeQuery(strtotaldiff);
	while(rstotaldiff.next()){
		totaldiffhours=rstotaldiff.getInt("totalhours");//Total Hours before hour limit
	}
	double extrahourstransfer=0.0;
	double extratotalhours=0;//Difference after subtracting hour limit;
	double nighttotalhours=0;//Total difference between nightstarttime and nightendtime;
	double daynightstarthours=0;//Difference between starttime(after hour limit) and nightstarttime;
	double nightenddiffhours=0;//Difference between nightendtime and endtime;
	double extradayhours=0;
	double extranighthours=0;

	if(jobtype=='T'){
		strremaintime="select DATE_FORMAT(TIMESTAMPADD(HOUR,"+timerestrict.split(":")[0]+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') remaintime";
		ResultSet rsremaintimehour=stmt.executeQuery(strremaintime);
		while(rsremaintimehour.next()){
			remaintime=rsremaintimehour.getString("remaintime");//Time after subtracting hour limit
		}
		strremaintime="select DATE_FORMAT(TIMESTAMPADD(MINUTE,"+timerestrict.split(":")[1]+",concat('"+sqlstartdate+"',' ','"+remaintime+"')), '%H:%i') remaintime";
		ResultSet rsremaintimemins=stmt.executeQuery(strremaintime);
		while(rsremaintimemins.next()){
			remaintime=rsremaintimemins.getString("remaintime");//Time after subtracting minute limit
		}
		String strextrahrstransfer="select TIMESTAMPDIFF(MINUTE,concat('"+sqlstartdate+"',' ','"+remaintime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 extrahourstransfer";
		ResultSet rsextrahrstransfer=stmt.executeQuery(strextrahrstransfer);
		while(rsextrahrstransfer.next()){
			extrahourstransfer=rsextrahrstransfer.getDouble("extrahourstransfer");
		}
		
	}
	else if(jobtype=='L'){
		strremaintime="select DATE_FORMAT(TIMESTAMPADD(HOUR,"+blockhrs+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') remaintime";
		ResultSet rsremain=stmt.executeQuery(strremaintime);
		while(rsremain.next()){
			remaintime=rsremain.getString("remaintime");
		}
		int nightonlystatus=0;
		String strnightonly="select case when (remaintime between nightstart and nightend) and (endtime between nightstart and nightend) then"+
		" timestampdiff(minute,remaintime,endtime)/60 end nighthours from (select timestamp(concat('"+sqlstartdate+"',' ','"+remaintime+"')) remaintime,"+
		" timestamp(concat('"+sqlstartdate+"',' ','"+nightstarttime+"')) nightstart,timestamp(concat(if(timestamp(concat('"+sqlenddate+"',' ','"+nightendtime+"')) between "+
		" timestamp(concat('"+sqlenddate+"',' ','00:00')) and timestamp(concat('"+sqlenddate+"',' ','12:00')) and '"+sqlstartdate+"'='"+sqlenddate+"',"+
		" date_add('"+sqlenddate+"',interval 1 day),'"+sqlenddate+"'),' ','"+nightendtime+"')) nightend,timestamp(concat('"+sqlenddate+"',' ','"+endtime+"')) endtime)aa";
		System.out.println(strnightonly);
		ResultSet rsnightonly=stmt.executeQuery(strnightonly);
		while(rsnightonly.next()){
			nightonlystatus=1;
			extranighthours=rsnightonly.getDouble("nighthours");
		}
		if(nightonlystatus!=1){
		String strtotalremaintime="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+remaintime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 extratotalhours";
		ResultSet rstotalremaintime=stmt.executeQuery(strtotalremaintime);
		while(rstotalremaintime.next()){
			extratotalhours=rstotalremaintime.getDouble("extratotalhours");
		}
		String strdaynightstart="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+remaintime+"'),concat('"+sqlstartdate+"',' ','"+nightstarttime+"'))/60 daynightstarthours";
		ResultSet rsdaynightstart=stmt.executeQuery(strdaynightstart);
		while(rsdaynightstart.next()){
			daynightstarthours=rsdaynightstart.getDouble("daynightstarthours");
		}
		
		String strtotalnight="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+nightstarttime+"'),concat('"+sqlenddate+"',' ','"+nightendtime+"'))/60 nighttotalhours";
		ResultSet rstotalnight=stmt.executeQuery(strtotalnight);
		while(rstotalnight.next()){
			nighttotalhours=rstotalnight.getDouble("nighttotalhours");
		}
		String strnightend="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+nightendtime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 nightenddiffhours";
		ResultSet rsnightend=stmt.executeQuery(strnightend);
		while(rsnightend.next()){
			nightenddiffhours=rsnightend.getDouble("nightenddiffhours");
		}
				String strextraused="select if("+extratotalhours+"<="+daynightstarthours+","+extratotalhours+","+daynightstarthours+") dayhoursused,"+
				" if("+nighttotalhours+"<="+nightenddiffhours+","+nightenddiffhours+","+nighttotalhours+") nighthoursused,"+
				" timestampdiff(minute,concat('"+sqlenddate+"',' ','"+nightendtime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 nightdaydiff";
				System.out.println(strextraused);
				ResultSet rsextraused=stmt.executeQuery(strextraused);
				while(rsextraused.next()){
					extradayhours=rsextraused.getInt("dayhoursused");
					extranighthours=rsextraused.getInt("nighthoursused");
				}
	}
	}
	double extradayhourcharge=0.0;
	double extranighthourcharge=0.0;
	double extradayhourrate=0.0;
	double extranighthourrate=0.0;
	double nighttarifamt=0.0;
	if(jobtype=='T'){
		extradayhourcharge=extrahourstransfer*extimerate;
		excesskm=totalkm-kmrestrict;
		excesskmchg=excesskm*exkmrate;
	}
	else if(jobtype=='L'){
		extradayhourcharge=extradayhours*exhrrate;
		extranighthourcharge=extranighthours*nightexhrrate;
		if(extranighthours>0){
			nighttarifamt=nighttarif;
		}
	}
	//System.out.println("Extra Night Hours: "+extranighthours);
	conn.setAutoCommit(false);
	int deleteval=stmt.executeUpdate("delete from gl_limojobclosecalc where jobdocno="+jobdocno+" and bookdocno="+bookdocno+" and calcstatus=0 and jobtype='"+jobtype+"'");
	String strgetidno="select idno from gl_invmode where limo=1";
	ResultSet rsgetidno=stmt.executeQuery(strgetidno);
	ArrayList<String> idnoarray=new ArrayList<String>();
	while(rsgetidno.next()){
		idnoarray.add(rsgetidno.getString("idno"));
	}
	ArrayList<String> calcarray=new ArrayList<String>();
	for(int i=0;i<idnoarray.size();i++){
		if(tarif>0 && idnoarray.get(i).equalsIgnoreCase("1")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+tarif+","+tarif+",1,0,'"+jobtype+"')");
		}
		else if(nighttarifamt>0 && idnoarray.get(i).equalsIgnoreCase("22")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+nighttarifamt+","+nighttarifamt+",1,0,'"+jobtype+"')");
		}
		else if(Double.parseDouble(fuelchg)>0 && idnoarray.get(i).equalsIgnoreCase("11")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+fuelchg+","+fuelchg+",1,0,'"+jobtype+"')");
		}
		else if(Double.parseDouble(parkingchg)>0 && idnoarray.get(i).equalsIgnoreCase("24")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+parkingchg+","+parkingchg+",1,0,'"+jobtype+"')");
		}
		else if(Double.parseDouble(otherchg)>0 && idnoarray.get(i).equalsIgnoreCase("12")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+otherchg+","+otherchg+",1,0,'"+jobtype+"')");
		}
		else if(Double.parseDouble(greetchg)>0 && idnoarray.get(i).equalsIgnoreCase("25")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+greetchg+","+greetchg+",1,0,'"+jobtype+"')");
		}
		else if(Double.parseDouble(vipchg)>0 && idnoarray.get(i).equalsIgnoreCase("26")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+vipchg+","+vipchg+",1,0,'"+jobtype+"')");
		}
		else if(Double.parseDouble(boquechg)>0 && idnoarray.get(i).equalsIgnoreCase("27")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+",1,"+boquechg+","+boquechg+",1,0,'"+jobtype+"')");
		}
		else if(excesskmchg>0 && idnoarray.get(i).equalsIgnoreCase("4")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+","+excesskm+","+exkmrate+","+excesskmchg+",1,0,'"+jobtype+"')");
		}
		else if(extradayhourcharge>0 && idnoarray.get(i).equalsIgnoreCase("5")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+","+(jobtype=='T'?extrahourstransfer:extradayhours)+""+","+(jobtype=='T'?extimerate:exhrchg)+""+","+exhrchg+",1,0,'"+jobtype+"')");
		}
		else if(extranighthourcharge>0 && idnoarray.get(i).equalsIgnoreCase("23")){
			calcarray.add("insert into gl_limojobclosecalc(jobdocno,bookdocno,idno,qty,rate,amount,status,calcstatus,jobtype)values("+jobdocno+","+bookdocno+","+idnoarray.get(i)+","+extranighthours+","+nightexhrrate+","+extranighthourcharge+",1,0,'"+jobtype+"')");
		}
	}
	
	int status=-1;
	for(int i=0;i<calcarray.size();i++){
		//System.out.println(calcarray.get(i));
		int val=stmt.executeUpdate(calcarray.get(i));
		if(val<0){
			status=0;
			break;
		}
	}
	if(status!=0){
		conn.commit();
		status=1;
	}
	//System.out.println("final Status: "+status);
	response.getWriter().write(status+"");
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>