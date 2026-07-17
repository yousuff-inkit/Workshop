package com.dashboard.analysis.revenuereportcarfare;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
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

public class ClsRevenueReportCarfareAction {

	

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
               Statement stmtRevenueReport =conn.createStatement();
               param = new HashMap();
              
        	   String branch = request.getParameter("branch");
        	   String fromdate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String hidclient=request.getParameter("client");
               String hidclientslm=request.getParameter("clientslm");
               String hidrepairtype=request.getParameter("repairtype");
               String sumtype=request.getParameter("type");
               String hidserviceadvisor=request.getParameter("hidserviceadvisor");
        	  
               String sqld="";
               
               if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA") || (branch.equalsIgnoreCase(""))))){
   				sqld+=" and r.brhId="+branch+"";
   			}
   			
               String sqltest="";
               String sqlselect="";
               String sqlgroup="";
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
               if(!hidclientslm.equalsIgnoreCase("")){
       			 sqltest+=" and slm.doc_no in ("+hidclientslm+")";
       		 }
               if(!hidrepairtype.equalsIgnoreCase("")){
       			 sqltest+=" and rtype.row_no in ("+hidrepairtype+")";
       		 }
               if(!hidserviceadvisor.equalsIgnoreCase("")){
         			 sqltest+=" and gate.serviceadvisor in ("+hidserviceadvisor+")";
         		 }
               
               
              /* if(sumtype.equalsIgnoreCase("clt")){*/
       			sqlselect=" ac.cldocno,case when ((ac.refname=''  or ac.refname is null) and gate.cldocno=1) then 'ALICE RENT A CAR LLC' when ac.refname<>'' or ac.refname is null then coalesce(ac.refname,'NON INSURANCE JOBS') end   REFNAME1 ,";
       			sqlgroup=" group by refname1";
               	
       		/* }else if(sumtype.equalsIgnoreCase("sm")){
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
       		 }*/
               
               
               String Revenuereport="";
               
               Revenuereport="select "+sqlselect+"sum(coalesce(invm.nettotal,0)) totalinv,sum(coalesce(invm.nettotal,0)- coalesce(lbr.spramt,0)) labour,sum(coalesce(spr.spramt,0)) spares,sum(coalesce(lub.spramt,0)) lubricants,sum(coalesce(cns.spramt,0))"+
           			" consumables,sum(coalesce(oth.spramt,0)) others from ws_jobcard job inner join (select reftype,date,voc_no,refno,sum(nettotal) nettotal from ws_invm where date between '"+sqlfromdate+"' and '"+sqltodate+"' and status<>7  group by refno,doc_no) invm on (job.doc_no=invm.refno and invm.reftype='JC')"
        			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare group by jobcarddocno) lbr on lbr.jobcarddocno=job.doc_no"
        			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=1 group by jobcarddocno) spr on spr.jobcarddocno=job.doc_no"
        			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=2 group by jobcarddocno) lub on lub.jobcarddocno=job.doc_no"
        			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid=3 group by jobcarddocno) cns on cns.jobcarddocno=job.doc_no"
        			+" left join (select jobcarddocno,sum(coalesce(customeramt,0)) spramt from ws_jccspare jcs left join my_main mm on jcs.psrno=mm.psrno where mm.catid>3 group by jobcarddocno) oth on oth.jobcarddocno=job.doc_no"
        			+" left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))"
        			+" left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM')"
        			+" where 1=1 "+sqltest+sqlgroup;
               
                  ResultSet result=stmtRevenueReport.executeQuery(Revenuereport);
               
                  System.out.println("print grid"+Revenuereport);
                  
                  String sql="",printname="",company="",address="",tel="",fax="",loc="",compbranch="";
                  sql="select 'Revenue Report' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlFromDate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqlToDate+"','%D %M  %Y ')) vouchername1,"
          				+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from ws_jobcard r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
          				+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
          				+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1 "+sqld+" group by r.brhid";
        	 
        	    ResultSet rs=stmtRevenueReport.executeQuery(sql);
        	    while(rs.next()){
        	    	printname=rs.getString("vouchername");
        	    	company=rs.getString("company");
        	    	address=rs.getString("address");
        	    	tel=rs.getString("tel");
        	    	fax=rs.getString("fax");
        	    	loc=rs.getString("location");
        	    	compbranch=rs.getString("branchname");
        	    }
                  
                  
        	   String reportFileName = commonDAO.getBIBPrintPath("RRT");
        	   
               /*String reportFileName = "accountStatementTypeHeaderFooterPrint";*/
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/carfarehead1.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
			   
			  /* String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                */
               param.put("revenuereport",Revenuereport);
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
	
	public void printAction1() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
   
		try {
               
               conn = connDAO.getMyConnection();
               Statement stmtmnthwisereport =conn.createStatement();
               param = new HashMap();
              
        	   String branch = request.getParameter("branch");
        	   String fromdate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   
        	  /* String hidclient=request.getParameter("client");
               String hidclientslm=request.getParameter("clientslm");
               String hidrepairtype=request.getParameter("repairtype");
               String sumtype=request.getParameter("type");
               */
        	  
               String sqld="";
               
               if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA") || (branch.equalsIgnoreCase(""))))){
   				sqld+=" and r.brhId="+branch+"";
   			}
   			
              /* String sqltest="";
              String sqlgroup="";*/
               java.sql.Date sqlfromdate=null,sqltodate=null;
               int mnthwiseDate=0;
               int  year=0;
               String head="";
               String strhead="";
               String head1="",head2="",head3="",head4="",head5="",head6="",head7="",head8="",head9="",head10="",head11="",head12="";
               
               if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
               	sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
       		}
               if(!toDate.equalsIgnoreCase("") && toDate!=null){
               	sqltodate=commonDAO.changeStringtoSqlDate(toDate);
       		}
              
            //   mnthwiseDate=sqltodate;
               String sqladd="";
				for(int i=0;i<=12;i++)
				{
				   
				   //if(i==1){
					String xsql= "select  year(date_sub('"+sqltodate+"', interval "+i+" month)) yrs,month(date_sub('"+sqltodate+"', interval "+i+" month)) mnth , DATE_FORMAT(date_sub('"+sqltodate+"', interval "+i+" month),'%b %Y') head;";
					   ResultSet rs = stmtmnthwisereport.executeQuery(xsql);
					   
		//		System.out.println("qryyy"+xsql);
					  
					   while(rs.next()){
						    
						   mnthwiseDate=rs.getInt("mnth");
						   year=rs.getInt("yrs");
						   head=rs.getString("head"); 
						   
						   if(i==0){
							    strhead=rs.getString("head");
						   }
						   else{
							    strhead+=","+rs.getString("head");
						   }
						   
						  /* if(i==12){
							  // sqladd+="if(month(invm.date)='"+mnthwiseDate+"' and year(invm.date)='"+year+"',(coalesce(invm.nettotal,0)),0) totalinv"+i+",if(month(invm.date)='"+mnthwiseDate+"' and year(invm.date)='"+year+"',(coalesce(invm.excess,0)),0) excess"+i+"";
						   }
						   else{*/
						   int j=i+1;
							   sqladd+=",if(month(invm.date)='"+mnthwiseDate+"' and year(invm.date)='"+year+"',(coalesce(invm.nettotal,0)),0) totalinv"+j+",if(month(invm.date)='"+mnthwiseDate+"' and year(invm.date)='"+year+"',(coalesce(invm.excess,0)),0) excess"+j+"";
//						   }
						   
						     
						    }
				//	   System.out.println("condition check"+strhead);
					  
				   // } 
				   
	              
				}
				   head1=strhead.split(",")[0];
				   head2=strhead.split(",")[1];
				   head3=strhead.split(",")[2];
				   head4=strhead.split(",")[3];
				   head5=strhead.split(",")[4];
				   head6=strhead.split(",")[5];
				   head7=strhead.split(",")[6];
				   head8=strhead.split(",")[7];
				   head9=strhead.split(",")[8];
				   head10=strhead.split(",")[9];
				   head11=strhead.split(",")[10];
				   head12=strhead.split(",")[11];
            
				 System.out.println("array"+strhead);
				 System.out.println("var"+head1);
               String mnthwisereport="";
               
               mnthwisereport="select coalesce(ac.cldocno,0) cldocno,case when ((ac.refname=''  or ac.refname is null) and gate.cldocno=1) then 'ALICE RENT A CAR LLC' when ac.refname<>'' or ac.refname is null then coalesce(ac.refname,'NON INSURANCE JOBS') end   REFNAME1 ,round(sum(totalinv1),0) totalinv1,round(sum(excess1),0) excess1  ,round(sum(totalinv2),0) totalinv2,round(sum(excess2),0) excess2 ,round(sum(totalinv3),0) totalinv3,round(sum(excess3),0) excess3  ,round(sum(totalinv4),0) totalinv4,round(sum(excess4),0) excess4 ,round(sum(totalinv5),0) totalinv5,round(sum(excess5),0) excess5  ,round(sum(totalinv6),0) totalinv6,round(sum(excess6),0) excess6 ,round(sum(totalinv7),0) totalinv7,round(sum(excess7),0) excess7  ,round(sum(totalinv8),0) totalinv8,round(sum(excess8),0) excess8 ,round(sum(totalinv9),0) totalinv9,round(sum(excess9),0) excess9  ,round(sum(totalinv10),0) totalinv10,round(sum(excess10),0) excess10 ,round(sum(totalinv11),0) totalinv11,round(sum(excess11),0) excess11  ,round(sum(totalinv12),0) totalinv12,round(sum(excess12),0) excess12 from (select reftype,date,voc_no,refno,sum(totalinv1) totalinv1,sum(excess1) excess1  ,sum(totalinv2) totalinv2,sum(excess2) excess2 ,sum(totalinv3) totalinv3,sum(excess3) excess3  ,sum(totalinv4) totalinv4,sum(excess4) excess4 ,sum(totalinv5) totalinv5,sum(excess5) excess5  ,sum(totalinv6) totalinv6,sum(excess6) excess6 ,sum(totalinv7) totalinv7,sum(excess7) excess7  ,sum(totalinv8) totalinv8,sum(excess8) excess8 ,sum(totalinv9) totalinv9,sum(excess9) excess9  ,sum(totalinv10) totalinv10,sum(excess10) excess10 ,sum(totalinv11) totalinv11,sum(excess11) excess11  ,sum(totalinv12) totalinv12,sum(excess12) excess12 from "
               		+ "( select  reftype,date,voc_no,refno "+sqladd+" from  ws_invm invm where  invm.date>=date_sub('"+sqltodate+"', interval 13 month) and invm.date<='"+sqltodate+"' and invm.status<>7 )  m  group by reftype,refno ) invm "
               				+ " inner join  ws_jobcard job on (job.doc_no=invm.refno  and invm.reftype='JC')  left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no)  left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))  left join my_acbook ac on (gate.insurcldocno=ac.cldocno and ac.dtype='CRM')  group by refname1 ";
                              
               System.out.println("print griddddd"+mnthwisereport);
               
                  ResultSet result=stmtmnthwisereport.executeQuery(mnthwisereport);
               

				  
                  
                  String sql="",printname="",company="",address="",tel="",fax="",loc="",compbranch="";
                  sql="select 'Month Wise Report' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlFromDate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqlToDate+"','%D %M  %Y ')) vouchername1,"
          				+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from ws_jobcard r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
          				+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
          				+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1 "+sqld+" group by r.brhid";
        	 
        	    ResultSet rst=stmtmnthwisereport.executeQuery(sql);
        	    while(rst.next()){
        	    	printname=rst.getString("vouchername");
        	    	company=rst.getString("company");
        	    	address=rst.getString("address");
        	    	tel=rst.getString("tel");
        	    	fax=rst.getString("fax");
        	    	loc=rst.getString("location");
        	    	compbranch=rst.getString("branchname");
        	    }
                  
                  
        	   String reportFileName = "com/dashboard/analysis/revenuereport/mnthwiserevenuereport.jrxml";
        	   
               /*String reportFileName = "accountStatementTypeHeaderFooterPrint";*/
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/carfarehead1.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
			   
			  /* String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                */
               param.put("mnthwise",mnthwisereport);
               param.put("printname", printname);
               param.put("compname", company);
               param.put("comptel", tel);
               param.put("compaddress", address);
               param.put("compfax", fax);
               param.put("location", loc);
               param.put("compbranch", compbranch);
               param.put("imgpath", imgpath);
               param.put("head1", head1);
               param.put("head2", head2);
               param.put("head3", head3);
               param.put("head4", head4);
               param.put("head5", head5);
               param.put("head6", head6);
               param.put("head7", head7);
               param.put("head8", head8);
               param.put("head9", head9);
               param.put("head10", head10);
               param.put("head11", head11);
               param.put("head12", head12);
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
