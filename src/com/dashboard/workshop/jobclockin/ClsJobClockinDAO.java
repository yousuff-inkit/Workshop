package com.dashboard.workshop.jobclockin;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsJobClockinDAO {
	
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
public JSONArray technicianData(String techname,String id) throws SQLException{
		
		
		JSONArray RESULTDATA=new JSONArray();

		/*if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }*/
		Connection conn =null;
        
		try {
			int config=0;
			conn=objconn.getMyConnection();
			Statement stmtconfig=conn.createStatement();
			
			String strconfig="select method from gl_config where field_nme='clktch';";
			ResultSet rsconfig = stmtconfig.executeQuery(strconfig);
				while(rsconfig.next()){
					config=rsconfig.getInt("method");
				}
			System.out.println("config"+config);
			stmtconfig.close();
			
			Statement stmt = conn.createStatement ();        	
			String sqltest="";
			String techqry="";
			if(!techname.equalsIgnoreCase("")){
				sqltest+=" and tc.name like '%"+techname+"%'";
			}
			
			
			
				if(config==0){
					 techqry="select name,doc_no from ws_technician where 1=1"+sqltest; 
				}
				else if(config==1){
					 techqry="select tc.name,tc.doc_no from ws_technician tc left join (select  tch.doc_no docnos  from ws_technician tch inner join ws_clockin clk on tch.doc_no=clk.technicianid where clk.closedate is  null   group by tch.doc_no) aa"
							+" on tc.doc_no=aa.docnos where docnos is null"+sqltest;
				}
			
			
			//System.out.println("sqlqry tech 11="+techqry);
			ResultSet resultSet = stmt.executeQuery(techqry);
			
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

public JSONArray jobCardData(String date,String id,String jobnos) throws SQLException{
	
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
		if(!jobnos.equalsIgnoreCase("")){
			sqltest+=" and voc_no like '%"+jobnos+"%'";
		}
		String sqlqry= "select voc_no,doc_no,date,reftype from ws_jobcard where 1=1"+sqltest;
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

public JSONArray getClockInData(String fromdate,String todate,String id,String jcno,String sjob)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		String sqltest="";
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			sqltest+=" and jcno="+jcno;
		}
		if(sjob.equalsIgnoreCase("1")){
			sqltest+=" and (closedate is null or closetime is  null)";
		}
		Statement stmt=conn.createStatement();
		String strsql="select clk.doc_no,jcno docno,jc.voc_no jcdocno,technicianid techid,startdate,starttime,closedate,closetime,tech.name techname"
				+ " from ws_clockin clk left join ws_technician tech on clk.technicianid=tech.doc_no left join ws_jobcard jc on clk.jcno=jc.doc_no "
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

public JSONArray getClockInExportData(String fromdate,String todate,String id,String jcno,String sjob)throws SQLException
{
	JSONArray clockdata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return clockdata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		String sqltest="";
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		if(!jcno.equalsIgnoreCase("") && jcno!=null){
			sqltest+=" and jcno="+jcno;
		}
		if(sjob.equalsIgnoreCase("1")){
			sqltest+=" and (closedate is null or closetime is  null)";
		}
		Statement stmt=conn.createStatement();
		String strsql="select clk.doc_no 'Doc No',jc.voc_no 'Job Card No',tech.name 'Technician',startdate 'Start Date',starttime 'Start Time',closedate 'Close Date',closetime 'Close Time'"
				+ " from ws_clockin clk left join ws_technician tech on clk.technicianid=tech.doc_no left join ws_jobcard jc on clk.jcno=jc.doc_no "
				+ " where startdate between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;

		 System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		clockdata=objcommon.convertToEXCEL(rs);
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
