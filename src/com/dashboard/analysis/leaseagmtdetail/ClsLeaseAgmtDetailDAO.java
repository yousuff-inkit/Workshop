package com.dashboard.analysis.leaseagmtdetail;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsLeaseAgmtDetailDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getSummaryData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray summarydata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return summarydata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and agmt.outdate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and agmt.outdate<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and agmt.doc_no="+branch;
			}
			/*String strsql="select br.branchname,agmt.voc_no rano,agmt.refno,ac.refname,agmt.outdate contractdate,agmt.perfleet,veh.flname,veh.reg_no,"+
			" plt.code_name plate,veh.ch_no chassis,pyttotalrent total,pytadvance advance,pytbalance balance,pytmonthno,count(calc.rdocno) chequecount"+
			" ,sum(calc.amount),sum(ucr.totalamount) postamount,coalesce(sum(calc.amount),0)-coalesce(sum(ucr.totalamount),0) postbalance from gl_lagmt"+
			" agmt left join my_brch br on agmt.brhid=br.doc_no left join my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left"+
			" join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join gl_vehplate plt on plt.doc_no=veh.pltid left join gl_leasepytcalc"+
			" calc on (calc.rdocno=agmt.doc_no and bpvno is not null) left join my_unclrchqreceiptm ucr on (calc.bpvno=ucr.doc_no and"+
			" ucr.bpvno<>0) where 1=1 "+sqltest+" group by agmt.doc_no";*/
			String strsql="select veh.fleet_no,br.branchname,agmt.voc_no rano,agmt.refno,ac.refname,agmt.outdate contractdate,agmt.perfleet,"+
			" veh.flname,veh.reg_no, plt.code_name plate,veh.ch_no chassis,pyttotalrent total,pytadvance advance,pytbalance balance,pytmonthno,"+
			" count(calc.rdocno) chequecount ,sum(calc.amount) unclearedchq,sum(ucr.totalamount) postamount,"+
			" coalesce(sum(calc.amount),0)-coalesce(sum(ucr.totalamount),0) postbalance,veh.fleet_no,"+
			" calc1.amt totalinvoiced,applied totalreceived, pyttotalrent- applied totaltobereceived"+
			" from gl_lagmt agmt left join my_brch br on agmt.brhid=br.doc_no left join my_acbook ac"+
			" on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet"+
			" left join gl_vehplate plt on plt.doc_no=veh.pltid"+
			" left join gl_leasepytcalc calc on (calc.rdocno=agmt.doc_no and bpvno is not null)"+
			" left join my_unclrchqreceiptm ucr on (calc.bpvno=ucr.doc_no and ucr.bpvno<>0)"+
			" left join (select sum(dramount) amt,sum(out_amount) applied,c.rdocno,j.acno from gl_leasepytcalc c"+
			" inner join my_jvtran j on j.tr_no=c.trno   inner join my_head h1 on j.acno=h1.doc_no and atype='ar'"+
			" group by c.rdocno,j.acno) calc1 on (calc1.rdocno=agmt.doc_no )"+
			" where 1=1 "+sqltest+" group by agmt.doc_no";
			System.out.println("===== "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			summarydata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return summarydata;
	}
	
	
	public JSONArray getDetailData(String id,String agmtno) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select calc.date chequedate,calc.amount,calc.bpvno,calc.chequeno,coalesce(ucr.totalamount,0) postamount,coalesce(calc.amount,0)-"+
			" coalesce(ucr.totalamount,0) postbalance from gl_leasepytcalc calc left join my_unclrchqreceiptm ucr on (calc.bpvno=ucr.doc_no and ucr.bpvno<>0) "+
			" where calc.rdocno="+agmtno+" and calc.bpvno is not null and calc.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			detaildata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
	public JSONArray getAgmtData(String client,String mobile,String docno,String mrano,String fleetno,String regno,String branch,String id) throws SQLException{
		JSONArray agmtdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return agmtdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
    			sqltest+=" agmt.brhid="+branch+"";
    		}
        	
        	if(!(client.equalsIgnoreCase(""))){
        		sqltest+=" and ac.RefName like '%"+client+"%'";
        	}
        	if(!(mobile.equalsIgnoreCase(""))){
        		sqltest+=" and ac.per_mob like '%"+mobile+"%'";
        	}
        	if(!(docno.equalsIgnoreCase(""))){
        		sqltest+=" and agmt.voc_no like '%"+docno+"%'";
        	}
        	if(!(fleetno.equalsIgnoreCase(""))){
        		sqltest+=" and agmt.fleet_no like '%"+fleetno+"%'";
        	}
        	if(!(regno.equalsIgnoreCase(""))){
        		sqltest+=" and veh.reg_no like '%"+regno+"%'";
        	}
    
			String strsql="select agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,ac.RefName,ac.per_mob,veh.reg_no from gl_lagmt agmt "+
			" left join gl_vehmaster veh on veh.fleet_no=if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) left join my_acbook ac on "+
			" (ac.cldocno=agmt.cldocno and ac.dtype='CRM') where 1=1 "+sqltest+" group by agmt.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			agmtdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return agmtdata;
	}
	
	public JSONArray getSummaryExcelData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray summarydata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return summarydata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and agmt.outdate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and agmt.outdate<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and agmt.doc_no="+branch;
			}
			String strsql="select br.branchname 'Branch',agmt.voc_no 'LA No',agmt.refno 'Ref No',agmt.outdate 'Contract Date',ac.refname 'Client',veh.fleet_no 'Fleet No',veh.flname 'Fleet',veh.reg_no 'Reg No',plt.code_name 'Plate Code',pyttotalrent 'Total',pytadvance 'Advance',pytbalance 'Balance',count(calc.rdocno) 'No of Cheques',sum(ucr.totalamount) 'BPV Posted',coalesce(sum(calc.amount),0)-coalesce(sum(ucr.totalamount),0) 'BPV To Be Posted',calc1.amt 'Total Invoiced',applied 'Total Recieved',pyttotalrent- applied 'Total Amt To Be Collected' "+
			" from gl_lagmt agmt left join my_brch br on agmt.brhid=br.doc_no left join my_acbook ac"+
			" on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet"+
			" left join gl_vehplate plt on plt.doc_no=veh.pltid"+
			" left join gl_leasepytcalc calc on (calc.rdocno=agmt.doc_no and bpvno is not null)"+
			" left join my_unclrchqreceiptm ucr on (calc.bpvno=ucr.doc_no and ucr.bpvno<>0)"+
			" left join (select sum(dramount) amt,sum(out_amount) applied,c.rdocno,j.acno from gl_leasepytcalc c"+
			" inner join my_jvtran j on j.tr_no=c.trno   inner join my_head h1 on j.acno=h1.doc_no and atype='ar'"+
			" group by c.rdocno,j.acno) calc1 on (calc1.rdocno=agmt.doc_no )"+
			" where 1=1 "+sqltest+" group by agmt.doc_no";
			System.out.println("===== "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			summarydata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return summarydata;
	}
	
	public JSONArray getDetailExcelData(String id,String agmtno) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select calc.date 'Cheque Date',calc.chequeno 'Cheque No',calc.amount 'Amount',calc.bpvno "+
			" 'Reciept No',coalesce(ucr.totalamount,0) 'Posted Amount',coalesce(calc.amount,0)-coalesce(ucr.totalamount,0) "+
			" 'Balance' from gl_leasepytcalc calc left join my_unclrchqreceiptm ucr on (calc.bpvno=ucr.doc_no and "+
			" ucr.bpvno<>0) where calc.rdocno="+agmtno+" and calc.bpvno is not null and calc.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			detaildata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
	
}
