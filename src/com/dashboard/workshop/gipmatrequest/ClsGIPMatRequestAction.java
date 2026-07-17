package com.dashboard.workshop.gipmatrequest;

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

public class ClsGIPMatRequestAction {
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
		  int brhid=Integer.parseInt(request.getParameter("brhid")==null?"0":request.getParameter("brhid"));
		  Connection conn = null;
		  try { 
		      conn = connDAO.getMyConnection();
	          Statement stmt = conn.createStatement();
	          HttpServletResponse response = ServletActionContext.getResponse();
	          String path1="";
	          setUrl(commonDAO.getBIBPrintPath("BGMRE"));
	          
		      String imgpath = request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
		      imgpath = imgpath.replace("\\", "\\\\");
		    	param = new HashMap();    			       
		    			        param.put("imgpath",imgpath);
		    			        param.put("docno", doc+"");
		 		    			param.put("printedby", session.getAttribute("USERNAME"));
		 		    								
		    			    			
		    			    			
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/workshop/gipmatrequest/materialrequest.jrxml"));
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
