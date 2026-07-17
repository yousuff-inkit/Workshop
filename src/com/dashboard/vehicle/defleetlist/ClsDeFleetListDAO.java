package com.dashboard.vehicle.defleetlist;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.*;
import com.connection.*;
public class ClsDeFleetListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getDeFleetData(String id,String fromdate,String todate,String branch) throws SQLException
	{
		JSONArray defleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return defleetdata;
		}
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("") && todate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and ret.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and ret.date<='"+sqltodate+"'";
			}
			/*String strsql="select ret.salesprice,ret.date defleetdate,veh.fleet_no,veh.reg_no,veh.flname,veh.prch_cost purcost,veh.residual_val residualval,veh.eng_no engineno,veh.ch_no chassisno,veh.vin from gl_vehreturn ret left join gl_vehmaster veh on (ret.fleetno=veh.fleet_no and ret.defleetstatus=1) where ret.status=3 and ret.defleetstatus=1"+sqltest;*/
			String strsql="select ac.refname,coalesce(if(agmt.per_name=1,(agmt.per_value*12)*coalesce(ltrf.kmrest,0),agmt.per_value*coalesce(ltrf.kmrest,0)),0) contractkm,"+
			" coalesce(mov2.kmin,0) actualkm,ret.salesprice,ret.date defleetdate,veh.fleet_no,veh.reg_no,veh.flname,veh.prch_cost purcost,veh.residual_val residualval,"+
			" veh.eng_no engineno,veh.ch_no chassisno,veh.vin from gl_vehreturn ret left join (select max(doc_no) maxdocno,fleet_no from gl_vmove group by fleet_no) "+
			" mov1 on (ret.fleetno=mov1.fleet_no) left join gl_vmove mov2 on (mov1.maxdocno=mov2.doc_no) left join gl_vehmaster veh on "+
			" (ret.fleetno=veh.fleet_no and ret.defleetstatus=1) left join gl_lagmt agmt on (ret.agmtno=agmt.doc_no) left join gl_ltarif ltrf on "+
			" agmt.doc_no=ltrf.rdocno left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where ret.status=3 and ret.defleetstatus=1"+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			defleetdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return defleetdata;
	}

	public JSONArray getDeFleetExcelData(String id,String fromdate,String todate,String branch) throws SQLException
	{
		JSONArray defleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return defleetdata;
		}
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("") && todate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and ret.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and ret.date<='"+sqltodate+"'";
			}
			/*String strsql="select ret.salesprice,ret.date defleetdate,veh.fleet_no,veh.reg_no,veh.flname,veh.prch_cost purcost,veh.residual_val residualval,veh.eng_no engineno,veh.ch_no chassisno,veh.vin from gl_vehreturn ret left join gl_vehmaster veh on (ret.fleetno=veh.fleet_no and ret.defleetstatus=1) where ret.status=3 and ret.defleetstatus=1"+sqltest;*/
			String strsql="select ac.refname 'Client',veh.fleet_no 'Fleet No',veh.reg_no 'Reg No',ret.date 'Defleeted Date',veh.flname 'Fleet Name',veh.prch_cost 'Purchase Cost',"+
			" veh.residual_val 'Residual Value',ret.salesprice 'Sales Price',veh.eng_no 'Engine No',veh.ch_no 'Chassis No',veh.vin 'VIN No',coalesce(if(agmt.per_name=1,(agmt.per_value*12)*coalesce(ltrf.kmrest,0),agmt.per_value*coalesce(ltrf.kmrest,0)),0) 'Contractual Mileage',"+
					" coalesce(mov2.kmin,0) 'Actual Km' from gl_vehreturn ret left join (select max(doc_no) maxdocno,fleet_no from gl_vmove group by fleet_no) "+
					" mov1 on (ret.fleetno=mov1.fleet_no) left join gl_vmove mov2 on (mov1.maxdocno=mov2.doc_no) left join gl_vehmaster veh on "+
					" (ret.fleetno=veh.fleet_no and ret.defleetstatus=1) left join gl_lagmt agmt on (ret.agmtno=agmt.doc_no) left join gl_ltarif ltrf on "+
					" agmt.doc_no=ltrf.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where ret.status=3 and ret.defleetstatus=1"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			defleetdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return defleetdata;
	}
	public ClsDeFleetListBean getPrint(String fleetno) throws SQLException {
		// TODO Auto-generated method stub
		ClsDeFleetListBean bean=new ClsDeFleetListBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select round(coalesce(mov2.kmin,0),0) actualkm,br.doc_no brdocno,comp.company,comp.address compaddress,br.branchname,comp.tel comptel,comp.fax compfax,concat(ret.doc_no,' - ',year(ret.date)) invoicedoc,date_format(ret.date,'%d-%M-%Y') date,coalesce(ac.refname,'')"+
			" client,coalesce(ac.address,'') pobox,coalesce(ac.address2,'') address,coalesce(ac.per_mob,'') telephone,coalesce(ac.fax1,'') fax,"+
			" coalesce(veh.flname,'') vehicle,coalesce(yom.yom,'') yom,coalesce(veh.vin,'') vin,coalesce(veh.ch_no,'') chassisno,"+
			" coalesce(veh.eng_no,'') engineno,coalesce(clr.color,'') color,coalesce(veh.cur_km,'') mileage,coalesce(round(ret.salesprice,2),'') amount  "+
			" from gl_vehreturn ret left join (select max(doc_no) maxdocno,fleet_no from gl_vmove group by fleet_no) mov1 on (ret.fleetno=mov1.fleet_no) "+
			" left join gl_vmove mov2 on (mov1.maxdocno=mov2.doc_no) left join gl_vehmaster veh on ret.fleetno=veh.fleet_no left join my_acbook ac on (ret.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" left join gl_yom yom on veh.yom=yom.doc_no left join my_color clr on veh.clrid=clr.doc_no left join gl_lagmt agmt on ret.agmtno=agmt.doc_no left join"+
			" my_brch br on agmt.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no where defleetstatus=1 and fleetno="+fleetno;
			ResultSet rs=stmt.executeQuery(strsql);
			int brhid=0;
			while(rs.next()){
				brhid=rs.getInt("brdocno");
				bean.setLblinvoicedoc(rs.getString("invoicedoc"));
				bean.setLbldate(rs.getString("date"));
				bean.setLblclient(rs.getString("client"));
				bean.setLblpobox(rs.getString("pobox"));
				bean.setLbladdress(rs.getString("address"));
				bean.setLbltelephone(rs.getString("telephone"));
				bean.setLblfax(rs.getString("fax"));
				bean.setLblvehicle(rs.getString("vehicle"));
				bean.setLblyear(rs.getString("yom"));
				bean.setLblvin(rs.getString("vin"));
				bean.setLblchassis(rs.getString("chassisno"));
				bean.setLblengine(rs.getString("engineno"));
				bean.setLblcolor(rs.getString("color"));
				bean.setLblmileage(rs.getString("actualkm"));
				bean.setLblamount(rs.getString("amount"));
				bean.setLblcompname(rs.getString("company"));
				bean.setLblbranch(rs.getString("branchname"));
				bean.setLblcomptel(rs.getString("comptel"));
				bean.setLblcompfax(rs.getString("compfax"));
				bean.setLblcompaddress(rs.getString("compaddress"));
			}
			String strlocation="select loc_name from my_locm where doc_no=(select min(doc_no) from my_locm where brhid="+brhid+")";
			ResultSet rslocation=stmt.executeQuery(strlocation);
			while(rslocation.next()){
				bean.setLbllocation(rslocation.getString("loc_name"));
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return bean;
	}
}
