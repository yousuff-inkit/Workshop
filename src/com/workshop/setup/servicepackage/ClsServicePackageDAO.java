package com.workshop.setup.servicepackage;

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

	public class ClsServicePackageDAO {
		ClsConnection ClsConnection=new ClsConnection();	
		ClsCommon ClsCommon=new ClsCommon();
	public int insert( String complaint, Date sqlStartDate, HttpSession session, String mode,
			String formdetailcode, String code, String name, String amount,ArrayList<String> descarray) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			int doc;
		    conn.setAutoCommit(false);
			CallableStatement stmtsave = conn.prepareCall("{call servicePackageDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtsave.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtsave.setString(1,code);
			stmtsave.setString(2,name);
			stmtsave.setString(3,amount);
			stmtsave.setDate(4,sqlStartDate);
			stmtsave.setString(6,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(7,mode);
			stmtsave.setString(8,formdetailcode);
			stmtsave.executeQuery();
			
			doc=stmtsave.getInt("docNo");
			int resultSetd=0;
			if (doc > 0) {
				Statement stmt=conn.createStatement();
				for(int i=0;i< descarray.size() ;i++){
					String[] descgridarray=((String) descarray.get(i)).split("::");
					if(!((descgridarray[0].trim().equalsIgnoreCase("0"))||(descgridarray[0].trim().equalsIgnoreCase("undefined")) ||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty())){
						String tclsql="";
						int j=1;
						tclsql="INSERT INTO ws_servicepackaged(rdocno, jobdocno, srno, status) values("+doc+","
								+ "'"+(descgridarray[0].trim().equalsIgnoreCase("undefined")||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty()?0:descgridarray[0].trim())+"',"+(i+1)+",3)";

						System.out.println("==tclsql===="+tclsql);

						resultSetd = stmt.executeUpdate (tclsql);
						j=j+1;
					}
					if(resultSetd<=0)
					{

						return 0; 
					}


				}
				conn.commit();
				stmtsave.close();
				conn.close();
				return doc;
			}
			stmtsave.close();
			conn.close();
		}catch(Exception e){	
		    e.printStackTrace();
		    conn.close();
		    return 0;
		}finally{
			conn.close();
		}
		return 0;
	}
	
	
	public boolean edit(String complaint, Date sqlStartDate,HttpSession session, String mode, 
			String formdetailcode, int docno, String code, String name, String amount,ArrayList<String> descarray) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			
CallableStatement stmtsave = conn.prepareCall("{call servicePackageDML(?,?,?,?,?,?,?,?,?)}");
			System.out.println("Action:"+code+name+amount+mode);
			System.out.println("Doc:"+docno);
			stmtsave.setInt(9, docno);
			stmtsave.setString(1,code);
			stmtsave.setString(2,name);
			stmtsave.setString(3,amount);
			stmtsave.setDate(4,sqlStartDate);
			stmtsave.setString(6,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(7,mode);
			stmtsave.setString(8,formdetailcode);
		
			int data = stmtsave.executeUpdate();
			int resultSetd=0;
			if (data>0) {
				Statement stmt=conn.createStatement();
				String strdelete="delete from ws_servicepackaged where rdocno="+docno;
				int deleteval=stmt.executeUpdate(strdelete);
				for(int i=0;i< descarray.size() ;i++){
					String[] descgridarray=((String) descarray.get(i)).split("::");
					if(!((descgridarray[0].trim().equalsIgnoreCase("0"))||(descgridarray[0].trim().equalsIgnoreCase("undefined")) ||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty())){
						String tclsql="";
						int j=1;
						tclsql="INSERT INTO ws_servicepackaged(rdocno, jobdocno, srno, status) values("+docno+","
								+ "'"+(descgridarray[0].trim().equalsIgnoreCase("undefined")||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty()?0:descgridarray[0].trim())+"',"+(i+1)+",3)";

						System.out.println("==tclsql===="+tclsql);

						resultSetd = stmt.executeUpdate (tclsql);
						j=j+1;
					}
					if(resultSetd<=0)
					{

						return false; 
					}


				}
				
				stmtsave.close();
				conn.close();
				return true;
			}
	
			stmtsave.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}
	
	public boolean delete(HttpSession session, String mode, String formdetailcode, int docno) throws SQLException {
		
		Connection conn=null;
		
		try{
			conn=ClsConnection.getMyConnection();
			
CallableStatement stmtsave = conn.prepareCall("{call servicePackageDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtsave.setInt(9, docno);
			stmtsave.setString(1,"");
			stmtsave.setString(2,"");
			stmtsave.setString(3,"0.0");
			stmtsave.setDate(4,null);
			stmtsave.setString(6,session.getAttribute("BRANCHID").toString());
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(7,mode);
			stmtsave.setString(8,formdetailcode);
			
			int data = stmtsave.executeUpdate();
			
			if (data>0) {
				stmtsave.close();
				conn.close();	
				return true;
			}
			stmtsave.close();
			conn.close();	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}
	
	public  JSONArray mainserch() throws SQLException {
	
	    JSONArray RESULTDATA=new JSONArray();
	  
	    Connection conn = null;
	   
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement();
	        	
			//	String resql=("select docno, mtype, name, DATE_FORMAT(date,'%d.%m.%Y') date from gl_vrepm where status=3 ");
				
				String resql=("select doc_no,code,name,amount, date from ws_servicepackage where status=3 ");
				
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtrelode.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	public JSONArray getServicePackData(String docno) throws SQLException{

	    JSONArray RESULTDATA=new JSONArray();
	  
	    Connection conn = null;
	   
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement();
	        	
			//	String resql=("select docno, mtype, name, DATE_FORMAT(date,'%d.%m.%Y') date from gl_vrepm where status=3 ");
				
				String resql=("select jm.doc_no jobdocno, jm.date jobdate,  jm.desc1 jobdesc, type jobtype from ws_servicepackaged "+
				" d left join ws_jobmaster jm on (d.jobdocno=jm.doc_no) left join ws_jobtype jt on "+
				" jm.jobid=jt.doc_no where d.rdocno="+docno);
				System.out.println(resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtrelode.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;

	}
}
	
