package com.dashboard.limousine.limovehiclelist;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsLimoVehicleListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getBrand(String id) throws SQLException{
		JSONArray branddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return branddata;
		}
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,brand_name from gl_vehbrand where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			branddata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return branddata;
	}
	
	public JSONArray getModel(String brandid,String id) throws SQLException{
		JSONArray modeldata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return modeldata;
		}
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select model.doc_no,model.vtype,brd.brand_name from gl_vehmodel model left join gl_vehbrand brd on model.brandid=brd.doc_no where model.status=3 and model.brandid="+brandid;
			ResultSet rs=stmt.executeQuery(strsql);
			modeldata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return modeldata;
	}
	
	public JSONArray getGroup(String id) throws SQLException{
		JSONArray groupdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return groupdata;
		}
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,gname from gl_vehgroup where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			groupdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return groupdata;
	}
	
	public JSONArray getVehicleData(String regno,String brandid,String modelid,String groupid,String branch,String id) throws SQLException{
		JSONArray vehdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return vehdata;
		}
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(!brandid.equalsIgnoreCase("")){
				sqltest+=" and veh.brdid="+brandid;
			}
			if(!modelid.equalsIgnoreCase("")){
				sqltest+=" and veh.vmodid="+modelid;
			}
			if(!groupid.equalsIgnoreCase("")){
				sqltest+=" and veh.vgrpid="+groupid;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and veh.a_br="+branch;
			}
			String strsql="select st.st_desc,veh.doc_no,veh.reg_no,veh.fleet_no,veh.flname,veh.eng_no engine,veh.ch_no chassis,veh.tcno,veh.salik_tag saliktag,auth.authname "+
			" authority,plt.code_name platecode,grp.gname,brd.brand_name brand,model.vtype model,clr.color,yom.yom from gl_vehmaster veh left join gl_vehauth auth on "+
			" veh.authid=auth.doc_no left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_vehbrand brd on "+
			" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join my_color clr on veh.clrid=clr.doc_no left join gl_yom yom on"+
			" veh.yom=yom.doc_no left join gl_status st on veh.tran_code=st.status where veh.dtype='LMO' or veh.limostatus=1 and veh.statu=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			vehdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vehdata;
	}
public JSONArray excelVehicleData(String regno,String brandid,String modelid,String groupid,String branch,String id) throws SQLException{
		JSONArray vehdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return vehdata;
		}
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(!brandid.equalsIgnoreCase("")){
				sqltest+=" and veh.brdid="+brandid;
			}
			if(!modelid.equalsIgnoreCase("")){
				sqltest+=" and veh.vmodid="+modelid;
			}
			if(!groupid.equalsIgnoreCase("")){
				sqltest+=" and veh.vgrpid="+groupid;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and veh.a_br="+branch;
			}
			String strsql="select st.st_desc,veh.doc_no,veh.reg_no,veh.fleet_no,veh.flname,veh.eng_no engine,veh.ch_no chassis,veh.tcno,veh.salik_tag saliktag,auth.authname "+
			" authority,plt.code_name platecode,grp.gname,brd.brand_name brand,model.vtype model,clr.color,yom.yom from gl_vehmaster veh left join gl_vehauth auth on "+
			" veh.authid=auth.doc_no left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_vehbrand brd on "+
			" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join my_color clr on veh.clrid=clr.doc_no left join gl_yom yom on"+
			" veh.yom=yom.doc_no left join gl_status st on veh.tran_code=st.status where veh.dtype='LMO' or veh.limostatus=1 and veh.statu=3"+sqltest;
			System.out.println("=== str == "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			vehdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vehdata;
	}
}
