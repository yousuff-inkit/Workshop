<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();


	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();

		String account=request.getParameter("acc");
		String accdocno=request.getParameter("accdocno");
		String acccurid=request.getParameter("acccurid");
		String accrate=request.getParameter("accrate");
		String acccurtype=request.getParameter("acccurtype");
		String postingdate=request.getParameter("postingdate");
		String selectedtrno=request.getParameter("selectedtrno");
		String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		String formdetailcode="JVT";
		
		String sql=null,sql1=null,sql2=null,sql3=null,sql4=null;
		int val = 0, docNo = 0, docno = 0,trno = 0;
		
        java.sql.Date sqlDate = null;
        
        if(!(postingdate.equalsIgnoreCase("undefined")) && !(postingdate.equalsIgnoreCase("")) && !(postingdate.equalsIgnoreCase("0"))){
        	sqlDate = ClsCommon.changeStringtoSqlDate(postingdate);
        }
        
		ArrayList<String> griddataarray=new ArrayList<String>();
		String[] temparray=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			griddataarray.add(temparray[i]);
		}
		
		ArrayList<String> journalvouchersarray=new ArrayList<String>();
		double amounttotal=0.0,baseamounttotal=0.0;int j=0,id=1,totid=1;
		String subaccdocno="0";
		for(int i=0;i<griddataarray.size();i++){
			String[] temp=griddataarray.get(i).split("::");
			double amount=(Double.parseDouble(temp[1]));
			double baseamount=amount*Double.parseDouble(accrate);
			amounttotal+=amount;
			if(amount<0){
				id=-1;
			} 
			
			journalvouchersarray.add(temp[0]+"::"+temp[2]+" ["+temp[3]+" - "+temp[4]+"] is Inter Company Transfered on "+postingdate+"::"+temp[5]+"::"+temp[6]+"::"+amount+"::"+baseamount+"::"+i+"::"+id+":: 0:: 0");
			j=i;
			subaccdocno=temp[0];
		}
		
		baseamounttotal=amounttotal*Double.parseDouble(accrate);
		
		if(amounttotal<0){
			totid=-1;
		}
		
		journalvouchersarray.add(accdocno+":: Inter Company Transfer is Passed as Journal Voucher on "+postingdate+"::"+acccurid+"::"+accrate+"::"+(amounttotal)*-1+"::"+(baseamounttotal)*-1+"::"+(j+1)+"::"+(totid)*-1+":: 0:: 0");
		
		if(amounttotal<0){
			amounttotal=amounttotal*-1;
		}
		
		sql="select coalesce(max(doc_no)+1,1) doc_no from gl_btrf";
        ResultSet resultSet = stmt.executeQuery(sql);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
		
		ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
		docno=jvt.insert(sqlDate, formdetailcode.concat("-18"), "BTRF", "Inter Company Transfer of Account - "+account+" is Passed as Journal Voucher on "+postingdate, amounttotal, amounttotal, journalvouchersarray, session, request);
		trno=Integer.parseInt(request.getAttribute("tranno").toString());
		
		 sql1="update my_jvtran set refTrNo="+trno+" where acno in ("+accdocno+","+subaccdocno+") and tr_no in ("+selectedtrno+","+trno+")";
		 val= stmt.executeUpdate(sql1);  
	    
		 /*Inserting gl_btrf*/
	     sql2="insert into gl_btrf(doc_no, date, acno, tr_no, postedtrno, brhid, userid) values('"+docNo+"', '"+sqlDate+"', '"+account+"', '"+trno+"', '"+selectedtrno+"', '"+session.getAttribute("BRANCHID").toString()+"', '"+session.getAttribute("USERID").toString()+"')";
	     int data1= stmt.executeUpdate(sql2);
		 /*Inserting gl_btrf Ends*/
		 
	     sql3="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BTRF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	     int data= stmt.executeUpdate(sql3); 
		
	     response.getWriter().print(val+"***"+docno);
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
