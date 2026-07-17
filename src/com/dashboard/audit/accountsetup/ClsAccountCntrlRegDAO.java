package com.dashboard.audit.accountsetup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccountCntrlRegDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray accountContrlRegGrid(String brnchval,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		java.sql.Date sqlfromdate = null;
		String sqltest="";
		

		java.sql.Date sqltodate = null;
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			if(id.equalsIgnoreCase("1")) {
				
			String sql="select a.*,'Update' as btnval,h.description accountname,h.account from my_account a left join my_head h on h.doc_no=a.acno ; ";
			//System.out.println("--accountContrlRegGrid--"+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
			stmtVeh.close();

			conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray accountContrlRegExcel(String brnchval,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		java.sql.Date sqlfromdate = null;
		String sqltest="";
		

		java.sql.Date sqltodate = null;
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			if(id.equalsIgnoreCase("1")) {
				
			String sql="select a.codeno Code,a.description Description,h.account as 'Account No',h.description as 'Account Name' from my_account a left join my_head h on h.doc_no=a.acno ; ";
			//System.out.println("--accountContrlRegGrid--"+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			}
			stmtVeh.close();

			conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


}
