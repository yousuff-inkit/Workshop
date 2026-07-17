package com.dashboard.marketing.onlinebookinglist;

import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.marketing.booking.ClsbookingDAO;
import com.operations.clientrelations.client.ClsClientDAO;

public class ClsOnlineBookingListAction extends ActionSupport{
	private String onlinebookdocno,mode,msg,fromdate,todate,currentdate,bookfromdate,booktodate,cldocno,renttype,tarifdocno,fleetname,detail,detailname,currenttime,lblclient,lblhidclient;
	ClsCommon objcommon=new ClsCommon();
	ClsOnlineBookingListDAO onlinedao=new ClsOnlineBookingListDAO();
	
	
	public String getLblclient() {
		return lblclient;
	}

	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}

	public String getLblhidclient() {
		return lblhidclient;
	}

	public void setLblhidclient(String lblhidclient) {
		this.lblhidclient = lblhidclient;
	}
	public String getCurrenttime() {
		return currenttime;
	}

	public void setCurrenttime(String currenttime) {
		this.currenttime = currenttime;
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

	public String getFleetname() {
		return fleetname;
	}

	public void setFleetname(String fleetname) {
		this.fleetname = fleetname;
	}

	public String getTarifdocno() {
		return tarifdocno;
	}

	public void setTarifdocno(String tarifdocno) {
		this.tarifdocno = tarifdocno;
	}

	public String getRenttype() {
		return renttype;
	}

	public void setRenttype(String renttype) {
		this.renttype = renttype;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getBookfromdate() {
		return bookfromdate;
	}

	public void setBookfromdate(String bookfromdate) {
		this.bookfromdate = bookfromdate;
	}

	public String getBooktodate() {
		return booktodate;
	}

	public void setBooktodate(String booktodate) {
		this.booktodate = booktodate;
	}

	public String getCurrentdate() {
		return currentdate;
	}

	public void setCurrentdate(String currentdate) {
		this.currentdate = currentdate;
	}

	public String getOnlinebookdocno() {
		return onlinebookdocno;
	}

	public void setOnlinebookdocno(String onlinebookdocno) {
		this.onlinebookdocno = onlinebookdocno;
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
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		java.sql.Date sqldate=null,sqlbookfromdate=null,sqlbooktodate=null;
		if(!getCurrentdate().equalsIgnoreCase("") && getCurrentdate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getCurrentdate());
		}
		if(!getBookfromdate().equalsIgnoreCase("") && getBookfromdate()!=null){
			sqlbookfromdate=objcommon.changeStringtoSqlDate(getBookfromdate());
		}
		if(!getBooktodate().equalsIgnoreCase("") && getBooktodate()!=null){
			sqlbooktodate=objcommon.changeStringtoSqlDate(getBooktodate());
		}
		if(mode.equalsIgnoreCase("A")){
			ClsbookingDAO bookdao=new ClsbookingDAO();
			setDetail("Marketing");
			setDetailname("Online Booking List");
			//Check the client is valid
			int brandid=0,modelid=0,groupid=0,tarifdoc=0;
			boolean clientstatus=onlinedao.checkClientStatus(getLblclient(),getLblhidclient(),getOnlinebookdocno());
			System.out.println("Client Status: "+clientstatus);
			if(clientstatus){
				
			}
			else{
				//Create A New Client
				ClsClientDAO clientDAO= new ClsClientDAO();
				ArrayList<String> clientdetails=new ArrayList<>();
				clientdetails=onlinedao.getClientDetails(getOnlinebookdocno());
				String salutation="",name="",address="",email="",mobile="",nationality="",licno="",licexp="",licplace="",passport="",passportexp="";
				for(int i=0;i<clientdetails.size();i++){
					if(i==0){
						salutation=clientdetails.get(i);
					}
					else if(i==1){
						name=clientdetails.get(i);
					}
					else if(i==2){
						address=clientdetails.get(i);
					}
					else if(i==3){
						email=clientdetails.get(i);
					}
					else if(i==4){
						mobile=clientdetails.get(i);
					}
					else if(i==5){
						nationality=clientdetails.get(i);
					}
					else if(i==6){
						licno=clientdetails.get(i);
					}
					else if(i==7){
						licexp=clientdetails.get(i);
					}
					else if(i==8){
						licplace=clientdetails.get(i);
					}
					else if(i==9){
						passport=clientdetails.get(i);
					}
					else if(i==10){
						passportexp=clientdetails.get(i);
					}
				}
				ArrayList<String> driverarray=new ArrayList<>();
				ArrayList<String> blankarray=new ArrayList<>();
				ArrayList<String> vehiclearray=new ArrayList<>();
				vehiclearray=onlinedao.getVehicleDetails(getOnlinebookdocno());
				brandid=Integer.parseInt(vehiclearray.get(0));
				modelid=Integer.parseInt(vehiclearray.get(1));
				groupid=Integer.parseInt(vehiclearray.get(2));
				tarifdoc=Integer.parseInt(vehiclearray.get(3));
				driverarray.add(name+" :: "+"undefined"+" :: "+nationality+" :: "+mobile+" :: "+passport+" :: "+passportexp+" :: "+licno+" :: "+getCurrentdate()+" :: "+licplace+" :: "+licexp+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+"");
				System.out.println(driverarray.get(0));
				
				int clientval=clientDAO.insert(sqldate,"CRM",name,salutation,session.getAttribute("CURRENCYID").toString(),"1", 
						"1","0","0",0,"",0,"0","","8279","",0,0,0,1,"0.0","0.0","","",address,"",mobile,"","",email,"","","","","","","","", 
						"","","","","","","","","","","","","","","","","","",name,address,mobile,0,nationality,
						"","","",sqldate,"","",sqldate,"",driverarray,blankarray,blankarray,blankarray,session,request);
				if(clientval<=0){
					setMsg("Failed to create Client/Driver");
					return "fail";
				}
				else{
					setCldocno(clientval+"");
				}
			}
			ArrayList<String> tarifarray=new ArrayList<>();
			tarifarray=onlinedao.getTariffArray(getFleetname(),getTarifdocno(),getRenttype(),getOnlinebookdocno());
			ArrayList<String> paymentarray=new ArrayList<>();
			
			/*if(1==1){
				return "fail";
			}*/
			int val=bookdao.insert(sqldate, sqlbookfromdate, sqlbooktodate, "ONL", "", getCldocno(), "", "", "", brandid, modelid, 0, groupid, getRenttype(), getCurrenttime(), getCurrenttime(),
					0, 0, "", "", 0, "", tarifarray, paymentarray, "1", mode, session, "VBR", request, "", "0", tarifdoc, 0, "0", "0", 0, "1", 
					"", "", "");
			/* (Date sqlStartDate, Date vehfromdate, Date vehtodate,
					String cmbreftype, String bookrefno, String bookclientno,
					String bookcontactno, String bookattention, String bookremark,
					int bookbrandid, int bookmodelid, int bookcolorid, int bookgroupid,
					String renttype, String jqxVehicleToTime, String jqxVehicleFromTime,
					int delivery_chkval, int chauffeur_chkval, String dellocation,String guestremark,int salagtid,String email, 
					ArrayList<String> qtarifarray,ArrayList<String> paymentarray,String bookslno,
					String mode, HttpSession session,String formcode,HttpServletRequest request,String clientname,String clacno, int tdocno, int fleetno,
					String delchg, String invex, int advchk, String invtype, String vehloc, String codeno,String refclientdet
			*/
			setDetail("Marketing");
			setDetailname("Online Booking List");
			if(val>0){
				int updateval=onlinedao.updateOnlineDocno(val,getOnlinebookdocno());
				if(updateval>0){
					 setMsg("Successfully Generated");				
					 return "success";					
				}
				else{
					setMsg("Not Generated");
					return "fail";
				}
			}
			else{
				 setMsg("Not Generated");
				 return "fail";
			}
			
/*Date, Date, Date, String, String, String, String, String, String, int, int, int, int, String, String, String, int, int, String, String, int, String,
 *  ArrayList<String>, ArrayList<String>, String, String, HttpSession, String,HttpServletRequest, String, String, int, int, String, String, int, String, 
 *  String, String, String) 
 *  
 *  Date, Date, Date, String, String, String, String, String, String, String, String, String, String, String, Date, Date, String, String, String, String, String, String,
 *   ArrayList<String>, ArrayList<String>, String, String, HttpSession, String, HttpServletRequest, String, int, String, int, int, int, int, int, String, String, String)
		*/
		}
		return "fail";
	}
}
