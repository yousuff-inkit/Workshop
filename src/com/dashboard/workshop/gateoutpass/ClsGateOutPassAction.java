package com.dashboard.workshop.gateoutpass;

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

public class ClsGateOutPassAction {
	ClsGateOutPassBean bean=new ClsGateOutPassBean();
	ClsGateOutPassDAO releasedao=new ClsGateOutPassDAO();
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	private String lblcompanyname;
	
	
	private String lblcompname,lblcompaddress,lblprintname,lblcomptel,lblcompfax,lblprintname1,lblbranch,lbllocation,lblcomptrn;
	
	private String lbldate,lblmodel,lblrvehicleno,lbljobno,lbltype,lblcustomer,lblperson,lblchasisno,lblengineno,lblreleasedby,lbltodat;
	
	private String url;
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getLblcomptrn() {
		return lblcomptrn;
	}




	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}




	public String getLbldate() {
		return lbldate;
	}




	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}




	public String getLblmodel() {
		return lblmodel;
	}




	public void setLblmodel(String lblmodel) {
		this.lblmodel = lblmodel;
	}




	public String getLblrvehicleno() {
		return lblrvehicleno;
	}




	public void setLblrvehicleno(String lblrvehicleno) {
		this.lblrvehicleno = lblrvehicleno;
	}




	public String getLbljobno() {
		return lbljobno;
	}




	public void setLbljobno(String lbljobno) {
		this.lbljobno = lbljobno;
	}




	public String getLbltype() {
		return lbltype;
	}




	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}




	public String getLblcustomer() {
		return lblcustomer;
	}




	public void setLblcustomer(String lblcustomer) {
		this.lblcustomer = lblcustomer;
	}




	public String getLblperson() {
		return lblperson;
	}




	public void setLblperson(String lblperson) {
		this.lblperson = lblperson;
	}




	public String getLblchasisno() {
		return lblchasisno;
	}




	public void setLblchasisno(String lblchasisno) {
		this.lblchasisno = lblchasisno;
	}




	public String getLblengineno() {
		return lblengineno;
	}




	public void setLblengineno(String lblengineno) {
		this.lblengineno = lblengineno;
	}




	public String getLblreleasedby() {
		return lblreleasedby;
	}




	public void setLblreleasedby(String lblreleasedby) {
		this.lblreleasedby = lblreleasedby;
	}




	public String getLbltodat() {
		return lbltodat;
	}




	public void setLbltodat(String lbltodat) {
		this.lbltodat = lbltodat;
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




	public String getLblprintname() {
		return lblprintname;
	}




	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}




	public String getLblcomptel() {
		return lblcomptel;
	}




	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}




	public String getLblcompfax() {
		return lblcompfax;
	}




	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}




	public String getLblprintname1() {
		return lblprintname1;
	}




	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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




	public String getLblcompanyname() {
		return lblcompanyname;
	}




	public void setLblcompanyname(String lblcompanyname) {
		this.lblcompanyname = lblcompanyname;
	}
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private Map<String, Object> param = null;
	



	public String printAction() throws ParseException, SQLException,Exception{
		
		System.out.println("inside action");
			 
			 HttpServletRequest request=ServletActionContext.getRequest();
			 HttpSession session=request.getSession();
			 String Docno=request.getParameter("Docno")==null?"0":request.getParameter("Docno");
			 int doc=Integer.parseInt(request.getParameter("Docno"));
			 String dtype=request.getParameter("dtype");
			 bean=releasedao.getPrint(doc);
			 setLblcompanyname("TEMPORARY RELEASE ORDER/VEHICLE");
			 setLblcompanyname("GATE OUT PASS");
			 setUrl(commonDAO.getBIBPrintPath(dtype));
			 setLblbranch(bean.getLblbranch());
			   setLblcompname(bean.getLblcompname());
			  setLblcomptrn(bean.getLblcomptrn());
			  setLblcompaddress(bean.getLblcompaddress());
			   setLblcomptel(bean.getLblcomptel());
			   setLblcompfax(bean.getLblcompfax());
			   setLbllocation(bean.getLbllocation());
			  
			   setLblrvehicleno(bean.getLblrvehicleno());
			   setLbldate(bean.getLbldate());
	    	  setLbljobno(bean.getLbljobno());
	    	  setLbltype(bean.getLbltype());
	    	  setLblcustomer( bean.getLblcustomer());
	    	   setLblperson(bean.getLblperson());
	    	   setLblchasisno(bean.getLblchasisno());
	    	   setLblengineno(bean.getLblengineno());
	    	   setLbltodat(bean.getLbltodat());
	
	    	   System.out.println("out==="+commonDAO.getBIBPrintPath(dtype).contains(".jrxml"));
	
				
      if(commonDAO.getBIBPrintPath(dtype).contains(".jrxml")==true)
		   {
    	  System.out.println("inbsbvxsbxhds"+doc);
		     HttpServletResponse response = ServletActionContext.getResponse();
             Connection conn = null;
		    			 try {
		    				 conn = connDAO.getMyConnection();
		    				 Statement stmt = conn.createStatement();
		    				 
		    				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
		    			     imgpath=imgpath.replace("\\", "\\\\");
		    			     
		    			     String carimg=request.getSession().getServletContext().getRealPath("/icons/carinoutimg.png");
		    			     carimg=carimg.replace("\\", "\\\\");
		    			     
		    			     String checkbox=request.getSession().getServletContext().getRealPath("/icons/checkedbox.png");
		    			     checkbox=checkbox.replace("\\", "\\\\");
		    			     
		    			     String uncheckbox=request.getSession().getServletContext().getRealPath("/icons/uncheckedbox.png");   
		    			     uncheckbox=uncheckbox.replace("\\", "\\\\");   
		    			     
		    				    param = new HashMap();
		    			        param.put("docno", doc); 
		    			        param.put("compname",bean.getLblcompname());
		    			        param.put("headerimg", imgpath);
		    			        param.put("carimg", carimg);
		    			        param.put("puser", session.getAttribute("USERNAME"));
		    			        param.put("compaddress",bean.getLblcompaddress());
							    param.put("comptel",bean.getLblcomptel());
							    param.put("branch", bean.getLblbranch());
		    			        
		    			        param.put("isdoc1", uncheckbox); 
			    				 param.put("isdoc2", uncheckbox); 
			    				 param.put("isdoc3", uncheckbox); 
			    				 param.put("isdoc4", uncheckbox); 
			    				 param.put("isdoc5", uncheckbox); 
			    				 param.put("isdoc6", uncheckbox); 
			    				 param.put("isdoc7", uncheckbox); 
			    				 param.put("isdoc8", uncheckbox); 
			    				 param.put("isdoc9", uncheckbox);
			    				 param.put("isdoc10", uncheckbox); 
			    				 param.put("isdoc11", uncheckbox); 
			    				 param.put("isdoc12", uncheckbox); 
			    				 param.put("isdoc13", uncheckbox); 
			    				 param.put("isdoc14", uncheckbox); 
		    			            
			    				 String invdoc="";
			    				 String invsql="select m.name invstatus,m.sr_no from gl_inspection m left join ws_gipinventory i on (m.sr_no=i.invdocno and i.gipdocno="+doc+") where m.status=3 and i.value=1";
			    				 ResultSet rs3 = stmt.executeQuery(invsql);   
			    				 while(rs3.next()){   
			    					 invdoc=rs3.getString("sr_no").trim(); 
				    				 
				    				 if(invdoc.equalsIgnoreCase("1")){  
				    					 param.put("isdoc1", checkbox); 
				    				 }
				    				 if(invdoc.equalsIgnoreCase("2")){  
				    					 param.put("isdoc2", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("3")){  
				    					 param.put("isdoc3", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("4")){  
				    					 param.put("isdoc4", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("5")){  
				    					 param.put("isdoc5", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("6")){  
				    					 param.put("isdoc6", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("7")){  
				    					 param.put("isdoc7", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("8")){  
				    					 param.put("isdoc8", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("9")){  
				    					 param.put("isdoc9", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("10")){  
				    					 param.put("isdoc10", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("11")){  
				    					 param.put("isdoc11", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("12")){  
				    					 param.put("isdoc12", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("13")){  
				    					 param.put("isdoc13", checkbox); 
				    				 }if(invdoc.equalsIgnoreCase("14")){  
				    					 param.put("isdoc14", checkbox); 
				    				 }
			    				 }
			    				 
		    			
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getBIBPrintPath(dtype)));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);
		        generateReportPDF(response, param, jasperReport, conn);
		        } catch (Exception e) {
		          e.printStackTrace();
		        }
		    	  finally{
		    	  conn.close();
		    	}

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
