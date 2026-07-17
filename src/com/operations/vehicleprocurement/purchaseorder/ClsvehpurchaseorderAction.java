package com.operations.vehicleprocurement.purchaseorder;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.operations.vehicleprocurement.purchaseorder.ClsvehpurchaseorderDAO;
import com.operations.vehicleprocurement.purchaserequest.ClsvehpurchasereqDAO;

@SuppressWarnings("serial")
public class ClsvehpurchaseorderAction extends HttpServlet {
	ClsCommon ClsCommon=new ClsCommon();


	ClsvehpurchaseorderDAO purchaseorderDAO= new ClsvehpurchaseorderDAO(); 
	ClsvehpurchaseorderBean pintbean = new ClsvehpurchaseorderBean();
	
	private String vehpurorderDate,hidvehpurorderDate,accid,vehpuraccname,headacccode,vehtype,vehrefno,vehpurorderdelDate,hidvehpurorderdelDate,vehdesc;
	
	private int  docno,vehoredergridlenght;
	  private String masterrefno,brchName;
	  private int masterdoc_no;
	private String deleted,mode,msg,formdetailcode,vehtypeval;
    private Double nettotal;



	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}

	
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
	public String getAccid() {
		return accid;
	}
	public void setAccid(String accid) {
		this.accid = accid;
	}
	public String getVehpuraccname() {
		return vehpuraccname;
	}
	public void setVehpuraccname(String vehpuraccname) {
		this.vehpuraccname = vehpuraccname;
	}
	public String getHeadacccode() {
		return headacccode;
	}
	public void setHeadacccode(String headacccode) {
		this.headacccode = headacccode;
	}
	public String getVehtype() {
		return vehtype;
	}
	public void setVehtype(String vehtype) {
		this.vehtype = vehtype;
	}
	public String getVehrefno() {
		return vehrefno;
	}
	public void setVehrefno(String vehrefno) {
		this.vehrefno = vehrefno;
	}
	public String getVehpurorderdelDate() {
		return vehpurorderdelDate;
	}
	public void setVehpurorderdelDate(String vehpurorderdelDate) {
		this.vehpurorderdelDate = vehpurorderdelDate;
	}
	public String getHidvehpurorderdelDate() {
		return hidvehpurorderdelDate;
	}
	public void setHidvehpurorderdelDate(String hidvehpurorderdelDate) {
		this.hidvehpurorderdelDate = hidvehpurorderdelDate;
	}
	public String getVehdesc() {
		return vehdesc;
	}
	public void setVehdesc(String vehdesc) {
		this.vehdesc = vehdesc;
	}
	public Double getNettotal() {
		return nettotal;
	}
	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
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

	public String getVehtypeval() {
		return vehtypeval;
	}
	public void setVehtypeval(String vehtypeval) {
		this.vehtypeval = vehtypeval;
	}
	public int getVehoredergridlenght() {
		return vehoredergridlenght;
	}
	public void setVehoredergridlenght(int vehoredergridlenght) {
		this.vehoredergridlenght = vehoredergridlenght;
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
	

	public String getMasterrefno() {
		return masterrefno;
	}
	public void setMasterrefno(String masterrefno) {
		this.masterrefno = masterrefno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	
	//--------------------------------------------------------print-------------------------------------------------------
	
	private String lbldate,lbltype,lbldesc1,expdeldate,lblvendoeacc,lblvendoeaccName,lbltotal;
	
	private int lbldoc;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;
	
	
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
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
	public int getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
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
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getVehpurorderDate());
		java.sql.Date sqlpurdeldate = ClsCommon.changeStringtoSqlDate(getVehpurorderdelDate() );
		String mode=getMode();



if(mode.equalsIgnoreCase("A")){
	ArrayList<String> descarray= new ArrayList<>();
	for(int i=0;i<getVehoredergridlenght() ;i++){
		String temp2=requestParams.get("vehodrtest"+i)[0];
	// String temp2=request.getAttribute("enqtest"+i).toString();
	
		descarray.add(temp2);
	 
	}
	int val=purchaseorderDAO.insert(sqlStartDate,sqlpurdeldate,getHeadacccode(),getVehtype(),getMasterrefno(),
			getNettotal(),getVehdesc(),session,getMode(),getFormdetailcode(),descarray,request);
	int vdocno=(int) request.getAttribute("vocno");
	if(val>0){
		//System.out.println("---------------"+val);
		 setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		//setCmbreftypeval(getCmbreftype());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		
		setMasterrefno(getMasterrefno());
		setDocno(vdocno);
		setMasterdoc_no(val);
	
		setMsg("Successfully Saved");
		return "success";
	}
	else{
		 setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			//setCmbreftypeval(getCmbreftype());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
			
			setMasterrefno(getMasterrefno());
			setDocno(vdocno);
			setMasterdoc_no(val);
		setMsg("Not Saved");
		return "fail";
	}
}


	else if(mode.equalsIgnoreCase("E")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getVehoredergridlenght();i++){
			String temp2=requestParams.get("vehodrtest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
		
			descarray.add(temp2);
			
		}
		boolean Status=purchaseorderDAO.edit(getMasterdoc_no(),sqlStartDate,sqlpurdeldate,getHeadacccode(),getVehtype(),getMasterrefno(),getNettotal(),getVehdesc(),session,getMode(),getFormdetailcode(),descarray);
		if(Status){
			
			 setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurorderdelDate(sqlpurdeldate.toString());
				//setCmbreftypeval(getCmbreftype());
				setAccid(getAccid());
				setVehpuraccname(getVehpuraccname());
				setVehtypeval(getVehtype());
				setHeadacccode(getHeadacccode());
				setVehrefno(getVehrefno());
				setNettotal(getNettotal());
				setVehdesc(getVehdesc());
				setMasterrefno(getMasterrefno());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				
				
				
		
			setMsg("Updated Successfully");
			return "success";
		
		}
		else{
			 setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurorderdelDate(sqlpurdeldate.toString());
				//setCmbreftypeval(getCmbreftype());
				setAccid(getAccid());
				setVehpuraccname(getVehpuraccname());
				setVehtypeval(getVehtype());
				setHeadacccode(getHeadacccode());
				setVehrefno(getVehrefno());
				setNettotal(getNettotal());
				setVehdesc(getVehdesc());
				setMasterrefno(getMasterrefno());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
			setMsg("Not Updated");
			return "fail";
		}
	}
else if(mode.equalsIgnoreCase("D")){
		boolean Status=purchaseorderDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
	if(Status){
		 setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			//setCmbreftypeval(getCmbreftype());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
			setDocno(getDocno());
			setMasterrefno(getMasterrefno());
			setMasterdoc_no(getMasterdoc_no());
		setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
	}
	else{
		setMsg("Not Deleted");
		return "fail";
	}

}
else if(mode.equalsIgnoreCase("view")){
	    setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
}



return "fail";	

}
	
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		
		 pintbean=purchaseorderDAO.getPrint(doc);
		 ArrayList<String> arraylist = purchaseorderDAO.getPrintdetails(doc);
		 
		
		  //cl details
		 
		 setLblprintname("Vehicle Purchase Order");
		    setLbldoc(pintbean.getLbldoc());
  	    setLbldate(pintbean.getLbldate());
  	    setLbltype(pintbean.getLbltype());
  	    setLbldesc1(pintbean.getLbldesc1());
  	    
  	    setExpdeldate(pintbean.getExpdeldate());
  	    
		request.setAttribute("details",arraylist); 
		
		 setLblvendoeacc(pintbean.getLblvendoeacc());
		 setLblvendoeaccName(pintbean.getLblvendoeaccName());
		
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	  setLbltotal(pintbean.getLbltotal());

	   
		 return "print";
		 }	
	
	
	
	
}
