package com.dashboard.client.clientvehiclemovement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import net.sf.json.JSONArray;

public class ClsClientVehicleMovementDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public JSONArray getCountData(String fromdate,String todate,String branch,String id,String cldocno) throws SQLException{
		JSONArray countdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return countdata;
		}
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and date<='"+sqltodate+"'";
			}
			String strsql="select 'IN' desc1,count(*) value from gl_lagmt where (perfleet<>0 or tmpfleet<>0) and clstatus<>1 and cldocno="+cldocno+" and clientvehstatus=0 "+sqltest+" union all"+
			" select 'OUT' desc1,count(*) value from gl_lagmt where (perfleet<>0 or tmpfleet<>0) and clstatus<>1 and cldocno="+cldocno+" and clientvehstatus=1 "+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			countdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return countdata;
	}
	
	
	public JSONArray getClient(String client,String mobile,String license,String passport,String nation,String dob,String id) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldob=null;
			if(!dob.equalsIgnoreCase("")){
				sqldob=objcommon.changeStringtoSqlDate(dob);
			}
			if(!client.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+client+"%'";
			}
			if(!mobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+mobile+"%'";
			}
			if(!passport.equalsIgnoreCase("")){
				sqltest+=" and dr.passport_no like '%"+passport+"%'";
			}
			if(!nation.equalsIgnoreCase("")){
				sqltest+=" and dr.nation like '%"+nation+"%'";
			}
			if(sqldob!=null){
				sqltest+=" and dr.dob like '%"+sqldob+"%'";
			}
			String strsql="select distinct ac.cldocno,ac.refname,ac.per_mob,dr.dob,dr.dlno license,dr.nation,dr.passport_no passport from my_acbook ac left join gl_drdetails dr "+
			" on dr.cldocno=ac.cldocno and dr.dtype=ac.dtype where ac.dtype='CRM' and status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
	public JSONArray getDetailData(String client,String desc,String id,String fromdate,String todate) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!client.equalsIgnoreCase("")){
				sqltest+=" and agmt.cldocno="+client;
			}
			if(sqlfromdate!=null){
				sqltest+=" and agmt.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and agmt.date<='"+sqltodate+"'";
			}
			if(desc.equalsIgnoreCase("IN")){
				sqltest+=" and agmt.clientvehstatus=0";
			}
			if(desc.equalsIgnoreCase("OUT")){
				sqltest+=" and agmt.clientvehstatus=1";
			}
/*			strsql="select m.doc_no clientmovdocno,m.drvname driver,m.drvlicense licenseno,m.drvlicenseexp licenseexp,m.drvidno idno,m.drvmobile mobile,clmov.opendate,clmov.opentime,"+
			" clmov.openkm,CASE WHEN clmov.openfuel=0.000 THEN 'Level 0/8' WHEN clmov.openfuel=0.125 THEN 'Level 1/8' WHEN clmov.openfuel=0.250 THEN 'Level 2/8'"+
			" WHEN clmov.openfuel=0.375 THEN 'Level 3/8' WHEN clmov.openfuel=0.500 THEN 'Level 4/8' WHEN clmov.openfuel=0.625 THEN 'Level 5/8'  WHEN clmov.openfuel=0.750"+
			" THEN 'Level 6/8' WHEN clmov.openfuel=0.875 THEN 'Level 7/8' WHEN clmov.openfuel=1.000 THEN 'Level 8/8'  END as openfuel,clmov.closedate,clmov.closetime,"+
			" clmov.closekm,CASE WHEN clmov.closefuel=0.000 THEN 'Level 0/8' WHEN clmov.closefuel=0.125 THEN 'Level 1/8' WHEN clmov.closefuel=0.250 THEN 'Level 2/8'"+
			" WHEN clmov.closefuel=0.375 THEN 'Level 3/8' WHEN clmov.closefuel=0.500 THEN 'Level 4/8' WHEN clmov.closefuel=0.625 THEN 'Level 5/8'  WHEN clmov.closefuel=0.750"+
			" THEN 'Level 6/8' WHEN clmov.closefuel=0.875 THEN 'Level 7/8' WHEN clmov.closefuel=1.000 THEN 'Level 8/8'  END as closefuel,mov.dout movdate,"+
			" mov.tout movtime,mov.fout movfuel,mov.kmout movkm,agmt.doc_no agmtno,agmt.voc_no,agmt.cldocno,ac.refname client,veh.fleet_no,"+
			" concat(brd.brand_name,' ',model.vtype) vehicle,veh.reg_no from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left "+
			" join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel"+
			" model on veh.vmodid=model.doc_no left join gl_vmove mov on (veh.fleet_no=mov.fleet_no and mov.status='OUT') inner join (select max(doc_no) maxdoc,fleet_no "+
			" maxfleet from gl_clientmov group by fleet_no) a on veh.fleet_no=a.maxfleet left join gl_clientmov clmov on a.maxdoc=clmov.doc_no left join gl_clientvehmov m on clmov.rdocno=m.doc_no where (perfleet<>0 or "+
			" tmpfleet<>0) and clstatus<>1 "+sqltest;*/
			strsql="select clmov.opendate,clmov.opentime, clmov.openkm,CASE WHEN clmov.openfuel=0.000 THEN 'Level 0/8' WHEN clmov.openfuel=0.125 THEN 'Level 1/8' WHEN clmov.openfuel=0.250 THEN 'Level 2/8' WHEN clmov.openfuel=0.375 THEN 'Level 3/8' WHEN clmov.openfuel=0.500 THEN 'Level 4/8' WHEN clmov.openfuel=0.625 THEN 'Level 5/8'  WHEN clmov.openfuel=0.750 THEN 'Level 6/8' WHEN clmov.openfuel=0.875 THEN 'Level 7/8' WHEN clmov.openfuel=1.000 THEN 'Level 8/8'  END as openfuel,"+
			" clmov.closedate,clmov.closetime, clmov.closekm,CASE WHEN clmov.closefuel=0.000 THEN 'Level 0/8' WHEN clmov.closefuel=0.125 THEN 'Level 1/8' WHEN clmov.closefuel=0.250 THEN 'Level 2/8' WHEN clmov.closefuel=0.375 THEN 'Level 3/8' WHEN clmov.closefuel=0.500 THEN 'Level 4/8' WHEN clmov.closefuel=0.625 THEN 'Level 5/8'  WHEN clmov.closefuel=0.750 THEN 'Level 6/8' WHEN clmov.closefuel=0.875 THEN 'Level 7/8' WHEN clmov.closefuel=1.000 THEN 'Level 8/8'  END as closefuel,"+
			" m.doc_no clientmovdocno,m.drvname driver,m.drvlicense licenseno,m.drvlicenseexp licenseexp,m.drvidno idno,m.drvmobile mobile,mov.dout movdate, mov.tout movtime,mov.fout movfuel,mov.kmout movkm,agmt.doc_no agmtno,agmt.voc_no,agmt.cldocno,ac.refname client,"+
			" veh.fleet_no, concat(brd.brand_name,' ',model.vtype) vehicle,veh.reg_no from gl_lagmt agmt left join my_acbook ac on"+
			" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left  join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no)"+
			" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vmove mov on"+
			" (veh.fleet_no=mov.fleet_no and mov.status='OUT') left join gl_clientmov clmov on (clmov.fleet_no=veh.fleet_no and clmov.doc_no=(select max(doc_no) from "+
			" gl_clientmov where fleet_no=veh.fleet_no)) left join gl_clientvehmov m on (m.doc_no=clmov.doc_no) where (perfleet<>0 or  tmpfleet<>0) and clstatus<>1"+sqltest;

			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			detaildata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
}
