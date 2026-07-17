package com.dashboard.analysis.profitlossanalysispalnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProfitLossAnalysis  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray analysisGrid(String branch,String fromdate,String todate, String cmbfrequency,String noOfDays,String check,String level1,String level2, String level3, String level4,String entrydate) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		 if(!check.equalsIgnoreCase("1")){
			 return RESULTDATA;    
		 }
		 HttpServletRequest request=ServletActionContext.getRequest();
		 HttpSession session=request.getSession();  
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtProfitLoss = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
		     java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		     java.sql.Date analysisDate=null;
		     java.sql.Date analysisFromDate=null;
		     java.sql.Date analysisToDate=null;
		     java.sql.Date sqlEntryDate = null;         
		     String analysingDate="",analysingToDate="";
		     int amountLength=0,txtfrequency=0;
		     
		     
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	         }else if(fromdate.equalsIgnoreCase("0")){
	        	   String sqldate= "select DATE_SUB(LAST_DAY(CURDATE()),INTERVAL 1 MONTH) today";
				   ResultSet rs = stmtProfitLoss.executeQuery(sqldate);
				   
				   while(rs.next()){
					   sqlFromDate=rs.getDate("today");
				   }
	         }

		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	         }else if(todate.equalsIgnoreCase("0")){
	        	   String sqldate= "select CURDATE() today";
				   ResultSet rs = stmtProfitLoss.executeQuery(sqldate);
				   
				   while(rs.next()){
					   sqlToDate=rs.getDate("today");
				   }
	         }
		     
		     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
		     
		     analysiscolumnarray.add("Id::id::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Parent Id::parentid::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Ord No::ordno::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Group No::groupno::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Group Id::gp_id::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Account::subac::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Description::description::left::left:: ::30%:: ::headClass");
			 analysiscolumnarray.add("Total::total::right::right:: ::10%::d2::violetClass");
		     		     
		     String xsql="",xsqls="";
		     String sql = "",sql1 = "",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="";
		     String dayDiff="",monthDiff="";

		     if(cmbfrequency.equalsIgnoreCase("1")){
		    		 String sqls = "select DATEDIFF('"+sqlToDate+"', '"+sqlFromDate+"') daydiff";
		    		 ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
		 			
		 			while(rs1.next()) {
		 				dayDiff=rs1.getString("daydiff");
		 			} 
		 			
		 			String sqls1 = "select ("+dayDiff+"/"+noOfDays+") daydifference";
		 			ResultSet rs2 = stmtProfitLoss.executeQuery(sqls1);
		 			
		 			while(rs2.next()) {
		 				txtfrequency=rs2.getInt("daydifference");
		 			} 

		    		 xsqls=Integer.parseInt(noOfDays) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");	
				
		     }else if(cmbfrequency.equalsIgnoreCase("2")){
		    	 
		    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("monthdiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
					
		     }else if(cmbfrequency.equalsIgnoreCase("3")){
		    	 
		    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
					
					while(rs1.next()) {
						monthDiff=rs1.getString("monthdiff");
					} 
					
					String sqls1 = "select ("+monthDiff+"/3) monthdifference";
					ResultSet rs2 = stmtProfitLoss.executeQuery(sqls1);
					
					while(rs2.next()) {
						txtfrequency=rs2.getInt("monthdifference");
					} 
		    	    
					xsqls= "3 Month";
					
		     }else if (cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){

		    	 	/*String sqls = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";*/
					String sqls = "select (YEAR('"+sqlToDate+"')-YEAR('"+sqlFromDate+"'))+1 yeardiff";
		    	 	ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("yeardiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
		     }
		     //System.out.println("txtfrequency==="+txtfrequency);  
		     	if(cmbfrequency.equalsIgnoreCase("1")){
					analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+") analysisDate,DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+"),'%d-%m-%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y') analysingDate";
					   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
					   
					   while(rs.next()){
						     analysisDate=rs.getDate("analysisDate");
						     analysingDate=rs.getString("analysisDates");
						     analysingToDate=rs.getString("analysingDate");
								
						     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	   analysisDate=sqlToDate;
						    	   analysingDate=analysingToDate;
						      }
						     
						     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
						     
						     sql4+=" 0 amount"+i+",";
							 
						     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
						     
						     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
						     
						     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
						     
						     sql8+="if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
						     
						     sql9+="if(round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2)!=0,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2),'')  amount"+i+",";
						     
						     sql10+="if(sum(coalesce(amount"+i+",0))!=0,round(sum(coalesce(amount"+i+",0)),2),'') amount"+i+",";  
						     
						     amountLength=amountLength+1;
						     
						     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
						     
					     }

					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
		     	}
		     
		     	else if(cmbfrequency.equalsIgnoreCase("2")){
		     	
		     	analysisDate=sqlFromDate;
				for(int i=0;i<=txtfrequency;i++)
				{
				   
				   if(i==0){
					   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
					   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
					   
					   while(rs.next()){
						     analysisDate=rs.getDate("analysisDate");
						     analysingDate=rs.getString("analysisDates");
						     
						     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
							 
						     sql4+=" 0 amount"+i+",";
						     
						     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
						     
						     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
						     
						     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
						     
						     sql8+="if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
						     
						     sql9+="if(round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2)!=0,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2),'')  amount"+i+",";
							 
						     sql10+="if(sum(coalesce(amount"+i+",0))!=0,round(sum(coalesce(amount"+i+",0)),2),'') amount"+i+",";
						     
						     amountLength=amountLength+1;
						     
						     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass"); 
					     }
					}else{
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
						   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
						   
						   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
		
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
							     
							         sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
									 
							         sql4+=" 0 amount"+i+",";
							         
							         sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
							         
							         sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
							         
							         sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
							         
							         sql8+="if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
							         
							         sql9+="if(round(sum(if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(invd.amount,0),'')),2)!=0,round(sum(if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(invd.amount,0),'')),2),'')  amount"+i+",";
							         
							         sql10+="if(sum(coalesce(amount"+i+",0))!=0,round(sum(coalesce(amount"+i+",0)),2),'') amount"+i+","; 
								     
							         amountLength=amountLength+1;
								     
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
							     
							         analysisDate=analysisToDate;
						     }
					   }
				   
				     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
				    	 break;
				     }
				}
				
		     }
		     
		     	else if(cmbfrequency.equalsIgnoreCase("3")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%b %Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%b %Y')) analysisDates";
						   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
								 
							     sql4+=" 0 amount"+i+",";
							     
							     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
							     
							     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
							     
							     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
							     
							     sql8+="if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
							     
							     sql9+="if(round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2)!=0,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2),'')  amount"+i+",";
								 
							     sql10+="if(sum(coalesce(amount"+i+",0))!=0,round(sum(coalesce(amount"+i+",0)),2),'') amount"+i+",";
							     
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
						     }
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
							   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
								         sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
										 
								         sql4+=" 0 amount"+i+",";
								         
								         sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
								         
								         sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
								         
								         sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
								         
								         sql8+="if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
								         
								         sql9+="if(round(sum(if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(invd.amount,0),'')),2)!=0,round(sum(if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(invd.amount,0),'')),2),'')  amount"+i+",";
										 
								         sql10+="if(sum(coalesce(amount"+i+",0))!=0,round(sum(coalesce(amount"+i+",0)),2),'') amount"+i+",";
								         
									     amountLength=amountLength+1;
									     
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
								     
								         analysisDate=analysisToDate;
							     }
						   }
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
			     }
		     	
		     	else if(cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){
		     		
		     		analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					  
					   if(i==0){
						   String sqls = "SELECT YEAR('"+analysisDate+"') year";
						   ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
						   
						   int year=0;
						   while(rs1.next()){
							    year=rs1.getInt("year");
						   }
						   
						   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
						   ResultSet rss = stmtProfitLoss.executeQuery(sqls1);
						   
						   int noOfMonths=0;
						   while(rss.next()){
							     noOfMonths=rss.getInt("noofmonths");
						   }
						   
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
						   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
							     
							     sql4+=" 0 amount"+i+",";
							     
							     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
							     
							     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
							     
							     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
							     
							     sql8+="if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
							     
							     sql9+="if(round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2)!=0,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+analysisDate+"',coalesce(invd.amount,0),'')),2),'')  amount"+i+",";
								 
							     sql10+="if(sum(coalesce(amount"+i+",0))!=0,round(sum(coalesce(amount"+i+",0)),2),'') amount"+i+",";
							     
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
						     }
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
									+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
							   
							   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
									     sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
									     
									     sql4+=" 0 amount"+i+",";
									     
									     sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
									     
									     sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
									     
									     sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
									    	
									     sql8+="if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
									     
									     sql9+="if(round(sum(if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(invd.amount,0),'')),2)!=0,round(sum(if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(invd.amount,0),'')),2),'')  amount"+i+",";
										 
									     sql10+="if(sum(coalesce(amount"+i+",0))!=0,round(sum(coalesce(amount"+i+",0)),2),'') amount"+i+",";
									     
									     amountLength=amountLength+1;
									     
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
								     
								         analysisDate=analysisToDate;
							     }
						   }
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){ 
					    	 break;
					     }
					}
		     	}
		     	
		     	
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and t.brhid in ("+branch+")";
			 }
		     Statement stmtprofit1=conn.createStatement();
		     Statement stmtprofit2=conn.createStatement();
		     Statement stmtprofit3=conn.createStatement();  
		     String sqldel ="delete from profitandlossanalysis where entrydate<UNIX_TIMESTAMP(date_format(now(),'%Y-%m-%d'))";   
	       	 stmtProfitLoss.executeUpdate(sqldel);   
		     int ival=1;
		     String sqlgetid ="select coalesce(max(id)+1,1) id from profitandlossanalysis";  
	       	 ResultSet rstemp= stmtProfitLoss.executeQuery(sqlgetid);    
	       	 while(rstemp.next()){  
	       		ival=rstemp.getInt("id");    
	       	 }	    
	       	 String userid=session.getAttribute("USERID").toString();     
	       	 //System.out.println(level1+"="+level2+"="+level3+"="+level4);
	       	  
	       	 if(level1.equalsIgnoreCase("1")){  
	       		sql = "select @i:=@i+1 id,k.date,k.description,head,grpHead,if(k.total!=0,round(k.total,2),'') dramount,if(k.total!=0,round(k.total,2),'') total,"+sql3+"k.gp_id, k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then acc.account else k.ordno end as code from ( "  
			     		+ "select "+sql1+""+sql4+"0 date,0 ORDNO,gp_id,0 den,0 groupNo,0 subac,gp_desc description,0 total,'' head,'' grpHead from gc_agrpd where gtype in('D') and gp_id>18 "  
			     		+ "union all "  
			     		+ "select "+sql1+""+sql4+"0 date,5 ORDNO,21 gp_id,0 den,0 groupNo,0 subac,'GROSS PROFIT' description,0.001 total,'' head,'' grpHead " 
			     		+ "union all "  
			     		+ "select "+sql1+""+sql5+"m.date,@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,"
			     		+ "ifnull(groupNo,0) groupNo,ifnull(subac,0)subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,"
			     		+ "if(gp_id is  null,total*if(grpLevel=1,-1,1),total*drsign) total,m.head,m.grpHead from ("  
			     		+ "select a.date,a.doc_no subac,m.*,sum(total) total,"+sql6+"a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ( "  
			     		+ "select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and "  
			     		+ "h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,( "  
			     		+ "select x.acno,x.date,"+sql7+"round(sum(x.total),2) total from (Select t.date,acno,"+sql8+"coalesce(round(ldramount,2),0) total from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type>=4 "
			     		+ "and t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"' and h.gr_type>=4 and t.yrid=0"+sql2+") x group by x.acno) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,"
			     		+ "groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k left join my_head acc on k.subac=acc.doc_no,(SELECT @i:= 0) as i where k.total!=0 and ordno in(5,1)  order by k.gp_id,k.den,k.groupno,k.ordno"; 
	       	 }else if(level2.equalsIgnoreCase("1")){ 
	       		sql = "select @i:=@i+1 id,k.date,k.description,head,grpHead,if(k.total!=0,round(k.total,2),'') dramount,if(k.total!=0,round(k.total,2),'') total,"+sql3+"k.gp_id, k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then acc.account else k.ordno end as code from ( "  
			     		+ "select "+sql1+""+sql4+"0 date,0 ORDNO,gp_id,0 den,0 groupNo,0 subac,gp_desc description,0 total,'' head,'' grpHead from gc_agrpd where gtype in('D') and gp_id>18 "  
			     		+ "union all "  
			     		+ "select "+sql1+""+sql4+"0 date,5 ORDNO,21 gp_id,0 den,0 groupNo,0 subac,'GROSS PROFIT' description,0.001 total,'' head,'' grpHead " 
			     		+ "union all "  
			     		+ "select "+sql1+""+sql5+"m.date,@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,"
			     		+ "ifnull(groupNo,0) groupNo,ifnull(subac,0)subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,"
			     		+ "if(gp_id is  null,total*if(grpLevel=1,-1,1),total*drsign) total,m.head,m.grpHead from ("  
			     		+ "select a.date,a.doc_no subac,m.*,sum(total) total,"+sql6+"a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ( "  
			     		+ "select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and "  
			     		+ "h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,( "  
			     		+ "select x.acno,x.date,"+sql7+"round(sum(x.total),2) total from (Select t.date,acno,"+sql8+"coalesce(round(ldramount,2),0) total from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type>=4 "
			     		+ "and t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"' and h.gr_type>=4 and t.yrid=0"+sql2+") x group by x.acno) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,"
			     		+ "groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k left join my_head acc on k.subac=acc.doc_no,(SELECT @i:= 0) as i where k.total!=0 and ordno in(5,3,1)  order by k.gp_id,k.den,k.groupno,k.ordno"; 
	       	}else if(level3.equalsIgnoreCase("1")){ 
	       		sql = "select @i:=@i+1 id,k.date,k.description,head,grpHead,if(k.total!=0,round(k.total,2),'') dramount,if(k.total!=0,round(k.total,2),'') total,"+sql3+"k.gp_id, k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then acc.account else k.ordno end as code from ( "  
			     		+ "select "+sql1+""+sql4+"0 date,0 ORDNO,gp_id,0 den,0 groupNo,0 subac,gp_desc description,0 total,'' head,'' grpHead from gc_agrpd where gtype in('D') and gp_id>18 "  
			     		+ "union all "  
			     		+ "select "+sql1+""+sql4+"0 date,5 ORDNO,21 gp_id,0 den,0 groupNo,0 subac,'GROSS PROFIT' description,0.001 total,'' head,'' grpHead " 
			     		+ "union all "  
			     		+ "select "+sql1+""+sql5+"m.date,@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,"
			     		+ "ifnull(groupNo,0) groupNo,ifnull(subac,0)subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,"
			     		+ "if(gp_id is  null,total*if(grpLevel=1,-1,1),total*drsign) total,m.head,m.grpHead from ("  
			     		+ "select a.date,a.doc_no subac,m.*,sum(total) total,"+sql6+"a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ( "  
			     		+ "select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and "  
			     		+ "h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,( "  
			     		+ "select x.acno,x.date,"+sql7+"round(sum(x.total),2) total from (Select t.date,acno,"+sql8+"coalesce(round(ldramount,2),0) total from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type>=4 "
			     		+ "and t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"' and h.gr_type>=4 and t.yrid=0"+sql2+") x group by x.acno) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,"
			     		+ "groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k left join my_head acc on k.subac=acc.doc_no,(SELECT @i:= 0) as i where k.total!=0 and ordno in(5,3,4,1)  order by k.gp_id,k.den,k.groupno,k.ordno"; 
	       	}else {
	       		sql = "select @i:=@i+1 id,k.date,k.description,head,grpHead,if(k.total!=0,round(k.total,2),'') dramount,if(k.total!=0,round(k.total,2),'') total,"+sql3+"k.gp_id, k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then acc.account else k.ordno end as code from ( "  
			     		+ "select "+sql1+""+sql4+"0 date,0 ORDNO,gp_id,0 den,0 groupNo,0 subac,gp_desc description,0 total,'' head,'' grpHead from gc_agrpd where gtype in('D') and gp_id>18 "  
			     		+ "union all "  
			     		+ "select "+sql1+""+sql4+"0 date,5 ORDNO,21 gp_id,0 den,0 groupNo,0 subac,'GROSS PROFIT' description,0.001 total,'' head,'' grpHead " 
			     		+ "union all "  
			     		+ "select "+sql1+""+sql5+"m.date,@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,"
			     		+ "ifnull(groupNo,0) groupNo,ifnull(subac,0)subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION,"
			     		+ "if(gp_id is  null,total*if(grpLevel=1,-1,1),total*drsign) total,m.head,m.grpHead from ("  
			     		+ "select a.date,a.doc_no subac,m.*,sum(total) total,"+sql6+"a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ( "  
			     		+ "select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and "  
			     		+ "h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,( "  
			     		+ "select x.acno,x.date,"+sql7+"round(sum(x.total),2) total from (Select t.date,acno,"+sql8+"coalesce(round(ldramount,2),0) total from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type>=4 "
			     		+ "and t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"' and h.gr_type>=4 and t.yrid=0"+sql2+") x group by x.acno) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,"
			     		+ "groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k left join my_head acc on k.subac=acc.doc_no,(SELECT @i:= 0) as i where k.total!=0  order by k.gp_id,k.den,k.groupno,k.ordno,k.description"; 
	       	}
	         //System.out.println("===== "+sql);   
			 ResultSet rsprofits = stmtprofit1.executeQuery(sql);  
			 //System.out.println("amountLength--->>>"+amountLength);
			 ArrayList<String> amountlist = new ArrayList<String>();  
			 int rownoval=0;   
			 String subacval="",dateval="",descval="";
			 while(rsprofits.next()){  
				  subacval=rsprofits.getString("subac");  
				  descval=rsprofits.getString("description");
				  if(descval.equalsIgnoreCase("REVENUE CONTROL ACCOUNT")) {
					  //String sqlprofit2="select a.* from(select coalesce(i.rowno,0) rowno,t.acno,coalesce(typename,'OTHER') type,"+sql9+"round(sum(coalesce(invd.amount,0) ),2) total,round(sum(coalesce(invd.amount,0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0  order by rowno";
					  String sqlprofit2="select b.* from(select a.* from(select coalesce(i.rowno,0) rowno,t.acno,coalesce(typename,'OTHER') type,coalesce(typename,'OTHER') type2,"+sql9+"round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) total,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0 and (rowno=-2 or rowno=-1) union all select a.rowno,a.acno,a.type,a.type2,"+sql10+"sum(a.total) total,sum(a.dramount) dramount from(select coalesce(i.rowno,0) rowno,t.acno,'INSURANCE SALES' type,coalesce(typename,'OTHER') type2,"+sql9+"round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) total,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0 and rowno>=0 group by type union all select a.rowno,a.acno,a.type,a.type2,"+sql10+"sum(a.total) total,sum(a.dramount) dramount from(select coalesce(i.rowno,0) rowno,t.acno,'SALES OTHER' type,coalesce(typename,'OTHER') type2,"+sql9+"round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) total,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0 and (rowno=-3 or rowno=-4 or rowno=-5 or rowno=-6 or rowno=-7 ) group by type)b order by type";
					  //System.out.println("sqlprofit2==="+sqlprofit2);           
		        	  ResultSet rsprofit2 = stmtprofit2.executeQuery(sqlprofit2);      
		        	  while(rsprofit2.next()) {  
		        		  rownoval=rsprofit2.getInt("rowno");
		        		  if(rownoval==-3 || rownoval==-4 || rownoval==-5  || rownoval==-6  || rownoval==-7) {     
		        			  for (int l = 0; l < amountLength; l++) {
				        		  amountlist.add(rsprofit2.getString("amount"+l+""));  
				        	  }
				        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
				        		  amountlist.add("");         
				        	  }
				        	  String sqlprofit ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','SALES OTHER','SALES OTHER','"+rsprofit2.getString("dramount")+"','"+rsprofit2.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','"+rsprofits.getString("gp_id")+"','"+rsprofits.getString("ordno")+"','"+rsprofits.getString("parentid")+"','"+rsprofits.getString("groupno")+"','0','Main')";
				        	  //System.out.println("sqlprofit==="+sqlprofit);
				        	  stmtProfitLoss.executeUpdate(sqlprofit);
				        	  ival++;
							  amountlist = new ArrayList<String>();
							  if(level4.equalsIgnoreCase("1")){    
								  String sqlprofit3="select a.* from(select coalesce(i.rowno,0) rowno,t.acno,typename type,typename type2,"+sql9+"round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) total,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0 and (rowno=-3 or rowno=-4 or rowno=-5 or rowno=-6 or rowno=-7) order by type";
								  //System.out.println("sqlprofit3==="+sqlprofit3);            
					        	  ResultSet rsprofit3 = stmtprofit3.executeQuery(sqlprofit3);  
					        	  while(rsprofit3.next()) {
					        		  for (int l = 0; l < amountLength; l++) {
						        		  amountlist.add(rsprofit3.getString("amount"+l+""));  
						        	  }
						        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
						        		  amountlist.add("");         
						        	  }
						        	  String sqlprofit5 ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','SALES OTHER','"+rsprofit3.getString("type")+"','"+rsprofit3.getString("dramount")+"','"+rsprofit3.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','19','6','6','1020','1052','1052')";
						        	  //System.out.println("sqlprofit5==="+sqlprofit5);    
						        	  stmtProfitLoss.executeUpdate(sqlprofit5);  
						        	  ival++;
									  amountlist = new ArrayList<String>();  
					        	  }    
							  }
		        		  }else if(rownoval==-2) {
		        			  for (int l = 0; l < amountLength; l++) {
				        		  amountlist.add(rsprofit2.getString("amount"+l+""));  
				        	  }
				        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
				        		  amountlist.add("");         
				        	  }
				        	  String sqlprofit ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','MECHANICAL','MECHANICAL','"+rsprofit2.getString("dramount")+"','"+rsprofit2.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','"+rsprofits.getString("gp_id")+"','"+rsprofits.getString("ordno")+"','"+rsprofits.getString("parentid")+"','"+rsprofits.getString("groupno")+"','0','Main')";
				        	  //System.out.println("sqlprofit==="+sqlprofit);
				        	  stmtProfitLoss.executeUpdate(sqlprofit);
				        	  ival++;
							  amountlist = new ArrayList<String>();
							  if(level4.equalsIgnoreCase("1")){    
								  String sqlprofit3="select a.* from(select coalesce(i.rowno,0) rowno,t.acno,coalesce(typename,'OTHER') type,coalesce(typename,'OTHER') type2,"+sql9+"round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) total,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0 and (rowno=-2) order by type";
								  //System.out.println("sqlprofit3==="+sqlprofit3);         
					        	  ResultSet rsprofit3 = stmtprofit3.executeQuery(sqlprofit3);  
					        	  while(rsprofit3.next()) {
					        		  for (int l = 0; l < amountLength; l++) {
						        		  amountlist.add(rsprofit3.getString("amount"+l+""));  
						        	  }
						        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
						        		  amountlist.add("");         
						        	  }
						        	  String sqlprofit5 ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','MECHANICAL','"+rsprofit3.getString("type")+"','"+rsprofit3.getString("dramount")+"','"+rsprofit3.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','19','6','6','1020','1052','1052')";
						        	  //System.out.println("sqlprofit5==="+sqlprofit5);  
						        	  stmtProfitLoss.executeUpdate(sqlprofit5);  
						        	  ival++;
									  amountlist = new ArrayList<String>();  
					        	  }    
							  }
		        		  }else if(rownoval==-1) {
		        			  for (int l = 0; l < amountLength; l++) {
				        		  amountlist.add(rsprofit2.getString("amount"+l+""));  
				        	  }
				        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
				        		  amountlist.add("");         
				        	  }
				        	  String sqlprofit ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','PRIVATE JOB','PRIVATE JOB','"+rsprofit2.getString("dramount")+"','"+rsprofit2.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','"+rsprofits.getString("gp_id")+"','"+rsprofits.getString("ordno")+"','"+rsprofits.getString("parentid")+"','"+rsprofits.getString("groupno")+"','0','Main')";
				        	  //System.out.println("sqlprofit==="+sqlprofit);
				        	  stmtProfitLoss.executeUpdate(sqlprofit); 
				        	  ival++;
							  amountlist = new ArrayList<String>();
							  if(level4.equalsIgnoreCase("1")){
								  String sqlprofit3="select a.* from(select coalesce(i.rowno,0) rowno,t.acno,coalesce(typename,'OTHER') type,coalesce(typename,'OTHER') type2,"+sql9+"round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) total,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0 and (rowno=-1) order by type";
								  //System.out.println("sqlprofit3==="+sqlprofit3);         
					        	  ResultSet rsprofit3 = stmtprofit3.executeQuery(sqlprofit3);  
					        	  while(rsprofit3.next()) {
					        		  for (int l = 0; l < amountLength; l++) {
						        		  amountlist.add(rsprofit3.getString("amount"+l+""));  
						        	  }
						        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
						        		  amountlist.add("");         
						        	  }
						        	  String sqlprofit5 ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','PRIVATE JOB','"+rsprofit3.getString("type")+"','"+rsprofit3.getString("dramount")+"','"+rsprofit3.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','19','6','6','1020','1052','1052')";
						        	  //System.out.println("sqlprofit5==="+sqlprofit5);  
						        	  stmtProfitLoss.executeUpdate(sqlprofit5);  
						        	  ival++;
									  amountlist = new ArrayList<String>();
					        	  } 
							  }
		        		  }else if(rownoval>=0) {
		        			  for (int l = 0; l < amountLength; l++) {
				        		  amountlist.add(rsprofit2.getString("amount"+l+""));  
				        	  }
				        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
				        		  amountlist.add("");         
				        	  } 
				        	  String sqlprofit ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','INSURANCE SALES','INSURANCE SALES','"+rsprofit2.getString("dramount")+"','"+rsprofit2.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','"+rsprofits.getString("gp_id")+"','"+rsprofits.getString("ordno")+"','"+rsprofits.getString("parentid")+"','"+rsprofits.getString("groupno")+"','0','Main')";
				        	  //System.out.println("sqlprofit==="+sqlprofit);
				        	  stmtProfitLoss.executeUpdate(sqlprofit);
				        	  ival++;
							  amountlist = new ArrayList<String>();
							  if(level4.equalsIgnoreCase("1")){
								  String sqlprofit3="select a.* from(select coalesce(i.rowno,0) rowno,t.acno,coalesce(typename,'OTHER') type,coalesce(typename,'OTHER') type2,"+sql9+"round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) total,round(sum(if(t.date>='"+sqlFromDate+"' and t.date<='"+sqlToDate+"',coalesce(invd.amount,0),0)),2) dramount from MY_jvtran t left join ws_invinsurtype invd on invd.invno=t.doc_no and t.dtype='mnt' left join my_acinsurtype i on i.rowno=invd.insurtype where t.acno=1052 and t.status<>7 "+sql2+" group by i.rowno) a where total!=0 and (rowno>=0) order by type ";
								 // System.out.println("sqlprofit3==="+sqlprofit3);          
					        	  ResultSet rsprofit3 = stmtprofit3.executeQuery(sqlprofit3);    
					        	  while(rsprofit3.next()) {
					        		  for (int l = 0; l < amountLength; l++) {
						        		  amountlist.add(rsprofit3.getString("amount"+l+""));  
						        	  }
						        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {    
						        		  amountlist.add("");         
						        	  }
						        	  String sqlprofit5 ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','INSURANCE SALES','"+rsprofit3.getString("type")+"','"+rsprofit3.getString("dramount")+"','"+rsprofit3.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','19','6','6','1020','1052','1052')";
						        	  //System.out.println("sqlprofit5==="+sqlprofit5);    
						        	  stmtProfitLoss.executeUpdate(sqlprofit5);  
						        	  ival++;
									  amountlist = new ArrayList<String>(); 
					        	  } 
							  }  
		        		  }else {}  
		        	  }  
					
				  }else if(subacval.equalsIgnoreCase("1052")) {  
					  
				  }else {    
		        	  for (int l = 0; l < amountLength; l++) {
		        		  amountlist.add(rsprofits.getString("amount"+l+""));    
		        	  }
		        	  for (int i = 13,k=amountLength; i > amountLength; i--,k++) {        
		        		  amountlist.add("");         
		        	  }
		        	  String sqlprofit ="insert into profitandlossanalysis (id, userid, entrydate, head, grphead, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code) values('"+ival+"','"+userid+"','"+entrydate+"','"+rsprofits.getString("head")+"','"+rsprofits.getString("grphead")+"','"+rsprofits.getString("description")+"','"+rsprofits.getString("dramount")+"','"+rsprofits.getString("total")+"','"+amountlist.get(0)+"','"+amountlist.get(1)+"','"+amountlist.get(2)+"','"+amountlist.get(3)+"','"+amountlist.get(4)+"','"+amountlist.get(5)+"','"+amountlist.get(6)+"','"+amountlist.get(7)+"','"+amountlist.get(8)+"','"+amountlist.get(9)+"','"+amountlist.get(10)+"','"+amountlist.get(11)+"','"+rsprofits.getString("gp_id")+"','"+rsprofits.getString("ordno")+"','"+rsprofits.getString("parentid")+"','"+rsprofits.getString("groupno")+"','"+rsprofits.getString("subac")+"','"+rsprofits.getString("code")+"')";
		        	  //System.out.println("sqlprofit==="+sqlprofit);  
		        	  stmtProfitLoss.executeUpdate(sqlprofit);     
					  ival++;
					  amountlist = new ArrayList<String>();  
		          }
			 }        
			 
			 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
			 ArrayList<String> revenueamtarray=new ArrayList<String>();
			 ArrayList<String> directcostamtarray=new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",revenueamt="",directcostamt="",grossprofit="",
					 otherincomeamt="",indirectexpensesamt="",revenueamttotal="",directcostamttotal="",grossprofittotal="",otherincomeamttotal="",indirectexpensesamttotal="";
			
			 String sqlprofitfinal="select id, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac from profitandlossanalysis where entrydate='"+entrydate+"'";
			 ResultSet resultSet = stmtProfitLoss.executeQuery(sqlprofitfinal);    
			 
				while(resultSet.next()){   
					ArrayList<String> temp=new ArrayList<String>();

					masterid=resultSet.getString("parentid");
					
					if(childid!=masterid){
						
						if(masterid.equalsIgnoreCase("null")){
							parentid=null;
							masterparentid=resultSet.getString("id");
							
						}else if(masterid.equalsIgnoreCase("3")){
							parentid=masterparentid;
							childparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("4")){
							parentid=childparentid;
							subchildparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("6")){
							parentid=subchildparentid;
						}
						
						/*if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22")){
								if(parentid==null){
									grossprofit=String.valueOf((revenueamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamt))-(directcostamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamt)));
									//temp="0::GROSS PROFIT:: ::"+grossprofit+" :: :: :: null:: 5:: :: 0";
									temp.add("0");
									temp.add(null);
									temp.add("5");
									temp.add("");
									temp.add(resultSet.getString("gp_id"));
									temp.add("0");
									temp.add("GROSS PROFIT");
									
									for (int l = 0; l < amountLength; l++) {
										temp.add(resultSet.getString("amount"+l+""));
									}
									
									analysisrowarray.add(temp);
								}
							}*/
							
							/*if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23")){
								if(parentid==null){
								    netprofit=String.valueOf(((grossprofit.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(grossprofit))+(otherincomeamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(otherincomeamt)))-(indirectexpensesamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(indirectexpensesamt)));
								}
							}*/
							
						 childid=masterid;
					}
				     
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add("0");
						otherincomeamttotal=resultSet.getString("total");
					}else{
						temp.add(resultSet.getString("id"));	
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add(null);
					}else{
						temp.add(parentid);	
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add("5");
					}else{
						temp.add(resultSet.getString("ordno"));
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add("0");
					}else{
						temp.add(resultSet.getString("groupno"));
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add(resultSet.getString("gp_id"));
					}else{
						temp.add(resultSet.getString("gp_id"));
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add("0");
					}else{
						temp.add(resultSet.getString("subac"));
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
						revenueamttotal=resultSet.getString("total");
					}
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
						directcostamttotal=resultSet.getString("total");
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
						indirectexpensesamttotal=resultSet.getString("total");
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add("GROSS PROFIT");
						grossprofittotal=String.valueOf((revenueamttotal.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamttotal))-(directcostamttotal.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamttotal)));
						temp.add(grossprofittotal);
					}else{
						temp.add(resultSet.getString("description"));
						temp.add(resultSet.getString("total"));
					}
					
					for (int l = 0; l < amountLength; l++) {
						
						if(masterid.equalsIgnoreCase("null")){  
							parentid=null;
							masterparentid=resultSet.getString("id");
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamtarray.add(resultSet.getString("amount"+l+""));
							}
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamtarray.add(resultSet.getString("amount"+l+""));
							}
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamt=resultSet.getString("amount"+l+"");
							}
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamt=resultSet.getString("amount"+l+"");
							}
							
					}
						
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21")){
						if(parentid==null){
							if(revenueamtarray.size()>0){
								revenueamt=revenueamtarray.get(l);
							}
							if(directcostamtarray.size()>0){
								directcostamt=directcostamtarray.get(l);
							}
							grossprofit=String.valueOf((revenueamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamt))-(directcostamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamt)));
							temp.add(grossprofit.trim().equalsIgnoreCase("0.0")?"":grossprofit);
						} else {
							temp.add(resultSet.getString("amount"+l+""));    
						}
					}else{
				    	 temp.add(resultSet.getString("amount"+l+""));    	 
				     }
					//analysisrowarray.add(temp);
				  }
					analysisrowarray.add(temp);
			     }
				 //System.out.println("analysisrowarray--->>>"+analysisrowarray); 
				 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
				 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				 
				 JSONArray analysisarray=new JSONArray();
				 
				 analysisarray.addAll(COLUMNDATA);
				 analysisarray.addAll(ROWDATA);
				 RESULTDATA=analysisarray;
			 } 
			 stmtProfitLoss.close();
			 conn.close();
			 
			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 //System.out.println("data = "+RESULTDATA);
		 return RESULTDATA;
       }                 

	public JSONArray accountStatementDetail(String branch,String fromdate,String todate,String accdocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtProfitLoss1 = conn.createStatement();
				String sql = "";
				
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            			
				sql = "select a.*,if(a.transType='ÍNV',m.voc_no,a.transno) transno  from (select transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and t.yrid=0 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" union all select date( '"+sqlFromDate+"' ) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and t.yrid=0 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join gl_invm m on m.dtype=a.transType and a.transno=m.doc_no";
				
				ResultSet resultSet = stmtProfitLoss1.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtProfitLoss1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray accountStatementDetailGrid() throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtProfitLoss1 = conn.createStatement();
	        	
				ResultSet resultSet1 = stmtProfitLoss1.executeQuery ("select jv.tr_no,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(15)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(15)) cr,"
						+ "CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(15)) drcur,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(15)) crcur,t.description account,c.code currency,round((c.c_rate),2) rate "
						+ "from my_jvtran jv left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 and jv.yrid=0 ");
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtProfitLoss1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
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
		Connection conn =  null;
		int id=0,j=0,k=0;
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtProfitLoss = conn.createStatement();
			 String sql="select id from profitandlossanalysis where description='GROSS PROFIT'";     
	       	  //System.out.println("sql==="+sql);     
	       	  ResultSet rs = stmtProfitLoss.executeQuery(sql);          
	       	  while(rs.next()) {
	       		  id=rs.getInt("id");   
	       	 }   
			 for (int i = 0; i < rowsAnalysisList.size(); i++) {  
						
						JSONObject obj = new JSONObject();
						ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
						
						int length = analysisRowArray.size();
						
						obj.put("id",analysisRowArray.get(0));
						obj.put("parentid",analysisRowArray.get(1));
						obj.put("ordno",analysisRowArray.get(2));
						obj.put("groupno",analysisRowArray.get(3));
						obj.put("gp_id",analysisRowArray.get(4));
						obj.put("subac",analysisRowArray.get(5));
						obj.put("description",analysisRowArray.get(6));
						obj.put("total",analysisRowArray.get(7));
						
						if(analysisRowArray.get(6).equalsIgnoreCase("GROSS PROFIT")) {  
							  //System.out.println("Yes I'm Here Da"+obj);  
							 String sqlprofit ="update profitandlossanalysis set dramount="+obj.getString("total")+", total="+obj.getString("total")+" where id='"+id+"'";
				        	 //System.out.println("sqlprofit==="+sqlprofit);    
				        	 stmtProfitLoss.executeUpdate(sqlprofit);
						}
						for (j = 8,k=0; j < length; j++,k++) {   
							if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
								obj.put("amount"+k,analysisRowArray.get(j));
								String amountname="amount"+k;
								if(analysisRowArray.get(6).equalsIgnoreCase("GROSS PROFIT")) {  
									String sqlprofit ="update profitandlossanalysis set "+amountname+"='"+analysisRowArray.get(j)+"' where id='"+id+"'";
						        	//System.out.println("sqlprofit==="+sqlprofit);
						        	stmtProfitLoss.executeUpdate(sqlprofit);
								}    
							}
						}
						
						jsonArray.add(obj);
			 }
			JSONObject obj1 = new JSONObject();
			obj1.put("rows",jsonArray);
			jsonArray1.add(obj1);  
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return jsonArray1;
		}
	
	public  JSONArray convertArrayToExcel(ArrayList<ArrayList<String>> arrayList,String cmbfrequency) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		String frequencytype=cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":cmbfrequency.equalsIgnoreCase("3")?" Quarter ":" Year ";
		
		for (int i = 0; i < arrayList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> profitAndLossRowArray=arrayList.get(i);
			int length = profitAndLossRowArray.size();
				
			obj.put("Code",profitAndLossRowArray.get(0));
			obj.put("Description",profitAndLossRowArray.get(1));
			obj.put("Total",profitAndLossRowArray.get(2));
			
			for (int j = 3,k=1; j < length; j++,k++) {
				if(!(profitAndLossRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put(frequencytype+" "+k,profitAndLossRowArray.get(j));
				}
			}
			
			jsonArray.add(obj);

		}
		return jsonArray;
		}
	public JSONArray analysisExcel(String branch,String fromdate,String todate, String cmbfrequency,String noOfDays,String check,String entrydate) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		 if(!check.equalsIgnoreCase("1")){
			 return RESULTDATA;    
		 }
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtProfitLoss = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
		     java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		     java.sql.Date analysisDate=null;
		     java.sql.Date analysisFromDate=null;
		     java.sql.Date analysisToDate=null;
		     String analysingDate="",analysingToDate="";
		     int amountLength=0,txtfrequency=0;
		     
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	         }else if(fromdate.equalsIgnoreCase("0")){
	        	   String sqldate= "select DATE_SUB(LAST_DAY(CURDATE()),INTERVAL 1 MONTH) today";
				   ResultSet rs = stmtProfitLoss.executeQuery(sqldate);
				   
				   while(rs.next()){
					   sqlFromDate=rs.getDate("today");
				   }
	         }

		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	         }else if(todate.equalsIgnoreCase("0")){
	        	   String sqldate= "select CURDATE() today";
				   ResultSet rs = stmtProfitLoss.executeQuery(sqldate);
				   
				   while(rs.next()){
					   sqlToDate=rs.getDate("today");
				   }
	         }
		     
		     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
		     
		     analysiscolumnarray.add("Id::id::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Parent Id::parentid::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Ord No::ordno::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Group No::groupno::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Group Id::gp_id::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Account::subac::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Description::description::left::left:: ::30%:: ::headClass");
			 analysiscolumnarray.add("Total::total::right::right:: ::10%::d2::violetClass");
		     		     
		     String xsql="",xsqls="";
		     String sql = "",sql1 = "",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="";
		     String dayDiff="",monthDiff="";

		     if(cmbfrequency.equalsIgnoreCase("1")){
		    		 String sqls = "select DATEDIFF('"+sqlToDate+"', '"+sqlFromDate+"') daydiff";
		    		 ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
		 			
		 			while(rs1.next()) {
		 				dayDiff=rs1.getString("daydiff");
		 			} 
		 			
		 			String sqls1 = "select ("+dayDiff+"/"+noOfDays+") daydifference";
		 			ResultSet rs2 = stmtProfitLoss.executeQuery(sqls1);
		 			
		 			while(rs2.next()) {
		 				txtfrequency=rs2.getInt("daydifference");
		 			} 

		    		 xsqls=Integer.parseInt(noOfDays) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");	
				
		     }else if(cmbfrequency.equalsIgnoreCase("2")){
		    	 
		    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("monthdiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
					
		     }else if(cmbfrequency.equalsIgnoreCase("3")){
		    	 
		    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
					
					while(rs1.next()) {
						monthDiff=rs1.getString("monthdiff");
					} 
					
					String sqls1 = "select ("+monthDiff+"/3) monthdifference";
					ResultSet rs2 = stmtProfitLoss.executeQuery(sqls1);
					
					while(rs2.next()) {
						txtfrequency=rs2.getInt("monthdifference");
					} 
		    	    
					xsqls= "3 Month";
					
		     }else if (cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){

		    	 	/*String sqls = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";*/
					String sqls = "select (YEAR('"+sqlToDate+"')-YEAR('"+sqlFromDate+"'))+1 yeardiff";
		    	 	ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("yeardiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
		     }
		     
		     	if(cmbfrequency.equalsIgnoreCase("1")){
					analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+") analysisDate,DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+"),'%d-%m-%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y') analysingDate";
					   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
					   
					   while(rs.next()){
						     analysisDate=rs.getDate("analysisDate");
						     analysingDate=rs.getString("analysisDates");
						     analysingToDate=rs.getString("analysingDate");
								
						     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	   analysisDate=sqlToDate;
						    	   analysingDate=analysingToDate;
						      }
						     
						     amountLength=amountLength+1;
						     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
					     }

					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
		     	}
		     
		     	else if(cmbfrequency.equalsIgnoreCase("2")){
		     	
		     	analysisDate=sqlFromDate;
				for(int i=0;i<=txtfrequency;i++)
				{
				   
				   if(i==0){
					   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
					   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
					   
					   while(rs.next()){
						     analysisDate=rs.getDate("analysisDate");
						     analysingDate=rs.getString("analysisDates");
						     
						     amountLength=amountLength+1;
						     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
					     }
					}else{
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
						   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
						   
						   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
		
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
								     amountLength=amountLength+1;  
								     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
							         analysisDate=analysisToDate;
						     }
					   }
				   
				     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
				    	 break;
				     }
				}
				
		     }
		     
		     	else if(cmbfrequency.equalsIgnoreCase("3")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%b %Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%b %Y')) analysisDates";
						   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
							     
							     amountLength=amountLength+1;
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
						     }
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
							   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
									    
								     amountLength=amountLength+1;
									 analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
								     analysisDate=analysisToDate;
							     }
						   }
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
			     }
		     	
		     	else if(cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){
		     		
		     		analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   String sqls = "SELECT YEAR('"+analysisDate+"') year";
						   ResultSet rs1 = stmtProfitLoss.executeQuery(sqls);
						   
						   int year=0;
						   while(rs1.next()){
							    year=rs1.getInt("year");
						   }
						   
						   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
						   ResultSet rss = stmtProfitLoss.executeQuery(sqls1);
						   
						   int noOfMonths=0;
						   while(rss.next()){
							     noOfMonths=rss.getInt("noofmonths");
						   }
						   
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
						   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     amountLength=amountLength+1;
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
						     }
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
									+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
							   
							   ResultSet rs = stmtProfitLoss.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
									     amountLength=amountLength+1;
									     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
								         analysisDate=analysisToDate;
							     }
						   }
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
		     	}
		     	
			 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
			 ArrayList<String> revenueamtarray=new ArrayList<String>();
			 ArrayList<String> directcostamtarray=new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",revenueamt="",directcostamt="",grossprofit="",
					 otherincomeamt="",indirectexpensesamt="",revenueamttotal="",directcostamttotal="",grossprofittotal="",otherincomeamttotal="",indirectexpensesamttotal="";
			 
			 String sqlprofitfinal="select id, description, dramount, total, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, gp_id, ordno, parentid, groupno, subac, code from profitandlossanalysis where entrydate='"+entrydate+"'";  
			 ResultSet resultSet = stmtProfitLoss.executeQuery(sqlprofitfinal);
			 while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					
					masterid=resultSet.getString("parentid");
					
					if(childid!=masterid){
						//System.out.println("masterid="+masterid);
						if(masterid==null){  
							parentid=null;
							masterparentid=resultSet.getString("id");
							
						}else if(masterid.equalsIgnoreCase("3")){
							parentid=masterparentid;
							childparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("4")){
							parentid=childparentid;
							subchildparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("6")){
							parentid=subchildparentid;
						}
							
						 childid=masterid;
					}
					
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
						revenueamttotal=resultSet.getString("total");
					}  
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
						directcostamttotal=resultSet.getString("total");
					}
					 if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21") && parentid==null){
						temp.add("Group II");
						temp.add("GROSS PROFIT");
						//temp.add(resultSet.getString("total"));
	                    grossprofittotal=String.valueOf((revenueamttotal.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamttotal))-(directcostamttotal.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamttotal)));
					    temp.add(grossprofittotal);   
					}else{
						temp.add(resultSet.getString("code"));
						temp.add(resultSet.getString("description"));
						temp.add(resultSet.getString("total"));
					} 
					
					for (int l = 0; l < amountLength; l++) {
						
						if(masterid==null){  
							parentid=null;
							masterparentid=resultSet.getString("id");
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamtarray.add(resultSet.getString("amount"+l+""));
							}
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamtarray.add(resultSet.getString("amount"+l+""));
							}
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamt=resultSet.getString("amount"+l+"");
							}
							
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamt=resultSet.getString("amount"+l+"");
							}
							
					}
						
					if(resultSet.getString("gp_id").trim().equalsIgnoreCase("21")){
						if(parentid==null){
							if(revenueamtarray.size()>0){
								revenueamt=revenueamtarray.get(l);
							}
							if(directcostamtarray.size()>0){
								directcostamt=directcostamtarray.get(l);
							}
							grossprofit=String.valueOf((revenueamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamt))-(directcostamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamt)));
							temp.add(grossprofit.trim().equalsIgnoreCase("0.0")?"0":grossprofit);    
						}
					}else{
				    	 temp.add(resultSet.getString("amount"+l+"").equalsIgnoreCase("") || resultSet.getString("amount"+l+"")==null?"0":resultSet.getString("amount"+l+""));  
				     }
					
				}
					
					analysisrowarray.add(temp);
			 
			  }
			 //System.out.println("Excel--->>>"+analysisrowarray);   
				RESULTDATA=convertArrayToExcel(analysisrowarray,cmbfrequency);
				
			 }
			 stmtProfitLoss.close();
			 conn.close();
			 
			}catch(Exception e){   
			    e.printStackTrace();
			    conn.close();
		  }
		 //System.out.println("data = "+RESULTDATA);
		 return RESULTDATA;
     }
	
    }         


