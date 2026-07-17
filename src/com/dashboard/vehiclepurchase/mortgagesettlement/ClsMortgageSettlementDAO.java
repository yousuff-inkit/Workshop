package com.dashboard.vehiclepurchase.mortgagesettlement;

import java.sql.*;

import net.sf.json.JSONArray;

import com.connection.*;
import com.common.*;
public class ClsMortgageSettlementDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
	public JSONArray getMortgageData(String fromdate,String todate,String id,String purchasedocno) throws SQLException{
		JSONArray mortgagedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return mortgagedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!purchasedocno.equalsIgnoreCase("")){
				sqltest+=" and d.rdocno="+purchasedocno;
				
			}
			String strsql="select if(m.bpvno=0,0,1) poststatus,0 editstatus,1 defaultrow,m.doc_no ucrdocno,d.rowno detaildocno,d.rdocno purchasedocno, d.date, d.pramt principalamt,d.intstamt interestamt, d.totamt amount,"+
			" convert(coalesce(m.chqno,''),char(50)) chequeno,d.bpvno  from gl_vpurdetd d  left join my_unclrchqbm m on m.doc_no=d.bpvno"+
			" where 1=1 and m.status=3"+sqltest+" order by d.date";
			ResultSet rs=stmt.executeQuery(strsql);
			mortgagedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return mortgagedata;
	}
	
	public JSONArray getPurchaseSearchData(String branch) throws SQLException{
		
		JSONArray purchasedata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			String strsql="select round(det.loanamt,2) loanamount,m.doc_no,m.voc_no,m.date,m.venid vendorid,head.description,det.dealno from gl_vpurm m left join my_head head on "+
			" (m.venid=head.doc_no and head.dtype='VND') left join gl_vpurdetm det on m.doc_no=det.rdocno where m.status=3"+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			purchasedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
			
		}
		return purchasedata;
	}
	
	public JSONArray getDeleteData(String purchasedocno,String id) throws SQLException{
		JSONArray deletedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return deletedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select 1 defaultdeleterow,purchasedocno,date,chequeno,principalamt,interestamt,amount,bpvno from gl_loanrestructure where deletestatus=1 and purchasedocno="+purchasedocno;
			ResultSet rs=stmt.executeQuery(strsql);
			deletedata=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return deletedata;
	}
	
	public JSONArray getBalanceLoanAcno() throws SQLException{
		JSONArray acnodata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,description,account from my_head where atype='GL' and m_s=0";
			ResultSet rs=stmt.executeQuery(strsql);
			acnodata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return acnodata;
	}
	
	
	public JSONArray getVehicle(String purchasedocno,String dealno,String id) throws SQLException{
		JSONArray vehicledata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return vehicledata; 
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select rowno,brd.brand_name brand,model.vtype model,clr.color,d.fleet_no,veh.reg_no from gl_vpurd d left join gl_vehbrand brd on "+
			" d.brdid=brd.doc_no left join gl_vehmodel model on d.modid=model.doc_no left join my_color clr on d.clrid=clr.doc_no left join gl_vehmaster veh"+
			" on d.fleet_no=veh.fleet_no where rdocno="+purchasedocno+" and d.flstatus=1";
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
}
