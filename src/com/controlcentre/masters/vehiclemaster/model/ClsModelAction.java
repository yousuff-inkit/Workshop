package com.controlcentre.masters.vehiclemaster.model;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeBean;
import com.controlcentre.masters.vehiclemaster.project.ClsProjectBean;

public class ClsModelAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsModelDAO modelDAO= new ClsModelDAO();
	ClsModelBean bean;
private int docno;
private String mode;
private String deleted;
private String model; 
private String modeldate;
private String brand;
private String brandid;
private String txtgroup;
private int txtgroupid;
private String msg;
private String formdetailcode;
private String formdetail;
private String chkstatus;
private String cmbenginesize,hidcmbenginesize;

public String getDeleted() {
	return deleted;
}
public void setDeleted(String deleted) {
	this.deleted = deleted;
}
public String getCmbenginesize() {
	return cmbenginesize;
}
public void setCmbenginesize(String cmbenginesize) {
	this.cmbenginesize = cmbenginesize;
}
public String getHidcmbenginesize() {
	return hidcmbenginesize;
}
public void setHidcmbenginesize(String hidcmbenginesize) {
	this.hidcmbenginesize = hidcmbenginesize;
}
public String getChkstatus() {
	return chkstatus;
}
public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getFormdetail() {
	return formdetail;
}
public void setFormdetail(String formdetail) {
	this.formdetail = formdetail;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getBrandid() {
	return brandid;
}
public void setBrandid(String brandid) {
	this.brandid = brandid;
}
public String getModel() {
	return model;
}
public void setModel(String model) {
	this.model = model;
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

public String getModeldate() {
	return modeldate;
}
public void setModeldate(String modeldate) {
	this.modeldate = modeldate;
}
public String getBrand() {
	return brand;
}
public void setBrand(String brand) {
	this.brand = brand;
}


public String getTxtgroup() {
	return txtgroup;
}
public void setTxtgroup(String txtgroup) {
	this.txtgroup = txtgroup;
}
public int getTxtgroupid() {
	return txtgroupid;
}
public void setTxtgroupid(int txtgroupid) {
	this.txtgroupid = txtgroupid;
}
public void setValues(int docno,java.sql.Date sqlstartdate){
	setModel(getModel());
	setBrandid(getBrand());
	setTxtgroupid(getTxtgroupid());
	setTxtgroup(getTxtgroup());
	setModeldate(sqlstartdate.toString());
	setMode(getMode());
	setDocno(docno);
	setHidcmbenginesize(getCmbenginesize());
	setCmbenginesize(getCmbenginesize());
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	String mode=getMode();
	ClsModelBean bean=new ClsModelBean();
	java.sql.Date sqlStartDate=null;
	if((mode.equalsIgnoreCase("A"))||(mode.equalsIgnoreCase("E"))){
		sqlStartDate = ClsCommon.changeStringtoSqlDate(getModeldate());
	}
	if(mode.equalsIgnoreCase("A")){
		int val=modelDAO.insert(getModel(),getBrand(),getTxtgroupid(),sqlStartDate,session,getMode(),getFormdetailcode(),getCmbenginesize());
		if(val>0.0){
			setValues(val, sqlStartDate);			
			setMsg("Successfully Saved");
			return "success";
		}
		else if(val==-1){
			setValues(val, sqlStartDate);
			setChkstatus("1");
			setMsg("Model Already Exists");
			return "fail";
		}
		else{
			setValues(val, sqlStartDate);
			setMsg("Not Saved");
			return "fail";
		}
	}


	else if(mode.equalsIgnoreCase("E")){
		int Status=modelDAO.edit(getModel(),getDocno(),getTxtgroupid(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode(),getCmbenginesize());
		if(Status>0){
			setValues(getDocno(), sqlStartDate);
			setMode(getMode());
			setMsg("Updated Successfully");
			return "success";
		}
		else if(Status==-1){
			setValues(getDocno(), sqlStartDate);
			setMode(getMode());
			setChkstatus("2");
			setMsg("Model Already Exists");
			return "fail";
		}
		else{
			setValues(getDocno(), sqlStartDate);
			setMode(getMode());
			setMsg("Not Updated");
			return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=modelDAO.delete(getModel(),getDocno(),getTxtgroupid(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setValues(getDocno(), sqlStartDate);
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else if(Status==-2){
				setValues(getDocno(), sqlStartDate);
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{
				setValues(getDocno(), sqlStartDate);
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}

}
