package com.operations.marketing.leasecalculator;


import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;

import com.operations.marketing.quotation.ClsquotationDAO;

public class ClsLeaseCalculatorAction extends ActionSupport {
ClsCommon objcommon=new ClsCommon();
ClsLeaseCalculatorDAO calcdao=new ClsLeaseCalculatorDAO();
private int docno;
private int vocno;
private String date;
private String hiddate;
private String leasereqdoc;
private String hidleasereqdoc;
private int reqgridlength;
private String mode;
private String msg;
private String deleted;
private String brchName;
private String formdetailcode;
private String lbldate;
private String lbldocno;
private String lblleasereqdocno;
private String lblcompname;
private String lblcompaddress;
private String lblcomptel;
private String lblcompfax;
private String lblprintname;
private String url;
private String submitstatus;


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
public String getLblprintname() {
	return lblprintname;
}
public void setLblprintname(String lblprintname) {
	this.lblprintname = lblprintname;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}
public String getLbldate() {
	return lbldate;
}
public void setLbldate(String lbldate) {
	this.lbldate = lbldate;
}
public String getLbldocno() {
	return lbldocno;
}
public void setLbldocno(String lbldocno) {
	this.lbldocno = lbldocno;
}
public String getLblleasereqdocno() {
	return lblleasereqdocno;
}
public void setLblleasereqdocno(String lblleasereqdocno) {
	this.lblleasereqdocno = lblleasereqdocno;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getBrchName() {
	return brchName;
}
public void setBrchName(String brchName) {
	this.brchName = brchName;
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
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public int getVocno() {
	return vocno;
}
public void setVocno(int vocno) {
	this.vocno = vocno;
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
public String getLeasereqdoc() {
	return leasereqdoc;
}
public void setLeasereqdoc(String leasereqdoc) {
	this.leasereqdoc = leasereqdoc;
}
public String getHidleasereqdoc() {
	return hidleasereqdoc;
}
public void setHidleasereqdoc(String hidleasereqdoc) {
	this.hidleasereqdoc = hidleasereqdoc;
}
public int getReqgridlength() {
	return reqgridlength;
}
public void setReqgridlength(int reqgridlength) {
	this.reqgridlength = reqgridlength;
}
public String getSubmitstatus() {
	return submitstatus;
}
public void setSubmitstatus(String submitstatus) {
	this.submitstatus = submitstatus;
}
//mm

private String lblclient,lblclientaddress,lblmob,lblemail,lbltypep,lblbranch;

private int docvals,firstarray,secarray;

private String  lbllocation;

public int getFirstarray() {
	return firstarray;
}
public void setFirstarray(int firstarray) { 
	this.firstarray = firstarray; 
}
public int getSecarray() {
	return secarray;
}
public void setSecarray(int secarray) {
	this.secarray = secarray;
}
public String getLblclient() {
	return lblclient;
}
public void setLblclient(String lblclient) {
	this.lblclient = lblclient;
}

public String setLblbranch() {
	return lblbranch;
}
public void setLblbranch(String lblbranch) {
	this.lblbranch = lblbranch;
}

public String getLblclientaddress() {
	return lblclientaddress;
}
public void setLblclientaddress(String lblclientaddress) {
	this.lblclientaddress = lblclientaddress;
}
public String getLblmob() {
	return lblmob;
}
public void setLblmob(String lblmob) {
	this.lblmob = lblmob;
}
public String getLblemail() {
	return lblemail;
}
public void setLblemail(String lblemail) {
	this.lblemail = lblemail;
}
public String getLbltypep() {
	return lbltypep;
}
public void setLbltypep(String lbltypep) {
	this.lbltypep = lbltypep;
}
public int getDocvals() {
	return docvals;
}
public void setDocvals(int docvals) {
	this.docvals = docvals;
}
public String getLbllocation() {
	return lbllocation;
}
public void setLbllocation(String lbllocation) {
	this.lbllocation = lbllocation;
}	


private String terms1,generalterms,terms2;
public String getTerms1() {
	return terms1;
}

public void setTerms1(String terms1) {
	this.terms1 = terms1;
}

public String getGeneralterms() {
	return generalterms;
}

public void setGeneralterms(String generalterms) {
	this.generalterms = generalterms;
}
public String getTerms2() {
	return terms2;
}
public void setTerms2(String terms2) {
	this.terms2 = terms2;
}
private String lblcstno,lblservicetax,lblpan,lbltinno;



public String getLbltinno() {
	return lbltinno;
}
public void setLbltinno(String lbltinno) {
	this.lbltinno = lbltinno;
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









public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	String mode=getMode();
	Map<String, String[]> requestParams = request.getParameterMap();
	java.sql.Date sqldate=null;
	if(!getDate().equalsIgnoreCase("") && getDate()!=null){
		sqldate=objcommon.changeStringtoSqlDate(getDate());
	}
	if(mode.equalsIgnoreCase("A")){
		ArrayList<String> reqarray=new ArrayList<>();
		for(int i=0;i<getReqgridlength();i++){
			String temp=requestParams.get("testreq"+i)[0];
			reqarray.add(temp);
		}
		
		int val=calcdao.insert(sqldate,getHidleasereqdoc(),reqarray,session,getBrchName(),getMode(),getFormdetailcode());
		if(val>0){
			setDocno(val);
			setDate(sqldate.toString());
			setLeasereqdoc(getLeasereqdoc());
			setHidleasereqdoc(getHidleasereqdoc());
			setSubmitstatus("1");
			setMsg("Successfully Saved");
			
			return "success";
		}
		else{
			setDocno(val);
			setDate(sqldate.toString());
			setLeasereqdoc(getLeasereqdoc());
			setHidleasereqdoc(getHidleasereqdoc());
			setMsg("Not Saved");
			setSubmitstatus("1");
			return "fail";
		}
	}
	
	return "fail";
}
public String printAction() throws SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	ClsLeaseCalculatorBean bean=new ClsLeaseCalculatorBean();
	String docno=request.getParameter("docno");
	bean=calcdao.getPrint(docno,request);
	setUrl(objcommon.getPrintPath("LEC"));
	setLbldate(bean.getLbldate());
	setLbldocno(bean.getLbldocno());
	setLblleasereqdocno(bean.getLblleasereqdocno());
	setLblprintname("Lease Calculator");
	setLblcompaddress(bean.getLblcompaddress());
	setLblcompfax(bean.getLblcompfax());
	setLblcompname(bean.getLblcompname());
	setLblcomptel(bean.getLblcomptel());
	return "print";
}


public String printQotAction() throws ParseException, SQLException{
	
	  HttpServletRequest request=ServletActionContext.getRequest();
	 // HttpServletResponse response=ServletActionContext.getResponse();
	 
	 int doc=Integer.parseInt(request.getParameter("docno"));
	  String ckhval=request.getParameter("ckhval")==null?"NA":request.getParameter("ckhval");
	ClsLeaseCalculatorBean pintbean = new ClsLeaseCalculatorBean();
	 pintbean=calcdao.getPrintQot(doc,request);

	 
	
	  //cl details
	 

    setLblclient(pintbean.getLblclient());
    setLblclientaddress(pintbean.getLblclientaddress());
    setLblmob(pintbean.getLblmob());
    setLblemail(pintbean.getLblemail());
    //upper
    setLbldate(pintbean.getLbldate());
    setLbltypep(pintbean.getLbltypep());
    setDocvals(pintbean.getDocvals());
	 
/*	request.setAttribute("details",arraylist); */
	
	
    setLblprintname("Quotation");
  setLblbranch(pintbean.getLblbranch());
   setLblcompname(pintbean.getLblcompname());
  
  setLblcompaddress(pintbean.getLblcompaddress());
 
   setLblcomptel(pintbean.getLblcomptel());
  
  setLblcompfax(pintbean.getLblcompfax());
   setLbllocation(pintbean.getLbllocation());


   setFirstarray(pintbean.getFirstarray());
   setSecarray(pintbean.getSecarray());
   

   setGeneralterms(pintbean.getGeneralterms());
   setTerms1(pintbean.getTerms1());
   setTerms2(pintbean.getTerms2());
   
   
	   if(ckhval.equalsIgnoreCase("test"))
	   {
		   
	
		 // Calendar now = Calendar.getInstance();
		 Calendar now = GregorianCalendar.getInstance();
		 
		SimpleDateFormat df = new SimpleDateFormat("HH");
		String formattedDate = df.format(new Date());
		//System.out.println(formattedDate);
		 
		 String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

			     
		 return SUCCESS; 
	   }
	   else
	   {
		  setLblcstno(pintbean.getLblcstno());
	 	   setLblservicetax(pintbean.getLblservicetax());
		  setLblpan(pintbean.getLblpan());
		   setUrl(objcommon.getPrintPath("QOT"));
		  return "print";   
	   }
	 
	 }	








}