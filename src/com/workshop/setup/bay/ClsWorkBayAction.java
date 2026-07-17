package com.workshop.setup.bay;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsWorkBayAction {
	
	
	ClsCommon objcom=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	ClsWorkBayDAO baydao=new ClsWorkBayDAO();
	private String mode,msg,deleted,formdetailcode;
	private String date,  code, cmbjobtype,name,hidcmbjobtype;
	private int docno;
	
	
	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getHidcmbjobtype() {
		return hidcmbjobtype;
	}

	public void setHidcmbjobtype(String hidcmbjobtype) {
		this.hidcmbjobtype = hidcmbjobtype;
	}

	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCmbjobtype() {
		return cmbjobtype;
	}
	public void setCmbjobtype(String cmbjobtype) {
		this.cmbjobtype = cmbjobtype;
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



	public String saveAction() throws ParseException, SQLException{
		System.out.println("mode");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		System.out.println(mode);
		if(!mode.equalsIgnoreCase("view")){
			java.sql.Date sqldate=null,sqlindate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcom.changeStringtoSqlDate(getDate());
			}
			
			
			if(mode.equalsIgnoreCase("A")){
				int insertval=baydao.insert(getCode(),getName(),sqldate,getCmbjobtype(),getMode(),getFormdetailcode(),session,request);
				System.out.println("insertval"+insertval);
				if(insertval>0){
					//setData(insertval,sqldate,sqlindate);
					setDocno(insertval);
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					//setData(0,sqldate,sqlindate);
					setDocno(insertval);
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Not Saved");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
				boolean status=baydao.edit(getCode(),getName(),sqldate,getDocno(),getCmbjobtype(),getMode(),getFormdetailcode(),session,request);
				if(status){
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setHidcmbjobtype(getCmbjobtype());
					setDate(sqldate.toString());
					setMsg("Updated Successfully");
					return "success";
				}
				else{
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Not Updated");
					return "fail";
				}
			}
			
			else if(mode.equalsIgnoreCase("D")){
				boolean status=baydao.delete(getDocno(),getMode(),session,request);
				if(status){
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
				}
				else{
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		}
	return "fail";
	
		
	}	
}
