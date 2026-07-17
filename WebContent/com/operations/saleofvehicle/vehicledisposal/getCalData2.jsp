<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	//Notations used in calculation
	/* 
	Sales Price 	-salesprice
	Dep Posted		-deprdate
	Purchase Value	-purcost
	Acc.Dep			-sumassetamt
	Current Dep		-days
	Net P(L)		-netamt */
	
	
 	conn=objconn.getMyConnection();
	String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
	double salesprice=Double.parseDouble(request.getParameter("salesprice")==null?"0":request.getParameter("salesprice"));
	

	Statement stmtfleet=conn.createStatement();
	java.sql.Date deprdate=null,docdate=null;
	if(!(date.equalsIgnoreCase(""))){
		docdate=objcommon.changeStringtoSqlDate(date);
	}
	
	
	double purcost=0.0;
	String strfleet="select depr_date from gl_vehmaster where fleet_no="+fleet;
	ResultSet rsfleet=stmtfleet.executeQuery(strfleet);
	if(rsfleet.next()){
		deprdate=rsfleet.getDate("depr_date");
		//purcost=rsfleet.getDouble("tval");
	}
	
	Statement stmtpurch=conn.createStatement();
	String strpurch="select coalesce(sum(dramount),0) purchasevalue from gc_assettran asset left join my_account ac on (asset.acno=ac.acno and ac.codeno='VEH') where ac.codeno='VEH' and fleet_no="+fleet;
	ResultSet rspurch=stmtpurch.executeQuery(strpurch);
	while(rspurch.next()){
		purcost=rspurch.getDouble("purchasevalue");
		}
	stmtpurch.close();
	
	double sumassetamt=0.0;
	Statement stmtaccdepr=conn.createStatement();
	String straccdepr="select coalesce(sum(dramount),0) accdeprvalue from gc_assettran asset left join my_account ac on (asset.acno=ac.acno and ac.codeno='VAD') where ac.codeno='VAD' and fleet_no="+fleet;
	Statement stmtasset=conn.createStatement();
	ResultSet rsaccdepr=stmtaccdepr.executeQuery(straccdepr);
	while(rsaccdepr.next()){
	sumassetamt=rsaccdepr.getDouble("accdeprvalue");
	}
	/* String strasset="select (select sum(dramount) from gc_assettran where fleet_no="+fleet+") sumamount,datediff('"+docdate+"','"+deprdate+"') daysdiff"; */
	String strasset="select datediff('"+docdate+"','"+deprdate+"') datediff,round((("+purcost+" * "+sumassetamt+"/100)/365)*(select datediff) ,2) currentdepr";
	
	Statement stmt=conn.createStatement();
	String strcheckcurdepr="select sum(dramount) amt from gc_assettran asset left join my_account ac on asset.acno=ac.acno where fleet_no="+fleet;
	ResultSet rscheck=stmt.executeQuery(strcheckcurdepr);
	double checkcuramt=0.0;
	while(rscheck.next()){
		checkcuramt=rscheck.getDouble("amt");
	}
	System.out.println("Current Depr Query: "+strasset);
	double currentdepr=0.0;
	
	ResultSet rsasset=stmtasset.executeQuery(strasset);
	if(rsasset.next()){
		//sumassetamt=rsasset.getDouble("sumamount");
		currentdepr=rsasset.getDouble("currentdepr");
	}
	if(checkcuramt<=currentdepr){
		currentdepr=checkcuramt;
	}
if(checkcuramt==0){
currentdepr=0;
}
	//System.out.println(purcost+"::::"+sumassetamt+":::::"+currentdepr);
	double netbook=purcost+sumassetamt-currentdepr;
	
	double netamt=salesprice-netbook;
	
	stmtasset.close();
	stmtfleet.close();
	conn.close();
	
	response.getWriter().write(deprdate+"::"+purcost+"::"+sumassetamt+"::"+currentdepr+"::"+netamt+"::"+netbook);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
  %>