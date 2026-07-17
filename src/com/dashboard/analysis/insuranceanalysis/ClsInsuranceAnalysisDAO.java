package com.dashboard.analysis.insuranceanalysis;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.*;
import com.connection.*;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
public class ClsInsuranceAnalysisDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getDetailsData(String fromdate,String todate) throws SQLException
	{
		
		JSONArray insurdata=new JSONArray();
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqltodate=null;
			java.sql.Date sqlfromdate=null;
		
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
				strsql="select insur.postdate,insur.doc_no insurdocno,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
				" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
				" enddate,veh.fleet_no,veh.reg_no,veh.flname,DATEDIFF(convert(case when agmt.per_name=1 then  date_add(agmt.outdate,interval agmt.per_value year) "
				+ "when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)),agmt.outdate) nodays,coalesce(round(insur.amount,2),0) totinsur,"
				+ "convert(if(vehp.postdate < '"+sqlfromdate+"',round(sum(vehp.amount),2),''),CHAR(30)) openpost,"
				+ "convert(if(vehp.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' ,round(sum(vehp.amount),2),''),CHAR(30)) posted,"
				+ "round((insur.amount-if(vehp.postdate < '"+sqlfromdate+"',round(sum(vehp.amount),2),0)-if(vehp.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' ,round(sum(vehp.amount),2),0)),2) balance "
				+ " from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) left join gl_vehinsurposting vehp on vehp.agmtno=agmt.doc_no where insur.terminatestatus<>1  "
				+ "and (('"+sqlfromdate+"'"
				+ " between insur.insurfromdate and insur.insurtodate)  or ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)"
				+ "or (insur.insurfromdate between '"+sqlfromdate+"' and '"+sqltodate+"') "
				+ "or (insur.insurtodate between '"+sqlfromdate+"' and '"+sqltodate+"')) group by agmt.doc_no ";
			
				
				
			System.out.println("======insurance analysis=="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			insurdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return insurdata;
	}
	
	
	public JSONArray excelDetailsData(String fromdate,String todate) throws SQLException
	{
		
		JSONArray insurdata=new JSONArray();
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqltodate=null;
			java.sql.Date sqlfromdate=null;
		
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
				strsql="select @id:=@id+1 'Sr No.',a.* from (select agmt.voc_no 'Agmt No',br.branchname 'Branch',ac.refname 'Client',agmt.date 'Date',agmt.outdate 'Out Date',convert(case when agmt.per_name=1 then date_add(agmt.outdate,interval agmt.per_value year) "
						+ "when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) 'End Date',insur.postdate 'Post Date',veh.fleet_no 'Fleet No',veh.reg_no 'Reg No',veh.flname 'Fleet Name',"
						+ "DATEDIFF(convert(case when agmt.per_name=1 then  date_add(agmt.outdate,interval agmt.per_value year) "
				+ "when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)),agmt.outdate) 'No. of Days',coalesce(round(insur.amount,2),0) 'Total Insured',"
				+ "convert(if(vehp.postdate < '"+sqlfromdate+"',round(sum(vehp.amount),2),''),CHAR(30)) 'Opening Posted',"
				+ "convert(if(vehp.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' ,round(sum(vehp.amount),2),''),CHAR(30)) 'Posted',"
				+ "round((insur.amount-if(vehp.postdate < '"+sqlfromdate+"',round(sum(vehp.amount),2),0)-if(vehp.postdate between '"+sqlfromdate+"' and '"+sqltodate+"' ,round(sum(vehp.amount),2),0)),2) 'Balance' "
				+ " from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
				" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
				" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) left join gl_vehinsurposting vehp on vehp.agmtno=agmt.doc_no where insur.terminatestatus<>1  "
				+ "and (('"+sqlfromdate+"'"
				+ " between insur.insurfromdate and insur.insurtodate)  or ('"+sqltodate+"' between insur.insurfromdate and insur.insurtodate)"
				+ "or (insur.insurfromdate between '"+sqlfromdate+"' and '"+sqltodate+"') "
				+ "or (insur.insurtodate between '"+sqlfromdate+"' and '"+sqltodate+"')) group by agmt.doc_no) a,(select @id:=0) r; ";
			
				
				
			System.out.println("======insurance analysis Excel=="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			insurdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return insurdata;
	}
	
		
	
	public JSONArray analysisGrid(String fromdate,String todate,String check,String grouping) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = objconn.getMyConnection();
			 Statement stmtBalance = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			     java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     int amountLength=0,txtfrequency=0;
			     
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
		         }

			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = objcommon.changeStringtoSqlDate(todate);
		         }
			     
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     analysiscolumnarray.add("Sr No::id::center::center:: ::5%:: :: :: ");
			     analysiscolumnarray.add("Ref No::refno::center::center:: ::10%:: :: :: ");
			     analysiscolumnarray.add("Description::description::left::left:: ::25%:: ::headClass:: ");
			     		     
			     String xsql="",xsqls="";
			     String sql = "",sql1 = "",sql2="",sql3="";
			     String dayDiff="",monthDiff="";
			     if(grouping.equalsIgnoreCase("2")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtBalance.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
						
						xsqls=1 + (grouping.equalsIgnoreCase("2")?" Month ":" Year ");
						
			     }else if(grouping.equalsIgnoreCase("3")){
			    	 
			    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtBalance.executeQuery(sqls);
						
						while(rs1.next()) {
							monthDiff=rs1.getString("monthdiff");
						} 
						
						String sqls1 = "select ("+monthDiff+"/3) monthdifference";
						ResultSet rs2 = stmtBalance.executeQuery(sqls1);
						
						while(rs2.next()) {
							txtfrequency=rs2.getInt("monthdifference");
						} 
			    	    
						xsqls= "3 Month";
						
			     }else if(grouping.equalsIgnoreCase("4")){

			    	 	String sqls = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";
			    	 	ResultSet rs1 = stmtBalance.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("yeardiff");
						} 
						
						xsqls=1 + (grouping.equalsIgnoreCase("2")?" Month ":" Year ");
			     }
			     
			     else{
			    	 txtfrequency=0;
			     }
			     	ArrayList<String> temparray=new ArrayList<>();
			     	if(grouping.equalsIgnoreCase("2")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						  // xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%d-%m-%Y'),' To ',DATE_FORMAT(LAST_DAY('"+analysisDate+"'),'%d-%m-%Y')) analysisDates";
						   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,concat(MONTHNAME('"+analysisDate+"'),' ',date_format('"+analysisDate+"','%y')) analysisDates";
						   
						  // System.out.println(xsql);
						   ResultSet rs = stmtBalance.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql3+=" if (vehp.postdate between '"+sqlFromDate+"' and '"+analysisDate+"',vehp.amount,'') amount"+i+",";
								 temparray.add(" and vehp.postdate between '"+sqlFromDate+"' and '"+analysisDate+"'");
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
						     }
						}else{
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							   		+ "MONTHNAME(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate"+
								   ",concat(MONTHNAME(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ))),' ',date_format(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )),'%y')) stranalysisToDate";
					//System.out.println("Month xsql:"+xsql);
													   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("stranalysisToDate");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=rs.getString("stranalysisToDate");
								      }
								     
									     sql3+=" if (vehp.postdate between '"+analysisFromDate+"' and '"+analysisToDate+"',vehp.amount,'') amount"+i+",";
									     temparray.add(" and vehp.postdate between '"+analysisFromDate+"' and '"+analysisToDate+"'");
									     amountLength=amountLength+1;
									     
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
								     
								         analysisDate=analysisToDate;
							     }
						   }
					   
					     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
			     }
			     
			     	else if(grouping.equalsIgnoreCase("3")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%d-%m-%Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%d-%m-%Y')) analysisDates";
							   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								     sql3+=" if (vehp.postdate between '"+sqlFromDate+"' and '"+analysisDate+"',vehp.amount,'') amount"+i+",";
									 temparray.add(" and vehp.postdate between '"+sqlFromDate+"' and '"+analysisDate+"'");
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
							     }
							}else{
								   
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',"
								   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%d-%m-%Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',"
								   		+ "DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate";
								   
								   ResultSet rs = stmtBalance.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=analysingToDate;
									      }
									     
										     sql3+=" if (vehp.postdate between '"+analysisFromDate+"' and '"+analysisToDate+"',vehp.amount,'') amount"+i+",";
											 
										     temparray.add(" vehp.postdate between '"+analysisFromDate+"' and '"+analysisToDate+"'");
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
						
				     }
			     	
			     	else if(grouping.equalsIgnoreCase("4")){
			     		
			     		analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   String sqls = "SELECT YEAR('"+analysisDate+"') year";
							   ResultSet rs1 = stmtBalance.executeQuery(sqls);
							   
							   int year=0;
							   while(rs1.next()){
								    year=rs1.getInt("year");
							   }
							   
							   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
							   ResultSet rss = stmtBalance.executeQuery(sqls1);
							   
							   int noOfMonths=0;
							   while(rss.next()){
								     noOfMonths=rss.getInt("noofmonths");
							   }
							   
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,YEAR('"+analysisDate+"') analysisDates";
//							  System.out.println("year xsql: "+xsql);
							   ResultSet rs = stmtBalance.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
			
								     sql3+=" if (vehp.postdate between '"+sqlFromDate+"' and '"+analysisDate+"',vehp.amount,'') amount"+i+",";
									 
								     amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
							     }
							}else{
								   
								   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,YEAR(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%d-%m-%Y'),' To ',"
								   		+ "DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysingDate,YEAR(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month ))) stranalysisToDate";
								   
								   ResultSet rs = stmtBalance.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=rs.getString("stranalysisToDate");
									      }
									     
										     sql3+=" if (vehp.postdate between '"+analysisFromDate+"' and '"+analysisToDate+"',vehp.amount,'') amount"+i+",";
											 
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
			     	}
			     	
			     	
			     	
			     	
		     
		     
		     
		  /*   sql = "select @i:=@i+1 id,k.date,k.description,if(k.dr!=0,round(k.dr,2),'') dramount,"+sql3+""
		     		+ "k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac from ("
		     		+ "select 0 date,"+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,if(gtype='X',@xwrk,0) netAmt "
		     		+ "from gc_agrpd where gtype in('D','X') and gp_id<=17 "
		     		+ "UNION ALL "
		     		+ "Select t.date,"+sql1+"0 ORDNO,19 gp_id,0 den,0 groupNo, 0 subac,'PROFIT FOR THE PERIOD' description,0 dr,sum(ldramount)*-1 netAmt from "
		     		+ "my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type in (4,5)  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "select m.date,"+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,"
		     		+ "gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,if(grpLevel=1,'NET ASSET',"
		     		+ "' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,"
		     		+ "dr*if(grpLevel=1,1,-1),dr*drsign) dr,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt from ("
		     		+ "select a.date,a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between 12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,"
		     		+ "a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ("
		     		+ "select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
		     		+ "length(h.alevel) alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,("
		     		+ "SELECT 139 acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date<'"+sqlFromDate+"' and h.gr_type>=4  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "Select 140 acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 and "
		     		+ "t.trtype!=1  "+sql2+" "
		     		+ "UNION ALL "
		     		+ "SELECT acno,sum(ldramount) ldramount,t.date from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "
		     		+ ""+sql2+"  group by t.acno) t  where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,"
		     		+ "(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where k.dr!=0 order by gp_id,den,groupno,ordno";
		     */
		   String sqltest="";
		   String sqlcommon="";
		     if(sqlFromDate!=null){
					sqlcommon+=" and vehp.postdate>='"+sqlFromDate+"'";
				}
				if(sqlToDate!=null){
					sqlcommon+=" and vehp.postdate<='"+sqlToDate+"'";
				}
				
				String sqlgroup="";
				String sqlselect="";
				String sqlgroupdet="";
				if(grouping.equalsIgnoreCase("")){
					sqlgroup=" group by bsd.fleet_no";
					sqlselect="bsd.fleet_no refno,bsd.flname description";

				}
				else{
					sqlgroup="group by";
					if(!grouping.equalsIgnoreCase("")){
						sqlgroupdet=" bsd.fleet_no";
						sqlselect="bsd.fleet_no refno,bsd.flname description";
					}
					
					sqlgroup+=sqlgroupdet;
				}
				String sumsql="";
				if(grouping.equalsIgnoreCase("2") || grouping.equalsIgnoreCase("3") || grouping.equalsIgnoreCase("4")){
					for(int i=0;i<=txtfrequency;i++){
				    	 sumsql+="(sum(bsd.amount"+i+")) amount"+i+",";
				     }		
				}
				else{
//					System.out.println("Yom freq:"+txtfrequency);
					for(int i=0;i<txtfrequency;i++){
				    	 sumsql+="(sum(bsd.amount"+i+")) amount"+i+",";
				     }		
				}
		     
		     
				/* sql="select "+sumsql+",@i:=@i+1 id,refno,description from  (select "+sql3+" "+sqlselect+" from my_costtran cost left join gl_invm inv on"+
						" cost.tr_no=inv.tr_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on"+
						" ac.catid=cat.doc_no left join gl_vehmaster veh on cost.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
						" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_ragmt ragmt"+
						" on (inv.ratype='RAG' and inv.rano=ragmt.doc_no) left join gl_lagmt lagmt on (inv.ratype='LAG' and inv.rano=lagmt.doc_no) "+
						" left join my_salesman rarla on (ragmt.raid=rarla.doc_no"+
						" and rarla.sal_type='RLA') left join gl_yom yom on veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+sqltest+") f"+sqlgroup+",(SELECT @i:= 0) as i"; 
*/
		     /*sql="select "+sumsql+"@i:=@i+1 id,refno,description,0.0 amount from ("+
		    		 " select "+sql3+" "+sqlselect+"  from my_costtran c inner join my_jvtran j on c.tranid=j.tranid left "+
							" join my_head h on c.acno=h.doc_no left join my_acbook ac on (j.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on "+
							" h.cldocno=cat.doc_no left join gl_vehmaster veh on c.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on "+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where h.den=110 and j.status=3 "+sqltest+" ) bb,(SELECT @i:= 0) as i group by refno";*/
				/*
				sql="select "+sumsql+"refno,description,amount,id from (select "+sql3+""+sqlselect+",@i:=@i+1 id,0.0 amount from my_costtran c inner join my_jvtran j on c.tranid=j.tranid left "+
							" join my_head h on c.acno=h.doc_no left join my_acbook ac on (j.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on "+
							" h.cldocno=cat.doc_no left join gl_vehmaster veh on c.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on "+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no,(select @i:=0) as i where h.den=110 and j.status=3 "+sqltest+")a group by refno";*/
				
				/*if(grouping.equalsIgnoreCase("1") || grouping.equalsIgnoreCase("2")  || grouping.equalsIgnoreCase("3")  || grouping.equalsIgnoreCase("4")){
					sql=" select "+sumsql+""+sqlselect+",a.amount,@i:=@i+1 id from ( select (select @i:=0) as i,"+sql3+"c.amount,j.rtype,j.rdocno,c.jobid,j.tr_no,j.dtype,j.cldocno,j.doc_no from my_costtran c "+
							" inner join my_jvtran j on c.tranid=j.tranid left join my_head h on c.acno=h.doc_no where h.den=110 and j.status=3 "+sqlcommon+")a"+
							" left join gl_invm inv on (a.dtype in ('INV','INS','INT') and a.tr_no=inv.tr_no) left join my_cnot cno on (a.dtype in('CNO','DNO')"+
							" and a.tr_no=cno.tr_no) left join my_head cnohead on (cno.acno=cnohead.doc_no and cnohead.dtype='CRM')"+
							" left join my_acbook ac on ( (inv.cldocno=ac.cldocno or cnohead.cldocno=ac.cldocno) and ac.dtype='CRM') left join my_clcatm"+
							" cat on ac.catid=cat.doc_no left join  gl_vehmaster veh on a.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+sqltest+" group by refno order by id";					
				}
				else{
					sql=" select "+sqlselect+",a.amount,"+sql3+"@i:=@i+1 id from ( select (select @i:=0) as i,c.amount,j.rtype,j.rdocno,c.jobid,j.tr_no,j.dtype,j.cldocno,j.doc_no from my_costtran c "+
							" inner join my_jvtran j on c.tranid=j.tranid left join my_head h on c.acno=h.doc_no where h.den=110 and j.status=3 "+sqlcommon+")a"+
							" left join gl_invm inv on (a.dtype in ('INV','INS','INT') and a.tr_no=inv.tr_no) left join my_cnot cno on (a.dtype in('CNO','DNO')"+
							" and a.tr_no=cno.tr_no) left join my_head cnohead on (cno.acno=cnohead.doc_no and cnohead.dtype='CRM')"+
							" left join my_acbook ac on ( (inv.cldocno=ac.cldocno or cnohead.cldocno=ac.cldocno) and ac.dtype='CRM') left join my_clcatm"+
							" cat on ac.catid=cat.doc_no left join  gl_vehmaster veh on a.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
							" veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+sqltest+" group by refno order by id";					
				}*/
				
				sql="select "+sumsql+""+sqlselect+",bsd.amount0 amount,bsd.refname,@i:=@i+1 id from ( select (select @i:=0) as i,"+sql3+"insur.postdate,insur.doc_no insurdocno,agmt.voc_no,agmt.doc_no,br.branchname,ac.refname,agmt.date,agmt.outdate,convert(case when agmt.per_name=1 then "+
						" date_add(agmt.outdate,interval agmt.per_value year) when agmt.per_name=2 then date_add(agmt.outdate,interval agmt.per_value month) else '' end,char(25)) "+
						" enddate,veh.fleet_no,veh.reg_no,veh.flname "
						+ " from gl_lagmt agmt left join gl_vehinsur insur on insur.agmtno=agmt.doc_no left join my_brch br on "+
						" agmt.brhid=br.doc_no left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on "+
						" (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) left join gl_vehinsurposting vehp on vehp.agmtno=agmt.doc_no where insur.terminatestatus<>1  "+
						 " ) bsd group by refno order by id";

						 /*
						  * group by agmt.doc_no
						  * + "and (('"+sqlFromDate+"'"
							+ " between insur.insurfromdate and insur.insurtodate)  or ('"+sqlToDate+"' between insur.insurfromdate and insur.insurtodate)"
							+ "or (insur.insurfromdate between '"+sqlFromDate+"' and '"+sqlToDate+"') "
							+ "or (insur.insurtodate between '"+sqlFromDate+"' and '"+sqlToDate+"'))
*/				System.out.println("check sql: "+sql);
			 ArrayList<String> amtarray=new ArrayList<>();
			
			 
			 
				 ResultSet resultSet = stmtBalance.executeQuery(sql);

				 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",orderno="",profityearamt="",netamount="";
	/*		 
			 for(int i=0;i<temparray.size();i++){
				 System.out.println("For i"+i);
				 String amtsql="select @i:=@i+1 id,f.* from  (select sum(if(amount<0,amount*-1,amount)) amount from my_costtran cost left join gl_invm inv on"+
							" cost.tr_no=inv.tr_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on"+
							" ac.catid=cat.doc_no left join gl_vehmaster veh on cost.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
							" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_ragmt ragmt"+
							" on (inv.ratype='RAG' and inv.rano=ragmt.doc_no) left join gl_lagmt lagmt on (inv.ratype='LAG' and inv.rano=lagmt.doc_no) "+
							" left join my_salesman rarla on (ragmt.raid=rarla.doc_no"+
							" and rarla.sal_type='RLA') left join gl_yom yom on veh.yom=yom.doc_no left join my_salm sal on ac.sal_id=sal.doc_no where 1=1 "+temparray.get(i)+" "+sqlgroup+") f,(SELECT @i:= 0) as i"; 
				// System.out.println("Amtsql: "+amtsql);
				 Statement stmtamt=conn.createStatement();
				 ResultSet rsamt=stmtamt.executeQuery(amtsql);
				 while(rsamt.next()){
					 amtarray.add(rsamt.getString("amount"));
				 }
				 System.out.println("Check temp:"+temparray.get(i));
				 System.out.println(amtarray);
				 
			 }*/
			// System.out.println("Amountlength: "+amountLength);
			// System.out.println("Temparray size:"+temparray.size());
			// System.out.println("Amtarray size:"+amtarray.size());
							while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();

					
					
					
					
				     
					
					temp.add(resultSet.getString("id"));
					temp.add(resultSet.getString("refno"));
					temp.add(resultSet.getString("description"));
					temp.add(resultSet.getString("amount"));
					//System.out.println(amtarray);
					for (int l = 0; l < amountLength; l++) {
						temp.add(resultSet.getString("amount"+l+""));
						//temp.add(amtarray.get(l)+"l");
					}
					
					analysisrowarray.add(temp);
				}
				
			 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
			 
			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;
			// System.out.println("analysisarray = "+analysisarray);
			 }
			 
			 stmtBalance.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
     }
	
	
	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[8]);
			}
			/*if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregatesrenderer","rendererstring");
			}*/
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("refno",analysisRowArray.get(1));
			obj.put("description",analysisRowArray.get(2));
			obj.put("amount",analysisRowArray.get(3));
			for (int j = 4,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("amount"+k,analysisRowArray.get(j));
				}
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}

}
