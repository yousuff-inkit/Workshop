package com.limousine.limotarifmgmt;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsLimoTarifAction {
ClsCommon objcommon=new ClsCommon();
ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO();
private int docno;
private String mode;
private String msg;
private String deleted;
private String date;
private String cmbtariftype;
private String hidcmbtariftype;
private String cmbtariffor;
private String hidcmbtariffor;
private String tarifclient;
private String hidtarifclient;
private String fromdate;
private String todate;
private String chkdelivery;
private String hidchkdelivery;
private String desc;
private String formdetail;
private String formdetailcode;
private String brchName;
private int tariftransferlength;
private int tarifhourslength;
private String hidgroup;


public int getTariftransferlength() {
	return tariftransferlength;
}
public void setTariftransferlength(int tariftransferlength) {
	this.tariftransferlength = tariftransferlength;
}
public int getTarifhourslength() {
	return tarifhourslength;
}
public void setTarifhourslength(int tarifhourslength) {
	this.tarifhourslength = tarifhourslength;
}
public String getHidgroup() {
	return hidgroup;
}
public void setHidgroup(String hidgroup) {
	this.hidgroup = hidgroup;
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
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getCmbtariftype() {
	return cmbtariftype;
}
public void setCmbtariftype(String cmbtariftype) {
	this.cmbtariftype = cmbtariftype;
}
public String getHidcmbtariftype() {
	return hidcmbtariftype;
}
public void setHidcmbtariftype(String hidcmbtariftype) {
	this.hidcmbtariftype = hidcmbtariftype;
}
public String getCmbtariffor() {
	return cmbtariffor;
}
public void setCmbtariffor(String cmbtariffor) {
	this.cmbtariffor = cmbtariffor;
}
public String getHidcmbtariffor() {
	return hidcmbtariffor;
}
public void setHidcmbtariffor(String hidcmbtariffor) {
	this.hidcmbtariffor = hidcmbtariffor;
}
public String getTarifclient() {
	return tarifclient;
}
public void setTarifclient(String tarifclient) {
	this.tarifclient = tarifclient;
}
public String getHidtarifclient() {
	return hidtarifclient;
}
public void setHidtarifclient(String hidtarifclient) {
	this.hidtarifclient = hidtarifclient;
}
public String getFromdate() {
	return fromdate;
}
public void setFromdate(String fromdate) {
	this.fromdate = fromdate;
}
public String getTodate() {
	return todate;
}
public void setTodate(String todate) {
	this.todate = todate;
}
public String getChkdelivery() {
	return chkdelivery;
}
public void setChkdelivery(String chkdelivery) {
	this.chkdelivery = chkdelivery;
}
public String getHidchkdelivery() {
	return hidchkdelivery;
}
public void setHidchkdelivery(String hidchkdelivery) {
	this.hidchkdelivery = hidchkdelivery;
}
public String getDesc() {
	return desc;
}
public void setDesc(String desc) {
	this.desc = desc;
}
public String getFormdetail() {
	return formdetail;
}
public void setFormdetail(String formdetail) {
	this.formdetail = formdetail;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getBrchName() {
	return brchName;
}
public void setBrchName(String brchName) {
	this.brchName = brchName;
}

public void setvalues(int docno,java.sql.Date sqldate,java.sql.Date sqlfromdate,java.sql.Date sqltodate){
	setDocno(docno);
	setDate(sqldate.toString());
	setFromdate(sqlfromdate.toString());
	setTodate(sqltodate.toString());
	setCmbtariffor(getCmbtariffor());
	setHidcmbtariffor(getCmbtariffor());
	setCmbtariftype(getCmbtariftype());
	setHidcmbtariftype(getCmbtariftype());
	setTarifclient(getTarifclient());
	setHidtarifclient(getHidtarifclient());
	setHidchkdelivery(getHidchkdelivery());
	setDesc(getDesc());
	
}


public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	String mode=getMode();
	java.sql.Date sqldate=null;
	java.sql.Date sqlfromdate=null;
	java.sql.Date sqltodate=null;
	if(getDate()!=null && !getDate().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(getDate());
	}
	if(getFromdate()!=null && !getFromdate().equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
	}
	if(getTodate()!=null && !getTodate().equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(getTodate());
	}
	
	if(mode.equalsIgnoreCase("A")){
		int val=tarifdao.insert(sqldate,getCmbtariffor(),getCmbtariftype(),getHidtarifclient(),sqlfromdate,sqltodate,getHidchkdelivery(),getDesc(),mode,session,getBrchName(),getFormdetailcode());
		if(val>0){
			setvalues(val,sqldate,sqlfromdate,sqltodate);
			setMsg("Successfully Saved");
			return "success";
		}
		else{
			setvalues(val,sqldate,sqlfromdate,sqltodate);
			setMsg("Not Saved");
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("E")){
		boolean status=tarifdao.edit(getDocno(),sqldate,getCmbtariffor(),getCmbtariftype(),getHidtarifclient(),sqlfromdate,sqltodate,getHidchkdelivery(),getDesc(),mode,session,getBrchName(),getFormdetailcode());
		if(status){
			setvalues(getDocno(),sqldate,sqlfromdate,sqltodate);
			setMsg("Updated Successfully");
			return "success";
		}
		else{
			setvalues(getDocno(),sqldate,sqlfromdate,sqltodate);
			setMsg("Not Updated");
			return "fail";
		}
	
	}
	
	else if(mode.equalsIgnoreCase("D")){
		boolean status=tarifdao.delete(getDocno(),sqldate,getCmbtariffor(),getCmbtariftype(),getHidtarifclient(),sqlfromdate,sqltodate,getHidchkdelivery(),getDesc(),mode,session,getBrchName(),getFormdetailcode());
		if(status){
			setvalues(getDocno(),sqldate,sqlfromdate,sqltodate);
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setvalues(getDocno(),sqldate,sqlfromdate,sqltodate);
			setMsg("Not Deleted");
			return "fail";
		}
		
	}
	
	else if(mode.equalsIgnoreCase("tarifinsert")){
		ArrayList<String> transferarray=new ArrayList<>();
		ArrayList<String> hoursarray=new ArrayList<>();
		if(getTariftransferlength()>0){
			for(int i=0;i<getTariftransferlength();i++){
				String temp=requestParams.get("tariftransfer"+i)[0];
				transferarray.add(temp);
			}
		}
		if(getTarifhourslength()>0){
			for(int i=0;i<getTarifhourslength();i++){
				String temp=requestParams.get("tarifhours"+i)[0];
				hoursarray.add(temp);
			}
		}
		int val=tarifdao.detailinsert(getDocno(),getHidgroup(),transferarray,hoursarray,session,getBrchName());
		if(val>0){
			setvalues(getDocno(),sqldate,sqlfromdate,sqltodate);
			setMsg("Updated Successfully");
			return "success";
		}
		else{
			setvalues(getDocno(),sqldate,sqlfromdate,sqltodate);
			setMsg("Not Updated");
			return "fail";
		}
		
	}
	return "fail";
}
	
}
