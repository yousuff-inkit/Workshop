package com.dashboard.workshop.jobcardcompletenew;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.workshop.wsinvoice.ClsWSInvoiceBean;
import com.workshop.wsinvoice.ClsWSInvoiceDAO;

public class ClsJobCardCompleteNewAction {
	ClsCommon objcommon=new ClsCommon();
	ClsJobCardCompleteNewDAO jobdao=new ClsJobCardCompleteNewDAO();
	private String mode;
	private String msg;
	private String detail;
	private String detailname,txtremarks;
	private String strlabourarray;
	private String strpartsarray;
	private String strextraarray;
	private String estdocno,docno;
	private String brhid;
	private String lblcompname,lblcompaddress,lblprintname,lblbranch,lbllocation,lblcomptel,lblcompfax;
	private String lbldate,lblinvno,lblrefno,lblclient,lbladdress,lblmobile,lblemail,lblvehicle,lblchassis;
	private String lblcheckedby,lblrecievedby,lblfinaldate;
	private String lbltotal,lbltax,lblnetamount,lblamountwords,lblroundoff;
	private String lblcomptrn,lblclienttrn;
	private String claimno,lpono,lpoamount;
	
	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}
	public String getLblroundoff() {
		return lblroundoff;
	}

	public void setLblroundoff(String lblroundoff) {
		this.lblroundoff = lblroundoff;
	}

	public String getClaimno() {
		return claimno;
	}

	public void setClaimno(String claimno) {
		this.claimno = claimno;
	}

	public String getLpono() {
		return lpono;
	}

	public void setLpono(String lpono) {
		this.lpono = lpono;
	}

	public String getLpoamount() {
		return lpoamount;
	}

	public void setLpoamount(String lpoamount) {
		this.lpoamount = lpoamount;
	}

	public String getStrextraarray() {
		return strextraarray;
	}

	public void setStrextraarray(String strextraarray) {
		this.strextraarray = strextraarray;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public String getLblclienttrn() {
		return lblclienttrn;
	}

	public void setLblclienttrn(String lblclienttrn) {
		this.lblclienttrn = lblclienttrn;
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

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblinvno() {
		return lblinvno;
	}

	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
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

	public String getLblemail() {
		return lblemail;
	}

	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}

	public String getLblvehicle() {
		return lblvehicle;
	}

	public void setLblvehicle(String lblvehicle) {
		this.lblvehicle = lblvehicle;
	}

	public String getLblchassis() {
		return lblchassis;
	}

	public void setLblchassis(String lblchassis) {
		this.lblchassis = lblchassis;
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

	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}

	public String getLbltax() {
		return lbltax;
	}

	public void setLbltax(String lbltax) {
		this.lbltax = lbltax;
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

	public String getBrhid() {
		return brhid;
	}

	public void setBrhid(String brhid) {
		this.brhid = brhid;
	}

	public String getEstdocno() {
		return estdocno;
	}

	public void setEstdocno(String estdocno) {
		this.estdocno = estdocno;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
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

	

	public String getStrlabourarray() {
		return strlabourarray;
	}

	public void setStrlabourarray(String strlabourarray) {
		this.strlabourarray = strlabourarray;
	}

	public String getStrpartsarray() {
		return strpartsarray;
	}

	public void setStrpartsarray(String strpartsarray) {
		this.strpartsarray = strpartsarray;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		ArrayList<String> labourarray=new ArrayList<>();
		ArrayList<String> partsarray=new ArrayList<>();
		ArrayList<String> extraarray=new ArrayList<>();
		if(!getStrpartsarray().equalsIgnoreCase("")){
			String temppartsarray[]=getStrpartsarray().split(",");
			for(int i=0;i<temppartsarray.length;i++){
				partsarray.add(temppartsarray[i]);
			}
		}
		if(!getStrlabourarray().equalsIgnoreCase("")){
			String templabourarray[]=getStrlabourarray().split(",");
			for(int i=0;i<templabourarray.length;i++){
				labourarray.add(templabourarray[i]);
			}
		}
		if(!getStrextraarray().equalsIgnoreCase("")){
			String tempextraarray[]=getStrextraarray().split(",");
			for(int i=0;i<tempextraarray.length;i++){
				extraarray.add(tempextraarray[i]);
			}
		}
		String mode=getMode();
		if(mode.equalsIgnoreCase("A")){
			int val=jobdao.insert(getEstdocno(),getDocno(),getBrhid(),labourarray,partsarray,
					extraarray,session,request,mode,getLpono(),getClaimno(),getLpoamount(),getTxtremarks());
			if(val>0){
				setDetail("Workshop");
				setDetailname("Job Card Complete");
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Workshop");
				setDetailname("Job Card Complete");
				setMsg("Not Saved");
				return "fail";
			}

		}
		return "fail";
	}
	
	
	public String printAction() throws ParseException, SQLException,Exception{
		
		 try{
			 System.out.println("Inside Print Action");
			 ClsJobCardCompleteNewBean bean=new ClsJobCardCompleteNewBean();
			 HttpServletRequest request=ServletActionContext.getRequest();
			 HttpSession session=request.getSession();
			 String doc=request.getParameter("docno");
			 bean=jobdao.printDetails(doc,request);
			 setLblrefno(bean.getLblrefno());
			 setLbldate(bean.getLbldate());
			 setLblinvno(bean.getLblinvno());
			 setLblclient(bean.getLblclient());
			 setLbladdress(bean.getLbladdress());
			 setLblemail(bean.getLblemail());
			 setLblmobile(bean.getLblmobile());
			 setLblvehicle(bean.getLblvehicle());
			 setLblbranch(bean.getLblbranch());
			 setLblprintname("Proforma Invoice");
			 setLblcompaddress(bean.getLblcompaddress());
			 setLblcompname(bean.getLblcompname());
			 setLblcomptel(bean.getLblcomptel());
			 setLblcompfax(bean.getLblcompfax());
			 setLbltotal(bean.getLbltotal());
			 setLbltax(bean.getLbltax());
			 setLblnetamount(bean.getLblnetamount());
			 setLblroundoff(bean.getLblroundoff());
			 setLblamountwords(bean.getLblamountwords());
			 setLblcheckedby(bean.getLblcheckedby());
			 setLblfinaldate(bean.getLblfinaldate());
			 setLblclienttrn(bean.getLblclienttrn());
			 setLblcomptrn(bean.getLblcomptrn());
			 setLblchassis(bean.getLblchassis());
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 return "print";
	}
}
