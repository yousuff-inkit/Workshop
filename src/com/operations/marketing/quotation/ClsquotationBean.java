

package com.operations.marketing.quotation;

import java.util.*;

public class ClsquotationBean {
	
	 private String BRAND;
	 private String VTYPE;
	 private String SPEC;
	 private String COLOR;
	 private String RTYPE;
	 private Date FRM_CONTR;
	 private Date TO_CONTR;
	 private int UNIT;
	 private String lblsalclient;
		private String lblsalmob;
		
	   public String getLblsalclient() {
			return lblsalclient;
		}
		public void setLblsalclient(String lblsalclient) {
			this.lblsalclient = lblsalclient;
		}
		public String getLblsalmob() {
			return lblsalmob;
		}
		public void setLblsalmob(String lblsalmob) {
			this.lblsalmob = lblsalmob;
		}
	public String getBRAND() {
		return BRAND;
	}
	public void setBRAND(String bRAND) {
		BRAND = bRAND;
	}
	public String getVTYPE() {
		return VTYPE;
	}
	public void setVTYPE(String vTYPE) {
		VTYPE = vTYPE;
	}
	public String getSPEC() {
		return SPEC;
	}
	public void setSPEC(String sPEC) {
		SPEC = sPEC;
	}
	public String getCOLOR() {
		return COLOR;
	}
	public void setCOLOR(String cOLOR) {
		COLOR = cOLOR;
	}
	public String getRTYPE() {
		return RTYPE;
	}
	public void setRTYPE(String rTYPE) {
		RTYPE = rTYPE;
	}
	public Date getFRM_CONTR() {
		return FRM_CONTR;
	}
	public void setFRM_CONTR(Date fRM_CONTR) {
		FRM_CONTR = fRM_CONTR;
	}
	public Date getTO_CONTR() {
		return TO_CONTR;
	}
	public void setTO_CONTR(Date tO_CONTR) {
		TO_CONTR = tO_CONTR;
	}
	public int getUNIT() {
		return UNIT;
	}
	public void setUNIT(int uNIT) {
		UNIT = uNIT;
	}	
	private String rentaltype;

	public String getRentaltype() {
		return rentaltype;
	}
	public void setRentaltype(String rentaltype) {
		this.rentaltype = rentaltype;
	}
	
	
	
	//-------------------------------------------------------
	
	
	
	private String lblclient,lblclientaddress,lblmob,lblemail,lbldate,lbltypep;
	
	private int docvals,firstarray,secarray;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation;

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
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblmob() {
		return lblmob;
	}
	public void setLblmob(String lblmob) {
		this.lblmob = lblmob;
	}
	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltypep() {
		return lbltypep;
	}
	public void setLbltypep(String lbltypep) {
		this.lbltypep = lbltypep;
	}
	public int getDocvals() {
		return docvals;
	}
	public void setDocvals(int docvals) {
		this.docvals = docvals;
	}
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
	
	//------------------------------------------------
	
	private String terms1,generalterms,terms2;
	public String getTerms1() {
		return terms1;
	}

	public void setTerms1(String terms1) {
		this.terms1 = terms1;
	}

	public String getGeneralterms() {
		return generalterms;
	}

	public void setGeneralterms(String generalterms) {
		this.generalterms = generalterms;
	}
	public String getTerms2() {
		return terms2;
	}
	public void setTerms2(String terms2) {
		this.terms2 = terms2;
	}
	private String lblcstno,lblservicetax,lblpan,lbltinno;

	
	
	public String getLbltinno() {
		return lbltinno;
	}
	public void setLbltinno(String lbltinno) {
		this.lbltinno = lbltinno;
	}
	
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
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
	
	
	
	
	
}