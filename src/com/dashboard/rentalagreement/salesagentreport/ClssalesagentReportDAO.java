package com.dashboard.rentalagreement.salesagentreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 

public class ClssalesagentReportDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	
	 public   JSONArray salesagentReport(String branchval,String fromdate,String todate,String  type,String hidrag, String hidsag,String clstatuss) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     		return RESULTDATA;
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     		return RESULTDATA;
	     	}
	     	
	      	
     	String sqltest="";
     	//String sqltest1="";
	    	if(!(hidrag.equalsIgnoreCase("")|| hidrag.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and r.doc_no in ("+hidrag+") ";
	    	}
	    	if(!(hidsag.equalsIgnoreCase("") || hidsag.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and sa.doc_no in ("+hidsag+") ";
	    	}
	    	
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and m.brhid="+branchval+"";
	 		}
	    	
	      	if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and r.clstatus ="+clstatuss+" ";
	    	}
	    	
	      String sqlss="";	
	      	if(type.equalsIgnoreCase("summary"))
	      	{
	      		sqlss=" group by r.said  ";
	      	}
	      	else
	      	{
	      		sqlss=" group by m.doc_no ";
	      	}
	      	
	      	
	      	
	      	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					if(type.equalsIgnoreCase("summary"))
			      	{
					
						String sql ="select  a.date,a.doc_no,a.acname,a.acno,a.saname,a.sadocno,sum(amount) amount ,convert(if(sum(rent)=0,'',sum(rent)),char(50)) rent , "
								+ " convert(if(sum(inschg)=0,'',sum(inschg)),char(50)) inschg, "
					+ "  convert(if(sum(accchg)=0,'',sum(accchg)),char(50))  accchg, convert(if(sum(salik)=0,'',sum(salik)),char(50)) salik,convert(if(sum(traffic)=0,'',sum(traffic)),char(50)) traffic, "
					+ "  convert(if(sum(other)=0,'',sum(other)),char(50)) other from (select  m.date,m.voc_no doc_no,h.description acname,h.account acno,sa.sal_name saname,r.said sadocno, "
					 + "  r.voc_no  rano,m.cldocno,m.fromdate,m.todate,  convert(coalesce(sum(d.total),''),char(50)) amount , " 
					 + "   convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
					 + "    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
					  + "    convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
					  + "     convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
					 + "      convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic , "
					   + "    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19)),' '), "
					    + "   char(50)) other , r.mrano mrano   from gl_ragmt r inner join   my_salesman "
					     + "   sa on sa.doc_no=r.said and sa.sal_type='SLA' inner join  gl_invm m  on r.doc_no=m.rano "
					    + "    inner join gl_invd d on m.doc_no=d.rdocno   left join my_head h on h.doc_no=m.acno where "
					   + "    m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +"   group by m.doc_no  order by m.doc_no) a group by a.sadocno " ;
			System.out.println(sql);
						ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
			      	}
					else
					{
						
					 
				
	            		String sql ="select  m.date,m.status,m.voc_no doc_no,h.description acname,h.account acno,m.ratype,sa.sal_name saname,r.said sadocno,"
	            				+ "  r.voc_no  rano,m.cldocno,m.fromdate,m.todate, "
	            				+ " convert(coalesce(sum(d.total),''),char(50)) amount , "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
	            				+ "convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic ,   "
	            				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19)),' '),char(50)) other ,"
	            			    + " r.mrano mrano  "
	            				+ " from gl_ragmt r inner join   my_salesman   sa on sa.doc_no=r.said and sa.sal_type='SLA' inner join"
	            				+ "  gl_invm m  on r.doc_no=m.rano inner join gl_invd d on m.doc_no=d.rdocno "
	            		
	            				+ "  left join my_head h on h.doc_no=m.acno"
	            			    + " where   m.status=3 and "
	            				+ " m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +"  group by m.doc_no   order by m.doc_no";
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
					}
 
	              
	            
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
	    

	 
	 public   JSONArray salesagentReports(String branchval,String fromdate,String todate,String  type,String hidrag, String hidsag,String clstatuss) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     		return RESULTDATA;
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     		return RESULTDATA;
	     	}
	     	
	      	
  	String sqltest="";
  	//String sqltest1="";
	    	if(!(hidrag.equalsIgnoreCase("")|| hidrag.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and r.doc_no in ("+hidrag+") ";
	    	}
	    	if(!(hidsag.equalsIgnoreCase("") || hidsag.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and sa.doc_no in ("+hidsag+") ";
	    	}
	    	
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and m.brhid="+branchval+"";
	 		}
	    	
	      	if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and r.clstatus ="+clstatuss+" ";
	    	}
	    	
	  
	      	
	      	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					

					// Amount	 'Rental Sum'  'Insurance Charges'  Acc_Sum 'Salik Amt' 'Traffic Amt' 'Other Charges'
				
	            		String sql ="select m.voc_no 'Doc No',DATE_FORMAT(m.date,'%d.%m.%Y')   Date ,r.said 'Ref No',sa.sal_name 'Ref Name', r.voc_no  'RA No'  ,  r.mrano 'MRA NO', "
	            				+ " DATE_FORMAT(m.fromdate,'%d.%m.%Y') 'From Date'  ,DATE_FORMAT(m.todate,'%d.%m.%Y') 'To Date' , h.account Account, h.description 'Account Name',"
	            				+ "  r.voc_no  'RA No', "
	            				+ " convert(coalesce(round(sum(d.total),2),''),char(50)) Amount ,"
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) 'Rental Sum', "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) 'Insurance Charges' , "
	            				+ "convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) Acc_Sum, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) 'Salik Amt', "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) 'Traffic Amt' ,   "
	            				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19)),' '),char(50)) 'Other Charges' "
	            			  	+ " from gl_ragmt r inner join   my_salesman   sa on sa.doc_no=r.said and sa.sal_type='SLA' inner join"
	            				+ "  gl_invm m  on r.doc_no=m.rano inner join gl_invd d on m.doc_no=d.rdocno "
	            						+ "  left join my_head h on h.doc_no=m.acno"
	            			    + " where   m.status=3 and "
	            				+ " m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by m.doc_no  order by m.doc_no";
	         
	           //   System.out.println("----------"+sql);
	              
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
	    

	 
	
	
	
		public   JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno ) throws SQLException {

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
							+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where r.status=3 "+sqltest+" group by doc_no");
					
				//System.out.println("--sql------"+sql);
					
					
					
					
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
	
	
		
		public   JSONArray getsalesagent() throws SQLException {  
	        JSONArray RESULTDATA=new JSONArray();
	        Connection  conn =null;
			try {
				conn=ClsConnection.getMyConnection();
				Statement stmtsales=conn.createStatement();
					String strSql="select s.doc_no,s.sal_name from my_salesman s inner join gl_ragmt m on m.said=s.doc_no  where s.sal_type='SLA' and s.status=3 group by s.doc_no;";
	             	ResultSet resultSet = stmtsales.executeQuery (strSql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
	        		stmtsales.close();
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
	        return RESULTDATA;
	    }
	
	
	
	
	
}
