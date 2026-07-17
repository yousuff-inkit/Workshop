package com.dashboard.serviceandmaintenance.servicedue;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsServiceDue  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray servicedueGridLoading(String branch,String avgkm,String uptodate) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
	
        java.sql.Date sqlUpToDate = null;
		int avgkms=Integer.parseInt(avgkm);
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtChqUpdate = conn.createStatement();
			  
		        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
		        String sql="";
			    String sqltest = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    	sqltest+=" and v.brhid="+branch+"";
	    		}
			
			    
	  sql = "select CONVERT(concat(v.reg_no,'-',v.pltid),CHAR(50)) regplt,v.fleet_no fleetno,v.flname fleetname,"
	 + "CASE WHEN vm.rdtype='RAG' THEN rag.voc_no WHEN  vm.rdtype='LAG' THEN lag.voc_no else vm.rdocno  END as 'refno',"
	 + "vm.rdtype reftype,coalesce(ac.refname,'') client,coalesce(ac.per_mob,ac.com_mob,'') mobno,"
	 + "v.lst_srv lstservicekm,v.srvc_km nxtservicekm,v.cur_km curkm from gl_vehmaster v "
	 + "inner join gl_vmove vm on vm.fleet_no=v.fleet_no "
	 + "inner join (select max(doc_no) docno,fleet_no from gl_vmove group by fleet_no) a on vm.doc_no=a.docno and vm.fleet_no=a.fleet_no "
	 + "left join gl_ragmt rag on vm.rdocno=rag.doc_no and vm.rdtype='RAG' "
	 + "left join gl_lagmt lag on vm.rdocno=lag.doc_no and vm.rdtype='LAG' "
	 + "left join my_acbook ac on ac.cldocno=vm.emp_id and vm.emp_type='CRM' "
	 + "where (v.lst_srv+(DATEDIFF('"+sqlUpToDate+"',v.srvc_dte)*("+avgkms+"/3))) > v.srvc_km "+sqltest+" group by v.fleet_no";
			//System.out.println("queryy=="+sql);    
			    ResultSet resultSet = stmtChqUpdate.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtChqUpdate.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
		
}