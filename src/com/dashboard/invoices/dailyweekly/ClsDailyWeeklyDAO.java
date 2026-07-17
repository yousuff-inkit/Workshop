package com.dashboard.invoices.dailyweekly;

import com.connection.*;
import com.common.*;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsDailyWeeklyDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsJournalVouchersDAO journaldao=new ClsJournalVouchersDAO();
	Connection conn=null;
	
	public JSONArray getInvoiceData(String uptodate,String branch,String mode) throws SQLException
	{
		JSONArray invdata=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return invdata;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="",strsql="",sqlbranch="";
			java.sql.Date sqldate=null;
			if(!branch.equalsIgnoreCase("")){
				sqlbranch+=" and agmt.brhid="+branch;
			}
			if(!uptodate.equalsIgnoreCase("") && uptodate!=null){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			sqltest+=" and tarif.rentaltype in ('Daily','Weekly') and coalesce(agmt.dailyinvdate,agmt.odate)<'"+sqldate+"' and clstatus=0"+
        			"  "+sqlbranch+" ";
			
			strsql="select case when datediff('"+sqldate+"',coalesce(agmt.dailyinvdate,agmt.odate))>day(last_day('"+sqldate+"')) then 1 else 0 end moredays,"+
			" datediff('"+sqldate+"',coalesce(agmt.dailyinvdate,agmt.odate)) datediff,agmt.doc_no agmtno,agmt.voc_no agmtvocno,tarif.rentaltype,agmt.invtype,"+
			" coalesce(agmt.dailyinvdate,agmt.odate) fromdate,'"+sqldate+"' todate,ac.cldocno,ac.acno clientacno,head.account "+
			" clientaccount,head.description clientacname from gl_ragmt agmt left join"+
			" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
			" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no where 1=1  "+sqltest+"order by agmt.voc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			invdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invdata;
	}
	
	
	public JSONArray getTotalData(String uptodate,String branch,String mode) throws SQLException
	{
		JSONArray invdata=new JSONArray();
		if(!mode.equalsIgnoreCase("2")){
			return invdata;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="",strsql="",sqlbranch="";
			java.sql.Date sqldate=null;
			if(!branch.equalsIgnoreCase("")){
				sqlbranch+=" and agmt.brhid="+branch;
			}
			if(!uptodate.equalsIgnoreCase("") && uptodate!=null){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			sqltest+=" and tarif.rentaltype in ('Daily','Weekly') and coalesce(agmt.dailyinvdate,agmt.odate)<'"+sqldate+"' and clstatus=0"+
        			"  "+sqlbranch+" ";
			
/*			strsql="select a.rent,(a.datediff*a.rent+a.datediff*a.insur+a.datediff*a.acc) totalamt,a.datediff*a.rent rentalamt,a.datediff*a.insur insuramt,a.datediff*a.acc accamt,a.moredays,a.agmtno,a.agmtvocno,a.rentaltype,"+
			" a.invtype,a.fromdate,a.todate,a.cldocno,a.clientacno,a.clientaccount,a.clientacname from ("+
			" select tarif.rate rent,(tarif.cdw+tarif.pai+tarif.cdw1+tarif.pai1) insur,(tarif.gps+tarif.babyseater+tarif.cooler) acc,"+
			" datediff(date_add(coalesce(agmt.dailyinvdate,agmt.odate),interval 1 month),coalesce(agmt.dailyinvdate,agmt.odate)) datediff,case when datediff('"+sqldate+"',agmt.odate)>day(last_day('"+sqldate+"')) then 1 else 0 end"+
			" moredays, agmt.doc_no agmtno,agmt.voc_no agmtvocno,tarif.rentaltype,agmt.invtype,coalesce(agmt.dailyinvdate,agmt.odate) fromdate,date_add(coalesce(agmt.dailyinvdate,agmt.odate),interval 1 month) todate,ac.cldocno,"+
			" ac.acno clientacno,head.account clientaccount,head.description clientacname from gl_ragmt agmt left join"+
			" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
			" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no where 1=1 "+sqltest+") a";*/
			
		/*	strsql="select b.rentalamt+b.insuramt+b.accamt totalamt,b.* from ( select round((a.datediff/a.monthcal)*a.rent,2) rentalamt,"+
			" round((a.datediff/a.monthcal)*a.insur,2) insuramt, round((a.datediff/a.monthcal)*a.acc,2) accamt,a.datediff,a.moredays,a.agmtno,"+
			" a.agmtvocno,a.rentaltype, a.invtype,a.fromdate,a.todate,a.cldocno, a.clientacno,a.clientaccount,a.clientacname from ( select case"+
			" when tarif.rentaltype='Daily' then 1 when tarif.rentaltype='Weekly' then 7 else 0 end  monthcal,tarif.rate rent,"+
			" (tarif.cdw+tarif.pai+tarif.cdw1+tarif.pai1) insur,(tarif.gps+tarif.babyseater+tarif.cooler) acc,"+
			" datediff('"+sqldate+"',coalesce(agmt.dailyinvdate,agmt.odate)) datediff,"+
			" case when datediff('"+sqldate+"',coalesce(agmt.dailyinvdate,agmt.odate))>day(last_day('"+sqldate+"')) then 1 else 0 end moredays,"+
			" agmt.doc_no agmtno,agmt.voc_no agmtvocno, tarif.rentaltype,agmt.invtype,coalesce(agmt.dailyinvdate,agmt.odate) fromdate,"+
			" '"+sqldate+"'  todate,ac.cldocno, ac.acno clientacno,head.account clientaccount,head.description clientacname from gl_ragmt agmt"+
			" left join gl_rtarif tarif on  (agmt.doc_no=tarif.rdocno and tarif.rstatus=7) inner join my_acbook ac on"+
			" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on  ac.acno=head.doc_no where 1=1 "+sqltest+" ) a)b";*/
			
			ArrayList<String> invcalcarray=new ArrayList<>();
			strsql="select datediff('"+sqldate+"',coalesce(agmt.dailyinvdate,agmt.odate)) datediff,case when datediff('"+sqldate+"',"+
			" coalesce(agmt.dailyinvdate,agmt.odate))>day(last_day('"+sqldate+"')) then 1 else 0 end moredays,agmt.doc_no agmtno,agmt.voc_no agmtvocno, "+
			" tarif.rentaltype,agmt.invtype,coalesce(agmt.dailyinvdate,agmt.odate) fromdate,'"+sqldate+"' todate,ac.cldocno, ac.acno clientacno,head.account "+
			" clientaccount,head.description clientacname from gl_ragmt agmt left join gl_rtarif tarif on  (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner "+
			" join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on  ac.acno=head.doc_no where 1=1 "+sqltest;
			ArrayList<String> invoicearray=new ArrayList<>();
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				invcalcarray=calculateAmount(rs.getString("agmtno"),rs.getDate("fromdate"),rs.getDate("todate"),rs.getString("rentaltype"),rs.getInt("datediff"),conn,branch);
				
				invoicearray.add(invcalcarray.get(0)+"::"+invcalcarray.get(1)+"::"+invcalcarray.get(2)+"::"+invcalcarray.get(3)+"::"+rs.getString("datediff")+"::"+rs.getString("moredays")+"::"+rs.getString("agmtno")+"::"+rs.getString("agmtvocno")+"::"+rs.getString("rentaltype")+"::"+rs.getString("invtype")+"::"+rs.getString("fromdate")+"::"+rs.getString("todate")+"::"+rs.getString("cldocno")+"::"+rs.getString("clientacno")+"::"+rs.getString("clientaccount")+"::"+rs.getString("clientacname"));
				invcalcarray=new ArrayList<>();
			}
			invdata=convertArrayToJSON(invoicearray);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invdata;
	}


	private JSONArray convertArrayToJSON(ArrayList<String> invoicearray) {
		// TODO Auto-generated method stub
		JSONArray finalarray=new JSONArray();
		
		for(int i=0;i<invoicearray.size();i++){
			
			JSONObject obj = new JSONObject();
			
			obj.put("agmtno",invoicearray.get(i).split("::")[6]);
			obj.put("agmtvocno",invoicearray.get(i).split("::")[7]);
			obj.put("rentaltype",invoicearray.get(i).split("::")[8]);
			obj.put("clientacno",invoicearray.get(i).split("::")[13]);
			obj.put("clientaccount",invoicearray.get(i).split("::")[14]);
			obj.put("clientacname",invoicearray.get(i).split("::")[15]);
			obj.put("cldocno",invoicearray.get(i).split("::")[12]);
			obj.put("totalamt",invoicearray.get(i).split("::")[0]);
			obj.put("rentalamt",invoicearray.get(i).split("::")[1]);
			obj.put("accamt",invoicearray.get(i).split("::")[2]);
			obj.put("insuramt",invoicearray.get(i).split("::")[3]);
			obj.put("moredays",invoicearray.get(i).split("::")[5]);
			obj.put("fromdate",invoicearray.get(i).split("::")[10]);
			obj.put("todate",invoicearray.get(i).split("::")[11]);

			finalarray.add(obj);
		}
		return finalarray;
	}


	private ArrayList<String> calculateAmount(String agmtno, Date fromdate,
			Date todate, String rentaltype, int datediff,Connection conn,String branch) {
		ArrayList<String> calcarray=new ArrayList<>();
		
		try{
			Statement stmt=conn.createStatement();
			int monthcal=0;
			if(rentaltype.equalsIgnoreCase("Daily")){
				monthcal=1;
			}
			else if(rentaltype.equalsIgnoreCase("Weekly")){
				monthcal=7;
			}
			
			String strsql="select round((a.tarif+a.insur+a.acc),2) total,a.tarif,a.insur,a.acc from (select round((rate*("+datediff+"/"+monthcal+")),2) tarif,round(((cdw+pai+cdw1+pai1)*("+datediff+"/"+monthcal+")),2) insur,"+
			" round(((gps+babyseater+cooler)*("+datediff+"/"+monthcal+")),2) acc from gl_rtarif where rdocno="+agmtno+" and rstatus=7 and brhid="+branch+") a";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				calcarray.add(rs.getString("total"));
				calcarray.add(rs.getString("tarif"));
				calcarray.add(rs.getString("insur"));
				calcarray.add(rs.getString("acc"));
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		return calcarray;
	}


	public int insert(ArrayList<String> agmtarray,java.sql.Date sqldate,HttpSession session, HttpServletRequest request,String periodupto) throws SQLException{
		// TODO Auto-generated method stub
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			double jvtotalamt=0.0,jvrentalamt=0.0,jvaccamt=0.0,jvinsuramt=0.0;
			ArrayList<String> journalarray=new ArrayList<>();
			ArrayList<String> calcarray=new ArrayList<>();
			int errorstatus=0;
			for(int i=0;i<agmtarray.size();i++){
				System.out.println("asdasdasd"+agmtarray.get(i));
				String agmtno=agmtarray.get(i).split("::")[0];
				String rentaltype=agmtarray.get(i).split("::")[1];
				
				String stragmtdetail="select b.rentamt+b.insuramt+b.accamt totalamt,b.* from ("+
				" select round((a.datediff/a.monthcal)*a.rent,2) rentamt,round((a.datediff/a.monthcal)*a.insur,2) insuramt,"+
				" round((a.datediff/a.monthcal)*a.acc,2) accamt,a.* from (select agmt.brhid,agmt.doc_no agmtno,coalesce(agmt.dailyinvdate,agmt.odate) fromdate,'"+sqldate+"' todate,"+
				" datediff('"+sqldate+"',coalesce(agmt.dailyinvdate,agmt.odate)) datediff,case when '"+rentaltype+"'='Daily' then 1 when '"+rentaltype+"'='Weekly' "+
				" then 7 else 0 end monthcal,tarif.rate rent,(tarif.cdw+tarif.pai+tarif.cdw1+tarif.pai1) insur,(tarif.gps+tarif.babyseater+tarif.cooler) acc from gl_ragmt "+
				" agmt left join gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=7) where agmt.doc_no="+agmtno+")a )b";
				System.out.println(stragmtdetail);
				ResultSet rsagmtdetail=stmt.executeQuery(stragmtdetail);
				while(rsagmtdetail.next()){
					jvtotalamt+=rsagmtdetail.getDouble("totalamt");
					jvrentalamt+=rsagmtdetail.getDouble("rentamt");
					jvaccamt+=rsagmtdetail.getDouble("insuramt");
					jvinsuramt+=rsagmtdetail.getDouble("accamt");
					calcarray.add(rsagmtdetail.getInt("agmtno")+"::"+rsagmtdetail.getInt("brhid")+"::"+rsagmtdetail.getDate("fromdate")+"::"+rsagmtdetail.getDate("todate")+"::"+rsagmtdetail.getDouble("totalamt")+"::"+rsagmtdetail.getDouble("rentamt")+"::"+rsagmtdetail.getDouble("insuramt")+"::"+rsagmtdetail.getDouble("accamt"));
				}
				
			}
			
			for(int i=0;i<calcarray.size();i++){
				System.out.println(calcarray.get(i));
				String temp[]=calcarray.get(i).split("::");
				String str="insert into gl_dailycalc(agmtno,brhid,fromdate,todate,totalamt,rentalamt,insuramt,accamt,status)values("+temp[0]+","+temp[1]+",'"+temp[2]+"','"+temp[3]+"',"+temp[4]+","+temp[5]+","+temp[6]+","+temp[7]+",3)";
				int insertval=stmt.executeUpdate(str);
				if(insertval<=0){
					errorstatus=1;
				}
				
				String strupdateagmt="update gl_ragmt set dailyinvdate='"+sqldate+"' where doc_no="+temp[0];
				int updateagmt=stmt.executeUpdate(strupdateagmt);
				if(updateagmt<0){
					errorstatus=1;
				}
			}
			
			int revenueacno=0;
			int curid=0;
			double currate=0.0;
			String note="JV posted for Daily Agmts on "+periodupto+"";
			String strrevenueacno="select head.doc_no,head.curid,head.rate from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='INV REVENUE ACCOUNT'";
			ResultSet rsrevenueacno=stmt.executeQuery(strrevenueacno);
			while(rsrevenueacno.next()){
				revenueacno=rsrevenueacno.getInt("doc_no");
				curid=rsrevenueacno.getInt("curid");
				currate=rsrevenueacno.getDouble("rate");
			}
			int rentalacno=0,accacno=0,insuracno=0,rentalcurid=0,acccurid=0,insurcurid=0;
			double rentalcurrate=0.0,acccurrate=0.0,insurcurrate=0.0;
			java.sql.Date sqlreversedate=null;
			String strreversedate="";
			String sqlacno="select (select head.doc_no from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=1) rentalacno,"+
			" (select head.curid from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=1) rentalcurid,"+
			" (select head.rate from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=1) rentalcurrate,"+
			" (select head.doc_no from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=2) accacno,"+
			" (select head.curid from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=2) acccurid,"+
			" (select head.rate from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=2) acccurrate,"+
			" (select head.doc_no from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=17) insuracno,"+
			" (select head.curid from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=17) insurcurid,"+
			" (select head.rate from gl_invmode inv inner join my_head head on inv.acno=head.doc_no where inv.idno=17) insurcurrate,"+
			" (select date_add('"+sqldate+"',interval 1 day)) reversedate,"+
			" (select date_format(date_add('"+sqldate+"',interval 1 day),'%d.%m.%Y')) strreversedate";
			
			ResultSet rsacno=stmt.executeQuery(sqlacno);
			
			while(rsacno.next()){
				rentalacno=rsacno.getInt("rentalacno");
				accacno=rsacno.getInt("accacno");
				insuracno=rsacno.getInt("insuracno");
				
				rentalcurid=rsacno.getInt("rentalcurid");
				acccurid=rsacno.getInt("acccurid");
				insurcurid=rsacno.getInt("insurcurid");
				
				rentalcurrate=rsacno.getDouble("rentalcurrate");
				acccurrate=rsacno.getDouble("acccurrate");
				insurcurrate=rsacno.getDouble("insurcurrate");
				strreversedate=rsacno.getString("strreversedate");
				sqlreversedate=rsacno.getDate("reversedate");				
			}
			if(jvtotalamt>0.0){
				//Against Expense Acno +ve
				journalarray.add(revenueacno+"::"+note+"::"+curid+"::"+currate+"::"+jvtotalamt+"::"+jvtotalamt*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
				
				//Against Income Acno -ve
				
				if(jvrentalamt>0){
					double amountparty=jvrentalamt*-1;
					journalarray.add(rentalacno+"::"+note+"::"+rentalcurid+"::"+rentalcurrate+"::"+amountparty+"::"+amountparty*rentalcurrate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
				}
				if(jvaccamt>0){
					double amountparty=jvaccamt*-1;
					journalarray.add(accacno+"::"+note+"::"+acccurid+"::"+acccurrate+"::"+amountparty+"::"+amountparty*acccurrate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
				}
				if(jvinsuramt>0){
					double amountparty=jvinsuramt*-1;
					journalarray.add(insuracno+"::"+note+"::"+insurcurid+"::"+insurcurrate+"::"+amountparty+"::"+amountparty*insurcurrate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
				}

			}
			
			String txtrefno=getDailyRefno(stmt);
			int journalval=journaldao.insert(sqldate, "JVT", txtrefno, note, jvtotalamt, jvtotalamt, journalarray, session, request);
			if(journalval>0){
				int intrno=Integer.parseInt(request.getAttribute("tranno").toString());
				String strupdateintrno="update gl_dailycalc set intrno="+intrno+" where todate='"+sqldate+"' and status=3";
				int updateintrno=stmt.executeUpdate(strupdateintrno);
				if(updateintrno<0){
					errorstatus=1;
				}
			}
			
			
			//Reversing Transaction
			journalarray=new ArrayList<>();
			note="JV posted for Daily Agmts on "+strreversedate+" (Reversal)";
			if(jvtotalamt>0.0){
				//Against Expense Acno -ve
				double amountparty=jvtotalamt*-1;
				journalarray.add(revenueacno+"::"+note+"::"+curid+"::"+currate+"::"+amountparty+"::"+amountparty*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
				
				//Against Income Acno +ve
				
				if(jvrentalamt>0){
					journalarray.add(rentalacno+"::"+note+"::"+rentalcurid+"::"+rentalcurrate+"::"+jvrentalamt+"::"+jvrentalamt*rentalcurrate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
				}
				if(jvaccamt>0){
					journalarray.add(accacno+"::"+note+"::"+acccurid+"::"+acccurrate+"::"+jvaccamt+"::"+jvaccamt*acccurrate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
				}
				if(jvinsuramt>0){
					journalarray.add(insuracno+"::"+note+"::"+insurcurid+"::"+insurcurrate+"::"+jvinsuramt+"::"+jvinsuramt*insurcurrate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
				}

			}
			
			int journalval2=journaldao.insert(sqlreversedate, "JVT", txtrefno, note, jvtotalamt, jvtotalamt, journalarray, session, request);
			if(journalval2>0){
				int outtrno=Integer.parseInt(request.getAttribute("tranno").toString());
				String strupdateouttrno="update gl_dailycalc set outtrno="+outtrno+" where todate='"+sqldate+"' and status=3";
				int updateouttrno=stmt.executeUpdate(strupdateouttrno);
				if(updateouttrno<0){
					errorstatus=1;
				}
			}
			
			stmt.close();
			if(errorstatus!=1){
				conn.commit();
				return 1;
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


	private String getDailyRefno(Statement stmt) {
		// TODO Auto-generated method stub
		String refno="";
		try{
			String str="select jvid from my_jvidentifyingid where menu_name='Daily-Weekly Invoices'";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				refno=rs.getString("jvid");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return refno;
	}
	
}

