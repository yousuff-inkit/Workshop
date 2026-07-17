<%@page import="com.workshop.wsestimationnew.ClsWSEstimationNewDAO"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%
String servicetotal=request.getParameter("servicetotal")==null?"0.0":request.getParameter("servicetotal");
String partstotal=request.getParameter("total")==null?"":request.getParameter("total");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String lumsumamount=request.getParameter("lumsumamount")==null || request.getParameter("lumsumamount").toString().trim().equalsIgnoreCase("undefined")?"0":request.getParameter("lumsumamount").toString();
String chklumsum=request.getParameter("chklumsum")==null || request.getParameter("chklumsum").toString().trim().equalsIgnoreCase("undefined")?"0":request.getParameter("chklumsum");

String chkservicelumsum=request.getParameter("chkservicelumsum")==null || request.getParameter("chkservicelumsum").toString().trim().equalsIgnoreCase("undefined")?"0":request.getParameter("chkservicelumsum").toString();
String servicelumsumamt=request.getParameter("servicelumsumamt")==null || request.getParameter("servicelumsumamt").toString().trim().equalsIgnoreCase("undefined")?"0":request.getParameter("servicelumsumamt").toString();
String chkrandomlumsum=request.getParameter("chkrandomlumsum")==null || request.getParameter("chkrandomlumsum").toString().trim().equalsIgnoreCase("undefined")?"0":request.getParameter("chkrandomlumsum").toString();
String randomlumsumamt=request.getParameter("randomlumsumamt")==null || request.getParameter("randomlumsumamt").toString().trim().equalsIgnoreCase("undefined")?"0":request.getParameter("randomlumsumamt").toString();

Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	System.out.println(chklumsum+"///"+lumsumamount);
	System.out.println("Service:"+chkservicelumsum+"///"+servicelumsumamt);
	System.out.println("Random:"+chkrandomlumsum+"///"+randomlumsumamt);
	Statement stmt=conn.createStatement();
	double nettotal=0.0,netmarket=0.0,netused=0.0,netapproved=0.0,vatpercent=0.0,vatvalue=0.0;
	double vatnettotal=0.0,vatnetmarket=0.0,vatnetused=0.0,vatnetapproved=0.0;
	int cldocno=0,tax=0,clienttax=0;
	if(chklumsum.equalsIgnoreCase("1") && Double.parseDouble(lumsumamount)>0){
		partstotal=lumsumamount;
	}
	if(chkservicelumsum.equalsIgnoreCase("1") && Double.parseDouble(servicelumsumamt)>0){
		servicetotal=servicelumsumamt;
	}
	if(chkrandomlumsum.equalsIgnoreCase("1") && Double.parseDouble(randomlumsumamt)>0.0){
		nettotal=Double.parseDouble(randomlumsumamt);
	}
	else{
		nettotal=Double.parseDouble(partstotal)+Double.parseDouble(servicetotal);	
	}
	if(chkrandomlumsum.equalsIgnoreCase("0")){
		if(!docno.equalsIgnoreCase("") || (chklumsum.equalsIgnoreCase("1") && Double.parseDouble(lumsumamount)>0)){
			nettotal=Double.parseDouble(partstotal)+Double.parseDouble(servicetotal);
		}	
	}
	
	
	java.sql.Date sqldate=null;
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	String strgetclient="select cldocno from ws_gateinpass where doc_no="+gatedocno+" and status=3";
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);
	while(rsgetclient.next()){
		cldocno=rsgetclient.getInt("cldocno");
	}
	String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttax";
	ResultSet rschecktax=stmt.executeQuery(strchecktax);
	while(rschecktax.next()){
		tax=rschecktax.getInt("taxmethod");
		clienttax=rschecktax.getInt("clienttax");
	}
	if(tax==1 && clienttax==1){
		String strtax="select coalesce(vat_per,0.0) vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
		ResultSet rstax=stmt.executeQuery(strtax);
		while(rstax.next()){
			vatpercent=rstax.getDouble("vat_per");
		}
		
	}
	vatvalue=vatpercent/100;
	String strdelete="delete from ws_estspareamt where gatedocno="+gatedocno;
	int updateval=stmt.executeUpdate(strdelete);
	
	vatnettotal=nettotal+(vatvalue*nettotal);
	ArrayList<String> amtarray=new ArrayList();
	if(chkrandomlumsum.equalsIgnoreCase("0")){
		amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+partstotal);
		amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+servicetotal);	
	}
	else{
		amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+0.0);
		amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+0.0);	
	}
	
	amtarray.add(gatedocno+"::"+"Sub Total::"+null+"::"+nettotal);
	amtarray.add(gatedocno+"::"+"VAT::"+vatpercent+"::"+(vatvalue*nettotal));
	amtarray.add(gatedocno+"::"+"Net Total with VAT::"+null+"::"+vatnettotal);

	for(int i=0;i<amtarray.size();i++){
		//System.out.println("///////////////");
		String temp[]=amtarray.get(i).split("::");
		String stramtinsert="insert into ws_estspareamt(gatedocno,description,taxpercent,approved,status)values("+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[3]+",3)";
		
		int val=stmt.executeUpdate(stramtinsert);
		if(val<=0){
			errorstatus=1;
			break;
		}
	}
	/*if(docno.equalsIgnoreCase("")){
		if(chklumsum.equalsIgnoreCase("1") && Double.parseDouble(lumsumamount)>0){
			
			vatnettotal=nettotal+(vatvalue*nettotal);
			ArrayList<String> amtarray=new ArrayList();
			amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+partstotal);
			amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+servicetotal);
			amtarray.add(gatedocno+"::"+"Sub Total::"+null+"::"+nettotal);
			amtarray.add(gatedocno+"::"+"VAT::"+vatpercent+"::"+(vatvalue*nettotal));
			amtarray.add(gatedocno+"::"+"Net Total with VAT::"+null+"::"+vatnettotal);
		
			for(int i=0;i<amtarray.size();i++){
				//System.out.println("///////////////");
				String temp[]=amtarray.get(i).split("::");
				String stramtinsert="insert into ws_estspareamt(gatedocno,description,taxpercent,approved,status)values("+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[3]+",3)";
				
				int val=stmt.executeUpdate(stramtinsert);
				if(val<=0){
					errorstatus=1;
					break;
				}
			}
		}
		else{
			vatnettotal=nettotal+(vatvalue*nettotal);
			System.out.println(vatnettotal+"//"+nettotal+"//"+vatvalue+"//"+nettotal+"//"+servicetotal);
			ArrayList<String> amtarray=new ArrayList();
			amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+partstotal);
			amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+servicetotal);
			amtarray.add(gatedocno+"::"+"Sub Total::"+null+"::"+nettotal);
			amtarray.add(gatedocno+"::"+"VAT::"+vatpercent+"::"+(vatvalue*nettotal));
			amtarray.add(gatedocno+"::"+"Net Total with VAT::"+null+"::"+vatnettotal);
		
			for(int i=0;i<amtarray.size();i++){
				//System.out.println("??????????????????");
				String temp[]=amtarray.get(i).split("::");
				
				//System.out.println(""+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[2]+"");
				String stramtinsert="insert into ws_estspareamt(gatedocno,description,taxpercent,approved,status)values("+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[3]+",3)";
				System.out.println(stramtinsert);
				int val=stmt.executeUpdate(stramtinsert);
				System.out.println("val  -- "+val);
				if(val<=0){
					errorstatus=1;
					break;
				} 
			}	
		}
		
	}
	else{
		vatnettotal=nettotal+(vatvalue*nettotal);
		ArrayList<String> amtarray=new ArrayList();
		amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+partstotal);
		amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+servicetotal);
		amtarray.add(gatedocno+"::"+"Sub Total::"+null+"::"+nettotal);
		amtarray.add(gatedocno+"::"+"VAT::"+vatpercent+"::"+(vatvalue*nettotal));
		amtarray.add(gatedocno+"::"+"Net Total with VAT::"+null+"::"+vatnettotal);
	
		for(int i=0;i<amtarray.size();i++){
			//System.out.println("///////////////");
			String temp[]=amtarray.get(i).split("::");
			String stramtinsert="insert into ws_estspareamt(gatedocno,description,taxpercent,approved,status)values("+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[3]+",3)";
			
			int val=stmt.executeUpdate(stramtinsert);
			if(val<=0){
				errorstatus=1;
				break;
			}
		}
	} */
	
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(gatedocno);
%>