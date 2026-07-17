package com.dashboard.serviceandmaintenance.accidentsreported;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccidentsReportedDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getAccidentsReported(String branchvalue) throws SQLException {
		
       Connection conn=null;
        JSONArray RESULTDATA=new JSONArray();
		try {
				String sqltest="";
				  if(!((branchvalue.equalsIgnoreCase("a")) || (branchvalue.equalsIgnoreCase("NA")))){
					sqltest=" and insp.brhid="+branchvalue+"";
				}
				 conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard = conn.createStatement ();
				
				String strSql="select veh.reg_no,ac.refname,'Edit' btnsave,'Verify' btnclear,insp.brhid,insp.polrep report,insp.acdate accdate,insp.coldate collectdate,insp.place,insp.fine "+
				"  accfines,insp.remarks,if(insp.claim=1,'Own','Third Party') claim,insp.doc_no docno,insp.reftype from gl_vinspm insp left join gl_ragmt agmt on "+
				" (insp.reftype='RAG' and insp.refdocno=agmt.doc_no) left join gl_lagmt lagmt on (insp.reftype='LAG' and insp.refdocno=lagmt.doc_no) left join gl_nrm nrm on"+
				" (insp.reftype='NRM' and insp.refdocno=nrm.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
				" left join gl_ragmt reprag on (insp.reftype='RPL' and rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on "+
				" (insp.reftype='RPL' and rep.rtype='LAG' and rep.rdocno=replag.doc_no) left join my_acbook ac on ((case when insp.reftype='RAG' then agmt.cldocno when "+
				" insp.reftype='LAG' then lagmt.cldocno when insp.reftype='RPL' and rep.rtype='RAG' then reprag.cldocno when insp.reftype='RPL' and rep.rtype='LAG' then "+
				" replag.cldocno else 0 end)=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on insp.rfleet=veh.fleet_no where insp.accident=1 and insp.status<>7 and insp.clacc=0"+sqltest; 
            	
            	//System.out.println("Damage Reported Sql:"+strSql);
             	ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
				stmtDashBoard.close();
				conn.close();
				   return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return RESULTDATA;
		}
        
    }
}
