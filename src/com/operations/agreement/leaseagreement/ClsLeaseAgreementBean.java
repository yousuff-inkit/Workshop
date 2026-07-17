package com.operations.agreement.leaseagreement;

import java.util.*;

public class ClsLeaseAgreementBean {
	 
	  

	private String kmclient;
	private String kmdriver;
	private String kmvehicle;
	private String kmagmtno;
	private String kmmrano;
	private String kmdate;
	private String lblcompname;    
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lbltotalallowedkm;
	private String lblrateperkm;
	private String lbltotalusedkm;
	private String lbltotalexcesskmrate;
	private String lbltotalexcesskm;
	private String lbltotalexcesskmratewords;
	private String lblclstatus;
	private String Lblcosmoclienttel;
	
//=============================main=================================================================================================================
	
	public String getKmclient() {
		return kmclient;
	}

	public void setKmclient(String kmclient) {
		this.kmclient = kmclient;
	}

	public String getKmdriver() {
		return kmdriver;
	}

	public void setKmdriver(String kmdriver) {
		this.kmdriver = kmdriver;
	}

	public String getKmvehicle() {
		return kmvehicle;
	}

	public void setKmvehicle(String kmvehicle) {
		this.kmvehicle = kmvehicle;
	}

	public String getKmagmtno() {
		return kmagmtno;
	}

	public void setKmagmtno(String kmagmtno) {
		this.kmagmtno = kmagmtno;
	}

	public String getKmmrano() {
		return kmmrano;
	}

	public void setKmmrano(String kmmrano) {
		this.kmmrano = kmmrano;
	}

	public String getKmdate() {
		return kmdate;
	}

	public void setKmdate(String kmdate) {
		this.kmdate = kmdate;
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

	public String getLbltotalallowedkm() {
		return lbltotalallowedkm;
	}

	public void setLbltotalallowedkm(String lbltotalallowedkm) {
		this.lbltotalallowedkm = lbltotalallowedkm;
	}

	public String getLblrateperkm() {
		return lblrateperkm;
	}

	public void setLblrateperkm(String lblrateperkm) {
		this.lblrateperkm = lblrateperkm;
	}

	public String getLbltotalusedkm() {
		return lbltotalusedkm;
	}

	public void setLbltotalusedkm(String lbltotalusedkm) {
		this.lbltotalusedkm = lbltotalusedkm;
	}

	public String getLbltotalexcesskmrate() {
		return lbltotalexcesskmrate;
	}

	public void setLbltotalexcesskmrate(String lbltotalexcesskmrate) {
		this.lbltotalexcesskmrate = lbltotalexcesskmrate;
	}

	public String getLbltotalexcesskm() {
		return lbltotalexcesskm;
	}

	public void setLbltotalexcesskm(String lbltotalexcesskm) {
		this.lbltotalexcesskm = lbltotalexcesskm;
	}

	public String getLbltotalexcesskmratewords() {
		return lbltotalexcesskmratewords;
	}

	public void setLbltotalexcesskmratewords(String lbltotalexcesskmratewords) {
		this.lbltotalexcesskmratewords = lbltotalexcesskmratewords;
	}

	public String getLblclstatus() {
		return lblclstatus;
	}

	public void setLblclstatus(String lblclstatus) {
		this.lblclstatus = lblclstatus;
	}



	private int docno;
	private String date;
	private String hiddate;
	private int clientid;
	private int le_salmanid;
	private String clientName;
	private String salesmanName;
	private String le_clcodeno;
	private String le_clacno;
	private String description;
	private String cusaddress;
	private int additional_driver;
	private String add_driverName;
	private String adidrvcharges;
	private String ladriverlist;
	private int ladrivercheck;
	private String tempfleet;
	private String permanentfleet;
	private String fleetname;
	private int chkdelivery;
	private String dateout;
	private String timeout;
	private String kmout;
	private String cmbfuelout;
	private String deldateout;
	private String deltimeout;
	private String delkmout;
	private String cmbdelfuelout;
	private String m1;
	private String m2;
	private String m3;
	private String m4;
	private String m5;
	private String m6;
	private String m7;
	private String m8;
	private String m9;
	private String m10;
	private String amt1;
	private String amt2;
	private String amt3;
	private String amt4;
	private String amt5;
	private ArrayList tclList;
	private int del_chaufferid;
	private String client_driverid;
	private int client_driverdoc;
	private String chau_name;
	 private String chau_id;
	 private String sal_docno;
	 private int per_value;
		private int per_name;
		private int advance_chk;
		private int invoice;
		private int hidper_value;
		private int hidper_name;
		private int hidadvance_chk;
		private int hidinvoice,masterdoc_no;
		
		private String vehlocation,delcharges;
		 private String excessinsur;
		 private String deldrvname;
		 
		 
		 private int  deldrvid;	
		
		  private int  leaseprojectDoc;
		  
		  private String leasePo,leaseproject,termi1,termi2,termi3,termi4,termi5; 
		 
		 //mm
		
			private String deldates,deltimes,delkmins,delfuels,outdetails,deldetailss;

					//mm

					public String getOutdetails() {
						return outdetails;
					}

					public void setOutdetails(String outdetails) {
						this.outdetails = outdetails;
					}

					public String getDeldetailss() {
						return deldetailss;
					}

					public void setDeldetailss(String deldetailss) {
						this.deldetailss = deldetailss;
					}

					public String getDeldates() {
						return deldates;
					}

					public void setDeldates(String deldates) {
						this.deldates = deldates;
					}

					public String getDeltimes() {
						return deltimes;
					}

					public void setDeltimes(String deltimes) {
						this.deltimes = deltimes;
					}

					public String getDelkmins() {
						return delkmins;
					}

					public void setDelkmins(String delkmins) {
						this.delkmins = delkmins;
					}

					public String getDelfuels() {
						return delfuels;
					}

					public void setDelfuels(String delfuels) {
						this.delfuels = delfuels;
					}


			
		  private String salname,leasestatus;
			
			public String getLeasestatus() {
			return leasestatus;
		}

		public void setLeasestatus(String leasestatus) {
			this.leasestatus = leasestatus;
		}

	public String getSalname() {
			return salname;
		}

		public void setSalname(String salname) {
			this.salname = salname;
		}
			
	
	  public String getTermi1() {
			return termi1;
		}

		public void setTermi1(String termi1) {    
			this.termi1 = termi1;
		}

		public String getTermi2() {
			return termi2;
		}

		public void setTermi2(String termi2) {
			this.termi2 = termi2;
		}

		public String getTermi3() {
			return termi3;
		}

		public void setTermi3(String termi3) {
			this.termi3 = termi3;
		}
		public String getTermi4() {
				return termi4;
			}

			public void setTermi4(String termi4) {
				this.termi4 = termi4;
			}
			public String getTermi5() {
				return termi5;
			}

			public void setTermi5(String termi5) {
				this.termi5 = termi5;
			}
	public int getLeaseprojectDoc() {
			return leaseprojectDoc;
		}

		public void setLeaseprojectDoc(int leaseprojectDoc) {
			this.leaseprojectDoc = leaseprojectDoc;
		}

		public String getLeasePo() {
			return leasePo;
		}

		public void setLeasePo(String leasePo) {
			this.leasePo = leasePo;
		}

		public String getLeaseproject() {
			return leaseproject;
		}

		public void setLeaseproject(String leaseproject) {
			this.leaseproject = leaseproject;
		}

	public int getMasterdoc_no() {
			return masterdoc_no;
		}

		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}

	public String getDeldrvname() {
			return deldrvname;
		}

		public void setDeldrvname(String deldrvname) {
			this.deldrvname = deldrvname;
		}

		public int getDeldrvid() {
			return deldrvid;
		}

		public void setDeldrvid(int deldrvid) { 
			this.deldrvid = deldrvid;
		}

	public String getExcessinsur() {
			return excessinsur;
		}

		public void setExcessinsur(String excessinsur) {
			this.excessinsur = excessinsur;
		}

	public String getDelcharges() {
			return delcharges;
		}

		public void setDelcharges(String delcharges) {
			this.delcharges = delcharges;
		}

	public String getVehlocation() {
			return vehlocation;
		}

		public void setVehlocation(String vehlocation) {
			this.vehlocation = vehlocation;
		}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getSalesmanName() {
		return salesmanName;
	}

	public void setSalesmanName(String salesmanName) {
		this.salesmanName = salesmanName;
	}

	public String getAdd_driverName() {
		return add_driverName;
	}

	public void setAdd_driverName(String add_driverName) {
		this.add_driverName = add_driverName;
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
	
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	
	
	public int getLe_salmanid() {
		return le_salmanid;
	}
	public void setLe_salmanid(int le_salmanid) {
		this.le_salmanid = le_salmanid;
	}
	public String getLe_clcodeno() {
		return le_clcodeno;
	}
	public void setLe_clcodeno(String le_clcodeno) {
		this.le_clcodeno = le_clcodeno;
	}
	public String getLe_clacno() {
		return le_clacno;
	}
	public void setLe_clacno(String le_clacno) {
		this.le_clacno = le_clacno;
	}

	 public String getCusaddress() {
			return cusaddress;
	}
	public void setCusaddress(String cusaddress) {
		this.cusaddress = cusaddress;
	}
	public String getLadriverlist() {
		return ladriverlist;
	}
	public void setLadriverlist(String ladriverlist) {
		this.ladriverlist = ladriverlist;
	}
	
	public int getAdditional_driver() {
		return additional_driver;
	}
	public void setAdditional_driver(int additional_driver) {
		this.additional_driver = additional_driver;
	}
	public String getAdidrvcharges() {
		return adidrvcharges;
	}
	public void setAdidrvcharges(String adidrvcharges) {
		this.adidrvcharges = adidrvcharges;
	}
	
	public int getLadrivercheck() {
		return ladrivercheck;
	}
	public void setLadrivercheck(int ladrivercheck) {
		this.ladrivercheck = ladrivercheck;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTempfleet() {
		return tempfleet;
	}
	public void setTempfleet(String tempfleet) {
		this.tempfleet = tempfleet;
	}
	public String getPermanentfleet() {
		return permanentfleet;
	}
	public void setPermanentfleet(String permanentfleet) {
		this.permanentfleet = permanentfleet;
	}
	public String getFleetname() {
		return fleetname;
	}
	public void setFleetname(String fleetname) {
		this.fleetname = fleetname;
	}
	public int getChkdelivery() {
		return chkdelivery;
	}
	public void setChkdelivery(int chkdelivery) {
		this.chkdelivery = chkdelivery;
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
	public String getKmout() {
		return kmout;
	}
	public void setKmout(String kmout) {
		this.kmout = kmout;
	}
	public String getCmbfuelout() {
		return cmbfuelout;
	}
	public void setCmbfuelout(String cmbfuelout) {
		this.cmbfuelout = cmbfuelout;
	}
	public String getDeldateout() {
		return deldateout;
	}
	public void setDeldateout(String deldateout) {
		this.deldateout = deldateout;
	}
	public String getDeltimeout() {
		return deltimeout;
	}
	public void setDeltimeout(String deltimeout) {
		this.deltimeout = deltimeout;
	}
	public String getDelkmout() {
		return delkmout;
	}
	public void setDelkmout(String delkmout) {
		this.delkmout = delkmout;
	}
	public String getCmbdelfuelout() {
		return cmbdelfuelout;
	}
	public void setCmbdelfuelout(String cmbdelfuelout) {
		this.cmbdelfuelout = cmbdelfuelout;
	}
	public String getM1() {
		return m1;
	}
	public void setM1(String m1) {
		this.m1 = m1;
	}
	public String getM2() {
		return m2;
	}
	public void setM2(String m2) {
		this.m2 = m2;
	}
	public String getM3() {
		return m3;
	}
	public void setM3(String m3) {
		this.m3 = m3;
	}
	public String getM4() {
		return m4;
	}
	public void setM4(String m4) {
		this.m4 = m4;
	}
	public String getM5() {
		return m5;
	}
	public void setM5(String m5) {
		this.m5 = m5;
	}
	public String getM6() {
		return m6;
	}
	public void setM6(String m6) {
		this.m6 = m6;
	}
	public String getM7() {
		return m7;
	}
	public void setM7(String m7) {
		this.m7 = m7;
	}
	public String getM8() {
		return m8;
	}
	public void setM8(String m8) {
		this.m8 = m8;
	}
	public String getM9() {
		return m9;
	}
	public void setM9(String m9) {
		this.m9 = m9;
	}
	public String getM10() {
		return m10;
	}
	public void setM10(String m10) {
		this.m10 = m10;
	}
	
	public String getAmt1() {
		return amt1;
	}
	public void setAmt1(String amt1) {
		this.amt1 = amt1;
	}
	public String getAmt2() {
		return amt2;
	}
	public void setAmt2(String amt2) {
		this.amt2 = amt2;
	}
	public String getAmt3() {
		return amt3;
	}
	public void setAmt3(String amt3) {
		this.amt3 = amt3;
	}
	public String getAmt4() {
		return amt4;
	}
	public void setAmt4(String amt4) {
		this.amt4 = amt4;
	}
	public String getAmt5() {
		return amt5;
	}
	public void setAmt5(String amt5) {
		this.amt5 = amt5;
	}
	public int getClient_driverdoc() {
		return client_driverdoc;
	}
	public void setClient_driverdoc(int client_driverdoc) {
		this.client_driverdoc = client_driverdoc;
	}
	public int getDel_chaufferid() {
		return del_chaufferid;
	}
	public void setDel_chaufferid(int del_chaufferid) {
		this.del_chaufferid = del_chaufferid;
	}
	
	public String getClient_driverid() {
		return client_driverid;
		}
		
		public void setClient_driverid(String client_driverid) {
		this.client_driverid = client_driverid;
		}


//grid
	
	// payment grid
		 private int paymentgridlength;
	
		 public int getPaymentgridlength() {
				return paymentgridlength;
			}
			public void setPaymentgridlength(int paymentgridlength) {
				this.paymentgridlength = paymentgridlength;
			}
			
		//  tariff grid
			private int tariffgridlength;
			
			public int getTariffgridlength() {
				return tariffgridlength;
			}
			
			public void setTariffgridlength(int tariffgridlength) {
				this.tariffgridlength = tariffgridlength;
			}
			
			
			// driver grid
			
			private int drivergridlength;
			
			public int getDrivergridlength() {
				return drivergridlength;
			}
			public void setDrivergridlength(int drivergridlength) {
				this.drivergridlength = drivergridlength;
			}

			public ArrayList getTclList() {
				return tclList;
			}

			public void setTclList(ArrayList tclList) {
				this.tclList = tclList;
			}

			public String getChau_name() {
				return chau_name;
			}

			public void setChau_name(String chau_name) {
				this.chau_name = chau_name;
			}

			public String getChau_id() {
				return chau_id;
			}

			public void setChau_id(String chau_id) {
				this.chau_id = chau_id;
			}

			public String getSal_docno() {
				return sal_docno;
			}

			public void setSal_docno(String sal_docno) {
				this.sal_docno = sal_docno;
			}

			public int getPer_value() {
				return per_value;
			}

			public void setPer_value(int per_value) {
				this.per_value = per_value;
			}

			public int getPer_name() {
				return per_name;
			}

			public void setPer_name(int per_name) {
				this.per_name = per_name;
			}

			public int getAdvance_chk() {
				return advance_chk;
			}

			public void setAdvance_chk(int advance_chk) {
				this.advance_chk = advance_chk;
			}

			public int getInvoice() {
				return invoice;
			}

			public void setInvoice(int invoice) {
				this.invoice = invoice;
			}

			public int getHidper_value() {
				return hidper_value;
			}

			public void setHidper_value(int hidper_value) {
				this.hidper_value = hidper_value;
			}

			public int getHidper_name() {
				return hidper_name;
			}

			public void setHidper_name(int hidper_name) {
				this.hidper_name = hidper_name;
			}

			public int getHidadvance_chk() {
				return hidadvance_chk;
			}

			public void setHidadvance_chk(int hidadvance_chk) {
				this.hidadvance_chk = hidadvance_chk;
			}

			public int getHidinvoice() {
				return hidinvoice;
			}

			public void setHidinvoice(int hidinvoice) {
				this.hidinvoice = hidinvoice;
			}
			
			
			
//===============================================================================================================================================
	  
	  
	  
			// --------------------------------------master down print-------------------------------------------------------------------
			 private String clname,claddress,clmobno,clemail,barnchval,mrano,rentaldoc,radrname,radlno,passno,licexpdate,passexpdate,dobdate;
			 
			 
				private String ravehname,ravehregno,ravehmodel,ravehgroup,radateout,ratimeout,raklmout; 
				 
				 
				 private String radaily,raweakly,ramonthly,tariff,racdwscdw,raaccessory,raadditionalcge,rafuelout,totalpaids,invamount,balance;
				 
				 private String inkm,infuel,indate,intime,docnoval,rastatus,rayom,racolor,adddrname1,adddrname2,addlicno1,addlicno2,expdate1,expdate2,adddob1,adddob2,raextrakm,raexxtakmchg,rarenttypes;

					private String companyname,address,mobileno,fax,location;



				public String getClname() {
					return clname;
				}

				public void setClname(String clname) {
					this.clname = clname;
				}

				public String getCladdress() {
					return claddress;
				}

				public void setCladdress(String claddress) {
					this.claddress = claddress;
				}

				public String getClmobno() {
					return clmobno;
				}

				public void setClmobno(String clmobno) {
					this.clmobno = clmobno;
				}

				public String getClemail() {
					return clemail;
				}

				public void setClemail(String clemail) {
					this.clemail = clemail;
				}

				public String getBarnchval() {
					return barnchval;
				}

				public void setBarnchval(String barnchval) {
					this.barnchval = barnchval;
				}

				public String getMrano() {
					return mrano;
				}

				public void setMrano(String mrano) {
					this.mrano = mrano;
				}

				public String getRentaldoc() {
					return rentaldoc;
				}

				public void setRentaldoc(String rentaldoc) {
					this.rentaldoc = rentaldoc;
				}

				public String getRadrname() {
					return radrname;
				}

				public void setRadrname(String radrname) {
					this.radrname = radrname;
				}

				public String getRadlno() {
					return radlno;
				}

				public void setRadlno(String radlno) {
					this.radlno = radlno;
				}

				public String getPassno() {
					return passno;
				}

				public void setPassno(String passno) {
					this.passno = passno;
				}

				public String getLicexpdate() {
					return licexpdate;
				}

				public void setLicexpdate(String licexpdate) {
					this.licexpdate = licexpdate;
				}

				public String getPassexpdate() {
					return passexpdate;
				}

				public void setPassexpdate(String passexpdate) {
					this.passexpdate = passexpdate;
				}

				public String getDobdate() {
					return dobdate;
				}

				public void setDobdate(String dobdate) {
					this.dobdate = dobdate;
				}

				public String getRavehname() {
					return ravehname;
				}

				public void setRavehname(String ravehname) {
					this.ravehname = ravehname;
				}

				public String getRavehregno() {
					return ravehregno;
				}

				public void setRavehregno(String ravehregno) {
					this.ravehregno = ravehregno;
				}

				public String getRavehmodel() {
					return ravehmodel;
				}

				public void setRavehmodel(String ravehmodel) {
					this.ravehmodel = ravehmodel;
				}

				public String getRavehgroup() {
					return ravehgroup;
				}

				public void setRavehgroup(String ravehgroup) {
					this.ravehgroup = ravehgroup;
				}

				public String getRadateout() {
					return radateout;
				}

				public void setRadateout(String radateout) {
					this.radateout = radateout;
				}

				public String getRatimeout() {
					return ratimeout;
				}

				public void setRatimeout(String ratimeout) {
					this.ratimeout = ratimeout;
				}

				public String getRaklmout() {
					return raklmout;
				}

				public void setRaklmout(String raklmout) {
					this.raklmout = raklmout;
				}

				public String getRadaily() {
					return radaily;
				}

				public void setRadaily(String radaily) {
					this.radaily = radaily;
				}

				public String getRaweakly() {
					return raweakly;
				}

				public void setRaweakly(String raweakly) {
					this.raweakly = raweakly;
				}

				public String getRamonthly() {
					return ramonthly;
				}

				public void setRamonthly(String ramonthly) {
					this.ramonthly = ramonthly;
				}

				public String getTariff() {
					return tariff;
				}

				public void setTariff(String tariff) {
					this.tariff = tariff;
				}

				public String getRacdwscdw() {
					return racdwscdw;
				}

				public void setRacdwscdw(String racdwscdw) {
					this.racdwscdw = racdwscdw;
				}

				public String getRaaccessory() {
					return raaccessory;
				}

				public void setRaaccessory(String raaccessory) {
					this.raaccessory = raaccessory;
				}

				public String getRaadditionalcge() {
					return raadditionalcge;
				}

				public void setRaadditionalcge(String raadditionalcge) {
					this.raadditionalcge = raadditionalcge;
				}

				public String getRafuelout() {
					return rafuelout;
				}

				public void setRafuelout(String rafuelout) {
					this.rafuelout = rafuelout;
				}

				public String getInkm() {
					return inkm;
				}

				public void setInkm(String inkm) {
					this.inkm = inkm;
				}

				public String getInfuel() {
					return infuel;
				}

				public void setInfuel(String infuel) {
					this.infuel = infuel;
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

				public String getDocnoval() {
					return docnoval;
				}

				public void setDocnoval(String docnoval) {
					this.docnoval = docnoval;
				}

				public String getRastatus() {
					return rastatus;
				}

				public void setRastatus(String rastatus) {
					this.rastatus = rastatus;
				}

				public String getRayom() {
					return rayom;
				}

				public void setRayom(String rayom) {
					this.rayom = rayom;
				}

				public String getRacolor() {
					return racolor;
				}

				public void setRacolor(String racolor) {
					this.racolor = racolor;
				}

				public String getAdddrname1() {
					return adddrname1;
				}

				public void setAdddrname1(String adddrname1) {
					this.adddrname1 = adddrname1;
				}

				public String getAdddrname2() {
					return adddrname2;
				}

				public void setAdddrname2(String adddrname2) {
					this.adddrname2 = adddrname2;
				}

				public String getAddlicno1() {
					return addlicno1;
				}

				public void setAddlicno1(String addlicno1) {
					this.addlicno1 = addlicno1;
				}

				public String getAddlicno2() {
					return addlicno2;
				}

				public void setAddlicno2(String addlicno2) {
					this.addlicno2 = addlicno2;
				}

				public String getExpdate1() {
					return expdate1;
				}

				public void setExpdate1(String expdate1) {
					this.expdate1 = expdate1;
				}

				public String getExpdate2() {
					return expdate2;
				}

				public void setExpdate2(String expdate2) {
					this.expdate2 = expdate2;
				}

				public String getAdddob1() {
					return adddob1;
				}

				public void setAdddob1(String adddob1) {
					this.adddob1 = adddob1;
				}

				public String getAdddob2() {
					return adddob2;
				}

				public void setAdddob2(String adddob2) {
					this.adddob2 = adddob2;
				}

				public String getRaextrakm() {
					return raextrakm;
				}

				public void setRaextrakm(String raextrakm) {
					this.raextrakm = raextrakm;
				}

				public String getRaexxtakmchg() {
					return raexxtakmchg;
				}

				public void setRaexxtakmchg(String raexxtakmchg) {
					this.raexxtakmchg = raexxtakmchg;
				}

				public String getRarenttypes() {
					return rarenttypes;
				}

				public void setRarenttypes(String rarenttypes) {
					this.rarenttypes = rarenttypes;
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
				
				
				
				
				
				
				
				
				
				
				
			// ----------------------------------------------main print----------------------------------------------------------------------
			
	  
	  
	  
				private String txtcustomersname,txtaddress,txtcontact,vehicledetails,vehduration,vehcostpermonth,kmrest,lbllessorcompany,clientnames;





				public String getTxtcustomersname() {
					return txtcustomersname;
				}

				public void setTxtcustomersname(String txtcustomersname) { 
					this.txtcustomersname = txtcustomersname;
				}

				public String getTxtaddress() {
					return txtaddress;
				}

				public void setTxtaddress(String txtaddress) {
					this.txtaddress = txtaddress;
				}

				public String getTxtcontact() {
					return txtcontact;
				}

				public void setTxtcontact(String txtcontact) {
					this.txtcontact = txtcontact;
				}

				public String getVehicledetails() {
					return vehicledetails;
				}

				public void setVehicledetails(String vehicledetails) {
					this.vehicledetails = vehicledetails;
				}

				public String getVehduration() {
					return vehduration;
				}

				public void setVehduration(String vehduration) {
					this.vehduration = vehduration;
				}

				public String getVehcostpermonth() {
					return vehcostpermonth;
				}

				public void setVehcostpermonth(String vehcostpermonth) {
					this.vehcostpermonth = vehcostpermonth;
				}

				public String getKmrest() {
					return kmrest;
				}

				public void setKmrest(String kmrest) {
					this.kmrest = kmrest;
				}

				public String getLbllessorcompany() {
					return lbllessorcompany;
				}

				public void setLbllessorcompany(String lbllessorcompany) { 
					this.lbllessorcompany = lbllessorcompany;
				}

				public String getClientnames() {
					return clientnames;
				}

				public void setClientnames(String clientnames) {
					this.clientnames = clientnames;
				}

				public String getTotalpaids() {
					return totalpaids;
				}

				public void setTotalpaids(String totalpaids) {
					this.totalpaids = totalpaids;
				}

				public String getInvamount() {
					return invamount;
				}

				public void setInvamount(String invamount) {
					this.invamount = invamount;
				}

				public String getBalance() {
					return balance;
				}

				public void setBalance(String balance) {
					this.balance = balance;
				}
	  
	  
	  
				//Closing Summary Print
				private String branchname;
				private String lblclientname;
				private String lblfleetno;
				private String lblfleetname;
				private String lbldateout;
				private String lbltimeout;
				private String lblkmout;
				private String lblfuelout;
				private String lbldatein;
				private String lbltimein;
				private String lblkmin;
				private String lblfuelin;
				
				private String lblsumotherdebit;
				private String lblsumothercredit;
				private String lblsumcrvdebit;
				private String lblsumcrvcredit;
				private String lblnetbalance;





				public String getBranchname() {
					return branchname;
				}

				public void setBranchname(String branchname) {
					this.branchname = branchname;
				}

				public String getLblclientname() {
					return lblclientname;
				}

				public void setLblclientname(String lblclientname) {
					this.lblclientname = lblclientname;
				}

				public String getLblfleetno() {
					return lblfleetno;
				}

				public void setLblfleetno(String lblfleetno) {
					this.lblfleetno = lblfleetno;
				}

				public String getLblfleetname() {
					return lblfleetname;
				}

				public void setLblfleetname(String lblfleetname) {
					this.lblfleetname = lblfleetname;
				}

				public String getLbldateout() {
					return lbldateout;
				}

				public void setLbldateout(String lbldateout) {
					this.lbldateout = lbldateout;
				}

				public String getLbltimeout() {
					return lbltimeout;
				}

				public void setLbltimeout(String lbltimeout) {
					this.lbltimeout = lbltimeout;
				}

				public String getLblkmout() {
					return lblkmout;
				}

				public void setLblkmout(String lblkmout) {
					this.lblkmout = lblkmout;
				}

				public String getLblfuelout() {
					return lblfuelout;
				}

				public void setLblfuelout(String lblfuelout) {
					this.lblfuelout = lblfuelout;
				}

				public String getLbldatein() {
					return lbldatein;
				}

				public void setLbldatein(String lbldatein) {
					this.lbldatein = lbldatein;
				}

				public String getLbltimein() {
					return lbltimein;
				}

				public void setLbltimein(String lbltimein) {
					this.lbltimein = lbltimein;
				}

				public String getLblkmin() {
					return lblkmin;
				}

				public void setLblkmin(String lblkmin) {
					this.lblkmin = lblkmin;
				}

				public String getLblfuelin() {
					return lblfuelin;
				}

				public void setLblfuelin(String lblfuelin) {
					this.lblfuelin = lblfuelin;
				}

				public String getLblsumotherdebit() {
					return lblsumotherdebit;
				}

				public void setLblsumotherdebit(String lblsumotherdebit) {
					this.lblsumotherdebit = lblsumotherdebit;
				}

				public String getLblsumothercredit() {
					return lblsumothercredit;
				}

				public void setLblsumothercredit(String lblsumothercredit) {
					this.lblsumothercredit = lblsumothercredit;
				}

				public String getLblsumcrvdebit() {
					return lblsumcrvdebit;
				}

				public void setLblsumcrvdebit(String lblsumcrvdebit) {
					this.lblsumcrvdebit = lblsumcrvdebit;
				}

				public String getLblsumcrvcredit() {
					return lblsumcrvcredit;
				}

				public void setLblsumcrvcredit(String lblsumcrvcredit) {
					this.lblsumcrvcredit = lblsumcrvcredit;
				}

				public String getLblnetbalance() {
					return lblnetbalance;
				}

				public void setLblnetbalance(String lblnetbalance) {
					this.lblnetbalance = lblnetbalance;
				}
	  
				 private String excessinsu,trafficcharge,salikcharge;



				public String getExcessinsu() {
					return excessinsu;
				}

				public void setExcessinsu(String excessinsu) {
					this.excessinsu = excessinsu;
				}

				public String getTrafficcharge() {
					return trafficcharge;
				}

				public void setTrafficcharge(String trafficcharge) {
					this.trafficcharge = trafficcharge;
				}

				public String getSalikcharge() {
					return salikcharge;
				}

				public void setSalikcharge(String salikcharge) {
					this.salikcharge = salikcharge;
				}
	  
	  
	//Getters and setters for cosmo print
				
				
				private String lblcosmoagmtno;
				private String lblcosmoclientname;
				private String lblcosmoclientaddress;
				private String lblcosmoclientmobile;
				private String lblcosmofleetno;
				private String lblcosmoregno;
				private String lblcosmoyom;
				private String lblcosmomodel;
				private String lblcosmocolor;
				private String lblcosmoengine;
				private String lblcosmochassis;
				private String lblcosmobrand;
				private String lblcosmoduration;
				private String lblcosmostartdate;
				private String lblcosmoenddate;
				private String lblcosmoagreedrate;
				private String lblexcessamt;
				private String lblcosmoterm1;
				private String lblcosmoterm2;
				private String lblcosmoterm3;
				private String lblcosmoterm4;
				private String lblcosmoterm5;
				private String lblcosmoterm6;
				private String lblcosmoterm7;
				private String lblcosmoterm8;
				private String lblcosmoterm9;
				private String lblcosmoterm10;
				private String lblcosmoamt1;
				private String lblcosmoamt2;
				private String lblcosmoamt3;
				private String lblcosmoamt4;
				private String lblcosmoamt5;
				private String lblcosmoexcessamt;
				
				
				public String getLblcosmoexcessamt() {
					return lblcosmoexcessamt;
				}

				public void setLblcosmoexcessamt(String lblcosmoexcessamt) {
					this.lblcosmoexcessamt = lblcosmoexcessamt;
				}

				
				public String getLblcosmoclientaddress() {
					return lblcosmoclientaddress;
				}

				public void setLblcosmoclientaddress(String lblcosmoclientaddress) {
					this.lblcosmoclientaddress = lblcosmoclientaddress;
				}

				public String getLblcosmoagmtno() {
					return lblcosmoagmtno;
				}

				public void setLblcosmoagmtno(String lblcosmoagmtno) {
					this.lblcosmoagmtno = lblcosmoagmtno;
				}

				public String getLblcosmoclientname() {
					return lblcosmoclientname;
				}

				public void setLblcosmoclientname(String lblcosmoclientname) {
					this.lblcosmoclientname = lblcosmoclientname;
				}

				public String getLblcosmoclientmobile() {
					return lblcosmoclientmobile;
				}

				public void setLblcosmoclientmobile(String lblcosmoclientmobile) {
					this.lblcosmoclientmobile = lblcosmoclientmobile;
				}

				public String getLblcosmofleetno() {
					return lblcosmofleetno;
				}

				public void setLblcosmofleetno(String lblcosmofleetno) {
					this.lblcosmofleetno = lblcosmofleetno;
				}

				public String getLblcosmoregno() {
					return lblcosmoregno;
				}

				public void setLblcosmoregno(String lblcosmoregno) {
					this.lblcosmoregno = lblcosmoregno;
				}

				public String getLblcosmoyom() {
					return lblcosmoyom;
				}

				public void setLblcosmoyom(String lblcosmoyom) {
					this.lblcosmoyom = lblcosmoyom;
				}

				public String getLblcosmomodel() {
					return lblcosmomodel;
				}

				public void setLblcosmomodel(String lblcosmomodel) {
					this.lblcosmomodel = lblcosmomodel;
				}

				public String getLblcosmocolor() {
					return lblcosmocolor;
				}

				public void setLblcosmocolor(String lblcosmocolor) {
					this.lblcosmocolor = lblcosmocolor;
				}

				public String getLblcosmoengine() {
					return lblcosmoengine;
				}

				public void setLblcosmoengine(String lblcosmoengine) {
					this.lblcosmoengine = lblcosmoengine;
				}

				public String getLblcosmochassis() {
					return lblcosmochassis;
				}

				public void setLblcosmochassis(String lblcosmochassis) {
					this.lblcosmochassis = lblcosmochassis;
				}

				public String getLblcosmobrand() {
					return lblcosmobrand;
				}

				public void setLblcosmobrand(String lblcosmobrand) {
					this.lblcosmobrand = lblcosmobrand;
				}

				public String getLblcosmoduration() {
					return lblcosmoduration;
				}

				public void setLblcosmoduration(String lblcosmoduration) {
					this.lblcosmoduration = lblcosmoduration;
				}

				public String getLblcosmostartdate() {
					return lblcosmostartdate;
				}

				public void setLblcosmostartdate(String lblcosmostartdate) {
					this.lblcosmostartdate = lblcosmostartdate;
				}

				public String getLblcosmoenddate() {
					return lblcosmoenddate;
				}

				public void setLblcosmoenddate(String lblcosmoenddate) {
					this.lblcosmoenddate = lblcosmoenddate;
				}

				public String getLblcosmoagreedrate() {
					return lblcosmoagreedrate;
				}

				public void setLblcosmoagreedrate(String lblcosmoagreedrate) {
					this.lblcosmoagreedrate = lblcosmoagreedrate;
				}

				public String getLblexcessamt() {
					return lblexcessamt;
				}

				public void setLblexcessamt(String lblexcessamt) {
					this.lblexcessamt = lblexcessamt;
				}

				public String getLblcosmoterm1() {
					return lblcosmoterm1;
				}

				public void setLblcosmoterm1(String lblcosmoterm1) {
					this.lblcosmoterm1 = lblcosmoterm1;
				}

				public String getLblcosmoterm2() {
					return lblcosmoterm2;
				}

				public void setLblcosmoterm2(String lblcosmoterm2) {
					this.lblcosmoterm2 = lblcosmoterm2;
				}

				public String getLblcosmoterm3() {
					return lblcosmoterm3;
				}

				public void setLblcosmoterm3(String lblcosmoterm3) {
					this.lblcosmoterm3 = lblcosmoterm3;
				}

				public String getLblcosmoterm4() {
					return lblcosmoterm4;
				}

				public void setLblcosmoterm4(String lblcosmoterm4) {
					this.lblcosmoterm4 = lblcosmoterm4;
				}

				public String getLblcosmoterm5() {
					return lblcosmoterm5;
				}

				public void setLblcosmoterm5(String lblcosmoterm5) {
					this.lblcosmoterm5 = lblcosmoterm5;
				}

				public String getLblcosmoterm6() {
					return lblcosmoterm6;
				}

				public void setLblcosmoterm6(String lblcosmoterm6) {
					this.lblcosmoterm6 = lblcosmoterm6;
				}

				public String getLblcosmoterm7() {
					return lblcosmoterm7;
				}

				public void setLblcosmoterm7(String lblcosmoterm7) {
					this.lblcosmoterm7 = lblcosmoterm7;
				}

				public String getLblcosmoterm8() {
					return lblcosmoterm8;
				}

				public void setLblcosmoterm8(String lblcosmoterm8) {
					this.lblcosmoterm8 = lblcosmoterm8;
				}

				public String getLblcosmoterm9() {
					return lblcosmoterm9;
				}

				public void setLblcosmoterm9(String lblcosmoterm9) {
					this.lblcosmoterm9 = lblcosmoterm9;
				}

				public String getLblcosmoterm10() {
					return lblcosmoterm10;
				}

				public void setLblcosmoterm10(String lblcosmoterm10) {
					this.lblcosmoterm10 = lblcosmoterm10;
				}

				public String getLblcosmoamt1() {
					return lblcosmoamt1;
				}

				public void setLblcosmoamt1(String lblcosmoamt1) {
					this.lblcosmoamt1 = lblcosmoamt1;
				}

				public String getLblcosmoamt2() {
					return lblcosmoamt2;
				}

				public void setLblcosmoamt2(String lblcosmoamt2) {
					this.lblcosmoamt2 = lblcosmoamt2;
				}

				public String getLblcosmoamt3() {
					return lblcosmoamt3;
				}

				public void setLblcosmoamt3(String lblcosmoamt3) {
					this.lblcosmoamt3 = lblcosmoamt3;
				}

				public String getLblcosmoamt4() {
					return lblcosmoamt4;
				}

				public void setLblcosmoamt4(String lblcosmoamt4) {
					this.lblcosmoamt4 = lblcosmoamt4;
				}

				public String getLblcosmoamt5() {
					return lblcosmoamt5;
				}

				public void setLblcosmoamt5(String lblcosmoamt5) {
					this.lblcosmoamt5 = lblcosmoamt5;
				}
				
				
				private String lblpai;

				public String getLblpai() {
					return lblpai;
				}

				public void setLblpai(String lblpai) {
					this.lblpai = lblpai;
				}

				public String getLblcosmoclienttel() {
					return Lblcosmoclienttel;
				}

				public void setLblcosmoclienttel(String lblcosmoclienttel) {
					Lblcosmoclienttel = lblcosmoclienttel;
				}

				
				
	  
	  
	  
	  
	  
	  
}