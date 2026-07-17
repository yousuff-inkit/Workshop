package com.dashboard.operations.replacelist;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsReplaceListAction {
	private String lblprintname;
	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;


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



	public String getLblprintname() {
		return lblprintname;
	}



	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}



	public String printAction() throws ParseException, SQLException{
		ClsReplaceListDAO ClsReplaceListDAO=new ClsReplaceListDAO();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		System.out.println("Here");
		String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
		String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
		String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
		String repstatus=request.getParameter("repstatus")==null?"":request.getParameter("repstatus");
		String repreason=request.getParameter("repreason")==null?"":request.getParameter("repreason");
		String reptype=request.getParameter("reptype")==null?"":request.getParameter("reptype");
		String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
		String agmtbranch=request.getParameter("agmtbranch")==null?"":request.getParameter("agmtbranch");
		String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
		String rentaltype=request.getParameter("rentaltype")==null?"":request.getParameter("rentaltype");
		String agmtstatus=request.getParameter("agmtstatus")==null?"":request.getParameter("agmtstatus");
		ClsReplaceListBean bean=new ClsReplaceListBean();
		bean=ClsReplaceListDAO.getPrintDetails(fromdate,todate,branch,repstatus,repreason,reptype,agmttype,agmtbranch,agmtno,rentaltype,agmtstatus);
		setLblprintname("Replacements of "+fromdate+" to "+todate);
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcomptel(bean.getLblcomptel());
		setLblcompfax(bean.getLblcompfax());
		setLblbranch(bean.getLblbranch());
		return "print";
	}
	
}
