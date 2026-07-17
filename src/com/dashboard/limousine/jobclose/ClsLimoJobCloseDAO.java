package com.dashboard.limousine.jobclose;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.converters.SqlTimeConverter;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.google.common.util.concurrent.Service.State;

import net.sf.json.JSONArray;

public class ClsLimoJobCloseDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getJobData(String fromdate,String todate,String bookdocno,String branch,String id) throws SQLException{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="",sqltransferbranch="",sqlhoursbranch="";
		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
			/*sqltest+=" and book.brhid="+branch;*/
			sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
			sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
		}
		if(sqlfromdate!=null){
			sqltest+=" and book.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and book.date<='"+sqltodate+"'";
		}
		
		if(!bookdocno.equalsIgnoreCase("")){
			sqltest+=" and book.doc_no in ("+bookdocno+")";
		}
		/*String strsql="select * from (select tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,"+
		" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
		" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
		" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
		" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
		" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
		" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+sqltest+sqltransferbranch+" union all"+
		" select hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,"+
		" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
		" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
		" hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
		" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
		" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and hours.masterstatus=3 "+
		" "+sqltest+sqlhoursbranch+")a order by a.doc_no";*/
		String strsql="select * from (select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') "+
		" status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no, book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,"+
		" tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate, tran.pickuptime,pickup.location"+
		" pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,model.vtype model,tran.nos from "+
		" gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and "+
		" tran.doc_no=srvc.typedocno) left join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join"+
		" gl_limoextrasrvctarifd vip on (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on "+
		" (srvc.boquetarifdocno=boque.doc_no and srvc.airportid=boque.airportid) left join my_acbook ac on  (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
		" gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on  (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on "+
		" (tran.dropfflocid=dropoff.doc_no) left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no  "+
		" left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on  "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+
		" "+sqltest+sqltransferbranch+" union all"+
		" select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname "+
		" transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno, book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,"+
		" hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate, hours.pickuptime,pickup.location pickuplocation,"+
		" hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model, hours.nos from gl_limobookm book left join "+
		" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and hours.doc_no=srvc.typedocno) left "+
		" join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join gl_limoextrasrvctarifd vip on"+
		" (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on (srvc.boquetarifdocno=boque.doc_no and "+
		" srvc.airportid=boque.airportid) left join my_acbook ac on (book.cldocno=ac.cldocno and  ac.dtype='CRM') left join gl_limoguest guest on "+
		" (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no "+
		" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no "+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and "+
		" hours.masterstatus=3 "+sqltest+sqlhoursbranch+" )a order by a.doc_no";
		System.out.println(strsql);
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(strsql);
		jobdata=objcommon.convertToJSON(rs);
		stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}
	
	public JSONArray getAmountData(String jobdocno,String bookdocno,String id) throws SQLException{
		JSONArray amountdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return amountdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(!jobdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.jobdocno in ("+jobdocno+")";
			}
			if(!bookdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.bookdocno in ("+bookdocno+")";
			}
			String str="select case when calc.jobtype='T' then tran.docname when calc.jobtype='L' then hours.docname else '' end jobname,calc.jobdocno,calc.bookdocno,calc.idno,calc.qty,calc.rate,calc.amount total,inv.description,inv.acno from gl_limojobclosecalc calc left join"+
			" gl_invmode inv on calc.idno=inv.idno left join gl_limobooktransfer tran on (calc.jobtype='T' and calc.jobdocno=tran.doc_no and calc.bookdocno=tran.bookdocno) "+
			" left join gl_limobookhours hours on (calc.jobtype='L' and calc.jobdocno=hours.doc_no and calc.bookdocno=hours.bookdocno) where 1=1"+sqltest;
			System.out.println("Amount Query: "+str);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(str);
			amountdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return amountdata;
	}
	public JSONArray getAmountData2(String jobdocno,String bookdocno,String id) throws SQLException{
		JSONArray amountdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return amountdata;
		}
		System.out.println("Jobdocno: "+jobdocno);
		System.out.println("Bookdocno: "+bookdocno);
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(!jobdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.jobdocno in ("+jobdocno+")";
			}
			if(!bookdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.bookdocno in ("+bookdocno+")";
			}
			/*String str="select case when calc.jobtype='T' then tran.docname when calc.jobtype='L' then hours.docname else '' end jobname,calc.jobdocno,calc.bookdocno,calc.idno,calc.qty,calc.rate,calc.amount total,inv.description,inv.acno from gl_limojobclosecalc calc left join"+
			" gl_invmode inv on calc.idno=inv.idno left join gl_limobooktransfer tran on (calc.jobtype='T' and calc.jobdocno=tran.doc_no and calc.bookdocno=tran.bookdocno) "+
			" left join gl_limobookhours hours on (calc.jobtype='L' and calc.jobdocno=hours.doc_no and calc.bookdocno=hours.bookdocno) where 1=1"+sqltest;*/
			String str="select guest.guest,calc.bookdocno, calc.jobdocno, calc.jobtype, calc.jobname, calc.guestno, calc.total, calc.tarif, calc.nighttarif,"+
			" calc.exkmchg excesskmchg, calc.exhrchg excesshrchg, calc.exnighthrchg excessnighthrchg, calc.fuelchg, calc.parkingchg, calc.otherchg, calc.greetchg, calc.vipchg,calc.boquechg from "+
			" gl_limojobclosecalc calc left join gl_limoguest guest on (calc.guestno=guest.doc_no) where  1=1"+sqltest;
			System.out.println("Amount Query: "+str);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(str);
			amountdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return amountdata;
	}
	public JSONArray getBookSearchData(String branch,String searchdate,String searchdocno,String searchclient,String searchguest,String id) throws SQLException{
		JSONArray bookdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return bookdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!searchdate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(searchdate);
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and book.brhid="+branch;
			}
			if(sqldate!=null){
				sqltest+=" and book.date='"+sqldate+"'";
			}
			if(!searchdocno.equalsIgnoreCase("")){
				sqltest+=" and book.doc_no like '%"+searchdocno+"%'";
			}
			if(!searchclient.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+searchclient+"%'";
			}
			if(!searchguest.equalsIgnoreCase("")){
				sqltest+=" and guest.guest like '%"+searchguest+"%'";
			}
			String strsql="select book.doc_no bookdocno,book.date,ac.refname client,guest.guest from gl_limobookm book left join my_acbook ac on"+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on book.guestno=guest.doc_no where book.status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			bookdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return bookdata;
	}

	public int insert(ArrayList<String> calcarray, String mode,
			String cmbbranch, HttpSession session)throws SQLException {
		// TODO Auto-generated method stub
		int val=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			int status=0;
			int maxdoc=0;
			String strmaxdoc="select coalesce(max(doc_no)+1,1) maxdoc from gl_limojobclose";
			Statement stmt=conn.createStatement();
			ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
			while(rsmaxdoc.next()){
				maxdoc=rsmaxdoc.getInt("maxdoc");
			}
			for(int i=0;i<calcarray.size();i++){
				String temp[]=calcarray.get(i).split("::");			
				CallableStatement stmtJobclose = conn.prepareCall("{call limoJobCloseDML(?,?,?,?,?,?,?,?,?,?)}");
				stmtJobclose.setString(1, temp[0]);
				stmtJobclose.setString(2, temp[1]);
				stmtJobclose.setString(3, temp[2]);
				stmtJobclose.setString(4, temp[3]);
				stmtJobclose.setString(5, mode);
				stmtJobclose.setString(6, "BLJC");
				stmtJobclose.setString(7, cmbbranch);
				stmtJobclose.setString(8, session.getAttribute("USERID").toString());
				stmtJobclose.setString(9, session.getAttribute("COMPANYID").toString());
				stmtJobclose.setInt(10, maxdoc);
				stmtJobclose.executeQuery();
				//int docno=stmtJobclose.getInt("docNo");
				if(maxdoc<=0){
					status=1;
					break;
				}
			}
			if(status!=1){
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
		return val;
	}
public JSONArray exceljobcloseData(String fromdate,String todate,String bookdocno,String branch,String id) throws SQLException{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="",sqltransferbranch="",sqlhoursbranch="";
		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
			/*sqltest+=" and book.brhid="+branch;*/
			sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
			sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
		}
		if(sqlfromdate!=null){
			sqltest+=" and book.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and book.date<='"+sqltodate+"'";
		}
		
		if(!bookdocno.equalsIgnoreCase("")){
			sqltest+=" and book.doc_no in ("+bookdocno+")";
		}
		/*String strsql="select * from (select tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,"+
		" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
		" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
		" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
		" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
		" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
		" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+sqltest+sqltransferbranch+" union all"+
		" select hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,"+
		" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
		" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
		" hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
		" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
		" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and hours.masterstatus=3 "+
		" "+sqltest+sqlhoursbranch+")a order by a.doc_no";*/
		String strsql="select * from (select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') "+
		" status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no, book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,"+
		" tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate, tran.pickuptime,pickup.location"+
		" pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,model.vtype model,tran.nos from "+
		" gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and "+
		" tran.doc_no=srvc.typedocno) left join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join"+
		" gl_limoextrasrvctarifd vip on (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on "+
		" (srvc.boquetarifdocno=boque.doc_no and srvc.airportid=boque.airportid) left join my_acbook ac on  (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
		" gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on  (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on "+
		" (tran.dropfflocid=dropoff.doc_no) left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no  "+
		" left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on  "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+
		" "+sqltest+sqltransferbranch+" union all"+
		" select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname "+
		" transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno, book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,"+
		" hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate, hours.pickuptime,pickup.location pickuplocation,"+
		" hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model, hours.nos from gl_limobookm book left join "+
		" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and hours.doc_no=srvc.typedocno) left "+
		" join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join gl_limoextrasrvctarifd vip on"+
		" (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on (srvc.boquetarifdocno=boque.doc_no and "+
		" srvc.airportid=boque.airportid) left join my_acbook ac on (book.cldocno=ac.cldocno and  ac.dtype='CRM') left join gl_limoguest guest on "+
		" (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no "+
		" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no "+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and "+
		" hours.masterstatus=3 "+sqltest+sqlhoursbranch+" )a order by a.doc_no";
		System.out.println(strsql);
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(strsql);
		jobdata=objcommon.convertToEXCEL(rs);
		stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}
}