package com.dashboard.operations.repcancel;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsRepCancelDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray getReplaceData(String fromdate,String todate,String agmtno,String fleetno,String mode,String agmttype,String branch) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		
		 Connection conn=null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtReplace = conn.createStatement();
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			if(!agmttype.equalsIgnoreCase("")){
				sqltest+=" and rep.rtype='"+agmttype+"'";
			}
			if(!agmtno.equalsIgnoreCase("")){
				/*sqltest+=" and rep.rtype='"+agmtno+"'";*/
			}
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and rep.ofleetno="+fleetno+"";
			}
			if(sqlfromdate!=null && sqltodate!=null){
				sqltest+=" and rep.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("0") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and rep.rbrhid="+branch;
			}
			String strSql="select rep.doc_no repno,rep.date repdate,rep.rtype agmttype,rep.rdocno agmtno,if(rep.rtype='RAG',rag.voc_no,lag.voc_no) agmtvocno,ac.refname,rep.ofleetno fleet_no,veh.reg_no,rep.odate dout,rep.otime tout,"+
					" CASE WHEN rep.ofuel='0.000' THEN 'Level 0/8' WHEN rep.ofuel='0.125' THEN 'Level 1/8' WHEN rep.ofuel='0.250' THEN 'Level 2/8' WHEN rep.ofuel='0.375' "+
					" THEN 'Level 3/8' WHEN rep.ofuel='0.500' THEN 'Level 4/8' WHEN rep.ofuel='0.625' THEN 'Level 5/8'  WHEN rep.ofuel='0.750' THEN 'Level 6/8' WHEN "+
					" rep.ofuel='0.875' THEN 'Level 7/8' WHEN rep.ofuel='1.000' THEN 'Level 8/8'  END as  fout,rep.okm kmout,br.branchname outbranch,loc.loc_name outlocation from gl_vehreplace rep left join gl_ragmt rag on (rep.rtype='RAG' and"+
					" rep.rdocno=rag.doc_no) left join gl_lagmt lag on (rep.rtype='LAG' and rep.rdocno=lag.doc_no) left join my_acbook ac on"+
					" (if(rep.rtype='RAG',rag.cldocno=ac.cldocno,lag.cldocno=ac.cldocno)) left join gl_vehmaster veh on rep.ofleetno=veh.fleet_no"+
					" left join my_brch br on rep.obrhid=br.doc_no left join my_locm loc on rep.olocid=loc.doc_no where rep.closestatus=0"+
					" "+sqltest+" group by rep.doc_no";
        	//System.out.println(strSql);
			ResultSet resultSet = stmtReplace.executeQuery(strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtReplace.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	
	    return RESULTDATA;
	}
}
