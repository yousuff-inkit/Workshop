package com.dashboard.operations.vehicleinsurancetermination;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsVehicleInsuranceTerminationAction {
	ClsVehicleInsuranceTerminationDAO termdao=new ClsVehicleInsuranceTerminationDAO();
	ClsCommon objcommon=new ClsCommon();
	private int invgridlength;
	private String mode;
	private String hidclient;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String expenseacno;
	private String uptodate;
	private String reverseacno;
	
	
	public String getReverseacno() {
		return reverseacno;
	}
	public void setReverseacno(String reverseacno) {
		this.reverseacno = reverseacno;
	}
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
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
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public String getExpenseacno() {
		return expenseacno;
	}
	public void setExpenseacno(String expenseacno) {
		this.expenseacno = expenseacno;
	}
	public String getUptodate() {
		return uptodate;
	}
	public void setUptodate(String uptodate) {
		this.uptodate = uptodate;
	}	
	
	public String saveAction() throws ParseException, SQLException{
	//	System.out.println("Inside Action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ArrayList<String> invoicedoc= new ArrayList<>();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ArrayList<String> insurarray=new ArrayList<>();
		for(int i=0;i<getInvgridlength();i++){
			String temp=requestParams.get("testinsurance"+i)[0];
			System.out.println(temp);
			insurarray.add(temp);
		}
		
		java.sql.Date sqluptodate=null;
		if(!getUptodate().equalsIgnoreCase("") && getUptodate()!=null){
			sqluptodate=objcommon.changeStringtoSqlDate(getUptodate());
		}
		if(mode.equalsIgnoreCase("A")){
			int val=termdao.insert(insurarray,getExpenseacno(),getReverseacno(),sqluptodate,getUptodate(),session,request);
			if(val>0){
				setDetail("Operations");
				setDetailname("Vehicle Insurance Termination");
				setMsg("Successfully Terminated");
				return "success";
			}
			else{
				setDetail("Operations");
				setDetailname("Vehicle Insurance Termination");
				setMsg("Not Terminated");
				return "fail";
			}
		}
		return "fail";
	}
	
}
