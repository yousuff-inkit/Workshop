package com.operations.agreement.rentalagmtnew;

public class ClsRentalAgmtNewBean {

	 
	 
	 // chauffer
	 private String sal_docno;
	 private String sal_id;
	 private String sal_name;
	 
	 
	 //driver search
	 private String drid;
	 private String driverName;
//tariff search foe daily monthly00000
	 
	 private String tarifftype;
	 // chuffer Search
	 private String chau_name;
	 private String chau_id;
	 // tariff botton
	 private String btndocno;
	 private String btnvalidto;
	 private String btntarifftype;
	 
	 
	 // payment
	 private String paymentmode;
	 
	 
	 private String pyt;
	 private String mode;
	 private String amount;
	 private String acode;
	 private String cardno;
	 private String exdate;
	 private String recieptno,delcharges,rasupercdw,ravmd;
	 
	 private int delchkvalue;
	 
	 
	 
		private int  advance_chkval;
		private int advance_chk;
	 
	 
	 
	 
	 private int masterdoc_no;
	 
	 
	 
	 //	 payment
	 
		public String getRasupercdw() {
		return rasupercdw;
	}

	public void setRasupercdw(String rasupercdw) {
		this.rasupercdw = rasupercdw;
	}




	 

		public String getRavmd() {
		return ravmd;
	}

	public void setRavmd(String ravmd) {
		this.ravmd = ravmd;
	}






		private int weekendval,weekend;
		
	//Extra Added for fancy  print
		
		private String lblnation,lblissfromdate,lblissby,lblidno,lblpassissued;
		
		private String lbladdpassno1,lbladdpassexp1,lbladdnation1,lbladdissby1,lbladdissfrom1,lbladdid1,lbladdpassissued1;
	//Extra Added for Manila Print

		private String lblcompwebsite,lblcompmail;
	//Extra added m	
		private String lbltel1,lbltel2,duedate, salagent ,raagent,  salname,duetime ;
	 

public String getDuetime() {
			return duetime;
		}

		public void setDuetime(String duetime) {
			this.duetime = duetime;
		}

		public String getSalname() {
			return salname;
		}

		public void setSalname(String salname) {
			this.salname = salname;
		}



		
		public String getDuedate() {
			return duedate;
		}

		public void setDuedate(String duedate) { 
			this.duedate = duedate;
		}

		public String getSalagent() {
			return salagent;
		}

		public void setSalagent(String salagent) {
			this.salagent = salagent;
		}

		public String getRaagent() {
			return raagent;
		}

		public void setRaagent(String raagent) {
			this.raagent = raagent;
		}

		public String getLbltel1() {
			return lbltel1;
		}

		public void setLbltel1(String lbltel1) {
			this.lbltel1 = lbltel1;
		}

		public String getLbltel2() {
			return lbltel2;
		}

		public void setLbltel2(String lbltel2) {
			this.lbltel2 = lbltel2;
		}

		public String getLbladdpassno1() {
			return lbladdpassno1;
		}

		public void setLbladdpassno1(String lbladdpassno1) {
			this.lbladdpassno1 = lbladdpassno1;
		}

		public String getLbladdpassexp1() {
			return lbladdpassexp1;
		}

		public void setLbladdpassexp1(String lbladdpassexp1) {
			this.lbladdpassexp1 = lbladdpassexp1;
		}

		public String getLbladdnation1() {
			return lbladdnation1;
		}

		public void setLbladdnation1(String lbladdnation1) {
			this.lbladdnation1 = lbladdnation1;
		}

		public String getLbladdissby1() {
			return lbladdissby1;
		}

		public void setLbladdissby1(String lbladdissby1) {
			this.lbladdissby1 = lbladdissby1;
		}

		public String getLbladdissfrom1() {
			return lbladdissfrom1;
		}

		public void setLbladdissfrom1(String lbladdissfrom1) {
			this.lbladdissfrom1 = lbladdissfrom1;
		}

		public String getLbladdid1() {
			return lbladdid1;
		}

		public void setLbladdid1(String lbladdid1) {
			this.lbladdid1 = lbladdid1;
		}

		public String getLbladdpassissued1() {
			return lbladdpassissued1;
		}

		public void setLbladdpassissued1(String lbladdpassissued1) {
			this.lbladdpassissued1 = lbladdpassissued1;
		}

		public String getLblpassissued() {
			return lblpassissued;
		}

		public void setLblpassissued(String lblpassissued) {
			this.lblpassissued = lblpassissued;
		}

		public String getLblcompwebsite() {
			return lblcompwebsite;
		}

		public void setLblcompwebsite(String lblcompwebsite) {
			this.lblcompwebsite = lblcompwebsite;
		}

		public String getLblcompmail() {
			return lblcompmail;
		}

		public void setLblcompmail(String lblcompmail) {
			this.lblcompmail = lblcompmail;
		}

		
		
		public String getLblnation() {
			return lblnation;
		}

		public void setLblnation(String lblnation) {
			this.lblnation = lblnation;
		}

		public String getLblissfromdate() {
			return lblissfromdate;
		}

		public void setLblissfromdate(String lblissfromdate) {
			this.lblissfromdate = lblissfromdate;
		}

	

		public String getLblissby() {
			return lblissby;
		}

		public void setLblissby(String lblissby) {
			this.lblissby = lblissby;
		}

		public String getLblidno() {
			return lblidno;
		}

		public void setLblidno(String lblidno) {
			this.lblidno = lblidno;
		}		
		
		
	 
		public int getWeekendval() {
			return weekendval;
		}

		public void setWeekendval(int weekendval) {
			this.weekendval = weekendval;
		}

		public int getWeekend() {
			return weekend;
		}

		public void setWeekend(int weekend) {
			this.weekend = weekend;
		}

		public String getDelcharges() {
			return delcharges;
		}

		public int getMasterdoc_no() {
			return masterdoc_no;
		}

		public void setMasterdoc_no(int masterdoc_no) {
			this.masterdoc_no = masterdoc_no;
		}

		public void setDelcharges(String delcharges) {
			this.delcharges = delcharges;
		}
	 
		public int getAdvance_chkval() {
			return advance_chkval;
		}

		

		public void setAdvance_chkval(int advance_chkval) {
			this.advance_chkval = advance_chkval;
		}

		public int getAdvance_chk() {
			return advance_chk;
		}

		public void setAdvance_chk(int advance_chk) {
			this.advance_chk = advance_chk;
		}

		public String getPaymentmode() {
			return paymentmode;
		}

		public void setPaymentmode(String paymentmode) {
			this.paymentmode = paymentmode;
		}

	 
	 // tariff botton
	 
	 public String getBtndocno() {
			return btndocno;
		        }
		
	
		public void setBtndocno(String btndocno) {
			this.btndocno = btndocno;
		}
		public String getBtnvalidto() {
			return btnvalidto;
		}
		public void setBtnvalidto(String btnvalidto) {
			this.btnvalidto = btnvalidto;
		}
		public String getBtntarifftype() {
			return btntarifftype;
		}
		public void setBtntarifftype(String btntarifftype) {
			this.btntarifftype = btntarifftype;
		}
	 	 
		
	 
	 
	 
	 
	 
	 // chuffer Search
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
	public String getTarifftype() {
		return tarifftype;
	}
	public void setTarifftype(String tarifftype) {
		this.tarifftype = tarifftype;
	}
	 
	
	// driver search
	  public String getDrid() {
		return drid;
	}
	public void setDrid(String drid) {
		this.drid = drid;
	}
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	// client search

	
	// sale search
	
	
	public String getSal_docno() {
		return sal_docno;
	}
	public void setSal_docno(String sal_docno) {
		this.sal_docno = sal_docno;
	}
	public String getSal_id() {
		return sal_id;
	}
	public void setSal_id(String sal_id) {
		this.sal_id = sal_id;
	}
	public String getSal_name() {
		return sal_name;
	}
	public void setSal_name(String sal_name) {
		this.sal_name = sal_name;
	}
	


	
	//  main 
	private String docno;
	private String jqxRentalDate;
	private String hidjqxRentalDate;
	// veh
	private String  txtfleetno;	
	private String vehlocation;
	// client
	private String txtcusid;
	private int re_salmanid;
	private String re_clcodeno;
	private String re_clacno;
	private String rentaldesc;
	// chauffeur select
	private int additional_driver;
	private String adidrvcharges;
	private int delivery_chk;
	private int radrivercheck;
	
	private int del_chaufferid;
	
	//client driver
	private String client_driverid;
	
	 // tariff main
	 private String ratariffsystem;
	 private String ratariffdocno1;
	 private String invoice;
	 private String excessinsur;
	 private String veh_fleetgrouptariff;
	 
	 // tariff sub
	 private String re_Km;
	 private String ratariff_fuel;
	 private int tariffsales_Agentid;
	 private int tariffrenral_Agentid;
	 private String jqxDateOut;  //out date
	 private String hidjqxDateOut;
	 private String jqxTimeOut;   // out time
	 private String hidjqxTimeOut;
	 private String ratariff_checkout;
	 private int ratariff_checkoutid;
	 private String jqxOnDate;   // due date
	 private String hidjqxOnDate;
	 private String jqxOnTime;   // due time
	 private String hidjqxOnTime;
	 private String hidvehfuel;

	 // payment sub
	 private String payment_Mra;
	



	private String payment_PO;
	 private String payment_Conveh;// original fleet
	 
	  // delivery driver
	 private String del_chaufferid2;
	 private String del_KM;
	 private String del_Fuel;
	 private String jqxDeliveryOut;
	 private String hidjqxDeliveryOut;
	 private String jqxDelTimeOut;
	 private String hidjqxDelTimeOut;
	
	 // hidden
	 private String rentaltype; 
	
	 
	 //==================================================
	 
	 // for reload
	 
	 // all
	 private String vehdetails;
	 private String client_Name;
	 private String re_salman;
	 private String radriverlist;
	 private String rasales_Agent;
	 private String rarenral_Agent;
	 private String cusaddress;
	


//
	  
		private String salikcharge,trafficcharge,totalsalikandtraffic;
	  
	  private String del_Driver;
	
//open or close
	  
	  
	  private String rentalstatus,rafuelout,rayom,racolor,adddrname1,adddrname2,addlicno1,addlicno2,expdate1,expdate2,adddob1,adddob2,raextrakm,raexxtakmchg,rarenttypes;


	public String getRarenttypes() {
		return rarenttypes;
	}

	public void setRarenttypes(String rarenttypes) {
		this.rarenttypes = rarenttypes;
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

	public String getRafuelout() {
		return rafuelout;
	}

	public void setRafuelout(String rafuelout) {
		this.rafuelout = rafuelout;
	}

	public String getRentalstatus() {
		return rentalstatus;
	}

	public void setRentalstatus(String rentalstatus) {
		this.rentalstatus = rentalstatus;
	}

	public String getDel_Driver() {
		return del_Driver;
	}

	public void setDel_Driver(String del_Driver) {
		this.del_Driver = del_Driver;
	}

	public String getPyt() {
		return pyt;
	}

	public void setPyt(String pyt) {
		this.pyt = pyt;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getAcode() {
		return acode;
	}

	public void setAcode(String acode) {
		this.acode = acode;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public String getExdate() {
		return exdate;
	}

	public void setExdate(String exdate) {
		this.exdate = exdate;
	}

	public String getRecieptno() {
		return recieptno;
	}

	public void setRecieptno(String recieptno) {
		this.recieptno = recieptno;
	}

	 public String getDocno() {
			return docno;
		}

		public void setDocno(String docno) {
			this.docno = docno;
		}


	public String getJqxRentalDate() {
		return jqxRentalDate;
	}

	public void setJqxRentalDate(String jqxRentalDate) {
		this.jqxRentalDate = jqxRentalDate;
	}

	public String getHidjqxRentalDate() {
		return hidjqxRentalDate;
	}

	public void setHidjqxRentalDate(String hidjqxRentalDate) {
		this.hidjqxRentalDate = hidjqxRentalDate;
	}

	public String getTxtfleetno() {
		return txtfleetno;
	}

	public void setTxtfleetno(String txtfleetno) {
		this.txtfleetno = txtfleetno;
	}

	public String getVehlocation() {
		return vehlocation;
	}

	public void setVehlocation(String vehlocation) {
		this.vehlocation = vehlocation;
	}

	public String getRentaldesc() {
		return rentaldesc;
	}

	public void setRentaldesc(String rentaldesc) {
		this.rentaldesc = rentaldesc;
	}

	public String getTxtcusid() {
		return txtcusid;
	}

	public void setTxtcusid(String txtcusid) {
		this.txtcusid = txtcusid;
	}

	public int getRe_salmanid() {
		return re_salmanid;
	}

	public void setRe_salmanid(int re_salmanid) {
		this.re_salmanid = re_salmanid;
	}

	public String getRe_clcodeno() {
		return re_clcodeno;
	}

	public void setRe_clcodeno(String re_clcodeno) {
		this.re_clcodeno = re_clcodeno;
	}

	public String getRe_clacno() {
		return re_clacno;
	}

	public void setRe_clacno(String re_clacno) {
		this.re_clacno = re_clacno;
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

	public int getDelivery_chk() {
		return delivery_chk;
	}

	public void setDelivery_chk(int delivery_chk) {
		this.delivery_chk = delivery_chk;
	}

	public int getRadrivercheck() {
		return radrivercheck;
	}

	public void setRadrivercheck(int radrivercheck) {
		this.radrivercheck = radrivercheck;
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

	public String getRatariffsystem() {
		return ratariffsystem;
	}

	public void setRatariffsystem(String ratariffsystem) {
		this.ratariffsystem = ratariffsystem;
	}

	public String getRatariffdocno1() {
		return ratariffdocno1;
	}

	public void setRatariffdocno1(String ratariffdocno1) {
		this.ratariffdocno1 = ratariffdocno1;
	}

	public String getInvoice() {
		return invoice;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	public String getExcessinsur() {
		return excessinsur;
	}

	public void setExcessinsur(String excessinsur) {
		this.excessinsur = excessinsur;
	}

	public String getVeh_fleetgrouptariff() {
		return veh_fleetgrouptariff;
	}

	public void setVeh_fleetgrouptariff(String veh_fleetgrouptariff) {
		this.veh_fleetgrouptariff = veh_fleetgrouptariff;
	}

	public String getRe_Km() {
		return re_Km;
	}

	public void setRe_Km(String re_Km) {
		this.re_Km = re_Km;
	}

	public String getRatariff_fuel() {
		return ratariff_fuel;
	}

	public void setRatariff_fuel(String ratariff_fuel) {
		this.ratariff_fuel = ratariff_fuel;
	}

	public int getTariffsales_Agentid() {
		return tariffsales_Agentid;
	}

	public void setTariffsales_Agentid(int tariffsales_Agentid) {
		this.tariffsales_Agentid = tariffsales_Agentid;
	}

	public int getTariffrenral_Agentid() {
		return tariffrenral_Agentid;
	}

	public void setTariffrenral_Agentid(int tariffrenral_Agentid) {
		this.tariffrenral_Agentid = tariffrenral_Agentid;
	}

	public String getJqxDateOut() {
		return jqxDateOut;
	}

	public void setJqxDateOut(String jqxDateOut) {
		this.jqxDateOut = jqxDateOut;
	}

	public String getHidjqxDateOut() {
		return hidjqxDateOut;
	}

	public void setHidjqxDateOut(String hidjqxDateOut) {
		this.hidjqxDateOut = hidjqxDateOut;
	}

	public String getJqxTimeOut() {
		return jqxTimeOut;
	}

	public void setJqxTimeOut(String jqxTimeOut) {
		this.jqxTimeOut = jqxTimeOut;
	}

	public String getHidjqxTimeOut() {
		return hidjqxTimeOut;
	}

	public void setHidjqxTimeOut(String hidjqxTimeOut) {
		this.hidjqxTimeOut = hidjqxTimeOut;
	}

	public String getRatariff_checkout() {
		return ratariff_checkout;
	}

	public void setRatariff_checkout(String ratariff_checkout) {
		this.ratariff_checkout = ratariff_checkout;
	}

	public int getRatariff_checkoutid() {
		return ratariff_checkoutid;
	}

	public void setRatariff_checkoutid(int ratariff_checkoutid) {
		this.ratariff_checkoutid = ratariff_checkoutid;
	}

	public String getJqxOnDate() {
		return jqxOnDate;
	}

	public void setJqxOnDate(String jqxOnDate) {
		this.jqxOnDate = jqxOnDate;
	}

	public String getHidjqxOnDate() {
		return hidjqxOnDate;
	}

	public void setHidjqxOnDate(String hidjqxOnDate) {
		this.hidjqxOnDate = hidjqxOnDate;
	}

	public String getJqxOnTime() {
		return jqxOnTime;
	}

	public void setJqxOnTime(String jqxOnTime) {
		this.jqxOnTime = jqxOnTime;
	}

	public String getHidjqxOnTime() {
		return hidjqxOnTime;
	}

	public void setHidjqxOnTime(String hidjqxOnTime) {
		this.hidjqxOnTime = hidjqxOnTime;
	}

	public String getPayment_Mra() {
		return payment_Mra;
	}

	public void setPayment_Mra(String payment_Mra) {
		this.payment_Mra = payment_Mra;
	}

	public String getPayment_PO() {
		return payment_PO;
	}

	public void setPayment_PO(String payment_PO) {
		this.payment_PO = payment_PO;
	}

	public String getPayment_Conveh() {
		return payment_Conveh;
	}

	public void setPayment_Conveh(String payment_Conveh) {
		this.payment_Conveh = payment_Conveh;
	}

	public String getDel_chaufferid2() {
		return del_chaufferid2;
	}

	public void setDel_chaufferid2(String del_chaufferid2) {
		this.del_chaufferid2 = del_chaufferid2;
	}

	public String getDel_KM() {
		return del_KM;
	}

	public void setDel_KM(String del_KM) {  
		this.del_KM = del_KM;
	}

	public String getDel_Fuel() {
		return del_Fuel;
	}

	public void setDel_Fuel(String del_Fuel) {
		this.del_Fuel = del_Fuel;
	}

	public String getJqxDeliveryOut() {
		return jqxDeliveryOut;
	}

	public void setJqxDeliveryOut(String jqxDeliveryOut) {
		this.jqxDeliveryOut = jqxDeliveryOut;
	}

	public String getHidjqxDeliveryOut() {
		return hidjqxDeliveryOut;
	}

	public void setHidjqxDeliveryOut(String hidjqxDeliveryOut) {
		this.hidjqxDeliveryOut = hidjqxDeliveryOut;
	}

	public String getJqxDelTimeOut() {
		return jqxDelTimeOut;
	}

	public void setJqxDelTimeOut(String jqxDelTimeOut) {
		this.jqxDelTimeOut = jqxDelTimeOut;
	}

	public String getHidjqxDelTimeOut() {
		return hidjqxDelTimeOut;
	}

	public void setHidjqxDelTimeOut(String hidjqxDelTimeOut) {
		this.hidjqxDelTimeOut = hidjqxDelTimeOut;
	}

	public String getRentaltype() {
		return rentaltype;
	}

	public void setRentaltype(String rentaltype) {
		this.rentaltype = rentaltype;
	}

	public String getVehdetails() {
		return vehdetails;
	}

	public void setVehdetails(String vehdetails) {
		this.vehdetails = vehdetails;
	}

	public String getClient_Name() {
		return client_Name;
	}

	public void setClient_Name(String client_Name) {
		this.client_Name = client_Name;
	}

	public String getRe_salman() {
		return re_salman;
	}

	public void setRe_salman(String re_salman) {
		this.re_salman = re_salman;
	}

	public String getRadriverlist() {
		return radriverlist;
	}

	public void setRadriverlist(String radriverlist) {
		this.radriverlist = radriverlist;
	}

	public String getRasales_Agent() {
		return rasales_Agent;
	}

	public void setRasales_Agent(String rasales_Agent) {
		this.rasales_Agent = rasales_Agent;
	}

	public String getRarenral_Agent() {
		return rarenral_Agent;
	}

	public void setRarenral_Agent(String rarenral_Agent) {
		this.rarenral_Agent = rarenral_Agent;
	}

	public String getCusaddress() {
		return cusaddress;
	}

	public void setCusaddress(String cusaddress) {
		this.cusaddress = cusaddress;
	}

	public int getDelchkvalue() {
		return delchkvalue;
	}

	public void setDelchkvalue(int delchkvalue) {
		this.delchkvalue = delchkvalue;
	}

	public String getHidvehfuel() {
		return hidvehfuel;
	}

	public void setHidvehfuel(String hidvehfuel) {
		this.hidvehfuel = hidvehfuel;
	}
	  
	  
	 // ================================================= print==============
	  
	 private String clname,claddress,clmobno,clemail,barnchval,mrano,rentaldoc,radrname,radlno,passno,licexpdate,passexpdate,dobdate;
		private String ravehname,ravehregno,ravehmodel,ravehgroup,radateout,ratimeout,raklmout,excessinsu; 
		
		
		
		 private String radaily,raweakly,ramonthly,tariff,racdwscdw,raaccessory,raadditionalcge;
		 private String inkm,infuel,indate,intime,rastatus,totalpaid,invamount,balance;
			private String companyname,address,mobileno,fax,location;
			private String deldates,deltimes,delkmins,delfuels;

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
//-----------------------------------
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

	
//--------------------------------------------------------
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

	public String getRastatus() {
		return rastatus;
	}

	public void setRastatus(String rastatus) {
		this.rastatus = rastatus;
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

	public String getExcessinsu() {
		return excessinsu;
	}

	public void setExcessinsu(String excessinsu) {
		this.excessinsu = excessinsu;
	}

	public String getTotalpaid() {
		return totalpaid;
	}

	public void setTotalpaid(String totalpaid) { 
		this.totalpaid = totalpaid;
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
	private String lblcosmodrivername;
	private String lblcosmodriverlicense;
	private String lblcosmodrivervalidupto;
	private String lblcosmodrivermobile;
	private String lblcosmodriverpassport;

	
	public String getLblcosmodriverpassport() {
		return lblcosmodriverpassport;
	}

	public void setLblcosmodriverpassport(String lblcosmodriverpassport) {
		this.lblcosmodriverpassport = lblcosmodriverpassport;
	}

	public String getLblcosmodrivername() {
		return lblcosmodrivername;
	}

	public void setLblcosmodrivername(String lblcosmodrivername) {
		this.lblcosmodrivername = lblcosmodrivername;
	}

	public String getLblcosmodriverlicense() {
		return lblcosmodriverlicense;
	}

	public void setLblcosmodriverlicense(String lblcosmodriverlicense) {
		this.lblcosmodriverlicense = lblcosmodriverlicense;
	}

	public String getLblcosmodrivervalidupto() {
		return lblcosmodrivervalidupto;
	}

	public void setLblcosmodrivervalidupto(String lblcosmodrivervalidupto) {
		this.lblcosmodrivervalidupto = lblcosmodrivervalidupto;
	}

	public String getLblcosmodrivermobile() {
		return lblcosmodrivermobile;
	}

	public void setLblcosmodrivermobile(String lblcosmodrivermobile) {
		this.lblcosmodrivermobile = lblcosmodrivermobile;
	}

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

	  
	  
	  
	private String coldates,coltimes,colkmins,colfuels;








	public String getColdates() {
		return coldates;
	}

	public void setColdates(String coldates) { 
		this.coldates = coldates;
	}

	public String getColtimes() {
		return coltimes;
	}

	public void setColtimes(String coltimes) {
		this.coltimes = coltimes;
	}

	public String getColkmins() {
		return colkmins;
	}

	public void setColkmins(String colkmins) {
		this.colkmins = colkmins;
	}

	public String getColfuels() {
		return colfuels;
	}

	public void setColfuels(String colfuels) {
		this.colfuels = colfuels;
	}
	  
	  
	  
	  
	  
	private String outdetails,deldetailss;








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
	  
	  
	private String indetails,coldetails;








	public String getIndetails() {
		return indetails;
	}

	public void setIndetails(String indetails) { 
		this.indetails = indetails;
	}

	public String getColdetails() {
		return coldetails;
	}

	public void setColdetails(String coldetails) {
		this.coldetails = coldetails;
	}
	  
	  
	/*  
	  
	  for nooori
	
	private String lbldrmobno,lbldrmobno1,lblplaceissue,lblplaceissue1,passno1,lbpassexpdate,lbpassexpdate1;


	private String  lbfueltype,lbmodel,kmused,noofdays,pertel,faxno;

	private String lbmasterdate,lbexpcarddate,lbsecurity;

	private int firstarray;

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public String getLbldrmobno() {
		return lbldrmobno;
	}

	public void setLbldrmobno(String lbldrmobno) {
		this.lbldrmobno = lbldrmobno;
	}

	public String getLbldrmobno1() {
		return lbldrmobno1;
	}

	public void setLbldrmobno1(String lbldrmobno1) {
		this.lbldrmobno1 = lbldrmobno1;
	}

	public String getLblplaceissue() {
		return lblplaceissue;
	}

	public void setLblplaceissue(String lblplaceissue) {
		this.lblplaceissue = lblplaceissue;
	}

	public String getLblplaceissue1() {
		return lblplaceissue1;
	}

	public void setLblplaceissue1(String lblplaceissue1) {
		this.lblplaceissue1 = lblplaceissue1;
	}

	public String getPassno1() {
		return passno1;
	}

	public void setPassno1(String passno1) {
		this.passno1 = passno1;
	}

	public String getLbpassexpdate() {
		return lbpassexpdate;
	}

	public void setLbpassexpdate(String lbpassexpdate) {
		this.lbpassexpdate = lbpassexpdate;
	}

	public String getLbpassexpdate1() {
		return lbpassexpdate1;
	}

	public void setLbpassexpdate1(String lbpassexpdate1) {
		this.lbpassexpdate1 = lbpassexpdate1;
	}

	public String getLbfueltype() {
		return lbfueltype;
	}

	public void setLbfueltype(String lbfueltype) {
		this.lbfueltype = lbfueltype;
	}

	public String getLbmodel() {
		return lbmodel;
	}

	public void setLbmodel(String lbmodel) {
		this.lbmodel = lbmodel;
	}

	public String getKmused() {
		return kmused;
	}

	public void setKmused(String kmused) {
		this.kmused = kmused;
	}

	public String getNoofdays() {
		return noofdays;
	}

	public void setNoofdays(String noofdays) {
		this.noofdays = noofdays;
	}

	public String getPertel() {
		return pertel;
	}

	public void setPertel(String pertel) {
		this.pertel = pertel;
	}

	public String getFaxno() {
		return faxno;
	}

	public void setFaxno(String faxno) {
		this.faxno = faxno;
	}

	public String getLbmasterdate() {
		return lbmasterdate;
	}

	public void setLbmasterdate(String lbmasterdate) {
		this.lbmasterdate = lbmasterdate;
	}

	public String getLbexpcarddate() {
		return lbexpcarddate;
	}

	public void setLbexpcarddate(String lbexpcarddate) {
		this.lbexpcarddate = lbexpcarddate;
	}

	public String getLbsecurity() {
		return lbsecurity;
	}

	public void setLbsecurity(String lbsecurity) {
		this.lbsecurity = lbsecurity;
	}
	
	
	*/
	  // =====================================driven ==============================
	
	 private String lblclname,lblcladdress,lblpertel,lblfaxno,lblclmobno,lblclemail,lbldobdate,lblradlno,lbcardno,lbexpcarddate,drivravehregno;



	public String getLblclname() {
		return lblclname;
	}

	public void setLblclname(String lblclname) { 
		this.lblclname = lblclname; 
	}

	public String getLblcladdress() {
		return lblcladdress;
	}

	public void setLblcladdress(String lblcladdress) {
		this.lblcladdress = lblcladdress;
	}

	public String getLblpertel() {
		return lblpertel;
	}

	public void setLblpertel(String lblpertel) {
		this.lblpertel = lblpertel;
	}

	public String getLblfaxno() {
		return lblfaxno;
	}

	public void setLblfaxno(String lblfaxno) {
		this.lblfaxno = lblfaxno;
	}

	public String getLblclmobno() {
		return lblclmobno;
	}

	public void setLblclmobno(String lblclmobno) {
		this.lblclmobno = lblclmobno;
	}

	public String getLblclemail() {
		return lblclemail;
	}

	public void setLblclemail(String lblclemail) {
		this.lblclemail = lblclemail;
	}

	public String getLbldobdate() {
		return lbldobdate;
	}

	public void setLbldobdate(String lbldobdate) {
		this.lbldobdate = lbldobdate;
	}

	public String getLblradlno() {
		return lblradlno;
	}

	public void setLblradlno(String lblradlno) {
		this.lblradlno = lblradlno;
	}

	public String getLbcardno() {
		return lbcardno;
	}

	public void setLbcardno(String lbcardno) { 
		this.lbcardno = lbcardno;
	}

	public String getLbexpcarddate() {
		return lbexpcarddate;
	}

	public void setLbexpcarddate(String lbexpcarddate) {
		this.lbexpcarddate = lbexpcarddate;
	}

	public String getDrivravehregno() {
		return drivravehregno;
	}

	public void setDrivravehregno(String drivravehregno) {
		this.drivravehregno = drivravehregno;
	}

	public String getSalikcharge() {
		return salikcharge;
	}

	public void setSalikcharge(String salikcharge) {
		this.salikcharge = salikcharge;
	}

	public String getTrafficcharge() {
		return trafficcharge;
	}

	public void setTrafficcharge(String trafficcharge) {
		this.trafficcharge = trafficcharge;
	}

	public String getTotalsalikandtraffic() {
		return totalsalikandtraffic;
	}

	public void setTotalsalikandtraffic(String totalsalikandtraffic) {
		this.totalsalikandtraffic = totalsalikandtraffic;
	}
	 
	 private String ldllandno;





	public String getLdllandno() {
		return ldllandno;
	}

	public void setLdllandno(String ldllandno) {
		this.ldllandno = ldllandno;
	}
	 
	private String  lblpai,laldelcharge,lblchafcharge;





	public String getLblpai() {
		return lblpai;
	}

	public void setLblpai(String lblpai) {
		this.lblpai = lblpai;
	}

	public String getLaldelcharge() {
		return laldelcharge;
	}

	public void setLaldelcharge(String laldelcharge) {
		this.laldelcharge = laldelcharge;
	}

	public String getLblchafcharge() {
		return lblchafcharge;
	}

	public void setLblchafcharge(String lblchafcharge) {
		this.lblchafcharge = lblchafcharge;
	}
	
	
	
	
	//yeti=======	
	
	private String securitycardno,securityexpdate,securitypreauthno,securitypreauthamt,tarifftotal,racdwscdwtotal,raaccessorytotal,laldelchargetotal, advtotalamont,advpaidamount,advbalance;



	public String getSecuritycardno() {
		return securitycardno;
	}

	public void setSecuritycardno(String securitycardno) {   
		                                                    
		this.securitycardno = securitycardno;                 
	}
                                                             
	public String getSecurityexpdate() {
		return securityexpdate;
	}

	public void setSecurityexpdate(String securityexpdate) {
		this.securityexpdate = securityexpdate;
	}

	public String getSecuritypreauthno() {
		return securitypreauthno;
	}

	public void setSecuritypreauthno(String securitypreauthno) {
		this.securitypreauthno = securitypreauthno;
	}

	public String getSecuritypreauthamt() {
		return securitypreauthamt;
	}

	public void setSecuritypreauthamt(String securitypreauthamt) {
		this.securitypreauthamt = securitypreauthamt;
	}

	public String getTarifftotal() {
		return tarifftotal;
	}

	public void setTarifftotal(String tarifftotal) {
		this.tarifftotal = tarifftotal;
	}

	public String getRacdwscdwtotal() {
		return racdwscdwtotal;
	}

	public void setRacdwscdwtotal(String racdwscdwtotal) {
		this.racdwscdwtotal = racdwscdwtotal;
	}

	public String getRaaccessorytotal() {
		return raaccessorytotal;
	}

	public void setRaaccessorytotal(String raaccessorytotal) {
		this.raaccessorytotal = raaccessorytotal;
	}

	public String getLaldelchargetotal() {
		return laldelchargetotal;
	}

	public void setLaldelchargetotal(String laldelchargetotal) {
		this.laldelchargetotal = laldelchargetotal;
	}

	public String getAdvtotalamont() {
		return advtotalamont;
	}

	public void setAdvtotalamont(String advtotalamont) {
		this.advtotalamont = advtotalamont;
	}

	public String getAdvpaidamount() {
		return advpaidamount;
	}

	public void setAdvpaidamount(String advpaidamount) {
		this.advpaidamount = advpaidamount;
	}

	public String getAdvbalance() {
		return advbalance;
	}

	public void setAdvbalance(String advbalance) {
		this.advbalance = advbalance;
	}
	
//-----------------	
		
	
	//Getters And Setters for Cosmo Print
	
	private String lblcosmofleetno;
	private String lblcosmofleetbrand;
	private String lblcosmoissuedat;
	private String lblcosmocheckin;
	private String lblcosmocheckout;
	private String lblcosmokmin;
	private String lblcosmofuelin;
	private String lblcosmocreditcardno;
	private String lblcosmocreditvaliddate;
	private String lblcosmosecurity;
	private String lblcosmoexcessamt;
	private String lblcosmogps;
	private String lblcosmobabyseater;
	private String lblcosmocollectchg;
	private String lblcosmodamagechg;
	private String lblcosmofuelchg;
	private String lblcosmototal;
	private String lblcosmoadvance;
	private String lblcosmokmrestrictdaily;
	private String lblcosmokmrestrictweekly;
	private String lblcosmokmrestrictmonthly;
	private String lblcosmoexkmratedaily;
	private String lblcosmoexkmrateweekly;
	private String lblcosmoexkmratemonthly;



	public String getLblcosmobabyseater() {
		return lblcosmobabyseater;
	}

	public void setLblcosmobabyseater(String lblcosmobabyseater) {
		this.lblcosmobabyseater = lblcosmobabyseater;
	}

	public String getLblcosmofleetno() {
		return lblcosmofleetno;
	}

	public void setLblcosmofleetno(String lblcosmofleetno) {
		this.lblcosmofleetno = lblcosmofleetno;
	}

	public String getLblcosmofleetbrand() {
		return lblcosmofleetbrand;
	}

	public void setLblcosmofleetbrand(String lblcosmofleetbrand) {
		this.lblcosmofleetbrand = lblcosmofleetbrand;
	}

	public String getLblcosmoissuedat() {
		return lblcosmoissuedat;
	}

	public void setLblcosmoissuedat(String lblcosmoissuedat) {
		this.lblcosmoissuedat = lblcosmoissuedat;
	}

	public String getLblcosmocheckin() {
		return lblcosmocheckin;
	}

	public void setLblcosmocheckin(String lblcosmocheckin) {
		this.lblcosmocheckin = lblcosmocheckin;
	}

	public String getLblcosmocheckout() {
		return lblcosmocheckout;
	}

	public void setLblcosmocheckout(String lblcosmocheckout) {
		this.lblcosmocheckout = lblcosmocheckout;
	}

	public String getLblcosmokmin() {
		return lblcosmokmin;
	}

	public void setLblcosmokmin(String lblcosmokmin) {
		this.lblcosmokmin = lblcosmokmin;
	}

	public String getLblcosmofuelin() {
		return lblcosmofuelin;
	}

	public void setLblcosmofuelin(String lblcosmofuelin) {
		this.lblcosmofuelin = lblcosmofuelin;
	}

	public String getLblcosmocreditcardno() {
		return lblcosmocreditcardno;
	}

	public void setLblcosmocreditcardno(String lblcosmocreditcardno) {
		this.lblcosmocreditcardno = lblcosmocreditcardno;
	}

	public String getLblcosmocreditvaliddate() {
		return lblcosmocreditvaliddate;
	}

	public void setLblcosmocreditvaliddate(String lblcosmocreditvaliddate) {
		this.lblcosmocreditvaliddate = lblcosmocreditvaliddate;
	}

	public String getLblcosmosecurity() {
		return lblcosmosecurity;
	}

	public void setLblcosmosecurity(String lblcosmosecurity) {
		this.lblcosmosecurity = lblcosmosecurity;
	}

	public String getLblcosmoexcessamt() {
		return lblcosmoexcessamt;
	}

	public void setLblcosmoexcessamt(String lblcosmoexcessamt) {
		this.lblcosmoexcessamt = lblcosmoexcessamt;
	}

	public String getLblcosmogps() {
		return lblcosmogps;
	}

	public void setLblcosmogps(String lblcosmogps) {
		this.lblcosmogps = lblcosmogps;
	}

	public String getLblcosmocollectchg() {
		return lblcosmocollectchg;
	}

	public void setLblcosmocollectchg(String lblcosmocollectchg) {
		this.lblcosmocollectchg = lblcosmocollectchg;
	}

	public String getLblcosmodamagechg() {
		return lblcosmodamagechg;
	}

	public void setLblcosmodamagechg(String lblcosmodamagechg) {
		this.lblcosmodamagechg = lblcosmodamagechg;
	}

	public String getLblcosmofuelchg() {
		return lblcosmofuelchg;
	}

	public void setLblcosmofuelchg(String lblcosmofuelchg) {
		this.lblcosmofuelchg = lblcosmofuelchg;
	}

	public String getLblcosmototal() {
		return lblcosmototal;
	}

	public void setLblcosmototal(String lblcosmototal) {
		this.lblcosmototal = lblcosmototal;
	}

	public String getLblcosmoadvance() {
		return lblcosmoadvance;
	}

	public void setLblcosmoadvance(String lblcosmoadvance) {
		this.lblcosmoadvance = lblcosmoadvance;
	}

	public String getLblcosmokmrestrictdaily() {
		return lblcosmokmrestrictdaily;
	}

	public void setLblcosmokmrestrictdaily(String lblcosmokmrestrictdaily) {
		this.lblcosmokmrestrictdaily = lblcosmokmrestrictdaily;
	}

	public String getLblcosmokmrestrictweekly() {
		return lblcosmokmrestrictweekly;
	}

	public void setLblcosmokmrestrictweekly(String lblcosmokmrestrictweekly) {
		this.lblcosmokmrestrictweekly = lblcosmokmrestrictweekly;
	}

	public String getLblcosmokmrestrictmonthly() {
		return lblcosmokmrestrictmonthly;
	}

	public void setLblcosmokmrestrictmonthly(String lblcosmokmrestrictmonthly) {
		this.lblcosmokmrestrictmonthly = lblcosmokmrestrictmonthly;
	}

	public String getLblcosmoexkmratedaily() {
		return lblcosmoexkmratedaily;
	}

	public void setLblcosmoexkmratedaily(String lblcosmoexkmratedaily) {
		this.lblcosmoexkmratedaily = lblcosmoexkmratedaily;
	}

	public String getLblcosmoexkmrateweekly() {
		return lblcosmoexkmrateweekly;
	}

	public void setLblcosmoexkmrateweekly(String lblcosmoexkmrateweekly) {
		this.lblcosmoexkmrateweekly = lblcosmoexkmrateweekly;
	}

	public String getLblcosmoexkmratemonthly() {
		return lblcosmoexkmratemonthly;
	}

	public void setLblcosmoexkmratemonthly(String lblcosmoexkmratemonthly) {
		this.lblcosmoexkmratemonthly = lblcosmoexkmratemonthly;
	}
	
	private String cmbtarifnew;
	private String hidcmbtarifnew;



	public String getCmbtarifnew() {
		return cmbtarifnew;
	}

	public void setCmbtarifnew(String cmbtarifnew) {
		this.cmbtarifnew = cmbtarifnew;
	}

	public String getHidcmbtarifnew() {
		return hidcmbtarifnew;
	}

	public void setHidcmbtarifnew(String hidcmbtarifnew) {
		this.hidcmbtarifnew = hidcmbtarifnew;
	}
	
	
	
	
	
	
	
	
	
	
}