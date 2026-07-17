package com.workshop.estimationadditionv3;

import java.sql.Connection;
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

public class ClsEstimationAdditionV3Action extends ActionSupport{
	private String docno,vocno,date,gatedocno,gatevocno,gateuserdetails,gatevehicledetails,sparepartstotal,labourtotal,discount,esttotal,mode,msg,deleted,brchName,formdetailcode,servicestotal,servicesdiscount,netservices,hidchklumsum,lumsumamount;
	private int complaintgridlength,sparePartsNewGridlength,labourcostgridlength;
	ClsCommon objcommon=new ClsCommon();
	ClsConnection connDAO=new ClsConnection();
	
	ClsEstimationAdditionV3DAO estimationdao=new ClsEstimationAdditionV3DAO();
	ClsEstimationAdditionV3Bean been=new ClsEstimationAdditionV3Bean();
	private String jobcardvocno,jobcarddocno,addition,estdocno;
	private String header,notes,internalremarks,chkservicelumsum,hidchkservicelumsum,servicelumsumamt,chkrandomlumsum,hidchkrandomlumsum,randomlumsumamt;
	private String gipinsurcomp,gipclaimno,gipdatetime,estimatedays;
	private String brhid;
	private String cmbserviceadvisor,hidcmbserviceadvisor;
	private String sparetotal,sparediscount,netspare;
	private String hidcmbentitytype,cmbentitytype;
	private String distservicediscount,distsparediscount;
	
	public String getDistservicediscount() {
		return distservicediscount;
	}
	public void setDistservicediscount(String distservicediscount) {
		this.distservicediscount = distservicediscount;
	}
	public String getDistsparediscount() {
		return distsparediscount;
	}
	public void setDistsparediscount(String distsparediscount) {
		this.distsparediscount = distsparediscount;
	}
	public String getHidcmbentitytype() {
		return hidcmbentitytype;
	}
	public void setHidcmbentitytype(String hidcmbentitytype) {
		this.hidcmbentitytype = hidcmbentitytype;
	}
	public String getCmbentitytype() {
		return cmbentitytype;
	}
	public void setCmbentitytype(String cmbentitytype) {
		this.cmbentitytype = cmbentitytype;
	}
	public String getSparetotal() {
		return sparetotal;
	}
	public void setSparetotal(String sparetotal) {
		this.sparetotal = sparetotal;
	}
	public String getSparediscount() {
		return sparediscount;
	}
	public void setSparediscount(String sparediscount) {
		this.sparediscount = sparediscount;
	}
	public String getNetspare() {
		return netspare;
	}
	public void setNetspare(String netspare) {
		this.netspare = netspare;
	}
	public String getCmbserviceadvisor() {
		return cmbserviceadvisor;
	}
	public void setCmbserviceadvisor(String cmbserviceadvisor) {
		this.cmbserviceadvisor = cmbserviceadvisor;
	}
	public String getHidcmbserviceadvisor() {
		return hidcmbserviceadvisor;
	}
	public void setHidcmbserviceadvisor(String hidcmbserviceadvisor) {
		this.hidcmbserviceadvisor = hidcmbserviceadvisor;
	}
	public String getBrhid() {
		return brhid;
	}
	public void setBrhid(String brhid) {
		this.brhid = brhid;
	}
	public String getGipinsurcomp() {
		return gipinsurcomp;
	}
	public void setGipinsurcomp(String gipinsurcomp) {
		this.gipinsurcomp = gipinsurcomp;
	}
	public String getGipclaimno() {
		return gipclaimno;
	}
	public void setGipclaimno(String gipclaimno) {
		this.gipclaimno = gipclaimno;
	}
	public String getGipdatetime() {
		return gipdatetime;
	}
	public void setGipdatetime(String gipdatetime) {
		this.gipdatetime = gipdatetime;
	}
	public String getEstimatedays() {
		return estimatedays;
	}
	public void setEstimatedays(String estimatedays) {
		this.estimatedays = estimatedays;
	}
	public String getHeader() {
		return header;
	}
	public void setHeader(String header) {
		this.header = header;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getInternalremarks() {
		return internalremarks;
	}
	public void setInternalremarks(String internalremarks) {
		this.internalremarks = internalremarks;
	}
	public String getChkservicelumsum() {
		return chkservicelumsum;
	}
	public void setChkservicelumsum(String chkservicelumsum) {
		this.chkservicelumsum = chkservicelumsum;
	}
	public String getHidchkservicelumsum() {
		return hidchkservicelumsum;
	}
	public void setHidchkservicelumsum(String hidchkservicelumsum) {
		this.hidchkservicelumsum = hidchkservicelumsum;
	}
	public String getServicelumsumamt() {
		return servicelumsumamt;
	}
	public void setServicelumsumamt(String servicelumsumamt) {
		this.servicelumsumamt = servicelumsumamt;
	}
	public String getChkrandomlumsum() {
		return chkrandomlumsum;
	}
	public void setChkrandomlumsum(String chkrandomlumsum) {
		this.chkrandomlumsum = chkrandomlumsum;
	}
	public String getHidchkrandomlumsum() {
		return hidchkrandomlumsum;
	}
	public void setHidchkrandomlumsum(String hidchkrandomlumsum) {
		this.hidchkrandomlumsum = hidchkrandomlumsum;
	}
	public String getRandomlumsumamt() {
		return randomlumsumamt;
	}
	public void setRandomlumsumamt(String randomlumsumamt) {
		this.randomlumsumamt = randomlumsumamt;
	}
	public String getJobcardvocno() {
		return jobcardvocno;
	}
	public void setJobcardvocno(String jobcardvocno) {
		this.jobcardvocno = jobcardvocno;
	}
	public String getJobcarddocno() {
		return jobcarddocno;
	}
	public void setJobcarddocno(String jobcarddocno) {
		this.jobcarddocno = jobcarddocno;
	}
	public String getAddition() {
		return addition;
	}
	public void setAddition(String addition) {
		this.addition = addition;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getVocno() {
		return vocno;
	}
	public void setVocno(String vocno) {
		this.vocno = vocno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getGatedocno() {
		return gatedocno;
	}
	public void setGatedocno(String gatedocno) {
		this.gatedocno = gatedocno;
	}
	public String getGatevocno() {
		return gatevocno;
	}
	public void setGatevocno(String gatevocno) {
		this.gatevocno = gatevocno;
	}
	public String getGateuserdetails() {
		return gateuserdetails;
	}
	public void setGateuserdetails(String gateuserdetails) {
		this.gateuserdetails = gateuserdetails;
	}
	public String getGatevehicledetails() {
		return gatevehicledetails;
	}
	public void setGatevehicledetails(String gatevehicledetails) {
		this.gatevehicledetails = gatevehicledetails;
	}
	public String getSparepartstotal() {
		return sparepartstotal;
	}
	public void setSparepartstotal(String sparepartstotal) {
		this.sparepartstotal = sparepartstotal;
	}
	public String getLabourtotal() {
		return labourtotal;
	}
	public void setLabourtotal(String labourtotal) {
		this.labourtotal = labourtotal;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	public String getEsttotal() {
		return esttotal;
	}
	public void setEsttotal(String esttotal) {
		this.esttotal = esttotal;
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
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getServicestotal() {
		return servicestotal;
	}
	public void setServicestotal(String servicestotal) {
		this.servicestotal = servicestotal;
	}
	public String getServicesdiscount() {
		return servicesdiscount;
	}
	public void setServicesdiscount(String servicesdiscount) {
		this.servicesdiscount = servicesdiscount;
	}
	public String getNetservices() {
		return netservices;
	}
	public void setNetservices(String netservices) {
		this.netservices = netservices;
	}
	public String getHidchklumsum() {
		return hidchklumsum;
	}
	public void setHidchklumsum(String hidchklumsum) {
		this.hidchklumsum = hidchklumsum;
	}
	public String getLumsumamount() {
		return lumsumamount;
	}
	public void setLumsumamount(String lumsumamount) {
		this.lumsumamount = lumsumamount;
	}
	public int getComplaintgridlength() {
		return complaintgridlength;
	}
	public void setComplaintgridlength(int complaintgridlength) {
		this.complaintgridlength = complaintgridlength;
	}
	public int getSparePartsNewGridlength() {
		return sparePartsNewGridlength;
	}
	public void setSparePartsNewGridlength(int sparePartsNewGridlength) {
		this.sparePartsNewGridlength = sparePartsNewGridlength;
	}
	public int getLabourcostgridlength() {
		return labourcostgridlength;
	}
	public void setLabourcostgridlength(int labourcostgridlength) {
		this.labourcostgridlength = labourcostgridlength;
	}
	

	public String getEstdocno() {
		return estdocno;
	}
	public void setEstdocno(String estdocno) {
		this.estdocno = estdocno;
	}
	public void setData(String docno,String vocno,java.sql.Date sqldate,String addition){
		setDocno(docno);
		setVocno(vocno);
		setAddition(addition);
		setDate(sqldate.toString());
		setHidcmbentitytype(getCmbentitytype());
		setGateuserdetails(getGateuserdetails());
		setGatevehicledetails(getGatevehicledetails());
		setGatedocno(getGatedocno());
		setGatevocno(getGatevocno());
		setSparepartstotal(getSparepartstotal());
		setLabourtotal(getLabourtotal());
		setDiscount(getDiscount());
		setEsttotal(getEsttotal());
		setServicesdiscount(getServicesdiscount());
		setServicestotal(getServicestotal());
		setNetservices(getNetservices());
		setSparediscount(getSparediscount());
		setSparetotal(getSparetotal());
		setNetspare(getNetspare());
		setHidchklumsum(getHidchklumsum());
		setJobcarddocno(getJobcarddocno());
		setJobcardvocno(getJobcardvocno());
		setGipinsurcomp(getGipinsurcomp());
		setGipclaimno(getGipclaimno());
		setHeader(getHeader());
		setNotes(getNotes());
		setInternalremarks(getInternalremarks());
		setEstimatedays(getEstimatedays());
		setGipdatetime(getGipdatetime());
		setCmbserviceadvisor(getCmbserviceadvisor());
		setHidcmbserviceadvisor(getCmbserviceadvisor());
		if(getLumsumamount()!=null && !getLumsumamount().equalsIgnoreCase("")){
			
			setLumsumamount(getLumsumamount());
			if(Double.parseDouble(getLumsumamount())>0){
				setHidchklumsum("1");
			}
			else{
				setHidchklumsum("0");
			}
		}
		
		
		setHidchkservicelumsum(getHidchkservicelumsum());
		setHidchkrandomlumsum(getHidchkrandomlumsum());
		if(getRandomlumsumamt()!=null && !getRandomlumsumamt().equalsIgnoreCase("")){
			setRandomlumsumamt(getRandomlumsumamt());
		}
		if(getServicelumsumamt()!=null && !getServicelumsumamt().equalsIgnoreCase("")){
			setServicelumsumamt(getServicelumsumamt());
		}
		setDistservicediscount(getDistservicediscount());
		setDistsparediscount(getDistsparediscount());
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		
	    
		if(mode.equalsIgnoreCase("view")){
			String id=request.getParameter("id");
			String modee=request.getParameter("mode");
			String docno=request.getParameter("docno");
			String jcno=request.getParameter("jcno");
			String add=request.getParameter("addition");
	    /*System.out.println("===="+id+"mode--"+modee+"gipno---"+gipnoo+"docnooo"+docno);*/
	    if(id.equalsIgnoreCase("2")){
	    	
	    mode=modee;
	    
		if(mode.equalsIgnoreCase("view")){
	    int doc_no=(Integer.parseInt(docno));
	    int jc_no=(Integer.parseInt(jcno));
	 	been=estimationdao.viewdetails(doc_no,jc_no,add);
	 	setHidcmbentitytype(been.getHidcmbentitytype());
	 		setDate(been.getDate());
	 		setAddition(add);
	 		setEstdocno(been.getEstdocno());
			setDocno(been.getDocno());
			setGatedocno(been.getGatedocno());
			setGatevocno(been.getGatevocno());
			setJobcardvocno(been.getJobcardvocno());
			setJobcarddocno(been.getJobcarddocno());
			setVocno(been.getVocno());
			setGatevocno(been.getGatevocno());
			setGateuserdetails(been.getGateuserdetails());
			setGatevehicledetails(been.getGatevehicledetails());
			setServicesdiscount(been.getServicesdiscount());
			setNetservices(been.getNetservices());
			setSparediscount(been.getSparediscount());
	 		setSparetotal(been.getSparetotal());
	 		setNetspare(been.getNetspare());
			setGipinsurcomp(been.getGipinsurcomp());
			setGipclaimno(been.getGipclaimno());
			setHeader(been.getHeader());
			setNotes(been.getNotes());
			setInternalremarks(been.getInternalremarks());
			setEstimatedays(been.getEstimatedays());
			setGipdatetime(been.getGipdatetime());
			setBrhid(been.getBrhid());
			setHidcmbserviceadvisor(been.getHidcmbserviceadvisor());
			//System.out.println("dsfdnfhd"+been.getNetservices());
			setHidchklumsum(been.getHidchklumsum());
			setLumsumamount(been.getLumsumamount());
			setHidchkservicelumsum(been.getHidchkservicelumsum());
			setServicelumsumamt(been.getServicelumsumamt());
			setHidchkrandomlumsum(been.getHidchkrandomlumsum());
			setRandomlumsumamt(been.getRandomlumsumamt());
			setDistservicediscount(been.getDistservicediscount());
			setDistsparediscount(been.getDistsparediscount());
			return "success";
		}
		
		}
	    }
		
		
		if(!mode.equalsIgnoreCase("view")){
			java.sql.Date sqldate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(getDate());
			}
			ArrayList<String> sparepartsarray=new ArrayList<>();
			ArrayList<String> labourcostarray=new ArrayList<>();
			
			if(getHidchklumsum().equalsIgnoreCase("")){
				setHidchklumsum("0");
			}
			if(mode.equalsIgnoreCase("A")){
				for(int i=0;i<getSparePartsNewGridlength();i++){
					String temp=requestParams.get("sparepartsarray"+i)[0];
					sparepartsarray.add(temp);
				}
				for(int i=0;i<getLabourcostgridlength();i++){
					String temp=requestParams.get("labourcostarray"+i)[0];
					labourcostarray.add(temp);
				}
				int insertval=estimationdao.insert(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
				sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getServicesdiscount(),
				getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount(),
				getJobcarddocno(),getEstdocno(),getHidchkservicelumsum(),getServicelumsumamt(),
				getHidchkrandomlumsum(),getRandomlumsumamt(),getHeader(),getNotes(),getInternalremarks(),
				getGipclaimno(),getGipdatetime(),getEstimatedays(),getCmbserviceadvisor(),getSparetotal(),getSparediscount(),getNetspare(),getCmbentitytype(),getDistservicediscount(),getDistsparediscount());
				if(insertval>0){
					setData(insertval+"",request.getAttribute("WSESTADDVOCNO").toString(),sqldate,request.getAttribute("WSESTADDITION").toString());
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData(insertval+"","",sqldate,"");
					setMsg("Not Saved");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
				for(int i=0;i<getSparePartsNewGridlength();i++){
					String temp=requestParams.get("sparepartsarray"+i)[0];
					sparepartsarray.add(temp);
				}
				for(int i=0;i<getLabourcostgridlength();i++){
					String temp=requestParams.get("labourcostarray"+i)[0];
					labourcostarray.add(temp);
				}
				boolean status=estimationdao.edit(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getDocno(),getVocno(),
						getServicesdiscount(),getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount(),
						getJobcarddocno(),getEstdocno(),getAddition(),getHidchkservicelumsum(),getServicelumsumamt(),
						getHidchkrandomlumsum(),getRandomlumsumamt(),getHeader(),getNotes(),getInternalremarks(),
						getGipclaimno(),getGipdatetime(),getEstimatedays(),getCmbserviceadvisor(),getSparetotal(),getSparediscount(),getNetspare(),getCmbentitytype(),getDistservicediscount(),getDistsparediscount());
				if(status){
					setData(getDocno(),getVocno(),sqldate,getAddition());
					setMsg("Updated Successfully");
					return "success";
				}
				else{
					setData(getDocno(),getVocno(),sqldate,getAddition());
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				boolean status=estimationdao.delete(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getDocno(),getVocno());
				if(status){
					setData(getDocno(),getVocno(),sqldate,getAddition());
					setMsg("Successfully Deleted");
					return "success";
				}
				else{
					setData(getDocno(),getVocno(),sqldate,getAddition());
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		}
		return "fail";
	}
}
