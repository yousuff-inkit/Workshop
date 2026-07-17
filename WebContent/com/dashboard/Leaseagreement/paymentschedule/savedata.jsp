
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%	

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

  String list=request.getParameter("list")==null?"0":request.getParameter("list");
 
  
  java.sql.Date sqlDueDate = null;
  
  java.sql.Date sqlLPCDate = null;
  
 /*  String postdate=request.getParameter("postdate");
  java.sql.Date sqlPostDate = null;
	if(!(postdate.equalsIgnoreCase("undefined"))&&!(postdate.equalsIgnoreCase(""))&&!(postdate.equalsIgnoreCase("0")))
	{
		sqlPostDate=ClsCommon.changeStringtoSqlDate(postdate);
		
	}
	else{

	} */
	
 	 
	  ArrayList<String> psrnoarray= new ArrayList<String>();
		String aa[]=list.split(",");
			for(int i=0;i<aa.length;i++){
			// System.out.println("----------"+aa[i]);
			 String bb[]=aa[i].split("::");
			// System.out.println("Col Len----------"+bb.length);
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
				 
			}
			 psrnoarray.add(temp);
			 
		}  
	 
		Connection conn=null;

		 try{
	 	 conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
		int val=0;
		String invmsql=null,invdsql=null,jvtran1sql=null,jvtran2sql=null;
		int invid=0;
		int acno=0;
		 String sqlinvmod="select idno,acno from gl_invmode where description='LEASE CHARGES'";
		  ResultSet rsinv_acno=stmt.executeQuery(sqlinvmod);
			 if(rsinv_acno.next())
			 {
				
				 invid=rsinv_acno.getInt("idno");
				 acno=rsinv_acno.getInt("acno");
				 
			 }
		
for(int k=0;k<psrnoarray.size();k++)
	{
			
		String[] pmgntarr=((String) psrnoarray.get(k)).split("::"); 
		
		 String lano = ""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";
		  String docno = ""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
		  String cldocno = ""+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"";
		  
		  String clacno = ""+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"";
		  String amount = ""+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"";
		  String brch = ""+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"";
	//	  String userid = ""+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"";
		  String fleetno = ""+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"";
		  String period2 = ""+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"";
		  String srno = ""+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"";
		  String lpcdate = ""+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?"":pmgntarr[9].trim())+"";
		
		  sqlLPCDate=ClsCommon.changeStringtoSqlDate(lpcdate);
		  
		 
		  
		  Double neg_amount=Double.parseDouble(amount)*-1;
		  
		  String sqlinserttrno="insert into my_trno(USERNO, TRTYPE, brhId, edate, transid) values('"+session.getAttribute("USERID").toString()+"','INV','"+brch+"',NOW(),0)";
		  stmt.executeUpdate(sqlinserttrno);
		  
		  int trno=0;
		  String sqltrno="select max(trno) trno from my_trno where trtype='INV' ";
		  ResultSet rstrno=stmt.executeQuery(sqltrno);
			 if(rstrno.next())
			 {
				
				 trno=rstrno.getInt("trno");
				 
			 }
		  
		  int invmaxdoc=0;
		  int invmaxvoc=0;
		  String invmax="select coalesce(max(doc_no),0)+1 invmdoc,coalesce(max(voc_no),0)+1 invmvoc from gl_invm where dtype='INV' ";
		  ResultSet rsinv=stmt.executeQuery(invmax);
			 if(rsinv.next())
			 {
				
				invmaxdoc=rsinv.getInt("invmdoc");
				invmaxvoc=rsinv.getInt("invmvoc");
				 
			 }
			//due date
			
			   String sqldate=("select DATE_ADD('"+sqlLPCDate+"', INTERVAL "+period2+" DAY) AS duedate");
    ResultSet rsdate1 = stmt.executeQuery(sqldate);
        
     while (rsdate1.next()) {
     sqlDueDate=rsdate1.getDate("duedate");
     }
		
			  invmsql="insert into gl_invm (brhid, DOC_NO, DATE, RATYPE, CLDOCNO, RANO, LDGRNOTE, INVNOTE, CURID, ACNO, TR_NO, DTYPE, FROMDATE, TODATE, status, dispatch, userid, manual, voc_no) values('"+brch+"', '"+invmaxdoc+"', '"+sqlLPCDate+"', 'LAG','"+cldocno+"' , '"+docno+"', 'LAG-"+lano+"', 'LAG-"+lano+"', '"+session.getAttribute("CURRENCYID").toString()+"', '"+clacno+"', '"+trno+"', 'INV', '"+sqlLPCDate+"', '"+sqlLPCDate+"', 3, 0,'"+session.getAttribute("USERID").toString()+"', 11, '"+invmaxvoc+"')";
 			  stmt.executeUpdate(invmsql);
		 
		      invdsql="insert into gl_invd(SR_NO, BRHID, RDOCNO, TRNO, CHID, UNITS, AMOUNT, TOTAL, ACNO, remarks) values(1,'"+brch+"','"+invmaxdoc+"', '"+trno+"','"+invid+"' , '1', '"+amount+"', '"+amount+"', '"+acno+"','LAG-"+lano+"' )";
		   	  stmt.executeUpdate(invdsql);
		
		   	  //jvtran insertion
			 jvtran1sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId, trtype, id, ref_row, brhid, description, yrId, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status, category, refTrNo, rdocno, rtype, bankreconcile, prep, costtype, costcode) values ('"+trno+"', '"+acno+"', '"+neg_amount+"', 1.0000000000, '"+session.getAttribute("CURRENCYID").toString()+"', '5', -1, 1, '"+brch+"', 'LAG-"+lano+"', 0, '"+sqlLPCDate+"', 'INV', 0, '"+neg_amount+"', '"+invmaxdoc+"', 1, '1', 1.0000, 3, '', 0, '"+docno+"', 'LAG', 0, 0,6, '"+fleetno+"')";
			 stmt.executeUpdate(jvtran1sql);
			 
			 jvtran2sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId, duedate, trtype, id, ref_row, brhid, description, yrId, cldocno, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status, category, refTrNo, rdocno, rtype, bankreconcile, prep, costtype, costcode) values ('"+trno+"', '"+clacno+"', '"+amount+"', 1.0000000000, '"+session.getAttribute("CURRENCYID").toString()+"', '"+sqlDueDate+"','5', 1, 1, '"+brch+"', 'LAG-"+lano+"', 0, '"+cldocno+"', '"+sqlLPCDate+"', 'INV', 0, '"+amount+"', '"+invmaxdoc+"', 1, '1', 1.0000, 3, '', 0, '"+docno+"', 'LAG', 0, 0,6, '"+fleetno+"')";
			 stmt.executeUpdate(jvtran2sql);
		
			 //biblog
			 
			 String sqlbiblog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+invmaxdoc+"','"+brch+"','INV',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 	stmt.executeUpdate(sqlbiblog);  
		
			//update leasepytcalc	 	
			 	
			 String updatesql="update gl_leasepytcalc set markstatus='"+invmaxdoc+"' where srno='"+srno+"'";
			 stmt.executeUpdate(updatesql);
	 
	}
		conn.commit();
		 response.getWriter().print(1);
	  
	 	stmt.close();
	 	conn.close();
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 			response.getWriter().print(2);
	 		}
	    
	%>