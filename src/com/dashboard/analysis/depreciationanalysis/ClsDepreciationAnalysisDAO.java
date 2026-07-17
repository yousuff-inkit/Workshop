package com.dashboard.analysis.depreciationanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDepreciationAnalysisDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray depreciationAnalysisGridLoading(String branch,String fromdate,String todate,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))) {
			return RESULTDATA;
		}
		
		Connection conn = null;
		
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBDA = conn.createStatement();
			    
				
		        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and a.brhid="+branch+"";
	    		}
			    
			    sql = "select CONVERT(COALESCE(l.voc_no,' '),CHAR(100)) agreement,CONVERT(COALESCE(if(l.chkleaseown=0,'LEASE ONLY',if(l.chkleaseown=1,'LEASE TO OWN',' ')),' '),CHAR(100)) type," 
			    	+ "CONVERT(COALESCE(l.refname,' '),CHAR(100)) client,CONVERT(COALESCE(l.fleet_no,' '),CHAR(100)) fleetno,l.reg_no regno,l.plate platecode,l.brand,l.model,CONVERT(COALESCE(l.outdate,' '),CHAR(100)) leasefromdate,"  
			    	+ "CONVERT(COALESCE(l.leasetodate,' '),CHAR(100)) leasetodate,Convert(coalesce(l.depr_date,l.purdate),CHAR(100)) posteddate,COALESCE(DATEDIFF(l.leasetodate,l.outdate),0) numberofdays," 
			    	+ "round(l.prch_cost,2) vehiclecost,round(l.residual_val,2) residual,round((COALESCE(l.prch_cost,0)-COALESCE(l.residual_val,0)),2) totaldepriciated, l.opndepriciated,l.posted,"
			    	+ "(round((COALESCE(l.prch_cost,0)-COALESCE(l.residual_val,0)),2) + l.opndepriciated + l.posted) balance from ( "  
			    	+ "select b.voc_no,b.chkleaseown,b.outdate,b.cldocno,b.leasetodate, c.refname, a.fleet_no, a.date, a.opndepriciated, a.posted,a.flname, a.reg_no, a.purdate, a.vgrpid, a.vmodid, a.residual_val," 
			    	+ "a.prch_cost, a.depr_date, a.brhid, a.brdid, a.plate,br.brand_name brand,vm.vtype model from ( " 
			    	+ "select d.fleet_no,d.date,round(SUM(d.opndepriciated),2) opndepriciated,round(SUM(d.posted),2) posted,d.flname,d.reg_no,d.prch_dte purdate,d.vgrpid,d.vmodid,d.residual_val,d.prch_cost,d.depr_date,d.brdid," 
			    	+ "d.brhid,d.code_name plate from ( " 
			    	+ "select a.fleet_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0) opndepriciated,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,0) posted,v.flname,v.reg_no,v.prch_dte,v.fstatus,v.vgrpid,"
			    	+ "v.vmodid,v.residual_val,v.prch_cost,v.depr_date, v.brdid,a.brhid,p.code_name from gc_assettran a left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on v.pltid=p.doc_no where v.statu=3 " 
			    	+ "and v.fstatus<>'Z'"+sql+" and acno=(select acno from my_account where codeno='VAD')) d where  d.date<='"+sqlToDate+"' group by d.fleet_no) a left join ( select l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleetno," 
			    	+ "l.chkleaseown,l.outdate,l.cldocno, if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate from ( select max(doc_no) docno from gl_lagmt group by "
			    	+ "if(perfleet=0,tmpfleet,perfleet)) a left join gl_lagmt l on a.docno=l.doc_no ) b on a.fleet_no=b.fleetno left join my_acbook c on b.cldocno=c.cldocno and c.dtype='CRM' left join gl_vehbrand br on a.brdid=br.doc_no "
			    	+ "left join gl_vehmodel vm on a.vmodid=vm.doc_no) l";
			    
			    ResultSet resultSet = stmtBDA.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtBDA.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray depreciationAnalysisExcelExport(String branch,String fromdate,String todate,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))) {
			return RESULTDATA;
		}
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBDA = conn.createStatement();
			    
				
		        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and a.brhid="+branch+"";
	    		}
		        
			    sql = "select CONVERT(COALESCE(l.voc_no,' '),CHAR(100)) 'Agreement',CONVERT(COALESCE(if(l.chkleaseown=0,'LEASE ONLY',if(l.chkleaseown=1,'LEASE TO OWN',' ')),' '),CHAR(100)) 'Type'," 
				    	+ "CONVERT(COALESCE(l.refname,' '),CHAR(100)) 'Client',CONVERT(COALESCE(l.fleet_no,' '),CHAR(100)) 'Fleet',l.reg_no 'Reg No',l.plate 'Plate Code',l.brand 'Brand',l.model 'Model',"
			    		+ "CONVERT(COALESCE(l.outdate,' '),CHAR(100)) 'From',CONVERT(COALESCE(l.leasetodate,' '),CHAR(100)) 'To',Convert(coalesce(l.depr_date,l.purdate),CHAR(100)) 'Posted Till',"
				    	+ "round(l.prch_cost,2) 'Vehicle Cost',round(l.residual_val,2) 'Residual',COALESCE(DATEDIFF(l.leasetodate,l.outdate),0) 'No of Days'," 
				    	+ "round((COALESCE(l.prch_cost,0)-COALESCE(l.residual_val,0)),2) 'Total Depriciated', l.opndepriciated 'Opening Depriciation',l.posted 'Posted',"
				    	+ "(round((COALESCE(l.prch_cost,0)-COALESCE(l.residual_val,0)),2) + l.opndepriciated + l.posted) 'Balance' from ( "  
				    	+ "select b.voc_no,b.chkleaseown,b.outdate,b.cldocno,b.leasetodate, c.refname, a.fleet_no, a.date, a.opndepriciated, a.posted,a.flname, a.reg_no, a.purdate, a.vgrpid, a.vmodid, a.residual_val," 
				    	+ "a.prch_cost, a.depr_date, a.brhid, a.brdid, a.plate,br.brand_name brand,vm.vtype model from ( " 
				    	+ "select d.fleet_no,d.date,round(SUM(d.opndepriciated),2) opndepriciated,round(SUM(d.posted),2) posted,d.flname,d.reg_no,d.prch_dte purdate,d.vgrpid,d.vmodid,d.residual_val,d.prch_cost,d.depr_date,d.brdid," 
				    	+ "d.brhid,d.code_name plate from ( " 
				    	+ "select a.fleet_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0) opndepriciated,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"',a.dramount,0) posted,v.flname,v.reg_no,v.prch_dte,v.fstatus,v.vgrpid,"
				    	+ "v.vmodid,v.residual_val,v.prch_cost,v.depr_date, v.brdid,a.brhid,p.code_name from gc_assettran a left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on v.pltid=p.doc_no where v.statu=3 " 
				    	+ "and v.fstatus<>'Z'"+sql+" and acno=(select acno from my_account where codeno='VAD')) d where  d.date<='"+sqlToDate+"' group by d.fleet_no) a left join ( select l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleetno," 
				    	+ "l.chkleaseown,l.outdate,l.cldocno, if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate from ( select max(doc_no) docno from gl_lagmt group by "
				    	+ "if(perfleet=0,tmpfleet,perfleet)) a left join gl_lagmt l on a.docno=l.doc_no ) b on a.fleet_no=b.fleetno left join my_acbook c on b.cldocno=c.cldocno and c.dtype='CRM' left join gl_vehbrand br on a.brdid=br.doc_no "
				    	+ "left join gl_vehmodel vm on a.vmodid=vm.doc_no) l";
			    
			    
			    ResultSet resultSet = stmtBDA.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
			    stmtBDA.close();
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