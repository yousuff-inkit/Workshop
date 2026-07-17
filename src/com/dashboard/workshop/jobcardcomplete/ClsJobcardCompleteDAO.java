package com.dashboard.workshop.jobcardcomplete;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobcardCompleteDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon commonDAO = new ClsCommon();
	
	public JSONArray getJobcardData(String clientname,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			String sqltest="";
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqltodate=commonDAO.changeStringtoSqlDate(todate);
				sqltest+=" and jc.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			
			
			String sqlqry="select jc.doc_no doc_no, jc.date date, jc.reftype reftype, jc.refno refno, jc.brhid brhid, convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Regno: ',coalesce(gp.regno,''),' Plate code: ',coalesce(plate.code_name,''),' ', "+
					"coalesce(yom.yom,''),' Others: ',coalesce(gp.vehother,'')),char(200)) vehicledetails, concat(ac.refname,' , Address: ',ac.address, "+
					"' , Telephone: ',ac.per_tel,' , Mobile: ', ac.per_mob,' , Mail: ',ac.mail1,' , Contact Person ',ac.contactperson) userdetails, 'View' as btnview from "+
					"ws_jobcard jc left join ws_estm es on (jc.refno=es.doc_no and jc.reftype='EST') "+
					"left join ws_gateinpass gp on((jc.refno=gp.doc_no and jc.reftype='GIP') or (es.gipno=gp.doc_no and jc.reftype='EST'))"+
					
					"left join my_acbook ac on (gp.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gp.pltid=plate.doc_no "+
					"left join gl_vehbrand brd on(gp.brdid=brd.doc_no) left join gl_vehmodel model on brd.doc_no=gp.modid "+
					"left join gl_yom yom on gp.yom=yom.doc_no where jc.status=3 and jc.complete=0"+sqltest;
			
			System.out.println(clientname+"+++++"+sqlqry);
			
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=commonDAO.convertToJSON(resultSet);
			
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
	
	
	public JSONArray clientData(String clientname,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
		
		Connection conn =null;
        
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
        	
			String sqltest="";
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and refname like '%"+clientname+"%'";
			}
			String sqlqry= "select refname clientname,cldocno from my_acbook where dtype='CRM' and status='3'"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=commonDAO.convertToJSON(resultSet);
			
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
