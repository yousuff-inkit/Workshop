package com.dashboard.workshop.jobclockanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobClockAnalysisDAO {
	
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
public JSONArray technicianData(String techname,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		/*if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }*/
		Connection conn =null;
        
		try {
			conn=objconn.getMyConnection();

			Statement stmt = conn.createStatement ();
        	
			String sqltest="";
			if(!techname.equalsIgnoreCase("")){
				sqltest+=" and name like '%"+techname+"%'";
			}
			String sqlqry= "select name,doc_no from ws_technician where 1=1"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
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

public JSONArray jobCardData(String date,String id) throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();

	/*if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }*/
	Connection conn =null;
    
	try {
		conn=objconn.getMyConnection();

		Statement stmt = conn.createStatement ();
    	
		String sqltest="";
		java.sql.Date sqldate=null;
		/*if(!docno.equalsIgnoreCase("")){
			sqltest+=" and docno like '%"+docno+"%'";
		}*/
		if(!date.equalsIgnoreCase("")){
			sqldate=objcommon.changeStringtoSqlDate(date);
			sqltest+=" and date='"+sqldate+"'";
		}
		String sqlqry= "select doc_no,date,reftype from ws_jobcard where 1=1"+sqltest;
		System.out.println("sqlqry ="+sqlqry);
		ResultSet resultSet = stmt.executeQuery(sqlqry);
		
		RESULTDATA=objcommon.convertToJSON(resultSet);
		
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

public JSONArray getClockInData(String fromdate,String todate,String jcno,String techid,String id,String brhid)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="";
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.jcno='"+jcno+"'";
		}
		if(!techid.equalsIgnoreCase("") && techid!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.technicianid='"+techid+"'";
		}
		if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a") && !brhid.trim().equalsIgnoreCase("undefined")) {
			sqltest+=" and flr.brhid="+brhid;
		}
		Statement stmt=conn.createStatement();
		String strsql="select round(timestampdiff(minute,concat(clk.startdate,' ',clk.starttime),concat(clk.closedate,' ',clk.closetime))/60,2) totalhrs,flr.vehicledetails,desig.desc1 designation,dept.desc1 dept,clk.doc_no,jobvocno jcdocno,technicianid techid,startdate,starttime,closedate,closetime,tech.name techname"
		+ " from ws_clockin clk left join ws_technician tech on clk.technicianid=tech.doc_no  left join hr_empm emp on tech.acno=emp.acno"+
		" left join ws_floormgmtdata flr on clk.jcno=flr.jobdocno left join hr_setdesig desig on emp.desc_id=desig.doc_no left join hr_setdept dept on emp.dept_id=dept.doc_no"
				+ " where startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;

		 System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		clockdata=objcommon.convertToJSON(rs);
		stmt.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return clockdata;
}

public JSONArray getClockInExportData(String fromdate,String todate,String jcno,String techid,String id)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="";
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.jcno='"+jcno+"'";
		}
		if(!techid.equalsIgnoreCase("") && techid!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.technicianid='"+techid+"'";
		}
		
		Statement stmt=conn.createStatement();
		String strsql="select clk.doc_no,jcno JC_Docno,flr.vehicledetails 'Vehicle Details',tech.name Technician,desig.remarks 'Designation',dept.desc1 'Department',startdate Start_Date,starttime Start_Time,closedate Close_Date,closetime Close_Time,round(timestampdiff(minute,concat(clk.startdate,' ',clk.starttime),concat(clk.closedate,' ',clk.closetime))/60,2) 'Total Hours' "
				+ " from ws_clockin clk left join ws_technician tech on clk.technicianid=tech.doc_no  left join hr_empm emp on tech.acno=emp.acno"+
		" left join ws_floormgmtdata flr on clk.jcno=flr.jobdocno left join hr_setdesig desig on emp.desc_id=desig.doc_no left join hr_setdept dept on emp.dept_id=dept.doc_no"
				+ " where startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;

		 System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		clockdata=objcommon.convertToEXCEL(rs);
		stmt.close();
		System.out.println("EXport Excel====");
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return clockdata;
}

public JSONArray getJobCardGroupData(String fromdate,String todate,String jcno,String techid,String id,String brhid)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="";
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.jcno='"+jcno+"'";
		}
		if(!techid.equalsIgnoreCase("") && techid!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.technicianid='"+techid+"'";
		}
		if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a") && !brhid.trim().equalsIgnoreCase("undefined")) {
			sqltest+=" and flr.brhid="+brhid;
		}
		Statement stmt=conn.createStatement();
		String strsql="select base.*,round(coalesce(base.total,0)-coalesce(base.esthrs,0),2) hrsdiff,ROUND(COALESCE(((ROUND(COALESCE(base.total,0)-COALESCE(base.esthrs,0),2))/COALESCE(base.esthrs,0))*100,0),2) variancepercent from (select coalesce(flr.esthrs,0) esthrs,coalesce(flr.vehicledetails,'') vehicledetails,ac.refname,job.reftype,job.refno,round(sum((TIMESTAMPDIFF(minute,concat(startdate,' ',starttime),concat(closedate,' ',closetime))/60)),2) as total"
					+" from ws_clockin clk left join ws_jobcard job on clk.jcno=job.doc_no"
					+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join ws_floormgmtdata flr on job.doc_no=flr.jobdocno"
					+" where startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+" group by jcno) base";

		 System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		clockdata=objcommon.convertToJSON(rs);
		stmt.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return clockdata;
}


public JSONArray getJobCardGroupExportData(String fromdate,String todate,String jcno,String techid,String id)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="";
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.jcno='"+jcno+"'";
		}
		if(!techid.equalsIgnoreCase("") && techid!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.technicianid='"+techid+"'";
		}
		
		Statement stmt=conn.createStatement();
		String strsql="select @i:=@i+1 as srno,a.* from(select job.refno,ac.refname,round(sum((TIMESTAMPDIFF(minute,concat(startdate,' ',starttime),concat(closedate,' ',closetime))/60)),2) as totalhours"
					+" from ws_clockin clk left join ws_jobcard job on clk.jcno=job.doc_no"
					+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" where startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+"group by jcno)a,(select @i:=0) r";

		 System.out.println("Jobcard Export--->"+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		clockdata=objcommon.convertToJSON(rs);
		stmt.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return clockdata;
}


public JSONArray getTechnicianGroupData(String fromdate,String todate,String jcno,String techid,String id,String brhid)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="";
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.jcno='"+jcno+"'";
		}
		if(!techid.equalsIgnoreCase("") && techid!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.technicianid='"+techid+"'";
		}
		if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a") && !brhid.trim().equalsIgnoreCase("undefined")) {
			sqltest+=" and flr.brhid="+brhid;
		}
		Statement stmt=conn.createStatement();
		String strsql="select base.*,round(coalesce(base.total,0)-coalesce(base.esthrs,0),2) hrsdiff,ROUND(COALESCE(((ROUND(COALESCE(base.total,0)-COALESCE(base.esthrs,0),2))/COALESCE(base.esthrs,0))*100,0),2) variancepercent from ("+
		" select coalesce(flr.esthrs,0) esthrs,tch.name refname,clk.technicianid refno,desig.desc1 designation,dept.desc1 dept,"+
		" round(sum((TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),concat(clk.closedate,' ',clk.closetime))/60)),2) as total"
				+" from ws_clockin clk "+
				" left join ws_jobcard job on clk.jcno=job.doc_no"+
				" left join ws_technician tch on clk.technicianid=tch.doc_no"+
				" left join hr_empm emp on tch.acno=emp.acno"+
				" left join hr_setdesig desig on emp.desc_id=desig.doc_no"+
				" left join hr_setdept dept on emp.dept_id=dept.doc_no"+
				" left join ws_floormgmtdata flr on job.doc_no=flr.jobdocno"+
				
				" where clk.startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+" group by clk.technicianid) base";

		 System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		clockdata=objcommon.convertToJSON(rs);
		stmt.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return clockdata;
}



public JSONArray getTechnicianGroupExportData(String fromdate,String todate,String jcno,String techid,String id)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="";
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.jcno='"+jcno+"'";
		}
		if(!techid.equalsIgnoreCase("") && techid!=null){
			//System.out.println("sqltest");
			 sqltest+=" and clk.technicianid='"+techid+"'";
		}
		
		Statement stmt=conn.createStatement();
		String strsql="select @i:=@i+1 as srno,a.* from(select clk.technicianid refno,tch.name refname,round(sum((TIMESTAMPDIFF(minute,concat(startdate,' ',starttime),concat(closedate,' ',closetime))/60)),2) as totalhours"
					+" from ws_clockin clk left join ws_technician tch on clk.technicianid=tch.doc_no"
					+" where startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+"group by clk.technicianid)a,(select @i:=0) r";

		 System.out.println("Technician groupExport-->"+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		clockdata=objcommon.convertToJSON(rs);
		stmt.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return clockdata;
}


}
