package com.operations.agreement.rentalagmtnew;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.agreement.rentalagreement.ClsRentalAgreementBean;
import com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsDAO;

public class ClsRentalAgmtNewDAO {
	ClsRentalAgmtNewBean RentalAgmtNewBean = new ClsRentalAgmtNewBean();
	ClsRentalReceiptsDAO rentalReceiptsDAO= new ClsRentalReceiptsDAO();
	ClsConnection connDAO=new ClsConnection();
	
	ClsCommon commonDAO=new ClsCommon();
	Connection conn;
	int headdoc; // for payment receipt create
	

    String plusval="" ; 
	public int insert(Date sqlrentalDate,String fleetNO,String clientId,int salesmanid,
			String clcodeno,String clacno,
			int addrvchk,String adddrvcharges,
			int delchk,int chfchk,int deldriverid,ArrayList<String>driverarray,String inkm,String infuel,
			Date sqloutDate,String outTime,int salesagentid,int rentalagentid,
			int checkoutid,Date sqldueDate,String dueTime,ArrayList<String>	ragmttariffarray,
			String tasystem,String tadocno,String invoice,String exessinsu,
	ArrayList<String> paymentarray,String paymentMra,String paymentPo,String origFleetno,String Vehlocationid,String fleetgroup,String rentalType,
	int advancechk,String mode, HttpSession session,String formcode,HttpServletRequest request,String clientname,String delcharge,String rentaldesc,int weekend,String cmbtarifnew) throws SQLException {
		String 	barchid="0";
		 if(!(tasystem.equalsIgnoreCase("Manual")))
	      {
		
			// String chack []= tasystem.split("::");	
			 
			 barchid=tasystem.trim();
	
		
	      }	
		
		
	 
		try{
			
			
			
			int docno;
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
CallableStatement stmtrentalagmt = conn.prepareCall("{CALL rentalAgmtDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
             
      stmtrentalagmt.registerOutParameter(2, java.sql.Types.INTEGER);
      stmtrentalagmt.registerOutParameter(39, java.sql.Types.BIGINT);
      // main
      stmtrentalagmt.setDate(1,sqlrentalDate);
      stmtrentalagmt.setString(3,fleetNO);
      stmtrentalagmt.setString(4,clientId);
      stmtrentalagmt.setInt(5,salesmanid);
    stmtrentalagmt.setString(6,clcodeno);
      stmtrentalagmt.setString(7,clacno);
      // drv
      stmtrentalagmt.setInt(8,addrvchk);
      stmtrentalagmt.setString(9,adddrvcharges);
      stmtrentalagmt.setInt(10,delchk);
      stmtrentalagmt.setInt(11,chfchk);
      stmtrentalagmt.setInt(12,deldriverid);
      // triffmain 
      stmtrentalagmt.setString(13,"Manual");
      stmtrentalagmt.setString(14,tadocno);
      stmtrentalagmt.setString(15,invoice);
      stmtrentalagmt.setString(16,exessinsu);
     
      // thariff sub
      stmtrentalagmt.setString(17,inkm);
      stmtrentalagmt.setString(18,infuel);
      stmtrentalagmt.setDate(19,sqloutDate);
      stmtrentalagmt.setString(20,outTime);
      stmtrentalagmt.setInt(21,salesagentid);
      stmtrentalagmt.setInt(22,rentalagentid);
      stmtrentalagmt.setInt(23,checkoutid);
      stmtrentalagmt.setDate(24,sqldueDate);
      stmtrentalagmt.setString(25,dueTime);
    
    //payment
      stmtrentalagmt.setString(26,paymentMra);
      stmtrentalagmt.setString(27,paymentPo);
      stmtrentalagmt.setString(28,origFleetno.contains(" ")?origFleetno.split(" ")[0]:origFleetno);
      // ex
      stmtrentalagmt.setString(29,Vehlocationid);

      stmtrentalagmt.setString(30,session.getAttribute("COMPANYID").toString().trim());
      
      if(tasystem.equalsIgnoreCase("Manual"))
      {
    	
      stmtrentalagmt.setString(31,session.getAttribute("BRANCHID").toString().trim());
      }
      else
      {
    	  
    	  stmtrentalagmt.setString(31,barchid) ;
      }
      stmtrentalagmt.setString(31,session.getAttribute("BRANCHID").toString().trim());
      stmtrentalagmt.setString(32,session.getAttribute("USERID").toString().trim());
      stmtrentalagmt.setString(33,session.getAttribute("CURRENCYID").toString().trim());

      stmtrentalagmt.setString(34,rentalType);
      stmtrentalagmt.setInt(35,advancechk);
      stmtrentalagmt.setString(36,formcode);
      stmtrentalagmt.setString(37,mode);
      stmtrentalagmt.setString(38,delcharge=="null"?"0":delcharge);
      stmtrentalagmt.setString(40,rentaldesc);
      stmtrentalagmt.setInt(41,weekend);
      
     System.out.println("-----------"+stmtrentalagmt);
 
			stmtrentalagmt.executeQuery();
		    docno=stmtrentalagmt.getInt("docNo");
			String vocno=stmtrentalagmt.getString("vocNo");	
			request.setAttribute("vocno", vocno);
			System.out.println("Doc No: "+docno+" vocno: "+vocno);
	if(docno<=0)
	{
		 conn.close();
		return 0;
	}	     
	else{
		Statement stmt=conn.createStatement();
		int updateval=stmt.executeUpdate("update gl_ragmt set tariftype='"+cmbtarifnew.trim()+"',invtype=3 where doc_no="+docno);
		if(updateval<=0){
			conn.close();
			return 0;
		}
	}
	System.out.println("Tarif type:"+cmbtarifnew);
	if(cmbtarifnew.equalsIgnoreCase("Slab")){
		System.out.println("Inside slab");
		for(int i=0;i<ragmttariffarray.size();i++){
			System.out.println(ragmttariffarray.get(i));
			String[] tariff=ragmttariffarray.get(i).split("::");
			String sql="INSERT INTO gl_rtarif(rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg,rstatus,brhid,rdocno,gid,slabfromday,slabtoday,slabrateperday)VALUES"
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
				       + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"
				       + "'"+(tariff[14].trim().equalsIgnoreCase("undefined") || tariff[14].trim().equalsIgnoreCase("")|| tariff[14].trim().equalsIgnoreCase("NaN")|| tariff[14].isEmpty()?0:tariff[14].trim())+"',"
				       + "'"+(tariff[15].trim().equalsIgnoreCase("undefined") || tariff[15].trim().equalsIgnoreCase("")|| tariff[15].trim().equalsIgnoreCase("NaN")|| tariff[15].isEmpty()?0:tariff[15].trim())+"',"
				       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+fleetgroup+"',"
				       + "'"+(tariff[20].trim().equalsIgnoreCase("undefined") || tariff[20].trim().equalsIgnoreCase("")|| tariff[20].trim().equalsIgnoreCase("NaN")|| tariff[20].isEmpty()?0:tariff[20].trim())+"',"
				       + "'"+(tariff[21].trim().equalsIgnoreCase("undefined") || tariff[21].trim().equalsIgnoreCase("")|| tariff[21].trim().equalsIgnoreCase("NaN")|| tariff[21].isEmpty()?0:tariff[21].trim())+"',"
				       + "'"+(tariff[22].trim().equalsIgnoreCase("undefined") || tariff[22].trim().equalsIgnoreCase("")|| tariff[22].trim().equalsIgnoreCase("NaN")|| tariff[22].isEmpty()?0:tariff[22].trim())+"')";
			System.out.println(sql);	
			int resultSet1 = stmtrentalagmt.executeUpdate (sql);
				     if(resultSet1<=0)
					    {
				    	 conn.close();
				    	 return 0;
					    }
		}
	}
	else if(cmbtarifnew.trim().equalsIgnoreCase("Package")){
		System.out.println("Inside Package Insert");
		for(int i=0;i<ragmttariffarray.size();i++){
			System.out.println(ragmttariffarray.get(i));
			String[] tariff=ragmttariffarray.get(i).split("::");
			System.out.println(ragmttariffarray.get(i));
			String sql="INSERT INTO gl_rtarif(rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg,rstatus,brhid,rdocno,gid,packageblockday,packageblocktarif,packageextradaytarif)VALUES"
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
				       + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"
				       + "'"+(tariff[14].trim().equalsIgnoreCase("undefined") || tariff[14].trim().equalsIgnoreCase("")|| tariff[14].trim().equalsIgnoreCase("NaN")|| tariff[14].isEmpty()?0:tariff[14].trim())+"',"
				       + "'"+(tariff[15].trim().equalsIgnoreCase("undefined") || tariff[15].trim().equalsIgnoreCase("")|| tariff[15].trim().equalsIgnoreCase("NaN")|| tariff[15].isEmpty()?0:tariff[15].trim())+"',"
				       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+fleetgroup+"',"
				       + "'"+(tariff[23].trim().equalsIgnoreCase("undefined") || tariff[23].trim().equalsIgnoreCase("")|| tariff[23].trim().equalsIgnoreCase("NaN")|| tariff[23].isEmpty()?0:tariff[23].trim())+"',"
				       + "'"+(tariff[24].trim().equalsIgnoreCase("undefined") || tariff[24].trim().equalsIgnoreCase("")|| tariff[24].trim().equalsIgnoreCase("NaN")|| tariff[24].isEmpty()?0:tariff[24].trim())+"',"
				       + "'"+(tariff[25].trim().equalsIgnoreCase("undefined") || tariff[25].trim().equalsIgnoreCase("")|| tariff[25].trim().equalsIgnoreCase("NaN")|| tariff[25].isEmpty()?0:tariff[25].trim())+"')";
				     System.out.println(sql);
			int resultSet1 = stmtrentalagmt.executeUpdate (sql);
				     if(resultSet1<=0)
					    {
				    	 conn.close();
				    	 return 0;
					    }
		}
	}
	else if(weekend==0)
	{
		System.out.println("Inside weekend");
    for(int i=0;i< ragmttariffarray.size();i++){
    	
	     String[] tariff=ragmttariffarray.get(i).split("::");
	    
	    // System.out.println("dasfghjk======="+ragmttariffarray.get(i));
	     String sql="INSERT INTO gl_rtarif(rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg,rstatus,brhid,rdocno,gid)VALUES"
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
	       + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"
	       + "'"+(tariff[14].trim().equalsIgnoreCase("undefined") || tariff[14].trim().equalsIgnoreCase("")|| tariff[14].trim().equalsIgnoreCase("NaN")|| tariff[14].isEmpty()?0:tariff[14].trim())+"',"
	       + "'"+(tariff[15].trim().equalsIgnoreCase("undefined") || tariff[15].trim().equalsIgnoreCase("")|| tariff[15].trim().equalsIgnoreCase("NaN")|| tariff[15].isEmpty()?0:tariff[15].trim())+"',"
	       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+fleetgroup+"' )";
	     int resultSet1 = stmtrentalagmt.executeUpdate (sql);
	     if(resultSet1<=0)
		    {
	    	 conn.close();
	    	 return 0;
		    }
	     
	     }
	
	}
	
	
	else
	{	
		System.out.println("Inside Regular");
	
	
		     for(int i=0;i< ragmttariffarray.size();i++){
		    	
		     String[] tariff=ragmttariffarray.get(i).split("::");
		    
		    // System.out.println("dasfghjk======="+ragmttariffarray.get(i));
		     String sql="INSERT INTO gl_rtarif(rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg,rstatus,st_day,st_time,ed_day,ed_time,brhid,rdocno,gid)VALUES"
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
		       + "'"+(tariff[13].trim().equalsIgnoreCase("undefined") || tariff[13].trim().equalsIgnoreCase("")|| tariff[13].trim().equalsIgnoreCase("NaN")|| tariff[13].isEmpty()?0:tariff[13].trim())+"',"
		       + "'"+(tariff[14].trim().equalsIgnoreCase("undefined") || tariff[14].trim().equalsIgnoreCase("")|| tariff[14].trim().equalsIgnoreCase("NaN")|| tariff[14].isEmpty()?0:tariff[14].trim())+"',"
		       + "'"+(tariff[15].trim().equalsIgnoreCase("undefined") || tariff[15].trim().equalsIgnoreCase("")|| tariff[15].trim().equalsIgnoreCase("NaN")|| tariff[15].isEmpty()?0:tariff[15].trim())+"',"
		       
		            + "'"+(tariff[16].trim().equalsIgnoreCase("undefined") || tariff[16].trim().equalsIgnoreCase("")|| tariff[16].trim().equalsIgnoreCase("NaN")|| tariff[16].isEmpty()?0:tariff[16].trim())+"',"
				       + "'"+(tariff[17].trim().equalsIgnoreCase("undefined") || tariff[17].trim().equalsIgnoreCase("")|| tariff[17].trim().equalsIgnoreCase("NaN")|| tariff[17].isEmpty()?0:tariff[13].trim())+"',"
				       + "'"+(tariff[18].trim().equalsIgnoreCase("undefined") || tariff[18].trim().equalsIgnoreCase("")|| tariff[18].trim().equalsIgnoreCase("NaN")|| tariff[18].isEmpty()?0:tariff[18].trim())+"',"
				       + "'"+(tariff[19].trim().equalsIgnoreCase("undefined") || tariff[19].trim().equalsIgnoreCase("")|| tariff[19].trim().equalsIgnoreCase("NaN")|| tariff[19].isEmpty()?0:tariff[19].trim())+"',"
				      
		       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+fleetgroup+"' )";
		     int resultSet1 = stmtrentalagmt.executeUpdate (sql);
		     if(resultSet1<=0)
			    {
		    	 conn.close();
		    	 return 0;
			    }
		     
		     }
		
	}
		     
		     ArrayList<String> blankarray= new ArrayList<String>();
		    
		    for(int i=0;i< paymentarray.size();i++){
		    	
			     String[] payment=paymentarray.get(i).split("::");
			     
			     if(!(payment[1].trim().equalsIgnoreCase("undefined")||payment[1].trim().equalsIgnoreCase("")|| payment[1].trim().equalsIgnoreCase("NaN")|| payment[1].isEmpty()))
			     {

		   // String paytype="'"+ payment[1].trim()+"'";
		    String cardtype=""+(payment[7].trim().equalsIgnoreCase("undefined") ||payment[7].trim().equalsIgnoreCase("")|| payment[7].trim().equalsIgnoreCase("NaN")|| payment[7].isEmpty()?0:payment[7].trim())+"";
            String paidas=""+(payment[10].trim().equalsIgnoreCase("undefined") ||payment[10].trim().equalsIgnoreCase("")|| payment[10].trim().equalsIgnoreCase("NaN")|| payment[10].isEmpty()?0:payment[10].trim())+"";
		 
            String Amt= ""+(payment[2].trim().equalsIgnoreCase("undefined") || payment[2].trim().equalsIgnoreCase("")|| payment[2].trim().equalsIgnoreCase("NaN")|| payment[2].isEmpty()?0:payment[2].trim())+"";
           
            String paytypeid=""+(payment[8].trim().equalsIgnoreCase("undefined") ||payment[8].trim().equalsIgnoreCase("")|| payment[8].trim().equalsIgnoreCase("NaN")|| payment[8].isEmpty()?0:payment[8].trim())+"";
            
            
            String refdoc=""+(payment[4].trim().equalsIgnoreCase("undefined") ||payment[4].trim().equalsIgnoreCase("")|| payment[4].trim().equalsIgnoreCase("NaN")|| payment[4].isEmpty()?0:payment[4].trim())+"";
            
            int cldoc = Integer.parseInt(clientId);
		     
		     int claccount=Integer.parseInt(clacno);
		     
		   
		     String aggno=""+docno;
          
            
            double Amount=Double.parseDouble(Amt);
            
          
            int srno=0;
            String type="";
            if(!(paidas.equalsIgnoreCase("3")))
            
            {
           /*  if(!paytypeid.equalsIgnoreCase("3"))
             {
            	*/
             /* type=paytypeid.equalsIgnoreCase("1")?"rcash":"rcard";
             }
             else
             {
            	 type="ronline"; 
             }*/
             
         /*    String selectsql="select t.doc_no,t.account,t.description from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where codeno='"+type+"'";
             
			 ResultSet resSet = stmtrentalagmt.executeQuery(selectsql);
			     if (resSet.next()) {
			    	 headdoc = resSet.getInt("doc_no");
			                      }*/
            	
            	
            	String selectsql="select acno from my_cardm where doc_no='"+paytypeid+"' and dtype='mode'";
                
   			 ResultSet resSet = stmtrentalagmt.executeQuery(selectsql);
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
            	
            	
            	
            	
			     
			     	
		     int valre=rentalReceiptsDAO.insert(conn,sqlrentalDate,"RRV",paytypeid,headdoc,cardtype,refdoc.trim(),sqlrentalDate,"RA"+" "+vocno+" "+advorsec,0,"0",cldoc,claccount,"RAG",aggno,payid,Amount,0.00,0.00,0.00,
		    		 Amount,"RA"+" "+vocno+" "+advorsec,clientname,0.00,blankarray,session,request);
		     
		     
		      srno=(int) request.getAttribute("isrno");
		    if(valre<=0)	{
		    	
		    	 conn.close();
		    	 return 0; 
		    	
		                  }
                }
		    	 
		    	 String sql="INSERT INTO gl_rpyt(payment,mode,amount,acode,cardno,expdate,card,cardtype,paytype,payid,brhid,rdocno,recieptno)VALUES"
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
					     int resultSet2 = stmtrentalagmt.executeUpdate (sql);
			     if(resultSet2<=0)
			     {
			    	 conn.close();
			    	 return 0; 
			     }
		  
		     
		     //gl_config
		     
		     //update
				 
			     if((paidas.equalsIgnoreCase("3")))
			            
		            {
			    	 
			    	 
			    	 String dateval="select round(value) plusval from gl_config where field_nme='ccrelDate'";
		             
		           
					 ResultSet resSet = stmtrentalagmt.executeQuery(dateval);
					     if (resSet.next()) {
					    	 plusval = resSet.getString("plusval").trim();
					               }
					     
			   String upsql="update gl_rpyt set reldate=(select DATE_ADD('"+sqloutDate+"', interval '"+plusval+"' day )) where rdocno="+docno+" and payid='"+paidas+"'";
			   int upval = stmtrentalagmt.executeUpdate (upsql);
			   
							   if(upval<=0)
							   {
								   conn.close();
							    	 return 0; 
							   }
							   
			   
		            }
		       }   
			     
			     
		    }
		    
		    
		    
		 	if(chfchk!=1)
		 	{
		     for(int i=0;i< driverarray.size();i++){
			     String[] driver=driverarray.get(i).split("::");
			     if(!(driver[0].trim().equalsIgnoreCase("undefined")||driver[0].trim().equalsIgnoreCase("")|| driver[0].isEmpty()))
			     {
		     String sql="INSERT INTO gl_rdriver(drid,brhid,rdocno,cldocno)VALUES"
				       + " ('"+(driver[0].trim().equalsIgnoreCase("undefined") ||driver[0].trim().equalsIgnoreCase("")|| driver[0].isEmpty()?0:driver[0].trim())+"',"
				       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+clientId+"' )";
				     int resultSet3 = stmtrentalagmt.executeUpdate (sql);
				     
				   
				     
				     if(resultSet3<=0)
				     {   
				    	 
				    	 conn.close();
				    	 return 0; 
				     }
			      }
		     }
		 		}
		     
		 	int specialuserdoc=request.getAttribute("specialuserdoc")==null?0:(int) request.getAttribute("specialuserdoc");
		 	if(specialuserdoc>0)
		 	{
		 		
	      String updatesql="update gl_rdisclevel set rdocno='"+docno+"' where doc_no='"+specialuserdoc+"'";
	      int res = stmtrentalagmt.executeUpdate (updatesql);
	      
	      if(res<=0)
		     {   
		    	 
		    	 conn.close();
		    	 return 0; 
		     }
		 	}
		 	
		 	
				if (docno > 0) {
					conn.commit();
					stmtrentalagmt.close();
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

	public boolean update(int week,int docno,Date sqlrentalDate,String fleetNO,String deldrvid,String delkm,String delfuel,Date sqldelDate,String deltime,String vlocation,String vgroup,String mode,String clientid,HttpSession session) throws SQLException {

		try{
	
		
			conn=connDAO.getMyConnection();
			// conn.setAutoCommit(false);
			CallableStatement stmtUpdaterent = conn.prepareCall("{CALL renAgmtupdateDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtUpdaterent.setDate(1,sqlrentalDate);
			stmtUpdaterent.setString(2, fleetNO);
			stmtUpdaterent.setString(3,deldrvid);
			stmtUpdaterent.setString(4,delkm);
			stmtUpdaterent.setString(5,delfuel);
			stmtUpdaterent.setDate(6,sqldelDate);
			stmtUpdaterent.setString(7,deltime.trim());
			stmtUpdaterent.setString(8,session.getAttribute("BRANCHID").toString());
		    stmtUpdaterent.setString(9,vlocation);
			stmtUpdaterent.setString(10,vgroup);
		    stmtUpdaterent.setInt(11,docno);
			stmtUpdaterent.setString(12,clientid);
		   	stmtUpdaterent.setString(13,"ADD");
		 	stmtUpdaterent.setInt(14,week);
		   	
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

	
	
	

    
    
    
    
    public JSONArray chufferinfo() throws SQLException {

   	 JSONArray RESULTDATA=new JSONArray();
   	   
   	        
   	 Connection conn=null;
   			try {
   					  conn = connDAO.getMyConnection();
   					Statement stmtVeh = conn.createStatement ();
   	            	
   					String sqll="select sal_code,doc_no,sal_name from my_salesman where sal_type='DRV' and status<>7 ";
   					
   					
   					ResultSet resultSet = stmtVeh.executeQuery(sqll);

   					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
   	    
    

    
      
    public  JSONArray SalesgentSearch() throws SQLException {

      	 JSONArray RESULTDATA=new JSONArray();
      	   
      	        
      	 Connection conn=null;
      			try {
      					  conn = connDAO.getMyConnection();
      					Statement stmtVeh = conn.createStatement ();
      	            	
      					String salsql="select sal_code,doc_no,sal_name from my_salesman where sal_type='SLA' and status<>7 ";
      					
      					ResultSet resultSet = stmtVeh.executeQuery(salsql);
      					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
     public JSONArray RentalgentSearch() throws SQLException {

      	 JSONArray RESULTDATA=new JSONArray();
      	   
      	        
      	 Connection conn=null;
      			try {
      					  conn = connDAO.getMyConnection();
      					Statement stmtVeh = conn.createStatement ();
      	            	
      					String resql="select sal_code,doc_no,sal_name from my_salesman where sal_type='RLA' and status<>7 ";
      					
      					ResultSet resultSet = stmtVeh.executeQuery(resql);
      					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
     public JSONArray checkoutSearch() throws SQLException {

      	 JSONArray RESULTDATA=new JSONArray();
      	   
      	        
      	 Connection conn=null;
      			try {
      					  conn = connDAO.getMyConnection();
      					Statement stmtVeh = conn.createStatement ();
      	            	
      					String chsql="select sal_code,doc_no,sal_name from my_salesman where sal_type='CHK' and status<>7 ";
      					
      					ResultSet resultSet = stmtVeh.executeQuery(chsql);
      					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
      	    
    


    public  JSONArray trariffbtnGrid(HttpSession session,String vehgpid,String cldocno,String tarifnew) throws SQLException {

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
	        
   	   
             	Connection conn=null;
   	      
   			try {
   			 
                     conn = connDAO.getMyConnection();
   					Statement stmtVeh = conn.createStatement ();
   				  String brch=session.getAttribute("BRANCHID").toString();
   	            	

/*   					String sqltari=("select m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,  "
   							+ "	coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
   							+ "	gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where m1.branch='"+brch+"' and  current_date between m.validfrm and m.validto and m.status<>7 and "
   							+ "  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='regular' group by m.doc_no   union all "
   							+ " select aa.doc_no,aa.validto,concat(aa.tariftype,' ',ca.cat_name,' - ',aa.notes) tariftype,aa.clientid, aa.insurexcess, aa.cdwexcess, aa.scdwexcess from "
   							+ "   (select m.doc_no,m.validto,m.tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess, "
   							+ "   coalesce(scdwexcess,0) scdwexcess,m.notes    from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
   							+ "  	gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where  m1.branch='"+brch+"' and  current_date between m.validfrm and m.validto  "
   							+ " and m.status<>7 and  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='corporate' group by m.doc_no) aa "
   							+ " inner join (select * from my_acbook cl where cl.dtype='CRM' and cl.doc_no='"+cldocno+"') bb  "
   							+ "	on aa.tariftype='corporate' and aa.clientid=bb.catid left join my_clcatm ca on ca.doc_no=bb.catid    union all  "
   							+ " select m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,   "
   							+ " coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
   							+ "gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where  m1.branch='"+brch+"' and current_date between m.validfrm and m.validto  "
   							+ "  and m.status<>7  and  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='Client' and m.clientid='"+cldocno+"' group by m.doc_no ") ;*/
   				String sqltari="";
   				if(tarifnew.equalsIgnoreCase("Slab")){
   					sqltari="select m.doc_no,m.validto,concat(m.tariftype,' - ',coalesce(m.notes,'')) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess,"+
   					" coalesce(cdwexcess,0) cdwexcess,  coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no"+
   					" left join gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where    current_date between m.validfrm and m.validto and"+
   					" m.status=3 and (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='Slab' group by m.doc_no ";
   				}
   				else if(tarifnew.equalsIgnoreCase("Package")){
   					sqltari="select m.doc_no,m.validto,concat(m.tariftype,' - ',coalesce(m.notes,'')) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess,"+
   		   					" coalesce(cdwexcess,0) cdwexcess,  coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no"+
   		   					" left join gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where    current_date between m.validfrm and m.validto and"+
   		   					" m.status=3 and (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='Package' group by m.doc_no ";
   				}
   				else{
   					 sqltari=("select m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,  "
   							+ "	coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
   							+ "	gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where    current_date between m.validfrm and m.validto and m.status=3 and "
   							+ "  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='regular' group by m.doc_no   union all "
   							+ " select aa.doc_no,aa.validto,concat(aa.tariftype,' ',ca.cat_name,' - ',aa.notes) tariftype,aa.clientid, aa.insurexcess, aa.cdwexcess, aa.scdwexcess from "
   							+ "   (select m.doc_no,m.validto,m.tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess, "
   							+ "   coalesce(scdwexcess,0) scdwexcess,m.notes    from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
   							+ "  	gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where   current_date between m.validfrm and m.validto  "
   							+ " and m.status=3 and  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='corporate' group by m.doc_no) aa "
   							+ " inner join (select * from my_acbook cl where cl.dtype='CRM' and cl.doc_no='"+cldocno+"') bb  "
   							+ "	on aa.tariftype='corporate' and aa.clientid=bb.catid left join my_clcatm ca on ca.doc_no=bb.catid    union all  "
   							+ " select m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,   "
   							+ " coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
   							+ "gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where  current_date between m.validfrm and m.validto  "
   							+ "  and m.status=3  and  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='Client' and m.clientid='"+cldocno+"' group by m.doc_no ") ;   					
   				}

   					
   				//System.out.println("=========1111========="+sqltari);
   					
   					// gl_tarifexcess for cdw ,super cdw  insu
   				
   			
   					ResultSet resultSet = stmtVeh.executeQuery(sqltari);
   					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
    public  JSONArray weekendtrariffbtnGrid(HttpSession session,String vehgpid,String cldocno,String outdate,String outtime) throws SQLException {

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
   	       java.sql.Date sqloutdate=null;
   	       
   	       
   	    if(!(outdate.equalsIgnoreCase("undefined"))&&!(outdate.equalsIgnoreCase("NA"))&&!(outdate.equalsIgnoreCase("0")))
   		{
   	    	sqloutdate=commonDAO.changeStringtoSqlDate(outdate);
   			
   		}
      	   
                	Connection conn=null;
      	      
      			try {
      			 
                        conn = connDAO.getMyConnection();
      					Statement stmtVeh = conn.createStatement ();
      				  String brch=session.getAttribute("BRANCHID").toString();
      	            	

 		 
 				String sqltari=("select m1.cswkday,m1.cstime,m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, "
   						+ " coalesce(cdwexcess,0) cdwexcess,  	coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifcondn m1  "
   						+ "  on m1.doc_no=m.doc_no left join  	gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where m1.gid='"+vehgpid+"' and "
   						+ "   current_date between m.validfrm and m.validto and m.status=3 and   (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') "
   						+ "   and m.tariftype='Weekend'  and DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime<='"+outtime+"'  group by m.doc_no") ; 
   	
      			//	System.out.println("=========1111========="+sqltari);
      					
      					 
      				
      			
      					ResultSet resultSet = stmtVeh.executeQuery(sqltari);
      					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
  public JSONArray searchuser(HttpSession session,String tarifdoc,String groupid) throws SQLException {

      	 JSONArray RESULTDATA=new JSONArray();
      	   
                	Connection conn=null;
      	      
      			try {

                        conn = connDAO.getMyConnection();
      					Statement stmtVeh = conn.createStatement ();

      				  String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
      					// gl_tarifexcess for cdw ,super cdw  insu
      				String usersql="select u.user_name,u.doc_no,u.ulevel,(select case when u.ulevel=1 then m1.disclevel1  "
      						+ "when u.ulevel=2 then m1.disclevel2 when u.ulevel=3 then m1.disclevel3 else 0 "
      						+ "end as 'disclevel' from  gl_tarifd m1 where m1.renttype='daily' and doc_no='"+tarifdoc+"' and gid='"+groupid+"')  "
      						+ "daily,(select case when u.ulevel=1 then m1.disclevel1 when u.ulevel=2 then m1.disclevel2  "
      						+ "when u.ulevel=3 then m1.disclevel3 else 0 "
      						+ "end as 'disclevel' from  gl_tarifd m1 where m1.renttype='weekly' and doc_no='"+tarifdoc+"' and gid='"+groupid+"') weekly, "
      						+ "(select case when u.ulevel=1 then m1.disclevel1 when u.ulevel=2 then m1.disclevel2 when u.ulevel=3 then m1.disclevel3 else 0  "
      						+ "end as 'disclevel' from  gl_tarifd m1 where m1.renttype='monthly' and doc_no='"+tarifdoc+"' and gid='"+groupid+"') monthly from my_user  u, gl_tarifm  m "
      						+ "  where u.status<>7 and u.ulevel>(select ulevel from my_user where doc_no='"+userid+"') and m.doc_no='"+tarifdoc+"'  group by u.doc_no,m.doc_no;";
      			
      				//      				System.out.println("usersql----------"+usersql);	
      				
      				
      				ResultSet resultSet = stmtVeh.executeQuery(usersql);
      					RESULTDATA=commonDAO.convertToJSON(resultSet);
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

 public  JSONArray reloadDriver(HttpSession session,String txtrentaldocno) throws SQLException {

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
	            	
					String drsql=("SELECT d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM gl_drdetails d  left join gl_rdriver r  on d.dr_id=r.drid where r.rdocno='"+txtrentaldocno+"' and r.status=3  order by srno ");

					
					ResultSet resultSet = stmtVeh.executeQuery(drsql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
 public JSONArray clientDriver(String clientid) throws SQLException {

	 JSONArray RESULTDATA=new JSONArray();
	   
	        
	 Connection conn=null;
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	            	
					ResultSet resultSet = stmtVeh.executeQuery("SELECT d.dr_id,d.doc_no,d.name,d.dob,d.nation,d.mobno,d.dlno,d.issdate,d.led,d.ltype,d.issfrm,d.passport_no,d.pass_exp,d.visano,d.visa_exp,d.hcdlno,d.hcissdate,d.hcled ,d.cldocno,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear,(select value from gl_config where field_nme='drage') drage ,(select value from gl_config where field_nme='licyr') licyr FROM gl_drdetails d  WHERE d.cldocno='"+clientid+"' and d.dtype='CRM' ;");

					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
	            	String pySql=("select rdocno, payment, mode, amount, acode, cardno, expdate, recieptno, brhid, payid, doc_no, card, paytype, cardtype from gl_rpyt where rdocno='"+txtrentaldocno1+"'  ");
	            	//System.out.println("========"+pySql);
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);

					RESULTDATA=commonDAO.convertToJSON(resultSet); 
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
	    
	    public  JSONArray cardSearch(String cldocno) throws SQLException {
	       

	         JSONArray RESULTDATA=new JSONArray();
	         
	         Connection conn = null;
	   
	         try {
	     conn = connDAO.getMyConnection();
	     Statement stmtRRV = conn.createStatement();
	              
	   String sqls= ("SELECT m.doc_no type,m.mode cardtype,replace(trim(c.cardno),' ','') cardno,c.exp_date,DATE_FORMAT(c.exp_date,'%m-%Y')  hidexpdate FROM my_clbankdet c left join my_cardm m on\r\n" + 
	     		"c.type=m.mode and (m.dtype='card' and m.id=1) where  c.rdocno='"+cldocno+"'");
	     ResultSet resultSet = stmtRRV.executeQuery (sqls);
	   //  System.out.println("-----sqls----"+sqls);
	     
	     RESULTDATA=commonDAO.convertToJSON(resultSet);
	     
	     stmtRRV.close();
	     conn.close();
	   }catch(Exception e){
	    e.printStackTrace();
	    conn.close();
	   }finally{
	    conn.close();
	   }
	         return RESULTDATA;
	     }
	    
	    
	    
	    public  JSONArray tariffType() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn=null;
	       
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh2 = conn.createStatement ();
	            	
					ResultSet resultSet = stmtVeh2.executeQuery ("select rentaltype  from gl_tlistm where status=1 order by doc_no");

					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
	    public  JSONArray tariffRate(HttpSession session,String ratariffdocno,String groupname,String tarifnew) throws SQLException {


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
	   	        
	       
	   	 Connection conn=null;
			try {
					 conn = connDAO.getMyConnection();
			        String brch=session.getAttribute("BRANCHID").toString();
	                String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	                Statement stmtVeh6 = conn.createStatement ();
	            	
					/*String sqltari=("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg, "
							+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  "
							+ "right join gl_tlistm m2 on m1.renttype=m2.rentaltype  where m1.gid='"+groupname+"'  and   m.doc_no='"+ratariffdocno+"' and m1.branch='"+brch+"' and m2.status=1 order by m2.doc_no");*/
	            	
		/*			String sqltari=("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg, "
							+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype,case when u.ulevel=1 then m1.disclevel1 when u.ulevel=2 then m1.disclevel2 when u.ulevel=3 then m1.disclevel3 else 0 "
							+ "end as 'disclevel'  from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  "
							+ "right join gl_tlistm m2 on m1.renttype=m2.rentaltype left join my_user u on u.doc_no='"+userid+"' where m1.gid='"+groupname+"'  and   "
							+ " m.doc_no='"+ratariffdocno+"' and m2.status=1 order by m2.doc_no");*/
	                String sqltari="";
	                if(tarifnew.equalsIgnoreCase("Slab") || tarifnew.equalsIgnoreCase("Package")){
	                	
	                	sqltari=("select m1.slabfromday,m1.slabtoday,m1.slabrateperday,m1.packageblockday,m1.packageblocktarif,m1.packageextradaytarif,m1.doc_no,"+
	                	" m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg,m1.chaufexchg,m1.exhrchg,"+
	                	" m1.gid,m1.renttype rentaltype from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no where m1.gid='"+groupname+"' and m.doc_no='"+ratariffdocno+"' order by m1.srno");
	                }
	                else{
		    			 sqltari=("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg, "
									+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype,case when u.ulevel=1 then m1.disclevel1 when u.ulevel=2 then m1.disclevel2 when u.ulevel=3 then m1.disclevel3 else 0 "
									+ "end as 'disclevel'  from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  "
									+ "right join gl_tlistm m2 on m1.renttype=m2.rentaltype left join my_user u on u.doc_no='"+userid+"' where m1.gid='"+groupname+"'  and   "
									+ " m.doc_no='"+ratariffdocno+"'  and m2.status=1 order by m2.doc_no");
	                }

					
		//System.out.println("----------"+sqltari);
  
					ResultSet resultSet = stmtVeh6.executeQuery(sqltari);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
	    public  JSONArray weektariffRate(HttpSession session,String ratariffdocno,String groupname,String outdate,String outtime,String tarifnew) throws SQLException {


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
		   	        
		       
		   	 Connection conn=null;
				try {
						 conn = connDAO.getMyConnection();
				        String brch=session.getAttribute("BRANCHID").toString();
		                String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
		                Statement  stmtVeh6 =conn.createStatement();
		            	
						/*String sqltari=("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg, "
								+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  "
								+ "right join gl_tlistm m2 on m1.renttype=m2.rentaltype  where m1.gid='"+groupname+"'  and   m.doc_no='"+ratariffdocno+"' and m1.branch='"+brch+"' and m2.status=1 order by m2.doc_no");*/
		            	
			/*			String sqltari=("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg, "
								+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype,case when u.ulevel=1 then m1.disclevel1 when u.ulevel=2 then m1.disclevel2 when u.ulevel=3 then m1.disclevel3 else 0 "
								+ "end as 'disclevel'  from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  "
								+ "right join gl_tlistm m2 on m1.renttype=m2.rentaltype left join my_user u on u.doc_no='"+userid+"' where m1.gid='"+groupname+"'  and   "
								+ " m.doc_no='"+ratariffdocno+"' and m2.status=1 order by m2.doc_no");*/
		                
		    	/*		String sqltari=("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater, "
		    				+ " m1.cooler,m1.oinschg,m1.chaufchg, m1.chaufexchg,'0' exhrchg,m1.gid,0 'disclevel' "
		    				+ "  from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
		    				+ "	left join my_user u on u.doc_no='"+userid+"' where DAYNAME('2015-12-06')=m1.cswkday and m1.cstime>'09:54' and m1.gid='"+groupname+"'  and   "
		    				+ " m.doc_no='"+ratariffdocno+"' ");*/
		    			
		                java.sql.Date sqloutdate=null;
		        	       
		        	       
		           	    if(!(outdate.equalsIgnoreCase("undefined"))&&!(outdate.equalsIgnoreCase("NA"))&&!(outdate.equalsIgnoreCase("0")))
		           		{
		           	    	sqloutdate=commonDAO.changeStringtoSqlDate(outdate);
		           			
		           		}
		           	    
		           	    int rows=0;
		           	    
		           	   String sqltest="";
		    			Statement  stmtVeh7 =conn.createStatement();
		    			String ss=("select count(*) rows from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
		    					+ "	left join my_user u on u.doc_no='"+userid+"' where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime<='"+outtime+"' and "
		    					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' ");
		    			
		    		
		    		
		    			ResultSet countrs = stmtVeh7.executeQuery(ss);
		           	    if(countrs.next())
		              	   
		           	    {
		           	    	
		           	    	rows=countrs.getInt("rows");
		           	    	
		           	    }
		        
		           	    if(rows==1)
		           	    {
		           	    	sqltest=(" union all select 'WED2' AS rentaltype,0 doc_no ,0 cdw ,0 pai , 0 kmrest , 0 exkmrte , 0 rate, 0 cdw1 ,0 pai1 ,0 gps ,0 babyseater , "
		           	    			+ " 0 cooler ,0 oinschg ,0 chaufchg ,  0 chaufexchg,'0' exhrchg,0 gid ,0 'disclevel' ,0 startday, 0 starttime,0 endday, 0 endtime "
			    					+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
			    					+ "	left join my_user u on u.doc_no='"+userid+"' where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime<='"+outtime+"' and "
			    					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' "
			    					+ " union  all select 'WED3' AS rentaltype,0 doc_no ,0 cdw ,0 pai , 0 kmrest , 0 exkmrte , 0 rate, 0 cdw1 ,0 pai1 ,0 gps ,0 babyseater , "
		           	    			+ " 0 cooler ,0 oinschg ,0 chaufchg ,  0 chaufexchg,'0' exhrchg,0 gid ,0 'disclevel' ,0 startday, 0 starttime,0 endday, 0 endtime "
			    					+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
			    					+ "	left join my_user u on u.doc_no='"+userid+"' where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime<='"+outtime+"' and "
			    					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' ");
		           	    	
		           	    }
		           	 
		           	    if(rows==2)
		           	    {
		           	    	sqltest=(" union all select 'WED3' AS rentaltype,0 doc_no ,0 cdw ,0 pai , 0 kmrest , 0 exkmrte , 0 rate, 0 cdw1 ,0 pai1 ,0 gps ,0 babyseater , "
		           	    			+ " 0 cooler ,0 oinschg ,0 chaufchg ,  0 chaufexchg,'0' exhrchg,0 gid ,0 'disclevel',0 startday, 0 starttime,0 endday, 0 endtime  "
			    					+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
			    					+ "	left join my_user u on u.doc_no='"+userid+"' where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime<='"+outtime+"' and "
			    					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' ");
		           	    	
		           	    }
		           
		        	
		           	    	
		    			String sqltari=("select * from(select convert(trim(concat('WED',@i:=@i+1)),char(10)) AS rentaltype,m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater, "
		    					+ " m1.cooler,m1.oinschg,m1.chaufchg, m1.chaufexchg,convert(m1.exdaychg,char(15)) exhrchg,m1.gid,case when u.ulevel=1 then m1.ulevel1 when u.ulevel=2 then m1.ulevel2 when u.ulevel=3 then m1.ulevel3 else 0 end as 'disclevel', "
		    					+ " m1.cswkday startday, m1.cstime starttime,m1.cewkday endday, m1.cetime endtime "
		    					+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
		    					+ "	left join my_user u on u.doc_no='"+userid+"',(select @i:=0) i where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime<='"+outtime+"' and "
		    					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' order by m1.rowno)aa "+sqltest);
						
						
		//	System.out.println("----------"+sqltari);
	  
						ResultSet resultSet = stmtVeh6.executeQuery(sqltari);
						
						RESULTDATA=commonDAO.convertToJSON(resultSet);
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
		    
	    public  JSONArray tariffratereload(HttpSession session,String txtrentaldocno,String group,String tarifnew) throws SQLException {

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
					String sqlorderby="";
					String sqlselect="";
	            	if(tarifnew.equalsIgnoreCase("Slab") || tarifnew.equalsIgnoreCase("Package")){
	            		sqlorderby=" order by srno";
	            	}
	            	else {
	            		sqlorderby=" order by rstatus";
	            	}
	            	if(tarifnew.equalsIgnoreCase("Slab")){
	            		sqlselect+="slabfromday,slabtoday,slabrateperday,";
	            	}
	            	else if(tarifnew.equalsIgnoreCase("Package")){
	            		sqlselect+="packageblockday,packageblocktarif,packageextradaytarif,";
	            	}
					String  tarifsql=("select "+sqlselect+" rdocno,gid,rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg,st_day startday,st_time starttime,ed_day endday,ed_time endtime"
							+ " from gl_rtarif where rdocno='"+txtrentaldocno+"'"+sqlorderby);
					System.out.println("------------------------------"+tarifsql);
					
					ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
	    
	    
	    public   JSONArray mainSrearch(HttpSession session,String sclname,String smob,String rno,String flno,String sregno,String smra,String branch_chk) throws SQLException {

	    	 JSONArray RESULTDATA=new JSONArray();
	    	 
	    	 
	
	    	 
	    	 
	    	 
	    	 
	
	    	//System.out.println("name"+sclname);
	    	
	    	String sqltest="";
	    	
	    	if(!(sclname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+sclname+"%'";
	    	}
	    	if(!(smob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob like '%"+smob+"%'";
	    	}
	    	if(!(rno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and r.voc_no like '%"+rno+"%'";
	    	}
	    	if(!(flno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and r.fleet_no like '%"+flno+"%'";
	    	}
	    	if(!(sregno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and v.reg_no like '%"+sregno+"%'";
	    	}
	    	if(!(smra.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and r.mrano like '%"+smra+"%'";
	    	}
	    	 
	    	Connection conn=null;
	     
			try {
					 conn = connDAO.getMyConnection();
					 
					 
					 
			    	 if(branch_chk.equalsIgnoreCase("1"))  // WIB with in branch, WOB with out branch
			    	 {
			    		 Statement stmt1 = conn.createStatement ();
			    		 String str1Sql=("select 'WOB' checks,r.doc_no,r.voc_no,r.fleet_no,r.acno,r.cldocno,r.date,r.salid,r.delivery,r.chif,r.drid,r.addr,r.said, "
									+ " r.raid,round(r.okm) okm,r.odate,r.otime,r.ofuel,r.ochkid,r.ddate,r.dtime,r.tselect,r.tdocno,r.insex,r.invtype, "
									+ " r.addrchg,r.mrano,r.mrano mrnumber,r.pono,r.ofleet_no,v.reg_no,a.RefName,a.per_mob,t.gid from gl_ragmt r  "
									+ " left join gl_vehmaster v on v.fleet_no=r.fleet_no left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'  "
									+ "left join my_salm m on a.sal_id=m.doc_no left join gl_rtarif t on t.rdocno=r.doc_no where r.status=3  "
									+ "    " +sqltest+" group by doc_no"); 
			    		 
			    		// System.out.println("--1-str1Sql----"+str1Sql);
			    		 
			    		 ResultSet resultSet = stmt1.executeQuery (str1Sql);
							RESULTDATA=commonDAO.convertToJSON(resultSet);
							stmt1.close();
			    		 
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
			 			Statement stmt2 = conn.createStatement ();
						String str1Sql=("select 'WIB' checks,r.doc_no,r.voc_no,r.fleet_no,r.acno,r.cldocno,r.date,r.salid,r.delivery,r.chif,r.drid,r.addr,r.said, "
								+ " r.raid,round(r.okm) okm,r.odate,r.otime,r.ofuel,r.ochkid,r.ddate,r.dtime,r.tselect,r.tdocno,r.insex,r.invtype, "
								+ " r.addrchg,r.mrano,r.mrano mrnumber,r.pono,r.ofleet_no,v.reg_no,a.RefName,a.per_mob,t.gid from gl_ragmt r  "
								+ " left join gl_vehmaster v on v.fleet_no=r.fleet_no left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'  "
								+ "left join my_salm m on a.sal_id=m.doc_no left join gl_rtarif t on t.rdocno=r.doc_no where r.status=3 and "
								+ "   r.brhid='"+brnchid+"'  " +sqltest+" group by doc_no");
						// System.out.println("--2-str1Sql----"+str1Sql);
						ResultSet resultSet = stmt2.executeQuery (str1Sql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmt2.close(); 
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
/*
	   
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
	     	*/
	    	
	    
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    
	    	if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = commonDAO.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and (a.per_mob like '%"+mob+"%' or d.mobno like '%"+mob+"%')  ";
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
	        
	    	 Connection conn=null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh8 = conn.createStatement ();
	            	
					int method=0;
					
					String chk="select method  from gl_config where field_nme='Clientinvchk'";
					ResultSet rs=stmtVeh8.executeQuery(chk); 
					if(rs.next())
					{
						
						method=rs.getInt("method");
					}
					
					
					
					
					
			/*		String clsql= ("select distinct a.pcase,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(coalesce(a.address,''),'  ',coalesce(a.address2,'')) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ "left join gl_drdetails d on d.cldocno=a.cldocno where a.dtype='CRM' and a.status=3 " +sqltest);*/
					String clsql= ("select distinct "+method+" method, a.advance,a.invc_method,a.pcase,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(coalesce(a.address,''),'  ',coalesce(a.address2,'')) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ "left join gl_drdetails d on d.cldocno=a.cldocno and d.dtype=a.dtype where a.dtype='CRM' and a.status=3 " +sqltest);
				
					//System.out.println("-------------"+clsql);
						
		
					
					ResultSet resultSet = stmtVeh8.executeQuery(clsql);
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
		   
		    	 Connection conn=null;
				try {
					 conn = connDAO.getMyConnection();
					if(aa.equalsIgnoreCase("yes"))
					{
					
						
						Statement stmtVeh8 = conn.createStatement ();
		            	
						String vehsql="select plate.code_name platecode,v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc, "
								+ "	CASE WHEN m.FIN='0.000' THEN 'Level 0/8'  WHEN m.FIN='0.125' THEN 'Level 1/8' WHEN m.FIN='0.250' THEN 'Level 2/8' WHEN m.FIN='0.375' "
								+ "	THEN 'Level 3/8' WHEN m.FIN='0.500' THEN 'Level 4/8' WHEN m.FIN='0.625' THEN 'Level 5/8' "
								+ "	WHEN m.FIN='0.750' THEN 'Level 6/8' WHEN m.FIN='0.875' THEN 'Level 7/8' WHEN m.FIN='1.000' THEN 'Level 8/8' "
								+ "	 END as 'FIN',m.FIN hidfin,m.fleet_no ,m.kmin,c.doc_no,c.color,g.gname,g.doc_no gid from gl_vehmaster v "
								+ "	left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c "
								+ " on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_vehplate plate on v.pltid=plate.doc_no "
								+ "	where v.a_br="+brid+" and ins_exp >=current_date and v.statu <> 7 and   "
								+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and "
								+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','R') " +sqltest;
				//System.out.println("---------------"+vehsql);
						ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
						
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmtVeh8.close();
						
						
						
					}
					conn.close();
					 return RESULTDATA;
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				/*finally
				{
					conn.close();
				}*/
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }
		    
	   
	 
	    public  JSONArray getReplacedVehicle(String agmtno) throws SQLException { 
	      
	      
	        JSONArray ReplaceData=new JSONArray();
	       Connection conn = null;
	     
	     try {
	    	 conn = connDAO.getMyConnection();
	      Statement stmtreplace = conn.createStatement();
	       //agmtno=agmtno==null?"0":agmtno;
	             String strSql="select rep.ofleetno,rep.odate,rep.otime,rep.indate,rep.intime,rep.rfleetno infleetno,rep.doc_no repdoc,v.reg_no regnoin,veh.reg_no regnoout "
	             		+ " from gl_ragmt agmt left join  gl_vehreplace rep on agmt.doc_no=rep.rdocno left join gl_vehmaster v on v.fleet_no=rep.rfleetno  "
	             		+ " left join gl_vehmaster veh on veh.fleet_no=rep.ofleetno  where rep.status<>7 and rep.rtype='RAG' and agmt.doc_no='"+agmtno+"'  order by rep.doc_no DESC";
	             
	
	       
	       ResultSet rsreplace = stmtreplace.executeQuery(strSql);
	       ReplaceData=commonDAO.convertToJSON(rsreplace);
	       stmtreplace.close();
	       conn.close();
	     }

	     catch(Exception e){
	      e.printStackTrace();
	      //conn.close();stmtTarif.close();
	      conn.close();
	      return ReplaceData;
	        
	     }
	     //System.out.println("RESULTDATA=========>"+RESULTDATA);
	     
	     conn.close();
	        return ReplaceData;
	        
	    }
	    
	    
	    
	    public  ClsRentalAgmtNewBean getViewDetails(HttpSession session,int docNo) throws SQLException {
	    	
			
	    	ClsRentalAgmtNewBean RentalAgreementBean = new ClsRentalAgmtNewBean();
			Connection conn=null;
			try {
			  conn = connDAO.getMyConnection();
			Statement stmtCPV0 = conn.createStatement ();
			String branch = session.getAttribute("BRANCHID").toString();

			String strSql=("select coalesce(r.tariftype,'') tariftype,concat(r.ofleet_no,' (',vehcontract.reg_no,' - ',contractplate.code_name,')') contractvehicle,r.weekend,r.voc_no,if(r.clstatus=0,'Open',if(r.clstatus=1,CONCAT(DATE_FORMAT(racl.date,'%d-%m-%Y'),'  Close'),'Cancel')) clstatus,r.doc_no,r.fleet_no,r.desc1, "
					+ "	r.acno,r.cldocno,r.date,r.salid,r.delivery,r.chif,r.drid,r.addr,r.said,r.raid,round(r.okm) okm,round(r.delchg,2) delchg, "
					+ "	 r.odate,r.otime,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
					+ "	 THEN 'Level 2/8' WHEN r.ofuel='0.375' THEN 'Level 3/8' WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
					+ "	  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8'   END "
					+ "	  as 'ofuel',r.ofuel hidfuel, r.ochkid,r.ddate,r.dtime,r.tselect,r.tdocno,round(r.insex,2) insex,r.invtype,   "
					+ "	  round(r.addrchg,2) addrchg,r.mrano,r.pono,r.ofleet_no,r.locid, r.advchk,v.doc_no vdocno,v.fleet_no,  "
					+ "	  CONCAT('REG NO : ',coalesce(v.reg_no,''), ' , ', ' NAME : ',coalesce(v.FLNAME,''), ' , ' ,'GROUP : '  ,coalesce(g.gname,''), ' , ' ,'COLOR : ',coalesce(c.color,''),' , ','PLATE CODE : ',coalesce(plate.code_name,'')) as vehdetails, "
					+ "  v.a_loc,c.color,g.gid,a.cldocno,RefName , CONCAT('CONTACT PERSON : ',coalesce(a.contactperson,''), ' , ', ' MOB : ',coalesce(a.per_mob,''), ' , "
					+ "	 ' ,'EMAIL : '  ,coalesce(a.mail1,'') , ' , ' ,'ADDRESS : ',coalesce(a.address,''), ' , ' ,'TEL NO : ',coalesce(a.per_tel,'')) as clarress ,m.sal_name salman, "
					+ "	 d.sal_name drname,ra.sal_name ragnt,sa.sal_name sagnt,  ch.sal_name chackin,mv.din,mv.tin,round(mv.kmin) kmin,mv.fin   "
					+ "	 from gl_ragmt r left join  gl_vehmaster v on v.fleet_no=r.fleet_no left join my_color c  on v.clrid=c.doc_no  "
					+ "	 left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_vehplate plate on v.pltid=plate.doc_no left join my_acbook a on a.cldocno=r.cldocno   and  a.dtype='CRM'  "
					+ "	left join my_salm m on m.doc_no=r.salid  left join  my_salesman d on d.doc_no=r.drid and d.sal_type='DRV'  "
					+ "	left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA'   left join  "
					+ "	my_salesman ch on ch.doc_no=r.ochkid and ch.sal_type='CHK' left join gl_ragmtclosem racl on racl.agmtno=r.doc_no   left join   "
					+ " gl_vmove mv on mv.rdocno=r.doc_no and mv.rdtype='RAG' and mv.trancode='DL' and mv.repno=0 and mv.custno=0  and mv.exchng=0 "
					+ " and mv.doc_no=(select min(doc_no) from gl_vmove where  rdtype='RAG' and status='IN'   "
			       		+ " and trancode='DL'  and rdocno=r.doc_no and repno=0 and custno=0  and exchng=0 ) left join gl_vehmaster vehcontract on r.ofleet_no=vehcontract.fleet_no left join gl_vehplate contractplate on vehcontract.pltid=contractplate.doc_no where  r.doc_no='"+docNo+"' ");
			
		/*	String strSql=("select r.voc_no,if(r.clstatus=0,'Open',if(r.clstatus=1,CONCAT(DATE_FORMAT(racl.date,'%d-%m-%Y'),'  Close'),'Cancel')) clstatus,r.doc_no,r.fleet_no,r.desc1, "
					+ "	r.acno,r.cldocno,r.date,r.salid,r.delivery,r.chif,r.drid,r.addr,r.said,r.raid,round(r.okm) okm,round(r.delchg,2) delchg, "
					+ "	 r.odate,r.otime,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
					+ "	 THEN 'Level 2/8' WHEN r.ofuel='0.375' THEN 'Level 3/8' WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' "
					+ "	  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8'   END "
					+ "	  as 'ofuel',r.ofuel hidfuel, r.ochkid,r.ddate,r.dtime,r.tselect,r.tdocno,round(r.insex,2) insex,r.invtype,   "
					+ "	  round(r.addrchg,2) addrchg,r.mrano,r.pono,r.ofleet_no,r.locid, r.advchk,v.doc_no vdocno,v.fleet_no,  "
					+ "	  CONCAT('REG NO : ',coalesce(v.reg_no,''), ' , ', ' NAME : ',coalesce(v.FLNAME,''), ' , ' ,'GROUP : '  ,coalesce(g.gname,''), ' , ' ,'COLOR : ',coalesce(c.color,'')) as vehdetails, "
					+ "  v.a_loc,c.color,g.gid,a.cldocno,RefName , CONCAT('CONTACT PERSON : ',coalesce(a.contactperson,''), ' , ', ' MOB : ',coalesce(a.per_mob,''), ' , "
					+ "	 ' ,'EMAIL : '  ,coalesce(a.mail1,'') , ' , ' ,'ADDRESS : ',coalesce(a.address,''), ' , ' ,'TEL NO : ',coalesce(a.per_tel,'')) as clarress ,m.sal_name salman, "
					+ "	 d.sal_name drname,ra.sal_name ragnt,sa.sal_name sagnt,  ch.sal_name chackin,mv.din,mv.tin,round(mv.kmin) kmin,mv.fin   "
					+ "	 from gl_ragmt r left join  gl_vehmaster v on v.fleet_no=r.fleet_no left join my_color c  on v.clrid=c.doc_no  "
					+ "	 left join gl_vehgroup g on g.doc_no=v.vgrpid left join my_acbook a on a.cldocno=r.cldocno   and  a.dtype='CRM'  "
					+ "	left join my_salm m on m.doc_no=r.salid  left join  my_salesman d on d.doc_no=r.drid and d.sal_type='DRV'  "
					+ "	left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA'   left join  "
					+ "	my_salesman ch on ch.doc_no=r.ochkid and ch.sal_type='CHK' left join gl_ragmtclosem racl on racl.agmtno=r.doc_no   left join   "
					+ " gl_vmove mv on mv.rdocno=r.doc_no and mv.rdtype='RAG' and mv.trancode='DL' and mv.repno=0 where  r.doc_no="+docNo+" ");*/
		
			//System.out.println("sql"+strSql);
			 
			ResultSet resultSet = stmtCPV0.executeQuery(strSql);
	
  	
			while (resultSet.next()) {
				RentalAgreementBean.setMasterdoc_no(docNo);
				RentalAgreementBean.setDocno(resultSet.getString("voc_no"));
				//System.out.println("========================="+RentalAgreementBean.getTxtrentaldocno());
				RentalAgreementBean.setJqxRentalDate(resultSet.getString("date").toString());
				//fleet
				RentalAgreementBean.setTxtfleetno(resultSet.getString("fleet_no"));
				RentalAgreementBean.setVehdetails(resultSet.getString("vehdetails"));
				RentalAgreementBean.setHidcmbtarifnew(resultSet.getString("tariftype"));
				RentalAgreementBean.setCmbtarifnew(resultSet.getString("tariftype"));
				//client
				RentalAgreementBean.setTxtcusid(resultSet.getString("cldocno"));
				RentalAgreementBean.setClient_Name(resultSet.getString("RefName"));
				RentalAgreementBean.setRe_salman(resultSet.getString("salman"));
				RentalAgreementBean.setCusaddress(resultSet.getString("clarress"));
				//driver
				RentalAgreementBean.setAdditional_driver(resultSet.getInt("addr"));
				RentalAgreementBean.setAdidrvcharges(resultSet.getString("addrchg"));
				RentalAgreementBean.setDelivery_chk(resultSet.getInt("delivery"));
				RentalAgreementBean.setRadrivercheck(resultSet.getInt("chif"));
				RentalAgreementBean.setRadriverlist(resultSet.getString("drname"));
				
				// advance
				RentalAgreementBean.setAdvance_chkval(resultSet.getInt("advchk"));
				//sub tariff
				RentalAgreementBean.setRarenral_Agent(resultSet.getString("ragnt"));
				RentalAgreementBean.setRasales_Agent(resultSet.getString("sagnt"));
				
				//out
			   RentalAgreementBean.setJqxDateOut(resultSet.getString("odate").toString());
				RentalAgreementBean.setJqxTimeOut(resultSet.getString("otime"));
				RentalAgreementBean.setRe_Km(resultSet.getString("okm"));
				RentalAgreementBean.setRatariff_fuel(resultSet.getString("ofuel"));
				RentalAgreementBean.setHidvehfuel(resultSet.getString("hidfuel"));
				
				//due
				RentalAgreementBean.setJqxOnDate(resultSet.getString("ddate").toString());
				 RentalAgreementBean.setJqxOnTime(resultSet.getString("dtime"));
				 RentalAgreementBean.setRatariff_checkout(resultSet.getString("chackin"));
				//tariff main
				
				 RentalAgreementBean.setRatariffsystem(resultSet.getString("tselect"));
			     RentalAgreementBean.setRatariffdocno1(resultSet.getString("tdocno"));
				
				 RentalAgreementBean.setInvoice(resultSet.getString("invtype"));
				 RentalAgreementBean.setExcessinsur(resultSet.getString("insex"));
				//payment
			    RentalAgreementBean.setPayment_Mra(resultSet.getString("mrano"));
			   RentalAgreementBean.setPayment_PO(resultSet.getString("pono"));
				RentalAgreementBean.setPayment_Conveh(resultSet.getString("contractvehicle"));
				//
			
				RentalAgreementBean.setDel_chaufferid2(resultSet.getString("drid"));
				RentalAgreementBean.setDel_Driver(resultSet.getString("drname"));
				//
				RentalAgreementBean.setVehlocation(resultSet.getString("locid"));
				RentalAgreementBean.setDelcharges(resultSet.getString("delchg"));
				
				RentalAgreementBean.setRentalstatus(resultSet.getString("clstatus"));
				RentalAgreementBean.setWeekendval(resultSet.getInt("weekend"));
				
				// del
			
				RentalAgreementBean.setDel_KM(resultSet.getString("kmin"));
				//
				RentalAgreementBean.setDel_Fuel(resultSet.getString("fin"));
				
				
				RentalAgreementBean.setJqxDeliveryOut(resultSet.getString("din")==null?"":resultSet.getString("din"));
				
				
				RentalAgreementBean.setJqxDelTimeOut(resultSet.getString("tin"));
				RentalAgreementBean.setRentaldesc(resultSet.getString("desc1"));
				
				
				
			}
				
		
				
			stmtCPV0.close();
			conn.close();
			}
			catch(Exception e){
				
			e.printStackTrace();
			conn.close();
			}
			
			return RentalAgreementBean;
			}
	    
	  /*  if(rows==1)
   	    {
   	    	sqltest=(" union all select WED2 AS rentaltype,0 doc_no ,0 cdw ,0 pai , 0 kmrest , 0 exkmrte , 0 rate, 0 cdw1 ,0 pai1 ,0 gps ,0 babyseater , "
   	    			+ " 0 cooler ,0 oinschg ,0 chaufchg ,  0 chaufexchg,'0' exhrchg,0 gid ,0 'disclevel' "
					+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
					+ "	left join my_user u on u.doc_no='"+userid+"',(select @i:=0) i where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime>'"+outtime+"' and "
					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' "
					+ " union  all select WED3 AS rentaltype,0 doc_no ,0 cdw ,0 pai , 0 kmrest , 0 exkmrte , 0 rate, 0 cdw1 ,0 pai1 ,0 gps ,0 babyseater , "
   	    			+ " 0 cooler ,0 oinschg ,0 chaufchg ,  0 chaufexchg,'0' exhrchg,0 gid ,0 'disclevel' "
					+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
					+ "	left join my_user u on u.doc_no='"+userid+"',(select @i:=0) i where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime>'"+outtime+"' and "
					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' ");
   	    	
   	    }
   	 
   	    if(rows==2)
   	    {
   	    	sqltest=(" union all select WED3 AS rentaltype,0 doc_no ,0 cdw ,0 pai , 0 kmrest , 0 exkmrte , 0 rate, 0 cdw1 ,0 pai1 ,0 gps ,0 babyseater , "
   	    			+ " 0 cooler ,0 oinschg ,0 chaufchg ,  0 chaufexchg,'0' exhrchg,0 gid ,0 'disclevel' "
					+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
					+ "	left join my_user u on u.doc_no='"+userid+"',(select @i:=0) i where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime>'"+outtime+"' and "
					+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"' ");
   	    	
   	    }
   	 
	
   	    	
		String sqltari=("select convert(trim(concat('WED',@i:=@i+1)),char(10)) AS rentaltype,m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater, "
				+ " m1.cooler,m1.oinschg,m1.chaufchg, m1.chaufexchg,'0' exhrchg,m1.gid,0 'disclevel' "
				+ " from gl_tarifm m inner join gl_tarifcondn m1 on m.doc_no=m1.doc_no   "
				+ "	left join my_user u on u.doc_no='"+userid+"',(select @i:=0) i where DAYNAME('"+sqloutdate+"')=m1.cswkday and m1.cstime>'"+outtime+"' and "
				+ " m.tariftype='Weekend' and  m1.gid='"+groupname+"'  and  m.doc_no='"+ratariffdocno+"'  "+sqltest);
	    
*/
	  public  ClsRentalAgmtNewBean getPrint(int docno) throws SQLException {
		  ClsRentalAgmtNewBean bean = new ClsRentalAgmtNewBean();
	    	 Connection conn =null;
	      try {
	    	   conn = connDAO.getMyConnection();
	       Statement stmtinvoice = conn.createStatement();
	       
	       double totaldays=0; // this for calculate total rate
	       
	       String strSql="";
	   
/*	      strSql=("select r.voc_no,round(r.insex,2) insex,if(r.clstatus=0,'Open','Closed') clstatus, r.doc_no,round(r.addrchg,2) addrchg,r.mrano,round(r.okm) okm,"
		       		+ " CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
		       		+ "THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN "
		       		+ "r.ofuel='0.625' THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' "
		       		+ "WHEN r.ofuel='1.000' THEN 'Level 8/8' 	END as 'ofuel' ,DATE_FORMAT(r.odate,'%d-%m-%Y')odate,r.otime,a.refname,  "
		       		+ "a.address,a.per_mob,a.mail1,br.branchname,concat(v.reg_no,' ',p.code_name) reg_no,v.flname,g.gname,mo.vtype,"
		       		+ "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as rate, (select  round(cdw,2)+round(cdw1,2) "
		       		+ "  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cdw , (select round(gps,2)+round(babyseater,2)+round(cooler,2) "
		       		+ "	 from gl_rtarif where  rdocno="+docno+" and rstatus=7) as accessories, "
		       		+ "  (select round(kmrest)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raextrakm, "
		       		+ "(select round(exkmrte,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raexxtakmchg,"
		       				+ "(select rentaltype  from gl_rtarif where  rdocno="+docno+" and rstatus=5) as rentaltypes, "
		       				+ " CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
		       		+ "	 WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' "
		       		+ "	THEN 'Level 3/8'	WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
		       		+ "	 WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
		       		+ "	  THEN 'Level 8/8' 	 END as 'infuel',round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') indate,rc.intime,co.color,yo.yom "
		       		+ "	  from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
		       		+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
		       		+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid   left join gl_vehmodel mo on mo.doc_no=v.vmodid 	   			        "
		       		+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
		       		+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
		       		+ " left join my_color co on co.doc_no=v.clrid   where r.doc_no="+docno+" group by r.doc_no");*/
	       //pai,chaufchg
	     
	       
	       // getting total in cosmo print
	       double cosmoscdw=0.0,cosmocdw=0.0,cosmopai=0.0,cosmodelchg=0.0,cosmorate=0.0;
	      strSql=("select DATE_FORMAT(r.ddate,'%d-%m-%Y') ddate, dtime, ra.sal_name ragnt,sa.sal_name sagnt, sm.sal_name ,   round(coalesce(r.delchg,0),2) delchg,a.per_tel,if(a.ser_default=1,if(g1.method=1,round(g1.value,2),0),round(per_salikrate,2)) salikcharge, \r\n" 
	    		    + "    if(a.ser_default=1,round(g2.value,2),round(per_trafficharge,2)) trafficcharge, \r\n"  
	      		    + "     4+if(a.ser_default=1,if(g1.method=1,round(g1.value,2),0),round(per_salikrate,2)) saliktotal,concat(u.authid,' ',p.code_name,' ',v.reg_no) reg_noval,r.voc_no,round(r.insex,2) insex,if(r.clstatus=0,'Open','Closed') clstatus,a.per_tel,a.fax1, r.doc_no,round(r.addrchg,2) addrchg,r.mrano,round(r.okm) okm,"
		       		+ " CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
		       		+ "THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN "
		       		+ "r.ofuel='0.625' THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' "
		       		+ "WHEN r.ofuel='1.000' THEN 'Level 8/8' 	END as 'ofuel' ,DATE_FORMAT(r.odate,'%d-%m-%Y')odate,r.otime,a.refname,  "
		       		+ "a.address,a.per_mob,a.mail1,br.branchname,concat(v.reg_no,' ',p.code_name) reg_no,v.flname,g.gname,mo.vtype,"
		       		+ "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as rate, (select  round(cdw,2)+round(cdw1,2) "
		       		+ "  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cdw , (select round(gps,2)+round(babyseater,2)+round(cooler,2) "
		       		+ "	 from gl_rtarif where  rdocno="+docno+" and rstatus=7) as accessories,"
		       				+ " (select round(cdw1,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as scdw , "
		       					+ " (select round(cdw1,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as vmd , "
		       		+ "  (select round(kmrest,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raextrakm, "
		       		+ "(select round(exkmrte,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raexxtakmchg,"
		       		+ "(select round(pai,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as pai,"
		       		+ "(select round(chaufchg,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as chaufchg,"
		       				+ "(select rentaltype  from gl_rtarif where  rdocno="+docno+" and rstatus=5) as rentaltypes, "
		       				+ " CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
		       		+ "	 WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' "
		       		+ "	THEN 'Level 3/8'	WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
		       		+ "	 WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
		       		+ "	  THEN 'Level 8/8' 	 END as 'infuel',round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') indate,rc.intime,co.color,yo.yom "
		       		+ "	  from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
		       		+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
		       		+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA' "
		       		+ " left join gl_config g1 on g1.field_nme='saliksrv'\r\n" + 
		       		"    left join gl_config g2 on g2.field_nme='trafficsrv'    left join gl_vehmodel mo on mo.doc_no=v.vmodid  left join gl_vehauth u on u.doc_no=v.authid	   			        "
		       		+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
		       		+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
		       		+ " left join my_color co on co.doc_no=v.clrid  left join my_salm sm on sm.doc_no=r.salid left join gl_vehbrand brd on v.brdid=brd.doc_no "+
		       		" left join my_salesman checkout on (r.ochkid=checkout.doc_no and checkout.sal_type='CHK') left join my_salesman checkin on "+
		       		" (rc.chkinid=checkin.doc_no and checkin.sal_type='CHK') left join gl_rpyt pyt on (r.doc_no=pyt.rdocno) where r.doc_no="+docno+" group by r.doc_no");
	      
	      
	      
	      
	     // System.out.println("---------"+strSql);
	      
	      
	       
		      
	 
	       ResultSet resultSet = stmtinvoice.executeQuery(strSql); 
	       
	     
	       while(resultSet.next()){
	    	  // bean.setLbmasterdate(resultSet.getString("date"));
	    	   
	    	   // cldatails
	    	   
	    	  // getDuedate getSalagent getRaagent
	    	    
	    	   bean.setDuedate(resultSet.getString("ddate"));
		//mm
		  bean.setDuetime(resultSet.getString("dtime"));

	    	   bean.setRaagent(resultSet.getString("ragnt"));
	    	   bean.setSalagent(resultSet.getString("sagnt"));
	    	  
	    	   
	    	   
 
	    	   bean.setSalikcharge(resultSet.getString("salikcharge"));
	    	   bean.setTrafficcharge(resultSet.getString("trafficcharge"));
	    	   bean.setTotalsalikandtraffic(resultSet.getString("saliktotal"));
	    	   
	    	    bean.setClname(resultSet.getString("refname"));
	    	    bean.setCladdress(resultSet.getString("address"));
	    	    bean.setClemail(resultSet.getString("mail1"));
	    	    bean.setClmobno(resultSet.getString("per_mob"));
		//mm
		   bean.setSalname(resultSet.getString("sal_name"));
	    	    
	    	    bean.setLdllandno(resultSet.getString("per_tel"));
	    	    
	    	    //upper
	    	   
	    	    bean.setMrano(resultSet.getString("mrano"));
	    	    bean.setRentaldoc(resultSet.getString("voc_no"));
	    	    
	    	    
	    	//    bean.setLbfueltype(resultSet.getString("fueltype"));
	    	 //   bean.setLbmodel(resultSet.getString("vtype"));
	 
	    	    
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
	    	    
	    	    
	    	    bean.setRasupercdw(resultSet.getString("scdw"));
	    	    bean.setRavmd(resultSet.getString("vmd"));
	    	    
	    	    
	    	    
	    	// in details
	    	    
		    	   bean.setColdates(resultSet.getString("indate"));
		    	   bean.setColtimes(resultSet.getString("intime"));
		    	   bean.setColkmins(resultSet.getString("inkm"));
		    	   bean.setColfuels(resultSet.getString("infuel"));
	    	    
	    	   // bean.setKmused(resultSet.getString("kmused"));
	    	   // bean.setNoofdays(resultSet.getString("noofdays"));
	    	     
	    	   
	    	  //  bean.setPertel(resultSet.getString("per_tel"));
	    	  //  bean.setFaxno(resultSet.getString("fax1"));
	    	         
	    	    
	    	    
	    	    
	    	    bean.setOutdetails("Delivered");
	    	    
	    	    bean.setColdetails("Collected");
	    	    
	    	  //  setIndetails,setColdetails
	    	    
	    	  
	    	    bean.setRastatus(resultSet.getString("clstatus"));
	    	    bean.setRafuelout(resultSet.getString("ofuel"));
	    	   //
	    	    
	    	   bean.setRayom(resultSet.getString("yom"));
	    	   bean.setRacolor(resultSet.getString("color")) ;
	    	   
	    	   
	    	   //setRaextrakm,setRaexxtakmchg
	    	   
	    	   bean.setRaextrakm(resultSet.getString("raextrakm"));
	    	   bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg"));
	    	   bean.setRarenttypes(resultSet.getString("rentaltypes"));
	    	 
	    	   //pai,chaufchg
	    	   bean.setLblpai(resultSet.getString("pai"));
	    	   bean.setLaldelcharge(resultSet.getString("delchg"));
	    	   bean.setLblchafcharge(resultSet.getString("chaufchg"));
	    	   
	    	//   getLblpai() ,  getLaldelcharge() getLblchafcharge()
	    	   
	    	   
	    	   if(resultSet.getString("cdw").equalsIgnoreCase("0.00"))
	    			   {
	    		   bean.setExcessinsu(resultSet.getString("insex")); 
	    	 
	    			   }
	    	   else
	    	   {
	    		    
	    		   bean.setExcessinsu("0.00");   
	    	   }
	    	   
	// driven
	    	   //  setLblpertel setLblfaxno   setLbldobdate setLblradlno setDrivravehregno 
	   	    bean.setLblclname(resultSet.getString("refname"));
    	    bean.setLblcladdress(resultSet.getString("address"));
    	    bean.setLblclemail(resultSet.getString("mail1"));
    	    bean.setLblclmobno(resultSet.getString("per_mob"));   
	    	   
    	    bean.setDrivravehregno(resultSet.getString("reg_noval"));   
    	    bean.setLblpertel(resultSet.getString("per_tel"));
	    	 bean.setLblfaxno(resultSet.getString("fax1"));
	    	 
	    	 
	    	 
	    	// setLbldobdate    setLblradlno   setLbcardno setLbexpcarddate 
	    	 
	    	  
	    	 //For getting total in cosmo print
	    	 cosmoscdw=resultSet.getDouble("scdw");
	    	 cosmocdw=resultSet.getDouble("cdw");
	    	 cosmopai=resultSet.getDouble("delchg");
	    	 cosmodelchg=resultSet.getDouble("delchg");
	    	 cosmorate=resultSet.getDouble("rate");
	    	 
	    	
	       }
	       
	       
	       String strcosmo="select (select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as rate,"+
	    		  " round(coalesce(r.delchg,0),2) delchg,(select round(pai,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as pai,"+
	    		   " (select  round(cdw,2)+round(cdw1,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cdw,"+
	    		  " (select round(cdw1,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as scdw,round(rc.colchg,2) cosmocollectchg,"+
	    		  " (select round(gps,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cosmogps,"+
	    		  " (select round(babyseater,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cosmobabyseater,"+
	    		  " (select round(cooler,2) from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cosmocooler,"+
	    		  " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno=12 and rstatus=1) cosmokmrestrictdaily,"+
	    		  " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno=12 and rstatus=2) cosmokmrestrictweekly,"+
	    		  " (select round(kmrest,2) kmrest  from gl_rtarif where  rdocno=12 and rstatus=3) cosmokmrestrictmonthly,"+
	    		  " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno=12 and rstatus=1) cosmoexkmratedaily,"+
	    		  " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno=12 and rstatus=2) cosmoexkmrateweekly,"+
	    		  " (select round(exkmrte,2) exkmrte  from gl_rtarif where  rdocno=12 and rstatus=3) cosmoexkmratemonthly,"+
	    		  " if(pyt.payid=1,pyt.amount,'') cosmoadvance,if(pyt.payid=2,pyt.amount,'') cosmosecurity,if(pyt.mode='CARD',pyt.cardno,'') cosmocreditcardno,"+
	    		  " if(pyt.mode='CARD',pyt.expdate,'') cosmocreditcarddate,rc.infuel cosmofuelin,rc.inkm cosmokmin,checkin.sal_name cosmocheckin,checkout.sal_name "+
	    		  " cosmocheckout,v.fleet_no cosmofleetno,brd.brand_name cosmobrand,d.issfrm cosmoissuedat,coalesce(round(r.insex,2),'') insurexcess from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
		       		+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
		       		+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid left join  my_salesman sa on sa.doc_no=r.said and sa.sal_type='SLA'  left join  my_salesman ra on ra.doc_no=r.raid and  ra.sal_type='RLA' "
		       		+ " left join gl_config g1 on g1.field_nme='saliksrv'\r\n" + 
		       		"    left join gl_config g2 on g2.field_nme='trafficsrv'    left join gl_vehmodel mo on mo.doc_no=v.vmodid  left join gl_vehauth u on u.doc_no=v.authid	   			        "
		       		+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
		       		+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
		       		+ " left join my_color co on co.doc_no=v.clrid  left join my_salm sm on sm.doc_no=r.salid left join gl_vehbrand brd on v.brdid=brd.doc_no "+
		       		" left join my_salesman checkout on (r.ochkid=checkout.doc_no and checkout.sal_type='CHK') left join my_salesman checkin on "+
		       		" (rc.chkinid=checkin.doc_no and checkin.sal_type='CHK') left join gl_rpyt pyt on (r.doc_no=pyt.rdocno) where r.doc_no="+docno+" group by r.doc_no";
	       System.out.println("Cosmo Sql:"+strcosmo);
	       Statement stmtcosmo=conn.createStatement();
	       ResultSet rscosmo=stmtcosmo.executeQuery(strcosmo);
	       while(rscosmo.next()){
	    	   //data for cosmo print

		    	 bean.setLblcosmokmrestrictdaily(rscosmo.getString("cosmokmrestrictdaily"));
		    	 bean.setLblcosmokmrestrictweekly(rscosmo.getString("cosmokmrestrictweekly"));
		    	 bean.setLblcosmokmrestrictmonthly(rscosmo.getString("cosmokmrestrictmonthly"));
		    	 bean.setLblcosmoexkmratedaily(rscosmo.getString("cosmoexkmratedaily"));
		    	 bean.setLblcosmoexkmrateweekly(rscosmo.getString("cosmoexkmrateweekly"));
		    	 bean.setLblcosmoexkmratemonthly(rscosmo.getString("cosmoexkmratemonthly"));
		    	 bean.setLblcosmoadvance(rscosmo.getString("cosmoadvance"));
		    	 bean.setLblcosmosecurity(rscosmo.getString("cosmosecurity"));
		    	 bean.setLblcosmocreditcardno(rscosmo.getString("cosmocreditcardno"));
		    	 bean.setLblcosmocreditvaliddate(rscosmo.getString("cosmocreditcarddate"));
		    	 bean.setLblcosmofuelin(commonDAO.checkFuelName(conn, rscosmo.getString("cosmofuelin")));
		    	 bean.setLblcosmokmin(rscosmo.getString("cosmokmin"));
		    	 bean.setLblcosmocheckin(rscosmo.getString("cosmocheckin"));
		    	 bean.setLblcosmocheckout(rscosmo.getString("cosmocheckout"));
		    	 bean.setLblcosmofleetno(rscosmo.getString("cosmofleetno"));
		    	 bean.setLblcosmofleetbrand(rscosmo.getString("cosmobrand"));
		    	 bean.setLblcosmoissuedat(rscosmo.getString("cosmoissuedat"));
		    	 bean.setLblcosmogps(rscosmo.getString("cosmogps"));
		    	 bean.setLblcosmobabyseater(rscosmo.getString("cosmobabyseater"));
		    	 bean.setLblcosmocollectchg(rscosmo.getString("cosmocollectchg"));
		    	 bean.setLblcosmoexcessamt(rscosmo.getString("insurexcess"));
		    	 double cosmototaltemp=cosmoscdw+cosmocdw+cosmopai+cosmodelchg+cosmorate+rscosmo.getDouble("cosmogps")+rscosmo.getDouble("cosmobabyseater")+rscosmo.getDouble("cosmocollectchg");
		    	 bean.setLblcosmototal(cosmototaltemp+"");
	       }
	       
	       
	       
	       
	       
	       
	       stmtinvoice.close();
	       
	       Statement stmtinvoice66 = conn.createStatement();
	       Statement stmtcosmodriver=conn.createStatement();
	       String strcosmodriver="select name,mobno,dlno,DATE_FORMAT(d.led,'%d-%m-%Y') led,passport_no from gl_drdetails d left join gl_rdriver rr  "
	       		+ " on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno="+docno+") "
	       		+ " and (select max(srno) srno from gl_rdriver  where rdocno="+docno+") and  rr.status=3  limit 2";
	       System.out.println(strcosmodriver);
	       ResultSet rscosmodriver=stmtcosmodriver.executeQuery(strcosmodriver);
	       int drivercount=0;
	       while(rscosmodriver.next()){
	    	   if(drivercount>0){
	    	   bean.setLblcosmodrivername(rscosmodriver.getString("name"));
	    	   bean.setLblcosmodrivermobile(rscosmodriver.getString("mobno"));
	    	   bean.setLblcosmodriverlicense(rscosmodriver.getString("dlno"));
	    	   bean.setLblcosmodrivervalidupto(rscosmodriver.getString("led"));
	    	   bean.setLblcosmodriverpassport(rscosmodriver.getString("passport_no"));
	    	   }
	    	   drivercount++;
	    	   }
	       String  maindr=" select coalesce(d.ltype,'') licensetype,coalesce(visano) visano,coalesce(d.nation,'') nation,coalesce(issfrm,'') issuedby,coalesce(DATE_FORMAT(d.issdate,'%d-%m-%Y'),'') issuedfrom,"+
				" d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') led,if(d.PASSPORT_NO='0','',d.PASSPORT_NO) "
	       		+ " PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp from gl_drdetails d left join gl_rdriver rr  "
	       		+ " on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno between(select min(srno) srno from gl_rdriver  where rdocno="+docno+") "
	       		+ " and (select max(srno) srno from gl_rdriver  where rdocno="+docno+") and  rr.status=3  limit 3 ";
	     // System.out.println("---------maindr------"+maindr);
	       
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
		    	   bean.setLblnation(resultmain.getString("nation"));
		    	    bean.setLblissby(resultmain.getString("licensetype"));
					bean.setLblpassissued(resultmain.getString("issuedby"));
		    	    bean.setLblissfromdate(resultmain.getString("issuedfrom"));
		    	    bean.setLblidno(resultmain.getString("visano"));
		    	    //drin
		    	    bean.setLbldobdate(resultmain.getString("dob"));  
		    	    bean.setLblradlno(resultmain.getString("dlno"));  
	    	    
	    	   }
	    	   
	    	   if(i==1)
	    	   {
	    		   bean.setAdddrname1(resultmain.getString("drname"));
		    	   bean.setAddlicno1(resultmain.getString("dlno"));
		    	   bean.setLbladdpassno1(resultmain.getString("passport_no"));
		    	   bean.setExpdate1(resultmain.getString("led"));
		    	   bean.setLbladdpassexp1(resultmain.getString("pass_exp"));
		    	   bean.setAdddob1(resultmain.getString("dob"));
		    	   bean.setLbladdnation1(resultmain.getString("nation"));
	    		   bean.setLbladdissby1(resultmain.getString("licensetype"));
	    		   bean.setLbladdpassissued1(resultmain.getString("issuedby"));
	    		   bean.setLbladdissfrom1(resultmain.getString("issuedfrom"));
	    		   bean.setLbladdid1(resultmain.getString("visano"));
	    		   
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
	        
     /*  Statement stmtinvoice4 = conn.createStatement();
	       
	       
	 String  maindr=" select d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') "
	 		+ "led,if(d.PASSPORT_NO='0','',d.PASSPORT_NO) PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp from gl_drdetails d left join gl_rdriver rr on rr.drid=d.dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno) from gl_rdriver where rdocno="+docno+") group by rr.rdocno ";
	 
	 System.out.println("-----------"+maindr);
	 
	 ResultSet resultmain = stmtinvoice4.executeQuery(maindr); 
	       
	       while(resultmain.next()){
	    	   
	    	    bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	   
	    	    //drin
	    	    bean.setLbldobdate(resultmain.getString("dob"));  
	    	    bean.setLblradlno(resultmain.getString("dlno"));  
	    
	    	   
	       }
	       stmtinvoice4.close();
	        
	       
	      
	       
	       
	       Statement stmtinvoice1 = conn.createStatement();
	       
 
	 String  drone="select dr.name name1,dr.dlno licno1,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob1,DATE_FORMAT(dr.led,'%d-%m-%Y') led1 from gl_drdetails dr left join gl_rdriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+1 from gl_rdriver where rdocno="+docno+")";
	 
	 ResultSet resultone = stmtinvoice1.executeQuery(drone); 
	       
	       while(resultone.next()){
	    	   
	    	   bean.setAdddrname1(resultone.getString("name1"));
	    	 
	    	   bean.setAddlicno1(resultone.getString("licno1"));
	    	  
	    	   bean.setExpdate1(resultone.getString("led1"));
	    	
	    	   bean.setAdddob1(resultone.getString("dob1"));
	    	  
	    	   
	       }
	       stmtinvoice1.close();
	     
	   	
	    Statement stmtinvoice2 = conn.createStatement ();
	    String  drtwo="select dr.name name2,dr.dlno licno2,DATE_FORMAT(dr.dob,'%d-%m-%Y') dob2,DATE_FORMAT(dr.led,'%d-%m-%Y') led2 from gl_drdetails dr left join gl_rdriver rr on rr.drid=dr_id where rr.rdocno="+docno+" and rr.srno=(select MIN(srno)+2 from gl_rdriver where rdocno="+docno+")";
	 
ResultSet resulttwo = stmtinvoice2.executeQuery(drtwo); 
	       
	       while(resulttwo.next()){
	    	   
	    	 
	    	   bean.setAdddrname2(resulttwo.getString("name2"));
	    	  
	    	   bean.setAddlicno2(resulttwo.getString("licno2"));
	    	 
	    	   bean.setExpdate2(resulttwo.getString("led2"));
	    	  
	    	   bean.setAdddob2(resulttwo.getString("dob2"));
	    	  
	    	   
	       } 
	       stmtinvoice2.close();
	
	       */
	       
	       
	       
	       Statement stmtinvoice51 = conn.createStatement();
	      
	 String  sql011="select if(aa.defaultcard=1,aa.cardno,cardno) cardno,if(aa.defaultcard=1,DATE_FORMAT(aa.exp_date,'%d-%m-%Y'),DATE_FORMAT(exp_date,'%d-%m-%Y')) exp_date,"
	 		+ " if(aa.defaultcard=1,aa.defaultcard,defaultcard) defaultcard from "
	 		+ " (SELECT cardno,exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') "
	 		+ " and sr_no=(select sr_no from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"')and defaultcard=1)) aa "
	 		+ " union all (SELECT cardno,DATE_FORMAT(exp_date,'%d-%m-%Y') exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') and "
	 		+ "sr_no=(select min(sr_no) from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') and defaultcard=0) ) limit 1 ;";
	 
	 //System.out.println("----sql011------"+sql011);
	 
	 ResultSet ress1 = stmtinvoice51.executeQuery(sql011); 
	   
	       while(ress1.next()){
	    	   bean.setLbexpcarddate(ress1.getString("exp_date"));
	    	   bean.setLbcardno(ress1.getString("cardno"));
	    	   //setLbcardno setLbexpcarddate  
	                   }
	    
	       stmtinvoice51.close();
	       
	       
	       
	       
	       Statement stmtinvoice10 = conn.createStatement ();
		   /* String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_ragmt r  "
		    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
		    

		    
		    String  companysql="select coalesce(c.tel2,'') tel2,coalesce(c.email,'') email,coalesce(c.web,'') web,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_ragmt r inner join my_brch b on  "
		    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
		    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no="+docno+" ";
		    
		    
		 //   System.out.println("----------"+companysql);
		    

	         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
			   bean.setLbltel1(resultsetcompany.getString("tel"));
		    	   bean.setLbltel2(resultsetcompany.getString("tel2"));
		    	   bean.setLblcompmail(resultsetcompany.getString("email"));
		    	   bean.setLblcompwebsite(resultsetcompany.getString("web"));
		    	   bean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   bean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   bean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   bean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   bean.setFax(resultsetcompany.getString("fax"));
		    	   bean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
		       
		    
		
		       Statement stmttatal = conn.createStatement ();
			    String  totalsql="select if(bb.inv-aa.total=0,'',bb.inv-aa.total) balance,if(aa.total=0,'',aa.total) total,if(bb.inv=0,'',bb.inv) inv from ((select coalesce(round(sum(dramount),2),0) total from my_jvtran where rtype='RAG' and rdocno="+docno+"   and dtype='CRV' and id=1)  aa, "
			    		+ "(select coalesce(round(sum(dramount),2),0) inv from my_jvtran where rtype='RAG' and rdocno="+docno+"   and dtype='INV' and id=1) bb);  ";
			//	System.out.println("======="+totalsql);
		         ResultSet restotal = stmttatal.executeQuery(totalsql); 
		        
			       
			       while(restotal.next()){
			 
			    	   bean.setTotalpaid(restotal.getString("total"));
			    	   
			    	   bean.setInvamount(restotal.getString("inv"));
			    	   bean.setBalance(restotal.getString("balance"));
			    	   
			       } 
			       stmttatal.close();
			    
			   	
			       Statement delstmt = conn.createStatement ();
			       String  delsql="select DATE_FORMAT(v.din,'%d-%m-%Y') din, v.tin tin, round(v.kmin) kmin,  "
				       		+ " CASE WHEN v.fin='0.000'   THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' "
				       		+ "  WHEN   v.fin='0.375' THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' "
				       		+ "    WHEN v.fin='0.750' THEN 'Level 6/8' WHEN v.fin='0.875' THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' "
				       		+ "        END as 'fin' from gl_ragmt r inner join gl_vmove v on v.rdocno=r.doc_no and v.rdtype='RAG' and v.status='IN' "
				       		+ "           and v.trancode='DL'  and v.doc_no=(select min(doc_no) from gl_vmove where  rdtype='RAG' and status='IN'   "
				       		+ " and trancode='DL'  and rdocno=r.doc_no and repno=0 and custno=0 and exchng=0 )    where r.delstatus=1 and r.doc_no="+docno+"  and v.repno=0 and v.custno=0 and v.exchng=0";
				       
			       
			         ResultSet rsdel = delstmt.executeQuery(delsql); 
			        
				       
				       while(rsdel.next()){
				    	   
				    	   bean.setOutdetails("Out :");
				    	   bean.setDeldetailss("Delivered :");
				    	    
				    	     
				 
				    	   bean.setDeldates(rsdel.getString("din"));
				    	   
				    	   bean.setDeltimes(rsdel.getString("tin"));
				    	   bean.setDelkmins(rsdel.getString("kmin"));
				    	   bean.setDelfuels(rsdel.getString("fin"));
				    	   
				    	   
				    	  
				    	   
				       } 
				       rsdel.close();
				       
					   	
				       Statement colstmt = conn.createStatement ();
				       String  colsql="select DATE_FORMAT(v.dout,'%d-%m-%Y') din, v.tout tin, round(v.kmout) kmin, CASE WHEN v.fout='0.000' THEN 'Level 0/8' WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250' "
					       		+ "THEN 'Level 2/8' WHEN v.fout='0.375' THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN "
					       		+ "v.fout='0.625' THEN 'Level 5/8'  WHEN v.fout='0.750' THEN 'Level 6/8' WHEN v.fout='0.875' THEN "
					       		+ "'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8'  END as 'fin' from gl_ragmt r inner join gl_vmove v on v.rdocno=r.doc_no "
					       		+ "and v.rdtype='RAG' and v.status='IN' and trancode='DL' inner join gl_ragmtclosem col on col.agmtno=r.doc_no "
					       		+ " where col.colstatus=1 and r.doc_no="+docno+"  and v.doc_no =(select max(doc_no) from gl_vmove where rdocno="+docno+" "
					       		+ "and rdtype='RAG' and status='IN' and trancode='DL' and repno=0 and  custno=0 and exchng=0) ";
				 
				         ResultSet rscol = colstmt.executeQuery(colsql); 
				        
					       
					       while(rscol.next()){
					 
					    	 	 bean.setIndetails("Collected :");
								    
							     bean.setColdetails("In :");
						    	
					            
						    	   bean.setInkm(rscol.getString("kmin"));
						    	    bean.setInfuel(rscol.getString("fin"));
						    	    bean.setIndate(rscol.getString("din"));
						    	    bean.setIntime(rscol.getString("tin"));
						    	       
					    	   
					    	  
					    	   
					       } 
					       rscol.close();
					       
					       
					       
					       
					       
					       
					       Statement rstmt = conn.createStatement ();
					       String  rstmtsql="select if(cardno='0','',cardno) cardno,coalesce(expdate,'') expdate,if(acode='0','',acode) acode,round(amount,2) amount from gl_rpyt  where payid=2 and rdocno='"+docno+"' ";
					 
					         ResultSet rsp = rstmt.executeQuery(rstmtsql); 
					      //   setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),
						       
						       while(rsp.next()){
						 
						    	 
							    	   bean.setSecuritycardno(rsp.getString("cardno"));
							    	    bean.setSecurityexpdate(rsp.getString("expdate"));
							    	    bean.setSecuritypreauthno(rsp.getString("acode"));
							    	    bean.setSecuritypreauthamt(rsp.getString("amount"));
							    	       
						    	   
						    	  
						    	   
						       } 
						       rsp.close();
						       
						       
						       Statement rstmt2 = conn.createStatement ();
						       String  rstmtsql2="select DATEDIFF(r.ddate,coalesce(mv.din,r.odate)) totaldays from gl_ragmt r left join "
						       		+ " gl_vmove mv on mv.rdocno=r.doc_no and mv.rdtype='RAG' and mv.trancode='DL' and mv.repno=0 and mv.custno=0  and mv.exchng=0 \r\n" + 
						       		" where r.doc_no='"+docno+"' ";
						// System.out.println("1========"+rstmtsql2);
						         ResultSet rsp2 = rstmt2.executeQuery(rstmtsql2); 
						      //   setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),
							       
							       while(rsp2.next()){
							 
							    	   totaldays=rsp2.getDouble("totaldays");
								    	  
								    	    
							    	   
							    	  
							    	   
							       } 
							       rsp2.close();
							       
						       
						       
						       
						   	double paidtotalamt=0;
						       Statement rstmt1 = conn.createStatement ();
						       String  rstmtsql1="select amount from gl_rpyt  where payid=1 and rdocno='"+docno+"' ";
						 
						         ResultSet rsp1 = rstmt1.executeQuery(rstmtsql1); 
						      //   setSecuritycardno(),setSecurityexpdate(),setSecuritypreauthno(),setSecuritypreauthamt(),
							       
							       while(rsp1.next()){
							 
							    	 
							    	   paidtotalamt=(rsp1.getDouble("amount"));
								    	
							    	   
							       } 
							       rsp1.close();
						  
							 
							 
								double tariftotal=0,cdwtotal=0,accsssorytotal=0,deltotal=0;
								
								double totalamt=0;
								 
								double balamount=0;
								String rentaltype=bean.getRarenttypes();
								
								double divval=1;
								if(rentaltype.equalsIgnoreCase("Monthly"))
									
								{
									
									if(totaldays<=30)
							    	{
							    		totaldays=1;
							    		divval=1;
							    	
							    		
							    	}
									else
									{
										divval=30;
									}
									
								}
								else if(rentaltype.equalsIgnoreCase("Weekly"))
								{
									
									if(totaldays<=7)
							    	{
							    		totaldays=1;
							    		divval=1;
							    	}else
							    	{
							    		divval=7;
							    	}
							    	   
									
								}
								else
								{
									if(totaldays<=0)
							    	{
							    		totaldays=1;
							    		divval=1;
							    	}
									else
									{
										divval=1;
									}
									
								}
							 
								//System.out.println("divval======"+divval);
								
								
								
								//System.out.println("-----totaldays--="+totaldays);
								DecimalFormat df=new DecimalFormat("0.00");
								tariftotal=(Double.parseDouble(bean.getTariff())*totaldays)/divval;
								cdwtotal=(Double.parseDouble(bean.getRacdwscdw())*totaldays)/divval; 	   
								accsssorytotal=(Double.parseDouble(bean.getRaaccessory())*totaldays)/divval;
								deltotal=(Double.parseDouble(bean.getLaldelcharge())*totaldays)/divval;
								
						       bean.setTarifftotal(df.format(tariftotal)+"");
						       bean.setRacdwscdwtotal(df.format(cdwtotal)+"");
						       bean.setRaaccessorytotal(df.format(accsssorytotal)+"");
						       bean.setLaldelchargetotal(df.format(deltotal)+"");
						       
						       
						       totalamt=tariftotal+cdwtotal+accsssorytotal+deltotal;
						       
						       balamount=totalamt-paidtotalamt;
						       
						       bean.setAdvtotalamont(df.format(totalamt)+"");
						       bean.setAdvpaidamount(df.format(paidtotalamt)+"");
						       bean.setAdvbalance(df.format(balamount)+"");
						       
								    	   //   Double.parseDouble(bean.getRacdwscdw())*totaldays;
								    	   //  Double.parseDouble(bean.getRaaccessory())*totaldays;
								    	   // Double.parseDouble(bean.getLaldelcharge())*totaldays;	   
								    	   // getTarifftotal(),getRacdwscdwtotal(), getLaldelchargetotal(),getAdvtotalamont(),getAdvpaidamount(),getAdvbalance(),
							       
					       
					       
				
	       conn.close();
	      }
	      catch(Exception e){
	    	  conn.close();
	    	  e.printStackTrace();
	       
	      
	      }
	      return bean;
	     }
	 
	 /*  public  ClsRentalAgreementBean getPrintnoori(int docno, HttpServletRequest request) throws SQLException {
	    	ClsRentalAgreementBean bean = new ClsRentalAgreementBean();
	    	 Connection conn =null;
	      try {
	    	   conn = connDAO.getMyConnection();
	       Statement stmtinvoice = conn.createStatement();
	       String strSql="";
	   
	       strSql=("select r.voc_no,DATE_FORMAT(r.date,'%d-%m-%Y') date,a.per_tel,a.fax1,round(rc.inkm)-round(r.okm) kmused,DATEDIFF(rc.indate,r.odate) noofdays,if(v.fueltype='P','Petrol','Diesel') fueltype, "
	       		   + " round(r.insex,2) insex,if(r.clstatus=0,'Open','Closed') clstatus, r.doc_no,round(r.addrchg,2) addrchg,r.mrano,round(r.okm) okm,"
		       		+ " CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' "
		       		+ "THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN "
		       		+ "r.ofuel='0.625' THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' "
		       		+ "WHEN r.ofuel='1.000' THEN 'Level 8/8' 	END as 'ofuel' ,DATE_FORMAT(r.odate,'%d-%m-%Y')odate,r.otime,a.refname,  "
		       		+ "a.address,a.per_mob,a.mail1,br.branchname,concat(v.reg_no,' ',p.code_name) reg_no,v.flname,g.gname,mo.vtype,"
		       		+ "(select round(rate,2) rate  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as rate, (select  round(cdw,2)+round(cdw1,2) "
		       		+ "  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as cdw , (select round(gps,2)+round(babyseater,2)+round(cooler,2) "
		       		+ "	 from gl_rtarif where  rdocno="+docno+" and rstatus=7) as accessories, "
		       		+ "  (select round(kmrest)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raextrakm, "
		       		+ "(select round(exkmrte,2)  from gl_rtarif where  rdocno="+docno+" and rstatus=7) as raexxtakmchg,"
		       				+ "(select rentaltype  from gl_rtarif where  rdocno="+docno+" and rstatus=5) as rentaltypes, "
		       				+ " CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' "
		       		+ "	 WHEN rc.infuel='0.125' THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' "
		       		+ "	THEN 'Level 3/8'	WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' THEN 'Level 5/8' "
		       		+ "	 WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' "
		       		+ "	  THEN 'Level 8/8' 	 END as 'infuel',round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') indate,rc.intime,co.color,yo.yom "
		       		+ "	  from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join gl_drdetails d on "
		       		+ "	  d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no 	   "
		       		+ "	  left join gl_vehgroup g on g.doc_no=v.vgrpid   left join gl_vehmodel mo on mo.doc_no=v.vmodid 	   			        "
		       		+ "left join gl_vehplate p on p.doc_no=v.pltid left join gl_rtarif t on t.rdocno=r.doc_no  	   			"
		       		+ " left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join gl_yom yo on yo.doc_no=v.yom 	   		"
		       		+ " left join my_color co on co.doc_no=v.clrid   where r.doc_no="+docno+" group by r.doc_no");
	       
	       
	     //  System.out.println("------------"+strSql);
		       
	 
	       ResultSet resultSet = stmtinvoice.executeQuery(strSql); 
	       
	     
	       while(resultSet.next()){
	    	   
	    	   
	    	   bean.setLbmasterdate(resultSet.getString("date"));
	    
	    	   // cldatails
	    	    bean.setClname(resultSet.getString("refname"));
	    	    bean.setCladdress(resultSet.getString("address"));
	    	    bean.setClemail(resultSet.getString("mail1"));
	    	    bean.setClmobno(resultSet.getString("per_mob"));
	    	    //upper
	    	    bean.setBarnchval(resultSet.getString("branchname"));
	    	    bean.setMrano(resultSet.getString("mrano"));
	    	    bean.setRentaldoc(resultSet.getString("voc_no"));
	    	    
	    
	 
	    	    
	    	  // veh details
	    	    
	    	    
	    	    bean.setRavehname(resultSet.getString("flname"));
	    	    bean.setRavehgroup(resultSet.getString("gname"));
	    	    bean.setRavehmodel(resultSet.getString("vtype"));
	    	    bean.setRavehregno(resultSet.getString("reg_no"));
	    	    bean.setRadateout(resultSet.getString("odate"));
	    	    bean.setRatimeout(resultSet.getString("otime"));
	    	    bean.setRaklmout(resultSet.getString("okm"));
	    	    
	    	    
	    	    bean.setLbfueltype(resultSet.getString("fueltype"));
	    	    bean.setLbmodel(resultSet.getString("vtype"));
	    	    
	    	      
	    	    
	    	    
	    	    // rental type
	    	    
	    	 //   bean.setRadaily(resultSet.getString("daily"));
	    	   // bean.setRaweakly(resultSet.getString("weekly"));
	    	  //  bean.setRamonthly(resultSet.getString("monthly"));
	    	   // bean.setTariff(resultSet.getString("rate"));
	    	  // bean.setRacdwscdw(resultSet.getString("cdw"));
	    	   // bean.setRaaccessory(resultSet.getString("accessories"));
	    	  //  bean.setRaadditionalcge(resultSet.getString("addrchg"));
	    	    
	    	// in details
	    	   
	    	    bean.setInkm(resultSet.getString("inkm"));
	    	    bean.setInfuel(resultSet.getString("infuel"));
	    	    bean.setIndate(resultSet.getString("indate"));
	    	    bean.setIntime(resultSet.getString("intime"));
	    	    
	    	    
	    	    bean.setKmused(resultSet.getString("kmused"));
	    	    bean.setNoofdays(resultSet.getString("noofdays"));
	    	     
	    	   
	    	    bean.setPertel(resultSet.getString("per_tel"));
	    	    bean.setFaxno(resultSet.getString("fax1"));
	    	         
	    	    
	    	    
	    	  //  setIndetails,setColdetails
	    	    
	    	  
	    	    bean.setRastatus(resultSet.getString("clstatus"));
	    	    bean.setRafuelout(resultSet.getString("ofuel"));
	    	   //
	    	    
	    	   bean.setRayom(resultSet.getString("yom"));
	    	   bean.setRacolor(resultSet.getString("color")) ;
	    	   
	    	   
	    	   //setRaextrakm,setRaexxtakmchg
	    	   
	    	   bean.setRaextrakm(resultSet.getString("raextrakm"));
	    	   //bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg"));
	    	   bean.setRarenttypes(resultSet.getString("rentaltypes"));
	    	 
	    	   
	    	   if(resultSet.getInt("raextrakm")>0)
	    			   {
	    		   bean.setRaexxtakmchg(resultSet.getString("raexxtakmchg")); 
	    	 
	    			   }
	    	   else
	    	   {
	    		   bean.setRaexxtakmchg("");   
	    	   }
	    	   
	


	       }
	       
	       stmtinvoice.close();
	       
	       Statement stmtinvoice4 = conn.createStatement();
	       
	       
	 String  maindr="  select d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y') led, "
	 		+ " if(d.PASSPORT_NO='0','',d.PASSPORT_NO) PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp,d.mobno,d.issfrm from gl_drdetails d  "
	 		+ " left join gl_rdriver rr on rr.drid=d.dr_id where rr.rdocno='"+docno+"' and rr.srno=(select MIN(srno) from gl_rdriver where rdocno='"+docno+"') group by rr.rdocno;";
	// System.out.println("----------"+maindr);
	 ResultSet resultmain = stmtinvoice4.executeQuery(maindr); 
	       
	       while(resultmain.next()){
	    	   
	    	    bean.setRadrname(resultmain.getString("drname"));
	    	    bean.setRadlno(resultmain.getString("dlno"));
	    	    bean.setPassno(resultmain.getString("passport_no"));
	    	    bean.setLicexpdate(resultmain.getString("led"));
	    	    bean.setPassexpdate(resultmain.getString("pass_exp"));
	    	    bean.setDobdate(resultmain.getString("dob"));
	    	    bean.setLbldrmobno(resultmain.getString("mobno"));
	    	    bean.setLblplaceissue(resultmain.getString("issfrm"));
	    	   
	    
	    	    
	    	   
	       }
	       stmtinvoice4.close();
	       
	       Statement stmtinvoice1 = conn.createStatement();
	       

	 String  drone=" select d.name drname,d.dlno,DATE_FORMAT(d.dob,'%d-%m-%Y') dob,DATE_FORMAT(d.led,'%d-%m-%Y')  led,"
	 		+ " if(d.PASSPORT_NO='0','',d.PASSPORT_NO) PASSPORT_NO,DATE_FORMAT(d.pass_exp,'%d-%m-%Y') pass_exp,d.mobno,d.issfrm from gl_drdetails d "
	 		+ " left join gl_rdriver rr on rr.drid=d.dr_id where rr.rdocno='"+docno+"' and rr.srno=(select MIN(srno)+1 from gl_rdriver where rdocno='"+docno+"') group by rr.rdocno";
	 
	 ResultSet resultone = stmtinvoice1.executeQuery(drone); 
	       
	       while(resultone.next()){
	    	   
	    	   bean.setAdddrname1(resultone.getString("drname"));
	    	   bean.setAddlicno1(resultone.getString("dlno"));
	    	   bean.setExpdate1(resultone.getString("led"));
	    	   bean.setAdddob1(resultone.getString("dob"));
	    	   bean.setLbldrmobno1(resultone.getString("mobno"));
	    	   bean.setLblplaceissue1(resultone.getString("issfrm"));
	    	   bean.setLbpassexpdate1(resultone.getString("pass_exp"));
	    	   bean.setPassno1(resultone.getString("passport_no"));
	    	   
	       }
	       stmtinvoice1.close();
	     
	       Statement stmtinvoice5 = conn.createStatement();
	       int bb=0;
			 ArrayList<String> arr=new ArrayList<String>();      
	 String  sql01="select if(aa.defaultcard=1,aa.cardno,cardno) cardno,if(aa.defaultcard=1,DATE_FORMAT(aa.exp_date,'%d-%m-%Y'),DATE_FORMAT(exp_date,'%d-%m-%Y')) exp_date,"
	 		+ " if(aa.defaultcard=1,aa.defaultcard,defaultcard) defaultcard from "
	 		+ " (SELECT cardno,exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') "
	 		+ " and sr_no=(select sr_no from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"')and defaultcard=1)) aa "
	 		+ " union all (SELECT cardno,exp_date,defaultcard FROM my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') and "
	 		+ "sr_no=(select min(sr_no) from  my_clbankdet where rdocno=(select cldocno from gl_ragmt where doc_no='"+docno+"') and defaultcard=0) ) limit 1 ;";
	 
	 ResultSet resss = stmtinvoice5.executeQuery(sql01); 
	       String temp="";
	       while(resss.next()){
	    	   bean.setLbexpcarddate(resss.getString("exp_date"));
	    	   String  aa= resss.getString("cardno");
	    	   
	    	
	    	    //resss.getString("exp_date");
	    	  
	    	//System.out.println("==========="+aa.charAt(0));
	    	   if(aa.length()==16)
	    	   {
	    		    bb=1;
	    			temp=aa.charAt(0)+"::"+aa.charAt(1)+"::"+aa.charAt(2)+"::"+aa.charAt(3)+"::"+aa.charAt(4)+"::"
	    			+aa.charAt(5)+"::"+aa.charAt(6)+"::"+aa.charAt(7)+"::"+aa.charAt(8)+"::"
	    			+aa.charAt(9)+"::"+aa.charAt(10)+"::"+aa.charAt(11)+"::"+aa.charAt(12)+"::" 
	    			+aa.charAt(13)+"::"+aa.charAt(14)+"::"+aa.charAt(15);
	    		

					arr.add(temp);
					//System.out.println("-------"+arr);
					request.setAttribute("details",arr); 
	    		    //System.out.println(aa.charAt(i));
	    		}
	    	   else
	    	   {
	    		   bean.setFirstarray(1); 
	    	   }
	    	   
	    	   
	    	   
	    	   
	       }
	       if(bb==1)
   	   {
	    	   bean.setFirstarray(0); 
   	   }
	       
	       else
	       {
	    	   bean.setFirstarray(1);  
	       }
	       
	       
	       
	       stmtinvoice5.close();
	       
	       Statement stmtinvoice6 = conn.createStatement();
	       
	 String  sql02="select round(amount,2) amount from gl_rpyt where  rdocno='"+docno+"' and payment='Security' ;";
	 
	 ResultSet resss1 = stmtinvoice6.executeQuery(sql02); 
	      
	       if(resss1.next()){
	    	   bean.setLbsecurity(resss1.getString("amount"));
	    	   //setLbsecurity
	       }
	       stmtinvoice6.close();
					       
				
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	       conn.close();
	      
	      }
	      return bean;
	     }*/
	  public  JSONArray ralistgridload(String rentaldoc) throws SQLException {

	       JSONArray RESULTDATA=new JSONArray();
	        
	       Connection conn=null;
			try {
					  conn = connDAO.getMyConnection();
					Statement stmtVeh2 = conn.createStatement ();
	            	
				

					
					
					 String sql="select r.idno,m.acno,r.qty,r.total rate,m.description,r.r.total total"+
						       " from gl_invmode m left join"+
						       " (select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0, "+
						       " (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from "+
						       " gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+rentaldoc+" and afterclose=0 and calcstatus=1 group by idno "+
						       " union all "+
						       " select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0, "+
						       " (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from "+
						       " gl_rcalc r where r.idno in(8,14) and rdocno="+rentaldoc+" and afterclose=0 and calcstatus=1 "+
						       " union all "+
						       " select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0, "+
						       " (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from "+
						       " gl_rcalc r where r.idno in(9,15) and rdocno="+rentaldoc+" and afterclose=0 and calcstatus=1) r on(m.idno=r.idno) where r.idno is not null ";
					
					
		//	System.out.println("-----------------"+sql);
					ResultSet resultSet = stmtVeh2.executeQuery (sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
	    public  JSONArray trafficinvoSearch(String rentaldoc) throws SQLException {

		       JSONArray RESULTDATA=new JSONArray();
		       Connection conn=null;
		    
				try {
						 conn = connDAO.getMyConnection();
						Statement stmtVeh8 = conn.createStatement ();
		          
						
/*						String sql="select regno,ticket_no,time,traffic_date,fleetno,amount,inv_no,source  "
								+ "  from gl_traffic where ra_no='"+rentaldoc+"' and rtype in('RA','RD','RW','RF','RM') and inv_no is not null and inv_no>0  ;";*/
						
						String sql="select t.regno,t.ticket_no,t.time,t.traffic_date,t.fleetno,t.amount,i.voc_no inv_no,t.source " 
								+ " from gl_traffic t left join gl_invm i on i.doc_no=t.inv_no 	where t.ra_no='"+rentaldoc+"' and  "
										+ " t. rtype in('RA','RD','RW','RF','RM') and inv_no is not null and inv_no>0 " ;
						
						
						//System.out.println("---i----"+sql);
						ResultSet resultSet = stmtVeh8.executeQuery(sql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);
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
		  
	    public  JSONArray trafficNotinvoSearch(String rentaldocs) throws SQLException {

		       JSONArray RESULTDATA=new JSONArray();
		        
		       Connection conn=null;
				try {
						   conn = connDAO.getMyConnection();
						Statement stmtVeh4 = conn.createStatement ();
		    
						
						String sql="select regno,ticket_no,time,traffic_date,fleetno,amount,source  "
								+ "  from gl_traffic where ra_no='"+rentaldocs+"' and rtype in('RA','RD','RW','RF','RM') and (inv_no is null or inv_no=0) ;";
						
						//System.out.println("---n----"+sql);
						ResultSet resultSet = stmtVeh4.executeQuery(sql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmtVeh4.close();
						conn.close();

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    } 
	    public  JSONArray accountstatementSearch(String rentaldocval) throws SQLException {

		       JSONArray RESULTDATA=new JSONArray();
		       Connection conn=null;
		    
				try {
						  conn = connDAO.getMyConnection();
						Statement stmtVeh4 = conn.createStatement ();
		    
/*						String sql="select a.*,if(a.transtype='INV',m.voc_no,a.transno) transno  from (select j.acno,j.doc_no transno,j.tr_no,j.tranid,j.dtype transtype,j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,  "
								+ "	CONVERT(if(j.ldramount>0,round((j.ldramount*1),2),''),CHAR(100)) debit,  CONVERT(if(j.ldramount<0,round((j.ldramount*-1),2),''),   CHAR(100)) credit, "
								+ " if(j.description='0','',j.description) description  from my_jvtran j inner join gl_ragmt r  "
								+ "  	on j.rdocno=r.doc_no and rtype='RAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno  "
								+ "   where  j.status=3 and  j.rdocno='"+rentaldocval+"' 	and j.rtype='RAG'  union all  "
								+ "     ( select acno,transno,tr_no,tranid,transtype,trdate,rentaldoc,rentaltype,   if(sum(gr.debit)=0,'',round(sum(gr.debit),2)),if(sum(gr.credit)=0,'',round(sum(gr.credit),2)) "
								+ " ,if(description='0','',description) description   	from  (select j1.acno,j1.doc_no transno,j1.tr_no,j1.tranid,j1.dtype transtype,j1.date trdate,j.rdocno rentaldoc,j.rtype rentaltype, "
								+ "    CONVERT(if(j1.ldramount>0,round((j1.ldramount*1),2),''),CHAR(100)) debit, 	CONVERT(if(j1.ldramount<0,round((j1.ldramount*-1),2),''),CHAR(100)) credit,j.ldramount,if(j1.description='0','',j1.description)  "
								+ "  description  from my_jvtran j inner join  	my_outd d on d.ap_trid=j.tranid      inner join my_jvtran j1 on d.tranid=j1.tranid  inner join gl_ragmt r  "
								+ "   	on j.rdocno=r.doc_no and j.rtype='RAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno    "
								+ "    	where  j.status=3 and j.rdocno='"+rentaldocval+"' and j.rtype='RAG'   and j1.tr_no is not null group by j1.doc_no) gr group by gr.tranid)) a "
								+ "  left join gl_invm m on m.dtype=a.transtype and a.transno=m.doc_no order by trdate ";
					*/

					
										//#Second select is for selecting applied  reciepts
					
                             	String sql="select a.*,if(a.transtype in ('INV','INS','INT'),m.voc_no,a.transno) transno  from (select j.acno,j.doc_no transno,j.tr_no,j.tranid,j.dtype transtype,"+
								" j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,  	CONVERT(if(j.ldramount>0,round((j.ldramount*1),2),''),CHAR(100)) debit,"+
								" CONVERT(if(j.ldramount<0,round((j.ldramount*-1),2),''),   CHAR(100)) credit,  if(j.description='0','',j.description) description"+
								" from my_jvtran j inner join gl_ragmt r on (j.rdocno=r.doc_no and rtype='RAG') left join my_acbook c on (r.cldocno=c.cldocno and"+
								" c.dtype='CRM' and c.acno=j.acno) left join (select acno from my_account where codeno='rsecurity') h on j.acno=h.acno"+
								" where j.status=3 and j.rdocno="+rentaldocval+" and j.rtype='RAG' and (c.doc_no is not null or h.acno is not null) union all  "
						/*#*/	+ " ( select acno,transno,tr_no,tranid,transtype,trdate,rentaldoc,rentaltype,   if(sum(gr.debit)=0,'',round(sum(gr.debit),2)),if(sum(gr.credit)=0,'',round(sum(gr.credit),2)) "
								+ " ,if(description='0','',description) description   	from  (select j1.acno,j1.doc_no transno,j1.tr_no,j1.tranid,j1.dtype transtype,j1.date trdate,j.rdocno rentaldoc,j.rtype rentaltype, "
								+ "    CONVERT(if(j1.ldramount>0,round((j1.ldramount*1),2),''),CHAR(100)) debit, 	CONVERT(if(j1.ldramount<0,round((j1.ldramount*-1),2),''),CHAR(100)) credit,j.ldramount,if(j1.description='0','',j1.description)  "
								+ "  description  from my_jvtran j inner join  	my_outd d on d.ap_trid=j.tranid      inner join my_jvtran j1 on d.tranid=j1.tranid  inner join gl_ragmt r  "
								+ "   	on j.rdocno=r.doc_no and j.rtype='RAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno    "
								+ "    	where  j.status=3 and j.rdocno='"+rentaldocval+"' and j.rtype='RAG' and j1.tr_no is not null group by j1.doc_no) gr group by gr.tranid)) a "
								+ "  left join gl_invm m on m.dtype=a.transtype and a.transno=m.doc_no";
						


					
						//System.out.println("-----sql-----"+sql);
						
						//System.out.println("-------"+sql);
/*						String sql="select j.acno,j.doc_no transno,j.tr_no,j.tranid,j.dtype transtype,j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype, "
								+ "	CONVERT(if(j.ldramount>0,round((j.ldramount*1),2),''),CHAR(100)) debit,  "
								+ "CONVERT(if(j.ldramount<0,round((j.ldramount*-1),2),''),CHAR(100)) credit,if(j.description='0','',j.description) description  from my_jvtran j inner join gl_ragmt r  "
								+ "	on j.rdocno=r.doc_no and rtype='RAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno  where  j.status=3 and  j.rdocno='"+rentaldocval+"' "
								+ "	and j.rtype='RAG'  	union all ( select acno,transno,tr_no,tranid,transtype,trdate,rentaldoc,rentaltype,if(sum(gr.debit)=0,'',round(sum(gr.debit),2)),if(sum(gr.credit)=0,'',round(sum(gr.credit),2)),if(description='0','',description) description   "
								+ "	from (select j1.acno,j1.doc_no transno,j1.tr_no,j1.tranid,j1.dtype transtype,j1.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,  "
								+ " CONVERT(if(j1.ldramount>0,round((j1.ldramount*1),2),''),CHAR(100)) debit,  "
								+ "	CONVERT(if(j1.ldramount<0,round((j1.ldramount*-1),2),''),CHAR(100)) credit,j.ldramount,if(j1.description='0','',j1.description) description  from my_jvtran j inner join  "
								+ "	my_outd d on d.ap_trid=j.tranid inner join my_jvtran j1 on d.tranid=j1.tranid  inner join gl_ragmt r  "
								+ "	on j.rdocno=r.doc_no and j.rtype='RAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno  "
								+ "	where  j.status=3 and  j.rdocno='"+rentaldocval+"'  and j.rtype='RAG' and j1.tr_no is not null group by j1.doc_no) gr group by gr.tranid) order by trdate";*/
						//System.out.println("---------------"+sql);
						ResultSet resultSet = stmtVeh4.executeQuery(sql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmtVeh4.close();
						conn.close();

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    } 

	    public  ClsRentalAgmtNewBean getClosingSummaryPrint(HttpServletRequest request, int docNo) throws SQLException {
	    	ClsRentalAgmtNewBean bean = new ClsRentalAgmtNewBean();
			Connection conn=null;
			try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh5 = conn.createStatement();
				String sql="";
				
				sql="select r.doc_no,c.company,c.address,c.tel,c.fax,lo.loc_name location,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' WHEN r.ofuel='0.125' THEN "
				+ "'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375'	THEN 'Level 3/8'	WHEN r.ofuel='0.500' THEN 'Level 4/8' WHEN r.ofuel='0.625' "
				+ "THEN 'Level 5/8'  WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' WHEN r.ofuel='1.000' THEN 'Level 8/8' 	END as 'ofuel',"
				+ "DATE_FORMAT(r.odate,'%d-%m-%Y')odate,r.otime,a.refname,br.branchname,v.fleet_no,v.flname,CASE WHEN rc.infuel='0.000' THEN 'Level 0/8' WHEN rc.infuel='0.125' "
				+ "THEN 'Level 1/8' WHEN rc.infuel='0.250' 	THEN 'Level 2/8' WHEN rc.infuel='0.375' THEN 'Level 3/8' WHEN rc.infuel='0.500' THEN 'Level 4/8' WHEN rc.infuel='0.625' "
				+ "THEN 'Level 5/8' WHEN rc.infuel='0.750' THEN 'Level 6/8' WHEN rc.infuel='0.875' THEN 'Level 7/8' WHEN rc.infuel='1.000' THEN 'Level 8/8' END as 'infuel',"
				+ "round(rc.inkm) inkm,DATE_FORMAT(rc.indate,'%d-%m-%Y') indate,rc.intime from gl_ragmt r left join my_acbook a on a.cldocno=r.cldocno  and  a.dtype='CRM' left join "
				+ "gl_drdetails d on d.cldocno=a.cldocno  left join my_brch br on br.branch=r.brhid left join gl_vehmaster  v on v.fleet_no=r.fleet_no left join gl_rtarif t on "
				+ "t.rdocno=r.doc_no left join gl_ragmtclosem rc on rc.agmtno=r.doc_no left join my_locm lo on lo.brhid=br.doc_no left join my_comp c on br.cmpid=c.doc_no where r.doc_no="+docNo+" "
				+ "group by r.doc_no";
				
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
					
					bean.setLbldateout(resultSet.getString("odate"));
					bean.setLbltimeout(resultSet.getString("otime"));
					bean.setLblkmout(resultSet.getString("okm"));
					bean.setLblfuelout(resultSet.getString("ofuel"));
					
					bean.setLbldatein(resultSet.getString("indate"));
					bean.setLbltimein(resultSet.getString("intime"));
					bean.setLblkmin(resultSet.getString("inkm"));
					bean.setLblfuelin(resultSet.getString("infuel"));
					
				}
				
				String sql1 = "";
				
					sql1="select rep.ofleetno,rep.odate,rep.otime,rep.indate,rep.intime,rep.rfleetno infleetno from gl_ragmt agmt left join "+
							" gl_vehreplace rep on agmt.doc_no=rep.rdocno where rep.status<>7 and rep.rtype='RAG' and agmt.doc_no='"+docNo+"' ";
				
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
						+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(100)) credit from my_jvtran j inner join gl_ragmt r on j.rdocno=r.doc_no and rtype='RAG' inner join my_acbook c on "
						+ "c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno where  j.status=3 and  rdocno="+docNo+" and rtype='RAG' and j.dtype='CRV';";
			
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
			
			sql4="select CONVERT(if(ldramount>0,round(sum(ldramount*1),2),'0.00'),CHAR(100)) debitcrvtotal,CONVERT(if(ldramount<0,round(sum(ldramount*-1),2),'0.00'),CHAR(100)) creditcrvtotal from my_jvtran j inner join gl_ragmt r on j.rdocno=r.doc_no and rtype='RAG' "
				+ "inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno where  j.status=3 and  rdocno="+docNo+" and rtype='RAG' and j.dtype='CRV'";

			ResultSet resultSet4 = stmtVeh5.executeQuery(sql4);
			
			while(resultSet4.next()){
				bean.setLblsumcrvdebit(resultSet4.getString("debitcrvtotal"));
				bean.setLblsumcrvcredit(resultSet4.getString("creditcrvtotal"));
			}
			
			String sql3 = "";
/*			
			sql3="select j.doc_no transno,j.dtype transtype,j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,j.description,CONVERT(if(ldramount>0,round((ldramount*1),2),'  '),CHAR(100)) debit,"
					+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(100)) credit from my_jvtran j inner join gl_ragmt r on j.rdocno=r.doc_no and rtype='RAG' inner join my_acbook c on "
					+ "c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno where  j.status=3 and  rdocno="+docNo+" and rtype='RAG' and j.dtype!='CRV';";*/
			
			

			sql3="select j.doc_no transno,j.dtype transtype,j.date trdate,if(j.dtype='INV',inv.voc_no,j.doc_no) rentaldoc,j.rtype rentaltype,j.description, "
		+ "		CONVERT(if(ldramount>0,round((ldramount*1),2),'  '),CHAR(100)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(100))  "
		+ "  credit from my_jvtran j inner join gl_ragmt r on j.rdocno=r.doc_no and rtype='RAG'  "
		+ " inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno  "
		+ "  left join gl_invm inv on (j.doc_no=inv.doc_no and j.dtype='INV')    "
		+ "	 where  j.status=3 and  rdocno="+docNo+" and rtype='RAG' and j.dtype!='CRV' ";
			
		
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
		
		sql5="select CONVERT(if(ldramount>0,round(sum(ldramount*1),2),'0.00'),CHAR(100)) debittotal,CONVERT(if(ldramount<0,round(sum(ldramount*-1),2),'0.00'),CHAR(100)) credittotal from my_jvtran j inner join gl_ragmt r on j.rdocno=r.doc_no and rtype='RAG' "
			+ "inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno where  j.status=3 and  rdocno="+docNo+" and rtype='RAG' and j.dtype!='CRV'";
		
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
			conn.close();
		}
		return bean;
	}
	   /* public  JSONArray bookingrefsearch(HttpSession session,String qutdocno,String clientname,String clmob,String qutdate,String quttype) throws SQLException {


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
	      	sqlStartDate = commonDAO.changeStringtoSqlDate(qutdate);
	      	}
	      	
	      	
	      	String sqltest="";
	      	if(!(qutdocno.equalsIgnoreCase(""))){
	      		sqltest=sqltest+" and b.doc_no like '"+qutdocno+"'";
	      	}
	      	if(!(clientname.equalsIgnoreCase(""))){
	      		sqltest=sqltest+" and a.refname like '"+clientname+"%'";
	      	}
	      	if(!(clmob.equalsIgnoreCase(""))){
	      		sqltest=sqltest+" and b.contactno ='"+clmob+"'";
	      	}
	      	
	      	if(!(quttype.equalsIgnoreCase(""))){
	      		
	      		sqltest=sqltest+" and b.reftype like'"+quttype+"'";
	      	}
	      	 if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and b.date='"+sqlStartDate+"'";
	      	} 
	      	Connection conn = null;
	   		try {
	   				 conn = connDAO.getMyConnection();
	   				Statement stmtenq1 = conn.createStatement ();
	              	
	   				String clssql= ("select b.doc_no docnos,b.tdocno,b.date bookingdate,b.frmdate fromdate,b.frmtime fromtime,b.todate,b.totime,"
	   						+ "b.delivery,b.chuef,sal.doc_no saldoc,trim(sal.sal_name) sal_name,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,"
	   						+ "concat(coalesce(a.address,''),'  ',coalesce(a.address2,'')) as address ,a.per_tel,a.codeno,a.acno, "
	   						+ "v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc, CASE WHEN m.FIN='0.000' THEN 'Level 0/8' "
	   						+ " WHEN m.FIN='0.125' THEN 'Level 1/8' WHEN m.FIN='0.250' THEN 'Level 2/8' WHEN m.FIN='0.375' "
	   						+ " THEN 'Level 3/8' WHEN m.FIN='0.500' THEN 'Level 4/8' WHEN m.FIN='0.625' THEN 'Level 5/8' "
	   						+ "   WHEN m.FIN='0.750' THEN 'Level 6/8' WHEN m.FIN='0.875' THEN 'Level 7/8' WHEN m.FIN='1.000' "
	   						+ "   THEN 'Level 8/8'    END as 'FIN',m.FIN hidfin,m.fleet_no ,m.kmin,c.doc_no,c.color,g.gname,g.doc_no gid "
	   						+ "   from gl_bookingm b inner join gl_vehmaster v  on b.fleet_no=v.fleet_no inner join my_acbook a "
	   						+ "    on a.cldocno=b.cldocno  and  a.dtype='CRM' left join gl_vmove m on v.fleet_no=m.fleet_no "
	   						+ "left join my_salm sal on a.sal_id=sal.doc_no and sal.status<>7 "
	   						+ "  left join my_color c on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid "
	   						+ "     where v.a_br=1 and ins_exp >=current_date and v.statu <> 7 and "
	   						+ "    m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) "
	   						+ "     and  fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','R') and "
	   						+ "      b.status<>7 and b.brhid="+brid+" " +sqltest+" group by b.Doc_No");
	   			//System.out.println("-----------"+clssql);
	   				ResultSet resultSet = stmtenq1.executeQuery(clssql);
	   				
	   				RESULTDATA=commonDAO.convertToJSON(resultSet);
	   				stmtenq1.close();
	   				conn.close();
	   		}
	   		catch(Exception e){
	   			conn.close();
	   			e.printStackTrace();
	   		}
	   		//System.out.println(RESULTDATA);
	          return RESULTDATA;
	      }
    */
	    
}
