package com.operations.marketing.quotation;




import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;
import com.operations.marketing.quotation.ClspdfCreate;

import  sun.misc.BASE64Decoder;
@SuppressWarnings("serial")
public class ClsquotationAction extends ActionSupport{
	ClsquotationDAO QuotationDAO= new ClsquotationDAO(); 

	ClsquotationBean pintbean= new ClsquotationBean(); 
	
	ClsCommon commDAO=new ClsCommon();
    
    private int docno;
    private String jqxQuoteDate;
	private String hidjqxQuoteDate;
	private String cmbreftype;
	private String refno,enqrefno;
	private String cl_dcocno;
	private String client_details;
	private String txt_mobile;
	private String txt_email;
	private String txt_attention;
	private String txt_remarks;
	private String lblsalclient;
	private String lblsalmob;
	private String desc_main;
	private String mode;
	
	private int quotgridlenght;
	private String msg;
	private int tarifgridlength;
	private int descgridlenght;
	private int maingridlength;
	private String reftypeval;
	private String deleted,formdetailcode;
	

	private int masterdoc_no;
	//-------------------------------------------------------
	
	
	
	private String lblclient,lblclientaddress,lblmob,lblemail,lbldate,lbltypep;
	
	public String getLblsalclient() {
		return lblsalclient;
	}

	public void setLblsalclient(String lblsalclient) {
		this.lblsalclient = lblsalclient;
	}

	public String getLblsalmob() {
		return lblsalmob;
	}

	public void setLblsalmob(String lblsalmob) {
		this.lblsalmob = lblsalmob;
	}



	private int docvals,firstarray,secarray;
	private String terms1,generalterms,terms2;
	public String getTerms1() {
		return terms1;
	}

	public void setTerms1(String terms1) {
		this.terms1 = terms1;
	}

	public String getGeneralterms() {
		return generalterms;
	}

	public void setGeneralterms(String generalterms) {
		this.generalterms = generalterms;
	}
	
	

	public String getTerms2() {
		return terms2;
	}

	public void setTerms2(String terms2) {
		this.terms2 = terms2;
	}



	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
	private String fileName;
	private String fielpath;
	
	private String lblcstno,lblservicetax,lblpan;
	 private String url,lbltinno;

		
		
		public String getLbltinno() {
			return lbltinno;
		}
		public void setLbltinno(String lbltinno) {
			this.lbltinno = lbltinno;
		}
;
	
	//------------------------------------------------
	
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
	
	
	public String getFielpath() {
		return fielpath;
	}

	

	public void setFielpath(String fielpath) {
		this.fielpath = fielpath;
	}
	
	public String getFileName() {
		return fileName;
	}



	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	
	public int getDocno() {
		return docno;
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

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
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

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getJqxQuoteDate() {
		return jqxQuoteDate;
	}

	public void setJqxQuoteDate(String jqxQuoteDate) {
		this.jqxQuoteDate = jqxQuoteDate;
	}

	public String getHidjqxQuoteDate() {
		return hidjqxQuoteDate;
	}


	public void setHidjqxQuoteDate(String hidjqxQuoteDate) {
		this.hidjqxQuoteDate = hidjqxQuoteDate;
	}

	public String getCmbreftype() {
		return cmbreftype;
	}
	

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}


	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getCl_dcocno() {
		return cl_dcocno;
	}

	public void setCl_dcocno(String cl_dcocno) {
		this.cl_dcocno = cl_dcocno;
	}


	public String getClient_details() {
		return client_details;
	}

	public void setClient_details(String client_details) {
		this.client_details = client_details;
	}

	public String getTxt_mobile() {
		return txt_mobile;
	}
	
	public void setTxt_mobile(String txt_mobile) {
		this.txt_mobile = txt_mobile;
	}

	public String getTxt_email() {
		return txt_email;
	}


	public void setTxt_email(String txt_email) {
		this.txt_email = txt_email;
	}


	public String getTxt_attention() {
		return txt_attention;
	}

	public void setTxt_attention(String txt_attention) {
		this.txt_attention = txt_attention;
	}

	public String getTxt_remarks() {
		return txt_remarks;
	}

	public void setTxt_remarks(String txt_remarks) {
		this.txt_remarks = txt_remarks;
	}


	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	

	public String getDesc_main() {
		return desc_main;
	}

	public void setDesc_main(String desc_main) {
		this.desc_main = desc_main;
	}

	public int getQuotgridlenght() {
		return quotgridlenght;
	}

	public void setQuotgridlenght(int quotgridlenght) {
		this.quotgridlenght = quotgridlenght;
	}

	public int getTarifgridlength() {
		return tarifgridlength;
	}

	public void setTarifgridlength(int tarifgridlength) {
		this.tarifgridlength = tarifgridlength;
	}
       


	public int getDescgridlenght() {
		return descgridlenght;
	}

	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
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

	public int getMaingridlength() {
		return maingridlength;
	}

	public void setMaingridlength(int maingridlength) {
		this.maingridlength = maingridlength;
	}
	
	

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

	

	public String getEnqrefno() {
		return enqrefno;
	}

	public void setEnqrefno(String enqrefno) {
		this.enqrefno = enqrefno;
	}

	
	
	
	
	
	
	
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String saveAction() throws ParseException, SQLException{
				HttpServletRequest request=ServletActionContext.getRequest();
				
		HttpSession session=request.getSession();
	
		java.sql.Date sqlStartDate = commDAO.changeStringtoSqlDate(getJqxQuoteDate());
		String mode=getMode();
		Map<String, String[]> requestParams = request.getParameterMap();
	
	
		String mobno=getTxt_mobile().trim();
	
		if(mode.equalsIgnoreCase("A")){
		
			 
				ArrayList<String> quotarray= new ArrayList<>();
				for(int i=0;i<getQuotgridlenght();i++){
					String temp2=requestParams.get("quottest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
			
					quotarray.add(temp2);
			 			           }
				ArrayList<String> qtarifarray= new ArrayList<>();
				for(int i=0;i<getTarifgridlength();i++){
					String temp2=requestParams.get("test"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
			
					qtarifarray.add(temp2);
			 			           }
				
				ArrayList<String> descarray= new ArrayList<>();
				for(int i=0;i<getDescgridlenght();i++){
					String temp2=requestParams.get("desctest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
			
					descarray.add(temp2);
			 			           }
	
			int val=QuotationDAO.insert(sqlStartDate,getCl_dcocno(),mobno,getTxt_remarks(),getTxt_email(),getTxt_attention(),session,getMode(),getEnqrefno(),getCmbreftype(),quotarray,qtarifarray,getDesc_main(),descarray,getFormdetailcode(),request);
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				
				setHidjqxQuoteDate(sqlStartDate.toString());
				setCl_dcocno(getCl_dcocno());
				setClient_details(getClient_details());
				setRefno(getRefno());
				setEnqrefno(getEnqrefno());
				setTxt_mobile(getTxt_mobile());
				setTxt_email(getTxt_email());
				setTxt_attention(getTxt_attention());
				setTxt_remarks(getTxt_remarks());
				setDesc_main(getDesc_main());
				setReftypeval(getReftypeval());
				setDocno(vdocno);
				setMasterdoc_no(val);
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				//setHidjqxQuoteDate(sqlStartDate.toString());
				setHidjqxQuoteDate(sqlStartDate.toString());
				setCl_dcocno(getCl_dcocno());
				setClient_details(getClient_details());
				setRefno(getRefno());
				setEnqrefno(getEnqrefno());
				setTxt_mobile(getTxt_mobile());
				setTxt_email(getTxt_email());
				setTxt_attention(getTxt_attention());
				setTxt_remarks(getTxt_remarks());
				setDesc_main(getDesc_main());
				setReftypeval(getReftypeval());
				setDocno(vdocno);
				setMasterdoc_no(val);
				setMsg("Not Saved");
				return "fail";
			}
		}
		
		
			else if(mode.equalsIgnoreCase("E")){

				ArrayList<String> quotarray= new ArrayList<>();
				for(int i=0;i<getQuotgridlenght();i++){
					String temp2=requestParams.get("quottest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
			
					quotarray.add(temp2);
			 			           }
				ArrayList<String> qtarifarray= new ArrayList<>();
				for(int i=0;i<getTarifgridlength();i++){
					String temp2=requestParams.get("test"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
			
					qtarifarray.add(temp2);
			 			           }
				
				ArrayList<String> descarray= new ArrayList<>();
				for(int i=0;i<getDescgridlenght();i++){
					String temp2=requestParams.get("desctest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
			
					descarray.add(temp2);
			 			           }
				
				boolean Status=QuotationDAO.edit(getMasterdoc_no(),sqlStartDate,getCl_dcocno(),mobno,getTxt_remarks(),getTxt_email(),getTxt_attention(),session,getMode(),getRefno(),getCmbreftype(),quotarray,qtarifarray,getDesc_main(),descarray,getFormdetailcode());
				if(Status){
					
					setHidjqxQuoteDate(sqlStartDate.toString());
					setCl_dcocno(getCl_dcocno());
					setClient_details(getClient_details());
					setRefno(getRefno());
					setEnqrefno(getEnqrefno());
					setTxt_mobile(getTxt_mobile());
					setTxt_email(getTxt_email());
					setTxt_attention(getTxt_attention());
					setTxt_remarks(getTxt_remarks());
					setDesc_main(getDesc_main());
					setReftypeval(getReftypeval());
					setMasterdoc_no(getMasterdoc_no());
					setDocno(getDocno());
					setMsg("Updated Successfully");
					return "success";
				
				}
				else{
					setHidjqxQuoteDate(sqlStartDate.toString());
					setCl_dcocno(getCl_dcocno());
					setClient_details(getClient_details());
					setRefno(getRefno());
					setEnqrefno(getEnqrefno());
					setTxt_mobile(getTxt_mobile());
					setTxt_email(getTxt_email());
					setTxt_attention(getTxt_attention());
					setTxt_remarks(getTxt_remarks());
					setDesc_main(getDesc_main());
					setReftypeval(getReftypeval());
					setMasterdoc_no(getMasterdoc_no());
					setDocno(getDocno());
					setMsg("Not Updated");
					return "fail";
				}
			}
		else if(mode.equalsIgnoreCase("D")){
			
				int Status=QuotationDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),getEnqrefno(),getCmbreftype());
				System.out.println("Status"+Status);
			if(Status>0){
				
		
				setHidjqxQuoteDate(sqlStartDate.toString());
				setMasterdoc_no(getMasterdoc_no());
				setDocno(getDocno());
				setEnqrefno(getEnqrefno());
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
		else if(mode.equalsIgnoreCase("view")){
				setHidjqxQuoteDate(sqlStartDate.toString());
			}
			
	return "fail";	
		
	}
	
	ClsquotationDAO viewDAO= new ClsquotationDAO();
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 // HttpServletResponse response=ServletActionContext.getResponse();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		  String ckhval=request.getParameter("ckhval")==null?"NA":request.getParameter("ckhval");
		
		 pintbean=viewDAO.getPrint(doc,request);
	
		 
		
		  //cl details
		 
       setLblsalclient(pintbean.getLblsalclient());
       setLblsalmob(pintbean.getLblsalmob());
	    setLblclient(pintbean.getLblclient());
	    setLblclientaddress(pintbean.getLblclientaddress());
	    setLblmob(pintbean.getLblmob());
	    setLblemail(pintbean.getLblemail());
	    //upper
	    setLbldate(pintbean.getLbldate());
	    setLbltypep(pintbean.getLbltypep());
	    setDocvals(pintbean.getDocvals());
		 
	/*	request.setAttribute("details",arraylist); */
		
		
	    setLblprintname("Quotation");
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	

	   setFirstarray(pintbean.getFirstarray());
	   setSecarray(pintbean.getSecarray());
	   

	   setGeneralterms(pintbean.getGeneralterms());
	   setTerms1(pintbean.getTerms1());
	   setTerms2(pintbean.getTerms2());
	   
	 //  bean.setGeneralterms(pintrs.getString("glterms"));
	   
	  // bean.setTerms1("General Terms And Conditions" );
	   
 	   if(ckhval.equalsIgnoreCase("test"))
 	   {
 		   
 	
 		 // Calendar now = Calendar.getInstance();
 		 Calendar now = GregorianCalendar.getInstance();
 		 
 		SimpleDateFormat df = new SimpleDateFormat("HH");
 		String formattedDate = df.format(new Date());
 		//System.out.println(formattedDate);
 		 
 		 String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

 		 
 		 //System.out.println("currdate"+currdate);
  		 fileName = "QOT"+"["+request.getParameter("docno")+"]"+currdate+".pdf";

  	

  		
 	/*String path= System.getProperty("user.home")+File.separator+"Downloads";


 		  File f=new File(""+path+"\\"+fileName);
 		  System.out.println("---------"+f);
 		 fielpath=f.toString();
 		
 		 if(f.delete())
 			if(f.delete()){
 				 return SUCCESS; 	
 			}else{
 				
 			}*/
 		 
 		     
 		 return SUCCESS; 
 	   }
 	   else
 	   {
 		  setLblcstno(pintbean.getLblcstno());
 	 	   setLblservicetax(pintbean.getLblservicetax());
 		  setLblpan(pintbean.getLblpan());
 		   setUrl(commDAO.getPrintPath("QOT"));
 		  return "print";   
 	   }
		 
		 }	
	
	/*public String printAction1() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  System.out.println("---------------------"+request.getParameter("ckhval"));
		  System.out.println("---------------------"+request.getParameter("docno"));
		 int doc=Integer.parseInt(request.getParameter("docno"));
		// System.out.println("---------------------");
		
		 pintbean=ClsquotationDAO.getPrint(doc,request);
	
		 
		
		  //cl details
		 

	    setLblclient(pintbean.getLblclient());
	    setLblclientaddress(pintbean.getLblclientaddress());
	    setLblmob(pintbean.getLblmob());
	    setLblemail(pintbean.getLblemail());
	    //upper
	    setLbldate(pintbean.getLbldate());
	    setLbltypep(pintbean.getLbltypep());
	    setDocvals(pintbean.getDocvals());
		 
		request.setAttribute("details",arraylist); 
		
		
	    setLblprintname("Quotation");
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	

	   setFirstarray(pintbean.getFirstarray());
	   setSecarray(pintbean.getSecarray());
	   
	   
		 return SUCCESS;
		 }	
	
	
	
	*/
	
	

	public   String searchTariff(){
		
		String cellarray1 = "";  
		
		
		  try {
			  List <ClsquotationBean> list= viewDAO.list4();
			  for(ClsquotationBean bean:list){
				  		cellarray1+=bean.getRentaltype()+",";
			 
			  

			 }
			  cellarray1=cellarray1.substring(0, cellarray1.length()-1);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray1;
	}
	
	
	public String emailAction() throws ParseException, SQLException, IOException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();
		 HashMap gridmap=new HashMap();
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 String genterms=request.getParameter("genterms")==null?"":request.getParameter("genterms").trim();
		String formcode=request.getParameter("formcode")==null?"NA":request.getParameter("formcode").trim();
		String filename="";
		String recep=request.getParameter("recep").trim();
		 ArrayList gridarray=new ArrayList();
		 ArrayList arraydesc=new ArrayList();
		 
		 pintbean=viewDAO.getPrintPDF(doc,request);
	
		 filename=QuotationDAO.getFileName(formcode);
		 
		 gridmap=QuotationDAO.gridArray(doc, request);
		 
		 arraydesc=QuotationDAO.descArray(doc, request);
		 

	    setLblclient(pintbean.getLblclient());
	    setLblclientaddress(pintbean.getLblclientaddress());
	    setLblmob(pintbean.getLblmob());
	    setLblemail(pintbean.getLblemail());
	    //upper
	    setLbldate(pintbean.getLbldate());
	    setLbltypep(pintbean.getLbltypep());
	    setDocvals(pintbean.getDocvals());
		setLblcstno(pintbean.getLblcstno());
		setLbltinno(pintbean.getLbltinno());
		setLblservicetax(pintbean.getLblservicetax());
	/*	request.setAttribute("details",arraylist); */
		
		
	    setLblprintname("Quotation");
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	

	   setFirstarray(pintbean.getFirstarray());
	   setSecarray(pintbean.getSecarray());
	   
	   
	   System.out.println("==getFirstarray()===="+getFirstarray());
	   System.out.println("==getSecarray()===="+getSecarray());

	   setGeneralterms(pintbean.getGeneralterms());
	   setTerms1(pintbean.getTerms1());
	   setTerms2("Terms And Conditions" );
	   
	   String [] path=filename.split("attachment");
	   String path1=path[0];
	   
	   System.out.println("==getTerms1()===="+getTerms1());
	   
	   System.out.println("==getTerms2()===="+getTerms2());
	     
	try{
		
		ClspdfCreate sim=new ClspdfCreate();
		
		System.out.println("==getTxt_email====="+recep);
		int isindian=QuotationDAO.getCompChk();
		
		
if(isindian==1){
			
	sim.newLocal(getLblclient(),getLblclientaddress(),getLblmob(),getLblemail(),getLblprintname(),
			getLblcompname(),getLblcompaddress(),getLblcomptel(),getLblcompfax(),getLbllocation(),
			getLblbranch(),getLbldate(),getDocvals(),filename,recep,path1,gridmap,getTerms1(),
			getTerms2(),arraydesc,genterms,formcode,getLblcstno(),getLbltinno(),getLblservicetax());

		}
		
		else{
			
			sim.newCommon(getLblclient(),getLblclientaddress(),getLblmob(),getLblemail(),getLblprintname(),
					getLblcompname(),getLblcompaddress(),getLblcomptel(),getLblcompfax(),getLbllocation(),
					getLblbranch(),getLbldate(),getDocvals(),filename,recep,path1,gridmap,getTerms1(),
					getTerms2(),arraydesc,genterms,formcode);
		
					
		}
		
		
		
			//inv.doGet(request,response);
	
		 // Calendar now = Calendar.getInstance();
				     
		 
	}
	catch(Exception e){
		e.printStackTrace();
		return "failed";
	}
	   
	  return "success";
		 
		 }
	
	
}
