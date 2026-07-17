package com.dashboard.operations.replacelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsReplaceListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getRepData(String fromdate,String todate,String agmttype,String agmtno,String cmbrentaltype,String cmbagmtstatus,String cmbrepstatus,
			String cmbtrancode,String cmbreptype,String cmbagmtbranch,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			/*
			 * cmbrentaltype=Daily/Weekly/Monthly
			 * cmbagmtstatus=Agreement Open/Close
			 * cmbrepstatus=Replacement Open/Close
			 * cmbtrancode=GA/GM/NS
			 * cmbreptype=Atbranch/Collection
			 * cmbagmtbranch=Agreement Branch
			 */
		try {	
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				
				if(sqlfromdate!=null){
					sqltest+=" and rep.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and rep.date<='"+sqltodate+"'";
				}
				
				if(!cmbrepstatus.equalsIgnoreCase("")){
					sqltest+=" and rep.closestatus="+cmbrepstatus;
				}
				
				if(!cmbreptype.equalsIgnoreCase("")){
					sqltest+=" and rep.reptype='"+cmbreptype+"'";
				}
				
				if(!cmbtrancode.equalsIgnoreCase("")){
					sqltest+=" and rep.trancode='"+cmbtrancode+"'";
				}
				
				if(!agmttype.equalsIgnoreCase("")){
					sqltest+=" and rep.rtype='"+agmttype+"'";
				}
				
				if(!agmtno.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and rag.voc_no="+agmtno;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lag.voc_no="+agmtno;
					}
				}
				
				if(!cmbrentaltype.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and tarif.rentaltype='"+cmbrentaltype+"'";
					}
				}
				
				if(!cmbagmtbranch.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and rag.brhid="+cmbagmtbranch;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lag.brhid="+cmbagmtbranch;
					}
				}
				if(!cmbagmtstatus.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and rag.clstatus="+cmbagmtstatus;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lag.clstatus="+cmbagmtstatus;
					}
				}
				
				
				
				
				conn=ClsConnection.getMyConnection();
				Statement stmtRep = conn.createStatement();
				String strSql="select case when rep.trancode='GM' then 'Garage Maintenance' when rep.trancode='GA' then 'Garage Accident' when rep.trancode='GS' then "+
						" 'Garage Service' when rep.trancode='NS' then 'Not Satisfied' when rep.trancode='OT' then 'Others' else '' end replacereason,case when "+
						" rep.reptype='atbranch' then 'At Branch' when rep.reptype='collection' then 'Collection' else '' end replacetype,agmtbr.branchname agmtbranch,"+
						" rep.doc_no repno,if(rtype='RAG',rag.voc_no,lag.voc_no) agmtno,rep.rtype agmttype,outveh.fleet_no outfleetno,outveh.reg_no"+
						" outfleetreg,date_format(rep.odate,'%d.%m.%Y') outdate,rep.otime outtime,round(rep.okm,2) outkm,CASE WHEN rep.ofuel=0.000 THEN 'Level 0/8' WHEN "+
						" rep.ofuel=0.125 THEN 'Level 1/8' WHEN rep.ofuel=0.250 THEN 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN rep.ofuel=0.625 THEN "+
						" 'Level 5/8'  WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  else '' END "+
						" outfuel,convert(coalesce(inveh.fleet_no,''),char(25)) infleetno,convert(coalesce(inveh.reg_no,''),char(25)) infleetreg,convert(coalesce(date_format(rep.indate,'%d.%m.%Y'),''),char(25)) indate,coalesce(rep.intime,'') "+
						" intime,convert(coalesce(round(rep.inkm,2),''),char(25)) inkm,CASE WHEN rep.infuel=0.000 THEN 'Level 0/8' WHEN rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN "+
						" 'Level 2/8' WHEN rep.infuel=0.375 THEN 'Level 3/8' WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  WHEN"+
						" rep.infuel=0.750 THEN 'Level 6/8' WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 THEN 'Level 8/8'  else '' END infuel,"+
						" convert(coalesce(date_format(rep.cldate,'%d.%m.%Y'),''),char(25)) coldate,coalesce(rep.cltime,'') coltime,convert(coalesce(round(rep.clkm,2),''),char(25)) colkm,CASE WHEN rep.clfuel=0.000 THEN 'Level 0/8' WHEN "+
						" rep.clfuel=0.125 THEN 'Level 1/8' WHEN rep.clfuel=0.250 THEN 'Level 2/8' WHEN rep.clfuel=0.375 THEN 'Level 3/8' WHEN rep.clfuel=0.500 THEN "+
						" 'Level 4/8' WHEN rep.clfuel=0.625 THEN 'Level 5/8'  WHEN rep.clfuel=0.750 THEN 'Level 6/8' WHEN rep.clfuel=0.875 THEN 'Level 7/8' WHEN "+
						" rep.clfuel=1.000 THEN 'Level 8/8'  else '' END colfuel,convert(coalesce(date_format(rep.deldate,'%d.%m.%Y'),''),char(25)) deldate,coalesce(rep.deltime,'') deltime,convert(coalesce(round(rep.delkm,2),''),char(25)) "+
						" delkm,CASE WHEN rep.delfuel=0.000 THEN 'Level 0/8' WHEN rep.delfuel=0.125 THEN 'Level 1/8' WHEN rep.delfuel=0.250 THEN 'Level 2/8'"+
						" WHEN rep.delfuel=0.375 THEN 'Level 3/8' WHEN rep.delfuel=0.500 THEN 'Level 4/8' WHEN rep.delfuel=0.625 THEN 'Level 5/8'  WHEN"+
						" rep.delfuel=0.750 THEN 'Level 6/8' WHEN rep.delfuel=0.875 THEN 'Level 7/8' WHEN rep.delfuel=1.000 THEN 'Level 8/8'  else '' END"+
						" delfuel,    rep.delkm - rep.okm AS 'delconkm',rep.inkm - rep.clkm AS 'colconkm',bc.branchname repbrch  from gl_vehreplace rep left join gl_ragmt rag on (rep.rtype='RAG' and rep.rdocno=rag.doc_no) left join gl_rtarif tarif"+
						" on (rag.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_lagmt lag on (rep.rtype='LAG' and rep.rdocno=lag.doc_no) left join "+
						" gl_vehmaster inveh on (rep.rfleetno=inveh.fleet_no) left join gl_vehmaster outveh on (rep.ofleetno=outveh.fleet_no) left join my_brch agmtbr on "+
						" (if(rep.rtype='RAG',rag.brhid=agmtbr.doc_no,lag.brhid=agmtbr.doc_no)) left join my_brch bc on rep.obrhid=bc.doc_no where rep.status=3"+sqltest;
			//System.out.println(strSql);
				ResultSet resultSet = stmtRep.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtRep.close();
		}
		catch(Exception e){
			e.printStackTrace();
		    return RESULTDATA;
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}

	
	
	
	
	
	public JSONArray getRepExcelData(String fromdate,String todate,String agmttype,String agmtno,String cmbrentaltype,String cmbagmtstatus,String cmbrepstatus,
			String cmbtrancode,String cmbreptype,String cmbagmtbranch,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			/*
			 * cmbrentaltype=Daily/Weekly/Monthly
			 * cmbagmtstatus=Agreement Open/Close
			 * cmbrepstatus=Replacement Open/Close
			 * cmbtrancode=GA/GM/NS
			 * cmbreptype=Atbranch/Collection
			 * cmbagmtbranch=Agreement Branch
			 */
		try {	
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				
				if(sqlfromdate!=null){
					sqltest+=" and rep.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and rep.date<='"+sqltodate+"'";
				}
				
				if(!cmbrepstatus.equalsIgnoreCase("")){
					sqltest+=" and rep.closestatus="+cmbrepstatus;
				}
				
				if(!cmbreptype.equalsIgnoreCase("")){
					sqltest+=" and rep.reptype='"+cmbreptype+"'";
				}
				
				if(!cmbtrancode.equalsIgnoreCase("")){
					sqltest+=" and rep.trancode='"+cmbtrancode+"'";
				}
				
				if(!agmttype.equalsIgnoreCase("")){
					sqltest+=" and rep.rtype='"+agmttype+"'";
				}
				
				if(!agmtno.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and rag.voc_no="+agmtno;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lag.voc_no="+agmtno;
					}
				}
				
				if(!cmbrentaltype.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and tarif.rentaltype='"+cmbrentaltype+"'";
					}
				}
				
				if(!cmbagmtbranch.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and rag.brhid="+cmbagmtbranch;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lag.brhid="+cmbagmtbranch;
					}
				}
				if(!cmbagmtstatus.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and rag.clstatus="+cmbagmtstatus;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lag.clstatus="+cmbagmtstatus;
					}
				}
				
				
				
				
				conn=ClsConnection.getMyConnection();
				Statement stmtRep = conn.createStatement();
				String strSql="select bc.branchname 'Rep Branch',case when rep.trancode='GM' then 'Garage Maintenance' when rep.trancode='GA' then 'Garage Accident' when rep.trancode='GS' then "+
						" 'Garage Service' when rep.trancode='NS' then 'Not Satisfied' when rep.trancode='OT' then 'Others' else '' end 'Replace Reason',case when "+
						" rep.reptype='atbranch' then 'At Branch' when rep.reptype='collection' then 'Collection' else '' end 'Replace Type',agmtbr.branchname 'Agmt Branch',"+
						" rep.doc_no 'Rep No',if(rtype='RAG',rag.voc_no,lag.voc_no) 'Agmt No',rep.rtype 'Agmt Type',outveh.fleet_no 'Out Fleet No',outveh.reg_no"+
						" 'Out Reg No',date_format(rep.odate,'%d.%m.%Y') 'Out Date',rep.otime 'Out Time',round(rep.okm,2) 'Out Km',CASE WHEN rep.ofuel=0.000 THEN 'Level 0/8' WHEN "+
						" rep.ofuel=0.125 THEN 'Level 1/8' WHEN rep.ofuel=0.250 THEN 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN rep.ofuel=0.625 THEN "+
						" 'Level 5/8'  WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  else '' END "+
						" 'Out Fuel',convert(coalesce(inveh.fleet_no,''),char(25)) 'In Fleet No',convert(coalesce(inveh.reg_no,''),char(25)) 'In Reg No',convert(coalesce(date_format(rep.indate,'%d.%m.%Y'),''),char(25)) 'In Date',coalesce(rep.intime,'') "+
						" 'In Time',convert(coalesce(round(rep.inkm,2),''),char(25)) 'In Km',CASE WHEN rep.infuel=0.000 THEN 'Level 0/8' WHEN rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN "+
						" 'Level 2/8' WHEN rep.infuel=0.375 THEN 'Level 3/8' WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  WHEN"+
						" rep.infuel=0.750 THEN 'Level 6/8' WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 THEN 'Level 8/8'  else '' END 'In Fuel',"+
						" convert(coalesce(date_format(rep.cldate,'%d.%m.%Y'),''),char(25)) 'Col Date',coalesce(rep.cltime,'') 'Col Time',convert(coalesce(round(rep.clkm,2),''),char(25)) 'Col Km',CASE WHEN rep.clfuel=0.000 THEN 'Level 0/8' WHEN "+
						" rep.clfuel=0.125 THEN 'Level 1/8' WHEN rep.clfuel=0.250 THEN 'Level 2/8' WHEN rep.clfuel=0.375 THEN 'Level 3/8' WHEN rep.clfuel=0.500 THEN "+
						" 'Level 4/8' WHEN rep.clfuel=0.625 THEN 'Level 5/8'  WHEN rep.clfuel=0.750 THEN 'Level 6/8' WHEN rep.clfuel=0.875 THEN 'Level 7/8' WHEN "+
						" rep.clfuel=1.000 THEN 'Level 8/8'  else '' END 'Col Fuel',convert(coalesce(date_format(rep.deldate,'%d.%m.%Y'),''),char(25)) 'Del Date',coalesce(rep.deltime,'') 'Del Time',convert(coalesce(round(rep.delkm,2),''),char(25)) "+
						" 'Del Km',CASE WHEN rep.delfuel=0.000 THEN 'Level 0/8' WHEN rep.delfuel=0.125 THEN 'Level 1/8' WHEN rep.delfuel=0.250 THEN 'Level 2/8'"+
						" WHEN rep.delfuel=0.375 THEN 'Level 3/8' WHEN rep.delfuel=0.500 THEN 'Level 4/8' WHEN rep.delfuel=0.625 THEN 'Level 5/8'  WHEN"+
						" rep.delfuel=0.750 THEN 'Level 6/8' WHEN rep.delfuel=0.875 THEN 'Level 7/8' WHEN rep.delfuel=1.000 THEN 'Level 8/8'  else '' END"+
						" 'Del Fuel',    rep.delkm - rep.okm AS 'delconkm',rep.inkm - rep.clkm AS 'colconkm'  from gl_vehreplace rep left join gl_ragmt rag on (rep.rtype='RAG' and rep.rdocno=rag.doc_no) left join gl_rtarif tarif"+
						" on (rag.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_lagmt lag on (rep.rtype='LAG' and rep.rdocno=lag.doc_no) left join "+
						" gl_vehmaster inveh on (rep.rfleetno=inveh.fleet_no) left join gl_vehmaster outveh on (rep.ofleetno=outveh.fleet_no) left join my_brch agmtbr on "+
						" (if(rep.rtype='RAG',rag.brhid=agmtbr.doc_no,lag.brhid=agmtbr.doc_no)) left join my_brch bc on rep.obrhid=bc.doc_no where rep.status=3"+sqltest;
//			System.out.println(strSql);
				ResultSet resultSet = stmtRep.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmtRep.close();
		}
		catch(Exception e){
			e.printStackTrace();
		    return RESULTDATA;
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}






	public  ClsReplaceListBean getPrintDetails(String fromdate,String todate,String branch,String repstatus,String repreason,String reptype,String agmttype,String agmtbranch,String agmtno,String rentaltype,String agmtstatus) throws SQLException {
		// TODO Auto-generated method stub
		java.sql.Date sqlfromdate=null;
		java.sql.Date sqltodate=null;
		Connection conn=null;
		String sqltest="";
		ClsReplaceListBean bean=new ClsReplaceListBean();
		HttpServletRequest request=ServletActionContext.getRequest();
		try{
			conn=ClsConnection.getMyConnection();
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			
			if(sqlfromdate!=null){
				sqltest+=" and rep.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and rep.date<='"+sqltodate+"'";
			}
			if(!repstatus.equalsIgnoreCase("")){
				sqltest+=" and rep.closestatus="+repstatus;
			}
			
			if(!reptype.equalsIgnoreCase("")){
				sqltest+=" and rep.reptype='"+reptype+"'";
			}
			
			if(!repreason.equalsIgnoreCase("")){
				sqltest+=" and rep.trancode='"+repreason+"'";
			}
			
			if(!agmttype.equalsIgnoreCase("")){
				sqltest+=" and rep.rtype='"+agmttype+"'";
			}
			
			if(!agmtno.equalsIgnoreCase("")){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqltest+=" and rag.voc_no="+agmtno;
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					sqltest+=" and lag.voc_no="+agmtno;
				}
			}
			
			if(!rentaltype.equalsIgnoreCase("")){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqltest+=" and tarif.rentaltype='"+rentaltype+"'";
				}
			}
			
			if(!agmtbranch.equalsIgnoreCase("")){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqltest+=" and rag.brhid="+agmtbranch;
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					sqltest+=" and lag.brhid="+agmtbranch;
				}
			}
			if(!agmtstatus.equalsIgnoreCase("")){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqltest+=" and rag.clstatus="+agmtstatus;
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					sqltest+=" and lag.clstatus="+agmtstatus;
				}
			}
			
			String strsql="select comp.company,comp.address,comp.tel,comp.fax,loc.loc_name location,br.branchname,case when rep.trancode='GM' then 'Garage Maintenance' when rep.trancode='GA' then 'Garage Accident' when rep.trancode='GS' then "+
					" 'Garage Service' when rep.trancode='NS' then 'Not Satisfied' when rep.trancode='OT' then 'Others' else '' end replacereason,case when "+
					" rep.reptype='atbranch' then 'At Branch' when rep.reptype='collection' then 'Collection' else '' end replacetype,agmtbr.branchname agmtbranch,"+
					" rep.doc_no repno,if(rtype='RAG',rag.voc_no,lag.voc_no) agmtno,rep.rtype agmttype,outveh.fleet_no outfleetno,outveh.reg_no"+
					" outfleetreg,date_format(rep.odate,'%d.%m.%Y') outdate,rep.otime outtime,round(rep.okm,2) outkm,CASE WHEN rep.ofuel=0.000 THEN 'Level 0/8' WHEN "+
					" rep.ofuel=0.125 THEN 'Level 1/8' WHEN rep.ofuel=0.250 THEN 'Level 2/8' WHEN rep.ofuel=0.375 THEN 'Level 3/8' WHEN rep.ofuel=0.500 THEN 'Level 4/8' WHEN rep.ofuel=0.625 THEN "+
					" 'Level 5/8'  WHEN rep.ofuel=0.750 THEN 'Level 6/8' WHEN rep.ofuel=0.875 THEN 'Level 7/8' WHEN rep.ofuel=1.000 THEN 'Level 8/8'  else '' END "+
					" outfuel,convert(coalesce(inveh.fleet_no,''),char(25)) infleetno,convert(coalesce(inveh.reg_no,''),char(25)) infleetreg,convert(coalesce(date_format(rep.indate,'%d.%m.%Y'),''),char(25)) indate,coalesce(rep.intime,'') "+
					" intime,convert(coalesce(round(rep.inkm,2),''),char(25)) inkm,CASE WHEN rep.infuel=0.000 THEN 'Level 0/8' WHEN rep.infuel=0.125 THEN 'Level 1/8' WHEN rep.infuel=0.250 THEN "+
					" 'Level 2/8' WHEN rep.infuel=0.375 THEN 'Level 3/8' WHEN rep.infuel=0.500 THEN 'Level 4/8' WHEN rep.infuel=0.625 THEN 'Level 5/8'  WHEN"+
					" rep.infuel=0.750 THEN 'Level 6/8' WHEN rep.infuel=0.875 THEN 'Level 7/8' WHEN rep.infuel=1.000 THEN 'Level 8/8'  else '' END infuel,"+
					" convert(coalesce(date_format(rep.cldate,'%d.%m.%Y'),''),char(25)) coldate,coalesce(rep.cltime,'') coltime,convert(coalesce(round(rep.clkm,2),''),char(25)) colkm,CASE WHEN rep.clfuel=0.000 THEN 'Level 0/8' WHEN "+
					" rep.clfuel=0.125 THEN 'Level 1/8' WHEN rep.clfuel=0.250 THEN 'Level 2/8' WHEN rep.clfuel=0.375 THEN 'Level 3/8' WHEN rep.clfuel=0.500 THEN "+
					" 'Level 4/8' WHEN rep.clfuel=0.625 THEN 'Level 5/8'  WHEN rep.clfuel=0.750 THEN 'Level 6/8' WHEN rep.clfuel=0.875 THEN 'Level 7/8' WHEN "+
					" rep.clfuel=1.000 THEN 'Level 8/8'  else '' END colfuel,convert(coalesce(date_format(rep.deldate,'%d.%m.%Y'),''),char(25)) deldate,coalesce(rep.deltime,'') deltime,convert(coalesce(round(rep.delkm,2),''),char(25)) "+
					" delkm,CASE WHEN rep.delfuel=0.000 THEN 'Level 0/8' WHEN rep.delfuel=0.125 THEN 'Level 1/8' WHEN rep.delfuel=0.250 THEN 'Level 2/8'"+
					" WHEN rep.delfuel=0.375 THEN 'Level 3/8' WHEN rep.delfuel=0.500 THEN 'Level 4/8' WHEN rep.delfuel=0.625 THEN 'Level 5/8'  WHEN"+
					" rep.delfuel=0.750 THEN 'Level 6/8' WHEN rep.delfuel=0.875 THEN 'Level 7/8' WHEN rep.delfuel=1.000 THEN 'Level 8/8'  else '' END"+
					" delfuel from gl_vehreplace rep left join gl_ragmt rag on (rep.rtype='RAG' and rep.rdocno=rag.doc_no) left join gl_rtarif tarif"+
					" on (rag.doc_no=tarif.rdocno and tarif.rstatus=5) left join gl_lagmt lag on (rep.rtype='LAG' and rep.rdocno=lag.doc_no) left join "+
					" gl_vehmaster inveh on (rep.rfleetno=inveh.fleet_no) left join gl_vehmaster outveh on (rep.ofleetno=outveh.fleet_no) left join my_brch agmtbr on "+
					" (if(rep.rtype='RAG',rag.brhid=agmtbr.doc_no,lag.brhid=agmtbr.doc_no)) left join my_brch br on rep.rbrhid=br.doc_no left join my_locm loc on "+
					" loc.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no where rep.status=3"+sqltest+" group by rep.doc_no";
			
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			ArrayList<String> printarray=new ArrayList<>();
			while(rs.next()){
				String temp=rs.getString("repno")+"::"+rs.getString("replacereason")+"::"+rs.getString("replacetype")+"::"+rs.getString("agmtno")+"::"+
				rs.getString("agmttype")+"::"+rs.getString("outfleetno")+"::"+rs.getString("outfleetreg")+"::"+rs.getString("outdate")+"::"+
				rs.getString("outtime")+"::"+rs.getString("outkm")+"::"+rs.getString("outfuel")+"::"+rs.getString("infleetno")+"::"+rs.getString("infleetreg")+"::"+
				rs.getString("indate")+"::"+rs.getString("intime")+"::"+rs.getString("inkm")+"::"+rs.getString("infuel");
				printarray.add(temp);
				bean.setLblcompname(rs.getString("company"));
				bean.setLblcompaddress(rs.getString("address"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblbranch(rs.getString("branchname"));
			}
			request.setAttribute("REPPRINT",printarray);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return bean;
	}

	
	
}
