package com.dashboard.workshop.jobprofitabilitypivot;


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
		
	public JSONArray getSummaryData(String fromdate,String todate,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        
        java.sql.Date sqlfromdate=null,sqltodate=null;
        
        if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
        	sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
        if(!todate.equalsIgnoreCase("") && todate!=null){
        	sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		}
		try {
			conn=ClsConnection.getMyConnection();
			Statement detailstmt=conn.createStatement();
	
	     String strSql="select invm.date invdate,job.voc_no jobno,invm.voc_no invoiceno,job.date,concat(gate.regno,'-',gate.pltid) regno,"
	     		+ " concat(b.brand_name,'',veh.vtype) make, ac.refname party,case when ((bac.refname=''  or bac.refname is null) and gate.cldocno=1) then 'ALICE RENT A CAR LLC' when bac.refname<>'' or bac.refname is null then coalesce(bac.refname,'NON INSURANCE JOBS') end   insurname,if(invm.voc_no is null,0.00,invm.nettotal) invamt,"
	     		+ " if(invm.voc_no is null,0.00,coalesce(invm.nettotal,0)-coalesce(spr.spramt,0)-coalesce(cns.spramt,0)) labouramt,"
	     		+ " if(invm.voc_no is null,0.00,coalesce(spr.spramt,0)) spareamt, if(invm.voc_no is null,0.00,coalesce(cns.spramt,0)) consamt,"
	     		+ " coalesce(lab.labourcost,0) labourcost,coalesce(spr.costtotal,0) sparescost, coalesce(cns.costtotal,0) conscost,"
	     		+ " coalesce(paint.costtotal,0) paintscost, coalesce(lube.costtotal,0) lubecost, ((coalesce(lab.labourcost,0))+(coalesce(spr.costtotal,0))+(coalesce(cns.costtotal,0))+(coalesce(paint.costtotal,0))+(coalesce(lube.costtotal,0))) totcost, coalesce(invm.nettotal,0) - ((coalesce(lab.labourcost,0))+(coalesce(spr.costtotal,0))+(coalesce(cns.costtotal,0))+(coalesce(paint.costtotal,0))+(coalesce(lube.costtotal,0))) profit from ws_jobcard job inner join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm where date between '"+sqlfromdate+"' and '"+sqltodate+"' and status<>7 group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') left join my_user usr on job.userid=usr.doc_no left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=est.doc_no left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid not in (2,3,9,12) group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no left join "
	    		 +" (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no left join "
	    		 +" (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid in (9,12) group by jobcarddocno) paint on paint.jobcarddocno=job.doc_no left join "
	    		 +" (select jobcarddocno,sum(coalesce(customeramt,0)) spramt,sum(coalesce(costtotal,0)) costtotal from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lube on lube.jobcarddocno=job.doc_no left join "
	    		 +" (select clk.jcno,round(sum(coalesce((TIMESTAMPDIFF(minute,concat(clk.startdate,' ',clk.starttime),if(clk.closedate is null, now(),concat(clk.closedate,' ',clk.closetime)))/60)*tech.stdcost,0)),2) labourcost "
	    		 +" from ws_clockin clk left join ws_technician tech on (clk.technicianid=tech.doc_no) group by clk.jcno) lab on lab.jcno=job.doc_no left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no)) left join gl_vehbrand b on b.doc_no=gate.brdid left join gl_vehmodel veh on veh.doc_no=gate.modid left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1) left join my_head h on (bac.acno=h.doc_no) left join my_salm slm on ac.sal_id=slm.doc_no left join ws_gartype rtype on gate.repairtype=rtype.row_no left join my_clcatm cl on cl.doc_no=ac.catid left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join (select costcode,sum(nettaxamount) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no where costtype=9 and srvm.status<>7 group by costcode) srv on srv.costcode=job.doc_no where 1=1 order by invm.voc_no";
			    
			System.out.println("job pivot--->>>"+strSql);  
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
	
}
