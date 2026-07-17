package com.operations.commtransactions.saliktrafficfineentry;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsSaliktrafficDAO 
{

	ClsConnection connDAO=new ClsConnection();
	ClsCommon Common=new ClsCommon();
	
	
	Connection conn;
	public int insert(Date sqlStartDate, String entry,
			ArrayList<String> salickarray,ArrayList<String> traffickarray, HttpSession session, String mode,
			String formdetailcode) throws SQLException {
		try{
		
			int docno;
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtsave = conn.prepareCall("{call salicktrafficDML(?,?,?,?,?,?,?)}");
			stmtsave.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtsave.setDate(1,sqlStartDate);
			stmtsave.setString(2,entry);
			stmtsave.setString(3,mode);
			stmtsave.setString(4,formdetailcode);
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(6,session.getAttribute("BRANCHID").toString());
			
			stmtsave.executeQuery();
			docno=stmtsave.getInt("docNo");
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			if(docno<=0)
			{
				 conn.close();
				return 0;
			}	
		
			if(entry.equalsIgnoreCase("salik"))
			{
			
					for(int i=0;i< salickarray.size();i++)
					{
						
						/*int  masterdoc = 0;
						
					
						 String selectsql="select coalesce(max(doc_no)+1,1) as doc_no  from gl_salik ";
				
						 ResultSet resSet = stmtsave.executeQuery(selectsql);
							
						    if (resSet.next()) {
						    	 masterdoc = resSet.getInt("doc_no");
						                      }*/
						  
					     String[] salicldaoarray=salickarray.get(i).split("::");
								     if(!(salicldaoarray[0].trim().equalsIgnoreCase("undefined")|| salicldaoarray[0].trim().equalsIgnoreCase("NaN")||salicldaoarray[0].trim().equalsIgnoreCase("")|| salicldaoarray[0].isEmpty()))
								     {
								    	 
								    	/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
							     String sql="INSERT INTO gl_salik(sr_no,fleetno,regno,tagno,salik_date,sal_date,salik_time,trans,direction,Source,amount,location,date,status,doc_no,branch)VALUES"
									       + " ("+(i+1)+","
									         + "'"+(salicldaoarray[0].trim().equalsIgnoreCase("undefined") || salicldaoarray[0].trim().equalsIgnoreCase("NaN")|| salicldaoarray[0].trim().equalsIgnoreCase("")|| salicldaoarray[0].isEmpty()?0:salicldaoarray[0].trim())+"',"
									       + "'"+(salicldaoarray[1].trim().equalsIgnoreCase("undefined") || salicldaoarray[1].trim().equalsIgnoreCase("NaN")|| salicldaoarray[1].trim().equalsIgnoreCase("")|| salicldaoarray[1].isEmpty()?0:salicldaoarray[1].trim())+"',"
									       + "'"+(salicldaoarray[2].trim().equalsIgnoreCase("undefined") || salicldaoarray[2].trim().equalsIgnoreCase("NaN")|| salicldaoarray[2].trim().equalsIgnoreCase("")|| salicldaoarray[2].isEmpty()?0:salicldaoarray[2].trim())+"',"
									       + "(cast(concat('"+(salicldaoarray[3].trim().equalsIgnoreCase("undefined") || salicldaoarray[3].trim().equalsIgnoreCase("NaN")||salicldaoarray[3].trim().equalsIgnoreCase("")|| salicldaoarray[3].isEmpty()?0:Common.changeStringtoSqlDate(salicldaoarray[3].trim()))+"',concat(' ','"+(salicldaoarray[4].trim().equalsIgnoreCase("undefined") || salicldaoarray[4].trim().equalsIgnoreCase("NaN")||salicldaoarray[4].trim().equalsIgnoreCase("")|| salicldaoarray[4].isEmpty()?0:salicldaoarray[4].trim())+"')) as datetime)),"
									       + "'"+(salicldaoarray[3].trim().equalsIgnoreCase("undefined") || salicldaoarray[3].trim().equalsIgnoreCase("NaN")||salicldaoarray[3].trim().equalsIgnoreCase("")|| salicldaoarray[3].isEmpty()?0:salicldaoarray[3].trim())+"',"
									       + "'"+(salicldaoarray[4].trim().equalsIgnoreCase("undefined") || salicldaoarray[4].trim().equalsIgnoreCase("NaN")||salicldaoarray[4].trim().equalsIgnoreCase("")|| salicldaoarray[4].isEmpty()?0:salicldaoarray[4].trim())+"',"
									       + "'"+(salicldaoarray[5].trim().equalsIgnoreCase("undefined") || salicldaoarray[5].trim().equalsIgnoreCase("NaN")||salicldaoarray[5].trim().equalsIgnoreCase("")|| salicldaoarray[5].isEmpty()?0:salicldaoarray[5].trim())+"',"
									       + "'"+(salicldaoarray[6].trim().equalsIgnoreCase("undefined") || salicldaoarray[6].trim().equalsIgnoreCase("NaN")||salicldaoarray[6].trim().equalsIgnoreCase("")|| salicldaoarray[6].isEmpty()?0:salicldaoarray[6].trim())+"',"
									       + "'"+(salicldaoarray[7].trim().equalsIgnoreCase("undefined") || salicldaoarray[7].trim().equalsIgnoreCase("NaN")||salicldaoarray[7].trim().equalsIgnoreCase("")|| salicldaoarray[7].isEmpty()?0:salicldaoarray[7].trim())+"',"
									       + "'"+(salicldaoarray[8].trim().equalsIgnoreCase("undefined") || salicldaoarray[8].trim().equalsIgnoreCase("NaN")||salicldaoarray[8].trim().equalsIgnoreCase("")|| salicldaoarray[8].isEmpty()?0:salicldaoarray[8].trim())+"'," 
									       + "'"+(salicldaoarray[9].trim().equalsIgnoreCase("undefined") || salicldaoarray[9].trim().equalsIgnoreCase("NaN")||salicldaoarray[9].trim().equalsIgnoreCase("")|| salicldaoarray[9].isEmpty()?0:salicldaoarray[9].trim())+"',"
										  +"'"+sqlStartDate+"',3,'"+docno+"','"+session.getAttribute("BRANCHID").toString()+"')";
							
									     int resultSet2 = stmtsave.executeUpdate (sql);
									     if(resultSet2<=0)
												 	{
												 		 conn.close();
												 		return 0;
												 	}	
									     
				                           }				     
				    }
			}
			else   /*  + "'"+(salicldaoarray[3].trim().equalsIgnoreCase("undefined") || salicldaoarray[3].trim().equalsIgnoreCase("NaN")||salicldaoarray[3].trim().equalsIgnoreCase("")|| salicldaoarray[3].isEmpty()?0:ClsCommon.changeStringtoSqlDate(salicldaoarray[3].trim()))+"',"*/
			{

				for(int i=0;i< traffickarray.size();i++)
				{
		       
				     String[] traffickdaoarray=traffickarray.get(i).split("::");
				   
							     if(!(traffickdaoarray[0].trim().equalsIgnoreCase("undefined")|| traffickdaoarray[0].trim().equalsIgnoreCase("NaN")||traffickdaoarray[0].trim().equalsIgnoreCase("")|| traffickdaoarray[0].isEmpty()))
							     {
							    	 
							    	/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
						     String sql="INSERT INTO gl_traffic(sr_no,Fleetno,regNo,Source,Fine_Source,Ticket_No,traffic_date,time,amount,desc1,location,pcolor,tcno,date,status,doc_no,branch)VALUES"
								       + " ("+(i+1)+","
								         + "'"+0+"',"
								       + "'"+(traffickdaoarray[1].trim().equalsIgnoreCase("undefined") || traffickdaoarray[1].trim().equalsIgnoreCase("NaN")|| traffickdaoarray[1].trim().equalsIgnoreCase("")|| traffickdaoarray[1].isEmpty()?0:traffickdaoarray[1].trim())+"',"
								       + "'"+(traffickdaoarray[2].trim().equalsIgnoreCase("undefined") || traffickdaoarray[2].trim().equalsIgnoreCase("NaN")|| traffickdaoarray[2].trim().equalsIgnoreCase("")|| traffickdaoarray[2].isEmpty()?0:traffickdaoarray[2].trim())+"',"
								       + "'"+(traffickdaoarray[3].trim().equalsIgnoreCase("undefined") || traffickdaoarray[3].trim().equalsIgnoreCase("NaN")||traffickdaoarray[3].trim().equalsIgnoreCase("")|| traffickdaoarray[3].isEmpty()?0:traffickdaoarray[3].trim())+"',"
								       + "'"+(traffickdaoarray[4].trim().equalsIgnoreCase("undefined") || traffickdaoarray[4].trim().equalsIgnoreCase("NaN")||traffickdaoarray[4].trim().equalsIgnoreCase("")|| traffickdaoarray[4].isEmpty()?0:traffickdaoarray[4].trim())+"',"
								       + "'"+(traffickdaoarray[5].trim().equalsIgnoreCase("undefined") || traffickdaoarray[5].trim().equalsIgnoreCase("NaN")||traffickdaoarray[5].trim().equalsIgnoreCase("")|| traffickdaoarray[5].isEmpty()?0:Common.changeStringtoSqlDate(traffickdaoarray[5].trim()))+"',"
								       + "'"+(traffickdaoarray[6].trim().equalsIgnoreCase("undefined") || traffickdaoarray[6].trim().equalsIgnoreCase("NaN")||traffickdaoarray[6].trim().equalsIgnoreCase("")|| traffickdaoarray[6].isEmpty()?0:traffickdaoarray[6].trim())+"',"
								       + "'"+(traffickdaoarray[7].trim().equalsIgnoreCase("undefined") || traffickdaoarray[7].trim().equalsIgnoreCase("NaN")||traffickdaoarray[7].trim().equalsIgnoreCase("")|| traffickdaoarray[7].isEmpty()?0:traffickdaoarray[7].trim())+"',"
								       + "'"+(traffickdaoarray[8].trim().equalsIgnoreCase("undefined") || traffickdaoarray[8].trim().equalsIgnoreCase("NaN")||traffickdaoarray[8].trim().equalsIgnoreCase("")|| traffickdaoarray[8].isEmpty()?0:traffickdaoarray[8].trim())+"'," 
								       + "'"+(traffickdaoarray[9].trim().equalsIgnoreCase("undefined") || traffickdaoarray[9].trim().equalsIgnoreCase("NaN")||traffickdaoarray[9].trim().equalsIgnoreCase("")|| traffickdaoarray[9].isEmpty()?0:traffickdaoarray[9].trim())+"',"
								       + "'"+(traffickdaoarray[10].trim().equalsIgnoreCase("undefined") || traffickdaoarray[10].trim().equalsIgnoreCase("NaN")||traffickdaoarray[10].trim().equalsIgnoreCase("")|| traffickdaoarray[10].isEmpty()?0:traffickdaoarray[10].trim())+"',"

+ "'"+(traffickdaoarray[11].trim().equalsIgnoreCase("undefined") || traffickdaoarray[11].trim().equalsIgnoreCase("NaN")||traffickdaoarray[11].trim().equalsIgnoreCase("")|| traffickdaoarray[11].isEmpty()?0:traffickdaoarray[11].trim())+"',"
								       +"'"+sqlStartDate+"',3,'"+docno+"','"+session.getAttribute("BRANCHID").toString()+"')";
						           
								     int resultSet2 = stmtsave.executeUpdate (sql);
								     if(resultSet2<=0)
											 	{
											 		 conn.close();
											 		return 0;
											 	}	
								     
			                           }				     
			    }
			}
			
			if (docno > 0) {
				
				conn.commit();
				stmtsave.close();
				conn.close();
					
				return docno;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	   }
	


	public boolean edit(int docno, Date sqlStartDate, String entry,
			ArrayList<String> salickarray, ArrayList<String> traffickarray,
			HttpSession session, String mode, String formdetailcode) throws SQLException {
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);  
		
			CallableStatement stmtsave = conn.prepareCall("{call salicktrafficDML(?,?,?,?,?,?,?)}");
			
			stmtsave.setDate(1,sqlStartDate);
			stmtsave.setString(2,entry);
			stmtsave.setString(3,"E");
			stmtsave.setString(4,formdetailcode);
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(6,session.getAttribute("BRANCHID").toString());
			stmtsave.setInt(7, docno);
			int aaa=stmtsave.executeUpdate();
		
			docno=stmtsave.getInt("docNo");
					
			 if(aaa<=0){
					conn.close();
					return false;
					
				      }
			 
			 
				if(entry.equalsIgnoreCase("salik"))
				{
					   String delsql="Delete from gl_salik where doc_no="+docno+" ";
					   stmtsave.executeUpdate(delsql);

						for(int i=0;i< salickarray.size();i++)
						{
							

					/*		int  masterdoc = 0;
							
						
							 String selectsql="select coalesce(max(doc_no)+1,1) as doc_no  from gl_salik ";
					
							 ResultSet resSet = stmtsave.executeQuery(selectsql);
								
							    if (resSet.next()) {
							    	 masterdoc = resSet.getInt("doc_no");
							                      }*/
					    	
						     String[] salicldaoarray=salickarray.get(i).split("::");
									     if(!(salicldaoarray[0].trim().equalsIgnoreCase("undefined")|| salicldaoarray[0].trim().equalsIgnoreCase("NaN")||salicldaoarray[0].trim().equalsIgnoreCase("")|| salicldaoarray[0].isEmpty()))
									     {
									    	/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
										     String sql="INSERT INTO gl_salik(sr_no,fleetno,regno,tagno,salik_date,sal_date,salik_time,trans,direction,Source,amount,location,date,status,doc_no,branch)VALUES"
												       + " ("+(i+1)+","
												         + "'"+(salicldaoarray[0].trim().equalsIgnoreCase("undefined") || salicldaoarray[0].trim().equalsIgnoreCase("NaN")|| salicldaoarray[0].trim().equalsIgnoreCase("")|| salicldaoarray[0].isEmpty()?0:salicldaoarray[0].trim())+"',"
												       + "'"+(salicldaoarray[1].trim().equalsIgnoreCase("undefined") || salicldaoarray[1].trim().equalsIgnoreCase("NaN")|| salicldaoarray[1].trim().equalsIgnoreCase("")|| salicldaoarray[1].isEmpty()?0:salicldaoarray[1].trim())+"',"
												       + "'"+(salicldaoarray[2].trim().equalsIgnoreCase("undefined") || salicldaoarray[2].trim().equalsIgnoreCase("NaN")|| salicldaoarray[2].trim().equalsIgnoreCase("")|| salicldaoarray[2].isEmpty()?0:salicldaoarray[2].trim())+"',"
												       + "(cast(concat('"+(salicldaoarray[3].trim().equalsIgnoreCase("undefined") || salicldaoarray[3].trim().equalsIgnoreCase("NaN")||salicldaoarray[3].trim().equalsIgnoreCase("")|| salicldaoarray[3].isEmpty()?0:Common.changeStringtoSqlDate(salicldaoarray[3].trim()))+"',concat(' ','"+(salicldaoarray[4].trim().equalsIgnoreCase("undefined") || salicldaoarray[4].trim().equalsIgnoreCase("NaN")||salicldaoarray[4].trim().equalsIgnoreCase("")|| salicldaoarray[4].isEmpty()?0:salicldaoarray[4].trim())+"')) as datetime)),"
												       + "'"+(salicldaoarray[3].trim().equalsIgnoreCase("undefined") || salicldaoarray[3].trim().equalsIgnoreCase("NaN")||salicldaoarray[3].trim().equalsIgnoreCase("")|| salicldaoarray[3].isEmpty()?0:salicldaoarray[3].trim())+"',"
												       + "'"+(salicldaoarray[4].trim().equalsIgnoreCase("undefined") || salicldaoarray[4].trim().equalsIgnoreCase("NaN")||salicldaoarray[4].trim().equalsIgnoreCase("")|| salicldaoarray[4].isEmpty()?0:salicldaoarray[4].trim())+"',"
												       + "'"+(salicldaoarray[5].trim().equalsIgnoreCase("undefined") || salicldaoarray[5].trim().equalsIgnoreCase("NaN")||salicldaoarray[5].trim().equalsIgnoreCase("")|| salicldaoarray[5].isEmpty()?0:salicldaoarray[5].trim())+"',"
												       + "'"+(salicldaoarray[6].trim().equalsIgnoreCase("undefined") || salicldaoarray[6].trim().equalsIgnoreCase("NaN")||salicldaoarray[6].trim().equalsIgnoreCase("")|| salicldaoarray[6].isEmpty()?0:salicldaoarray[6].trim())+"',"
												       + "'"+(salicldaoarray[7].trim().equalsIgnoreCase("undefined") || salicldaoarray[7].trim().equalsIgnoreCase("NaN")||salicldaoarray[7].trim().equalsIgnoreCase("")|| salicldaoarray[7].isEmpty()?0:salicldaoarray[7].trim())+"',"
												       + "'"+(salicldaoarray[8].trim().equalsIgnoreCase("undefined") || salicldaoarray[8].trim().equalsIgnoreCase("NaN")||salicldaoarray[8].trim().equalsIgnoreCase("")|| salicldaoarray[8].isEmpty()?0:salicldaoarray[8].trim())+"'," 
												       + "'"+(salicldaoarray[9].trim().equalsIgnoreCase("undefined") || salicldaoarray[9].trim().equalsIgnoreCase("NaN")||salicldaoarray[9].trim().equalsIgnoreCase("")|| salicldaoarray[9].isEmpty()?0:salicldaoarray[9].trim())+"',"
													  +"'"+sqlStartDate+"',3,'"+docno+"','"+session.getAttribute("BRANCHID").toString()+"')";
										
								  
										     int resultSet2 = stmtsave.executeUpdate (sql);
										     if(resultSet2<=0)
													 	{
													 		 conn.close();
													 		return false;
													 	}	
										     
					                           }				     
					    }
			
				}
				else
				{
					 String delsql="Delete from gl_traffic where doc_no="+docno+" ";
					   stmtsave.executeUpdate(delsql);
					   for(int i=0;i< traffickarray.size();i++)
						{
				       
						     String[] traffickdaoarray=traffickarray.get(i).split("::");
						   
									     if(!(traffickdaoarray[0].trim().equalsIgnoreCase("undefined")|| traffickdaoarray[0].trim().equalsIgnoreCase("NaN")||traffickdaoarray[0].trim().equalsIgnoreCase("")|| traffickdaoarray[0].isEmpty()))
									     {
									    	 
									    	/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
								     String sql="INSERT INTO gl_traffic(sr_no,Fleetno,regNo,Source,Fine_Source,Ticket_No,traffic_date,time,amount,desc1,location,pcolor,tcno,date,status,doc_no,branch)VALUES"
										       + " ("+(i+1)+","
										         + "'"+(traffickdaoarray[0].trim().equalsIgnoreCase("undefined") || traffickdaoarray[0].trim().equalsIgnoreCase("NaN")|| traffickdaoarray[0].trim().equalsIgnoreCase("")|| traffickdaoarray[0].isEmpty()?0:traffickdaoarray[0].trim())+"',"
										       + "'"+(traffickdaoarray[1].trim().equalsIgnoreCase("undefined") || traffickdaoarray[1].trim().equalsIgnoreCase("NaN")|| traffickdaoarray[1].trim().equalsIgnoreCase("")|| traffickdaoarray[1].isEmpty()?0:traffickdaoarray[1].trim())+"',"
										       + "'"+(traffickdaoarray[2].trim().equalsIgnoreCase("undefined") || traffickdaoarray[2].trim().equalsIgnoreCase("NaN")|| traffickdaoarray[2].trim().equalsIgnoreCase("")|| traffickdaoarray[2].isEmpty()?0:traffickdaoarray[2].trim())+"',"
										       + "'"+(traffickdaoarray[3].trim().equalsIgnoreCase("undefined") || traffickdaoarray[3].trim().equalsIgnoreCase("NaN")||traffickdaoarray[3].trim().equalsIgnoreCase("")|| traffickdaoarray[3].isEmpty()?0:traffickdaoarray[3].trim())+"',"
										       + "'"+(traffickdaoarray[4].trim().equalsIgnoreCase("undefined") || traffickdaoarray[4].trim().equalsIgnoreCase("NaN")||traffickdaoarray[4].trim().equalsIgnoreCase("")|| traffickdaoarray[4].isEmpty()?0:traffickdaoarray[4].trim())+"',"
										       + "'"+(traffickdaoarray[5].trim().equalsIgnoreCase("undefined") || traffickdaoarray[5].trim().equalsIgnoreCase("NaN")||traffickdaoarray[5].trim().equalsIgnoreCase("")|| traffickdaoarray[5].isEmpty()?0:Common.changeStringtoSqlDate(traffickdaoarray[5].trim()))+"',"
										       + "'"+(traffickdaoarray[6].trim().equalsIgnoreCase("undefined") || traffickdaoarray[6].trim().equalsIgnoreCase("NaN")||traffickdaoarray[6].trim().equalsIgnoreCase("")|| traffickdaoarray[6].isEmpty()?0:traffickdaoarray[6].trim())+"',"
										       + "'"+(traffickdaoarray[7].trim().equalsIgnoreCase("undefined") || traffickdaoarray[7].trim().equalsIgnoreCase("NaN")||traffickdaoarray[7].trim().equalsIgnoreCase("")|| traffickdaoarray[7].isEmpty()?0:traffickdaoarray[7].trim())+"',"
										       + "'"+(traffickdaoarray[8].trim().equalsIgnoreCase("undefined") || traffickdaoarray[8].trim().equalsIgnoreCase("NaN")||traffickdaoarray[8].trim().equalsIgnoreCase("")|| traffickdaoarray[8].isEmpty()?0:traffickdaoarray[8].trim())+"'," 
										       + "'"+(traffickdaoarray[9].trim().equalsIgnoreCase("undefined") || traffickdaoarray[9].trim().equalsIgnoreCase("NaN")||traffickdaoarray[9].trim().equalsIgnoreCase("")|| traffickdaoarray[9].isEmpty()?0:traffickdaoarray[9].trim())+"',"
										       + "'"+(traffickdaoarray[10].trim().equalsIgnoreCase("undefined") || traffickdaoarray[10].trim().equalsIgnoreCase("NaN")||traffickdaoarray[10].trim().equalsIgnoreCase("")|| traffickdaoarray[10].isEmpty()?0:traffickdaoarray[10].trim())+"',"
										   
+ "'"+(traffickdaoarray[11].trim().equalsIgnoreCase("undefined") || traffickdaoarray[11].trim().equalsIgnoreCase("NaN")||traffickdaoarray[11].trim().equalsIgnoreCase("")|| traffickdaoarray[11].isEmpty()?0:traffickdaoarray[11].trim())+"',"

    +"'"+sqlStartDate+"',3,'"+docno+"','"+session.getAttribute("BRANCHID").toString()+"')";
								           
										     int resultSet2 = stmtsave.executeUpdate (sql);
										     if(resultSet2<=0)
													 	{
													 		 conn.close();
													 		return false;
													 	}	
										     
					                           }				     
					    }
			
				}
						
			if (aaa > 0) {
				conn.commit();
				stmtsave.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno,HttpSession session,String mode,String formdetailcode) throws SQLException {
		try{
			conn=connDAO.getMyConnection();
			
		
			CallableStatement stmtsave = conn.prepareCall("{call salicktrafficDML(?,?,?,?,?,?,?)}");
			
			stmtsave.setDate(1,null);
			stmtsave.setString(2,null);
			stmtsave.setString(3,"D");
			stmtsave.setString(4,formdetailcode);
			stmtsave.setString(5,session.getAttribute("USERID").toString());
			stmtsave.setString(6,session.getAttribute("BRANCHID").toString());
			stmtsave.setInt(7, docno);
			int aaa=stmtsave.executeUpdate();
		
			if (aaa > 0) {
				
				stmtsave.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}	
		}catch(Exception e){
			conn.close();
		}
		return false;
	}

	
	
	
	
	public JSONArray saliksearchfleet(HttpSession session) throws SQLException {

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
	    	//
	        Connection conn =  null;
      
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
           	
				String sql=("select reg_no,fleet_no,flname,salik_tag tcno from gl_vehmaster where statu=3 and brhid='"+brcid+"' ");
				
				ResultSet resultSet = stmtVeh.executeQuery (sql);
				RESULTDATA=Common.convertToJSON(resultSet);
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
	public JSONArray trafficsearchfleet(HttpSession session) throws SQLException {

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
	    	//
	        Connection conn = null;
     
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
          	
				ResultSet resultSet = stmtVeh.executeQuery ("select v.reg_no,v.fleet_no,v.flname,a.authname authid,p.code_name pltid,v.tcno from gl_vehmaster v left join gl_vehauth a on a.doc_no=v.authid "
						+ "left join gl_vehplate p on p.doc_no=v.pltid where v.statu=3 and v.brhid='"+brcid+"' ");

				RESULTDATA=Common.convertToJSON(resultSet);
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
	public JSONArray reloadsalik(String salickdoc) throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	   	    
	   	Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
         	
				ResultSet resultSet = stmtVeh.executeQuery ("select Fleetno,regno,TagNo,salik_date date, DATE_FORMAT(salik_date,'%d.%m.%Y') AS "
					+ "	hiddate,salik_time time,salik_time hidtime,Trans transaction,Direction,Source,Amount,Location from gl_salik where doc_no='"+salickdoc+"' ");

				RESULTDATA=Common.convertToJSON(resultSet);
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
	public JSONArray reloadtraffic(String trafficdoc) throws SQLException {

	   	 JSONArray RESULTDATA=new JSONArray();
	   	    
	   	Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
        	
				String sql= ("select Fleetno,regNo,Source,Fine_Source finesource,ticket_no fineno,TRAFFIC_DATE date,DATE_FORMAT(TRAFFIC_DATE,'%d.%m.%Y') as hiddate, "
						+ "time,time hidtime,amount,Desc1 description,Location,pcolor pltid from gl_traffic where doc_no='"+trafficdoc+"' ");
				
				
				ResultSet resultSet = stmtVeh.executeQuery(sql);
				RESULTDATA=Common.convertToJSON(resultSet);
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
	

	 public JSONArray searchMaster(HttpSession session,String seardoc,String seardate,String seartype) throws SQLException {


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
	   	        
	    	 //  System.out.println("8888888888"+clnames); 	
	   	 String brid=session.getAttribute("BRANCHID").toString();
	    	
	   
		    
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    	//enqdate.trim();
	    	if(!(seardate.equalsIgnoreCase("undefined"))&&!(seardate.equalsIgnoreCase(""))&&!(seardate.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = Common.changeStringtoSqlDate(seardate);
	    	}
	    	
	    	
	    	
	    	String sqltest="";
	    	if(!(seardoc.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and m.doc_no like '%"+seardoc+"%'";
	    	}
	    	
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	    	} 
	        
	    	
	        	
	    	 Connection conn = null;
	 
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtenq1 = conn.createStatement ();
					if(seartype.equalsIgnoreCase("salik"))
					{
					
					String clssql= ("select 'salik' type, m.doc_no,m.date,d.fleetno,d.amount from gl_salikm m left join gl_salik d on d.doc_no=m.doc_no  where m.status=3 and d.branch='"+brid+"' " +sqltest );
				 
					ResultSet resultSet = stmtenq1.executeQuery(clssql);
					
					RESULTDATA=Common.convertToJSON(resultSet);
				
					
					}
					else	
					{
						String clssql= ("select 'traffic' type, m.doc_no,m.date,d.fleetno,d.amount  from gl_trafficm m left join gl_traffic d on d.doc_no=m.doc_no where m.status=3 and d.branch='"+brid+"' " +sqltest);
					
						//System.out.println("========="+clssql);
						ResultSet resultSet = stmtenq1.executeQuery(clssql);
					
						RESULTDATA=Common.convertToJSON(resultSet);
						
						
					}
					stmtenq1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }

	
	
}
