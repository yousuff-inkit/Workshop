package com.workshop.gateinpassmaster;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
import com.sms.SmsAction;
import com.workshop.gateinpass.ClsGateInPassBean;
@SuppressWarnings("serial")

public class ClsGateInPassAction extends ActionSupport{
    
	ClsGateInPassDAO gatedao= new ClsGateInPassDAO();
	com.workshop.gateinpassmaster.ClsGateInPassBean bean=new 	com.workshop.gateinpassmaster.ClsGateInPassBean();
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	//save
	private int repgridlength;
	
	public int getRepgridlength() {
		return repgridlength;
	}

	public void setRepgridlength(int repgridlength) {
		this.repgridlength = repgridlength;
	}
	private int docno,gridlength,clname,apprvalchk,backjob,excesschk,clientid,cmbbrand,cmbmodel,cmbyom,movno,
	            vehkm,cmbrepairtype,cmbinsutype,cmbfaulttype,hidcmbbrand,hidcmbmodel,hidcmbyom,luxury,hidluxury,
	            hidcmbrepairtype,hidcmbinsutype,hidcmbfaulttype,chkexces,chkbjob,hidchkappr,hidchkclname,vocno;
	double lpoamount,excessamount;
	
	private String date,brchName,vehuserothers,vehregno,vehplatecode,cmbfueltype,hidcmbfueltype,
	               cldocno,vehusername,vehusermobile,vehuseremail,clientname,insucompany,clientdetails,
	               description,intime,cmbinfuel,remarks,serviceduekm,vehothers,estdate,esttime,maintenanceremarks,
	               policereport,policedate,policestation,claim,lpo;
	private String mode,msg,deleted,formdetailcode,refno,lblcompanyname,latestkm;
	private String lblcompname,lblcompaddress,lblprintname,lblcomptel,lblcompfax,lblprintname1,lblbranch,lbllocation;
	
	private String lbldate,lblmodel,lblrvehicleno,lbljobno,lbltype,lblcustomer,lblperson,lblchasisno,lblengineno,lblreleasedby,lbltodat;
	private String marketingperson,serviceadvisor,insurancesurvivor,referencedby,servicepackage,teammaster,hidmarketingperson,hidserviceadvisor,
	hidinsurancesurvivor,hidreferencedby,hidservicepackage,hidteammaster;
	private String cmbpriority;
	private String hidcmbpriority;
	private String cmbcolor;
	private String hidcmbcolor;
	private String regexpirydate;
	private String group;
	private String chkvirtual;
	private String hidchkvirtual;
	
	
	public String getChkvirtual() {
		return chkvirtual;
	}

	public void setChkvirtual(String chkvirtual) {
		this.chkvirtual = chkvirtual;
	}

	public String getHidchkvirtual() {
		return hidchkvirtual;
	}

	public void setHidchkvirtual(String hidchkvirtual) {
		this.hidchkvirtual = hidchkvirtual;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getRegexpirydate() {
		return regexpirydate;
	}

	public void setRegexpirydate(String regexpirydate) {
		this.regexpirydate = regexpirydate;
	}

	public String getCmbcolor() {
		return cmbcolor;
	}

	public void setCmbcolor(String cmbcolor) {
		this.cmbcolor = cmbcolor;
	}

	public String getHidcmbcolor() {
		return hidcmbcolor;
	}

	public void setHidcmbcolor(String hidcmbcolor) {
		this.hidcmbcolor = hidcmbcolor;
	}

	public String getHidcmbpriority() {
		return hidcmbpriority;
	}

	public void setHidcmbpriority(String hidcmbpriority) {
		this.hidcmbpriority = hidcmbpriority;
	}

	public String getCmbpriority() {
		return cmbpriority;
	}

	public void setCmbpriority(String cmbpriority) {
		this.cmbpriority = cmbpriority;
	}

	public String getMarketingperson() {
		return marketingperson;
	}

	public void setMarketingperson(String marketingperson) {
		this.marketingperson = marketingperson;
	}

	public String getServiceadvisor() {
		return serviceadvisor;
	}

	public void setServiceadvisor(String serviceadvisor) {
		this.serviceadvisor = serviceadvisor;
	}

	public String getInsurancesurvivor() {
		return insurancesurvivor;
	}

	public void setInsurancesurvivor(String insurancesurvivor) {
		this.insurancesurvivor = insurancesurvivor;
	}

	public String getReferencedby() {
		return referencedby;
	}

	public void setReferencedby(String referencedby) {
		this.referencedby = referencedby;
	}

	public String getServicepackage() {
		return servicepackage;
	}

	public void setServicepackage(String servicepackage) {
		this.servicepackage = servicepackage;
	}

	public String getTeammaster() {
		return teammaster;
	}

	public void setTeammaster(String teammaster) {
		this.teammaster = teammaster;
	}

	public String getHidmarketingperson() {
		return hidmarketingperson;
	}

	public void setHidmarketingperson(String hidmarketingperson) {
		this.hidmarketingperson = hidmarketingperson;
	}

	public String getHidserviceadvisor() {
		return hidserviceadvisor;
	}

	public void setHidserviceadvisor(String hidserviceadvisor) {
		this.hidserviceadvisor = hidserviceadvisor;
	}

	public String getHidinsurancesurvivor() {
		return hidinsurancesurvivor;
	}

	public void setHidinsurancesurvivor(String hidinsurancesurvivor) {
		this.hidinsurancesurvivor = hidinsurancesurvivor;
	}

	public String getHidreferencedby() {
		return hidreferencedby;
	}

	public void setHidreferencedby(String hidreferencedby) {
		this.hidreferencedby = hidreferencedby;
	}

	public String getHidservicepackage() {
		return hidservicepackage;
	}

	public void setHidservicepackage(String hidservicepackage) {
		this.hidservicepackage = hidservicepackage;
	}

	public String getHidteammaster() {
		return hidteammaster;
	}

	public void setHidteammaster(String hidteammaster) {
		this.hidteammaster = hidteammaster;
	}

	public String getLatestkm() {
		return latestkm;
	}

	public void setLatestkm(String latestkm) {
		this.latestkm = latestkm;
	}

	public String getLblmodel() {
		return lblmodel;
	}

	public void setLblmodel(String lblmodel) {
		this.lblmodel = lblmodel;
	}

	public String getLblrvehicleno() {
		return lblrvehicleno;
	}

	public void setLblrvehicleno(String lblrvehicleno) {
		this.lblrvehicleno = lblrvehicleno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbljobno() {
		return lbljobno;
	}

	public void setLbljobno(String lbljobno) {
		this.lbljobno = lbljobno;
	}

	public String getLbltype() {
		return lbltype;
	}

	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}

	public String getLblcustomer() {
		return lblcustomer;
	}

	public void setLblcustomer(String lblcustomer) {
		this.lblcustomer = lblcustomer;
	}

	public String getLblperson() {
		return lblperson;
	}

	public void setLblperson(String lblperson) {
		this.lblperson = lblperson;
	}

	public String getLblchasisno() {
		return lblchasisno;
	}

	public void setLblchasisno(String lblchasisno) {
		this.lblchasisno = lblchasisno;
	}

	public String getLblengineno() {
		return lblengineno;
	}

	public void setLblengineno(String lblengineno) {
		this.lblengineno = lblengineno;
	}

	public String getLblreleasedby() {
		return lblreleasedby;
	}

	public void setLblreleasedby(String lblreleasedby) {
		this.lblreleasedby = lblreleasedby;
	}

	public String getLbltodat() {
		return lbltodat;
	}

	public void setLbltodat(String lbltodat) {
		this.lbltodat = lbltodat;
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

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
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

	public String getLblprintname1() {
		return lblprintname1;
	}

	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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

	public String getLblcompanyname() {
		return lblcompanyname;
	}

	public void setLblcompanyname(String lblcompanyname) {
		this.lblcompanyname = lblcompanyname;
	}

	public int getLuxury() {
		return luxury;
	}

	public void setLuxury(int luxury) {
		this.luxury = luxury;
	}

	public int getHidluxury() {
		return hidluxury;
	}

	public void setHidluxury(int hidluxury) {
		this.hidluxury = hidluxury;
	}

	public int getMovno() {
		return movno;
	}

	public void setMovno(int movno) {
		this.movno = movno;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public int getVocno() {
		return vocno;
	}

	public void setVocno(int vocno) {
		this.vocno = vocno;
	}

	public int getChkexces() {
		return chkexces;
	}

	public void setChkexces(int chkexces) {
		this.chkexces = chkexces;
	}

	public int getChkbjob() {
		return chkbjob;
	}

	public void setChkbjob(int chkbjob) {
		this.chkbjob = chkbjob;
	}

	public int getHidchkappr() {
		return hidchkappr;
	}

	public void setHidchkappr(int hidchkappr) {
		this.hidchkappr = hidchkappr;
	}

	public int getHidchkclname() {
		return hidchkclname;
	}

	public void setHidchkclname(int hidchkclname) {
		this.hidchkclname = hidchkclname;
	}

	public String getHidcmbfueltype() {
		return hidcmbfueltype;
	}

	public void setHidcmbfueltype(String hidcmbfueltype) {
		this.hidcmbfueltype = hidcmbfueltype;
	}

	public int getHidcmbrepairtype() {
		return hidcmbrepairtype;
	}

	public void setHidcmbrepairtype(int hidcmbrepairtype) {
		this.hidcmbrepairtype = hidcmbrepairtype;
	}

	public int getHidcmbinsutype() {
		return hidcmbinsutype;
	}

	public void setHidcmbinsutype(int hidcmbinsutype) {
		this.hidcmbinsutype = hidcmbinsutype;
	}

	public int getHidcmbfaulttype() {
		return hidcmbfaulttype;
	}

	public void setHidcmbfaulttype(int hidcmbfaulttype) {
		this.hidcmbfaulttype = hidcmbfaulttype;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getClname() {
		return clname;
	}
	public void setClname(int clname) {
		this.clname = clname;
	}
	public int getApprvalchk() {
		return apprvalchk;
	}
	public void setApprvalchk(int apprvalchk) {
		this.apprvalchk = apprvalchk;
	}
	public int getBackjob() {
		return backjob;
	}
	public void setBackjob(int backjob) {
		this.backjob = backjob;
	}
	public int getExcesschk() {
		return excesschk;
	}
	public void setExcesschk(int excesschk) {
		this.excesschk = excesschk;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getVehuserothers() {
		return vehuserothers;
	}
	public void setVehuserothers(String vehuserothers) {
		this.vehuserothers = vehuserothers;
	}
	public String getVehregno() {
		return vehregno;
	}
	public void setVehregno(String vehregno) {
		this.vehregno = vehregno;
	}
	public String getVehplatecode() {
		return vehplatecode;
	}
	public void setVehplatecode(String vehplatecode) {
		this.vehplatecode = vehplatecode;
	}
	public int getCmbbrand() {
		return cmbbrand;
	}
	public void setCmbbrand(int cmbbrand) {
		this.cmbbrand = cmbbrand;
	}
	public int getHidcmbbrand() {
		return hidcmbbrand;
	}
	public void setHidcmbbrand(int hidcmbbrand) {
		this.hidcmbbrand = hidcmbbrand;
	}
	public int getCmbmodel() {
		return cmbmodel;
	}
	public void setCmbmodel(int cmbmodel) {
		this.cmbmodel = cmbmodel;
	}
	public int getHidcmbmodel() {
		return hidcmbmodel;
	}
	public void setHidcmbmodel(int hidcmbmodel) {
		this.hidcmbmodel = hidcmbmodel;
	}
	public int getCmbyom() {
		return cmbyom;
	}
	public void setCmbyom(int cmbyom) {
		this.cmbyom = cmbyom;
	}
	public int getHidcmbyom() {
		return hidcmbyom;
	}
	public void setHidcmbyom(int hidcmbyom) {
		this.hidcmbyom = hidcmbyom;
	}
	public String getCldocno() {
		return cldocno;
	}
	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}
	public String getVehusername() {
		return vehusername;
	}
	public void setVehusername(String vehusername) {
		this.vehusername = vehusername;
	}
	public String getVehusermobile() {
		return vehusermobile;
	}
	public void setVehusermobile(String vehusermobile) {
		this.vehusermobile = vehusermobile;
	}
	public String getVehuseremail() {
		return vehuseremail;
	}
	public void setVehuseremail(String vehuseremail) {
		this.vehuseremail = vehuseremail;
	}

	public String getClientname() {
		return clientname;
	}
	public void setClientname(String clientname) {
		this.clientname = clientname;
	}

	public String getInsucompany() {
		return insucompany;
	}
	public void setInsucompany(String insucompany) {
		this.insucompany = insucompany;
	}
	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIntime() {
		return intime;
	}
	public void setIntime(String intime) {
		this.intime = intime;
	}
	public String getCmbinfuel() {
		return cmbinfuel;
	}

	public void setCmbinfuel(String cmbinfuel) {
		this.cmbinfuel = cmbinfuel;
	}
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getServiceduekm() {
		return serviceduekm;
	}

	public void setServiceduekm(String serviceduekm) {
		this.serviceduekm = serviceduekm;
	}
	public String getVehothers() {
		return vehothers;
	}
	public void setVehothers(String vehothers) {
		this.vehothers = vehothers;
	}
	public int getVehkm() {
		return vehkm;
	}
	public void setVehkm(int vehkm) {
		this.vehkm = vehkm;
	}
	public String getCmbfueltype() {
		return cmbfueltype;
	}
	public void setCmbfueltype(String cmbfueltype) {
		this.cmbfueltype = cmbfueltype;
	}
	public int getCmbrepairtype() {
		return cmbrepairtype;
	}
	public void setCmbrepairtype(int cmbrepairtype) {
		this.cmbrepairtype = cmbrepairtype;
	}
	public String getEstdate() {
		return estdate;
	}
	public void setEstdate(String estdate) {
		this.estdate = estdate;
	}
	public String getEsttime() {
		return esttime;
	}
	public void setEsttime(String esttime) {
		this.esttime = esttime;
	}
	public String getMaintenanceremarks() {
		return maintenanceremarks;
	}
	public void setMaintenanceremarks(String maintenanceremarks) {
		this.maintenanceremarks = maintenanceremarks;
	}

	public String getPolicereport() {
		return policereport;
	}
	public void setPolicereport(String policereport) {
		this.policereport = policereport;
	}
	public String getPolicedate() {
		return policedate;
	}
	public void setPolicedate(String policedate) {
		this.policedate = policedate;
	}
	public String getPolicestation() {
		return policestation;
	}
	public void setPolicestation(String policestation) {
		this.policestation = policestation;
	}
	public int getCmbinsutype() {
		return cmbinsutype;
	}

	public void setCmbinsutype(int cmbinsutype) {
		this.cmbinsutype = cmbinsutype;
	}
	public int getCmbfaulttype() {
		return cmbfaulttype;
	}
	public void setCmbfaulttype(int cmbfaulttype) {
		this.cmbfaulttype = cmbfaulttype;
	}
	public String getClaim() {
		return claim;
	}
	public void setClaim(String claim) {
		this.claim = claim;
	}
	public String getLpo() {
		return lpo;
	}
	public void setLpo(String lpo) {
		this.lpo = lpo;
	}
	public double getLpoamount() {
		return lpoamount;
	}
	public void setLpoamount(double lpoamount) {
		this.lpoamount = lpoamount;
	}

	public double getExcessamount() {
		return excessamount;
	}
	public void setExcessamount(double excessamount) {
		this.excessamount = excessamount;
	}
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private Map<String, Object> param = null;
	
	

	
	

	public String saveAction() throws ParseException, SQLException{
		
		//System.out.println("inside action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();

		if(mode.equalsIgnoreCase("view")){
			String id=request.getParameter("id");
			String modee=request.getParameter("mode");
			String docno=request.getParameter("docno");
			if(id.equalsIgnoreCase("2")){
				mode=modee;
				System.out.println(docno);
				if(mode.equalsIgnoreCase("view")){
					int doc_no=(Integer.parseInt(docno));
					System.out.println("Passed Doc No:"+doc_no);
					Connection conn = null;
					try{
						conn=connDAO.getMyConnection();
						Statement stmt = conn.createStatement ();
						String strSql = "select w.chkvirtual,w.regexpirydate,w.colorid,coalesce(grp.gname) gname,w.marketingperson marketingpersonid, w.serviceadvisor serviceadvisorid, "+
						" w.insurancesurvivor insurancesurvivorid,w.referencedby referencedbyid, w.servicepackage servicepackageid, w.teammaster "+
						" teammasterid,coalesce(wmp.sal_name,'') marketingperson,coalesce(wsa.sal_name,'') serviceadvisor,coalesce(wis.sal_name,'') insurancesurvivor,coalesce(wrb.sal_name,'') "+
						" referencedby,coalesce(wsp.name,'') servicepackage,coalesce(wtm.grpcode,'') teammaster,w.doc_no, w.brhid,ac.refname clientname,ac.contactperson,ac.per_mob,ac.per_tel,ac.mail1,ac.address"
						+ " ,acc.refname companyname, w.VOC_NO, w.date, w.cldocno, w.insurancecomp, w.insurcldocno, w.desc1, w.approvalreq, w.username, "
						+ " w.mobile, w.email, w.other, w.regno, w.pltid, w.brdid, w.modid, w.yom, w.vehother,"
						+ " w.kmin, w.fuel, w.repairtype, w.estdeldate, w.estdeltime, w.mainremarks, w.policerep, w.policerepdate,"
						+ " w.stationname, w.insutype, w.faulttype, w.claim, w.lpo, w.lpoamount, w.excess, w.excessamt, w.userid,"
						+ " w.status, w.BACKJOB, w.Refno, w.movno, w.processstatus,w.luxury from ws_gateinpass w left join my_acbook ac"
						+ " on (ac.cldocno=w.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=w.insurcldocno and acc.dtype='CRM') "+
						" left join my_salesman wmp on (w.marketingperson=wmp.doc_no and wmp.sal_type='WMP')"+
						" left join my_salesman wsa on (w.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA')"+
						" left join my_salesman wis on (w.insurancesurvivor=wis.doc_no and wis.sal_type='WIS')"+
						" left join my_salesman wrb on (w.referencedby=wrb.doc_no and wrb.sal_type='WRB')"+
						" left join ws_servicepackage wsp on w.servicepackage=wsp.doc_no"+
						" left join ws_teammasterm wtm on w.teammaster=wtm.doc_no "+
						" left join gl_vehmodel model on w.modid=model.doc_no "+
						" left join gl_vehgroup grp on model.groupid=grp.doc_no where w.doc_no="+doc_no;
						System.out.println("nidhi"+strSql);
						ResultSet rs = stmt.executeQuery(strSql);
						while(rs.next())
						{
							setGroup(rs.getString("gname"));
							if(rs.getDate("regexpirydate")!=null){
								setRegexpirydate(rs.getDate("regexpirydate").toString());
							}
							setHidchkvirtual(rs.getString("chkvirtual"));
							setDocno(rs.getInt("doc_no"));
							setVocno(rs.getInt("voc_no"));
							setHidcmbcolor(rs.getString("colorid"));
							setHidcmbbrand(rs.getInt("brdid"));
							setHidcmbmodel(rs.getInt("modid"));
							setHidcmbyom(rs.getInt("yom"));
							setHidcmbrepairtype(rs.getInt("repairtype"));
							setHidcmbfaulttype(rs.getInt("faulttype"));
							setHidcmbinsutype(rs.getInt("insutype"));
							setHidcmbfueltype(rs.getString("fuel"));
							setHidchkappr(rs.getInt("approvalreq"));
							setHidchkclname(rs.getInt("insurancecomp"));
							setChkbjob(rs.getInt("BACKJOB"));
							setChkexces(rs.getInt("excess"));
							setRefno(rs.getString("Refno"));
							setMovno(rs.getInt("movno"));
							setHidluxury(rs.getInt("luxury"));
							setDate(rs.getDate("date").toString());
							setCldocno(rs.getString("cldocno"));
							setClientname(rs.getString("clientname"));
							setInsucompany(rs.getString("companyname"));
							setClientid(rs.getInt("insurcldocno"));
							setClientdetails("CONTACT PPERSON: "+rs.getString("contactperson")+" ,Address: "+rs.getString("address")+" ,Mobile: "+rs.getString("per_mob")+" ,Email: "+rs.getString("mail1")+" ,Tel: "+rs.getString("per_tel"));
						    setDescription(rs.getString("desc1"));
						    setVehusername(rs.getString("username"));
						    setVehusermobile(rs.getString("mobile"));
						    setVehuseremail(rs.getString("email"));
						    setVehuserothers(rs.getString("other"));
						    setVehregno(rs.getString("regno"));
						    setVehplatecode(rs.getString("pltid"));
						    setVehothers(rs.getString("vehother"));
						    setVehkm(rs.getInt("kmin"));
						    setEstdate(rs.getDate("estdeldate").toString());
						    setEsttime(rs.getString("estdeltime"));
						    setMaintenanceremarks(rs.getString("mainremarks"));
						    setPolicereport(rs.getString("policerep"));
						    setPolicedate(rs.getDate("policerepdate").toString());
						    setPolicestation(rs.getString("stationname"));
						    setClaim(rs.getString("claim"));
						    setLpo(rs.getString("lpo"));
						    setLpoamount(rs.getInt("lpoamount"));
						    setExcessamount(rs.getInt("excessamt"));
						    setMarketingperson(rs.getString("marketingperson"));
						    setHidmarketingperson(rs.getString("marketingpersonid"));
						    setServiceadvisor(rs.getString("serviceadvisor"));
						    setHidserviceadvisor(rs.getString("serviceadvisorid"));
						    setInsurancesurvivor(rs.getString("insurancesurvivor"));
						    setHidinsurancesurvivor(rs.getString("insurancesurvivorid"));
						    setReferencedby(rs.getString("referencedby"));
						    setHidreferencedby(rs.getString("referencedbyid"));
						    setServicepackage(rs.getString("servicepackage"));
						    setHidservicepackage(rs.getString("servicepackageid"));
						    setTeammaster(rs.getString("teammaster"));
						    setHidteammaster(rs.getString("teammasterid"));
						}
	
						/*setHidcmbmodel(getCmbmodel());
						setHidcmbyom(getCmbyom());
						setHidcmbrepairtype(getCmbrepairtype());
						setHidcmbfaulttype(getCmbfaulttype());
						setHidcmbinsutype(getCmbinsutype());
						setHidcmbfueltype(getCmbfueltype());
						setHidchkappr(getApprvalchk());
						setHidchkclname(getClname());
						setChkbjob(getBackjob());
						setChkexces(getExcesschk());
						setRefno(getRefno());
						setMovno(getMovno());
						setHidluxury(getLuxury());*/
						
						/*setVocno(doc_no);
						setDocno(doc_no);*/
					    return "success";
					}
				 	catch(Exception e){
				 		e.printStackTrace();
				 		conn.close();
				 	}
				 	finally{
				 		conn.close();
				 	}
				}
			}
		}

		if(!mode.equalsIgnoreCase("view")){
			java.sql.Date sqldate=null,sqlestdate=null,sqlesttime=null,sqlpolicedate=null;
			java.sql.Date sqlregexpirydate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=commonDAO.changeStringtoSqlDate(getDate());
			}
			if(getEstdate()!=null && !getEstdate().equalsIgnoreCase("")){
				sqlestdate=commonDAO.changeStringtoSqlDate(getEstdate());
			}
			if(getPolicedate()!=null && !getPolicedate().equalsIgnoreCase("")){
				sqlpolicedate=commonDAO.changeStringtoSqlDate(getPolicedate());
			}
			if(getRegexpirydate()!=null && !getRegexpirydate().equalsIgnoreCase("")){
				sqlregexpirydate=commonDAO.changeStringtoSqlDate(getRegexpirydate());
			}
			
			//System.out.println("============="+mode);
			if(mode.equalsIgnoreCase("A")){
				ArrayList<String> complaintarray=new ArrayList<>();
//				System.out.println("============="+getGridlength());
				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("test"+i)[0];
					complaintarray.add(temp);
				}
				ArrayList<String> reparray=new ArrayList<>();
				for(int i=0;i<getRepgridlength();i++){
					String temp=requestParams.get("reptest"+i)[0];
					reparray.add(temp);
				}
				int insertval=gatedao.insert(sqldate,getDocno(),getCldocno(),getClname(),getClientid(),getDescription(),
				getApprvalchk(),getBackjob(),getVehusername(),getVehusermobile(),getVehuseremail(),getVehuserothers(),getVehregno(),getVehplatecode(),
				getCmbbrand(),getCmbmodel(),getCmbyom(),getVehothers(),getVehkm(),getCmbfueltype(),getCmbrepairtype(),sqlestdate,getEsttime(),getMaintenanceremarks(),
				getPolicereport(),sqlpolicedate,getPolicestation(),getCmbinsutype(),getCmbfaulttype(),getClaim(),getLpo(),getLpoamount()
				,getExcesschk(),getExcessamount(),complaintarray,session,request,mode,getFormdetailcode(),getBrchName(),
				getRefno(),getMovno(),getLuxury(),getHidmarketingperson(),getHidserviceadvisor(),getHidinsurancesurvivor(),getHidreferencedby(),
				getHidservicepackage(),getHidteammaster(),getCmbpriority(),getCmbcolor(),sqlregexpirydate,getChkvirtual(),reparray);
				if(insertval>0){
					setGroup(getGroup());
					setRegexpirydate(sqlregexpirydate.toString());
					setHidcmbcolor(getCmbcolor());
					setCmbpriority(getCmbpriority());
					setHidcmbpriority(getCmbpriority());
					setLatestkm(getLatestkm());
					setDate(sqldate.toString());
					setEstdate(sqlestdate.toString());
					setPolicedate(sqlpolicedate.toString());
					setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());
					setHidcmbyom(getCmbyom());
					setHidcmbrepairtype(getCmbrepairtype());
					setHidcmbfaulttype(getCmbfaulttype());
					setHidcmbinsutype(getCmbinsutype());
					setHidcmbfueltype(getCmbfueltype());
					setHidchkvirtual(getChkvirtual());
					setChkvirtual(getChkvirtual());
					setHidchkappr(getApprvalchk());
					setHidchkclname(getClname());
					setChkbjob(getBackjob());
					setChkexces(getExcesschk());
					setDocno(insertval);
					setRefno(getRefno());
					setMovno(getMovno());
					setHidluxury(getLuxury());
					setVocno(Integer.parseInt(request.getAttribute("vocNo").toString()));
					setMsg("Successfully Saved");
//					System.out.println("CmbFuelType:"+getCmbfueltype());
//					System.out.println("HidCmbFuelType:"+getHidcmbfueltype());
					setHidmarketingperson(getHidmarketingperson());
					setMarketingperson(getMarketingperson());
					setServiceadvisor(getServiceadvisor());
					setHidserviceadvisor(getHidserviceadvisor());
					setInsurancesurvivor(getInsurancesurvivor());
					setHidinsurancesurvivor(getHidinsurancesurvivor());
					setReferencedby(getReferencedby());
					setHidreferencedby(getHidreferencedby());
					setServicepackage(getServicepackage());
					setHidservicepackage(getHidservicepackage());
					setTeammaster(getTeammaster());
					setHidteammaster(getHidteammaster());
					
					return "success";
				}
				else{
					setGroup(getGroup());
					setRegexpirydate(sqlregexpirydate.toString());
					setHidcmbcolor(getCmbcolor());
					setCmbpriority(getCmbpriority());
					setHidcmbpriority(getCmbpriority());
					setLatestkm(getLatestkm());
					setDate(sqldate.toString());
					setEstdate(sqlestdate.toString());
					setPolicedate(sqlpolicedate.toString());
					setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());
					setHidcmbyom(getCmbyom());
					setHidcmbrepairtype(getCmbrepairtype());
					setHidcmbfaulttype(getCmbfaulttype());
					setHidcmbinsutype(getCmbinsutype());
					setHidcmbfueltype(getCmbfueltype());
					setHidchkappr(getApprvalchk());
					setHidchkclname(getClname());
					setChkbjob(getBackjob());
					setChkexces(getExcesschk());
					setRefno(getRefno());
					setHidluxury(getLuxury());
					setHidchkvirtual(getChkvirtual());
					setChkvirtual(getChkvirtual());
					setMsg("Not Saved");
					setHidmarketingperson(getHidmarketingperson());
					setMarketingperson(getMarketingperson());
					setServiceadvisor(getServiceadvisor());
					setHidserviceadvisor(getHidserviceadvisor());
					setInsurancesurvivor(getInsurancesurvivor());
					setHidinsurancesurvivor(getHidinsurancesurvivor());
					setReferencedby(getReferencedby());
					setHidreferencedby(getHidreferencedby());
					setServicepackage(getServicepackage());
					setHidservicepackage(getHidservicepackage());
					setTeammaster(getTeammaster());
					setHidteammaster(getHidteammaster());
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
				ArrayList<String> complaintarray=new ArrayList<>();
			//	System.out.println("============="+getGridlength());
				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("test"+i)[0];
					
					complaintarray.add(temp);
				}
				ArrayList<String> reparray=new ArrayList<>();
				for(int i=0;i<getRepgridlength();i++){
					String temp=requestParams.get("reptest"+i)[0];
					reparray.add(temp);
				}
				int status=gatedao.edit(sqldate,getDocno(),getVocno(),getCldocno(),getClname(),getClientid(),getDescription(),
	             getApprvalchk(),getBackjob(),getVehusername(),getVehusermobile(),getVehuseremail(),getVehuserothers(),getVehregno(),getVehplatecode(),
	             getCmbbrand(),getCmbmodel(),getCmbyom(),getVehothers(),getVehkm(),getCmbfueltype(),getCmbrepairtype(),sqlestdate,getEsttime(),getMaintenanceremarks(),
	             getPolicereport(),sqlpolicedate,getPolicestation(),getCmbinsutype(),getCmbfaulttype(),getClaim(),getLpo(),getLpoamount()
	             ,getExcesschk(),getExcessamount(),complaintarray,session,request,mode,getFormdetailcode(),getBrchName(),getRefno(),
	             getMovno(),getLuxury(),getHidmarketingperson(),getHidserviceadvisor(),getHidinsurancesurvivor(),getHidreferencedby(),
					getHidservicepackage(),getHidteammaster(),getCmbpriority(),getCmbcolor(),sqlregexpirydate,getChkvirtual(),reparray);
				if(status>0){
					setGroup(getGroup());
					setRegexpirydate(sqlregexpirydate.toString());
					setHidcmbcolor(getCmbcolor());
					setCmbpriority(getCmbpriority());
					setHidcmbpriority(getCmbpriority());
					setDate(sqldate.toString());
					setEstdate(sqlestdate.toString());
					setPolicedate(sqlpolicedate.toString());
					setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());
					setHidcmbyom(getCmbyom());
					setHidcmbrepairtype(getCmbrepairtype());
					setHidcmbfaulttype(getCmbfaulttype());
					setHidcmbinsutype(getCmbinsutype());
					setHidcmbfueltype(getCmbfueltype());
					setHidchkappr(getApprvalchk());
					setHidchkclname(getClname());
					setChkbjob(getBackjob());
					setChkexces(getExcesschk());
					setRefno(getRefno());
					setHidluxury(getLuxury());
					setMsg("Updated Successfully");
					setHidmarketingperson(getHidmarketingperson());
					setMarketingperson(getMarketingperson());
					setServiceadvisor(getServiceadvisor());
					setHidserviceadvisor(getHidserviceadvisor());
					setInsurancesurvivor(getInsurancesurvivor());
					setHidinsurancesurvivor(getHidinsurancesurvivor());
					setReferencedby(getReferencedby());
					setHidreferencedby(getHidreferencedby());
					setServicepackage(getServicepackage());
					setHidservicepackage(getHidservicepackage());
					setTeammaster(getTeammaster());
					setHidteammaster(getHidteammaster());
					setHidchkvirtual(getChkvirtual());
					setChkvirtual(getChkvirtual());
					return "success";
				}
				else{
					setGroup(getGroup());
					setRegexpirydate(sqlregexpirydate.toString());
					setHidcmbcolor(getCmbcolor());
					setCmbpriority(getCmbpriority());
					setHidcmbpriority(getCmbpriority());
					setDate(sqldate.toString());
					setEstdate(sqlestdate.toString());
					setPolicedate(sqlpolicedate.toString());
					setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());
					setHidcmbyom(getCmbyom());
					setHidcmbrepairtype(getCmbrepairtype());
					setHidcmbfaulttype(getCmbfaulttype());
					setHidcmbinsutype(getCmbinsutype());
					setHidcmbfueltype(getCmbfueltype());
					setHidchkappr(getApprvalchk());
					setHidchkclname(getClname());
					setChkbjob(getBackjob());
					setChkexces(getExcesschk());
					setRefno(getRefno());
					setHidluxury(getLuxury());
					if(status<0){
						setMsg("Estimation Created, Cannot Edit");
					}
					else{
						setMsg("Not Updated");
					}
					setHidchkvirtual(getChkvirtual());
					setChkvirtual(getChkvirtual());
					setHidmarketingperson(getHidmarketingperson());
					setMarketingperson(getMarketingperson());
					setServiceadvisor(getServiceadvisor());
					setHidserviceadvisor(getHidserviceadvisor());
					setInsurancesurvivor(getInsurancesurvivor());
					setHidinsurancesurvivor(getHidinsurancesurvivor());
					setReferencedby(getReferencedby());
					setHidreferencedby(getHidreferencedby());
					setServicepackage(getServicepackage());
					setHidservicepackage(getHidservicepackage());
					setTeammaster(getTeammaster());
					setHidteammaster(getHidteammaster());
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
//			System.out.println(mode);
				int status=gatedao.delete(getDocno(),getBrchName(),getMode(),session,request);
				if(status>0){
					setGroup(getGroup());
					setRegexpirydate(sqlregexpirydate.toString());
					setHidcmbcolor(getCmbcolor());
					setCmbpriority(getCmbpriority());
					setHidcmbpriority(getCmbpriority());
					setDate(sqldate.toString());
					setEstdate(sqlestdate.toString());
					setPolicedate(sqlpolicedate.toString());
					setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());
					setHidcmbyom(getCmbyom());
					setHidcmbrepairtype(getCmbrepairtype());
					setHidcmbfaulttype(getCmbfaulttype());
					setHidcmbinsutype(getCmbinsutype());
					setHidcmbfueltype(getCmbfueltype());
					setHidchkappr(getApprvalchk());
					setHidchkclname(getClname());
					setChkbjob(getBackjob());
					setChkexces(getExcesschk());
					setRefno(getRefno());
					setHidluxury(getLuxury());
					setHidmarketingperson(getHidmarketingperson());
					setMarketingperson(getMarketingperson());
					setServiceadvisor(getServiceadvisor());
					setHidserviceadvisor(getHidserviceadvisor());
					setInsurancesurvivor(getInsurancesurvivor());
					setHidinsurancesurvivor(getHidinsurancesurvivor());
					setReferencedby(getReferencedby());
					setHidreferencedby(getHidreferencedby());
					setServicepackage(getServicepackage());
					setHidservicepackage(getHidservicepackage());
					setTeammaster(getTeammaster());
					setHidteammaster(getHidteammaster());
					setHidchkvirtual(getChkvirtual());
					setChkvirtual(getChkvirtual());
					setMsg("Successfully Deleted");
					return "success";
				}
				else{
					setGroup(getGroup());
					setRegexpirydate(sqlregexpirydate.toString());
					setHidcmbcolor(getCmbcolor());
					setCmbpriority(getCmbpriority());
					setHidcmbpriority(getCmbpriority());
					setDate(sqldate.toString());
					setEstdate(sqlestdate.toString());
					setPolicedate(sqlpolicedate.toString());
					setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());
					setHidcmbyom(getCmbyom());
					setHidcmbrepairtype(getCmbrepairtype());
					setHidcmbfaulttype(getCmbfaulttype());
					setHidcmbinsutype(getCmbinsutype());
					setHidcmbfueltype(getCmbfueltype());
					setHidchkappr(getApprvalchk());
					setHidchkclname(getClname());
					setChkbjob(getBackjob());
					setChkexces(getExcesschk());
					setRefno(getRefno());
					setHidluxury(getLuxury());
					setHidmarketingperson(getHidmarketingperson());
					setMarketingperson(getMarketingperson());
					setServiceadvisor(getServiceadvisor());
					setHidserviceadvisor(getHidserviceadvisor());
					setInsurancesurvivor(getInsurancesurvivor());
					setHidinsurancesurvivor(getHidinsurancesurvivor());
					setReferencedby(getReferencedby());
					setHidreferencedby(getHidreferencedby());
					setServicepackage(getServicepackage());
					setHidservicepackage(getHidservicepackage());
					setTeammaster(getTeammaster());
					setHidteammaster(getHidteammaster());
					setHidchkvirtual(getChkvirtual());
					setChkvirtual(getChkvirtual());
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		}
	return "fail";
	}

	private void setData(int insertval, Date sqldate) {
		// TODO Auto-generated method stub
		
	}
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  int doc=Integer.parseInt(request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString());
		  String brhid=request.getParameter("branch")==null || request.getParameter("branch")==""?session.getAttribute("BRANCHID").toString():request.getParameter("branch");
		  String printsource=request.getParameter("printsource")==null || request.getParameter("printsource")==""?"":request.getParameter("printsource");
		  String mail=request.getAttribute("mail")==null?"":request.getAttribute("mail").toString();
		  String  formcode= request.getParameter("formdetailcode");
		  if(mail.equalsIgnoreCase("1")){
			  doc=Integer.parseInt(request.getAttribute("gatedocno")==null?"":request.getAttribute("gatedocno").toString());
			  brhid=request.getAttribute("branch")==null?"":request.getAttribute("branch").toString();
			  formcode="GIP";
		  }
		  param = new HashMap();
		 
		
		 bean=gatedao.getPrint(doc,request,formcode);
		 
		 System.out.println("IN GATEINPASS PRINT");
	  
		 
		setLblcompanyname("VEHICLE GATE PASS");
	    setCmbpriority(bean.getCmbpriority());
		setLblbranch(bean.getLblbranch());
	    setLblcompname(bean.getLblcompname());
	    setLblcompaddress(bean.getLblcompaddress());
		setLblcomptel(bean.getLblcomptel());
		setLblcompfax(bean.getLblcompfax());
	    setLbllocation(bean.getLbllocation());
	    setLblrvehicleno(bean.getLblrvehicleno());
	    setLbldate(bean.getLbldate());
		setLbljobno(bean.getLbljobno());
		setLbltype(bean.getLbltype());
		setLblcustomer( bean.getLblcustomer());
		setLblperson(bean.getLblperson());
		setLblchasisno(bean.getLblchasisno());
		setLblengineno(bean.getLblengineno());
		setLblmodel(bean.getLblmodel());
		setLbltodat(bean.getLbltodat());
		 ArrayList<String> uploadpicsarray=gatedao.getUploadPicsData(doc);	    	
        if(commonDAO.getPrintPath(formcode).contains(".jrxml")==true)
		   {
		     HttpServletResponse response = ServletActionContext.getResponse();
               Connection conn = null;
		    			 try {
		    				 conn = connDAO.getMyConnection();
		    				 Statement stmt = conn.createStatement ();
		    				 String path1="";
		    				 String strsql2="select imgpath from my_brch where doc_no='"+brhid+"'";          
				    	     ResultSet rs2=stmt.executeQuery(strsql2);          
				    	     while(rs2.next()){         
				    	    	 path1=rs2.getString("imgpath");         
				    	     }
				    	     
		    				 String imgpath=request.getSession().getServletContext().getRealPath(path1);     
		    			     imgpath=imgpath.replace("\\", "\\\\");
							 String imgpathroyal=request.getSession().getServletContext().getRealPath("/icons/royallogo.png");  
		    			     imgpathroyal=imgpathroyal.replace("\\", "\\\\");
		    			     String imgpathroyaldesign=request.getSession().getServletContext().getRealPath("/icons/designpattern.png");  
		    			     imgpathroyaldesign=imgpathroyaldesign.replace("\\", "\\\\");
		    			     String watermarkroyal=request.getSession().getServletContext().getRealPath("/icons/watermarkroyal.png");
						     watermarkroyal=watermarkroyal.replace("\\", "\\\\");
						     String decl_apex=request.getSession().getServletContext().getRealPath("/icons/pic1.png");
						     decl_apex=decl_apex.replace("\\", "\\\\");
						     String add_termsapex=request.getSession().getServletContext().getRealPath("/icons/add_terms.png");
						     add_termsapex=add_termsapex.replace("\\", "\\\\");
		    			     
		    			     String carimg=request.getSession().getServletContext().getRealPath("/icons/carinoutimg.png");
		    			     carimg=carimg.replace("\\", "\\\\");
		    			     String strgetvehimg="select coalesce(vehimage,'') vehimage from ws_gateinpass where doc_no="+doc;
//		    			     System.out.println(strgetvehimg);
		    			     ResultSet rsvehimg=stmt.executeQuery(strgetvehimg);
		    			     String caroutimage="";
		    			     while(rsvehimg.next()){
		    			    	 caroutimage=rsvehimg.getString("vehimage");
		    			     }
//		    			     System.out.println("Image:"+caroutimage);
		    			     String carout="";
		    			     if(caroutimage.trim().equalsIgnoreCase("")){
		    			    	 carout=request.getSession().getServletContext().getRealPath("/icons/carout.png");
		    			     }
		    			     else{
		    			    	 //carout=request.getSession().getServletContext().getRealPath("/attachment"+caroutimage.split("attachment")[1]);
		    			    	 carout=caroutimage;
		    			     }
//		    			     System.out.println("Car OUT:"+carout);
		    			     carout=carout.replace("\\", "\\\\");

		    			     String checkbox=request.getSession().getServletContext().getRealPath("/icons/checkedbox.png");
		    			     checkbox=checkbox.replace("\\", "\\\\");
//		    			     System.out.println("Checkbox:"+checkbox);
		    			     String uncheckbox=request.getSession().getServletContext().getRealPath("/icons/uncheckedbox.png");   
		    			     uncheckbox=uncheckbox.replace("\\", "\\\\");   
		    			     
		    				 String repairtype="",invstatus="",fuellevel="",invdoc="",repairdoc="";
                             String resql="select name,fuel fuellevel from ws_gateinpass ws left join ws_gartype r on r.row_no=ws.repairtype where ws.doc_no='"+docno+"'";
                             //System.out.println("---resql----"+resql);
		    				 ResultSet rs = stmt.executeQuery(resql);
		    				 while(rs.next()){   
		    					 repairtype=rs.getString("name");  
		    					 fuellevel=rs.getString("fuellevel");
		    				 }
		    				 
		    				
		    				 
		    				 
		    				 String strrep="select rep.name,rep.row_no docno,coalesce(grep.doc_no,0) grepdocno from ws_gartype rep left join "+
		    				 " ws_giprepairtype grep on (rep.row_no=grep.repairdocno and grep.gipdocno="+docno+") group by rep.row_no";
		    				 System.out.println("strrep==="+strrep);
		    				 ResultSet rsrep=stmt.executeQuery(strrep);
		    				 while(rsrep.next()){
		    					 repairtype=rsrep.getString("name");
		    					 int repdocno=rsrep.getInt("grepdocno");
		    					 repairdoc=rsrep.getString("docno");
		    					 System.out.println(repairtype+"::"+repdocno+"::"+(repairtype.equalsIgnoreCase("Maintenance") && repdocno>0));
		    					 if(repairtype.equalsIgnoreCase("Modification") && repdocno>0){
			    					 param.put("repaccident", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Modification") && repdocno==0){    
			    				 	 param.put("repaccident", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Maintenance")  && repdocno>0){
			    					 param.put("maintenance", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Maintenance") && repdocno==0){
			    				 	 param.put("maintenance", uncheckbox); 
			    				 }
			    			     
			    				 if(repairtype.equalsIgnoreCase("Bodyshop") && repdocno>0){
			    					 param.put("bodyshop", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Bodyshop") && repdocno==0){
			    				 	 param.put("bodyshop", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Detailing") && repdocno>0){
			    					 param.put("detailing", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Detailing") && repdocno==0){
			    				 	 param.put("detailing", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Denting") && repdocno>0){
			    					 param.put("denting", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Denting") && repdocno==0){
			    				 	 param.put("denting", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("All") && repdocno>0){
			    					 param.put("repall", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("All") && repdocno==0){
			    					 param.put("repall", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("electrical") && repdocno>0){
			    					 param.put("repdenting", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("electrical") && repdocno==0){
			    					 param.put("repdenting", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Fabrication") && repdocno>0){    
			    					 param.put("repmech", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Fabrication") && repdocno==0){
			    					 param.put("repmech", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Mechanical") && repdocno>0){  
			    					 param.put("repmechanical", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Mechanical") && repdocno==0){
			    					 param.put("repmechanical", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Others") && repdocno>0){
			    					 param.put("repothers", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Others") && repdocno==0){
			    					 param.put("repothers", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Service") && repdocno>0){
			    					 param.put("repquick", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Service") && repdocno==0){
			    					 param.put("repquick", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Servc & Accident") && repdocno>0){
			    					 param.put("repseraccident", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Servc & Accident") && repdocno==0){
			    					 param.put("repseraccident", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Servc & Mech") && repdocno>0){
			    					 param.put("repsermech", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Servc & Mech") && repdocno==0){
			    					 param.put("repsermech", uncheckbox); 
			    				 }
			    				 
			    				 if(repairtype.equalsIgnoreCase("Service") && repdocno>0){
			    					 param.put("repservice", checkbox); 
			    				 }else if(repairtype.equalsIgnoreCase("Service") && repdocno==0){
			    					 param.put("repservice", uncheckbox); 
			    				 }
			    				 
			    				 
			    				 
			    				
			    				 
			    				 
			    				 
		    				 }
		    				 
		    				 param.put("repdoc5", uncheckbox); 
		    				 param.put("repdoc6", uncheckbox); 
		    				 param.put("repdoc7", uncheckbox); 
		    				 param.put("repdoc8", uncheckbox); 
		    				 param.put("repdoc9", uncheckbox);
		    				 param.put("repdoc10", uncheckbox); 
		    				 param.put("repdoc11", uncheckbox); 
		    				 param.put("repdoc12", uncheckbox); 
		    				 param.put("repdoc13", uncheckbox); 
		    				 param.put("repdoc14", uncheckbox); 
		    				
		    				 
		    				 
		    				 String strrepapex="select rep.row_no docno from ws_gartype rep left join  ws_giprepairtype grep on rep.row_no=grep.repairdocno  where grep.gipdocno="+docno+"";
				    				 ResultSet rsrepapex=stmt.executeQuery(strrepapex);
				    				 while(rsrepapex.next()){
				    					
				    					 repairdoc=rsrepapex.getString("docno");
				    					 if(repairdoc.equalsIgnoreCase("5")){  
					    					 param.put("repdoc5", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("6")){  
					    					 param.put("repdoc6", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("7")){  
					    					 param.put("repdoc7", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("8")){  
					    					 param.put("repdoc8", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("9")){  
					    					 param.put("repdoc9", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("10")){  
					    					 param.put("repdoc10", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("11")){  
					    					 param.put("repdoc11", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("12")){  
					    					 param.put("repdoc12", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("13")){  
					    					 param.put("repdoc13", checkbox); 
					    				 }if(repairdoc.equalsIgnoreCase("14")){  
					    					 param.put("repdoc14", checkbox); 
					    				 }
		    				 
				    				 }
		    				 //System.out.println("accidental"+repairtype);
		    				  
		    				 
//		    				 System.out.println("Fuel Level");
		    				 
		    				 if(fuellevel.equalsIgnoreCase("0.000")){  
		    					 param.put("fl1", checkbox);   
		    				 }else{
		    					 param.put("fl1", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("0.125")){  
		    					 param.put("fl2", checkbox); 
		    				 }else{
		    					 param.put("fl2", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("0.250")){     
		    					 param.put("fl3", checkbox); 
		    				 }else{
		    					 param.put("fl3", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("0.375")){  
		    					 param.put("fl4", checkbox); 
		    				 }else{
		    					 param.put("fl4", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("0.500")){     
		    					 param.put("fl5", checkbox); 
		    				 }else{
		    					 param.put("fl5", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("0.625")){     
		    					 param.put("fl6", checkbox); 
		    				 }else{
		    					 param.put("fl6", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("0.750")){     
		    					 param.put("fl7", checkbox); 
		    				 }else{
		    					 param.put("fl7", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("0.875")){     
		    					 param.put("fl8", checkbox); 
		    				 }else{
		    					 param.put("fl8", uncheckbox); 
		    				 }
		    				 if(fuellevel.equalsIgnoreCase("1.000")){     
		    					 param.put("fl9", checkbox); 
		    				 }else{
		    					 param.put("fl9", uncheckbox); 
		    				 }
		    				 
//		    				 System.out.println("INVENTORY STATUS");
		    				 
		    				 param.put("is1", uncheckbox); 
		    				 param.put("is2", uncheckbox); 
		    				 param.put("is3", uncheckbox); 
		    				 param.put("is4", uncheckbox); 
		    				 param.put("is5", uncheckbox); 
		    				 param.put("is6", uncheckbox); 
		    				 param.put("is7", uncheckbox); 
		    				 param.put("is8", uncheckbox); 
		    				 param.put("is9", uncheckbox); 
		    				 param.put("isdoc1", uncheckbox); 
		    				 param.put("isdoc2", uncheckbox); 
		    				 param.put("isdoc3", uncheckbox); 
		    				 param.put("isdoc4", uncheckbox); 
		    				 param.put("isdoc5", uncheckbox); 
		    				 param.put("isdoc6", uncheckbox); 
		    				 param.put("isdoc7", uncheckbox); 
		    				 param.put("isdoc8", uncheckbox); 
		    				 param.put("isdoc9", uncheckbox);
		    				 param.put("isdoc10", uncheckbox); 
		    				 param.put("isdoc11", uncheckbox); 
		    				 param.put("isdoc12", uncheckbox); 
		    				 param.put("isdoc13", uncheckbox); 
		    				 param.put("isdoc14", uncheckbox); 
		    				 
		    				 String invsql="select m.name invstatus,m.sr_no  from gl_inspection m left join ws_gipinventory i on (m.sr_no=i.invdocno and i.gipdocno="+doc+") where m.status=3 and i.value=1";
//		    				 System.out.println("---invsql----"+invsql);
		    				 ResultSet rs3 = stmt.executeQuery(invsql);   
		    				 while(rs3.next()){   
		    					 invstatus=rs3.getString("invstatus");
		    					 invdoc=rs3.getString("sr_no").trim(); 

		    					 if(invstatus.equalsIgnoreCase("Additional tyres")){  
			    					 param.put("is1", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("Fire Cylinder / Extinguisher")){  
			    					 param.put("is2", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("Salik")){  
			    					 param.put("is3", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("Cighar Lighter / ASHTRY")){  
			    					 param.put("is4", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("Toolkit")){  
			    					 param.put("is5", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("Wheel Cap")){  
			    					 param.put("is6", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("CD Player")){  
			    					 param.put("is7", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("Antenna")){  
			    					 param.put("is8", checkbox); 
			    				 }
			    				 
			    				 if(invstatus.equalsIgnoreCase("Jack")){  
			    					 param.put("is9", checkbox); 
			    				 }
			    				 
			    				 
			    				 
			    				 if(invdoc.equalsIgnoreCase("1")){  
			    					 param.put("isdoc1", checkbox); 
			    				 }
			    				 if(invdoc.equalsIgnoreCase("2")){  
			    					 param.put("isdoc2", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("3")){  
			    					 param.put("isdoc3", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("4")){  
			    					 param.put("isdoc4", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("5")){  
			    					 param.put("isdoc5", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("6")){  
			    					 param.put("isdoc6", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("7")){  
			    					 param.put("isdoc7", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("8")){  
			    					 param.put("isdoc8", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("9")){  
			    					 param.put("isdoc9", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("10")){  
			    					 param.put("isdoc10", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("11")){  
			    					 param.put("isdoc11", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("12")){  
			    					 param.put("isdoc12", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("13")){  
			    					 param.put("isdoc13", checkbox); 
			    				 }if(invdoc.equalsIgnoreCase("14")){  
			    					 param.put("isdoc14", checkbox); 
			    				 }
		    				 }
		    				 
		    				 
//		    				System.out.println("INVENTORY STATUS");    
		    				int uploadpic1status=0,uploadpic2status=0,uploadpic3status=0,uploadpic4status=0,uploadpic5status=0,
			    			        	uploadpic6status=0,uploadpic7status=0,uploadpic8status=0;  
			    			        for(int i=0,j=1;i<uploadpicsarray.size();i++,j++){
			    			        	if(j<=8){
			    			        		param.put("uploadpic"+j,uploadpicsarray.get(i));    
			    			        		if(j==1){
			    			        			uploadpic1status=1;
			    			        		}
			    			        		else if(j==2){
			    			        			uploadpic2status=1;
			    			        		}
			    			        		else if(j==3){
			    			        			uploadpic3status=1;
			    			        		}
			    			        		else if(j==4){
			    			        			uploadpic4status=1;
			    			        		}
			    			        		else if(j==5){
			    			        			uploadpic5status=1;
			    			        		}
			    			        		else if(j==6){
			    			        			uploadpic6status=1;
			    			        		}
			    			        		else if(j==7){
			    			        			uploadpic7status=1;
			    			        		}
			    			        		else if(j==8){
			    			        			uploadpic8status=1;
			    			        		}
			    			        		
			    			        	}
			    			        }
			    			        
			    			        param.put("uploadpic1status",uploadpic1status+"");
			    			        param.put("uploadpic2status",uploadpic2status+"");
			    			        param.put("uploadpic3status",uploadpic3status+"");
			    			        param.put("uploadpic4status",uploadpic4status+"");
			    			        param.put("uploadpic5status",uploadpic5status+"");
			    			        param.put("uploadpic6status",uploadpic6status+"");
			    			        param.put("uploadpic7status",uploadpic7status+"");
			    			        param.put("uploadpic8status",uploadpic8status+""); 
		    				
						    param.put("compaddress",bean.getLblcompaddress());
						    param.put("comptel",bean.getLblcomptel());
						    param.put("compfax",bean.getLblcompfax());
						    param.put("branch", bean.getLblbranch());
						    param.put("location", bean.getLbllocation());      
		    				param.put("docno", doc); 
		    			    param.put("compname",bean.getLblcompname());  
		    			    param.put("imgpath", imgpath);
		    			    param.put("decl_apex", decl_apex);
		    			    param.put("add_terms", add_termsapex);

							param.put("imgpathroyal", imgpathroyal);
                            param.put("imgpathroyaldesign", imgpathroyaldesign);
		    			    param.put("carimg", carimg);
		    			    param.put("watermark", watermarkroyal);
//		    			    System.out.println("INVENTORY STATUS");  
		    			    param.put("carout", carout);
		    			    param.put("puser", session.getAttribute("USERNAME"));
//		    			    System.out.println("INVENTORY STATUS");         
		    			
		    			       			      
		    			      
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath(formcode)));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);
		        
		        if(mail.equalsIgnoreCase("1")){
		        	generateReportEmailCustom(response, param, jasperReport, conn,doc+"",session,brhid,request);
		        }
		        else if(printsource.equalsIgnoreCase("APP")){
		        	generateReportPDF(response, param, jasperReport, conn);
		        	String remail="",bccemail="",print="1",subject="Workshop GIP";
		        	//getting company corresponding config
			        String  strmailconfig="select method from gl_config where field_nme='GIPMail'";
			        ResultSet rsmailconfig=conn.createStatement().executeQuery(strmailconfig);
			        int mailconfig=0;
			        while(rsmailconfig.next()){
			        	mailconfig=rsmailconfig.getInt("method");
			        }
			        if(mailconfig==1){
			        	//PAL
			        	subject="PAL Auto - Vehicle Acknowledgement";
			        }
			        String strgetemail="select coalesce(if(ac.mail1='',gip.email,ac.mail1),gip.email) clientemail from ws_gateinpass gip left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM' where gip.doc_no="+doc;
			        ResultSet rsgetemail=conn.createStatement().executeQuery(strgetemail);
			        while(rsgetemail.next()){
			        	remail=rsgetemail.getString("clientemail");
			        }
			        if(!remail.trim().equalsIgnoreCase("")){
			        	generateReportEmail(param,jasperReport, conn,remail,bccemail,print,subject,doc+"",session);
			        }
		        }
		        else{
		        	generateReportPDF(response, param, jasperReport, conn);
		        }
		        
		        } catch (Exception e) {
		          e.printStackTrace();
		        }
		    	  finally{
		    	  conn.close();
		    	}

		    	}

		    		return "print";
		    		
		    	}
		    	private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		    				  byte[] bytes = null;
		    				  bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		    				  resp.reset();
		    					resp.resetBuffer();
		    					
		    					resp.setContentType("application/pdf");
		    					resp.setContentLength(bytes.length);
		    					ServletOutputStream ouputStream = resp.getOutputStream();
		    					ouputStream.write(bytes, 0, bytes.length);
		    					ouputStream.close();
		    					ouputStream.flush();
		    	     
		    	}
		    	
		    	private void generateReportEmail (Map parameters, JasperReport jasperReport, Connection conn, String remail,String bccemail, String print, String subject,String insp, HttpSession session)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
			  		  byte[] bytes = null;
			          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
			          EmailProcess ep=new EmailProcess();
			      	Statement stmtrr=conn.createStatement();
			      //getting company corresponding config
			        String  strmailconfig="select method from gl_config where field_nme='GIPMail'";
			        ResultSet rsmailconfig=conn.createStatement().executeQuery(strmailconfig);
			        int mailconfig=0;
			        while(rsmailconfig.next()){
			        	mailconfig=rsmailconfig.getInt("method");
			        }  
			      	String fileName="",path="", formcode="GIP",filepath="",path1=""; 
			      	String host="", port="", userName="", password="", recipient="", message="please find the attached Workshop GIP details",docnos="1";
			      	if(mailconfig==1){
			      		//PAL
			      		message="Dear Sir/Madam,<br><br>Please find attached your vehicle acknowledgment slip.<br>Have a nice day!<br><br><br>Regards,<br><br>Team PAL Auto";
			      	}
			      	String strSql1 = "select imgPath from my_comp";

			    		ResultSet rs1 = stmtrr.executeQuery(strSql1);
			    		while(rs1.next ()) {
			    			path1=rs1.getString("imgPath");
			    		}
			    		path=path1.replace("\\", "/");
			    		String userid=session.getAttribute("USERID")==null?"1":session.getAttribute("USERID").toString();
			    		String strSql3 = "select mail,mailpass,smtpserver,smtphostport from my_user where doc_no='"+userid+"'";
			  		ResultSet rs3 = stmtrr.executeQuery(strSql3);
			  		while(rs3.next ()) {
			  			userName=rs3.getString("mail");
			  			port=rs3.getString("smtphostport");
			  			host=rs3.getString("smtpserver");
			  			password=ClsEncrypt.getInstance().decrypt(rs3.getString("mailpass"));
			  		}
			    		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
			  		java.util.Date date = new java.util.Date();
			  		String currdate=dateFormat.format(date);
			  		
			  		
			  		DateFormat dateFormat2 = new SimpleDateFormat("dd_MM_yyyy");
			  		java.util.Date date2 = new java.util.Date();
			  		String currdate2=dateFormat2.format(date2);
			  		//subject="Fleet status Epic Rent a car "+currdate2+" 8:00";
			  		subject=subject+"  "+currdate2;
			    		fileName = "WorkshopGIP"+currdate+".pdf";
			    		filepath=path+ "/attachment/"+formcode+"/"+fileName;

			    		File dir = new File(path+ "/attachment/"+formcode); 
			    		dir.mkdirs();
			    		
			    		CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
			    		
			    		stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
//			    		System.out.println("CALL fileAttach");
			    		stmtAttach.setString(1,"GIP");
			    		stmtAttach.setString(2,insp);
			    		stmtAttach.setString(3,"1");
			    		stmtAttach.setString(4,"1");
			    		stmtAttach.setString(5,path+ "/attachment/"+formcode+"/"+fileName);
			    		stmtAttach.setString(6,fileName);
			    		stmtAttach.setString(7,"print");
			    		stmtAttach.setString(8,"1");
			    		stmtAttach.executeQuery();
			    		int no=stmtAttach.getInt("srNo");
			    		
			    		FileOutputStream fos = new FileOutputStream(filepath);
			      	fos.write(bytes);
			      	fos.flush();  
			      	fos.close();
			      	
			      	File saveFile=new File(filepath);
			  		SendEmailAction sendmail= new SendEmailAction();
			  		//String[] remails=remail.split(",");
			  		//System.out.println(userName+"::"+password);
			  		ep.sendEmailwithpdfBCC(host, port, userName, password,remail, "",bccemail,subject, message, saveFile,docnos);
			             
			    }
		    	private void generateReportEmailCustom(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn,String docno,HttpSession session,String brhid,HttpServletRequest request)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		    		
		    		try{
		    			byte[] bytes = null;
		    		    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		    		    //System.out.println("Bytes:"+bytes.toString());
		    		    //System.out.println(Arrays.toString(bytes));
		    		  	Statement stmt=conn.createStatement();
		    		  	String fileName="",path="", formcode="GIP",filepath=""; 
		    		  	//Deleting Existing Internal Attachments
		    		  	String strgetattach="select path from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999";
		    		  	ResultSet rsgetattach=stmt.executeQuery(strgetattach);
		    		  	while(rsgetattach.next()){
		    		  		String deletepath=rsgetattach.getString("path");
		    		  		File deletefile = new File(deletepath);
		    		  		deletefile.delete();
		    		  	}
		    		  	int deleteFileEntry=stmt.executeUpdate("delete from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999");
		    		  	
		    		  	String host="", port="", userName="", password="", recipient="", message="",docnos="1";
		    		  	String strSql1 = "select imgPath from my_comp";
		    			ResultSet rs1 = stmt.executeQuery(strSql1);
		    			while(rs1.next ()) {
		    				path=rs1.getString("imgPath");
		    			}
		    			//path=path.replace("\\", "/");
		    			String srno="";
		    			String strSql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"'";
		    			ResultSet rs = stmt.executeQuery(strSql);
		    			while(rs.next()) {
		    				srno=rs.getString("srno");
		    			}
		    				
		    			fileName = formcode+"-"+docno+"-"+srno+".pdf";
		    			filepath=path+ "\\attachment\\"+formcode+"\\"+fileName;

		    			File dir = new File(path+ "\\attachment\\"+formcode); 
		    			dir.mkdirs();
		    			JasperPrint print = JasperFillManager.fillReport(jasperReport, parameters);
		    		  	JasperExportManager.exportReportToPdfFile(print, filepath);	
		    			
		    		    CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
		    			stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
		    			stmtAttach.setString(1,formcode);
		    			stmtAttach.setString(2,docno);
		    			stmtAttach.setString(3,session.getAttribute("BRANCHID")==null?brhid:session.getAttribute("BRANCHID").toString());
		    			stmtAttach.setString(4,session.getAttribute("USERNAME").toString());
		    			stmtAttach.setString(5,path+"\\attachment\\"+formcode+"\\"+fileName);
		    			stmtAttach.setString(6,fileName);
		    			stmtAttach.setString(7,"");
		    			stmtAttach.setString(8,"999");
		    			stmtAttach.executeQuery();
		    			int no=stmtAttach.getInt("srNo");
		    			if(no<=0){
		    				System.out.println("Insert Error");
		    			}
		    		}
		    		catch(Exception e){
		    			e.printStackTrace();
		    		}
		    		
		    }

	 	
}