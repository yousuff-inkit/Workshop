package com.dashboard.workshop.partscosting;
import com.common.ClsCommon;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.dashboard.vehicle.drivermovement.ClsDriverMovBean;
import com.dashboard.vehicle.drivermovement.ClsDriverMovDAO;
import com.opensymphony.xwork2.ActionSupport;

import javax.servlet.http.HttpServlet;

@SuppressWarnings("serial")
public class ClsPartsCostingAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsPartsCostingDAO partsCostingDAO= new ClsPartsCostingDAO(); 
	
	ClsPartsCostingBean bean;
	
	private String lbljobno;
	private String lblvehicledetails;
	private String lbldate;
	private String lblregno;
	private String lblcustomer,lblclienttrn,lblcomptrn;
	private String lblbrand;
	private String lblmodel;
	private String lblyom;
	private String lblestimationtotal;
	private String lblpurchasetotal;
	private String lblprofitamount;
	private String lblprofitperc;
	
	////////////////////////////
	public String getLblcomptrn() {
		return lblcomptrn;
	}
	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}
	public String getLblclienttrn() {
		return lblclienttrn;
	}
	public void setLblclienttrn(String lblclienttrn) {
		this.lblclienttrn = lblclienttrn;
	}
	public String getLbljobno() {
		return lbljobno;
	}
	public void setLbljobno(String lbljobno) {
		this.lbljobno = lbljobno;
	}
	public String getLblvehicledetails() {
		return lblvehicledetails;
	}
	public void setLblvehicledetails(String lblvehicledetails) {
		this.lblvehicledetails = lblvehicledetails;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblregno() {
		return lblregno;
	}
	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}
	public String getLblcustomer() {
		return lblcustomer;
	}
	public void setLblcustomer(String lblcustomer) {
		this.lblcustomer = lblcustomer;
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
	public String getLblyom() {
		return lblyom;
	}
	public void setLblyom(String lblyom) {
		this.lblyom = lblyom;
	}
	public String getLblestimationtotal() {
		return lblestimationtotal;
	}
	public void setLblestimationtotal(String lblestimationtotal) {
		this.lblestimationtotal = lblestimationtotal;
	}
	public String getLblpurchasetotal() {
		return lblpurchasetotal;
	}
	public void setLblpurchasetotal(String lblpurchasetotal) {
		this.lblpurchasetotal = lblpurchasetotal;
	}
	public String getLblprofitamount() {
		return lblprofitamount;
	}
	public void setLblprofitamount(String lblprofitamount) {
		this.lblprofitamount = lblprofitamount;
	}
	public String getLblprofitperc() {
		return lblprofitperc;
	}
	public void setLblprofitperc(String lblprofitperc) {
		this.lblprofitperc = lblprofitperc;
	}
	/////////////////////////////////////////////
	
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getLblservicetax() {
		return lblservicetax;
	}
	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}
	public String getLblpan() {
		return lblpan;
	}
	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}
	public String printAction() throws ParseException, SQLException{
		
		
		HttpServletRequest request=ServletActionContext.getRequest();
	//	String ready = request.getParameter("ready");
		String jobno = request.getParameter("jobno");
		
		
		bean=partsCostingDAO.getPrint(jobno);
		
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLblprintname(bean.getLblprintname());
		setLblprintname1(bean.getLblprintname1());
		setLblcomptel(bean.getLblcomptel());
		setLblcompfax(bean.getLblcompfax());
		setLblbranch(bean.getLblbranch());
		setLbllocation(bean.getLbllocation());
		setLblcstno(bean.getLblcstno());
		setLblpan(bean.getLblpan());
		setLblservicetax(bean.getLblservicetax());
		setLblclienttrn(bean.getLblclienttrn());
		setLblcomptrn(bean.getLblcomptrn());
		//////////////////////////
		
		setLblbrand(bean.getLblbrand());
		setLblcustomer(bean.getLblcustomer());
		setLbldate(bean.getLbldate());
		setLblestimationtotal(bean.getLblestimationtotal());
		setLbljobno(bean.getLbljobno());
		setLblmodel(bean.getLblmodel());
		setLblprofitamount(bean.getLblprofitamount());
		setLblprofitperc(bean.getLblprofitperc());
		setLblpurchasetotal(bean.getLblpurchasetotal());
		setLblregno(bean.getLblregno());
		setLblvehicledetails(bean.getLblvehicledetails());
		setLblyom(bean.getLblyom());
		request.setAttribute("printspares", partsCostingDAO.printsparepartsdetails(jobno));
		
		
		
		return "print";
	}
	

}
