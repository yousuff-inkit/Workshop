package com.dashboard.operations.driveragmtprocess;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.debitnote.ClsDebitNoteDAO;

import java.sql.*;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
public class ClsDriverAgmtProcessAction {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsDriverAgmtProcessDAO processdao=new ClsDriverAgmtProcessDAO();
	ClsDebitNoteDAO debitdao=new ClsDebitNoteDAO();
	
	private String agmtno,cmbbranch,uptodate,normalovertime,holidayovertime,totalnormalovertime,totalholidayovertime,totalrate,closedate,msg,mode,detail,detailname,docno,hidclient;

	
	public String getHidclient() {
		
		return hidclient;
	}

	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getAgmtno() {
		return agmtno;
	}

	public void setAgmtno(String agmtno) {
		this.agmtno = agmtno;
	}

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getUptodate() {
		return uptodate;
	}

	public void setUptodate(String uptodate) {
		this.uptodate = uptodate;
	}

	public String getNormalovertime() {
		return normalovertime;
	}

	public void setNormalovertime(String normalovertime) {
		this.normalovertime = normalovertime;
	}

	public String getHolidayovertime() {
		return holidayovertime;
	}

	public void setHolidayovertime(String holidayovertime) {
		this.holidayovertime = holidayovertime;
	}

	public String getTotalnormalovertime() {
		return totalnormalovertime;
	}

	public void setTotalnormalovertime(String totalnormalovertime) {
		this.totalnormalovertime = totalnormalovertime;
	}

	public String getTotalholidayovertime() {
		return totalholidayovertime;
	}

	public void setTotalholidayovertime(String totalholidayovertime) {
		this.totalholidayovertime = totalholidayovertime;
	}

	public String getTotalrate() {
		return totalrate;
	}

	public void setTotalrate(String totalrate) {
		this.totalrate = totalrate;
	}

	public String getClosedate() {
		return closedate;
	}

	public void setClosedate(String closedate) {
		this.closedate = closedate;
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
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		setDetail("Operations");
		setDetailname("Driver Agreement Processing");
		
		java.sql.Date sqluptodate=null;
		java.sql.Date sqlclosedate=null;
		if(!getUptodate().equalsIgnoreCase("") && getUptodate()!=null){
			sqluptodate=objcommon.changeStringtoSqlDate(getUptodate());
		}
		if(mode.equalsIgnoreCase("close")){
			if(!getClosedate().equalsIgnoreCase("") && getClosedate()!=null ){
				sqlclosedate=objcommon.changeStringtoSqlDate(getClosedate());
			}
		}
		java.sql.Date invtodate=processdao.getInvToDate(getDocno());
		ArrayList<String> accarray=new ArrayList<>();
		accarray=processdao.getAccountDetails();
		String txtrefno=processdao.getRefNo();
		double totalrate1=Double.parseDouble((getTotalrate()=="" || getTotalrate()==null?0.0:getTotalrate().toString())+"");
		double totalnormal=Double.parseDouble((getTotalnormalovertime()=="" || getTotalnormalovertime()==null?0.0:getTotalnormalovertime().toString())+"");
		double totalholiday=Double.parseDouble((getTotalholidayovertime()=="" || getTotalholidayovertime()==null?0.0:getTotalholidayovertime().toString())+"");
		double amount=totalrate1+totalnormal+totalholiday;
		String clientacno=processdao.getClientAcno(getHidclient());
		String txtdescription="";
		if(totalrate1!=0.0){
			txtdescription+=" Rate : "+totalrate1;
		}
		if(totalnormal!=0.0){
			txtdescription+=" ,Normal Overtime : "+totalnormal;
		}
		if(totalholiday!=0.0){
			txtdescription+=" ,Holiday Overtime : "+totalholiday;
		}
		/*	var amount,baseamount;
		if(rows[i].dr==true){
			 amount=rows[i].amount1*-1;
			 baseamount=rows[i].baseamount1*-1;
		}
		else if(rows[i].dr==false){
			 amount=rows[i].amount1;
			 baseamount=rows[i].baseamount1;
		}
		
		
	newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
	*/
	
		
		
		if(mode.equalsIgnoreCase("Invoice")){
			
			ArrayList<String> debitnotearray=new ArrayList<>();
			debitnotearray.add(accarray.get(0)+"::"+accarray.get(1)+"::"+accarray.get(2)+"::"+true+"::"+amount*-1+"::"+txtdescription+""+"::"+(amount*Double.parseDouble(accarray.get(2)))*-1+":: "+"0"+":: "+"0");
			
			int val=debitdao.insert(invtodate, "DNO", txtrefno, Double.parseDouble(accarray.get(2)), txtdescription, 
					Integer.parseInt(clientacno), accarray.get(1), amount, amount*Double.parseDouble(accarray.get(2)), "DAG", Integer.parseInt(getDocno()), debitnotearray, session,
					request, "A");
			int trno=Integer.parseInt(request.getAttribute("tranno").toString());
			//System.out.println("-----TRNO-----"+trno);
			if(val>0){
				int updateinvdate=processdao.updateInvDate(trno,sqluptodate,getAgmtno(),getNormalovertime(),getHolidayovertime(),getTotalrate(),getTotalnormalovertime(),getTotalholidayovertime(),getDocno(),mode,sqlclosedate);
				if(updateinvdate>=0){
					setMsg("Processed Successfully - DNO "+val);
					return "success";
					
				}
				else{
					setMsg("Not Invoiced");
					return "fail";
				}
			}
			else{
				setMsg("Not Invoiced");
				return "fail";
			}
		
		}
		
		else if(mode.equalsIgnoreCase("Close")){
			int val=0;
			if(amount>0){
				ArrayList<String> debitnotearray=new ArrayList<>();
				debitnotearray.add(accarray.get(0)+"::"+accarray.get(1)+"::"+accarray.get(2)+"::"+true+"::"+amount*-1+"::"+txtdescription+"::"+(amount*Double.parseDouble(accarray.get(2)))*-1+":: "+"0"+":: "+"0");
				
				val=debitdao.insert(sqlclosedate, "DNO", txtrefno, Double.parseDouble(accarray.get(2)), txtdescription, 
						Integer.parseInt(clientacno), accarray.get(1), amount, amount*Double.parseDouble(accarray.get(2)), "DAG", Integer.parseInt(getDocno()), debitnotearray, session,
						request, "A");
				int trno=Integer.parseInt(request.getAttribute("tranno").toString());
				//System.out.println("-----TRNO-----"+trno);
				if(val>0){
					int updateinvdate=processdao.updateInvDate(trno,sqluptodate,getAgmtno(),getNormalovertime(),getHolidayovertime(),getTotalrate(),getTotalnormalovertime(),getTotalholidayovertime(),getDocno(),mode,sqlclosedate);
					if(updateinvdate>=0){
						
					}
					else{
						setMsg("Not Closed");
						return "fail";
					}

				}
				else{
					return "fail";					
				}
				}
			int closeval=processdao.close(getDocno(),sqlclosedate);
			if(closeval>0){
				if(val>0){
					setMsg("Successfully Closed with DNO "+val);
				}
				else{
					setMsg("Successfully Closed");
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