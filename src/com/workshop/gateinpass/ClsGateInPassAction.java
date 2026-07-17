package com.workshop.gateinpass;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsGateInPassAction extends ActionSupport {

	ClsCommon objcommon=new ClsCommon();
	ClsGateInPassDAO gatedao=new ClsGateInPassDAO();
	ClsGateInPassBean gatebean=new ClsGateInPassBean();
	
	private int gridlength;
	private String docno,date,fleetno,fleetdetails,brchName,chkdriver,hidchkdriver,driver,hiddriver,indate,intime,inkm,cmbinfuel,remarks,serviceduekm,hidcmbinfuel,srvckm,lastsrvckm,cldocno,agmtno,agmtexist,clientdetails;
	private String mode,msg,deleted,formdetailcode;
	
	
	
	public String getAgmtexist() {
		return agmtexist;
	}

	public void setAgmtexist(String agmtexist) {
		this.agmtexist = agmtexist;
	}

	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getAgmtno() {
		return agmtno;
	}

	public void setAgmtno(String agmtno) {
		this.agmtno = agmtno;
	}

	public String getSrvckm() {
		return srvckm;
	}

	public void setSrvckm(String srvckm) {
		this.srvckm = srvckm;
	}

	public String getLastsrvckm() {
		return lastsrvckm;
	}

	public void setLastsrvckm(String lastsrvckm) {
		this.lastsrvckm = lastsrvckm;
	}

	public String getHidcmbinfuel() {
		return hidcmbinfuel;
	}

	public void setHidcmbinfuel(String hidcmbinfuel) {
		this.hidcmbinfuel = hidcmbinfuel;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFleetno() {
		return fleetno;
	}

	public void setFleetno(String fleetno) {
		this.fleetno = fleetno;
	}

	public String getFleetdetails() {
		return fleetdetails;
	}

	public void setFleetdetails(String fleetdetails) {
		this.fleetdetails = fleetdetails;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getChkdriver() {
		return chkdriver;
	}

	public void setChkdriver(String chkdriver) {
		this.chkdriver = chkdriver;
	}

	public String getHidchkdriver() {
		return hidchkdriver;
	}

	public void setHidchkdriver(String hidchkdriver) {
		this.hidchkdriver = hidchkdriver;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getHiddriver() {
		return hiddriver;
	}

	public void setHiddriver(String hiddriver) {
		this.hiddriver = hiddriver;
	}

	public String getIndate() {
		return indate;
	}

	public void setIndate(String indate) {
		this.indate = indate;
	}

	public String getIntime() {
		return intime;
	}

	public void setIntime(String intime) {
		this.intime = intime;
	}

	public String getInkm() {
		return inkm;
	}

	public void setInkm(String inkm) {
		this.inkm = inkm;
	}

	public String getCmbinfuel() {
		return cmbinfuel;
	}

	public void setCmbinfuel(String cmbinfuel) {
		this.cmbinfuel = cmbinfuel;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getServiceduekm() {
		return serviceduekm;
	}

	public void setServiceduekm(String serviceduekm) {
		this.serviceduekm = serviceduekm;
	}
	public void setData(int docno,java.sql.Date sqldate,java.sql.Date sqlindate){
		setDocno(docno+"");
		setDate(sqldate.toString());
		setIndate(sqlindate.toString());
		setFleetno(getFleetno());
		setFleetdetails(getFleetdetails());
		setHidchkdriver(getHidchkdriver());
		setDriver(getDriver());
		setHiddriver(getHiddriver());
		setIntime(getIntime());
		setInkm(getInkm());
		setCmbinfuel(getCmbinfuel());
		setRemarks(getRemarks());
		setServiceduekm(getServiceduekm());
		setHidcmbinfuel(getCmbinfuel());
		setCldocno(getCldocno());
		setAgmtno(getAgmtno());
		setClientdetails(getClientdetails());
		setAgmtexist(getAgmtexist());
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		
		if(!mode.equalsIgnoreCase("view")){
			java.sql.Date sqldate=null,sqlindate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(getDate());
			}
			if(getIndate()!=null && !getIndate().equalsIgnoreCase("")){
				sqlindate=objcommon.changeStringtoSqlDate(getIndate());
			}
			ArrayList<String> complaintarray=new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				complaintarray.add(temp);
			}
			
			if(mode.equalsIgnoreCase("A")){
				int insertval=gatedao.insert(sqldate,getFleetno(),getDriver(),getHidchkdriver(),getHiddriver(),sqlindate,getIntime(),getInkm(),getCmbinfuel(),
						getRemarks(),getServiceduekm(),complaintarray,session,request,mode,getFormdetailcode(),getBrchName(),getAgmtno(),getCldocno(),getAgmtexist());
				if(insertval>0){
					setData(insertval,sqldate,sqlindate);
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData(0,sqldate,sqlindate);
					setMsg("Not Saved");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
				boolean status=gatedao.edit(sqldate,getFleetno(),getDriver(),getHidchkdriver(),getHiddriver(),sqlindate,getIntime(),getInkm(),getCmbinfuel(),getRemarks(),getServiceduekm(),complaintarray,session,request,mode,getFormdetailcode(),getBrchName(),getDocno(),getAgmtno(),getCldocno(),getAgmtexist());
				if(status){
					setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setMsg("Updated Successfully");
					return "success";
				}
				else{
					setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				boolean status=gatedao.delete(getDocno(),getBrchName(),getMode(),session,request);
				if(status){
					setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setMsg("Successfully Deleted");
					return "success";
				}
				else{
					setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		}
	return "fail";
	}
	 
}
