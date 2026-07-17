package com.dashboard.humanresource.timesheet;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTimeSheetDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public int insert(String cmbbranch, String cmbyear, String cmbmonth, ArrayList<String> timesheetarray, HttpSession session, HttpServletRequest request, 
			String mode) throws SQLException {
		
		Connection conn  = null;
		  
		try{
			
			 conn=ClsConnection.getMyConnection();
			 conn.setAutoCommit(false);
			 Statement stmtBHTS = conn.createStatement();
			
			 String branch=session.getAttribute("BRANCHID").toString().trim();
			 String userid=session.getAttribute("USERID").toString().trim();
	        
			 String selectedemployees="";int docno=0;
        	
			 String sql1="select coalesce(max(doc_no)+1,1) doc_no from hr_bhts";
		     ResultSet resultSet = stmtBHTS.executeQuery(sql1);
		  
		     while (resultSet.next()) {
		    	  docno=resultSet.getInt("doc_no");
		     }
		     
			 /*Time Sheet Grid Saving*/
				for(int i=0;i< timesheetarray.size();i++){
				CallableStatement stmtBHTS1=null;
				String[] timesheet=timesheetarray.get(i).split("::");
				
				 if(!timesheet[0].equalsIgnoreCase("undefined") && !timesheet[0].equalsIgnoreCase("NaN")){
				 
					 java.sql.Date date=(timesheet[1].trim().equalsIgnoreCase("undefined") || timesheet[1].trim().equalsIgnoreCase("NaN") || timesheet[1].trim().equalsIgnoreCase("") ||  timesheet[1].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(timesheet[1].trim()));
					 
					 if(!(selectedemployees.contains((timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()))) {
						 if(i==0) {
							 selectedemployees = (timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 } else {
							 selectedemployees += ","+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 }
					 }
					 String normalTime = (timesheet[4].trim().equalsIgnoreCase("undefined") || timesheet[4].trim().equalsIgnoreCase("NaN") || timesheet[4].trim().equalsIgnoreCase("") ||timesheet[4].trim().isEmpty()?"0:00":timesheet[4].trim()).toString();
					 String otTime = (timesheet[5].trim().equalsIgnoreCase("undefined") || timesheet[5].trim().equalsIgnoreCase("NaN") || timesheet[5].trim().equalsIgnoreCase("") ||timesheet[5].trim().isEmpty()?"0:00":timesheet[5].trim()).toString();
					 String hotTime = (timesheet[6].trim().equalsIgnoreCase("undefined") || timesheet[6].trim().equalsIgnoreCase("NaN") || timesheet[6].trim().equalsIgnoreCase("") ||timesheet[6].trim().isEmpty()?"0:00":timesheet[6].trim()).toString();
					 
					 String[] normalHour=normalTime.split(":");
					 String[] otHour=otTime.split(":");
					 String[] hotHour=hotTime.split(":");
					 
					 int normalHourInHour = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]); 
					 int otInHour = (Integer.parseInt(otHour[0]) * 60)+ Integer.parseInt(otHour[1]);
					 int hotInHour = (Integer.parseInt(hotHour[0]) * 60)+ Integer.parseInt(hotHour[1]);
					 
					 stmtBHTS1 = conn.prepareCall("INSERT INTO hr_timesheethrs(date, empid, costtype, costcode, normalhrs, othrs, hothrs, normal, ot, hot, intime, outtime, status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						
					 stmtBHTS1.setDate(1,date);
					 stmtBHTS1.setString(2,(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString());
					 stmtBHTS1.setString(3,(timesheet[2].trim().equalsIgnoreCase("undefined") || timesheet[2].trim().equalsIgnoreCase("NaN") || timesheet[2].trim().equalsIgnoreCase("") ||timesheet[2].trim().isEmpty()?"0":timesheet[2].trim()).toString());
					 stmtBHTS1.setString(4,(timesheet[3].trim().equalsIgnoreCase("undefined") || timesheet[3].trim().equalsIgnoreCase("NaN") || timesheet[3].trim().equalsIgnoreCase("") ||timesheet[3].trim().isEmpty()?"0":timesheet[3].trim()).toString());
					 stmtBHTS1.setString(5,normalTime);
					 stmtBHTS1.setString(6,otTime);
					 stmtBHTS1.setString(7,hotTime);
					 stmtBHTS1.setInt(8,normalHourInHour);
					 stmtBHTS1.setInt(9,otInHour);
					 stmtBHTS1.setInt(10,hotInHour);
					 stmtBHTS1.setString(11, (timesheet[7].trim().equalsIgnoreCase("undefined") || timesheet[7].trim().equalsIgnoreCase("NaN") || timesheet[7].trim().equalsIgnoreCase("") ||timesheet[7].trim().isEmpty()?"0:00":timesheet[7].trim()).toString());
					 stmtBHTS1.setString(12, (timesheet[8].trim().equalsIgnoreCase("undefined") || timesheet[8].trim().equalsIgnoreCase("NaN") || timesheet[8].trim().equalsIgnoreCase("") ||timesheet[8].trim().isEmpty()?"0:00":timesheet[8].trim()).toString());
					 stmtBHTS1.setString(13,"3");
				     int data = stmtBHTS1.executeUpdate();
					 if(data<=0){
						stmtBHTS.close();
						conn.close();
						return 0;
					 }
				}
			}
				
			/*Inserting hr_bhts*/
		     String sql2="insert into hr_bhts(doc_no, date, employeeIds, brhid, userid) values('"+docno+"',now(),'"+selectedemployees+"','"+branch+"','"+userid+"')";
		     int data1= stmtBHTS.executeUpdate(sql2);
			 if(data1<=0){
				    stmtBHTS.close();
					conn.close();
					return 0;
				}
			 /*Inserting hr_bhts Ends*/
				 
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','BHTS',now(),'"+userid+"','A')";
			 int datas= stmtBHTS.executeUpdate(sqls);
			 if(datas<=0){
				 	stmtBHTS.close();
				    conn.close();
					return 0;
				}
			conn.commit();
			stmtBHTS.close();
			conn.close();
			return docno;
		
	 } catch(Exception e){	
		 	conn.close();
		 	e.printStackTrace();	
		 	return 0;
	 } finally{
		 conn.close();
	 }
	}
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBHTS = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(empid.equalsIgnoreCase(""))){
	                sql=sql+" and m.codeno like '%"+empid+"%'";
	            }
	            if(!(employeename.equalsIgnoreCase(""))){
	             sql=sql+" and m.name like '%"+employeename+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and m.pmmob like '%"+contact+"%'";
	            }
	            
				sql = "select m.doc_no,m.codeno,UPPER(m.name) name,m.pmmob from hr_empm m left join hr_paycode c on (m.pay_catid=c.catid and c.status=3) where m.active=1 and m.status=3 and c.timesheet=1"+sql;
				
				ResultSet resultSet1 = stmtBHTS.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtBHTS.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray timeSheetFillGridLoading(HttpSession session,String fromdate,String todate,String days,String selectedempdocnos,String selectedcosttypename,String selectedcosttypeid,String selectedcostid,String selectedcostiddocno,
			String fillintime,String fillouttime,String fillnormalhrs,String fillothrs,String fillhothrs,String gridload) throws SQLException {

		JSONArray jsonArray = new JSONArray();

		if(!(gridload.equalsIgnoreCase("1"))){
			return jsonArray;
		}
		
		Connection conn = null;
		
		try {
			  conn = ClsConnection.getMyConnection();
			    Statement stmtBHTS = conn.createStatement ();


				java.sql.Date stdate=ClsCommon.changeStringtoSqlDate(fromdate);
				java.sql.Date enddate=ClsCommon.changeStringtoSqlDate(todate);

				String sql1="",sql2="",sql3="";
				
				if(!(days.equalsIgnoreCase("0")) && !(days.equalsIgnoreCase(""))){
					if (days.trim().endsWith(",")) {
						days = days.trim().substring(0,days.length() - 1);
					}
					
					sql1+=" and weekday(date) in ("+days+")";
				}
				
				if(!(selectedempdocnos.equalsIgnoreCase("0")) && !(selectedempdocnos.equalsIgnoreCase(""))){
					sql2="select a.*,b.* from (";
					sql3=" ) a,(select codeno empid,name empname,doc_no empdocno from hr_empm where status=3 and active=1 and doc_no in ("+selectedempdocnos+")) b order by a.date,b.empdocno";
					
				}

				/*for(int i=0;i<2;i++){*/

					String clsql= (""+sql2+"select  date_format(date,'%Y-%m-%d') as date,DAYname(date_format(date,'%Y-%m-%d')) as days,'"+selectedcosttypename+"' as costgroup, "
							+ "'"+fillintime+"' as intime,'"+fillouttime+"' as outtime,'"+fillnormalhrs+"' as hrs,'"+fillothrs+"' as othrs,'"+fillhothrs+"' as hothrs,'"+selectedcosttypeid+"' as costtype,'"+selectedcostid+"' as costcodename,'"+selectedcostiddocno+"' as costcode from ( "
							+ "select  date_add('"+stdate+"', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date "
							+ "from  (select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 "
							+ "union all select 6 union all select 7 union all select 8 union all select 9) n1, "
							+ "(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 "
							+ "union all select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1 "
							+ " union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 "
							+ " union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3 "
							+ " union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4 "
							+ " ) a where date >='"+stdate+"' and date <='"+enddate+"'"+sql1+" order by date"+sql3+"");


					ResultSet resultSet = stmtBHTS.executeQuery(clsql);

					jsonArray=ClsCommon.convertToJSON(resultSet);

				/*}*/

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return jsonArray;
	}

}
