package com.dashboard.invoices.lease;

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
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;


public class ClsLeaseInvoiceDAO {
	ClsLeaseInvoiceCalc ClsLeaseInvoiceCalc=new ClsLeaseInvoiceCalc();
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public  JSONArray getClient(HttpSession session,String clname,String mob,String lcno,String passno,String nation,String dob) throws SQLException {
        List<ClsLeaseInvoiceBean> leaseBean = new ArrayList<ClsLeaseInvoiceBean>();
        

        Connection conn = ClsConnection.getMyConnection();
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
	     	
	    	
	    
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    	 dob.trim();
	    	if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = ClsCommon.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob='"+mob+"'";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno='"+lcno+"'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no='"+passno+"'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like'"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	        
	  
			try {
					
					Statement stmtVeh8 = conn.createStatement ();
	            	
					String clsql="select distinct a.cldocno,trim(a.RefName) RefName,a.per_mob,trim(a.address) address,a.codeno,a.acno,m.doc_no,trim(m.sal_name)"+
							" sal_name from gl_lagmt agmt left join my_acbook a on (agmt.cldocno=a.cldocno and a.dtype='CRM')left join my_salm m on"+
							" a.sal_id=m.doc_no and m.status<>7 join gl_drdetails d on d.cldocno=a.cldocno where a.brhid="+brid+"" +sqltest;
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
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    
    }
	public  JSONArray getInvoiceno(String date1,String branchvalue,String client,String status,String agmtno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		if(!status.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
        Connection conn = ClsConnection.getMyConnection();
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase(""))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
		try {
			//System.out.println("Here");
			String sqltest="";
			String sqlclient="";
				if(!(client.equalsIgnoreCase(""))){
				sqlclient+=" and agmt.cldocno="+client;
			}
			if(!(branchvalue.equalsIgnoreCase(""))){
				sqltest=" and agmt.brhid="+branchvalue;
			}
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and agmt.doc_no="+agmtno;
			}
				 
				Statement stmtDashBoard = conn.createStatement ();
            /*	String strSql="select 'Month End (M) Adv' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno)  where "
            			+ " agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" union"+
            			" select 'Month End (M)' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) where agmt.adv_chk=0 "
            			+ " and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" union"+            			
            			" select 'Period (M) Adv' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) where agmt.adv_chk=1 "
            			+ " and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" union"+
            			" select 'Period (M)' desc1,count(*) value from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno) where agmt.adv_chk=0 and "
            			+ "agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+" ";
						*/
					String strSql="select srno,desc1,sum(value) value from("+
						" select 1 srno,'Month End (M) Adv' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno)"+
						" where  agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" union all"+
						" select 2 srno,'Month End (M)' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno )"+
						" where  agmt.adv_chk=0  and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" union all"+
						" select 3 srno,'Period (M) Adv' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno )"+
						" where  agmt.adv_chk=1  and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" union all"+
						" select 4 srno,'Period (M)' desc1,count(*) value,agmt.cldocno from gl_lagmt agmt inner join gl_ltarif tarif on (agmt.doc_no=tarif.rdocno)"+
						" where   agmt.adv_chk=0 and agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0 "+sqltest+" "+sqlclient+""+
						" ) as a group by srno";	
            	// System.out.println("Inv No Sql"+strSql);
				ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtDashBoard.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
		conn.close();
		}
        return RESULTDATA;
		
    }
	public  JSONArray getLeaseInvoice(String temp,String desc1,String date1,String branchvalue,String client,String mode,String agmtno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("2")){
			return RESULTDATA;
		}
        java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase(""))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
        Connection conn = ClsConnection.getMyConnection();
		try {
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
			if(!agmtno.equalsIgnoreCase("")){
				sqlclient+=" and agmt.doc_no="+agmtno;
			}
			//System.out.println("DESC1:"+desc1);
			if(desc1.equalsIgnoreCase("Month End (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0  "+sqlbranch+"";
			
			}
			if(desc1.equalsIgnoreCase("Month End (M)")){
				sqltest=" and agmt.adv_chk=0 and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
			
			}
			
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest="and agmt.adv_chk=0 and agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
				
				Statement stmtDashBoard = conn.createStatement();
				String strtarifsum="";
				String strSql="select agmt.doc_no rano,agmt.voc_no,'Monthly' ratype,agmt.invdate fromdate,ac.cldocno,agmt.inv_type,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,brh.curid,if(inv_type=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_lagmt agmt left join"+
						" gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
						" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no left join my_brch brh on agmt.brhid=brh.doc_no where 1=1 "+sqltest+" "+sqlclient+" order by agmt.voc_no";
            	
            	System.out.println("Invoice SQL"+strSql);
             	ResultSet resultSet = stmtDashBoard.executeQuery(strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
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
	public ArrayList<String> checkFirstInvoice(int agmtno,int id) throws SQLException {
		ArrayList<String> firstinv=new ArrayList<>();
		double amount=0.0;
		int count=0;
		Connection conn=ClsConnection.getMyConnection();
		
		try {
			Statement stmt=conn.createStatement();
				String strgetamt="";
				if(id==1){
					strgetamt="select coalesce(sum(amount),0.0) amount,count(*) count from gl_lothser where invno=0 and invstatus=0 and rdocno="+agmtno;	
				}
				if(id==2){
					strgetamt="select coalesce(sum(amount),0.0) amount,count(*) count from gl_lothser where rdocno="+agmtno;
				}
				//System.out.println("Other Income Sql:"+strgetamt);
				ResultSet rsgetamt=stmt.executeQuery(strgetamt);
					if(rsgetamt.next()){
						amount=rsgetamt.getDouble("amount");
						count=rsgetamt.getInt("count");
					}
					firstinv.add(amount+"");
					firstinv.add(count+"");
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			
		}
		
		return firstinv;
	}
	
	
	public int getAdvance(int agmtno, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int advchk=0;
		try{
			Statement stmt=conn.createStatement();
			String strchk="select adv_chk from gl_lagmt where doc_no="+agmtno;
			ResultSet rschk=stmt.executeQuery(strchk);
			
			if(rschk.next()){
				advchk=rschk.getInt("adv_chk");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return advchk;
	}
	/*public double getChauffercharge(int agmtno,java.sql.Date invdate,java.sql.Date invtodate) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		double chaufchg=0.0;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
			String getdays=manualdao.getTotalDays(agmtno, invdate, invtodate,"LAG");
			String daysarray[]=getdays.split("::");
			int monthcalmethod=Integer.parseInt(daysarray[0]);
			int rentalno=Integer.parseInt(daysarray[1]);
			double days=Double.parseDouble(daysarray[2]);
			double day=Double.parseDouble(daysarray[3]);
			int month=Integer.parseInt(daysarray[4]);
			int lastday=Integer.parseInt(daysarray[5]);
			String strsql="";
			
			if(monthcalmethod==0){
				strsql="select "+(days/rentalno)+"*chaufchg chaufferchg from gl_ltarif where rdocno="+agmtno;
			}
			else if(monthcalmethod==1){
				strsql="select (("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)) chaufferchg from gl_ltarif where rdocno="+agmtno;
				
			}
			
			ResultSet rschauffer=stmt.executeQuery(strsql);
			while(rschauffer.next()){
				chaufchg=rschauffer.getDouble("chaufferchg");
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
	}*/
public  JSONArray getTotalData(String temp,String desc1,String date1,String branchvalue,String client,String mode,String agmtno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		java.sql.Date sqldate=null;
        if(!(date1.equalsIgnoreCase("NA"))){
        	sqldate=ClsCommon.changeStringtoSqlDate(date1);
        }
        Connection conn = ClsConnection.getMyConnection();
		try {
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
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=1 and agmt.invdate<='"+sqldate+"' and clstatus=0  "+sqlbranch+"";
			
			}
			if(desc1.equalsIgnoreCase("Month End (M)")){
				sqltest=" and agmt.adv_chk=0 and agmt.inv_type=1 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
			
			}
			
			if(desc1.equalsIgnoreCase("Period (M) Adv")){
				sqltest=" and agmt.adv_chk=1 and agmt.inv_type=2 and agmt.invdate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
			if(desc1.equalsIgnoreCase("Period (M)")){
				sqltest="and agmt.adv_chk=0 and agmt.inv_type=2 and agmt.invtodate<='"+sqldate+"' and clstatus=0"+
            			"  "+sqlbranch+"";
				
			}
			if(!agmtno.equalsIgnoreCase("")){
				sqlclient+=" and agmt.doc_no="+agmtno;
			}
				Statement stmtDashBoard = conn.createStatement();
				String strtarifsum="";
				String strSql="select agmt.doc_no rano,agmt.voc_no,'Monthly' ratype,agmt.invdate fromdate,ac.cldocno,agmt.inv_type,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,brh.curid,if(inv_type=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_lagmt agmt left join"+
						" gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
						" my_head head on ac.acno=head.doc_no left join my_brch brh on agmt.brhid=brh.doc_no where 1=1 "+sqltest+" "+sqlclient+" order by agmt.voc_no";
            	
            	//System.out.println("Invoice SQL"+strSql);
				double finalamt=0.0;
             	ArrayList<Double> invoicearray=new ArrayList<>();
				ArrayList<Double> salikarray=new ArrayList<>();
				ArrayList<String> newarray=new ArrayList<>();
             	ResultSet resultSet = stmtDashBoard.executeQuery(strSql);
             	while(resultSet.next()){
             		invoicearray=ClsLeaseInvoiceCalc.getInvoiceCalc(resultSet.getString("rano"), resultSet.getString("cldocno"), resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("ratype"), resultSet.getString("inv_type"));
             		salikarray=ClsCommon.getSalik(resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("cldocno"), resultSet.getString("rano"), "LAG");
             		
             		for(int i=0;i<4;i++){
                 		finalamt+=salikarray.get(i);
                 		//System.out.println("Check Final Amt Salik:"+finalamt);
                 	}
                 	for(int i=0;i<invoicearray.size();i++){
                 		finalamt+=invoicearray.get(i);
                 		//System.out.println("Check Final Amt Other:"+finalamt);
                 	}
             		newarray.add(resultSet.getString("rano")+"::"+resultSet.getString("voc_no")+"::"+resultSet.getString("ratype")+"::"+
             		resultSet.getDate("fromdate")+"::"+resultSet.getDate("todate")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("acname")+"::"+finalamt+"::"+
             		resultSet.getString("cldocno")+"::"+invoicearray.get(0)+"::"+invoicearray.get(1)+"::"+salikarray.get(0)+"::"+salikarray.get(1)+"::"+salikarray.get(2)+"::"+
             		salikarray.get(3)+"::"+resultSet.getString("datediff")+"::"+resultSet.getString("brhid")+"::"+resultSet.getString("curid")+"::"+invoicearray.get(2)+"::"+
             		resultSet.getString("inv_type")+"::"+salikarray.get(4)+"::"+salikarray.get(5)+"::"+salikarray.get(6)+"::"+salikarray.get(7)+"::"+resultSet.getString("account"));
             	
             		invoicearray=new ArrayList<>();
             		salikarray=new ArrayList<>();
             		finalamt=0.0;
             	}
             	//System.out.println(newarray);
             	//System.out.println(newarray.size());
             	RESULTDATA=convertArrayToJSON(newarray);
				//System.out.println(RESULTDATA);
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
			
		//	ArrayList<String> analysisRowArray=newarray.get(i);
			
			int length = newarray.size();
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
			obj.put("account",newarray.get(i).split("::")[24]);
			jsonArray.add(obj);
		}
		
		
		return jsonArray;
		}
	public JSONArray getAgmtData(String client,String mobile,String date,String fleetno,String regno,String docno,String branch,String id) throws SQLException
	{
		JSONArray agmtdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return agmtdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("") && date!=null){
				sqldate=ClsCommon.changeStringtoSqlDate(date);
			}
			String sqltest="";
			if(!client.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+client+"%'";
			}
			if(!mobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+mobile+"%'";
			}
			if(sqldate!=null){
				sqltest+=" and agmt.date='"+sqldate+"'";
			}
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and agmt.voc_no like '%"+docno+"%'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			String strsql="select agmt.doc_no,agmt.voc_no,ac.refname,ac.per_mob,br.branchname branch,veh.fleet_no,veh.reg_no,agmt.date from gl_lagmt agmt left join "+
			" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no) "+
			" left join my_brch br on agmt.brhid=br.doc_no where agmt.status=3 and agmt.clstatus=0"+sqltest;
			System.out.println(strsql);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			agmtdata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return agmtdata;
	}
	
}
