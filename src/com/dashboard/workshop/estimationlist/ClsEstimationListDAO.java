package com.dashboard.workshop.estimationlist;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsEstimationListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
	
	public  JSONArray masterdetails(String brach,String fromdate,String todate,String check,String client) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        String sqltest="";String sqltest1="";String sqltest2="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
       
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		
     	}
        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		
     	}
       
    	if(!(client.equalsIgnoreCase("0") || (client.equalsIgnoreCase("")) || (client.equalsIgnoreCase("undefined")))){
			sqltest1+="and mac.cldocno="+client+"";
        }
    	if(!((brach.equalsIgnoreCase("a")) && !(brach.equalsIgnoreCase("NA")))){
     		sqltest1+=" and em.brhid="+brach+"";
		}
     	
    
     	
		try {
				 conn = objconn.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced // POS -traffic posted RES - Received
				  
				  
				//  System.out.println("-----code------");
			
			String sql="select job.voc_no,concat(gp.regno,'-',gp.pltid) vehno,em.voc_no estvocno,gp.voc_no gatevocno,gp.processstatus,gp.kmin,b.branchname,concat(em.header,' - ',em.notes ,' - ',em.internalremarks) jobdesc, "
					+ " em.nettotal+coalesce(eadd.tot,0) nettotal,em.brhid,em.gipno,convert(em.date,date) date,em.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no  gateinpassdocno from ws_estm em "
					+ "left join ws_gateinpass gp on (em.gipno=gp.doc_no) "
					+ " left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM') "
					+ "left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no) "
					+ "left join gl_yom yom on gp.yom=yom.doc_no "
					+ "left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no) "
					+ "left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no "
					+ "left join my_brch b on b.doc_no=em.brhid "
					+ "left join (select sum(sparenettotal+netservices) tot,estdocno from ws_estmadd group by estdocno) eadd on eadd.estdocno=em.doc_no where  em.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+"   group by em.doc_no ";
			System.out.println("-----estimationlist----detail--"+sql);

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
	
	 public JSONArray clentdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = objconn.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
					String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' and pcase=0 ";

				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=objcommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
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
