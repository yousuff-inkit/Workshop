package com.dashboard.operations.dueforservices;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDueForServicesDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getData(String id) throws SQLException{
		JSONArray duedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return duedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select veh.fleet_no,veh.reg_no,veh.flname,st.st_desc currentstatus,ac.refname,ac.per_mob,rag.voc_no,rag.okm,"+
			" coalesce(veh.calibrationkm,0)+coalesce(veh.cur_km,0) currentkm,if(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0)>coalesce(veh.calibrationkm,0)+"+
			" coalesce(veh.cur_km,0),0,1) duestatus,coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) nextduekm,(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0))-(coalesce(veh.calibrationkm,0)+coalesce(veh.cur_km,0)) dueinkm  from gl_vehmaster veh  left join gl_status st on (veh.tran_code=st.status) left join gl_ragmt rag on"+
			" (veh.tran_code in ('RA','RD','RW','RF','RM') and veh.fleet_no=rag.fleet_no) left join my_acbook ac on (rag.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" where veh.statu=3";
			ResultSet rs=stmt.executeQuery(str);
			duedata=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return duedata;
	}
	
	public JSONArray getExcelData(String id) throws SQLException{
		JSONArray duedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return duedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select veh.fleet_no 'Fleet No',veh.reg_no 'Reg No',veh.flname 'Fleet Name',st.st_desc 'Current Status',ac.refname 'Client Name',ac.per_mob 'Client Mobile',rag.voc_no 'Agmt No',rag.okm 'Out Km',"+
			" coalesce(veh.calibrationkm,0)+coalesce(veh.cur_km,0) 'Current Km',coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) 'Next Due Km',(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0))-(coalesce(veh.calibrationkm,0)+coalesce(veh.cur_km,0)) 'Due In',if(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0)>coalesce(veh.calibrationkm,0)+"+
			" coalesce(veh.cur_km,0),'Not Due','Due Exceeded') 'Due Status'  from gl_vehmaster veh  left join gl_status st on (veh.tran_code=st.status) left join gl_ragmt rag on"+
			" (veh.tran_code in ('RA','RD','RW','RF','RM') and veh.fleet_no=rag.fleet_no) left join my_acbook ac on (rag.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" where veh.statu=3";
			ResultSet rs=stmt.executeQuery(str);
			duedata=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return duedata;
	}
}
