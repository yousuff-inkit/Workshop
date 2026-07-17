package com.workshop.workshopsetup.bay;

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

public class ClsBayAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsBayDAO bayDAO= new ClsBayDAO();
	ClsBayBean bean;

	private int docno;
	
	private String baydate;
	private String code;
	private String name;
	
	
	private String hidbaydate;
	private String mode;
	private String delete;
	
	
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String techstatus;
	
	
	
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
	
	
	
	public String getBaydate() {
		return baydate;
	}
	public void setBaydate(String baydate) {
		this.baydate = baydate;
	}
	public String getHidbaydate() {
		return hidbaydate;
	}
	public void setHidbaydate(String hidbaydate) {
		this.hidbaydate = hidbaydate;
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
	public String getTechstatus() {
		return techstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.techstatus = techstatus;
	}
	
	public String saveAction() throws ParseException, SQLException{
		System.out.println("bfbfugg");
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		

		java.sql.Date bayDate = ClsCommon.changeStringtoSqlDate(getBaydate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=bayDAO.insert(getCode(),getName(), bayDate,session,getMode(),getFormdetailcode());
						//System.out.println(val);
						if(val>0){
							
							setCode(getCode());
							setName(getName());
							setHidbaydate(bayDate.toString());
							
							setMode(getMode());
						    setDocno(val);
						    
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setCode(getCode());
							setName(getName());
							setHidbaydate(bayDate.toString());
							setDocno(getDocno());
							setMode(getMode());
							
							setChkstatus("1");
							setMsg("Code Already Exists.");
							return "fail";
						}
						else if(val==-2){
							setCode(getCode());
							setName(getName());
							setHidbaydate(bayDate.toString());
							
							setDocno(getDocno());
							setMode(getMode());
							
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						else if(val==-3){
							setCode(getCode());
							setName(getName());
							setHidbaydate(bayDate.toString());
							
							setDocno(getDocno());
							setMode(getMode());
							;
							setChkstatus("1");
							setMsg("Account Already Exists.");
							return "fail";
						}
						else{
							setCode(getCode());
							setName(getName());
							setHidbaydate(getBaydate());
							
							setMode(getMode());
						    setDocno(val);
							
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=bayDAO.edit(getCode(),getName(),bayDate,session,getMode(),getDocno(),getFormdetailcode());
				System.out.println("kbdfkbdfjgb");
				System.out.println("jnfgjnf"+val);
				if(val>0){
					
					//session.getAttribute("BranchName");
					setCode(getCode());
					setName(getName());
					setHidbaydate(bayDate.toString());
					
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setCode(getCode());
					setName(getName());
					setHidbaydate(bayDate.toString());
					
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(val==-2){
					setCode(getCode());
					setName(getName());
					setHidbaydate(bayDate.toString());
					
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(val==-3){
					setCode(getCode());
					setName(getName());
					setHidbaydate(bayDate.toString());
					
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{
					setCode(getCode());
					setName(getName());
					setHidbaydate(getBaydate());
					
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=bayDAO.delete(getCode(),getName(),bayDate,session,getMode(),getDocno(),getFormdetailcode());
			if(Status){
				setCode(getCode());
				setName(getName());
				setHidbaydate(bayDate.toString());
				
				setDocno(getDocno());
				setMode(getMode());
				
				setDelete("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				
				setCode(getCode());
				setName(getName());
				setHidbaydate(getBaydate());
				
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
	}
	
		/*public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  try {
				  List <ClsBayBean> list= technicianDAO.list();
				  for(ClsBayBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.getbaydate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				  cellobj.put("mobile",bean.getMobile());
				  cellobj.put("email", bean.getEmail());
				  cellobj.put("acdoc", bean.getHidacno());
				  cellarray.add(cellobj);
				 }
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}*/

}


