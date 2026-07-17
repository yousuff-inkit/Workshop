package com.dashboard.android.collectiondetails;

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

public class ClsToCollectionDetails {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray searchCollectionDetails(String fdateval,String tdateval) throws SQLException {

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
            	             	 
            	String sqldata="SELECT a.agmttype ratype,r.voc_no rano,br.branchname branch,a.km,a.fuel,a.date date1,a.time time1,u.user_name,a.edate\r\n" + 
            			" FROM an_acollection a left join gl_ragmt r on a.agmtno=r.doc_no \r\n" + 
            			" left join my_brch br on r.brhid=br.doc_no left join my_user u on a.userid=u.doc_no"
            			+ " where date(a.edate) between '"+sqlfromdate+"' and '"+sqltodate+"' ";
            	
            						
				//System.out.println("----------:"+sqldata);
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
	
	
	public JSONArray excelCollectionDetails(String fdateval,String tdateval) throws SQLException {

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
           	             	 
            	String sqldata="SELECT a.agmttype 'RA Type',r.voc_no 'RA No.',br.branchname 'Branch Name',a.km 'KM',a.fuel 'Fuel',a.date 'Date',a.time 'Time',u.user_name 'Username',date_format(a.edate,'%d.%m.%Y  %T') 'Entry Date' \r\n" + 
            			" FROM an_acollection a left join gl_ragmt r on a.agmtno=r.doc_no \r\n" + 
            			" left join my_brch br on r.brhid=br.doc_no left join my_user u on a.userid=u.doc_no"
            			+ " where date(a.edate) between '"+sqlfromdate+"' and '"+sqltodate+"' ";
            	
            						
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

	
	
	
}
