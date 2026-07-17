package com.workshop.workshopsetup.technician;

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

public class ClsTechnicianAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsTechnicianDAO technicianDAO= new ClsTechnicianDAO();
	ClsTechnicianBean bean;

	private int docno;
	private String techniciandate;
	private String code;
	private String name;
	private int txtaccno;
	private String txtaccname;
	private String hidtechniciandate;
	private String mode;
	private String delete;
	private String mobile;
	private String email;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String techstatus;
	private String hidacno;
	
	public String getHidacno() {
		return hidacno;
	}
	public void setHidacno(String hidacno) {
		this.hidacno = hidacno;
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getTechniciandate() {
		return techniciandate;
	}
	public void setTechniciandate(String techniciandate) {
		this.techniciandate = techniciandate;
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
	public int getTxtaccno() {
		return txtaccno;
	}
	public void setTxtaccno(int txtaccno) {
		this.txtaccno = txtaccno;
	}
	public String getTxtaccname() {
		return txtaccname;
	}
	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}
	public String getHidtechniciandate() {
		return hidtechniciandate;
	}
	public void setHidtechniciandate(String hidtechniciandate) {
		this.hidtechniciandate = techniciandate;
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
		
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		

		java.sql.Date technicianDate = ClsCommon.changeStringtoSqlDate(getTechniciandate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=technicianDAO.insert(getCode(),getName(), technicianDate,getHidacno(),session,getMode(),getMobile(),getEmail(),getFormdetailcode());
						//System.out.println(val);
						if(val>0){
							
							setCode(getCode());
							setName(getName());
							setHidtechniciandate(technicianDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setEmail(getEmail());
							setMode(getMode());
						    setDocno(val);
						    setHidacno(getHidacno());
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setCode(getCode());
							setName(getName());
							setHidtechniciandate(technicianDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setEmail(getEmail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setChkstatus("1");
							setMsg("Code Already Exists.");
							return "fail";
						}
						else if(val==-2){
							setCode(getCode());
							setName(getName());
							setHidtechniciandate(technicianDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setEmail(getEmail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						else if(val==-3){
							setCode(getCode());
							setName(getName());
							setHidtechniciandate(technicianDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setEmail(getEmail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setChkstatus("1");
							setMsg("Account Already Exists.");
							return "fail";
						}
						else{
							setCode(getCode());
							setName(getName());
							setHidtechniciandate(getTechniciandate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setEmail(getEmail());
							setMode(getMode());
						    setDocno(val);
							setHidacno(getHidacno());
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=technicianDAO.edit(getCode(),getName(),technicianDate,getHidacno(),session,getMode(),getDocno(),getMobile(),getEmail(),getFormdetailcode());
				System.out.println("kbdfkbdfjgb");
				System.out.println("jnfgjnf"+val);
				if(val>0){
					
					//session.getAttribute("BranchName");
					setCode(getCode());
					setName(getName());
					setHidtechniciandate(technicianDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setEmail(getEmail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setCode(getCode());
					setName(getName());
					setHidtechniciandate(technicianDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setEmail(getEmail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(val==-2){
					setCode(getCode());
					setName(getName());
					setHidtechniciandate(technicianDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setEmail(getEmail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(val==-3){
					setCode(getCode());
					setName(getName());
					setHidtechniciandate(technicianDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setEmail(getEmail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setChkstatus("2");
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{
					setCode(getCode());
					setName(getName());
					setHidtechniciandate(getTechniciandate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setEmail(getEmail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=technicianDAO.delete(getCode(),getName(),technicianDate,getTxtaccno(),session,getMode(),getDocno(),getMobile(),getEmail(),getFormdetailcode());
			if(Status){
				setCode(getCode());
				setName(getName());
				setHidtechniciandate(technicianDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setEmail(getEmail());
				setDocno(getDocno());
				setMode(getMode());
				setHidacno(getHidacno());
				setDelete("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setHidacno(getHidacno());
				setCode(getCode());
				setName(getName());
				setHidtechniciandate(getTechniciandate());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setEmail(getEmail());
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
	}
	
		public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  try {
				  List <ClsTechnicianBean> list= technicianDAO.list();
				  for(ClsTechnicianBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.gettechniciandate().toString());
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
		}

}


