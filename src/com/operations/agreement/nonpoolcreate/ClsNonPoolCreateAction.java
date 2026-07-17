package com.operations.agreement.nonpoolcreate;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsNonPoolCreateAction {
ClsNonPoolCreateDAO nonpoolDAO=new ClsNonPoolCreateDAO();
ClsNonPoolCreateBean bean;
ClsCommon objcommon=new ClsCommon();
private int docno;
private int voucherno;
private String date;
private String hiddate;
private String fleetno;
private String fleetname;
private String vendoracno;
private String vendor;
private String vendorname;
private String cmbperiodtype;
private String hidcmbperiodtype;
private String cmbperiodno;
private String hidcmbperiodno;
private String datein;
private String hiddatein;
private String timein;
private String hidtimein;
private String datedue;
private String timedue;
private String hidtimedue;
private String inkm;
private String cmbinfuel;
private String hidcmbinfuel;
private String checkin;
private String hidcheckin;
private String inuser;
private String hidinuser;
private String m1;
private String m2;
private String m3;
private String m4;
private String m5;
private String m6;
private String m7;
private String m8;
private String m9;
private String m10;
private String amt1;
private String amt2;
private String amt3;
private String amt4;
private String amt5;
private String closedate;
private String hidclosedate;
private String closetime;
private String hidclosetime;
private String closekm;
private String cmbclosefuel;
private String hidcmbclosefuel;
private String totalkm;
private String avgkm;
private String checkout;
private String hidcheckout;
private String closeuser;
private String hidcloseuser;
private String mode;
private String msg;
private String deleted;
private int gridlength;
private String formdetailcode;
private int nonpoolgridlength;
private String amttotal;
private String closestatus;
private String cmblocation;
private String hidcmblocation;
private String cmbbranch;
private String  hidcmbbranch;
private String gridstatus;



public int getVoucherno() {
	return voucherno;
}
public void setVoucherno(int voucherno) {
	this.voucherno = voucherno;
}
public String getGridstatus() {
	return gridstatus;
}
public void setGridstatus(String gridstatus) {
	this.gridstatus = gridstatus;
}
public String getCmbbranch() {
	return cmbbranch;
}
public void setCmbbranch(String cmbbranch) {
	this.cmbbranch = cmbbranch;
}
public String getHidcmbbranch() {
	return hidcmbbranch;
}
public void setHidcmbbranch(String hidcmbbranch) {
	this.hidcmbbranch = hidcmbbranch;
}
public String getCmblocation() {
	return cmblocation;
}
public void setCmblocation(String cmblocation) {
	this.cmblocation = cmblocation;
}
public String getHidcmblocation() {
	return hidcmblocation;
}
public void setHidcmblocation(String hidcmblocation) {
	this.hidcmblocation = hidcmblocation;
}
public String getClosestatus() {
	return closestatus;
}
public void setClosestatus(String closestatus) {
	this.closestatus = closestatus;
}
public String getAmttotal() {
	return amttotal;
}
public void setAmttotal(String amttotal) {
	this.amttotal = amttotal;
}
public int getNonpoolgridlength() {
	return nonpoolgridlength;
}
public void setNonpoolgridlength(int nonpoolgridlength) {
	this.nonpoolgridlength = nonpoolgridlength;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getHidtimedue() {
	return hidtimedue;
}
public void setHidtimedue(String hidtimedue) {
	this.hidtimedue = hidtimedue;
}
public int getGridlength() {
	return gridlength;
}
public void setGridlength(int gridlength) {
	this.gridlength = gridlength;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
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
public String getVendoracno() {
	return vendoracno;
}
public void setVendoracno(String vendoracno) {
	this.vendoracno = vendoracno;
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
public String getFleetno() {
	return fleetno;
}
public void setFleetno(String fleetno) {
	this.fleetno = fleetno;
}
public String getFleetname() {
	return fleetname;
}
public void setFleetname(String fleetname) {
	this.fleetname = fleetname;
}
public String getVendor() {
	return vendor;
}
public void setVendor(String vendor) {
	this.vendor = vendor;
}
public String getVendorname() {
	return vendorname;
}
public void setVendorname(String vendorname) {
	this.vendorname = vendorname;
}
public String getCmbperiodtype() {
	return cmbperiodtype;
}
public void setCmbperiodtype(String cmbperiodtype) {
	this.cmbperiodtype = cmbperiodtype;
}
public String getHidcmbperiodtype() {
	return hidcmbperiodtype;
}
public void setHidcmbperiodtype(String hidcmbperiodtype) {
	this.hidcmbperiodtype = hidcmbperiodtype;
}
public String getCmbperiodno() {
	return cmbperiodno;
}
public void setCmbperiodno(String cmbperiodno) {
	this.cmbperiodno = cmbperiodno;
}
public String getHidcmbperiodno() {
	return hidcmbperiodno;
}
public void setHidcmbperiodno(String hidcmbperiodno) {
	this.hidcmbperiodno = hidcmbperiodno;
}
public String getDatein() {
	return datein;
}
public void setDatein(String datein) {
	this.datein = datein;
}
public String getHiddatein() {
	return hiddatein;
}
public void setHiddatein(String hiddatein) {
	this.hiddatein = hiddatein;
}
public String getTimein() {
	return timein;
}
public void setTimein(String timein) {
	this.timein = timein;
}
public String getHidtimein() {
	return hidtimein;
}
public void setHidtimein(String hidtimein) {
	this.hidtimein = hidtimein;
}
public String getDatedue() {
	return datedue;
}
public void setDatedue(String datedue) {
	this.datedue = datedue;
}
public String getTimedue() {
	return timedue;
}
public void setTimedue(String timedue) {
	this.timedue = timedue;
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
public String getHidcmbinfuel() {
	return hidcmbinfuel;
}
public void setHidcmbinfuel(String hidcmbinfuel) {
	this.hidcmbinfuel = hidcmbinfuel;
}
public String getCheckin() {
	return checkin;
}
public void setCheckin(String checkin) {
	this.checkin = checkin;
}
public String getHidcheckin() {
	return hidcheckin;
}
public void setHidcheckin(String hidcheckin) {
	this.hidcheckin = hidcheckin;
}
public String getInuser() {
	return inuser;
}
public void setInuser(String inuser) {
	this.inuser = inuser;
}
public String getHidinuser() {
	return hidinuser;
}
public void setHidinuser(String hidinuser) {
	this.hidinuser = hidinuser;
}
public String getM1() {
	return m1;
}
public void setM1(String m1) {
	this.m1 = m1;
}
public String getM2() {
	return m2;
}
public void setM2(String m2) {
	this.m2 = m2;
}
public String getM3() {
	return m3;
}
public void setM3(String m3) {
	this.m3 = m3;
}
public String getM4() {
	return m4;
}
public void setM4(String m4) {
	this.m4 = m4;
}
public String getM5() {
	return m5;
}
public void setM5(String m5) {
	this.m5 = m5;
}
public String getM6() {
	return m6;
}
public void setM6(String m6) {
	this.m6 = m6;
}
public String getM7() {
	return m7;
}
public void setM7(String m7) {
	this.m7 = m7;
}
public String getM8() {
	return m8;
}
public void setM8(String m8) {
	this.m8 = m8;
}
public String getM9() {
	return m9;
}
public void setM9(String m9) {
	this.m9 = m9;
}
public String getM10() {
	return m10;
}
public void setM10(String m10) {
	this.m10 = m10;
}
public String getAmt1() {
	return amt1;
}
public void setAmt1(String amt1) {
	this.amt1 = amt1;
}
public String getAmt2() {
	return amt2;
}
public void setAmt2(String amt2) {
	this.amt2 = amt2;
}
public String getAmt3() {
	return amt3;
}
public void setAmt3(String amt3) {
	this.amt3 = amt3;
}
public String getAmt4() {
	return amt4;
}
public void setAmt4(String amt4) {
	this.amt4 = amt4;
}
public String getAmt5() {
	return amt5;
}
public void setAmt5(String amt5) {
	this.amt5 = amt5;
}
public String getClosedate() {
	return closedate;
}
public void setClosedate(String closedate) {
	this.closedate = closedate;
}
public String getHidclosedate() {
	return hidclosedate;
}
public void setHidclosedate(String hidclosedate) {
	this.hidclosedate = hidclosedate;
}
public String getClosetime() {
	return closetime;
}
public void setClosetime(String closetime) {
	this.closetime = closetime;
}
public String getHidclosetime() {
	return hidclosetime;
}
public void setHidclosetime(String hidclosetime) {
	this.hidclosetime = hidclosetime;
}
public String getClosekm() {
	return closekm;
}
public void setClosekm(String closekm) {
	this.closekm = closekm;
}
public String getCmbclosefuel() {
	return cmbclosefuel;
}
public void setCmbclosefuel(String cmbclosefuel) {
	this.cmbclosefuel = cmbclosefuel;
}
public String getHidcmbclosefuel() {
	return hidcmbclosefuel;
}
public void setHidcmbclosefuel(String hidcmbclosefuel) {
	this.hidcmbclosefuel = hidcmbclosefuel;
}
public String getTotalkm() {
	return totalkm;
}
public void setTotalkm(String totalkm) {
	this.totalkm = totalkm;
}
public String getAvgkm() {
	return avgkm;
}
public void setAvgkm(String avgkm) {
	this.avgkm = avgkm;
}
public String getCheckout() {
	return checkout;
}
public void setCheckout(String checkout) {
	this.checkout = checkout;
}
public String getHidcheckout() {
	return hidcheckout;
}
public void setHidcheckout(String hidcheckout) {
	this.hidcheckout = hidcheckout;
}
public String getCloseuser() {
	return closeuser;
}
public void setCloseuser(String closeuser) {
	this.closeuser = closeuser;
}
public String getHidcloseuser() {
	return hidcloseuser;
}
public void setHidcloseuser(String hidcloseuser) {
	this.hidcloseuser = hidcloseuser;
}



public void setData(java.sql.Date sqldate,java.sql.Date sqlclosedate,java.sql.Date sqldatedue,java.sql.Date sqldatein,int val,HttpSession session,String extmode){
	
	setDocno(val);
	setFleetno(getFleetno());
	setFleetname(getFleetname());
	setVendor(getVendor());
	setVendoracno(getVendoracno());
	setVendorname(getVendorname());
	setHidcmbperiodno(getCmbperiodno());
	setHidcmbperiodtype(getCmbperiodtype());
	
	setHidtimein(getTimein());
	
	setHidtimedue(getTimedue());
	setInkm(getInkm());
	setHidcmbinfuel(getCmbinfuel());
	setHidcheckin(getHidcheckin());
	setCheckin(getCheckin());
	setInuser(session.getAttribute("USERNAME").toString());
	setHidinuser(session.getAttribute("USERID").toString());
	setHidcmbbranch(getCmbbranch());
	setHidcmblocation(getCmblocation());
	setM1(getM1());
	setM2(getM2());
	setM3(getM3());
	setM4(getM4());
	setM5(getM5());
	setM6(getM6());
	setM7(getM7());
	setM8(getM8());
	setM9(getM9());
	setM10(getM10());
	setAmt1(getAmt1());
	setAmt2(getAmt2());
	setAmt3(getAmt3());
	setAmt4(getAmt4());
	setAmt5(getAmt5());
	
	if(extmode.equalsIgnoreCase("1")){
		if(sqlclosedate!=null){
			setClosedate(sqlclosedate.toString());	
		}
		setHidclosetime(getClosetime());
		setClosekm(getClosekm());
		setHidcmbclosefuel(getCmbclosefuel());
		setTotalkm(getTotalkm());
		setAvgkm(getAvgkm());
		setCheckout(getCheckout());
		setHidcheckout(getHidcheckout());
		setCloseuser(session.getAttribute("USERNAME").toString());
		setHidcloseuser(session.getAttribute("USERID").toString());
	}
	if(sqldate!=null){
		setDate(sqldate.toString());	
	}
	if(sqldatein!=null){
		setDatein(sqldatein.toString());
	}
	if(sqldatedue!=null){
		setDatedue(sqldatedue.toString());
	}
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	String mode=getMode();
	Map<String, String[]> requestParams = request.getParameterMap();

	java.sql.Date sqldatedue=null,sqldatein=null,sqlclosedate=null,sqldate=null;
	sqldate=objcommon.changeStringtoSqlDate(getDate());
	if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("R")){
		setDatein(getDatein()==null?"":getDatein());
		setDatedue(getDatedue()==null?"":getDatedue());
		
		if(!(getDatein().equalsIgnoreCase(""))){
			sqldatein=objcommon.changeStringtoSqlDate(getDatein());
		}
		if(!(getDatedue().equalsIgnoreCase(""))){
			sqldatedue=objcommon.changeStringtoSqlDate(getDatedue());
		}
		if(mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("R")){
			if(!(getClosedate().equalsIgnoreCase(""))){
				sqlclosedate=objcommon.changeStringtoSqlDate(getClosedate());
			}	
		}
		
	}
	
if(mode.equalsIgnoreCase("A")){
	ArrayList<String> tarifarray= new ArrayList<>();
		int i=0;
		String temp=requestParams.get("test"+i)[0];
			
			tarifarray.add(temp);

		int val=nonpoolDAO.insert(getFleetno(),getVendor(),getVendoracno(),getCmbperiodno(),getCmbperiodtype(),sqldate,sqldatein,getTimein(),sqldatedue,getTimedue(),
				getInkm(),getCmbinfuel(),getHidcheckin(),getM1(),getM2(),getM3(),getM4(),getM5(),getM6(),getM7(),getM8(),getM9(),getM10(),getAmt1(),
				getAmt2(),getAmt3(),getAmt4(),getAmt5(),tarifarray,getMode(),session,getFormdetailcode(),getCmblocation(),getCmbbranch(),request);
//		System.out.println("Action Val:"+val);
		if(val>0){
			
			setData(sqldate,sqlclosedate,sqldatedue,sqldatein,val,session,"0");
			setVoucherno(Integer.parseInt(request.getAttribute("VOUCHERNO").toString()));
			setMsg("Successfully Saved");
			setClosestatus("0");
			return "success";
		}
		else{
			setData(sqldate,sqlclosedate,sqldatedue,sqldatein,val,session,"0");
			setVoucherno(0);
			setClosestatus("0");
			setMsg("Not Saved");
			return "fail";
		}
	}
else if(mode.equalsIgnoreCase("E")){
	
	boolean status=nonpoolDAO.close(getDocno(),sqlclosedate,getClosetime(),getClosekm(),getCmbclosefuel(),getTotalkm(),getAvgkm(),getHidcheckout(),mode,
			session,getFleetno(),getFormdetailcode(),getAmttotal(),getVendoracno(),getVendor(),getVoucherno());
	if(status){
		setData(sqldate,sqlclosedate,sqldatedue,sqldatein,getDocno(),session,"1");
		setVoucherno(getVoucherno());
		setMsg("Updated Successfully");
		setClosestatus("1");
		return "success";
	}
	else{
		setData(sqldate,sqlclosedate,sqldatedue,sqldatein,getDocno(),session,"1");
		setVoucherno(getVoucherno());
		setClosestatus("0");
		setMsg("Not Updated");
		return "fail";
	}
}

else if(mode.equalsIgnoreCase("R")){
	ArrayList<String> nonpoolratearray=new ArrayList<>();
	for(int i=0;i<getNonpoolgridlength();i++){
		String temp=requestParams.get("nonpoollist"+i)[0];
		
		nonpoolratearray.add(temp);
	}
	boolean status=nonpoolDAO.rateupdate(getDocno(),sqlclosedate,mode,
			session,getFleetno(),nonpoolratearray,getFormdetailcode(),getVendoracno(),getVendor());
	if(status){
		setData(sqldate,sqlclosedate,sqldatedue,sqldatein,getDocno(),session,"1");
		setVoucherno(getVoucherno());
		setMsg("Updated Successfully");
		setClosestatus("1");
		setGridstatus("1");
		return "success";
	}
	else{
		setData(sqldate,sqlclosedate,sqldatedue,sqldatein,getDocno(),session,"1");
		setVoucherno(getVoucherno());
		setClosestatus("0");
		setGridstatus("0");
		setMsg("Not Updated");
		return "fail";
	}
}
else if(mode.equalsIgnoreCase("View")){
	bean=nonpoolDAO.getViewDetails(getDocno());
	
	setVoucherno(bean.getVoucherno());
	setDocno(bean.getDocno());
	setDate(bean.getDate());
	setFleetno(bean.getFleetno());
	setFleetname(bean.getFleetname());
	setVendor(bean.getVendor());
	setVendorname(bean.getVendorname());
	setVendoracno(bean.getVendoracno());
	setDatedue(bean.getDatedue());
	setHidtimedue(bean.getHidtimedue());
	setHidcmbperiodno(bean.getHidcmbperiodno());
	setHidcmbperiodtype(bean.getHidcmbperiodtype());
	setDatein(bean.getDatein());
	setHidtimein(bean.getHidtimein());
	setInkm(bean.getInkm());
	setHidcmbinfuel(bean.getHidcmbinfuel());
	setHidcheckin(bean.getHidcheckin());
	setCheckin(bean.getCheckin());
	setHidinuser(bean.getHidinuser());
	setInuser(bean.getInuser());
	setM1(bean.getM1());
	setM2(bean.getM2());
	setAmt1(bean.getAmt1());
	setM3(bean.getM3());
	setM4(bean.getM4());
	setAmt2(bean.getAmt2());
	setM5(bean.getM5());
	setM6(bean.getM6());
	setAmt3(bean.getAmt3());
	setM7(bean.getM7());
	setM8(bean.getM8());
	setAmt4(bean.getAmt4());
	setM9(bean.getM9());
	setM10(bean.getM10());
	setAmt5(bean.getAmt5());
	setHidcmbbranch(bean.getHidcmbbranch());
	setHidcmblocation(bean.getHidcmblocation());
	if(bean.getClstatus().equalsIgnoreCase("1")){
		setClosedate(bean.getClosedate());
		setHidclosetime(bean.getHidclosetime());
		setClosekm(bean.getClosekm());
		setHidcmbclosefuel(bean.getHidcmbclosefuel());
		setTotalkm(bean.getTotalkm());
		setAvgkm(bean.getAvgkm());
		setHidcheckout(bean.getHidcheckout());
		setCheckout(bean.getCheckout());
		setCloseuser(bean.getCloseuser());
		setHidcloseuser(bean.getCloseuser());
		
	}
	setClosestatus(bean.getClstatus());
	return "success";
}
	return "fail";
}
}