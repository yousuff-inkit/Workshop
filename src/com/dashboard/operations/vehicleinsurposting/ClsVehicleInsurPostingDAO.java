package com.dashboard.operations.vehicleinsurposting;

import net.sf.json.JSONArray;

import com.common.*;
import com.connection.*;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
public class ClsVehicleInsurPostingDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getPostingCountData(String id,String uptodate) throws SQLException{
		JSONArray countdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return countdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqltodate=null;
			java.sql.Date sqlfromdate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String strlastdate="select last_day(date_sub('"+sqltodate+"',interval 1 month)) lastday";
			ResultSet rslastdate=stmt.executeQuery(strlastdate);
			while(rslastdate.next()){
				sqlfromdate=rslastdate.getDate("lastday");
			}
			
			/*String str="select 'Posted' desc1,coalesce(count(*),0) value from gl_vehinsur where terminatestatus<>1 and (postdate>='"+sqlfromdate+"' and postdate<='"+sqltodate+"' and"+
			" postdate='"+sqltodate+"') or (postdate='"+sqltodate+"' and poststatus<>0) union all"+
			" select 'Not Posted' desc1,coalesce(count(*),0) value from gl_vehinsur insur left join gl_lagmt agmt on insur.agmtno=agmt.doc_no where agmt.clstatus=0 and terminatestatus<>1 and (postdate>='"+sqlfromdate+"' and postdate<='"+sqltodate+"' and"+
			" postdate<>'"+sqltodate+"') or (postdate='"+sqltodate+"' and poststatus=0) ";*/
			
/*			select 'Not Posted' desc1,coalesce(count(*),0) value from gl_vehinsur insur inner join (select max(doc_no) insurmaxdoc from gl_vehinsur group by agmtno) ins1 on
			ins1.insurmaxdoc=insur.doc_no left join gl_lagmt agmt on insur.agmtno=agmt.doc_no where agmt.clstatus=0 and insur.terminatestatus<>1
			 and ((insur.postdate>='"+sqlfromdate+"' and insur.postdate<'"+sqltodate+"' ) or (insur.postdate='"+sqltodate+"' and insur.poststatus=0))
			 and ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)*/
			
			String str="select 'Posted' desc1,coalesce(count(*),0) value from gl_vehinsur insur inner join (select max(doc_no) insurmaxdoc from "+
			" gl_vehinsur group by agmtno) ins1 on ins1.insurmaxdoc=insur.doc_no left join gl_lagmt agmt on insur.agmtno=agmt.doc_no where "+
			" agmt.clstatus=0 and insur.terminatestatus<>1 and ((insur.postdate>='"+sqlfromdate+"' and insur.postdate<'"+sqltodate+"' ) or "+
			" (insur.postdate='"+sqltodate+"' and insur.poststatus<>0)) and ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate) and "+
			" '"+sqltodate+"'=insur.postdate union all"+
			" select 'Not Posted' desc1,coalesce(count(*),0) value from gl_vehinsur insur inner join (select max(doc_no) insurmaxdoc from "+
			" gl_vehinsur group by agmtno) ins1 on ins1.insurmaxdoc=insur.doc_no left join gl_lagmt agmt on insur.agmtno=agmt.doc_no where "+
			" agmt.clstatus=0 and insur.terminatestatus<>1 and ((insur.postdate>='"+sqlfromdate+"' and insur.postdate<'"+sqltodate+"' ) or "+
			" (insur.postdate='"+sqltodate+"' and insur.poststatus=0)) and ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)";
			System.out.println(str);
			ResultSet rs=stmt.executeQuery(str);
			countdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return countdata;
	}
	
	public JSONArray getDetailsData(String uptodate,String branch,String desc,String id) throws SQLException
	{
		
		JSONArray insurdata=new JSONArray();
		if(desc==null || desc.equalsIgnoreCase("")){
			return insurdata;
		}
		if(!id.equalsIgnoreCase("1")){
			return insurdata;
		}
		System.out.println("Inside "+desc);
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqltodate=null;
			java.sql.Date sqlfromdate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String strlastdate="select last_day(date_sub('"+sqltodate+"',interval 1 month)) lastday";
			ResultSet rslastdate=stmt.executeQuery(strlastdate);
			while(rslastdate.next()){
				sqlfromdate=rslastdate.getDate("lastday");
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			if(desc.equalsIgnoreCase("Posted")){
				/*strsql="select insur.postdate,insur.doc_no insurdocno,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where insur.terminatestatus<>1 and (postdate>='"+sqlfromdate+"' and postdate<='"+sqltodate+"' and "+
				" postdate='"+sqltodate+"') or (postdate='"+sqltodate+"' and poststatus<>0)"+sqltest+" order by agmt.voc_no";*/
				strsql="select insur.postdate,insur.doc_no insurdocno,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname  from gl_vehinsur insur inner join (select max(doc_no) insurmaxdoc from  gl_vehinsur group by agmtno) ins1 on ins1.insurmaxdoc=insur.doc_no left join gl_lagmt agmt on insur.agmtno=agmt.doc_no left join my_brch br on  agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on  (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where agmt.clstatus=0 and insur.terminatestatus<>1 and ((insur.postdate='"+sqltodate+"' and insur.poststatus=1)) and ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)"+sqltest+" order by agmt.voc_no";
			}
			else if(desc.equalsIgnoreCase("Not Posted")){
				/*strsql="select insur.postdate,insur.doc_no insurdocno,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where agmt.clstatus=0 and insur.terminatestatus<>1 and (postdate>='"+sqlfromdate+"' and postdate<='"+sqltodate+"' and"+
				" postdate<>'"+sqltodate+"') or (postdate='"+sqltodate+"' and poststatus=0)"+sqltest+" order by agmt.voc_no";*/
				strsql="select insur.postdate,insur.doc_no insurdocno,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname  from gl_vehinsur insur inner join (select max(doc_no) insurmaxdoc from  gl_vehinsur group by agmtno) ins1 on ins1.insurmaxdoc=insur.doc_no left join gl_lagmt agmt on insur.agmtno=agmt.doc_no left join my_brch br on  agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on  (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where agmt.clstatus=0 and insur.terminatestatus<>1 and ((insur.postdate>='"+sqlfromdate+"' and insur.postdate<'"+sqltodate+"' ) or  (insur.postdate='"+sqltodate+"' and insur.poststatus=0)) and ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)"+sqltest+" order by agmt.voc_no";
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			insurdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return insurdata;
	}
	
	public JSONArray getDetailsExcelData(String uptodate,String branch,String desc,String id) throws SQLException
	{
		
		JSONArray insurdata=new JSONArray();
		if(desc==null || desc.equalsIgnoreCase("")){
			return insurdata;
		}
		if(!id.equalsIgnoreCase("1")){
			return insurdata;
		}
		System.out.println("Inside "+desc);
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqltodate=null;
			java.sql.Date sqlfromdate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String strlastdate="select last_day(date_sub('"+sqltodate+"',interval 1 month)) lastday";
			ResultSet rslastdate=stmt.executeQuery(strlastdate);
			while(rslastdate.next()){
				sqlfromdate=rslastdate.getDate("lastday");
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			if(desc.equalsIgnoreCase("Posted")){
				strsql="select agmt.voc_no 'Agmt No',br.branchname 'Branch',ac.refname 'Client',DATE_FORMAT(agmt.date, '%d-%m-%Y') 'Date',DATE_FORMAT(agmt.outdate, "+
				" '%d-%m-%Y') 'Out Date',date_format(case when agmt.per_name=1 then date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then "+
				" date_add(agmt.outdate,interval agmt.per_value month) else '' end, '%d-%m-%Y') 'End Date',date_format(insur.postdate,'%d-%m-%Y') 'Post Date',"+
				" veh.fleet_no 'Fleet No',veh.reg_no 'Reg No',veh.flname 'Fleet Name' from gl_vehinsur insur inner join (select max(doc_no) insurmaxdoc from  gl_vehinsur group by agmtno) ins1 on ins1.insurmaxdoc=insur.doc_no left join gl_lagmt agmt on insur.agmtno=agmt.doc_no left join my_brch br on  agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on  (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where agmt.clstatus=0 and insur.terminatestatus<>1 and ((insur.postdate='"+sqltodate+"' and insur.poststatus=1)) and ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)"+sqltest+" order by agmt.voc_no"; 
			}
			else if(desc.equalsIgnoreCase("Not Posted")){
				strsql="select agmt.voc_no 'Agmt No',br.branchname 'Branch',ac.refname 'Client',DATE_FORMAT(agmt.date, '%d-%m-%Y') 'Date',DATE_FORMAT(agmt.outdate, "+
				" '%d-%m-%Y') 'Out Date',date_format(case when agmt.per_name=1 then date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then "+
				" date_add(agmt.outdate,interval agmt.per_value month) else '' end, '%d-%m-%Y') 'End Date',date_format(insur.postdate,'%d-%m-%Y') 'Post Date',"+
				" veh.fleet_no 'Fleet No',veh.reg_no 'Reg No',veh.flname 'Fleet Name'  from gl_vehinsur insur inner join (select max(doc_no) insurmaxdoc from  gl_vehinsur group by agmtno) ins1 on ins1.insurmaxdoc=insur.doc_no left join gl_lagmt agmt on insur.agmtno=agmt.doc_no left join my_brch br on  agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on  (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where agmt.clstatus=0 and insur.terminatestatus<>1 and ((insur.postdate>='"+sqlfromdate+"' and insur.postdate<'"+sqltodate+"' ) or  (insur.postdate='"+sqltodate+"' and insur.poststatus=0)) and ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)"+sqltest+" order by agmt.voc_no"; 
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			insurdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return insurdata;
	}
	public JSONArray getCalcData(String strinsurarray,String uptodate,String expenseacno,String id) throws SQLException{
		JSONArray calcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return calcdata;
		}

		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlpostdate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqlpostdate=objcommon.changeStringtoSqlDate(uptodate);
			}
			ArrayList<String> insurarray=new ArrayList<>();
			String temparray[]=strinsurarray.split(",");
			for(int i=0;i<temparray.length;i++){
				insurarray.add(temparray[i]);
			}
			
			for(int i=0;i<insurarray.size();i++){
				String temp[]=insurarray.get(i).split("::");
				String agmtno=temp[0];
				String insurdocno=temp[1];
			
				int insurdatediff=0,datediff=0,maxtrno=0,curid=0,insuracno=0;
				double totalamount=0.0,rateperday=0.0,currentamount=0.0,currate=0.0;
				String agmtvocno="";
				String strdatediff="select datediff(if(insurtodate<'"+sqlpostdate+"',insurtodate,'"+sqlpostdate+"'),postdate) datediff,datediff(insurtodate,insurfromdate) insurdatediff,amount from gl_vehinsur where doc_no="+insurdocno;
				ResultSet rsdatediff=stmt.executeQuery(strdatediff);
				while(rsdatediff.next()){
					insurdatediff=rsdatediff.getInt("insurdatediff");
					datediff=rsdatediff.getInt("datediff");
					totalamount=rsdatediff.getDouble("amount");
				}
				rateperday=totalamount/insurdatediff;
				currentamount=rateperday*datediff;
				System.out.println("Total Date Diff: "+insurdatediff);
				System.out.println("Current Date Diff: "+datediff);
				System.out.println("Total Amount: "+totalamount);
				System.out.println("Rate Per Day: "+rateperday);
				System.out.println("Current Amount: "+currentamount);
				String strmaxtrno="select max(trno) maxtrno from my_trno";
				ResultSet rsmaxtrno=stmt.executeQuery(strmaxtrno);
				while(rsmaxtrno.next()){
					maxtrno=rsmaxtrno.getInt("maxtrno");
				}
				String strcurrate="select curid,rate from my_head where doc_no="+expenseacno;
				ResultSet rscurrate=stmt.executeQuery(strcurrate);
				while(rscurrate.next()){
					curid=rscurrate.getInt("curid");
					currate=rscurrate.getDouble("rate");
				}
				String stragmt="select voc_no from gl_lagmt where doc_no="+agmtno;
				ResultSet rsagmt=stmt.executeQuery(stragmt);
				while(rsagmt.next()){
					agmtvocno=rsagmt.getString("voc_no");
				}
				String strinsuracno="select head.doc_no from my_head head inner join my_account ac on ac.acno=head.doc_no where ac.codeno='VEHICLE INSURANCE PREPAID'";
				ResultSet rsinsuracno=stmt.executeQuery(strinsuracno);
				while(rsinsuracno.next()){
					insuracno=rsinsuracno.getInt("doc_no");
				}
				//Deleting from temperory table
				int deleteval=stmt.executeUpdate("delete from gl_vehinsurpostcalc where insurdocno="+insurdocno);
				if(deleteval<0){
					return calcdata;
				}
				String strtempjv1="insert into gl_vehinsurpostcalc(insurdocno,agmtno,acno,dramount,id,trno,curid,ldramount,desc1)values("+insurdocno+","+agmtno+","+expenseacno+","+currentamount+",1,"+maxtrno+","+curid+","+currentamount*currate+",'Insurance Posted Amount of Agmt "+agmtvocno+" of "+uptodate+"')";
				System.out.println("JV1"+strtempjv1);
				int tempjv1=stmt.executeUpdate(strtempjv1);
				if(tempjv1<=0){
					return calcdata;
				}
				String strtempjv2="insert into gl_vehinsurpostcalc(insurdocno,agmtno,acno,dramount,id,trno,curid,ldramount,desc1)values("+insurdocno+","+agmtno+","+insuracno+","+currentamount*-1+",-1,"+maxtrno+","+curid+","+(currentamount*currate)*-1+",'Insurance Posted Amount of Agmt "+agmtvocno+" of "+uptodate+"')";
				System.out.println("JV2"+strtempjv2);
				int tempjv2=stmt.executeUpdate(strtempjv2);
				if(tempjv2<=0){
					return calcdata;
				}
			}
			String stragmtno="",strinsurdocno="";
			
			for(int i=0;i<insurarray.size();i++){
				if(i==0){
					stragmtno+=insurarray.get(i).split("::")[0];
					strinsurdocno+=insurarray.get(i).split("::")[1];
				}
				else{
					stragmtno+=","+insurarray.get(i).split("::")[0];
					strinsurdocno+=","+insurarray.get(i).split("::")[1];
				}
			}
			ResultSet rsgetcalcdata=stmt.executeQuery("select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.desc1,h.account acno,	h.description acname,h.atype type from gl_vehinsurpostcalc j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.agmtno in ("+stragmtno+") and j.insurdocno in ("+strinsurdocno+")");
			System.out.println("select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.desc1,h.account acno,	h.description acname,h.atype type from gl_vehinsurpostcalc j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.agmtno in ("+stragmtno+") and j.insurdocno in ("+strinsurdocno+")");
			calcdata=objcommon.convertToJSON(rsgetcalcdata);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return calcdata;
	}
	
	public JSONArray getLoadCalcData(String strinsurarray,String uptodate,String expenseacno,String id) throws SQLException{
		JSONArray calcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return calcdata;
		}

		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlpostdate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqlpostdate=objcommon.changeStringtoSqlDate(uptodate);
			}
			ArrayList<String> insurarray=new ArrayList<>();
			String temparray[]=strinsurarray.split(",");
			for(int i=0;i<temparray.length;i++){
				insurarray.add(temparray[i]);
			}
			String stragmtno="";
			for(int i=0;i<insurarray.size();i++){
				if(i==0){
					stragmtno+=insurarray.get(i).split("::")[0];
				}
				else{
					stragmtno+=","+insurarray.get(i).split("::")[0];
				}
			}
			ResultSet rsgetcalcdata=stmt.executeQuery("select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        			" round(j.ldramount*j.id,2) baseamt,j.desc1,h.account acno,	h.description acname,h.atype type from gl_vehinsurpostcalc j left join my_head h on"+
	        			" j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId where j.agmtno in ("+stragmtno+")");
			calcdata=objcommon.convertToJSON(rsgetcalcdata);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return calcdata;
	}
	
	public JSONArray getExpenseAccount(String id) throws SQLException{
		JSONArray expensedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return expensedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select description,doc_no acno,account from my_head where gr_type=4";
			ResultSet rs=stmt.executeQuery(str);
			expensedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return expensedata;
	}

	public int insert(ArrayList<String> insurarray, String expenseacno,
			Date sqluptodate,String uptodate, HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			System.out.println("Inside DAO");
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			int errorstatus=0;
			for(int i=0;i<insurarray.size();i++){
				String temp[]=insurarray.get(i).split("::");
				String agmtno=temp[0];
				String insurdocno=temp[1];
			
				int insurdatediff=0,datediff=0,maxtrno=0,curid=0,insuracno=0,agmtbrhid=0,fleetno=0;
				double totalamount=0.0,rateperday=0.0,currentamount=0.0,currate=0.0;
				String agmtvocno="";
				String userid=session.getAttribute("USERID").toString();
				
				String stragmt="select voc_no,brhid,if(perfleet=0,tmpfleet,perfleet) fleetno from gl_lagmt where doc_no="+agmtno;
				ResultSet rsagmt=stmt.executeQuery(stragmt);
				while(rsagmt.next()){
					agmtvocno=rsagmt.getString("voc_no");
					agmtbrhid=rsagmt.getInt("brhid");
					fleetno=rsagmt.getInt("fleetno");
				}
				
				String strdatediff="select datediff('"+sqluptodate+"',postdate) datediff,datediff(insurtodate,insurfromdate) insurdatediff,amount from gl_vehinsur where doc_no="+insurdocno;
				ResultSet rsdatediff=stmt.executeQuery(strdatediff);
				while(rsdatediff.next()){
					insurdatediff=rsdatediff.getInt("insurdatediff");
					datediff=rsdatediff.getInt("datediff");
					totalamount=rsdatediff.getDouble("amount");
				}
				rateperday=totalamount/insurdatediff;
				currentamount=rateperday*datediff;
				System.out.println("Total Date Diff: "+insurdatediff);
				System.out.println("Current Date Diff: "+datediff);
				System.out.println("Total Amount: "+totalamount);
				System.out.println("Rate Per Day: "+rateperday);
				System.out.println("Current Amount: "+currentamount);
				String strmaxtrno="select max(trno)+1 maxtrno from my_trno";
				ResultSet rsmaxtrno=stmt.executeQuery(strmaxtrno);
				while(rsmaxtrno.next()){
					maxtrno=rsmaxtrno.getInt("maxtrno");
				}
				String strtrnoinsert="insert my_trno(trno,userno,trtype,brhid,edate)values("+maxtrno+","+userid+",4,"+agmtbrhid+",now())";
				System.out.println(strtrnoinsert);
				int trnoinsert=stmt.executeUpdate(strtrnoinsert);
				if(trnoinsert<=0){
					errorstatus=1;
					return 0;
				}
				String strcurrate="select curid,rate from my_head where doc_no="+expenseacno;
				ResultSet rscurrate=stmt.executeQuery(strcurrate);
				while(rscurrate.next()){
					curid=rscurrate.getInt("curid");
					currate=rscurrate.getDouble("rate");
				}
				
				String strinsuracno="select head.doc_no from my_head head inner join my_account ac on ac.acno=head.doc_no where ac.codeno='VEHICLE INSURANCE PREPAID'";
				ResultSet rsinsuracno=stmt.executeQuery(strinsuracno);
				while(rsinsuracno.next()){
					insuracno=rsinsuracno.getInt("doc_no");
				}
				
				//Inserting JV
				int srno=0;
				String note="Insurance Posted Amount of Agmt "+agmtvocno+" of "+uptodate;
				String strjv1="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values('"+maxtrno+"','"+expenseacno+"','"+currentamount+"','"+currate+"',"+
				"'"+curid+"',0,1,'"+(srno+1)+"',"+agmtbrhid+",'"+note+"',0,'"+sqluptodate+"','BVIP','"+currentamount*currate+"','"+insurdocno+"','"+note+"',"+
							 "'"+curid+"','4',1,0,3,6,"+fleetno+")";
				System.out.println(strjv1);
				int jv1=stmt.executeUpdate(strjv1);
				if(jv1<=0){
					errorstatus=1;
					return 0;
				}
				String strjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+maxtrno+"','"+insuracno+"','"+currentamount*-1+"','"+currate+"',"+
				"'"+curid+"',0,-1,'"+(srno+1)+"',"+agmtbrhid+",'"+note+"',0,'"+sqluptodate+"','BVIP','"+(currentamount*currate)*-1+"','"+insurdocno+"','"+note+"',"+
				"'"+curid+"','4',1,0,3)";
				System.out.println(strjv2);
				int jv2=stmt.executeUpdate(strjv2);
				if(jv2<=0){
					errorstatus=1;
					return 0;
				}
				String strgettranid="select tranid from my_jvtran where tr_no="+maxtrno+" and acno="+expenseacno;
				int tranid=0;
				ResultSet rstranid=stmt.executeQuery(strgettranid);
				while(rstranid.next()){
					tranid=rstranid.getInt("tranid");
				}
				String strcosttraninsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+
				" "+expenseacno+",6,"+currentamount+",1,"+tranid+",0,"+fleetno+","+maxtrno+")";
				System.out.println(strcosttraninsert);
				int costtraninsert=stmt.executeUpdate(strcosttraninsert);
				if(costtraninsert<=0){
					errorstatus=1;
					return 0;
				}
				String strupdateinsur="update gl_vehinsur set postdate='"+sqluptodate+"',poststatus=1 where doc_no="+insurdocno;
				System.out.println(strupdateinsur);
				int updateinsur=stmt.executeUpdate(strupdateinsur);
				if(updateinsur<=0){
					errorstatus=1;
					return 0;
				}
				String strinsertposting="insert into gl_vehinsurposting(agmtno,amount,trno,postdate,expenseacno,fleetno,status)values("+
				""+agmtno+","+currentamount+","+maxtrno+",'"+sqluptodate+"',"+expenseacno+","+fleetno+",3)";
				int postinginsert=stmt.executeUpdate(strinsertposting);
				if(postinginsert<=0){
					errorstatus=1;
					return 0;
				}
			}
			
			if(errorstatus==1){
				return 0;
				
			}
			else{
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
	
}
