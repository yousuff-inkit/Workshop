
package com.operations.marketing.quotation;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.quotation.ClsquotationBean;

public class ClsquotationDAO {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon  commDAO=new ClsCommon();
	Connection conn;

	public int insert(Date sqlStartDate,String qutcldocno,String mobno,String qutremarks,String qutemail,String attention,HttpSession session,String mode,String refno,String reftype,
			ArrayList<String> quotsarray,ArrayList<String> qtarifarray,String descmain,ArrayList<String> descarray,String formcode, HttpServletRequest request) throws SQLException {
		try{
			int docno ;
			
			if(refno.equalsIgnoreCase("")||refno.equalsIgnoreCase("0")||refno.equalsIgnoreCase("NA"))
			{
				refno=null;	
			}
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);      
			CallableStatement stmtquatation = conn.prepareCall("{call quotationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtquatation.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtquatation.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtquatation.setDate(1,sqlStartDate);
			stmtquatation.setString(2,qutcldocno);
			stmtquatation.setString(3,mobno);
			stmtquatation.setString(4,qutemail);
			stmtquatation.setString(5,qutremarks);
			stmtquatation.setString(6,attention);
			stmtquatation.setString(7,reftype);
			stmtquatation.setString(8,refno);
			stmtquatation.setString(9,descmain);
		    stmtquatation.setString(10,session.getAttribute("USERID").toString());
			stmtquatation.setString(11,session.getAttribute("BRANCHID").toString());
		    stmtquatation.setString(12,formcode.trim());
		    stmtquatation.setString(14,mode);
			stmtquatation.executeQuery();
			docno=stmtquatation.getInt("docNo");
			
			int vocno=stmtquatation.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			
			
			if(docno<=0)
			{
				
			conn.close();	
				return 0;
			}
			
			

			for(int i=0;i< quotsarray.size();i++){
		    	
			     String[] quotarray=quotsarray.get(i).split("::");
			     if(!(quotarray[1].trim().equalsIgnoreCase("undefined")|| quotarray[1].trim().equalsIgnoreCase("NaN")||quotarray[1].trim().equalsIgnoreCase("")|| quotarray[1].isEmpty()))
			     {
			    	
		     String sql="INSERT INTO gl_qenq(SR_NO,BRDID,MODID,SPEC,CLRID,RTYPE,FRMDATE,TODATE,UNIT,GRPID,yom,RDOCNO)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(quotarray[1].trim().equalsIgnoreCase("undefined") || quotarray[1].trim().equalsIgnoreCase("NaN")||quotarray[1].trim().equalsIgnoreCase("null")|| quotarray[1].trim().equalsIgnoreCase("")|| quotarray[1].isEmpty()?0:quotarray[1].trim())+"',"
				       + "'"+(quotarray[2].trim().equalsIgnoreCase("undefined") || quotarray[2].trim().equalsIgnoreCase("NaN")||quotarray[2].trim().equalsIgnoreCase("null")|| quotarray[2].trim().equalsIgnoreCase("")|| quotarray[2].isEmpty()?0:quotarray[2].trim())+"',"
				       + "'"+(quotarray[3].trim().equalsIgnoreCase("undefined") || quotarray[3].trim().equalsIgnoreCase("NaN")||quotarray[3].trim().equalsIgnoreCase("null")||quotarray[3].trim().equalsIgnoreCase("")|| quotarray[3].isEmpty()?0:quotarray[3].trim())+"',"
				       + "'"+(quotarray[4].trim().equalsIgnoreCase("undefined") || quotarray[4].trim().equalsIgnoreCase("NaN")||quotarray[4].trim().equalsIgnoreCase("null")||quotarray[4].trim().equalsIgnoreCase("")|| quotarray[4].isEmpty()?0:quotarray[4].trim())+"',"
				       + "'"+(quotarray[5].trim().equalsIgnoreCase("undefined") || quotarray[5].trim().equalsIgnoreCase("NaN")||quotarray[5].trim().equalsIgnoreCase("null")||quotarray[5].trim().equalsIgnoreCase("")|| quotarray[5].isEmpty()?0:quotarray[5].trim())+"',"
				       + ""+(quotarray[6].trim().equalsIgnoreCase("undefined") || quotarray[6].trim().equalsIgnoreCase("NaN")||quotarray[6].trim().equalsIgnoreCase("null")|| quotarray[6].trim().isEmpty()?null:"'"+commDAO.changeStringtoSqlDate(quotarray[6].trim())+"'")+","
				       + ""+(quotarray[7].trim().equalsIgnoreCase("undefined") || quotarray[7].trim().equalsIgnoreCase("NaN")||quotarray[7].trim().equalsIgnoreCase("null")|| quotarray[7].trim().isEmpty()?null:"'"+commDAO.changeStringtoSqlDate(quotarray[7].trim())+"'")+","
				       + "'"+(quotarray[8].trim().equalsIgnoreCase("undefined") || quotarray[8].trim().equalsIgnoreCase("NaN")||quotarray[8].trim().equalsIgnoreCase("null")|| quotarray[8].isEmpty()?0:quotarray[8].trim())+"',"
			        + "'"+(quotarray[9].trim().equalsIgnoreCase("undefined") || quotarray[9].trim().equalsIgnoreCase("NaN")||quotarray[9].trim().equalsIgnoreCase("null")|| quotarray[9].isEmpty()?0:quotarray[9].trim())+"',"
				      + "'"+(quotarray[10].trim().equalsIgnoreCase("undefined") || quotarray[10].trim().equalsIgnoreCase("NA")|| quotarray[10].trim().equalsIgnoreCase("NaN")||quotarray[10].trim().equalsIgnoreCase("null")|| quotarray[10].isEmpty()?0:quotarray[10].trim())+"',"
			        +"'"+docno+"')";
		            
				     int resultSet2 = stmtquatation.executeUpdate (sql);
				 	if(resultSet2<=0)
					{
						
					conn.close();	
						return 0;
					}
				     
			     }
			} 
			     for(int i=0;i< qtarifarray.size();i++){
				    	
				     String[] tariff=qtarifarray.get(i).split("::"); 
				     if(!(tariff[1].trim().equalsIgnoreCase("undefined")|| tariff[1].trim().equalsIgnoreCase("NaN")||tariff[1].trim().equalsIgnoreCase("")|| tariff[1].isEmpty()))
				     {
				    // System.out.println("dasfghjk======="+ragmttariffarray.get(i));
				     String sql="INSERT INTO gl_quotd(rentaltype,tariff,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,grpid,srno,tdocno,rdocno)VALUES"
				       + " ('"+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].isEmpty()?0:tariff[0].trim())+"',"
				       + "'"+(tariff[1].trim().equalsIgnoreCase("undefined") || tariff[1].trim().equalsIgnoreCase("")|| tariff[1].trim().equalsIgnoreCase("NaN") || tariff[1].isEmpty()?0:tariff[1].trim())+"',"
				       + "'"+(tariff[2].trim().equalsIgnoreCase("undefined") || tariff[2].trim().equalsIgnoreCase("")|| tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+"',"
				       + "'"+(tariff[3].trim().equalsIgnoreCase("undefined") || tariff[3].trim().equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+"',"
				       + "'"+(tariff[4].trim().equalsIgnoreCase("undefined") || tariff[4].trim().equalsIgnoreCase("") || tariff[4].trim().equalsIgnoreCase("NaN")|| tariff[4].isEmpty()?0:tariff[4].trim())+"',"
				       + "'"+(tariff[5].trim().equalsIgnoreCase("undefined") || tariff[5].trim().equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+"',"
				       + "'"+(tariff[6].trim().equalsIgnoreCase("undefined") || tariff[6].trim().equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+"',"
				       + "'"+(tariff[7].trim().equalsIgnoreCase("undefined") || tariff[7].trim().equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+"',"
				       + "'"+(tariff[8].trim().equalsIgnoreCase("undefined") || tariff[8].trim().equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+"',"
				       + "'"+(tariff[9].trim().equalsIgnoreCase("undefined") || tariff[9].trim().equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+"',"
				       + "'"+(tariff[10].trim().equalsIgnoreCase("undefined") || tariff[10].trim().equalsIgnoreCase("")|| tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+"',"
				       + "'"+(tariff[11].trim().equalsIgnoreCase("undefined") || tariff[11].trim().equalsIgnoreCase("")|| tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+"',"
				       + "'"+(tariff[12].trim().equalsIgnoreCase("undefined") || tariff[12].trim().equalsIgnoreCase("")|| tariff[12].trim().equalsIgnoreCase("NaN")|| tariff[12].isEmpty()?0:tariff[12].trim())+"',"
				       + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"
				       + "'"+(i+1)+"',"
				       + "'"+(tariff[15].trim().equalsIgnoreCase("undefined") || tariff[15].trim().equalsIgnoreCase("")|| tariff[15].trim().equalsIgnoreCase("NaN")|| tariff[15].isEmpty()?0:tariff[15].trim())+"',"
				       +"'"+docno+"' )";
				     //System.out.println("---------"+sql);
				     int resultSet3 = stmtquatation.executeUpdate (sql);
				    // System.out.println("---------"+sql);
				    // System.out.println("==================="+tariff[2].trim());
				  	if(resultSet3<=0)
					{
						
					conn.close();	
						return 0;
					}
				     
				     
				     }
				     }
				   
			     
			 	for(int i=0;i< descarray.size();i++){
			    	
				     String[] desarray=descarray.get(i).split("::");
				     if(!(desarray[1].trim().equalsIgnoreCase("undefined")|| desarray[1].trim().equalsIgnoreCase("NaN")||desarray[1].trim().equalsIgnoreCase("")|| desarray[1].isEmpty()))
				     {
				    	
			     String sql="INSERT INTO gl_quotc(srno,desid,descplus,rdocno,brhid)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(desarray[1].trim().equalsIgnoreCase("undefined") || desarray[1].trim().equalsIgnoreCase("NaN")|| desarray[1].trim().equalsIgnoreCase("")|| desarray[1].isEmpty()?0:desarray[1].trim())+"',"
					       + "'"+(desarray[2].trim().equalsIgnoreCase("undefined") || desarray[2].trim().equalsIgnoreCase("NaN")|| desarray[2].trim().equalsIgnoreCase("")|| desarray[2].isEmpty()?0:desarray[2].trim())+"',"
					       +"'"+docno+"','"+session.getAttribute("BRANCHID").toString()+"')";
			   
					     int resultSet4 = stmtquatation.executeUpdate (sql);
					    
					 	if(resultSet4<=0)
						{
							
						conn.close();	
							return 0;
						}
				     }
				} 
				     
		/*	 	 for(int i=0;i<maintariff.size();i++){
				    	
				     String[] qtariff=maintariff.get(i).split("::");
				    
				    // System.out.println("dasfghjk======="+ragmttariffarray.get(i));
				     String sql="INSERT INTO gl_rtarif(rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,rstatus,rdocno)VALUES"
				       + " ('"+(qtariff[0].equalsIgnoreCase("undefined") || qtariff[0].equalsIgnoreCase("") || qtariff[0].isEmpty()?0:qtariff[0].trim())+"',"
				       + "'"+(qtariff[1].trim().equalsIgnoreCase("undefined") || qtariff[1].trim().equalsIgnoreCase("") || qtariff[1].isEmpty()?0:qtariff[1].trim())+"',"
				       + "'"+(qtariff[2].trim().equalsIgnoreCase("undefined") || qtariff[2].trim().equalsIgnoreCase("") || qtariff[2].isEmpty()?0:qtariff[2].trim())+"',"
				       + "'"+(qtariff[3].trim().equalsIgnoreCase("undefined") || qtariff[3].trim().equalsIgnoreCase("") || qtariff[3].isEmpty()?0:qtariff[3].trim())+"',"
				       + "'"+(qtariff[4].trim().equalsIgnoreCase("undefined") || qtariff[4].trim().equalsIgnoreCase("") || qtariff[4].isEmpty()?0:qtariff[4].trim())+"',"
				       + "'"+(qtariff[5].trim().equalsIgnoreCase("undefined") || qtariff[5].trim().equalsIgnoreCase("") || qtariff[5].isEmpty()?0:qtariff[5].trim())+"',"
				       + "'"+(qtariff[6].trim().equalsIgnoreCase("undefined") || qtariff[6].trim().equalsIgnoreCase("") || qtariff[6].isEmpty()?0:qtariff[6].trim())+"',"
				       + "'"+(qtariff[7].trim().equalsIgnoreCase("undefined") || qtariff[7].trim().equalsIgnoreCase("") || qtariff[7].isEmpty()?0:qtariff[7].trim())+"',"
				       + "'"+(qtariff[8].trim().equalsIgnoreCase("undefined") || qtariff[8].trim().equalsIgnoreCase("") || qtariff[8].isEmpty()?0:qtariff[8].trim())+"',"
				       + "'"+(qtariff[9].trim().equalsIgnoreCase("undefined") || qtariff[9].trim().equalsIgnoreCase("") || qtariff[9].isEmpty()?0:qtariff[9].trim())+"',"
				       + "'"+(qtariff[10].trim().equalsIgnoreCase("undefined") || qtariff[10].trim().equalsIgnoreCase("")|| qtariff[10].isEmpty()?0:qtariff[10].trim())+"',"
				       + "'"+(qtariff[11].trim().equalsIgnoreCase("undefined") || qtariff[11].trim().equalsIgnoreCase("")|| qtariff[11].isEmpty()?0:qtariff[11].trim())+"',"
				       + "'"+(qtariff[12].trim().equalsIgnoreCase("undefined") || qtariff[12].trim().equalsIgnoreCase("")|| qtariff[12].isEmpty()?0:qtariff[12].trim())+"',"
				       + "'"+(qtariff[13].trim().equalsIgnoreCase("undefined") || qtariff[13].trim().equalsIgnoreCase("")|| qtariff[13].isEmpty()?0:qtariff[13].trim())+"',"
				       +"'"+docno+"' )";
				     int resultSet4 = stmtquatation.executeUpdate (sql);
				    // System.out.println("==================="+tariff[2].trim());
				     
				     }*/
				        
			if (docno > 0) {
				conn.commit();
				stmtquatation.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
		}
		return 0;
	   }
	
	public boolean edit(int docno,Date sqlStartDate,String qutcldocno,String mobno,String qutremarks,String qutemail,String attention,HttpSession session,String mode,String refno,String reftype,
			ArrayList<String> quotsarray,ArrayList<String> qtarifarray,String descmain,ArrayList<String> descarray,String formcode) throws SQLException {
		
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false); 
		//	System.out.println("--------------"+refno);
			
			CallableStatement stmtquatation = conn.prepareCall("{call quotationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtquatation.setDate(1,sqlStartDate);
			stmtquatation.setString(2,qutcldocno);
			stmtquatation.setString(3,mobno.trim());
			stmtquatation.setString(4,qutemail);
			stmtquatation.setString(5,qutremarks);
			stmtquatation.setString(6,attention);
			stmtquatation.setString(7,reftype);
			stmtquatation.setString(8,refno);
			stmtquatation.setString(9,descmain);
		    stmtquatation.setString(10,session.getAttribute("USERID").toString());
			stmtquatation.setString(11,session.getAttribute("BRANCHID").toString());
			stmtquatation.setString(12,formcode.trim());
			stmtquatation.setInt(13,docno);
			stmtquatation.setString(14,mode);
			stmtquatation.setInt(15,0);
		
			int editval=stmtquatation.executeUpdate();
			// System.out.println("-----editval----"+editval);	
			docno=stmtquatation.getInt("docNo");
					
			
			if (editval <= 0) {
			
				conn.close();
				
				return false;
			}
			  String delsql="Delete from gl_qenq where rdocno="+docno+" ";
			  stmtquatation.executeUpdate(delsql);
			   
			  for(int i=0;i< quotsarray.size();i++){
			    	
				     String[] quotarray=quotsarray.get(i).split("::");
				     if(!(quotarray[1].trim().equalsIgnoreCase("undefined")|| quotarray[1].trim().equalsIgnoreCase("NaN")||quotarray[1].trim().equalsIgnoreCase("")|| quotarray[1].isEmpty()))
				     {
				    	
			     String sql="INSERT INTO gl_qenq(SR_NO,BRDID,MODID,SPEC,CLRID,RTYPE,FRMDATE,TODATE,UNIT,GRPID,yom,RDOCNO)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(quotarray[1].trim().equalsIgnoreCase("undefined") || quotarray[1].trim().equalsIgnoreCase("NaN")||quotarray[1].trim().equalsIgnoreCase("null")|| quotarray[1].trim().equalsIgnoreCase("")|| quotarray[1].isEmpty()?0:quotarray[1].trim())+"',"
					       + "'"+(quotarray[2].trim().equalsIgnoreCase("undefined") || quotarray[2].trim().equalsIgnoreCase("NaN")||quotarray[2].trim().equalsIgnoreCase("null")|| quotarray[2].trim().equalsIgnoreCase("")|| quotarray[2].isEmpty()?0:quotarray[2].trim())+"',"
					       + "'"+(quotarray[3].trim().equalsIgnoreCase("undefined") || quotarray[3].trim().equalsIgnoreCase("NaN")||quotarray[3].trim().equalsIgnoreCase("null")||quotarray[3].trim().equalsIgnoreCase("")|| quotarray[3].isEmpty()?0:quotarray[3].trim())+"',"
					       + "'"+(quotarray[4].trim().equalsIgnoreCase("undefined") || quotarray[4].trim().equalsIgnoreCase("NaN")||quotarray[4].trim().equalsIgnoreCase("null")||quotarray[4].trim().equalsIgnoreCase("")|| quotarray[4].isEmpty()?0:quotarray[4].trim())+"',"
					       + "'"+(quotarray[5].trim().equalsIgnoreCase("undefined") || quotarray[5].trim().equalsIgnoreCase("NaN")||quotarray[5].trim().equalsIgnoreCase("null")||quotarray[5].trim().equalsIgnoreCase("")|| quotarray[5].isEmpty()?0:quotarray[5].trim())+"',"
					       + ""+(quotarray[6].trim().equalsIgnoreCase("undefined") || quotarray[6].trim().equalsIgnoreCase("NaN")||quotarray[6].trim().equalsIgnoreCase("null")|| quotarray[6].trim().isEmpty()?null:"'"+commDAO.changeStringtoSqlDate(quotarray[6].trim())+"'")+","
					       + ""+(quotarray[7].trim().equalsIgnoreCase("undefined") || quotarray[7].trim().equalsIgnoreCase("NaN")||quotarray[7].trim().equalsIgnoreCase("null")|| quotarray[7].trim().isEmpty()?null:"'"+commDAO.changeStringtoSqlDate(quotarray[7].trim())+"'")+","
					       + "'"+(quotarray[8].trim().equalsIgnoreCase("undefined") || quotarray[8].trim().equalsIgnoreCase("NaN")||quotarray[8].trim().equalsIgnoreCase("null")|| quotarray[8].isEmpty()?0:quotarray[8].trim())+"',"
					        + "'"+(quotarray[9].trim().equalsIgnoreCase("undefined") || quotarray[9].trim().equalsIgnoreCase("NaN")||quotarray[9].trim().equalsIgnoreCase("null")|| quotarray[9].isEmpty()?0:quotarray[9].trim())+"',"
					       + "'"+(quotarray[10].trim().equalsIgnoreCase("undefined") || quotarray[10].trim().equalsIgnoreCase("NA")|| quotarray[10].trim().equalsIgnoreCase("NaN")||quotarray[10].trim().equalsIgnoreCase("null")|| quotarray[10].isEmpty()?0:quotarray[10].trim())+"',"
					        +"'"+docno+"')";
			            
					     int resultSet2 = stmtquatation.executeUpdate (sql);
					 	if(resultSet2<=0)
						{
							
						conn.close();	
							return false;
						}
					     
				     }
				} 
			  String delsql2="Delete from gl_quotd where rdocno="+docno+" ";
			  stmtquatation.executeUpdate(delsql2);
			  

			     for(int i=0;i< qtarifarray.size();i++){
				    	
				     String[] tariff=qtarifarray.get(i).split("::");
				     if(!(tariff[1].trim().equalsIgnoreCase("undefined")|| tariff[1].trim().equalsIgnoreCase("NaN")||tariff[1].trim().equalsIgnoreCase("")|| tariff[1].isEmpty()))
				     {
				  //  System.out.println("dasfghjk======="+tariff[15]);
				    	  String sql="INSERT INTO gl_quotd(rentaltype,tariff,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,grpid,srno,tdocno,rdocno)VALUES"
							       + " ('"+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].isEmpty()?0:tariff[0].trim())+"',"
							       + "'"+(tariff[1].trim().equalsIgnoreCase("undefined") || tariff[1].trim().equalsIgnoreCase("")|| tariff[1].trim().equalsIgnoreCase("NaN") || tariff[1].isEmpty()?0:tariff[1].trim())+"',"
							       + "'"+(tariff[2].trim().equalsIgnoreCase("undefined") || tariff[2].trim().equalsIgnoreCase("")|| tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+"',"
							       + "'"+(tariff[3].trim().equalsIgnoreCase("undefined") || tariff[3].trim().equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+"',"
							       + "'"+(tariff[4].trim().equalsIgnoreCase("undefined") || tariff[4].trim().equalsIgnoreCase("") || tariff[4].trim().equalsIgnoreCase("NaN")|| tariff[4].isEmpty()?0:tariff[4].trim())+"',"
							       + "'"+(tariff[5].trim().equalsIgnoreCase("undefined") || tariff[5].trim().equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+"',"
							       + "'"+(tariff[6].trim().equalsIgnoreCase("undefined") || tariff[6].trim().equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+"',"
							       + "'"+(tariff[7].trim().equalsIgnoreCase("undefined") || tariff[7].trim().equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+"',"
							       + "'"+(tariff[8].trim().equalsIgnoreCase("undefined") || tariff[8].trim().equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+"',"
							       + "'"+(tariff[9].trim().equalsIgnoreCase("undefined") || tariff[9].trim().equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+"',"
							       + "'"+(tariff[10].trim().equalsIgnoreCase("undefined") || tariff[10].trim().equalsIgnoreCase("")|| tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+"',"
							       + "'"+(tariff[11].trim().equalsIgnoreCase("undefined") || tariff[11].trim().equalsIgnoreCase("")|| tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+"',"
							       + "'"+(tariff[12].trim().equalsIgnoreCase("undefined") || tariff[12].trim().equalsIgnoreCase("")|| tariff[12].trim().equalsIgnoreCase("NaN")|| tariff[12].isEmpty()?0:tariff[12].trim())+"',"
							       + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"
							       + "'"+(i+1)+"',"
							       + "'"+(tariff[15].trim().equalsIgnoreCase("undefined") || tariff[15].trim().equalsIgnoreCase("")|| tariff[15].trim().equalsIgnoreCase("NaN")|| tariff[15].isEmpty()?0:tariff[15].trim())+"',"
							       +"'"+docno+"' )";
				     //System.out.println("---------"+sql);
				     int resultSet3 = stmtquatation.executeUpdate (sql);
		
				  	if(resultSet3<=0)
					{
						
					conn.close();	
						return false;
					}
				     
				     
				     }
				     }
				   
			     
			     String delsql3="Delete from gl_quotc where rdocno="+docno+" ";
				  stmtquatation.executeUpdate(delsql3);
				 
				  for(int i=0;i< descarray.size();i++){
			
					     String[] desarray=descarray.get(i).split("::");
				
					     if(!(desarray[1].trim().equalsIgnoreCase("undefined")|| desarray[1].trim().equalsIgnoreCase("NaN")||desarray[1].trim().equalsIgnoreCase("")|| desarray[1].isEmpty()))
					     {
					    	
					    
				     String sql="INSERT INTO gl_quotc(srno,desid,descplus,rdocno,brhid)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(desarray[1].trim().equalsIgnoreCase("undefined") || desarray[1].trim().equalsIgnoreCase("NaN")|| desarray[1].trim().equalsIgnoreCase("")|| desarray[1].isEmpty()?0:desarray[1].trim())+"',"
						       + "'"+(desarray[2].trim().equalsIgnoreCase("undefined") || desarray[2].trim().equalsIgnoreCase("NaN")|| desarray[2].trim().equalsIgnoreCase("")|| desarray[2].isEmpty()?0:desarray[2].trim())+"',"
						       +"'"+docno+"','"+session.getAttribute("BRANCHID").toString()+"')";
				
						     int resultSet4 = stmtquatation.executeUpdate (sql);
						    
						 	if(resultSet4<=0)
							{
								
							conn.close();	
								return false;
							}
					     }
					} 

			 	  
			if (editval > 0) {
				conn.commit();
				stmtquatation.close();
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


/*	public boolean edit(int docno,Date sqlStartDate,String qutcldocno,String mobno,String qutremarks,String qutemail,String attention,HttpSession session,String mode,String refno,String reftype,
			ArrayList<String> quotsarray,ArrayList<String> qtarifarray,String descmain,ArrayList<String> descarray,String formcode) throws SQLException {
		
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);       
			CallableStatement stmtquatation = conn.prepareCall("{call quotationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtquatation.setDate(1,sqlStartDate);
			stmtquatation.setString(2,qutcldocno);
			stmtquatation.setString(3,mobno.trim());
			stmtquatation.setString(4,qutemail);
			stmtquatation.setString(5,qutremarks);
			stmtquatation.setString(6,attention);
			stmtquatation.setString(7,reftype);
			stmtquatation.setString(8,refno);
			stmtquatation.setString(9,descmain);
		    stmtquatation.setString(10,session.getAttribute("USERID").toString());
			stmtquatation.setString(11,session.getAttribute("BRANCHID").toString());
			stmtquatation.setString(12,formcode.trim());
			stmtquatation.setInt(13,docno);
			stmtquatation.setString(14,mode);
			
		
			int editval=stmtquatation.executeUpdate();
			// System.out.println("-----editval----"+editval);	
			docno=stmtquatation.getInt("docNo");
					
			
			if (editval <= 0) {
			
				conn.close();
				
				return false;
			}
			
			for(int i=0;i< quotsarray.size();i++){
		    	
			     String[] quotarray=quotsarray.get(i).split("::");
			     if(!(quotarray[1].trim().equalsIgnoreCase("undefined")|| quotarray[1].trim().equalsIgnoreCase("NaN")||quotarray[1].trim().equalsIgnoreCase("")|| quotarray[1].isEmpty()))
			     {
			    	
		     String sql="update gl_qenq set  SR_NO="+(i+1)+","
				       + "BRDID='"+(quotarray[1].trim().equalsIgnoreCase("undefined") || quotarray[1].trim().equalsIgnoreCase("NaN")|| quotarray[1].trim().equalsIgnoreCase("")|| quotarray[1].isEmpty()?0:quotarray[1].trim())+"',"
				       + "MODID='"+(quotarray[2].trim().equalsIgnoreCase("undefined") || quotarray[2].trim().equalsIgnoreCase("NaN")|| quotarray[2].trim().equalsIgnoreCase("")|| quotarray[2].isEmpty()?0:quotarray[2].trim())+"',"
				       + "SPEC='"+(quotarray[3].trim().equalsIgnoreCase("undefined") || quotarray[3].trim().equalsIgnoreCase("NaN")||quotarray[3].trim().equalsIgnoreCase("")|| quotarray[3].isEmpty()?0:quotarray[3].trim())+"',"
				       + "CLRID='"+(quotarray[4].trim().equalsIgnoreCase("undefined") || quotarray[4].trim().equalsIgnoreCase("NaN")||quotarray[4].trim().equalsIgnoreCase("")|| quotarray[4].isEmpty()?0:quotarray[4].trim())+"',"
				       + "RTYPE='"+(quotarray[5].trim().equalsIgnoreCase("undefined") || quotarray[5].trim().equalsIgnoreCase("NaN")||quotarray[5].trim().equalsIgnoreCase("")|| quotarray[5].isEmpty()?0:quotarray[5].trim())+"',"
				       + "FRMDATE='"+(quotarray[6].trim().equalsIgnoreCase("undefined") || quotarray[6].trim().equalsIgnoreCase("NaN")||quotarray[6].trim().equalsIgnoreCase("")|| quotarray[6].isEmpty()?0:ClsCommon.changeStringtoSqlDate(quotarray[6].trim()))+"',"
				       + "TODATE='"+(quotarray[7].trim().equalsIgnoreCase("undefined") || quotarray[7].trim().equalsIgnoreCase("NaN")||quotarray[7].trim().equalsIgnoreCase("")|| quotarray[7].isEmpty()?0:ClsCommon.changeStringtoSqlDate(quotarray[7].trim()))+"',"
				       + "UNIT='"+(quotarray[8].trim().equalsIgnoreCase("undefined") || quotarray[8].trim().equalsIgnoreCase("NaN")||quotarray[8].trim().equalsIgnoreCase("")|| quotarray[8].isEmpty()?0:quotarray[8].trim())+"',"
				       + "GRPID='"+(quotarray[9].trim().equalsIgnoreCase("undefined") || quotarray[9].trim().equalsIgnoreCase("NaN")||quotarray[9].trim().equalsIgnoreCase("")|| quotarray[9].isEmpty()?0:quotarray[9].trim())+"' where RDOCNO="+docno+"";
				      
		            // System.out.println("--------"+sql);
				     int resultSet2 = stmtquatation.executeUpdate (sql);
				 	if (resultSet2 <= 0) {
						
						conn.close();
						
						return false;
					}
				     
			     }
			} 
			     for(int i=0;i< qtarifarray.size();i++){
				    	
				     String[] tariff=qtarifarray.get(i).split("::");
				     if(!(tariff[1].trim().equalsIgnoreCase("undefined")|| tariff[1].trim().equalsIgnoreCase("NaN")||tariff[1].trim().equalsIgnoreCase("")|| tariff[1].isEmpty()))
				     {
				    	
				    
				     String sql="update gl_quotd set  rentaltype='"+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].isEmpty()?0:tariff[0].trim())+"',"
				    		 + "tariff='"+(tariff[1].trim().equalsIgnoreCase("undefined") || tariff[1].trim().equalsIgnoreCase("")|| tariff[1].trim().equalsIgnoreCase("NaN") || tariff[1].isEmpty()?0:tariff[1].trim())+"',"
				    		 + "cdw='"+(tariff[2].trim().equalsIgnoreCase("undefined") || tariff[2].trim().equalsIgnoreCase("")|| tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+"',"
				    		 + "pai='"+(tariff[3].trim().equalsIgnoreCase("undefined") || tariff[3].trim().equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+"',"
				    		 + "cdw1='"+(tariff[4].trim().equalsIgnoreCase("undefined") || tariff[4].trim().equalsIgnoreCase("") || tariff[4].trim().equalsIgnoreCase("NaN")|| tariff[4].isEmpty()?0:tariff[4].trim())+"',"
				    		 + "pai1='"+(tariff[5].trim().equalsIgnoreCase("undefined") || tariff[5].trim().equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+"',"
				    		 + "gps='"+(tariff[6].trim().equalsIgnoreCase("undefined") || tariff[6].trim().equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+"',"
				    		 + "babyseater='"+(tariff[7].trim().equalsIgnoreCase("undefined") || tariff[7].trim().equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+"',"
				    		 + "cooler='"+(tariff[8].trim().equalsIgnoreCase("undefined") || tariff[8].trim().equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+"',"
				    		 + "kmrest='"+(tariff[9].trim().equalsIgnoreCase("undefined") || tariff[9].trim().equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+"',"
				    		 + "exkmrte='"+(tariff[10].trim().equalsIgnoreCase("undefined") || tariff[10].trim().equalsIgnoreCase("")|| tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+"',"
				    		 + "oinschg='"+(tariff[11].trim().equalsIgnoreCase("undefined") || tariff[11].trim().equalsIgnoreCase("")|| tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+"',"
				    		 + "exhrchg='"+(tariff[12].trim().equalsIgnoreCase("undefined") || tariff[12].trim().equalsIgnoreCase("")|| tariff[12].trim().equalsIgnoreCase("NaN")|| tariff[12].isEmpty()?0:tariff[12].trim())+"',"
				    		 + "grpid='"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"
				    		 + "srno='"+(i+1)+"' where rdocno="+docno+"";
				     
				     int resultSet3= stmtquatation.executeUpdate (sql);
 	                 if (resultSet3 <= 0) {
						
						conn.close();
						
						return false;
					}
				     }
			     }
			     
			 	for(int i=0;i< descarray.size();i++){
			    	
				     String[] desarray=descarray.get(i).split("::");
				     if(!(desarray[1].trim().equalsIgnoreCase("undefined")|| desarray[1].trim().equalsIgnoreCase("NaN")||desarray[1].trim().equalsIgnoreCase("")|| desarray[1].isEmpty()))
				     {
				
			    		  String sql="update gl_quotc set  srno="+(i+1)+","
			    				  + "desid='"+(desarray[1].trim().equalsIgnoreCase("undefined") || desarray[1].trim().equalsIgnoreCase("NaN")|| desarray[1].trim().equalsIgnoreCase("")|| desarray[1].isEmpty()?0:desarray[1].trim())+"',"
			    				  + "descplus='"+(desarray[2].trim().equalsIgnoreCase("undefined") || desarray[2].trim().equalsIgnoreCase("NaN")|| desarray[2].trim().equalsIgnoreCase("")|| desarray[2].isEmpty()?0:desarray[2].trim())+"',"
			    				  + "brhid='"+session.getAttribute("BRANCHID").toString()+"'  where rdocno="+docno+"";
			    // System.out.println("---------"+sql);
					     int resultSet3 = stmtquatation.executeUpdate (sql);
					    
					     
				     }
				} 

			 	  
			if (editval > 0) {
				conn.commit();
				stmtquatation.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
			
*/
	public int delete(int docno,HttpSession session,String mode,String formcode,String refno,String reftype) throws SQLException {
		try{
			
			conn=connDAO.getMyConnection();
			
			Statement stmtdel = conn.createStatement ();
			if(reftype.equalsIgnoreCase("CEQ"))
			{
				
			String sql="SELECT clstatus FROM gl_quotm where doc_no='"+docno+"'";
			
			
			ResultSet resultSet = stmtdel.executeQuery (sql);
			if (resultSet.next()) {
				 int data = (resultSet.getInt("clstatus"));
				 if(data>3)
				 {
					 stmtdel.close();
					conn.close(); 
					return -1;
				 }
				}
		     }
			
			CallableStatement stmtquatation = conn.prepareCall("{call quotationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtquatation.setDate(1,null);
			stmtquatation.setString(2,null);
			stmtquatation.setString(3,null);
			stmtquatation.setString(4,null);
			stmtquatation.setString(5,null);
			stmtquatation.setString(6,null);
			stmtquatation.setString(7,reftype);
			stmtquatation.setString(8,refno);
			stmtquatation.setString(9,null);
		    stmtquatation.setString(10,session.getAttribute("USERID").toString());
			stmtquatation.setString(11,session.getAttribute("BRANCHID").toString());
			stmtquatation.setString(12,formcode.trim());
			stmtquatation.setInt(13,docno);
			stmtquatation.setString(14,"D");
			stmtquatation.setString(15,"0");
			int aaa=stmtquatation.executeUpdate();
			if(aaa>0)
			{
				Statement stmtup = conn.createStatement ();
				if(reftype.equalsIgnoreCase("CEQ"))
				{
					
				String sqls="update gl_enqm set clstatus=0 where DOC_NO='"+refno+"'";
			    stmtup.executeUpdate(sqls);
			    stmtup.close();
				}
				else
				{
					
				}
				
				
			}
			
			
			
			
			if (aaa > 0) {
				
				stmtquatation.close();
				conn.close();
				System.out.println("Sucess");
				return docno;
			}	
		}catch(Exception e){
			conn.close();
		}
		return 0;
	}
	 public   ClsquotationBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsquotationBean bean = new ClsquotationBean();
		  Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select q.voc_no,coalesce(q.glterms,'') glterms,m.sal_name salname,m.mob_no mob,q.DOC_NO,DATE_FORMAT(q.DATE,'%d-%m-%Y') DATE , q.REF_NO, "
						+ "if(q.REF_TYPE='DIR','Direct',concat('Enquiry ','(',q.REF_NO,')')) type,q.CONTACT_NO mob ,if(q.REF_TYPE='DIR',a.refname,e.name) name, "
						+ "if(q.REF_TYPE='DIR',a.address,e.com_add1) com_add1,if(q.REF_TYPE='DIR',a.per_mob,e.mob) mob,if(q.REF_TYPE='DIR',a.mail1,e.email) email from "
						+ "   gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no   left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a  "
						+ "on a.cldocno=q.cldocno and a.dtype='CRM' left join my_salm m on m.doc_no=a.sal_id   where q.DOC_NO="+docno+" ");
				System.out.println(resql);
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   if(!(pintrs.getString("glterms").equalsIgnoreCase("")) && (!(pintrs.getString("glterms").equalsIgnoreCase("NA"))))
			    	   {
			    		   bean.setGeneralterms(pintrs.getString("glterms"));
			    		   
			    		   bean.setTerms1("General Terms And Conditions" );
			    		   
			    	   }
			    	   
			    	   
			    	   bean.setLblsalclient(pintrs.getString("salname"));
			    	   bean.setLblsalmob(pintrs.getString("mob"));
			    	    bean.setLblclient(pintrs.getString("name"));
			    	    bean.setLblclientaddress(pintrs.getString("com_add1"));
			    	    bean.setLblmob(pintrs.getString("mob"));
			    	    bean.setLblemail(pintrs.getString("email"));
			    	    //upper
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLbltypep(pintrs.getString("type"));
			    	    bean.setDocvals(pintrs.getInt("voc_no"));
			    	    
			    	    
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmtinvoice10 = conn.createStatement ();
		/*		    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_quotm r  "
				    		+ " left join my_brch b on r.BRANCH=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
			/*	    String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_quotm r inner join "
				    		+ "    my_brch b on r.BRANCH=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join "
				    		+ "	    (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo) as lc on(lc.loc=l.loc) where  r.doc_no="+docno+"  ";*/
				  String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_quotm r inner join my_brch b on  "
				    		+ "r.branch=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
				    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
                      //System.out.println("--------"+companysql);

			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   bean.setLblcstno(resultsetcompany.getString("cstno"));
					    	  
				    		  bean.setLblservicetax(resultsetcompany.getString("stcno"));
				    		  bean.setLblpan(resultsetcompany.getString("pbno"));
				    	   
				       } 
				       stmtinvoice10.close();
				       ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();
					
					/*	
						String strSqldetail="select if(qt.tariff=0,' ',round(qt.tariff,2)) rate ,coalesce(y.yom,'') yom,eq.sr_no,eq.brdid,eq.modid,eq.spec ,eq.clrid,round(eq.unit) unit,DATEDIFF(eq.todate,eq.frmdate) AS days, "
								+ " eq.rtype ,eq.grpid,vb.brand_name brand,vm.vtype model, "
								+ "vc.color color,vg.gname gname FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
								+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID left join my_color vc on vc.doc_no=eq.clrid "
								+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid left join gl_yom y on y.doc_no=eq.yom"
								+ " left join gl_quotd qt on (qt.rdocno=eq.rdocno and qt.rentaltype=eq.rtype)   where  eq.rdocno='"+docno+"' group by eq.sr_no ";
						*/
						String strSqldetail="select if(qt.tariff=0,' ',round(qt.tariff*eq.unit,2)) rate ,if(qt.cdw=0,' ',round(qt.cdw*eq.unit,2)) "+
						" cdw ,if(qt.pai=0,' ',round(qt.pai*eq.unit,2)) pai , if(qt.gps=0,' ',round(qt.gps*eq.unit,2)) gps ,if(qt.babyseater=0,' ',"+
						" round(qt.babyseater*eq.unit,2)) babyseater ,(round(qt.tariff*eq.unit,2)+round(qt.cdw*eq.unit,2)+round(qt.pai*eq.unit,2)+"+
						" round(qt.gps*eq.unit,2)+round(qt.babyseater*eq.unit,2))*(round(eq.unit)) total,coalesce(y.yom,'') yom,eq.sr_no,eq.brdid,eq.modid,eq.clrid,"+
						" round(eq.unit) unit,eq.rtype ,eq.grpid,vb.brand_name brand,vm.vtype model,vc.color color,vg.gname gname"+
						" FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID left join gl_vehmodel vm on vm.doc_no=eq.MODID "+
						" left join my_color vc on vc.doc_no=eq.clrid left join gl_vehgroup vg on vg.doc_no=eq.grpid left join gl_yom y on "+
						" y.doc_no=eq.yom left join gl_quotd qt on (qt.rdocno=eq.rdocno and qt.srno=eq.sr_no) where eq.rdocno="+docno+""+
						" group by eq.sr_no";
//				System.out.println("--------------"+strSqldetail);
			
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						
							String temp="";
							String spci="";
							 bean.setFirstarray(1); 
					/*		if(rsdetail.getString("spec").equalsIgnoreCase("0"))
							{
								spci="";
							}
							else
							{
								spci=rsdetail.getString("spec");
							}*/
						/*temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("days")+"::"+rsdetail.getString("gname") ;*/
							temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("cdw")+"::"+rsdetail.getString("pai")+"::"+rsdetail.getString("gps")+"::"+rsdetail.getString("babyseater")+"::"+rsdetail.getString("gname")+"::"+rsdetail.getString("total");
		
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 
					
					
				       ArrayList<String> descarr=new ArrayList<String>();
								Statement stmtinvoice11 = conn.createStatement ();
							
								
								String stsql="select  concat(c.srno,' .  ',m.description,' ',' ',if(c.descplus='0','',c.descplus)) descplus from gl_quotc c "
										+ " left join gl_qcond m on c.desid=m.doc_no where m.status=3 and c.rdocno='"+docno+"' order by c.rowno";
								
						//	System.out.println("--------------"+strSqldetail);
					
							ResultSet rsdetails=stmtinvoice11.executeQuery(stsql);
							
						String temp1="";
					String ss="";
							while(rsdetails.next()){
								 bean.setTerms2("Special Notes" );
								
								temp1=ss+"::"+rsdetails.getString("descplus") ;
				
								descarr.add(temp1);
								
							
								
						              }
							stmtinvoice2.close();  
							request.setAttribute("desc",descarr); 
					
					
					
					/*ArrayList<String> tariffarr=new ArrayList<String>();
					Statement stmtinvoice3 = conn.createStatement ();
				
					String strSqldetail1="select if(vg.gname='0',' ',vg.gname) group1,if(qt.rentaltype='0',' ',qt.rentaltype) rentaltype,if(qt.tariff=0,' ',round(qt.tariff,2)) rate  "
							+ ",if(qt.cdw=0,' ',round(qt.cdw,2)) cdw,if(qt.pai=0,' ',round(qt.pai,2)) pai,if(qt.cdw1=0,' ',round(qt.cdw1,2)) cdw1, "
							+ "if(qt.pai1=0,' ',round(qt.pai1,2)) pai1,if(qt.gps=0,' ',round(qt.gps,2)) gps,"
							+ "if(qt.babyseater=0,' ',round(qt.babyseater,2)) babyseater,if(qt.cooler=0,' ',round(qt.cooler,2)) cooler,"
							+ "if(qt.kmrest=0,' ',round(qt.kmrest)) kmrest,if(qt.exkmrte=0,' ',round(qt.exkmrte,2)) exkmrte,"
							+ "if(qt.oinschg=0,' ',round(qt.oinschg,2)) oinschg,if(qt.exhrchg=0,' ',round(qt.exhrchg,2)) exhrchg "
							+ "from gl_quotd qt left join gl_vehgroup vg on vg.doc_no=qt.grpid  where qt.rdocno="+docno+" ";
		//		System.out.println("---------"+strSqldetail1);
		
				ResultSet rsdetail1=stmtinvoice3.executeQuery(strSqldetail1);
				
				int rowcounts=1;
		
				while(rsdetail1.next()){
	
						String temp="";
					     
						 bean.setSecarray(2);  
						temp=rowcounts+"::"+rsdetail1.getString("group1")+"::"+rsdetail1.getString("rentaltype")+"::"+rsdetail1.getString("rate")
						+"::"+rsdetail1.getString("cdw")+"::"+rsdetail1.getString("cdw1")
						+"::"+rsdetail1.getString("gps")+"::"+rsdetail1.getString("babyseater")+"::"+rsdetail1.getString("cooler")+"::"+rsdetail1.getString("kmrest")
						+"::"+rsdetail1.getString("exkmrte")+"::"+rsdetail1.getString("oinschg")+"::"+rsdetail1.getString("exhrchg");
	
						tariffarr.add(temp);
						rowcounts++;
		
				
					
			              }
				stmtinvoice3.close();  
				request.setAttribute("tariffdetails",tariffarr); */
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	 }
	
	public   JSONArray descsaverelode(String qutdocno3) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
		    /*Enumeration<String> Enumeration = session.getAttributeNames();
		    int a=0;
		    while(Enumeration.hasMoreElements()){
		     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
		      a=1;
		     }
		    }
		    if(a==0){
		  return RESULTDATA;
		     }*/
		 Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("SELECT dc.srno,dc.desid,dc.descplus,cd.description from gl_quotc dc left join gl_qcond cd  on cd.doc_no=dc.desid where rdocno='"+qutdocno3+"' ");
				//System.out.println("--------------"+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println("fgdg"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public   JSONArray tarifsaverelode(String qutdocno1) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
		    /*Enumeration<String> Enumeration = session.getAttributeNames();
		    int a=0;
		    while(Enumeration.hasMoreElements()){
		     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
		      a=1;
		     }
		    }
		    if(a==0){
		  return RESULTDATA;
		     }*/
		 Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select qt.tdocno,qt.grpid,qt.rentaltype,qt.tariff rate,qt.cdw,qt.pai,qt.cdw1,qt.pai1,qt.gps,qt.babyseater,qt.cooler, "
						+ "qt.kmrest,qt.exkmrte,qt.oinschg,qt.exhrchg,vg.gname group1"
						+ " from gl_quotd qt left join gl_vehgroup vg on vg.doc_no=qt.grpid  where rdocno='"+qutdocno1+"' ");
				//System.out.println("resql"+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println("fgdg"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public   JSONArray enqsaverelode(String qutdocno) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
		    /*Enumeration<String> Enumeration = session.getAttributeNames();
		    int a=0;
		    while(Enumeration.hasMoreElements()){
		     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
		      a=1;
		     }
		    }
		    if(a==0){
		  return RESULTDATA;
		     }*/
		 Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select y.doc_no yomid,y.yom,eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.unit,eq.frmdate fromdate,eq.todate,DATE_FORMAT(frmdate,'%d.%m.%Y') AS "
						+ "hidfromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS hidtodate,eq.rtype renttype,eq.grpid,vb.brand_name brand,vm.vtype model,vc.color color,vg.gname gname "
						+ "FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
						+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID "
						+ "left join my_color vc on vc.doc_no=eq.clrid "
						+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid "
						+ " left join gl_yom y on y.doc_no=eq.yom "
					    + "  where eq.rdocno='"+qutdocno+"' ");
			//	System.out.println("------resql------"+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println("fgdg"+RESULTDATA);
	    return RESULTDATA;
	}
	

	public   JSONArray enqsearchrelode(String docno) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	   
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
	        	
				String resql=("select eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.unit,eq.frmdate fromdate,eq.todate,DATE_FORMAT(frmdate,'%d.%m.%Y') AS"
						+ "    hidfromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS hidtodate,eq.rtype renttype,vb.brand_name brand,vm.vtype model,vc.color color"
						+ "    FROM gl_enqd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID"
						+ "    left join gl_vehmodel vm on vm.doc_no=eq.MODID"
						+ "     left join my_color vc on vc.doc_no=eq.clrid  where eq.rdocno='"+docno+"' ");
				
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println("fgdg"+RESULTDATA);
	    return RESULTDATA;
	}
public   JSONArray searchColor() throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();
        	
			ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color color1  from my_color where status<>7 order by  doc_no;");

			RESULTDATA=commDAO.convertToJSON(resultSet);
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
public   JSONArray searchGroup(String brandid,String modelis) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();
        	
			String sql= ("Select v.doc_no,trim(g.gname) gname,g.doc_no from gl_vehmaster v "
					+ "left join gl_vehgroup g on g.doc_no=v.vgrpid where v.brdid='"+brandid+"' and v.vmodid='"+modelis+"' group by g.doc_no  ;");
			//System.out.println("-----------"+sql);
			 ResultSet resultSet = stmtVehclr.executeQuery(sql);
			 

			
			RESULTDATA=commDAO.convertToJSON(resultSet);
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
public   JSONArray tariffRate(HttpSession session,String groupname) throws SQLException {


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
  	        
       String brch=session.getAttribute("BRANCHID").toString();
       Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh6 = conn.createStatement ();
    
           	
				String tasql= ("select m1.doc_no tdocno,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg,"
						+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype,(select count(*) from gl_tlistm  where status=1) count from gl_tarifm m inner join gl_tarifd m1 on m.doc_no=m1.doc_no right join "
						+ "gl_tlistm m2 on m1.renttype=m2.rentaltype where m1.gid='"+groupname+"'  and   m.doc_no=(select MAX(M.doc_no) from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no where "
						+ "current_date between M.validfrm and M.validto AND m1.gid='"+groupname+"'and m.status<>7) and m1.branch="+brch+" and m2.Status=1 order by m2.doc_no;");
				
			//	System.out.println("++++++"+tasql);
				
				ResultSet resultSet = stmtVeh6.executeQuery(tasql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh6.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println("================="+RESULTDATA);
       return RESULTDATA;
   }
public   JSONArray tariffType() throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVeh2 = conn.createStatement ();
        	
			ResultSet resultSet = stmtVeh2.executeQuery ("select rentaltype  from gl_tlistm  where status=1 order by doc_no;");

			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmtVeh2.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}

public   List<ClsquotationBean> list4() throws SQLException {
    List<ClsquotationBean> list1Bean = new ArrayList<ClsquotationBean>();
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmt6 = conn.createStatement ();
			
		
			String tasql= ("select rentaltype from gl_tlistm where status=1;");
			//System.out.println("----------"+tasql);
			ResultSet resultSet5 = stmt6.executeQuery(tasql);
			while (resultSet5.next()) {
				
				ClsquotationBean bean = new ClsquotationBean();
				 
				bean.setRentaltype(resultSet5.getString("rentaltype"));
				
			
			
				
            	list1Bean.add(bean);
        	//System.out.println(list1Bean);
			}
			stmt6.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return list1Bean;
}




	public   JSONArray searchBrand() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

				RESULTDATA=commDAO.convertToJSON(resultSet);
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
	
	public   JSONArray searchYOM() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select doc_no,yom from gl_yom;");

				RESULTDATA=commDAO.convertToJSON(resultSet);
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
	
	
	public   JSONArray searchModel(String brandval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh3 = conn.createStatement ();
            	
				String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid="+brandval+" and status<>7;");
				
				//System.out.println("========"+modelsql);
				
				ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh3.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public   JSONArray descSearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh3 = conn.createStatement ();
            	
				String modelsql1= ("select doc_no,description from gl_qcond where status=3");
				
			//System.out.println("========"+modelsql1);
				
				ResultSet resultSet = stmtVeh3.executeQuery(modelsql1)  ;
				RESULTDATA=commDAO.convertToJSON(resultSet);
				//System.out.println(RESULTDATA);
				stmtVeh3.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	/*public  JSONArray descSearch() throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtdesc = conn.createStatement ();
	        	
				String desc= ("select doc_no,description from gl_qcond where status=3;");
				System.out.println("================"+desc);
				ResultSet resultSet = stmtdesc.executeQuery(desc);
				
				RESULTDATA=commDAO.convertToJSON(resultSet);
				System.out.println(RESULTDATA);
				stmtdesc.close();
				conn.close();
			
				
				  return RESULTDATA;
				  
				  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		  return RESULTDATA;
	}*/
		
	    public   JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {


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
	   	        
	    	    	
	   	 String brid=session.getAttribute("BRANCHID").toString();
	    	
	    	
	    	    	
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and refname like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and per_mob like '%"+mob+"%'";
	    	}
	    	
	        
	    	Connection conn = null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql= ("select cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=commDAO.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	 
	    public   JSONArray enqsearchMaster(HttpSession session,String msdocno,String clnames,String enqdate) throws SQLException {


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
		    	if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		    	{
		    	sqlStartDate = commDAO.changeStringtoSqlDate(enqdate);
		    	}
		    	
		    	
		    	String sqltest="";
		    	if(!(msdocno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and voc_no like '%"+msdocno+"%'";
		    	}
		    	if(!(clnames.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and name like '%"+clnames+"%'";
		    	}
		    	
		    	 if(!(sqlStartDate==null)){
		    		sqltest=sqltest+" and date='"+sqlStartDate+"'";
		    	} 
		        
		    	
		    	 	    	
		    	 Connection conn = null;
		 
				try {
						conn = connDAO.getMyConnection();
						Statement stmtenq1 = conn.createStatement ();
		            	
						String clssql= ("select voc_no,doc_no,date,remarks,cldocno,name,com_add1,mob,email,enqtype from gl_enqm where status<>7 and clstatus<3 and brhid="+brid+" " +sqltest);
					
						ResultSet resultSet = stmtenq1.executeQuery(clssql);
						
						RESULTDATA=commDAO.convertToJSON(resultSet);
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
	   
	    public   JSONArray searchMaster(HttpSession session,String qutdocno,String clientname,String clmob,String qutdate,String quttype) throws SQLException {


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
		    	if(!(qutdate.equalsIgnoreCase("undefined"))&&!(qutdate.equalsIgnoreCase(""))&&!(qutdate.equalsIgnoreCase("0")))
		    	{
		    	sqlStartDate = commDAO.changeStringtoSqlDate(qutdate);
		    	}
		    	
		    
		    	String sqltest="";
		    	if(!(qutdocno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and m.voc_no like '%"+qutdocno+"%'";
		    	}
		    	if(!(clientname.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and  if(m.cldocno!=0,a.refname like '%"+clientname+"%',e.name like '%"+clientname+"%'  )";                                           
		    	}
		    	if(!(clmob.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and m.contact_no like '%"+clmob+"%'";
		    	}
		    	
		    	if(!(quttype.equalsIgnoreCase(""))){
		    		
		    		sqltest=sqltest+" and m.REF_TYPE like '%"+quttype+"%'";
		    	}
		    	 if(!(sqlStartDate==null)){
		    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		    	} 
		        
		    	
		    	 	    	
		    	 Connection conn = null;
		 
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtenq1 = conn.createStatement ();
						String clssql= ("select e.voc_no enqrefno,m.voc_no,coalesce(m.glterms,'') glterms,m.DOC_NO,m.DATE,m.cldocno,m.REF_NO,m.REF_TYPE,m.ATTN_TO,m.contact_no ,"
								+ "m.REMARKS,m.NETTOTAL,m.userid,m.email,if(m.cldocno!=0,a.refname,e.name) refname , "
								+ "if(m.cldocno!=0,a.address ,e.com_add1) address from gl_quotm m left join "
								+ "my_acbook a on a.cldocno=m.cldocno and dtype='CRM'  "
								+ "left join gl_enqm e on e.doc_no=m.ref_no where m.status=3 and m.branch="+brid+" " +sqltest);
						/*String clssql= ("select m.DOC_NO,m.DATE,m.cldocno,m.REF_NO,m.REF_TYPE,m.ATTN_TO,m.contact_no ,m.REMARKS,m.NETTOTAL,m.userid,m.email, "
								+ "a.refname ,a.address from gl_quotm m left join my_acbook a on a.cldocno=m.cldocno and dtype='CRM' where m.status<>7 and m.branch="+brid+" " +sqltest);*/
					
						ResultSet resultSet = stmtenq1.executeQuery(clssql);
						
						RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtenq1.close();
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
	    
	    public   ClsquotationBean getPrintPDF(int docno, HttpServletRequest request) throws SQLException {
			 ClsquotationBean bean = new ClsquotationBean();
			  Connection conn = null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtprint = conn.createStatement ();
		        	
					String resql=("select q.voc_no,coalesce(q.glterms,'') glterms, q.DOC_NO,DATE_FORMAT(q.DATE,'%d-%m-%Y') DATE , q.REF_NO, "
							+ "if(q.REF_TYPE='DIR','Direct',concat('Enquiry ','(',q.REF_NO,')')) type,q.CONTACT_NO mob ,if(q.REF_TYPE='DIR',a.refname,e.name) name, "
							+ "if(q.REF_TYPE='DIR',a.address,e.com_add1) com_add1,if(q.REF_TYPE='DIR',a.per_mob,e.mob) mob,if(q.REF_TYPE='DIR',a.mail1,e.email) email from "
							+ "   gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no   left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a  "
							+ "on a.cldocno=q.cldocno and a.dtype='CRM'   where q.DOC_NO="+docno+" ");
					
					ResultSet pintrs = stmtprint.executeQuery(resql);
					
				     
				       while(pintrs.next()){
				    	   // cldatails
				    	   
				    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
				    	   if(!(pintrs.getString("glterms").equalsIgnoreCase("")) && (!(pintrs.getString("glterms").equalsIgnoreCase("NA"))))
				    	   {
				    		   bean.setGeneralterms(pintrs.getString("glterms"));
				    		   
				    		   bean.setTerms1("General Terms And Conditions" );
				    		   
				    	   }
				    	   
				    	   
				    	   
				    	    bean.setLblclient(pintrs.getString("name"));
				    	    bean.setLblclientaddress(pintrs.getString("com_add1"));
				    	    bean.setLblmob(pintrs.getString("mob"));
				    	    bean.setLblemail(pintrs.getString("email"));
				    	    //upper
				    	    bean.setLbldate(pintrs.getString("date"));
				    	    bean.setLbltypep(pintrs.getString("type"));
				    	    bean.setDocvals(pintrs.getInt("voc_no"));
				    	    
				    	    
				       }
					

					stmtprint.close();
					
					
					
					 Statement stmtinvoice10 = conn.createStatement ();
			/*		    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_quotm r  "
					    		+ " left join my_brch b on r.BRANCH=b.doc_no left join my_locm l on l.brhid=b.doc_no "
					    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
				/*	    String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_quotm r inner join "
					    		+ "    my_brch b on r.BRANCH=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join "
					    		+ "	    (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo) as lc on(lc.loc=l.loc) where  r.doc_no="+docno+"  ";*/
					  String  companysql="select coalesce(c.company,'') company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno from gl_quotm r inner join my_brch b on  "
					    		+ "r.branch=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
					    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
	                      //System.out.println("--------"+companysql);

				         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
					       
					       while(resultsetcompany.next()){
					    	   
					    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
					    	   bean.setLblcompname(resultsetcompany.getString("company"));
					    	  
					    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
					    	 
					    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
					    	  
					    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
					    	   bean.setLbllocation(resultsetcompany.getString("location"));
					    	  
					    	   bean.setLblcstno(resultsetcompany.getString("cstno"));
					    	   bean.setLbltinno(resultsetcompany.getString("tinno"));
					    		  bean.setLblservicetax(resultsetcompany.getString("stcno"));
					    		  bean.setLblpan(resultsetcompany.getString("pbno"));
					    	   
					       } 
					       stmtinvoice10.close();
					       ArrayList<String> arr=new ArrayList<String>();
							Statement stmtinvoice2 = conn.createStatement ();
						
							
							String strSqldetail="select if(qt.tariff=0,' ',round(qt.tariff,2)) rate ,coalesce(y.yom,'') yom,eq.sr_no,eq.brdid,eq.modid,eq.spec ,eq.clrid,round(eq.unit) unit,DATEDIFF(eq.todate,eq.frmdate) AS days, "
									+ " eq.rtype ,eq.grpid,vb.brand_name brand,vm.vtype model, "
									+ "vc.color color,vg.gname gname FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
									+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID left join my_color vc on vc.doc_no=eq.clrid "
									+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid left join gl_yom y on y.doc_no=eq.yom"
									+ " left join gl_quotd qt on (qt.rdocno=eq.rdocno and qt.rentaltype=eq.rtype)   where  eq.rdocno='"+docno+"' group by eq.sr_no ";
							
					//	System.out.println("--------------"+strSqldetail);
				
						ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
						
						int rowcount=1;
				
						while(rsdetail.next()){
							
								String temp="";
								String spci="";
								 bean.setFirstarray(1); 
								if(rsdetail.getString("spec").equalsIgnoreCase("0"))
								{
									spci="";
								}
								else
								{
									spci=rsdetail.getString("spec");
								}
							temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("days")+"::"+rsdetail.getString("gname") ;
			
								arr.add(temp);
								rowcount++;
				
						
							
					              }
						stmtinvoice2.close();  
						request.setAttribute("details",arr); 
						
						
					       ArrayList<String> descarr=new ArrayList<String>();
									Statement stmtinvoice11 = conn.createStatement ();
								
									
									String stsql="select  concat(c.srno,' .  ',m.description,' ',' ',if(c.descplus='0','',c.descplus)) descplus from gl_quotc c "
											+ " left join gl_qcond m on c.desid=m.doc_no where m.status=3 and c.rdocno='"+docno+"' order by c.rowno";
									
							//	System.out.println("--------------"+strSqldetail);
						
								ResultSet rsdetails=stmtinvoice11.executeQuery(stsql);
								
							String temp1="";
						String ss="";
								while(rsdetails.next()){
									 bean.setTerms2("Terms And Conditions" );
									
									temp1=ss+"::"+rsdetails.getString("descplus") ;
					
									descarr.add(temp1);
									
								
									
							              }
								stmtinvoice2.close();  
								request.setAttribute("desc",descarr); 
						
						
						
						/*ArrayList<String> tariffarr=new ArrayList<String>();
						Statement stmtinvoice3 = conn.createStatement ();
					
						String strSqldetail1="select if(vg.gname='0',' ',vg.gname) group1,if(qt.rentaltype='0',' ',qt.rentaltype) rentaltype,if(qt.tariff=0,' ',round(qt.tariff,2)) rate  "
								+ ",if(qt.cdw=0,' ',round(qt.cdw,2)) cdw,if(qt.pai=0,' ',round(qt.pai,2)) pai,if(qt.cdw1=0,' ',round(qt.cdw1,2)) cdw1, "
								+ "if(qt.pai1=0,' ',round(qt.pai1,2)) pai1,if(qt.gps=0,' ',round(qt.gps,2)) gps,"
								+ "if(qt.babyseater=0,' ',round(qt.babyseater,2)) babyseater,if(qt.cooler=0,' ',round(qt.cooler,2)) cooler,"
								+ "if(qt.kmrest=0,' ',round(qt.kmrest)) kmrest,if(qt.exkmrte=0,' ',round(qt.exkmrte,2)) exkmrte,"
								+ "if(qt.oinschg=0,' ',round(qt.oinschg,2)) oinschg,if(qt.exhrchg=0,' ',round(qt.exhrchg,2)) exhrchg "
								+ "from gl_quotd qt left join gl_vehgroup vg on vg.doc_no=qt.grpid  where qt.rdocno="+docno+" ";
			//		System.out.println("---------"+strSqldetail1);
			
					ResultSet rsdetail1=stmtinvoice3.executeQuery(strSqldetail1);
					
					int rowcounts=1;
			
					while(rsdetail1.next()){
		
							String temp="";
						     
							 bean.setSecarray(2);  
							temp=rowcounts+"::"+rsdetail1.getString("group1")+"::"+rsdetail1.getString("rentaltype")+"::"+rsdetail1.getString("rate")
							+"::"+rsdetail1.getString("cdw")+"::"+rsdetail1.getString("cdw1")
							+"::"+rsdetail1.getString("gps")+"::"+rsdetail1.getString("babyseater")+"::"+rsdetail1.getString("cooler")+"::"+rsdetail1.getString("kmrest")
							+"::"+rsdetail1.getString("exkmrte")+"::"+rsdetail1.getString("oinschg")+"::"+rsdetail1.getString("exhrchg");
		
							tariffarr.add(temp);
							rowcounts++;
			
					
						
				              }
					stmtinvoice3.close();  
					request.setAttribute("tariffdetails",tariffarr); */
					conn.close();



					
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
			return bean;
			
		
		 }
	    
	    public   HashMap gridArray(int docno, HttpServletRequest request) throws SQLException {
			 ClsquotationBean bean = new ClsquotationBean();
			  Connection conn = null;
			  ArrayList<String> arr=null;
			  ArrayList<String> arradd=new ArrayList<String>();
			  
			  HashMap map=new HashMap();
			try {
					 conn = connDAO.getMyConnection();
						
							Statement stmtinvoice2 = conn.createStatement ();
						
							
							String strSqldetail="select if(qt.tariff=0,' ',coalesce(round(qt.tariff,2),0.0)) rate ,coalesce(y.yom,'') yom,eq.sr_no,eq.brdid,eq.modid,coalesce(eq.spec,'') spec ,eq.clrid,round(eq.unit) unit,DATEDIFF(eq.todate,eq.frmdate) AS days, "
									+ " eq.rtype ,eq.grpid,vb.brand_name brand,vm.vtype model, "
									+ "coalesce(vc.color,'') color,coalesce(vg.gname,'') gname FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
									+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID left join my_color vc on vc.doc_no=eq.clrid "
									+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid left join gl_yom y on y.doc_no=eq.yom"
									+ " left join gl_quotd qt on (qt.rdocno=eq.rdocno and qt.rentaltype=eq.rtype)   where  eq.rdocno='"+docno+"' group by eq.sr_no ";
							
//						System.out.println("------strSqldetailstrSqldetail--------"+strSqldetail);
				
						ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
						
						int rowcount=1;
				
						while(rsdetail.next()){
							arr=new ArrayList<String>();
								String temp="";
								String spci="";
								 bean.setFirstarray(1); 
								if(rsdetail.getString("spec").equalsIgnoreCase("0"))
								{
									spci="";
								}
								else
								{
									spci=rsdetail.getString("spec");
								}
							//temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("days")+"::"+rsdetail.getString("gname") ;
								
								arr.add(rowcount+"");
								arr.add(rsdetail.getString("brand"));
								arr.add(rsdetail.getString("model"));
								arr.add(spci);
								arr.add(rsdetail.getString("yom"));
								arr.add(rsdetail.getString("color"));
								arr.add(rsdetail.getString("rtype"));
								arr.add(rsdetail.getString("rate"));
								arr.add(rsdetail.getString("unit"));
								arr.add(rsdetail.getString("days"));
								arr.add(rsdetail.getString("gname"));
								//arr.add(temp);
								//arr.add(temp);
								map.put(rowcount, arr);
								rowcount++;
				
//								System.out.println("===temp=====111===="+temp);
								//arradd.addAll(arr);
							
					              }
						

					conn.close();


//	System.out.println("fghjklkjhgfdghjkjhgfgbhj"+map.size());
					
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
			return map;
			
		
		 }
		 
		 
		 
		 public   ArrayList descArray(int docno, HttpServletRequest request) throws SQLException {
			 ClsquotationBean bean = new ClsquotationBean();
			  Connection conn = null;
			  ArrayList<String> descarr=null;
			try {
					 conn = connDAO.getMyConnection();
						
									
					        descarr=new ArrayList<String>();
									Statement stmtinvoice11 = conn.createStatement ();
								
									
									String stsql="select  concat(c.srno,' .  ',m.description,' ',' ',if(c.descplus='0','',c.descplus)) descplus from gl_quotc c "
											+ " left join gl_qcond m on c.desid=m.doc_no where m.status=3 and c.rdocno='"+docno+"' order by c.rowno";
									
							//	System.out.println("--------------"+strSqldetail);
						
								ResultSet rsdetails=stmtinvoice11.executeQuery(stsql);
								

								while(rsdetails.next()){
									
						
									
									descarr.add(rsdetails.getString("descplus")) ;
									
									
							              }  
		
					conn.close();

					
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
			return descarr;
			
		
		 }
		 
		 
			public   int getCompChk() throws SQLException {

		        
		        
		        Connection conn = null;
		        int isindian=0;
	        	
				try {
						 conn = connDAO.getMyConnection();
						Statement stmt1 = conn.createStatement ();
						HttpServletRequest request=ServletActionContext.getRequest();
						HttpSession session=request.getSession();
		            	
		           
						String strSql1 = "select method from gl_config where field_nme='indian'";

						ResultSet rs1 = stmt1.executeQuery(strSql1);
						while(rs1.next ()) {
							isindian=rs1.getInt("method");
						}
					

	                  
						
				   	 stmt1.close();
						conn.close();

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return isindian;
		    }	
			
			
public   String getFileName(String formcode) throws SQLException {

		        
		        
		        Connection conn = null;
		        String path="";
	        	String fileName ="";
	        	String filepath="";
				try {
						 conn = connDAO.getMyConnection();
						Statement stmt1 = conn.createStatement ();
						HttpServletRequest request=ServletActionContext.getRequest();
						HttpSession session=request.getSession();
		            	
		            /*	Calendar now = GregorianCalendar.getInstance();
		       		 
		        		SimpleDateFormat df = new SimpleDateFormat("HH");
		        		String formattedDate = df.format(new Date())*/;
		        		
		        		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		        		java.util.Date date = new java.util.Date();
//		        		System.out.println(dateFormat.format(date)); //2014/08/06 15:59:48
		        		
		        		
		        		 //String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";
		            	
		        		String currdate=dateFormat.format(date);
		        		
//		        		System.out.println("===currdate======"+currdate);
		        		
						String strSql1 = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");

						ResultSet rs1 = stmt1.executeQuery(strSql1);
						while(rs1.next ()) {
							path=rs1.getString("imgPath");
						}
						
						 fileName = formcode+"["+request.getParameter("docno")+"]"+currdate+".pdf";
						
						 filepath=path+ "/attachment/"+formcode+"/"+fileName;
						 
//				    	ServletContext context = request.getServletContext();
				    	File dir = new File(path+ "/attachment/"+formcode);
				   	 	dir.mkdirs();

	                  
						
				   	 stmt1.close();
						conn.close();

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return filepath;
		    }		 



}

