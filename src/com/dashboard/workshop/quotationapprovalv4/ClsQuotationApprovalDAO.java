package com.dashboard.workshop.quotationapprovalv4;
import  com.common.*;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.agreement.rentalagreement.ClsRentalAgreementBean;

public class ClsQuotationApprovalDAO {

		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO= new ClsCommon();
		
		public JSONArray getSparepartsData(String docno,String id,String addition) throws SQLException
		{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null;
			try{
				conn=connDAO.getMyConnection();
				Statement stmt=conn.createStatement();
				String sqlfilters="";
				if(addition!=null && !addition.equalsIgnoreCase("") && !addition.equalsIgnoreCase("undefined")) {
					sqlfilters+=" and addition="+addition;
				}
				String strsql="select rowno,description, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estspare where  confirmed=1 and approved=0 and rdocno="+docno+" "+sqlfilters;
				System.out.println(strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=commonDAO.convertToJSON(rs);
				
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
		public JSONArray getLabourcostData(String docno,String id,String addition)throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null;
			try{
				conn=connDAO.getMyConnection();
				Statement stmt=conn.createStatement();
				String sqlfilters="";
				if(addition!=null && !addition.equalsIgnoreCase("") && !addition.equalsIgnoreCase("undefined")) {
					sqlfilters+=" and lab.addition="+addition;
				}
				String strsql="select lab.rowno,lab.strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,lab.strjobtype jobtype,lab.markupper markuppercent,lab.total,lab.remarks,"+
				" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (m.status=3 and lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
				" where  lab.confirmed=1 and lab.approved=0   and lab.rdocno="+docno+" "+sqlfilters;
				System.out.println("Labour Data:"+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=commonDAO.convertToJSON(rs);
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
		public JSONArray clientDetailsGridReloading(String cl_name,String chk) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        
			try {
					conn = connDAO.getMyConnection();
					Statement stmtCRM = conn.createStatement();
					String sqltest="";
					if(!cl_name.equalsIgnoreCase("")){
						//System.out.println("sqltest");
						 sqltest+=" and RefName like'%"+cl_name+"%'";
					}
					String sqlqry="SELECT RefName clname,cldocno FROM my_acbook where dtype='CRM' and status<>7"+sqltest;
					ResultSet resultSet = stmtCRM.executeQuery (sqlqry);
	                
					
					
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtCRM.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
			
	    }
		public JSONArray getApprovalDetails(String todate,String approv,String docnos,String branch) throws SQLException {   
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        
	        //System.out.println(fromdate+todate+"  "+approv);
	          
			try {
					conn = connDAO.getMyConnection();
					Statement stmtCRM = conn.createStatement();
					java.sql.Date sqlfromdate=null,sqltodate=null;
					/*if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
						sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
					}*/
					if(!todate.equalsIgnoreCase("") && todate!=null){
						sqltodate=commonDAO.changeStringtoSqlDate(todate);
					}
					
					String sqltest="";
					if(!docnos.equalsIgnoreCase("") && docnos!=null){
						//System.out.println("sqltest");
						 sqltest+=" and mac.cldocno='"+docnos+"'";
					}
					System.out.println("Branch---"+branch);   
					if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a") ){     
						 sqltest+=" and em.brhid='"+branch+"'";       
					}
					if(approv.equalsIgnoreCase("approved")){
						/*ws_jobcard job left join 
						 * (job.reftype='EST' and job.refno=em.doc_no)*/
						
						/*String sqlqry="select job.voc_no,coalesce(aa.addition,0) labaddition,coalesce(bb.addition,0) spaddition,'view' as view,concat(gp.regno,'-',gp.pltid) vehno,em.voc_no estvocno,gp.voc_no gatevocno,if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) sparetot,em.brhid,em.gipno,coalesce(lab.labtot,0) labouttot,coalesce(em.discount,0) discount,"
									+" (if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) +coalesce(lab.labtot,0)) nettotal,em.date,em.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no gateinpassdocno"
									+" from ws_estm em "
									+" left join ws_gateinpass gp on (em.gipno=gp.doc_no)"
									+" left join (select rdocno, sum(total) labtot,confirmed,approved from ws_estlabour group by rdocno) lab  on (em.doc_no=lab.rdocno)"
									+" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"
									+" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"
									+" left join gl_yom yom on gp.yom=yom.doc_no"
									+" left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"
									+" left join (select rdocno,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare group by rdocno) spr on (em.doc_no=spr.rdocno)"
									+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estspare where  addition>0    group by rdocno   ) bb on bb.rdocno=em.doc_no"
									+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estlabour where  addition>0    group by rdocno   ) aa on aa.rdocno=em.doc_no"
									+" left join (select count(addition) add1,rdocno,sum(confirmed) confirmed,sum(approved) approved from ws_estlabour group by rdocno   ) xx on xx.rdocno=em.doc_no"
									+" left join (select count(addition) add1,rdocno,sum(confirmed) confirmed,sum(approved) approved from ws_estspare group by rdocno   ) yy on yy.rdocno=em.doc_no"
									+" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no where (xx.add1=xx.confirmed and xx.add1=xx.approved) and (yy.add1=yy.confirmed and yy.add1=yy.approved) and gp.processstatus<7 and em.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+" group by em.doc_no;";	*/

				String sqlqry="select job.voc_no,coalesce(aa.addition,0) labaddition,coalesce(bb.addition,0) spaddition,'view' as view,concat(gp.regno,'-',gp.pltid) vehno,em.voc_no estvocno,gp.voc_no gatevocno,if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(em.lumsumamount,0)) sparetot,em.brhid,em.gipno,coalesce(lab.labtot,0) labouttot,coalesce(em.discount,0) discount,"
								+" (if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(em.lumsumamount,0)) ) nettotal,em.date,em.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no gateinpassdocno"
								+" from ws_estm em "
								+" left join ws_gateinpass gp on (em.gipno=gp.doc_no)"
								+" left join (select rdocno, sum(total) labtot,confirmed,approved from ws_estlabour group by rdocno) lab  on (em.doc_no=lab.rdocno)"
								+" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"
								+" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"
								+" left join gl_yom yom on gp.yom=yom.doc_no"
								+" left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"
								+" left join (select rdocno,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare group by rdocno) spr on (em.doc_no=spr.rdocno)"
								+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estspare where  addition>0    group by rdocno   ) bb on bb.rdocno=em.doc_no"
								+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estlabour where  addition>0    group by rdocno   ) aa on aa.rdocno=em.doc_no"
								
								+" left join (select rdocno,count(confirmed) confirmed from ws_estlabour where confirmed=0  group by rdocno   ) x1 on x1.rdocno=em.doc_no"
								+" left join (select rdocno,count(approved) approved from ws_estlabour where approved=0 group by rdocno   ) x2 on x2.rdocno=em.doc_no"

								+" left join (select rdocno,count(confirmed) confirmed from ws_estspare where confirmed=0 group by rdocno   ) y1 on y1.rdocno=em.doc_no"
								+" left join (select rdocno,count(approved) approved from ws_estspare where approved=0 group by rdocno   ) y2 on y2.rdocno=em.doc_no"
								
								+" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no where (coalesce(x1.confirmed,0)=0 and coalesce(x2.approved,0)=0) and (coalesce(y1.confirmed,0)=0 and coalesce(y2.approved,0)=0) and gp.processstatus<7 and em.date <='"+sqltodate+"'"+sqltest+" group by em.doc_no;";
						
									
						System.out.println("aproved _-__-----"+sqlqry);
						ResultSet resultSet = stmtCRM.executeQuery (sqlqry);
		                
						
						
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						
						stmtCRM.close();
						conn.close();
					}
					
					if(approv.equalsIgnoreCase("tobeapproved")){
						
						/*String sqlqry="select job.voc_no,coalesce(aa.addition,0) labaddition,coalesce(bb.addition,0) spaddition,'view' as view,concat(gp.regno,'-',gp.pltid) vehno,em.voc_no estvocno,gp.voc_no gatevocno,if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) sparetot,em.brhid,em.gipno,coalesce(lab.labtot,0) labouttot,coalesce(em.discount,0) discount,"
									+" (if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) +coalesce(lab.labtot,0)) nettotal,em.date,em.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no gateinpassdocno"
									+" from ws_estm em "
									+" left join ws_gateinpass gp on (em.gipno=gp.doc_no)"
									+" left join (select rdocno, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 and approved=0  group by rdocno) lab  on (em.doc_no=lab.rdocno)"									
									+" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"
									+" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"
									+" left join gl_yom yom on gp.yom=yom.doc_no"
									+" left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"
									+" left join (select rdocno,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 and approved=0 group by rdocno) spr on (em.doc_no=spr.rdocno)"
									+" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no"
									+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estspare where  addition>0    group by rdocno   ) bb on bb.rdocno=em.doc_no"
									+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estlabour where  addition>0    group by rdocno   ) aa on aa.rdocno=em.doc_no"
									+" left join (select count(addition) add1,rdocno,sum(confirmed) confirmed,sum(approved) approved from ws_estlabour group by rdocno   ) xx on xx.rdocno=em.doc_no"
									+" left join (select count(addition) add1,rdocno,sum(confirmed) confirmed,sum(approved) approved from ws_estspare group by rdocno   ) yy on yy.rdocno=em.doc_no"	
									+" where (xx.approved<xx.add1 and xx.confirmed=xx.add1) or (yy.confirmed=yy.add1 and yy.approved<yy.add1) and em.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+"  group by em.doc_no;";*/

/*						String sqlqry="select job.voc_no,coalesce(aa.addition,0) labaddition,coalesce(bb.addition,0) spaddition,'view' as view,concat(gp.regno,'-',gp.pltid) vehno,em.voc_no estvocno,gp.voc_no gatevocno,if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) sparetot,em.brhid,em.gipno,if(em.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(lab.labtot,0)+coalesce(em.servicelumsumamt,0)) labouttot,coalesce(em.discount,0) discount,"
									+" case when em.chkrandomlumsum=0 then if(em.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(lab.labtot,0)+coalesce(em.servicelumsumamt,0))+if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) else coalesce(em.randomlumsumamt,0) end  nettotal,em.date,em.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no gateinpassdocno"
									+" from ws_estm em "
									+" left join ws_estmadd ad on em.doc_no=ad.doc_no"
									+" left join ws_gateinpass gp on (em.gipno=gp.doc_no)"
									+" left join (select rdocno, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 and approved=0  group by rdocno) lab  on (em.doc_no=lab.rdocno)"									
									+" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"
									+" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"
									+" left join gl_yom yom on gp.yom=yom.doc_no"
									+" left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"
									+" left join (select rdocno,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 and approved=0 group by rdocno) spr on (em.doc_no=spr.rdocno)"
									+" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no"
									+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estspare where  addition>0    group by rdocno   ) bb on bb.rdocno=em.doc_no"
									+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estlabour where  addition>0    group by rdocno   ) aa on aa.rdocno=em.doc_no"
									
								+" left join (select rdocno,count(confirmed) confirmed from ws_estlabour where confirmed=0  group by rdocno   ) x1 on x1.rdocno=em.doc_no"
								+" left join (select rdocno,count(approved) approved from ws_estlabour where approved=0 group by rdocno   ) x2 on x2.rdocno=em.doc_no"

								+" left join (select rdocno,count(confirmed) confirmed from ws_estspare where confirmed=0 group by rdocno   ) y1 on y1.rdocno=em.doc_no"
								+" left join (select rdocno,count(approved) approved from ws_estspare where approved=0 group by rdocno   ) y2 on y2.rdocno=em.doc_no"								
									
									+" where ((coalesce(x1.confirmed,0)=0 and coalesce(x2.approved,0)>0) or (coalesce(y1.confirmed,0)=0 and coalesce(y2.approved,0)>0)) and em.date <='"+sqltodate+"'"+sqltest+"  group by em.doc_no;";
*/
						/*String sqlqry="select job.voc_no,coalesce(lab.addition,0) labaddition,coalesce(spr.addition,0) spaddition,'view' as view,concat(gp.regno,'-',gp.pltid) vehno,em.voc_no estvocno,gp.voc_no gatevocno,"+
						" if(spr.addition>0,if(ad.chklumsum=0,coalesce(spr.sparetot,0),coalesce(ad.lumsumamount,0)),"+
						" if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(em.lumsumamount,0))) sparetot,"+
						" if(lab.addition>0,if(ad.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(ad.servicelumsumamt,0)),"+
						" if(em.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(em.servicelumsumamt,0))) labouttot,"+
						" case when coalesce(ad.chkrandomlumsum,0)=0 and em.chkrandomlumsum=0 then if(lab.addition>0,if(ad.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(ad.servicelumsumamt,0)),"+
						" if(em.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(em.servicelumsumamt,0)))+if(spr.addition>0,if(ad.chklumsum=0,coalesce(spr.sparetot,0),coalesce(ad.lumsumamount,0)),"+
						" if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(em.lumsumamount,0))) else if(coalesce(ad.addition,0)>0,coalesce(ad.randomlumsumamt,0),coalesce(em.randomlumsumamt,0)) end nettotal,"+
						" em.brhid,em.gipno,coalesce(em.discount,0) discount,em.date,em.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no gateinpassdocno from ws_estm em"+
						"  left join ws_gateinpass gp on (em.gipno=gp.doc_no) left join"+
						" (select rdocno,addition, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 and approved=0  group by rdocno,addition) lab  on (em.doc_no=lab.rdocno) left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM') left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no) left join gl_yom yom on gp.yom=yom.doc_no left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no) left join"+
						" (select rdocno,addition,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 and approved=0 group by rdocno,addition) spr on (em.doc_no=spr.rdocno) left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no"+
						" left join ws_estmadd ad on em.doc_no=ad.doc_no and (ad.addition=lab.addition or ad.addition=spr.addition)"+
						"  left join (select rdocno,count(confirmed) confirmed from ws_estlabour where confirmed=0  group by rdocno   ) x1 on x1.rdocno=em.doc_no left join (select rdocno,count(approved) approved from ws_estlabour where approved=0 group by rdocno   ) x2 on x2.rdocno=em.doc_no left join (select rdocno,count(confirmed) confirmed from ws_estspare where confirmed=0 group by rdocno   ) y1 on y1.rdocno=em.doc_no left join (select rdocno,count(approved) approved from ws_estspare where approved=0 group by rdocno   ) y2 on y2.rdocno=em.doc_no where ((coalesce(x1.confirmed,0)=0 and coalesce(x2.approved,0)>0) or (coalesce(y1.confirmed,0)=0 and coalesce(y2.approved,0)>0)) and em.date <='"+sqltodate+"'"+sqltest+"  group by em.doc_no";
						*/
						String sqlqry="select job.voc_no,0 labaddition,0 spaddition,'view' as view,concat(gp.regno,'-',gp.pltid) vehno,em.voc_no estvocno,gp.voc_no gatevocno,  if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(em.lumsumamount,0)) sparetot,if(em.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(em.servicelumsumamt,0)) labouttot,"+
						" case when coalesce(em.chkrandomlumsum,0)=1 then em.randomlumsumamt else if(em.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(em.servicelumsumamt,0))+"+
						" if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(em.lumsumamount,0)) end nettotal,em.brhid,em.gipno,coalesce(em.discount,0) discount,convert(em.date,date) date,em.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no  gateinpassdocno from ws_estm em left join ws_gateinpass gp on (em.gipno=gp.doc_no)"+
						" left join (select rdocno,addition, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 and approved=0  group by rdocno,addition) lab  on (em.doc_no=lab.rdocno and lab.addition=0)"+
						" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"+
						" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"+
						" left join gl_yom yom on gp.yom=yom.doc_no left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"+
						" left join (select rdocno,addition,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 and approved=0 group by rdocno,addition) spr on (em.doc_no=spr.rdocno and spr.addition=0)"+
						" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no"+
						" where em.date <='"+sqltodate+"'"+sqltest+" and em.approved=0 group by em.doc_no union all"+
						" select job.voc_no,ad.addition labaddition,ad.addition,'view' as view,concat(gp.regno,'-',gp.pltid) vehno,ad.voc_no estvocno,gp.voc_no gatevocno,  if(ad.chklumsum=0,coalesce(spr.sparetot,0),coalesce(ad.lumsumamount,0)) sparetot,if(ad.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(ad.servicelumsumamt,0)) labouttot,"+
						" case when coalesce(ad.chkrandomlumsum,0)=1 then ad.randomlumsumamt else if(ad.chkservicelumsum=0,coalesce(lab.labtot,0),coalesce(ad.servicelumsumamt,0))+"+
						" if(ad.chklumsum=0,coalesce(spr.sparetot,0),coalesce(ad.lumsumamount,0)) end nettotal,ad.brhid,em.gipno,coalesce(em.discount,0) discount,convert(ad.date,date) date,ad.doc_no,mac.refname, convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) vehicledetails,gp.doc_no  gateinpassdocno from ws_estm em left join ws_gateinpass gp on (em.gipno=gp.doc_no)"+
						" left join ws_estmadd ad on em.doc_no=ad.doc_no"+
						" left join (select rdocno,addition, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 and approved=0  group by rdocno,addition) lab  on (em.doc_no=lab.rdocno and lab.addition=ad.addition)"+
						" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"+
						" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"+
						" left join gl_yom yom on gp.yom=yom.doc_no left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"+
						" left join (select rdocno,addition,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 and approved=0 group by rdocno,addition) spr on (em.doc_no=spr.rdocno and spr.addition=ad.addition)"+
						" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no"+
						" where ad.date <='"+sqltodate+"'"+sqltest+" and ad.approved=0 and ad.addition>0 group by ad.doc_no,ad.addition";
						System.out.println("tobe approved----:"+sqlqry);
						ResultSet resultSet = stmtCRM.executeQuery (sqlqry);
		                
						
						
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						
						stmtCRM.close();
						conn.close();
					}
					
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
			
	    }
		
		public JSONArray getApprovalExportData(String todate,String approv,String docnos,String branch)throws SQLException
		{
			JSONArray approvaldata=new JSONArray();      
			Connection conn=null;
			try{
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				java.sql.Date sqlfromdate=null,sqltodate=null;
				/*if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
					sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
				}*/
				if(!todate.equalsIgnoreCase("") && todate!=null){
					sqltodate=commonDAO.changeStringtoSqlDate(todate);
				}
				
				String sqltest="";
				if(!docnos.equalsIgnoreCase("") && docnos!=null){
					//System.out.println("sqltest");
					 sqltest+=" and mac.cldocno='"+docnos+"'";
				}
				if(!branch.equalsIgnoreCase("") && branch.equalsIgnoreCase("a") ){        
					 sqltest+=" and em.brhid='"+branch+"'";       
				}
				if(approv.equalsIgnoreCase("approved")){
					
					String sqlqry="select em.voc_no 'Doc No',em.date 'Date',gp.voc_no 'Gate In Pass Doc No',em.doc_no,mac.refname 'User Name',concat(gp.regno,'-',gp.pltid) 'Vehicle No', convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) 'Vehicle Details',"
							+" coalesce(lab.labtot,0) 'Labour Total',if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) 'Spare Total',coalesce(em.discount,0) 'Discount',(if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) +coalesce(lab.labtot,0)) 'Net Total'"
							+" from ws_estm em "
							+" left join ws_gateinpass gp on (em.gipno=gp.doc_no)"
							+" left join (select rdocno, sum(total) labtot,confirmed,approved from ws_estlabour group by rdocno) lab  on (em.doc_no=lab.rdocno)"
							+" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"
							+" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"
							+" left join gl_yom yom on gp.yom=yom.doc_no"
							+" left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"
							+" left join (select rdocno,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare group by rdocno) spr on (em.doc_no=spr.rdocno)"
							+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estspare where  addition>0    group by rdocno   ) bb on bb.rdocno=em.doc_no"
							+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estlabour where  addition>0    group by rdocno   ) aa on aa.rdocno=em.doc_no"
							
							+" left join (select rdocno,count(confirmed) confirmed from ws_estlabour where confirmed=0  group by rdocno   ) x1 on x1.rdocno=em.doc_no"
							+" left join (select rdocno,count(approved) approved from ws_estlabour where approved=0 group by rdocno   ) x2 on x2.rdocno=em.doc_no"

							+" left join (select rdocno,count(confirmed) confirmed from ws_estspare where confirmed=0 group by rdocno   ) y1 on y1.rdocno=em.doc_no"
							+" left join (select rdocno,count(approved) approved from ws_estspare where approved=0 group by rdocno   ) y2 on y2.rdocno=em.doc_no"
							
							+" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no where (coalesce(x1.confirmed,0)=0 and coalesce(x2.approved,0)=0) and (coalesce(y1.confirmed,0)=0 and coalesce(y2.approved,0)=0) and gp.processstatus<7 and em.date <='"+sqltodate+"'"+sqltest+" group by em.doc_no;";
					
								
					System.out.println(sqlqry);
					ResultSet rs=stmtCRM.executeQuery(sqlqry);
					approvaldata=commonDAO.convertToEXCEL(rs);
					conn.close();
				}
				
				if(approv.equalsIgnoreCase("tobeapproved")){
					
					
					String sqlqry="select em.voc_no 'Doc No',em.date 'Date',gp.voc_no 'Gate In Pass Doc No',em.doc_no,mac.refname 'User Name',concat(gp.regno,'-',gp.pltid) 'Vehicle No', convert(concat(coalesce(vbrand.brand_name,''),' ',coalesce(vmodel.vtype,''),' ',coalesce(yom.yom,''),' Others: ', coalesce(gp.vehother,'')),char(200)) 'Vehicle Details',"
								+" coalesce(lab.labtot,0) 'Labour Total',if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) 'Spare Total',coalesce(em.discount,0) 'Discount',(if(em.chklumsum=0,coalesce(spr.sparetot,0),coalesce(spr.sparetot,0)+coalesce(em.lumsumamount,0)) +coalesce(lab.labtot,0)) 'Net Total'"
								+" from ws_estm em "
								+" left join ws_gateinpass gp on (em.gipno=gp.doc_no)"
								+" left join (select rdocno, sum(total) labtot,confirmed,approved from ws_estlabour where confirmed=1 and approved=0  group by rdocno) lab  on (em.doc_no=lab.rdocno)"									
								+" left join my_acbook mac on (gp.cldocno=mac.cldocno and mac.dtype='CRM')"
								+" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"
								+" left join gl_yom yom on gp.yom=yom.doc_no"
								+" left join ws_jobcard job on (job.reftype='EST' and job.refno=em.doc_no)"
								+" left join (select rdocno,sum(approvedvalue) sparetot,confirmed,approved from  ws_estspare where confirmed=1 and approved=0 group by rdocno) spr on (em.doc_no=spr.rdocno)"
								+" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no"
								+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estspare where  addition>0    group by rdocno   ) bb on bb.rdocno=em.doc_no"
								+" left join (select count(addition) add1,rdocno,max(addition) addition from ws_estlabour where  addition>0    group by rdocno   ) aa on aa.rdocno=em.doc_no"
								
							+" left join (select rdocno,count(confirmed) confirmed from ws_estlabour where confirmed=0  group by rdocno   ) x1 on x1.rdocno=em.doc_no"
							+" left join (select rdocno,count(approved) approved from ws_estlabour where approved=0 group by rdocno   ) x2 on x2.rdocno=em.doc_no"

							+" left join (select rdocno,count(confirmed) confirmed from ws_estspare where confirmed=0 group by rdocno   ) y1 on y1.rdocno=em.doc_no"
							+" left join (select rdocno,count(approved) approved from ws_estspare where approved=0 group by rdocno   ) y2 on y2.rdocno=em.doc_no"								
								
								+" where ((coalesce(x1.confirmed,0)=0 and coalesce(x2.approved,0)>0) or (coalesce(y1.confirmed,0)=0 and coalesce(y2.approved,0)>0)) and em.date <='"+sqltodate+"'"+sqltest+"  group by em.doc_no,ad.addition;";
					
					
					System.out.println(sqlqry);
					ResultSet rs=stmtCRM.executeQuery(sqlqry);
					approvaldata=commonDAO.convertToEXCEL(rs);
					stmtCRM.close();
					conn.close();
				}
				 
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return approvaldata;
		}
		
		public ClsQuotationApprovalBean getPrint(String estDocno)throws SQLException{
			
	    	 Connection conn =null;
	    	 ClsQuotationApprovalBean qabean=new ClsQuotationApprovalBean();
	      try {
	    	   conn = connDAO.getMyConnection();
	    	   Statement stmt = conn.createStatement();
	    	   
	    	   int tax=0;
	    	   String strsql="select ac.tax,u.user_name sadvisor,coalesce(wsa.sal_name,'') serviceadvisor,round(coalesce(gp.kmin,0),0) lblkm,brch.tinno comptrn,cmp.tel,cmp.fax,cmp.company,brch.branchname,em.sparetot sparetot,em.gipno,em.labouttot,em.discount,em.nettotal,gp.claim,concat(gp.regno,'-',gp.pltid) regno,gp.mainremarks,coalesce(gp.vehother,'') vehother,gp.other,ac.refname client,"
								+" DATE_FORMAT(em.date, '%d-%m-%Y') date,em.doc_no,em.voc_no estvocno,gp.voc_no gipvocno,vbrand.brand_name,vmodel.vtype,yom.yom,gp.doc_no gipno,gp.lpo,round(gp.lpoamount,2) lpoamount,gp.excess,round(gp.excessamt,2) excessamt,gp.username"
								+" from ws_estm em left join ws_gateinpass gp on em.gipno=gp.doc_no"
								+" left join gl_vehbrand vbrand on(gp.brdid=vbrand.doc_no)"
								+" left join gl_yom yom on gp.yom=yom.doc_no"
								+" left join my_acbook ac on(if(gp.insurancecomp=1,gp.insurcldocno=ac.cldocno,gp.cldocno=ac.cldocno) and dtype='CRM')"
								+" left join my_brch brch on em.brhid=brch.doc_no"
								+" left join my_comp cmp on brch.branch=cmp.comp_id"
								+" left join my_salesman wsa on (gp.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA')"
								+" left join my_user u on gp.userid=u.doc_no  "
								+" left join gl_vehmodel vmodel on gp.modid=vmodel.doc_no where em.doc_no="+estDocno;
	    	   		   System.out.println("lbl values---------: "+strsql);
	    			   ResultSet rs=stmt.executeQuery(strsql);
	    			   String gatedocno="";
	    			   while(rs.next()){
	    				   tax=rs.getInt("tax");
	    				   qabean.setLblkm(rs.getString("lblkm"));
	    				   System.out.println(rs.getString("username")+rs.getString("brand_name")+rs.getString("labouttot")+rs.getString("sparetot"));
	    				   gatedocno=rs.getString("gipno");
						   qabean.setLblcomptrn(rs.getString("comptrn"));
	    				  qabean.setLblUserName(rs.getString("username"));
	    				  qabean.setLblBrand(rs.getString("brand_name"));
	    				  qabean.setLblClaim(rs.getString("claim"));
	    				  qabean.setLblDiscount(rs.getString("discount"));
	    				  
	    				  qabean.setLblEstNo(rs.getString("estvocno"));
	    				  qabean.setLblExcessAmt(rs.getString("excessamt"));
	    				  qabean.setLblGipNo(rs.getString("gipvocno"));
	    				  
	    				  qabean.setLblLpo(rs.getString("lpo"));
	    				  qabean.setLblLpoAmt(rs.getString("lpoamount"));
	    				  qabean.setLblModel(rs.getString("vtype"));
	    				  qabean.setLblRegNo(rs.getString("regno"));
	    				  qabean.setLblRemarks(rs.getString("vehother"));
	    				  
	    				  qabean.setLblYom(rs.getString("yom"));
	    				  qabean.setLblDate(rs.getString("date"));
	    				  qabean.setLblOthers(rs.getString("other"));
	    				  qabean.setLblClient(rs.getString("client"));
	    				  qabean.setLblcompfax(rs.getString("fax"));
	    				  qabean.setLblcomptel(rs.getString("tel"));
	    				  qabean.setLblcompname(rs.getString("company"));
	    				  qabean.setLblbranch(rs.getString("branchname"));
	    				  qabean.setLblserviceadvisor(rs.getString("sadvisor"));
	    			   }
	    			   
	    			   Statement stmt1 = conn.createStatement();
	    			   
	    			   //String parts="select round(approved,2) approved from ws_estm em left join ws_estspareamt eamt on em.gipno=eamt.gatedocno where eamt.description='Total Parts Cost' and em.doc_no="+estDocno;
	    			   String parts="select round(sum(approvedvalue),2) approved from ws_estspare where rdocno="+estDocno;
	    			   System.out.println("parts values---------: "+parts);
	    			   ResultSet prs=stmt1.executeQuery(parts);
	    			   while(prs.next()){
	    				   qabean.setLblSparePartsTotal(prs.getString("approved"));
	    			   }
	    			   
	    			   //String labour="select coalesce(round(approved,2),0) approved from ws_estm em left join ws_estspareamt eamt on em.gipno=eamt.gatedocno where eamt.description='Total Services Cost' and em.doc_no="+estDocno;
	    			   String labour="select round(sum(total),2) approved from ws_estlabour where rdocno="+estDocno;
	    			   System.out.println("labour values---------: "+labour);
	    			   ResultSet lrs=stmt1.executeQuery(labour);
	    			   while(lrs.next()){
	    				   qabean.setLblLabourTotal(lrs.getString("approved"));
	    			   }
	    			   //String vat="select coalesce(round(approved,2),0) approved from ws_estm em left join ws_estspareamt eamt on em.gipno=eamt.gatedocno where eamt.description='VAT' and em.doc_no="+estDocno;
	    			   String vat= "select round(("+ qabean.getLblSparePartsTotal()+" + " +qabean.getLblLabourTotal()+") * if("+tax+"=1,0.05,0) ,2) approved ";
	    			   System.out.println("labour values---------: "+vat);
	    			   ResultSet lvat=stmt1.executeQuery(vat);
	    			   while(lvat.next()){
	    				   qabean.setLblvat(lvat.getString("approved"));
	    			   }
	    			   //String total="select coalesce(round(approved,2),0) approved from ws_estm em left join ws_estspareamt eamt on em.gipno=eamt.gatedocno where eamt.description='Net Total with VAT' and em.doc_no="+estDocno;
	    			   String total="select round(("+ qabean.getLblSparePartsTotal()+" + " +qabean.getLblLabourTotal()+") * if("+tax+"=1,1.05,1) ,2) approved ";
	    			   System.out.println("total values---------: "+total);
	    			   
	    			   ResultSet trs=stmt1.executeQuery(total);
	    			   while(trs.next()){
	    				   String vattotal=trs.getString("approved");
	    				   
	    				   /*if(vattotal.equalsIgnoreCase(null)){ vattotal="0"; }*/
	    				   
	    				   qabean.setLblEstimation(vattotal);
	    				   
	    				   ClsAmountToWords towords=new ClsAmountToWords();
	    				   String amtinwrds= towords.convertAmountToWords(vattotal);
	    				   
	    				   qabean.setLblvattotal(amtinwrds);
	    				   
	    			   }
	    			   
	    			ArrayList<String> spdetails=new ArrayList<>();
	    			spdetails=getSparePartsDetails(estDocno,conn);
	    			
	    			ArrayList<String> alicspdetails=new ArrayList<>();
	    			alicspdetails=getAliceSparePartsDetails(estDocno,conn);
	    			
	    			ArrayList<String> jbcostdetails=new ArrayList<>();
	    			jbcostdetails=getLabourCharges(estDocno,conn);
	    			
	    			ArrayList<String> jbcostdetails2=new ArrayList<>();
	    			jbcostdetails2=getLabourChargescarfare(estDocno,conn);
	    			
	    			ArrayList<String> jblistdetails=new ArrayList<>();
	    			jblistdetails=getJobListDetails(gatedocno,conn);
	    			
	    			HttpServletRequest request=ServletActionContext.getRequest();
	    			request.setAttribute("SPAREPRINT", spdetails);
	    			request.setAttribute("JBCOSTPRINT", jbcostdetails);
	    			request.setAttribute("JBCOSTPRINTCARFARE", jbcostdetails2);
	    			request.setAttribute("JBLISTPRINT", jblistdetails);
	    			request.setAttribute("ALICESPAREPRINT", alicspdetails);
	    	   
	    	   
		  }catch(Exception e){
				 e.printStackTrace();
				 conn.close();
		  }
	      finally{
	    	  conn.close();
	      }
	      
	      return qabean;
		}
		
		private ArrayList<String> getSparePartsDetails(String docno, Connection conn) throws SQLException {
			ArrayList<String> sparray=new ArrayList<>();
			try{
				Statement stmt=conn.createStatement();
				int i=1;
				int lumsum=0;
				String sqltest="";
				ResultSet rs2=stmt.executeQuery("select chklumsum from ws_estm where doc_no="+docno);
				while(rs2.next()){
					System.out.println("select chklumsum from ws_estm where doc_no="+docno+"===="+rs2.getInt("chklumsum"));
					lumsum=rs2.getInt("chklumsum");
				}
//				lumsum=0;
				System.out.println("select chklumsum from ws_estm where doc_no="+docno+"===="+lumsum);
				if(lumsum==1){
					sqltest=" union all"
						+" select * from ( select '0' qty,'Lumsum Value' sparedesc,'0' as genuinerate, '0' as marketrate,'0' as usedrate,'0' genuinetotal, '0' as markettotal,'0' usedtotal,em.lumsumamount approvedvalue,'' as rate,'' as  markuppercent,'' as  total,'' as  remarks,'' as  brand,'' as  brdid,'' as  partdocno,'' as  partno,'' as  description,'' as  doc_no,'' as  unit,'' as  unitdocno,'' as  psrno"
						+" from ws_estm em where doc_no="+docno+" and chklumsum=1)b;";				
								}

				String strsql="select * from ( select round(spare.qty,0) qty,spare.description sparedesc,round(spare.genuinerate,2) genuinerate,"+
				" round(spare.marketrate,2) marketrate,round(spare.usedrate,2) usedrate,round(spare.genuinetotal,2) genuinetotal,"+
				" round(spare.markettotal,2) markettotal,round(spare.usedtotal,2) usedtotal,round(spare.approvedvalue,2) approvedvalue,spare.rate,spare.markupper markuppercent,spare.total,spare.remarks,bd.brandname brand,bd.doc_no brdid,m.psrno partdocno,m.part_no partno,m.productname description,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "+
						" from ws_estspare spare left join my_main m on spare.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
						" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
						" where  spare.rdocno="+docno+"  order by i.date) a"+sqltest;
				
				
				System.out.println("Spare Parts-----------------------: "+strsql);
						ResultSet rs=stmt.executeQuery(strsql);
						double genuinetotal=0.0,markettotal=0.0,usedtotal=0.0,approvedtotal=0.0;
				while(rs.next()){
					String temp="";
					genuinetotal+=rs.getDouble("genuinetotal");
						markettotal+=rs.getDouble("markettotal");
						usedtotal+=rs.getDouble("usedtotal");
						approvedtotal+=rs.getDouble("approvedvalue");
						temp=i+"::"+rs.getString("sparedesc")+"::"+rs.getString("qty")+"::"+rs.getString("genuinerate")+"::"+rs.getString("marketrate")+"::"+rs.getString("usedrate")+"::"+rs.getString("genuinetotal")+"::"+rs.getString("markettotal")+"::"+rs.getString("usedtotal")+"::"+rs.getString("approvedvalue");
						i++;
					sparray.add(temp);
					
				}
				sparray.add(" "+"::"+" "+"::"+" "+"::"+" "+"::"+" "+"::"+" "+"::"+genuinetotal+"::"+markettotal+"::"+usedtotal+"::"+approvedtotal);
				stmt.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return sparray;
		}
		private ArrayList<String> getAliceSparePartsDetails(String docno, Connection conn) throws SQLException {
			ArrayList<String> sparray=new ArrayList<>();
			try{
				Statement stmt=conn.createStatement();
				int i=1;
				int lumsum=0;
				String sqltest="";
				ResultSet rs2=stmt.executeQuery("select chklumsum from ws_estm where doc_no="+docno);
				while(rs2.next()){
					System.out.println("select chklumsum from ws_estm where doc_no="+docno+"===="+rs2.getInt("chklumsum"));
					lumsum=rs2.getInt("chklumsum");
				}
//				lumsum=0;
				System.out.println("select chklumsum from ws_estm where doc_no="+docno+"===="+lumsum);
				if(lumsum==1){
					sqltest=" union all"
						+" select * from ( select '0' qty,'Lumsum Value' sparedesc,'0' as genuinerate, '0' as marketrate,'0' as usedrate,'0' genuinetotal, '0' as markettotal,'0' usedtotal,em.lumsumamount approvedvalue,'' as rate,'' as  markuppercent,'' as  total,'' as  remarks,'' as  brand,'' as  brdid,'' as  partdocno,'' as  partno,'' as  description,'' as  doc_no,'' as  unit,'' as  unitdocno,'' as  psrno"
						+" from ws_estm em where doc_no="+docno+" and chklumsum=1)b;";				
								}

				String strsql="select * from ( select round(spare.qty,0) qty,spare.description sparedesc,round(spare.rate,2) rate,round(spare.genuinerate,2) genuinerate,"+
				" round(spare.marketrate,2) marketrate,round(spare.usedrate,2) usedrate,round(spare.genuinetotal,2) genuinetotal,"+
				" round(spare.markettotal,2) markettotal,round(spare.usedtotal,2) usedtotal,round(spare.approvedvalue,2) approvedvalue,spare.markupper markuppercent,spare.total,spare.remarks,bd.brandname brand,bd.doc_no brdid,m.psrno partdocno,m.part_no partno,m.productname description,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "+
						" from ws_estspare spare left join my_main m on spare.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
						" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
						" where  spare.rdocno="+docno+"  order by i.date) a"+sqltest;
				
				
				System.out.println("Spare Parts-----------------------: "+strsql);
						ResultSet rs=stmt.executeQuery(strsql);
						double genuinetotal=0.0,markettotal=0.0,usedtotal=0.0,approvedtotal=0.00;
				while(rs.next()){
					String temp="";
						approvedtotal+=rs.getDouble("approvedvalue");
						temp=i+"::"+rs.getString("sparedesc")+"::"+rs.getString("qty")+"::"+rs.getString("rate")+"::"+rs.getString("approvedvalue");
						i++;
					sparray.add(temp);
					
				}
				sparray.add(" "+"::"+" "+"::"+" "+"::"+" "+"::"+approvedtotal);
				stmt.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return sparray;
		}
		
		private ArrayList<String> getLabourCharges(String docno, Connection conn) throws SQLException {
			ArrayList<String> jbarray=new ArrayList<>();
			try{
				Statement stmt=conn.createStatement();
				int i=1;
				String strsql="select m.desc1 jobdesc,m.doc_no,m.date,lab.hrs,round(lab.rate,2) rate,t.type jobtype,lab.markupper markuppercent,round(lab.total,2) total,lab.remarks,"+
						" m.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
						" where m.status=3 and lab.rdocno="+docno;
				
						System.out.println("Spare Parts: "+strsql);
						ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					String temp="";
					
					temp=i+"::"+rs.getString("jobtype")+"::"+rs.getString("jobdesc");
						i++;
					jbarray.add(temp);
					
				}
				stmt.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return jbarray;
		}
		
		private ArrayList<String> getLabourChargescarfare(String docno, Connection conn) throws SQLException {
			ArrayList<String> jbarray=new ArrayList<>();
			try{
				Statement stmt=conn.createStatement();
				int i=1;
				String strsql="select m.desc1 jobdesc,round(lab.rate,2) rate,round(lab.total,2) total,lab.remarks,"+
						" m.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
						" where m.status=3 and lab.rdocno="+docno;
				
						System.out.println("Spare Parts: "+strsql);
						ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					String temp="";
					
					temp=i+"::"+rs.getString("jobdesc")+"::"+rs.getString("rate")+"::"+rs.getString("total");
						i++;
					jbarray.add(temp);
					
				}
				stmt.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return jbarray;
		}
		
		
		
		private ArrayList<String> getJobListDetails(String docno, Connection conn) throws SQLException {
			ArrayList<String> jblarray=new ArrayList<>();
			try{
				Statement stmt=conn.createStatement();
				String strsql="select comp.compname complaint,gate.desc1 description,comp.doc_no complaintid from ws_gateinpassd gate left join gl_complaint comp on gate.complaintid=comp.doc_no where gate.rdocno="+docno;
				System.out.println(strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				int i=1;
				while(rs.next()){
					String temp="";
					
						temp=i+"::"+rs.getString("complaint")+"::"+rs.getString("description");
						i++;
						jblarray.add(temp);
					
				}
				stmt.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return jblarray;
		}
			
		
		
	}


