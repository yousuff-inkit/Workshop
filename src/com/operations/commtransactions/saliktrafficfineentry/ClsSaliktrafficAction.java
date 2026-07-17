package com.operations.commtransactions.saliktrafficfineentry;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO;

public class ClsSaliktrafficAction  {
	ClsCommon commDAO=new ClsCommon();
	
	ClsSaliktrafficDAO SaliktrafficDAO= new ClsSaliktrafficDAO(); 
	
	  private int traficdocno,salickgridlenght,trafficgridlenght;


	//
	private String deleted,tsDate,entry,hidtsDate,entryval;
	//

	
	public String getDeleted() {
		return deleted;
	}


	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}


	private String msg,mode,formdetailcode;
	
	


	
	public String getEntryval() {
		return entryval;
	}


	public void setEntryval(String entryval) {
		this.entryval = entryval;
	}


	public String getHidtsDate() {
		return hidtsDate;
	}


	public void setHidtsDate(String hidtsDate) {
		this.hidtsDate = hidtsDate;
	}


	public String getFormdetailcode() {
		return formdetailcode;
	}


	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}


	public int getTraficdocno() {
		return traficdocno;
	}


	public void setTraficdocno(int traficdocno) {
		this.traficdocno = traficdocno;
	}

	public String getTsDate() {
		return tsDate;
	}

	public void setTsDate(String tsDate) {
		this.tsDate = tsDate;
	}

	public String getEntry() {
		return entry;
	}

	public void setEntry(String entry) {
		this.entry = entry;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}


	public String getMode() {
		return mode;
	}


	public void setMode(String mode) {
		this.mode = mode;
	}


	public int getSalickgridlenght() {
		return salickgridlenght;
	}


	public void setSalickgridlenght(int salickgridlenght) {
		this.salickgridlenght = salickgridlenght;
	}


	public int getTrafficgridlenght() {
		return trafficgridlenght;
	}


	public void setTrafficgridlenght(int trafficgridlenght) {
		this.trafficgridlenght = trafficgridlenght;
	}


	public String saveAction() throws ParseException, SQLException{
				HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		//System.out.println(mode);

	
	//	System.out.println(mode);
		//System.out.println("---------"+getEntry());
	
		if(mode.equalsIgnoreCase("A")){
			
		
			
			ArrayList<String> salickarray= new ArrayList<>();
			ArrayList<String> traffickarray= new ArrayList<>();
			if(getEntry().equalsIgnoreCase("salik"))
			{
			for(int i=0;i<getSalickgridlenght();i++){
				String temp2=requestParams.get("salicktest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
				salickarray.add(temp2);
			 
			}
			}
			else
			{
			for(int i=0;i<getTrafficgridlenght();i++){
				String temp2=requestParams.get("traffictest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
			
				traffickarray.add(temp2);
			 
			}
			}
			java.sql.Date sqlStartDate = commDAO.changeStringtoSqlDate(getTsDate());
			int val=SaliktrafficDAO.insert(sqlStartDate,getEntry(),salickarray,traffickarray,session,getMode(),getFormdetailcode());
			//System.out.println("================="+val);
			if(val>0){

				setHidtsDate(sqlStartDate.toString());
				setEntryval(getEntry());
				setTraficdocno(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setHidtsDate(sqlStartDate.toString());
				setEntryval(getEntry());
				setMsg("Not Saved");
				return "fail";
			}
		}
     
		else if(mode.equalsIgnoreCase("E")){
					ArrayList<String> salickarray= new ArrayList<>();
			ArrayList<String> traffickarray= new ArrayList<>();
			if(getEntry().equalsIgnoreCase("salik"))
			{
			for(int i=0;i<getSalickgridlenght();i++){
				String temp2=requestParams.get("salicktest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
				salickarray.add(temp2);
			 
			}
			}
			else
			{
			for(int i=0;i<getTrafficgridlenght();i++){
				String temp2=requestParams.get("traffictest"+i)[0];
			// String temp2=request.getAttribute("enqtest"+i).toString();
			
				traffickarray.add(temp2);
			 
			}
			
			}	
			java.sql.Date sqlStartDate = commDAO.changeStringtoSqlDate(getTsDate());
			boolean Status=SaliktrafficDAO.edit(getTraficdocno(),sqlStartDate,getEntry(),salickarray,traffickarray,session,getMode(),getFormdetailcode());
				if(Status){
					
					setHidtsDate(sqlStartDate.toString());
					setEntryval(getEntry());
					setTraficdocno(getTraficdocno());
					setMsg("Updated Successfully");
					return "success";
				
				}
				else{
					setHidtsDate(sqlStartDate.toString());
					setEntryval(getEntry());
					setMsg("Not Updated");
					return "fail";
				}
			}
	else if(mode.equalsIgnoreCase("D")){
		         java.sql.Date sqlStartDate = commDAO.changeStringtoSqlDate(getTsDate());
				boolean Status=SaliktrafficDAO.delete(getTraficdocno(),session,getMode(),getFormdetailcode());
			if(Status){
				setHidtsDate(sqlStartDate.toString());
				setEntryval(getEntry());
				setTraficdocno(getTraficdocno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setHidtsDate(sqlStartDate.toString());
				setEntryval(getEntry());
				setTraficdocno(getTraficdocno());
				setMsg("Not Deleted");
				return "fail";
			}
		
		}
	
		
	return "fail";	
		
	}
	
	
	
	
	
	
	
}
