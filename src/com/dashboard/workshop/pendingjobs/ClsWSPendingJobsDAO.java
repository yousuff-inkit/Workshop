package com.dashboard.workshop.pendingjobs;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsWSPendingJobsDAO {
	
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray getGateInPassData(String id,String gatedocno,String gateregno,String clientname,String date) throws SQLException{
		JSONArray data=new JSONArray();
		/*if(!id.equalsIgnoreCase("1")){
			return data;
		}*/
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and gate.doc_no like '%"+gatedocno+"%'";
			}
			if(!gateregno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+gateregno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and gate.date='"+sqldate+"'";
			}
			strsql="select gate.voc_no,gate.doc_no,gate.regno,ac.refname,gate.date from ws_gateinpass gate"
					+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') where 1=1"+sqltest;
			System.out.println("Gate:"+strsql);
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
	public JSONArray getPendingJobs(String todate,String branch,String gipno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and gate.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and gate.brhid="+branch;
			}
			if(!gipno.equalsIgnoreCase("")){
				sqltest+=" and gate.voc_no="+gipno;
			}
			
			String strsql="select est.doc_no estdocno,if(est.chklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+est.lumsumamount) sparetotal,"+
			" elab.labtot  labourtotal,(if(est.chklumsum=0,coalesce(espr.sparetot,0),coalesce(espr.sparetot,0)+est.lumsumamount)+elab.labtot)"+
			" nettotal,gate.voc_no gatevocno,gate.doc_no gatedocno,gate.brhid,gate.date,gate.cldocno,gate.regno,br.branchname branch,ac.refname,"+
			" convert(concat(coalesce(brand.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(gate.pltid,''),coalesce(yom.yom,'')),char(300)) vehicledetails from ws_gateinpass gate left join"+
			" my_brch br on gate.brhid=br.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brand"+
			" on gate.brdid=brand.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on gate.yom=yom.doc_no"+
			" left join ws_estm est on est.gipno=gate.doc_no left join (select rdocno, coalesce(sum(total),0) labtot,confirmed from ws_estlabour"+
			" where confirmed=1 and approved=1 group by rdocno) elab  on"+
			" (est.doc_no=elab.rdocno) left join (select rdocno,coalesce(sum(approvedvalue),0) sparetot,confirmed from  ws_estspare  where"+
			" confirmed=1 and approved=1 group by rdocno) espr on (est.doc_no=espr.rdocno) where gate.processstatus=4 and gate.status<>7"+sqltest;
			
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
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
