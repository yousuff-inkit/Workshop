package com.dashboard.security;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSecurity  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray refundable(String branch,String uptodate,String agreementClosedDays,String clientAccount) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRefundable = conn.createStatement();
				String sql = "";
				java.sql.Date sqlUpToDate = null;
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					/*sql+=" and j.brhid="+branch+"";*/
					sql+=" and (r.brhid="+branch+" or l.brhid="+branch+")";
	    		}
				
				if(!(sqlUpToDate==null)){
					//sql+=" and (r.date<='"+sqlUpToDate+"' or l.date<='"+sqlUpToDate+"')";
					sql+=" and (DATE_ADD(rc.date,INTERVAL "+agreementClosedDays+" DAY)<='"+sqlUpToDate+"' or DATE_ADD(lc.date,INTERVAL "+agreementClosedDays+" DAY)<='"+sqlUpToDate+"')";
			    }
				
				if(!(clientAccount.equalsIgnoreCase("0")) && !(clientAccount.equalsIgnoreCase(""))){
					sql+=" and c.acno="+clientAccount+"";
	            }
					
				/*sql = "select CONVERT(if(secamount1<0,round(secamount1*-1,2),' '),CHAR(100)) securityamount,CONVERT(if(invamount1=0,'',if(invamount1<0,' ',round(invamount1,2))),CHAR(100)) invoiceamount,"
						+ "CONVERT(if(cnoamount1=0,'',if(cnoamount1<0,round(cnoamount1*-1,2),' ')),CHAR(100)) creditnoteamount,CONVERT(if(crvamount1=0,'',if(crvamount1<0,round(crvamount1*-1,2),' ')),CHAR(100)) receiptamount,"
						+ "CONVERT(round((if(invamount1=0,' ',if(invamount1<0,' ',round(invamount1,2))))-(if(crvamount1=0,' ',if(crvamount1<0,round(crvamount1*-1,2),' ')))-(if(cnoamount1=0,' ',if(cnoamount1<0,round(cnoamount1*-1,2),' '))),2),CHAR(100)) balance,"
						+ "CONVERT(round((if(secamount1<0,round(secamount1*-1,2),' '))-(round((if(invamount1=0,' ',if(invamount1<0,' ',round(invamount1,2))))-(if(crvamount1=0,'',if(crvamount1<0,round(crvamount1*-1,2),' ')))-(if(cnoamount1=0,'',"
						+ "if(cnoamount1<0,round(cnoamount1*-1,2),' '))),2)),2),CHAR(100)) netvalue,if(r.date is null,l.date,r.date) radate,if(r.cldocno is null,l.cldocno,r.cldocno) cldocno,c.acno clacno,coalesce(rc.date,lc.date) closedate,"
						+ "CONVERT(if(j.rtype='0','',if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,j.brhid,j.rdocno rano,j.rtype,c.refname clientname,if(c.per_mob is null,c.com_mob,c.per_mob) mobile,CONVERT(concat(' Client : ',coalesce(c.refname,' '),' * ',"
						+ "'Agreement  : ',coalesce(if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no)),' '),' * ','Security : ' ,coalesce(round(secamount1*-1,2),' '),' * ','Balance : ', coalesce(round((if(invamount1<0,'',round(invamount1,2)))-"
						+ "(if(crvamount1<0,round(crvamount1*-1,2),''))-(if(cnoamount1<0,round(cnoamount1*-1,2),'')),2),' ')),CHAR(1000)) empinfo from  ("
						+ "select sum(invamount) invamount1,sum(cnoamount) cnoamount1,sum(crvamount) crvamount1,sum(secamount) secamount1,a.* from ("
						+ "select 0 invamount,0 cnoamount,0 crvamount,sum(dramount) as secamount,rdocno,rtype,brhid from my_jvtran where acno=(select t.doc_no from my_account ac inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') "
						+ "and status=3 and rdocno is not null group by rdocno,rtype union all "
						+ "select sum(invamount) invamount,0 cnoamount,0 crvamount,0 secamount,rdocno,rtype,brhid from ( select j.dramount,j.out_amount,(j.dramount-j.out_amount) invamount,j.rdocno,j.rtype,j.brhid from my_jvtran j where "  
						+ "j.dtype='INV' and j.status=3 and rdocno is not null) a group by a.rdocno,a.rtype union all "  
						+ "select 0 invamount,sum(cnoamount) cnoamount,0 crvamount,0 secamount,rdocno,rtype,brhid from ( select j.dramount,j.out_amount,(j.dramount-j.out_amount) cnoamount,j.rdocno,j.rtype,j.brhid from my_jvtran j where "  
						+ "j.dtype='CNO' and j.status=3 and rdocno is not null) a group by a.rdocno,a.rtype union all "  
						+ "select 0 invamount,0 invamount,sum(crvamount) crvamount,0 secamount,rdocno,rtype,brhid from ( select j.dramount,j.out_amount,(j.dramount-j.out_amount) crvamount,j.rdocno,j.rtype,j.brhid from my_jvtran j where "  
						+ "j.dtype='CRV' and j.status=3 and rdocno is not null) a group by a.rdocno,a.rtype) a group by rdocno,rtype) j "
						+ "left join gl_ragmt r on j.rdocno=r.doc_no and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join gl_ragmtclosem rc on r.doc_no=rc.agmtno left join gl_lagmtclosem lc on l.doc_no=lc.agmtno "
						+ "left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' where secamount!=0 and (r.clstatus=1 or l.clstatus=1)"+sql+" order by rano,rtype";*/	
				
				sql = "select CONVERT(if(secamount1<0,round(secamount1*-1,2),''),CHAR(100)) securityamount,CONVERT(if(invamount1=0,'',if(invamount1<0,round(invamount1*-1,2),round(invamount1,2))),CHAR(100)) invoiceamount,"
						+ "CONVERT(if(cnoamount1=0,'',if(cnoamount1<0,round(cnoamount1*-1,2),round(cnoamount1,2))),CHAR(100)) creditnoteamount,CONVERT(if(crvamount1=0,'',if(crvamount1<0,round(crvamount1*-1,2),round(crvamount1,2))),CHAR(100)) receiptamount,"  
						+ "round((invamount1+crvamount1+cnoamount1),2) balance,round((secamount1+invamount1+crvamount1+cnoamount1),2) netvalue,if(r.date is null,l.date,r.date) radate,if(r.cldocno is null,l.cldocno,r.cldocno) cldocno,c.acno clacno,"  
						+ "coalesce(rc.date,lc.date) closedate,CONVERT(if(j.rtype='0','',if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,j.brhid,j.rdocno rano,j.rtype,c.refname clientname,"
						+ "if(c.per_mob is null,c.com_mob,c.per_mob) mobile,CONVERT(concat(' Client : ',coalesce(c.refname,' '),' * ','Agreement  : ',coalesce(if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no)),' '),' * ','Security : ' ,"
						+ "coalesce(round(secamount1*-1,2),' '),' * ','Balance : ',coalesce(round((invamount1+crvamount1+cnoamount1),2),' ')),CHAR(1000)) empinfo from  ( select sum(invamount) invamount1,sum(cnoamount) cnoamount1,sum(crvamount) crvamount1,"
						+ "sum(secamount) secamount1,a.* from ( select 0 invamount,0 cnoamount,0 crvamount,sum(dramount) as secamount,rdocno,rtype,brhid from my_jvtran where acno=(select t.doc_no from my_account ac inner join my_head t on ac.acno=t.doc_no "
						+ "where ac.codeno='RSECURITY') and status=3 and rdocno is not null and dramount<0 group by rdocno,rtype having sum(dramount-out_amount)!=0 union all select sum(j.dramount-j.out_amount) invamount,0 cnoamount,0 crvamount,0 secamount,j.rdocno,j.rtype,j.brhid from my_jvtran j inner join "
						+ "gl_invm r on j.tr_no=r.tr_no and j.cldocno=r.cldocno where j.cldocno>0  and j.status=3 and rdocno is not null group by rdocno,rtype union all select 0 invamount,sum(cnoamount) cnoamount,0 crvamount,0 secamount,rdocno,rtype,brhid from ( "
						+ "select j.dramount,j.out_amount,(j.dramount-j.out_amount) cnoamount,j.rdocno,j.rtype,j.brhid from my_jvtran j where j.cldocno>0 and j.dtype='CNO' and j.status=3 and rdocno is not null) a group by a.rdocno,a.rtype union all select 0 invamount,"
						+ "0 cnoamount,sum(j.dramount-j.out_amount) crvamount,0 secamount,j.rdocno,j.rtype,j.brhid  from  my_jvtran j inner join gl_rentreceipt r on j.tr_no=r.tr_no and j.cldocno=r.cldocno  where j.cldocno>0 and r.status=3  and j.status=3 and j.rdocno "
						+ "is not null  group by j.rdocno,j.rtype) a group by rdocno,rtype) j left join gl_ragmt r on j.rdocno=r.doc_no and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join gl_ragmtclosem rc on r.doc_no=rc.agmtno "
						+ "left join gl_lagmtclosem lc on l.doc_no=lc.agmtno left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' where secamount!=0  and (r.clstatus=1 or l.clstatus=1)"+sql+" order by rano,rtype";
				//System.out.println("======= "+sql);
				ResultSet resultSet = stmtRefundable.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRefundable.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray clientDetailsSearch(String account,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtAgeingStatement1 = conn.createStatement();
			
	    	    String sql = "";
	    	    
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.doc_no cldocno,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ "and a.dtype='CRM' left join my_curr c on t.curid=c.doc_no where t.atype='AR' and a.status=3 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmtAgeingStatement1.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtAgeingStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
	
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
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
			        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			        	  + "where t.atype='GL' and t.m_s=0 and t.den=305"+sqltest;
		        
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	          stmtBPO.close();
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
	
	public JSONArray balanceGridLoading(String branch,String uptodate,String clientAccount,String agreementType) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlUpToDate = null;
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRefundable = conn.createStatement();
				String sql = "",agreementStatus="0";
				
				if(agreementType.equalsIgnoreCase("OPEN")){
					agreementStatus="0";
				}else{
					agreementStatus="1";
				}
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					sql+=" and j.brhid="+branch+"";
	    		}
				
				if(!(sqlUpToDate==null)){
					sql+=" and (ra.date<='"+sqlUpToDate+"' or l.date<='"+sqlUpToDate+"')";
			    }
				
				if(!(clientAccount.equalsIgnoreCase("0")) && !(clientAccount.equalsIgnoreCase(""))){
					sql+=" and c.acno="+clientAccount+"";
	            }
				
				if(!(agreementType.equalsIgnoreCase(""))){
					if(agreementStatus.equalsIgnoreCase("0")){
						sql+=" and (ra.clstatus="+agreementStatus+" or l.clstatus="+agreementStatus+")";
					}else if(agreementStatus.equalsIgnoreCase("1")){
						sql+=" and (ra.clstatus="+agreementStatus+" or l.clstatus="+agreementStatus+")";
					}
	            }
				
				 //  gl_rentreceipt r left join on r.tr_no=j.tr_no removed for calder imported document 
				  
				sql = "select (sum(j.dramount)*j.id) securityreceived,(sum(j.out_amount)*j.id) securitypaid,((sum(j.dramount)-sum(j.out_amount))*j.id) balance,"  
						+ "if(ra.date is null,l.date,ra.date) radate,if(ra.cldocno is null,l.cldocno,ra.cldocno) cldocno,c.acno clacno,"
						+ "coalesce(rc.date,lc.date) closedate,CONVERT(if(j.rtype='0','',if(j.rtype='RAG',concat(j.rtype,' - ',ra.voc_no)," 
						+ "concat(j.rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,j.brhid,j.rdocno rano,j.rtype,c.refname clientname," 
						+ "if(c.per_mob is null,c.com_mob,c.per_mob) mobile from  my_jvtran j  left join "  
						+ "gl_ragmt ra on j.rdocno=ra.doc_no and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join "  
						+ "gl_ragmtclosem rc on ra.doc_no=rc.agmtno left join gl_lagmtclosem lc on l.doc_no=lc.agmtno left join my_acbook c on "  
						+ "(c.doc_no=ra.cldocno or c.doc_no=l.cldocno)  and c.dtype='CRM' where j.status=3 and j.rdocno is not null and "  
						+ "j.acno=(select t.doc_no from my_account ac inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and "  
						+ "(j.dramount-j.out_amount)!=0"+sql+" group by j.rdocno,j.rtype order by j.rdocno,j.rtype";
				
				ResultSet resultSet = stmtRefundable.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRefundable.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray cardSearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtRefundable = conn.createStatement();
            	
				ResultSet resultSet = stmtRefundable.executeQuery ("SELECT c.doc_no type,m.type cardtype,m.cardno,m.exp_date FROM my_clbankdet m left join my_cardm c on "
						+ "m.type=c.mode and c.id=1 and c.dtype='card'");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRefundable.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < arrayList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] refundArray=arrayList.get(i).split("::");
			
			obj.put("clientname",refundArray[0]);
			obj.put("rano",refundArray[1]);
			obj.put("radate",refundArray[2]);
			obj.put("closedate",refundArray[3]);
			obj.put("invoiceamount",refundArray[4]);
			obj.put("receiptamount",refundArray[5]);
			obj.put("creditnoteamount",refundArray[6]);
			
			jsonArray.add(obj);
		}
		return jsonArray;
		}
	
}
