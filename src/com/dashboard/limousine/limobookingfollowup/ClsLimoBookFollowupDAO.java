package com.dashboard.limousine.limobookingfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsLimoBookFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getFollowupData(String branch,String id,String fromdate,String todate) throws SQLException{
		JSONArray followupdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return followupdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
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
			/*strsql="select book.doc_no,book.date,ac.refname client,guest.guest,guest.guestcontactno contactno,(select count(*) from gl_limobookm book left join"+
			" gl_limobooktransfer tran on book.doc_no=tran.bookdocno where book.status=3 and (book.detailstatus=0 or book.detailstatus=1) "+sqltest+") transfercount,"+
			" (select count(*) from gl_limobookm book left join gl_limobookhours hours on book.doc_no=hours.bookdocno where book.status=3 and (book.detailstatus=0 or book.detailstatus=1) "+sqltest+")"+
			" hourscount,(select count(*) from gl_limobookm book left join gl_limobooksrvc srvc on book.doc_no=srvc.bookdocno where book.status=3 and "+
			" (book.detailstatus=0 or book.detailstatus=1) "+sqltest+") srvccount from gl_limobookm book left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
			" gl_limoguest guest on book.guestno=guest.doc_no where book.status=3 and (book.detailstatus=0 or book.detailstatus=1)"+sqltest;
			*/
			strsql="select book.doc_no,book.date,ac.refname client,coalesce(guest.guest,'') guest,coalesce(guest.guestcontactno,'') contactno,"+
			" coalesce(hours.hourscount,0) hourscount,coalesce(srvc.srvccount,0) srvccount,coalesce(tran.transfercount,0) transfercount from gl_limobookm book "+
			" left join (select count(bookdocno) hourscount,bookdocno from  gl_limobookhours group by bookdocno) hours on book.doc_no=hours.bookdocno "+
			" left join (select count(bookdocno) srvccount,bookdocno from  gl_limobooksrvc group by bookdocno) srvc  on book.doc_no=srvc.bookdocno"+
			" left join (select count(bookdocno) transfercount,bookdocno from  gl_limobooktransfer group by bookdocno) tran  on book.doc_no=tran.bookdocno"+
			" left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join  gl_limoguest guest on book.guestno=guest.doc_no"+
			" where book.status=3 and (book.detailstatus=0 or book.detailstatus=1)"+sqltest+" group by book.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			followupdata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return followupdata;
	}
	
	public JSONArray getFollowupDetailData(String bookdocno,String id)throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select det.date,det.followupdate fdate,det.remarks,usr.user_name user from gl_limobookfollowup det left join my_user usr on "+
			" det.doc_no=usr.doc_no where det.bookdocno="+bookdocno;
			ResultSet rs=stmt.executeQuery(strsql);
			detaildata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
public JSONArray excelFollowupsubData(String bookdocno,String id)throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select det.date,det.followupdate fdate,det.remarks,usr.user_name user from gl_limobookfollowup det left join my_user usr on "+
			" det.doc_no=usr.doc_no where det.bookdocno="+bookdocno;
			ResultSet rs=stmt.executeQuery(strsql);
			detaildata=ClsCommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
	public JSONArray excelFollowupData(String branch,String id,String fromdate,String todate) throws SQLException{
		JSONArray followupdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return followupdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
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
			/*strsql="select book.doc_no,book.date,ac.refname client,guest.guest,guest.guestcontactno contactno,(select count(*) from gl_limobookm book left join"+
			" gl_limobooktransfer tran on book.doc_no=tran.bookdocno where book.status=3 and (book.detailstatus=0 or book.detailstatus=1) "+sqltest+") transfercount,"+
			" (select count(*) from gl_limobookm book left join gl_limobookhours hours on book.doc_no=hours.bookdocno where book.status=3 and (book.detailstatus=0 or book.detailstatus=1) "+sqltest+")"+
			" hourscount,(select count(*) from gl_limobookm book left join gl_limobooksrvc srvc on book.doc_no=srvc.bookdocno where book.status=3 and "+
			" (book.detailstatus=0 or book.detailstatus=1) "+sqltest+") srvccount from gl_limobookm book left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
			" gl_limoguest guest on book.guestno=guest.doc_no where book.status=3 and (book.detailstatus=0 or book.detailstatus=1)"+sqltest;
			*/
			strsql="select book.doc_no,book.date,ac.refname client,coalesce(guest.guest,'') guest,coalesce(guest.guestcontactno,'') contactno,"+
			" coalesce(hours.hourscount,0) hourscount,coalesce(srvc.srvccount,0) srvccount,coalesce(tran.transfercount,0) transfercount from gl_limobookm book "+
			" left join (select count(bookdocno) hourscount,bookdocno from  gl_limobookhours group by bookdocno) hours on book.doc_no=hours.bookdocno "+
			" left join (select count(bookdocno) srvccount,bookdocno from  gl_limobooksrvc group by bookdocno) srvc  on book.doc_no=srvc.bookdocno"+
			" left join (select count(bookdocno) transfercount,bookdocno from  gl_limobooktransfer group by bookdocno) tran  on book.doc_no=tran.bookdocno"+
			" left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join  gl_limoguest guest on book.guestno=guest.doc_no"+
			" where book.status=3 and (book.detailstatus=0 or book.detailstatus=1)"+sqltest+" group by book.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			followupdata=ClsCommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return followupdata;
	}

}
