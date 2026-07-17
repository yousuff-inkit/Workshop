<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
String month=request.getParameter("month")==null?"":request.getParameter("month");
String year=request.getParameter("year")==null?"":request.getParameter("year");
JSONArray griddata=new JSONArray();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqlselect="",sqljoin="",sqltotalclockin="";
	if(month.length()==1){
		month="0"+month;
	}
	
	//Getting Total Available Hours in gl_config
	String stravailconfig="select value from gl_config where field_nme='floorTechProcess'";
	ResultSet rsavailconfig=stmt.executeQuery(stravailconfig);
	int totalavailhrs=0;
	while(rsavailconfig.next()){
		totalavailhrs=rsavailconfig.getInt("value");
	}
	for(int i=0,j=1;i<31;i++,j++){
		String day="";
		if((j+"").length()==1){
			day="0"+j;
		}
		else{
			day=j+"";	
		}
		String curdate=""+year+"-"+month+"-"+day;
		sqljoin+=" left join (select technicianid techdocno,sum(timestampdiff(minute,concat(startdate,' ',starttime),concat(closedate,' ',closetime))) timediff from ws_clockin where date='"+curdate+"' group by technicianid) day"+j+" on tech.doc_no=day"+j+".techdocno";
		sqlselect+=" ,round(coalesce(day"+j+".timediff/60,0),2) day"+j+"";
		if(i==0){
			sqltotalclockin+="round(coalesce(day"+j+".timediff/60,0),2)";
		}
		else{
			sqltotalclockin+="+round(coalesce(day"+j+".timediff/60,0),2)";
		}
	}
	
/* 	select base2.*,round(case when base2.idlehrs>0 then (base2.totalavailhrs/base2.idlehrs)*100 else 0 end,2) idlepercent,round(case when base2.othrs>0 then (base2.totalavailhrs/base2.idlehrs)*100 else 0 end,2) idlepercent from (select base.*,base.totalavailhrs,round(base.totalavailhrs-base.totalclockin,2) idlehrs,case when base.totalclockin>base.totalavailhrs then base.totalclockin-base.totalavailhrs else 0 end othrs from (
	,round(coalesce(ftech.estmins,0)/60,2) esttotalhrs,"+totalavailhrs+" totalavailhrs
 */	
	String strsql="select *, availhrs totalavailhrs, if(availhrs-totalclockin>0, availhrs-totalclockin, 0)idlehrs, if(totalclockin-availhrs>0, totalclockin-availhrs, 0)othrs,"+
	"round((if(availhrs-totalclockin>0, availhrs-totalclockin, 0)/availhrs)*100,2)idlehrsperc, round((if(totalclockin-availhrs>0, totalclockin-availhrs, 0)/availhrs)*100,2)othrsperc from ("+
	" select tech.name techname"+sqlselect+","+sqltotalclockin+" totalclockin,(9*avl.totaldays)availhrs from ws_technician tech "+sqljoin+" "+
	" left join (select techdocno,sum(estmins) estmins from ws_floortech where status=3 and month(date)="+month+" and year(date)="+year+" group by techdocno) ftech on tech.doc_no=ftech.techdocno "+
	" left join (select technicianid,count(distinct startdate)totaldays from ws_clockin where month(startdate)="+month+" and year(startdate)="+year+" group by technicianid) avl on tech.doc_no=avl.technicianid"+
	" where tech.status<>7)a";
	
	//) base";
	ResultSet rs=stmt.executeQuery(strsql);
	griddata=objcommon.convertToJSON(rs);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(griddata+"");
%>