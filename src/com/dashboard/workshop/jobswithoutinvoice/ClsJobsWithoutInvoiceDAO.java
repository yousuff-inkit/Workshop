package com.dashboard.workshop.jobswithoutinvoice;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsJobsWithoutInvoiceDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getJobcardWithoutInvoiceData(String fromdate,String todate,String id,String branch,String jobcard) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				
			}
			if(sqlfromdate!=null){
				sqltest+=" and jc.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and jc.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jc.brhid="+branch;
			}
			if(!jobcard.equalsIgnoreCase("")){
				sqltest+=" and jc.voc_no="+jobcard;
			}
			
			
			String strsql="select es.voc_no estdocno,jc.voc_no, jc.date date, jc.reftype reftype, convert(case when jc.reftype='EST' then es.voc_no when"+
			" jc.reftype='GIP' then gp.voc_no else ''  end,char(25)) refno, jc.brhid brhid, convert(concat(coalesce(brd.brand_name,''),' ',"+
			" coalesce(model.vtype,''),' Reg No: ',coalesce(gp.regno,''),' Plate Code: ',coalesce(gp.pltid,''),' YoM: ',coalesce(yom.yom,''),"+
			" ' Others: ',coalesce(gp.vehother,'')),char(200)) vehicledetails, concat(coalesce(ac.refname,''),' , Address: ',"+
			" coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',coalesce(ac.per_mob,''),' , Mail: ',"+
			" coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_jobcard jc left join ws_estm es on "+
			" (jc.refno=es.doc_no and jc.reftype='EST') left join (select sum(invoiceamt) invoiceamt,"+
			" rdocno from ws_estlabour lab where  lab.confirmed=1 and lab.approved=1 group by rdocno ) lab on (es.doc_no=lab.rdocno) left join"+
			" (select sum(customeramt) customeramt,estdocno from ws_jccspare group by estdocno) spare on (es.doc_no=spare.estdocno) left join"+
			" ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST')) left join my_acbook ac"+
			" on (gp.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gp.pltid=plate.doc_no left join gl_vehbrand brd"+
			" on (gp.brdid=brd.doc_no) left join gl_vehmodel model on brd.doc_no=gp.modid left join gl_yom yom on gp.yom=yom.doc_no"+
			" where jc.complete=1 "+sqltest+" and coalesce(spare.customeramt,0.0)=0.0 and coalesce(lab.invoiceamt,0.0)=0.0 group by jc.doc_no order by jc.voc_no";
			
			System.out.println("Job Card Without Invoice Query:"+strsql);
			
			ResultSet resultSet = stmt.executeQuery(strsql);
			
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
	
	
	public JSONArray getJobcardWithoutInvoiceExcelData(String fromdate,String todate,String id,String branch,String jobcard) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				
			}
			if(sqlfromdate!=null){
				sqltest+=" and jc.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and jc.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jc.brhid="+branch;
			}
			if(!jobcard.equalsIgnoreCase("")){
				sqltest+=" and jc.voc_no="+jobcard;
			}
			
			
			String strsql="select jc.voc_no 'Job Card No',date_format(jc.date,'%d.%m.%Y') 'Date',jc.reftype 'Ref Type',convert(case when jc.reftype='EST' then es.voc_no when"+
			" jc.reftype='GIP' then gp.voc_no else ''  end,char(25)) 'Ref No',es.voc_no 'Est No',concat(coalesce(ac.refname,''),' , Address: ',"+
			" coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',coalesce(ac.per_mob,''),' , Mail: ',"+
			" coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) 'User Details',convert(concat(coalesce(brd.brand_name,''),' ',"+
			" coalesce(model.vtype,''),' Reg No: ',coalesce(gp.regno,''),' Plate Code: ',coalesce(gp.pltid,''),' YoM: ',coalesce(yom.yom,''),"+
			" ' Others: ',coalesce(gp.vehother,'')),char(200)) 'Vehicle Details' from ws_jobcard jc left join ws_estm es on "+
			" (jc.refno=es.doc_no and jc.reftype='EST') left join (select sum(invoiceamt) invoiceamt,"+
			" rdocno from ws_estlabour lab where  lab.confirmed=1 and lab.approved=1 group by rdocno ) lab on (es.doc_no=lab.rdocno) left join"+
			" (select sum(customeramt) customeramt,estdocno from ws_jccspare group by estdocno) spare on (es.doc_no=spare.estdocno) left join"+
			" ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST')) left join my_acbook ac"+
			" on (gp.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gp.pltid=plate.doc_no left join gl_vehbrand brd"+
			" on (gp.brdid=brd.doc_no) left join gl_vehmodel model on brd.doc_no=gp.modid left join gl_yom yom on gp.yom=yom.doc_no"+
			" where jc.complete=1 "+sqltest+" and coalesce(spare.customeramt,0.0)=0.0 and coalesce(lab.invoiceamt,0.0)=0.0 group by jc.doc_no order by jc.voc_no";
			
			System.out.println("Job Card Without Invoice Query:"+strsql);
			
			ResultSet resultSet = stmt.executeQuery(strsql);
			
			data=objcommon.convertToEXCEL(resultSet);
			
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
	
	
	public JSONArray getSearchJobCard(String jobcardno,String jobcarddate,String estdocno,String gipdocno,String cldocno,String clientname,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!jobcarddate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(jobcarddate);
			}
			if(!jobcardno.equalsIgnoreCase("")){
				sqltest+=" and jc.voc_no like '%"+jobcardno+"%'";
			}
			if(sqldate!=null){
				sqltest+=" and jc.date='"+sqldate+"'";
			}
			if(!estdocno.equalsIgnoreCase("")){
				sqltest+=" and es.voc_no like '%"+estdocno+"%'";
			}
			if(!gipdocno.equalsIgnoreCase("")){
				sqltest+=" and gp.voc_no like '%"+gipdocno+"%'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			
			String strsql="select jc.voc_no, jc.date, jc.reftype,es.voc_no estvocno,gp.voc_no gipvocno,ac.cldocno,ac.refname from ws_jobcard jc "+
			" left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST') left join ws_gateinpass gp on((jc.refno=gp.doc_no and "+
			" jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST')) left join my_acbook ac on (gp.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" left join gl_vehplate plate on gp.pltid=plate.doc_no left join gl_vehbrand brd on (gp.brdid=brd.doc_no) left join gl_vehmodel model "+
			" on brd.doc_no=gp.modid left join gl_yom yom on gp.yom=yom.doc_no where jc.complete=1 "+sqltest+" group by jc.doc_no order by jc.voc_no";
			System.out.println("Search Job Card Query:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
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
