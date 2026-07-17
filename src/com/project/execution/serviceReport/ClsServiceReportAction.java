package com.project.execution.serviceReport;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsServiceReportAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsServiceReportDAO serviceReportDAO= new ClsServiceReportDAO();
	ClsServiceReportBean serviceReportBean;

	private int txtservicereportdocno;
	private int txtservicereporttrno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String serviceReportDate;
	private String hidserviceReportDate;
	private String txtrefno;
	private String txtcustomer;
	private int txtcustomerdocno;
	private int txtcustomeracno;
	private String txtcustomerdetails;
	private String cmbcontracttype;
	private String hidcmbcontracttype;
	private String txtcontractno;
	private String txtcontracttrno;
	private String txtcontractdetails;
	private String txtsitename;
	private String txtsiteid;
	private String txtareaname;
	private String txtareaid;
	private int txtscheduleno;
	private double txtcompletionperc;
	private double txttobeinvoicednettotal;
	
	private String url;
	private String textrect;
	private int  chkrect;
	
	

	public int getChkrect() {
		return chkrect;
	}

	public void setChkrect(int chkrect) {
		this.chkrect = chkrect;
	}

	public String getTextrect() {
		return textrect;
	}

	public void setTextrect(String textrect) {
		this.textrect = textrect;
	}

	//Activity Grid
	private int activitygridlength;
	//To Be Invoiced Grid
	private int tobeinvoicedgridlength;
	
	public int getTxtservicereportdocno() {
		return txtservicereportdocno;
	}

	public void setTxtservicereportdocno(int txtservicereportdocno) {
		this.txtservicereportdocno = txtservicereportdocno;
	}

	public int getTxtservicereporttrno() {
		return txtservicereporttrno;
	}

	public void setTxtservicereporttrno(int txtservicereporttrno) {
		this.txtservicereporttrno = txtservicereporttrno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getServiceReportDate() {
		return serviceReportDate;
	}

	public void setServiceReportDate(String serviceReportDate) {
		this.serviceReportDate = serviceReportDate;
	}

	public String getHidserviceReportDate() {
		return hidserviceReportDate;
	}

	public void setHidserviceReportDate(String hidserviceReportDate) {
		this.hidserviceReportDate = hidserviceReportDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public String getTxtcustomer() {
		return txtcustomer;
	}

	public void setTxtcustomer(String txtcustomer) {
		this.txtcustomer = txtcustomer;
	}

	public int getTxtcustomerdocno() {
		return txtcustomerdocno;
	}

	public void setTxtcustomerdocno(int txtcustomerdocno) {
		this.txtcustomerdocno = txtcustomerdocno;
	}

	public int getTxtcustomeracno() {
		return txtcustomeracno;
	}

	public void setTxtcustomeracno(int txtcustomeracno) {
		this.txtcustomeracno = txtcustomeracno;
	}

	public String getTxtcustomerdetails() {
		return txtcustomerdetails;
	}

	public void setTxtcustomerdetails(String txtcustomerdetails) {
		this.txtcustomerdetails = txtcustomerdetails;
	}

	public String getCmbcontracttype() {
		return cmbcontracttype;
	}

	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}

	public String getHidcmbcontracttype() {
		return hidcmbcontracttype;
	}

	public void setHidcmbcontracttype(String hidcmbcontracttype) {
		this.hidcmbcontracttype = hidcmbcontracttype;
	}

	public String getTxtcontractno() {
		return txtcontractno;
	}

	public void setTxtcontractno(String txtcontractno) {
		this.txtcontractno = txtcontractno;
	}

	public String getTxtcontracttrno() {
		return txtcontracttrno;
	}

	public void setTxtcontracttrno(String txtcontracttrno) {
		this.txtcontracttrno = txtcontracttrno;
	}

	public String getTxtcontractdetails() {
		return txtcontractdetails;
	}

	public void setTxtcontractdetails(String txtcontractdetails) {
		this.txtcontractdetails = txtcontractdetails;
	}

	public String getTxtsitename() {
		return txtsitename;
	}

	public void setTxtsitename(String txtsitename) {
		this.txtsitename = txtsitename;
	}

	public String getTxtsiteid() {
		return txtsiteid;
	}

	public void setTxtsiteid(String txtsiteid) {
		this.txtsiteid = txtsiteid;
	}

	public String getTxtareaname() {
		return txtareaname;
	}

	public void setTxtareaname(String txtareaname) {
		this.txtareaname = txtareaname;
	}

	public String getTxtareaid() {
		return txtareaid;
	}

	public void setTxtareaid(String txtareaid) {
		this.txtareaid = txtareaid;
	}

	public int getTxtscheduleno() {
		return txtscheduleno;
	}

	public void setTxtscheduleno(int txtscheduleno) {
		this.txtscheduleno = txtscheduleno;
	}

	public double getTxtcompletionperc() {
		return txtcompletionperc;
	}

	public void setTxtcompletionperc(double txtcompletionperc) {
		this.txtcompletionperc = txtcompletionperc;
	}

	public double getTxttobeinvoicednettotal() {
		return txttobeinvoicednettotal;
	}

	public void setTxttobeinvoicednettotal(double txttobeinvoicednettotal) {
		this.txttobeinvoicednettotal = txttobeinvoicednettotal;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getActivitygridlength() {
		return activitygridlength;
	}

	public void setActivitygridlength(int activitygridlength) {
		this.activitygridlength = activitygridlength;
	}

	public int getTobeinvoicedgridlength() {
		return tobeinvoicedgridlength;
	}

	public void setTobeinvoicedgridlength(int tobeinvoicedgridlength) {
		this.tobeinvoicedgridlength = tobeinvoicedgridlength;
	}

	java.sql.Date serviceReportsDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsServiceReportBean bean = new ClsServiceReportBean();
		serviceReportsDate = commonDAO.changeStringtoSqlDate(getServiceReportDate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Activity Grid Saving*/
			ArrayList<String> activityarray= new ArrayList<String>();
			for(int i=0;i<getActivitygridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				activityarray.add(temp);
			}
			/*Activity Grid Saving Ends*/
			
			/*To Be Invoiced Grid Saving*/
			ArrayList<String> tobeinvoicedarray= new ArrayList<String>();
			for(int j=0;j<getTobeinvoicedgridlength();j++){
				String temps=requestParams.get("tests"+j)[0];
				tobeinvoicedarray.add(temps);
			}
			/*To Be Invoiced Grid Saving Ends*/
		//	System.out.println("inside saveaction");
				int val=serviceReportDAO.insert(serviceReportsDate,getFormdetailcode(),getTxtrefno(),getTxtcustomerdocno(),getTxtcustomeracno(),getCmbcontracttype(),getTxtcontracttrno(),getTxtsiteid(),getTxtareaid(),
						getTxtscheduleno(),getTxtcompletionperc(),getTxttobeinvoicednettotal(),activityarray,tobeinvoicedarray,session,request,mode,getChkrect(),getTextrect());
				if(val>0.0){
					
					setTxtservicereportdocno(val);
					setTxtservicereporttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
					setData();
					
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData();
					setMsg("Not Saved");
					return "fail";
				}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
			/*Updating Activity Grid*/
			ArrayList<String> activityarray= new ArrayList<String>();
			for(int i=0;i<getActivitygridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				activityarray.add(temp);
			}
			/*Updating Activity Grid Ends*/
			
			/*Updating To Be Invoiced Grid*/
			ArrayList<String> tobeinvoicedarray= new ArrayList<String>();
			for(int j=0;j<getTobeinvoicedgridlength();j++){
				String temps=requestParams.get("tests"+j)[0];
				tobeinvoicedarray.add(temps);
			}
			/*Updating To Be Invoiced Grid Ends*/
			
			boolean Status=serviceReportDAO.edit(getTxtservicereportdocno(),getFormdetailcode(),getTxtservicereporttrno(),serviceReportsDate,getTxtrefno(),getTxtcustomerdocno(),getTxtcustomeracno(),getCmbcontracttype(),getTxtcontracttrno(),
					getTxtsiteid(),getTxtareaid(),getTxtscheduleno(),getTxtcompletionperc(),getTxttobeinvoicednettotal(),activityarray,tobeinvoicedarray,session,request,mode,getChkrect(),getTextrect());
			if(Status){

				setTxtservicereportdocno(getTxtservicereportdocno());
				setTxtservicereporttrno(getTxtservicereporttrno());
				setData();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtservicereportdocno(getTxtservicereportdocno());
				setTxtservicereporttrno(getTxtservicereporttrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=serviceReportDAO.delete(getTxtservicereportdocno(),getFormdetailcode(),getTxtservicereporttrno(),session,mode);
			if(Status){
				
				setTxtservicereportdocno(getTxtservicereportdocno());
				setTxtservicereporttrno(getTxtservicereporttrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtservicereportdocno(getTxtservicereportdocno());
				setTxtservicereporttrno(getTxtservicereporttrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			serviceReportBean=serviceReportDAO.getViewDetails(session,getTxtservicereportdocno());
			
			setHidserviceReportDate(serviceReportBean.getServiceReportDate());
			setTxtrefno(serviceReportBean.getTxtrefno());
			setTxtservicereportdocno(serviceReportBean.getTxtservicereportdocno());
			setTxtservicereporttrno(serviceReportBean.getTxtservicereporttrno());
			setTxtcustomer(serviceReportBean.getTxtcustomer());
			setTxtcustomerdocno(serviceReportBean.getTxtcustomerdocno());
			setTxtcustomeracno(serviceReportBean.getTxtcustomeracno());
			setTxtcustomerdetails(serviceReportBean.getTxtcustomerdetails());
			setHidcmbcontracttype(serviceReportBean.getHidcmbcontracttype());
			setTxtcontractno(serviceReportBean.getTxtcontractno());
			setTxtcontracttrno(serviceReportBean.getTxtcontracttrno());
			setTxtcontractdetails(serviceReportBean.getTxtcontractdetails());
			setTxtsitename(serviceReportBean.getTxtsitename());
			setTxtsiteid(serviceReportBean.getTxtsiteid());
			setTxtareaname(serviceReportBean.getTxtareaname());
			setTxtareaid(serviceReportBean.getTxtareaid());
			setTxtscheduleno(serviceReportBean.getTxtscheduleno());
			setTxtcompletionperc(serviceReportBean.getTxtcompletionperc());
			setTxttobeinvoicednettotal(serviceReportBean.getTxttobeinvoicednettotal());
			setFormdetailcode(serviceReportBean.getFormdetailcode());
			setChkrect(serviceReportBean.getChkrect());
			setTextrect(serviceReportBean.getTextrect());
			
			return "success";
		}
		return "fail";
    }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		serviceReportBean=serviceReportDAO.getPrint(request,docno,branch,header);
		
		setUrl(commonDAO.getPrintPath("SRVE"));
	
		return "print";
	}

		public JSONArray searchDetails(HttpSession session, String clientsname, String docNo, String date, String contractstype, String contractsno, String scheduleno){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= serviceReportDAO.srveMainSearch(session, clientsname, docNo, date, contractstype, contractsno, scheduleno);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidserviceReportDate(serviceReportsDate.toString());
			setTxtrefno(getTxtrefno());
			setTxtcustomer(getTxtcustomer());
			setTxtcustomerdocno(getTxtcustomerdocno());
			setTxtcustomeracno(getTxtcustomeracno());
			setTxtcustomerdetails(getTxtcustomerdetails());
			setHidcmbcontracttype(getCmbcontracttype());
			setTxtcontractno(getTxtcontractno());
			setTxtcontracttrno(getTxtcontracttrno());
			setTxtcontractdetails(getTxtcontractdetails());
			setTxtsitename(getTxtsitename());
			setTxtsiteid(getTxtsiteid());
			setTxtareaname(getTxtareaname());
			setTxtareaid(getTxtareaid());
			setTxtscheduleno(getTxtscheduleno());
			setTxtcompletionperc(getTxtcompletionperc());
			setTxttobeinvoicednettotal(getTxttobeinvoicednettotal());
			setFormdetailcode(getFormdetailcode());
			setTextrect(getTextrect());
		}
}

