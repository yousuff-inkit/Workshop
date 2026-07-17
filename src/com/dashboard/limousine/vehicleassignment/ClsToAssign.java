package com.dashboard.limousine.vehicleassignment;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsToAssign {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray searchVehAssign(String branchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
				if(!(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a"))){
            		sqltest=" and v.a_br='"+branchval+"'";
            	}
            	             	 
            	String sqldata="select mov.fin movfuel,mov.kmin movkm,mov.din movdate,mov.tin movtime,v.flname,v.fleet_no,v.reg_no,p.code_name pltcode,b.brand_name ,m.vtype model from"+
            	" gl_vehmaster v left join gl_vehplate p on v.pltid=p.doc_no left join gl_vehbrand b on v.brdid=b.doc_no left join gl_vehmodel m on "+
            	" v.vmodid=m.doc_no left join gl_vmove mov on (v.fleet_no=mov.fleet_no) inner join (select max(doc_no) maxdocno from gl_vmove group by fleet_no) a "+
            	" on (mov.doc_no=a.maxdocno and mov.fleet_no=v.fleet_no) where v.status='IN' and v.assign=0 and v.limostatus=1 "+sqltest;
            					
				System.out.println("UnAssigned Query:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray searchDriver() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select d.name,d.dob,d.nation,d.mobno,d.dlno,d.issdate,d.led,d.issfrm,d.passport_no,s.doc_no from my_salesman s left join gl_drdetails d on s.sal_type=d.dtype and s.doc_no=d.doc_no\r\n" + 
            			"WHERE s.status=3 and d.dtype='DRV' ";
            					
				//System.out.println("UnRentable Query:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
}





