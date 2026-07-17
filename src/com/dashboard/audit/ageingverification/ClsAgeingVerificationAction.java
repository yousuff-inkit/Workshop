package com.dashboard.audit.ageingverification;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsAgeingVerificationAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsAgeingVerificationDAO ageingVerificationDAO=new ClsAgeingVerificationDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String uptodate;
	private String hiduptodate;
	private String cmbtype;
	private String hidcmbtype;
	private int gridlength;

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

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getUptodate() {
		return uptodate;
	}

	public void setUptodate(String uptodate) {
		this.uptodate = uptodate;
	}

	public String getHiduptodate() {
		return hiduptodate;
	}

	public void setHiduptodate(String hiduptodate) {
		this.hiduptodate = hiduptodate;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date dbUpToDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		dbUpToDate = (getUptodate()==null || getUptodate().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getUptodate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/* Ageing Difference Grid Removing */
			ArrayList<String> ageingdifferencearray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				ageingdifferencearray.add(temp);
			}
			/* Ageing Difference Grid Removing Ends*/
			
			int val=ageingVerificationDAO.insert(getCmbbranch(),getCmbtype(),dbUpToDate,ageingdifferencearray,session,request,mode);
			if(val>0.0){
				setDetail("Audit");
				setDetailname("Ageing Verification");
				if(getUptodate()!=null && !(getUptodate().trim().equalsIgnoreCase(""))){
					setHiduptodate(dbUpToDate.toString());
				}
				setHidcmbtype(getCmbtype());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Audit");
				setDetailname("Ageing Verification");
				if(getUptodate()!=null && !(getUptodate().trim().equalsIgnoreCase(""))){
					setHiduptodate(dbUpToDate.toString());
				}
				setHidcmbtype(getCmbtype());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


