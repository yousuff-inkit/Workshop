package com.dashboard.workshop.invehiclestatus;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInVehicleStatusDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getClientDetails(String id) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn=null;
        try {
			 conn = objconn.getMyConnection();
			 Statement stmt=conn.createStatement ();
			 String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			 ResultSet resultSet = stmt.executeQuery(sql);
			 data=objcommon.convertToJSON(resultSet);
			 stmt.close();
 			 conn.close();
        }catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
        return data;
    }
	
	public JSONArray getGIPData(String id) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn=null;
        try {
			 conn = objconn.getMyConnection();
			 Statement stmt=conn.createStatement ();
			 String sql="select doc_no,voc_no,date,regno,pltid from ws_gateinpass where status=3";
			 ResultSet resultSet = stmt.executeQuery(sql);
			 data=objcommon.convertToJSON(resultSet);
			 stmt.close();
 			 conn.close();
        }catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
        return data;
    }
	
	public JSONArray getCountData(String id,String todate,String cldocno,String gipdocno,String regno,String branch) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn=null;
        try {
			 conn = objconn.getMyConnection();
			 Statement stmt=conn.createStatement ();
			 String sqltest="";
			 java.sql.Date sqlfromdate=null;
			 java.sql.Date sqltodate=null;
			 if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				 sqltest+=" and ws.brhid="+branch;
			 }
			 if(!todate.equalsIgnoreCase("")){
				 sqltodate=objcommon.changeStringtoSqlDate(todate);
				 sqltest+=" and date<='"+sqltodate+"'";
			 }
			 if(!cldocno.equalsIgnoreCase("")){
				 sqltest+=" and cldocno="+cldocno;
			 }
			 if(!gipdocno.equalsIgnoreCase("")){
				 sqltest+=" and ws.doc_no="+gipdocno;
			 }
			 if(!regno.equalsIgnoreCase("")){
				 sqltest+=" and regno="+regno;
			 }
			 String sql="select * from ("+
					 " select 1 srno,count(*) count,'ENTERED' status from ws_gateinpass ws where processstatus=1 and status=3 "+sqltest+" union all"+
					 " select 2 srno,count(*) count,'ESTIMATED' status from ws_gateinpass ws where processstatus=2 and status=3  "+sqltest+" union all"+
					 " select 3 srno,count(*) count,'ESTIMATION CONFIRMED' status from ws_gateinpass ws where processstatus=3 and status=3  "+sqltest+" union all"+
					 " select 4 srno,count(*) count,'QUOTATION APPROVED' status from ws_gateinpass ws where processstatus=4 and status=3  "+sqltest+" union all"+
					 " select 5 srno,count(*) count,'JOB CARD OPENED' status from ws_gateinpass ws where processstatus=5 and status=3  "+sqltest+" union all"+
					 " select 6 srno,count(*) count,'TEMP. RELEASED' status from ws_gateinpass ws left join ws_vehrelease vl on (ws.doc_no=vl.gatedocno and vl.doc_no=(select max(doc_no) from ws_vehrelease where gatedocno=ws.doc_no)) where ws.processstatus>=5 and ws.processstatus<7 and status=3 and vl.doc_no is not null and vl.clstatus=1 "+sqltest+" union all"+
					 " select 7 srno,count(*) count,'JOB CARD COMPLETED' status from ws_gateinpass ws where processstatus=6 and status=3  "+sqltest+" union all"+
					 " select 8 srno,count(*) count,'INVOICED' status from ws_gateinpass ws where processstatus=7 and status=3  "+sqltest+" union all"+
					 " select 9 srno,count(*) count,'ALL' status from ws_gateinpass ws where processstatus<8 and status=3  "+sqltest+" ) a order by a.srno";
			 System.out.println("sub qry---- : "+sql);
			 ResultSet resultSet = stmt.executeQuery(sql);
			 data=objcommon.convertToJSON(resultSet);
			 stmt.close();
 			 conn.close();
        }catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
        return data;
    }
	
	
	public JSONArray getDetailData(String id,String todate,String cldocno,String gipdocno,String regno,String process,String branch) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn=null;
        try {
			 conn = objconn.getMyConnection();
			 Statement stmt=conn.createStatement ();
			 String sqltest="";
			 java.sql.Date sqlfromdate=null;
			 java.sql.Date sqltodate=null;
			 if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				 sqltest+=" and gate.brhid="+branch;
			 }
			 if(!todate.equalsIgnoreCase("")){
				 sqltodate=objcommon.changeStringtoSqlDate(todate);
				 sqltest+=" and gate.date<='"+sqltodate+"'";
			 }
			 if(!cldocno.equalsIgnoreCase("")){
				 sqltest+=" and gate.cldocno="+cldocno;
			 }
			 if(!gipdocno.equalsIgnoreCase("")){
				 sqltest+=" and gate.doc_no="+gipdocno;
			 }
			 if(!regno.equalsIgnoreCase("")){
				 sqltest+=" and gate.regno="+regno;
			 }
			 if(process.equalsIgnoreCase("1")){
				 sqltest+=" and gate.processstatus="+1;
			 }
			 if(process.equalsIgnoreCase("2")){
				 sqltest+=" and gate.processstatus="+2;
			 }
			 if(process.equalsIgnoreCase("3")){
				 sqltest+=" and gate.processstatus="+3;
			 }
			 if(process.equalsIgnoreCase("4")){
				 sqltest+=" and gate.processstatus="+4;
			 }
			 if(process.equalsIgnoreCase("5")){
				 sqltest+=" and gate.processstatus="+5;
			 }
			 if(process.equalsIgnoreCase("6")){
				 sqltest+=" and gate.processstatus>=5 and gate.processstatus<7 and vl.doc_no is not null and vl.clstatus=1";
			 }
			 if(process.equalsIgnoreCase("7")){
				 sqltest+=" and gate.processstatus="+6;
			 }
			 if(process.equalsIgnoreCase("8")){
				 sqltest+=" and gate.processstatus="+7;
			 }
			 if(process.equalsIgnoreCase("9")){
				 sqltest+=" and gate.processstatus<"+8;
			 }
			 String sql="select gate.voc_no gipvocno,gate.date gipdate,est.voc_no estvocno,job.voc_no jobcardvocno,inv.voc_no invvocno,inv.date "+
			 " invdate,ac.refname,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Reg No: ',"+
			 " coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicleinfo,"+
			 " coalesce(inv.nettotal,0) total,coalesce(srvc.servicestotal,0) servicestotal,coalesce(spare.partstotal,0) partstotal"+
			 " from ws_gateinpass gate left join ws_estm est on est.gipno=gate.doc_no left join ws_jobcard job on"+
			 " (job.reftype='EST' and job.refno=est.doc_no) left join ws_vehrelease vl on (gate.doc_no=vl.gatedocno and vl.doc_no=(select max(doc_no) from ws_vehrelease where gatedocno=gate.doc_no)) "+
			 " left join (select sum(invoiceamt) servicestotal,rdocno from ws_estlabour group by"+
			 " rdocno) srvc on (srvc.rdocno=est.doc_no) left join (select sum(invoiceamt) partstotal,jobcarddocno from ws_jccspare"+
			 " group by jobcarddocno) spare on (job.doc_no=spare.jobcarddocno) "+
			 " left join (select sum(nettotal) nettotal,refno,date,voc_no from ws_invm where reftype='JC' group by refno) inv on (inv.refno=job.doc_no)"+
			 " left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on"+
			 " gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on"+
			 " gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no where gate.status=3"+sqltest;
			 
			 System.out.println("detail qry --- : "+sql);
			 
			 ResultSet resultSet = stmt.executeQuery(sql);
			 data=objcommon.convertToJSON(resultSet);
			 stmt.close();
 			 conn.close();
        }catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
        return data;
    }
	
	public JSONArray getDetailExcelData(String id,String todate,String cldocno,String gipdocno,String regno,String process,String branch) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn=null;
        try {
			 conn = objconn.getMyConnection();
			 Statement stmt=conn.createStatement ();
			 String sqltest="";
			 java.sql.Date sqltodate=null;
			 if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				 sqltest+=" and gate.brhid="+branch;
			 }
			 if(!todate.equalsIgnoreCase("")){
				 sqltodate=objcommon.changeStringtoSqlDate(todate);
				 sqltest+=" and gate.date<='"+sqltodate+"'";
			 }
			 if(!cldocno.equalsIgnoreCase("")){
				 sqltest+=" and gate.cldocno="+cldocno;
			 }
			 if(!gipdocno.equalsIgnoreCase("")){
				 sqltest+=" and gate.doc_no="+gipdocno;
			 }
			 if(!regno.equalsIgnoreCase("")){
				 sqltest+=" and gate.regno="+regno;
			 }
			 if(process.equalsIgnoreCase("1")){
				 sqltest+=" and gate.processstatus="+1;
			 }
			 if(process.equalsIgnoreCase("2")){
				 sqltest+=" and gate.processstatus="+2;
			 }
			 if(process.equalsIgnoreCase("3")){
				 sqltest+=" and gate.processstatus="+3;
			 }
			 if(process.equalsIgnoreCase("4")){
				 sqltest+=" and gate.processstatus="+4;
			 }
			 if(process.equalsIgnoreCase("5")){
				 sqltest+=" and gate.processstatus="+5;
			 }
			 if(process.equalsIgnoreCase("6")){
				 sqltest+=" and gate.processstatus>=5 and gate.processstatus<7 and vl.doc_no is not null and vl.clstatus=1";
			 }
			 if(process.equalsIgnoreCase("7")){
				 sqltest+=" and gate.processstatus="+6;
			 }
			 if(process.equalsIgnoreCase("8")){
				 sqltest+=" and gate.processstatus="+7;
			 }
			 if(process.equalsIgnoreCase("9")){
				 sqltest+=" and gate.processstatus<"+8;
			 }
			 String sql="select gate.voc_no 'GIP No',date_format(gate.date,'%d.%m.%Y') 'GIP Date',est.voc_no 'Est No',job.voc_no 'Job Card No',inv.voc_no 'Inv No',date_format(inv.date,'%d.%m.%Y') 'Inv Date' "+
			 " ,ac.refname 'Client',convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Reg No: ',"+
			 " coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) 'Vehicle Details',"+
			 " coalesce(inv.nettotal,0) 'Invoice Total',coalesce(spare.partstotal,0) 'Parts Cost',coalesce(srvc.servicestotal,0) 'Services Total' "+
			 " from ws_gateinpass gate left join ws_estm est on est.gipno=gate.doc_no left join ws_jobcard job on"+
			 " (job.reftype='EST' and job.refno=est.doc_no) left join ws_vehrelease vl on (gate.doc_no=vl.gatedocno and vl.doc_no=(select max(doc_no) from ws_vehrelease where gatedocno=gate.doc_no)) "+
			 " left join (select sum(invoiceamt) servicestotal,rdocno from ws_estlabour group by"+
			 " rdocno) srvc on (srvc.rdocno=est.doc_no) left join (select sum(invoiceamt) partstotal,jobcarddocno from ws_jccspare"+
			 " group by jobcarddocno) spare on (job.doc_no=spare.jobcarddocno) "+
			 " left join (select sum(nettotal) nettotal,refno,date,voc_no from ws_invm where reftype='JC' group by refno) inv on (inv.refno=job.doc_no)"+
			 " left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on"+
			 " gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on"+
			 " gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no where gate.status=3"+sqltest;
			 
			 ResultSet resultSet = stmt.executeQuery(sql);
			 data=objcommon.convertToEXCEL(resultSet);
			 stmt.close();
 			 conn.close();
        }catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
        return data;
    }
}
