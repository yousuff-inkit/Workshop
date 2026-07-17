package com.dashboard.audit.userroledetailed;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.guideline.ClsGuidelineDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsUserRoleAction extends ActionSupport{

	ClsUserRoleDAO userRoleDAO= new ClsUserRoleDAO();
	ClsUserRoleBean userrolebean;

	private int txtuserroledocno;
	private String chkstatus;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String txtrolename;
	private String txtemail;
	private String txtusername;
	
	public String getTxtusername() {
		return txtusername;
	}

	public void setTxtusername(String txtusername) {
		this.txtusername = txtusername;
	}

	//User Role Grid
	private int gridlength;
	
	private int gridlengths;

	public int getGridlengths() {
		return gridlengths;
	}

	public void setGridlengths(int gridlengths) {
		this.gridlengths = gridlengths;
	}

	public int getTxtuserroledocno() {
		return txtuserroledocno;
	}

	public void setTxtuserroledocno(int txtuserroledocno) {
		this.txtuserroledocno = txtuserroledocno;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getTxtrolename() {
		return txtrolename;
	}

	public void setTxtrolename(String txtrolename) {
		this.txtrolename = txtrolename;
	}
	
	public String getTxtemail() {
		return txtemail;
	}

	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String saveAction() throws ParseException, SQLException
	{
		String result="";
		ClsUserRoleDAO userroleeDAO= new ClsUserRoleDAO();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		String formcode="";
		formcode=session.getAttribute("Code").toString();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		
		if(mode.equalsIgnoreCase("A")){
			
			/*User Role Grid*/
			ArrayList<String> userrolearray= new ArrayList<>();
			ArrayList<String> userRoleGridLoadingBean= new ArrayList<>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				userrolearray.add(temp);
			}
			for(int i=0;i<getGridlengths();i++){
				String temp=requestParams.get("test1"+i)[0];
				userRoleGridLoadingBean.add(temp);
			}
								
			int val=userRoleDAO.insert(getTxtrolename(),getTxtemail(),getFormdetailcode(),userrolearray,userRoleGridLoadingBean,session,request,mode);
			if(val>0.0){
				
				setTxtuserroledocno(val);
				setTxtrolename(getTxtrolename());
				setTxtemail(getTxtemail());
				
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1)
			   {
				setTxtrolename(getTxtrolename());
				setTxtemail(getTxtemail());
				setChkstatus("1");
				setMsg("Role Already Exists");
			    return "fail";
			   }
			else{
				setTxtrolename(getTxtrolename());
				setTxtemail(getTxtemail());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
			
			/*User Role Grid*/
			ArrayList<String> userrolearray= new ArrayList<>();
			ArrayList<String> userRoleGridLoadingBean= new ArrayList<>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				userrolearray.add(temp);
			}
			for(int i=0;i<getGridlengths();i++){
				String temp=requestParams.get("test1"+i)[0];
				userRoleGridLoadingBean.add(temp);
			}
			
			
			
			int Status=userRoleDAO.edit(getFormdetailcode(),getTxtuserroledocno(),getTxtrolename(),getTxtemail(),userrolearray,userRoleGridLoadingBean,session,mode);
			if(Status>0){
				
				setTxtuserroledocno(getTxtuserroledocno());
				setTxtrolename(getTxtrolename());
				setTxtemail(getTxtemail());
				
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			   {
				setTxtuserroledocno(getTxtuserroledocno());
				setTxtrolename(getTxtrolename());
				setTxtemail(getTxtemail());
				setChkstatus("2");
				setMsg("Role Already Exists");
			    return "fail";
			}
			else{
				setTxtuserroledocno(getTxtuserroledocno());
				setTxtrolename(getTxtrolename());
				setTxtemail(getTxtemail());
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=userRoleDAO.delete(getTxtuserroledocno(),getFormdetailcode(),session);
		if(Status){
			
			setTxtuserroledocno(getTxtuserroledocno());
			setTxtrolename(getTxtrolename());
			setTxtemail(getTxtemail());
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setTxtuserroledocno(getTxtuserroledocno());
			setTxtrolename(getTxtrolename());
			setTxtemail(getTxtemail());
			setMsg("Not Deleted");
			return "fail";
		}
	  }
		return "fail";
    }
	
}
