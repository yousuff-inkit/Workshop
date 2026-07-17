package com.dashboard.workshop.gateoutpassdetails;

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

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ClsGOPDetailsAction {
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private Map<String, Object> param = null;
	
	private String url;
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  int doc=Integer.parseInt(request.getParameter("docno")==null?"0":request.getParameter("docno"));
		 String brhid=request.getParameter("branch")==null?"0":request.getParameter("branch");
		 String printmode=request.getParameter("printmode")==null?"0":request.getParameter("printmode").toString();
		 //String  formcode= request.getParameter("formdetailcode");
		//System.out.println("doc");
		 //bean=gatedao.getPrint(doc,request,formcode);
		 String path1="";
		 System.out.println("hiiiiiiiii=branch=="+brhid);
		 Connection conn = null;
		 conn = connDAO.getMyConnection();
	     Statement stmt = conn.createStatement();
	     if(printmode.equalsIgnoreCase("1")){
	    	 setUrl(commonDAO.getBIBPrintPath1("BGIPM"));
	     }
	     else{
	    	 setUrl(commonDAO.getBIBPrintPath("BGIPM"));
	     }
	     
	     
		
		String strsql2="select imgpath from my_brch where doc_no='"+brhid+"'";          
	     ResultSet rs2=stmt.executeQuery(strsql2);          
	     while(rs2.next()){         
	    	 path1=rs2.getString("imgpath");         
	     }  
      
		     HttpServletResponse response = ServletActionContext.getResponse();
            
		    			 try {
		    				 
		    				 String imgpath=request.getSession().getServletContext().getRealPath(path1);
		    			     imgpath=imgpath.replace("\\", "\\\\");
		    				 String imgpathlogo=request.getSession().getServletContext().getRealPath("/icons/gateway43.png");
		    			     imgpathlogo=imgpathlogo.replace("\\", "\\\\");
		    			     String carimg=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		    			     carimg=carimg.replace("\\", "\\\\");
		    				    param = new HashMap();
		    			                conn = connDAO.getMyConnection();
		    			        param.put("brhid", brhid); 		    			       
		    			        param.put("imgheader", imgpath);
		    			        param.put("imgfooter", carimg);
		    			        param.put("imgpath",imgpathlogo);
		    			        String sqltest=""; 
		    			         sqltest+=" and gip.brhid="+brhid;
		    			         String date="",time="",estno="",docno="",plateno="",model="",color="",mileage="",chassisno="";
		    			        String strsql="select coalesce(gip.other,'') other,coalesce(gip.backjob,0) backjob,trim(both ' , ' from concat(coalesce(est.claimno,''),' , ',group_concat(distinct coalesce(estadd.claimno,''),if(coalesce(estadd.claimno,'')<>'',' , ','')))) estclaimno,coalesce(gip.chkvirtual,0) chkvirtual,coalesce(insur.refname,'') insurcompname,coalesce(ac.address,'') gipclientaddress,convert(coalesce(ac.catid,''),char(25)) gipclientcat,coalesce(ac.trnnumber,'') gipclienttrn,coalesce(gip.mobile,'') gipclientmobile,coalesce(gip.email,'') gipclientemail,coalesce(lpo,'') pono,coalesce(excess,0) chkexcess,round(coalesce(excessamt,0.0),2) excessamt,coalesce(est.voc_no,0) estvocno,coalesce(job.doc_no,0) jobdocno,coalesce(job.voc_no,0) jobvocno,concat(gip.regno,' ',gip.pltid,' ',brd.brand_name,' ',model.vtype) fleetdetails,gip.brhid,case when gip.processstatus=1 then 'Gate In Pass' when gip.processstatus=2 then 'Estimation' when gip.processstatus=3 then"+
		    			    			" 'Confirm Est.' when processstatus=4 then 'Quotation Approval' when gip.processstatus=5 then 'Job Card' when gip.processstatus=6"+
		    			    			" then 'Job Card Complete' when gip.processstatus=7 then 'Invoiced' when gip.processstatus=8 then 'Gate Out Pass' when gip.processstatus=10"+
		    			    			" then 'Vehicle Release' else '' end gipprocess,gip.brhid,gip.cldocno,gip.insurcldocno,gip.voc_no vocno,coalesce(est.doc_no,0) estdocno,gip.processstatus,coalesce(gip.email,ac.mail1) email,rt.name repairtype,br.branchname,case when gip.cldocno=0 then 'New' else 'Existing' end customertype,gip.doc_no docno,gip.voc_no,gip.cldocno,coalesce(case when ac.refname='' then gip.clientname else ac.refname end,gip.clientname) refname,gip.mobile,gip.email,gip.estdeldate date,gip.estdeltime time from"+
		    			    			" ws_gateinpass gip left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM' left join my_acbook insur on gip.insurcldocno=insur.cldocno and insur.dtype='CRM' left join my_brch br on gip.brhid=br.doc_no left join ws_gartype rt on gip.repairtype=rt.row_no left join ws_estm est on gip.doc_no=est.gipno left join ws_jobcard job on (job.refno=est.doc_no and job.reftype='EST') left join gl_vehbrand brd on brd.doc_no=gip.brdid left join"+
		    			    			" gl_vehmodel model on model.doc_no=gip.modid left join ws_estmadd estadd on est.doc_no=estadd.doc_no "+
		    			    			" where gip.status=3 and gip.processstatus<>8 "+sqltest+" group by gip.doc_no order by gip.doc_no desc";
		    			    			//System.out.println(strsql);   			      
		    			    			ResultSet rsgetclient=stmt.executeQuery(strsql);
		    			    			while(rsgetclient.next()){
		    			    				chassisno=rsgetclient.getString("other");
		    			    				date= rsgetclient.getString("date");
		    			    				time=rsgetclient.getString("time");
		    			    				estno=rsgetclient.getString("date");
		    			    				docno=rsgetclient.getString("docno");
		    			    				plateno=rsgetclient.getString("date");
		    			    				model=rsgetclient.getString("date");
		    			    				color=rsgetclient.getString("date");
		    			    				mileage=rsgetclient.getString("date");
		    			    			}
		    			    			 param.put("date", date); 	
		    			    			    param.put("doc_no", doc);
		 		    			        param.put("time", time);
		 		    			        param.put("imgfooter", carimg);
		 		    			        param.put("imgpath",imgpathlogo);
		    			    			
		    			    			
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/workshop/gipmgmt/"+getUrl()));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);
		        generateReportPDF(response, param, jasperReport, conn);
		        } catch (Exception e) {
		          e.printStackTrace();
		        }
		    	  finally{
		    	  conn.close();
		    	}

		    	

		    		return "print";
		    		
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
		    					ouputStream.close();
		    					ouputStream.flush();
		    	     
		    	}

				
}
