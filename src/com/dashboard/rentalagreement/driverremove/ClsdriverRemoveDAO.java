package com.dashboard.rentalagreement.driverremove;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsdriverRemoveDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public  JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
     
        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
    	 
 
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				 
				String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where r.clstatus=0 and r.status=3 "+sqltest+" group by doc_no");
				
		//	System.out.println("------sql------"+sql);
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		     
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	public   JSONArray clientDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select r.cldocno,a.refname from gl_ragmt r left join  my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  where r.clstatus=0 and  r.status=3 and a.dtype='CRM' group by r.cldocno";
		
		ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	 public  JSONArray driverlist(String branchval,String fromdate,String todate,String cldocno,String agmtNo) throws SQLException {

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
 
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and agmt.cldocno='"+cldocno+"'";
	    	}
	    	 
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and agmt.doc_no='"+agmtNo+"'";
	    	}
	     
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and agmt.brhid="+branchval+"";
	 		}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection(); 
					Statement stmt = conn.createStatement (); 
				 
				
	            		String sql ="	select agmt.doc_no,agmt.voc_no,agmt.fleet_no,r.brhid,v.flname,r.cldocno,r.srno,a.refname,dr.name drname, 'Edit' btnsave from  gl_ragmt agmt inner join  gl_rdriver r on r.rdocno=agmt.doc_no and r.cldocno=agmt.cldocno\r\n" + 
	            				"			 inner join my_acbook a on a.cldocno=agmt.cldocno\r\n" + 
	            				"			and a.dtype='CRM' inner join gl_drdetails dr on dr.dr_id=r.drid left join gl_vehmaster v on  v.fleet_no=agmt.fleet_no\r\n" + 
	            				"			where agmt.clstatus=0  and agmt.status=3 and r.status=3 and agmt.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +"   group by r.srno order by agmt.doc_no   ";
	            			 
	            	 //	System.out.println(""+sql);
	              
	            		ResultSet resultSet = stmt.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	            		 stmt.close();
	            	
	          
	            	
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
