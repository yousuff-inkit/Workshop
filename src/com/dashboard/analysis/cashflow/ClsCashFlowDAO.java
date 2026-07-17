package com.dashboard.analysis.cashflow;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCashFlowDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray cashFlowAnalysisGrid(String branch,String fromdate,String todate,String rptType,String summaryType, String hidcash,
			String hidbank,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();

		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtCashFlowAnalysis = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			     java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     int txtfrequency=0;
			     
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		         }else if(fromdate.equalsIgnoreCase("0")){
		        	   String sqldate= "select DATE_SUB(LAST_DAY(CURDATE()),INTERVAL 1 MONTH) today";
					   ResultSet rs = stmtCashFlowAnalysis.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlFromDate=rs.getDate("today");
					   }
		         }

			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		         }else if(todate.equalsIgnoreCase("0")){
		        	   String sqldate= "select CURDATE() today";
					   ResultSet rs = stmtCashFlowAnalysis.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlToDate=rs.getDate("today");
					   }
		         }
			     
			    ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     
			    String xsql="",sql = "",sql1 = "",sql2="",sql3="",sql4="",sql5="";

	    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
	    	    ResultSet rs1 = stmtCashFlowAnalysis.executeQuery(sqls);
				
				while(rs1.next()) {
					txtfrequency=rs1.getInt("monthdiff");
				} 
			    
				if(rptType.equalsIgnoreCase("1")){
					
					analysiscolumnarray.add("Sr No.::id::center::center:: ::5%:: :: :: :: ");
					analysiscolumnarray.add("Acc No.::acno::center::center::true::5%:: ::headClass:: :: ");
				    analysiscolumnarray.add("Account::account::left::left:: ::10%:: ::headClass:: :: ");
					analysiscolumnarray.add("Account Name::accountname::left::left:: ::40%:: ::headClass:: :: ");
					analysiscolumnarray.add("In-Flow::monthamount0::right::right:: ::15%::d2::inflowamountClass:: ::['sum']");
					analysiscolumnarray.add("Out-Flow::monthamount1::right::right:: ::15%::d2::outflowamountClass:: ::['sum']");
					analysiscolumnarray.add("Net-Flow::monthamount2::right::right:: ::15%::d2::netflowamountClass:: ::['sum']");
					txtfrequency=2;
					
		     } else if(rptType.equalsIgnoreCase("2")) {
		    	 
		    	    analysiscolumnarray.add("Sr No.::id::center::center:: ::5%:: :: :: :: ");
					analysiscolumnarray.add("Acc No.::acno::center::center::true::5%:: ::headClass:: :: ");
				    analysiscolumnarray.add("Account::account::left::left:: ::10%:: ::headClass:: :: ");
		    	    analysiscolumnarray.add("Account Name::accountname::left::left:: ::29%:: ::headClass:: :: ");
		    	    
		    	    analysisDate=sqlFromDate;
					
					for(int m=0;m<=txtfrequency;m++) {
						 if(m==0) {

							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
							   ResultSet rs = stmtCashFlowAnalysis.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     
								     analysiscolumnarray.add(""+analysingDate+"::monthamount"+m+"::right::right:: ::8%::d2::amountClass:: ::['sum']");
								     
								     sql1+="round(sum(b.monthamount"+m+"),2) monthamount"+m+",";
								     
								     sql2+="if(j.date>='"+sqlFromDate+"' and j.date<='"+analysisDate+"',round(if(j.ldramount>0,j.ldramount,0),2),0) monthamount"+m+",";
								     
								     sql3+="if(j.date>='"+sqlFromDate+"' and j.date<='"+analysisDate+"',round(if(j.ldramount<0,j.ldramount*-1,0),2),0) monthamount"+m+",";
								     
								     sql4+="if(j.date>='"+sqlFromDate+"' and j.date<='"+analysisDate+"',(if(j.ldramount>0,j.ldramount,0)-if(j.ldramount<0,j.ldramount*-1,0)),0) monthamount"+m+",";
								     
							   }
							   
						   } else {
						   
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
						   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
						   ResultSet rs = stmtCashFlowAnalysis.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
							     
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
								   
								  analysiscolumnarray.add(""+analysingDate+"::monthamount"+m+"::right::right:: ::8%::d2::amountClass:: ::['sum']");
								  analysisDate=analysisToDate;
								  
								  sql1+="round(sum(b.monthamount"+m+"),2) monthamount"+m+",";
								  
								  sql2+="if(j.date>='"+analysisFromDate+"' and j.date<='"+analysisToDate+"',round(if(j.ldramount>0,j.ldramount,0),2),0) monthamount"+m+",";
								  
								  sql3+="if(j.date>='"+analysisFromDate+"' and j.date<='"+analysisToDate+"',round(if(j.ldramount<0,j.ldramount*-1,0),2),0) monthamount"+m+",";
								  
								  sql4+="if(j.date>='"+analysisFromDate+"' and j.date<='"+analysisToDate+"',(if(j.ldramount>0,j.ldramount,0)-if(j.ldramount<0,j.ldramount*-1,0)),0) monthamount"+m+",";
								  
						   }
						   
						}
						 
						 if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
			 }
		     
			 if(rptType.equalsIgnoreCase("1")) {
				 
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				     sql1=" and j.brhid in ("+branch+")";
				 }
			     
			     if(!((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && !((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
			    	 sql1+=" and j.acno in ("+hidcash+","+hidbank+")";
			     }
			     
			     if(!((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && ((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
			    	 sql1+=" and j.acno in ("+hidcash+")";
				 }
				 
			     if(((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && !((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
					 sql1+=" and j.acno in ("+hidbank+")";
				 }
			     
			 } else if(rptType.equalsIgnoreCase("2")) {
				 
				 if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				     sql5=" and j.brhid in ("+branch+")";
				 }
			     
			     if(!((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && !((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
			    	 sql5+=" and j.acno in ("+hidcash+","+hidbank+")";
			     }
			     
			     if(!((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && ((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
			    	 sql5+=" and j.acno in ("+hidcash+")";
				 }
				 
			     if(((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && !((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
					 sql5+=" and j.acno in ("+hidbank+")";
				 }
			 }
			 
		     if(rptType.equalsIgnoreCase("1") && summaryType.equalsIgnoreCase("All")) {
		    	 
		    	 sql = "select @i:=@i+1 id,f.* from (select a.acno,a.account,a.description accountname,CONVERT(if(sum(a.inflow)=0,' ',round(sum(a.inflow),2)),CHAR(100)) monthamount0,CONVERT(if(sum(a.outflow)=0,' ',round(sum(a.outflow),2)),CHAR(100)) monthamount1,"  
					 + "CONVERT(if((sum(a.inflow)-sum(a.outflow))=0,' ',((round(sum(a.inflow),2))-round(sum(a.outflow),2))),CHAR(100)) monthamount2 from ( select j.acno,h.account,h.description,h.den,if(j.ldramount>0,j.ldramount,0) inflow,"
					 + "if(j.ldramount<0,j.ldramount*-1,0) outflow from my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den in (604,305) where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql1+") a "  
					 + "group by a.acno order by a.den) f,(SELECT @i:= 0) as i";
		    	 
		     } else if(rptType.equalsIgnoreCase("1") && summaryType.equalsIgnoreCase("604")) {
		    	 
		    	 sql = "select @i:=@i+1 id,f.* from (select a.acno,a.account,a.description accountname,CONVERT(if(sum(a.inflow)=0,' ',round(sum(a.inflow),2)),CHAR(100)) monthamount0,CONVERT(if(sum(a.outflow)=0,' ',round(sum(a.outflow),2)),CHAR(100)) monthamount1,"  
					 + "CONVERT(if((sum(a.inflow)-sum(a.outflow))=0,' ',((round(sum(a.inflow),2))-round(sum(a.outflow),2))),CHAR(100)) monthamount2 from ( select j.acno,h.account,h.description,h.den,if(j.ldramount>0,j.ldramount,0) inflow,"
					 + "if(j.ldramount<0,j.ldramount*-1,0) outflow from my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den=604 where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql1+") a "  
					 + "group by a.acno order by a.acno) f,(SELECT @i:= 0) as i";
		    	 
		     } else if(rptType.equalsIgnoreCase("1") && summaryType.equalsIgnoreCase("305")) {

		    	 sql = "select @i:=@i+1 id,f.* from (select a.acno,a.account,a.description accountname,CONVERT(if(sum(a.inflow)=0,' ',round(sum(a.inflow),2)),CHAR(100)) monthamount0,CONVERT(if(sum(a.outflow)=0,' ',round(sum(a.outflow),2)),CHAR(100)) monthamount1,"  
					 + "CONVERT(if((sum(a.inflow)-sum(a.outflow))=0,' ',((round(sum(a.inflow),2))-round(sum(a.outflow),2))),CHAR(100)) monthamount2 from ( select j.acno,h.account,h.description,h.den,if(j.ldramount>0,j.ldramount,0) inflow,"
					 + "if(j.ldramount<0,j.ldramount*-1,0) outflow from my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den=305 where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql1+") a "  
					 + "group by a.acno order by a.acno) f,(SELECT @i:= 0) as i";
		    	 
		     } else if(rptType.equalsIgnoreCase("2")) {
		    	 
		    	 sql = "select @i:=@i+1 id,f.* from ( select b.acno,CONVERT(if(b.account=0,' ',b.account),CHAR(50)) account,b.accountname,"+sql1+"b.den from ( select 0 acno,0 account,CONCAT('IN-FLOW [',DATE_FORMAT('"+sqlFromDate+"','%b %Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%b %Y'),']') accountname,"
		    		 + ""+sql2+"305 den from my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den in (604,305) where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql5+") b group by b.acno UNION ALL select j.acno,h.account,h.description accountname,"+sql2+"h.den from "  
		    	 	 + "my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den in (604,305) where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql5+" UNION ALL select b.acno,CONVERT(if(b.account=0,' ',b.account),CHAR(50)) account,b.accountname,"+sql1+"b.den from ( "
		    	 	 + "select 0 acno,0 account,CONCAT('OUT-FLOW [',DATE_FORMAT('"+sqlFromDate+"','%b %Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%b %Y'),']') accountname,"+sql3+"305 den from my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den in (604,305) where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' "
		    	 	 + "and j.date<='"+sqlToDate+"'"+sql5+") b group by b.acno UNION ALL select j.acno,h.account,h.description accountname,"+sql3+"h.den from my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den in (604,305) where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql5+" UNION ALL "
		    	 	 + "select b.acno,CONVERT(if(b.account=0,' ',b.account),CHAR(50)) account,b.accountname,"+sql1+"b.den from ( select 0 acno,0 account,CONCAT('NET-FLOW [',DATE_FORMAT('"+sqlFromDate+"','%b %Y'),' To ',DATE_FORMAT('"+sqlToDate+"','%b %Y'),']') accountname,"+sql4+"999 den from my_jvtran j inner join my_head h on "
		    	 	 + "j.acno=h.doc_no and h.den in (604,305) where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql5+") b group by b.acno ) f,(SELECT @i:= 0) as i";
		    	 
		     }

		     ResultSet resultSet = stmtCashFlowAnalysis.executeQuery(sql);
		     
			 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();

				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					
					temp.add(resultSet.getString("id"));
					temp.add(resultSet.getString("acno"));
					temp.add(resultSet.getString("account"));
					temp.add(resultSet.getString("accountname"));
					
					for (int l = 0; l <= txtfrequency; l++) {
						temp.add(resultSet.getString("monthamount"+l+""));
					}
					
					analysisrowarray.add(temp);
				}
			
			 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray,txtfrequency);

			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;

			 }
			 
			 stmtCashFlowAnalysis.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
       }
	
	public JSONArray cashFlowExcelExport(String branch,String fromdate,String todate,String hidcash, String hidbank,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCashFlowAnalysis = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")) {
					
				String sql="";
				
				java.sql.Date sqlFromDate = null;
		        java.sql.Date sqlToDate = null;
		        
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && !((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
			    	 sql+=" and j.acno in ("+hidcash+","+hidbank+")";
			    }
			     
			    if(!((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && ((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
			    	 sql+=" and j.acno in ("+hidcash+")";
				}
				 
			    if(((hidcash.equalsIgnoreCase("")) || (hidcash.equalsIgnoreCase("0"))) && !((hidbank.equalsIgnoreCase("")) || (hidbank.equalsIgnoreCase("0")))){
					 sql+=" and j.acno in ("+hidbank+")";
				}
			            		
				sql = "select a.account 'Account',a.description 'Account Name',CONVERT(if(sum(a.inflow)=0,' ',round(sum(a.inflow),2)),CHAR(100)) 'In Flow',CONVERT(if(sum(a.outflow)=0,' ',round(sum(a.outflow),2)),CHAR(100)) 'Out Flow',"  
					   + "CONVERT(if((sum(a.inflow)-sum(a.outflow))=0,' ',((round(sum(a.inflow),2))-round(sum(a.outflow),2))),CHAR(100)) 'Net Flow' from ( select j.acno,h.account,h.description,h.den,if(j.ldramount>0,j.ldramount,0) inflow,"
					   + "if(j.ldramount<0,j.ldramount*-1,0) outflow from my_jvtran j inner join my_head h on j.acno=h.doc_no and h.den in (604,305) where j.status=3 and j.dtype!='COT' and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'"+sql+") a "  
					   + "group by a.acno order by a.den";

				ResultSet resultSet = stmtCashFlowAnalysis.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				
				stmtCashFlowAnalysis.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String den,String account,String partyname,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
				conn = ClsConnection.getMyConnection();
				Statement stmtCashFlowAnalysis = conn.createStatement();
	            
				if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            
				if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
				
				sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.atype='GL' and t.m_s=0 and t.den='"+den+"'"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtCashFlowAnalysis.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtCashFlowAnalysis.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtCashFlowAnalysis.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
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
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList,int txtfrequency) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			int j,k=0;
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("acno",analysisRowArray.get(1));
			obj.put("account",analysisRowArray.get(2));
			obj.put("accountname",analysisRowArray.get(3));
			
			int jj=(txtfrequency+1)+4;

			for (j = 4,k=0; j < jj; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("monthamount"+k,analysisRowArray.get(j));
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
