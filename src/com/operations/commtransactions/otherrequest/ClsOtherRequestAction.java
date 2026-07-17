package com.operations.commtransactions.otherrequest;

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
public class ClsOtherRequestAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();


	ClsOtherRequestDAO otherRequestDAO= new ClsOtherRequestDAO();
	ClsOtherRequestBean otherRequestBean;

	private int txtotherrequestdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String brchName;
	private String jqxOtherRequestDate;
	private String hidjqxOtherRequestDate;
	private String txtrefno;
	private int txtclientdocno;
	private String txtclientname;
	private String cmbservicetype;
	private String hidcmbservicetype;
	private String txtremarks;
	private String txtservicefulldetail;
	private String cmbratype;
	private String hidcmbratype;
	private int txtrano;
	private String txtravocher;
	private String chkadddriver;
	private String adddriverintickval;
	private double txtamount;
	private String txtdescription;
	private String chkstatus;
	
	//Other Request Grid
	private int gridlength;
	private int drivergridlength;
	
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
	
	private String lbldate;
	private String lblratype;
	private String lblrano;
	private String lbldocno;
	private String lblclient;
	private String lbldescription;
	
	//for hide
	private int firstarray;
	
	public int getTxtotherrequestdocno() {
		return txtotherrequestdocno;
	}

	public void setTxtotherrequestdocno(int txtotherrequestdocno) {
		this.txtotherrequestdocno = txtotherrequestdocno;
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

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getJqxOtherRequestDate() {
		return jqxOtherRequestDate;
	}

	public void setJqxOtherRequestDate(String jqxOtherRequestDate) {
		this.jqxOtherRequestDate = jqxOtherRequestDate;
	}

	public String getHidjqxOtherRequestDate() {
		return hidjqxOtherRequestDate;
	}

	public void setHidjqxOtherRequestDate(String hidjqxOtherRequestDate) {
		this.hidjqxOtherRequestDate = hidjqxOtherRequestDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public int getTxtclientdocno() {
		return txtclientdocno;
	}

	public void setTxtclientdocno(int txtclientdocno) {
		this.txtclientdocno = txtclientdocno;
	}

	public String getTxtclientname() {
		return txtclientname;
	}

	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}

	public String getCmbservicetype() {
		return cmbservicetype;
	}

	public void setCmbservicetype(String cmbservicetype) {
		this.cmbservicetype = cmbservicetype;
	}

	public String getHidcmbservicetype() {
		return hidcmbservicetype;
	}

	public void setHidcmbservicetype(String hidcmbservicetype) {
		this.hidcmbservicetype = hidcmbservicetype;
	}

	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}

	public String getTxtservicefulldetail() {
		return txtservicefulldetail;
	}

	public void setTxtservicefulldetail(String txtservicefulldetail) {
		this.txtservicefulldetail = txtservicefulldetail;
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

	public int getTxtrano() {
		return txtrano;
	}

	public void setTxtrano(int txtrano) {
		this.txtrano = txtrano;
	}

	public String getTxtravocher() {
		return txtravocher;
	}

	public void setTxtravocher(String txtravocher) {
		this.txtravocher = txtravocher;
	}

	public String getChkadddriver() {
		return chkadddriver;
	}

	public void setChkadddriver(String chkadddriver) {
		this.chkadddriver = chkadddriver;
	}

	public String getAdddriverintickval() {
		return adddriverintickval;
	}

	public void setAdddriverintickval(String adddriverintickval) {
		this.adddriverintickval = adddriverintickval;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getDrivergridlength() {
		return drivergridlength;
	}

	public void setDrivergridlength(int drivergridlength) {
		this.drivergridlength = drivergridlength;
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

	public String getLbldocno() {
		return lbldocno;
	}

	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}

	public String getLblclient() {
		return lblclient;
	}

	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	java.sql.Date otherRequestDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsOtherRequestBean bean = new ClsOtherRequestBean();
		otherRequestDate = ClsCommon.changeStringtoSqlDate(getJqxOtherRequestDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Other Request Grid*/
			ArrayList<String> otherrequestarray= new ArrayList<>();

			if(getAdddriverintickval().equalsIgnoreCase("1")){
				otherrequestarray.add("Additional Driver::"+getTxtdescription()+"::"+getTxtamount()+"::4");
			}
			
			for(int i=0;i<getGridlength();i++){
				ClsOtherRequestBean otherRequestBean=new ClsOtherRequestBean();
				String temp=requestParams.get("test"+i)[0];
				otherrequestarray.add(temp);
			}
			
			ArrayList<String> driverarray= new ArrayList<>();
			/*Driver Grid*/
			for(int i=0;i<getDrivergridlength();i++){
				ClsOtherRequestBean otherRequestBean=new ClsOtherRequestBean();
				String temp1=requestParams.get("tested"+i)[0];
				driverarray.add(temp1);
			}
			
			int val=otherRequestDAO.insert(getFormdetailcode(),getBrchName(),otherRequestDate,getTxtrefno(),getTxtclientdocno(),getCmbratype(),getTxtrano(),getAdddriverintickval(),getTxtremarks(),getTxtdescription(),getTxtamount(),otherrequestarray,driverarray,session,mode);
			if(val>0.0){
				
				setTxtotherrequestdocno(val);
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
			/*Other Request Grid*/
			ArrayList<String> otherrequestarray= new ArrayList<>();
			if(getAdddriverintickval().equalsIgnoreCase("1")){
				otherrequestarray.add("Additional Driver::"+getTxtdescription()+"::"+getTxtamount()+"::4");
			}
			
			for(int i=0;i<getGridlength();i++){
				ClsOtherRequestBean otherRequestBean=new ClsOtherRequestBean();
				String temp=requestParams.get("test"+i)[0];
				otherrequestarray.add(temp);
			}
			
			ArrayList<String> driverarray= new ArrayList<>();
			/*Driver Grid*/
			for(int i=0;i<getDrivergridlength();i++){
				ClsOtherRequestBean otherRequestBean=new ClsOtherRequestBean();
				String temp1=requestParams.get("tested"+i)[0];
				driverarray.add(temp1);
			}
			
			int Status=otherRequestDAO.edit(getFormdetailcode(),getBrchName(),getTxtotherrequestdocno(),otherRequestDate,getTxtrefno(),getTxtclientdocno(),getCmbratype(),getTxtrano(),getAdddriverintickval(),getTxtremarks(),getTxtdescription(),getTxtamount(),otherrequestarray,driverarray,session,mode);
			if(Status>0){
				
				setTxtotherrequestdocno(getTxtotherrequestdocno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtotherrequestdocno(getTxtotherrequestdocno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			int Status=otherRequestDAO.delete(getBrchName(),getTxtotherrequestdocno(),getFormdetailcode(),session,mode);
			if(Status>0){
				
				setTxtotherrequestdocno(getTxtotherrequestdocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else if(Status==-1)
			   {
				setChkstatus("1");
				setData();
				setMsg("Transaction Already Exists.");
				return "fail";
			}
			else{
				setTxtotherrequestdocno(getTxtotherrequestdocno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("View")){
			String branch=null;
			otherRequestBean=otherRequestDAO.getViewDetails(getBrchName(),getTxtotherrequestdocno());
			setJqxOtherRequestDate(otherRequestBean.getJqxOtherRequestDate());
			setTxtrefno(otherRequestBean.getTxtrefno());
			setTxtclientdocno(otherRequestBean.getTxtclientdocno());
			setTxtclientname(otherRequestBean.getTxtclientname());
			setHidcmbratype(otherRequestBean.getHidcmbratype());
			setTxtrano(otherRequestBean.getTxtrano());
			setTxtravocher(otherRequestBean.getTxtravocher());
			setTxtremarks(otherRequestBean.getTxtremarks());
			setAdddriverintickval(otherRequestBean.getChkadddriver());
			setTxtdescription(otherRequestBean.getTxtdescription());
			setTxtamount(otherRequestBean.getTxtamount());
			setFormdetailcode(otherRequestBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
}

		public  JSONArray searchDetails(String branch,String partyname,String docNo,String date,String ratype,String raNo){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= otherRequestDAO.oreMainSearch(branch, partyname, docNo, date, ratype, raNo);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public String printAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			int docno=Integer.parseInt(request.getParameter("docno"));
			int branch=Integer.parseInt(request.getParameter("branch"));
			otherRequestBean=otherRequestDAO.getPrint(branch,request,docno);
			
			setLblcompname(otherRequestBean.getLblcompname());
			setLblcompaddress(otherRequestBean.getLblcompaddress());
			setLblprintname(otherRequestBean.getLblprintname());
			setLblcomptel(otherRequestBean.getLblcomptel());
			setLblcompfax(otherRequestBean.getLblcompfax());
			setLblbranch(otherRequestBean.getLblbranch());
			setLbllocation(otherRequestBean.getLbllocation());
			setLblcstno(otherRequestBean.getLblcstno());
			setLblpan(otherRequestBean.getLblpan());
			setLblservicetax(otherRequestBean.getLblservicetax());
			setLbldate(otherRequestBean.getLbldate());
			setLblratype(otherRequestBean.getLblratype());
			setLblrano(otherRequestBean.getLblrano());
			setLbldocno(otherRequestBean.getLbldocno());
			setLblclient(otherRequestBean.getLblclient());
			setLbldescription(otherRequestBean.getLbldescription());
			
			// for hide
			setFirstarray(otherRequestBean.getFirstarray());
		
		return "print";
		}
		
		public void setData(){
			setHidjqxOtherRequestDate(otherRequestDate.toString());
			setTxtrefno(getTxtrefno());
			setTxtclientdocno(getTxtclientdocno());
			setTxtclientname(getTxtclientname());
			setHidcmbratype(getCmbratype());
			setTxtrano(getTxtrano());
			setTxtravocher(getTxtravocher());
			setHidcmbservicetype(getCmbservicetype());
			setTxtremarks(getTxtremarks());
			setTxtservicefulldetail(getTxtservicefulldetail());
			setAdddriverintickval(getAdddriverintickval());
			setTxtamount(getTxtamount());
			setTxtdescription(getTxtdescription());
			setFormdetailcode(getFormdetailcode());
		}
		
}

