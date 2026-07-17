package com.operations.marketing.booking;






import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.marketing.booking.ClsbookingDAO;
import com.operations.marketing.booking.ClsbookingBean;
import com.operations.marketing.quotation.ClsquotationDAO;

@SuppressWarnings("serial")
public class ClsbookingAction extends ActionSupport{
	ClsbookingDAO bookingDAO= new ClsbookingDAO(); 
	ClsbookingBean bean= new ClsbookingBean(); 
	ClsbookingBean pintbean= new ClsbookingBean(); 
	ClsCommon commDAO=new ClsCommon();

	
	private String jqxBookingDate;
	private String hidjqxBookingDate;
	private String cmbreftype;
	private String bookrefno,refqouteno;
	private int bookingdocno;
	private String  bookclientno;
	private String bookemail;
	private String bookclientname;
	private String bookcontactno;
	private String booksalesAgent;
	private String bookattention;
	private String bookremark;
	private String guestremark;
	private int bookbrandid,masterdoc_no;
	private int bookmodelid;
	private int bookcolorid;    
	private int bookgroupid ;      
	private String renttype  ;
	
	
	private String jqxVehicleFromDate;
	private String hidjqxVehicleFromDate;
	private String jqxVehicleFromTime;
	private String hidjqxVehicleFromTime ;
	private String jqxVehicleToDate;
	private String hidjqxVehicleToDate;
	private String jqxVehicleToTime;
	private String hidjqxVehicleToTime;
	private int delivery_chkval;
	private int chauffeur_chkval;
	private String dellocation;
   
	private String mode,clientacno,clientname;
	private String msg;
	
	private int booksalesAgentid;
	//grid
	private int tarifgridlength;
	private int paymentgridlength;
	
	private String clientdetails;
	
	//        ---------------------
	private String bookslno;
	private String bookbrand;
	private String bookmodel;
	private String bookcolor;
	private String bookgroup;
	private String reftypeval,formdetailcode;
	private String deleted;
	
	private int tarifdoc,fleetno,ranos;
	
	
	 private String  delcharge,excessinsur,advance_chk,invoice,invoval,vehloc,codenos; 
	
	private int advance_chkval;
	
	
	 private String  setusernametxt;
	
	//------------------------------------------
	
	
	
	private String lblcstno,lblservicetax,lblpan;
	 private String url;
	
	private String lblclient,lblclientaddress,lblmob,lblemail,lbldate,lbltypep,lblbrand,lblmodel,lblcolor,lblgroup;
	private String lblrenttype,lblfromdate,lblfromtim,lbltodate,lbltotim,lbldelivery,lblchauffeur,lbldellocation,lblsaagnt,lblfleet;
	
	private int docvals,firstarray,secarray;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
	
	
	
	//===================================

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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}


	public String getLblfleet() {
		return lblfleet;
	}

	public void setLblfleet(String lblfleet) {
		this.lblfleet = lblfleet;
	}

	/*public int getLblfleet() {
		return lblfleet;
	}

	
	public void setLblfleet(int lblfleet) {
		this.lblfleet = lblfleet;
	}
*/
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

	
	public String getLblsaagnt() {
		return lblsaagnt;
	}

	public void setLblsaagnt(String lblsaagnt) {
		this.lblsaagnt = lblsaagnt;
	}

	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
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

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbltypep() {
		return lbltypep;
	}

	public void setLbltypep(String lbltypep) {
		this.lbltypep = lbltypep;
	}

	public String getLblbrand() {
		return lblbrand;
	}

	public void setLblbrand(String lblbrand) {
		this.lblbrand = lblbrand;
	}

	public String getLblmodel() {
		return lblmodel;
	}

	public void setLblmodel(String lblmodel) {
		this.lblmodel = lblmodel;
	}

	public String getLblcolor() {
		return lblcolor;
	}

	public void setLblcolor(String lblcolor) {
		this.lblcolor = lblcolor;
	}

	public String getLblgroup() {
		return lblgroup;
	}

	public void setLblgroup(String lblgroup) {
		this.lblgroup = lblgroup;
	}

	public String getLblrenttype() {
		return lblrenttype;
	}

	public void setLblrenttype(String lblrenttype) {
		this.lblrenttype = lblrenttype;
	}

	public String getLblfromdate() {
		return lblfromdate;
	}

	public void setLblfromdate(String lblfromdate) {
		this.lblfromdate = lblfromdate;
	}

	public String getLblfromtim() {
		return lblfromtim;
	}

	public void setLblfromtim(String lblfromtim) {
		this.lblfromtim = lblfromtim;
	}

	public String getLbltodate() {
		return lbltodate;
	}

	public void setLbltodate(String lbltodate) {
		this.lbltodate = lbltodate;
	}

	public String getLbltotim() {
		return lbltotim;
	}

	public void setLbltotim(String lbltotim) {
		this.lbltotim = lbltotim;
	}

	public String getLbldelivery() {
		return lbldelivery;
	}

	public void setLbldelivery(String lbldelivery) {
		this.lbldelivery = lbldelivery;
	}

	public String getLblchauffeur() {
		return lblchauffeur;
	}

	public void setLblchauffeur(String lblchauffeur) {
		this.lblchauffeur = lblchauffeur;
	}

	public String getLbldellocation() {
		return lbldellocation;
	}

	public void setLbldellocation(String lbldellocation) {
		this.lbldellocation = lbldellocation;
	}

	public int getDocvals() {
		return docvals;
	}

	public void setDocvals(int docvals) {
		this.docvals = docvals;
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

	public String getJqxBookingDate() {
		return jqxBookingDate;
	}

	public void setJqxBookingDate(String jqxBookingDate) {
		this.jqxBookingDate = jqxBookingDate;
	}

	public String getHidjqxBookingDate() {
		return hidjqxBookingDate;
	}

	public void setHidjqxBookingDate(String hidjqxBookingDate) {
		this.hidjqxBookingDate = hidjqxBookingDate;
	}

	public String getCmbreftype() {
		return cmbreftype;
	}


	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}


	public String getBookrefno() { 
		return bookrefno;
	}

	public void setBookrefno(String bookrefno) {
		this.bookrefno = bookrefno;
	}



	public String getBookemail() {
		return bookemail;
	}

	public void setBookemail(String bookemail) {
		this.bookemail = bookemail;
	}

	public int getBookingdocno() {
		return bookingdocno;
	}

	public void setBookingdocno(int bookingdocno) {
		this.bookingdocno = bookingdocno;
	}

	public String getBookclientno() {    
		return bookclientno;
	}

	public void setBookclientno(String bookclientno) {
		this.bookclientno = bookclientno;
	}

	public String getBookclientname() {
		return bookclientname;
	}

	public void setBookclientname(String bookclientname) {
		this.bookclientname = bookclientname;
	}

	public String getBookcontactno() {
		return bookcontactno;
	}

	public void setBookcontactno(String bookcontactno) {
		this.bookcontactno = bookcontactno;
	}

	public String getBooksalesAgent() {     
		return booksalesAgent;
	}

	public void setBooksalesAgent(String booksalesAgent) {
		this.booksalesAgent = booksalesAgent;
	}


	public String getBookattention() {
		return bookattention;
	}


	public void setBookattention(String bookattention) {
		this.bookattention = bookattention;
	}


	public String getBookremark() {
		return bookremark;
	}                                        



	public void setBookremark(String bookremark) {
		this.bookremark = bookremark;
	}
	public String getGuestremark() {
		return guestremark;
	}

	public void setGuestremark(String guestremark) {
		this.guestremark = guestremark;
	}

	public int getBooksalesAgentid() {
		return booksalesAgentid;
	}

	public void setBooksalesAgentid(int booksalesAgentid) {
		this.booksalesAgentid = booksalesAgentid;
	}


//////////////////////////////////////////////////////////////

	public int getBookbrandid() {
		return bookbrandid;               
	}

	public void setBookbrandid(int bookbrandid) {
		this.bookbrandid = bookbrandid;
	}

	public int getBookmodelid() {                
		return bookmodelid;
	}

	public void setBookmodelid(int bookmodelid) {
		this.bookmodelid = bookmodelid;
	}

	public int getBookcolorid() {
		return bookcolorid;
	}

	public void setBookcolorid(int bookcolorid) {
		this.bookcolorid = bookcolorid;
	}

	public int getBookgroupid() {
		return bookgroupid;
	}

	public void setBookgroupid(int bookgroupid) {
		this.bookgroupid = bookgroupid;
	}

	public String getRenttype() {
		return renttype;
	}

	public void setRenttype(String renttype) {
		this.renttype = renttype;
	}
	/////////////////////////////////////////////////////////////

	public String getJqxVehicleFromDate() {
		return jqxVehicleFromDate;
	}

	public void setJqxVehicleFromDate(String jqxVehicleFromDate) {
		this.jqxVehicleFromDate = jqxVehicleFromDate;
	}

	public String getHidjqxVehicleFromDate() {
		return hidjqxVehicleFromDate;
	}

	public void setHidjqxVehicleFromDate(String hidjqxVehicleFromDate) {
		this.hidjqxVehicleFromDate = hidjqxVehicleFromDate;
	}

	public String getJqxVehicleFromTime() {
		return jqxVehicleFromTime;
	}

	public void setJqxVehicleFromTime(String jqxVehicleFromTime) {
		this.jqxVehicleFromTime = jqxVehicleFromTime;
	}

	public String getHidjqxVehicleFromTime() {
		return hidjqxVehicleFromTime;
	}

	public void setHidjqxVehicleFromTime(String hidjqxVehicleFromTime) {
		this.hidjqxVehicleFromTime = hidjqxVehicleFromTime;
	}
	                                                
	public String getJqxVehicleToDate() {
		return jqxVehicleToDate;
	}

	public void setJqxVehicleToDate(String jqxVehicleToDate) {
		this.jqxVehicleToDate = jqxVehicleToDate;
	}

	public String getHidjqxVehicleToDate() {
		return hidjqxVehicleToDate;
	}

	public void setHidjqxVehicleToDate(String hidjqxVehicleToDate) {
		this.hidjqxVehicleToDate = hidjqxVehicleToDate;
	}
    public String getJqxVehicleToTime() {
         return jqxVehicleToTime;
       }

     public void setJqxVehicleToTime(String jqxVehicleToTime) {
    this.jqxVehicleToTime = jqxVehicleToTime;
        }
	public String getHidjqxVehicleToTime() {
		return hidjqxVehicleToTime;
	}

	public void setHidjqxVehicleToTime(String hidjqxVehicleToTime) {
		this.hidjqxVehicleToTime = hidjqxVehicleToTime;
	}
					


	public int getDelivery_chkval() {
		return delivery_chkval;
	}

	public void setDelivery_chkval(int delivery_chkval) {
		this.delivery_chkval = delivery_chkval;
	}

	public int getChauffeur_chkval() {
		return chauffeur_chkval;
	}

	public void setChauffeur_chkval(int chauffeur_chkval) {
		this.chauffeur_chkval = chauffeur_chkval;
	}

	public String getDellocation() {
		return dellocation;
	}

	public void setDellocation(String dellocation) {
		this.dellocation = dellocation;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	
	///////////////////////////////////
	
	public int getRanos() {
		return ranos;
	}

	public void setRanos(int ranos) {
		this.ranos = ranos;
	}

	public String getMsg() {
		return msg;
	}

	

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getTarifgridlength() {
		return tarifgridlength;
	}

	public void setTarifgridlength(int tarifgridlength) {
		this.tarifgridlength = tarifgridlength;
	}

	public int getPaymentgridlength() {
		return paymentgridlength;
	}

	public void setPaymentgridlength(int paymentgridlength) {
		this.paymentgridlength = paymentgridlength;
	}
/////////////

	public String getBookslno() {
		return bookslno;
	}

	public void setBookslno(String bookslno) { 
		this.bookslno = bookslno;
	}

	public String getBookbrand() {
		return bookbrand;
	}

	public void setBookbrand(String bookbrand) {
		this.bookbrand = bookbrand;
	}

	public String getBookmodel() {
		return bookmodel;
	}

	public void setBookmodel(String bookmodel) {
		this.bookmodel = bookmodel;
	}

	public String getBookcolor() {
		return bookcolor;
	}

	public void setBookcolor(String bookcolor) {
		this.bookcolor = bookcolor;
	}

	public String getBookgroup() {
		return bookgroup;
	}

	public void setBookgroup(String bookgroup) {
		this.bookgroup = bookgroup;
	}


	public String getReftypeval() {
		return reftypeval;
	}

	public void setReftypeval(String reftypeval) {
		this.reftypeval = reftypeval;
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

	
	
	
	public String getClientacno() {
		return clientacno;
	}

	public void setClientacno(String clientacno) {
		this.clientacno = clientacno;
	}

	public String getClientname() {
		return clientname;
	}

	public void setClientname(String clientname) {
		this.clientname = clientname;
	}
	

	public int getTarifdoc() {
		return tarifdoc;
	}

	public void setTarifdoc(int tarifdoc) {
		this.tarifdoc = tarifdoc;
	}

	public int getFleetno() {
		return fleetno;
	}

	public void setFleetno(int fleetno) {
		this.fleetno = fleetno;
	}
	//--------------------------------------------
	
	
	public String getDelcharge() {
		return delcharge;
	}

	public void setDelcharge(String delcharge) {
		this.delcharge = delcharge;
	}

	public String getExcessinsur() {
		return excessinsur;
	}

	public void setExcessinsur(String excessinsur) {
		this.excessinsur = excessinsur;
	}

	public String getAdvance_chk() {  
		return advance_chk;
	}

	public void setAdvance_chk(String advance_chk) {
		this.advance_chk = advance_chk;
	}

	public String getInvoice() {         
		return invoice;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	public String getInvoval() {          
		return invoval;
	}

	public void setInvoval(String invoval) {
		this.invoval = invoval;
	}

	public int getAdvance_chkval() {
		return advance_chkval;
	}

	public void setAdvance_chkval(int advance_chkval) {
		this.advance_chkval = advance_chkval;
	}

	public String getVehloc() {
		return vehloc;
	}

	public void setVehloc(String vehloc) {
		this.vehloc = vehloc;
	}

	public String getCodenos() {
		return codenos;
	}

	public void setCodenos(String codenos) {
		this.codenos = codenos;
	}

	//----------------------------

	public String getRefqouteno() {
		return refqouteno;
	}

	public void setRefqouteno(String refqouteno) {
		this.refqouteno = refqouteno;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	
	
	public String getSetusernametxt() {
		return setusernametxt;
	}

	public void setSetusernametxt(String setusernametxt) {
		this.setusernametxt = setusernametxt;
	}

	public String saveAction() throws ParseException, SQLException{
				HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		java.sql.Date sqlStartDate = commDAO.changeStringtoSqlDate(getJqxBookingDate());
		

		java.sql.Date vehfromdate = commDAO.changeStringtoSqlDate(getJqxVehicleFromDate());

		java.sql.Date vehtodate = commDAO.changeStringtoSqlDate(getJqxVehicleToDate());
	
		
		if(mode.equalsIgnoreCase("A")){
		
			ArrayList<String> qtarifarray= new ArrayList<>();
			for(int i=0;i<getTarifgridlength();i++){
				String temp2=requestParams.get("test"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
		
				qtarifarray.add(temp2);
		 			           }
			
			ArrayList<String> paymentarray= new ArrayList<>();
			for(int i=0;i<getPaymentgridlength();i++){
			
			 String temp=requestParams.get("paytest"+i)[0];
			 paymentarray.add(temp);
			 
			}
				
				
			int val=bookingDAO.insert(sqlStartDate,vehfromdate,vehtodate,getCmbreftype(),getRefqouteno(),getBookclientno(),
					getBookcontactno(),getBookattention(),getBookremark(),getBookbrandid(),getBookmodelid(),getBookcolorid(),
					getBookgroupid(),getRenttype(),getJqxVehicleToTime(),getJqxVehicleFromTime(),getDelivery_chkval(),
					getChauffeur_chkval(),getDellocation(),getGuestremark(),getBooksalesAgentid(),getBookemail(),
					qtarifarray,paymentarray,getBookslno(),getMode(),session,getFormdetailcode(),request,getClientname(),
					getClientacno(),getTarifdoc(),getFleetno(),
					getDelcharge(),getExcessinsur(),getAdvance_chkval(),getInvoice(),getVehloc(),getCodenos(),getClientdetails());
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				
				
				setRefqouteno(getRefqouteno());	
				setBookingdocno(vdocno);
				setMasterdoc_no(val);
				
				setDelcharge(getDelcharge());
				setExcessinsur(getExcessinsur());
				setInvoval(getInvoice());
				setAdvance_chkval(getAdvance_chkval());
				setVehloc(getVehloc());
				setCodenos(getCodenos());
				
				setTarifdoc(getTarifdoc());
				
			/*	if(getFleetno()==0)
				{
					setFleetno();
				}
				*/
				setFleetno(getFleetno());
				
				setHidjqxBookingDate(sqlStartDate.toString());
				setHidjqxVehicleFromDate(vehfromdate.toString());
				setHidjqxVehicleToDate(vehtodate.toString());
				setHidjqxVehicleFromTime(getJqxVehicleFromTime());
				setHidjqxVehicleToTime(getJqxVehicleToTime());
				//main
				setReftypeval(getCmbreftype());
				setBookrefno(getBookrefno());
				// main 
				setBookclientno(getBookclientno());
				setBookclientname(getBookclientname());
				
				setBookcontactno(getBookcontactno());
				setBookemail(getBookemail());
				setBookattention(getBookattention());
				setGuestremark(getGuestremark());
				
				//veh
				 setBookslno(getBookslno());
				 setBookbrand(getBookbrand());
				 setBookmodel(getBookmodel());
				 setBookcolor(getBookcolor());
				 setBookgroup(getBookgroup());
				 setRenttype(getRenttype());
				 //
				 
				setBookremark(getBookremark());
				setDellocation(getDellocation());
				
				
				setDelivery_chkval(getDelivery_chkval());
				setChauffeur_chkval(getChauffeur_chkval());
				setClientname(getClientname());
				setClientacno(getClientacno());

				setClientdetails(getClientdetails());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				
				setRefqouteno(getRefqouteno());	
				setBookingdocno(vdocno);
				setMasterdoc_no(val);
				setDelcharge(getDelcharge());
				setExcessinsur(getExcessinsur());
				setInvoval(getInvoice());
				setAdvance_chkval(getAdvance_chkval());
				setVehloc(getVehloc());
				setCodenos(getCodenos());
				
				setTarifdoc(getTarifdoc());
				setFleetno(getFleetno());
				
				setHidjqxBookingDate(sqlStartDate.toString());
				setHidjqxVehicleFromDate(vehfromdate.toString());
				setHidjqxVehicleToDate(vehtodate.toString());
				setHidjqxVehicleFromTime(getJqxVehicleFromTime());
				setHidjqxVehicleToTime(getJqxVehicleToTime());
				//main
				setReftypeval(getCmbreftype());
				setBookrefno(getBookrefno());
				// main 
				setBookclientno(getBookclientno());
				setBookclientname(getBookclientname());
				
				setBookcontactno(getBookcontactno());
				setBookemail(getBookemail());
				setBookattention(getBookattention());
				setGuestremark(getGuestremark());
				
				//veh
				 setBookslno(getBookslno());
				 setBookbrand(getBookbrand());
				 setBookmodel(getBookmodel());
				 setBookcolor(getBookcolor());
				 setBookgroup(getBookgroup());
				 setRenttype(getRenttype());
				 //
				 
				setBookremark(getBookremark());
				setDellocation(getDellocation());
				setClientname(getClientname());
				setClientacno(getClientacno());

				
				setDelivery_chkval(getDelivery_chkval());
				setChauffeur_chkval(getChauffeur_chkval());
				setClientdetails(getClientdetails());
				setMsg("Not Saved");
				return "fail";
			}
		}
       

		else if(mode.equalsIgnoreCase("D")){
				int Status=bookingDAO.delete(getBookingdocno(),session,getMode(),getFormdetailcode(),getCmbreftype(),getBookrefno());
			if(Status>0){
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else if(Status==-1)
			{
				setMsg("Enquiry Is IN Progress");
				return "fail";	
				
			}
			else{
				setMsg("Not Deleted");
				return "fail";
			}
		
		}
		if(mode.equalsIgnoreCase("view")){
			
			//System.out.println("00000000000"+getJqxVehicleFromTime());
			
			setSetusernametxt(getSetusernametxt());
			
			setHidjqxBookingDate(sqlStartDate.toString());
			setHidjqxVehicleFromDate(vehfromdate.toString());
			setHidjqxVehicleToDate(vehtodate.toString());
			setHidjqxVehicleFromTime(getJqxVehicleFromTime());
			setHidjqxVehicleToTime(getJqxVehicleToTime());
			
			setRanos(getRanos());
			setDelcharge(getDelcharge());
			setExcessinsur(getExcessinsur());
			setInvoval(getInvoice());
			setAdvance_chkval(getAdvance_chkval());
			setVehloc(getVehloc());
			setCodenos(getCodenos());
			setTarifdoc(getTarifdoc());
			setFleetno(getFleetno());
			
		}
	return "fail";	
		
	}
	


	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		
		 pintbean=bookingDAO.getPrint(doc,request);
	
		 
		 setLblfleet(pintbean.getLblfleet());
		 
		    setLblsaagnt(pintbean.getLblsaagnt());
    	    setLblbrand(pintbean.getLblbrand());
    	    setLblmodel(pintbean.getLblmodel());
    	    setLblcolor(pintbean.getLblcolor());
    	    //upper
    	    setLblgroup(pintbean.getLblgroup());
    	    setLblrenttype(pintbean.getLblrenttype());
    	    setLblfromdate(pintbean.getLblfromdate());
    	    
    	    
    	    setLblfromtim(pintbean.getLblfromtim());
    	    setLbltodate(pintbean.getLbltodate());
    	    setLbltotim(pintbean.getLbltotim());
    	    setLbldelivery(pintbean.getLbldelivery());
    	    //upper
    	    setLblchauffeur(pintbean.getLblchauffeur());
    	    setLbldellocation(pintbean.getLbldellocation());

		
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
		
		
	    setLblprintname("Booking");
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());

	   
	   setLblcstno(pintbean.getLblcstno());
 	   setLblservicetax(pintbean.getLblservicetax());
	   setLblpan(pintbean.getLblpan());
	   setUrl(commDAO.getPrintPath("VBR"));

		  
	   setFirstarray(pintbean.getFirstarray());
	   setSecarray(pintbean.getSecarray());

	   
		 return "print";
		 }	
	
	
	
	

	public   String payment(){
		
		String cellarray1 = "";  
		
		
		  try {
			  List <ClsbookingBean> list= bookingDAO.list4();
			  for(ClsbookingBean bean:list){
				  		cellarray1+=bean.getPaymentmode()+",";
			 
			  

			 }
			  cellarray1=cellarray1.substring(0, cellarray1.length()-1);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray1;
	}
	
}
