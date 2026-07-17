<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%

String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String chkmultiple=request.getParameter("chkmultiple")==null?"":request.getParameter("chkmultiple");
String strexcess=request.getParameter("excess")==null?"":request.getParameter("excess");
String strclaimno=request.getParameter("claimno")==null?"":request.getParameter("claimno");
String strpono=request.getParameter("pono")==null?"":request.getParameter("pono");
String strpodate=request.getParameter("podate")==null?"":request.getParameter("podate");
String strvattype=request.getParameter("vattype")==null?"":request.getParameter("vattype");
String strestarray=request.getParameter("estarray")==null?"":request.getParameter("estarray");
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqlpodate=null;
	if(!strpodate.equalsIgnoreCase("") && !strpodate.equalsIgnoreCase("undefined")){
		sqlpodate=objcommon.changeStringtoSqlDate(strpodate);
	}
	ArrayList<String> estarray=new ArrayList();
	//System.out.println(jobcarddocno+"::"+chkmultiple+"::"+excess+"::"+claimno+"::"+pono+"::"+podate+"::"+vattype);
	for(int i=0;i<strestarray.split(",").length;i++){
		strestarray.split(",")[i].split("::")[0]=strestarray.split(",")[i].split("::")[0].equalsIgnoreCase("undefined")?"":strestarray.split(",")[i].split("::")[0];
		estarray.add(strestarray.split(",")[i]);
		System.out.println(estarray.get(i));
	}
	String strsql="";
	String strdelete="delete from ws_investdata where jobdocno="+jobcarddocno;
	int deleteval=stmt.executeUpdate(strdelete);
	for(int i=0;i<estarray.size();i++){
		if(chkmultiple.equalsIgnoreCase("1")){
			String estno=estarray.get(i).split("::")[0];
			String labourtotal=estarray.get(i).split("::")[1];
			String sparetotal=estarray.get(i).split("::")[2];
			String nettotal=estarray.get(i).split("::")[3];
			String chkclaim=estarray.get(i).split("::")[4].equalsIgnoreCase("true")?"1":"0";
			String claimno=estarray.get(i).split("::")[5].equalsIgnoreCase("undefined")?"":estarray.get(i).split("::")[5];
			String excess=estarray.get(i).split("::")[6].equalsIgnoreCase("undefined")?"0.0":estarray.get(i).split("::")[6];
			String pono=estarray.get(i).split("::")[7].equalsIgnoreCase("undefined")?"":estarray.get(i).split("::")[7];
			String podate=estarray.get(i).split("::")[8];
			String vattype=estarray.get(i).split("::")[9].equalsIgnoreCase("Shared")?"1":"2";
			java.sql.Date sqlpodatenew=null;
			if(!podate.equalsIgnoreCase("undefined") && !podate.equalsIgnoreCase("")){
				sqlpodatenew=objcommon.changeStringtoSqlDate(podate);
			}
			if(sqlpodatenew!=null){
				strsql="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
						" podate, vattype, status)values("+jobcarddocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+","+chkclaim+","+
						" '"+claimno+"',"+excess+",'"+pono+"','"+sqlpodatenew+"',"+vattype+",3)";
				System.out.println("Date Not Null Insert: "+strsql);
			}
			else{
				strsql="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
						" podate, vattype, status)values("+jobcarddocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+","+chkclaim+","+
						" '"+claimno+"',"+excess+",'"+pono+"',"+sqlpodatenew+","+vattype+",3)";
				System.out.println("Date Null Insert: "+strsql);
			}
			int value=stmt.executeUpdate(strsql);
			System.out.println("Insert Value:"+value);
			if(value<=0){
				errorstatus=1;
				break;
			}
		}
	}
	if(chkmultiple.equalsIgnoreCase("0")){
		double labourtotal=0.0,sparetotal=0.0,nettotal=0.0;
		String estno="";
		strvattype=strvattype.equalsIgnoreCase("Shared")?"1":"2";
		for(int i=0;i<estarray.size();i++){
			estno=estarray.get(0).split("::")[0];
			labourtotal+=Double.parseDouble(estarray.get(i).split("::")[1]);
			sparetotal+=Double.parseDouble(estarray.get(i).split("::")[2]);
			nettotal+=Double.parseDouble(estarray.get(i).split("::")[3]);
		}
		
		String strinsert="insert into ws_investdata(jobdocno, chkmultiple, estno, labourtotal, sparetotal, nettotal, chkclaim, claimno, excess, pono, "+
				" podate, vattype, status)values("+jobcarddocno+","+chkmultiple+",'"+estno+"',"+labourtotal+","+sparetotal+","+nettotal+",0,"+
				" '"+strclaimno+","+strexcess+",'"+strpono+"','"+sqlpodate+"',"+strvattype+",3)";
		System.out.println(strinsert);
		int insertval=stmt.executeUpdate(strinsert);
		if(insertval<=0){
			errorstatus=1;
		}
		
	}
	
	
	
	/* ArrayList<String> amountarray=new ArrayList();
	String strgetvalues="select sum(nettotal) amount,claimno,chkclaim from ws_investdata where jobdocno="+jobcarddocno+" group by claimno";
	ResultSet rsgetvalues=stmt.executeQuery(strgetvalues);
	while(rsgetvalues.next()){
		if(rsgetvalues.getInt("))
	} */ 
	
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
%>