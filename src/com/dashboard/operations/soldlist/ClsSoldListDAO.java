package com.dashboard.operations.soldlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSoldListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getSoldList(String fromdate,String todate,String branch,String client,String fleet,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			
		try {	
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				
				if(sqlfromdate!=null){
					sqltest+=" and salem.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and salem.date<='"+sqltodate+"'";
				}
				if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
					sqltest+=" and salem.brhid="+branch;
				}
				if(!client.equalsIgnoreCase("")){
					sqltest+=" and ac.cldocno="+client;
				}
				if(!fleet.equalsIgnoreCase("")){
					sqltest+=" and veh.fleet_no="+fleet;
				}
				conn=ClsConnection.getMyConnection();
				Statement stmtSold = conn.createStatement();
				String strSql="select salem.date saledate,concat(auth.authid,' ',plt.code_name) plate,saled.fleetno,veh.flname,veh.reg_no,ac.refname,saled.salesprice,"+
				" saled.dep_posted,saled.pvalue purcost,saled.acdep accdep,saled.curdep,saled.netval netpl,saled.netbook from gl_vsalem salem left join gl_vsaled saled "+
				" on (salem.doc_no=saled.rdocno) left join gl_vehmaster veh on (saled.fleetno=veh.fleet_no) left join gl_vehauth auth on veh.authid=auth.doc_no left "+
				" join gl_vehplate plt on (veh.pltid=plt.doc_no) left join my_acbook ac on (salem.cldocno=ac.cldocno) where salem.status<>7 "+sqltest+" group by "+
				" saled.rdocno,saled.sr_no";
			//System.out.println(strSql);
				ResultSet resultSet = stmtSold.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtSold.close();
		}
		catch(Exception e){
			e.printStackTrace();
		    return RESULTDATA;
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	
	
	public JSONArray getClient(String name,String cldocno,String telephone,String mobile,String dob,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			
		try {	
				java.sql.Date sqldate=null;
				String sqltest="";
				if(!dob.equalsIgnoreCase("")){
					sqldate=ClsCommon.changeStringtoSqlDate(dob);
				}
				if(!name.equalsIgnoreCase("")){
					sqltest+=" and refname like '%"+name+"%'";
				}
				if(!cldocno.equalsIgnoreCase("")){
					sqltest+=" and cldocno like '%"+cldocno+"%'";
				}
				if(!telephone.equalsIgnoreCase("")){
					sqltest+=" and per_tel like '%"+telephone+"%'";
				}
				if(!mobile.equalsIgnoreCase("")){
					sqltest+=" and per_mob like '%"+mobile+"%'";
				}
				if(sqldate!=null){
					sqltest+=" and date="+sqldate;
				}
				conn=ClsConnection.getMyConnection();
				Statement stmtClient = conn.createStatement();
				String strSql="select cldocno,refname,coalesce(per_tel,'') telephone,coalesce(per_mob,'') mobile,date from my_acbook where status<>7"+sqltest;
				ResultSet resultSet = stmtClient.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtClient.close();
		}
		catch(Exception e){
			e.printStackTrace();
		    return RESULTDATA;
		    
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}

	
	public JSONArray getFleet(String fleetname,String regno,String color,String fleet,String fleetdocno,String fleetdate,String group,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			
		try {	
				java.sql.Date sqldate=null;
				String sqltest="";
				if(!fleetdate.equalsIgnoreCase("")){
					sqldate=ClsCommon.changeStringtoSqlDate(fleetdate);
				}
				if(!fleetname.equalsIgnoreCase("")){
					sqltest+=" and veh.flname like '%"+fleetname+"%'";
				}
				if(!regno.equalsIgnoreCase("")){
					sqltest+=" and veh.reg_no like '%"+regno+"%'";
				}
				if(!color.equalsIgnoreCase("")){
					sqltest+=" and veh.clrid="+color;
				}
				if(!fleet.equalsIgnoreCase("")){
					sqltest+=" and veh.fleet_no like '%"+fleet+"%'";
				}
				if(!fleetdocno.equalsIgnoreCase("")){
					sqltest+=" and veh.doc_no like '%"+fleetdocno+"%'";
				}
				if(sqldate!=null){
					sqltest+=" and veh.date="+sqldate;
				}
				if(!group.equalsIgnoreCase("")){
					sqltest+=" and veh.vgrpid="+group;
				}
				conn=ClsConnection.getMyConnection();
				Statement stmtClient = conn.createStatement();
				String strSql="select veh.doc_no,veh.date,veh.reg_no,veh.fleet_no,veh.flname,clr.color,grp.gname from gl_vsaled saled left join gl_vsalem sale on "+
				" saled.rdocno=sale.doc_no left join gl_vehmaster veh on (saled.fleetno=veh.fleet_no) left join my_color clr on veh.clrid=clr.doc_no left join "+
				" gl_vehgroup grp on veh.vgrpid=grp.doc_no where veh.statu<>7 and sale.status<>7"+sqltest;
				ResultSet resultSet = stmtClient.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtClient.close();
		}
		catch(Exception e){
			e.printStackTrace();
		    return RESULTDATA;   
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}

}
