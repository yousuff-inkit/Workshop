package com.dashboard.purchases.gisgeneration;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO;


public class ClsGISGenerationAction {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsGoodsissuenoteDAO goodsdao=new ClsGoodsissuenoteDAO();
	ClsGISGenerationDAO gisdao=new ClsGISGenerationDAO();
	private String griddata,pivdocno,mode,msg;
	private String detail;
	private String detailname;
	
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

	public String getGriddata() {
		return griddata;
	}

	public void setGriddata(String griddata) {
		this.griddata = griddata;
	}

	public String getPivdocno() {
		return pivdocno;
	}

	public void setPivdocno(String pivdocno) {
		this.pivdocno = pivdocno;
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

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		if(mode.equalsIgnoreCase("A")){
			System.out.println("Inside Action");
			int value=gisdao.insert(getGriddata(),getPivdocno(),request,session);
			setDetail("Supply Chain");
			setDetailname("GIS Generation");
			if(value>0){
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
