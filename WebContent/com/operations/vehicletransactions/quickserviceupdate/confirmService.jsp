<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	String docno=request.getParameter("docno");
	String garage=request.getParameter("garage");
	String currencyid=session.getAttribute("CURRENCYID").toString();
	String branch=request.getParameter("branch");
 	double totalamt=Double.parseDouble(request.getParameter("total"));
 	String formdetailcode=request.getParameter("formdetailcode");
 	java.sql.Date date=objcommon.changeStringtoSqlDate(request.getParameter("date"));
	Connection conn = objconn.getMyConnection();
	String partscost=request.getParameter("partscost");
	String labourcost=request.getParameter("labourcost");
	System.out.println(docno+":"+garage+":"+currencyid+":"+branch+":"+formdetailcode+":"+date+":"+partscost+":"+labourcost);
 	Statement stmt = conn.createStatement ();
 	try{
 	conn.setAutoCommit(false);
	int trno=0;
 	int updatestatus=0;
	Statement stmttrno=conn.createStatement();
	String gettrno="select (max(coalesce(trno,1))+1) trno from my_trno";
	ResultSet rstrno=stmttrno.executeQuery(gettrno);
	while(rstrno.next()){
		trno=rstrno.getInt("trno");
	}
	Statement stmtacno=conn.createStatement();
	String stracno="select (select acno from my_account where codeno='MAINTLAB') partsacno,(select acno from my_account where codeno='MAINTLSP')"+
			" labouracno,(select acc_no from gl_garrage where doc_no="+garage+") garageacno";
	ResultSet rsacno=stmtacno.executeQuery(stracno);
	int partsacno=0,labouracno=0,garageacno=0;
	while(rsacno.next()){
		partsacno=rsacno.getInt("partsacno");
		labouracno=rsacno.getInt("labouracno");
		garageacno=rsacno.getInt("garageacno");
	}
	Statement stmtcurr=conn.createStatement();
	int testcurid=0;
	double testcurrate=0.0;
	ResultSet rscurr=stmtcurr.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+currencyid+"'");
	while(rscurr.next()){
		testcurid=rscurr.getInt("doc_no");
		testcurrate=rscurr.getDouble("c_rate");
	}
	
	double totaldramt=totalamt;
	double totalldramt=testcurrate*totalamt;
	int i=0;
	String note="Quick Service Update Entry of Doc No "+docno;
	
	//Insertion to Jvtran Corresponding to total Value
	String strtotal="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
		"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+garageacno+"','"+totaldramt+"','"+testcurrate+"',"+
			"'"+testcurid+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+date+"','"+formdetailcode+"','"+totalldramt+"','"+docno+"','Quick Service Update',"+
		"'"+testcurrate+"','5',0,'0',3)";
	System.out.println("Jvtran Total"+strtotal);
	Statement stmttotal=conn.createStatement();
	int jvtotalval=stmttotal.executeUpdate(strtotal);
	if(jvtotalval>0){
		double partsdramt=Double.parseDouble(partscost)*-1;
		double partsldramt=partsdramt*testcurrate;
		Statement stmtparts=conn.createStatement();
		
		//Insertion to Jvtran corresponding to Parts Value
		String strparts="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
		"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+partsacno+"','"+partsdramt+"','"+testcurrate+"',"+
			"'"+testcurid+"',0,-1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+date+"','"+formdetailcode+"','"+partsldramt+"','"+docno+"','Quick Service Update',"+
		"'"+testcurrate+"','5',0,'0',3)";
		System.out.println("Jvtran Parts"+strparts);
		int jvpartsval=stmtparts.executeUpdate(strparts);
		if(jvpartsval>0){
			
			double labourdramt=Double.parseDouble(labourcost)*-1;
			double labourldramt=labourdramt*testcurrate;
			
			//Insertion to jvtran corresponding to Labours Value
		String strlabour="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+trno+"','"+labouracno+"','"+labourdramt+"','"+testcurrate+"',"+
				"'"+testcurid+"',0,-1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+date+"','"+formdetailcode+"','"+labourldramt+"','"+docno+"','Quick Service Update',"+
			"'"+testcurrate+"','5',0,'0',3)";
			System.out.println("Jvtran Labour:"+strlabour);
		Statement stmtlabourval=conn.createStatement();
		int  jvlabourval=stmtlabourval.executeUpdate(strlabour);
		if(jvlabourval>0){
			
			//Updating Confirm Status
			String strSql = "update gl_quickservicem set cstatus=1 where doc_no="+docno;
			int updateval=stmt.executeUpdate(strSql);
				if(updateval<0){
					stmt.close();
			 		conn.close();
					}
				if(updateval>0){
					conn.commit();
					stmt.close();
			 		conn.close();
					updatestatus=1;
					}
			
		}
		}
	}
	System.out.println("Check Update Status:"+updatestatus);
	response.getWriter().write(updatestatus+"");
 	}
 	catch(Exception e1){
 		e1.printStackTrace();
 		stmt.close();
 		conn.close();
 	}
	stmt.close();
	conn.close();
  %>