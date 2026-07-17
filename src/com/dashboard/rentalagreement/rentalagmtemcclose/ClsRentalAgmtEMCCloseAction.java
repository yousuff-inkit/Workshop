package com.dashboard.rentalagreement.rentalagmtemcclose;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsRentalAgmtEMCCloseAction {

	ClsCommon objcommon=new ClsCommon();
	ClsRentalAgmtEMCCloseDAO closedao=new ClsRentalAgmtEMCCloseDAO();
	private String cmbbranch,indate,intime,inkm,cmbinfuel,total,courtesy,amount,discount,netamount,
	salikamt,saliksrvcamt,trafficamt,trafficsrvcamt,agmtno,salikcount,trafficcount,mode,msg,formdetailcode,
	useddays,usedhours,detail,detailname;
	
	
	
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getDetailname() {
		return detailname;
	}
	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}
	public String getUseddays() {
		return useddays;
	}
	public void setUseddays(String useddays) {
		this.useddays = useddays;
	}
	public String getUsedhours() {
		return usedhours;
	}
	public void setUsedhours(String usedhours) {
		this.usedhours = usedhours;
	}
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public String getIntime() {
		return intime;
	}
	public void setIntime(String intime) {
		this.intime = intime;
	}
	public String getInkm() {
		return inkm;
	}
	public void setInkm(String inkm) {
		this.inkm = inkm;
	}
	public String getCmbinfuel() {
		return cmbinfuel;
	}
	public void setCmbinfuel(String cmbinfuel) {
		this.cmbinfuel = cmbinfuel;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getCourtesy() {
		return courtesy;
	}
	public void setCourtesy(String courtesy) {
		this.courtesy = courtesy;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	public String getNetamount() {
		return netamount;
	}
	public void setNetamount(String netamount) {
		this.netamount = netamount;
	}
	public String getSalikamt() {
		return salikamt;
	}
	public void setSalikamt(String salikamt) {
		this.salikamt = salikamt;
	}
	public String getSaliksrvcamt() {
		return saliksrvcamt;
	}
	public void setSaliksrvcamt(String saliksrvcamt) {
		this.saliksrvcamt = saliksrvcamt;
	}
	public String getTrafficamt() {
		return trafficamt;
	}
	public void setTrafficamt(String trafficamt) {
		this.trafficamt = trafficamt;
	}
	public String getTrafficsrvcamt() {
		return trafficsrvcamt;
	}
	public void setTrafficsrvcamt(String trafficsrvcamt) {
		this.trafficsrvcamt = trafficsrvcamt;
	}
	public String getAgmtno() {
		return agmtno;
	}
	public void setAgmtno(String agmtno) {
		this.agmtno = agmtno;
	}
	public String getSalikcount() {
		return salikcount;
	}
	public void setSalikcount(String salikcount) {
		this.salikcount = salikcount;
	}
	public String getTrafficcount() {
		return trafficcount;
	}
	public void setTrafficcount(String trafficcount) {
		this.trafficcount = trafficcount;
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
	
	public String saveAction() throws ParseException, SQLException{
		
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		java.sql.Date sqlindate=null;
		Map<String, String[]> requestParams = request.getParameterMap();
		
		if(mode.equalsIgnoreCase("A")){
			if(!getIndate().equalsIgnoreCase("") && getIndate()!=null){
				sqlindate=objcommon.changeStringtoSqlDate(getIndate());
			}
			int val=closedao.insert(getCmbbranch(),sqlindate,getIntime(),getInkm(),getCmbinfuel(),getTotal(),getCourtesy(),getAmount(),getDiscount(),
					getNetamount(),getSalikamt(),getSaliksrvcamt(),getTrafficamt(),getTrafficsrvcamt(),getSalikcount(),getTrafficcount(),
					session,request,getMode(),getFormdetailcode(),getAgmtno(),getUseddays(),getUsedhours());
			setDetail("Rental Agreement");
			setDetailname("Rental Agreement Close");
			System.out.println("Inv Voucher:"+request.getAttribute("INVVOUCHER").toString());
			if(val>0){
				if(!(request.getAttribute("INVVOUCHER").toString().equalsIgnoreCase(""))){
					setMsg("Inv No "+request.getAttribute("INVVOUCHER").toString()+" Generated Successfully");
				}
				else{
					setMsg("Successfully Saved");
				}
				
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}
		}
		return "fail";
	}
}
