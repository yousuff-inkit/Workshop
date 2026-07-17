package com.dashboard.analysis.customerleaseinvoiceanalysis;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsLeaseAgmtDetailDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getSummaryData(String id,String fromdate,String todate,String status,String branch) throws SQLException{
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
			if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and agmt.clstatus='"+status+"'";
			}
			String strsql="select br.branchname,veh.ch_no,j.acno,agmt.voc_no rano,agmt.larefdocno refno,ac.refname,agmt.outdate contractdate,agmt.perfleet,veh.flname,"
					+ "veh.reg_no, plt.code_name plate,veh.ch_no chassis,if(agmt.clstatus=0,'open','close') AS clstatus,pyttotalrent total,pytadvance advance,"
					+ "(sum(COALESCE((j.dramount),0)))- (sum(COALESCE((j.out_amount),0))) balance,pytmonthno,"
					+ " sum(COALESCE((j.dramount),0)) totalinvoiced,sum(COALESCE((j.out_amount),0)) totalreceived from gl_lagmt agmt"
					+ " left join my_brch br on agmt.brhid=br.doc_no left join my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM')"
					+ " left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join gl_vehplate plt on plt.doc_no=veh.pltid"
					+ " left join gl_leasepytcalc calc on (calc.rdocno=agmt.doc_no )"
					+ " left join my_jvtran j on j.tr_no=calc.trno and j.acno=agmt.acno where 1=1 "+sqltest+"  group by agmt.doc_no;";
			System.out.println("=====main - invoice analysis "+strsql);
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
	
	public JSONArray getExportSummaryData(String id,String fromdate,String todate,String status,String branch) throws SQLException{
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
			if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and agmt.clstatus='"+status+"'";
			}
			String strsql="select br.branchname,veh.ch_no,j.acno,agmt.voc_no rano,agmt.larefdocno refno,ac.refname,agmt.outdate contractdate,agmt.perfleet,veh.flname,"
					+ "veh.reg_no, plt.code_name plate,veh.ch_no chassis,if(agmt.clstatus=0,'open','close') AS clstatus,pyttotalrent total,pytadvance advance,"
					+ "(sum(COALESCE((j.dramount),0)))- (sum(COALESCE((j.out_amount),0))) balance,pytmonthno,"
					+ " sum(j.dramount) totalinvoiced,sum(j.out_amount) totalreceived from gl_lagmt agmt"
					+ " left join my_brch br on agmt.brhid=br.doc_no left join my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM')"
					+ " left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join gl_vehplate plt on plt.doc_no=veh.pltid"
					+ " left join gl_leasepytcalc calc on (calc.rdocno=agmt.doc_no )"
					+ " left join my_jvtran j on j.tr_no=calc.trno and j.acno=agmt.acno where 1=1 "+sqltest+"  group by agmt.doc_no;";
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
	
}
