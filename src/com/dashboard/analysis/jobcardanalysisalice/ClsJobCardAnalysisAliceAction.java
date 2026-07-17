package com.dashboard.analysis.jobcardanalysisalice;


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;



import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobCardAnalysisAliceAction {

	
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	
	private Map<String, Object> param = null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	
	
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
   
		try {
               
               conn = connDAO.getMyConnection();
               Statement stmtJobcardAnalysis =conn.createStatement();
               param = new HashMap();
              
        	   String branch = request.getParameter("branch");
        	   String fromdate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String hidclient=request.getParameter("client");
               String hidaccname=request.getParameter("accname");
               String hidclientslm=request.getParameter("clientslm");
               String hidrepairtype=request.getParameter("repairtype");
               String hidinvoicestatus=request.getParameter("invoicestatus");
        	  
               String sqld="";
               
               if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA") || (branch.equalsIgnoreCase(""))))){
   				sqld+=" and r.brhId="+branch+"";
   			}
   			
               String sqltest="";
               java.sql.Date sqlfromdate=null,sqltodate=null;
               if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
               	sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
       		}
               if(!toDate.equalsIgnoreCase("") && toDate!=null){
               	sqltodate=commonDAO.changeStringtoSqlDate(toDate);
       		}
               
               if(!hidclient.equalsIgnoreCase("")){
       			 sqltest+=" and ac.cldocno in ("+hidclient+")";
       		 }
               if(!hidaccname.equalsIgnoreCase("")){
       			 sqltest+=" and bac.cldocno in ("+hidaccname+")";
       		 }
               if(!hidclientslm.equalsIgnoreCase("")){
       			 sqltest+=" and slm.doc_no in ("+hidclientslm+")";
       		 }
               if(!hidrepairtype.equalsIgnoreCase("")){
       			 sqltest+=" and rtype.row_no in ("+hidrepairtype+")";
       		 }
               if(!hidinvoicestatus.equalsIgnoreCase("") && hidinvoicestatus.equalsIgnoreCase("1")){
       			 sqltest+=" and gate.processstatus=7 ";
       		 }
               if(!hidinvoicestatus.equalsIgnoreCase("") && hidinvoicestatus.equalsIgnoreCase("2")){
       			 sqltest+=" and gate.processstatus<7 ";
       		 }
               if(!hidinvoicestatus.equalsIgnoreCase("") && hidinvoicestatus.equalsIgnoreCase("3")){
       			 sqltest+=" and gate.processstatus=10 ";
       		 }
        	 
               
               String jobcardanalysis="";
               
               jobcardanalysis="select coalesce(h.doc_no,'')doc_no,coalesce(lbr.spramt,0) actualspare,date_format(job.date,'%d-%m-%Y')date,job.voc_no jobno,invm.nettotal totalinv,invm.excesstotal,ac.refname client,"+
           			" concat(gate.regno,'-',gate.pltid) regno,rtype.name repairtype,"+
        			" case when h.description is null and ac.acno=20424 then 'ALICE RENT A CAR LLC' when h.description<>'' or h.description is null then coalesce(h.description,'NON INSURANCE JOBS') end account,coalesce(gate.mainremarks,'') maintenanceremarks from ws_jobcard job left join (select reftype,date,convert(group_concat(voc_no SEPARATOR ' ,'),char(50)) voc_no,refno,sum(nettotal) nettotal,sum(coalesce(nettotal,0))-coalesce(excess,0) clienttotal, coalesce(excess,0) excesstotal from ws_invm  "+
        			" group by refno) invm on (job.doc_no=invm.refno and invm.reftype='JC') left join my_user usr on job.userid=usr.doc_no left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare  group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no "+
        			" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join (select rdocno,sum(total) total from ws_estlabour group by rdocno) estl on estl.rdocno=est.doc_no "+
        			" left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"+
        			" left join my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM')"+
        			" left join my_acbook bac on (gate.insurcldocno=bac.cldocno and bac.dtype='CRM' and insurancecomp=1)"+
        			" left join my_head h on (bac.acno=h.doc_no)"+
        			" left join my_salm slm on ac.sal_id=slm.doc_no"+
        			" left join ws_gartype rtype on gate.repairtype=rtype.row_no  left join my_clcatm cl on cl.doc_no=ac.catid left join my_salesman sm on sm.doc_no=gate.marketingperson and sm.sal_type='WMP' left join my_salesman sm1 on sm1.doc_no=gate.serviceadvisor and sm1.sal_type='WSA' left join (select costcode,sum(nettaxamount) nispareamt from my_srvpurd srv left join my_srvpurm srvm on srv.rdocno=srvm.doc_no  where costtype=9 and srvm.status!=7 group by costcode) srv on srv.costcode=job.doc_no where 1=1 and job.date between '"+sqlfromdate+"' and '"+sqltodate+"' and job.status<>7 "+sqltest+" order by account,h.doc_no ,invm.voc_no,job.date " ;
               
                  ResultSet result=stmtJobcardAnalysis.executeQuery(jobcardanalysis);
               
                  System.out.println("print grid"+jobcardanalysis);
                  String sql="",printname="",company="",address="",tel="",fax="",loc="",compbranch="";
                  sql="select 'Job Card Analysis' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlFromDate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqlToDate+"','%D %M  %Y ')) vouchername1,"
          				+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from ws_jobcard r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
          				+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
          				+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1 "+sqld+" group by r.brhid";
        	 
        	    ResultSet rs=stmtJobcardAnalysis.executeQuery(sql);
        	    while(rs.next()){
        	    	printname=rs.getString("vouchername");
        	    	company=rs.getString("company");
        	    	address=rs.getString("address");
        	    	tel=rs.getString("tel");
        	    	fax=rs.getString("fax");
        	    	loc=rs.getString("location");
        	    	compbranch=rs.getString("branchname");
        	    }
                  
                  
        	   String reportFileName = commonDAO.getBIBPrintPath("JCA");
        	   
               /*String reportFileName = "accountStatementTypeHeaderFooterPrint";*/
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/carfarehead1.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
			   
			  /* String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                */
               param.put("jobcardanalysisqry",jobcardanalysis);
               param.put("printname", printname);
               param.put("compname", company);
               param.put("comptel", tel);
               param.put("compaddress", address);
               param.put("compfax", fax);
               param.put("location", loc);
               param.put("compbranch", compbranch);
               param.put("imgpath", imgpath);
               param.put("fromdate", fromdate);
               param.put("todate", toDate);
               
		           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
		           JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
      
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		param=null;
         		conn.close();
         	}
      	
	 }
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null;
	    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	      resp.reset();
	    resp.resetBuffer();
	    
	    resp.setContentType("application/pdf");
	    resp.setContentLength(bytes.length);
	    ServletOutputStream ouputStream = resp.getOutputStream();
	    ouputStream.write(bytes, 0, bytes.length);
	   
	    ouputStream.flush();
	    ouputStream.close();
	   
	         
	}		
	
	
	
	
	
	
}
