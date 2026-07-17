package com.dashboard.invoices.extrakm;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsExtraKmDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getInvoice(String temp,String date1,String branchvalue,String client) throws SQLException {
	
		JSONArray RESULTDATA=new JSONArray();
	if(!temp.equalsIgnoreCase("1")){
		return RESULTDATA;
	}
	Connection conn=null;
	try{
		//System.out.println("Inside DAO");
		conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		java.sql.Date sqluptodate=null;
		if(!(date1.equalsIgnoreCase(""))){
			sqluptodate=ClsCommon.changeStringtoSqlDate(date1);
		}
		String sqltest="";
		if(!client.equalsIgnoreCase("") && !client.equalsIgnoreCase("0")){
			sqltest+=" where if(mov.rdtype='RAG',ragmt.cldocno="+client+",lagmt.cldocno="+client+")";
		}
		int monthcal=0,lesmonthcal=0,fuelcal=0;
		double monthcalvalue=0.0,lesmonthcalvalue=0.0;
		double prate=0.0,drate=0.0;
		String strmonthcal="";
		String strgetfuel="";
		String strinvoice="";
		
		strmonthcal="select (select method from gl_config where field_nme='monthlycal') monthcalmethod,(select method from gl_config where field_nme='lesmonthlycal')"+
		" lesmonthcalmethod,(select value from gl_config where field_nme='monthlycal') monthcalvalue,(select value from gl_config where field_nme='lesmonthlycal') "+
		" lesmonthcalvalue,(select method from gl_config where field_nme='fuelrate') fuelcal";
		ResultSet rsmonthcal=stmt.executeQuery(strmonthcal);
		while(rsmonthcal.next()){
			monthcal=rsmonthcal.getInt("monthcalmethod");
			lesmonthcal=rsmonthcal.getInt("lesmonthcalmethod");
			monthcalvalue=rsmonthcal.getDouble("monthcalvalue");
			lesmonthcalvalue=rsmonthcal.getDouble("lesmonthcalvalue");
			fuelcal=rsmonthcal.getInt("fuelcal");
		}
		
		if(fuelcal==1){
			strgetfuel="select if((select method from gl_config where field_nme='prate')=1,(select value from gl_config where field_nme='prate'),0.00) prate,"+
					" if((select method from gl_config where field_nme='drate')=1,(select value from gl_config where field_nme='drate'),0.00)drate";	
		}
		else if(fuelcal==0){
			strgetfuel="select ptlchg prate,deslchg drate from gl_fuelcharge where status<>7 and doc_no=(select max(doc_no)"+
							" from gl_fuelcharge where '"+sqluptodate+"' between frmdate and todate)";
			
		}
		ResultSet rsfuel=stmt.executeQuery(strgetfuel);
		while(rsfuel.next()){
			prate=rsfuel.getDouble("prate");
			drate=rsfuel.getDouble("drate");
		}
		/*
		strinvoice="select  currencyid,branchid,round(exkmrte,2) exkmrte,round(if(fueltype='P',"+prate+","+drate+"),2) fuelrate,acno,acname,doutt fromdate,dinn todate,voucherno voc_no, doc_no agmtno,cldocno,refname,rdtype agmttype,fuel,km totalkm,km-kmrest excesskm,kmrest,exkmrte,rentaltype,"+
		" round(case when rentaltype='Daily' then (km-dates/1*kmrest)*exkmrte"+
		" when rentaltype='Weekly' then (km-dates/7*kmrest)*exkmrte"+
		" when rentaltype='Monthly' and dates<=30 then (km-(dates/if(rdtype='RAG',if("+monthcal+"=1,day(last_day(dinn)),"+monthcalvalue+"),"+
		" if("+lesmonthcal+"=1,day(last_day(dinn)),"+lesmonthcalvalue+"))*kmrest))*exkmrte"+
		" when rentaltype='Monthly' and dates>30 then (km-(months*kmrest)+DATEDIFF(dinn,"+
		" DATE_ADD(doutt,INTERVAL months month))/if(rdtype='RAG',if("+monthcal+"=1,day(last_day(dinn)),"+monthcalvalue+"),"+
		" if("+lesmonthcal+"=1,day(last_day(dinn)),"+lesmonthcalvalue+"))*exkmrte) end,2)  excesskmamt,"+
		" fleet_no,tcap,fueltype,round(if(fuel<0,if(fueltype='P',fuel*tcap*"+prate+",fuel*tcap*"+drate+"),0)*-1,2) excessfuelamt,if(fuel<0,fuel*-1,0) excessfuel from ("+
		" select currencyid,branchid,acno,acname,voucherno, doc_no,cldocno,refname,rdtype,sum(fueldiff) fuel,sum(kmdiff) km,kmrest,exkmrte,rentaltype,fleet_no,tcap,fueltype,"+
		" if(day(doutt)>day(dinn),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM dinn),EXTRACT( YEAR_MONTH FROM doutt) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM dinn),"+
		" EXTRACT( YEAR_MONTH FROM doutt) )) months,dates,dinn,doutt from ("+
		" select head.doc_no acno,head.description acname,head.curid currencyid,if(mov.rdtype='RAG',ragmt.brhid,lagmt.brhid) branchid,min(dout) doutt,max(din) dinn,datediff(max(din),min(dout)) dates,veh.fleet_no,veh.tcap,veh.fueltype,if(mov.rdtype='RAG',rt.exkmrte,lt.exkmrte) exkmrte,"+
		" if(mov.rdtype='RAG',rt.kmrest,lt.kmrest) kmrest,if(mov.rdtype='RAG',rt.rentaltype,'Monthly') rentaltype,if(mov.rdtype='RAG',ragmt.voc_no,lagmt.voc_no) "+
		" voucherno,if(mov.rdtype='RAG',ragmt.doc_no,lagmt.doc_no) doc_no,ac.cldocno,ac.refname,mov.rdtype,if(fuel_invno=0,fin-fout,0) fueldiff,if(km_invno=0,kmin-kmout,0) kmdiff from gl_vmove mov "+
		" left join gl_ragmt ragmt on (mov.rdocno=ragmt.doc_no and mov.rdtype='RAG') left join gl_lagmt lagmt"+
		" on (mov.rdocno=lagmt.doc_no and mov.rdtype='LAG') left join my_acbook ac on (if(mov.rdtype='RAG',ragmt.cldocno=ac.cldocno, lagmt.cldocno=ac.cldocno) "+
		" and ac.dtype='CRM') left join gl_rtarif rt on (mov.rdtype='RAG' and mov.rdocno=rt.rdocno and rt.rstatus=5) left join gl_ltarif lt on(mov.rdtype='LAG' "+
		" and mov.rdocno=lt.rdocno) left join gl_vehmaster veh on (if(mov.rdtype='RAG',ragmt.fleet_no,if(lagmt.tmpfleet=0,perfleet,tmpfleet))=veh.fleet_no) "+
		" left join my_head head on (ac.acno=head.doc_no) where "+
		" mov.status='IN' and mov.rdtype in ('RAG','LAG') and (mov.fuel_invno=0 or mov.km_invno=0) and (ragmt.clstatus=0 or lagmt.clstatus=0) and din<='"+uptodate+"' group by mov.doc_no"+
		" )a group by doc_no,rdtype) b"+sqltest;*/
		ArrayList<String> extrakmarray=new ArrayList<>();
		
		String strsql="select veh.fleet_no,mov.rdtype,mov.rdocno,head.doc_no acno,head.description acname,head.curid currencyid,if(mov.rdtype='RAG',ragmt.brhid,lagmt.brhid) branchid,"+
		" if(mov.rdtype='RAG',ragmt.voc_no,lagmt.voc_no) voc_no,if(mov.rdtype='RAG',ragmt.doc_no,lagmt.doc_no) agmtno,ac.cldocno,if(mov.rdtype='RAG',rtf.exkmrte,"+
		" ltf.exkmrte) exkmrte,if(veh.fueltype='P',"+prate+","+drate+") fuelrate from gl_vmove mov left join gl_ragmt ragmt on (mov.rdocno=ragmt.doc_no and mov.rdtype='RAG') "+
		" left join gl_lagmt lagmt on (mov.rdocno=lagmt.doc_no and mov.rdtype='LAG') left join gl_vehmaster veh on (if(mov.rdtype='RAG',ragmt.fleet_no,"+
		" if(lagmt.tmpfleet=0,perfleet,tmpfleet))=veh.fleet_no) left join my_acbook ac on (if(mov.rdtype='RAG',ragmt.cldocno=ac.cldocno,lagmt.cldocno=ac.cldocno) and ac.dtype='CRM') "+
		" left join my_head head on (ac.acno=head.doc_no and ac.dtype='CRM') left join gl_rtarif rtf on (ragmt.doc_no=rtf.rdocno and rtf.rstatus=7) left join "+
		" gl_ltarif ltf on (lagmt.doc_no=ltf.rdocno) where if(mov.rdtype='RAG',ragmt.status=3,lagmt.status=3) and if(mov.rdtype='RAG',ragmt.clstatus=0,"+
		" lagmt.clstatus=0) and (mov.fuel_invno=0 or mov.km_invno=0) and mov.status='IN' and mov.din<'"+sqluptodate+"' group by mov.rdocno,mov.rdtype";
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			//agmtno,agmttype,kmdiff,allowedkm,excesskm,excesskmamt,fueldiff,excessfuelamt
			CallableStatement stmtExtraKm = conn.prepareCall("{call ExtraKMInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtExtraKm.setInt (1, rs.getInt("rdocno"));
			stmtExtraKm.setString(2,rs.getString("rdtype"));
			stmtExtraKm.registerOutParameter (3, java.sql.Types.DOUBLE);
			stmtExtraKm.registerOutParameter (4, java.sql.Types.DOUBLE);
			stmtExtraKm.registerOutParameter (5, java.sql.Types.DOUBLE);
			stmtExtraKm.registerOutParameter (6, java.sql.Types.DOUBLE);
			stmtExtraKm.registerOutParameter (7, java.sql.Types.DOUBLE);
			stmtExtraKm.registerOutParameter (8, java.sql.Types.DOUBLE);
			stmtExtraKm.registerOutParameter (9, java.sql.Types.DATE);
			stmtExtraKm.registerOutParameter (10, java.sql.Types.DATE);
			stmtExtraKm.setDate(11, sqluptodate);
			stmtExtraKm.setInt(12, rs.getInt("fleet_no"));
			System.out.println(stmtExtraKm);
			stmtExtraKm.executeQuery();
			
			String fromdate="";
			if(stmtExtraKm.getDate("maxdateout")!=null){
				fromdate=ClsCommon.changeSqltoString(stmtExtraKm.getDate("maxdateout"));
				System.out.println(fromdate);
			}
			String todate="";
			if(stmtExtraKm.getDate("maxdatein")!=null){
				todate=ClsCommon.changeSqltoString(stmtExtraKm.getDate("maxdatein"));
			}
			System.out.println("Used KM:"+stmtExtraKm.getDouble("kmdiff"));
			extrakmarray.add(rs.getString("agmtno")+"::"+rs.getString("rdtype")+"::"+rs.getString("voc_no")+"::"+fromdate
			+"::"+todate+"::"+rs.getString("acno")+"::"+rs.getString("acname")+"::"+stmtExtraKm.getDouble("excesskmamt")
			+"::"+stmtExtraKm.getDouble("excessfuelamt")+"::"+rs.getString("acno")+"::"+stmtExtraKm.getDouble("kmdiff")+"::"+stmtExtraKm.getDouble("excesskm")
			+"::"+stmtExtraKm.getDouble("fueldiff")+"::"+stmtExtraKm.getDouble("allowedkm")+"::"+rs.getString("exkmrte")+"::"+rs.getString("fuelrate")
			+"::"+rs.getString("branchid")+"::"+rs.getString("currencyid"));
		}
		RESULTDATA=convertArrayToJSON(extrakmarray);
	}
	catch(Exception e){
		e.printStackTrace();
		
		
	}
	finally{
		conn.close();
	}
	return RESULTDATA;
	}

	private JSONArray convertArrayToJSON(ArrayList<String> extrakmarray) {
		// TODO Auto-generated method stub
		
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < extrakmarray.size(); i++) {
			
			JSONObject obj = new JSONObject();
			

			obj.put("agmtno",extrakmarray.get(i).split("::")[0]);
			obj.put("agmttype",extrakmarray.get(i).split("::")[1]);
			obj.put("voc_no",extrakmarray.get(i).split("::")[2]);
			obj.put("fromdate",extrakmarray.get(i).split("::")[3]);
			obj.put("todate",extrakmarray.get(i).split("::")[4]);
			obj.put("acno",extrakmarray.get(i).split("::")[5]);
			obj.put("acname",extrakmarray.get(i).split("::")[6]);
			obj.put("excesskmamt",extrakmarray.get(i).split("::")[7]);
			obj.put("excessfuelamt",extrakmarray.get(i).split("::")[8]);
			obj.put("cldocno",extrakmarray.get(i).split("::")[9]);
			obj.put("totalkm",extrakmarray.get(i).split("::")[10]);
			obj.put("excesskm",extrakmarray.get(i).split("::")[11]);
			obj.put("excessfuel",extrakmarray.get(i).split("::")[12]);
			obj.put("kmrest",extrakmarray.get(i).split("::")[13]);
			obj.put("exkmrte",extrakmarray.get(i).split("::")[14]);
			obj.put("fuelrate",extrakmarray.get(i).split("::")[15]);
			obj.put("branchid",extrakmarray.get(i).split("::")[16]);
			obj.put("currencyid",extrakmarray.get(i).split("::")[17]);
			

			jsonArray.add(obj);
		}
		
		
		return jsonArray;
		}
	
}
