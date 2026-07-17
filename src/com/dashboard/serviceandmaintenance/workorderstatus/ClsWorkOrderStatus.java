package com.dashboard.serviceandmaintenance.workorderstatus;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsWorkOrderStatus  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray maintenanceDetailsGridLoading(String branch,String fromdate,String todate) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtChqUpdate = conn.createStatement();
			    
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and brhid="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and date<='"+sqlToDate+"'";
			    }
			    
			    sql = "select * from (select 'MAINTENANCE REQUIRED' status,convert(count(*),char(10)) value,'MRQ' dtype from gl_vmcostm where status=3 and dtype='MWO' "
			    		+ "and wostatus=0 and apstatus=0 and psstatus=0"+sql+" UNION ALL "
			    		+ "select 'WORK ORDER' status,convert(count(*),char(10)) value,'MWO' dtype from gl_vmcostm where status=3 and dtype='MWO' and wostatus=1 and "
			    		+ "apstatus=0 and psstatus=0"+sql+" UNION ALL "  
			    		+ "select 'JOB APPROVAL' status,convert(count(*),char(10)) value,'MAP' dtype from gl_vmcostm where status=3 and dtype='MWO' and wostatus=1 and "
			    		+ "apstatus=1 and psstatus=0"+sql+" UNION ALL "  
			    		+ "select 'POSTING' status,convert(count(*),char(10)) value,'MPO' dtype from gl_vmcostm where status=3 and dtype='MWO' and wostatus=1 and "
			    		+ "apstatus=1 and psstatus=1"+sql+" UNION ALL "  
			    		+ "select 'All' status, convert('',char(10)) value,'ALL' dtype) a";
			    
			    ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtChqUpdate.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray workOrderStatusGridLoading(String branch,String fromdate,String todate,String dtype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtChqUpdate = conn.createStatement();
			    
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "",sql1="";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
			    
		        if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
		        	if(dtype.equalsIgnoreCase("MRQ")){
		        		sql1+="'MAINTANENCE REQUIRED' status,";
		        		sql+=" and m.wostatus=0 and m.apstatus=0 and m.psstatus=0";
		        	}else if(dtype.equalsIgnoreCase("MWO")){
		        		sql1+="'WORK ORDER' status,";
		        		sql+=" and m.wostatus=1 and m.apstatus=0 and m.psstatus=0";
		        	}else if(dtype.equalsIgnoreCase("MAP")){
		        		sql1+="'JOB APPROVAL' status,";
		        		sql+=" and m.wostatus=1 and m.apstatus=1 and m.psstatus=0";
		        	}else if(dtype.equalsIgnoreCase("MPO")){
		        		sql1+="'POSTING' status,";
		        		sql+=" and m.wostatus=1 and m.apstatus=1 and m.psstatus=1";
		        	}else{
		        		sql1+="case when m.wostatus=0 and m.apstatus=0 and m.psstatus=0 then 'MAINTANENCE REQUIRED' when m.wostatus=1 and m.apstatus=0 and m.psstatus=0 "
		        				+ "then 'WORK ORDER' when m.wostatus=1 and m.apstatus=1 and m.psstatus=0 then 'JOB APPROVAL' when m.wostatus=1 and m.apstatus=1 and "
		        				+ "m.psstatus=1 then 'POSTING' END as 'status',";
		        	}
	            }
		        
			    sql = "select "+sql1+"m.voc_no docno,m.date,m.fleetno,UCASE(m.mtype) type,v.reg_no,v.flname,g.name garage,b.branchname,CONVERT(CONCAT(m.wostatus,m.apstatus,m.psstatus),CHAR(50)) checks from gl_vmcostm m left join "
			    	+ "gl_vehmaster v on m.fleetno=v.fleet_no left join gl_garrage g on m.gargid=g.doc_no left join my_brch b on m.brhid=b.doc_no where m.status=3 and m.dtype='MWO'"+sql+"";
			    
			    ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtChqUpdate.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray workOrderStatusExcelExport(String branch,String fromdate,String todate,String dtype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtChqUpdate = conn.createStatement();
			    
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "",sql1="";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			    }
			    
		        if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
		        	if(dtype.equalsIgnoreCase("MRQ")){
		        		sql1+="'MAINTANENCE REQUIRED' 'STATUS',";
		        		sql+=" and m.wostatus=0 and m.apstatus=0 and m.psstatus=0";
		        	}else if(dtype.equalsIgnoreCase("MWO")){
		        		sql1+="'WORK ORDER' 'STATUS',";
		        		sql+=" and m.wostatus=1 and m.apstatus=0 and m.psstatus=0";
		        	}else if(dtype.equalsIgnoreCase("MAP")){
		        		sql1+="'JOB APPROVAL' 'STATUS',";
		        		sql+=" and m.wostatus=1 and m.apstatus=1 and m.psstatus=0";
		        	}else if(dtype.equalsIgnoreCase("MPO")){
		        		sql1+="'POSTING' 'STATUS',";
		        		sql+=" and m.wostatus=1 and m.apstatus=1 and m.psstatus=1";
		        	}else{
		        		sql1+="case when m.wostatus=0 and m.apstatus=0 and m.psstatus=0 then 'MAINTANENCE REQUIRED' when m.wostatus=1 and m.apstatus=0 and m.psstatus=0 "
		        				+ "then 'WORK ORDER' when m.wostatus=1 and m.apstatus=1 and m.psstatus=0 then 'JOB APPROVAL' when m.wostatus=1 and m.apstatus=1 and "
		        				+ "m.psstatus=1 then 'POSTING' END as 'STATUS',";
		        	}
	            }
		        
			    sql = "select "+sql1+"m.voc_no 'DOC NO', b.branchname Branch ,m.date 'DATE',m.fleetno 'FLEET',v.reg_no 'REG NO',v.flname 'FLEET NAME',m.mtype 'TYPE',g.name 'GARAGE' from gl_vmcostm m left join "
			    	+ "gl_vehmaster v on m.fleetno=v.fleet_no left join gl_garrage g on m.gargid=g.doc_no  left join my_brch b on m.brhid=b.doc_no where m.status=3 and m.dtype='MWO'"+sql+"";
			    
			    ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
			    stmtChqUpdate.close();
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