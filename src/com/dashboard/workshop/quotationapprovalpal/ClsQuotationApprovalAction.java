package com.dashboard.workshop.quotationapprovalpal;

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


public class ClsQuotationApprovalAction {
	
	ClsCommon commonDAO=new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsQuotationApprovalDAO qadao=new ClsQuotationApprovalDAO();
	ClsQuotationApprovalBean qabean;
	
	private String lblEstNo;
	private String lblGipNo;
	private String lblDate;
	private String lblRegNo;
	private String lblBrand;
	private String lblRemarks;
	private String lblUserName;
	private String lblModel;
	private String lblYom;
	private String lblClaim;
	private String lblLpo;
	private String lblLpoAmt;
	private String lblExcessAmt;
	private String lblSparePartsTotal;
	private String lblDiscount;
	private String lblLabourTotal;
	private String lblEstimation;
	private String lblOthers;
	private String lblClient;
	private String lblvattotal;
	private String lblcompname;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	
	private String url;
	private String lblvat;
	private String lblcomptrn;
	private String lblkm;
	private String sparetotal;
	private String servicetotal;
	private String vat;
	private String nettotal;
	private String lblserviceadvisor;
	
	
	public String getLblserviceadvisor() {
		return lblserviceadvisor;
	}

	public void setLblserviceadvisor(String lblserviceadvisor) {
		this.lblserviceadvisor = lblserviceadvisor;
	}

	public String getSparetotal() {
		return sparetotal;
	}

	public void setSparetotal(String sparetotal) {
		this.sparetotal = sparetotal;
	}

	public String getServicetotal() {
		return servicetotal;
	}

	public void setServicetotal(String servicetotal) {
		this.servicetotal = servicetotal;
	}

	public String getVat() {
		return vat;
	}

	public void setVat(String vat) {
		this.vat = vat;
	}

	public String getNettotal() {
		return nettotal;
	}

	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private Map<String, Object> param = null;
	
	
	public String getLblkm() {
		return lblkm;
	}
	public void setLblkm(String lblkm) {
		this.lblkm = lblkm;
	}
	public String getLblcomptrn() {
		return lblcomptrn;
	}
	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
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
	public String getLblvattotal() {
		return lblvattotal;
	}
	public void setLblvattotal(String lblvattotal) {
		this.lblvattotal = lblvattotal;
	}
	public String getLblClient() {
		return lblClient;
	}
	public void setLblClient(String lblClient) {
		this.lblClient = lblClient;
	}
	
	public String getLblOthers() {
		return lblOthers;
	}
	public void setLblOthers(String lblOthers) {
		this.lblOthers = lblOthers;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getLblEstNo() {
		return lblEstNo;
	}
	public void setLblEstNo(String lblEstNo) {
		this.lblEstNo = lblEstNo;
	}
	public String getLblGipNo() {
		return lblGipNo;
	}
	public void setLblGipNo(String lblGipNo) {
		this.lblGipNo = lblGipNo;
	}
	public String getLblDate() {
		return lblDate;
	}
	public void setLblDate(String lblDate) {
		this.lblDate = lblDate;
	}
	public String getLblRegNo() {
		return lblRegNo;
	}
	public void setLblRegNo(String lblRegNo) {
		this.lblRegNo = lblRegNo;
	}
	public String getLblBrand() {
		return lblBrand;
	}
	public void setLblBrand(String lblBrand) {
		this.lblBrand = lblBrand;
	}
	public String getLblRemarks() {
		return lblRemarks;
	}
	public void setLblRemarks(String lblRemarks) {
		this.lblRemarks = lblRemarks;
	}
	public String getLblUserName() {
		return lblUserName;
	}
	public void setLblUserName(String lblUserName) {
		this.lblUserName = lblUserName;
	}
	public String getLblModel() {
		return lblModel;
	}
	public void setLblModel(String lblModel) {
		this.lblModel = lblModel;
	}
	public String getLblYom() {
		return lblYom;
	}
	public void setLblYom(String lblYom) {
		this.lblYom = lblYom;
	}
	public String getLblClaim() {
		return lblClaim;
	}
	public void setLblClaim(String lblClaim) {
		this.lblClaim = lblClaim;
	}
	public String getLblLpo() {
		return lblLpo;
	}
	public void setLblLpo(String lblLpo) {
		this.lblLpo = lblLpo;
	}
	public String getLblLpoAmt() {
		return lblLpoAmt;
	}
	public void setLblLpoAmt(String lblLpoAmt) {
		this.lblLpoAmt = lblLpoAmt;
	}
	public String getLblExcessAmt() {
		return lblExcessAmt;
	}
	public void setLblExcessAmt(String lblExcessAmt) {
		this.lblExcessAmt = lblExcessAmt;
	}
	public String getLblSparePartsTotal() {
		return lblSparePartsTotal;
	}
	public void setLblSparePartsTotal(String lblSparePartsTotal) {
		this.lblSparePartsTotal = lblSparePartsTotal;
	}
	public String getLblDiscount() {
		return lblDiscount;
	}
	public void setLblDiscount(String lblDiscount) {
		this.lblDiscount = lblDiscount;
	}
	public String getLblLabourTotal() {
		return lblLabourTotal;
	}
	public void setLblLabourTotal(String lblLabourTotal) {
		this.lblLabourTotal = lblLabourTotal;
	}
	public String getLblEstimation() {
		return lblEstimation;
	}
	public void setLblEstimation(String lblEstimation) {
		this.lblEstimation = lblEstimation;
	}
	
	public String printAction() throws ParseException, SQLException,Exception{
		
		
			 
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  
		 String voc=request.getParameter("estDocno");
		 String docno=request.getParameter("docno");
		 String gatedocno=request.getParameter("gatedocno");
		 String addition=request.getParameter("addition")==null?"0":request.getParameter("addition");
		 System.out.println("addd:"+addition);
		  qabean=qadao.getPrint(voc);
		  setLblkm(qabean.getLblkm());
		  setUrl(commonDAO.getBIBPrintPath("BWQA"));
		  setLblBrand(qabean.getLblBrand());
		  setLblClaim(qabean.getLblClaim());
		  setLblDate(qabean.getLblDate());
		  setLblDiscount(qabean.getLblDiscount());
		  setLblEstimation(qabean.getLblEstimation());
		  setLblEstNo(qabean.getLblEstNo());
		  setLblExcessAmt(qabean.getLblExcessAmt());
		  setLblGipNo(qabean.getLblGipNo());
		  setLblLabourTotal(qabean.getLblLabourTotal());
		  setLblLpo(qabean.getLblLpo());
		  setLblLpoAmt(qabean.getLblLpoAmt());
		  setLblModel(qabean.getLblModel());
		  setLblRegNo(qabean.getLblRegNo());
		  setLblRemarks(qabean.getLblRemarks());
		  setLblSparePartsTotal(qabean.getLblSparePartsTotal());
		  setLblUserName(qabean.getLblUserName());
		  setLblYom(qabean.getLblYom());
		  setLblOthers(qabean.getLblOthers());
		  setLblClient(qabean.getLblClient());
		  setLblvattotal(qabean.getLblvattotal());
		  setLblbranch(qabean.getLblbranch());
		  setLblcompname(qabean.getLblcompname());
		  setLblcompfax(qabean.getLblcompfax());
		  setLblcomptel(qabean.getLblcomptel());
		  setLblvat(qabean.getLblvat());
		  setLblprintname("QUOTATION");
		  setLblcomptrn(qabean.getLblcomptrn());
		  setLblserviceadvisor(qabean.getLblserviceadvisor());
		
		 if(commonDAO.getBIBPrintPath("BWQA").contains(".jrxml")==true)
		   {
		     HttpServletResponse response = ServletActionContext.getResponse();
             Connection conn = null;
		    		
             try{
            	 conn = connDAO.getMyConnection();
  	    	     Statement stmt = conn.createStatement();
  	    	   
            	 String sqlqry="select round((select b.approved from (select a.approved,@i:=@i+1 series from (select approved,@i:=0 from ws_estspareamt where addition='"+addition+"'and gatedocno='"+gatedocno+"')a)b where b.series=1),2) sparetotal,round((select b.approved from (select a.approved,@i:=@i+1 series from (select approved,@i:=0 from ws_estspareamt where addition='"+addition+"'and gatedocno='"+gatedocno+"')a)b where b.series=2),2) servicetotal,round((select b.approved from ( select a.approved,@i:=@i+1 series from ( "
                               +" select approved,@i:=0 from ws_estspareamt where addition='"+addition+"' and gatedocno='"+gatedocno+"')a)b where b.series=4),2) vattotal,round((select b.approved from ( "
                                +" select a.approved,@i:=@i+1 series from ( select approved,@i:=0 from ws_estspareamt where addition='"+addition+"'and gatedocno='"+gatedocno+"')a)b where b.series=5),2) nettotal ";
                               
            	 ResultSet rs=stmt.executeQuery(sqlqry);
            	 while(rs.next()){
            		 qabean.setSparetotal(rs.getString("sparetotal"));
            		 qabean.setServicetotal(rs.getString("servicetotal"));
            		 qabean.setVat(rs.getString("vattotal"));
            		 qabean.setNettotal(rs.getString("nettotal"));
            	 }
            	 
		    				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
		    			     imgpath=imgpath.replace("\\", "\\\\");
		    			     String carimg=request.getSession().getServletContext().getRealPath("/icons/carinoutimg.png");
		    			     carimg=carimg.replace("\\", "\\\\");
		    				    param = new HashMap();
		    			        
		    				    String estimation="QUOTATION";
		    				    String Additional="ADDITIONAL ESTIMATION";
		    				   
		    				    
		    			        param.put("vocno", voc); 
		    			       param.put("imgheader", imgpath);
		    			       param.put("spareparts", qabean.getSparetotal());
		    			       param.put("service", qabean.getServicetotal());
		    			       param.put("vattotal", qabean.getVat());
		    			       param.put("estimation", qabean.getNettotal());
		    			      // param.put("lblvattotal", qabean.getLblvattotal());
		    			       param.put("docno", docno);
		    			       param.put("gatedocno", gatedocno);
		    			       param.put("addition", addition);
		    			       
		    			       if(addition.equalsIgnoreCase("1"))
		    			       {
		    			       param.put("printname", Additional);
		    			       }
		    			       else 
		    			       {
		    			       param.put("printname", estimation);
		    			       }
		    			       
		   		       			      
		    			      
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getBIBPrintPath("BWQA")));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);
		        generateReportPDF(response, param, jasperReport, conn);
                }catch (Exception e){
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


	public String getLblvat() {
		return lblvat;
	}
	public void setLblvat(String lblvat) {
		this.lblvat = lblvat;
	}
	
}


