package com.dashboard.trafficfine.othertraffic;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsothertrafficDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public  JSONArray trafficlist(String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqluptodate = null;
      
        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))){
          sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
        Connection conn =null;
        
        try {
        	conn = ClsConnection.getMyConnection();
        	Statement stmtVeh = conn.createStatement();
    
        	
    		String sqls="update gl_traffic t,gl_webcat c set pcolor=itemno where c.codeno=t.pcolor and c.emirate=t.source ";
    		stmtVeh.executeUpdate(sqls);
        	
        	
        	
        	String sql=("select 'Edit' btnsave,v.reg_no,t.regNo,coalesce(t.Source,'') Source,t.TRAFFIC_DATE,round(t.AMOUNT,2) AMOUNT, \r\n" + 
        			"t.Ticket_No,t.pcolor  from  gl_traffic t  left join gl_vehmaster v \r\n" + 
        			"on (V.REG_NO=t.REGNO and t.pcolor=v.pltid)    where  t.status in (0,3 ) and v.reg_no is null and \r\n" + 
        			"t.ISALLOCATED=0  and t.TRAFFIC_DATE<='"+sqluptodate+"' group by t.TICKET_NO");
    
        	ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);

       stmtVeh.close();
       conn.close();
  }
  catch(Exception e){
	  e.printStackTrace();
      conn.close();
  }
    return RESULTDATA;
}
	
	
	
	
	
	
	
}
