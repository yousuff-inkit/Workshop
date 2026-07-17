package com.dashboard.analysis.abcfleet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAbcFleetDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public JSONArray getFleetData(String branch,String fromdate,String todate,String hidbrand,String hidmodel,String hidyom,String temp,String hidfleet) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        if(!temp.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn=null;
	        try {    	
	        	java.sql.Date sqlfromdate=null,sqltodate=null;
	        	String sqltest="";
	        	String sqlcommon="";
	        	String strsql="";
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
	        	if(!hidyom.equalsIgnoreCase("")){
	        		sqltest+=" and veh.yom in ("+hidyom+")";
	        	}
	        	if(!hidfleet.equalsIgnoreCase("")){
	        		sqltest+=" and veh.doc_no in ("+hidfleet+")";
	        	}
	        	if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase("a"))){
	        		sqlcommon+=" and jv.brhid="+branch;
	        	}
	        	
	        	sqlcommon+=" and jv.rtype in ('RAG','LAG')";
	        	conn=ClsConnection.getMyConnection();
	        	Statement stmtsearch=conn.createStatement();
	        	
	        	strsql="select b.*,b.accchg+b.rentchg+b.exkmchg+b.damagechg+B.otherchg+b.tax netbill,round(((b.rentchg+b.exkmchg+b.damagechg+b.otherchg+B.tax)/b.bookingcount),2) "+
	        			" amtperbooking from ( select veh.fleet_no,veh.flname,COUNT(distinct(RAG.DOC_NO))+count(distinct(lag.doc_no)) bookingcount, "+
	        			" (round(IF(IDNO=1,SUM(AMT),0),2))*-1 rentchg, (round(IF(IDNO=2, sum(AMT),0),2))*-1 accchg,(round(if(idno=4,sum(amt),0),2))*-1 exkmchg,(round(if(idno=10,sum(amt),0),2))*-1 damagechg,"+
	        			"  (round(if(idno=15,sum(amt),0)+if(idno not in (1,2,4,19,20),sum(amt),0),2))*-1 otherchg,round((if(idno=19,sum(amt),0)+if(idno=20,sum(amt),0)),2)*-1 tax,IDNO  from ("+
	        			" select cost.amount AMT,jv.rdocno,jv.rtype,cost.tr_no,jv.brhid,cost.jobid,jv.date,I.IDNO from my_costtran cost"+
	        			" inner join my_jvtran jv on cost.trANID=jv.trANID left join gl_invmode i on COST.acno=i.acno"+
	        			" where 1=1 "+sqlcommon+")a left join gl_ragmt rag on (a.rtype='RAG' and a.rdocno=rag.doc_no) "+
	        			" left join gl_lagmt lag on (a.rtype='LAG' and a.rdocno=lag.doc_no)  left join my_brch br on (a.brhid=br.doc_no)"+
	        			" left join gl_vehmaster veh on a.jobid=veh.fleet_no inner join gl_vehbrand  brd on veh.brdid=brd.doc_no inner join"+
	        			" gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
	        			" veh.yom=yom.doc_no  where 1=1 "+sqltest+" GROUP BY VEH.FLEET_NO)b";
	        	//System.out.println(strsql);
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

	public JSONArray getFleetGroupData(String branch,String fromdate,String todate,String hidbrand,String hidmodel,String hidyom,String temp,String hidfleet,String grpby) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!temp.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn=null;
        try {    	
        	java.sql.Date sqlfromdate=null,sqltodate=null;
        	String sqltest="";
        	String sqlcommon="";
        	String strsql="";
        	String sqlselect="";
        	String sqlgroup="";
        	if(grpby.equalsIgnoreCase("brand")){
        		sqlselect+=" brd.doc_no refno,brd.brand_name description";
        		sqlgroup=" brd.doc_no";
        	}
        	else if(grpby.equalsIgnoreCase("model")){
        		sqlselect+=" model.doc_no refno,model.vtype description";
        		sqlgroup=" model.doc_no";
        	}
        	else if(grpby.equalsIgnoreCase("group")){
        		sqlselect+=" grp.doc_no refno,grp.gname description";
        		sqlgroup=" grp.doc_no";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect+=" yom.doc_no refno,yom.yom description";
        		sqlgroup=" yom.doc_no";
        	}
        	else{
        		sqlselect+=" yom.doc_no refno,yom.yom description";
        		sqlgroup=" yom.doc_no";
        	}
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
        	if(!hidyom.equalsIgnoreCase("")){
        		sqltest+=" and veh.yom in ("+hidyom+")";
        	}
        	if(!hidfleet.equalsIgnoreCase("")){
        		sqltest+=" and veh.doc_no in ("+hidfleet+")";
        	}
        	if(!(branch.equalsIgnoreCase("")) && !(branch.equalsIgnoreCase("a"))){
        		sqlcommon+=" and jv.brhid="+branch;
        	}
        	
        	sqlcommon+=" and jv.rtype in ('RAG','LAG')";
        	conn=ClsConnection.getMyConnection();
        	Statement stmtsearch=conn.createStatement();
        	
        	/*strsql="select b.*,b.accchg+b.rentchg+b.exkmchg+b.damagechg+b.otherchg+b.tax netbill,round(((b.rentchg+b.exkmchg+b.damagechg+b.otherchg+b.tax+b.accchg)/b.bookingcount),2) "+
        			" amtperbooking from ( select "+sqlselect+",COUNT(distinct(RAG.DOC_NO))+count(distinct(lag.doc_no)) bookingcount, "+
        			" (round(IF(IDNO=1, sum(AMT),0),2))*-1 rentchg,(round(IF(IDNO=2, sum(AMT),0),2))*-1 accchg,(round(if(idno=4,sum(amt),0),2))*-1 exkmchg,(round(if(idno=10,sum(amt),0),2))*-1 damagechg,"+
        			" (round(if(idno=15,sum(amt),0)+if(idno not in (1,2,4,19,20),sum(amt),0),2))*-1 otherchg,round((if(idno=19,sum(amt),0)+if(idno=20,sum(amt),0)),2)*-1 tax,IDNO  from ("+
        			" select cost.amount AMT,jv.rdocno,jv.rtype,cost.tr_no,jv.brhid,cost.jobid,jv.date,I.IDNO from my_costtran cost"+
        			" inner join my_jvtran jv on cost.trANID=jv.trANID left join gl_invmode i on COST.acno=i.acno"+
        			" where 1=1 "+sqlcommon+" group by jobid  )a left join gl_ragmt rag on (a.rtype='RAG' and a.rdocno=rag.doc_no) "+
        			" left join gl_lagmt lag on (a.rtype='LAG' and a.rdocno=lag.doc_no)  left join my_brch br on (a.brhid=br.doc_no)"+
        			" left join gl_vehmaster veh on a.jobid=veh.fleet_no inner join gl_vehbrand  brd on veh.brdid=brd.doc_no inner join"+
        			" gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on"+
        			" veh.yom=yom.doc_no  where 1=1 "+sqltest+" GROUP BY "+sqlgroup+")b ";*/
        	
        	strsql="select sum(b.rentchg) rentchg,sum(b.accchg) accchg,sum(b.otherchg)otherchg,sum(b.damagechg) damagechg,sum(b.tax) tax,"+
        			" sum(b.exkmchg) exkmchg,refno,description,sum(b.rentchg)+sum(b.accchg)+sum(b.otherchg)+sum(b.damagechg)+sum(b.tax)+sum(b.exkmchg)"+
        			" netbill,sum(b.bookingcount) bookingcount ,round(((sum(b.rentchg)+sum(b.accchg)+sum(b.otherchg)+sum(b.damagechg)+sum(b.tax)+sum(b.exkmchg))/"+
        			"sum(b.bookingcount)),2) amtperbooking from ( select "+sqlselect+",COUNT(distinct(RAG.DOC_NO))+count(distinct(lag.doc_no))"+
        			" bookingcount,  (round(IF(IDNO=1, sum(AMT),0),2))*-1 rentchg,(round(IF(IDNO=2, sum(AMT),0),2))*-1 accchg,(round(if(idno=4,sum(amt),0),2))*-1 exkmchg,"+
        			" (round(if(idno=10,sum(amt),0),2))*-1 damagechg, (round(if(idno=15,sum(amt),0)+if(idno not in (1,2,4,19,20),sum(amt),0),2))*-1 otherchg,round((if(idno=19,sum(amt),0)+"+
        			" if(idno=20,sum(amt),0)),2)*-1 tax,IDNO  from ( select cost.amount AMT,jv.rdocno,jv.rtype,cost.tr_no,jv.brhid,cost.jobid,jv.date,I.IDNO from my_costtran cost inner join "+
        			" my_jvtran jv on cost.trANID=jv.trANID left join gl_invmode i on COST.acno=i.acno where 1=1 "+sqlcommon+" )a left join gl_ragmt rag "+
        			" on (a.rtype='RAG' and a.rdocno=rag.doc_no)  left join gl_lagmt lag on (a.rtype='LAG' and a.rdocno=lag.doc_no)  left join my_brch br on "+
        			" (a.brhid=br.doc_no) left join gl_vehmaster veh on a.jobid=veh.fleet_no inner join gl_vehbrand  brd on veh.brdid=brd.doc_no inner join gl_vehmodel "+
        			" model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no  "+
        			" where 1=1 "+sqltest+" GROUP BY veh.fleet_no)b group by refno";
//        	System.out.println(strsql);
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
