package com.operations.vehicleprocurement.vehiclepurchasedirect;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClspurchaseDirectAction 

{
	ClsCommon ClsCommon=new ClsCommon();

	ClspurchaseDirectDAO purchaseDirectDAO=new ClspurchaseDirectDAO();
	ClspurchaseDirectBean pintbean= new ClspurchaseDirectBean(); 
	ClspurchaseDirectBean bean;

	
	private String vehpurorderDate,hidvehpurorderDate,vehpurinvDate,hidvehpurinvDate,vehpuraccname,vehdesc,mode,deleted,msg,formdetailcode;
	private int docno,invno,accid,masterdoc_no,headacccode,vehpurchasegridlenght;
	public String getVehpurorderDate() {
		return vehpurorderDate;
	}
	public void setVehpurorderDate(String vehpurorderDate) {
		this.vehpurorderDate = vehpurorderDate;
	}
	public String getHidvehpurorderDate() {
		return hidvehpurorderDate;
	}
	public void setHidvehpurorderDate(String hidvehpurorderDate) {
		this.hidvehpurorderDate = hidvehpurorderDate;
	}
	public String getVehpurinvDate() {
		return vehpurinvDate;
	}
	public void setVehpurinvDate(String vehpurinvDate) {
		this.vehpurinvDate = vehpurinvDate;
	}
	public String getHidvehpurinvDate() {
		return hidvehpurinvDate;
	}
	public void setHidvehpurinvDate(String hidvehpurinvDate) {
		this.hidvehpurinvDate = hidvehpurinvDate;
	}
	public String getVehpuraccname() {
		return vehpuraccname;
	}
	public void setVehpuraccname(String vehpuraccname) {
		this.vehpuraccname = vehpuraccname;
	}
	public String getVehdesc() {
		return vehdesc;
	}
	public void setVehdesc(String vehdesc) {
		this.vehdesc = vehdesc;
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
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getInvno() {
		return invno;
	}
	public void setInvno(int invno) {
		this.invno = invno;
	}
	public int getAccid() {
		return accid;
	}
	public void setAccid(int accid) {
		this.accid = accid;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getHeadacccode() {
		return headacccode;
	}
	public void setHeadacccode(int headacccode) {
		this.headacccode = headacccode;
	}
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getVehpurchasegridlenght() {
		return vehpurchasegridlenght;
	}
	public void setVehpurchasegridlenght(int vehpurchasegridlenght) {
		this.vehpurchasegridlenght = vehpurchasegridlenght;
	}
	
	//--------print--------
	
	private String lbldate,lbltype,lbldesc1,expdeldate,lblvendoeacc,lblvendoeaccName,lbltotal,lblpurchaseDate,lblinvno,amountinwords;
	
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltype() {
		return lbltype;
	}
	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}
	public String getLbldesc1() {
		return lbldesc1;
	}
	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}
	public String getExpdeldate() {
		return expdeldate;
	}
	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
	}
	public String getLblvendoeacc() {
		return lblvendoeacc;
	}
	public void setLblvendoeacc(String lblvendoeacc) {
		this.lblvendoeacc = lblvendoeacc;
	}
	public String getLblvendoeaccName() {
		return lblvendoeaccName;
	}
	public void setLblvendoeaccName(String lblvendoeaccName) {
		this.lblvendoeaccName = lblvendoeaccName;
	}
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
	public String getLblpurchaseDate() {
		return lblpurchaseDate;
	}
	public void setLblpurchaseDate(String lblpurchaseDate) {
		this.lblpurchaseDate = lblpurchaseDate;
	}
	public String getLblinvno() {
		return lblinvno;
	}
	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}
	public String getAmountinwords() {
		return amountinwords;
	}
	public void setAmountinwords(String amountinwords) {
		this.amountinwords = amountinwords;
	}
	public int getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
	}
	public int getFirstarray() {
		return firstarray;
	}
	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}
	public int getRowdatascount() {
		return rowdatascount;
	}
	public void setRowdatascount(int rowdatascount) {
		this.rowdatascount = rowdatascount;
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

	private int lbldoc,firstarray,rowdatascount;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;
	
	
	
	
	
	public String saveAction() throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getVehpurorderDate());
	 
		
		java.sql.Date invDate = ClsCommon.changeStringtoSqlDate(getVehpurinvDate());
		String mode=getMode();
		
		
		if(mode.equalsIgnoreCase("A")){
			
			
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getVehpurchasegridlenght() ;i++){
				String temp2=requestParams.get("vehpurchasetest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
			
				descarray.add(temp2);
			 
			}
			int val=purchaseDirectDAO.insert(sqlStartDate,invDate,getHeadacccode(),getVehdesc(),session,getMode(),getFormdetailcode(),descarray,getInvno(),request);
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				 setHidvehpurorderDate(sqlStartDate.toString());
		 
				setHidvehpurinvDate(invDate.toString());
				setAccid(getAccid());
				setVehpuraccname(getVehpuraccname());
			 
				setHeadacccode(getHeadacccode());
				 
				 
			 
				setVehdesc(getVehdesc());
			
				setDocno(vdocno);
				setMasterdoc_no(val);
			
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMsg("Not Saved");
				setHidvehpurorderDate(sqlStartDate.toString());
				 
				setHidvehpurinvDate(invDate.toString());
				setAccid(getAccid());
				setVehpuraccname(getVehpuraccname());
 
				setHeadacccode(getHeadacccode());
			 
				setVehdesc(getVehdesc());
				setDocno(vdocno);
				setMasterdoc_no(val);
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("view")){
			
			setHidvehpurorderDate(sqlStartDate.toString());
			 
			setHidvehpurinvDate(invDate.toString());
			
		}
		
		


	
	else if(mode.equalsIgnoreCase("D")){
		boolean Status=purchaseDirectDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
	if(Status){
		 setHidvehpurorderDate(sqlStartDate.toString());
			 
			setHidvehpurinvDate(invDate.toString());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			 
			setHeadacccode(getHeadacccode());
 
			setVehdesc(getVehdesc());
			setDocno(getDocno());
		setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
	}
	else{
		
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
 
			setHeadacccode(getHeadacccode());
 
 
			setVehdesc(getVehdesc());
			setDocno(getDocno());
		setMsg("Not Deleted");
		return "fail";

		
	}
	
	
	}
	
	
	
	

	return "fail";
	} // method
	
	
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		
		 pintbean=purchaseDirectDAO.getPrint(doc,request);
		// ArrayList<String> arraylist = ClsvehpurchaseDAO.getPrintdetails(doc);
		 
		
		  //cl details
		 
		 setLblprintname("Vehicle Purchase Direct");
		    setLbldoc(pintbean.getLbldoc());
	    setLbldate(pintbean.getLbldate());
	    setLbldesc1(pintbean.getLbldesc1());
	    
	 
		
		 setLblvendoeacc(pintbean.getLblvendoeacc());
		 setLblvendoeaccName(pintbean.getLblvendoeaccName());
		
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	  setLbltotal(pintbean.getLbltotal());
	  
	  setLblinvno(pintbean.getLblinvno());
	  setLblpurchaseDate(pintbean.getLblpurchaseDate());
	  

	 
		
				
	//	System.out.println("-------"+pintbean.getAmountinwords());
		 
		setAmountinwords(pintbean.getAmountinwords());
		
		
		 return "print";
		 }	
	
	
	
	
} //class
