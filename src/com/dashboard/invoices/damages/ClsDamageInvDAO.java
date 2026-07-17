package com.dashboard.invoices.damages;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDamageInvDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray damageInvSearch(String branchval) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				String strsql="";
				if(!branchval.equalsIgnoreCase("a") && !branchval.equalsIgnoreCase("")){
         /*   		strsql= "select  inspm.doc_no,inspm.date,inspm.type,inspm.reftype,inspm.refdocno,inspm.refvoucherno,inspm.rfleet,inspm.amount,inspm.brhid,br.curid,"
            				+ " if(inspm.reftype='RAG',ac.cldocno,ac2.cldocno) cldocno,if(inspm.reftype='RAG',ac.acno,ac2.acno) acno "
            				+ " from gl_vinspm inspm left join gl_ragmt ragmt on (inspm.refdocno=ragmt.doc_no and reftype='RAG') left join gl_lagmt lagmt "
            				+ " on (inspm.refdocno=lagmt.doc_no and reftype='LAG') left join my_acbook ac on (ragmt.cldocno=ac.cldocno and ac.dtype='CRM') "
            				+ " left join my_acbook ac2 on (lagmt.cldocno=ac2.cldocno and ac2.dtype='CRM') left join my_brch br on inspm.brhid=br.doc_no "
            				+ " where inspm.status<>7  and inspm.amount>0 and inspm.invno=0 and (inspm.accident=0 or (inspm.accident=1 and inspm.clacc=1)) "
            				+ " and inspm.brhid="+branchval+" group by inspm.doc_no";   */
							
					strsql="select ac.refname, inspm.fine accfines,veh.reg_no,inspm.invno,inspm.doc_no,inspm.date,inspm.type,inspm.reftype,inspm.refdocno,inspm.refvoucherno,inspm.rfleet,inspm.amount,"+
				" inspm.brhid,br.curid,ac.cldocno,ac.acno from gl_vinspm inspm left join gl_ragmt ragmt on (inspm.refdocno=ragmt.doc_no and inspm.reftype='RAG') left join "+
				" gl_lagmt lagmt on (inspm.refdocno=lagmt.doc_no and inspm.reftype='LAG') left join gl_vehreplace rep on (inspm.refdocno=rep.doc_no and"+
				" inspm.reftype='RPL') left join gl_ragmt reprag on (rep.rdocno=reprag.doc_no and rep.rtype='RAG') left join gl_lagmt replag on"+
				" (rep.rdocno=replag.doc_no and rep.rtype='LAG') left join my_acbook ac on (case when inspm.reftype='RAG' then"+
				" (ragmt.cldocno=ac.cldocno and ac.dtype='CRM') when inspm.reftype='LAG' then (lagmt.cldocno=ac.cldocno and ac.dtype='CRM')"+
				" when (inspm.reftype='RPL' and rep.rtype='RAG') then (reprag.cldocno=ac.cldocno and ac.dtype='CRM') when"+
				" (inspm.reftype='RPL' and rep.rtype='LAG') then (replag.cldocno=ac.cldocno and ac.dtype='CRM') else 0 end) left join my_brch br"+
				" on inspm.brhid=br.doc_no left join gl_vehmaster veh on inspm.rfleet=veh.fleet_no where inspm.status<>7  and (inspm.amount>0 or inspm.fine>0) and inspm.invno=0  "+
				" and inspm.brhid="+branchval+" and inspm.reftype<> 'NRM' group by inspm.doc_no";
					
					System.out.println("======= "+strsql);
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				else{
					stmtVeh.close();
					return RESULTDATA;
				}
            	//System.out.println("Damage Sql:"+strsql);
            		
 				stmtVeh.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }


}
