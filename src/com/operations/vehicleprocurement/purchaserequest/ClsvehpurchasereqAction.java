package com.operations.vehicleprocurement.purchaserequest;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;







@SuppressWarnings("serial")

public class ClsvehpurchasereqAction extends HttpServlet {
	ClsCommon ClsCommon=new ClsCommon();

	ClsvehpurchasereqDAO purchasereqDAO= new ClsvehpurchasereqDAO(); 
	ClsvehpurchasereqBean pintbean= new 	ClsvehpurchasereqBean(); 
	
		private String vehpurreqDate;
		private String hidvehpurreqDate,cmbreftype,vehexpDate,purdesc,hidvehexpDate,cmbreftypeval;
		private int  docno,vehreqgridlenght,masterdoc_no;
		
		private String deleted,mode,msg,formdetailcode,brchName;
	
	

		public String getVehpurreqDate() {
			return vehpurreqDate;
		}
		public void setVehpurreqDate(String vehpurreqDate) {
			this.vehpurreqDate = vehpurreqDate;
		}
		public String getHidvehpurreqDate() {
			return hidvehpurreqDate;
		}
		public void setHidvehpurreqDate(String hidvehpurreqDate) {
			this.hidvehpurreqDate = hidvehpurreqDate;
		}
		public String getCmbreftype() {
			return cmbreftype;
		}
		public void setCmbreftype(String cmbreftype) {
			this.cmbreftype = cmbreftype;
		}
		public String getVehexpDate() {
			return vehexpDate;
		}
		public void setVehexpDate(String vehexpDate) {
			this.vehexpDate = vehexpDate;
		}
		public String getPurdesc() {      
			return purdesc;
		}
		public void setPurdesc(String purdesc) {
			this.purdesc = purdesc;
		}
		public String getHidvehexpDate() {
			return hidvehexpDate;
		}
		public void setHidvehexpDate(String hidvehexpDate) {
			this.hidvehexpDate = hidvehexpDate;
		}
		public int getDocno() {
			return docno;
		}
		public void setDocno(int docno) {
			this.docno = docno;
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
	

		
	
		
		
		public String getBrchName() {
			return brchName;
		}
		public void setBrchName(String brchName) {
			this.brchName = brchName;
		}
		public String getCmbreftypeval() {
			return cmbreftypeval;
		}
		public void setCmbreftypeval(String cmbreftypeval) {
			this.cmbreftypeval = cmbreftypeval;
		}
		public int getVehreqgridlenght() {
			return vehreqgridlenght;
		}
		public void setVehreqgridlenght(int vehreqgridlenght) {
			this.vehreqgridlenght = vehreqgridlenght;
		}
		public String getFormdetailcode() {
			return formdetailcode;
		}
		public void setFormdetailcode(String formdetailcode) {
			this.formdetailcode = formdetailcode;
		}
		public String getDeleted() {
			return deleted;
		}
		public void setDeleted(String deleted) {
			this.deleted = deleted;
		}
		
	
		public int getMasterdoc_no() {
			return masterdoc_no;
		}
		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}
		
		
		
		
		//-------------------------------------------------------
		
		
		
		private String lbldate,lbltype,lbldesc1,expdeldate;
		
		private int lbldoc;
		
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
		
		//------------------------------------------------
		
		
		 public String getLbldate() {
				return lbldate;
			}
			public void setLbldate(String lbldate) {
				this.lbldate = lbldate;
			}
			public String getLbltype() {
				return lbltype;
			}
			public void setLbltype(String lbltype) {
				this.lbltype = lbltype;
			}
			public String getLbldesc1() {
				return lbldesc1;
			}
			public void setLbldesc1(String lbldesc1) {
				this.lbldesc1 = lbldesc1;
			}
			public int getLbldoc() {
				return lbldoc;
			}
			public void setLbldoc(int lbldoc) {
				this.lbldoc = lbldoc;
			}
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
			public String getLbllocation() {
				return lbllocation;
			}
			public void setLbllocation(String lbllocation) {
				this.lbllocation = lbllocation;
			}
			public String getLblprintname() {
				return lblprintname;
			}
			public void setLblprintname(String lblprintname) {
				this.lblprintname = lblprintname;
			}
		
	
		
		public String getExpdeldate() {
				return expdeldate;
			}
			public void setExpdeldate(String expdeldate) {
				this.expdeldate = expdeldate;
			}
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getVehpurreqDate());
			java.sql.Date sqlpurdeldate = ClsCommon.changeStringtoSqlDate(getVehexpDate());
			String mode=getMode();

//System.out.println("========="+getFormdetailcode());
			

	if(mode.equalsIgnoreCase("A")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getVehreqgridlenght();i++){
			String temp2=requestParams.get("vehreqtest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
		
			descarray.add(temp2);
		 
		}
		int val=purchasereqDAO.insert(sqlStartDate,sqlpurdeldate,getCmbreftype(),getPurdesc(),session,getMode(),getFormdetailcode(),descarray,request);
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0){
			//System.out.println("---------------"+val);
			setHidvehpurreqDate(sqlStartDate.toString());
			setHidvehexpDate(sqlpurdeldate.toString());
			setCmbreftypeval(getCmbreftype());
			
			setPurdesc(getPurdesc());
			setDocno(vdocno);
			setMasterdoc_no(val);
		
			setMsg("Successfully Saved");
			return "success";
		}
		else{
			
			setHidvehpurreqDate(sqlStartDate.toString());
			setHidvehexpDate(sqlpurdeldate.toString());
			setCmbreftypeval(getCmbreftype());
			
			setPurdesc(getPurdesc());
			setDocno(vdocno);
			setMasterdoc_no(val);
			setMsg("Not Saved");
			return "fail";
		}
	}

   
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getVehreqgridlenght();i++){
				String temp2=requestParams.get("vehreqtest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
			
				descarray.add(temp2);
			 
			}
			boolean Status=purchasereqDAO.edit(getMasterdoc_no(),sqlStartDate,sqlpurdeldate,getCmbreftype(),getPurdesc(),session,getMode(),getFormdetailcode(),descarray);
			if(Status){
				
				setHidvehpurreqDate(sqlStartDate.toString());
				setHidvehexpDate(sqlpurdeldate.toString());
				setCmbreftypeval(getCmbreftype());
				
				setPurdesc(getPurdesc());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
			
				setMsg("Updated Successfully");
				return "success";
			
			}
			else{
				
				setHidvehpurreqDate(sqlStartDate.toString());
				setHidvehexpDate(sqlpurdeldate.toString());
				setCmbreftypeval(getCmbreftype());
				
				setPurdesc(getPurdesc());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMsg("Not Updated");
				return "fail";
			}
		}
	else if(mode.equalsIgnoreCase("D")){
			boolean Status=purchasereqDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
		if(Status){
			setHidvehpurreqDate(sqlStartDate.toString());
			setHidvehexpDate(sqlpurdeldate.toString());
			setCmbreftypeval(getCmbreftype());
			setPurdesc(getPurdesc());
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setMsg("Not Deleted");
			return "fail";
		}
	
	}
	else if(mode.equalsIgnoreCase("view")){
		setHidvehpurreqDate(sqlStartDate.toString());
		setHidvehexpDate(sqlpurdeldate.toString());
	}

	
	
return "fail";	
	
}
		
	
		public String printAction() throws ParseException, SQLException{
				
			  HttpServletRequest request=ServletActionContext.getRequest();
			 
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 
			
			 pintbean=purchasereqDAO.getPrint(doc);
			 ArrayList<String> arraylist = purchasereqDAO.getPrintdetails(doc);
			 
			
			  //cl details
			 
			 setLblprintname("Vehicle Purchase Request");
			    setLbldoc(pintbean.getLbldoc());
	    	    setLbldate(pintbean.getLbldate());
	    	    setLbltype(pintbean.getLbltype());
	    	    setLbldesc1(pintbean.getLbldesc1());
	    	    
	    	    setExpdeldate(pintbean.getExpdeldate());
	    	    
			request.setAttribute("details",arraylist); 
			
			
			
		  setLblbranch(pintbean.getLblbranch());
		   setLblcompname(pintbean.getLblcompname());
		  
		  setLblcompaddress(pintbean.getLblcompaddress());
		 
		   setLblcomptel(pintbean.getLblcomptel());
		  
		  setLblcompfax(pintbean.getLblcompfax());
		   setLbllocation(pintbean.getLbllocation());
		  

	  	   
			 return "print";
			 }	
		
}
