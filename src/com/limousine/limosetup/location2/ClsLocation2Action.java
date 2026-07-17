package com.limousine.limosetup.location2;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsLocation2Action {
	ClsCommon objcommon=new ClsCommon();
	ClsLocation2DAO locdao=new ClsLocation2DAO();
	private int docno;
	private String location;
	private String latitude;
	private String longitude;
	private String msg;
	private String mode;
	private String deleted;
	private String brchName;
	private String date;
	private String formdetail;
	private String formdetailcode;
	
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
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
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	
	
	public void setValues(int docno,java.sql.Date sqldate){
		setDocno(docno);
		setLongitude(getLongitude());
		setLatitude(getLatitude());
		if(sqldate!=null){
			setDate(sqldate.toString());	
		}
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
			int val=locdao.insert(getLocation(),getLongitude(),getLatitude(),getBrchName(),sqldate,session,getFormdetailcode());
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
			boolean status=locdao.edit(getLocation(),getLongitude(),getLatitude(),getBrchName(),sqldate,session,getDocno(),getFormdetailcode());
			if(status){
				setMsg("Updated Successfully");
				System.out.println("docno:"+getDocno());
				setValues(getDocno(),sqldate);
				return "success";
			}
			else{
				setMsg("Not Updated");
				setValues(getDocno(),sqldate);
				return "success";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean status=locdao.delete(getLocation(),getLongitude(),getLatitude(),getBrchName(),sqldate,session,getDocno(),getFormdetailcode());
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
		
		else if(mode.equalsIgnoreCase("view")){
			setValues(getDocno(), sqldate);
			return "success";
		}
		return "fail";
		}
}
