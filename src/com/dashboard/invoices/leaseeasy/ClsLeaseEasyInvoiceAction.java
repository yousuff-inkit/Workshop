package com.dashboard.invoices.leaseeasy;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import java.sql.*;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaseEasyInvoiceAction {

	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	ClsLeaseEasyInvoiceDAO objlease=new ClsLeaseEasyInvoiceDAO();
	
	private String selectedagmt;
	private String mode;
	private String hidclient;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbtype;
	private String periodupto;
	private String cmbbranch;

	public String getPeriodupto() {
		return periodupto;
	}
	public void setPeriodupto(String periodupto) {
		this.periodupto = periodupto;
	}
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public String getSelectedagmt() {
		return selectedagmt;
	}
	public void setSelectedagmt(String selectedagmt) {
		this.selectedagmt = selectedagmt;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
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
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	
		String mode=getMode();
		if(mode.equalsIgnoreCase("A")){
			java.sql.Date sqldate=null;
			if(!getPeriodupto().equalsIgnoreCase("") && getPeriodupto()!=null){
				sqldate=objcommon.changeStringtoSqlDate(getPeriodupto());
			}
			ArrayList<String> agmtarray=new ArrayList<>();
			String stragmtarry[]=getSelectedagmt().split(",");
			for(int i=0;i<stragmtarry.length;i++){
				System.out.println("Check Grid Values "+stragmtarry[i]);
				agmtarray.add(stragmtarry[i]);
			}
			int val=objlease.insert(getSelectedagmt(),getCmbtype(),getHidclient(),sqldate,getCmbbranch(),agmtarray,getPeriodupto(),session,request);
			setDetail("Invoices");
			setDetailname("Lease");
			if(val>0){
				Connection conn=null;
				conn=objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				String strsql="select voc_no from gl_invm where doc_no="+val;
				ResultSet rs=stmt.executeQuery(strsql);
				String vocno="";
				
				while(rs.next()){
					vocno=rs.getString("voc_no");
				}
				setMsg("Inv No "+vocno+" Successfully Generated");
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}
		}
		return "fail";
	}
	
}
