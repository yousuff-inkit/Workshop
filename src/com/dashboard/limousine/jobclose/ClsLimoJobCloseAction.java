package com.dashboard.limousine.jobclose;

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

public class ClsLimoJobCloseAction {
	ClsCommon objcommon=new ClsCommon();
	ClsLimoJobCloseDAO closedao=new ClsLimoJobCloseDAO();
	private int gridlength;
	private String mode;
	private String msg;
	private String cmbbranch;
	private String detail;
	private String detailname;
	
	
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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
		System.out.println("//////////////////////////////////////////////////////////Inside");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		try{
			String mode=getMode();
			ArrayList<String> calcarray=new ArrayList<>();
			
			if(mode.equalsIgnoreCase("A")){
				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("testclose"+i)[0];
					calcarray.add(temp);
				}
				int val=closedao.insert(calcarray,mode,cmbbranch,session);
				if(val<=0){
					setMsg("Not Saved");
					setDetail("Limo");
					setDetailname("Job Close");
					return "fail";
				}
				else{
					setMsg("Successfully Saved");
					setDetail("Limo");
					setDetailname("Job Close");
					return "success";
				}
				
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
		}
	return "fail";
}
	
}
