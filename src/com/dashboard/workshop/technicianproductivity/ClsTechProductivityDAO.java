package com.dashboard.workshop.technicianproductivity;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTechProductivityDAO {
	ClsCommon clscommon=new ClsCommon();
	ClsConnection clsconn=new ClsConnection();
	
	public JSONArray getDetailData(String fromdate,String todate,String techid,String jcno,String clientid,String clcatid,String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		Connection conn=null;
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		
		try{
			
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=clscommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=clscommon.changeStringtoSqlDate(todate);
			}
			if(!techid.equalsIgnoreCase("") && techid!=null){
				//System.out.println("sqltest");
				 sqltest+=" and tech.doc_no='"+techid+"'";
			}
			if(!jcno.equalsIgnoreCase("") && jcno!=null){
				//System.out.println("sqltest");
				 sqltest+=" and job.doc_no='"+jcno+"'";
			}
			if(!clientid.equalsIgnoreCase("") && clientid!=null){
				//System.out.println("sqltest");
				 sqltest+=" and ac.cldocno='"+clientid+"'";
			}
			if(!clcatid.equalsIgnoreCase("") && clcatid!=null){
				//System.out.println("sqltest");
				 sqltest+=" and cat.doc_no='"+clcatid+"'";
			}
			/*lab.total,lab.invoiceamt invoiced_value,amt.nettotal,amt.sparetot,amt.labtotal,estl.totalestlab,estl.investlab,*/
			conn=clsconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select  tech.name technician,job.voc_no jobcard,t.type service_type,m.desc1 description,lab.hrs hours,"
						+" if((amt.labtotal=0 or estl.totalestlab=0),0,round((amt.labtotal/estl.totalestlab)*lab.total,2)) total,"
						+" if((amt.labtotal=0 or estl.investlab=0),0,round((amt.labtotal/estl.investlab)*lab.invoiceamt,2)) invoiced_value"
						+" from (select inv.refno,inv.reftype from ws_invm inv where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' and inv.status=3 group by inv.refno,inv.reftype) inv left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC'"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_estlabour lab on est.doc_no=lab.rdocno"
						+" left join ws_technician tech on lab.technicianid=tech.doc_no"
						+" left join ws_jobmaster m on (lab.jobid=m.doc_no )"
						+" left join ws_jobtype t on m.jobid=t.doc_no"
						+" left join ws_gateinpass gate on (est.gipno=gate.doc_no)"
						+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join my_clcatm cat on ac.catid=cat.doc_no"
						+" left join (select rdocno,sum(total) totalestlab,sum(invoiceamt) investlab from ws_estlabour group by rdocno) estl on estl.rdocno=est.doc_no"
						+" left join (select SUM(inv.nettotal) nettotal,IF(coalesce(jc.sparetot,0)>SUM(INV.NETTOTAL),SUM(INV.NETTOTAL),coalesce(jc.sparetot,0)) sparetot, IF(SUM(inv.nettotal)-coalesce(jc.sparetot,0)<0,0,sum(inv.nettotal)-coalesce(jc.sparetot,0)) labtotal,job.doc_no from ws_invm inv"
						+" left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC'"
						+" left join (select sum(customeramt) sparetot,jobcarddocno from ws_jccspare group by jobcarddocno) jc on job.doc_no=jc.jobcarddocno "
						+ " where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"'  and inv.status=3 GROUP BY inv.refno,inv.reftype ) amt on amt.doc_no=job.doc_no"
						+" where 1=1 "+sqltest+" order by job.doc_no,tech.doc_no;";
			
			
			System.out.println("tech qry----: "+strsql);
			ResultSet resultset=stmt.executeQuery(strsql);
			RESULTDATA=clscommon.convertToJSON(resultset);
			
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		
		
		
		return RESULTDATA;
	}
	
	public JSONArray getSummaryData(String fromdate,String todate,String techid,String jcno,String clientid,String clcatid,String stype,String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		Connection conn=null;
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		
		try{
			
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=clscommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=clscommon.changeStringtoSqlDate(todate);
			}
			if(!techid.equalsIgnoreCase("") && techid!=null){
				//System.out.println("sqltest");
				 sqltest+=" and tech.doc_no='"+techid+"'";
			}
			if(!jcno.equalsIgnoreCase("") && jcno!=null){
				//System.out.println("sqltest");
				 sqltest+=" and job.doc_no='"+jcno+"'";
			}
			if(!clientid.equalsIgnoreCase("") && clientid!=null){
				//System.out.println("sqltest");
				 sqltest+=" and ac.cldocno='"+clientid+"'";
			}
			if(!clcatid.equalsIgnoreCase("") && clcatid!=null){
				//System.out.println("sqltest");
				 sqltest+=" and cat.doc_no='"+clcatid+"'";
			}
			
			conn=clsconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String selectqry="";
			String groupqry="";
			
			if(stype.equalsIgnoreCase("TCH")){
				selectqry=" tech.name refname,tech.doc_no refno,";
				groupqry=" group by tech.doc_no";
			}
			else if(stype.equalsIgnoreCase("JBC")){
				selectqry=" convert(concat(job.voc_no,'- ',ac.refname),char(100)) refname,job.voc_no refno,";
				groupqry=" group by job.doc_no";
			}
			else if(stype.equalsIgnoreCase("CLT")){
				selectqry=" ac.refname,ac.cldocno refno,";
				groupqry=" group by ac.cldocno";
			}
			else if(stype.equalsIgnoreCase("CLC")){
				selectqry=" cat.cat_name refname,cat.doc_no refno,";
				groupqry="  group by cat.doc_no";
			}
			else{ 
				selectqry="";
				groupqry="";
			}
			/*String strsql="select "+selectqry+"sum(lab.hrs) totalhours, "
					+" sum(if((amt.labtotal=0 or estl.totalestlab=0),0,round((amt.labtotal/estl.totalestlab)*lab.total,2))) total,"
					+" sum(if((amt.labtotal=0 or estl.investlab=0),0,round((amt.labtotal/estl.investlab)*lab.invoiceamt,2))) invoicetotal"
					+" from ws_invm inv left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC'"
					+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_estlabour lab on est.doc_no=lab.rdocno"
					+" left join ws_technician tech on lab.technicianid=tech.doc_no"
					+" left join ws_jobmaster m on (lab.jobid=m.doc_no )"
					+" left join ws_jobtype t on m.jobid=t.doc_no"
					+" left join ws_gateinpass gate on (est.gipno=gate.doc_no)"
					+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join my_clcatm cat on ac.catid=cat.doc_no"
					+" left join (select rdocno,sum(total) totalestlab,sum(invoiceamt) investlab from ws_estlabour group by rdocno) estl on estl.rdocno=est.doc_no"
					+" left join (select inv.nettotal,coalesce(jc.sparetot,0) sparetot,inv.nettotal-coalesce(jc.sparetot,0) labtotal,job.doc_no from ws_invm inv"
					+" left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC'"
					+" left join (select sum(customeramt) sparetot,jobcarddocno from ws_jccspare group by jobcarddocno) jc on job.doc_no=jc.jobcarddocno) amt on amt.doc_no=job.doc_no"
					+" where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+" and inv.status=3 "+groupqry;
			*/
			 
			String strsql="select "+selectqry+"sum(lab.hrs) totalhours, "
					+" sum(if((amt.labtotal=0 or estl.totalestlab=0),0,round((amt.labtotal/estl.totalestlab)*lab.total,2))) total,"
					+" sum(if((amt.labtotal=0 or estl.investlab=0),0,round((amt.labtotal/estl.investlab)*lab.invoiceamt,2))) invoicetotal"
					+" from (select inv.refno,inv.reftype from ws_invm inv where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' and inv.status=3 group by inv.refno,inv.reftype) inv left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC'"
					+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_estlabour lab on est.doc_no=lab.rdocno"
					+" left join ws_technician tech on lab.technicianid=tech.doc_no"
					+" left join ws_jobmaster m on (lab.jobid=m.doc_no )"
					+" left join ws_jobtype t on m.jobid=t.doc_no"
					+" left join ws_gateinpass gate on (est.gipno=gate.doc_no)"
					+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join my_clcatm cat on ac.catid=cat.doc_no"
					+" left join (select rdocno,sum(total) totalestlab,sum(invoiceamt) investlab from ws_estlabour group by rdocno) estl on estl.rdocno=est.doc_no"
					+" left join (select SUM(inv.nettotal) nettotal,IF(coalesce(jc.sparetot,0)>SUM(INV.NETTOTAL),SUM(INV.NETTOTAL),coalesce(jc.sparetot,0)) sparetot, IF(SUM(inv.nettotal)-coalesce(jc.sparetot,0)<0,0,sum(inv.nettotal)-coalesce(jc.sparetot,0)) labtotal,job.doc_no from ws_invm inv"
					+" left join ws_jobcard job on inv.refno=job.doc_no and inv.reftype='JC'"
					+" left join (select sum(customeramt) sparetot,jobcarddocno from ws_jccspare group by jobcarddocno) jc on job.doc_no=jc.jobcarddocno "
					+ " where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"'  and inv.status=3 GROUP BY inv.refno,inv.reftype ) amt on amt.doc_no=job.doc_no"
					+" where 1=1 "+sqltest+""+groupqry;
			
			System.out.println("summary qry----: "+strsql);
			ResultSet resultset=stmt.executeQuery(strsql);
			RESULTDATA=clscommon.convertToJSON(resultset);
			
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		
		
		
		return RESULTDATA;
	}
	
public JSONArray technicianData(String techname,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		/*if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }*/
		Connection conn =null;
        
		try {
			conn=clsconn.getMyConnection();
			Statement stmt = conn.createStatement ();
        	
			String sqltest="";
			if(!techname.equalsIgnoreCase("")){
				sqltest+=" and name like '%"+techname+"%'";
			}
			String sqlqry= "select name,doc_no from ws_technician where 1=1"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=clscommon.convertToJSON(resultSet);
			
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
	
	return RESULTDATA;
	}

public JSONArray getClientCategory() throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();

	/*if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }*/
	Connection conn =null;
    
	try {
		conn=clsconn.getMyConnection();
		Statement stmt = conn.createStatement ();
    	
		String sqlqry= "select doc_no,cat_name from my_clcatm where dtype='CRM'";
		System.out.println("sqlqry ="+sqlqry);
		ResultSet resultSet = stmt.executeQuery(sqlqry);
		RESULTDATA=clscommon.convertToJSON(resultSet);
		
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

return RESULTDATA;
}

public JSONArray clientDetailsGridReloading(String cl_name,String chk) throws SQLException {
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
    
	try {
			conn = clsconn.getMyConnection();
			Statement stmtCRM = conn.createStatement();
			String sqltest="";
			if(!cl_name.equalsIgnoreCase("")){
				//System.out.println("sqltest");
				 sqltest+=" and RefName like'%"+cl_name+"%'";
			}
			String sqlqry="SELECT RefName clname,cldocno FROM my_acbook where dtype='CRM' and status<>7"+sqltest;
			ResultSet resultSet = stmtCRM.executeQuery (sqlqry);
            
			
			
			RESULTDATA=clscommon.convertToJSON(resultSet);
			
			stmtCRM.close();
			conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return RESULTDATA;
	}

public JSONArray jobCardData(String date,String jcno,String id) throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();

	/*if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }*/
	Connection conn =null;
    
	try {
		conn=clsconn.getMyConnection();

		Statement stmt = conn.createStatement ();
    	
		String sqltest="";
		java.sql.Date sqldate=null;
		/*if(!docno.equalsIgnoreCase("")){
			sqltest+=" and docno like '%"+docno+"%'";
		}*/
		if(!date.equalsIgnoreCase("")){
			sqldate=clscommon.changeStringtoSqlDate(date);
			sqltest+=" and date='"+sqldate+"'";
		}
		if(!jcno.equalsIgnoreCase("") ){
			sqltest+=" and voc_no like '%"+jcno+"%'";
		}
		String sqlqry= "select doc_no,voc_no,date,reftype from ws_jobcard where 1=1"+sqltest;
		System.out.println("sqlqry ="+sqlqry);
		ResultSet resultSet = stmt.executeQuery(sqlqry);
		
		RESULTDATA=clscommon.convertToJSON(resultSet);
		
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

return RESULTDATA;
}
}
