package com.dashboard.analysis.vehicleassetregisterreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleAssetRegisterReport  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray vehicleAsssetGridLoading(String branch,String fromdate,String todate,String fleetNo,String group,String model,String check) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();

	    Connection conn = null;
	    
	    try {
				conn=ClsConnection.getMyConnection();
				Statement stmtBVAR = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			        
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			     }
			     
			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			     }
			     String sql="";
			     String strSql="";
			     
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	 sql+=" and d.brhid="+branch+"";
		    	 }
			     
			     if(!((fleetNo.equalsIgnoreCase("")) || (fleetNo.equalsIgnoreCase("0")))){
			    	   sql=sql+"  and d.fleet_no='"+fleetNo+"'";
		         }
	             
			     if(!((group.equalsIgnoreCase("")) || (group.equalsIgnoreCase("0")))){
			    	 	sql=sql+" and d.vgrpid='"+group+"'";
	             }
			     
			     if(!((model.equalsIgnoreCase("")) || (model.equalsIgnoreCase("0")))){
	                     sql=sql+" and d.vmodid='"+model+"'";
	             }
					
				 sql = "SELECT m.fleet_no,m.flname,m.reg_no,m.plate,m.age,m.purdate,m.deprper,m.residualvalue,m.startdate,m.enddate,CONVERT(coalesce(m.contractno, ' '),CHAR(50)) contractno,\r\n" + 
			    		"CONVERT(if(m.asset_opn=0,'',if(m.asset_opn<0,m.asset_opn*-1,m.asset_opn)),CHAR(100)) assetopn,\r\n" + 
			    		"CONVERT(if(m.asset_add=0,'',if(m.asset_add<0,m.asset_add*-1,m.asset_add)),CHAR(100)) assetadd,\r\n" + 
			    		"CONVERT(if(m.asset_del=0,'',if(m.asset_del<0,m.asset_del*-1,m.asset_del)),CHAR(100)) assetdel,\r\n" + 
			    		"CONVERT(if(m.assettotal=0,'',if(m.assettotal<0,m.assettotal*-1,m.assettotal)),CHAR(100)) assettotal,\r\n" + 
			    		"CONVERT(if(m.depr_opn=0,'',if(m.depr_opn<0,m.depr_opn*-1,m.depr_opn)),CHAR(100)) depropn,\r\n" + 
			    		"CONVERT(if(m.depr_add=0,'',m.depr_add*-1),CHAR(100)) depradd,\r\n" + 
			    		"CONVERT(if(m.depr_del=0,'',if(m.depr_del<0,m.depr_del*-1,m.depr_del)),CHAR(100)) deprdel,\r\n" + 
			    		"CONVERT(if(m.deprtotal=0,'',m.deprtotal*-1),CHAR(100)) deprtotal,\r\n" + 
			    		"CONVERT(if(m.nettotal=0,'',if(m.nettotal<0,m.nettotal*-1,m.nettotal)),CHAR(100)) nettotal,\r\n" + 
			    		"CONVERT(if(m.prevyear=0,'',if(m.prevyear<0,m.prevyear*-1,m.prevyear)),CHAR(100)) prevyear FROM (\r\n" + 
			    		"SELECT l.fleet_no,l.flname,l.reg_no,l.plate,l.age,l.purdate,l.asset_opn,l.asset_add,l.asset_del,\r\n" + 
			    		"(l.asset_opn+l.asset_add+l.asset_del) assettotal,l.depr_opn,l.depr_add,l.depr_del,(l.depr_opn+l.depr_add+l.depr_del)  deprtotal,\r\n" + 
			    		"((l.asset_opn+l.asset_add+l.asset_del)+(l.depr_opn+l.depr_add+l.depr_del)) nettotal,(l.asset_opn+l.depr_opn) prevyear,\r\n" + 
			    		"l.fstatus,l.vgrpid,l.vmodid,l.deprper,l.brhid,l.date,l.residualvalue,l.contractno,l.startdate,l.enddate FROM (\r\n" + 
			    		"select d.fleet_no,d.date,round(SUM(d.asset_opn),2) asset_opn,round(SUM(d.asset_add),2) asset_add,round(SUM(d.asset_del),2)\r\n" + 
			    		"asset_del,round(SUM(d.depr_opn),2) depr_opn,round(SUM(d.depr_add),2) depr_add,round(SUM(d.depr_del),2) depr_del,\r\n" + 
			    		"d.flname,d.reg_no,d.prch_dte purdate,((DATEDIFF('"+sqlToDate+"',d.prch_dte)/365)*12) age,d.fstatus,d.vgrpid,d.vmodid,d.deprper,d.residual_val residualvalue,d.brhid,\r\n" + 
			    		"d.code_name plate,lg.voc_no contractno,lg.outdate startdate,\r\n" + 
			    		"if(lg.per_name=1,DATE_ADD(lg.outdate,INTERVAL lg.per_value YEAR),DATE_ADD(lg.outdate,INTERVAL lg.per_value MONTH)) AS enddate from (\r\n" + 
			    		"select a.fleet_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) asset_opn,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'') asset_add,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') asset_del,0.00 depr_opn,\r\n" + 
			    		"0.00 depr_add,0.00 depr_del,v.flname,v.reg_no,v.prch_dte,v.fstatus,v.vgrpid,v.vmodid,v.depr deprper,v.residual_val,a.brhid,p.code_name from gc_assettran a\r\n" + 
			    		"left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on v.pltid=p.doc_no where acno=(select acno from\r\n" + 
			    		"my_account where codeno='VEH')\r\n" + 
			    		"UNION ALL\r\n" + 
			    		"select a.fleet_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) depr_opn,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.ttype='VPO',a.dramount,'') depr_add,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.ttype='VSI',a.dramount,'')  depr_del,\r\n" + 
			    		"v.flname,v.reg_no,v.prch_dte,v.fstatus,v.vgrpid,v.vmodid,v.depr deprper,v.residual_val,a.brhid,p.code_name from gc_assettran a\r\n" + 
			    		"left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on v.pltid=p.doc_no where acno=(select acno from\r\n" + 
			    		"my_account where codeno='VAD')\r\n" + 
			    		") d\r\n" + 
			    		"left join gl_vsaled sd on sd.fleetno=d.fleet_no left join gl_vsalem sm on sm.doc_no=sd.rdocno left join gl_lagmt lg on d.fleet_no=lg.perfleet where coalesce(sm.date,\r\n" + 
			    		"'"+sqlFromDate+"')>='"+sqlFromDate+"' and d.prch_dte<='"+sqlToDate+"'"+sql+" group by d.fleet_no"+strSql+") l ) m";
// System.out.println("==== "+sql);
				ResultSet resultSet = stmtBVAR.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtBVAR.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	
	public JSONArray vehicleDetailedAsssetGridLoading(String branch,String fromdate,String todate,String fleetNo) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();

	    Connection conn = null;
	    
	    try {
				conn=ClsConnection.getMyConnection();
				Statement stmtBVAR = conn.createStatement();
				
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			        
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			     }
			     
			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			     }
			     
			     String sql="";
			     
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	 sql+=" and d.brhid="+branch+"";
		    	 }
			     
				sql="select a.fleet_no,a.date,CONVERT(if(a.dramount>0,a.dramount,''),CHAR(100)) debit,CONVERT(if(a.dramount<0,a.dramount*-1,''),CHAR(100)) credit,"
			    		 + "a.ttype,a.acno,v.reg_no,v.flname,p.code_name,t.description,(select round(coalesce(sum(dramount),0),2) from gc_assettran where fleet_no="+fleetNo+" and "
			    		 + "date<='"+sqlToDate+"') bookvalue from gc_assettran a left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on "
			    		 + "v.pltid=p.doc_no left join my_head t on a.acno=t.doc_no where a.fleet_no="+fleetNo+" and a.date<='"+sqlToDate+"'"+sql+"";
			     
				ResultSet resultSet = stmtBVAR.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBVAR.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray vehicleAsssetExcelExport(String branch,String fromdate,String todate,String fleetNo,String group,String model,String check) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();

	    Connection conn = null;
	    
	    try {
	    	conn=ClsConnection.getMyConnection();
			Statement stmtBVAR = conn.createStatement();
			
			if(check.equalsIgnoreCase("1")){
			
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     String sql="";
		     String strSql="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql+=" and d.brhid="+branch+"";
	    	 }
		     
		     if(!((fleetNo.equalsIgnoreCase("")) || (fleetNo.equalsIgnoreCase("0")))){
		    	   sql=sql+"  and d.fleet_no='"+fleetNo+"'";
	         }
             
		     if(!((group.equalsIgnoreCase("")) || (group.equalsIgnoreCase("0")))){
		    	 	sql=sql+" and d.vgrpid='"+group+"'";
             }
		     
		     if(!((model.equalsIgnoreCase("")) || (model.equalsIgnoreCase("0")))){
                     sql=sql+" and d.vmodid='"+model+"'";
             }
		    
			 sql = "SELECT m.fleet_no 'FLEET NO',m.flname 'FLEET NAME',m.reg_no 'REG NO',m.plate 'PLATE',TRUNCATE(m.age,0) 'AGE(M)',m.deprper 'Depr(%)',m.purdate 'PUR. DATE',\r\n" +
					    "m.residualvalue 'Residual Value',m.startdate 'Start Date',m.enddate 'End Date',CONVERT(coalesce(m.contractno, ' '),CHAR(50)) 'Contract No',\r\n" + 
			    		"CONVERT(if(m.asset_opn=0,'',if(m.asset_opn<0,m.asset_opn*-1,m.asset_opn)),CHAR(100)) 'ASSET(OPN)',\r\n" + 
			    		"CONVERT(if(m.asset_add=0,'',if(m.asset_add<0,m.asset_add*-1,m.asset_add)),CHAR(100)) 'ASSET(ADDITION)',\r\n" + 
			    		"CONVERT(if(m.asset_del=0,'',if(m.asset_del<0,m.asset_del*-1,m.asset_del)),CHAR(100)) 'ASSET(DELETION)',\r\n" + 
			    		"CONVERT(if(m.assettotal=0,'',if(m.assettotal<0,m.assettotal*-1,m.assettotal)),CHAR(100)) 'ASSET_TOTAL',\r\n" + 
			    		"CONVERT(if(m.depr_opn=0,'',if(m.depr_opn<0,m.depr_opn*-1,m.depr_opn)),CHAR(100)) 'DEPR.(OPN)',\r\n" + 
			    		"CONVERT(if(m.depr_add=0,'',m.depr_add*-1),CHAR(100)) 'DEPR.(ADDITION)',\r\n" + 
			    		"CONVERT(if(m.depr_del=0,'',if(m.depr_del<0,m.depr_del*-1,m.depr_del)),CHAR(100)) 'DEPR.(DELETION)',\r\n" + 
			    		"CONVERT(if(m.deprtotal=0,'',m.deprtotal*-1),CHAR(100)) DEPR_TOTAL,\r\n" + 
			    		"CONVERT(if(m.nettotal=0,'',if(m.nettotal<0,m.nettotal*-1,m.nettotal)),CHAR(100)) 'NET TOTAL',\r\n" + 
			    		"CONVERT(if(m.prevyear=0,'',if(m.prevyear<0,m.prevyear*-1,m.prevyear)),CHAR(100)) 'PREVIOUS YEAR' FROM (\r\n" + 
			    		"SELECT l.fleet_no,l.flname,l.reg_no,l.plate,l.age,l.purdate,l.asset_opn,l.asset_add,l.asset_del,\r\n" + 
			    		"(l.asset_opn+l.asset_add+l.asset_del) assettotal,l.depr_opn,l.depr_add,l.depr_del,(l.depr_opn+l.depr_add+l.depr_del)  deprtotal,\r\n" + 
			    		"((l.asset_opn+l.asset_add+l.asset_del)+(l.depr_opn+l.depr_add+l.depr_del)) nettotal,(l.asset_opn+l.depr_opn) prevyear,\r\n" + 
			    		"l.fstatus,l.vgrpid,l.vmodid,l.deprper,l.brhid,l.date,l.residualvalue,l.contractno,l.startdate,l.enddate FROM (\r\n" + 
			    		"select d.fleet_no,d.date,round(SUM(d.asset_opn),2) asset_opn,round(SUM(d.asset_add),2) asset_add,round(SUM(d.asset_del),2)\r\n" + 
			    		"asset_del,round(SUM(d.depr_opn),2) depr_opn,round(SUM(d.depr_add),2) depr_add,round(SUM(d.depr_del),2) depr_del,\r\n" + 
			    		"d.flname,d.reg_no,d.prch_dte purdate,((DATEDIFF('"+sqlToDate+"',d.prch_dte)/365)*12) age,d.fstatus,d.vgrpid,d.vmodid,d.deprper,d.residual_val residualvalue,d.brhid,\r\n" + 
			    		"d.code_name plate,lg.voc_no contractno,lg.outdate startdate,\r\n" + 
			    		"if(lg.per_name=1,DATE_ADD(lg.outdate,INTERVAL lg.per_value YEAR),DATE_ADD(lg.outdate,INTERVAL lg.per_value MONTH)) AS enddate from (\r\n" + 
			    		"select a.fleet_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) asset_opn,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'') asset_add,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') asset_del,0.00 depr_opn,\r\n" + 
			    		"0.00 depr_add,0.00 depr_del,v.flname,v.reg_no,v.prch_dte,v.fstatus,v.vgrpid,v.vmodid,v.depr deprper,v.residual_val,a.brhid,p.code_name from gc_assettran a\r\n" + 
			    		"left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on v.pltid=p.doc_no where acno=(select acno from\r\n" + 
			    		"my_account where codeno='VEH')\r\n" + 
			    		"UNION ALL\r\n" + 
			    		"select a.fleet_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) depr_opn,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.ttype='VPO',a.dramount,'') depr_add,\r\n" + 
			    		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.ttype='VSI',a.dramount,'')  depr_del,\r\n" + 
			    		"v.flname,v.reg_no,v.prch_dte,v.fstatus,v.vgrpid,v.vmodid,v.depr deprper,v.residual_val,a.brhid,p.code_name from gc_assettran a\r\n" + 
			    		"left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on v.pltid=p.doc_no where acno=(select acno from\r\n" + 
			    		"my_account where codeno='VAD')\r\n" + 
			    		") d\r\n" + 
			    		"left join gl_vsaled sd on sd.fleetno=d.fleet_no left join gl_vsalem sm on sm.doc_no=sd.rdocno left join gl_lagmt lg on d.fleet_no=lg.perfleet where coalesce(sm.date,\r\n" + 
			    		"'"+sqlFromDate+"')>='"+sqlFromDate+"' and d.prch_dte<='"+sqlToDate+"'"+sql+" group by d.fleet_no"+strSql+") l ) m";
			 
			ResultSet resultSet = stmtBVAR.executeQuery(sql);
			
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			
			}
			
			stmtBVAR.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray fleetdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
        	conn = ClsConnection.getMyConnection();
        	Statement stmtBVAR = conn.createStatement();
   
            String sql="select fleet_no,flname from gl_vehmaster where statu=3";
            ResultSet resultSet = stmtBVAR.executeQuery(sql);
            
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
           
           stmtBVAR.close();
           conn.close();
       
           }catch(Exception e){
        	   e.printStackTrace();
        	   conn.close();
           }finally{
   			conn.close();
   		}
        return RESULTDATA;
    }
	
	 public JSONArray groupdetails() throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	     Connection conn = null;
	       
	     try {
	    	 conn = ClsConnection.getMyConnection();
	    	 Statement stmtBVAR = conn.createStatement();
	   
	    	 String sql="select gname,doc_no from gl_vehgroup where status=3";
	    	 ResultSet resultSet = stmtBVAR.executeQuery(sql);
	    	 
	         RESULTDATA=ClsCommon.convertToJSON(resultSet);
	         
	     stmtBVAR.close();
	     conn.close();
	 }catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }finally{
			conn.close();
	  }
	      return RESULTDATA;
	}
	 
	   public JSONArray modeldetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn =null;
	       
	        try {
	        	conn = ClsConnection.getMyConnection();
	        	Statement stmtBVAR = conn.createStatement();
	   
	        	String sql="select vtype,doc_no from gl_vehmodel where status=3";
	        	ResultSet resultSet = stmtBVAR.executeQuery(sql);
	        	
	            RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
	     stmtBVAR.close();
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
