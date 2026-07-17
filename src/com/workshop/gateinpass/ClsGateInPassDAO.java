package com.workshop.gateinpass;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsGateInPassDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getFleet(String fleetno,String fleetname,String regno,String date,String id) throws SQLException{
		JSONArray fleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return fleetdata;
		}
		Connection conn=null;
		try{
			java.sql.Date sqldate=null;
			String sqltest="";
			if(date!=null && !date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(!fleetname.equalsIgnoreCase("")){
				sqltest+=" and veh.flname like '%"+fleetname+"%'";
			}
			if(sqldate!=null){
				sqltest+=" and veh.date='"+sqldate+"'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select agmt.doc_no agmtno, if(agmt.cldocno>0,1,0) agmtexist,convert(coalesce(ac.cldocno,''),char(25)) cldocno,concat(ac.refname,' ,Address : ',ac.address,' ,Mobile : ',ac.per_mob,' "+
			" ,Mail : ',ac.mail1) clientdetails,coalesce(veh.srvc_km,0) srvckm,coalesce(veh.lst_srv,0) lastsrvckm,veh.fleet_no,veh.reg_no,veh.flname,veh.date"+
			" from gl_vehmaster veh left join gl_lagmt agmt on (veh.fleet_no=if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) and agmt.clstatus=0)"+
			" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where veh.fstatus='L' and veh.statu=3 "+sqltest;
			System.out.println(strsql);
			ResultSet rsveh=stmt.executeQuery(strsql);
			fleetdata=objcommon.convertToJSON(rsveh);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return fleetdata;
	}
	
	public JSONArray getClient(String id,String clientdocno,String clientname,String clientaddress,String clientmobile,String clientmail) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			String sqltest="";
			
			if(!clientdocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+clientdocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!clientaddress.equalsIgnoreCase("")){
				sqltest+=" and ac.address like '%"+clientaddress+"%'";
			}
			if(!clientmobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+clientmobile+"%'";
			}
			if(!clientmail.equalsIgnoreCase("")){
				sqltest+=" and ac.mail1 like '%"+clientmail+"%'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select ac.cldocno,coalesce(ac.refname,'') refname,coalesce(ac.address,'') address,coalesce(ac.per_mob,'') mobile,coalesce(ac.mail1,'') mail,concat(ac.refname,' ,Address : ',ac.address,' ,Mobile : ',ac.per_mob,' "+
			" ,Mail : ',ac.mail1) clientdetails from  my_acbook ac  where ac.dtype='CRM' and ac.status=3 "+sqltest;
			System.out.println(strsql);
			ResultSet rsveh=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rsveh);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
	public JSONArray getDriver(String driverdocno,String driverlicense,String driverlicensedate,String drivername,String drivermobile,String id,String agmtexist,String cldocno,String agmtno) throws SQLException{
		JSONArray driverdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return driverdata;
		}
		Connection conn=null;
		try{
			String sqltest="";
			java.sql.Date sqllicensedate=null;
			if(!driverlicensedate.equalsIgnoreCase("") && driverlicensedate!=null){
				sqllicensedate=objcommon.changeStringtoSqlDate(driverlicensedate);
			}
			if(agmtexist.equalsIgnoreCase("1")){
				if(!driverdocno.equalsIgnoreCase("")){
					sqltest+=" and dr.dr_id like '%"+driverdocno+"%'";
				}
				if(!driverlicense.equalsIgnoreCase("")){
					sqltest+=" and dr.dlno like '%"+driverlicense+"%'";
				}
				if(sqllicensedate!=null){
					sqltest+=" and dr.led='"+sqllicensedate+"'";
				}
				if(!drivername.equalsIgnoreCase("")){
					sqltest+=" and dr.name like '%"+drivername+"%'";
				}
				if(!drivermobile.equalsIgnoreCase("")){
					sqltest+=" and dr.mobno like '%"+drivermobile+"%'";
				}
			}
			else{
				if(!driverdocno.equalsIgnoreCase("")){
					sqltest+=" and sal.doc_no like '%"+driverdocno+"%'";
				}
				if(!driverlicense.equalsIgnoreCase("")){
					sqltest+=" and sal.lic_no like '%"+driverlicense+"%'";
				}
				if(sqllicensedate!=null){
					sqltest+=" and sal.lic_exp_dt='"+sqllicensedate+"'";
				}
				if(!drivername.equalsIgnoreCase("")){
					sqltest+=" and sal.sal_name like '%"+drivername+"%'";
				}
				if(!drivermobile.equalsIgnoreCase("")){
					sqltest+=" and sal.mobile like '%"+drivermobile+"%'";
				}
			}
			
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			if(agmtexist.equalsIgnoreCase("1")){
				strsql="select dr.dr_id doc_no, dr.name name,dr.dlno license,dr.led licenseexpiry,dr.mobno mobile from  gl_drdetails dr where dr.cldocno="+cldocno+" and dr.dtype='CRM'";
			}
			else{
				strsql="select sal.doc_no ,sal.sal_name name,sal.lic_no license,sal.lic_exp_dt licenseexpiry,sal.mobile from my_salesman sal where sal.status=3 and sal.sal_type='DRV'"+sqltest;
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			driverdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return driverdata;
	}

	public int insert(Date sqldate, String fleetno, String driver,
			String hidchkdriver, String hiddriver, Date sqlindate,
			String intime, String inkm, String cmbinfuel, String remarks,
			String serviceduekm, ArrayList<String> complaintarray,
			HttpSession session, HttpServletRequest request, String mode,
			String formdetailcode,String brchName,String agmtno,String cldocno,String agmtexist) throws SQLException {
		// TODO Auto-generated method stub
		int val=0;
		int errorstatus=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			hiddriver=hiddriver.equalsIgnoreCase("")?"0":hiddriver;
			hidchkdriver=hidchkdriver.equalsIgnoreCase("")?"0":hidchkdriver;
			agmtno=agmtno.equalsIgnoreCase("")?"0":agmtno;
			cldocno=cldocno.equalsIgnoreCase("")?"0":cldocno;
			serviceduekm=serviceduekm.equalsIgnoreCase("")?"0":serviceduekm;
			CallableStatement stmtGate = conn.prepareCall("{call gateInPassDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtGate.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtGate.setDate(1,sqldate);
			stmtGate.setString(2,fleetno);
			stmtGate.setString(3,hiddriver);
			stmtGate.setString(4, hidchkdriver);
			stmtGate.setString(5,driver);
			stmtGate.setDate(6,sqlindate);
			stmtGate.setString(7,intime);
			stmtGate.setString(8,inkm);
			stmtGate.setString(9,cmbinfuel);
			stmtGate.setString(10,remarks);
			stmtGate.setString(11,"WGIP");
			stmtGate.setString(12,mode);
			stmtGate.setString(13,session.getAttribute("USERID").toString());
			stmtGate.setString(14,brchName);
			stmtGate.setString(15,serviceduekm);
			stmtGate.setInt(17,Integer.parseInt(agmtno));
			stmtGate.setInt(18,Integer.parseInt(cldocno));
			stmtGate.executeQuery();
			val=stmtGate.getInt("docNo");
			if(val>0){
				Statement stmt=conn.createStatement();
				String strupdate="update gl_workgateinpassm set agmtexist="+agmtexist+" where doc_no="+val;
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<0){
					return 0;
				}
				for(int i=0;i<complaintarray.size();i++){
					String temp[]=complaintarray.get(i).split("::");
					String strsql="insert into gl_workgateinpassd(rdocno,complaintid,brhid,description,status)values("+val+","+temp[0]+","+brchName+",'"+temp[1]+"',3)";
					System.out.println(strsql);
					int detailval=stmt.executeUpdate(strsql);
					if(detailval<=0){
						errorstatus=1;
					}
				}
			}
			if(errorstatus!=1){
				conn.commit();
				return val;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return val;
	}

	public boolean edit(Date sqldate, String fleetno, String driver,
			String hidchkdriver, String hiddriver, Date sqlindate,
			String intime, String inkm, String cmbinfuel, String remarks,
			String serviceduekm, ArrayList<String> complaintarray,
			HttpSession session, HttpServletRequest request, String mode,
			String formdetailcode, String brchName, String docno,String agmtno,String cldocno,String agmtexist) throws SQLException {
		// TODO Auto-generated method stub
		int errorstatus=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			hiddriver=hiddriver.equalsIgnoreCase("")?"0":hiddriver;
			hidchkdriver=hidchkdriver.equalsIgnoreCase("")?"0":hidchkdriver;
			agmtno=agmtno.equalsIgnoreCase("")?"0":agmtno;
			cldocno=cldocno.equalsIgnoreCase("")?"0":cldocno;
			serviceduekm=serviceduekm.equalsIgnoreCase("")?"0":serviceduekm;
			CallableStatement stmtGate = conn.prepareCall("{call gateInPassDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtGate.setInt(16, Integer.parseInt(docno));
			stmtGate.setDate(1,sqldate);
			stmtGate.setString(2,fleetno);
			stmtGate.setString(3,hiddriver);
			stmtGate.setString(4, hidchkdriver);
			stmtGate.setString(5,driver);
			stmtGate.setDate(6,sqlindate);
			stmtGate.setString(7,intime);
			stmtGate.setString(8,inkm);
			stmtGate.setString(9,cmbinfuel);
			stmtGate.setString(10,remarks);
			stmtGate.setString(11,"WGIP");
			stmtGate.setString(12,mode);
			stmtGate.setString(13,session.getAttribute("USERID").toString());
			stmtGate.setString(14,brchName);
			stmtGate.setString(15,serviceduekm);
			stmtGate.setInt(17,Integer.parseInt(agmtno));
			stmtGate.setInt(18,Integer.parseInt(cldocno));
			int val=stmtGate.executeUpdate();
			if(val>=0){
				Statement stmt=conn.createStatement();
				String strupdate="update gl_workgateinpassm set agmtexist="+agmtexist+" where doc_no="+docno;
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<0){
					return false;
				}
				String strdelete="delete from gl_workgateinpassd where rdocno="+docno+" and brhid="+brchName;
				int deleteval=stmt.executeUpdate(strdelete);
				System.out.println("Array Size :"+complaintarray.size());
				for(int i=0;i<complaintarray.size();i++){
					String temp[]=complaintarray.get(i).split("::");
					String description=temp[1].equalsIgnoreCase("undefined")?"":temp[1];
					String strsql="insert into gl_workgateinpassd(rdocno,complaintid,brhid,description,status)values("+docno+","+temp[0]+","+brchName+",'"+description+"',3)";
					System.out.println(strsql);
					int detailval=stmt.executeUpdate(strsql);
					if(detailval<=0){
						errorstatus=1;
					}
				}
			}
			if(errorstatus!=1){
				conn.commit();
				return true;
			}
			else{
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return false;
	}

	public boolean delete(String docno, String brchName,String mode,HttpSession session, HttpServletRequest request)throws SQLException {
		// TODO Auto-generated method stub
		int errorstatus=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtGate = conn.prepareCall("{call gateInPassDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtGate.setInt(16, Integer.parseInt(docno));
			stmtGate.setDate(1,null);
			stmtGate.setString(2,"0");
			stmtGate.setString(3,"0");
			stmtGate.setString(4, "0");
			stmtGate.setString(5,"0");
			stmtGate.setDate(6,null);
			stmtGate.setString(7,"0");
			stmtGate.setString(8,"0");
			stmtGate.setString(9,"0");
			stmtGate.setString(10,"0");
			stmtGate.setString(11,"WGIP");
			stmtGate.setString(12,mode);
			stmtGate.setString(13,session.getAttribute("USERID").toString());
			stmtGate.setString(14,brchName);
			stmtGate.setString(15,"0");
			stmtGate.setInt(17,0);
			stmtGate.setInt(18,0);
			int val=stmtGate.executeUpdate();
			if(val>=0){
				Statement stmt=conn.createStatement();
				String strdelete="update gl_workgateinpassd set status=7 where rdocno="+docno+" and brhid="+brchName;
				int deleteval=stmt.executeUpdate(strdelete);
				if(deleteval<0){
					errorstatus=1;
				}
			}
			if(errorstatus!=1){
				conn.commit();
				return true;
			}
			else{
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	public JSONArray getComplaints(String docno,String branch,String id) throws SQLException{
		JSONArray complaintdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return complaintdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select det.complaintid complaintdocno,det.description,comp.compname complaint from "+
			" gl_workgateinpassd det left join gl_complaint comp on det.complaintid=comp.doc_no where "+
			" det.status=3 and det.rdocno="+docno+" and det.brhid="+branch;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			complaintdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return complaintdata;
	}
	
	public JSONArray getSearchData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select concat(ac.refname,' ,Address : ',ac.address,' ,Mobile : ',ac.per_mob,' ,Mail : ',ac.mail1) clientdetails,m.agmtno,m.cldocno,m.doc_no,br.branchname,m.date,m.fleet_no,concat('Reg No : ',veh.reg_no,' Fleet Name : ',veh.flname) fleetdetails,m.driverid "+
			" hiddriver,m.newdriver chkdriver,m.drivername driver,m.indate,m.intime,m.inkm,m.infuel,m.remarks,m.serviceduekm from "+
			" gl_workgateinpassm m left join gl_vehmaster veh on m.fleet_no=veh.fleet_no left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV') "+
			" left join my_brch br on m.brhid=br.doc_no left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_drdetails dr on (m.driverid=dr.dr_id and m.agmtno>0) where m.status=3 order by m.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	} 
	
}
