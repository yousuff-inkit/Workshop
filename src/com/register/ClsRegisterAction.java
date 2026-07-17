package com.register;

import java.sql.SQLException;
import java.text.ParseException;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsRegisterAction extends ActionSupport{
	
	ClsCommon commonDAO = new ClsCommon();
	ClsRegisterDAO registerDAO = new ClsRegisterDAO();
	ClsRegisterBean registerbean;
	
	/*Company*/
	private String txtcompid;
	private String txtcompname;
	private String txtaddress;
	private String txttel;
	private String txtemail;
	private String txtproduct;
	private String cmbtimezone;
	private String hidcmbtimezone;
	
	/*Branch*/
	private String txtbranchid;
	private String txtbranchname;
	private String txtbranchaddress;
	private String txtbranchtel;
	private String txtbranchemail;
	
	/*User*/
	private String txtuserid;
	private String txtusername;
	private String txtuserpassword;
	private String txtuserpasswordconfirm;
	private String txtuseremail;
		
	public String getTxtcompid() {
		return txtcompid;
	}

	public void setTxtcompid(String txtcompid) {
		this.txtcompid = txtcompid;
	}

	public String getTxtcompname() {
		return txtcompname;
	}

	public void setTxtcompname(String txtcompname) {
		this.txtcompname = txtcompname;
	}

	public String getTxtaddress() {
		return txtaddress;
	}

	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}

	public String getTxttel() {
		return txttel;
	}

	public void setTxttel(String txttel) {
		this.txttel = txttel;
	}

	public String getTxtemail() {
		return txtemail;
	}

	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}

	public String getTxtproduct() {
		return txtproduct;
	}

	public void setTxtproduct(String txtproduct) {
		this.txtproduct = txtproduct;
	}

	public String getCmbtimezone() {
		return cmbtimezone;
	}

	public void setCmbtimezone(String cmbtimezone) {
		this.cmbtimezone = cmbtimezone;
	}

	public String getHidcmbtimezone() {
		return hidcmbtimezone;
	}

	public void setHidcmbtimezone(String hidcmbtimezone) {
		this.hidcmbtimezone = hidcmbtimezone;
	}

	public String getTxtbranchid() {
		return txtbranchid;
	}

	public void setTxtbranchid(String txtbranchid) {
		this.txtbranchid = txtbranchid;
	}

	public String getTxtbranchname() {
		return txtbranchname;
	}

	public void setTxtbranchname(String txtbranchname) {
		this.txtbranchname = txtbranchname;
	}

	public String getTxtbranchaddress() {
		return txtbranchaddress;
	}

	public void setTxtbranchaddress(String txtbranchaddress) {
		this.txtbranchaddress = txtbranchaddress;
	}

	public String getTxtbranchtel() {
		return txtbranchtel;
	}

	public void setTxtbranchtel(String txtbranchtel) {
		this.txtbranchtel = txtbranchtel;
	}

	public String getTxtbranchemail() {
		return txtbranchemail;
	}

	public void setTxtbranchemail(String txtbranchemail) {
		this.txtbranchemail = txtbranchemail;
	}

	public String getTxtuserid() {
		return txtuserid;
	}

	public void setTxtuserid(String txtuserid) {
		this.txtuserid = txtuserid;
	}

	public String getTxtusername() {
		return txtusername;
	}

	public void setTxtusername(String txtusername) {
		this.txtusername = txtusername;
	}

	public String getTxtuserpassword() {
		return txtuserpassword;
	}

	public void setTxtuserpassword(String txtuserpassword) {
		this.txtuserpassword = txtuserpassword;
	}

	public String getTxtuserpasswordconfirm() {
		return txtuserpasswordconfirm;
	}

	public void setTxtuserpasswordconfirm(String txtuserpasswordconfirm) {
		this.txtuserpasswordconfirm = txtuserpasswordconfirm;
	}

	public String getTxtuseremail() {
		return txtuseremail;
	}

	public void setTxtuseremail(String txtuseremail) {
		this.txtuseremail = txtuseremail;
	}

	public String saveAction() throws ParseException, SQLException{

		int val=registerDAO.insert(getTxtcompid(),getTxtcompname(),getTxtaddress(),getTxttel(),getTxtemail(),getTxtproduct(),getTxtproduct(),getCmbtimezone(),getTxtbranchid(),
				getTxtbranchname(),getTxtbranchaddress(),getTxtbranchtel(),getTxtbranchemail(),getTxtuserid(),getTxtusername(),getTxtuserpassword(),getTxtuserpasswordconfirm(),getTxtuseremail());
		if(val>0.0) {
			return "success";
		} else if(val==-1) {
			return "fail";
		} 
			return "fail";
		}
		
	}

