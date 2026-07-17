package com.operations.agreement.rentalclosesayara;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsRentalCloseSayaraAction {

	ClsRentalCloseSayaraDAO rentalcloseDAO=new ClsRentalCloseSayaraDAO();
	ClsCommon objcommon=new ClsCommon();
	ClsRentalCloseSayaraBean bean;
	private int docno;
	private int voucherno;
	private String agreementno;
	private String vocno;
	private String vehicle;
	private String clientid;
	private String client;
	private String txtaccno;
	private String closedate;
	private String hidclosedate;
	private String chkcollection;
	private String hidchkcollection;
	private String chauffer;
	private String chaufferid;
	private String collectkm;
	private String cmbcollectfuel;
	private String hidcmbcollectfuel;
	private String collectdate;
	private String hidcollectdate;
	private String collecttime;
	private String hidcollecttime;
	private String cmbcheckin;
	private String hidcmbcheckin;
	private String useddays;
	private String usedhours;
	private String inkm;
	private String cmbinfuel;
	private String hidcmbinfuel;
	private String indate;
	private String hidindate;
	private String intime;
	private String hidintime;
	private String cmbrentalagent;
	private String hidcmbrentalagent;
	private String totalkm;
	private String excesskm;
	private String chkconvert;
	private String hidchkconvert;
	private String agmttime;
	private String agmtdate;
	private String agmtkm;
	private String datehidden;
	private String agmtdeliverydate;
	private String msg;
	private String mode;
	private String deleted;
	private String agmtdeliverykm;
	private int gridlength;
	private String infuel;
	private int calcgridlength;
	private String clientacno;
	private String hidfleet;
	private String creditnotesum;
	private String deliverychg;
	private String collectchg;
	private String rentalagent;
	private String hidrentalagent;
	private String checkin;
	private String hidcheckin;
	private String description;
	private String brchName;
	private String closeinvdate;
	private String closecalflag;
	private String cmbagmtbranch;
	private String hidcmbagmtbranch;
	private String errormsg;
	private String cmbcloseloc;
	private String hidcmbcloseloc;
	private String allbranch;



	public String getAllbranch() {
		return allbranch;
	}

	public void setAllbranch(String allbranch) {
		this.allbranch = allbranch;
	}

	public String getCmbcloseloc() {
		return cmbcloseloc;
	}

	public void setCmbcloseloc(String cmbcloseloc) {
		this.cmbcloseloc = cmbcloseloc;
	}

	public String getHidcmbcloseloc() {
		return hidcmbcloseloc;
	}

	public void setHidcmbcloseloc(String hidcmbcloseloc) {
		this.hidcmbcloseloc = hidcmbcloseloc;
	}


	public String getErrormsg() {
		return errormsg;
	}

	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}


	public String getHidcmbagmtbranch() {
		return hidcmbagmtbranch;
	}

	public void setHidcmbagmtbranch(String hidcmbagmtbranch) {
		this.hidcmbagmtbranch = hidcmbagmtbranch;
	}

	public String getCmbagmtbranch() {
		return cmbagmtbranch;
	}

	public void setCmbagmtbranch(String cmbagmtbranch) {
		this.cmbagmtbranch = cmbagmtbranch;
	}

	public String getClosecalflag() {
		return closecalflag;
	}

	public void setClosecalflag(String closecalflag) {
		this.closecalflag = closecalflag;
	}

	public String getCloseinvdate() {
		return closeinvdate;
	}

	public void setCloseinvdate(String closeinvdate) {
		this.closeinvdate = closeinvdate;
	}

	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno){
		this.vocno = vocno;
	}

	public int getVoucherno() {
		return voucherno;
	}

	public void setVoucherno(int voucherno) {
		this.voucherno = voucherno;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRentalagent() {
		return rentalagent;
	}

	public void setRentalagent(String rentalagent) {
		this.rentalagent = rentalagent;
	}

	public String getHidrentalagent() {
		return hidrentalagent;
	}

	public void setHidrentalagent(String hidrentalagent) {
		this.hidrentalagent = hidrentalagent;
	}

	public String getCheckin() {
		return checkin;
	}

	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}

	public String getHidcheckin() {
		return hidcheckin;
	}

	public void setHidcheckin(String hidcheckin) {
		this.hidcheckin = hidcheckin;
	}

	public String getDeliverychg() {
		return deliverychg;
	}

	public void setDeliverychg(String deliverychg) {
		this.deliverychg = deliverychg;
	}

	public String getCollectchg() {
		return collectchg;
	}

	public void setCollectchg(String collectchg) {
		this.collectchg = collectchg;
	}

	public String getCreditnotesum() {
		return creditnotesum;
	}

	public void setCreditnotesum(String creditnotesum) {
		this.creditnotesum = creditnotesum;
	}

	public String getHidfleet() {
		return hidfleet;
	}

	public void setHidfleet(String hidfleet) {
		this.hidfleet = hidfleet;
	}

	public String getClientacno() {
		return clientacno;
	}

	public void setClientacno(String clientacno) {
		this.clientacno = clientacno;
	}

	public int getCalcgridlength() {
		return calcgridlength;
	}

	public void setCalcgridlength(int calcgridlength) {
		this.calcgridlength = calcgridlength;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getAgreementno() {
		return agreementno;
	}

	public void setAgreementno(String agreementno) {
		this.agreementno = agreementno;
	}

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public String getClientid() {
		return clientid;
	}

	public void setClientid(String clientid) {
		this.clientid = clientid;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getTxtaccno() {
		return txtaccno;
	}

	public void setTxtaccno(String txtaccno) {
		this.txtaccno = txtaccno;
	}

	public String getClosedate() {
		return closedate;
	}

	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}

	public String getHidclosedate() {
		return hidclosedate;
	}

	public void setHidclosedate(String hidclosedate) {
		this.hidclosedate = hidclosedate;
	}

	public String getChkcollection() {
		return chkcollection;
	}

	public void setChkcollection(String chkcollection) {
		this.chkcollection = chkcollection;
	}

	public String getHidchkcollection() {
		return hidchkcollection;
	}

	public void setHidchkcollection(String hidchkcollection) {
		this.hidchkcollection = hidchkcollection;
	}

	public String getChauffer() {
		return chauffer;
	}

	public void setChauffer(String chauffer) {
		this.chauffer = chauffer;
	}

	public String getChaufferid() {
		return chaufferid;
	}

	public void setChaufferid(String chaufferid) {
		this.chaufferid = chaufferid;
	}

	public String getCollectkm() {
		return collectkm;
	}

	public void setCollectkm(String collectkm) {
		this.collectkm = collectkm;
	}

	public String getCmbcollectfuel() {
		return cmbcollectfuel;
	}

	public void setCmbcollectfuel(String cmbcollectfuel) {
		this.cmbcollectfuel = cmbcollectfuel;
	}

	public String getHidcmbcollectfuel() {
		return hidcmbcollectfuel;
	}

	public void setHidcmbcollectfuel(String hidcmbcollectfuel) {
		this.hidcmbcollectfuel = hidcmbcollectfuel;
	}

	public String getCollectdate() {
		return collectdate;
	}

	public void setCollectdate(String collectdate) {
		this.collectdate = collectdate;
	}

	public String getHidcollectdate() {
		return hidcollectdate;
	}

	public void setHidcollectdate(String hidcollectdate) {
		this.hidcollectdate = hidcollectdate;
	}

	public String getCollecttime() {
		return collecttime;
	}

	public void setCollecttime(String collecttime) {
		this.collecttime = collecttime;
	}

	public String getHidcollecttime() {
		return hidcollecttime;
	}

	public void setHidcollecttime(String hidcollecttime) {
		this.hidcollecttime = hidcollecttime;
	}

	public String getCmbcheckin() {
		return cmbcheckin;
	}

	public void setCmbcheckin(String cmbcheckin) {
		this.cmbcheckin = cmbcheckin;
	}

	public String getHidcmbcheckin() {
		return hidcmbcheckin;
	}

	public void setHidcmbcheckin(String hidcmbcheckin) {
		this.hidcmbcheckin = hidcmbcheckin;
	}

	public String getUseddays() {
		return useddays;
	}

	public void setUseddays(String useddays) {
		this.useddays = useddays;
	}

	public String getUsedhours() {
		return usedhours;
	}

	public void setUsedhours(String usedhours) {
		this.usedhours = usedhours;
	}

	public String getInkm() {
		return inkm;
	}

	public void setInkm(String inkm) {
		this.inkm = inkm;
	}

	public String getCmbinfuel() {
		return cmbinfuel;
	}

	public void setCmbinfuel(String cmbinfuel) {
		this.cmbinfuel = cmbinfuel;
	}

	public String getHidcmbinfuel() {
		return hidcmbinfuel;
	}

	public void setHidcmbinfuel(String hidcmbinfuel) {
		this.hidcmbinfuel = hidcmbinfuel;
	}

	public String getIndate() {
		return indate;
	}

	public void setIndate(String indate) {
		this.indate = indate;
	}

	public String getHidindate() {
		return hidindate;
	}

	public void setHidindate(String hidindate) {
		this.hidindate = hidindate;
	}

	public String getIntime() {
		return intime;
	}

	public void setIntime(String intime) {
		this.intime = intime;
	}

	public String getHidintime() {
		return hidintime;
	}

	public void setHidintime(String hidintime) {
		this.hidintime = hidintime;
	}

	public String getCmbrentalagent() {
		return cmbrentalagent;
	}

	public void setCmbrentalagent(String cmbrentalagent) {
		this.cmbrentalagent = cmbrentalagent;
	}

	public String getHidcmbrentalagent() {
		return hidcmbrentalagent;
	}

	public void setHidcmbrentalagent(String hidcmbrentalagent) {
		this.hidcmbrentalagent = hidcmbrentalagent;
	}

	public String getTotalkm() {
		return totalkm;
	}

	public void setTotalkm(String totalkm) {
		this.totalkm = totalkm;
	}

	public String getExcesskm() {
		return excesskm;
	}

	public void setExcesskm(String excesskm) {
		this.excesskm = excesskm;
	}

	public String getChkconvert() {
		return chkconvert;
	}

	public void setChkconvert(String chkconvert) {
		this.chkconvert = chkconvert;
	}

	public String getHidchkconvert() {
		return hidchkconvert;
	}

	public void setHidchkconvert(String hidchkconvert) {
		this.hidchkconvert = hidchkconvert;
	}

	public String getAgmttime() {
		return agmttime;
	}

	public void setAgmttime(String agmttime) {
		this.agmttime = agmttime;
	}

	public String getAgmtdate() {
		return agmtdate;
	}

	public void setAgmtdate(String agmtdate) {
		this.agmtdate = agmtdate;
	}

	public String getAgmtkm() {
		return agmtkm;
	}

	public void setAgmtkm(String agmtkm) {
		this.agmtkm = agmtkm;
	}

	public String getDatehidden() {
		return datehidden;
	}

	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}

	public String getAgmtdeliverydate() {
		return agmtdeliverydate;
	}

	public void setAgmtdeliverydate(String agmtdeliverydate) {
		this.agmtdeliverydate = agmtdeliverydate;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getAgmtdeliverykm() {
		return agmtdeliverykm;
	}

	public void setAgmtdeliverykm(String agmtdeliverykm) {
		this.agmtdeliverykm = agmtdeliverykm;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String getInfuel() {
		return infuel;
	}

	public void setInfuel(String infuel) {
		this.infuel = infuel;
	}

	private String chkorgregcardcollect;
	private String hidchkorgregcardcollect;
	private String hidchkorgregcard;



	public String getChkorgregcardcollect() {
		return chkorgregcardcollect;
	}

	public void setChkorgregcardcollect(String chkorgregcardcollect) {
		this.chkorgregcardcollect = chkorgregcardcollect;
	}

	public String getHidchkorgregcardcollect() {
		return hidchkorgregcardcollect;
	}

	public void setHidchkorgregcardcollect(String hidchkorgregcardcollect) {
		this.hidchkorgregcardcollect = hidchkorgregcardcollect;
	}

	public String getHidchkorgregcard() {
		return hidchkorgregcard;
	}

	public void setHidchkorgregcard(String hidchkorgregcard) {
		this.hidchkorgregcard = hidchkorgregcard;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		Map<String, String[]> requestParams = request.getParameterMap();
		setHidchkorgregcard(getHidchkorgregcard());
		setHidchkorgregcardcollect(getHidchkorgregcardcollect());
		if(mode.equalsIgnoreCase("View")){
			//System.out.println("mode==="+getMode());

//			System.out.println("view===="+getAgreementno());
			//ClsNonPoolVehBean bean = new ClsNonPoolVehBean(); 
					bean=rentalcloseDAO.getViewDetails(getAgreementno(),getDocno());
					setHidchkorgregcard(bean.getHidchkorgregcard());
					setHidchkorgregcardcollect(bean.getHidchkorgregcardcollect());
					setAllbranch(getAllbranch());
					setVocno(bean.getVocno());
					setHidcmbagmtbranch(bean.getCmbagmtbranch());
					setHidcmbcloseloc(bean.getCmbcloseloc());
					setVoucherno(bean.getVoucherno());
					setClientid(bean.getClientid());
					setHidchkcollection(bean.getHidchkcollection());
					setChaufferid(bean.getChaufferid());
					setChauffer(bean.getChauffer());
					setHidcmbcollectfuel(bean.getHidcmbcollectfuel());
					setCollectchg(bean.getCollectchg());
					setCollectdate(bean.getHidcollectdate());
					setHidcollecttime(bean.getHidcollecttime());
					setCollectkm(bean.getCollectkm());
					/*setHidcmbcheckin(bean.getHidcmbcheckin());
					setHidcmbrentalagent(bean.getHidcmbrentalagent());*/
					setHidfleet(bean.getHidfleet());
					setHidcheckin(bean.getHidcheckin());
					setCheckin(bean.getCheckin());
					setHidrentalagent(bean.getHidrentalagent());
					setRentalagent(bean.getRentalagent());
					setUseddays(bean.getUseddays());
					setUsedhours(bean.getUsedhours());
					setTotalkm(bean.getTotalkm());
					setExcesskm(bean.getExcesskm());
					setInkm(bean.getInkm());
					setHidcmbinfuel(bean.getHidcmbinfuel());
//					System.out.println("fuel:::::"+getHidcmbinfuel());
					setIndate(bean.getHidindate());
					setHidintime(bean.getHidintime());
					setVehicle(bean.getVehicle());
					setClient(bean.getClient());
					setClosedate(bean.getHidclosedate());
					setAgreementno(getAgreementno());
					setDescription(bean.getDescription());
					setDocno(getDocno());
					return "success";
				}
		java.sql.Date indate=null,collectdate=null,closedate=null,outdate=null;
//		System.out.println("GETINDATE:"+getIndate());
		if(getIndate()!=null){
		indate=objcommon.changeStringtoSqlDate(getIndate());
		}
		if(getCollectdate()!=null){
			collectdate=objcommon.changeStringtoSqlDate(getCollectdate());
		}
		if(!(getClosedate()==null)){
			closedate=objcommon.changeStringtoSqlDate(getClosedate());
		}
		if(getDatehidden()!=null){
			outdate=objcommon.changeStringtoSqlDate(getDatehidden());
		}
		int closecal=rentalcloseDAO.getCloseMethod();
		if(closecal==1 && (!(getClosecalflag().trim().equalsIgnoreCase("1")))){
			outdate=objcommon.changeStringtoSqlDate(getCloseinvdate());
		}
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> closearray= new ArrayList<>();
//			System.out.println("inside tarifsave");
			for(int i=0;i<getGridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
				//System.out.println("request =========="+request.getAttribute("test"+i));
				String temp=requestParams.get("test"+i)[0];
				
				closearray.add(temp);
//				System.out.println(closearray.get(i));
			}
			ArrayList<String> calcarray= new ArrayList<>();
			for(int i=0;i<getCalcgridlength();i++){
				String temp=requestParams.get("testcalc"+i)[0];
				
				calcarray.add(temp);
//				System.out.println(calcarray.get(i));
			}
			/*getAgreementno(),sqldate,getIntime(),session,getInkm(),getInfuel(),closearray*/
			int val=rentalcloseDAO.insert(getAgreementno(),getClientid(),getHidchkcollection(),getCollectkm(),getCmbcollectfuel()==null?"0":getCmbcollectfuel(),collectdate,getCollecttime(),getHidcheckin(),
					getInkm(),getCmbinfuel(),indate,getIntime(),getHidrentalagent(),getUseddays(),getUsedhours(),getTotalkm(),getExcesskm(),session,closearray,closedate,getMode(),
					getChaufferid(),calcarray,outdate,getClientacno(),getHidfleet(),getCreditnotesum(),request,getCollectchg()==null?"0":getCollectchg(),getBrchName(),getCmbagmtbranch(),getCmbcloseloc(),getDescription(),getHidchkorgregcardcollect());
			if(val>0){
				setDocno(val);
				setVoucherno(Integer.parseInt(request.getAttribute("VOUCHERNO").toString()));
				setAgreementno(getAgreementno());
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHidcmbcloseloc(getCmbcloseloc());
				setVocno(getVocno());
				setVehicle(getVehicle());
				setClient(getClient());
				setClientid(getClientid());
				setIndate(indate.toString());
				setHidcmbinfuel(getCmbinfuel());
				setClosedate(closedate.toString());
				setChauffer(getChauffer());
				setChaufferid(getChaufferid());
				setHidchkcollection(getHidchkcollection());
				if(getHidchkcollection().equalsIgnoreCase("1")){
					setCollectkm(getCollectkm());
					setCollectdate(collectdate.toString());
					
					setHidcmbcollectfuel(getCmbcollectfuel());
					setHidcollecttime(getCollecttime());	
				}
				
				setHidintime(getIntime());
				setHidcmbcollectfuel(getCmbcollectfuel());
				setHidcmbcheckin(getCmbcheckin());
				setHidcmbrentalagent(getCmbrentalagent());
				setUseddays(getUseddays());
				setUsedhours(getUsedhours());
				setTotalkm(getTotalkm());
				setExcesskm(getExcesskm());
				setMode(getMode());
				setDescription(getDescription());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDocno(val);
				setVoucherno(0);
				setVocno(getVocno());
				setAgreementno(getAgreementno());
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHidcmbcloseloc(getCmbcloseloc());
				setVehicle(getVehicle());
				setClient(getClient());
				setClientid(getClientid());
				setIndate(indate.toString());
				setHidcmbinfuel(getCmbinfuel());
				setClosedate(closedate.toString());
				setChauffer(getChauffer());
				setChaufferid(getChaufferid());
				setHidchkcollection(getHidchkcollection());
				if(getHidchkcollection().equalsIgnoreCase("1")){
					setCollectkm(getCollectkm());
					setCollectdate(collectdate.toString());
					
					setHidcmbcollectfuel(getCmbcollectfuel());
					setHidcollecttime(getCollecttime());	
				}
				
				setHidintime(getIntime());
				setHidcmbcollectfuel(getCmbcollectfuel());
				setHidcmbcheckin(getCmbcheckin());
				setHidcmbrentalagent(getCmbrentalagent());
				setUseddays(getUseddays());
				setUsedhours(getUsedhours());
				setTotalkm(getTotalkm());
				setExcesskm(getExcesskm());
				setMode(getMode());
				setDescription(getDescription());
				
				setMsg("Not Saved");
			}
		}
		
		
		
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println("Inside Action");
			int val=rentalcloseDAO.delete(getDocno(),getAgreementno(),session,getMode(),getHidfleet(),getBrchName());
			if(val>0){
				setDocno(getDocno());
				setVoucherno(getVoucherno());
				setAgreementno(getAgreementno());
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHidcmbcloseloc(getCmbcloseloc());
				setVocno(getVocno());
				setVehicle(getVehicle());
				setUseddays(getUseddays());
				setUsedhours(getUsedhours());
				setTotalkm(getTotalkm());
				setExcesskm(getExcesskm());
				setClient(getClient());
				setClientid(getClientid());
				setIndate(indate.toString());
				setHidcmbinfuel(getCmbinfuel());
				setClosedate(closedate.toString());
				setChauffer(getChauffer());
				setChaufferid(getChaufferid());
				setHidchkcollection(getHidchkcollection());
				if(getHidchkcollection().equalsIgnoreCase("1")){
					setCollectkm(getCollectkm());
					setCollectdate(collectdate.toString());
					
					setHidcmbcollectfuel(getCmbcollectfuel());
					setHidcollecttime(getCollecttime());	
				}
				
				setHidintime(getIntime());
				setHidcmbcollectfuel(getCmbcollectfuel());
				
				setHidcheckin(getHidcheckin());
				setCheckin(getCheckin());
				setHidrentalagent(getHidrentalagent());
				setRentalagent(getRentalagent());
				setDescription(getDescription());
				setMsg("Successfully Deleted");
				return "success";
			}
			else if(val==-1){
				setDocno(getDocno());
				setVoucherno(getVoucherno());
				setAgreementno(getAgreementno());
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHidcmbcloseloc(getCmbcloseloc());
				setVocno(getVocno());
				setVehicle(getVehicle());
				setUseddays(getUseddays());
				setUsedhours(getUsedhours());
				setTotalkm(getTotalkm());
				setExcesskm(getExcesskm());
				setClient(getClient());
				setClientid(getClientid());
				setIndate(indate.toString());
				setHidcmbinfuel(getCmbinfuel());
				setClosedate(closedate.toString());
				setChauffer(getChauffer());
				setChaufferid(getChaufferid());
				setHidchkcollection(getHidchkcollection());
				if(getHidchkcollection().equalsIgnoreCase("1")){
					setCollectkm(getCollectkm());
					setCollectdate(collectdate.toString());
					
					setHidcmbcollectfuel(getCmbcollectfuel());
					setHidcollecttime(getCollecttime());	
				}
				setHidintime(getIntime());
				setHidcmbcollectfuel(getCmbcollectfuel());
				setHidcheckin(getHidcheckin());
				setCheckin(getCheckin());
				setHidrentalagent(getHidrentalagent());
				setRentalagent(getRentalagent());
				setDescription(getDescription());
				setMsg("Not Deleted");
				setErrormsg("Other Movements found against vehicle");
				return "fail";
			}
			else{
				setDocno(getDocno());
				setVoucherno(getVoucherno());
				setAgreementno(getAgreementno());
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHidcmbcloseloc(getCmbcloseloc());
				setVocno(getVocno());
				setVehicle(getVehicle());
				setUseddays(getUseddays());
				setUsedhours(getUsedhours());
				setTotalkm(getTotalkm());
				setExcesskm(getExcesskm());
				setClient(getClient());
				setClientid(getClientid());
				setIndate(indate.toString());
				setHidcmbinfuel(getCmbinfuel());
				setClosedate(closedate.toString());
				setChauffer(getChauffer());
				setChaufferid(getChaufferid());
				setHidchkcollection(getHidchkcollection());
				if(getHidchkcollection().equalsIgnoreCase("1")){
					setCollectkm(getCollectkm());
					setCollectdate(collectdate.toString());
					
					setHidcmbcollectfuel(getCmbcollectfuel());
					setHidcollecttime(getCollecttime());	
				}
				setHidintime(getIntime());
				setHidcmbcollectfuel(getCmbcollectfuel());
				setHidcheckin(getHidcheckin());
				setCheckin(getCheckin());
				setHidrentalagent(getHidrentalagent());
				setRentalagent(getRentalagent());
				setDescription(getDescription());
				setMsg("Not Deleted");
				return "fail";
			}
		}
				return "fail";
			}

}
