package com.dashboard.client.driverlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.clientrelations.client.ClsClientBean;

public class ClsDriverList {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray driverListGridLoading(String branch,String cldocno,String check) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDriverList = conn.createStatement();
				String sql="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and d.branch="+branch+"";
	    		}
				
				if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
					sql+=" and d.cldocno="+cldocno+"";
		        }
				
				ResultSet resultSet = stmtDriverList.executeQuery ("SELECT d.doc_no,d.dr_id,d.sr_no srno,d.name,d.dob,d.nation as nation1,d.mobno,d.passport_no,d.pass_exp,"
						+ "d.dlno,d.issdate,d.issfrm,d.led,d.ltype,d.visano,d.visa_exp,d.hcdlno,d.hcissdate,d.hcled,'Attach' attachbtn,a.refname FROM gl_drdetails d "
						+ "left join my_acbook a on d.doc_no=a.doc_no and a.dtype='CRM' where  d.dtype='CRM' and a.status=3"+sql+" order by d.doc_no");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDriverList.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray driverGridSearch(String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDriverList = conn.createStatement();
            	
				ResultSet resultSet = stmtDriverList.executeQuery ("SELECT nation FROM my_natm order by nation");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDriverList.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public JSONArray stateGridSearch(String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDriverList = conn.createStatement();
            	
				ResultSet resultSet = stmtDriverList.executeQuery ("select state from my_uaestatesm order by state");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDriverList.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray clientDetailsSearch(String clientname,String contact,String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtDriverList = conn.createStatement();
			
	    	    String sql = "";
	    	    
	            if(!(clientname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+clientname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.doc_no,t.description from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ "and a.dtype='CRM' where t.atype='AR' and a.status=3 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmtDriverList.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtDriverList.close();
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
