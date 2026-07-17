package com.dashboard.vehicle.vehiclepickup;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;


public class ClsVehiclePickUpAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

ClsVehiclePickUpDAO pickupdao=new ClsVehiclePickUpDAO();

private String agmtvocno;
private String agmtno;
private String cldocno;

private String indate;
private String intime;
private String inkm;
private String cmbinfuel;
private String cmbtype;
private String fleet_no;
private String mode;
private String msg;
private String deleted;
private String cmbbranch;
private String detail;
private String detailname;
private int docno;
private String pickdesc;

private String companyname,address,mobileno,fax,location,barnchval;
private String lblagmtbranch,lbldocno,lblagmtloc,lbldate,lblagmttype,lblvrano,lblfleet_no,lblflname,lblvradate,lblregno,lblclientacno,lblrefname,lblstartdate,
lblstarttime,lblstartkm,lblstartfuel,lblpdate,lblptime,lblpfuel,lblpkm,lbldrivenby,lbldescription,lblpickbranch,lblpicklocation,lblpickdesc,lblagmtdesc;

		
public String getPickdesc() {
	return pickdesc;
}
public void setPickdesc(String pickdesc) {
	this.pickdesc = pickdesc;
}
	
public String getLblagmtdesc() {
	return lblagmtdesc;
}
public void setLblagmtdesc(String lblagmtdesc) {
	this.lblagmtdesc = lblagmtdesc;
}
public String getLblpickdesc() {
	return lblpickdesc;
}
public void setLblpickdesc(String lblpickdesc) {
	this.lblpickdesc = lblpickdesc;
}
public String getCompanyname() {
	return companyname;
}
public void setCompanyname(String companyname) {
	this.companyname = companyname;
}
public String getAddress() {
	return address;
}
public void setAddress(String address) {
	this.address = address;
}
public String getMobileno() {
	return mobileno;
}
public void setMobileno(String mobileno) {
	this.mobileno = mobileno;
}
public String getFax() {
	return fax;
}
public void setFax(String fax) {
	this.fax = fax;
}
public String getLocation() {
	return location;
}
public void setLocation(String location) {
	this.location = location;
}
public String getBarnchval() {
	return barnchval;
}
public void setBarnchval(String barnchval) {
	this.barnchval = barnchval;
}
public String getLblstartkm() {
	return lblstartkm;
}
public void setLblstartkm(String lblstartkm) {
	this.lblstartkm = lblstartkm;
}
public String getLblstartfuel() {
	return lblstartfuel;
}
public void setLblstartfuel(String lblstartfuel) {
	this.lblstartfuel = lblstartfuel;
}
public String getLblpdate() {
	return lblpdate;
}
public void setLblpdate(String lblpdate) {
	this.lblpdate = lblpdate;
}
public String getLblptime() {
	return lblptime;
}
public void setLblptime(String lblptime) {
	this.lblptime = lblptime;
}
public String getLblpfuel() {
	return lblpfuel;
}
public void setLblpfuel(String lblpfuel) {
	this.lblpfuel = lblpfuel;
}
public String getLblpkm() {
	return lblpkm;
}
public void setLblpkm(String lblpkm) {
	this.lblpkm = lblpkm;
}
public String getLbldrivenby() {
	return lbldrivenby;
}
public void setLbldrivenby(String lbldrivenby) {
	this.lbldrivenby = lbldrivenby;
}
public String getLbldescription() {
	return lbldescription;
}
public void setLbldescription(String lbldescription) {
	this.lbldescription = lbldescription;
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
public String getCldocno() {
	return cldocno;
}
public void setCldocno(String cldocno) {
	this.cldocno = cldocno;
}


public String getCmbbranch() {
	return cmbbranch;
}
public void setCmbbranch(String cmbbranch) {
	this.cmbbranch = cmbbranch;
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
public String getFleet_no() {
	return fleet_no;
}
public void setFleet_no(String fleet_no) {
	this.fleet_no = fleet_no;
}
public String getAgmtvocno() {
	return agmtvocno;
}
public void setAgmtvocno(String agmtvocno) {
	this.agmtvocno = agmtvocno;
}
public String getAgmtno() {
	return agmtno;
}
public void setAgmtno(String agmtno) {
	this.agmtno = agmtno;
}
public String getIndate() {
	return indate;
}
public void setIndate(String indate) {
	this.indate = indate;
}
public String getIntime() {
	return intime;
}
public void setIntime(String intime) {
	this.intime = intime;
}
public String getInkm() {
	return inkm;
}
public void setInkm(String inkm) {
	this.inkm = inkm;
}
public String getCmbinfuel() {
	return cmbinfuel;
}
public void setCmbinfuel(String cmbinfuel) {
	this.cmbinfuel = cmbinfuel;
}
public String getCmbtype() {
	return cmbtype;
}
public void setCmbtype(String cmbtype) {
	this.cmbtype = cmbtype;
}


public String saveAction() throws SQLException {
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	
	String mode=getMode();
	java.sql.Date indate=null ;	
//	System.out.println(getIndate()+"::"+getIntime());
	if(getIndate()!=null){
		indate=ClsCommon.changeStringtoSqlDate(getIndate());
	}
	

	
	if(mode.equalsIgnoreCase("A")){
		int val=pickupdao.insert(getAgmtno(),getCmbtype(),getFleet_no(),indate,getIntime(),getInkm(),getCmbinfuel(),getCmbbranch(),session,getCldocno(),getMode(),getPickdesc());
			if(val>0){
				setDetail("Vehicle");
				setDetailname("Vehicle Pick Up");
				setMsg("Successfully Saved");
				
				return "success";
				
			}
			else{
				setDetail("Vehicle");
				setDetailname("Vehicle Pick Up");
				setMsg("Not Saved");
				
				return "fail";
				}	
			}
	else if (mode.equalsIgnoreCase("D")){
		boolean status=pickupdao.delete(getDocno(),getMode(),session,getCmbbranch());
		if(status){
			setDetail("Vehicle");
			setDetailname("Vehicle Pick Up");
			setMsg("Successfully Deleted");
			
			return "success";
		}
		else{
			setDetail("Vehicle");
			setDetailname("Vehicle Pick Up");
			setMsg("Not Deleted");
			
			return "fail";
		}
	}

return "fail";

}


public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String printAction() throws ParseException, SQLException{
	
	  HttpServletRequest request=ServletActionContext.getRequest();
	 
	 int doc=Integer.parseInt(request.getParameter("docno"));
	 
	 ClsVehiclePickUpBean printbean=new ClsVehiclePickUpBean();
	 printbean=pickupdao.getPrint(doc);
	 

	   
	  setLblagmtbranch(printbean.getLblagmtbranch());
	  setLblpickbranch(printbean.getLblagmtbranch());
	  setLblagmtloc(printbean.getLblagmtloc());
	  setLblagmttype(printbean.getLblagmttype());
	  setLblvrano(printbean.getLblvrano());
	  setLblclientacno(printbean.getLblclientacno());
	  setLblrefname(printbean.getLblrefname());
	  setLbldrivenby(printbean.getLbldrivenby());
	  setLbldescription(printbean.getLbldescription());
	  setLbldocno(printbean.getLbldocno());
	  setLbldate(printbean.getLbldate());
	  setLblfleet_no(printbean.getLblfleet_no());
	  setLblflname(printbean.getLblflname());
	  setLblregno(printbean.getLblregno());
	  setLblstartdate(printbean.getLblstartdate());
	  setLblstarttime(printbean.getLblstarttime());
	  setLblstartkm(printbean.getLblstartkm());
	  setLblstartfuel(printbean.getLblstartfuel());
	  setLblpdate(printbean.getLblpdate());
	  setLblptime(printbean.getLblptime());
	  setLblpkm(printbean.getLblpkm());
	  setLblpfuel(printbean.getLblpfuel());
	  setLblvradate(printbean.getLblvradate());
	  setLblpickdesc(printbean.getLblpickdesc());
	  setLblagmtdesc(printbean.getLblagmtdesc());
	  // company
	     setBarnchval(printbean.getBarnchval());
	   setCompanyname(printbean.getCompanyname());
	 	  
	   setAddress(printbean.getAddress());
	 
	   setMobileno(printbean.getMobileno());
	  
	   setFax(printbean.getFax());
	   setLocation(printbean.getLocation());
	
	
	 return "print";
	 }
public String getLblagmtbranch() {
	return lblagmtbranch;
}
public void setLblagmtbranch(String lblagmtbranch) {
	this.lblagmtbranch = lblagmtbranch;
}
public String getLbldocno() {
	return lbldocno;
}
public void setLbldocno(String lbldocno) {
	this.lbldocno = lbldocno;
}
public String getLblagmtloc() {
	return lblagmtloc;
}
public void setLblagmtloc(String lblagmtloc) {
	this.lblagmtloc = lblagmtloc;
}
public String getLbldate() {
	return lbldate;
}
public void setLbldate(String lbldate) {
	this.lbldate = lbldate;
}
public String getLblagmttype() {
	return lblagmttype;
}
public void setLblagmttype(String lblagmttype) {
	this.lblagmttype = lblagmttype;
}
public String getLblvrano() {
	return lblvrano;
}
public void setLblvrano(String lblvrano) {
	this.lblvrano = lblvrano;
}
public String getLblfleet_no() {
	return lblfleet_no;
}
public void setLblfleet_no(String lblfleet_no) {
	this.lblfleet_no = lblfleet_no;
}
public String getLblflname() {
	return lblflname;
}
public void setLblflname(String lblflname) {
	this.lblflname = lblflname;
}
public String getLblvradate() {
	return lblvradate;
}
public void setLblvradate(String lblvradate) {
	this.lblvradate = lblvradate;
}
public String getLblregno() {
	return lblregno;
}
public void setLblregno(String lblregno) {
	this.lblregno = lblregno;
}
public String getLblclientacno() {
	return lblclientacno;
}
public void setLblclientacno(String lblclientacno) {
	this.lblclientacno = lblclientacno;
}
public String getLblrefname() {
	return lblrefname;
}
public void setLblrefname(String lblrefname) {
	this.lblrefname = lblrefname;
}
public String getLblstartdate() {
	return lblstartdate;
}
public void setLblstartdate(String lblstartdate) {
	this.lblstartdate = lblstartdate;
}
public String getLblstarttime() {
	return lblstarttime;
}
public void setLblstarttime(String lblstarttime) {
	this.lblstarttime = lblstarttime;
}

public String getLblpickbranch() {
	return lblpickbranch;
}
public void setLblpickbranch(String lblpickbranch) {
	this.lblpickbranch = lblpickbranch;
}
public String getLblpicklocation() {
	return lblpicklocation;
}
public void setLblpicklocation(String lblpicklocation) {
	this.lblpicklocation = lblpicklocation;
}


}
