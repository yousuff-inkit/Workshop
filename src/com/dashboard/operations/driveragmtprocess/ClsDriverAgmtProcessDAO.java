package com.dashboard.operations.driveragmtprocess;

import java.util.ArrayList;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsDriverAgmtProcessDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getGridData(String branch,String id,String date,String type) throws SQLException{
		JSONArray griddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return griddata;
		}
		java.sql.Date sqldate=null;
		if(!date.equalsIgnoreCase("")){
			sqldate=objcommon.changeStringtoSqlDate(date);
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			if(type.equalsIgnoreCase("Invoice")){
				sqltest+=" and agmt.invtodate<='"+sqldate+"'";
			}
			String strsql="select if(agmt.invtype=1,'Month End','Period') invtype,ac.refname client,drv.sal_name driver,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,agmt.drvid,agmt.contracttype,"+
			" round(agmt.rate,2) rate,round(agmt.normalovertime,2) normalovertime,round(agmt.holidayovertime,2) holidayovertime,agmt.fromdate,invdate,invtodate from gl_drvagmt agmt"+
			" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salesman drv on (agmt.drvid=drv.doc_no and drv.sal_type='DRV') "+
			" where agmt.status=3 and agmt.clstatus=0"+sqltest;
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
	public ArrayList<String> getAccountDetails() throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> accountarray=new ArrayList<>();
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String straccount="select acno from my_account where codeno='DRV AGMT INCOME'";
			System.out.println(straccount);
			ResultSet rsaccount=stmt.executeQuery(straccount);
			while(rsaccount.next()){
				accountarray.add(rsaccount.getString("acno"));
			}
			String straccdetails="select curid,rate from my_head where doc_no="+accountarray.get(0);
			int curid=0;
			double currate=0.0;
			ResultSet rsaccdetails=stmt.executeQuery(straccdetails);
			while(rsaccdetails.next()){
				curid=rsaccdetails.getInt("curid");
				currate=rsaccdetails.getDouble("rate");
			}
			accountarray.add(curid+"");
			accountarray.add(currate+"");
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return accountarray;
	}

	public String getRefNo() throws SQLException{
		// TODO Auto-generated method stub
		String refno="";
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strrefno="select jvid from my_jvidentifyingid where menu_name='Driver Agreement Process'";
			ResultSet rsrefno=stmt.executeQuery(strrefno);
			while(rsrefno.next()){
				refno=rsrefno.getString("jvid");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return refno;
	}


	public int updateInvDate(int trno,Date uptodate,String agmtno,String normalovrtime,String holidayovertime,String totalrate,String totalnormalot,String totalholidayot, String docno,String mode,java.sql.Date sqlclosedate) throws SQLException
	{
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int invtype=0;
			java.sql.Date invdate=null,invtodate=null;
			String strinvtype="select invtype,invdate,invtodate from gl_drvagmt where doc_no="+docno;
			ResultSet rsinvtype=stmt.executeQuery(strinvtype);
			while(rsinvtype.next()){
				invtype=rsinvtype.getInt("invtype");
				invdate=rsinvtype.getDate("invdate");
				invtodate=rsinvtype.getDate("invtodate");
			}
			String drvagrementinv="";
			if(sqlclosedate!=null){
				drvagrementinv="insert into gl_drvagmtinv(inv_trno,uptodate,agmtno,normalOT_Hrs,HolidayOT_Hrs,closedate,totalrate,totalnormalOT,totalholidayOT,invdate,invtodate) values("+trno+",'"+uptodate+"',"+agmtno+","+normalovrtime+","+holidayovertime+",'"+sqlclosedate+"',"+totalrate+","+totalnormalot+","+totalholidayot+",'"+invdate+"','"+invtodate+"')";
			}
			else{
				drvagrementinv="insert into gl_drvagmtinv(inv_trno,uptodate,agmtno,normalOT_Hrs,HolidayOT_Hrs,closedate,totalrate,totalnormalOT,totalholidayOT,invdate,invtodate) values("+trno+",'"+uptodate+"',"+agmtno+","+normalovrtime+","+holidayovertime+","+sqlclosedate+","+totalrate+","+totalnormalot+","+totalholidayot+",'"+invdate+"','"+invtodate+"')";
			}
			
			System.out.println(drvagrementinv);
			int inv=stmt.executeUpdate(drvagrementinv);
			if(inv >0){
			int monthcalmethod=0,monthcalvalue=0;
			String strconfig="select method,value from gl_config where field_nme='drvmonthlycal'";
			ResultSet rsconfig=stmt.executeQuery(strconfig);
			while(rsconfig.next()){
				monthcalmethod=rsconfig.getInt("method");
				monthcalvalue=rsconfig.getInt("value");
			}
			
			String todatecalc="";
			if(mode.equalsIgnoreCase("Invoice")){
			if(monthcalmethod==1){
				 if(invtype==1){
					 todatecalc="SELECT LAST_DAY(DATE_ADD('"+invtodate+"',INTERVAL 1 month))";
				 }
				 if(invtype==2){
					 todatecalc="DATE_ADD('"+invtodate+"',INTERVAL 1 month)";
				 }
			 }
			 else if(monthcalmethod==0){
				 if(invtype==1){
					 todatecalc="SELECT LAST_DAY(DATE_ADD('"+invtodate+"',INTERVAL '"+monthcalvalue+"' DAY))";
				 }
				 if(invtype==2){
					 todatecalc="DATE_ADD('"+invtodate+"',INTERVAL '"+monthcalvalue+"' DAY)";
				 }
				 System.out.println("todatecalc casc:"+todatecalc);
			 }
			}
			else if(mode.equalsIgnoreCase("Close")){
				todatecalc="select '"+sqlclosedate+"'";
			}
			String strupdate="update gl_drvagmt set invdate='"+invtodate+"',invtodate=("+todatecalc+") where doc_no="+docno;
			 System.out.println("strupdate casc:"+strupdate);
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval>=0){
				conn.commit();
				return 1;
			}
			else{
				return 0;
			}
		}}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}

	public int close(String docno,java.sql.Date sqlclosedate) throws SQLException
	{
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String strupdate="update gl_drvagmt set clstatus=1,closedate='"+sqlclosedate+"' where doc_no="+docno;
			int updateval=stmt.executeUpdate(strupdate);
			if(updateval>0){
				conn.commit();
				return 1;
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

	public String getClientAcno(String hidclient) throws SQLException {
		// TODO Auto-generated method stub
		int clientacno=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String stracno="select head.doc_no acno from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.cldocno="+hidclient+" and ac.dtype='CRM'";
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				clientacno=rsacno.getInt("acno");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientacno+"";
	}
	public Date getInvToDate(String docno) throws SQLException {
		// TODO Auto-generated method stub
		java.sql.Date invtodate=null;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select invtodate from gl_drvagmt where doc_no="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				invtodate=rs.getDate("invtodate");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invtodate;
	}

}
