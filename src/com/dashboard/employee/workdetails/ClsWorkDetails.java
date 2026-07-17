package com.dashboard.employee.workdetails;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsWorkDetails  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray workDetailsGridLoading(String branch,String fromdate,String todate,String project,String employee,String type) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEWD = conn.createStatement();
				String sql = "";
				
				/*if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and brhId="+branch+"";
	    		}*/
				
				if(!(sqlFromDate==null)){
		        	sql+=" and correction_date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and correction_date<='"+sqlToDate+"'";
			        }
		        
		        if(!((employee.equalsIgnoreCase("")) || (employee.equalsIgnoreCase("0")))){
	                sql=sql+" and emp_name like '%"+employee+"%'";
	            }
		        
		        if(!((project.equalsIgnoreCase("")) || (project.equalsIgnoreCase("0")))){
	                sql=sql+" and project='"+project+"'";
	            }
		        
		        if(!((type.equalsIgnoreCase("")) || (type.equalsIgnoreCase("0")))){
		        	sql=sql+" and correction_type='"+type+"'";
	            }
            			
				sql = "select date(correction_date) date,form_name,detail,correction_type,if(correction_type=1,'New Form',if(correction_type=2,'Modification','Correction')) "
						+ "correctiontype,start_date,end_date,emp_name from gw_empworkdetails where status=3"+sql+" order by date desc";
				
				ResultSet resultSet = stmtEWD.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEWD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray empNameLoading(String project) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
    	
   	    Connection conn = null;
   	    
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEWD = conn.createStatement();
            	
				String sql= ("select name,doc_no from gw_employee where status=1 and project="+project+"");
				
				ResultSet resultSet = stmtEWD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEWD.close();
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
