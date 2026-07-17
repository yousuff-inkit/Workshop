package com.dashboard.trafficfine.posting;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineDAO;
/*import com.finance.transactions.contratrans.ClsContraTransDAO;*/
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

public class ClsPostingDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public int insert(String type,double txtdrtotal,String[] tranarray,ArrayList<String> postingarray, HttpSession session,HttpServletRequest request,String mode, Date sqldates) throws SQLException {
		 Connection conn  = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBPO = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
/*				DateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
		        java.util.Date date = new java.util.Date();
		        String jvPostedDate=dateFormat.format(date);*/
		        java.sql.Date postedDate = sqldates;
		        
		        int docno = 0,docNo=0;
		        int trno = 0;
		        

				
		        /*Inserting into my_jvma and my_jvtran*/
				    
		        	ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
				    docno=jvt.insert(postedDate,"JVT".concat("-9"), "BTPO", "Card is posted as JVT on"+postedDate ,txtdrtotal, txtdrtotal, postingarray, session, request);
				    trno=Integer.parseInt(request.getAttribute("tranno").toString());
				
				/*Inserting my_jvma and my_jvtran Ends*/
				
		      
				for (int i = 0; i < tranarray.length; i++) {
					String tranno=tranarray[i];	
					
					if(!(tranno.equalsIgnoreCase(""))){
						
						String jvtval="JVT";
					 String sql1="update gl_traffic set postdocno="+docno+",posttype='"+jvtval+"',posttrno="+trno+" where ticket_no="+tranno+"";
					 int data= stmtBPO.executeUpdate(sql1);
					 if(data<=0){
						    stmtBPO.close();
							conn.close();
							return 0;
						}
					}
				}
				
			    String sql="select coalesce(max(doc_no)+1,1) doc_no from gl_btpo";
		        ResultSet resultSet = stmtBPO.executeQuery(sql);
		  
		        while (resultSet.next()) {
				   docNo=resultSet.getInt("doc_no");
		        }
				 
			     String sql2="insert into gl_btpo(doc_no, date, tr_no, type, brhid, userid) values("+docNo+", now(), '"+trno+"', '"+type+"', '"+branch+"', '"+userid+"')";
				 int data1= stmtBPO.executeUpdate(sql2);
				 if(data1<=0){
					    stmtBPO.close();
						conn.close();
						return 0;
					}
				 
				if(docno>0){
					
					 String sqls="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','BTPO',now(),'"+userid+"','A')";
					 int datas= stmtBPO.executeUpdate(sqls);
					 if(datas<=0){
						    stmtBPO.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBPO.close();
					conn.close();
					return docno;
				}
			stmtBPO.close();
			conn.close();	
		 }catch(Exception e){	
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
		return 0;
	}
	
public JSONArray postingGridLoading(String fromdate,String todate,String ticketno) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	           ClsTrafficfineDAO trafficcommon=new ClsTrafficfineDAO();
		       double govfees=trafficcommon.getGovFees(conn);
		       java.sql.Date sqlFromDate = null;
		       java.sql.Date sqlToDate = null;
		        
		        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		        	 sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		        	 sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
	      String sqltest="";
		        if(!ticketno.equalsIgnoreCase("")){
		        	sqltest+=" and t.ticket_no in ("+ticketno+")";
		        }
	      
	        	   
	        	   
		        String sql="";
		       
		      
		    	 sql="select t.inv_no tinvno, m.voc_no invno,coalesce(t.inv_type,'') invtype,case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGREEMENT' when  "
						+ " t.rtype in ('LA','LC') then 'LEASE AGREEMENT' else  st.st_desc end as 'dtypedesc', "
						+ " case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno,  "
						+ " t.fleetno ,t.fine_source source, t.ticket_no ,t.traffic_date ,t.location, convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) as amount  "
						+ " from gl_traffic t   left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
						+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
						+ " left join gl_invm m on m.doc_no=t.inv_no  where t.postdocno=0 and t.isallocated=1 and t.inv_no>0  and t.status in (1) and t.traffic_date between '"+sqlFromDate+"' and '"+sqlToDate+"'"+sqltest;
		    	 
		    	// System.out.println("sql"+sql);
		    	 
/*	        	sql="select r.date,Convert(concat(r.dtype,' - ',r.rdocno),CHAR(100)) documentno,r.tr_no,r.brhid,r.dtype,r.rdocno,r.acno,r.refno,r.refdate,a.acno clacno,r.cldocno,a.refname,r.paydesc,"
	        		+ "if(r.cardtype='0','',if(r.cardtype='1','VISA','MASTER')) cardtype,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) paidas,round(r.netamt,2) netamt from gl_rentreceipt r "
	        		+ "left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' where r.status=3 and r.jvno=0 and r.paytype="+paytype+" and r.date between '"+sqlFromDate+"' and '"+sqlToDate+"'"+sql;*/
		        
	        //	System.out.println("SQL = "+sql);
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	      
		      stmt.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }  
	
	public JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String date,String check,String cmbtypes) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
		       Enumeration<String> Enumeration = session.getAttributeNames();
	           int a=0;
	           while(Enumeration.hasMoreElements()){
	            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	             a=1;
	            }
	           }
	           if(a==0){
	              return RESULTDATA;
	            }
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           
	           java.sql.Date sqlDate=null;
	           
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sqltest="";
		        String sql="";
		        
		        date.trim();
		           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		           {
		        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
		           }
		         //  and t.den=305
		           if(cmbtypes.equalsIgnoreCase("2"))
			        	  
			          {
			        	  
			        	  sqltest=sqltest+" and den=305 ";  
			          }
		           
		           
		           if(cmbtypes.equalsIgnoreCase("1"))
			        	  
			          {
			        	  
			        	  sqltest=sqltest+" and den=604 ";  
			          }
		           
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
			        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			        	  + "where t.atype='GL' and t.m_s=0 " +sqltest;
		        
		     // System.out.println( "------"+sql);
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		     /*  stmt.close();
		       conn.close();*/
		       }
		      stmt.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }

public JSONArray getMultiTickets(String branch,String fromdate,String todate,String type,String acno,String id,String ticketno,String regno) throws SQLException{
		JSONArray multidata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return multidata;
			
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			ClsTrafficfineDAO trafficcommon=new ClsTrafficfineDAO();
		       double govfees=trafficcommon.getGovFees(conn);
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(!ticketno.equalsIgnoreCase("")){
				sqltest+=" and t.ticket_no like '%"+ticketno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and t.regno like '%"+regno+"%'";
			}
			Statement stmt=conn.createStatement();
			String strsql="select t.regno,t.source, t.ticket_no ,t.traffic_date , convert(coalesce(if(t.fine_source like '%DUBAI%' && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount from gl_traffic t where t.postdocno=0 and "+
			" t.isallocated=1 and t.inv_no>0  and t.status in (1) and t.traffic_date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			multidata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return multidata;
	}
}
