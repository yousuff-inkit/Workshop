package com.dashboard.integration.accountmaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccountMasterDAO  {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	
	public int insert(String mainbranch,String txtselectedaccounts, String[] accountarray, String[] accountsbrhidarray, ArrayList<String> accountmasterarray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		 Connection conn  = null;
		  
			try{
				
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBAM = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
		        
				Set<String> set = new HashSet<String>(Arrays.asList(accountarray));
				accountarray = set.toArray(new String[set.size()]);
				
				Set<String> sets = new HashSet<String>(Arrays.asList(accountsbrhidarray));
				accountsbrhidarray = sets.toArray(new String[sets.size()]);
				
		        int docNo=0, trno = 0;
		       /*Updating my_accounting*/
				for (int i = 0; i < accountarray.length; i++) {
					String account=accountarray[i];	
					String accountbranch=accountsbrhidarray[i];
					
					if(!(account.equalsIgnoreCase(""))){
						 String sql1="delete from my_accounting where acno='"+account+"' and brhid="+accountbranch+"";
						 stmtBAM.executeUpdate(sql1);
						 
						 String sql2="select coalesce(max(trno)+1,1) trno from my_trno";
					     ResultSet resultSet2 = stmtBAM.executeQuery(sql2);
					  
					     while (resultSet2.next()) {
					        trno=resultSet2.getInt("trno");
					     }
						 
						 CallableStatement stmtBOPN1=null;
						 String[] openingbalance=accountmasterarray.get(i).split("::");
							if(!openingbalance[0].equalsIgnoreCase("undefined") && !openingbalance[0].equalsIgnoreCase("NaN")){
							    
								stmtBOPN1 = conn.prepareCall("INSERT INTO my_accounting(tr_no, acno, gp, hr, autoline, brhid, dtype) VALUES(?,?,?,?,?,?,?)");
								
								stmtBOPN1.setInt(1,trno);
								stmtBOPN1.setString(2,(openingbalance[0].trim().equalsIgnoreCase("undefined") || openingbalance[0].trim().equalsIgnoreCase("NaN") || openingbalance[0].trim().equalsIgnoreCase("") ||openingbalance[0].trim().isEmpty()?"0":openingbalance[0].trim()).toString());
								stmtBOPN1.setString(3,(openingbalance[1].trim().equalsIgnoreCase("undefined") || openingbalance[1].trim().equalsIgnoreCase("NaN") || openingbalance[1].trim().equalsIgnoreCase("") ||openingbalance[1].trim().isEmpty()?"0":openingbalance[1].trim()).toString());
								stmtBOPN1.setString(4,(openingbalance[2].trim().equalsIgnoreCase("undefined") || openingbalance[2].trim().equalsIgnoreCase("NaN") || openingbalance[2].trim().equalsIgnoreCase("") ||openingbalance[2].trim().isEmpty()?"0":openingbalance[2].trim()).toString());
								stmtBOPN1.setString(5,(openingbalance[3].trim().equalsIgnoreCase("undefined") || openingbalance[3].trim().equalsIgnoreCase("NaN") || openingbalance[3].trim().equalsIgnoreCase("") ||openingbalance[3].trim().isEmpty()?"0":openingbalance[3].trim()).toString());
								stmtBOPN1.setString(6,(openingbalance[4].trim().equalsIgnoreCase("undefined") || openingbalance[4].trim().equalsIgnoreCase("NaN") || openingbalance[4].trim().equalsIgnoreCase("") ||openingbalance[4].trim().isEmpty()?"0":openingbalance[4].trim()).toString());
								stmtBOPN1.setString(7,"BAM");
								int data1 = stmtBOPN1.executeUpdate();
							    if(data1<=0){
									 stmtBOPN1.close();
									 conn.close();
									 return 0;
								 }
							 }
					    }
				     }
				/*Updating my_accounting Ends*/
				
			    String sql="select coalesce(max(doc_no)+1,1) doc_no from gl_baccmaster";
		        ResultSet resultSet = stmtBAM.executeQuery(sql);
		  
		        while (resultSet.next()) {
				   docNo=resultSet.getInt("doc_no");
		        }
		        
		        /*Inserting gl_baccmaster*/
			     String sql2="insert into gl_baccmaster(doc_no, date, tr_no, accounts, brhid, userid) values("+docNo+",now(),"+trno+",'"+txtselectedaccounts+"',"+branch+","+userid+")";
			     int data1= stmtBAM.executeUpdate(sql2);
				 if(data1<=0){
					    stmtBAM.close();
						conn.close();
						return 0;
					}
				 /*Inserting gl_baccmaster Ends*/
				 
				if(docNo>0){
					
					 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','BAM',now(),'"+userid+"','A')";
					 int datas= stmtBAM.executeUpdate(sqls);
					 if(datas<=0){
						    stmtBAM.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBAM.close();
					conn.close();
					return docNo;
				}
			stmtBAM.close();
			conn.close();	
		 } catch(Exception e){	
			 	conn.close();
			 	e.printStackTrace();	
			 	return 0;
		 } finally{
			 conn.close();
		 }
		return 0;
	}

	public JSONArray accountMasterGridLoading(String accounttype, String branch, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtBAM = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
	    	    String sql = "",sql1="";
				
	    	    if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase("0")) && !(branch.equalsIgnoreCase("null"))){
	    	    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    	    		sql1+=" and a.brhId="+branch+"";
	    	    	}
	    	    }
	    	    
	    	    if(!(accounttype.equalsIgnoreCase("")) && !(accounttype.equalsIgnoreCase("0")) && !(accounttype.equalsIgnoreCase("null"))){
	                sql=sql+" and h.gr_type='"+accounttype+"'";
	            }
	           
				sql = "select * from (select m.acno doc_no,m.gp,m.hr,m.autoline,h.account,h.description accountname,m.brhid,b.branchname from my_accounting m "
					+ "left join my_head h on m.acno=h.doc_no left join my_brch b on m.brhid=b.doc_no where m.dtype='BAM'"+sql+" group by m.acno,m.brhid UNION ALL "
					+ "select h.doc_no,0 gp, 0 hr, 0 autoline,h.account,h.description,b.doc_no brhid,b.branchname from my_head h,my_brch b where 1=1"+sql+") a "
					+ "where 1=1"+sql1+" group by a.doc_no,a.brhid";
				
				ResultSet resultSet1 = stmtBAM.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet1);
		        
		        }
		        
		        stmtBAM.close();
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
