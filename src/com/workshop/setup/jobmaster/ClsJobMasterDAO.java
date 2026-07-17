package com.workshop.setup.jobmaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobMasterDAO {
	
	

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcom=new ClsCommon();
	public int insert( String jobtypeid,String desc,Date date,String  mode,String formdetcode,
			String stdrate,String stdcostperhr,ArrayList<String> jobarray,HttpSession session, HttpServletRequest request) throws SQLException{
	
		Connection conn=null;
		String docnotbl="";
		int docnotble=0;
		String brchid=session.getAttribute("BRANCHID").toString();
		String user=session.getAttribute("USERID").toString();
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			session.getAttribute("USERID").toString();
			
			
			String insertsql="insert into ws_jobmaster (date, jobid, desc1,stdrate,stdcostperhr, status, userid, brhid) values "
					+ " ('"+date+"',"+jobtypeid+",'"+desc+"','"+stdrate+"','"+stdcostperhr+"',3,"+user+","+brchid+") ";
			
			//doc_no date code name jobtypeid brhid userid status
			int insval=stmt.executeUpdate(insertsql);
			if(insval<0){
				return 0;
			}
			else{
				String docsql="select max(doc_no) docno from ws_jobmaster";
				
				ResultSet rs=stmt.executeQuery(docsql);
				while(rs.next()){
					docnotbl=rs.getString("docno");
				}
				CallableStatement stmt1;
				for(int i=0;i< jobarray.size();i++){
					String[] techjob=jobarray.get(i).split("::");
					if(!techjob[0].trim().equalsIgnoreCase("undefined") && !techjob[0].trim().equalsIgnoreCase("NaN") && !techjob[0].trim().equalsIgnoreCase("")){
							stmt1 = conn.prepareCall("insert into ws_jobmasterd   (rdocno, jobdesc ) values(?, ?)");
							 stmt1.setString(1,docnotbl); //docNo 
							stmt1.setString(2,(techjob[0].trim().equalsIgnoreCase("undefined") || techjob[0].trim().equalsIgnoreCase("NaN") || techjob[0].trim().equalsIgnoreCase("") || techjob[0].trim().isEmpty()?"0":techjob[0].trim())); 
							//System.out.println(stmt1);
							int data2 = stmt1.executeUpdate();
						  	if(data2<=0){
						  		stmt.close();
						        conn.close();
						      }
						   }
				    }
				
				
				
			}
			  docnotble=Integer.parseInt(docnotbl);
			conn.commit();
			return docnotble;
		  }catch (Exception e){
			 e.printStackTrace();
			 conn.close();
		}finally{
			conn.close();
		}
		return docnotble;
	}
	
	public boolean edit(int doc_no,String jobtypeid,String desc,Date date,String  mode,String formdetcode,String stdrate,String stdcostperhr,ArrayList<String> jobarray,
			HttpSession session, HttpServletRequest request)throws SQLException{
		Connection conn=null;
		String brchid=session.getAttribute("BRANCHID").toString();
		String user=session.getAttribute("USERID").toString();
		try{
				conn=objconn.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmt=conn.createStatement();
				String strupdate="update ws_jobmaster set date='"+date+"', jobid="+jobtypeid+", desc1='"+desc+"', stdrate='"+stdrate+"' ,stdcostperhr='"+stdcostperhr+"', "
						+ " userid="+brchid+", brhid="+user+" where doc_no="+doc_no+"";
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<0){
					return false;
				}
				

				Statement stmtdel=conn.createStatement();
				String strdel="delete from ws_jobmasterd where rdocno="+doc_no+"";
				int delval=stmtdel.executeUpdate(strdel);
				if(delval<0){
					return false;
				}
				CallableStatement stmt1;
				for(int i=0;i< jobarray.size();i++){
					String[] techjob=jobarray.get(i).split("::");
					if(!techjob[0].trim().equalsIgnoreCase("undefined") && !techjob[0].trim().equalsIgnoreCase("NaN") && !techjob[0].trim().equalsIgnoreCase("")){
						stmt1 = conn.prepareCall("insert into ws_jobmasterd   (rdocno, jobdesc ) values(?, ?)");
						 stmt1.setInt(1,doc_no); //docNo 
						stmt1.setString(2,(techjob[0].trim().equalsIgnoreCase("undefined") || techjob[0].trim().equalsIgnoreCase("NaN") || techjob[0].trim().equalsIgnoreCase("") || techjob[0].trim().isEmpty()?"0":techjob[0].trim())); 
						//System.out.println(stmt1);
						int data2 = stmt1.executeUpdate();
					  	if(data2<=0){
					  		stmt.close();
					        conn.close();
					      }
					   }
				    }
				
				
				
				
		
		
				
				
				
				conn.commit();
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			conn.close();
		}
		
		return true;
	}
	
	public boolean delete(int docno, String mode,HttpSession session, HttpServletRequest request)throws SQLException {
		Connection conn=null;

		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			
			Statement stmt=conn.createStatement();
			String strupdate="update ws_jobmaster set status=7 where doc_no="+docno+"";
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval<0){
				return false;
			}

			conn.commit();
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return true;
	}
	
	public JSONArray loadgrid() throws SQLException{
		Connection conn=objconn.getMyConnection();
		JSONArray jsa=new JSONArray();
		Statement stmt=conn.createStatement();
		try{     
			
			conn=objconn.getMyConnection();
			String strsql="select jm.doc_no, date,  desc1 as 'desc', type,jobid, stdrate,stdcostperhr from ws_jobmaster jm left join ws_jobtype jt on jm.jobid=jt.doc_no where jm.status=3";
			//System.out.println(strsql);
			ResultSet rsveh=stmt.executeQuery(strsql);
			
			jsa=objcom.convertToJSON(rsveh);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jsa;
		
	}
	
	public JSONArray loadgrid(String docno) throws SQLException{
		
		JSONArray jsa=new JSONArray();
		if(docno.equalsIgnoreCase("")||docno.equalsIgnoreCase("undefined") ||docno==null||docno.equalsIgnoreCase("0")){
			return jsa;
		}
		Connection conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		try{     
			
			conn=objconn.getMyConnection();
			String strsql="select  jobdesc  as 'desc' from ws_jobmasterd where rdocno="+docno+";";
			System.out.println(strsql);
			ResultSet rsveh=stmt.executeQuery(strsql);
			
			jsa=objcom.convertToJSON(rsveh);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jsa;
		
	}
	
	
	

}
