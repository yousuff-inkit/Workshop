package com.dashboard.analysis.termloanreports;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsTermLoanReportsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	
	public JSONArray searchsumm(String branch,String type,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        /*	String sqltest1="";	*/
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
				
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}	
		    	
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and dt.rpaccno='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
				
	  	if(type.equalsIgnoreCase("summary"))
		    	{
		    		
	  	
	  		
	  		String sql="select dt.dealno ,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate,  "
	  				+ "DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,round(dt.loanamt,2) totalval,"
	  				+ " round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
	  				+ " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
	  				+ " round(coalesce(det.pramt,0)-coalesce(m.pramt,0),2) principle2 ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) interest2,round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) pytvalue2"
	  				+ " from gl_termloanm  vo    left join gl_termloandetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
	  				+ "  left join my_head hh on hh.doc_no=dt.rpaccno  left join my_head h1  "
	  				+ " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	  				+ " from gl_termloandetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 group by rdocno) "
	  				+ "det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	  				+ "from gl_termloandetd det  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 "
	  				+ " left join  my_chqbm m on um.bpvno=m.doc_no   and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' where "
	  				+ "(um.bpvno=9999999 or m.doc_no is not null)  group by rdocno) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and"
	  				+ " vo.status=3 and vo.date<='"+sqlUpToDate+"'  "+sqltest+"   group by vo.doc_no ";
	   	//System.out.println("=summary=== "+sql);
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
	
	public JSONArray searchsummexcel(String branch,String type,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	String sqltest1="";	
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
				
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}	
				
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and dt.rpaccno='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
          	if(type.equalsIgnoreCase("summary"))
		    	{
		    		
		    
       		
  
          		 String sql="select vo.doc_no 'Doc No',dt.dealno 'Deal No',hh.description 'Financier Name' ,hh.account 'Account',DATE_FORMAT(dt.stdate,'%d.%m.%Y') 'Start_Date', "
          	           + " DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') 'End_Date',round(dt.loanamt,2) 'Value', "
          	           + " round(dt.perintst,2) '% Interest',round( det.intstamt,2) ' Finance Interest',round( det.pramt,2) 'Finance Principle' , "
          	           + " round( det.totamt,2) 'Finance Value',round( m.intstamt,2) 'Paid Interest', round( m.pramt,2) 'Paid Principle' ,round( m.totamt,2) 'Paid Value', "
          	           + " round( coalesce(det.pramt,0)-coalesce(m.pramt,0),2) 'Bal Principle' ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) 'Bal Interest',round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) 'Bal Value' "
          	         + " from gl_termloanm  vo    left join gl_termloandetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
 	  				+ "  left join my_head hh on hh.doc_no=dt.rpaccno  left join my_head h1  "
 	  				+ " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
 	  				+ " from gl_termloandetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 group by rdocno) "
 	  				+ "det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
 	  				+ "from gl_termloandetd det  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 "
 	  				+ " left join  my_chqbm m on um.bpvno=m.doc_no   and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' where "
 	  				+ "(um.bpvno=9999999 or m.doc_no is not null)  group by rdocno) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and "
 	  				+ " vo.status=3 and vo.date<='"+sqlUpToDate+"'  "+sqltest+"   group by vo.doc_no ";
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
	
	
	public JSONArray searchdetailsdata(String branch,String type,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
	        	
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}	
				
          		ResultSet rss=stmtVeh.executeQuery("select dtype from gl_termloanm  limit 1");
          		String dtype="TLN";
          		if(rss.first())
          		{
          			dtype=rss.getString("dtype");
          			
          		}
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and dt.rpaccno='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
	          	if(type.equalsIgnoreCase("detail"))
			    	{
 
	          		
	          		String sql="select um.bpvno,if(um.bpvno>0,'Paid','Not paid') paid,det.date chqdate,dt.chqname,dt.sectychqno,vo.doc_no,dt.stdate,  "
	          				+ " DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.loanamt totalval, "
	          				+ "	round(dt.perintst,2) intst ,  dt.dealno,hh.description financiername,hh.account account, "
	          				+ "	convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and um.status<>7),''),char(50)) interest,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) principle,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2  and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) pytvalue,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0  and um.status<>7),''),char(50)) interest1,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) principle1,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) pytvalue1,  "
	          		        + " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7),''),char(50)) interest2,  "
	          		        + " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) principle2,  "
	          		        + " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) pytvalue2  "
	          		        + " from gl_termloandetd det left join gl_termloanm vo on vo.doc_no=det.rdocno  left join gl_termloandetm dt on dt.rdocno=vo.doc_no  "
	          		        + "    left join my_head hh on hh.doc_no=dt.rpaccno left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP'  and um.status<>7  "
	          		        + "  and um.refno like '"+dtype+"%'  where  vo.clstatus=1 and vo.status=3 and det.date<='"+sqlUpToDate+"' and um.date<='"+sqlUpToDate+"' "+sqltest;
	          		
         //  		System.out.println("---detail----"+sql);

            		
           
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
	public JSONArray searchexceldetailsdata(String branch,String type,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
	        	
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}	
		   		
          		ResultSet rss=stmtVeh.executeQuery("select dtype from gl_termloanm  limit 1");
          		String dtype="TLN";
          		if(rss.first())
          		{
          			dtype=rss.getString("dtype");
          			
          		}
          		
          		
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and dt.rpaccno='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
	        	if(type.equalsIgnoreCase("detail"))
				    	{
				    			  	
	        		/*gl_termloandetm,gl_termloandetd,gl_termloanm ,gl_vpurm,gl_vpurdetm,gl_vpurdetd,VPU*/
				//dealno financiername account   order by dt.dealno
            		
            	   String sqldet=" select if(um.bpvno>0,'Paid','Not paid') 'Paid',DATE_FORMAT(det.date,'%d/%m/%Y') 'Cheque Date',dt.chqname 'Cheque Name',dt.sectychqno 'Cheque NO', "
            				+ " DATE_FORMAT(dt.stdate,'%d/%m/%Y') 'Start Date', DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d/%m/%Y') 'End Date',round(dt.loanamt,2) 'Value', "
            				+ " round(dt.perintst,2) '% Interest' ,  dt.dealno 'Deal No',hh.description 'Financier Name',hh.account 'Account', "
            				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2  and um.status<>7),''),char(50)) 'Finance Taken Interest', "
            				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) 'Finance Taken Principle',  "
            				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2  and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) 'Finance Taken value',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0 and um.status<>7),''),char(50)) 'Paid Interest', "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) 'Paid Principle',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) 'Paid value' , "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7),''),char(50)) 'Balance Interest',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) 'Balance Principle',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) 'Balance value'  "
            				+ " from gl_termloandetd det left join gl_termloanm vo on vo.doc_no=det.rdocno  left join gl_termloandetm dt on dt.rdocno=vo.doc_no  "
            				+ "    left join my_head hh on hh.doc_no=dt.rpaccno left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP'  and um.status<>7  "
            				+ "  and um.refno like '"+dtype+"%'  where  vo.clstatus=1 and vo.status=3 and det.date<='"+sqlUpToDate+"' and um.date<='"+sqlUpToDate+"' "+sqltest;
     		
            		
            		//System.out.println("---detailexcel---sql----"+sqldet);

            		
           
            		ResultSet resultSet = stmtVeh.executeQuery(sqldet);
            	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            	 
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

	
	
	
	

	public JSONArray dealnoseachmove() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
			String sql="select dealno from gl_termloandetm";
				
            	//	System.out.println(""+sql);
            		
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
	
	
	public JSONArray rcpancesearch(String accountno,String accountname,String check) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		         String sqltest="";
		        //  String sql="";
		          
		          if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		              sqltest=sqltest+" and account like '%"+accountno+"%'";
		          }
		          if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and description like '%"+accountname+"%'";
		          }
		          
		          if(check.equalsIgnoreCase("1"))
		          {
		      
			        
		        String sql="select t.doc_no,t.account acc_no,t.description fname from my_head t where t.atype in ('GL','AP','AR') and  t.m_s=0 "+sqltest;;
		          
		            //  System.out.println("=========sql========"+sql);
		              
		              
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		          } 
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }
}
