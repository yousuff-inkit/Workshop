package com.dashboard.workshop.gipupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsGIPUpdateDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public  JSONArray masterdetails(String fromdate,String todate,String check,String load,String client) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
        String sqltest="";String sqltest1="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		
     	}
        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		
     	}
    	if(!(client.equalsIgnoreCase("0") || client.equalsIgnoreCase("") || client.equalsIgnoreCase("undefined"))){
			sqltest1+="and ws.cldocno="+client+"";
        }
    	//System.out.println("load1------------------"+load);
        if(!(load.equalsIgnoreCase("undefined") || load.equalsIgnoreCase("") || load.equalsIgnoreCase("null") || load.equalsIgnoreCase("0")))
     	{
        	//System.out.println("load2------------------"+load);
        	if(load.equalsIgnoreCase("open")){
     		sqltest+="and ws.processstatus<8";
        	}else{
        	sqltest+="and ws.processstatus>=8";	
        	}
     	}
     		
     	
     	 
     	
		try {
				 conn = objconn.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				  System.out.println("-----code------");
			
			String sql="select ws.kmin,e.doc_no estdocno,e.voc_no estvocno,j.doc_no jobdocno,df.name srvpkg,dy.sal_name rfrby,ds.sal_name inssrvor,es.sal_name srvadvsr,ms.sal_name estimator,bc.refname insurcmpny,ws.doc_no doc_no,ws.voc_no voc_no,ws.doc_no gateinpassdoc,ws.date,ws.estdeltime time,gr.name reptype, ws.regno, ws.pltid pcode,vb.brand_name brand,vm.vtype model,datediff( CURRENT_TIMESTAMP, ws.DATE) gipdate,"
					+ "  ws.estdeldate expdelivery, ws.estdeltime dtime,ws.desc1 description,ws.username,ws.mobile, "
					+ " ur.user_name estimtdby,uw.user_name gipuser,e.date estdate,e.doc_no estimationno,e.voc_no estimationvocno,j.doc_no jobno,j.voc_no jobvocno,j.date jdate,us.user_name user,ac.refname customer, "
					+ "  ws.processstatus,if(((ep.rdocno is null) and (el.rdocno is null)) ,'approved','notapproved') approval,if(j.complete=1,'Completed','Not Completed') jstatus from ws_gateinpass ws"
					+ " left join ws_gartype gr on gr.row_no=ws.repairtype left join gl_vehbrand vb on vb.doc_no=ws.brdid "
					+ " left join gl_vehmodel vm on vm.doc_no=ws.modid left join ws_estm e on e.gipno=ws.doc_no "
					+ " left join ws_jobcard j on ((e.doc_no=j.refno and reftype='EST') or (ws.doc_no=j.refno and reftype='GIP')) "
					+ " left join my_user ur on ur.doc_no=e.userid"
					+ " left join my_user us on us.doc_no=j.userid"
					+ " left join my_user uw on uw.doc_no=ws.userid"
					+ " left join my_acbook ac on ac.cldocno=ws.cldocno and ac.dtype='CRM' "
					+ " left join my_acbook bc on bc.cldocno=ws.insurcldocno and bc.dtype='CRM' "
					+ " left join my_salesman ms on ms.doc_no=ws.marketingperson and ms.sal_type='WMP'"
					+ " left join my_salesman es on es.doc_no=ws.serviceadvisor and es.sal_type='WSA'"
					+ " left join my_salesman ds on ds.doc_no=ws.insurancesurvivor and ds.sal_type='WIS'"
					+ " left join my_salesman dy on dy.doc_no=ws.referencedby and dy.sal_type='WRB'"
					+ " left join ws_servicepackage df on df.doc_no=ws.servicepackage and df.status=3"
					+ " left join (select ep.rdocno,count(*) cnt from  ws_estspare ep where ep.approved=0 group by ep.rdocno) ep on e.doc_no=ep.rdocno"
					+ " left join (select el.rdocno,count(*) cnt from  ws_estlabour el where el.approved=0 group by el.rdocno) el on e.doc_no=el.rdocno where ws.date>='"+sqlfromdate+"' and ws.date<='"+sqltodate+"' "+sqltest1+" "+sqltest+"";
			System.out.println("-----gatelist----detail--"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVeh.close();
        conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
     	
		//System.out.println(RESULTDATA);
        return RESULTDATA;
     	
    }
}
