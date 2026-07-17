package com.dashboard.accounts.costpandl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCostPAndLDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray costPAndLGridLoading(String branch,String fromdate,String todate,String costtype,String costcode,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql = "",sql1="",casestatement="",joins="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql1+=" and t.brhid="+branch+"";
	    		}
				
				if(!(costtype.equalsIgnoreCase("0")) && !(costtype.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.costtype='"+costtype+"'";
		        }
        		
        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.jobid='"+costcode+"'";
		        }
        		
        		if(costtype.equalsIgnoreCase("3") || costtype.equalsIgnoreCase("4") || costtype.equalsIgnoreCase("5")) {
        			casestatement=" WHEN e.costtype in (3,4) THEN CONCAT('Branch :',src.brhid,' - Doc No. :',src.doc_no)  WHEN e.costtype=5 THEN CONCAT('Branch :',cal.brhid,' - Doc No. :',cal.doc_no) ";
        			joins=" left join cm_srvcontrm src on e.costcode=src.tr_no and e.costtype in (3,4) left join cm_cuscallm cal on e.costcode=cal.tr_no and e.costtype=5";
        		}
        		
        		
			/*	sql = "select e.costtype,CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname) ELSE e.costcode END AS 'costcode',"  
					+ "Convert(if(e.income=0,'',e.income),char(50)) income,Convert(if(e.expenditure=0,'',e.expenditure),char(50)) expenditure,Convert(if(e.netamount=0,'',e.netamount),char(50)) netamount,UPPER(u.costgroup) costgroup from ( select a.costtype,"
					+ "a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)-sum(a.expenditure)),2) netamount,a.gr_type from (select t.costtype,t.costcode,t.acno,t.tr_no, t.ldramount income,"
					+ "0 expenditure,h.gr_type from my_costtran c left join my_jvtran t on c.tranid=t.tranid left join my_head h on h.doc_no=t.acno and h.gr_type=5 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and "
					+ "t.costtype!=1 and t.costcode!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"'"+sql1+" UNION ALL select t.costtype,t.costcode,t.acno,t.tr_no, 0 income,t.ldramount expenditure,h.gr_type from my_costtran c left join "
					+ "my_jvtran t on c.tranid=t.tranid left join my_head h on h.doc_no=t.acno and h.gr_type=4 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and t.costtype!=1 and t.costcode!=0 and t.date<='"+sqlToDate+"' "
					+ "and t.date>='"+sqlFromDate+"'"+sql1+") a group by a.costcode UNION ALL select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income,round(sum(d.expenditure),2) expenditure,round((sum(d.income)-sum(d.expenditure)),2) "
					+ "netamount,d.gr_type from ( select t.costtype,t.costcode,t.acno,t.tr_no,if(h.gr_type=5,t.ldramount,0) income,if(h.gr_type=4,t.ldramount,0) expenditure,h.gr_type from my_costtran c left join my_jvtran t on c.tranid=t.tranid left join "
					+ "my_head h on h.doc_no=t.acno and h.gr_type in (4,5) where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and t.costtype=1 and t.costcode!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"'"+sql1+") d "
					+ "group by d.costcode) e left join my_costunit u on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6";
 */
        		
        		/**
        		 * account wise query
        		 * select acno,h.description,sum(income),sum(expenditure),e.costtype,CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname) WHEN e.costtype='UNALLOCATED' THEN 'UNALLOCATED' ELSE e.costcode END AS 'costcode',Convert(if(e.income=0,'',e.income),char(50)) income,Convert(if(e.expenditure=0,'',e.expenditure),char(50)) expenditure,Convert(if(e.netamount=0,'',e.netamount),char(50)) netamount,UPPER(u.costgroup) costgroup from (select a.costtype,a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)-sum(a.expenditure)),2) netamount,a.gr_type from (select c.costtype,c.jobid costcode,t.acno,t.tr_no, c.amount income,0 expenditure,h.gr_type from  my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno  and h.gr_type=5 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1  and c.jobid!=0 and t.date<='2016-01-31' and t.date>='2016-01-01'   UNION ALL  select c.costtype,c.jobid costcode,t.acno,t.tr_no, 0 income,c.amount expenditure,h.gr_type from my_costtran  c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type=4  where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1 and c.jobid!=0  and t.date<='2016-01-31' and t.date>='2016-01-01'  ) a group by a.costcode,a.acno UNION ALL  select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income, round(sum(d.expenditure),2) expenditure,round((sum(d.income)-sum(d.expenditure)),2) netamount,d.gr_type  from ( select c.costtype,c.jobid costcode,t.acno,t.tr_no,if(h.gr_type=5,c.amount,0) income,  if(h.gr_type=4,c.amount,0) expenditure,h.gr_type from my_costtran c inner join my_jvtran t  on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type in (4,5)  where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype=1 and c.jobid!=0  and t.date<='2016-01-31' and t.date>='2016-01-01'  ) d group by d.costcode,d.acno ) e left join my_costunit u  on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join  gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6  left join my_head h on h.doc_no=acno group by acno;
        		 */
        		
        		sql=" select e.costtype,CONVERT(CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname)"+casestatement+" ELSE e.costcode END,CHAR(1000)) AS 'costcode',"
        				+ "Convert(if(e.income=0,'',e.income*-1),char(100)) income,Convert(if(e.expenditure=0,'',e.expenditure),char(100)) expenditure,Convert(if(e.netamount=0,'',e.netamount*-1),char(100)) netamount,coalesce(UPPER(u.costgroup),'UNALLOCATED') costgroup from ( "
        				+ "select a.costtype,a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)+sum(a.expenditure)),2) netamount,a.gr_type from "
        				+ "(select c.costtype,c.jobid costcode,t.acno,t.tr_no, c.amount income,0 expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno "
        				+ " and h.gr_type=5 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+"  UNION ALL "
        				+ " select c.costtype,c.jobid costcode,t.acno,t.tr_no, 0 income,c.amount expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type=4 "
        				+ " where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) a group by a.costcode UNION ALL "
        				+ " select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income,round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type "
        				+ " from ( select c.costtype,c.jobid costcode,t.acno,t.tr_no,if(h.gr_type=5,c.amount,0) income,if(h.gr_type=4,c.amount,0) expenditure,h.gr_type from my_costtran c inner join my_jvtran t "
        				+ " on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type in (4,5) where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype=1 and c.jobid!=0 "
        				+ " and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) d UNION ALL select * from (select 'UNALLOCATED' costtype, 'UNALLOCATED'  costcode,d.acno,d.tr_no,round(sum(d.income),2) income, "
        				+ " round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type  from (select t.costtype,t.costcode,t.acno,t.tr_no,if(h.gr_type=5,t.dramount-COALESCE(C.AMOUNT,0),0) income,  "
        				+ " if(h.gr_type=4,t.dramount-COALESCE(C.AMOUNT,0),0) expenditure,h.gr_type from my_jvtran t  left join (select sum(amount) amount ,tranid,jobid costcode,costtype from my_costtran  group by tranid) c on c.tranid=t.tranid left join "
        				+ " my_head h on h.doc_no=t.acno   where h.gr_type in (4,5) and t.status=3 and t.trtype!=1 and t.yrid=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"'  )d ) d group by d.costcode) e left join my_costunit u "
        				+ " on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6"+joins+"";
				
				ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtAccountStatement.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray costPAndLExcelExport(String branch,String fromdate,String todate,String costtype,String costcode,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql = "",sql1="",casestatement="",joins="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql1+=" and t.brhid="+branch+"";
	    		}
				
				if(!(costtype.equalsIgnoreCase("0")) && !(costtype.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.costtype='"+costtype+"'";
		        }
        		
        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
		            sql1=sql1+" and c.jobid='"+costcode+"'";
		        }
        		
        		if(costtype.equalsIgnoreCase("3") || costtype.equalsIgnoreCase("4") || costtype.equalsIgnoreCase("5")) {
        			casestatement=" WHEN e.costtype in (3,4) THEN CONCAT('Branch :',src.brhid,' - Doc No. :',src.doc_no)  WHEN e.costtype=5 THEN CONCAT('Branch :',cal.brhid,' - Doc No. :',cal.doc_no) ";
        			joins=" left join cm_srvcontrm src on e.costcode=src.tr_no and e.costtype in (3,4) left join cm_cuscallm cal on e.costcode=cal.tr_no and e.costtype=5";
        		}
        		
        		sql=" select coalesce(UPPER(u.costgroup),'UNALLOCATED') 'Costtype',CONVERT(CASE WHEN e.costtype=1 THEN CONCAT(e.costcode,' - ',cs.description) WHEN e.costtype=6 THEN CONCAT('Fleet No. :',e.costcode,' - Reg No. :',v.reg_no,' - ',v.flname)"+casestatement+" ELSE e.costcode END,CHAR(1000)) AS 'Costcode',"
        				+ "Convert(if(e.income=0,'',e.income*-1),char(100)) 'Income',Convert(if(e.expenditure=0,'',e.expenditure),char(100)) 'Expenditure',Convert(if(e.netamount=0,'',e.netamount*-1),char(100)) 'Netamount' from ( "
        				+ "select a.costtype,a.costcode,a.acno,a.tr_no,round(sum(a.income),2) income,round(sum(a.expenditure),2) expenditure,round((sum(a.income)+sum(a.expenditure)),2) netamount,a.gr_type from "
        				+ "(select c.costtype,c.jobid costcode,t.acno,t.tr_no, c.amount income,0 expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno "
        				+ " and h.gr_type=5 where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+"  UNION ALL "
        				+ " select c.costtype,c.jobid costcode,t.acno,t.tr_no, 0 income,c.amount expenditure,h.gr_type from my_costtran c inner join my_jvtran t on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type=4 "
        				+ " where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype!=1 and c.jobid!=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) a group by a.costcode UNION ALL "
        				+ " select d.costtype,d.costcode,d.acno,d.tr_no,round(sum(d.income),2) income,round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type "
        				+ " from ( select c.costtype,c.jobid costcode,t.acno,t.tr_no,if(h.gr_type=5,c.amount,0) income,if(h.gr_type=4,c.amount,0) expenditure,h.gr_type from my_costtran c inner join my_jvtran t "
        				+ " on c.tranid=t.tranid inner join my_head h on h.doc_no=t.acno and h.gr_type in (4,5) where h.gr_type is not null and t.status=3 and t.trtype!=1 and t.yrid=0 and c.costtype=1 and c.jobid!=0 "
        				+ " and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"' "+sql1+" ) d UNION ALL select * from (select 'UNALLOCATED' costtype, 'UNALLOCATED'  costcode,d.acno,d.tr_no,round(sum(d.income),2) income, "
        				+ " round(sum(d.expenditure),2) expenditure,round((sum(d.income)+sum(d.expenditure)),2) netamount,d.gr_type  from (select t.costtype,t.costcode,t.acno,t.tr_no,if(h.gr_type=5,t.dramount-COALESCE(C.AMOUNT,0),0) income,  "
        				+ " if(h.gr_type=4,t.dramount-COALESCE(C.AMOUNT,0),0) expenditure,h.gr_type from my_jvtran t  left join (select sum(amount) amount ,tranid,jobid costcode,costtype from my_costtran  group by tranid) c on c.tranid=t.tranid left join "
        				+ " my_head h on h.doc_no=t.acno   where h.gr_type in (4,5) and t.status=3 and t.trtype!=1 and t.yrid=0 and t.date<='"+sqlToDate+"' and t.date>='"+sqlFromDate+"'  )d ) d group by d.costcode) e left join my_costunit u "
        				+ " on e.costtype=u.costtype left join my_ccentre cs on cs.doc_no=e.costcode and e.costtype=1 left join gl_vehmaster v on v.fleet_no=e.costcode and e.costtype=6"+joins+"";
				
				ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				
				stmtAccountStatement.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray costCodeDetailsSearch(String type, String costcode, String regno, String costcodename, String check) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCostLedger = conn.createStatement ();
			
				if(check.equalsIgnoreCase("1")) {
					
	        	if(type.equalsIgnoreCase("1")) {
	        		
	        		String sql1="";
	        		
	        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and c1.costcode like '%"+costcode+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and c1.description like '%"+costcodename+"%'";
			        }
	        		
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name from my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0"+sql1+"";
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
	        	
	        	} else if(type.equalsIgnoreCase("6")) {
	        		
	        		String sql1="";
	        		
	        		if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
			            sql1=sql1+" and fleet_no like '%"+costcode+"%'";
			        }
	        		
	        		if(!(regno.equalsIgnoreCase("0")) && !(regno.equalsIgnoreCase(""))){
			            sql1=sql1+" and reg_no like '%"+regno+"%'";
			        }
	        		
	        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
			            sql1=sql1+" and flname like '%"+costcodename+"%'";
			        }
	        		
	        		String sql="select fleet_no doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0"+sql1+"";
	        		ResultSet resultSet = stmtCostLedger.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtCostLedger.close();
					conn.close();
	        	
	        	} else {
	        		
	        		if(!(type.equalsIgnoreCase("0")) && !(type.equalsIgnoreCase(""))){
	        			
	        		String sqls="select costgroup from my_costunit where status=1 and CostType="+type+"";
					ResultSet resultSets = stmtCostLedger.executeQuery(sqls);
				    
					String costgroup="";
					while (resultSets.next()) {
						costgroup=resultSets.getString("costgroup");
					}
					 
					if(costgroup.equalsIgnoreCase("AMC") || costgroup.equalsIgnoreCase("SJOB")) {
						
						String sql1="";
						
						if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
				            sql1=sql1+" and c.doc_no like '%"+costcode+"%'";
				        }
		        		
		        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
				            sql1=sql1+" and a.refname like '%"+costcodename+"%'";
				        }
		        		
						String sql="select c.tr_no doc_no,c.doc_no code,a.refname name from cm_srvcontrm c left join my_acbook a on (c.cldocno=a.doc_no and a.dtype='CRM') "
								+ "where c.status=3 and a.status=3 and c.dtype='"+costgroup+"'"+sql1+"";
						ResultSet resultSet = stmtCostLedger.executeQuery(sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtCostLedger.close();
						conn.close();
						
					} else if(costgroup.equalsIgnoreCase("Ticket No") || costgroup.equalsIgnoreCase("CREG")) {
						
						String sql1="";costgroup="CREG";
						
						if(!(costcode.equalsIgnoreCase("0")) && !(costcode.equalsIgnoreCase(""))){
				            sql1=sql1+" and c.doc_no like '%"+costcode+"%'";
				        }
		        		
		        		if(!(costcodename.equalsIgnoreCase("0")) && !(costcodename.equalsIgnoreCase(""))){
				            sql1=sql1+" and a.refname like '%"+costcodename+"%'";
				        }
		        		
						String sql="select c.tr_no doc_no,c.doc_no code,a.refname name from cm_srvcontrm c left join my_acbook a on (c.cldocno=a.doc_no and a.dtype='CRM') "  
							+ "where c.status=3 and a.status=3 and c.dtype='"+costgroup+"'"+sql1+"";
						
						ResultSet resultSet = stmtCostLedger.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtCostLedger.close();
						conn.close();
					}
	        	  }
	        	}
			}
			conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
}
