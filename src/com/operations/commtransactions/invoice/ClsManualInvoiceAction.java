package com.operations.commtransactions.invoice;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.*;

import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.salesmanmaster.rentalagent.ClsRentalAgentBean;
import com.controlcentre.masters.salesmanmaster.rentalagent.ClsRentalAgentDAO;
import com.controlcentre.masters.tarifmgmt.ClsTarifBean;
import com.operations.commtransactions.invoice.*;
import com.operations.vehicletransactions.movement.ClsMovementBean;
import com.operations.vehicletransactions.movement.ClsMovementDAO;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;
public class ClsManualInvoiceAction extends ActionSupport{
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
ClsManualInvoiceDAO manualinvoiceDAO =new ClsManualInvoiceDAO();
ClsManualInvoiceBean bean;
private int docno;
private int voucherno;
private String date;
private String hiddate;
private String cmbagmttype;
private String hidcmbagmttype;
private int agmtno;
private int agmtvoucherno;
private String client;
private String clientdetails;
private String driver;
private String driverdetails;
private String contractvehicle;
private String vehicledetails;
private String fromdate;
private String hidfromdate;
private String todate;
private String hidtodate;
private String ledgernote;
private String invoicenote;
private String mode;
private String deleted;
private String acno;
private String hidclient;
private String brchName;
private int gridlength;
private String dtype;
private String lblcompname;
private String lblcompaddress;
private String lblcomptel;
private String lblcompfax;
private String lblclient;
private String lblaccount;
private String lblmobile;
private String lblfax;
private String lbldriven;
private String lblmrano;
private String lblcontractstart;
private String lblinvno;
private String lbldate;
private String lblratype;
private String lblrano;
private String lblinvfrom;
private String lblinvto;
private String lblcontractvehicle;
private String lblbranch;
private String lbltotal;
private String lblnetamount;
private String lblphone;
private String msg;
private String formdetail;
private String formdetailcode;
private String lblamountwords;
private String clstatus;
private String lbladdress1;
private String lbladdress2;
private String lblcheckedby;
private String lblrecievedby;
private String  lblfinaldate;
private String lbllocation;
private String lbllpono;
private String lblbranchcode;
private String lbldateyear;
private int lblsalikcount;
private int lbltrafficcountdubai;
private int lbltrafficcountelse;
private String lblprintname;
private int lbltcno;
private String lblcstno;
private String lblservicetax;
private String lblpan;
private String lblsalesman;
private String lblinvfromtime;
private String lblinvtotime;
private String lblcurrencycode;
private String lblcurrentvehicle;
private String lblinvtype;
private String url;
private int lblfleetcount;
private String email;
private String tinno;
private String lblhidheader;
private int lbldamagecount;
private String lblinspno;
private String lblinspregno;
private int lblshowfees;
private String printdetailsql;
private String saliksql;
private String trafficdubaisql;
private String trafficabudhabusql;
private String otherfleetsql;
private String jasptotal;
private String jaspnetamount;
private int lblagmtcounteasy;
private String lblcompemail;
private String lblcompwebsite;
private String lblcreditdiff;
private String duedate;
private String lblledgernote;


public String getLblledgernote() {
	return lblledgernote;
}
public void setLblledgernote(String lblledgernote) {
	this.lblledgernote = lblledgernote;
}
public String getLblcreditdiff() {
	return lblcreditdiff;
}
public void setLblcreditdiff(String lblcreditdiff) {
	this.lblcreditdiff = lblcreditdiff;
}
public String getLblcompemail() {
	return lblcompemail;
}
public void setLblcompemail(String lblcompemail) {
	this.lblcompemail = lblcompemail;
}
public String getLblcompwebsite() {
	return lblcompwebsite;
}
public void setLblcompwebsite(String lblcompwebsite) {
	this.lblcompwebsite = lblcompwebsite;
}

public int getLblagmtcounteasy() {
	return lblagmtcounteasy;
}
public void setLblagmtcounteasy(int lblagmtcounteasy) {
	this.lblagmtcounteasy = lblagmtcounteasy;
}
public String getJasptotal() {
	return jasptotal;
}
public void setJasptotal(String jasptotal) {
	this.jasptotal = jasptotal;
}
public String getJaspnetamount() {
	return jaspnetamount;
}
public void setJaspnetamount(String jaspnetamount) {
	this.jaspnetamount = jaspnetamount;
}
public String getOtherfleetsql() {
	return otherfleetsql;
}
public void setOtherfleetsql(String otherfleetsql) {
	this.otherfleetsql = otherfleetsql;
}
public String getPrintdetailsql() {
	return printdetailsql;
}
public void setPrintdetailsql(String printdetailsql) {
	this.printdetailsql = printdetailsql;
}
public String getSaliksql() {
	return saliksql;
}
public void setSaliksql(String saliksql) {
	this.saliksql = saliksql;
}
public String getTrafficdubaisql() {
	return trafficdubaisql;
}
public void setTrafficdubaisql(String trafficdubaisql) {
	this.trafficdubaisql = trafficdubaisql;
}
public String getTrafficabudhabusql() {
	return trafficabudhabusql;
}
public void setTrafficabudhabusql(String trafficabudhabusql) {
	this.trafficabudhabusql = trafficabudhabusql;
}

public int getLblshowfees() {
	return lblshowfees;
}
public void setLblshowfees(int lblshowfees) {
	this.lblshowfees = lblshowfees;
}
public String getLblinspno() {
	return lblinspno;
}
public void setLblinspno(String lblinspno) {
	this.lblinspno = lblinspno;
}
public String getLblinspregno() {
	return lblinspregno;
}
public void setLblinspregno(String lblinspregno) {
	this.lblinspregno = lblinspregno;
}
public int getLbldamagecount() {
	return lbldamagecount;
}
public void setLbldamagecount(int lbldamagecount) {
	this.lbldamagecount = lbldamagecount;
}
public String getLblhidheader() {
	return lblhidheader;
}
public void setLblhidheader(String lblhidheader) {
	this.lblhidheader = lblhidheader;
}
public String getTinno() {
	return tinno;
}

public void setTinno(String tinno) {
	this.tinno = tinno;
}

public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}

public int getLblfleetcount() {
	return lblfleetcount;
}
public void setLblfleetcount(int lblfleetcount) {
	this.lblfleetcount = lblfleetcount;
}
public String getLblinvtype() {
	return lblinvtype;
}
public void setLblinvtype(String lblinvtype) {
	this.lblinvtype = lblinvtype;
}
public String getLblcurrentvehicle() {
	return lblcurrentvehicle;
}
public void setLblcurrentvehicle(String lblcurrentvehicle) {
	this.lblcurrentvehicle = lblcurrentvehicle;
}
public String getLblcurrencycode() {
	return lblcurrencycode;
}
public void setLblcurrencycode(String lblcurrencycode) {
	this.lblcurrencycode = lblcurrencycode;
}
public String getLblsalesman() {
	return lblsalesman;
}
public void setLblsalesman(String lblsalesman) {
	this.lblsalesman = lblsalesman;
}
public String getLblinvfromtime() {
	return lblinvfromtime;
}
public void setLblinvfromtime(String lblinvfromtime) {
	this.lblinvfromtime = lblinvfromtime;
}
public String getLblinvtotime() {
	return lblinvtotime;
}
public void setLblinvtotime(String lblinvtotime) {
	this.lblinvtotime = lblinvtotime;
}
public int getVoucherno() {
	return voucherno;
}
public void setVoucherno(int voucherno) {
	this.voucherno = voucherno;
}
public int getAgmtvoucherno() {
	return agmtvoucherno;
}
public void setAgmtvoucherno(int agmtvoucherno) {
	this.agmtvoucherno = agmtvoucherno;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}
public String getLblcstno() {
	return lblcstno;
}
public void setLblcstno(String lblcstno) {
	this.lblcstno = lblcstno;
}
public String getLblservicetax() {
	return lblservicetax;
}
public void setLblservicetax(String lblservicetax) {
	this.lblservicetax = lblservicetax;
}
public String getLblpan() {
	return lblpan;
}
public void setLblpan(String lblpan) {
	this.lblpan = lblpan;
}
public String getBrchName() {
	return brchName;
}
public void setBrchName(String brchName) {
	this.brchName = brchName;
}

//easy lease
public String lbltelphone;

public String getLbltelphone() {
return lbltelphone;
}
public void setLbltelphone(String lbltelphone) {
this.lbltelphone = lbltelphone;
}

private String lblcustomervehicle;
private String lblcourtesyvehicle;

public String getLblcustomervehicle() {
	return lblcustomervehicle;
}
public void setLblcustomervehicle(String lblcustomervehicle) {
	this.lblcustomervehicle = lblcustomervehicle;
}
public String getLblcourtesyvehicle() {
	return lblcourtesyvehicle;
}
public void setLblcourtesyvehicle(String lblcourtesyvehicle) {
	this.lblcourtesyvehicle = lblcourtesyvehicle;
}


public ClsManualInvoiceAction(){}
/*public ClsManualInvoiceAction(int docno,String lblcompname, String lblcompaddress, String lblcomptel,String lblcompfax, String lblclient, String lblaccount,
		String lblmobile,String lblfax,String lbldriven,String lblmrano)
{*/
public ClsManualInvoiceAction(String lblinvno,String lblclient,String lblaccount,String lbldate,String lbladdress1,String lblrano,String lbladdress2,String lbllpono,
		String lblmrano,String lblmobile,String lblratype,String lblphone,String lblcontractstart,String lbldriven,String lblinvfrom,String lblinvto,String lblcontractvehicle,
		String lblcompname, String lblcompaddress, String lblcomptel,String lblcompfax,String lblprintname,String lblbranch,String lbltotal,String lblnetamount,
		String lblamountwords,String lblcheckedby,String lblfinaldate,int lblsalikcount,String lblbranchcode,String lbldateyear,
		int lbltrafficcountdubai,int lbltrafficcountelse,String lblcstno,String lblservicetax,String lblpan,String lbllocation,String lblsalesman,
		String lblinvfromtime,String lblinvtotime,String lblcurrencycode,String lblcurrentvehicle,String lblinvtype,int lblfleetcount,String lblhidheader,
		int lbldamagecount,String lblinspno,String lblinspregno,int lblshowfees,int lblagmtcounteasy,String lblcompemail,String lblcompwebsite,String lblcreditdiff,String duedate,
		 String lbltelphone,String lblledgernote,String lblcustomervehicle,String lblcourtesyvehicle)
{
   this.lblinvno = lblinvno;
   this.lblcompname = lblcompname;
   this.lblcompaddress = lblcompaddress;
   this.lblcomptel = lblcomptel;
   this.lblcompfax = lblcompfax;
   this.lblclient = lblclient;
   this.lblaccount = lblaccount;
   this.lbldate=lbldate;
   this.lbladdress1=lbladdress1;
   this.lblrano=lblrano;
   this.lbladdress2=lbladdress2;
   this.lbllpono=lbllpono;
   this.lblmrano=lblmrano;
   this.lblprintname=lblprintname;
   this.lblmobile = lblmobile;
   //easylease
   this.lbltelphone = lbltelphone;
   this.lblratype=lblratype;
   this.lblphone=lblphone;
   this.lblcontractstart=lblcontractstart;
   this.lbldriven=lbldriven;
   this.lblinvfrom=lblinvfrom;
   this.lblinvto=lblinvto;
   this.lblcontractvehicle=lblcontractvehicle;
   this.lbltotal=lbltotal;
   this.lblnetamount=lblnetamount;
   this.lblamountwords=lblamountwords;
   this.lblcheckedby=lblcheckedby;
   this.lblrecievedby=lblrecievedby;
   this.lblfinaldate=lblfinaldate;
   this.lblsalikcount=lblsalikcount;
   this.lblbranchcode=lblbranchcode;
   this.lbldateyear=lbldateyear;
   this.lblbranch=lblbranch;
   this.lbltrafficcountdubai=lbltrafficcountdubai;
   this.lbltrafficcountelse=lbltrafficcountelse;
   this.lblcstno=lblcstno;
   this.lblservicetax=lblservicetax;
   this.lblpan=lblpan;
   this.lbllocation=lbllocation;
   this.lblsalesman=lblsalesman;
   this.lblinvfromtime=lblinvfromtime;
   this.lblinvtotime=lblinvtotime;
   this.lblcurrencycode=lblcurrencycode;
   this.lblcurrentvehicle=lblcurrentvehicle;
   this.lblinvtype=lblinvtype;
     this.lblfleetcount=lblfleetcount;
	 this.lblhidheader=lblhidheader; 
   this.lbldamagecount=lbldamagecount;
   this.lblinspno=lblinspno;
   this.lblinspregno=lblinspregno;
   this.lblshowfees=lblshowfees;
   this.lblagmtcounteasy=lblagmtcounteasy;
   this.lblcompemail=lblcompemail;
   this.lblcompwebsite=lblcompwebsite;
   this.lblcreditdiff=lblcreditdiff;
   this.duedate=duedate;
   this.lblledgernote=lblledgernote;
    this.lblcustomervehicle=lblcustomervehicle;
   this.lblcourtesyvehicle=lblcourtesyvehicle;
   //System.out.println("Salik Count: "+this.lblsalikcount);
 
/*  this.lblfax = lblfax; 
   this.lbldriven = lbldriven;
   this.lblmrano = lblmrano;*/
}



public ClsManualInvoiceDAO getManualinvoiceDAO() {
	return manualinvoiceDAO;
}
public void setManualinvoiceDAO(ClsManualInvoiceDAO manualinvoiceDAO) {
	this.manualinvoiceDAO = manualinvoiceDAO;
}
public ClsManualInvoiceBean getBean() {
	return bean;
}
public void setBean(ClsManualInvoiceBean bean) {
	this.bean = bean;
}
public int getLbltrafficcountdubai() {
	return lbltrafficcountdubai;
}
public void setLbltrafficcountdubai(int lbltrafficcountdubai) {
	this.lbltrafficcountdubai = lbltrafficcountdubai;
}
public int getLbltrafficcountelse() {
	return lbltrafficcountelse;
}
public void setLbltrafficcountelse(int lbltrafficcountelse) {
	this.lbltrafficcountelse = lbltrafficcountelse;
}
public int getLbltcno() {
	return lbltcno;
}
public void setLbltcno(int lbltcno) {
	this.lbltcno = lbltcno;
}
	public String getLblprintname() {
	return lblprintname;
}
public void setLblprintname(String lblprintname) {
	this.lblprintname = lblprintname;
}

	public int getLblsalikcount() {
	return lblsalikcount;
}
public void setLblsalikcount(int lblsalikcount) {
	this.lblsalikcount = lblsalikcount;
}
	public String getLblbranchcode() {
	return lblbranchcode;
}
public void setLblbranchcode(String lblbranchcode) {
	this.lblbranchcode = lblbranchcode;
}
public String getLbldateyear() {
	return lbldateyear;
}
public void setLbldateyear(String lbldateyear) {
	this.lbldateyear = lbldateyear;
}
	public String getLbllpono() {
	return lbllpono;
}
public void setLbllpono(String lbllpono) {
	this.lbllpono = lbllpono;
}
	public String getLbllocation() {
	return lbllocation;
}
public void setLbllocation(String lbllocation) {
	this.lbllocation = lbllocation;
}
	public String getLbladdress2() {
	return lbladdress2;
}
public void setLbladdress2(String lbladdress2) {
	this.lbladdress2 = lbladdress2;
}
	public String getLblcheckedby() {
	return lblcheckedby;
}
public void setLblcheckedby(String lblcheckedby) {
	this.lblcheckedby = lblcheckedby;
}
public String getLblrecievedby() {
	return lblrecievedby;
}
public void setLblrecievedby(String lblrecievedby) {
	this.lblrecievedby = lblrecievedby;
}
public String getLblfinaldate() {
	return lblfinaldate;
}
public void setLblfinaldate(String lblfinaldate) {
	this.lblfinaldate = lblfinaldate;
}
	public String getLbladdress1() {
	return lbladdress1;
}
public void setLbladdress1(String lbladdress1) {
	this.lbladdress1 = lbladdress1;
}
	public String getClstatus() {
	return clstatus;
}
public void setClstatus(String clstatus) {
	this.clstatus = clstatus;
}
	public String getLblamountwords() {
	return lblamountwords;
}
public void setLblamountwords(String lblamountwords) {
	this.lblamountwords = lblamountwords;
}
	public String getLblphone() {
	return lblphone;
}
public void setLblphone(String lblphone) {
	this.lblphone = lblphone;
}
	public String getLbltotal() {
	return lbltotal;
}
public void setLbltotal(String lbltotal) {
	this.lbltotal = lbltotal;
}
public String getLblnetamount() {
	return lblnetamount;
}
public void setLblnetamount(String lblnetamount) {
	this.lblnetamount = lblnetamount;
}
	public String getFormdetail() {
	return formdetail;
}
public void setFormdetail(String formdetail) {
	this.formdetail = formdetail;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
	public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
	public String getLblbranch() {
	return lblbranch;
}
public void setLblbranch(String lblbranch) {
	this.lblbranch = lblbranch;
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
public String getLblclient() {
	return lblclient;
}
public void setLblclient(String lblclient) {
	this.lblclient = lblclient;
}
public String getLblaccount() {
	return lblaccount;
}
public void setLblaccount(String lblaccount) {
	this.lblaccount = lblaccount;
}
public String getLblmobile() {
	return lblmobile;
}
public void setLblmobile(String lblmobile) {
	this.lblmobile = lblmobile;
}
public String getLblfax() {
	return lblfax;
}
public void setLblfax(String lblfax) {
	this.lblfax = lblfax;
}
public String getLbldriven() {
	return lbldriven;
}
public void setLbldriven(String lbldriven) {
	this.lbldriven = lbldriven;
}
public String getLblmrano() {
	return lblmrano;
}
public void setLblmrano(String lblmrano) {
	this.lblmrano = lblmrano;
}
public String getLblcontractstart() {
	return lblcontractstart;
}
public void setLblcontractstart(String lblcontractstart) {
	this.lblcontractstart = lblcontractstart;
}
public String getLblinvno() {
	return lblinvno;
}
public void setLblinvno(String lblinvno) {
	this.lblinvno = lblinvno;
}
public String getLbldate() {
	return lbldate;
}
public void setLbldate(String lbldate) {
	this.lbldate = lbldate;
}

public String getLblratype() {
	return lblratype;
}
public void setLblratype(String lblratype) {
	this.lblratype = lblratype;
}
public String getLblrano() {
	return lblrano;
}
public void setLblrano(String lblrano) {
	this.lblrano = lblrano;
}
public String getLblinvfrom() {
	return lblinvfrom;
}
public void setLblinvfrom(String lblinvfrom) {
	this.lblinvfrom = lblinvfrom;
}
public String getLblinvto() {
	return lblinvto;
}
public void setLblinvto(String lblinvto) {
	this.lblinvto = lblinvto;
}
public String getLblcontractvehicle() {
	return lblcontractvehicle;
}
public void setLblcontractvehicle(String lblcontractvehicle) {
	this.lblcontractvehicle = lblcontractvehicle;
}
	public String getLblcompname() {
	return lblcompname;
}
public void setLblcompname(String lblcompname) {
	this.lblcompname = lblcompname;
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



public String getCmbagmttype() {
	return cmbagmttype;
}



public void setCmbagmttype(String cmbagmttype) {
	this.cmbagmttype = cmbagmttype;
}



public String getHidcmbagmttype() {
	return hidcmbagmttype;
}



public void setHidcmbagmttype(String hidcmbagmttype) {
	this.hidcmbagmttype = hidcmbagmttype;
}



public int getAgmtno() {
	return agmtno;
}



public void setAgmtno(int agmtno) {
	this.agmtno = agmtno;
}



public String getClient() {
	return client;
}



public void setClient(String client) {
	this.client = client;
}



public String getClientdetails() {
	return clientdetails;
}



public void setClientdetails(String clientdetails) {
	this.clientdetails = clientdetails;
}



public String getDriver() {
	return driver;
}



public void setDriver(String driver) {
	this.driver = driver;
}



public String getDriverdetails() {
	return driverdetails;
}



public void setDriverdetails(String driverdetails) {
	this.driverdetails = driverdetails;
}



public String getContractvehicle() {
	return contractvehicle;
}



public void setContractvehicle(String contractvehicle) {
	this.contractvehicle = contractvehicle;
}



public String getVehicledetails() {
	return vehicledetails;
}



public void setVehicledetails(String vehicledetails) {
	this.vehicledetails = vehicledetails;
}



public String getFromdate() {
	return fromdate;
}



public void setFromdate(String fromdate) {
	this.fromdate = fromdate;
}



public String getHidfromdate() {
	return hidfromdate;
}



public void setHidfromdate(String hidfromdate) {
	this.hidfromdate = hidfromdate;
}



public String getTodate() {
	return todate;
}



public void setTodate(String todate) {
	this.todate = todate;
}



public String getHidtodate() {
	return hidtodate;
}



public void setHidtodate(String hidtodate) {
	this.hidtodate = hidtodate;
}



public String getLedgernote() {
	return ledgernote;
}



public void setLedgernote(String ledgernote) {
	this.ledgernote = ledgernote;
}



public String getInvoicenote() {
	return invoicenote;
}



public void setInvoicenote(String invoicenote) {
	this.invoicenote = invoicenote;
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



public String getAcno() {
	return acno;
}



public void setAcno(String acno) {
	this.acno = acno;
}



public String getHidclient() {
	return hidclient;
}



public void setHidclient(String hidclient) {
	this.hidclient = hidclient;
}



public int getGridlength() {
	return gridlength;
}



public void setGridlength(int gridlength) {
	this.gridlength = gridlength;
}



public String getDtype() {
	return dtype;
}



public void setDtype(String dtype) {
	this.dtype = dtype;
}

private Map<String, Object> param=null;


public Map<String, Object> getParam() {
	return param;
}
public void setParam(Map<String, Object> param) {
	this.param = param;
}

	/**
	 * @return
	 * @throws ParseException
	 * @throws SQLException 
	 */
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
		Map<String, String[]> requestParams = request.getParameterMap();
		session.getAttribute("BranchName");
		
		//System.out.println("request==="+request.getAttribute("BranchName"));
		
		String mode=getMode();
		ClsManualInvoiceBean bean=new ClsManualInvoiceBean();
		java.sql.Date date = null;
		java.sql.Date fromdate=null ;
		java.sql.Date todate=null;
		java.sql.Date garagecollectdate=null;
		Connection conn=null;
		try{
			
			
			
	if((mode.equalsIgnoreCase("A"))||mode.equalsIgnoreCase("close")||mode.equalsIgnoreCase("D") || mode.equalsIgnoreCase("E")){
		if(getDate()!=null && !getDate().equalsIgnoreCase("")){
			date = objcommon.changeStringtoSqlDate(getDate());	
		}
		if(getFromdate()!=null && !getFromdate().equalsIgnoreCase("")){
			fromdate = objcommon.changeStringtoSqlDate(getFromdate());	
		}
		if(getTodate()!=null && !getTodate().equalsIgnoreCase("")){
			todate = objcommon.changeStringtoSqlDate(getTodate());	
		}
		
		
	}
		if(mode.equalsIgnoreCase("A")){
		//	System.out.println("Inside Action Mode A");
			ArrayList<String> invoicearray = new ArrayList<>();
			//System.out.println("inside tarifsave");
			for(int i=0;i<getGridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
				//System.out.println("request =========="+request.getAttribute("test"+i));
				String temp=requestParams.get("test"+i)[0];
				
				invoicearray.add(temp);
				//System.out.println(invoicearray.get(i));
			}
			/*String value1=invoicearray.get(1);
			System.out.println("Value1"+value1);*/
			//System.out.println("Unsaved Data"+getHidgarage()+getHidchkgaragedelivery()+getHidchkgaragecollect());
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			setDtype("INV###1");
			String qty2=objcommon.getMonthandDays(todate, fromdate, conn);
						int val=manualinvoiceDAO.insert(conn,invoicearray,getCmbagmttype(),date,getHidclient(),getAgmtno(),getLedgernote(),getInvoicenote(),fromdate,todate,
								session.getAttribute("BRANCHID").toString(),session.getAttribute("USERID").toString(),session.getAttribute("CURRENCYID").toString(),
								getMode(),getAcno(),getDtype(),getFormdetailcode(),qty2);
						if(val>0.0){
							conn.commit();
							setVoucherno(manualinvoiceDAO.getVoucherno(val));
							setAgmtvoucherno(getAgmtvoucherno());
							setHidcmbagmttype(getCmbagmttype());
							setAgmtno(getAgmtno());
							setHidclient(getHidclient());
							setClient(getClient());
							setClientdetails(getClientdetails());
							setAcno(getAcno());
							setContractvehicle(getContractvehicle());
							setVehicledetails(getVehicledetails());
							setDriver(getDriver());
							setDriverdetails(getDriverdetails());
							setFromdate(fromdate.toString());
							setTodate(todate.toString());
							setDate(date.toString());
							setLedgernote(getLedgernote());
							setInvoicenote(getInvoicenote());
							
							//System.out.println("Action Value"+val);
							setDocno(val);
							setMsg("Successfully Saved");
							conn.close();
							return "success";
						}
						else{
							setHidcmbagmttype(getCmbagmttype());
							setVoucherno(0);
							setAgmtno(getAgmtno());
							setHidclient(getHidclient());
							setClient(getClient());
							setClientdetails(getClientdetails());
							setAcno(getAcno());
							setContractvehicle(getContractvehicle());
							setVehicledetails(getVehicledetails());
							setDriver(getDriver());
							setDriverdetails(getDriverdetails());
							setFromdate(fromdate.toString());
							setTodate(todate.toString());
							setDate(date.toString());
							setLedgernote(getLedgernote());
							setInvoicenote(getInvoicenote());
							setAgmtvoucherno(getAgmtvoucherno());
//							System.out.println(val);
							setDocno(val);
							setMsg("Not Saved");
							conn.close();
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("View")){
			//System.out.println("view===="+getDocno());
					bean=manualinvoiceDAO.getViewDetails(getDocno(),getBrchName(),getCmbagmttype());
setDocno(bean.getDocno());
setVoucherno(bean.getVoucherno());
setAgmtno(bean.getAgmtno());
setDate(bean.getHiddate());
setFromdate(bean.getHidfromdate());
setTodate(bean.getHidtodate());
setHidclient(bean.getHidclient());
setAcno(bean.getAcno());
setClientdetails(bean.getClientdetails());
setClient(bean.getClient());
setContractvehicle(bean.getContractvehicle());
setVehicledetails(bean.getVehicledetails());
setDriver(bean.getDriver());
setDriverdetails(bean.getDriverdetails());
setHidcmbagmttype(bean.getHidcmbagmttype());
setLedgernote(bean.getLedgernote());
setInvoicenote(bean.getInvoicenote());
setAgmtvoucherno(bean.getAgmtvoucherno());
setEmail(bean.getEmail());
		}
		
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> invoicearray = new ArrayList<>();
			
			for(int i=0;i<getGridlength();i++){

				String temp=requestParams.get("test"+i)[0];
				
				String idno=temp.split("::")[0];
				
				if(!(idno.equalsIgnoreCase("13")) && !(idno.equalsIgnoreCase("19")) && !(idno.equalsIgnoreCase("20"))){
					//System.out.println("TEMP: "+temp);
					invoicearray.add(temp);	
				}
				
			}
			
			/*int i=0;
			while(i<invoicearray.size()){
				System.out.println(invoicearray.get(i));
				i++;
			}*/
			//setDtype("INV:MANUAL");
			conn=objconn.getMyConnection();
				conn.setAutoCommit(false);
				String qty2=objcommon.getMonthandDays(todate, fromdate, conn);
				boolean status=manualinvoiceDAO.edit(conn,invoicearray,getCmbagmttype(),date,getHidclient(),getAgmtno(),getLedgernote(),getInvoicenote(),fromdate,todate,
						getBrchName(),session.getAttribute("USERID").toString(),session.getAttribute("CURRENCYID").toString(),
						getMode(),getAcno(),getDtype(),getFormdetailcode(),qty2,getDocno());
				if(status){
					conn.commit();
					setAgmtvoucherno(getAgmtvoucherno());
					setHidcmbagmttype(getCmbagmttype());
					setAgmtno(getAgmtno());
					setHidclient(getHidclient());
					setClient(getClient());
					setClientdetails(getClientdetails());
					setAcno(getAcno());
					setContractvehicle(getContractvehicle());
					setVehicledetails(getVehicledetails());
					setDriver(getDriver());
					setDriverdetails(getDriverdetails());
					setFromdate(fromdate.toString());
					setTodate(todate.toString());
					setDate(date.toString());
					setLedgernote(getLedgernote());
					setInvoicenote(getInvoicenote());
				
					setDocno(getDocno());
					setMsg("Updated Successfully");
					conn.close();
					return "success";
				}
				else{
					setHidcmbagmttype(getCmbagmttype());
					setAgmtno(getAgmtno());
					setHidclient(getHidclient());
					setClient(getClient());
					setClientdetails(getClientdetails());
					setAcno(getAcno());
					setContractvehicle(getContractvehicle());
					setVehicledetails(getVehicledetails());
					setDriver(getDriver());
					setDriverdetails(getDriverdetails());
					setFromdate(fromdate.toString());
					setTodate(todate.toString());
					setDate(date.toString());
					setLedgernote(getLedgernote());
					setInvoicenote(getInvoicenote());
					setAgmtvoucherno(getAgmtvoucherno());
					setDocno(getDocno());
					setMsg("Not Updated");
					conn.close();
					return "fail";
				}	
			
			
		}
		
		
		
/*		else if(mode.equalsIgnoreCase("print")){
			System.out.println("Here in"+mode);
			bean=ClsManualInvoiceDAO.getPrint(getDocno(),getCmbagmttype());
			setLblcompname(bean.getLblcompname());
			setLblcompaddress(bean.getLblcompaddress());
			setLblcompfax(bean.getLblcompfax());
			setLblcomptel(bean.getLblcomptel());
			setLblprintname("Invoice");
			setLblbranch(bean.getLblbranch());
			setLblclient(bean.getLblclient());
			setLblaccount(bean.getLblaccount());
			setLblmobile(bean.getLblmobile());
			setLblfax(bean.getLblfax());
			setLbldriven(bean.getLbldriven());
			setLblcontractstart(bean.getLblcontractstart());
			setLblmrano(bean.getLblmrano());
			setLblinvno(bean.getLblinvno());
			setLbldate(bean.getLbldate());
			setLblrano(bean.getLblrano());
			setLblinvfrom(bean.getLblinvfrom());
			setLblinvto(bean.getLblinvto());
			setLblcontractvehicle(bean.getLblcontractvehicle());
			setLblratype(bean.getLblratype());
			System.out.println(getLblcompname());
		
			ArrayList<String> printdet=ClsManualInvoiceDAO.getPrintdetails(getDocno());
			request.setAttribute("INVPRINT", printdet);
		return "print";
		}*/
		
		else if(mode.equalsIgnoreCase("D")){
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			boolean Status=manualinvoiceDAO.delete(conn,getDocno(),date,fromdate,todate,getCmbagmttype(),getAgmtno(),getBrchName(),session.getAttribute("USERID").toString(),getFormdetailcode());
		if(Status){
			
		conn.commit();
			setHidcmbagmttype(getCmbagmttype());
			setAgmtno(getAgmtno());
			setHidclient(getHidclient());
			setClient(getClient());
			setClientdetails(getClientdetails());
			setAcno(getAcno());
			setContractvehicle(getContractvehicle());
			setVehicledetails(getVehicledetails());
			setDriver(getDriver());
			setDriverdetails(getDriverdetails());
			setFromdate(fromdate.toString());
			setTodate(todate.toString());
			setDate(date.toString());
			setLedgernote(getLedgernote());
			setInvoicenote(getInvoicenote());setAgmtvoucherno(getAgmtvoucherno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			conn.close();
			return "success";
		}
		else{
			setHidcmbagmttype(getCmbagmttype());
			setAgmtno(getAgmtno());
			setHidclient(getHidclient());
			setClient(getClient());
			setClientdetails(getClientdetails());
			setAcno(getAcno());
			setContractvehicle(getContractvehicle());
			setVehicledetails(getVehicledetails());
			setDriver(getDriver());
			setDriverdetails(getDriverdetails());
			setFromdate(fromdate.toString());
			setTodate(todate.toString());
			setDate(date.toString());
			setLedgernote(getLedgernote());setAgmtvoucherno(getAgmtvoucherno());
			setInvoicenote(getInvoicenote());
			setMsg("Not Deleted");
			conn.close();
			return "fail";
		}
		}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return "fail";
		

	}
	
	public String printAction() throws ParseException, SQLException{
		//System.out.println("Inside print Action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		//System.out.println("Check Type:"+getCmbagmttype());
		setUrl(objcommon.getPrintPath("INV"));
		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		bean=manualinvoiceDAO.getPrint(request.getParameter("fromno"),request.getParameter("tono"),request.getParameter("branch"),request.getParameter("printdocno"),allbranch,hidheader);
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLbladdress1(lbladdress1);
		setLblprintname("Invoice");
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLblbranch(bean.getLblbranch());
		setLblclient(bean.getLblclient());
		setLblaccount(bean.getLblaccount());
		setLblphone(bean.getLblphone());
		setLblmobile(bean.getLblmobile());
		setLblfax(bean.getLblfax());
		setLbldriven(bean.getLbldriven());
		setLblcontractstart(bean.getLblcontractstart());
		setLblmrano(bean.getLblmrano());
		setLblinvno(bean.getLblinvno());
		setLbldate(bean.getLbldate());
		setLblrano(bean.getLblrano());
		setLblinvfrom(bean.getLblinvfrom());
		setLblinvto(bean.getLblinvto());
		setLblcontractvehicle(bean.getLblcontractvehicle());
		setLblratype(bean.getLblratype());
		setLbltotal(bean.getLbltotal());
		setLblnetamount(bean.getLblnetamount());
		setLbldriven(bean.getLbldriven());
		setLblamountwords(bean.getLblamountwords());
		setLblcheckedby(session.getAttribute("USERNAME").toString());
		setLblfinaldate(bean.getLblfinaldate());
		setLbllocation(bean.getLbllocation());
		setLbllpono(bean.getLbllpono());
		setLblbranchcode(bean.getLblbranchcode());
		setLbldateyear(bean.getLbldateyear());
		//System.out.println(getLblcompname());
		//System.out.println("check Session:"+session.getAttribute("USERNAME").toString().trim());
		
		
		/*if(salikdet.size()>0){
			setLblsalikcount(salikdet.size()+"");
		}
		else{
			setLblsalikcount(0+"");
		}*/
		return "print";
	}
	

		public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  ClsRentalAgentDAO agentdao=new ClsRentalAgentDAO();
			  try {
				  List <ClsRentalAgentBean> list= agentdao.list();
				  for(ClsRentalAgentBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.getRentalagentdate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				 cellarray.add(cellobj);

				 }
			 //System.out.println("cellobj"+cellarray);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}
	
		
		public String emailAction() throws Exception{
			//System.out.println("Inside emailAction");
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			
			
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 String genterms=request.getParameter("genterms")==null?"":request.getParameter("genterms").trim();
			String formcode=request.getParameter("formcode")==null?"NA":request.getParameter("formcode").trim();
			String filename="";
			int isindian=0;
			String recep=request.getParameter("recep").trim();

			bean=manualinvoiceDAO.sendMail(request.getParameter("docno").toString().trim(),request.getParameter("branch"));
			
			HashMap printdetin=new HashMap();
			   printdetin=manualinvoiceDAO.getEmailPrintdetails(request.getParameter("docno").toString().trim());
			   
			   //System.out.println("==printdetin==printdetin==="+printdetin.get(2));
			   
	//System.out.println("==bean.getLblrano==="+bean.getLblrano()+"===bean.getLblinvfrom=="+objcommon.getSqlDate(bean.getLblinvfrom())+"==bean.getLblinvto===="+bean.getLblinvto()+"==bean.getLblratype===="+bean.getLblratype());

				ArrayList<String> printfleet=new ArrayList<>();
				printfleet=manualinvoiceDAO.getFleetdetailsmail (bean.getLblrano(),objcommon.getSqlDate(bean.getLblinvfrom()),objcommon.getSqlDate(bean.getLblinvto()),bean.getLblratype());
				
				
				ArrayList<String> salikdet=new ArrayList<>();
				salikdet=manualinvoiceDAO.getSalikDetails(request.getParameter("docno").toString().trim());
				
			 	
				ArrayList<String> trafficdetdubai=new ArrayList<>();
				trafficdetdubai=manualinvoiceDAO.getTrafficDetailsDubai(request.getParameter("docno").toString().trim());
				
				
				ArrayList<String> trafficdetelse=new ArrayList<>();
				 trafficdetelse=manualinvoiceDAO.getTrafficDetailsElse(request.getParameter("docno").toString().trim());

				 filename=manualinvoiceDAO.getFileName(formcode);
				 
				 isindian=manualinvoiceDAO.getCompChk();
			
				 Locale currentLocale = request.getLocale();
				 
				 //System.out.println("getDisplayLanguagegetDisplayLanguage"+currentLocale.getDisplayLanguage());
				 //System.out.println(currentLocale.getDisplayCountry());
				  
				 //System.out.println(currentLocale.getLanguage());
				 //System.out.println(currentLocale.getCountry());
				 
			setLblcompname(bean.getLblcompname());
			setLblcompaddress(bean.getLblcompaddress());
			setLbladdress1(lbladdress1);
			setLblprintname("Invoice");
			setLblcompfax(bean.getLblcompfax());
			setLblcomptel(bean.getLblcomptel());
			setLblbranch(bean.getLblbranch());
			setLblclient(bean.getLblclient());
			setLblaccount(bean.getLblaccount());
			setLbladdress1(bean.getLbladdress1());
			setLbladdress2(bean.getLbladdress2());
			setLblphone(bean.getLblphone());
			setLblmobile(bean.getLblmobile());
			setLblfax(bean.getLblfax());
			setLbldriven(bean.getLbldriven());
			setLblcontractstart(bean.getLblcontractstart());
			setLblmrano(bean.getLblmrano());
			setLblinvno(bean.getLblinvno());
			setLbldate(bean.getLbldate());
			setLblrano(bean.getLblrano());
			setLblinvfrom(bean.getLblinvfrom());
			setLblinvto(bean.getLblinvto());
			setLblcontractvehicle(bean.getLblcontractvehicle());
			setLblratype(bean.getLblratype());
			setLbltotal(bean.getLbltotal());
			setLblnetamount(bean.getLblnetamount());
			setLbldriven(bean.getLbldriven());
			setLblamountwords(bean.getLblamountwords());
			setLblcheckedby(session.getAttribute("USERNAME").toString());
			setLblfinaldate(bean.getLblfinaldate());
			setLbllocation(bean.getLbllocation());
			setLbllpono(bean.getLbllpono());
			setLblbranchcode(bean.getLblbranchcode());
			setLbldateyear(bean.getLbldateyear());
			setLblrecievedby(bean.getLblrecievedby());
			setTinno(bean.getTinno());
			setLblservicetax(bean.getLblservicetax());
			setLblcstno(bean.getLblcstno());
			//System.out.println("===filename===="+filename);
			
			 String [] path=filename.split("attachment");
			   String path1=path[0];
			  
			
			
			ClspdfCreate pdfcreate= new ClspdfCreate();
			
			if(isindian==1){
				
				pdfcreate.pdfCreateLocal(filename, path1,getLblcompname(),getLblcompaddress(),getLblcompfax(),getLblcomptel(),
						getLblbranch(),getLblclient(),getLblaccount(),getLbladdress1(),getLbladdress2(),getLblphone(),getLblmobile(),getLblfax(),
					    getLbldriven(),getLblcontractstart(),getLblmrano(),getLblinvno(),getLbldate(),getLblrano(),
						getLblinvfrom(),getLblinvto(),getLblcontractvehicle(),getLblratype(),getLbltotal(),getLblnetamount(),
						getLblamountwords(),getLblcheckedby(),getLblfinaldate(),getLbllocation(),getLbllpono(),
						getLblbranchcode(),getLbldateyear(),printdetin,printfleet,getLblrecievedby(),formcode,recep,session,getLblbranchcode(),getTinno(),getLblservicetax(),getLblcstno());
			}
			
			else{
				
				pdfcreate.pdfCreate(filename, path1,getLblcompname(),getLblcompaddress(),getLblcompfax(),getLblcomptel(),
						getLblbranch(),getLblclient(),getLblaccount(),getLbladdress1(),getLbladdress2(),getLblphone(),getLblmobile(),getLblfax(),
					    getLbldriven(),getLblcontractstart(),getLblmrano(),getLblinvno(),getLbldate(),getLblrano(),
						getLblinvfrom(),getLblinvto(),getLblcontractvehicle(),getLblratype(),getLbltotal(),getLblnetamount(),
						getLblamountwords(),getLblcheckedby(),getLblfinaldate(),getLbllocation(),getLbllpono(),
						getLblbranchcode(),getLbldateyear(),printdetin,printfleet,getLblrecievedby(),formcode,recep);
						
			}
			
			
			
			return "print";
		}	


		public void printActionJasper() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
		    HttpServletResponse response = ServletActionContext.getResponse();
			
			String email=request.getParameter("email")==null?"":request.getParameter("email");
	  
		    String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
			String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
			String fromno=request.getParameter("fromno");
			String tono=request.getParameter("tono");
			String branch=request.getParameter("branch");
			String printdoc=request.getParameter("printdocno");
			String refid=request.getParameter("vocno");
			String brhid=request.getParameter("brhid");
			bean=manualinvoiceDAO.getPrint(request.getParameter("fromno"),request.getParameter("tono"),request.getParameter("branch"),request.getParameter("printdocno"),allbranch,hidheader);
			
			String reportFileName = "invoicetobedispatch";
			 param = new HashMap();
			
			 Connection conn = null;
			 try {
		         	 conn = objconn.getMyConnection();
	            	Statement stmtPC = conn.createStatement();
	            	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	               	imgpath=imgpath.replace("\\", "\\\\");
	            	String imgdubaigov=request.getSession().getServletContext().getRealPath("/icons/dubaigovlogo.jpg");
	            	imgdubaigov=imgdubaigov.replace("\\", "\\\\");
	            	String imgrtalogo=request.getSession().getServletContext().getRealPath("/icons/rtalogo.jpg");
	            	imgrtalogo=imgrtalogo.replace("\\", "\\\\");
	            	String imgtrafficbanner=request.getSession().getServletContext().getRealPath("/icons/traffic_banner.jpg");
	            	imgtrafficbanner=imgtrafficbanner.replace("\\", "\\\\");
	        	 param.put("printname", "INVOICE");
	        	 param.put("imgpath", imgpath);
	        	 param.put("imgdubaigov", imgdubaigov);
	        	 param.put("imgrtalogo", imgrtalogo);
	        	 param.put("imgtrafficbanner", imgtrafficbanner);
		         param.put("compname", bean.getLblcompname());
		         param.put("compaddress", bean.getLblcompaddress());
		        
		         param.put("comptel", bean.getLblcomptel());
		         param.put("compfax", bean.getLblcompfax());
		         param.put("compbranch", bean.getLblbranch());
		         param.put("location", bean.getLbllocation());
		       
			         param.put("custname", bean.getLblclient());
			         param.put("custcode", bean.getLblaccount());
			         param.put("custaddress", bean.getLbladdress1());
			         param.put("custaddress2", bean.getLbladdress2());
			         param.put("mob", bean.getLblmobile());
		        	 param.put("phone", bean.getLblphone());
		        	 param.put("driven", bean.getLbldriven());
			         param.put("invno", bean.getLblinvno());
			         param.put("custdate", bean.getLbldate());
			          param.put("rano", bean.getLblrano());
		        	 param.put("lpono", bean.getLbllpono());
		        	 param.put("mrano", bean.getLblmrano());
			         param.put("type", bean.getLblratype());
			         param.put("contstart", bean.getLblcontractstart());
			         param.put("invfromdate", bean.getLblinvfrom());
			         param.put("invtodate", bean.getLblinvto());
			          param.put("invfromtime", bean.getLblinvfromtime());
		        	 param.put("invtotime", bean.getLblinvtotime());
		        	 param.put("contveh", bean.getLblcontractvehicle());
			         param.put("curveh", bean.getLblcurrentvehicle());
			         param.put("processby", bean.getLblcheckedby());
			         param.put("recvby", bean.getLblrecievedby());
			          param.put("processdate", bean.getLblfinaldate());
		        	 param.put("total", bean.getJasptotal());
			         param.put("netamount", bean.getJaspnetamount());
			         param.put("amountwords", bean.getLblamountwords());
			         param.put("printby", session.getAttribute("USERNAME"));
	        	
			         param.put("printdetailsql", bean.getPrintdetailsql());
		        	 param.put("otherfleetsql", bean.getOtherfleetsql());
			         param.put("saliksql", bean.getSaliksql());
			         param.put("trafficdubaisql", bean.getTrafficdubaisql());
			         param.put("trafficabudhabisql", bean.getTrafficabudhabusql());
			         param.put("showfees", new Integer(bean.getLblshowfees()));
			         
		    //   	 System.out.println("paramm=="+param);
	                       JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/invoices/invoicetodispatch/" + reportFileName + ".jrxml"));
	     	 
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                       generateReportPDF(response, param, jasperReport, conn,email,session,printdoc,brhid,refid);
	                 
	      
	             } catch (Exception e) {

	                 e.printStackTrace();

	             }
			 finally{
					conn.close();
				}
	      		}
		
		  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email,HttpSession session,String printdoc,String brhid,String refid)throws JRException, NamingException, SQLException, IOException, MessagingException, javax.mail.MessagingException {
		  /*private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {*/	  
			  byte[] bytes = null;
	          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	          resp.reset();
	          resp.resetBuffer();
	          
	          resp.setContentType("application/pdf");
	          resp.setContentLength(bytes.length);
	          ServletOutputStream ouputStream = resp.getOutputStream();
	         
	          /*if(print.equalsIgnoreCase("1")) { 
	          
		          ouputStream.write(bytes, 0, bytes.length);
		          ouputStream.flush();
		          ouputStream.close();
	         } else {*/
	        	
	        	 Statement stmtleaseapp =conn.createStatement();
	        	  
	        	String fileName="",path="", formcode="BIVD",filepath=""; 
	        	String strSql1 = "select imgPath from my_comp";

	      		ResultSet rs1 = stmtleaseapp.executeQuery(strSql1);
	      		while(rs1.next ()) {
	      			path=rs1.getString("imgPath");
	      		}

	      		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
	    		java.util.Date date = new java.util.Date();
	    		String currdate=dateFormat.format(date);
	    		
	      		fileName = "InvoiceToBeDispath"+currdate+".pdf";
	      		filepath=path+ "/attachment/"+formcode+"/"+fileName;

	      		File dir = new File(path+ "/attachment/"+formcode);
	      		dir.mkdirs();
	      		
	      		FileOutputStream fos = new FileOutputStream(filepath);
	        	fos.write(bytes);
	        	fos.flush();
	        	fos.close();
	        	
	        	File saveFile=new File(filepath);
				SendEmailAction sendmail= new SendEmailAction();
				String msg=sendmail.SendTomail(saveFile,formcode,email,printdoc,brhid,session.getAttribute("USERID").toString(),refid);
				/*if(msg=="success")
				{
				String	insql="insert into blaf_email(clientid, reqcalsrno, date, sender) values("+cldocno+","+srno+",NOW(),'"+session.getAttribute("USERID").toString()+"')";
				stmtleaseapp.executeUpdate(insql); 
				}*/
				
	         // }
	               
	      }
		public String getDuedate() {
			return duedate;
		}
		public void setDuedate(String duedate) {
			this.duedate = duedate;
		}
		
		
		
	
	
		
}
