package com.project.execution.ServiceSale;

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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsVatInsert;
import com.common.ClsApplyDelete;
import com.connection.ClsConnection;
import com.project.execution.ServiceSale.ClsServiceSaleDAO;
import com.sun.corba.se.spi.legacy.connection.GetEndPointInfoAgainException;

public class ClsServiceSaleDAO  {
	
	ClsCommon commDAO=new ClsCommon();
	
	ClsConnection connDAO=new ClsConnection();
	
	Connection conn;
public int insert(Date sqlStartDate,Date purdeldate, String reftype,String refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,
		HttpServletRequest request, Date sqlinvdate, String invno,String indateval,int interstate,Double taxperc,ClsServiceSaleAction masteraction) throws SQLException {
	try{
		int docno;
		
		 conn=connDAO.getMyConnection();
		 conn.setAutoCommit(false);
//		 System.out.println("cmbcurr---"+cmbcurr+"=currate="+currate);
		 
		 Statement stmt = conn.createStatement ();
		   ArrayList<String> outamtarray=new ArrayList<>();
		  String upsql="select method from gl_config where field_nme like'tax'";
		   ResultSet resultSet = stmt.executeQuery(upsql);
		    int docval = 0;
		    if (resultSet.next()) {
		    	docval=resultSet.getInt("method");
		    }		  
 if(docval==0)
 {
		    String upsql2="select method from gl_prdconfig where field_nme like'tax'";
			   ResultSet resultSet2 = stmt.executeQuery(upsql2);
			   
			    if (resultSet2.next()) {
			    	docval=resultSet2.getInt("method");
			    }
 }
		    
		    

		CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSaleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtnipurchase.registerOutParameter(16, java.sql.Types.INTEGER);
		
		 
		
		stmtnipurchase.setInt(18, java.sql.Types.INTEGER);
		stmtnipurchase.setDate(1,sqlStartDate);
		stmtnipurchase.setString(2,refno);
		stmtnipurchase.setString(3,acctype);
		stmtnipurchase.setString(4,accdoc);
	   	stmtnipurchase.setString(5,cmbcurr);
		stmtnipurchase.setString(6,currate);
		stmtnipurchase.setString(7,delterms);
		stmtnipurchase.setString(8,payterms);
		stmtnipurchase.setString(9,purdesc);
		stmtnipurchase.setDate(10,purdeldate);
		stmtnipurchase.setDouble(11,nettotal);
		stmtnipurchase.setString(12,Formdetailcode);
		stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
		stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
		stmtnipurchase.setString(15,reftype);
		stmtnipurchase.setString(17,mode);
		stmtnipurchase.setInt(19,interstate);
//		System.out.println("--stmtnmipurchase-- "+stmtnipurchase.toString());
 
		stmtnipurchase.executeQuery();
		docno=stmtnipurchase.getInt("docNo");
		int vocno=stmtnipurchase.getInt("vocNo");
		int intrstate=stmtnipurchase.getInt("vinterstate");
		request.setAttribute("vocno", vocno);
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		else{
			//Updating Delivery No
			
			String strupdatemaster="update my_srvsalem set delno='"+masteraction.getDelno()+"' where doc_no="+docno+" and brhid="+session.getAttribute("BRANCHID").toString()+"";
			int updatemaster=stmt.executeUpdate(strupdatemaster);
			if(updatemaster<=0){
				System.out.println(strupdatemaster);
				conn.close();
				return 0;
			}
		}
		int tranno=0;
		int j=0;
		int sno=0;
		
		double fdramt=0.0,cmbcurrency=1.0,rate=1.0;  
		double tdramt=0.0;
		
		int count=0;
		
		int iapprovalStatus=3;
		double masteramount=0;
//		System.out.println(docval);
		 /*if(docval>0){
			 Statement stmt21 = conn.createStatement ();
			 Statement stmtt=conn.createStatement();
			 Statement stmtt2=conn.createStatement();
			
		    		 if(intrstate>0){
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and cstper>0";
		 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
		 		    	 while(resultSet3.next()){
		    			 double amount=((nettotal*resultSet3.getDouble("cstper"))/100);
		    			 masteramount=(masteramount+amount);
		    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet3.getInt("docno")+","+resultSet3.getInt("acno")+","+resultSet3.getDouble("cstper")+","+amount+")";
		    			stmtt.executeUpdate(sql);
		    		 }
		 		    	 }
		    		 else{
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and per>0";
		 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
		 		    	 while(resultSet4.next()){
		    			 double amount=((nettotal*resultSet4.getDouble("per"))/100);
		    			 masteramount=(masteramount+amount);
			    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet4.getInt("docno")+","+resultSet4.getInt("acno")+","+resultSet4.getDouble("per")+","+amount+")";
			    			stmtt.executeUpdate(sql);
		    		 }
				       }
		    	
		    }*/
		String refdetails="SRS"+""+vocno;
		
//		System.out.println("==================+"+refno);
		
		String jvdesc="";
		
		 
		int jvm=0;
		Statement sstst=conn.createStatement();
		ResultSet rsssss= sstst.executeQuery("SELECT method FROM GL_PRDCONFIG where field_nme='jvdescpass'") ;
		if(rsssss.first())
		{
			jvm=rsssss.getInt("method");			}

	 
		if(jvm==1)
		{
			jvdesc="Ref No-"+invno+" "+purdesc;
		}
		else
		{
			jvdesc="Ref-"+refno+"-"+invno+" "+purdesc;
		}
		
		
		String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
	
		ResultSet tass = stmtnipurchase.executeQuery (trsql);
		
		if (tass.next()) {
			tranno=tass.getInt("trno");		
	     }
		
		String appsql="select count(*)   icount from my_apprmaster where status=3 and dtype='"+Formdetailcode+"'";
		ResultSet appsqlrs = stmtnipurchase.executeQuery(appsql);
		if (appsqlrs.next()) {
			count=appsqlrs.getInt("icount");		
	     }
		if(count==0)
		{
			iapprovalStatus=3;
		}
		else
		{
			iapprovalStatus=0;
		}
		
		request.setAttribute("trans",tranno);
		String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
		int dd=stmtnipurchase.executeUpdate(trnosql);
				 if(dd<=0)
					{
						conn.close();
						return 0;
					}
		double nettaxtot = 0;
		 /* Due Date Selection*/	
		int period=0;
		java.sql.Date sqlDuedate = null;
	    String s1sql = "SELECT coalesce(period2,0) period2 FROM my_head h LEFT JOIN my_acbook ac ON ac.cldocno=h.cldocno AND ac.dtype='crm' WHERE h.doc_no='"+accdoc+"'";  
		ResultSet s1rs = stmtnipurchase.executeQuery (s1sql);
		if (s1rs.next()) {
			period = s1rs.getInt("period2");		
		}
		String s2sql = "SELECT DATE_ADD('"+sqlStartDate+"', INTERVAL "+period+" DAY) duedate";      
		ResultSet s2rs = stmtnipurchase.executeQuery (s2sql);
		if (s2rs.next()) {
			sqlDuedate = s2rs.getDate("duedate"); 	 	
		}
		/* Due Date Selection*/	 	 
		for(int i=0;i< descarray.size();i++){
			
			String[] purorderarray=descarray.get(i).split("::");
			//String newjvdesc=""+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
		
			String newjvdesc=jvdesc;
			String nettax=""+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim());
			
//			System.out.println("==nettax==="+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim()));
			
			nettaxtot+=Double.parseDouble(nettax);
			
			if(i==descarray.size()-1){
//			System.out.println("==nettaxtot==="+nettaxtot);
				double dramt=nettotal+nettaxtot;
				double as=Double.parseDouble(currate);
				double ldramt=dramt*as;
				
				dramt=commDAO.Round(dramt,2);
				ldramt=commDAO.Round(ldramt,2);
				
				String sql1="insert into my_jvtran(date,duedate,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 		+ "values('"+sqlStartDate+"','"+sqlDuedate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
				 
//			   System.out.println("client account sql ="+sql1);
				 int ss = stmtnipurchase.executeUpdate(sql1);

			     if(ss<=0)
					{
						conn.close();
						return 0;
					}
				
			}
		
			double taxper,tax,nettaxamount;
			Statement stmt21=conn.createStatement();
			String sqltax="select per  from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0;";
			ResultSet resultSet3 = stmt21.executeQuery(sqltax);
	    	 while(resultSet3.next()){
	    		 taxper=resultSet3.getDouble("per");
	    		 tax=((nettotal*resultSet3.getDouble("per"))/100);
	    		 nettaxamount=nettotal+tax;
	    	 }
	    	 
	    	 
			 
	    	 Double netamount=Double.parseDouble((purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?"0":purorderarray[6].trim()+"")); 
		    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
		     {
	
	    		 String sql="INSERT INTO my_srvsaled(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
					       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
					       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
					       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
					       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
					       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
					       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
					       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
					       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
					       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
					       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
					       + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
					       + "'"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"',"
					       + "'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"',"
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'"+docno+"')";
	    		// System.out.println("__saled--"+sql);
	    		 int resultSet2 = stmtnipurchase.executeUpdate(sql);
			     
			     if(resultSet2<=0)
					{
						conn.close();
						return 0;
						
					}
			     String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
			     int acno=Integer.parseInt(acno1);
			     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
			     //fdramt=Double.parseDouble(tmp)*1;
			     //tdramt=fdramt*rate;   //*Double.parseDouble(currate) since 2022-03-26    
			    
			     fdramt=(Double.parseDouble(tmp)*1)*Double.parseDouble(currate);
			     tdramt=fdramt;    
			     
			     fdramt=commDAO.Round(fdramt,2);
			     tdramt=commDAO.Round(tdramt,2);
			     
			     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
		 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
 				+ "'"+newjvdesc+"', "+ "'"+cmbcurrency+"','"+rate+"',"+fdramt*-1+","+tdramt*-1+",0,-1,5,"+(i+1)+",0,0,0,'SRS', "
				+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"','"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
				+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
				     
			   //  System.out.println("other account sql ="+don);	
			int samp=stmtnipurchase.executeUpdate(don);
   
			     
			 if(samp<=0)
				{
					conn.close();
					return 0;
					
				}
					//}
			      
			 if(!(purorderarray[11].trim().equalsIgnoreCase("undefined")|| purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty() ||purorderarray[11].trim().equalsIgnoreCase("0")))
		     {
				 int TRANID=0;
				 sno=sno+1;
				  String tmp1=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
				  double  fdramt1=Double.parseDouble(tmp1)*-1;
			    		
			
					String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"' ";
			
					ResultSet tass1 = stmtnipurchase.executeQuery (trsqlss);
					
					if (tass1.next()) {
				
						TRANID=tass1.getInt("TRANID");	
					
					
						
				     }
					
					String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
							+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
							 
			  int costabsq=  stmtnipurchase.executeUpdate(ssql);
			  
			  if(costabsq<=0)
				{
					conn.close();
					return 0;
					
				}
			  
		     }
				String updat="update  my_srvsalem set tr_no="+tranno+",invno='"+invno+"',invdate='"+sqlinvdate+"' where doc_no="+docno+"  ";
				  int tabs=  stmtnipurchase.executeUpdate(updat);
				  if(tabs<=0)
					{
						conn.close();
						return 0;
					}
		     }
	     }
		 if(docval>0){
			 Statement stmt21 = conn.createStatement ();
			 Statement stmtt=conn.createStatement();
			 Statement stmtt2=conn.createStatement();
			 String newjvdesc=jvdesc;
		    		 if(intrstate>0){
		    			 double amount,dramt=0,as,ldramt = 0;
		    			 long acno=0;
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
		 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
		 		    	 while(resultSet3.next()){
		 		    		amount=((nettaxtot)*-1);
		    			 	//dramt=amount;
			 				//ldramt=dramt*rate; //*as since 2022-03-26
			 				
			 				dramt=amount*Double.parseDouble(currate);;
			 				ldramt=dramt;
			 				acno=resultSet3.getLong("acno");
			 				
			 				dramt=commDAO.Round(dramt,2);
			 				ldramt=commDAO.Round(ldramt,2);
		 		    	 }

		 		    	 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurrency+"','"+rate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
		 				 
		 			//	System.out.println(sql1);
		 				if(taxperc>0){
		 				 int ss = stmtnipurchase.executeUpdate(sql1);

		 			     if(ss<=0)
		 					{
		 						conn.close();
		 						return 0;
		 						
		 					}
		 				}
		 		    	 }
		    		 else{
		    			 double amount,dramt=0,as,ldramt = 0;
		    			 long acno=0;
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
		 		    	 while(resultSet4.next()){
		 		    		amount=((nettaxtot)*-1);
		    			 	//dramt=amount;
			 				//ldramt=dramt*rate;  //*as since 2022-03-26  
			 				
			 				dramt=amount*Double.parseDouble(currate);
			 				ldramt=dramt;
			 				
			 				acno=resultSet4.getLong("acno");
			 				
			 				dramt=commDAO.Round(dramt,2);
			 				ldramt=commDAO.Round(ldramt,2);
		 		    	 }
		 		    	 
			 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurrency+"','"+rate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 				 
//			 			System.out.println("--sql1jvtran--"+sql1);
			 			if(taxperc>0){	 
			 				int ss = stmtnipurchase.executeUpdate(sql1);
//			 				System.out.println("+sql1 status++--"+ss);
			 			     if(ss<=0)
			 					{
			 						conn.close();
			 						return 0;
			 						
			 					}
			 			}			    		
				       }
		    	
		    }
		

		 ArrayList<String> arr=new ArrayList<String>(); 
			ClsVatInsert ClsVatInsert=new ClsVatInsert();
			Statement newStatement=conn.createStatement();
			String selectsqls= "select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3, "
					+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
					+"  sum(a.total9) total9,sum(a.total10) total10, "
					+"  sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,sum(a.tax6) tax6, "
					+"  sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
					+"  from ( "
				+" 	 select  d.nettotal+coalesce(d.tax,0) nettaxamount,if(coalesce(d.tax,0)>0,d.nettotal,0) total1, "
					+"  if(coalesce(d.tax,0)=0,d.nettotal,0) total2 ,0 total3, "
					 +"  0 total4,0 total5, "
					+"  0 total6,0 total7, "
					+"  0 total8,0 total9, "
					+"  0 total10, "
					+"  if(d.tax>0,d.tax,0) tax1,  0 tax2, "
					+"  0 tax3,  0 tax4, "
					+"  0 tax5, 0 tax6, "
					+"  0 tax7,  0 tax8, "
					+"  0 tax9,  0 tax10 "
					 +"  from my_srvsaled d where rdocno="+docno+" ) a" ;
			

		//System.out.println("===ABC===="+selectsqls);
			
			
			ResultSet rss101=newStatement.executeQuery(selectsqls);
			if(rss101.first())
				{
				arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
						rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
						rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
						rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
						rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
						rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
						rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
				}   
			
				int result=ClsVatInsert.vatinsert(1,2,conn,tranno,Integer.parseInt(accdoc),vocno,sqlStartDate,Formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,1,arr,mode)	;
					if(result==0)	
				        {
						conn.close();
						return 0;
						}
		       

		
		    
	if (docno > 0) {
		
		int total=0;
		String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+tranno+"";
		ResultSet rsJv = stmtnipurchase.executeQuery(sql1);
	    
		 while (rsJv.next()) {
			 total=rsJv.getInt("jvtotal");
		 }
		 
		 if(total == 0){
			String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+tranno+"'";
			stmtnipurchase.executeUpdate(sqlss10);
			conn.commit();
			stmtnipurchase.close();
			conn.close();
			return docno;
		 }else{
		        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
		        stmtnipurchase.close();
			    return 0;
		    }
		
	
	}
}catch(Exception e){	
	conn.close();
e.printStackTrace();
return 0;
}
return 0;
}

public boolean edit(int docno,Date sqlStartDate,Date purdeldate, String reftype, String refno, String acctype,
		String accdoc, String puraccname, String cmbcurr, String currate,
		String delterms, String payterms, String purdesc,
		HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,
		String Formdetailcode,int tranno,HttpServletRequest request,Date sqlinvdate,
		String invno,String indateval,int interstate,Double taxperc,ClsServiceSaleAction masteraction) throws SQLException {
	
	try{
		
		 conn=connDAO.getMyConnection();
		 conn.setAutoCommit(false);
		 Statement stmt33 = conn.createStatement ();
		 
		  String upsql="select method from gl_config where field_nme like'tax'";
		   ResultSet resultSet33 = stmt33.executeQuery(upsql);
		    int docval = 0;
		    if (resultSet33.next()) {
		    	docval=resultSet33.getInt("method");
		    }		  
if(docval==0)
{
		    String upsql2="select method from gl_prdconfig where field_nme like'tax'";
			   ResultSet resultSet2 = stmt33.executeQuery(upsql2);
			   
			    if (resultSet2.next()) {
			    	docval=resultSet2.getInt("method");
			    }
}
		    
		CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSaleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtnipurchase.setDate(1,sqlStartDate);
		stmtnipurchase.setString(2,refno);
		stmtnipurchase.setString(3,acctype);
		stmtnipurchase.setString(4,accdoc);
	   	stmtnipurchase.setString(5,cmbcurr);
		stmtnipurchase.setString(6,currate);
		stmtnipurchase.setString(7,delterms);
		stmtnipurchase.setString(8,payterms);
		stmtnipurchase.setString(9,purdesc);
		stmtnipurchase.setDate(10,purdeldate);
		stmtnipurchase.setDouble(11,nettotal);
		stmtnipurchase.setString(12,Formdetailcode);
		stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
		stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
		stmtnipurchase.setString(15,reftype);
		stmtnipurchase.setInt(16,docno);
		stmtnipurchase.setString(17,"E");
		stmtnipurchase.setInt(18, 0);
		stmtnipurchase.setInt(19,interstate);
		int aaa=stmtnipurchase.executeUpdate();
		docno=stmtnipurchase.getInt("docNo");
//		System.out.println("=="+stmtnipurchase.toString());
		if(aaa<=0)
		{
			conn.close();
			return false;
			
		}	
		else{
			int applydelete=0;
			ClsApplyDelete applyDelete = new ClsApplyDelete();
			applydelete=applyDelete.getFinanceApplyDelete(conn, tranno);
		    if(applydelete<0){
		    	System.out.println("*** ERROR IN APPLY DELETE ***");
		    	stmtnipurchase.close();
		        conn.close();
		        return false;
		    }
		    
			//Updating Delivery No
			String strupdatemaster="update my_srvsalem set delno='"+masteraction.getDelno()+"' where doc_no="+docno+" and brhid="+session.getAttribute("BRANCHID").toString()+"";
			System.out.println(strupdatemaster);
			int updatemaster=stmt33.executeUpdate(strupdatemaster);
			if(updatemaster<=0){
				System.out.println("Update Master Error");
				conn.close();
				return false;
			}
		}
	    double cmbcurrency=1.0,rate=1.0;   
	      
		   String delsql="Delete from my_srvsaled where rdocno="+docno+" and brhid='"+session.getAttribute("BRANCHID").toString()+"' ";
		   stmtnipurchase.executeUpdate(delsql);
		   
		   String delsql1="Delete from my_jvtran where tr_no="+tranno+" ";
		   stmtnipurchase.executeUpdate(delsql1);
		   
		   String delsql2="Delete from my_costtran where tr_no="+tranno+" ";
		   stmtnipurchase.executeUpdate(delsql2);
		   
		   String delsql3="Delete from my_srvtaxsale where rdocno="+docno+" ";
		   stmtnipurchase.executeUpdate(delsql3);
		   
		   
		 
			int j=0;
			int sno=0;
			double fdramt=0;
			double tdramt=0;
			Statement stmt =conn.createStatement();
			
			int vocno=0;
			
			String sqlss="select voc_no from my_srvsalem where doc_no='"+docno+"' ";
			ResultSet rss=stmt.executeQuery(sqlss);
			
			if(rss.next())
			
			{
				
				vocno=rss.getInt("voc_no");
				
			}
			double masteramount=0;
			/*if(docval>0){
				 Statement stmt21 = conn.createStatement ();
				 Statement stmtt=conn.createStatement();
				 Statement stmtt2=conn.createStatement();
				
			    		 if(interstate>0){
			    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and cstper>0";
			 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
			 		    	 while(resultSet3.next()){
			    			 double aamount=((nettotal*resultSet3.getDouble("cstper"))/100);
			    			 masteramount=(masteramount+aamount);
			    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet3.getInt("docno")+","+resultSet3.getInt("acno")+","+resultSet3.getDouble("cstper")+","+aamount+")";
			    			stmtt.executeUpdate(sql);
			    		 }
			 		    	 }
			    		 else{
			    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where '"+sqlStartDate+"' between fromdate and todate and per>0";
			 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
			 		    	 while(resultSet4.next()){
			    			 double aamount=((nettotal*resultSet4.getDouble("per"))/100);
			    			 masteramount=(masteramount+aamount);
				    			String sql="insert into my_srvtaxsale  (rdocno, taxid, acno, per, amount) values("+docno+","+resultSet4.getInt("docno")+","+resultSet4.getInt("acno")+","+resultSet4.getDouble("per")+","+aamount+")";
				    			stmtt.executeUpdate(sql);
			    		 }
					       }
			    	
			    }*/
			
			String refdetails="SRS"+""+vocno;
			//String jvdesc="SRS-"+""+invno+""+":-Dated :- "+indateval+"";  
			String jvdesc=""; 
			
			int jvm=0;
			Statement sstst=conn.createStatement();
			ResultSet rsssss= sstst.executeQuery("SELECT method FROM GL_PRDCONFIG where field_nme='jvdescpass'") ;
			if(rsssss.first())
			{
				jvm=rsssss.getInt("method");			}

		 
			if(jvm==1)
			{
				jvdesc="Ref No-"+invno+" "+purdesc;
			}
			else
			{
				jvdesc="Ref-"+refno+"-"+invno+" "+purdesc;
			}
			
//			System.out.println("descarray--->>>"+descarray);          
			double nettaxtot = 0;
			 /* Due Date Selection*/	
			int period=0;
			java.sql.Date sqlDuedate = null;
		    String s1sql = "SELECT coalesce(period2,0) period2 FROM my_head h LEFT JOIN my_acbook ac ON ac.cldocno=h.cldocno AND ac.dtype='crm' WHERE h.doc_no='"+accdoc+"'";  
			ResultSet s1rs = stmtnipurchase.executeQuery (s1sql);
			if (s1rs.next()) {
				period = s1rs.getInt("period2");		
			}
			String s2sql = "SELECT DATE_ADD('"+sqlStartDate+"', INTERVAL "+period+" DAY) duedate";      
			ResultSet s2rs = stmtnipurchase.executeQuery (s2sql);
			if (s2rs.next()) {
				sqlDuedate = s2rs.getDate("duedate"); 	 	
			}
			/* Due Date Selection*/ 
			for(int i=0;i< descarray.size();i++){
				 String[] purorderarray=descarray.get(i).split("::");
				// String newjvdesc=""+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
					String newjvdesc=jvdesc;
				 if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
//			     System.out.println("purorderarray[8]==="+purorderarray[8].trim());	
				 String nettax=""+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("") || purorderarray[8].isEmpty() || purorderarray[8]==null?0:purorderarray[8].trim());
				 nettaxtot+=Double.parseDouble(nettax);
			     }      
				 if(i==descarray.size()-1){         
					double dramt=nettotal+nettaxtot;
					double as=Double.parseDouble(currate);
					double ldramt=dramt*as;
					 
					dramt=commDAO.Round(dramt,2);
					ldramt=commDAO.Round(ldramt,2);
					
					 String sql1="insert into my_jvtran(date,duedate,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlStartDate+"','"+sqlDuedate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+jvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
	                 //System.out.println("sql1--->>>"+sql1);                        
					 int ss = stmtnipurchase.executeUpdate(sql1);  

				     if(ss<=0)
						{
							conn.close();
							return false;
							
						}
					
				}
				
			
				Double netamount=0.0;   
				if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
					 netamount=Double.parseDouble((purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?"0":purorderarray[6].trim()+""));
			    	String sql="INSERT INTO my_srvsaled(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
						       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
						       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
						       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
						       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
						       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
						       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
						       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
						       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
						       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
						       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
						       + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
						       + "'"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"',"
						       + "'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"',"
						       + "'"+session.getAttribute("BRANCHID").toString()+"',"
						       +"'"+docno+"')";
				     int resultSet21 = stmtnipurchase.executeUpdate(sql);
				     
				     if(resultSet21<=0)
						{
							conn.close();
							return false;
							
						}
				  String acno1=""+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"";
					    int acno=Integer.parseInt(acno1);
				
					     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					      			//fdramt=Double.parseDouble(tmp)*1;
					     		    //tdramt=fdramt*rate; //*Double.parseDouble(currate) since 2022-03-26
					     		    
					     		   fdramt=(Double.parseDouble(tmp)*1)*Double.parseDouble(currate);
								     tdramt=fdramt;  
					     
					     		   fdramt=commDAO.Round(fdramt,2);
								     tdramt=commDAO.Round(tdramt,2);
					    		 
					     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
							 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', '"+newjvdesc+"', "
						+ "'"+cmbcurrency+"','"+rate+"',"+(fdramt*-1)+","+tdramt*-1+",0,-1,5,"+(i+1)+",0,0,0,'SRS', "
						+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3,'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
						+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
					
					int samp=	stmtnipurchase.executeUpdate(don);

					     
					 if(samp<=0)
						{
							conn.close();
							return false;
							
						}
						//	}
				 
				 
					 if(!(purorderarray[11].trim().equalsIgnoreCase("undefined")|| purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty() ||purorderarray[11].trim().equalsIgnoreCase("0")))
				     {
					 int TRANID=0;
					 sno=sno+1;
					  String tmp1=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
					  double  fdramt1=Double.parseDouble(tmp1)*-1;
						String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"' ";
						
						
						
						
						ResultSet tass1 = stmtnipurchase.executeQuery (trsqlss);
						
						if (tass1.next()) {
					
							TRANID=tass1.getInt("TRANID");	
						
						
							
					     }
						
					
						String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
								+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
								 
				  int costabsq=  stmtnipurchase.executeUpdate(ssql);
				  
				  if(costabsq<=0)
					{
						conn.close();
						return false;
						
					}
				  
			     }
				 
			     }
			  
		     }
		   
		
	//	System.out.println("aaaaaaaaaaaaaaaaa"+aaa);
		/*for(int i=0;i<descarray.size();i++){
	    	
		     String[] purorderarray=descarray.get(i).split("::");
		    
		     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
		     {
		    	 
		    	 String sql="INSERT INTO my_srvsaled(srno,qty,desc1,unitprice,total,discount,nettotal,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
					       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
					       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
					       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
					       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
					       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
					       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
					       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
					       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
					       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
					       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
					       + "'"+session.getAttribute("BRANCHID").toString()+"',"
					       +"'"+docno+"')";*/
		    	 
		/*    	 
	     String sql="update  my_srvsaled set SRNO="+(i+1)+","
	     		   + "qty='"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
			       + "desc1='"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
			       + "unitprice='"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
			       + "total='"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
			       + "discount='"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
			       + "nettotal='"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"'," 
	               + "nuprice='"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
	               + "costtype='"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
	               + "costcode='"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
	                + "remarks='"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
	            + "acno='"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
	            + "brhid='"+session.getAttribute("BRANCHID").toString()+"' where rdocno="+docno+"";*/
	      
	   //  System.out.println(""+sql);
	/*     int resultSet4 = stmtnipurchase.executeUpdate(sql);
	 	if(resultSet4<=0)
		{
			conn.close();
			return false;
			
		} 
		     }
		    
		}*/	
			
			 
			String updat="update  my_srvsalem set invno='"+invno+"',invdate='"+sqlinvdate+"' where doc_no="+docno+"  ";
				 
			  int tabs=  stmtnipurchase.executeUpdate(updat);
		 
			  if(tabs<=0)
				{
					conn.close();
					return false;
					
				}
			  
			  if(docval>0){
					 Statement stmt21 = conn.createStatement ();
					 Statement stmtt=conn.createStatement();
					 Statement stmtt2=conn.createStatement();
					 String newjvdesc=jvdesc;
					 
					 
				    		 if(interstate>0){
				    			 double aamount,dramt=0,as,ldramt = 0;
				    			 long acno=0;
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and cstper>0";
				 		    	ResultSet resultSet3 = stmt21.executeQuery(upsql1);
				 		    	 while(resultSet3.next()){
				 		    		aamount=((nettaxtot)*-1);
				    			 	//dramt=aamount;
					 				//ldramt=dramt*rate;  //*as since 2022-03-26
					 				
					 				dramt=aamount*Double.parseDouble(currate);
					 				ldramt=dramt; 
					 				acno=resultSet3.getLong("acno");
					 				
					 				dramt=commDAO.Round(dramt,2);
					 				ldramt=commDAO.Round(ldramt,2);
				 		    	 }
				 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurrency+"','"+rate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'3')";
				 				 
				 				if(taxperc>0){
					 				 int ss = stmtnipurchase.executeUpdate(sql1);
	
					 			     if(ss<=0)
					 					{
					 						conn.close();
					 						return false;
					 						
					 					}
				 				}
			    			 }
				    		 else{
				    			 double aamount,dramt=0,as,ldramt = 0;
				    			 long acno=0;
				    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
				 		    	ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
				 		    	 while(resultSet4.next()){
					    			 aamount=((nettaxtot)*-1);
					    			 //dramt=aamount;
						 			 //ldramt=dramt*rate;   //*as since 2022-03-26   
						 			 dramt=aamount*Double.parseDouble(currate);;
						 			 ldramt=dramt;
						 			 acno=resultSet4.getLong("acno");
						 			 
						 			dramt=commDAO.Round(dramt,2);
						 			ldramt=commDAO.Round(ldramt,2);
				 		    	 }	
					 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurrency+"','"+rate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'3')";
					 				 
					 				if(taxperc>0){
					 				 int ss = stmtnipurchase.executeUpdate(sql1);

					 			     if(ss<=0)
					 					{
					 						conn.close();
					 						return false;
					 						
					 					}
					 				}
				    		
						       }
				    	
				    }
			
				 ArrayList<String> arr=new ArrayList<String>(); 
					ClsVatInsert ClsVatInsert=new ClsVatInsert();
					Statement newStatement=conn.createStatement();
					String selectsqls= "select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3, "
							+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
							+"  sum(a.total9) total9,sum(a.total10) total10, "
							+"  sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,sum(a.tax6) tax6, "
							+"  sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
							+"  from ( "
						+" 	 select  d.nettotal+coalesce(d.tax,0) nettaxamount,if(coalesce(d.tax,0)>0,d.nettotal,0) total1, "
							+"  if(coalesce(d.tax,0)=0,d.nettotal,0) total2 ,0 total3, "
							 +"  0 total4,0 total5, "
							+"  0 total6,0 total7, "
							+"  0 total8,0 total9, "
							+"  0 total10, "
							+"  if(d.tax>0,d.tax,0) tax1,  0 tax2, "
							+"  0 tax3,  0 tax4, "
							+"  0 tax5, 0 tax6, "
							+"  0 tax7,  0 tax8, "
							+"  0 tax9,  0 tax10 "
							 +"  from my_srvsaled d where rdocno="+docno+" ) a" ;
					ResultSet rss101=newStatement.executeQuery(selectsqls);
					if(rss101.first())
						{
						arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
								rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
								rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
								rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
								rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
								rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
								rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
						}   
					
						int result=ClsVatInsert.vatinsert(1,2,conn,tranno,Integer.parseInt(accdoc),vocno,sqlStartDate,Formdetailcode,session.getAttribute("BRANCHID").toString(),""+vocno,1,arr,mode)	;
							if(result==0)	
						        {
								conn.close();
								return false;
								}
			
		if (aaa > 0) {
			
			int total=0;
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+tranno+"";
					ResultSet rsJv = stmtnipurchase.executeQuery(sql1);
				    
					 while (rsJv.next()) {
						 total=rsJv.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						 String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+tranno+"'";
							stmtnipurchase.executeUpdate(sqlss10);
						 	conn.commit();
							stmtnipurchase.close();
							conn.close();
							System.out.println("Sucess");
							return true;
					 }else{
					        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					        stmtnipurchase.close();
						    return false;
					    }
		
		}
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	return false;
}

public boolean delete(int docno,HttpSession session,String mode,String Formdetailcode) throws SQLException {
	try{
		conn=connDAO.getMyConnection();
		
//		System.out.println("0000000000000000-0000000000000");
		CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSaleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtnipurchase.setDate(1,null);
		stmtnipurchase.setString(2,null);
		stmtnipurchase.setString(3,null);
		stmtnipurchase.setString(4,null);
	   	stmtnipurchase.setString(5,null);
		stmtnipurchase.setString(6,null);
		stmtnipurchase.setString(7,null);
		stmtnipurchase.setString(8,null);
		stmtnipurchase.setString(9,null);
		stmtnipurchase.setDate(10,null);
		stmtnipurchase.setDouble(11,0.0);
		stmtnipurchase.setString(12,Formdetailcode);
		stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
		stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
		stmtnipurchase.setString(15,null);
		stmtnipurchase.setInt(16,docno);
		stmtnipurchase.setString(17,"D");
		stmtnipurchase.setInt(18,0);
		stmtnipurchase.setInt(19,0);
		int aaa=stmtnipurchase.executeUpdate();
		
		int tr_no=0;
	     
		ArrayList<String> arr=new ArrayList<String>(); 
		ClsVatInsert ClsVatInsert=new ClsVatInsert();
		Statement newStatement=conn.createStatement();
		String selectsqls= " select tr_no from my_srvsalem where doc_no="+docno+" " ;
//		System.out.println("selectsqlsselectsqlsselectsqls"+selectsqls);
		ResultSet rss101=newStatement.executeQuery(selectsqls);
		if(rss101.first())
			{
			tr_no=rss101.getInt("tr_no");
			}   
		
		int applydelete=0;
		ClsApplyDelete applyDelete = new ClsApplyDelete();
		applydelete=applyDelete.getFinanceApplyDelete(conn, tr_no);
	    if(applydelete<0){
	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	    	stmtnipurchase.close();
	        conn.close();
	        return false;
	    }
		
		 	int result=ClsVatInsert.vatinsert(1,2,conn,tr_no,0,0,null,Formdetailcode,session.getAttribute("BRANCHID").toString(),"",1,arr,"D")	;
//			System.out.println("result"+result);
			if(result==0)	
			        {
					conn.close();
					return false;
					}
 
		
		if (aaa > 0) {
			stmtnipurchase.close();
			conn.close();
			//System.out.println("Success");
			return true;
		}	
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	return false;
}

public   JSONArray accountsDetailsTo(String type,String accno,String accname,String mobileno,String id) throws SQLException {
		
	JSONArray RESULTDATA=new JSONArray();
	
	if(!(id.equalsIgnoreCase("1"))){
		return RESULTDATA;
	}
	
	Connection conn=null;

  try {
	
    String sql="",sqltest="";
    
    if((!(accno.equalsIgnoreCase(""))) && (!(accno.equalsIgnoreCase("NA")))){
		sqltest=sqltest+" and t.account like '%"+accno+"%'  ";
	}
	if((!(accname.equalsIgnoreCase(""))) && (!(accname.equalsIgnoreCase("NA")))){
		sqltest=sqltest+" and t.description like '%"+accname+"%'";
	}
	if(!(mobileno.equalsIgnoreCase("NA"))&&!(mobileno.equalsIgnoreCase(""))){
		sqltest=sqltest+" and a.per_mob like '%"+mobileno+"%' ";
	}
	
	conn= connDAO.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
    
    if(type.equalsIgnoreCase("GL")||type.equalsIgnoreCase("AR")||type.equalsIgnoreCase("AP")){
    	sql="select a.nontax,a.per_mob mobno,t.doc_no,t.account,t.description,t.curid,c.code currency,round(coalesce(cb.rate,0),2)rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
                + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
                + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
                + " left join my_acbook a on a.acno=t.doc_no and a.dtype='CRM'  "
                + "where t.atype='"+type+"' and t.m_s=0 "+sqltest;
    }
    else{
    	sql="select a.nontax,a.per_mob mobno,t.doc_no,t.account,t.description,t.curid,c.code currency,round(coalesce(cb.rate,0),2)rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
            + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
            + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
            + " left join my_acbook a on a.acno=t.doc_no and a.dtype='CRM'  "
            + "where t.atype='AR' and t.m_s=0 and t.den='340'"+sqltest;
    }   
    //System.out.println("--acc---sql---"+sql);
    ResultSet resultSet = stmtCPV.executeQuery (sql);
    RESULTDATA=commDAO.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	
public   JSONArray reloadnipurchase(HttpSession session,String nidoc) throws SQLException {

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
	        	String pySql=(" select case when d.costtype=1 then cc.doc_no when d.costtype in(3,4) then cm.doc_no when d.costtype=11 then sc.voc_no when d.costtype=13 then ac.voc_no else 0 end as costcodeid,d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.nuprice,d.acno headdoc,h.gr_type grtype ,"
	        			+ "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup,d.taxper,d.tax taxperamt,d.nettaxamount taxamount "
	        			+ " from my_srvsaled d left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype left join cm_srvcontrm cm on cm.tr_no=d.costcode and cm.dtype=if(d.costtype=3,'AMC',if(d.costtype=4,'SJOB','')) "
	        			+" left join my_ccentre cc on cc.doc_no = d.costcode and d.costtype=1 left join cm_staffcontrm sc on sc.doc_no = d.costcode and d.costtype=11 left join cm_amscontrm ac on ac.doc_no = d.costcode and d.costtype=13 "
	        			+ "  where d.rdocno='"+nidoc+"'  ");
	        	//System.out.println("=====++==="+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	public   JSONArray accountGridsearch(String type) throws SQLException {
      
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
  try {
     conn = connDAO.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
             
    String sqlfilter="";
    
    String acctconfig="0";

    String sqlconfig="select method from gl_config where field_nme = 'INCOMEACCOUNTSONLY';";
    ResultSet rsConfig = stmtCPV.executeQuery (sqlconfig);
    while(rsConfig.next()) {
    	acctconfig=rsConfig.getString("method");
    }
    
    if(acctconfig.equalsIgnoreCase("1")) {
    	sqlfilter=" and t.gr_type=5";
    }
    
    String sqq= ("select t.gr_type grtype,t.doc_no,t.account,t.description,c.code curr,c.doc_no curid,c.c_rate from my_head t left join my_curr c "
      + "on t.curid=c.doc_no where atype='"+type+"' and m_s=0"+sqlfilter);
    
    
    System.out.println("--cczxc-----"+sqq);
    
    ResultSet resultSet = stmtCPV.executeQuery (sqq);
    
   

    RESULTDATA=commDAO.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();

  }
  catch(Exception e){
	   conn.close();
   e.printStackTrace();
  }
        return RESULTDATA;
    }
	
	public   JSONArray searchCosttype() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
	        	
				ResultSet resultSet = stmtVehclr.executeQuery ("select costtype,costgroup from my_costunit where status=1;");

				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray searchCostcode(String type) throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	  
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
			
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		//System.out.println("1111111111111111");
	        		String sql="select costcode code,doc_no,description name,0 reg_no  from my_ccentre where m_s=0;";
	        		//System.out.println("----"+sql );
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
					stmtVehclr.close();
					
	        	}
	        	else if(type.equalsIgnoreCase("6"))
	        	{
	        		
	        		String sql="select doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0;";
	        		//System.out.println("----"+sql );
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=commDAO.convertToJSON(resultSet);
					stmtVehclr.close();
					
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
	public   JSONArray refnosearch(HttpSession session) throws SQLException {

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
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select m.doc_no,m.voc_no,m.date,m.netamount,m.type,m.acno,m.refno,m.curid,m.rate,m.delterm,m.payterm,m.deldate,m.desc1,h.description,h.account "
	        			+ "from my_srvlpom m left join my_head h on h.doc_no=m.acno where m.status<>7 and m.brhid='"+brcid+"'" );
	        	//System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
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
	public   JSONArray slnosearch(String niorderdocno) throws SQLException {

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
	       	
				String resql=(" select d.srno,d.desc1 desc1,d.unitprice unitprice,d.qty,d.total total,m.type,d.discount,m.acno,h.description,h.account from "
						+ "my_srvlpod d inner join my_srvlpom m on d.rdocno=m.doc_no left join my_head h on h.doc_no=m.acno   where d.rdocno='"+niorderdocno+"' ");
				
				
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
	public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String reftypess,String aa,String mobileno) throws SQLException {

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
    	sqlStartDate = commDAO.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
    	}
    	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
    	}
    	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
    	}
    	if((!(reftypess.equalsIgnoreCase(""))) && (!(reftypess.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and m.reftype like '%"+reftypess+"%'";
    	}
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
    	} 
	if(!(mobileno.equalsIgnoreCase("NA"))&&!(mobileno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.per_mob like '%"+mobileno+"%' ";
    	}
        
	    Connection conn = null;
		try {
			conn = connDAO.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				 
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select coalesce(m.delno,'') delno,a.per_mob mobno,convert(coalesce(m.refno,''),char(20)) refvocno,m.tr_no,m.doc_no,m.voc_no,coalesce(m.invno,'') invno,m.invdate,m.date,m.netamount,m.type,m.acno,m.reftype,m.refno,m.curid,m.rate,m.delterm,m.payterm, "
	        			+ "m.deldate,m.desc1,h.description,h.account,m.interstate,h.atype from my_srvsalem m left join my_head h on h.doc_no=m.acno left join my_srvlpom o on m.refno=o.doc_no left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' where m.status<>7  "
	        			+ "and m.brhid='"+brcid+"' "+sqltest +" order by m.doc_no");
	        	//System.out.println("===pysql====="+pySql);
	        	
	       
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
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
	public  ClsServiceSaleBean getPrint(int docno, HttpServletRequest request ,HttpSession session) throws SQLException {
		 ClsServiceSaleBean bean = new ClsServiceSaleBean();
		  Connection conn = null; // String brcid=session.getAttribute("BRANCHID").toString();
		 // String doc_no=request.getParameter("doc_no");
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtprint = conn.createStatement ();
				
				 String brcid=session.getAttribute("BRANCHID").toString();
	        	
				/*String resql=("select m.invno,date_format(m.invdate,'%d-%m-%Y') invdate,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,round(m.netamount,2) netamount,m.type,m.acno,if(m.reftype='DIR','Direct',concat('NI Purchase Order ','(',m.refno,')')) reftype,m.refno,m.curid,m.rate,m.delterm, "
						+ "coalesce(m.payterm,'') payterm,date_format(m.deldate,'%d-%m-%Y') deldate,coalesce(m.desc1,'') desc1,coalesce(h.description,'') description,h.account from my_srvsalem m left join my_head h on h.doc_no=m.acno  where m.DOC_NO='"+docno+"' ");
				*/
				String resql = ("select m.curid,coalesce(m.delno,'') delno,if(m.date<20210101,0,1) easycmp,ar.area,cr.country_name as country,year(curdate())curyear,m.voc_no,if(CONCAT(if(a.per_tel is null or trim(a.per_tel)='',if(a.per_mob is null or trim(a.per_mob)='',if(a.com_mob is null or trim(a.com_mob)='',' NIL , ',CONCAT(a.com_mob,' , ')),CONCAT(a.per_mob,' , ')),CONCAT(a.per_tel,' , ')), "
					+ "	if(a.fax1 is null or trim(a.fax1)='',if(a.fax2 is null or trim(a.fax2)='','NIL',a.fax2),a.fax1))=' NIL , NIL','',CONCAT(if(a.per_tel is null or trim(a.per_tel)='',if(a.per_mob is null or trim(a.per_mob)='',if(a.com_mob is null or trim(a.com_mob)='',' NIL , ',CONCAT(a.com_mob,' , ')),CONCAT(a.per_mob,' , ')),CONCAT(a.per_tel,' , ')), "
					+ "	if(a.fax1 is null or trim(a.fax1)='',if(a.fax2 is null or trim(a.fax2)='','NIL',a.fax2),a.fax1))) as telno,"
					+ " b.tinno brtinno,round(sum(d.tax),2)vatot,round(sum(d.total),2)totals,round(m.netamount+sum(d.tax),2) nettaxtot,m.refno,coalesce(a.mail1,'') mail1,  coalesce(a.fax1,'') fax1,coalesce(a.per_mob,'') per_mob,a.address, "
					+ "coalesce(a.contactperson,'') contactperson,m.voc_no,date_format(m.date,'%d-%m-%Y') date,coalesce(a.tinno,a.trnnumber) trnnumber,a.com_mob,if(m.invno='0','',m.invno) as invno,date_format(m.invdate,'%d-%m-%Y') invdate, "
					+ "round(m.netamount,2) netamount ,m.type,m.acno,if(trim(m.delterm)!='',m.delterm,null) delterm,"
					+ "if(trim(m.payterm)!='',m.payterm,null)payterm,date_format(m.deldate,'%d-%m-%Y') deldate, if(trim(m.desc1)!='',m.desc1,null)desc1,coalesce(h.description,'') description,"
					+ "h.account,round(sum(d.tax),2) taxamount from my_srvsalem m left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' left join my_area ar on a.area_id=ar.doc_no left join my_acountry cr on ar.country_id=cr.doc_no "
					+ "left join my_srvsaled d on m.doc_no=d.rdocno  left join my_brch b on m.brhid=b.doc_no"
					+ "  where m.DOC_NO="+ docno + " group by rdocno");
				//System.out.println("Query++++++++"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				DecimalFormat df = new DecimalFormat("###,##0.00");
			     
			       while(pintrs.next()){
			    	   session.setAttribute("CURRENCYID",pintrs.getString("curid"));   
			    	   
			    	   if(pintrs.getInt("easycmp")==0){
			    		   bean.setEasycmp("EASY LEASE MOTOR CYCLE RENTAL LLC"+"\n"+
								"P.O.Box: 333367," +"\n"+
								"Al Nouf Tower Office no: 1004"+"\n"+
								"Tel:097142844404"+"\n"+
								"Fax:097142844060"+"\n"+"\n"+
								"TRN NO: ");
			    	   }else{
			    		   bean.setEasycmp("EASY LEASE MOTOR CYCLE RENTAL PSC"+"\n"+
			    				   "P.O.Box: 333367," +"\n"+
			    				   "Al Nouf Tower Office no: 1004"+"\n"+
			    				   "Tel:097142844404"+"\n"+
			    				   "Fax:097142844060"+"\n"+"\n"+
			    				   "TRN NO: ");  
			    	   }
			    	   bean.setDelno(pintrs.getString("delno"));
					   bean.setLbldocno(pintrs.getString("voc_no"));
			          bean.setTelno(pintrs.getString("telno"));		    	
			          bean.setCompanytrno(pintrs.getString("brtinno"));
			   bean.setLblcountry(pintrs.getString("country"));
			   bean.setLblarea(pintrs.getString("area"));
			    bean.setLblcltrnno(pintrs.getString("trnnumber"));
//			    System.out.println("tr======"+pintrs.getString("trnnumber"));
				bean.setAttn(pintrs.getString("contactperson"));
				bean.setLblvenphon(pintrs.getString("per_mob"));
				bean.setLblvenaddress(pintrs.getString("address"));
//				System.out.println("affff"+pintrs.getString("address"));
				bean.setLblvenland(pintrs.getString("com_mob"));
				bean.setFax(pintrs.getString("fax1"));
				bean.setEmail(pintrs.getString("mail1"));
				bean.setRefno(pintrs.getString("refno"));

				bean.setLbldate(pintrs.getString("date"));
				// bean.setLbltype(pintrs.getString("reftype"));
				bean.setDocvals(pintrs.getString("voc_no"));
				bean.setLblacno(pintrs.getString("account"));
				// upper
				bean.setLblacnoname(pintrs.getString("description"));
				bean.setLbldeldate(pintrs.getString("deldate"));
				bean.setLbldddtm(pintrs.getString("delterm"));

				bean.setLbldsc(pintrs.getString("desc1"));
				bean.setLblpatms(pintrs.getString("payterm"));
				
				bean.setLblnettotal(df.format(pintrs.getDouble("netamount")));
				bean.setLbltaxamount(df.format(pintrs.getDouble("taxamount")));
				//bean.setLblnettaxamount(Float.parseFloat(pintrs.getString("netamount"))+Float.parseFloat(pintrs.getString("taxamount"))+"");
				bean.setLblnettaxamount(df.format(pintrs.getDouble("nettaxtot")));
				bean.setNettaxamount(df.format(pintrs.getDouble("nettaxtot")));
//                System.out.println(df.format(pintrs.getDouble("nettaxtot")));
				ClsAmountToWords c = new ClsAmountToWords();
				bean.setLblamountinwords(c.convertAmountToWords(pintrs.getString("nettaxtot")));
				  bean.setVatwords(c.convertAmountToWords(pintrs.getString("vatot")));
	                bean.setTotalwords(c.convertAmountToWords(pintrs.getString("totals")));
				bean.setLblinvno(pintrs.getString("invno"));
				bean.setLblinvdate(pintrs.getString("invdate"));
				 bean.setPrintcuryear(pintrs.getString("curyear"));	     
			    	 
			    	    
			       }
				

				stmtprint.close();
				
				Statement stmtinvoice11 = conn.createStatement ();
				
				String bankinfosql = "select name,beneficiary,account,ibanno,swiftcode,logo,address branchaddress from cm_bankdetails where status=3 and brhid='"+session.getAttribute("BRANCHID").toString().trim()+"'";
				ResultSet resultsetbank = stmtinvoice11.executeQuery(bankinfosql);
//				System.out.println("branchhhkkkkk"+session.getAttribute("BRANCHID").toString().trim());
				
				while (resultsetbank.next()) {
					bean.setLbllogoimgpath(resultsetbank.getString("logo"));
					bean.setLblbankdetails(resultsetbank.getString("name"));
					bean.setLblbankbeneficiary(resultsetbank.getString("beneficiary"));
					bean.setLblbankaccountno(resultsetbank.getString("account"));
					bean.setLblbeneficiarybank(resultsetbank.getString("swiftcode"));
					bean.setLblbankibanno(resultsetbank.getString("ibanno"));
					bean.setLblcompbranchaddress(resultsetbank.getString("branchaddress"));
				} 
				
				stmtinvoice11.close();
				
				 Statement stmtinvoice10 = conn.createStatement ();
				 /*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_srvsalem r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
				    String companysql = "select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno from my_srvsalem r inner join my_brch b on  "
					+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
					+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"
					+ docno + "' ";
			// System.out.println("----------------"+companysql);
			ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql);

			while (resultsetcompany.next()) {
				bean.setLblbranchtrno(resultsetcompany.getString("tinno"));
				   bean.setEasycmp(bean.getEasycmp()+resultsetcompany.getString("tinno")); 	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	 
				    	   
				       } 
				       stmtinvoice10.close();
				 ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();
					
						String strSqldetail="select d.srno,d.desc1 description,format(d.unitprice,2) unitprice,round(d.qty) qty,format(d.total,2) total,coalesce(format(d.discount,2),'')discount,format(d.nettotal,2) nettotal,d.nuprice,"
								+ " d.remarks,h.account account,h.description accname,h.atype accounttype,round(d.taxper,2) taxper,format(d.tax,2) taxperamt,format(d.nettaxamount,2) nettaxamount  from my_srvsaled d left join my_head h on h.doc_no=d.acno  "
								+ " where d.rdocno='"+docno+"' ";
					
			
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
		
							String temp="";
							temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("unitprice")+"::"+rsdetail.getString("total")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal")+"::"+rsdetail.getString("taxper")+"::"+rsdetail.getString("taxperamt")+"::"+rsdetail.getString("nettaxamount") ;
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 

					///cargo///////////
					Statement stmtcargo=conn.createStatement();
					String branchsql="select  b.branchname,b.address,b.tel,b.fax,l.loc_name location,coalesce(b.tinno,0) tinno from my_srvsalem m left join my_brch b on m.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no where m.doc_no="+docno;
//					System.out.println("====branchsql===="+branchsql);
					ResultSet rsbranch=stmtcargo.executeQuery(branchsql);
					while(rsbranch.next()){
						bean.setLblbranch(rsbranch.getString("branchname"));
						bean.setLblbranchaddress(rsbranch.getString("address"));
						bean.setLblbranchtel(rsbranch.getString("tel"));
						bean.setLblbranchfax(rsbranch.getString("fax"));
						bean.setLbllocation(rsbranch.getString("location"));
						bean.setLblbranchtrno(rsbranch.getString("tinno"));
					}
					rsbranch.close();
					
					 Statement stmt=conn.createStatement();
				
					
					
					String username="select u.USER_NAME preparedby from datalog d left join my_user u on (d.userid=u.DOC_NO) where"
			        		+ " d.ENTRY='A' and d.dtype='SRS' and d.doc_no="+docno+"";
//					System.out.println("rst"+username);
                    
                       
                        ResultSet result=stmt.executeQuery(username);
                       // String uname="";
                        while (result.next())
                        {
                        	//uname=result.getString("preparedby");
                        	bean.setUsername(result.getString("preparedby"));
                        	//System.out.println("rst"+result.getString("USER_NAME"));
                        }
                     //System.out.println("rst====="+uname);
                      
                      stmt.close();
					
			/*		String crsql="select coalesce(m.invno,'') jobno,coalesce(cm.refno,'') cusref,ac.refname,coalesce(ac.address,'') address, "
							+ " coalesce(ac.per_mob,'') per_mob,coalesce(ac.fax1,'') fax1,coalesce(ac.contactPerson,'') contactPerson,coalesce(ac.mail1,'') mail1,coalesce(ac.tinno,0) trnnumber,"
							+ " format(sum(d.unitprice),2) grossrate,format(sum(total),2) grossamount,format(sum(d.discount),2) discount,"
							+ " format(sum(d.unitprice-d.discount),2) taxablerate,format(sum(d.nettotal),2) taxableamount,"
							+ " format(sum(d.tax),2) vatamount,format(sum(d.nettaxamount),2) netamount,round(sum(d.nettaxamount),2) wordsamount, "
							+ " coalesce(cf.mawb,'') mawb,coalesce(cf.mbl,'') mbl,coalesce(cf.hawb,'') hawb,coalesce(cf.hbl,'') hbl,coalesce(cf.shipper,'') shipper,"
							+ " coalesce(cf.consignee,'') consignee,coalesce(cf.carrier,'') carrier,coalesce(cf.flightno,'') flightno,coalesce(cf.voage,'') voage,coalesce(cf.etd,'') etd,"
							+ " coalesce(cf.eta,'') eta,coalesce(cf.ttime,'') ttime,coalesce(cf.boe,'') boe,coalesce(cf.contno,'') contno,"
							+ " coalesce(cf.truckno,'') truckno,coalesce(ed.volume,'') volume,coalesce(ed.noofpacks,'') qty "
							+ " from my_srvsalem m  "
							+ " left join(select invtrno,rdocno  from  cr_cfid where invtrno>0  group by rdocno,invtrno) dd on dd.invtrno=m.tr_no and m.status=3 "
							+ " left join cr_cfim  cf on if(dd.invtrno>0,cf.doc_no=dd.rdocno, cf.tr_no=m.tr_no) left join cm_srvcontrm cm on cf.refno=cm.tr_no"
							+ " left join my_acbook ac on ac.acno=m.acno  and ac.dtype='crm' left join my_srvsaled d on m.doc_no=d.rdocno"
							+ " left join cr_joblist l on l.jobno=cm.tr_no left join cr_enqd ed on l.enqdocno=ed.doc_no "
							+ " where m.doc_no="+docno+" group by m.doc_no";*/
					
					
					String crsql=" select qm.confirm_no jobno,coalesce(m.invno,'') subjobno,coalesce(cm.refno,'') cusref,ac.refname,coalesce(ac.address,'') address,"
							+ "  coalesce(ac.per_mob,'') per_mob,coalesce(ac.fax1,'') fax1,coalesce(ac.contactPerson,'') contactPerson, "
							+ "coalesce(ac.mail1,'') mail1,coalesce(ac.tinno,0) trnnumber, dd2.grossrate,dd2.grossamount,dd2. discount,"
							+ " dd2.taxablerate,dd2.taxableamount, dd2.vatamount,dd2.netamount,dd2.wordsamount,  coalesce(cf.mawb,'') mawb,"
							+ "coalesce(cf.mbl,'') mbl,coalesce(cf.hawb,'') hawb,coalesce(cf.hbl,'') hbl,coalesce(cf.shipper,'') shipper,"
							+ " coalesce(cf.consignee,'') consignee,coalesce(cf.carrier,'') carrier,coalesce(cf.flightno,'') flightno,"
							+ "coalesce(cf.voage,'') voage,coalesce(cf.etd,'') etd, coalesce(cf.eta,'') eta,coalesce(cf.ttime,'') ttime,"
							+ "coalesce(cf.boe,'') boe,coalesce(cf.contno,'') contno, coalesce(cf.truckno,'') truckno,coalesce(ed.volume,'') volume,"
							+ "coalesce(ed.noofpacks,'') qty  from my_srvsalem m   left join(select invtrno,rdocno  from  cr_cfid where invtrno>0 "
							+ " group by rdocno,invtrno) dd on dd.invtrno=m.tr_no and m.status=3  left join cr_cfim  cf on"
							+ " if(dd.invtrno>0,cf.doc_no=dd.rdocno, cf.tr_no=m.tr_no) left join cm_srvcontrm cm on cf.refno=cm.tr_no"
							+ " left join my_acbook ac on ac.acno=m.acno  and ac.dtype='crm'  "
							+ " left join (select   format(sum(d.unitprice),2) grossrate,format(sum(total),2) grossamount,"
							+ " format(sum(d.discount),2) discount, format(sum(d.unitprice-d.discount),2) taxablerate,format(sum(d.nettotal),2)"
							+ " taxableamount, format(sum(d.tax),2) vatamount,format(sum(d.nettaxamount),2) netamount,round(sum(d.nettaxamount),2) "
							+ "wordsamount,rdocno from my_srvsaled d group by d.rdocno) dd2 on dd2.rdocno=m.doc_no   "
							+ "  left join cr_joblist l on l.jobno=cm.tr_no left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno  left join cr_qotm qm on qm.rrefno=em.doc_no and qm.reftype='ENQ'"    
							+ "  where m.doc_no="+docno+" group by m.doc_no ";
					
					
					
				//System.out.println("--crsql--"+crsql);
					ResultSet rs=stmtcargo.executeQuery(crsql);
					while(rs.next()){
						bean.setLbljobno(rs.getString("jobno"));
						bean.setLblsubjobno(rs.getString("subjobno"));  
						bean.setLblcustomerref(rs.getString("cusref"));
						bean.setLblclientname(rs.getString("refname"));
						bean.setLblclientaddress(rs.getString("address"));
						bean.setLblclienttel(rs.getString("per_mob"));
						bean.setLblclientfax(rs.getString("fax1"));
						bean.setLblctcperson(rs.getString("contactPerson"));
						bean.setLblclientemail(rs.getString("mail1"));
						bean.setLblcltrnno(rs.getString("trnnumber"));
						bean.setLblgrossrate(rs.getString("grossrate"));
						bean.setLblgrossamount(rs.getString("grossamount"));
						bean.setLbldiscount(rs.getString("discount"));
						bean.setLbltaxablerate(rs.getString("taxablerate"));
						bean.setLbltaxableamount(rs.getString("taxableamount"));
						bean.setLblvatamount(rs.getString("vatamount"));
						bean.setLblnetamount(rs.getString("netamount"));
						bean.setLblwordsamount(rs.getString("wordsamount"));
						bean.setLblmawb(rs.getString("mawb"));
						bean.setLblmbl(rs.getString("mbl"));
						bean.setLblhawb(rs.getString("hawb"));
						bean.setLblhbl(rs.getString("hbl"));
						bean.setLblshipper(rs.getString("shipper"));
						bean.setLblconsignee(rs.getString("consignee"));
						bean.setLblcarrier(rs.getString("carrier"));
						bean.setLblflightno(rs.getString("flightno"));
						bean.setLblvessel(rs.getString("voage"));
						bean.setLbletd(rs.getString("etd"));
						bean.setLbleta(rs.getString("eta"));
						bean.setLblttime(rs.getString("ttime"));
						bean.setLblboe(rs.getString("boe"));
						bean.setLblcontainerno(rs.getString("contno"));
						bean.setLbltruckno(rs.getString("truckno"));
						bean.setLblshipqty(rs.getString("qty"));
						bean.setLblgrosswt(rs.getString("volume"));
						
						ClsAmountToWords c = new ClsAmountToWords();
						bean.setLblwordsamount(c.convertAmountToWords(bean.getLblwordsamount()));
						
						}
					stmtcargo.close();
					
					/////cargo-ends///////
					
					
				conn.close();



				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		return bean;
		
	
	}
	 public   JSONArray termssearch() throws SQLException {

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
	       	
				String resql=(" select  h.gr_type grtype, m.description desc1 ,m.idno,m.acno,h.description ,h.atype,h.account from my_srvsaleterms m  "
						+ " left join my_head h on h.doc_no=m.acno where m.status=1  ");
				// System.out.println("--------------"+resql);
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
		public   JSONArray searchCostcodes(String type) throws SQLException {  

		    JSONArray RESULTDATA=new JSONArray();
		    Connection conn = null;
		  
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVehclr = conn.createStatement ();
				
		        	if(type.equalsIgnoreCase("1"))
		        	{
		        		//System.out.println("1111111111111111");
		        		String sql="select costcode code,doc_no,description name,0 reg_no  from my_ccentre where m_s=0;";
		        		//System.out.println("----"+sql );
		        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
		        		RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtVehclr.close();
						
		        	}
		        	/* AMC & SJOB */
		        	else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4"))
		        	{
		        		String dtype="";
		        		if(type.equalsIgnoreCase("3")) {
		        			dtype="AMC";
		        		} else if(type.equalsIgnoreCase("4")) {
		        			dtype="SJOB";
		        		}
		        		
		        		// String sql="select m.tr_no,m.doc_no code,a.refname name from cm_srvcontrm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'";
		        		String sql=" select m.tr_no doc_no,cast(concat(m.doc_no, if(sd.doc_no is null,'',concat('',sd.doc_no))) as char(20)) code,concat(if(sd.name is null,'' ,concat(sd.name,'')),a.refname) name from cm_srvcontrm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' "
		        				+ " left join cm_subdivm s on m.tr_no=s.jobdocno left join cm_subdivision sd on sd.doc_no=s.rdocno where m.status=3 and a.status=3 and m.dtype='"+dtype+"' order by m.doc_no,sd.doc_no";
		        		System.out.println("====== "+sql);
		        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
		        		RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtVehclr.close();
						conn.close();
		        	}
		        	/* Call Register */
		        	else if(type.equalsIgnoreCase("5"))
		        	{
		        		String sql="select m.doc_no,m.doc_no code,a.refname name from cm_cuscallm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
		        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
		        		RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtVehclr.close();
						conn.close();
		        	}
		        	/* Fleet */
		        	else if(type.equalsIgnoreCase("6"))
		        	{
		        		String sql="select doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0";
		        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
		        		RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtVehclr.close();
						conn.close();
		        	}
		        	/* IJCE */
		        	else if(type.equalsIgnoreCase("7"))
		        	{
		        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from is_jobmaster m left join my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'";
		        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
		        		RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtVehclr.close();
						conn.close();
		        	}
					/* Contract */
		        	else if(type.equalsIgnoreCase("8"))
		        	{
		        		String sql="select m.doc_no,m.doc_no code,if(m.cardno is null,' ',(if(m.cardno=0,' ',m.cardno))) reg_no,cl.name name from hi_contract m left join hi_client cl on cl.doc_no=m.cldocno where m.status=3 and cl.status=3";
		        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
		        		RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtVehclr.close();
						conn.close();
		        	}
					
					/* Job Card */
		        	else if(type.equalsIgnoreCase("9"))
		        	{
		        		String sql="SELECT * FROM (select M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site from ws_jobcard M left join ws_estm e on M.refno=e.doc_no and reftype='est' left join ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3)) M WHERE 1=1";
		        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
		        		RESULTDATA=commDAO.convertToJSON(resultSet);
						stmtVehclr.close();
						conn.close();
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

    }