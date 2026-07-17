package com.dashboard.vehicle.defleetlist;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsDeFleetListAction {

	ClsDeFleetListDAO defleetdao=new ClsDeFleetListDAO();
	ClsDeFleetListBean defleetbean=new ClsDeFleetListBean();
	private String lblinvoicedoc;
	private String lbldate;
	private String lblclient;
	private String lblpobox;
	private String lbladdress;
	private String lbltelephone;
	private String lblfax;
	private String lblvehicle;
	private String lblyear;
	private String lblchassis;
	private String lblengine;
	private String lblcolor;
	private String lblvin;
	private String lblamount;
	private String lblmileage;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname1;
	private String lblbranch,lbllocation;
	private String lblcompname;
	
	
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
	public String getLblmileage() {
		return lblmileage;
	}
	public void setLblmileage(String lblmileage) {
		this.lblmileage = lblmileage;
	}
	public String getLblinvoicedoc() {
		return lblinvoicedoc;
	}
	public void setLblinvoicedoc(String lblinvoicedoc) {
		this.lblinvoicedoc = lblinvoicedoc;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLblpobox() {
		return lblpobox;
	}
	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
	}
	public String getLbladdress() {
		return lbladdress;
	}
	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}
	public String getLbltelephone() {
		return lbltelephone;
	}
	public void setLbltelephone(String lbltelephone) {
		this.lbltelephone = lbltelephone;
	}
	public String getLblfax() {
		return lblfax;
	}
	public void setLblfax(String lblfax) {
		this.lblfax = lblfax;
	}
	public String getLblvehicle() {
		return lblvehicle;
	}
	public void setLblvehicle(String lblvehicle) {
		this.lblvehicle = lblvehicle;
	}
	public String getLblyear() {
		return lblyear;
	}
	public void setLblyear(String lblyear) {
		this.lblyear = lblyear;
	}
	public String getLblchassis() {
		return lblchassis;
	}
	public void setLblchassis(String lblchassis) {
		this.lblchassis = lblchassis;
	}
	public String getLblengine() {
		return lblengine;
	}
	public void setLblengine(String lblengine) {
		this.lblengine = lblengine;
	}
	public String getLblcolor() {
		return lblcolor;
	}
	public void setLblcolor(String lblcolor) {
		this.lblcolor = lblcolor;
	}
	public String getLblvin() {
		return lblvin;
	}
	public void setLblvin(String lblvin) {
		this.lblvin = lblvin;
	}
	public String getLblamount() {
		return lblamount;
	}
	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String fleetno=request.getParameter("fleetno");
		defleetbean=defleetdao.getPrint(fleetno);
		setLbladdress(defleetbean.getLbladdress());
		setLblamount(defleetbean.getLblamount());
		setLblchassis(defleetbean.getLblchassis());
		setLblclient(defleetbean.getLblclient());
		setLblcolor(defleetbean.getLblcolor());
		setLbldate(defleetbean.getLbldate());
		setLblengine(defleetbean.getLblengine());
		setLblfax(defleetbean.getLblfax());
		setLblinvoicedoc(defleetbean.getLblinvoicedoc());
		setLblmileage(defleetbean.getLblmileage());
		setLblpobox(defleetbean.getLblpobox());
		setLbltelephone(defleetbean.getLbltelephone());
		setLblvehicle(defleetbean.getLblvehicle());
		setLblvin(defleetbean.getLblvin());
		setLblyear(defleetbean.getLblyear());
		setLblcompaddress(defleetbean.getLblcompaddress());
		setLblcompfax(defleetbean.getLblcompfax());
		setLblcompname(defleetbean.getLblcompname());
		setLblcomptel(defleetbean.getLblcomptel());
		setLblbranch(defleetbean.getLblbranch());
		setLbllocation(defleetbean.getLbllocation());
		setLblprintname("Invoice");
		return "print";
	}
}
