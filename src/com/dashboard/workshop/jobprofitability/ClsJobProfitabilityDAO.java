package com.dashboard.workshop.jobprofitability;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobProfitabilityDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
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
	
	public JSONArray repairTypeSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtClientAnalysis=conn.createStatement();
			
			String strSql="select name rtname,row_no docno from  ws_gartype";
            
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
	public JSONArray getDetailData(String fromdate,String todate,String hidclient,String hidclientslm,String hidrepairtype,String id,String chkfollowup) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        
        String sqltest="",sqltype="";
        java.sql.Date sqlfromdate=null,sqltodate=null;
        if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
        	sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
        if(!todate.equalsIgnoreCase("") && todate!=null){
        	sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		}
        
        if(!hidclient.equalsIgnoreCase("")){
			 sqltest+=" and ac.cldocno in ("+hidclient+")";
		 }
        if(!hidclientslm.equalsIgnoreCase("")){
			 sqltest+=" and slm.doc_no in ("+hidclientslm+")";
		 }
        if(!hidrepairtype.equalsIgnoreCase("")){
			 sqltest+=" and rtype.row_no in ("+hidrepairtype+")";
		 }
        
        
        
        
        if(chkfollowup.equalsIgnoreCase("1")){
        	
        	sqltype+=" invm.date ";
			
			}
        
        else{
        	
        	sqltype+=" job.date ";
        }
		
        
        
        
        
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement detailstmt=conn.createStatement();
			
			/*String strSql="select invm.date,invm.voc_no invoiceno,invm.refno jobno,invm.nettotal totalinv,ac.refname client,concat(gate.regno,'-',gate.pltid) regno,usr.user_name serviceadvisor,rtype.name repairtype,"
						+" invm.nettotal- lbr.spramt labour,spr.spramt spares,lub.spramt lubricants,cns.spramt consumables,oth.spramt others,slm.sal_name salesman,h.description account"
						+" from ws_invm invm left join ws_jobcard job on (invm.reftype='JC' and invm.refno=job.doc_no)"
						+" left join my_user usr on job.userid=usr.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare  group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"
						+" left join my_head h on (bac.acno=h.doc_no)"
						+" left join my_salm slm on ac.sal_id=slm.doc_no"
						+" left join ws_gartype rtype on gate.repairtype=rtype.row_no "
						+" where invm.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;*/
			/*String strSql="select srv.nispareamt actualspare,sm1.sal_name serviceadvisor,sm.sal_name estimator,cl.category clcategory,invm.date,invm.voc_no invoiceno,invm.refno jobno,invm.nettotal totalinv,invm.clienttotal,invm.excesstotal,ac.refname client,"+
			" concat(gate.regno,'-',gate.pltid) regno,usr.user_name,rtype.name repairtype,"+
			" coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0) labour,coalesce(spr.spramt,0) "+
			" spares,coalesce(lub.spramt,0) lubricants,coalesce(cns.spramt,0) consumables,coalesce(oth.spramt,0) others,slm.sal_name salesman,"+
			" h.description account from ws_jobcard job inner join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm where date between '"+sqlfromdate+"' and '"+sqltodate+"' and status<>7 "+
			" group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') left join my_user usr on job.userid=usr.doc_no"+
			" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare  group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"+
			" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"+
			" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"+
			" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"+
			" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"+
			" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"+
			" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"+
			" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"+
			" left join my_head h on (bac.acno=h.doc_no)"+
			" left join my_salm slm on ac.sal_id=slm.doc_no"+
			" left join ws_gartype rtype on gate.repairtype=rtype.row_no  left join my_clcatm cl on cl.doc_no=ac.catid left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join (select costcode,sum(nettaxamount) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no  where costtype=9 and srvm.status!=7 group by costcode) srv on srv.costcode=job.doc_no where 1=1 "+sqltest+" order by invm.voc_no" ;
			*/
			String strSql="select invm.date invdate,job.voc_no jobno,invm.voc_no invoiceno,job.date,concat(gate.regno,'-',gate.pltid) regno,concat(b.brand_name,'',veh.vtype) make,"
					+ " ac.refname party,case when ((bac.refname=''  or bac.refname is null) and gate.cldocno=1) then 'ALICE RENT A CAR LLC' when bac.refname<>'' or bac.refname is null then coalesce(bac.refname,'NON INSURANCE JOBS') end   insurname,"
					+ " if(invm.voc_no is null,0.00,invm.nettotal) invamt,if(invm.voc_no is null,0.00,coalesce(invm.nettotal,0)-coalesce(spr.spramt,0)-coalesce(cns.spramt,0))  labouramt,if(invm.voc_no is null,0.00,coalesce(spr.spramt,0)) spareamt,"
					+ " if(invm.voc_no is null,0.00,coalesce(cns.spramt,0)) consamt,coalesce(lab.labourcost,0) labourcost,coalesce(spr.costtotal,0) sparescost,"
					+ " coalesce(cns.costtotal,0) conscost,((coalesce(lab.labourcost,0))+(coalesce(spr.costtotal,0))+(coalesce(cns.costtotal,0))) totcost,"
					+ " coalesce(invm.nettotal,0) - ((coalesce(lab.labourcost,0))+(coalesce(spr.costtotal,0))+(coalesce(cns.costtotal,0))) profit from ws_jobcard job "
					+ " left join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm where status<>7 group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') "
					+ " left join my_user usr on job.userid=usr.doc_no left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) "
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=est.doc_no "
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare jcs "
					+ " left join my_main mm on jcs.psrno=mm.psrno where mm.catid<>3 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no "
					+ " left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare jcs "
					+ " left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no "
					+ " left join (select clk.jcno,round(sum(coalesce((TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),if(clk.closedate is null,"+
					" now(),concat(clk.closedate,' ',clk.closetime)))/60)*tech.stdcost,0)),2) labourcost  from"+
					" ws_clockin clk left join ws_technician tech on (clk.technicianid=tech.doc_no) group by clk.jcno) lab on lab.jcno=job.doc_no"+
					" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join  gl_vehbrand b on b.doc_no=gate.brdid "
					+ " left join gl_vehmodel veh on veh.doc_no=gate.modid left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') "
					+ " left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1) left join my_head h on (bac.acno=h.doc_no) "
					+ " left join my_salm slm on ac.sal_id=slm.doc_no left join ws_gartype rtype on gate.repairtype=rtype.row_no left join my_clcatm cl on cl.doc_no=ac.catid "
					+ " left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' "
					+ " left join (select costcode,sum(nettaxamount) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no where costtype=9 and srvm.status<>7 group by costcode) srv on srv.costcode=job.doc_no where "+sqltype+" between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" order by invm.voc_no";
			
			System.out.println("grid detail---:"+strSql);
			ResultSet resultSet = detailstmt.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	detailstmt.close();
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
	
	public JSONArray getSummaryData(String fromdate,String todate,String hidclient,String hidclientslm,String hidrepairtype,String id,String sumtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        
        String sqltest="";
        String sqlselect="";
        String sqlgroup="";
        java.sql.Date sqlfromdate=null,sqltodate=null;
        
        if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
        	sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
        if(!todate.equalsIgnoreCase("") && todate!=null){
        	sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		}
        
        if(!hidclient.equalsIgnoreCase("")){
			 sqltest+=" and ac.cldocno in ("+hidclient+")";
		 }
        if(!hidclientslm.equalsIgnoreCase("")){
			 sqltest+=" and slm.doc_no in ("+hidclientslm+")";
		 }
        if(!hidrepairtype.equalsIgnoreCase("")){
			 sqltest+=" and rtype.row_no in ("+hidrepairtype+")";
		 }
        
        
        if(sumtype.equalsIgnoreCase("clt")){
			sqlselect=" ac.cldocno,ac.refname,";
			sqlgroup=" group by ac.cldocno";
        	
		 }else if(sumtype.equalsIgnoreCase("sm")){
			 sqlselect=" slm.doc_no,slm.sal_name refname,";
			 sqlgroup=" group by slm.doc_no"; 
			 
		 }else if(sumtype.equalsIgnoreCase("rt")){
			 sqlselect=" rtype.row_no,rtype.name refname,";
			 sqlgroup=" group by rtype.row_no";
			 
		 }else if(sumtype.equalsIgnoreCase("dly")){
			 sqlselect=" invm.date refname,";
			 sqlgroup=" group by invm.date";
			 
		 }else if(sumtype.equalsIgnoreCase("mly")){
			 sqlselect=" month(invm.date),CONVERT(concat(year(invm.date),'-',monthname(invm.date)),char) refname,";
			 sqlgroup=" group by year(invm.date),month(invm.date)";
			 
		 }else if(sumtype.equalsIgnoreCase("yly")){
			 sqlselect=" year(invm.date) refname,";
			 sqlgroup=" group by year(invm.date)";
			 
		 }else{
			 sqlselect="";
				sqlgroup="";
		 }
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement detailstmt=conn.createStatement();
			
			/*String strSql="select "+sqlselect+"sum(invm.nettotal) totalinv,sum(invm.nettotal- lbr.spramt) labour,sum(spr.spramt) spares,sum(lub.spramt) lubricants,sum(cns.spramt) consumables,sum(oth.spramt) others"
						+" from ws_invm invm left join ws_jobcard job on (invm.reftype='JC' and invm.refno=job.doc_no)"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join my_salm slm on ac.sal_id=slm.doc_no"
						+" left join ws_gartype rtype on gate.repairtype=rtype.row_no"
						+" where invm.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+sqlgroup;
			*/
//			if(sum(coalesce(invm.nettotal,0)- coalesce(lbr.spramt,0))<0,0,sum(coalesce(invm.nettotal,0)- coalesce(lbr.spramt,0))) labour
			String strSql="select "+sqlselect+"sum(coalesce(invm.nettotal,0)) totalinv,sum(coalesce(invm.nettotal,0)- coalesce(lbr.spramt,0)) labour,sum(coalesce(spr.spramt,0)) spares,sum(coalesce(lub.spramt,0)) lubricants,sum(coalesce(cns.spramt,0))"+
			" consumables,sum(coalesce(oth.spramt,0)) others from ws_jobcard job inner join (select reftype,date,voc_no,refno,sum(nettotal) nettotal from ws_invm where date between '"+sqlfromdate+"' and '"+sqltodate+"' and status<>7  group by refno,doc_no) invm on (job.doc_no=invm.refno and invm.reftype='JC')"
			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
			+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
			+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
			+" left join my_salm slm on ac.sal_id=slm.doc_no"
			+" left join ws_gartype rtype on gate.repairtype=rtype.row_no"
			+" where 1=1 "+sqltest+sqlgroup;

			
			System.out.println("revenue summary---:"+strSql);
			ResultSet resultSet = detailstmt.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	detailstmt.close();
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
	
	public JSONArray getDetailExportData(String fromdate,String todate,String hidclient,String hidclientslm,String hidrepairtype,String id)throws SQLException
	{
		JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        
        String sqltest="";
        java.sql.Date sqlfromdate=null,sqltodate=null;
        if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
        	sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
        if(!todate.equalsIgnoreCase("") && todate!=null){
        	sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		}
        
        if(!hidclient.equalsIgnoreCase("")){
			 sqltest+=" and ac.cldocno in ("+hidclient+")";
		 }
        if(!hidclientslm.equalsIgnoreCase("")){
			 sqltest+=" and slm.doc_no in ("+hidclientslm+")";
		 }
        if(!hidrepairtype.equalsIgnoreCase("")){
			 sqltest+=" and rtype.row_no in ("+hidrepairtype+")";
		 }
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement detailstmt=conn.createStatement();
			
			/*String strSql="select invm.date 'Date',invm.voc_no 'Invoice No',ac.refname 'Client',usr.user_name 'Service Advisor',h.description 'Account Name',invm.refno 'Job No',concat(gate.regno,'-',gate.pltid) 'Reg No',CONVERT(coalesce(invm.nettotal,''),char) 'Total Inv Value',"
						+" convert(coalesce(format(invm.nettotal- lbr.spramt,2),'0.00'),char) 'Labour',convert(coalesce(format(spr.spramt,2),'0.00'),char) 'Spares',convert(coalesce(format(lub.spramt,2),'0.00'),char) 'Lubricants',convert(coalesce(format(cns.spramt,2),'0.00'),char) 'Consumables',convert(coalesce(format(oth.spramt,2),'0.00'),char) 'Others',coalesce(slm.sal_name,'') Salesman,coalesce(rtype.name,'') 'Repair Type'"
						+" from ws_invm invm left join ws_jobcard job on (invm.reftype='JC' and invm.refno=job.doc_no)"
						+" left join my_user usr on job.userid=usr.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
						+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
						+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"
						+" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
						+" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"
						+" left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"
						+" left join my_head h on (bac.acno=h.doc_no)"
						+" left join my_salm slm on ac.sal_id=slm.doc_no"
						+" left join ws_gartype rtype on gate.repairtype=rtype.row_no "
						+" where invm.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;
			*/
/*			invm.date,invm.voc_no invoiceno,invm.refno jobno,invm.nettotal totalinv,ac.refname client,"+
			" concat(gate.regno,'-',gate.pltid) regno,usr.user_name serviceadvisor,rtype.name repairtype,"+
			" if(coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0)<0,0,coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0)) labour,coalesce(spr.spramt,0) "+
			" spares,coalesce(lub.spramt,0) lubricants,coalesce(cns.spramt,0) consumables,coalesce(oth.spramt,0) others,slm.sal_name salesman,"+
			" h.description account from ws_jobcard job inner join (select reftype,date,voc_no,refno,sum(nettotal) nettotal
*/			String strSql="select job.date 'Date',invm.voc_no 'Invoice No',ac.refname 'Client Name',cl.category 'Client Category',sm.sal_name 'Estimator',sm1.sal_name 'Service Advisor',h.description 'Account Name',job.voc_no 'Job No',concat(gate.regno,'-',gate.pltid) 'Reg No',CONVERT(coalesce(invm.nettotal,''),char) 'Total Inv Value',invm.clienttotal 'Clent',invm.excesstotal 'Ins. Co.',"
						+" convert(coalesce(format(coalesce(invm.nettotal,0)-coalesce(lbr.spramt,0),2),'0.00'),char) 'Labour',convert(coalesce(format(spr.spramt,2),'0.00'),char) 'Spares',srv.nispareamt 'Actual Spare',convert(coalesce(format(lub.spramt,2),'0.00'),char) 'Lubricants',convert(coalesce(format(cns.spramt,2),'0.00'),char) 'Consumables',convert(coalesce(format(oth.spramt,2),'0.00'),char) 'Others',coalesce(slm.sal_name,'') Salesman,coalesce(rtype.name,'') 'Repair Type' from ws_jobcard job left join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm where 1=1 and status<>7 "+
				" group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') left join my_user usr on job.userid=usr.doc_no"+
					" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare  group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"+
					" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"+
					" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"+
					" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"+
					" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"+
					" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)"+
					" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"+
					" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
					" left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"+
					" left join my_head h on (bac.acno=h.doc_no)"+
					" left join my_salm slm on ac.sal_id=slm.doc_no"+
					" left join ws_gartype rtype on gate.repairtype=rtype.row_no left join my_clcatm cl on cl.doc_no=ac.catid left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join (select costcode,sum(nettaxamount) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no where costtype=9 and srvm.status<>7 group by costcode) srv on srv.costcode=job.doc_no where 1=1 job.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" order by invm.voc_no" ;
			System.out.println("revenue Export detail---:"+strSql);

			ResultSet rs=detailstmt.executeQuery(strSql);
			RESULTDATA=ClsCommon.convertToEXCEL(rs);
			detailstmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
}
