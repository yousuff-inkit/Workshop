package com.sales.InventoryTransfer.physicalstockadjustment;
 
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

 





import com.common.ClsCommon;
 


public class ClsphysicalStockadjustmentAction {

	ClsphysicalStockadjustmentDAO DAO= new ClsphysicalStockadjustmentDAO();
	ClsphysicalStockadjustmentBean bean= new ClsphysicalStockadjustmentBean();
	ClsCommon ClsCommon=new ClsCommon();
 
	private String date;
	private String hiddate;
 
	private String docno;
 
 
 int brchNames1,hidbrchids;
 


	private String txtdescription;
	 
	private String formdetailcode;
	private String mode;
	private String msg;
	private String deleted;
	private int gridlength;
	 
	private int masterdoc_no;
 
	private String txtlocation;
	private int locationid;
	
 

 
	public int getBrchNames1() {
		return brchNames1;
	}
	public void setBrchNames1(int brchNames1) {
		this.brchNames1 = brchNames1;
	}
	public int getHidbrchids() {
		return hidbrchids;
	}
	public void setHidbrchids(int hidbrchids) {
		this.hidbrchids = hidbrchids;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
 
	public String getTxtlocation() {
		return txtlocation;
	}
	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}
	public int getLocationid() {
		return locationid;
	}
	public void setLocationid(int locationid) {
		this.locationid = locationid;
	}
	 
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	 
 
	 
	public String saveAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;
		try{


	 
			if(mode.equalsIgnoreCase("A")){
				ArrayList<String> prodarray= new ArrayList<>();
				 

				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("prodg"+i)[0];		
					prodarray.add(temp);
				}

			 
				
		     
				
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				val=DAO.insert(date,prodarray,session,request,getLocationid(),getBrchNames1(),getTxtdescription(),getMode(),getFormdetailcode(),getBrchNames1());
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					
					 
					setHiddate(date.toString());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setHidbrchids(getBrchNames1());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					  
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					
					
		 
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setHiddate(date.toString());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setHidbrchids(getBrchNames1());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					  
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					setMsg("Not Saved");
					returns="fail";
				}
			}
			if(mode.equalsIgnoreCase("view")){

				bean=DAO.getViewDetails(getMasterdoc_no(),session.getAttribute("BRANCHID").toString());
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());
				  setHiddate(date.toString());
				 setMasterdoc_no(getMasterdoc_no());
				 setDocno(getDocno());
			 
				 setHidbrchids(getHidbrchids());
				 
			//	setLocationid(bean.getLocationid());
				setTxtdescription(getTxtdescription());
				 
				setTxtlocation(getTxtlocation());
				
				
	 

				returns="success";
			}


			if(mode.equalsIgnoreCase("E")){
				ArrayList<String> prodarray= new ArrayList<>();
		 
				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("prodg"+i)[0];		
					prodarray.add(temp);
				}

				 
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				/*val=DAO.update(getDocno(),getMasterdoc_no(),date,getMode(),
						getFormdetailcode(),prodarray,termsarray,servarray,session,request);*/
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					 
					setHiddate(date.toString());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setHidbrchids(getBrchNames1());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					 
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					 
				
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setHiddate(date.toString());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
				 
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setHidbrchids(getBrchNames1());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					 
				
					setMsg("Not Updated");
					returns="fail";
				}
			}

		 

		}
		catch(Exception e){
			e.printStackTrace();
		}


		return returns;
	}

	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		
		 bean=DAO.getPrint(doc,request);
	  
		 
		
		  //cl details
		 /*
		    setLblprintname("Delivery Note");
		    setLbldoc(bean.getLbldoc());
		    setLbldate(bean.getLbldate());
		     setLblrefno(bean.getLblrefno());
		     setLbldesc1(bean.getLbldesc1());
		    
	 	      
  	     setLblpaytems(bean.getLblpaytems());
  	     setLbldelterms(bean.getLbldelterms());
  	     setLbltype(bean.getLbltype());
  	     setLblvendoeacc(bean.getLblvendoeacc());  
  	     setLblvendoeaccName(bean.getLblvendoeaccName());
		     setExpdeldate(bean.getExpdeldate());
	 
					
  	           setLbltotal(bean.getLbltotal());
	    	       setLblsubtotal(bean.getLblsubtotal());
				   setLblbranch(bean.getLblbranch());
				   setLblcompname(bean.getLblcompname());
				  
				   setLblcompaddress(bean.getLblcompaddress());
				   setLblcomptel(bean.getLblcomptel());
				   setLblcompfax(bean.getLblcompfax());
				   setLbllocation(bean.getLbllocation());
				  
				   setLblsalesPerson(bean.getLblsalesPerson());
				   
				   
				   setLbllocation1(bean.getLbllocation1());
				   setFirstarray(bean.getFirstarray());
				   
				   setSecarray(bean.getSecarray());
				     
		    	   setLblordervalue(bean.getLblordervalue());
		    	   setLblordervaluewords(bean.getLblordervaluewords());*/
		   
		 return "print";
		 }	
		
	
	
	
	
	
}
