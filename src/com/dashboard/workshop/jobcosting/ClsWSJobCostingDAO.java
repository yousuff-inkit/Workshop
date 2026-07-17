package com.dashboard.workshop.jobcosting;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsWSJobCostingDAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public JSONArray getJobCostingData(String id,String type) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(type.equalsIgnoreCase("0")){
				sqltest+=" and flr.completestatus=0";
			}
			else if(type.equalsIgnoreCase("1")){
				sqltest+=" and flr.completestatus=1";
			}
			String strsql="select b.esthrs estlabourhrs,b.jobdate,datediff(curdate(),b.jobdate) age,b.refname,b.grpname, b.estimator, b.srvcadvisor, b.salesman, b.insursurvivor, b.referredby, b.sellingsparetotal sellingparts,"+
			" b.sellingsrvctotal sellinglabour, b.sellingpricetotal sellingtotal, b.estimatedlabour estlabour, b.estimatedspare estparts, b.actualspare "+
			" actualparts, b.actualhrs actuallabourhrs, b.actuallabour actuallabourcost, b.variancespare varianceparts, b.variancehrs variancelabourhrs, "+
			" b.variancelabour variancelabourcost, b.service, b.priority, b.jobvocno, b.vehicledetails, b.billto,b.actualspare-b.variancespare "+
			" contributionparts,b.actuallabour-b.variancelabour contributionlabour,(b.actualspare-b.variancespare)+(b.actuallabour-b.variancelabour) contributiontotal from ("+
			" select a.esthrs,a.refname,a.jobdate,a.grpname, a.estimator, a.srvcadvisor, a.salesman, a.insursurvivor, a.referredby,a.sellingsparetotal,a.sellingsrvctotal,"+
			" a.sellingsparetotal+a.sellingsrvctotal sellingpricetotal,a.estimatedlabour,a.estimatedspare,a.actualspare,a.actualhrs,"+
			" a.actuallabour,a.actualspare-a.estimatedspare variancespare,a.actualhrs-a.esthrs variancehrs,a.actuallabour-a.estimatedlabour "+
			" variancelabour,a.service,a.priority,a.jobvocno,a.vehicledetails,a.billto from ("+
			" select flr.jobdate,flr.grpname, flr.estimator, flr.srvcadvisor, flr.salesman, flr.insursurvivor, flr.referredby,estlabour.esthrs,flr.priority,"+
			" flr.service,flr.billto,flr.client refname,flr.vehicledetails,job.voc_no jobvocno,job.doc_no jobdocno,est.doc_no estdocno,"+
			" coalesce(est.sparenettotal,0.0)+coalesce(estadd.estsparenettotal,0.0) sellingsparetotal,"+
			" coalesce(est.netservices,0.0)+coalesce(estsrvctotal,0.0) sellingsrvctotal,coalesce(estlabour.estlabour,0.0) estimatedlabour,"+
			" (est.sparetotal-(est.sparetotal*coalesce(prv.sparemarkup,0)))+(coalesce(estadd.estsparetotal,0.0)-(coalesce(estadd.estsparetotal,0.0)*coalesce(prv.sparemarkup,0))) estimatedspare,"+
			" coalesce(jccspare.actualspare,0.0) actualspare,coalesce(flr.actualhrs,0) actualhrs,coalesce(estlabour.actuallabour,0) actuallabour "+
			" from ws_floormgmtdata flr left join ws_jobcard job on flr.jobdocno=job.doc_no left join ws_estm est on (job.reftype='EST' and"+
			" job.refno=est.doc_no) left join (select jobcarddocno jobdocno,sum(sparetotal) estsparetotal,sum(sparenettotal) estsparenettotal,"+
			" sum(netservices) estsrvctotal from ws_estmadd where status=3 group by jobcarddocno) estadd on"+
			" (job.doc_no=estadd.jobdocno) left join (select rdocno estdocno,sum(hrs*rate) estlabour,sum(invoiceamt) actuallabour,sum(hrs) esthrs "+
			" from ws_estlabour group by rdocno) estlabour on (est.doc_no=estlabour.estdocno) left join ws_gateinpass gate on "+
			" est.gipno=gate.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clprivilage prv on "+
			" ac.privillege=prv.doc_no left join (select sum(customeramt) actualspare,jobcarddocno from ws_jccspare group by jobcarddocno) "+
			" jccspare on (job.doc_no=jccspare.jobcarddocno) where 1=1 "+sqltest+" group by job.doc_no) a) b";
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
	
	
	
	public JSONArray getJobCostingExcelData(String id,String type) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(type.equalsIgnoreCase("0")){
				sqltest+=" and flr.completestatus=0";
			}
			else if(type.equalsIgnoreCase("1")){
				sqltest+=" and flr.completestatus=1";
			}
			String strsql="select b.jobvocno 'Job No',date_format(b.jobdate,'%d.%m.%Y') 'Job Date',b.vehicledetails 'Vehicle Details',b.billto 'Bill To',"+
			" b.refname 'Client',datediff(curdate(),b.jobdate) 'Age',b.priority 'Priority',b.service 'Service',round(b.sellingsparetotal,2) 'Selling Parts Price',"+
			" round(b.sellingsrvctotal,2) 'Selling Labour Price',round(b.sellingpricetotal,2) 'Selling Total Price',round(b.estimatedspare,2) 'Est.Parts Price',"+
			" round(b.esthrs,2) 'Est.Labour Hrs',round(b.estimatedlabour,2) 'Est.Labour Price',round(b.actualspare,2) 'Actual Parts Price',round(b.actualhrs,2) 'Actual Labour Hrs',"+
			" round(b.actuallabour,2) 'Actual Labour Cost',round(b.variancespare,2) 'Variance Parts Price',round(b.variancehrs,2) 'Variance Labour Hrs',"+
			" round(b.variancelabour,2) 'Variance Labour Cost',round(b.actualspare-b.variancespare,2) 'Contribution Parts',"+
			" round(b.actuallabour-b.variancelabour,2) 'Contribution Labour',round((b.actualspare-b.variancespare)+(b.actuallabour-b.variancelabour),2) "+
			" 'Contribution Total',coalesce(b.grpname,'') 'Group',coalesce(b.estimator,'') 'Estimator',coalesce(b.srvcadvisor,'') 'Service Advisor',"+
			" coalesce(b.salesman,'') 'Salesman',coalesce(b.insursurvivor,'') 'Insurance Surveyer',coalesce(b.referredby,'') 'Referred By' from ("+
			" select a.esthrs,a.refname,a.jobdate,a.grpname, a.estimator, a.srvcadvisor, a.salesman, a.insursurvivor, a.referredby,a.sellingsparetotal,a.sellingsrvctotal,"+
			" a.sellingsparetotal+a.sellingsrvctotal sellingpricetotal,a.estimatedlabour,a.estimatedspare,a.actualspare,a.actualhrs,"+
			" a.actuallabour,a.actualspare-a.estimatedspare variancespare,a.actualhrs-a.esthrs variancehrs,a.actuallabour-a.estimatedlabour "+
			" variancelabour,a.service,a.priority,a.jobvocno,a.vehicledetails,a.billto from ("+
			" select flr.jobdate,flr.grpname, flr.estimator, flr.srvcadvisor, flr.salesman, flr.insursurvivor, flr.referredby,estlabour.esthrs,flr.priority,"+
			" flr.service,flr.billto,flr.client refname,flr.vehicledetails,job.voc_no jobvocno,job.doc_no jobdocno,est.doc_no estdocno,"+
			" coalesce(est.sparenettotal,0.0)+coalesce(estadd.estsparenettotal,0.0) sellingsparetotal,"+
			" coalesce(est.netservices,0.0)+coalesce(estsrvctotal,0.0) sellingsrvctotal,coalesce(estlabour.estlabour,0.0) estimatedlabour,"+
			" (est.sparetotal-(est.sparetotal*coalesce(prv.sparemarkup,0)))+(coalesce(estadd.estsparetotal,0.0)-(coalesce(estadd.estsparetotal,0.0)*coalesce(prv.sparemarkup,0))) estimatedspare,"+
			" coalesce(jccspare.actualspare,0.0) actualspare,coalesce(flr.actualhrs,0) actualhrs,coalesce(estlabour.actuallabour,0) actuallabour "+
			" from ws_floormgmtdata flr left join ws_jobcard job on flr.jobdocno=job.doc_no left join ws_estm est on (job.reftype='EST' and"+
			" job.refno=est.doc_no) left join (select jobcarddocno jobdocno,sum(sparetotal) estsparetotal,sum(sparenettotal) estsparenettotal,"+
			" sum(netservices) estsrvctotal from ws_estmadd where status=3 group by jobcarddocno) estadd on"+
			" (job.doc_no=estadd.jobdocno) left join (select rdocno estdocno,sum(hrs*rate) estlabour,sum(invoiceamt) actuallabour,sum(hrs) esthrs "+
			" from ws_estlabour group by rdocno) estlabour on (est.doc_no=estlabour.estdocno) left join ws_gateinpass gate on "+
			" est.gipno=gate.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clprivilage prv on "+
			" ac.privillege=prv.doc_no left join (select sum(customeramt) actualspare,jobcarddocno from ws_jccspare group by jobcarddocno) "+
			" jccspare on (job.doc_no=jccspare.jobcarddocno)  where 1=1 "+sqltest+" group by job.doc_no) a) b";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
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
}
