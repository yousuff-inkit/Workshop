package com.dashboard.workshop.partsdisbursmentfancy;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

import java.sql.*;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;
public class ClsWSPartsDisbursmentFancyDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getPartsMgmtData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select apprvalue+totalvalue estvalue,round(coalesce(spare2.price,0),2) pendingcash,round(coalesce(spare3.price,0),2) pendingcredit,jc.date jobdate,fl.jobdocno, fl.rowno,fl.partremarks,fl.jobvocno, fl.vehicledetails, fl.billto, fl.client refname, fl.service, datediff(curdate(),jc.date) age,"+
			" fl.priority, fl.partsstatus, fl.partsexpdate, fl.promiseddate, fl.extdate, fl.esthrs, fl.actualhrs, fl.hrsdiff, fl.grpname, fl.estimator, fl.srvcadvisor, fl.salesman, "+
			" fl.insursurvivor, fl.referredby,jc.refno from ws_floormgmtdata fl left join ws_jobcard jc on fl.jobdocno=jc.doc_no left join ws_estm est on (jc.reftype='EST' and jc.refno=est.doc_no) "+
			" left join ws_gateinpass gate on est.gipno=gate.doc_no left join (select rdocno from ws_estspare where status in ('CASH','CREDIT') and disbursconfirmstatus=0 group by rdocno) spare on est.doc_no=spare.rdocno "+
			"  left join (select sum(coalesce(costprice*qty,0)) price,rdocno from ws_estspare where coalesce(status,'')='CASH' and disbursconfirmstatus=0 group by rdocno) spare2 on est.doc_no=spare2.rdocno "+
			"  left join (select sum(coalesce(costprice*qty,0)) price,rdocno from ws_estspare where coalesce(status,'')='CREDIT' and disbursconfirmstatus=0 group by rdocno) spare3 on est.doc_no=spare3.rdocno "
			+ "left join (select sum(coalesce(approvedvalue,0)) apprvalue,rdocno from ws_estspare group by rdocno) spare4 "
			+ "on est.doc_no=spare4.rdocno left join (select sum(coalesce(total,0)) totalvalue,rdocno from ws_estlabour "
			+ "group by rdocno) labour1 on est.doc_no=labour1.rdocno where gate.processstatus<6 and jc.status=3 "
			+ "and spare.rdocno is not null";
			System.out.println("strsql--->>>"+strsql);  
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getPartsMgmtDataExcel(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsqlexcel="select jc.date 'Job Date',fl.jobvocno 'Job No',fl.vehicledetails 'Vehicle Details', "
					+ "fl.client 'Client',round(coalesce(spare2.price,0),2) 'Pending Cash', "
					+ "round(coalesce(spare3.price,0),2) 'Pending Credit',apprvalue+totalvalue 'Estimation Value',fl.promiseddate 'Promised Date',fl.service 'Service',datediff(curdate(),jc.date) 'Age', "
					+ "fl.priority 'Priority',fl.partsstatus 'Parts Status',fl.partsexpdate 'Parts Exp.Date', "
					+ "fl.extdate 'Extended Date',fl.esthrs 'Est.Hrs',fl.actualhrs 'Actual Hrs.', "
					+ "fl.hrsdiff 'Hrs. Diff.',fl.grpname 'Group',fl.estimator 'Estimator', fl.srvcadvisor 'Service Advisor', "
					+ "fl.salesman 'Salesman',fl.partremarks 'Part Remarks',fl.insursurvivor 'Insurance Survivor', "
					+ "fl.referredby 'Referred by',jc.refno 'Refno',fl.billto 'Bill To' from ws_floormgmtdata fl "
					+ "left join ws_jobcard jc on fl.jobdocno=jc.doc_no left join ws_estm est on "
					+ "(jc.reftype='EST' and jc.refno=est.doc_no) left join ws_gateinpass gate on est.gipno=gate.doc_no left join "
					+ "(select rdocno from ws_estspare where status in ('CASH','CREDIT') and disbursconfirmstatus=0 group by rdocno) "
					+ "spare on est.doc_no=spare.rdocno left join (select sum(coalesce(costprice*qty,0)) price,rdocno from "
					+ "ws_estspare where coalesce(status,'')='CASH' and disbursconfirmstatus=0 group by rdocno) spare2 "
					+ "on est.doc_no=spare2.rdocno left join (select sum(coalesce(costprice*qty,0)) price,rdocno "
					+ "from ws_estspare where coalesce(status,'')='CREDIT' and disbursconfirmstatus=0 group by rdocno) spare3 on "
					+ "est.doc_no=spare3.rdocno left join (select sum(coalesce(approvedvalue,0)) apprvalue,rdocno "
					+ "from ws_estspare group by rdocno) spare4 on est.doc_no=spare4.rdocno left join "
					+ "(select sum(coalesce(total,0)) totalvalue,rdocno from ws_estlabour group by rdocno) labour1 on "
					+ "est.doc_no=labour1.rdocno where gate.processstatus<6 and jc.status=3 and spare.rdocno is not null";
			
			
			System.out.println("strsql excel--->>>"+strsqlexcel);  
			
			
			ResultSet rs=stmt.executeQuery(strsqlexcel);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	
	
	
	
	
	public JSONArray getCashData(String id,String jobdocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select disbursconfirmstatus,rowno,description productname,qty,coalesce(costprice,0.0) costprice,qty*coalesce(costprice,0.0) total from ws_estspare spare left join ws_jobcard job on (spare.rdocno=job.refno and job.reftype='EST') where job.doc_no="+jobdocno+" and spare.status='CASH'";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return data;
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getCreditData(String id,String jobdocno) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select description productname,qty,coalesce(costprice,0.0) costprice,qty*coalesce(costprice,0.0) total from ws_estspare spare left join ws_jobcard job on (spare.rdocno=job.refno and job.reftype='EST') where job.doc_no="+jobdocno+" and spare.status='CREDIT'";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return data;
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getAccountData(String fromto,String id) throws SQLException {
		JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn = null; 
	    try {
	    	conn = objconn.getMyConnection();
		    Statement stmt = conn.createStatement();
	        String den= "";
	        if(fromto.equalsIgnoreCase("1")){
	        	den="604,305";
			}
			else{
				den="604";
			}
	        String sql="select t.doc_no,t.account,t.description from my_head t where t.atype='GL' and t.m_s=0 and t.den in("+den+")";
	        System.out.println(sql);
		    ResultSet resultSet = stmt.executeQuery(sql);
		    data=objcommon.convertToJSON(resultSet);
	        stmt.close();
		    conn.close();
		       
	    }
	    catch(Exception e){
	    	e.printStackTrace();
	    	conn.close();
	    }
	    finally{
	    	conn.close();
		}
	    return data;
	}

}
