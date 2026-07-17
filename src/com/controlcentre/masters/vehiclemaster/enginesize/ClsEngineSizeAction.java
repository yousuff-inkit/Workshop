package com.controlcentre.masters.vehiclemaster.enginesize;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsEngineSizeAction extends ActionSupport {
	ClsEngineSizeDAO engineDAO= new ClsEngineSizeDAO();
	ClsEngineSizeBean bean;
	private int docno;
	private String enginesize;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	
	
	
	public String getEnginesize() {
		return enginesize;
	}
	public void setEnginesize(String enginesize) {
		this.enginesize = enginesize;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public void setValues(int docno){
		setEnginesize(getEnginesize());
		setMode(getMode());
		setDocno(docno);
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		ClsEngineSizeBean bean=new ClsEngineSizeBean();
		if(mode.equalsIgnoreCase("A")){
			int val=engineDAO.insert(getEnginesize(),session,getMode(),getFormdetailcode());
			if(val>0.0){
				setValues(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1){
				setValues(val);
				setChkstatus("1");
				setMsg("Enginesize Already Exists");
				return "fail";
			}
			else{
				setValues(val);
				setMsg("Not Saved");
				return "fail";
			}	
		}


		else if(mode.equalsIgnoreCase("E")){
				int Status=engineDAO.edit(getEnginesize().trim(),getDocno(),getMode(),session,getFormdetailcode());
				if(Status>0){
					setValues(getDocno());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(Status==-1){
					setValues(getDocno());
					setChkstatus("2");
					setMsg("Enginesize Already Exists");
					return "fail";
				}
				else{
					setValues(getDocno());
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				//System.out.println(getDocno()+","+getUnit()+","+getUnitdesc());
				int Status=engineDAO.delete(getEnginesize(),getDocno(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setValues(getDocno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else if(Status==-2){
				setValues(getDocno());
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{
				setValues(getDocno());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}
}


