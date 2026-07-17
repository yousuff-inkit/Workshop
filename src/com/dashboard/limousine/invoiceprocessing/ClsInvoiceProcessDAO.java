package com.dashboard.limousine.invoiceprocessing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInvoiceProcessDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public JSONArray getInvoiceData(String client,String guest,String fromdate,String todate,String id,String branch,String bookdocno,String jobtype,String invoicetype) throws SQLException{
		JSONArray invoicedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return invoicedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			String sqlorderby="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!client.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+client;
			}
			if(!guest.equalsIgnoreCase("")){
				sqltest+=" and guest.doc_no="+guest;
			}
			if(sqlfromdate!=null && sqltodate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"' and book.date<='"+sqltodate+"'";
			}
			if(!bookdocno.equalsIgnoreCase("")){
				sqltest+=" and book.doc_no="+bookdocno;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and book.brhid="+branch;
			}
			
			if(invoicetype.equalsIgnoreCase("client")){
				sqlorderby=" order by book.cldocno";
			}
		
      		
			if(jobtype.equalsIgnoreCase("Transfer")){
				strsql="select tran.doc_no jobdocno,convert(concat(tran.bookdocno,' - ',tran.docname),char(25)) jobnametemp,tran.bookdocno,ac.cldocno,ac.refname client,guest.doc_no guestno,guest.guest,tran.docname jobname,'Transfer' jobtype,pickup.location"+
						" pickuplocation, tran.pickuplocid pickuplocid,dropoff.location dropofflocation,tran.dropfflocid dropofflocid,null blockhrs,calc.total,calc.tarif,"+
						" calc.nighttarif,calc.exkmchg,calc.exhrchg,calc.exnighthrchg nightextrahrchg,calc.fuelchg,calc.parkingchg,calc.otherchg,calc.greetchg,calc.vipchg,calc.boquechg from "+
						" gl_limobookm book left join gl_limobooktransfer tran on book.doc_no=tran.bookdocno left join gl_limojobclosecalc calc on (tran.doc_no=calc.jobdocno "+
						" and calc.jobtype='Transfer' and book.doc_no=calc.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
						" gl_limoguest guest on  book.guestno=guest.doc_no left join gl_cordinates pickup on tran.pickuplocid=pickup.doc_no left join gl_cordinates dropoff on "+
						" tran.dropfflocid=dropoff.doc_no where book.status=3 and tran.status=3 and tran.masterstatus=5 and tran.trno=0 "+sqltest+" group by tran.doc_no"+sqlorderby;
			}
			else if(jobtype.equalsIgnoreCase("Limo")){
				strsql="select hours.doc_no jobdocno,convert(concat(hours.bookdocno,' - ',hours.docname),char(25)) jobnametemp,hours.bookdocno,ac.cldocno,ac.refname client,guest.doc_no guestno,guest.guest,hours.docname jobname,'Limo' jobtype,pickup.location"+
						" pickuplocation,hours.pickuplocid  pickuplocid,null dropofflocation,null dropofflocid,hours.blockhrs,calc.total,calc.tarif,calc.nighttarif,calc.exkmchg,"+
						" calc.exhrchg,calc.exnighthrchg nightextrahrchg,calc.fuelchg,calc.parkingchg,calc.otherchg,calc.greetchg,calc.vipchg,calc.boquechg from gl_limobookm book left join "+
						" gl_limobookhours hours on book.doc_no=hours.bookdocno left join gl_limojobclosecalc calc on (hours.doc_no=calc.jobdocno and calc.jobtype='Limo' and "+
						" book.doc_no=calc.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on  "+
						" book.guestno=guest.doc_no left join gl_cordinates pickup on hours.pickuplocid=pickup.doc_no where book.status=3 and hours.status=3 and hours.masterstatus=5  and hours.trno=0 "+
						"  "+sqltest+"  group by hours.doc_no"+sqlorderby;
			}
			else{
				if(!sqlorderby.equalsIgnoreCase("")){
				
				strsql="select * from (select tran.doc_no jobdocno,convert(concat(tran.bookdocno,' - ',tran.docname),char(25)) jobnametemp,tran.bookdocno,ac.cldocno,ac.refname client,guest.doc_no guestno,guest.guest,tran.docname jobname,'Transfer' jobtype,pickup.location"+
						" pickuplocation, tran.pickuplocid pickuplocid,dropoff.location dropofflocation,tran.dropfflocid dropofflocid,null blockhrs,calc.total,calc.tarif,"+
						" calc.nighttarif,calc.exkmchg,calc.exhrchg,calc.exnighthrchg nightextrahrchg,calc.fuelchg,calc.parkingchg,calc.otherchg,calc.greetchg,calc.vipchg,calc.boquechg from "+
						" gl_limobookm book left join gl_limobooktransfer tran on book.doc_no=tran.bookdocno left join gl_limojobclosecalc calc on (tran.doc_no=calc.jobdocno "+
						" and calc.jobtype='Transfer' and book.doc_no=calc.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
						" gl_limoguest guest on  book.guestno=guest.doc_no left join gl_cordinates pickup on tran.pickuplocid=pickup.doc_no left join gl_cordinates dropoff on "+
						" tran.dropfflocid=dropoff.doc_no where book.status=3 and tran.status=3 and tran.masterstatus=5  and tran.trno=0 "+sqltest+" group by tran.doc_no union all"+
						" select hours.doc_no jobdocno,convert(concat(hours.bookdocno,' - ',hours.docname),char(25)) jobnametemp,hours.bookdocno,ac.cldocno,ac.refname client,guest.doc_no guestno,guest.guest,hours.docname jobname,'Limo' jobtype,pickup.location"+
						" pickuplocation,hours.pickuplocid  pickuplocid,null dropofflocation,null dropofflocid,hours.blockhrs,calc.total,calc.tarif,calc.nighttarif,calc.exkmchg,"+
						" calc.exhrchg,calc.exnighthrchg nightextrahrchg,calc.fuelchg,calc.parkingchg,calc.otherchg,calc.greetchg,calc.vipchg,calc.boquechg from gl_limobookm book left join "+
						" gl_limobookhours hours on book.doc_no=hours.bookdocno left join gl_limojobclosecalc calc on (hours.doc_no=calc.jobdocno and calc.jobtype='Limo' and "+
						" book.doc_no=calc.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on  "+
						" book.guestno=guest.doc_no left join gl_cordinates pickup on hours.pickuplocid=pickup.doc_no where book.status=3 and hours.status=3 and hours.masterstatus=5  and hours.trno=0 "+
						"  "+sqltest+"  group by hours.doc_no) a order by a.cldocno";
				
				}
				else{
					strsql="select tran.doc_no jobdocno,convert(concat(tran.bookdocno,' - ',tran.docname),char(25)) jobnametemp,tran.bookdocno,ac.cldocno,ac.refname client,guest.doc_no guestno,guest.guest,tran.docname jobname,'Transfer' jobtype,pickup.location"+
						" pickuplocation, tran.pickuplocid pickuplocid,dropoff.location dropofflocation,tran.dropfflocid dropofflocid,null blockhrs,calc.total,calc.tarif,"+
						" calc.nighttarif,calc.exkmchg,calc.exhrchg,calc.exnighthrchg nightextrahrchg,calc.fuelchg,calc.parkingchg,calc.otherchg,calc.greetchg,calc.vipchg,calc.boquechg from "+
						" gl_limobookm book left join gl_limobooktransfer tran on book.doc_no=tran.bookdocno left join gl_limojobclosecalc calc on (tran.doc_no=calc.jobdocno "+
						" and calc.jobtype='Transfer' and book.doc_no=calc.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
						" gl_limoguest guest on  book.guestno=guest.doc_no left join gl_cordinates pickup on tran.pickuplocid=pickup.doc_no left join gl_cordinates dropoff on "+
						" tran.dropfflocid=dropoff.doc_no where book.status=3 and tran.status=3 and tran.masterstatus=5  and tran.trno=0 "+sqltest+" group by tran.doc_no union all"+
						" select hours.doc_no jobdocno,convert(concat(hours.bookdocno,' - ',hours.docname),char(25)) jobnametemp,hours.bookdocno,ac.cldocno,ac.refname client,guest.doc_no guestno,guest.guest,hours.docname jobname,'Limo' jobtype,pickup.location"+
						" pickuplocation,hours.pickuplocid  pickuplocid,null dropofflocation,null dropofflocid,hours.blockhrs,calc.total,calc.tarif,calc.nighttarif,calc.exkmchg,"+
						" calc.exhrchg,calc.exnighthrchg nightextrahrchg,calc.fuelchg,calc.parkingchg,calc.otherchg,calc.greetchg,calc.vipchg,calc.boquechg from gl_limobookm book left join "+
						" gl_limobookhours hours on book.doc_no=hours.bookdocno left join gl_limojobclosecalc calc on (hours.doc_no=calc.jobdocno and calc.jobtype='Limo' and "+
						" book.doc_no=calc.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on  "+
						" book.guestno=guest.doc_no left join gl_cordinates pickup on hours.pickuplocid=pickup.doc_no where book.status=3 and hours.status=3 and hours.masterstatus=5  and hours.trno=0 "+
						"  "+sqltest+"  group by hours.doc_no";
				}
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			invoicedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicedata;
	}
	
	
	
	public  JSONArray getClientData(String clientdocno,String clientname,String id) throws SQLException{
		JSONArray clientdata=new JSONArray();
		Connection conn=null;
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			if(!clientdocno.equalsIgnoreCase("")){
				sqltest+=" and cldocno like '%"+clientdocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and refname like '%"+clientname+"%'";
			}
			strsql="select cldocno,refname,address,per_mob from my_acbook where status=3 and dtype='CRM'"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return clientdata;
	}
	
	
	public  JSONArray getGuestData(String guestdocno,String guestname,String guestmobile,String id) throws SQLException{
		JSONArray guestdata=new JSONArray();
		Connection conn=null;
		if(!id.equalsIgnoreCase("1")){
			return guestdata;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			if(!guestdocno.equalsIgnoreCase("")){
				sqltest+=" and doc_no like '%"+guestdocno+"%'";
			}
			if(!guestname.equalsIgnoreCase("")){
				sqltest+=" and guest like '%"+guestname+"%'";
			}
			if(!guestmobile.equalsIgnoreCase("")){
				sqltest+=" and guestcontactno like '%"+guestmobile+"%'";
			}
			strsql="select doc_no,guest,guestcontactno from gl_limoguest where status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			guestdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return guestdata;
	}
	
}
