package com.operations.commtransactions.rentalrefund;


import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsRentalRefundAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

    
	ClsRentalRefundDAO rentalRefundDAO= new ClsRentalRefundDAO();
	ClsRentalRefundBean rentalRefundBean;

	private int txtrentalrefunddocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxRentalRefundDate;
	private String hidjqxRentalRefundDate;
	private String txtdoctype;
	private int txtsrno;
	private String cmbpaytype;
	private String hidcmbpaytype;
	private int txtdocno;
	private int txtaccid;
	private String txtaccname;
	private String cmbcardtype;
	private String hidcmbcardtype;
	private String txtchequeno;
	private String jqxReferenceDate;
	private String hidjqxReferenceDate;
	private String txtdescription;
	private int chckib;
	private int hidchckib;
	private String cmbbranch;
	private String hidcmbbranch;
	private int txtacno;
	private int txtcldocno;
	private String txtclientid;
	private String txtclientname;
	private String cmbratype;
	private String hidcmbratype;
	private String txtagreement;
	private String txtagreementvocher;
	private String cmbpayedas;
	private String hidcmbpayedas;
	private int txtsecurityacno;
	private double txtamount;
	private double txtdeduction;
	private double txtaddamount;
	private double txtnetamount;
	private double txtonaccountamount;
	private String txtdescriptions;
	private String txtpaidto;
	private int txttranno;
	
	//Security Grid
    private int applylength;
		
	//Security Grid Updating
	private int applylengthupdate;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblcomptel2;
	private String lblcompwebsite;
	private String lblcompemail;
	
	private String receivedfrom;
	private String receiptno;
	private String receiptdate;
	private String rentalno;
	private String rentaltype;
	private String refno;
	private String contractstart;
	private String cardno;
	private String cardexp;
	private String chqno;
	private String chqdate;
	private String amtinwords;
	private String total;
	private String preparedby;
	private String lbladvancesecurity;
	private String lbldescription;
	private String paymode;
	private String amount;
	
	private String url;
	
	//Cheque Print
	private String lblbankid;
	private String lblbankname;
	private String lblpageheight;
	private String lblpagewidth;
	private String lblpagesheight;
	private String lblpageswidth;
	private String lbldatex;
	private String lbldatey;
	private String lblpaytovertical;
	private String lblpaytohorizontal;
	private String lblpaytolength;
	private String lblaccountpayingx;
	private String lblaccountpayingy;
	private String lblamtwordsvertical;
	private String lblamtwordshorizontal;
	private String lblamtwordslength;
	private String lblamountx;
	private String lblamounty;
	private String lblamtwords1vertical;
	private String lblamtwords1horizontal;
	private String lblamtwords1length;
	
	private String lblchequedate;
	private String lblpaidto;
	private String lblaccountno;
	private String lblamountwords;
	private String lblamountwords1;
	private String lblamount;
	
	public int getTxtrentalrefunddocno() {
		return txtrentalrefunddocno;
	}

	public void setTxtrentalrefunddocno(int txtrentalrefunddocno) {
		this.txtrentalrefunddocno = txtrentalrefunddocno;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getJqxRentalRefundDate() {
		return jqxRentalRefundDate;
	}

	public void setJqxRentalRefundDate(String jqxRentalRefundDate) {
		this.jqxRentalRefundDate = jqxRentalRefundDate;
	}

	public String getHidjqxRentalRefundDate() {
		return hidjqxRentalRefundDate;
	}

	public void setHidjqxRentalRefundDate(String hidjqxRentalRefundDate) {
		this.hidjqxRentalRefundDate = hidjqxRentalRefundDate;
	}

	public String getTxtdoctype() {
		return txtdoctype;
	}

	public void setTxtdoctype(String txtdoctype) {
		this.txtdoctype = txtdoctype;
	}

	public int getTxtsrno() {
		return txtsrno;
	}

	public void setTxtsrno(int txtsrno) {
		this.txtsrno = txtsrno;
	}

	public String getCmbpaytype() {
		return cmbpaytype;
	}

	public void setCmbpaytype(String cmbpaytype) {
		this.cmbpaytype = cmbpaytype;
	}

	public String getHidcmbpaytype() {
		return hidcmbpaytype;
	}

	public void setHidcmbpaytype(String hidcmbpaytype) {
		this.hidcmbpaytype = hidcmbpaytype;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public int getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(int txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}
    
	public String getCmbcardtype() {
		return cmbcardtype;
	}

	public void setCmbcardtype(String cmbcardtype) {
		this.cmbcardtype = cmbcardtype;
	}

	public String getHidcmbcardtype() {
		return hidcmbcardtype;
	}

	public void setHidcmbcardtype(String hidcmbcardtype) {
		this.hidcmbcardtype = hidcmbcardtype;
	}
	
	public String getTxtchequeno() {
		return txtchequeno;
	}

	public void setTxtchequeno(String txtchequeno) {
		this.txtchequeno = txtchequeno;
	}

	public String getJqxReferenceDate() {
		return jqxReferenceDate;
	}

	public void setJqxReferenceDate(String jqxReferenceDate) {
		this.jqxReferenceDate = jqxReferenceDate;
	}

	public String getHidjqxReferenceDate() {
		return hidjqxReferenceDate;
	}

	public void setHidjqxReferenceDate(String hidjqxReferenceDate) {
		this.hidjqxReferenceDate = hidjqxReferenceDate;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getChckib() {
		return chckib;
	}

	public void setChckib(int chckib) {
		this.chckib = chckib;
	}

	public int getHidchckib() {
		return hidchckib;
	}

	public void setHidchckib(int hidchckib) {
		this.hidchckib = hidchckib;
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

	public int getTxtacno() {
		return txtacno;
	}

	public void setTxtacno(int txtacno) {
		this.txtacno = txtacno;
	}

	public int getTxtcldocno() {
		return txtcldocno;
	}

	public void setTxtcldocno(int txtcldocno) {
		this.txtcldocno = txtcldocno;
	}

	public String getTxtclientid() {
		return txtclientid;
	}

	public void setTxtclientid(String txtclientid) {
		this.txtclientid = txtclientid;
	}

	public String getTxtclientname() {
		return txtclientname;
	}

	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}

	public String getCmbratype() {
		return cmbratype;
	}

	public void setCmbratype(String cmbratype) {
		this.cmbratype = cmbratype;
	}

	public String getHidcmbratype() {
		return hidcmbratype;
	}

	public void setHidcmbratype(String hidcmbratype) {
		this.hidcmbratype = hidcmbratype;
	}

	public String getTxtagreement() {
		return txtagreement;
	}

	public void setTxtagreement(String txtagreement) {
		this.txtagreement = txtagreement;
	}

	public String getTxtagreementvocher() {
		return txtagreementvocher;
	}

	public void setTxtagreementvocher(String txtagreementvocher) {
		this.txtagreementvocher = txtagreementvocher;
	}

	public String getCmbpayedas() {
		return cmbpayedas;
	}

	public void setCmbpayedas(String cmbpayedas) {
		this.cmbpayedas = cmbpayedas;
	}

	public String getHidcmbpayedas() {
		return hidcmbpayedas;
	}

	public void setHidcmbpayedas(String hidcmbpayedas) {
		this.hidcmbpayedas = hidcmbpayedas;
	}

	public int getTxtsecurityacno() {
		return txtsecurityacno;
	}

	public void setTxtsecurityacno(int txtsecurityacno) {
		this.txtsecurityacno = txtsecurityacno;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public double getTxtdeduction() {
		return txtdeduction;
	}

	public void setTxtdeduction(double txtdeduction) {
		this.txtdeduction = txtdeduction;
	}

	public double getTxtaddamount() {
		return txtaddamount;
	}

	public void setTxtaddamount(double txtaddamount) {
		this.txtaddamount = txtaddamount;
	}

	public double getTxtnetamount() {
		return txtnetamount;
	}
	
	

	public void setTxtnetamount(double txtnetamount) {
		this.txtnetamount = txtnetamount;
	}

	public double getTxtonaccountamount() {
		return txtonaccountamount;
	}

	public void setTxtonaccountamount(double txtonaccountamount) {
		this.txtonaccountamount = txtonaccountamount;
	}

	public String getTxtdescriptions() {
		return txtdescriptions;
	}

	public void setTxtdescriptions(String txtdescriptions) {
		this.txtdescriptions = txtdescriptions;
	}

	public String getTxtpaidto() {
		return txtpaidto;
	}

	public void setTxtpaidto(String txtpaidto) {
		this.txtpaidto = txtpaidto;
	}

	public int getTxttranno() {
		return txttranno;
	}

	public void setTxttranno(int txttranno) {
		this.txttranno = txttranno;
	}

	public int getApplylength() {
		return applylength;
	}

	public void setApplylength(int applylength) {
		this.applylength = applylength;
	}

	public int getApplylengthupdate() {
		return applylengthupdate;
	}

	public void setApplylengthupdate(int applylengthupdate) {
		this.applylengthupdate = applylengthupdate;
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

	public String getLblcstno() {
		return lblcstno;
	}

	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}

	public String getLblcomptel2() {
		return lblcomptel2;
	}

	public void setLblcomptel2(String lblcomptel2) {
		this.lblcomptel2 = lblcomptel2;
	}

	public String getLblcompwebsite() {
		return lblcompwebsite;
	}

	public void setLblcompwebsite(String lblcompwebsite) {
		this.lblcompwebsite = lblcompwebsite;
	}

	public String getLblcompemail() {
		return lblcompemail;
	}

	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}

	public String getReceivedfrom() {
		return receivedfrom;
	}

	public void setReceivedfrom(String receivedfrom) {
		this.receivedfrom = receivedfrom;
	}

	public String getReceiptno() {
		return receiptno;
	}

	public void setReceiptno(String receiptno) {
		this.receiptno = receiptno;
	}

	public String getReceiptdate() {
		return receiptdate;
	}

	public void setReceiptdate(String receiptdate) {
		this.receiptdate = receiptdate;
	}

	public String getRentalno() {
		return rentalno;
	}

	public void setRentalno(String rentalno) {
		this.rentalno = rentalno;
	}

	public String getRentaltype() {
		return rentaltype;
	}

	public void setRentaltype(String rentaltype) {
		this.rentaltype = rentaltype;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getContractstart() {
		return contractstart;
	}

	public void setContractstart(String contractstart) {
		this.contractstart = contractstart;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public String getCardexp() {
		return cardexp;
	}

	public void setCardexp(String cardexp) {
		this.cardexp = cardexp;
	}

	public String getChqno() {
		return chqno;
	}

	public void setChqno(String chqno) {
		this.chqno = chqno;
	}

	public String getChqdate() {
		return chqdate;
	}

	public void setChqdate(String chqdate) {
		this.chqdate = chqdate;
	}

	public String getAmtinwords() {
		return amtinwords;
	}

	public void setAmtinwords(String amtinwords) {
		this.amtinwords = amtinwords;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getPreparedby() {
		return preparedby;
	}

	public void setPreparedby(String preparedby) {
		this.preparedby = preparedby;
	}

	public String getLbladvancesecurity() {
		return lbladvancesecurity;
	}

	public void setLbladvancesecurity(String lbladvancesecurity) {
		this.lbladvancesecurity = lbladvancesecurity;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public String getPaymode() {
		return paymode;
	}

	public void setPaymode(String paymode) {
		this.paymode = paymode;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getLblbankid() {
		return lblbankid;
	}

	public void setLblbankid(String lblbankid) {
		this.lblbankid = lblbankid;
	}

	public String getLblbankname() {
		return lblbankname;
	}

	public void setLblbankname(String lblbankname) {
		this.lblbankname = lblbankname;
	}

	public String getLblpageheight() {
		return lblpageheight;
	}

	public void setLblpageheight(String lblpageheight) {
		this.lblpageheight = lblpageheight;
	}

	public String getLblpagewidth() {
		return lblpagewidth;
	}

	public void setLblpagewidth(String lblpagewidth) {
		this.lblpagewidth = lblpagewidth;
	}

	public String getLblpagesheight() {
		return lblpagesheight;
	}

	public void setLblpagesheight(String lblpagesheight) {
		this.lblpagesheight = lblpagesheight;
	}

	public String getLblpageswidth() {
		return lblpageswidth;
	}

	public void setLblpageswidth(String lblpageswidth) {
		this.lblpageswidth = lblpageswidth;
	}

	public String getLbldatex() {
		return lbldatex;
	}

	public void setLbldatex(String lbldatex) {
		this.lbldatex = lbldatex;
	}

	public String getLbldatey() {
		return lbldatey;
	}

	public void setLbldatey(String lbldatey) {
		this.lbldatey = lbldatey;
	}

	public String getLblpaytovertical() {
		return lblpaytovertical;
	}

	public void setLblpaytovertical(String lblpaytovertical) {
		this.lblpaytovertical = lblpaytovertical;
	}

	public String getLblpaytohorizontal() {
		return lblpaytohorizontal;
	}

	public void setLblpaytohorizontal(String lblpaytohorizontal) {
		this.lblpaytohorizontal = lblpaytohorizontal;
	}

	public String getLblpaytolength() {
		return lblpaytolength;
	}

	public void setLblpaytolength(String lblpaytolength) {
		this.lblpaytolength = lblpaytolength;
	}

	public String getLblaccountpayingx() {
		return lblaccountpayingx;
	}

	public void setLblaccountpayingx(String lblaccountpayingx) {
		this.lblaccountpayingx = lblaccountpayingx;
	}

	public String getLblaccountpayingy() {
		return lblaccountpayingy;
	}

	public void setLblaccountpayingy(String lblaccountpayingy) {
		this.lblaccountpayingy = lblaccountpayingy;
	}

	public String getLblamtwordsvertical() {
		return lblamtwordsvertical;
	}

	public void setLblamtwordsvertical(String lblamtwordsvertical) {
		this.lblamtwordsvertical = lblamtwordsvertical;
	}

	public String getLblamtwordshorizontal() {
		return lblamtwordshorizontal;
	}

	public void setLblamtwordshorizontal(String lblamtwordshorizontal) {
		this.lblamtwordshorizontal = lblamtwordshorizontal;
	}

	public String getLblamtwordslength() {
		return lblamtwordslength;
	}

	public void setLblamtwordslength(String lblamtwordslength) {
		this.lblamtwordslength = lblamtwordslength;
	}

	public String getLblamountx() {
		return lblamountx;
	}

	public void setLblamountx(String lblamountx) {
		this.lblamountx = lblamountx;
	}

	public String getLblamounty() {
		return lblamounty;
	}

	public void setLblamounty(String lblamounty) {
		this.lblamounty = lblamounty;
	}

	public String getLblamtwords1vertical() {
		return lblamtwords1vertical;
	}

	public void setLblamtwords1vertical(String lblamtwords1vertical) {
		this.lblamtwords1vertical = lblamtwords1vertical;
	}

	public String getLblamtwords1horizontal() {
		return lblamtwords1horizontal;
	}

	public void setLblamtwords1horizontal(String lblamtwords1horizontal) {
		this.lblamtwords1horizontal = lblamtwords1horizontal;
	}

	public String getLblamtwords1length() {
		return lblamtwords1length;
	}

	public void setLblamtwords1length(String lblamtwords1length) {
		this.lblamtwords1length = lblamtwords1length;
	}

	public String getLblchequedate() {
		return lblchequedate;
	}

	public void setLblchequedate(String lblchequedate) {
		this.lblchequedate = lblchequedate;
	}

	public String getLblpaidto() {
		return lblpaidto;
	}

	public void setLblpaidto(String lblpaidto) {
		this.lblpaidto = lblpaidto;
	}

	public String getLblaccountno() {
		return lblaccountno;
	}

	public void setLblaccountno(String lblaccountno) {
		this.lblaccountno = lblaccountno;
	}

	public String getLblamountwords() {
		return lblamountwords;
	}

	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}

	public String getLblamountwords1() {
		return lblamountwords1;
	}

	public void setLblamountwords1(String lblamountwords1) {
		this.lblamountwords1 = lblamountwords1;
	}

	public String getLblamount() {
		return lblamount;
	}

	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}

	java.sql.Date rentalRefundDate;
	java.sql.Date referenceDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsRentalRefundBean bean = new ClsRentalRefundBean();

		if(!(getJqxRentalRefundDate()==null || getJqxRentalRefundDate().equalsIgnoreCase(""))){
			 rentalRefundDate = ClsCommon.changeStringtoSqlDate(getJqxRentalRefundDate());
		 }
		
		 if(!(getJqxReferenceDate()==null || getJqxReferenceDate().equalsIgnoreCase(""))){
			 referenceDate = ClsCommon.changeStringtoSqlDate(getJqxReferenceDate());
		 }

		if(mode.equalsIgnoreCase("A")){
			
			/*Security Grid Saving*/
			ArrayList applysecurityarray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applysecurityarray.add(applytemp);
			}
			/*Security Grid Saving Ends*/
			
			int val=rentalRefundDAO.insert(rentalRefundDate,getCmbpaytype(),getTxtdocno(),getCmbcardtype(),getTxtchequeno(),referenceDate,getTxtdescription(),getHidchckib(),
					getCmbbranch(),getTxtcldocno(),getTxtacno(),getCmbratype(),getTxtagreement(),getCmbpayedas(),getTxtsecurityacno(),getTxtamount(),getTxtdeduction(),getTxtaddamount(),
					getTxtnetamount(),getTxtonaccountamount(),getTxtdescriptions(),getTxtpaidto(),applysecurityarray,session,request);
			if(val>0.0){
				
				setTxtrentalrefunddocno(Integer.parseInt(request.getAttribute("documentNo").toString()));               
				setTxttranno(Integer.parseInt(request.getAttribute("transactionno").toString()));
				setTxtsrno(val);    
				setTxtdoctype(request.getAttribute("doctype").toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setMsg("Not Saved");
				return "fail";
			}
		}
		
	
		else if(mode.equalsIgnoreCase("E")){
			
			/*Security Grid Saving*/
			ArrayList applysecurityarray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applysecurityarray.add(applytemp);
			}
			/*Security Grid Saving Ends*/
			
			boolean Status=rentalRefundDAO.edit(getTxtrentalrefunddocno(),getFormdetailcode(),rentalRefundDate,getTxttranno(),getTxtdoctype(),getTxtsrno(),getCmbpaytype(),getTxtdocno(),
					getCmbcardtype(),getTxtchequeno(),referenceDate,getTxtdescription(),getHidchckib(),getCmbbranch(),getTxtcldocno(),getTxtacno(),getCmbratype(),getTxtagreement(),getCmbpayedas(),
					getTxtsecurityacno(),getTxtamount(),getTxtdeduction(),getTxtaddamount(),getTxtnetamount(),getTxtonaccountamount(),getTxtdescriptions(),getTxtpaidto(),applysecurityarray,session);
			if(Status){
					
					setTxtrentalrefunddocno(getTxtrentalrefunddocno());
					setTxttranno(getTxttranno());
					setTxtsrno(getTxtsrno());
					setTxtdoctype(getTxtdoctype());
					setData();
					
					setMsg("Updated Successfully");
					return "success";
			}
			else{
				setTxtrentalrefunddocno(getTxtrentalrefunddocno());
				setTxttranno(getTxttranno());
				setTxtsrno(getTxtsrno());
				setTxtdoctype(getTxtdoctype());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		 else if(mode.equalsIgnoreCase("D")){
			 
			 /*Security Grid Updating*/
				ArrayList applysecurityupdatearray= new ArrayList();
				for(int i=0;i<getApplylengthupdate();i++){
					String applyupdatetemp=requestParams.get("txtapplyupdate"+i)[0];
					applysecurityupdatearray.add(applyupdatetemp);
				}
				/*Security Grid Updating Ends*/
			
			boolean Status=rentalRefundDAO.delete(getTxtrentalrefunddocno(),getFormdetailcode(),getTxtsrno(),getTxttranno(),getTxtdoctype(), getTxtdocno(),applysecurityupdatearray,session);
			if(Status){
					setTxtrentalrefunddocno(getTxtrentalrefunddocno());
					setTxttranno(getTxttranno());
					setTxtsrno(getTxtsrno());
					setTxtdoctype(getTxtdoctype());
					setData();
					
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
			}
			else{
				setTxtrentalrefunddocno(getTxtrentalrefunddocno());
				setTxttranno(getTxttranno());
				setTxtsrno(getTxtsrno());
				setTxtdoctype(getTxtdoctype());
				setData();
				setMsg("Not Deleted");
				return "fail";
			}
		}

		  else if(mode.equalsIgnoreCase("View")){
			    rentalRefundBean=rentalRefundDAO.getViewDetails(session,getTxtsrno());
			
			    setJqxRentalRefundDate(rentalRefundBean.getJqxRentalRefundDate());
				setTxtdoctype(rentalRefundBean.getTxtdoctype());
				setTxtrentalrefunddocno(getTxtrentalrefunddocno());
				setTxtsrno(rentalRefundBean.getTxtsrno());
				
				setHidcmbpaytype(rentalRefundBean.getHidcmbpaytype());
				setTxtaccid(rentalRefundBean.getTxtaccid());
				setTxtaccname(rentalRefundBean.getTxtaccname());
				setTxtdocno(rentalRefundBean.getTxtdocno());
				setTxttranno(rentalRefundBean.getTxttranno());
				setHidcmbcardtype(rentalRefundBean.getHidcmbcardtype());
				setTxtchequeno(rentalRefundBean.getTxtchequeno());
				setJqxReferenceDate(rentalRefundBean.getJqxReferenceDate());
				setTxtdescription(rentalRefundBean.getTxtdescription());
				
				setHidchckib(rentalRefundBean.getHidchckib());
				setHidcmbbranch(rentalRefundBean.getHidcmbbranch());
				setTxtcldocno(rentalRefundBean.getTxtcldocno());
				setTxtacno(rentalRefundBean.getTxtacno());
				setTxtclientid(rentalRefundBean.getTxtclientid());
				setTxtclientname(rentalRefundBean.getTxtclientname());
				setHidcmbratype(rentalRefundBean.getHidcmbratype());
				setTxtagreement(rentalRefundBean.getTxtagreement());
				setTxtagreementvocher(rentalRefundBean.getTxtagreementvocher());
				setHidcmbpayedas(rentalRefundBean.getHidcmbpayedas());
				
				setTxtamount(rentalRefundBean.getTxtamount());
				setTxtdeduction(rentalRefundBean.getTxtdeduction());
				setTxtaddamount(rentalRefundBean.getTxtaddamount());
				setTxtnetamount(rentalRefundBean.getTxtnetamount());
				setTxtonaccountamount(rentalRefundBean.getTxtonaccountamount());
				setTxtdescriptions(rentalRefundBean.getTxtdescriptions());
				setTxtpaidto(rentalRefundBean.getTxtpaidto());
				setTxtsecurityacno(rentalRefundBean.getTxtsecurityacno());
				setFormdetailcode(rentalRefundBean.getFormdetailcode());
				
				return "success";
		}
		return "fail";
}

	public  JSONArray searchDetails(HttpSession session,String accountName,String docNo,String date,String total,String refNo,String contact){
		  JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
		  try {
			cellarray= rentalRefundDAO.rrpMainSearch(session,accountName,docNo,date,total,refNo);
	
		  } catch (SQLException e) {
			  e.printStackTrace();
			  }
		return cellarray;
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int srno=Integer.parseInt(request.getParameter("srno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		rentalRefundBean=rentalRefundDAO.getPrint(srno,branch);
		
	    setLblprintname("Refund Voucher");
	    setUrl(ClsCommon.getPrintPath("RRP"));
		setLblcompname(rentalRefundBean.getLblcompname());
		setLblcompaddress(rentalRefundBean.getLblcompaddress());
		setLblcomptel(rentalRefundBean.getLblcomptel());
		setLblcompfax(rentalRefundBean.getLblcompfax());
		setLblbranch(rentalRefundBean.getLblbranch());
		setLbllocation(rentalRefundBean.getLbllocation());
		setLblservicetax(rentalRefundBean.getLblservicetax());
		setLblpan(rentalRefundBean.getLblpan());
		setLblcstno(rentalRefundBean.getLblcstno());
		setLblcomptel2(rentalRefundBean.getLblcomptel2());
		setLblcompwebsite(rentalRefundBean.getLblcompwebsite());
		setLblcompemail(rentalRefundBean.getLblcompemail());
		setReceivedfrom(rentalRefundBean.getReceivedfrom());
		setReceiptno(rentalRefundBean.getReceiptno());
		setReceiptdate(rentalRefundBean.getReceiptdate());
		setRentalno(rentalRefundBean.getRentalno());
		setRentaltype(rentalRefundBean.getRentaltype());
		setRefno(rentalRefundBean.getRefno());
		setContractstart(rentalRefundBean.getContractstart());
		setLbladvancesecurity(rentalRefundBean.getLbladvancesecurity());
		setLbldescription(rentalRefundBean.getLbldescription());
		setCardno(rentalRefundBean.getCardno());
		setCardexp(rentalRefundBean.getCardexp());
		setChqno(rentalRefundBean.getChqno());
		setChqdate(rentalRefundBean.getChqdate());
		setPaymode(rentalRefundBean.getPaymode());
		setAmount(rentalRefundBean.getAmount());
		setAmtinwords(rentalRefundBean.getAmtinwords());
		setTotal(rentalRefundBean.getTotal());
		setPreparedby(rentalRefundBean.getPreparedby());
	
	return "print";
	}

	public String printChequeAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		int docno=Integer.parseInt(request.getParameter("docno"));
		String dtype=request.getParameter("dtype");
		int branch=Integer.parseInt(request.getParameter("branch"));
		rentalRefundBean=rentalRefundDAO.getChequePrint(docno,dtype,branch);
		setLblbankid(rentalRefundBean.getLblbankid());
		setLblbankname(rentalRefundBean.getLblbankname());
		setLblpageswidth(rentalRefundBean.getLblpageswidth());
		setLblpagesheight(rentalRefundBean.getLblpagesheight());
		setLblpagewidth(rentalRefundBean.getLblpagewidth());
		setLblpageheight(rentalRefundBean.getLblpageheight());
		setLbldatex(rentalRefundBean.getLbldatex());
		setLbldatey(rentalRefundBean.getLbldatey());
		setLblpaytovertical(rentalRefundBean.getLblpaytovertical());
		setLblpaytohorizontal(rentalRefundBean.getLblpaytohorizontal());
		setLblpaytolength(rentalRefundBean.getLblpaytolength());
		setLblaccountpayingx(rentalRefundBean.getLblaccountpayingx());
		setLblaccountpayingy(rentalRefundBean.getLblaccountpayingy());
		setLblamtwordsvertical(rentalRefundBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(rentalRefundBean.getLblamtwordshorizontal());
		setLblamtwordslength(rentalRefundBean.getLblamtwordslength());
		setLblamountx(rentalRefundBean.getLblamountx());
		setLblamounty(rentalRefundBean.getLblamounty());
		setLblamtwords1vertical(rentalRefundBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(rentalRefundBean.getLblamtwords1horizontal());
		setLblamtwords1length(rentalRefundBean.getLblamtwords1length());
		
		setLblchequedate(rentalRefundBean.getLblchequedate());
		setLblpaidto(rentalRefundBean.getLblpaidto());
		setLblaccountno(rentalRefundBean.getLblaccountno());
		setLblamountwords(rentalRefundBean.getLblamountwords());
		setLblamountwords1(rentalRefundBean.getLblamountwords1());
		setLblamount(rentalRefundBean.getLblamount());
		
	return "print";
	}
	
	public void setData(){
		setHidjqxRentalRefundDate(rentalRefundDate.toString());
		setHidcmbpaytype(getCmbpaytype());
		setTxtdocno(getTxtdocno());
		setTxtaccid(getTxtaccid());
		setTxtaccname(getTxtaccname());
		setHidcmbcardtype(getCmbcardtype());
		setTxtchequeno(getTxtchequeno());
		if(!(getJqxReferenceDate()==null || getJqxReferenceDate().equalsIgnoreCase(""))){
			setHidjqxReferenceDate(referenceDate.toString());
		}
		setTxtdescription(getTxtdescription());
		setHidchckib(getHidchckib());
		setHidcmbbranch(getCmbbranch());
		setTxtcldocno(getTxtcldocno());
		setTxtacno(getTxtacno());
		setTxtclientid(getTxtclientid());
		setTxtclientname(getTxtclientname());
		setHidcmbratype(getCmbratype());
		setTxtagreement(getTxtagreement());
		setTxtagreementvocher(getTxtagreementvocher());
		setHidcmbpayedas(getCmbpayedas());
		setTxtsecurityacno(getTxtsecurityacno());
		setTxtamount(getTxtamount());
		setTxtdeduction(getTxtdeduction());
		setTxtaddamount(getTxtaddamount());
		setTxtnetamount(getTxtnetamount());
		setTxtonaccountamount(getTxtonaccountamount());
		setTxtdescriptions(getTxtdescriptions());
		setTxtpaidto(getTxtpaidto());
		setFormdetailcode(getFormdetailcode());
	}
	
}
