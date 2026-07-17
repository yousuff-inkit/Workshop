package com.operations.vehicletransactions.maintenanceupdate;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;




@SuppressWarnings("serial")
public class ClsmaintenanceAction extends HttpServlet {
	
	ClsmaintenanceDAO maintupdateDAO= new ClsmaintenanceDAO(); 
	ClsmaintenanceBean pintbean= new ClsmaintenanceBean(); 
	ClsCommon commDAO=new ClsCommon();
	private String maintainceDate,hidmaintainceDate,mtfleetno,mtflname,mtremark,maintype,garagemaster,garrageid,currkm,nextserdue,maintypeval,invDate,hidinvDate;
			
			private int  docno,maingridlength,servicegridlenght,maintTrno,jvmDovno,masterdoc_no,invno;
			
			//  private double lbrtotalcost,partstotalcost,totalcost;
			  
			  private double lbrtotalcost,partstotalcost,totalcost;
			
			  private String deleted,mode,msg,formdetailcode;
			  
			//------------------------------------------------------------------  
			  // print 
			  
			  
			  
			  private  String  lblfleetno,lblfleetname,lblservtype,lblcurrkm,lblnextserkm,lbldate,lblgarage,lblnettotallabour,lblnettotalparts,lblnettotalamount;
				private int docvals,firstarray;
				
				private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblreg_no;	
				
				
			  
			//-------------------------------------------------------  
	
				
				public String getInvDate() {
					return invDate;
				}

				public void setInvDate(String invDate) {
					this.invDate = invDate;
				}

				public String getHidinvDate() {
					return hidinvDate;
				}

				public void setHidinvDate(String hidinvDate) {
					this.hidinvDate = hidinvDate;
				}

				public int getInvno() {
					return invno;
				}

				public void setInvno(int invno) {
					this.invno = invno;
				}

				
				public String getLblreg_no() {
					return lblreg_no;
				}

				public void setLblreg_no(String lblreg_no) {
					this.lblreg_no = lblreg_no;
				}

				public int getMasterdoc_no() {
					return masterdoc_no;
				}

			

				public void setMasterdoc_no(int masterdoc_no) {
					this.masterdoc_no = masterdoc_no;
				}

				
			
			public int getDocvals() {
				return docvals;
			}

			public String getLblnettotallabour() {
				return lblnettotallabour;
			}

			public void setLblnettotallabour(String lblnettotallabour) {
				this.lblnettotallabour = lblnettotallabour;
			}

			public String getLblnettotalparts() {
				return lblnettotalparts;
			}

			public void setLblnettotalparts(String lblnettotalparts) {
				this.lblnettotalparts = lblnettotalparts;
			}

			public String getLblnettotalamount() {
				return lblnettotalamount;
			}

			public void setLblnettotalamount(String lblnettotalamount) {
				this.lblnettotalamount = lblnettotalamount;
			}

			public int getFirstarray() {
				return firstarray;
			}

			public void setFirstarray(int firstarray) {
				this.firstarray = firstarray;
			}

			public String getLblgarage() {
				return lblgarage;
			}

			public void setLblgarage(String lblgarage) {
				this.lblgarage = lblgarage;
			}

			public String getLblfleetno() {
				return lblfleetno;
			}

			public void setLblfleetno(String lblfleetno) {
				this.lblfleetno = lblfleetno;
			}

			public String getLblfleetname() {
				return lblfleetname;
			}

			public void setLblfleetname(String lblfleetname) {
				this.lblfleetname = lblfleetname;
			}

			public String getLblservtype() {
				return lblservtype;
			}

			public void setLblservtype(String lblservtype) {
				this.lblservtype = lblservtype;
			}

			public String getLblcurrkm() {
				return lblcurrkm;
			}

			public void setLblcurrkm(String lblcurrkm) {
				this.lblcurrkm = lblcurrkm;
			}

			public String getLblnextserkm() {
				return lblnextserkm;
			}

			public void setLblnextserkm(String lblnextserkm) {
				this.lblnextserkm = lblnextserkm;
			}

			public String getLbldate() {
				return lbldate;
			}

			public void setLbldate(String lbldate) {
				this.lbldate = lbldate;
			}

	
			public void setDocvals(int docvals) {
				this.docvals = docvals;
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

	
			
			public String getMaintainceDate() {
				return maintainceDate;
			}

			public void setMaintainceDate(String maintainceDate) {
				this.maintainceDate = maintainceDate;
			}

			public String getHidmaintainceDate() {
				return hidmaintainceDate;
			}

			public void setHidmaintainceDate(String hidmaintainceDate) {
				this.hidmaintainceDate = hidmaintainceDate;
			}

			public String getMtfleetno() {  //getMtfleetno(),getMtremark(),getMaintype(),getCurrkm(),getNextserdue(),getGarrageid(),getLbrtotalcost(),getPartstotalcost(),getTotalcost()
				return mtfleetno;          //  getMtflname(),getGaragemaster()
			}

			public void setMtfleetno(String mtfleetno) {
				this.mtfleetno = mtfleetno;
			}

			public String getMtflname() {
				return mtflname;
			}

			public void setMtflname(String mtflname) {
				this.mtflname = mtflname;
			}

			public String getMtremark() {
				return mtremark;
			}

			public void setMtremark(String mtremark) {
				this.mtremark = mtremark;
			}

			public String getMaintype() {
				return maintype;
			}

			public void setMaintype(String maintype) {
				this.maintype = maintype;
			}

			
			public String getGaragemaster() {
				return garagemaster;
			}

			public void setGaragemaster(String garagemaster) {
				this.garagemaster = garagemaster;
			}

			public String getGarrageid() {
				return garrageid;
			}

			public void setGarrageid(String garrageid) {
				this.garrageid = garrageid;
			}

			

		

			public String getCurrkm() {
				return currkm;
			}

			public void setCurrkm(String currkm) {
				this.currkm = currkm;
			}

			public String getNextserdue() {
				return nextserdue;
			}

			public void setNextserdue(String nextserdue) {
				this.nextserdue = nextserdue;
			}

			public int getDocno() {
				return docno;
			}

			public void setDocno(int docno) {
				this.docno = docno;
			}

			public String getDeleted() {
				return deleted;
			}

			public void setDeleted(String deleted) {
				this.deleted = deleted;
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
		
			public int getMaingridlength() {
				return maingridlength;
			}

			public void setMaingridlength(int maingridlength) {
				this.maingridlength = maingridlength;
			}

			public int getServicegridlenght() {
				return servicegridlenght;
			}

			public void setServicegridlenght(int servicegridlenght) {
				this.servicegridlenght = servicegridlenght;
			}
			
			
			public String getMaintypeval() {
				return maintypeval;
			}

			public void setMaintypeval(String maintypeval) {
				this.maintypeval = maintypeval;
			}


			public int getMaintTrno() {
				return maintTrno;
			}

			public void setMaintTrno(int maintTrno) {
				this.maintTrno = maintTrno;
			}


			public int getJvmDovno() {
				return jvmDovno;
			}

			public void setJvmDovno(int jvmDovno) {
				this.jvmDovno = jvmDovno;
			}


			public double getLbrtotalcost() {
				return lbrtotalcost;
			}

			public void setLbrtotalcost(double lbrtotalcost) {
				this.lbrtotalcost = lbrtotalcost;
			}

			public double getPartstotalcost() {
				return partstotalcost;
			}

			public void setPartstotalcost(double partstotalcost) {
				this.partstotalcost = partstotalcost;
			}

			public double getTotalcost() {
				return totalcost;
			}

			public void setTotalcost(double totalcost) {
				this.totalcost = totalcost;
			}


			java.sql.Date sqlStartDate;
			java.sql.Date sqlInvDate;
			public String saveAction() throws ParseException, SQLException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				Map<String, String[]> requestParams = request.getParameterMap();
				 sqlStartDate = commDAO.changeStringtoSqlDate(getMaintainceDate());
				// System.out.println("----------"+getInvDate());
					if(!(getInvDate().equalsIgnoreCase("")))
					{
				 sqlInvDate = commDAO.changeStringtoSqlDate(getInvDate());
			}
			
				String mode=getMode();
				
				
		/*		getMtfleetno(),getMtremark(),getMaintype(),getCurrkm(),getNextserdue(),getGarrageid(),getLbrtotalcost(),getPartstotalcost(),getTotalcost()
			          getMtflname(),getGaragemaster()*/
			
		
				
			
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> mainarray= new ArrayList<>();
			for(int i=0;i<getMaingridlength();i++){
				String temp2=requestParams.get("main"+i)[0];
				mainarray.add(temp2);
			}
			ArrayList<String> servicearray= new ArrayList<>();
			for(int i=0;i<getServicegridlenght();i++){
				String temp2=requestParams.get("service"+i)[0];
				servicearray.add(temp2);
			}
			

			
			int val=maintupdateDAO.insert(getInvDate(),getGaragemaster(),getInvno(),sqlInvDate,sqlStartDate,getMtfleetno(),getMtremark(),getMaintype(),getCurrkm(),getNextserdue(),getGarrageid(),getLbrtotalcost(),getPartstotalcost(),getTotalcost(),session,getMode(),getFormdetailcode(),mainarray,servicearray,request);
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				setDocno(vdocno);
				setMasterdoc_no(val);
				
				String forchk= (String) request.getAttribute("forchk");
				
				if(forchk.equalsIgnoreCase("1"))
						{
				
				int trno=(int) request.getAttribute("tranno");
				setMaintTrno(trno);
				int jvmdoc=(int) request.getAttribute("jvmdocno");
				 setJvmDovno(jvmdoc);
						}
				 
				setData();
			//	setDocno(val);
				setInvno(getInvno());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDocno(vdocno);
				setMasterdoc_no(val);
				setInvno(getInvno());
				setMsg("Not Saved");
				setData();
				return "fail";
			}
		}

	   
			else if(mode.equalsIgnoreCase("E")){
				ArrayList<String> mainarray= new ArrayList<>();
				for(int i=0;i<getMaingridlength();i++){
					String temp2=requestParams.get("main"+i)[0];
					mainarray.add(temp2);
				}
				ArrayList<String> servicearray= new ArrayList<>();
				for(int i=0;i<getServicegridlenght();i++){
					String temp2=requestParams.get("service"+i)[0];
					servicearray.add(temp2);
				}
				boolean Status=maintupdateDAO.edit(getDocno(),getInvDate(),getGaragemaster(),getInvno(),sqlInvDate,getMasterdoc_no(),sqlStartDate,getMtfleetno(),getMtremark(),getMaintype(),getCurrkm(),getNextserdue(),getGarrageid(),getLbrtotalcost(),getPartstotalcost(),getTotalcost(),session,getMode(),getFormdetailcode(),mainarray,servicearray,getMaintTrno(),getJvmDovno(),request);
				if(Status){
					
					setData();
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());
				
					String forchk= (String) request.getAttribute("forchk");
					
					if(forchk.equalsIgnoreCase("1"))
							{
					
					int trno=(int) request.getAttribute("tranno");
					setMaintTrno(trno);
					int jvmdoc=(int) request.getAttribute("jvmdocno");
					 setJvmDovno(jvmdoc);
							}
					else
					{
					setMaintTrno(getMaintTrno());
					setJvmDovno(getJvmDovno());
					}
					
					setMsg("Updated Successfully");
					return "success";
				
				}
				else{
					setMsg("Not Updated");
					setDocno(getDocno());
					setInvno(getInvno());
					setMasterdoc_no(getMasterdoc_no());
				
					setData();
					return "fail";
				}
			}
		else if(mode.equalsIgnoreCase("D")){
				boolean Status=maintupdateDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),getMaintTrno(),getJvmDovno());
			if(Status){
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMaintTrno(getMaintTrno());
				setJvmDovno(getJvmDovno());
				setData();
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setMsg("Not Deleted");
				setMaintTrno(getMaintTrno());
				setJvmDovno(getJvmDovno());
				setDocno(getDocno());
				setInvno(getInvno());
				setMasterdoc_no(getMasterdoc_no());
			
				setData();
				
				return "fail";
			}
		
		}
		else if(mode.equalsIgnoreCase("View")){
			setHidmaintainceDate(sqlStartDate.toString());
			if(!(getInvDate().equalsIgnoreCase("")))
			{
			setHidinvDate(sqlInvDate.toString());
			}
			
		}
		
	return "fail";	
		
	}
		
			public void setData(){
				setHidmaintainceDate(sqlStartDate.toString());
				setHidinvDate(sqlInvDate.toString());
				setInvno(getInvno());
				setMtfleetno(getMtfleetno());
				setMtremark(getMtremark());
				setMaintypeval(getMaintype());
				setCurrkm(getCurrkm());
				setNextserdue(getNextserdue());
				setGarrageid(getGarrageid());
				setLbrtotalcost(getLbrtotalcost());
				setPartstotalcost(getPartstotalcost());
				setTotalcost(getTotalcost());
		        setMtflname(getMtflname());
		        setGaragemaster(getGaragemaster());
			}
			
			
			
			 public String printAction() throws ParseException, SQLException{
					
				  HttpServletRequest request=ServletActionContext.getRequest();
				 
				 int doc=Integer.parseInt(request.getParameter("docno"));
				 
				
			 pintbean=maintupdateDAO.getPrint(doc,request);
				
		
				
				  //cl details
				 
				 setLblprintname("Maintenance Update");
				setLblgarage(pintbean.getLblgarage());
		    	  setLblfleetno(pintbean.getLblfleetno());
		    	    setLblfleetname(pintbean.getLblfleetname());
		    	   setLblservtype(pintbean.getLblservtype());
		    	   setLblcurrkm(pintbean.getLblcurrkm());
		    	    //upper
		    	   setLblnextserkm(pintbean.getLblnextserkm());
		    	   setLbldate(pintbean.getLbldate());
		    	   setDocvals(pintbean.getDocvals());
		    	   
		    	   setFirstarray(pintbean.getFirstarray());
		    	   
		    
		    	    
		 	    setDocvals(pintbean.getDocvals());
				 
			
		 	    
			    setLblnettotallabour(pintbean.getLblnettotallabour());
	    	   setLblnettotalparts(pintbean.getLblnettotalparts());
	    	    setLblnettotalamount(pintbean.getLblnettotalamount());
		 	    
				
				
				
		 	  setLblbranch(pintbean.getLblbranch());
			   setLblcompname(pintbean.getLblcompname());
			  
			  setLblcompaddress(pintbean.getLblcompaddress());
			 
			   setLblcomptel(pintbean.getLblcomptel());
			  
			  setLblcompfax(pintbean.getLblcompfax());
			   setLbllocation(pintbean.getLbllocation());
			
	    	    setLblreg_no(pintbean.getLblreg_no());
		   	   
				 return "print";
				 }	
			
			
			
			
}
