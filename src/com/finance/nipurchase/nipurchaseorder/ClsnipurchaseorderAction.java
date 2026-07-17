package com.finance.nipurchase.nipurchaseorder;



import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceBean;
import com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO;

@SuppressWarnings("serial")
	public class ClsnipurchaseorderAction extends ActionSupport{
		ClsnipurchaseorderDAO purorderDAO= new ClsnipurchaseorderDAO(); 
		ClsnipurchaseorderBean pintbean= new ClsnipurchaseorderBean(); 
		ClsnipurchaseorderBean viewobj= new ClsnipurchaseorderBean();
		
		
		ClsCommon commDAO=new ClsCommon();
		private String nipurchaseorderdate,lblprintpath;    
		public String getLblprintpath() {
			return lblprintpath;
		}
		public void setLblprintpath(String lblprintpath) {
			this.lblprintpath = lblprintpath;
		}


		private String hidnipurchaseorderdate;
		private int  docno,descgridlenght;
		private String refno,acctype,puraccid,puraccname,cmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
		private String deleted,ventrno,lblbranchtrno;
		private Double nettotal;
		private int masterdoc_no;
		private String venland,venphon,watermarks,lblrefno,lblpreparedby,lblpreparedon,lblpreparedat,lblverifiedby,lblapprovedby,lblverifiedon,lblapprovedon,lblapprovedat,lblverifiedat;
		
		private int taxaccount,hideproducttype;
		
		private double taxpers ;
		
		private String txtproducttype;
		private String cityqry,lbltotal,lbldiscount,lblnettax;
		
		
		public String getLbltotal() {
			return lbltotal;
		}
		public void setLbltotal(String lbltotal) {
			this.lbltotal = lbltotal;
		}
		public String getLbldiscount() {
			return lbldiscount;
		}
		public void setLbldiscount(String lbldiscount) {
			this.lbldiscount = lbldiscount;
		}
		public String getLblnettax() {
			return lblnettax;
		}
		public void setLblnettax(String lblnettax) {
			this.lblnettax = lblnettax;
		}
		public String getCityqry() {
			return cityqry;
		}
		public void setCityqry(String cityqry) {
			this.cityqry = cityqry;
		}
		
		
		public String getLblbranchtrno() {
			return lblbranchtrno;
		}
		public void setLblbranchtrno(String lblbranchtrno) {
			this.lblbranchtrno = lblbranchtrno;
		}
		public String getVentrno() {
			return ventrno;
		}
		public void setVentrno(String ventrno) {
			this.ventrno = ventrno;
		}
		public int getTaxaccount() {
			return taxaccount;
		}
		public void setTaxaccount(int taxaccount) {
			this.taxaccount = taxaccount;
		}
		public int getHideproducttype() {
			return hideproducttype;
		}
		public void setHideproducttype(int hideproducttype) {
			this.hideproducttype = hideproducttype;
		}
		public double getTaxpers() {
			return taxpers;
		}
		public void setTaxpers(double taxpers) {
			this.taxpers = taxpers;
		}
		public String getTxtproducttype() {
			return txtproducttype;
		}
		public void setTxtproducttype(String txtproducttype) {
			this.txtproducttype = txtproducttype;
		}
		public String getWatermarks() {
			return watermarks;
		}
		public void setWatermarks(String watermarks) {
			this.watermarks = watermarks;
		}
		public String getLblverifiedon() {
			return lblverifiedon;
		}
		public void setLblverifiedon(String lblverifiedon) {
			this.lblverifiedon = lblverifiedon;
		}
		public String getLblapprovedon() {
			return lblapprovedon;
		}
		public void setLblapprovedon(String lblapprovedon) {
			this.lblapprovedon = lblapprovedon;
		}
		public String getLblapprovedat() {
			return lblapprovedat;
		}
		public void setLblapprovedat(String lblapprovedat) {
			this.lblapprovedat = lblapprovedat;
		}
		public String getLblverifiedat() {
			return lblverifiedat;
		}
		public void setLblverifiedat(String lblverifiedat) {
			this.lblverifiedat = lblverifiedat;
		}
		public String getLblverifiedby() {
			return lblverifiedby;
		}
		public void setLblverifiedby(String lblverifiedby) {
			this.lblverifiedby = lblverifiedby;
		}
		public String getLblapprovedby() {
			return lblapprovedby;
		}
		public void setLblapprovedby(String lblapprovedby) {
			this.lblapprovedby = lblapprovedby;
		}
		public String getLblpreparedby() {
			return lblpreparedby;
		}
		public void setLblpreparedby(String lblpreparedby) {
			this.lblpreparedby = lblpreparedby;
		}
		public String getLblpreparedon() {
			return lblpreparedon;
		}
		public void setLblpreparedon(String lblpreparedon) {
			this.lblpreparedon = lblpreparedon;
		}
		public String getLblpreparedat() {
			return lblpreparedat;
		}
		public void setLblpreparedat(String lblpreparedat) {
			this.lblpreparedat = lblpreparedat;
		}
		public String getLblrefno() {
			return lblrefno;
		}
		public void setLblrefno(String lblrefno) {
			this.lblrefno = lblrefno;
		}


		// for print 
		private String lbldate,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc,venaddress,contactperson,amountinwords;
		
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
		
		private String lblnettotal;
		private String url;
		
		
		
		
		
		public String getVenland() {
			return venland;
		}
		public void setVenland(String venland) {
			this.venland = venland;
		}
		public String getVenphon() {
			return venphon;
		}
		public void setVenphon(String venphon) {
			this.venphon = venphon;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}


		
		public String getVenaddress() {
			return venaddress;
		}
		public void setVenaddress(String venaddress) {    
			this.venaddress = venaddress;
		}
		public String getContactperson() {
			return contactperson;
		}
		public void setContactperson(String contactperson) {
			this.contactperson = contactperson;
		}
		public String getAmountinwords() {
			return amountinwords;
		}
		public void setAmountinwords(String amountinwords) {
			this.amountinwords = amountinwords;
		}
		public String getLbldate() {
			return lbldate;
		}
		public void setLbldate(String lbldate) {
			this.lbldate = lbldate;
		}
	
		public String getDocvals() {
			return docvals;
		}
		public void setDocvals(String docvals) {
			this.docvals = docvals;
		}
		public String getLblacno() {
			return lblacno;
		}
		public void setLblacno(String lblacno) {
			this.lblacno = lblacno;
		}
		public String getLblacnoname() {
			return lblacnoname;
		}
		public void setLblacnoname(String lblacnoname) {
			this.lblacnoname = lblacnoname;
		}
		public String getLbldeldate() {
			return lbldeldate;
		}
		public void setLbldeldate(String lbldeldate) {
			this.lbldeldate = lbldeldate;
		}
		public String getLbldddtm() {
			return lbldddtm;
		}
		public void setLbldddtm(String lbldddtm) {
			this.lbldddtm = lbldddtm;
		}
		public String getLblpatms() {
			return lblpatms;
		}
		public void setLblpatms(String lblpatms) {
			this.lblpatms = lblpatms;
		}
		public String getLbldsc() {
			return lbldsc;
		}
		public void setLbldsc(String lbldsc) {
			this.lbldsc = lbldsc;
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
		public String getLblprintname() {
			return lblprintname;
		}
		public void setLblprintname(String lblprintname) {
			this.lblprintname = lblprintname;
		}
		public String getLblnettotal() {
			return lblnettotal;
		}
		public void setLblnettotal(String lblnettotal) {
			this.lblnettotal = lblnettotal;
		}
		public String getNipurchaseorderdate() {
			return nipurchaseorderdate;
		}
		public void setNipurchaseorderdate(String nipurchaseorderdate) {
			this.nipurchaseorderdate = nipurchaseorderdate;
		}

		public String getHidnipurchaseorderdate() {
			return hidnipurchaseorderdate;
		}

		public void setHidnipurchaseorderdate(String hidnipurchaseorderdate) {
			this.hidnipurchaseorderdate = hidnipurchaseorderdate;
		}
		public int getDocno() {
			return docno;
		}
		public void setDocno(int docno) {
			this.docno = docno;
		}
		public String getRefno() {    
			return refno;
		}

		public String getAccdocno() {
			return accdocno;
		}
		public void setAccdocno(String accdocno) {
			this.accdocno = accdocno;
		}
		public void setRefno(String refno) {
			this.refno = refno;
		}
		public String getAcctype() {
			return acctype;
		}

		public void setAcctype(String acctype) {
			this.acctype = acctype;
		}
		public String getPuraccid() {
			return puraccid;
		}

		public void setPuraccid(String puraccid) {
			this.puraccid = puraccid;
		}

		public String getPuraccname() {
			return puraccname;
		}

		public void setPuraccname(String puraccname) {
			this.puraccname = puraccname;
		}
		public String getCmbcurr() {                            
			return cmbcurr;
		}
		public void setCmbcurr(String cmbcurr) {
			this.cmbcurr = cmbcurr;
		}
		public String getCurrate() {
			return currate;
		}
		public void setCurrate(String currate) {
			this.currate = currate;
		}
		public String getDeliverydate() {
			return deliverydate;
		}

		public void setDeliverydate(String deliverydate) {
			this.deliverydate = deliverydate;
		}
		public String getHiddeliverydate() {
			return hiddeliverydate;
		}

		public void setHiddeliverydate(String hiddeliverydate) {
			this.hiddeliverydate = hiddeliverydate;
		}
		public String getDelterms() {
			return delterms;
		}
		public void setDelterms(String delterms) { 
			this.delterms = delterms;
		}
		public String getPayterms() {
			return payterms;
		}
		public void setPayterms(String payterms) {
			this.payterms = payterms;
		}
		public String getPurdesc() {
			return purdesc;
		}
		public void setPurdesc(String purdesc) {
			this.purdesc = purdesc;
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
	
		public Double getNettotal() {
			return nettotal;
		}
		public void setNettotal(Double nettotal) {
			this.nettotal = nettotal;
		}
		public int getDescgridlenght() {
			return descgridlenght;
		}
		public void setDescgridlenght(int descgridlenght) {
			this.descgridlenght = descgridlenght;
		}
		
		/// relode
	
		public String getCmbcurrval() {
			return cmbcurrval;
		}
		public void setCmbcurrval(String cmbcurrval) {
			this.cmbcurrval = cmbcurrval;
		}
		public String getAcctypeval() {
			return acctypeval;
		}
		public void setAcctypeval(String acctypeval) {
			this.acctypeval = acctypeval;
		}
		
		
		
		public String getDeleted() {
			return deleted;
		}
		public void setDeleted(String deleted) {
			this.deleted = deleted;
		}
		// form name
		public String getFormdetailcode() {
			return formdetailcode;
		}
		public void setFormdetailcode(String formdetailcode) {
			this.formdetailcode = formdetailcode;
		}
	
		
		
		public int getMasterdoc_no() {
			return masterdoc_no;
		}
		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}


	private Map<String, Object> param=null;
		
		
		public Map<String, Object> getParam() {
			return param;
		}
		public void setParam(Map<String, Object> param) {
			this.param = param;
		}
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			java.sql.Date sqlStartDate1 = commDAO.changeStringtoSqlDate(getNipurchaseorderdate());
			java.sql.Date sqlpurdeldate = commDAO.changeStringtoSqlDate(getDeliverydate());
			String mode=getMode();

//System.out.println("========="+getFormdetailcode());
			//System.out.println("========="+getCmbcurr());

	if(mode.equalsIgnoreCase("A")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getDescgridlenght();i++){
			
			////System.out.println("dddddddddd"+requestParams.get("desctest"+i)[0]);
			
			String temp2=requestParams.get("desctest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
		
			descarray.add(temp2);
			//System.out.println("temp2 "+temp2);
		}
		int val=purorderDAO.insert(sqlStartDate1,sqlpurdeldate,getRefno(),getAcctype(),getAccdocno(),getPuraccname(), getCmbcurr(),
				getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),request,getHideproducttype());
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0){
			//System.out.println("---------------"+val);
			
			
			setHidnipurchaseorderdate(sqlStartDate1.toString());
			setHiddeliverydate(sqlpurdeldate.toString());
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			
		setCurrate(getCurrate());
		setDelterms(getDelterms());
		setPayterms(getPayterms());
		setPurdesc(getPurdesc());
		setNettotal(getNettotal());
			setDocno(vdocno);
			setMasterdoc_no(val);
			//request.setAttribute("vocno", vocno);
		
			setMsg("Successfully Saved");
			return "success";
		}
		else{
			setHidnipurchaseorderdate(sqlStartDate1.toString());
			setHiddeliverydate(sqlpurdeldate.toString());
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			setTaxaccount(getTaxaccount());
			setHideproducttype(getHideproducttype());
			setTaxpers(getTaxpers());
			setTxtproducttype(getTxtproducttype());
			
		setCurrate(getCurrate());
		setDelterms(getDelterms());
		setPayterms(getPayterms());
		setPurdesc(getPurdesc());
		setNettotal(getNettotal());
		setDocno(vdocno);
		setMasterdoc_no(val);
			setMsg("Not Saved");
			return "fail";
		}
	}

   
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getDescgridlenght();i++){
				String temp2=requestParams.get("desctest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
			
				descarray.add(temp2);
			 
			}
			boolean Status=purorderDAO.edit(getMasterdoc_no(),sqlStartDate1,sqlpurdeldate,getRefno(),getAcctype(),getAccdocno(),getPuraccname(),
					getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),getHideproducttype());
			if(Status){
				
				setHidnipurchaseorderdate(sqlStartDate1.toString());
				setHiddeliverydate(sqlpurdeldate.toString());
				setRefno(getRefno());
				setAcctypeval(getAcctype());
				setPuraccid(getPuraccid());
				setPuraccname(getPuraccname());
				setCmbcurrval(getCmbcurr());
				setTaxaccount(getTaxaccount());
				setHideproducttype(getHideproducttype());
				setTaxpers(getTaxpers());
				setTxtproducttype(getTxtproducttype());
				
				setAccdocno(getAccdocno());
		    	setCurrate(getCurrate());
			    setDelterms(getDelterms());
		     	setPayterms(getPayterms());
			    setPurdesc(getPurdesc());
			    setNettotal(getNettotal());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMsg("Updated Successfully");
				return "success";
			
			}
			else{
				setHidnipurchaseorderdate(sqlStartDate1.toString());
				setHiddeliverydate(sqlpurdeldate.toString());
				setRefno(getRefno());
				setAcctypeval(getAcctype());
				setPuraccid(getPuraccid());
				setPuraccname(getPuraccname());
				setTaxaccount(getTaxaccount());
				setHideproducttype(getHideproducttype());
				setTaxpers(getTaxpers());
				setTxtproducttype(getTxtproducttype());
				
				setCmbcurrval(getCmbcurr());
				setAccdocno(getAccdocno());
		    	setCurrate(getCurrate());
			    setDelterms(getDelterms());
		     	setPayterms(getPayterms());
			    setPurdesc(getPurdesc());
			    setNettotal(getNettotal());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMsg("Not Updated");
				return "fail";
			}
		}
	else if(mode.equalsIgnoreCase("D")){
			boolean Status=purorderDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
		if(Status){
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setRefno(getRefno());
			setAcctypeval(getAcctype());
			setPuraccid(getPuraccid());
			setPuraccname(getPuraccname());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
	    	setCurrate(getCurrate());
		    setDelterms(getDelterms());
	     	setPayterms(getPayterms());
		    setPurdesc(getPurdesc());
		    setNettotal(getNettotal());
			setDocno(getDocno());
			setMsg("Not Deleted");
			return "fail";
		}
	
	}

	else if(mode.equalsIgnoreCase("view")){
		
		
		
	//	System.out.println("======================="+getMasterdoc_no());
		
 
			
			
		viewobj=purorderDAO.getViewDetails(getDocno(),session);
		
		
		 
		setHidnipurchaseorderdate(viewobj.getHidnipurchaseorderdate());
		
		 
		setHiddeliverydate(viewobj.getHiddeliverydate());
		 
		setRefno(viewobj.getRefno());
		 
		setAcctypeval(viewobj.getAcctypeval());
		 
		setPuraccname(viewobj.getPuraccname());
		setCmbcurrval(viewobj.getCmbcurrval());
		setAccdocno(viewobj.getAccdocno());
		setCurrate(viewobj.getCurrate());
		  setHideproducttype(viewobj.getHideproducttype());
		  setTxtproducttype(viewobj.getTxtproducttype());
		  setTaxpers(viewobj.getTaxpers());
		setPuraccid(viewobj.getPuraccid());
		 setDelterms(viewobj.getDelterms());
		 setPayterms(viewobj.getPayterms());
		 setPurdesc(viewobj.getPurdesc());
	 setNettotal(viewobj.getNettotal());
		//setDocno(val);
		 setDocno(viewobj.getDocno());
		 setMasterdoc_no(viewobj.getMasterdoc_no());
		
		
		 
		
		
}

	
return "fail";	
	
}
		
		
		
		
		
		 public String printAction() throws ParseException, SQLException{
				
			  HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 String brhid=request.getParameter("brhid").toString();
			 String dtype=request.getParameter("dtype").toString();
			 setUrl(commDAO.getPrintPath(dtype));
			 System.out.println("inside action"+doc);
			 pintbean=purorderDAO.getPrint(doc,request,session,brhid);
			 
			 
			
			  //cl details
			 
			 //System.out.println("ndjesfjkfjkk");
			 setLblprintpath(pintbean.getLblprintpath());
			 System.out.println("print path--->>>"+pintbean.getLblprintpath());      
			 setWatermarks(pintbean.getWatermarks());
			      setLblverifiedat(pintbean.getLblverifiedat());
			      setLblverifiedon(pintbean.getLblverifiedon());
			      setLblapprovedat(pintbean.getLblapprovedat());
			      setLblapprovedon(pintbean.getLblapprovedon());
			      setLblapprovedby(pintbean.getLblapprovedby());
			      setLblverifiedby(pintbean.getLblverifiedby());
			          setLblprintname("NI Purchase Order");
			          if(pintbean.getLblcompname().contains("PAL AUTO GARAGE")){
			        	  setLblprintname("Purchase Order");  
			          }
			         setLbldate(pintbean.getLbldate());
			    	setVenland(pintbean.getVenland());
			    	setVenphon(pintbean.getVenphon());
			    	setLblrefno(pintbean.getLblrefno());
			    	setLblpreparedby(pintbean.getLblpreparedby());
			    	   setDocvals(pintbean.getDocvals());
			    	   setLblacno(pintbean.getLblacno());
			    	    setVenaddress(pintbean.getVenaddress());
			    	   setLblacnoname(pintbean.getLblacnoname());
			    	   setLbldeldate(pintbean.getLbldeldate());
			    	    setLbldddtm(pintbean.getLbldddtm());
			    	    setLblpreparedon(pintbean.getLblpreparedon());
			    	    setLblpreparedat(pintbean.getLblpreparedat());
			    	    setVentrno(pintbean.getVentrno());
			    	    setLblbranchtrno(pintbean.getLblbranchtrno());
			    	   setLbldsc(pintbean.getLbldsc());
			    	   setLblpatms(pintbean.getLblpatms());
			
			    	   setLblnettotal(pintbean.getLblnettotal());
			  
			
	 	  setLblbranch(pintbean.getLblbranch());
		   setLblcompname(pintbean.getLblcompname());
		  
		  setLblcompaddress(pintbean.getLblcompaddress());
		 
		   setLblcomptel(pintbean.getLblcomptel());
		  
		  setLblcompfax(pintbean.getLblcompfax());
		   setLbllocation(pintbean.getLbllocation());
		   
		   
		   setVenaddress(pintbean.getVenaddress());
		   setContactperson(pintbean.getContactperson());
		   setAmountinwords(pintbean.getAmountinwords());
                   setAmountinwords(pintbean.getWordnetamount());
		   
		   
		/*   getVenaddress setContactperson getAmountinwords*/
		   if(commDAO.getPrintPath(dtype).contains("jrxml")==true)
		   {
			   HttpServletResponse response = ServletActionContext.getResponse();
			    
			    
			    
			    
				 
				 param = new HashMap();
				 Connection conn = null;
				 
				 String reportFileName = "NIPurchaseOrder";
				 							
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
			     
				 try {            
		             param.put("termsquery",pintbean.getTermQry());
			          
			         param.put("descQry",pintbean.getDescQry());
			         
			       //  System.out.println("product++++++++++"+productQuery);
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imghedderpath", imgpath);
			          
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          
			          
			      
			          param.put("vendor", pintbean.getLblacnoname());
			          param.put("attn", pintbean.getAttn());
			          param.put("tel", pintbean.getTel());
			          param.put("fax", pintbean.getFax());
			          param.put("email", pintbean.getEmail());
			          param.put("docno",doc);
			          param.put("date", pintbean.getLbldate());
			          param.put("refno", pintbean.getRefno());
			          param.put("desc", pintbean.getLbldsc());
			          param.put("payterm", pintbean.getLblpatms());
			          param.put("delterm", pintbean.getLbldddtm());
			          param.put("netamount", pintbean.getLblnettotal());
			          param.put("amountwords", pintbean.getWordnetamount());
				  param.put("taxnetamount", pintbean.getLblnettotal());
			          param.put("taxamountwords", pintbean.getWordnetamount());
				    param.put("clienttrno", pintbean.getTinno());
				         param.put("compnytrno", pintbean.getCompanytrno());
				         param.put("discount", "0.00");
				    
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			       // String path[]=commDAO.getPrintPath(dtype).split("nipurchaseorder/");
				   
				   
				    //city Experts
				      /*String imgpath1=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
				      	imgpath1=imgpath1.replace("\\", "\\\\");
				        param.put("imghedderpath", imgpath1);*/

				     /* param.put("vendor",pintbean.getLblacnoname());*/
				      param.put("taxqry",pintbean.getCityqry());
				      
				      param.put("address",pintbean.getVenaddress());
				      param.put("phoneno",pintbean.getVenphon());
				      param.put("trnno",pintbean.getVentrno());
				      param.put("landno",pintbean.getVenland());
				      param.put("contactp",pintbean.getContactperson());
				      param.put("refno",pintbean.getLblrefno());
				      param.put("deldate",pintbean.getLbldeldate());
				      param.put("delterms",pintbean.getLbldddtm());
				      param.put("payterms",pintbean.getLblpatms());
				      param.put("description",pintbean.getLbldsc());
				      param.put("docno",pintbean.getDocvals());
				      param.put("date",pintbean.getLbldate());
				      param.put("nettotal",pintbean.getLblnettotal());
				      param.put("amtinwords",pintbean.getWordnetamount());
				      param.put("preparedby",pintbean.getLblpreparedby());
				      param.put("pdate",pintbean.getLblpreparedon());
				      param.put("ptime",pintbean.getLblpreparedat());
				      param.put("verifiedby",pintbean.getLblverifiedby());
				      param.put("vdate",pintbean.getLblverifiedon());
				      param.put("vtime",pintbean.getLblverifiedat());
				      param.put("approvedby",pintbean.getLblapprovedby());
				      param.put("adate",pintbean.getLblapprovedon());
				      param.put("atime",pintbean.getLblapprovedon());
				      param.put("total", pintbean.getLbltotal());
				      param.put("discount", pintbean.getLbldiscount());
				      param.put("nettax", pintbean.getLblnettax());
				      
				      param.put("compbranch",pintbean.getLblbranch());
				      param.put("compname",pintbean.getLblcompname());				  
				      param.put("compaddress",pintbean.getLblcompaddress());				 
				      param.put("comptel",pintbean.getLblcomptel());				  
				      param.put("compfax",pintbean.getLblcompfax());
				      param.put("complocation",pintbean.getLbllocation());
				   
				   
			        setUrl(commDAO.getPrintPath(dtype));
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/nipurchase/nipurchaseorder/" +commDAO.getPrintPath(dtype)));
	         	 
	              JasperReport jasperReport = JasperCompileManager.compileReport(design);
	             generateReportPDF(response, param, jasperReport, conn);
	       

	   } catch (Exception e) {

	       e.printStackTrace();

	   }
				 
				 finally{
					 conn.close();
				 }
			   
		   }
		  

	   	   
			 return "print";
			 }
			private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
				  byte[] bytes = null;
			    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
			      resp.reset();
			    resp.resetBuffer();
			    
			    resp.setContentType("application/pdf");
			    resp.setContentLength(bytes.length);
			    ServletOutputStream ouputStream = resp.getOutputStream();
			    ouputStream.write(bytes, 0, bytes.length);
			   
			    ouputStream.flush();
			    ouputStream.close();
			   
			         
			}
	
		
}
