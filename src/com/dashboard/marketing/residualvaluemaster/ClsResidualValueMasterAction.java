package com.dashboard.marketing.residualvaluemaster;

import com.common.ClsCommon;

import java.sql.*;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
public class ClsResidualValueMasterAction {

	ClsCommon objcommon=new ClsCommon();
	ClsResidualValueMasterDAO masterdao=new ClsResidualValueMasterDAO();
	private String date,cmbbranch,mode,msg,detail,detailname,hidbrand,hidmodel,hidyom;
	private int gridlength;
	
	
	public String getHidbrand() {
		return hidbrand;
	}
	public void setHidbrand(String hidbrand) {
		this.hidbrand = hidbrand;
	}
	public String getHidmodel() {
		return hidmodel;
	}
	public void setHidmodel(String hidmodel) {
		this.hidmodel = hidmodel;
	}
	public String getHidyom() {
		return hidyom;
	}
	public void setHidyom(String hidyom) {
		this.hidyom = hidyom;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		setDetail("Marketing");
		setDetailname("Residual Value Master");
		ArrayList<String> masterarray=new ArrayList<>();
		for(int i=0;i<getGridlength();i++){
			String temp=requestParams.get("test"+i)[0];
			masterarray.add(temp);
		}
		java.sql.Date sqldate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(mode.equalsIgnoreCase("Add")){
			int val=masterdao.insert(session,masterarray,getCmbbranch(),sqldate,getHidbrand(),getHidmodel(),getHidyom());
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
