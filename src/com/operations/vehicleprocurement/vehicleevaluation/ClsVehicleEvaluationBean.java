package com.operations.vehicleprocurement.vehicleevaluation;

import java.io.IOException;


public class ClsVehicleEvaluationBean{
	private String jqxDate1;
	private String  hidjqxDate1;
	private int  docno;
	
	private String deleted,mode,msg,formdetailcode;
	private String cmbbrand;
	private String hidcmbbrand;
	private String cmbmodel;
	private String txtclientname;
	private String txtengno;
	private String model;
	private String formdetail;
	private String lblintrclr;
	//for print
	private String lbldate,lblclient,lblcontact,lblbrand,lblmodel,lblyom,lblcolor,
	               lblintrcolor,lbltrans,lblchno,lblengineno,lblodo,lblcond;
	
	
	
	
	
	
	
	
	
	
	public String getLblintrclr() {
		return lblintrclr;
	}
	public void setLblintrclr(String lblintrclr) {
		this.lblintrclr = lblintrclr;
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
	public String getLblcontact() {
		return lblcontact;
	}
	public void setLblcontact(String lblcontact) {
		this.lblcontact = lblcontact;
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
	public String getLblcolor() {
		return lblcolor;
	}
	public void setLblcolor(String lblcolor) {
		this.lblcolor = lblcolor;
	}
	public String getLblintrcolor() {
		return lblintrcolor;
	}
	public void setLblintrcolor(String lblintrcolor) {
		this.lblintrcolor = lblintrcolor;
	}
	public String getLbltrans() {
		return lbltrans;
	}
	public void setLbltrans(String lbltrans) {
		this.lbltrans = lbltrans;
	}
	public String getLblchno() {
		return lblchno;
	}
	public void setLblchno(String lblchno) {
		this.lblchno = lblchno;
	}
	public String getLblengineno() {
		return lblengineno;
	}
	public void setLblengineno(String lblengineno) {
		this.lblengineno = lblengineno;
	}
	public String getLblodo() {
		return lblodo;
	}
	public void setLblodo(String lblodo) {
		this.lblodo = lblodo;
	}
	public String getLblcond() {
		return lblcond;
	}
	public void setLblcond(String lblcond) {
		this.lblcond = lblcond;
	}



	//
	private int hidcmbtransition;
	public String getJqxDate1() {
		return jqxDate1;
	}
	public void setJqxDate1(String jqxDate1) {
		this.jqxDate1 = jqxDate1;
	}
	public String getHidjqxDate1() {
		return hidjqxDate1;
	}
	public void setHidjqxDate1(String hidjqxDate1) {
		this.hidjqxDate1 = hidjqxDate1;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
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
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getCmbbrand() {
		return cmbbrand;
	}
	public void setCmbbrand(String cmbbrand) {
		this.cmbbrand = cmbbrand;
	}
	public String getHidcmbbrand() {
		return hidcmbbrand;
	}
	public void setHidcmbbrand(String hidcmbbrand) {
		this.hidcmbbrand = hidcmbbrand;
	}
	public String getCmbmodel() {
		return cmbmodel;
	}
	public void setCmbmodel(String cmbmodel) {
		this.cmbmodel = cmbmodel;
	}
	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	public String getTxtengno() {
		return txtengno;
	}
	public void setTxtengno(String txtengno) {
		this.txtengno = txtengno;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public int getHidcmbtransition() {
		return hidcmbtransition;
	}
	public void setHidcmbtransition(int hidcmbtransition) {
		this.hidcmbtransition = hidcmbtransition;
	}
	public String getTxtchno() {
		return txtchno;
	}
	public void setTxtchno(String txtchno) {
		this.txtchno = txtchno;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getTxtcldocno() {
		return txtcldocno;
	}
	public void setTxtcldocno(int txtcldocno) {
		this.txtcldocno = txtcldocno;
	}
	public int getCarval() {
		return carval;
	}
	public void setCarval(int carval) {
		this.carval = carval;
	}
	public int getCmbyom() {
		return cmbyom;
	}
	public void setCmbyom(int cmbyom) {
		this.cmbyom = cmbyom;
	}
	public int getHidcmbyom() {
		return hidcmbyom;
	}
	public void setHidcmbyom(int hidcmbyom) {
		this.hidcmbyom = hidcmbyom;
	}
	public int getCmbinterior() {
		return cmbinterior;
	}
	public void setCmbinterior(int cmbinterior) {
		this.cmbinterior = cmbinterior;
	}
	public int getHidcmbcolor() {
		return hidcmbcolor;
	}
	public void setHidcmbcolor(int hidcmbcolor) {
		this.hidcmbcolor = hidcmbcolor;
	}
	public int getCmbcolor() {
		return cmbcolor;
	}
	public void setCmbcolor(int cmbcolor) {
		this.cmbcolor = cmbcolor;
	}
	public int getCmbtransition() {
		return cmbtransition;
	}
	public void setCmbtransition(int cmbtransition) {
		this.cmbtransition = cmbtransition;
	}
	public int getTxtodno() {
		return txtodno;
	}
	public void setTxtodno(int txtodno) {
		this.txtodno = txtodno;
	}
	public int getCmbcondition() {
		return cmbcondition;
	}
	public void setCmbcondition(int cmbcondition) {
		this.cmbcondition = cmbcondition;
	}
	public int getHidcmbcondition() {
		return hidcmbcondition;
	}
	public void setHidcmbcondition(int hidcmbcondition) {
		this.hidcmbcondition = hidcmbcondition;
	}
	
	public int getHidcmbinterior() {
		return hidcmbinterior;
	}
	public void setHidcmbinterior(int hidcmbinterior) {
		this.hidcmbinterior = hidcmbinterior;
	}
	
	
	
	private String txtchno;
	




	private int gridlength,txtcldocno,carval,cmbyom,hidcmbyom,cmbinterior,hidcmbcolor,cmbcolor,cmbtransition,hidcmbinterior;
	
	private int txtodno,cmbcondition,hidcmbcondition;
	
	
	
	
	
	
	
	
	
	
	
	

}
