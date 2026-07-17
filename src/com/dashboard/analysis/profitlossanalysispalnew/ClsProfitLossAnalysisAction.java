package com.dashboard.analysis.profitlossanalysispalnew; 

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.text.SimpleDateFormat;  
import java.util.Date; 

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsProfitLossAnalysisAction extends ActionSupport{
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
    
	ClsProfitLossAnalysis profitlossDAO= new ClsProfitLossAnalysis();  
	
	private Map<String, Object> param=null;
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String entrydate = request.getParameter("entrydate");	
		String branchval = request.getParameter("branchval");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String cmbfrequency = request.getParameter("frequencytype");
		String noOfDays = request.getParameter("noofdays");    
		int amountlen = request.getParameter("amountlen")=="" || request.getParameter("amountlen")==null?0:Integer.parseInt(request.getParameter("amountlen").toString());        
		String printsql="",path1="",brhid="",amount1="";  
		 java.sql.Date sqlFromDate = null;
	     java.sql.Date sqlToDate = null;
	     java.sql.Date analysisDate=null;  
	     java.sql.Date analysisFromDate=null;
	     java.sql.Date analysisToDate=null;
	     String analysingDate="",analysingToDate="";
	     int amountLength=0,txtfrequency=0;  
	     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
                sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
            }
            if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
                sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
            }
            if(branchval.equalsIgnoreCase("") || branchval.equalsIgnoreCase("a")) {
         		brhid="1";
         	 }else {
         		brhid=branchval;      
         	 }
		//profitlossBean=profitlossDAO.getPrint(request,branchval,fromdate,todate);  
		
		if(ClsCommon.getBIBPrintPath("PLA").contains(".jrxml")==true)  
		{
			 HttpServletResponse response = ServletActionContext.getResponse();
			 Connection conn = null;
			
			 try {
				 param = new HashMap();
			
		      	 conn = ClsConnection.getMyConnection();
             	 String reportFileName = ClsCommon.getBIBPrintPath("PLA");
             	 Statement profitloss =conn.createStatement();
                 
             	 printsql="";  
             	 System.out.println("amountlen========"+amountlen);    
             	String xsql="",xsqls="";
   		     String sql = "",sql1 = "",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="";
   		     String dayDiff="",monthDiff="";

   		     if(cmbfrequency.equalsIgnoreCase("1")){
   		    		 String sqls = "select DATEDIFF('"+sqlToDate+"', '"+sqlFromDate+"') daydiff";
   		    		 ResultSet rs1 = profitloss.executeQuery(sqls);  
   		 			
   		 			while(rs1.next()) {
   		 				dayDiff=rs1.getString("daydiff");
   		 			} 
   		 			
   		 			String sqls1 = "select ("+dayDiff+"/"+noOfDays+") daydifference";
   		 			ResultSet rs2 = profitloss.executeQuery(sqls1);
   		 			
   		 			while(rs2.next()) {
   		 				txtfrequency=rs2.getInt("daydifference");
   		 			} 

   		    		 xsqls=Integer.parseInt(noOfDays) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");	
   				
   		     }else if(cmbfrequency.equalsIgnoreCase("2")){
   		    	 
   		    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
   		    	    ResultSet rs1 = profitloss.executeQuery(sqls);
   					
   					while(rs1.next()) {
   						txtfrequency=rs1.getInt("monthdiff");
   					} 
   					
   					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
   					
   		     }else if(cmbfrequency.equalsIgnoreCase("3")){
   		    	 
   		    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
   		    	    ResultSet rs1 = profitloss.executeQuery(sqls);
   					
   					while(rs1.next()) {
   						monthDiff=rs1.getString("monthdiff");
   					} 
   					
   					String sqls1 = "select ("+monthDiff+"/3) monthdifference";
   					ResultSet rs2 = profitloss.executeQuery(sqls1);
   					
   					while(rs2.next()) {
   						txtfrequency=rs2.getInt("monthdifference");
   					} 
   		    	    
   					xsqls= "3 Month";
   					
   		     }else if (cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){

   					String sqls = "select (YEAR('"+sqlToDate+"')-YEAR('"+sqlFromDate+"'))+1 yeardiff";
   		    	 	ResultSet rs1 = profitloss.executeQuery(sqls);
   					
   					while(rs1.next()) {
   						txtfrequency=rs1.getInt("yeardiff");
   					} 
   					
   					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
   		     }
   			 
   			 
   	System.out.println("txtfrequency==="+txtfrequency);  
   		     	if(cmbfrequency.equalsIgnoreCase("1")){
   					analysisDate=sqlFromDate;
   					for(int i=0;i<=txtfrequency;i++)
   					{
   					   
   					   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+") analysisDate,DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+xsqls+"),'%d-%m-%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y') analysingDate";
   					   ResultSet rs = profitloss.executeQuery(xsql);
   					   
   					   while(rs.next()){
   						     analysisDate=rs.getDate("analysisDate");
   						     analysingDate=rs.getString("analysisDates");
   						     analysingToDate=rs.getString("analysingDate");
   								
   						     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
   						    	   analysisDate=sqlToDate;
   						    	   analysingDate=analysingToDate;
   						      }
   						    param.put("amount"+(i+1), analysingDate);      
   						     
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
   					   ResultSet rs = profitloss.executeQuery(xsql);
   					   
   					   while(rs.next()){
   						     analysisDate=rs.getDate("analysisDate");
   						     analysingDate=rs.getString("analysisDates");
   						     param.put("amount"+(i+1), analysingDate);
   					     }
   					}else{
   						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
   						   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
   						   
   						   ResultSet rs = profitloss.executeQuery(xsql);
   						   
   						   while(rs.next()){
   							     analysisFromDate=rs.getDate("analysisFromDate");
   							     analysisToDate=rs.getDate("analysisToDate");
   							     analysingDate=rs.getString("analysisDates");
   							     analysingToDate=rs.getString("analysingDate");
   		
   							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
   							    	   analysisToDate=sqlToDate;
   							    	   analysingDate=analysingToDate;
   							      }
   								     param.put("amount"+(i+1), analysingDate);
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
   						   ResultSet rs = profitloss.executeQuery(xsql);
   						   
   						   while(rs.next()){
   							     analysisDate=rs.getDate("analysisDate");
   							     analysingDate=rs.getString("analysisDates");
   							    param.put("amount"+(i+1), analysingDate);
   						     }
   						}else{
   							   
   							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
   							   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
   							   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
   							   ResultSet rs = profitloss.executeQuery(xsql);
   							   
   							   while(rs.next()){
   								     analysisFromDate=rs.getDate("analysisFromDate");
   								     analysisToDate=rs.getDate("analysisToDate");
   								     analysingDate=rs.getString("analysisDates");
   								     analysingToDate=rs.getString("analysingDate");
   			
   								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
   								    	   analysisToDate=sqlToDate;
   								    	   analysingDate=analysingToDate;
   								      }
   									     param.put("amount"+(i+1), analysingDate);
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
   						   ResultSet rs1 = profitloss.executeQuery(sqls);
   						   
   						   int year=0;
   						   while(rs1.next()){
   							    year=rs1.getInt("year");
   						   }
   						   
   						   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
   						   ResultSet rss = profitloss.executeQuery(sqls1);
   						   
   						   int noOfMonths=0;
   						   while(rss.next()){
   							     noOfMonths=rss.getInt("noofmonths");
   						   }
   						   
   						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
   						   ResultSet rs = profitloss.executeQuery(xsql);
   						   
   						   while(rs.next()){
   							     analysisDate=rs.getDate("analysisDate");
   							     analysingDate=rs.getString("analysisDates");
   		
   							    param.put("amount"+(i+1), analysingDate);
   						     }
   						}else{
   							   
   							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
   									+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
   							   
   							   ResultSet rs = profitloss.executeQuery(xsql);
   							   
   							   while(rs.next()){
   								     analysisFromDate=rs.getDate("analysisFromDate");
   								     analysisToDate=rs.getDate("analysisToDate");
   								     analysingDate=rs.getString("analysisDates");
   								     analysingToDate=rs.getString("analysingDate");
   			
   								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
   								    	   analysisToDate=sqlToDate;
   								    	   analysingDate=analysingToDate;
   								      }
   									     param.put("amount"+(i+1), analysingDate);
   								         analysisDate=analysisToDate;
   							     }
   						   }
   					   
   					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){  
   					    	 break;
   					     }
   					}
   		     	}  		 
             	 
   		       String sqltest="";
          	   if(branchval.equalsIgnoreCase("") || branchval.equalsIgnoreCase("a")) {
          		sqltest+=" and mainbranch=1";
          	    }else {
          		sqltest+=" and doc_no='"+branchval+"'";     
          	   }
          	    String strsql2="select imgpath from my_brch where 1=1 "+sqltest+"";             
	    	     ResultSet rs2=profitloss.executeQuery(strsql2);          
	    	     while(rs2.next()){         
	    	    	 path1=rs2.getString("imgpath");         
	    	     }
             	 String imgpath=request.getSession().getServletContext().getRealPath(path1);
               	 imgpath=imgpath.replace("\\", "\\\\");
               	 
               	String amtssql1="select format(total,2) total, format(amount0,2) amount0, format(amount1,2) amount1, format(amount2,2) amount2, format(amount3,2) amount3, format(amount4,2) amount4, format(amount5,2) amount5, format(amount6,2) amount6, format(amount7,2) amount7, format(amount8,2) amount8, format(amount9,2) amount9, format(amount10,2) amount10, format(amount11,2) amount11 from profitandlossanalysis where description='GROSS PROFIT'  and entrydate='"+entrydate+"'";   
               	System.out.println("amtssql1="+amtssql1);
               	 ResultSet amtsrs1=profitloss.executeQuery(amtssql1);              
	    	     while(amtsrs1.next()){         
	    	    	 param.put("grossamt1", amtsrs1.getString("amount0"));  
	    	    	 param.put("grossamt2", amtsrs1.getString("amount1")); 
	    	    	 param.put("grossamt3", amtsrs1.getString("amount2")); 
	    	    	 param.put("grossamt4", amtsrs1.getString("amount3")); 
	    	    	 param.put("grossamt5", amtsrs1.getString("amount4")); 
	    	    	 param.put("grossamt6", amtsrs1.getString("amount5")); 
	    	    	 param.put("grossamt7", amtsrs1.getString("amount6")); 
	    	    	 param.put("grossamt8", amtsrs1.getString("amount7")); 
	    	    	 param.put("grossamt9", amtsrs1.getString("amount8")); 
	    	    	 param.put("grossamt10", amtsrs1.getString("amount9")); 
	    	    	 param.put("grossamt11", amtsrs1.getString("amount10")); 
	    	    	 param.put("grossamt12", amtsrs1.getString("amount11")); 
	    	    	 param.put("grosstot", amtsrs1.getString("total")); 
	    	     }
               	 
	    	     String amtssql2="select format(total,2) total, format(amount0,2) amount0, format(amount1,2) amount1, format(amount2,2) amount2, format(amount3,2) amount3, format(amount4,2) amount4, format(amount5,2) amount5, format(amount6,2) amount6, format(amount7,2) amount7, format(amount8,2) amount8, format(amount9,2) amount9, format(amount10,2) amount10, format(amount11,2) amount11 from profitandlossanalysis where trim(description)='NET PROFIT / (LOSS)'  and entrydate='"+entrydate+"'";    
	    	     System.out.println("amtssql2="+amtssql2);    
	    	     ResultSet amtsrs2=profitloss.executeQuery(amtssql2);          
	    	     while(amtsrs2.next()){               
	    	    	 param.put("netamt1", amtsrs2.getString("amount0"));   
	    	    	 param.put("netamt2", amtsrs2.getString("amount1")); 
	    	    	 param.put("netamt3", amtsrs2.getString("amount2")); 
	    	    	 param.put("netamt4", amtsrs2.getString("amount3")); 
	    	    	 param.put("netamt5", amtsrs2.getString("amount4")); 
	    	    	 param.put("netamt6", amtsrs2.getString("amount5")); 
	    	    	 param.put("netamt7", amtsrs2.getString("amount6")); 
	    	    	 param.put("netamt8", amtsrs2.getString("amount7")); 
	    	    	 param.put("netamt9", amtsrs2.getString("amount8")); 
	    	    	 param.put("netamt10", amtsrs2.getString("amount9")); 
	    	    	 param.put("netamt11", amtsrs2.getString("amount10")); 
	    	    	 param.put("netamt12", amtsrs2.getString("amount11")); 
	    	    	 param.put("nettot", amtsrs2.getString("total")); 
	    	     }

	    	     String amtssql3="select format(sum(coalesce(total,0)),2) total, format(sum(coalesce(amount0,0)),2) amount0, format(sum(coalesce(amount1,0)),2) amount1, format(sum(coalesce(amount2,0)),2) amount2, format(sum(coalesce(amount3,0)),2) amount3, format(sum(coalesce(amount4,0)),2) amount4, format(sum(coalesce(amount5,0)),2) amount5, format(sum(coalesce(amount6,0)),2) amount6, format(sum(coalesce(amount7,0)),2) amount7, format(sum(coalesce(amount8,0)),2) amount8, format(sum(coalesce(amount9,0)),2) amount9, format(sum(coalesce(amount10,0)),2) amount10, format(sum(coalesce(amount11,0)),2) amount11 from profitandlossanalysis p left join my_head h on p.subac=h.doc_no where h.gr_type=4 and entrydate='"+entrydate+"'";    
	    	     System.out.println("amtssql3="+amtssql3);    
	    	     ResultSet amtsrs3=profitloss.executeQuery(amtssql3);          
	    	     while(amtsrs3.next()){         
	    	    	 param.put("expamt1", amtsrs3.getString("amount0"));  
	    	    	 param.put("expamt2", amtsrs3.getString("amount1")); 
	    	    	 param.put("expamt3", amtsrs3.getString("amount2")); 
	    	    	 param.put("expamt4", amtsrs3.getString("amount3")); 
	    	    	 param.put("expamt5", amtsrs3.getString("amount4")); 
	    	    	 param.put("expamt6", amtsrs3.getString("amount5")); 
	    	    	 param.put("expamt7", amtsrs3.getString("amount6")); 
	    	    	 param.put("expamt8", amtsrs3.getString("amount7")); 
	    	    	 param.put("expamt9", amtsrs3.getString("amount8")); 
	    	    	 param.put("expamt10", amtsrs3.getString("amount9")); 
	    	    	 param.put("expamt11", amtsrs3.getString("amount10")); 
	    	    	 param.put("expamt12", amtsrs3.getString("amount11")); 
	    	    	 param.put("exptot", amtsrs3.getString("total"));       
	    	     }
	    	     
               	 param.put("amountlen", amountlen);
               	 param.put("brhid", branchval);    
		         param.put("imgpal", imgpath);  
		         param.put("puser", session.getAttribute("USERNAME"));
		         param.put("printsql", printsql); 
		         param.put("fromdate", fromdate); 
		         param.put("todate", todate); 
		         param.put("entrydate", entrydate); 
		         SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
		         Date date = new Date();  
		         System.out.println(formatter.format(date));  
		         param.put("printdate", formatter.format(date));     
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName)); 
         	 
                JasperReport jasperReport = JasperCompileManager.compileReport(design);
                generateReportPDF(response, param, jasperReport, conn);
                             
          
                 } catch (Exception e) {
                     e.printStackTrace();
                 } finally{
                	 conn.close();
                 }	   	 
		}

		return "print";
	}
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
 		  byte[] bytes = null;
         bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
           resp.reset();
         resp.resetBuffer();
         
         resp.setContentType("application/pdf");
         resp.setContentLength(bytes.length);
         ServletOutputStream ouputStream = resp.getOutputStream();
         ouputStream.write(bytes, 0, bytes.length);
         ouputStream.flush();
         ouputStream.close();
      
              
     }
		
	
}