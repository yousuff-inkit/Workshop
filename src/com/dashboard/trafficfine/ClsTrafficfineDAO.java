package com.dashboard.trafficfine;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsTrafficfineDAO{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public   JSONArray unallocation(String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqluptodate = null;
      
        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))){
          sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
        Connection conn =null;
        
        try {
        	conn = ClsConnection.getMyConnection();
        	Statement stmtVeh = conn.createStatement();
    
        	String sql=("select 'Edit' btnsave,regNo,coalesce(Source,'') Source,TRAFFIC_DATE,time,round(AMOUNT,2) AMOUNT,Ticket_No,pcolor,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch,convert(coalesce(REASON,''),char(30)) REASON from  gl_traffic  where  status in (0,3 )and  ISALLOCATED=0 and TRAFFIC_DATE<='"+sqluptodate+"' ");
    
        	ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);

       stmtVeh.close();
       conn.close();
  }
  catch(Exception e){
	  e.printStackTrace();
      conn.close();
  }
    return RESULTDATA;
}
	
	public   JSONArray allocationlist(String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqluptodate = null;
      
        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))){
          sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
        Connection conn =null;

        try {
        	conn = ClsConnection.getMyConnection();
        	Statement stmtVeh = conn.createStatement();
    
        	/*String sql=("select regNo,Ticket_No,coalesce(Source,'') Source,TRAFFIC_DATE,round(AMOUNT,2) AMOUNT,pcolor,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch,convert(coalesce(REASON,''),char(30)) REASON from  gl_traffic  where ISALLOCATED=1 and TRAFFIC_DATE<='"+sqluptodate+"' ");*/
    
        	
        	String sql=("select t.rtype,t.ra_no doccc,t.regNo,t.Ticket_No,coalesce(t.Source,'') Source,t.TRAFFIC_DATE,time,round(t.AMOUNT,2) AMOUNT, "
        			+ "    	t.pcolor,	case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when "
        			+ "    	t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',convert(coalesce(t.branch,''),char(30)) branch, "
        			+ "   	convert(coalesce(t.REASON,''),char(30)) REASON from  gl_traffic t  left join gl_ragmt ragmt on "
        			+ "  	 (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))   left join gl_lagmt  lagmt on "
        			+ "    	 (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) where  t.status in (0,3) and  t.ISALLOCATED=1 and t.TRAFFIC_DATE<='"+sqluptodate+"' ");
        	//System.out.println("-------sql----"+sql);
        	
        			       	ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);

       stmtVeh.close();
       conn.close();
  }
  catch(Exception e){
	  e.printStackTrace();
      conn.close();
  }
    return RESULTDATA;
  }
	
	
	public JSONArray notInvoicedGridLoading(String branch,String fromDate, String toDate, String cldocno, String rentalType, String agmtNo) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtTraffic = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and s.traffic_date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and s.traffic_date<='"+sqlToDate+"'";
			     }
		        
		        if(!(cldocno.equalsIgnoreCase(""))){
		        	sql+=" and a.cldocno='"+cldocno+"'";
		        }
		        
		        if(!(rentalType.equalsIgnoreCase(""))){
		        	if(rentalType.equalsIgnoreCase("RAG")){
		        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
		        	}
		        	else if(rentalType.equalsIgnoreCase("LAG")){
		        		sql+=" and s.rtype IN ('LA', 'LC')";
		        	}
		         }
		        
		        if(!(agmtNo.equalsIgnoreCase(""))){
		        	sql+=" and s.ra_no='"+agmtNo+"'";
		           }
				
				
				String strfees="select method,value from gl_config where field_nme='govTrafficFees'";
		        ResultSet rsfees=stmtTraffic.executeQuery(strfees);
		        int feesmethod=0;
		        double feesvalue=0.0;
		        while(rsfees.next()){
		        	feesmethod=rsfees.getInt("method");
		        	feesvalue=rsfees.getDouble("value");
		        }
		        
		        
				
				sql = "select         if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno,s.regno,s.ticket_no,s.fleetno,s.location,s.source,if("+feesmethod+"=1 and s.fine_source like '%DUBAI%',"+
								" coalesce(round(s.amount,2),0)+"+feesvalue+",coalesce(round(s.amount,2),0)) amount,s.ra_no,s.rtype,s.traffic_date,a.refname"+
						" from gl_traffic s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
						" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and emp_type=a.dtype)"+
						" where inv_no=0 and isallocated=1 and emp_type='CRM' "+sql+" and s.ra_no<>0 and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") order by s.rtype,s.ra_no";
//				System.out.println("============ "+sql);
				ResultSet resultSet = stmtTraffic.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtTraffic.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray invoicedGridLoading(String branch,String fromDate, String toDate, String cldocno, String rentalType, String agmtNo) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtTraffic = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    String sql1 = "";
			    
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and m.date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and m.date<='"+sqlToDate+"'";
			     }
		        
		        if(!(cldocno.equalsIgnoreCase(""))){
		        	sql+=" and ac.cldocno='"+cldocno+"'";
		        }
		        
		        if(!(rentalType.equalsIgnoreCase(""))){
		        	if(rentalType.equalsIgnoreCase("RAG")){
		        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
		        	}
		        	else if(rentalType.equalsIgnoreCase("LAG")){
		        		sql+=" and s.rtype IN ('LA', 'LC')";
		        	}
		         }
		        
		        if(!(agmtNo.equalsIgnoreCase(""))){
		        	sql+=" and s.ra_no='"+agmtNo+"'";
		           }
				double govfees=getGovFees(conn);
				sql1 = "select  case when s.rtype in ('RM','RA', 'RD','RW','RF') then r.voc_no when s.rtype in ('LA','LC')  then l.voc_no\r\n" + 
						"else s.ra_no end as 'rano',\r\n" + 
						"case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT'\r\n" + 
						"when s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',\r\n" + 
						"m.voc_no invno,\r\n" + 
						"coalesce(ac.refname,sa.sal_name) refname,            s.regno,s.ticket_no,s.fleetno,s.location,s.source,convert(coalesce(if(s.fine_source like '%DUBAI%' && "+govfees+">0,s.amount+"+govfees+",s.amount),''),char(100)) amount,s.ra_no,ac.refname\r\n" + 
						"from gl_traffic s left join gl_ragmt r on s.ra_no=r.doc_no and ((s.rtype='RM')or(s.rtype='RA')or(s.rtype='RD')or(s.rtype='RW')or(s.rtype='RF'))\r\n" + 
						"left join gl_lagmt l on s.ra_no=l.doc_no and ((s.rtype='LA')or(s.rtype='LC'))\r\n" + 
						"  left join gl_status st on s.rtype=st.Status\r\n" + 
						"left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type\r\n" + 
						"left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type\r\n" + 
						"left join gl_invm m on s.inv_no=m.doc_no and s.inv_type='INV'\r\n" + 
						"\r\n" + 
						"left join my_jvtran j on s.inv_no=j.doc_no and s.inv_type='JVT'\r\n" + 
						"where s.inv_no!=0 and s.isallocated=1"+sql+" and s.ra_no<>0 and emp_type='CRM' group by s.sr_no,s.doc_no";
				//System.out.println(sql1);
				ResultSet resultSet = stmtTraffic.executeQuery(sql1);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtTraffic.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray staffAllocatedGridLoading(String branch,String fromDate, String toDate, String type, String employee) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtTraffic = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.branch="+branch+"";
	    		}
				
				if(!(sqlFromDate==null)){
		        	sql+=" and t.traffic_date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and t.traffic_date<='"+sqlToDate+"'";
			     }
		        
		        if(!(type.equalsIgnoreCase(""))){
		        	if(type.equalsIgnoreCase("STF")){
		        		sql+=" and t.emp_type='STF'";
		        	}
		        	else if(type.equalsIgnoreCase("DRV")){
		        		sql+=" and t.emp_type='DRV'";
		        	}
		         }
		        
		        if(!(employee.equalsIgnoreCase(""))){
		        	sql+=" and t.emp_id like '%"+employee+"%'";
		           }
				
				 sql = "select t.doc_no,t.sr_no,t.emp_id,t.regno,t.ticket_no,t.fleetno,t.location,t.source,1 amountcount,(t.amount) totalamount,st.st_desc,if(t.emp_type='STF','Staff','Driver') emp_type,"
						  + "m.sal_name,m.acc_no accno,(select acno from gl_invmode where idno=9) trafficacc,(select branch from my_brch where mainbranch=1) mainbranch,convert(concat(' Fleet : ',coalesce(t.fleetno),'  ',"
						  + "coalesce(t.regno), ' * ','Traffic Ticket  : ',coalesce(t.ticket_no),' * ','Emp Name : ' ,coalesce(m.sal_name),' * ','Emp Type : ', coalesce(t.emp_type)),char(1000)) empinfo from gl_traffic t "
						  + "left join gl_status st on st.status=t.rtype left join my_salesman m on t.emp_id=m.doc_no and m.sal_type=t.emp_type where t.emp_type in ('STF','DRV') and t.amount!=0 and t.inv_no=0 "+sql+"";
				
				// System.out.println(sql);
				ResultSet resultSet = stmtTraffic.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtTraffic.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray clientDetails(String docNo,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtSailk = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(docNo.equalsIgnoreCase(""))){
	                sql=sql+" and cldocno like '%"+docNo+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and refname like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select cldocno,refname,per_mob,acno,trim(address) address from my_acbook where status=3 and dtype='CRM'"+sql;
				
				ResultSet resultSet1 = stmtSailk.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtSailk.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	     String sqltest="";
	     
	     if(rentaltype.equalsIgnoreCase("RAG")){
	        
	      if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("0")))){
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
	     }
	     
	     else if(rentaltype.equalsIgnoreCase("LAG")){
	      
	      if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       sqltest+=" and  l.brhid="+branch+"";
	      }
	         
	         if(!(sclname.equalsIgnoreCase(""))){
	          sqltest+=" and a.RefName like '%"+sclname+"%'";
	         }
	         if(!(smob.equalsIgnoreCase(""))){
	          sqltest+=" and a.per_mob like '%"+smob+"%'";
	         }
	         if(!(rno.equalsIgnoreCase(""))){
	          sqltest+=" and l.voc_no like '%"+rno+"%'";
	         }
	         if(!(flno.equalsIgnoreCase(""))){
	          sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
	         }
	         if(!(sregno.equalsIgnoreCase(""))){
	          sqltest+=" and v.reg_no like '%"+sregno+"%'";
	         }
	     }
	     
	     Connection conn=null;
	     
	  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtTraffic = conn.createStatement();
		    
		    if(rentaltype.equalsIgnoreCase("RAG")){
		    
		    String sql=("select r.doc_no,r.voc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
		      + " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no");

		    ResultSet resultSet = stmtTraffic.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtTraffic.close();
		    conn.close();
	       }
		    
	    else if(rentaltype.equalsIgnoreCase("LAG")){
	     
		     String sql=("select l.doc_no,l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
		       + " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no"); 
		     
		     ResultSet resultSet = stmtTraffic.executeQuery(sql);
		     RESULTDATA=ClsCommon.convertToJSON(resultSet);
		     
		     stmtTraffic.close();
		     conn.close();
	       }
		    stmtTraffic.close();
		    conn.close();
	  }catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }finally{
		  conn.close();
	  }
       return RESULTDATA;
   }
	
	public  ClsTrafficfineBean getPrint(HttpServletRequest request,String branch,String fromdate, String todate) throws SQLException {
		ClsTrafficfineBean bean = new ClsTrafficfineBean();

		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
        Connection conn = null;
        
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtTraffic = conn.createStatement();
		String sql="";
		
		sql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname from gl_traffic t inner join my_brch b on t.branch=b.doc_no inner join my_comp c on "
			+ "b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
			+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) group by t.branch";
		
		ResultSet resultSet = stmtTraffic.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblbranch(resultSet.getString("branchname"));
		}
		
		String sql1 = "",sql2 = "";
		
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			sql2+=" and inv.brhid="+branch+"";
		}
		
		if(!(sqlFromDate==null)){
        	sql2+=" and inv.fromdate>='"+sqlFromDate+"'";
	     }
        
        if(!(sqlToDate==null)){
        	sql2+=" and inv.todate<='"+sqlToDate+"'";
	     }
		
		sql1 = "select t.regno,t.ticket_no,t.fleetno,DATE_FORMAT(t.traffic_date,'%d-%m-%Y') trafficdate,t.time traffictime,t.ra_no,t.inv_no,t.amount,a.refname,"
			+ " t1.amt total from gl_traffic t left join gl_ragmt r on t.ra_no=r.doc_no "
			+ "and ((t.rtype='RM')or(t.rtype='RA')or(t.rtype='RD')or(t.rtype='RW')or(t.rtype='RF')) left join gl_lagmt l on t.ra_no=l.doc_no and ((t.rtype='LA')or(t.rtype='LC')) "
			+ "left join my_acbook a on ((r.cldocno=a.cldocno or l.cldocno=a.cldocno) and a.dtype='CRM') left join gl_invm inv on inv.doc_no=t.inv_no "
			+ " left join (select sum(t.amount) amt,t.emp_id from gl_traffic t  left join gl_invm inv on inv.doc_no=t.inv_no "
			+ " where inv_no!=0 and t.emp_type='crm' and isallocated=1  "+sql2+"  group by t.emp_id) t1 on t1.emp_id=a.cldocno and a.dtype='crm' "
			+ " where t.inv_no!=0 and t.emp_type='crm' and t.isallocated=1 and t.amount!=0 "+sql2+" order by refname";
		// System.out.println(sql1);
		ResultSet resultSet1 = stmtTraffic.executeQuery(sql1);
		
		ArrayList<String> printarray= new ArrayList<String>();
		String temps="",temps1="";
		String tempskey="";
		HashMap<String, ArrayList<String>> maps = new HashMap<String, ArrayList<String>>();
		
		while(resultSet1.next()){
			temps1=resultSet1.getString("refname")+"::"+resultSet1.getString("total");
			if(!(temps1.equalsIgnoreCase(tempskey))){
				printarray=new ArrayList<String>();
			}
			temps=resultSet1.getString("regno")+"::"+resultSet1.getString("ticket_no")+"::"+resultSet1.getString("fleetno")+"::"+resultSet1.getString("trafficdate")+"::"+resultSet1.getString("traffictime")+"::"+resultSet1.getString("ra_no")+"::"+resultSet1.getString("inv_no")+"::"+resultSet1.getString("amount");
			
		    printarray.add(temps);
		    
		    maps.put(temps1 , printarray );
		    tempskey=temps1;
		}
		request.setAttribute("printingarray", maps);

		stmtTraffic.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }
	
	public  ClsTrafficfineBean getPrintToBeInvoiced(HttpServletRequest request,String branch,String fromdate, String todate,String agmtno,String rentaltype,String cldocno) throws SQLException {
		ClsTrafficfineBean bean = new ClsTrafficfineBean();
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
        Connection conn = null;
        
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtTraffic = conn.createStatement();
		String sql="";
		
		sql="select c.company,c.address,c.tel,c.fax,b.branchname,l.loc_name location from  my_brch b  left join my_locm l on "
				+ "l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no where b.doc_no="+branch+" group by b.doc_no";
		
		ResultSet resultSet = stmtTraffic.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblbranch(resultSet.getString("branchname"));
		}
		
		String sql1 = "";
		
		
		if(!(sqlFromDate==null)){
        	sql1+=" and t.traffic_date>='"+sqlFromDate+"'";
	     }
        
        if(!(sqlToDate==null)){
        	sql1+=" and t.traffic_date<='"+sqlToDate+"'";
	     }
        
        if(!(rentaltype.equalsIgnoreCase("") && rentaltype.equalsIgnoreCase("undefined") && rentaltype.equalsIgnoreCase("0")))
        {
        	if(rentaltype.equalsIgnoreCase("RAG")){
        		sql1+=" and t.rtype in ('RA','RW','RF','RD','RM')";
        	}
        	else if(rentaltype.equalsIgnoreCase("LAG")){
        		sql1+=" and t.rtype in ('LA','LC')";
        	}
        }
        
        if(!(agmtno.equalsIgnoreCase("") && agmtno.equalsIgnoreCase("undefined") && agmtno.equalsIgnoreCase("0"))){
        	if(rentaltype.equalsIgnoreCase("RAG")){
        		sql1+=" and r.voc_no="+agmtno+"";
        	}
        	else if(rentaltype.equalsIgnoreCase("LAG")){
        		sql1+=" and l.voc_no="+agmtno+"";
        	}
        }
		
        if(!cldocno.equalsIgnoreCase("0")){
        	sql1+=" and t.emp_id="+cldocno+" and t.emp_type='CRM'";
        }
        
        sql1 = "select t.regno,t.ticket_no,t.fleetno,DATE_FORMAT(t.traffic_date,'%d-%m-%Y') trafficdate,t.time traffictime,t.ra_no,t.inv_no,t.amount,a.refname,"
    			+ "(select sum(t.amount) from gl_traffic t left join gl_ragmt r on t.ra_no=r.doc_no and ((t.rtype='RM')or(t.rtype='RA')or(t.rtype='RD')or(t.rtype='RW')or"
    			+ "(t.rtype='RF')) left join gl_lagmt l on t.ra_no=l.doc_no and ((t.rtype='LA')or(t.rtype='LC')) where ((l.cldocno=a.doc_no or r.cldocno=a.doc_no) and "
    			+ "a.dtype='CRM') and inv_no=0 and isallocated=1 "+sql1+" group by (r.cldocno or l.cldocno)) total from gl_traffic t left join gl_ragmt r on t.ra_no=r.doc_no "
    			+ "and ((t.rtype='RM')or(t.rtype='RA')or(t.rtype='RD')or(t.rtype='RW')or(t.rtype='RF')) left join gl_lagmt l on t.ra_no=l.doc_no and ((t.rtype='LA')or(t.rtype='LC')) "
    			+ "left join my_acbook a on ((r.cldocno=a.cldocno or l.cldocno=a.cldocno)and a.dtype='CRM') where inv_no=0 and isallocated=1 and emp_type='CRM' and t.amount!=0 and "
    			+ "if(t.rtype in ('RA','RD','RW','RF','RM'),r.brhid,l.brhid)="+branch+" "+sql1+"";
		
//        System.out.println("Print Traffic Query: "+sql1);
		ResultSet resultSet1 = stmtTraffic.executeQuery(sql1);
		
		ArrayList<String> printtobeinvoicedarray= new ArrayList<String>();
		String temp="",temp1="";
		String tempkey="";
		HashMap<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
		
		while(resultSet1.next()){
			temp1=resultSet1.getString("refname")+"::"+resultSet1.getString("total");
			if(!(temp1.equalsIgnoreCase(tempkey))){
				printtobeinvoicedarray=new ArrayList<String>();
			}
			temp=resultSet1.getString("regno")+"::"+resultSet1.getString("ticket_no")+"::"+resultSet1.getString("fleetno")+"::"+resultSet1.getString("trafficdate")+"::"+resultSet1.getString("traffictime")+"::"+resultSet1.getString("ra_no")+"::"+resultSet1.getString("inv_no")+"::"+resultSet1.getString("amount");
			
			printtobeinvoicedarray.add(temp);
		    
		    map.put(temp1 , printtobeinvoicedarray );
		    tempkey=temp1;
		}
		request.setAttribute("printingtobeinvoicedarray", map);
		
		stmtTraffic.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }

	public ArrayList<String> getTrafficDetails(String branch,java.sql.Date sqlFromDate, java.sql.Date sqlToDate, String cldocno, String rentalType, String agmtNo,HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
		
		Connection conn=null;
		try{
			
			ArrayList<String> invoicedoc=new ArrayList<String>();
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtacno=conn.createStatement();
			ClsManualInvoiceDAO invoicedao=new ClsManualInvoiceDAO();
			String strtrafficacno="select (select acno from gl_invmode where idno=9)trafficacno,(select acno from gl_invmode where idno=15)trafficsrvcacno";
			ResultSet rsacno=stmtacno.executeQuery(strtrafficacno);
			int trafficacno=0;
			int trafficsrvcacno=0;
			while(rsacno.next()){
				trafficacno=rsacno.getInt("trafficacno");
				trafficsrvcacno=rsacno.getInt("trafficsrvcacno");
			}
			stmtacno.close();
			  
		    
	         
		    String sql = "";
		    
			if(!(sqlFromDate==null)){
	        	sql+=" and s.traffic_date>='"+sqlFromDate+"'";
		     }
	        
	        if(!(sqlToDate==null)){
	        	sql+=" and s.traffic_date<='"+sqlToDate+"'";
		     }
	        
	        if(!(cldocno.equalsIgnoreCase(""))){
	        	sql+=" and a.cldocno='"+cldocno+"'";
	        }
	        
	        if(!(rentalType.equalsIgnoreCase(""))){
	        	if(rentalType.equalsIgnoreCase("RAG")){
	        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
	        	}
	        	else if(rentalType.equalsIgnoreCase("LAG")){
	        		sql+=" and s.rtype IN ('LA', 'LC')";
	        	}
	         }
	        
	        if(!(agmtNo.equalsIgnoreCase(""))){
	        	sql+=" and s.ra_no='"+agmtNo+"'";
	           }
	       
	        Statement stmttraffic=conn.createStatement();
			
			
		        String strfees="select method,value from gl_config where field_nme='govTrafficFees'";
		        ResultSet rsfees=stmttraffic.executeQuery(strfees);
		        int feesmethod=0;
		        double feesvalue=0.0;
		        while(rsfees.next()){
		        	feesmethod=rsfees.getInt("method");
		        	feesvalue=rsfees.getDouble("value");
		        }
			
			/*select case when s.rtype='RM' or s.rtype='RD' or s.rtype='RW' or s.rtype='RD' then 'RAG' else 'LAG' end as rentaltype,*/
			String strtraffic="select CURDATE() date,s.rtype,a.acno,a.cldocno,s.regno,s.ticket_no,s.fleetno,s.location,s.source,if("+feesmethod+"=1 and s.fine_source like '%DUBAI%',"+
								" coalesce(round(s.amount,2),0)+"+feesvalue+",coalesce(round(s.amount,2),0)) amount,"
					+ "s.ra_no,a.refname from gl_traffic s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
						" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and emp_type=a.dtype)"+
						" where inv_no=0 and isallocated=1 and emp_type='CRM' "+sql+" and s.ra_no<>0 and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") order by s.rtype,s.ra_no";
			
			System.out.println("traffic Query: "+strtraffic);
			ResultSet rstraffic=stmttraffic.executeQuery(strtraffic);
			double amount=0.0;
			double srvc=0.0;
			int count=0;
			int flag=0;
			int temprano=0;
			int val=0;
			
			int clno=0;
			int clacno=0;
			java.sql.Date sqldate=null;
			String rtype="";
			while(rstraffic.next()){
				sqldate=rstraffic.getDate("date");
				ArrayList<String> calcarray=new ArrayList<>();
			calcarray=calculateTraffic(conn, rstraffic.getString("cldocno"), rstraffic.getDouble("amount"), 1);
			//String rtype=rstraffic.getString("rtype");
			
			
			if(temprano!=rstraffic.getInt("ra_no") || !(rtype.trim().equalsIgnoreCase(rstraffic.getString("rtype").trim()))){
				
				if(flag==1){
			ArrayList<String> invoicearray=new ArrayList<>();
					
					String note="";
					String agmttype="";
					if(rtype.equalsIgnoreCase("RM") || rtype.equalsIgnoreCase("RA") || rtype.equalsIgnoreCase("RD") || rtype.equalsIgnoreCase("RW") || rtype.equalsIgnoreCase("RF")){
						note=ClsCommon.changeSqltoString(sqlFromDate) +" to "+ClsCommon.changeSqltoString(sqlToDate) +" Traffic for Rental Aggreement No "+rstraffic.getString("ra_no");
						agmttype="RAG";
						
					}
					else if(rtype.equalsIgnoreCase("LA") || rtype.equalsIgnoreCase("LC")){
						note=ClsCommon.changeSqltoString(sqlFromDate) +" to "+ClsCommon.changeSqltoString(sqlToDate) +" Traffic for Lease Aggreement No "+rstraffic.getString("ra_no");
						agmttype="LAG";
						
					}
					
				
					invoicearray.add(9+"::"+trafficacno+"::"+note+"::"+count+"::"+amount+"::"+amount);
					invoicearray.add(15+"::"+trafficsrvcacno+"::"+note+"::"+count+"::"+srvc+"::"+srvc);
					
					String qty=ClsCommon.getMonthandDays(sqlToDate,sqlFromDate, conn);
					
					 val=invoicedao.insert(conn, invoicearray, agmttype, sqldate, clno+"", temprano, note, note, sqlFromDate,
								sqlToDate, branch, session.getAttribute("USERID").toString(),session.getAttribute("CURRENCYID").toString(),
								"A",clacno+"", "INT###9", "INT", qty);
				//	 System.out.println("After Insert Invoice of RA:"+temprano);
					 if(val>0){
					 Statement stmtgetvoc=conn.createStatement();
						 	ResultSet rsgetvoc=stmtgetvoc.executeQuery("select voc_no from gl_invm where doc_no="+val);
						 	while(rsgetvoc.next()){
						 		invoicedoc.add(rsgetvoc.getString("voc_no"));
						 	}
							Statement stmtlog=conn.createStatement();
							String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+val+","+branch+","+
									" 'BINT',now(),'"+session.getAttribute("USERID").toString()+"','A')";
							int logval=stmtlog.executeUpdate(strlog);
							if(logval<=0){
								stmtacno.close();
								stmttraffic.close();
								return null;
							}
						}
					
					// finish
					// System.out.println("After Finishing Invoice Insert");
					
					 amount=0;srvc=0;count=0;
					amount+=Double.parseDouble(calcarray.get(1));
					srvc+=Double.parseDouble(calcarray.get(0));
					count+=Integer.parseInt(calcarray.get(2));
					temprano=rstraffic.getInt("ra_no");
				
					 clno=rstraffic.getInt("cldocno");
						clacno=rstraffic.getInt("acno");
						rtype=rstraffic.getString("rtype");
					flag=1;
				}
				else{
					//System.out.println("inside not equals else");
					//System.out.println("In Case of Flag 0");
					amount+=Double.parseDouble(calcarray.get(1));
					srvc+=Double.parseDouble(calcarray.get(0));
					count+=Integer.parseInt(calcarray.get(2));
					flag=1; 
					
					temprano=rstraffic.getInt("ra_no");
					
					clno=rstraffic.getInt("cldocno");
					clacno=rstraffic.getInt("acno");
					rtype=rstraffic.getString("rtype");
				}
				
			}
			else{
				//System.out.println("In Case of Agmt No is Same");
				amount+=Double.parseDouble(calcarray.get(1));
				srvc+=Double.parseDouble(calcarray.get(0));
				count+=Integer.parseInt(calcarray.get(2));
				temprano=rstraffic.getInt("ra_no");
				
				rtype=rstraffic.getString("rtype");
				flag=1;
				clno=rstraffic.getInt("cldocno");
				clacno=rstraffic.getInt("acno");
			}	
			
					}
			ArrayList<String> invoicearray=new ArrayList<>();
			//System.out.println("Check Clinet:"+clno);
			
			String note="";
			String agmttype="";
			if(rtype.equalsIgnoreCase("RM") || rtype.equalsIgnoreCase("RA") || rtype.equalsIgnoreCase("RD") || rtype.equalsIgnoreCase("RW") || rtype.equalsIgnoreCase("RF")){
				note=ClsCommon.changeSqltoString(sqlFromDate) +" to "+ClsCommon.changeSqltoString(sqlToDate) +" for Rental Aggreement No "+temprano;
				agmttype="RAG";
			}
			else if(rtype.equalsIgnoreCase("LA") || rtype.equalsIgnoreCase("LC")){
				note=ClsCommon.changeSqltoString(sqlFromDate) +" to "+ClsCommon.changeSqltoString(sqlToDate) +" for Lease Aggreement No "+temprano;
				agmttype="LAG";
			}
			invoicearray.add(9+"::"+trafficacno+"::"+note+"::"+count+"::"+amount+"::"+amount);
			invoicearray.add(15+"::"+trafficsrvcacno+"::"+note+"::"+count+"::"+srvc+"::"+srvc);
			
			String qty=ClsCommon.getMonthandDays(sqlToDate,sqlFromDate, conn);
			//System.out.println(session.getAttribute("CURRENCYID"));
			 val=invoicedao.insert(conn, invoicearray, agmttype, sqldate, clno+"", temprano, note, note, sqlFromDate,
					sqlToDate, branch, session.getAttribute("USERID").toString(),session.getAttribute("CURRENCYID").toString(),
					"A",clacno+"", "INT###9", "INT", qty);
//			 System.out.println("val:"+val);
			 if(val>0){
			 Statement stmtgetvoc=conn.createStatement();
						 	ResultSet rsgetvoc=stmtgetvoc.executeQuery("select voc_no from gl_invm where doc_no="+val);
						 	while(rsgetvoc.next()){
						 		invoicedoc.add(rsgetvoc.getString("voc_no"));
						 	}
					Statement stmtlog=conn.createStatement();
					String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+val+",'"+session.getAttribute("BRANCHID").toString()+"',"+
							" 'BINT',now(),'"+session.getAttribute("USERID").toString()+"','A')";
					int logval=stmtlog.executeUpdate(strlog);
					if(logval<=0){
						stmtacno.close();
						stmttraffic.close();
						return null;
					}
				}
		//	System.out.println("Outter val:"+val);
			if(val>0){
				conn.commit();
				stmtacno.close();
				stmttraffic.close();
				return invoicedoc;
			}
				
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return null;
	}
	
	
	public ArrayList calculateTraffic(Connection conn,String clientid,double amt,int count) throws SQLException{
		ArrayList<String> calarray=new ArrayList<>();
		try{
		int srvcdefault=0;
		double salikrate=0.0,trafficrate=0.0;
		Statement stmt=conn.createStatement();
		String stracbook="select ser_default,per_salikrate,per_trafficharge from my_acbook where cldocno='"+clientid+"' and dtype='CRM' and status<>7";
		//System.out.println("Acbbok"+stracbook);
		ResultSet rsacbook=stmt.executeQuery(stracbook);
		while(rsacbook.next()){
			srvcdefault=rsacbook.getInt("ser_default");
			if(srvcdefault==0){
				salikrate=rsacbook.getDouble("per_salikrate");
				trafficrate=rsacbook.getDouble("per_trafficharge");
			}
		}
		
		int trafficmethod=0;
		double trafficapply=0.0;
		double trafficsrvc=0.0;
		double trafficsrvcper=0.0;
		double trafficpercalc=0.0;
		double finaltrafficsrvc=0.0;
		int trafficpermethod=0,trafficsrvmethod=0;
		double trafficamt=0.0;
		int trafficcount=0;
		if(srvcdefault==0){
			/*String strtraffic="select  COALESCE(sum(amount),0.0) trafficamt,count(*) count  from gl_traffic where amount>0 and inv_no=0 and ra_no='"+agmtno+"'"+sqltesttraffic;
//			System.out.println(strtraffic);
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			
			while(rstraffic.next()){
				trafficamt=rstraffic.getDouble("trafficamt");
				trafficcount=rstraffic.getInt("count");
			}	*/
			trafficamt=amt;
			trafficcount=count;
		}
		
		if(srvcdefault==1){
			/*String saliksrv="select if((select method from gl_config where field_nme='saliksrv')=1,(select value from gl_config where field_nme='saliksrv'),0)"+
					" saliksrv  from gl_config where field_nme='saliksrv'";
			ResultSet rssaliksrv=stmt.executeQuery(saliksrv);
			while(rssaliksrv.next()){
				salikrate=rssaliksrv.getDouble("saliksrv");
			}*/
			String strtrafficsrv="select method,value,field_nme from gl_config where field_nme in('trafficsrvapply','trafficsrvper','trafficsrv')";
			//String strtrafficsrv="select method,value from gl_config where field_nme='trafficsrvapply'";
			ResultSet rstrafficsrvapply=stmt.executeQuery(strtrafficsrv);
			while(rstrafficsrvapply.next()){
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvapply")){
					trafficmethod=rstrafficsrvapply.getInt("method");
					trafficapply=rstrafficsrvapply.getDouble("value");	
				}
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvper")){
					trafficpermethod=rstrafficsrvapply.getInt("method");
					trafficsrvcper=rstrafficsrvapply.getDouble("value");
				}
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrv")){
					trafficsrvmethod=rstrafficsrvapply.getInt("method");
					trafficsrvc=rstrafficsrvapply.getDouble("value");
				}
				
			}		
			
			
			double traffic=0.0,pertraffic=0.0,amttraffic=0.0; 
			/*String strtrafficvalues="select  COALESCE(sum(amount),0.0) trafficamt,count(*) count  from gl_traffic where amount>0 and inv_no=0 and ra_no='"+agmtno+"'"+sqltesttraffic;
//			System.out.println(" Inside Srvc Default Traffic Query"+strtrafficvalues);
			ResultSet rstrafficvalues=stmt.executeQuery(strtrafficvalues);
			while(rstrafficvalues.next()){*/
				if(trafficrate>0.0)	{
					/*traffic=trafficrate*rstrafficvalues.getDouble("trafficamt");
					trafficcount=rstrafficvalues.getInt("count");*/
					traffic=trafficrate*amt;
					trafficcount=count;
				}
				else {
						if(trafficpermethod==1){
							/*pertraffic=rstrafficvalues.getDouble("trafficamt")*(trafficsrvcper/100);
							trafficcount=rstrafficvalues.getInt("count");*/
							pertraffic=amt*(trafficsrvcper/100);
							trafficcount=count;
						}
						else if(trafficpermethod==0){
							pertraffic=0;
							}
					
						if(trafficsrvmethod==1){
							amttraffic=trafficsrvc;
							trafficcount=count;
						}
						else if(trafficsrvmethod==0){
							amttraffic=0;
						}
						if(trafficmethod==1){traffic=pertraffic;	}
						if(trafficmethod==0){traffic=amttraffic*trafficcount;	}
						if(trafficmethod==2){traffic=(trafficapply>=pertraffic)?trafficapply:pertraffic;	}
					}	
//				System.out.println("Traffic Method Check:"+trafficmethod);
				finaltrafficsrvc+=traffic;
				trafficamt+=amt;
				//System.out.println("============"+finaltrafficsrvc);
			/*}*/
			}
		else{
			finaltrafficsrvc=trafficrate*trafficcount;
		}
		calarray.add(finaltrafficsrvc+"");
		calarray.add(trafficamt+"");
		calarray.add(trafficcount+"");
		//System.out.println(calarray);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	return calarray;
	}

	
	 public JSONArray ramainSrearch(HttpSession session,String sclname,String smob,String rno,String flno,String sregno,String smra,String brc) throws SQLException {

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
    	    	
       // String brnchid=session.getAttribute("BRANCHID").toString();
        String brnchid=brc;
    	
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
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh7 = conn.createStatement ();
				String str1Sql=("select r.doc_no,r.voc_no,r.fleet_no,r.acno,r.cldocno,r.date,r.salid,r.delivery,r.chif,r.drid,r.addr,r.said, "
						+ " r.raid,round(r.okm) okm,r.odate,r.otime,r.ofuel,r.ochkid,r.ddate,r.dtime,r.tselect,r.tdocno,r.insex,r.invtype, "
						+ " r.addrchg,r.mrano,r.mrano mrnumber,r.pono,r.ofleet_no,v.reg_no,a.RefName,a.per_mob,t.gid from gl_ragmt r  "
						+ " left join gl_vehmaster v on v.fleet_no=r.fleet_no left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'  "
						+ "left join my_salm m on a.sal_id=m.doc_no left join gl_rtarif t on t.rdocno=r.doc_no where r.status=3 and "
						+ "   r.brhid='"+brnchid+"'  " +sqltest+" group by doc_no");
			//	System.out.println("=========="+str1Sql);
				ResultSet resultSet = stmtVeh7.executeQuery (str1Sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh7.close();
				conn.close();
		}
		catch(Exception e){
			
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    

	
	
	 public JSONArray lamainSrearch(HttpSession session,String sclname,String smob,String rno,String flno,String sregno,String brc) throws SQLException {

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
	    
	   	 // String brnchid=session.getAttribute("BRANCHID").toString();
	   	 String brnchid=brc;
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
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh7 = conn.createStatement ();
					String str1Sql=("select l.doc_no,l.voc_no,l.acno,CONVERT(if(if(l.perfleet=0,l.tmpfleet,l.perfleet)=0,'',if(l.perfleet=0,l.tmpfleet,l.perfleet)),char(30)) fleet_no,l.cldocno,l.date,l.salid,l.delivery, "
							+ "l.chif,l.drid,l.addr,l.outkm,l.outdate,l.outtime,l.outfuel, "
							+ "l.deldate,l.deltime,l.addrchg,a.RefName,a.per_mob,if(v.reg_no!='',v.reg_no,'')  reg_no from gl_lagmt l left join gl_vehmaster v on "
							+ " v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet) left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' "
							+ " left join my_salm m on a.sal_id=m.doc_no left join gl_ltarif t on t.rdocno=l.doc_no where   "
							+ " l.status=3 and l.brhid='"+brnchid+"'  " +sqltest+" group by doc_no");
								
		//System.out.println("=========="+str1Sql);
					ResultSet resultSet = stmtVeh7.executeQuery (str1Sql); 
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh7.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
 
	 public JSONArray searchdretails(String values) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	      
	        
	        Connection conn =null;
	        
	        try {
	        	conn = ClsConnection.getMyConnection();
	        	Statement stmtVeh = conn.createStatement();
	    
	        	String sql=("select doc_no,sal_name from my_salesman where  sal_type='"+values+"' and status=3");
	  //System.out.println("sql"+sql);
	        	ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	RESULTDATA=ClsCommon.convertToJSON(resultSet);

	       stmtVeh.close();
	       conn.close();
	  }
	  catch(Exception e){
		  e.printStackTrace();
	      conn.close();
	  }
	    return RESULTDATA;
	}
	
	  public JSONArray fleetdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				String sql="select fleet_no,flname,reg_no from gl_vehmaster where statu=3";
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
	  
	  
	  public double getGovFees(Connection conn) throws SQLException{
		  double fees=0.0;
		  try{
			  Statement stmt=conn.createStatement();
			  String strgetfees="select method,value from gl_config where field_nme='govTrafficFees'";
				int feesmethod=0;
				double feesvalue=0.0;
				ResultSet rsgetfees=stmt.executeQuery(strgetfees);
				while(rsgetfees.next()){
					feesmethod=rsgetfees.getInt("method");
					feesvalue=rsgetfees.getDouble("value");
				}
				if(feesmethod==1 && feesvalue>0){
					fees=feesvalue;
				}
		  }
		  catch(Exception e){
			  e.printStackTrace();
		  }
		  return fees;
	  }
	
}
