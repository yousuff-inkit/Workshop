package com.dashboard.leaseagreement.paymentschedule;


import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class ClsPaymentSchedularAction extends ActionSupport{

	PaymentScheduleDAO pytdao=new PaymentScheduleDAO();
	
	private String msg;
	private String mode;
	private String detail;
	private String detailname;
	private int invgridlength;
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
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	
	public String saveAction() throws ParseException, SQLException{
		System.out.println("Inside Action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		if(mode.equalsIgnoreCase("A")){
			System.out.println("Inside Mode A");
			ArrayList<String> invoicearray= new ArrayList<>();
			for(int i=0;i<getInvgridlength();i++){
				String temp=requestParams.get("testinvoice"+i)[0];
				invoicearray.add(temp);
			}
			
			int val=pytdao.insert(invoicearray,session,request);
			if(val>0){
				setMsg("Successfully Invoiced");
				setDetail("Invoices");
				setDetailname("Lease");
				return "success";
			}
			else{
				setMsg("Not Invoiced");
				setDetail("Invoices");
				setDetailname("Lease");
				return "fail";
			}
		}
			return "fail";
		}
	}
