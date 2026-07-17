package com.dashboard.accounts.mainaccountstatement;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMainAccountStatementDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray mainaccountStatement(String branch,String fromdate,String todate,String atype,String account,String chckopening,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement = conn.createStatement();
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
				String sql = "";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhid="+branch+"";
	    		}
				
				if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql+=" and h.grpno='"+account+"'";
	            }
				
				if(chckopening.equalsIgnoreCase("1")){
	                sql+=" and j.date<='"+sqlToDate+"'";
	            } else {
	            	sql+=" and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'";
	            }
            			
				sql = "select t.account,t.description accountname,a.acno,CONVERT(if(a.dramount>0,round((a.dramount*1),2),''),CHAR(50)) dr,"  
						+ "CONVERT(if(a.dramount<0,round((a.dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(a.ldramount>0,round((a.ldramount*1),2),''),CHAR(50)) debit," 
						+ "CONVERT(if(a.ldramount<0,round((a.ldramount*-1),2),''),CHAR(50)) credit,a.tr_no,a.curId,c.code currency,round((a.rate),2) rate from (" 
						+ "select sum(j.dramount) dramount,sum(j.ldramount) ldramount,h.grpno acno,j.curId,j.rate,j.tr_no from my_jvtran j inner join my_head h on "
						+ "j.acno=h.doc_no where j.status=3 and j.yrid=0"+sql+" group by h.grpno) a left join my_head t on a.acno=t.doc_no left join my_curr c on c.doc_no=a.curId "
						+ "where a.dramount!=0 and t.atype='"+atype+"'";
				
				ResultSet resultSet = stmtMainAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtMainAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountStatementDetail(String branch,String fromdate,String todate,String atype,String account,String chckopening) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement = conn.createStatement();
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }

		        String sql = "";
		        
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql=sql+" and h.grpno='"+account+"'";
	            }
				
				if(chckopening.equalsIgnoreCase("1")){
	                sql+=" and j.date<='"+sqlToDate+"'";
	            } else {
	            	sql+=" and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'";
	            }
            			
				sql = "select t.account,t.description accountname,a.acno,CONVERT(if(a.dramount>0,round((a.dramount*1),2),''),CHAR(50)) dr,"  
						+ "CONVERT(if(a.dramount<0,round((a.dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(a.ldramount>0,round((a.ldramount*1),2),''),CHAR(50)) debit," 
						+ "CONVERT(if(a.ldramount<0,round((a.ldramount*-1),2),''),CHAR(50)) credit,if(a.transtype='ÍNV',m.voc_no,a.transno) transno,a.transtype,"
						+ "date(a.trdate) trdate,a.tr_des description,a.ref_detail,a.tr_no,a.curId,c.code currency,round((a.rate),2) rate from (" 
						+ "select j.dramount,j.ldramount,h.grpno acno,j.date trdate,j.ref_detail,j.description tr_des,j.curId,j.rate," 
						+ "j.doc_no transno,j.dtype transtype,j.tr_no from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and j.yrid=0"+sql+") a "
						+ "left join my_head t on a.acno=t.doc_no left join my_curr c on c.doc_no=a.curId left join gl_invm m on m.dtype=a.transtype and "
						+ "a.transno=m.doc_no where a.dramount!=0 and t.atype='"+atype+"'";
				
				ResultSet resultSet = stmtMainAccountStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtMainAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountStatementDetailGrid() throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement = conn.createStatement();
	        	
				ResultSet resultSet1 = stmtMainAccountStatement.executeQuery ("select jv.tr_no,CONVERT(if(jv.dramount>0,round((jv.dramount*jv.id),2),''),CHAR(100)) dr,CONVERT(if(jv.dramount<0,round((jv.dramount*jv.id),2),''),CHAR(100)) cr,"
						+ "CONVERT(if(jv.ldramount>0,round((jv.ldramount*jv.id),2),''),CHAR(100)) drcur,CONVERT(if(jv.ldramount<0,round((jv.ldramount*jv.id),2),''),CHAR(100)) crcur,t.description account,c.code currency,round((c.c_rate),2) rate "
						+ "from my_jvtran jv left join my_head t on jv.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where jv.status=3 and jv.yrid=0");
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtMainAccountStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}

	public JSONArray accountDetails(String type,String account,String partyname,String chk) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtMainAccountStatement1 = conn.createStatement();
				
				sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.m_s=1 and t.atype='"+type+"'"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtMainAccountStatement1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				
				else{
					stmtMainAccountStatement1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtMainAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  ClsMainAccountStatementBean getPrint(HttpServletRequest request,String account,String atype,String branch,String fromdate,String todate,String chckopening) throws SQLException {
		ClsMainAccountStatementBean bean = new ClsMainAccountStatementBean();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtMainAccountStatement = conn.createStatement();
		
		if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
            sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        
		if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
            sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
      
		String sql="select 'Statement of Account' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"' ,'%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
			+ "CASE WHEN t.atype='AP' THEN 'ACCOUNTS PAYABLE' WHEN t.atype='AR' THEN 'ACCOUNTS RECEIVABLE' WHEN t.atype='GL' THEN 'GENERAL LEDGER' WHEN t.atype='HR' THEN 'HUMAN RESOURCE' "
			+ "END as 'description',c.company,c.address,c.tel,c.fax,b.branchname,b.pbno,b.stcno,b.cstno,l.loc_name location from my_jvtran j left join my_head t on j.acno=t.doc_no left join "
			+ "my_brch b on j.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no where t.atype='"+atype+"' group by t.atype";
		
		ResultSet resultSet = stmtMainAccountStatement.executeQuery(sql);
		
		while(resultSet.next()){

			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
			
			bean.setAccountname(resultSet.getString("description"));
		}
		
		String sql1 = "";
		
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			sql1+=" and j.brhId="+branch+"";
		}
		
		if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
            sql1=sql1+" and h.grpno='"+account+"'";
        }
		
		if(chckopening.equalsIgnoreCase("1")){
            sql1+=" and j.date<='"+sqlToDate+"'";
        } else {
        	sql1+=" and j.date>='"+sqlFromDate+"' and j.date<='"+sqlToDate+"'";
        }
		
		sql1 = "select k.*,round((k.debit+(k.credit)*-1),2) nettotal from (select t.account,t.description accountname,a.acno,CONVERT(if(a.dramount>0,round((a.dramount*1),2),' '),CHAR(50)) dr,"  
			+ "CONVERT(if(a.dramount<0,round((a.dramount*-1),2),' '),CHAR(50)) cr,CONVERT(if(a.ldramount>0,round((a.ldramount*1),2),' '),CHAR(50)) debit,"
			+ "CONVERT(if(a.ldramount<0,round((a.ldramount*-1),2),' '),CHAR(50)) credit,a.tr_no,a.curId,c.code currency,round((a.rate),2) rate from ("
			+ "select sum(j.dramount) dramount,sum(j.ldramount) ldramount,h.grpno acno,j.curId,j.rate,j.tr_no from my_jvtran j inner join my_head h on "
			+ "j.acno=h.doc_no where j.status=3 and j.yrid=0"+sql1+" group by h.grpno) a left join my_head t on a.acno=t.doc_no left join my_curr c on c.doc_no=a.curId "
			+ "where a.dramount!=0 and t.atype='"+atype+"') k";
		
		ResultSet resultSet1 = stmtMainAccountStatement.executeQuery(sql1);
		
		ArrayList<String> printarray= new ArrayList<String>();
		Double netamount=0.00;
		
		while(resultSet1.next()){
			String temp="";
			
			netamount=netamount+resultSet1.getDouble("nettotal");
			
			temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
		    printarray.add(temp);
		}
		request.setAttribute("printingarray", printarray);
		
		netamount = ClsCommon.Round(netamount, 2);
		bean.setLblnetamount(String.valueOf(netamount));
		
		stmtMainAccountStatement.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
}

	
}
