package com.dashboard.workshop.wsupdateinsurcomp;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import java.sql.*;
public class ClsWSUpdateInsurCompDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getUpdateInsurCompData(String fromdate,String todate,String branch,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and gate.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and gate.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and gate.brhid="+branch;
			}
			String strsql="select gate.doc_no,gate.voc_no,gate.date,gate.brhid,br.branchname branch,ac.cldocno,ac.refname clientname,insur.cldocno "+
			" insurcldocno,insur.refname insurcompname,convert(concat(brd.brand_name,' ',model.vtype,' ',gate.regno,' ',gate.pltid,' ',yom.yom),char(250)) vehdetails "+
			" from ws_gateinpass gate left join my_brch br on gate.brhid=br.doc_no left join gl_vehbrand brd on gate.brdid=brd.doc_no left join "+
			" gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on gate.yom=yom.doc_no left join my_acbook ac on"+
			" (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_acbook insur on (gate.insurancecomp=1 and gate.insurcldocno=insur.cldocno "+
			" and insur.dtype='CRM') where gate.status=3 and gate.processstatus<=6"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		
		}
		catch(Exception e){
			e.printStackTrace();
			return data;
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getInsurCompany(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select refname,cldocno from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.dtype='CRM' and ac.status=3"
			+ " and cat.status=3 and cat.insurance=1";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			return data;
		}
		finally{
			conn.close();
		}
		return data;
	}
}
