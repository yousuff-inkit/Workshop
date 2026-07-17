package com.dashboard.operations.vehicleinsurance;

import java.sql.SQLException;
import java.sql.*;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsVehicleInsuranceDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getInvoiceCountData(String uptodate,String branch,String id) throws SQLException{
		JSONArray invoicecount=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
/*			insur.terminatestatus<>1 and insur.agmtno is not null and insur.insurfromdate is not null and insur.status=3 and "+
					" '"+sqldate+"'>=insur.insurfromdate and '"+sqldate+"'<=insur.insurtodate"+sqltest+" 
*/			String strsql="select 'Insured' desc1,count(*) value from gl_lagmt agmt left join (select max(doc_no) docno,agmtno from gl_vehinsur where "+
				" status=3 and coalesce(terminatestatus,0)=0 group by agmtno) insur1 on insur1.agmtno=agmt.doc_no left join gl_vehinsur insur on "+
				" insur1.docno=insur.doc_no  where "+
			" coalesce(insur.terminatestatus,0)<>1 and '"+sqldate+"'>=insur.insurfromdate and "+
			" '"+sqldate+"'<=insur.insurtodate and insur.agmtno is not null and insur.status=3 and insur.insurfromdate is not null "+sqltest+" union all"+
			" select 'Not Insured' desc1,count(*) value from gl_lagmt agmt left join (select max(doc_no) docno,agmtno from gl_vehinsur where "+
				" status=3 and coalesce(terminatestatus,0)=0 group by agmtno) insur1 on insur1.agmtno=agmt.doc_no left join gl_vehinsur insur on "+
				" insur1.docno=insur.doc_no  where coalesce(insur.terminatestatus,0)<>1  and agmt.clstatus=0 and "+
			" (insur.insurfromdate is null or '"+sqldate+"'>insur.insurtodate) "+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			invoicecount=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicecount;
	}
	
	public JSONArray getInsurData(String uptodate,String branch,String desc,String id) throws SQLException
	{
		JSONArray insurdata=new JSONArray();
		if(desc==null || desc.equalsIgnoreCase("")){
			return insurdata;
		}
		System.out.println("Inside "+desc);
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqldate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			if(desc.equalsIgnoreCase("Insured")){
				strsql="select insur.amount insuramount,insur.insurfromdate,insur.insurtodate,veh.prch_cost,veh.ch_no,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname from gl_lagmt agmt left join (select max(doc_no) docno,agmtno from gl_vehinsur where "+
				" status=3 and coalesce(terminatestatus,0)=0 group by agmtno) insur1 on insur1.agmtno=agmt.doc_no left join gl_vehinsur insur on "+
				" insur1.docno=insur.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (IF(AGMT.PERFLEET=0,AGMT.TMPFLEET=VEH.FLEET_NO,AGMT.PERFLEET=VEH.FLEET_NO)) where insur.terminatestatus<>1 and insur.agmtno is not null and insur.insurfromdate is not null and insur.status=3 and "+
				" '"+sqldate+"'>=insur.insurfromdate and '"+sqldate+"'<=insur.insurtodate"+sqltest+"  order by agmt.voc_no";
			}
			else if(desc.equalsIgnoreCase("Not Insured")){
				strsql="select veh.prch_cost,veh.ch_no,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname from gl_lagmt agmt left join (select max(doc_no) docno,agmtno from gl_vehinsur where "+
				" status=3 and coalesce(terminatestatus,0)=0 group by agmtno) insur1 on insur1.agmtno=agmt.doc_no left join gl_vehinsur insur on "+
				" insur1.docno=insur.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (IF(AGMT.PERFLEET=0,AGMT.TMPFLEET=VEH.FLEET_NO,AGMT.PERFLEET=VEH.FLEET_NO)) where coalesce(insur.terminatestatus,0)<>1 and agmt.clstatus=0 and (insur.insurfromdate is null or '"+sqldate+"'>insur.insurtodate)"+sqltest+"  order by agmt.voc_no";
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
	
	
	public JSONArray getInsurDataExcel(String uptodate,String branch,String desc,String id) throws SQLException
	{
		JSONArray insurdata=new JSONArray();
		if(desc==null || desc.equalsIgnoreCase("")){
			return insurdata;
		}
		System.out.println("Inside "+desc);
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqldate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			if(desc.equalsIgnoreCase("Insured")){
			/*	strsql="select  @i:=@i+1 'Sr No',a.voc_no 'Agreement No',a.branchname 'Branch',a.refname 'Client',a.date 'Date',a.outdate 'Out Date',"+
				" a.enddate 'End Date',a.fleet_no 'Fleet No',a.flname 'Fleet Name',a.ch_no 'Chassis No',a.prch_cost 'Purchase Cost' from (select veh.prch_cost,veh.ch_no,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname,(SELECT @i:= 0) as i from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where insur.terminatestatus<>1 and insur.agmtno is not null and insur.insurfromdate is not null and insur.status=3 and "+
				" '"+sqldate+"'>=insur.insurfromdate and '"+sqldate+"'<=insur.insurtodate"+sqltest+")a order by a.voc_no";
			*/
				/*strsql="select agmt.voc_no 'Agreement No',br.branchname 'Branch',ac.refname 'Client',agmt.date 'Date',agmt.outdate,convert(case when agmt.per_name=1 then "+
						" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
						" 'End Date',veh.fleet_no 'Fleet No',veh.reg_no 'Reg No',veh.flname 'Fleet Name',veh.ch_no 'Chassis No',veh.prch_cost 'Purchase Cost' from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
						" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
						" (IF(AGMT.PERFLEET=0,AGMT.TMPFLEET=VEH.FLEET_NO,AGMT.PERFLEET=VEH.FLEET_NO)) where insur.terminatestatus<>1 and insur.agmtno is not null and insur.insurfromdate is not null and insur.status=3 and "+
						" '"+sqldate+"'>=insur.insurfromdate and '"+sqldate+"'<=insur.insurtodate"+sqltest+"  order by agmt.voc_no";*/
				
				strsql="select agmt.voc_no 'Agreement No',br.branchname 'Branch',ac.refname 'Client',agmt.date 'Date',agmt.outdate,convert(case when agmt.per_name=1 then "+
						" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
						" 'End Date',veh.fleet_no 'Fleet No',veh.reg_no 'Reg No',veh.flname 'Fleet Name',veh.ch_no 'Chassis No',veh.prch_cost 'Purchase Cost',insur.amount 'Insur Amount',insur.insurfromdate 'Insur From Date',insur.insurtodate 'Insur To Date' from gl_lagmt agmt left join (select max(doc_no) docno,agmtno from gl_vehinsur where "+
						" status=3 and coalesce(terminatestatus,0)=0 group by agmtno) insur1 on insur1.agmtno=agmt.doc_no left join gl_vehinsur insur on "+
						" insur1.docno=insur.doc_no left join my_brch br on "+
						" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
						" (IF(AGMT.PERFLEET=0,AGMT.TMPFLEET=VEH.FLEET_NO,AGMT.PERFLEET=VEH.FLEET_NO)) where insur.terminatestatus<>1 and insur.agmtno is not null and insur.insurfromdate is not null and insur.status=3 and "+
						" '"+sqldate+"'>=insur.insurfromdate and '"+sqldate+"'<=insur.insurtodate"+sqltest+"  order by agmt.voc_no";
			}
			else if(desc.equalsIgnoreCase("Not Insured")){
				/*strsql="select  @i:=@i+1 'Sr No',a.voc_no 'Agreement No',a.branchname 'Branch',a.refname 'Client',a.date 'Date',a.outdate 'Out Date',"+
						" a.enddate 'End Date',a.fleet_no 'Fleet No',a.flname 'Fleet Name',a.ch_no 'Chassis No',a.prch_cost 'Purchase Cost' from (select veh.prch_cost,veh.ch_no,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname,(SELECT @i:= 0) as i from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where coalesce(insur.terminatestatus,0)<>1 and agmt.clstatus=0 and insur.insurfromdate is null or '"+sqldate+"'>insur.insurtodate"+sqltest+")a  order by a.voc_no";*/
				strsql="select agmt.voc_no 'Agreement No', br.branchname 'Branch', ac.refname 'Client',agmt.date 'Date',agmt.outdate 'Out Date',convert(case when agmt.per_name=1 then "+
						" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
						" 'End Date',veh.fleet_no 'Fleet No',veh.reg_no,veh.flname 'Fleet Name',veh.ch_no 'Chassis No',veh.prch_cost 'Purchase Cost'  from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
						" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
						" (IF(AGMT.PERFLEET=0,AGMT.TMPFLEET=VEH.FLEET_NO,AGMT.PERFLEET=VEH.FLEET_NO)) where coalesce(insur.terminatestatus,0)<>1 and agmt.clstatus=0 and (insur.insurfromdate is null or '"+sqldate+"'>insur.insurtodate)"+sqltest+"  order by agmt.voc_no";
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
	
	
	public JSONArray getVendor(String id) throws SQLException{
		JSONArray vendordata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return vendordata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			/*String strsql="select ac.cldocno,ac.refname,ac.per_mob,head.account,head.doc_no acno,head.description from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.status=3 and ac.dtype='VND'";*/
			String strsql = "select h.doc_no ACNO,h.DESCRIPTION REFNAME,h.account  from my_head h where H.ATYPE in ('GL','AP') ";
			ResultSet rs=stmt.executeQuery(strsql);
			vendordata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vendordata;
	}
	
	public JSONArray getInsurHistory(String agmtno,String id) throws SQLException{
		JSONArray history=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return history;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select agmt.voc_no agmtno,vnd.DESCRIPTION vendor,ac.refname client,insur.invno,insur.invdate,insur.amount invamount,insur.insurfromdate,insur."+
			"insurtodate from gl_vehinsur insur left join my_HEAD vnd on (insur.vendorid=vnd.DOC_NO ) left join gl_lagmt"+
			" agmt on insur.agmtno=agmt.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') "
			+ " where insur.terminatestatus<>1 and insur.status=3 and "+
			" agmt.status=3 and insur.agmtno="+agmtno;
			ResultSet rs=stmt.executeQuery(strsql);
			history=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return history;
	}
	
}
