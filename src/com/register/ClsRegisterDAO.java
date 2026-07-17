package com.register;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;

public class ClsRegisterDAO {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	ClsRegisterBean registerBean=new ClsRegisterBean();
	
	public int insert(String txtcompid, String txtcompname,String txtaddress, String txttel, String txtemail, String txtproduct, String txtproduct2, String cmbtimezone,
			String txtbranchid, String txtbranchname, String txtbranchaddress, String txtbranchtel, String txtbranchemail, String txtuserid, String txtusername, 
			String txtuserpassword, String txtuserpasswordconfirm, String txtuseremail) throws SQLException {
			
		    Connection conn=null;
		  
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			java.sql.Date sqlAccStartDate = null;
		    java.sql.Date sqlAccEndDate = null;
		     
			Statement stmtRegister=conn.createStatement();
			
			String sql="select comp_id from my_comp where status<>7 and comp_id='"+txtcompid+"'";
			ResultSet resultSet = stmtRegister.executeQuery(sql);
			if(resultSet.next()){
				System.out.println("************ COMPANY ALREADY EXISTS ************");	
				return -1;
			}
			
			String sql1="select CONCAT(YEAR(CURDATE()),'-01-01') accStart,CONCAT(YEAR(CURDATE()),'-12-31') accEnd";
			ResultSet resultSet1 = stmtRegister.executeQuery(sql1);
			if(resultSet1.next()){
				sqlAccStartDate=resultSet1.getDate("accStart");
				sqlAccEndDate=resultSet1.getDate("accEnd");
			}
			
			/*Company Saving*/
			CallableStatement stmtCompany = conn.prepareCall("{call vehCompDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
	
			stmtCompany.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtCompany.setString(1,txtcompid); //Company ID
			stmtCompany.setString(2,txtcompname); //Company Name
			stmtCompany.setString(3, txtaddress); //Company Address
			stmtCompany.setString(4, ""); //PB No
			stmtCompany.setString(5, txttel); //Tel
			stmtCompany.setString(6, ""); //Tel2
			stmtCompany.setString(7, ""); //Fax
			stmtCompany.setString(8, ""); //Fax2
			stmtCompany.setString(9, txtemail); //Email
			stmtCompany.setString(10, ""); //Web
			stmtCompany.setDate(11, sqlAccStartDate); //Accounting Year start
			stmtCompany.setDate(12, sqlAccEndDate); //Accounting Year end
			stmtCompany.setString(13,"1"); //Currency ID
			stmtCompany.setString(14,"1"); //User ID
			stmtCompany.setString(15,"1"); //Branch ID
			stmtCompany.setString(17,"A"); //Mode
			stmtCompany.setString(18,"COM"); //Dtype
			stmtCompany.setString(19,cmbtimezone); //Time zone
			stmtCompany.executeQuery();
			String compDocNo=stmtCompany.getString("docNo");
			
			/*Company Saving Ends*/
			
			if (Integer.parseInt(compDocNo) > 0) {
				
				/*Product Key in my_comp*/
				String sql2="update my_comp set product_key='"+txtproduct+"',comp_refid="+compDocNo+" where status=3 and doc_no="+compDocNo+"";
				int data = stmtRegister.executeUpdate(sql2);
				/*Product Key in my_comp Ends*/
	
				/*Branch Saving*/
				CallableStatement stmtBranch = conn.prepareCall("{call vehBranchDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtBranch.setString(1, compDocNo);
				stmtBranch.setString(2, txtbranchid);
				stmtBranch.setString(3, txtbranchname);
				stmtBranch.setString(4, txtbranchaddress);
				stmtBranch.setString(5, "");
				stmtBranch.setString(6, txtbranchtel);
				stmtBranch.setString(7, "");
				stmtBranch.setString(8, "");
				stmtBranch.setString(9, "");
				stmtBranch.setString(10, txtbranchemail);
				stmtBranch.setString(11, "");
				stmtBranch.setString(12, "");
				stmtBranch.setString(13, "");
				stmtBranch.setString(14,"");
				stmtBranch.setInt(15, 0);
				stmtBranch.setDate(16, sqlAccStartDate);
				stmtBranch.setDate(17, sqlAccEndDate);
				stmtBranch.setString(18, "1");
				stmtBranch.setString(20, "1");
				stmtBranch.setString(19, "1");
				stmtBranch.setString(22, "A");
				stmtBranch.setString(23, "BRH");
				stmtBranch.executeQuery();
				String branchDocNo=stmtBranch.getString("docNo");
				/*Branch Saving Ends*/
	
				if (Integer.parseInt(branchDocNo) > 0) {
					
					/*Main Branch in my_brch*/
					String sql3="update my_brch set mainbranch=1 where status=3 and doc_no="+branchDocNo+"";
					int data1 = stmtRegister.executeUpdate(sql3);
					/*Main Branch in my_brch Ends*/
	
					/*User Saving*/
					CallableStatement stmtUser = conn.prepareCall("{CALL vehUserDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					stmtUser.registerOutParameter(10, java.sql.Types.INTEGER);
					stmtUser.setString(1,txtuserid);
					stmtUser.setString(2,ClsEncrypt.getInstance().encrypt(txtuserpassword));
					stmtUser.setString(3,txtusername);
					stmtUser.setInt(4,1);
					stmtUser.setString(5,"");
					stmtUser.setString(6,"");
					stmtUser.setString(7,"1");
					stmtUser.setString(8,"1");
					stmtUser.setString(9,"1");
					stmtUser.setString(11,"A");
					stmtUser.setDate(12,sqlAccStartDate);
					stmtUser.setString(13,"USR");
					stmtUser.setInt(14,1);
					stmtUser.setString(15,ClsEncrypt.getInstance().encrypt(""));
					stmtUser.setString(16,"");
					stmtUser.setString(17,"");
					stmtUser.setString(18,"");
					stmtUser.executeQuery();
					int userDocNo=stmtUser.getInt("docNo");
					/*User Saving Ends*/
					
					if (userDocNo > 0) {
						
						String sql4="INSERT INTO my_usrbr(user_id,brhid,cmpid) VALUES("+userDocNo+","+branchDocNo+","+compDocNo+")";	
						int resultSet2 = stmtRegister.executeUpdate(sql4);
						
						if(resultSet2<=0) {
							 stmtCompany.close();
							 stmtRegister.close();
							 stmtBranch.close();
							 stmtUser.close();
					 		 conn.close();
					 		 return 0;
					 	} else {	
						
					 		String sql5="INSERT INTO my_year(comp_id,accyr_f,accyr_t,cl_stat,cmpid, brhid) VALUES("+txtcompid+",'"+sqlAccStartDate+"','"+sqlAccEndDate+"',0,"+compDocNo+","+branchDocNo+")";	
							int resultSet3 = stmtRegister.executeUpdate(sql5);
							
							if(resultSet3<=0) {
								 stmtCompany.close();
								 stmtRegister.close();
								 stmtBranch.close();
								 stmtUser.close();
						 		 conn.close();
						 		 return 0;
						 	}
							
							conn.commit();
							stmtCompany.close();
							stmtRegister.close();
							stmtBranch.close();
							stmtUser.close();
							conn.close();
						
							return userDocNo;
					 	}
					}
					
					stmtUser.close();
					conn.close();
				}
				stmtBranch.close();
				conn.close();
			}
			stmtCompany.close();
			stmtRegister.close();
			conn.close();
	} catch(Exception e){	
		e.printStackTrace();
		conn.close();
	} finally{
		conn.close();
	}
	return 0;
  }
	
}
