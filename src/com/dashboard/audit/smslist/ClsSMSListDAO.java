package com.dashboard.audit.smslist;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsSMSListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getSMSListData(String fromdate,String todate,String id) throws SQLException{
		JSONArray smsdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return smsdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and date(edate)>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and date(edate)<='"+sqltodate+"'";
			}
			
			//strsql="select edate,replace(replace(replace(replace(replace(replace(replace(message,'+',' '),'%2C',' '),'%3A',':'),'%2F','/'),'%26','&'),'%28','('),'%29',')') message,phone from my_smsbox where 1=1"+sqltest;
			
			strsql="select edate,replace(replace(replace(replace(replace(replace(replace(replace(replace(message,'+',' '),'%2C',' '),'%3A',':'),'%2F','/'),'%26','&'),'%28','('),'%29',')'),'%40','@'),'%23','#') message,phone from my_smsbox where 1=1"+sqltest;
			
		 
		//	System.out.println("==strsql==1===="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			smsdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return smsdata;
	}
}
