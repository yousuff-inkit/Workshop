package com.workshop.carfaregateinpassmaster;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
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
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
import com.workshop.gateinpass.ClsGateInPassBean;
@SuppressWarnings("serial")

public class ClsCarfareGateInPassAction extends ActionSupport{
    
	ClsCarfareGateInPassDAO gatedao= new ClsCarfareGateInPassDAO();
	ClsCarfareGateInPassBean bean=new ClsCarfareGateInPassBean();
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	//save
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
						String strSql = "select w.regexpirydate,w.colorid,coalesce(grp.gname) gname,w.marketingperson marketingpersonid, w.serviceadvisor serviceadvisorid, "+
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
				System.out.println("============="+getGridlength());
				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("test"+i)[0];
					
					complaintarray.add(temp);
				}
				int insertval=gatedao.insert(sqldate,getDocno(),getCldocno(),getClname(),getClientid(),getDescription(),
				getApprvalchk(),getBackjob(),getVehusername(),getVehusermobile(),getVehuseremail(),getVehuserothers(),getVehregno(),getVehplatecode(),
				getCmbbrand(),getCmbmodel(),getCmbyom(),getVehothers(),getVehkm(),getCmbfueltype(),getCmbrepairtype(),sqlestdate,getEsttime(),getMaintenanceremarks(),
				getPolicereport(),sqlpolicedate,getPolicestation(),getCmbinsutype(),getCmbfaulttype(),getClaim(),getLpo(),getLpoamount()
				,getExcesschk(),getExcessamount(),complaintarray,session,request,mode,getFormdetailcode(),getBrchName(),
				getRefno(),getMovno(),getLuxury(),getHidmarketingperson(),getHidserviceadvisor(),getHidinsurancesurvivor(),getHidreferencedby(),
				getHidservicepackage(),getHidteammaster(),getCmbpriority(),getCmbcolor(),sqlregexpirydate);
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
					System.out.println("CmbFuelType:"+getCmbfueltype());
					System.out.println("HidCmbFuelType:"+getHidcmbfueltype());
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
				int status=gatedao.edit(sqldate,getDocno(),getVocno(),getCldocno(),getClname(),getClientid(),getDescription(),
	             getApprvalchk(),getBackjob(),getVehusername(),getVehusermobile(),getVehuseremail(),getVehuserothers(),getVehregno(),getVehplatecode(),
	             getCmbbrand(),getCmbmodel(),getCmbyom(),getVehothers(),getVehkm(),getCmbfueltype(),getCmbrepairtype(),sqlestdate,getEsttime(),getMaintenanceremarks(),
	             getPolicereport(),sqlpolicedate,getPolicestation(),getCmbinsutype(),getCmbfaulttype(),getClaim(),getLpo(),getLpoamount()
	             ,getExcesschk(),getExcessamount(),complaintarray,session,request,mode,getFormdetailcode(),getBrchName(),getRefno(),
	             getMovno(),getLuxury(),getHidmarketingperson(),getHidserviceadvisor(),getHidinsurancesurvivor(),getHidreferencedby(),
					getHidservicepackage(),getHidteammaster(),getCmbpriority(),getCmbcolor(),sqlregexpirydate);
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
			System.out.println(mode);
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
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		 String  formcode= request.getParameter("formdetailcode");
		
		 bean=gatedao.getPrint(doc,request,formcode);
		 
		 System.out.println("hiiiiiiiii");
	  
		 
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
				
        if(commonDAO.getPrintPath(formcode).contains(".jrxml")==true)
		   {
		     HttpServletResponse response = ServletActionContext.getResponse();
               Connection conn = null;
		    			 try {
		    				 
		    				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
		    			     imgpath=imgpath.replace("\\", "\\\\");
		    			     String carimg=request.getSession().getServletContext().getRealPath("/icons/carinoutimg.png");
		    			     carimg=carimg.replace("\\", "\\\\");
		    				    param = new HashMap();
		    			                conn = connDAO.getMyConnection();
		    			        param.put("docno", doc); 
		    			        param.put("compname",bean.getLblcompname());
		    			        param.put("headerimg", imgpath);
		    			        param.put("carimg", carimg);
		    			        param.put("puser", session.getAttribute("USERNAME"));
		    			            
		    			
		    			       			      
		    			      
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath(formcode)));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);
		        generateReportPDF(response, param, jasperReport, conn);
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


	 	
}