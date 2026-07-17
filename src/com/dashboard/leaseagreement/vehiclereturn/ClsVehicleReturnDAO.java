package com.dashboard.leaseagreement.vehiclereturn;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

public class ClsVehicleReturnDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getReturnData(String branch,String periodupto,String type,String id) throws SQLException{
		JSONArray returndata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return returndata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!periodupto.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(periodupto);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and a.brhid="+branch;
			}
			if(sqldate!=null){
				sqltest+=" and a.date<='"+sqldate+"'";
			}
			if(type.equalsIgnoreCase("1")){
				strsql="select * from (select agmt.clstatus,br.branchname,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,veh.fleet_no perfleet,agmt.outdate,"+
				" if(agmt.per_name=1,date_add(agmt.outdate,interval agmt.per_value*12 month),date_add(agmt.outdate,interval agmt.per_value month)) enddate,ac.refname,"+
				" veh.reg_no,veh.flname,veh.depr_date,veh.prch_cost veh_cost,veh.residual_val residualvalue from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
				" (agmt.brhid=br.doc_no) left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)) a where a.clstatus=0 "+
				" and '"+sqldate+"'>a.enddate"+sqltest;
			}
			else if(type.equalsIgnoreCase("2")){
				strsql="select * from (select 0 stockvehiclestatus,agmt.vehreturndate,agmt.vehreturnstatus,agmt.clstatus,br.branchname,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,veh.fleet_no perfleet,agmt.outdate,"+
						" if(agmt.per_name=1,date_add(agmt.outdate,interval agmt.per_value*12 month),date_add(agmt.outdate,interval agmt.per_value month)) enddate,ac.refname,"+
						" veh.reg_no,veh.flname,veh.depr_date,veh.prch_cost veh_cost,veh.residual_val residualvalue from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
						" (agmt.brhid=br.doc_no) left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)"
						+ " where agmt.clstatus=1 and agmt.vehreturnstatus=0 and agmt.vehreturndate is not null union all "
						+ " select 1 stockvehiclestatus,stock.vehreturndate,stock.vehreturnstatus,1 clstatus,br.branchname,stock.doc_no,stock.doc_no voc_no,br.doc_no brhid,stock.date,0 cldocno,veh.fleet_no perfleet,stock.fromdate outdate,"+
						" stock.todate enddate,'' refname,veh.reg_no,veh.flname,veh.depr_date,veh.prch_cost veh_cost,veh.residual_val residualvalue from gl_stockvehicles stock left join gl_vehmaster veh on stock.fleet_no=veh.fleet_no"+
						" left join my_brch br on veh.a_br=br.doc_no where stock.status=3 and stock.vehreturnstatus=0 and stock.vehreturndate is not null ) a where 1=1 "+sqltest;
			}
			System.out.println(strsql);
			if(!strsql.equalsIgnoreCase("")){
				ResultSet rsreturn=stmt.executeQuery(strsql);
				returndata=objcommon.convertToJSON(rsreturn);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return returndata;
	}
	
	
	public JSONArray calculateData(String fleetno,String type,String id,String agmtno) throws SQLException
	{
		JSONArray calculatedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return calculatedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int errorstatus=0;
			double purcost=0.0,residualval=0.0,amtdiff=0.0,assetsum=0.0,currdepr=0.0;
			int vendoracno=0;
			/*String strvndacno="select head.doc_no from gl_lagmt agmt left join gl_leaseappm lap on (agmt.latype=2 and agmt.larefdocno=lap.doc_no) left join "+
			" gl_leasecalcreq req on lap.reqdoc=req.leasereqdocno  left join my_vendorm vnd on vnd.doc_no=req.po_dealer left join my_head head on "+
			" vnd.acc_no=head.doc_no where agmt.doc_no="+agmtno;
			ResultSet rsvndacno=stmt.executeQuery(strvndacno);
			while(rsvndacno.next()){
				vendoracno=rsvndacno.getInt("doc_no");
			}*/
			//Current Depreciation      -VDE
			//Vehicle                   -VEH
			//Accumulative Depreciation -VAD
			int vehacno=0,accdepracno=0,currdepracno=0;
			String stracno="select (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='VEH') vehacno,"+
			" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='VAD') accdepracno,"+
			" (select head.doc_no from my_head head left join my_account ac on ac.acno=head.doc_no where ac.codeno='VDE') currdepracno";
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				vehacno=rsacno.getInt("vehacno");
				accdepracno=rsacno.getInt("accdepracno");
				currdepracno=rsacno.getInt("currdepracno");
			}
			String strvehdetails="select (select round(sum(dramount),0) from gc_assettran where acno="+accdepracno+" and  fleet_no="+fleetno+") assetsum,"+
			" (select round(prch_cost,0) from gl_vehmaster where fleet_no="+fleetno+" ) purcost,"+
			" (select round(residual_val,0) from gl_vehmaster where fleet_no="+fleetno+") residualval,"+
			" (select round(prch_cost-residual_val,0) from gl_vehmaster where fleet_no="+fleetno+") amtdiff";
			ResultSet rsvehdetails=stmt.executeQuery(strvehdetails);
			while(rsvehdetails.next()){
				purcost=rsvehdetails.getDouble("purcost");
				residualval=rsvehdetails.getDouble("residualval");
				amtdiff=rsvehdetails.getDouble("amtdiff");//Purchase Cost - Residual Value
				assetsum=rsvehdetails.getDouble("assetsum");//Amount Sum from gc_assettran
			}
			currdepr=purcost-residualval;
			
			String strdelete="delete from gl_vehreturncalc where fleetno="+fleetno+" and agmtno="+agmtno;
			int deleteval=stmt.executeUpdate(strdelete);
			System.out.println("Purchase Cost :"+purcost);
			System.out.println("Curr Depr : "+currdepr);
			System.out.println("Vehicle Cost - Residual Value : "+amtdiff);
			System.out.println("Vendor Acno : "+residualval);
			for(int i=0;i<5;i++){
				int acno=0;
				double amount=0.0;
				if(i==0){
					acno=vehacno;
					amount=purcost*-1;
				}
				else if(i==1){
					acno=accdepracno;
					amount=currdepr*-1;
				}
				else if(i==2){
					acno=accdepracno;
					amount=amtdiff;
				}
				else if(i==3){
					acno=currdepracno;
					amount=currdepr;
				}
				else if(i==4){
					acno=vendoracno;
					amount=residualval;
				}
				String strtempinsert="insert into gl_vehreturncalc(acno,amount,fleetno,agmtno)values("+acno+","+amount+","+fleetno+","+agmtno+")";
				int tempinsert=stmt.executeUpdate(strtempinsert);
				if(tempinsert<=0){
					errorstatus=1;
				}
			}
			if(errorstatus!=1){
				conn.commit();
				String strgetdetails="select calc.fleetno,agmt.doc_no,agmt.voc_no,head.doc_no acno,head.description,round(calc.amount,0) amount from gl_vehreturncalc calc left join "+
				" gl_lagmt agmt on  (agmt.latype=2 and calc.agmtno=agmt.doc_no) left join my_head head on calc.acno=head.doc_no where calc.fleetno="+fleetno+" and calc.agmtno="+agmtno;
				System.out.println(strgetdetails);
				ResultSet rs=stmt.executeQuery(strgetdetails);
				calculatedata=objcommon.convertToJSON(rs);
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return calculatedata;
	}
	
	
	public JSONArray calculateDataNew(String fleetno,String type,String id,String agmtno,String clientacno,String salesvalue,String stockvehiclestatus) throws SQLException{
		JSONArray calcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return calcdata;
		}
		Connection conn=null;
		try{
			int errorstatus=0;
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String agmtvocno="";
			java.sql.Date sqlduedate=null;
			java.sql.Date sqlindate=null;
			java.sql.Date sqldeprdate=null;
			java.sql.Date sqlcalcdate=null;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
			double purchasecost=0.0;
			String tempfleetno="";
			int vendorid=0;
			String stragmtdetails="select coalesce(veh.dlrid,0) vendorid,veh.prch_cost tval,veh.depr_date,veh.fleet_no,agmt.voc_no,cl.indate,case when agmt.per_name=1 then date_add(agmt.outdate,interval agmt.per_value*12 month) "+
			" when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) end duedate from gl_lagmt agmt left join gl_lagmtclosem cl on "+
			" agmt.doc_no=cl.agmtno left join gl_vehmaster veh on agmt.perfleet=veh.fleet_no where agmt.doc_no="+agmtno;
			ResultSet rsagmtdetails=stmt.executeQuery(stragmtdetails);
			while(rsagmtdetails.next()){
				sqldeprdate=rsagmtdetails.getDate("depr_date");
				sqlindate=rsagmtdetails.getDate("indate");
				sqlduedate=rsagmtdetails.getDate("duedate");
				agmtvocno=rsagmtdetails.getString("voc_no");
				purchasecost=rsagmtdetails.getDouble("tval");
				tempfleetno=rsagmtdetails.getString("fleet_no");
				vendorid=rsagmtdetails.getInt("vendorid");
			}
			if(stockvehiclestatus.equalsIgnoreCase("1")){
				String strstockdetails="select coalesce(veh.dlrid,0) vendorid,veh.prch_cost tval,veh.depr_date,veh.fleet_no,stock.doc_no voc_no,stock.todate indate,"+
				" stock.todate duedate from gl_stockvehicles stock left join gl_vehmaster veh on stock.fleet_no=veh.fleet_no where stock.doc_no="+agmtno;
						ResultSet rsstockdetails=stmt.executeQuery(strstockdetails);
						while(rsstockdetails.next()){
							sqldeprdate=rsstockdetails.getDate("depr_date");
							sqlindate=rsstockdetails.getDate("indate");
							sqlduedate=rsstockdetails.getDate("duedate");
							agmtvocno=rsstockdetails.getString("voc_no");
							purchasecost=rsstockdetails.getDouble("tval");
							tempfleetno=rsstockdetails.getString("fleet_no");
							vendorid=rsstockdetails.getInt("vendorid");
						}
			}
			
			/*String strcheckdate="select case when '"+sqlindate+"'>'"+sqlduedate+"' then '"+sqlduedate+"' when '"+sqlindate+"'<'"+sqlduedate+"' then '"+sqlindate+"' end calcdate";
			ResultSet rscheckdate=stmt.executeQuery(strcheckdate);
			while(rscheckdate.next()){
				sqlcalcdate=rscheckdate.getDate("calcdate");
			}*/
			
			
			System.out.println(sqlcalcdate);
			int vadacno=0,vdeacno=0,vehacno=0,vendoracno=0,defleetacno=0;
			String stracnoodetails="select (select head.doc_no from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='VAD') vadacno,"+
			"(select head.doc_no from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='VEH') vehacno,"+
			"(select head.doc_no from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='VDE') vdeacno,"+
			"(select head.doc_no from my_vendorm vnd inner join my_head head on vnd.acc_no=head.doc_no where vnd.doc_no="+vendorid+") vendoracno,"+
			"(select head.doc_no from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='DEFLEET DIFFERENCE ACCOUNT') defleetacno";
			ResultSet rsacnodetails=stmt.executeQuery(stracnoodetails);
			while(rsacnodetails.next()){
				vadacno=rsacnodetails.getInt("vadacno");
				vehacno=rsacnodetails.getInt("vehacno");
				vdeacno=rsacnodetails.getInt("vdeacno");
				vendoracno=rsacnodetails.getInt("vendoracno");
				defleetacno=rsacnodetails.getInt("defleetacno");
			}
			//Overridden to client
			vendoracno=Integer.parseInt(clientacno);
			
			double depramount=0.0;
/*			String strdepramount="select round((COALESCE(DATEDIFF('"+sqlcalcdate+"',coalesce(v.depr_date,v.prch_dte)),0)*round(COALESCE((COALESCE(v.prch_cost,0)-"+
			"COALESCE(v.residual_val,0))/COALESCE(DATEDIFF('"+sqlcalcdate+"',coalesce(v.depr_date,v.prch_dte)),0),0),2)),2) depramount from gl_vehmaster v where v.fleet_no="+tempfleetno;*/
			String strdepramount="";
			strdepramount="select round((COALESCE(DATEDIFF(if(leasetodate<'"+sqlindate+"',leasetodate,'"+sqlindate+"'),coalesce(v.depr_date,v.prch_dte)),0)*"+
			" round(COALESCE((COALESCE(v.prch_cost,0)-COALESCE(v.residual_val,0))/COALESCE(DATEDIFF(b.leasetodate,b.outdate),0),0),2)),2) depramount from gl_vehmaster v "+
			" left join ( select l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleetno,l.chkleaseown,l.outdate,l.cldocno,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL "+
			" l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) leasetodate from ( select max(doc_no) docno from gl_lagmt group by "+
			" if(perfleet=0,tmpfleet,perfleet)) a left join gl_lagmt l on a.docno=l.doc_no ) b on v.fleet_no=b.fleetno left join my_acbook c on b.cldocno=c.cldocno and "+
			" c.dtype='CRM' left join gl_vehplate p on v.pltid=p.doc_no left join gl_vehbrand br on v.brdid=br.doc_no left join gl_vehmodel vm on v.vmodid=vm.doc_no"+
			" where v.fleet_no="+fleetno;
			
			if(stockvehiclestatus.equalsIgnoreCase("1")){
				/*strdepramount="select round((COALESCE(DATEDIFF(if(leasetodate<'"+sqlindate+"',leasetodate,'"+sqlindate+"'),coalesce(v.depr_date,v.prch_dte)),0)*"+
				" round(COALESCE((COALESCE(v.prch_cost,0)-COALESCE(v.residual_val,0))/COALESCE(DATEDIFF(b.leasetodate,b.outdate),0),0),2)),2) depramount from gl_vehmaster v "+
				" left join ( select l.doc_no voc_no,l.fleet_no fleetno,l.fromdate outdate,l.cldocno,l.todate leasetodate from ( select max(doc_no) docno from gl_stockvehicles group by "+
				" l.fleet_no) a left join gl_stockvehicles l on a.docno=l.doc_no ) b on v.fleet_no=b.fleet_no left join my_acbook c on b.cldocno=c.cldocno and "+
				" c.dtype='CRM' left join gl_vehplate p on v.pltid=p.doc_no left join gl_vehbrand br on v.brdid=br.doc_no left join gl_vehmodel vm on v.vmodid=vm.doc_no"+
				" where v.fleet_no="+fleetno;*/
				strdepramount="select round((COALESCE(DATEDIFF(if(leasetodate<'"+sqlindate+"',leasetodate,'"+sqlindate+"'),coalesce(v.depr_date,v.prch_dte)),0)*"+
				" round(COALESCE((COALESCE(v.prch_cost,0)-COALESCE(v.residual_val,0))/COALESCE(DATEDIFF(b.leasetodate,b.outdate),0),0),2)),2)"+
				" depramount from gl_vehmaster v  left join ( select l.doc_no voc_no,l.fleet_no fleetno,l.fromdate outdate,l.todate"+
				" leasetodate from ( select max(doc_no) docno from gl_stockvehicles l group by  l.fleet_no) a left join gl_stockvehicles l on"+
				" a.docno=l.doc_no ) b on v.fleet_no=b.fleetno where v.fleet_no="+fleetno;
				
			}
			System.out.println(strdepramount);
			ResultSet rsdepramount=stmt.executeQuery(strdepramount);
			while(rsdepramount.next()){
				depramount=rsdepramount.getDouble("depramount");
			}
			double assetsum=0.0;
			String strassetsum="select sum(dramount) assetsum from gc_assettran where acno="+vadacno+" and fleet_no="+fleetno;
			ResultSet rsassetsum=stmt.executeQuery(strassetsum);
			while(rsassetsum.next()){
				assetsum=rsassetsum.getDouble("assetsum");
			}
			String strdeletestock="";
			String strinsertstockfield="";
			String strinsertstockvalue="";
			if(stockvehiclestatus.equalsIgnoreCase("1")){
				strdeletestock=" and stockvehiclestatus=1";
				strinsertstockfield=",stockvehiclestatus";
				strinsertstockvalue=",1";
			}
			int deleteentries=stmt.executeUpdate("delete from gl_vehreturncalc where agmtno="+agmtno+strdeletestock+" and fleetno="+fleetno);
			//Data Insertion corresponding to vehicle Account
			String strvehinsert="insert into gl_vehreturncalc(acno,amount,fleetno,agmtno,id"+strinsertstockfield+")values("+vehacno+","+getRoundAmount(purchasecost,conn)+","+fleetno+","+agmtno+",-1"+strinsertstockvalue+")";
			String strdeprinsert="insert into gl_vehreturncalc(acno,amount,fleetno,agmtno"+strinsertstockfield+")values("+vdeacno+","+getRoundAmount(depramount,conn)+","+fleetno+","+agmtno+""+strinsertstockvalue+")";
			String straccdeprinsert1="insert into gl_vehreturncalc(acno,amount,fleetno,agmtno,id"+strinsertstockfield+")values("+vadacno+","+getRoundAmount(depramount,conn)+","+fleetno+","+agmtno+",-1"+strinsertstockvalue+")";
			String straccdeprinsert2="insert into gl_vehreturncalc(acno,amount,fleetno,agmtno,id"+strinsertstockfield+")values("+vadacno+","+getRoundAmount(assetsum,conn)+"+("+(getRoundAmount(depramount,conn))*-1+")"+","+fleetno+","+agmtno+",-1"+strinsertstockvalue+")";
			System.out.println("strvehinsert:"+strvehinsert);
			System.out.println("strdeprinsert:"+strdeprinsert);
			System.out.println("strvehinsert:"+strvehinsert);
			System.out.println("strvehinsert:"+strvehinsert);
			System.out.println(purchasecost+"///"+depramount+"///"+assetsum);
			double totalbalance=(purchasecost-(((depramount*-1)+assetsum)*-1));
			String strbalance="insert into gl_vehreturncalc(acno,amount,fleetno,agmtno"+strinsertstockfield+")values("+vendoracno+","+getRoundAmount(Double.parseDouble(salesvalue),conn)+","+fleetno+","+agmtno+""+strinsertstockvalue+")";
			int vehinsert=stmt.executeUpdate(strvehinsert);
			if(vehinsert<=0){
				errorstatus=1;
				return calcdata;
			}
			int deprinsert=stmt.executeUpdate(strdeprinsert);
			if(deprinsert<=0){
				errorstatus=1;
				return calcdata;
			}
			int accdeprinsert1=stmt.executeUpdate(straccdeprinsert1);
			if(accdeprinsert1<=0){
				errorstatus=1;
				return calcdata;
			}
			int accdeprinsert2=stmt.executeUpdate(straccdeprinsert2);
			if(accdeprinsert2<=0){
				errorstatus=1;
				return calcdata;
			}
			int balanceinsert=stmt.executeUpdate(strbalance);
			if(balanceinsert<=0){
				errorstatus=1;
				return calcdata;
			}
			//Getting totalsum and insert into depr account
			double totalsum=0.0;
			String strtotalsum="select round(sum(calc.amount*id),2) totalsum from gl_vehreturncalc calc where calc.agmtno="+agmtno+strdeletestock+" and calc.fleetno="+fleetno;
			ResultSet rstotalsum=stmt.executeQuery(strtotalsum);
			while(rstotalsum.next()){
				totalsum=rstotalsum.getDouble("totalsum");
			}
			String strtotaldepr="insert into gl_vehreturncalc(acno,amount,fleetno,agmtno,id"+strinsertstockfield+")values("+defleetacno+","+getRoundAmount(totalsum,conn)+","+fleetno+","+agmtno+",-1"+strinsertstockvalue+")";
			int totaldeprinsert=stmt.executeUpdate(strtotaldepr);
			if(totaldeprinsert<=0){
				errorstatus=1;
				return calcdata;
			}
			if(errorstatus!=1){
				conn.commit();
				String strgetdetails="select calc.fleetno,agmt.doc_no,agmt.voc_no,head.doc_no acno,head.description,round(calc.amount*id,2) amount from gl_vehreturncalc calc left join "+
				" gl_lagmt agmt on  (calc.agmtno=agmt.doc_no) left join my_head head on calc.acno=head.doc_no where calc.fleetno="+fleetno+strdeletestock+" and calc.agmtno="+agmtno;
				System.out.println(strgetdetails);
				ResultSet rs=stmt.executeQuery(strgetdetails);
				calcdata=objcommon.convertToJSON(rs);
			}
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return calcdata;
	}
	
	
	public JSONArray getClientData(String id) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select head.account,head.description,head.doc_no acno,ac.refname,ac.cldocno from my_acbook ac left join my_head head on (ac.acno=head.doc_no and ac.dtype='CRM') where ac.dtype='CRM' and ac.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
	
	public JSONArray getPLAccountData(String id) throws SQLException{
		JSONArray accountdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return accountdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select description,account,doc_no from my_head where atype='GL'";
			ResultSet rs=stmt.executeQuery(str);
			accountdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return accountdata;
	}
	
	public double getRoundAmount(double amount,Connection conn){
		double roundamount=0.0;
		try{
			Statement stmt=conn.createStatement();
			String strround="select round("+amount+",2) amount";
			ResultSet rsround=stmt.executeQuery(strround);
			while(rsround.next()){
				roundamount=rsround.getDouble("amount");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return roundamount;
	}

public JSONArray getReturnDataexcel(String branch,String periodupto,String type,String id) throws SQLException{
		JSONArray returndata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return returndata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!periodupto.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(periodupto);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and a.brhid="+branch;
			}
			if(sqldate!=null){
				sqltest+=" and a.date<='"+sqldate+"'";
			}
			if(type.equalsIgnoreCase("1")){
				strsql="select * from (select agmt.clstatus,br.branchname,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,veh.fleet_no perfleet,agmt.outdate,"+
				" if(agmt.per_name=1,date_add(agmt.outdate,interval agmt.per_value*12 month),date_add(agmt.outdate,interval agmt.per_value month)) enddate,ac.refname,"+
				" veh.reg_no,veh.flname,veh.depr_date,veh.prch_cost veh_cost,veh.residual_val residualvalue from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
				" (agmt.brhid=br.doc_no) left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)) a where a.clstatus=0 "+
				" and '"+sqldate+"'>a.enddate"+sqltest;
			}
			else if(type.equalsIgnoreCase("2")){
				strsql="select * from (select 0 stockvehiclestatus,agmt.vehreturndate,agmt.vehreturnstatus,agmt.clstatus,br.branchname,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,veh.fleet_no perfleet,agmt.outdate,"+
						" if(agmt.per_name=1,date_add(agmt.outdate,interval agmt.per_value*12 month),date_add(agmt.outdate,interval agmt.per_value month)) enddate,ac.refname,"+
						" veh.reg_no,veh.flname,veh.depr_date,veh.prch_cost veh_cost,veh.residual_val residualvalue from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
						" (agmt.brhid=br.doc_no) left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)"
						+ " where agmt.clstatus=1 and agmt.vehreturnstatus=0 and agmt.vehreturndate is not null union all "
						+ " select 1 stockvehiclestatus,stock.vehreturndate,stock.vehreturnstatus,1 clstatus,br.branchname,stock.doc_no,stock.doc_no voc_no,br.doc_no brhid,stock.date,0 cldocno,veh.fleet_no perfleet,stock.fromdate outdate,"+
						" stock.todate enddate,'' refname,veh.reg_no,veh.flname,veh.depr_date,veh.prch_cost veh_cost,veh.residual_val residualvalue from gl_stockvehicles stock left join gl_vehmaster veh on stock.fleet_no=veh.fleet_no"+
						" left join my_brch br on veh.a_br=br.doc_no where stock.status=3 and stock.vehreturnstatus=0 and stock.vehreturndate is not null ) a where 1=1 "+sqltest;
			}
			System.out.println(strsql);
			if(!strsql.equalsIgnoreCase("")){
				ResultSet rsreturn=stmt.executeQuery(strsql);
				returndata=objcommon.convertToJSON(rsreturn);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return returndata;
	}
}
