package com.dashboard.operations.insplist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInspListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray getInspList(String cmbbranch,String fromdate,String todate,String cmbreftype,String cmbagmtbranch,String refdocno,String client,String cmbtype,String cmbinvoicetype,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			
		try {	
				java.sql.Date sqlfromdate=null;
				java.sql.Date sqltodate=null;
				String sqltest="";
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				conn=ClsConnection.getMyConnection();
				Statement stmtInsp = conn.createStatement();
				if(sqlfromdate!=null){
					sqltest+=" and insp.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and insp.date<='"+sqltodate+"'";
				}
				if(!cmbreftype.equalsIgnoreCase("")){
					sqltest+=" and insp.reftype='"+cmbreftype+"'";
				}
				if(!refdocno.equalsIgnoreCase("")){
					sqltest+=" and insp.refdocno="+refdocno;
				}
				if(!client.equalsIgnoreCase("")){
					sqltest+=" and ac.cldocno="+client;
				}
				if(!cmbtype.equalsIgnoreCase("")){
					if(cmbtype.equalsIgnoreCase("ACC")){
						sqltest+=" and insp.accident=1";
					}
					else if(cmbtype.equalsIgnoreCase("DMG")){
						sqltest+=" and insp.accident=0";
					}
				}
				if(!cmbinvoicetype.equalsIgnoreCase("")){
					if(cmbinvoicetype.equalsIgnoreCase("1")){
						sqltest+=" and insp.invno<>0";
					}
					else if(cmbinvoicetype.equalsIgnoreCase("0")){
						sqltest+=" and insp.invno=0";
					}
				}
				if(!cmbbranch.equalsIgnoreCase("") && !cmbbranch.equalsIgnoreCase("a")){
					sqltest+=" and insp.brhid="+cmbbranch;
				}
				String strSql="select inv.voc_no invvocno,if(insp.accident=1,'Accident','Damage') type,insp.invtype,convert(coalesce(if(insp.invtype='INV',inv.voc_no,insp.invno),''),char(15)) invno,case when insp.reftype='RAG'then rag.voc_no when insp.reftype='LAG' then lag.voc_no else insp.refdocno end refvocno,veh.flname "+
				" fleet,veh.reg_no,case when insp.reftype='NRM' and nrm.drid<>0 then 'DRV' when insp.reftype='NRM' and nrm.staffid<>0 then 'STF' else insp.reftype end"+
				" clienttype,insp.doc_no,insp.date,insp.reftype,round(insp.amount,2) amount,coalesce(insp.polrep,'') policereport,convert(coalesce(insp.acdate,''),char(25)) "+
				" accdate,round(insp.fine,2) insurexcess,case when insp.reftype='NRM' and nrm.drid<>0 then drv.sal_name when insp.reftype='NRM' and"+
				" nrm.staffid<>0 then stf.sal_name else ac.refname end client from gl_vinspm insp  left join gl_vehmaster veh  on (insp.rfleet=veh.fleet_no) left join"+
				" gl_ragmt rag on (insp.reftype='RAG' and insp.refdocno=rag.doc_no) left join gl_lagmt lag on (insp.reftype='LAG' and insp.refdocno=lag.doc_no) left join "+
				" gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no) left join gl_ragmt reprag on (rep.rtype='RAG' and rep.rdocno=reprag.doc_no) "+
				" left join gl_lagmt replag on (rep.rtype='LAG' and rep.rdocno=replag.doc_no) left join gl_nrm nrm on (insp.reftype='NRM' and insp.refdocno=nrm.doc_no) "+
				" left join my_acbook ac on (case when insp.reftype='RAG' then rag.cldocno=ac.cldocno when insp.reftype='LAG' then lag.cldocno=ac.cldocno when "+
				" insp.reftype='RPL' and rep.rtype='RAG' then reprag.cldocno=ac.cldocno when insp.reftype='RPL' and rep.rtype='LAG' then replag.cldocno=ac.cldocno end "+
				" and ac.dtype='CRM') left join my_salesman drv on (nrm.drid=drv.doc_no and drv.sal_type='DRV') left join my_salesman stf on (nrm.staffid=stf.doc_no"+
				" and stf.sal_type='STF') left join gl_invm inv on (insp.invtype='INV' and insp.invno=inv.doc_no and insp.invno<>0 ) where 1=1"+sqltest;
//				System.out.println(strSql);
				ResultSet resultSet = stmtInsp.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtInsp.close();
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

}
