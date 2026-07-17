package com.dashboard.workshop.jobplanning;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsWSJobPlanningDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public JSONArray getJobData(String date,String id,String jcno,String brhid)throws SQLException
	{
		JSONArray jcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jcdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date uptodate=null,sqltodate=null;
			String sqltest="";
			if(!date.equalsIgnoreCase("") && date!=null){
				uptodate=objcommon.changeStringtoSqlDate(date);
			}
			if(!jcno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no="+jcno;
			}
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqltest+=" and job.brhid="+brhid;
			}
			Statement stmt=conn.createStatement();
			String strsql="select dlog.edate jobdatetime,job.date,job.doc_no jobdocno,gate.regno,gate.pltid plate,brd.brand_name brand,model.vtype model,datediff(curdate(),job.date) as daysjc,gate.username user,ac.cldocno,ac.refname client,job.voc_no jobno,est.doc_no,rtype.name repairtype,sm.sal_name serviceadvisor "
						+" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
						+" left join gl_vehmodel model on gate.modid=model.doc_no"
						+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
						+" left join ws_gartype rtype on gate.repairtype=rtype.row_no"
						+" left join gl_yom yom on gate.yom=yom.doc_no left join my_salesman sm on sm.doc_no=gate.serviceadvisor and sm.sal_type='WSA' left join datalog dlog on (dlog.dtype='JBC' and dlog.doc_no=job.doc_no and dlog.entry='A' and dlog.brhid=job.brhid) where job.complete=0 and job.planstatus=0 and gate.date<='"+uptodate+"'"+sqltest;
			 
			System.out.println("jobcard-----------:"+strsql);
			
			ResultSet rs=stmt.executeQuery(strsql);
			jcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jcdata;
	}
	
	public JSONArray getJobExcelData(String date,String id,String jcno)throws SQLException
	{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date uptodate=null,sqltodate=null;
			String sqltest="";
			if(!date.equalsIgnoreCase("") && date!=null){
				uptodate=objcommon.changeStringtoSqlDate(date);
			}
			if(!jcno.equalsIgnoreCase("")){
				sqltest+=" and job.voc_no="+jcno;
			}
			Statement stmt=conn.createStatement();
			String strsql="select job.voc_no 'Job No',date_format(job.date,'%d.%m.%Y') 'Date',ac.refname 'Client',gate.regno 'Reg No',gate.pltid 'Plate',brd.brand_name 'Brand',model.vtype 'Model',datediff(curdate(),job.date) as 'Age',gate.username 'User',sm.sal_name 'Service Advisor'"
					+" from ws_jobcard job left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
					+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
					+" left join my_acbook ac on(gate.cldocno=ac.cldocno and ac.dtype='CRM')"
					+" left join gl_vehbrand brd on gate.brdid=brd.doc_no"
					+" left join gl_vehmodel model on gate.modid=model.doc_no"
					+" left join gl_vehplate plate on gate.pltid=plate.doc_no"
					+" left join ws_gartype rtype on gate.repairtype=rtype.row_no"
					+" left join gl_yom yom on gate.yom=yom.doc_no left join my_salesman sm on sm.doc_no=gate.serviceadvisor and sm.sal_type='WSA' where job.complete=0 and job.planstatus=0 and gate.date<='"+uptodate+"'"+sqltest;
		
			System.out.println("jobcardExcel-----------:"+strsql);
			 
			ResultSet rs=stmt.executeQuery(strsql);
			jobdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}
	
	public JSONArray getTeamData(String id,String brhid) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn =null;
		try {

			conn = objconn.getMyConnection();
			Statement stmt =conn.createStatement();
			ResultSet resultSet = stmt.executeQuery ("select m.grpcode,m.description desc1,m.doc_no docno,m.ismulemp,m.serteamuserlink teamuserlinkid,u.user_name teamuserlinkname from ws_teammasterm m left join my_user u on u.doc_no=m.serteamuserlink where m.status=3");
			RESULTDATA=objcommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray getBayData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		
		try{     
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sql="select  bm.doc_no, date, code, name, jobtypeid, type jobtype from  "
					+ "ws_bay bm left join ws_jobtype jt on bm.jobtypeid=jt.doc_no where bm.status=3";
			ResultSet rs=stmt.executeQuery(sql);
			data=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return data;
		
	}
	
	public JSONArray getAvailability(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		
		try{     
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sql="select m.grpcode,m.description,convert(coalesce(base.availability,'Free'),char(200)) availability from ws_teammasterm  m left join (select pl.teamdocno,if(flr.rowno is null,'Free',concat('JC# ',flr.jobvocno,'- ',flr.vehicledetails)) availability from ws_jobplanteam pl"+
			" inner join ws_floormgmtdata flr on (pl.jobdocno=flr.jobdocno and flr.deliverystatus=0)) base on base.teamdocno=m.doc_no where m.status=3";
			ResultSet rs=stmt.executeQuery(sql);
			data=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return data;
		
	}
}
