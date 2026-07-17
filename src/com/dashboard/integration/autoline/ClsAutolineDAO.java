package com.dashboard.integration.autoline;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsAutolineDAO {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	public JSONArray autolineGridload(String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
     
        
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				String sqlbrch="";
		        java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
			
			String sqldata="select CHASSIS_NUMBER chassis,VIN_NUMBER vin_no,TRANS_DATE trans_date, "
					+ "REG_NUMBER reg_no,INVOICE_NUMBER invo_no,WIP_NUMBER wip_no,LINE_NUMBER line_no ,"
					+ " LINE_TYPE line_type,LINE_DESCRIPTION line_desc,SELLING_PRICE selling_price, "
					+ " DISCOUNT_AMOUNT discount_amt,NET_PRICE net_price,POS_COMPANY pos_company, "
					+ " MKMAGIC mkmagic,CUSTOMERNAME customer_name,ACCOUNTNO acc_no,VEHICLEMAGIC veh_magic   "
					+ "from gl_autoline where TRANS_DATE between '"+sqlfromdate+"' and '"+sqltodate+"' ;"; 
			
			
			//System.out.println("---sqldata-----"+sqldata);

			
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	//////////////////////////////////////
	public JSONArray autolineExcel(String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				String sqlbrch="";
		        java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
			
			String sqldata="select CHASSIS_NUMBER 'CHASSIS NUMBER', VIN_NUMBER 'VIN NUMBER', REG_NUMBER 'REG NUMBER', TRANS_DATE 'TRANS DATE', INVOICE_NUMBER 'INVOICE NUMBER', WIP_NUMBER 'WIP NUMBER', "
					+ " LINE_NUMBER 'LINE NUMBER',LINE_TYPE 'LINE TYPE', LINE_DESCRIPTION 'LINE DESCRIPTION', SELLING_PRICE 'SELLING PRICE', DISCOUNT_AMOUNT 'DISCOUNT AMOUNT', NET_PRICE 'NET PRICE', POS_COMPANY 'POS COMPANY', MKMAGIC 'MKMAGIC', "
					+ "CUSTOMERNAME, ACCOUNTNO 'ACCOUNT NO', VEHICLEMAGIC 'VEHICLE MAGIC' from gl_autoline where TRANS_DATE between '"+sqlfromdate+"' and '"+sqltodate+"';"; 
			
			
			//System.out.println("---sqldata-----"+sqldata);
 		//	System.out.println("------1-------"+sqldata);

			ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			stmtVeh1.close();
				
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	

}
