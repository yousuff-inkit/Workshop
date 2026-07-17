package com.limousine.limoinvoice;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsLimoInvoiceAction {
	ClsCommon objcommon=new ClsCommon();
	ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();
	ClsLimoInvoiceBean invoicebean=new ClsLimoInvoiceBean();
	private int docno;
	private int vocno;
	private String date;
	private String fromdate;
	private String todate;
	private String hidclient;
	private String client;
	private String clientdetails;
	private String ledgernote;
	private String invoicenote;
	private int gridlength;
	private String msg;
	private String mode;
	private String deleted;
	private String formdetailcode;
	private String brchName;
	private int trno;
	private String manual;
	private double mastertotal;
	private String url;
	private String lpono;
	private String eventno;
	
	private String lbldetails;
	private String lblcldocno;
	private String lblclient;
	private String lbldate;
	private String lblvocno;
	private String lblfromdate;
	private String lbltodate;
	private String lblrefno;
	private String lblbookedby;
	private String lblguest;
	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname;
	private String lblbranch;
	private String lblcheckedby;
	private String lblfinaldate;
	private String lblrecievedby;
	private String lblcode,lbladdress,lbladdressother,lblmobileno,lblmail;
	private String lbllpo,lblevent,lblcurrencycode,lbltotal,lblnetamount,lblamountwords;
	
	
	public String getLbllpo() {
		return lbllpo;
	}
	public void setLbllpo(String lbllpo) {
		this.lbllpo = lbllpo;
	}
	public String getLblevent() {
		return lblevent;
	}
	public void setLblevent(String lblevent) {
		this.lblevent = lblevent;
	}
	public String getLblcurrencycode() {
		return lblcurrencycode;
	}
	public void setLblcurrencycode(String lblcurrencycode) {
		this.lblcurrencycode = lblcurrencycode;
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
	public String getLblamountwords() {
		return lblamountwords;
	}
	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}
	public String getLpono() {
		return lpono;
	}
	public void setLpono(String lpono) {
		this.lpono = lpono;
	}
	public String getEventno() {
		return eventno;
	}
	public void setEventno(String eventno) {
		this.eventno = eventno;
	}
	public String getLblcode() {
		return lblcode;
	}
	public void setLblcode(String lblcode) {
		this.lblcode = lblcode;
	}
	public String getLbladdress() {
		return lbladdress;
	}
	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}
	public String getLbladdressother() {
		return lbladdressother;
	}
	public void setLbladdressother(String lbladdressother) {
		this.lbladdressother = lbladdressother;
	}
	public String getLblmobileno() {
		return lblmobileno;
	}
	public void setLblmobileno(String lblmobileno) {
		this.lblmobileno = lblmobileno;
	}
	public String getLblmail() {
		return lblmail;
	}
	public void setLblmail(String lblmail) {
		this.lblmail = lblmail;
	}
	public String getLblcheckedby() {
		return lblcheckedby;
	}
	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}
	public String getLblfinaldate() {
		return lblfinaldate;
	}
	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
	}
	public String getLblrecievedby() {
		return lblrecievedby;
	}
	public void setLblrecievedby(String lblrecievedby) {
		this.lblrecievedby = lblrecievedby;
	}
	
	
	public String getLbldetails() {
		return lbldetails;
	}
	public void setLbldetails(String lbldetails) {
		this.lbldetails = lbldetails;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
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
	public String getLblcldocno() {
		return lblcldocno;
	}
	public void setLblcldocno(String lblcldocno) {
		this.lblcldocno = lblcldocno;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblvocno() {
		return lblvocno;
	}
	public void setLblvocno(String lblvocno) {
		this.lblvocno = lblvocno;
	}
	public String getLblfromdate() {
		return lblfromdate;
	}
	public void setLblfromdate(String lblfromdate) {
		this.lblfromdate = lblfromdate;
	}
	public String getLbltodate() {
		return lbltodate;
	}
	public void setLbltodate(String lbltodate) {
		this.lbltodate = lbltodate;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getLblbookedby() {
		return lblbookedby;
	}
	public void setLblbookedby(String lblbookedby) {
		this.lblbookedby = lblbookedby;
	}
	public String getLblguest() {
		return lblguest;
	}
	public void setLblguest(String lblguest) {
		this.lblguest = lblguest;
	}
	
	public String getManual() {
		return manual;
	}
	public void setManual(String manual) {
		this.manual = manual;
	}
	public double getMastertotal() {
		return mastertotal;
	}
	public void setMastertotal(double mastertotal) {
		this.mastertotal = mastertotal;
	}
	public int getTrno() {
		return trno;
	}
	public void setTrno(int trno) {
		this.trno = trno;
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
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
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
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	public void setValues(int docno,int vocno,int trno,java.sql.Date sqldate,java.sql.Date sqlfromdate,java.sql.Date sqltodate){
		setDocno(docno);
		setVocno(vocno);
		if(sqldate!=null){
			setDate(sqldate.toString());	
		}
		if(sqlfromdate!=null){
			setFromdate(sqlfromdate.toString());
		}
		if(sqltodate!=null){
			setTodate(sqltodate.toString());
		}
		setClient(getClient());
		setClientdetails(getClientdetails());
		setHidclient(getHidclient());
		setInvoicenote(getInvoicenote());
		setLedgernote(getLedgernote());
		setManual(getManual());
		setMastertotal(getMastertotal());
		setTrno(trno);
		
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		java.sql.Date sqldate = null;
		java.sql.Date sqlfromdate=null ;
		java.sql.Date sqltodate=null;
		if(getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(getFromdate()!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
		}
		if(getTodate()!=null){
			sqltodate=objcommon.changeStringtoSqlDate(getTodate());
		}
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> invoicearray = new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("invoice"+i)[0];
				invoicearray.add(temp);
				//System.out.println(invoicearray.get(i));
			}
			for(int i=0;i<invoicearray.size();i++){
				System.out.println(invoicearray.get(i));
			}
			int value=invoicedao.insert(sqldate,sqlfromdate,sqltodate,getHidclient(),getLedgernote(),getInvoicenote(),invoicearray,mode,getFormdetailcode(),request,getBrchName(),session,getManual(),getMastertotal(),getLpono(),getEventno());
			if(value>0){
				int voucher=Integer.parseInt(request.getAttribute("VOUCHER").toString());
				int tran=Integer.parseInt(request.getAttribute("LIMOTRNO").toString());
				setValues(value, voucher,tran, sqldate, sqlfromdate, sqltodate);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				int voucher=Integer.parseInt(request.getAttribute("VOUCHER").toString());
				int tran=Integer.parseInt(request.getAttribute("LIMOTRNO").toString());
				setValues(value, voucher,tran, sqldate, sqlfromdate, sqltodate);
				setMsg("Not Saved");
				return "fail";
			}
				
			}
		
		
		return "fail";
	}
	
	public String printAction() throws ParseException,SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		setUrl(objcommon.getPrintPath("LIN"));
		invoicebean=invoicedao.getPrint(getDocno(),request);
		setLblbookedby(invoicebean.getLblbookedby());
		setLblcldocno(invoicebean.getLblcldocno());
		setLblclient(invoicebean.getLblclient());
		setLbldate(invoicebean.getLbldate());
		setLblfromdate(invoicebean.getLblfromdate());
		setLblguest(invoicebean.getLblguest());
		setLblrefno(invoicebean.getLblrefno());
		setLbltodate(invoicebean.getLbltodate());
		setLblvocno(invoicebean.getLblvocno());
		setLblcompname(invoicebean.getLblcompname());
		setLblcompaddress(invoicebean.getLblcompaddress());
		setLblprintname("Limousine Service Invoice");
		setLblrecievedby(invoicebean.getLblrecievedby());
		setLblcheckedby(invoicebean.getLblcheckedby());
		setLblfinaldate(invoicebean.getLblfinaldate());
		setLblcompfax(invoicebean.getLblcompfax());
		setLblcomptel(invoicebean.getLblcomptel());
		setLblbranch(invoicebean.getLblbranch());
		setLbldetails(invoicebean.getLbldetails());
		setLbladdress(invoicebean.getLbladdress());
		setLblmail(invoicebean.getLblmail());
		setLblmobileno(invoicebean.getLblmobileno());
		setLblevent(invoicebean.getLblevent());
		setLbllpo(invoicebean.getLbllpo());
		setLblcurrencycode(invoicebean.getLblcurrencycode());
		setLbltotal(invoicebean.getLbltotal());
		setLblnetamount(invoicebean.getLblnetamount());
		setLblamountwords(invoicebean.getLblamountwords());
		return "print";
	}
}