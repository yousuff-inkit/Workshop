<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
Connection conn = null;
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();

	/* System.out.println("Here in check delivery.jsp");
System.out.println(request.getParameter("delstatus")+"::"+request.getParameter("agmtno")+"::"+request.getParameter("collectkm")+"::"+request.getParameter("inkm")+"::"+request.getParameter("indate")+"::"+request.getParameter("infuel")); */

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
java.sql.Date date1=null,date2=null;
java.sql.Date collectdate=null;
int delcheck=-1;
int delcheckstatus=0;
Statement stmt=conn.createStatement();
String	strdelcheck="select delstatus from gl_ragmt where delivery=1 and doc_no="+agmtno;
ResultSet rsdelcheck=stmt.executeQuery(strdelcheck);
if(rsdelcheck.next()){
	delcheck=rsdelcheck.getInt("delstatus");
	delstatus=rsdelcheck.getInt("delstatus");
}
if(delcheck==0){
	delcheckstatus=1;
}
stmt.close();
String tempcollectdate=request.getParameter("collectdate").trim();
/* System.out.println("Temp Collectdate Length:"+tempcollectdate.length());
System.out.println("Collectdate Temp:"+tempcollectdate+"::::::"); */
if(tempcollectdate.length()>4){
	System.out.println("Inside Check Parsing");
	if(!(tempcollectdate==null)){
	collectdate=objcommon.changeStringtoSqlDate(tempcollectdate);
	}
}

	 stmt = conn.createStatement();
	int delcal=0;
	double tfuel=0.0,tkm=0.0;
	double km1=0.0,km2=0.0;
	double finalkm=0.0,finalfuel=0.0;
	double delkm=0.0,delfuel=0.0,outkm=0.0,outfuel=0.0;
	java.sql.Date deldate=null,outdate=null;
	String	deltime="",outtime="",time1="",time2="";
	String sqltest="";	
	 String strSql = "select method from gl_config where field_nme='delcal'";
	ResultSet resultSet = stmt.executeQuery(strSql);
	while(resultSet.next()){
		delcal=resultSet.getInt("method");
		
	}
	if(delcal==1){
		sqltest=" and trancode!='DL' and repno=0";
	}
	String sqlsum="select sum(coalesce(tkm,0)) tkm,sum(coalesce(tfuel,0)) tfuel from gl_vmove where rdtype='RAG' and rdocno="+agmtno+""+sqltest;
	//System.out.println("Sum Query"+sqlsum);
	ResultSet rssum=stmt.executeQuery(sqlsum);
	while(rssum.next()){
		tkm=rssum.getDouble("tkm");
		tfuel=rssum.getDouble("tfuel");
	}
	
	String strout="select dout,tout,kmout,fout from gl_vmove where rdtype='RAG' and rdocno="+agmtno+" and status='OUT'";
	ResultSet rsout=stmt.executeQuery(strout);
	while(rsout.next()){
		outkm=rsout.getDouble("kmout");
		outfuel=rsout.getDouble("fout");
	}
	//System.out.println("KM Check: Inkm:"+inkm+" Outkm:"+outkm);
	if(inkm<outkm){
		//System.out.println("Inside Km Check If");
		response.getWriter().write("1");
	}
	if(delcal==1){
		finalkm=(inkm-outkm)+tkm;
		finalfuel=(infuel-outfuel)+tfuel;
	}
	else{
		finalkm=(collectkm-outkm)+tkm;
		finalfuel=(collectfuel-outfuel)+tfuel;
		
	}
	//System.out.println("Inkm:"+inkm+"Outkm:"+outkm+"Tkm:"+tkm+"FinalKM:"+finalkm+"Total:"+((inkm-outkm)+tkm));
	
	
	/* km fuel ends */
	
	
	
	/** date and time 	**/
	String stragmtsql="select odate,otime from gl_ragmt where doc_no="+agmtno;
	ResultSet rsagmt=stmt.executeQuery(stragmtsql);
	while(rsagmt.next()){
		outdate=rsagmt.getDate("odate");
		outtime=rsagmt.getString("otime");
	}
	
	//if(delcal==0){
		if(delstatus==1){
	String strmovsql="select din,tin from gl_vmove where rdtype='RAG' and rdocno="+agmtno+" and trancode='DL'";
	ResultSet rsmov=stmt.executeQuery(strmovsql);
	while(rsmov.next()){
		deldate=rsmov.getDate("din");
		deltime=rsmov.getString("tin");
	}
		}
	//}

	
	/** delivery - collectoin date or out- in date calculation STARTS
	*/
	if(deldate!=null && delcal==0){
	//Delivery Date And Time
	date1=deldate;
	time1=deltime;
		}
		else{
	//Agreement Date And Time
	date1=outdate;
	time1=outtime;
		}
		if(collectdate!=null && delcal==0){
	// collection date and time
	date2=collectdate;
	time2=collecttime;
		}
		else{
	// in date and time
	date2=indate;
	time2=intime;
		}
		
		/** delivery - collectoin date or out- in date calculation  ENDS
		*/
		
		
		/**  date VALIDATION calculation STARTS
		*/
		java.sql.Date date1valid=null,date2valid=null;
		String time1valid="",time2valid="";
		if(deldate!=null){
		//Delivery Date And Time
		date1valid=deldate;
		time1valid=deltime;
			}
			else{
		//Agreement Date And Time
		date1valid=outdate;
		time1valid=outtime;
			}
			if(collectdate!=null){
		// collection date and time
		date2valid=collectdate;
		time2valid=collecttime;
			}
			else{
		// in date and time
		date2valid=indate;
		time2valid=intime;
			}
			
			/** date VALIDATION calculation  ENDS
			*/
			
		System.out.println("Out Date:"+outdate);
		System.out.println("Del Date:"+deldate);
		System.out.println("In Date:"+indate);
		System.out.println("Collect Date:"+collectdate);
	java.sql.Date invtmpdate=null,invtmptodate=null;
		String strinv="select invdate,invtodate,advchk from gl_ragmt where doc_no="+agmtno+"";
	ResultSet rsinv=stmt.executeQuery(strinv);
	int advchk=0;
	while(rsinv.next()){
		if(rsinv.getDate("invdate")!=null){
			invtmpdate=rsinv.getDate("invdate");
			invtmptodate=rsinv.getDate("invtodate");
			advchk=rsinv.getInt("advchk");
		}
	
	}
	
	long diff=date2.getTime()-date1.getTime();
	long datediff = diff / (24 * 60 * 60 * 1000);
	System.out.println("Date Difference:"+datediff);
	System.out.println("Time Check>>>Time2:"+time2+"    Time1:"+time1);
	String datediff2=datediff+"";
	String tformat[]=time1.split(":");
	String tformat2[]=time2.split(":");
	int t1hour=Integer.parseInt(tformat[0]);
	int t2hour=Integer.parseInt(tformat2[0]);
	int t1min=Integer.parseInt(tformat[1]);
	int t2min=Integer.parseInt(tformat2[1]);
	int finaltime=(t2hour-t1hour)-1;

	if((t2min-t1min)<0){
			
	}
	else{
		finaltime=finaltime+1;
	}

	
	if(finaltime<0){
		finaltime=0;
	}
	if(finalkm<0){
		finalkm=0;
	}
	System.out.println("Time Difference:"+finaltime);
	int kmstatus=0;
	int datestatus=0;
	int timestatus=0;
	int invstatus=0;
	int collectkmstatus=0;
	if(inkm<outkm){
		kmstatus=1;
	}
	if(hidchkcollection==1){
		if(inkm<collectkm){
			collectkmstatus=1;
			System.out.println("Inkm:"+inkm+"  CollectKM:"+collectkm);
		}
		
	}
	System.out.println("Date1:"+date1+"-------"+"Date2:"+date2);
	 if(date2.compareTo(date1)<0){
		// System.out.println("date2.compareTo(date1):"+date2.compareTo(date1));
		datestatus=1;
	} 
	 if(date2.compareTo(date1)==0){
		 if(t2hour<t1hour){
			 timestatus=1;
		 }
		 if(t2hour==t1hour){
			 if(t2min<t1min){
				 timestatus=1;
			 }
		 }
	 }
	 //System.out.println("Date check1:"+date2.compareTo(invtmpdate));
	 //System.out.println("Date check2:"+invtmpdate.compareTo(date2));
	 System.out.println(invtmpdate+"::"+date2);
	 int invtostatus=0;
	//if(advchk==0){
	 if(invtmpdate!=null){
	if(invtmpdate.compareTo(date2)>0){
		
		invstatus=1;
	}
	 }
	 if(invtmptodate!=null){
		 if(temprentaltype.equalsIgnoreCase("monthly")){
		 System.out.println("Close Date:"+date2+"     InvToDate:"+invtmptodate);
		 System.out.println(date2.compareTo(invtmptodate));
		 if(date2.compareTo(invtmptodate)>0){
			 invtostatus=1;
		 }
		 }
	 }
	stmt.close();
	conn.close();
System.out.println("Check Collection:"+hidchkcollection);
	System.out.println("Inkm:"+inkm+" Out Km:"+outkm+" Totalkm:"+finalkm); 
	response.getWriter().write(datediff2+"***"+finaltime+"***"+finalkm+"***"+finalfuel+"***"+outkm+"***"+kmstatus+"***"+datestatus+"***"+timestatus+"***"+date1+"***"+invstatus+"***"+invtmpdate+"***"+collectkmstatus+"***"+delcheckstatus+"***"+invtostatus+"***"+date2);

}
catch(Exception e1){
	e1.printStackTrace();
	conn.close();
}
%>