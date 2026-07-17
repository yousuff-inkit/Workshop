package com.dashboard.invoices.detailinvoicelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsdetailinvoicelistDAO
{
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public  JSONArray clientDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		
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
	
	public  JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
    	
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

        
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
    
    	}
    	
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and l.brhid="+branch+"";
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
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where r.status=3 "+sqltest+" group by doc_no");
				
			
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select  l.voc_no,l.doc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where l.status=3 "+sqltest+" group by doc_no");	
					
				
					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
					
		    	}
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

	 public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss) throws SQLException {

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
        	String sqltest1="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.cldocno='"+cldocno+"'";
	    	}
	    	if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.ratype='"+rentaltype+"'";
	    	}
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.rano='"+agmtNo+"'";
	    	}
	    	if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"+clstatuss+"' )";
	    	}
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and m.brhid="+branchval+"";
	 		}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					String sql1 ="select method from gl_config where field_nme='indian' ";
            		ResultSet re = stmtVeh.executeQuery(sql1);
            		
				int company=0;	
				int chk=1;
				
				if(re.next())
	            
				{
					company=re.getInt("method");
				}
	
				if(company==1)
				{
					chk=0;
					
					sqltest1=sqltest1+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (20)),' '),char(50)) vat , ";
				}
				
				else
				{
					chk=1;
					sqltest+=" and m.status=3 ";		
					
				}
				
					
				Statement stmtindian=conn.createStatement();
				String strindian="select method from gl_config where field_nme='indian'";
				ResultSet rsindian=stmtindian.executeQuery(strindian);
				int indian=0;
				while(rsindian.next()){
					indian=rsindian.getInt("method");
				}
				String sqlvocno="";
				if(indian==1){
					sqlvocno="concat(br.branch,'/',year(m.date),'/',m.voc_no)";
				}
				else{
					sqlvocno="m.voc_no";
				}
			/*	select  m.date,m.status,convert(m.voc_no,char(25)) doc_no,h.description acname,h.account acno,m.ratype,
				if(m.ratype='RAG',r.voc_no,l.voc_no) rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(d.total,''),char(50)) amount ,
				convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent,
				convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic ,   convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19)),' '),char(50)) other , ms.sal_name, sum(j.out_amount) collection,convert(coalesce(sum(d.total),''),char(50))-sum(j.out_amount) AS balance,   if(m.ratype='RAG',r.mrano,l.manualra) mrano ,'1' chk
				from gl_invm m left join (select sum(total) total,rdocno from gl_invd group by rdocno) d on m.doc_no=d.rdocno  left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM'
				left join gl_lagmt l on l.doc_no=m.rano left join gl_ragmt r on r.doc_no=m.rano 
				left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid left join 
				(select sum(out_amount) out_amount,acno,j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no
				   where j.dtype in ('INV','INS','INT') and h.atype='AR'  group by j.tr_no) j on m.tr_no=j.tr_no and m.acno=j.acno
				    where   m.date between '2016-01-01' and  '2016-12-11'  and m.cldocno='188' and m.status=3 group by doc_no  order by m.doc_no*/
	            			String sql ="select  m.date,m.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,h.account acno,m.ratype,if(m.ratype='RAG',r.voc_no,l.voc_no) rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(d.total,''),char(50)) amount , "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
	            				+ "convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic , "+sqltest1 +" "
	            				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19,21)),' '),char(50)) other , ms.sal_name,"
	            				+ " j.out_amount collection,convert(coalesce(d.total,''),char(50))-j.out_amount AS balance,   if(m.ratype='RAG',r.mrano,l.manualra) mrano ,'"+chk+"' chk "
	            				+ " from gl_invm m left join (select sum(total) total,rdocno from gl_invd group by rdocno) d on m.doc_no=d.rdocno "
	            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
	            				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid "
	            				+ "left join (select sum(out_amount) out_amount,acno,j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no\r\n" + 
	            				"   where j.dtype in ('INV','INS','INT') and h.atype='AR'  group by j.tr_no) j on m.tr_no=j.tr_no and m.acno=j.acno  "
	            				+ " where   m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";
	         
	            		// System.out.println("mm===="+sql);
	              
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
	    

	 
	  
	 public JSONArray invoicelistExcel(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss) throws SQLException {

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
	       String sqltest1="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.cldocno='"+cldocno+"'";
	    	}
	    	if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.ratype='"+rentaltype+"'";
	    	}
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.rano='"+agmtNo+"'";
	    	}
	    	if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"+clstatuss+"' )";
	    	}
	    	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	    		sqltest+=" and m.brhid="+branchval+"";
 		}
	    	
	    	
	    	
	    
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					String sql1 ="select method from gl_config where field_nme='indian' ";
            		ResultSet re = stmtVeh.executeQuery(sql1);
            		
				int company=0;	
				
				
				if(re.next())
	            
				{
					company=re.getInt("method");
				}
	
				if(company==1)
				{
				
					sqltest1=sqltest1+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (20)),' '),char(50)) vat , ";
					
				}
				
				else
				{
				
					sqltest+=" and m.status=3 ";		
					
				}
				
				
	            
				//	Doc No ,RA No ,RA Type,  MRA NO ,From Date, To Date, Account, Account Name, Amount, Rental Sum ,Acc Sum, Salik Amt, Traffic Amt ,Insurance Charges, Other Charges
				
				Statement stmtindian=conn.createStatement();
				String strindian="select method from gl_config where field_nme='indian'";
				ResultSet rsindian=stmtindian.executeQuery(strindian);
				int indian=0;
				while(rsindian.next()){
					indian=rsindian.getInt("method");
				}
				String sqlvocno="";
				if(indian==1){
					sqlvocno="concat(br.branch,'/',year(m.date),'/',m.voc_no)";
				}
				else{
					sqlvocno="m.voc_no";
				}				
	            				
				String sql ="select  m.date Date,convert("+sqlvocno+",char(25)) 'Doc No',h.description 'Account Name',h.account Account,m.ratype 'RA Type', "
							+ " 	if(m.ratype='RAG',r.voc_no,l.voc_no) 'RA No',m.fromdate 'From Date'   ,m.todate  'To Date',convert(coalesce(d.total,''),char(50)) Amount , "
        				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) 'Rental Sum', "
        				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) 'Insurance Charges', "
        				+ "convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) Acc_Sum, "
        				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) 'Salik Amt', "
        				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) 'Traffic Amt' , "+sqltest1 +" "
        				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19,21)),' '),char(50)) other , ms.sal_name,"
        				+ " j.out_amount 'Collection',convert(coalesce(d.total,''),char(50))-j.out_amount AS 'Balance',ms.sal_name 'Salesman',  if(m.ratype='RAG',r.mrano,l.manualra) 'MRA NO' ,if(m.status='7','Cancelled','') Status"
        				+ " from gl_invm m left join (select sum(total) total,rdocno from gl_invd group by rdocno) d on m.doc_no=d.rdocno "
        				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
        				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid "
        				+ "left join (select sum(out_amount) out_amount,acno,j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no\r\n" + 
        				"   where j.dtype in ('INV','INS','INT') and h.atype='AR'  group by j.tr_no) j on m.tr_no=j.tr_no and m.acno=j.acno  "
        				+ " where   m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";
				
/*				
					String sql ="select convert("+sqlvocno+",char(25)) as 'Doc No',m.date Date,h.description 'Account Name',h.account Account,m.ratype 'RA Type', "
							+ " 	if(m.ratype='RAG',r.voc_no,l.voc_no) 'RA No',m.fromdate 'From Date'   ,m.todate  'To Date' , "
							+ " 	convert(coalesce(d.total,''),char(50)) Amount , convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),  "
							+ " ' '),char(50)) 'Rental Sum', convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50))  "
							+ " 'Insurance Charges', convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) Acc_Sum,  "
							+ "  convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) 'Salik Amt',"+sqltest1 +" "
									+ "	    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) 'Traffic Amt' ,"
							+ "    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19)),' '),char(50)) 'Other Charges' ,"
							+ " sum(j.out_amount) 'Collection',convert(coalesce(d.total,''),char(50))-sum(j.out_amount) AS 'Balance',  ms.sal_name 'Salesman',	"
							+ "     if(m.ratype='RAG',r.mrano,l.manualra) 'MRA NO' ,if(m.status='7','Cancelled','') Status  from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
							+ "     left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano "
							+ "      left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid"
							+ "  left join (select sum(out_amount) out_amount,acno,j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no\r\n" + 
							"where j.dtype in ('INV','INS','INT')  and h.atype='AR'  group by j.tr_no) j on m.tr_no=j.tr_no and m.acno=j.acno\r\n" + 
							"  where  "           				
	            				+ " m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +"  group by d.rdocno order by m.doc_no";
//*/	      System.out.println("============"+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=convertToJSON(resultSet);//  convertToJSON(resultSet);
	            		 stmtVeh.close();
	            	
	          
	            	
  				conn.close();
			}
			catch(Exception e){
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	 
		public  JSONArray convertToJSON(ResultSet resultSet)
				throws Exception {
				JSONArray jsonArray = new JSONArray();
				
				while (resultSet.next()) {
				int total_rows = resultSet.getMetaData().getColumnCount();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < total_rows; i++) {
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
				}
				jsonArray.add(obj);
				}
				//System.out.println("ConvertTOJson:   "+jsonArray);
				return jsonArray;
				}
			 
	 
	 
	 
}


