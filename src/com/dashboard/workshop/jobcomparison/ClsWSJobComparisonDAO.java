package com.dashboard.workshop.jobcomparison;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

public class ClsWSJobComparisonDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getJobCompareData(String fromdate,String todate,String cldocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and job.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and job.date<='"+sqltodate+"'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno;
			}
			strsql="select job.voc_no,job.doc_no,job.date,convert(concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',"+
			" coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' ',coalesce(gate.vehother,'')),char(200))"+
			" vehicledetails,coalesce(billto.refname,'') billto,ac.refname,if(est.chklumsum=1,coalesce(est.lumsumamount,0.0),"+
			" estspare.estsparetotal) estsparetotal,estlabour.estlabourtotal,jccspare.jccsparetotal,estlabour.jcclabourtotal,inv.invtaxtotal "+
			" from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on"+
			" est.gipno=gate.doc_no left join (select sum(coalesce(approvedvalue,0)) estsparetotal,rdocno from ws_estspare where approved=1 and"+
			" confirmed=1 group by rdocno) estspare on estspare.rdocno=est.doc_no left join (select sum(coalesce(total,0)) estlabourtotal,rdocno,"+
			" sum(coalesce(invoiceamt,0)) jcclabourtotal from ws_estlabour where approved=1 and confirmed=1 group by rdocno) estlabour on"+
			" estlabour.rdocno=est.doc_no left join (select sum(coalesce(customeramt,0)) jccsparetotal,jobcarddocno jobdocno from ws_jccspare"+
			" group by jobcarddocno) jccspare on jccspare.jobdocno=job.doc_no left join (select sum(coalesce(taxtotal,0)) invtaxtotal,refno from ws_invm"+
			" where status=3 group by refno) inv on (inv.refno=job.doc_no)"+
			" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" left join my_acbook billto on (gate.insurcldocno=billto.cldocno and billto.dtype='CRM')"+
			" left join my_clcatm cat on (billto.catid=cat.doc_no and cat.status=3 and cat.insurance=1)"+
			" left join gl_vehplate plate on gate.pltid=plate.doc_no"+
			" left join gl_vehbrand brd on(gate.brdid=brd.doc_no)"+
			" left join gl_vehmodel model on gate.modid=model.doc_no"+
			" left join gl_yom yom on gate.yom=yom.doc_no where 1=1 "+sqltest+" group by job.doc_no";
			System.out.println("Query:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getJobCompareDataExcel(String fromdate,String todate,String cldocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and job.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and job.date<='"+sqltodate+"'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno;
			}
			strsql="select job.voc_no 'Job No',date_format(job.date,'%d.%m.%Y') 'Date',convert(concat(coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',"+
			" coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' ',coalesce(gate.vehother,'')),char(200)) 'Vehicle Details'"+
			" ,ac.refname 'Client',coalesce(billto.refname,'') 'Insur.Company',round(if(est.chklumsum=1,coalesce(est.lumsumamount,0.0),"+
			" estspare.estsparetotal),2) 'Est.Spare Total',round(coalesce(estlabour.estlabourtotal,0.0),2) 'Est.Labour Total',round(coalesce(jccspare.jccsparetotal,0.0),2) 'JCC Spare Total',round(coalesce(estlabour.jcclabourtotal,0.0),2) 'JCC.Labour Total',round(coalesce(inv.invtaxtotal,0.0),2) 'Inv.Total' "+
			" from ws_jobcard job left join ws_estm est on job.reftype='EST' and job.refno=est.doc_no left join ws_gateinpass gate on"+
			" est.gipno=gate.doc_no left join (select sum(coalesce(approvedvalue,0)) estsparetotal,rdocno from ws_estspare where approved=1 and"+
			" confirmed=1 group by rdocno) estspare on estspare.rdocno=est.doc_no left join (select sum(coalesce(total,0)) estlabourtotal,rdocno,"+
			" sum(coalesce(invoiceamt,0)) jcclabourtotal from ws_estlabour where approved=1 and confirmed=1 group by rdocno) estlabour on"+
			" estlabour.rdocno=est.doc_no left join (select sum(coalesce(customeramt,0)) jccsparetotal,jobcarddocno jobdocno from ws_jccspare"+
			" group by jobcarddocno) jccspare on jccspare.jobdocno=job.doc_no left join (select sum(coalesce(taxtotal,0)) invtaxtotal,refno from ws_invm"+
			" where status=3 group by refno) inv on (inv.refno=job.doc_no)"+
			" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" left join my_acbook billto on (gate.insurcldocno=billto.cldocno and billto.dtype='CRM')"+
			" left join my_clcatm cat on (billto.catid=cat.doc_no and cat.status=3 and cat.insurance=1)"+
			" left join gl_vehplate plate on gate.pltid=plate.doc_no"+
			" left join gl_vehbrand brd on(gate.brdid=brd.doc_no)"+
			" left join gl_vehmodel model on gate.modid=model.doc_no"+
			" left join gl_yom yom on gate.yom=yom.doc_no where 1=1 "+sqltest+" group by job.doc_no";
			System.out.println("Query:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getClientData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			String sqlqry= "select refname,cldocno from my_acbook where dtype='CRM' and status='3'";
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			data=objcommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}	
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
}
