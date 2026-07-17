package com.dashboard.operations.nrmlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsNrmListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray fleetSearch(String branch,String searchdate,String fleetno,String docno,String regno,String color,String group,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			conn=ClsConnection.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(searchdate.equalsIgnoreCase(""))){
				sqldate=ClsCommon.changeStringtoSqlDate(searchdate);
			}
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.doc_no like '%"+docno+"%'";
			}
			if(!(fleetno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and v.date='"+sqldate+"'";
				
			}
			if(!(group.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.vgrpid like '%"+group+"%'";
			}
			if(!(color.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.clrid like '%"+color+"%'";
			}
			if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase(""))){
				sqltest+=" and v.a_br="+branch;
			}
				Statement stmtmovement = conn.createStatement ();
	        	String strSql="select v.doc_no,v.date,v.reg_no,v.fleet_no,v.FLNAME,c.color,g.gid from gl_vehmaster v left join my_color c  on v.clrid=c.doc_no "+
				" left join gl_vehgroup g on g.doc_no=v.vgrpid where v.statu <> 7 and v.fstatus in ('L','N') "+sqltest;
	        
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	public JSONArray employeeSearch(String emptype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			conn=ClsConnection.getMyConnection();
			String sqltest="";
			Statement stmtmovement = conn.createStatement ();
        	String strSql="select doc_no,sal_code code,sal_name employee from my_salesman where status<>7 and sal_type='"+emptype+"'";
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtmovement.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	public JSONArray garageSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtmovement = conn.createStatement ();
        	String strSql="select doc_no,code,name from gl_garrage where status<>7 order by doc_no";
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtmovement.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	public JSONArray getNrmList(String temp,String branch,String fromdate,String todate,String fleet,String movtype,String emptype,String employee,String garage,String status) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
		if(!(temp.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtmovement = conn.createStatement ();
			String sqltest="";
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and mv.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and mv.date<='"+sqltodate+"'";
			}
			if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase("a"))){
				sqltest+=" and nrm.brhid="+branch;
			}
			if(!fleet.equalsIgnoreCase("")){
				sqltest+=" and nrm.fleet_no="+fleet;
			}
			if(!movtype.equalsIgnoreCase("")){
				sqltest+=" and nrm.movtype='"+movtype+"'";
			}
			if(!emptype.equalsIgnoreCase("")){
				if(emptype.equalsIgnoreCase("STF")){
					sqltest+=" and nrm.staffid<>0";
				}
				else if(emptype.equalsIgnoreCase("DRV")){
					sqltest+=" and nrm.drid<>0";
				}
			}
			if(!employee.equalsIgnoreCase("")){
				if(emptype.equalsIgnoreCase("STF")){
					sqltest+=" and nrm.staffid="+employee;
				}
				else if(emptype.equalsIgnoreCase("DRV")){
					sqltest+=" and nrm.drid="+employee;
				}
			}
			if(!garage.equalsIgnoreCase("")){
				sqltest+=" and nrm.garageid="+garage;
			}
			if(!status.equalsIgnoreCase("")){
				sqltest+=" and nrm.clstatus="+status;
			}
/*        	
String strSql="select nrm.doc_no,nrm.fleet_no,veh.reg_no,nrm.date,if(nrm.drid<>0,drv.sal_name,stf.sal_name) employee,grg.name garagename,TIMESTAMPDIFF(MINUTE,ADDTIME(minmov.dout, minmov.tout),ADDTIME(maxmov.din, maxmov.tin))/1440 as totaldays,case when"+
        			" nrm.clstatus=0 then 'Open' when nrm.clstatus=1 then 'Closed' end status,st.st_desc movtype,convert(minmov.dout,char(25))"+
        			" outdate,minmov.tout outtime,minmov.kmout outkm,CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8'"+
        			" WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
        			" minmov.fout=0.625 THEN 'Level 5/8'  WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
        			" minmov.fout=1.000 THEN 'Level 8/8' end outfuel,convert(if(nrm.delivery=1,minmov.din,''),char(25)) deldate,"+
        			" if(nrm.delivery=1,minmov.tin,'') deltime,convert(if(nrm.delivery=1,minmov.kmin,''),char(25))"+
        			" delkm,if(nrm.delivery=1,CASE WHEN minmov.fin=0.000 THEN 'Level 0/8' WHEN minmov.fin=0.125 THEN 'Level 1/8'"+
        			" WHEN minmov.fin=0.250 THEN 'Level 2/8' WHEN minmov.fin=0.375 THEN 'Level 3/8' WHEN minmov.fin=0.500 THEN 'Level 4/8' WHEN"+
        			" minmov.fin=0.625 THEN 'Level 5/8'  WHEN minmov.fin=0.750 THEN 'Level 6/8' WHEN minmov.fin=0.875 THEN 'Level 7/8' WHEN"+
        			" minmov.fin=1.000 THEN 'Level 8/8' end ,'') delfuel,convert(if(nrm.collection=1,maxmov.dout,''),char(25))"+
        			" coldate,if(nrm.collection=1,maxmov.tout,'') coltime,convert(if(nrm.collection=1,maxmov.kmout,''),"+
        			" char(25)) colkm,if(nrm.collection=1,CASE WHEN maxmov.fout=0.000 THEN 'Level 0/8' WHEN maxmov.fout=0.125 THEN"+
        			" 'Level 1/8' WHEN maxmov.fout=0.250 THEN 'Level 2/8' WHEN maxmov.fout=0.375 THEN 'Level 3/8' WHEN maxmov.fout=0.500 THEN"+
        			" 'Level 4/8' WHEN maxmov.fout=0.625 THEN 'Level 5/8' WHEN maxmov.fout=0.750 THEN 'Level 6/8'  WHEN maxmov.fout=0.875 THEN"+
        			" 'Level 7/8' WHEN maxmov.fout=1.000 THEN 'Level 8/8' end,'') colfuel,maxmov.din indate,maxmov.tin  intime,maxmov.kmin inkm,CASE"+
        			" WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
        			" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
        			" maxmov.fin=0.750 THEN 'Level 6/8'  WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' end infuel"+
        			"  ,   maxmov.kmin - minmov.kmout AS 'conkm' from gl_nrm nrm left join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') left join gl_vmove minmov"+
        			" on minmov.doc_no=(select min(doc_no) from gl_vmove where rdtype='MOV' and rdocno=nrm.doc_no)"+
        			" left join gl_vmove maxmov on maxmov.doc_no=(select max(doc_no) from gl_vmove where rdtype='MOV' and rdocno=nrm.doc_no)"+
        			" left join gl_status st on (nrm.movtype=st.status and st.mov=1) left join my_salesman drv on  (nrm.drid=drv.doc_no and"+
        			" drv.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') left join gl_vehmaster veh"+
        			" on (nrm.fleet_no=veh.fleet_no) left join gl_garrage grg on nrm.garageid=grg.doc_no where nrm.status<>7 "+sqltest+" group by nrm.doc_no";
*/

		String strSql="select nrm.doc_no,nrm.fleet_no,veh.flname,veh.reg_no,nrm.date,if(nrm.drid<>0,drv.sal_name,stf.sal_name) employee,grg.name garagename,"
					+ "case when nrm.clstatus=0 then 'Open' when nrm.clstatus=1 then 'Closed' end status,st.st_desc movtype,mv.outdate, mv.outtime,"
					+ " mv.outkm, mv.outfuel, mv.deldate, mv.deltime, mv.delkm, mv.delfuel,mv.coldate, mv.coltime, mv.colkm, mv.colfuel, mv.indate,"
					+ " mv.intime, mv.inkm, mv.infuel,mv.totaldays,mv.conkm,mu.user_name ouser,mcl.user_name cuser,nrm.entrytime from gl_nrm nrm "
					+ "left join movement_view mv on nrm.doc_no=mv.doc_no "
					
					+ "left join gl_status st on (nrm.movtype=st.status and st.mov=1) "
					+ "left join my_salesman drv on  (nrm.drid=drv.doc_no and drv.sal_type='DRV') "
					+ "left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF')"
					+ " left join gl_vehmaster veh on (nrm.fleet_no=veh.fleet_no) left join gl_garrage grg on nrm.garageid=grg.doc_no "
					+ "left join my_user mu on mu.doc_no=nrm.userid left join my_user mcl on mcl.doc_no=nrm.closeuserid "
					+ "where nrm.status<>7 "+sqltest+"";

        //	System.out.println("movmnt=="+strSql);
        	ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtmovement.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
public JSONArray getNrmExcelList(String temp,String branch,String fromdate,String todate,String fleet,String movtype,String emptype,String employee,String garage,String status) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
		if(!(temp.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtmovement = conn.createStatement ();
			String sqltest="";
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and mv.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and mv.date<='"+sqltodate+"'";
			}
			if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase("a"))){
				sqltest+=" and nrm.brhid="+branch;
			}
			if(!fleet.equalsIgnoreCase("")){
				sqltest+=" and nrm.fleet_no="+fleet;
			}
			if(!movtype.equalsIgnoreCase("")){
				sqltest+=" and nrm.movtype='"+movtype+"'";
			}
			if(!emptype.equalsIgnoreCase("")){
				if(emptype.equalsIgnoreCase("STF")){
					sqltest+=" and nrm.staffid<>0";
				}
				else if(emptype.equalsIgnoreCase("DRV")){
					sqltest+=" and nrm.drid<>0";
				}
			}
			if(!employee.equalsIgnoreCase("")){
				if(emptype.equalsIgnoreCase("STF")){
					sqltest+=" and nrm.staffid="+employee;
				}
				else if(emptype.equalsIgnoreCase("DRV")){
					sqltest+=" and nrm.drid="+employee;
				}
			}
			if(!garage.equalsIgnoreCase("")){
				sqltest+=" and nrm.garageid="+garage;
			}
			if(!status.equalsIgnoreCase("")){
				sqltest+=" and nrm.clstatus="+status;
			}
        	
/*
String strSql="select nrm.doc_no 'Doc No',nrm.fleet_no 'Fleet No',veh.flname 'Fleet Name',veh.reg_no 'Reg No',nrm.date 'Date',grg.name 'Garage',if(nrm.drid<>0,drv.sal_name,stf.sal_name) 'Employee',case when"+
        			" nrm.clstatus=0 then 'Open' when nrm.clstatus=1 then 'Closed' end 'Status',TIMESTAMPDIFF(MINUTE,ADDTIME(minmov.dout, minmov.tout),ADDTIME(maxmov.din, maxmov.tin))/1440 'Consumption days',st.st_desc 'Type',convert(minmov.dout,char(25))"+
        			" 'Out date',minmov.tout 'Out time',minmov.kmout 'Out km',CASE WHEN minmov.fout=0.000 THEN 'Level 0/8' WHEN minmov.fout=0.125 THEN 'Level 1/8'"+
        			" WHEN minmov.fout=0.250 THEN 'Level 2/8' WHEN minmov.fout=0.375 THEN 'Level 3/8' WHEN minmov.fout=0.500 THEN 'Level 4/8' WHEN"+
        			" minmov.fout=0.625 THEN 'Level 5/8'  WHEN minmov.fout=0.750 THEN 'Level 6/8' WHEN minmov.fout=0.875 THEN 'Level 7/8' WHEN"+
        			" minmov.fout=1.000 THEN 'Level 8/8' end 'Out fuel',convert(if(nrm.movtype in ('GA','GM','GS'),minmov.din,''),char(25)) 'Delivery Date',"+
        			" if(nrm.movtype in ('GA','GM','GS'),minmov.tin,'') 'Delivery Time',convert(if(nrm.movtype in ('GA','GM','GS'),minmov.kmin,''),char(25))"+
        			" 'Delivery km',if(nrm.movtype in ('GA','GM','GS'),CASE WHEN minmov.fin=0.000 THEN 'Level 0/8' WHEN minmov.fin=0.125 THEN 'Level 1/8'"+
        			" WHEN minmov.fin=0.250 THEN 'Level 2/8' WHEN minmov.fin=0.375 THEN 'Level 3/8' WHEN minmov.fin=0.500 THEN 'Level 4/8' WHEN"+
        			" minmov.fin=0.625 THEN 'Level 5/8'  WHEN minmov.fin=0.750 THEN 'Level 6/8' WHEN minmov.fin=0.875 THEN 'Level 7/8' WHEN"+
        			" minmov.fin=1.000 THEN 'Level 8/8' end ,'') 'Delivery fuel',convert(if(nrm.movtype in ('GA','GM','GS'),maxmov.dout,''),char(25))"+
        			" 'Collection Date',if(nrm.movtype in ('GA','GM','GS'),maxmov.tout,'') 'Collection time',convert(if(nrm.movtype in ('GA','GM','GS'),maxmov.kmout,''),"+
        			" char(25)) 'Collection km',if(nrm.movtype in ('GA','GM','GS'),CASE WHEN maxmov.fout=0.000 THEN 'Level 0/8' WHEN maxmov.fout=0.125 THEN"+
        			" 'Level 1/8' WHEN maxmov.fout=0.250 THEN 'Level 2/8' WHEN maxmov.fout=0.375 THEN 'Level 3/8' WHEN maxmov.fout=0.500 THEN"+
        			" 'Level 4/8' WHEN maxmov.fout=0.625 THEN 'Level 5/8' WHEN maxmov.fout=0.750 THEN 'Level 6/8'  WHEN maxmov.fout=0.875 THEN"+
        			" 'Level 7/8' WHEN maxmov.fout=1.000 THEN 'Level 8/8' end,'') 'Collection Fuel',maxmov.din 'In Date',maxmov.tin  'In time',maxmov.kmin 'In km',CASE"+
        			" WHEN maxmov.fin=0.000 THEN 'Level 0/8' WHEN maxmov.fin=0.125 THEN 'Level 1/8' WHEN maxmov.fin=0.250 THEN 'Level 2/8' WHEN"+
        			" maxmov.fin=0.375 THEN 'Level 3/8' WHEN maxmov.fin=0.500 THEN 'Level 4/8' WHEN maxmov.fin=0.625 THEN 'Level 5/8' WHEN"+
        			" maxmov.fin=0.750 THEN 'Level 6/8'  WHEN maxmov.fin=0.875 THEN 'Level 7/8' WHEN maxmov.fin=1.000 THEN 'Level 8/8' end 'In fuel'"+
        			"  ,   maxmov.kmin - minmov.kmout AS 'conkm'from gl_nrm nrm left join gl_vmove mov on (nrm.doc_no=mov.rdocno and mov.rdtype='MOV') left join gl_vmove minmov"+
        			" on minmov.doc_no=(select min(doc_no) from gl_vmove where rdtype='MOV' and rdocno=nrm.doc_no)"+
        			" left join gl_vmove maxmov on maxmov.doc_no=(select max(doc_no) from gl_vmove where rdtype='MOV' and rdocno=nrm.doc_no)"+
        			" left join gl_status st on (nrm.movtype=st.status and st.mov=1) left join my_salesman drv on  (nrm.drid=drv.doc_no and"+
        			" drv.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF') left join gl_vehmaster veh"+
        			" on (nrm.fleet_no=veh.fleet_no) left join gl_garrage grg on nrm.garageid=grg.doc_no where nrm.status<>7 "+sqltest+" group by nrm.doc_no";

*/

		String strSql="select nrm.doc_no 'Doc No',nrm.fleet_no 'Fleet No',veh.reg_no 'Reg No',nrm.date 'Date',if(nrm.drid<>0,drv.sal_name,stf.sal_name) 'Employee',grg.name 'Garage',"
					+ "case when nrm.clstatus=0 then 'Open' when nrm.clstatus=1 then 'Closed' end 'Status',DATE_FORMAT(nrm.entrytime,'%d-%m-%Y %H:%m') 'Entry Date & Time',mu.user_name 'Open User',mcl.user_name 'Close User',mv.totaldays 'Consumption days',mv.conkm 'Consuption KM',st.st_desc 'Type',mv.outdate 'Out Date', mv.outtime 'Out Time',"
					+ " mv.outkm 'Out KM', mv.outfuel 'Out Fuel', mv.deldate 'Delivery Date', mv.deltime 'Delivery Time', mv.delkm 'Delivery KM', mv.delfuel 'Delivery Fuel',mv.coldate 'Collection Date', mv.coltime 'Collection Time', mv.colkm 'Collection KM', mv.colfuel 'Collection Fuel', mv.indate 'In Date',"
					+ " mv.intime 'In Time', mv.inkm 'In KM', mv.infuel 'In fuel' from gl_nrm nrm "
					+ "left join movement_view mv on nrm.doc_no=mv.doc_no "
					
					+ "left join gl_status st on (nrm.movtype=st.status and st.mov=1) "
					+ "left join my_salesman drv on  (nrm.drid=drv.doc_no and drv.sal_type='DRV') "
					+ "left join my_salesman stf on (nrm.staffid=stf.doc_no and stf.sal_type='STF')"
					+ " left join gl_vehmaster veh on (nrm.fleet_no=veh.fleet_no) left join gl_garrage grg on nrm.garageid=grg.doc_no "
					+ "left join my_user mu on mu.doc_no=nrm.userid left join my_user mcl on mcl.doc_no=nrm.closeuserid "
					+ "where nrm.status<>7 "+sqltest+"";

        	//System.out.println(strSql);
        	
        	
        	ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			stmtmovement.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}

}
