package com.workshop.packagemaster;

import java.sql.Connection;
import java.sql.Date;
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

public class ClsWSPackageMasterAction extends ActionSupport{

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	private String docno,date,fromdate,todate,description,amount,cmbbrand,cmbmodel,packagename,maxusage,mode,msg,deleted,brchName,formdetailcode,hidcmbbrand,hidcmbmodel;
	private int sparelength,labourlength;
	
	
	public int getSparelength() {
		return sparelength;
	}

	public void setSparelength(int sparelength) {
		this.sparelength = sparelength;
	}

	public int getLabourlength() {
		return labourlength;
	}

	public void setLabourlength(int labourlength) {
		this.labourlength = labourlength;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFromdate() {
		return fromdate;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getTodate() {
		return todate;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getCmbbrand() {
		return cmbbrand;
	}

	public void setCmbbrand(String cmbbrand) {
		this.cmbbrand = cmbbrand;
	}

	public String getCmbmodel() {
		return cmbmodel;
	}

	public void setCmbmodel(String cmbmodel) {
		this.cmbmodel = cmbmodel;
	}

	public String getPackagename() {
		return packagename;
	}

	public void setPackagename(String packagename) {
		this.packagename = packagename;
	}

	public String getMaxusage() {
		return maxusage;
	}

	public void setMaxusage(String maxusage) {
		this.maxusage = maxusage;
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

	public String getHidcmbbrand() {
		return hidcmbbrand;
	}

	public void setHidcmbbrand(String hidcmbbrand) {
		this.hidcmbbrand = hidcmbbrand;
	}

	public String getHidcmbmodel() {
		return hidcmbmodel;
	}

	public void setHidcmbmodel(String hidcmbmodel) {
		this.hidcmbmodel = hidcmbmodel;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date sqldate=null,sqlfromdate=null,sqltodate=null;
		ClsWSPackageMasterAction masteraction=new ClsWSPackageMasterAction();
		ArrayList<String> sparearray=new ArrayList<>();
		ArrayList<String> labourarray=new ArrayList<>();
		ClsWSPackageMasterDAO dao=new ClsWSPackageMasterDAO();
		if(!mode.equalsIgnoreCase("view")){
			if(!getDate().equalsIgnoreCase("") && getDate()!=null){
				sqldate=objcommon.changeStringtoSqlDate(getDate());
			}
			if(!getFromdate().equalsIgnoreCase("") && getFromdate()!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
			}
			if(!getTodate().equalsIgnoreCase("") && getTodate()!=null){
				sqltodate=objcommon.changeStringtoSqlDate(getTodate());
			}

			masteraction.setDocno(getDocno());
			masteraction.setDate(getDate());
			masteraction.setPackagename(getPackagename());
			masteraction.setFromdate(getFromdate());
			masteraction.setTodate(getTodate());
			masteraction.setCmbbrand(getCmbbrand());
			masteraction.setCmbmodel(getCmbmodel());
			masteraction.setAmount(getAmount());
			masteraction.setMaxusage(getMaxusage());
			masteraction.setFormdetailcode(getFormdetailcode());
			masteraction.setBrchName(getBrchName());
			masteraction.setDescription(getDescription());
			
			for(int i=0;i<getSparelength();i++){
				String temp=requestParams.get("sparearray"+i)[0];
				sparearray.add(temp);
			}
			for(int i=0;i<getLabourlength();i++){
				String temp=requestParams.get("labourarray"+i)[0];
				labourarray.add(temp);
			}
		}
			
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			if(mode.equalsIgnoreCase("A")){
				int insertvalue=dao.insert(masteraction,sparearray,labourarray,sqldate,sqlfromdate,sqltodate,session,request,conn);
				setValues(masteraction,insertvalue,sqldate,sqlfromdate,sqltodate);
				if(insertvalue>0){
					setMsg("Successfully Saved");
					conn.commit();
					return "success";
				}
				else{
					setMsg("Not Saved");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
				boolean status=dao.edit(masteraction,sparearray,labourarray,sqldate,sqlfromdate,sqltodate,session,request,conn);
				setValues(masteraction,Integer.parseInt(masteraction.getDocno()),sqldate,sqlfromdate,sqltodate);
				if(status){
					setMsg("Updated Successfully");
					conn.commit();
					return "success";
				}
				else{
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				boolean status=dao.delete(masteraction,sparearray,labourarray,sqldate,sqlfromdate,sqltodate,session,request,conn);
				setValues(masteraction,Integer.parseInt(masteraction.getDocno()),sqldate,sqlfromdate,sqltodate);
				if(status){
					setMsg("Deleted Successfully");
					conn.commit();
					return "success";
				}
				else{
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
			
		return "fail";
	}

	private void setValues(ClsWSPackageMasterAction masteraction,
			int insertvalue, Date sqldate, Date sqlfromdate, Date sqltodate) {
		// TODO Auto-generated method stub
		if(sqldate!=null){
			setDate(sqldate.toString());
		}
		if(sqlfromdate!=null){
			setFromdate(sqlfromdate.toString());
		}
		if(sqltodate!=null){
			setTodate(sqltodate.toString());
		}
		setDocno(insertvalue+"");
		setHidcmbbrand(masteraction.getCmbbrand());
		setHidcmbmodel(masteraction.getCmbmodel());
		setAmount(masteraction.getAmount());
		setMaxusage(masteraction.getMaxusage());
		setDescription(masteraction.getDescription());
	}
}
