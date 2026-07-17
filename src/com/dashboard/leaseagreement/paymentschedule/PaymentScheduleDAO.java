package com.dashboard.leaseagreement.paymentschedule;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class PaymentScheduleDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public  JSONArray pymtScheduleGrid(String branch, String pdate) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
     
        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and l.brhid="+branch+"";
    		}
    		
    		 java.sql.Date sqlDate = null;
    	     	if(!(pdate.equalsIgnoreCase("undefined"))&&!(pdate.equalsIgnoreCase(""))&&!(pdate.equalsIgnoreCase("0")))
    	     	{
    	     		sqlDate=ClsCommon.changeStringtoSqlDate(pdate);
    	     		
    	     	}
    	     	else{
    	     
    	     	}
    		
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				 
				String sql="select l.voc_no lano,a.refname client,l.outdate odate,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleetno,"
						+ "v.flname fleetname,lpc.date dates,round(lpc.amount,2) amount,l.doc_no,l.acno clacno,l.cldocno,l.brhid,a.period2,lpc.srno "
						+ "from gl_leasepytcalc lpc left join gl_lagmt l on l.doc_no=lpc.rdocno left join my_acbook a on l.cldocno=a.cldocno and a.dtype='CRM' "
						+ "left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no "
						+ " where lpc.markstatus=0 and l.clstatus=0 and lpc.date<='"+sqlDate+"' "+sqltest+" ";
		//	System.out.println("------sql------"+sql);
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
					stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }




	public int insert(ArrayList<String> invoicearray, HttpSession session,
			HttpServletRequest request) throws SQLException {
		System.out.println("Inside DAO");
		// TODO Auto-generated method stub
		Connection conn=null;
		int val=0;
		try{
			conn = ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			String invmsql=null,invdsql=null,jvtran1sql=null,jvtran2sql=null;
			java.sql.Date sqlDueDate = null;
			java.sql.Date sqlLPCDate = null;
			int invid=0;
			int acno=0;
			int errorstatus=0;
			String sqlinvmod="select idno,acno from gl_invmode where description='LEASE CHARGES'";
			ResultSet rsinv_acno=stmt.executeQuery(sqlinvmod);
			while(rsinv_acno.next())
			{
				 invid=rsinv_acno.getInt("idno");
				 acno=rsinv_acno.getInt("acno");
					 
			}
			
			for(int k=0;k<invoicearray.size();k++)
			{
					
				String[] pmgntarr=((String) invoicearray.get(k)).split("::"); 
				
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
				  
					 String strinvdesc="select (select method from gl_config where field_nme='invdesc') method,(select reg_no from gl_vehmaster where fleet_no="+fleetno+") reg_no,"+
							" (select plt.code_name from gl_vehmaster veh left join gl_vehplate plt on veh.pltid=plt.doc_no where veh.fleet_no="+fleetno+") plate";
					 int invdesc=0;
					 String regno="",plate="";
					 ResultSet rsinvdesc=stmt.executeQuery(strinvdesc);
					 while(rsinvdesc.next()){
						invdesc=rsinvdesc.getInt("method");
					 	regno=rsinvdesc.getString("reg_no");
					 	plate=rsinvdesc.getString("plate");
					 }
					 String desc="";
					 desc="LAG - "+lano;
					 	
					 if(invdesc==1){
						 desc=desc+" with Reg No "+regno+" and Plate Code "+plate;
					 }
				  
				 
				  
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
				  String invmax="select coalesce(max(doc_no),0)+1 invmdoc from gl_invm";
				  ResultSet rsinv=stmt.executeQuery(invmax);
					 if(rsinv.next())
					 {
						
						invmaxdoc=rsinv.getInt("invmdoc");
						
						 
					 }
				String invvocmax="select coalesce(max(voc_no),0)+1 invmvoc from gl_invm where brhid="+brch;
				ResultSet rsinvvoc=stmt.executeQuery(invvocmax);
				while(rsinvvoc.next()){
					invmaxvoc=rsinvvoc.getInt("invmvoc");
				}
					//due date
					
					   String sqldate=("select DATE_ADD('"+sqlLPCDate+"', INTERVAL "+period2+" DAY) AS duedate");
		    ResultSet rsdate1 = stmt.executeQuery(sqldate);
		        
		     while (rsdate1.next()) {
		     sqlDueDate=rsdate1.getDate("duedate");
		     }
				
			invmsql="insert into gl_invm (brhid, DOC_NO, DATE, RATYPE, CLDOCNO, RANO, LDGRNOTE, INVNOTE, CURID, ACNO, TR_NO, DTYPE, FROMDATE, TODATE, status, dispatch, userid, manual, voc_no) values('"+brch+"', '"+invmaxdoc+"', '"+sqlLPCDate+"', 'LAG','"+cldocno+"' , '"+docno+"', '"+desc+"', '"+desc+"', '"+session.getAttribute("CURRENCYID").toString()+"', '"+clacno+"', '"+trno+"', 'INV', '"+sqlLPCDate+"', '"+sqlLPCDate+"', 3, 0,'"+session.getAttribute("USERID").toString()+"', 11, '"+invmaxvoc+"')";
		 	int invmaster=stmt.executeUpdate(invmsql);
			if(invmaster<=0){
				errorstatus=1;
				return 0;
			}
			invdsql="insert into gl_invd(SR_NO, BRHID, RDOCNO, TRNO, CHID, UNITS, AMOUNT, TOTAL, ACNO, remarks) values(1,'"+brch+"','"+invmaxdoc+"', '"+trno+"','"+invid+"' , '1', '"+amount+"', '"+amount+"', '"+acno+"','"+desc+"' )";
			int invdetail=stmt.executeUpdate(invdsql);
			if(invdetail<=0){
				errorstatus=1;
				return 0;
			}
				   	  //jvtran insertion
			jvtran1sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId, trtype, id, ref_row, brhid, description, yrId, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status, category, refTrNo, rdocno, rtype, bankreconcile, prep, costtype, costcode) values ('"+trno+"', '"+acno+"', '"+neg_amount+"', 1.0000000000, '"+session.getAttribute("CURRENCYID").toString()+"', '5', -1, 1, '"+brch+"', '"+desc+"', 0, '"+sqlLPCDate+"', 'INV', 0, '"+neg_amount+"', '"+invmaxdoc+"', 1, '1', 1.0000, 3, '', 0, '"+docno+"', 'LAG', 0, 0,6, '"+fleetno+"')";
			int jv1=stmt.executeUpdate(jvtran1sql);
			if(jv1<=0){
				errorstatus=1;
				return 0;
			}
			jvtran2sql="insert into my_jvtran(tr_no, acno, dramount, rate, curId, duedate, trtype, id, ref_row, brhid, description, yrId, cldocno, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status, category, refTrNo, rdocno, rtype, bankreconcile, prep, costtype, costcode) values ('"+trno+"', '"+clacno+"', '"+amount+"', 1.0000000000, '"+session.getAttribute("CURRENCYID").toString()+"', '"+sqlDueDate+"','5', 1, 1, '"+brch+"', '"+desc+"', 0, '"+cldocno+"', '"+sqlLPCDate+"', 'INV', 0, '"+amount+"', '"+invmaxdoc+"', 1, '1', 1.0000, 3, '', 0, '"+docno+"', 'LAG', 0, 0,0, 0)";
			int jv2=stmt.executeUpdate(jvtran2sql);
			if(jv2<=0){
				errorstatus=1;
				return 0;
			}
			String strgettran="select tranid from my_jvtran where acno="+acno+" and tr_no="+trno;
			ResultSet rsgettran=stmt.executeQuery(strgettran);
			int tranid=0;
			while(rsgettran.next()){
				tranid=rsgettran.getInt("tranid");
			}
			
			String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+acno+",6,"+amount+",1,"+tranid+",0,"+fleetno+","+trno+")";
			int costinsert=stmt.executeUpdate(strcostinsert);
			if(costinsert<=0){
				errorstatus=1;
				return 0;
			}
			//biblog
					 
			String sqlbiblog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+invmaxdoc+"','"+brch+"','INV',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			int biblog=stmt.executeUpdate(sqlbiblog);  
			if(biblog<=0){
				errorstatus=1;
				return 0;
			}
					//update leasepytcalc	 	
					 	
			String updatesql="update gl_leasepytcalc set markstatus='"+invmaxdoc+"',trno="+trno+" where srno='"+srno+"'";
			int updatepyt=stmt.executeUpdate(updatesql);
			if(updatepyt<0){
				errorstatus=1;
				return 0;
			}
			}
			
			if(errorstatus!=1){
				conn.commit();
				val=1;
			}
			else{
				val=0;
			}
			
		}
		catch(Exception e){
			
			e.printStackTrace();
			val=0;
		}
		finally{
			conn.close();
		}
		return val;
	}
	
}
