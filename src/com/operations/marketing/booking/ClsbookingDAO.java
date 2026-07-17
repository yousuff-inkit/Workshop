package com.operations.marketing.booking;





import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsDAO;
import com.operations.marketing.booking.ClsbookingAction;
import com.operations.marketing.booking.ClsbookingBean;
import com.operations.marketing.quotation.ClsquotationBean;




public class ClsbookingDAO {
	ClsRentalReceiptsDAO rentalReceiptsDAO= new ClsRentalReceiptsDAO();
	ClsConnection connDAO=new ClsConnection();
	
	ClsCommon commDAO=new ClsCommon();
	int headdoc; // for payment receipt create
	

    String plusval="" ; 
	Connection conn;
public int insert(Date sqlStartDate, Date vehfromdate, Date vehtodate,
		String cmbreftype, String bookrefno, String bookclientno,
		String bookcontactno, String bookattention, String bookremark,
		int bookbrandid, int bookmodelid, int bookcolorid, int bookgroupid,
		String renttype, String jqxVehicleToTime, String jqxVehicleFromTime,
		int delivery_chkval, int chauffeur_chkval, String dellocation,String guestremark,int salagtid,String email, 
		ArrayList<String> qtarifarray,ArrayList<String> paymentarray,String bookslno,
		String mode, HttpSession session,String formcode,HttpServletRequest request,String clientname,String clacno, int tdocno, int fleetno,
		String delchg, String invex, int advchk, String invtype, String vehloc, String codeno,String refclientdet ) throws SQLException {
//System.out.println("=================="+vehloc);


		try{
			int docno ;
			 conn=connDAO.getMyConnection();
			 conn.setAutoCommit(false);   
			// int vehlocs=Integer.parseInt(vehloc);
			 if(vehloc.trim().equalsIgnoreCase("")||(vehloc.equalsIgnoreCase("null")))
			 {
				 vehloc="0";
			 }
				if(bookrefno.equalsIgnoreCase("")||bookrefno.equalsIgnoreCase("0")||bookrefno.equalsIgnoreCase("NA"))
				{
					bookrefno=null;	
				}
			CallableStatement stmtbooking= conn.prepareCall("{call bookingDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtbooking.registerOutParameter(27, java.sql.Types.INTEGER);
			stmtbooking.registerOutParameter(38, java.sql.Types.INTEGER);
			stmtbooking.setDate(1,sqlStartDate);
			stmtbooking.setString(2,cmbreftype);
			stmtbooking.setString(3,bookrefno=="null"?null:bookrefno);
			stmtbooking.setString(4,bookclientno);
			stmtbooking.setString(5,bookcontactno);
			stmtbooking.setString(6,bookattention);
			stmtbooking.setString(7,bookremark);
			stmtbooking.setInt(8,bookbrandid);
			stmtbooking.setInt(9,bookmodelid);
			stmtbooking.setInt(10,bookcolorid);
			stmtbooking.setInt(11,bookgroupid);
			stmtbooking.setString(12,renttype);
			stmtbooking.setString(13,jqxVehicleFromTime);
			stmtbooking.setString(14,jqxVehicleToTime);
			stmtbooking.setInt(15,delivery_chkval);
			stmtbooking.setInt(16,chauffeur_chkval);
			stmtbooking.setString(17,dellocation);
			stmtbooking.setString(18,guestremark);
		    stmtbooking.setString(19,session.getAttribute("USERID").toString());
			stmtbooking.setString(20,session.getAttribute("BRANCHID").toString());
			stmtbooking.setDate(21,vehfromdate);
		    stmtbooking.setDate(22,vehtodate);
			stmtbooking.setInt(23,salagtid);
			stmtbooking.setString(24,email);
			stmtbooking.setString(25,bookslno=="null"?"0":bookslno);
		    stmtbooking.setString(26,formcode);
			stmtbooking.setString(28,mode);
			stmtbooking.setInt(29,tdocno);
			stmtbooking.setInt(30,fleetno);
			stmtbooking.setString(31,clacno);
			stmtbooking.setString(32,delchg=="null"?"0":delchg);
			stmtbooking.setString(33,invex);
			stmtbooking.setInt(34,advchk);
			stmtbooking.setString(35,invtype);
			stmtbooking.setString(36,vehloc);
			stmtbooking.setString(37,refclientdet);
			System.out.println("book === "+stmtbooking);
			stmtbooking.executeQuery();
			//docno=stmtbooking.getInt("docNo");
			docno=stmtbooking.getInt("docNo");
			int vocno=stmtbooking.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			
			if(docno<=0)
			{
				 conn.close();
				return 0;
			}	
		if(cmbreftype.equalsIgnoreCase("QOT"))
			{
				
				String sqlupdate="update gl_quotm set clstatus=4 where DOC_NO='"+bookrefno+"'";
				
				
						 stmtbooking.executeUpdate (sqlupdate);
				
			}
		
			
/*		rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,gid,brhid,rdocno*/
			
		 for(int i=0;i<qtarifarray.size();i++){
		    	
		     String[] tariff=qtarifarray.get(i).split("::");
		    
		    // System.out.println("dasfghjk======="+ragmttariffarray.get(i));
		     String sql="INSERT INTO gl_btarif(rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg,rstatus,brhid,rdocno,gid)VALUES"
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
		       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"','"+bookgroupid+"' )";
		     int resultSet1 = stmtbooking.executeUpdate (sql);
		     if(resultSet1<=0)
			    {
		    	 conn.close();
		    	 return 0;
			    }
		     
		     }
		
		
		
/*		
		
			
			for(int i=0;i< qtarifarray.size();i++){
		    	
			     String[] tariff=qtarifarray.get(i).split("::");
			   
			    // System.out.println("dasfghjk======="+ragmttariffarray.get(i));, brhid, gid
			     String sql="INSERT INTO gl_btarif(rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,gid,brhid,rdocno)VALUES"
			       + " ('"+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].isEmpty()?0:tariff[0].trim())+"',"
			       + "'"+(tariff[1].trim().equalsIgnoreCase("undefined") || tariff[1].trim().equalsIgnoreCase("")|| tariff[1].trim().equalsIgnoreCase("NA")|| tariff[1].trim().equalsIgnoreCase("NaN") || tariff[1].isEmpty()?0:tariff[1].trim())+"',"
			       + "'"+(tariff[2].trim().equalsIgnoreCase("undefined") || tariff[2].trim().equalsIgnoreCase("")|| tariff[2].trim().equalsIgnoreCase("NA")|| tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+"',"
			       + "'"+(tariff[3].trim().equalsIgnoreCase("undefined") || tariff[3].trim().equalsIgnoreCase("")|| tariff[3].trim().equalsIgnoreCase("NA") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+"',"
			       + "'"+(tariff[4].trim().equalsIgnoreCase("undefined") || tariff[4].trim().equalsIgnoreCase("")|| tariff[4].trim().equalsIgnoreCase("NA") || tariff[4].trim().equalsIgnoreCase("NaN")|| tariff[4].isEmpty()?0:tariff[4].trim())+"',"
			       + "'"+(tariff[5].trim().equalsIgnoreCase("undefined") || tariff[5].trim().equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NA")|| tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+"',"
			       + "'"+(tariff[6].trim().equalsIgnoreCase("undefined") || tariff[6].trim().equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NA")|| tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+"',"
			       + "'"+(tariff[7].trim().equalsIgnoreCase("undefined") || tariff[7].trim().equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NA")|| tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+"',"
			       + "'"+(tariff[8].trim().equalsIgnoreCase("undefined") || tariff[8].trim().equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NA")|| tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+"',"
			       + "'"+(tariff[9].trim().equalsIgnoreCase("undefined") || tariff[9].trim().equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NA")|| tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+"',"
			       + "'"+(tariff[10].trim().equalsIgnoreCase("undefined") || tariff[10].trim().equalsIgnoreCase("")|| tariff[10].trim().equalsIgnoreCase("NA")|| tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+"',"
			       + "'"+(tariff[11].trim().equalsIgnoreCase("undefined") || tariff[11].trim().equalsIgnoreCase("")|| tariff[11].trim().equalsIgnoreCase("NA")|| tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+"',"
			       + "'"+(tariff[12].trim().equalsIgnoreCase("undefined") || tariff[12].trim().equalsIgnoreCase("")|| tariff[12].trim().equalsIgnoreCase("NA")|| tariff[12].trim().equalsIgnoreCase("NaN")|| tariff[12].isEmpty()?0:tariff[12].trim())+"',"
			       + "'"+bookgroupid+"',"
			       +"'"+session.getAttribute("BRANCHID").toString()+"','"+docno+"' )";
			     //System.out.println("---------"+sql);
			     int resultSet2 = stmtbooking.executeUpdate (sql);
			    
			    // System.out.println("==================="+tariff[2].trim());
			     
			     if(resultSet2<=0)
				 	{
				 		 conn.close();
				 		return 0;
				 	}	
			     }
			
			*/
			
			   
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
           
           int cldoc = Integer.parseInt(bookclientno);
		     
		     int claccount=Integer.parseInt(clacno);
		     
		   
		     String aggno=""+docno;
         
           
           double Amount=Double.parseDouble(Amt);
           
         
           int srno=0;
           String type="";
           if(!(paidas.equalsIgnoreCase("3")))
           
           {
        	  
           	String selectsql="select acno from my_cardm where doc_no='"+paytypeid+"' and dtype='mode'";
            
  			 ResultSet resSet = stmtbooking.executeQuery(selectsql);
  			     if (resSet.next()) {
  			    	 headdoc = resSet.getInt("acno");
  			                      }	
			     
        	 /*  if(!paytypeid.equalsIgnoreCase("3"))
               {
              	
                type=paytypeid.equalsIgnoreCase("1")?"rcash":"rcard";
            	//System.out.println("-----1---");   
               }
               else
               {
            	//System.out.println("-----2----");   
              	 type="ronline"; 
               }
           // String type=paytypeid.equalsIgnoreCase("1")?"rcash":"rcard";
           
            
            String selectsql="select t.doc_no,t.account,t.description from my_account a inner JOIN MY_HEAD t on a.acno=t.doc_no where codeno='"+type+"'";
        //   System.out.println("-------"+selectsql);
			 ResultSet resSet = stmtbooking.executeQuery(selectsql);
			     if (resSet.next()) {
			    	 headdoc = resSet.getInt("doc_no");
			    	 
			    	 
			    	 
			                      }*/
			     
			  
			     
			        String payid="";
				     if((paidas.equalsIgnoreCase("1")))
				     {
				    	 payid="2"; 
				    	 
				    	 
				     }
				     else
				     {
				    	 payid="3"; 
				     }
				     
		     int valre=rentalReceiptsDAO.insert(conn,sqlStartDate,"RRV",paytypeid,headdoc,cardtype,refdoc.trim(),sqlStartDate,"Booking",0,"0",cldoc,claccount,"VBR",aggno,payid,Amount,0.00,0.00,0.00,
		    		 Amount,"Booking",clientname,0.00,blankarray,session,request);
		     
		     
		      srno=(int) request.getAttribute("isrno");
		    if(valre<=0)	{
		    	
		    	 conn.close();
		    	 return 0; 
		    	
		                  }
               }
           
/*rdocno, payment, mode, amount, acode, cardno, expdate, recieptno, brhid, payid, card, paytype, cardtype*/
			    	 String sql="INSERT INTO gl_bpyt(payment,mode,amount,acode,cardno,expdate,card,cardtype,paytype,payid,brhid,rdocno,recieptno)VALUES"
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
						     int resultSet3 = stmtbooking.executeUpdate (sql);
						     if(resultSet3<=0)
							 	{
							 		 conn.close();
							 		return 0;
							 	}	
						     
			     }
				     
				     }
		 
				     
			if (docno > 0) {
				conn.commit();
				stmtbooking.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			e.printStackTrace();
		conn.close();
		}
		return 0;
	   }
public int delete(int docno,HttpSession session,String mode,String formcode,String reftype,String refno) throws SQLException {
	try{
		
		 conn=connDAO.getMyConnection();
 
			Statement stmtdel = conn.createStatement ();
			if(reftype.equalsIgnoreCase("QOT"))
			{
				
			String sql="SELECT clstatus FROM gl_bookingm where doc_no='"+refno+"'";
			
			
			ResultSet resultSet = stmtdel.executeQuery (sql);
			if (resultSet.next()) {
				
				 int data = (resultSet.getInt("clstatus"));
				 if(data>4)
				 {
					 stmtdel.close();
					conn.close(); 
					return -1;
				 }
				}
		     }
		CallableStatement stmtbooking= conn.prepareCall("{call bookingDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtbooking.setDate(1,null);
		stmtbooking.setString(2,null);
		stmtbooking.setString(3,null);
		stmtbooking.setString(4,null);
		stmtbooking.setString(5,null);
		stmtbooking.setString(6,null);
		stmtbooking.setString(7,null);
		stmtbooking.setInt(8,0);
		stmtbooking.setInt(9,0);
		stmtbooking.setInt(10,0);
		stmtbooking.setInt(11,0);
		stmtbooking.setString(12,null);
		stmtbooking.setString(13,null);
		stmtbooking.setString(14,null);
		stmtbooking.setString(15,null);
		stmtbooking.setString(16,null);
		stmtbooking.setString(17,null);
		stmtbooking.setString(18,null);
	    stmtbooking.setString(19,session.getAttribute("USERID").toString());
		stmtbooking.setString(20,session.getAttribute("BRANCHID").toString());
		stmtbooking.setDate(21,null);
		stmtbooking.setDate(22,null);
		stmtbooking.setInt(23, 0);
		stmtbooking.setString(24,null);
		stmtbooking.setString(25,null);
		stmtbooking.setString(26,formcode.trim());
		stmtbooking.setInt(27,docno);
		stmtbooking.setString(28,"D");
		
		stmtbooking.setInt(29,0);
		stmtbooking.setInt(30,0);
		
		stmtbooking.setString(31,null);
		stmtbooking.setString(32,null);
		stmtbooking.setString(33,null);
		stmtbooking.setInt(34,0);
		stmtbooking.setString(35,null);
		stmtbooking.setString(36,null);
		stmtbooking.setString(37,"");
		stmtbooking.setInt(38,0);
		int del=stmtbooking.executeUpdate();
		
		if(del>0)
		{
			Statement stmtup = conn.createStatement ();
			if(reftype.equalsIgnoreCase("QOT"))
			{
				
			String sqls="update gl_quotm set clstatus=0 where DOC_NO='"+refno+"'";
		    stmtup.executeUpdate(sqls);
		    stmtup.close();
			}
			else
			{
				
			}
			
			
		}
		
		if (del>0) {
		
			stmtbooking.close();
			conn.close();
			System.out.println("Sucess");
			return docno;
		}	
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	return 0;
}
	

public   ClsbookingBean getPrint(int docno, HttpServletRequest request) throws SQLException {
	ClsbookingBean bean = new ClsbookingBean();
	  Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtprint = conn.createStatement ();
       	
			String resql=("select b.voc_no,b.doc_no,if(b.fleet_no='0','',b.fleet_no) fleet_no,b.Doc_No,DATE_FORMAT(b.date,'%d-%m-%Y') date,b.reftype,if(b.REFTYPE='ONL','Online',if(b.REFTYPE='DIR','Direct',concat('Quotation','(',b.refno,')'))) type, "
					+ "b.contactno mob,b.rsrno,b.colid,b.grpid,b.rtype,DATE_FORMAT(b.frmDate,'%d-%m-%Y') fromdate,b.FrmTime,DATE_FORMAT(b.todate,'%d-%m-%Y') todate, "
					+ "b.toTime,if(b.delivery=0,'NO','YES') delivery,if(b.chuef=0,'NO','YES') chuef,b.delloc, "
					+ "b.clreason,b.email,a.refname,a.address,ag.sal_name,vb.brand_name,vm.vtype model,vc.color,vg.gname "
					+ "from gl_bookingm b left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM'  left join my_salesman ag on ag.doc_no=b.sagid and sal_type='SLA' "
					+ "left join gl_vehbrand vb on vb.doc_no=b.brdid left join gl_vehmodel vm on vm.doc_no=b.modid "
					+ "left join my_color vc on vc.doc_no=b.colid left join gl_vehgroup vg on vg.doc_no=b.grpid where b.Doc_No="+docno+" group by b.Doc_No");

			//System.out.println("asddasd"+resql);
			ResultSet pintrs = stmtprint.executeQuery(resql);
			
		     
		       while(pintrs.next()){
		    	bean.setLblfleet(pintrs.getString("fleet_no"));
		   	    bean.setLblsaagnt(pintrs.getString("sal_name"));
	    	    bean.setLblbrand(pintrs.getString("brand_name"));
	    	    bean.setLblmodel(pintrs.getString("model"));
	    	    bean.setLblcolor(pintrs.getString("color"));
	    	    //upper
	    	    bean.setLblgroup(pintrs.getString("gname"));
	    	    bean.setLblrenttype(pintrs.getString("rtype"));
	    	    bean.setLblfromdate(pintrs.getString("fromdate"));
	    	    
	    	    
	    	    bean.setLblfromtim(pintrs.getString("FrmTime"));
	    	    bean.setLbltodate(pintrs.getString("todate"));
	    	    bean.setLbltotim(pintrs.getString("toTime"));
	    	    bean.setLbldelivery(pintrs.getString("delivery"));
	    	    //upper
	    	    bean.setLblchauffeur(pintrs.getString("chuef"));
	    	    bean.setLbldellocation(pintrs.getString("delloc"));
	
	    	    
	    	    
		    	   
		    	   
		    	    bean.setLblclient(pintrs.getString("refname"));
		    	    bean.setLblclientaddress(pintrs.getString("address"));
		    	    bean.setLblmob(pintrs.getString("mob"));
		    	    bean.setLblemail(pintrs.getString("email"));
		    	    //upper
		    	    bean.setLbldate(pintrs.getString("date"));
		    	    bean.setLbltypep(pintrs.getString("type"));
		    	    bean.setDocvals(pintrs.getInt("voc_no"));
		       }
			

			stmtprint.close();
			
			
			
			 Statement stmtinvoice10 = conn.createStatement ();
/*			    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_bookingm r  "
			    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
			    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";
*/

			  String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_bookingm r inner join my_brch b on  "
			    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
			    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
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
			       
				ArrayList<String> tariffarr=new ArrayList<String>();
				Statement stmtinvoice3 = conn.createStatement ();
			
				String strSqldetail1="select if(vg.gname='0',' ',vg.gname) group1,if(qt.rentaltype='0',' ',qt.rentaltype) rentaltype,if(qt.rate=0,' ',round(qt.rate,2)) rate "
						+ "	,if(qt.cdw=0,' ',round(qt.cdw,2)) cdw,if(qt.pai=0,' ',round(qt.pai,2)) pai,if(qt.cdw1=0,' ',round(qt.cdw1,2)) cdw1,  "
						+ "	if(qt.pai1=0,' ',round(qt.pai1,2)) pai1,if(qt.gps=0,' ',round(qt.gps,2)) gps, "
						+ "	if(qt.babyseater=0,' ',round(qt.babyseater,2)) babyseater,if(qt.cooler=0,' ',round(qt.cooler,2)) cooler,"
						+ "	if(qt.kmrest=0,' ',round(qt.kmrest)) kmrest,if(qt.exkmrte=0,' ',round(qt.exkmrte,2)) exkmrte,  "
						+ "if(qt.oinschg=0,' ',round(qt.oinschg,2)) oinschg,if(qt.exhrchg=0,' ',round(qt.exhrchg,2)) exhrchg "
						+ "	from gl_btarif qt left join gl_vehgroup vg on vg.doc_no=qt.gid   where qt.rdocno="+docno+" order by sr_no";
			
	
			ResultSet rsdetail1=stmtinvoice3.executeQuery(strSqldetail1);
			
			int rowcounts=1;
	
			while(rsdetail1.next()){

					String temp="";
					   bean.setFirstarray(1);
				
					temp=rsdetail1.getString("rentaltype")+"::"+rsdetail1.getString("rate")
					+"::"+rsdetail1.getString("cdw")+"::"+rsdetail1.getString("cdw1")
					+"::"+rsdetail1.getString("gps")+"::"+rsdetail1.getString("babyseater")+"::"+rsdetail1.getString("cooler")+"::"+rsdetail1.getString("kmrest")
					+"::"+rsdetail1.getString("exkmrte")+"::"+rsdetail1.getString("oinschg")+"::"+rsdetail1.getString("exhrchg");

					tariffarr.add(temp);
					rowcounts++;
	
			
				
		              }
			stmtinvoice3.close();  
			request.setAttribute("tariffdetails",tariffarr); 
			
			
			 ArrayList<String> arr=new ArrayList<String>();
				Statement stmtinvoice2 = conn.createStatement ();
			
				String strSqldetail="select payment, mode, round(amount,2) amount, if(acode='0','',acode) accode, if(cardno='0','',cardno) cardno, "
						+ " expdate, recieptno, if(card='0','',card) card,  case when cardtype='1' then 'Visa' when cardtype='2' then 'Master' else '' end as 'cardtype'  "
						+ "FROM gl_bpyt where rdocno="+docno+" order by doc_no; ";
			
	
			ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
			
			int rowcount=1;
	
			while(rsdetail.next()){

					String temp="";
		
					   bean.setSecarray(2);
						
					temp=rsdetail.getString("payment")+"::"+rsdetail.getString("mode")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("accode")+"::"+rsdetail.getString("cardtype")+"::"+rsdetail.getString("cardno")+"::"+rsdetail.getString("expdate")+"::"+rsdetail.getString("recieptno") ;

					arr.add(temp);
					rowcount++;
	
			
				
		              }
			stmtinvoice2.close();  
			request.setAttribute("details",arr);
			
			conn.close();



			
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	return bean;
	

}

	
	

public   JSONArray tariffRate(HttpSession session,String groupname,String rentaltype) throws SQLException {


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
       Connection conn =null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh6 = conn.createStatement ();
				/*and m1.branch="+brch+"*/
				String tasql= ("select coalesce(round(insurexcess,2),0) insurexcess, coalesce(round(cdwexcess,2),0) cdwexcess, "
						+ "coalesce(round(scdwexcess,2),0) scdwexcess,m1.doc_no tdocno,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler,m1.oinschg,m1.chaufchg, "
						+ "m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype from gl_tarifm m inner join gl_tarifd m1 on m.doc_no=m1.doc_no "
						+ "left join gl_tarifexcess t on  t.rdocno=m.doc_no and t.gid='"+groupname+"' right join "
						+ "gl_tlistm m2 on m1.renttype=m2.rentaltype where m1.gid='"+groupname+"'  and   m.doc_no=(select MAX(M.doc_no) from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no where "
						+ "current_date between M.validfrm and M.validto AND m1.gid='"+groupname+"'  and m.status<>7)  and m1.renttype='"+rentaltype+"' and m2.Status=1 order by m2.doc_no;");
				
				
			//System.out.println("sql"+tasql);
				ResultSet resultSet = stmtVeh6.executeQuery(tasql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh6.close();
				conn.close();
		}
		catch(Exception e){
			conn.close();
		}
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

public   List<ClsbookingBean> list4() throws SQLException {
    List<ClsbookingBean> list1Bean = new ArrayList<ClsbookingBean>();
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmt6 = conn.createStatement ();
			
		
			ResultSet resultSet5 = stmt6.executeQuery ("select mode from my_cardm;");

			while (resultSet5.next()) {
				
				ClsbookingBean bean = new ClsbookingBean();
				bean.setPaymentmode(resultSet5.getString("mode"));
				
			
			
				
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

   	String sqltest="";
   	
   	if(!(clname.equalsIgnoreCase(""))){
   		sqltest=sqltest+" and refname like '%"+clname+"%'";
   	}
   	if(!(mob.equalsIgnoreCase(""))){
   		sqltest=sqltest+" and per_mob='%"+mob+"%'";
   	}
 
	Connection conn=null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
           	
				String clsql= ("select cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,acno from my_acbook where dtype='CRM' and  brhid='"+brid+"' " +sqltest);
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
   

public   JSONArray qutsearchMaster(HttpSession session,String qutdocno,String clientname,String qutdate) throws SQLException {


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
   		
   		/*sqltest=sqltest+" and a.refname like '%"+clientname+"%'";*/
   	}
   
   	 if(!(sqlStartDate==null)){
   		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
   	} 
       
   	Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();
           	
				String clssql= ("select m.voc_no qotrefno,m.DOC_NO,m.DATE,m.cldocno,m.REF_NO,m.REF_TYPE,m.ATTN_TO,m.contact_no ,m.REMARKS,m.NETTOTAL,m.userid,m.email,a.acno, "
						+ "if(m.cldocno!=0,a.refname,e.name) refname ,if(m.cldocno!=0,a.address ,e.com_add1) address from gl_quotm m "
						+ " left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' left join gl_enqm e on e.doc_no=m.ref_no  left join gl_qenq d on d.rdocno=m.doc_no and d.bookstatus=0 "
						+ "where m.status=3 and d.bookstatus=0 and m.branch='"+brid+"' " +sqltest+ " and m.clstatus<>2 group by m.doc_no");
//				System.out.println("---------"+clssql);
			/*	String clssql= ("select m.DOC_NO,m.DATE,m.cldocno,m.REF_NO,m.REF_TYPE,m.ATTN_TO,m.contact_no ,m.REMARKS,m.NETTOTAL,m.userid,m.email, "
						+ "a.refname ,a.address from gl_quotm m left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM'  where m.status<>7 and m.branch="+brid+" " +sqltest);*/
				
				
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
public   JSONArray slnosearch(String qutdocno) throws SQLException {

	 JSONArray RESULTDATA=new JSONArray();
	 Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtrelode = conn.createStatement ();
       	
			String resql=("select qt.tdocno,eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.unit,eq.frmdate fromdate,eq.todate,DATE_FORMAT(frmdate,'%d.%m.%Y') AS "
					+ "hidfromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS hidtodate,eq.rtype renttype,eq.grpid,vb.brand_name brand,vm.vtype model,vc.color color,vg.gname gname "
					+ "FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
					+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID left join gl_quotd qt on qt.rdocno=eq.rdocno "
					+ "left join my_color vc on vc.doc_no=eq.clrid "
					+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid   where eq.rdocno='"+qutdocno+"' and eq.bookstatus=0 group by eq.sr_no ");
	//	System.out.println("--------"+resql);
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
public   JSONArray tarifrdocnorelode(String qutdocno,String qotslno) throws SQLException {

	 JSONArray RESULTDATA=new JSONArray();
	 Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtrelode = conn.createStatement ();
       	
		/*	String resql=("select qt.tdocno,qt.grpid,qt.rentaltype,qt.tariff rate,qt.cdw,qt.pai,qt.cdw1,qt.pai1,qt.gps,qt.babyseater,qt.cooler,"
					+ "		qt.kmrest,qt.exkmrte,qt.oinschg,qt.exhrchg	from gl_quotd qt where qt.rdocno='"+qutdocno+"' and qt.srno='"+qotslno+"' ");*/
			
			
			
			String resql=("select coalesce(round(t.insurexcess,2),0) insurexcess, coalesce(round(t.cdwexcess,2),0) cdwexcess,"
					+ "coalesce(round(t.scdwexcess,2),0) scdwexcess,qt.tdocno,qt.grpid,qt.rentaltype,qt.tariff rate,qt.cdw,qt.pai,qt.cdw1,qt.pai1, "
					+ "	qt.gps,qt.babyseater,qt.cooler,	qt.kmrest,qt.exkmrte,qt.oinschg,qt.exhrchg	from gl_quotd qt  "
					+ "left join gl_tarifexcess t on  t.rdocno=qt.tdocno and t.gid=qt.grpid  where qt.rdocno='"+qutdocno+"' and qt.srno='"+qotslno+"' ");
			
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
public   JSONArray salagentseach() throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
   
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
        	
			ResultSet resultSet = stmtVeh.executeQuery ("select sal_code,doc_no,sal_name from my_salesman where sal_type='SLA' and status<>7;");

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



public   JSONArray searchModel(String brandval) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVeh3 = conn.createStatement ();
        	
			String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid="+brandval+" and status<>7;");
			
			
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

public   JSONArray searchColor() throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null;
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();
        	
			ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color  from my_color where status<>7 order by  doc_no;");

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
public   JSONArray searchGroup(String brand,String models) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
   
	try {
			 conn = connDAO.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();
        	
			String sql= ("Select v.doc_no,trim(g.gname) gname,g.doc_no from gl_vehmaster v "
					+ "left join gl_vehgroup g on g.doc_no=v.vgrpid where v.brdid='"+brand+"' and v.vmodid='"+models+"' group by g.doc_no;");
			//System.out.println("-------------"+sql);
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
public   JSONArray grouptariffType() throws SQLException {

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

public   JSONArray reloadpayment(HttpSession session,String bookdocno1) throws SQLException {

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
			 conn = connDAO.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
        	String pySql=("select rdocno, payment, mode, amount, acode, cardno, expdate, recieptno, brhid, payid, card, paytype, cardtype from gl_bpyt where rdocno='"+bookdocno1+"' and brhid="+brcid+" ");
        	//System.out.println("========"+pySql);
			ResultSet resultSet = stmtVeh1.executeQuery(pySql);

			RESULTDATA=commDAO.convertToJSON(resultSet); 
			stmtVeh1.close();
			conn.close();

	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}


public   JSONArray tariffratereload(HttpSession session,String txtrentaldocno,String group) throws SQLException {

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
        	
			String  tarifsql=("select rdocno,gid,rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg "
					+ " from gl_btarif where rdocno='"+txtrentaldocno+"' and gid='"+group+"' order by rstatus");
			//System.out.println("------------------------------"+tarifsql);
			
			ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
			RESULTDATA=commDAO.convertToJSON(resultSet);
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
public   JSONArray tariffslrelode(HttpSession session,String refno,String slno,String groupid) throws SQLException {

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
        	
			String  tarifsql=("select aa.status,doc_no,gid,rentaltype,rate,cdw,pai,kmrest,exkmrte,cdw1,pai1,gps,babyseater,cooler,oinschg,exhrchg from "
					+ " (select @s:=@s+1 status,m1.doc_no,m1.gid,m2.rentaltype,m1.rate,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler "
					+ ",m1.oinschg,m1.exhrchg from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  right join gl_tlistm m2 on m1.renttype=m2.rentaltype "
					+ " left join gl_quotd u on u.rdocno='"+refno+"' and u.srno='"+slno+"' ,(SELECT @s:= 0) AS s "
					+ "   where m1.gid='"+groupid+"'    and    m.doc_no=u.tdocno  and m2.status=1 order by m2.doc_no) aa "
					+ "union all "
					+ " (select 5,m1.doc_no,m1.gid,m2.rentaltype,m1.rate,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.cdw1,m1.pai1,m1.gps,m1.babyseater,m1.cooler "
					+ " ,m1.oinschg,m1.exhrchg from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  right join gl_tlistm m2 on m1.renttype=m2.rentaltype "
					+ "  left join gl_quotd u on u.rdocno='"+refno+"' and u.srno='"+slno+"' where m1.gid='"+groupid+"'    and   m.doc_no=u.tdocno "
					+ "  and m2.status=1 and u.rdocno='"+refno+"' and u.srno='"+slno+"' and m2.rentaltype=u.rentaltype    order by m2.doc_no ) "
					+ " union all "
					+ "(select 6,m1.doc_no,m1.gid,'Discount',m1.rate-qt.tariff,m1.cdw-qt.cdw,m1.pai-qt.pai,m1.kmrest-qt.kmrest,m1.exkmrte-qt.exkmrte, "
					+ " m1.cdw1-qt.cdw1,m1.pai1-qt.pai1,m1.gps-qt.gps,m1.babyseater-qt.babyseater,m1.cooler-qt.cooler  "
					+ ",m1.oinschg-qt.oinschg,m1.exhrchg-qt.exhrchg from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  right join  "
					+ " gl_tlistm m2 on m1.renttype=m2.rentaltype  left join gl_quotd qt on qt.rdocno='"+refno+"' and qt.srno='"+slno+"' where m1.gid='"+groupid+"'    and "
					+ "   m.doc_no=qt.tdocno  and m2.status=1 and qt.rdocno='"+refno+"' and qt.srno='"+slno+"' and m2.rentaltype=qt.rentaltype  order by m2.doc_no ) "
					+ " union all "
					+ " (select 7,qt.tdocno,qt.grpid,'Net Total',qt.tariff rate,qt.cdw,qt.pai,qt.kmrest,qt.exkmrte,qt.cdw1,qt.pai1, "
					+ "  qt.gps,qt.babyseater,qt.cooler,qt.oinschg,qt.exhrchg  from gl_quotd qt left join gl_tarifexcess t on  t.rdocno=qt.tdocno and t.gid=qt.grpid "
					+ " where qt.rdocno='"+refno+"' and qt.srno='"+slno+"')");
			//System.out.println("------------------------------"+tarifsql);
			
			ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
			RESULTDATA=commDAO.convertToJSON(resultSet);
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


/*public  JSONArray tariffratereload(HttpSession session,String bookdocno,String group) throws SQLException {

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
    Connection conn =null;
    String brnch=session.getAttribute("BRANCHID").toString();

	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh5 = conn.createStatement ();
        	
			String  tarifsql=("select rdocno,gid,rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg from gl_btarif where rdocno='"+bookdocno+"' and gid='"+group+"' and brhid='"+brnch+"' order by sr_no");
			//System.out.println("------------------------------"+tarifsql);
			
			ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
			RESULTDATA=commDAO.convertToJSON(resultSet);
			stmtVeh5.close();
			conn.close();
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}*/

public   JSONArray searchMaster(HttpSession session,String qutdocno,String clientname,String clmob,String qutdate,String quttype,String regno) throws SQLException {


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
   		sqltest=sqltest+" and b.voc_no like '%"+qutdocno+"%'";
   	}
   	if(!(clientname.equalsIgnoreCase(""))){
   		sqltest=sqltest+" and a.refname like '%"+clientname+"%'";
   	}
   	if(!(clmob.equalsIgnoreCase(""))){
   		sqltest=sqltest+" and b.contactno like '%"+clmob+"%'";
   	}
   	
   	if(!(quttype.equalsIgnoreCase(""))){
   		
   		sqltest=sqltest+" and b.reftype like '%"+quttype+"%'";
   	}
  	if(!(regno.equalsIgnoreCase(""))){
   		
   		sqltest=sqltest+" and vh.reg_no like '%"+regno+"%'";
   	}
   		
   	
   	
   	 if(!(sqlStartDate==null)){
   		sqltest=sqltest+" and b.date='"+sqlStartDate+"'";
   	} 
   	Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();
           	
				String clssql= ("select convert(CONCAT(UCASE(MID(usr.user_name,1,1)),LCASE(MID(usr.user_name,2))),char(100)) as usrname,b.voc_no,qt.voc_no qoutrefno,b.refclientdet,rag.voc_no rano,b.tdocno,b.acno,round(b.insuex,2) insuex,b.invtype,b.advchk,b.locid,round(b.delchg,2) delchg,b.fleet_no,b.Doc_No,b.date,b.reftype,b.refno,b.sagid,b.attn,b.contactno,b.guestdet,b.rsrno,b.brdid,b.modid, "
						+ "b.colid,b.grpid,b.rtype,b.frmDate,b.FrmTime,b.todate,b.toTime,b.delivery,b.chuef,b.delloc,b.remarks,b.status,b.clstatus,b.cltype,b.cldocno, "
						+ "b.clreason,b.email,a.refname,a.address,ag.sal_name,vb.brand_name,vm.vtype model,vc.color,vg.gname "
						+ "from gl_bookingm b left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM'  left join my_salesman ag on ag.doc_no=b.sagid and sal_type='SLA' "
						+ "left join gl_vehbrand vb on vb.doc_no=b.brdid left join gl_vehmaster vh on vh.fleet_no=b.fleet_no "
						+ "left join gl_vehmodel vm on vm.doc_no=b.modid "
						+ "left join my_color vc on vc.doc_no=b.colid  "
						+ "left join gl_quotm qt on qt.doc_no=b.refno  "
						+ "left join gl_ragmt rag on rag.doc_no=b.rano  "
						+ "left join gl_vehgroup vg on vg.doc_no=b.grpid left join my_user usr on usr.doc_no=b.userid where b.status=3 and b.brhid='"+brid+"' " +sqltest+" group by b.Doc_No");
				//System.out.println("========"+clssql);
				ResultSet resultSet = stmtenq1.executeQuery(clssql);
				
				RESULTDATA=commDAO.convertToJSON(resultSet);
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


public   JSONArray vehSearch(HttpSession session) throws SQLException {


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
				Statement stmtVeh8 = conn.createStatement ();
           	
		
				
				
		/*		String vehsql=" select *  from (select v.reg_no,v.fleet_no,v.FLNAME,convert(if(v.fleet_no>0,'',''),char(20)) days from gl_vehmaster v "
						+ "	left join gl_vmove m on v.fleet_no=m.fleet_no     	where v.a_br=1 and ins_exp >=current_date and v.statu <> 7 and "
						+ "m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and  fstatus in ('L','N') "
						+ " and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','R')) aa 	union all "
						+ "(select v.reg_no,v.fleet_no,v.FLNAME,convert((SELECT DATEDIFF(r.ddate,curdate())),char(20)) AS days from gl_vehmaster v  "
						+ " inner join gl_ragmt r on(r.fleet_no=v.fleet_no and r.clstatus=0 and date_add(curdate(), INTERVAL 15 DAY)>r.ddate) )";*/
				
				
				String vehsql="select *  from (select v.a_loc,v.reg_no,v.fleet_no,v.FLNAME,convert(if(v.fleet_no>0,'',''),char(20)) days,c.color,v.clrid,g.gname,v.vgrpid,vb.brand_name,v.brdid,vm.vtype model,v.vmodid  from gl_vehmaster v   "
						+ "	left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g  on g.doc_no=v.vgrpid  "
						+ " left join gl_vehbrand vb on vb.doc_no=v.brdid left join gl_vehmodel vm on vm.doc_no=v.vmodid where v.a_br='"+brid+"' "
						+ " and ins_exp >=current_date and v.statu <> 7	 and m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and "
						+ " fstatus in ('L','N')  and v.status='IN'	  and v.tran_code='RR' and v.renttype in ('A','R')) aa 	union all "
						+ " (select v.a_loc,v.reg_no,v.fleet_no,v.FLNAME, convert((SELECT DATEDIFF(r.ddate,curdate())),char(20)) AS days,c.color,v.clrid,g.gname, "
						+ "v.vgrpid,vb.brand_name,v.brdid,vm.vtype model,v.vmodid  from gl_vehmaster v "
						+ "left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g  on g.doc_no=v.vgrpid  "
						+ " left join gl_vehbrand vb on vb.doc_no=v.brdid left join gl_vehmodel vm on vm.doc_no=v.vmodid "
						+ " inner join gl_ragmt r on(r.fleet_no=v.fleet_no and r.clstatus=0 and date_add(curdate(), INTERVAL 30 DAY)>r.ddate))";
				
				
		//	System.out.println("---------------"+vehsql);
				ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
				
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVeh8.close();
				
			
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
   



}


