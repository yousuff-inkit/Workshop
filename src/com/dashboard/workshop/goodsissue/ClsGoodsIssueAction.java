package com.dashboard.workshop.goodsissue;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsGoodsIssueAction {

	private String mode;
	private String detail;
	private String detailname;
	private String msg;
	private int partsgridlength;
	private String fromdate;
	private String todate;
	private String srvcdocno;
	private int brhid,locationid,cldocno,fleetno;
	
	
	
	public int getCldocno() {
		return cldocno;
	}

	public void setCldocno(int cldocno) {
		this.cldocno = cldocno;
	}

	public String getSrvcdocno() {
		return srvcdocno;
	}

	public void setSrvcdocno(String srvcdocno) {
		this.srvcdocno = srvcdocno;
	}

	public int getBrhid() {
		return brhid;
	}

	public void setBrhid(int brhid) {
		this.brhid = brhid;
	}

	public int getLocationid() {
		return locationid;
	}

	public void setLocationid(int locationid) {
		this.locationid = locationid;
	}

	public int getFleetno() {
		return fleetno;
	}

	public void setFleetno(int fleetno) {
		this.fleetno = fleetno;
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

	public int getPartsgridlength() {
		return partsgridlength;
	}

	public void setPartsgridlength(int partsgridlength) {
		this.partsgridlength = partsgridlength;
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

	ClsGoodsIssueDAO issuedao=new ClsGoodsIssueDAO();
	ClsCommon objcommon=new ClsCommon();
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		ArrayList<String> partsarray=new ArrayList<>();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!getFromdate().equalsIgnoreCase("") && !getFromdate().equalsIgnoreCase("undefined") && getFromdate()!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
		}
		if(!getTodate().equalsIgnoreCase("") && !getTodate().equalsIgnoreCase("undefined") && getTodate()!=null){
			sqltodate=objcommon.changeStringtoSqlDate(getTodate());
		}
		
		if(mode.equalsIgnoreCase("A")){
			for(int i=0;i<getPartsgridlength();i++){
				String temp=requestParams.get("partsgrid"+i)[0];
				partsarray.add(temp);
			}
			int val=issuedao.insert(sqlfromdate,sqltodate,partsarray,session,request,mode,getSrvcdocno(),getBrhid(),getLocationid(),getCldocno(),getFleetno());
			setDetail("Workshop");
			setDetailname("Goods Issue");
			if(val>0){
				setMsg("Goods Issue Note "+val+" Generated");
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
