package com.limousine.limosetup.location2;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLocation2DAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public int insert(String location, String longitude, String latitude,
			String brchName, Date sqldate, HttpSession session,String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			ResultSet rsgetdoc=stmt.executeQuery("select coalesce(max(doc_no)+1,1) docno from gl_cordinates");
			while(rsgetdoc.next()){
				docno=rsgetdoc.getInt("docno");
			}
			conn.setAutoCommit(false);
			String userid=session.getAttribute("USERID").toString();
			System.out.println("Location: "+location.replace("'", "''"));
			int val=stmt.executeUpdate("insert into gl_cordinates(doc_no,date,location,latitude,longitude,status,brhid,userid)values("+docno+",'"+sqldate+"','"+location.replace("'", "''")+"','"+latitude+"','"+longitude+"',3,"+brchName+","+userid+")");
			if(val<=0){
				return 0;
			}
			else{
				int logval=stmt.executeUpdate("insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values("+docno+","+brchName+",'"+formdetailcode+"',now(),"+userid+",'A')");
				if(logval<=0){
					return 0;
				}
				else{
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
		return docno;
	}

	public boolean edit(String location, String longitude, String latitude,
			String brchName, Date sqldate, HttpSession session, int docno,String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			int val=stmt.executeUpdate("update gl_cordinates set location='"+location.replace("'", "''")+"',latitude='"+latitude+"',longitude='"+longitude+"',brhid="+brchName+" where doc_no="+docno);
			if(val<0){
				return false;
			}
			else{
				String userid=session.getAttribute("USERID").toString();
				int logval=stmt.executeUpdate("insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values("+docno+","+brchName+",'"+formdetailcode+"',now(),"+userid+",'E')");
				if(logval<=0){
					return false;
				}
				else{
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

	public boolean delete(String location, String longitude, String latitude,
			String brchName, Date sqldate, HttpSession session, int docno,String formdetailcode) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int val=stmt.executeUpdate("update gl_cordinates set status=7 where doc_no="+docno);
			if(val<0){
				return false;
			}
			else{
				String userid=session.getAttribute("USERID").toString();
				int logval=stmt.executeUpdate("insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values("+docno+","+brchName+",'"+formdetailcode+"',now(),"+userid+",'D')");
				if(logval<=0){
					return false;
				}
				else{
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
	
	
	public JSONArray getSearchData() throws SQLException{
		Connection conn=null;
		JSONArray RESULTDATA=new JSONArray();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select doc_no,date,location,latitude,longitude from gl_cordinates where status=3";
			ResultSet rs=stmt.executeQuery(str);
			RESULTDATA=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	

}
	