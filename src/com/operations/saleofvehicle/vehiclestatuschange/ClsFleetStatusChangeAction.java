package com.operations.saleofvehicle.vehiclestatuschange;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.common.*;
import com.controlcentre.masters.maintenancemaster.damage.ClsDamageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.operations.saleofvehicle.vehiclestatuschange.*;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsFleetStatusChangeAction {
	ClsFleetStatusChangeDAO fleetstatusDAO= new ClsFleetStatusChangeDAO();
	ClsFleetStatusChangeBean bean;
	ClsCommon objcommon=new ClsCommon();
	private int docno;
	private int fleetno;
	private String fleetname;
	private String fleetstatusdate;
	private String hidfleetstatusdate;
	private String hidfleetstatustime;
	private String fleetstatustime;
	private String reason;
	private String currentstatus;
	private String cmbchangestatus;
	private String hidcmbchangestatus;
	private String msg;
	private String deleted;
	private String mode;
	private String hidcurrentstatus;
	private String formdetailcode;
	private String formdetail;
	
	
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
	public String getHidcurrentstatus() {
		return hidcurrentstatus;
	}
	public void setHidcurrentstatus(String hidcurrentstatus) {
		this.hidcurrentstatus = hidcurrentstatus;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getFleetno() {
		return fleetno;
	}
	public void setFleetno(int fleetno) {
		this.fleetno = fleetno;
	}
	public String getFleetname() {
		return fleetname;
	}
	public void setFleetname(String fleetname) {
		this.fleetname = fleetname;
	}
	public String getFleetstatusdate() {
		return fleetstatusdate;
	}
	public void setFleetstatusdate(String fleetstatusdate) {
		this.fleetstatusdate = fleetstatusdate;
	}
	public String getHidfleetstatusdate() {
		return hidfleetstatusdate;
	}
	public void setHidfleetstatusdate(String hidfleetstatusdate) {
		this.hidfleetstatusdate = hidfleetstatusdate;
	}
	public String getHidfleetstatustime() {
		return hidfleetstatustime;
	}
	public void setHidfleetstatustime(String hidfleetstatustime) {
		this.hidfleetstatustime = hidfleetstatustime;
	}
	public String getFleetstatustime() {
		return fleetstatustime;
	}
	public void setFleetstatustime(String fleetstatustime) {
		this.fleetstatustime = fleetstatustime;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getCurrentstatus() {
		return currentstatus;
	}
	public void setCurrentstatus(String currentstatus) {
		this.currentstatus = currentstatus;
	}
	public String getCmbchangestatus() {
		return cmbchangestatus;
	}
	public void setCmbchangestatus(String cmbchangestatus) {
		this.cmbchangestatus = cmbchangestatus;
	}
	public String getHidcmbchangestatus() {
		return hidcmbchangestatus;
	}
	public void setHidcmbchangestatus(String hidcmbchangestatus) {
		this.hidcmbchangestatus = hidcmbchangestatus;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getDate_plateCode());

		session.getAttribute("BRANCHID");
		//System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
//		System.out.println("request==="+request.getAttribute("BranchName"));
		
		String mode=getMode();
		ClsDamageBean bean=new ClsDamageBean();
		java.sql.Date sqlStartDate = objcommon.changeStringtoSqlDate(getFleetstatusdate());

		if(mode.equalsIgnoreCase("A")){
						int val=fleetstatusDAO.insert(sqlStartDate,getFleetstatustime(),getFleetno(),getHidcurrentstatus(),getCmbchangestatus(),getReason(),session,getMode(),getFormdetailcode(),session.getAttribute("BRANCHID").toString());
						if(val>0.0){
							setFleetstatusdate(sqlStartDate.toString());
							setHidfleetstatustime(getFleetstatustime());
							setFleetno(getFleetno());
							setFleetname(getFleetname());
							setReason(getReason());
							setCurrentstatus(getCurrentstatus());
							setHidcurrentstatus(getHidcurrentstatus());
							setHidcmbchangestatus(getCmbchangestatus());
							setMode(getMode());
							
//							System.out.println(val);
							setDocno(val);
							setMsg("Successfully Saved");

							return "success";
						}
						else{
							setFleetstatusdate(sqlStartDate.toString());
							setHidfleetstatustime(getFleetstatustime());
							setFleetno(getFleetno());
							setFleetname(getFleetname());
							setReason(getReason());
							setCurrentstatus(getCurrentstatus());
							setHidcurrentstatus(getHidcurrentstatus());
							setHidcmbchangestatus(getCmbchangestatus());
							setMode(getMode());
							setMsg("Not Saved");

							return "fail";
						}	
		}
		else if(mode.equalsIgnoreCase("E")){
			boolean Status=fleetstatusDAO.edit(sqlStartDate,getFleetstatustime(),getFleetno(),getHidcurrentstatus(),getCmbchangestatus(),getReason(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status){
				setFleetstatusdate(sqlStartDate.toString());
				setHidfleetstatustime(getFleetstatustime());
				setFleetno(getFleetno());
				setFleetname(getFleetname());
				setReason(getReason());
				setCurrentstatus(getCurrentstatus());
				setHidcurrentstatus(getHidcurrentstatus());
				setHidcmbchangestatus(getCmbchangestatus());
				setMode(getMode());
				setDocno(getDocno());
				//System.out.println("brand"+brand);
				setMsg("Updated Successfully");

				return "success";
			}
			else{
				setFleetstatusdate(sqlStartDate.toString());
				setHidfleetstatustime(getFleetstatustime());
				setFleetno(getFleetno());
				setFleetname(getFleetname());
				setReason(getReason());
				setCurrentstatus(getCurrentstatus());
				setHidcurrentstatus(getHidcurrentstatus());
				setHidcmbchangestatus(getCmbchangestatus());
				setMode(getMode());
				setDocno(getDocno());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println(getDocno()+","+getBrand()+","+getDate_brand());
			boolean Status=fleetstatusDAO.delete(sqlStartDate,getFleetstatustime(),getFleetno(),getHidcurrentstatus(),getCmbchangestatus(),getReason(),session,getMode(),getDocno(),getFormdetailcode());
		if(Status){
			//setBra(getBrand());
			setFleetstatusdate(sqlStartDate.toString());
			setHidfleetstatustime(getFleetstatustime());
			setFleetno(getFleetno());
			setFleetname(getFleetname());
			setReason(getReason());
			setCurrentstatus(getCurrentstatus());
			setHidcurrentstatus(getHidcurrentstatus());
			setHidcmbchangestatus(getCmbchangestatus());
			setMode(getMode());
			setDocno(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else{
			setFleetstatusdate(sqlStartDate.toString());
			setHidfleetstatustime(getFleetstatustime());
			setFleetno(getFleetno());
			setFleetname(getFleetname());
			setReason(getReason());
			setCurrentstatus(getCurrentstatus());
			setHidcurrentstatus(getHidcurrentstatus());
			setHidcmbchangestatus(getCmbchangestatus());
			setMode(getMode());
			setDocno(getDocno());
			setMsg("Not Deleted");

			return "fail";
		}
		}
		return "fail";
	}

}
