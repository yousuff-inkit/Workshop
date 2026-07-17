package com.limousine.jobassignment;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsJobAssignAction {
	ClsCommon objcommon=new ClsCommon();
	private int docno;
	private String uptodate;
	private String jobname;
	private String cmbprocess;
	private String hiddriver;
	private String fleetno;
	private String cmbtransferbranch;
	private String mode;
	private String msg;
	private String deleted;
	private int bookdocno;
	private int detaildocno;
	private String doctype;
	private String formdetail;
	private String formdetailcode; 
	private String vocno;
	private String brchName;
	private String type;
	private String cldocno;
	private String guestno;
	
	
	
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getCldocno() {
		return cldocno;
	}
	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}
	public String getGuestno() {
		return guestno;
	}
	public void setGuestno(String guestno) {
		this.guestno = guestno;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getVocno() {
		return vocno;
	}
	public void setVocno(String vocno) {
		this.vocno = vocno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getBookdocno() {
		return bookdocno;
	}
	public void setBookdocno(int bookdocno) {
		this.bookdocno = bookdocno;
	}
	public int getDetaildocno() {
		return detaildocno;
	}
	public void setDetaildocno(int detaildocno) {
		this.detaildocno = detaildocno;
	}
	public String getDoctype() {
		return doctype;
	}
	public void setDoctype(String doctype) {
		this.doctype = doctype;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getUptodate() {
		return uptodate;
	}
	public void setUptodate(String uptodate) {
		this.uptodate = uptodate;
	}
	public String getJobname() {
		return jobname;
	}
	public void setJobname(String jobname) {
		this.jobname = jobname;
	}
	public String getCmbprocess() {
		return cmbprocess;
	}
	public void setCmbprocess(String cmbprocess) {
		this.cmbprocess = cmbprocess;
	}
	public String getHiddriver() {
		return hiddriver;
	}
	public void setHiddriver(String hiddriver) {
		this.hiddriver = hiddriver;
	}
	public String getFleetno() {
		return fleetno;
	}
	public void setFleetno(String fleetno) {
		this.fleetno = fleetno;
	}
	public String getCmbtransferbranch() {
		return cmbtransferbranch;
	}
	public void setCmbtransferbranch(String cmbtransferbranch) {
		this.cmbtransferbranch = cmbtransferbranch;
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
	
	public String saveAction() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		ClsJobAssignDAO jobdao=new ClsJobAssignDAO();
		java.sql.Date sqluptodate=null;
		if(getUptodate()!=null && !getUptodate().equalsIgnoreCase("") && !getUptodate().equalsIgnoreCase("undefined")){
			sqluptodate=objcommon.changeStringtoSqlDate(getUptodate());
		}
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
			
			int val=jobdao.insert(sqluptodate,getCmbprocess(),getHiddriver(),getFleetno(),getCmbtransferbranch(),getBookdocno(),getDetaildocno(),session,mode,getFormdetailcode(),getBrchName(),request,getType());
			if(val>0){
				setMsg("Successfully Saved");
				setFormdetail("Job Assignment");
				setFormdetailcode("LJA");
				return "success";
			}
			else{
				setMsg("Not Saved");
				setFormdetail("Job Assignment");
				setFormdetailcode("LJA");
				return "fail";
			}
		}
		return "fail";
	}
}
