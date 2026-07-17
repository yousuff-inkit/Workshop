<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
Connection conn = null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	conn=objconn.getMyConnection();
	String datediff2="",finaltime1="";
	double finalkm=0.0,finalfuel=0.0;
	double tfuel=0.0,tkm=0.0;
	double km1=0.0,km2=0.0;
	double fuel1=0.0,fuel2=0.0;
	int kmstatus=0;
	int datestatus=0;
	int timestatus=0;
	int invstatus=0;
	int invtype=0;
	int collectkmstatus=0;
	java.sql.Date date1=null,date2=null;
	java.sql.Date collectdate=null;
	int delcheck=-1;
	int delcheckstatus=0;
	java.sql.Date invtmpdate=null,invtmptodate=null;	
	int invtostatus=0;	
	double delkm=0.0,delfuel=0.0,outkm=0.0,outfuel=0.0;
	int closecalflag=0;
	int delcal=0;
	java.sql.Date deldate=null,outdate=null,invdate=null,closeinvdate=null;
	String	deltime="",outtime="",time1="",time2="";
	String sqltest="";	
	int latest=0;
	int firstinvstatus=0;	
	int closecal=0;

	/* 	
		Date1 => Out Date/Delivery Date
		Date2 => In Date/Collect Date
		Same applies to time,km,fuel
	*/
	
	int delstatus=0;
	String agmtno=request.getParameter("agmtno")==""||request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
	double collectkm=Double.parseDouble(request.getParameter("collectkm")==""||request.getParameter("collectkm")==null?"0":request.getParameter("collectkm"));
	double inkm=Double.parseDouble(request.getParameter("inkm")==""||request.getParameter("inkm")==null?"0":request.getParameter("inkm"));
	int hidchkcollection=Integer.parseInt((request.getParameter("hidchkcollection").trim()));
	java.sql.Date indate=null;
	
	/* System.out.println("Indate:"+request.getParameter("indate")+"Collectdate:"+request.getParameter("collectdate")); */
	
	if(!(request.getParameter("indate").trim()==null)){
		indate=objcommon.changeStringtoSqlDate(request.getParameter("indate"));
	}
	
	String temprentaltype=request.getParameter("rentaltype");
	double infuel=Double.parseDouble(request.getParameter("infuel"));
	double collectfuel=Double.parseDouble(request.getParameter("collectfuel")==""||request.getParameter("collectfuel")==null?"0":request.getParameter("collectfuel"));
	String intime=request.getParameter("intime");
	String collecttime=request.getParameter("collecttime");
				
	Statement stmt=conn.createStatement();
	String	strdelcheck="select delstatus,delivery from gl_ragmt where doc_no="+agmtno;
	ResultSet rsdelcheck=stmt.executeQuery(strdelcheck);
	if(rsdelcheck.next()){
		if(rsdelcheck.getInt("delivery")==1){
			delcheck=rsdelcheck.getInt("delstatus");
			delstatus=rsdelcheck.getInt("delstatus");
		}
		else if(rsdelcheck.getInt("delivery")==0){
			delcheck=1;
		}
	}
	if(delcheck==0){
		delcheckstatus=1;
	}
	stmt.close();
	if(delcheck==1){
		String tempcollectdate=request.getParameter("collectdate").trim();
		/* System.out.println("Temp Collectdate Length:"+tempcollectdate.length());
		System.out.println("Collectdate Temp:"+tempcollectdate+"::::::"); */
		if(tempcollectdate.length()>4){
			//System.out.println("Inside Check Parsing");
			if(!(tempcollectdate==null)){
				collectdate=objcommon.changeStringtoSqlDate(tempcollectdate);
			}
		}
		stmt = conn.createStatement();
		String strSql = "select (select method from gl_config where field_nme='delcal') delcal,(select method from gl_config where field_nme='closecal') closecal,"+
							" (select invdate from gl_ragmt where doc_no="+agmtno+") invdate";
		ResultSet resultSet = stmt.executeQuery(strSql);
		while(resultSet.next()){
			delcal=resultSet.getInt("delcal");
			closecal=resultSet.getInt("closecal");
			invdate=resultSet.getDate("invdate");
		}
			
	/**get out date and time 	**/
		String stragmtsql="select odate,otime,okm,ofuel from gl_ragmt where doc_no="+agmtno;
		ResultSet rsagmt=stmt.executeQuery(stragmtsql);
		while(rsagmt.next()){
			outdate=rsagmt.getDate("odate");
			outtime=rsagmt.getString("otime");
			outkm=rsagmt.getDouble("okm");
			outfuel=rsagmt.getDouble("ofuel");
		}
	
		if(delstatus==1){
			String strmovsql="select mov.din,mov.tin,mov.kmin,mov.fin from gl_vmove mov left join gl_ragmt agmt "+
						" on (mov.rdocno=agmt.doc_no and mov.rdtype='RAG') where mov.rdtype='RAG' and mov.rdocno="+agmtno+" and mov.trancode='DL' and mov.repno=0";
			ResultSet rsmov=stmt.executeQuery(strmovsql);
			while(rsmov.next()){
				deldate=rsmov.getDate("din");
				deltime=rsmov.getString("tin");
				delkm=rsmov.getDouble("kmin");
				delfuel=rsmov.getDouble("fin");
			}
		}
	
	/** (delivery - collectoin) date or (out- in) date calculation STARTS 	*/
			//System.out.println(outdate+"***"+outtime+"***"+outkm+"***"+outfuel+"***"+deldate+"***"+deltime+"***"+delkm+"***"+delfuel);
		if(deldate!=null && delcal==0){
			//Delivery Date And Time
			date1=deldate;
			time1=deltime;
			km1=delkm;
			fuel1=delfuel;
		}
		else{
			//Agreement Date And Time
			date1=outdate;
			time1=outtime;
			km1=outkm;
			fuel1=outfuel;
			}
				
		if(collectdate!=null && delcal==0){
			// collection date and time
			date2=collectdate;
			time2=collecttime;
			km2=collectkm;
			fuel2=collectfuel;
		}
		else{
			// in date and time
			date2=indate;
			time2=intime;
			km2=inkm;
			fuel2=infuel;
			}
			
		
		/** (delivery - collection) date or (out- in) date calculation  ENDS */
		
		//System.out.println(date1+"###"+date2);
		
		/**  date VALIDATION calculation STARTS 	*/
	
		java.sql.Date date1valid=null, date2valid=null;
		String time1valid="", time2valid="";
		double km1valid=0.0, km2valid=0.0, fuel1valid=0.0, fuel2valid=0.0;
			
			
		if(deldate!=null){
			//Delivery Date And Time
			date1valid=deldate;
			time1valid=deltime;
			km1valid=delkm;
			fuel1valid=delfuel;
		}
		else{
			//Agreement Date And Time
			date1valid=outdate;
			time1valid=outtime;
			km1valid=outkm;
			fuel1valid=outfuel;
		}
		if(collectdate!=null){
			// collection date and time
			date2valid=collectdate;
			time2valid=collecttime;
			km2valid=collectkm;
			fuel2valid=collectfuel;
		}
		else{
			// in date and time
			date2valid=indate;
			time2valid=intime;
			km2valid=inkm;
			fuel2valid=infuel;
		}
			
		//Getting the last Vehicle Details
		Statement stmtvalid=conn.createStatement();
		String strvalid="select dout,tout,kmout,fout from gl_vmove where rdocno="+agmtno+" and rdtype='RAG' and status='OUT'";
		ResultSet rsvalid=stmtvalid.executeQuery(strvalid);
		while(rsvalid.next()){
			date1valid=rsvalid.getDate("dout");
			time1valid=rsvalid.getString("tout");
			km1valid=rsvalid.getDouble("kmout");
			fuel1valid=rsvalid.getDouble("fout");
		}
		stmtvalid.close();
			
			
		/** date VALIDATION calculation  ENDS*/
			
		//System.out.println("Date1 valid:"+date1valid+" Date2valid :"+date2valid+"   Km1valid: "+km1valid+"::::Km2valid: "+km2valid);
		//System.out.println("Date1 :"+date1+" Date2 :"+date2+"   Km1: "+km1+"::::Km2: "+km2);
	
	
		/** Getting Total Km and fuel of corresponding Agreement*/		
	
		if(delcal==0){
			sqltest=" and trancode!='DL' and repno=0";
		}
		String sqlsum="select sum(coalesce(tkm,0)) tkm,sum(coalesce(tfuel,0)) tfuel from gl_vmove where rdtype='RAG' and rdocno="+agmtno+""+sqltest;
		//System.out.println("sqlsum:"+sqlsum);
		ResultSet rssum=stmt.executeQuery(sqlsum);
		while(rssum.next()){
			tkm=rssum.getDouble("tkm");
			tfuel=rssum.getDouble("tfuel");
		}
			
		//finalkm=(km2-km1)+tkm;
		//finalfuel=(fuel2-fuel1)+tfuel;
		//System.out.println(km2+"::::"+km1valid+":::::"+tkm);
		finalkm=(km2-km1valid)+tkm;
		finalfuel=(fuel2-fuel1valid)+tfuel;
		/*** km fuel ends */
	
	
	
		//System.out.println("Out Date:"+outdate);
		//	System.out.println("Del Date:"+deldate);
		//System.out.println("In Date:"+indate);
		//System.out.println("Collect Date:"+collectdate);


		/* Statement stmtupload=conn.createStatement();
		
		String strupload="select if("+closecal+"=1,invdate,odate) fromdate from gl_ragmt where doc_no="+agmtno;
		ResultSet rsupload=stmtupload.executeQuery(strupload);
		if(rsupload.next()){
			date1=rsupload.getDate("fromdate");
		}
		stmtupload.close(); */
		
		//Method for getting monthlycal from gl_config
		Statement stmtmonthcal=conn.createStatement();
		String strmonthcal="select if(method=1,day(last_day('"+date1+"')),value) monthcalvalue from gl_config where field_nme='monthlycal'";
		int monthcalvalue=0;
		ResultSet rsmonthcalvalue=stmtmonthcal.executeQuery(strmonthcal);
		while(rsmonthcalvalue.next()){
			monthcalvalue=rsmonthcalvalue.getInt("monthcalvalue");
		}
		stmtmonthcal.close();
		
		
		
		//Total Days,Hours Calculation Starts here	
		long diff=date2.getTime()-date1.getTime();
		long datediff = diff / (24 * 60 * 60 * 1000);
			
			
			
		String tformat[]=time1.split(":");
		String tformat2[]=time2.split(":");
		int t1hour=Integer.parseInt(tformat[0]);
		int t2hour=Integer.parseInt(tformat2[0]);
		int t1min=Integer.parseInt(tformat[1]);
		int t2min=Integer.parseInt(tformat2[1]);
		int finaltime=(t2hour-t1hour);
		int finalmin=0;
			/* || finaltime<0 */ 
						
		if(finaltime<=0 && t2min-t1min<=0){
			finaltime1="0";
			//System.out.println("Both Hr and min is less");
		}
		else if((t2min-t1min)<0){
			if(t2min>t1min){
				//finaltime=(((finaltime*60)+((t2min-t1min)*-1))/60);
				
				finalmin=(t2min-t1min)*-1;
			}
			else if(t2min<=t1min && finaltime>0){
				//System.out.println("Hr is greater");
				finaltime=(t2hour-t1hour)-1;
				finalmin=(60-t1min)+t2min;
					
			}
			else{
					//System.out.println("Hr is less");
				finalmin=t2min-t1min;
			}
		}
		else{
			//System.out.println("Else");
			finaltime=finaltime;
			finalmin=t2min-t1min;
			//System.out.println("Minute check: "+(t2min-t1min)/60);
			//System.out.println("Calculated Final Time: "+finaltime);
		}
		
			
		if(finaltime<0){
				//System.out.println("Time Difference:"+finaltime);
			finaltime=0;
				
		}
		
		//Overriding totalkm-on 04/10/2016
		String sqldelcal="";
		if(delcal==1){
			sqldelcal=" and trancode<>'DL'";
		}
		else{
			sqldelcal="";
		}
		String strtotalkm="select (select sum(kmin-kmout) from gl_vmove where rdocno="+agmtno+" and rdtype='RAG'"+sqldelcal+") movtotalkm,"+
		" (select kmout from gl_vmove where rdocno="+agmtno+" and rdtype='RAG'  and status='OUT') movoutkm";
		double movtotalkm=0.0;
		double movoutkm=0.0;
		double currentinkm=0.0;
		ResultSet rsmovkm=stmt.executeQuery(strtotalkm);
		while(rsmovkm.next()){
			movtotalkm=rsmovkm.getDouble("movtotalkm");
			movoutkm=rsmovkm.getDouble("movoutkm");
			currentinkm=km2;
		}
		finalkm=movtotalkm+(currentinkm-movoutkm);
		if(finalkm<0){
			finalkm=0;
		}
		finaltime1=finaltime+"."+(finalmin<10?"0"+finalmin:finalmin)+"";
			//System.out.println("Time Difference:===================="+finaltime1);
			/* Statement stmttemp=conn.createStatement();
			ResultSet rstemp=stmttemp.executeQuery("select round("+finaltime+",2) finaltime");
			while(rstemp.next()){
				finaltime=rstemp.getInt("finaltime");
			}
			stmttemp.close(); */
	
	//Total Days,Hours Calculation Ends here
	
	//Validation Block Starts here
	
	
	//Km Validation
		if(km2valid<km1valid){
			kmstatus=1;
		}
		if(hidchkcollection==1){
			if(inkm<collectkm){
				collectkmstatus=1;
				//System.out.println("Inkm:"+inkm+"  CollectKM:"+collectkm);
			}
			
		}
	//Km Validation ends
	
	
	//Date and Time Validation
		if(date2valid.compareTo(date1valid)<0){
			// System.out.println("date2.compareTo(date1):"+date2.compareTo(date1));
			datestatus=1;
		} 
		 //System.out.println("Date check1:"+date2.compareTo(invtmpdate));
		 //System.out.println("Date check2:"+invtmpdate.compareTo(date2));
		if(date2valid.compareTo(date1valid)==0){
			String tformatvalid[]=time1valid.split(":");
			String tformat2valid[]=time2valid.split(":");
			int t1hourvalid=Integer.parseInt(tformatvalid[0]);
			int t2hourvalid=Integer.parseInt(tformat2valid[0]);
			int t1minvalid=Integer.parseInt(tformatvalid[1]);
			int t2minvalid=Integer.parseInt(tformat2valid[1]);	
							 
			if(t2hourvalid<t1hourvalid){
				timestatus=1;
			}
			if(t2hourvalid==t1hourvalid){
				if(t2minvalid<t1minvalid){
					timestatus=1;
				}
			}
		}

	//Date and time validation ends
	 
	 
	
	//Invoice VAlidation Starts Here
	
	
		
		String strinv="select invdate,invtodate,advchk,invtype from gl_ragmt where doc_no="+agmtno+"";
		ResultSet rsinv=stmt.executeQuery(strinv);
		int advchk=0;
		while(rsinv.next()){
			if(rsinv.getDate("invdate")!=null){
				invtmpdate=rsinv.getDate("invdate");
				invtmptodate=rsinv.getDate("invtodate");
				advchk=rsinv.getInt("advchk");
				invtype=rsinv.getInt("invtype");
			}
		
		}
		//System.out.println(invtmpdate+"::"+date2);
		//Validation for Invoices done
	
		 
		
		if(invtmpdate!=null){
			if(invtmpdate.compareTo(date2)>0){
				
				invstatus=1;
			}
		 }
		//Validation for Invoices done ends here
	 	//Validation For Pending Invoices
	 
		if(invtmptodate!=null){
			if(temprentaltype.equalsIgnoreCase("monthly")){
			System.out.println("Close Date:"+date2+"     InvToDate:"+invtmptodate);
			System.out.println(date2.compareTo(invtmptodate));
			if(date2.compareTo(invtmptodate)>0){
				invtostatus=1;
			}
		}
	}
	if(invtype==3){
		invtostatus=0;
	}
	//Validation for Pending Invoices Ends
	 
	//Invoice Validation Ends Here	
		 
	/** no invoice is generated if invtmpdate and date1 is same */
		 
	//Checking how many invoices done corresponding to agreement.Specially uses for checking agmt is advance and done only one;
			
	String stradvinv="select count(*) advinvcount from gl_invm where rano="+agmtno+" and ratype='RAG' and manual=2";
	int advinvcount=0;
	ResultSet rsadvinv=stmt.executeQuery(stradvinv);
	while(rsadvinv.next()){
		advinvcount=rsadvinv.getInt("advinvcount");
	}

	if(invtmpdate.compareTo(date1)==0){
		firstinvstatus=1;
	}
		
	if(closecal==1){
		if(firstinvstatus==1){
			closecalflag=1;
			closeinvdate=invdate;
			// convertion
			System.out.println("Inside Convertion 1");
		}
		else if(advchk==1 && advinvcount==1){
			closecalflag=0;
			java.sql.Date tempdate=null;//In case of no creditnote;
			
			if(deldate!=null && delcal==0){
				tempdate=deldate;
			}
			else{
				tempdate=outdate;
			}
			long nocreditdiff=0;
			long nocreditdatediff=0;
			int startdays=0;
  			if(deldate!=null && delcal==0){

				nocreditdiff=date2.getTime()-deldate.getTime();
				nocreditdatediff=nocreditdiff/(24*60*60*1000);
				ResultSet rs2=stmt.executeQuery("select day(last_day('"+deldate+"')) startdays");
				while(rs2.next()){
					startdays=rs2.getInt("startdays");	
				}
			}
			else{
				nocreditdiff=date2.getTime()-outdate.getTime();
				nocreditdatediff=nocreditdiff/(24*60*60*1000);
				ResultSet rs=stmt.executeQuery("select day(last_day('"+outdate+"')) startdays");
				while(rs.next()){
					startdays=rs.getInt("startdays");	
				}
				
			}
  		
  		
  		System.out.println("Checking:"+nocreditdatediff+"////"+startdays);
			if(nocreditdatediff<startdays && advchk==1 && advinvcount==1){
				System.out.println("Inside no credit");
				datediff=0;
				closeinvdate=invdate;
				finaltime1="0.0";
			} 
			else{
				closeinvdate=invdate;
				System.out.println(date2+"::"+closeinvdate);
				diff=date2.getTime()-closeinvdate.getTime();
				datediff=diff/(24*60*60*1000);
			}
			
	
//Not Applicable after 24-05-2016-->  Allows to convert when the first invoice is advance and closing before the first invoice period ends.(Only invoice is advance and only one is done)
		}
		else{
			closecalflag=0;
			closeinvdate=invdate;
			diff=date2.getTime()-closeinvdate.getTime();
			closecalflag=0;
			datediff=diff/(24*60*60*1000);
			System.out.println("Else part Convertion -1");
			// no convertion  and the total days( i.e. datediff) for which invoice need to be generated
		}
				
	}
			
			
			
	datediff2=datediff+"";
	System.out.println("JSP Final Datediff"+datediff2);
	Statement stmtlatest=conn.createStatement();
	String strlatest="select  cast(concat('"+date2+"',' ','"+time2+"') as datetime) <"+
		" cast(concat(dout,' ',tout)as datetime) latest from gl_vmove where rdocno="+agmtno+" and rdtype='RAG' and status='OUT'";
	ResultSet rslatest=stmtlatest.executeQuery(strlatest);
	while(rslatest.next()){
		latest=rslatest.getInt("latest");
	}
			
	stmtlatest.close();
				
	}
				
	
	int weekend=0;
	String strweek="select weekend from gl_ragmt where doc_no="+agmtno+"";
	Statement stmtweek=conn.createStatement();
	ResultSet rsweek=stmtweek.executeQuery(strweek);
	if(rsweek.next()){
		weekend=rsweek.getInt("weekend");
	}
	if(weekend==1){
		String strendtime="select ed_time endtime from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
		String endtime="";
		ResultSet rsendtime=stmtweek.executeQuery(strendtime);
		while(rsendtime.next()){
			endtime=rsendtime.getString("endtime");
		}
		String closetimearray[]=time2.split(":");
		String endtimearray[]=endtime.split(":");
		int closehour=Integer.parseInt(closetimearray[0]);
		int closemin=Integer.parseInt(closetimearray[1]);
		int endhour=Integer.parseInt(endtimearray[0]);
		int endmin=Integer.parseInt(endtimearray[1]);	
		int finaltime=(closehour-endhour);
		int finalmin=0;
		if(finaltime<=0 && closemin-endmin<=0){
			finaltime1="0";
			//System.out.println("Both Hr and min is less");
		}
		else if((closemin-endmin)<0){
			if(closemin>endmin){
				//finaltime=(((finaltime*60)+((t2min-t1min)*-1))/60);
			
				finalmin=(closemin-endmin)*-1;
			}
			else if(closemin<=endmin && finaltime>0){
				//System.out.println("Hr is greater");
				finaltime=(closehour-endhour)-1;
				finalmin=(60-endhour)+closemin;
				
			}
			else{
				//System.out.println("Hr is less");
				finalmin=closemin-endmin;
			}
		}
		else{
			//System.out.println("Else");
			
			finalmin=closemin-endmin;
			//System.out.println("Minute check: "+(t2min-t1min)/60);
			//System.out.println("Calculated Final Time: "+finaltime);
		}
		
		if(finaltime<0){
			//System.out.println("Time Difference:"+finaltime);
			finaltime=0;
			
		}
		finaltime1=finaltime+"."+(finalmin<10?"0"+finalmin:finalmin)+"";
		
		
		
	}
	 
	//System.out.println("Date2: "+date2+"     Date1: "+date1+"        Difference: "+datediff);
	stmt.close();
	conn.close();
	//System.out.println("Close Inv Date: "+closeinvdate);

	//System.out.println(datediff2+"***"+finaltime1+"***"+finalkm+"***"+finalfuel+"***"+outkm+"***"+kmstatus+"***"+datestatus+"***"+timestatus+"***"+date1+"***"+invstatus+"***"+invtmpdate+"***"+collectkmstatus+"***"+delcheckstatus+"***"+invtostatus+"***"+date2+"***"+closecalflag+"***"+closeinvdate+"***"+firstinvstatus+"***"+latest); 
	response.getWriter().write(datediff2+"***"+finaltime1+"***"+finalkm+"***"+finalfuel+"***"+outkm+"***"+kmstatus+"***"+datestatus+"***"+timestatus+"***"+date1+"***"+invstatus+"***"+invtmpdate+"***"+collectkmstatus+"***"+delcheckstatus+"***"+invtostatus+"***"+date2+"***"+closecalflag+"***"+closeinvdate+"***"+firstinvstatus+"***"+latest+"***"+fuel2);

}
catch(Exception e1){
	e1.printStackTrace();
	conn.close();
}
%>