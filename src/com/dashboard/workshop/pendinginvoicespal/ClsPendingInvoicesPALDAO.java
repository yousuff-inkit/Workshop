package com.dashboard.workshop.pendinginvoicespal;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;

public class ClsPendingInvoicesPALDAO {

    ClsConnection objconn=new ClsConnection();
    ClsCommon objcommon=new ClsCommon();
    
    public JSONArray getPendingData(String branch,String todate,String id) throws SQLException
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
            
            /*String strsql="select a.*,sum(a.amount) total from (select coalesce(pend.remarks,'') remarks,job.doc_no jobcarddocno,job.voc_no jobcardvocno,job.date,"+
            " concat(gate.pltid,' ',gate.regno) regno,concat(brd.brand_name,' ',model.vtype) flname,coalesce(sal.sal_name,'') sal_name,"+
            " ac.refname,datediff(curdate(),gate.date) age,coalesce(lab.invoiceamt,0) amount from "+
            " ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST' "+
            " and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on gate.brdid=brd.doc_no "+
            " left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left "+
            " join my_salm sal on ac.sal_id=sal.doc_no left join ws_estlabour lab on est.doc_no=lab.rdocno left join (select max(rowno) maxdoc,rdocno maxrdoc from ws_pendinginvfollowup group by rdocno) a on"+
            " (a.maxrdoc=job.doc_no) left join ws_pendinginvfollowup pend on a.maxdoc=pend.rowno where inv.refno is null and job.complete=1"+sqltest+" union all"+
            " select coalesce(pend.remarks,'') remarks,job.doc_no jobcarddocno,job.voc_no jobcardvocno,job.date,"+
            " concat(gate.pltid,' ',gate.regno) regno,concat(brd.brand_name,' ',model.vtype) flname,coalesce(sal.sal_name,'') sal_name,"+
            " ac.refname,datediff(curdate(),gate.date) age,coalesce(spare.customeramt,0) amount from "+
            " ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST' "+
            " and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on gate.brdid=brd.doc_no "+
            " left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left "+
            " join my_salm sal on ac.sal_id=sal.doc_no left join ws_jccspare spare on job.doc_no=spare.jobcarddocno left join (select max(rowno) maxdoc,rdocno maxrdoc from ws_pendinginvfollowup group by rdocno) a on"+
            " (a.maxrdoc=job.doc_no) left join ws_pendinginvfollowup pend on a.maxdoc=pend.rowno where inv.refno is null and job.complete=1"+sqltest+") a group by  a.jobcarddocno";*/
            
            String strsql="select * from (select coalesce(wmp.sal_name,'') estimator, gate.processstatus,round(coalesce(lab.labtot+sp.sparestot,0),2) nettotal,round(coalesce(lab.labtot,0),2) labourtotal,round(coalesce(sp.sparestot,0),2) partstotal,coalesce(ac.refname,'') clientname,coalesce(insur.refname,'') insurcompname,coalesce(wsa.sal_name,'') serviceadvisor,coalesce(pend.remarks,'') remarks,job.doc_no jobcarddocno,job.voc_no jobcardvocno,job.date, concat(gate.pltid,' ',gate.regno) regno,concat(brd.brand_name,' ',model.vtype) flname,coalesce(sal.sal_name,'') sal_name, ac.refname,datediff(curdate(),gate.date) age,coalesce(labtot,0)+coalesce(sparestot,0) total,case when gate.processstatus=1 then 'Gate In Pass' when gate.processstatus=2 then 'Estimation' when gate.processstatus=3 then 'Confirm Est.' when processstatus=4 then 'Quotation Approval' when gate.processstatus=5 then 'Job Card' when gate.processstatus=6 then 'Job Card Complete' when gate.processstatus=7 then 'Invoiced' when gate.processstatus=8 then 'Gate Out Pass' when gate.processstatus=10 then 'Vehicle Release' else '' end gateprocess from"
            +" ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST'  and job.refno=est.doc_no) "
            +" left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) left join my_salesman wmp on(gate.marketingperson=wmp.doc_no and wmp.sal_type='WMP' and wmp.status=3)\r\n"
            + " left join gl_vehbrand brd on gate.brdid=brd.doc_no  left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on ( gate.cldocno=ac.cldocno and ac.dtype='CRM' ) left  join my_salm sal on ac.sal_id=sal.doc_no" 
            +" left join my_acbook insur on (insur.cldocno=gate.insurcldocno and insur.dtype='CRM')"
            +" left join (select max(rowno) maxdoc,rdocno maxrdoc from ws_pendinginvfollowup group by rdocno) a on (a.maxrdoc=job.doc_no) "
            +" left join ws_pendinginvfollowup pend on a.maxdoc=pend.rowno"
            +" left join (select sum(coalesce(invoiceamt,0)) labtot,rdocno,sum(coalesce(total,0)) labourtotal from ws_estlabour group by rdocno ) lab on est.doc_no=lab.rdocno"
            +" left join (select sum(coalesce(customeramt,0)) sparestot,jobcarddocno from ws_jccspare group by jobcarddocno ) sp on job.doc_no=sp.jobcarddocno"         
            +" where inv.refno is null and gate.processstatus<7 and job.complete=1"+sqltest+" union all"+
            " select coalesce(wmp.sal_name,'') estimator,gate.processstatus,round(coalesce(amtnet.amt,0),2) nettotal,round(coalesce(amtlab.amt,0),2) labourtotal,round(coalesce(amtspare.amt,0),2) partstotal,coalesce(ac.refname,'') clientname,coalesce(insur.refname,'') insurcompname,coalesce(wsa.sal_name,'') serviceadvisor,coalesce(pend.remarks,'') remarks,job.doc_no jobcarddocno,job.voc_no jobcardvocno,job.date, concat(gate.pltid,' ',gate.regno) regno,concat(brd.brand_name,' ',model.vtype) flname,coalesce(sal.sal_name,'') sal_name, ac.refname,datediff(curdate(),gate.date) age,round(coalesce(amtnet.amt,0),2) total,case when gate.processstatus=1 then 'Gate In Pass' when gate.processstatus=2 then 'Estimation' when gate.processstatus=3 then 'Confirm Est.' when processstatus=4 then 'Quotation Approval' when gate.processstatus=5 then 'Job Card' when gate.processstatus=6 then 'Job Card Complete' when gate.processstatus=7 then 'Invoiced' when gate.processstatus=8 then 'Gate Out Pass' when gate.processstatus=10 then 'Vehicle Release' else '' end gateprocess from"
            +" ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST'  and job.refno=est.doc_no) "
            +" left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) left join my_salesman wmp on(gate.marketingperson=wmp.doc_no and wmp.sal_type='WMP' and wmp.status=3)\r\n"
            + " left join gl_vehbrand brd on gate.brdid=brd.doc_no  left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on ( gate.cldocno=ac.cldocno and ac.dtype='CRM' ) left  join my_salm sal on ac.sal_id=sal.doc_no" 
            +" left join my_acbook insur on (insur.cldocno=gate.insurcldocno and insur.dtype='CRM')"
            +" left join (select max(rowno) maxdoc,rdocno maxrdoc from ws_pendinginvfollowup group by rdocno) a on (a.maxrdoc=job.doc_no) "
            +" left join ws_pendinginvfollowup pend on a.maxdoc=pend.rowno"
            +" left join (select sum(approved) amt,gatedocno from ws_estspareamt where description='Total Parts Cost' group by gatedocno) amtspare on (amtspare.gatedocno=gate.doc_no)"+
            " left join (select sum(approved) amt,gatedocno from ws_estspareamt where description='Total Services Cost' group by gatedocno) amtlab on (amtlab.gatedocno=gate.doc_no)"+
            " left join (select sum(approved) amt,gatedocno from ws_estspareamt where description='Sub Total' group by gatedocno) amtnet on (amtnet.gatedocno=gate.doc_no)"             
            +" where inv.refno is null and gate.processstatus<7 and job.complete=0"+sqltest+") x order by x.jobcardvocno";
            
            System.out.println(strsql);
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
    
    
    public JSONArray getPendingExcelData(String branch,String todate,String id) throws SQLException
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
            
            /*String strsql=" select b.voc_no 'Job Card No',date_format(b.date,'%d.%m.%Y') 'Date',b.regno 'Reg No', b.make 'Make',"+
            " b.sal_name 'Advisor',b.refname 'Party',b.age 'Age', round(sum(b.amount),2) 'Amount Total',b.status 'Status' from (select job.doc_no,job.voc_no,job.date,concat(gate.pltid,' ',gate.regno) regno,"+
            " concat(brd.brand_name,' ',model.vtype) make,coalesce(sal.sal_name,'') sal_name,ac.refname,datediff(curdate(),gate.date) age,"+
            " coalesce(lab.invoiceamt,0) amount,coalesce(pend.remarks,'') status from "+
            " ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST' "+
            " and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on gate.brdid=brd.doc_no "+
            " left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left "+
            " join my_salm sal on ac.sal_id=sal.doc_no left join ws_estlabour lab on est.doc_no=lab.rdocno left join (select max(rowno) maxdoc,"+
            " rdocno maxrdoc from ws_pendinginvfollowup group by rdocno) a on"+
            " (a.maxrdoc=job.doc_no) left join ws_pendinginvfollowup pend on a.maxdoc=pend.rowno where inv.refno is null and job.complete=1"+sqltest+" union all "+
            " select job.doc_no,job.voc_no,job.date,concat(gate.pltid,' ',gate.regno) regno,"+
            " concat(brd.brand_name,' ',model.vtype) make,coalesce(sal.sal_name,'') sal_name,ac.refname,datediff(curdate(),gate.date) age,"+
            " coalesce(spare.customeramt,0) amount,coalesce(pend.remarks,'') status from "+
            " ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST' "+
            " and job.refno=est.doc_no) left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join gl_vehbrand brd on gate.brdid=brd.doc_no "+
            " left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left "+
            " join my_salm sal on ac.sal_id=sal.doc_no left join ws_jccspare spare on "+
            " job.doc_no=spare.jobcarddocno left join (select max(rowno) maxdoc,rdocno maxrdoc from ws_pendinginvfollowup group by rdocno) a on"+
            " (a.maxrdoc=job.doc_no) left join ws_pendinginvfollowup pend on a.maxdoc=pend.rowno where inv.refno is null and job.complete=1"+sqltest+
            " ) b group by  b.doc_no";*/
            String strsql="select job.voc_no 'Job Card No',date_format(job.date,'%d.%m.%Y') 'Date',concat(gate.pltid,' ',gate.regno) 'Reg No',concat(brd.brand_name,' ',model.vtype) 'Make',"
                    +" coalesce(sal.sal_name,'') 'Salesman',coalesce(wsa.sal_name,'') 'Service Advisor',ac.refname 'Customer',datediff(curdate(),gate.date) 'Age', coalesce(labtot,0)+coalesce(sparestot,0) 'Amount Total',coalesce(pend.remarks,'') 'Status' from"
                    +" ws_jobcard job left join ws_invm inv on (inv.reftype='JC' and inv.refno=job.doc_no) left join ws_estm est on (job.reftype='EST'  and job.refno=est.doc_no) "
                    +" left join ws_gateinpass gate on (est.gipno=gate.doc_no) left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) left join gl_vehbrand brd on gate.brdid=brd.doc_no  left join gl_vehmodel model on gate.modid=model.doc_no left join my_acbook ac on ( gate.cldocno=ac.cldocno and ac.dtype='CRM' ) left  join my_salm sal on ac.sal_id=sal.doc_no" 
                    +" left join (select max(rowno) maxdoc,rdocno maxrdoc from ws_pendinginvfollowup group by rdocno) a on (a.maxrdoc=job.doc_no) "
                    +" left join ws_pendinginvfollowup pend on a.maxdoc=pend.rowno"
                    +" left join (select sum(coalesce(invoiceamt,0)) labtot,rdocno from ws_estlabour group by rdocno ) lab on est.doc_no=lab.rdocno"
                    +" left join (select sum(coalesce(customeramt,0)) sparestot,jobcarddocno from ws_jccspare group by jobcarddocno ) sp on job.doc_no=sp.jobcarddocno"
                    +" where inv.refno is null  and gate.processstatus<7 and job.complete=1 "+sqltest;
            
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
    
    
    public JSONArray getFollowupData(String jobcarddocno,String id) throws SQLException
    {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
            return data;
        }
        Connection conn=null;
        try{
            conn=objconn.getMyConnection();
            Statement stmt=conn.createStatement();
            
            String strsql="select pend.followupdate,usr.user_name user,pend.remarks from ws_pendinginvfollowup pend left join my_user usr on pend.userid=usr.doc_no where rdocno="+jobcarddocno;
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
}
