package com.dashboard.android.rentalreceipt;

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

public class ClsToRentalReceipt {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray searchrentalreceipt(String branchval,String fdateval,String tdateval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!(fdateval.equalsIgnoreCase("undefined")) && !(fdateval.equalsIgnoreCase("")) && !(fdateval.equalsIgnoreCase("0")) && !(fdateval==null)){
       		sqlfromdate=ClsCommon.changeStringtoSqlDate(fdateval);
        }
        else{ }
        if(!(tdateval.equalsIgnoreCase("undefined")) && !(tdateval.equalsIgnoreCase("")) && !(tdateval.equalsIgnoreCase("0"))&& !(fdateval==null)){
        		sqltodate=ClsCommon.changeStringtoSqlDate(tdateval);
        } 
        else { }
          	Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
				if(!(branchval.equalsIgnoreCase("NA")) && !(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a"))){
            		sqltest=" and rr.branch_no='"+branchval+"'";
            	}
            	             	 
            	String sqldata="SELECT rr.sr_no srno,DATE_FORMAT(rr.doc_date,'%d-%m-%Y') date1,br.branchname branch,ac.RefName clientname,mm.mode mod1 , m.mode ctype,rr.checkno,DATE_FORMAT(rr.date,'%d-%m-%Y') checkdate,rr.amount,rr.describtion description,rr.branch_no brno,rr.cardtype,rr.type,ac.cldocno,mm.acno txtdoc,ac.acno txtacno,rr.doc_no docno FROM an_rentalreceipt rr "
            			+ "left join my_brch br on rr.branch_no=br.doc_no left join my_cardm m on  m.doc_no=rr.cardtype and m.dtype='card'  left join my_acbook ac on ac.doc_no=rr.refname  and ac.dtype='CRM'"
            			+ "left join my_cardm mm on mm.doc_no=rr.type and mm.dtype='MODE' where  "
            			+ "date(doc_date) between '"+sqlfromdate+"' and '"+sqltodate+"' and rr.rrv_trno='0' '"+sqltest+"'";
            	
            						
			//	System.out.println("----------:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
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
	
	public JSONArray excelrentalreceipt(String branchval,String fdateval,String tdateval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!(fdateval.equalsIgnoreCase("undefined")) && !(fdateval.equalsIgnoreCase("")) && !(fdateval.equalsIgnoreCase("0")) && !(fdateval==null)){
       		sqlfromdate=ClsCommon.changeStringtoSqlDate(fdateval);
        }
        else{ }
        if(!(tdateval.equalsIgnoreCase("undefined")) && !(tdateval.equalsIgnoreCase("")) && !(tdateval.equalsIgnoreCase("0"))&& !(fdateval==null)){
        		sqltodate=ClsCommon.changeStringtoSqlDate(tdateval);
        } 
        else { }
          	Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
				if(!(branchval.equalsIgnoreCase("NA")) && !(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a"))){
            		sqltest=" and rr.branch_no='"+branchval+"'";
            	}
            	             	 
            	String sqldata="SELECT rr.sr_no 'Doc No.',DATE_FORMAT(rr.doc_date,'%d-%m-%Y') 'Date',br.branchname 'Branch',ac.RefName 'Client Name',mm.mode 'Type' , m.mode 'Card Type',rr.checkno 'Chq/Card No./Online',DATE_FORMAT(rr.date,'%d-%m-%Y') 'Check Date',rr.amount 'Amount',rr.describtion 'Description' FROM an_rentalreceipt rr "
            			+ "left join my_brch br on rr.branch_no=br.doc_no left join my_cardm m on  m.doc_no=rr.cardtype and m.dtype='card'  left join my_acbook ac on ac.doc_no=rr.refname  and ac.dtype='CRM'"
            			+ "left join my_cardm mm on mm.doc_no=rr.type and mm.dtype='MODE' where  "
            			+ "date(doc_date) between '"+sqlfromdate+"' and '"+sqltodate+"' and rr.rrv_trno='0' '"+sqltest+"'";
            	
            						
				//System.out.println("----------:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
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

	 public JSONArray attachDetails(String docno) throws SQLException {
	     JSONArray RESULTDATA=new JSONArray();
		     try {
		    	 String  cpsql="";
		       Connection conn = ClsConnection.getMyConnection();
		       Statement cpstmt = conn.createStatement();
		      if(!(docno.equalsIgnoreCase("0")) || (docno.equalsIgnoreCase("NA")) || (docno.equalsIgnoreCase("")))
		       {
		     cpsql="select a.sr_no srno,a.dtype dtyp,a.descpt description,a.filename,replace(path,'\\\\',';') path"
		        		+ " from my_fileattach a left join an_rentalreceipt c on c.doc_no=a.doc_no where a.dtype='rrv' and a.doc_no="+docno;
		     
//	  System.out.println("attach=="+cpsql);
		     ResultSet resultSet = cpstmt.executeQuery(cpsql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
		       cpstmt.close();
		       conn.close();
		       }
		       
		     }
		     catch(Exception e){
		      e.printStackTrace();
		     }
           return RESULTDATA;
       }
	
}
