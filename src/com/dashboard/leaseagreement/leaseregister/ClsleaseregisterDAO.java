package com.dashboard.leaseagreement.leaseregister;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsleaseregisterDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	

	    public JSONArray detailsgrid(String branchval,String fromdate,String todate,String status) throws SQLException {

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
	     	
	      	
	    	String sqltest="" ,sqlt="";
	    	
	    	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and c.brhid='"+branchval+"'";
	 		}

	    	if(status.equalsIgnoreCase("OPEN")){
	 			sqltest+=" and c.clstatus=0";
	 			sqlt+="where l.clstatus=0";
	 		}
	    	else if(status.equalsIgnoreCase("CLOSE")){
	 			sqltest+=" and c.clstatus=1";
	 			sqlt+="where l.clstatus=1";
	 		}

	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
				
	            				/*String sql ="select l.voc_no,l.brhid,l.doc_no, "
	            				+ "if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,l.outdate startdate,v.reg_no,v.FLNAME vehdetails,a.refname from gl_lagmt l left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no  "
	            				+ "  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' "
	              				+ " where l.status=3 and l.outdate between   '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by l.doc_no";
	            		*/
	        String sql="select voc_no,brhid,docno,fleet_no,reg_no,vehdetails,refname,outdate,DATE_ADD(b.outdate,INTERVAL mont MONTH) enddate,coalesce(lcost,0) lcost, "
	        		+ "round(invd,2) invd,round(bal,2) bal from (select c.voc_no,c.brhid,docno,if(c.perfleet=0,c.tmpfleet,c.perfleet) fleet_no,invd,"
	        		+ "if(c.per_name=1,c.per_value*12,c.per_value) mont,c.outdate as outdate,v.reg_no,v.FLNAME vehdetails,a.refname,"
	        		+ "round(c.pyttotalrent,2) lcost,(coalesce(c.pyttotalrent,0)-invd) as bal from (select rdocno docno,coalesce(sum(amount),0) invd "
	        		+ "from gl_leasepytcalc where markstatus!=0 group by rdocno union all select doc_no docno,0 invd from gl_lagmt l"
	        		+ " "+sqlt+") a left join gl_lagmt c on(c.doc_no=a.docno)"
	        		+ " left join gl_vehmaster v on if(c.perfleet=0,c.tmpfleet,c.perfleet)=v.fleet_no"
	        		+ " left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM'  where c.status=3 and "
	        		+ "c.outdate between   '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+"  group by a.docno) as b";
	           
	//    System.out.println("----lllllllll------"+sql);
	          
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
	    
	    

	    public JSONArray detailexcel(String branchval,String fromdate,String todate,String status) throws SQLException {

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
	     	
	      	
	    	String sqltest="" ,sqlt="";
	    	
	    	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and c.brhid='"+branchval+"'";
	 		}

	    	if(status.equalsIgnoreCase("OPEN")){
	 			sqltest+=" and c.clstatus=0";
	 			sqlt+="where l.clstatus=0";
	 		}
	    	else if(status.equalsIgnoreCase("CLOSE")){
	 			sqltest+=" and c.clstatus=1";
	 			sqlt+="where l.clstatus=1";
	 		}

	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
				
	            				/*String sql ="select l.voc_no,l.brhid,l.doc_no, "
	            				+ "if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,l.outdate startdate,v.reg_no,v.FLNAME vehdetails,a.refname from gl_lagmt l left join gl_vehmaster v on if(l.perfleet=0,l.tmpfleet,l.perfleet)=v.fleet_no  "
	            				+ "  left join my_acbook a on a.cldocno=l.cldocno and a.dtype='CRM' "
	              				+ " where l.status=3 and l.outdate between   '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by l.doc_no";
	            		*/
	        String sql="select voc_no 'LA NO',fleet_no 'Fleet',vehdetails 'Fleet Name',reg_no 'Reg No',refname 'Client Name',outdate 'Start Date',DATE_ADD(b.outdate,INTERVAL mont MONTH) 'End Date',coalesce(lcost,0) 'Lease Cost', "
	        		+ "round(invd,2) 'Invoiced',round(bal,2) 'Balance' from (select c.voc_no,c.brhid,docno,if(c.perfleet=0,c.tmpfleet,c.perfleet) fleet_no,invd,"
	        		+ "if(c.per_name=1,c.per_value*12,c.per_value) mont,c.outdate as outdate,v.reg_no,v.FLNAME vehdetails,a.refname,"
	        		+ "round(c.pyttotalrent,2) lcost,(coalesce(c.pyttotalrent,0)-invd) as bal from (select rdocno docno,coalesce(sum(amount),0) invd "
	        		+ "from gl_leasepytcalc where markstatus!=0 group by rdocno union all select doc_no docno,0 invd from gl_lagmt l"
	        		+ " "+sqlt+") a left join gl_lagmt c on(c.doc_no=a.docno)"
	        		+ " left join gl_vehmaster v on if(c.perfleet=0,c.tmpfleet,c.perfleet)=v.fleet_no"
	        		+ " left join my_acbook a on a.cldocno=c.cldocno and a.dtype='CRM'  where c.status=3 and "
	        		+ "c.outdate between   '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+"  group by a.docno) as b";
	           
	//    System.out.println("----lllllllll------"+sql);
	          
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
	    
	    
	    public  JSONArray subDetails(String fromdate,String todate,String branchval) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        String sqltest="";
	       
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
	 	   
	    	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and l.brhid='"+branchval+"'";
	 		}
	        Connection conn = null;
	       
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
		      				String sql="  select 'OPEN' status,count(*) count from gl_lagmt l where clstatus=0 and l.outdate between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+" "
		      						+ "union all "
		      						+ "select 'CLOSE' status,count(*) count from gl_lagmt l where clstatus=1 and l.outdate between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+""
		      						+ " union all "
		      						+ "select 'ALL' status,count(*) count from gl_lagmt l where l.outdate between   '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+" "; 
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	     				stmtVeh.close();
	     				conn.close();
			}
			catch(Exception e){
				conn.close();
				
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }   
	
	
}
