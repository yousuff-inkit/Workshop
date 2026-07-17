package com.operations.saleofvehicle.vehiclestatuschange;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.movement.ClsMovementBean;

public class ClsFleetStatusChangeDAO {
	ClsFleetStatusChangeBean statuschangebean=new ClsFleetStatusChangeBean();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray fleetSearch(String branch,String searchdate,String fleetno,String docno,String regno,String color,String group) throws SQLException {
	    List<ClsFleetStatusChangeBean> changebean = new ArrayList<ClsFleetStatusChangeBean>();
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(searchdate.equalsIgnoreCase(""))){
				sqldate=objcommon.changeStringtoSqlDate(searchdate);
			}
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.doc_no like '%"+docno+"%'";
			}
			if(!(fleetno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and veh.date='"+sqldate+"'";
				
			}
			if(!(group.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.vgrpid like '%"+group+"%'";
			}
			if(!(color.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.clrid like '%"+color+"%'";
			}
				Statement stmtmovement = conn.createStatement();
	        	String strSql="select veh.doc_no,veh.date,veh.fleet_no,veh.flname,veh.reg_no,clr.color,grp.gid,veh.tran_code,st.st_desc,v.din,v.tin"+
" from gl_vehmaster veh left join gl_vmove v  on (veh.fleet_no=v.fleet_no and veh.status='IN' and v.doc_no=( select max(doc_no)"+
" from gl_vmove where fleet_no= veh.fleet_no)) left join my_color clr on veh.clrid=clr.doc_no left join gl_vehgroup grp on"+
" veh.vgrpid=grp.doc_no left join gl_status st on veh.tran_code=st.status where veh.status='IN' and veh.tran_code<>'CU'"+
" and veh.statu<>7 and a_br='"+branch+"'"+sqltest;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
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
	public JSONArray fleetStatusSearch(HttpSession session) throws SQLException {
	
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
	        	String strSql="select st.doc_no,st.date,st.time,st.fleetno,stat.st_desc,st.currst,st.changest,st.reason,veh.flname,veh.reg_no,grp.gid,clr.color"+
	        			" from gl_flchange st  left join gl_vehmaster veh on st.fleetno=veh.fleet_no left join gl_status stat on st.currst=stat.status"+
	        			" left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join my_color clr on veh.clrid=clr.doc_no where st.status<>7 and st.brhid='"+session.getAttribute("BRANCHID").toString()+"'";
	        /*	String strSql="select st.doc_no from gl_flchange st  left join gl_vehmaster veh on st.fleetno=veh.fleet_no left join gl_status stat on st.currst=stat.status"+
    			" left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join my_color clr on veh.clrid=clr.doc_no where st.status<>7 and st.brhid='"+session.getAttribute("BRANCHID").toString()+"'";*/
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
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
	public int insert(Date sqlStartDate, String fleetstatustime, int fleetno,
			String currentstatus, String cmbchangestatus, String reason,
			HttpSession session, String mode, String formdetailcode,String branchid) throws SQLException {
		Connection conn=objconn.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			String cmbbranch="";
			if(session.getAttribute("BRANCHID")==null){
				cmbbranch=branchid;
			}
			else{
				cmbbranch=session.getAttribute("BRANCHID").toString();
			}
			CallableStatement stmtFleetStatus = conn.prepareCall("{call fleetStatusDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("checking");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtFleetStatus.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtFleetStatus.setDate(1,sqlStartDate);
			stmtFleetStatus.setString(2,fleetstatustime);
			stmtFleetStatus.setString(3, cmbbranch);
			stmtFleetStatus.setString(4, session.getAttribute("USERID").toString());
			stmtFleetStatus.setInt(5,fleetno);
			stmtFleetStatus.setString(6,currentstatus);
			stmtFleetStatus.setString(7,cmbchangestatus);
			stmtFleetStatus.setString(8,reason);
			stmtFleetStatus.setString(9,session.getAttribute("USERID").toString());
			stmtFleetStatus.setString(10,cmbbranch);
			stmtFleetStatus.setString(12, mode);
			stmtFleetStatus.setString(13,formdetailcode);
			stmtFleetStatus.executeQuery();
			aaa=stmtFleetStatus.getInt("docNo");
			
//			System.out.println("no====="+aaa);
			statuschangebean.setDocno(aaa);
			//String dtype=session.getAttribute("Code").toString();
			/*stmtFleetStatus.close();
			conn.close();*/
			if (aaa > 0) {
				CallableStatement stmtMove = conn.prepareCall("{call detailmoveDML(?,?,?,?,?,?)}");
				stmtMove.setInt(1,fleetno);
				stmtMove.setDate(2,sqlStartDate);
				stmtMove.setString(3, fleetstatustime);
				stmtMove.setInt(4, aaa);
				stmtMove.setString(5,formdetailcode);
				stmtMove.setString(6,cmbchangestatus);
//				System.out.println("Statement detailMove:"+stmtMove);
				int val=stmtMove.executeUpdate();
				if(val<=0){
					return 0;
				}
//				System.out.println("Success"+statuschangebean.getDocno());
				conn.commit();
				stmtFleetStatus.close();
				stmtMove.close();
				conn.close();
				return aaa;
			}
			stmtFleetStatus.close();
			
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	public boolean edit(Date sqlStartDate, String fleetstatustime, int fleetno,
			String currentstatus, String cmbchangestatus, String reason,
			HttpSession session, String mode, int docno,String formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtFleetStatus = conn.prepareCall("{call fleetStatusDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("checking");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtFleetStatus.setInt(11,docno);
			stmtFleetStatus.setDate(1,sqlStartDate);
			stmtFleetStatus.setString(2,fleetstatustime);
			stmtFleetStatus.setString(3, session.getAttribute("BRANCHID").toString());
			stmtFleetStatus.setString(4, session.getAttribute("USERID").toString());
			stmtFleetStatus.setInt(5,fleetno);
			stmtFleetStatus.setString(6,currentstatus);
			stmtFleetStatus.setString(7,cmbchangestatus);
			stmtFleetStatus.setString(8,reason);
			stmtFleetStatus.setString(9,session.getAttribute("USERID").toString());
			stmtFleetStatus.setString(10, session.getAttribute("BRANCHID").toString());
			stmtFleetStatus.setString(12, mode);
			stmtFleetStatus.setString(13,formdetailcode);
			int aa = stmtFleetStatus.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtFleetStatus.close();
				conn.close();
				return true;
			}
			stmtFleetStatus.close();
			conn.close();
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		
		return false;
	}
	public boolean delete(Date sqlStartDate, String fleetstatustime,
			int fleetno, String currentstatus, String cmbchangestatus,
			String reason, HttpSession session, String mode, int docno,String formdetailcode) throws SQLException {
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtFleetStatus = conn.prepareCall("{call fleetStatusDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("checking");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtFleetStatus.setInt(11,docno);
			stmtFleetStatus.setDate(1,sqlStartDate);
			stmtFleetStatus.setString(2,fleetstatustime);
			stmtFleetStatus.setString(3, session.getAttribute("BRANCHID").toString());
			stmtFleetStatus.setString(4, session.getAttribute("USERID").toString());
			stmtFleetStatus.setInt(5,fleetno);
			stmtFleetStatus.setString(6,currentstatus);
			stmtFleetStatus.setString(7,cmbchangestatus);
			stmtFleetStatus.setString(8,reason);
			stmtFleetStatus.setString(9,session.getAttribute("USERID").toString());
			stmtFleetStatus.setString(10, session.getAttribute("BRANCHID").toString());
			stmtFleetStatus.setString(12, mode);
			stmtFleetStatus.setString(13,formdetailcode);
			int aa = stmtFleetStatus.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtFleetStatus.close();
				conn.close();
				return true;
			}
			stmtFleetStatus.close();
			conn.close();
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		
		return false;
	}

}
