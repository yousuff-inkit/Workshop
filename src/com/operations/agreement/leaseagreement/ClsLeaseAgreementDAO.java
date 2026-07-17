package com.operations.agreement.leaseagreement;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.operations.agreement.rentalagreement.ClsRentalAgreementBean;
import com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsDAO;



public class ClsLeaseAgreementDAO {
	ClsLeaseAgreementBean LeaseAgreementBean = new ClsLeaseAgreementBean();
	ClsRentalReceiptsDAO rentalReceiptsDAO= new ClsRentalReceiptsDAO();
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon CommonDAO=new  ClsCommon();
	
	Connection conn;
int headdoc; // for payment receipt create
	

    String plusval="" ; 
	public int insert(Date sqlleaseDate,int clientId,int  salesmanid,String Desc,String clcodeno,String clacno,
			int addrvchk,String adddrvcharges,int chfchk,int chaufferid,int chkdlvry,String tempfleet,String perfleet,
			String fleetname,String dateout,String timeout,String kmout,String fuelout,String delDateout,String delTimeout,String delKmout,
			String delFuelout,String m1,String m2,String m3,String m4,String m5,String m6,String m7,String m8,String m9,String m10,
			String amt1,String amt2,String amt3,String amt4,String amt5,
			ArrayList<String> driverarray,ArrayList<String> lagmttariffarray,ArrayList<String> paymentarray,String mode,HttpSession session,String formcode,
			int per_name,int per_value,int advance_chk,int invoice, String Vehlocationid,String fromcode,
			String clientname,HttpServletRequest request,ArrayList<String> vehdetarray,String exinsu,int prodoc,String po) throws SQLException {


		try{
			
	
			
			int docno=0;
	
			
			  ArrayList<String> tercllist= new ArrayList<>();
			  
			  tercllist.add((m1.trim().equalsIgnoreCase("")?"0":m1)+":"+(m2.trim().equalsIgnoreCase("")?"0":m2)+":"+(amt1.trim().equalsIgnoreCase("")?"0":amt1));
			  tercllist.add((m3.trim().equalsIgnoreCase("")?"0":m3)+":"+(m4.trim().equalsIgnoreCase("")?"0":m4)+":"+(amt2.trim().equalsIgnoreCase("")?"0":amt2));
			  tercllist.add((m5.trim().equalsIgnoreCase("")?"0":m5)+":"+(m6.trim().equalsIgnoreCase("")?"0":m6)+":"+(amt3.trim().equalsIgnoreCase("")?"0":amt3));
			  tercllist.add((m7.trim().equalsIgnoreCase("")?"0":m7)+":"+(m8.trim().equalsIgnoreCase("")?"0":m8)+":"+(amt4.trim().equalsIgnoreCase("")?"0":amt4));
			  tercllist.add((m9.trim().equalsIgnoreCase("")?"0":m9)+":"+(m10.trim().equalsIgnoreCase("")?"0":m10)+":"+(amt5.trim().equalsIgnoreCase("")?"0":amt5));
			  
			  /*tercllist.add(m1+":"+m2+":"+amt1);
			  tercllist.add(m3+":"+m4+":"+amt2);
			  tercllist.add(m5+":"+m6+":"+amt3);
			  tercllist.add(m7+":"+m8+":"+amt4);
			  tercllist.add(m9+":"+m10+":"+amt5);*/
			  
			 	
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
CallableStatement stmtleaseagmt = conn.prepareCall("{CALL leaseAgmtDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
       


       stmtleaseagmt.registerOutParameter(17, java.sql.Types.INTEGER);
       stmtleaseagmt.registerOutParameter(24, java.sql.Types.INTEGER);
       
      // main
      stmtleaseagmt.setDate(1,sqlleaseDate);
      stmtleaseagmt.setInt(2,clientId);
       stmtleaseagmt.setInt(3,salesmanid);
      stmtleaseagmt.setString(4, Desc);
      stmtleaseagmt.setString(5,clcodeno);
      stmtleaseagmt.setString(6,clacno);
      stmtleaseagmt.setInt(7,addrvchk);
      stmtleaseagmt.setString(8,adddrvcharges=="null"?"0":adddrvcharges);
      stmtleaseagmt.setInt(9,chfchk);
      stmtleaseagmt.setInt(10,chaufferid);
      stmtleaseagmt.setInt(11,chkdlvry);
     /* stmtleaseagmt.setString(12,tempfleet=="null"?"0":tempfleet);
      stmtleaseagmt.setString(13,perfleet==""?"0":perfleet);
      stmtleaseagmt.setString(14,fleetname);
      stmtleaseagmt.setDate(15,sqldateout);
      stmtleaseagmt.setString(16,timeout);
      stmtleaseagmt.setString(17,kmout);
      stmtleaseagmt.setString(18,fuelout);
      stmtleaseagmt.setDate(19,sqldelDateout);
      stmtleaseagmt.setString(20,delTimeout);
      stmtleaseagmt.setString(21,delKmout);
      stmtleaseagmt.setString(22,delFuelout);*/
      stmtleaseagmt.setString(12,session.getAttribute("COMPANYID").toString().trim());
      stmtleaseagmt.setString(13,session.getAttribute("BRANCHID").toString().trim());
      stmtleaseagmt.setString(14,session.getAttribute("USERID").toString().trim());
      stmtleaseagmt.setString(15,session.getAttribute("CURRENCYID").toString().trim());
      
      stmtleaseagmt.setString(16,mode);
      stmtleaseagmt.setInt(18, per_value);
      stmtleaseagmt.setInt(19, per_name);
      stmtleaseagmt.setInt(20, advance_chk);
      stmtleaseagmt.setInt(21, invoice);
      stmtleaseagmt.setString(22, fromcode);
      stmtleaseagmt.setString(23, exinsu=="null"?"0":exinsu);
      
      
      stmtleaseagmt.setInt(25, prodoc);
      stmtleaseagmt.setString(26, po);
      
/*      stmtleaseagmt.setString(33,Vehlocationid);*/
    //  System.out.println("-------"+stmtleaseagmt);
      stmtleaseagmt.executeQuery();
	    docno=stmtleaseagmt.getInt("docNo");
	    int vocno=stmtleaseagmt.getInt("vocNo");
	    request.setAttribute("vocno", vocno);
	if(docno<=0)
	{
		conn.close();
		return 0;
	}	     
			
		     for(int i=0;i< lagmttariffarray.size();i++){
		    	
		     String[] tariff=((String) lagmttariffarray.get(i)).split("::");
		    
		  //   System.out.println("dasfghjk======="+lagmttariffarray.get(i));
		     String sql="INSERT INTO gl_ltarif(rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,chaufchg,chaufexchg,rstatus,brhid,rdocno)VALUES"
		       + " ('"+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].trim().equalsIgnoreCase("NaN")|| tariff[0].isEmpty()?0:tariff[0].trim())+"',"
		       + "'"+(tariff[1].trim().equalsIgnoreCase("undefined")  || tariff[1].trim().equalsIgnoreCase("") || tariff[1].trim().equalsIgnoreCase("NaN")|| tariff[1].isEmpty()?0:tariff[1].trim())+"',"
		       + "'"+(tariff[2].trim().equalsIgnoreCase("undefined") || tariff[2].trim().equalsIgnoreCase("") || tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+"',"
		       + "'"+(tariff[3].trim().equalsIgnoreCase("undefined") || tariff[3].trim().equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+"',"
		       + "'"+(tariff[4].trim().equalsIgnoreCase("undefined") || tariff[4].trim().equalsIgnoreCase("")|| tariff[4].trim().equalsIgnoreCase("NaN") || tariff[4].isEmpty()?0:tariff[4].trim())+"',"
		       + "'"+(tariff[5].trim().equalsIgnoreCase("undefined") || tariff[5].trim().equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+"',"
		       + "'"+(tariff[6].trim().equalsIgnoreCase("undefined") || tariff[6].trim().equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+"',"
		       + "'"+(tariff[7].trim().equalsIgnoreCase("undefined") || tariff[7].trim().equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+"',"
		       + "'"+(tariff[8].trim().equalsIgnoreCase("undefined") || tariff[8].trim().equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+"',"
		       + "'"+(tariff[9].trim().equalsIgnoreCase("undefined") || tariff[9].trim().equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+"',"
		       + "'"+(tariff[10].trim().equalsIgnoreCase("undefined") || tariff[10].trim().equalsIgnoreCase("")|| tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+"',"
		       + "'"+(tariff[11].trim().equalsIgnoreCase("undefined") || tariff[11].trim().equalsIgnoreCase("")|| tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+"',"
		       + "'"+(tariff[12].trim().equalsIgnoreCase("undefined") || tariff[12].trim().equalsIgnoreCase("")|| tariff[12].trim().equalsIgnoreCase("NaN")|| tariff[12].isEmpty()?0:tariff[12].trim())+"',"
		       /* + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"*/
		       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"')";
		     int resultSet1 = stmtleaseagmt.executeUpdate (sql);
		     if(resultSet1<=0)
			    {
		    		conn.close();
		    	 return 0;
			    }
		     
		     }
		   
		     
		     ArrayList<String> blankarray= new ArrayList<String>();
		    
		    for(int i=0;i< paymentarray.size();i++){
		    	
		    	 String[] payment=((String) paymentarray.get(i)).split("::");
			     
			     if(!(payment[1].trim().equalsIgnoreCase("undefined")||payment[1].trim().equalsIgnoreCase("")|| payment[1].trim().equalsIgnoreCase("NaN")|| payment[1].isEmpty()))
			     {
			    	
		   // String paytype="'"+ payment[1].trim()+"'";
		    String cardtype=""+(payment[7].trim().equalsIgnoreCase("undefined") ||payment[7].trim().equalsIgnoreCase("")|| payment[7].trim().equalsIgnoreCase("NaN")|| payment[7].isEmpty()?0:payment[7].trim())+"";
            String paidas=""+(payment[10].trim().equalsIgnoreCase("undefined") ||payment[10].trim().equalsIgnoreCase("")|| payment[10].trim().equalsIgnoreCase("NaN")|| payment[10].isEmpty()?0:payment[10].trim())+"";
		 
            String Amt= ""+(payment[2].trim().equalsIgnoreCase("undefined") || payment[2].trim().equalsIgnoreCase("")|| payment[2].trim().equalsIgnoreCase("NaN")|| payment[2].isEmpty()?0:payment[2].trim())+"";
           
            String paytypeid=""+(payment[8].trim().equalsIgnoreCase("undefined") ||payment[8].trim().equalsIgnoreCase("")|| payment[8].trim().equalsIgnoreCase("NaN")|| payment[8].isEmpty()?0:payment[8].trim())+"";
            
            String refdoc=""+(payment[4].trim().equalsIgnoreCase("undefined") ||payment[4].trim().equalsIgnoreCase("")|| payment[4].trim().equalsIgnoreCase("NaN")|| payment[4].isEmpty()?0:payment[4].trim())+"";
            
            int cldoc = clientId;
		     
		     int claccount=Integer.parseInt(clacno);
		     
		   
		     String aggno=""+docno;
            double Amount=Double.parseDouble(Amt);
            
            int srno=0;
            String type="";
				            if(!(paidas.equalsIgnoreCase("3")))
				            
				            {
				             
				            // String type=paytypeid.equalsIgnoreCase("1")?"rcash":"rcard";
				            
				           /*  if(!paytypeid.equalsIgnoreCase("3"))
				             {
				            	
				              type=paytypeid.equalsIgnoreCase("1")?"rcash":"rcard";
				             }
				             else
				             {
				            	 type="ronline"; 
				             }
				             
				             
				             
				             String selectsql="select t.doc_no,t.account,t.description from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where codeno='"+type+"'";
				             
							 ResultSet resSet = stmtleaseagmt.executeQuery(selectsql);
							     if (resSet.next()) {
							    	 headdoc = resSet.getInt("doc_no");
							                        }
							     String payid="";
							     String advorsec="";
							     if((paidas.equalsIgnoreCase("1")))
							     {
							    	 payid="2"; 
							    	 advorsec="Advance"; 
							    	 
							     }
							     else
							     {
							    	 payid="3"; 
							    	 advorsec="Security";
							     }
							   	*/
				             	String selectsql="select acno from my_cardm where doc_no='"+paytypeid+"' and dtype='mode' ";
				                
				      			 ResultSet resSet = stmtleaseagmt.executeQuery(selectsql);
				      			     if (resSet.next()) {
				      			    	 headdoc = resSet.getInt("acno");
				      			                      }	
				   			     
				                String payid="";
				                String advorsec="";
				   			     if((paidas.equalsIgnoreCase("1")))
				   			     {
				   			    	 payid="2"; 
				   			    	 advorsec="Advance";
				   			    	 
				   			    	 
				   			     }
				   			     else
				   			     {
				   			    	 payid="3"; 
				   			    	 advorsec="Security";
				   			     }
				               	
				               	
				               	
							    // System.out.println("---------------"+refdoc.trim());
							     
						     int valre=rentalReceiptsDAO.insert(conn,sqlleaseDate,"RRV",paytypeid,headdoc,cardtype,refdoc.trim(),sqlleaseDate,"LA"+" "+vocno+" "+advorsec,0,"0",cldoc,claccount,"LAG",aggno,payid,Amount,0.00,0.00,0.00,
						    		 Amount,"LA"+" "+vocno+" "+advorsec,clientname,0.00,blankarray,session,request);
						     
						     
						      srno=(int) request.getAttribute("isrno");
						    if(valre<=0)	{
						    	
						    	 conn.close();
						    	 return 0; 
						    	
						                  }
				                  }
						    
		     
		/*     for(int i=0;i< paymentarray.size();i++){
		    //	System.out.println("paymentarray===i===="+i);
			     String[] payment=((String) paymentarray.get(i)).split("::");*/
			/*     if(!(payment[1].trim().equalsIgnoreCase("undefined")||payment[1].trim().equalsIgnoreCase("")|| payment[1].isEmpty()))
			     {
			    	 */
			    	 
			    	 String sql="INSERT INTO gl_lpyt(payment,mode,amount,acode,cardno,expdate,card,cardtype,paytype,payid,brhid,rdocno,recieptno)VALUES"
						       + " ('"+(payment[0].equalsIgnoreCase("undefined") || payment[0].isEmpty()?0:payment[0])+"',"
						       + "'"+(payment[1].trim().equalsIgnoreCase("undefined") || payment[1].trim().equalsIgnoreCase("")|| payment[1].trim().equalsIgnoreCase("NaN")|| payment[1].isEmpty()?0:payment[1].trim())+"',"
						       + "'"+(payment[2].trim().equalsIgnoreCase("undefined") || payment[2].trim().equalsIgnoreCase("")|| payment[2].trim().equalsIgnoreCase("NaN")|| payment[2].isEmpty()?0:payment[2].trim())+"',"
						       + "'"+(payment[3].trim().equalsIgnoreCase("undefined") ||payment[3].trim().equalsIgnoreCase("")|| payment[3].trim().equalsIgnoreCase("NaN")|| payment[3].isEmpty()?0:payment[3].trim())+"',"
						       + "'"+(payment[4].trim().equalsIgnoreCase("undefined") ||payment[4].trim().equalsIgnoreCase("")|| payment[4].trim().equalsIgnoreCase("NaN")|| payment[4].isEmpty()?0:payment[4].trim())+"',"
						       + "'"+(payment[5].trim().equalsIgnoreCase("undefined") ||payment[5].trim().equalsIgnoreCase("")|| payment[5].trim().equalsIgnoreCase("NaN")|| payment[5].isEmpty()?"":payment[5].trim())+"',"
						        + "'"+(payment[6].trim().equalsIgnoreCase("undefined") ||payment[6].trim().equalsIgnoreCase("")|| payment[6].trim().equalsIgnoreCase("NaN")|| payment[6].isEmpty()?"":payment[6].trim())+"',"
						         + "'"+(payment[7].trim().equalsIgnoreCase("undefined") ||payment[7].trim().equalsIgnoreCase("")|| payment[7].trim().equalsIgnoreCase("NaN")|| payment[7].isEmpty()?0:payment[7].trim())+"',"
						          + "'"+(payment[8].trim().equalsIgnoreCase("undefined") ||payment[8].trim().equalsIgnoreCase("")|| payment[8].trim().equalsIgnoreCase("NaN")|| payment[8].isEmpty()?0:payment[8].trim())+"',"
						       + "'"+(payment[10].trim().equalsIgnoreCase("undefined") ||payment[10].trim().equalsIgnoreCase("")|| payment[10].trim().equalsIgnoreCase("NaN")|| payment[10].isEmpty()?0:payment[10].trim())+"',"
						       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+srno+"')";
						     int resultSet2 = stmtleaseagmt.executeUpdate (sql);
						     
		  
				     if(resultSet2<=0)
				     {
				    	 conn.close();
				    	 return 0; 
				     }
			     }
				     
				     }
		     
		     for(int i=0;i< tercllist.size() ;i++){
				  String[] terclarray=((String) tercllist.get(i)).split(":");
				// System.out.println("------1-------"+terclarray[2].trim());
				  if(!(terclarray[2].trim().equalsIgnoreCase("undefined")||terclarray[2].trim().equalsIgnoreCase("")|| terclarray[2].isEmpty() ||  terclarray[2].trim().equalsIgnoreCase("NaN") ||  terclarray[2].trim().equalsIgnoreCase("0") ))
				     {
				  
							
							   String tclsql="";
							   tclsql="INSERT INTO gl_ltermcl(rdocno,mnthfrm,mnthto,amt) values('"+docno+"',"
							  +"'"+(terclarray[0].equalsIgnoreCase("undefined")||terclarray[0]==null || terclarray[0].equalsIgnoreCase("") || terclarray[0].trim().equalsIgnoreCase("NaN")|| terclarray[0].isEmpty()?0:terclarray[0].trim())+"',"
							  + "'"+(terclarray[1].trim().equalsIgnoreCase("undefined")||terclarray[1]==null  || terclarray[1].trim().equalsIgnoreCase("") || terclarray[1].trim().equalsIgnoreCase("NaN")|| terclarray[1].isEmpty()?0:terclarray[1].trim())+"',"
							  +"'"+(terclarray[2].equalsIgnoreCase("undefined")||terclarray[2]==null || terclarray[2].equalsIgnoreCase("") || terclarray[2].trim().equalsIgnoreCase("NaN")|| terclarray[2].isEmpty()?0:terclarray[2].trim())+"')";
							// System.out.println("==tclsql===+"+tclsql);
							  
							int resultSettcl = stmtleaseagmt.executeUpdate (tclsql);
							 if(resultSettcl<=0)
						     {
							  conn.close();
						    	 return 0; 
						     }
				     }	  
				 
				  }
		    
		 	if(chfchk!=1)
		 	{
		     for(int i=0;i< driverarray.size();i++){
			     String[] driver=((String) driverarray.get(i)).split("::");
			    // System.out.println("driver"+driver);
			     if(!(driver[0].trim().equalsIgnoreCase("undefined")||driver[0].trim().equalsIgnoreCase("")|| driver[0].isEmpty()))
			     {
		     String sql="INSERT INTO gl_ldriver(drid,brhid,rdocno,cldocno)VALUES"
				       + " ('"+(driver[0].trim().equalsIgnoreCase("undefined") ||driver[0].trim().equalsIgnoreCase("")|| driver[0].isEmpty()?0:driver[0].trim())+"',"
				       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+clientId+"' )";
		     
		  //System.out.println("sql============"+sql);
		     
				     int resultSet3 = stmtleaseagmt.executeUpdate (sql);
				     if(resultSet3<=0)
				     {
				    	  conn.close();
				    	 return 0; 
				     }
			     }
				     }
		 	}
		 	
		 	
		 	for(int i=0;i< vehdetarray.size();i++){
		    	
			     String[] vehdetailsarray=vehdetarray.get(i).split("::");
			     if(!(vehdetailsarray[0].trim().equalsIgnoreCase("undefined")|| vehdetailsarray[0].trim().equalsIgnoreCase("NaN")||vehdetailsarray[0].trim().equalsIgnoreCase("")|| vehdetailsarray[0].isEmpty()))
			     {
			    	/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
		     String sql="INSERT INTO gl_lothser(rowno,name,amount,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(vehdetailsarray[0].trim().equalsIgnoreCase("undefined") || vehdetailsarray[0].trim().equalsIgnoreCase("NaN")|| vehdetailsarray[0].trim().equalsIgnoreCase("")|| vehdetailsarray[0].isEmpty()?0:vehdetailsarray[0].trim())+"',"
				       + "'"+(vehdetailsarray[1].trim().equalsIgnoreCase("undefined") || vehdetailsarray[1].trim().equalsIgnoreCase("NaN")|| vehdetailsarray[1].trim().equalsIgnoreCase("")|| vehdetailsarray[1].isEmpty()?0:vehdetailsarray[1].trim())+"',"
				       +"'"+docno+"')";
		   
				     int re10 = stmtleaseagmt.executeUpdate (sql);
				     if(re10<=0)
				 	{
				 		 conn.close();
				 		return 0;
				 	}	
				     
			     }
				    
		    	}
		     
				if (docno > 0) {
					conn.commit();
					stmtleaseagmt.close();
					conn.close();
		          return docno;
			}
				else{
				
				}
			
		
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		return 0;
	}

	public boolean update(int docno,Date sqlleaseDate, int chkdelivery,
			String tempfleet, String permanentfleet, Date sqlDateout,
			String timeout, String kmout, String cmbfuelout,
			 String vehlocation, String mode,
			HttpSession session,int invoice,ArrayList<String> paymentarray,String delcharge,int drvid,int clientid) throws SQLException {

		try{
	
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtUpdaterent = conn.prepareCall("{CALL leaseUpdateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtUpdaterent.setDate(1,sqlleaseDate);
			stmtUpdaterent.setInt(2, chkdelivery);
			stmtUpdaterent.setString(3,tempfleet);
			stmtUpdaterent.setString(4,permanentfleet);
			stmtUpdaterent.setDate(5,sqlDateout);
			stmtUpdaterent.setString(6,timeout);
			stmtUpdaterent.setString(7,kmout.trim());
			stmtUpdaterent.setString(8,session.getAttribute("BRANCHID").toString());
		    stmtUpdaterent.setString(9,cmbfuelout);
		    stmtUpdaterent.setInt(10,docno);
		   	stmtUpdaterent.setString(11,vehlocation);
		    stmtUpdaterent.setInt(12,invoice);
			stmtUpdaterent.setString(13,delcharge=="null"?"0":delcharge);
			stmtUpdaterent.setInt(14,drvid);
			stmtUpdaterent.setInt(15,clientid);
			
			stmtUpdaterent.setString(16,"ADD");
		   	
	
			
		  //	System.out.println("------------"+stmtUpdaterent);
			int aa=stmtUpdaterent.executeUpdate();
			 docno=stmtUpdaterent.getInt("docNo");
			 
			 if(aa<=0)
			 {
				 
				 conn.close(); 
				 return false;
			 }
			 
			  
			    for(int i=0;i< paymentarray.size();i++){
			    	
			    	
			    	String[] payment=((String) paymentarray.get(i)).split("::");
				     
				     if(!(payment[1].trim().equalsIgnoreCase("undefined")||payment[1].trim().equalsIgnoreCase("")|| payment[1].trim().equalsIgnoreCase("NaN")|| payment[1].isEmpty()))
				     {
	            if(i==2)
		            
	            {
	            	//String paidas=""+(payment[10].trim().equalsIgnoreCase("undefined") ||payment[10].trim().equalsIgnoreCase("")|| payment[10].trim().equalsIgnoreCase("NaN")|| payment[10].isEmpty()?0:payment[10].trim())+""; 
		    	 
		    	 String dateval="select round(value) plusval from gl_config where field_nme='ccrelDate'";
	             
	           
				 ResultSet resSet = stmtUpdaterent.executeQuery(dateval);
				     if (resSet.next()) {
				    	 plusval = resSet.getString("plusval").trim();
				               }
				     
	
				     
				     
				     
		   String upsql="update gl_lpyt set reldate=(select DATE_ADD('"+sqlDateout+"', interval '"+plusval+"' day )) where rdocno="+docno+" and payid=3";
		   
		  //System.out.println("----------"+upsql);
		   int upval = stmtUpdaterent.executeUpdate (upsql);
		   
						   if(upval<=0)
						   {
							   conn.close();
						    	 return false; 
						   }
	            }
				     
				     
				     }
			    }
			 
			if (aa > 0) {
				conn.commit();
				stmtUpdaterent.close();
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

	public boolean delupdate(int docno, Date sqlleaseDate,
			String tempfleet, String permanentfleet, Date sqldelDateout,
			String deltimeout, String delkmout, String cmbdelfuelout,
			String vehlocation, String mode,int cientid, HttpSession session) throws SQLException {

		try{
			conn=connDAO.getMyConnection();
			// conn.setAutoCommit(false);
			CallableStatement stmtUpdaterent = conn.prepareCall("{CALL leasedelupdateDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtUpdaterent.setDate(1,sqlleaseDate);
			stmtUpdaterent.setString(2,tempfleet);
			stmtUpdaterent.setString(3,permanentfleet);
			stmtUpdaterent.setDate(4,sqldelDateout);
			stmtUpdaterent.setString(5,deltimeout);
			stmtUpdaterent.setString(6,delkmout.trim());
			stmtUpdaterent.setString(7,session.getAttribute("BRANCHID").toString());
		    stmtUpdaterent.setString(8,cmbdelfuelout);
		    stmtUpdaterent.setInt(9,docno);
		   	stmtUpdaterent.setString(10,vehlocation);
		    stmtUpdaterent.setInt(11,cientid);
			stmtUpdaterent.setString(12,"DLY");
		  	//System.out.println("------------"+stmtUpdaterent);
			/*System.out.println("----------"+stmtUpdaterent);*/
			int aa=stmtUpdaterent.executeUpdate();
			 docno=stmtUpdaterent.getInt("docNo");
			if (aa > 0) {
				//conn.commit();
				stmtUpdaterent.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		
		}catch(Exception e){
			
			conn.close();
			e.printStackTrace();
		}
		return false;
	}

	
	
/*
   public  List<ClsLeaseAgreementBean> list7() throws SQLException {
        List<ClsLeaseAgreementBean> list1Bean = new ArrayList<ClsLeaseAgreementBean>();
        Connection conn=null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt2 = conn.createStatement ();
				
				//String brid=session.getAttribute("BRANCHID").toString();
			
				ResultSet resultSet1 = stmt2.executeQuery ("select sal_code,doc_no,sal_name from my_salesman where sal_type='DRV' and status<>7;");

				while (resultSet1.next()) {
					
					ClsLeaseAgreementBean bean = new ClsLeaseAgreementBean();
					bean.setSal_docno(resultSet1.getString("doc_no"));
					bean.setChau_id(resultSet1.getString("sal_code"));
					bean.setChau_name(resultSet1.getString("sal_name"));
					
				
				
					
	            	list1Bean.add(bean);
            	//System.out.println(list1Bean);
				}
				stmt2.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return list1Bean;
    }
*/
   
   
 public  JSONArray reloadDriver(HttpSession session,String txtleasedocno) throws SQLException {

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
	        Connection conn=null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	            	
					//ResultSet resultSet = stmtVeh.executeQuery("SELECT d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1,(select value from gl_config where field_nme='drage') drage1,(select value from gl_config where field_nme='licyr') licyr1 FROM gl_drdetails d  join gl_config left join gl_ldriver r  on d.doc_no=r.drid where r.rdocno='"+txtleasedocno+"' and brhid="+brid+" group by d.doc_no;");
		     String drsql=("SELECT d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM gl_drdetails d  left join gl_ldriver r  on d.dr_id=r.drid where r.rdocno='"+txtleasedocno+"' and r.status=3 ");

					
					ResultSet resultSet = stmtVeh.executeQuery(drsql);
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
 public  JSONArray clientDriver(String clientid) throws SQLException {

	 JSONArray RESULTDATA=new JSONArray();
	   
	 Connection conn=null;
	      
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	            	
					//ResultSet resultSet = stmtVeh.executeQuery("SELECT d.dr_id,d.doc_no,d.name,d.dob,d.nation,d.mobno,d.dlno,d.issdate,d.led,d.ltype,d.issfrm,d.passport_no,d.pass_exp,d.visano,d.visa_exp,d.hcdlno,d.hcissdate,d.hcled ,d.cldocno,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear,(select value from gl_config where field_nme='drage') drage ,(select value from gl_config where field_nme='licyr') licyr FROM gl_drdetails d,gl_config   WHERE d.cldocno='"+clientid+"' group by d.doc_no;");
					ResultSet resultSet = stmtVeh.executeQuery("SELECT d.dr_id,d.doc_no,d.name,d.dob,d.nation,d.mobno,d.dlno,d.issdate,d.led,d.ltype,d.issfrm,d.passport_no,d.pass_exp,d.visano,d.visa_exp,d.hcdlno,d.hcissdate,d.hcled ,d.cldocno,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear,(select value from gl_config where field_nme='drage') drage ,(select value from gl_config where field_nme='licyr') licyr FROM gl_drdetails d  WHERE d.cldocno='"+clientid+"' and d.dtype='CRM' ;");
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
	    
	    
	    
	   
	    public  JSONArray reloadpayment(HttpSession session,String txtrentaldocno1) throws SQLException {

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
	        Connection conn=null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	String pySql=("select rdocno, payment, mode, amount, acode, cardno, expdate, recieptno, brhid, payid, doc_no, card, paytype, cardtype from gl_lpyt where rdocno='"+txtrentaldocno1+"'  ");
	            	//System.out.println("========"+pySql);
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);

					RESULTDATA=CommonDAO.convertToJSON(resultSet); 
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
	    public  JSONArray tariffType() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn=null;
	       
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh2 = conn.createStatement ();
	            	
					ResultSet resultSet = stmtVeh2.executeQuery ("select rentaltype  from gl_tlistm where status=1 order by doc_no");

					RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
	    public  JSONArray tariffRate(HttpSession session,String ratariffdocno,String groupname) throws SQLException {


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
	        Connection conn=null;
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh6 = conn.createStatement ();
	           
	            	
					ResultSet resultSet = stmtVeh6.executeQuery ("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg, "
							+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  "
							+ "right join gl_tlistm m2 on m1.renttype=m2.rentaltype  where m1.gid='"+groupname+"'  and   m.doc_no='"+ratariffdocno+"' and m1.branch="+brch+" and m2.status=1 order by m2.doc_no");

					RESULTDATA=CommonDAO.convertToJSON(resultSet);
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
	    
	    public  JSONArray tariffratereload(HttpSession session,String docno) throws SQLException {

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
	 
	        String brnch=session.getAttribute("BRANCHID").toString();
	        Connection conn=null;
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh5 = conn.createStatement ();
	            	
					String  tarifsql=("select rdocno,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,chaufchg,chaufexchg from gl_ltarif where rdocno='"+docno+"'  order by rstatus");
					//System.out.println("------------------------------"+tarifsql);
					
					ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
					stmtVeh5.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    public  JSONArray otherincomedivrelode(String docno) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();


		    Connection conn=null;


	  
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh5 = conn.createStatement ();
	            	
					String  tarifsql=("select name,amount price from gl_lothser where rdocno='"+docno+"' ");
					//System.out.println("------------------------------"+tarifsql);
					
					ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
					stmtVeh5.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	    
	    public   JSONArray mainSrearch(HttpSession session,String sclname,String smob,String rno,String flno,String sregno,String branch_chk) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	    	    	
	   
	   	
	    	String sqltest="";
	    	
	    	if(!(sclname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+sclname+"%'";
	    	}
	    	if(!(smob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob like '%"+smob+"%'";
	    	}
	    	if(!(rno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and l.voc_no like '%"+rno+"%'";
	    	}
	    	if(!(flno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
	    	}
	    	if(!(sregno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and v.reg_no like '%"+sregno+"%'";
	    	}
	    	
	    	 
	    	 Connection conn=null;  
	     
			try {
					 conn = connDAO.getMyConnection();
					 if(branch_chk.equalsIgnoreCase("1"))  // WIB with in branch, WOB with out branch
			    	 {
					 
					 
					 
					Statement stmt = conn.createStatement ();
					String Sql=("select 'WOB' checks,l.doc_no,l.voc_no,l.acno,CONVERT(if(if(l.perfleet=0,l.tmpfleet,l.perfleet)=0,'',if(l.perfleet=0,l.tmpfleet,l.perfleet)),char(30)) fleet_no,l.cldocno,l.date,l.salid,l.delivery, "
							+ "l.chif,l.drid,l.addr,l.outkm,l.outdate,l.outtime,l.outfuel, "
							+ "l.deldate,l.deltime,l.addrchg,a.RefName,a.per_mob,if(v.reg_no!='',v.reg_no,'')  reg_no from gl_lagmt l left join gl_vehmaster v on "
							+ " v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' "
							+ " left join my_salm m on a.sal_id=m.doc_no left join gl_ltarif t on t.rdocno=l.doc_no where   "
							+ " l.status=3    " +sqltest+" group by l.doc_no");
								
		// System.out.println("------Sql-----"+Sql);
					ResultSet resultSet = stmt.executeQuery (Sql); 
					
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
					stmt.close();
					
			    	 }
					 
					 else
					 {
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
					   	  String brnchid=session.getAttribute("BRANCHID").toString();
						 
							Statement stmt = conn.createStatement ();
							
							String Sql=("select 'WIB' checks,l.doc_no,l.voc_no,l.acno,CONVERT(if(if(l.perfleet=0,l.tmpfleet,l.perfleet)=0,'',if(l.perfleet=0,l.tmpfleet,l.perfleet)),char(30)) fleet_no,l.cldocno,l.date,l.salid,l.delivery, "
									+ "l.chif,l.drid,l.addr,l.outkm,l.outdate,l.outtime,l.outfuel, "
									+ "l.deldate,l.deltime,l.addrchg,a.RefName,a.per_mob,if(v.reg_no!='',v.reg_no,'')  reg_no from gl_lagmt l left join gl_vehmaster v on "
									+ " v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' "
									+ " left join my_salm m on a.sal_id=m.doc_no left join gl_ltarif t on t.rdocno=l.doc_no where   "
									+ " l.status=3 and l.brhid='"+brnchid+"'  " +sqltest+" group by l.doc_no");
							// System.out.println("------Sql-----"+Sql);			
			 
							ResultSet resultSet = stmt.executeQuery (Sql); 
							
							RESULTDATA=CommonDAO.convertToJSON(resultSet);
							stmt.close(); 
						 
					 }
					
					
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
    
   
	    public   JSONArray clientSearch(HttpSession session,String clname,String mob,String lcno,String passno,String nation,String dob) throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	   /* Enumeration<String> Enumeration = session.getAttributeNames();
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
	     	*/
	    	
	    
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    	 dob.trim();
	    	if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = CommonDAO.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and (a.per_mob like '%"+mob+"%' or d.mobno like '%"+mob+"%')";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno like '%"+lcno+"%'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no like '%"+passno+"%'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like '%"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	        
	    	 Connection conn =null;
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh8 = conn.createStatement ();
	            	
				/*	String clsql= ("select distinct a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ " join gl_drdetails d on d.cldocno=a.cldocno where a.dtype='CRM' and a.brhid="+brid+"" +sqltest);*/
			/*		String clsql= ("select distinct a.pcase,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ "left join gl_drdetails d on d.cldocno=a.cldocno where a.dtype='CRM' and a.status=3 " +sqltest);*/
					
					String clsql= ("select distinct d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ "left join gl_drdetails d on d.cldocno=a.cldocno and d.dtype=a.dtype where a.dtype='CRM' and a.status=3 " +sqltest);
					
					
					ResultSet resultSet = stmtVeh8.executeQuery(clsql);
					
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
					stmtVeh8.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    public   JSONArray vehSearch(HttpSession session,String fleetno,String regno,String flname,String color,String group,String aa) throws SQLException {


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
		     	
		  
		    		
		    
		    	
	    	String sqltest="";
		    	
		    	if((!(fleetno.equalsIgnoreCase(""))) && (!(fleetno.equalsIgnoreCase("NA")))){
		    		sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
		    	}
		    	if((!(regno.equalsIgnoreCase(""))) && (!(regno.equalsIgnoreCase("NA")))){
		    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'  ";
		    	}
		    	if((!(flname.equalsIgnoreCase(""))) && (!(flname.equalsIgnoreCase("NA")))){
		    		sqltest=sqltest+" and v.FLNAME like '%"+flname+"%'";
		    	}
		    	if((!(color.equalsIgnoreCase(""))) && (!(color.equalsIgnoreCase("NA")))){
		    		sqltest=sqltest+" and c.color like '%"+color+"%'";
		    	}
		    	if((!(group.equalsIgnoreCase(""))) && (!(group.equalsIgnoreCase("NA")))){
		    		sqltest=sqltest+" and g.gname like '%"+group+"%'";
		    	}
		   
		    	 Connection conn =null;
				try {
					
					conn = connDAO.getMyConnection();
					if(aa.equalsIgnoreCase("yes"))
					{					
						  
						Statement stmtVeh8 = conn.createStatement ();
						String vehsql= "select  plate.code_name platecode,v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc,m.fleet_no,m.kmin,m.fin,c.doc_no,c.color,g.gname,g.gid from gl_vehmaster v 	 "
								+ "left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid  left join gl_vehplate plate on v.pltid=plate.doc_no "
								+ "	where v.a_br="+brid+" and ins_exp >=current_date and v.statu <> 7 and "
										+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and  "
										+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','L') "+sqltest ;
					//	System.out.println("--------lease-------"+vehsql);
						ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
						
						RESULTDATA=CommonDAO.convertToJSON(resultSet);
						stmtVeh8.close();
						
					}
					conn.close();
					 return RESULTDATA;
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }
	   
	   /* public  JSONArray vehSearch(HttpSession session) throws SQLException {


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
	    	
	    	
	    
	        Connection conn = null;
	  			try {
					  conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	            	
					String vehsql= ("select v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc,m.fleet_no,m.kmin,m.fin,c.doc_no,c.color,g.gname,g.gid from gl_vehmaster v 	 "
							+ "left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid  "
							+ "	where v.a_br="+brcid+" and ins_exp >=current_date and v.statu <> 7 and "
									+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and  "
									+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','L')" );
					
					ResultSet resultSet = stmtVeh.executeQuery(vehsql) ;
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh.close();
					conn.close();
			}
			catch(Exception e){
				
				e.printStackTrace();
				conn.close();
			}
		//	System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }*/
	    
	    public  ClsLeaseAgreementBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
			ClsLeaseAgreementBean LeaseAgreementBean = new ClsLeaseAgreementBean();
			Connection conn=null;
			try {
			  conn = connDAO.getMyConnection();
			Statement stmtCPV0 = conn.createStatement ();
			
			

			
			String strSql=("select pro.project_name,     if(l.clstatus=0,'Open',if(l.clstatus=1,CONCAT(DATE_FORMAT(lacl.date,'%d-%m-%Y'),'  Close'),'Cancel')) clstatus,      l.projectno,l.po,l.voc_no,round(l.insurexcess,2) insurexcess,l.doc_no,l.brhid,l.cldocno,l.date as leasedate,l.salid as salesmanid,m.sal_name as salesman,round(l.delchg,2) delchg ,"
					+ " l.desc1 as description,l.chif as chiffchk,l.drid as chiff_driverid,l.drid as deldriverid, l.addr as add_driverchk,round(l.addrchg,2) add_charge, "
					+ "if(l.tmpfleet=0,'',tmpfleet) as tmpfleet,if(l.perfleet=0,'',perfleet) as perfleet,l.outdate as outdate,l.outtime "
					+ " as outtime,l.outkm as outkm,l.outfuel as  outfuel,l.delivery as  del_chk,l.deldate as del_date,l.deltime as "
					+ " del_time,round(l.delkm) del_km, l.delfuel as  del_fuel,l.acno as ac_no,   coalesce(v.a_loc,v1.a_loc) a_loc, "
					+ " CONCAT('REG NO : ',coalesce(v.reg_no,v1.reg_no),',',' NAME : ',coalesce(v.FLNAME,v1.FLNAME),',','GROUP : ', coalesce(g.gname,g1.gname),',','COLOR : ',coalesce(c.color,c1.color),',','PLATE CODE:',coalesce(plate.code_name,plate1.code_name)) as fleetdetails,  "
					+ " CONCAT('CONTACT PERSON : ',coalesce(a.contactperson,''), ' ,', ' MOB : ',coalesce(a.per_mob,''), ' , ' ,'EMAIL : '  ,coalesce(a.mail1,'') , ' , ' ,'ADDRESS : ',coalesce(a.address,''), ' , ' ,'TEL NO : ',coalesce(a.per_tel,''))     as  clarress, "
					+ "d.sal_name  drname,d.sal_name  deldrname,RefName,l.per_value,l.per_name,l.inv_type,l.adv_chk from gl_lagmt l   left join gl_vehmaster v on "
					+ "  v.fleet_no=l.perfleet  left join gl_vehmaster v1 on  v1.fleet_no=l.tmpfleet  left join my_color c  on "
					+ "  (c.doc_no=v.clrid) left join my_color c1  on (c1.doc_no=v1.clrid) left join gl_vehplate plate  on "
					+ "  (plate.doc_no=v.pltid) left join gl_vehplate plate1  on (plate1.doc_no=v1.pltid)	left join "
					+ "  my_acbook a on a.cldocno=l.cldocno and  a.dtype='CRM'  left join my_salm m on (m.doc_no=l.salid) "
					+ " left join  my_salesman d on (d.doc_no=l.drid and d.sal_type='DRV') 	left join gl_vehgroup g on (g.doc_no=v.vgrpid)  "
					+ "  left join gl_project pro on l.projectno=pro.doc_no "
					+ " left join gl_vehgroup g1 on (g1.doc_no=v1.vgrpid)      left join gl_lagmtclosem lacl on lacl.agmtno=l.doc_no         where l.doc_no="+docNo+"  ");
			
			String tclSql=("select mnthfrm,mnthto,amt from gl_ltermcl where rdocno="+docNo+"");
			
			
		//	System.out.println("strSql=-----------------=="+strSql);
			
			ResultSet resultSet = stmtCPV0.executeQuery(strSql);
	
  	
			while (resultSet.next()) {
				
				LeaseAgreementBean.setMasterdoc_no(docNo);
				LeaseAgreementBean.setDocno(resultSet.getInt("voc_no"));
				
				
				LeaseAgreementBean.setLeaseprojectDoc(resultSet.getInt("projectno"));
				LeaseAgreementBean.setLeasePo(resultSet.getString("po"));
				LeaseAgreementBean.setLeaseproject(resultSet.getString("project_name"));
				
				LeaseAgreementBean.setDate(resultSet.getString("leasedate"));
				LeaseAgreementBean.setClientid(resultSet.getInt("l.cldocno"));
				LeaseAgreementBean.setClientName(resultSet.getString("RefName"));
				LeaseAgreementBean.setCusaddress(resultSet.getString("clarress"));
				LeaseAgreementBean.setLe_salmanid(resultSet.getInt("salesmanid"));
				LeaseAgreementBean.setSalesmanName(resultSet.getString("salesman"));
				LeaseAgreementBean.setDescription(resultSet.getString("description"));
				LeaseAgreementBean.setLe_clcodeno(resultSet.getString("l.cldocno"));
				LeaseAgreementBean.setLe_clacno(resultSet.getString("ac_no"));
				LeaseAgreementBean.setAdditional_driver(resultSet.getInt("add_driverchk"));
				LeaseAgreementBean.setAdd_driverName(resultSet.getString("drname"));
				LeaseAgreementBean.setAdidrvcharges(resultSet.getString("add_charge"));
				LeaseAgreementBean.setLadrivercheck(resultSet.getInt("chiffchk"));
				LeaseAgreementBean.setDel_chaufferid(resultSet.getInt("chiff_driverid"));
				LeaseAgreementBean.setChkdelivery(resultSet.getInt("del_chk"));
				
				LeaseAgreementBean.setDeldrvid(resultSet.getInt("deldriverid"));
				LeaseAgreementBean.setDeldrvname(resultSet.getString("deldrname"));
				
				 
				
				LeaseAgreementBean.setTempfleet(resultSet.getString("tmpfleet"));
				LeaseAgreementBean.setPermanentfleet(resultSet.getString("perfleet"));
				LeaseAgreementBean.setFleetname(resultSet.getString("fleetdetails"));
				LeaseAgreementBean.setDateout(resultSet.getString("outdate"));
				LeaseAgreementBean.setTimeout(resultSet.getString("outtime"));
				LeaseAgreementBean.setKmout(resultSet.getString("outkm"));
				LeaseAgreementBean.setVehlocation(resultSet.getString("a_loc"));
				LeaseAgreementBean.setCmbfuelout(resultSet.getString("outfuel"));
				LeaseAgreementBean.setDeldateout(resultSet.getString("del_date"));
				LeaseAgreementBean.setDeltimeout(resultSet.getString("del_time"));
				LeaseAgreementBean.setDelkmout(resultSet.getString("del_km"));
				LeaseAgreementBean.setCmbdelfuelout(resultSet.getString("del_fuel"));
				LeaseAgreementBean.setPer_value(resultSet.getInt("l.per_value"));
				LeaseAgreementBean.setPer_name(resultSet.getInt("l.per_name"));
				LeaseAgreementBean.setInvoice(resultSet.getInt("l.inv_type"));
				LeaseAgreementBean.setAdvance_chk(resultSet.getInt("l.adv_chk"));
				LeaseAgreementBean.setDelcharges(resultSet.getString("delchg"));
				
				
				LeaseAgreementBean.setExcessinsur(resultSet.getString("insurexcess"));

				//mm	
			
				  LeaseAgreementBean.setLeasestatus(resultSet.getString("clstatus"));
				
			}
			
			ResultSet rtcl = stmtCPV0.executeQuery(tclSql);
			int i=0;
			while(rtcl.next())
			{	
				
				
				if(i==0)
				{
				LeaseAgreementBean.setM1(rtcl.getString("mnthfrm"));
				LeaseAgreementBean.setM2(rtcl.getString("mnthto"));
				LeaseAgreementBean.setAmt1(rtcl.getString("amt"));
				}
				if(i==1)
				{
				LeaseAgreementBean.setM3(rtcl.getString("mnthfrm"));
				LeaseAgreementBean.setM4(rtcl.getString("mnthto"));
				LeaseAgreementBean.setAmt2(rtcl.getString("amt"));
				}
				if(i==2)
				{
				LeaseAgreementBean.setM5(rtcl.getString("mnthfrm"));
				LeaseAgreementBean.setM6(rtcl.getString("mnthto"));
				LeaseAgreementBean.setAmt3(rtcl.getString("amt"));
				}
				if(i==3)
				{
				LeaseAgreementBean.setM7(rtcl.getString("mnthfrm"));
				LeaseAgreementBean.setM8(rtcl.getString("mnthto"));
				LeaseAgreementBean.setAmt4(rtcl.getString("amt"));
				}
				if(i==4)
				{
				LeaseAgreementBean.setM9(rtcl.getString("mnthfrm"));
				LeaseAgreementBean.setM10(rtcl.getString("mnthto"));
				LeaseAgreementBean.setAmt5(rtcl.getString("amt"));
				}
			//	System.out.println("tercllist========"+i);
				
				i++;
				
			}
			
				
			stmtCPV0.close();
			conn.close();
			}
			catch(Exception e){
			e.printStackTrace();
			conn.close();
			}
			
			return LeaseAgreementBean;
			}
	    public  String getmode() throws SQLException {
	    	
			String cellarray1 = "";  
		    Connection conn = null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmt6 = conn.createStatement ();
					
				
					String tasql= ("select mode  from my_cardm where id=1 and dtype='mode'");
					//System.out.println("----------"+tasql);
					ResultSet resultSet5 = stmt6.executeQuery(tasql);
					while (resultSet5.next()) {
						
					//	ClsEnquiryBean bean = new ClsEnquiryBean();
						cellarray1+=resultSet5.getString("mode")+",";
						//bean.setRentaltype(resultSet5.getString("rentaltype"));
						
					
					
						
		            //	list1Bean.add(bean);
		        	//System.out.println(list1Bean);
					}
					cellarray1=cellarray1.substring(0, cellarray1.length()-1);
					stmt6.close();
					conn.close();
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
		    return cellarray1;
		}


		public  String getcard() throws SQLException {
		
			String cellarray1 = "";  
		    Connection conn = null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmt6 = conn.createStatement ();
					
				
					String tasql= ("select mode  from my_cardm where id=1 and dtype='card'");
					//System.out.println("----------"+tasql);
					ResultSet resultSet5 = stmt6.executeQuery(tasql);
					while (resultSet5.next()) {
						
					//	ClsEnquiryBean bean = new ClsEnquiryBean();
						cellarray1+=resultSet5.getString("mode")+",";
						//bean.setRentaltype(resultSet5.getString("rentaltype"));
						
					
					
						
		            //	list1Bean.add(bean);
		        	//System.out.println(list1Bean);
					}
					cellarray1=cellarray1.substring(0, cellarray1.length()-1);
					stmt6.close();
					conn.close();
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
		    return cellarray1;
		}

	
	    public  ClsLeaseAgreementBean getPrint(int docno) throws SQLException {
	    	ClsLeaseAgreementBean bean = new ClsLeaseAgreementBean();
	    	Connection conn=null;
	      try {
	    	   conn = connDAO.getMyConnection();
	       Statement stmtinvoice = conn.createStatement();
	       String strSql="";
	   
			 //Cosmo Print
	       
	       String strsqlcosmo="select  round(coalesce(l.insurexcess,0),2) insurexcess,if(per_name=1,l.per_value*12,per_value) duration,date_add(l.outdate,interval if(l.per_name=1,l.per_value*12,per_value) month) enddate,v.fleet_no,v.eng_no engine,v.ch_no chassis ,l.voc_no agmtno,DATE_FORMAT(l.outdate,'%d-%m-%Y') outdate,a.refname clientname,a.address clientaddress,a.per_mob,a.per_tel, v.reg_no regno,co.color,"+
	       " yo.yom,brd.brand_name brand,mo.vtype model, (select round(rate,2) rate  from gl_ltarif where  rdocno="+docno+" ) as agreedrate from gl_lagmt l left join my_acbook a "+
	       " on a.cldocno=l.cldocno   and  a.dtype='CRM' left join gl_vehmaster  v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) left join gl_vehmodel mo on "+
	       " mo.doc_no=v.vmodid  left join gl_vehplate p on p.doc_no=v.pltid left join gl_ltarif t on t.rdocno=l.doc_no left join gl_yom yo on yo.doc_no=v.yom  left join "+
	       " my_color co on co.doc_no=v.clrid  left join gl_vehbrand brd on v.brdid=brd.doc_no where l.doc_no="+docno+" group by l.doc_no";
	       System.out.println(strsqlcosmo);
	       Statement stmtcosmo=conn.createStatement();
	       ResultSet rscosmo=stmtcosmo.executeQuery(strsqlcosmo);
	       int duration=0;
	       while(rscosmo.next()){
		   bean.setLblcosmoexcessamt(rscosmo.getString("insurexcess"));
	    	   bean.setLblcosmoagmtno(rscosmo.getString("agmtno"));
	    	   bean.setLblcosmoagreedrate(rscosmo.getString("agreedrate"));
	    	   bean.setLblcosmoclientname(rscosmo.getString("clientname"));
	    	   bean.setLblcosmoclientaddress(rscosmo.getString("clientaddress"));
	    	   bean.setLblcosmoclientmobile(rscosmo.getString("per_mob"));
	    	   bean.setLblcosmoclienttel(rscosmo.getString("per_tel"));
	    	   bean.setLblcosmoregno(rscosmo.getString("regno"));
	    	   bean.setLblcosmocolor(rscosmo.getString("color"));
	    	   bean.setLblcosmoyom(rscosmo.getString("yom"));
	    	   bean.setLblcosmobrand(rscosmo.getString("brand"));
	    	   bean.setLblcosmomodel(rscosmo.getString("model"));
	    	   bean.setLblcosmofleetno(rscosmo.getString("fleet_no"));
	    	   bean.setLblcosmoengine(rscosmo.getString("engine"));
	    	   bean.setLblcosmochassis(rscosmo.getString("chassis"));
	    	   bean.setLblcosmostartdate(rscosmo.getString("outdate"));
	    	   bean.setLblcosmoduration(rscosmo.getString("duration"));
	    	   bean.setLblcosmoenddate(rscosmo.getString("enddate"));
	       }
	       String  strcosmoterm="select mnthfrm,mnthto,round(amt,2) amt,rdocno from gl_ltermcl where rdocno="+docno+" and amt>0 ";
	       ResultSet rscosmoterm=stmtcosmo.executeQuery(strcosmoterm);
	       int cosmoi=0;
	       while(rscosmoterm.next()){
	    	   if(cosmoi==0){
	    		   bean.setLblcosmoterm1(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm2(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt1(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==1){
	    		   bean.setLblcosmoterm3(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm4(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt2(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==2){
	    		   bean.setLblcosmoterm5(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm6(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt3(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==3){
	    		   bean.setLblcosmoterm7(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm8(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt4(rscosmoterm.getString("amt"));
	    	   }
	    	   if(cosmoi==4){
	    		   bean.setLblcosmoterm9(rscosmoterm.getString("mnthfrm"));
	    		   bean.setLblcosmoterm10(rscosmoterm.getString("mnthto"));
	    		   bean.setLblcosmoamt5(rscosmoterm.getString("amt"));
	    	   }
	    	   cosmoi++;
	       }
	       
	       strSql=("select if(a.ser_default=1,if(g1.method=1,round(g1.value,2),0),round(per_salikrate,2)) salikcharge,  "
	       		+ "  if(a.ser_default=1,25,round(per_trafficharge,2)) trafficcharge,  round(l.insurexcess,2) insurexcess , "
	       		+ " l.voc_no,if(l.clstatus=0,'Open','Closed') clstatus, l.doc_no,round(l.addrchg,2) addrchg,l.outkm okm, "
	       		+ " CASE WHEN l.outfuel='0.000' THEN 'Level 0/8' WHEN l.outfuel='0.125' THEN 'Level 1/8' WHEN l.outfuel='0.250' "
	       		+ " THEN 'Level 2/8' WHEN l.outfuel='0.375' THEN 'Level 3/8' WHEN l.outfuel='0.500' THEN 'Level 4/8' WHEN "
	       		+ " l.outfuel='0.625' THEN 'Level 5/8'  WHEN l.outfuel='0.750' THEN 'Level 6/8' WHEN l.outfuel='0.875' THEN 'Level 7/8'  "
	       		+ " WHEN l.outfuel='1.000' THEN 'Level 8/8'  END as 'ofuel' ,DATE_FORMAT(l.outdate,'%d-%m-%Y') odate,l.outtime otime,a.refname,  "
	       		+ " a.address,a.per_mob,  sm.sal_name ,   a.mail1,br.branchname,concat(v.reg_no,' ',p.code_name) reg_no,concat(v.flname,' ',if(l.perfleet=0,'(Temp)','(Pr)')) flname,g.gname,mo.vtype, "
	       		+ " (select round(rate,2) rate  from gl_ltarif where  rdocno="+docno+" ) as rate, (select  round(cdw,2)+round(cdw1,2) "
	       		+ " from gl_ltarif where rdocno="+docno+"  ) as cdw , (select  round(pai,2)+round(pai1,2) "
	       		+ " from gl_ltarif where rdocno="+docno+"  ) as pai , (select round(gps,2)+round(babyseater,2)+round(cooler,2)   from gl_ltarif where "
	       		+ " rdocno="+docno+"  ) as accessories,   (select round(kmrest)  from gl_ltarif where  rdocno="+docno+" ) "
	       		+ " as raextrakm, (select round(exkmrte,2)  from gl_ltarif where  rdocno="+docno+") as raexxtakmchg,  CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
	       		+ " WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250'  THEN 'Level 2/8' WHEN rc.infuel='0.375' "
	       		+ " THEN 'Level 3/8' WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
	       		+ " WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
	       		+ " THEN 'Level 8/8'   END as 'infuel',round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') "
	       		+ " indate,rc.intime,co.color,yo.yom    from gl_lagmt l left join my_acbook a on a.cldocno=l.cldocno "
	       		+ "  and  a.dtype='CRM'   left join my_brch br      on br.branch=l.brhid left join gl_vehmaster  v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
	       		+ " left join gl_vehgroup g on g.doc_no=v.vgrpid  left join gl_config g1 on g1.field_nme='saliksrv'  left join gl_config g2 on g2.field_nme='trafficsrvper'   "
	       		+ "  left join gl_vehmodel mo on mo.doc_no=v.vmodid "
	       		+ " left join gl_vehplate p on p.doc_no=v.pltid left join gl_ltarif t on t.rdocno=l.doc_no "
	       		+ " left join gl_lagmtclosem rc on rc.agmtno=l.doc_no left join gl_yom yo on yo.doc_no=v.yom "
	       		+ " left join my_color co on co.doc_no=v.clrid   left join my_salm sm on sm.doc_no=l.salid     where l.doc_no="+docno+" group by l.doc_no");
		       
//System.out.println("strSql============"+strSql);
	       
	       ResultSet resultSet = stmtinvoice.executeQuery(strSql); 
	       
	     
	       while(resultSet.next()){
	    	   // cldatails
	    	   
	    	   
	    	   bean.setSalikcharge(resultSet.getString("salikcharge"));
	    	   bean.setTrafficcharge(resultSet.getString("trafficcharge"));
	    	   
	    	   
	    	   if(resultSet.getString("cdw").equalsIgnoreCase("0.00"))
			   {
		        bean.setExcessinsu(resultSet.getString("insurexcess")); 
	 
			    }
				   else
				   {
					    
					   bean.setExcessinsu("0.00");   
				   }
				    	   
	    	   
	    	    bean.setClname(resultSet.getString("refname"));
	    	    bean.setCladdress(resultSet.getString("address"));
	    	    bean.setClemail(resultSet.getString("mail1"));
	    	    bean.setClmobno(resultSet.getString("per_mob"));
	    	    //upper
	    	  
	    	   /* bean.setMrano("1");*/
	    	    bean.setRentaldoc(resultSet.getString("voc_no"));
	    	    
	    	  // veh details
	    	    
	    	    bean.setRavehname(resultSet.getString("flname"));
	    	    bean.setRavehgroup(resultSet.getString("gname"));
	    	    bean.setRavehmodel(resultSet.getString("vtype"));
	    	    bean.setRavehregno(resultSet.getString("reg_no"));
	    	    bean.setRadateout(resultSet.getString("odate"));
	    	    bean.setRatimeout(resultSet.getString("otime"));
	    	    bean.setRaklmout(resultSet.getString("okm"));
	    	    
	    	    // rental type
	    	    
	    	 //   bean.setRadaily(resultSet.getString("daily"));
	    	   // bean.setRaweakly(resultSet.getString("weekly"));
	    	  //  bean.setRamonthly(resultSet.getString("monthly"));
	    	    bean.setTariff(resultSet.getString("rate"));
	    	    bean.setRacdwscdw(resultSet.getString("cdw"));
	    	    bean.setRaaccessory(resultSet.getString("accessories"));
	    	    bean.setRaadditionalcge(resultSet.getString("addrchg"));
	    	    bean.setLblpai(resultSet.getString("pai"));
	    	// in details
	    	   
	    	    bean.setInkm(resultSet.getString("inkm"));
	    	    bean.setInfuel(resultSet.getString("infuel"));
	    	    bean.setIndate(resultSet.getString("indate"));
	    	    bean.setIntime(resultSet.getString("intime"));
	    	  
	    	    bean.setRastatus(resultSet.getString("clstatus"));
	    	    bean.setRafuelout(resultSet.getString("ofuel"));
	    	   //
	    	    
	    	   bean.setRayom(resultSet.getString("yom"));
	    	   bean.setRacolor(resultSet.getString("color")) ;
	    	   
	    	   
	    	   //setRaextrakm,setRaexxtakmchg
	    	   
	    	   bean.setRaextrakm(resultSet.getString("raextrakm"));
	    	   bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg"));
	    /*	   bean.setRarenttypes("SS");*/
	    	   
	    	   
		//mm
				
		  bean.setSalname(resultSet.getString("sal_name"));
	    	 	   


	       }
	       
	       
	  
	       stmtinvoice.close();
	       

		 Statement delstmt = conn.createStatement ();
	       String  delsql="select DATE_FORMAT(l.deldate,'%d-%m-%Y') deldate,l.deltime,round(l.delkm) delkm,CASE WHEN l.delfuel='0.000' THEN 'Level 0/8' "
	       		+ "WHEN l.delfuel='0.125' THEN 'Level 1/8'"
	       		+ " WHEN l.delfuel='0.250' THEN 'Level 2/8' WHEN l.delfuel='0.375' THEN 'Level 3/8' WHEN l.delfuel='0.500' THEN 'Level 4/8' "
	       		+ "WHEN l.delfuel='0.625' THEN 'Level 5/8'  WHEN l.delfuel='0.750' THEN 'Level 6/8' WHEN l.delfuel='0.875' THEN 'Level 7/8' "
	       		+ "WHEN l.delfuel='1.000' THEN 'Level 8/8'  END as 'delfuel' from gl_lagmt l where  doc_no="+docno+" ";
		       
	         ResultSet rsdel = delstmt.executeQuery(delsql); 
	        
		       
		       while(rsdel.next()){
		    	   
		    	   bean.setOutdetails("Out :");
		    	   bean.setDeldetailss("Delivered :");
		     	   bean.setDeldates(rsdel.getString("deldate"));
		    	    bean.setDeltimes(rsdel.getString("deltime"));
		    	    bean.setDelkmins(rsdel.getString("delkm"));
		    	    bean.setDelfuels(rsdel.getString("delfuel")); 
		    	   
		    	   
		    	  
		    	   
		       } 
		  //    rsdel.close();
		      delstmt.close();

	       
	      // setTermi1 setTermi2 setTermi3
	       
           Statement trmi = conn.createStatement();
	       
	       String  trmisql="select mnthfrm,mnthto,round(amt,2) amt,rdocno from gl_ltermcl where rdocno="+docno+" and amt>0  limit 5 ";
	       
	       
	       
	       
	       ResultSet resulttermi = trmi.executeQuery(trmisql); 
	       
	       int j=0;
	       
	 	       while(resulttermi.next()){
	 	    	   if(j==0)
	 	    	   {
	 	    	    bean.setTermi1("Between "+resulttermi.getString("mnthfrm")+"    and    "+resulttermi.getString("mnthto")+" Months   -  "+resulttermi.getString("amt"));
	 	    	    
	 	    	    
	 	    	   }
	 	    	   
	 	    	   if(j==1)
	 	    	   {
	 	    		   
	 	    		bean.setTermi2("Between "+resulttermi.getString("mnthfrm")+"    and    "+resulttermi.getString("mnthto")+" Months  -  "+resulttermi.getString("amt"));
	 	  	    	 
	 		    	   
	 	    		   
	 	    	   }
	 	    	   
	 	    	   
	 	    	   if(j==2)
	 	    	   {
	 	    		   
	 	  	    	 
	 	    		bean.setTermi3("Between "+resulttermi.getString("mnthfrm")+"     and    "+resulttermi.getString("mnthto")+" Months  -   "+resulttermi.getString("amt"));
	 		    	  
	 		    	 
	 	    	   }
	 	    	   if(j==3)
	 	    	   {
	 	    		   
	 	  	    	 
	 	    		bean.setTermi4("Between "+resulttermi.getString("mnthfrm")+"     and    "+resulttermi.getString("mnthto")+" Months  -   "+resulttermi.getString("amt"));
	 		    	  
	 		    	 
	 	    	   }
	 	    	 if(j==4)
	 	    	   {
	 	    		   
	 	  	    	 
	 	    		bean.setTermi5("Between "+resulttermi.getString("mnthfrm")+"     and    "+resulttermi.getString("mnthto")+" Months  -   "+resulttermi.getString("amt"));
	 		    	  
	 		    	 
	 	    	   }
	 	    	   j=j+1;
	 	    	   
	 	       }
	 	      trmi.close();
	 	        
	       
	       
	       
	       
	       
	       Statement stmtinvoice66 = conn.createStatement();
	       
	       String  maindr=" select dr.name drname,dr.dlno ,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob,DATE_FORMAT(dr.led,'%d-%m-%Y') led, "
	       		+ " if(dr.PASSPORT_NO=0,'',dr.PASSPORT_NO) passport_no,DATE_FORMAT(dr.pass_exp,'%d-%m-%Y') pass_exp, "
	       		+ " rr.srno from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id and rr.status=3 where rr.rdocno="+docno+" "
	       		+ " and rr.srno between(select min(srno) srno from gl_ldriver  where rdocno="+docno+" and status=3) and (select max(srno) srno from gl_ldriver  where  rdocno="+docno+" and status=3) limit 3 ";
	       
	       
      ResultSet resultmain = stmtinvoice66.executeQuery(maindr); 
	       
      int i=0;
      
	       while(resultmain.next()){
	    	   if(i==0)
	    	   {
	    	    bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	    
	    	   }
	    	   
	    	   if(i==1)
	    	   {
	    		   
	    		   bean.setAdddrname1(resultmain.getString("drname"));
	  	    	 
		    	   bean.setAddlicno1(resultmain.getString("dlno"));
		    	  
		    	   bean.setExpdate1(resultmain.getString("led"));
		    	
		    	   bean.setAdddob1(resultmain.getString("dob"));
	    		   
	    	   }
	    	   
	    	   
	    	   if(i==2)
	    	   {
	    		   
	  	    	 
		    	   bean.setAdddrname2(resultmain.getString("drname"));
		    	  
		    	   bean.setAddlicno2(resultmain.getString("dlno"));
		    	 
		    	   bean.setExpdate2(resultmain.getString("led"));
		    	  
		    	   bean.setAdddob2(resultmain.getString("dob"));
	    		   
	    	   }
	    	   
	    	   i=i+1;
	    	   
	       }
	       stmtinvoice66.close();
	        
	       
	       
	       
	       /*Statement stmtinvoice4 = conn.createStatement();
	       
	       
	 String  maindr=" select d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') "
	 		+ "led,if(d.PASSPORT_NO=0,'',d.PASSPORT_NO) PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp from gl_drdetails d left join gl_ldriver rr on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno) from gl_ldriver where rdocno="+docno+") group by rr.rdocno ";
	 
	 ResultSet resultmain = stmtinvoice4.executeQuery(maindr); 
	       
	       while(resultmain.next()){
	    	   
	    	   bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	   
	       }
	       stmtinvoice4.close();
	        
	       
	      
	       
	       
	       Statement stmtinvoice1 = conn.createStatement();
	       
 
	 String  drone="select dr.name name1,dr.dlno licno1,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob1,DATE_FORMAT(dr.led,'%d-%m-%Y') led1 from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+1 from gl_ldriver where rdocno="+docno+")";
	 
	 ResultSet resultone = stmtinvoice1.executeQuery(drone); 
	       
	       while(resultone.next()){
	    	   
	    	   bean.setAdddrname1(resultone.getString("name1"));
	    	 
	    	   bean.setAddlicno1(resultone.getString("licno1"));
	    	  
	    	   bean.setExpdate1(resultone.getString("led1"));
	    	
	    	   bean.setAdddob1(resultone.getString("dob1"));
	    	  
	    	   
	       }
	       stmtinvoice1.close();
	     
	   	
	    Statement stmtinvoice2 = conn.createStatement ();
	    String  drtwo="select dr.name name2,dr.dlno licno2,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob2,DATE_FORMAT(dr.led,'%d-%m-%Y') led2 from gl_drdetails dr left join gl_ldriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+2 from gl_ldriver where rdocno="+docno+")";
	 
         ResultSet resulttwo = stmtinvoice2.executeQuery(drtwo); 
	       
	       while(resulttwo.next()){
	    	   
	    	 
	    	   bean.setAdddrname2(resulttwo.getString("name2"));
	    	  
	    	   bean.setAddlicno2(resulttwo.getString("licno2"));
	    	 
	    	   bean.setExpdate2(resulttwo.getString("led2"));
	    	  
	    	   bean.setAdddob2(resulttwo.getString("dob2"));
	    	  
	    	   
	    	   
	       } 
	       stmtinvoice2.close();*/
	       
	       Statement stmtinvoice10 = conn.createStatement ();/*
		    String  companysql="select c.company,c.address,c.tel,c.fax,l.loc_name location from gl_lagmt r  "
		    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
	
		    String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_lagmt r inner join my_brch b on  "
		    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
		    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no="+docno+" "; 
		    ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   
		    	   bean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   bean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   bean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   bean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   bean.setFax(resultsetcompany.getString("fax"));
		    	   bean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
	       
		       Statement stmttatal = conn.createStatement ();
			    String  totalsql="select if(bb.inv-aa.total=0,'',bb.inv-aa.total) balance,if(aa.total=0,'',aa.total) total,if(bb.inv=0,'',bb.inv) inv from ((select coalesce(round(sum(dramount),2),0) total from my_jvtran where rtype='LAG' and rdocno="+docno+"   and dtype='CRV' and id=1)  aa, "
			    		+ "(select coalesce(round(sum(dramount),2),0) inv from my_jvtran where rtype='LAG' and rdocno="+docno+"   and dtype='INV' and id=1) bb);  ";
				
		         ResultSet restotal = stmttatal.executeQuery(totalsql); 
		        
			       
			       while(restotal.next()){
			 
			    	   bean.setTotalpaids(restotal.getString("total"));
			    	   
			    	   bean.setInvamount(restotal.getString("inv"));
			    	   bean.setBalance(restotal.getString("balance"));
			    	   
			       } 
			       stmttatal.close();
			       
		
	       
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	       conn.close();
	      
	      }
	      return bean;
	     }
	  
	    public  JSONArray ralistgridload(String rentaldoc) throws SQLException {

	       JSONArray RESULTDATA=new JSONArray();
	       Connection conn=null;
	    
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh2 = conn.createStatement ();
	            	
				
					
					String sql="select r.idno,m.acno, qty,r.total,m.description	from gl_invmode m left join (select r.idno, qty,coalesce(sum(amount),0) total,"
							+ "sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,(sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from "
							+ "	gl_lcalc r where r.idno not in(8,9,14,15) and rdocno='"+rentaldoc+"' and afterclose=0 group by idno 	union all select r.idno, qty,coalesce(sum(amount),0) total, "
							+ "sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0, (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from "
							+ "	gl_lcalc r where r.idno in(8,14) and rdocno='"+rentaldoc+"' and afterclose=0 union all select r.idno, qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0, "
					+ "	(sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_lcalc r where r.idno in(9,15) and rdocno='"+rentaldoc+"' and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";
					
	
					ResultSet resultSet = stmtVeh2.executeQuery (sql);
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
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

		
	    public  ClsLeaseAgreementBean getmainPrint(int docno) throws SQLException {
	    	
	    	ClsLeaseAgreementBean mainbean = new ClsLeaseAgreementBean();	
	    	
	    	
	    	 Connection conn=null;
	    	 try {
		    	  conn = connDAO.getMyConnection();
		       Statement stmtmainprint = conn.createStatement();
		       String mainprintsql="";
		   
		       mainprintsql=("select c.company,a.refname,a.address,a.per_mob,v.flname,Concat(if(l.per_name=1,l.per_value*12,l.per_value),' ','Months') duration, "
		       		+ "(select round((rate+cdw+pai+cdw1+pai1+gps+babyseater+cooler),2)  from gl_ltarif where rdocno="+docno+") as cost, "
		       		+ "(select if(round(kmrest)>0,concat(' , ',round(kmrest),' KM PM Restricted'),'') from gl_ltarif where rdocno="+docno+") as kmrest "
		       		+ "from gl_lagmt l left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' "
		       		+ "left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) left join gl_ltarif t on t.rdocno=l.doc_no "
		       		+ "left join my_brch b on l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no  where l.doc_no="+docno+" ");
		       
		      
		       
		       ResultSet resultmainprint = stmtmainprint.executeQuery(mainprintsql); 
		       while(resultmainprint.next()){
	
		    	   mainbean.setTxtcustomersname(resultmainprint.getString("refname"));
			    	  
		    	   mainbean.setTxtaddress(resultmainprint.getString("address"));
		    	 
		    	   mainbean.setTxtcontact(resultmainprint.getString("per_mob"));
		    	  
		    	   mainbean.setVehicledetails(resultmainprint.getString("flname"));
			    	  
		    	   mainbean.setVehduration(resultmainprint.getString("duration"));
		    	 
		    	   mainbean.setVehcostpermonth(resultmainprint.getString("cost"));  
		    	   mainbean.setKmrest(resultmainprint.getString("kmrest"));  
		    	   
		    	   
		     	   mainbean.setLbllessorcompany(resultmainprint.getString("company"));  
		    	   mainbean.setClientnames(resultmainprint.getString("refname"));  
		    	   
		    		 
		    		 
		    		  
		       }
		       
	
		       stmtmainprint.close();
		       conn.close();
		      }
		      catch(Exception e){
		       e.printStackTrace();
		       conn.close();
		      
		      }
		      return mainbean;
		     }
	    
	    
	    public  ClsLeaseAgreementBean getClosingSummaryPrint(HttpServletRequest request, int docNo) throws SQLException {
	    	ClsLeaseAgreementBean bean = new ClsLeaseAgreementBean();
			
			Connection conn = null;
			try {
				conn = connDAO.getMyConnection();
				Statement stmtVeh5 = conn.createStatement();
				String sql="";
				
				sql="select r.doc_no,c.company,c.address,c.tel,c.fax,lo.loc_name location,r.outkm,CASE WHEN r.outfuel='0.000' THEN 'Level 0/8' WHEN r.outfuel='0.125' THEN "
				  + "'Level 1/8' WHEN r.outfuel='0.250' THEN 'Level 2/8' WHEN r.outfuel='0.375'	THEN 'Level 3/8'	WHEN r.outfuel='0.500' THEN 'Level 4/8' WHEN r.outfuel='0.625' "
				  + "THEN 'Level 5/8'  WHEN r.outfuel='0.750' THEN 'Level 6/8' WHEN r.outfuel='0.875' THEN 'Level 7/8' WHEN r.outfuel='1.000' THEN 'Level 8/8' END as 'outfuel',"
				  + "DATE_FORMAT(r.outdate,'%d-%m-%Y')outdate,r.outtime,a.refname,br.branchname,v.fleet_no,v.flname,CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' WHEN rc.infuel='0.125' "
				  + "THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' THEN 'Level 3/8' WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' "
				  + "THEN 'Level 5/8' WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' THEN 'Level 8/8' END as 'infuel',round(rc.inkm) inkm,"
				  + "DATE_FORMAT(rc.indate,'%d-%m-%Y') indate,rc.intime from gl_lagmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on d.cldocno=a.cldocno "
				  + "left join my_brch br on br.branch=r.brhid left join gl_vehmaster v on v.fleet_no=if(r.perfleet=0,r.tmpfleet,r.perfleet) left join gl_ltarif t on t.rdocno=r.doc_no left join gl_lagmtclosem rc "
				  + "on rc.agmtno=r.doc_no left join my_locm lo on lo.brhid=br.doc_no left join my_comp c on br.cmpid=c.doc_no where r.doc_no="+docNo+" group by r.doc_no";
				
				ResultSet resultSet = stmtVeh5.executeQuery(sql);
				
				while(resultSet.next()){
					bean.setCompanyname(resultSet.getString("company"));
					bean.setAddress(resultSet.getString("address"));
					bean.setMobileno(resultSet.getString("tel"));
					bean.setFax(resultSet.getString("fax"));
					bean.setLocation(resultSet.getString("location"));
					bean.setBranchname(resultSet.getString("branchname"));
					
					bean.setLblclientname(resultSet.getString("refname"));
					bean.setLblfleetno(resultSet.getString("fleet_no"));
					bean.setLblfleetname(resultSet.getString("flname"));
					
					bean.setLbldateout(resultSet.getString("outdate"));
					bean.setLbltimeout(resultSet.getString("outtime"));
					bean.setLblkmout(resultSet.getString("outkm"));
					bean.setLblfuelout(resultSet.getString("outfuel"));
					
					bean.setLbldatein(resultSet.getString("indate"));
					bean.setLbltimein(resultSet.getString("intime"));
					bean.setLblkmin(resultSet.getString("inkm"));
					bean.setLblfuelin(resultSet.getString("infuel"));
					
				}
				
				String sql1 = "";
				
					sql1="select rep.ofleetno,rep.odate,rep.otime,rep.indate,rep.intime,rep.rfleetno infleetno from gl_lagmt agmt left join "+
							" gl_vehreplace rep on agmt.doc_no=rep.rdocno where rep.status<>7 and rep.rtype='LAG' and agmt.doc_no='"+docNo+"' ";
				
				ResultSet resultSet1 = stmtVeh5.executeQuery(sql1);
				
				ArrayList<String> printreplacearray= new ArrayList<String>();
				
				while(resultSet1.next()){

					String temp="";
					temp=resultSet1.getString("infleetno")+"::"+resultSet1.getString("indate")+"::"+resultSet1.getString("intime")+"::"+resultSet1.getString("ofleetno")+"::"+resultSet1.getString("odate")+"::"+resultSet1.getString("otime");
					printreplacearray.add(temp);
				}
				printreplacearray=printreplacearray.size()==0?null:printreplacearray;
				request.setAttribute("printingreplacementarray", printreplacearray);
				
				String sql2 = "";
				
				sql2="select j.doc_no transno,j.dtype transtype,j.date trdate,j.doc_no rentaldoc,j.rtype rentaltype,j.description,CONVERT(if(ldramount>0,round((ldramount*1),2),'  '),CHAR(100)) debit,"
						+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(100)) credit from my_jvtran j inner join gl_lagmt r on j.rdocno=r.doc_no and rtype='LAG' inner join my_acbook c on "
						+ "c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno where  j.status=3 and  rdocno="+docNo+" and rtype='LAG' and j.dtype='CRV';";
				
				
			
			
			ResultSet resultSet2 = stmtVeh5.executeQuery(sql2);
			
			ArrayList<String> printcrvarray= new ArrayList<String>();
			
			while(resultSet2.next()){

				String temp1="";
				temp1=resultSet2.getString("trdate")+"::"+resultSet2.getString("transtype")+"::"+resultSet2.getString("rentaldoc")+"::"+resultSet2.getString("description")+"::"+resultSet2.getString("debit")+"::"+resultSet2.getString("credit");
				printcrvarray.add(temp1);
			}
			printcrvarray=printcrvarray.size()==0?null:printcrvarray;
			request.setAttribute("printingcashreceiptarray", printcrvarray);
			
			String sql4 = "";
			
			sql4="select CONVERT(if(ldramount>0,round(sum(ldramount*1),2),'0.00'),CHAR(100)) debitcrvtotal,CONVERT(if(ldramount<0,round(sum(ldramount*-1),2),'0.00'),CHAR(100)) creditcrvtotal from my_jvtran j inner join gl_lagmt r on j.rdocno=r.doc_no and rtype='LAG' "
				+ "inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno where  j.status=3 and  rdocno="+docNo+" and rtype='LAG' and j.dtype='CRV'";

			ResultSet resultSet4 = stmtVeh5.executeQuery(sql4);
			
			while(resultSet4.next()){
				bean.setLblsumcrvdebit(resultSet4.getString("debitcrvtotal"));
				bean.setLblsumcrvcredit(resultSet4.getString("creditcrvtotal"));
			}
			
			String sql3 = "";
			
			sql3="select j.doc_no transno,j.dtype transtype,j.date trdate,if(j.dtype='�NV',inv.voc_no,j.doc_no) rentaldoc,j.rtype rentaltype,j.description,CONVERT(if(ldramount>0,round((ldramount*1),2),'  '),CHAR(100)) debit,"
					+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(100)) credit from my_jvtran j inner join gl_lagmt r on j.rdocno=r.doc_no and rtype='LAG' inner join my_acbook c on "
					+ "c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno left join gl_invm inv on (j.doc_no=inv.doc_no and j.dtype='INV')  where  j.status=3 and  rdocno="+docNo+" and rtype='LAG' and j.dtype!='CRV';";
			

			
		
		ResultSet resultSet3 = stmtVeh5.executeQuery(sql3);
		
		ArrayList<String> printotherreceiptarray= new ArrayList<String>();
		
		while(resultSet3.next()){

			String temp2="";
			temp2=resultSet3.getString("trdate")+"::"+resultSet3.getString("transtype")+"::"+resultSet3.getString("rentaldoc")+"::"+resultSet3.getString("description")+"::"+resultSet3.getString("debit")+"::"+resultSet3.getString("credit");
			printotherreceiptarray.add(temp2);
		}
		printotherreceiptarray=printotherreceiptarray.size()==0?null:printotherreceiptarray;
		request.setAttribute("printingotherreceiptarray", printotherreceiptarray);
		
		String sql5 = "";
		
		sql5="select CONVERT(if(ldramount>0,round(sum(ldramount*1),2),'0.00'),CHAR(100)) debittotal,CONVERT(if(ldramount<0,round(sum(ldramount*-1),2),'0.00'),CHAR(100)) credittotal from my_jvtran j inner join gl_lagmt r on j.rdocno=r.doc_no and rtype='LAG' "
			+ "inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno where  j.status=3 and  rdocno="+docNo+" and rtype='LAG' and j.dtype!='CRV'";
		
		ResultSet resultSet5 = stmtVeh5.executeQuery(sql5);
		
		while(resultSet5.next()){
			bean.setLblsumotherdebit(resultSet5.getString("debittotal"));
			bean.setLblsumothercredit(resultSet5.getString("credittotal"));
		}
		
		String sql6="";
		
		sql6="select round(sum('"+bean.getLblsumotherdebit()+"'+'"+bean.getLblsumothercredit()+"'+'"+bean.getLblsumcrvdebit()+"'+'"+bean.getLblsumcrvcredit()+"'),2) balancetotal";
		ResultSet resultSet6 = stmtVeh5.executeQuery(sql6);
		
		while(resultSet6.next()){
		
			bean.setLblnetbalance(resultSet6.getString("balancetotal"));
		}
		
		stmtVeh5.close();
		conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return bean;
	}
	    
	    
	    
	    
	    public  JSONArray searchproject() throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();


		    Connection conn=null;


	  
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh5 = conn.createStatement ();
	            	
					String  tarifsql=("select project_name,doc_no from gl_project where status=3; ");
					//System.out.println("------------------------------"+tarifsql);
					
					ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
					stmtVeh5.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	        
	    public ClsLeaseAgreementBean getKmPrint(HttpServletRequest request,
				int docNo) throws SQLException {
			// TODO Auto-generated method stub
	    	ClsLeaseAgreementBean bean=new ClsLeaseAgreementBean();
			Connection conn=null;
			try{
				conn=connDAO.getMyConnection();
				Statement stmt=conn.createStatement();
				ArrayList<String> kmarray=new ArrayList<>();
				
				String str="select (select round(exkmrte,2) exkmrte from gl_ltarif where rdocno="+docNo+") exkmrte,agmt.clstatus,comp.company,comp.address,comp.tel,comp.fax,loc.loc_name location,br.branchname,coalesce(agmt.voc_no,'') kmagmtno,coalesce(ac.refname,'') kmclient,coalesce(agmt.refno,'') kmmrano,concat(coalesce(veh.fleet_no,''),' - ',coalesce(veh.reg_no,''),' - ',coalesce(veh.flname,'')) kmvehicle,"+
				" coalesce(date_format(agmt.date,'%d/%m/%Y'),'') kmdate,coalesce(drv.name,'') kmdriver from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') "+
				" left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no) left join gl_ldriver rdrv on agmt.doc_no=rdrv.rdocno left join gl_drdetails drv on"+
				" rdrv.drid=drv.dr_id left join my_brch br on agmt.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no left join my_locm loc"+
				" on br.doc_no=loc.brhid where agmt.doc_no="+docNo+" group by agmt.doc_no";
				System.out.println(str);
				ResultSet rs=stmt.executeQuery(str);
				while(rs.next()){
					bean.setLblcompname(rs.getString("company"));
					bean.setLblcompaddress(rs.getString("address"));
					bean.setLblcomptel(rs.getString("tel"));
					bean.setLblcompfax(rs.getString("fax"));
					bean.setLblbranch(rs.getString("branchname"));
					bean.setLbllocation(rs.getString("location"));
					bean.setKmagmtno(rs.getString("kmagmtno"));
					bean.setKmclient(rs.getString("kmclient"));
					bean.setKmmrano(rs.getString("kmmrano"));
					bean.setKmvehicle(rs.getString("kmvehicle"));
					bean.setKmdate(rs.getString("kmdate"));
					bean.setKmdriver(rs.getString("kmdriver"));
					bean.setLblclstatus(rs.getString("clstatus"));
					bean.setLblrateperkm(rs.getString("exkmrte"));
				}

				if(bean.getLblclstatus().equalsIgnoreCase("1")){
					String strtotal="select round(totalkm,0) totalkm,round(excesskm,0) excesskm,round(totalkm,0)-round(excesskm,0) allowedkm from gl_lagmtclosem where agmtno="+docNo;
					System.out.println(strtotal);
					ResultSet rsclose=stmt.executeQuery(strtotal);
					while(rsclose.next()){
						bean.setLbltotalallowedkm(rsclose.getString("allowedkm"));
						bean.setLbltotalexcesskm(rsclose.getString("excesskm"));
						bean.setLbltotalusedkm(rsclose.getString("totalkm"));
					}
					String strexcess="select round(exkmrte,2) totalexcessrate from gl_lagmtclosed where rdocno="+docNo+" and rentaltype='Net Total'";
					System.out.println(strexcess);
					ResultSet rsexcess=stmt.executeQuery(strexcess);
					while(rsexcess.next()){
						bean.setLbltotalexcesskmrate(rsexcess.getString("totalexcessrate"));
					}
				}
				kmarray=getPrintKmArray(docNo,stmt);
				request.setAttribute("KMPRINT", kmarray);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return bean;
		}

		private ArrayList<String> getPrintKmArray(int docNo, Statement stmt) {
			// TODO Auto-generated method stub
			ArrayList<String> kmarray=new ArrayList<>();
			try{
				int delcal=0;
	    		String sqltest="";
	    		String strconfig="select method from gl_config where field_nme='delcal'";
	    		ResultSet rsconfig=stmt.executeQuery(strconfig);
	    		while(rsconfig.next()){
	    			delcal=rsconfig.getInt("method");
	    		}
	    		if(delcal==0){
	    			sqltest=" and trancode<>'DL'";
	    		}
	    		String strsql="select mov.fleet_no,veh.reg_no,veh.flname,coalesce(round(mov.kmout,0),'') kmout,coalesce(date_format(mov.dout,'%d/%m/%Y'),'') dout,mov.tout,"+
	    		" coalesce(round(mov.kmin,0),'') kmin,coalesce(date_format(mov.din,'%d/%m/%Y'),'') din,mov.tin,coalesce(round(mov.kmin,0)-round(mov.kmout,0),'') kmdiff from gl_vmove mov left join"+
	    		" gl_vehmaster veh on mov.fleet_no=veh.fleet_no where mov.rdocno="+docNo+" and mov.rdtype='LAG'"+sqltest;
	    		System.out.println(strsql);
	    		ResultSet rs=stmt.executeQuery(strsql);
	    		while(rs.next()){
	    			kmarray.add(rs.getString("fleet_no")+" :: "+rs.getString("reg_no")+" :: "+rs.getString("flname")+" :: "+rs.getString("dout")+" :: "+rs.getString("tout")+" :: "+rs.getString("kmout")+" :: "+rs.getString("din")+" :: "+rs.getString("tin")+" :: "+rs.getString("kmin")+" :: "+rs.getString("kmdiff"));
	    		}
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
			return kmarray;
		}
	
	
		 public JSONArray getKmDetails(String docno,String id) throws SQLException{
		    	JSONArray kmdata=new JSONArray();
		    	if(!id.equalsIgnoreCase("1")){
		    		return kmdata;
		    	}
		    	Connection conn=null;
		    	try{
		    		conn=connDAO.getMyConnection();
		    		Statement stmt=conn.createStatement();
		    		int delcal=0;
		    		String sqltest="";
		    		String strconfig="select method from gl_config where field_nme='delcal'";
		    		ResultSet rsconfig=stmt.executeQuery(strconfig);
		    		while(rsconfig.next()){
		    			delcal=rsconfig.getInt("method");
		    		}
		    		if(delcal==0){
		    			sqltest=" and trancode<>'DL'";
		    		}
		    		String strsql="select mov.fleet_no,veh.reg_no,veh.flname,mov.kmout,mov.dout,mov.tout,mov.kmin,mov.din,mov.tin,mov.kmin-mov.kmout kmdiff from gl_vmove mov left join"+
		    		" gl_vehmaster veh on mov.fleet_no=veh.fleet_no where mov.rdocno="+docno+" and mov.rdtype='LAG' and mov.status='IN'"+sqltest;
		    		System.out.println(strsql);
		    		ResultSet rs=stmt.executeQuery(strsql);
		    		kmdata=CommonDAO.convertToJSON(rs);
		    		stmt.close();
		    	}
		    	catch(Exception e){
		    		e.printStackTrace();
		    	}
		    	finally{
		    		conn.close();
		    	}
		    	return kmdata;
		    }
}













