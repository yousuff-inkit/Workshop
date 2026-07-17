package com.operations.marketing.leasecostgroup;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import com.common.ClsCommon;
public class ClsleaseCostGroupAction {

	ClsCommon commDAO=new ClsCommon();
	private String masterdate,hidmasterdate,groupname,brandname,modelname,desc,msg, mode, deleted,formdetailcode;
	private int brandid, modelid, docno,groupid;
	
	
	
	public int getGroupid() {
		return groupid;
	}


	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}


	public String getFormdetailcode() {
		return formdetailcode;
	}


	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}


	public String getMasterdate() {
		return masterdate;
	}


	public void setMasterdate(String masterdate) {     
		this.masterdate = masterdate;
	}


	public String getHidmasterdate() {
		return hidmasterdate;
	}


	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}


	public String getGroupname() {
		return groupname;
	}


	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}


	public String getBrandname() {
		return brandname;
	}


	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}


	public String getModelname() {
		return modelname;
	}


	public void setModelname(String modelname) {
		this.modelname = modelname;
	}


	public String getDesc() {
		return desc;
	}


	public void setDesc(String desc) {     
		this.desc = desc;
	}


	public String getMsg() {
		return msg;
	}


	public void setMsg(String msg) {
		this.msg = msg;
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


	public int getBrandid() {
		return brandid;
	}


	public void setBrandid(int brandid) {
		this.brandid = brandid;
	}


	public int getModelid() {
		return modelid;
	}


	public void setModelid(int modelid) {
		this.modelid = modelid;
	}


	public int getDocno() {
		return docno;
	}


	public void setDocno(int docno) {
		this.docno = docno;
	}


	ClsleaseCostGroupDAO saveDAO= new ClsleaseCostGroupDAO();
	
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
       HttpSession session=request.getSession();
  java.sql.Date mastedate=null;
  if(getMode().equalsIgnoreCase("A") || getMode().equalsIgnoreCase("E"))
  {
	  
	  
	 mastedate = commDAO.changeStringtoSqlDate(getMasterdate());
	  
  }
       
  if(getMode().equalsIgnoreCase("A"))
	 {   
    int val= saveDAO.Insert(mastedate,getGroupid(),getBrandid(),getModelid(),getMode(),getDesc(),session,request,getFormdetailcode());
       
    if(val>0)
    {
    	setGroupid(getGroupid());
    	setGroupname(getGroupname());
    	setBrandid(getBrandid());
    	setModelid(getModelid());
    	setDesc(getDesc());
    	setModelname(getModelname());
    	setBrandname(getBrandname());
    	 setDocno(val); 
    	 setHidmasterdate(masterdate.toString());
    	 setMsg("Successfully Saved");
		 return "success";
   }
    
    else
    {
    	
    	setGroupid(getGroupid());
    	setGroupname(getGroupname());
    	setBrandid(getBrandid());
    	setModelid(getModelid());
    	setDesc(getDesc());
    	setModelname(getModelname());
    	setBrandname(getBrandname());
     
		setMsg("Not Saved");
		return "fail";
    }
	 }	 
    	 else if(getMode().equalsIgnoreCase("E"))
    	 {
    		 int val= saveDAO.update(getDocno(),mastedate,getGroupid(),getBrandid(),getModelid(),getMode(),getDesc(),session,request,getFormdetailcode());
       	  
    	    	if(val>0)
    	    	{ 
    	    		setGroupid(getGroupid());
    		   setGroupname(getGroupname());
    	    	setBrandid(getBrandid());
    	    	setModelid(getModelid());
    	    	setDesc(getDesc());
    	    	setModelname(getModelname());
    	    	setBrandname(getBrandname());
    	    	
    		 setDocno(getDocno()); 
    		 setHidmasterdate(masterdate.toString());
    		 setMsg("Updated Successfully");
				return "success";
    	    	}
    	    	else
    	    	{
    	    		    setGroupid(getGroupid());
    	    		    setGroupname(getGroupname());
    	    	    	setBrandid(getBrandid());
    	    	    	setModelid(getModelid());
    	    	    	setDesc(getDesc());
    	    	    	setModelname(getModelname());
    	    	    	setBrandname(getBrandname());
    	    	    	setDocno(getDocno()); 
    	        		setMsg("Not Updated");
    	    			return "fail";
    	    		
    	    	}
    		 
    	 }
  
  
  
    else if(getMode().equalsIgnoreCase("D"))
        	 {
    	  int val= saveDAO.delete(getDocno(),getMode(),session,request,getFormdetailcode());
    	  
    	if(val>0)
    	{
    	setGroupid(getGroupid());  
    	setGroupname(getGroupname());
    	setBrandid(getBrandid());
    	setModelid(getModelid());
    	setDesc(getDesc());
    	setModelname(getModelname());
    	setBrandname(getBrandname());
    	setDocno(getDocno());  
    	setDeleted("DELETED");
 		setMsg("Successfully Deleted");
 		return "success";
        	 }
    	
     
    else
    {
    	setGroupid(getGroupid());
    	setGroupname(getGroupname());
    	setBrandid(getBrandid());
    	setModelid(getModelid());
    	setDesc(getDesc());
    	setModelname(getModelname());
    	setBrandname(getBrandname());
    	setDocno(getDocno()); 
    	setMsg("Not Deleted");
		return "fail";
     }
   	
    	
    }
       
       
       
       
       
       
       
       
return "fail";

	}
	
	
	
	
	
	
	
	
}
