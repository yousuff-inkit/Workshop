package com.operations.vehicletransactions.replacementalfahim;

public class ClsReplacementAlFahimBean {
	//Master Data
		private int docno;
		private String date;
		private String hiddate;
		private String refdate;
		private String hidrefdate;
		private String refno;
		private String refvocno;
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
		
		//Vehicle In Info
		private String chkcollection;
		private int hidchkcollection;
		private String collectdriver;
		private String hidcollectdriver;
		private String oncollectdate;
		private String hidoncollectdate;
		private String oncollecttime;
		private String hidoncollecttime;
		private String oncollectkm;
		private String cmboncollectfuel;
		private String hidcmboncollectfuel;
		private String incollectdate;
		private String hidincollectdate;
		private String incollecttime;
		private String hidincollecttime;
		private String incollectkm;
		private String cmbincollectfuel;
		private String hidcmbincollectfuel;
		private String cmbinbranch;
		private String hidcmbinbranch;
		private String hidcmbinlocation;
		private String cmbinlocation;
		//Vehicle Out Info
		private String chkdelivery;
		private int hidchkdelivery;
		private String outbranch;
		private String hidoutbranch;
		private String outlocation;
		private String hidoutlocation;
		private String txtoutfleetno;
		private String txtoutfleetname;
		private String deliveryto;
		private String deliverydriver;
		private String hiddeliverydriver;
		private String deliveryoutdate;
		private String hiddeliveryoutdate;
		private String deliveryouttime;
		private String hiddeliveryouttime;
		private String deliveryoutkm;
		private String cmbdeliveryoutfuel;
		private String hidcmbdeliveryoutfuel;
		private String outuser;
		private String hidoutuser;
		private String ondeliverydate;
		private String hidondeliverydate;
		private String ondeliverytime;
		private String hidondeliverytime;
		private String ondeliverykm;
		private String cmbondeliveryfuel;
		private String hidcmbondeliveryfuel;
		//Other
		private String mode;
		private String deleted;
		private String dtype;
		
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
			
		public String getLbldrivenby() {
				return lbldrivenby;
			}
			public void setLbldrivenby(String lbldrivenby) {
				this.lbldrivenby = lbldrivenby;
			}
		public String getLbldescription() {
				return lbldescription;
			}
			public void setLbldescription(String lbldescription) {
				this.lbldescription = lbldescription;
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
		public String getInfleettrancode() {
				return infleettrancode;
			}
			public void setInfleettrancode(String infleettrancode) {
				this.infleettrancode = infleettrancode;
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
		public String getLblrlocation() {
				return lblrlocation;
			}
			public void setLblrlocation(String lblrlocation) {
				this.lblrlocation = lblrlocation;
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
		public String getOutlocation() {
			return outlocation;
		}
		public void setOutlocation(String outlocation) {
			this.outlocation = outlocation;
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
		public String getChkcollection() {
			return chkcollection;
		}
		public void setChkcollection(String chkcollection) {
			this.chkcollection = chkcollection;
		}
		public int getHidchkcollection() {
			return hidchkcollection;
		}
		public void setHidchkcollection(int hidchkcollection) {
			this.hidchkcollection = hidchkcollection;
		}
		public String getCollectdriver() {
			return collectdriver;
		}
		public void setCollectdriver(String collectdriver) {
			this.collectdriver = collectdriver;
		}
		public String getHidcollectdriver() {
			return hidcollectdriver;
		}
		public void setHidcollectdriver(String hidcollectdriver) {
			this.hidcollectdriver = hidcollectdriver;
		}
		public String getOncollectdate() {
			return oncollectdate;
		}
		public void setOncollectdate(String oncollectdate) {
			this.oncollectdate = oncollectdate;
		}
		public String getHidoncollectdate() {
			return hidoncollectdate;
		}
		public void setHidoncollectdate(String hidoncollectdate) {
			this.hidoncollectdate = hidoncollectdate;
		}
		public String getOncollecttime() {
			return oncollecttime;
		}
		public void setOncollecttime(String oncollecttime) {
			this.oncollecttime = oncollecttime;
		}
		public String getHidoncollecttime() {
			return hidoncollecttime;
		}
		public void setHidoncollecttime(String hidoncollecttime) {
			this.hidoncollecttime = hidoncollecttime;
		}
		public String getOncollectkm() {
			return oncollectkm;
		}
		public void setOncollectkm(String oncollectkm) {
			this.oncollectkm = oncollectkm;
		}
		public String getCmboncollectfuel() {
			return cmboncollectfuel;
		}
		public void setCmboncollectfuel(String cmboncollectfuel) {
			this.cmboncollectfuel = cmboncollectfuel;
		}
		public String getHidcmboncollectfuel() {
			return hidcmboncollectfuel;
		}
		public void setHidcmboncollectfuel(String hidcmboncollectfuel) {
			this.hidcmboncollectfuel = hidcmboncollectfuel;
		}
		public String getIncollectdate() {
			return incollectdate;
		}
		public void setIncollectdate(String incollectdate) {
			this.incollectdate = incollectdate;
		}
		public String getHidincollectdate() {
			return hidincollectdate;
		}
		public void setHidincollectdate(String hidincollectdate) {
			this.hidincollectdate = hidincollectdate;
		}
		public String getIncollecttime() {
			return incollecttime;
		}
		public void setIncollecttime(String incollecttime) {
			this.incollecttime = incollecttime;
		}
		public String getHidincollecttime() {
			return hidincollecttime;
		}
		public void setHidincollecttime(String hidincollecttime) {
			this.hidincollecttime = hidincollecttime;
		}
		public String getIncollectkm() {
			return incollectkm;
		}
		public void setIncollectkm(String incollectkm) {
			this.incollectkm = incollectkm;
		}
		public String getCmbincollectfuel() {
			return cmbincollectfuel;
		}
		public void setCmbincollectfuel(String cmbincollectfuel) {
			this.cmbincollectfuel = cmbincollectfuel;
		}
		public String getHidcmbincollectfuel() {
			return hidcmbincollectfuel;
		}
		public void setHidcmbincollectfuel(String hidcmbincollectfuel) {
			this.hidcmbincollectfuel = hidcmbincollectfuel;
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
		public String getHidcmbinlocation() {
			return hidcmbinlocation;
		}
		public void setHidcmbinlocation(String hidcmbinlocation) {
			this.hidcmbinlocation = hidcmbinlocation;
		}
		public String getCmbinlocation() {
			return cmbinlocation;
		}
		public void setCmbinlocation(String cmbinlocation) {
			this.cmbinlocation = cmbinlocation;
		}
		public String getChkdelivery() {
			return chkdelivery;
		}
		public void setChkdelivery(String chkdelivery) {
			this.chkdelivery = chkdelivery;
		}
		public int getHidchkdelivery() {
			return hidchkdelivery;
		}
		public void setHidchkdelivery(int hidchkdelivery) {
			this.hidchkdelivery = hidchkdelivery;
		}
		public String getOutbranch() {
			return outbranch;
		}
		public void setOutbranch(String outbranch) {
			this.outbranch = outbranch;
		}
		public String getHidoutbranch() {
			return hidoutbranch;
		}
		public void setHidoutbranch(String hidoutbranch) {
			this.hidoutbranch = hidoutbranch;
		}
		public String getHidoutlocation() {
			return hidoutlocation;
		}
		public void setHidoutlocation(String hidoutlocation) {
			this.hidoutlocation = hidoutlocation;
		}
		public String getTxtoutfleetno() {
			return txtoutfleetno;
		}
		public void setTxtoutfleetno(String txtoutfleetno) {
			this.txtoutfleetno = txtoutfleetno;
		}
		public String getTxtoutfleetname() {
			return txtoutfleetname;
		}
		public void setTxtoutfleetname(String txtoutfleetname) {
			this.txtoutfleetname = txtoutfleetname;
		}
		public String getDeliveryto() {
			return deliveryto;
		}
		public void setDeliveryto(String deliveryto) {
			this.deliveryto = deliveryto;
		}
		public String getDeliverydriver() {
			return deliverydriver;
		}
		public void setDeliverydriver(String deliverydriver) {
			this.deliverydriver = deliverydriver;
		}
		public String getHiddeliverydriver() {
			return hiddeliverydriver;
		}
		public void setHiddeliverydriver(String hiddeliverydriver) {
			this.hiddeliverydriver = hiddeliverydriver;
		}
		public String getDeliveryoutdate() {
			return deliveryoutdate;
		}
		public void setDeliveryoutdate(String deliveryoutdate) {
			this.deliveryoutdate = deliveryoutdate;
		}
		public String getHiddeliveryoutdate() {
			return hiddeliveryoutdate;
		}
		public void setHiddeliveryoutdate(String hiddeliveryoutdate) {
			this.hiddeliveryoutdate = hiddeliveryoutdate;
		}
		public String getDeliveryouttime() {
			return deliveryouttime;
		}
		public void setDeliveryouttime(String deliveryouttime) {
			this.deliveryouttime = deliveryouttime;
		}
		public String getHiddeliveryouttime() {
			return hiddeliveryouttime;
		}
		public void setHiddeliveryouttime(String hiddeliveryouttime) {
			this.hiddeliveryouttime = hiddeliveryouttime;
		}
		public String getDeliveryoutkm() {
			return deliveryoutkm;
		}
		public void setDeliveryoutkm(String deliveryoutkm) {
			this.deliveryoutkm = deliveryoutkm;
		}
		public String getCmbdeliveryoutfuel() {
			return cmbdeliveryoutfuel;
		}
		public void setCmbdeliveryoutfuel(String cmbdeliveryoutfuel) {
			this.cmbdeliveryoutfuel = cmbdeliveryoutfuel;
		}
		public String getHidcmbdeliveryoutfuel() {
			return hidcmbdeliveryoutfuel;
		}
		public void setHidcmbdeliveryoutfuel(String hidcmbdeliveryoutfuel) {
			this.hidcmbdeliveryoutfuel = hidcmbdeliveryoutfuel;
		}
		public String getOutuser() {
			return outuser;
		}
		public void setOutuser(String outuser) {
			this.outuser = outuser;
		}
		public String getHidoutuser() {
			return hidoutuser;
		}
		public void setHidoutuser(String hidoutuser) {
			this.hidoutuser = hidoutuser;
		}
		public String getOndeliverydate() {
			return ondeliverydate;
		}
		public void setOndeliverydate(String ondeliverydate) {
			this.ondeliverydate = ondeliverydate;
		}
		public String getHidondeliverydate() {
			return hidondeliverydate;
		}
		public void setHidondeliverydate(String hidondeliverydate) {
			this.hidondeliverydate = hidondeliverydate;
		}
		public String getOndeliverytime() {
			return ondeliverytime;
		}
		public void setOndeliverytime(String ondeliverytime) {
			this.ondeliverytime = ondeliverytime;
		}
		public String getHidondeliverytime() {
			return hidondeliverytime;
		}
		public void setHidondeliverytime(String hidondeliverytime) {
			this.hidondeliverytime = hidondeliverytime;
		}
		public String getOndeliverykm() {
			return ondeliverykm;
		}
		public void setOndeliverykm(String ondeliverykm) {
			this.ondeliverykm = ondeliverykm;
		}
		public String getCmbondeliveryfuel() {
			return cmbondeliveryfuel;
		}
		public void setCmbondeliveryfuel(String cmbondeliveryfuel) {
			this.cmbondeliveryfuel = cmbondeliveryfuel;
		}
		public String getHidcmbondeliveryfuel() {
			return hidcmbondeliveryfuel;
		}
		public void setHidcmbondeliveryfuel(String hidcmbondeliveryfuel) {
			this.hidcmbondeliveryfuel = hidcmbondeliveryfuel;
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
		public String getDtype() {
			return dtype;
		}
		public void setDtype(String dtype) {
			this.dtype = dtype;
		}
		
		
		
		//Getters and setters for Print
		
		
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

		//Getters for Print
		
		
		
		

	}
