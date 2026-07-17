package com.dashboard.integration.clientfinancials;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsClientFinancialsDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public JSONArray getInvoiceData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray invoicedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return invoicedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and invm.brhid="+branch;
			}
			if(sqlfromdate!=null){
				sqltest+=" and invm.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and invm.date<='"+sqltodate+"'";
			}
			Statement stmt=conn.createStatement();
			String str="select invm.doc_no invdocno,invm.voc_no invvocno,invm.date invdate,ac.refernceno acrefno,ac.refname,veh.reg_no,veh.ch_no chassisno,"+
			" sum(invd.amount) amount from gl_invm invm left join gl_invd invd on invm.doc_no=invd.rdocno  left join gl_ragmt agmt on (invm.ratype='RAG' and "+
			" invm.rano=agmt.doc_no) left join my_acbook ac on (invm.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no "+
			" where invm.exportstatus=0 and invm.status=3 "+sqltest+" group by invm.doc_no";
			ResultSet rs=stmt.executeQuery(str);
			invoicedata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicedata;
	}
	
	public JSONArray getInvoiceExcelData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray invoicedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return invoicedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and invm.brhid="+branch;
			}
			if(sqlfromdate!=null){
				sqltest+=" and invm.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and invm.date<='"+sqltodate+"'";
			}
			Statement stmt=conn.createStatement();
			String str="select invm.voc_no 'Invoice No',date_format(invm.date,'%d-%m-%y') 'Invoice Date',ac.refernceno 'MK No',ac.refname 'Customer Name',veh.reg_no 'Vehicle Reg No',veh.ch_no 'Chassis No',"+
			" sum(invd.amount) 'Amount Invoiced' from gl_invm invm left join gl_invd invd on invm.doc_no=invd.rdocno  left join gl_ragmt agmt on (invm.ratype='RAG' and "+
			" invm.rano=agmt.doc_no) left join my_acbook ac on (invm.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no "+
			" where invm.exportstatus=0 and invm.status=3 "+sqltest+" group by invm.doc_no";
			System.out.println(str);
			ResultSet rs=stmt.executeQuery(str);
			invoicedata=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicedata;
	}
	
	public JSONArray getRentalRecieptData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray invoicedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return invoicedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and rent.brhid="+branch;
			}
			if(sqlfromdate!=null){
				sqltest+=" and rent.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and rent.date<='"+sqltodate+"'";
			}
			Statement stmt=conn.createStatement();
			String str="select rent.srno recieptno,rent.date recieptdate,ac.refernceno acrefno,ac.refname,veh.reg_no,veh.ch_no"+
			" chassisno,rent.netamt amount,card.mode paymenttype from gl_rentreceipt rent left join gl_ragmt agmt on (rent.rtype='RAG' and rent.aggno=agmt.doc_no) left join my_acbook ac on"+
			" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join my_cardm card on"+
			" (rent.paytype=card.doc_no and card.dtype='mode') where rent.status=3 and rent.exportstatus=0 "+sqltest;
			System.out.println(str);
			ResultSet rs=stmt.executeQuery(str);
			invoicedata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicedata;
	}
	
	public JSONArray getRentalRecieptExcelData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray invoicedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return invoicedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and rent.brhid="+branch;
			}
			if(sqlfromdate!=null){
				sqltest+=" and rent.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and rent.date<='"+sqltodate+"'";
			}
			Statement stmt=conn.createStatement();
			String str="select rent.srno 'Reciept No',date_format(rent.date,'%d-%m-%y') 'Reciept Date' ,ac.refernceno 'MK No',ac.refname 'Customer Name',"+
			" veh.reg_no 'Vehicle Reg No',veh.ch_no 'Chassis No', rent.netamt 'Amount Collected',card.mode 'Payment  Type' from gl_rentreceipt rent left join "+
			" gl_ragmt agmt on (rent.rtype='RAG' and rent.aggno=agmt.doc_no) left join my_acbook ac on"+
			" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join my_cardm card on"+
			" (rent.paytype=card.doc_no and card.dtype='mode') where rent.status=3 and rent.exportstatus=0 "+sqltest;
			System.out.println(str);
			ResultSet rs=stmt.executeQuery(str);
			invoicedata=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicedata;
	}
}
