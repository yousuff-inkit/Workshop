package com.dashboard.accounts.costledger;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCostLedgerDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray costLedgerGridLoading(String rpttype, String branch,String fromdate,String todate,String costtype,String costcode,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql = "",sql1="",sql2="",sql3="",sql4="",joins="",casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhid="+branch+"";
	    			sql1+=" and t.brhid="+branch+"";
	    		}
				
				if(!(sqlToDate==null)){
					sql=sql+" and t.date<='"+sqlToDate+"'";
		        } 
            		
				if(rpttype.equalsIgnoreCase("2")) {
					
					sql4 = ", a.debit, a.credit";
					
				} else {
					
					if(!(sqlFromDate==null)){
						sql=sql+" and t.date>='"+sqlFromDate+"'";
				    } 
					
					sql2 = " union all select t.brhid,date('"+sqlFromDate+"') trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId,sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and "
						 + "((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) and t.costtype="+costtype+" and t.costcode="+costcode+""+sql1+" group by t.costcode,t.curId";
						
					sql3 = "group by a.acno";

					sql4 = ", sum(a.debit) debits, sum(a.credit) credits";
					
				}

				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select a.brhid,"+casestatement+"a.transtype,a.trdate, a.description, a.ref_detail, a.tr_no, a.currency"+sql4+", a.rate, a.account, a.accountname,a.acno, b.branchname from ( "
					+ "select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,"
					+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,round((t.rate),2) rate, h.account,h.description accountname,h.doc_no acno from my_head h inner join ( select t.brhid,"
					+ "t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.ldramount, t.rate, t.doc_no transNo,t.dtype transType from my_costtran c left join my_jvtran t on c.tranid=t.tranid "
					+ "where  t.status=3 and t.trtype!=1 and t.costtype="+costtype+" and t.costcode="+costcode+" and t.yrid=0"+sql+""+sql2+") t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,"
					+ "transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+""+sql3+"";
 
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
		        		
		        		String sql="select c.tr_no doc_no,c.doc_no code,a.refname name from cm_cuscallm c left join my_acbook a on (c.cldocno=a.doc_no and a.dtype='CRM') " 
								+ "where c.status=3 and a.status=3 and c.dtype='"+costgroup+"'"+sql1+"";
						ResultSet resultSet = stmtCostLedger.executeQuery(sql);
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
