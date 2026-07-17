<%@page import="com.workshop.wsestimationnew.ClsWSEstimationNewDAO"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%
String servicetotal=request.getParameter("servicetotal")==null?"":request.getParameter("servicetotal");
String genuinetotal=request.getParameter("genuinetotal")==null?"":request.getParameter("genuinetotal");
String markettotal=request.getParameter("markettotal")==null?"":request.getParameter("markettotal");
String usedtotal=request.getParameter("usedtotal")==null?"":request.getParameter("usedtotal");
String approvedtotal=request.getParameter("approvedtotal")==null?"":request.getParameter("approvedtotal");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String lumsumamount=request.getParameter("lumsumamount")==null?"":request.getParameter("lumsumamount");
String chklumsum=request.getParameter("chklumsum")==null?"":request.getParameter("chklumsum");
String straddition=request.getParameter("addition")==null?"":request.getParameter("addition");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	System.out.println(chklumsum+"///"+lumsumamount);
	Statement stmt=conn.createStatement();
	double netgenuine=0.0,netmarket=0.0,netused=0.0,netapproved=0.0,vatpercent=0.0,vatvalue=0.0;
	double vatnetgenuine=0.0,vatnetmarket=0.0,vatnetused=0.0,vatnetapproved=0.0;
	int cldocno=0,tax=0,clienttax=0;
	int addition=Integer.parseInt(straddition);
	if(mode.equalsIgnoreCase("A")){
		addition++;
	}
	if(chklumsum.equalsIgnoreCase("1") && Double.parseDouble(lumsumamount)>0){
		genuinetotal=lumsumamount;
		markettotal=lumsumamount;
		usedtotal=lumsumamount;
		approvedtotal=lumsumamount;
	}
	netgenuine=Double.parseDouble(genuinetotal)+Double.parseDouble(servicetotal);
	netmarket=Double.parseDouble(markettotal)+Double.parseDouble(servicetotal);
	netused=Double.parseDouble(usedtotal)+Double.parseDouble(servicetotal);
	if(!docno.equalsIgnoreCase("") || (chklumsum.equalsIgnoreCase("1") && Double.parseDouble(lumsumamount)>0)){
		netapproved=Double.parseDouble(approvedtotal)+Double.parseDouble(servicetotal);
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
	String strdelete="delete from ws_estspareamt where gatedocno="+gatedocno+" and addition="+addition;
	int updateval=stmt.executeUpdate(strdelete);
	if(docno.equalsIgnoreCase("")){
		if(chklumsum.equalsIgnoreCase("1") && Double.parseDouble(lumsumamount)>0){
			vatnetgenuine=netgenuine+(vatvalue*netgenuine);
			vatnetmarket=netmarket+(vatvalue*netmarket);
			vatnetused=netused+(vatvalue*netused);
			vatnetapproved=netapproved+(vatvalue*netapproved);
			ArrayList<String> amtarray=new ArrayList();
			amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+genuinetotal+"::"+markettotal+"::"+usedtotal+"::"+approvedtotal);
			amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+servicetotal+"::"+servicetotal+"::"+servicetotal+"::"+servicetotal);
			amtarray.add(gatedocno+"::"+"Sub Total::"+null+"::"+netgenuine+"::"+netmarket+"::"+netused+"::"+netapproved);
			amtarray.add(gatedocno+"::"+"VAT::"+vatpercent+"::"+(vatvalue*netgenuine)+"::"+(vatvalue*netmarket)+"::"+(vatvalue*netused)+"::"+(vatvalue*netapproved));
			amtarray.add(gatedocno+"::"+"Net Total with VAT::"+null+"::"+vatnetgenuine+"::"+vatnetmarket+"::"+vatnetused+"::"+vatnetapproved);
		
			for(int i=0;i<amtarray.size();i++){
				//System.out.println("///////////////");
				String temp[]=amtarray.get(i).split("::");
				String stramtinsert="insert into ws_estspareamt(gatedocno,description,taxpercent,genuine,market,used,approved,status,addition)values("+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+",3,"+addition+")";
				
				int val=stmt.executeUpdate(stramtinsert);
				if(val<=0){
					errorstatus=1;
					break;
				}
			}
		}
		else{
			vatnetgenuine=netgenuine+(vatvalue*netgenuine);
			vatnetmarket=netmarket+(vatvalue*netmarket);
			vatnetused=netused+(vatvalue*netused);
			vatnetapproved=netapproved+(vatvalue*netapproved);
			System.out.println(vatnetgenuine+"//"+netgenuine+"//"+vatvalue+"//"+netgenuine);
			ArrayList<String> amtarray=new ArrayList();
			amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+genuinetotal+"::"+markettotal+"::"+usedtotal);
			amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+servicetotal+"::"+servicetotal+"::"+servicetotal);
			amtarray.add(gatedocno+"::"+"Sub Total::"+null+"::"+netgenuine+"::"+netmarket+"::"+netused);
			amtarray.add(gatedocno+"::"+"VAT::"+vatpercent+"::"+(vatvalue*netgenuine)+"::"+(vatvalue*netmarket)+"::"+(vatvalue*netused));
			amtarray.add(gatedocno+"::"+"Net Total with VAT::"+null+"::"+vatnetgenuine+"::"+vatnetmarket+"::"+vatnetused);
		
			for(int i=0;i<amtarray.size();i++){
				//System.out.println("??????????????????");
				String temp[]=amtarray.get(i).split("::");
				String stramtinsert="insert into ws_estspareamt(gatedocno,description,taxpercent,genuine,market,used,status,addition)values("+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+",3,"+addition+")";
				System.out.println(stramtinsert);
				int val=stmt.executeUpdate(stramtinsert);
				if(val<=0){
					errorstatus=1;
					break;
				}
			}	
		}
		
	}
	else{
		vatnetgenuine=netgenuine+(vatvalue*netgenuine);
		vatnetmarket=netmarket+(vatvalue*netmarket);
		vatnetused=netused+(vatvalue*netused);
		vatnetapproved=netapproved+(vatvalue*netapproved);
		ArrayList<String> amtarray=new ArrayList();
		amtarray.add(gatedocno+"::"+"Total Parts Cost::"+null+"::"+genuinetotal+"::"+markettotal+"::"+usedtotal+"::"+approvedtotal);
		amtarray.add(gatedocno+"::"+"Total Services Cost::"+null+"::"+servicetotal+"::"+servicetotal+"::"+servicetotal+"::"+servicetotal);
		amtarray.add(gatedocno+"::"+"Sub Total::"+null+"::"+netgenuine+"::"+netmarket+"::"+netused+"::"+netapproved);
		amtarray.add(gatedocno+"::"+"VAT::"+vatpercent+"::"+(vatvalue*netgenuine)+"::"+(vatvalue*netmarket)+"::"+(vatvalue*netused)+"::"+(vatvalue*netapproved));
		amtarray.add(gatedocno+"::"+"Net Total with VAT::"+null+"::"+vatnetgenuine+"::"+vatnetmarket+"::"+vatnetused+"::"+vatnetapproved);
	
		for(int i=0;i<amtarray.size();i++){
			//System.out.println("///////////////");
			String temp[]=amtarray.get(i).split("::");
			String stramtinsert="insert into ws_estspareamt(gatedocno,description,taxpercent,genuine,market,used,approved,status,addition)values("+temp[0]+",'"+temp[1]+"',"+temp[2]+","+temp[3]+","+temp[4]+","+temp[5]+","+temp[6]+",3,"+addition+")";
			
			int val=stmt.executeUpdate(stramtinsert);
			if(val<=0){
				errorstatus=1;
				break;
			}
		}
	}
	
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