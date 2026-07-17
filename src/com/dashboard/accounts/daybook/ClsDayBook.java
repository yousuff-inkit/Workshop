package com.dashboard.accounts.daybook;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDayBook  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray dayBook(String branch,String fromdate,String todate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(fromdate.equalsIgnoreCase("0")){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				String sql = "";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			        }
            			
				sql = "select j.doc_no,j.dtype,j.date,j.ref_detail ref,j.description,j.tr_no,round((csh.totalamount),2) total from my_jvtran j left join my_cashbm csh on(j.tr_no=csh.tr_no) "
						+ "where j.status=3 "+sql+" group by tr_no";
				
				ResultSet resultSet = stmtDayBook.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDayBook.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray dayBookGrid(String branch,String fromdate,String todate) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(fromdate.equalsIgnoreCase("0")){
        	return RESULTDATA1;
        }
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
	    try {
			String sql="";	
	    	conn = ClsConnection.getMyConnection();
				Statement stmtDayBook1 = conn.createStatement();
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and jv.brhId="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and jv.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and jv.date<='"+sqlToDate+"'";
			        }
				ResultSet resultSet1 = stmtDayBook1.executeQuery ("select jv.tr_no,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(15)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(15)) cr,"
						+ "CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(15)) drcur,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(15)) crcur,t.description account,c.code currency,round((c.c_rate),2) rate "
						+ "from my_jvtran jv left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 "+sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtDayBook1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
