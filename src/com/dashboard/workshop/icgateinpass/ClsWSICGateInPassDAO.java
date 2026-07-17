package com.dashboard.workshop.icgateinpass;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;

public class ClsWSICGateInPassDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getGateInPassData(String fromdate,String todate,String id,String branch) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String intercompanyname=getInterCompanyName(conn);
			String intercompanyname2=getInterCompanyName2(conn);  
			String strsql="",sqltest="",sqljoin="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and nrm.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and nrm.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and nrm.brhid="+branch;
			}
			if(!intercompanyname2.equalsIgnoreCase("")){
				sqljoin="union all select cp.company,2 compno,veh.ch_no chassisno,yom.doc_no yomid,'Create' btnview,mov1.oreason description,veh.flname,nrm.doc_no,nrm.date,nrm.fleet_no,nrm.brhid,br.branchname,nrm.userid,usr.user_name user,"+
						" if(nrm.drid>0,nrm.drid,nrm.staffid) driverid,drv.sal_name driver,veh.reg_no,plate.code_name platecode,brd.brand_name brand,brd.doc_no"+
						" brandid,model.vtype model,model.doc_no modelid,yom.yom,mov.dout outdate,mov.tout outtime,mov.fout,CASE WHEN mov.fout=0.000 THEN"+
						" 'Level 0/8' WHEN mov.fout=0.125 THEN 'Level 1/8' WHEN mov.fout=0.250 THEN 'Level 2/8' WHEN mov.fout=0.375 THEN 'Level 3/8'"+
						" WHEN mov.fout=0.500 THEN 'Level 4/8' WHEN mov.fout=0.625 THEN 'Level 5/8'  WHEN mov.fout=0.750 THEN 'Level 6/8' WHEN"+
						" mov.fout=0.875 THEN 'Level 7/8' WHEN mov.fout=1.000 THEN 'Level 8/8'  END as outfuel,mov.kmout outkm from "+intercompanyname2+".gl_nrm nrm "+
						" left join "+intercompanyname2+".gl_vehmaster veh on nrm.fleet_no=veh.fleet_no left join "+intercompanyname2+".gl_vehbrand brd on veh.brdid=brd.doc_no "+
						" left join "+intercompanyname2+".gl_vehmodel model on veh.vmodid=model.doc_no left join "+intercompanyname2+".gl_vehplate plate on veh.pltid=plate.doc_no "+
						" left join "+intercompanyname2+".my_brch  br on nrm.brhid=br.doc_no left join "+intercompanyname2+".my_comp cp on br.cmpid=cp.doc_no left join "+intercompanyname2+".my_user usr on nrm.userid=usr.doc_no left join ws_gateinpass gate on (nrm.doc_no=gate.movno and gate.compno=2) left join "+
						" "+intercompanyname2+".my_salesman drv on (if(nrm.drid>0,(nrm.drid=drv.doc_no and drv.sal_type='DRV'),(nrm.staffid=drv.doc_no and "+
						" drv.sal_type='STF'))) left join "+intercompanyname2+".gl_yom yom on veh.yom=yom.doc_no left join (select max(doc_no) maxdoc,rdocno,min(doc_no) mindoc from "+
						" "+intercompanyname2+".gl_vmove where rdtype='MOV' group by rdocno) a on (a.rdocno=nrm.doc_no) left join "+intercompanyname2+".gl_vmove mov on "+
						" (mov.rdocno=nrm.doc_no and mov.rdtype='MOV' and mov.doc_no=a.maxdoc) left join "+intercompanyname2+".gl_vmove mov1 on "+
						" (mov1.rdocno=nrm.doc_no and mov1.rdtype='MOV' and mov1.doc_no=a.mindoc) where nrm.clstatus=0 and nrm.movtype in ('GA','GS','GM') and nrm.status=3 and gate.movno is null"+sqltest+"";
			}      
			strsql="select cp.company,1 compno,veh.ch_no chassisno,yom.doc_no yomid,'Create' btnview,mov1.oreason description,veh.flname,nrm.doc_no,nrm.date,nrm.fleet_no,nrm.brhid,br.branchname,nrm.userid,usr.user_name user,"+
			" if(nrm.drid>0,nrm.drid,nrm.staffid) driverid,drv.sal_name driver,veh.reg_no,plate.code_name platecode,brd.brand_name brand,brd.doc_no"+
			" brandid,model.vtype model,model.doc_no modelid,yom.yom,mov.dout outdate,mov.tout outtime,mov.fout,CASE WHEN mov.fout=0.000 THEN"+
			" 'Level 0/8' WHEN mov.fout=0.125 THEN 'Level 1/8' WHEN mov.fout=0.250 THEN 'Level 2/8' WHEN mov.fout=0.375 THEN 'Level 3/8'"+
			" WHEN mov.fout=0.500 THEN 'Level 4/8' WHEN mov.fout=0.625 THEN 'Level 5/8'  WHEN mov.fout=0.750 THEN 'Level 6/8' WHEN"+
			" mov.fout=0.875 THEN 'Level 7/8' WHEN mov.fout=1.000 THEN 'Level 8/8'  END as outfuel,mov.kmout outkm from "+intercompanyname+".gl_nrm nrm "+
			" left join "+intercompanyname+".gl_vehmaster veh on nrm.fleet_no=veh.fleet_no left join "+intercompanyname+".gl_vehbrand brd on veh.brdid=brd.doc_no "+
			" left join "+intercompanyname+".gl_vehmodel model on veh.vmodid=model.doc_no left join "+intercompanyname+".gl_vehplate plate on veh.pltid=plate.doc_no "+
			" left join "+intercompanyname+".my_brch  br on nrm.brhid=br.doc_no left join "+intercompanyname+".my_comp cp on br.cmpid=cp.doc_no left join "+intercompanyname+".my_user usr on nrm.userid=usr.doc_no left join ws_gateinpass gate on nrm.doc_no=gate.movno left join "+
			" "+intercompanyname+".my_salesman drv on (if(nrm.drid>0,(nrm.drid=drv.doc_no and drv.sal_type='DRV'),(nrm.staffid=drv.doc_no and "+
			" drv.sal_type='STF'))) left join "+intercompanyname+".gl_yom yom on veh.yom=yom.doc_no left join (select max(doc_no) maxdoc,rdocno,min(doc_no) mindoc from "+
			" "+intercompanyname+".gl_vmove where rdtype='MOV' group by rdocno) a on (a.rdocno=nrm.doc_no) left join "+intercompanyname+".gl_vmove mov on "+
			" (mov.rdocno=nrm.doc_no and mov.rdtype='MOV' and mov.doc_no=a.maxdoc) left join "+intercompanyname+".gl_vmove mov1 on "+
			" (mov1.rdocno=nrm.doc_no and mov1.rdtype='MOV' and mov1.doc_no=a.mindoc) where nrm.clstatus=0 and nrm.movtype in ('GA','GS','GM') and nrm.status=3 and gate.movno is null"+sqltest+" "+sqljoin+"";   
		    System.out.println("strsql--->>>"+strsql);       
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
	
	public String getInterCompanyName(Connection conn) {
		// TODO Auto-generated method stub
		String interCompanyname="";
		try{
			Statement stmt=conn.createStatement();
			String str="select intercompany from my_comp where doc_no=1";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				interCompanyname=rs.getString("intercompany");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return interCompanyname;
	}
	public String getInterCompanyName2(Connection conn) {
		// TODO Auto-generated method stub
		String interCompanyname="";
		try{
			Statement stmt=conn.createStatement();
			String str="select coalesce(intercompany2,'') intercompany2 from my_comp where doc_no=1";          
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				interCompanyname=rs.getString("intercompany2");   
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return interCompanyname;
	}
	
}
