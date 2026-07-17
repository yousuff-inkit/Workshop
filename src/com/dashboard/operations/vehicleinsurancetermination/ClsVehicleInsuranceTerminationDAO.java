package com.dashboard.operations.vehicleinsurancetermination;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsVehicleInsuranceTerminationDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
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
	
	public JSONArray getReverseAccount(String id) throws SQLException{
		JSONArray reversedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return reversedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select description,doc_no acno,account from my_head where atype in('GL','AR')";
			ResultSet rs=stmt.executeQuery(str);
			reversedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return reversedata;
	}
	

	public JSONArray getDetailsData(String uptodate,String branch,String id) throws SQLException
	{
		
		JSONArray insurdata=new JSONArray();
		
		if(!id.equalsIgnoreCase("1")){
			return insurdata;
		}
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
				strsql="select insur.postdate,insur.doc_no insurdocno,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where insur.terminatestatus<>1 and insur.postdate<='"+sqltodate+"'"+sqltest; 
			
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

	public int insert(ArrayList<String> insurarray, String expenseacno,
			String reverseacno, Date sqluptodate, String uptodate,
			HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int errorstatus=0;
			for(int i=0;i<insurarray.size();i++){
				String temp[]=insurarray.get(i).split("::");
				String agmtno=temp[0];
				String insurdocno=temp[1];
				
				double totalamount=0.0,currentamount=0.0,currate=0.0;
				int postdatediff=0,termdatediff=0,insurdatediff=0,maxtrno=0,curid=0,insuracno=0;
				String strdatediff="select datediff(insurtodate,insurfromdate) insurdatediff,datediff('"+sqluptodate+"',postdate) postdatediff,datediff(insurtodate,'"+sqluptodate+"') termdatediff,amount from gl_vehinsur where doc_no="+insurdocno;
				ResultSet rsdatediff=stmt.executeQuery(strdatediff);
				while(rsdatediff.next()){
					insurdatediff=rsdatediff.getInt("insurdatediff");
					postdatediff=rsdatediff.getInt("postdatediff");
					termdatediff=rsdatediff.getInt("termdatediff");
					totalamount=rsdatediff.getDouble("amount");
				}
				int agmtbrhid=0,fleetno=0;
				String agmtvocno="";
				String userid=session.getAttribute("USERID").toString();
				String stragmt="select voc_no,brhid,if(perfleet=0,tmpfleet,perfleet) fleetno from gl_lagmt where doc_no="+agmtno;
				ResultSet rsagmt=stmt.executeQuery(stragmt);
				while(rsagmt.next()){
					agmtvocno=rsagmt.getString("voc_no");
					agmtbrhid=rsagmt.getInt("brhid");
					fleetno=rsagmt.getInt("fleetno");
				}
				
				
				if(postdatediff>0){
					double rateperday=totalamount/insurdatediff;
					currentamount=rateperday*postdatediff;
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
					int srno=1;
					String note="Insurance Posted Amount of Agmt "+agmtvocno+" of "+uptodate;
					String strjv1="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values('"+maxtrno+"','"+expenseacno+"','"+currentamount+"','"+currate+"',"+
					"'"+curid+"',0,1,'"+(srno)+"',"+agmtbrhid+",'"+note+"',0,'"+sqluptodate+"','BVIP','"+currentamount*currate+"','"+insurdocno+"','"+note+"',"+
								 "'"+curid+"','4',1,0,3,6,"+fleetno+")";
					System.out.println(strjv1);
					int jv1=stmt.executeUpdate(strjv1);
					if(jv1<=0){
						errorstatus=1;
						return 0;
					}
					srno++;
					String strjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+maxtrno+"','"+insuracno+"','"+currentamount*-1+"','"+currate+"',"+
					"'"+curid+"',0,-1,'"+(srno)+"',"+agmtbrhid+",'"+note+"',0,'"+sqluptodate+"','BVIP','"+(currentamount*currate)*-1+"','"+insurdocno+"','"+note+"',"+
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
				}
				if(termdatediff>0){
					double rateperday=totalamount/insurdatediff;
					currentamount=rateperday*termdatediff;
					int expensecurid=0,reversecurid=0;
					double expensecurrate=0.0,reversecurrate=0.0;
					/* String strmaxtrno="select max(trno)+1 maxtrno from my_trno";
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
				*/	
					String strexpensecurrate="select curid,rate from my_head where doc_no="+expenseacno;
					ResultSet rsexpensecurrate=stmt.executeQuery(strexpensecurrate);
					while(rsexpensecurrate.next()){
						expensecurid=rsexpensecurrate.getInt("curid");
						expensecurrate=rsexpensecurrate.getDouble("rate");
					}
					String strreversecurrate="select curid,rate from my_head where doc_no="+reverseacno;
					ResultSet rsreversecurrate=stmt.executeQuery(strreversecurrate);
					while(rsreversecurrate.next()){
						reversecurid=rsreversecurrate.getInt("curid");
						reversecurrate=rsreversecurrate.getDouble("rate");
					}
					
					//Inserting JV
					int srno=1;
					String note="Insurance Terminated Amount of Agmt "+agmtvocno+" of "+uptodate;
					String strjv1="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status)values('"+maxtrno+"','"+reverseacno+"','"+currentamount+"','"+reversecurrate+"',"+
					"'"+reversecurid+"',0,1,'"+(srno)+"',"+agmtbrhid+",'"+note+"',0,'"+sqluptodate+"','BVIT','"+currentamount*reversecurrate+"','"+insurdocno+"','"+note+"',"+
								 "'"+reversecurid+"','4',1,0,3)";
					System.out.println(strjv1);
					int jv1=stmt.executeUpdate(strjv1);
					if(jv1<=0){
						errorstatus=1;
						return 0;
					}
					srno++;
					String strjv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
					"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,costtype,costcode)values('"+maxtrno+"','"+insuracno+"','"+currentamount*-1+"','"+currate+"',"+
					"'"+curid+"',0,-1,'"+(srno)+"',"+agmtbrhid+",'"+note+"',0,'"+sqluptodate+"','BVIT','"+(currentamount*currate)*-1+"','"+insurdocno+"','"+note+"',"+
					"'"+curid+"','4',1,0,3,6,"+fleetno+")";
					System.out.println(strjv2);
					int jv2=stmt.executeUpdate(strjv2);
					if(jv2<=0){
						errorstatus=1;
						return 0;
					}
					String strgettranid="select tranid from my_jvtran where tr_no="+maxtrno+" and acno="+reverseacno;
					int tranid=0;
					ResultSet rstranid=stmt.executeQuery(strgettranid);
					while(rstranid.next()){
						tranid=rstranid.getInt("tranid");
					}
					String strcosttraninsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+
					" "+reverseacno+",6,"+currentamount+",1,"+tranid+",0,"+fleetno+","+maxtrno+")";
					System.out.println(strcosttraninsert);
					int costtraninsert=stmt.executeUpdate(strcosttraninsert);
					if(costtraninsert<=0){
						errorstatus=1;
						return 0;
					}
					String strupdateinsur="update gl_vehinsur set terminatestatus=1 where doc_no="+insurdocno;
					System.out.println(strupdateinsur);
					int updateinsur=stmt.executeUpdate(strupdateinsur);
					if(updateinsur<=0){
						errorstatus=1;
						return 0;
					}
				}
			}
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
	
	
	public JSONArray getCalcData(String strinsurarray,String uptodate,String expenseacno,String reverseacno,String id) throws SQLException{
		JSONArray calcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return calcdata;
		}

		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqluptodate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			ArrayList<String> insurarray=new ArrayList<>();
			String temparray[]=strinsurarray.split(",");
			for(int i=0;i<temparray.length;i++){
				insurarray.add(temparray[i]);
			}
			String deletedocno="";
			for(int i=0;i<insurarray.size();i++){
				String temp[]=insurarray.get(i).split("::");
				if(i==0){
					deletedocno+=insurarray.get(i).split("::")[1];
				}
				else{
					deletedocno+=","+insurarray.get(i).split("::")[1];
				}
			}
			int deleteval=stmt.executeUpdate("delete from gl_vehinsurtermcalc where insurdocno in ("+deletedocno+")");
			if(deleteval<0){
				return calcdata;
			}
			for(int i=0;i<insurarray.size();i++){
				String temp[]=insurarray.get(i).split("::");
				String agmtno=temp[0];
				String insurdocno=temp[1];
				

				double totalamount=0.0,currentamount=0.0,currate=0.0;
				int postdatediff=0,termdatediff=0,insurdatediff=0,maxtrno=0,curid=0,insuracno=0;
				String strdatediff="select datediff(insurtodate,insurfromdate) insurdatediff,datediff('"+sqluptodate+"',postdate) postdatediff,datediff(insurtodate,'"+sqluptodate+"') termdatediff,amount from gl_vehinsur where doc_no="+insurdocno;
				System.out.println(strdatediff);
				ResultSet rsdatediff=stmt.executeQuery(strdatediff);
				while(rsdatediff.next()){
					insurdatediff=rsdatediff.getInt("insurdatediff");
					postdatediff=rsdatediff.getInt("postdatediff");
					termdatediff=rsdatediff.getInt("termdatediff");
					totalamount=rsdatediff.getDouble("amount");
				}
				int agmtbrhid=0,fleetno=0;
				String agmtvocno="";
				String stragmt="select voc_no,brhid,if(perfleet=0,tmpfleet,perfleet) fleetno from gl_lagmt where doc_no="+agmtno;
				ResultSet rsagmt=stmt.executeQuery(stragmt);
				while(rsagmt.next()){
					agmtvocno=rsagmt.getString("voc_no");
					agmtbrhid=rsagmt.getInt("brhid");
					fleetno=rsagmt.getInt("fleetno");
				}
				
				if(postdatediff>0){
					double rateperday=totalamount/insurdatediff;
					currentamount=rateperday*postdatediff;
					String strmaxtrno="select max(trno)+1 maxtrno from my_trno";
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
					String strinsuracno="select head.doc_no from my_head head inner join my_account ac on ac.acno=head.doc_no where ac.codeno='VEHICLE INSURANCE PREPAID'";
					ResultSet rsinsuracno=stmt.executeQuery(strinsuracno);
					while(rsinsuracno.next()){
						insuracno=rsinsuracno.getInt("doc_no");
					}
					
					
					String strtempjv1="insert into gl_vehinsurtermcalc(insurdocno,agmtno,acno,dramount,id,trno,curid,ldramount,desc1,amounttype)values("+insurdocno+","+agmtno+","+expenseacno+","+currentamount+",1,"+maxtrno+","+curid+","+currentamount*currate+",'Insurance Posted Amount of Agmt "+agmtvocno+" of "+uptodate+"',1)";
					System.out.println("JV1"+strtempjv1);
					int tempjv1=stmt.executeUpdate(strtempjv1);
					if(tempjv1<=0){
						return calcdata;
					}
					String strtempjv2="insert into gl_vehinsurtermcalc(insurdocno,agmtno,acno,dramount,id,trno,curid,ldramount,desc1,amounttype)values("+insurdocno+","+agmtno+","+insuracno+","+currentamount*-1+",-1,"+maxtrno+","+curid+","+(currentamount*currate)*-1+",'Insurance Posted Amount of Agmt "+agmtvocno+" of "+uptodate+"',1)";
					System.out.println("JV2"+strtempjv2);
					int tempjv2=stmt.executeUpdate(strtempjv2);
					if(tempjv2<=0){
						return calcdata;
					}
				}
				
				if(termdatediff>0){
					double rateperday=totalamount/insurdatediff;
					currentamount=rateperday*termdatediff;
					int expensecurid=0,reversecurid=0;
					double expensecurrate=0.0,reversecurrate=0.0;
					String strmaxtrno="select max(trno)+1 maxtrno from my_trno";
					ResultSet rsmaxtrno=stmt.executeQuery(strmaxtrno);
					while(rsmaxtrno.next()){
						maxtrno=rsmaxtrno.getInt("maxtrno");
					}
					
					String strexpensecurrate="select curid,rate from my_head where doc_no="+expenseacno;
					ResultSet rsexpensecurrate=stmt.executeQuery(strexpensecurrate);
					while(rsexpensecurrate.next()){
						expensecurid=rsexpensecurrate.getInt("curid");
						expensecurrate=rsexpensecurrate.getDouble("rate");
					}
					String strreversecurrate="select curid,rate from my_head where doc_no="+reverseacno;
					ResultSet rsreversecurrate=stmt.executeQuery(strreversecurrate);
					while(rsreversecurrate.next()){
						reversecurid=rsreversecurrate.getInt("curid");
						reversecurrate=rsreversecurrate.getDouble("rate");
					}
					
					String strtempjv1="insert into gl_vehinsurtermcalc(insurdocno,agmtno,acno,dramount,id,trno,curid,ldramount,desc1,amounttype)values("+insurdocno+","+agmtno+","+reverseacno+","+currentamount+",1,"+maxtrno+","+reversecurid+","+currentamount*reversecurrate+",'Insurance Terminated Amount of Agmt "+agmtvocno+" of "+uptodate+"',2)";
					System.out.println("JV1"+strtempjv1);
					int tempjv1=stmt.executeUpdate(strtempjv1);
					if(tempjv1<=0){
						return calcdata;
					}
					String strtempjv2="insert into gl_vehinsurtermcalc(insurdocno,agmtno,acno,dramount,id,trno,curid,ldramount,desc1,amounttype)values("+insurdocno+","+agmtno+","+insuracno+","+currentamount*-1+",-1,"+maxtrno+","+curid+","+(currentamount*currate)*-1+",'Insurance Terminated Amount of Agmt "+agmtvocno+" of "+uptodate+"',2)";
					System.out.println("JV2"+strtempjv2);
					int tempjv2=stmt.executeUpdate(strtempjv2);
					if(tempjv2<=0){
						return calcdata;
					}
				}
				
				//Deleting from temperory table
				
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
	        			" round(j.ldramount*j.id,2) baseamt,j.desc1,h.account acno,	h.description acname,h.atype type,j.amounttype from gl_vehinsurtermcalc j left join my_head h on"+
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
}
