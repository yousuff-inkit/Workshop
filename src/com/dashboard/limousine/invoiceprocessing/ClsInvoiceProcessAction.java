package com.dashboard.limousine.invoiceprocessing;

import java.sql.*;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.limousine.limoinvoice.ClsLimoInvoiceDAO;


public class ClsInvoiceProcessAction {
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
ClsLimoInvoiceDAO objinvoice=new ClsLimoInvoiceDAO();
private String mode;
private String msg;
private int gridlength;
private String cmbbranch;
private String detail;
private String detailname;
private String fromdate;
private String todate;
private String hidclient;
private String hidguest;
private String bookdocno;
private String cmbjobtype;
private String limoinvtype;
private String currentdate;
private String lpono;
private String eventno;

public String getLpono() {
	return lpono;
}
public void setLpono(String lpono) {
	this.lpono = lpono;
}
public String getEventno() {
	return eventno;
}
public void setEventno(String eventno) {
	this.eventno = eventno;
}

public String getCurrentdate() {
	return currentdate;
}
public void setCurrentdate(String currentdate) {
	this.currentdate = currentdate;
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
public String getHidclient() {
	return hidclient;
}
public void setHidclient(String hidclient) {
	this.hidclient = hidclient;
}
public String getHidguest() {
	return hidguest;
}
public void setHidguest(String hidguest) {
	this.hidguest = hidguest;
}
public String getBookdocno() {
	return bookdocno;
}
public void setBookdocno(String bookdocno) {
	this.bookdocno = bookdocno;
}
public String getCmbjobtype() {
	return cmbjobtype;
}
public void setCmbjobtype(String cmbjobtype) {
	this.cmbjobtype = cmbjobtype;
}
public String getLimoinvtype() {
	return limoinvtype;
}
public void setLimoinvtype(String limoinvtype) {
	this.limoinvtype = limoinvtype;
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

public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	try{
		ArrayList<String> processarray=new ArrayList<>();
		for(int i=0;i<getGridlength();i++){
			String temp=requestParams.get("invoice"+i)[0];
			processarray.add(temp);
		}
		java.sql.Date sqlfromdate=null,sqltodate=null,sqldate=null;
		String note="",clientno="";
		if(!getFromdate().equalsIgnoreCase("") && getFromdate()!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
		}
		if(!getTodate().equalsIgnoreCase("") && getTodate()!=null){
			sqltodate=objcommon.changeStringtoSqlDate(getTodate());
		}
		if(!getCurrentdate().equalsIgnoreCase("") && getCurrentdate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getCurrentdate());
		}
		int status=0;
		ArrayList<String> invoicearray2=new ArrayList<>();
		String clientname="";
		if(getLimoinvtype().equalsIgnoreCase("clientwise")){
			for(int i=0;i<processarray.size();i++){
				System.out.println("Rows:"+processarray.get(i));
				if(clientno.equalsIgnoreCase("")){
					clientno=processarray.get(i).split("::")[0];
				}
				if(clientno.equalsIgnoreCase(processarray.get(i).split("::")[0])){
					String temp[]=processarray.get(i).split("::");
					invoicearray2.add(temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+temp[9]+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]);
					System.out.println(temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+temp[9]+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]);
					if(i==processarray.size()-1){
						clientname=objinvoice.getClientName(clientno);
						note=getFromdate()+" to "+getTodate()+" of Client "+clientname;
						System.out.println("Before Insertion");
						int val=objinvoice.insert(sqldate, sqlfromdate, sqltodate, clientno, note, note, invoicearray2, mode, "LIN", request, cmbbranch, session, "2", 0.0,getLpono(),getEventno());
						if(val<=0){
							status=1;
							break;
						}
					}
				}
				
				else{
					clientname=objinvoice.getClientName(clientno);
					note=getFromdate()+" to "+getTodate()+" of Client "+clientname;
					System.out.println("Before Insertion");
					int val=objinvoice.insert(sqldate, sqlfromdate, sqltodate, clientno, note, note, invoicearray2, mode, "LIN", request, cmbbranch, session, "2", 0.0,getLpono(),getEventno());
					if(val<=0){
						status=1;
						break;
					}
					invoicearray2=new ArrayList<>();
					clientno=processarray.get(i).split("::")[0];
					String temp[]=processarray.get(i).split("::");
					invoicearray2.add(temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+temp[9]+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]);
					if(i==processarray.size()-1){
						clientname=objinvoice.getClientName(clientno);
						note=getFromdate()+" to "+getTodate()+" of Client "+clientname;
						System.out.println("Before Insertion");
						int newval=objinvoice.insert(sqldate, sqlfromdate, sqltodate, clientno, note, note, invoicearray2, mode, "LIN", request, cmbbranch, session, "2", 0.0,getLpono(),getEventno());
						if(newval<=0){
							status=1;
							break;
						}
					}
				}	
			
			}
			
		}
		else if(getLimoinvtype().equalsIgnoreCase("jobwise")){
			for(int i=0;i<processarray.size();i++){
				ArrayList<String> invoicearray=new ArrayList<>();
				String temp[]=processarray.get(i).split("::");
				note=getFromdate()+" to "+getTodate()+" for "+temp[5];
				clientno=temp[0];
			/*	//Process Array
				cldocno+"::"+guestno+"::"+jobtype+"::"+jobdocno+"::"+bookdocno+"::"+jobnametemp+"::"+total+"::"+tarif+"::"+nighttarif+"::"+exkmchg+"::"+exhrchg+"::"+nightextrahrchg+"::"+fuelchg+"::"+parkingchg+"::"+otherchg+"::"+greetchg+"::"+vipchg+"::"+boquechg+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0");
				//Invoice Array
				newTextBox.val(rows[i].guestno+"::"+rows[i].jobtype+"::"+rows[i].jobdocno+"::"+rows[i].bookdocno+"::"+rows[i].jobnametemp+"::"+rows[i].total+"::"+rows[i].tarif+"::"+rows[i].nighttarif+"::"+rows[i].excesskmchg+"::"+rows[i].excesshrchg+"::"+rows[i].excessnighthrchg+"::"+rows[i].fuelchg+"::"+rows[i].parkingchg+"::"+rows[i].otherchg+"::"+rows[i].greetchg+"::"+rows[i].vipchg+"::"+rows[i].boquechg+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0");*/
				
				invoicearray.add(temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+temp[9]+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]);
				
				int val=objinvoice.insert(sqldate, sqlfromdate, sqltodate, clientno, note, note, invoicearray, mode, "LIN", request, cmbbranch, session, "2", 0.0,getLpono(),getEventno());
				if(val<=0){
					status=1;
					break;
				}
				
			}
			
		}
		if(status==1){
			setDetail("Limo");
			setDetailname("Invoice Processing");
			setMsg("Not Saved");
			return "fail";
		}
		else{
			setDetail("Limo");
			setDetailname("Invoice Processing");
			setMsg("Saved Successfully");
			return "success";
		}
		
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	return "fail";
	}


}
