package com.dashboard.operations.driveragmtcreate;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.components.Bean;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineBean;

public class ClsDriverAgmtCreateDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getClient(String cldocno,String clientname,String clientmobile,String clientmail,String id,String clientdate) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and refname like '%"+clientname+"%'";
			}
			if(!clientmobile.equalsIgnoreCase("")){
				sqltest+=" and per_mob like '%"+clientmobile+"%'";
			}
			if(!clientmail.equalsIgnoreCase("")){
				sqltest+=" and mail1 like '%"+clientmail+"%'";
			}
			if(!clientdate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(clientdate);
			}
			if(sqldate!=null){
				sqltest+=" and date='"+sqldate+"'";
			}
			strsql="select date,cldocno,refname clientname,per_mob clientmobile,mail1 clientmail from my_acbook where status=3 and dtype='CRM' "+sqltest;
			ResultSet rsclient=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rsclient);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
	
	public JSONArray getDriver(String id) throws SQLException{
		JSONArray driverdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return driverdata;
		}
		Connection conn=null;
		try{
			
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,sal_code code,sal_name name,lic_no license,lic_exp_dt licenseexpdate,mobile from my_salesman where sal_type='DRV' and status=3";
			ResultSet rsdriver=stmt.executeQuery(strsql);
			driverdata=objcommon.convertToJSON(rsdriver);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return driverdata;
	}
	
	public JSONArray getCheckin(String id) throws SQLException{
		JSONArray checkindata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return checkindata;
		}
		Connection conn=null;
		try{
			
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,sal_code code,sal_name name,lic_no license,lic_exp_dt licenseexpdate,mobile from my_salesman where sal_type='CHK' and status=3";
			ResultSet rsdriver=stmt.executeQuery(strsql);
			checkindata=objcommon.convertToJSON(rsdriver);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return checkindata;
	}


	public int insert(String cmbbranch, Date sqldate, String hidclient,
			String hiddriver, String cmbcontracttype, String rate,
			String normalovertime, String holidayovertime, Date sqlfromdate,
			String cmbinvoicetype,String lpono,String overrate,HttpSession session,
			HttpServletRequest request, String mode,java.sql.Date sqlcheckindate) throws SQLException {
		// TODO Auto-generated method stubu
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int monthcalmethod=0,monthcalvalue=0;
			String strdocdetails="select (select coalesce(max(doc_no)+1,1) from gl_drvagmt) maxdoc,(select method from gl_config where field_nme='drvmonthlycal') method,(select value from gl_config where field_nme='drvmonthlycal') value";
			System.out.println("-----"+strdocdetails);
			ResultSet rsmaxdoc=stmt.executeQuery(strdocdetails);
			while(rsmaxdoc.next()){
				docno=rsmaxdoc.getInt("maxdoc");
				monthcalmethod=rsmaxdoc.getInt("method");
				monthcalvalue=rsmaxdoc.getInt("value");
			}
			String stryeardoc="select method from gl_config where field_nme='Yeardocno'";
			ResultSet rsyeardoc=stmt.executeQuery(stryeardoc);
			String vocno="";
			int yeardoc=0;
			while(rsyeardoc.next()){
				yeardoc=rsyeardoc.getInt("method");
			}
			if(yeardoc==1){
				String str="select concat(1,"+cmbbranch+",DATE_FORMAT(curdate(), '%y'),LPAD(coalesce(max(SUBSTRING(voc_no FROM 5 FOR 8))+1,1),5,0)) voucher from gl_drvagmt  where brhid="+cmbbranch;
				ResultSet rsvoc=stmt.executeQuery(str);
				while(rsvoc.next()){
					vocno=rsvoc.getString("voucher");
				}
			}
			else{
				vocno=docno+"";
			}
			/*String strinvtodate="select if("+monthcalmethod+"=1,date_add('"+sqlfromdate+"',interval 1 month),date_add('"+sqlfromdate+"',interval "+monthcalvalue+" day)) invtodate";
			System.out.println(strinvtodate);
			*/
			String strinvoice="";
			if(cmbinvoicetype.equalsIgnoreCase("1")){
				//If Monthly
				strinvoice="select if("+monthcalmethod+"=1,last_day('"+sqlfromdate+"'),date_add('"+sqlfromdate+"',interval 30 day)) invtodate";
			}
			else if(cmbinvoicetype.equalsIgnoreCase("2")){
				strinvoice="select if("+monthcalmethod+"=1,date_add('"+sqlfromdate+"',interval 1 month),date_add('"+sqlfromdate+"',interval 30 day)) invtodate";
			}
			ResultSet rsinvtodate=stmt.executeQuery(strinvoice);
			java.sql.Date invtodate=null;
			while(rsinvtodate.next()){
				invtodate=rsinvtodate.getDate("invtodate");
			}
			String strinsert="insert into gl_drvagmt(doc_no,brhid,voc_no,date,cldocno,drvid,contracttype,rate,normalovertime,holidayovertime,fromdate,invdate,"+
			" invtodate,clstatus,status,userid,invtype,lpono,overrate,checkindate)values("+docno+","+cmbbranch+","+vocno+",'"+sqldate+"',"+hidclient+","+hiddriver+",'"+cmbcontracttype+"',"+rate+","+
			" "+normalovertime+","+holidayovertime+",'"+sqlfromdate+"','"+sqlfromdate+"','"+invtodate+"',0,3,"+session.getAttribute("USERID").toString()+","+cmbinvoicetype+","+lpono+","+overrate+",'"+sqlcheckindate+"')";
			System.out.println(strinsert);
			int val=stmt.executeUpdate(strinsert);
			if(val>0){
				String strlog="insert into gl_drvagmtlog(rdocno,brhid,userid,date,cldocno,drvid,contracttype,rate,normalovertime,holidayovertime,fromdate,invdate,invtodate,mode,edate,invtype,lpono,overrate,checkindate) values("+
				""+docno+","+cmbbranch+","+session.getAttribute("USERID").toString()+",'"+sqldate+"',"+hidclient+","+hiddriver+",'"+cmbcontracttype+"',"+rate+","+normalovertime+","+holidayovertime+","+
				"'"+sqlfromdate+"','"+sqlfromdate+"','"+invtodate+"','A',now(),"+cmbinvoicetype+","+lpono+","+overrate+",'"+sqlcheckindate+"')";
				System.out.println(strlog);
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert>0){
					conn.commit();
					return docno;
				}
				else{
					return 0;
				}
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}


	public boolean edit(String docno, String cmbbranch, Date sqldate,
			String hidclient, String hiddriver, String cmbcontracttype,
			String rate, String normalovertime, String holidayovertime,
			Date sqlfromdate, String cmbinvoicetype,String lpono,String overrate,HttpSession session,
			HttpServletRequest request, String mode,java.sql.Date sqlcheckindate) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String strcheckedit="select if(invdate>fromdate,0,1) editstatus from gl_drvagmt where doc_no="+docno;
			int editstatus=0;
			ResultSet rscheckeditstatus=stmt.executeQuery(strcheckedit);
			while(rscheckeditstatus.next()){
				editstatus=rscheckeditstatus.getInt("editstatus");
			}
			int monthcalmethod=0,monthcalvalue=0;
			ResultSet rsmaxdoc=stmt.executeQuery("select (select method from gl_config where field_nme='drvmonthlycal') method,(select value from gl_config where field_nme='drvmonthlycal') value");
			while(rsmaxdoc.next()){
				monthcalmethod=rsmaxdoc.getInt("method");
				monthcalvalue=rsmaxdoc.getInt("value");
			}
			
			String strinvtodate="select if("+monthcalmethod+"=1,date_add('"+sqlfromdate+"',interval 1 month),date_add('"+sqlfromdate+"',interval "+monthcalvalue+" day)) invtodate";
			ResultSet rsinvtodate=stmt.executeQuery(strinvtodate);
			java.sql.Date invtodate=null;
			while(rsinvtodate.next()){
				invtodate=rsinvtodate.getDate("invtodate");
			}
			if(editstatus==1){
				//Full Edit
				String strupdateagmt="update gl_drvagmt set cldocno="+hidclient+",drvid="+hiddriver+",contracttype='"+cmbcontracttype+"',rate="+rate+",normalovertime="+normalovertime+","+
				" holidayovertime="+holidayovertime+",fromdate='"+sqlfromdate+"',invdate='"+sqlfromdate+"',invtodate='"+invtodate+"',invtype="+cmbinvoicetype+",lpono="+lpono+",overrate="+overrate+",checkindate='"+sqlcheckindate+"' where doc_no="+docno;
				int updateval=stmt.executeUpdate(strupdateagmt);
				if(updateval>=0){
					String strlog="insert into gl_drvagmtlog(rdocno,brhid,userid,date,cldocno,drvid,contracttype,rate,normalovertime,holidayovertime,fromdate,invdate,invtodate,mode,edate,invtype,lpono,overrate,checkindate) values("+
					""+docno+","+cmbbranch+","+session.getAttribute("USERID").toString()+",'"+sqldate+"',"+hidclient+","+hiddriver+",'"+cmbcontracttype+"',"+rate+","+normalovertime+","+holidayovertime+","+
					"'"+sqlfromdate+"','"+sqlfromdate+"','"+invtodate+"','E',now(),"+cmbinvoicetype+","+lpono+","+overrate+",'"+sqlcheckindate+"')";
					int updatelog=stmt.executeUpdate(strlog);
					if(updatelog>=0){
						conn.commit();
						return true;
					}
					else{
						return false;
					}
				}
				else{
					return false;
				}
				
			}
			else{
				//Edit Only Driver
				String strupdateagmt="update gl_drvagmt set drvid="+hiddriver+" where doc_no="+docno;
				int updateval=stmt.executeUpdate(strupdateagmt);
				if(updateval>=0){
					String strlog="insert into  gl_drvagmtlog(rdocno,brhid,userid,date,mode,edate,drvid)values("+docno+","+cmbbranch+","+session.getAttribute("USERID").toString()+",CURDATE(),'E',now(),"+hiddriver+")";
					int updatelog=stmt.executeUpdate(strlog);
					if(updatelog>=0){
						conn.commit();
						return true;
					}
					else{
						return false;
					}
				}
				else{
					return false;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	
	public JSONArray getGridData(String branch,String id) throws SQLException{
		JSONArray griddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return griddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			String strsql="select agmt.checkindate,if(agmt.invtype=1,'Month End','Period') invtype,br.branchname,ac.refname client,drv.sal_name driver,agmt.lpono,agmt.overrate,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,agmt.drvid,agmt.contracttype,"+
			" round(agmt.rate,2) rate,round(agmt.normalovertime,2) normalovertime,round(agmt.holidayovertime,2) holidayovertime,agmt.fromdate from gl_drvagmt agmt"+
			" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on br.branch=agmt.brhid left join my_salesman drv on (agmt.drvid=drv.doc_no and drv.sal_type='DRV') "+
			" where agmt.status=3 and agmt.clstatus=0"+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			griddata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return griddata;
	}
	public JSONArray getGridDataexcel(String branch,String id) throws SQLException{
		JSONArray griddata=new JSONArray();
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			String strsql="select agmt.voc_no 'Doc No',agmt.date 'Date',ac.refname Client,br.branchname 'Branch Name',drv.sal_name Driver,agmt.contracttype 'Contract Type',round(agmt.rate,2) Rate,round(agmt.normalovertime,2) 'Normal Overtime/Hr',round(agmt.holidayovertime,2) 'Holiday Overtime/Hr',agmt.fromdate 'From Date',if(agmt.invtype=1,'Month End','Period') 'Invoice Type',date_format(agmt.checkindate,'%d-%m-%y') 'Expected Check In' "+
			"  from gl_drvagmt agmt"+
			" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on br.branch=agmt.brhid left join my_salesman drv on (agmt.drvid=drv.doc_no and drv.sal_type='DRV') "+
			" where agmt.status=3 and agmt.clstatus=0"+sqltest;
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			griddata=objcommon.convertToEXCEL(rs);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return griddata;
	}
	public  ClsDriverAgmtCreateBean getPrint(HttpServletRequest request,String branch,String docno) throws SQLException {
		System.out.println(docno);
		ClsDriverAgmtCreateBean bean = new ClsDriverAgmtCreateBean();

		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
      /*  if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }*/
        
        Connection conn = null;
        
	try {
		
		conn = objconn.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql="";
		String sqltest="";
		String sqltest1="";
		
		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
			sqltest+=" and agmt.brhid="+branch;
		}
		if(!docno.equalsIgnoreCase("") && !docno.equalsIgnoreCase("0") && !docno.equalsIgnoreCase("null")){
			sqltest1="  and agmt.doc_no="+docno;
		}
		String strsql="select date_format(agmt.checkindate,'%d-%m-%Y') checkindate,usr.user_name,concat(agmt.voc_no) as doc_no,if(agmt.invtype=1,'Month End','Period') invtype,br.branchname,c.company,br.tel,br.fax,br.address adres,ac.refname client,ac.address,ac.per_mob,ac.mail1,drv.sal_name driver,agmt.doc_no,agmt.lpono,round(agmt.overrate,2) overrate,agmt.voc_no,agmt.brhid,DATE_FORMAT(agmt.date,'%d-%m-%Y') AS date,agmt.cldocno,agmt.drvid,agmt.contracttype,"+
		" round(agmt.rate,2) rate,round(agmt.normalovertime,2) normalovertime,round(agmt.holidayovertime,2) holidayovertime,DATE_FORMAT(agmt.fromdate,'%d-%m-%Y') AS fromdate,DATE_FORMAT(agmt.closedate,'%d-%m-%Y') AS closedate,drd.name,drd.dlno,DATE_FORMAT(drd.led,'%d-%m-%Y') as led,drd.passport_no,DATE_FORMAT(drd.pass_exp,'%d-%m-%Y') pass_exp,DATE_FORMAT(drd.dob,'%d-%m-%Y') dob from gl_drvagmt agmt"+
		" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on br.branch=agmt.brhid left join my_salesman drv on (agmt.drvid=drv.doc_no and drv.sal_type='DRV') "+
		" left join my_comp c on br.cmpid=c.doc_no left join gl_drdetails drd on (drv.sal_type=drd.dtype and drv.doc_no=drd.doc_no) left join my_user usr on agmt.userid=usr.doc_no where agmt.status=3 and agmt.clstatus=0"+sqltest+" "+sqltest1;
		
		System.out.println(strsql);
		ResultSet resultSet = stmt.executeQuery(strsql);
		
		while(resultSet.next()){
			bean.setLbldocno(resultSet.getString("doc_no"));
			bean.setLbldate(resultSet.getString("date"));
			bean.setLblclient(resultSet.getString("client"));
			bean.setLbladdress(resultSet.getString("address"));
			bean.setLblmobile(resultSet.getString("per_mob"));
			bean.setLbldriver(resultSet.getString("driver"));
			bean.setLblcontrcttype(resultSet.getString("contracttype"));
			bean.setLblstartdate(resultSet.getString("fromdate"));
			bean.setLblinvoicetype(resultSet.getString("invtype"));
			bean.setLblrate(resultSet.getString("rate"));
			bean.setLblnormalover(resultSet.getString("normalovertime"));
			bean.setLblholidayover(resultSet.getString("holidayovertime"));
			bean.setLblradrname(resultSet.getString("name"));
			bean.setLblradlno(resultSet.getString("dlno"));
			bean.setLicexpdate(resultSet.getString("led"));
			bean.setLblpassno(resultSet.getString("passport_no"));
			bean.setLblpassexpdate(resultSet.getString("pass_exp"));
			bean.setLbldobdate(resultSet.getString("dob"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLblmail(resultSet.getString("mail1"));
			bean.setLblcomptel(resultSet.getString("tel"));;
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLbllocation(resultSet.getString("adres"));
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblclosedate(resultSet.getString("closedate"));
			bean.setLbllpo(resultSet.getString("lpono"));
			bean.setLbloverrate(resultSet.getString("overrate"));
			bean.setLblcheckedby(resultSet.getString("user_name"));
			bean.setLblcheckindate(resultSet.getString("checkindate"));
			
			/*bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblbranch(resultSet.getString("branchname"));*/
		}
		
		

		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }
}
