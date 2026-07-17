package com.dashboard.workshop.evaluationprocessing;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsEvaluationProcessingDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public JSONArray clientDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = objconn.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		
		ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=objcommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	public JSONArray getInvoiceData(String branch,String fromdate,String todate,String cldocno,String id) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
    	Connection conn = null;
		try {
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
	        if(!fromdate.equalsIgnoreCase(""))
	     	{
	     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	     	}
	        if(!todate.equalsIgnoreCase(""))
	     	{
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	     	}
	        String sqltest="";
	        if(sqlfromdate!=null){
	        	sqltest+=" and m.date>='"+sqlfromdate+"'";
	        }
	        if(sqltodate!=null){
	        	sqltest+=" and m.date<='"+sqltodate+"'";
	        }
	        if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
	        	sqltest+=" and m.brhid="+branch;
	        }
	        if(!cldocno.equalsIgnoreCase("")){     
	        	sqltest+=" and m.cldocno="+cldocno;      
	        }
	       
	     	conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			String sql="select ac.refname,m.doc_no, m.voc_no, m.date, m.brhid, carmaker, chassisno, engineno, model, marketprice, billingamt from ws_evalm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' where m.invtrno=0 and m.status=3"+sqltest;
			//System.out.println("grid loading====="+sql);
            ResultSet resultSet = stmt.executeQuery(sql);
            data=objcommon.convertToJSON(resultSet);
 			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }        
}
