<%@page import="com.common.ClsCommon"%>
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

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		String salikaccount=request.getParameter("salikaccount");
		String expenseaccount=request.getParameter("expenseaccount");
		//String rano=request.getParameter("rano");
		String fleetno=request.getParameter("fleetno");
		String amounts=request.getParameter("amount");
		String mainbranch=request.getParameter("mainbranch");
		String docNo=request.getParameter("docno");
		String date=request.getParameter("date");
		//String srno=request.getParameter("srno");
		//String amountscount=request.getParameter("amountcount");
		String empId=request.getParameter("empid");
		String formdetailcode="JVT";
		//System.out.println(salikaccount+"????"+expenseaccount+"????"+fleetno+"???"+amounts+"????"+mainbranch+"????"+docNo+"?????"+empId+"????"+formdetailcode);
		java.sql.Date sqlDate=null;
		
		String sql=null,sql1=null,sql2=null,sql3=null,sql4=null;
		int docno = 0,trno = 0,currency=0,currencyexp=0,val=0,saliksrvemp=0,currencysrvemp=0;
		double rate = 0.00,rateexp = 0.00,ratesrvemp=0.00,value = 0.00;
		double amount = Double.parseDouble(amounts);
		//int amountcount = Integer.parseInt(amountscount);
		
	    sql="select date from gl_vinspm where doc_no="+docNo;
	    ResultSet resultSet = stmt.executeQuery(sql);
	  
	    while (resultSet.next()) {
		   sqlDate=resultSet.getDate("date");
	    }
		   
		sql1="select curid,rate from my_head where doc_no="+salikaccount+"";
		ResultSet resultSet1 = stmt.executeQuery(sql1);
			  
		while (resultSet1.next()) {
		   currency=resultSet1.getInt("curid");
		   rate=resultSet1.getDouble("rate");
		}
		
		sql2="select curid,rate from my_head where doc_no="+expenseaccount+"";
		ResultSet resultSet2 = stmt.executeQuery(sql2);
			  
		while (resultSet2.next()) {
		   currencyexp=resultSet2.getInt("curid");
		   rateexp=resultSet2.getDouble("rate");
		}
		
		sql3="select value from gl_config where field_nme='saliksrvemp' and method=1";
		ResultSet resultSet3 = stmt.executeQuery(sql3);
			  
		while (resultSet3.next()) {
		   value=resultSet3.getDouble("value");
		}
		
		sql4="select i.acno,h.curid,h.rate from gl_invmode i left join my_head h on i.acno=h.doc_no where i.idno=14";
		ResultSet resultSet4 = stmt.executeQuery(sql4);
			  
		while (resultSet4.next()) {
			saliksrvemp=resultSet4.getInt("acno");
			currencysrvemp=resultSet4.getInt("curid");
			ratesrvemp=resultSet4.getDouble("rate");
		}
		
		ArrayList<String> salikarray= new ArrayList<String>();
		salikarray.add(salikaccount+":: Staff-Allocated Damage is Passed as JVT on "+sqlDate+":: "+currency+":: "+rate+":: "+(amount)*-1+":: "+(amount)*rate*-1+"::"+1+":: -1:: 0:: 0"); //Salik Account
		salikarray.add(expenseaccount+":: Staff-Allocated Damage is Passed as JVT on "+sqlDate+":: "+currencyexp+"::"+rateexp+":: "+(amount)+":: "+(amount)*rateexp+":: "+2+":: 1::6 :: "+fleetno); //Expense Account
		/* 
		if(!(value==0)){
		salikarray.add(saliksrvemp+":: Staff-Allocated Damage is Passed as JVT on "+sqlDate+":: "+currencysrvemp+":: "+ratesrvemp+":: "+value*amountcount+":: "+value*amountcount*ratesrvemp+"::"+1+":: 1:: 0:: 0"); //Salik Service Employee Account
		} */
		
		ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
		
		docno=jvt.insert(sqlDate, formdetailcode, "0"+"-"+fleetno, "Staff-Allocated Damage is Passed as JVT on "+sqlDate, amount, amount, salikarray, session, request);
		int jvno=docno;
		trno=Integer.parseInt(request.getAttribute("tranno").toString());
		//System.out.println("Jvma Docno: "+docno);
		 sql="update gl_vinspm set invno='"+docno+"',invtype='JVT' where doc_no="+docNo+" and invno='0'";
		 val= stmt.executeUpdate(sql);
	     
	     sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+mainbranch+"','BSAD',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	     int data= stmt.executeUpdate(sql);
			if(docno>0){
			conn.commit();
			}
	     response.getWriter().print(jvno);
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
