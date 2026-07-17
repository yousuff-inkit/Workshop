package com.dashboard.leaseagreement.leasestatus;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import java.sql.*;
import net.sf.json.JSONArray;

public class ClsLeaseStatusDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getCountData(String branch,String fromdate,String todate,String id) throws SQLException{
		JSONArray countdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return countdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and d.frmdate>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and d.frmdate<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			String strsql="select 1 srno,'Entered' desc1,(select count(*) from gl_lprd d left join gl_lprm m on d.rdocno=m.doc_no where d.masterstatus=1 and m.status=3 "+sqltest+") value union all"+
			" select 2 srno,'Quoted' desc1,(select count(*) from gl_lprd d left join gl_lprm m  on d.rdocno=m.doc_no where d.masterstatus=2 and m.status=3 "+sqltest+") value union all"+
			" select 3 srno,'Lease Application' desc1,(select count(*) from gl_lprd d left join gl_lprm m  on d.rdocno=m.doc_no where d.masterstatus=3 and m.status=3 "+sqltest+") value union all"+
			" select 4 srno,'Declined' desc1,(select count(*) from gl_lprd d left join gl_lprm m  on d.rdocno=m.doc_no where d.masterstatus=4 and m.status=3 "+sqltest+") value";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			countdata=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return countdata;
	}


	public JSONArray getData(String srno,String id,String branch,String fromdate,String todate) throws SQLException{
		JSONArray statusdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return statusdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and d.frmdate>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and d.frmdate<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			String strsql="select m.brhid branch,m.doc_no reqdocno,m.voc_no reqvocno,d.sr_no reqsrno,if(m.reqtype=1,ac.refname,m.name) refname,brd.brand_name brand,"+
			" model.vtype model,d.spec specification,clr.color,d.qty,d.ldur leasemonths,d.frmdate leasefromdate"+
			" from gl_lprm m left join gl_lprd d on m.doc_no=d.rdocno left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand "+
			" brd on d.brdid=brd.doc_no left join gl_vehmodel model on d.modid=model.doc_no left join my_color clr on d.clrid=clr.doc_no where masterstatus="+srno+sqltest;
			
			ResultSet rs=stmt.executeQuery(strsql);
			statusdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return statusdata;
	}
}

