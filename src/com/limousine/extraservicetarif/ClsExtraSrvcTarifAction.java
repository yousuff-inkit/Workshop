package com.limousine.extraservicetarif;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsExtraSrvcTarifAction {
private String date;
private String fromdate;
private String todate;
private String desc;
private String brchName;
private String formdetailcode;
private String mode;
private String msg;
private int docno;
private String deleted;
private int gridlength;


public int getGridlength() {
	return gridlength;
}
public void setGridlength(int gridlength) {
	this.gridlength = gridlength;
}
public String getDeleted() {
	return deleted;
}
public void setDeleted(String deleted) {
	this.deleted = deleted;
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
public String getDesc() {
	return desc;
}
public void setDesc(String desc) {
	this.desc = desc;
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


public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public void setValues(int docno,java.sql.Date sqldate,java.sql.Date sqlfromdate,java.sql.Date sqltodate){
	setDocno(docno);
	setDate(sqldate.toString());
	setFromdate(sqlfromdate.toString());
	setTodate(sqltodate.toString());
	setDesc(getDesc());	
}

public String saveAction() throws SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	String mode=getMode();
	ClsCommon objcommon=new ClsCommon();
	ClsExtraSrvcTarifDAO extradao=new ClsExtraSrvcTarifDAO();
	java.sql.Date sqldate=null,sqlfromdate=null,sqltodate=null;
	if(getDate()!=null && !getDate().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(getDate());
	}
	if(getFromdate()!=null && !getFromdate().equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
	}
	if(getTodate()!=null && !getTodate().equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(getTodate());
	}
	if(mode.equalsIgnoreCase("A")){
		int val=extradao.insert(sqldate,sqlfromdate,sqltodate,getDesc(),getBrchName(),session,getFormdetailcode(),mode);
		if(val>0){
			setValues(val, sqldate,sqlfromdate,sqltodate);
			setMsg("Successfully Saved");
			return "success";
		}
		else{
			setValues(val, sqldate,sqlfromdate,sqltodate);
			setMsg("Not Saved");
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("E")){
		boolean status=extradao.edit(getDocno(),sqldate,sqlfromdate,sqltodate,getDesc(),getBrchName(),session,getFormdetailcode(),mode);
		if(status){
			setValues(getDocno(), sqldate,sqlfromdate,sqltodate);
			setMsg("Updated Successfully");
			return "success";
		}
		else{
			setValues(getDocno(), sqldate,sqlfromdate,sqltodate);
			setMsg("Not Updated");
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){
		boolean status=extradao.delete(getDocno(),sqldate,sqlfromdate,sqltodate,getDesc(),getBrchName(),session,getFormdetailcode(),mode);
		if(status){
			setValues(getDocno(), sqldate,sqlfromdate,sqltodate);
			setMsg("Successfully Deleted");
			setDeleted("DELETED");
			return "success";
		}
		else{
			setValues(getDocno(), sqldate,sqlfromdate,sqltodate);
			setMsg("Not Deleted");
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("tarifinsert")){
		ArrayList<String> gridarray=new ArrayList<>();
		if(getGridlength()>0){
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("grid"+i)[0];
				gridarray.add(temp);
			}
			
		}
		boolean status=extradao.tarifinsert(getDocno(),gridarray);
		if(status){
			setValues(getDocno(), sqldate,sqlfromdate,sqltodate);
			setMsg("Updated Successfully");
			return "success";
		}
		else{
			setValues(getDocno(), sqldate,sqlfromdate,sqltodate);
			setMsg("Not Updated");
			return "fail";
		}
	}
	
	return "fail";
}

}