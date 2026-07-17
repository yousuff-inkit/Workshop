package com.operations.marketing.leasepricerequestalfahim;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsLeasePriceRequestAlfahimAction {
	ClsCommon CommonDAO=new ClsCommon();
	ClsLeasePriceRequestAlfahimDAO lprequestDAO=new ClsLeasePriceRequestAlfahimDAO();
	ClsLeasePriceRequestAlfahimBean pintbean=new ClsLeasePriceRequestAlfahimBean();
	 private int docno,masterdoc_no;
		
		
		private String EnquiryDate;
		private String hidEnquiryDate;
		private String cmbclient;
		private String txtclientname;
	    private int genaral;
	    private int client;
		
		private String txtaddress;
		private String txtmobile;
		private String txtRemarks;
		private String txtemail;
		private String mode,formdetailcode;
		private int gridval;
		
		// grid
		private int enqgridlenght;
		private String enqsrc,hidenqsrc;
		
		
		public String getEnqsrc() {
			return enqsrc;
		}
		public void setEnqsrc(String enqsrc) {
			this.enqsrc = enqsrc;
		}
		public String getHidenqsrc() {
			return hidenqsrc;
		}
		public void setHidenqsrc(String hidenqsrc) {
			this.hidenqsrc = hidenqsrc;
		}


		// for radio chk
		private int forradiochk;
		//
		private String addvalchange;
		private String remvalchange;
		
		//
		private String deleted;
		//
		private String enqdtype;
		
		private String msg;
		
		private int txtradio;
		
		
		
		//-------------------------------------------------------
		
		
		
		private String lblclient,lblclientaddress,lblmob,lblemail,lbldate,lbltypep;
		
		private int docvals;
		
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
		
		//------------------------------------------------
		public int getMasterdoc_no() {
			return masterdoc_no;
		}
		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}
		
		
		
		public int getTxtradio() {
			return txtradio;
		}

		public String getLblclient() {
			return lblclient;
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
		public void setTxtradio(int txtradio) {
			this.txtradio = txtradio;
		}
		public String getMsg() {
			return msg;
		}
		public void setMsg(String msg) {
			this.msg = msg;
		}
		public int getGridval() {
			return gridval;
		}
		public void setGridval(int gridval) {
			this.gridval = gridval;
		}
		public String getAddvalchange() {
			return addvalchange;
		}
		public void setAddvalchange(String addvalchange) {
			this.addvalchange = addvalchange;
		}
		public String getRemvalchange() {
			return remvalchange;
		}
		public void setRemvalchange(String remvalchange) {
			this.remvalchange = remvalchange;
		}
		public int getForradiochk() {
			return forradiochk;
		}
		public void setForradiochk(int forradiochk) {
			this.forradiochk = forradiochk;
		}
		public int getDocno() {
			return docno;
		}
		public void setDocno(int docno) {
			this.docno = docno;
		}
		
		
		
		public String getEnquiryDate() {
			return EnquiryDate;
		}
		public void setEnquiryDate(String enquiryDate) {
			EnquiryDate = enquiryDate;
		}
		
		
		public String getHidEnquiryDate() {
			return hidEnquiryDate;
		}
		public void setHidEnquiryDate(String hidEnquiryDate) {
			this.hidEnquiryDate = hidEnquiryDate;
		}
		public String getCmbclient() {
			return cmbclient;
		}
		public void setCmbclient(String cmbclient) {
			this.cmbclient = cmbclient;
		}
		
		public String getTxtclientname() {
			return txtclientname;
		}
		public void setTxtclientname(String txtclientname) {
			this.txtclientname = txtclientname;
		}
		public String getTxtaddress() {
			return txtaddress;
		}
		public void setTxtaddress(String txtaddress) {
			this.txtaddress = txtaddress;
		}

		public String getTxtmobile() {
			return txtmobile;
		}
		public void setTxtmobile(String txtmobile) {
			this.txtmobile = txtmobile;
		}
		
		public String getTxtRemarks() {
			return txtRemarks;
		}
		public void setTxtRemarks(String txtRemarks) {
			this.txtRemarks = txtRemarks;
		}
		
		
		
		public int getGenaral() {
			return genaral;
		}
		public void setGenaral(int genaral) {
			this.genaral = genaral;
		}
		public int getClient() {
			return client;
		}
		public void setClient(int client) {
			this.client = client;
		}
		
		
		
		public String getTxtemail() {
			return txtemail;
		}
		public void setTxtemail(String txtemail) {
			this.txtemail = txtemail;
		}
		public String getMode() {
			return mode;
		}
		public void setMode(String mode) {
			this.mode = mode;
		}
		
		//grid

		
		public int getEnqgridlenght() {
			return enqgridlenght;
		}
		public void setEnqgridlenght(int enqgridlenght) {
			this.enqgridlenght = enqgridlenght;
		}
		
		
		
		
		public String getFormdetailcode() {
			return formdetailcode;
		}
		public void setFormdetailcode(String formdetailcode) {
			this.formdetailcode = formdetailcode;
		}
		public String getDeleted() {
			return deleted;
		}
		public void setDeleted(String deleted) {
			this.deleted = deleted;
		}
		
		public String getEnqdtype() {
			return enqdtype;
		}
		public void setEnqdtype(String enqdtype) {
			this.enqdtype = enqdtype;
		}
		
		public String saveAction() throws ParseException, SQLException{
					HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			java.sql.Date sqlStartDate = CommonDAO.changeStringtoSqlDate(getEnquiryDate());
			String mode=getMode();
			//System.out.println(mode);
			String mobno=getTxtmobile();
		
		
		
			if(mode.equalsIgnoreCase("A")){
				ArrayList<String> enqarray= new ArrayList<>();
				for(int i=0;i<getEnqgridlenght();i++){
					String temp2=requestParams.get("enqtest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				
				 enqarray.add(temp2);
				 
				}
				int val=lprequestDAO.insert(sqlStartDate,getCmbclient(),getTxtclientname(),getTxtaddress(),mobno,getGenaral(),getClient(),getTxtRemarks(),getTxtemail(),enqarray,session,getMode(),getFormdetailcode(),request,getHidenqsrc());
				int vdocno=(int) request.getAttribute("vocno");
				if(val>0){
					
					setHidEnquiryDate(sqlStartDate.toString());
					setCmbclient(getCmbclient());
					setTxtclientname(getTxtclientname());
					setTxtaddress(getTxtaddress());
					setTxtemail(getTxtemail());
					setTxtmobile(getTxtmobile());
					setTxtRemarks(getTxtRemarks());
					setForradiochk(getForradiochk());
					setTxtradio(getTxtradio());
					setEnqsrc(getEnqsrc());
					setHidenqsrc(getHidenqsrc());
					setDocno(vdocno);
					setMasterdoc_no(val);

					setGridval(getGridval());
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setHidEnquiryDate(sqlStartDate.toString());
					setCmbclient(getCmbclient());
					setTxtclientname(getTxtclientname());
					setTxtaddress(getTxtaddress());
					setTxtemail(getTxtemail());
					setTxtmobile(getTxtmobile());
					setTxtRemarks(getTxtRemarks());
					setForradiochk(getForradiochk());
					setTxtradio(getTxtradio());
					setEnqsrc(getEnqsrc());
					setHidenqsrc(getHidenqsrc());
					setDocno(vdocno);
					setMasterdoc_no(val);

					setGridval(getGridval());
					setMsg("Not Saved");
					return "fail";
				}
			}
	       
				else if(mode.equalsIgnoreCase("E")){
					ArrayList<String> enqarray= new ArrayList<>();
					for(int i=0;i<getEnqgridlenght();i++){
						String temp2=requestParams.get("enqtest"+i)[0];
				
					 enqarray.add(temp2);
					 
					}
					boolean Status=lprequestDAO.edit(getMasterdoc_no(),sqlStartDate,getCmbclient(),getTxtclientname(),getTxtaddress(),mobno,getGenaral(),getClient(),getTxtRemarks(),getTxtemail(),enqarray,session,getMode(),getFormdetailcode(),getHidenqsrc());
					if(Status){
						setEnqsrc(getEnqsrc());
						setHidenqsrc(getHidenqsrc());
						setHidEnquiryDate(sqlStartDate.toString());
						setCmbclient(getCmbclient());
						setTxtclientname(getTxtclientname());
						setTxtaddress(getTxtaddress());
						setTxtemail(getTxtemail());
						setTxtmobile(getTxtmobile());
						setTxtRemarks(getTxtRemarks());
						setTxtradio(getTxtradio());
						setForradiochk(getForradiochk());
						setDocno(getDocno());
						setMasterdoc_no(getMasterdoc_no());
						setGridval(getGridval());
						setMsg("Updated Successfully");
						return "success";
					
					}
					else{
						setHidEnquiryDate(sqlStartDate.toString());
						setCmbclient(getCmbclient());
						setTxtclientname(getTxtclientname());
						setTxtaddress(getTxtaddress());
						setTxtemail(getTxtemail());
						setTxtmobile(getTxtmobile());
						setTxtRemarks(getTxtRemarks());
						setTxtradio(getTxtradio());
						setForradiochk(getForradiochk());
						setDocno(getDocno());
						setMasterdoc_no(getMasterdoc_no());
						setGridval(getGridval());
						setEnqsrc(getEnqsrc());
						setHidenqsrc(getHidenqsrc());
						setMsg("Not Updated");
						return "fail";
					}
				}
			else if(mode.equalsIgnoreCase("D")){
					int Status=lprequestDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
				if(Status==1){
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					setHidEnquiryDate(sqlStartDate.toString());
					setCmbclient(getCmbclient());
					setTxtclientname(getTxtclientname());
					setTxtaddress(getTxtaddress());
					setTxtemail(getTxtemail());
					setTxtmobile(getTxtmobile());
					setTxtRemarks(getTxtRemarks());
					setTxtradio(getTxtradio());
					setForradiochk(getForradiochk());
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());
					setGridval(getGridval());
					setEnqsrc(getEnqsrc());
					setHidenqsrc(getHidenqsrc());
					return "success";
				}
			/*	else if(Status==-1)
				{
					
					setMsg("Enquiry Under Process");
					return "fail";
					
				}*/
				
				else{
					setHidEnquiryDate(sqlStartDate.toString());
					setCmbclient(getCmbclient());
					setTxtclientname(getTxtclientname());
					setTxtaddress(getTxtaddress());
					setTxtemail(getTxtemail());
					setTxtmobile(getTxtmobile());
					setTxtRemarks(getTxtRemarks());
					setTxtradio(getTxtradio());
					setForradiochk(getForradiochk());
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());
					setGridval(getGridval());
					setEnqsrc(getEnqsrc());
					setHidenqsrc(getHidenqsrc());
					setMsg("Not Deleted");
					return "fail";
				}
			
			}
			if(mode.equalsIgnoreCase("view")){
				setHidEnquiryDate(sqlStartDate.toString());
			}
			
		return "fail";	
			
		}
		
		
		 public String printAction() throws ParseException, SQLException{
				
			  HttpServletRequest request=ServletActionContext.getRequest();
			 
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 
			
			 pintbean=lprequestDAO.getPrint(doc);
			 ArrayList<String> arraylist = lprequestDAO.getPrintdetails(doc);
			 
			
			  //cl details
			 
			 setLblprintname("Lease Price Request");
		    setLblclient(pintbean.getLblclient());
		    setLblclientaddress(pintbean.getLblclientaddress());
		    setLblmob(pintbean.getLblmob());
		    setLblemail(pintbean.getLblemail());
		    //upper
		    setLbldate(pintbean.getLbldate());
		    setLbltypep(pintbean.getLbltypep());
		    setDocvals(pintbean.getDocvals());
			 
			request.setAttribute("details",arraylist); 
			
			
			
		  setLblbranch(pintbean.getLblbranch());
		   setLblcompname(pintbean.getLblcompname());
		  
		  setLblcompaddress(pintbean.getLblcompaddress());
		 
		   setLblcomptel(pintbean.getLblcomptel());
		  
		  setLblcompfax(pintbean.getLblcompfax());
		   setLbllocation(pintbean.getLbllocation());
		  

	  	   
			 return "print";
			 }	
		
		
		
		
	/*	public  String searchTariff(){
			
			String cellarray1 = "";  
			
			
			  try {
				  List <ClsEnquiryBean> list= ClsEnquiryDAO.list4();
				  for(ClsEnquiryBean bean:list){
					  		cellarray1+=bean.getRentaltype()+",";
				 
				  

				 }
				  cellarray1=cellarray1.substring(0, cellarray1.length()-1);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray1;
		}
		*/
}
