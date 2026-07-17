package com.operations.commtransactions.invoice;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.*;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceAction;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;
import com.operations.vehicletransactions.movement.ClsMovementBean;
import com.sms.SmsAction;
public class ClsManualInvoiceDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
	public   JSONArray accountSearch() throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			conn=objconn.getMyConnection();

			Statement stmtmanual = conn.createStatement ();
			strSql="select idno,acno,description from gl_invmode where status=1";
			//System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}



	public   JSONArray mainSearch(String client,String cmbagmttype,String agmtno,String searchdate,String docno,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		//	    	    	System.out.println(client+":"+cmbagmttype+":"+agmtno+":"+searchdate+":"+docno);
		// String brnchid=session.getAttribute("BRANCHID").toString();
		//System.out.println("name"+sclname);

		String sqltest="";
		java.sql.Date sqldate=null;
		if(!(searchdate.equalsIgnoreCase(""))){
			sqldate=objcommon.changeStringtoSqlDate(searchdate);	
		}

		if(!(client.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+client+"%'";
		}
		if(!(cmbagmttype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and inv.ratype='"+cmbagmttype+"'";
		}
		if(!(agmtno.equalsIgnoreCase(""))){
			if(cmbagmttype.equalsIgnoreCase("RAG")){
				sqltest=sqltest+" and agmt.voc_no like '%"+agmtno+"%'";	
			}
			else if(cmbagmttype.equalsIgnoreCase("LAG")){
				sqltest=sqltest+" and lagmt.voc_no like '%"+agmtno+"%'";
			}

		}

		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and inv.voc_no='"+docno+"'";
		}

		if(branch.equalsIgnoreCase("")){
			branch="0";
		}
		if(!branch.equalsIgnoreCase("")){
			sqltest=sqltest+" and inv.brhid="+branch+"";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and inv.date='"+sqldate+"'";
		}
		Connection conn =null;

		try {
			conn= objconn.getMyConnection();
			Statement stmtsearch = conn.createStatement ();
			String str1Sql="select inv.doc_no,inv.voc_no voucherno,inv.rano,inv.date,inv.ratype agmttype,ac.refname,if(inv.ratype='RAG',agmt.voc_no,lagmt.voc_no) voc_no "+
					" from gl_invm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_ragmt agmt on "+
					" (inv.rano=agmt.doc_no and inv.ratype='RAG') left join gl_lagmt lagmt on (inv.rano=lagmt.doc_no and inv.ratype='LAG') where inv.status<>7 "+sqltest+""+
					" group by inv.doc_no";
			ResultSet resultSet = stmtsearch.executeQuery(str1Sql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtsearch.close();
			conn.close();
			return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		conn.close();
		return RESULTDATA;
	}





	public   JSONArray getInvoiceGridData(String branch,String docno) throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection  conn = null;
		try {

			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			strSql="select invmod.idno idno,invd.acno account,invmod.description,invd.units qty,invd.amount rate,invd.total from gl_invm inv"+
					" left join gl_invd invd on inv.doc_no=invd.rdocno left join gl_invmode invmod on invd.chid=invmod.idno where inv.doc_no='"+docno+"' and inv.status=3 ";
			//    	System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}
	public   JSONArray invoiceSearch() throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			conn=objconn.getMyConnection();

			Statement stmtmanual = conn.createStatement ();
			strSql="select inv.doc_no,inv.rano,inv.date,inv.ratype agmttype,ac.refname from gl_invm inv left join my_acbook ac on"+
					" (inv.cldocno=ac.cldocno and ac.dtype='CRM') where inv.status<>7";
			//	System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}
	public   JSONArray getAgmtnoSearch(String docno,String fleet,String regno,String client,String agmttype,String date,String mobile,String license,String branch) throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			java.sql.Date sqlStartDate=null;
			String sqltest="";

			if(!(date.equalsIgnoreCase(""))){
				sqlStartDate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqlStartDate!=null){
				sqltest=sqltest+" and agmt.date='"+sqlStartDate+"'";
			}
			if(!(license.equalsIgnoreCase(""))){
				sqltest=sqltest+" and dr.dlno like '%"+license+"%'";
			}

			if(!(docno.equalsIgnoreCase(""))){
				sqltest=" and agmt.voc_no='"+docno+"'";
			}
			if(!(fleet.equalsIgnoreCase(""))){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqltest=sqltest+" and agmt.ofleet_no like '%"+fleet+"%'";
				}
				if(agmttype.equalsIgnoreCase("LAG")){
					sqltest=sqltest+" and (agmt.tmpfleet like '%"+fleet+"%' or agmt.perfleet like '%"+fleet+"%')";
				}

			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			if(!(client.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+client+"%'";
			}
			if(!(mobile.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}

			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			JSONArray jsonArray = new JSONArray();
			//System.out.println("AGMT"+agmttype);
			if(agmttype.equalsIgnoreCase("RAG")){
				strSql="select distinct agmt.doc_no,agmt.voc_no,agmt.cldocno,agmt.ofleet_no,ac.refname,ac.address,coalesce(ac.mail1,'') as email,ac.per_mob,ac.acno,coalesce(dr.name,dr1.name) name,coalesce(dr.mobno,dr1.mobno) mobno,coalesce(dr.dlno,dr1.dlno) dlno,veh.reg_no,"+
						" veh.flname,mov.fleet_no from gl_ragmt agmt "+
						" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_rdriver rdr on  agmt.doc_no=rdr.rdocno  and rdr.status=3  left join gl_drdetails dr on ((rdr.drid=dr.dr_id) "+
						" and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+ 
						" left join gl_vehmaster veh on agmt.ofleet_no=veh.fleet_no left join gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='RAG')"+
						" where agmt.brhid="+branch+" and agmt.status=3 "+sqltest+"  group by agmt.doc_no";
			}
			if(agmttype.equalsIgnoreCase("LAG")){
				strSql="select distinct agmt.doc_no,agmt.voc_no,agmt.cldocno,if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet) ofleet_no,ac.refname,coalesce(ac.mail1,'') as email,ac.address,"+
						" ac.per_mob,ac.acno,dr.name,dr.mobno,dr.dlno,veh.reg_no,veh.flname,mov.fleet_no from gl_lagmt agmt "+
						" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_ldriver rdr on  agmt.doc_no=rdr.rdocno  and rdr.status=3 left join gl_drdetails dr on ((rdr.drid=dr.dr_id) "+
						" and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
						" left join gl_vehmaster veh on if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet)=veh.fleet_no left join"+
						" gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='LAG') where agmt.brhid="+branch+" and agmt.status=3 "+sqltest+"  group by agmt.doc_no";
			}
			//	System.out.println(strSql);
			if(!(strSql.equalsIgnoreCase(""))){
				ResultSet resultSet = stmtmanual.executeQuery (strSql);

				RESULTDATA=objcommon.convertToJSON(resultSet);

			}
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}
	public   ClsManualInvoiceBean getViewDetails(int docno,String branchid,String cmbagmttype) throws SQLException {
		//List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();
	//	ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
		Connection  conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSql="";
			if(cmbagmttype.equalsIgnoreCase("RAG")){
				strSql="select distinct inv.ratype,inv.doc_no invdoc,inv.voc_no  voucherno,inv.date,inv.ldgrnote,inv.fromdate,inv.todate,inv.invnote,agmt.doc_no agmtdoc,agmt.voc_no,agmt.cldocno,"
						+ "agmt.ofleet_no,ac.refname,ac.address,coalesce(ac.per_mob,'') per_mob,ac.acno,coalesce(ac.mail1,'') as email,coalesce(coalesce(dr.name,dr1.name),'') name,coalesce(coalesce(dr.mobno,dr1.mobno),'') mobno,"
						+ "coalesce(coalesce(dr.dlno,dr1.dlno),'') dlno,veh.reg_no,veh.flname,mov.fleet_no from gl_invm inv left "
						+ "join gl_invd invd on inv.doc_no=invd.rdocno left join gl_ragmt agmt on inv.rano=agmt.doc_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"
						+ "left join ( select min(srno) srno,rdocno from gl_rdriver where status=3 group by rdocno ) gdr on  agmt.doc_no=gdr.rdocno "
						+ "left join gl_rdriver rdr on  agmt.doc_no=rdr.rdocno and rdr.srno=gdr.srno left join gl_drdetails dr on ((rdr.drid=dr.dr_id) "
						+ " and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV') left join gl_vehmaster veh on "
						+ "agmt.ofleet_no=veh.fleet_no left join gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='RAG') where inv.doc_no='"+docno+"' and inv.status=3";
			}


			if(cmbagmttype.equalsIgnoreCase("LAG")){
				strSql="select distinct inv.ratype,inv.doc_no invdoc,inv.voc_no voucherno,inv.date,inv.ldgrnote,inv.fromdate,inv.todate,inv.invnote,agmt.doc_no agmtdoc,agmt.voc_no,"
						+ "agmt.cldocno,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) ofleet_no,ac.refname,ac.address,coalesce(ac.per_mob,'') per_mob,coalesce(ac.mail1,'') as email,ac.acno,coalesce(coalesce(dr.name,dr1.name),'') name,coalesce(coalesce(dr.mobno,dr1.mobno),'') mobno,"
						+ "coalesce(coalesce(dr.dlno,dr1.dlno),'') dlno,veh.reg_no,veh.flname,mov.fleet_no from gl_invm inv left join gl_invd invd on inv.doc_no=invd.rdocno left "
						+ "join gl_lagmt agmt on inv.rano=agmt.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') "
						+ "left join ( select min(srno) srno,rdocno from gl_ldriver where status=3 group by rdocno ) gdr on  agmt.doc_no=gdr.rdocno "
						+ " left join gl_ldriver ldr on  agmt.doc_no=ldr.rdocno and ldr.srno=gdr.srno  left join gl_drdetails dr on ((ldr.drid=dr.dr_id) "
						+ " and dr.dtype='CRM') left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no) and dr1.dtype='DRV') left join gl_vehmaster veh on "
						+ " if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet)=veh.fleet_no left join gl_vmove mov on (agmt.doc_no=mov.rdocno and mov.rdtype='LAG')"
						+ " where inv.status=3 and inv.doc_no="+docno;
			}
			//System.out.println("View Sql:"+strSql);

			ResultSet resultSet = stmtinvoice.executeQuery (strSql);

			while (resultSet.next()) {
				bean.setHidcmbagmttype(resultSet.getString("ratype"));
				bean.setHiddate(resultSet.getString("date"));
				bean.setLedgernote(resultSet.getString("ldgrnote"));
				bean.setInvoicenote(resultSet.getString("invnote"));
				bean.setHidfromdate(resultSet.getString("fromdate"));
				bean.setHidtodate(resultSet.getString("todate"));
				bean.setDocno(resultSet.getInt("invdoc"));
				bean.setVoucherno(resultSet.getInt("voucherno"));
				bean.setAgmtno(resultSet.getInt("agmtdoc"));
				bean.setAgmtvoucherno(resultSet.getInt("voc_no"));
				bean.setHidclient(resultSet.getString("cldocno"));
				String temp1="";
				temp1="Fleet: "+resultSet.getString("ofleet_no");
				temp1=temp1+" "+resultSet.getString("flname");
				temp1=temp1+" Reg No: "+resultSet.getString("reg_no");
				bean.setContractvehicle(temp1);
				String temp2="";
				bean.setClient(resultSet.getString("refname"));
				temp2="Address: "+resultSet.getString("address");
				temp2=temp2+"Mobile: "+resultSet.getString("per_mob");
				bean.setClientdetails(temp2);
				String temp3="";
				bean.setDriver(resultSet.getString("name"));
				bean.setAcno(resultSet.getString("acno"));
				temp3="Mobile: "+resultSet.getString("mobno");
				temp3=temp3+"License No: "+resultSet.getString("dlno");
				bean.setDriverdetails(temp3);
				String temp4="";
				temp4="Fleet: "+resultSet.getString("fleet_no");
				temp4=temp4+" "+resultSet.getString("flname");
				temp4=temp4+" Reg No: "+resultSet.getString("reg_no");
				bean.setVehicledetails(temp4);
				bean.setEmail(resultSet.getString("email"));

			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	public int insert(Connection conn,ArrayList<String> invoicearray,String cmbagmttype, Date date, String hidclient, int agmtno,
			String ledgernote, String invoicenote, Date fromdate, Date todate,String branchid,String userid,String currencyid,String mode,String acno,
			String dtype,String formdetailcode,String qty2) throws SQLException {


		if(hidclient==null){
			return 0;
		}
		if(hidclient.equalsIgnoreCase("0")){
			return 0;
		}
		try{


			 int salikcount=0,trafficcount=0;
			 String salikqty="",trafficqty="";
			int invdescconfig=getInvDescConfig(conn);
			ClsManualInvoiceBean invoicebean=new ClsManualInvoiceBean();
			String note="";
			note=ledgernote;

			int invoicetypeno=0;	//For Determining from where it was invoiced

			int advance=0,invtypeno=0;	//For Determining Month End Advance
			String rtype="";
			String salikdesc="";
			String trafficdesc="";
			Statement stmtacperiod=conn.createStatement();
			java.sql.Date duedate=null;
			duedate=date;
			String origin=dtype.contains("###")?dtype.split("###")[1]:"";
			String damagedtype=dtype.contains("###")?dtype.split("###")[0]:"";
			String damageinspno="";
			if(damagedtype.equalsIgnoreCase("IND")){
				invoicetypeno=6;
				damageinspno=dtype.split("###")[1];
				//origin="";

			}
			else{
				invoicetypeno=Integer.parseInt(dtype.contains("###")?dtype.split("###")[1]:"");
			}
			//	System.out.println("Invoice Type Code: "+invoicetypeno);
			int agmtvocno=0;
			String agmtrefno="";
			String agmtmrano="";
			Statement stmtagmtvoc=conn.createStatement();
			String stragmtvoc="";
			String agmtregno="";
			String agmtplate="";
			if(cmbagmttype.equalsIgnoreCase("RAG")){
				stragmtvoc="select agmt.voc_no,coalesce(agmt.refno,'') refno,coalesce(agmt.mrano,'') mrano,veh.reg_no,plt.code_name from gl_ragmt agmt left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.doc_no="+agmtno;
			}
			else if(cmbagmttype.equalsIgnoreCase("LAG")){
				stragmtvoc="select agmt.voc_no,coalesce(agmt.refno,'') refno,coalesce(agmt.manualra,'') mrano,veh.reg_no,plt.code_name from gl_lagmt agmt left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)  left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.doc_no="+agmtno;
			}
			if(!stragmtvoc.equalsIgnoreCase("")){
				ResultSet rsagmtvocno=stmtagmtvoc.executeQuery(stragmtvoc);
				while(rsagmtvocno.next()){
					agmtvocno=rsagmtvocno.getInt("voc_no");
					agmtrefno=rsagmtvocno.getString("refno");
					agmtmrano=rsagmtvocno.getString("mrano");
					agmtregno=rsagmtvocno.getString("reg_no");
					agmtplate=rsagmtvocno.getString("code_name");
				}
			}


			double damageamount=0.0;
			String strdelchg="";
			String straddrchg="";
			java.sql.Date tempfromdate=null;
			int aaa=0,testtrno=0;
			//System.out.println(date+"//////"+hidclient+"////"+agmtno+"///"+cmbagmttype);

			String stracperiod="select DATE_ADD(if("+date+" is null,null,'"+date+"'), INTERVAL (select period2 from my_acbook where cldocno="+hidclient+" and dtype='CRM') DAY) duedate";
			//System.out.println(stracperiod);
			ResultSet rsacperiod=stmtacperiod.executeQuery(stracperiod);
			while(rsacperiod.next()){
				duedate=rsacperiod.getDate("duedate");
			}
			//System.out.println("Duedate:"+duedate);
			tempfromdate=fromdate;
			if(!(origin.trim().equalsIgnoreCase("1"))){

				if(cmbagmttype.equalsIgnoreCase("RAG")){
					strdelchg="select (select if(delivery=1,coalesce(delchg,0),0) from gl_ragmt where doc_no="+agmtno+" and del_invno=0) del,(select acno from gl_invmode where idno=6) delacno ";
					straddrchg="select (select coalesce(if(addr=1,addrchg,0),0) addrchg from gl_ragmt where doc_no="+agmtno+" and addr_invno=0 and clstatus=0) addrchg,(select acno from gl_invmode where idno=12) others";
				}
				else if(cmbagmttype.equalsIgnoreCase("LAG")){
					strdelchg="select (select if(delivery=1,coalesce(delchg,0),0) from gl_lagmt where doc_no="+agmtno+" and del_invno=0) del,(select acno from gl_invmode where idno=6) delacno ";
					straddrchg="select (select coalesce(if(addr=1,addrchg,0),0) addrchg from gl_lagmt where doc_no="+agmtno+" and addr_invno=0 and clstatus=0) addrchg,(select acno from gl_invmode where idno=12) others";

				}
				else{

				}
				double delchg=0.0;
				int delacno=0;
				Statement stmtdelchg=conn.createStatement();
				ResultSet rsdelchg=stmtdelchg.executeQuery(strdelchg);
				while(rsdelchg.next()){
					delchg=rsdelchg.getDouble("del");
					delacno=rsdelchg.getInt("delacno");
				}
				stmtdelchg.close();
				double addrchg=0.0;
				int othersacno=0;
				Statement stmtaddrchg=conn.createStatement();
				ResultSet rsaddrchg=stmtaddrchg.executeQuery(straddrchg);
				while(rsaddrchg.next()){
					addrchg=rsaddrchg.getDouble("addrchg");
					othersacno=rsaddrchg.getInt("others");
				}
				int delflag=0,addrflag=0;
				for(int z=0;z<invoicearray.size();z++){
					String strcheckdel=invoicearray.get(z).split("::")[0];
					if(strcheckdel.equalsIgnoreCase("6")){
						delflag=1;
						break;
					}
				}
				for(int z=0;z<invoicearray.size();z++){
					String strcheckaddr=invoicearray.get(z).split("::")[0];
					if(strcheckaddr.equalsIgnoreCase("12")){
						addrflag=1;
						break;
					}
				}
				if(delchg>0 && delflag==0 && (!formdetailcode.equalsIgnoreCase("INS") && !formdetailcode.equalsIgnoreCase("INT"))){
					invoicearray.add("6"+"::"+delacno+"::"+note+"::1::"+delchg+"::"+delchg);
				}
				if(addrchg>0 && addrflag==0 && (!formdetailcode.equalsIgnoreCase("INS") && !formdetailcode.equalsIgnoreCase("INT"))){
					invoicearray.add("12"+"::"+othersacno+"::"+note+"::1::"+addrchg+"::"+addrchg);
				}

				//dtype=session.getAttribute("Code").toString();

				if(hidclient.equalsIgnoreCase("")){
					hidclient="0";
				}
				if(acno.equalsIgnoreCase("")){
					acno="0";
				}

				acno=acno==null?"0":acno;

				Statement stmtcheck=conn.createStatement();
				String strcheck="";
				//Adds 1 Date to From Date if invoice type is Monthly 
				if(invoicearray.get(0).split("::")[0].toString().equalsIgnoreCase("1")){
					if(cmbagmttype.equalsIgnoreCase("RAG") ){
						strcheck="select if((select '"+fromdate+"')>agmt.odate,DATE_ADD('"+fromdate+"',INTERVAL 1 DAY),(select '"+fromdate+"')) fromdate from"+
								" gl_ragmt agmt where  agmt.doc_no="+agmtno+" and agmt.invtype=1";
					}
					if(cmbagmttype.equalsIgnoreCase("LAG")){
						/*strcheck="select if((select count(*) from gl_invm inv left join gl_lagmt agmt on inv.rano=agmt.doc_no where inv.status<>7 and inv.rano="+agmtno+""+
						" and inv.ratype='LAG' and agmt.inv_type=1)>0,(select DATE_ADD('"+fromdate+"',INTERVAL 1 DAY)),(select '"+fromdate+"')) fromdate";*/

						strcheck="select if((select '"+fromdate+"')>agmt.outdate,DATE_ADD('"+fromdate+"',INTERVAL 1 DAY),(select '"+fromdate+"')) fromdate from"+
								" gl_lagmt agmt where  agmt.doc_no="+agmtno+" and agmt.inv_type=1";
					}
					//System.out.println("Invoice Date Check Query:"+strcheck);
					ResultSet rscheck=stmtcheck.executeQuery(strcheck);
					if(rscheck.next()){
						tempfromdate=rscheck.getDate("fromdate");
					}
				}


				if(cmbagmttype.equalsIgnoreCase("RAG")){
					note=objcommon.changeSqltoString(tempfromdate) +" to "+objcommon.changeSqltoString(todate) +" for Rental Agreement no "+agmtvocno;
					rtype=" in ('RA','RD','RW','RF','RM')";
					salikdesc="Salik Invoice for Rental Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
					trafficdesc="Traffic Invoice for Rental Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
				}
				else if(cmbagmttype.equalsIgnoreCase("LAG")){
					note=objcommon.changeSqltoString(tempfromdate) +" to "+objcommon.changeSqltoString(todate) +" for Lease Agreement no "+agmtvocno;
					rtype=" in ('LA','LC')";
					salikdesc="Salik Invoice for Lease Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
					trafficdesc="Traffic Invoice for Lease Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
				}
				
				if(invoicetypeno==6 && invdescconfig==1){
					String strdamagefleet="select insp.rfleet fleet_no,insp.reftype,veh.reg_no,plt.code_name from gl_vinspm insp left join gl_vehmaster veh on insp.rfleet=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where insp.doc_no="+damageinspno;
					ResultSet rsdamagefleet=stmtcheck.executeQuery(strdamagefleet);
					String  damagefleet="";
					String agmtreftype="";
					String damageregno="";
					String damageplate="";
					while(rsdamagefleet.next()){
						damagefleet=rsdamagefleet.getString("fleet_no");
						agmtreftype=rsdamagefleet.getString("reftype");
						damageregno=rsdamagefleet.getString("reg_no");
						damageplate=rsdamagefleet.getString("code_name");
					}
					String damageagmttype="";
					if(agmtreftype.equalsIgnoreCase("RAG")){
						damageagmttype="Rental";
					}
					else if(agmtreftype.equalsIgnoreCase("LAG")){
						damageagmttype="Lease";
					}
					note=" Damage Invoice for fleet "+damagefleet+" of "+damageagmttype+" Agreement "+agmtvocno+" with Reg No "+damageregno+" and Plate Code "+damageplate;
				}

				
				if(!agmtmrano.equalsIgnoreCase("")){
					/*
					 * Overridden for Maxima
					 * */
					//note+=" ("+agmtrefno+")";
					note+=" ("+agmtmrano+")";
				}
				
				if(invdescconfig==1 && invoicetypeno!=6){
					note+=" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
				}

				//Checking Agreement is Monthend Advance
				String stradv="";
				if(cmbagmttype.equalsIgnoreCase("RAG")){
					stradv="select invtype,advchk from gl_ragmt where doc_no="+agmtno;
				}
				else if(cmbagmttype.equalsIgnoreCase("LAG")){
					stradv="select inv_type invtype,adv_chk advchk from gl_lagmt where doc_no="+agmtno;
				}
				Statement stmtadv=conn.createStatement();
				ResultSet rsadv=stmtadv.executeQuery(stradv);
				while(rsadv.next()){
					advance=rsadv.getInt("advchk");
					invtypeno=rsadv.getInt("invtype");
				}




				if(advance==1 && invtypeno==1 && (origin.equalsIgnoreCase("2") || origin.equalsIgnoreCase("3") || origin.equalsIgnoreCase("4") || origin.equalsIgnoreCase("5"))){
					date=tempfromdate;
				}

			}//Closing for Origin
			CallableStatement stmtManual = conn.prepareCall("{call invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			if(invdescconfig==1){
				if(formdetailcode.equalsIgnoreCase("INS")){
					salikqty="0";
					for(int i=0;i< invoicearray.size();i++){
						String[] invoice=invoicearray.get(i).split("::");
						if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
							salikqty=invoice[3];
						}
					}
					String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
					//Overridden for WORLDRAC on 04/05/2017
					String strfromdate="",strtodate="";
					if(fromdate!=null){
						strfromdate=objcommon.changeSqltoString(fromdate);
					}
					if(todate!=null){
						strtodate=objcommon.changeSqltoString(todate);
					}
					note=salikqty+" Saliks of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
				}
				else if(formdetailcode.equalsIgnoreCase("INT")){
					for(int i=0;i< invoicearray.size();i++){
						String[] invoice=invoicearray.get(i).split("::");
						if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
							trafficqty=invoice[3];
						}
					}
					String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
					//Overridden for WORLDRAC on 04/05/2017
					String strfromdate="",strtodate="";
					if(fromdate!=null){
						strfromdate=objcommon.changeSqltoString(fromdate);
					}
					if(todate!=null){
						strtodate=objcommon.changeSqltoString(todate);
					}
					note=trafficqty+" Traffics of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
				}
			}
			
			stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtManual.setDate(1,date);
			stmtManual.setString(2,cmbagmttype);
			stmtManual.setString(3,hidclient);
			stmtManual.setInt(4, agmtno);
			stmtManual.setString(5,origin.equalsIgnoreCase("1")?ledgernote:note);
			stmtManual.setString(6,origin.equalsIgnoreCase("1")?invoicenote:note);
			stmtManual.setString(7,currencyid);
			stmtManual.setString(8,acno);
			stmtManual.setDate(9,tempfromdate);
			stmtManual.setDate(10,todate);
			stmtManual.setString(11,formdetailcode);
			stmtManual.setString(12,userid);
			stmtManual.setString(13,branchid);
			stmtManual.setString(16,mode);
			//		System.out.println(stmtManual);
			stmtManual.executeQuery();
			aaa=stmtManual.getInt("docNo");
			testtrno=stmtManual.getInt("vtrNo");
			//request.setAttribute("tranno", testtrno);
			//	System.out.println("inv vocno"+stmtManual.getInt("voucher"));
			Statement stmtinvoice;
			int testcurid=0;
			double testcurrate=0.0;
			stmtinvoice = conn.createStatement();
			//System.out.println("Currency"+currencyid);

			ResultSet rscurr=stmtinvoice.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+currencyid+"'");
			if(rscurr.next()){
				testcurid=rscurr.getInt("doc_no");
				testcurrate=rscurr.getDouble("c_rate");
			}
			else{
				System.out.println("Currency Error");
				return 0;
			}


			Statement stmtupdatemanual=conn.createStatement();
			String strupdatemanual="update gl_invm set manual="+invoicetypeno+" where doc_no="+aaa;
			int updatemanual=stmtupdatemanual.executeUpdate(strupdatemanual);
			if(updatemanual<0){
				return 0;
			}

			double salikamt=0.0,trafficamt=0.0,generalamt=0.0;
			double otherincome=0.0;
			double salikldr=0.0,trafficldr=0.0,generalldr=0.0;
			double smsamount=0.0;
			int srno=1,ismssend=0;
			int tempno=1;
			for(int i=0;i< invoicearray.size();i++){

				String[] invoice=invoicearray.get(i).split("::");
				//System.out.println(Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString()));
				//System.out.println(testcurrate);
				double testldramt=testcurrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
				double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
				partydramt=objcommon.Round(partydramt, 2);
				double partyldramt=testldramt*-1;
				//double testamt=(double)invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5];
				//System.out.println("Invoice[5]:"+invoice[5]);
				String strqty=invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?"0":invoice[3];
				String temptot=invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?"0":invoice[5];
				String temprate=invoice[4].equalsIgnoreCase("undefined") || invoice[4].isEmpty()?"0":invoice[4];
				if(invoice[0].equalsIgnoreCase("10")){
					damageamount=Double.parseDouble(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?"0":invoice[5]);
					//System.out.println("Dmg Amt: "+damageamount+"////"+invoice[4]+"////"+invoice[5]);
				}
				/*//Deriving rate from total and quantity	
		if(!(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14"))){
			if(Double.parseDouble(strqty.split(" ")[0])<0){
				temprate=Double.parseDouble(temptot)*Double.parseDouble(strqty.split(" ")[0])+"";
			}
			else{
				temprate=Double.parseDouble(temptot)/Double.parseDouble(strqty.split(" ")[0])+"";	
			}

		}
	//Deriving Ends here
				 */		if(Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]))>0){


					 String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+branchid+"','"+aaa+"'"+
							 ",'"+testtrno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+strqty+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+temprate+"')";
					 //		System.out.println(" Invd Sql"+sql);
					 int resultSet = stmtinvoice.executeUpdate (sql);
					 if(resultSet>0){


						 if((!origin.trim().equalsIgnoreCase("1"))){
							 if((Integer.parseInt(invoice[0])==9)|| (Integer.parseInt(invoice[0])==15)){

								 ismssend=1;
								 smsamount=smsamount+Double.parseDouble(invoice[5]);

							 }
						 }


						 if(!(origin.trim().equalsIgnoreCase("1"))){
							 if(invoice[0].equalsIgnoreCase("12") && Double.parseDouble(invoice[5])>0){
								 Statement stmtupdateaddr=conn.createStatement();
								 String strupdateaddr="";
								 if(cmbagmttype.equalsIgnoreCase("RAG")){
									 strupdateaddr="update gl_ragmt set addr_invno="+aaa+" where doc_no="+agmtno;
								 }
								 else if(cmbagmttype.equalsIgnoreCase("LAG")){
									 strupdateaddr="update gl_lagmt set addr_invno="+aaa+" where doc_no="+agmtno;
								 }
								 int updateval=stmtupdateaddr.executeUpdate(strupdateaddr);
								 if(updateval<0){
									 return 0;
								 }
								 stmtupdateaddr.close();
							 }


							 if(invoice[0].equalsIgnoreCase("6") && Double.parseDouble(invoice[5])>0){
								 String strdelivery="";
								 Statement stmtdelivery=conn.createStatement();
								 if(cmbagmttype.equalsIgnoreCase("RAG")){
									 strdelivery="update gl_ragmt set del_invno="+aaa+" where doc_no="+agmtno;
								 }
								 else if(cmbagmttype.equalsIgnoreCase("LAG")){
									 strdelivery="update gl_lagmt set del_invno="+aaa+" where doc_no="+agmtno;
								 }
								 int delval=stmtdelivery.executeUpdate(strdelivery);
								 if(delval<=0){
									 return 0;
								 }
							 }
						 }//Closing for Origin
						 if(cmbagmttype.equalsIgnoreCase("RAG")){
							 String strSqlrcalc="";
							 if(!(origin.trim().equalsIgnoreCase("1"))){
								 strSqlrcalc="insert into gl_rcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+branchid+"','"+testtrno+"',"+
										 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";
							 }
							 else{
								 strSqlrcalc="insert into gl_rcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+branchid+"','"+testtrno+"',"+
										 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
							 }

							 //System.out.println(strSqlrcalc);
							 int rcalcval=stmtinvoice.executeUpdate(strSqlrcalc);

							 if(rcalcval<=0){
								 System.out.println("Rcalc Error");
								 return 0;
							 }


						 }
						 if(cmbagmttype.equalsIgnoreCase("LAG")){
							 String strSqlrcalc="";
							 if(!(origin.trim().equalsIgnoreCase("1"))){
								 strSqlrcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+branchid+"','"+testtrno+"',"+
										 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";
							 }
							 else{
								 strSqlrcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+branchid+"','"+testtrno+"',"+
										 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
							 }
							 //System.out.println(strSqlrcalc);
							 int rcalcval=stmtinvoice.executeUpdate(strSqlrcalc);

							 if(rcalcval<=0){
								 System.out.println("Lcalc Error");
								 return 0;
							 }
						 }
					 }
					 else{
						 System.out.println("Invd Error");
						 return 0;
					 }
					 double invtype=0;
					 String todatecalc="";
					 int monthcalmethod=0;
					 int monthcalvalue=0;
					 //		System.out.println("Origin: "+origin+"//////");

					 //Extra Block for updating agmt invtodate in case of agreement started in monthend
					 Statement stmtdelcal=conn.createStatement();
					 int delcal=0;
					 //Deciding outddate or deliverydate
					 String strdelcal="select method from gl_config where field_nme='delcal'";
					 ResultSet rsdelcal=stmtdelcal.executeQuery(strdelcal);

					 while(rsdelcal.next()){
						 delcal=rsdelcal.getInt("method");
					 }
					 String strcheckdate="";
					 java.sql.Date temptodate=null;
					 //when delivery date must be considered
					 if(delcal==0){
						 if(cmbagmttype.equalsIgnoreCase("RAG")){
							 strcheckdate="select if(delivery=1 and delstatus=1,(select min(din) from gl_vmove where rdocno="+agmtno+" and rdtype='RAG' and "+
									 " trancode='DL' and repno=0),odate) temptodate from gl_ragmt where doc_no="+agmtno;	
						 }
						 else if(cmbagmttype.equalsIgnoreCase("LAG")){
							 strcheckdate="select if(delivery=1 and delstatus=1,(select min(din) from gl_vmove where rdocno="+agmtno+" and rdtype='LAG' and "+
									 "  trancode='DL' and repno=0),outdate) temptodate from gl_lagmt where doc_no="+agmtno;	
						 }

					 }
					 //When Outdate is considered
					 else{
						 if(cmbagmttype.equalsIgnoreCase("RAG")){
							 strcheckdate="select odate temptodate from gl_ragmt where doc_no="+agmtno;
						 }
						 else if(cmbagmttype.equalsIgnoreCase("LAG")){
							 strcheckdate="select outdate temptodate from gl_lagmt where doc_no="+agmtno;
						 }
					 }
					 //System.out.println("Check Date Query: "+strcheckdate);
					 ResultSet rstemptodate=stmtdelcal.executeQuery(strcheckdate);
					 while(rstemptodate.next()){
						 temptodate=rstemptodate.getDate("temptodate");
					 }

					 int samedatestatus=0;
					 String strchecksame="";
					 int startday=0;
					 int closestatus=0;
					 //System.out.println("Check invtype: "+invtype);
					 if(cmbagmttype.equalsIgnoreCase("RAG")){
						 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select invtype,clstatus from gl_ragmt where doc_no="+agmtno);
						 if(rsgetinvtype.next()){
							 invtype=rsgetinvtype.getDouble("invtype");
							 closestatus=rsgetinvtype.getInt("clstatus");
						 }
					 }
					 else if(cmbagmttype.equalsIgnoreCase("LAG")){
						 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select inv_type,clstatus from gl_lagmt where doc_no="+agmtno);
						 if(rsgetinvtype.next()){
							 invtype=rsgetinvtype.getDouble("inv_type");
							 closestatus=rsgetinvtype.getInt("clstatus");
						 }
					 }



					 if(invtype==2){
						 //Checking Out Date and Month End of Out date is same
						 strchecksame="select if('"+temptodate+"'=last_day('"+temptodate+"'),1,0) samedatestatus,day('"+temptodate+"') startday";
						 //System.out.println("Check Same Date Query: "+strchecksame);
						 ResultSet rssamedatestatus=stmtdelcal.executeQuery(strchecksame);
						 while(rssamedatestatus.next()){
							 samedatestatus=rssamedatestatus.getInt("samedatestatus");
							 startday=rssamedatestatus.getInt("startday");
						 }
					 }
					 //Extra Block for updating agmt invtodate in case of agreement started in monthend Ends





					 if(!(origin.trim().equalsIgnoreCase("1"))){
						 if(cmbagmttype.equalsIgnoreCase("RAG") &&  invoice[0].equalsIgnoreCase("1") && Double.parseDouble(invoice[5])>0){
							 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select invtype from gl_ragmt where doc_no="+agmtno);
							 if(rsgetinvtype.next()){
								 invtype=rsgetinvtype.getDouble("invtype");
							 }
							 String tempdate="'"+todate+"'";
							 String sqlra="";
							 if(cmbagmttype.equalsIgnoreCase("RAG")){
								 sqlra="select method,value from GL_CONFIG WHERE FIELD_NME='monthlycal'";
							 }
							 else{
								 sqlra="select method,value from GL_CONFIG WHERE FIELD_NME='lesmonthlycal'";
							 }

							 ResultSet rsgetmonthcal=stmtinvoice.executeQuery(sqlra);
							 while(rsgetmonthcal.next()){
								 monthcalmethod=rsgetmonthcal.getInt("method");
								 monthcalvalue=rsgetmonthcal.getInt("value");
							 }
							 if(monthcalmethod==1){
								 if(invtype==1){
									 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
								 }
								 if(invtype==2){
									 todatecalc="DATE_ADD('"+todate+"',INTERVAL 1 month)";
								 }
							 }
							 else if(monthcalmethod==0){
								 if(invtype==1){
									 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
								 }
								 if(invtype==2){
									 todatecalc="DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)";
								 }
								 /*todatecalc="SELECT DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)";*/
							 }

							 //Checks Out Date and MonthEnd is same
							 if(samedatestatus==1  && invtype==2 && monthcalmethod==0){

								 todatecalc="select LAST_DAY(("+todatecalc+"))";

								 todatecalc="select  if("+startday+">(select day(("+todatecalc+"))),"+
										 " (SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)),(select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)))))";	

							 }
							 if(samedatestatus==0){
								 if(invtype==2){
									if(monthcalmethod==1){
									 int remainday=0;
									 int sameday=0;
									 //	System.out.println("Todatecalc b4: "+todatecalc);
									 Statement stmtremain=conn.createStatement();
									 //	System.out.println(startday);
									 String check="select if("+startday+">(select day(("+todatecalc+"))),"+startday+"-(select day(("+todatecalc+"))),0) remainday,if(day("+todatecalc+")=day(last_day("+todatecalc+")),1,0) sameday";

									 //System.out.println("Get Remainday Query: "+check);
									 ResultSet rsremain=stmtremain.executeQuery(check);
									 while(rsremain.next()){
										 remainday=rsremain.getInt("remainday");
										 sameday=rsremain.getInt("sameday");
									 }
									 if(sameday==1){
										 //	System.out.println("Inside Lastday");
										 todatecalc="select last_day("+todatecalc+")";
									 }
									 else if(remainday>0){
										 todatecalc="select date_add("+todatecalc+",interval "+remainday+" day)";
										 //System.out.println("check todatecalc: "+todatecalc);
									 }
									 else {
										 //	System.out.println("/////////Else//////////");
									 }

									 stmtremain.close();
									}
								}
							 }

							 //			System.out.println("Final Todatecalc: "+todatecalc);
						if(invtype!=3){
							 if(closestatus==0){
								 String strupdate="update gl_ragmt set invdate='"+todate+"',invtodate=("+todatecalc+") where doc_no="+agmtno;
								 //System.out.println("Update Query"+strupdate);
								 int agmtupdate=stmtinvoice.executeUpdate(strupdate);
								 //System.out.println("Agmt Update Value"+agmtupdate);
								 if(agmtupdate<0){
									 System.out.println("Update Ragmt Error");
									 return 0;
								 }
							 }
						}	 
						 }



						 if(cmbagmttype.equalsIgnoreCase("LAG")  && invoice[0].equalsIgnoreCase("1")  && Double.parseDouble(invoice[5])>0){
							 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select inv_type from gl_lagmt where doc_no="+agmtno);
							 if(rsgetinvtype.next()){
								 invtype=rsgetinvtype.getInt("inv_type");
							 }
							 String tempdate="'"+todate+"'";
							 ResultSet rsgetmonthcal=stmtinvoice.executeQuery("select method,value from GL_CONFIG WHERE FIELD_NME='monthlycal'");
							 while(rsgetmonthcal.next()){
								 monthcalmethod=rsgetmonthcal.getInt("method");
								 monthcalvalue=rsgetmonthcal.getInt("value");
							 }
							 if(monthcalmethod==1){
								 if(invtype==1){
									 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
								 }
								 if(invtype==2){
									 todatecalc="DATE_ADD('"+todate+"',INTERVAL 1 month)";
								 }
							 }
							 else if(monthcalmethod==0){
								 if(invtype==1){
									 todatecalc="SELECT LAST_DAY(DATE_ADD('"+todate+"',INTERVAL 1 month))";
								 }
								 if(invtype==2){
									 todatecalc="DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)";
								 }
							 }

							 if(samedatestatus==1 && invtype==2 && monthcalmethod==0){
								 todatecalc="select LAST_DAY(("+todatecalc+"))";

								 todatecalc="select if("+startday+">(select day(("+todatecalc+"))),"+
										 " (SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)),(select LAST_DAY((SELECT DATE_ADD('"+todate+"',INTERVAL 1 month)))))";	

							 }

							 /*if(samedatestatus==0){
					if(invtype==2){
					int remainday=0;
					int sameday=0;
					Statement stmtremain=conn.createStatement();
					String check="select if("+startday+">(select day(("+todatecalc+"))),"+startday+"-(select day(("+todatecalc+"))),0) remainday,if(day("+todatecalc+")=day(last_day("+todatecalc+")),1,0) sameday";

					System.out.println("Get Remainday Query: "+check);
					ResultSet rsremain=stmtremain.executeQuery(check);
					while(rsremain.next()){
						remainday=rsremain.getInt("remainday");
						sameday=rsremain.getInt("sameday");
					}
					if(sameday==1){
						todatecalc="select last_day("+todatecalc+")";
					}
					else if(remainday>0){
						todatecalc="select date_add("+todatecalc+",interval "+remainday+" day)";
							System.out.println("check todatecalc: "+todatecalc);
					}
					else {
						System.out.println("/////////Else//////////");
					}

					stmtremain.close();

				}
				}*/



							 if(closestatus==0){
								 String strupdate="update gl_lagmt set invdate='"+todate+"',invtodate=("+todatecalc+") where doc_no="+agmtno;

								 int agmtupdate=stmtinvoice.executeUpdate(strupdate);
								 if(agmtupdate<0){
									 System.out.println("Lagmt Error");
									 return 0;
								 }
							 }
						 }

						 if(!(origin.trim().equalsIgnoreCase("1"))){
							 if(invoice[0].equalsIgnoreCase("18") && Double.parseDouble(invoice[5])>0){
								 Statement stmtotherincome=conn.createStatement();
								 //System.out.println("Inside Other Income Update SQL");
								 String strotherincome="update gl_lothser set invno="+aaa+",invstatus=1 where rdocno="+agmtno+" and invstatus=0";
								 int otherincomeval=stmtotherincome.executeUpdate(strotherincome);
								 if(otherincomeval<0){
									 //				System.out.println("OtherIncome Update error");
									 //conn.close();
									 System.out.println(" Update Other Income Error");
									 return 0;
								 }
							 }

						 }

					 }//Closing for Origin



					 if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
						 salikamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
						 salikcount++;
						 salikqty=invoice[3];
					 }

					 else if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
						 trafficamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
						 trafficcount++;
						 trafficqty=invoice[3];
					 }
					 //trafficldr=testcurrate*trafficamt;

					 else{
						 generalamt=objcommon.Round(generalamt+Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5])),2);
						 //			System.out.println("Check General Amount:"+generalamt);
					 }
					 salikldr=testcurrate*salikamt;
					 trafficldr=testcurrate*trafficamt;
					 generalldr=testcurrate*generalamt;

					 String sqljv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							 "doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+testtrno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
							 "'"+partydramt+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(i+1)+"',"+
							 "'"+branchid+"','"+note+"',"+
							 "0,'"+date+"','"+formdetailcode+"','"+partyldramt+"','"+aaa+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
							 "'"+testcurid+"','5',1,0,3,'"+agmtno+"','"+cmbagmttype+"')";
					 //		System.out.println("SqlJV2"+sqljv2);
					 int rsjv2=stmtinvoice.executeUpdate(sqljv2);
					 if(rsjv2>0){


						 Statement stmtcostentry=conn.createStatement();
						 String strcostentry="select costentry from gl_invmode where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1]);
						 int costentry=0;
						 ResultSet rscostentry=stmtcostentry.executeQuery(strcostentry);
						 while(rscostentry.next()){
							 costentry=rscostentry.getInt("costentry");
						 }
						 if(costentry==1){
							 Statement stmtgettran=conn.createStatement();
							 String strgettran="select tranid from my_jvtran where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+" and tr_no="+testtrno;
							 //	System.out.println("GetTran Query:"+strgettran);
							 ResultSet rsgettran=stmtgettran.executeQuery(strgettran);
							 int temptranid=0;
							 while(rsgettran.next()){
								 temptranid=rsgettran.getInt("tranid");
							 }
							 int count=0;
							 ArrayList<String> costmovarray=new ArrayList<String>();
							 Statement stmtcostmov=conn.createStatement();
							 double temptimediff=0.0;
							 String tempcostfleet="";
							 String strtemptimediff="select (TIMESTAMPDIFF(second,'"+fromdate+" 00:00:00' ,'"+todate+" 23:59:59'))/(60*60) temptimediff";
							 Statement stmttemptimediff=conn.createStatement();
							 //			System.out.println("TemptimeDiff Sql:"+strtemptimediff);
							 ResultSet rstemptimediff=stmtcostmov.executeQuery(strtemptimediff);
							 while(rstemptimediff.next()){
								 temptimediff=rstemptimediff.getDouble("temptimediff");

							 }
							 //			System.out.println("TimeDiffer In Hours:"+temptimediff);
							 stmttemptimediff.close();
							 String strcostmov="";
							 if(damagedtype.equalsIgnoreCase("IND")){
								 strcostmov="select 0 hourdiff,rfleet fleet_no from gl_vinspm where doc_no="+damageinspno;
								 //System.out.println("Damage Get Cost Entry Query: "+strcostmov);
							 }
							 else{
								 strcostmov="select sum(aa.hourdiff) hourdiff,aa.fleet_no from("+
										 " select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno from ("+
										 " select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout) as datetime))"+
										 " dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(coalesce(concat(din,' ',tin),'"+todate+" 23:59:59') as datetime)) din,tin"+
										 " from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"'  and trancode<>'DL'  and (dout between '"+fromdate+"' and '"+todate+"' or  coalesce(din,'"+todate+"')"+
										 " between '"+fromdate+"' and '"+todate+"')) kk)aa group by aa.fleet_no ";
								 /*String strcostmov="select (TIMESTAMPDIFF(second,dout ,coalesce(din,'"+todate+"')))/(60*60) hourdiff,fleet_no,kk.repno from ("+
					" select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout)"+
					" as datetime)) dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(concat(din,' ',tin) as datetime))"+
					" din,tin from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"' and (dout between '"+fromdate+"' and '"+todate+"' or "+
					" coalesce(din,'"+todate+"') between '"+fromdate+"' and '"+todate+"') group by fleet_no )kk";*/
								 //System.out.println("Cost Mov Sql:"+strcostmov);
							 }
							 ResultSet rscostmov=stmtcostmov.executeQuery(strcostmov);
							 int counter=0;
							 while(rscostmov.next()){

								 //count=rscostmov.getInt("repno");
								 //	if(count==0){
								 costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
								 //System.out.println(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
								 counter++;
								 /*	}
				if(count>0){
					double tempamt=(Double.parseDouble(rscostmov.getString("hourdiff"))/temptimediff)*partydramt;
					costmovarray.add(tempamt+""+"::"+rscostmov.getString("fleet_no"));

				}*/


							 }
							 stmtcostmov.close();
							 Statement stmtcostinsert=conn.createStatement();
							 for(int j=0;j<costmovarray.size();j++){
								 //				System.out.println("============================================="+i);
								 if(counter==1){

									 String costmov=costmovarray.get(j);
									 String costmovamt=costmov.split("::")[0];
									 String costmovfleet=costmov.split("::")[1];
									 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
											 ",6,"+partydramt+","+srno+","+temptranid+",0,"+costmovfleet+","+testtrno+")";
									 //System.out.println("Insert Costtran Sql:"+strcostinsert);
									 srno++;
									 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
									 if(costinsertval<0){
										 //conn.close();
										 System.out.println("Cost Insert Error");
										 return 0;
									 }

								 }
								 else if(counter>1){
									 String costmov=costmovarray.get(j);
									 String costmovamt=costmov.split("::")[0];
									 String costmovfleet=costmov.split("::")[1];
									 double amt=(Double.parseDouble(costmovamt)/temptimediff)*partydramt;
									 //System.out.println("Total Amt:"+amt+":::costmovamt="+costmovamt+":::::::::TempTime Diff="+temptimediff+":::::::::Amount="+partydramt);
									 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
											 ",6,"+amt+","+srno+","+temptranid+",0,"+costmovfleet+","+testtrno+")";
									 //			System.out.println("Insert Costtran Sql:"+strcostinsert);
									 srno++;
									 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
									 if(costinsertval<0){
										 //conn.close();
										 System.out.println("Cost Insert Error2");
										 return 0;
									 }

								 }
							 }
							 stmtcostinsert.close();

						 }
						 else{

						 }

					 }	

					 else{
						 //			System.out.println("General Jvtran error");
						 //conn.close();
						 System.out.println("Jvtran Error");
						 return 0;
					 }


				 }
				 tempno++;	
			}

			if(ismssend>0){

				sendSMS(aaa+"", branchid, dtype, smsamount+"", hidclient,"",conn);

			}

			if(salikamt>0){
				//		System.out.println("SalikAMt: "+salikamt+"::::::::::::::::Origin: "+origin.trim().equalsIgnoreCase("")+"========="+origin.trim()+"////////");
				if(!(origin.trim().equalsIgnoreCase("1"))){
					Statement stmtsalik=conn.createStatement();
					//System.out.println("Heere inside salik");
					String strupdatesalik="";
					if(invoicetypeno==8){
						strupdatesalik="update gl_salik set inv_no="+aaa+",inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1 and rtype "+rtype+" and "+
								" sal_date>='"+fromdate+"' and sal_date<='"+todate+"' and inv_no=0";	
					}
					else{
						strupdatesalik="update gl_salik set inv_no="+aaa+",inv_type='INV',status=1 where ra_no="+agmtno+" and  isallocated=1 and rtype "+rtype+" and "+
								" sal_date<='"+todate+"' and inv_no=0";	
					}
					//		System.out.println("Update Salik:"+strupdatesalik);
					int val=stmtsalik.executeUpdate(strupdatesalik);
					if(val<0){
						System.out.println("Salik Update Error");
						//conn.close();

						return 0;
					}


				}//Closing for origin (salik update)
				String saliknote=""+salikqty+" Saliks";
				/*String saliknote=note;*/
				if(invdescconfig==1){
					String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
					//saliknote="Salik Charges "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno+" NOS - "+salikcount;
					//Overridden for WORLDRAC on 04/05/2017
					String strfromdate="",strtodate="";
					if(fromdate!=null){
						strfromdate=objcommon.changeSqltoString(fromdate);
					}
					if(todate!=null){
						strtodate=objcommon.changeSqltoString(todate);
					}
					saliknote=salikqty+" Saliks of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+""+" with Reg No "+agmtregno;
				}
				String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+acno+"',"+
						"'"+salikamt+"','"+testcurrate+"','"+testcurid+"',0,1,8,"+
						"'"+branchid+"','"+saliknote+"',"+
						"0,'"+date+"','"+formdetailcode+"','"+salikldr+"','"+aaa+"','"+qty2+"',"+
						"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
				//System.out.println("SqlJV"+sqljv);
				int rsjv=stmtinvoice.executeUpdate(sqljv);
				if(rsjv>0){

				}
				else{
					System.out.println("Jvtran salik Error");
					return 0;
				}
			}

			if(trafficamt>0){
			//	System.out.println("==trafficamt==="+trafficamt);
			//	System.out.println("==origin.trim()==="+origin.trim());
				String temptrafficdesc="";
				if(!(origin.trim().equalsIgnoreCase("1"))){
					Statement stmttraffic=conn.createStatement();
					String strupdatetraffic="";
					if(invoicetypeno==9){
						strupdatetraffic="update gl_traffic set inv_no="+aaa+",inv_desc='"+trafficdesc+"',inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1  and rtype "+rtype+" and emp_type='CRM' and traffic_date>='"+fromdate+"' and traffic_date <= '"+todate+"' and inv_no=0";	
					}
					else{
						strupdatetraffic="update gl_traffic set inv_no="+aaa+",inv_desc='"+trafficdesc+"',inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1  and rtype "+rtype+" and emp_type='CRM' and traffic_date <= '"+todate+"' and inv_no=0";
					}
//					System.out.println("strupdatetraffic :"+strupdatetraffic);
					//System.out.println("Update Traffic:"+strupdatetraffic);
					int val=stmttraffic.executeUpdate(strupdatetraffic);
					//System.out.println("Update Traffic Val:"+val+":::"+strupdatetraffic);
					if(val<0){
						System.out.println("Traffic Update Error");
						//conn.close();
						return 0;
					}
					
					
					try
					{
						String  traffic_date="";
						
						String sql="select concat(ticket_no,' - ',DATE_FORMAT(traffic_date, '%d-%m-%Y')) trafficdesc,concat(ticket_no,' REG.NO ',regno ,' at ',DATE_FORMAT(traffic_date, '%d-%m-%Y'),' ',time) as trdates from gl_traffic t where inv_no='"+aaa+"'";
						Statement stmt=conn.createStatement();
						ResultSet rs1 = stmt.executeQuery(sql);

//						System.out.println("select concat(ticket_no,' against ',regno,' at ',DATE_FORMAT(traffic_date, '%d-%m-%Y'),' ',time) as trdates from gl_traffic t where inv_no='"+aaa+"'");

						int k=0;
						while(rs1.next())
						{
							
							if(k==0){
								traffic_date=rs1.getString("trdates");
								temptrafficdesc+=rs1.getString("trafficdesc");
							}
							else{
								traffic_date=traffic_date+","+rs1.getString("trdates");
								temptrafficdesc+=","+rs1.getString("trafficdesc");
							}

							k++;

						}
						
						rs1.close();
						sendSMS(aaa+"", branchid, dtype, trafficamt+"", hidclient,traffic_date,conn);
					}catch(Exception e){e.printStackTrace();}


				}//Closing for origin (Traffic Update)

				String trafficnote=""+trafficqty+" Traffics";
				//String trafficnote=note;
				if(invdescconfig==1){
					// System.out.println("Inside Traffic Description");
					String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
					//trafficnote=temptrafficdesc+" - "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno;
					//Overridden for WORLDRAC on 04/05/2017
					String strfromdate="",strtodate="";
					if(fromdate!=null){
						strfromdate=objcommon.changeSqltoString(fromdate);
					}
					if(todate!=null){
						strtodate=objcommon.changeSqltoString(todate);
					}
					trafficnote=trafficqty+" Traffics of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno;
				}
				// System.out.println("description ==== "+trafficnote);
				String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+acno+"',"+
						"'"+trafficamt+"','"+testcurrate+"','"+testcurid+"',0,1,9,"+
						"'"+branchid+"','"+trafficnote+"',"+
						"0,'"+date+"','"+formdetailcode+"','"+trafficldr+"','"+aaa+"','"+qty2+"',"+
						"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
				//	System.out.println("SqlJV"+sqljv);
				int rsjv=stmtinvoice.executeUpdate(sqljv);
				if(rsjv>0){

				}
				else{
					System.out.println("Jvtran Traffic Error");
					//conn.close();
					return 0;
				}
			}


			//Tax Portion Starts Here
			//	System.out.println("Default General Amount:"+generalamt);
			//if(!(origin.trim().equalsIgnoreCase("1"))){
				Statement stmtchecktax=conn.createStatement();
				String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+hidclient+" and dtype='CRM') clienttaxmethod";
				System.out.println(strchecktax);
				ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
				int taxstatus=0;
				int clienttaxmethod=0;
				while(rschecktax.next()){
					taxstatus=rschecktax.getInt("taxmethod");
					clienttaxmethod=rschecktax.getInt("clienttaxmethod");
				}
				if(taxstatus==1 && clienttaxmethod==1){
						System.out.println("Inside TaxDetail");
					
					// Getting amount in which tax is applicable
					Statement stmtgettax=conn.createStatement();
					String strtaxapplied="select total from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+aaa;
					ResultSet rsapplied=stmtgettax.executeQuery(strtaxapplied);
					double generalamttax=0.0;
					while(rsapplied.next()){
						generalamttax+=rsapplied.getDouble("total");
					}
					int igststatus=0;
					String strigst="select igststatus from gl_ragmt where doc_no="+agmtno;
					ResultSet rsigst=stmtchecktax.executeQuery(strigst);
					while(rsigst.next()){
						igststatus=rsigst.getInt("igststatus");
					}
					String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+date+"' between tax.fromdate and tax.todate";
					double setpercent=0.0;
					double vatpercent=0.0;
					ResultSet rsgettax=stmtgettax.executeQuery(strgettax);
					double vatval=0.0,setval=0.0;
					ArrayList<String> temptaxarray=new ArrayList<>();
					while(rsgettax.next()){
						setpercent=rsgettax.getDouble("set_per");
						vatpercent=rsgettax.getDouble("vat_per");
						vatval=(generalamttax*(vatpercent/100));
						setval=generalamttax*(setpercent/100);
						setval=objcommon.Round(setval, 2);
						vatval=objcommon.Round(vatval, 2);
						if(igststatus==1){
							if(rsgettax.getInt("idno")==21){
								if(setval>0.0){
									temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+setval+"::"+rsgettax.getString("description"));
									generalamt+=setval;
								}
							}
						}
						else{
							if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
								if(vatval>0.0){
									temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
									generalamt+=vatval;
								}
							}
						}
					}
					if(setpercent>0.0 || vatpercent>0.0){
						
						/*if(damageamount>0){
							//System.out.println("Damage amount: "+damageamount+"//////General Amount: "+generalamt);
							vatval=((generalamt-damageamount)*(vatpercent/100));	

						}
						else{
							vatval=(generalamttax*(vatpercent/100));
						}*/
						//setval=objcommon.Round(setval, 2);
						//vatval=objcommon.Round(vatval, 2);
						//generalamt=generalamt+setval;

						generalamt=objcommon.Round(generalamt, 2);

						
						//generalamt=generalamt+vatval;
						generalamt=objcommon.Round(generalamt, 2);
						generalldr=generalamt*testcurrate;

						/*Statement stmtgetinvmode=conn.createStatement();
						String strgetinvmode="select (select acno from gl_invmode where idno=19) setacno,(select acno from gl_invmode where idno=20) vatacno";
						ResultSet rsinvmode=stmtgetinvmode.executeQuery(strgetinvmode);
						ArrayList<String> temptaxarray=new ArrayList<>();
						while(rsinvmode.next()){
							temptaxarray.add(19+"::"+rsinvmode.getString("setacno")+"::"+setval+"::"+"SET");
							temptaxarray.add(20+"::"+rsinvmode.getString("vatacno")+"::"+vatval+"::"+"VAT");
						}*/
						int tempsrno=invoicearray.size()+1;
						for(int j=0;j<temptaxarray.size();j++){
							String[] tax=temptaxarray.get(j).split("::");
							Statement stmttaxinvd=conn.createStatement();
							if(Double.parseDouble(tax[2])>0){
								String strtaxinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+branchid+"','"+aaa+"'"+
										",'"+testtrno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
											System.out.println("Invd Sql:"+strtaxinvd);
								int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
								if(taxinvdval>0){
									String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
											"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+testtrno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
											"'"+Double.parseDouble(tax[2])*-1+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(tempsrno)+"',"+
											"'"+branchid+"','"+note+"',"+
											"0,'"+date+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*testcurrate)*-1+"','"+aaa+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
											"'"+testcurid+"','5',1,'"+hidclient+"',3,'"+agmtno+"','"+cmbagmttype+"')";
									tempsrno++;
									Statement stmttaxjv=conn.createStatement();
													System.out.println("Jvtran Sql:"+strtaxjv);
									int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
									if(taxjvval>0){

									}
									else{
										System.out.println("Jvtran Tax Error");
										return 0;
									}
									stmttaxjv.close();
									stmttaxinvd.close();
								}
								else{
									System.out.println("Tax Invd Error");
									return 0;
								}
							}
						}
						stmtchecktax.close();
						//stmtgetinvmode.close();
						stmtgettax.close();
					}

				}


			//}//Closing for origin (Tax)
			//If Tax Method is Disabled in gl_config
			if(generalamt>0){

				double ramt=Math.round(generalamt);
				double ramtldr=ramt*testcurrate;
				double discount = (generalamt-ramt);
				discount=objcommon.Round(discount, 2);
				/*discount=Math.round(discount*-1);*/
				//System.out.println("Check:"+Math.scalb(discount, 2));
				double discountldr=discount*testcurrate;
				// System.out.println("R Amt:"+ramt+"::::::::::Discount:"+discount+"General Amt:"+generalamt);
				// discount a/c jvtran  discount*-1   
				Statement stmtdiscount=conn.createStatement();
				String strdiscount="select acno discountacno from gl_invmode where idno=13";
				ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
				int  discac=0;
				while(rsdiscount.next()){
					discac=rsdiscount.getInt("discountacno");
				}
				if(discount!=0.0){
					Statement stmtdiscjv=conn.createStatement();
					Statement stmtdiscinvd=conn.createStatement();
					String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+branchid+"','"+aaa+"'"+
							",'"+testtrno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
					int discinvd=stmtdiscinvd.executeUpdate(sql);
					if(discinvd<=0){
						stmtdiscinvd.close();
						stmtdiscjv.close();
						stmtdiscount.close();
						conn.close();
						return 0;
					}
					stmtdiscinvd.close();
								System.out.println(" Invd Sql"+sql);
					int discid=0;
					if(discount>0.0){
						discid=1;
					}
					else if(discount<0.0){
						discid=-1;
					}
					String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+discac+"',"+
							"'"+discount+"','"+testcurrate+"','"+testcurid+"',0,"+discid+",1,"+
							"'"+branchid+"','Discount',"+
							"0,'"+date+"','"+formdetailcode+"','"+discountldr+"','"+aaa+"','"+qty2+"',"+
							"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
					int discval=stmtdiscjv.executeUpdate(sqljvdisc);
					if(discval<=0){
						stmtdiscjv.close();
						stmtdiscount.close();
						conn.close();
						return 0;

					}
					stmtdiscjv.close();
					stmtdiscount.close();
				}

				String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
						"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+acno+"',"+
						"'"+ramt+"','"+testcurrate+"','"+testcurid+"',0,1,1,"+
						"'"+branchid+"','"+note+"',"+
						"0,'"+date+"','"+formdetailcode+"','"+ramtldr+"','"+aaa+"','"+qty2+"',"+
						"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
						System.out.println("General Jv sql:"+sqljv);
				int rsjv=stmtinvoice.executeUpdate(sqljv);
				if(rsjv>0){
							System.out.println("Inside general jv");	
				}
				else{
					System.out.println("General jvtran error");
					//conn.close();
					return 0;
				}
				stmtdiscount.close();
			}	
//			System.out.println("no====="+aaa);
			invoicebean.setDocno(aaa);
			String testjv1="select dramount from my_jvtran where tr_no="+testtrno;
			ResultSet rstestjv1=stmtinvoice.executeQuery(testjv1);
//						 System.out.println("Test Sum Jvtran"+testjv1);
				while(rstestjv1.next()){
//				System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
				}
			if (aaa > 0) {
					
				//			System.out.println("InvNo > 0");

				String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+testtrno;
				ResultSet rstestjv=stmtinvoice.executeQuery(testjv);
				//			System.out.println("Test Sum Jvtran"+testjv);
				while(rstestjv.next()){
					//	System.out.println("jv vvalue"+rstestjv.getDouble("dramount"));
					if(rstestjv.getDouble("dramount")==0.00){
						//	System.out.println("testjv"+rstestjv.getDouble("dramount"));
						//	System.out.println("Success"+invoicebean.getDocno());

						stmtinvoice.close();
						stmtManual.close();
						//	conn.close();
						return aaa;
					}
					else{
						stmtinvoice.close();
						stmtManual.close();
						//conn.close();
						System.out.println("Jv tally Error");
						return 0;
					}
				}

			}

		}catch(Exception e){	
			e.printStackTrace();	
			conn.close();
			System.out.println("Exception error");
			return 0;
		}
		/*finally{
			conn.close();

		}*/
		//System.out.println("Outer Return");
		//System.out.println("Outer return error");
		return 0;
	}

private int getInvDescConfig(Connection conn) {
		// TODO Auto-generated method stub
		int invdesc=0;
		try{
			Statement stmt=conn.createStatement();
			String str="select method from gl_config where field_nme='invdesc'";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				invdesc=rs.getInt("method");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return invdesc;
	}

	public   ClsManualInvoiceBean getPrint(String fromno,String tono,String branch,String printdocno,String allbranch,String hidheader) throws SQLException {
		//ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
		Connection  conn =null;
		HttpServletRequest request=ServletActionContext.getRequest();
		ArrayList<ClsManualInvoiceAction> employees = new ArrayList();
		try {
			conn= objconn.getMyConnection();
			ClsNumberToWord obj=new ClsNumberToWord();
			ClsAmountToWords objamt=new ClsAmountToWords();
			Statement stmtinvoice = conn.createStatement ();
			String strSql="";
			//System.out.println("Print Docno:"+printdocno);
			//System.out.println("Check2:"+agmttype);
			/*if(agmttype.equalsIgnoreCase("RAG")){
				strSql="select ac.acno,br.branch,year(inv.date) dateyear,agmt.pono,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,cur.code,cmp.company,cmp.address,cmp.tel,cmp."+
			" fax,br.branchname,ac.refname,ac.com_mob,ac.per_mob,ac.fax1,dr.name,inv.doc_no, DATE_FORMAT(inv.date,'%d/%m/%Y') date,inv.rano,"+
			" DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate, DATE_FORMAT(inv.todate,'%d/%m/%Y') todate,inv.acno, inv.ratype,"+
			" hed.description,agmt.ofleet_no,agmt.mrano,DATE_FORMAT(agmt.odate,'%d/%m/%Y') agmtdate,veh.flname,veh.reg_no,plt.code_name,"+
			" auth.authname, round(sum(invd.total),2) total, round(sum(invd.total),2) nettotal,dr.name driven,ac.address,"+
			" ac.address2,loc.loc_name from gl_invm inv left join gl_invd invd on inv.doc_no=invd.rdocno left join gl_ragmt agmt on"+
			" inv.rano=agmt.doc_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')  left join my_head hed on"+
			" inv.acno=hed.doc_no  left join gl_vehmaster veh on agmt.ofleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no"+
			" left join gl_vehauth auth on veh.authid=auth.doc_no left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_drdetails dr"+
			" on (agmt.drid=dr.dr_id or rdr.drid=dr.dr_id) left join my_brch br on inv.brhid=br.doc_no left join my_comp cmp on"+
			" br.cmpid=cmp.doc_no left join my_curr cur on cmp.curid=cur.doc_no left join my_locm loc on loc.brhid=br.doc_no where inv.doc_no >="+fromno+" and inv.doc_no<="+tono+" group by inv.doc_no";
			}
			if(agmttype.equalsIgnoreCase("LAG")){
				strSql="select ac.acno,br.branch,year(inv.date) dateyear,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,cur.code,cmp.company,cmp.address,cmp.tel,cmp.fax,br.branchname,"+
						"ac.refname,coalesce(ac.com_mob,'') com_mob,ac.per_mob,ac.fax1,coalesce(dr.name,'') name, inv.doc_no,DATE_FORMAT(inv.date,"+
						" '%d/%m/%Y') date,inv.rano,DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate,coalesce(DATE_FORMAT(inv.todate,'%d/%m/%Y'),'') todate,"+
						" inv.acno, inv.ratype,hed.description,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)ofleet_no,coalesce(DATE_FORMAT(agmt.outdate,'%d/%m/%Y'),'')"+
						" agmtdate,veh.flname,veh.reg_no,plt.code_name,auth.authname, round(sum(invd.total),2) total, round(sum(invd.total),2) nettotal,"+
						" coalesce(dr.name,'') driven,ac.address,ac.address2,loc.loc_name from gl_invm inv left join gl_invd invd on inv.doc_no=invd.rdocno"+
						" left join gl_lagmt agmt on inv.rano=agmt.doc_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')  left join"+
						" my_head hed on inv.acno=hed.doc_no  left join gl_vehmaster veh on ((select if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)"+
						" ofleet_no)=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_vehauth auth on veh.authid=auth.doc_no"+
						" left join gl_ldriver rdr on agmt.doc_no=rdr.rdocno left join gl_drdetails dr on (agmt.drid=dr.dr_id or rdr.drid=dr.dr_id)"+
						" left join my_brch br on inv.brhid=br.doc_no left join my_comp cmp on br.cmpid=cmp.doc_no left join my_curr cur on"+
						" cmp.curid=cur.doc_no left join my_locm loc on loc.brhid=br.doc_no where inv.doc_no >="+fromno+" and inv.doc_no<="+tono+" group by inv.doc_no";
			}*/
			//System.out.println(strSql);

			String sqltest="";
			/*if(!fromno.equalsIgnoreCase("") && !tono.equalsIgnoreCase("")){
				sqltest+=" and inv.voc_no >="+fromno+" and inv.voc_no<="+tono+"";
			}
			if(fromno.equalsIgnoreCase("") && tono.equalsIgnoreCase("")){
				if(!printdocno.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no in ("+printdocno+")";	
				}

			}
			if(!printdocno.equalsIgnoreCase("")){
				sqltest+=" and inv.voc_no in ("+printdocno+")";
			}
			else{
				if(!fromno.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no>="+fromno+"";
				}
				if(!tono.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no<="+tono+"";
				}
			}*/

			if(allbranch.equalsIgnoreCase("1")){
				sqltest+=" and inv.doc_no in ("+printdocno+")";
			}
			else{
				if(!printdocno.equalsIgnoreCase("")){
					sqltest+=" and inv.voc_no in ("+printdocno+") and inv.brhid="+branch;
				}
				else{
					if(!fromno.equalsIgnoreCase("")){
						sqltest+=" and inv.voc_no>="+fromno+"";
					}
					if(!tono.equalsIgnoreCase("")){
						sqltest+=" and inv.voc_no<="+tono+"";
					}
					if(!branch.equalsIgnoreCase("")){
						sqltest+=" and inv.brhid="+branch;
					}
				}

			}

			ArrayList<Double> totalarray=new ArrayList<>();
			ArrayList<String> totalstringarray=new ArrayList<>();
			String strtotal="select round(sum(coalesce(total,0)),2) total,inv.doc_no from gl_invm inv left join gl_invd on doc_no=rdocno where 1=1 "+sqltest+" and inv.status<>7 group by doc_no order by doc_no";
			ResultSet rstotal=stmtinvoice.executeQuery(strtotal);

			while(rstotal.next()){
				totalarray.add(rstotal.getDouble("total"));
				totalstringarray.add(rstotal.getString("total"));
			}

			String stremc="select concat('Reg No :',agmt.emcregno,' ',agmt.emcplate) emccustomervehicle,concat('Fleet No :',veh.fleet_no,' ',veh.flname,' Reg No :',"+
			" reg_no,' ',plt.code_name) emccourtesyvehicle from gl_invm inv left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG') left join "+
			" gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where 1=1 "+sqltest;
			
			ResultSet rsemc=stmtinvoice.executeQuery(stremc);
			while(rsemc.next()){
				bean.setLblcustomervehicle(rsemc.getString("emccustomervehicle"));
				bean.setLblcourtesyvehicle(rsemc.getString("emccourtesyvehicle"));
			}
			
			strSql="select coalesce(inv.ldgrnote,'') ledgernote,datediff(inv.todate,inv.fromdate) creditdiff,insp.doc_no inspno,inspveh.reg_no inspregno,inv.dtype,coalesce(if(inv.ratype='RAG',agmt.refno,lagmt.refno),'') refno,case when inv.ratype='RAG' then agmt.otime when inv.ratype='LAG' then lagmt.outtime else '' end invfromtime,"+
					" case when inv.ratype='RAG' and inv.manual=3 then agmtcl.intime when inv.ratype='RAG' and inv.manual<>3 then agmt.otime when"+
					" inv.ratype='LAG' and inv.manual=5 then lagmtcl.intime when inv.ratype='LAG' and inv.manual<>5 then lagmt.outtime else '' end invtotime,sal.sal_name salesman,"+
					" inv.voc_no, br.pbno,br.stcno,br.cstno,coalesce(dr.name,dr1.name) driven,inv.fromdate sqlfromdate,inv.todate sqltodate,br.branch,year(inv.date) dateyear,agmt.pono,"+
					" DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,cur.code,cmp.company,cmp.address ,cmp.tel,cmp.fax,cmp.email,cmp.web website,br.branchname,ac.refname,ac.com_mob,ac.per_tel,ac.per_mob,ac.fax1,dr.name,"+
					" inv.doc_no, DATE_FORMAT(inv.date,'%d/%m/%Y') date,if(inv.ratype='RAG',if(agmt.refno is not null,concat(agmt.voc_no,' (',agmt.refno,')'),agmt.voc_no),if(lagmt.refno is not null,concat(lagmt.voc_no,' (',lagmt.refno,')'),lagmt.voc_no)) rano1,inv.rano,DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate,"+
					" DATE_FORMAT(inv.todate,'%d/%m/%Y') todate,ac.codeno,inv.acno, inv.ratype,if(inv.ratype='RAG',agmt.ofleet_no,veh.fleet_no) ofleet_no,"+
					" if(inv.ratype='RAG',agmt.mrano,lagmt.manualra) mrano,coalesce(DATE_FORMAT(agmt.odate,'%d/%m/%Y'),"+
					" DATE_FORMAT(lagmt.outdate,'%d/%m/%Y')) agmtdate,veh.flname,veh.reg_no,plt.code_name,auth.authname,ac.address cladd,ac.address2 cladd1,lc.loc_name,u.user_name,DATE_FORMAT(date_add(inv.date , interval ac.period2 day),'%d/%m/%Y') duedate"+
					" from gl_invm inv"+
					" left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"+
					" left join gl_lagmt lagmt on(inv.rano=lagmt.doc_no and inv.ratype='LAG')"+
					" left join gl_ragmtclosem agmtcl on (agmt.doc_no=agmtcl.agmtno)"+
					" left join gl_lagmtclosem lagmtcl on (lagmt.doc_no=lagmtcl.agmtno)"+
					" left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on (ac.sal_id=sal.doc_no and ac.dtype='CRM')"+
					" left join gl_vehmaster veh on ((agmt.ofleet_no=veh.fleet_no  and inv.ratype='RAG') or ((select if(perfleet=0,tmpfleet,perfleet) fleet from gl_lagmt"+
					" where doc_no=inv.rano)=veh.fleet_no and inv.ratype='LAG'))"+
					" left join gl_vehplate plt on veh.pltid=plt.doc_no"+
					" left join gl_vehauth auth on veh.authid=auth.doc_no"+
					" left join (select min(srno) srno,rdocno from gl_rdriver where status=3 group by rdocno) gdr on  agmt.doc_no=gdr.rdocno "+
					" left join gl_rdriver rdr on  agmt.doc_no=rdr.rdocno and rdr.srno=gdr.srno "+ 
					" left join (select min(srno) srno,rdocno from gl_ldriver where status=3 group by rdocno) gldr on  lagmt.doc_no=gldr.rdocno "+
					" left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno and ldr.srno=gldr.srno  "+
					" left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
					" left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
					" left join my_brch br on inv.brhid=br.doc_no"+
					" left join my_comp cmp on br.cmpid=cmp.doc_no"+
					" left join my_curr cur on cmp.curid=cur.doc_no"+
					" left join gl_vinspm insp on inv.doc_no=insp.invno"+
					" left join gl_vehmaster inspveh on insp.rfleet=inspveh.fleet_no"+
					" inner join my_locm l on l.brhid=br.doc_no"+
					" inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no)"+
					" left join my_user u on u.doc_no=inv.userid where 1=1 "+sqltest+" and inv.status<>7 group by inv.doc_no";

			//System.out.println("Print query:"+strSql);
			/*String strSqldetail="select invd.sr_no,imod.description,invd.units,invd.amount,invd.total from gl_invd invd left join gl_invmode imod on "+
								" invd.chid=imod.idno where invd.rdocno >="+fromno+" and invd.rdocno<="+tono+"";
			//System.out.println("Detail"+strSqldetail);
			 */			
			ArrayList<ArrayList<String>> printdet=new ArrayList<>();
			ArrayList<ArrayList<String>> printfleetmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printsalikmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficdubaimaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficelsemaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printdamagemaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printagmtdetailmaster=new ArrayList<>();
			ResultSet resultSet = stmtinvoice.executeQuery (strSql);
			int i=0;
			String ledgernote="";
			while(resultSet.next()){
				String fleet="";
				fleet="Fleet :"+resultSet.getString("ofleet_no");
				fleet=fleet+" "+resultSet.getString("flname");
				fleet=fleet+" Reg No :"+resultSet.getString("reg_no");
				fleet=fleet+" "+resultSet.getString("code_name");
				fleet=fleet+" "+resultSet.getString("authname");
				//bean.setLblcstno(resultSet.getString("cstno"));
				//bean.setLblservicetax(resultSet.getString("stcno"));
				//bean.setLblpan(resultSet.getString("pbno"));
				/*String lbltotal,String lblnetamount,
				String lblamountwords,String lblcheckedby,String lblrecievedby,String lblfinaldate*/
				/*String lblinvno,String lblclient,String lblaccount,String lbldate,String lbladdress1,String lblrano,String lbladdress2,String lbllpono,
				String lblmrano,String lblmobile,String lblratype,String lblphone,String lblcontractstart,String lbldriven,String lblinvfrom,String lblinvto,String lblcontractvehicle*/
				ArrayList<String> printdetin=new ArrayList<String>();
				printdetin=getPrintdetails(resultSet.getString("doc_no"));
				printdet.add(printdetin);

				ArrayList<String> printdamage=new ArrayList<String>();
				printdamage=getPrintDamage(resultSet.getString("doc_no"));
				printdamagemaster.add(printdamage);

				//Show traffic Fees
				int showfees=0;				   
				showfees=showTrafficFees(resultSet.getString("doc_no"));


				ArrayList<String> printfleet=new ArrayList<>();
				printfleet=getFleetdetails(resultSet.getString("rano"),resultSet.getDate("sqlfromdate"),resultSet.getDate("sqltodate"),resultSet.getString("ratype"));
				printfleetmaster.add(printfleet);
				String currentfleet=getCurrentFleet(resultSet.getString("rano"),resultSet.getString("ratype"),resultSet.getDate("sqlfromdate"),resultSet.getDate("sqltodate"));
				//					System.out.println("Current:"+currentfleet);
				ArrayList<String> salikdet=new ArrayList<>();
				salikdet=getSalikDetails(resultSet.getString("doc_no"));
				printsalikmaster.add(salikdet);

				ArrayList<String> trafficdetdubai=new ArrayList<>();
				trafficdetdubai=getTrafficDetailsDubai(resultSet.getString("doc_no"));
				printtrafficdubaimaster.add(trafficdetdubai);

				ArrayList<String> trafficdetelse=new ArrayList<>();
				trafficdetelse=getTrafficDetailsElse(resultSet.getString("doc_no"));

				printtrafficelsemaster.add(trafficdetelse);
				System.out.println("Salik Size: "+salikdet.size());
				//For Easy Lease
				ArrayList<String> agmtdetailarrayeasy=new ArrayList<>();
				//System.out.println("Agmt Invoice Doc No: "+resultSet.getString("doc_no"));
				agmtdetailarrayeasy=getAgmtDetailEasy(resultSet.getString("doc_no"),conn);
				printagmtdetailmaster.add(agmtdetailarrayeasy);
				
				ledgernote=resultSet.getString("ledgernote");
				if(trafficdetdubai.size()>0 || trafficdetelse.size()>0){
					ledgernote+=" with Reg No ";
				}
				for(int k=0;k<trafficdetdubai.size();k++){
					if(k==0){
						if(!ledgernote.contains(trafficdetdubai.get(k).split("::")[1])){
							ledgernote+=trafficdetdubai.get(k).split("::")[1];
						}
						
					}
					else{
						if(!ledgernote.contains(trafficdetdubai.get(k).split("::")[1])){
							ledgernote+=trafficdetdubai.get(k).split("::")[1];
						}
					}
				}
				for(int k=0;k<trafficdetelse.size();k++){
					if(k==0){
						if(!ledgernote.contains(trafficdetelse.get(k).split("::")[1])){
							ledgernote+=trafficdetelse.get(k).split("::")[1];
						}
						
					}
					else{
						if(!ledgernote.contains(trafficdetelse.get(k).split("::")[1])){
							ledgernote+=trafficdetelse.get(k).split("::")[1];
						}
					}
				}
					//System.out.println("totalarray.get(i):"+totalstringarray.get(i));
				employees.add(new ClsManualInvoiceAction(resultSet.getString("voc_no"),resultSet.getString("refname"),resultSet.getString("codeno"),resultSet.getString("date"),
						resultSet.getString("cladd"),resultSet.getString("rano1"),resultSet.getString("cladd1"),resultSet.getString("pono"),resultSet.getString("mrano"),
						resultSet.getString("per_mob"),resultSet.getString("ratype"),resultSet.getString("com_mob"),resultSet.getString("agmtdate"),resultSet.getString("driven"),
						resultSet.getString("fromdate"),resultSet.getString("todate"),fleet,resultSet.getString("company"),resultSet.getString("address"),
						resultSet.getString("tel"),resultSet.getString("fax"),"Invoice",resultSet.getString("branchname"),totalstringarray.get(i).toString(),totalstringarray.get(i).toString(),
						" "+objamt.convertAmountToWords(totalstringarray.get(i))+" .",resultSet.getString("user_name") ,resultSet.getString("finaldate"),salikdet.size(),
						resultSet.getString("branch"),resultSet.getString("dateyear"),trafficdetdubai.size(),trafficdetelse.size(),
						resultSet.getString("pbno"),resultSet.getString("stcno"),resultSet.getString("cstno"),resultSet.getString("loc_name"),resultSet.getString("salesman"),
						resultSet.getString("invfromtime"),resultSet.getString("invtotime"),resultSet.getString("code"),currentfleet,resultSet.getString("dtype"),
						printfleet.size(),hidheader,printdamage.size(),resultSet.getString("inspno"),resultSet.getString("inspregno"),showfees,agmtdetailarrayeasy.size(),
						resultSet.getString("email"),resultSet.getString("website"),resultSet.getString("creditdiff"),resultSet.getString("duedate"),
						resultSet.getString("per_tel"),ledgernote,bean.getLblcustomervehicle(),bean.getLblcourtesyvehicle()));

				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLblprintname("Invoice");
				bean.setLblclient(resultSet.getString("refname"));
				bean.setLblphone(resultSet.getString("com_mob"));
				
				//easylease
			    bean.setLbltelphone(resultSet.getString("per_tel"));
			    // end easylease
				bean.setLblmobile(resultSet.getString("per_mob"));
				bean.setLblfax(resultSet.getString("fax1"));
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLblinvno(resultSet.getString("doc_no"));
				bean.setLblbranchcode(resultSet.getString("branch"));
				bean.setLbldateyear(resultSet.getString("dateyear"));
				bean.setLbldate(resultSet.getString("date").toString());
				bean.setLblrano(resultSet.getString("rano"));
				bean.setLblinvfrom(resultSet.getString("fromdate").toString());
				bean.setLblinvto(resultSet.getString("todate"));
				bean.setLblcurrentvehicle(currentfleet);
				bean.setLblshowfees(showfees);
				String ac="";
				ac=resultSet.getString("acno");
				//ac=ac+" "+resultSet.getString("description");
				bean.setLblaccount(ac);
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
					bean.setLblmrano(resultSet.getString("mrano"));
				}
				if(resultSet.getString("agmtdate")!=null){
					bean.setLblcontractstart(resultSet.getString("agmtdate").toString());
				}
				

				bean.setLblcontractvehicle(fleet);
				bean.setLblratype(resultSet.getString("ratype"));
				bean.setLbltotal(totalarray.get(i).toString());
				bean.setLblnetamount(totalarray.get(i).toString());
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLbladdress1(resultSet.getString("address"));
				bean.setLbladdress2(resultSet.getString("cladd1"));
				bean.setLblfinaldate(resultSet.getString("finaldate").toString());
				bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblinvfromtime(resultSet.getString("invfromtime"));
				bean.setLblinvtotime(resultSet.getString("invtotime"));
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
					bean.setLbllpono(resultSet.getString("pono"));
				}
				bean.setLblamountwords(resultSet.getString("code")+" "+obj.convertNumberToWords(totalarray.get(i))+" only");

				i++;		
			}
			request.setAttribute("EASYAGMTPRINT", printagmtdetailmaster);
			request.setAttribute("FLEETPRINT", printfleetmaster);
			request.setAttribute("INVPRINT", printdet); 
			request.setAttribute("SALIKPRINT", printsalikmaster);
			request.setAttribute("TRAFFICPRINTDUBAI", printtrafficdubaimaster);
			request.setAttribute("TRAFFICPRINTELSE", printtrafficelsemaster);
			request.setAttribute("DAMAGEPRINT", printdamagemaster);
			request.setAttribute("TRIAL", employees);
			System.out.println("Check Agmt Details Details: "+printagmtdetailmaster);
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}


	private ArrayList<String> getAgmtDetailEasy(String docno, Connection conn) {
		// TODO Auto-generated method stub
		ArrayList<String> agmtarray=new ArrayList<>();
		try{
			Statement stmt=conn.createStatement();
			int i=1;
/*			String strsql="select coalesce(veh.reg_no,'') reg_no,if(current.reg_no is null,veh.reg_no,current.reg_no)  currentregno,coalesce(agmt.po,'') po,agmt.voc_no,date_format(inv.fromdate,'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,round(inv.rentalamt,2)"+
			" rentalamt,round(inv.accamt,2) accamt,round(inv.insuramt,2) insuramt,round(inv.amount,2) amount from gl_inveasylease inv left join"+
			" gl_lagmt agmt on inv.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_vehmaster current on (agmt.tmpfleet=current.fleet_no) where inv.invdocno="+docno+" and inv.status=3";*/
			String strsql="select * from ("+
			" select '' outregno,'' repdate,invm.voc_no invvocno,'' repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(inv.todate,inv.fromdate) datediff,"+
			" agmt.voc_no,date_format(date_add(inv.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,round(inv.rentalamt,2)"+
			" rentalamt,round(inv.accamt,2) accamt,round(inv.insuramt,2) insuramt,round(inv.amount,2) amount from gl_inveasylease inv left join"+
			" gl_lagmt agmt on inv.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_invm invm on inv.invdocno=invm.doc_no where inv.invdocno="+docno+" and inv.status=3"+
			" union all"+
			" select outveh.reg_no outregno,date_format(rep.date,'%d-%m-%Y') repdate,invm.voc_no invvocno,rep.doc_no repdocno,coalesce(veh.reg_no,'') reg_no,coalesce(agmt.po,'') po,datediff(inv.todate,inv.fromdate) datediff,"+
			" agmt.voc_no,date_format(date_add(inv.fromdate,interval 1 day),'%d-%m-%Y') fromdate,date_format(inv.todate,'%d-%m-%Y') todate,round(inv.rentalamt,2)"+
			" rentalamt,round(inv.accamt,2) accamt,round(inv.insuramt,2) insuramt,round(inv.amount,2) amount from gl_inveasylease inv left join"+
			" gl_lagmt agmt on inv.agmtno=agmt.doc_no left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no) left join gl_invm invm on inv.invdocno=invm.doc_no "+
			" left join gl_vehreplace rep on inv.agmtno=rep.rdocno left join gl_vehmaster outveh on rep.ofleetno=outveh.fleet_no where inv.invdocno="+docno+" and inv.status=3 and rep.doc_no is not null and (rep.date>=inv.fromdate and rep.date<=inv.todate)) a order by a.voc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				String temp="";
				if(!rs.getString("repdocno").equalsIgnoreCase("") && rs.getString("repdocno")!=null){
					temp=" "+"::"+" "+"::"+" "+"::"+"Replace Date"+"::"+rs.getString("repdate")+"::"+" "+"::"+" "+"::"+rs.getString("outregno")+"::"+" "+"::"+" "+"::"+" "+"::"+" ";
				}
				else{
					temp=i+"::"+rs.getString("voc_no")+"::"+rs.getString("invvocno")+"::"+rs.getString("po")+"::"+rs.getString("fromdate")+"::"+rs.getString("todate")+"::"+rs.getString("datediff")+"::"+rs.getString("reg_no")+"::"+rs.getString("rentalamt")+"::"+rs.getString("accamt")+"::"+rs.getString("insuramt")+"::"+rs.getString("amount");
					i++;
					
				}
				
				agmtarray.add(temp);
				
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return agmtarray;
	}

	private   int showTrafficFees(String docno) throws SQLException {
		// TODO Auto-generated method stub
		int showfees=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select amount from gl_traffic where inv_no="+docno+" and amount>0 and inv_type='INV' and fine_source like '%DUBAI%'");
			while(rs.next()){
				showfees++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		finally{
			conn.close();
		}
		return showfees;
	}

	private   ArrayList<String> getPrintDamage(String docno) throws SQLException {
		ArrayList<String> damagearray=new ArrayList<>();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sql="select dmg.type code,dmg.name,inspd.type,inspd.remarks from gl_vinspm insp left join gl_vinspd  inspd on (insp.doc_no=inspd.rdocno) "+
					" left join gl_damage dmg on inspd.dmid=dmg.doc_no where insp.invno="+docno;
			int i=0;
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				i++;
				damagearray.add(i+"::"+rs.getString("code")+"::"+rs.getString("name")+"::"+rs.getString("type")+"::"+rs.getString("remarks"));
			}

		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return damagearray;
	}
	public   String getCurrentFleet(String lblrano,String lblratype,java.sql.Date sqlfromdate,java.sql.Date sqltodate) throws SQLException {
		Connection conn=null;
		String currentfleet="";
		try {
			conn=objconn.getMyConnection();
			Statement stmtcurrent=conn.createStatement();
			String strmaxdoc="select coalesce(max(doc_no),0) maxdoc from gl_vmove where rdocno="+lblrano+" and rdtype='"+lblratype+"'"+
					" and dout between '"+sqlfromdate+"' and '"+sqltodate+"'";
			//System.out.println(strmaxdoc);
			int maxdoc=0;
			ResultSet rsmaxdoc=stmtcurrent.executeQuery(strmaxdoc);
			while(rsmaxdoc.next()){
				maxdoc=rsmaxdoc.getInt("maxdoc");
			}
			if(maxdoc==0){
				strmaxdoc="select coalesce(max(doc_no),0) maxdoc from gl_vmove where rdocno="+lblrano+" and rdtype='"+lblratype+"'";
				rsmaxdoc=stmtcurrent.executeQuery(strmaxdoc);
				while(rsmaxdoc.next()){
					maxdoc=rsmaxdoc.getInt("maxdoc");
				}
			}
			String strcurrentfleet="select mov.fleet_no,veh.flname,veh.reg_no,plt.code_name,auth.authname from gl_vmove mov left join gl_vehmaster veh on "+
					" mov.fleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no left join gl_vehauth auth on veh.authid=auth.doc_no where  mov.doc_no="+maxdoc;

			ResultSet rscurrent=stmtcurrent.executeQuery(strcurrentfleet);

			while(rscurrent.next()){
				currentfleet="Fleet :"+rscurrent.getString("fleet_no")+"  "+rscurrent.getString("flname")+"  "+"Reg No:"+rscurrent.getString("reg_no")+"  "+rscurrent.getString("code_name")+"  "+rscurrent.getString("authname");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return currentfleet;
	}



	public   ArrayList<String> getPrintdetails(String docno) throws SQLException {
		ArrayList<String> arr=new ArrayList<String>();
		Connection conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";
			/*		
		strSqldetail="select r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,m.description from gl_invmode m left join (select r.chid,"+
				" r.units,round(r.amount,2) amount,round(coalesce(sum(total),0),2) total from gl_invd r where r.chid not in(8,9,14,15) and"+
				" rdocno="+docno+" group by chid"+
				" union all"+
				" select r.chid,r.units,round(sum(r.amount),2),round(coalesce(sum(total),0),2) total from gl_invd r where r.chid in(8,14) and rdocno="+docno+""+
				" union all"+
				" select r.chid,r.units,round(r.amount,2),round(coalesce(sum(total),0),2) total from gl_invd r where r.chid  in(9,15) and rdocno="+docno+""+
				" ) r on(m.idno=r.chid) where r.chid is not null";*/

			String stragreed="select method from gl_config where field_nme='printAgreedrate'";
			ResultSet rsagreed=stmtinvoice.executeQuery(stragreed);
			int agreedrate=0;
			while(rsagreed.next()){
				agreedrate=rsagreed.getInt("method");
			}
			String strprintsrvc="select method from gl_config where field_nme='printSrvc'";
			int printsrvc=0;
			ResultSet rsprintsrvc=stmtinvoice.executeQuery(strprintsrvc);
			while(rsprintsrvc.next()){
				printsrvc=rsprintsrvc.getInt("method");
			}
			String strnorate="select method from gl_config where field_nme='NoRatePrint'";
			int norate=0;
			ResultSet rsnorate=stmtinvoice.executeQuery(strnorate);
			while(rsnorate.next()){
				norate=rsnorate.getInt("method");
			}
			if(agreedrate==1){
				if(printsrvc==1){
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ',"+
							" (select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where  r.date >=fromdate and"+
							" r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', (select round(vat_per,1) from gl_taxdetail"+
							" where doc_no=(select max(doc_no) from gl_taxdetail where r.date >=fromdate and r.date <=todate and status=3)),' %') else"+
							" m.description end description from gl_invmode m left join (select r.chid,r.units,round(case when r.chid=1 and m.ratype='RAG' then"+
							" rtrf.rate when r.chid=1 and m.ratype='LAG' then ltrf.rate when r.chid=2 and m.ratype='RAG' then rtrf.gps+rtrf.babyseater+rtrf.cooler"+
							" when r.chid=2 and m.ratype='LAG' then ltrf.gps+ltrf.babyseater+ltrf.cooler when r.chid=3 and m.ratype='RAG' then rtrf.chaufchg"+
							" when r.chid=3 and m.ratype='LAG' then ltrf.chaufchg when r.chid=4 and m.ratype='RAG' then rtrf.exkmrte when r.chid=4 and"+
							" m.ratype='LAG' then ltrf.exkmrte when r.chid=5 and m.ratype='RAG' then rtrf.exhrchg when r.chid=7 and m.ratype='RAG' then"+
							" rtrf.oinschg  when r.chid=17 and m.ratype='RAG' then rtrf.cdw+rtrf.pai+rtrf.cdw1+rtrf.pai1 when r.chid=18 and m.ratype='LAG' then"+
							" ltrf.cdw+ltrf.pai+ltrf.cdw1+ltrf.pai1  else 0 end,2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_invm m"+
							" left join gl_rtarif rtrf on (m.rano=rtrf.rdocno and m.ratype='RAG' and rtrf.rstatus=7) left join gl_ltarif ltrf on"+
							" (m.rano=ltrf.rdocno and m.ratype='LAG')inner join gl_invd r on m.doc_no=r.rdocno where r.rdocno="+docno+
							" group by chid ) r on(m.idno=r.chid) where r.chid is not null";

				}
				else{
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ', "
							+ "	(select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where "
							+ " r.date >=fromdate and r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', "
							+ "(select round(vat_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail where "
							+ "r.date >=fromdate and r.date <=todate and status=3)),' %') else m.description end description from gl_invmode m left join "
							+ "(select r.chid,r.units,round(case when r.chid=1 and m.ratype='RAG' then rtrf.rate when r.chid=1 and m.ratype='LAG' then ltrf.rate when r.chid=2 and"+
							" m.ratype='RAG' then rtrf.gps+rtrf.babyseater+rtrf.cooler when r.chid=2 and m.ratype='LAG' then ltrf.gps+ltrf.babyseater+ltrf.cooler"+
							" when r.chid=3 and m.ratype='RAG' then rtrf.chaufchg when r.chid=3 and m.ratype='LAG' then ltrf.chaufchg when r.chid=4 and"+
							" m.ratype='RAG' then rtrf.exkmrte when r.chid=4 and m.ratype='LAG' then ltrf.exkmrte when r.chid=5 and m.ratype='RAG' then"+
							" rtrf.exhrchg when r.chid=7 and m.ratype='RAG' then rtrf.oinschg  when"+
							" r.chid=17 and m.ratype='RAG' then rtrf.cdw+rtrf.pai+rtrf.cdw1+rtrf.pai1 when r.chid=18 and m.ratype='LAG' then"+
							" ltrf.cdw+ltrf.pai+ltrf.cdw1+ltrf.pai1  else 0 end,2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_invm m  "+
							" left join gl_rtarif rtrf on (m.rano=rtrf.rdocno and m.ratype='RAG' and rtrf.rstatus=7)"+
							" left join gl_ltarif ltrf on (m.rano=ltrf.rdocno and m.ratype='LAG')inner join"+
							" gl_invd r on m.doc_no=r.rdocno where r.chid not in(8,9,14,15) and r.rdocno="+docno+" group by chid union all "+
							" select r.chid,r.units,round(sum(r.amount),2) amount ,round(coalesce(sum(total),0),2)  total,m.date from gl_invm m  "+
							" inner join gl_invd r on m.doc_no=r.rdocno  where r.chid in(8,14) and r.rdocno="+docno+" union all select r.chid,r.units, "+
							" round(sum(r.amount),2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_invm m  inner join gl_invd r on m.doc_no=r.rdocno  where"+
							" r.chid in(9,15) and r.rdocno="+docno+") r on(m.idno=r.chid) where r.chid is not null";		
				}

			}
			else{
				if(printsrvc==1){
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ',"+
							" (select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where  r.date >=fromdate and"+
							" r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', (select round(vat_per,1) from gl_taxdetail"+
							" where doc_no=(select max(doc_no) from gl_taxdetail where r.date >=fromdate and r.date <=todate and status=3)),' %') else"+
							" m.description end description from gl_invmode m left join (select r.chid,r.units,round(sum(r.amount),2) amount,"+
							" round(coalesce(sum(total),0),2) total,m.date from gl_invm m inner join gl_invd r on m.doc_no=r.rdocno where"+
							" r.rdocno="+docno+" group by chid) r on(m.idno=r.chid) where r.chid is not null";
				}
				else{
					strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ', "
							+ "	(select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where "
							+ " r.date >=fromdate and r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', "
							+ "(select round(vat_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail where "
							+ "r.date >=fromdate and r.date <=todate and status=3)),' %') else m.description end description from gl_invmode m left join "
							+ "(select r.chid,r.units,round(sum(r.amount),2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_invm m inner join"+
							" gl_invd r on m.doc_no=r.rdocno where r.chid not in(8,9,14,15) and r.rdocno="+docno+" group by chid union all "+
							" select r.chid,r.units,round(sum(r.amount),2) amount ,round(coalesce(sum(total),0),2)  total,m.date from gl_invm m  "+
							" inner join gl_invd r on m.doc_no=r.rdocno  where r.chid in(8,14) and r.rdocno="+docno+" union all select r.chid,r.units, "+
							" round(sum(r.amount),2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_invm m  inner join gl_invd r on m.doc_no=r.rdocno  where"+
							" r.chid in(9,15) and r.rdocno="+docno+") r on(m.idno=r.chid) where r.chid is not null";

				}
			}
			//System.out.println("Print Details:"+strSqldetail);
			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);

			int rowcount=1;
			String firstsql="";
			/*if(rsdetail.last()){
			rowcount=rsdetail.getRow();
			rsdetail.beforeFirst();
		}*/
			System.out.println("NoRate: "+norate);
			while(rsdetail.next()){
				//for(int i=0;i<rowcount;i++){
				String temp="";
				if(norate==1){
					//Overridden for EASYLEASE
					//System.out.println("Inside Agreed Rate");
					temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("total");
					System.out.println("inside 1");
				}
				else if(agreedrate==1){
					temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("total");	
					System.out.println("inside 2");
				}
				else{
					temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("total");
					System.out.println("inside 3");
				}

				System.out.println(temp);
				String secndsql="select '"+rowcount+"' as srno,'"+rsdetail.getString("description")+"' as descp,"
						+ "'"+rsdetail.getString("units")+"' as unit,'"+rsdetail.getString("amount")+"' as amount,'"+rsdetail.getString("total")+"' as total" ;
				if(rowcount==1){
				 firstsql="select '"+rowcount+"' as srno,'"+rsdetail.getString("description")+"' as descp,"
						+ "'"+rsdetail.getString("units")+"' as unit,'"+rsdetail.getString("amount")+"' as amount,'"+rsdetail.getString("total")+"' as total" ;
				}
				else{
				firstsql=firstsql +" union all  "+secndsql;
				}	
				
				arr.add(temp);
				rowcount++;
				/*System.out.println(arr.Get[i]);*/
				//}

			}
			//System.out.println("========== "+arr);
			bean.setPrintdetailsql(firstsql);
			stmtinvoice.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return arr;
	}
	public   ArrayList<String> getFleetdetails(String lblrano,java.sql.Date fromdate,java.sql.Date todate,String lblratype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> fleetarray=new ArrayList<>();
		int rowcount=1;
				String otherfleetsql="";
		try {
			String strfleetdetails="select distinct mov.fleet_no,veh.flname,veh.reg_no,DATE_FORMAT(mov.dout,'%d/%m/%Y') dout,COALESCE(DATE_FORMAT(mov.din,'%d/%m/%Y '),'') "+
					" din from gl_vmove mov left join gl_vehmaster veh on (mov.fleet_no=veh.fleet_no ) where mov.rdocno="+lblrano+" and mov.rdtype='"+lblratype+"' and mov.repno<> 0 and mov.trancode<>'DL'"+
					" and ((dout >='"+fromdate+"' and dout <='"+todate+"') or (din >='"+fromdate+"' and din <='"+todate+"'))";
			conn=objconn.getMyConnection();

			Statement stmtfleetdetails = conn.createStatement();
			//				System.out.println("Fleet Query:"+strfleetdetails);
			ResultSet rsfleetdetails=stmtfleetdetails.executeQuery(strfleetdetails);
			while(rsfleetdetails.next()){
				String temp=rsfleetdetails.getString("fleet_no")+"  "+rsfleetdetails.getString("flname")+"  "+"Reg No:"+rsfleetdetails.getString("reg_no")+"  "+"From Date:"+rsfleetdetails.getString("dout")+"  "+"To Date:"+rsfleetdetails.getString("din");
				fleetarray.add(temp);
				String secndsql="select 'Other Fleets' as name,'"+temp+"' as otherfleets" ;
				if(rowcount==1){
					otherfleetsql="select 'Other Fleets' as name,'"+temp+"' as otherfleets" ;
				}
				else{
					otherfleetsql=otherfleetsql +" union all  "+secndsql;
				}
rowcount++;

			}
			bean.setOtherfleetsql(otherfleetsql);
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return fleetarray;
	}



	public   ArrayList<String> getSalikDetails(String docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> salikarray=new ArrayList<>();
String saliksql="";
		try{
			conn=objconn.getMyConnection();

			Statement stmt=conn.createStatement();
			java.sql.Date fromdate=null,todate=null;
			/*	Statement stmtdate=conn.createStatement();
			ResultSet rsdate=stmtdate.executeQuery("select fromdate,todate from gl_invm where doc_no="+docno+"");
			while(rsdate.next()){
				fromdate=rsdate.getDate("fromdate");
				todate=rsdate.getDate("todate");
			}*/
			
			
			
			String strprintsalikconfig="select method from gl_config where field_nme='PrintSalikSrvc'";
			int saliksrvcconfig=0;
			ResultSet rssrvcconfig=stmt.executeQuery(strprintsalikconfig);
			int i=1;
			while(rssrvcconfig.next()){
				saliksrvcconfig=rssrvcconfig.getInt("method");
			}
			
			String strsalik="select trans,DATE_FORMAT(salik_date,'%b-%e-%Y %h:%i:%s %p') salik_date,DATE_FORMAT(sal_date,'%b-%e-%Y') sal_date,"+
					" concat('Tag #:',coalesce(tagno,''),' ',coalesce(source,''),'-',coalesce(cust_plate,''),' ',coalesce(regno,'')) plateinfo,location,"+
					" direction,round(if("+saliksrvcconfig+"=1,amount+1,amount),2) amount from gl_salik where inv_no="+docno+" and amount>0 and inv_type='INV' order by regno,date";
			/*and sal_date between '"+fromdate+"' and '"+todate+"'*/
			ResultSet rssalik=stmt.executeQuery(strsalik);
			
			while(rssalik.next()){
				String temp=i+"::"+rssalik.getString("trans")+"::"+rssalik.getString("salik_date")+"::"+rssalik.getString("sal_date")+"::"+rssalik.getString("plateinfo")+"::"+rssalik.getString("location")+"::"+rssalik.getString("direction")+"::"+rssalik.getString("amount");
				//System.out.println(temp);
				salikarray.add(temp);
		String secndsql="select '"+i+"' as srno,'"+rssalik.getString("trans")+"' as trans,"
						+ "'"+rssalik.getString("salik_date")+"' as tripdate,'"+rssalik.getString("sal_date")+"' as postdate,"
						+ "'"+rssalik.getString("plateinfo")+"' as plateinfo,'"+rssalik.getString("location")+"' as location,"
						+ "'"+rssalik.getString("direction")+"' as direction,'"+rssalik.getString("amount")+"' as amount" ;
				if(i==1){
					saliksql="select '"+i+"' as srno,'"+rssalik.getString("trans")+"' as trans,"
							+ "'"+rssalik.getString("salik_date")+"' as tripdate,'"+rssalik.getString("sal_date")+"' as postdate,"
							+ "'"+rssalik.getString("plateinfo")+"' as plateinfo,'"+rssalik.getString("location")+"' as location,"
							+ "'"+rssalik.getString("direction")+"' as direction,'"+rssalik.getString("amount")+"' as amount" ;
				}
				else{
					saliksql=saliksql +" union all  "+secndsql;
				}
				
			
				i++;
			}
bean.setSaliksql(saliksql);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return salikarray;
	}

	public   ArrayList<String> getTrafficDetailsDubai(String docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> trafficarray=new ArrayList<>();
String trafficdubaisql="";
		try{
			conn=objconn.getMyConnection();

			Statement stmt=conn.createStatement();
			/*String strsalik="select trans,DATE_FORMAT(salik_date,'%M-%e-%Y %h:%i:%s %p') salik_date,DATE_FORMAT(sal_date,'%M-%e-%Y') sal_date,"+
					" concat('Tag #:',tagno,' ',source,'-',coalesce(cust_plate,''),' ',regno) plateinfo,location,"+
					" direction,amount from gl_salik where inv_no="+docno+" and amount>0 ";*/
			String strtraffic="select regno,ticket_no,DATE_FORMAT(traffic_date,'%b-%e-%Y')traffic_date,time,round(amount,2) amount,if(desc1 is null,' ',desc1) desc1,coalesce(fine_source,'') fine_source from gl_traffic where inv_no="+docno+" and amount>0 and inv_type='INV' and tcno like '50%'";
			/*and sal_date between '"+fromdate+"' and '"+todate+"'*/
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			int i=1;
			while(rstraffic.next()){
				String temp=i+"::"+rstraffic.getString("regno")+"::"+rstraffic.getString("ticket_no")+"::"+rstraffic.getString("traffic_date")+"::"+rstraffic.getString("time")+"::"+rstraffic.getString("amount")+"::"+rstraffic.getString("fine_source")+"::"+rstraffic.getString("desc1");
				//System.out.println(temp);
				// If Tc No is 1 then Dubai Else Abu Dhabi 

				trafficarray.add(temp);
String secndsql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
						+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
						+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
						+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				if(i==1){
					trafficdubaisql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
					+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
					+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
					+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				}
				else{
					trafficdubaisql=trafficdubaisql +" union all  "+secndsql;
				}
				i++;
			}
bean.setTrafficdubaisql(trafficdubaisql);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return trafficarray;
	}


	public   ArrayList<String> getTrafficDetailsElse(String docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> trafficarray=new ArrayList<>();
String trafficabudabisql="";
		try{
			conn=objconn.getMyConnection();

			Statement stmt=conn.createStatement();
			java.sql.Date fromdate=null,todate=null;

			/*String strsalik="select trans,DATE_FORMAT(salik_date,'%M-%e-%Y %h:%i:%s %p') salik_date,DATE_FORMAT(sal_date,'%M-%e-%Y') sal_date,"+
					" concat('Tag #:',tagno,' ',source,'-',coalesce(cust_plate,''),' ',regno) plateinfo,location,"+
					" direction,amount from gl_salik where inv_no="+docno+" and amount>0 ";*/
			String strtraffic="select regno,ticket_no,DATE_FORMAT(traffic_date,'%b-%e-%Y')traffic_date,time,round(amount,2) amount,if(desc1 is null,' ',desc1) desc1,coalesce(fine_source,'') fine_source from gl_traffic where inv_no="+docno+" and amount>0 and inv_type='INV' and tcno not like '50%'";
			/*and sal_date between '"+fromdate+"' and '"+todate+"'*/
			int i=1;
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			while(rstraffic.next()){
				String temp=i+"::"+rstraffic.getString("regno")+"::"+rstraffic.getString("ticket_no")+"::"+rstraffic.getString("traffic_date")+"::"+rstraffic.getString("time")+"::"+rstraffic.getString("amount")+"::"+rstraffic.getString("fine_source")+"::"+rstraffic.getString("desc1");
				//System.out.println(temp);
				// If Tc No is 1 then Dubai Else Abu Dhabi 

				trafficarray.add(temp);
String secndsql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
						+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
						+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
						+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				if(i==1){
					trafficabudabisql="select '"+i+"' as srno,'"+rstraffic.getString("regno")+"' as regno,"
					+ "'"+rstraffic.getString("ticket_no")+"' as ticketno,'"+rstraffic.getString("traffic_date")+"' as trafficdate,"
					+ "'"+rstraffic.getString("time")+"' as time,'"+rstraffic.getString("amount")+"' as amount,"
					+ "'"+rstraffic.getString("fine_source")+"' as finesource,'"+rstraffic.getString("desc1")+"' as descp" ;
				}
				else{
					trafficabudabisql=trafficabudabisql +" union all  "+secndsql;
				}
				i++;
			}
bean.setTrafficabudhabusql(trafficabudabisql);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return trafficarray;
	}



	public double getChaufferCharge(int agmtno,java.sql.Date invdate,java.sql.Date invtodate,String agmttype) throws SQLException{
		Connection conn=null;
		int monthcalmethod=0,monthcalvalue=0,rentalno=0;
		double chaufchg=0.0;
		try{
			conn=objconn.getMyConnection();
			Statement stmtconfig=conn.createStatement();
			String strconfig="";
			if(agmttype.equalsIgnoreCase("RAG")){
				strconfig="select method,value from gl_config where field_nme='monthlycal'";
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				strconfig="select method,value from gl_config where field_nme='lesmonthlycal'";
			}
			else{

			}
			ResultSet rsconfig=stmtconfig.executeQuery(strconfig);
			while(rsconfig.next()){
				monthcalmethod=rsconfig.getInt("method");
				monthcalvalue=rsconfig.getInt("value");
			}
			String strsql="";

			double day=0.0,month=0.0,days=0.0;
			int lastday=0;
			if(monthcalmethod==1){
				Statement stmtmonthdays=conn.createStatement();
				String strmonthdays="SELECT (select DAY(LAST_DAY('"+invdate+"'))) monthdays,(select method from gl_config where field_nme='closecal') closecal";
				ResultSet rsmonthdays=stmtmonthdays.executeQuery(strmonthdays);
				int closecal=0;
				while(rsmonthdays.next()){
					monthcalvalue=rsmonthdays.getInt("monthdays");
					closecal=rsmonthdays.getInt("closecal");
				}
				Statement stmtMonth=conn.createStatement();
				
				String strgetmonth="";
				if(closecal==0){
					strgetmonth="select a.months,DAY(LAST_DAY('"+invtodate+"')) lastday, DATEDIFF( '"+invtodate+"', DATE_ADD('"+invdate+"',INTERVAL a.months month) ) days from ("+
							" select if(day('"+invdate+"')>day('"+invtodate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+invtodate+"' ),"+
							" EXTRACT( YEAR_MONTH FROM '"+invdate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+invtodate+"' ),"+
							" EXTRACT( YEAR_MONTH FROM '"+invdate+"' ) )) months) a";	
				}
				else if(closecal==1){
					strgetmonth="select DAY(LAST_DAY('"+invtodate+"')) lastday, DATEDIFF( '"+invtodate+"', DATE_ADD('"+invdate+"',INTERVAL 0 month) ) days,0 months";
				}


				ResultSet rsgetmonth=stmtMonth.executeQuery(strgetmonth);
				while(rsgetmonth.next()){
					day=rsgetmonth.getDouble("days");
					month=rsgetmonth.getDouble("MONTHS");
					lastday=rsgetmonth.getInt("lastday");
				}
				if(agmttype.equalsIgnoreCase("RAG")){
					strsql="select round((("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)),2) chaufferchg from gl_rtarif where rstatus=7 and rdocno="+agmtno;
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					strsql="select round((("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)),2) chaufferchg from gl_ltarif where rdocno="+agmtno;
				}
			}
			else if(monthcalmethod==0){
				rentalno=monthcalvalue;
				long diff=invtodate.getTime()-invdate.getTime();
				long datediff = diff / (24 * 60 * 60 * 1000);
				days=datediff;
				if(agmttype.equalsIgnoreCase("RAG")){
					strsql="select round("+(days/rentalno)+"*chaufchg,2) chaufferchg from gl_rtarif where rstatus=7 and rdocno="+agmtno;	
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					strsql="select round("+(days/rentalno)+"*chaufchg,2) chaufferchg from gl_ltarif where rdocno="+agmtno;
				}

				else{

				}
			}
			Statement stmtchauf=conn.createStatement();
			ResultSet rschaufchg=stmtchauf.executeQuery(strsql);

			while(rschaufchg.next()){
				chaufchg=rschaufchg.getDouble("chaufferchg");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return chaufchg;
	}







	public boolean edit(Connection conn,ArrayList<String> invoicearray, String cmbagmttype,
			Date date, String hidclient, int agmtno, String ledgernote,
			String invoicenote, Date fromdate, Date todate, String branchid,
			String userid, String currencyid, String mode, String acno,
			String dtype, String formdetailcode, String qty2,int docno) throws SQLException {
		// TODO Auto-generated method stub

		try{
			ArrayList<String> editarray=new ArrayList<>();
			for(int i=0;i<invoicearray.size();i++){
				int idno=Integer.parseInt(invoicearray.get(i).split("::")[0]);
				System.out.println("IDNO: "+idno);
				if(idno!=13 && idno!=19 && idno!=20 && idno!=21){
					editarray.add(invoicearray.get(i));
				}
			}
			invoicearray=editarray;
			for(int i=0;i<invoicearray.size();i++){
				System.out.println("Invoice Data:"+invoicearray.get(i));
			}
			
			 int salikcount=0,trafficcount=0;
			 String salikqty="",trafficqty="";
			int invdescconfig=getInvDescConfig(conn);
			double damageamount=0.0;
			String origin="";
			Statement stmtorigin=conn.createStatement();
			String strorigin="select manual from gl_invm where doc_no="+docno;
			ResultSet rsorigin=stmtorigin.executeQuery(strorigin);
			while(rsorigin.next()){
				origin=rsorigin.getString("manual");
			}
			stmtorigin.close();
			//Getting TRNO for further editing
			Statement stmttrno=conn.createStatement();
			String strtrno="select tr_no from gl_invm where doc_no="+docno;
			int trno=0;
			ResultSet rstrno=stmttrno.executeQuery(strtrno);
			while(rstrno.next()){
				trno=rstrno.getInt("tr_no");
			}
			stmttrno.close();


			int agmtvocno=0;
			Statement stmtagmtvoc=conn.createStatement();
			String stragmtvoc="";
			if(cmbagmttype.equalsIgnoreCase("RAG")){
				stragmtvoc="select voc_no from gl_ragmt where doc_no="+agmtno;
			}
			else if(cmbagmttype.equalsIgnoreCase("LAG")){
				stragmtvoc="select voc_no from gl_lagmt where doc_no="+agmtno;
			}
			if(!stragmtvoc.equalsIgnoreCase("")){
				ResultSet rsagmtvocno=stmtagmtvoc.executeQuery(stragmtvoc);
				while(rsagmtvocno.next()){
					agmtvocno=rsagmtvocno.getInt("voc_no");
				}
			}



			//Clearing invoice Reference in Agreement tables
			String strclearagmtinvno="";
			String strclearcalc="";
			//Clearing Costtran Values

			Statement stmtclearcost=conn.createStatement();
			String strclearcost="delete from my_costtran where tr_no="+trno;
			int clearcost=stmtclearcost.executeUpdate(strclearcost);
			if(clearcost<0){
				return false;
			}
			stmtclearcost.close();

			if(cmbagmttype.equalsIgnoreCase("RAG")){
				strclearagmtinvno="update gl_ragmt set addr_invno=0,del_invno=0 where doc_no="+agmtno;

				strclearcalc="delete from gl_rcalc where rdocno="+agmtno+" and trno="+trno;
			}
			if(cmbagmttype.equalsIgnoreCase("LAG")){
				strclearagmtinvno="update gl_lagmt set addr_invno=0,del_invno=0 where doc_no="+agmtno;

				strclearcalc="delete from gl_rcalc where rdocno="+agmtno+" and trno="+trno;


			}
			Statement stmtclearagmt=conn.createStatement();
			int clearagmt=stmtclearagmt.executeUpdate(strclearagmtinvno);
			if(clearagmt<0){
				return false;
			}
			stmtclearagmt.close();

			//Clearing Data from Rcalc/Lcalc tables
			Statement stmtclearcalc=conn.createStatement();
			int clearcalc=stmtclearcalc.executeUpdate(strclearcalc);
			if(clearcalc<0){
				return false;
			}

			stmtclearcalc.close();

			if(cmbagmttype.equalsIgnoreCase("LAG")){
				String strleaseserv="update gl_lothser set invno=0,invstatus=0 where invno="+docno;
				Statement stmtleaseserv=conn.createStatement();
				int leaseserv=stmtleaseserv.executeUpdate(strleaseserv);
				if(leaseserv<0){
					return false;
				}

				stmtleaseserv.close();
			}

			//Deleting data from my_jvtran
			ClsApplyDelete objapply=new ClsApplyDelete();
			int applydelete=objapply.getFinanceApplyDelete(conn, trno);
			if(applydelete<0){
				return false;
			}
			String strjvdelete="delete from my_jvtran where tr_no="+trno;
			Statement stmtjvdelete=conn.createStatement();
			int jvdeleteval=stmtjvdelete.executeUpdate(strjvdelete);
			if(jvdeleteval<0){
				return false;
			}

			stmtjvdelete.close();

			/*//Clearing Invoice Reference from salik table

		String strclearsalik="update gl_salik set status=0,inv_no=0,inv_type='' where inv_no="+agmtno;
		Statement stmtclearsalik=conn.createStatement();
		int clearsalikval=stmtclearsalik.executeUpdate(strclearsalik);
		if(clearsalikval<0){
			return false;
		}
		stmtclearsalik.close();

		//Clearing Invoice Reference from traffic table

		String strcleartraffic="update gl_traffic set status=0,inv_no=0,inv_type='',inv_desc='' where inv_no="+docno;
		Statement stmtcleartraffic=conn.createStatement();
		int cleartrafficval=stmtcleartraffic.executeUpdate(strcleartraffic);
		if(cleartrafficval<0){
			return false;
		}
			 */

			//Updating Master Data
			//brhid="+branchid+",ratype='"+cmbagmttype+"',cldocno='"+hidclient+"',rano="+agmtno+",curid="+currencyid+",acno="+acno+"
			Statement stmtmaster=conn.createStatement();
			String strmaster="update gl_invm set date='"+date+"',ldgrnote='"+ledgernote+"'"+
					",invnote='"+invoicenote+"',fromdate='"+fromdate+"',todate='"+todate+"',userid='"+userid+"' where doc_no="+docno;
			int masterupdate=stmtmaster.executeUpdate(strmaster);
			if(masterupdate<0){
				System.out.println("/////////Master Update Error/////////////");
				return false;
			}
			if(masterupdate>0){
				Statement stmtlog=conn.createStatement();
				String strlog="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+","+branchid+",'"+formdetailcode+"',now(),"+userid+",'E')";
				int logval=stmtlog.executeUpdate(strlog);
				if(logval<0){
					return false;
				}
				Statement stmtdelete=conn.createStatement();
				String strdelete="delete from gl_invd where rdocno="+docno;
				int deleteval=stmtdelete.executeUpdate(strdelete);
				if(deleteval<0){
					return false;

				}
				stmtdelete.close();
				if(deleteval>0){
					Statement stmtinsert=conn.createStatement();
					double salikamt=0.0,trafficamt=0.0,generalamt=0.0;
					double otherincome=0.0;
					double salikldr=0.0,trafficldr=0.0,generalldr=0.0;
					int srno=1;
					int tempno=1;
					int testcurid=0;
					double testcurrate=0.0;
					Statement stmtinvoice = conn.createStatement();
					ResultSet rscurr=stmtinvoice.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+currencyid+"'");
					if(rscurr.next()){
						testcurid=rscurr.getInt("doc_no");
						testcurrate=rscurr.getDouble("c_rate");
					}
					else{
						System.out.println("Currency Error");
						return false;
					}
					String note="";
					String rtype="";
					String salikdesc="";
					String trafficdesc="";
					Statement stmtacperiod=conn.createStatement();
					java.sql.Date duedate=null;

					String strdelchg="";
					String straddrchg="";
					java.sql.Date tempfromdate=null;
					int aaa=0,testtrno=0;

					String stracperiod="select DATE_ADD('"+date+"', INTERVAL (select period2 from my_acbook where cldocno="+hidclient+" and dtype='CRM') DAY) duedate";
					//				System.out.println(stracperiod);
					ResultSet rsacperiod=stmtacperiod.executeQuery(stracperiod);
					while(rsacperiod.next()){
						duedate=rsacperiod.getDate("duedate");
					}
					if(cmbagmttype.equalsIgnoreCase("RAG")){
						note=objcommon.changeSqltoString(fromdate) +" to "+objcommon.changeSqltoString(todate) +" for Rental Agreement no "+agmtvocno;
						rtype=" in ('RA','RD','RW','RF','RM')";
						salikdesc="Salik Invoice for Rental Agreement "+agmtvocno+"";
						trafficdesc="Traffic Invoice for Rental Agreement "+agmtvocno+"";
					}
					else if(cmbagmttype.equalsIgnoreCase("LAG")){
						note=objcommon.changeSqltoString(fromdate) +" to "+objcommon.changeSqltoString(todate) +" for Lease Agreement no "+agmtvocno;
						rtype=" in ('LA','LC')";
						salikdesc="Salik Invoice for Lease Agreement "+agmtvocno+"";
						trafficdesc="Traffic Invoice for Lease Agreement "+agmtvocno+"";
					}
					for(int i=0;i< invoicearray.size();i++){
						String[] invoice=invoicearray.get(i).split("::");
						if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
							/*salikamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
							salikcount++;*/
							salikqty=invoice[3];
						}

						else if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
							/*trafficamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
							trafficcount++;*/
							trafficqty=invoice[3];
						}
						double testldramt=testcurrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
						double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
						double partyldramt=testldramt*-1;
						if(invoice[0].equalsIgnoreCase("10")){
							damageamount=Double.parseDouble(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?"0":invoice[5]);
						}
						String strinsert="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+branchid+"','"+docno+"'"+
								",'"+trno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+(invoice[4].equalsIgnoreCase("undefined") || invoice[4].isEmpty()?0:invoice[4])+"')";
						int insertval=stmtinsert.executeUpdate(strinsert);
						if(insertval<0){
							return false;
						}
						if(insertval>0){

							//Updating Additional Driver Invoice Reference in agreement tables
							if(invoice[0].equalsIgnoreCase("12") && Double.parseDouble(invoice[5])>0){
								Statement stmtupdateaddr=conn.createStatement();
								String strupdateaddr="";
								if(cmbagmttype.equalsIgnoreCase("RAG")){
									strupdateaddr="update gl_ragmt set addr_invno="+docno+" where doc_no="+agmtno;
								}
								else if(cmbagmttype.equalsIgnoreCase("LAG")){
									strupdateaddr="update gl_lagmt set addr_invno="+docno+" where doc_no="+agmtno;
								}
								int updateval=stmtupdateaddr.executeUpdate(strupdateaddr);
								if(updateval<0){
									return false;
								}
								stmtupdateaddr.close();
							}

							//Updating Delivery Invoice Reference in agreement tables
							if(invoice[0].equalsIgnoreCase("6") && Double.parseDouble(invoice[5])>0){
								String strdelivery="";
								Statement stmtdelivery=conn.createStatement();
								if(cmbagmttype.equalsIgnoreCase("RAG")){
									strdelivery="update gl_ragmt set del_invno="+docno+" where doc_no="+agmtno;
								}
								else if(cmbagmttype.equalsIgnoreCase("LAG")){
									strdelivery="update gl_lagmt set del_invno="+docno+" where doc_no="+agmtno;
								}
								int delval=stmtdelivery.executeUpdate(strdelivery);
								if(delval<=0){
									return false;
								}
							}
							Statement stmtcalc=conn.createStatement();
							if(cmbagmttype.equalsIgnoreCase("RAG")){
								String strSqlrcalc="";

								strSqlrcalc="insert into gl_rcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+branchid+"','"+trno+"',"+
										"'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+docno+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";

								//System.out.println(strSqlrcalc);
								int rcalcval=stmtcalc.executeUpdate(strSqlrcalc);

								if(rcalcval<=0){
									System.out.println("Rcalc Error");
									return false;
								}


							}
							if(cmbagmttype.equalsIgnoreCase("LAG")){
								String strSqlrcalc="";
								strSqlrcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+branchid+"','"+trno+"',"+
										"'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+docno+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";
								//System.out.println(strSqlrcalc);
								int rcalcval=stmtcalc.executeUpdate(strSqlrcalc);

								if(rcalcval<=0){
									System.out.println("Lcalc Error");
									return false;
								}
							}

							if(invoice[0].equalsIgnoreCase("18") && Double.parseDouble(invoice[5])>0){
								Statement stmtotherincome=conn.createStatement();
								//System.out.println("Inside Other Income Update SQL");
								String strotherincome="update gl_lothser set invno="+docno+",invstatus=1 where rdocno="+agmtno+" and invstatus=0";
								int otherincomeval=stmtotherincome.executeUpdate(strotherincome);
								if(otherincomeval<0){
									//									
									System.out.println(" Update Other Income Error");
									return false;
								}
							}



							if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
								salikamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
								salikcount++;
								 salikqty=invoice[3];
							}

							else if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
								trafficamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
								trafficcount++;
								 trafficqty=invoice[3];
							}
							//trafficldr=testcurrate*trafficamt;

							else{
								generalamt=generalamt+Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
								//System.out.println("Check General Amount:"+generalamt);
							}

							String sqljv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
									"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+trno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
									"'"+partydramt+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(i+1)+"',"+
									"'"+branchid+"','"+note+"',"+
									"0,'"+date+"','"+formdetailcode+"','"+partyldramt+"','"+docno+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
									"'"+testcurid+"','5',1,0,3,'"+agmtno+"','"+cmbagmttype+"')";
							System.out.println("Auto JV: "+sqljv2);
							int rsjv2=stmtinvoice.executeUpdate(sqljv2);
							if(rsjv2<0){
								return false;
							}
							if(rsjv2>0){

								Statement stmtcostentry=conn.createStatement();
								String strcostentry="select costentry from gl_invmode where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1]);
								int costentry=0;
								ResultSet rscostentry=stmtcostentry.executeQuery(strcostentry);
								while(rscostentry.next()){
									costentry=rscostentry.getInt("costentry");
								}

								if(costentry==1){
									Statement stmtgettran=conn.createStatement();
									String strgettran="select tranid from my_jvtran where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+" and tr_no="+trno;
									//	System.out.println("GetTran Query:"+strgettran);
									ResultSet rsgettran=stmtgettran.executeQuery(strgettran);
									int temptranid=0;
									while(rsgettran.next()){
										temptranid=rsgettran.getInt("tranid");
									}
									int count=0;
									ArrayList<String> costmovarray=new ArrayList<String>();
									Statement stmtcostmov=conn.createStatement();
									double temptimediff=0.0;
									String tempcostfleet="";
									String strtemptimediff="select (TIMESTAMPDIFF(second,'"+fromdate+" 00:00:00' ,'"+todate+" 23:59:59'))/(60*60) temptimediff";
									Statement stmttemptimediff=conn.createStatement();
									//								System.out.println("TemptimeDiff Sql:"+strtemptimediff);
									ResultSet rstemptimediff=stmtcostmov.executeQuery(strtemptimediff);
									while(rstemptimediff.next()){
										temptimediff=rstemptimediff.getDouble("temptimediff");

									}
									//								System.out.println("TimeDiffer In Hours:"+temptimediff);
									stmttemptimediff.close();
									String strcostmov="select sum(aa.hourdiff) hourdiff,aa.fleet_no from("+
											" select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno from ("+
											" select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout) as datetime))"+
											" dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(coalesce(concat(din,' ',tin),'"+todate+" 23:59:59') as datetime)) din,tin"+
											" from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"'  and trancode<>'DL'  and (dout between '"+fromdate+"' and '"+todate+"' or  coalesce(din,'"+todate+"')"+
											" between '"+fromdate+"' and '"+todate+"')) kk)aa group by aa.fleet_no ";
									/*String strcostmov="select (TIMESTAMPDIFF(second,dout ,coalesce(din,'"+todate+"')))/(60*60) hourdiff,fleet_no,kk.repno from ("+
										" select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout)"+
										" as datetime)) dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(concat(din,' ',tin) as datetime))"+
										" din,tin from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"' and (dout between '"+fromdate+"' and '"+todate+"' or "+
										" coalesce(din,'"+todate+"') between '"+fromdate+"' and '"+todate+"') group by fleet_no )kk";*/
									//System.out.println("Cost Mov Sql:"+strcostmov);
									ResultSet rscostmov=stmtcostmov.executeQuery(strcostmov);
									int counter=0;
									while(rscostmov.next()){

										//count=rscostmov.getInt("repno");
										//	if(count==0){
										costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));

										counter++;
										/*	}
									if(count>0){
										double tempamt=(Double.parseDouble(rscostmov.getString("hourdiff"))/temptimediff)*partydramt;
										costmovarray.add(tempamt+""+"::"+rscostmov.getString("fleet_no"));

									}*/


									}
									stmtcostmov.close();
									Statement stmtcostinsert=conn.createStatement();

									for(int j=0;j<costmovarray.size();j++){
										//				System.out.println("============================================="+i);
										if(counter==1){

											String costmov=costmovarray.get(j);
											String costmovamt=costmov.split("::")[0];
											String costmovfleet=costmov.split("::")[1];
											String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
													",6,"+partydramt+","+srno+","+temptranid+",0,"+costmovfleet+","+trno+")";
											//										System.out.println("Insert Costtran Sql:"+strcostinsert);
											srno++;
											int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
											if(costinsertval<0){
												//conn.close();
												System.out.println("Cost Insert Error");
												return false;
											}

										}
										else if(counter>1){
											String costmov=costmovarray.get(j);
											String costmovamt=costmov.split("::")[0];
											String costmovfleet=costmov.split("::")[1];
											double amt=(Double.parseDouble(costmovamt)/temptimediff)*partydramt;
											//		System.out.println("Total Amt:"+amt+":::costmovamt="+costmovamt+":::::::::TempTime Diff="+temptimediff+":::::::::Amount="+partydramt);
											String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
													",6,"+amt+","+srno+","+temptranid+",0,"+costmovfleet+","+trno+")";
											//			System.out.println("Insert Costtran Sql:"+strcostinsert);
											srno++;
											int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
											if(costinsertval<0){
												//conn.close();
												System.out.println("Cost Insert Error2");
												return false;
											}

										}
									}
									stmtcostinsert.close();

								}
								else{

								}

							}
						}
					}
					if(salikamt>0){

						/*		Statement stmtsalik=conn.createStatement();
								String strupdatesalik="update gl_salik set inv_no="+docno+",inv_type='INV',status=1 where ra_no="+agmtno+" and rtype "+rtype+" and status in(3,0) and sal_date>='"+fromdate+"' and sal_date<='"+todate+"'";
//								System.out.println("Update Salik:"+strupdatesalik);
								int val=stmtsalik.executeUpdate(strupdatesalik);
								if(val<0){
									System.out.println("Salik Update Error");
									//conn.close();

									return false;
								}*/


						//Closing for origin (salik update)
						String saliknote=""+salikqty+" Saliks";
						if(invdescconfig==1){
							String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
							//saliknote="Salik Charges "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno+" NOS - "+salikcount;
							//Overridden for WORLDRAC on 04/05/2017
							String strfromdate="",strtodate="";
							if(fromdate!=null){
								strfromdate=objcommon.changeSqltoString(fromdate);
							}
							if(todate!=null){
								strtodate=objcommon.changeSqltoString(todate);
							}
							saliknote=salikqty+" Saliks of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate;
						}
						String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+trno+"','"+acno+"',"+
								"'"+salikamt+"','"+testcurrate+"','"+testcurid+"',0,1,8,"+
								"'"+branchid+"','"+saliknote+"',"+
								"0,'"+date+"','"+formdetailcode+"','"+salikamt*testcurrate+"','"+docno+"','"+qty2+"',"+
								"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
						//System.out.println("SqlJV"+sqljv);
						int rsjv=stmtinvoice.executeUpdate(sqljv);
						if(rsjv>0){

						}
						else{
							System.out.println("Jvtran salik Error");
							return false;
						}
					}

					if(trafficamt>0){

						/*Statement stmttraffic=conn.createStatement();
								String strupdatetraffic="update gl_traffic set inv_no="+docno+",inv_desc='"+trafficdesc+"',status=1 where ra_no="+agmtno+" and rtype "+rtype+" and status in(3,0) and traffic_date >= '"+fromdate+"' and traffic_date <= '"+todate+"'";

								int val=stmttraffic.executeUpdate(strupdatetraffic);
								System.out.println("Update Traffic Val:"+val+":::"+strupdatetraffic);
								if(val<0){
									System.out.println("Traffic Update Error");
									//conn.close();
									return false;
								}*/



						String trafficnote=""+trafficqty+" Traffics";
						if(invdescconfig==1){
							// System.out.println("Inside Traffic Description");
							String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
							//trafficnote=temptrafficdesc+" - "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno;
							//Overridden for WORLDRAC on 04/05/2017
							String strfromdate="",strtodate="";
							if(fromdate!=null){
								strfromdate=objcommon.changeSqltoString(fromdate);
							}
							if(todate!=null){
								strtodate=objcommon.changeSqltoString(todate);
							}
							trafficnote=trafficqty+" Traffics of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate;
						}
						String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+trno+"','"+acno+"',"+
								"'"+trafficamt+"','"+testcurrate+"','"+testcurid+"',0,1,9,"+
								"'"+branchid+"','"+trafficnote+"',"+
								"0,'"+date+"','"+formdetailcode+"','"+trafficamt*testcurrate+"','"+docno+"','"+qty2+"',"+
								"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
						//	System.out.println("SqlJV"+sqljv);
						int rsjv=stmtinvoice.executeUpdate(sqljv);
						if(rsjv>0){

						}
						else{
							System.out.println("Jvtran Traffic Error");
							//conn.close();
							return false;
						}
					}



					//if(!origin.equalsIgnoreCase("1")){

						//Tax Portion Starts Here
					Statement stmtchecktax=conn.createStatement();
					String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+hidclient+" and dtype='CRM') clienttaxmethod";
					System.out.println(strchecktax);
					ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
					int taxstatus=0;
					int clienttaxmethod=0;
					while(rschecktax.next()){
						taxstatus=rschecktax.getInt("taxmethod");
						clienttaxmethod=rschecktax.getInt("clienttaxmethod");
					}
					if(taxstatus==1 && clienttaxmethod==1){
							System.out.println("Inside TaxDetail");
						
						// Getting amount in which tax is applicable
						Statement stmtgettax=conn.createStatement();
						String strtaxapplied="select total from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+docno;
						System.out.println(strtaxapplied);
						ResultSet rsapplied=stmtgettax.executeQuery(strtaxapplied);
						double generalamttax=0.0;
						while(rsapplied.next()){
							generalamttax+=rsapplied.getDouble("total");
						}
						int igststatus=0;
						String strigst="select igststatus from gl_ragmt where doc_no="+agmtno;
						ResultSet rsigst=stmtchecktax.executeQuery(strigst);
						while(rsigst.next()){
							igststatus=rsigst.getInt("igststatus");
						}
						String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+date+"' between tax.fromdate and tax.todate";
						double setpercent=0.0;
						double vatpercent=0.0;
						ResultSet rsgettax=stmtgettax.executeQuery(strgettax);
						double vatval=0.0,setval=0.0;
						ArrayList<String> temptaxarray=new ArrayList<>();
						while(rsgettax.next()){
							setpercent=rsgettax.getDouble("set_per");
							vatpercent=rsgettax.getDouble("vat_per");
							vatval=(generalamttax*(vatpercent/100));
							setval=generalamttax*(setpercent/100);
							setval=objcommon.Round(setval, 2);
							vatval=objcommon.Round(vatval, 2);
							if(igststatus==1){
								if(rsgettax.getInt("idno")==21){
									if(setval>0.0){
										temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+setval+"::"+rsgettax.getString("description"));
										generalamt+=setval;
									}
								}
							}
							else{
								if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
									if(vatval>0.0){
										temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
										generalamt+=vatval;
									}
								}
							}
						}
						System.out.println();
						if(setpercent>0.0 || vatpercent>0.0){
							
							/*if(damageamount>0){
								//System.out.println("Damage amount: "+damageamount+"//////General Amount: "+generalamt);
								vatval=((generalamt-damageamount)*(vatpercent/100));	

							}
							else{
								vatval=(generalamttax*(vatpercent/100));
							}*/
							//setval=objcommon.Round(setval, 2);
							//vatval=objcommon.Round(vatval, 2);
							//generalamt=generalamt+setval;

							generalamt=objcommon.Round(generalamt, 2);

							
							//generalamt=generalamt+vatval;
							generalamt=objcommon.Round(generalamt, 2);
							generalldr=generalamt*testcurrate;

							/*Statement stmtgetinvmode=conn.createStatement();
							String strgetinvmode="select (select acno from gl_invmode where idno=19) setacno,(select acno from gl_invmode where idno=20) vatacno";
							ResultSet rsinvmode=stmtgetinvmode.executeQuery(strgetinvmode);
							ArrayList<String> temptaxarray=new ArrayList<>();
							while(rsinvmode.next()){
								temptaxarray.add(19+"::"+rsinvmode.getString("setacno")+"::"+setval+"::"+"SET");
								temptaxarray.add(20+"::"+rsinvmode.getString("vatacno")+"::"+vatval+"::"+"VAT");
							}*/
							int tempsrno=invoicearray.size()+1;
							for(int j=0;j<temptaxarray.size();j++){
								System.out.println(temptaxarray.get(j));
								String[] tax=temptaxarray.get(j).split("::");
								Statement stmttaxinvd=conn.createStatement();
								if(Double.parseDouble(tax[2])>0){
									String strtaxinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+branchid+"','"+docno+"'"+
											",'"+trno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
												System.out.println("Invd Sql:"+strtaxinvd);
									int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
									if(taxinvdval>0){
										String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
												"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+trno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
												"'"+Double.parseDouble(tax[2])*-1+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(tempsrno)+"',"+
												"'"+branchid+"','"+note+"',"+
												"0,'"+date+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*testcurrate)*-1+"','"+docno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
												"'"+testcurid+"','5',1,'"+hidclient+"',3,'"+agmtno+"','"+cmbagmttype+"')";
										tempsrno++;
										Statement stmttaxjv=conn.createStatement();
														System.out.println("Jvtran Sql:"+strtaxjv);
										int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
										if(taxjvval>0){

										}
										else{
											System.out.println("Jvtran Tax Error");
											return false;
										}
										stmttaxjv.close();
										stmttaxinvd.close();
									}
									else{
										System.out.println("Tax Invd Error");
										return false;
									}
								}
							}
							stmtchecktax.close();
							//stmtgetinvmode.close();
							stmtgettax.close();
						}

					}


				//}//Closing for origin (Tax)
				//If Tax Method is Disabled in gl_config
				if(generalamt>0){

					double ramt=Math.round(generalamt);
					double ramtldr=ramt*testcurrate;
					double discount = (generalamt-ramt);
					discount=objcommon.Round(discount, 2);
					/*discount=Math.round(discount*-1);*/
					//System.out.println("Check:"+Math.scalb(discount, 2));
					double discountldr=discount*testcurrate;
					// System.out.println("R Amt:"+ramt+"::::::::::Discount:"+discount+"General Amt:"+generalamt);
					// discount a/c jvtran  discount*-1   
					Statement stmtdiscount=conn.createStatement();
					String strdiscount="select acno discountacno from gl_invmode where idno=13";
					ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
					int  discac=0;
					while(rsdiscount.next()){
						discac=rsdiscount.getInt("discountacno");
					}
					if(discount!=0.0){
						Statement stmtdiscjv=conn.createStatement();
						Statement stmtdiscinvd=conn.createStatement();
						String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+branchid+"','"+docno+"'"+
								",'"+trno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
						int discinvd=stmtdiscinvd.executeUpdate(sql);
						if(discinvd<=0){
							stmtdiscinvd.close();
							stmtdiscjv.close();
							stmtdiscount.close();
							conn.close();
							return false;
						}
						stmtdiscinvd.close();
									System.out.println(" Invd Sql"+sql);
						int discid=0;
						if(discount>0.0){
							discid=1;
						}
						else if(discount<0.0){
							discid=-1;
						}
						String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+trno+"','"+discac+"',"+
								"'"+discount+"','"+testcurrate+"','"+testcurid+"',0,"+discid+",1,"+
								"'"+branchid+"','Discount',"+
								"0,'"+date+"','"+formdetailcode+"','"+discountldr+"','"+docno+"','"+qty2+"',"+
								"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
						System.out.println("Discount JV: "+sqljvdisc);
						int discval=stmtdiscjv.executeUpdate(sqljvdisc);
						if(discval<=0){
							stmtdiscjv.close();
							stmtdiscount.close();
							conn.close();
							return false;

						}
						stmtdiscjv.close();
						stmtdiscount.close();
					}

					String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+trno+"','"+acno+"',"+
							"'"+ramt+"','"+testcurrate+"','"+testcurid+"',0,1,1,"+
							"'"+branchid+"','"+note+"',"+
							"0,'"+date+"','"+formdetailcode+"','"+ramtldr+"','"+aaa+"','"+qty2+"',"+
							"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
					System.out.println("General Jv sql:"+sqljv);
					int rsjv=stmtinvoice.executeUpdate(sqljv);
					if(rsjv>0){
								System.out.println("Inside general jv");	
					}
					else{
						System.out.println("General jvtran error");
						//conn.close();
						return false;
					}
					stmtdiscount.close();
				}						//}

					//If Tax Method is Disabled in gl_config
	
					//System.out.println("no====="+aaa);


					if (docno > 0) {
						String testjv1="select dramount from my_jvtran where tr_no="+trno;
						ResultSet rstestjv1=stmtinvoice.executeQuery(testjv1);
						//									System.out.println("Test Sum Jvtran"+testjv);
						while(rstestjv1.next()){
						System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
						}
						//									System.out.println("InvNo > 0");

						String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+trno;
						ResultSet rstestjv=stmtinvoice.executeQuery(testjv);
						//									System.out.println("Test Sum Jvtran"+testjv);
						while(rstestjv.next()){
							//System.out.println("jv vvalue"+rstestjv.getDouble("dramount"));
							if(rstestjv.getDouble("dramount")==0.00){

								stmtinvoice.close();

								//	conn.close();
								return true;
							}
							else{
								stmtinvoice.close();

								//conn.close();
								System.out.println("Jv tally Error");
								return false;
							}
						}

					}


				}




			}


		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}






	public boolean delete(Connection conn,int docno,Date date,Date fromdate,Date todate,String cmbagmttype,int agmtno,String branchid,String userid,String formdetailcode) throws SQLException {

		try{

			//Getting TRNO for further deleting
			Statement stmttrno=conn.createStatement();
			String strtrno="select tr_no from gl_invm where doc_no="+docno;
			int trno=0;
			ResultSet rstrno=stmttrno.executeQuery(strtrno);
			while(rstrno.next()){
				trno=rstrno.getInt("tr_no");
			}
			stmttrno.close();




			//Change status into delete status of Invoice Master Table
			Statement stmtinvoice;
			stmtinvoice = conn.createStatement ();
			int updateval = stmtinvoice.executeUpdate("update gl_invm set status=7 where doc_no='"+docno+"'");
			if (updateval<0) {
				return false;
			}
			stmtinvoice.close();
			//Clearing invoice Reference in Agreement tables
			String strclearagmtinvno="";
			String strclearcalc="";

			if(cmbagmttype.equalsIgnoreCase("RAG")){
				strclearagmtinvno="update gl_ragmt set addr_invno=0,del_invno=0 where doc_no="+agmtno;

				strclearcalc="delete from gl_rcalc where rdocno="+agmtno+" and trno="+trno;
			}
			if(cmbagmttype.equalsIgnoreCase("LAG")){
				strclearagmtinvno="update gl_lagmt set addr_invno=0,del_invno=0 where doc_no="+agmtno;

				strclearcalc="delete from gl_rcalc where rdocno="+agmtno+" and trno="+trno;


			}
			Statement stmtclearagmt=conn.createStatement();
			int clearagmt=stmtclearagmt.executeUpdate(strclearagmtinvno);
			if(clearagmt<0){
				return false;
			}
			stmtclearagmt.close();

			//Clearing Data from Rcalc/Lcalc tables
			Statement stmtclearcalc=conn.createStatement();
			int clearcalc=stmtclearcalc.executeUpdate(strclearcalc);
			if(clearcalc<0){
				return false;
			}

			stmtclearcalc.close();

			if(cmbagmttype.equalsIgnoreCase("LAG")){
				String strleaseserv="update gl_lothser set invno=0,invstatus=0 where invno="+docno;
				Statement stmtleaseserv=conn.createStatement();
				int leaseserv=stmtleaseserv.executeUpdate(strleaseserv);
				if(leaseserv<0){
					return false;
				}

				stmtleaseserv.close();
			}

			//Deleting data from my_jvtran
			ClsApplyDelete objapply=new ClsApplyDelete();
			int applydelete=objapply.getFinanceApplyDelete(conn, trno);
			if(applydelete<0){
				return false;
			}
			String strjvdelete="update my_jvtran set status=7 where tr_no="+trno;
			Statement stmtjvdelete=conn.createStatement();
			int jvdeleteval=stmtjvdelete.executeUpdate(strjvdelete);
			if(jvdeleteval<0){
				return false;
			}

			stmtjvdelete.close();

			//Clearing Invoice Reference from salik table

			String strclearsalik="update gl_salik set status=0,inv_no=0,inv_type='' where inv_no="+agmtno;
			Statement stmtclearsalik=conn.createStatement();
			int clearsalikval=stmtclearsalik.executeUpdate(strclearsalik);
			if(clearsalikval<0){
				return false;
			}
			stmtclearsalik.close();

			//Clearing Invoice Reference from traffic table

			String strcleartraffic="update gl_traffic set status=0,inv_no=0,inv_type='',inv_desc='' where inv_no="+docno;
			Statement stmtcleartraffic=conn.createStatement();
			int cleartrafficval=stmtcleartraffic.executeUpdate(strcleartraffic);
			if(cleartrafficval<0){
				return false;
			}

			stmtcleartraffic.close();

			Statement stmtclearcost=conn.createStatement();
			String strclearcost="delete from my_costtran where tr_no="+trno;
			int clearcost=stmtclearcost.executeUpdate(strclearcost);
			if(clearcost<0){
				return false;
			}
			stmtclearcost.close();

			Statement stmtlog=conn.createStatement();
			String strlog="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+","+branchid+",'"+formdetailcode+"',now(),"+userid+",'D')";
			int logval=stmtlog.executeUpdate(strlog);
			if(logval<0){
				return false;
			}
			if(logval>0){
				return true;
			}
			//System.out.println("Success");




		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}


		return false;
	}



	public int getVoucherno(int val) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int voucherno=0;
		try{
			conn=objconn.getMyConnection();
			Statement stmtvoucher=conn.createStatement();
			String strvoucher="select voc_no from gl_invm where doc_no="+val;
			ResultSet rsvoucher=stmtvoucher.executeQuery(strvoucher);
			while(rsvoucher.next()){
				voucherno=rsvoucher.getInt("voc_no");
			}
			stmtvoucher.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();	
		}
		finally{
			conn.close();
		}
		return voucherno;
	}


	public   int getCompChk() throws SQLException {



		Connection conn = null;
		int isindian=0;

		try {
			conn = objconn.getMyConnection();
			Statement stmt1 = conn.createStatement ();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();


			String strSql1 = "select method from gl_config where field_nme='indian'";

			ResultSet rs1 = stmt1.executeQuery(strSql1);
			while(rs1.next ()) {
				isindian=rs1.getInt("method");
			}




			stmt1.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return isindian;
	}	


	public   String getFileName(String formcode) throws SQLException {



		Connection conn = null;
		String path="";
		String fileName ="";
		String filepath="";
		try {
			conn = objconn.getMyConnection();
			Statement stmt1 = conn.createStatement ();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();

			/*	Calendar now = GregorianCalendar.getInstance();

        		SimpleDateFormat df = new SimpleDateFormat("HH");
        		String formattedDate = df.format(new Date())*/;

        		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
        		java.util.Date date = new java.util.Date();
        		//System.out.println(dateFormat.format(date)); //2014/08/06 15:59:48


        		//String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

        		String currdate=dateFormat.format(date);

        		//System.out.println("===currdate======"+currdate);

        		String strSql1 = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");

        		ResultSet rs1 = stmt1.executeQuery(strSql1);
        		while(rs1.next ()) {
        			path=rs1.getString("imgPath");
        		}

        		fileName = formcode+"["+request.getParameter("vocno")+"]"+currdate+".pdf";

        		filepath=path+ "/attachment/"+formcode+"/"+fileName;

        		ServletContext context = ((HttpSession) request).getServletContext();
        		File dir = new File(path+ "/attachment/"+formcode);
        		dir.mkdirs();



        		stmt1.close();
        		conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return filepath;
	}


	public   ClsManualInvoiceBean sendMail (String fromno,String branch) throws SQLException {
		ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
		Connection  conn =null;
		HttpServletRequest request=ServletActionContext.getRequest();
		ArrayList<ClsManualInvoiceAction> employees = new ArrayList();
		try {
			conn= objconn.getMyConnection();
			ClsNumberToWord obj=new ClsNumberToWord();
			
			Statement stmtinvoice = conn.createStatement ();
			String strSql="";



			ArrayList<Double> totalarray=new ArrayList<>();

			String strtotal="select round(sum(coalesce(total,0)),2) total,inv.doc_no from gl_invm inv left join gl_invd on doc_no=rdocno where inv.doc_no="+fromno+"  and inv.status<>7 and inv.brhid="+branch+" group by doc_no order by doc_no";
			ResultSet rstotal=stmtinvoice.executeQuery(strtotal);

			while(rstotal.next()){
				totalarray.add(rstotal.getDouble("total"));
			}


			strSql="select  coalesce(br.tinno,'') as tinno,coalesce(br.pbno,'') as pbno,coalesce(br.stcno,'') stcno,coalesce(br.cstno,'') cstno,coalesce(dr.name,dr1.name) driven,inv.fromdate sqlfromdate,inv.todate sqltodate,br.branch,year(inv.date) dateyear,agmt.pono,DATE_FORMAT(CURDATE(),'%d/%m/%Y')"+
					" finaldate,cur.code,cmp.company,cmp.address ,cmp.tel,cmp.fax,br.branchname,ac.refname,ac.com_mob,ac.per_mob,ac.fax1,dr.name,"+
					" inv.voc_no as doc_no, DATE_FORMAT(inv.date,'%d/%m/%Y') date,inv.rano,DATE_FORMAT(inv.fromdate,'%d/%m/%Y') fromdate,"+
					" DATE_FORMAT(inv.todate,'%d/%m/%Y') todate,inv.acno, inv.ratype,if(inv.ratype='RAG',coalesce(agmt.ofleet_no,''),coalesce(veh.fleet_no,'')) ofleet_no,"+
					" if(inv.ratype='RAG',coalesce(agmt.mrano,''),coalesce(lagmt.manualra,'')) mrano,coalesce(DATE_FORMAT(agmt.odate,'%d/%m/%Y'),"+
					" DATE_FORMAT(lagmt.outdate,'%d/%m/%Y')) agmtdate,veh.flname,veh.reg_no,plt.code_name,auth.authname,ac.address cladd,ac.address2 cladd1,lc.loc_name,u.user_name"+
					" from gl_invm inv"+
					" left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"+
					" left join gl_lagmt lagmt on(inv.rano=lagmt.doc_no and inv.ratype='LAG')"+
					" left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"+
					" left join gl_vehmaster veh on ((agmt.ofleet_no=veh.fleet_no  and inv.ratype='RAG') or ((select if(perfleet=0,tmpfleet,perfleet) fleet from gl_lagmt"+
					" where doc_no=inv.rano)=veh.fleet_no and inv.ratype='LAG'))"+
					" left join gl_vehplate plt on veh.pltid=plt.doc_no"+
					" left join gl_vehauth auth on veh.authid=auth.doc_no"+
					" left join (select min(srno) srno,rdocno from gl_rdriver where status=3 group by rdocno) gdr on  agmt.doc_no=gdr.rdocno "+
					" left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno and rdr.srno=gdr.srno "+ 
					" left join (select min(srno) srno,rdocno from gl_ldriver where status=3 group by rdocno) gldr on  lagmt.doc_no=gldr.rdocno "+
					" left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno and ldr.srno=gldr.srno  "+
					" left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
					" left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
					" left join my_brch br on inv.brhid=br.doc_no"+
					" left join my_comp cmp on br.cmpid=cmp.doc_no"+
					" left join my_curr cur on cmp.curid=cur.doc_no"+
					" inner join my_locm l on l.brhid=br.doc_no"+
					" inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no)"+
					" left join my_user u on u.doc_no=inv.userid where inv.doc_no="+fromno+"  and inv.status<>7 and inv.brhid="+branch+" group by inv.doc_no";

			//System.out.println("Print query:"+strSql);
			/*String strSqldetail="select invd.sr_no,imod.description,invd.units,invd.amount,invd.total from gl_invd invd left join gl_invmode imod on "+
						" invd.chid=imod.idno where invd.rdocno >="+fromno+" and invd.rdocno<="+tono+"";
	//System.out.println("Detail"+strSqldetail);
			 */			
			ArrayList<ArrayList<String>> printdet=new ArrayList<>();
			ArrayList<ArrayList<String>> printfleetmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printsalikmaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficdubaimaster=new ArrayList<>();
			ArrayList<ArrayList<String>> printtrafficelsemaster=new ArrayList<>();
			ResultSet resultSet = stmtinvoice.executeQuery (strSql);
			int i=0;
			while(resultSet.next()){
				String fleet="";
				fleet="Fleet :"+resultSet.getString("ofleet_no");
				fleet=fleet+" "+resultSet.getString("flname");
				fleet=fleet+" Reg No :"+resultSet.getString("reg_no");
				fleet=fleet+" "+resultSet.getString("code_name");
				fleet=fleet+" "+resultSet.getString("authname");

				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLblprintname("Invoice");
				bean.setLblclient(resultSet.getString("refname"));
				bean.setLblphone(resultSet.getString("com_mob"));
				bean.setLblmobile(resultSet.getString("per_mob"));
				bean.setLblfax(resultSet.getString("fax1"));
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLblinvno(resultSet.getString("doc_no"));
				bean.setLblbranchcode(resultSet.getString("branch"));
				bean.setLbldateyear(resultSet.getString("dateyear"));
				bean.setLbldate(resultSet.getString("date").toString());
				bean.setLblrano(resultSet.getString("rano"));
				bean.setLblinvfrom(resultSet.getString("fromdate").toString());
				bean.setLblinvto(resultSet.getString("todate"));
				bean.setLblrecievedby(resultSet.getString("user_name"));
				String ac="";
				ac=resultSet.getString("acno");
				//ac=ac+" "+resultSet.getString("description");
				bean.setLblaccount(ac);
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
					bean.setLblmrano(resultSet.getString("mrano"));
				}
				bean.setLblcontractstart(resultSet.getString("agmtdate").toString());

				bean.setLblcontractvehicle(fleet);
				bean.setLblratype(resultSet.getString("ratype"));
				bean.setLbltotal(totalarray.get(i).toString());
				bean.setLblnetamount(totalarray.get(i).toString());
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLbladdress1(resultSet.getString("cladd"));
				bean.setLbladdress2(resultSet.getString("cladd1"));
				bean.setLblfinaldate(resultSet.getString("finaldate").toString());
				bean.setLbllocation(resultSet.getString("loc_name"));
				/*
		bean.setTinno(resultSet.getString("tinno"));
		bean.setLblservicetax(resultSet.getString("stcno"));
		bean.setLblcstno(resultSet.getString("cstno"));
				 */
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
					bean.setLbllpono(resultSet.getString("pono"));
				}
				bean.setLblamountwords(resultSet.getString("code")+" "+obj.convertNumberToWords(totalarray.get(i))+" only");

				i++;		
			}

			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	public   HashMap getEmailPrintdetails(String docno) throws SQLException {
		ArrayList<String> arr=null;
		HashMap map=new HashMap();
		Connection conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";
			/*		
strSqldetail="select r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,m.description from gl_invmode m left join (select r.chid,"+
		" r.units,round(r.amount,2) amount,round(coalesce(sum(total),0),2) total from gl_invd r where r.chid not in(8,9,14,15) and"+
		" rdocno="+docno+" group by chid"+
		" union all"+
		" select r.chid,r.units,round(sum(r.amount),2),round(coalesce(sum(total),0),2) total from gl_invd r where r.chid in(8,14) and rdocno="+docno+""+
		" union all"+
		" select r.chid,r.units,round(r.amount,2),round(coalesce(sum(total),0),2) total from gl_invd r where r.chid  in(9,15) and rdocno="+docno+""+
		" ) r on(m.idno=r.chid) where r.chid is not null";*/


			strSqldetail="select  r.chid,r.units,round(r.amount,2) amount,round(r.total,2) total,case when r.chid=19 then concat(m.description,' @ ', "
					+ "	(select  round(set_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail  where "
					+ " r.date >=fromdate and r.date <=todate and status=3 )),' %') when r.chid=20 then concat(m.description,' @ ', "
					+ "(select round(vat_per,1) from gl_taxdetail where doc_no=(select max(doc_no) from gl_taxdetail where "
					+ "r.date >=fromdate and r.date <=todate and status=3)),' %') else m.description end description from gl_invmode m left join "
					+ "(select r.chid,r.units,round(r.amount,2) amount, round(coalesce(sum(total),0),2) total,m.date from gl_invm m  inner join"
					+ " gl_invd r on m.doc_no=r.rdocno where r.chid not in(8,9,14,15) and rdocno="+docno+" group by chid union all "
					+ "	select r.chid,r.units,round(sum(r.amount),2),round(coalesce(sum(total),0),2)  total,m.date from gl_invm m  "
					+ " inner join gl_invd r on m.doc_no=r.rdocno  where r.chid in(8,14) and rdocno="+docno+" union all select r.chid,r.units, "
					+ " round(r.amount,2), round(coalesce(sum(total),0),2) total,m.date from gl_invm m  inner join gl_invd r on m.doc_no=r.rdocno  where"
					+ "	r.chid in(9,15) and rdocno="+docno+") r on(m.idno=r.chid) where r.chid is not null";

			//System.out.println("====getPrintdetails==== "+strSqldetail);
			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);

			int rowcount=1;
			/*if(rsdetail.last()){
	rowcount=rsdetail.getRow();
	rsdetail.beforeFirst();
}*/
			while(rsdetail.next()){
				arr=new ArrayList<String>();
				arr.add(rowcount+"");
				arr.add(rsdetail.getString("description"));
				arr.add(rsdetail.getString("units"));
				arr.add(rsdetail.getString("amount"));
				arr.add(rsdetail.getString("total"));

				map.put(rowcount, arr);
				//System.out.println("=====rowcountrowcountrowcount===== "+map.get(rowcount));
				rowcount++;


			}
			//System.out.println("========== "+arr);
			stmtinvoice.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return map;
	}

	public   ArrayList<String>  getFleetdetailsmail(String lblrano,Date fromdate,Date todate,String lblratype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> fleetarray=new ArrayList<>();
		try {
			String strfleetdetails="select distinct mov.fleet_no,veh.flname,veh.reg_no,DATE_FORMAT(mov.dout,'%d/%m/%Y') dout,COALESCE(DATE_FORMAT(mov.din,'%d/%m/%Y '),'') "+
					" din from gl_vmove mov left join gl_vehmaster veh on (mov.fleet_no=veh.fleet_no ) where mov.rdocno="+lblrano+" and mov.rdtype='"+lblratype+"' and mov.repno<> 0 and mov.trancode<>'DL'"+
					" and ((dout >='"+fromdate+"' and dout <='"+todate+"') or (din >='"+fromdate+"' and din <='"+todate+"'))";
			conn=objconn.getMyConnection();

			//System.out.println("==getFleetdetails===="+strfleetdetails);

			Statement stmtfleetdetails = conn.createStatement();
			ResultSet rsfleetdetails=stmtfleetdetails.executeQuery(strfleetdetails);
			while(rsfleetdetails.next()){
				String temp=rsfleetdetails.getString("fleet_no")+"  "+rsfleetdetails.getString("flname")+"  "+"Reg No:"+rsfleetdetails.getString("reg_no")+"  "+"From Date:"+rsfleetdetails.getString("dout")+"  "+"To Date:"+rsfleetdetails.getString("din");
				fleetarray.add(temp);
			}
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return fleetarray;
	}

	public  JSONArray printInvoiceSearch(String mode,String fromdate,String todate,String agmtno,String agmttype,String client,String branch,String fromno,String tono) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return RESULTDATA;
		}

		String sqltest="";
		java.sql.Date sqlfromdate=null,sqltodate=null;

		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}

		if(!fromno.equalsIgnoreCase("")){
			sqltest+=" and inv.voc_no>="+fromno+"";
		}
		if(!tono.equalsIgnoreCase("")){
			sqltest+=" and inv.voc_no<="+tono+"";
		}

		if(sqlfromdate!=null ){
			sqltest+=" and inv.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and inv.date<='"+sqltodate+"'";
		}

		if(!agmttype.equalsIgnoreCase("")){
			sqltest+=" and inv.ratype='"+agmttype+"'";
		}
		if(agmttype.equalsIgnoreCase("RAG")){
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and agmt.voc_no="+agmtno+"";
			}
		}
		if(agmttype.equalsIgnoreCase("LAG")){
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and lagmt.voc_no="+agmtno+"";
			}
		}
		if(!client.equalsIgnoreCase("")){
			sqltest+=" and ac.refname like '%"+client+"%'";
		}
		if(!branch.equalsIgnoreCase("")){
			sqltest+=" and inv.brhid="+branch+"";
		}


		Connection conn=null;

		try {
			conn= objconn.getMyConnection();
			Statement stmtsearch = conn.createStatement ();
			String str1Sql="select inv.doc_no,inv.voc_no voucherno,inv.rano,inv.date,inv.ratype agmttype,ac.refname,if(inv.ratype='RAG',agmt.voc_no,lagmt.voc_no) voc_no "+
					" from gl_invm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_ragmt agmt on "+
					" (inv.rano=agmt.doc_no and inv.ratype='RAG') left join gl_lagmt lagmt on (inv.rano=lagmt.doc_no and inv.ratype='LAG') where inv.status<>7 "+sqltest+""+
					" group by inv.doc_no";
			//		System.out.println("Print Search Query:"+str1Sql);
			ResultSet resultSet = stmtsearch.executeQuery(str1Sql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtsearch.close();
			conn.close();
			return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		conn.close();
		return RESULTDATA;
	}

	public String sendSMS(String doc_no,String branchid,String dtype,String trafficamt,String hidclient,String traffic_date,Connection conn){


		Statement smt=null;
		try {
			
			smt = conn.createStatement();

			SmsAction sms=new SmsAction();
			String phone="",clname="";
			try
			{


				ResultSet rs= conn.createStatement(
						ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
								"select refname,per_mob from my_acbook where doc_no="+hidclient+" and dtype='CRM'");

				if(rs.next())
				{

					phone=rs.getString("per_mob");
					clname=rs.getString("refname");
					

				}
				rs.close();	
			}catch(Exception e){e.printStackTrace();}



			String doctype=dtype.contains("###")?dtype.split("###")[0]:dtype;

			sms.doSendSms(phone, clname, trafficamt, doc_no, traffic_date,doctype, branchid,conn);
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}

		return "success";
	}


}
