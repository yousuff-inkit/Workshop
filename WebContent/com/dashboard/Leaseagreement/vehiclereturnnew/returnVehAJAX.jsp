<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String calcstrarray=request.getParameter("calcarray")==null?"":request.getParameter("calcarray");
String returndate=request.getParameter("returndate")==null?"":request.getParameter("returndate");
String returnremarks=request.getParameter("returnremarks")==null?"":request.getParameter("returnremarks");
String stockvehiclestatus=request.getParameter("stockvehiclestatus")==null?"":request.getParameter("stockvehiclestatus");
ArrayList<String> calcarray=new ArrayList<String>();
if(!calcstrarray.equalsIgnoreCase("")){
	String temp[]=calcstrarray.split(",");
	for(int i=0;i<temp.length;i++){
		calcarray.add(temp[i]);
	}	
}
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	double currate=0.0;
	String userid=session.getAttribute("USERID").toString();
	String curid=session.getAttribute("CURRENCYID").toString();
	java.sql.Date sqlreturndate=null;
	if(!returndate.equalsIgnoreCase("") && returndate!=null){
		sqlreturndate=objcommon.changeStringtoSqlDate(returndate);
	}
	String strcurrate="select c_rate currate from my_curr where doc_no="+curid;
	ResultSet rscurrate=stmt.executeQuery(strcurrate);
	while(rscurrate.next()){
		currate=rscurrate.getDouble("currate");
	}
	int maxtrno=0,maxdocno=0;
	//Inserting to my_trno
/* 	String strtrnoinsert="insert into my_trno(USERNO, TRTYPE, brhId, edate, transid)values("+userid+",'BLVR',"+branch+",now(),0)";
	System.out.println("trno: "+strtrnoinsert);
	int trnoinsert=stmt.executeUpdate(strtrnoinsert);
	if(trnoinsert<=0){
		errorstatus=1;
	}
	else{
		ResultSet rsmaxtrno=stmt.executeQuery("select max(trno) maxtrno from my_trno");
		while(rsmaxtrno.next()){
			maxtrno=rsmaxtrno.getInt("maxtrno");
		} */
		
		//Inserting into master
		String strinsertmaster="insert into gl_vehreturn(date,agmtno,fleetno,status)values(CURDATE(),"+agmtno+","+fleetno+",3)";
		System.out.println("Master: "+strinsertmaster);

		int insertmaster=stmt.executeUpdate(strinsertmaster);
		if(insertmaster<=0){
			errorstatus=1;
		}
/* 	for(int i=0;i<calcarray.size();i++){
		String temp[]=calcarray.get(i).split("::");
		int acno=Integer.parseInt(temp[0]);
		double amount=Double.parseDouble(temp[1]);
		double partyamount=amount*-1;
		String strjv1="";
		String strjv2="";
		String strcost="";
		if(i==3){
			strcost="";
		}
		strjv1="insert into my_jvtran(tr_no,acno,dramount,rate,curId,out_amount,trtype,id,ref_row,brhid,description,yrId,cldocno,date,dTYPE,"+
				" stkmove,ldramount,doc_no,LAGE,ref_detail,lbrrate,status,costtype,costcode)values("+maxtrno+","+acno+","+amount+","+currate+","+curid+","+
				" 0.0,9,1,"+(i+1)+","+branch+",concat('Vehicle Return of ',"+fleetno+"),0,0,CURDATE(),'BLVR',0,"+amount*currate+","+maxdocno+",0,"+
				" concat('BLVR',' - ',"+maxdocno+"),"+currate+",3,6,"+fleetno+")";
		 
		strjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curId,out_amount,trtype,id,ref_row,brhid,description,yrId,cldocno,date,dTYPE,"+
				" stkmove,ldramount,doc_no,LAGE,ref_detail,lbrrate,status,costtype,costcode)values("+maxtrno+","+acno+","+partyamount+","+currate+","+curid+","+
				" 0.0,9,-1,"+(i+1)+","+branch+",concat('Vehicle Return of ',"+fleetno+"),0,0,CURDATE(),'BLVR',0,"+partyamount*currate+","+maxdocno+",0,"+
				" concat('BLVR',' - ',"+maxdocno+"),"+currate+",3,6,"+fleetno+")";
		
		if(!strjv1.equalsIgnoreCase("")){
			int jv1=stmt.executeUpdate(strjv1);
			if(jv1<=0){
				errorstatus=1;
			}
			else{
				if(!strjv2.equalsIgnoreCase("")){
					int jv2=stmt.executeUpdate(strjv2);
					if(jv2<=0){
						errorstatus=1;
					}
					else{
						if(i==3){
							int tranid=0;
							String strgettran="SELECT tranid FROM my_jvtran where TR_NO="+maxtrno+" and acno="+acno+" order by tranid desc limit 1";
							ResultSet rsgettran=stmt.executeQuery(strgettran);
							while(rsgettran.next()){
								tranid=rsgettran.getInt("tranid");
							}
							strcost="insert into my_costtran(acno,costType,amount,sr_no,tranid,projectId,jobId,tr_no)values("+acno+",6,"+amount+",1,"+tranid+",0,"+fleetno+","+maxtrno+")";
							int cost=stmt.executeUpdate(strcost);
							if(cost<=0){
								errorstatus=1;
							}
						}
					}
				}
			}
		}
		
		
	} 
	
	String strupdateveh="update gl_vehmaster set fstatus='Z' where fleet_no="+fleetno;
	System.out.println("vehupdate: "+strupdateveh);
	
	int updateveh=stmt.executeUpdate(strupdateveh);
	if(updateveh<0){
		errorstatus=1;
	}*/
	String strupdateagmt="";
	if(stockvehiclestatus.equalsIgnoreCase("1")){
		strupdateagmt="update gl_stockvehicles set vehreturnstatus=0,vehreturndate='"+sqlreturndate+"',vehreturnremarks='"+returnremarks+"' where doc_no="+agmtno;
	}
	else{
		strupdateagmt="update gl_lagmt set vehreturnstatus=0,vehreturndate='"+sqlreturndate+"',vehreturnremarks='"+returnremarks+"' where doc_no="+agmtno;	
	}
	
	System.out.println(strupdateagmt);
	int updateagmt=stmt.executeUpdate(strupdateagmt);
	if(updateagmt<0){
		errorstatus=1;
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