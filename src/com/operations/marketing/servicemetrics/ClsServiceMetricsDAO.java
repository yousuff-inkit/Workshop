package com.operations.marketing.servicemetrics;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.SQLException;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

public class ClsServiceMetricsDAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getTarifGroup() throws SQLException{
		JSONArray groupdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,gname from gl_vehgroup where status=3 and doc_no not in (select tarifgroup from gl_srvcmetricsm where status=3)";
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

	public int insert(Date sqldate, String hidtarifgroup, String insurpercent,
			String tracker, String regcost, String mode, String brchName,
			HttpSession session,String formdetailcode,ArrayList<String> srvcarray,String insurexcess,String exkmrate) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			insurexcess=insurexcess.equalsIgnoreCase("")?"0.0":insurexcess;
			exkmrate=exkmrate.equalsIgnoreCase("")?"0.0":exkmrate;
			insurpercent=insurpercent.equalsIgnoreCase("")?"0.0":insurpercent;
			tracker=tracker.equalsIgnoreCase("")?"0.0":tracker;
			regcost=regcost.equalsIgnoreCase("")?"0.0":regcost;
			CallableStatement stmtSrvc = conn.prepareCall("{call srvcMetricsDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtSrvc.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtSrvc.setDate(1,sqldate);
			stmtSrvc.setString(2, hidtarifgroup);
			stmtSrvc.setString(3, insurpercent);
			stmtSrvc.setString(4, tracker);
			stmtSrvc.setString(5, regcost);
			stmtSrvc.setString(6, session.getAttribute("USERID").toString());
			stmtSrvc.setString(7, brchName);
			stmtSrvc.setString(8, mode);
			stmtSrvc.setString(9, formdetailcode);
			stmtSrvc.setString(11, insurexcess);
			stmtSrvc.setString(12, exkmrate);
			stmtSrvc.executeQuery();
			docno=stmtSrvc.getInt("docNo");
			if(docno<=0){
				return 0;
			}
			int errorstatus=0;
			if(docno>0){
				Statement stmt=conn.createStatement();
				for(int i=0;i<srvcarray.size();i++){
					String srvc[]=srvcarray.get(i).split("::");
					if(!srvc[0].equalsIgnoreCase("") && !srvc[0].equalsIgnoreCase("undefined") && srvc[0]!=null){
					String strsql="insert into gl_srvcmetricsd(rdocno,srvckm,srvccost,replacecost,tyrecost,status)values("+docno+","+srvc[0]+","+srvc[1]+","+srvc[2]+","+srvc[3]+",3)";
					int val=stmt.executeUpdate(strsql);
					if(val<=0){
						errorstatus=1;
						return 0;
					}
					}
				}
				
				if(errorstatus!=1){
					conn.commit();
					return docno;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}

	public boolean edit(Date sqldate, String hidtarifgroup,
			String insurpercent, String tracker, String regcost, String mode,
			String brchName, HttpSession session, int docno,
			String formdetailcode, ArrayList<String> srvcarray,String insurexcess,String exkmrate) throws SQLException{
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			insurexcess=insurexcess.equalsIgnoreCase("")?"0.0":insurexcess;
			exkmrate=exkmrate.equalsIgnoreCase("")?"0.0":exkmrate;
			insurpercent=insurpercent.equalsIgnoreCase("")?"0.0":insurpercent;
			tracker=tracker.equalsIgnoreCase("")?"0.0":tracker;
			regcost=regcost.equalsIgnoreCase("")?"0.0":regcost;
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtSrvc = conn.prepareCall("{call srvcMetricsDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtSrvc.setInt(10,docno);
			stmtSrvc.setDate(1,sqldate);
			stmtSrvc.setString(2, hidtarifgroup);
			stmtSrvc.setString(3, insurpercent);
			stmtSrvc.setString(4, tracker);
			stmtSrvc.setString(5, regcost);
			stmtSrvc.setString(6, session.getAttribute("USERID").toString());
			stmtSrvc.setString(7, brchName);
			stmtSrvc.setString(8, mode);
			stmtSrvc.setString(9, formdetailcode);
			stmtSrvc.setString(11, insurexcess);
			stmtSrvc.setString(12, exkmrate);
			int updateval=stmtSrvc.executeUpdate();
			if(docno<0){
				return false;
			}
			int errorstatus=0;
			if(updateval>0){
				Statement stmt=conn.createStatement();
				int deleteval=stmt.executeUpdate("delete from gl_srvcmetricsd where rdocno="+docno);
				
				for(int i=0;i<srvcarray.size();i++){
					String srvc[]=srvcarray.get(i).split("::");
					if(!srvc[0].equalsIgnoreCase("") && !srvc[0].equalsIgnoreCase("undefined") && srvc[0]!=null){
					String strsql="insert into gl_srvcmetricsd(rdocno,srvckm,srvccost,replacecost,tyrecost,status)values("+docno+","+srvc[0]+","+srvc[1]+","+srvc[2]+","+srvc[3]+",3)";
					int val=stmt.executeUpdate(strsql);
					if(val<=0){
						errorstatus=1;
						return false;
					}
					}
				}
				
				if(errorstatus!=1){
					conn.commit();
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
		
	}

	public boolean delete(Date sqldate, String hidtarifgroup,
			String insurpercent, String tracker, String regcost, String mode,
			String brchName, HttpSession session, int docno,
			String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtSrvc = conn.prepareCall("{call srvcMetricsDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtSrvc.setInt(10,docno);
			stmtSrvc.setDate(1,sqldate);
			stmtSrvc.setString(2, hidtarifgroup);
			stmtSrvc.setString(3, insurpercent);
			stmtSrvc.setString(4, tracker);
			stmtSrvc.setString(5, regcost);
			stmtSrvc.setString(6, session.getAttribute("USERID").toString());
			stmtSrvc.setString(7, brchName);
			stmtSrvc.setString(8, mode);
			stmtSrvc.setString(9, formdetailcode);
			stmtSrvc.setString(11, "0");
			int updateval=stmtSrvc.executeUpdate();
			if(updateval<0){
				return false;
			}
			if(updateval>0){
				Statement stmt=conn.createStatement();
				int deleteval=stmt.executeUpdate("update gl_srvcmetricsd set status=7 where rdocno="+docno);
				if(deleteval>=0){
					conn.commit();
					return true;
				}
				
				
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	public JSONArray mainSearch() throws SQLException{
		Connection conn=null;
		JSONArray searchdata=new JSONArray();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select srv.exkmrate,srv.doc_no,srv.insurexcess,srv.date,srv.tarifgroup,srv.insurpercent,srv.tracker,srv.regcost,grp.gname from gl_srvcmetricsm srv"+
			" left join gl_vehgroup grp on srv.tarifgroup=grp.doc_no where srv.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return searchdata;
	}
	
	public JSONArray getSrvcMetricsGridData(String docno,String id) throws SQLException{
		Connection conn=null;
		JSONArray searchdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return searchdata;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select srvckm,srvccost,replacecost,tyrecost from gl_srvcmetricsd where rdocno="+docno+" and status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return searchdata;
	}
	
	
}
