package com.dashboard.leaseagreement.depreciationcostrecognization;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsDepreciationCostRecognizationAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsDepreciationCostRecognizationDAO depreciationcostrecognizationDAO=new ClsDepreciationCostRecognizationDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private int docno;
	private String uptodate;
	private String hiduptodate;
	private String txtgridload;
	private String txtchkgridload;
	private String txtchkdate;
	private int gridlength;
	private String txtselecteddocs;
	private double txtdeprtotal;
	
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

	public String getHiduptodate() {
		return hiduptodate;
	}

	public void setHiduptodate(String hiduptodate) {
		this.hiduptodate = hiduptodate;
	}

	public String getTxtgridload() {
		return txtgridload;
	}

	public void setTxtgridload(String txtgridload) {
		this.txtgridload = txtgridload;
	}

	public String getTxtchkgridload() {
		return txtchkgridload;
	}

	public void setTxtchkgridload(String txtchkgridload) {
		this.txtchkgridload = txtchkgridload;
	}

	public String getTxtchkdate() {
		return txtchkdate;
	}

	public void setTxtchkdate(String txtchkdate) {
		this.txtchkdate = txtchkdate;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String getTxtselecteddocs() {
		return txtselecteddocs;
	}

	public void setTxtselecteddocs(String txtselecteddocs) {
		this.txtselecteddocs = txtselecteddocs;
	}

	public double getTxtdeprtotal() {
		return txtdeprtotal;
	}

	public void setTxtdeprtotal(double txtdeprtotal) {
		this.txtdeprtotal = txtdeprtotal;
	}

	java.sql.Date dbUpToDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		dbUpToDate = ClsCommon.changeStringtoSqlDate(getUptodate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Grid Saving*/
			ArrayList<String> depreciationcostrecognizationarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String posttemp=requestParams.get("test"+i)[0];
				depreciationcostrecognizationarray.add(posttemp);
			}
			/*Grid Saving Ends*/
			
			int val=depreciationcostrecognizationDAO.insert(getCmbbranch(),dbUpToDate,getTxtdeprtotal(),getTxtselecteddocs(),depreciationcostrecognizationarray,session,request,mode);
			if(val>0.0){
				setDetail("Lease Agreement");
				setDetailname("Depr. Cost Recognization");
				setHiduptodate(dbUpToDate.toString());
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Lease Agreement");
				setDetailname("Depr. Cost Recognization");
				setHiduptodate(dbUpToDate.toString());
				
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


