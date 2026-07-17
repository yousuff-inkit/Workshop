package com.dashboard.analysis.utilization;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehUtilizationDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getVehUtilize(String branch,String fromdate,String todate,String fleet,String temp,String duration,String grpby1,String hidbrand,String hidmodel,String hidgroup,String hidyom) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			if(!temp.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Statement stmtsales=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String strSql="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String sqlgroup="";
			String sqlselect="";
				 if(grpby1.equalsIgnoreCase("brand")){
					
					sqlgroup=" group by f.brdid";
					sqlselect=" brd.doc_no refno,brd.brand_name description";
				 }
				else if(grpby1.equalsIgnoreCase("model")){
					sqlgroup=" group by f.vmodid";
					sqlselect=" model.doc_no refno,model.vtype description";
				}
				else if(grpby1.equalsIgnoreCase("group")){
					sqlgroup=" group by f.vgrpid";
					sqlselect=" grp.doc_no refno,grp.gname description";
				}
				else if(grpby1.equalsIgnoreCase("yom")){
					sqlgroup=" group by f.yom";
					sqlselect=" yom.doc_no refno,yom.yom description";
				}
				else{
					sqlselect=" veh.fleet_no refno,veh.flname description,veh.reg_no";
				}
			
			String sqlcommon="";
		
			if(!hidbrand.equalsIgnoreCase("")){
				sqlcommon+=" and f.brdid in ("+hidbrand+")";
			}
			if(!hidmodel.equalsIgnoreCase("")){
				sqlcommon+=" and f.vmodid in ("+hidmodel+")";
			}
			if(!hidgroup.equalsIgnoreCase("")){
				sqlcommon+=" and f.vgrpid in ("+hidgroup+")";
			}
			if(!hidyom.equalsIgnoreCase("")){
				sqlcommon+=" and f.yomid in ("+hidyom+")";
			}
			if(!fleet.equalsIgnoreCase("")){
				sqlcommon+=" and f.fleet_no in ("+fleet+")";
			}

			if(duration.equalsIgnoreCase("hours")){
			/*	
				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no,veh.brdid,veh.vmodid,veh.vgrpid,"+
						" veh.yom yomid,trancode,sum(rental) rental,sum(delivery) delivery,sum(staff) staff,sum(transfer) transfer,sum(readytorent) readytorent"+
						" ,sum(unrentable) unrentable,sum(garage) garage,timestampdiff(hour,'2015-08-19','2016-01-19') as  total,"+
						" veh.fleet_no refno,veh.flname description,veh.reg_no, veh.prch_dte purdate,salem.date saledate,clr.color,"+
						" sum(coalesce(if(trancode='FS' and veh.tran_code='FS',timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),"+
						" (cast(concat(if(salem.date>'"+sqltodate+"',salem.date,'"+sqltodate+"'),' ',CURTIME())as datetime))),forsale),0)) forsale"+
						" from ( select fleet_no,trancode,if(trancode in ('RM','RW','RD','LA','CU'),timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))),0) rental,if(trancode in ('GA','GM','GS'),timestampdiff(hour,(cast(concat(outdate,' ',"+
						" outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) garage,if(trancode in ('DL'), timestampdiff(hour,"+
						" (cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) delivery, if(trancode in ('TR'),"+
						" timestampdiff(hour,(cast(concat(outdate, ' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) transfer,"+
						" if(trancode in ('ST'),timestampdiff(hour, (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as"+
						" datetime))),0) staff,if(trancode in ('RR'), timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,"+
						" ' ',intime)as datetime))),0) readytorent, if(trancode in ('UR'),timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,if(trancode in ('FS'),timestampdiff(hour,(cast(concat(outdate,' ',"+
						" outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale,outdate,outtime from ("+
						" select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate,"+
						" if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,if(din<='"+sqltodate+"',tin,"+
						" CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or  (din between '"+sqlfromdate+"' and"+
						" '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr"+
						" on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left"+
						" join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";
				
				*/
				
				
				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no,veh.brdid,veh.vmodid,veh.vgrpid,"+
						" veh.yom yomid,veh.tran_code,trancode,sum(rental) rental,sum(delivery) delivery,sum(staff) staff,sum(transfer) transfer,sum(readytorent) readytorent"+
						" ,sum(unrentable) unrentable,sum(garage) garage,timestampdiff(hour,'"+sqlfromdate+"','"+sqltodate+"') as  total,"+sqlselect+","+
						" veh.prch_dte purdate,salem.date saledate,clr.color,"+
						" coalesce(( select if(trancode='FS' and veh.tran_code='FS',timestampdiff(hour,(cast(concat(dout,' ',tout)as datetime)),"+
						" (cast(concat(if(salem.date>'"+sqltodate+"',salem.date,'"+sqltodate+"'),' ',CURTIME())as datetime)))"+
						" ,forsale) from gl_vmove mov where doc_no=(select max(doc_no) from gl_vmove where trancode='FS' and fleet_no=veh.fleet_no)),0) forsale from ("+
						" select fleet_no,trancode,if(trancode in ('RM','RW','RD','LA','CU'),"+
						" timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) rental,"+
						" if(trancode in ('GA','GM','GS'),timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as"+
						" datetime))),0) garage,if(trancode in ('DL'), timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,"+
						" ' ',intime)as datetime))),0) delivery, if(trancode in ('TR'),timestampdiff(hour,(cast(concat(outdate, ' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))),0) transfer,if(trancode in ('ST'),timestampdiff(hour, (cast(concat(outdate,' ',outtime)"+
						" as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) staff,if(trancode in ('RR'), timestampdiff(hour,(cast(concat(outdate,"+
						" ' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) readytorent, if(trancode in ('UR'),timestampdiff(hour,"+
						" (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,if(trancode in ('FS'),"+
						" timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale from ( "+
						" select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate,"+
						" if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,if(din<='"+sqltodate+"',tin,"+
						" CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or  (din between '"+sqlfromdate+"' and"+
						" '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr"+
						" on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left"+
						" join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";

				
			}
			else if(duration.equalsIgnoreCase("days")){
							
/*				

				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no,veh.brdid,veh.vmodid,veh.vgrpid,veh.yom yomid,trancode,sum(rental) rental,sum(delivery) delivery,sum(staff) staff,sum(transfer) transfer,sum(readytorent)"+
						" readytorent,sum(unrentable) unrentable,sum(forsale) forsale,sum(garage) garage,timestampdiff(day,'"+sqlfromdate+"','"+sqltodate+"') as  total,"+sqlselect+","+
						main.fleet_no,veh.reg_no,"+
						" veh.prch_dte purdate,salem.date saledate,clr.color from ("+
						" select fleet_no,trancode,"
						+ "if(trancode in ('RM','RW','RD','LA','CU'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) rental,"
						+ "if(trancode in ('GA','GM','GS'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) garage,"
						+ "if(trancode in ('DL'), timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) delivery,"
						+ " if(trancode in ('TR'),timestampdiff(day,(cast(concat(outdate, ' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) transfer,"
						+ "if(trancode in ('ST'),timestampdiff(day, (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) staff,"
						+ "if(trancode in ('RR'), timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) readytorent,"
						+ " if(trancode in ('UR'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,"
						+ "if(trancode in ('FS'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale"+
						" from ( select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate, if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,"+
						" if(din<='"+sqltodate+"',tin,CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or "+
						" (din between '"+sqlfromdate+"' and '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on"+
						" main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no"+
						" left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr on veh.clrid=clr.doc_no left join gl_yom yom on"+
						" veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";
				*/
				
			
				
				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no,veh.brdid,veh.vmodid,veh.vgrpid,"+
						" veh.yom yomid,veh.tran_code,trancode,sum(rental) rental,sum(delivery) delivery,sum(staff) staff,sum(transfer) transfer,sum(readytorent) readytorent"+
						" ,sum(unrentable) unrentable,sum(garage) garage,timestampdiff(day,'"+sqlfromdate+"','"+sqltodate+"') as  total,"+sqlselect+","+
						" veh.prch_dte purdate,salem.date saledate,clr.color,"+
						" coalesce(( select if(trancode='FS' and veh.tran_code='FS',timestampdiff(day,(cast(concat(dout,' ',tout)as datetime)),"+
						" (cast(concat(if(salem.date>'"+sqltodate+"',salem.date,'"+sqltodate+"'),' ',CURTIME())as datetime)))"+
						" ,forsale) from gl_vmove mov where doc_no=(select max(doc_no) from gl_vmove where trancode='FS' and fleet_no=veh.fleet_no)),0) forsale from ("+
						" select fleet_no,trancode,if(trancode in ('RM','RW','RD','LA','CU'),"+
						" timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) rental,"+
						" if(trancode in ('GA','GM','GS'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as"+
						" datetime))),0) garage,if(trancode in ('DL'), timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,"+
						" ' ',intime)as datetime))),0) delivery, if(trancode in ('TR'),timestampdiff(day,(cast(concat(outdate, ' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))),0) transfer,if(trancode in ('ST'),timestampdiff(day, (cast(concat(outdate,' ',outtime)"+
						" as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) staff,if(trancode in ('RR'), timestampdiff(day,(cast(concat(outdate,"+
						" ' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) readytorent, if(trancode in ('UR'),timestampdiff(day,"+
						" (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,if(trancode in ('FS'),"+
						" timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale from ( "+
						" select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate,"+
						" if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,if(din<='"+sqltodate+"',tin,"+
						" CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or  (din between '"+sqlfromdate+"' and"+
						" '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr"+
						" on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left"+
						" join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";
				
				
			}

			System.out.println("Check Query:"+strSql);
             	ResultSet resultSet = stmtsales.executeQuery(strSql);
             	
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
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


	public JSONArray getVehUtilizeExcel(String branch,String fromdate,String todate,String fleet,String temp,String duration,String grpby1,String hidbrand,String hidmodel,String hidgroup,String hidyom) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			if(!temp.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Statement stmtsales=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String strSql="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			String sqlgroup="";
			String sqlselect="";
				 if(grpby1.equalsIgnoreCase("brand")){
					
					sqlgroup=" group by f.brdid";
					sqlselect=" brd.doc_no refno,brd.brand_name description";
				 }
				else if(grpby1.equalsIgnoreCase("model")){
					sqlgroup=" group by f.vmodid";
					sqlselect=" model.doc_no refno,model.vtype description";
				}
				else if(grpby1.equalsIgnoreCase("group")){
					sqlgroup=" group by f.vgrpid";
					sqlselect=" grp.doc_no refno,grp.gname description";
				}
				else if(grpby1.equalsIgnoreCase("yom")){
					sqlgroup=" group by f.yom";
					sqlselect=" yom.doc_no refno,yom.yom description";
				}
				else{
					sqlselect=" veh.fleet_no refno,veh.flname description,veh.reg_no";
				}
			
			String sqlcommon="";
		
			if(!hidbrand.equalsIgnoreCase("")){
				sqlcommon+=" and f.brdid in ("+hidbrand+")";
			}
			if(!hidmodel.equalsIgnoreCase("")){
				sqlcommon+=" and f.vmodid in ("+hidmodel+")";
			}
			if(!hidgroup.equalsIgnoreCase("")){
				sqlcommon+=" and f.vgrpid in ("+hidgroup+")";
			}
			if(!hidyom.equalsIgnoreCase("")){
				sqlcommon+=" and f.yomid in ("+hidyom+")";
			}
			if(!fleet.equalsIgnoreCase("")){
				sqlcommon+=" and f.fleet_no in ("+fleet+")";
			}

			if(duration.equalsIgnoreCase("hours")){
			/*	
				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no,veh.brdid,veh.vmodid,veh.vgrpid,"+
						" veh.yom yomid,trancode,sum(rental) rental,sum(delivery) delivery,sum(staff) staff,sum(transfer) transfer,sum(readytorent) readytorent"+
						" ,sum(unrentable) unrentable,sum(garage) garage,timestampdiff(hour,'2015-08-19','2016-01-19') as  total,"+
						" veh.fleet_no refno,veh.flname description,veh.reg_no, veh.prch_dte purdate,salem.date saledate,clr.color,"+
						" sum(coalesce(if(trancode='FS' and veh.tran_code='FS',timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),"+
						" (cast(concat(if(salem.date>'"+sqltodate+"',salem.date,'"+sqltodate+"'),' ',CURTIME())as datetime))),forsale),0)) forsale"+
						" from ( select fleet_no,trancode,if(trancode in ('RM','RW','RD','LA','CU'),timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))),0) rental,if(trancode in ('GA','GM','GS'),timestampdiff(hour,(cast(concat(outdate,' ',"+
						" outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) garage,if(trancode in ('DL'), timestampdiff(hour,"+
						" (cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) delivery, if(trancode in ('TR'),"+
						" timestampdiff(hour,(cast(concat(outdate, ' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) transfer,"+
						" if(trancode in ('ST'),timestampdiff(hour, (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as"+
						" datetime))),0) staff,if(trancode in ('RR'), timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,"+
						" ' ',intime)as datetime))),0) readytorent, if(trancode in ('UR'),timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,if(trancode in ('FS'),timestampdiff(hour,(cast(concat(outdate,' ',"+
						" outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale,outdate,outtime from ("+
						" select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate,"+
						" if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,if(din<='"+sqltodate+"',tin,"+
						" CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or  (din between '"+sqlfromdate+"' and"+
						" '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr"+
						" on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left"+
						" join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";
				
				*/
				
				
				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no, "+
						" sum(rental) Rental,sum(delivery) Delivery,sum(staff) Staff,sum(transfer) Transfer,sum(readytorent) ReadyToRent"+
						" ,sum(unrentable) UnRentable,sum(garage) Garage,timestampdiff(hour,'"+sqlfromdate+"','"+sqltodate+"') as  Total,"+sqlselect+","+
						" veh.prch_dte purdate,salem.date saledate,clr.color,"+
						" coalesce(( select if(trancode='FS' and veh.tran_code='FS',timestampdiff(hour,(cast(concat(dout,' ',tout)as datetime)),"+
						" (cast(concat(if(salem.date>'"+sqltodate+"',salem.date,'"+sqltodate+"'),' ',CURTIME())as datetime)))"+
						" ,forsale) from gl_vmove mov where doc_no=(select max(doc_no) from gl_vmove where trancode='FS' and fleet_no=veh.fleet_no)),0) forsale from ("+
						" select fleet_no,trancode,if(trancode in ('RM','RW','RD','LA','CU'),"+
						" timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) rental,"+
						" if(trancode in ('GA','GM','GS'),timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as"+
						" datetime))),0) garage,if(trancode in ('DL'), timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,"+
						" ' ',intime)as datetime))),0) delivery, if(trancode in ('TR'),timestampdiff(hour,(cast(concat(outdate, ' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))),0) transfer,if(trancode in ('ST'),timestampdiff(hour, (cast(concat(outdate,' ',outtime)"+
						" as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) staff,if(trancode in ('RR'), timestampdiff(hour,(cast(concat(outdate,"+
						" ' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) readytorent, if(trancode in ('UR'),timestampdiff(hour,"+
						" (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,if(trancode in ('FS'),"+
						" timestampdiff(hour,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale from ( "+
						" select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate,"+
						" if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,if(din<='"+sqltodate+"',tin,"+
						" CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or  (din between '"+sqlfromdate+"' and"+
						" '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr"+
						" on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left"+
						" join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";

				
			}
			else if(duration.equalsIgnoreCase("days")){
							
/*				

				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no,veh.brdid,veh.vmodid,veh.vgrpid,veh.yom yomid,trancode,sum(rental) rental,sum(delivery) delivery,sum(staff) staff,sum(transfer) transfer,sum(readytorent)"+
						" readytorent,sum(unrentable) unrentable,sum(forsale) forsale,sum(garage) garage,timestampdiff(day,'"+sqlfromdate+"','"+sqltodate+"') as  total,"+sqlselect+","+
						main.fleet_no,veh.reg_no,"+
						" veh.prch_dte purdate,salem.date saledate,clr.color from ("+
						" select fleet_no,trancode,"
						+ "if(trancode in ('RM','RW','RD','LA','CU'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) rental,"
						+ "if(trancode in ('GA','GM','GS'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) garage,"
						+ "if(trancode in ('DL'), timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) delivery,"
						+ " if(trancode in ('TR'),timestampdiff(day,(cast(concat(outdate, ' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as datetime))),0) transfer,"
						+ "if(trancode in ('ST'),timestampdiff(day, (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) staff,"
						+ "if(trancode in ('RR'), timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) readytorent,"
						+ " if(trancode in ('UR'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,"
						+ "if(trancode in ('FS'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale"+
						" from ( select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate, if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,"+
						" if(din<='"+sqltodate+"',tin,CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or "+
						" (din between '"+sqlfromdate+"' and '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on"+
						" main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no"+
						" left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr on veh.clrid=clr.doc_no left join gl_yom yom on"+
						" veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";
				*/
				
			
				
				strSql="select f.*,(total-rental-delivery-staff-transfer-forsale-garage) as other from (select veh.fleet_no FleetNO, "+
						" sum(rental) Rental,sum(delivery) Delivery,sum(staff) Staff,sum(transfer) Transfer,sum(readytorent) ReadyToRent"+
						" ,sum(unrentable) UnRentable,sum(garage) Garage,timestampdiff(day,'"+sqlfromdate+"','"+sqltodate+"') as  Total,"+sqlselect+","+
						" veh.prch_dte PurchaseDate,salem.date SaleDate,clr.color Color,"+
						" coalesce(( select if(trancode='FS' and veh.tran_code='FS',timestampdiff(day,(cast(concat(dout,' ',tout)as datetime)),"+
						" (cast(concat(if(salem.date>'"+sqltodate+"',salem.date,'"+sqltodate+"'),' ',CURTIME())as datetime)))"+
						" ,forsale) from gl_vmove mov where doc_no=(select max(doc_no) from gl_vmove where trancode='FS' and fleet_no=veh.fleet_no)),0) forsale from ("+
						" select fleet_no,trancode,if(trancode in ('RM','RW','RD','LA','CU'),"+
						" timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) rental,"+
						" if(trancode in ('GA','GM','GS'),timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,' ',intime)as"+
						" datetime))),0) garage,if(trancode in ('DL'), timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)),(cast(concat(indate,"+
						" ' ',intime)as datetime))),0) delivery, if(trancode in ('TR'),timestampdiff(day,(cast(concat(outdate, ' ',outtime)as datetime)),"+
						" (cast(concat(indate,' ',intime)as datetime))),0) transfer,if(trancode in ('ST'),timestampdiff(day, (cast(concat(outdate,' ',outtime)"+
						" as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) staff,if(trancode in ('RR'), timestampdiff(day,(cast(concat(outdate,"+
						" ' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) readytorent, if(trancode in ('UR'),timestampdiff(day,"+
						" (cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))) ,0) unrentable,if(trancode in ('FS'),"+
						" timestampdiff(day,(cast(concat(outdate,' ',outtime)as datetime)), (cast(concat(indate,' ',intime)as datetime))),0) forsale from ( "+
						" select if(dout<'"+sqlfromdate+"','"+sqlfromdate+"',dout) outdate, if(din<='"+sqltodate+"',din,'"+sqltodate+"') indate,"+
						" if(dout<'"+sqlfromdate+"',CURTIME(),tout) outtime,if(din<='"+sqltodate+"',tin,"+
						" CURTIME()) intime,v.* from gl_vmove v where ((dout between '"+sqlfromdate+"' and '"+sqltodate+"') or  (din between '"+sqlfromdate+"' and"+
						" '"+sqltodate+"') ))a ) main left join gl_vehmaster veh on main.fleet_no=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no  left join my_color clr"+
						" on veh.clrid=clr.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_vsaled saled on main.fleet_no=saled.fleetno left"+
						" join gl_vsalem salem on saled.rdocno=salem.doc_no group by main.fleet_no) as f where 1=1 "+sqlcommon+" group by refno";
				
				
			}

			System.out.println("Check Query:"+strSql);
             	ResultSet resultSet = stmtsales.executeQuery(strSql);
             	
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
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

}
