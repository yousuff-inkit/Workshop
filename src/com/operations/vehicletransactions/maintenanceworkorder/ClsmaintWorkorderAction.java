package com.operations.vehicletransactions.maintenanceworkorder;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;



public class ClsmaintWorkorderAction{
	
	ClsmaintWorkorderDAO maintupdateDAO= new ClsmaintWorkorderDAO(); 
	ClsmaintWorkorderBean pintbean= new ClsmaintWorkorderBean(); 
	ClsCommon commDAO=new ClsCommon(); 
	
	private String maintainceDate,hidmaintainceDate,mtfleetno,mtflname,mtremark,maintype,garagemaster,garrageid,currkm,nextserdue,maintypeval,invDate,hidinvDate,formstatus,invno,postDate,hidpostDate;
	
	private int  docno,maingridlength,servicegridlenght,maintTrno,jvmDovno,masterdoc_no,postvals,selectgridtype,workstatus,apprstatus,postingstatus;
	
	//  private double lbrtotalcost,partstotalcost,totalcost;
	  
	  private double lbrtotalcost,partstotalcost,totalcost;
	
	  private String deleted,mode,msg,formdetailcode;
	  
	//------------------------------------------------------------------  
	  // print 
	  
	  
	  
	  private  String  lblfleetno,lblfleetname,lblservtype,lblcurrkm,lblnextserkm,lbldate,lblgarage,lblnettotallabour,lblnettotalparts,lblnettotalamount;
		private int docvals,firstarray;
		
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblreg_no;	
		
		private  String lblgaaddress,lblphonenos,lblmobilenos,lblcontactpersons;
	  
	//-------------------------------------------------------  
		private  String lblengno,lblchasno,lblpltid;
		
		private String url; 
		private String approvalstatus;
		
		
		public String getApprovalstatus() {
			return approvalstatus;
		}

		public void setApprovalstatus(String approvalstatus) {
			this.approvalstatus = approvalstatus;
		}

		public String getUrl() {
			return url;
		}

		public void setUrl(String url) {
			this.url = url;
		}

		public String getLblengno() {
			return lblengno;
		}

		public void setLblengno(String lblengno) {
			this.lblengno = lblengno;
		}

		public String getLblchasno() {
			return lblchasno;
		}

		public void setLblchasno(String lblchasno) {
			this.lblchasno = lblchasno;
		}

		public String getLblpltid() {
			return lblpltid;
		}

		public void setLblpltid(String lblpltid) {
			this.lblpltid = lblpltid;
		}

		
		public String getLblgaaddress() {
			return lblgaaddress;
		}

		public void setLblgaaddress(String lblgaaddress) {
			this.lblgaaddress = lblgaaddress;
		}

		public String getLblphonenos() {
			return lblphonenos;
		}

		public void setLblphonenos(String lblphonenos) {
			this.lblphonenos = lblphonenos;
		}

		public String getLblmobilenos() {
			return lblmobilenos;
		}

		public void setLblmobilenos(String lblmobilenos) {
			this.lblmobilenos = lblmobilenos;
		}

		public String getLblcontactpersons() {
			return lblcontactpersons;
		}

		public void setLblcontactpersons(String lblcontactpersons) {
			this.lblcontactpersons = lblcontactpersons;
		}
		
		
		public int getWorkstatus() {
			return workstatus;
		}

		

		public void setWorkstatus(int workstatus) {                 
			this.workstatus = workstatus;
		}

		public int getApprstatus() {
			return apprstatus;
		}

		public void setApprstatus(int apprstatus) {
			this.apprstatus = apprstatus;
		}

		public int getPostingstatus() {
			return postingstatus;
		}

		public void setPostingstatus(int postingstatus) {
			this.postingstatus = postingstatus;
		}

		
		
		public int getSelectgridtype() {
			return selectgridtype;
		}

		
		public void setSelectgridtype(int selectgridtype) {
			this.selectgridtype = selectgridtype;
		}

		
		
		
		
		public int getPostvals() {
			return postvals;
		}

	
		public void setPostvals(int postvals) {
			this.postvals = postvals;
		}

		
		public String getInvDate() {
			return invDate;
		}

		
		public void setInvDate(String invDate) {
			this.invDate = invDate;
		}

		public String getHidinvDate() {
			return hidinvDate;
		}

		public void setHidinvDate(String hidinvDate) {
			this.hidinvDate = hidinvDate;
		}

		public String getInvno() {
			return invno;
		}

		public void setInvno(String invno) {
			this.invno = invno;
		}

		
		public String getLblreg_no() {
			return lblreg_no;
		}

		public void setLblreg_no(String lblreg_no) {
			this.lblreg_no = lblreg_no;
		}

		public int getMasterdoc_no() {
			return masterdoc_no;
		}

	

		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}

		
	
	public String getFormstatus() {
			return formstatus;
		}

		public void setFormstatus(String formstatus) {
			this.formstatus = formstatus;
		}

	public int getDocvals() {
		return docvals;
	}

	public String getLblnettotallabour() {
		return lblnettotallabour;
	}

	public void setLblnettotallabour(String lblnettotallabour) {
		this.lblnettotallabour = lblnettotallabour;
	}

	public String getLblnettotalparts() {
		return lblnettotalparts;
	}

	public void setLblnettotalparts(String lblnettotalparts) {
		this.lblnettotalparts = lblnettotalparts;
	}

	public String getLblnettotalamount() {
		return lblnettotalamount;
	}

	public void setLblnettotalamount(String lblnettotalamount) {
		this.lblnettotalamount = lblnettotalamount;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public String getLblgarage() {
		return lblgarage;
	}

	public void setLblgarage(String lblgarage) {
		this.lblgarage = lblgarage;
	}

	public String getLblfleetno() {
		return lblfleetno;
	}

	public void setLblfleetno(String lblfleetno) {
		this.lblfleetno = lblfleetno;
	}

	public String getLblfleetname() {
		return lblfleetname;
	}

	public void setLblfleetname(String lblfleetname) {
		this.lblfleetname = lblfleetname;
	}

	public String getLblservtype() {
		return lblservtype;
	}

	public void setLblservtype(String lblservtype) {
		this.lblservtype = lblservtype;
	}

	public String getLblcurrkm() {
		return lblcurrkm;
	}

	public void setLblcurrkm(String lblcurrkm) {
		this.lblcurrkm = lblcurrkm;
	}

	public String getLblnextserkm() {
		return lblnextserkm;
	}

	public void setLblnextserkm(String lblnextserkm) {
		this.lblnextserkm = lblnextserkm;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
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


	
	public String getMaintainceDate() {
		return maintainceDate;
	}

	public void setMaintainceDate(String maintainceDate) {
		this.maintainceDate = maintainceDate;
	}

	public String getHidmaintainceDate() {
		return hidmaintainceDate;
	}

	public void setHidmaintainceDate(String hidmaintainceDate) {
		this.hidmaintainceDate = hidmaintainceDate;
	}

	public String getMtfleetno() {  //getMtfleetno(),getMtremark(),getMaintype(),getCurrkm(),getNextserdue(),getGarrageid(),getLbrtotalcost(),getPartstotalcost(),getTotalcost()
		return mtfleetno;          //  getMtflname(),getGaragemaster()
	}

	public void setMtfleetno(String mtfleetno) {
		this.mtfleetno = mtfleetno;
	}

	public String getMtflname() {
		return mtflname;
	}

	public void setMtflname(String mtflname) {
		this.mtflname = mtflname;
	}

	public String getMtremark() {
		return mtremark;
	}

	public void setMtremark(String mtremark) {
		this.mtremark = mtremark;
	}

	public String getMaintype() {
		return maintype;
	}

	public void setMaintype(String maintype) {
		this.maintype = maintype;
	}

	
	public String getGaragemaster() {
		return garagemaster;
	}

	public void setGaragemaster(String garagemaster) {
		this.garagemaster = garagemaster;
	}

	public String getGarrageid() {
		return garrageid;
	}

	public void setGarrageid(String garrageid) {
		this.garrageid = garrageid;
	}

	



	public String getCurrkm() {
		return currkm;
	}

	public void setCurrkm(String currkm) {
		this.currkm = currkm;
	}

	public String getNextserdue() {
		return nextserdue;
	}

	public void setNextserdue(String nextserdue) {
		this.nextserdue = nextserdue;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getMaingridlength() {
		return maingridlength;
	}

	public void setMaingridlength(int maingridlength) {
		this.maingridlength = maingridlength;
	}

	public int getServicegridlenght() {
		return servicegridlenght;
	}

	public void setServicegridlenght(int servicegridlenght) {
		this.servicegridlenght = servicegridlenght;
	}
	
	
	public String getMaintypeval() {
		return maintypeval;
	}

	public void setMaintypeval(String maintypeval) {
		this.maintypeval = maintypeval;
	}


	public int getMaintTrno() {
		return maintTrno;
	}

	public void setMaintTrno(int maintTrno) {
		this.maintTrno = maintTrno;
	}


	public int getJvmDovno() {
		return jvmDovno;
	}

	public void setJvmDovno(int jvmDovno) {
		this.jvmDovno = jvmDovno;
	}


	public double getLbrtotalcost() {
		return lbrtotalcost;
	}

	public void setLbrtotalcost(double lbrtotalcost) {
		this.lbrtotalcost = lbrtotalcost;
	}

	public double getPartstotalcost() {
		return partstotalcost;
	}

	public void setPartstotalcost(double partstotalcost) {
		this.partstotalcost = partstotalcost;
	}

	public double getTotalcost() {
		return totalcost;
	}

	public void setTotalcost(double totalcost) {
		this.totalcost = totalcost;
	}


	public String getPostDate() {
		return postDate;
	}

	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}

	public String getHidpostDate() { 
		return hidpostDate;
	}

	public void setHidpostDate(String hidpostDate) {
		this.hidpostDate = hidpostDate;
	}


	java.sql.Date sqlpostDate;
	
	
	java.sql.Date sqlStartDate;
	java.sql.Date sqlInvDate;
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		 sqlStartDate = commDAO.changeStringtoSqlDate(getMaintainceDate());
		// System.out.println("----------"+getInvDate());
			if(!(getInvDate().equalsIgnoreCase("")))
			{
		 //sqlInvDate = ClsCommon.changeStringtoSqlDate(getInvDate());
	}
	
		String mode=getMode();
		
		
/*		getMtfleetno(),getMtremark(),getMaintype(),getCurrkm(),getNextserdue(),getGarrageid(),getLbrtotalcost(),getPartstotalcost(),getTotalcost()
	          getMtflname(),getGaragemaster()*/
	

		
	
if(mode.equalsIgnoreCase("A")){
	ArrayList<String> mainarray= new ArrayList<>();
	for(int i=0;i<getMaingridlength();i++){
		String temp2=requestParams.get("main"+i)[0];
		mainarray.add(temp2);
	}
	
	

	
	int val=maintupdateDAO.insert(sqlStartDate,getMtfleetno(),getMtremark(),session,getMode(),getFormdetailcode(),mainarray,request);
	int vdocno=(int) request.getAttribute("vocno");
	if(val>0){
		setDocno(vdocno);
		setMasterdoc_no(val);
		
		setMtfleetno(getMtfleetno());
		setMtremark(getMtremark());
		setHidmaintainceDate(sqlStartDate.toString());
	    setMtflname(getMtflname());
		
	 
		
		setSelectgridtype(10);
		 
		setMsg("Successfully Saved");
		return "success";
	}
	else{
		setDocno(vdocno);
		setSelectgridtype(11);
		setMasterdoc_no(val);
		setMtfleetno(getMtfleetno());
		setMtremark(getMtremark());
		setHidmaintainceDate(sqlStartDate.toString());
	    setMtflname(getMtflname());
		
		setMsg("Not Saved");
 
		return "fail";
	}
}
else if(mode.equalsIgnoreCase("POS")){
	
	sqlInvDate = commDAO.changeStringtoSqlDate(getInvDate());
	sqlpostDate=commDAO.changeStringtoSqlDate(getPostDate());
	//getPostDate() getHidpostDate()
	
	ArrayList<String> servicearray= new ArrayList<>();
/*	for(int i=0;i<getServicegridlenght();i++){
		String temp2=requestParams.get("service"+i)[0];
		servicearray.add(temp2);
	}*/
	int Status=maintupdateDAO.posting(getMasterdoc_no(),getDocno(),getInvDate(),getGaragemaster(),getInvno(),sqlInvDate,
			sqlStartDate,getMtfleetno(),getMtremark(),getMaintype(),getCurrkm(),getNextserdue(),getGarrageid(),getLbrtotalcost(),
			getPartstotalcost(),getTotalcost(),session,getMode(),getFormdetailcode(),servicearray,request,sqlpostDate);
	if(Status>0){
		
		//setData();
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setInvno(getInvno());
		
		setHidinvDate(sqlInvDate.toString());
		
		setHidpostDate(sqlpostDate.toString());
		
		/*String forchk= (String) request.getAttribute("forchk");*/
		
/*		if(forchk.equalsIgnoreCase("1"))
				{*/
		

		/*int jvmdoc=(int) request.getAttribute("jvmdocno");
		 setJvmDovno(jvmdoc);*/
			/*	}
		else
		{
		setMaintTrno(getMaintTrno());
		setJvmDovno(getJvmDovno());
		}*/
		setMsg("");
		setPostvals(1);
		 
		return "success";
	
	}
	else{
		setMsg("");
		setDocno(getDocno());
		setInvno(getInvno());
		setMasterdoc_no(getMasterdoc_no());
		setHidinvDate(sqlInvDate.toString());
		setHidpostDate(sqlpostDate.toString());
		setPostvals(2);
		//setData();
		return "fail";
	}
}

	else if(mode.equalsIgnoreCase("E")){
		ArrayList<String> mainarray= new ArrayList<>();
		for(int i=0;i<getMaingridlength();i++){
			String temp2=requestParams.get("main"+i)[0];
			mainarray.add(temp2);
		}
		
		boolean Status=maintupdateDAO.edit(getDocno(),getMasterdoc_no(),sqlStartDate,getMtfleetno(),getMtremark(),session,getMode(),getFormdetailcode(),mainarray,getMaintTrno(),getJvmDovno(),request);
		if(Status){
			  //setWorkstatus(0);
			  
			//setData();
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
		
		/*	String forchk= (String) request.getAttribute("forchk");
			
			if(forchk.equalsIgnoreCase("1"))
					{
			
			int trno=(int) request.getAttribute("tranno");
			setMaintTrno(trno);
			int jvmdoc=(int) request.getAttribute("jvmdocno");
			 setJvmDovno(jvmdoc);
					}
			else
			{
			setMaintTrno(getMaintTrno());
			setJvmDovno(getJvmDovno());
			}*/
			
			setMsg("Updated Successfully");
			return "success";
		
		}
		else{
			setMsg("Not Updated");
			//  setWorkstatus(0);
			setDocno(getDocno());
		
			setMasterdoc_no(getMasterdoc_no());
		
			//setData();
			return "fail";
		}
	}
else if(mode.equalsIgnoreCase("D")){
		boolean Status=maintupdateDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),getMaintTrno(),getJvmDovno());
	if(Status){
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setMaintTrno(getMaintTrno());
		setJvmDovno(getJvmDovno());
		//setData();
		setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
	}
	else{
		setMsg("Not Deleted");
		setMaintTrno(getMaintTrno());
		setJvmDovno(getJvmDovno());
		setDocno(getDocno());
		setInvno(getInvno());
		setMasterdoc_no(getMasterdoc_no());
	
		//setData();
		
		return "fail";
	}

}
else if(mode.equalsIgnoreCase("View")){
	System.out.println("Inside View Mode");
	setHidmaintainceDate(sqlStartDate.toString());
	System.out.println(getApprstatus());
	setApprstatus(getApprstatus());
	setApprovalstatus(getApprovalstatus());
	if(!getInvDate().equalsIgnoreCase(""))
	{ 
 
	sqlInvDate = commDAO.changeStringtoSqlDate(getInvDate());
	setHidinvDate(sqlInvDate.toString());
	//System.out.println("--------++"+getPostDate()); 
	}
	 
	if(!getPostDate().equalsIgnoreCase(""))
	{
		 
	sqlpostDate= commDAO.changeStringtoSqlDate(getPostDate());
	setHidpostDate(sqlpostDate.toString());
 
	}
	 
	/*if(!(getInvDate().equalsIgnoreCase("")))
	{
	setHidinvDate(sqlInvDate.toString());
	 setWorkstatus(getWorkstatus());
	  setApprstatus(getApprstatus());  
	  setPostingstatus(getPostingstatus());
	
	
	}*/
	
}

return "fail";	

}

	

/*	public void setData(){
		
	
		
		setHidmaintainceDate(sqlStartDate.toString());
		setHidinvDate(sqlInvDate.toString());
		setInvno(getInvno());
		setMtfleetno(getMtfleetno());
		setMtremark(getMtremark());
		setMaintypeval(getMaintype());
		setCurrkm(getCurrkm());
		setNextserdue(getNextserdue());
		setGarrageid(getGarrageid());
		setLbrtotalcost(getLbrtotalcost());
		setPartstotalcost(getPartstotalcost());
		setTotalcost(getTotalcost());
        setMtflname(getMtflname());
        setGaragemaster(getGaragemaster());
	}*/
	
	
	 public String printAction() throws ParseException, SQLException{
			
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		
	 pintbean=maintupdateDAO.getPrint(doc,request);
		
	   
	 setLblgaaddress(pintbean.getLblgaaddress());
	     setLblphonenos(pintbean.getLblphonenos());
	     setLblmobilenos(pintbean.getLblmobilenos());
	     setLblcontactpersons(pintbean.getLblcontactpersons());
		
	     
	     setLblengno(pintbean.getLblengno());
	     setLblchasno(pintbean.getLblchasno());
	     setLblpltid(pintbean.getLblpltid());
	     
	     
		  //cl details
		 
		 setLblprintname("Maintenance Work Order");
		setLblgarage(pintbean.getLblgarage());
   	  setLblfleetno(pintbean.getLblfleetno());
   	    setLblfleetname(pintbean.getLblfleetname());
   	   setLblservtype(pintbean.getLblservtype());
   	   setLblcurrkm(pintbean.getLblcurrkm());
   	    //upper
   	   setLblnextserkm(pintbean.getLblnextserkm());
   	   setLbldate(pintbean.getLbldate());
   	   setDocvals(pintbean.getDocvals());
   	   
   	   setFirstarray(pintbean.getFirstarray());
   	   
   
   	    
	    setDocvals(pintbean.getDocvals());
		 
	
	    
	    setLblnettotallabour(pintbean.getLblnettotallabour());
	   setLblnettotalparts(pintbean.getLblnettotalparts());
	    setLblnettotalamount(pintbean.getLblnettotalamount());
	    
		
		
		
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	
	    setLblreg_no(pintbean.getLblreg_no());
	    setUrl(commDAO.getPrintPath("MWO"));
  	   
		 return "print";
		 }	
	
	

	
	
}
