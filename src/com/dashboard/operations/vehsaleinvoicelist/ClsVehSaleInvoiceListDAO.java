package com.dashboard.operations.vehsaleinvoicelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehSaleInvoiceListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray detail(String branch,String fromdate,String todate) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "",sql1 = "",sql11 = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and sale.brhid="+branch+"";
	    		}
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and sale.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and sale.date<='"+sqlToDate+"'";
			    }
				
		        String detsql="select saled.sr_no,saled.rdocno doc_no,ac.refname client,saled.fleetno fleet_no ,saled.salesprice,saled.dep_posted,saled.pvalue pur_value,saled.acdep acc_dep,saled.curdep cur_dep,saled.netbook,saled.netval net_pl,veh.flname,concat(veh.reg_no,'-',coalesce(vehp.code_name,'')) reg_no "+
	        			" from gl_vsaled saled left join gl_vehmaster veh on saled.fleetno=veh.fleet_no left join gl_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate vehp on veh.pltid=vehp.doc_no where 1=1 "+sql+" ";
		//		System.out.println("==mm=== "+sql);
				ResultSet resultSet = stmtVehicle.executeQuery(detsql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray detailexcel(String branch,String fromdate,String todate) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "",sql1 = "",sql11 = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and sale.brhid="+branch+"";
	    		}
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and sale.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and sale.date<='"+sqlToDate+"'";
			    }
				
		        String detsql="select saled.sr_no 'Sl No',saled.rdocno 'Doc No',ac.refname 'Client',saled.fleetno 'Fleet No',veh.flname 'Fleet Name',concat(veh.reg_no,'-',coalesce(vehp.code_name,'')) 'Reg No',saled.salesprice 'Sales Price',saled.dep_posted 'Dep Posted',saled.pvalue 'Purchase Value',saled.acdep 'Acc. Dep',saled.curdep 'Current Dep',saled.netbook 'Net Book',saled.netval 'Net P /(L)' "+
	        			" from gl_vsaled saled left join gl_vehmaster veh on saled.fleetno=veh.fleet_no left join gl_vsalem sale on saled.rdocno=sale.doc_no"+
	        			" left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate vehp on veh.pltid=vehp.doc_no where 1=1 "+sql+" ";
		//		System.out.println("==mm=== "+sql);
				ResultSet resultSet = stmtVehicle.executeQuery(detsql);

				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	
	public JSONArray summary(String branch,String fromdate,String todate) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and sale.brhid="+branch+"";
	    		}
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and sale.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and sale.date<='"+sqlToDate+"'";
			    }
				
				sql = "select sale.voc_no doc_no,sale.date,if(sale.type='S','Sale','Total Loss') type,sale.description 'desc',ac.refname 'client',round(sum(coalesce(saled.salesprice,0)),2) total from gl_vsalem sale"
						+ " left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vsaled saled on saled.rdocno=sale.doc_no where 1=1 "+sql+" group by sale.doc_no";
				
				ResultSet resultSet = stmtVehicle.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVehicle.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray summaryexcel(String branch,String fromdate,String todate) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVehicle = conn.createStatement();
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				String sql = "";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and sale.brhid="+branch+"";
	    		}
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and sale.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and sale.date<='"+sqlToDate+"'";
			    }
				
				sql = "select sale.voc_no 'Doc No',sale.date 'Date',ac.refname 'Client',sale.description 'Description',if(sale.type='S','Sale','Total Loss') 'Type',round(sum(coalesce(saled.salesprice,0)),2) 'Total' from gl_vsalem sale"
						+ " left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vsaled saled on saled.rdocno=sale.doc_no where 1=1 "+sql+" group by sale.doc_no";
				
				ResultSet resultSet = stmtVehicle.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtVehicle.close();
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
