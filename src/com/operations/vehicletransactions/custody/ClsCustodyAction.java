package com.operations.vehicletransactions.custody;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.operations.vehicletransactions.replacement.ClsReplacementBean;


public class ClsCustodyAction 
{
	ClsCustodyDAO CustodyDAO = new ClsCustodyDAO();
	ClsCustodyBean viewbean = new ClsCustodyBean();
	ClsCommon commDAO=new ClsCommon();
	private String date,cmbrentaltype,refname,refdate,txtfleetname,dateout,timeout,cmbfuel,reason,infleettrancode,outkm,txtbranch,txtlocation;
	
	private int refno,txtfleetno,mainbranchid,mainlocationid,docno,masterrefno,searchbranch,searchbranchval;
	private String hidedate,hiderefdate,hideroutdate,rfuelval,renttypeval,hidertimeout;

private String descnew;
	private String outdesc;
	private int colldriverid,collectintickval,clientnumbers;
	private String collectiondriver,colleteddate,collectedtime,colletedkm,collectedfuel;
    private String inbranch,inlocation,indate,intime,binkm,binfuel,hidebranch,hidelocation;
   private String  hidcollectedTime,hidcollectedFuelval,hideIntime,inFuelval,hidcollecteddate,hideIndate;
	
   private String mode,msg,deleted,formdetailcode;

 //---------------------------------------
   
   private String  outdate,outtime,boutkm,boutfuel,hidoutdate,hidouttime,outfuelval,delyornval,delyesorno;
  private int branchoutval;
   
   // ----------------------
   
   private String deldriver,deliveryto,deldate,deltime,delkm,delfuel,hiddeldate,hiddeltime,hiddelfuelval;
   private int delchkval,deldriverid;
 
   
 //------------------------------------------------------------------

 		private String companyname,address,mobileno,fax,location,barnchval;
 		
 		private String brwithcompany,vrano,mtime,pfleetno,pfuel,popened,pclient,clientacno,agmt,pdocno,pdate,pregno,vradate,dtimes,replaced,reptype,pkm,poutdate,pdelivery;

 	//------------------------------------------------------------------------------------
 		
 		
 		//---------------------------------------------------------------------
 		private String inbrwithcompany,invehdate,invehtime,invehkm,invehfuel,invehreason;
 		
 		private String newbrwithcompany,newvehoutdate,newvehouttime,newvehfleet,newvehregno,newvehkm,newvehfuel;
 		
 		
 		
 		private String delbrwithcompany,delfleet,delregno;
 		
 		
 		private String colbrwithcompany,coldate,coltime,colfleet,colregno,colkm,colfuel;
 		
 		private String lbldelivery,lblcollection,lblrlocation;
 		private String lblinfleetname,lbloutfleetname,lbldelfleetname,lblcolfleetname;
 		private String lblinlocation,lbloutlocation,lbldeldriver,lblcoldriver,lbldescription,lbldrivenby;
 		

 		
 		
		public String getOutdesc() {
			return outdesc;
		}

		public void setOutdesc(String outdesc) {
			this.outdesc = outdesc;
		}

		public String getDescnew() {
			return descnew;
		}

		public void setDescnew(String descnew) {
			this.descnew = descnew;
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

public int getSearchbranch() {
	return searchbranch;
}

public void setSearchbranch(int searchbranch) {
	this.searchbranch = searchbranch;
}

public int getSearchbranchval() {
	return searchbranchval;
}

public void setSearchbranchval(int searchbranchval) {
	this.searchbranchval = searchbranchval;
}

public int getMasterrefno() {
	return masterrefno;
}

public void setMasterrefno(int masterrefno) {
	this.masterrefno = masterrefno;
}

public int getBranchoutval() {
	return branchoutval;
}

public void setBranchoutval(int branchoutval) {
	this.branchoutval = branchoutval;
}

	public String getDelyornval() {
	return delyornval;
}

public void setDelyornval(String delyornval) {
	this.delyornval = delyornval;
}

public String getDelyesorno() {
	return delyesorno;
}

public void setDelyesorno(String delyesorno) {
	this.delyesorno = delyesorno;
}

	public int getDeldriverid() {
	return deldriverid;
}

public void setDeldriverid(int deldriverid) {
	this.deldriverid = deldriverid;
}

	public String getDeldriver() {
	return deldriver;
}

public void setDeldriver(String deldriver) { 
	this.deldriver = deldriver;
}

public String getDeliveryto() {
	return deliveryto;
}

public void setDeliveryto(String deliveryto) {
	this.deliveryto = deliveryto;
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

public String getHiddeldate() {
	return hiddeldate;
}

public void setHiddeldate(String hiddeldate) {
	

	this.hiddeldate = hiddeldate;
}

public String getHiddeltime() {
	return hiddeltime;
}

public void setHiddeltime(String hiddeltime) {
	this.hiddeltime = hiddeltime;
}

public String getHiddelfuelval() {
	return hiddelfuelval;
}

public void setHiddelfuelval(String hiddelfuelval) {
	this.hiddelfuelval = hiddelfuelval;
}

public int getDelchkval() {
	return delchkval;
}

public void setDelchkval(int delchkval) {
	this.delchkval = delchkval;
}

	public String getOutdate() {
	return outdate;
}

public void setOutdate(String outdate) { 
	this.outdate = outdate;
}

public String getOuttime() {
	return outtime;
}

public void setOuttime(String outtime) {
	this.outtime = outtime;
}

public String getBoutkm() {
	return boutkm;
}

public void setBoutkm(String boutkm) {
	this.boutkm = boutkm;
}

public String getBoutfuel() {
	return boutfuel;
}

public void setBoutfuel(String boutfuel) {
	this.boutfuel = boutfuel;
}

public String getHidoutdate() {
	return hidoutdate;
}

public void setHidoutdate(String hidoutdate) {
	this.hidoutdate = hidoutdate;
}

public String getHidouttime() {
	return hidouttime;
}

public void setHidouttime(String hidouttime) {
	this.hidouttime = hidouttime;
}

public String getOutfuelval() {
	return outfuelval;
}

public void setOutfuelval(String outfuelval) {
	this.outfuelval = outfuelval;
}

	public int getClientnumbers() {
	return clientnumbers;
}

public void setClientnumbers(int clientnumbers) {
	this.clientnumbers = clientnumbers;
}

	public String getHidebranch() {
	return hidebranch;
}

public void setHidebranch(String hidebranch) { 
	this.hidebranch = hidebranch;
}

public String getHidelocation() {
	return hidelocation;
}

public void setHidelocation(String hidelocation) { 
	this.hidelocation = hidelocation; 
}

	public String getHidcollecteddate() {
	return hidcollecteddate;
}

public void setHidcollecteddate(String hidcollecteddate) { 
	this.hidcollecteddate = hidcollecteddate;
}

public String getHideIndate() {
	return hideIndate;
}

public void setHideIndate(String hideIndate) {
	this.hideIndate = hideIndate;
}

	public int getCollectintickval() {
	return collectintickval;
}

public void setCollectintickval(int collectintickval) {
	this.collectintickval = collectintickval;
}

	public String getCollectiondriver() {
	return collectiondriver;
}

public void setCollectiondriver(String collectiondriver) {  
	this.collectiondriver = collectiondriver;
}


public int getColldriverid() {
	return colldriverid;
}

public void setColldriverid(int colldriverid) {
	this.colldriverid = colldriverid;
}

public String getColleteddate() {
	return colleteddate;
}

public void setColleteddate(String colleteddate) {
	this.colleteddate = colleteddate;
}

public String getCollectedtime() {
	return collectedtime;
}

public void setCollectedtime(String collectedtime) {
	this.collectedtime = collectedtime;
}

public String getColletedkm() {
	return colletedkm;
}

public void setColletedkm(String colletedkm) {
	this.colletedkm = colletedkm;
}

public String getCollectedfuel() {
	return collectedfuel;
}

public void setCollectedfuel(String collectedfuel) {
	this.collectedfuel = collectedfuel;
}

public String getInbranch() { 
	return inbranch;
}

public void setInbranch(String inbranch) {
	this.inbranch = inbranch;
}

public String getInlocation() {
	return inlocation;
}

public void setInlocation(String inlocation) {
	this.inlocation = inlocation;
}

public String getIndate() {
	return indate;
}

public void setIndate(String indate) {
	this.indate = indate;
}

public String getIntime() {
	return intime;
}

public void setIntime(String intime) {
	this.intime = intime;
}

public String getBinkm() {
	return binkm;
}

public void setBinkm(String binkm) {
	this.binkm = binkm;
}

public String getBinfuel() {
	return binfuel;
}

public void setBinfuel(String binfuel) {
	this.binfuel = binfuel;
}



public String getHidcollectedTime() {
	return hidcollectedTime;
}
 
public void setHidcollectedTime(String hidcollectedTime) { 
	this.hidcollectedTime = hidcollectedTime;
}

public String getHidcollectedFuelval() {
	return hidcollectedFuelval;
}

public void setHidcollectedFuelval(String hidcollectedFuelval) {
	this.hidcollectedFuelval = hidcollectedFuelval;
}


public String getHideIntime() {
	return hideIntime;
}

public void setHideIntime(String hideIntime) {
	this.hideIntime = hideIntime;
}

public String getInFuelval() {
	return inFuelval;
}

public void setInFuelval(String inFuelval) {
	this.inFuelval = inFuelval;
}

	public String getHidertimeout() {
		return hidertimeout;
	}

	public void setHidertimeout(String hidertimeout) {
		this.hidertimeout = hidertimeout;
	}

	public String getTxtbranch() { 
		return txtbranch;
	}

	public void setTxtbranch(String txtbranch) {
		this.txtbranch = txtbranch;
	}

	public String getTxtlocation() {
		return txtlocation;
	}

	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}

	public String getHidedate() {
		return hidedate;
	}

	public void setHidedate(String hidedate) { 
		this.hidedate = hidedate;
	}

	public String getHiderefdate() {
		return hiderefdate;
	}

	public void setHiderefdate(String hiderefdate) {
		this.hiderefdate = hiderefdate;
	}

	public String getHideroutdate() {
		return hideroutdate;
	}

	public void setHideroutdate(String hideroutdate) {
		this.hideroutdate = hideroutdate;
	}

	public String getRfuelval() {
		return rfuelval;
	}

	public void setRfuelval(String rfuelval) {
		this.rfuelval = rfuelval;
	}

	public String getRenttypeval() {
		return renttypeval;
	}

	public void setRenttypeval(String renttypeval) {
		this.renttypeval = renttypeval;
	}

	public String getRefdate() {
		return refdate;
	}

	public void setRefdate(String refdate) {
		this.refdate = refdate;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getCmbrentaltype() {
		return cmbrentaltype;
	}

	public void setCmbrentaltype(String cmbrentaltype) {
		this.cmbrentaltype = cmbrentaltype;
	}

	public String getRefname() { 
		return refname;
	}

	public void setRefname(String refname) { 
		this.refname = refname;
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

	public String getTimeout() { 
		return timeout;
	}

	public void setTimeout(String timeout) {
		this.timeout = timeout;
	}


	public String getCmbfuel() {
		return cmbfuel;
	}

	public void setCmbfuel(String cmbfuel) {
		this.cmbfuel = cmbfuel;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getInfleettrancode() {
		return infleettrancode;
	}

	public void setInfleettrancode(String infleettrancode) {
		this.infleettrancode = infleettrancode;
	}

	public int getRefno() {
		return refno;
	}

	public void setRefno(int refno) {
		this.refno = refno;
	}

	public int getTxtfleetno() {
		return txtfleetno;
	}
	public void setTxtfleetno(int txtfleetno) {
		this.txtfleetno = txtfleetno;
	}
	public int getMainbranchid() {
		return mainbranchid;
	}

	public void setMainbranchid(int mainbranchid) {
		this.mainbranchid = mainbranchid;
	}
	public int getMainlocationid() {
		return mainlocationid;
	}
	public void setMainlocationid(int mainlocationid) {
		this.mainlocationid = mainlocationid;
	}

	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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




	public String getOutkm() {
		return outkm;
	}

	public void setOutkm(String outkm) {
		this.outkm = outkm;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String saveAction() throws  SQLException
	
	
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		String mode=getMode();

		if(mode.equalsIgnoreCase("A"))
		{
			//System.out.println("------------getMasterrefno()-------"+getMasterrefno());
			java.sql.Date masterDate=commDAO.changeStringtoSqlDate(getDate());
			java.sql.Date srenralrefdate = commDAO.changeStringtoSqlDate(getRefdate());
			java.sql.Date rentdateout = commDAO.changeStringtoSqlDate(getDateout());
			
			
			java.sql.Date sqlcoldate =null;
			if(getCollectintickval()>0)
			{
				
				sqlcoldate = commDAO.changeStringtoSqlDate(getColleteddate());
				
			}
			java.sql.Date sqlindate = commDAO.changeStringtoSqlDate(getIndate());
			
			
			int val=CustodyDAO.insert(masterDate,srenralrefdate,getCmbrentaltype(),getMasterrefno(),rentdateout,getTimeout(),getOutkm(),
					getCmbfuel(),getTxtfleetno(),getReason(),getInfleettrancode(),getMainbranchid(),getMainlocationid(),mode,
					getColldriverid(),sqlcoldate,getCollectedtime(),getColletedkm(),getCollectedfuel(),getCollectintickval(),
					getInbranch(),getInlocation(),sqlindate,getIntime(),getBinkm(),getBinfuel(),getClientnumbers(),getFormdetailcode(),session,getSearchbranch(),getDescnew());
			
			if(val>0)
			{
				//System.out.println("------------getMasterrefno()-------"+getMasterrefno());		
				setDocno(val);
				setHidedate(masterDate.toString()); 
				setHiderefdate(srenralrefdate.toString()) ;
				setHideroutdate(rentdateout.toString()); 
			    setHidertimeout(getTimeout());
			    setSearchbranchval(getSearchbranch());
			    setDescnew(getDescnew());
				if(getCollectintickval()>0)
				{
				 setCollectiondriver(getCollectiondriver());
				 setColldriverid(getColldriverid());
				 setHidcollecteddate(sqlcoldate.toString());
				 setHidcollectedTime(getCollectedtime());
				 setHidcollectedFuelval(getCollectedfuel());
				 setCollectintickval(getCollectintickval());
				}
		
				setHideIntime(getIntime());
				setBinkm(getBinkm());
				setInFuelval(getBinfuel());
				setHideIndate(sqlindate.toString());
			
				
				setHidebranch(getInbranch());  
				setHidelocation(getInlocation());
				
				  setMasterrefno(getMasterrefno());
				setData(); 
                setMsg("Successfully Saved");
				return "success";
			}
			
			else
			{
				setDescnew(getDescnew());
				setHidedate(masterDate.toString()); 
				setHiderefdate(srenralrefdate.toString()) ;
				setHideroutdate(rentdateout.toString()); 
				setHidertimeout(getTimeout());
				  setSearchbranchval(getSearchbranch());
				if(getCollectintickval()>0)
				{
				 setCollectiondriver(getCollectiondriver());
				 setColldriverid(getColldriverid());
				 setHidcollecteddate(sqlcoldate.toString());
				 setHidcollectedTime(getCollectedtime());
				 setHidcollectedFuelval(getCollectedfuel());
				 setColletedkm(getColletedkm());
				 setCollectintickval(getCollectintickval());
				}
		
				setHideIntime(getIntime());
				setBinkm(getBinkm());
				setInFuelval(getBinfuel());
				setHideIndate(sqlindate.toString());
				
				
				setHidebranch(getInbranch());  
				setHidelocation(getInlocation());
				  setMasterrefno(getMasterrefno());
				setData();
				setMsg("Not Saved");
				return "fail";
				
			}
			
		}
		
		
		
			  else if(mode.equalsIgnoreCase("OUT")){
				  java.sql.Date branchoutdate=commDAO.changeStringtoSqlDate(getOutdate());
				int ret=CustodyDAO.update(branchoutdate,getOuttime(),getBoutkm(),getBoutfuel(),getDocno(),getDelyesorno(),getMasterrefno(),getTxtfleetno(),session,getOutdesc());  
				  if(ret>0)
				  {
					  
					  setOutdesc(getOutdesc());
					  setDescnew(getDescnew());
					  setDocno(getDocno());
					  setHidoutdate(branchoutdate.toString());
					  setHidouttime(getOuttime());
					  setBoutkm(getBoutkm());
					  setOutfuelval(getBoutfuel());
					  setDelyornval(getDelyesorno());
					  setSearchbranchval(getSearchbranch());
					  setMasterrefno(getMasterrefno());
					  setBranchoutval(1);
					  setMsg("Updated Successfully");
		  				return "success";
				  }
				  else
				  {
					  setDescnew(getDescnew());
					  setOutdesc(getOutdesc());
					  setSearchbranchval(getSearchbranch());
		  				 setDocno(getDocno());
						  setHidoutdate(branchoutdate.toString());
						  setHidouttime(getOuttime());
						  setBoutkm(getBoutkm());
						  setOutfuelval(getBoutfuel());
						  setDelyornval(getDelyesorno());
						  setBranchoutval(getBranchoutval());
						  setMasterrefno(getMasterrefno());
		  				setMsg("Not Updated");
		  				return "fail";
		  			}  
				  }
				  
/*		getDeldriver() getDeliveryto() getDeldate() getDeltime() 
        getDelkm() getDelfuel()  getHiddeldate() getHiddeltime() getHiddelfuelval()  getDelchkval()  getDeldriverid()*/
		
		
	
		  
		  else if(mode.equalsIgnoreCase("DLY")){
			  java.sql.Date deldate=commDAO.changeStringtoSqlDate(getDeldate());
			  

			  
			int retu=CustodyDAO.delupdate(getDeldriverid(),getDeliveryto(),deldate,getDeltime(),getDelkm(),getDelfuel(),getDocno(),getMasterrefno(),getTxtfleetno(),session);  
			  if(retu>0)
			  {
				  setDescnew(getDescnew());
				  setDocno(getDocno());
				  setSearchbranchval(getSearchbranch());
				  setDeldriver(getDeldriver());
				  setDeliveryto(getDeliveryto());
				  setHiddeldate(deldate.toString());
				  setHiddeltime(getDeltime());
				  setDelkm(getDelkm());
				  setHiddelfuelval(getDelfuel());
				  setDeldriverid(getDeldriverid());
				  setDelchkval(getDelchkval());
				  setMasterrefno(getMasterrefno());
				  setOutdesc(getOutdesc());
				  setMsg("Updated Successfully");
	  				return "success";
			  }
			  else
			  {
				
				  setDescnew(getDescnew());
				  setDocno(getDocno());
				  setDeldriver(getDeldriver());
				  setDeliveryto(getDeliveryto());
				  setHiddeldate(deldate.toString());
				  setHiddeltime(getDeltime());
				  setSearchbranchval(getSearchbranch());
				  setDelkm(getDelkm());
				  setHiddelfuelval(getDelfuel());
				  setDeldriverid(getDeldriverid());
				  setDelchkval(getDelchkval());
				  setMasterrefno(getMasterrefno());
				  setOutdesc(getOutdesc());
	  				setMsg("Not Updated");
	  				return "fail";
	  			}  
			  }
		  else if(mode.equalsIgnoreCase("View")){
			  
			 viewbean=CustodyDAO.getViewDetails(getDocno()); 
			 setDocno(getDocno());
			 setHidedate(viewbean.getDate()); 
				setHiderefdate(viewbean.getRefdate()) ;
				setHideroutdate(viewbean.getDateout()); 
				setHidertimeout(viewbean.getTimeout());
				setDescnew(viewbean.getDescnew());
			     setRfuelval(viewbean.getCmbfuel());
		        setRenttypeval(viewbean.getCmbrentaltype());	
		        setRefno(viewbean.getRefno());
		        setOutkm(viewbean.getOutkm());
		        setTxtfleetno(viewbean.getTxtfleetno());
		        setReason(viewbean.getReason());
		        setMainbranchid(viewbean.getMainbranchid());
		        setMainlocationid(viewbean.getMainlocationid());
		        setTxtbranch(viewbean.getTxtbranch());
		        setTxtlocation(viewbean.getTxtlocation());
		        setRefname(viewbean.getRefname());
		        setTxtfleetname(viewbean.getTxtfleetname()); 
		        
		        setOutdesc(viewbean.getOutdesc());
		        setMasterrefno(viewbean.getMasterrefno());
		        //in
		        
		    	setHideIntime(viewbean.getIntime());
				setBinkm(viewbean.getBinkm());
				setInFuelval(viewbean.getBinfuel());
				setHideIndate(viewbean.getIndate());
				setHidebranch(viewbean.getInbranch());  
				setHidelocation(viewbean.getInlocation());
				//col
				
				setCollectiondriver(viewbean.getCollectiondriver());
				 setColldriverid(viewbean.getColldriverid());
				 setHidcollecteddate(viewbean.getColleteddate());
				 setHidcollectedTime(viewbean.getCollectedtime());
				 setHidcollectedFuelval(viewbean.getCollectedfuel());
				 setCollectintickval(viewbean.getCollectintickval());
				 setColletedkm(viewbean.getColletedkm());
				 
				 //out
			
				  setHidoutdate(viewbean.getOutdate());
				  setHidouttime(viewbean.getOuttime());
				  setBoutkm(viewbean.getBoutkm());
				  setOutfuelval(viewbean.getBoutfuel());
				  setDelyornval(viewbean.getDelyesorno());
				  setBranchoutval(viewbean.getBranchoutval());
				 //del
				  
				  setDeldriver(viewbean.getDeldriver());
				  setDeliveryto(viewbean.getDeliveryto());
				  setHiddeldate(viewbean.getDeldate());
				  setHiddeltime(viewbean.getDeltime());
				  setDelkm(viewbean.getDelkm());
				  setHiddelfuelval(viewbean.getDelfuel());
				  setDeldriverid(viewbean.getDeldriverid());
				  setDelchkval(viewbean.getDelchkval());
				  setSearchbranchval(viewbean.getSearchbranch());
				  
				return "success";
		  }
		
		return "fail";
	}
	
	public void setData()
	{
	
		setRfuelval(getCmbfuel());
        setRenttypeval(getCmbrentaltype());	
        setRefno(getRefno());
      
        setOutkm(getOutkm());
        setTxtfleetno(getTxtfleetno());
        setReason(getReason());
        setMainbranchid(getMainbranchid());
        setMainlocationid(getMainlocationid());
        setTxtbranch(getTxtbranch());
        setTxtlocation(getTxtlocation());
        setRefname(getRefname());
        setTxtfleetname(getTxtfleetname()); 
       setDescnew(getDescnew());
		setOutdesc(getOutdesc());
		
	}

	
	public String printAction() throws  SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		 ClsCustodyBean printbean=new ClsCustodyBean();
		 printbean=CustodyDAO.getPrint(doc);
		 setBrwithcompany(printbean.getBrwithcompany());
		 setVrano(printbean.getVrano());;
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
