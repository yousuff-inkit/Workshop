package com.limousine.limosetup.airport;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsAirportAction {
	ClsCommon objcommon=new ClsCommon();
ClsAirportDAO airportdao=new ClsAirportDAO();
private int docno;
private String iata;
private String airport;
private String location;
private String country;
private String date;
private String mode;
private String msg;
private String deleted;
private String formdetailcode;
private String brchName;


public String getBrchName() {
	return brchName;
}
public void setBrchName(String brchName) {
	this.brchName = brchName;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getIata() {
	return iata;
}
public void setIata(String iata) {
	this.iata = iata;
}
public String getAirport() {
	return airport;
}
public void setAirport(String airport) {
	this.airport = airport;
}
public String getLocation() {
	return location;
}
public void setLocation(String location) {
	this.location = location;
}
public String getCountry() {
	return country;
}
public void setCountry(String country) {
	this.country = country;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
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
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}

public void setValues(int docno,java.sql.Date sqldate){
	setDocno(docno);
	setIata(getIata());
	setAirport(getAirport());
	setCountry(getCountry());
	setDate(sqldate.toString());
	setLocation(getLocation());
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	String mode=getMode();
	java.sql.Date sqldate=null;
	if(getDate()!=null && !getDate().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(getDate());
	}
	if(mode.equalsIgnoreCase("A")){
		int val=airportdao.insert(getIata(),getAirport(),getLocation(),getCountry(),sqldate,getFormdetailcode(),session,getBrchName());
		if(val>0){
			setMsg("Successfully Saved");
			setValues(val,sqldate);
			return "success";
		}
		else{
			setMsg("Not Saved");
			setValues(docno,sqldate);
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("E")){
		boolean status=airportdao.edit(getIata(),getAirport(),getLocation(),getCountry(),sqldate,getFormdetailcode(),session,getDocno(),getBrchName());
		if(status){
			setMsg("Updated Successfully");
			setValues(getDocno(),sqldate);
			return "success";
		}
		else{
			setMsg("Not Updated");
			setValues(getDocno(),sqldate);
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){
		boolean status=airportdao.delete(getIata(),getAirport(),getLocation(),getCountry(),sqldate,getFormdetailcode(),session,getDocno(),getBrchName());
		if(status){
			setMsg("Successfully Deleted");
			setValues(getDocno(),sqldate);
			return "success";

		}
		else{
			setMsg("Not Deleted");
			setValues(getDocno(),sqldate);
			return "fail";
		}
	}
	
return "fail";
}
}
