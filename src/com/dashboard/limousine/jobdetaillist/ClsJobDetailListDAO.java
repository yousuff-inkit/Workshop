package com.dashboard.limousine.jobdetaillist;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsJobDetailListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public JSONArray getJobDetails(String id,String branch,String fromdate,String todate) throws SQLException{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="",sqltransferbranch="",sqlhoursbranch="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and book.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				/*sqltest+=" and book.brhid="+branch;*/
				sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
				sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
			}
			String strsql="select convert(concat(coalesce(book.doc_no,''),' - ',coalesce(tran.docname,'')),char(10)) jobnametemp,book.doc_no bookdocno,tran.doc_no jobdocno,tran.docname jobname,ac.refname,guest.guest,'Transfer' type,'' blockhrs,calc.startdate,"+
			" calc.starttime,calc.startkm,calc.closedate ,calc.closetime ,calc.closekm,pickup.location pickuplocation,tran.pickupadress pickupaddress,"+
			" dropoff.location dropofflocation,tran.dropoffaddress dropoffaddress,brd.brand_name brand,model.vtype model,tran.nos from gl_limobookm book left join "+
			" my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on book.guestno=guest.doc_no left join gl_limobooktransfer tran "+
			" on book.doc_no=tran.bookdocno left join gl_limojobclosecalc calc on (book.doc_no=calc.bookdocno and tran.doc_no=calc.jobdocno and calc.jobtype='Transfer')"+
			" left join gl_vehbrand brd on (tran.brandid=brd.doc_no) left join gl_vehmodel model on (tran.modelid=model.doc_no) left join gl_cordinates pickup on "+
			" tran.pickuplocid=pickup.doc_no left join gl_cordinates dropoff on tran.dropfflocid=dropoff.doc_no where book.status=3 "+sqltest+" union all"+
			" select convert(concat(coalesce(book.doc_no,''),' - ',coalesce(hours.docname,'')),char(10)) jobnametemp,book.doc_no bookdocno,hours.doc_no jobdocno,hours.docname jobname,ac.refname,guest.guest,'Transfer' type,hours.blockhrs,calc.startdate,"+
			" calc.starttime,calc.startkm,calc.closedate ,calc.closetime ,calc.closekm,pickup.location pickuplocation,hours.pickupaddress pickupaddress,"+
			" '' dropofflocation,'' dropoffaddress,brd.brand_name brand,model.vtype model,hours.nos from gl_limobookm book left join my_acbook ac on "+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on book.guestno=guest.doc_no left join gl_limobookhours hours on "+
			" book.doc_no=hours.bookdocno  left join gl_limojobclosecalc calc on (book.doc_no=calc.bookdocno and hours.doc_no=calc.jobdocno and calc.jobtype='Limo') "+
			" left join gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join gl_cordinates pickup on "+
			" hours.pickuplocid=pickup.doc_no where book.status=3 "+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			jobdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}
}
