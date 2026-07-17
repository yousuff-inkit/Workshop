package com.operations.commercialreceipt;

import java.sql.Connection;
import java.sql.ResultSet;
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
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.sms.SmsAction;

@SuppressWarnings("serial")
public class ClsCommercialReceiptAction  {
    
	ClsCommercialReceiptDAO commercialReceiptDAO= new ClsCommercialReceiptDAO();
	ClsCommercialReceiptBean commercialReceiptBean;

	private int txtrentalreceiptdocno;
	private String chkstatus;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxRentalReceiptDate;
	private String hidjqxRentalReceiptDate;
	private String txtdoctype;
	private int txtsrno;
	private String cmbpaytype;
	private String hidcmbpaytype;
	private int txtdocno;
	private int txtaccid;
	private String txtaccname;
	private String cmbcardtype;
	private String hidcmbcardtype;
	private String txtrefno;
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
	private double txtamount;
	private double txtdiscount;
	private double txtaddcharges;
	private double txtamounts;
	private double txtnetvalue;
	private String txtdescriptions;
	private String txtreceivedfrom;
	private int txttranno;
	
	private double txtapplyinvoiceamt;
	private double txtapplyinvoiceapply;
	private double txtapplyinvoicebalance;
	
	//Apply-Invoice Grid
	private int applylength;
		
	//Apply-Invoice Grid Updating
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
	private String lblcompemail,lblprintpath;  
	
	public String getLblprintpath() {
		return lblprintpath;
	}

	public void setLblprintpath(String lblprintpath) {
		this.lblprintpath = lblprintpath;
	}

	private String receivedfrom;
	private String clientinfo;
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
	
	//for hide
	private int firstarray,receiptdocno;
	private String email;
	private String url;



	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	public int getTxtrentalreceiptdocno() {
		return txtrentalreceiptdocno;
	}

	public void setTxtrentalreceiptdocno(int txtrentalreceiptdocno) {
		this.txtrentalreceiptdocno = txtrentalreceiptdocno;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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

	public String getJqxRentalReceiptDate() {
		return jqxRentalReceiptDate;
	}

	public void setJqxRentalReceiptDate(String jqxRentalReceiptDate) {
		this.jqxRentalReceiptDate = jqxRentalReceiptDate;
	}

	public String getHidjqxRentalReceiptDate() {
		return hidjqxRentalReceiptDate;
	}

	public void setHidjqxRentalReceiptDate(String hidjqxRentalReceiptDate) {
		this.hidjqxRentalReceiptDate = hidjqxRentalReceiptDate;
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

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
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

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public double getTxtdiscount() {
		return txtdiscount;
	}

	public void setTxtdiscount(double txtdiscount) {
		this.txtdiscount = txtdiscount;
	}

	public double getTxtaddcharges() {
		return txtaddcharges;
	}

	public void setTxtaddcharges(double txtaddcharges) {
		this.txtaddcharges = txtaddcharges;
	}

	public double getTxtamounts() {
		return txtamounts;
	}

	public void setTxtamounts(double txtamounts) {
		this.txtamounts = txtamounts;
	}

	public double getTxtnetvalue() {
		return txtnetvalue;
	}

	public void setTxtnetvalue(double txtnetvalue) {
		this.txtnetvalue = txtnetvalue;
	}

	public String getTxtdescriptions() {
		return txtdescriptions;
	}

	public void setTxtdescriptions(String txtdescriptions) {
		this.txtdescriptions = txtdescriptions;
	}

	public String getTxtreceivedfrom() {
		return txtreceivedfrom;
	}

	public void setTxtreceivedfrom(String txtreceivedfrom) {
		this.txtreceivedfrom = txtreceivedfrom;
	}

	public int getTxttranno() {
		return txttranno;
	}

	public void setTxttranno(int txttranno) {
		this.txttranno = txttranno;
	}

	public double getTxtapplyinvoiceamt() {
		return txtapplyinvoiceamt;
	}

	public void setTxtapplyinvoiceamt(double txtapplyinvoiceamt) {
		this.txtapplyinvoiceamt = txtapplyinvoiceamt;
	}

	public double getTxtapplyinvoiceapply() {
		return txtapplyinvoiceapply;
	}

	public void setTxtapplyinvoiceapply(double txtapplyinvoiceapply) {
		this.txtapplyinvoiceapply = txtapplyinvoiceapply;
	}

	public double getTxtapplyinvoicebalance() {
		return txtapplyinvoicebalance;
	}

	public void setTxtapplyinvoicebalance(double txtapplyinvoicebalance) {
		this.txtapplyinvoicebalance = txtapplyinvoicebalance;
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

	public String getClientinfo() {
		return clientinfo;
	}

	public void setClientinfo(String clientinfo) {
		this.clientinfo = clientinfo;
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

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getReceiptdocno() {
		return receiptdocno;
	}

	public void setReceiptdocno(int receiptdocno) {
		this.receiptdocno = receiptdocno;
	}

	Connection conn;
	java.sql.Date rentalReceiptsDate=null;
	java.sql.Date referenceDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon ClsCommon=new ClsCommon();

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
	try{
		String mode=getMode();
		ClsCommercialReceiptBean bean = new ClsCommercialReceiptBean();

		if(!(getJqxRentalReceiptDate()==null || getJqxRentalReceiptDate().equalsIgnoreCase(""))){
			rentalReceiptsDate = ClsCommon.changeStringtoSqlDate(getJqxRentalReceiptDate());
		}
			 
		if(!(getJqxReferenceDate()==null || getJqxReferenceDate().equalsIgnoreCase(""))){
			referenceDate = ClsCommon.changeStringtoSqlDate(getJqxReferenceDate());
		}

		if(mode.equalsIgnoreCase("A")){
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			/*Apply-Invoice Grid Saving*/
			ArrayList applyinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyinvoicearray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/ 
			
			int val=commercialReceiptDAO.insert(conn,rentalReceiptsDate,getFormdetailcode(),getCmbpaytype(),getTxtdocno(),getCmbcardtype(),getTxtrefno(),referenceDate,getTxtdescription(),getHidchckib(),
					getCmbbranch(),getTxtcldocno(),getTxtacno(),"0","0","1",getTxtamount(),getTxtdiscount(),getTxtaddcharges(),getTxtamounts(),
					getTxtnetvalue(),getTxtdescriptions(),getTxtreceivedfrom(),getTxtapplyinvoiceapply() ,applyinvoicearray,session,request);
			if(val>0.0){
				
				setTxtrentalreceiptdocno(Integer.parseInt(request.getAttribute("documentNo").toString()));               
				setTxttranno(Integer.parseInt(request.getAttribute("transactionno").toString()));
				setTxtsrno(val);    
				setTxtdoctype(request.getAttribute("doctype").toString());
				setData();
				conn.commit();
				
				try
				{

					String status="0";
					ResultSet rs= conn.createStatement(
							ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
					"select  status  from my_msgsettings where dtype='"+getFormdetailcode()+"' and  brhid in ("+session.getAttribute("BRANCHID").toString().trim()+",0) and status=3");

					if(rs.next()) {
						status=rs.getString("status");
					}
					
					if(status.equalsIgnoreCase("3")) {
					
						String phone="",rentalReceiptDate="";
						ResultSet rs1= conn.createStatement(
								ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
										"select per_mob,DATE_FORMAT('"+rentalReceiptsDate+"', '%d-%m-%Y') rentalReceiptDate from my_acbook where doc_no="+getTxtcldocno()+" and dtype='CRM'");
	
						if(rs1.next()) {
							phone=rs1.getString("per_mob");
							rentalReceiptDate=rs1.getString("rentalReceiptDate");
						}
						
						SmsAction sms = new SmsAction();
						sms.doSendSms(phone,getTxtclientname(),String.valueOf(getTxtnetvalue()),String.valueOf(val),rentalReceiptDate,getFormdetailcode(), session.getAttribute("BRANCHID").toString().trim());
						rs1.close();
					}
					
					rs.close();	
				} catch(Exception e){conn.close();e.printStackTrace();}
				
				conn.close();
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setChkstatus("1");
				conn.close();
				setMsg("Not Saved");
				return "fail";
			}
		}
		
	
		  else if(mode.equalsIgnoreCase("E")){
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			/*Apply-Invoice Grid Saving*/
			ArrayList applyinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyinvoicearray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/
			
			/*Apply-Invoice Grid Updating*/
			ArrayList applyinvoiceupdatearray= new ArrayList();
			for(int i=0;i<getApplylengthupdate();i++){
				String applyupdatetemp=requestParams.get("txtapplyupdate"+i)[0];
				applyinvoiceupdatearray.add(applyupdatetemp);
			}
			/*Apply-Invoice Grid Updating Ends*/
			
			boolean Status=commercialReceiptDAO.edit(conn,getTxtrentalreceiptdocno(),getFormdetailcode(),rentalReceiptsDate,getTxttranno(),getTxtdoctype(),getTxtsrno(),getCmbpaytype(),getTxtdocno(),
					getCmbcardtype(),getTxtrefno(),referenceDate,getTxtdescription(),getHidchckib(),getCmbbranch(),getTxtcldocno(),getTxtacno(),"0","0",
					"1",getTxtamount(),getTxtdiscount(),getTxtaddcharges(),getTxtamounts(),getTxtnetvalue(),getTxtdescriptions(),getTxtreceivedfrom(),getTxtapplyinvoiceapply() ,
					applyinvoicearray,applyinvoiceupdatearray,session);
			if(Status){
					
					setTxtrentalreceiptdocno(getTxtrentalreceiptdocno());
					setTxttranno(getTxttranno());
					setTxtsrno(getTxtsrno());
					setTxtdoctype(getTxtdoctype());
					setData();
					conn.commit();
					conn.close();
					setMsg("Updated Successfully");
					return "success";
			}
			else{
				setTxtrentalreceiptdocno(getTxtrentalreceiptdocno());
				setTxttranno(getTxttranno());
				setTxtsrno(getTxtsrno());
				setTxtdoctype(getTxtdoctype());
				setData();
				setChkstatus("2");
				conn.close();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		 else if(mode.equalsIgnoreCase("D")){
			 conn=ClsConnection.getMyConnection();
			 conn.setAutoCommit(false);
		    /*Apply-Invoice Grid Updating*/
			ArrayList applyinvoiceupdatearray= new ArrayList();
			for(int i=0;i<getApplylengthupdate();i++){
				String applyupdatetemp=requestParams.get("txtapplyupdate"+i)[0];
				applyinvoiceupdatearray.add(applyupdatetemp);
			}
			/*Apply-Invoice Grid Updating Ends*/
		
		boolean Status=commercialReceiptDAO.delete(conn,getTxtrentalreceiptdocno(),getFormdetailcode(),getTxtsrno(),getTxttranno(),getTxtdoctype(),getTxtacno(),"1","0","0",session);
		if(Status){
				setTxtrentalreceiptdocno(getTxtrentalreceiptdocno());
				setTxttranno(getTxttranno());
				setTxtsrno(getTxtsrno());
				setTxtdoctype(getTxtdoctype());
				setData();
				conn.commit();
				conn.close();
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
		}
		else{
			setTxtrentalreceiptdocno(getTxtrentalreceiptdocno());
			setTxttranno(getTxttranno());
			setTxtsrno(getTxtsrno());
			setTxtdoctype(getTxtdoctype());
			setData();
			conn.close();
			setMsg("Not Deleted");
			return "fail";
		}
	}
		

		  else if(mode.equalsIgnoreCase("View")){
			    commercialReceiptBean=commercialReceiptDAO.getViewDetails(session,getTxtsrno());
			
			    setJqxRentalReceiptDate(commercialReceiptBean.getJqxRentalReceiptDate());
				setTxtdoctype(commercialReceiptBean.getTxtdoctype());
				setTxtrentalreceiptdocno(getTxtrentalreceiptdocno());
				setTxtsrno(commercialReceiptBean.getTxtsrno());
				
				setHidcmbpaytype(commercialReceiptBean.getHidcmbpaytype());
				setTxtaccid(commercialReceiptBean.getTxtaccid());
				setTxtaccname(commercialReceiptBean.getTxtaccname());
				setHidcmbcardtype(commercialReceiptBean.getHidcmbcardtype());
				setTxtdocno(commercialReceiptBean.getTxtdocno());
				setTxttranno(commercialReceiptBean.getTxttranno());
				setTxtrefno(commercialReceiptBean.getTxtrefno());
				setJqxReferenceDate(commercialReceiptBean.getJqxReferenceDate());
				setTxtdescription(commercialReceiptBean.getTxtdescription());
				
				setHidchckib(commercialReceiptBean.getHidchckib());
				setHidcmbbranch(commercialReceiptBean.getHidcmbbranch());
				setTxtcldocno(commercialReceiptBean.getTxtcldocno());
				setTxtacno(commercialReceiptBean.getTxtacno());
				setTxtclientid(commercialReceiptBean.getTxtclientid());
				setTxtclientname(commercialReceiptBean.getTxtclientname());
				
				setTxtamount(commercialReceiptBean.getTxtamount());
				setTxtdiscount(commercialReceiptBean.getTxtdiscount());
				setTxtaddcharges(commercialReceiptBean.getTxtaddcharges());
				setTxtamounts(commercialReceiptBean.getTxtamounts());
				setTxtnetvalue(commercialReceiptBean.getTxtnetvalue());
				setTxtdescriptions(commercialReceiptBean.getTxtdescriptions());
				setTxtreceivedfrom(commercialReceiptBean.getTxtreceivedfrom());
				
				setTxtapplyinvoiceamt(commercialReceiptBean.getTxtapplyinvoiceamt());
				setTxtapplyinvoiceapply(commercialReceiptBean.getTxtapplyinvoiceapply());
				setTxtapplyinvoicebalance((commercialReceiptBean.getTxtapplyinvoicebalance()));
				
				setFormdetailcode(commercialReceiptBean.getFormdetailcode());
				
				return "success";
		    }
	   }catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return "fail";
   }
	
	public String printAction() throws ParseException, SQLException{
		ClsCommon ClsCommon=new ClsCommon();

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int srno=Integer.parseInt(request.getParameter("srno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		commercialReceiptBean=commercialReceiptDAO.getPrint(request,srno,branch);
		setLblprintpath(commercialReceiptBean.getLblprintpath()); 
		System.out.println("print path--->>>"+commercialReceiptBean.getLblprintpath());
		setLblprintname("Commercial Receipt");
		setUrl(ClsCommon.getPrintPath("CMR"));
		setLblcompname(commercialReceiptBean.getLblcompname());
		setLblcompaddress(commercialReceiptBean.getLblcompaddress());
		setLblcomptel(commercialReceiptBean.getLblcomptel());
		setLblcompfax(commercialReceiptBean.getLblcompfax());
		setLbllocation(commercialReceiptBean.getLbllocation());
		setLblbranch(commercialReceiptBean.getLblbranch());
		setLblcstno(commercialReceiptBean.getLblcstno());
		setLblpan(commercialReceiptBean.getLblpan());
		setLblservicetax(commercialReceiptBean.getLblservicetax());
		setLblcomptel2(commercialReceiptBean.getLblcomptel2());
		setLblcompwebsite(commercialReceiptBean.getLblcompwebsite());
		setLblcompemail(commercialReceiptBean.getLblcompemail());
		
		setReceivedfrom(commercialReceiptBean.getReceivedfrom());
		setClientinfo(commercialReceiptBean.getClientinfo());
		setReceiptno(commercialReceiptBean.getReceiptno());
		setReceiptdate(commercialReceiptBean.getReceiptdate());
		setRentalno(commercialReceiptBean.getRentalno());
		setRentaltype(commercialReceiptBean.getRentaltype());
		setRefno(commercialReceiptBean.getRefno());
		setContractstart(commercialReceiptBean.getContractstart());
		setLbladvancesecurity(commercialReceiptBean.getLbladvancesecurity());
		setLbldescription(commercialReceiptBean.getLbldescription());
		setCardno(commercialReceiptBean.getCardno());
		setCardexp(commercialReceiptBean.getCardexp());
		setChqno(commercialReceiptBean.getChqno());
		setChqdate(commercialReceiptBean.getChqdate());
		setPaymode(commercialReceiptBean.getPaymode());
		setAmount(commercialReceiptBean.getAmount());
		setAmtinwords(commercialReceiptBean.getAmtinwords());
		setTotal(commercialReceiptBean.getTotal());
		setPreparedby(commercialReceiptBean.getPreparedby());
		
		// for hide
		setFirstarray(commercialReceiptBean.getFirstarray());
		
		setReceiptdocno(commercialReceiptBean.getReceiptdocno());
		
		
	
	return "print";
	}

	public  JSONArray searchDetails(HttpSession session,String accountName,String docNo,String date,String total,String refNo,String contact){
		  JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
		  try {
			cellarray= commercialReceiptDAO.cmrMainSearch(session,accountName,docNo,date,total,refNo);
	
		  } catch (SQLException e) {
			  e.printStackTrace();
			  }
		return cellarray;
	}
	
	public void setData(){
		setHidjqxRentalReceiptDate(rentalReceiptsDate.toString());
		setHidcmbpaytype(getCmbpaytype());
		setTxtdocno(getTxtdocno());
		setTxtaccid(getTxtaccid());
		setTxtaccname(getTxtaccname());
		setHidcmbcardtype(getCmbcardtype());
		setTxtrefno(getTxtrefno());
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
		setTxtamount(getTxtamount());
		setTxtdiscount(getTxtdiscount());
		setTxtaddcharges(getTxtaddcharges());
		setTxtamounts(getTxtamounts());
		setTxtnetvalue(getTxtnetvalue());
		setTxtdescriptions(getTxtdescriptions());
		setTxtapplyinvoiceamt(getTxtapplyinvoiceamt());
		setTxtapplyinvoiceapply(getTxtapplyinvoiceapply());
		setTxtapplyinvoicebalance(getTxtapplyinvoicebalance());
		setFormdetailcode(getFormdetailcode());
	}

	public String emailAction() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon ClsCommon=new ClsCommon();

		try{
			
			
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		String formcode=request.getParameter("formcode")==null?"NA":request.getParameter("formcode").trim();
		String recep=request.getParameter("recep")==null?"NA":request.getParameter("recep").trim();
		String filename="";
		int isindian=0;
		
		commercialReceiptBean=commercialReceiptDAO.getPdf(request,docno,branch);
		
		
		 filename=commercialReceiptDAO.getFileName(formcode);

		 isindian=commercialReceiptDAO.getCompChk();
	
		setLblprintname("Receipt Voucher");
		setUrl(ClsCommon.getPrintPath("CMR"));
		setLblcompname(commercialReceiptBean.getLblcompname());
		setLblcompaddress(commercialReceiptBean.getLblcompaddress());
		setLblcomptel(commercialReceiptBean.getLblcomptel());
		setLblcompfax(commercialReceiptBean.getLblcompfax());
		setLbllocation(commercialReceiptBean.getLbllocation());
		setLblbranch(commercialReceiptBean.getLblbranch());
		setLblcstno(commercialReceiptBean.getLblcstno());
		setLblpan(commercialReceiptBean.getLblpan());
		setLblservicetax(commercialReceiptBean.getLblservicetax());
		
		setReceivedfrom(commercialReceiptBean.getReceivedfrom());
		setClientinfo(commercialReceiptBean.getClientinfo());
		setReceiptno(commercialReceiptBean.getReceiptno());
		setReceiptdate(commercialReceiptBean.getReceiptdate());
		setRentalno(commercialReceiptBean.getRentalno());
		setRentaltype(commercialReceiptBean.getRentaltype());
		setRefno(commercialReceiptBean.getRefno());
		setContractstart(commercialReceiptBean.getContractstart());
		setLbladvancesecurity(commercialReceiptBean.getLbladvancesecurity());
		setLbldescription(commercialReceiptBean.getLbldescription());
		setCardno(commercialReceiptBean.getCardno());
		setCardexp(commercialReceiptBean.getCardexp());
		setChqno(commercialReceiptBean.getChqno());
		setChqdate(commercialReceiptBean.getChqdate());
		setPaymode(commercialReceiptBean.getPaymode());
		setAmount(commercialReceiptBean.getAmount());
		setAmtinwords(commercialReceiptBean.getAmtinwords());
		setTotal(commercialReceiptBean.getTotal());
		setPreparedby(commercialReceiptBean.getPreparedby());
		
		
		ArrayList printapplyingsarray=new ArrayList();
		printapplyingsarray=(ArrayList) request.getAttribute("printapplyingsarray");
		
		setFirstarray(commercialReceiptBean.getFirstarray());
		
		
		 String [] path=filename.split("attachment");
		   String path1=path[0];
		
		ClspdfCreate pdfcreate= new ClspdfCreate();
		
		/*if(isindian==1){*/
			
			pdfcreate.pdfCreateLocal(formcode,filename,getLblcompname(),getLblcompaddress(),getLblcomptel(),getLblcompfax(),
			getLbllocation(),getLblbranch(),getLblcstno(),getLblpan(),getLblservicetax(),getReceivedfrom(),
			getReceiptno(),getReceiptdate(),getRentalno(),getRentaltype(),getRefno(),getContractstart(),
			getLbladvancesecurity(),getLbldescription(),getCardno(),getCardexp(),getChqno(),getChqdate(),
			getPaymode(),getAmount(),getAmtinwords(),getTotal(),getPreparedby(),printapplyingsarray,session,path1,recep,isindian);
		/*}*/
		
		/*else{
			
			pdfcreate.pdfCreate(formcode,filename,getLblcompname(),getLblcompaddress(),getLblcomptel(),getLblcompfax(),
			getLbllocation(),getLblbranch(),getLblcstno(),getLblpan(),getLblservicetax(),getReceivedfrom(),
			getReceiptno(),getReceiptdate(),getRentalno(),getRentaltype(),getRefno(),getContractstart(),
			getLbladvancesecurity(),getLbldescription(),getCardno(),getCardexp(),getChqno(),getChqdate(),
			getPaymode(),getAmount(),getAmtinwords(),getTotal(),getPreparedby(),printapplyingsarray);
					
		}*/
		
		}
		catch(Exception e){
			e.printStackTrace();
			return "fail";
		}
		
	
	return "success";
	}
	


}
