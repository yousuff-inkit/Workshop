package com.operations.vehicletransactions.quickserviceupdate;

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


public class ClsQuickServiceUpdateDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public   JSONArray garageSearch() throws SQLException {
	    List<ClsQuickServiceUpdateBean> servicebean = new ArrayList<ClsQuickServiceUpdateBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
			conn=objconn.getMyConnection();
				
				Statement stmtgarage = conn.createStatement ();
				strSql="select name,doc_no from gl_garrage where  status<>7";
//	        	System.out.println(strSql);
				
				ResultSet resultSet = stmtgarage.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtgarage.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getFleet(String docno,String fleet,String regno,String date) throws SQLException {
	    List<ClsQuickServiceUpdateBean> rentalclosebean = new ArrayList<ClsQuickServiceUpdateBean>();
		//java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
		//System.out.println("Date"+sqlStartDate);
		Connection conn = null;
		
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
		conn=objconn.getMyConnection();
		Statement stmt = conn.createStatement();
		String sqltest="";
			if(!(docno.equalsIgnoreCase("")||docno.equalsIgnoreCase("0"))){
				sqltest=" and doc_no="+docno;
			}
			if(!(fleet.equalsIgnoreCase("")||fleet.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and fleet_no like '%"+fleet+"%'";
			}
			if(!(regno.equalsIgnoreCase("")||regno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and reg_no like '%"+regno+"%'";
			}
			
			
			java.sql.Date sqlsearchdate=null;
			if(!(date.equalsIgnoreCase("0")||date.equalsIgnoreCase(null)||date.equalsIgnoreCase(""))){
				sqlsearchdate=objcommon.changeStringtoSqlDate(date);
			}
			if(!(sqlsearchdate==null)){
				sqltest=sqltest+" and date='"+sqlsearchdate+"'";
			}
//			System.out.println("Default SqlTest:"+sqltest);
			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			JSONArray jsonArray = new JSONArray();
			 String strSql = "select doc_no,fleet_no,flname,date,reg_no from gl_vehmaster where status<>7 "+sqltest+" group by doc_no";
			 //System.out.println("CHECKING SQL"+strSql);
				ResultSet resultSet = stmt.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();		
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		
	    return RESULTDATA;
	}
	public   JSONArray mainSearch() throws SQLException {
	    List<ClsQuickServiceUpdateBean> servicebean = new ArrayList<ClsQuickServiceUpdateBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	    try {
			conn=objconn.getMyConnection();
				
				Statement stmtmovement = conn.createStatement ();
				strSql="select qm.doc_no,qm.date,qm.fromdate,qm.todate,qm.garageid,grg.name garagename,qm.cstatus,coalesce(qm.remarks,'') remarks from gl_quickservicem qm left join gl_garrage grg"+
						" on qm.garageid=grg.doc_no";
//				System.out.println(strSql);
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
	//Grid Reloading with Service Data
	public   JSONArray loadServiceData(String docno) throws SQLException {
	    List<ClsQuickServiceUpdateBean> servicebean = new ArrayList<ClsQuickServiceUpdateBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	    try {
			conn=objconn.getMyConnection();
				
				Statement stmtmovement = conn.createStatement ();
				strSql="select qd.fleet_no fleetno,veh.flname,if(qd.washing=1,'Yes','No') washing,currkm currentkm,nextduekm,servicedate,partcost partscost,"+
						" labourcost,(partcost+labourcost) total  from gl_quickserviced qd left join gl_vehmaster veh on qd.fleet_no=veh.fleet_no where rdocno="+docno;
				//System.out.println(strSql);
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
	public int insert(int docno, Date date, Date fromdate, Date todate,String garage,String formdetailcode,HttpSession session,String mode,String branch,String remarks) throws SQLException {
		Connection conn=objconn.getMyConnection();
		int mval=0;
		try{
			
			conn.setAutoCommit(false);
			CallableStatement stmtService = conn.prepareCall("{call quickServiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtService.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtService.setDate(1,date);
			 stmtService.setInt(2,Integer.parseInt(garage));
			 stmtService.setDate(3,fromdate);
			 stmtService.setDate(4,todate);
			 stmtService.setString(5,formdetailcode);
			 stmtService.setString(6,session.getAttribute("USERID").toString());
			 stmtService.setString(7,branch);
			 stmtService.setString(9,mode);
			 stmtService.setInt(10, 0);
			 stmtService.setInt(11, 0);
			 stmtService.setInt(12, 0);
			 stmtService.setInt(13, 0);
			 stmtService.setDate(14, null);
			 stmtService.setInt(15, 0);
			 stmtService.setInt(16, 0);
			 stmtService.setInt(17, 0);
			 stmtService.setInt(18, 0);
			 stmtService.setInt(19, 0);
			 stmtService.setDouble(20, 0);
			 stmtService.setDouble(21, 0);
			 stmtService.setString(22, remarks);
//			 System.out.println(stmtService);
			 stmtService.executeQuery();
	mval=stmtService.getInt("docNo");
			if(mval<=0){
				conn.close();
				return 0;
			}
			conn.commit();
			stmtService.close();
			conn.close();
			return mval;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		finally{
			conn.close();
		}
		
	}
	public int serviceSave(int docno, String fleetno, String currentkm,String nextduekm, String billno, Date servicedate,String hidchkwashing,
			String hidchkoil, String hidchkoilfilter,String hidchkfuelfilter, String hidchkairfilter, String partscost,String labourcost, 
			String mode, HttpSession session,String formdetailcode,String branch,String remarks) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int serviceval=0;
		try{
			conn=objconn.getMyConnection();
			if(partscost.equalsIgnoreCase("")){
				partscost="0";
			}
			if(labourcost.equalsIgnoreCase("")){
				labourcost="0";
			}
			
			conn.setAutoCommit(false);
			CallableStatement stmtService = conn.prepareCall("{call quickServiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtService.setInt(8, docno);
			stmtService.setDate(1,null);
			 stmtService.setInt(2,0);
			 stmtService.setDate(3,null);
			 stmtService.setDate(4,null);
			 stmtService.setString(5,formdetailcode);
			 stmtService.setString(6,session.getAttribute("USERID").toString());
			 stmtService.setString(7,branch);
			 stmtService.setString(9,mode);
			 stmtService.setInt(10, Integer.parseInt(fleetno));
			 stmtService.setInt(11, Integer.parseInt(currentkm));
			 stmtService.setInt(12, Integer.parseInt(nextduekm));
			 stmtService.setInt(13, Integer.parseInt(billno));
			 stmtService.setDate(14, servicedate);
			 stmtService.setInt(15, Integer.parseInt(hidchkwashing));
			 stmtService.setInt(16, Integer.parseInt(hidchkoil));
			 stmtService.setInt(17, Integer.parseInt(hidchkoilfilter));
			 stmtService.setInt(18, Integer.parseInt(hidchkfuelfilter));
			 stmtService.setInt(19, Integer.parseInt(hidchkairfilter));
			 stmtService.setDouble(20, Double.parseDouble(partscost));
			 stmtService.setDouble(21, Double.parseDouble(labourcost));
			 stmtService.setString(22,remarks);
//			 System.out.println(stmtService);
			 stmtService.executeQuery();
	serviceval=stmtService.getInt("docNo");

			if(serviceval<=0){
				conn.close();
				return 0;
			}
			
			
			
			conn.commit();
			stmtService.close();
			conn.close();
			return serviceval;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		finally{
			conn.close();
		}
		
	}
}
