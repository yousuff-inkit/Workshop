package com.project.execution.projectInvoice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
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

import org.apache.http.HttpRequest;
import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.common.ClsNumberToWord;
import com.ibm.icu.text.DecimalFormat;
import com.project.execution.projectInvoice.ClsProjectInvoiceBean;
import com.project.execution.projectInvoice.ClsProjectInvoiceDAO;
import com.project.execution.projectproInvoice.ClsProjectProInvoiceBean;
import com.project.execution.projectproInvoice.ClsProjectProInvoiceDAO;
import com.project.execution.quotation.ClsQuotationBean;
import com.project.execution.quotation.ClsQuotationDAO;

public class ClsProjectInvoiceAction {

	ClsCommon com=new ClsCommon();
	ClsProjectInvoiceDAO proinvDAO= new ClsProjectInvoiceDAO();
	ClsProjectInvoiceBean proinvBean;
	ClsConnection conobj=new ClsConnection();
	private String date;
	private String hiddate;
	private String refno;
	private String brchName;

	private String txtlegalamt;
	private String txtseramt;
	private String txtexptotal;
	private String txtnettotal;

	private String clacno;
	private int costid;
	private int maintrno;
	private String searchtrno;
	private int docno;
	private String pdid;
	private int invgridlength;
	private int expgridlength;
	private String cmbcontracttype;
	private String ptype;


	private String desc;
	private String txtnotes;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;

	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname1;
	private String lblbranch;
	private String lbllocation;
	private String amountwords;
	private String lblcheckedby;
	private String lblfinaldate;
	private String txtheader;
	private String url;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private String txtjobrefno; 
    private String contypeval;
	private int masterdoc_no;

	private int clientid;
	private int cpersonid;

	private String txtclient;
	private String txtclientdet;
	private int txtcontract;

	private ArrayList list;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList termlist;
	private ArrayList paylist;

	private String mxrnomin;
	private String mxrnomax;
	private String total1;
	private String invoived;
	private String balance;
	
	private String cperson;
	
	private String txtrefdetails;
	private String txtdtype;
	
	
	public String getTxtdtype() {
		return txtdtype;
	}
	public void setTxtdtype(String txtdtype) {
		this.txtdtype = txtdtype;
	}
	public String getTxtrefdetails() {
		return txtrefdetails;
	}
	public void setTxtrefdetails(String txtrefdetails) {
		this.txtrefdetails = txtrefdetails;
	}
	public String getCperson() {
		return cperson;
	}
	public void setCperson(String cperson) {
		this.cperson = cperson;
	}
	
	
	public String getMxrnomin() {
		return mxrnomin;
	}
	public void setMxrnomin(String mxrnomin) {
		this.mxrnomin = mxrnomin;
	}
	public String getMxrnomax() {
		return mxrnomax;
	}
	public void setMxrnomax(String mxrnomax) {
		this.mxrnomax = mxrnomax;
	}
	public String getTotal1() {
		return total1;
	}
	public void setTotal1(String total1) {
		this.total1 = total1;
	}
	public String getInvoived() {
		return invoived;
	}
	public void setInvoived(String invoived) {
		this.invoived = invoived;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}

	public String getContypeval() {
		return contypeval;
	}
	public void setContypeval(String contypeval) {
		this.contypeval = contypeval;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public ArrayList getPaylist() {
		return paylist;
	}
	public void setPaylist(ArrayList paylist) {
		this.paylist = paylist;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getTxttel() {
		return txttel;
	}
	public void setTxttel(String txttel) {
		this.txttel = txttel;
	}
	public String getTxtmob() {
		return txtmob;
	}
	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtjobrefno() {
		return txtjobrefno;
	}
	public void setTxtjobrefno(String txtjobrefno) {
		this.txtjobrefno = txtjobrefno;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	public ArrayList getSitelist() {
		return sitelist;
	}
	public void setSitelist(ArrayList sitelist) {
		this.sitelist = sitelist;
	}
	public ArrayList getSerlist() {
		return serlist;
	}
	public void setSerlist(ArrayList serlist) {
		this.serlist = serlist;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getAmountwords() {
		return amountwords;
	}
	public void setAmountwords(String amountwords) {
		this.amountwords = amountwords;
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
	public String getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(String txtheader) {
		this.txtheader = txtheader;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(int txtcontract) {
		this.txtcontract = txtcontract;
	}

	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
	}


	public int getMaintrno() {
		return maintrno;
	}
	public void setMaintrno(int maintrno) {
		this.maintrno = maintrno;
	}
	public String getClacno() {
		return clacno;
	}
	public void setClacno(String clacno) {
		this.clacno = clacno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}



	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}

	public String getTxtlegalamt() {
		return txtlegalamt;
	}
	public void setTxtlegalamt(String txtlegalamt) {
		this.txtlegalamt = txtlegalamt;
	}
	public String getTxtseramt() {
		return txtseramt;
	}
	public void setTxtseramt(String txtseramt) {
		this.txtseramt = txtseramt;
	}
	public String getTxtexptotal() {
		return txtexptotal;
	}
	public void setTxtexptotal(String txtexptotal) {
		this.txtexptotal = txtexptotal;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}
	public int getExpgridlength() {
		return expgridlength;
	}
	public void setExpgridlength(int expgridlength) {
		this.expgridlength = expgridlength;
	}
	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}




	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
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
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}


	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getPdid() {
		return pdid;
	}
	public void setPdid(String pdid) {
		this.pdid = pdid;
	}
	public String getTxtnotes() {
		return txtnotes;
	}
	public void setTxtnotes(String txtnotes) {
		this.txtnotes = txtnotes;
	}
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}


private String fire7site;
	
	public String getFire7site() {
		return fire7site;
	}
	public void setFire7site(String fire7site) {
		this.fire7site = fire7site;
	}
	public String saveInvoiceAction()throws ParseException, SQLException{



		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String searchtrno=getSearchtrno();

		int val=0;
		Double taxamt=0.0,taxtot=0.0;
		String nontax="0";
		ClsProjectInvoiceDAO DAO=new ClsProjectInvoiceDAO();

		if(mode.equals("A")){

			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();

			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);

			}
			for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}
			
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt())+Double.parseDouble(getTxtexptotal());
			
			taxlist=DAO.getTax(session,nettotal,date,"0");
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}


			val=DAO.insert(date,getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),getTxtnettotal(),getPdid(),getTxtnotes(),getPtype(),taxtot,taxlist,nontax);
			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMaintrno(val);
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Not Saved");
				return "fail";


			}

		}

		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();

			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);

			}
			for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}
			
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt())+Double.parseDouble(getTxtexptotal());
			
      taxlist=DAO.getTax(session,nettotal,date,"0");
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}


			val=DAO.edit(getMaintrno(),getDocno(),date,getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),getTxtnettotal(),getPdid(),getTxtnotes(),getPtype(),taxtot,taxlist);



			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Updated Successfully");
				return "success";
			}
			else{

				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Not Updated");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("D")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();
			
			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);

			}
			for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}
			
			taxlist=DAO.getTax(session,Double.parseDouble(getTxtnettotal()),date,"0");
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

//				System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}


			val=DAO.delete(getMaintrno(),getDocno(),date,getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),getTxtnettotal(),getPdid(),getTxtnotes(),getPtype(),taxtot,taxlist);



			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setDeleted("DELETED");
				setMsg("Deleted Successfully");
				return "success";
			}
			else{
				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Not Deleted");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("view")){
			proinvBean=proinvDAO.getViewDetails(session,getMaintrno(),getBrchName());

			setDocno(proinvBean.getDocno());
			setDate(proinvBean.getDate());
			setRefno(proinvBean.getRefno());
			setTxtclient(proinvBean.getTxtclient());
			setTxtclientdet(proinvBean.getTxtclientdet());
			setContypeval(proinvBean.getCmbcontracttype());
			setDesc(proinvBean.getDesc());
			setTxtcontract(proinvBean.getTxtcontract());
			setMaintrno(proinvBean.getMaintrno());
			setClientid(proinvBean.getClientid());
			setClacno(proinvBean.getClacno());
			setCostid(proinvBean.getCostid());
			setPdid(proinvBean.getPdid());
			setTxtnettotal(proinvBean.getTxtnettotal());
			setTxtlegalamt(proinvBean.getTxtlegalamt());
			setTxtseramt(proinvBean.getTxtseramt());
			setTxtexptotal(proinvBean.getTxtexptotal());
			setTxtnotes(proinvBean.getTxtnotes());
			setTxtrefdetails(proinvBean.getTxtrefdetails());

			return "success";
		}

		return "fail";

	}	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsProjectInvoiceBean bean = new ClsProjectInvoiceBean();
		ClsProjectInvoiceDAO DAO= new  ClsProjectInvoiceDAO();
		String dtype=request.getParameter("dtype").toString();
		setUrl(com.getPrintPath(dtype));
	//	System.out.println("==="+com.getPrintPath(dtype));
	
		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header").toString();
		bean=DAO.printMaster(session,docno,brhid,trno,dtype);

		setTxtheader(header);
		setMasterdoc_no(bean.getMasterdoc_no());
		setDocno(bean.getDocno());
		setDate(bean.getDate());
		setHiddate(bean.getDate());
		setClientid(bean.getClientid());
		setTxtclient(bean.getTxtclient());
		setTxtclientdet(bean.getTxtclientdet());
		setTxtmob(bean.getTxtmob());
		setTxtemail(bean.getTxtemail());
		setTxttel(bean.getTxttel());
		setCpersonid(bean.getCpersonid());
		setRefno(bean.getRefno());
		setList(bean.getList());
		setTxtcontract(bean.getDocno());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setAmountwords(bean.getAmountwords());
		setLblcompname(bean.getLblcompname());
		setLblcheckedby(session.getAttribute("USERNAME").toString().trim());
		setLblfinaldate(bean.getLblfinaldate());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setLblcompname(bean.getLblcompname());
		setLblfinaldate(bean.getLblfinaldate());
		setTxtjobrefno(bean.getTxtjobrefno());

		setLblprintname("SALES INVOICE");
		setContypeval(bean.getCmbcontracttype());
		ArrayList sitelist=bean.getSitelist();
		ArrayList serlist=bean.getSerlist();
		ArrayList termlist=bean.getTermlist();
		ArrayList paylList=bean.getPaylist();
		ArrayList list=bean.getList();
//		System.out.println("==sitelist.size====="+sitelist.size());

		setSitelist(sitelist);
		setSerlist(serlist);
		setTermlist(termlist);
		setPaylist(paylList);
		setList(list);

		request.setAttribute("SITELIST", sitelist);
		request.setAttribute("SERLIST", serlist);
		request.setAttribute("TERMLIST", termlist);
		request.setAttribute("PAYLIST", paylList);
		request.setAttribute("LIST", list);
		
		//	jasperHVLPrintAction();
//		System.out.println("getPrintPath(dtype)="+com.getPrintPath(dtype));
		if(com.getPrintPath(dtype).contains(".jrxml")==true)
		{
			 HttpServletResponse response = ServletActionContext.getResponse();
	
			   Connection conn = null;
			 try {
				  
					String id=request.getParameter("id")==null?"0":request.getParameter("id");
				
					 param = new HashMap();
			   
			                conn = conobj.getMyConnection();
			            param.put("printname", "SALES INVOICE");
				          String contractpay="select @id:=@id+1 as srno,a.* from(select  round(amount,2) as amount, "
				          		+ " IF(description IS NULL or description = '', '     ', description) description"
				          		+ " from cm_srvcontrpd  where tr_no="+bean.getConttrno()+") a,(select @id:=0) r";
				          param.put("contractpayment",contractpay);
				      // System.out.println("contractpay===="+contractpay);
				            String annualmaintainquery="select  m.description  as descp,'1' as qty, "
				                  + " round(atotal,2) as unitprice, round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
				                  + "as total from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" "
				                  + "union all select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
				                  + " round(legalchrg,2) as unitprice,round(legalchrg,2) as legalchrg,"
				                  + "(round(atotal,2)+round(legalchrg,2)) as total from my_servm m where m.status=3 "
				                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
				                  + " union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
				                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total from my_servm m where m.status=3 and etotal>0.0000 "
				                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" ";
				            
				            // for fire 7 LLC
				            String itemqry="";
				            if(bean.getTxtdtype().equalsIgnoreCase("SJOB"))
				            {
				             itemqry=itemqry+"UNION ALL select coalesce(equips,'') descp,coalesce(round(qty),'') qty,'' unitprice,'' atotal,(round(atotal,2)+round(legalchrg,2)) total "
				             		+ "from my_servm m left join cm_srvcontrd cd on cd.tr_no=m.costid  where m.tr_no="+trno+" ";
				            }
				            
				            String fire7annualmaintainquery="select  if(m.ref_type='AMC',concat('Annual Maintenance of Fire Protection System - ',description),"
				            		+ "if(m.ref_type='SJOB',concat('Fire Protection System - ',description),description))  as descp,'1' as qty, "
					                  + " round(atotal,2) as unitprice, round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
					                  + "as total from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" "
					                  + "union all select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
					                  + " round(legalchrg,2) as unitprice,round(legalchrg,2) as legalchrg,"
					                  + "(round(atotal,2)+round(legalchrg,2)) as total from my_servm m where m.status=3 "
					                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
					                  + " union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
					                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total from my_servm m where m.status=3 and etotal>0.0000 "
					                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry+" ";
				            
				          param.put("annualmaintainquery",annualmaintainquery);
				          param.put("fire7query",fire7annualmaintainquery);
//			         System.out.println("annualmaintainquery===="+annualmaintainquery);
			         
//			         System.out.println("fire7annualmaintainquery===="+fire7annualmaintainquery);
				          
				        param.put("txtclient", bean.getTxtclient());		         
				         param.put("clientdeta",bean.getTxtclientdet());
				         param.put("txtmob", bean.getTxtmob());
				         param.put("telno", bean.getTelph());
				         param.put("email", bean.getTxtemail());
				         param.put("date", bean.getDate());
				         
				         param.put("invono", docno);
				         param.put("refno", bean.getRefno());
				         param.put("jobrefno", bean.getTxtjobrefno());
				         param.put("cperson", bean.getCperson());
				         param.put("description", bean.getDesc());
				         param.put("notes",bean.getTxtnotes());
//				         System.out.println("===param=="+param);

					 param.put("fire7srno1", bean.getFire7srno());
				         param.put("fire7mxrno1", bean.getFire7mxrno());
				         param.put("fire7total1", bean.getFire7total());
				         param.put("fire7invoice1", bean.getFire7invamt());
				         param.put("fire7balance1", bean.getFire7balance());
				         
				         param.put("srno1", bean.getMxrnomin());
				         param.put("mxrno1", bean.getMxrnomax());
				         param.put("total1", bean.getTotal1());
				         param.put("invoice1", bean.getInvoived());
				         param.put("balance1", bean.getBalance());
				         param.put("printby", session.getAttribute("USERNAME"));
					  //fire7 site
				         param.put("sitedet",bean.getFire7site());
//				         System.out.println("==== "+bean.getTxtnotes());
				         /*param.put("notes",bean.getTxtnotes());*/
				         
				         param.put("dtype",bean.getTxtdtype());
				         param.put("compname",bean.getLblcompname());
				        
				         Double netamt=0.00;
				               
				           int inctax=0,taxamt=0; 
				              Statement stmt = conn.createStatement ();
				        String netamtqry="select m.netamount,cm.inctax,m.taxamt from my_servm m "
				                + "left join cm_srvcontrm cm on m.costid=cm.tr_no where m.tr_no="+trno+"";
				              
				              String taxqry="select @i:=@i+1 srno,a.* from (select 'Pest control charges - Billed'as particular,'' as qty,'' as rate,'' as per, "
				                + " round((m.atotal+m.legalchrg+m.etotal),2) as Amt from my_servm m "
				                + "left join cm_srvcontrm cm on m.costid=cm.tr_no where m.tr_no="+trno+" "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select concat('                          ',tsm.tax_name,' @ ',round(td.per,2),'%')as particular,"
				                + "'' as qty,'' as rate,'' as per,round(td.amount,2) as Amt  from my_servm sm "
				                + "left join my_invtaxdet td on sm.tr_no=td.rdocno "
				                + "left join gl_taxsubmaster tsm on td.taxid=tsm.doc_no where sm.tr_no="+trno+" ) a,(select @i:=0)r";
//				           System.out.println("===taxqry=="+taxqry);
				          // System.out.println("===getTel2=="+bean.getTel2()+"ha");
				          // System.out.println("===getBrch_tel=="+bean.getBrch_tel()+"ha");
				              ResultSet  taxrs1=stmt.executeQuery(netamtqry);
				       while(taxrs1.next()){
				        netamt=taxrs1.getDouble("netamount");
				        taxamt=taxrs1.getInt("taxamt");
				        inctax=taxrs1.getInt("inctax");
				        }
				       if(inctax==0)
				       {
				        netamt=netamt+taxamt;
				       }
				         ClsAmountToWords ClsAmountToWords=new ClsAmountToWords();
				         String amuntwrd=ClsAmountToWords.convertAmountToWords(netamt.toString());
							DecimalFormat df = new DecimalFormat("#.00"); 
							
							param.put("amntword", amuntwrd);
							param.put("netAmount",df.format(netamt)+"");
							param.put("taxqry", taxqry);
							param.put("customer", bean.getTxtclient());		         
							param.put("address",bean.getTxtclientdet());
							param.put("site", bean.getSite());
							param.put("invodate", bean.getDate());
				         	
							param.put("invonohvl",bean.getInvono());
							param.put("tinno", bean.getTinno());
							//param.put("remark", bean.getDesc());
							param.put("remark",bean.getTxtnotes());
							param.put("brch_name", bean.getBrch_name());
							param.put("brch_address", bean.getBrch_address());
							param.put("brch_pbno", bean.getBrch_pbno());
							param.put("brch_tel", bean.getBrch_tel());
							param.put("brch_email", bean.getBrch_email());
							
							
							String rupeeimgpath=request.getSession().getServletContext().getRealPath("/icons/rupee.jpg");
							rupeeimgpath=rupeeimgpath.replace("\\", "\\\\");
						param.put("rupeeimgpath", rupeeimgpath);
			           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(com.getPrintPath(dtype)));
		         	 
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
