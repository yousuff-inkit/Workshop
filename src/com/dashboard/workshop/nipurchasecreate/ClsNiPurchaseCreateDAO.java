package com.dashboard.workshop.nipurchasecreate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsNiPurchaseCreateDAO {
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commDAO=new ClsCommon();
	
	public JSONArray getVendorDeatils(String vendorname,String chk)throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!chk.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null; 
		try{
			conn = connDAO.getMyConnection();
			Statement stmt= conn.createStatement();
			String sqltest="";
			if(!vendorname.equalsIgnoreCase("")){
				//System.out.println("sqltest");
				 sqltest+=" and RefName like'%"+vendorname+"%'";
			}
			String sqlqry="SELECT RefName vndname,acno,cldocno vndocno FROM my_acbook where dtype='VND' and status<>7"+sqltest;
			ResultSet resultSet = stmt.executeQuery (sqlqry);
			
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmt.close();
			
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	return RESULTDATA;
	}
	
	public JSONArray getPoSearchDeatils(String docno,String date,String chk)throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!chk.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null; 
		try{
			conn = connDAO.getMyConnection();
			Statement stmt= conn.createStatement();
			String sqltest="";
			java.sql.Date sqlDate=null;
			
			if(!date.equalsIgnoreCase("")){
				sqlDate=commDAO.changeStringtoSqlDate(date);
				sqltest+=" and pm.date='"+sqlDate+"'";
			}
			if(!docno.equalsIgnoreCase("")){
				//System.out.println("sqltest");
				 sqltest+=" and pm.voc_no like'%"+docno+"%'";
			}
			String sqlqry="select pm.voc_no,pm.doc_no,pm.date,ac.refname from my_srvlpom pm left join my_acbook ac on (pm.acno=ac.acno and ac.dtype='VND') "
					+" where pm.status=3"+sqltest;
			ResultSet resultSet = stmt.executeQuery (sqlqry);
			
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmt.close();
			
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	return RESULTDATA;
	}
	
	public JSONArray getPurchaseOrderData(String fromdate,String todate,String vendorid,String podocno,String id)throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null; 
		try{
			conn = connDAO.getMyConnection();
			Statement stmt= conn.createStatement();
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=commDAO.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=commDAO.changeStringtoSqlDate(todate);
			}
			if(!vendorid.equalsIgnoreCase("") && vendorid!=null){
				sqltest+=" and ac.cldocno="+vendorid;
			}
			if(!podocno.equalsIgnoreCase("") && podocno!=null){
				sqltest+=" and pm.doc_no="+podocno;
			}
			
			String sqlqry="select (select acno from my_account where codeno='MAINTSP') accdocno,curdate() crdate,pm.date,pm.doc_no,pm.orderdocno,pm.voc_no,ac.refname,pm.refno,pm.desc1 description,sum(pd.nettaxamount) amount,"
						+" h.atype,h.doc_no acno,h.description acname,h.curid,h.rate "
						+" from my_srvlpom pm left join my_srvlpod pd on pm.doc_no=pd.rdocno"
						+" left join my_acbook ac on (pm.acno=ac.acno and ac.dtype='VND') "
						+" left join my_head h on pm.acno=h.doc_no"
						+" left join my_srvpurm sm on pm.doc_no=sm.refno"
						+" where pm.date between '"+sqlfromdate+"' and '"+sqltodate+"' and pm.status=3 and sm.doc_no is null"+sqltest+" group by pd.rdocno";
			System.out.println(sqlqry);
			ResultSet resultSet = stmt.executeQuery (sqlqry); 
			
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmt.close();
			
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	return RESULTDATA;
	}
	
	public JSONArray getPurchaseOrderExcelData(String fromdate,String todate,String vendorid,String podocno,String id)throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null; 
		try{
			conn = connDAO.getMyConnection();
			Statement stmt= conn.createStatement();
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=commDAO.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=commDAO.changeStringtoSqlDate(todate);
			}
			if(!vendorid.equalsIgnoreCase("") && vendorid!=null){
				sqltest+=" and ac.cldocno="+vendorid;
			}
			if(!podocno.equalsIgnoreCase("") && podocno!=null){
				sqltest+=" and pm.doc_no="+podocno;
			}
			
			String sqlqry="select pm.date 'Date',pm.voc_no 'Doc No',ac.refname 'Vendor',pm.refno 'Ref No',pm.desc1 'Description',sum(pd.nettaxamount) 'Amount'"
						+" from my_srvlpom pm left join my_srvlpod pd on pm.doc_no=pd.rdocno"
						+" left join my_acbook ac on (pm.acno=ac.acno and ac.dtype='VND') "
						+" left join my_head h on pm.acno=h.doc_no"
						+" left join my_srvpurm sm on pm.doc_no=sm.refno"
						+" where pm.date between '"+sqlfromdate+"' and '"+sqltodate+"' and pm.status=3 and sm.doc_no is null"+sqltest+" group by pd.rdocno";
			System.out.println(sqlqry);
			ResultSet resultSet = stmt.executeQuery (sqlqry); 
			
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmt.close();
			
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	return RESULTDATA;
	}
	
	public JSONArray getDetailData(String docno,String id)throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null; 
		try{
			conn = connDAO.getMyConnection();
			Statement stmt= conn.createStatement();
			/*String sqltest="";
			if(!podocno.equalsIgnoreCase("") && podocno!=null){
				sqltest+=" and pm.doc_no="+podocno;
			}*/
			
			String sqlqry="select srno,desc1 description,unitprice,qty,total,discount,nettotal,nuprice,taxper,taxamount taxperamt,nettaxamount taxamount from my_srvlpod  where rdocno='"+docno+"'";
			System.out.println(sqlqry);
			ResultSet resultSet = stmt.executeQuery (sqlqry); 
			
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmt.close();
			
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	return RESULTDATA;
	}
}
