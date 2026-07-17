<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%

ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn = null;
try{
	conn=objconn.getMyConnection();
	/* Date1 => Out Date/Delivery Date
	Date2 => In Date/Collect Date
	Same applies to time,km,fuel
	*/
int delstatus=0;

String agmtno=request.getParameter("agmtno")==""||request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");

double collectkm=Double.parseDouble(request.getParameter("collectkm")==""||request.getParameter("collectkm")==null?"0":request.getParameter("collectkm"));

double inkm=Double.parseDouble(request.getParameter("inkm")==""||request.getParameter("inkm")==null?"0":request.getParameter("inkm"));

java.sql.Date indate=null;
if(!(request.getParameter("indate").trim()==null)){
	indate=objcommon.changeStringtoSqlDate(request.getParameter("indate"));
}
String temprentaltype=request.getParameter("rentaltype");
int hidchkcollection=Integer.parseInt(request.getParameter("hidchkcollection").trim());
double infuel=Double.parseDouble(request.getParameter("infuel"));
double collectfuel=Double.parseDouble(request.getParameter("collectfuel")==""||request.getParameter("collectfuel")==null?"0":request.getParameter("collectfuel"));
String intime=request.getParameter("intime");
String collecttime=request.getParameter("collecttime");
java.sql.Date date1=null,date2=null;
java.sql.Date collectdate=null;
String tempcollectdate=request.getParameter("collectdate").trim();
if(tempcollectdate.length()>4){
	System.out.println("Inside Check Parsing");
	collectdate=objcommon.changeStringtoSqlDate(tempcollectdate);
}
int delcheck=-1;
int delcheckstatus=0;
Statement stmt=conn.createStatement();
String	strdelcheck="select delstatus from gl_lagmt where delivery=1 and doc_no="+agmtno;
ResultSet rsdelcheck=stmt.executeQuery(strdelcheck);
if(rsdelcheck.next()){
	delcheck=rsdelcheck.getInt("delstatus");
	delstatus=rsdelcheck.getInt("delstatus");
}
if(delcheck==0){
 	delcheckstatus=1;
}
stmt.close();
	 stmt = conn.createStatement ();
	int temp=0;//For checking Collection is done or not
	int delcal=0;
	double tfuel=0.0,tkm=0.0;
	double km1=0.0,km2=0.0;
	double fuel1=0.0,fuel2=0.0;
	double finalkm=0.0,finalfuel=0.0;
	double delkm=0.0,delfuel=0.0,outkm=0.0,outfuel=0.0;
	java.sql.Date deldate=null,outdate=null,invdate=null,closeinvdate=null;
	String	deltime="",outtime="",time1="",time2="";
	String sqltest="";	
	int closecal=0;
	 String strSql = "select (select method from gl_config where field_nme='delcal') delcal,(select method from gl_config where field_nme='closecal') closecal,"+
					"(select invdate from gl_lagmt where doc_no="+agmtno+") invdate";
	ResultSet resultSet = stmt.executeQuery(strSql);
	while(resultSet.next()){
		delcal=resultSet.getInt("delcal");
		closecal=resultSet.getInt("closecal");
		invdate=resultSet.getDate("invdate");
	}
	
	
	// Get Agreement OutDate,Time,Km,Fuel
	
	String stragmtsql="select outdate,outtime,outkm,outfuel from gl_lagmt where doc_no="+agmtno;
	ResultSet rsagmt=stmt.executeQuery(stragmtsql);
	while(rsagmt.next()){
		outdate=rsagmt.getDate("outdate");
		outtime=rsagmt.getString("outtime");
		outkm=rsagmt.getDouble("outkm");
		outfuel=rsagmt.getDouble("outfuel");
	}
	

	if(delstatus==1){

	String strmovsql="select mov.din,mov.tin,mov.kmin,mov.fin from gl_vmove mov left join gl_lagmt agmt "+
			" on (mov.rdocno=agmt.doc_no and mov.rdtype='LAG') where mov.rdtype='LAG' and mov.rdocno="+agmtno+" and mov.trancode='DL' and mov.repno=0";
	ResultSet rsmov=stmt.executeQuery(strmovsql);
	while(rsmov.next()){
		deldate=rsmov.getDate("din");
		deltime=rsmov.getString("tin");
		delkm=rsmov.getDouble("kmin");
		delfuel=rsmov.getDouble("fin");
	}
		}
	/** (delivery - collectoin) date or (out- in) date calculation STARTS 	*/
			
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
					temp=1;
			}
			else{
					// in date and time
					date2=indate;
					time2=intime;
					km2=inkm;
					fuel2=infuel;
			}
		
	/** (delivery - collection) date or (out- in) date calculation  ENDS */
	
	
			
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
					
					/** date VALIDATION calculation  ENDS
					*/
	
					

					System.out.println("Date1 valid:"+date1valid+" Date2valid :"+date2valid+"   Km1valid: "+km1valid+"::::Km2valid: "+km2valid+"   TIME1valid: "+time1valid+"::::time2valid: "+time2valid);
					System.out.println("Date1 :"+date1+" Date2 :"+date2+"   Km1: "+km1+"::::Km2: "+km2);
			
					
					/** Getting Total Km and fuel of corresponding Agreement*/			
	if(delcal==1){
		sqltest=" and trancode!='DL' and repno=0";
	}
	String sqlsum="select sum(coalesce(tkm,0)) tkm,sum(coalesce(tfuel,0)) tfuel from gl_vmove where rdtype='LAG' and rdocno="+agmtno+""+sqltest;
	System.out.println("Sum Query"+sqlsum);
	ResultSet rssum=stmt.executeQuery(sqlsum);
	while(rssum.next()){
		tkm=rssum.getDouble("tkm");
		tfuel=rssum.getDouble("tfuel");
	}

	finalkm=(km2-km1)+tkm;
	finalfuel=(fuel2-fuel1)+tfuel;
	
	/* km fuel ends */
	
	
	Statement stmtmonthcal=conn.createStatement();
	String strmonthcal="select if(method=1,day(last_day('"+date1+"')),value) monthcalvalue from gl_config where field_nme='lesmonthlycal'";
	int monthcalvalue=0;
	ResultSet rsmonthcalvalue=stmtmonthcal.executeQuery(strmonthcal);
	while(rsmonthcalvalue.next()){
		monthcalvalue=rsmonthcalvalue.getInt("monthcalvalue");
	}
	stmtmonthcal.close();
	
	/** date and time 	**/
	
	//System.out.println("Date2:"+date2+" date1:"+date1);
	long diff=date2.getTime()-date1.getTime();
	long datediff = diff / (24 * 60 * 60 * 1000);
	
	
	String tformat[]=time1.split(":");
	String tformat2[]=time2.split(":");
	int t1hour=Integer.parseInt(tformat[0]);
	int t2hour=Integer.parseInt(tformat2[0]);
	int t1min=Integer.parseInt(tformat[1]);
	int t2min=Integer.parseInt(tformat2[1]);
	int finaltime=(t2hour-t1hour)-1;
	int finalmin=0;
	if((t2min-t1min)<0 ){
		if(t2min>t1min){
			//finaltime=(((finaltime*60)+((t2min-t1min)*-1))/60);
		
			finalmin=(t2min-t1min)*-1;
		}
		else if(t2min<=t1min){
			
			finalmin=(60-t1min)+t2min;
		}
	}
	else{
		finaltime=finaltime+1;
		finalmin=t2min-t1min;
		//System.out.println("Minute check: "+(t2min-t1min)/60);
		//System.out.println("Calculated Final Time: "+finaltime);
	}

	
	if(finaltime<0){
		finaltime=0;
	}
	if(finalkm<0){
		finalkm=0;
	}
	
	String finaltime1=finaltime+"."+(finalmin<10?"0"+finalmin:finalmin)+"";
	System.out.println("Time Difference:"+finaltime);
	int kmstatus=0;
	int datestatus=0;
	int timestatus=0;
	int invstatus=0;
	int invtostatus=0;
	int collectkmstatus=0;
	int outdatestatus=0;
	int outtimestatus=0;
	
	
	if(outdate==null){
		outdatestatus=1;
	}
	if(outtime.equalsIgnoreCase("")){
		outtimestatus=1;
	}//Km Validation
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
 
 
	 
	 java.sql.Date invtmpdate=null,invtmptodate=null;
		String strinv="select invdate,invtodate,adv_chk from gl_lagmt where doc_no="+agmtno+"";
	ResultSet rsinv=stmt.executeQuery(strinv);
	int advchk=0;
	while(rsinv.next()){
		if(rsinv.getDate("invdate")!=null){
		//	System.out.println("InvTempDate:"+rsinv.getDate("invdate"));
		invtmpdate=rsinv.getDate("invdate");
		invtmptodate=rsinv.getDate("invtodate");
		advchk=rsinv.getInt("adv_chk");
		}
		}
	
	 if(invtmpdate.compareTo(date2)>0){
			
			invstatus=1;
		}
	 
	 if(invtmptodate!=null){
		// System.out.println("Close Date:"+date2+"     InvToDate:"+invtmptodate);
		 //System.out.println(date2.compareTo(invtmptodate));
		 if(date2.compareTo(invtmptodate)>0){
			 invtostatus=1;
		 }
	 }
	 
	 
	 
	 int closecalflag=0;
		
	

			/* if(temprentaltype.equalsIgnoreCase("daily") && date1.compareTo(invtmpdate)>0){
				closecalflag=1;
			}
			if(temprentaltype.equalsIgnoreCase("weekly") && datediff<7){
				closecalflag=1;
			}
			else if(temprentaltype.equalsIgnoreCase("monthly") && datediff<monthcalvalue){
				closecalflag=1;
			} */
			
			if(closecal==1){
				closeinvdate=invdate;
				diff=date2.getTime()-closeinvdate.getTime();
				datediff=diff/(24*60*60*1000);
			}
		
		int firstinvstatus=0;
		if(invtmpdate.compareTo(date1)==0){
			firstinvstatus=1;
		}
		String datediff2=datediff+"";
		int latest=0;
		
		Statement stmtlatest=conn.createStatement();
		String strlatest="select  cast(concat('"+date2+"',' ','"+time2+"') as datetime) <"+
				  " cast(concat(dout,' ',tout)as datetime) latest from gl_vmove where rdocno="+agmtno+" and rdtype='LAG' and status='OUT'";
		ResultSet rslatest=stmtlatest.executeQuery(strlatest);
		while(rslatest.next()){
			latest=rslatest.getInt("latest");
		}
		
	stmt.close(); 
	conn.close();
	
	
	response.getWriter().write(datediff2+"***"+finaltime1+"***"+finalkm+"***"+finalfuel+"***"+outkm+"***"+kmstatus+"***"+datestatus+"***"+timestatus+"***"+date1+"***"+invstatus+"***"+invtmpdate+"***"+collectkmstatus+"***"+outdatestatus+"***"+outtimestatus+"***"+delcheckstatus+"***"+invtostatus+"***"+date2+"***"+closecalflag+"***"+closeinvdate+"***"+firstinvstatus+"***"+latest);

}
catch(Exception e1){
	e1.printStackTrace();
	conn.close();
}



%>