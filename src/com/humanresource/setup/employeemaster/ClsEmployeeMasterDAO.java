package com.humanresource.setup.employeemaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsEmployeeMasterDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();


	 ClsEmployeeMasterBean employeemasterbean = new ClsEmployeeMasterBean();

	 public int insert(Date employeeMasterDate, String formdetailcode, String txtemployeeid, String txtemployeename, int txtempaccdocno, String cmbcurrency,Date employeeJoiningDate, String cmbempdesignation,
				String cmbempdepartment, String cmbpayrollcategory, double txtemptravels, String txtpermanentaddress, String txtpresentaddress, String txtpermanentmobile, String txtpresentmobile, String txtpermanentemail, 
				String txtpresentemail, String txtempcity, String txtempstate, String txtemppincode, int txtempnationalityid, String txtempreligion, String txtempnearestairport, String txtempplaceofbirth,
				Date employeeDateOfBirth, String cmbempsex,String cmbempbloodgroup, String cmbempmaritalstatus, String txtempfathername, String txtempmothername,String txtempspousename, String txtempotherdetails,
				String cmbempagentid, String txtbankemployeeid,String txtbankaccountno, String txtbankbranchname,String txtbankifsccode, ArrayList<String> monthlysalaryarray, ArrayList<String> documentsarray, 
				HttpSession session,HttpServletRequest request, String mode) throws SQLException {
			
		 		Connection conn = null;

		 		try{
		 			conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					Statement stmtEMPS = conn.createStatement();
					
		 			String company=session.getAttribute("COMPANYID").toString().trim();
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
					int docno;
					
					CallableStatement stmtEMP = conn.prepareCall("{CALL HR_employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					stmtEMP.registerOutParameter(42, java.sql.Types.INTEGER);
					stmtEMP.setDate(1,employeeMasterDate);
					stmtEMP.setString(2,txtemployeeid);
					stmtEMP.setString(3,txtemployeename);
					stmtEMP.setInt(4,txtempaccdocno);
					stmtEMP.setString(5,cmbcurrency);
					stmtEMP.setDate(6,employeeJoiningDate);
					stmtEMP.setString(7,cmbempdesignation);
					stmtEMP.setString(8,cmbempdepartment);
					stmtEMP.setString(9,cmbpayrollcategory);
					stmtEMP.setDouble(10,txtemptravels);
					stmtEMP.setString(11, txtpermanentaddress);
					stmtEMP.setString(12,txtpresentaddress);
					
					stmtEMP.setString(13,txtpermanentmobile);
					stmtEMP.setString(14,txtpresentmobile);
					stmtEMP.setString(15,txtpermanentemail);
					stmtEMP.setString(16,txtpresentemail);
					stmtEMP.setString(17,txtempcity);
					stmtEMP.setString(18,txtempstate);
					
					stmtEMP.setString(19,txtemppincode);
					stmtEMP.setInt(20,txtempnationalityid);
					stmtEMP.setString(21,txtempreligion);
					stmtEMP.setString(22,txtempnearestairport);
					stmtEMP.setString(23,txtempplaceofbirth);
					stmtEMP.setDate(24,employeeDateOfBirth);
					stmtEMP.setString(25,cmbempsex);
					stmtEMP.setString(26,cmbempbloodgroup);
					stmtEMP.setString(27,cmbempmaritalstatus);
					stmtEMP.setString(28,txtempfathername);
					stmtEMP.setString(29,txtempmothername);
					stmtEMP.setString(30,txtempspousename);
					stmtEMP.setString(31,txtempotherdetails);
					stmtEMP.setString(32,cmbempagentid);
					stmtEMP.setString(33,txtbankemployeeid);
					stmtEMP.setString(34,txtbankaccountno);
					stmtEMP.setString(35,txtbankbranchname);
					stmtEMP.setString(36,txtbankifsccode);

					stmtEMP.setString(37,formdetailcode);
					stmtEMP.setString(38,currency);
					stmtEMP.setString(39,company);
					stmtEMP.setString(40,branch);
					stmtEMP.setString(41,userid);
					stmtEMP.setString(43,mode);
					stmtEMP.executeQuery();
					docno=stmtEMP.getInt("docNo");
					
					employeemasterbean.setTxtempmasterdocno(docno);
					if (docno > 0) {
					int data=0;
					int data1=0;
					int j=0;
					int docNo=0;
					
					/*Monthly Salary Grid Saving*/
					for(int i=0;i< monthlysalaryarray.size();i++){
					CallableStatement stmtEMP1=null;
					
					String[] employee=monthlysalaryarray.get(i).split("::");
					if(!employee[0].equalsIgnoreCase("undefined") && !employee[0].equalsIgnoreCase("NaN")){
						
						if(i==0){
						
							String sqls="select coalesce(max(doc_no)+1,1) doc_no from hr_incrm where status=3";
							ResultSet resultSet = stmtEMPS.executeQuery(sqls);
				  
							while (resultSet.next()) {
								docNo=resultSet.getInt("doc_no");
							}
						
							String sql="insert into hr_incrm(date, month, year, empId, upto, deptId, catId, desigId,remarks,revised, revdeptId, revcatId, revdesigId,"
									+ "brhId, userId, cmpId, onHold, dtype, doc_no, status) values('"+employeeMasterDate+"', MONTH('"+employeeMasterDate+"'), "
									+ "YEAR('"+employeeMasterDate+"'), "+docno+", '"+employeeMasterDate+"', "+cmbempdepartment+", "+cmbpayrollcategory+", "+cmbempdesignation+","
									+ "'EMPLOYEE MASTER',0,0,0,0,'"+branch+"', '"+userid+"', '"+company+"', 0, '"+formdetailcode+"', "+docNo+", 3)";
							stmtEMPS.executeUpdate (sql);
						}
						
						if(!(employee[1].trim().equalsIgnoreCase("STD")) && ((!(employee[2].trim().equalsIgnoreCase("undefined")) && !(employee[2].trim().equalsIgnoreCase("NaN")) && !(employee[2].trim().equalsIgnoreCase("")) && !(employee[2].trim().isEmpty())) || ((!(employee[3].trim().equalsIgnoreCase("undefined")) && !(employee[3].trim().equalsIgnoreCase("NaN")) && !(employee[3].trim().equalsIgnoreCase("")) && !(employee[3].trim().isEmpty()))))){
					    
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1,docno); //doc_no
						stmtEMP1.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
						stmtEMP1.setString(3,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
						stmtEMP1.setString(4,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
						stmtEMP1.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
						stmtEMP1.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(7,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
						data = stmtEMP1.executeUpdate();
						
						if(data<=0){
							stmtEMP1.close();
							conn.close();
							return 0;
						}
						
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_incrd(sr_no, rdocno, awlId, refdtype, addition, deduction, statutorydeduction, revadd, revded, revstatded, remarks) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1, j); //sr_no
						stmtEMP1.setInt(2, docNo); //doc_no
						stmtEMP1.setString(3,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
						stmtEMP1.setString(4,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
						stmtEMP1.setString(5,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
						stmtEMP1.setString(6,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
						stmtEMP1.setString(7,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(8,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //rev. addition
							stmtEMP1.setString(9,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //rev. deduction
							stmtEMP1.setString(10,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //rev. statutorydeduction
						stmtEMP1.setString(11,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
						int datas = stmtEMP1.executeUpdate();
						
						if(datas<=0){
							stmtEMP1.close();
							conn.close();
							return 0;
						}
						
						j++;
						}
						
						if((employee[1].trim().equalsIgnoreCase("STD")) && (!(employee[4].trim().equalsIgnoreCase("undefined"))  && !(employee[4].trim().equalsIgnoreCase("NaN")) && !(employee[4].trim().equalsIgnoreCase("")) && !(employee[4].trim().isEmpty()))){
						    
							stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
							
							stmtEMP1.setInt(1,docno); //doc_no
							stmtEMP1.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
							stmtEMP1.setString(3,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
							stmtEMP1.setString(4,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
							stmtEMP1.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
							stmtEMP1.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
							stmtEMP1.setString(7,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
							data = stmtEMP1.executeUpdate();
							
							if(data<=0){
								stmtEMP1.close();
								conn.close();
								return 0;
							}
							
							stmtEMP1 = conn.prepareCall("INSERT INTO hr_incrd(sr_no, rdocno, awlId, refdtype, addition, deduction, statutorydeduction, revadd, revded, revstatded, remarks) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
							
							stmtEMP1.setInt(1, j); //sr_no
							stmtEMP1.setInt(2, docNo); //doc_no
							stmtEMP1.setString(3,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
							stmtEMP1.setString(4,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
							stmtEMP1.setString(5,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
							stmtEMP1.setString(6,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
							stmtEMP1.setString(7,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
							stmtEMP1.setString(8,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //rev. addition
							stmtEMP1.setString(9,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //rev. deduction
							stmtEMP1.setString(10,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //rev. statutorydeduction
							stmtEMP1.setString(11,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
							int datas = stmtEMP1.executeUpdate();
							
							if(datas<=0){
								stmtEMP1.close();
								conn.close();
								return 0;
							}
							
							j++;
						}
					  }
					}
					
					/*Documents Grid Saving*/
					for(int i=0;i< documentsarray.size();i++){
					CallableStatement stmtEMP2=null;
					String[] employee=documentsarray.get(i).split("::");
					if(!employee[0].equalsIgnoreCase("undefined") && !employee[0].equalsIgnoreCase("NaN")){
					    
						java.sql.Date issueDate=(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||  employee[1].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(employee[1].trim()));
						java.sql.Date expDate=(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||  employee[2].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(employee[2].trim()));
						
						stmtEMP2 = conn.prepareCall("INSERT INTO hr_empdoc(rdocno, docId, issdt, expdt, placeofiss, location, remarks, docIdnum) VALUES(?,?,?,?,?,?,?,?)");
						
						stmtEMP2.setInt(1,docno); //doc_no
						stmtEMP2.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //document Id
						stmtEMP2.setDate(3,issueDate); //issueDate
						stmtEMP2.setDate(4,expDate); //expDate
						stmtEMP2.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //Place of issue
						stmtEMP2.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //location
						stmtEMP2.setString(7,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
						stmtEMP2.setString(8,(employee[6].trim().equalsIgnoreCase("undefined") || employee[6].trim().equalsIgnoreCase("NaN") || employee[6].trim().equalsIgnoreCase("") ||employee[6].trim().isEmpty()?0:employee[6].trim()).toString()); //document Number
						data1 = stmtEMP2.executeUpdate();
						
						if(data1<=0){
							stmtEMP2.close();
							conn.close();
							return 0;
					   }
					 }
					}
					
					String sql1="delete from hr_empdoc where issdt is null and expdt is null and placeofiss=0 and location=0 and remarks=0 and rdocno="+docno+"";
					stmtEMPS.executeUpdate (sql1);
					
					conn.commit();
					stmtEMP.close();
					stmtEMPS.close();
					conn.close();
					return docno;
				}
					stmtEMP.close();
					conn.close();
					return docno;
			 }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		}

	 public int edit(int txtempmasterdocno, String formdetailcode, Date employeeMasterDate, String txtemployeeid, String txtemployeename, int txtempaccdocno, String cmbcurrency, Date employeeJoiningDate, 
			 String cmbempdesignation, String cmbempdepartment, String cmbpayrollcategory, double txtemptravels, String txtpermanentaddress, String txtpresentaddress, String txtpermanentmobile, String txtpresentmobile,
			 String txtpermanentemail, String txtpresentemail, String txtempcity, String txtempstate, String txtemppincode, int txtempnationalityid, String txtempreligion,
			 String txtempnearestairport, String txtempplaceofbirth, Date employeeDateOfBirth, String cmbempsex, String cmbempbloodgroup, String cmbempmaritalstatus,
			 String txtempfathername, String txtempmothername, String txtempspousename, String txtempotherdetails, String cmbempagentid, String txtbankemployeeid,
			 String txtbankaccountno, String txtbankbranchname, String txtbankifsccode, ArrayList<String> monthlysalaryarray, ArrayList<String> documentsarray, 
			 HttpSession session, String mode) throws SQLException {
		 
		 	Connection conn = null;
		 	
		 try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();
	 			String branch=session.getAttribute("BRANCHID").toString().trim();
	 			String currency=session.getAttribute("CURRENCYID").toString().trim();
	 			String userid=session.getAttribute("USERID").toString().trim();
	 			
	 			CallableStatement stmtEMP = conn.prepareCall("{CALL HR_employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtEMP.setInt(42,txtempmasterdocno);
				stmtEMP.setDate(1,employeeMasterDate);
				stmtEMP.setString(2,txtemployeeid);
				stmtEMP.setString(3,txtemployeename);
				stmtEMP.setInt(4,txtempaccdocno);
				stmtEMP.setString(5,cmbcurrency);
				stmtEMP.setDate(6,employeeJoiningDate);
				stmtEMP.setString(7,cmbempdesignation);
				stmtEMP.setString(8,cmbempdepartment);
				stmtEMP.setString(9,cmbpayrollcategory);
				stmtEMP.setDouble(10,txtemptravels);
				stmtEMP.setString(11, txtpermanentaddress);
				stmtEMP.setString(12,txtpresentaddress);
				
				stmtEMP.setString(13,txtpermanentmobile);
				stmtEMP.setString(14,txtpresentmobile);
				stmtEMP.setString(15,txtpermanentemail);
				stmtEMP.setString(16,txtpresentemail);
				stmtEMP.setString(17,txtempcity);
				stmtEMP.setString(18,txtempstate);
			
				stmtEMP.setString(19, txtemppincode);
				stmtEMP.setInt(20, txtempnationalityid);
				stmtEMP.setString(21, txtempreligion);
				stmtEMP.setString(22, txtempnearestairport);
				stmtEMP.setString(23, txtempplaceofbirth);
				stmtEMP.setDate(24, employeeDateOfBirth);
				stmtEMP.setString(25,cmbempsex);
				stmtEMP.setString(26,cmbempbloodgroup);
				stmtEMP.setString(27,cmbempmaritalstatus);
				stmtEMP.setString(28,txtempfathername);
				stmtEMP.setString(29,txtempmothername);
				stmtEMP.setString(30,txtempspousename);
				stmtEMP.setString(31,txtempotherdetails);
				stmtEMP.setString(32,cmbempagentid);
				stmtEMP.setString(33,txtbankemployeeid);
				stmtEMP.setString(34,txtbankaccountno);
				stmtEMP.setString(35,txtbankbranchname);
				stmtEMP.setString(36,txtbankifsccode);

				stmtEMP.setString(37,formdetailcode);
				stmtEMP.setString(38,currency);
				stmtEMP.setString(39,company);
				stmtEMP.setString(40,branch);
				stmtEMP.setString(41,userid);
				stmtEMP.setString(43,mode);
				stmtEMP.executeQuery();
				int docno=stmtEMP.getInt("docNo");
				
				employeemasterbean.setTxtempmasterdocno(docno);
				if (docno > 0) {
					int data=0,data1=0,appraisal=0,j=0;
					
					String sqls="select count(*) appraisal from hr_incrm where dtype!='EMP' and status=3 and empid="+docno+"";
					ResultSet resultSet = stmtEMP.executeQuery(sqls);
					   
					   while (resultSet.next()) {
					        appraisal=resultSet.getInt("appraisal");
					    }
					
					if(appraisal==0){
						
					String sql="DELETE FROM hr_empsal WHERE rdocno="+docno+"";
					stmtEMP.executeUpdate(sql);
					
					String sql1="DELETE FROM hr_incrd WHERE rdocno=(select coalesce(max(doc_no),0) from hr_incrm where status=3 and empid="+docno+")";
					stmtEMP.executeUpdate(sql1);
					
					/*Monthly Salary Grid Saving*/
					for(int i=0;i< monthlysalaryarray.size();i++){
					CallableStatement stmtEMP1=null;
					String[] employee=monthlysalaryarray.get(i).split("::");
					if(!employee[0].equalsIgnoreCase("undefined") && !employee[0].equalsIgnoreCase("NaN")){
						
						int docNo=0;
						String sql3="select coalesce(max(doc_no),0) doc_no from hr_incrm where status=3 and empid="+docno+"";
				        ResultSet resultSet1 = stmtEMP.executeQuery(sql3);
				  
				        while (resultSet1.next()) {
						   docNo=resultSet1.getInt("doc_no");
				        }
						
						if(i==0){
							
							String sql2="update hr_incrm set date='"+employeeMasterDate+"',month=MONTH('"+employeeMasterDate+"'),year=YEAR('"+employeeMasterDate+"'), "
									+ "empId="+docno+",upto='"+employeeMasterDate+"',deptId="+cmbempdepartment+",catId="+cmbpayrollcategory+",desigId="+cmbempdesignation+","
									+ "remarks='EMPLOYEE MASTER',brhId='"+branch+"', revised=0, revdeptId=0, revcatId=0, revdesigId=0, userId='"+userid+"',cmpId='"+company+"',"
									+ "onHold=0, status=3 where doc_no="+docNo+"";
							stmtEMP.executeUpdate (sql2);
							
						}
						
						if(!(employee[1].trim().equalsIgnoreCase("STD")) && ((!(employee[2].trim().equalsIgnoreCase("undefined")) && !(employee[2].trim().equalsIgnoreCase("NaN")) && !(employee[2].trim().equalsIgnoreCase("")) && !(employee[2].trim().isEmpty())) || ((!(employee[3].trim().equalsIgnoreCase("undefined")) && !(employee[3].trim().equalsIgnoreCase("NaN")) && !(employee[3].trim().equalsIgnoreCase("")) && !(employee[3].trim().isEmpty()))))){
					    
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1,docno); //doc_no
						stmtEMP1.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
						stmtEMP1.setString(3,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
						stmtEMP1.setString(4,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
						stmtEMP1.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
						stmtEMP1.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(7,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
						data = stmtEMP1.executeUpdate();
						
						if(data<=0){
							stmtEMP1.close();
							conn.close();
							return 0;
						}
						
						stmtEMP1 = conn.prepareCall("INSERT INTO hr_incrd(sr_no, rdocno, awlId, refdtype, addition, deduction, statutorydeduction, revadd, revded, revstatded, remarks) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
						
						stmtEMP1.setInt(1, j); //sr_no
						stmtEMP1.setInt(2, docNo); //doc_no
						stmtEMP1.setString(3,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
						stmtEMP1.setString(4,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
						stmtEMP1.setString(5,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
						stmtEMP1.setString(6,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
						stmtEMP1.setString(7,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
						stmtEMP1.setString(8,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //rev. addition
						stmtEMP1.setString(9,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //rev. deduction
						stmtEMP1.setString(10,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //rev. statutorydeduction
						stmtEMP1.setString(11,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
						int datas = stmtEMP1.executeUpdate();
						
						if(datas<=0){
							stmtEMP1.close();
							conn.close();
							return 0;
						}
						
						j++;
						
						stmtEMP1.close();
						}
						
						if((employee[1].trim().equalsIgnoreCase("STD")) && (!(employee[4].trim().equalsIgnoreCase("undefined"))  && !(employee[4].trim().equalsIgnoreCase("NaN")) && !(employee[4].trim().equalsIgnoreCase("")) && !(employee[4].trim().isEmpty()))){
						    
							stmtEMP1 = conn.prepareCall("INSERT INTO hr_empsal(rdocno, awlId, refdtype, addition, deduction, statutorydeduction, remarks) VALUES(?,?,?,?,?,?,?)");
							
							stmtEMP1.setInt(1,docno); //doc_no
							stmtEMP1.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
							stmtEMP1.setString(3,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
							stmtEMP1.setString(4,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
							stmtEMP1.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
							stmtEMP1.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
							stmtEMP1.setString(7,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
							data = stmtEMP1.executeUpdate();
							
							if(data<=0){
								stmtEMP1.close();
								conn.close();
								return 0;
							}
							
							stmtEMP1 = conn.prepareCall("INSERT INTO hr_incrd(sr_no, rdocno, awlId, refdtype, addition, deduction, statutorydeduction, revadd, revded, revstatded, remarks) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
							
							stmtEMP1.setInt(1,j); //sr_no
							stmtEMP1.setInt(2, docNo); //doc_no
							stmtEMP1.setString(3,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //allowance Id
							stmtEMP1.setString(4,(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||employee[1].trim().isEmpty()?0:employee[1].trim()).toString()); //refdtype
							stmtEMP1.setString(5,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //addition
							stmtEMP1.setString(6,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //deduction
							stmtEMP1.setString(7,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //statutorydeduction
							stmtEMP1.setString(8,(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||employee[2].trim().isEmpty()?0:employee[2].trim()).toString()); //rev. addition
							stmtEMP1.setString(9,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //rev. deduction
							stmtEMP1.setString(10,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //rev. statutorydeduction
							stmtEMP1.setString(11,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
							int datas = stmtEMP1.executeUpdate();
							
							if(datas<=0){
								stmtEMP1.close();
								conn.close();
								return 0;
							}
							
							j++;
							
							stmtEMP1.close();
						}
					  }
					}
					
					}
					
					String sql1="DELETE FROM hr_empdoc WHERE rdocno="+docno+"";
					stmtEMP.executeUpdate (sql1);
					
					/*Documents Grid Saving*/
					for(int i=0;i< documentsarray.size();i++){
					CallableStatement stmtEMP2=null;
					String[] employee=documentsarray.get(i).split("::");
					if(!employee[0].equalsIgnoreCase("undefined") && !employee[0].equalsIgnoreCase("NaN")){
					    
						java.sql.Date issueDate=(employee[1].trim().equalsIgnoreCase("undefined") || employee[1].trim().equalsIgnoreCase("NaN") || employee[1].trim().equalsIgnoreCase("") ||  employee[1].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(employee[1].trim()));
						java.sql.Date expDate=(employee[2].trim().equalsIgnoreCase("undefined") || employee[2].trim().equalsIgnoreCase("NaN") || employee[2].trim().equalsIgnoreCase("") ||  employee[2].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(employee[2].trim()));
						
						stmtEMP2 = conn.prepareCall("INSERT INTO hr_empdoc(rdocno, docId, issdt, expdt, placeofiss, location, remarks, docIdnum) VALUES(?,?,?,?,?,?,?,?)");
						
						stmtEMP2.setInt(1,docno); //doc_no
						stmtEMP2.setString(2,(employee[0].trim().equalsIgnoreCase("undefined") || employee[0].trim().equalsIgnoreCase("NaN") || employee[0].trim().equalsIgnoreCase("") ||employee[0].trim().isEmpty()?0:employee[0].trim()).toString()); //document Id
						stmtEMP2.setDate(3,issueDate); //issueDate
						stmtEMP2.setDate(4,expDate); //expDate
						stmtEMP2.setString(5,(employee[3].trim().equalsIgnoreCase("undefined") || employee[3].trim().equalsIgnoreCase("NaN") || employee[3].trim().equalsIgnoreCase("") ||employee[3].trim().isEmpty()?0:employee[3].trim()).toString()); //Place of issue
						stmtEMP2.setString(6,(employee[4].trim().equalsIgnoreCase("undefined") || employee[4].trim().equalsIgnoreCase("NaN") || employee[4].trim().equalsIgnoreCase("") ||employee[4].trim().isEmpty()?0:employee[4].trim()).toString()); //location
						stmtEMP2.setString(7,(employee[5].trim().equalsIgnoreCase("undefined") || employee[5].trim().equalsIgnoreCase("NaN") || employee[5].trim().equalsIgnoreCase("") ||employee[5].trim().isEmpty()?0:employee[5].trim()).toString()); //remarks
						stmtEMP2.setString(8,(employee[6].trim().equalsIgnoreCase("undefined") || employee[6].trim().equalsIgnoreCase("NaN") || employee[6].trim().equalsIgnoreCase("") ||employee[6].trim().isEmpty()?0:employee[6].trim()).toString()); //document Number
						data1 = stmtEMP2.executeUpdate();
						
						if(data1<=0){
							stmtEMP2.close();
							conn.close();
							return 0;
					   }
					 }
					 stmtEMP2.close();
					}
					
					String sql2="delete from hr_empdoc where issdt is null and expdt is null and placeofiss=0 and location=0 and remarks=0 and rdocno="+docno+"";
					stmtEMP.executeUpdate (sql2);
					
					conn.commit();
					stmtEMP.close();
					conn.close();
					return 1;
				}	
				stmtEMP.close();
				conn.close();
				return 1;
		 }catch(Exception e){
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
		}

		public int delete(int txtempmasterdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			
			Connection conn = null;
		 
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String company=session.getAttribute("COMPANYID").toString().trim();
	 		String branch=session.getAttribute("BRANCHID").toString().trim();
	 		String currency=session.getAttribute("CURRENCYID").toString().trim();
	 		String userid=session.getAttribute("USERID").toString().trim();
			
	 		CallableStatement stmtEMP = conn.prepareCall("{CALL HR_employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtEMP.setInt(41,txtempmasterdocno);
			stmtEMP.setDate(1,null);
			stmtEMP.setString(2,null);
			stmtEMP.setString(3,null);
			stmtEMP.setInt(4,0);
			stmtEMP.setDate(5,null);
			stmtEMP.setString(6,null);
			stmtEMP.setString(7,null);
			stmtEMP.setString(8,null);
			stmtEMP.setString(9,null);
			stmtEMP.setString(10,null);
			stmtEMP.setString(11,null);
			
			stmtEMP.setString(12,null);
			stmtEMP.setString(13,null);
			stmtEMP.setString(14,null);
			stmtEMP.setString(15,null);
			stmtEMP.setString(16,null);
			stmtEMP.setString(17,null);
			
			stmtEMP.setString(18,null);
			stmtEMP.setInt(19,0);
			stmtEMP.setString(20,null);
			stmtEMP.setString(21,null);
			stmtEMP.setString(22,null);
			stmtEMP.setDate(23,null);
			stmtEMP.setString(24,null);
			stmtEMP.setString(25,null);
			stmtEMP.setString(26,null);
			stmtEMP.setString(27,null);
			stmtEMP.setString(28,null);
			stmtEMP.setString(29,null);
			stmtEMP.setString(30,null);
			stmtEMP.setString(31,null);
			stmtEMP.setString(32,null);
			stmtEMP.setString(33,null);
			stmtEMP.setString(34,null);
			stmtEMP.setString(35,null);

			stmtEMP.setString(36,formdetailcode);
			stmtEMP.setString(37,currency);
			stmtEMP.setString(38,company);
			stmtEMP.setString(39,branch);
			stmtEMP.setString(40,userid);
			stmtEMP.setString(42,mode);
			stmtEMP.executeQuery();
			int docno=stmtEMP.getInt("docNo");
			employeemasterbean.setTxtempmasterdocno(docno);
			if (docno > 0) {
				
				conn.commit();
				stmtEMP.close();
				conn.close();
				return 1;
			}
			if (docno == -1){
				stmtEMP.close();
				conn.close();
				return docno;
			}
			stmtEMP.close();
			conn.close();
			return 0;
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
  }
     
		public  ClsEmployeeMasterBean getViewDetails(int docNo) throws SQLException {
			
			ClsEmployeeMasterBean employeemasterbean = new ClsEmployeeMasterBean();
			
			Connection conn = null;
			
			try {
			
				conn = ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtEMP = conn.createStatement();

				String sql= ("select m.date, m.codeNo, m.name, m.dtjoin, m.acno, m.acc_curid, round(m.travels,2) travels, m.pmaddr, m.praddr, m.pmmob, m.prmob, m.pmemail, m.premail, m.city, m.state,"  
						+ "m.pincode, m.religion, m.nairport, m.pob, m.dob, m.nationId, m.mstatus, m.Gender, m.fatherName, m.motherName, m.bloodGroup,if(m.active=1,'ACTIVE','TERMINATED') empstatus," 
						+ "m.spouseName, m.others,m.agent_id, m.bnk_acc_no, m.emp_id, m.brchname, m.ifsccode, m.desc_id, m.dept_id, m.pay_catid,"  
						+ "h.account,h.description accountname,n.nation from hr_empm m left join my_head h on m.acno=h.doc_no left join my_natm n on m.nationId=n.doc_no "
						+ "where m.doc_no="+docNo+"");
				
				ResultSet resultSet = stmtEMP.executeQuery(sql);
							
				while (resultSet.next()) {
					
					employeemasterbean.setEmployeeDate(resultSet.getDate("date").toString());
					employeemasterbean.setTxtemployeeid(resultSet.getString("codeNo"));
					employeemasterbean.setTxtemployeename(resultSet.getString("name"));
					employeemasterbean.setTxtempaccount(resultSet.getString("account"));
					employeemasterbean.setTxtempaccountname(resultSet.getString("accountname"));
					employeemasterbean.setTxtempaccdocno(resultSet.getInt("acno"));
					employeemasterbean.setHidcmbcurrency(resultSet.getString("acc_curid"));
					employeemasterbean.setJoiningDate(resultSet.getDate("dtjoin").toString());
					employeemasterbean.setHidcmbempdesignation(resultSet.getString("desc_id"));
					employeemasterbean.setHidcmbempdepartment(resultSet.getString("dept_id"));
					employeemasterbean.setHidcmbpayrollcategory(resultSet.getString("pay_catid"));
					employeemasterbean.setTxtemptravels(resultSet.getDouble("travels"));
					employeemasterbean.setTxtpermanentaddress(resultSet.getString("pmaddr"));
					employeemasterbean.setTxtpresentaddress(resultSet.getString("praddr"));
					employeemasterbean.setTxtpermanentmobile(resultSet.getString("pmmob"));
					employeemasterbean.setTxtpresentmobile(resultSet.getString("prmob"));
					employeemasterbean.setTxtpermanentemail(resultSet.getString("pmemail"));
					employeemasterbean.setTxtpresentemail(resultSet.getString("premail"));
					employeemasterbean.setTxtempcity(resultSet.getString("city"));
					employeemasterbean.setTxtempstate(resultSet.getString("state"));
					employeemasterbean.setTxtemppincode(resultSet.getString("pincode"));
					employeemasterbean.setTxtempnationality(resultSet.getString("nation"));
					employeemasterbean.setTxtempnationalityid(resultSet.getInt("nationId"));
					employeemasterbean.setTxtempreligion(resultSet.getString("religion"));
					employeemasterbean.setTxtempnearestairport(resultSet.getString("nairport"));
					employeemasterbean.setTxtempplaceofbirth(resultSet.getString("pob"));
					employeemasterbean.setEmpDateOfBirth(resultSet.getDate("dob").toString());
					employeemasterbean.setHidcmbempsex(resultSet.getString("Gender"));
					employeemasterbean.setHidcmbempbloodgroup(resultSet.getString("bloodGroup"));
					employeemasterbean.setHidcmbempmaritalstatus(resultSet.getString("mstatus"));
					employeemasterbean.setTxtempfathername(resultSet.getString("fatherName"));
					employeemasterbean.setTxtempmothername(resultSet.getString("motherName"));
					employeemasterbean.setTxtempspousename(resultSet.getString("spouseName"));
					employeemasterbean.setTxtempotherdetails(resultSet.getString("others"));
					employeemasterbean.setHidcmbempagentid(resultSet.getString("agent_id"));
					employeemasterbean.setTxtbankemployeeid(resultSet.getString("emp_id"));
					employeemasterbean.setTxtbankaccountno(resultSet.getString("bnk_acc_no"));
					employeemasterbean.setTxtbankbranchname(resultSet.getString("brchname"));
					employeemasterbean.setTxtbankifsccode(resultSet.getString("ifsccode"));
					employeemasterbean.setLblemployeestatus(resultSet.getString("empstatus"));
					
			        }
				stmtEMP.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		return employeemasterbean;
		}
    
    public JSONArray nationsSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
            	
				ResultSet resultSet = stmtEMP.executeQuery ("SELECT doc_no,nation FROM my_natm order by nation");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public JSONArray allowanceLoading() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
            	
				/*ResultSet resultSet = stmtEMP.executeQuery ("select * from (select CONVERT('0',CHAR(50)) allowanceid,'Basic Salary' allowance,' ' refdtype,CONVERT(' ',CHAR(50)) chktype Union all "
						+ "select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'ALC' refdtype,CONVERT(' ',CHAR(50)) chktype from hr_setallowance where status=3 Union all select CONVERT(doc_no,CHAR(50)) allowanceid,"
						+ "desc1 allowance,'STD' refdtype,CONVERT(chktype,CHAR(50)) chktype from hr_setdeduction where status=3) a");*/

				ResultSet resultSet = stmtEMP.executeQuery ("select * from (select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,if(doc_no=0,' ','ALC') refdtype,CONVERT(' ',CHAR(50)) chktype "  
						+ "from hr_setallowance where status=3 and doc_no>=0 Union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'STD' refdtype,CONVERT(chktype,CHAR(50)) chktype "  
						+ "from hr_setdeduction where status=3) a");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();

		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
    
    public JSONArray documentsLoading() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				
				ResultSet resultSet = stmtEMP.executeQuery ("select doc_no documentid,desc1 document from hr_setdoc where status=3");
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
    public JSONArray allowanceEditReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				
				/*ResultSet resultSet = stmtEMP.executeQuery ("select CONVERT(b.allowanceid,CHAR(50)) allowanceid,CONVERT(b.allowance,CHAR(50)) allowance,CONVERT(b.refdtype,CHAR(50)) refdtype,CONVERT(b.chktype,CHAR(50)) chktype,\r\n" +
						"CONVERT(if(b.addition=0,' ',b.addition),CHAR(100)) addition,CONVERT(if(b.deduction=0,' ',b.deduction),CHAR(100)) deduction,CONVERT(if(b.statutorydeduction=0,' ',b.statutorydeduction),CHAR(100)) statutorydeduction,\r\n" +
						"CONVERT(b.remarks,CHAR(500)) remarks,(select count(*) from hr_incrm where dtype!='EMP' and empid="+docNo+") appraisal from (select m.awlId allowanceid,\r\n" +
						"if(m.refdtype='0','Basic Salary',if(m.refdtype='ALC',a.desc1,s.desc1)) allowance,if(m.refdtype='0',' ',m.refdtype) refdtype,if(m.refdtype='STD',s.chktype,' ') chktype,m.addition,\r\n" +
						" m.deduction,m.statutorydeduction,m.remarks from hr_empsal m  left join hr_setallowance a on m.awlId=a.doc_no left join hr_setdeduction s on m.awlId=s.doc_no where m.rdocno="+docNo+"\r\n" +
						" union all select * from ( select CONVERT('0',CHAR(50)) allowanceid,'Basic Salary' allowance,' ' refdtype,CONVERT(' ',CHAR(50)) chktype,' ' addition,' ' deduction,' ' statutorydeduction,\r\n" +
						"' ' remarks Union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'ALC' refdtype,CONVERT(' ',CHAR(50)) chktype,' ' addition,' ' deduction,' ' statutorydeduction,' ' remarks\r\n" +
						" from hr_setallowance where status=3 Union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'STD' refdtype,CONVERT(chktype,CHAR(50)) chktype,' ' addition,' ' deduction,\r\n" +
						" ' ' statutorydeduction,' ' remarks from hr_setdeduction where status=3) a) b group by allowanceid,refdtype");*/
				
				ResultSet resultSet = stmtEMP.executeQuery ("select CONVERT(b.allowanceid,CHAR(50)) allowanceid,CONVERT(b.allowance,CHAR(50)) allowance,CONVERT(b.refdtype,CHAR(50)) refdtype,CONVERT(b.chktype,CHAR(50)) chktype,\r\n" +
						"CONVERT(if(b.addition=0,' ',b.addition),CHAR(100)) addition,CONVERT(if(b.deduction=0,' ',b.deduction),CHAR(100)) deduction,CONVERT(if(b.statutorydeduction=0,' ',b.statutorydeduction),CHAR(100)) statutorydeduction,\r\n" +
						"CONVERT(b.remarks,CHAR(500)) remarks,(select count(*) from hr_incrm where dtype!='EMP' and status=3 and empid="+docNo+") appraisal from (select m.awlId allowanceid,\r\n" +
						"if(m.refdtype='0','Basic Salary',if(m.refdtype='ALC',a.desc1,s.desc1)) allowance,if(m.refdtype='0',' ',m.refdtype) refdtype,if(m.refdtype='STD',s.chktype,' ') chktype,m.addition,\r\n" +
						" m.deduction,m.statutorydeduction,m.remarks from hr_empsal m  left join hr_setallowance a on m.awlId=a.doc_no left join hr_setdeduction s on m.awlId=s.doc_no where m.rdocno="+docNo+"\r\n" +
						" union all select * from (select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,if(doc_no=0,' ','ALC') refdtype,CONVERT(' ',CHAR(50)) chktype,' ' addition,' ' deduction,' ' statutorydeduction,\r\n" + 
						" ' ' remarks from hr_setallowance where status=3 and doc_no>=0 Union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'STD' refdtype,CONVERT(chktype,CHAR(50)) chktype,\r\n" + 
						"' ' addition,' ' deduction,' ' statutorydeduction,' ' remarks from hr_setdeduction where status=3) a) b group by b.allowanceid,b.refdtype");
                
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }

    public JSONArray documentsEditReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				
				ResultSet resultSet = stmtEMP.executeQuery ("select a.* from (select m.docId documentid,s.desc1 document,m.docIdnum documentno,m.issdt issue_date,m.expdt exp_date,"
						+ "m.placeofiss place_of_issue,m.location,m.remarks from hr_empdoc m left join hr_setdoc s on m.docId=s.doc_no where m.rdocno="+docNo+" "  
						+ "UNION ALL select doc_no documentid,desc1 document,' ' documentno,null issue_date,null exp_date,' ' place_of_issue,' ' location,' ' remarks from hr_setdoc "  
						+ "where status=3) a group by a.documentid");
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();

		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
    
    public JSONArray allowanceReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				
				ResultSet resultSet = stmtEMP.executeQuery ("select m.awlId allowanceid,if(m.refdtype='0','Basic Salary',if(m.refdtype='ALC',a.desc1,s.desc1)) allowance," 
						+ "if(m.refdtype='0',' ',m.refdtype) refdtype,if(m.refdtype='STD',s.chktype,' ') chktype,CONVERT(if(m.addition=0,' ',m.addition),CHAR(100)) addition,"
						+ "CONVERT(if(m.deduction=0,' ',m.deduction),CHAR(100)) deduction,CONVERT(if(m.statutorydeduction=0,' ',m.statutorydeduction),CHAR(100)) statutorydeduction,m.remarks from "
						+ "hr_empsal m  left join hr_setallowance a on m.awlId=a.doc_no left join hr_setdeduction s on m.awlId=s.doc_no where m.rdocno="+docNo+"");
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }

    public JSONArray documentsReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
				
				ResultSet resultSet = stmtEMP.executeQuery ("select m.docId documentid,s.desc1 document,m.docIdnum documentno,m.issdt issue_date,m.expdt exp_date,m.placeofiss place_of_issue,"
						+ "m.location,m.remarks from hr_empdoc m left join hr_setdoc s on m.docId=s.doc_no where m.rdocno="+docNo+"");
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
 
    public  JSONArray employeeMainSearch(HttpSession session,String empname,String mob,String employeedesignation,String employeedepartment,String empid,String dob) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
           int a=0;
           while(Enumeration.hasMoreElements()){
            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
             a=1;
            }
           }
           if(a==0){
         return RESULTDATA;
            }
             
           String brid=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlDateofBirth=null;
       
        dob.trim();
        if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
        {
        	sqlDateofBirth = ClsCommon.changeStringtoSqlDate(dob);
        }
        
        String sqltest="";
        
        if(!(empname.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.name like '%"+empname+"%'";
        }
        if(!(mob.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) like '%"+mob+"%'";
        }
        if(!(employeedesignation.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.desc_id like '%"+employeedesignation+"%'";
        }
        if(!(employeedepartment.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.dept_id like '%"+employeedepartment+"%'";
        }
        if(!(empid.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.codeno like '%"+empid+"%'";
        }
        if(!(sqlDateofBirth==null)){
        	sqltest=sqltest+" and m.dob='"+sqlDateofBirth+"'";
        } 
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtEMP = conn.createStatement();
       
	       ResultSet resultSet = stmtEMP.executeQuery("select m.name,if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) mob,dg.desc1 designation,dp.desc1 department," 
	       	    + "m.dob,m.codeno emp_id,m.doc_no,m.dob birthdate,m.dtjoin from hr_empm m left join hr_setdesig dg on m.desc_id=dg.doc_no left join hr_setdept dp on m.dept_id=dp.doc_no "
	    		+ "where m.dtype='EMP'" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtEMP.close();
	       conn.close();
     }catch(Exception e){
    	 conn.close();
    	 e.printStackTrace();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }

}
