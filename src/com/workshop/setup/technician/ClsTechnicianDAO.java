package com.workshop.setup.technician;

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

public class ClsTechnicianDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcom=new ClsCommon();
	public int insert(String name,Date date,String accno,String mobno,String email,String actalstdcost,ArrayList<String> techjobarray,String formcode,HttpSession session,HttpServletRequest request) throws SQLException{
	
		String brchid=session.getAttribute("BRANCHID").toString();
		String user=session.getAttribute("USERID").toString();
		
		Connection conn=null;
		String docnotbl="";
		int docnotble=0;;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String insertsql="insert into ws_technician (date ,name,acno,email,mobile,stdcost,brhid, userid, status) values "
					+ " ('"+date+"','"+name+"','"+accno+"','"+email+"','"+mobno+"','"+actalstdcost+"',"+brchid+","+user+",3) ";
			int insval=stmt.executeUpdate(insertsql);
			if(insval<0){
				return 0;
			}
			else{
				String docsql="select max(doc_no) docno from ws_technician";
				
				ResultSet rs=stmt.executeQuery(docsql);
				while(rs.next()){
					docnotbl=rs.getString("docno");
				}
				
				stmt.close();
				CallableStatement stmt1;
				for(int i=0;i< techjobarray.size();i++){
					String[] techjob=techjobarray.get(i).split("::");
					if(!techjob[0].trim().equalsIgnoreCase("undefined") && !techjob[0].trim().equalsIgnoreCase("NaN") && !techjob[0].trim().equalsIgnoreCase("")){
							stmt1 = conn.prepareCall("insert into ws_techniciand   (rdocno, jobid ) values(?, ?)");
							 stmt1.setString(1,docnotbl); //docNo 
							stmt1.setInt(2,(techjob[0].trim().equalsIgnoreCase("undefined") || techjob[0].trim().equalsIgnoreCase("NaN") || techjob[0].trim().equalsIgnoreCase("") || techjob[0].trim().isEmpty()?0:Integer.parseInt(techjob[0].trim()))); 
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
	
	public boolean edit(int docno,String name,Date date,String accno,String mobno,String email,String actalstdcost,
			ArrayList<String> techjobarray,String formcode,HttpSession session,HttpServletRequest request)throws SQLException{

		String brchid=session.getAttribute("BRANCHID").toString();
		String user=session.getAttribute("USERID").toString();
		
		Connection conn=null;
		conn=objconn.getMyConnection();
		try{
				
				conn.setAutoCommit(false);
				Statement stmt=conn.createStatement();
				String strupdate="update ws_technician  set date='"+date+"',name='"+name+"',"
						+ " acno='"+accno+"',email='"+email+"',mobile='"+mobno+"',stdcost='"+actalstdcost+"',brhid="+brchid+", userid="+user+" where doc_no="+docno+" ";
				//System.out.println("==editstrupdate=="+strupdate);
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<0){
					return false;
				}
				
				Statement stmtdel=conn.createStatement();
				String strdel="delete from ws_techniciand where rdocno="+docno+"";
				int delval=stmtdel.executeUpdate(strdel);
				if(delval<0){
					return false;
				}
				CallableStatement stmt1;
				for(int i=0;i< techjobarray.size();i++){
					String[] techjob=techjobarray.get(i).split("::");
					if(!techjob[0].trim().equalsIgnoreCase("undefined") && !techjob[0].trim().equalsIgnoreCase("NaN") && !techjob[0].trim().equalsIgnoreCase("")){
							stmt1 = conn.prepareCall("insert into ws_techniciand   (rdocno, jobid ) values(?, ?)");
							 stmt1.setInt(1,docno); //docNo 
							stmt1.setInt(2,(techjob[0].trim().equalsIgnoreCase("undefined") || techjob[0].trim().equalsIgnoreCase("NaN") || techjob[0].trim().equalsIgnoreCase("") || techjob[0].trim().isEmpty()?0:Integer.parseInt(techjob[0].trim()))); 
							//System.out.println(stmt1);
							int data2 = stmt1.executeUpdate();
						  	if(data2<=0){
						  		stmt.close();
						        conn.close();
						      }
						   }
				    }
				
				conn.commit();
				return true;
				
		}catch(Exception e){
				e.printStackTrace();
				conn.close();
		}finally{
			conn.close();
		}
		return true;
	}
	
	public boolean delete(int docno, String mode,HttpSession session, HttpServletRequest request)throws SQLException {
		int errorstatus=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String strupdate="update ws_technician set status=7 where doc_no="+docno+"";
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval<0){
				return false;
			}
	
	
			conn.commit();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		
		return true;
	}
	
	
	public JSONArray loadJobmasteGrid(String docno,String check) throws SQLException{
		
		JSONArray jsa=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return jsa;
		}
		Connection conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		try{     
			conn=objconn.getMyConnection();
			String strsql="select jt.type jobtype,jm.desc1 jobdesc,jm.doc_no jobtypeid "
					+ " from  ws_technician m left join ws_techniciand d on m.doc_no=d.rdocno "
					+ " left join ws_jobmaster jm on d.jobid=jm.doc_no left join ws_jobtype jt "
					+ "on jm.jobid=jt.doc_no where m.doc_no="+docno+";";
			//System.out.println("strsql="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			
			jsa=objcom.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally	{
			conn.close();
		}
		return jsa;
		
	}
	public JSONArray loadSearchGrid() throws SQLException{
		Connection conn=objconn.getMyConnection();
		JSONArray jsa=new JSONArray();
		Statement stmt=conn.createStatement();
		try{     
			conn=objconn.getMyConnection();
			String strsql="select  tm.doc_no, tm.name, t.doc_no accdocno,t.account acno, email, mobile,t.description acname,tm.date, tm.stdcost stdcost "
					+ "from ws_technician tm  left join my_head t on tm.acno=t.doc_no where tm.status=3";
			ResultSet rsveh=stmt.executeQuery(strsql);
			
			jsa=objcom.convertToJSON(rsveh);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return jsa;
		
	}
	
	
	
	public JSONArray accountDetails(String account,String partyname,String contact,String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	  if(!(check.equalsIgnoreCase("1"))){
		  return RESULTDATA1;
	  }
	    try {
	    	    conn = objconn.getMyConnection();
		        Statement stmtAgeingStatement1 = conn.createStatement();
			
	    	    String sql = "";
            	
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.account like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	              /*  sql=sql+" and a.per_mob like '%"+contact+"%'";*/
	            }
	            
				sql = "select '' per_mob,t.doc_no,t.account,t.description from my_head t WHERE den=301 and m_s=0 "+sql;
						
				
				ResultSet resultSet1 = stmtAgeingStatement1.executeQuery(sql);
				
				RESULTDATA1=objcom.convertToJSON(resultSet1);
				
				stmtAgeingStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
}
