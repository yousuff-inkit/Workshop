<%@page import="com.finance.transactions.unclearedchequepayment.ClsUnclearedChequePaymentDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%
String purchasestrarray=request.getParameter("purchasearray")==null?"":request.getParameter("purchasearray");
String deletestrarray=request.getParameter("deletearray")==null?"":request.getParameter("deletearray");
String deleteucrdocno=request.getParameter("deleteucrdocno")==null?"":request.getParameter("deleteucrdocno");
String purchasedocno=request.getParameter("purchasedocno")==null?"":request.getParameter("purchasedocno");
String currentdate=request.getParameter("currentdate")==null?"":request.getParameter("currentdate");
String vendor=request.getParameter("vendor")==null?"":request.getParameter("vendor");
double principalsum=Double.parseDouble((request.getParameter("principalsum")==null?"0.0":request.getParameter("principalsum"))+"");
double totalloanamount=Double.parseDouble((request.getParameter("totalloanamount")==null?"0.0":request.getParameter("totalloanamount"))+"");
String balanceloanacno=request.getParameter("balanceloanacno")==null?"":request.getParameter("balanceloanacno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String vehicleremove=request.getParameter("vehicleremove")==null?"":request.getParameter("vehicleremove");
//Overridden as per progress
//double balanceamt=totalloanamount-principalsum;
double balanceamt=principalsum-totalloanamount;
String postingdate=request.getParameter("postingdate")==null?"":request.getParameter("postingdate");
System.out.println(totalloanamount+"::"+principalsum+"::"+balanceamt);
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
ClsUnclearedChequePaymentDAO ucpdao=new ClsUnclearedChequePaymentDAO();
int errorstatus=0;
ArrayList<String> purchasearray=new ArrayList<String>();
java.sql.Date sqlpostingdate=null;
if(!postingdate.equalsIgnoreCase("")){
	sqlpostingdate=objcommon.changeStringtoSqlDate(postingdate);
}
if(!purchasestrarray.equalsIgnoreCase("")){
	String temp[]=purchasestrarray.split(",");
	for(int i=0;i<temp.length;i++){
		purchasearray.add(temp[i]);
	}	
}

ArrayList<String> deletearray=new ArrayList<String>();
if(!deletestrarray.equalsIgnoreCase("")){
	String deletetemp[]=deletestrarray.split(",");
	for(int i=0;i<deletetemp.length;i++){
		deletearray.add(deletetemp[i]);
	}	
}
java.sql.Date sqlcurrentdate=null;
if(!currentdate.equalsIgnoreCase("")){
	sqlcurrentdate=objcommon.changeStringtoSqlDate(currentdate);
}

try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	conn.setAutoCommit(false);
	

	String stracno="select bankaccno amountacno,intstaccno interestacno,loanaccno principalacno from gl_vpurdetm where rdocno="+purchasedocno;
	int amountacno=0,interestacno=0,principalacno=0;
	ResultSet rsacno=stmt.executeQuery(stracno);
	while(rsacno.next()){
		amountacno=rsacno.getInt("amountacno");
		interestacno=rsacno.getInt("interestacno");
		principalacno=rsacno.getInt("principalacno");
	}
	System.out.println("Bank Acno: "+stracno);
	int amountcurid=0,interestcurid=0,principalcurid=0;
	double amountcurrate=0.0,interestcurrate=0.0,principalcurrate=0.0;
	String purchasedesc="";
	
	String strgetbankdetails="select (select curid from my_head where doc_no="+amountacno+") amountcurid,"+
						" (select rate from my_head where doc_no="+amountacno+") amountcurrate,"+
						" (select curid from my_head where doc_no="+interestacno+") interestcurid,"+
						" (select rate from my_head where doc_no="+interestacno+") interestcurrate,"+
						" (select curid from my_head where doc_no="+principalacno+") principalcurid,"+
						" (select rate from my_head where doc_no="+principalacno+") principalcurrate,"+
						" (select desc1 from gl_vpurdetm where rdocno="+purchasedocno+") purchasedesc";
	System.out.println("Bank Details: "+stracno);
	ResultSet rsbankdetails=stmt.executeQuery(strgetbankdetails);
	while(rsbankdetails.next()){
		amountcurid=rsbankdetails.getInt("amountcurid");
		amountcurrate=rsbankdetails.getDouble("amountcurrate");
		interestcurid=rsbankdetails.getInt("interestcurid");
		interestcurrate=rsbankdetails.getDouble("interestcurrate");
		principalcurid=rsbankdetails.getInt("principalcurid");
		principalcurrate=rsbankdetails.getDouble("principalcurrate");
		purchasedesc=rsbankdetails.getString("purchasedesc");
	}
	if(!vehicleremove.equalsIgnoreCase("")){
		String vehicleupdate="update gl_vpurd set inactive=1 where rowno in ("+vehicleremove+")";
		int updateval=stmt.executeUpdate(vehicleupdate);
		if(updateval<0){
			errorstatus=1;
		}
	}
	if(!deleteucrdocno.equalsIgnoreCase("")){
		String strdeleteucr="update my_unclrchqbm set status=7 where doc_no in ("+deleteucrdocno+")";
		System.out.println("Delete Bank UCR: "+strdeleteucr);
		int deleteval=stmt.executeUpdate(strdeleteucr);
		if(deleteval<=0){
			errorstatus=1;
		}
		
	}
	
	for(int i=0;i<purchasearray.size();i++){
		String purchasetemp[]=purchasearray.get(i).split("::");
		System.out.println(purchasearray.get(i));
		String temp1[]=purchasearray.get(i).split("::");
		java.sql.Date sqldate=null;
		sqldate=objcommon.changetstmptoSqlDate(purchasetemp[3]);
		java.sql.Date sqlchequedate=null;
		if(!temp1[3].equalsIgnoreCase("undefined") && temp1[3]!=null){
			sqlchequedate=objcommon.changetstmptoSqlDate(temp1[3]);
		}
		System.out.println("checking Purchasetemp[8]: "+purchasetemp[8]);
		if(!purchasetemp[8].equalsIgnoreCase("") || !purchasetemp[8].equalsIgnoreCase("undefined") || purchasetemp[8]!=null){
			System.out.println("checking temp1[10]: "+temp1[10]);
			System.out.println("checking temp1[9]: "+temp1[9]);
			if(temp1[10].equalsIgnoreCase("1") && temp1[9].equalsIgnoreCase("1")){
				String ucrdocno=temp1[8];
				
				String strupdateucrm="update my_unclrchqbm set totalAmount="+temp1[7]+" where doc_no="+ucrdocno;
				System.out.println("Update Bank UCR Master: "+strupdateucrm);
				int updateucrm=stmt.executeUpdate(strupdateucrm);
				if(updateucrm<0){
					errorstatus=1;
				}
				String strupdateucrprincipal="update my_unclrchqbd set amount="+temp1[5]+",lamount="+temp1[5]+"*rate,description='"+sqlchequedate+" Principal Amount is "+temp1[5]+"' where sr_no=3 and acno="+principalacno+" and rdocno="+ucrdocno;
				System.out.println("Update Bank Principal: "+strupdateucrprincipal);
				int updateucrprincipal=stmt.executeUpdate(strupdateucrprincipal);
				if(updateucrprincipal<0){
					errorstatus=1;
				}
				String strupdateucrinterest="update my_unclrchqbd set amount="+temp1[6]+",lamount="+temp1[6]+"*rate,description='"+sqlchequedate+" Interest Amount is "+temp1[6]+"' where sr_no=2 and acno="+interestacno+" and rdocno="+ucrdocno;
				System.out.println("Update Bank Interest: "+strupdateucrinterest);
				int updateucrinterest=stmt.executeUpdate(strupdateucrinterest);
				if(updateucrinterest<0){
					errorstatus=1;
				}
				double descamount=Double.parseDouble(temp1[7])*-1;
				String strupdateucramount="update my_unclrchqbd set amount="+temp1[7]+"*-1,lamount=("+temp1[7]+"*-1)*rate,description='"+sqlchequedate+" Amount is "+descamount+"' where sr_no=0 and acno="+amountacno+" and rdocno="+ucrdocno;
				System.out.println("Update Bank Amount: "+strupdateucramount);
				int updateucramount=stmt.executeUpdate(strupdateucramount);
				if(updateucramount<0){
					errorstatus=1;
				}
				String strupdatepurchase="update gl_vpurdetd set pramt="+temp1[5]+",intstamt="+temp1[6]+",totamt="+temp1[7]+" where rowno="+temp1[2];
				System.out.println("Update Purchase Details: "+strupdatepurchase);
				int updatepurchase=stmt.executeUpdate(strupdatepurchase);
				if(updatepurchase<0){
					errorstatus=1;
				}
				/* 
				String strdelete="delete from gl_loanrestructure where deletestatus=0 and purchasedocno="+purchasedocno;
				int deleteval=stmt.executeUpdate(strdelete); */
				String strpurchaseinsert="insert into gl_loanrestructure(purchasedocno,date,chequeno,principalamt,interestamt,amount,bpvno,deletestatus)values("+
				"'"+purchasetemp[0]+"','"+sqldate+"','"+purchasetemp[4]+"',"+purchasetemp[5]+","+purchasetemp[6]+","+purchasetemp[7]+","+purchasetemp[8]+",0)";
				System.out.println("Purchase Insert: "+strpurchaseinsert);
				int insertval=stmt.executeUpdate(strpurchaseinsert);
				if(insertval<=0){
					errorstatus=1;
					break;
				}
			}
			else if(temp1[9].equalsIgnoreCase("0")){
				String txtamount=sqlchequedate+" Amount is -"+temp1[7];
				String txtinterest=sqlchequedate+" Interest Amount is "+temp1[6];
				String txtprincipal=sqlchequedate+" Principal Amount is "+temp1[5];
				ArrayList<String> unclearedarray=new ArrayList<String>();
				
				double amount=Double.parseDouble(temp1[7]);
				double baseamount=amount*amountcurrate;
				double interest=Double.parseDouble(temp1[6]);
				double baseinterest=interest*interestcurrate;
				double principal=Double.parseDouble(temp1[5]);
				double baseprincipal=principal*principalcurrate;
				
				unclearedarray.add(amountacno+"::"+amountcurid+"::"+amountcurrate+"::false::"+amount*-1+"::"+txtamount+"::"+baseamount*-1+"::0::0::0");
				// bank  for zero      		
				unclearedarray.add("0::0::0::0::0::0::0::0::0::0");
	    		// interest array      
				unclearedarray.add(interestacno+"::"+interestcurid+"::"+interestcurrate+"::true::"+interest+"::"+txtinterest+"::"+baseinterest+"::0::0::0");
				// loan  array      		
				unclearedarray.add(principalacno+"::"+principalcurid+"::"+principalcurrate+"::true::"+principal+"::"+txtprincipal+"::"+baseprincipal+"::0::0::0");
				int val=0;
				if(errorstatus!=1){
					val=ucpdao.insert(sqlcurrentdate,"UCP","VPU-"+purchasedocno,amountcurrate,sqlchequedate,temp1[4],vendor,0,purchasedesc,amount,0,unclearedarray,session,request,"A");
				}
				
				if(val<=0){
					errorstatus=1;
					break;
				}
				
				int rowcount=0;
				String strrowcount="select max(sr_no) maxsrno from gl_vpurdetd where rdocno="+purchasedocno;
				System.out.println("Purchase Rowcount: "+strrowcount);
				ResultSet rsrowcount=stmt.executeQuery(strrowcount);
				while(rsrowcount.next()){
					rowcount=rsrowcount.getInt("maxsrno");
				}
				String strpurchasedetail="INSERT INTO gl_vpurdetd(sr_no,pramt,date,intstamt,totamt,chqno,rdocno,bpvno)VALUES"
					       + " ("+(rowcount+1)+","
					       + "'"+(temp1[5].trim().equalsIgnoreCase("undefined") || temp1[5].trim().equalsIgnoreCase("NaN")|| temp1[5].trim().equalsIgnoreCase("")|| temp1[5].isEmpty()?0:temp1[5].trim())+"',"
					       + "'"+(temp1[3].trim().equalsIgnoreCase("undefined") || temp1[3].trim().equalsIgnoreCase("NaN")|| temp1[3].trim().equalsIgnoreCase("")|| temp1[3].isEmpty()?0:sqlchequedate)+"',"
					       + "'"+(temp1[6].trim().equalsIgnoreCase("undefined") || temp1[6].trim().equalsIgnoreCase("NaN")|| temp1[6].trim().equalsIgnoreCase("")|| temp1[6].isEmpty()?0:temp1[6].trim())+"',"
					       + "'"+(temp1[7].trim().equalsIgnoreCase("undefined") || temp1[7].trim().equalsIgnoreCase("NaN")||temp1[7].trim().equalsIgnoreCase("")|| temp1[7].isEmpty()?0:temp1[7].trim())+"',"
					       + "'"+(temp1[4].trim().equalsIgnoreCase("undefined") || temp1[4].trim().equalsIgnoreCase("NaN")||temp1[4].trim().equalsIgnoreCase("")|| temp1[4].isEmpty()?0:temp1[4].trim())+"',"
					       +"'"+purchasedocno+"','"+val+"')";
				System.out.println("Purchase Detail: "+strpurchasedetail);
				int detailinsert=stmt.executeUpdate(strpurchasedetail);
				if(detailinsert<=0){
					errorstatus=1;
					break;
				}
				/*
				Commented on 30-11-2017
				Progress-
				*/
				/* String strdelete="delete from gl_loanrestructure where deletestatus=0 and purchasedocno="+purchasedocno;
				int deleteval=stmt.executeUpdate(strdelete); */
				String strpurchaseinsert="insert into gl_loanrestructure(purchasedocno,date,chequeno,principalamt,interestamt,amount,bpvno,deletestatus)values("+
				"'"+purchasetemp[0]+"','"+sqldate+"','"+purchasetemp[4]+"',"+purchasetemp[5]+","+purchasetemp[6]+","+purchasetemp[7]+","+val+",0)";
				System.out.println("Purchase Insert: "+strpurchaseinsert);
				int insertval=stmt.executeUpdate(strpurchaseinsert);
				if(insertval<=0){
					errorstatus=1;
					break;
				}
			}
		}
		
	}
	
	for(int i=0;i<deletearray.size();i++){
		String deletetemp1[]=deletearray.get(i).split("::");
		java.sql.Date sqldate=null;
		sqldate=objcommon.changetstmptoSqlDate(deletetemp1[3]);
		int defaultdeleterow=Integer.parseInt(deletetemp1[9]);
		if(defaultdeleterow==0){
			String strdeleteinsert="insert into gl_loanrestructure(purchasedocno,date,chequeno,principalamt,interestamt,amount,bpvno,deletestatus)values("+
			"'"+deletetemp1[0]+"','"+sqldate+"','"+deletetemp1[4]+"',"+deletetemp1[5]+","+deletetemp1[6]+","+deletetemp1[7]+","+deletetemp1[8]+",1)";
			System.out.println("Delete Insert: "+strdeleteinsert);
			int insertval=stmt.executeUpdate(strdeleteinsert);
			if(insertval<=0){
				errorstatus=1;
				break;
			}			
		}

	}
	
	if(balanceamt!=0.0){
		int restructuretrno=0;
		/* ,(select coalesce(restructuretrno,0)  from gl_vpurm where doc_no="+purchasedocno+") restructuretrno */ 
		String strmaxtrno="select (select max(trno)+1 from my_trno) maxtrno";
		ResultSet rstrno=stmt.executeQuery(strmaxtrno);
		int trno=0;
		while(rstrno.next()){
			trno=rstrno.getInt("maxtrno");
			/* restructuretrno=rstrno.getInt("restructuretrno"); */
		}
		int inserttrno=stmt.executeUpdate("insert into my_trno(trno,userno,trtype,brhid,edate,transid)values("+trno+","+session.getAttribute("USERID").toString()+",3,"+branch+",now(),0)");
		if(inserttrno<=0){
			errorstatus=1;
		}
		
		if(restructuretrno==0){
			
			int updateresttrno=stmt.executeUpdate("update gl_vpurm set restructuretrno="+trno+" where doc_no="+purchasedocno);
		}
		String strloanacdetails="select curid,rate from my_head where atype='GL' and m_s=0 and doc_no="+balanceloanacno;
		System.out.println(strloanacdetails);
		String loanaccurid="";
		double loanaccurrate=0.0;
		ResultSet rsloanacdetails=stmt.executeQuery(strloanacdetails);
		while(rsloanacdetails.next()){
			loanaccurid=rsloanacdetails.getString("curid");
			loanaccurrate=rsloanacdetails.getDouble("rate");
		}
		/* if(restructuretrno!=0){
			int updatejv=stmt.executeUpdate("update my_jvtran set status=7 where tr_no="+restructuretrno);			
		} */
		String sqljv1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,"+
		" costtype,costcode,dTYPE,brhId,tr_no,STATUS)VALUES('"+sqlpostingdate+"','VPU "+purchasedocno+"','"+purchasedocno+"',"+balanceloanacno+","+
		" 'Purchase Loan Restructured of Doc No "+purchasedocno+"',"+loanaccurid+","+loanaccurrate+","+balanceamt+","+balanceamt*loanaccurrate+",0.0,3,1,0,0,"+
		" "+loanaccurrate+",1,0,0,'VPU',"+branch+","+trno+",3)";
		System.out.println(sqljv1);
		int jvval1=stmt.executeUpdate(sqljv1);
		if(jvval1<=0){
			errorstatus=1;
		}
		else{
			String sqljv2="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,"+
			" costtype,costcode,dTYPE,brhId,tr_no,STATUS)VALUES('"+sqlpostingdate+"','VPU "+purchasedocno+"','"+purchasedocno+"',"+principalacno+","+
			" 'Purchase Loan Restructured of Doc No "+purchasedocno+"',"+loanaccurid+","+loanaccurrate+","+(balanceamt*-1)+","+(balanceamt*-1)*loanaccurrate+","+
			" 0.0,3,2,0,0,"+loanaccurrate+",-1,0,0,'VPU',"+branch+","+trno+",3)";
			System.out.println(sqljv2);
			int jvval2=stmt.executeUpdate(sqljv2);
			if(jvval2<=0){
				errorstatus=1;
			}
		}
	}
	/* 
	for(int i=0;i<purchasearray.size();i++){
		String temp1[]=purchasearray.get(i).split("::");
		String ucrdocno=temp1[1];
		java.sql.Date sqlchequedate=null;
		if(!temp1[3].equalsIgnoreCase("undefined") && temp1[3]!=null){
			sqlchequedate=objcommon.changetstmptoSqlDate(temp1[3]);
		}
		
		else if(temp1[9].equalsIgnoreCase("0")){
			String txtamount=temp1[3]+" Amount is -"+temp1[7];
			String txtinterest=temp1[3]+" Interest Amount is "+temp1[6];
			String txtprincipal=temp1[3]+" Principal Amount is "+temp1[5];
			ArrayList<String> unclearedarray=new ArrayList<String>();
			
			double amount=Double.parseDouble(temp1[7]);
			double baseamount=amount*amountcurrate;
			double interest=Double.parseDouble(temp1[6]);
			double baseinterest=interest*interestcurrate;
			double principal=Double.parseDouble(temp1[5]);
			double baseprincipal=principal*principalcurrate;
			
			unclearedarray.add(amountacno+"::"+amountcurid+"::"+amountcurrate+"::false::"+amount*-1+"::"+txtamount+"::"+baseamount*-1+"::0::0::0");
			// bank  for zero      		
			unclearedarray.add("0::0::0::0::0::0::0::0::0::0");
    		// interest array      
			unclearedarray.add(interestacno+"::"+interestcurid+"::"+interestcurrate+"::true::"+interest+"::"+txtinterest+"::"+baseinterest+"::0::0::0");
			// loan  array      		
			unclearedarray.add(principalacno+"::"+principalcurid+"::"+principalcurrate+"::true::"+principal+"::"+txtprincipal+"::"+baseprincipal+"::0::0::0");
		
			int val=ucpdao.insert(sqlcurrentdate,"UCP","VPU-"+purchasedocno,amountcurrate,sqlchequedate,temp1[4],vendor,0,"",amount,0,unclearedarray,session,request,"A");
			
			if(val<=0){
				errorstatus=1;
				break;
			}
			
			int rowcount=0;
			String strrowcount="select max(sr_no) maxsrno from gl_vpurdetd where rdocno="+purchasedocno;
			System.out.println("Purchase Rowcount: "+strrowcount);
			ResultSet rsrowcount=stmt.executeQuery(strrowcount);
			while(rsrowcount.next()){
				rowcount=rsrowcount.getInt("maxsrno");
			}
			String strpurchasedetail="INSERT INTO gl_vpurdetd(sr_no,pramt,date,intstamt,totamt,chqno,rdocno,bpvno)VALUES"
				       + " ("+(rowcount+1)+","
				       + "'"+(temp1[5].trim().equalsIgnoreCase("undefined") || temp1[5].trim().equalsIgnoreCase("NaN")|| temp1[5].trim().equalsIgnoreCase("")|| temp1[5].isEmpty()?0:temp1[5].trim())+"',"
				       + "'"+(temp1[3].trim().equalsIgnoreCase("undefined") || temp1[3].trim().equalsIgnoreCase("NaN")|| temp1[3].trim().equalsIgnoreCase("")|| temp1[3].isEmpty()?0:sqlchequedate)+"',"
				       + "'"+(temp1[6].trim().equalsIgnoreCase("undefined") || temp1[6].trim().equalsIgnoreCase("NaN")|| temp1[6].trim().equalsIgnoreCase("")|| temp1[6].isEmpty()?0:temp1[6].trim())+"',"
				       + "'"+(temp1[7].trim().equalsIgnoreCase("undefined") || temp1[7].trim().equalsIgnoreCase("NaN")||temp1[7].trim().equalsIgnoreCase("")|| temp1[7].isEmpty()?0:temp1[7].trim())+"',"
				       + "'"+(temp1[4].trim().equalsIgnoreCase("undefined") || temp1[4].trim().equalsIgnoreCase("NaN")||temp1[4].trim().equalsIgnoreCase("")|| temp1[4].isEmpty()?0:temp1[4].trim())+"',"
				       +"'"+purchasedocno+"','"+val+"')";
			System.out.println("Purchase Detail: "+strpurchasedetail);
			int detailinsert=stmt.executeUpdate(strpurchasedetail);
			if(detailinsert<=0){
				errorstatus=1;
				break;
			}
		}
	}
	 */
	 
	 Statement stmtupdate=conn.createStatement();
	 int updatemaster=stmtupdate.executeUpdate("update gl_vpurdetm set loanamt="+principalsum+",restructure=1 where rdocno="+purchasedocno);
	 if(updatemaster<0){
		 errorstatus=1;
	 }
	if(errorstatus!=1){
		conn.commit();
		System.out.println("No Errors");
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