package com.dashboard.operations;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsOperationsAction extends ActionSupport{
    
	ClsOperationsDAO operationsDAO= new ClsOperationsDAO();
	ClsOperationsBean operationsBean;
	
	//Print
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
	private String lblcashtotal;
	private String lblcardtotal;
	private String lblchequetotal;
	private String lblnetbalance;
	
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
	public String getLblcashtotal() {
		return lblcashtotal;
	}
	public void setLblcashtotal(String lblcashtotal) {
		this.lblcashtotal = lblcashtotal;
	}
	public String getLblcardtotal() {
		return lblcardtotal;
	}
	public void setLblcardtotal(String lblcardtotal) {
		this.lblcardtotal = lblcardtotal;
	}
	public String getLblchequetotal() {
		return lblchequetotal;
	}
	public void setLblchequetotal(String lblchequetotal) {
		this.lblchequetotal = lblchequetotal;
	}
	public String getLblnetbalance() {
		return lblnetbalance;
	}
	public void setLblnetbalance(String lblnetbalance) {
		this.lblnetbalance = lblnetbalance;
	}
	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		String branch = request.getParameter("branch");
		String frmDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
	
		operationsBean=operationsDAO.getPrint(request,branch,frmDate,toDate);
		setLblcompname(operationsBean.getLblcompname());
		setLblcompaddress(operationsBean.getLblcompaddress());
		setLblprintname(operationsBean.getLblprintname());
		setLblprintname1(operationsBean.getLblprintname1());
		setLblcomptel(operationsBean.getLblcomptel());
		setLblcompfax(operationsBean.getLblcompfax());
		setLblbranch(operationsBean.getLblbranch());
		setLbllocation(operationsBean.getLbllocation());
		setLblservicetax(operationsBean.getLblservicetax());
		setLblpan(operationsBean.getLblpan());
		setLblcstno(operationsBean.getLblcstno());
		setLblcashtotal(operationsBean.getLblcashtotal());
		setLblcardtotal(operationsBean.getLblcardtotal());
		setLblchequetotal(operationsBean.getLblchequetotal());
		setLblnetbalance(operationsBean.getLblnetbalance());

		return "print";
	}
}