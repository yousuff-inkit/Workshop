package com.dashboard.leaseagreement.vehiclereturnnew;

import net.sf.json.JSONArray;
import java.sql.*;
import com.connection.*;
import com.common.*;
public class ClsVehicleReturnNewDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
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
					strsql="select * from (select agmt.vehreturndate,agmt.status, cl.indate closedate,agmt.clstatus,br.branchname,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,veh.fleet_no perfleet,agmt.outdate,"+
					" if(agmt.per_name=1,date_add(agmt.outdate,interval agmt.per_value*12 month),date_add(agmt.outdate,interval agmt.per_value month)) enddate,ac.refname,"+
					" veh.reg_no,veh.flname from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
					" (agmt.brhid=br.doc_no) left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no) left join gl_lagmtclosem cl on agmt.doc_no=cl.agmtno  and cl.status=3 ) a where  a.status=3 and  a.clstatus=0 "+
					" and '"+sqldate+"'>a.enddate"+sqltest;
				}
				else if(type.equalsIgnoreCase("2")){
					strsql="select * from (select agmt.vehreturndate,agmt.status, cl.indate closedate,agmt.vehreturnstatus,agmt.clstatus,br.branchname,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,veh.fleet_no perfleet,agmt.outdate,"+
							" if(agmt.per_name=1,date_add(agmt.outdate,interval agmt.per_value*12 month),date_add(agmt.outdate,interval agmt.per_value month)) enddate,ac.refname,"+
							" veh.reg_no,veh.flname from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on "+
							" (agmt.brhid=br.doc_no) left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)  left join gl_lagmtclosem cl on agmt.doc_no=cl.agmtno  and cl.status=3 ) a where  a.status=3 and a.clstatus=1 "+
							" and a.vehreturnstatus=0 and a.vehreturndate is null"+sqltest;
				}
				if(!strsql.equalsIgnoreCase("")){
					//System.out.println("==== "+strsql);
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
				String strvndacno="select head.doc_no from gl_lagmt agmt left join gl_leaseappm lap on (agmt.latype=2 and agmt.larefdocno=lap.doc_no) left join "+
				" gl_leasecalcreq req on lap.reqdoc=req.leasereqdocno  left join my_vendorm vnd on vnd.doc_no=req.po_dealer left join my_head head on "+
				" vnd.acc_no=head.doc_no where agmt.doc_no="+agmtno;
				ResultSet rsvndacno=stmt.executeQuery(strvndacno);
				while(rsvndacno.next()){
					vendoracno=rsvndacno.getInt("doc_no");
				}
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
	}
