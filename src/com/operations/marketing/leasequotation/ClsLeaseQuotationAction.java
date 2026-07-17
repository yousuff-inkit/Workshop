package com.operations.marketing.leasequotation;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;
import com.operations.marketing.leasecalculatoralfahim.ClsLeaseCalcAlFahimDAO;

@SuppressWarnings("serial")
public class ClsLeaseQuotationAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsLeaseQuotationDAO leaseQuotationDAO= new ClsLeaseQuotationDAO();
	ClsLeaseQuotationBean leaseQuotationBean;
	ClsLeaseCalculatorBean leaseCalculatorBean;
	
	private int docno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String date;
	private String hiddate;
	private String cmbtype;
	private String hidcmbtype;
	private String txtquotationvocno;
	private int txtquotationno;
	private String txtcustomername;
	private int txtcustomerdocno;
	private String txtcustomeraddress;
	private String txtcustomermobile;
	private String txtcustomeremail;
	private String txtsalesman;
	private int chckleasetoown;
	private int hidchckleasetoown;
	private int leasereqdoc;
	
	private String url;
	
	//Lease Application Grid
	private int gridlength;

	//Terms and Condition Grid
	private int termsgridlen;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lblcustomername;
	private String lblcustomeraddress;
	private String lblcustomermobile;
	private String lblcustomeremail;
	private String lblemployeename;
	private String lblemployeeaddress;
	private String lbljobtitle;
	private String lbldateofjoining;
	private String lblbankname;
	private String lblschemeoflease;
	
	private ArrayList termlist;
	
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String lblverifiedby;
	private String lblapprovedby;
	
	private int firstarray;
	private int secarray;
	
	//Lease Calculator
	private String lbldate;
	private String lbldocno;
	private String lblleasereqdocno;
	private String lblclient;
	private String lblclientaddress;
	private String lblmob;
	private String lblemail;
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public int getTxtquotationno() {
		return txtquotationno;
	}
	public void setTxtquotationno(int txtquotationno) {
		this.txtquotationno = txtquotationno;
	}
	public String getTxtquotationvocno() {
		return txtquotationvocno;
	}
	public void setTxtquotationvocno(String txtquotationvocno) {
		this.txtquotationvocno = txtquotationvocno;
	}
	public String getTxtcustomername() {
		return txtcustomername;
	}
	public void setTxtcustomername(String txtcustomername) {
		this.txtcustomername = txtcustomername;
	}
	public int getTxtcustomerdocno() {
		return txtcustomerdocno;
	}
	public void setTxtcustomerdocno(int txtcustomerdocno) {
		this.txtcustomerdocno = txtcustomerdocno;
	}
	public String getTxtcustomeraddress() {
		return txtcustomeraddress;
	}
	public void setTxtcustomeraddress(String txtcustomeraddress) {
		this.txtcustomeraddress = txtcustomeraddress;
	}
	public String getTxtcustomermobile() {
		return txtcustomermobile;
	}
	public void setTxtcustomermobile(String txtcustomermobile) {
		this.txtcustomermobile = txtcustomermobile;
	}
	public String getTxtcustomeremail() {
		return txtcustomeremail;
	}
	public void setTxtcustomeremail(String txtcustomeremail) {
		this.txtcustomeremail = txtcustomeremail;
	}
	public String getTxtsalesman() {
		return txtsalesman;
	}
	public void setTxtsalesman(String txtsalesman) {
		this.txtsalesman = txtsalesman;
	}
	public int getLeasereqdoc() {
		return leasereqdoc;
	}
	public void setLeasereqdoc(int leasereqdoc) {
		this.leasereqdoc = leasereqdoc;
	}
	public int getChckleasetoown() {
		return chckleasetoown;
	}
	public void setChckleasetoown(int chckleasetoown) {
		this.chckleasetoown = chckleasetoown;
	}
	public int getHidchckleasetoown() {
		return hidchckleasetoown;
	}
	public void setHidchckleasetoown(int hidchckleasetoown) {
		this.hidchckleasetoown = hidchckleasetoown;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getTermsgridlen() {
		return termsgridlen;
	}
	public void setTermsgridlen(int termsgridlen) {
		this.termsgridlen = termsgridlen;
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
	public String getLblpobox() {
		return lblpobox;
	}
	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
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
	public String getLblcustomername() {
		return lblcustomername;
	}
	public void setLblcustomername(String lblcustomername) {
		this.lblcustomername = lblcustomername;
	}
	public String getLblcustomeraddress() {
		return lblcustomeraddress;
	}
	public void setLblcustomeraddress(String lblcustomeraddress) {
		this.lblcustomeraddress = lblcustomeraddress;
	}
	public String getLblcustomermobile() {
		return lblcustomermobile;
	}
	public void setLblcustomermobile(String lblcustomermobile) {
		this.lblcustomermobile = lblcustomermobile;
	}
	public String getLblcustomeremail() {
		return lblcustomeremail;
	}
	public void setLblcustomeremail(String lblcustomeremail) {
		this.lblcustomeremail = lblcustomeremail;
	}
	public String getLblemployeename() {
		return lblemployeename;
	}
	public void setLblemployeename(String lblemployeename) {
		this.lblemployeename = lblemployeename;
	}
	public String getLblemployeeaddress() {
		return lblemployeeaddress;
	}
	public void setLblemployeeaddress(String lblemployeeaddress) {
		this.lblemployeeaddress = lblemployeeaddress;
	}
	public String getLbljobtitle() {
		return lbljobtitle;
	}
	public void setLbljobtitle(String lbljobtitle) {
		this.lbljobtitle = lbljobtitle;
	}
	public String getLbldateofjoining() {
		return lbldateofjoining;
	}
	public void setLbldateofjoining(String lbldateofjoining) {
		this.lbldateofjoining = lbldateofjoining;
	}
	public String getLblbankname() {
		return lblbankname;
	}
	public void setLblbankname(String lblbankname) {
		this.lblbankname = lblbankname;
	}
	public String getLblschemeoflease() {
		return lblschemeoflease;
	}
	public void setLblschemeoflease(String lblschemeoflease) {
		this.lblschemeoflease = lblschemeoflease;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
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

	java.sql.Date leaseQuotationDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsLeaseQuotationBean bean = new ClsLeaseQuotationBean();
		
		leaseQuotationDate = commonDAO.changeStringtoSqlDate(getDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Lease Application Grid Saving*/
			ArrayList<String> leaseapplicationarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				leaseapplicationarray.add(temp);
			}
			/*Lease Application Grid Saving Ends*/
			
			/*Terms and Condition Grid Saving*/
			ArrayList<String> termsandconditionarray= new ArrayList<String>();
			for(int j=0;j<getTermsgridlen();j++){
				String tempterms=requestParams.get("termg"+j)[0];
				termsandconditionarray.add(tempterms);
			}
			/*Terms and Condition Grid Saving Ends*/
			          
						int val=leaseQuotationDAO.insert(leaseQuotationDate,getFormdetailcode(),getCmbtype(),getTxtquotationno(),getTxtcustomerdocno(),getHidchckleasetoown(),getLeasereqdoc(),leaseapplicationarray,termsandconditionarray,session,request,mode);
						if(val>0.0){

							setDocno(val);
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
			
			/*Updating Lease Application Grid*/
			ArrayList<String> leaseapplicationarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				leaseapplicationarray.add(temp);
			}
			/*Updating Lease Application Grid Ends*/
			
			/*Updating Terms and Condition Grid Saving*/
			ArrayList<String> termsandconditionarray= new ArrayList<String>();
			for(int j=0;j<getTermsgridlen();j++){
				String tempterms=requestParams.get("termg"+j)[0];
				termsandconditionarray.add(tempterms);
			}
			/*Updating Terms and Condition Grid Saving Ends*/
			
			boolean Status=leaseQuotationDAO.edit(getDocno(),getFormdetailcode(),leaseQuotationDate,getCmbtype(),getTxtquotationno(),getTxtcustomerdocno(),getHidchckleasetoown(),getLeasereqdoc(),leaseapplicationarray,termsandconditionarray,session,request,mode);
			if(Status){
				
				setDocno(getDocno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setDocno(getDocno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=leaseQuotationDAO.delete(getDocno(),getFormdetailcode(),session);
			if(Status){
				
				setDocno(getDocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setDocno(getDocno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			leaseQuotationBean=leaseQuotationDAO.getViewDetails(session,getDocno());
			
			setDate(leaseQuotationBean.getDate());
			setHidcmbtype(leaseQuotationBean.getHidcmbtype());
			setTxtquotationvocno(leaseQuotationBean.getTxtquotationvocno());
			setTxtquotationno(leaseQuotationBean.getTxtquotationno());
			
			setTxtcustomername(leaseQuotationBean.getTxtcustomername());
			setTxtcustomerdocno(leaseQuotationBean.getTxtcustomerdocno());
			setTxtcustomeraddress(leaseQuotationBean.getTxtcustomeraddress());
			setTxtcustomermobile(leaseQuotationBean.getTxtcustomermobile());
			setTxtcustomeremail(leaseQuotationBean.getTxtcustomeremail());
			setTxtsalesman(leaseQuotationBean.getTxtsalesman());
			setHidchckleasetoown(leaseQuotationBean.getChckleasetoown());
			setLeasereqdoc(leaseQuotationBean.getLeasereqdoc());
			setFormdetailcode(leaseQuotationBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
    }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		String leasereqdocno=request.getParameter("leasereqdocno");
		leaseQuotationBean=leaseQuotationDAO.getPrint(request,docno,branch);
		
		ClsLeaseCalcAlFahimDAO leaseCalcDAO = new ClsLeaseCalcAlFahimDAO();
		leaseCalculatorBean=leaseCalcDAO.getPrint(leasereqdocno,request);
		
		setUrl(commonDAO.getPrintPath("LQT"));
		setLblcompname(leaseQuotationBean.getLblcompname());
		setLblcompaddress(leaseQuotationBean.getLblcompaddress());
		setLblpobox(leaseQuotationBean.getLblpobox());
		setLblprintname(leaseQuotationBean.getLblprintname());
		setLblcomptel(leaseQuotationBean.getLblcomptel());
		setLblcompfax(leaseQuotationBean.getLblcompfax());
		setLblbranch(leaseQuotationBean.getLblbranch());
		setLbllocation(leaseQuotationBean.getLbllocation());
		setLblservicetax(leaseQuotationBean.getLblservicetax());
		setLblpan(leaseQuotationBean.getLblpan());
		setLblcstno(leaseQuotationBean.getLblcstno());
		
		setLblcustomername(leaseQuotationBean.getLblcustomername());
		setLblcustomeraddress(leaseQuotationBean.getLblcustomeraddress());
		setLblcustomeremail(leaseQuotationBean.getLblcustomeremail());
		setLblcustomermobile(leaseQuotationBean.getLblcustomermobile());
	    setLblemployeename(leaseQuotationBean.getLblemployeename());
	    setLblemployeeaddress(leaseQuotationBean.getLblemployeeaddress());
	    setLbljobtitle(leaseQuotationBean.getLbljobtitle());
	    setLbldateofjoining(leaseQuotationBean.getLbldateofjoining());
	    setLblbankname(leaseQuotationBean.getLblbankname());
	    setLblschemeoflease(leaseQuotationBean.getLblschemeoflease());
		
	    setLblpreparedby(leaseQuotationBean.getLblpreparedby());
		setLblpreparedon(leaseQuotationBean.getLblpreparedon());
		setLblpreparedat(leaseQuotationBean.getLblpreparedat());
		setLblverifiedby(leaseQuotationBean.getLblverifiedby());
		setLblapprovedby(leaseQuotationBean.getLblapprovedby());
		
	    setFirstarray(leaseQuotationBean.getFirstarray());
	    setSecarray(leaseQuotationBean.getSecarray());
	
	    ArrayList termlist=leaseQuotationBean.getTermlist();
	    request.setAttribute("TERMLIST", termlist);

	    setLbldate(leaseCalculatorBean.getLbldate());
		setLbldocno(leaseCalculatorBean.getLbldocno());
		setLblleasereqdocno(leaseCalculatorBean.getLblleasereqdocno());
		setLblclient(leaseCalculatorBean.getLblclient());
		setLblclientaddress(leaseCalculatorBean.getLblclientaddress());
		setLblmob(leaseCalculatorBean.getLblmob());
		
	return "print";
	}
	
	
	
		/*public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String chequeDt,String chequeNo){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= leaseQuotationDAO.lqtMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}*/
		
		public void setData() {
			
			setHiddate(leaseQuotationDate==null?null:leaseQuotationDate.toString());
			setHidcmbtype(getCmbtype());
			setTxtquotationvocno(getTxtquotationvocno());
			setTxtquotationno(getTxtquotationno());
			setTxtcustomername(getTxtcustomername());
			setTxtcustomerdocno(getTxtcustomerdocno());
			setTxtcustomeraddress(getTxtcustomeraddress());
			setTxtcustomermobile(getTxtcustomermobile());
			setTxtcustomeremail(getTxtcustomeremail());
			setTxtsalesman(getTxtsalesman());
			setHidchckleasetoown(getHidchckleasetoown());
			setLeasereqdoc(getLeasereqdoc());
			setFormdetailcode(getFormdetailcode());
		}
}
