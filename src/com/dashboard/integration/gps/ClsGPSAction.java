package com.dashboard.integration.gps;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsGPSAction {
	ClsCommon objcommon=new ClsCommon();
	ClsGPSDAO gpsdao=new ClsGPSDAO();
	
	private String date;
	private String mode;
	private String msg;
	private int gridlength;
	private String detail,detailname;
	private String docno;
	
	
	
	public String getDocno() {
		return docno;
	}


	public void setDocno(String docno) {
		this.docno = docno;
	}


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


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
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


	public int getGridlength() {
		return gridlength;
	}


	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}


	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		ArrayList<String> gpsarray=new ArrayList<>();
		/*java.sql.Date sqldate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}*/
		if(mode.equalsIgnoreCase("A")){
			/*for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("gpsgrid"+i)[0];
				gpsarray.add(temp);
			}*/
			
			boolean status=gpsdao.updateKm(getDocno());
			setDetail("Integration");
			setDetailname("GPS");
			if(status){
				setMsg("Successfully Saved");
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
