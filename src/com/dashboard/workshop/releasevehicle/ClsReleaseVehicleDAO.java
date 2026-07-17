package com.dashboard.workshop.releasevehicle;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.workshop.serviceadvisor.ClsServiceAdvisorBean;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsReleaseVehicleDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray getReleaseData(String branch,String todate,String id,String releasestatus)throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			/*if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and job.date>='"+sqlfromdate+"'";
			}*/
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and job.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and job.brhid="+branch;
			}
			
			String strsql="";
			if(releasestatus.equalsIgnoreCase("0")){
				strsql="select flr.esttotal,flr.extdate extendate,job.promdate promisedate,ac1.refname billto,sm.sal_name estimator,gate.doc_no gatedocno,job.doc_no jobcarddocno,job.voc_no jobcardvocno,est.voc_no estvocno,gate.voc_no gatevocno,job.date,"+
			" concat(gate.pltid,' ',gate.regno) regno,concat(brd.brand_name,' ',model.vtype) flname,coalesce(sal.sal_name,'') sal_name,"+
			" ac.refname,sm1.sal_name salname  from ws_jobcard job left join ws_estm est on"+
			" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on"+
			" gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno"+
			" and ac.dtype='CRM') left join my_salm sal on ac.sal_id=sal.doc_no left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_acbook ac1 on ac1.cldocno=gate.insurcldocno and ac1.dtype='CRM' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join ws_floormgmtdata flr on flr.jobdocno=job.doc_no  where gate.processstatus=5 and job.status=3"+sqltest;
			}
			else if(releasestatus.equalsIgnoreCase("1")){
				strsql="select flr.esttotal,case when rls.remarks=1 then 'LPO' when rls.remarks=2 then 'Parts' when rls.remarks=3 then 'Total Loss' else '' end remarks,flr.extdate extendate,job.promdate promisedate,ac1.refname billto,sm.sal_name estimator,gate.doc_no gatedocno,job.doc_no jobcarddocno,job.voc_no jobcardvocno,est.voc_no estvocno,gate.voc_no gatevocno,job.date,"+
						" concat(gate.pltid,' ',gate.regno) regno,concat(brd.brand_name,' ',model.vtype) flname,coalesce(sal.sal_name,'') sal_name,"+
						" ac.refname,sm1.sal_name salname from ws_vehrelease rls left join ws_jobcard job on (rls.jobcarddocno=job.doc_no) left join ws_estm est on"+
						" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on"+
						" gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno"+
						" and ac.dtype='CRM') left join my_salm sal on ac.sal_id=sal.doc_no left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_acbook ac1 on ac1.cldocno=gate.insurcldocno and ac1.dtype='CRM' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join ws_floormgmtdata flr on flr.jobdocno=job.doc_no where rls.clstatus=0"+sqltest;
			}
			
			
			System.out.println("grid loading query====="+strsql);
			
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
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
	
	
	public JSONArray getReleaseExcelData(String branch,String todate,String id,String releasestatus)throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			/*if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and job.date>='"+sqlfromdate+"'";
			}*/
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and job.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and job.brhid="+branch;
			}
			
			String strsql="";
			if(releasestatus.equalsIgnoreCase("0")){
				strsql="select job.voc_no 'Job Card No',date_format(job.date,'%d.%m.%Y') 'Date',job.promdate 'Promise Date',flr.extdate 'Extended Date',est.voc_no 'Est.No',gate.voc_no 'GIP No',round(flr.esttotal,2) 'Est.Total',"+
				" concat(gate.pltid,' ',gate.regno) 'Reg No',concat(brd.brand_name,' ',model.vtype) 'Make',coalesce(sm1.sal_name,'') 'Advisor',"+
				" ac.refname 'Party',ac1.refname 'Billto Company',sm.sal_name 'Estimator' from ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on"+
			" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on"+
			" gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno"+
			" and ac.dtype='CRM') left join my_salm sal on ac.sal_id=sal.doc_no left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_acbook ac1 on ac1.cldocno=gate.insurcldocno and ac1.dtype='CRM' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join ws_floormgmtdata flr on flr.jobdocno=job.doc_no  where gate.processstatus=5 and job.status=3"+sqltest;
			}
			else if(releasestatus.equalsIgnoreCase("1")){
				strsql="select job.voc_no 'Job Card No',date_format(job.date,'%d.%m.%Y') 'Date',job.promdate 'Promise Date',flr.extdate 'Extended Date',case when rls.remarks=1 then 'LPO' when rls.remarks=2 then 'Parts' when rls.remarks=3 then 'Total Loss' else '' end 'Remarks',est.voc_no 'Est.No',gate.voc_no 'GIP No',round(flr.esttotal,2) 'Est.Total',"+
						" concat(gate.pltid,' ',gate.regno) 'Reg No',concat(brd.brand_name,' ',model.vtype) 'Make',coalesce(sm1.sal_name,'') 'Advisor',"+
						" ac.refname 'Party',ac1.refname 'Billto Company',sm.sal_name 'Estimator' from ws_vehrelease rls left join ws_jobcard job on (rls.jobcarddocno=job.doc_no) left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on"+
						" (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on"+
						" gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno"+
						" and ac.dtype='CRM') left join my_salm sal on ac.sal_id=sal.doc_no left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_acbook ac1 on ac1.cldocno=gate.insurcldocno and ac1.dtype='CRM' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join ws_floormgmtdata flr on flr.jobdocno=job.doc_no  where rls.clstatus=0"+sqltest;
			}
			
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
			
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
	
	public ClsReleaseVehicleBean  getPrint(String jobcarddocno)throws SQLException{
		ClsReleaseVehicleBean bean=new ClsReleaseVehicleBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();

			String resql=("select concat(coalesce(gate.pltid,''),'  ',coalesce(gate.regno,'')) as regno,ws.releasetime,ws.releasedate,ws.jobcarddocno jobno,"
					+ " concat(coalesce(br.brand_name,''),'  ',coalesce(md.vtype,'')) as type,ac.refname customer,u.user_name person,gate.other chasisno"
					+ " ,gate.vehother engineno,CURDATE() as currdate"
					+ " from ws_vehrelease ws "
					+ "left join ws_gateinpass gate on gate.doc_no=ws.gatedocno "
					+ " left join gl_vehbrand br on br.doc_no=gate.brdid"
					+ " left join gl_vehmodel md on md.doc_no=gate.modid "
					+ " left join my_acbook ac on ac.cldocno=gate.cldocno "
					+ " left join my_user u on u.doc_no=ws.userid "
					+ "  where   ws.jobcarddocno='"+jobcarddocno+"'");
			
			 
		 System.out.println("---resql----"+resql);
			
			ResultSet pintrs = stmt.executeQuery(resql);
			
	 
		       while(pintrs.next()){
		    	
		    	
		    	    
		    	   bean.setLblrvehicleno(pintrs.getString("regno"));
		    	   bean.setLbldate(pintrs.getString("releasedate"));
		    	   bean.setLbljobno(pintrs.getString("jobno"));
		    	   bean.setLbltype(pintrs.getString("type"));
		    	   bean.setLblcustomer(pintrs.getString("customer"));
		    	   bean.setLblperson(pintrs.getString("person"));
		    	   bean.setLblchasisno(pintrs.getString("chasisno"));
		    	   bean.setLblengineno(pintrs.getString("engineno"));
		    	   bean.setLbltodat(pintrs.getString("releasetime"));
   	 }
			

			
			
			
			stmt.close();
			Statement stmt10 = conn.createStatement ();
		    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from ws_vehrelease v "
		    		+ " left join ws_gateinpass r on r.doc_no=v.gatedocno "
		    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where v.jobcarddocno="+jobcarddocno+"  ";

                 System.out.println("++++"+companysql);
	         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   
		    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
		    	   bean.setLblcompname(resultsetcompany.getString("company"));
		    	  
		    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
		    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
		    	  
		    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
		    	   bean.setLbllocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		     stmt10.close();
			
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	
	
	
	
	
	
}
