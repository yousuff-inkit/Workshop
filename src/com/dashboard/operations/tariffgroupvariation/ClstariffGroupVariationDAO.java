package com.dashboard.operations.tariffgroupvariation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClstariffGroupVariationDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray gettariffgroupdata(String branch,String fromdate,String todate,String agmtno,String cldocno,String temp) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			
			conn=ClsConnection.getMyConnection();
			if(!temp.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Statement stmtsales=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String strSql="";
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
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and rep.rbrhid="+branch+"";
			}
			
			if(!agmtno.equalsIgnoreCase("")){
				
					sqltest+=" and ragmt.voc_no="+agmtno+"";
				
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno+"";
			}
			 strSql="select * from (select ragmt.voc_no,rep.doc_no,rep.rdocno refno,rep.rtype reftype,ragmt.fleet_no,agmtveh.reg_no fleetreg,ragmt.ofleet_no contractfleet,"+
					 " contractveh.reg_no contractfleetreg,rep.odate repdate,rep.otime reptime,rep.doc_no repno ,"
					 + " vhcontgrp.gname contvehgrpid,flvhgrp.gname fleetgrpid from gl_vehreplace rep left join gl_ragmt ragmt on (rep.rtype='RAG'   and rep.rdocno=ragmt.doc_no)"+
					 " left join gl_vehmaster agmtveh on ragmt.fleet_no=agmtveh.fleet_no left join gl_vehmaster contractveh on"+
					 " ragmt.ofleet_no=contractveh.fleet_no left join my_acbook ac on (ragmt.cldocno=ac.cldocno and ac.dtype='CRM')"
					 + " left join gl_vehgroup vhcontgrp on contractveh.vgrpid=vhcontgrp.doc_no "
					 + "left join gl_vehgroup flvhgrp on agmtveh.vgrpid=flvhgrp.doc_no where rep.closestatus=1"+
					 " and rep.rtype='RAG' "+sqltest+" and ragmt.fleet_no<>ragmt.ofleet_no and"+
					 " ragmt.clstatus=0 and rep.doc_no in (select max(doc_no) from gl_vehreplace  group by rtype,rdocno)) a where a.contvehgrpid!=a.fleetgrpid";

		//	System.out.println("Check Query==="+strSql);
             	ResultSet resultSet = stmtsales.executeQuery(strSql);
             	
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				conn.close();
				
				   return RESULTDATA;
  
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
	public JSONArray getAgmtno(String branch,String client,String mobile,String rentalno,String fleetno,String regno,String mrano) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn=null;
		
		try{
			conn=ClsConnection.getMyConnection();
			String sqltest="";
			String strsql="";
			
				if(!(client.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and a.RefName like '%"+client+"%'";
		    	}
		    	if(!(mobile.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and a.per_mob like '%"+mobile+"%'";
		    	}
		    	if(!(rentalno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and r.voc_no like '%"+rentalno+"%'";
		    	}
		    	if(!(fleetno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and r.fleet_no like '%"+fleetno+"%'";
		    	}
		    	if(!(regno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
		    	}
		    	if(!(mrano.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and r.mrano like '%"+mrano+"%'";
		    	}
		    	if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
		    		sqltest=sqltest+" and r.brhid="+branch+"";
		    	}
		    	strsql="select r.doc_no,r.voc_no,r.fleet_no,r.cldocno, "
						+ " r.mrano,v.reg_no,a.RefName,a.per_mob from gl_ragmt r  "
						+ " left join gl_vehmaster v on v.fleet_no=r.fleet_no left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'  "
						+ " where r.status=3" +sqltest+"";
			
			Statement stmt=conn.createStatement();
			ResultSet resultSet = stmt.executeQuery (strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
