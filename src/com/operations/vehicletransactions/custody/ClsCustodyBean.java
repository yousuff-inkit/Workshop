package com.operations.vehicletransactions.custody;



public class ClsCustodyBean
{
	
	private String date,cmbrentaltype,refname,refdate,txtfleetname,dateout,timeout,cmbfuel,reason,infleettrancode,outkm,txtbranch,txtlocation;
	private int refno,txtfleetno,mainbranchid,mainlocationid,docno,masterrefno;
	private int colldriverid,collectintickval,searchbranch;
	private String collectiondriver,colleteddate,collectedtime,colletedkm,collectedfuel;
    private String inbranch,inlocation,indate,intime,binkm,binfuel;
    private String descnew;
    private String outdesc;
    
    
  //------------------------------------------------------------------

  		public String getOutdesc() {
		return outdesc;
	}
	public void setOutdesc(String outdesc) {
		this.outdesc = outdesc;
	}

		private String companyname,address,mobileno,fax,location,barnchval;
  		
  		
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
  		

    
	public int getSearchbranch() {
		return searchbranch;
	}
	public void setSearchbranch(int searchbranch) {
		this.searchbranch = searchbranch;
	}
	public int getMasterrefno() {
		return masterrefno;
	}
	public void setMasterrefno(int masterrefno) {
		this.masterrefno = masterrefno;
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
	public String getRefdate() {
		return refdate;
	}
	public void setRefdate(String refdate) {
		this.refdate = refdate;
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
	public String getOutkm() {
		return outkm;
	}
	public void setOutkm(String outkm) {
		this.outkm = outkm;
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
	
	//////////
	
	
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
	public int getCollectintickval() {
		return collectintickval;
	}
	public void setCollectintickval(int collectintickval) {
		this.collectintickval = collectintickval;
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
	
	
	//===================================
	
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

//----------------------------------------------------   
   
	 private String  outdate,outtime,boutkm,boutfuel,delyornval,delyesorno;
	
	  private int branchoutval;
	  
	  
	  
	public int getBranchoutval() {
		return branchoutval;
	}
	public void setBranchoutval(int branchoutval) {
		this.branchoutval = branchoutval;
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

	   private String deldriver,deliveryto,deldate,deltime,delkm,delfuel;
	   private int delchkval,deldriverid;

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
	public int getDelchkval() {
		return delchkval;
	}
	public void setDelchkval(int delchkval) {
		this.delchkval = delchkval;
	}
	public int getDeldriverid() {
		return deldriverid;
	}
	public void setDeldriverid(int deldriverid) {
		this.deldriverid = deldriverid;
	}
   
   
   
   
   
	
}
