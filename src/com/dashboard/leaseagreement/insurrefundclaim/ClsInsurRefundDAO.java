package com.dashboard.leaseagreement.insurrefundclaim;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class ClsInsurRefundDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getInsurRefundData(String fromdate,String todate,String id) throws SQLException{
		JSONArray insurrefunddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return insurrefunddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			String strinsurrefundacno="select acno from my_account where codeno='INSURANCE REFUND ACCOUNT'";
			ResultSet rsinsurrefund=stmt.executeQuery(strinsurrefundacno);
			int refundacno=0;
			while(rsinsurrefund.next()){
				refundacno=rsinsurrefund.getInt("acno");
			}
			String strsql="select jv.tr_no,jv.acno insurrefundacno,jv.dramount-jv.out_amount amount,jv.tranid,jv.description,jv.dtype,jv.doc_no,head.description insurrefundaccount from my_jvtran jv"+
			" left join my_head head on (jv.acno=head.doc_no) where (dramount-out_amount)>0 and id=1 and acno="+refundacno+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			insurrefunddata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return insurrefunddata;
	}
	
	
	public JSONArray getInsurCompany() throws SQLException{
		JSONArray insurdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,description,account from my_head where atype='AR' and m_s=0";
			ResultSet rs=stmt.executeQuery(strsql);
			insurdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return insurdata;
	}
	
	public JSONArray getExpenseAccount() throws SQLException{
		JSONArray insurdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,description,account from my_head where gr_type=4 and m_s=0";
			ResultSet rs=stmt.executeQuery(strsql);
			insurdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return insurdata;
	}


	public int insert(String refno, Date sqlgridate, String amount,
			String hidinsurcomp, String hidexpenseaccount,
			String expenseamount, String mode,String griddate, HttpSession session, HttpServletRequest request,String tempamount,String tranid) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ClsJournalVouchersDAO jvdao=new ClsJournalVouchersDAO();
		try{
			conn=objconn.getMyConnection();
			String txtrefno=getInsurRefId(conn);
			String insurrefunddetails=getInsurRefundAcno(conn);
			String insurcompdetails=getInsurCompanyDetails(hidinsurcomp,conn);	
			String expenseacdetails="",expenseacno="",expensecurid="",expensecurrate="";
			if(!hidexpenseaccount.equalsIgnoreCase("")){
				expenseacdetails=getExpenseAcDetails(hidexpenseaccount,conn);
				
				expenseacno=expenseacdetails.split("::")[0];
				expensecurid=expenseacdetails.split("::")[1];
				expensecurrate=expenseacdetails.split("::")[2];	
			}
			 
				
				String insurcompanyacno=insurcompdetails.split("::")[0];
				String insurcompanycurid=insurcompdetails.split("::")[1];
				String insurcompanycurrate=insurcompdetails.split("::")[2];
				
				String insurrefundacno=insurrefunddetails.split("::")[0];
				String insurrefundcurid=insurrefunddetails.split("::")[1];
				String insurrefundcurrate=insurrefunddetails.split("::")[2];
				
			String txtdescription="Insurance Refund Claim with Ref No "+refno+" is passed as JVT on "+griddate;
			ArrayList<String> journalarray=new ArrayList<>();
			journalarray.add(insurrefundacno+"::"+txtdescription+"::"+insurrefundcurid+"::"+insurrefundcurrate+"::"+Double.parseDouble(tempamount)*-1+"::"+(Double.parseDouble(tempamount)*-1)*Double.parseDouble(insurrefundcurrate)+"::"+"0"+"::"+"-1"+"::"+"0"+"::"+"0");
			journalarray.add(insurcompanyacno+"::"+txtdescription+"::"+insurcompanycurid+"::"+insurcompanycurrate+"::"+Double.parseDouble(amount)+"::"+Double.parseDouble(amount)*Double.parseDouble(insurcompanycurrate)+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
			if(Double.parseDouble(expenseamount)!=0.0){
				int id=0;
				if(Double.parseDouble(expenseamount)>0){
					id=1;
				}
				else if(Double.parseDouble(expenseamount)<0){
					id=-1;
				}
				journalarray.add(expenseacno+"::"+txtdescription+"::"+expensecurid+"::"+expensecurrate+"::"+Double.parseDouble(expenseamount)+"::"+Double.parseDouble(expenseamount)*Double.parseDouble(expensecurrate)+"::"+"0"+"::"+id+"::"+"0"+"::"+"0");
			}
			int jvval=jvdao.insert(sqlgridate, "JVT", txtrefno, txtdescription, Double.parseDouble(amount),Double.parseDouble(amount), journalarray, session, request);	
			if(jvval>0){
				String strupdate="update my_jvtran set out_amount="+tempamount+" where tranid="+tranid;
				Statement stmt=conn.createStatement();
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<0){
					return 0;
				}
				else{
					return updateval;
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


	private String getExpenseAcDetails(String hidexpenseaccount, Connection conn) {
		// TODO Auto-generated method stub
		String expenseacdetails="";
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select head.doc_no,head.curid,head.rate from  my_head head where head.doc_no="+hidexpenseaccount);
			while(rs.next()){
				expenseacdetails=rs.getString("doc_no")+"::"+rs.getString("curid")+"::"+rs.getString("rate");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return expenseacdetails;
		
	}


	private String getInsurCompanyDetails(String hidinsurcomp, Connection conn) {
		// TODO Auto-generated method stub
		String insurcompanydetails="";
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select head.doc_no,head.curid,head.rate from  my_head head where head.doc_no="+hidinsurcomp);
			while(rs.next()){
				insurcompanydetails=rs.getString("doc_no")+"::"+rs.getString("curid")+"::"+rs.getString("rate");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return insurcompanydetails;
		
	}
	private String getInsurRefundAcno(Connection conn) {
		// TODO Auto-generated method stub
		String insurrefunddetails="";
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select head.doc_no,head.curid,head.rate from my_account ac inner join my_head head on (ac.acno=head.doc_no) where ac.codeno='INSURANCE REFUND ACCOUNT'");
			while(rs.next()){
				insurrefunddetails=rs.getString("doc_no")+"::"+rs.getString("curid")+"::"+rs.getString("rate");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return insurrefunddetails;
	
	}


	private String getInsurRefId(Connection conn) {
		// TODO Auto-generated method stub
		String refid="";
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select jvid from my_jvidentifyingid where menu_name='Insurance Refund Claim'");
			while(rs.next()){
				refid=rs.getString("jvid");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return refid;
	
	}
	}
	

