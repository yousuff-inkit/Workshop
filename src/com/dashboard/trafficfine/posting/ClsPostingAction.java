package com.dashboard.trafficfine.posting;


import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsPostingAction {

ClsCommon ClsCommon=new ClsCommon();
	
	ClsPostingDAO postingDAO=new ClsPostingDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String fromdate;
	private String hidfromdate;
	private String todate;
	private String hidtodate;
	private String cmbtype;
	private String hidcmbtype;
	private double txtdrtotal;
	private String txttrno;
	private int jvgridlength;
	
	private String date,hiddate;
	
	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
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

	public String getFromdate() {
		return fromdate;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getHidfromdate() {
		return hidfromdate;
	}

	public void setHidfromdate(String hidfromdate) {
		this.hidfromdate = hidfromdate;
	}

	public String getTodate() {
		return todate;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getHidtodate() {
		return hidtodate;
	}

	public void setHidtodate(String hidtodate) {
		this.hidtodate = hidtodate;
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

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public String getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(String txttrno) {
		this.txttrno = txttrno;
	}

	public int getJvgridlength() {
		return jvgridlength;
	}

	public void setJvgridlength(int jvgridlength) {
		this.jvgridlength = jvgridlength;
	}

	java.sql.Date dbFromDate;
	java.sql.Date dbToDate;
	java.sql.Date sqldates;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		dbFromDate = ClsCommon.changeStringtoSqlDate(getFromdate());
		dbToDate = ClsCommon.changeStringtoSqlDate(getTodate());
		sqldates= ClsCommon.changeStringtoSqlDate(getDate());
		if(mode.equalsIgnoreCase("A")){
			
			/*Journal Grid Saving*/
			ArrayList<String> postingarray= new ArrayList<String>();
			
			for(int i=0;i<getJvgridlength();i++){
				String posttemp=requestParams.get("test"+i)[0];
				postingarray.add(posttemp);
			}
			/*Journal Grid Saving Ends*/
			
			String[] tranarray = getTxttrno().split("::");
			
			
		//	System.out.println("----------tranarray------"+tranarray); 
			
			int val=postingDAO.insert(getCmbtype(),getTxtdrtotal(),tranarray,postingarray,session,request,mode,sqldates);
			if(val>0.0){
				setHiddate(sqldates.toString());
				setHidfromdate(dbFromDate.toString());
				setHidtodate(dbToDate.toString());
				setCmbtype(getCmbtype());
				setDetail("Accounts");
				setDetailname("Posting");
				setHidcmbtype(getCmbtype());
				setMsg("JV No. "+val+" Successfully Created");
				return "success";
			}
			else{
				setHiddate(sqldates.toString());
				setHidfromdate(dbFromDate.toString());
				setHidtodate(dbToDate.toString());
				setHidcmbtype(getCmbtype());
				setDetail("Accounts");
				setDetailname("Posting");
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


