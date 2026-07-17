package com.dashboard.workshop.technicianreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTechnicianReportDAO {
	ClsCommon clscommon=new ClsCommon();
	ClsConnection clsconn=new ClsConnection();
	
	public JSONArray getTechReport(String fromdate,String todate,String techid,String jcno,String clientid,String clcatid,String id) throws SQLException{
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
				 sqltest+=" and clk.technicianid='"+techid+"'";
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
			
			String strsql="select clk.doc_no,tech.name technician,job.voc_no jobcard,ac.refname client,cat.cat_name category,startdate,starttime,closedate,closetime,"
						+" round(tech.stdcost,2) stdcostperhr,round(TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),concat(closedate,' ',closetime))/60,2) totalhours,"
						+" round((TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),concat(closedate,' ',closetime))/60)*tech.stdcost,2) totalcost"
						+" from ws_clockin clk left join ws_technician tech on clk.technicianid=tech.doc_no"
						+" left join ws_jobcard job on job.doc_no=clk.jcno"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join my_clcatm cat on ac.catid=cat.doc_no "
						+" where clk.startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;
			
			//System.out.println("tech qry----: "+strsql);
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
				 sqltest+=" and clk.technicianid='"+techid+"'";
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
				selectqry=" tech.name refname,clk.technicianid refno,";
				groupqry=" group by clk.technicianid";
			}
			else if(stype.equalsIgnoreCase("JBC")){
				selectqry=" job.voc_no refname,clk.jcno refno,";
				groupqry=" group by clk.jcno";
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
			String strsql="select "+selectqry+"sum(TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),concat(clk.closedate,' ',clk.closetime))/60) as totalhours,"
						+" sum((TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),concat(closedate,' ',closetime))/60)*coalesce(tech.stdcost,0)) totalcost,"
						+" sum((TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),concat(closedate,' ',closetime))/60)*coalesce(tech.stdcost,0))/sum(TIMESTAMPDIFF(minute,concat(startdate,' ',starttime),concat(closedate,' ',closetime))/60) as avgcostperhr"
						+" from ws_clockin clk left join ws_technician tech on clk.technicianid=tech.doc_no"
						+" left join ws_jobcard job on job.doc_no=clk.jcno"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join my_clcatm cat on ac.catid=cat.doc_no"	
						+" where clk.startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+groupqry;
			
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
