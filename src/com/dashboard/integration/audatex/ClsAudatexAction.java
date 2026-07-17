package com.dashboard.integration.audatex;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.dashboard.integration.audatex.*;

public class ClsAudatexAction {
	ClsCommon objcommon=new ClsCommon();
	ClsAudattexDAO dao=new ClsAudattexDAO();
	
	private String gatedocno;
	private String mode;
	private String msg;
	private int partarraylength;
	private int labourarraylength;
	private String detail,detailname;
	private String docno;
	
	
	
	public String getGatedocno() {
		return gatedocno;
	}


	public void setGatedocno(String gatedocno) {
		this.gatedocno = gatedocno;
	}


	public int getPartarraylength() {
		return partarraylength;
	}


	public void setPartarraylength(int partarraylength) {
		this.partarraylength = partarraylength;
	}


	public int getLabourarraylength() {
		return labourarraylength;
	}


	public void setLabourarraylength(int labourarraylength) {
		this.labourarraylength = labourarraylength;
	}


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
		ArrayList<String> labourarray=new ArrayList<>();
		ArrayList<String> partarray=new ArrayList<>();
		if(mode.equalsIgnoreCase("A")){
			for(int i=0;i<getLabourarraylength();i++){
				String temp=requestParams.get("labourarray"+i)[0];
				labourarray.add(temp);
			}
			for(int i=0;i<getPartarraylength();i++){
				String temp=requestParams.get("partarray"+i)[0];
				partarray.add(temp);
			}
			int estno=dao.createEst(getGatedocno(),labourarray,partarray,session,request);
			setDetail("Integration");
			setDetailname("Audatex");
			if(estno>0){
				setMsg("Est.No "+estno+" Created Successfully");
				return "success";
			}
			else{
				setMsg("Est.No Not Created");
				return "fail";
			}
		}
		return "fail";
	}
}
