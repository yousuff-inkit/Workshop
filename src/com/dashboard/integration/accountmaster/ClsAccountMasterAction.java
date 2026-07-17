package com.dashboard.integration.accountmaster;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsAccountMasterAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsAccountMasterDAO accountMasterDAO=new ClsAccountMasterDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String cmbaccounttype;
	private String hidcmbaccounttype;
	private String txtaccounts;
	private String txtaccountbrhid;
	
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

	public String getCmbaccounttype() {
		return cmbaccounttype;
	}

	public void setCmbaccounttype(String cmbaccounttype) {
		this.cmbaccounttype = cmbaccounttype;
	}

	public String getHidcmbaccounttype() {
		return hidcmbaccounttype;
	}

	public void setHidcmbaccounttype(String hidcmbaccounttype) {
		this.hidcmbaccounttype = hidcmbaccounttype;
	}

	public String getTxtaccounts() {
		return txtaccounts;
	}

	public void setTxtaccounts(String txtaccounts) {
		this.txtaccounts = txtaccounts;
	}
	
	public String getTxtaccountbrhid() {
		return txtaccountbrhid;
	}

	public void setTxtaccountbrhid(String txtaccountbrhid) {
		this.txtaccountbrhid = txtaccountbrhid;
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
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Account Master Grid Saving*/
			ArrayList<String> accountmasterarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				accountmasterarray.add(temp);
			}
			/*Account Master Grid Saving Ends*/
			
			String[] accountsarray = getTxtaccounts().split("::");
			String[] accountsbrhidarray = getTxtaccountbrhid().split("::");
			
			int val=accountMasterDAO.insert(getCmbbranch(),getTxtaccounts(),accountsarray,accountsbrhidarray,accountmasterarray,session,request,mode);
			if(val>0.0){
				setDetail("Integration");
				setDetailname("Account Master");
				setHidcmbaccounttype(getCmbaccounttype());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Integration");
				setDetailname("Account Master");
				setHidcmbaccounttype(getCmbaccounttype());
				setTxtaccounts(getTxtaccounts());
				setTxtaccountbrhid(getTxtaccountbrhid());
				setGridlength(getGridlength());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


