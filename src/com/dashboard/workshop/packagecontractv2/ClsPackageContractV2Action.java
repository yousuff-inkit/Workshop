package com.dashboard.workshop.packagecontractv2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsPackageContractV2Action {
	ClsCommon objcommon=new ClsCommon();
	private Map<String, Object> param = null;
	private String url;
	
	
	
	public String getUrl() {
		return url;
	}



	public void setUrl(String url) {
		this.url = url;
	}



	public Map<String, Object> getParam() {
		return param;
	}


	
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}



	public String printAction() throws ParseException, SQLException, Exception {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpSession session = request.getSession();
			HttpServletResponse response = ServletActionContext.getResponse();
			String doc = request.getParameter("docno");
			int brhid=Integer.parseInt(request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString());
			int header=Integer.parseInt(request.getParameter("header")==null?"0":request.getParameter("header").toString());
			if (objcommon.getBIBPrintPath("BWPC").contains(".jrxml") == true) {

				ClsConnection conobj = new ClsConnection();
				System.out.println("inside");
				param = new HashMap();
				Connection conn = null;
				conn = conobj.getMyConnection();
	    	     Statement stmt = conn.createStatement();
	    	     ClsAmountToWords objamount=new ClsAmountToWords();  
				String reportFileName = "PackageContract";
			    int proformaconfig=0;  
				try {
					String imgpath3 ="",path1="",imgpal="",amountinwords="";
					String imgpath = request.getSession().getServletContext()
							.getRealPath("/icons/epic.jpg");
					imgpath = imgpath.replace("\\", "\\\\");
					String imgpath1 = request.getSession().getServletContext()
							.getRealPath("/icons/epic.jpg");
					imgpath1 = imgpath.replace("\\", "\\\\");
					String imgpath2 =request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
					imgpath2 = imgpath2.replace("\\", "\\\\");
                    if(header==1){
					imgpath3 =request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
					imgpath3 = imgpath3.replace("\\", "\\\\");
                    }
                    String strsql2="select imgpath from my_brch where doc_no='"+brhid+"'";          
		    	    ResultSet rs2=stmt.executeQuery(strsql2);          
		    	    while(rs2.next()){         
		    	    	path1=rs2.getString("imgpath");
		    	    }
		    	    
		    	    //Getting Package Amount
		    	    String strgetpackamt="select round(coalesce(pack.amount,0),2) amt from ws_packagecontract wp left join ws_packagem pack on wp.packagedocno=pack.doc_no where wp.doc_no="+doc;
		    	    String packamt="0.0";
		    	    ResultSet rspackamt=stmt.executeQuery(strgetpackamt);
		    	    while(rspackamt.next()){
		    	    	packamt=rspackamt.getString("amt");
		    	    }
		    	    String imgpathroyal=request.getSession().getServletContext().getRealPath("/icons/royallogo.png");  
				     imgpathroyal=imgpathroyal.replace("\\", "\\\\");
				     String imgpathroyaldesign=request.getSession().getServletContext().getRealPath("/icons/designpattern.png");  
				     imgpathroyaldesign=imgpathroyaldesign.replace("\\", "\\\\");
				     String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/royalfooter.png");
				     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
				     String watermarkroyal=request.getSession().getServletContext().getRealPath("/icons/watermarkroyal.png");
				     watermarkroyal=watermarkroyal.replace("\\", "\\\\");
		    	   
		    	    param.put("imgpal", imgpath);   
                    param.put("docno", doc);   
					param.put("complogo", imgpath);
					param.put("compfooter", imgpath1);
					System.out.println("Pack Amount:"+packamt);
					System.out.println("Pack Amount Words:"+objamount.convertAmountToWords(packamt));
                    param.put("amountwords",objamount.convertAmountToWords(packamt));
					param.put("puser", session.getAttribute("USERNAME"));
					
					String printrealpath=objcommon.getBIBPrintPath("BWPC");
					System.out.println("printrealpath==="+printrealpath);  
					JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(printrealpath));
					JasperReport jasperReport = JasperCompileManager.compileReport(design);
					generateReportPDF(response, param, jasperReport, conn);
					
					
				} catch (Exception e) {
					e.printStackTrace();
					conn.close();
				} finally {
					conn.close();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	private void generateReportPDF(HttpServletResponse resp, Map parameters,
			JasperReport jasperReport, Connection conn) throws JRException,
			NamingException, SQLException, IOException {
		byte[] bytes = null;
		bytes = JasperRunManager.runReportToPdf(jasperReport, parameters, conn);
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
