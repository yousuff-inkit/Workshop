package com.dashboard.leaseagreement.stockvehicles;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.*;
import com.connection.*;
public class ClsStockVehiclesDAO {

	Connection conn=null;
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getVehicleData(String id,String branch) throws SQLException{
		JSONArray vehicledata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return vehicledata;
		}
		try{
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and br.doc_no="+branch;
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select veh.fleet_no,veh.reg_no,veh.flname,veh.prch_dte purdate,veh.prch_cost purcost,veh.eng_no engine,veh.ch_no chassis,br.branchname from"+
			" gl_vehmaster veh left join gl_lagmt agmt on veh.fleet_no=agmt.perfleet left join my_brch br on veh.a_br=br.doc_no where agmt.perfleet is null and veh.fstatus='L' and coalesce(veh.stockrelease,0)<>1 "+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			vehicledata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vehicledata;
	}
	public JSONArray getVehicleDataExcel(String id,String branch) throws SQLException{
		JSONArray vehicledata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return vehicledata;
		}
		try{
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and br.doc_no="+branch;
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select @i:=@i+1 'Sr No',a.fleet_no 'Fleet No',a.branchname 'Branch',a.reg_no 'Reg No',a.flname 'Fleet Name',a.prch_dte 'Purchase Date',a.prch_cost 'Purchase Cost',a.eng_no 'Engine No',a.ch_no 'Chassis No' from (select (SELECT @i:= 0) as i,veh.fleet_no ,br.branchname,veh.reg_no,veh.flname,veh.prch_dte,veh.prch_cost,convert(concat(veh.eng_no,''),char(25)) eng_no,veh.ch_no from"+
			" gl_vehmaster veh left join gl_lagmt agmt on veh.fleet_no=agmt.perfleet left join my_brch br on veh.a_br=br.doc_no where agmt.perfleet is null and veh.fstatus='L' and coalesce(veh.stockrelease,0)<>1 "+sqltest+")a";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			vehicledata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vehicledata;
	}
}
