package com.dashboard.workshop.gipmatrequest;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsGIPMatRequestDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getGIPData(String id,String mode,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			String strsql="";
			String sqlfilters="";
			
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")) {
				sqlfilters+=" and gate.brhid="+brhid;
				
			}
			System.out.println("Filters:"+sqlfilters);
			if(mode.equalsIgnoreCase("2")) {
				strsql="SELECT gate.brhid, coalesce(job.voc_no,0) jobvocno,coalesce(job.doc_no,0) jobdocno,COALESCE(wsa.sal_name,'') serviceadvisor,COALESCE(billto.refname,'') billto,case when mat.finapproval>0 then 'Financial Approval' when mat.techapproval>0 then 'Technical Approval' when mat.priceupdate>0 then 'Price Updated' when coalesce(mat.doc_no,0)>0 then 'Material Request' else '' end reqstatus,COALESCE(mat.doc_no,0) matreqdocno,COALESCE(mat.techapproval,0) techapproval,COALESCE(mat.finapproval,0) finapproval,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.date,COALESCE(ac.refname,gate.username) refname,CONCAT(gate.regno,' ',gate.pltid) regno,"+ 
						" CONCAT(brd.brand_name,' ',model.vtype) vehname,yom.yom FROM ws_gateinpass gate"+
						" LEFT JOIN my_acbook ac ON (gate.cldocno=ac.cldocno AND ac.dtype='CRM')"+
						" LEFT JOIN gl_vehbrand brd ON gate.brdid=brd.doc_no"+
						" LEFT JOIN gl_vehmodel model ON gate.modid=model.doc_no"+
						" LEFT JOIN gl_yom yom ON gate.yom=yom.doc_no"+
						" LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno"+ 
						" LEFT JOIN my_acbook billto ON (CASE WHEN COALESCE(gate.insurcldocno,0)>0 THEN gate.insurcldocno ELSE gate.cldocno END =billto.cldocno AND billto.dtype='CRM')"+
						" LEFT JOIN my_salesman wsa ON (gate.serviceadvisor=wsa.doc_no AND wsa.sal_type='WSA' AND wsa.status<>7) "+
						" LEFT JOIN ws_estm est ON gate.doc_no=est.gipno " + 
						" LEFT JOIN ws_jobcard job ON (est.doc_no=job.refno AND job.reftype='EST')" + 
						" WHERE gate.status=3 AND coalesce(mat.doc_no,0)>0 "+sqlfilters+" GROUP BY gate.doc_no";
			}
			else {
				strsql="SELECT gate.brhid, COALESCE(wsa.sal_name,'') serviceadvisor,COALESCE(billto.refname,'') billto,case when mat.finapproval>0 then 'Financial Approval' when mat.techapproval>0 then 'Technical Approval'  when mat.priceupdate>0 then 'Price Updated' when coalesce(mat.doc_no,0)>0 then 'Material Request' else '' end reqstatus,COALESCE(mat.doc_no,0) matreqdocno,COALESCE(mat.techapproval,0) techapproval,COALESCE(mat.finapproval,0) finapproval,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.date,COALESCE(ac.refname,gate.username) refname,CONCAT(gate.regno,' ',gate.pltid) regno,"+ 
						" CONCAT(brd.brand_name,' ',model.vtype) vehname,yom.yom FROM ws_gateinpass gate"+
						" LEFT JOIN my_acbook ac ON (gate.cldocno=ac.cldocno AND ac.dtype='CRM')"+
						" LEFT JOIN gl_vehbrand brd ON gate.brdid=brd.doc_no"+
						" LEFT JOIN gl_vehmodel model ON gate.modid=model.doc_no"+
						" LEFT JOIN gl_yom yom ON gate.yom=yom.doc_no"+
						" LEFT JOIN ws_gipmatreqm mat ON gate.doc_no=mat.gipdocno"+ 
						" LEFT JOIN my_acbook billto ON (CASE WHEN COALESCE(gate.insurcldocno,0)>0 THEN gate.insurcldocno ELSE gate.cldocno END =billto.cldocno AND billto.dtype='CRM')"+
						" LEFT JOIN my_salesman wsa ON (gate.serviceadvisor=wsa.doc_no AND wsa.sal_type='WSA' AND wsa.status<>7)"+
						" WHERE gate.status=3 AND gate.processstatus=1 "+sqlfilters+" GROUP BY gate.doc_no";
			}
	
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getMaterialData(String id,String gatedocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			String strsql="SELECT 'Delete' btndelete,m.doc_no docno,m.gipdocno gatedocno,d.reqdesc,d.qty,d.price FROM ws_gipmatreqm m LEFT JOIN ws_gipmatreqd d ON m.doc_no=d.rdocno WHERE m.status=3 AND m.gipdocno="+gatedocno;
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
}
