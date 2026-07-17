package com.dashboard.workshop.releasevehicle;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsReleaseVehicleAction {
	ClsReleaseVehicleBean bean=new ClsReleaseVehicleBean();
	ClsReleaseVehicleDAO releasedao=new ClsReleaseVehicleDAO();
	
	private String lblcompanyname;
	
	
	private String lblcompname,lblcompaddress,lblprintname,lblcomptel,lblcompfax,lblprintname1,lblbranch,lbllocation;
	
	private String lbldate,lblmodel,lblrvehicleno,lbljobno,lbltype,lblcustomer,lblperson,lblchasisno,lblengineno,lblreleasedby,lbltodat;
	
	
	
	public String getLbldate() {
		return lbldate;
	}




	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}




	public String getLblmodel() {
		return lblmodel;
	}




	public void setLblmodel(String lblmodel) {
		this.lblmodel = lblmodel;
	}




	public String getLblrvehicleno() {
		return lblrvehicleno;
	}




	public void setLblrvehicleno(String lblrvehicleno) {
		this.lblrvehicleno = lblrvehicleno;
	}




	public String getLbljobno() {
		return lbljobno;
	}




	public void setLbljobno(String lbljobno) {
		this.lbljobno = lbljobno;
	}




	public String getLbltype() {
		return lbltype;
	}




	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}




	public String getLblcustomer() {
		return lblcustomer;
	}




	public void setLblcustomer(String lblcustomer) {
		this.lblcustomer = lblcustomer;
	}




	public String getLblperson() {
		return lblperson;
	}




	public void setLblperson(String lblperson) {
		this.lblperson = lblperson;
	}




	public String getLblchasisno() {
		return lblchasisno;
	}




	public void setLblchasisno(String lblchasisno) {
		this.lblchasisno = lblchasisno;
	}




	public String getLblengineno() {
		return lblengineno;
	}




	public void setLblengineno(String lblengineno) {
		this.lblengineno = lblengineno;
	}




	public String getLblreleasedby() {
		return lblreleasedby;
	}




	public void setLblreleasedby(String lblreleasedby) {
		this.lblreleasedby = lblreleasedby;
	}




	public String getLbltodat() {
		return lbltodat;
	}




	public void setLbltodat(String lbltodat) {
		this.lbltodat = lbltodat;
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




	public String getLblprintname() {
		return lblprintname;
	}




	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
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




	public String getLblprintname1() {
		return lblprintname1;
	}




	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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




	public String getLblcompanyname() {
		return lblcompanyname;
	}




	public void setLblcompanyname(String lblcompanyname) {
		this.lblcompanyname = lblcompanyname;
	}




	public String printAction() throws ParseException, SQLException,Exception{
		
		 try{
			 
			 HttpServletRequest request=ServletActionContext.getRequest();
			 HttpSession session=request.getSession();
			 String jobcarddocno=request.getParameter("jobcarddocno")==null?"0":request.getParameter("jobcarddocno");
			 bean=releasedao.getPrint(jobcarddocno);
			 setLblcompanyname("TEMPORARY RELEASE ORDER/VEHICLE");
			 setLblbranch(bean.getLblbranch());
			   setLblcompname(bean.getLblcompname());
			  
			   setLblcompaddress(bean.getLblcompaddress());
			   setLblcomptel(bean.getLblcomptel());
			   setLblcompfax(bean.getLblcompfax());
			   setLbllocation(bean.getLbllocation());
			  
			   setLblrvehicleno(bean.getLblrvehicleno());
			   setLbldate(bean.getLbldate());
	    	  setLbljobno(bean.getLbljobno());
	    	   setLbltype(bean.getLbltype());
	    	  setLblcustomer( bean.getLblcustomer());
	    	   setLblperson(bean.getLblperson());
	    	   setLblchasisno(bean.getLblchasisno());
	    	   setLblengineno(bean.getLblengineno());
	    	   setLbltodat(bean.getLbltodat());
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 return "print";
	}
}
