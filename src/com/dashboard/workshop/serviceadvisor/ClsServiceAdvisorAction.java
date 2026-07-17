package com.dashboard.workshop.serviceadvisor;

import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import com.common.*;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;
public class ClsServiceAdvisorAction extends ActionSupport{

	ClsCommon objcommon=new ClsCommon();
	ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
	private String hidbay;
	private String hidtechnician;
	private String mode;
	private String msg;
	private int partsgridlength;
	private int maintenancegridlength;
	private String gateinpassdocno;
	private String detail;
	private String detailname;
	private String estimatedtime;
	private String estimateddate;
	
	
	public String getEstimateddate() {
		return estimateddate;
	}


	public void setEstimateddate(String estimateddate) {
		this.estimateddate = estimateddate;
	}


	public String getEstimatedtime() {
		return estimatedtime;
	}


	public void setEstimatedtime(String estimatedtime) {
		this.estimatedtime = estimatedtime;
	}

	
	public String getDetail() {
		return detail;
	}


	public void setDetail(String detail) {
		this.detail = detail;
	}


	public String getDetailname() {
		return detailname;
	}


	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}


	public String getGateinpassdocno() {
		return gateinpassdocno;
	}


	public void setGateinpassdocno(String gateinpassdocno) {
		this.gateinpassdocno = gateinpassdocno;
	}


	public String getHidbay() {
		return hidbay;
	}


	public void setHidbay(String hidbay) {
		this.hidbay = hidbay;
	}


	public String getHidtechnician() {
		return hidtechnician;
	}


	public void setHidtechnician(String hidtechnician) {
		this.hidtechnician = hidtechnician;
	}


	public String getMode() {
		return mode;
	}


	public void setMode(String mode) {
		this.mode = mode;
	}


	public String getMsg() {
		return msg;
	}


	public void setMsg(String msg) {
		this.msg = msg;
	}


	public int getPartsgridlength() {
		return partsgridlength;
	}


	public void setPartsgridlength(int partsgridlength) {
		this.partsgridlength = partsgridlength;
	}


	public int getMaintenancegridlength() {
		return maintenancegridlength;
	}


	public void setMaintenancegridlength(int maintenancegridlength) {
		this.maintenancegridlength = maintenancegridlength;
	}


private Map<String, Object> param=null;


	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private String url;
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	 private String regno;
	 private String fleetno;
	 private String fleetname;
	 private String indatetime;
	public String getRegno() {
		return regno;
	}
	public void setRegno(String regno) {
		this.regno = regno;
	}
	public String getFleetno() {
		return fleetno;
	}
	public void setFleetno(String fleetno) {
		this.fleetno = fleetno;
	}
	public String getFleetname() {
		return fleetname;
	}
	public void setFleetname(String fleetname) {
		this.fleetname = fleetname;
	}
	
	public String getIndatetime() {
		return indatetime;
	}


	public void setIndatetime(String indatetime) {
		this.indatetime = indatetime;
	}




	ClsCommon com=new ClsCommon();
	ClsConnection connection=new ClsConnection();


	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		ArrayList<String> partsarray=new ArrayList<>();
		ArrayList<String> maintenancearray=new ArrayList<>();
		java.sql.Date sqlestdate=null;
		if(!getEstimateddate().equalsIgnoreCase("") && getEstimateddate()!=null){
			sqlestdate=objcommon.changeStringtoSqlDate(getEstimateddate());
		}
		if(mode.equalsIgnoreCase("A")){
			for(int i=0;i<getPartsgridlength();i++){
				String temp=requestParams.get("partsgrid"+i)[0];
				partsarray.add(temp);
			}
			for(int i=0;i<getMaintenancegridlength();i++){
				String temp=requestParams.get("maintenancegrid"+i)[0];
				maintenancearray.add(temp);
			}
			int val=servicedao.insert(getHidbay(),getHidtechnician(),getGateinpassdocno(),partsarray,maintenancearray,session,request,mode,getEstimatedtime(),sqlestdate);
			setDetail("Workshop");
			setDetailname("Service Advisor");
			if(val>0){
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}
		}
	return "fail";
	}

	public String printAction() throws SQLException{
		param = new HashMap();
		Connection conn=null;
		conn=connection.getMyConnection();
		ClsServiceAdvisorBean sabean=new ClsServiceAdvisorBean();
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		String dtype=request.getParameter("dtype").toString();   
		String regno=request.getParameter("regno").toString();
		String gateindocno=request.getParameter("gateindoc").toString();
		String fleetno=request.getParameter("fleetno").toString();
		String fleetname=request.getParameter("fleetname").toString();
		String indatetime=request.getParameter("indatetime").toString();
		try{
		/*String headerimg=request.getSession().getServletContext().getRealPath("/icons/holidayfullheadder.png");
		headerimg=headerimg.replace("\\", "\\\\");*/
		sabean=servicedao.getPrint(gateindocno);
		param.put("regno", regno);
		param.put("fleetno", fleetno);
		param.put("fleetname", fleetname);
		param.put("technition", sabean.getTechiname());
		param.put("bay", sabean.getBayname());
		param.put("indatetime", indatetime);
		param.put("estdatetime", sabean.getEsttime());
		
		
		param.put("partsqry", sabean.getPartsqry());
		param.put("jobtobecarryqry", sabean.getJobqry());
	String path="";

		 path="com/dashboard/workshop/serviceadvisor/serviceAdvisorPrint.jrxml";
		 
		 setUrl("serviceAdvisorPrint.jrxml");
	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(path));
	 
	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	          generateReportPDF(response, param, jasperReport, conn);
	    

	} catch (Exception e) {

	    e.printStackTrace();
	    conn.close();
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
