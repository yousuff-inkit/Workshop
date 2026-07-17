package com.dashboard.accounts.individualageing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIndividualAgeing  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray individualAgeing(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtIndividualAgeing = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="",joins="",casestatement="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql+=" and bk.catid="+category+"";
	    		}
				
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				if(atype.equalsIgnoreCase("AR")){
					condition=" and bk.dtype='CRM'";
					
				sql = "select name,a.contact,a.pmob,CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)<0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'ADVANCE',"
						+ "CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)>0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)),2),''),CHAR(50)) 'BALANCE',CONVERT(if(if(balance<0,"
						+ "round((balance),2),0)<0,round((if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(if(balance>0,balance,0)>0,round((if(balance>0,balance,0)),2),''),CHAR(50)) 'TOTAL',"
						+ "a.date,a.transtype,"+casestatement+"a.acno,a.brhid,a.age,a.description from ("
						+ "select j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
						+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
						+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
						+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
						+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 group by j.tranid having balance<>0 union all "
						+ "select j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
						+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no "
						+ "inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) "
						+ "amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 "
						+ "group by j.tranid having balance<>0) a"+joins+" order by acno,date";

				} else if(atype.equalsIgnoreCase("AP")){
					condition=" and bk.dtype='VND'";
					
					sql = "select name,a.contact,a.pmob,CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)>0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)),2),''),CHAR(50)) 'ADVANCE',"  
							+ "CONVERT(if(if(balance>0,balance,0)+if(balance<0,round((balance),2),0)<0,round((if(balance>0,balance,0)+if(balance<0,round((balance),2),0)*-1),2),''),CHAR(50)) 'BALANCE',CONVERT(if(if(balance>0,"
							+ "round((balance),2),0)>0,round((if(balance>0,round((balance),2),0)),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(if(balance<0,balance,0)<0,round((if(balance<0,balance,0)),2),''),CHAR(50)) 'TOTAL',"
							+ "a.date,a.transtype,"+casestatement+",a.acno,a.brhid,a.age,a.description from ("
							+ "select j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
							+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
							+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
							+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
							+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having balance<>0 union all "
							+ "select j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
							+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no "
							+ "inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) "
							+ "amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 "
							+ "group by j.tranid having balance<>0) a"+joins+" order by acno,date";
					
				}
				
				ResultSet resultSet = stmtIndividualAgeing.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtIndividualAgeing.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray individualAgeingSummary(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql+=" and bk.catid="+category+"";
	    		}
				
		        if(!(sqlUpToDate==null)){
		        	sql+=" and j.date<='"+sqlUpToDate+"'";
			        }
				
				 if(atype.equalsIgnoreCase("AR")){
					condition=" and bk.dtype='CRM'";

					sql = "select name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,"
						+ "round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,"
						+ "round((balance),2),0))>0,round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance<0,"
						+ "round((balance),2),0)<0),round((sum(if(balance<0,round((balance),2),0)*-1)),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(sum(if(balance>0,balance,0))>0,"
						+ "round((sum(if(balance>0,balance,0))),2),''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select j.date,j.dtype,j.doc_no,j.acno,h.description name,"
						+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,"
						+ "sum(dramount) - coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j "
						+ "inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no "
						+ "left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "
						+ "j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" "
						+ "and j.id>0 group by j.tranid having balance<>0 union all select j.date,j.dtype,j.doc_no,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,"
						+ "if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) balance, j.tranid,"
						+ "j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
						+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join "
						+ "(select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
						+ "j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having balance<>0) ag group by acno";
				
		        } else if(atype.equalsIgnoreCase("AP")){
		        	condition=" and bk.dtype='VND'";
		        	
		        	sql = "select name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))>0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance>0,round((balance),2),0)>0),round((sum(if(balance>0,round((balance),2),0))),2),''),CHAR(50)) "
		        			+ "'UNAPPLIED',CONVERT(if(sum(if(balance<0,balance,0))<0,round((sum(if(balance<0,balance,0))),2)*-1,''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select j.date,j.dtype,j.doc_no,j.acno,"
		        			+ "h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description='0','',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
							+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
							+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
							+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
							+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" and j.id<0 group by j.tranid having balance<>0 union all select j.date,j.dtype,j.doc_no,j.acno,h.description name,"
							+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
							+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
							+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,"
							+ "sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' "
							+ "and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 group by j.tranid having balance<>0) ag group by acno";
					
				}
				
				ResultSet resultSet = stmtDayBook.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				
				stmtDayBook.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtIndividualAgeing1 = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmtIndividualAgeing1.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtIndividualAgeing1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
}
