package com.dashboard.limousine.jobstatus;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLimoJobStatusDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getStatusData(String fromdate,String todate,String branch,String status,String id,String booktype) throws SQLException{
		JSONArray transferdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return transferdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			String sqltransferbranch="";
			String sqlhoursbranch="";
			String sqltransferstatus="";
			String sqlhoursstatus="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				/*sqltest+=" and book.brhid="+branch;*/
				sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
				sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
			}
			if(sqlfromdate!=null && sqltodate!=null){
				if(booktype.equalsIgnoreCase("1")){
					sqltest+=" and tran.pickupdate>='"+sqlfromdate+"' and tran.pickupdate<='"+sqltodate+"'";
				}
				else if(booktype.equalsIgnoreCase("2")){
					sqltest+=" and hours.pickupdate>='"+sqlfromdate+"' and hours.pickupdate<='"+sqltodate+"'";
				}
			}
			if(!status.equalsIgnoreCase("")){
				sqltransferstatus+=" and tran.masterstatus="+status;
				sqlhoursstatus+=" and hours.masterstatus="+status;
			}
			
			if(booktype.equalsIgnoreCase("1")){
				strsql="select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no bookdocno,"+
			" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
			" model.vtype model,tran.nos from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
			" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus;
			}
			else if(booktype.equalsIgnoreCase("2")){
				strsql="select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no bookdocno,book.cldocno,"+
			" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
			" hours.nos from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
			" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3 "+
			" "+sqltest+sqlhoursbranch+sqlhoursstatus;
			}
			/*strsql="select * from (select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,"+
			" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
			" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
			" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 "+sqltest+sqltransferbranch+" union all"+
			" select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,"+
			" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
			" hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
			" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3 "+
			" "+sqltest+sqlhoursbranch+")a order by a.doc_no";*/
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			transferdata=objcommon.convertToJSON(rs);
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
	public JSONArray getCountData(String fromdate,String todate,String status,String branch,String id) throws SQLException{
		JSONArray countdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return countdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltesttransfer="",sqltesthours="";
			String sqltransferbranch="";
			String sqlhoursbranch="";
			String sqltransferstatus="";
			String sqlhoursstatus="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				/*sqltest+=" and book.brhid="+branch;*/
				sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
				sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
			}
			if(sqlfromdate!=null && sqltodate!=null){
					sqltesttransfer+=" and tran.pickupdate>='"+sqlfromdate+"' and tran.pickupdate<='"+sqltodate+"'";
					sqltesthours+=" and hours.pickupdate>='"+sqlfromdate+"' and hours.pickupdate<='"+sqltodate+"'";
			}
			if(!status.equalsIgnoreCase("")){
				sqltransferstatus+=" and tran.masterstatus="+status;
				sqlhoursstatus+=" and hours.masterstatus="+status;
			}
			
			strsql="select 1 docno,count(*) count,'Transfer' description from gl_limobooktransfer tran inner join gl_limobookm m on"+
			" tran.bookdocno=m.doc_no where m.status=3 and tran.status=3 "+sqltesttransfer+sqltransferbranch+sqltransferstatus+" union all"+
			" select 2 docno,count(*) count,'Limo' description from gl_limobookhours hours inner join gl_limobookm m on"+
			" hours.bookdocno=m.doc_no where m.status=3 and hours.status=3"+sqltesthours+sqlhoursbranch+sqlhoursstatus;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			countdata=objcommon.convertToJSON(rs);
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return countdata;
	}
         public JSONArray exceljobststusData(String fromdate,String todate,String branch,String status,String id,String booktype) throws SQLException{
		JSONArray transferdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return transferdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			String sqltransferbranch="";
			String sqlhoursbranch="";
			String sqltransferstatus="";
			String sqlhoursstatus="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				/*sqltest+=" and book.brhid="+branch;*/
				sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
				sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
			}
			if(sqlfromdate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and book.date<='"+sqltodate+"'";
			}
			if(!status.equalsIgnoreCase("")){
				sqltransferstatus+=" and tran.masterstatus="+status;
				sqlhoursstatus+=" and hours.masterstatus="+status;
			}
			
			if(booktype.equalsIgnoreCase("1")){
				strsql="select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no bookdocno,"+
			" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
			" model.vtype model,tran.nos from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
			" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 "+sqltest+sqltransferbranch+sqltransferstatus;
			}
			else if(booktype.equalsIgnoreCase("2")){
				strsql="select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no bookdocno,book.cldocno,"+
			" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
			" hours.nos from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
			" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3 "+
			" "+sqltest+sqlhoursbranch+sqlhoursstatus;
			}
			/*strsql="select * from (select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,"+
			" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
			" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
			" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
			" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
			" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 "+sqltest+sqltransferbranch+" union all"+
			" select coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,"+
			" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
			" hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
			" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
			" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
			" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3 "+
			" "+sqltest+sqlhoursbranch+")a order by a.doc_no";*/
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			transferdata=objcommon.convertToEXCEL(rs);
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
