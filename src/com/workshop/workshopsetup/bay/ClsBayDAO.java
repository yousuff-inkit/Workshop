package com.workshop.workshopsetup.bay;

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

public class ClsBayDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsBayBean checkinBean = new ClsBayBean();
	Connection conn;
	
	public int insert( String code,String name,Date sqlStartDate,HttpSession session,String mode,String formdetailcode) throws SQLException {
	
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtBay = conn.prepareCall("{call bayDML(?,?,?,?,?,?,?,?)}");

			stmtBay.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtBay.setDate(1, sqlStartDate);
			stmtBay.setString(2,code);
			stmtBay.setString(3,name);
			stmtBay.setString(4,session.getAttribute("BRANCHID").toString());
			stmtBay.setString(5,session.getAttribute("USERID").toString());
			stmtBay.setString(7,mode);
			stmtBay.setString(8, formdetailcode);
			stmtBay.executeUpdate();

			docno=stmtBay.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtBay.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtBay.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtBay.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtBay.close();
				conn.close();
				return docno;
			}
			stmtBay.close();
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

	public int edit( String code,String name,Date sqlStartDate,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtBay = conn.prepareCall("{call bayDML(?,?,?,?,?,?,?,?)}");

			stmtBay.setInt(6,docno);
			stmtBay.setDate(1, sqlStartDate);
			stmtBay.setString(2,code);
			stmtBay.setString(3,name);
			stmtBay.setString(4,session.getAttribute("BRANCHID").toString());
			stmtBay.setString(5,session.getAttribute("USERID").toString());
			stmtBay.setString(7,"E");
			stmtBay.setString(8, formdetailcode);
			stmtBay.executeUpdate();


			//System.out.println(mode);
			
			int documentNo=stmtBay.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtBay.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtBay.close();
				conn.close();
				return documentNo;
			}
			else if (docno == -2){
				stmtBay.close();
				conn.close();
				return documentNo;
			}
			else if (docno == -3){
				stmtBay.close();
				conn.close();
				return documentNo;
			}
			stmtBay.close();
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


	public boolean delete(String code, String name,Date sqlStartDate,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtBay = conn.prepareCall("{call bayDML(?,?,?,?,?,?,?,?)}");

			stmtBay.setInt(6,docno);
			stmtBay.setDate(1, sqlStartDate);
			stmtBay.setString(2,code);
			stmtBay.setString(3,name);
			stmtBay.setString(4,session.getAttribute("BRANCHID").toString());
			stmtBay.setString(5,session.getAttribute("USERID").toString());
			stmtBay.setString(7,"D");
			stmtBay.setString(8, formdetailcode);
			stmtBay.executeUpdate();

			int documentNo=stmtBay.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtBay.close();
				return true;
			}	
			stmtBay.close();
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
/*
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
	}*/
	
	public  JSONArray getBayGrid(String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";
       
        if(!(docno.equalsIgnoreCase("")) && !(docno.equalsIgnoreCase("0"))){
            sqltest=sqltest+" and doc_no like '%"+docno+"%'";
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="select doc_no,date,code,name from gl_workbay where status=3 "+sqltest+" ";
                System.out.println(strsql);
            	ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public  JSONArray bayMainSearch(String docno,String date,String code,String name) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
    java.sql.Date sqlWorkDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlWorkDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docno.equalsIgnoreCase("")) && !(docno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and doc_no like '%"+docno+"%'";
        }
        if(!(name.equalsIgnoreCase(""))){
         sqltest=sqltest+" and name like '%"+name+"%'";
        }
        if(!(code.equalsIgnoreCase(""))){
         sqltest=sqltest+" and code like '%"+code+"%'";
        }
        if(!(sqlWorkDate==null)){
	         sqltest=sqltest+" and date='"+sqlWorkDate+"'";
	    } 
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="select doc_no,date,code,name from gl_workbay where status=3";
                System.out.println(strsql);
            	ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	
/*
	public  JSONArray stateGridSearch() throws SQLException {
        List<ClsBayBean> stateGridSearchBean = new ArrayList<ClsBayBean>();

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement ();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("select state from my_uaestatesm order by state");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }*/
	
	/*public  List<ClsBayBean> list() throws SQLException {
	    List<ClsBayBean> listBean = new ArrayList<ClsBayBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDriver = conn.createStatement();
	        	
				ResultSet resultSet = stmtDriver.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mail,m1.authority,m2.description,m1.external from "+
						" my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='DRV'");

				while (resultSet.next()) {
					
					ClsBayBean bean = new ClsBayBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.setDriverdate(resultSet.getDate("date"));
					bean.setTxtaccno(resultSet.getInt("acc_no"));
					bean.setMail(resultSet.getString("mail"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setAuthority(resultSet.getString("authority"));
					bean.setHidacno(resultSet.getString("acdoc"));

					bean.setExternal(resultSet.getInt("external"));

	            	listBean.add(bean);
				}
				stmtDriver.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}*/
}
