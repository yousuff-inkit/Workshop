package com.dashboard.limousine.closevehassign;

import java.sql.*;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsCloseVehAssignDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getCloseAssignData(String branch,String id)throws SQLException{
		JSONArray assigndata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return assigndata;
		}
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and veh.a_br="+branch;
			}
			String strsql="select coalesce(drv.sal_name,'') driver,assign.movdocno,assign.date outdate,assign.time outtime,assign.km outkm,assign.fuel outfuel,assign.srno assignno,veh.fleet_no,veh.reg_no,auth.authid authority,plate.code_name plate,concat(auth.authid,' ',plate.code_name) platecode,"+
			" brd.brand_name brand,model.vtype model from gl_lvehassign assign inner join gl_vehmaster veh on (assign.fleet_no=veh.fleet_no and"+
			" veh.assign=1 and assign.clstatus=0) left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no "+
			" left join gl_vehauth auth on veh.authid=auth.doc_no left join gl_vehplate plate on veh.pltid=plate.doc_no left join my_salesman drv on (assign.drid=drv.doc_no and drv.sal_type='DRV') where veh.statu=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			assigndata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return assigndata;
	}
    public JSONArray excelCloseAssignData(String branch,String id)throws SQLException{
		JSONArray assigndata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return assigndata;
		}
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and veh.a_br="+branch;
			}
			String strsql="select assign.movdocno,assign.date outdate,assign.time outtime,assign.km outkm,assign.fuel outfuel,assign.srno assignno,veh.fleet_no,veh.reg_no,auth.authid authority,plate.code_name plate,concat(auth.authid,' ',plate.code_name) platecode,"+
			" brd.brand_name brand,model.vtype model from gl_lvehassign assign inner join gl_vehmaster veh on (assign.fleet_no=veh.fleet_no and"+
			" veh.assign=1 and assign.clstatus=0) left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no "+
			" left join gl_vehauth auth on veh.authid=auth.doc_no left join gl_vehplate plate on veh.pltid=plate.doc_no where veh.statu=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			assigndata=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return assigndata;
	}
}
