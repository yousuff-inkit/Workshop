package com.dashboard.operations.driveragmtcreate;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsDriverAgmtCreateAction extends ActionSupport{

	ClsDriverAgmtCreateDAO agmtdao=new ClsDriverAgmtCreateDAO();
	ClsCommon objcommon=new ClsCommon();
	ClsDriverAgmtCreateBean driverBean;
	private String msg,mode,date,client,hidclient,driver,hiddriver,rate,overrate,lpono,cmbcontracttype,normalovertime,holidayovertime,fromdate,cmbinvoicetype,docno,cmbbranch,detail,detailname;
	private String lblcheckedby;
	private String checkindate,lblcheckindate,lblprintname1;
	
	
	
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
	}
	public String getLblcheckindate() {
		return lblcheckindate;
	}
	public void setLblcheckindate(String lblcheckindate) {
		this.lblcheckindate = lblcheckindate;
	}
	
	public String getCheckindate() {
		return checkindate;
	}
	public void setCheckindate(String checkindate) {
		this.checkindate = checkindate;
	}
	public String getLblcheckedby() {
		return lblcheckedby;
	}
	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}
	public String getOverrate() {
		return overrate;
	}
	public void setOverrate(String overrate) {
		this.overrate = overrate;
	}
	public String getLpono() {
		return lpono;
	}
	public void setLpono(String lpono) {
		this.lpono = lpono;
	}
	private String lbldocno,lbldate,lblclient,lbladdress,lblmobile,lbldriver,lbllpo,lbloverrate,lblclosedate,
	lblcontrcttype,lblprintname,lbllocation,lblcomptel,lblcompfax,lblcompname,lblstartdate,lblinvoicetype,lblmail,lblrate,lblbranch,lblnormalover,lblholidayover,lblradrname,lblradlno,licexpdate,lblpassno,lblpassexpdate,lbldobdate;
	
	
	public String getLbloverrate() {
		return lbloverrate;
	}
	public void setLbloverrate(String lbloverrate) {
		this.lbloverrate = lbloverrate;
	}
	public String getLblclosedate() {
		return lblclosedate;
	}
	public void setLblclosedate(String lblclosedate) {
		this.lblclosedate = lblclosedate;
	}
	public String getLbllpo() {
		return lbllpo;
	}
	public void setLbllpo(String lbllpo) {
		this.lbllpo = lbllpo;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
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
	public String getLblmail() {
		return lblmail;
	}
	public void setLblmail(String lblmail) {
		this.lblmail = lblmail;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLblradrname() {
		return lblradrname;
	}
	public void setLblradrname(String lblradrname) {
		this.lblradrname = lblradrname;
	}
	public String getLblradlno() {
		return lblradlno;
	}
	public void setLblradlno(String lblradlno) {
		this.lblradlno = lblradlno;
	}
	public String getLicexpdate() {
		return licexpdate;
	}
	public void setLicexpdate(String licexpdate) {
		this.licexpdate = licexpdate;
	}
	public String getLblpassno() {
		return lblpassno;
	}
	public void setLblpassno(String lblpassno) {
		this.lblpassno = lblpassno;
	}
	public String getLblpassexpdate() {
		return lblpassexpdate;
	}
	public void setLblpassexpdate(String lblpassexpdate) {
		this.lblpassexpdate = lblpassexpdate;
	}
	public String getLbldobdate() {
		return lbldobdate;
	}
	public void setLbldobdate(String lbldobdate) {
		this.lbldobdate = lbldobdate;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLbladdress() {
		return lbladdress;
	}
	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}
	public String getLblmobile() {
		return lblmobile;
	}
	public void setLblmobile(String lblmobile) {
		this.lblmobile = lblmobile;
	}
	public String getLbldriver() {
		return lbldriver;
	}
	public void setLbldriver(String lbldriver) {
		this.lbldriver = lbldriver;
	}
	public String getLblcontrcttype() {
		return lblcontrcttype;
	}
	public void setLblcontrcttype(String lblcontrcttype) {
		this.lblcontrcttype = lblcontrcttype;
	}
	public String getLblstartdate() {
		return lblstartdate;
	}
	public void setLblstartdate(String lblstartdate) {
		this.lblstartdate = lblstartdate;
	}
	public String getLblinvoicetype() {
		return lblinvoicetype;
	}
	public void setLblinvoicetype(String lblinvoicetype) {
		this.lblinvoicetype = lblinvoicetype;
	}
	public String getLblrate() {
		return lblrate;
	}
	public void setLblrate(String lblrate) {
		this.lblrate = lblrate;
	}
	public String getLblnormalover() {
		return lblnormalover;
	}
	public void setLblnormalover(String lblnormalover) {
		this.lblnormalover = lblnormalover;
	}
	public String getLblholidayover() {
		return lblholidayover;
	}
	public void setLblholidayover(String lblholidayover) {
		this.lblholidayover = lblholidayover;
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
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getHiddriver() {
		return hiddriver;
	}
	public void setHiddriver(String hiddriver) {
		this.hiddriver = hiddriver;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}
	public String getNormalovertime() {
		return normalovertime;
	}
	public void setNormalovertime(String normalovertime) {
		this.normalovertime = normalovertime;
	}
	public String getHolidayovertime() {
		return holidayovertime;
	}
	public void setHolidayovertime(String holidayovertime) {
		this.holidayovertime = holidayovertime;
	}
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getCmbinvoicetype() {
		return cmbinvoicetype;
	}
	public void setCmbinvoicetype(String cmbinvoicetype) {
		this.cmbinvoicetype = cmbinvoicetype;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date sqldate=null,sqlfromdate=null,sqlcheckindate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(!getFromdate().equalsIgnoreCase("") && getFromdate()!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
		}
		if(!getCheckindate().equalsIgnoreCase("") && getCheckindate()!=null){
			sqlcheckindate=objcommon.changeStringtoSqlDate(getCheckindate());
		}
		if(mode.equalsIgnoreCase("A")){
			int val=agmtdao.insert(getCmbbranch(),sqldate,getHidclient(),getHiddriver(),getCmbcontracttype(),getRate(),getNormalovertime(),getHolidayovertime(),
					sqlfromdate,getCmbinvoicetype(),getLpono(),getOverrate(),session,request,mode,sqlcheckindate);
			if(val>0){
				setDetail("Operations");
				setDetailname("Driver Agreement Create");
				setMsg("Successfully Created");
				return "success";
			}
			else{
				setDetail("Operations");
				setDetailname("Driver Agreement Create");
				setMsg("Not Created");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
			boolean status=agmtdao.edit(getDocno(),getCmbbranch(),sqldate,getHidclient(),getHiddriver(),getCmbcontracttype(),getRate(),getNormalovertime(),
					getHolidayovertime(),sqlfromdate,cmbinvoicetype,getLpono(),getOverrate(),session,request,mode,sqlcheckindate);
			if(status){
				setDetail("Operations");
				setDetailname("Driver Agreement Create");
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setDetail("Operations");
				setDetailname("Driver Agreement Create");
				setMsg("Not Updated");
				return "fail";
			}
		}
		return "fail";
	}
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		String branch = request.getParameter("branch");
		String docno = request.getParameter("Docno");
		
		driverBean=agmtdao.getPrint(request,branch,docno);
		setLbldocno(driverBean.getLbldocno());
		setLbldate(driverBean.getLbldate());
		setLblclient(driverBean.getLblclient());
		setLbladdress(driverBean.getLbladdress());
		setLblmobile(driverBean.getLblmobile());
		setLbldriver(driverBean.getLbldriver());
		setLblcontrcttype(driverBean.getLblcontrcttype());
		setLblstartdate(driverBean.getLblstartdate());
		setLblinvoicetype(driverBean.getLblinvoicetype());
		setLblrate(driverBean.getLblrate());
		setLblnormalover(driverBean.getLblnormalover());
		setLblholidayover(driverBean.getLblholidayover());
		setLblradrname(driverBean.getLblradrname());
		setLblradlno(driverBean.getLblradlno());
		setLicexpdate(driverBean.getLicexpdate());
		setLblpassno(driverBean.getLblpassno());
		setLblpassexpdate(driverBean.getLblpassexpdate());
		setLbldobdate(driverBean.getLbldobdate());
		setLblbranch(driverBean.getLblbranch());
		setLblmail(driverBean.getLblmail());
		setLblcomptel(driverBean.getLblcomptel());
		setLblcompfax(driverBean.getLblcompfax());
		setLbllocation(driverBean.getLbllocation());
		setLblcompname(driverBean.getLblcompname());
		setLblprintname("Driver Agreement");
		setLblclosedate(driverBean.getLblclosedate());
		setLbllpo(driverBean.getLbllpo());
		setLbloverrate(driverBean.getLbloverrate());
		setLblcheckedby(driverBean.getLblcheckedby());
		setLblcheckindate(driverBean.getLblcheckindate());
		setLblprintname1("Contract Type : DRO");
		
		
		
		return "print";
	}
}
