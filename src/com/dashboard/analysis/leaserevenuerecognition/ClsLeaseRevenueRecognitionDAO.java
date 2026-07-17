package com.dashboard.analysis.leaserevenuerecognition;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaseRevenueRecognitionDAO {

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
			String sqll="";
			String sql1="",sql2="",sql3="",sql4="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				 sqll = " rev.date<'"+sqlfromdate+"'";
				 sql1 = " a.date<'"+sqlfromdate+"'";
				 sql2 =" a.date>='"+sqlfromdate+"'";
				// sqltest+=" and rev.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				// sqltest+=" and rev.date<='"+sqltodate+"'";
				sql4=" rev.date<='"+sqltodate+"'";
				sql3 =" a.date<='"+sqltodate+"'";
				
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest=" and br.doc_no="+branch;
			}
			/*String strsql="select br.branchname,agmt.voc_no rano,agmt.refno,ac.refname,agmt.outdate contractdate,agmt.perfleet,veh.flname,veh.reg_no,"+
			" plt.code_name plate,veh.ch_no chassis,pyttotalrent total,pytadvance advance,pytbalance balance,pytmonthno,count(calc.rdocno) chequecount"+
			" ,sum(calc.amount),sum(ucr.totalamount) postamount,coalesce(sum(calc.amount),0)-coalesce(sum(ucr.totalamount),0) postbalance from gl_lagmt"+
			" agmt left join my_brch br on agmt.brhid=br.doc_no left join my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left"+
			" join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join gl_vehplate plt on plt.doc_no=veh.pltid left join gl_leasepytcalc"+
			" calc on (calc.rdocno=agmt.doc_no and bpvno is not null) left join my_unclrchqreceiptm ucr on (calc.bpvno=ucr.doc_no and"+
			" ucr.bpvno<>0) where 1=1 "+sqltest+" group by agmt.doc_no";*/
			/*String strsql="select br.branchname,agmt.voc_no rano,agmt.refno,ac.refname,agmt.outdate contractdate,agmt.perfleet,veh.flname,veh.reg_no,"+
			" plt.code_name plate,veh.ch_no chassis,round(coalesce(agmt.pyttotalrent,0),2) total,round(coalesce(sum(rev.amount),0),2) revenuesum,(select round(coalesce(sum(rev.amount),0),2) from gl_lagmt agmt   left join gl_revenuem rev on agmt.doc_no=rev.rdocno where "+sqll+") opening_revenue,"+
			" round(coalesce(agmt.pyttotalrent,0)-coalesce(sum(rev.amount),0),2) balance from gl_lagmt agmt left join my_brch br on agmt.brhid=br.doc_no left join "+
			" my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join gl_vehplate plt on "+
			" plt.doc_no=veh.pltid left join gl_revenuem rev on agmt.doc_no=rev.rdocno where 1=1 "+sqltest+" group by agmt.doc_no";
			*/
			
			/*String strsql="select b.branchname,b.rano,b.refno,b.refname,b.contractdate,b.flname,b.reg_no,b.plate,b.total,"
				     + "b.balance,b.enddate,b.no_of_days,b.doc_no,b.date,round(SUM(b.opening_revenue),2) opening_revenue,round(SUM(b.revenuesum),2) revenuesum from ("
				     + " select a.branchname,a.rano,a.refno,a.refname,a.contractdate,a.flname,a.reg_no,a.plate,a.total,a.balance-if( a.date<'2017-02-21',a.amount,0.00) balance,a.enddate,a.no_of_days,a.doc_no,a.date,if("+sql1+",a.amount,0.00) opening_revenue,if("+sql2+" and "+sql3+" AND a.amount>0,a.amount,'') revenuesum from  ("
				     + "select br.branchname,agmt.voc_no rano,agmt.refno,ac.refname,agmt.outdate contractdate,veh.flname,"
				     + "veh.reg_no,plt.code_name plate,veh.ch_no chassis,round(coalesce(agmt.pyttotalrent,0),2) total,"
				     + "agmt.doc_no,agmt.pyttotalrent,rev.date,rev.amount,round(coalesce(agmt.pyttotalrent,0)-coalesce((rev.amount),0),2) balance,"
				     + "if(agmt.per_name=1,DATE_ADD(agmt.outdate,INTERVAL agmt.per_value YEAR),DATE_ADD(agmt.outdate,INTERVAL agmt.per_value MONTH)) AS enddate,DATEDIFF (if(agmt.per_name=1,"
				     + " DATE_ADD(agmt.outdate,INTERVAL agmt.per_value YEAR),DATE_ADD(agmt.outdate,INTERVAL agmt.per_value MONTH)),agmt.outdate) AS no_of_days from gl_lagmt agmt"
				     + " left join my_brch br on agmt.brhid=br.doc_no"
				     + " left join  my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM')"
				     + " left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet"
				     + " left join gl_vehplate plt on  plt.doc_no=veh.pltid"
				     + " left join gl_revenuem rev on agmt.doc_no=rev.rdocno"
				     + " where "+sql4+" "+sqltest+") a)b group by b.doc_no";*/
			
			String strsql="select fin.*,if((total-revenuesum-opening_revenue)>0,total-revenuesum-opening_revenue,0) balance from"+
			" (select b.branchname,b.rano,b.refno,b.refname,b.contractdate,b.flname,b.reg_no,b.plate,b.total,b.enddate,b.no_of_days,b.doc_no,"+
			" b.date,round(SUM(b.opening_revenue),2) opening_revenue,round(SUM(b.revenuesum),2) revenuesum from"+ 
			" ( select a.branchname,a.rano,a.refno,a.refname,a.contractdate,a.flname,a.reg_no,a.plate,a.total,a.enddate,a.no_of_days,a.doc_no,"+
			" a.date,if( "+sql1+",a.amount,0.00) opening_revenue,if("+sql2+" and "+sql3+" AND a.amount>0,"+
			" a.amount,'') revenuesum from"+  
			" ( select br.branchname,agmt.voc_no rano,agmt.refno,ac.refname,agmt.outdate contractdate,veh.flname,veh.reg_no,plt.code_name plate,"+
			" veh.ch_no chassis,round(coalesce(agmt.pyttotalrent,0),2) total,agmt.doc_no,agmt.pyttotalrent,rev.date,rev.amount,"+
			" if(agmt.per_name=1,DATE_ADD(agmt.outdate,INTERVAL agmt.per_value YEAR),DATE_ADD(agmt.outdate,INTERVAL agmt.per_value MONTH)) AS "+
			" enddate,DATEDIFF (if(agmt.per_name=1, DATE_ADD(agmt.outdate,INTERVAL agmt.per_value YEAR),DATE_ADD(agmt.outdate,INTERVAL "+
			" agmt.per_value MONTH)),agmt.outdate) AS no_of_days from gl_lagmt agmt left join my_brch br on agmt.brhid=br.doc_no left join "+
			" my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join "+
			" gl_vehplate plt on  plt.doc_no=veh.pltid left join gl_revenuem rev on agmt.doc_no=rev.rdocno where  "+sql4+" "+sqltest+") a)b "+
			" group by b.doc_no) fin";
		
			System.out.println(strsql);
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
			
			/*String strsql="select calc.date chequedate,calc.amount,calc.bpvno,calc.chequeno,coalesce(ucr.totalamount,0) postamount,coalesce(calc.amount,0)-"+
			" coalesce(ucr.totalamount,0) postbalance from gl_leasepytcalc calc left join my_unclrchqreceiptm ucr on (calc.bpvno=ucr.doc_no and ucr.bpvno<>0) "+
			" where calc.rdocno="+agmtno+" and calc.bpvno is not null and calc.status=3";*/
			String strsql="select fromdate,todate,amount,rentalamt,accamt,insuramt,chaufamt from gl_revenuem where rdocno="+agmtno;
			System.out.println(strsql);
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
			System.out.println(strsql);
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
	
	
		public JSONArray getDetailExcelData(String id,String agmtno) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select fromdate 'From Date',todate 'To Date',amount 'Amount',rentalamt 'Rental Amount',accamt 'Acc Amount',insuramt 'Insurance Amount',chaufamt 'Chauffer Amount' from gl_revenuem where rdocno="+agmtno;
			System.out.println(strsql);
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
	public JSONArray getSummaryExcelData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray summarydata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return summarydata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			/*Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and rev.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and rev.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and br.doc_no="+branch;
			}
			String strsql="select br.branchname 'Branch',agmt.voc_no 'Agmt No',agmt.refno 'Ref No',ac.refname 'Client',agmt.outdate 'Contract Date',agmt.perfleet "+
			" 'Fleet No',veh.flname 'Fleet Name',veh.reg_no 'Reg No',plt.code_name 'Plate Code',veh.ch_no 'Chassis No',round(coalesce(agmt.pyttotalrent,0),2) 'Total',"+
			" round(coalesce(sum(rev.amount),0),2) 'Revenue',round(coalesce(agmt.pyttotalrent,0)-coalesce(sum(rev.amount),0),2) 'Balance' from gl_lagmt agmt left join my_brch br on agmt.brhid=br.doc_no left join "+
			" my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join gl_vehplate plt on "+
			" plt.doc_no=veh.pltid left join gl_revenuem rev on agmt.doc_no=rev.rdocno where 1=1 "+sqltest+" group by agmt.doc_no";*/
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			String sqll="";
			String sql1="",sql2="",sql3="",sql4="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				 sqll = " rev.date<'"+sqlfromdate+"'";
				 sql1 = " a.date<'"+sqlfromdate+"'";
				 sql2 =" a.date>='"+sqlfromdate+"'";
				// sqltest+=" and rev.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				// sqltest+=" and rev.date<='"+sqltodate+"'";
				sql4=" rev.date<='"+sqltodate+"'";
				sql3 =" a.date<='"+sqltodate+"'";
				
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest=" and br.doc_no="+branch;
			}
			/*fin.*,if((total-revenuesum-opening_revenue)>0,total-revenuesum-opening_revenue,0) balance*/
			String strsql="select fin.branchname 'Branch',fin.rano 'RA No',fin.refno 'Ref No',fin.contractdate 'Contract Date',fin.enddate 'End Date',fin.refname 'Client',fin.flname 'Fleet',fin.reg_no 'Reg No',fin.plate 'Plate',fin.total 'Total',fin.no_of_days 'No Of Days',fin.opening_revenue 'Opening Revenue',fin.revenuesum 'Post Revenue',if((total-revenuesum-opening_revenue)>0,total-revenuesum-opening_revenue,0) 'Balance' from"+
			" (select b.branchname,b.rano,b.refno,b.refname,b.contractdate,b.flname,b.reg_no,b.plate,b.total,b.enddate,b.no_of_days,b.doc_no,"+
			" b.date,round(SUM(b.opening_revenue),2) opening_revenue,round(SUM(b.revenuesum),2) revenuesum from"+ 
			" ( select a.branchname,a.rano,a.refno,a.refname,a.contractdate,a.flname,a.reg_no,a.plate,a.total,a.enddate,a.no_of_days,a.doc_no,"+
			" a.date,if( "+sql1+",a.amount,0.00) opening_revenue,if("+sql2+" and "+sql3+" AND a.amount>0,"+
			" a.amount,'') revenuesum from"+  
			" ( select br.branchname,agmt.voc_no rano,agmt.refno,ac.refname,agmt.outdate contractdate,veh.flname,veh.reg_no,plt.code_name plate,"+
			" veh.ch_no chassis,round(coalesce(agmt.pyttotalrent,0),2) total,agmt.doc_no,agmt.pyttotalrent,rev.date,rev.amount,"+
			" if(agmt.per_name=1,DATE_ADD(agmt.outdate,INTERVAL agmt.per_value YEAR),DATE_ADD(agmt.outdate,INTERVAL agmt.per_value MONTH)) AS "+
			" enddate,DATEDIFF (if(agmt.per_name=1, DATE_ADD(agmt.outdate,INTERVAL agmt.per_value YEAR),DATE_ADD(agmt.outdate,INTERVAL "+
			" agmt.per_value MONTH)),agmt.outdate) AS no_of_days from gl_lagmt agmt left join my_brch br on agmt.brhid=br.doc_no left join "+
			" my_acbook ac on (ac.doc_no=agmt.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on veh.fleet_no=agmt.perfleet left join "+
			" gl_vehplate plt on  plt.doc_no=veh.pltid left join gl_revenuem rev on agmt.doc_no=rev.rdocno where  "+sql4+" "+sqltest+") a)b "+
			" group by b.doc_no) fin";
			System.out.println(strsql);
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
