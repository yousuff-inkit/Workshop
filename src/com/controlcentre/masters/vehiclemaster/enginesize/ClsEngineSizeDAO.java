package com.controlcentre.masters.vehiclemaster.enginesize;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsEngineSizeDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsEngineSizeBean colorBean = new ClsEngineSizeBean();
	public int insert(String enginesize,HttpSession session,String mode,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select enginesize from ws_enginesize where status<>7 and enginesize='"+enginesize+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtColor = conn.prepareCall("{call enginesizeDML(?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtColor.registerOutParameter(4, java.sql.Types.INTEGER);
			stmtColor.setString(1,enginesize);
			stmtColor.setString(3,session.getAttribute("BRANCHID").toString());
			stmtColor.setString(2,session.getAttribute("USERID").toString());
			
			stmtColor.setString(5,mode);
			stmtColor.setString(6,formdetailcode);
			stmtColor.executeQuery();
			aaa=stmtColor.getInt("docNo");
//			System.out.println("no====="+aaa);
			colorBean.setDocno(aaa);
			if (aaa > 0) {
				
		//		System.out.println("Sucess"+colorBean.getDocno());
				conn.commit();
				stmtColor.close();
				stmtTest.close();
				conn.close();
				return aaa;
			}
			stmtColor.close();
			stmtTest.close();

			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}
	


public JSONArray getEngineSizeData() throws SQLException {
    Connection conn = ClsConnection.getMyConnection();
	JSONArray data=new JSONArray();
    try {
		Statement stmtColor = conn.createStatement ();
        ResultSet resultSet = stmtColor.executeQuery ("select doc_no,enginesize from ws_enginesize where status<>7");
        data=objcommon.convertToJSON(resultSet);
		stmtColor.close();
		conn.close();
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

public int edit(String enginesize, int docno, String mode,HttpSession session,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select enginesize from ws_enginesize where status<>7 and enginesize='"+enginesize+"' and doc_no<>'"+docno+"'";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			stmtTest.close();
			conn.close();
			return -1;
		}
		CallableStatement stmtColor = conn.prepareCall("{call enginesizeDML(?,?,?,?,?,?)}");
		stmtColor.setString(1,enginesize);
		stmtColor.setInt(4,docno);
		stmtColor.setString(3, session.getAttribute("BRANCHID").toString());
		stmtColor.setString(2, session.getAttribute("USERID").toString());
		stmtColor.setString(5, mode);
		stmtColor.setString(6,formdetailcode);
		int aa = stmtColor.executeUpdate();
		if (aa>0) {
			conn.commit();
			stmtColor.close();
			stmtTest.close();
			conn.close();
			return aa;
		}
		stmtTest.close();
		stmtColor.close();
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


public int delete(String enginesize,int docno,String mode,HttpSession session,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testsql3="select m.doc_no from ws_enginesize c inner join gl_vehmodel m on m.engsizeid=c.doc_no where c.enginesize='"+enginesize+"'";
		ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
		if(resultSet3.next()){
			stmtTest.close();
			conn.close();
			return -2;
		}
		CallableStatement stmtColor = conn.prepareCall("{call enginesizeDML(?,?,?,?,?,?)}");
		stmtColor.setInt(4, docno);
		stmtColor.setString(1,enginesize);
		stmtColor.setString(3, session.getAttribute("BRANCHID").toString());
		stmtColor.setString(2, session.getAttribute("USERID").toString());
		stmtColor.setString(5, mode);
		stmtColor.setString(6,formdetailcode);
		int aa = stmtColor.executeUpdate();
		if (aa>0) {
			conn.commit();
			stmtTest.close();
			stmtColor.close();
			conn.close();
			return aa;
		}
		stmtTest.close();
		stmtColor.close();
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
}
