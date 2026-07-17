package com.operations.vehicleprocurement.purchaseorder;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mysql.jdbc.PreparedStatement;


public class ClsvehpurchaseorderDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	Connection conn;
		
	
	public int insert(Date sqlStartDate, Date sqlpurdeldate,
			String headacccode, String vehtype, String vehrefno,
			Double nettotal, String vehdesc, HttpSession session, String mode,
			String formdetailcode,ArrayList<String> descarray, HttpServletRequest request)  throws SQLException {
		
		try{
			int docno;
		
			if(vehrefno.equalsIgnoreCase("")|| vehrefno.equalsIgnoreCase("null") || vehrefno.equalsIgnoreCase("NA"))
			{
				vehrefno=null;
			}
			
			
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurodr= conn.prepareCall("{call vahpurchaseOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurodr.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtpurodr.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtpurodr.setDate(1,sqlStartDate);
			stmtpurodr.setString(2,headacccode);
			stmtpurodr.setString(3,vehtype);
			stmtpurodr.setString(4,vehrefno=="null"?"":vehrefno);
			stmtpurodr.setDouble(5,nettotal);
			stmtpurodr.setString(6,vehdesc);
			stmtpurodr.setDate(7,sqlpurdeldate);
			stmtpurodr.setString(8,session.getAttribute("USERID").toString());
			stmtpurodr.setString(9,session.getAttribute("BRANCHID").toString());
			stmtpurodr.setString(10,formdetailcode);
			stmtpurodr.setString(12,mode);
			stmtpurodr.executeQuery();
			docno=stmtpurodr.getInt("docNo");
			int vocno=stmtpurodr.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
		/*	ALTER TABLE `gl_vpod` MODIFY COLUMN `rowno` INT(10) UNSIGNED NOT NULL,
			 ADD COLUMN `reqrowno` INT(10) UNSIGNED DEFAULT 0 AFTER `pqty`,
			 ADD COLUMN `reqtotqty` INT(10) UNSIGNED DEFAULT 0 AFTER `reqrowno`,
			 ADD COLUMN `reqpqty` INT(10) UNSIGNED DEFAULT 0 AFTER `reqtotqty`;*/
		//	System.out.println("sssssss"+session.getAttribute("USERID").toString());
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] vehpurreqarray=descarray.get(i).split("::");
			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
			    	 
		     String sql="INSERT INTO gl_vpod(srno,brdid,modid,spec,clrid,qty,price,total,reqpqty,reqrowno,reqtotqty,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
				       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
				       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
				       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
				        + "'"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"',"
				        + "'"+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"',"
				        + "'"+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+"',"
				         + "'"+(vehpurreqarray[10].trim().equalsIgnoreCase("undefined") || vehpurreqarray[10].trim().equalsIgnoreCase("NaN")||vehpurreqarray[10].trim().equalsIgnoreCase("")|| vehpurreqarray[10].isEmpty()?0:vehpurreqarray[10].trim())+"',"
				        +"'"+docno+"')";
		   //  System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurodr.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
				     
				     if(vehtype.equalsIgnoreCase("VPR"))
			         {
			         String sqls="update gl_vprd set pqty="+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+" where rowno="+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+""; 
			      
			        // System.out.println("---sqls------"+sqls);
			         
			         int result = stmtpurodr.executeUpdate(sqls);
				     
				     if(result<=0)
						{
							conn.close();
							return 0;
			                  }
					
						     
			         }
			     }
				     
				     }
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpurodr.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
	


	public boolean edit(int docno,Date sqlStartDate, Date sqlpurdeldate,
			String headacccode, String vehtype, String vehrefno,
			Double nettotal, String vehdesc, HttpSession session, String mode,
			String formdetailcode,ArrayList<String> descarray) throws SQLException  {
		//System.out.println("-------vehrefno---"+vehrefno);
		
		if(vehrefno.equalsIgnoreCase("")|| vehrefno.equalsIgnoreCase("null") || vehrefno.equalsIgnoreCase("NA"))
		{
			vehrefno=null;
		}
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurodr= conn.prepareCall("{call vahpurchaseOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurodr.setDate(1,sqlStartDate);
			stmtpurodr.setString(2,headacccode);
			stmtpurodr.setString(3,vehtype);
			stmtpurodr.setString(4,vehrefno=="null"?"0":vehrefno);
			stmtpurodr.setDouble(5,nettotal);
			stmtpurodr.setString(6,vehdesc);
			stmtpurodr.setDate(7,sqlpurdeldate);
			stmtpurodr.setString(8,session.getAttribute("USERID").toString());
			stmtpurodr.setString(9,session.getAttribute("BRANCHID").toString());
			stmtpurodr.setString(10,formdetailcode);
			stmtpurodr.setInt(11,docno);
			stmtpurodr.setString(12,"E");
			stmtpurodr.setInt(13,0);
			int aaa=stmtpurodr.executeUpdate();
			docno=stmtpurodr.getInt("docNo");
					
			 if(aaa<=0)
				{
					conn.close();
					return false;
	                  }
			

			  String delsql="Delete from gl_vpod where rdocno="+docno+" ";
			  stmtpurodr.executeUpdate(delsql);
			 
			 
			for(int i=0;i<descarray.size();i++){
		    	
			     String[] vehpurreqarray=descarray.get(i).split("::");
			    
			     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
			     {
			    	  String sql="INSERT INTO gl_vpod(srno,brdid,modid,spec,clrid,qty,price,total,reqpqty,reqrowno,reqtotqty,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
						       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
						       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
						       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
						       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
						       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
						        + "'"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"',"
						        + "'"+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+"',"
						        + "'"+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+"',"
						         + "'"+(vehpurreqarray[10].trim().equalsIgnoreCase("undefined") || vehpurreqarray[10].trim().equalsIgnoreCase("NaN")||vehpurreqarray[10].trim().equalsIgnoreCase("")|| vehpurreqarray[10].isEmpty()?0:vehpurreqarray[10].trim())+"',"
						        +"'"+docno+"')";
				   //  System.out.println("444444444"+sql);
						     int resultSet2 = stmtpurodr.executeUpdate(sql);
						     if(resultSet2<=0)
								{
									conn.close();
									return false;
								}
						     
						     if(vehtype.equalsIgnoreCase("VPR"))
					         {
					         String sqls="update gl_vprd set pqty="+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+" where rowno="+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+""; 
					      
					        // System.out.println("---sqls------"+sqls);
					         
					         int result = stmtpurodr.executeUpdate(sqls);
						     
						     if(result<=0)
								{
									conn.close();
									return false;
					                  }
							
								     
					         }
			         /*String sql="INSERT INTO gl_vpod(srno,brdid,modid,spec,clrid,qty,price,total,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
						       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
						       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
						       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
						       + "'"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
						       + "'"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"',"
						        + "'"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"',"
						       +"'"+docno+"')"; 	
			       
	 
			         if(vehtype.equalsIgnoreCase("VPR"))
			         {
			         String sqls="update gl_vprd set pqty="+(vehpurreqarray[8].trim().equalsIgnoreCase("undefined") || vehpurreqarray[8].trim().equalsIgnoreCase("NaN")||vehpurreqarray[8].trim().equalsIgnoreCase("")|| vehpurreqarray[8].isEmpty()?0:vehpurreqarray[8].trim())+" where rowno="+(vehpurreqarray[9].trim().equalsIgnoreCase("undefined") || vehpurreqarray[9].trim().equalsIgnoreCase("NaN")||vehpurreqarray[9].trim().equalsIgnoreCase("")|| vehpurreqarray[9].isEmpty()?0:vehpurreqarray[9].trim())+""; 
			      
			       //  System.out.println("---sqls------"+sqls);
			         
			         int result = stmtpurodr.executeUpdate(sqls);
				     
				     if(result<=0)
						{
							conn.close();
						 	return false;
			                  }*/
					
						     
			         }
						     
			         
			         
		  /*   String sql="update  gl_vpod set srno="+(i+1)+","
		     		   + "brdid='"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"',"
				       + "modid='"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
				       + "spec='"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
				       + "clrid='"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
				       + "price='"+(vehpurreqarray[5].trim().equalsIgnoreCase("undefined") || vehpurreqarray[5].trim().equalsIgnoreCase("NaN")||vehpurreqarray[5].trim().equalsIgnoreCase("")|| vehpurreqarray[5].isEmpty()?0:vehpurreqarray[5].trim())+"',"
				       + "qty='"+(vehpurreqarray[6].trim().equalsIgnoreCase("undefined") || vehpurreqarray[6].trim().equalsIgnoreCase("NaN")||vehpurreqarray[6].trim().equalsIgnoreCase("")|| vehpurreqarray[6].isEmpty()?0:vehpurreqarray[6].trim())+"' ,"
				       + "total='"+(vehpurreqarray[7].trim().equalsIgnoreCase("undefined") || vehpurreqarray[7].trim().equalsIgnoreCase("NaN")||vehpurreqarray[7].trim().equalsIgnoreCase("")|| vehpurreqarray[7].isEmpty()?0:vehpurreqarray[7].trim())+"' where rdocno="+docno+"";
		    
		     System.out.println(""+sql);*/
		   //  i//nt resultSet4 = stmtpurodr.executeUpdate(sql);
		     /*
		     if(resultSet4<=0)
				{
					conn.close();
					return false;
	                  }
			
				     
			     }
				     */
				     }
			
						
			if (aaa > 0) {
				conn.commit();
				stmtpurodr.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno, HttpSession session, String mode,
			String formdetailcode)  throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
		//	conn.setAutoCommit(false);
			CallableStatement stmtpurodr= conn.prepareCall("{call vahpurchaseOrderDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtpurodr.setDate(1,null);
			stmtpurodr.setString(2,null);
			stmtpurodr.setString(3,null);
			stmtpurodr.setString(4,null);
			stmtpurodr.setDouble(5,0.0);
			stmtpurodr.setString(6,null);
			stmtpurodr.setDate(7,null);
			stmtpurodr.setString(8,session.getAttribute("USERID").toString());
			stmtpurodr.setString(9,session.getAttribute("BRANCHID").toString());
			stmtpurodr.setString(10,formdetailcode);
	
			stmtpurodr.setInt(11,docno);
			stmtpurodr.setString(12,"D");
			stmtpurodr.setInt(13,0);
			
			int aaa=stmtpurodr.executeUpdate();
			
			
		
			if (aaa > 0) {
				//conn.commit();
				stmtpurodr.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}	
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
	
	
	
	public  JSONArray searchBrand() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

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
	
	public  JSONArray searchModel(String brandval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh3 = conn.createStatement ();
            	
				String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid='"+brandval+"' and status<>7;");
				
				//System.out.println("========"+modelsql);
				
				ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh3.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public  JSONArray searchColor() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
	   
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
	        	
				ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color  from my_color  where status<>7 order by  doc_no;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public  JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
                     if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and c.code like '%"+currency+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmtCPV = conn.createStatement ();
          /*   String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
               + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
               + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') ";*/
   
    String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
    //System.out.println("sql===="+sql);
    
            /* String sql=" select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,a1.cldocno,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
            	        + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
            	        + "and t.cldocno=a1.cldocno and a1.dtype='VND' and t.atype='AP' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
            	        + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')";*/
             
             
          //  System.out.println("==============="+sql); 
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmtCPV.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
/*	public  JSONArray accountsDetailsFrom(HttpSession session) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
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
        String branch = session.getAttribute("BRANCHID").toString();
     String company = session.getAttribute("COMPANYID").toString();
     Connection conn = null;
        //JSONArray RESULTDATA=new JSONArray();
  try {
     conn = ClsConnection.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
             String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
               + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
               + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') ";
             
             
             
             String sql=" select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,a1.cldocno,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
         	        + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
         	        + "and t.cldocno=a1.cldocno and a1.dtype='VND' and t.atype='AP' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
         	        + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')";
          
             
          //  System.out.println("==============="+sql); 
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }*/
	public  JSONArray reqSearchMasters(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
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
        String brcid = session.getAttribute("BRANCHID").toString();
	 
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select voc_no,doc_no,date,type,expdeldt,desc1 from gl_vprm  where status=3 and brhid='"+brcid+"'" );
	        	//System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public  JSONArray reqsearchrelode(String reqdocno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
	   
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement (); 
	        	
	/*			String resql=("select round(rq.qty)-round(rq.pqty) qutval,rq.rowno,round(rq.qty)-round(rq.pqty) qty,  "
						+ " round(rq.pqty) pqty, if(rq.pqty=0,round(rq.qty),(round(rq.qty)-round(rq.pqty))+round(rq.qty)) saveqty ,rq.srno, "
						+ " rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.remarks,vb.brand_name brand,vm.vtype model,vc.color color  "
						+ " from gl_vprd rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ "left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and  rq.rdocno='"+reqdocno+"' ");*/
				
				
				String resql=("select round(rq.qty)-round(rq.pqty) qutval,rq.rowno,round(rq.qty)-round(rq.pqty) qty, "
						+ " round(rq.pqty) pqty, if(rq.pqty=0,round(rq.qty),((round(rq.qty)-round(rq.pqty))+round(rq.pqty))) saveqty , "
						+ " rq.srno,  rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.remarks,vb.brand_name brand,vm.vtype model,vc.color color  "
						+ " from gl_vprd rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ "  left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and  rq.rdocno='"+reqdocno+"' ");
			//System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	public  JSONArray gridsearchrelode(String masterdocno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
	   
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
		/*		String resql=("select rq.srno,rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.qty,rq.price, rq.total,"
						+ " vb.brand_name brand,vm.vtype model,vc.color color "
						+ " from gl_vpod rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
						+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID   "
						+ "left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and rq.rdocno='"+masterdocno+"' ");*/
				
				String resql=("select rq.reqrowno rowno,if(m.rtype='DIR',0,((select sum(qty) from  gl_vprd where rowno=rq.reqrowno)-(select sum(qty) from  gl_vpod where reqrowno=rq.reqrowno)+rq.qty)) qutval, "
						+ "  if(m.rtype='DIR',0,rq.reqpqty-rq.qty) pqty,rq.qty qty, "
						+ " if(m.rtype='DIR',0,round(rq.reqpqty)) saveqty, "
						+ "  rq.reqpqty,rq.reqtotqty,rq.qty,rq.srno,rq.brdid,rq.modid,rq.spec specification,rq.clrid,rq.price, "
						+ "     rq.total, vb.brand_name brand,vm.vtype model,vc.color color from  gl_vpom m left join  "
						+ "     gl_vpod rq on m.doc_no=rq.rdocno  left join gl_vprm mm on mm.doc_no=m.rno and m.rtype='VPR'  "
						+ "  left join gl_vehbrand vb on vb.doc_no=rq.BRDID   left join gl_vehmodel vm on vm.doc_no=rq.MODID  "
						+ " left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and rq.rdocno='"+masterdocno+"' ");
				
			//	System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	public  JSONArray searchmaster(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String reftypess,String aa) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
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
	    String brcid=session.getAttribute("BRANCHID").toString();
	    
	    
	    java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.voc_no like '%"+docnoss+"%'";
    	}
    	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
    	}
    	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
    	}
    	if((!(reftypess.equalsIgnoreCase(""))) && (!(reftypess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.rtype like '%"+reftypess+"%'";
    	}
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and vo.date='"+sqlStartDate+"'";
    	} 
    	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				 
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select vo.voc_no,vo.doc_no,vo.date,vo.venid, vo.rtype type, vo.rno,ss.voc_no refmaster ,vo.expdeldt, vo.desc1, vo.nettotal,h.description,h.account,h.doc_no headdoc "
	        			+ " from gl_vpom vo  left  join my_head h on h.doc_no=vo.venid left join gl_vprm ss on ss.doc_no=vo.rno "
	        			+ "  where vo.status=3 and vo.brhid='"+brcid+"' "+sqltest );
	        	//System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
			}
			
			conn.close();
			return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
	 public  ClsvehpurchaseorderBean getPrint(int docno) throws SQLException {
		 ClsvehpurchaseorderBean bean = new ClsvehpurchaseorderBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
				String resql=("  select vo.voc_no,vo.doc_no,DATE_FORMAT(vo.date,'%d.%m.%Y') date,vo.venid, if(vo.rtype='DIR','Direct',concat('Request (',ss.voc_no,')')) type,  "
						+ " vo.rno,ss.voc_no refmaster ,DATE_FORMAT(vo.expdeldt,'%d.%m.%Y') expdeldt,  "
						+ " vo.desc1, round(vo.nettotal,2) nettotal,h.description,h.account,h.doc_no headdoc "
	        			+ " from gl_vpom vo  left  join my_head h on h.doc_no=vo.venid left join gl_vprm ss on ss.doc_no=vo.rno "
	        			+ "  where vo.doc_no='"+docno+"' ");
			//	String resql=("select voc_no,doc_no,DATE_FORMAT(date,'%d.%m.%Y') AS date,type,DATE_FORMAT(expdeldt,'%d.%m.%Y') AS expdeldt,desc1 from gl_vprm where doc_no='"+docno+"' ");
		
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLbldesc1(pintrs.getString("desc1"));
			    	    bean.setExpdeldate(pintrs.getString("expdeldt"));
			    	    
			    	    bean.setLblvendoeacc(pintrs.getString("account"));
			    	    bean.setLblvendoeaccName(pintrs.getString("description"));
			    	    bean.setLbltotal(pintrs.getString("nettotal"));
			    	   // setLbltotal(pintbean.getLbltotal());
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmtinvoice10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_vpom r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	 
				    	   
				       } 
				       stmtinvoice10.close();
				       
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
		public  ArrayList<String> getPrintdetails(int docno) throws SQLException {
			ArrayList<String> arr=new ArrayList<String>();
			Connection conn = null;
			try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtinvoice = conn.createStatement ();
				String strSqldetail="";
		
			 strSqldetail=("select rq.srno,rq.brdid,rq.modid,rq.spec ,rq.clrid,round(rq.qty) qty,round(rq.price,2) price, round(rq.total,2) total,"
					+ " vb.brand_name brand,vm.vtype model,vc.color color "
					+ " from gl_vpod rq left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
					+ "left join gl_vehmodel vm on vm.doc_no=rq.MODID   "
					+ "left join my_color vc on vc.doc_no=rq.clrid  where rq.clstatus=0 and rq.rdocno='"+docno+"' ");
	
			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);
			
			int rowcount=1;
	
			while(rsdetail.next()){

					String temp="";
					String spci="";
					if(rsdetail.getString("spec").equalsIgnoreCase("0"))
					{
						spci="";
					}
					else
					{
						spci=rsdetail.getString("spec");
					}
					temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("price")+"::"+rsdetail.getString("total") ;

					arr.add(temp);
					rowcount++;
	
			
				
		}
			stmtinvoice.close();
			conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	
			return arr;
		}

	
	
	
	
	
	
	
}
