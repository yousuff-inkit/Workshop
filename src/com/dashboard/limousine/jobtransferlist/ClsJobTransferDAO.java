package com.dashboard.limousine.jobtransferlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsJobTransferDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getTransferData(String branch,String fromdate,String todate,String transferbranch,String id) throws SQLException{
		JSONArray transferdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return transferdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			String sqltranbranch="";
			String sqlhoursbranch="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and book.brhid="+branch;
			}
			if(sqlfromdate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and book.date<='"+sqltodate+"'";
			}
			if(!transferbranch.equalsIgnoreCase("")){
				sqltranbranch+=" and tran.transferbranch="+transferbranch;
				sqlhoursbranch+=" and hours.transferbranch="+transferbranch;
			}
			strsql="select br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,"+
			" tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate, tran.pickuptime,pickup.location pickuplocation,tran.pickupadress "+
			" pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, model.vtype model,tran.nos from gl_limobookm book left join "+
			" gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on "+
			" (book.guestno=guest.doc_no) left join gl_cordinates pickup on (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) "+
			" left join gl_vehbrand brd on tran.brandid=brd.doc_no left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left "+
			" join my_brch tranbr on tran.transferbranch=tranbr.doc_no where book.status=3 and book.detailstatus<>3 and tran.transferbranch<>0 "+sqltest+sqltranbranch+" union all"+
			" select br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,book.guestno,hours.doc_no detaildocno,hours.brandid,"+
			" hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,hours.pickuptime,pickup.location pickuplocation,"+
			" hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,hours.nos from gl_limobookm book left join"+
			" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest "+
			" on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehbrand brd on (hours.brandid=brd.doc_no) "+
			" left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch hoursbr on "+
			" hours.transferbranch=hoursbr.doc_no where book.status=3 and book.detailstatus<>3 and hours.transferbranch<>0"+sqltest+sqlhoursbranch;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			transferdata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return transferdata;
	}
           public JSONArray exceljobTransferData(String branch,String fromdate,String todate,String transferbranch,String id) throws SQLException{
		JSONArray transferdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return transferdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			String sqltranbranch="";
			String sqlhoursbranch="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and book.brhid="+branch;
			}
			if(sqlfromdate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and book.date<='"+sqltodate+"'";
			}
			if(!transferbranch.equalsIgnoreCase("")){
				sqltranbranch+=" and tran.transferbranch="+transferbranch;
				sqlhoursbranch+=" and hours.transferbranch="+transferbranch;
			}
			strsql="select br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,"+
			" tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate, tran.pickuptime,pickup.location pickuplocation,tran.pickupadress "+
			" pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, model.vtype model,tran.nos from gl_limobookm book left join "+
			" gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on "+
			" (book.guestno=guest.doc_no) left join gl_cordinates pickup on (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) "+
			" left join gl_vehbrand brd on tran.brandid=brd.doc_no left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left "+
			" join my_brch tranbr on tran.transferbranch=tranbr.doc_no where book.status=3 and book.detailstatus<>3 and tran.transferbranch<>0 "+sqltest+sqltranbranch+" union all"+
			" select br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,book.guestno,hours.doc_no detaildocno,hours.brandid,"+
			" hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,hours.pickuptime,pickup.location pickuplocation,"+
			" hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,hours.nos from gl_limobookm book left join"+
			" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest "+
			" on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehbrand brd on (hours.brandid=brd.doc_no) "+
			" left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch hoursbr on "+
			" hours.transferbranch=hoursbr.doc_no where book.status=3 and book.detailstatus<>3 and hours.transferbranch<>0"+sqltest+sqlhoursbranch;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			transferdata=ClsCommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return transferdata;
	}
}
