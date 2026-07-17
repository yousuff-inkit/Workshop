package com.dashboard.invoices.leasealfahim;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.testng.reporters.jq.ResultsByClass;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.common.ClsLeaseInvoiceCalc;
import com.connection.ClsConnection;
import com.dashboard.invoices.lease.ClsLeaseInvoiceBean;

public class ClsLeaseInvoiceAlFahimDAO {
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
	public  JSONArray getInvoiceno(String date1,String branchvalue,String client,String status) throws SQLException {
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
	public  JSONArray getLeaseInvoice(String temp,String desc1,String date1,String branchvalue,String client,String mode) throws SQLException {
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
            	
            	//System.out.println("Invoice SQL"+strSql);
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
public  JSONArray getTotalData(String temp,String desc1,String date1,String branchvalue,String client,String mode) throws SQLException {
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
				
				Statement stmtDashBoard = conn.createStatement();
				String strtarifsum="";
				String strSql="select agmt.doc_no rano,agmt.voc_no,'Monthly' ratype,agmt.invdate fromdate,ac.cldocno,agmt.inv_type,ac.acno,head.account,head.description acname,"+
						" agmt.invtodate todate,agmt.brhid,brh.curid,if(inv_type=1,"+
						" DATEDIFF((select todate),(select fromdate)),DATEDIFF((select todate),(select fromdate))) datediff  from gl_lagmt agmt left join"+
						" gl_ltarif tarif on (agmt.doc_no=tarif.rdocno ) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
						" my_head head on ac.acno=head.doc_no left join my_brch brh on agmt.brhid=brh.doc_no where 1=1 "+sqltest+" "+sqlclient+" order by agmt.voc_no";
            	
            	System.out.println("Invoice SQL"+strSql);
				double finalamt=0.0;
             	ArrayList<Double> invoicearray=new ArrayList<>();
				ArrayList<Double> salikarray=new ArrayList<>();
				ArrayList<String> newarray=new ArrayList<>();
             	ResultSet resultSet = stmtDashBoard.executeQuery(strSql);
             	while(resultSet.next()){
             		invoicearray=ClsLeaseInvoiceCalc.getInvoiceCalc(resultSet.getString("rano"), resultSet.getString("cldocno"), resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("ratype"), resultSet.getString("inv_type"));
             		//salikarray=ClsCommon.getSalik(resultSet.getDate("fromdate"), resultSet.getDate("todate"), resultSet.getString("cldocno"), resultSet.getString("rano"), "LAG");
             		
             		/*for(int i=0;i<4;i++){
                 		finalamt+=salikarray.get(i);
                 		//System.out.println("Check Final Amt Salik:"+finalamt);
                 	}*/
                 	for(int i=0;i<invoicearray.size();i++){
                 		finalamt+=invoicearray.get(i);
                 		//System.out.println("Check Final Amt Other:"+finalamt);
                 	}
             		newarray.add(resultSet.getString("rano")+"::"+resultSet.getString("voc_no")+"::"+resultSet.getString("ratype")+"::"+
             		resultSet.getDate("fromdate")+"::"+resultSet.getDate("todate")+"::"+resultSet.getString("acno")+"::"+resultSet.getString("acname")+"::"+finalamt+"::"+
             		resultSet.getString("cldocno")+"::"+invoicearray.get(0)+"::"+invoicearray.get(1)+"::"+0+"::"+0+"::"+0+"::"+
             		0+"::"+resultSet.getString("datediff")+"::"+resultSet.getString("brhid")+"::"+resultSet.getString("curid")+"::"+invoicearray.get(2)+"::"+
             		resultSet.getString("inv_type")+"::"+0+"::"+0+"::"+0+"::"+0+"::"+resultSet.getString("account"));
             	
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
			obj.put("salikamt",0);
			obj.put("trafficamt",0);
			obj.put("saliksrvc",0);
			obj.put("trafficsrvc",0);
			obj.put("datediff",newarray.get(i).split("::")[15]);
			obj.put("brhid",newarray.get(i).split("::")[16]);
			obj.put("curid",newarray.get(i).split("::")[17]);
			obj.put("insurchg",newarray.get(i).split("::")[18]);
			obj.put("inv_type",newarray.get(i).split("::")[19]);
			obj.put("salikcount",0);
			obj.put("trafficcount",0);
			obj.put("salamount",0);
			obj.put("salrate",0);
			obj.put("account",newarray.get(i).split("::")[24]);
			jsonArray.add(obj);
		}
		
		
		return jsonArray;
		}

	public int journalInvoiceInsert(int agmtno, String dtype, Date fromdate,
			Date todate, String branchid, String currencyid, String userid,
			String cldocno, Date sqldate, double chaufchg, double rentalamt,
			double accamt, double insuramt,double totalamt,String revenueacno,String journalval,
			int rentalacno,int accacno,int insuracno,int chaufferacno,Connection conn,String type,HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			ArrayList<String> acnoarray=new ArrayList<>();
			
			if(rentalamt>0.0){
				acnoarray.add(rentalacno+"::"+rentalamt);
			}
			if(accamt>0.0){
				acnoarray.add(accacno+"::"+accamt);
			}
			if(insuramt>0.0){
				acnoarray.add(insuracno+"::"+insuramt);
			}
			if(chaufchg>0.0){
				acnoarray.add(chaufferacno+"::"+chaufchg);
			}
			/*String strgettrno="select tr_no trno from my_jvma where doc_no="+journalval+" and dtype='"+type+"' and status=3";
			and brhid="+branchid;
			int trno=0;
			ResultSet rstrno=stmt.executeQuery(strgettrno);
			while(rstrno.next()){
				trno=rstrno.getInt("trno");
			}*/
			int trno=Integer.parseInt(request.getAttribute("tranno").toString());
			String strrevamount="select dramount from my_jvtran where tr_no="+trno+" and acno="+revenueacno+" and brhid="+branchid;
			ResultSet rsrevamount=stmt.executeQuery(strrevamount);
			while(rsrevamount.next()){
				acnoarray.add(revenueacno+"::"+rsrevamount.getDouble("dramount"));
			}
			String strinsert="insert into gl_revenuem(date,rdocno,rdtype,fromdate,todate,amount,rentalamt,accamt,insuramt,status,revenueacno,cldocno,chaufamt,journalno,manual,trno)values("+
			" '"+sqldate+"',"+agmtno+",'"+dtype+"','"+fromdate+"','"+todate+"',"+totalamt+","+rentalamt+","+accamt+","+insuramt+",3,"+revenueacno+","+cldocno+","+chaufchg+","+journalval+",4,"+trno+")";
			int val=stmt.executeUpdate(strinsert);
			if(val>0){
				int costentry=0;
				int srno=0;
				ResultSet rssrno=stmt.executeQuery("select coalesce(max(sr_no)+1,1) srno from my_costtran where tr_no="+trno);
				while(rssrno.next()){
					srno=rssrno.getInt("srno");
				}
				for(int i=0;i<acnoarray.size();i++){
					String strcostentry="select costentry from gl_invmode where acno="+acnoarray.get(i).split("::")[0];
					System.out.println(strcostentry);
					ResultSet rscostentry=stmt.executeQuery(strcostentry);
					while(rscostentry.next()){
						costentry=rscostentry.getInt("costentry");
					}
					if(costentry==1){
						String strgettran="select tranid from my_jvtran where acno="+acnoarray.get(i).split("::")[0]+" and tr_no="+trno;
						 System.out.println("GetTran Query:"+strgettran);
						 ResultSet rsgettran=stmt.executeQuery(strgettran);
						 int temptranid=0;
						 while(rsgettran.next()){
							 temptranid=rsgettran.getInt("tranid");
						 }
						 int count=0;
						 ArrayList<String> costmovarray=new ArrayList<String>();
						 double temptimediff=0.0;
						 String tempcostfleet="";
						 String strtemptimediff="select (TIMESTAMPDIFF(second,'"+fromdate+" 00:00:00' ,'"+todate+" 23:59:59'))/(60*60) temptimediff";
						 ResultSet rstemptimediff=stmt.executeQuery(strtemptimediff);
						 while(rstemptimediff.next()){
							 temptimediff=rstemptimediff.getDouble("temptimediff");

						 }
						 String strcostmov="select sum(aa.hourdiff) hourdiff,aa.fleet_no from("+
								 " select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno from ("+
								 " select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout) as datetime))"+
								 " dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(coalesce(concat(din,' ',tin),'"+todate+" 23:59:59') as datetime)) din,tin"+
								 " from gl_vmove where rdocno="+agmtno+" and rdtype='"+dtype+"'  and trancode<>'DL'  and (dout between '"+fromdate+"' and '"+todate+"' or  coalesce(din,'"+todate+"')"+
								 " between '"+fromdate+"' and '"+todate+"')) kk)aa group by aa.fleet_no ";
						 System.out.println(strcostmov);
						 ResultSet rscostmov=stmt.executeQuery(strcostmov);
						 int counter=0;
						 while(rscostmov.next()){
							 costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
							 counter++;
						 }
						 for(int j=0;j<costmovarray.size();j++){
							 if(counter==1){
								 String costmov=costmovarray.get(j);
								 String costmovamt=costmov.split("::")[0];
								 String costmovfleet=costmov.split("::")[1];
								 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+acnoarray.get(i).split("::")[0]+"'"+
										 ",6,"+acnoarray.get(i).split("::")[1]+","+srno+","+temptranid+",0,"+costmovfleet+","+trno+")";
								 System.out.println("Counter 1: "+strcostinsert);
								 srno++;
								 int costinsertval=stmt.executeUpdate(strcostinsert);
								 if(costinsertval<0){
									 System.out.println("Cost Insert Error");
									 return 0;
								 }
							 }
							 else if(counter>1){
								 String costmov=costmovarray.get(j);
								 String costmovamt=costmov.split("::")[0];
								 String costmovfleet=costmov.split("::")[1];
								 double amt=(Double.parseDouble(costmovamt)/temptimediff)*Double.parseDouble(acnoarray.get(i).split("::")[1]);
								 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+acnoarray.get(i).split("::")[0]+"'"+
										 ",6,"+amt+","+srno+","+temptranid+",0,"+costmovfleet+","+trno+")";
								 System.out.println("Counter>1: "+strcostinsert);
								 srno++;
								 int costinsertval=stmt.executeUpdate(strcostinsert);
								 if(costinsertval<0){
									 System.out.println("Cost Insert Error2");
									 return 0;
								 }
							 }
						 }
					}
					System.out.println("select * from my_jvtran jv left join my_costtran cost on (jv.tranid=cost.tranid and jv.tr_no=cost.tr_no) where cost.tr_no="+trno);
					String strcostupdate="update my_jvtran jv left join my_costtran cost on (jv.tranid=cost.tranid and jv.tr_no=cost.tr_no) set jv.costcode=cost.jobid,jv.costtype=cost.costtype where cost.tr_no="+trno;
					int costupdate=stmt.executeUpdate(strcostupdate);
					if(costupdate<0){
						return 0;
					}
					String strmonthcal="select (select method from gl_config where field_nme='lesmonthlycal') method,(select value from gl_config where "+
					" field_nme='lesmonthlycal') value,(select inv_type from gl_lagmt where doc_no="+agmtno+") invtype";
					ResultSet rsmonthcal=stmt.executeQuery(strmonthcal);
					int monthcalmethod=0,monthcalvalue=0,invtype=0;
					while(rsmonthcal.next()){
						monthcalmethod=rsmonthcal.getInt("method");
						monthcalvalue=rsmonthcal.getInt("value");
						invtype=rsmonthcal.getInt("invtype");
					}
					String strupdatetodate="";
					if(monthcalmethod==1){
						strupdatetodate="select LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
					}
					else{
						strupdatetodate="select DATE_ADD('"+todate+"',INTERVAL "+monthcalvalue+" day))";
					}
					String strupdateagmt="update gl_lagmt set invdate='"+todate+"',invtodate=("+strupdatetodate+") where doc_no="+agmtno;
					System.out.println(strupdateagmt);
					int updateval=stmt.executeUpdate(strupdateagmt);
					if(updateval>=0){
						
						return val;
					}
					
				}
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			
		}
		return 0;
	}
	public String getRevenueJVID() throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		String refno="";
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strrefno="select jvid from my_jvidentifyingid where menu_name='Lease Revenue Posting'";
			ResultSet rsrefno=stmt.executeQuery(strrefno);
			while(rsrefno.next()){
				refno=rsrefno.getString("jvid");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return refno;
	}
	public String getRevenueAcno() throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		String acno="";
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strrefno="select acno from my_account where codeno='REVENUE'";
			ResultSet rsrefno=stmt.executeQuery(strrefno);
			while(rsrefno.next()){
				acno=rsrefno.getString("acno");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return acno;
	}
	public double getCurrencyRate(HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		double rate=0.0;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strrefno="select round(c_rate,2) rate from my_curr where doc_no="+session.getAttribute("CURRENCYID").toString();
			ResultSet rsrefno=stmt.executeQuery(strrefno);
			while(rsrefno.next()){
				rate=rsrefno.getDouble("rate");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return rate;
	}
	public int getJVCostCodeUpdate(int journalno,String dtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			String strgettrno="select tr_no from my_jvma where dtype='"+dtype+"' and doc_no="+journalno;
			ResultSet rsgettrno=stmt.executeQuery(strgettrno);
			int trno=0;
			while(rsgettrno.next()){
				trno=rsgettrno.getInt("tr_no");
			}
			
			int updateval=stmt.executeUpdate("update my_jvtran jv inner join my_head head on (jv.acno=head.doc_no and head.gr_type in (4,5)) set costtype=7,costcode=9999 where jv.tr_no="+trno);
			if(updateval>0){
				conn.commit();
				return 1;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
}
