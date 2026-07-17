
package com.dashboard.invoices.rental;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.common.ClsLeaseInvoiceCalc;
import com.common.ClsRentalInvoiceCalc;
import com.connection.ClsConnection;
import com.dashboard.vehicle.tobereleased.ClsToBeReleasedBean;

public class ClsRentalInvoiceDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

public  JSONArray getClient(String branch,String clname,String mob,String lcno,String passno,String nation,String dob) throws SQLException {
        
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
        		
        		try {
					conn=ClsConnection.getMyConnection();
        		
	   	 
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    	 dob.trim();
	    	if(!(dob.equalsIgnoreCase("")) && !(dob.equalsIgnoreCase("undefined")))
	    	{
	    	sqlStartDate = ClsCommon.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob='%"+mob+"%'";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno='%"+lcno+"%'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no='%"+passno+"%'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like'%"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	        
	  
			
					Statement stmtVeh8 = conn.createStatement ();
	            	
					String clsql= "select distinct a.cldocno,trim(a.RefName) RefName,a.per_mob,trim(a.address) address,a.codeno,a.acno,m.doc_no,trim(m.sal_name) sal_name "+
					" from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 left join gl_drdetails d on d.cldocno=a.cldocno where 1=1 and a.dtype='CRM' "+sqltest;
					//System.out.println("rental"+clsql);
					ResultSet resultSet = stmtVeh8.executeQuery(clsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
        		finally{
        			conn.close();
        		}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    
    }
	public  JSONArray getInvoiceno(String date1,String branchvalue,String client,String status) throws SQLException {
		//System.out.println("Inside Invno");
		JSONArray RESULTDATA=new JSONArray();
		if(!status.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		if(branchvalue.equalsIgnoreCase("NA") || branchvalue.equalsIgnoreCase("a")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase("NA"))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
        
       Connection conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			//System.out.println("Here");
			String sqltest="";
			String sqlclient="";
			String sqlconfig="";
			if(!(client.equalsIgnoreCase(""))){
				sqlclient=" and agmt.cldocno="+client;
			}
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqltest=" and agmt.brhid="+branchvalue;
			}
			Statement stmtconfig=conn.createStatement();
			String strconfig="select method from gl_config where field_nme='invoicecal'";
			ResultSet rsconfig=stmtconfig.executeQuery(strconfig);
			int invoiceconfigval=0;
			while(rsconfig.next()){
				invoiceconfigval=rsconfig.getInt("method");
			}
			stmtconfig.close();
			
			if(invoiceconfigval==1){
				sqlconfig=	" union all select 5 srno,'Month End (W)' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Weekly' and tarif.rstatus=5) where agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union all"+
            			" select 6 srno,'Month End (D)' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Daily' and tarif.rstatus=5) where agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+"";
			}
			
				 
				Statement stmtDashBoard = conn.createStatement ();
        /*    	String strSql="select 'Month End (M) Adv' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=1 and agmt.invtype=1 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union"+
            			" select 'Month End (M)' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union"+
            			" select 'Period (M) Adv' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=1 and agmt.invtype=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union"+
            			" select 'Period (M)' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=0 and agmt.invtype=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" "+sqlconfig;	*/
				String strSql="select srno,desc1,sum(value) value from("+
            			" select 1 srno,'Month End (M) Adv' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=1 and agmt.invtype=1 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union all"+
            			" select 2 srno,'Month End (M)' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union all"+
            			" select 3 srno,'Period (M) Adv' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=1 and agmt.invtype=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" union all"+
            			" select 4 srno,'Period (M)' desc1,count(*) value from gl_ragmt agmt inner join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and"+
            			" tarif.rentaltype='Monthly' and tarif.rstatus=5) where agmt.advchk=0 and agmt.invtype=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqltest+" "+sqlclient+" "+sqlconfig+") as a group by srno";
            //	System.out.println("Inv No Sql"+strSql);
				ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtDashBoard.close();
				conn.close();
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
	public  JSONArray getRentalInvoice(String temp,String desc1,String date1,String branchvalue,String client,String mode) throws SQLException {
//		List<ClsRentalInvoiceBean> rentalBean = new ArrayList<ClsRentalInvoiceBean>();
		JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("2")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase(""))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
        
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			//System.out.println("Here");
			//System.out.println("Branch Value"+branchvalue);
			String sqltest="";
			String sqlbranch="";
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqlbranch=" and agmt.brhid="+branchvalue;
			}
			String sqlclient="";
			if(!(client.equalsIgnoreCase(""))){
				sqlclient=" and agmt.cldocno="+client;
			}
			//System.out.println("DESC1:"+desc1);
			if(desc1.equalsIgnoreCase("Month End (M) Adv")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=1 and agmt.invtype=1 and agmt.invdate<='"+sqldate+"' and clstatus=0   "+sqlbranch+"";
			
			}
			if(desc1.equalsIgnoreCase("Month End (M)")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
			
			}
			if(desc1.equalsIgnoreCase("Month End (W)")){
				sqltest=" and tarif.rentaltype='Weekly' and agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
			if(desc1.equalsIgnoreCase("Month End (D)")){
				sqltest=" and tarif.rentaltype='Daily' and agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
				
			}
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=1 and agmt.invtype=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=0 and agmt.invtype=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
				
				Statement stmtDashBoard = conn.createStatement ();
				String strduedatecal="select method from gl_config where field_nme='duedatecal'";
				int duedatecal=0;
				ResultSet rsduedate=stmtDashBoard.executeQuery(strduedatecal);
				while(rsduedate.next()){
					duedatecal=rsduedate.getInt("method");
				}
				String strSql="select if("+duedatecal+"=1 and agmt.advchk=1 and agmt.ddate<agmt.invdate,1,0) duedatecal,agmt.doc_no rano,agmt.voc_no,tarif.rentaltype ratype,agmt.invtype,agmt.invdate fromdate,ac.cldocno,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,agmt.curid,if(invtype=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_ragmt agmt left join"+
						" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
						" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no where 1=1  "+sqltest+" "+sqlclient+" order by agmt.voc_no";
            	
				//System.out.println(strSql);
				
				/*String strSql="select agmt.doc_no rano,tarif.rentaltype ratype,agmt.invdate fromdate,ac.cldocno,ac.acno,head.description acname,agmt.invtodate"+
            			" todate,(DATEDIFF((select todate),(select fromdate))) datediff,agmt.brhid,agmt.curid from gl_ragmt agmt left join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno"+
            			" and tarif.rstatus=5) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join"+
            			" my_head head on ac.acno=head.doc_no where 1=1 "+sqltest;*/
            	//System.out.println("Invoice SQL"+strSql);
             	ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				java.sql.Date fromdate=null,todate=null;
				
				stmtDashBoard.close();
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
	public int getAdvance(int agmtno, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int advchk=0;
		try{
			Statement stmt=conn.createStatement();
			String strchk="select advchk from gl_ragmt where doc_no="+agmtno;
			ResultSet rschk=stmt.executeQuery(strchk);
			
			if(rschk.next()){
				advchk=rschk.getInt("advchk");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return advchk;
	}
	public double getChauffercharge(int agmtno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		double chaufchg=0.0;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select coalesce(chaufchg,0) chaufchg from gl_ragmt agmt left join gl_rtarif tarif on agmt.doc_no=tarif.rdocno where agmt.doc_no="+agmtno+" and tarif.rstatus=7 and agmt.clstatus=0";
			
			ResultSet rschauffer=stmt.executeQuery(str);
			while(rschauffer.next()){
				chaufchg=rschauffer.getDouble("chaufchg");
			}
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return chaufchg;
	}
	public double getAdditionalDrvCharge(int agmtno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		double adddrvchg=0.0;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select coalesce(if(addr=1,addrchg,0),0) addrchg from gl_ragmt where doc_no="+agmtno+" and addr_invno=0 and clstatus=0";
			
			ResultSet rsaddrchg=stmt.executeQuery(str);
			while(rsaddrchg.next()){
				adddrvchg=rsaddrchg.getDouble("addrchg");
			}
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return adddrvchg;
	}

	public  JSONArray getTotaldata(String temp,String desc1,String date1,String branchvalue,String client,String mode) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		ClsRentalInvoiceCalc ClsRentalInvoiceCalc=new ClsRentalInvoiceCalc();
		if(!mode.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase("NA"))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
        
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			String sqltest="";
			String sqlbranch="";
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqlbranch=" and agmt.brhid="+branchvalue;
			}
			String sqlclient="";
			if(!(client.equalsIgnoreCase(""))){
				sqlclient=" and agmt.cldocno="+client;
			}
			//System.out.println("DESC1:"+desc1);
			if(desc1.equalsIgnoreCase("Month End (M) Adv")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=1 and agmt.invtype=1 and agmt.invdate<='"+sqldate+"' and clstatus=0   "+sqlbranch+"";
			
			}
			if(desc1.equalsIgnoreCase("Month End (M)")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
			
			}
			if(desc1.equalsIgnoreCase("Month End (W)")){
				sqltest=" and tarif.rentaltype='Weekly' and agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
			if(desc1.equalsIgnoreCase("Month End (D)")){
				sqltest=" and tarif.rentaltype='Daily' and agmt.advchk=0 and agmt.invtype=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
				
			}
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=1 and agmt.invtype=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest=" and tarif.rentaltype='Monthly' and agmt.advchk=0 and agmt.invtype=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+" ";
				
			}
				
				Statement stmtDashBoard = conn.createStatement ();
				String strduedatecal="select method from gl_config where field_nme='duedatecal'";
				int duedatecal=0;
				ResultSet rsduedate=stmtDashBoard.executeQuery(strduedatecal);
				while(rsduedate.next()){
					duedatecal=rsduedate.getInt("method");
				}
				String strSql="select if("+duedatecal+"=1 and agmt.advchk=1 and agmt.ddate<agmt.invdate,1,0) duedatecal,agmt.doc_no rano,agmt.voc_no,tarif.rentaltype ratype,agmt.invtype,agmt.invdate fromdate,ac.cldocno,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,agmt.curid,if(invtype=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_ragmt agmt left join"+
						" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
						" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no where 1=1  "+sqltest+" "+sqlclient+" order by agmt.voc_no";
     
				double finalamt=0.0;
             	ArrayList<Double> invoicearray=new ArrayList<>();
				ArrayList<Double> salikarray=new ArrayList<>();
				ArrayList<String> newarray=new ArrayList<>();
             	ResultSet resultSet = stmtDashBoard.executeQuery(strSql);
             	while(resultSet.next()){
             		invoicearray=ClsRentalInvoiceCalc.getInvoiceCalc(resultSet.getString("rano"), resultSet.getString("cldocno"), resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("ratype"), resultSet.getString("invtype"));
             		salikarray=ClsCommon.getSalik(resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("cldocno"), resultSet.getString("rano"), "RAG");
             		
             		for(int i=0;i<4;i++){
                 		finalamt+=salikarray.get(i);
                 	}
                 	for(int i=0;i<invoicearray.size();i++){
                 		finalamt+=invoicearray.get(i);
                 	}
             		newarray.add(resultSet.getString("rano")+"::"+resultSet.getString("voc_no")+"::"+resultSet.getString("ratype")+"::"+
             		resultSet.getDate("fromdate")+"::"+resultSet.getDate("todate")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("acname")+"::"+finalamt+"::"+
             		resultSet.getString("cldocno")+"::"+invoicearray.get(0)+"::"+invoicearray.get(1)+"::"+salikarray.get(0)+"::"+salikarray.get(1)+"::"+salikarray.get(2)+"::"+
             		salikarray.get(3)+"::"+resultSet.getString("datediff")+"::"+resultSet.getString("brhid")+"::"+resultSet.getString("curid")+"::"+invoicearray.get(2)+"::"+
             		resultSet.getString("invtype")+"::"+salikarray.get(4)+"::"+salikarray.get(5)+"::"+salikarray.get(6)+"::"+salikarray.get(7)+"::"+resultSet.getString("account")+"::"+resultSet.getString("duedatecal"));
             	
             		invoicearray=new ArrayList<>();
             		salikarray=new ArrayList<>();
             		finalamt=0.0;
             	}
             	RESULTDATA=convertArrayToJSON(newarray);
				stmtDashBoard.close();
				conn.close();
				return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;

	}
	
	public  JSONArray convertArrayToJSON(ArrayList<String> newarray) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < newarray.size(); i++) {
			
			JSONObject obj = new JSONObject();
			

			obj.put("rano",newarray.get(i).split("::")[0]);
			obj.put("voc_no",newarray.get(i).split("::")[1]);
			obj.put("ratype",newarray.get(i).split("::")[2]);
			obj.put("fromdate",newarray.get(i).split("::")[3]);
			obj.put("todate",newarray.get(i).split("::")[4]);
			obj.put("acno",newarray.get(i).split("::")[5]);
			obj.put("acname",newarray.get(i).split("::")[6]);
			obj.put("amount",newarray.get(i).split("::")[7]);
			obj.put("cldocno",newarray.get(i).split("::")[8]);
			obj.put("rentalsum",newarray.get(i).split("::")[9]);
			obj.put("accsum",newarray.get(i).split("::")[10]);
			obj.put("salikamt",newarray.get(i).split("::")[11]);
			obj.put("trafficamt",newarray.get(i).split("::")[12]);
			obj.put("saliksrvc",newarray.get(i).split("::")[13]);
			obj.put("trafficsrvc",newarray.get(i).split("::")[14]);
			obj.put("datediff",newarray.get(i).split("::")[15]);
			obj.put("brhid",newarray.get(i).split("::")[16]);
			obj.put("curid",newarray.get(i).split("::")[17]);
			obj.put("insurchg",newarray.get(i).split("::")[18]);
			obj.put("inv_type",newarray.get(i).split("::")[19]);
			obj.put("salikcount",newarray.get(i).split("::")[20]);
			obj.put("trafficcount",newarray.get(i).split("::")[21]);
			obj.put("salamount",newarray.get(i).split("::")[22]);
			obj.put("salrate",newarray.get(i).split("::")[23]);
			obj.put("account", newarray.get(i).split("::")[24]);
			obj.put("duedatecal", newarray.get(i).split("::")[25]);

			jsonArray.add(obj);
		}
		
		
		return jsonArray;
		}
	
	
}
