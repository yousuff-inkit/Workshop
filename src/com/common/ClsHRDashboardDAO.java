package com.common;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;

import com.connection.ClsConnection;

public class ClsHRDashboardDAO {
	
	ClsConnection objconn=new ClsConnection();

	public JSONArray getInitDesigData(HttpServletRequest request,HttpSession session) throws SQLException{
		Connection conn=null;
		JSONArray desigarray=new JSONArray();
		int errorstatus=0;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlbasedate=null;
			String accessdate="";
			String accessdb="";
			String strgetmiscdata="select (select CURDATE()) basedate,(select date_format(CURDATE(),'%d-%m-%Y')) accessdate,(select accessdbpath from my_comp where doc_no=1) accessdb,(select coalesce(accessdblastupdated,concat(year(curdate()),'-01-01')) from my_comp where doc_no=1) lastupdated";
			ResultSet rsgetmiscdata=stmt.executeQuery(strgetmiscdata);
			java.sql.Date lastupdated=null;
			while(rsgetmiscdata.next()){
				sqlbasedate=rsgetmiscdata.getDate("basedate");
				accessdate=rsgetmiscdata.getString("accessdate");
				accessdb=rsgetmiscdata.getString("accessdb");
				lastupdated=rsgetmiscdata.getDate("lastupdated");
//				System.out.println(sqlbasedate+"::"+accessdate+"::"+accessdb);
			}
			
			
			Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
			Connection c=DriverManager.getConnection("jdbc:ucanaccess://"+accessdb+";openExclusive=true;ignoreCase=true");
			Statement st=c.createStatement();
			/*ResultSet rs=st.executeQuery("select userid,if(checktype='I',date_format(checktime,'%Y-%m-%d'),null) checkindate,if(checktype='O',date_format(checktime,'%Y-%m-%d'),null) checkoutdate,if(checktype='I',date_format(checktime,'%H:%i'),null) checkintime,if(checktype='O',date_format(checktime,'%H:%i'),null) checkouttime,sensorid  from checkinout where date(checktime)='"+sqlbasedate+"'");*/
			ResultSet rs=st.executeQuery("select emp.badgenumber as empid,chk.checktime,chk.checktype,chk.sensorid from checkinout chk "
					+ "inner join userinfo emp on chk.userid=emp.userid where to_date(cast(checktime as VARCHAR(254)), 'YYYY-MM-DD') >= to_date('"+lastupdated+"', 'YYYY-MM-DD')");
			//System.out.println("select userid,checktime,checktype,sensorid  from checkinout where ="+accessdate+"");
//			System.out.println("select emp.badgenumber as empid,chk.checktime,chk.checktype,chk.sensorid from checkinout chk inner join userinfo emp on chk.userid=emp.userid where to_date(cast(checktime as VARCHAR(254)), 'YYYY-MM-DD') >= to_date('"+lastupdated+"', 'YYYY-MM-DD')");
			ArrayList<String> puncharray=new ArrayList<>();
			String checkindate="",checkintime="",checkoutdate="",checkouttime="";
			while(rs.next()){  
				
				if(rs.getString("checktype").equalsIgnoreCase("I")){
					checkindate=rs.getString("checktime").split(" ")[0];
					checkintime=rs.getString("checktime").split(" ")[1];
					checkintime=checkintime.substring(0, 5);
				}
				else if(rs.getString("checktype").equalsIgnoreCase("O")){
					checkoutdate=rs.getString("checktime").split(" ")[0];
					checkouttime=rs.getString("checktime").split(" ")[1];
					checkouttime=checkouttime.substring(0, 5);
				}
//				System.out.println("Check In Time:"+checkintime);
//				System.out.println(rs.getString("empid")+"::"+checkindate+"::"+checkintime+"::"+checkoutdate+"::"+checkouttime+"::"+rs.getString("sensorid"));
				puncharray.add(rs.getString("empid")+"::"+checkindate+"::"+checkintime+"::"+checkoutdate+"::"+checkouttime+"::"+rs.getString("sensorid"));
			}
            c.close();
            
            String strdeletepunch="delete from hr_punchatt where checkindate='"+sqlbasedate+"'";
            int deletepunch=stmt.executeUpdate(strdeletepunch);
            if(deletepunch<0){
            	errorstatus=1;
            }
            for(int i=0;i<puncharray.size();i++){
            	String punchdata[]=puncharray.get(i).split("::");
            	String strinsertpunch="";
            	if(!punchdata[1].equalsIgnoreCase("")){
            		strinsertpunch="insert into hr_punchatt(empid,checkindate,checkintime,date,status,machineid)values("+punchdata[0]+",'"+punchdata[1]+"','"+punchdata[2]+"','"+sqlbasedate+"',3,"+punchdata[5]+")";
            	}
				//System.out.println(strinsertpunch);
				int insertpunch=stmt.executeUpdate(strinsertpunch);
				if(insertpunch<=0){
					errorstatus=1;
				}
            }
            
			JSONObject desigdata=new JSONObject();
			
			int desigdocno=0,presenttoday=0,absenttoday=0,leavetoday=0,totalempcount=0;
			String designame="";
			//Data Fetching from Timesheet
			/*String strdeptdata="select dept.doc_no,dept.desc1,sum(aa.presenttoday) presenttoday,0 absenttoday,sum(aa.leavetoday) leavetoday from ("+
			" select emp.dept_id,emp.doc_no,emp.name,hrs.date,if(hrs.date='"+sqlbasedate+"',1,0) presenttoday,0 absenttoday,0 leavetoday,"+
			" if(month(hrs.date)=month('"+sqlbasedate+"'),1,0) presentmonth,0 absentmonth,0 leavemonth,"+
			" if(year(hrs.date)=year('"+sqlbasedate+"'),1,0) presentyear,0 absentyear,0 leaveyear from hr_empm emp left join hr_timesheethrs hrs on emp.doc_no=hrs.empid"+
			" where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"') group by emp.doc_no,hrs.date"+
			" union all"+
			" select emp.dept_id,emp.doc_no,emp.name,hrs.date,0 presenttoday,0 absenttoday,if('"+sqlbasedate+"' between hrs.fromdate and hrs.todate,1,0) leavetoday,"+
			" 0 presentmonth,0 absentmonth,if(month('"+sqlbasedate+"') between month(hrs.fromdate) and month(hrs.todate),"+
			" datediff(hrs.todate,hrs.fromdate),0) leavemonth,0 presentyear,0 absentyear,if(year('"+sqlbasedate+"') between year(hrs.fromdate) and"+
			" year(hrs.todate),datediff(hrs.todate,hrs.fromdate),0) leaveyear from hr_empm emp left join hr_leaverequest hrs on"+
			" emp.doc_no=hrs.empid where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"')) aa left join hr_setdept dept on (aa.dept_id=dept.doc_no and dept.status=3)group by aa.dept_id";
			*/
			String strdeptdata="select desig.doc_no,desig.remarks desc1,sum(aa.presenttoday) presenttoday,0 absenttoday,sum(aa.leavetoday) leavetoday from ("+
			" select emp.desc_id,emp.doc_no,emp.name,hrs.date,if(hrs.date='"+sqlbasedate+"',1,0) presenttoday,0 absenttoday,0 leavetoday,"+
			" if(month(hrs.date)=month('"+sqlbasedate+"'),1,0) presentmonth,0 absentmonth,0 leavemonth,"+
			" if(year(hrs.date)=year('"+sqlbasedate+"'),1,0) presentyear,0 absentyear,0 leaveyear from hr_empm emp left join"+
			" hr_punchatt hrs on emp.codeno=hrs.empid"+
			" where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"') group by emp.doc_no,hrs.date"+
			" union all"+
			" select emp.desc_id,emp.doc_no,emp.name,hrs.date,0 presenttoday,0 absenttoday,if('"+sqlbasedate+"' between hrs.fromdate and hrs.todate,1,0) leavetoday,"+
			" 0 presentmonth,0 absentmonth,if(month('"+sqlbasedate+"') between month(hrs.fromdate) and month(hrs.todate),"+
			" datediff(hrs.todate,hrs.fromdate),0) leavemonth,0 presentyear,0 absentyear,if(year('"+sqlbasedate+"') between year(hrs.fromdate) and"+
			" year(hrs.todate),datediff(hrs.todate,hrs.fromdate),0) leaveyear from hr_empm emp left join hr_leaverequest hrs on"+
			" emp.doc_no=hrs.empid where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"')) aa left join hr_setdesig desig on (aa.desc_id=desig.doc_no and desig.status=3) group by aa.desc_id";
//			System.out.println(strdeptdata);
			ResultSet rsdeptdata=stmt.executeQuery(strdeptdata);
			
			while(rsdeptdata.next()){
				JSONObject objdesig=new JSONObject();
				desigdocno=rsdeptdata.getInt("doc_no");
				designame=rsdeptdata.getString("desc1");
				totalempcount=getDesigEmpCount(desigdocno,conn);
				presenttoday=rsdeptdata.getInt("presenttoday");
				//absenttoday=rsdeptdata.getInt("absenttoday");
				leavetoday=rsdeptdata.getInt("leavetoday");
				absenttoday=totalempcount-(presenttoday+leavetoday);
				
				objdesig.put("desigdocno", desigdocno);
				objdesig.put("designame", designame);
				objdesig.put("totalempcount", totalempcount);
				objdesig.put("presenttoday", presenttoday);
				objdesig.put("absenttoday", absenttoday);
				objdesig.put("leavetoday", leavetoday);
				JSONArray desigemparray=getDesigEmpData(desigdocno,conn,sqlbasedate);
				int desigpresentmonth=0,desigabsentmonth=0,desigpleavemonth=0;
				int desigpresentyear=0,desigabsentyear=0,desigpleaveyear=0;
				for(int i=0;i<desigemparray.size();i++){
					JSONObject objemp=desigemparray.getJSONObject(i);
					desigpresentmonth+=objemp.getInt("presentmonth");
					desigabsentmonth+=objemp.getInt("absentmonth");
					desigpleavemonth+=objemp.getInt("leavemonth");
					
					desigpresentyear+=objemp.getInt("presentyear");
					desigabsentyear+=objemp.getInt("absentyear");
					desigpleaveyear+=objemp.getInt("leaveyear");
				}
				objdesig.put("presentmonth", desigpresentmonth);
				objdesig.put("absentmonth", desigabsentmonth);
				objdesig.put("leavemonth", desigpleavemonth);
				
				objdesig.put("presentyear", desigpresentyear);
				objdesig.put("absentyear", desigabsentyear);
				objdesig.put("leaveyear", desigpleaveyear);
				
				objdesig.put("deptemp",desigemparray);
				desigarray.add(objdesig);
			}
			
			String strupdate="update my_comp set accessdblastupdated=CURDATE() where doc_no=1";
			int update=stmt.executeUpdate(strupdate);
			
//			System.out.println(desigarray);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return desigarray;
	}
	
	private int getDesigEmpCount(int desigdocno, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int totalemp=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select count(*) totalemp from hr_empm emp left join hr_setdesig desig on (emp.desc_id=desig.doc_no and desig.status=3) where emp.status=3 and desig.doc_no="+desigdocno+" group by desig.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				totalemp=rs.getInt("totalemp");
			}
		}
		catch(Exception e){
			conn.close();
		}
		return totalemp;
		
	}

	private JSONArray getDesigEmpData(int desigdocno, Connection conn,
			Date sqlbasedate) throws SQLException {
		// TODO Auto-generated method stub
		JSONArray desigemparray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select aa.empdocno,aa.codeno,aa.name,aa.intime,aa.attstatus,sum(aa.absentmonth) absentmonth,sum(aa.absentyear) absentyear from ("+
			" select emp.doc_no empdocno,emp.codeno,emp.name,coalesce(hrs.checkintime,'') intime,if(hrs.checkintime is not null and hrs.checkindate='"+sqlbasedate+"','Present','Absent')"+
			" attstatus,0 absentmonth,0 absentyear from hr_empm emp left join hr_punchatt hrs on (emp.codeno=hrs.empid and hrs.checkindate='"+sqlbasedate+"')"+
			" where emp.status=3 and emp.desc_id="+desigdocno+
			" union all"+
			" select emp.doc_no empdocno,emp.codeno,emp.name,coalesce(hrs.checkintime,'') intime,if(hrs.checkintime is not null and hrs.checkindate='"+sqlbasedate+"','Present','Absent')"+
			" attstatus,1 absentmonth,0 absentyear from hr_empm emp left join hr_punchatt hrs on (emp.codeno=hrs.empid and month(hrs.checkindate)=month('"+sqlbasedate+"')) where"+
			" emp.status=3 and emp.desc_id="+desigdocno+" and hrs.doc_no is null"+
			" union all"+
			" select emp.doc_no empdocno,emp.codeno,emp.name,coalesce(hrs.checkintime,'') intime,if(hrs.checkintime is not null and hrs.checkindate='"+sqlbasedate+"','Present','Absent')"+
			" attstatus,0 absentmonth,1 absentyear from hr_empm emp left join hr_punchatt hrs on (emp.codeno=hrs.empid and year(hrs.checkindate)=year('"+sqlbasedate+"')) where"+
			" emp.status=3 and emp.desc_id="+desigdocno+" and hrs.doc_no is null) aa group by aa.empdocno";
			//System.out.println("Employee Data:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			int srno=0,empdocno=0,presentmonth=0,absentmonth=0,leavemonth=0,presentyear=0,absentyear=0,leaveyear=0;
			String empname="",codeno="",intime="",status="";
			while(rs.next()){
				srno++;
				JSONObject objdeptemp=new JSONObject();
				empdocno=rs.getInt("empdocno");
				codeno=rs.getString("codeno");
				empname=rs.getString("name");
				intime=rs.getString("intime");
				status=rs.getString("attstatus");
				absentmonth=rs.getInt("absentmonth");
				presentmonth=getEmpPresent("Month", empdocno, sqlbasedate, conn);
				presentyear=getEmpPresent("Year", empdocno, sqlbasedate, conn);
				leavemonth=getEmpLeave("Month",empdocno,sqlbasedate,conn);
				leaveyear=getEmpLeave("Year",empdocno,sqlbasedate,conn);
				absentyear=rs.getInt("absentyear");
				objdeptemp.put("srno", srno);
				objdeptemp.put("empdocno", empdocno);
				objdeptemp.put("codeno", codeno);
				objdeptemp.put("empname", empname);
				objdeptemp.put("intime", intime);
				objdeptemp.put("status", status);
				objdeptemp.put("absentmonth", absentmonth);
				objdeptemp.put("absentyear", absentyear);
				objdeptemp.put("presentmonth", presentmonth);
				objdeptemp.put("presentyear", presentyear);
				objdeptemp.put("leavemonth", leavemonth);
				objdeptemp.put("leaveyear", leaveyear);
				desigemparray.add(objdeptemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return desigemparray;
	}

	public JSONArray getInitDeptData(HttpServletRequest request,HttpSession session) throws SQLException{
		Connection conn=null;
		JSONArray deptarray=new JSONArray();
		int errorstatus=0;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlbasedate=null;
			String accessdate="";
			String accessdb="";
			String strgetmiscdata="select (select CURDATE()) basedate,(select date_format(CURDATE(),'%d-%m-%Y')) accessdate,(select accessdbpath from my_comp where doc_no=1) accessdb,(select coalesce(accessdblastupdated,concat(year(curdate()),'-01-01')) from my_comp where doc_no=1) lastupdated";
			ResultSet rsgetmiscdata=stmt.executeQuery(strgetmiscdata);
			java.sql.Date lastupdated=null;
			while(rsgetmiscdata.next()){
				sqlbasedate=rsgetmiscdata.getDate("basedate");
				accessdate=rsgetmiscdata.getString("accessdate");
				accessdb=rsgetmiscdata.getString("accessdb");
				lastupdated=rsgetmiscdata.getDate("lastupdated");
				//System.out.println(sqlbasedate+"::"+accessdate+"::"+accessdb);
			}
			
			
			Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
			Connection c=DriverManager.getConnection("jdbc:ucanaccess://"+accessdb+";openExclusive=true;ignoreCase=true");
			Statement st=c.createStatement();
			/*ResultSet rs=st.executeQuery("select userid,if(checktype='I',date_format(checktime,'%Y-%m-%d'),null) checkindate,if(checktype='O',date_format(checktime,'%Y-%m-%d'),null) checkoutdate,if(checktype='I',date_format(checktime,'%H:%i'),null) checkintime,if(checktype='O',date_format(checktime,'%H:%i'),null) checkouttime,sensorid  from checkinout where date(checktime)='"+sqlbasedate+"'");*/
//old 			ResultSet rs=st.executeQuery("select emp.badgenumber as empid,chk.checktime,chk.checktype,chk.sensorid from checkinout chk inner join userinfo emp on chk.userid=emp.badgenumber  where to_date(cast(checktime as VARCHAR(254)), 'YYYY-MM-DD') >= to_date('"+lastupdated+"', 'YYYY-MM-DD')");
			ResultSet rs=st.executeQuery("select emp.badgenumber as empid,chk.checktime,chk.checktype,chk.sensorid from checkinout chk inner join userinfo emp on chk.userid=emp.userid  where to_date(cast(checktime as VARCHAR(254)), 'YYYY-MM-DD') >= to_date('"+lastupdated+"', 'YYYY-MM-DD')");
//			System.out.println("select userid,checktime,checktype,sensorid  from checkinout where ="+accessdate+"");
			ArrayList<String> puncharray=new ArrayList<>();
			String checkindate="",checkintime="",checkoutdate="",checkouttime="";
			while(rs.next()){  
//				System.out.println("inside result set");
				if(rs.getString("checktype").equalsIgnoreCase("I")){
					checkindate=rs.getString("checktime").split(" ")[0];
					checkintime=rs.getString("checktime").split(" ")[1];
					checkintime=checkintime.substring(0, 5);
				}
				else if(rs.getString("checktype").equalsIgnoreCase("O")){
					checkoutdate=rs.getString("checktime").split(" ")[0];
					checkouttime=rs.getString("checktime").split(" ")[1];
					checkouttime=checkouttime.substring(0, 5);
				}
				//System.out.println("Check In Time:"+checkintime);
				//System.out.println(rs.getString("empid")+"::"+checkindate+"::"+checkintime+"::"+checkoutdate+"::"+checkouttime+"::"+rs.getString("sensorid"));
				puncharray.add(rs.getString("empid")+"::"+checkindate+"::"+checkintime+"::"+checkoutdate+"::"+checkouttime+"::"+rs.getString("sensorid"));
			}
            c.close();
            
            String strdeletepunch="delete from hr_punchatt where checkindate='"+sqlbasedate+"'";
            int deletepunch=stmt.executeUpdate(strdeletepunch);
            if(deletepunch<0){
            	errorstatus=1;
            }
            for(int i=0;i<puncharray.size();i++){
            	String punchdata[]=puncharray.get(i).split("::");
            	String strinsertpunch="";
            	if(!punchdata[1].equalsIgnoreCase("")){
            		strinsertpunch="insert into hr_punchatt(empid,checkindate,checkintime,date,status,machineid)values("+punchdata[0]+",'"+punchdata[1]+"','"+punchdata[2]+"','"+sqlbasedate+"',3,"+punchdata[5]+")";
            	}
				//System.out.println(strinsertpunch);
				int insertpunch=stmt.executeUpdate(strinsertpunch);
				if(insertpunch<=0){
					errorstatus=1;
				}
            }
            
			JSONObject deptdata=new JSONObject();
			
			int deptdocno=0,presenttoday=0,absenttoday=0,leavetoday=0,totalempcount=0;
			String deptname="";
			//Data Fetching from Timesheet
			/*String strdeptdata="select dept.doc_no,dept.desc1,sum(aa.presenttoday) presenttoday,0 absenttoday,sum(aa.leavetoday) leavetoday from ("+
			" select emp.dept_id,emp.doc_no,emp.name,hrs.date,if(hrs.date='"+sqlbasedate+"',1,0) presenttoday,0 absenttoday,0 leavetoday,"+
			" if(month(hrs.date)=month('"+sqlbasedate+"'),1,0) presentmonth,0 absentmonth,0 leavemonth,"+
			" if(year(hrs.date)=year('"+sqlbasedate+"'),1,0) presentyear,0 absentyear,0 leaveyear from hr_empm emp left join hr_timesheethrs hrs on emp.doc_no=hrs.empid"+
			" where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"') group by emp.doc_no,hrs.date"+
			" union all"+
			" select emp.dept_id,emp.doc_no,emp.name,hrs.date,0 presenttoday,0 absenttoday,if('"+sqlbasedate+"' between hrs.fromdate and hrs.todate,1,0) leavetoday,"+
			" 0 presentmonth,0 absentmonth,if(month('"+sqlbasedate+"') between month(hrs.fromdate) and month(hrs.todate),"+
			" datediff(hrs.todate,hrs.fromdate),0) leavemonth,0 presentyear,0 absentyear,if(year('"+sqlbasedate+"') between year(hrs.fromdate) and"+
			" year(hrs.todate),datediff(hrs.todate,hrs.fromdate),0) leaveyear from hr_empm emp left join hr_leaverequest hrs on"+
			" emp.doc_no=hrs.empid where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"')) aa left join hr_setdept dept on (aa.dept_id=dept.doc_no and dept.status=3)group by aa.dept_id";
			*/
			String strdeptdata="select dept.doc_no,dept.desc1,sum(aa.presenttoday) presenttoday,0 absenttoday,sum(aa.leavetoday) leavetoday from ("+
			" select emp.dept_id,emp.doc_no,emp.name,hrs.date,if(hrs.date='"+sqlbasedate+"',1,0) presenttoday,0 absenttoday,0 leavetoday,"+
			" if(month(hrs.date)=month('"+sqlbasedate+"'),1,0) presentmonth,0 absentmonth,0 leavemonth,"+
			" if(year(hrs.date)=year('"+sqlbasedate+"'),1,0) presentyear,0 absentyear,0 leaveyear from hr_empm emp left join"+
			" hr_punchatt hrs on emp.codeno=hrs.empid"+
			" where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"') group by emp.doc_no,hrs.date"+
			" union all"+
			" select emp.dept_id,emp.doc_no,emp.name,hrs.date,0 presenttoday,0 absenttoday,if('"+sqlbasedate+"' between hrs.fromdate and hrs.todate,1,0) leavetoday,"+
			" 0 presentmonth,0 absentmonth,if(month('"+sqlbasedate+"') between month(hrs.fromdate) and month(hrs.todate),"+
			" datediff(hrs.todate,hrs.fromdate),0) leavemonth,0 presentyear,0 absentyear,if(year('"+sqlbasedate+"') between year(hrs.fromdate) and"+
			" year(hrs.todate),datediff(hrs.todate,hrs.fromdate),0) leaveyear from hr_empm emp left join hr_leaverequest hrs on"+
			" emp.doc_no=hrs.empid where emp.status=3 and year(hrs.date)=year('"+sqlbasedate+"')) aa left join hr_setdept dept on (aa.dept_id=dept.doc_no and dept.status=3)group by aa.dept_id";
			//System.out.println(strdeptdata);
			ResultSet rsdeptdata=stmt.executeQuery(strdeptdata);
			
			while(rsdeptdata.next()){
				JSONObject objdept=new JSONObject();
				deptdocno=rsdeptdata.getInt("doc_no");
				deptname=rsdeptdata.getString("desc1");
				totalempcount=getDeptEmpCount(deptdocno,conn);
				presenttoday=rsdeptdata.getInt("presenttoday");
				//absenttoday=rsdeptdata.getInt("absenttoday");
				leavetoday=rsdeptdata.getInt("leavetoday");
				absenttoday=totalempcount-(presenttoday+leavetoday);
				
				objdept.put("deptdocno", deptdocno);
				objdept.put("deptname", deptname);
				objdept.put("totalempcount", totalempcount);
				objdept.put("presenttoday", presenttoday);
				objdept.put("absenttoday", absenttoday);
				objdept.put("leavetoday", leavetoday);
				JSONArray deptemparray=getDeptEmpData(deptdocno,conn,sqlbasedate);
				int deptpresentmonth=0,deptabsentmonth=0,deptpleavemonth=0;
				int deptpresentyear=0,deptabsentyear=0,deptpleaveyear=0;
				for(int i=0;i<deptemparray.size();i++){
					JSONObject objemp=deptemparray.getJSONObject(i);
					deptpresentmonth+=objemp.getInt("presentmonth");
					deptabsentmonth+=objemp.getInt("absentmonth");
					deptpleavemonth+=objemp.getInt("leavemonth");
					
					deptpresentyear+=objemp.getInt("presentyear");
					deptabsentyear+=objemp.getInt("absentyear");
					deptpleaveyear+=objemp.getInt("leaveyear");
				}
				objdept.put("presentmonth", deptpresentmonth);
				objdept.put("absentmonth", deptabsentmonth);
				objdept.put("leavemonth", deptpleavemonth);
				
				objdept.put("presentyear", deptpresentyear);
				objdept.put("absentyear", deptabsentyear);
				objdept.put("leaveyear", deptpleaveyear);
				
				
				objdept.put("deptemp",deptemparray);
				deptarray.add(objdept);
			}
			
			String strupdate="update my_comp set accessdblastupdated=CURDATE() where doc_no=1";
			int update=stmt.executeUpdate(strupdate);
			
//			System.out.println(deptarray);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return deptarray;
	}
	private JSONArray getDeptEmpData(int deptdocno, Connection conn,java.sql.Date sqlbasedate) throws SQLException {
		// TODO Auto-generated method stub
		JSONArray deptemparray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select aa.empdocno,aa.codeno,aa.name,aa.intime,aa.attstatus,sum(aa.absentmonth) absentmonth,sum(aa.absentyear) absentyear from ("+
			" select emp.doc_no empdocno,emp.codeno,emp.name,coalesce(hrs.checkintime,'') intime,if(hrs.checkintime is not null and hrs.checkindate='"+sqlbasedate+"','Present','Absent')"+
			" attstatus,0 absentmonth,0 absentyear from hr_empm emp left join hr_punchatt hrs on (emp.codeno=hrs.empid and hrs.checkindate='"+sqlbasedate+"')"+
			" where emp.status=3 and emp.dept_id="+deptdocno+
			" union all"+
			" select emp.doc_no empdocno,emp.codeno,emp.name,coalesce(hrs.checkintime,'') intime,if(hrs.checkintime is not null and hrs.checkindate='"+sqlbasedate+"','Present','Absent')"+
			" attstatus,1 absentmonth,0 absentyear from hr_empm emp left join hr_punchatt hrs on (emp.codeno=hrs.empid and month(hrs.checkindate)=month('"+sqlbasedate+"')) where"+
			" emp.status=3 and emp.dept_id="+deptdocno+" and hrs.doc_no is null"+
			" union all"+
			" select emp.doc_no empdocno,emp.codeno,emp.name,coalesce(hrs.checkintime,'') intime,if(hrs.checkintime is not null and hrs.checkindate='"+sqlbasedate+"','Present','Absent')"+
			" attstatus,0 absentmonth,1 absentyear from hr_empm emp left join hr_punchatt hrs on (emp.codeno=hrs.empid and year(hrs.checkindate)=year('"+sqlbasedate+"')) where"+
			" emp.status=3 and emp.dept_id="+deptdocno+" and hrs.doc_no is null) aa group by aa.empdocno";
			//System.out.println("Employee Data:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			int srno=0,empdocno=0,presentmonth=0,absentmonth=0,leavemonth=0,presentyear=0,absentyear=0,leaveyear=0;
			String empname="",codeno="",intime="",status="";
			while(rs.next()){
				srno++;
				JSONObject objdeptemp=new JSONObject();
				empdocno=rs.getInt("empdocno");
				codeno=rs.getString("codeno");
				empname=rs.getString("name");
				intime=rs.getString("intime");
				status=rs.getString("attstatus");
				absentmonth=rs.getInt("absentmonth");
				presentmonth=getEmpPresent("Month", empdocno, sqlbasedate, conn);
				presentyear=getEmpPresent("Year", empdocno, sqlbasedate, conn);
				leavemonth=getEmpLeave("Month",empdocno,sqlbasedate,conn);
				leaveyear=getEmpLeave("Year",empdocno,sqlbasedate,conn);
				absentyear=rs.getInt("absentyear");
				objdeptemp.put("srno", srno);
				objdeptemp.put("empdocno", empdocno);
				objdeptemp.put("codeno", codeno);
				objdeptemp.put("empname", empname);
				objdeptemp.put("intime", intime);
				objdeptemp.put("status", status);
				objdeptemp.put("absentmonth", absentmonth);
				objdeptemp.put("absentyear", absentyear);
				objdeptemp.put("presentmonth", presentmonth);
				objdeptemp.put("presentyear", presentyear);
				objdeptemp.put("leavemonth", leavemonth);
				objdeptemp.put("leaveyear", leaveyear);
				deptemparray.add(objdeptemp);
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return deptemparray;
	}
	private int getEmpLeave(String type, int empdocno, Date sqlbasedate,
			Connection conn) {
		// TODO Auto-generated method stub
		int leavedays=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="";
			if(type.equalsIgnoreCase("Month")){
				strsql="select datediff(a.todate,a.fromdate)+1 diffdays,a.fromdate,a.todate from ("+
				" select if(todate>'"+sqlbasedate+"','"+sqlbasedate+"',todate) todate,if(fromdate<(date_add(date_add(LAST_DAY('"+sqlbasedate+"'),interval 1 DAY),interval -1 MONTH)),(date_add(date_add(LAST_DAY('"+sqlbasedate+"'),interval 1 DAY),interval -1 MONTH)),fromdate) fromdate from hr_leaverequest where empid="+empdocno+" and month('"+sqlbasedate+"') between month(fromdate) and month(todate) and year('"+sqlbasedate+"') between year(fromdate) and year(todate) and confirm=1) a";
			}
			else if(type.equalsIgnoreCase("Year")){
				strsql="select datediff(a.todate,a.fromdate)+1 diffdays,a.fromdate,a.todate from ("+
				" select if(todate>'"+sqlbasedate+"','"+sqlbasedate+"',todate) todate,if(fromdate<concat(year('"+sqlbasedate+"'),'-01-01'),concat(year('"+sqlbasedate+"'),'-01-01'),fromdate) fromdate from hr_leaverequest where empid="+empdocno+" and year('"+sqlbasedate+"') between year(fromdate) and year(todate) and confirm=1) a";
			}
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				leavedays+=rs.getInt("diffdays");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return leavedays;
	}
	private int getEmpPresent(String type, int empdocno, Date sqlbasedate,
			Connection conn) {
		// TODO Auto-generated method stub
		int presentdays=0;
		try{
			Statement  stmt=conn.createStatement();
			String strsql="";
			if(type.equalsIgnoreCase("Month")){
				strsql="select * from hr_punchatt where empid="+empdocno+" and month(checkindate)=month('"+sqlbasedate+"') and year(checkindate)=year('"+sqlbasedate+"') group by empid,checkindate";
			}
			else if(type.equalsIgnoreCase("Year")){
				strsql="select * from hr_punchatt where empid="+empdocno+" and year(checkindate)=year('"+sqlbasedate+"') group by empid,checkindate";
			}
			
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				if(rs.getDate("checkindate")!=null){
					presentdays++;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return presentdays;
	}
	private int getHolidays(String type, int empdocno, Date sqlbasedate,
			Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int absent=0;
		try{
			Statement stmt=conn.createStatement();
			ArrayList<String> weeklyoffarray=new ArrayList<>();
			String sql2="",weekoff="",checkweekoff="0";
			String[] weekoffs=null;
			String sql1 = "select woff from hr_paycode where status=3 and catid=(select pay_catid from hr_empm where status=3 and active=1 and doc_no="+empdocno+")";
			ResultSet resultSet1 = stmt.executeQuery(sql1);

			while(resultSet1.next()){
				weekoff=resultSet1.getString("woff");
			}

			if(weekoff.trim().contains(",")){
				checkweekoff="1";
				weekoffs = weekoff.split(",");
			}
			int year=0,month=0;
			String strgetdate="select date_format('"+sqlbasedate+"','%Y') year,date_format('"+sqlbasedate+"','%m') month";
			ResultSet rsgetdate=stmt.executeQuery(strgetdate);
			while(rsgetdate.next()){
				year=rsgetdate.getInt("year");
				month=rsgetdate.getInt("month");
			}
			if(checkweekoff.equalsIgnoreCase("0")){
				
				sql2="select row+1 as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
				+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
				+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
				+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoff+"+1)>7,1,("+weekoff+"+1)))";
//				System.out.println(sql2);
				ResultSet resultSet3 = stmt.executeQuery(sql2);

				while(resultSet3.next()){
					weeklyoffarray.add(resultSet3.getString("holidaysofmonth"));
//					System.out.println("Check Holiday:"+resultSet3.getString("holidaysofmonth"));
				}

			}
			else if(checkweekoff.equalsIgnoreCase("1")){

				for(int k=0;k<(weekoff.length()-1);k++){

					sql2="select row+1 as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
					+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
					+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY) between "
					+ "'"+year+"-"+month+"-01' and '"+year+"-"+month+"-31' and DAYOFWEEK(DATE_ADD('"+year+"-"+month+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";
//					System.out.println(sql2);
					ResultSet resultSet3 = stmt.executeQuery(sql2);

					while(resultSet3.next()){
						weeklyoffarray.add(resultSet3.getString("holidaysofmonth"));
//						System.out.println("Check Holiday:"+resultSet3.getString("holidaysofmonth"));
					}
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}
	private int getDeptEmpCount(int deptdocno,Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int totalemp=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select count(*) totalemp from hr_empm emp left join hr_setdept dept on (emp.dept_id=dept.doc_no and dept.status=3) where emp.status=3 and dept.doc_no="+deptdocno+" group by dept.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				totalemp=rs.getInt("totalemp");
			}
		}
		catch(Exception e){
			conn.close();
		}
		return totalemp;
	}
}
