package com.dashboard.workshop.gateinvoice;

import java.sql.*;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.connection.*;
import com.common.*;
public class ClsGateInvoiceAction {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsGateInvoiceDAO invoicedao=new ClsGateInvoiceDAO();
	private String hidclient;
	private String hidgatedocno;
	private String invamount;
	private String fromdate;
	private String todate;
	private String msg;
	private String mode;
	private String detail;
	private String detailname;
	private String cmbbranch;
	
	
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}
	public String getHidgatedocno() {
		return hidgatedocno;
	}
	public void setHidgatedocno(String hidgatedocno) {
		this.hidgatedocno = hidgatedocno;
	}
	public String getInvamount() {
		return invamount;
	}
	public void setInvamount(String invamount) {
		this.invamount = invamount;
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
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		Connection conn =null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			String mode=getMode();
			if(mode.equalsIgnoreCase("A")){
				if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
					sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("") && todate!=null){
					sqltodate=objcommon.changeStringtoSqlDate(todate);
				}
				
				double amount=0.0;
				if(getInvamount().equalsIgnoreCase("")){
					amount=0.0;
				}
				else{
					amount=Double.parseDouble(getInvamount());
				}
				System.out.println("Action gatedocno"+getHidgatedocno());
				int val=invoicedao.gateInvoiceInsert(getHidclient(),getHidgatedocno(),sqlfromdate,sqltodate,amount,getCmbbranch(),session,request,conn);
				setDetail("Workshop");
				setDetailname("Gate Invoice");
				if(val>0){
					
					String voucherno=invoicedao.getVoucherNo(val,conn);
					setMsg("Successfully Generated Inv "+voucherno);
					conn.commit();
					return "success";
				}
				else{
					setMsg("Not Saved");
					return "fail";
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return "fail";
	}
}