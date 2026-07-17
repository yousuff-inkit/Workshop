package com.limousine.limosetup.airport;

import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import java.sql.*;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAirportDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public int insert(String iata, String airport, String location,String country, Date sqldate, String formdetailcode,HttpSession session,String brchname) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int  docno=0;
		try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		ResultSet rsdoc=stmt.executeQuery("select coalesce(max(doc_no)+1,1) docno from gl_airport");
		while(rsdoc.next()){
			docno=rsdoc.getInt("docno");
		}
		String userid=session.getAttribute("USERID").toString();
		int val=stmt.executeUpdate("insert into gl_airport(doc_no,date,iatacode,airport,location,country,status,brhid,userid)values("+docno+",'"+sqldate+"','"+iata+"','"+airport+"','"+location+"','"+country+"',3,"+brchname+","+userid+")");
		if(val>0){
			int logval=stmt.executeUpdate("insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values("+docno+","+brchname+",'"+formdetailcode+"',now(),"+userid+",'A')");
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
		return 0;
	}

	public boolean edit(String iata, String airport, String location,
			String country, Date sqldate, String formdetailcode,
			HttpSession session, int docno,String brchname) throws SQLException {
		// TODO Auto-generated method stub
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		int val=stmt.executeUpdate("update gl_airport set iatacode='"+iata+"',airport='"+airport+"',location='"+location+"',country='"+country+"' where doc_no="+docno);
		if(val<0){
			return false;
		}
		else{
			String userid=session.getAttribute("USERID").toString();
			int logval=stmt.executeUpdate("insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values("+docno+","+brchname+",'"+formdetailcode+"',now(),"+userid+",'E')");
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

	public boolean delete(String iata, String airport, String location,String country, Date sqldate, String formdetailcode,HttpSession session, int docno, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			int val=stmt.executeUpdate("update gl_airport set status=3 where doc_no="+docno);
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
			ResultSet rs=stmt.executeQuery("select doc_no,date,iatacode,airport,location,country from gl_airport where status<>7");
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
