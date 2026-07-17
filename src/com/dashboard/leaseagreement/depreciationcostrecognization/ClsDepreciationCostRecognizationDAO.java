package com.dashboard.leaseagreement.depreciationcostrecognization;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDepreciationCostRecognizationDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	ClsDepreciationCostRecognizationBean depreciationCostRecognizationBean = new ClsDepreciationCostRecognizationBean();
	
	public int insert(String cmbbranch, Date depreciationDate, Double txtdeprtotal, String txtselecteddocs, ArrayList<String> depreciationcostrecognizationarray, HttpSession session, HttpServletRequest request, 
			String mode) throws SQLException {
		
	    Connection conn  = null;
		  
	    try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtBDCR1 = conn.createStatement();
			
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			String branch=session.getAttribute("BRANCHID").toString().trim();
			int total = 0;
			
			CallableStatement stmtBDCR = conn.prepareCall("{CALL deprCostRecognizationmDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtBDCR.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtBDCR.registerOutParameter(8, java.sql.Types.INTEGER);
			
			stmtBDCR.setDate(1,depreciationDate);
			stmtBDCR.setDouble(2,txtdeprtotal);
			stmtBDCR.setString(3,"BDCR");
			stmtBDCR.setString(4,company);
			stmtBDCR.setString(5,branch);
			stmtBDCR.setString(6,userid);
			stmtBDCR.setString(9,mode);
			int datas=stmtBDCR.executeUpdate();
			if(datas<=0){
				stmtBDCR.close();
				conn.close();
				return 0;
			}
			int docno=stmtBDCR.getInt("docNo");
			int trno=stmtBDCR.getInt("itranNo");
			request.setAttribute("tranno", trno);
			depreciationCostRecognizationBean.setDocno(docno);
			if (docno > 0) {
				
				/*Selecting account no.*/
				int depreciationAccount=0,accumulativeDepreciationAccount=0;
				String sqlDepr=("select acno from my_account where codeno='VDE'");
				ResultSet resultSetDepr = stmtBDCR1.executeQuery(sqlDepr);
			    
			 	while (resultSetDepr.next()) {
			 		depreciationAccount=resultSetDepr.getInt("acno");
			 	}
			 	
			 	String sqlAccDepr=("select acno from my_account where codeno='VAD'");
				ResultSet resultSetAccDepr = stmtBDCR1.executeQuery(sqlAccDepr);
				    
				 while (resultSetAccDepr.next()) {
					 accumulativeDepreciationAccount=resultSetAccDepr.getInt("acno");
				 }
			 	/*Selecting account no. Ends*/
			 
				ArrayList<String> journalvouchersarray= new ArrayList<String>();
				journalvouchersarray.add(accumulativeDepreciationAccount+"::"+txtdeprtotal*-1+"::-1");
				journalvouchersarray.add(depreciationAccount+"::"+txtdeprtotal+"::1");
				
				/*Insertion to gc_assettran,my_jvtran*/
				int insertData=insertion(conn, docno, branch, trno, "BDCR", depreciationDate, depreciationcostrecognizationarray, journalvouchersarray, session, mode);
				if(insertData<=0){
					stmtBDCR.close();
					conn.close();
					return 0;
				}
				/*Insertion to gc_assettran,my_jvtran Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtBDCR.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0) {
					conn.commit();
					stmtBDCR.close();
					conn.close();
					return docno;
				 } else {
						System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
						stmtBDCR.close();
						return 0;
					}
			}
			
			stmtBDCR.close();
			conn.close();
	 } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
			conn.close();
		}
		return 0;
	}
	
	public JSONArray depreciationDetailsGridLoading(String branch,String uptodate) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlUpToDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBDCR = conn.createStatement();
			    
		        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	
			    	String sqlUpdate="update gl_vehmaster v left join gl_lagmt l on v.fleet_no=l.perfleet left join gl_blaf bl on bl.srno=l.blafsrno left join gl_leasecalcreq lr on bl.rdocno=lr.srno set v.residual_val=lr.residalvalue "
			    			+ "where v.statu=3 and v.residual_val=0 and l.status=3 and l.clstatus=0 and lr.residalvalue!=0";
			    	stmtBDCR.executeUpdate(sqlUpdate);
			    	
				    String sql = "";
				    	 
				    sql = "select * from ( " 
				    	+ "select 'Posted' status,convert(count(*),char(10)) value,'YES' dtype from gl_vehmaster where fstatus<>'Z' and statu=3 and depr_date is not null and depr_date='"+sqlUpToDate+"' and brhid="+branch+" UNION ALL "  
				    	+ "select 'To be Posted' status,convert(count(*),char(10)) value,'NO' dtype from gl_vehmaster v left join "
				    	+ " (select if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate, "
				    	+ " perfleet,l.brhid from gl_lagmt l UNION ALL select s.todate leasetodate,s.fleet_no fleetno,brhid from gl_stockvehicles s left join gl_vehmaster v on v.fleet_no=s.fleet_no where s.status=3 and v.stockrelease=1) l "
				    	+ "on l.perfleet=v.fleet_no  where fstatus<>'Z' and statu=3 and depr_date is not null and  leasetodate > last_day(date_sub('"+sqlUpToDate+"',INTERVAL 1 MONTH)) and depr_date<'"+sqlUpToDate+"' and l.brhid="+branch+" UNION ALL "  
				    	+ "select 'All' status,convert('',char(10)) value,'ALL' dtype) a";
				    
				    ResultSet resultSet = stmtBDCR.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    }
			    
			    stmtBDCR.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray depreciationCostRecognizationGridLoading(String branch,String uptodate,String dtype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
        java.sql.Date sqlUpToDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBDCR = conn.createStatement();
			    
				
		        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and b.brhid="+branch+"";
	    		}
		        
			    if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
			    	if(dtype.equalsIgnoreCase("YES")){
				    	if(!(sqlUpToDate==null)){
				        	sql+=" and v.depr_date='"+sqlUpToDate+"'";
					    }
			    	} else if(dtype.equalsIgnoreCase("NO")){
				    	if(!(sqlUpToDate==null)){
				        	sql+=" and v.depr_date<'"+sqlUpToDate+"'";
					    }
			    	} else {
			    		if(!(sqlUpToDate==null)){
				        	sql+=" and v.depr_date<='"+sqlUpToDate+"'";
					    }
			    	}
			    }
			    
			    sql = "select CONVERT(COALESCE(b.voc_no,' '),CHAR(100)) agreement,CONVERT(COALESCE(if(b.chkleaseown=0,'LEASE ONLY',if(b.chkleaseown=1,'LEASE TO OWN',' ')),' '),CHAR(100)) type,CONVERT(COALESCE(c.refname,' '),CHAR(100)) client,"  
				    	+ "CONVERT(COALESCE(b.fleetno,' '),CHAR(100)) fleetno,v.reg_no regno,p.code_name platecode,br.brand_name brand,vm.vtype model,CONVERT(COALESCE(b.outdate,' '),CHAR(100)) leasefromdate,CONVERT(COALESCE(b.leasetodate,' '),CHAR(100)) leasetodate,"
			    		+ "Convert(coalesce(v.depr_date,v.prch_dte),CHAR(100)) posteddate,round(v.prch_cost,2) vehiclecost,round(v.residual_val,2) residual,round((v.prch_cost-v.residual_val),2) balance,round((COALESCE(v.prch_cost,0)-COALESCE(v.residual_val,0)),2) balance,"
				    	+ "COALESCE(DATEDIFF(b.leasetodate,coalesce(v.depr_date,v.prch_dte)),0) numberofdays,round(COALESCE((COALESCE(v.prch_cost,0)-COALESCE(v.residual_val,0))/COALESCE(DATEDIFF(b.leasetodate,b.outdate),0),0),2) onedaycharge,"
			    		+ "DATEDIFF('"+sqlUpToDate+"',coalesce(v.depr_date,v.prch_dte)) tobedeprdays,round((COALESCE(DATEDIFF(if(leasetodate<'"+sqlUpToDate+"',leasetodate,'"+sqlUpToDate+"'),coalesce(v.depr_date,v.prch_dte)),0)*round(COALESCE((COALESCE(v.prch_cost,0)-COALESCE(v.residual_val,0))/"
			    		+ "COALESCE(DATEDIFF(b.leasetodate,b.outdate),0),0),2)),2) depramount from gl_vehmaster v left join ( select l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleetno,l.chkleaseown,l.outdate,l.cldocno,"
			    		+ "if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate,l.brhid from ( select max(doc_no) docno from gl_lagmt group by if(perfleet=0,tmpfleet,perfleet)) a left join "
			    		+ "gl_lagmt l on a.docno=l.doc_no UNION ALL select s.doc_no voc_no,s.fleet_no fleetno,2 chkleaseown,s.fromdate outdate,0 cldocno,s.todate leasetodate,v.brhid  from gl_stockvehicles s left join gl_vehmaster v on v.fleet_no=s.fleet_no where s.status=3 and v.stockrelease=1) b "
			    		+ "on v.fleet_no=b.fleetno left join my_acbook c on b.cldocno=c.cldocno and c.dtype='CRM' left join gl_vehplate p on v.pltid=p.doc_no left join gl_vehbrand br on v.brdid=br.doc_no left join gl_vehmodel vm "
				    	+ "on v.vmodid=vm.doc_no where v.statu=3 and v.fstatus<>'Z' and v.depr_date is not null and b.fleetno is not null and leasetodate > last_day(date_sub('"+sqlUpToDate+"',INTERVAL 1 MONTH)) "+sql+"";
			  //  System.out.println("===== "+sql);
			    ResultSet resultSet = stmtBDCR.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtBDCR.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray depreciationCostRecognizationExcelExport(String branch,String uptodate,String dtype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
        java.sql.Date sqlUpToDate = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBDCR = conn.createStatement();
			    
			    if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and b.brhid="+branch+"";
	    		}
		        
			    if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
			    	if(dtype.equalsIgnoreCase("YES")){
				    	if(!(sqlUpToDate==null)){
				        	sql+=" and v.depr_date='"+sqlUpToDate+"'";
					    }
			    	} else if(dtype.equalsIgnoreCase("NO")){
				    	if(!(sqlUpToDate==null)){
				        	sql+=" and v.depr_date<'"+sqlUpToDate+"'";
					    }
			    	} else {
			    		if(!(sqlUpToDate==null)){
				        	sql+=" and v.depr_date<='"+sqlUpToDate+"'";
					    }
			    	}
			    }
			    
			    sql = "select CONVERT(COALESCE(b.voc_no,' '),CHAR(100)) 'Agreement',CONVERT(COALESCE(if(b.chkleaseown=0,'LEASE ONLY',if(b.chkleaseown=1,'LEASE TO OWN',' ')),' '),CHAR(100)) 'Type',CONVERT(COALESCE(c.refname,' '),CHAR(100)) 'Client',"  
				    	+ "CONVERT(COALESCE(b.fleetno,' '),CHAR(100)) 'Fleet',v.reg_no 'Reg No',p.code_name 'Plate Code',br.brand_name 'Brand',vm.vtype 'Model',CONVERT(COALESCE(b.outdate,' '),CHAR(100)) 'From',CONVERT(COALESCE(b.leasetodate,' '),CHAR(100)) 'To',"
			    		+ "Convert(coalesce(v.depr_date,v.prch_dte),CHAR(100)) 'Posted Till',round(v.prch_cost,2) 'Vehicle Cost',round(v.residual_val,2) 'Residual Value',round((COALESCE(DATEDIFF(if(leasetodate<'"+sqlUpToDate+"',leasetodate,'"+sqlUpToDate+"'),coalesce(v.depr_date,v.prch_dte)),0)*round(COALESCE((COALESCE(v.prch_cost,0)-COALESCE(v.residual_val,0))/"
			    		+ "COALESCE(DATEDIFF(b.leasetodate,b.outdate),0),0),2)),2) 'Depr. Amount' from gl_vehmaster v left join ( select l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleetno,l.chkleaseown,l.outdate,l.cldocno,"
			    		+ "if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate,l.brhid from ( select max(doc_no) docno from gl_lagmt group by if(perfleet=0,tmpfleet,perfleet)) a left join "
			    		+ "gl_lagmt l on a.docno=l.doc_no UNION ALL select s.doc_no voc_no,s.fleet_no fleetno,2 chkleaseown,s.fromdate outdate,0 cldocno,s.todate leasetodate,v.brhid from gl_stockvehicles s left join gl_vehmaster v on v.fleet_no=s.fleet_no where s.status=3 and v.stockrelease=1) b on v.fleet_no=b.fleetno left join my_acbook c on b.cldocno=c.cldocno and c.dtype='CRM' left join gl_vehplate p on v.pltid=p.doc_no left join gl_vehbrand br on v.brdid=br.doc_no left join gl_vehmodel vm "
				    	+ "on v.vmodid=vm.doc_no where v.statu=3 and v.fstatus<>'Z' and v.depr_date is not null and b.fleetno is not null and leasetodate > last_day(date_sub('"+sqlUpToDate+"',INTERVAL 1 MONTH)) "+sql+"";
			    
			    ResultSet resultSet = stmtBDCR.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
			    stmtBDCR.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public int insertion(Connection conn,int docno,String branch,int trno,String formdetailcode,Date depreciationDate, ArrayList<String> depreciationcostrecognizationarray, ArrayList<String> journalvouchersarray, HttpSession session,String mode) throws SQLException {
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtBDCR;
				Statement stmtBDCR1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Vehicle Details Grid and Details Saving*/
				for(int i=0;i< depreciationcostrecognizationarray.size();i++){
					String[] vehicledetail=depreciationcostrecognizationarray.get(i).split("::");
					
					if(!vehicledetail[0].trim().equalsIgnoreCase("undefined") && !vehicledetail[0].trim().equalsIgnoreCase("NaN")){
					
					int accountNo=0;
					/*Selecting account no.*/
					String sqls=("select acno from my_account where codeno='VAD'");
					ResultSet resultSets = stmtBDCR1.executeQuery(sqls);
					    
					 while (resultSets.next()) {
						 accountNo=resultSets.getInt("acno");
					 }
					 /*Selecting account no. Ends*/
					
					java.sql.Date dFromDate=(vehicledetail[2].trim().equalsIgnoreCase("undefined") || vehicledetail[2].trim().equalsIgnoreCase("NaN") || vehicledetail[2].trim().equalsIgnoreCase("") ||  vehicledetail[2].trim().isEmpty()?null:ClsCommon.changetstmptoSqlDate(vehicledetail[2].trim()));
					 
					stmtBDCR = conn.prepareCall("{CALL deprCostRecognizationdDML(?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to gc_assettran*/
					stmtBDCR.setInt(8,trno); 
					stmtBDCR.setInt(9,docno);
					stmtBDCR.registerOutParameter(10, java.sql.Types.INTEGER);
					
					stmtBDCR.setDate(1,depreciationDate); //Date
					stmtBDCR.setInt(2,accountNo);  //doc_no of my_head
					stmtBDCR.setString(3,(vehicledetail[0].trim().equalsIgnoreCase("undefined") || vehicledetail[0].trim().equalsIgnoreCase("NaN") || vehicledetail[0].trim().isEmpty()?0:vehicledetail[0].trim()).toString()); //fleet_no
					stmtBDCR.setString(4,(vehicledetail[1].trim().equalsIgnoreCase("undefined") || vehicledetail[1].trim().equalsIgnoreCase("NaN") || vehicledetail[1].trim().isEmpty()?0:vehicledetail[1].trim()).toString()); //depr_amount
					stmtBDCR.setDate(5,dFromDate); //From Date
					
					stmtBDCR.setString(6,formdetailcode);
					stmtBDCR.setString(7,branch);
					stmtBDCR.setString(11,mode);
					
					int detail=stmtBDCR.executeUpdate();
						if(detail<=0){
							stmtBDCR.close();
							conn.close();
							return 0;
						}
    				  }
				    }
				    /*Vehicle Details Grid and Details Saving Ends*/
				
					/*Journal Voucher Grid Saving*/
					for(int i=0;i< journalvouchersarray.size();i++){
					String[] journal=journalvouchersarray.get(i).split("::");
					if(!journal[0].trim().equalsIgnoreCase("undefined") && !journal[0].trim().equalsIgnoreCase("NaN")){
					
					stmtBDCR = conn.prepareCall("{CALL deprCostRecognJournaldDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtBDCR.setInt(10,docno);
					stmtBDCR.setInt(11,trno);
					stmtBDCR.setDate(1,depreciationDate); //Date
					stmtBDCR.setString(2,"BDCR - "+docno);
					stmtBDCR.setInt(3,(i+1)); //SR_No
					stmtBDCR.setString(4,(journal[0].trim().equalsIgnoreCase("undefined") || journal[0].trim().equalsIgnoreCase("NaN") || journal[0].trim().isEmpty()?0:journal[0].trim()).toString());  //doc_no of my_head
					stmtBDCR.setString(5,(journal[1].trim().equalsIgnoreCase("undefined") || journal[1].trim().equalsIgnoreCase("NaN") || journal[1].trim().isEmpty()?0:journal[1].trim()).toString()); //amount
					stmtBDCR.setString(6,(journal[2].trim().equalsIgnoreCase("undefined") || journal[2].trim().equalsIgnoreCase("NaN") || journal[2].trim().isEmpty()?0:journal[2].trim()).toString()); //credit -1 & debit 1
					stmtBDCR.setString(7,formdetailcode);
					stmtBDCR.setString(8,branch);
					stmtBDCR.setString(9,userid);
					stmtBDCR.setString(12,mode);
					stmtBDCR.execute();
						if(stmtBDCR.getInt("docNo")<=0){
							stmtBDCR.close();
							conn.close();
							return 0;
						}
						/*my_jvtran Grid Saving Ends*/
						stmtBDCR.close();
					 }
				}	
					
					/*my_costtran Grid Saving*/
					for(int i=0;i< depreciationcostrecognizationarray.size();i++){
						CallableStatement stmtBDCR2=null;
						String[] vehicledetails=depreciationcostrecognizationarray.get(i).split("::");
						if(!vehicledetails[0].trim().equalsIgnoreCase("undefined") && !vehicledetails[0].trim().equalsIgnoreCase("NaN")){
							
						int accountNo=0,tranid=0;
						/*Selecting account no.*/
						String sqls=("select acno from my_account where codeno='VDE'");
						ResultSet resultSets = stmtBDCR1.executeQuery(sqls);
						    
						 while (resultSets.next()) {
							 accountNo=resultSets.getInt("acno");
						 }
						 /*Selecting account no. Ends*/
						 
						 /*Selecting tranid*/
						 String sql1=("select tranid from my_jvtran where acno="+accountNo+" and tr_no="+trno+"");
						 ResultSet resultSet1 = stmtBDCR1.executeQuery(sql1);
						    
						 while (resultSet1.next()) {
							 tranid=resultSet1.getInt("tranid");
						 }
						 /*Selecting tranid Ends*/
						
						stmtBDCR2 = conn.prepareCall("insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values(?,?,?,?,?,?,?)");
						
						stmtBDCR2.setInt(1,accountNo); //doc_no of my_head
						stmtBDCR2.setInt(2,6);//Cost Type
						stmtBDCR2.setString(3,(vehicledetails[1].trim().equalsIgnoreCase("undefined") || vehicledetails[1].trim().equalsIgnoreCase("NaN") || vehicledetails[1].trim().isEmpty()?0:vehicledetails[1].trim()).toString()); //depr_amount
						stmtBDCR2.setInt(4,(i+1)); //srNo
						stmtBDCR2.setString(5,(vehicledetails[0].trim().equalsIgnoreCase("undefined") || vehicledetails[0].trim().equalsIgnoreCase("NaN") || vehicledetails[0].trim().isEmpty()?0:vehicledetails[0].trim()).toString()); //fleet_no
						stmtBDCR2.setInt(6,tranid); //tranId
						stmtBDCR2.setInt(7,trno); //trNo
					    int data = stmtBDCR2.executeUpdate();
					    if(data<=0){
							stmtBDCR2.close();
							conn.close();
							return 0;
						}
					    
					    String sql2 = "update my_jvtran set costtype=7,costcode=9999 where acno="+accountNo+" and tr_no="+trno+"";
				        stmtBDCR1.executeUpdate(sql2);
				        
					 }
						stmtBDCR2.close();
					}
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
}