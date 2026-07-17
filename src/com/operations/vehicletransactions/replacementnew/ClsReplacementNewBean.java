package com.operations.vehicletransactions.replacementnew;

public class ClsReplacementNewBean {
	private int docno;
	private String date;
	private String hiddate;
	private String refdate;
	private String hidrefdate;
	private String refno;
	private String refvocno;

	private String refname;
	private String cmbagmtbranch;
	private String hidcmbagmtbranch;
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
	
	
	
	public String getRefvocno() {
		return refvocno;
	}
	public void setRefvocno(String refvocno) {
		this.refvocno = refvocno;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getHidcmbcolcollectfuel() {
		return hidcmbcolcollectfuel;
	}


	public void setHidcmbcolcollectfuel(String hidcmbcolcollectfuel) {
		this.hidcmbcolcollectfuel = hidcmbcolcollectfuel;
	}


	//Collection Delivery Info
	private String coldeldriver,hidcoldeldriver,coldeliveryto,coldeldate,hidcoldeldate,coldeltime,hidcoldeltime,coldelkm,cmbcoldelfuel,hidcmbcoldelfuel,chkdelivery,hidchkdelivery;
	
	
	//Collection In Info
	
	private String cmbcolinbranch,hidcmbcolinbranch,cmbcolinlocation,hidcmbcolinlocation,colindate,hidcolindate,colintime,hidcolintime,colinkm,cmbcolinfuel,hidcmbcolinfuel;
	
	
	//Other Info
	
	private String mode,msg,deleted,formdetailcode,status;


	
	
	//------------------------------------------------------------------

			private String companyname,address,mobileno,fax,location,barnchval;
			
			private String brwithcompany,vrano,mtime,pfleetno,pfuel,popened,pclient,clientacno,agmt,pdocno,pdate,pregno,vradate,dtimes,replaced,reptype,pkm,poutdate,pdelivery;

		//------------------------------------------------------------------------------------
			
			
			//---------------------------------------------------------------------
			private String inbrwithcompany,invehdate,invehtime,invehkm,invehfuel,invehreason;
			
			private String newbrwithcompany,newvehoutdate,newvehouttime,newvehfleet,newvehregno,newvehkm,newvehfuel;
			
			
			
			private String delbrwithcompany,deldate,deltime,delfleet,delregno,delkm,delfuel;
			
			
			private String colbrwithcompany,coldate,coltime,colfleet,colregno,colkm,colfuel;
			
			private String lbldelivery,lblcollection,lblrlocation;
			private String lblinfleetname,lbloutfleetname,lbldelfleetname,lblcolfleetname;
			
			private String lblinlocation,lbloutlocation,lbldeldriver,lblcoldriver,lbldescription,lbldrivenby;
			
			
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


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getHidcmbcoloutfuel() {
		return hidcmbcoloutfuel;
	}


	public void setHidcmbcoloutfuel(String hidcmbcoloutfuel) {
		this.hidcmbcoloutfuel = hidcmbcoloutfuel;
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


	public String getHidatbranchoutlocation() {
		return hidatbranchoutlocation;
	}


	public void setHidatbranchoutlocation(String hidatbranchoutlocation) {
		this.hidatbranchoutlocation = hidatbranchoutlocation;
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


	public String getFormdetailcode() {
		return formdetailcode;
	}


	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}


	
	
	
	

}
