package com.dashboard.client.clientvehiclemovementlist;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientVehicleMovementListDAO {
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();

public JSONArray getClientVehicleData(String fleetno,String fromdate,String todate,String branch,String id,String check) throws SQLException{

	JSONArray detaildata=new JSONArray();
	if(!(check.equalsIgnoreCase("1"))){
		return detaildata;
	}
	if(!id.equalsIgnoreCase("1") || fleetno.equalsIgnoreCase("")){
		return detaildata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="";
		if(sqlfromdate!=null){
			sqltest+=" and clientmov.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and clientmov.date<='"+sqltodate+"'";
		}
		if(!fleetno.equalsIgnoreCase("")){
			sqltest+=" and clientmov.fleetno="+fleetno;
		}
		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
			sqltest+=" and clientmov.branch="+branch;
		}
		String strsql="select veh.fleet_no,veh.reg_no,agmt.voc_no agmtno,ac.refname,clientmov.drvname driver,mov.opendate,mov.opentime,mov.openkm,CASE WHEN "+
		" mov.openfuel=0.000 THEN 'Level 0/8' WHEN mov.openfuel=0.125 THEN 'Level 1/8' WHEN mov.openfuel=0.250 THEN 'Level 2/8' WHEN mov.openfuel=0.375 THEN 'Level 3/8' "+
		" WHEN mov.openfuel=0.500 THEN 'Level 4/8' WHEN mov.openfuel=0.625 THEN 'Level 5/8' WHEN mov.openfuel=0.750 THEN 'Level 6/8' WHEN mov.openfuel=0.875 THEN "+
		" 'Level 7/8' WHEN mov.openfuel=1.000 THEN 'Level 8/8' END as openfuel,mov.closedate,mov.closetime,mov.closekm,CASE WHEN mov.closefuel=0.000 THEN 'Level 0/8' "+
		" WHEN mov.closefuel=0.125 THEN 'Level 1/8' WHEN mov.closefuel=0.250 THEN 'Level 2/8' WHEN mov.closefuel=0.375 THEN 'Level 3/8' WHEN mov.closefuel=0.500 THEN"+
		" 'Level 4/8' WHEN mov.closefuel=0.625 THEN 'Level 5/8'  WHEN mov.closefuel=0.750 THEN 'Level 6/8' WHEN mov.closefuel=0.875 THEN 'Level 7/8' WHEN "+
		" mov.closefuel=1.000 THEN 'Level 8/8'  END as closefuel,(timestampdiff(hour,timestamp(concat(mov.opendate,' ',mov.opentime)), "+
		" timestamp(concat(mov.closedate,' ',mov.closetime))))/24 daydiff,mov.closekm-mov.openkm kmdiff,CASE WHEN mov.closefuel-mov.openfuel=0.000 THEN 'Level 0/8' "+
		" WHEN mov.closefuel-mov.openfuel=0.125 THEN 'Level 1/8' WHEN mov.closefuel-mov.openfuel=0.250 THEN 'Level 2/8' WHEN mov.closefuel-mov.openfuel=0.375 THEN "+
		" 'Level 3/8' WHEN mov.closefuel-mov.openfuel=0.500 THEN 'Level 4/8' WHEN mov.closefuel-mov.openfuel=0.625 THEN 'Level 5/8'  WHEN mov.closefuel-mov.openfuel=0.750 "+
		" THEN 'Level 6/8' WHEN mov.closefuel-mov.openfuel=0.875 THEN 'Level 7/8' WHEN mov.closefuel-mov.openfuel=1.000 THEN 'Level 8/8'  END as fueldiff from "+
		" gl_clientvehmov clientmov left join gl_vehmaster veh on clientmov.fleetno=veh.fleet_no left join my_acbook ac on (clientmov.cldocno=ac.cldocno and "+
		" ac.dtype='CRM') left join gl_clientmov mov on clientmov.doc_no=mov.rdocno left join gl_lagmt agmt on clientmov.agmtno=agmt.doc_no where 1=1"+sqltest;
		
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

public JSONArray getFleet()throws SQLException{
	JSONArray fleetdata=new JSONArray();
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strsql="select veh.fleet_no,veh.reg_no,concat(brd.brand_name,'  ',model.vtype) name from gl_clientvehmov mov left join gl_vehmaster veh on "+
		" mov.fleetno=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no where veh.statu<>7 "+
		" group by mov.fleetno";
		ResultSet  rs=stmt.executeQuery(strsql);
		fleetdata=objcommon.convertToJSON(rs);
		stmt.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return fleetdata;
}

}