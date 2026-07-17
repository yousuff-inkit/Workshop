package com.limousine.extraservicetarif;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsExtraSrvcTarifDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public int insert(Date sqldate, Date sqlfromdate, Date sqltodate, String desc,
			String brchName, HttpSession session, String formdetailcode,
			String mode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt =conn.prepareCall("{call limoExtraSrvcTarifMDML(?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(10, java.sql.Types.INTEGER);
			stmt.setDate(1,sqldate);
			stmt.setDate(2, sqlfromdate);
			stmt.setDate(3, sqltodate);
			stmt.setString(4, brchName);
			stmt.setString(5, session.getAttribute("USERID").toString());
			stmt.setString(6, desc);
			stmt.setString(7, mode);
			stmt.setString(8, session.getAttribute("COMPANYID").toString());
			stmt.setString(9, formdetailcode);
			stmt.executeQuery();
			docno=stmt.getInt("docNo");
			if(docno<=0){
				return 0;
			}
			else{
				conn.commit();
				return docno;
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


	public boolean edit(int docno, Date sqldate, Date sqlfromdate,
			Date sqltodate, String desc, String brchName, HttpSession session,
			String formdetailcode, String mode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt =conn.prepareCall("{call limoExtraSrvcTarifMDML(?,?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(10, docno);
			stmt.setDate(1,sqldate);
			stmt.setDate(2, sqlfromdate);
			stmt.setDate(3, sqltodate);
			stmt.setString(4, brchName);
			stmt.setString(5, session.getAttribute("USERID").toString());
			stmt.setString(6, desc);
			stmt.setString(7, mode);
			stmt.setString(8, session.getAttribute("COMPANYID").toString());
			stmt.setString(9, formdetailcode);
			int val=stmt.executeUpdate();
			if(val<0){
				return false;
			}
			else{
				conn.commit();
				return true;
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


	public boolean delete(int docno, Date sqldate, Date sqlfromdate,
			Date sqltodate, String desc, String brchName, HttpSession session,
			String formdetailcode, String mode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt =conn.prepareCall("{call limoExtraSrvcTarifMDML(?,?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(10, docno);
			stmt.setDate(1,sqldate);
			stmt.setDate(2, sqlfromdate);
			stmt.setDate(3, sqltodate);
			stmt.setString(4, brchName);
			stmt.setString(5, session.getAttribute("USERID").toString());
			stmt.setString(6, desc);
			stmt.setString(7, mode);
			stmt.setString(8, session.getAttribute("COMPANYID").toString());
			stmt.setString(9, formdetailcode);
			int val=stmt.executeUpdate();
			if(val<0){
				return false;
			}
			else{
				conn.commit();
				return true;
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

	
	public JSONArray getSearchData() throws SQLException{
		JSONArray searchdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,date,fromdate,todate,desc1 from gl_limoextrasrvctarifm where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return searchdata;
	}


	public boolean tarifinsert(int tarifdocno, ArrayList<String> gridarray) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			int deleteval=stmt.executeUpdate("delete from gl_limoextrasrvctarifd where tarifdocno="+tarifdocno);
			for(int i=0;i<gridarray.size();i++){
				String arr[]=gridarray.get(i).split("::");
				if(!arr[0].equalsIgnoreCase("") && !arr[0].equalsIgnoreCase("undefined") && arr[0]!=null){
					ResultSet rsdoc=stmt.executeQuery("select coalesce(max(doc_no)+1,1) maxdoc from gl_limoextrasrvctarifd");
					while(rsdoc.next()){
						docno=rsdoc.getInt("maxdoc");
					}
					int val=stmt.executeUpdate("insert into gl_limoextrasrvctarifd(doc_no,tarifdocno,airportid,greetrate,viprate,boquerate,status)values"+
					" ("+docno+","+tarifdocno+","+arr[0]+","+arr[1]+","+arr[2]+","+arr[3]+",3)");
					if(val<=0){
						return false;
					}
				}
				
			}
			conn.commit();
			return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	public JSONArray getGridData(String docno,String id) throws SQLException{
		JSONArray griddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return griddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select extra.airportid,extra.greetrate,extra.viprate,extra.boquerate,air.airport from gl_limoextrasrvctarifd extra left join"+
			" gl_airport air on (extra.airportid=air.doc_no) where extra.status=3 and extra.tarifdocno="+docno;
			System.out.println(strsql);
			ResultSet resultSet=stmt.executeQuery(strsql);
			griddata=objcommon.convertToJSON(resultSet);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return griddata;
	}
}
