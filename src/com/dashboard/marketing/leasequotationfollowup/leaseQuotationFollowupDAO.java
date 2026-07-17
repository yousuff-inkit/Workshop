package com.dashboard.marketing.leasequotationfollowup;


import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.org.apache.bcel.internal.generic.DCONST;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class leaseQuotationFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray quotfollowtsearch(String brnchval,String fromdate,String todate,String salperson,String chkfollowup,String followupdate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		java.sql.Date sqlfromdate = null;
		java.sql.Date sqlFollowUpDate = null;
		String sqltest="";
		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		{
			sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);

		}
		else{

		}

		java.sql.Date sqltodate = null;
		if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		{
			sqltodate=ClsCommon.changeStringtoSqlDate(todate);

		}
		else{

		}
		if(!(salperson.equalsIgnoreCase(""))){
			sqltest+=" and s.doc_no="+salperson+" ";
		}
		if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
			sqlFollowUpDate = ClsCommon.changeStringtoSqlDate(followupdate);
		}
		if(chkfollowup.equalsIgnoreCase("1")){
			if(!(sqlFollowUpDate==null)){
				
				sqltest+=" and lq.fdate<='"+sqlFollowUpDate+"' ";
			}
		}
		else
		{
			sqltest+="and lcm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' ";
		}
		if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
			sqltest+=" and lcm.brhid='"+brnchval+"' ";
		}
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			//String sql="";
			//ResultSet resultSet ;
			//System.out.println("========="+brnchval);
			/*String sql="select req.leasefromdate,ac.refname name,brd.brand_name  brand,model.vtype model,req.spec specification,clr.color ,"
					+ "req.leasemonths,req.kmpermonth,grp.gname,req.totalvalue,lq.fdate,req.srno,lm.brhid,'Application' appbtn "
					+ "from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no "
					+ "left join gl_vehmodel model on  req.modid=model.doc_no left join my_color clr on req.clrid=clr.doc_no"
					+ " left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid)"
					+ " left join  gl_vehgroup grp on (lcg.grpid=grp.doc_no) "
					+ "left join gl_lprd ld on req.leasereqdocno=ld.rdocno and req.reqsrno=ld.sr_no"
					+ " left join gl_lprm lm on lm.doc_no=ld.rdocno left join my_acbook ac on lm.cldocno=ac.cldocno and dtype='CRM'"
					+ "left join (select max(doc_no) doc_no,rdocno from gl_blqf where status=3 group by rdocno) sub on(sub.rdocno=req.srno)"
					+ "left join gl_blqf lq on sub.doc_no = lq.doc_no"
					+ " where ld.dropstatus<>1 and req.leasefromdate between '"+sqlfromdate+"'  and '"+sqltodate+"' order by lq.fdate DESC ";

*/		
			String sql="select req.leasefromdate,lcm.date,ac.refname name,brd.brand_name  brand,model.vtype model,if(req.spec='0','',req.spec) specification,clr.color ,"
					+ "req.leasemonths, req.kmpermonth,grp.gname,req.totalvalue,lq.fdate,req.srno,lm.brhid,'Application' appbtn,s.sal_name,"
					+ "lpr.cldocno,if(lpr.reqtype=1,ac.com_mob,lpr.mob) mobile,if(lpr.reqtype=1,ac.refname,lpr.name) refname,"
					+ "if(lpr.reqtype=1,ac.address,lpr.com_add1) address,if(lpr.reqtype=1,ac.mail1,lpr.email) email,lcm.doc_no,lcm.vocno,lcm.reqdoc leasereqdocno"
					+ " from gl_leasecalcm lcm left join gl_leasecalcreq req on lcm.doc_no=req.rdocno left join gl_lprm lpr on (lcm.reqdoc=lpr.doc_no)"
					+ " left join gl_vehbrand brd on req.brdid=brd.doc_no left join gl_vehmodel model on  req.modid=model.doc_no "
					+ "left join my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on (req.brdid=req.brdid and req.modid=lcg.modid)"
					+ " left join  gl_vehgroup grp on (lcg.grpid=grp.doc_no)"
					+ " left join gl_lprd ld on req.leasereqdocno=ld.rdocno and req.reqsrno=ld.sr_no left join gl_lprm lm on lm.doc_no=ld.rdocno"
					+ " left join my_acbook ac on lm.cldocno=ac.cldocno and dtype='CRM' left join my_salm s on ac.sal_id=s.doc_no "
					+ "left join (select max(doc_no) doc_no,rdocno from gl_blqf where status=3 group by rdocno) sub on(sub.rdocno=req.srno) "
					+ "left join gl_blqf lq on sub.doc_no = lq.doc_no "
					+ "where ld.dropstatus<>1 and lcm.status=3 and lcm.leaseappstatus=0 and"
					+ " req.status=3  "+sqltest+" order by lq.fdate,lcm.doc_no ";
			
			
		//System.out.println("--fol--"+sql);
			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();



			conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public  JSONArray salpersonSearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn= ClsConnection.getMyConnection();
			Statement stmtsalname = conn.createStatement (); 

			String resql="select sal_name,doc_no from my_salm where status=3 ";
			//	System.out.println("================="+resql);
			ResultSet resultSet = stmtsalname.executeQuery(resql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtsalname.close();
			conn.close();



		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return RESULTDATA;
	}
	
	public JSONArray qotDetails(String srno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from gl_blqf m "
					+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+srno+"' and m.status=3 group by m.doc_no ";

			ResultSet resultSet = stmtVeh.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();




		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	

}