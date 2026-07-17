package com.humanresource.transactions.additionanddeduction;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 
public class ClsAdditionandDeductionAction {
	
	ClsCommon ClsCommon=new ClsCommon();

	private String  masterdate,hidmasterdate,refno, mode, deleted ,msg,formdetailcode,desc;
	private int cmbyear,hidcmbyear,cmbmonth,hidcmbmonth,docno,descdetailsGridlenght;
	
	ClsAdditionandDeductionDAO saveDAO= new ClsAdditionandDeductionDAO();
	ClsAdditionandDeductionBean viewDAO= new ClsAdditionandDeductionBean();
	
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
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
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
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getCmbyear() {
		return cmbyear;
	}
	public void setCmbyear(int cmbyear) {
		this.cmbyear = cmbyear;
	}
	public int getHidcmbyear() {
		return hidcmbyear;
	}
	public void setHidcmbyear(int hidcmbyear) {
		this.hidcmbyear = hidcmbyear;
	}
	public int getCmbmonth() {
		return cmbmonth;
	}
	public void setCmbmonth(int cmbmonth) {
		this.cmbmonth = cmbmonth;
	}
	public int getHidcmbmonth() {
		return hidcmbmonth;
	}
	public void setHidcmbmonth(int hidcmbmonth) {
		this.hidcmbmonth = hidcmbmonth;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getDescdetailsGridlenght() {
		return descdetailsGridlenght;
	}
	public void setDescdetailsGridlenght(int descdetailsGridlenght) {
		this.descdetailsGridlenght = descdetailsGridlenght;
	}

	public String saveAction() throws SQLException {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap(); 
		
		if(getMode().equalsIgnoreCase("A")) {
	 
			java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		
			ArrayList<String> comparray= new ArrayList<>();
			for(int i=0;i<getDescdetailsGridlenght();i++){
				String temp1=requestParams.get("test"+i)[0];
				comparray.add(temp1);
			}
   
			int val=saveDAO.insert(getDesc(),getCmbyear(),getCmbmonth(),masterdate,getRefno(),getFormdetailcode(),getMode(),request,session,comparray);
			if(val>0) {
				
				 setDocno(val);
				 setDesc(getDesc());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());
				 setHidmasterdate(masterdate.toString());
		        
				 setMsg("Successfully Saved");
				 return "success";
				 
			} else {
	 
				 setDesc(getDesc());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());
				 setHidmasterdate(masterdate.toString());
				  
				 setMsg("Not Saved");
				 return "fail";
				
			}
			
		}
		
		else if(getMode().equalsIgnoreCase("E")) {
	 
			 java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());

			 ArrayList<String> comparray= new ArrayList<>();
			 for(int i=0;i<getDescdetailsGridlenght();i++){
				 String temp1=requestParams.get("test"+i)[0];
				 comparray.add(temp1);
			 }

			 int val=saveDAO.update(getDocno(),getDesc(),getCmbyear(),getCmbmonth(),masterdate,getRefno(),getFormdetailcode(),getMode(),request,session,comparray);
					
			 if(val>0) {
						
					 setDocno(getDocno());
					 setDesc(getDesc());
					 setHidcmbyear(getCmbyear());
					 setHidcmbmonth(getCmbmonth());
					 setRefno(getRefno());
					 setHidmasterdate(masterdate.toString());
			         
					 setMsg("Updated Successfully");
					 return "success";
						
			  } else {
						 
					 setDocno(getDocno());
					 setDesc(getDesc());
					 setHidcmbyear(getCmbyear());
					 setHidcmbmonth(getCmbmonth());
					 setRefno(getRefno());
					 setHidmasterdate(masterdate.toString());
					  
			         setMsg("Not Updated");
				     return "fail";
						
			 }
		}
		
	 	else if(getMode().equalsIgnoreCase("D")) {
	 		 
		 	int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request); 
			if(val>0) {
				
				 setDocno(getDocno());
				 setDesc(getDesc());	
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());

				 setDeleted("DELETED");
				 setMsg("Successfully Deleted");
				 return "success";
			} else {
				 
				 setDocno(getDocno());
				 setDesc(getDesc());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setRefno(getRefno());
				 
				 setMsg("Not Deleted");
	             return "fail";
			}
		} 
		
	 	else if(mode.equalsIgnoreCase("View")){
	 		
			String branch=null;
			viewDAO=saveDAO.getViewDetails(session,getDocno());
			
			setMasterdate(viewDAO.getMasterdate());
			setRefno(viewDAO.getRefno());
			setHidcmbyear(viewDAO.getHidcmbyear());
			setHidcmbmonth(viewDAO.getHidcmbmonth());
			setDesc(viewDAO.getDesc());
			setFormdetailcode(viewDAO.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}

}
