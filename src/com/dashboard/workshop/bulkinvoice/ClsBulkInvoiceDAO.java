package com.dashboard.workshop.bulkinvoice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsBulkInvoiceDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getAmountData(String cldocno,String id,String branch,String date)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and gip.brhid="+branch;
			}
			if(!date.equalsIgnoreCase("") && date!=null){
				java.sql.Date sqldate=null;
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and gip.date<='"+sqldate+"'";
			}
			
			String strsql="select job.voc_no jobvocno,inv.brhid invbrhid,calc.rowno, calc.jobdocno, calc.billtoacno,head.description acname, calc.claimno, calc.description, round(calc.amount,2) amount, "+
			" round(calc.discount,2) discount, round(calc.netamount,2) net, round(calc.vatamount,2) vat, round(calc.totalamount,2) total, round(calc.excessamount,2) excess,round(calc.roundoff,2) roundoff, round(calc.netbill,2) netbill , calc.invno, "+
			" calc.confirmstatus, calc.insurstatus from ws_invcalctemp calc left join my_head head on calc.billtoacno=head.doc_no left join ws_invm inv on inv.doc_no=calc.invno "+
			" left join ws_jobcard job on (calc.jobdocno=job.doc_no)"+
			" left join ws_estm est on est.doc_no=job.refno and job.reftype='EST'"+
			" left join ws_gateinpass gip on gip.doc_no=est.gipno"+
			" left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM' where coalesce(calc.invno,0)=0 and head.cldocno="+cldocno+" "+sqltest;
			
			System.out.println("=== "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
}
