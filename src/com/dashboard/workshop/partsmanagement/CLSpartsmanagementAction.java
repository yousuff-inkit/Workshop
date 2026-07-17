package com.dashboard.workshop.partsmanagement;

import java.io.IOException;



import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
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
import com.ibm.icu.text.SimpleDateFormat;
import com.workshop.wsjobcard.ClsWSJobCardBean;
import com.workshop.wsjobcard.ClsWSJobCardDAO;


public class CLSpartsmanagementAction {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	private String url;
	
    private String lblcompname,lblcompaddress,lblcomptel,lblprintname,lblcompfax,lblbranch,lbllocation,lblcomptrn,lblchasis,lblcolor,lblyom,lblregno,lblbrand,lblmodel;
	
    private String lblbackjob;
    
    
	
	public String getLblbackjob() {
		return lblbackjob;
	}

	public void setLblbackjob(String lblbackjob) {
		this.lblbackjob = lblbackjob;
	}

	public String getLblregno() {
		return lblregno;
	}

	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}

	public String getLblbrand() {
		return lblbrand;
	}

	public void setLblbrand(String lblbrand) {
		this.lblbrand = lblbrand;
	}

	public String getLblmodel() {
		return lblmodel;
	}

	public void setLblmodel(String lblmodel) {
		this.lblmodel = lblmodel;
	}

	public String getLblchasis() {
		return lblchasis;
	}

	public void setLblchasis(String lblchasis) {
		this.lblchasis = lblchasis;
	}

	public String getLblcolor() {
		return lblcolor;
	}

	public void setLblcolor(String lblcolor) {
		this.lblcolor = lblcolor;
	}

	public String getLblyom() {
		return lblyom;
	}

	public void setLblyom(String lblyom) {
		this.lblyom = lblyom;
	}

	public String getLblcompname() {
		return lblcompname;
	}

	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}

	public String getLblcompaddress() {
		return lblcompaddress;
	}

	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}

	public String getLblcomptel() {
		return lblcomptel;
	}

	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblcompfax() {
		return lblcompfax;
	}

	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}

	public String getLblbranch() {
		return lblbranch;
	}

	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}

	public String getLbllocation() {
		return lbllocation;
	}

	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	CLSpartsManagementDAO partsdao=new CLSpartsManagementDAO();
	
	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String vndacno=request.getParameter("rowno")==null?"0":request.getParameter("rowno");
		String jobdocno=request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");
		System.out.println("docno---------------"+jobdocno);  
		String[] tranarray = jobdocno.split(",");
	    HttpServletResponse response = ServletActionContext.getResponse(); 
			
			 param = new HashMap();
             Connection conn = null;
             
			 try {
				 
				 ClsPartsMgmtBean bean=new ClsPartsMgmtBean();
	             	bean=partsdao.getPartsPrintMaster(vndacno);
	             	setLblbranch(bean.getLblbranch());
	             	setLblcompaddress(bean.getLblcompaddress());
	             	setLblcompfax(bean.getLblcompfax());
	             	setLblcompname(bean.getLblcompname());
	             	setLblcomptel(bean.getLblcomptel());
	             	setLblcomptrn(bean.getLblcomptrn());
	             	setLbllocation(bean.getLbllocation());
	             	//setLblprintname("Spare Parts Request");
	             	setLblregno(bean.getLblregno());
					setLblbrand(bean.getLblbrand());
					setLblmodel(bean.getLblmodel());
					setLblyom(bean.getLblyom());
					setLblcolor(bean.getLblcolor());
					setLblchasis(bean.getLblchasis());
					setLblbackjob(bean.getLblbackjob());
	             	ArrayList<String> partsarray=new ArrayList<>();  
	    			//partsarray=partsdao.getPartsPrint(vndacno);
		          
				String delnotesql1="",delnotesql="";  
	             	 conn = objconn.getMyConnection();	
	             SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");     
	       		 java.util.Date curDate=new java.util.Date();
	       	     java.sql.Date cdate = objcommon.changeStringtoSqlDate(formatter.format(curDate));
	       	     System.out.println(formatter.format(curDate)+"=="+cdate);
	             
	           String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	 		   imgpathheader=imgpathheader.replace("\\", "\\\\");    
	            	param.put("logo",imgpathheader);
	            	param.put("comname",getLblcompname());
	            	param.put("trno",getLblcomptrn());
	            	param.put("date",cdate);
	            	param.put("ndocno",vndacno);
	            	param.put("regno",getLblregno());
	            	param.put("brand",getLblbrand());
	            	param.put("model",getLblmodel());
	            	param.put("yom",getLblyom());
	            	param.put("color",getLblcolor());
	            	param.put("chasis",getLblchasis());
	            	param.put("printby", session.getAttribute("USERNAME"));
	            	param.put("backjob", getLblbackjob());
	            	
	            	for (int i = 0; i < tranarray.length; i++) {
						 //tranno=tranarray[i];
						 param.put("docno"+i,tranarray[i]);                                       
					 }   
			         
	            	//param.put("delnotesql",delnotesql);		     	

	            	//System.out.println("Path ="+ClsCommon.getPrintPath("BDNF"));
		                   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/workshop/partsmanagement/partsmanagement.jrxml"));
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	     	              System.out.println("in");    
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
        
         ouputStream.flush();
         ouputStream.close();
        
              
     }
	

}
