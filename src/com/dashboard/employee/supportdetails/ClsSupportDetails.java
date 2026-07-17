package com.dashboard.employee.supportdetails;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSupportDetails  { 
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray supportDetailsGridLoading(String branch,String fromdate,String todate,String company,String userid,String action,String status,String category,String support) throws SQLException {
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
		        	sql+=" and s.date>='"+sqlFromDate+"'";
			        }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and s.date<='"+sqlToDate+"'";
			        }
		        
		        if(!((company.equalsIgnoreCase("")) || (company.equalsIgnoreCase("0")))){
	                sql=sql+" and s.company='"+company+"'";
	            }
		        
		        if(!((userid.equalsIgnoreCase("")) || (userid.equalsIgnoreCase("0")))){
	                sql=sql+" and s.comp_userid='"+userid+"'";
	            }
		        
		        if(!((action.equalsIgnoreCase("")) || (action.equalsIgnoreCase("0")))){
		        	sql=sql+" and s.action_taken='"+action+"'";
	            }
		        
		        if(!((status.equalsIgnoreCase("")) || (status.equalsIgnoreCase("NA")))){
	                sql=sql+" and s.issue_status='"+status+"'";
	            }
		        
		        if(!((category.equalsIgnoreCase("")) || (category.equalsIgnoreCase("0")))){
	                sql=sql+" and s.issue_category='"+category+"'";
	            }
		        
		        if(!((support.equalsIgnoreCase("")) || (support.equalsIgnoreCase("0")))){
	                sql=sql+" and if(s.close_supportid is null,s.open_supportid,s.close_supportid)='"+support+"'";
	            }
            			
				sql = "select s.date,if(close_supportid is null,DATE_FORMAT(open_time,'%h:%i'),DATE_FORMAT(close_time,'%h:%i')) time,concat(upper(c.comp_code)) companycode,"
					+ "concat(upper(u.user_name)) as user,ic.type issue_category,s.issue_description,e.name actionname,s.remarks,if(issue_status='1','OPEN',if(issue_status='2',"
					+ "'PENDING','CLOSED')) status,if(close_supportid is null,e1.name,e2.name) supportname,s.issue_status from gw_supportdetails s left join gw_complist c on "
					+ "s.company=c.doc_no left join gw_userlist u on s.comp_userid=u.doc_no left join gw_issuecategory ic on s.issue_category=ic.doc_no left join gw_employee e "
					+ "on s.action_taken=e.doc_no left join gw_employee e1 on s.open_supportid=e1.doc_no left join gw_employee e2 on s.close_supportid=e2.doc_no where s.status=3"
					+ ""+sql+" order by date desc";
				
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
	
	public JSONArray UserNameLoading(String company) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
    	
   	    Connection conn = null;
   	    
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtESD = conn.createStatement();
            	
				String sql= ("select concat(upper(user_name)) as user,doc_no from gw_userlist where status=3 and comp_id="+company);
				
				ResultSet resultSet = stmtESD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtESD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}

public JSONArray empNameLoading() throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
    	
   	    Connection conn = null;
   	    
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtESD = conn.createStatement();
            	
				String sql= ("select name,doc_no from gw_employee where status=1 and project=1");
				
				ResultSet resultSet = stmtESD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtESD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}

	public JSONArray supportNameLoading() throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		
		    Connection conn = null;
		    
				try {
				conn = ClsConnection.getMyConnection();
				Statement stmtESD = conn.createStatement();
	        	
				String sql= ("select name,doc_no from gw_employee where status=1 and project=0");
				
				ResultSet resultSet = stmtESD.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtESD.close();
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
