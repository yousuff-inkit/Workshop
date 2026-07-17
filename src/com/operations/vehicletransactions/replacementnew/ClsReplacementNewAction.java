
package com.operations.vehicletransactions.replacementnew;

import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.operations.vehicletransactions.replacement.ClsReplacementBean;
import com.operations.vehicletransactions.replacement.ClsReplacementDAO;


public class ClsReplacementNewAction {
	ClsReplacementNewDAO replacementDAO=new ClsReplacementNewDAO();
	ClsReplacementNewBean bean=new ClsReplacementNewBean();
	ClsCommon objcommon=new ClsCommon();
	private String brchName;
	private int docno;
	private String date;
	private String hiddate;
	private String refdate;
	private String hidrefdate;
	private String refno;
	private String refvocno;
	private String status;
	private String cmbagmtbranch;
	private String hidcmbagmtbranch;
	private String refname;
	private String txtfleetno;
	private String txtfleetname;
	private String dateout;
	private String hiddateout;
	private String timeout;
	private String hidtimeout;
	private double outkm;
	private String cmbfuel;
	private String hidcmbfuel;
	private String cmbrentaltype;
	private String hidcmbrentaltype;
	private String txtbranch;
	private String hidtxtbranch;
	private String txtlocation;
	private String hidtxtlocation;
	private String cmbtrreason;
	private String hidcmbtrreason;
	private String cmbreplacetype;
	private String hidcmbreplacetype;
	private String user;
	private String hiduser;
	private String infleettrancode;
	private String description;
	
	//At Branch In Info
			private String hidchkatbranch,chkatbranch,cmbinbranch,hidcmbinbranch,cmbinlocation,hidcmbinlocation,inuser,hidinuser,atbranchdatein,hidatbranchdatein,atbranchtimein,hidatbranchtimein,atbranchkmin,
			cmbatbranchinfuel,hidcmbatbranchinfuel;
			
			//Atbranch out Info
			private String atbranchoutfleetno,atbranchoutfleetname,hidatbranchoutbranch,hidoutbranchuser,hidatbranchoutuser,atbranchoutbranch,atbranchoutlocation
			,atbranchoutuser,atbranchoutdate,hidatbranchoutdate,atbranchouttime,hidatbranchouttime,atbranchoutkm,cmbatbranchoutfuel,hidcmbatbranchoutfuel,hidatbranchoutlocation;
			

		//Collection  Out Info
		private String hidchkcollection,chkcollection,coloutfleetno,coloutfleetname,hidcoloutbranch,hidcoloutlocation,hidcoloutuser,coloutbranch,coloutlocation,
		coloutuser,coloutdate,hidcoloutdate,colouttime,hidcolouttime,coloutkm,cmbcoloutfuel,hidcmbcoloutfuel;
		
		
		//Collection Collect Info
		
		private String colcollectdriver,hidcolcollectdriver,colcollectdate,hidcolcollectdate,colcollecttime,hidcolcollecttime,colcollectkm,cmbcolcollectfuel,hidcmbcolcollectfuel,chkcollect,hidchkcollect;
		
		//Collection Delivery Info
		private String coldeldriver,hidcoldeldriver,coldeliveryto,coldeldate,hidcoldeldate,coldeltime,hidcoldeltime,coldelkm,cmbcoldelfuel,hidcmbcoldelfuel,chkdelivery,hidchkdelivery;
		
		
		//Collection In Info
		
		private String cmbcolinbranch,hidcmbcolinbranch,cmbcolinlocation,hidcmbcolinlocation,colindate,hidcolindate,colintime,hidcolintime,colinkm,cmbcolinfuel,hidcmbcolinfuel;
		
		
		//Other Info
		
		private String mode,msg,deleted,formdetailcode;

		
		///Print Info
		
		//------------------------------------------------------------------

		private String companyname,address,mobileno,fax,location,barnchval;

		private String brwithcompany,vrano,mtime,pfleetno,pfuel,popened,pclient,clientacno,agmt,pdocno,pdate,pregno,vradate,dtimes,replaced,reptype,pkm,poutdate,pdelivery;

		//in

		private String inbrwithcompany,invehdate,invehtime,invehkm,invehfuel,invehreason;
		//out

		private String newbrwithcompany,newvehoutdate,newvehouttime,newvehfleet,newvehregno,newvehkm,newvehfuel;

		//del
		private String delbrwithcompany,deldate,deltime,delfleet,delregno,delkm,delfuel;

		//col

		private String colbrwithcompany,coldate,coltime,colfleet,colregno,colkm,colfuel;

		private String lbldelivery,lblcollection,lblrlocation;

		private String lblinfleetname,lbloutfleetname,lbldelfleetname,lblcolfleetname;

		private String lblinlocation,lbloutlocation,lbldeldriver,lblcoldriver,lbldescription,lbldrivenby;
		
		
		
		
		public String getBrchName() {
			return brchName;
		}


		public void setBrchName(String brchName) {
			this.brchName = brchName;
		}


		public String getCmbagmtbranch() {
			return cmbagmtbranch;
		}


		public void setCmbagmtbranch(String cmbagmtbranch) {
			this.cmbagmtbranch = cmbagmtbranch;
		}


		public String getHidcmbagmtbranch() {
			return hidcmbagmtbranch;
		}


		public void setHidcmbagmtbranch(String hidcmbagmtbranch) {
			this.hidcmbagmtbranch = hidcmbagmtbranch;
		}



		
		public String getRefvocno() {
			return refvocno;
		}


		public void setRefvocno(String refvocno) {
			this.refvocno = refvocno;
		}
		
		
		public String getDescription() {
			return description;
		}


		public void setDescription(String description) {
			this.description = description;
		}


		public String getLblinlocation() {
			return lblinlocation;
		}


		public void setLblinlocation(String lblinlocation) {
			this.lblinlocation = lblinlocation;
		}


		public String getLbloutlocation() {
			return lbloutlocation;
		}


		public void setLbloutlocation(String lbloutlocation) {
			this.lbloutlocation = lbloutlocation;
		}


		public String getLbldeldriver() {
			return lbldeldriver;
		}


		public void setLbldeldriver(String lbldeldriver) {
			this.lbldeldriver = lbldeldriver;
		}


		public String getLblcoldriver() {
			return lblcoldriver;
		}


		public void setLblcoldriver(String lblcoldriver) {
			this.lblcoldriver = lblcoldriver;
		}


		public String getLbldescription() {
			return lbldescription;
		}


		public void setLbldescription(String lbldescription) {
			this.lbldescription = lbldescription;
		}


		public String getLbldrivenby() {
			return lbldrivenby;
		}


		public void setLbldrivenby(String lbldrivenby) {
			this.lbldrivenby = lbldrivenby;
		}


		public String getCompanyname() {
			return companyname;
		}


		public void setCompanyname(String companyname) {
			this.companyname = companyname;
		}


		public String getAddress() {
			return address;
		}


		public void setAddress(String address) {
			this.address = address;
		}


		public String getMobileno() {
			return mobileno;
		}


		public void setMobileno(String mobileno) {
			this.mobileno = mobileno;
		}


		public String getFax() {
			return fax;
		}


		public void setFax(String fax) {
			this.fax = fax;
		}


		public String getLocation() {
			return location;
		}


		public void setLocation(String location) {
			this.location = location;
		}


		public String getBarnchval() {
			return barnchval;
		}


		public void setBarnchval(String barnchval) {
			this.barnchval = barnchval;
		}


		public String getBrwithcompany() {
			return brwithcompany;
		}


		public void setBrwithcompany(String brwithcompany) {
			this.brwithcompany = brwithcompany;
		}


		public String getVrano() {
			return vrano;
		}


		public void setVrano(String vrano) {
			this.vrano = vrano;
		}


		public String getMtime() {
			return mtime;
		}


		public void setMtime(String mtime) {
			this.mtime = mtime;
		}


		public String getPfleetno() {
			return pfleetno;
		}


		public void setPfleetno(String pfleetno) {
			this.pfleetno = pfleetno;
		}


		public String getPfuel() {
			return pfuel;
		}


		public void setPfuel(String pfuel) {
			this.pfuel = pfuel;
		}


		public String getPopened() {
			return popened;
		}


		public void setPopened(String popened) {
			this.popened = popened;
		}


		public String getPclient() {
			return pclient;
		}


		public void setPclient(String pclient) {
			this.pclient = pclient;
		}


		public String getClientacno() {
			return clientacno;
		}


		public void setClientacno(String clientacno) {
			this.clientacno = clientacno;
		}


		public String getAgmt() {
			return agmt;
		}


		public void setAgmt(String agmt) {
			this.agmt = agmt;
		}


		public String getPdocno() {
			return pdocno;
		}


		public void setPdocno(String pdocno) {
			this.pdocno = pdocno;
		}


		public String getPdate() {
			return pdate;
		}


		public void setPdate(String pdate) {
			this.pdate = pdate;
		}


		public String getPregno() {
			return pregno;
		}


		public void setPregno(String pregno) {
			this.pregno = pregno;
		}


		public String getVradate() {
			return vradate;
		}


		public void setVradate(String vradate) {
			this.vradate = vradate;
		}


		public String getDtimes() {
			return dtimes;
		}


		public void setDtimes(String dtimes) {
			this.dtimes = dtimes;
		}


		public String getReplaced() {
			return replaced;
		}


		public void setReplaced(String replaced) {
			this.replaced = replaced;
		}


		public String getReptype() {
			return reptype;
		}


		public void setReptype(String reptype) {
			this.reptype = reptype;
		}


		public String getPkm() {
			return pkm;
		}


		public void setPkm(String pkm) {
			this.pkm = pkm;
		}


		public String getPoutdate() {
			return poutdate;
		}


		public void setPoutdate(String poutdate) {
			this.poutdate = poutdate;
		}


		public String getPdelivery() {
			return pdelivery;
		}


		public void setPdelivery(String pdelivery) {
			this.pdelivery = pdelivery;
		}


		public String getInbrwithcompany() {
			return inbrwithcompany;
		}


		public void setInbrwithcompany(String inbrwithcompany) {
			this.inbrwithcompany = inbrwithcompany;
		}


		public String getInvehdate() {
			return invehdate;
		}


		public void setInvehdate(String invehdate) {
			this.invehdate = invehdate;
		}


		public String getInvehtime() {
			return invehtime;
		}


		public void setInvehtime(String invehtime) {
			this.invehtime = invehtime;
		}


		public String getInvehkm() {
			return invehkm;
		}


		public void setInvehkm(String invehkm) {
			this.invehkm = invehkm;
		}


		public String getInvehfuel() {
			return invehfuel;
		}


		public void setInvehfuel(String invehfuel) {
			this.invehfuel = invehfuel;
		}


		public String getInvehreason() {
			return invehreason;
		}


		public void setInvehreason(String invehreason) {
			this.invehreason = invehreason;
		}


		public String getNewbrwithcompany() {
			return newbrwithcompany;
		}


		public void setNewbrwithcompany(String newbrwithcompany) {
			this.newbrwithcompany = newbrwithcompany;
		}


		public String getNewvehoutdate() {
			return newvehoutdate;
		}


		public void setNewvehoutdate(String newvehoutdate) {
			this.newvehoutdate = newvehoutdate;
		}


		public String getNewvehouttime() {
			return newvehouttime;
		}


		public void setNewvehouttime(String newvehouttime) {
			this.newvehouttime = newvehouttime;
		}


		public String getNewvehfleet() {
			return newvehfleet;
		}


		public void setNewvehfleet(String newvehfleet) {
			this.newvehfleet = newvehfleet;
		}


		public String getNewvehregno() {
			return newvehregno;
		}


		public void setNewvehregno(String newvehregno) {
			this.newvehregno = newvehregno;
		}


		public String getNewvehkm() {
			return newvehkm;
		}


		public void setNewvehkm(String newvehkm) {
			this.newvehkm = newvehkm;
		}


		public String getNewvehfuel() {
			return newvehfuel;
		}


		public void setNewvehfuel(String newvehfuel) {
			this.newvehfuel = newvehfuel;
		}


		public String getDelbrwithcompany() {
			return delbrwithcompany;
		}


		public void setDelbrwithcompany(String delbrwithcompany) {
			this.delbrwithcompany = delbrwithcompany;
		}


		public String getDeldate() {
			return deldate;
		}


		public void setDeldate(String deldate) {
			this.deldate = deldate;
		}


		public String getDeltime() {
			return deltime;
		}


		public void setDeltime(String deltime) {
			this.deltime = deltime;
		}


		public String getDelfleet() {
			return delfleet;
		}


		public void setDelfleet(String delfleet) {
			this.delfleet = delfleet;
		}


		public String getDelregno() {
			return delregno;
		}


		public void setDelregno(String delregno) {
			this.delregno = delregno;
		}


		public String getDelkm() {
			return delkm;
		}


		public void setDelkm(String delkm) {
			this.delkm = delkm;
		}


		public String getDelfuel() {
			return delfuel;
		}


		public void setDelfuel(String delfuel) {
			this.delfuel = delfuel;
		}


		public String getColbrwithcompany() {
			return colbrwithcompany;
		}


		public void setColbrwithcompany(String colbrwithcompany) {
			this.colbrwithcompany = colbrwithcompany;
		}


		public String getColdate() {
			return coldate;
		}


		public void setColdate(String coldate) {
			this.coldate = coldate;
		}


		public String getColtime() {
			return coltime;
		}


		public void setColtime(String coltime) {
			this.coltime = coltime;
		}


		public String getColfleet() {
			return colfleet;
		}


		public void setColfleet(String colfleet) {
			this.colfleet = colfleet;
		}


		public String getColregno() {
			return colregno;
		}


		public void setColregno(String colregno) {
			this.colregno = colregno;
		}


		public String getColkm() {
			return colkm;
		}


		public void setColkm(String colkm) {
			this.colkm = colkm;
		}


		public String getColfuel() {
			return colfuel;
		}


		public void setColfuel(String colfuel) {
			this.colfuel = colfuel;
		}


		public String getLbldelivery() {
			return lbldelivery;
		}


		public void setLbldelivery(String lbldelivery) {
			this.lbldelivery = lbldelivery;
		}


		public String getLblcollection() {
			return lblcollection;
		}


		public void setLblcollection(String lblcollection) {
			this.lblcollection = lblcollection;
		}


		public String getLblrlocation() {
			return lblrlocation;
		}


		public void setLblrlocation(String lblrlocation) {
			this.lblrlocation = lblrlocation;
		}


		public String getLblinfleetname() {
			return lblinfleetname;
		}


		public void setLblinfleetname(String lblinfleetname) {
			this.lblinfleetname = lblinfleetname;
		}


		public String getLbloutfleetname() {
			return lbloutfleetname;
		}


		public void setLbloutfleetname(String lbloutfleetname) {
			this.lbloutfleetname = lbloutfleetname;
		}


		public String getLbldelfleetname() {
			return lbldelfleetname;
		}


		public void setLbldelfleetname(String lbldelfleetname) {
			this.lbldelfleetname = lbldelfleetname;
		}


		public String getLblcolfleetname() {
			return lblcolfleetname;
		}


		public void setLblcolfleetname(String lblcolfleetname) {
			this.lblcolfleetname = lblcolfleetname;
		}


		public String getHidcmbcoloutfuel() {
			return hidcmbcoloutfuel;
		}


		public void setHidcmbcoloutfuel(String hidcmbcoloutfuel) {
			this.hidcmbcoloutfuel = hidcmbcoloutfuel;
		}


		public String getStatus() {
			return status;
		}


		public void setStatus(String status) {
			this.status = status;
		}


		public String getHidcmbcolcollectfuel() {
			return hidcmbcolcollectfuel;
		}


		public void setHidcmbcolcollectfuel(String hidcmbcolcollectfuel) {
			this.hidcmbcolcollectfuel = hidcmbcolcollectfuel;
		}
	
	public String getHidchkatbranch() {
		return hidchkatbranch;
	}


	public void setHidchkatbranch(String hidchkatbranch) {
		this.hidchkatbranch = hidchkatbranch;
	}


	public String getChkatbranch() {
		return chkatbranch;
	}


	public void setChkatbranch(String chkatbranch) {
		this.chkatbranch = chkatbranch;
	}


	public String getHidatbranchoutlocation() {
		return hidatbranchoutlocation;
	}


	public void setHidatbranchoutlocation(String hidatbranchoutlocation) {
		this.hidatbranchoutlocation = hidatbranchoutlocation;
	}

	

	public String getChkcollect() {
		return chkcollect;
	}


	public void setChkcollect(String chkcollect) {
		this.chkcollect = chkcollect;
	}


	public String getHidchkcollect() {
		return hidchkcollect;
	}


	public void setHidchkcollect(String hidchkcollect) {
		this.hidchkcollect = hidchkcollect;
	}


	public String getChkdelivery() {
		return chkdelivery;
	}


	public void setChkdelivery(String chkdelivery) {
		this.chkdelivery = chkdelivery;
	}


	public String getHidchkdelivery() {
		return hidchkdelivery;
	}


	public void setHidchkdelivery(String hidchkdelivery) {
		this.hidchkdelivery = hidchkdelivery;
	}


	public String getFormdetailcode() {
		return formdetailcode;
	}


	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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


	public String getHiddate() {
		return hiddate;
	}


	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}


	public String getRefdate() {
		return refdate;
	}


	public void setRefdate(String refdate) {
		this.refdate = refdate;
	}


	public String getHidrefdate() {
		return hidrefdate;
	}


	public void setHidrefdate(String hidrefdate) {
		this.hidrefdate = hidrefdate;
	}


	public String getRefno() {
		return refno;
	}


	public void setRefno(String refno) {
		this.refno = refno;
	}


	public String getRefname() {
		return refname;
	}


	public void setRefname(String refname) {
		this.refname = refname;
	}


	public String getTxtfleetno() {
		return txtfleetno;
	}


	public void setTxtfleetno(String txtfleetno) {
		this.txtfleetno = txtfleetno;
	}


	public String getTxtfleetname() {
		return txtfleetname;
	}


	public void setTxtfleetname(String txtfleetname) {
		this.txtfleetname = txtfleetname;
	}


	public String getDateout() {
		return dateout;
	}


	public void setDateout(String dateout) {
		this.dateout = dateout;
	}


	public String getHiddateout() {
		return hiddateout;
	}


	public void setHiddateout(String hiddateout) {
		this.hiddateout = hiddateout;
	}


	public String getTimeout() {
		return timeout;
	}


	public void setTimeout(String timeout) {
		this.timeout = timeout;
	}


	public String getHidtimeout() {
		return hidtimeout;
	}


	public void setHidtimeout(String hidtimeout) {
		this.hidtimeout = hidtimeout;
	}


	public double getOutkm() {
		return outkm;
	}


	public void setOutkm(double outkm) {
		this.outkm = outkm;
	}


	public String getCmbfuel() {
		return cmbfuel;
	}


	public void setCmbfuel(String cmbfuel) {
		this.cmbfuel = cmbfuel;
	}


	public String getHidcmbfuel() {
		return hidcmbfuel;
	}


	public void setHidcmbfuel(String hidcmbfuel) {
		this.hidcmbfuel = hidcmbfuel;
	}


	public String getCmbrentaltype() {
		return cmbrentaltype;
	}


	public void setCmbrentaltype(String cmbrentaltype) {
		this.cmbrentaltype = cmbrentaltype;
	}


	public String getHidcmbrentaltype() {
		return hidcmbrentaltype;
	}


	public void setHidcmbrentaltype(String hidcmbrentaltype) {
		this.hidcmbrentaltype = hidcmbrentaltype;
	}


	public String getTxtbranch() {
		return txtbranch;
	}


	public void setTxtbranch(String txtbranch) {
		this.txtbranch = txtbranch;
	}


	public String getHidtxtbranch() {
		return hidtxtbranch;
	}


	public void setHidtxtbranch(String hidtxtbranch) {
		this.hidtxtbranch = hidtxtbranch;
	}


	public String getTxtlocation() {
		return txtlocation;
	}


	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}


	public String getHidtxtlocation() {
		return hidtxtlocation;
	}


	public void setHidtxtlocation(String hidtxtlocation) {
		this.hidtxtlocation = hidtxtlocation;
	}


	public String getCmbtrreason() {
		return cmbtrreason;
	}


	public void setCmbtrreason(String cmbtrreason) {
		this.cmbtrreason = cmbtrreason;
	}


	public String getHidcmbtrreason() {
		return hidcmbtrreason;
	}


	public void setHidcmbtrreason(String hidcmbtrreason) {
		this.hidcmbtrreason = hidcmbtrreason;
	}


	public String getCmbreplacetype() {
		return cmbreplacetype;
	}


	public void setCmbreplacetype(String cmbreplacetype) {
		this.cmbreplacetype = cmbreplacetype;
	}


	public String getHidcmbreplacetype() {
		return hidcmbreplacetype;
	}


	public void setHidcmbreplacetype(String hidcmbreplacetype) {
		this.hidcmbreplacetype = hidcmbreplacetype;
	}


	public String getUser() {
		return user;
	}


	public void setUser(String user) {
		this.user = user;
	}


	public String getHiduser() {
		return hiduser;
	}


	public void setHiduser(String hiduser) {
		this.hiduser = hiduser;
	}


	public String getInfleettrancode() {
		return infleettrancode;
	}


	public void setInfleettrancode(String infleettrancode) {
		this.infleettrancode = infleettrancode;
	}


	public String getCmbinbranch() {
		return cmbinbranch;
	}


	public void setCmbinbranch(String cmbinbranch) {
		this.cmbinbranch = cmbinbranch;
	}


	public String getHidcmbinbranch() {
		return hidcmbinbranch;
	}


	public void setHidcmbinbranch(String hidcmbinbranch) {
		this.hidcmbinbranch = hidcmbinbranch;
	}


	public String getCmbinlocation() {
		return cmbinlocation;
	}


	public void setCmbinlocation(String cmbinlocation) {
		this.cmbinlocation = cmbinlocation;
	}


	public String getHidcmbinlocation() {
		return hidcmbinlocation;
	}


	public void setHidcmbinlocation(String hidcmbinlocation) {
		this.hidcmbinlocation = hidcmbinlocation;
	}


	public String getInuser() {
		return inuser;
	}


	public void setInuser(String inuser) {
		this.inuser = inuser;
	}


	public String getHidinuser() {
		return hidinuser;
	}


	public void setHidinuser(String hidinuser) {
		this.hidinuser = hidinuser;
	}


	public String getAtbranchdatein() {
		return atbranchdatein;
	}


	public void setAtbranchdatein(String atbranchdatein) {
		this.atbranchdatein = atbranchdatein;
	}


	public String getHidatbranchdatein() {
		return hidatbranchdatein;
	}


	public void setHidatbranchdatein(String hidatbranchdatein) {
		this.hidatbranchdatein = hidatbranchdatein;
	}


	public String getAtbranchtimein() {
		return atbranchtimein;
	}


	public void setAtbranchtimein(String atbranchtimein) {
		this.atbranchtimein = atbranchtimein;
	}


	public String getHidatbranchtimein() {
		return hidatbranchtimein;
	}


	public void setHidatbranchtimein(String hidatbranchtimein) {
		this.hidatbranchtimein = hidatbranchtimein;
	}


	public String getAtbranchkmin() {
		return atbranchkmin;
	}


	public void setAtbranchkmin(String atbranchkmin) {
		this.atbranchkmin = atbranchkmin;
	}


	public String getCmbatbranchinfuel() {
		return cmbatbranchinfuel;
	}


	public void setCmbatbranchinfuel(String cmbatbranchinfuel) {
		this.cmbatbranchinfuel = cmbatbranchinfuel;
	}


	public String getHidcmbatbranchinfuel() {
		return hidcmbatbranchinfuel;
	}


	public void setHidcmbatbranchinfuel(String hidcmbatbranchinfuel) {
		this.hidcmbatbranchinfuel = hidcmbatbranchinfuel;
	}


	public String getAtbranchoutfleetno() {
		return atbranchoutfleetno;
	}


	public void setAtbranchoutfleetno(String atbranchoutfleetno) {
		this.atbranchoutfleetno = atbranchoutfleetno;
	}


	public String getAtbranchoutfleetname() {
		return atbranchoutfleetname;
	}


	public void setAtbranchoutfleetname(String atbranchoutfleetname) {
		this.atbranchoutfleetname = atbranchoutfleetname;
	}


	public String getHidatbranchoutbranch() {
		return hidatbranchoutbranch;
	}


	public void setHidatbranchoutbranch(String hidatbranchoutbranch) {
		this.hidatbranchoutbranch = hidatbranchoutbranch;
	}


	public String getHidoutbranchuser() {
		return hidoutbranchuser;
	}


	public void setHidoutbranchuser(String hidoutbranchuser) {
		this.hidoutbranchuser = hidoutbranchuser;
	}


	public String getHidatbranchoutuser() {
		return hidatbranchoutuser;
	}


	public void setHidatbranchoutuser(String hidatbranchoutuser) {
		this.hidatbranchoutuser = hidatbranchoutuser;
	}


	public String getAtbranchoutbranch() {
		return atbranchoutbranch;
	}


	public void setAtbranchoutbranch(String atbranchoutbranch) {
		this.atbranchoutbranch = atbranchoutbranch;
	}


	public String getAtbranchoutlocation() {
		return atbranchoutlocation;
	}


	public void setAtbranchoutlocation(String atbranchoutlocation) {
		this.atbranchoutlocation = atbranchoutlocation;
	}


	public String getAtbranchoutuser() {
		return atbranchoutuser;
	}


	public void setAtbranchoutuser(String atbranchoutuser) {
		this.atbranchoutuser = atbranchoutuser;
	}


	public String getAtbranchoutdate() {
		return atbranchoutdate;
	}


	public void setAtbranchoutdate(String atbranchoutdate) {
		this.atbranchoutdate = atbranchoutdate;
	}


	public String getHidatbranchoutdate() {
		return hidatbranchoutdate;
	}


	public void setHidatbranchoutdate(String hidatbranchoutdate) {
		this.hidatbranchoutdate = hidatbranchoutdate;
	}


	public String getAtbranchouttime() {
		return atbranchouttime;
	}


	public void setAtbranchouttime(String atbranchouttime) {
		this.atbranchouttime = atbranchouttime;
	}


	public String getHidatbranchouttime() {
		return hidatbranchouttime;
	}


	public void setHidatbranchouttime(String hidatbranchouttime) {
		this.hidatbranchouttime = hidatbranchouttime;
	}


	public String getAtbranchoutkm() {
		return atbranchoutkm;
	}


	public void setAtbranchoutkm(String atbranchoutkm) {
		this.atbranchoutkm = atbranchoutkm;
	}


	public String getCmbatbranchoutfuel() {
		return cmbatbranchoutfuel;
	}


	public void setCmbatbranchoutfuel(String cmbatbranchoutfuel) {
		this.cmbatbranchoutfuel = cmbatbranchoutfuel;
	}


	public String getHidcmbatbranchoutfuel() {
		return hidcmbatbranchoutfuel;
	}


	public void setHidcmbatbranchoutfuel(String hidcmbatbranchoutfuel) {
		this.hidcmbatbranchoutfuel = hidcmbatbranchoutfuel;
	}


	public String getHidchkcollection() {
		return hidchkcollection;
	}


	public void setHidchkcollection(String hidchkcollection) {
		this.hidchkcollection = hidchkcollection;
	}


	public String getChkcollection() {
		return chkcollection;
	}


	public void setChkcollection(String chkcollection) {
		this.chkcollection = chkcollection;
	}


	public String getColoutfleetno() {
		return coloutfleetno;
	}


	public void setColoutfleetno(String coloutfleetno) {
		this.coloutfleetno = coloutfleetno;
	}


	public String getColoutfleetname() {
		return coloutfleetname;
	}


	public void setColoutfleetname(String coloutfleetname) {
		this.coloutfleetname = coloutfleetname;
	}


	public String getHidcoloutbranch() {
		return hidcoloutbranch;
	}


	public void setHidcoloutbranch(String hidcoloutbranch) {
		this.hidcoloutbranch = hidcoloutbranch;
	}


	public String getHidcoloutlocation() {
		return hidcoloutlocation;
	}


	public void setHidcoloutlocation(String hidcoloutlocation) {
		this.hidcoloutlocation = hidcoloutlocation;
	}


	public String getHidcoloutuser() {
		return hidcoloutuser;
	}


	public void setHidcoloutuser(String hidcoloutuser) {
		this.hidcoloutuser = hidcoloutuser;
	}


	public String getColoutbranch() {
		return coloutbranch;
	}


	public void setColoutbranch(String coloutbranch) {
		this.coloutbranch = coloutbranch;
	}


	public String getColoutlocation() {
		return coloutlocation;
	}


	public void setColoutlocation(String coloutlocation) {
		this.coloutlocation = coloutlocation;
	}


	public String getColoutuser() {
		return coloutuser;
	}


	public void setColoutuser(String coloutuser) {
		this.coloutuser = coloutuser;
	}


	public String getColoutdate() {
		return coloutdate;
	}


	public void setColoutdate(String coloutdate) {
		this.coloutdate = coloutdate;
	}


	public String getHidcoloutdate() {
		return hidcoloutdate;
	}


	public void setHidcoloutdate(String hidcoloutdate) {
		this.hidcoloutdate = hidcoloutdate;
	}


	public String getColouttime() {
		return colouttime;
	}


	public void setColouttime(String colouttime) {
		this.colouttime = colouttime;
	}


	public String getHidcolouttime() {
		return hidcolouttime;
	}


	public void setHidcolouttime(String hidcolouttime) {
		this.hidcolouttime = hidcolouttime;
	}


	public String getColoutkm() {
		return coloutkm;
	}


	public void setColoutkm(String coloutkm) {
		this.coloutkm = coloutkm;
	}


	public String getCmbcoloutfuel() {
		return cmbcoloutfuel;
	}


	public void setCmbcoloutfuel(String cmbcoloutfuel) {
		this.cmbcoloutfuel = cmbcoloutfuel;
	}


	public String getColcollectdriver() {
		return colcollectdriver;
	}


	public void setColcollectdriver(String colcollectdriver) {
		this.colcollectdriver = colcollectdriver;
	}


	public String getHidcolcollectdriver() {
		return hidcolcollectdriver;
	}


	public void setHidcolcollectdriver(String hidcolcollectdriver) {
		this.hidcolcollectdriver = hidcolcollectdriver;
	}


	public String getColcollectdate() {
		return colcollectdate;
	}


	public void setColcollectdate(String colcollectdate) {
		this.colcollectdate = colcollectdate;
	}


	public String getHidcolcollectdate() {
		return hidcolcollectdate;
	}


	public void setHidcolcollectdate(String hidcolcollectdate) {
		this.hidcolcollectdate = hidcolcollectdate;
	}


	public String getColcollecttime() {
		return colcollecttime;
	}


	public void setColcollecttime(String colcollecttime) {
		this.colcollecttime = colcollecttime;
	}


	public String getHidcolcollecttime() {
		return hidcolcollecttime;
	}


	public void setHidcolcollecttime(String hidcolcollecttime) {
		this.hidcolcollecttime = hidcolcollecttime;
	}


	public String getColcollectkm() {
		return colcollectkm;
	}


	public void setColcollectkm(String colcollectkm) {
		this.colcollectkm = colcollectkm;
	}


	public String getCmbcolcollectfuel() {
		return cmbcolcollectfuel;
	}


	public void setCmbcolcollectfuel(String cmbcolcollectfuel) {
		this.cmbcolcollectfuel = cmbcolcollectfuel;
	}


	public String getColdeldriver() {
		return coldeldriver;
	}


	public void setColdeldriver(String coldeldriver) {
		this.coldeldriver = coldeldriver;
	}


	public String getHidcoldeldriver() {
		return hidcoldeldriver;
	}


	public void setHidcoldeldriver(String hidcoldeldriver) {
		this.hidcoldeldriver = hidcoldeldriver;
	}


	public String getColdeliveryto() {
		return coldeliveryto;
	}


	public void setColdeliveryto(String coldeliveryto) {
		this.coldeliveryto = coldeliveryto;
	}


	public String getColdeldate() {
		return coldeldate;
	}


	public void setColdeldate(String coldeldate) {
		this.coldeldate = coldeldate;
	}


	public String getHidcoldeldate() {
		return hidcoldeldate;
	}


	public void setHidcoldeldate(String hidcoldeldate) {
		this.hidcoldeldate = hidcoldeldate;
	}


	public String getColdeltime() {
		return coldeltime;
	}


	public void setColdeltime(String coldeltime) {
		this.coldeltime = coldeltime;
	}


	public String getHidcoldeltime() {
		return hidcoldeltime;
	}


	public void setHidcoldeltime(String hidcoldeltime) {
		this.hidcoldeltime = hidcoldeltime;
	}


	public String getColdelkm() {
		return coldelkm;
	}


	public void setColdelkm(String coldelkm) {
		this.coldelkm = coldelkm;
	}


	public String getCmbcoldelfuel() {
		return cmbcoldelfuel;
	}


	public void setCmbcoldelfuel(String cmbcoldelfuel) {
		this.cmbcoldelfuel = cmbcoldelfuel;
	}


	public String getHidcmbcoldelfuel() {
		return hidcmbcoldelfuel;
	}


	public void setHidcmbcoldelfuel(String hidcmbcoldelfuel) {
		this.hidcmbcoldelfuel = hidcmbcoldelfuel;
	}



	public String getCmbcolinbranch() {
		return cmbcolinbranch;
	}


	public void setCmbcolinbranch(String cmbcolinbranch) {
		this.cmbcolinbranch = cmbcolinbranch;
	}


	public String getHidcmbcolinbranch() {
		return hidcmbcolinbranch;
	}


	public void setHidcmbcolinbranch(String hidcmbcolinbranch) {
		this.hidcmbcolinbranch = hidcmbcolinbranch;
	}


	public String getCmbcolinlocation() {
		return cmbcolinlocation;
	}


	public void setCmbcolinlocation(String cmbcolinlocation) {
		this.cmbcolinlocation = cmbcolinlocation;
	}


	public String getHidcmbcolinlocation() {
		return hidcmbcolinlocation;
	}


	public void setHidcmbcolinlocation(String hidcmbcolinlocation) {
		this.hidcmbcolinlocation = hidcmbcolinlocation;
	}


	public String getColindate() {
		return colindate;
	}


	public void setColindate(String colindate) {
		this.colindate = colindate;
	}


	public String getHidcolindate() {
		return hidcolindate;
	}


	public void setHidcolindate(String hidcolindate) {
		this.hidcolindate = hidcolindate;
	}


	public String getColintime() {
		return colintime;
	}


	public void setColintime(String colintime) {
		this.colintime = colintime;
	}


	public String getHidcolintime() {
		return hidcolintime;
	}


	public void setHidcolintime(String hidcolintime) {
		this.hidcolintime = hidcolintime;
	}


	public String getColinkm() {
		return colinkm;
	}


	public void setColinkm(String colinkm) {
		this.colinkm = colinkm;
	}


	public String getCmbcolinfuel() {
		return cmbcolinfuel;
	}


	public void setCmbcolinfuel(String cmbcolinfuel) {
		this.cmbcolinfuel = cmbcolinfuel;
	}


	public String getHidcmbcolinfuel() {
		return hidcmbcolinfuel;
	}


	public void setHidcmbcolinfuel(String hidcmbcolinfuel) {
		this.hidcmbcolinfuel = hidcmbcolinfuel;
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
	
	
	public void setData(int val,HttpSession session,java.sql.Date date,java.sql.Date dateout,java.sql.Date atbranchindate,java.sql.Date atbranchoutdate,
			java.sql.Date coloutdate,java.sql.Date colcollectdate,java.sql.Date coldeldate,java.sql.Date colindate,String cmbreplacetype,int id,java.sql.Date refdate){
		if(date!=null){
			setDate(date.toString());
		}
		setHidcmbagmtbranch(getCmbagmtbranch());
		setTxtfleetno(getTxtfleetno());
		setTxtfleetname(getTxtfleetname());
		//setHiddate(date.toString());
		setHidcmbrentaltype(getCmbrentaltype());
		setRefno(getRefno());
		setRefvocno(getRefvocno());
		setRefname(getRefname());
		if(refdate!=null){
			setRefdate(refdate.toString());	
		}
		
		setTxtfleetno(getTxtfleetno());
		setTxtfleetname(getTxtfleetname());
		if(dateout!=null){
		setDateout(dateout.toString());
		}
		setHidtimeout(getTimeout());
		setOutkm(getOutkm());
		setInfleettrancode(getInfleettrancode());
		setHidcmbfuel(getCmbfuel());
		setTxtbranch(getTxtbranch());
		setTxtlocation(getTxtlocation());
		setHidtxtbranch(getHidtxtbranch());
		setHidtxtlocation(getHidtxtlocation());
		setHidcmbtrreason(getCmbtrreason());
		setHidcmbreplacetype(getCmbreplacetype());
		setUser(session.getAttribute("USERNAME").toString());
		setHiduser(session.getAttribute("USERID").toString());
		setDescription(getDescription());
		if(cmbreplacetype.equalsIgnoreCase("atbranch")){
		if(atbranchindate!=null){
			setAtbranchdatein(atbranchindate.toString());	
		}
		setHidatbranchtimein(getAtbranchtimein());
		setAtbranchkmin(getAtbranchkmin());
		setHidcmbatbranchinfuel(getCmbatbranchinfuel());
		setHidcmbinbranch(getCmbinbranch());
		setHidcmbinlocation(getCmbinlocation());
		setAtbranchoutfleetno(getAtbranchoutfleetno());
		setAtbranchoutfleetname(getAtbranchoutfleetname());
		setAtbranchoutbranch(getAtbranchoutbranch());
		setHidatbranchdatein(getHidatbranchdatein());
		setAtbranchoutlocation(getAtbranchoutlocation());
		setHidatbranchoutlocation(getHidatbranchoutlocation());
		
		if(atbranchoutdate!=null){
			setAtbranchoutdate(atbranchoutdate.toString());	
		}
		setHidatbranchouttime(getAtbranchouttime());
		setAtbranchoutkm(getAtbranchoutkm());
		setHidcmbatbranchoutfuel(getCmbatbranchoutfuel());
		setHidatbranchoutuser(session.getAttribute("USERID").toString());
		setAtbranchoutuser(session.getAttribute("USERNAME").toString());
		setInuser(session.getAttribute("USERNAME").toString());
		setHidinuser(session.getAttribute("USERID").toString());
		}
		else if(cmbreplacetype.equalsIgnoreCase("collection")){
			if(id==1){
				setColoutfleetno(getColoutfleetno());
				setColoutfleetname(getColoutfleetname());
				setColoutbranch(getColoutbranch());
				setColoutlocation(getColoutlocation());
				setHidcoloutbranch(getHidcoloutbranch());
				setHidcoloutlocation(getHidcoloutlocation());
				setColoutdate(coloutdate.toString());
				setHidcolouttime(getColouttime());
				setColoutkm(getColoutkm());
				setHidcmbcoloutfuel(getCmbcoloutfuel());
				setHidcoloutuser(session.getAttribute("USERID").toString());
				setColoutuser(session.getAttribute("USERNAME").toString());
			}
			if(id==2){
				setColoutdate(coloutdate.toString());
				setHidchkcollect(getHidchkcollect()==null?"0":getHidchkcollect());
				if(getHidchkcollect().equalsIgnoreCase("1")){
				setColcollectdate(colcollectdate.toString());
				setHidcolcollectdriver(getHidcolcollectdriver());
				setColcollectdriver(getColcollectdriver());
				setHidcolcollecttime(getColcollecttime());
				setColcollectkm(getColcollectkm());
				setHidcmbcolcollectfuel(getCmbcolcollectfuel());
				}
				setHidchkdelivery(getHidchkdelivery()==null?"0":getHidchkdelivery());
				if(getHidchkdelivery().equalsIgnoreCase("1")){
					setColdeldriver(getColdeldriver());
					setHidcoldeldriver(getHidcoldeldriver());
					setColdeldate(coldeldate.toString());
					setHidcoldeltime(getColdeltime());
					setHidcmbcoldelfuel(getCmbcoldelfuel());
					setColdeliveryto(getColdeliveryto());
					
				}
				setHidcmbcolinbranch(getCmbcolinbranch());
				setHidcmbcolinlocation(getCmbcolinlocation());
				setColindate(colindate.toString());
				setHidcolintime(getColintime());
				setColinkm(getColinkm());
				setHidcmbcolinfuel(getCmbcolinfuel());
				
			}
		}
		//setOutuser(session.getAttribute("USERNAME").toString());
		//setHidoutuser(session.getAttribute("USERID").toString());
		//setMode(getMode());
		//setDtype(getDtype());
		//System.out.println("On Collectdate"+oncollectdate.toString());
			
		//System.out.println(val);
		setDocno(val);
		
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		java.sql.Date date = null;
		java.sql.Date dateout=null ;
		java.sql.Date refdate=null;
		java.sql.Date atbranchindate=null;
		java.sql.Date atbranchoutdate=null;
		java.sql.Date colindate=null;
		java.sql.Date coloutdate=null;
		java.sql.Date colcollectdate=null;
		java.sql.Date coldeldate=null;
//		System.out.println("Form:"+getFormdetail());
//		System.out.println("FormCode:"+getFormdetailcode());
			System.out.println("In Action Class");
		if((mode.equalsIgnoreCase("A"))||(mode.equalsIgnoreCase("E"))||(mode.equalsIgnoreCase("D"))){
			if(getDate()!=null){
			date = objcommon.changeStringtoSqlDate(getDate());
			}
			System.out.println("Date Out:"+getDateout());
			if(getDateout()!=null && (!(getDateout().equalsIgnoreCase("")))){
				/**/
				dateout = objcommon.changeStringtoSqlDate(getDateout());
			}
			if(getRefdate()!=null && (!(getRefdate().equalsIgnoreCase("")))){
				/**/
				refdate=objcommon.changeStringtoSqlDate(getRefdate());
			}
			if(getAtbranchdatein()!=null && (!(getAtbranchdatein().equalsIgnoreCase("")))){
				/**/
				atbranchindate=objcommon.changeStringtoSqlDate(getAtbranchdatein());
			}
			if(getAtbranchoutdate()!=null && (!(getAtbranchoutdate().equalsIgnoreCase("")))){
				/**/
				atbranchoutdate=objcommon.changeStringtoSqlDate(getAtbranchoutdate());
			}
			if(getColindate()!=null && (!(getColindate().equalsIgnoreCase("")))){
				 /**/
				colindate=objcommon.changeStringtoSqlDate(getColindate());
			}
			if(getColcollectdate()!=null && (!(getColcollectdate().equalsIgnoreCase("")))){
				 /**/
				colcollectdate=objcommon.changeStringtoSqlDate(getColcollectdate());	
			}
			if(getColdeldate()!=null && (!(getColdeldate().equalsIgnoreCase("")))){
				/**/
				coldeldate=objcommon.changeStringtoSqlDate(getColdeldate());	
			}
			if(getColoutdate()!=null && (!(getColoutdate().equalsIgnoreCase("")))){
				/**/
				coloutdate=objcommon.changeStringtoSqlDate(getColoutdate());	
			}
			//System.out.println("Before Mode"+mode+"::"+dateout+"::"+getTimeout()+"::"+getCmbfuel()+"::"+getAtbranchoutkm()+"::"+getCmbatbranchoutfuel());
		}
			
			if(mode.equalsIgnoreCase("A")){
				//System.out.println("Unsaved Data"+getHidgarage()+getHidchkgaragedelivery()+getHidchkgaragecollect());
//				System.out.println("Date:"+date+"Date Out:"+dateout+"InCollectDate"+incollectdate);
				//System.out.println("After Mode"+mode+"::"+dateout+"::"+getTimeout()+"::"+getCmbfuel()+"::"+getAtbranchoutkm()+"::"+getCmbatbranchoutfuel()+"::"+getColoutkm());
							int val=replacementDAO.insert(date,getCmbrentaltype(),getRefno(),getTxtfleetno(),dateout,getTimeout(),getOutkm(),getCmbfuel(),getCmbtrreason(),getCmbreplacetype(),getMode(),
									session,getFormdetailcode(),getHidtxtbranch(),getHidtxtlocation(),getHidchkcollection(),getHidchkatbranch(),getCmbinbranch(),getCmbinlocation(),atbranchindate,
									getAtbranchtimein(),getAtbranchkmin(),getCmbatbranchinfuel(),getHidatbranchoutbranch(),getHidatbranchoutlocation(),atbranchoutdate,getAtbranchouttime(),getAtbranchoutkm(),
									getCmbatbranchoutfuel(),getColoutfleetno(),getHidcoloutbranch(),getHidcoloutlocation(),coloutdate,getColouttime(),getColoutkm(),getCmbcoloutfuel(),getInfleettrancode(),getAtbranchoutfleetno(),getDescription());
							if(val>0.0){
									setData(val,session,date,dateout,atbranchindate,atbranchoutdate,coloutdate,colcollectdate,coldeldate,colindate,cmbreplacetype,1,refdate);
									setMsg("Successfully Saved");
									if(cmbreplacetype.equalsIgnoreCase("atbranch")){
										setStatus("close");
									}
									else{
										setStatus("open");
									}
									return "success";
							}	
							else{
								setData(val,session,date,dateout,atbranchindate,atbranchoutdate,coloutdate,colcollectdate,coldeldate,colindate,cmbreplacetype,1,refdate);
								setMsg("Not Saved");
								return "fail";
							}

}
			else if(mode.equalsIgnoreCase("E")){
				
				boolean status=replacementDAO.update(getDocno(),getHidchkdelivery(),getHidcolcollectdriver(),colcollectdate,getColcollecttime(),getColcollectkm(),
						getCmbcolcollectfuel(),getHidchkcollect(),getHidcoldeldriver(),coldeldate,getColdeltime(),getColdelkm(),getCmbcoldelfuel(),getColdeliveryto(),
						getRefno(),getTxtfleetno(),getCmbinbranch(),getCmbinlocation(),colindate,getColintime(),getColinkm(),getCmbcolinfuel(),coloutdate,getColouttime(),
						getColoutkm(),getCmbcoloutfuel(),getColoutfleetno(),getHidcoloutbranch(),getHidcoloutlocation(),getCmbtrreason(),date,dateout,refdate,getInfleettrancode(),
						getCmbrentaltype(),session,getMode(),getFormdetailcode(),getCmbcolinbranch(),getCmbcolinlocation(),getCmbreplacetype());
				if(status){
					setData(getDocno(),session,date,dateout,atbranchindate,atbranchoutdate,coloutdate,colcollectdate,coldeldate,colindate,cmbreplacetype,2,refdate);
					setMsg("Updated Successfully");
					setMode("view");
					setStatus("close");
					return "success";
				}
				else{
					setData(0,session,date,dateout,atbranchindate,atbranchoutdate,coloutdate,colcollectdate,coldeldate,colindate,cmbreplacetype,2,refdate);
					setStatus("open");
					setMsg("Not Updated");
					return "fail";
				}
			}
			
			else if(mode.equalsIgnoreCase("D")){
				int value=replacementDAO.delete(getDocno(),getBrchName(),getRefno(),getCmbrentaltype(),session,getMode());
				System.out.println("delete value"+value);
				setData(getDocno(),session,date,dateout,atbranchindate,atbranchoutdate,coloutdate,colcollectdate,coldeldate,colindate,cmbreplacetype,2,refdate);
				if(value>0){
					setMsg("Successfully Deleted");
					return "success";
				}
				else if(value==-1){
					setMsg("Cannot Delete Replacement of Closed Agreement");
					setMode("view");
					return "fail";
				}
				else if(value==-2){
					setMsg("Not Deleted.Found Other Replacements");
					setMode("view");
					return "fail";
				}
				else if(value==-3){
					setMsg("Cannot Delete.Found Other References");
					setMode("view");
					return "fail";
				}
				else{
					setMsg("Not Deleted");
					setMode("view");
					return "fail";
				}

			}
			
			
			
			
			
			else if(mode.equalsIgnoreCase("View")){
//				System.out.println("view===="+getTxtfleetno());
				//ClsVehicleBean bean = new ClsVehicleBean(); 
						bean=replacementDAO.getViewDetails(getDocno());
		setDocno(bean.getDocno());
		setDate(bean.getDate());
		setHidcmbrentaltype(bean.getHidcmbrentaltype());
		setHidcmbagmtbranch(bean.getCmbagmtbranch());
		setRefno(bean.getRefno());
		setRefvocno(bean.getRefvocno());
		setRefname(bean.getRefname());
		setRefdate(bean.getRefdate());
		setDescription(bean.getDescription());
		//setRefdate(bean.getHidrefdate());
		setTxtfleetno(bean.getTxtfleetno());
		setTxtfleetname(bean.getTxtfleetname());
		setDateout(bean.getDateout());
		setHidtimeout(bean.getHidtimeout());
		setOutkm(bean.getOutkm());
		setHidcmbfuel(bean.getHidcmbfuel());
		setHidtxtbranch(bean.getHidtxtbranch());
		setHidtxtlocation(bean.getHidtxtlocation());
		setTxtbranch(bean.getTxtbranch());
		setTxtlocation(bean.getTxtlocation());
		setHidcmbtrreason(bean.getHidcmbtrreason());
		setHidcmbreplacetype(bean.getHidcmbreplacetype());
		setStatus(bean.getStatus());
	/*	setHiduser(bean.getHiduser());
		setUser(bean.getUser());*/
		if(bean.getCmbreplacetype().equalsIgnoreCase("atbranch")){
				setHidcmbinbranch(bean.getHidcmbinbranch());
				setHidcmbinlocation(bean.getHidcmbinlocation());
				setAtbranchdatein(bean.getAtbranchdatein());
				setHidatbranchtimein(bean.getHidatbranchtimein());
				setAtbranchkmin(bean.getAtbranchkmin());
				setHidcmbatbranchinfuel(bean.getHidcmbatbranchinfuel());
				setAtbranchoutfleetno(bean.getAtbranchoutfleetno());
				setAtbranchoutfleetname(bean.getAtbranchoutfleetname());
				setHidatbranchoutbranch(bean.getHidatbranchoutbranch());
				setAtbranchoutbranch(bean.getAtbranchoutbranch());
				setAtbranchoutlocation(bean.getAtbranchoutlocation());
				setAtbranchoutdate(bean.getAtbranchoutdate());
				setHidatbranchouttime(bean.getHidatbranchouttime());
				setAtbranchoutkm(bean.getAtbranchoutkm());
				setHidcmbatbranchoutfuel(bean.getHidcmbatbranchoutfuel());
				setHidatbranchoutuser(bean.getHidatbranchoutuser());
				setAtbranchoutuser(bean.getAtbranchoutuser());
				setInuser(bean.getInuser());
				setHidinuser(bean.getHidinuser());
		}
		else{
			System.out.println("Collection Action");
			setColoutfleetno(bean.getColoutfleetno());
			setColoutfleetname(bean.getColoutfleetname());
			setColoutdate(bean.getColoutdate());
			setHidcolouttime(bean.getHidcolouttime());
			setColoutkm(bean.getColoutkm());
			setHidcmbcoloutfuel(bean.getHidcmbcoloutfuel());
			setHidcoloutbranch(bean.getHidcoloutbranch());
			setColoutbranch(bean.getColoutbranch());
			setColoutlocation(bean.getColoutlocation());
			setHidcoloutlocation(bean.getHidcoloutlocation());
			setColoutuser(bean.getColoutuser());
			setHidcoloutuser(bean.getHidcoloutuser());
			bean.setHidchkcollect(bean.getHidchkcollect()==null?"0":bean.getHidchkcollect());
			bean.setHidchkdelivery(bean.getHidchkdelivery()==null?"0":bean.getHidchkdelivery());
			if(bean.getHidchkcollect().equalsIgnoreCase("1")){
				setHidchkcollect(bean.getHidchkcollect());
				setHidcolcollectdriver(bean.getHidcolcollectdriver());
				setColcollectdriver(bean.getColcollectdriver());
				setColcollectdate(bean.getColcollectdate());
				setHidcolcollecttime(bean.getHidcolcollecttime());
				setColcollectkm(bean.getColcollectkm());
				setHidcmbcolcollectfuel(bean.getHidcmbcolcollectfuel());
				
			}
			
			if(bean.getHidchkdelivery().equalsIgnoreCase("1")){
				setHidchkdelivery(bean.getHidchkdelivery());
				setHidcoldeldriver(bean.getHidcoldeldriver());
				setColdeldriver(bean.getColdeldriver());
				setColdeldate(bean.getColdeldate());
				setHidcoldeltime(bean.getHidcoldeltime());
				setColdelkm(bean.getColdelkm());
				setHidcmbcoldelfuel(bean.getHidcmbcoldelfuel());
				setColdeliveryto(bean.getColdeliveryto());
			}
			
			setHidcmbcolinbranch(bean.getHidcmbcolinbranch());
			//setColinbranch(bean.getColinbranch());
			setHidcmbcolinlocation(bean.getHidcmbcolinlocation());
			setColindate(bean.getColindate());
			setHidcolintime(bean.getHidcolintime());
			setColinkm(bean.getColinkm());
			 setHidcmbcolinfuel(bean.getHidcmbcolinfuel());
		//System.out.println("OUTKM:"+getOndeliverykm());
		//System.out.println("sucess");

		}
			
			return "success";
			}
			
			return "fail";
	}

		
	
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		 ClsReplacementNewBean printbean=new ClsReplacementNewBean();
		 printbean=replacementDAO.getPrint(doc);
		 setBrwithcompany(printbean.getBrwithcompany());
		 setVrano(printbean.getVrano());
		 setMtime(printbean.getMtime());
		 setPfleetno(printbean.getPfleetno());
		
		 setPfuel(printbean.getPfuel());
		 setPopened(printbean.getPopened());
		 setPclient(printbean.getPclient());
		 setClientacno(printbean.getClientacno());
		 
		    
		 setAgmt(printbean.getAgmt());
		 setPdocno(printbean.getPdocno());
		 setPdate(printbean.getPdate());
		 setPregno(printbean.getPregno());
		 setVradate(printbean.getVradate());
		 setDtimes(printbean.getDtimes());
		 setReplaced(printbean.getReplaced());
		 setReptype(printbean.getReptype());
		 
		 setPkm(printbean.getPkm());
		 setPoutdate(printbean.getPoutdate());
		 setPdelivery(printbean.getPdelivery());
		 setLblrlocation(printbean.getLblrlocation());
		 setLblinlocation(printbean.getLblinlocation());
		 setLbloutlocation(printbean.getLbloutlocation());
		 
		 
		 //in 
		 
		 setInbrwithcompany(printbean.getInbrwithcompany());
		  setInvehdate(printbean.getInvehdate());
		  setInvehtime(printbean.getInvehtime());
		  setInvehkm(printbean.getInvehkm());
		   setInvehfuel(printbean.getInvehfuel());
		   setInvehreason(printbean.getInvehreason());
		   setLblinfleetname(printbean.getLblinfleetname());

		// out 
		   
		   
		   
		   setNewbrwithcompany(printbean.getNewbrwithcompany());
		   setNewvehoutdate(printbean.getNewvehoutdate());
		   
		   setNewvehouttime(printbean.getNewvehouttime());
		   setNewvehfleet(printbean.getNewvehfleet());
		   setNewvehregno(printbean.getNewvehregno());
		   
		   setNewvehkm(printbean.getNewvehkm());
		   setNewvehfuel(printbean.getNewvehfuel());
		 setLbloutfleetname(printbean.getLbloutfleetname());
		 
		   // del
		   
		   setDelbrwithcompany(printbean.getDelbrwithcompany());
		   setDeldate(printbean.getDeldate());
		   setDeltime(printbean.getDeltime());
		   setDelfleet(printbean.getDelfleet());
		   setDelregno(printbean.getDelregno());
		  setDelkm(printbean.getDelkm());
		   setDelfuel(printbean.getDelfuel());
		   setLbldelivery(printbean.getLbldelivery());
		   setLbldelfleetname(printbean.getLbldelfleetname());
		   // col
		   
		   
		   setColbrwithcompany(printbean.getColbrwithcompany());
		   setColdate(printbean.getColdate());
		   setColtime(printbean.getColtime());
		   setColfleet(printbean.getColfleet());
		   setColregno(printbean.getColregno());
		   setColkm(printbean.getColkm());
		   setColfuel(printbean.getColfuel());
		   setLblcollection(printbean.getLblcollection());
		   setLblcolfleetname(printbean.getLblcolfleetname());
		   
		   setLbldeldriver(printbean.getLbldeldriver());
		   setLblcoldriver(printbean.getLblcoldriver());
		   
		   setLbldescription(printbean.getLbldescription());
		   setLbldrivenby(printbean.getLbldrivenby());
		 // company
		     setBarnchval(printbean.getBarnchval());
		   setCompanyname(printbean.getCompanyname());
		 	  
		   setAddress(printbean.getAddress());
		 
		   setMobileno(printbean.getMobileno());
		  
		   setFax(printbean.getFax());
		   setLocation(printbean.getLocation());
		
		 return "print";
		 }

}
