package com.dashboard.integration.intercompanytransfer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInterCompanyTransferDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray accountDetails(String account, String partyname, String mainAccount, String checkAccount, String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and h.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and h.description like '%"+partyname+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
	        	
				if(checkAccount.equalsIgnoreCase("1")){
					
					sql = "select m.acno doc_no,h.account,h.description,h.curid,c.code currency,round(cb.rate,2) rate,c.type from my_settrfm m left join my_head h on m.acno=h.doc_no left join my_curr c on h.curid=c.doc_no "
						+ "left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where "
						+ "coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on (cb.doc_no=bo.doc_no and cb.curid=bo.curid) where m.status=3"+sql1;
					
				} else if(checkAccount.equalsIgnoreCase("0")){
					
					sql = "select d.acno doc_no,h.account,h.description,h.curid,c.code currency,round(cb.rate,2) rate,c.type from my_settrfm m left join my_settrfd d on "
						+ "m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid "
						+ "inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>=curdate() and "
						+ "frmDate<=curdate() group by cr.curid) as bo on (cb.doc_no=bo.doc_no and cb.curid=bo.curid) where m.status=3 and d.status=3 and m.acno="+mainAccount+""+sql1;
					
				}
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtAccountStatement1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtAccountStatement1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray interCompanyTransferGridLoading(String branch,String uptodate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
       
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
       
        Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, "
						+ "a.currency, a.dramount, a.dr, a.cr, a.ldramount,a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"
						+ ""+casestatement+"b.branchname from ( select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,"
						+ "CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr, ldramount,"
						+ "CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,round((t.rate),2) rate, h.account,"
						+ "h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join ( select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,"
						+ "t.curId, t.dramount , t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and t.trtype!=1 and t.yrid=0  and t.refTrNo=0 and t.acno="+accdocno+" and t.date<='"+sqlUpToDate+"'"+sql+") t "
						+ "on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,"
						+ "(select @i:=0) as i";

				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
}
