package com.dashboard.nipurchase.nipurchasereports;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsnipurchaseReportsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public   JSONArray nipurchaseReports(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
     	String sqltest="";
     	
        if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
        }
        if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
           sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
        }
        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.acno ="+accdocno+" ";
         }
         		
        

    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}	
     	Connection conn = null;
 
    
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String sql=" select m.doc_no,m.voc_no,m.date,m.invno,m.invdate,h.account venacno,h.description vendaccname,\r\n" + 
						"h1.account detacno,h1.description detaccname,d.qty,d.unitprice,d.total,d.discount,d.nettotal netamount\r\n" + 
						"  from my_srvpurm m left join my_srvpurd d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno  left join my_head h1 on h1.doc_no=d.acno\r\n" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status=3  "+sqltest+"  group by  d.rowno order by m.doc_no ";
         
            		
      //    System.out.println("------sql-----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	public   JSONArray nipurchaseReportsExcelExport(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
     	String sqltest="";
     	
        if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
        }
        if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
           sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
        }
        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.acno ="+accdocno+" ";
         }
         		
        

    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}	
     	Connection conn = null;
 
    
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String sql=" select m.voc_no 'Doc No',m.date Date,h.account Vendor,h.description  Name,\r\n" + 
						"h1.account Account,h1.description as 'Account Name',d.total Total,d.discount Discount,d.nettotal as 'Net Amount'\r\n" + 
						"  from my_srvpurm m left join my_srvpurd d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno  left join my_head h1 on h1.doc_no=d.acno\r\n" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status=3  "+sqltest+"  group by  d.rowno order by m.doc_no ";
         
            		
         // System.out.println("------excelsql-----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	

	
	
public   JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
		    
	   
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sqltest="";
		        String sql="";
		 
		           
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select   t.description,t.doc_no,t.account from my_head t  where t.atype='AP' and t.m_s=0 "+sqltest+" ";
		        
		     
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
	 
		       }
		      stmt.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }

	
	
	
	
}
