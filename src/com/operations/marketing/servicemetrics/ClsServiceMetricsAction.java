package com.operations.marketing.servicemetrics;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsServiceMetricsAction {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsServiceMetricsDAO srvcdao=new ClsServiceMetricsDAO();
	private String date;
	private int docno;
	private String tarifgroup;
	private String hidtarifgroup;
	private String insurpercent;
	private String tracker;
	private String regcost;
	private int gridlength;
	private String msg;
	private String mode;
	private String deleted;
	private String brchName;
	private String formdetailcode;
	private String insurexcess;
	private String exkmrate;
	
	
	
	public String getExkmrate() {
		return exkmrate;
	}
	public void setExkmrate(String exkmrate) {
		this.exkmrate = exkmrate;
	}
	public String getInsurexcess() {
		return insurexcess;
	}
	public void setInsurexcess(String insurexcess) {
		this.insurexcess = insurexcess;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getTarifgroup() {
		return tarifgroup;
	}
	public void setTarifgroup(String tarifgroup) {
		this.tarifgroup = tarifgroup;
	}
	public String getHidtarifgroup() {
		return hidtarifgroup;
	}
	public void setHidtarifgroup(String hidtarifgroup) {
		this.hidtarifgroup = hidtarifgroup;
	}
	public String getInsurpercent() {
		return insurpercent;
	}
	public void setInsurpercent(String insurpercent) {
		this.insurpercent = insurpercent;
	}
	public String getTracker() {
		return tracker;
	}
	public void setTracker(String tracker) {
		this.tracker = tracker;
	}
	public String getRegcost() {
		return regcost;
	}
	public void setRegcost(String regcost) {
		this.regcost = regcost;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	public void setData(java.sql.Date sqldate,int docno){
		setDate(sqldate.toString());
		setDocno(docno);
		setInsurpercent(getInsurpercent());
		setRegcost(getRegcost());
		setTracker(getTracker());
		setHidtarifgroup(getHidtarifgroup());
		setTarifgroup(getTarifgroup());
		setInsurexcess(getInsurexcess());
		setExkmrate(getExkmrate());
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqldate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		ArrayList<String> srvcarray=new ArrayList<>();
		if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E")){
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				srvcarray.add(temp);
			}			
		}

		if(mode.equalsIgnoreCase("A")){
			int val=srvcdao.insert(sqldate,getHidtarifgroup(),getInsurpercent(),getTracker(),getRegcost(),mode,getBrchName(),session,getFormdetailcode(),srvcarray,getInsurexcess(),getExkmrate());
			if(val<=0){
				setData(sqldate,val);
				setMsg("Not Saved");
				return "fail";
			}
			else{
				setData(sqldate,val);
				setMsg("Successfully Saved");
				return "success";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
			boolean status=srvcdao.edit(sqldate,getHidtarifgroup(),getInsurpercent(),getTracker(),getRegcost(),mode,getBrchName(),session,getDocno(),getFormdetailcode(),srvcarray,getInsurexcess(),getExkmrate());
			if(status){
				setData(sqldate,getDocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setData(sqldate,getDocno());
				setMsg("Not Updated");
				return "fail";
			}
			
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean status=srvcdao.delete(sqldate,getHidtarifgroup(),getInsurpercent(),getTracker(),getRegcost(),mode,getBrchName(),session,getDocno(),getFormdetailcode());
			if(status){
				setData(sqldate,getDocno());
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData(sqldate,getDocno());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		
		return "fail";
	}
}
