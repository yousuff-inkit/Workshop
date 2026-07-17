package com.workshop.setup.teammaster;

import java.util.Date;

public class ClsTeamMasterBean {
	
	
	private int docno;
	private String date;
	private String mode;
	private String deleted;
	private String hiddate;
	private String msg;
	private String txtgpcode;
	private String txtdesc,cmbavbranch,hidcmbavbranch;  
	public String getCmbavbranch() {
		return cmbavbranch;
	}
	public void setCmbavbranch(String cmbavbranch) {
		this.cmbavbranch = cmbavbranch;
	}
	public String getHidcmbavbranch() {
		return hidcmbavbranch;
	}
	public void setHidcmbavbranch(String hidcmbavbranch) {
		this.hidcmbavbranch = hidcmbavbranch;
	}
	private int ismemp;
	
	
	public int getIsmemp() {
		return ismemp;
	}
	public void setIsmemp(int ismemp) {
		this.ismemp = ismemp;
	}
	public String getTxtgpcode() {
		return txtgpcode;
	}
	public void setTxtgpcode(String txtgpcode) {
		this.txtgpcode = txtgpcode;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
}
