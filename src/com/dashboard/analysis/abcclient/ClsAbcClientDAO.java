package com.dashboard.analysis.abcclient;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.security.ntlm.Client;

public class ClsAbcClientDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray getClient() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsales=conn.createStatement();
				String strSql="select cldocno,refname,coalesce(com_mob,'')phone,coalesce(per_mob,'')mobile from my_acbook where status<>7 and dtype='CRM'";
             	ResultSet resultSet = stmtsales.executeQuery (strSql);
        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        		stmtsales.close();
				return RESULTDATA;
  
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	 public JSONArray getClientData(String branch,String fromdate,String todate,String hidbrand,String hidmodel,String hidgroup,String hidyom,String temp,
			 String hidfleet,String hidclient) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        if(!temp.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn=null;
	        try {    	
	        	java.sql.Date sqlfromdate=null,sqltodate=null;
	        	String sqltest="";
	        	String sqlcommon="";
	        	if(!fromdate.equalsIgnoreCase("")){
	        		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	        	}
	        	if(!todate.equalsIgnoreCase("")){
	        		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	        	}
	        	if(sqlfromdate!=null){
	        		sqlcommon+=" and jv.date>='"+sqlfromdate+"'";
	        	}
	        	if(sqltodate!=null){
	        		sqlcommon+=" and jv.date<='"+sqltodate+"'";
	        	}
	        	if(!hidbrand.equalsIgnoreCase("")){
	        		sqltest+=" and veh.brdid in ("+hidbrand+")";
	        	}
	        	if(!hidmodel.equalsIgnoreCase("")){
	        		sqltest+=" and veh.vmodid in ("+hidmodel+")";
	        	}
	        	if(!hidgroup.equalsIgnoreCase("")){
	        		sqltest+=" and veh.vgrpid in ("+hidgroup+")";
	        	}
	        	if(!hidyom.equalsIgnoreCase("")){
	        		sqltest+=" and veh.yom in ("+hidyom+")";
	        	}
	        	if(!hidfleet.equalsIgnoreCase("")){
	        		sqltest+=" and veh.doc_no in ("+hidfleet+")";
	        	}
	        	if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase("a"))){
	        		sqlcommon+=" and jv.brhid="+branch;
	        	}
	        	if(!(hidclient.equalsIgnoreCase(""))){
	        		sqltest+=" and ac.cldocno in ("+hidclient+")";
	        	}
	        	sqlcommon+=" and jv.rtype in ('RAG','LAG')";
	        	conn=ClsConnection.getMyConnection();
	        	Statement stmtsearch=conn.createStatement();
	        	/*String strsql="select (sum(amount))*-1 usedvalue,a.*,case when a.rtype='RAG' and rag.clstatus=1 then datediff(rac.indate,rag.odate)"+
	        			" when a.rtype='RAG' and rag.clstatus=0 then datediff(CURDATE(),rag.odate) when a.rtype='LAG' and lag.clstatus=1 then"+
	        			" datediff(lac.indate,lag.outdate) when a.rtype='LAG' and lag.clstatus=0 then datediff(CURDATE(),lag.outdate) end useddays,"+
	        			" br.branchname branch,case when a.rtype='RAG' then rag.voc_no when a.rtype='LAG' then lag.voc_no end doc_no,a.rtype renttype,"+
	        			" ac.refname client,veh.fleet_no,veh.reg_no,brd.brand_name brand,model.vtype model from ("+
	        			" select cost.amount,jv.rdocno,jv.rtype,cost.tr_no,jv.brhid,cost.jobid,jv.date from my_costtran cost inner join my_jvtran jv on cost.tr_no=jv.tr_no"+
	        			" group by cost.tranid,cost.sr_no order by jv.rdocno,jv.rtype,cost.jobid)a left join gl_ragmt rag on (a.rtype='RAG' and a.rdocno=rag.doc_no)"+
	        			" left join gl_lagmt lag on (a.rtype='LAG' and a.rdocno=lag.doc_no) left join my_acbook ac on (if(a.rtype='RAG',rag.cldocno=ac.cldocno,"+
	        			" lag.cldocno=ac.cldocno) and ac.dtype='CRM') left join gl_ragmtclosem rac on (rag.doc_no=rac.agmtno and rag.clstatus=1)  left join"+
	        			" gl_lagmtclosem lac on (lag.doc_no=lac.agmtno and lag.clstatus=1) left join my_brch br on (a.brhid=br.doc_no) left join gl_vehmaster"+
	        			" veh on a.jobid=veh.fleet_no inner join gl_vehbrand  brd on veh.brdid=brd.doc_no inner join gl_vehmodel model on"+
	        			" veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no "+
	        			" where 1=1  "+sqltest+" group by rdocno,rtype,jobid";*/
String strsql="select (AMT)*-1 usedvalue,a.*,case when a.rtype='RAG' and rag.clstatus=1 then datediff(rac.indate,rag.odate)"+
" when a.rtype='RAG' and rag.clstatus=0 then datediff(CURDATE(),rag.odate) when a.rtype='LAG' and lag.clstatus=1 then"+
" datediff(lac.indate,lag.outdate) when a.rtype='LAG' and lag.clstatus=0 then datediff(CURDATE(),lag.outdate) end useddays,"+
" br.branchname branch,case when a.rtype='RAG' then rag.voc_no when a.rtype='LAG' then lag.voc_no end doc_no,a.rtype renttype,"+
" ac.refname client,veh.fleet_no,veh.reg_no,brd.brand_name brand,model.vtype model from ("+
" select SUM(AMOUNT) AMT,jv.rdocno,jv.rtype,cost.tr_no,jv.brhid,cost.jobid,jv.date from my_costtran cost"+
" inner join my_jvtran jv on cost.trANID=jv.trANID where 1=1 "+sqlcommon+""+
" group by rtype,rdocno,jobid)a left join gl_ragmt rag on (a.rtype='RAG' and a.rdocno=rag.doc_no) left join gl_lagmt lag on"+
" (a.rtype='LAG' and a.rdocno=lag.doc_no) left join my_acbook ac on (if(a.rtype='RAG',rag.cldocno=ac.cldocno,"+
" lag.cldocno=ac.cldocno) and ac.dtype='CRM') left join gl_ragmtclosem rac on (rag.doc_no=rac.agmtno and rag.clstatus=1)"+
" left join gl_lagmtclosem lac on (lag.doc_no=lac.agmtno and lag.clstatus=1) left join my_brch br on (a.brhid=br.doc_no)"+
" left join gl_vehmaster veh on a.jobid=veh.fleet_no inner join gl_vehbrand  brd on veh.brdid=brd.doc_no inner join"+
" gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
" veh.yom=yom.doc_no  where 1=1 "+sqltest;
	        	/*String strsql="select case when inv.ratype='RAG' and rag.clstatus=1 then datediff(rac.indate,rag.odate) when inv.ratype='RAG' and rag.clstatus=0"+
	        			" then datediff(CURDATE(),rag.odate) when inv.ratype='LAG' and lag.clstatus=1 then datediff(lac.indate,lag.outdate) when inv.ratype='LAG'"+
	        			" and lag.clstatus=0 then datediff(CURDATE(),lag.outdate) end useddays,br.branchname branch,case when inv.ratype='RAG' then rag.voc_no"+
	        			" when inv.ratype='LAG' then lag.voc_no end doc_no,inv.ratype renttype,ac.refname client,veh.fleet_no,veh.reg_no,brd.brand_name brand,"+
	        			" model.vtype model,sum((cost.amount*-1))  usedvalue from my_costtran cost left join gl_invm inv on cost.tr_no=inv.tr_no left join"+
	        			" gl_ragmt rag on (inv.rano=rag.doc_no and inv.ratype='RAG') left join gl_lagmt lag on (inv.rano=lag.doc_no and inv.ratype='LAG')"+
	        			" left join my_acbook ac on (case when inv.ratype='RAG' then  rag.cldocno=ac.cldocno and ac.dtype='CRM' when inv.ratype='LAG' then"+
	        			" lag.cldocno=ac.cldocno and ac.dtype='CRM' end) left join gl_invmode imode  on cost.acno=imode.acno left join my_brch br on"+
	        			" inv.brhid=br.doc_no left join gl_vehmaster veh on cost.jobid=veh.fleet_no left join gl_vehbrand  brd on veh.brdid=brd.doc_no"+
	        			" left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_ragmtclosem rac on (inv.ratype='RAG' and  inv.rano=rac.agmtno)"+
	        			" left join gl_lagmtclosem lac on (inv.ratype='LAG' and inv.rano=lac.agmtno)  where 1=1 "+sqltest+" group by inv.rano,inv.ratype,cost.jobid";*/
				System.out.println(strsql);
	        	ResultSet resultSet = stmtsearch.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtsearch.close();
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
	        //System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }


	 public JSONArray getClientGroupData(String branch,String fromdate,String todate,String hidbrand,String hidmodel,String hidgroup,String hidyom,
			 String temp,String hidfleet,String grpby,String hidclient) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        if(!temp.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn=null;
	        try {    	
	        	java.sql.Date sqlfromdate=null,sqltodate=null;
	        	String sqltest="";
	        	String sqlselect="";
	        	String sqlgroup="";
	        	String sqlcommon="";
	        	if(!fromdate.equalsIgnoreCase("")){
	        		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	        	}
	        	if(!todate.equalsIgnoreCase("")){
	        		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	        	}
	        	if(sqlfromdate!=null){
	        		sqlcommon+=" and jv.date>='"+sqlfromdate+"'";
	        	}
	        	if(sqltodate!=null){
	        		sqlcommon+=" and jv.date<='"+sqltodate+"'";
	        	}
	        	if(!hidbrand.equalsIgnoreCase("")){
	        		sqltest+=" and veh.brdid in ("+hidbrand+")";
	        	}
	        	if(!hidmodel.equalsIgnoreCase("")){
	        		sqltest+=" and veh.vmodid in ("+hidmodel+")";
	        	}
	        	if(!hidgroup.equalsIgnoreCase("")){
	        		sqltest+=" and veh.vgrpid in ("+hidgroup+")";
	        	}
	        	if(!hidyom.equalsIgnoreCase("")){
	        		sqltest+=" and veh.yom in ("+hidyom+")";
	        	}
	        	if(!hidfleet.equalsIgnoreCase("")){
	        		sqltest+=" and veh.doc_no in ("+hidfleet+")";
	        	}
	        	
	        	sqlcommon+=" and jv.rtype in ('RAG','LAG')";
	        	if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase("a"))){
	        		sqlcommon+=" and jv.brhid="+branch;
	        	}
	        	
	        	if(!hidclient.equalsIgnoreCase("")){
	        		sqltest+=" and ac.cldocno in ("+hidclient+")";
	        	}
	        	
	        	if(grpby.equalsIgnoreCase("client")){
	        		sqlselect=" ac.cldocno refno,ac.refname description";
	        	}
	        	else if(grpby.equalsIgnoreCase("brand")){
	        		sqlselect=" brd.doc_no refno,brd.brand_name description";
	        	}
	        	else if(grpby.equalsIgnoreCase("model")){
	        		sqlselect=" model.doc_no refno,model.vtype description";
	        	}
	        	else if(grpby.equalsIgnoreCase("group")){
	        		sqlselect=" grp.doc_no refno,grp.gname description";
	        	}
	        	else if(grpby.equalsIgnoreCase("yom")){
	        		sqlselect=" yom.doc_no refno,yom.yom description";
	        	}
	        	conn = ClsConnection.getMyConnection();
	        	Statement stmtsearch = conn.createStatement();
	 /*       	String strsql="select "+sqlselect+",count(*) countno,sum(cost.amount*-1) netamt from my_costtran cost left join my_jvtran jv on cost.tr_no=jv.tr_no left join gl_ragmt rag on (jv.rdocno=rag.doc_no and jv.rtype='RAG')"+
	        			" left join gl_lagmt lag on (jv.rdocno=lag.doc_no and jv.rtype='LAG') left join my_acbook ac on (case when jv.rtype='RAG' then "+
	        			" rag.cldocno=ac.cldocno and ac.dtype='CRM' when jv.rtype='LAG' then lag.cldocno=ac.cldocno and ac.dtype='CRM' end) left join gl_invmode imode "+
	        			" on cost.acno=imode.acno left join my_brch br on jv.brhid=br.doc_no left join gl_vehmaster veh on cost.jobid=veh.fleet_no left join gl_vehbrand "+
	        			" brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_ragmtclosem rac on (jv.rtype='RAG' and "+
	        			" jv.rdocno=rac.agmtno) left join gl_lagmtclosem lac on (jv.rtype='LAG' and jv.rdocno=lac.agmtno)  where 1=1 "+sqltest+" "+
	        			" group by jv.rdocno,jv.rtype,cost.jobid";*/
	        /*	String strsql="select  refno,description,countno,round(netamt,2) netamt,round(netamt/countno,2) avgamt from ("+
	        			" select "+sqlselect+",(sum(cost.amount))*-1 netamt,count(*) countno from my_costtran cost left join my_jvtran jv on "+
	        			" cost.tr_no=jv.tr_no left join gl_ragmt rag on (jv.rtype='RAG' and"+
	        			" jv.rdocno=rag.doc_no) left join gl_lagmt lag on (jv.rtype='LAG' and jv.rdocno=lag.doc_no) left join my_acbook ac on"+
	        			" (if(jv.rtype='RAG',rag.cldocno=ac.cldocno,lag.cldocno=ac.cldocno) and ac.dtype='CRM') left join gl_vehmaster veh on"+
	        			" cost.jobid=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on (veh.vmodid=model.doc_no)"+
	        			" left join gl_vehgroup grp on (veh.vgrpid=grp.doc_no) left join gl_yom yom on veh.yom=yom.doc_no where 1=1 "+sqltest+""+
	        			" group by refno order by refno)a ";*/
	        	

	        /*	String strsql="select count(*) countno,sum(b.netamt) netamount,sum(b.netamt)/count(*) average,b.* from ("+
	        			" select round((sum(amount))*-1,2) netamt,"+sqlselect+",a.*,case when a.rtype='RAG' and rag.clstatus=1 then "+
	        			" datediff(rac.indate,rag.odate) when a.rtype='RAG' and rag.clstatus=0 then datediff(CURDATE(),rag.odate) when a.rtype='LAG' and lag.clstatus=1 "+
	        			" then datediff(lac.indate,lag.outdate) when a.rtype='LAG' and lag.clstatus=0 then datediff(CURDATE(),lag.outdate) end useddays, br.branchname "+
	        			" branch,case when a.rtype='RAG' then rag.voc_no when a.rtype='LAG' then lag.voc_no end doc_no,a.rtype renttype, ac.refname client,veh.fleet_no,"+
	        			" veh.reg_no,brd.brand_name brand,model.vtype model from ( select cost.amount,jv.rdocno,jv.rtype,cost.tr_no,jv.brhid,cost.jobid,jv.date from "+
	        			" my_costtran cost inner join my_jvtran jv on cost.tr_no=jv.tr_no group by cost.tranid,cost.sr_no order by jv.rdocno,jv.rtype,cost.jobid)a left join "+
	        			" gl_ragmt rag on (a.rtype='RAG' and a.rdocno=rag.doc_no) left join gl_lagmt lag on (a.rtype='LAG' and a.rdocno=lag.doc_no) left join my_acbook ac "+
	        			" on (if(a.rtype='RAG',rag.cldocno=ac.cldocno, lag.cldocno=ac.cldocno) and ac.dtype='CRM') left join gl_ragmtclosem rac on"+
	        			" (rag.doc_no=rac.agmtno and rag.clstatus=1)  left join gl_lagmtclosem lac on (lag.doc_no=lac.agmtno and lag.clstatus=1) left join"+
	        			" my_brch br on (a.brhid=br.doc_no) left join gl_vehmaster veh on a.jobid=veh.fleet_no inner join gl_vehbrand  brd on"+
	        			" veh.brdid=brd.doc_no inner join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left"+
	        			" join gl_yom yom on veh.yom=yom.doc_no where 1=1 "+sqltest+" group by a.rdocno,a.rtype )b  group by refno";*/
	        	String strsql="select COUNT(DISTINCT(RAG.DOC_NO))+COUNT(DISTINCT(LAG.DOC_NO)) countno,(sum(amt))*-1 netamount,(sum(amt)/count(*))*-1 average,"+sqlselect+"  from ("+
" select SUM(AMOUNT) AMT,jv.rdocno,jv.rtype,cost.tr_no,jv.brhid,cost.jobid,jv.date from my_costtran cost"+
" inner join my_jvtran jv on cost.trANID=jv.trANID where 1=1"+sqlcommon+" group by rtype,rdocno,jobid )a left join gl_ragmt rag on "+
" (a.rtype='RAG' and a.rdocno=rag.doc_no) left join gl_lagmt lag on (a.rtype='LAG' and a.rdocno=lag.doc_no) left join my_acbook ac on "+
" (if(a.rtype='RAG',rag.cldocno=ac.cldocno,lag.cldocno=ac.cldocno) and ac.dtype='CRM') left join gl_ragmtclosem rac on (rag.doc_no=rac.agmtno and rag.clstatus=1)"+
" left join gl_lagmtclosem lac on (lag.doc_no=lac.agmtno and lag.clstatus=1) left join my_brch br on (a.brhid=br.doc_no)"+
" left join gl_vehmaster veh on a.jobid=veh.fleet_no inner join gl_vehbrand  brd on veh.brdid=brd.doc_no inner join"+
" gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
" veh.yom=yom.doc_no  where 1=1 "+sqltest+" GROUP BY refno";
			//	System.out.println(strsql);
	        	ResultSet resultSet = stmtsearch.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtsearch.close();
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
	        //System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }

	 
	
}
