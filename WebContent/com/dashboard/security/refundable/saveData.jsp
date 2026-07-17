<%@page import="com.common.ClsCommon"%>
<%@page import="com.operations.commtransactions.rentalrefund.ClsRentalRefundDAO"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Connection con = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String mainbranch=request.getParameter("mainbranch")==null?"0":request.getParameter("mainbranch").trim();
		String refunddate=request.getParameter("refunddate")==null?"0":request.getParameter("refunddate").trim();
		String ibbranch=request.getParameter("ibbranch")==null?"0":request.getParameter("ibbranch").trim();
		String chckibbranch=request.getParameter("chckibbranch")==null?"0":request.getParameter("chckibbranch").trim();
		String paytype=request.getParameter("type")==null?"0":request.getParameter("type").trim();
		String typeaccount=request.getParameter("typeaccount")==null?"0":request.getParameter("typeaccount").trim();
		String chequeno=request.getParameter("chequeno")==null?"0":request.getParameter("chequeno").trim();
		String chequedate=request.getParameter("chequedate")==null?"0":request.getParameter("chequedate").trim();
		String remarks=request.getParameter("remarks")==null?"0":request.getParameter("remarks").trim();
		String clientaccount=request.getParameter("clientaccount")==null?"0":request.getParameter("clientaccount").trim();
		String clientdocno=request.getParameter("clientdocno")==null?"0":request.getParameter("clientdocno").trim();
		String paidto=request.getParameter("clientname")==null?"0":request.getParameter("clientname").trim();
		String rano=request.getParameter("rano")==null?"0":request.getParameter("rano").trim();
		String ratype=request.getParameter("rtype")==null?"0":request.getParameter("rtype").trim();
		String securityamount1=request.getParameter("securityamount")==null?"0":request.getParameter("securityamount").trim();
		String balanceamount1=request.getParameter("balanceamount")==null?"0":request.getParameter("balanceamount").trim();
		String process=request.getParameter("process")==null?"0":request.getParameter("process").trim();
		String formdetailcode="RRP";
		String cardtype=request.getParameter("cardtype")==null?"0":request.getParameter("cardtype").trim();
		
		if(cardtype.equalsIgnoreCase("")){
			cardtype="0";
		}
		
		java.sql.Date sqlDate=null;
		java.sql.Date sqlChequeDate=null;
		
		String sql=null,sql1=null,sql2=null,sql3=null,sql4=null,sql5=null,sql6=null,sql7=null,sql8=null,sql9=null,sql10=null;
		int docNo=0, docno = 0,trno = 0,securityacno=0,val= 0,tranid=0,curid=0;
		double deductionamount = 0.00,additionalamount = 0.00,netamount = 0.00,onaccountamount=0.00,tobepaid=0.00,outamount=0.00,rate=0.00;
		
		double securityamount = Double.parseDouble(securityamount1);
		double balanceamount = Double.parseDouble(balanceamount1);
		
		if(!(refunddate.equalsIgnoreCase("undefined"))&&!(refunddate.equalsIgnoreCase(""))&&!(refunddate.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(refunddate);
		}
		
		if(!(chequedate.equalsIgnoreCase("undefined"))&&!(chequedate.equalsIgnoreCase(""))&&!(chequedate.equalsIgnoreCase("0"))){
			 sqlChequeDate=ClsCommon.changeStringtoSqlDate(chequedate);
		}
		
		sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bsr";
		ResultSet rs = stmt.executeQuery(sql);
		  
		while (rs.next()) {
			docNo=rs.getInt("doc_no");
		}
		   
		sql1="select t.doc_no from my_account ac inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY'";
		ResultSet resultSet = stmt.executeQuery(sql1);
			  
		while (resultSet.next()) {
		   securityacno=resultSet.getInt("doc_no");
		}
		
		ArrayList<String> applysecurityarray= new ArrayList<String>();
		ArrayList<String> journalvouchersarray= new ArrayList<String>();
		ArrayList<String> securityaccountarray= new ArrayList<String>();
		ClsRentalRefundDAO rrp = new ClsRentalRefundDAO();
		ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
		
		if(process.equalsIgnoreCase("REFUNDED")){
			/*REFUND*/
			
			if(balanceamount > 0){
				deductionamount = balanceamount;
			}else if(balanceamount < 0){
				additionalamount = balanceamount*-1;
			}
		
			netamount=(securityamount-deductionamount)+additionalamount;

		 	sql2="select tranid,curid currency,out_amount,((dramount*id)-out_amount) tobepaid from my_jvtran where rdocno="+rano+" and "
		 		 + "acno=(select t.doc_no from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where a.codeno='RSECURITY') and rtype='"+ratype+"' and "
		 		 + "dramount<0 and (dramount+out_amount)<0";
		 
		 	ResultSet resultSet1 = stmt.executeQuery(sql2);
			   
		   while(resultSet1.next()){
			   	 tobepaid=resultSet1.getDouble("tobepaid");
			   	 outamount=resultSet1.getDouble("out_amount");
			   	 tranid=resultSet1.getInt("tranid");
			   	 curid=resultSet1.getInt("currency");
			     
			     applysecurityarray.add(tobepaid+":: "+outamount+":: "+curid+":: "+tranid+":: "+securityacno); //Security Array
		     }
		
			docno=rrp.insert(sqlDate, paytype, Integer.parseInt(typeaccount), cardtype, chequeno, sqlChequeDate, remarks, Integer.parseInt(chckibbranch), ibbranch, Integer.parseInt(clientdocno), Integer.parseInt(clientaccount), ratype, rano, "1", securityacno, securityamount, deductionamount, additionalamount, netamount, onaccountamount, process+" ON "+sqlDate, paidto, applysecurityarray, session, request);
		 
		}
		
		 else  if(process.equalsIgnoreCase("RELEASED")){
				/*RELEASE*/			 
			 
				/* deductionamount = securityamount;
			
				netamount=(securityamount-deductionamount)+additionalamount;

				sql2="select tranid,curid currency,out_amount,((dramount*id)-out_amount) tobepaid from my_jvtran where rdocno="+rano+" and "
				 		 + "acno=(select t.doc_no from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where a.codeno='RSECURITY') and rtype='"+ratype+"' and "
				 		 + "dramount<0 and (dramount+out_amount)<0";
				 
				 	ResultSet resultSet1 = stmt.executeQuery(sql2);
					   
				   while(resultSet1.next()){
					   	 tobepaid=resultSet1.getDouble("tobepaid");
					   	 outamount=resultSet1.getDouble("out_amount");
					   	 tranid=resultSet1.getInt("tranid");
					   	 curid=resultSet1.getInt("currency");
					     
					     applysecurityarray.add(tobepaid+":: "+outamount+":: "+curid+":: "+tranid+":: "+securityacno); */ //Security Array
				     /* } */
				
				//docno=rrp.insert(sqlDate, paytype, Integer.parseInt(typeaccount), cardtype, chequeno, sqlChequeDate, remarks, Integer.parseInt(chckibbranch), ibbranch, Integer.parseInt(clientdocno), Integer.parseInt(clientaccount), ratype, rano, "1", securityacno, securityamount, deductionamount, additionalamount, netamount, onaccountamount, process+" ON "+sqlDate, paidto, applysecurityarray, session, request);
				 
			      sql2="select t.doc_no,t.curid,t.rate from my_account ac inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY'";
				  ResultSet resultSet1 = stmt.executeQuery(sql2);
			  
				  while (resultSet1.next()) {
		   				securityacno=resultSet1.getInt("doc_no");
		   				curid=resultSet1.getInt("curid");
		   				rate=resultSet1.getInt("curid");
				  }
			 
				  journalvouchersarray.add(securityacno+":: RELEASED ON "+refunddate+":: "+curid+"::"+rate+":: "+securityamount+":: "+(securityamount)*rate+":: "+mainbranch+":: 1::0::0"); //Security Account
				  
				  sql3="select doc_no,curid,rate from my_head where doc_no="+clientaccount+"";
				  ResultSet resultSet2 = stmt.executeQuery(sql3);
			  	  int clientsaccount=0;
				  while (resultSet2.next()) {
					    clientsaccount=resultSet2.getInt("doc_no");
		   				curid=resultSet2.getInt("curid");
		   				rate=resultSet2.getInt("curid");
				  }
				  
				  sql4="select tr_no,id,dramount,tranid from my_jvtran where acno=(select t.doc_no from my_account ac inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and status=3 and rdocno is not null and rtype='"+ratype+"' and rdocno='"+rano+"'";
				  ResultSet resultSet3 = stmt.executeQuery(sql4);
				  while (resultSet3.next()) {
					    securityaccountarray.add(resultSet3.getString("tr_no")+"::"+resultSet3.getString("id")+"::"+resultSet3.getString("dramount")+"::"+resultSet3.getString("tranid"));
				  }
				  
				  journalvouchersarray.add(clientsaccount+":: RELEASED ON "+refunddate+":: "+curid+"::"+rate+":: "+(securityamount)*-1+":: "+((securityamount)*rate)*-1+":: "+mainbranch+":: -1::0::0"); //Client Account
				  
				  docno=jvt.insert(sqlDate, "JVT".concat("-11"), "BSR", "RELEASED ON "+refunddate, securityamount, securityamount, journalvouchersarray, session, request);
				  trno=Integer.parseInt(request.getAttribute("tranno").toString());
				  
				  sql5="select tranid from my_jvtran where status=3 and acno=(select t.doc_no from my_account ac inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and tr_no="+trno+"";
				  ResultSet resultSet4 = stmt.executeQuery(sql5);
				  while (resultSet4.next()) {
					  tranid=resultSet4.getInt("tranid");
				  }
				  
				  sql6="update my_jvtran set out_amount="+securityamount+",rdocno='"+rano+"',rtype='"+ratype+"' where acno="+securityacno+" and tr_no="+trno+"";
				  stmt.executeUpdate(sql6);
				  
				  if(securityaccountarray.size()>0){
					  
					  for(int i=0;i<securityaccountarray.size();i++){

						  int tranno=Integer.parseInt(securityaccountarray.get(i).split("::")[0]);
						  int id=Integer.parseInt(securityaccountarray.get(i).split("::")[1]);
						  double dramount=Double.parseDouble(securityaccountarray.get(i).split("::")[2]);
						  int applytranid=Integer.parseInt(securityaccountarray.get(i).split("::")[3]);
						  
						  sql7="update my_jvtran set out_amount="+dramount+" where acno="+securityacno+" and tr_no="+tranno+"";
						  stmt.executeUpdate(sql7);
						  
						  if(id==1){
							   
							   sql8="insert into my_outd(TRANID, AMOUNT, AP_TRID, curId) values("+applytranid+", ("+dramount+")*("+id+"),"+tranid+", 1)";
							   
						   } else if(id==-1){
							   
							   sql8="insert into my_outd(TRANID, AMOUNT, AP_TRID, curId) values("+tranid+", ("+dramount+")*("+id+"), "+applytranid+", 1)";
							   
						  }
						  stmt.executeUpdate(sql8);
					  }

				  }
				
		 }
		
		 if(docno>0){
			 con = ClsConnection.getMyConnection();
			 Statement stmt1=con.createStatement();
			 con.setAutoCommit(false);
			 
			 sql9="insert into gl_bsr (doc_no, date, type, rrpno, cldocno, agreement, securityamount, remarks, brhid) values("+docNo+",'"+sqlDate+"', '"+process+"', '"+docno+"', '"+clientdocno+"', '"+ratype+" - "+rano+"', '"+securityamount+"', '"+remarks+"', '"+mainbranch+"')";
			 val= stmt1.executeUpdate(sql9);
			 
		     sql10="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+mainbranch+"','BSR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		     int data= stmt1.executeUpdate(sql10);
		     
		     con.commit();
		     stmt1.close();
			 con.close();
		 }
		 
	     response.getWriter().print(val+"***"+docno+"***"+process);
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
