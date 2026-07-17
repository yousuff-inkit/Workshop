package com.dashboard.leaseagreement.insurrefundclaim;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsInsurRefundAction extends ActionSupport{

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsInsurRefundDAO refunddao=new ClsInsurRefundDAO();
	private String fromdate,todate,griddate,refno,amount,tempamount,insurcomp,hidinsurcomp,expenseamount,expenseaccount,hidexpenseaccount,cmbbranch,mode,msg,detail,detailname,tranid;

	
	
	public String getTranid() {
		return tranid;
	}

	public void setTranid(String tranid) {
		this.tranid = tranid;
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

	public String getTempamount() {
		return tempamount;
	}

	public void setTempamount(String tempamount) {
		this.tempamount = tempamount;
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

	public String getGriddate() {
		return griddate;
	}

	public void setGriddate(String griddate) {
		this.griddate = griddate;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getInsurcomp() {
		return insurcomp;
	}

	public void setInsurcomp(String insurcomp) {
		this.insurcomp = insurcomp;
	}

	public String getHidinsurcomp() {
		return hidinsurcomp;
	}

	public void setHidinsurcomp(String hidinsurcomp) {
		this.hidinsurcomp = hidinsurcomp;
	}

	public String getExpenseamount() {
		return expenseamount;
	}

	public void setExpenseamount(String expenseamount) {
		this.expenseamount = expenseamount;
	}

	public String getExpenseaccount() {
		return expenseaccount;
	}

	public void setExpenseaccount(String expenseaccount) {
		this.expenseaccount = expenseaccount;
	}

	public String getHidexpenseaccount() {
		return hidexpenseaccount;
	}

	public void setHidexpenseaccount(String hidexpenseaccount) {
		this.hidexpenseaccount = hidexpenseaccount;
	}

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date sqlgridate=null;
		if(!getGriddate().equalsIgnoreCase("") && getGriddate()!=null){
			sqlgridate=objcommon.changeStringtoSqlDate(getGriddate());
		}
		if(mode.equalsIgnoreCase("A")){
			int val=refunddao.insert(getRefno(),sqlgridate,getAmount(),getHidinsurcomp(),getHidexpenseaccount(),getExpenseamount(),getMode(),getGriddate(),
				session,request,getTempamount(),getTranid());
			setDetail("Lease Agreement");
			setDetailname("Insurance Refund Claim");
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