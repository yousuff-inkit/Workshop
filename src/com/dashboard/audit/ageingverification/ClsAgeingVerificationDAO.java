package com.dashboard.audit.ageingverification;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgeingVerificationDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public int insert(String cmbbranch, String atype, Date upToDate, ArrayList<String> ageingdifferencearray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		 
		Connection conn  = null;
		  
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBIAV = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
		        int docNo=0;
				
				String sqlsd="update my_jvtran set id=1 where dramount>0";
		        int datad=stmtBIAV.executeUpdate(sqlsd);
		        
		        String sqlsd1="update my_jvtran set id=-1 where dramount<0";
		        int datad1=stmtBIAV.executeUpdate(sqlsd1);
		        
		        String sql="select coalesce(max(doc_no)+1,1) doc_no from gl_biav";
		        ResultSet resultSet = stmtBIAV.executeQuery(sql);
		  
		        while (resultSet.next()) {
				   docNo=resultSet.getInt("doc_no");
		        }
		        
		        String[] ageingdifference=ageingdifferencearray.get(0).split("::");
		        int acno = (Integer.parseInt((ageingdifference[1].trim().equalsIgnoreCase("undefined") || ageingdifference[1].trim().equalsIgnoreCase("NaN") || ageingdifference[1].trim().isEmpty()?"0":ageingdifference[1].trim().toString())));
		        
		        ArrayList<String> outamtarray=new ArrayList<>();
		        
		        for(int i=0;i< ageingdifferencearray.size();i++){
					String[] applydifference=ageingdifferencearray.get(i).split("::");
					
					if(!applydifference[0].trim().equalsIgnoreCase("undefined") && !applydifference[0].trim().equalsIgnoreCase("NaN")){
						
						  String sql1="";
						
						  int tranid = (Integer.parseInt((applydifference[0].trim().equalsIgnoreCase("undefined") || applydifference[0].trim().equalsIgnoreCase("NaN") || applydifference[0].trim().isEmpty()?"0":applydifference[0].trim().toString())));
						  int id = (Integer.parseInt((applydifference[4].trim().equalsIgnoreCase("undefined") || applydifference[4].trim().equalsIgnoreCase("NaN") || applydifference[4].trim().isEmpty()?"0":applydifference[4].trim().toString())));
						  
						  /*Selecting Ap_Tran-Id*/ 
						   if(atype.equalsIgnoreCase("AR")){
							   if(id==1){
								   sql1="select tranid ap_trid,amount from my_outd where ap_trid="+tranid+""; 
							   }else if(id==-1){
								   sql1="select ap_trid,amount from my_outd where tranid="+tranid+"";
							   }
						   }else if(atype.equalsIgnoreCase("AP")){
							   if(id==1){
								   sql1="select ap_trid,amount from my_outd where tranid="+tranid+""; 
							   }else if(id==-1){
								   sql1="select tranid ap_trid,amount from my_outd where ap_trid="+tranid+"";
							   }
						   }
						   
						   ResultSet resultSet1=stmtBIAV.executeQuery(sql1);
						   
						   while(resultSet1.next()){
							   outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
						   } 
						  /*Selecting Ap_Tran-Id Ends*/
						   
						   for(int j=0;j<outamtarray.size();j++){
							   
							   int ap_trid=Integer.parseInt(outamtarray.get(j).split("::")[0]);
							   double amount=Double.parseDouble(outamtarray.get(j).split("::")[1]);

							   String sql2="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
							   int data1=stmtBIAV.executeUpdate(sql2);
							   
							}
						   
						     String sql3="update my_jvtran set out_amount=0 where tranid="+tranid+"";
						     int data3=stmtBIAV.executeUpdate(sql3);
							   
							 /*Deleting from my_outd*/
							 String sql4="delete from my_outd where tranid="+tranid+"";
							 int data4=stmtBIAV.executeUpdate(sql4);
							 
							 /*Inserting gl_biav*/
							 String sql5="insert into gl_biav(doc_no, date, reason, type, acno, out_amount, applied, tranid, brhid, userid) values("+docNo+", '"+upToDate+"', 'APPLYING DIFFERENCE ISSUE', '"+atype+"', '"+acno+"', "+((applydifference[2].equalsIgnoreCase("undefined") || applydifference[2].equalsIgnoreCase("NaN") || applydifference[2].isEmpty()?0.0:Double.parseDouble(applydifference[2])))+", "+((applydifference[3].equalsIgnoreCase("undefined") || applydifference[3].equalsIgnoreCase("NaN") || applydifference[3].isEmpty()?0.0:Double.parseDouble(applydifference[3])))+", '"+tranid+"', '"+branch+"', '"+userid+"')";
						     int data5= stmtBIAV.executeUpdate(sql5);
							 if(data5<=0){
								 	stmtBIAV.close();
									conn.close();
									return 0;
							 }
							 /*Inserting gl_biav Ends*/
					}
		        }
				 
				if(docNo>0){
					
					 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','BIAV',now(),'"+userid+"','A')";
					 int datas= stmtBIAV.executeUpdate(sqls);
					 if(datas<=0){
						    stmtBIAV.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBIAV.close();
					conn.close();
					return docNo;
				}
			stmtBIAV.close();
			conn.close();	
		 } catch(Exception e){	
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 } finally{
			 conn.close();
		 }
		return 0;
	}
		
	public JSONArray ageingVerificationGridLoading(String rpttype, String uptodate, String atype, String check) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBIAV = conn.createStatement();
				
				java.sql.Date sqlUpToDate = null;
		        
				if(check.equalsIgnoreCase("1")){
					
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
			          sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
			    }	
					
				String sql = "";
				
				if(rpttype.equalsIgnoreCase("1")){
					
				if(atype.equalsIgnoreCase("AR")){
					
						sql = "select aa.* ,round(accounting,2) accounting,round((ageing-accounting),2) balance from (select ag.acno,ag.name,ag.account,ag.brhid,ag.tranid,ag.tr_no,round((sum(t7+u6)),2) ageing from ( "
							+ "select d.name,d.account,d.acno,d.brhid,d.tranid,d.tr_no,if(d.bal<0,round((d.bal),2),0) U6,if(d.bal>0,d.bal,0) t7 from ( select j.acno,j.brhid,h.account,"
							+ "h.description name,sum(dramount-out_amount) bal,j.tranid,j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='"+atype+"' "
							+ "and j.yrid=0 and j.date<='"+sqlUpToDate+"' group by tranid having bal<>0) d ) ag where 1=1 group by acno) aa left join (select sum(dramount) accounting,acno from "
							+ "my_jvtran where status=3 and yrid=0 and date<='"+sqlUpToDate+"' group by acno) accounting on accounting.acno=aa.acno having balance>1 or balance<-1";
							
				} else if(atype.equalsIgnoreCase("AP")){
							  
						sql = "select aa.* ,round(accounting,2) accounting,round((ageing-accounting),2) balance from (select ag.acno,ag.name,ag.account,ag.brhid,ag.tranid,ag.tr_no,round((sum(t7+u6)),2) ageing from ( "
							+ "select d.name,d.account,d.acno,d.brhid,d.tranid,d.tr_no,if(d.bal>0,round((d.bal),2),0) U6,if(d.bal<0,d.bal,0) t7 from ( select j.acno,j.brhid,h.account,"
							+ "h.description name,sum(dramount-out_amount) bal,j.tranid,j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='"+atype+"' "
							+ "and j.yrid=0 and j.date<='"+sqlUpToDate+"' group by tranid having bal<>0) d ) ag where 1=1 group by acno) aa left join (select sum(dramount) accounting,acno from "
							+ "my_jvtran where status=3 and yrid=0 and date<='"+sqlUpToDate+"' group by acno) accounting on accounting.acno=aa.acno having balance>1 or balance<-1";
					
				  }
				
				} else if(rpttype.equalsIgnoreCase("2")){
					
				if(atype.equalsIgnoreCase("AR")){
					
						sql = "select aa.* ,round(accounting,2) accounting,round((ageing-accounting),2) balance from (select name,account,acno,brhid,tranid,tr_no,round((sum(t7+u6)),2) ageing from (select d.name,d.account,d.acno,d.brhid,"
							+ "d.tranid,d.tr_no,if(d.bal<0,round((d.bal),2),0) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.account,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, "
							+ "j.tranid, j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j "
							+ "on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.id > 0 "
							+ "group by j.tranid having bal<>0 union all select j.acno,j.brhid,h.account,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal,j.tranid, j.tr_no from my_jvtran j inner join "
							+ "my_head h on j.acno=h.doc_no left join ( select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' "
							+ "group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.id < 0 group by j.tranid having bal<>0) d) ag group by acno) aa "  
							+ "left join (select sum(dramount) accounting,acno from my_jvtran where status=3 and yrid=0 and date<='"+sqlUpToDate+"' group by acno) accounting on accounting.acno=aa.acno having balance>1 or balance<-1";
							
				} else if(atype.equalsIgnoreCase("AP")){
							  
						sql = "select aa.* ,round(accounting,2) accounting,round((ageing-accounting),2) balance from (select name,account,acno,brhid,tranid,tr_no,round((sum(t7+u6)),2) ageing from ( " 
							+ "select d.name,d.account,d.acno,d.brhid,d.tranid,d.tr_no,if(d.bal>0,round((d.bal),2),0) U6,if(d.bal<0,d.bal,0) t7 from ( select j.acno,j.brhid,h.account,h.description name,"
							+ "sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount "
							+ "from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' "
							+ "and j.date<='"+sqlUpToDate+"'  and j.id < 0 group by j.tranid having bal<>0 union all select j.acno,j.brhid,h.account,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal,"
							+ "j.tranid, j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no left join ( select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j "
							+ "on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.id > 0 "
							+ "group by j.tranid having bal<>0) d ) ag group by acno) aa left join (select sum(dramount) accounting,acno from my_jvtran where status=3 and yrid=0 and date<='"+sqlUpToDate+"' group by acno) "  
							+ "accounting on accounting.acno=aa.acno having balance>1 or balance<-1";
						
				  }
				
				}

				ResultSet resultSet = stmtBIAV.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				stmtBIAV.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray ageingDifferenceGridLoading(String atype, String accountno, String rpttype,String check) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBIAV = conn.createStatement();

				if(rpttype.equalsIgnoreCase("1")){
					
					String sql="";
					
					if(atype.equalsIgnoreCase("AR")){
						
						sql = "select a.id,a.brhid,a.curid currency,a.acno,a.tranid,a.tr_no,a.doc_no transno,a.dtype transtype,a.description,a.date,a.dramount,a.out_amount,a.applied,((a.out_amount*a.id)-a.applied) balance from (select j.acno,j.tranid,j.tr_no,"
							+ "j.doc_no,j.dtype,j.description,j.date,j.dramount,j.out_amount,j.id,j.brhid,j.curid,d.amount applied from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran j1 on j1.tranid=d.tranid and "
							+ "j1.status=3 where j.status=3 and j.dramount>0 and j.acno="+accountno+" and j1.tranid is null and j.out_amount!=0 UNION ALL select j.acno,j.tranid,j.tr_no,j.doc_no,j.dtype,j.description,j.date,j.dramount,"
							+ "j.out_amount,j.id,j.brhid,j.curid,d.amount applied from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran j1 on j1.tranid=d.ap_trid and j1.status=3 where j.status=3 and j.dramount<0 and "
							+ "j.acno="+accountno+" and j1.tranid is null and j.out_amount!=0) a";
						
					} else if(atype.equalsIgnoreCase("AP")){
						
						sql = "select a.id,a.brhid,a.curid currency,a.acno,a.tranid,a.tr_no,a.doc_no transno,a.dtype transtype,a.description,a.date,a.dramount,a.out_amount,a.applied,((a.out_amount*a.id)-a.applied) balance from (select j.acno,j.tranid,j.tr_no,"
							+ "j.doc_no,j.dtype,j.description,j.date,j.dramount,j.out_amount,j.id,j.brhid,j.curid,d.amount applied from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran j1 on j1.tranid=d.tranid and "
							+ "j1.status=3 where j.status=3 and j.dramount<0 and j.acno="+accountno+" and j1.tranid is null and j.out_amount!=0 UNION ALL select j.acno,j.tranid,j.tr_no,j.doc_no,j.dtype,j.description,j.date,j.dramount,"
							+ "j.out_amount,j.id,j.brhid,j.curid,d.amount applied from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran j1 on j1.tranid=d.ap_trid and j1.status=3 where j.status=3 and j.dramount>0 and "
							+ "j.acno="+accountno+" and j1.tranid is null and j.out_amount!=0 ) a";
	            	
					}
					
					ResultSet resultSet = stmtBIAV.executeQuery(sql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);

				} else if(rpttype.equalsIgnoreCase("2")){
					
					String sql="";
					
					if(atype.equalsIgnoreCase("AR")){
						
						sql = "select a.id,a.acno,a.tranid,a.tr_no,a.doc_no transno,a.dtype transtype,a.description,a.date,a.dramount,a.out_amount,a.applied,((a.out_amount*a.id)-a.applied) balance,a.currency from (select j.acno,j.tranid,"
							+ "j.tr_no,j.doc_no,j.dtype,j.description,j.date,j.dramount,j.out_amount,j.id,j.curid currency,sum(d.amount) applied from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where status=3 and j.dramount>0 "
							+ "and j.acno="+accountno+" group by d.ap_trid having applied<>(j.out_amount*j.id) UNION ALL select j.acno,j.tranid,j.tr_no,j.doc_no,j.dtype,j.description,j.date,j.dramount,j.out_amount,j.id,j.curid currency,"
							+ "sum(d.amount) applied from my_jvtran j left join  my_outd d on j.tranid=d.tranid where status=3 and j.dramount<0 and j.acno="+accountno+" group by d.tranid having applied<>(j.out_amount*j.id)) a";
	            	
					} else if(atype.equalsIgnoreCase("AP")){
						
						sql = "select a.id,a.acno,a.tranid,a.tr_no,a.doc_no transno,a.dtype transtype,a.description,a.date,a.dramount,a.out_amount,a.applied,((a.out_amount*a.id)-a.applied) balance,a.currency from (select j.acno,j.tranid,"
							+ "j.tr_no,j.doc_no,j.dtype,j.description,j.date,j.dramount,j.out_amount,j.id,j.curid currency,sum(d.amount) applied from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where status=3 and j.dramount<0 "
							+ "and j.acno="+accountno+" group by d.ap_trid having applied<>(j.out_amount*j.id) UNION ALL select j.acno,j.tranid,j.tr_no,j.doc_no,j.dtype,j.description,j.date,j.dramount,j.out_amount,j.id,j.curid currency,"
							+ "sum(d.amount) applied from my_jvtran j left join  my_outd d on j.tranid=d.tranid where status=3 and j.dramount>0 and j.acno="+accountno+" group by d.tranid having applied<>(j.out_amount*j.id)) a";
	            	
					}
					
					ResultSet resultSet = stmtBIAV.executeQuery(sql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				
				stmtBIAV.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }

}
