package com.controlcentre.masters.salesmanmaster.insurancesurvivor;

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

public class ClsInsuranceSurvivorDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	ClsInsuranceSurvivorBean rentalagentBean=new ClsInsuranceSurvivorBean();
	Connection conn;
	
	public int insert( String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,String mail,String mobile,
			String formdetailcode,String cldocno,String cmbactive) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtRentalAgent = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtRentalAgent.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtRentalAgent.setString(1,code);
			stmtRentalAgent.setString(2,name);
			stmtRentalAgent.setDate(3, sqlStartDate);
			stmtRentalAgent.setString(4, txtaccno);
			stmtRentalAgent.setString(5,formdetailcode);
			stmtRentalAgent.setString(6,session.getAttribute("USERID").toString());
			stmtRentalAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtRentalAgent.setString(9,mode);
			stmtRentalAgent.setString(10, mobile);
			stmtRentalAgent.setString(11, mail);
			stmtRentalAgent.setString(12, cmbactive);
			stmtRentalAgent.executeQuery();

			docno=stmtRentalAgent.getInt("docNo");
			rentalagentBean.setDocno(docno);
			if (docno > 0) {
				Statement stmt=conn.createStatement();
				String strupdate="update my_salesman set cldocno="+cldocno+" where sal_type='"+formdetailcode+"' and doc_no="+docno+" and status=3";
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<=0){
					return 0;
				}
				else{
					conn.commit();
					stmtRentalAgent.close();
					conn.close();
					return docno;
				}
			}
			else if (docno == -1){
				stmtRentalAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtRentalAgent.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtRentalAgent.close();
				conn.close();
				return docno;
			}
			stmtRentalAgent.close();
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

	public int edit(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,
			String mail,String mobile,String formdetailcode,String cldocno,String cmbactive) throws SQLException {
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtRentalAgent = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtRentalAgent.setInt(8, docno);
			stmtRentalAgent.setString(1,code);
			stmtRentalAgent.setString(2,name);
			stmtRentalAgent.setDate(3, sqlStartDate);
			stmtRentalAgent.setString(4, txtaccno);
			stmtRentalAgent.setString(5,formdetailcode);
			stmtRentalAgent.setString(6,session.getAttribute("USERID").toString());
			stmtRentalAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtRentalAgent.setString(9,mode);
			stmtRentalAgent.setString(10, mobile);
			stmtRentalAgent.setString(11, mail);
			stmtRentalAgent.setString(12, cmbactive);
			stmtRentalAgent.executeUpdate();
			
			int documentNo=stmtRentalAgent.getInt("docNo");
			if (documentNo >= 0) {
				Statement stmt=conn.createStatement();
				String strupdate="update my_salesman set cldocno="+cldocno+" where sal_type='"+formdetailcode+"' and doc_no="+docno+" and status=3";
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<0){
					return 0;
				}
				else{
					conn.commit();
					stmtRentalAgent.close();
					conn.close();
					return 1;
				}
			}
			else if (documentNo == -1){
				stmtRentalAgent.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -2){
				stmtRentalAgent.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -3){
				stmtRentalAgent.close();
				conn.close();
				return documentNo;
			}
		 stmtRentalAgent.close();
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

	public boolean delete(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mail,String mobile,String formdetailcode,String cmbactive) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtRentalAgent = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtRentalAgent.setInt(8, docno);
			stmtRentalAgent.setString(1,code);
			stmtRentalAgent.setString(2,name);
			stmtRentalAgent.setDate(3, sqlStartDate);
			stmtRentalAgent.setString(4, txtaccno);
			stmtRentalAgent.setString(5,formdetailcode);
			stmtRentalAgent.setString(6,session.getAttribute("USERID").toString());
			stmtRentalAgent.setString(7,session.getAttribute("BRANCHID").toString());
			stmtRentalAgent.setString(9,mode);
			stmtRentalAgent.setString(10, mobile);
			stmtRentalAgent.setString(11, mail);
			stmtRentalAgent.setString(12, cmbactive);
			stmtRentalAgent.executeUpdate();
			
			int documentNo=stmtRentalAgent.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtRentalAgent.close();
				return true;
			}	
		  stmtRentalAgent.close();
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
	
	

	public  JSONArray searchDetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select ac.cldocno,ac.refname,sal.doc_no,sal.sal_code,sal.sal_name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description,sal.active "+
            			" from my_salesman sal left join my_head head on (sal.acc_no=head.doc_no) left join my_acbook ac on (sal.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on (ac.catid=cat.doc_no and cat.status=3 and cat.insurance=1) where sal.status=3 and sal.sal_type='WIS'";
            	
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
	
	
	public  JSONArray getVendorData(String docno,String clientname,String mobile,String email) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
				String sql="";
				if(!(clientname.equalsIgnoreCase(""))){
		             sql=sql+" and ac.refname like '%"+clientname+"%'";
		            }
		            if(!(docno.equalsIgnoreCase(""))){
		                sql=sql+" and ac.cldocno like '%"+docno+"%'";
		            }
		            if(!(email.equalsIgnoreCase("undefined"))&&!(email.equalsIgnoreCase(""))&&!(email.equalsIgnoreCase("0"))){
		            	sql=sql+" and ac.mail1 like '%"+email+"%'";
		    		}
		            if(!(mobile.equalsIgnoreCase("undefined"))&&!(mobile.equalsIgnoreCase(""))&&!(mobile.equalsIgnoreCase("0"))){
		            	sql=sql+" and ac.per_mob like '%"+mobile+"%'";
		    		}
				String sqldata="select refname,cldocno,per_mob,mail1 from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.dtype='crm' and ac.status=3"
						+ " and cat.status=3 and cat.insurance=1"+sql;
				System.out.println("Vendor Query:"+sqldata);
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
