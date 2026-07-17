package com.dashboard.workshop.gateinpassanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsGateInPassAnalysisDAO {

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
	
	public JSONArray getCountData(String id,String fromdate,String todate,String cldocno,String gipdocno,String regno,String branch) throws SQLException {
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
				 sqltest+=" and brhid="+branch;
			 }
			 if(!fromdate.equalsIgnoreCase("")){
				 sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				 sqltest+=" and date>='"+sqlfromdate+"'";
			 }
			 if(!todate.equalsIgnoreCase("")){
				 sqltodate=objcommon.changeStringtoSqlDate(todate);
				 sqltest+=" and date<='"+sqltodate+"'";
			 }
			 if(!cldocno.equalsIgnoreCase("")){
				 sqltest+=" and cldocno="+cldocno;
			 }
			 if(!gipdocno.equalsIgnoreCase("")){
				 sqltest+=" and doc_no="+gipdocno;
			 }
			 if(!regno.equalsIgnoreCase("")){
				 sqltest+=" and regno="+regno;
			 }
			 String sql="select * from ("+
					 " select 1 srno,count(*) count,'Entered' status from ws_gateinpass where processstatus=1 and status=3 "+sqltest+" union all"+
					 " select 2 srno,count(*) count,'Estimation' status from ws_gateinpass where processstatus=2 and status=3  "+sqltest+" union all"+
					 " select 3 srno,count(*) count,'Confirm Estimation' status from ws_gateinpass where processstatus=3 and status=3  "+sqltest+" union all"+
					 " select 4 srno,count(*) count,'Quotation Approval' status from ws_gateinpass where processstatus=4 and status=3  "+sqltest+" union all"+
					 " select 5 srno,count(*) count,'Job Card' status from ws_gateinpass where processstatus=5 and status=3  "+sqltest+" union all"+
					 " select 6 srno,count(*) count,'Job Card Complete' status from ws_gateinpass where processstatus=6 and status=3  "+sqltest+" union all"+
					 " select 7 srno,count(*) count,'Invoiced' status from ws_gateinpass where processstatus=7 and status=3  "+sqltest+" union all"+
					 " select 8 srno,count(*) count,'Gate Out Pass' status from ws_gateinpass where processstatus=8 and status=3  "+sqltest+" ) a order by a.srno";
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
	
	
	public JSONArray getDetailData(String id,String fromdate,String todate,String cldocno,String gipdocno,String regno,String process,String branch) throws SQLException {
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
			 if(!fromdate.equalsIgnoreCase("")){
				 sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				 sqltest+=" and gate.date>='"+sqlfromdate+"'";
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
			 if(!process.equalsIgnoreCase("")){
				 sqltest+=" and gate.processstatus="+process;
			 }
			 String sql="select coalesce(wsa.sal_name,'') serviceadvisor,coalesce(sal.sal_name,'') jobadvisor,gate.voc_no gipvocno,gate.date gipdate,est.voc_no estvocno,job.voc_no jobcardvocno,inv.voc_no invvocno,inv.date "+
			 " invdate,ac.refname,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Reg No: ',"+
			 " coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) vehicleinfo,"+
			 " coalesce(invd.total,0) total,coalesce(srvc.servicestotal,0) servicestotal,coalesce(spare.partstotal,0) partstotal"+
			 " from ws_gateinpass gate left join ws_estm est on est.gipno=gate.doc_no and est.status=3 left join ws_jobcard job on"+
			 " (job.reftype='EST' and job.refno=est.doc_no and est.status=3 ) left join (select sum(invoiceamt) servicestotal,rdocno from ws_estlabour group by"+
			 " rdocno) srvc on (srvc.rdocno=est.doc_no ) left join (select sum(invoiceamt) partstotal,jobcarddocno from ws_jccspare"+
			 " group by jobcarddocno) spare on (job.doc_no=spare.jobcarddocno) left join ws_invm inv on (inv.reftype='JC' and"+
			 " inv.refno=job.doc_no) left join (select sum(amount) total,rdocno from ws_invd group by rdocno) invd on (invd.rdocno=inv.doc_no) "+
			 " left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on"+
			 " gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on"+
			 " gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no "+
			 " left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) "+
			 " left join my_salm sal on (ac.sal_id=sal.doc_no and sal.status=3) where gate.status=3 and 1=1"+sqltest;
			 
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
	
	public JSONArray getDetailExcelData(String id,String fromdate,String todate,String cldocno,String gipdocno,String regno,String process,String branch) throws SQLException {
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
			 if(!fromdate.equalsIgnoreCase("")){
				 sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				 sqltest+=" and gate.date>='"+sqlfromdate+"'";
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
			 if(!process.equalsIgnoreCase("")){
				 sqltest+=" and gate.processstatus="+process;
			 }
			 String sql="select gate.voc_no 'GIP No',date_format(gate.date,'%d.%m.%Y') 'GIP Date',est.voc_no 'Est No',job.voc_no 'Job Card No',inv.voc_no 'Inv No',date_format(inv.date,'%d.%m.%Y') 'Inv Date' "+
			 " ,ac.refname 'Client',convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Reg No: ',"+
			 " coalesce(gate.regno,''),' ',coalesce(plate.code_name,''),' Others: ', coalesce(gate.vehother,'')),char(200)) 'Vehicle Details',"+
			 " coalesce(invd.total,0) 'Invoice Total',coalesce(spare.partstotal,0) 'Parts Cost',coalesce(srvc.servicestotal,0) 'Services Total' "+
			 " from ws_gateinpass gate left join ws_estm est on est.gipno=gate.doc_no left join ws_jobcard job on"+
			 " (job.reftype='EST' and job.refno=est.doc_no) left join (select sum(invoiceamt) servicestotal,rdocno from ws_estlabour group by"+
			 " rdocno) srvc on (srvc.rdocno=est.doc_no) left join (select sum(invoiceamt) partstotal,jobcarddocno from ws_jccspare"+
			 " group by jobcarddocno) spare on (job.doc_no=spare.jobcarddocno) left join ws_invm inv on (inv.reftype='JC' and"+
			 " inv.refno=job.doc_no) left join (select sum(amount) total,rdocno from ws_invd group by rdocno) invd on (invd.rdocno=inv.doc_no) "+
			 " left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on"+
			 " gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_vehplate plate on"+
			 " gate.pltid=plate.doc_no left join gl_yom yom on gate.yom=yom.doc_no where 1=1"+sqltest;
			 
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
