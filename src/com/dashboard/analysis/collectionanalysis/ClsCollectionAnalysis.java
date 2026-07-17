package com.dashboard.analysis.collectionanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCollectionAnalysis  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray collectionGridLoading(String branch,String fromdate,String todate,String hidclientcat,String hidclient,String hidsalesman,
			String hidbrand,String hidmodel,String hidgroup,String hidyom) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCollection = conn.createStatement();
			    
			    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
			    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    
			    if(!hidclientcat.equalsIgnoreCase("")){
					sql+=" and cat.doc_no in ("+hidclientcat+")";
				}
				if(!hidclient.equalsIgnoreCase("")){
					sql+=" and a.cldocno in ("+hidclient+")";
				}
				if(!hidsalesman.equalsIgnoreCase("")){
					sql+=" and sal.doc_no in ("+hidsalesman+")";
				}
				if(!hidbrand.equalsIgnoreCase("")){
					sql+=" and veh.brdid in ("+hidbrand+")";
				}
				if(!hidmodel.equalsIgnoreCase("")){
					sql+=" and veh.vmodid in ("+hidmodel+")";
				}
				if(!hidgroup.equalsIgnoreCase("")){
					sql+=" and veh.vgrpid in ("+hidgroup+")";
				}
				if(!hidyom.equalsIgnoreCase("")){
					sql+=" and veh.yom in ("+hidyom+")";
				}
			    
			    sql = "select cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,coalesce(cc.rano,'') as rano,cc.cashtotal,cc.cardtotal,cc.chequetotal from "
						+ "(select if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
						+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,if(r.payas=1,concat(jv.rtype,' - ',CONVERT(jv.rdocno,CHAR(100))),concat(r.rtype,' - ',CONVERT(if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(100)))) rano,"
						+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from gl_rentreceipt r "
						+ "left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on "
						+ "(r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_clcatm cat on a.catid=cat.doc_no left join  gl_vehmaster veh on j.costcode=veh.fleet_no "
						+ "left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no "
						+ "left join my_salm sal on a.sal_id=sal.doc_no left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
						+ "r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno)cc";
			    
			    ResultSet resultSet = stmtCollection.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCollection.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray collectionGroupGridLoading(String branch,String fromdate,String todate,String cmbgroup,String hidclientcat,String hidclient,String hidsalesman,
			String hidbrand,String hidmodel,String hidgroup,String hidyom,String check) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
		JSONArray ROWDATA=new JSONArray();
		JSONArray COLUMNDATA=new JSONArray();
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCollection = conn.createStatement();
		        
			    if(check.equalsIgnoreCase("1")){

			    ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			    
			    analysiscolumnarray.add("Sr No.::id::center::center:: ::5%:: :: :: ");
			    analysiscolumnarray.add("Ref No.::refno::center::center:: ::10%:: ::headClass:: ");
			     
			    if(cmbgroup.equalsIgnoreCase("clientcat")){
			    	 analysiscolumnarray.add("Category Name::description::left::left:: :: :: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("salesman")){
			    	 analysiscolumnarray.add("Salesman Name::description::left::left:: :: :: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("brand")){
			    	 analysiscolumnarray.add("Brand Name::description::left::left:: :: :: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("model")){
			    	 analysiscolumnarray.add("Model Name::description::left::left:: :: :: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("group")){
			    	 analysiscolumnarray.add("Group Name::description::left::left:: :: :: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("yom")){
			    	 analysiscolumnarray.add("YOM Name::description::left::left:: :: :: ::headClass:: ");
			     } else {
			    	 analysiscolumnarray.add("Client Name::description::left::left:: :: :: ::headClass:: ");
			     }
			     
			    analysiscolumnarray.add("Cash Total::amount0::right::right:: ::12%::d2::cashClass::['sum']");
			    analysiscolumnarray.add("Card Total::amount1::right::right:: ::12%::d2::cardClass::['sum']");
			    analysiscolumnarray.add("Cheque Total::amount2::right::right:: ::12%::d2::chequeClass::['sum']");
			     
			    String sql = "",sqlselect="";	
			    
			    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			         sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			    }
			        
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			         sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			    }
			    
			    if(cmbgroup.equalsIgnoreCase("clientcat")){
					sqlselect="coalesce(cat.doc_no,0) refno,coalesce(cat.cat_name,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("client")){
					sqlselect="coalesce(r.cldocno,0) refno,coalesce(a.refname,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("salesman")){
					sqlselect="coalesce(sal.doc_no,0) refno,coalesce(sal.sal_name,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("brand")){
					sqlselect="coalesce(veh.brdid,0) refno,coalesce(brd.brand_name,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("model")){
					sqlselect="coalesce(veh.vmodid,0) refno,coalesce(model.vtype,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("group")){
					sqlselect="coalesce(veh.vgrpid,0) refno,coalesce(grp.gname,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("yom")){
					sqlselect="coalesce(veh.yom,0) refno,coalesce(yom.yom,0) description,";
				}

				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    
				if(!hidclientcat.equalsIgnoreCase("")){
					sql+=" and cat.doc_no in ("+hidclientcat+")";
				}
				if(!hidclient.equalsIgnoreCase("")){
					sql+=" and a.cldocno in ("+hidclient+")";
				}
				if(!hidsalesman.equalsIgnoreCase("")){
					sql+=" and sal.doc_no in ("+hidsalesman+")";
				}
				if(!hidbrand.equalsIgnoreCase("")){
					sql+=" and veh.brdid in ("+hidbrand+")";
				}
				if(!hidmodel.equalsIgnoreCase("")){
					sql+=" and veh.vmodid in ("+hidmodel+")";
				}
				if(!hidgroup.equalsIgnoreCase("")){
					sql+=" and veh.vgrpid in ("+hidgroup+")";
				}
				if(!hidyom.equalsIgnoreCase("")){
					sql+=" and veh.yom in ("+hidyom+")";
				}
				
			    sql = "select @i:=@i+1 id,cc.refno,cc.description,if(sum(cc.amount0)=0,' ',coalesce(sum(cc.amount0),0)) amount0,if(sum(cc.amount1)=0,' ',coalesce(sum(cc.amount1),0)) amount1,"
			    	+ "if(sum(cc.amount2)=0,' ',coalesce(sum(cc.amount2),0)) amount2 from (select "+sqlselect+"if(r.paytype=1,round(r.netamt,2),0) amount0,if(r.paytype=2,round(r.netamt,2),0) amount1,if(r.paytype=3,round(r.netamt,2),0) amount2 "
			    	+ "from gl_rentreceipt r left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid "
			    	+ "left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la "
			    	+ "on (r.aggno=la.doc_no and r.rtype='LAG') left join my_clcatm cat on a.catid=cat.doc_no left join  gl_vehmaster veh on j.costcode=veh.fleet_no "
			    	+ "left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on "
			    	+ "veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join my_salm sal on a.sal_id=sal.doc_no left join my_brch b on r.brhid=b.branch "
			    	+ "left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno)cc,"
			    	+ "(SELECT @i:= 0) as i group by cc.refno order by id";
			    
			    ResultSet resultSet = stmtCollection.executeQuery(sql);
			                
			    ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();

				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					
					temp.add(resultSet.getString("id"));
					temp.add(resultSet.getString("refno"));
					temp.add(resultSet.getString("description"));
					temp.add(resultSet.getString("amount0"));
					temp.add(resultSet.getString("amount1"));
					temp.add(resultSet.getString("amount2"));
					analysisrowarray.add(temp);
				}

				 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
				 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				 
				 JSONArray analysisarray=new JSONArray();
				 
				 analysisarray.addAll(COLUMNDATA);
				 analysisarray.addAll(ROWDATA);
				 RESULTDATA=analysisarray;
			    
			    }
			    
			    stmtCollection.close();
			    conn.close();
			    
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray collectionDistributionGridLoading(String branch,String fromdate,String todate,String cmbgroup,String cmbfrequency,String hidclientcat,String hidclient,String hidsalesman,
			String hidbrand,String hidmodel,String hidgroup,String hidyom,String check) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
		JSONArray ROWDATA=new JSONArray();
		JSONArray COLUMNDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCollection = conn.createStatement();
		        
			    if(check.equalsIgnoreCase("2")){

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
						   ResultSet rs = stmtCollection.executeQuery(sqldate);
						   
						   while(rs.next()){
							   sqlFromDate=rs.getDate("today");
						   }
			         }

				     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			         }else if(todate.equalsIgnoreCase("0")){
			        	   String sqldate= "select CURDATE() today";
						   ResultSet rs = stmtCollection.executeQuery(sqldate);
						   
						   while(rs.next()){
							   sqlToDate=rs.getDate("today");
						   }
			         }
				     
			    ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			    
			    analysiscolumnarray.add("Sr No.::id::center::center:: ::5%:: :: :: ");
			    analysiscolumnarray.add("Ref No.::refno::center::center:: ::5%:: ::headClass:: ");
			     
			    if(cmbgroup.equalsIgnoreCase("clientcat")){
			    	 analysiscolumnarray.add("Category Name::description::left::left:: ::25%:: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("salesman")){
			    	 analysiscolumnarray.add("Salesman Name::description::left::left:: ::25%:: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("brand")){
			    	 analysiscolumnarray.add("Brand Name::description::left::left:: ::25%:: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("model")){
			    	 analysiscolumnarray.add("Model Name::description::left::left:: ::25%:: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("group")){
			    	 analysiscolumnarray.add("Group Name::description::left::left:: ::25%:: ::headClass:: ");
			     } else if(cmbgroup.equalsIgnoreCase("yom")){
			    	 analysiscolumnarray.add("YOM Name::description::left::left:: ::25%:: ::headClass:: ");
			     } else {
			    	 analysiscolumnarray.add("Client Name::description::left::left:: ::25%:: ::headClass:: ");
			     }
			     
			    String sql = "",sqlselect="",sqlgroup="",sql1 = "",sql2="",sql3="",xsql="",xsqls="";	
			    
			     String dayDiff="",monthDiff="";
			     
			     if(cmbfrequency.equalsIgnoreCase("1")){
			    		String sqls = "select count(*) branchcount from my_brch where status<>7";
			    		ResultSet rs1 = stmtCollection.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("branchcount");
						} 
						
			     }
			     else if(cmbfrequency.equalsIgnoreCase("2")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	 	ResultSet rs1 = stmtCollection.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
						
			     }
			     
			     else if(cmbfrequency.equalsIgnoreCase("3")){
			    	 
			    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtCollection.executeQuery(sqls);
						
						while(rs1.next()) {
							monthDiff=rs1.getString("monthdiff");
						} 
						
						String sqls1 = "select ("+monthDiff+"/3) monthdifference";
						ResultSet rs2 = stmtCollection.executeQuery(sqls1);
						
						while(rs2.next()) {
							txtfrequency=rs2.getInt("monthdifference");
						} 
			    	    
						xsqls= "3 Month";
						
			     }else if(cmbfrequency.equalsIgnoreCase("4")){

			    	 	String sqls = "select TIMESTAMPDIFF(YEAR, '"+sqlFromDate+"', '"+sqlToDate+"') yeardiff";
			    	 	ResultSet rs1 = stmtCollection.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("yeardiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
			     }
			     else if(cmbfrequency.equalsIgnoreCase("5")){
			    	 String sqls="select count(*) catcount from my_clcatm where status=3";
			    	 ResultSet rs1=stmtCollection.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("catcount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("6")){
			    	 String sqls="select count(*) salescount from my_salm where status=3";
			    	 ResultSet rs1=stmtCollection.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("salescount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("7")){
			    	 String sqls="select count(*) brandcount from gl_vehbrand where status=3";
			    	 ResultSet rs1=stmtCollection.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("brandcount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("8")){
			    	 String sqls="select count(*) modelcount from gl_vehmodel where status=3";
			    	 ResultSet rs1=stmtCollection.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("modelcount");
			    	 }

			     }
			     else if(cmbfrequency.equalsIgnoreCase("9")){
			    	 String sqls="select count(*) groupcount from gl_vehgroup where status=3";
			    	 ResultSet rs1=stmtCollection.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("groupcount");
			    	 }
			     }
			     else if(cmbfrequency.equalsIgnoreCase("10")){
			    	 String sqls="select count(*) yomcount from gl_yom";
			    	 ResultSet rs1=stmtCollection.executeQuery(sqls);
			    	 while(rs1.next()){
			    		 txtfrequency=rs1.getInt("yomcount");
			    	 }
			     }
			     else{
			    	 txtfrequency=0;
			     }
			     
			     	if(cmbfrequency.equalsIgnoreCase("1")){
			     		
			     		String brname="";
			     		for(int i=0,y=0;i<=txtfrequency;i++){
			     			
			     			xsql="select branchname,doc_no from my_brch where doc_no="+i;
			     			ResultSet rsbr=stmtCollection.executeQuery(xsql);
			     			
			     			while(rsbr.next()){
			     				brname=rsbr.getString("branchname");
			     				
			     				sql1+="if(cc.amount"+y+"!=0,round(cc.amount"+y+",2),'') amount"+y+",";
							     
							    sql2+=" if(r.brhid="+rsbr.getInt("doc_no")+",coalesce(round(r.netamt,2),0),0) amount"+y+",";
							     
							    sql3+=" if(sum(cc.amount"+y+")!=0,coalesce(round(sum(cc.amount"+y+"),2),''),'') amount"+y+",";
							     
							    amountLength=amountLength+1;
			     				  
							    if(txtfrequency==0){
							    	 analysiscolumnarray.add(""+brname+"::amount"+y+"::right::right:: :: ::d2::yellowClass::['sum']");
							    }else{
							    	 analysiscolumnarray.add(""+brname+"::amount"+y+"::right::right:: ::12%::d2::yellowClass::['sum']");
							    }
							    
							    y++;
			     			}
			     		}
			     	}
			     	
			     	else if(cmbfrequency.equalsIgnoreCase("2")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
						   ResultSet rs = stmtCollection.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
							     
							     sql2+=" if(r.date>='"+sqlFromDate+"' and r.date<='"+analysisDate+"',coalesce(round(r.netamt,2),0),0) amount"+i+",";
							     
							     sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
							     
							     amountLength=amountLength+1;
							     
							     if(txtfrequency==0){
							    	 analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
							     }else{
							    	 analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
							     }
						     }
						}else{
							xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
							   ResultSet rs = stmtCollection.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
								     
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
									     sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
									     
									     sql2+=" if(r.date>='"+analysisFromDate+"' and r.date<='"+analysisToDate+"',coalesce(round(r.netamt,2),0),0) amount"+i+",";
								
									     sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
									     
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
			     
			     	else if(cmbfrequency.equalsIgnoreCase("3")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%b %Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%b %Y')) analysisDates";
							   ResultSet rs = stmtCollection.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     
								     sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
								     
								     sql2+=" if(r.date>='"+sqlFromDate+"' and r.date<='"+analysisDate+"',coalesce(round(r.netamt,2),0),0) amount"+i+",";
								     
								     sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
								     
								     amountLength=amountLength+1;
								     
								     if(txtfrequency==0){
								    	 analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
								     }else {
								    	 analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
								     }
							     }
							}else{
								   
								 xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
									   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
									   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
									   
									   ResultSet rs = stmtCollection.executeQuery(xsql);
									   
									   while(rs.next()){
										     analysisFromDate=rs.getDate("analysisFromDate");
										     analysisToDate=rs.getDate("analysisToDate");
										     analysingDate=rs.getString("analysisDates");
										     analysingToDate=rs.getString("analysingDate");
					
										     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
										    	   analysisToDate=sqlToDate;
										    	   analysingDate=analysingToDate;
										      }
									     
									         sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
									     
									         sql2+=" if(r.date>='"+analysisFromDate+"' and r.date<='"+analysisToDate+"',coalesce(round(r.netamt,2),0),0) amount"+i+",";
									     
									         sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
									         
										     amountLength=amountLength+1;
										     
										     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
									     
									         analysisDate=analysisToDate;
								     }
							   }
						   
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						    	 break;
						     }
						}
						
				     }
			     	
			     	else if(cmbfrequency.equalsIgnoreCase("4")){
			     		
			     		analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   String sqls = "SELECT YEAR('"+analysisDate+"') year";
							   ResultSet rs1 = stmtCollection.executeQuery(sqls);
							   
							   int year=0;
							   while(rs1.next()){
								    year=rs1.getInt("year");
							   }
							   
							   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
							   ResultSet rss = stmtCollection.executeQuery(sqls1);
							   
							   int noOfMonths=0;
							   while(rss.next()){
								     noOfMonths=rss.getInt("noofmonths");
							   }
							   
							   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
							   ResultSet rs = stmtCollection.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     
								     sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
								     
								     sql2+=" if(r.date>='"+sqlFromDate+"' and r.date<='"+analysisDate+"',coalesce(round(r.netamt,2),0),0) amount"+i+",";
									 
								     sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
								     
								     amountLength=amountLength+1;
								     
								     if(txtfrequency==0){
								    	 analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
								     } else {
								    	 analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::8%::d2::yellowClass::['sum']");
								     }
							     }
							}else{
								   
								xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
										+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
								   ResultSet rs = stmtCollection.executeQuery(xsql);
								   
								   while(rs.next()){
									     analysisFromDate=rs.getDate("analysisFromDate");
									     analysisToDate=rs.getDate("analysisToDate");
									     analysingDate=rs.getString("analysisDates");
									     analysingToDate=rs.getString("analysingDate");
				
									     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
									    	   analysisToDate=sqlToDate;
									    	   analysingDate=analysingToDate;
									      }
											 
									         sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
									     
								             sql2+=" if(r.date>='"+analysisFromDate+"' and r.date<='"+analysisToDate+"',coalesce(round(r.netamt,2),0),0) amount"+i+",";
								     
								             sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
								             
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
			     	else if(cmbfrequency.equalsIgnoreCase("5")){
			     			ArrayList<String> clientcatarray=new ArrayList<>();
			     		
			     			String sqlss="select doc_no,cat_name from my_clcatm where status=3";
			     			ResultSet rs2=stmtCollection.executeQuery(sqlss);
			     			
			     			while(rs2.next()){
			     				clientcatarray.add(rs2.getString("doc_no")+"::"+rs2.getString("cat_name"));
			     			}
			     			
			     			for(int i=0;i<clientcatarray.size();i++){
			     				
			     				sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
							     
							    sql2+=" if(cat.doc_no="+clientcatarray.get(i).split("::")[0]+",coalesce(round(r.netamt,2),0),0) amount"+i+",";
							     
							    sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
							     
							    amountLength=amountLength+1;
			     				  
							    if(txtfrequency==0){
							    	 analysiscolumnarray.add(""+clientcatarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
							    }else{
							    	analysiscolumnarray.add(""+clientcatarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
							    }
			     				
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("6")){
			     			ArrayList<String> salesmanarray=new ArrayList<>();
			     		
			     			String sqlss="select doc_no,sal_name from my_salm where status=3";
			     			ResultSet rs2=stmtCollection.executeQuery(sqlss);
			     			
			     			while(rs2.next()){
			     				salesmanarray.add(rs2.getString("doc_no")+"::"+rs2.getString("sal_name"));
			     			}
			     			
			     			for(int i=0;i<salesmanarray.size();i++){

			     				sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
							     
							    sql2+=" if(sal.doc_no="+salesmanarray.get(i).split("::")[0]+",coalesce(round(r.netamt,2),0),0) amount"+i+",";
							     
							    sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
							     
							    amountLength=amountLength+1;
			     				  
							    if(txtfrequency==0){
							    	 analysiscolumnarray.add(""+salesmanarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
							    }else{
							    	analysiscolumnarray.add(""+salesmanarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
							    }
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("7")){
			     		ArrayList<String> brandarray=new ArrayList<>();
			     		
			     			String sqlss="select doc_no,brand_name from gl_vehbrand where status=3";
			     			ResultSet rs2=stmtCollection.executeQuery(sqlss);
			     			
			     			while(rs2.next()){
			     				brandarray.add(rs2.getString("doc_no")+"::"+rs2.getString("brand_name"));
			     			}
			     			
			     			for(int i=0;i<brandarray.size();i++){
			     				
			     				sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
							     
							    sql2+=" if(brd.doc_no="+brandarray.get(i).split("::")[0]+",coalesce(round(r.netamt,2),0),0) amount"+i+",";
							     
							    sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
							     
							    amountLength=amountLength+1;
			     				  
							    if(txtfrequency==0){
							    	 analysiscolumnarray.add(""+brandarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
							    }else{
							    	analysiscolumnarray.add(""+brandarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
							    }
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("8")){
			     		    ArrayList<String> modelarray=new ArrayList<>();
			     			
			     			String sqlss="select doc_no,vtype from gl_vehmodel where status=3";
			     			ResultSet rs2=stmtCollection.executeQuery(sqlss);
			     			
			     			while(rs2.next()){
			     				modelarray.add(rs2.getString("doc_no")+"::"+rs2.getString("vtype"));
			     			}
			     			
			     			for(int i=0;i<modelarray.size();i++){
			     				
			     				sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
							     
							    sql2+=" if(model.doc_no="+modelarray.get(i).split("::")[0]+",coalesce(round(r.netamt,2),0),0) amount"+i+",";
							     
							    sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
							     
							    amountLength=amountLength+1;
			     				  
							    if(txtfrequency==0){
							    	 analysiscolumnarray.add(""+modelarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
							    }else{
							    	 analysiscolumnarray.add(""+modelarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
							    }
			     			}
			     		
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("9")){
			     		ArrayList<String> grouparray=new ArrayList<>();
		     			
		     			String sqlss="select doc_no,gname from gl_vehgroup where status=3";
		     			ResultSet rs2=stmtCollection.executeQuery(sqlss);
		     			
		     			while(rs2.next()){
		     				grouparray.add(rs2.getString("doc_no")+"::"+rs2.getString("gname"));
		     			}
		     			
		     			for(int i=0;i<grouparray.size();i++){
		     				
		     				sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
						     
						    sql2+=" if(grp.doc_no="+grouparray.get(i).split("::")[0]+",coalesce(round(r.netamt,2),0),0) amount"+i+",";
						     
						    sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
						     
						    amountLength=amountLength+1;
		     				  
						    if(txtfrequency==0){
						    	 analysiscolumnarray.add(""+grouparray.get(i).split("::")[1]+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
						    }else{
						    	 analysiscolumnarray.add(""+grouparray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
						    }
		     			}
			     	}
			     	else if(cmbfrequency.equalsIgnoreCase("10")){
			     		ArrayList<String> yomarray=new ArrayList<>();
		     			
		     			String sqlss="select doc_no,yom from gl_yom";
		     			ResultSet rs2=stmtCollection.executeQuery(sqlss);
		     			
		     			while(rs2.next()){
		     				yomarray.add(rs2.getString("doc_no")+"::"+rs2.getString("yom"));
		     			}
		     			
		     			for(int i=0;i<yomarray.size();i++){
		     				
		     				sql1+="if(cc.amount"+i+"!=0,round(cc.amount"+i+",2),'') amount"+i+",";
						     
						    sql2+=" if(yom.doc_no="+yomarray.get(i).split("::")[0]+",coalesce(round(r.netamt,2),0),0) amount"+i+",";
						     
						    sql3+=" if(sum(cc.amount"+i+")!=0,coalesce(round(sum(cc.amount"+i+"),2),''),'') amount"+i+",";
						     
						    amountLength=amountLength+1;
		     				  
						    if(txtfrequency==0){
						    	 analysiscolumnarray.add(""+yomarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: :: ::d2::yellowClass::['sum']");
						    }else{
						    	 analysiscolumnarray.add(""+yomarray.get(i).split("::")[1]+"::amount"+i+"::right::right:: ::12%::d2::yellowClass::['sum']");
						    }
		     			}
			     	}
			    
			    if(!(cmbgroup.equalsIgnoreCase(""))){

			    if(cmbgroup.equalsIgnoreCase("clientcat")){
			    	sql1=sql3;
					sqlselect="coalesce(cat.doc_no,0) refno,coalesce(cat.cat_name,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("client")){
					sql1=sql3;
					sqlselect="coalesce(r.cldocno,0) refno,coalesce(a.refname,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("salesman")){
					sql1=sql3;
					sqlselect="coalesce(sal.doc_no,0) refno,coalesce(sal.sal_name,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("brand")){
					sql1=sql3;
					sqlselect="coalesce(veh.brdid,0) refno,coalesce(brd.brand_name,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("model")){
					sql1=sql3;
					sqlselect="coalesce(veh.vmodid,0) refno,coalesce(model.vtype,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("group")){
					sql1=sql3;
					sqlselect="coalesce(veh.vgrpid,0) refno,coalesce(grp.gname,'NA') description,";
				}
				else if(cmbgroup.equalsIgnoreCase("yom")){
					sql1=sql3;
					sqlselect="coalesce(veh.yom,0) refno,coalesce(yom.yom,0) description,";
				}
			    
		    	sqlgroup=" group by cc.refno";
			    
			    }else{
			    	sqlselect="coalesce(r.cldocno,0) refno,coalesce(a.refname,'NA') description,";
			    }
			    
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    
				if(!hidclientcat.equalsIgnoreCase("")){
					sql+=" and cat.doc_no in ("+hidclientcat+")";
				}
				if(!hidclient.equalsIgnoreCase("")){
					sql+=" and a.cldocno in ("+hidclient+")";
				}
				if(!hidsalesman.equalsIgnoreCase("")){
					sql+=" and sal.doc_no in ("+hidsalesman+")";
				}
				if(!hidbrand.equalsIgnoreCase("")){
					sql+=" and veh.brdid in ("+hidbrand+")";
				}
				if(!hidmodel.equalsIgnoreCase("")){
					sql+=" and veh.vmodid in ("+hidmodel+")";
				}
				if(!hidgroup.equalsIgnoreCase("")){
					sql+=" and veh.vgrpid in ("+hidgroup+")";
				}
				if(!hidyom.equalsIgnoreCase("")){
					sql+=" and veh.yom in ("+hidyom+")";
				}
				
			    sql = "select @i:=@i+1 id,cc.refno,cc.description,"+sql1+"cc.amount from (select "+sqlselect+""+sql2+"round(r.netamt,2) amount " 
			    	+ "from gl_rentreceipt r left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid "
			    	+ "left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la "
			    	+ "on (r.aggno=la.doc_no and r.rtype='LAG') left join my_clcatm cat on a.catid=cat.doc_no left join  gl_vehmaster veh on j.costcode=veh.fleet_no "
			    	+ "left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on "
			    	+ "veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join my_salm sal on a.sal_id=sal.doc_no left join my_brch b on r.brhid=b.branch "
			    	+ "left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno)cc,"
			    	+ "(SELECT @i:= 0) as i"+sqlgroup+" order by id";
			    
			    ResultSet resultSet = stmtCollection.executeQuery(sql);
			                
			    ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();

				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					
					temp.add(resultSet.getString("id"));
					temp.add(resultSet.getString("refno"));
					temp.add(resultSet.getString("description"));
					
					for (int l = 0; l < amountLength; l++) {
						temp.add(resultSet.getString("amount"+l+""));
					}
					
					analysisrowarray.add(temp);
				}

				 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
				 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				 
				 JSONArray analysisarray=new JSONArray();
				 
				 analysisarray.addAll(COLUMNDATA);
				 analysisarray.addAll(ROWDATA);
				 RESULTDATA=analysisarray;
			    
			    }
			    
			    stmtCollection.close();
			    conn.close();
			    
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray collectionExcelExportLoading(String branch,String fromdate,String todate,String hidclientcat,String hidclient,String hidsalesman,
			String hidbrand,String hidmodel,String hidgroup,String hidyom) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCollection = conn.createStatement();
			    
			    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
			    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    
			    if(!hidclientcat.equalsIgnoreCase("")){
					sql+=" and cat.doc_no in ("+hidclientcat+")";
				}
				if(!hidclient.equalsIgnoreCase("")){
					sql+=" and a.cldocno in ("+hidclient+")";
				}
				if(!hidsalesman.equalsIgnoreCase("")){
					sql+=" and sal.doc_no in ("+hidsalesman+")";
				}
				if(!hidbrand.equalsIgnoreCase("")){
					sql+=" and veh.brdid in ("+hidbrand+")";
				}
				if(!hidmodel.equalsIgnoreCase("")){
					sql+=" and veh.vmodid in ("+hidmodel+")";
				}
				if(!hidgroup.equalsIgnoreCase("")){
					sql+=" and veh.vgrpid in ("+hidgroup+")";
				}
				if(!hidyom.equalsIgnoreCase("")){
					sql+=" and veh.yom in ("+hidyom+")";
				}
			    
			    sql = "select cc.branch 'Branch',cc.rdocno 'Doc No',cc.date 'Date',cc.dtype 'Doc Type',cc.srno 'RRV No.',cc.refname 'Client',concat(cc.payas,' ',cc.cardtype) 'Paid As',coalesce(cc.rano,'') as 'Agreement',cc.cashtotal 'Cash Total',cc.cardtotal 'Card Total',cc.chequetotal 'Cheque Total' from "
						+ "(select if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
						+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,if(r.payas=1,concat(jv.rtype,' - ',CONVERT(jv.rdocno,CHAR(100))),concat(r.rtype,' - ',CONVERT(if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(100)))) rano,"
						+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from gl_rentreceipt r "
						+ "left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on "
						+ "(r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_clcatm cat on a.catid=cat.doc_no left join  gl_vehmaster veh on j.costcode=veh.fleet_no "
						+ "left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no "
						+ "left join my_salm sal on a.sal_id=sal.doc_no left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
						+ "r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno)cc";
			    
			    ResultSet resultSet = stmtCollection.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
			    stmtCollection.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray clientCategorySearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtCollection=conn.createStatement();
			
			String strSql="select doc_no,cat_name clientcatname from my_clcatm where status=3 and dtype='CRM'";
            
			ResultSet resultSet = stmtCollection.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtCollection.close();
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
			Statement stmtCollection=conn.createStatement();
			
			String strSql="select doc_no,sal_name clientslmname from my_salm where status=3";
            
			ResultSet resultSet = stmtCollection.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtCollection.close();
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
			 Statement stmtCollection = conn.createStatement();
			 
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
			
			ResultSet resultSet = stmtCollection.executeQuery(clsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			stmtCollection.close();
			conn.close();
			
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
        			conn.close();
        	}
			
	        return RESULTDATA;
    }
    
    public JSONArray brandSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtCollection=conn.createStatement();
			
			String strSql="select doc_no,brand_name brand from gl_vehbrand where status=3";
            ResultSet resultSet = stmtCollection.executeQuery (strSql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
            stmtCollection.close();
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
        return RESULTDATA;
    }
    
	public JSONArray modelSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtCollection=conn.createStatement();
			
			String strSql="select model.doc_no,model.vtype model from gl_vehmodel model where model.status=3 ";
            ResultSet resultSet = stmtCollection.executeQuery (strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtCollection.close();
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
        return RESULTDATA;
    }
	
	
	public JSONArray groupSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtCollection=conn.createStatement();
				
			String strSql="select doc_no,gname from gl_vehgroup where status=3";
            ResultSet resultSet = stmtCollection.executeQuery (strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtCollection.close();
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
        return RESULTDATA;
    }
	
	public JSONArray yomSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtCollection=conn.createStatement();
				
			String strSql="select doc_no,yom from gl_yom";
            ResultSet resultSet = stmtCollection.executeQuery (strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
        	
        	stmtCollection.close();
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
			
			for (int j = 3,k=0; j < length; j++,k++) {
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