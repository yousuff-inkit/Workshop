package com.controlcentre.masters.salesmanmaster.checkin;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsCheckinAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsCheckinDAO checkinDAO= new ClsCheckinDAO();
	ClsCheckinBean bean;

	private int docno;
	private String checkindate;
	private String code;
	private String name;
	private String txtaccno;
	private String txtaccname;
	private String hidcheckindate;
	private String mode;
	private String delete;
	private String mobile;
	private String mail;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	private String hidacno;
	private String cmbactive;
	private String hidactive;
	private String cldocno,refname;
	
	
	
	public String getCldocno() {
		return cldocno;
	}
	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}
	public String getRefname() {
		return refname;
	}
	public void setRefname(String refname) {
		this.refname = refname;
	}
	public String getCmbactive() {
		return cmbactive;
	}
	public void setCmbactive(String cmbactive) {
		this.cmbactive = cmbactive;
	}
	public String getHidactive() {
		return hidactive;
	}
	public void setHidactive(String hidactive) {
		this.hidactive = hidactive;
	}
	public String getHidacno() {
		return hidacno;
	}
	public void setHidacno(String hidacno) {
		this.hidacno = hidacno;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCheckindate() {
		return checkindate;
	}
	public void setCheckindate(String checkindate) {
		this.checkindate = checkindate;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getTxtaccno() {
		return txtaccno;
	}
	public void setTxtaccno(String txtaccno) {
		this.txtaccno = txtaccno;
	}
	public String getTxtaccname() {
		return txtaccname;
	}
	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}
	public String getHidcheckindate() {
		return hidcheckindate;
	}
	public void setHidcheckindate(String hidcheckindate) {
		this.hidcheckindate = hidcheckindate;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDelete() {
		return delete;
	}
	public void setDelete(String delete) {
		this.delete = delete;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	
	public String saveAction() throws ParseException, SQLException{
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();

		java.sql.Date checkinDate = ClsCommon.changeStringtoSqlDate(getCheckindate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=checkinDAO.insert(getCode(),getName(),checkinDate,getHidacno(),session,getMode(),getMobile(),getMail(),getFormdetailcode(),getCmbactive(),getCldocno());
						if(val>0){
							
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
						    setDocno(val);
						    setHidacno(getHidacno());
						    setCmbactive(getCmbactive());
							setHidactive(getCmbactive());
							setCldocno(getCldocno());
							setRefname(getRefname());
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setCmbactive(getCmbactive());
							setHidactive(getCmbactive());
							setChkstatus("1");
							setCldocno(getCldocno());
							setRefname(getRefname());
							setMsg("Code Already Exists.");
							return "fail";
						}
						else if(val==-2){
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setCmbactive(getCmbactive());
							setHidactive(getCmbactive());
							setChkstatus("1");
							setCldocno(getCldocno());
							setRefname(getRefname());
							setMsg("Name Already Exists.");
							return "fail";
						}
						else if(val==-3){
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setCmbactive(getCmbactive());
							setHidactive(getCmbactive());
							setChkstatus("1");
							setCldocno(getCldocno());
							setRefname(getRefname());
							setMsg("Account Already Exists.");
							return "fail";
						}
						else{
							setCode(getCode());
							setName(getName());
							setHidcheckindate(getCheckindate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
						    setDocno(val);
							setHidacno(getHidacno());
							setCmbactive(getCmbactive());
							setHidactive(getCmbactive());
							setCldocno(getCldocno());
							setRefname(getRefname());
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=checkinDAO.edit(getCode(),getName(),checkinDate,getHidacno(),session,getMode(),getDocno(),getMobile(),getMail(),getFormdetailcode(),getCmbactive(),getCldocno());
				if(val>0){
					
					session.getAttribute("BranchName");
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setCmbactive(getCmbactive());
					setHidactive(getCmbactive());
					setCldocno(getCldocno());
					setRefname(getRefname());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setCmbactive(getCmbactive());
					setHidactive(getCmbactive());
					setChkstatus("2");
					setCldocno(getCldocno());
					setRefname(getRefname());
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(val==-2){
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setCmbactive(getCmbactive());
					setHidactive(getCmbactive());
					setChkstatus("2");
					setCldocno(getCldocno());
					setRefname(getRefname());
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(val==-3){
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setCmbactive(getCmbactive());
					setHidactive(getCmbactive());
					setChkstatus("2");
					setCldocno(getCldocno());
					setRefname(getRefname());
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{
					setCode(getCode());
					setName(getName());
					setHidcheckindate(getCheckindate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setCmbactive(getCmbactive());
					setHidactive(getCmbactive());
					setCldocno(getCldocno());
					setRefname(getRefname());
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=checkinDAO.delete(getCode(),getName(),checkinDate,getTxtaccno(),session,getMode(),getDocno(),getMobile(),getMail(),getFormdetailcode(),getCmbactive());
			if(Status){
				setCode(getCode());
				setName(getName());
				setHidcheckindate(checkinDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMail(getMail());
				setDocno(getDocno());
				setMode(getMode());
				setHidacno(getHidacno());
				setCmbactive(getCmbactive());
				setHidactive(getCmbactive());
				setCldocno(getCldocno());
				setRefname(getRefname());
				setDelete("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setHidacno(getHidacno());
				setCode(getCode());
				setName(getName());
				setHidcheckindate(getCheckindate());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMail(getMail());
				setDocno(getDocno());
				setMode(getMode());
				setCmbactive(getCmbactive());
				setHidactive(getCmbactive());
				setCldocno(getCldocno());
				setRefname(getRefname());
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
	}
	
		

}


