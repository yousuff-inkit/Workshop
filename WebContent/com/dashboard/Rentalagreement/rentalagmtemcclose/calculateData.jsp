<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%
String indate=request.getParameter("indate")==null?"":request.getParameter("indate");
String intime=request.getParameter("intime")==null?"":request.getParameter("intime");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String strinkm=request.getParameter("inkm")==null?"":request.getParameter("inkm");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
String usedhours="";
double inkm=0.0;
int datestatus=0,timestatus=0,kmstatus=0;
double days=0.0,totalrate=0.0,courtesyamount=0.0;
double salikamt=0.0,trafficamt=0.0,saliksrvc=0.0,trafficsrvc=0.0,salikcount=0.0,trafficcount=0.0,salikrate=0.0,trafficrate=0.0;
ArrayList saliktrafficarray=new ArrayList();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqlindate=null,sqloutdate=null;
	if(!indate.equalsIgnoreCase("") && indate!=null){
		sqlindate=objcommon.changeStringtoSqlDate(indate);
	}
	if(!strinkm.equalsIgnoreCase("")){
		inkm=Double.parseDouble(strinkm);
	}
	String outtime="";
	double emcrate=0.0;
	double emccourtesydays=0.0;
	int cldocno=0;
	double outkm=0.0;
	String stragmtdata="select odate,otime,okm,emcrate,emccourtesydays,cldocno from gl_ragmt where doc_no="+agmtno;
	ResultSet rsagmtdata=stmt.executeQuery(stragmtdata);
	while(rsagmtdata.next()){
		sqloutdate=rsagmtdata.getDate("odate");
		outtime=rsagmtdata.getString("otime");
		outkm=rsagmtdata.getDouble("okm");
		emcrate=rsagmtdata.getDouble("emcrate");
		emccourtesydays=rsagmtdata.getDouble("emccourtesydays");
		cldocno=rsagmtdata.getInt("cldocno");
	}
	long diff=sqlindate.getTime()-sqloutdate.getTime();
	long datediff=diff/(24*60*60*1000);
	String finaltime1="";
	String tformat[]=outtime.split(":");
	String tformat2[]=intime.split(":");
	int t1hour=Integer.parseInt(tformat[0]);
	int t2hour=Integer.parseInt(tformat2[0]);
	int t1min=Integer.parseInt(tformat[1]);
	int t2min=Integer.parseInt(tformat2[1]);
	int finaltime=(t2hour-t1hour);
	int finalmin=0;
	if(finaltime<=0 && t2min-t1min<=0){
		finaltime1="0";
		//System.out.println("Both Hr and min is less");
	}
	else if((t2min-t1min)<0){
		if(t2min>t1min){
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
		finaltime=finaltime;
		finalmin=t2min-t1min;
	}
	usedhours=finaltime+"."+(finalmin<10?"0"+finalmin:finalmin)+"";
	double hours=Double.parseDouble(usedhours);
	String strconfig="select (case when "+hours+"<=(select value from gl_config where field_nme='gp') then 'nothing' when "+hours+" <(select value from gl_config"+
	" where field_nme='gph') then 'hourly' when "+hours+"<(select value from gl_config where field_nme='gpd') then 'halfday'"+
	" else 'fullday' end )calc,value from gl_config where field_nme='gp'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	String calctype="";
	double freehours=0.0;
	while(rsconfig.next()){
		calctype=rsconfig.getString("calc");
		freehours=rsconfig.getDouble("value");
	}
	
	
	String strrough="select (select method from gl_config where field_nme='gp')gpmethod,(select value from gl_config where field_nme='gp')gpvalue,"+
			"(select method from gl_config where field_nme='gph')gphmethod,(select value from gl_config where field_nme='gph')gphvalue,"+
			"(select method from gl_config where field_nme='gpd')gpdmethod,(select value from gl_config where field_nme='gpd')gpdvalue";
	ResultSet rsrough=stmt.executeQuery(strrough);
	int gpmethod=0,gphmethod=0,gpdmethod=0;
	double gpvalue=0.0,gphvalue=0.0,gpdvalue=0.0;
	while(rsrough.next()){
		gpmethod=rsrough.getInt("gpmethod");
		gpvalue=rsrough.getDouble("gpvalue");
		gphmethod=rsrough.getInt("gphmethod");
		gphvalue=rsrough.getDouble("gphvalue");
		gpdmethod=rsrough.getInt("gpdmethod");
		gpdvalue=rsrough.getDouble("gpdvalue");
	}
	calctype="";
	
	if(gpdmethod==1 && gpdvalue<=hours){
		calctype="fullday";
	}
	if((gphmethod==1 && gphvalue<=hours) && ((gpdmethod==1 &&  gpdvalue>hours) || (gpdmethod==0)) ){
		calctype="halfday";
	}
	if((gpmethod==1 && gpvalue<=hours) && ((gphmethod==1 && gphvalue>hours) || (gphmethod==0))  && ((gpdmethod==1 &&  gpdvalue>hours) || (gpdmethod==0))){
		calctype="hourly";
	}
							
	//Rough Checking for hour charge ends here

	double cal=0.0;
	double finalhours=0.0;
	double hrchg=0.0;
	//hours=Math.round(hours);

	String temptime[]=usedhours.replace(".",":").split(":");
	int temphours=Integer.parseInt(temptime[0]);
	int tempminutes=Integer.parseInt(temptime[1]);
	if(calctype.equalsIgnoreCase("hourly")){

		if(tempminutes>0){
			temphours=temphours+1;
		}
		finalhours=temphours-freehours;
		cal=0;
	}
	if(calctype.equalsIgnoreCase("halfday")){
		//System.out.println("Calctype"+calctype);
		cal=0.5;
	}
	if(calctype.equalsIgnoreCase("fullday")){
		cal=1;
	}
	System.out.println("Diff: "+diff);
	days=Double.parseDouble(datediff+"");
	days=days+cal;
	totalrate=days*emcrate;
	if(days>=emccourtesydays){
		courtesyamount=emcrate*emccourtesydays;	
	}
	else{
		courtesyamount=emcrate*days;
	}
	
	
	
	//Getting Salik Amount
	
	saliktrafficarray=objcommon.getSalik(sqloutdate, sqlindate, cldocno+"", agmtno, "RAG");
	
	salikamt=Double.parseDouble(saliktrafficarray.get(0)+"");
	trafficamt=Double.parseDouble(saliktrafficarray.get(1)+"");
	saliksrvc=Double.parseDouble(saliktrafficarray.get(2)+"");
	trafficsrvc=Double.parseDouble(saliktrafficarray.get(3)+"");
	salikcount=Double.parseDouble(saliktrafficarray.get(4)+"");
	trafficcount=Double.parseDouble(saliktrafficarray.get(5)+"");

	//Date Validation
	if(sqlindate.compareTo(sqloutdate)<0){
		datestatus=1;
	} 
	
	//Time Validation
	if(sqlindate.compareTo(sqloutdate)==0){
		String tformatvalid[]=outtime.split(":");
		String tformat2valid[]=intime.split(":");
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
	
	//Km Validation
	
	if(inkm<outkm){
		kmstatus=1;
	}
	System.out.println(usedhours+"::"+days+"::"+totalrate+"::"+courtesyamount+"::"+salikamt+"::"+trafficamt+"::"+saliksrvc+"::"+trafficsrvc+"::"+salikcount+"::"+trafficcount);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(usedhours+"::"+days+"::"+totalrate+"::"+courtesyamount+"::"+salikamt+"::"+trafficamt+"::"+saliksrvc+"::"+trafficsrvc+"::"+salikcount+"::"+trafficcount+"::"+datestatus+"::"+timestatus+"::"+kmstatus);
%>