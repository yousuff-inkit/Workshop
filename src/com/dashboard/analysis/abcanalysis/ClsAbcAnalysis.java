package com.dashboard.analysis.abcanalysis;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAbcAnalysis  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray abcAnalysisGrid(String branch,String fromdate,String todate,String rptType,String summaryType, String hidclientcat,
			String hidclient, String hidclientslm, String hidclientstatus, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 JSONArray COLUMNGROUPDATA=new JSONArray();

		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtClientAnalysis = conn.createStatement();
			
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
					   ResultSet rs = stmtClientAnalysis.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlFromDate=rs.getDate("today");
					   }
		         }

			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		         }else if(todate.equalsIgnoreCase("0")){
		        	   String sqldate= "select CURDATE() today";
					   ResultSet rs = stmtClientAnalysis.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlToDate=rs.getDate("today");
					   }
		         }
			     
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     ArrayList<String> analysiscolumngrouparray= new ArrayList<String>();
			     
			     analysiscolumnarray.add("Sr No.::id::center::center:: ::5%:: :: :: :: ");
			     analysiscolumnarray.add("Ref No.::refno::center::center:: ::5%:: ::headClass:: :: ");
			     
			     if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("CAT")){
			    	 analysiscolumnarray.add("Category Name::refname::left::left:: ::25%:: ::headClass:: :: ");
			     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("SLM")){
			    	 analysiscolumnarray.add("Salesman Name::refname::left::left:: ::25%:: ::headClass:: :: ");
			     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("PCASE")){
			    	 analysiscolumnarray.add("Status Name::refname::left::left:: ::25%:: ::headClass:: :: ");
			     } else {
			    	 analysiscolumnarray.add("Client Name::refname::left::left:: ::25%:: ::headClass:: :: ");
			     }
			     
			     analysiscolumnarray.add("Opening::opn::right::right:: ::8%::d2::openingClass:: ::['sum']");
			     
			    String xsql="",sql = "",sql1 = "",sql2="",sql3="",sql4="",sql5="";

	    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
	    	    ResultSet rs1 = stmtClientAnalysis.executeQuery(sqls);
				
				while(rs1.next()) {
					txtfrequency=rs1.getInt("monthdiff");
				} 
			    
				if(rptType.equalsIgnoreCase("1")){
					
					analysisDate=sqlFromDate;
					
					for(int m=0;m<=txtfrequency;m++){
						 if(m==0){
							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
							   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     
								     analysiscolumnarray.add(""+analysingDate+"::invoice"+m+"::right::right:: ::8%::d2::invoiceClass::invoicegroup::['sum']");
							   }
							   
						   }else{
						   
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
						   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
    
						   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
							     
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
								   
								  analysiscolumnarray.add(""+analysingDate+"::invoice"+m+"::right::right:: ::8%::d2::invoiceClass::invoicegroup::['sum']");
								   
								  analysisDate=analysisToDate;
						   }
						}
						 
						 if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
							 analysiscolumnarray.add("Total::totalinvoice::right::right:: ::7%::d2::totalClass::invoicegroup::['sum']");
					    	 break;
					     }
					}
					
					analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
						   
						   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql1+="if(sum(invoice"+i+")=0,'',round(sum(invoice"+i+"),2)) invoice"+i+",if(sum(receipt"+i+")=0,'',round(sum(receipt"+i+")*-1,2)) receipt"+i+",";
							     
							     sql2+="if(b.date>='"+sqlFromDate+"' and b.date<='"+analysisDate+"' ,round(b.invoice,2),'') invoice"+i+",";
							     
							     sql2+="if(b.date>='"+sqlFromDate+"' and b.date<='"+analysisDate+"' ,round(b.receipt,2),'') receipt"+i+",";
							     
							     sql3+="round(0,2) invoice"+i+",round(0,2) receipt"+i+",";
							     
							     amountLength=amountLength+1;
							     
							     analysiscolumnarray.add(""+analysingDate+"::receipt"+i+"::right::right:: ::8%::d2::receiptClass::receiptgroup::['sum']");
							     
						     }
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
							   
							   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }


								     	 sql1+="if(sum(invoice"+i+")=0,'',round(sum(invoice"+i+"),2)) invoice"+i+",if(sum(receipt"+i+")=0,'',round(sum(receipt"+i+")*-1,2)) receipt"+i+",";
									     
								     	 sql2+="if(b.date>='"+analysisFromDate+"' and b.date<='"+analysisToDate+"' ,round(b.invoice,2),'') invoice"+i+",";
									     
									     sql2+="if(b.date>='"+analysisFromDate+"' and b.date<='"+analysisToDate+"' ,round(b.receipt,2),'') receipt"+i+",";
		
									     sql3+="round(0,2) invoice"+i+",round(0,2) receipt"+i+",";
									     
									     amountLength=amountLength+1;
					
									     analysiscolumnarray.add(""+analysingDate+"::receipt"+i+"::right::right:: ::8%::d2::receiptClass::receiptgroup::['sum']");
								 
								         analysisDate=analysisToDate;
							     }
						   }
					   
					     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 analysiscolumnarray.add("Total::totalreceipt::right::right:: ::7%::d2::totalClass::receiptgroup::['sum']");
					    	 break;
					     }
					}
					
					 analysiscolumngrouparray.add("Sales::center::50%::invoicegroup");
				     
				     analysiscolumngrouparray.add("Collection::center::50%::receiptgroup");
				     
				}
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			     sql4=" and j.brhid in ("+branch+")";
			 }
			
		     if(!hidclient.equalsIgnoreCase("")){
				 sql4+=" and h.cldocno in ("+hidclient+")";
			 }

		     if(!hidclientcat.equalsIgnoreCase("")){
		    	 sql5+=" and ac.catid in ("+hidclientcat+")";
			 }
		     
		     if(!hidclientslm.equalsIgnoreCase("")){
		    	 sql5+=" and ac.sal_id in ("+hidclientslm+")";
			 }
			 
			 if(!hidclientstatus.equalsIgnoreCase("")){
		    	 sql5+=" and ac.pcase in ("+hidclientstatus+")";
			 }
		     
		     if(rptType.equalsIgnoreCase("1")){
		    	 
		     /*sql = "select @i:=@i+1 id,f.* from (select b.cldocno,b.refname,b.acno refno,b.dtype,if(sum(b.opn)=0,'',sum(b.opn)) opn,if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',"
		     		+ "(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))) balance,if(sum(b.totalinvoice)=0,'',sum(b.totalinvoice)) totalinvoice,if(sum(b.totalreceipt)=0,'',sum(b.totalreceipt)*-1) totalreceipt,"+sql1+""
		     		+ "(if((sum(b.totalinvoice)/("+txtfrequency+"+1))=0,'',(sum(b.totalinvoice)/("+txtfrequency+"+1)))) salesaverage,(if((sum(b.totalreceipt)/("+txtfrequency+"+1))=0,'',(sum(b.totalreceipt)/("+txtfrequency+"+1))*-1)) collectionaverage,"
		     		+ "if(((sum(b.totalinvoice)/("+txtfrequency+"+1))-((sum(b.totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',((sum(b.totalinvoice)/("+txtfrequency+"+1))-((sum(b.totalreceipt)/("+txtfrequency+"+1))*-1))) creditaverage,b.date from ( select a.acno,a.cldocno,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,"
		     		+ "if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalinvoice,if(a.date>='"+sqlFromDate+"' "
		     		+ "and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,"+sql2+"a.date from ("
		     		+ "select j.acno,j.dramount,j.dtype,j.date,c.refname,c.cldocno from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' where h.atype='AR' and j.status=3 and c.status=3 and  j.date<='"+sqlToDate+"'"+sql3+") a) "
		     		+ "b group by acno order by acno) f,(SELECT @i:= 0) as i";*/
		    	 
		    	 sql = "select @i:=@i+1 id,f.* from (select cldocno, description refname, acno refno, dtype,if(sum(opn)=0,'',sum(opn)) opn,if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)) balance,"  
			    	 + "if(sum(totalinvoice)=0,'',round(sum(totalinvoice),2)) totalinvoice,if(sum(totalreceipt)=0,'',round(sum(totalreceipt)*-1,2)) totalreceipt,"+sql1+"(if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))) salesaverage,"
			    	 + "(if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))) collectionaverage,if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-"
			    	 + "((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)) creditaverage,date from ( " 
			    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
			    	 + ""+sql2+"b.* from ( select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
			    	 + "select j.acno,j.dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno where h.atype='AR' and j.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
			    	 + "union all " 
			    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,"+sql3+"round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,0 catid,0 sal_id,0 pcase from my_jvtran j " 
			    	 + "inner join my_head h on j.acno=h.doc_no where h.atype='AR' and j.status=3 and j.date<'"+sqlFromDate+"'"+sql4+" group by acno) c group by c.acno order by c.acno ) f,(SELECT @i:= 0) as i";
		    
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("CRM")){
		    	 
		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
			       
				   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
		    	 
			     analysiscolumnarray.add(""+analysingDate+"::invoice0::right::right:: ::12%::d2::invoiceClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalinvoice::right::right:: ::8%::d2::totalClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add(""+analysingDate+"::receipt0::right::right:: ::12%::d2::receiptClass::receiptgroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalreceipt::right::right:: ::8%::d2::totalClass::receiptgroup::['sum']");
			     
			     analysiscolumngrouparray.add("Sales::center::50%::invoicegroup");
			     
			     analysiscolumngrouparray.add("Collection::center::50%::receiptgroup");
			     
		     /*sql = "select @i:=@i+1 id,f.* from (select b.cldocno,b.refname,b.acno refno,b.dtype,if(sum(b.opn)=0,'',sum(b.opn)) opn,if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',"
		     		+ "(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))) balance,if(sum(b.totalinvoice)=0,'',sum(b.totalinvoice)) totalinvoice,if(sum(b.totalreceipt)=0,'',sum(b.totalreceipt)*-1) totalreceipt,"
		     		+ "if(sum(b.invoice0)=0,'',sum(b.invoice0)) invoice0,if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1) receipt0,(if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))) salesaverage,"
		     		+ "(if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',(sum(b.totalreceipt)/"+txtfrequency+")*-1)) collectionaverage,if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		+ "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))) creditaverage,b.date from ( "
		     		+ "select a.acno,a.refname,a.cldocno,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype IN ('INV','DNO','CNO','INS','INT'),"
		     		+ "round(a.dramount,2),'') totalinvoice,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' "
		     		+ "and a.date<='"+sqlToDate+"' and a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
		     		+ "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.refname,c.cldocno from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' where "
		     		+ "h.atype='AR' and j.status=3 and c.status=3 and j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) group by acno order by acno) f,(SELECT @i:= 0) as i";*/
		     
		     
		     sql = "select @i:=@i+1 id,f.* from (select cldocno, description refname, acno refno, dtype,if(sum(opn)=0,'',sum(opn)) opn,if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)) balance,"  
			    	 + "if(sum(totalinvoice)=0,'',round(sum(totalinvoice),2)) totalinvoice,if(sum(totalreceipt)=0,'',round(sum(totalreceipt)*-1,2)) totalreceipt,if(sum(invoice0)=0,'',sum(invoice0)) invoice0,if(sum(receipt0)=0,'',sum(receipt0)*-1) receipt0,"
		    		 + "(if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))) salesaverage,(if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))) collectionaverage,"
		    		 + "if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)) creditaverage,date from ( "
			    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
			    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
			    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
			    	 + "select j.acno,j.dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno where h.atype='AR' and j.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
			    	 + "union all " 
			    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,0 catid,0 sal_id,0 pcase from my_jvtran j " 
			    	 + "inner join my_head h on j.acno=h.doc_no where h.atype='AR' and j.status=3 and j.date<'"+sqlFromDate+"'"+sql4+" group by acno) c group by c.acno order by c.acno ) f,(SELECT @i:= 0) as i";

		     txtfrequency=0;
		     
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("CAT")){

		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
				   
			       ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
				   
			     analysiscolumnarray.add(""+analysingDate+"::invoice0::right::right:: ::12%::d2::invoiceClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalinvoice::right::right:: ::8%::d2::totalClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add(""+analysingDate+"::receipt0::right::right:: ::12%::d2::receiptClass::receiptgroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalreceipt::right::right:: ::8%::d2::totalClass::receiptgroup::['sum']");
			     
			     analysiscolumngrouparray.add("Sales::center::50%::invoicegroup");
			     
			     analysiscolumngrouparray.add("Collection::center::50%::receiptgroup");
			     
		     /*sql = "select @i:=@i+1 id,f.* from (select b.catid refno,b.refname,b.dtype,if(sum(b.opn)=0,'',sum(b.opn)) opn,if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',"
		     		+ "(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))) balance,if(sum(b.totalinvoice)=0,'',sum(b.totalinvoice)) totalinvoice,if(sum(b.totalreceipt)=0,'',sum(b.totalreceipt)*-1) totalreceipt,"
		     		+ "if(sum(b.invoice0)=0,'',sum(b.invoice0)) invoice0,if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1) receipt0,(if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))) salesaverage,"
		     		+ "(if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',(sum(b.totalreceipt)/"+txtfrequency+")*-1)) collectionaverage,if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		+ "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))) creditaverage,b.date from ( "
		     		+ "select a.catid,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') "
		     		+ "totalinvoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and "
		     		+ "a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
		     		+ "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.catid,ct.cat_name refname from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' "
		     		+ "inner join my_clcatm ct on c.catid=ct.doc_no and ct.dtype='CRM' where h.atype='AR' and j.status=3 and c.status=3 and j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) "
		     		+ "group by catid order by catid) f,(SELECT @i:= 0) as i";*/

			     sql = "select @i:=@i+1 id,f.* from (select cldocno, description refname, catid refno, dtype,if(sum(opn)=0,'',sum(opn)) opn,if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)) balance,"  
			    	 + "if(sum(totalinvoice)=0,'',round(sum(totalinvoice),2)) totalinvoice,if(sum(totalreceipt)=0,'',round(sum(totalreceipt)*-1,2)) totalreceipt,if(sum(invoice0)=0,'',sum(invoice0)) invoice0,if(sum(receipt0)=0,'',sum(receipt0)*-1) receipt0,"
		    		 + "(if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))) salesaverage,(if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))) collectionaverage,"
		    		 + "if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)) creditaverage,date from ( "
			    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
			    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
			    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
			    	 + "select j.acno,j.dramount,j.dtype,j.date,ct.cat_name description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clcatm ct on (ac.catid=ct.doc_no and ct.dtype='CRM') "
			    	 + "where h.atype='AR' and j.status=3 and ct.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
			    	 + "union all " 
			    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j " 
			    	 + "inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clcatm ct on (ac.catid=ct.doc_no and ct.dtype='CRM') where h.atype='AR' and j.status=3 and ct.status=3 and j.date<'"+sqlFromDate+"'"+sql4+""+sql5+" group by acno) c group by c.catid order by c.catid ) f,(SELECT @i:= 0) as i";
			     
		     txtfrequency=0;
		     
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("SLM")){

		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
				   
			       ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
				   
			     analysiscolumnarray.add(""+analysingDate+"::invoice0::right::right:: ::12%::d2::invoiceClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalinvoice::right::right:: ::8%::d2::totalClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add(""+analysingDate+"::receipt0::right::right:: ::12%::d2::receiptClass::receiptgroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalreceipt::right::right:: ::8%::d2::totalClass::receiptgroup::['sum']");
			     
			     analysiscolumngrouparray.add("Sales::center::50%::invoicegroup");
			     
			     analysiscolumngrouparray.add("Collection::center::50%::receiptgroup");
			     
		     /*sql = "select @i:=@i+1 id,f.* from (select b.sal_id refno,b.refname,b.dtype,if(sum(b.opn)=0,'',sum(b.opn)) opn,if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',"
		     		+ "(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))) balance,if(sum(b.totalinvoice)=0,'',sum(b.totalinvoice)) totalinvoice,if(sum(b.totalreceipt)=0,'',sum(b.totalreceipt)*-1) totalreceipt,"
		     		+ "if(sum(b.invoice0)=0,'',sum(b.invoice0)) invoice0,if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1) receipt0,(if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))) salesaverage,"
		     		+ "(if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',(sum(b.totalreceipt)/"+txtfrequency+")*-1)) collectionaverage,if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		+ "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))) creditaverage,b.date from ( "
		     		+ "select a.sal_id,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') "
		     		+ "totalinvoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and "
		     		+ "a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
		     		+ "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.sal_id,s.sal_name refname from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' "
		     		+ "inner join my_salm s on c.sal_id=s.doc_no where h.atype='AR' and j.status=3 and c.status=3 and j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) "
		     		+ "group by sal_id order by sal_id) f,(SELECT @i:= 0) as i";*/
		     
		     sql = "select @i:=@i+1 id,f.* from (select cldocno, description refname, sal_id refno, dtype,if(sum(opn)=0,'',sum(opn)) opn,if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)) balance,"  
			    	 + "if(sum(totalinvoice)=0,'',round(sum(totalinvoice),2)) totalinvoice,if(sum(totalreceipt)=0,'',round(sum(totalreceipt)*-1,2)) totalreceipt,if(sum(invoice0)=0,'',sum(invoice0)) invoice0,if(sum(receipt0)=0,'',sum(receipt0)*-1) receipt0,"
		    		 + "(if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))) salesaverage,(if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))) collectionaverage,"
		    		 + "if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)) creditaverage,date from ( "
			    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
			    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
			    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
			    	 + "select j.acno,j.dramount,j.dtype,j.date,s.sal_name description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_salm s on ac.sal_id=s.doc_no "
			    	 + "where h.atype='AR' and j.status=3 and s.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
			    	 + "union all " 
			    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j " 
			    	 + "inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_salm s on ac.sal_id=s.doc_no where h.atype='AR' and j.status=3 and s.status=3 and j.date<'"+sqlFromDate+"'"+sql4+""+sql5+" group by acno) c group by c.sal_id order by c.sal_id ) f,(SELECT @i:= 0) as i";

		     txtfrequency=0;
		     
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("PCASE")){

		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
				   
			       ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
				   
			     analysiscolumnarray.add(""+analysingDate+"::invoice0::right::right:: ::12%::d2::invoiceClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalinvoice::right::right:: ::8%::d2::totalClass::invoicegroup::['sum']");
			     
			     analysiscolumnarray.add(""+analysingDate+"::receipt0::right::right:: ::12%::d2::receiptClass::receiptgroup::['sum']");
			     
			     analysiscolumnarray.add("Total::totalreceipt::right::right:: ::8%::d2::totalClass::receiptgroup::['sum']");
			     
			     analysiscolumngrouparray.add("Sales::center::50%::invoicegroup");
			     
			     analysiscolumngrouparray.add("Collection::center::50%::receiptgroup");
			     
		     /*sql = "select @i:=@i+1 id,f.* from (select b.pcase refno,b.refname,b.dtype,if(sum(b.opn)=0,'',sum(b.opn)) opn,if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',"
		     		+ "(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))) balance,if(sum(b.totalinvoice)=0,'',sum(b.totalinvoice)) totalinvoice,if(sum(b.totalreceipt)=0,'',sum(b.totalreceipt)*-1) totalreceipt,"
		     		+ "if(sum(b.invoice0)=0,'',sum(b.invoice0)) invoice0,if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1) receipt0,(if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))) salesaverage,"
		     		+ "(if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',(sum(b.totalreceipt)/"+txtfrequency+")*-1)) collectionaverage,if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		+ "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))) creditaverage,b.date from ( "
		     		+ "select a.pcase,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') "
		     		+ "totalinvoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and "
		     		+ "a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
		     		+ "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.pcase,cl.clstatus refname from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' "
		     		+ "inner join my_clstatus cl on c.pcase=cl.doc_no where h.atype='AR' and j.status=3 and c.status=3 and j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) "
		     		+ "group by pcase order by pcase) f,(SELECT @i:= 0) as i";*/
		     
		     sql = "select @i:=@i+1 id,f.* from (select cldocno, description refname, pcase refno, dtype,if(sum(opn)=0,'',sum(opn)) opn,if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)) balance,"  
			    	 + "if(sum(totalinvoice)=0,'',round(sum(totalinvoice),2)) totalinvoice,if(sum(totalreceipt)=0,'',round(sum(totalreceipt)*-1,2)) totalreceipt,if(sum(invoice0)=0,'',sum(invoice0)) invoice0,if(sum(receipt0)=0,'',sum(receipt0)*-1) receipt0,"
		    		 + "(if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))) salesaverage,(if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))) collectionaverage,"
		    		 + "if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)) creditaverage,date from ( "
			    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
			    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
			    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
			    	 + "select j.acno,j.dramount,j.dtype,j.date,cl.clstatus description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clstatus cl on ac.pcase=cl.doc_no "
			    	 + "where h.atype='AR' and j.status=3 and cl.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
			    	 + "union all " 
			    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j " 
			    	 + "inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clstatus cl on ac.pcase=cl.doc_no where h.atype='AR' and j.status=3 and cl.status=3 and j.date<'"+sqlFromDate+"'"+sql4+""+sql5+" group by acno) c group by c.pcase order by c.pcase ) f,(SELECT @i:= 0) as i";

		     txtfrequency=0;
		     
		     }
		     
		     ResultSet resultSet = stmtClientAnalysis.executeQuery(sql);
		     
			 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();

				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					
					temp.add(resultSet.getString("id"));
					temp.add(resultSet.getString("refno"));
					temp.add(resultSet.getString("refname"));
					temp.add(resultSet.getString("opn"));
					
					for (int l = 0; l <= txtfrequency; l++) {
						temp.add(resultSet.getString("invoice"+l+""));
					}
					
					for (int l = 0; l <= txtfrequency; l++) {
						temp.add(resultSet.getString("receipt"+l+""));
					}
					
					temp.add(resultSet.getString("totalinvoice"));
					temp.add(resultSet.getString("totalreceipt"));
					temp.add(resultSet.getString("balance"));
					temp.add(resultSet.getString("salesaverage"));
					temp.add(resultSet.getString("collectionaverage"));
					temp.add(resultSet.getString("creditaverage"));
					
					analysisrowarray.add(temp);
				}
			
			 analysiscolumnarray.add("Balance::balance::right::right:: ::10%::d2::balanceClass:: ::['sum']");
			 
			 analysiscolumnarray.add("Avg. Sales [/ Month]::salesaverage::right::right:: ::10%::d2::averageClass:: ::['sum']");
			 
			 analysiscolumnarray.add("Avg. Collection [/Month]::collectionaverage::right::right:: ::10%::d2::averageClass:: ::['sum']");
			 
			 analysiscolumnarray.add("Avg. Credit::creditaverage::right::right:: ::10%::d2::averageClass:: ::['sum']");
			 
			 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
			 
			 COLUMNGROUPDATA=convertColumnGroupAnalysisArrayToJSON(analysiscolumngrouparray);

			 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray,txtfrequency);

			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(COLUMNGROUPDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;

			 }
			 
			 stmtClientAnalysis.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
       }
	
	
	public JSONArray abcAnalysisExcelExport(String branch,String fromdate,String todate,String rptType,String summaryType, String hidclientcat,
			String hidclient, String hidclientslm, String hidclientstatus, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtClientAnalysis = conn.createStatement();
			
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
		         }

			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		         }
			     
			    String xsql="",sql = "",sql1 = "",sql2="",sql3="",sql4="",sql5="",sql6="";

	    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
	    	    ResultSet rs1 = stmtClientAnalysis.executeQuery(sqls);
				
				while(rs1.next()) {
					txtfrequency=rs1.getInt("monthdiff");
				} 
			    
				if(rptType.equalsIgnoreCase("1")){
					
					analysisDate=sqlFromDate;
					
					for(int m=0;m<=txtfrequency;m++){
						 if(m==0){
							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
							   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     
							   }
							   
						   }else{
						   
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
						   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
    
						   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
							     
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
								   
								  analysisDate=analysisToDate;
						   }
						}
						 
						 if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
					analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
						   
						   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql1+="CONVERT(if(sum(invoice"+i+")=0,'',round(sum(invoice"+i+"),2)),CHAR(50)) 'SALES("+analysingDate+")',";
							     
							     sql6+="CONVERT(if(sum(receipt"+i+")=0,'',round(sum(receipt"+i+")*-1,2)),CHAR(50)) 'COLLECTION("+analysingDate+")',";
							     
							     sql2+="if(b.date>='"+sqlFromDate+"' and b.date<='"+analysisDate+"' ,round(b.invoice,2),'') invoice"+i+",";
							     
							     sql2+="if(b.date>='"+sqlFromDate+"' and b.date<='"+analysisDate+"' ,round(b.receipt,2),'') receipt"+i+",";
							     
							     sql3+="round(0,2) invoice"+i+",round(0,2) receipt"+i+",";
							     
							     amountLength=amountLength+1;
							     
							     
						     }
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
							   
							   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }

									     sql1+="CONVERT(if(sum(invoice"+i+")=0,'',round(sum(invoice"+i+"),2)),CHAR(50)) 'SALES("+analysingDate+")',";
									     
									     sql6+="CONVERT(if(sum(receipt"+i+")=0,'',round(sum(receipt"+i+")*-1,2)),CHAR(50)) 'COLLECTION("+analysingDate+")',";
									     
									     sql2+="if(b.date>='"+analysisFromDate+"' and b.date<='"+analysisToDate+"' ,round(b.invoice,2),'') invoice"+i+",";
									     
									     sql2+="if(b.date>='"+analysisFromDate+"' and b.date<='"+analysisToDate+"' ,round(b.receipt,2),'') receipt"+i+",";
									     
									     sql3+="round(0,2) invoice"+i+",round(0,2) receipt"+i+",";
									     
									     amountLength=amountLength+1;
					
								         analysisDate=analysisToDate;
							     }
						   }
					   
					     if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
				}
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			     sql4=" and j.brhid in ("+branch+")";
			 }
		     
		     if(!hidclientcat.equalsIgnoreCase("")){
		    	 sql4+=" and ac.catid in ("+hidclientcat+")";
			 }
			
		     if(!hidclient.equalsIgnoreCase("")){
				 sql5+=" and ac.cldocno in ("+hidclient+")";
			 }
		     
		     if(!hidclientslm.equalsIgnoreCase("")){
		    	 sql5+=" and ac.sal_id in ("+hidclientslm+")";
			 }
		     
			 if(!hidclientstatus.equalsIgnoreCase("")){
		    	 sql5+=" and ac.pcase in ("+hidclientstatus+")";
			 }
			 
		     if(rptType.equalsIgnoreCase("1")){
		    	 
		     /*sql = "select @i:=@i+1 'Sr No.',f.* from (select b.acno 'REF NO.',b.refname 'CLIENT NAME',CONVERT(if(sum(b.opn)=0,'',sum(b.opn)),CHAR(50)) 'OPENING',"+sql1+""
		     		+ "CONVERT(if(sum(b.totalinvoice)=0,'',sum(b.totalinvoice)),CHAR(50)) 'SALES TOTAL',"+sql4+"CONVERT(if(sum(b.totalreceipt)=0,'',sum(b.totalreceipt)*-1),CHAR(50)) 'COLLECTION TOTAL',"
		     		+ "CONVERT(if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))),CHAR(50)) 'BALANCE',"
		     		+ "CONVERT((if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))),CHAR(50)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',"
		     	    + "(sum(b.totalreceipt)/"+txtfrequency+")*-1)),CHAR(50)) 'AVG. COLLECTION [/ MONTH]',CONVERT(if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		+ "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))),CHAR(50)) 'AVG. CREDIT'"
		     		+ "from ( select a.acno,a.cldocno,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,"
		     		+ "if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalinvoice,if(a.date>='"+sqlFromDate+"' "
		     		+ "and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,"+sql2+"a.date from(select j.acno,j.dramount,j.dtype,j.date,c.refname,"
		     		+ "c.cldocno from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' where h.atype='AR' and j.status=3 and c.status=3 and  j.date<='"+sqlToDate+"'"+sql3+") a) "
		     		+ "b group by acno order by acno) f,(SELECT @i:= 0) as i";*/
		    
		    	 
		    	 sql = "select @i:=@i+1 'Sr No.',f.* from (select acno 'REF NO.', description 'CLIENT NAME', CONVERT(if(sum(opn)=0,'',sum(opn)),CHAR(100)) 'OPENING',"+sql1+"CONVERT(if(sum(totalinvoice)=0,'',round(sum(totalinvoice),2)),CHAR(100)) 'SALES TOTAL',"+sql6+"CONVERT(if(sum(totalreceipt)=0,'',round(sum(totalreceipt)*-1,2)),CHAR(100)) 'COLLECTION TOTAL',"
		    			 + "CONVERT(if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)),CHAR(100)) 'BALANCE',CONVERT((if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))),CHAR(100)) 'AVG. SALES [/ MONTH]',"
				    	 + "CONVERT((if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))),CHAR(100)) 'AVG. COLLECTION [/ MONTH]',CONVERT(if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-"
				    	 + "((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)),CHAR(100)) 'AVG. CREDIT' from ( " 
				    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
				    	 + ""+sql2+"b.* from ( select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
				    	 + "select j.acno,j.dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno where h.atype='AR' and j.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
				    	 + "union all " 
				    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,"+sql3+"round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,0 catid,0 sal_id,0 pcase from my_jvtran j " 
				    	 + "inner join my_head h on j.acno=h.doc_no where h.atype='AR' and j.status=3 and j.date<'"+sqlFromDate+"'"+sql4+" group by acno) c group by c.acno order by c.acno ) f,(SELECT @i:= 0) as i";
		    	 
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("CRM")){
		    	 
		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
			       
				   ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
		    	 
		     /*sql = "select @i:=@i+1 'Sr No.',f.* from (select b.acno 'REF NO.',b.refname 'CLIENT NAME',CONVERT(if(sum(b.opn)=0,'',sum(b.opn)),CHAR(50)) 'OPENING',CONVERT(if(sum(b.invoice0)=0,'',sum(b.invoice0)),CHAR(50)) 'SALES("+analysingDate+")',"
		     		+ "CONVERT(if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1),CHAR(50)) 'COLLECTION("+analysingDate+")',CONVERT(if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))),CHAR(50)) 'BALANCE',"
		     	    + "CONVERT((if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))),CHAR(50)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',"
		     	    + "(sum(b.totalreceipt)/"+txtfrequency+")*-1)),CHAR(50)) 'AVG. COLLECTION [/ MONTH]',CONVERT(if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		+ "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))),CHAR(50)) 'AVG. CREDIT' from ( "
		     		+ "select a.acno,a.refname,a.cldocno,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype IN ('INV','DNO','CNO','INS','INT'),"
		     		+ "round(a.dramount,2),'') totalinvoice,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' "
		     		+ "and a.date<='"+sqlToDate+"' and a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
		     		+ "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.refname,c.cldocno from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' where "
		     		+ "h.atype='AR' and j.status=3 and c.status=3 and  j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) group by acno order by acno) f,(SELECT @i:= 0) as i";*/
		     
		     sql = "select @i:=@i+1 'Sr No.',f.* from (select acno 'REF NO.', description 'CLIENT NAME', CONVERT(if(sum(opn)=0,'',sum(opn)),CHAR(100)) 'OPENING',CONVERT(if(sum(invoice0)=0,'',sum(invoice0)),CHAR(100)) 'SALES("+analysingDate+")',CONVERT(if(sum(receipt0)=0,'',sum(receipt0)*-1),CHAR(100)) 'COLLECTION("+analysingDate+")',"
		    		 + "CONVERT(if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)),CHAR(100)) 'BALANCE',"  
		    		 + "CONVERT((if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))),CHAR(100)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))),CHAR(100)) 'AVG. COLLECTION [/ MONTH]',"
		    		 + "CONVERT(if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)),CHAR(100)) 'AVG. CREDIT' from ( "
			    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
			    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
			    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
			    	 + "select j.acno,j.dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno where h.atype='AR' and j.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
			    	 + "union all " 
			    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,0 catid,0 sal_id,0 pcase from my_jvtran j " 
			    	 + "inner join my_head h on j.acno=h.doc_no where h.atype='AR' and j.status=3 and j.date<'"+sqlFromDate+"'"+sql4+" group by acno) c group by c.acno order by c.acno ) f,(SELECT @i:= 0) as i";
		     
		     	txtfrequency=0;
		     
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("CAT")){

		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
				   
			       ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
				   
			     /*sql = "select @i:=@i+1 'Sr No.',f.* from (select b.catid 'REF NO.',b.refname 'CATEGORY NAME',CONVERT(if(sum(b.opn)=0,'',sum(b.opn)),CHAR(50)) 'OPENING',CONVERT(if(sum(b.invoice0)=0,'',sum(b.invoice0)),CHAR(50)) 'SALES("+analysingDate+")',"
			             + "CONVERT(if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1),CHAR(50)) 'COLLECTION("+analysingDate+")',CONVERT(if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))),CHAR(50)) 'BALANCE',"
			             + "CONVERT((if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))),CHAR(50)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',"
		     	         + "(sum(b.totalreceipt)/"+txtfrequency+")*-1)),CHAR(50)) 'AVG. COLLECTION [/ MONTH]',CONVERT(if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		     + "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))),CHAR(50)) 'AVG. CREDIT' from ( "
			             + "select a.catid,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') "
			             + "totalinvoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and "
			             + "a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
			             + "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.catid,ct.cat_name refname from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' inner join my_clcatm ct on "
			             + "c.catid=ct.doc_no where j.acno=h.doc_no and h.atype='AR' and j.status=3 and c.status=3 and j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) "
			             + "group by catid order by catid) f,(SELECT @i:= 0) as i";*/

				   sql = "select @i:=@i+1 'Sr No.',f.* from (select catid 'REF NO.', description 'CATEGORY NAME', CONVERT(if(sum(opn)=0,'',sum(opn)),CHAR(100)) 'OPENING',CONVERT(if(sum(invoice0)=0,'',sum(invoice0)),CHAR(100)) 'SALES("+analysingDate+")',CONVERT(if(sum(receipt0)=0,'',sum(receipt0)*-1),CHAR(100)) 'COLLECTION("+analysingDate+")',"
						 + "CONVERT(if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)),CHAR(100)) 'BALANCE',"  
			    		 + "CONVERT((if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))),CHAR(100)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))),CHAR(100)) 'AVG. COLLECTION [/ MONTH]',"
			    		 + "CONVERT(if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)),CHAR(100)) 'AVG. CREDIT' from ( "
				    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
				    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
				    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
				    	 + "select j.acno,j.dramount,j.dtype,j.date,ct.cat_name description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clcatm ct on (ac.catid=ct.doc_no and ct.dtype='CRM') "
				    	 + "where h.atype='AR' and j.status=3 and ct.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
				    	 + "union all " 
				    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j " 
				    	 + "inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clcatm ct on (ac.catid=ct.doc_no and ct.dtype='CRM') where h.atype='AR' and j.status=3 and ct.status=3 and j.date<'"+sqlFromDate+"'"+sql4+""+sql5+" group by acno) c group by c.catid order by c.catid ) f,(SELECT @i:= 0) as i";
				   
			     txtfrequency=0;
			     
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("SLM")){

		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
				   
			       ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
				   
			     /*sql = "select @i:=@i+1 'Sr No.',f.* from (select b.sal_id 'REF NO.',b.refname 'SALESMAN NAME',CONVERT(if(sum(b.opn)=0,'',sum(b.opn)),CHAR(50)) 'OPENING',CONVERT(if(sum(b.invoice0)=0,'',sum(b.invoice0)),CHAR(50)) 'SALES("+analysingDate+")',"
			             + "CONVERT(if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1),CHAR(50)) 'COLLECTION("+analysingDate+")',CONVERT(if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))),CHAR(50)) 'BALANCE',"
			             + "CONVERT((if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))),CHAR(50)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',"
		     	         + "(sum(b.totalreceipt)/"+txtfrequency+")*-1)),CHAR(50)) 'AVG. COLLECTION [/ MONTH]',CONVERT(if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		     + "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))),CHAR(50)) 'AVG. CREDIT' from ( "
			             + "select a.sal_id,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') "
			             + "totalinvoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and "
			             + "a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
			             + "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.sal_id,s.sal_name refname from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' inner join my_salm s on "
			             + "c.sal_id=s.doc_no where j.acno=h.doc_no and h.atype='AR' and j.status=3 and c.status=3 and s.status=3 and j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) "
			             + "group by sal_id order by sal_id) f,(SELECT @i:= 0) as i";*/
			     
			     sql = "select @i:=@i+1 'Sr No.',f.* from (select sal_id 'REF NO.', description 'SALESMAN NAME', CONVERT(if(sum(opn)=0,'',sum(opn)),CHAR(100)) 'OPENING',CONVERT(if(sum(invoice0)=0,'',sum(invoice0)),CHAR(100)) 'SALES("+analysingDate+")',CONVERT(if(sum(receipt0)=0,'',sum(receipt0)*-1),CHAR(100)) 'COLLECTION("+analysingDate+")',"
			    		 + "CONVERT(if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)),CHAR(100)) 'BALANCE',"  
			    		 + "CONVERT((if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))),CHAR(100)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))),CHAR(100)) 'AVG. COLLECTION [/ MONTH]',"
			    		 + "CONVERT(if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)),CHAR(100)) 'AVG. CREDIT' from ( "
				    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
				    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
				    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
				    	 + "select j.acno,j.dramount,j.dtype,j.date,s.sal_name description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_salm s on ac.sal_id=s.doc_no "
				    	 + "where h.atype='AR' and j.status=3 and s.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
				    	 + "union all " 
				    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j " 
				    	 + "inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_salm s on ac.sal_id=s.doc_no where h.atype='AR' and j.status=3 and s.status=3 and j.date<'"+sqlFromDate+"'"+sql4+""+sql5+" group by acno) c group by c.sal_id order by c.sal_id ) f,(SELECT @i:= 0) as i";
			     
			     txtfrequency=0;
		     } else if(rptType.equalsIgnoreCase("2") && summaryType.equalsIgnoreCase("PCASE")){

		    	   xsql= "Select CONCAT(DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%d-%m-%Y')) analysisDates";
				   
			       ResultSet rs = stmtClientAnalysis.executeQuery(xsql);
				   
				   while(rs.next()){
					     analysingDate=rs.getString("analysisDates");
				   }
				   
			     /*sql = "select @i:=@i+1 'Sr No.',f.* from (select b.pcase 'REF NO.',b.refname 'STATUS NAME',CONVERT(if(sum(b.opn)=0,'',sum(b.opn)),CHAR(50)) 'OPENING',CONVERT(if(sum(b.invoice0)=0,'',sum(b.invoice0)),CHAR(50)) 'SALES("+analysingDate+")',"
			             + "CONVERT(if(sum(b.receipt0)=0,'',sum(b.receipt0)*-1),CHAR(50)) 'COLLECTION("+analysingDate+")',CONVERT(if((sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))=0,'',(sum(b.opn)+sum(b.totalinvoice)+sum(b.totalreceipt))),CHAR(50)) 'BALANCE',"
			             + "CONVERT((if((sum(b.totalinvoice)/"+txtfrequency+")=0,'',(sum(b.totalinvoice)/"+txtfrequency+"))),CHAR(50)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(b.totalreceipt)/"+txtfrequency+")=0,'',"
		     	         + "(sum(b.totalreceipt)/"+txtfrequency+")*-1)),CHAR(50)) 'AVG. COLLECTION [/ MONTH]',CONVERT(if(((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))=0,'',"
		     		     + "((sum(b.totalinvoice)/"+txtfrequency+")-((sum(b.totalreceipt)/"+txtfrequency+")*-1))),CHAR(50)) 'AVG. CREDIT' from ( "
			             + "select a.pcase,a.refname,a.dtype,if(a.date<'"+sqlFromDate+"',round(a.dramount,2),'') opn,if(a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') "
			             + "totalinvoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') totalreceipt,if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and "
			             + "a.dtype IN ('INV','DNO','CNO','INS','INT'),round(a.dramount,2),'') invoice0, if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' and a.dtype NOT IN ('INV','DNO','CNO','INS','INT'),"
			             + "round(a.dramount,2),'') receipt0,a.date from (select j.acno,j.dramount,j.dtype,j.date,c.pcase,cl.clstatus refname from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook c on c.acno=j.acno and c.dtype='CRM' inner join my_clstatus cl on "
			             + "c.pcase=cl.doc_no where j.acno=h.doc_no and h.atype='AR' and j.status=3 and c.status=3 and s.status=3 and j.date<='"+sqlToDate+"'"+sql3+") a) b where (b.opn!=0 or b.invoice0!=0 or b.receipt0!=0) "
			             + "group by pcase order by pcase) f,(SELECT @i:= 0) as i";*/
			     
			     sql = "select @i:=@i+1 'Sr No.',f.* from (select pcase 'REF NO.', description 'STATUS NAME', CONVERT(if(sum(opn)=0,'',sum(opn)),CHAR(100)) 'OPENING',CONVERT(if(sum(invoice0)=0,'',sum(invoice0)),CHAR(100)) 'SALES("+analysingDate+")',CONVERT(if(sum(receipt0)=0,'',sum(receipt0)*-1),CHAR(100)) 'COLLECTION("+analysingDate+")',"
			    		 + "CONVERT(if((sum(opn)+sum(totalinvoice)+sum(totalreceipt))=0,'',round((sum(opn)+sum(totalinvoice)+sum(totalreceipt)),2)),CHAR(100)) 'BALANCE',"  
			    		 + "CONVERT((if((sum(totalinvoice)/("+txtfrequency+"+1))=0,'',round((sum(totalinvoice)/("+txtfrequency+"+1)),2))),CHAR(100)) 'AVG. SALES [/ MONTH]',CONVERT((if((sum(totalreceipt)/("+txtfrequency+"+1))=0,'',round((sum(totalreceipt)/("+txtfrequency+"+1))*-1,2))),CHAR(100)) 'AVG. COLLECTION [/ MONTH]',"
			    		 + "CONVERT(if(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1))=0,'',round(((sum(totalinvoice)/("+txtfrequency+"+1))-((sum(totalreceipt)/("+txtfrequency+"+1))*-1)),2)),CHAR(100)) 'AVG. CREDIT' from ( "
				    	 + "select round(0,2) opn,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') totalinvoice,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') totalreceipt," 
				    	 + "if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.invoice,2),'') invoice0,if(b.date>='"+sqlFromDate+"' and b.date<='"+sqlToDate+"' ,round(b.receipt,2),'') receipt0,b.* from ( "
				    	 + "select if(a.dtype IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') invoice,if(a.dtype NOT IN ('INV','DNO','CNO','INS','INT','VSI'),round(a.dramount,2),'') receipt,a.* from ( " 
				    	 + "select j.acno,j.dramount,j.dtype,j.date,cl.clstatus description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clstatus cl on ac.pcase=cl.doc_no "
				    	 + "where h.atype='AR' and j.status=3 and cl.status=3 and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql4+""+sql5+") a) b " 
				    	 + "union all " 
				    	 + "select round(sum(j.dramount),2) opn,round(0,2) totalinvoice,round(0,2) totalreceipt,round(0,2) invoice0,round(0,2) receipt0,round(0,2) invoice,round(0,2) receipt,j.acno,round(0,2) dramount,j.dtype,j.date,h.description,h.cldocno,ac.catid,ac.sal_id,ac.pcase from my_jvtran j " 
				    	 + "inner join my_head h on j.acno=h.doc_no inner join my_acbook ac on j.acno=ac.acno inner join my_clstatus cl on ac.pcase=cl.doc_no where h.atype='AR' and j.status=3 and cl.status=3 and j.date<'"+sqlFromDate+"'"+sql4+""+sql5+" group by acno) c group by c.pcase order by c.pcase ) f,(SELECT @i:= 0) as i";

			     txtfrequency=0;
		     }

		     ResultSet resultSet = stmtClientAnalysis.executeQuery(sql);
			
		     RESULTDATA=ClsCommon.convertToEXCEL(resultSet);

			 }
			 
			 stmtClientAnalysis.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
       }
	
	public JSONArray clientCategorySearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtClientAnalysis=conn.createStatement();
			
			String strSql="select doc_no,cat_name clientcatname from my_clcatm where status=3 and dtype='CRM'";
            
			ResultSet resultSet = stmtClientAnalysis.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtClientAnalysis.close();
			conn.close();
			
			return RESULTDATA;
  
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		
        return RESULTDATA;
    }
	
	public JSONArray clientStatusSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtClientAnalysis=conn.createStatement();
			
			String strSql="select doc_no pcase,clstatus status from my_clstatus where status=3";
            
			ResultSet resultSet = stmtClientAnalysis.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtClientAnalysis.close();
			conn.close();
			
			return RESULTDATA;
  
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		
        return RESULTDATA;
    }
	
	public JSONArray clientSalesManSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtClientAnalysis=conn.createStatement();
			
			String strSql="select doc_no,sal_name clientslmname from my_salm where status=3";
            
			ResultSet resultSet = stmtClientAnalysis.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtClientAnalysis.close();
			conn.close();
			
			return RESULTDATA;
  
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		
        return RESULTDATA;
    }
	
    public JSONArray clientSearch(String branch,String clname,String mob,String lcno,String passno,String nation,String dob) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        		
        try {
			 conn=ClsConnection.getMyConnection();
			 Statement stmtClientAnalysis = conn.createStatement();
			 
	    	 java.sql.Date sqlStartDate=null;
	    	
	    	 dob.trim();
	    	 if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
	    	 {
	    		 sqlStartDate = ClsCommon.changeStringtoSqlDate(dob);
	    	 }
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob='%"+mob+"%'";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno='%"+lcno+"%'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no='%"+passno+"%'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like'%"+nation+"%'";
	    	}
	    	if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
			
			String clsql= "select distinct a.cldocno,coalesce(d.nation,'') nation,d.dob,coalesce(d.dlno,'') dlno,trim(a.RefName) RefName,"+
					" coalesce(a.per_mob,'')per_mob,coalesce(trim(a.address),'') address,a.codeno,a.acno,m.doc_no,coalesce(trim(m.sal_name),'') sal_name "+
					" from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 left join gl_drdetails d on d.cldocno=a.cldocno where a.dtype='CRM' and a.status=3"+sqltest;
			
			ResultSet resultSet = stmtClientAnalysis.executeQuery(clsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			stmtClientAnalysis.close();
			conn.close();
			
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
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
			    obj.put("columngroup",analysisColumnArray[8]);
			}
			if(!(analysisColumnArray[9].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[9]);
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertColumnGroupAnalysisArrayToJSON(ArrayList<String> columnsGroupAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsGroupAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnGroupArray=columnsGroupAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnGroupArray[0]);
			obj.put("align",analysisColumnGroupArray[1]);
			obj.put("width",analysisColumnGroupArray[2]);
			if(!(analysisColumnGroupArray[3].trim().equalsIgnoreCase(""))){
				obj.put("name",analysisColumnGroupArray[3]);
		    }
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columngroups",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList,int txtfrequency) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			int j,k=0;
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("refno",analysisRowArray.get(1));
			obj.put("refname",analysisRowArray.get(2));
			obj.put("opn",analysisRowArray.get(3));
			
			int jj=(txtfrequency+1)+4;

			for (j = 4,k=0; j < jj; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("invoice"+k,analysisRowArray.get(j));
				}
			}

			int kk=jj+(txtfrequency+1);

			for (j = jj,k=0; j < kk; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("receipt"+k,analysisRowArray.get(j));
				}
			}

			obj.put("totalinvoice",analysisRowArray.get(kk));
			obj.put("totalreceipt",analysisRowArray.get(kk+1));
			obj.put("balance",analysisRowArray.get(kk+2));
			
			obj.put("salesaverage",analysisRowArray.get(kk+3));
			obj.put("collectionaverage",analysisRowArray.get(kk+4));
			obj.put("creditaverage",analysisRowArray.get(kk+5));
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
     }
