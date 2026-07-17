package com.dashboard.invoices.groupedinvoice;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsGroupedInvoiceAction {
	ClsGroupedInvoiceDAO ClsGroupedInvoiceDAO=new ClsGroupedInvoiceDAO();
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
	private int invgridlength;
	private String lblcurrency;
	
	
	
	
	
	public String getLblcurrency() {
		return lblcurrency;
	}

	public void setLblcurrency(String lblcurrency) {
		this.lblcurrency = lblcurrency;
	}

	public int getInvgridlength() {
		return invgridlength;
	}

	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
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

	public String getLblbranch() {
		return lblbranch;
	}

	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
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

	public String getLblphone() {
		return lblphone;
	}

	public void setLblphone(String lblphone) {
		this.lblphone = lblphone;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
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

	public String getLblamountwords() {
		return lblamountwords;
	}

	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}

	public String getClstatus() {
		return clstatus;
	}

	public void setClstatus(String clstatus) {
		this.clstatus = clstatus;
	}

	public String getLbladdress1() {
		return lbladdress1;
	}

	public void setLbladdress1(String lbladdress1) {
		this.lbladdress1 = lbladdress1;
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

	public String getLbllocation() {
		return lbllocation;
	}

	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}

	public String getLbllpono() {
		return lbllpono;
	}

	public void setLbllpono(String lbllpono) {
		this.lbllpono = lbllpono;
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

	public int getLblsalikcount() {
		return lblsalikcount;
	}

	public void setLblsalikcount(int lblsalikcount) {
		this.lblsalikcount = lblsalikcount;
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

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public int getLbltcno() {
		return lbltcno;
	}

	public void setLbltcno(int lbltcno) {
		this.lbltcno = lbltcno;
	}
	public ClsGroupedInvoiceAction(){}
	public ClsGroupedInvoiceAction(String lblinvno,String lblclient,String lblaccount,String lbldate,String lbladdress1,String lblrano,String lbladdress2,String lbllpono,
			String lblmrano,String lblmobile,String lblratype,String lblphone,String lblcontractstart,String lbldriven,String lblinvfrom,String lblinvto,String lblcontractvehicle,
			String lblcompname, String lblcompaddress, String lblcomptel,String lblcompfax,String lblprintname,String lblbranch,String lbltotal,String lblnetamount,
			String lblamountwords,String lblcheckedby,String lblfinaldate,int lblsalikcount,String lblbranchcode,String lbldateyear,int lbltrafficcountdubai,
			int lbltrafficcountelse,String lbllocation,String lblcurrency)
	{
	   this.lblinvno = lblinvno;
	   this.lblcompname = lblcompname;
	   this.lblcompaddress = lblcompaddress;
	   this.lblcomptel = lblcomptel;
	   this.lblcompfax = lblcompfax;
	   this.lbllocation=lbllocation;
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
	   this.lblcurrency=lblcurrency;
	   //System.out.println("Salik Count: "+this.lblsalikcount);
	 
	/*  this.lblfax = lblfax; 
	   this.lbldriven = lbldriven;
	   this.lblmrano = lblmrano;*/
	}

	public String printAction() throws ParseException, SQLException{
//		System.out.println("Inside print Action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		
		
//		System.out.println(request.getParameter("griddocno").toString());
		ClsGroupedInvoiceBean bean=new ClsGroupedInvoiceBean();
//		System.out.println(request.getParameter("cldocno")+"::"+request.getParameter("fromdate")+"::"+request.getParameter("todate")+"::"+request.getParameter("rentaltype")+"::"+request.getParameter("agmtno")+"::"+request.getParameter("clstatus"));
		bean=ClsGroupedInvoiceDAO.getPrint(request.getParameter("cldocno").toString(),request.getParameter("fromdate").toString(),request.getParameter("todate").toString(),
				request.getParameter("rentaltype").toString(),request.getParameter("agmtno").toString(),request.getParameter("clstatus").toString(),request.getParameter("griddocno").toString());
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLbladdress1(bean.getLbladdress1());
		setLbllocation(bean.getLbllocation());
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
//		System.out.println(getLblcompname()); 
		//System.out.println("check Session:"+session.getAttribute("USERNAME").toString().trim());
		
		
		/*if(salikdet.size()>0){
			setLblsalikcount(salikdet.size()+"");
		}
		else{
			setLblsalikcount(0+"");
		}*/
		return "print";
	}
}
