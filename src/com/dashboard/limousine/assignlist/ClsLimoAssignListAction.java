package com.dashboard.limousine.assignlist;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsLimoAssignListAction extends ActionSupport{
    
	ClsLimoAssignListDAO limoassgnDAO= new ClsLimoAssignListDAO();
	ClsLimoAssignListBean limoassgnBean;
	
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
	}
	public String getLblcomptel() {
		return lblcomptel;
	}
	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}
	public String getLblcompfax() {
		return lblcompfax;
	}
	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	 
public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		
		//System.out.println("Action");
		
		String Type = request.getParameter("Type");
		String frmDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		String driver = request.getParameter("driver");
		String branch = request.getParameter("branch");
		
		limoassgnBean=limoassgnDAO.getPrint(request,branch,Type,frmDate,toDate,driver);
		setLblcompname(limoassgnBean.getLblcompname());
		setLblcompaddress(limoassgnBean.getLblcompaddress());
		setLblprintname(limoassgnBean.getLblprintname());
		setLblprintname1(limoassgnBean.getLblprintname1());
		setLblcomptel(limoassgnBean.getLblcomptel());
		setLblcompfax(limoassgnBean.getLblcompfax());
		setLblbranch(limoassgnBean.getLblbranch());
		setLbllocation(limoassgnBean.getLbllocation());
		
				
		
		
		
		return "print";
	}
}
	
	
	