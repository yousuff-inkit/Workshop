package com.dashboard.serviceandmaintenance;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsServiceAndMaintenanceAction extends ActionSupport{

	ClsServiceAndMaintenanceDAO serviceAndMaintenanceDAO= new ClsServiceAndMaintenanceDAO();
	ClsServiceAndMaintenanceBean serviceAndMaintenanceBean;
	
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
	private String lblfleetno;
	private String lblfleetname;
	private String lblfleetregno;
	private String lblfleetauthority;
	private String lblfleetyom;
	private String lblfleetcolor;
	private String lblfleetengineno;
	private String lblfleetchassisno;
	
	//for hide
	private int firstarray;
	private int secarray;

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

	public String getLblfleetno() {
		return lblfleetno;
	}

	public void setLblfleetno(String lblfleetno) {
		this.lblfleetno = lblfleetno;
	}

	public String getLblfleetname() {
		return lblfleetname;
	}

	public void setLblfleetname(String lblfleetname) {
		this.lblfleetname = lblfleetname;
	}

	public String getLblfleetregno() {
		return lblfleetregno;
	}

	public void setLblfleetregno(String lblfleetregno) {
		this.lblfleetregno = lblfleetregno;
	}

	public String getLblfleetauthority() {
		return lblfleetauthority;
	}

	public void setLblfleetauthority(String lblfleetauthority) {
		this.lblfleetauthority = lblfleetauthority;
	}

	public String getLblfleetyom() {
		return lblfleetyom;
	}

	public void setLblfleetyom(String lblfleetyom) {
		this.lblfleetyom = lblfleetyom;
	}

	public String getLblfleetcolor() {
		return lblfleetcolor;
	}

	public void setLblfleetcolor(String lblfleetcolor) {
		this.lblfleetcolor = lblfleetcolor;
	}

	public String getLblfleetengineno() {
		return lblfleetengineno;
	}

	public void setLblfleetengineno(String lblfleetengineno) {
		this.lblfleetengineno = lblfleetengineno;
	}

	public String getLblfleetchassisno() {
		return lblfleetchassisno;
	}

	public void setLblfleetchassisno(String lblfleetchassisno) {
		this.lblfleetchassisno = lblfleetchassisno;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public int getSecarray() {
		return secarray;
	}

	public void setSecarray(int secarray) {
		this.secarray = secarray;
	}

	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		int fleetno=Integer.parseInt(request.getParameter("fleetno"));
		String branch=request.getParameter("branch");
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		serviceAndMaintenanceBean=serviceAndMaintenanceDAO.getPrint(request,fleetno,branch,fromdate,todate);
		setLblcompname(serviceAndMaintenanceBean.getLblcompname());
		setLblcompaddress(serviceAndMaintenanceBean.getLblcompaddress());
		setLblprintname(serviceAndMaintenanceBean.getLblprintname());
		setLblprintname1(serviceAndMaintenanceBean.getLblprintname1());
		setLblcomptel(serviceAndMaintenanceBean.getLblcomptel());
		setLblcompfax(serviceAndMaintenanceBean.getLblcompfax());
		setLblbranch(serviceAndMaintenanceBean.getLblbranch());
		setLbllocation(serviceAndMaintenanceBean.getLbllocation());
		setLblservicetax(serviceAndMaintenanceBean.getLblservicetax());
		setLblpan(serviceAndMaintenanceBean.getLblpan());
		setLblcstno(serviceAndMaintenanceBean.getLblcstno());
		setLblfleetno(serviceAndMaintenanceBean.getLblfleetno());
		setLblfleetname(serviceAndMaintenanceBean.getLblfleetname());
		setLblfleetregno(serviceAndMaintenanceBean.getLblfleetregno());
		setLblfleetauthority(serviceAndMaintenanceBean.getLblfleetauthority());
		setLblfleetyom(serviceAndMaintenanceBean.getLblfleetyom());
		setLblfleetcolor(serviceAndMaintenanceBean.getLblfleetcolor());
		setLblfleetchassisno(serviceAndMaintenanceBean.getLblfleetchassisno());
		setLblfleetengineno(serviceAndMaintenanceBean.getLblfleetengineno());
		setFirstarray(serviceAndMaintenanceBean.getFirstarray());
		setSecarray(serviceAndMaintenanceBean.getSecarray());
		
		return "print";
	}
		
}
