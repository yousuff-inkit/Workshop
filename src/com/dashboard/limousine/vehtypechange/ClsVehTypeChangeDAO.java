package com.dashboard.limousine.vehtypechange;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsVehTypeChangeDAO {
	ClsConnection objconn=new ClsConnection();

	ClsCommon objcommon=new ClsCommon();


	public JSONArray getTypeChangeData(String branch,String uptodate,String regno,String brandid,String modelid,String groupid,String id) throws SQLException{
		JSONArray typedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return typedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqldate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and veh.a_br="+branch;
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no="+regno;
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
			if(sqldate!=null){
				sqltest+=" and veh.date<='"+sqldate+"'";
			}
			strsql="select veh.doc_no,veh.date,veh.reg_no,veh.fleet_no,veh.flname,veh.eng_no engineno,veh.ch_no chaseno,brd.brand_name brand,model.vtype model,grp.gname,"+
			" br.branchname availbranch,loc.loc_name availlocation from gl_vehmaster veh left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on "+
			" veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join my_brch br on veh.a_br=br.doc_no left join my_locm loc on "+
			" veh.a_loc=loc.doc_no where statu=3 and veh.limostatus=0 and veh.status='IN' and veh.dtype='VEH'"+sqltest;
		
			ResultSet rs=stmt.executeQuery(strsql);
			typedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return typedata;
	}
	
	
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
public JSONArray excelTypeChangeData(String branch,String uptodate,String regno,String brandid,String modelid,String groupid,String id) throws SQLException{
		JSONArray typedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return typedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqldate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and veh.a_br="+branch;
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no="+regno;
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
			if(sqldate!=null){
				sqltest+=" and veh.date<='"+sqldate+"'";
			}
			strsql="select veh.doc_no,veh.date,veh.reg_no,veh.fleet_no,veh.flname,veh.eng_no engineno,veh.ch_no chaseno,brd.brand_name brand,model.vtype model,grp.gname,"+
			" br.branchname availbranch,loc.loc_name availlocation from gl_vehmaster veh left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on "+
			" veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join my_brch br on veh.a_br=br.doc_no left join my_locm loc on "+
			" veh.a_loc=loc.doc_no where statu=3 and veh.limostatus=0 and veh.status='IN' and veh.dtype='VEH'"+sqltest;
		
			ResultSet rs=stmt.executeQuery(strsql);
			typedata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return typedata;
	}
	
}
