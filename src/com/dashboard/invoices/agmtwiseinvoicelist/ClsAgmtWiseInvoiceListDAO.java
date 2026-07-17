package com.dashboard.invoices.agmtwiseinvoicelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgmtWiseInvoiceListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
public JSONArray getMasterData(String branch,String fromdate,String todate,String cldocno,String cmbtype,String id) throws SQLException{
		
		JSONArray leasedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return leasedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and easy.cldocno="+cldocno;
			}
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and inv.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and inv.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and agmt.brhid="+branch;
			}
			String strsql="select easy.invtrno,ac.cldocno,head.account,head.description,count(easy.agmtno) agmtnocount,round(sum(easy.amount),2) amount,round(sum(easy.rentalamt),2) rentalamt,"+
			" round(sum(easy.accamt),2) accamt,round(sum(easy.insuramt),2) insuramt from gl_inveasylease easy inner join gl_invm inv on"+
			" (easy.invdocno=inv.doc_no) left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on"+
			" (ac.acno=head.doc_no) left join gl_lagmt agmt on (easy.agmtno=agmt.doc_no) where inv.status=3 "+sqltest+" group by easy.invtrno";
			
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			leasedata=objcommon.convertToJSON(rs);
			System.out.println(leasedata);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return leasedata;
	}

public JSONArray getDetailData(String cldocno,String invtrno,String fromdate,String todate,String branch,String id) throws SQLException{
	
	JSONArray leasedata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return leasedata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String sqltest="";
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!cldocno.equalsIgnoreCase("")){
			sqltest+=" and agmt.cldocno="+cldocno;
		}
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		if(sqlfromdate!=null){
			sqltest+=" and invm.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and invm.date<='"+sqltodate+"'";
		}
		if(!cldocno.equalsIgnoreCase("")){
			sqltest+=" and easy.cldocno="+cldocno;
		}
		if(!invtrno.equalsIgnoreCase("")){
			sqltest+=" and easy.invtrno="+invtrno;
		}
		if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
			sqltest+=" and agmt.brhid="+branch;
		}
		/*String strsql="select inv.voc_no invvocno,easy.invtrno,agmt.voc_no,easy.fromdate,easy.todate,head.account,head.description acname,amount,rentalamt rentalsum,accamt accsum,insuramt insurchg from gl_inveasylease easy inner "+
		" join gl_invm inv on (easy.invdocno=inv.doc_no) left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on"+
		" (ac.acno=head.doc_no) left join gl_lagmt agmt on (easy.agmtno=agmt.doc_no) where inv.status=3 "+sqltest;*/
		
		String strsql="select a.voc_no,a.invvocno,if(a.repdocno>0,'Replace Date',a.po) po,"+
				" if(a.repdocno>0,a.repdate,a.fromdate) fromdate,if(a.repdocno>0,'',a.todate) todate,if(a.repdocno>0,0,a.datediff) datediff,"+
				" if(a.repdocno>0,a.outregno,a.reg_no) reg_no,if(a.repdocno>0,0,a.rentalamt) rentalamt,if(a.repdocno>0,0,a.insuramt) insuramt,"+
				" if(a.repdocno>0,0,a.accamt) accamt,if(a.repdocno>0,0,a.amount) amount  from ("+
				" select '' outregno,'' repdate,invm.voc_no invvocno,'' repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(easy.todate,easy.fromdate) datediff,"+
				" agmt.voc_no,date_format(date_add(easy.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(easy.todate,'%d-%m-%Y') todate,round(easy.rentalamt,2)"+
				" rentalamt,round(easy.accamt,2) accamt,round(easy.insuramt,2) insuramt,round(easy.amount,2) amount from gl_inveasylease easy left join"+
				" gl_lagmt agmt on easy.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_invm invm on easy.invdocno=invm.doc_no where easy.status=3 "+sqltest+" "+
				" union all"+
				" select outveh.reg_no outregno,date_format(rep.date,'%d-%m-%Y') repdate,invm.voc_no invvocno,rep.doc_no repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(easy.todate,easy.fromdate) datediff,"+
				" agmt.voc_no,date_format(date_add(easy.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(easy.todate,'%d-%m-%Y') todate,round(easy.rentalamt,2)"+
				" rentalamt,round(easy.accamt,2) accamt,round(easy.insuramt,2) insuramt,round(easy.amount,2) amount from gl_inveasylease easy left join"+
				" gl_lagmt agmt on easy.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_invm invm on easy.invdocno=invm.doc_no "+
				" left join gl_vehreplace rep on easy.agmtno=rep.rdocno left join gl_vehmaster outveh on rep.ofleetno=outveh.fleet_no where  easy.status=3 "+sqltest+" and rep.doc_no is not null and (rep.date>=easy.fromdate and rep.date<=easy.todate)) a order by a.voc_no";
		
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		leasedata=objcommon.convertToJSON(rs);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return leasedata;
}

public JSONArray getDetailDataExcel(String cldocno,String invtrno,String fromdate,String todate,String branch,String id) throws SQLException{
	
	JSONArray leasedata=new JSONArray();
	if(!id.equalsIgnoreCase("1")){
		return leasedata;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String sqltest="";
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!cldocno.equalsIgnoreCase("")){
			sqltest+=" and agmt.cldocno="+cldocno;
		}
		if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("") && todate!=null){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		if(sqlfromdate!=null){
			sqltest+=" and invm.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and invm.date<='"+sqltodate+"'";
		}
		if(!cldocno.equalsIgnoreCase("")){
			sqltest+=" and easy.cldocno="+cldocno;
		}
		if(!invtrno.equalsIgnoreCase("")){
			sqltest+=" and easy.invtrno="+invtrno;
		}
		if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
			sqltest+=" and agmt.brhid="+branch;
		}
		String strsql="select a.voc_no 'Agreement No',if(a.repdocno>0,'Replace Date',a.po) 'Ref No',"+
				" if(a.repdocno>0,a.repdate,a.fromdate) 'From Date',if(a.repdocno>0,'',a.todate) 'To Date',if(a.repdocno>0,0,a.datediff) 'No of Days',"+
				" if(a.repdocno>0,a.outregno,a.reg_no) 'Reg No',if(a.repdocno>0,0,a.rentalamt) 'Rental Charges',if(a.repdocno>0,0,a.insuramt) 'Insur Charges',"+
				" if(a.repdocno>0,0,a.accamt) 'Acc Charges',if(a.repdocno>0,0,a.amount) 'Amount'  from ("+
				" select '' outregno,'' repdate,invm.voc_no invvocno,'' repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(easy.todate,easy.fromdate) datediff,"+
				" agmt.voc_no,date_format(date_add(easy.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(easy.todate,'%d-%m-%Y') todate,round(easy.rentalamt,2)"+
				" rentalamt,round(easy.accamt,2) accamt,round(easy.insuramt,2) insuramt,round(easy.amount,2) amount from gl_inveasylease easy left join"+
				" gl_lagmt agmt on easy.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_invm invm on easy.invdocno=invm.doc_no where easy.status=3 "+sqltest+" "+
				" union all"+
				" select outveh.reg_no outregno,date_format(rep.date,'%d-%m-%Y') repdate,invm.voc_no invvocno,rep.doc_no repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(easy.todate,easy.fromdate) datediff,"+
				" agmt.voc_no,date_format(date_add(easy.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(easy.todate,'%d-%m-%Y') todate,round(easy.rentalamt,2)"+
				" rentalamt,round(easy.accamt,2) accamt,round(easy.insuramt,2) insuramt,round(easy.amount,2) amount from gl_inveasylease easy left join"+
				" gl_lagmt agmt on easy.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_invm invm on easy.invdocno=invm.doc_no "+
				" left join gl_vehreplace rep on easy.agmtno=rep.rdocno left join gl_vehmaster outveh on rep.ofleetno=outveh.fleet_no where  easy.status=3 "+sqltest+" and rep.doc_no is not null and (rep.date>=easy.fromdate and rep.date<=easy.todate)) a order by a.voc_no";
		
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		leasedata=objcommon.convertToEXCEL(rs);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return leasedata;
}

}
