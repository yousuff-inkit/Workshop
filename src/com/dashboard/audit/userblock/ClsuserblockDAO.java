package com.dashboard.audit.userblock;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsuserblockDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	

	    public JSONArray userdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	       
	        try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				String sql="select doc_no,user_name,role_id from my_user";
			 		ResultSet resultSet = stmtVeh.executeQuery(sql);
	        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 				stmtVeh.close();
	 				conn.close();
	       
		}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	    
	    
	    public JSONArray getuserDataGrid(String doc_no,String brnchval,String check) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	       if(!(check.equalsIgnoreCase("1"))){
	    	   return RESULTDATA;
	       }
	    	
	    	Connection conn = null;
	    	
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement();
				
					String docno="";
			    	/*
			    	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
			 			sqltest+=" and u.brhid='"+brnchval+"'";
			 		}*/
			    	
			    	if(!((doc_no.equalsIgnoreCase("0")) ||  (doc_no.equalsIgnoreCase("")))){
			 			docno+=" and u.doc_no='"+doc_no+"'";
			 		}
			    	
            	   		String sql =" select u.doc_no,u.user_name,u.date,u.role_id,u.email,convert(concat(' User Id : ',coalesce(u.user_id), ' * ','Username  : ',"
            	   				+ " coalesce(u.user_name)),char(1000)) userinfo from my_user u where u.status=3 and u.block=0 " +
            	   				"	"+docno+"   group by u.doc_no"; 
					
 
 
	                       System.out.println(sql);
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	     				stmtVeh.close();
	     				
	        
	 			
	            	conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println( RESULTDATA);
	        return RESULTDATA;
	    }
	    
	    
	    
	    
	    
	    
	    
	    
	    

}
