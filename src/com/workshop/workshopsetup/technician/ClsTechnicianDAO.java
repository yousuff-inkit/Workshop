package com.workshop.workshopsetup.technician;

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

public class ClsTechnicianDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsTechnicianBean checkinBean = new ClsTechnicianBean();
	Connection conn;
	
	public int insert( String code,String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,String mobile,String email,String formdetailcode) throws SQLException {
	System.out.println(email);
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtTechnician = conn.prepareCall("{call technicianDML(?,?,?,?,?,?,?,?,?,?,?)}");

			stmtTechnician.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtTechnician.setDate(1, sqlStartDate);
			stmtTechnician.setString(2,code);
			stmtTechnician.setString(3,name);
			stmtTechnician.setString(4,txtaccno);
			stmtTechnician.setString(5,email);
			stmtTechnician.setString(6,mobile);
			stmtTechnician.setString(7,session.getAttribute("BRANCHID").toString());
			stmtTechnician.setString(8,session.getAttribute("USERID").toString());
			stmtTechnician.setString(10,mode);
			stmtTechnician.setString(11, formdetailcode);
			stmtTechnician.executeUpdate();

			docno=stmtTechnician.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtTechnician.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtTechnician.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtTechnician.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtTechnician.close();
				conn.close();
				return docno;
			}
			stmtTechnician.close();
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

	public int edit( String code,String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mobile,String email,String formdetailcode) throws SQLException {
	
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtTechnician = conn.prepareCall("{call technicianDML(?,?,?,?,?,?,?,?,?,?,?)}");

			stmtTechnician.setInt(9, docno);
			stmtTechnician.setDate(1,sqlStartDate);
			stmtTechnician.setString(2,code);
			stmtTechnician.setString(3,name);
			stmtTechnician.setString(4,txtaccno);
			stmtTechnician.setString(5,email);
			stmtTechnician.setString(6,mobile);
			stmtTechnician.setString(7,session.getAttribute("BRANCHID").toString());
			stmtTechnician.setString(8,session.getAttribute("USERID").toString());
			stmtTechnician.setString(10,"E");
			stmtTechnician.setString(11, formdetailcode);
			stmtTechnician.executeUpdate();

			//System.out.println(mode);
			
			int documentNo=stmtTechnician.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtTechnician.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtTechnician.close();
				conn.close();
				return documentNo;
			}
			else if (docno == -2){
				stmtTechnician.close();
				conn.close();
				return documentNo;
			}
			else if (docno == -3){
				stmtTechnician.close();
				conn.close();
				return documentNo;
			}
			stmtTechnician.close();
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


	public boolean delete(String code, String name,Date sqlStartDate,int txtaccno,HttpSession session,String mode,int docno,String mobile,String email,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtTechnician = conn.prepareCall("{call technicianDML(?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtTechnician.setInt(9, docno);
			stmtTechnician.setDate(1,sqlStartDate);
			stmtTechnician.setString(2,code);
			stmtTechnician.setString(3,name);
			stmtTechnician.setInt(4,txtaccno);
			stmtTechnician.setString(5,email);
			stmtTechnician.setString(6,mobile);
			stmtTechnician.setString(7,session.getAttribute("BRANCHID").toString());
			stmtTechnician.setString(8,session.getAttribute("USERID").toString());
			stmtTechnician.setString(10,"D");
			stmtTechnician.setString(11, formdetailcode);
			stmtTechnician.executeUpdate();

			int documentNo=stmtTechnician.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtTechnician.close();
				return true;
			}	
			stmtTechnician.close();
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

	public  List<ClsTechnicianBean> list() throws SQLException {
	    List<ClsTechnicianBean> listBean = new ArrayList<ClsTechnicianBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtSalesAgent = conn.createStatement();
	        	
				ResultSet resultSet = stmtSalesAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.email,m2.description "+
				" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='CHK'");

				while (resultSet.next()) {
					
					ClsTechnicianBean bean = new ClsTechnicianBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.settechniciandate(resultSet.getString("date"));
					bean.setTxtaccno(resultSet.getInt("acc_no"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setEmail(resultSet.getString("email"));
					bean.setMobile(resultSet.getString("mobile"));
					bean.setHidacno(resultSet.getString("acdoc"));
					listBean.add(bean);
				}
				stmtSalesAgent.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}
	
	
	
	
	public  JSONArray searchDetails(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        String sqltest="";
        if(!(docno.equalsIgnoreCase("")) && !(docno.equalsIgnoreCase("0"))){
            sqltest=sqltest+" and wt.doc_no like '%"+docno+"%'";
        }
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select wt.doc_no,wt.code code,wt.name name,head.account acno,head.doc_no acdoc,wt.email,wt.mobile,wt.date,"
            			+ " head.description from gl_worktechnician wt left join my_head head on (wt.acno=head.doc_no) where wt.status=3 "+sqltest+"";
            	System.out.println("nidheesh"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public  JSONArray technitionMainSearch(String docno,String date,String code,String name) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select wt.doc_no,wt.code code,wt.name name,head.account acno,head.doc_no acdoc,wt.email,wt.mobile,wt.date,"
            			+ " head.description from gl_worktechnician wt left join my_head head on (wt.acno=head.doc_no) where wt.status=3;";
            	System.out.println("nidheesh"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
   }
