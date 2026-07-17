package com.workshop.setup.bay;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsWorkBayDAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcom=new ClsCommon();
	public int insert(String code,String name,Date date,String jobid,String mode,String formdetailcode,HttpSession session, HttpServletRequest request) throws SQLException{
	
		Connection conn=null;
		String docnotbl="";
		int docnotble=0;
		String brchid=session.getAttribute("BRANCHID").toString();
		String user=session.getAttribute("USERID").toString();
		
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String insertsql="insert into ws_bay (date ,code,name,jobtypeid,brhid, userid, status) values "
					+ " ('"+date+"','"+code+"','"+name+"',"+jobid+","+brchid+","+user+",3) ";
			//doc_no date code name jobtypeid brhid userid status
			int insval=stmt.executeUpdate(insertsql);
			if(insval<0){
				return 0;
			}
			else{
				String docsql="select max(doc_no) docno from ws_bay";
				
				ResultSet rs=stmt.executeQuery(docsql);
				while(rs.next()){
					docnotbl=rs.getString("docno");
				}
				
			}
			  docnotble=Integer.parseInt(docnotbl);
			conn.commit();
			return docnotble;
		  }catch (Exception e){
			 e.printStackTrace();
			 conn.close();
		}
		finally{
			conn.close();
		}
		return docnotble;
	}
	
	public boolean edit(String code,String name,Date date,int docno,String jobid, String mode,String formdetailcode,HttpSession session, HttpServletRequest request)throws SQLException{
		Connection conn=null;
		String brchid=session.getAttribute("BRANCHID").toString();
		String user=session.getAttribute("USERID").toString();
		try{
				conn=objconn.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmt=conn.createStatement();
				String strupdate="update ws_bay set date='"+date+"',code='"+code+"',name='"+name+"',jobtypeid="+jobid+",brhid="+brchid+", userid="+user+" where doc_no="+docno+"";
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<0){
					return false;
				}
				conn.commit();
				return true;
		}catch(Exception e){
				e.printStackTrace();
				conn.close();
		}
		finally{
			conn.close();
		}
		
		return false;
	}
	
	public boolean delete(int docno, String mode,HttpSession session, HttpServletRequest request)throws SQLException {
		int errorstatus=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String strupdate="update ws_bay set status=7 where doc_no="+docno+"";
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval<0){
				return false;
			}
	
			conn.commit();
			return true;
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		
		return false;
	}
	
	public JSONArray loadgrid() throws SQLException{
		Connection conn=null;
		JSONArray jsa=new JSONArray();
		
		try{     
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sql="select  bm.doc_no, date, code, name, jobtypeid, type jobtype from  "
					+ "ws_bay bm left join ws_jobtype jt on bm.jobtypeid=jt.doc_no where bm.status=3";
			ResultSet rs=stmt.executeQuery(sql);
			jsa=objcom.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return jsa;
		
	}
}
