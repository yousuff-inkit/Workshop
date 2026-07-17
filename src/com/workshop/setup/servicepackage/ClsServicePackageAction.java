package com.workshop.setup.servicepackage;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class ClsServicePackageAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsServicePackageDAO ComplaintDAO=new ClsServicePackageDAO();
	ClsServicePackageBean bean;
private int docno;
private String  compdate ,compdatehidden,compliant;
private int gridlength;
private String msg;
private String formdetailcode;
private String formdetail;
private String code,amount,name;


public int getGridlength() {
	return gridlength;
}
public void setGridlength(int gridlength) {
	this.gridlength = gridlength;
}
public String getCode() {
	return code;
}
public void setCode(String code) {
	this.code = code;
}
public String getAmount() {
	return amount;
}
public void setAmount(String amount) {
	this.amount = amount;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
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


private String mode;
private String delete;

public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}


public String getCompdate() {
	return compdate;
}
public void setCompdate(String compdate) {
	this.compdate = compdate;
}
public String getCompdatehidden() {
	return compdatehidden;
}
public void setCompdatehidden(String compdatehidden) {
	this.compdatehidden = compdatehidden;
}
public String getCompliant() {
	return compliant;
}
public void setCompliant(String compliant) {
	this.compliant = compliant;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public String getDelete() {
	return delete;
}
public void setDelete(String delete) {
	this.delete = delete;
}

public void setData(){
	setCode(getCode());
	setName(getName());
	setAmount(getAmount());
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();

	session.getAttribute("BRANCHID");
	String mode=getMode();
	ArrayList<String> descarray= new ArrayList<>();
	if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E")){
		

		Map<String, String[]> requestParams = request.getParameterMap();
		for(int i=0;i<getGridlength();i++){

			String temp=requestParams.get("test"+i)[0];

			descarray.add(temp);
		}
	}

	if(mode.equalsIgnoreCase("A")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getCompdate());
					int val=ComplaintDAO.insert(getCompliant(),sqlStartDate,session,getMode(),
							getFormdetailcode(),getCode(),getName(),getAmount(),descarray);
					setData();
					if(val>0){
						
						setCompliant(getCompliant());
						setCompdatehidden(sqlStartDate.toString());
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else{
						setCompliant(getCompliant());
						setCompdatehidden(sqlStartDate.toString());
						setDocno(val);
						setMsg("Not Saved");

						return "fail";
					}	
	}
	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getCompdate());
		boolean Status=ComplaintDAO.edit(getCompliant(),sqlStartDate,session,getMode(),
				getFormdetailcode(),getDocno(),getCode(),getName(),getAmount(),descarray);
		setData();
		if(Status){
			
			setDocno(getDocno());
			setCompliant(getCompliant());
			setCompdatehidden(sqlStartDate.toString());
			setMsg("Updated Successfully");

			return "success";
		}
		else{
			setDocno(getDocno());
			setCompliant(getCompliant());
			setCompdatehidden(sqlStartDate.toString());
			setMsg("Not Updated");

			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getCompdate());

		boolean Status=ComplaintDAO.delete(session,getMode(),getFormdetailcode(),getDocno());
		setData();
		if(Status){
		//setBra(getBrand());
		setDocno(getDocno());
		setCompliant(getCompliant());
		setCompdatehidden(sqlStartDate.toString());
		
		setDelete("DELETED");
		setMsg("Successfully Deleted");

		return "success";
	}
	else{
		setDocno(getDocno());
		setCompliant(getCompliant());
		setCompdatehidden(sqlStartDate.toString());
		setMsg("Not Deleted");

		return "fail";
	}
	}
	return "fail";
}


}

