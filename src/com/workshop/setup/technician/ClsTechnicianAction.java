package com.workshop.setup.technician;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTechnicianAction {
	private String date, email, accountno, accountname, actualstdcost, name, mobile,hidaccdocno;
	private String mode,msg,deleted,formdetailcode;
	private int docno,technicianJoblength;
	
	
	public String getHidaccdocno() {
		return hidaccdocno;
	}
	public void setHidaccdocno(String hidaccdocno) {
		this.hidaccdocno = hidaccdocno;
	}
	public int getTechnicianJoblength() {
		return technicianJoblength;
	}
	public void setTechnicianJoblength(int technicianJoblength) {
		this.technicianJoblength = technicianJoblength;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getAccountno() {
		return accountno;
	}
	public void setAccountno(String accountno) {
		this.accountno = accountno;
	}
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	public String getActualstdcost() {
		return actualstdcost;
	}
	public void setActualstdcost(String actualstdcost) {
		this.actualstdcost = actualstdcost;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
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
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	
	ClsCommon objcom=new ClsCommon();
	
	ClsTechnicianDAO techdao=new ClsTechnicianDAO();
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		if(!mode.equalsIgnoreCase("view")){
			java.sql.Date sqldate=null,sqlindate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcom.changeStringtoSqlDate(getDate());
			}
			Map<String, String[]> requestParams = request.getParameterMap();
			
			if(mode.equalsIgnoreCase("A")){ 
				//System.out.println(requestParams.get("jobgidid"));
				/*  Tech Job Grid  Saving*/
				ArrayList<String> technicianjobarray= new ArrayList<String>();
				for(int i=0;i<getTechnicianJoblength();i++){
					String temp1=requestParams.get("jobgidid"+i)[0];
					technicianjobarray.add(temp1);
				}
				/* Tech Job Grid  Saving Ends*/
				
				
				
				int insertval=techdao.insert(getName(),sqldate,getHidaccdocno(),getMobile(),getEmail(), getActualstdcost(),technicianjobarray,getFormdetailcode(),session,request);
				if(insertval>0){
					//setData(insertval,sqldate,sqlindate);
					setDocno(insertval);
					setDate(sqldate.toString());
					System.out.println("getHidaccdocno="+getHidaccdocno());
					setHidaccdocno(getHidaccdocno());
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					//setData(0,sqldate,sqlindate);
					setDocno(insertval);
					setDate(sqldate.toString());
					setHidaccdocno(getHidaccdocno());
					setMsg("Not Saved");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
				
				ArrayList<String> technicianjobarray= new ArrayList<String>();
				for(int i=0;i<getTechnicianJoblength();i++){
					String temp1=requestParams.get("jobgidid"+i)[0];
					technicianjobarray.add(temp1);
				}
				boolean status=techdao.edit(getDocno(),getName(),sqldate,getHidaccdocno(),getMobile(),getEmail(),
						getActualstdcost(),technicianjobarray,getFormdetailcode(),session,request);
				if(status){
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					setHidaccdocno(getHidaccdocno());
					setMsg("Updated Successfully");
					return "success";
				}
				else{
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					  setDocno(getDocno());
					setDate(sqldate.toString());
					setHidaccdocno(getHidaccdocno());
					setMsg("Not Updated");
					return "fail";
				}
			}
			
			else if(mode.equalsIgnoreCase("D")){
				boolean status=techdao.delete(getDocno(),getMode(),session,request);
				if(status){
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					return "success";
				}
				else{
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		}
	return "fail";
	
		
	}	

}
