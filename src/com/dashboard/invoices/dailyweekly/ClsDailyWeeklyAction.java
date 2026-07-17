package com.dashboard.invoices.dailyweekly;

import com.common.*;

import java.sql.*;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.finance.transactions.journalvouchers.*;
public class ClsDailyWeeklyAction {

	ClsJournalVouchersDAO journaldao=new ClsJournalVouchersDAO();
	ClsDailyWeeklyDAO invoicedao=new ClsDailyWeeklyDAO();
	ClsCommon objcommon=new ClsCommon(); 
	private String msg;
	private String mode;
	private int invgridlength;
	private String formdetail;
	private String formdetailcode;
	private String periodupto;
	private String detail;
	private String detailname;
	
	public String getPeriodupto() {
		return periodupto;
	}


	public void setPeriodupto(String periodupto) {
		this.periodupto = periodupto;
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


	public int getInvgridlength() {
		return invgridlength;
	}


	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
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

	

	public String getDetail() {
		return detail;
	}


	public void setDetail(String detail) {
		this.detail = detail;
	}


	public String getDetailname() {
		return detailname;
	}


	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}


	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		ArrayList<String> agmtarray=new ArrayList<>();
		for(int i=0;i<getInvgridlength();i++){
			String temp=requestParams.get("testinvoice"+i)[0];
			agmtarray.add(temp);
		}
		java.sql.Date sqldate=null;
		if(!getPeriodupto().equalsIgnoreCase("") && getPeriodupto()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getPeriodupto());
		}
		if(getMode().equalsIgnoreCase("A")){
			int val=invoicedao.insert(agmtarray,sqldate,session,request,getPeriodupto());
			setDetail("Invoices");
			setDetailname("Daily Weekly Invoices");
			if(val>0){
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}
		}
		return "fail";
	}
}
