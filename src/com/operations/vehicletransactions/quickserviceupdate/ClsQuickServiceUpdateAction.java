package com.operations.vehicletransactions.quickserviceupdate;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
public class ClsQuickServiceUpdateAction extends ActionSupport {
ClsQuickServiceUpdateDAO servicedao=new ClsQuickServiceUpdateDAO();
ClsCommon objcommon=new ClsCommon();
ClsQuickServiceUpdateBean servicebean;
private int docno;
private String date;
private String srvcfromdate;
private String srvctodate;
private String garage;
private String garagename;
private String fleetno;
private String fleetname;
private String currentkm;
private String nextduekm;
private String billno;
private String servicedate;
private String chkwashing;
private String hidchkwashing;
private String chkoil;
private String hidchkoil;
private String chkoilfilter;
private String hidchkoilfilter;
private String chkfuelfilter;
private String hidchkfuelfilter;
private String chkairfilter;
private String hidchkairfilter;
private String partscost;
private String labourcost;
private String mode;
private String msg;
private String deleted;
private String formdetailcode;
private String brchName;
private String remarks;



public String getRemarks() {
	return remarks;
}
public void setRemarks(String remarks) {
	this.remarks = remarks;
}
public String getBrchName() {
	return brchName;
}
public void setBrchName(String brchName) {
	this.brchName = brchName;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getSrvcfromdate() {
	return srvcfromdate;
}
public void setSrvcfromdate(String srvcfromdate) {
	this.srvcfromdate = srvcfromdate;
}
public String getSrvctodate() {
	return srvctodate;
}
public void setSrvctodate(String srvctodate) {
	this.srvctodate = srvctodate;
}
public String getGarage() {
	return garage;
}
public void setGarage(String garage) {
	this.garage = garage;
}
public String getGaragename() {
	return garagename;
}
public void setGaragename(String garagename) {
	this.garagename = garagename;
}
public String getFleetno() {
	return fleetno;
}
public void setFleetno(String fleetno) {
	this.fleetno = fleetno;
}
public String getFleetname() {
	return fleetname;
}
public void setFleetname(String fleetname) {
	this.fleetname = fleetname;
}
public String getCurrentkm() {
	return currentkm;
}
public void setCurrentkm(String currentkm) {
	this.currentkm = currentkm;
}
public String getNextduekm() {
	return nextduekm;
}
public void setNextduekm(String nextduekm) {
	this.nextduekm = nextduekm;
}
public String getBillno() {
	return billno;
}
public void setBillno(String billno) {
	this.billno = billno;
}
public String getServicedate() {
	return servicedate;
}
public void setServicedate(String servicedate) {
	this.servicedate = servicedate;
}
public String getChkwashing() {
	return chkwashing;
}
public void setChkwashing(String chkwashing) {
	this.chkwashing = chkwashing;
}
public String getHidchkwashing() {
	return hidchkwashing;
}
public void setHidchkwashing(String hidchkwashing) {
	this.hidchkwashing = hidchkwashing;
}
public String getChkoil() {
	return chkoil;
}
public void setChkoil(String chkoil) {
	this.chkoil = chkoil;
}
public String getHidchkoil() {
	return hidchkoil;
}
public void setHidchkoil(String hidchkoil) {
	this.hidchkoil = hidchkoil;
}
public String getChkoilfilter() {
	return chkoilfilter;
}
public void setChkoilfilter(String chkoilfilter) {
	this.chkoilfilter = chkoilfilter;
}
public String getHidchkoilfilter() {
	return hidchkoilfilter;
}
public void setHidchkoilfilter(String hidchkoilfilter) {
	this.hidchkoilfilter = hidchkoilfilter;
}
public String getChkfuelfilter() {
	return chkfuelfilter;
}
public void setChkfuelfilter(String chkfuelfilter) {
	this.chkfuelfilter = chkfuelfilter;
}
public String getHidchkfuelfilter() {
	return hidchkfuelfilter;
}
public void setHidchkfuelfilter(String hidchkfuelfilter) {
	this.hidchkfuelfilter = hidchkfuelfilter;
}
public String getChkairfilter() {
	return chkairfilter;
}
public void setChkairfilter(String chkairfilter) {
	this.chkairfilter = chkairfilter;
}
public String getHidchkairfilter() {
	return hidchkairfilter;
}
public void setHidchkairfilter(String hidchkairfilter) {
	this.hidchkairfilter = hidchkairfilter;
}
public String getPartscost() {
	return partscost;
}
public void setPartscost(String partscost) {
	this.partscost = partscost;
}
public String getLabourcost() {
	return labourcost;
}
public void setLabourcost(String labourcost) {
	this.labourcost = labourcost;
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
public String getDeleted() {
	return deleted;
}
public void setDeleted(String deleted) {
	this.deleted = deleted;
}

public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	String mode=getMode();
	java.sql.Date date=null,fromdate=null,todate=null,servicedate=null;
	if(getDate()!=null){
		date=objcommon.changeStringtoSqlDate(getDate());
	}
	if(getSrvcfromdate()!=null){
		fromdate=objcommon.changeStringtoSqlDate(getSrvcfromdate());
	}
	if(getSrvctodate()!=null){
		todate=objcommon.changeStringtoSqlDate(getSrvctodate());
	}
	if(getServicedate()!=null){
		servicedate=objcommon.changeStringtoSqlDate(getServicedate());
	}
	Map<String, String[]> requestParams = request.getParameterMap();
	if(mode.equalsIgnoreCase("A")){
		int val=servicedao.insert(getDocno(),date,fromdate,todate,garage,getFormdetailcode(),session,getMode(),getBrchName(),getRemarks());
		if(val>0){
			setDocno(val);
			setDate(date.toString());
			setSrvcfromdate(fromdate.toString());
			setSrvctodate(todate.toString());
			setGarage(getGarage());
			setGaragename(getGaragename());
			setMsg("Successfully Saved");
			setMode(getMode());
			setRemarks(getRemarks());
			return "success";
		}
		else{
			setDocno(val);
			setDate(date.toString());
			setSrvcfromdate(fromdate.toString());
			setSrvctodate(todate.toString());
			setGarage(getGarage());
			setGaragename(getGaragename());
			setRemarks(getRemarks());	
			
			setMode(getMode());
			setMsg("Not Saved");

			return "fail";
		}
	}
	if(mode.equalsIgnoreCase("E")){
		int serviceval=servicedao.serviceSave(getDocno(),getFleetno(),getCurrentkm(),getNextduekm(),getBillno(),servicedate,getHidchkwashing(),getHidchkoil(),getHidchkoilfilter(),
				getHidchkfuelfilter(),getHidchkairfilter(),getPartscost(),getLabourcost(),getMode(),session,getFormdetailcode(),getBrchName(),getRemarks());
		if(serviceval>0){
			setMsg("Successfully Saved");
			setMode(getMode());
			return "success";
		}
		else{
			setMode(getMode());
			setMsg("Not Saved");

			return "fail";
		}
	}
return "fail";
}

}
