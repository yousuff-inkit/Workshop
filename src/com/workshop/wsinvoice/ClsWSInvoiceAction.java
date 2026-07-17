package com.workshop.wsinvoice;

import java.io.IOException;
import java.sql.*;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.math.*;

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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.ibm.icu.math.BigDecimal;
import com.workshop.wsjobcard.ClsWSJobCardBean;
import com.workshop.wsjobcard.ClsWSJobCardDAO;

public class ClsWSInvoiceAction {

	ClsWSInvoiceDAO invoicedao = new ClsWSInvoiceDAO();
	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();
	private String vocno, docno, date, cmbreftype, refno, hidrefno, regno,
			vehicledetails, cldocno, userdetails, invoicetoaccount,
			invoicetoacname, invoicetoacno, tempinvoicetoaccount,
			tempinvoicetoacname, excessamountacno, excessamountacname,
			excessamountaccount, total, discount, excessamount, nettotal,
			esttootal, remarks, brchName, formdetailcode, mode, msg, deleted,
			hidcmbreftype, taxpercent, taxamount, taxtotal, roundamt;
	private String lblcompname, lblcompaddress, lblprintname, lblbranch,
			lbllocation, lblcomptel, lblcompfax;
	private String lbldate, lblinvno, lblrefno, lblclient, lbladdress,
			lblmobile, lblemail, lblvehicle, lblchassis;
	private String lblcheckedby, lblrecievedby, lblfinaldate;
	private String lbltotal, lbltax, lblnetamount, lblamountwords, lblround;
	private String lblcomptrn, lblclienttrn;
	private String lblproformatotal, lblproformatax, lblproformanetamount,
			lblproformaamountwords, lblproformaround;
	private String hidchksaperateinvoice;
	private String lblremarks;
	private String vehdetails;
	private String woroundof;
	private String amtinwords;
	private String preparedby;
	private String lblkilometer,lbljobdate;
	private String lblcompremarks;
    private String lblcarfarevehicle;
	
	
	
	
	public String getLblcarfarevehicle() {
		return lblcarfarevehicle;
	}

	public void setLblcarfarevehicle(String lblcarfarevehicle) {
		this.lblcarfarevehicle = lblcarfarevehicle;
	}

	
	
	
	public String getLblcompremarks() {
		return lblcompremarks;
	}

	public void setLblcompremarks(String lblcompremarks) {
		this.lblcompremarks = lblcompremarks;
	}

	public String getLblkilometer() {
		return lblkilometer;
	}

	public void setLblkilometer(String lblkilometer) {
		this.lblkilometer = lblkilometer;
	}

	public String getLbljobdate() {
		return lbljobdate;
	}

	public void setLbljobdate(String lbljobdate) {
		this.lbljobdate = lbljobdate;
	}

	public String getExcessamount() {
		return excessamount;
	}

	public void setExcessamount(String excessamount) {
		this.excessamount = excessamount;
	}
	
	public String getPreparedby() {
		return preparedby;
	}

	public void setPreparedby(String preparedby) {
		this.preparedby = preparedby;
	}

	public String getAmtinwords() {
		return amtinwords;
	}

	public void setAmtinwords(String amtinwords) {
		this.amtinwords = amtinwords;
	}

	public String getWoroundof() {
		return woroundof;
	}

	public void setWoroundof(String woroundof) {
		this.woroundof = woroundof;
	}

	public String getVehdetails() {
		return vehdetails;
	}

	public void setVehdetails(String vehdetails) {
		this.vehdetails = vehdetails;
	}

	private String url;
	private Map<String, Object> param = null;
	private String wsinvqry;
	private String wsjobqry;
	private String wsspareqry;
	private String insuracno, clientacno;
	private String tempinvoicetoacno;
	private String policereportno;
	private String claim;
	private String lpo;
	private String lblregno;
	private String brand;
	private String model;
	private String lblsparequery;

	
	
	public String getLblsparequery() {
		return lblsparequery;
	}

	public void setLblsparequery(String lblsparequery) {
		this.lblsparequery = lblsparequery;
	}

	public String getLblregno() {
		return lblregno;
	}

	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getPolicereportno() {
		return policereportno;
	}

	public void setPolicereportno(String policereportno) {
		this.policereportno = policereportno;
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

	public String getTempinvoicetoacno() {
		return tempinvoicetoacno;
	}

	public void setTempinvoicetoacno(String tempinvoicetoacno) {
		this.tempinvoicetoacno = tempinvoicetoacno;
	}

	public String getInsuracno() {
		return insuracno;
	}

	public void setInsuracno(String insuracno) {
		this.insuracno = insuracno;
	}

	public String getClientacno() {
		return clientacno;
	}

	public void setClientacno(String clientacno) {
		this.clientacno = clientacno;
	}

	public String getWsjobqry() {
		return wsjobqry;
	}

	public void setWsjobqry(String wsjobqry) {
		this.wsjobqry = wsjobqry;
	}

	public String getWsspareqry() {
		return wsspareqry;
	}

	public void setWsspareqry(String wsspareqry) {
		this.wsspareqry = wsspareqry;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String getWsinvqry() {
		return wsinvqry;
	}

	public void setWsinvqry(String wsinvqry) {
		this.wsinvqry = wsinvqry;
	}

	public String getLblproformaround() {
		return lblproformaround;
	}

	public void setLblproformaround(String lblproformaround) {
		this.lblproformaround = lblproformaround;
	}

	public String getLblremarks() {
		return lblremarks;
	}

	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}

	public String getHidchksaperateinvoice() {
		return hidchksaperateinvoice;
	}

	public void setHidchksaperateinvoice(String hidchksaperateinvoice) {
		this.hidchksaperateinvoice = hidchksaperateinvoice;
	}

	public String getTempinvoicetoaccount() {
		return tempinvoicetoaccount;
	}

	public void setTempinvoicetoaccount(String tempinvoicetoaccount) {
		this.tempinvoicetoaccount = tempinvoicetoaccount;
	}

	public String getTempinvoicetoacname() {
		return tempinvoicetoacname;
	}

	public void setTempinvoicetoacname(String tempinvoicetoacname) {
		this.tempinvoicetoacname = tempinvoicetoacname;
	}

	public String getLblround() {
		return lblround;
	}

	public void setLblround(String lblround) {
		this.lblround = lblround;
	}

	public String getRoundamt() {
		return roundamt;
	}

	public void setRoundamt(String roundamt) {
		this.roundamt = roundamt;
	}

	public String getLblproformatotal() {
		return lblproformatotal;
	}

	public void setLblproformatotal(String lblproformatotal) {
		this.lblproformatotal = lblproformatotal;
	}

	public String getLblproformatax() {
		return lblproformatax;
	}

	public void setLblproformatax(String lblproformatax) {
		this.lblproformatax = lblproformatax;
	}

	public String getLblproformanetamount() {
		return lblproformanetamount;
	}

	public void setLblproformanetamount(String lblproformanetamount) {
		this.lblproformanetamount = lblproformanetamount;
	}

	public String getLblproformaamountwords() {
		return lblproformaamountwords;
	}

	public void setLblproformaamountwords(String lblproformaamountwords) {
		this.lblproformaamountwords = lblproformaamountwords;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public String getLblclienttrn() {
		return lblclienttrn;
	}

	public void setLblclienttrn(String lblclienttrn) {
		this.lblclienttrn = lblclienttrn;
	}

	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}

	public String getLbltax() {
		return lbltax;
	}

	public void setLbltax(String lbltax) {
		this.lbltax = lbltax;
	}

	public String getLblnetamount() {
		return lblnetamount;
	}

	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}

	public String getLblamountwords() {
		return lblamountwords;
	}

	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblinvno() {
		return lblinvno;
	}

	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}

	public String getLblclient() {
		return lblclient;
	}

	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}

	public String getLbladdress() {
		return lbladdress;
	}

	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}

	public String getLblmobile() {
		return lblmobile;
	}

	public void setLblmobile(String lblmobile) {
		this.lblmobile = lblmobile;
	}

	public String getLblemail() {
		return lblemail;
	}

	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}

	public String getLblvehicle() {
		return lblvehicle;
	}

	public void setLblvehicle(String lblvehicle) {
		this.lblvehicle = lblvehicle;
	}

	public String getLblchassis() {
		return lblchassis;
	}

	public void setLblchassis(String lblchassis) {
		this.lblchassis = lblchassis;
	}

	public String getLblcheckedby() {
		return lblcheckedby;
	}

	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}

	public String getLblrecievedby() {
		return lblrecievedby;
	}

	public void setLblrecievedby(String lblrecievedby) {
		this.lblrecievedby = lblrecievedby;
	}

	public String getLblfinaldate() {
		return lblfinaldate;
	}

	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
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

	public String getTaxpercent() {
		return taxpercent;
	}

	public void setTaxpercent(String taxpercent) {
		this.taxpercent = taxpercent;
	}

	public String getTaxamount() {
		return taxamount;
	}

	public void setTaxamount(String taxamount) {
		this.taxamount = taxamount;
	}

	public String getTaxtotal() {
		return taxtotal;
	}

	public void setTaxtotal(String taxtotal) {
		this.taxtotal = taxtotal;
	}

	private int gridlength;

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

	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno) {
		this.vocno = vocno;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getCmbreftype() {
		return cmbreftype;
	}

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getHidrefno() {
		return hidrefno;
	}

	public void setHidrefno(String hidrefno) {
		this.hidrefno = hidrefno;
	}

	public String getRegno() {
		return regno;
	}

	public void setRegno(String regno) {
		this.regno = regno;
	}

	public String getVehicledetails() {
		return vehicledetails;
	}

	public void setVehicledetails(String vehicledetails) {
		this.vehicledetails = vehicledetails;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getUserdetails() {
		return userdetails;
	}

	public void setUserdetails(String userdetails) {
		this.userdetails = userdetails;
	}

	public String getInvoicetoaccount() {
		return invoicetoaccount;
	}

	public void setInvoicetoaccount(String invoicetoaccount) {
		this.invoicetoaccount = invoicetoaccount;
	}

	public String getInvoicetoacname() {
		return invoicetoacname;
	}

	public void setInvoicetoacname(String invoicetoacname) {
		this.invoicetoacname = invoicetoacname;
	}

	public String getInvoicetoacno() {
		return invoicetoacno;
	}

	public void setInvoicetoacno(String invoicetoacno) {
		this.invoicetoacno = invoicetoacno;
	}

	public String getExcessamountacno() {
		return excessamountacno;
	}

	public void setExcessamountacno(String excessamountacno) {
		this.excessamountacno = excessamountacno;
	}

	public String getExcessamountacname() {
		return excessamountacname;
	}

	public void setExcessamountacname(String excessamountacname) {
		this.excessamountacname = excessamountacname;
	}

	public String getExcessamountaccount() {
		return excessamountaccount;
	}

	public void setExcessamountaccount(String excessamountaccount) {
		this.excessamountaccount = excessamountaccount;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	

	public String getNettotal() {
		return nettotal;
	}

	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}

	public String getEsttootal() {
		return esttootal;
	}

	public void setEsttootal(String esttootal) {
		this.esttootal = esttootal;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}

	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}

	public void setData(String docno, String vocno, java.sql.Date sqldate) {
		setDocno(docno);
		setVocno(vocno);
		setDate(sqldate.toString());
		setCmbreftype(getCmbreftype());
		setHidrefno(getHidrefno());
		setRefno(getRefno());
		setRegno(getRegno());
		setVehicledetails(getVehicledetails());
		setUserdetails(getUserdetails());
		setCldocno(getCldocno());
		setInvoicetoaccount(getInvoicetoaccount());
		setInvoicetoacname(getInvoicetoacname());
		setInvoicetoacno(getInvoicetoacno());
		setExcessamount(getExcessamount());
		setExcessamountaccount(getExcessamountaccount());
		setExcessamountacname(getExcessamountacname());
		setExcessamountacno(getExcessamountacno());
		setRemarks(getRemarks());
		setTotal(getTotal());
		setDiscount(getDiscount());
		setNettotal(getNettotal());
		setHidcmbreftype(getCmbreftype());
		setTaxamount(getTaxamount());
		setTaxpercent(getTaxpercent());
		setTaxtotal(getTaxtotal());
		setTempinvoicetoaccount(getTempinvoicetoaccount());
		setTempinvoicetoacname(getTempinvoicetoacname());
		setHidchksaperateinvoice(getHidchksaperateinvoice());
		setTempinvoicetoacno(getTempinvoicetoacno());
	}

	public String saveAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode = getMode();
		Connection conn = null;
		try {
			if (getHidchksaperateinvoice().equalsIgnoreCase("")) {
				setHidchksaperateinvoice("0");
			}
			if (!mode.equalsIgnoreCase("view")) {
				java.sql.Date sqldate = null;
				if (getDate() != null && !getDate().equalsIgnoreCase("")) {
					sqldate = objcommon.changeStringtoSqlDate(getDate());
				}
				

				conn = objconn.getMyConnection();
				conn.setAutoCommit(false);
				if (mode.equalsIgnoreCase("A")) {
					ArrayList<String> invoicearray = new ArrayList<>();
					for (int i = 0; i < getGridlength(); i++) {
						String temp = requestParams.get("invoicearray" + i)[0];
						invoicearray.add(temp);
					}
					int insertval = invoicedao.insert(sqldate, getCmbreftype(),
							getHidrefno(), getCldocno(), getInvoicetoacno(),
							getExcessamountacno(), getTotal(), getDiscount(),
							getExcessamount(), getNettotal(), getRemarks(),
							session, request, getMode(), getFormdetailcode(),
							getBrchName(), invoicearray, conn, getTaxpercent(),
							getTaxamount(), getTaxtotal(),
							getHidchksaperateinvoice(), getTempinvoicetoacno());
					if (insertval > 0) {
						int billtoinsur = invoicedao.checkBillToInsurance(
								getHidrefno(), conn);
						if (getHidchksaperateinvoice().equalsIgnoreCase("1")
								&& billtoinsur == 1) {
							ArrayList<String> excessinvarray = new ArrayList<>();
							excessinvarray = invoicedao.getExcessInvDetails(
									conn, getHidrefno(), getExcessamount());
							int saperateInvInsert = invoicedao
									.saperateInvInsert(sqldate,
											getCmbreftype(), getHidrefno(),
											getCldocno(), getInvoicetoacno(),
											getExcessamountacno(), getTotal(),
											getDiscount(), getExcessamount(),
											getNettotal(), getRemarks(),
											session, request, getMode(),
											getFormdetailcode(), getBrchName(),
											excessinvarray, conn, "0", "0",
											getTaxtotal(), insertval,
											getInvoicetoacno());
							if (saperateInvInsert <= 0) {
								setData(insertval + "", "", sqldate);
								setRoundamt("0");
								setMsg("Not Saved");
								return "fail";
							}
						}
						conn.commit();
						setData(insertval + "",
								request.getAttribute("WSINVVOCNO").toString(),
								sqldate);
						setRoundamt(invoicedao.getRoundAmount(getDocno()));
						System.out.println("Round Save:" + getRoundamt());
						setMsg("Successfully Saved");

						return "success";
					} else {
						System.out.println("========== action ===="+insertval + "  "+sqldate);
						setData(insertval + "", "", sqldate);
						setRoundamt("0");
						setMsg("Not Saved");
						return "fail";
					}
				}
				else if (mode.equalsIgnoreCase("E")) {
					ArrayList<String> invoicearray = new ArrayList<>();
					for (int i = 0; i < getGridlength(); i++) {
						String temp = requestParams.get("invoicearray" + i)[0];
						invoicearray.add(temp);
					}
					boolean status = invoicedao.edit(sqldate, getCmbreftype(),
							getHidrefno(), getCldocno(), getInvoicetoacno(),
							getExcessamountacno(), getTotal(), getDiscount(),
							getExcessamount(), getNettotal(), getRemarks(),
							session, request, getMode(), getFormdetailcode(),
							getBrchName(), invoicearray, conn, getTaxpercent(),
							getTaxamount(), getTaxtotal(),
							getHidchksaperateinvoice(), getTempinvoicetoacno(),Integer.parseInt(getDocno()),getRoundamt());
					//System.out.println("Returned Edit Value:"+status);
					if (status) {
						/*int billtoinsur = invoicedao.checkBillToInsurance(
								getHidrefno(), conn);
						if (getHidchksaperateinvoice().equalsIgnoreCase("1")
								&& billtoinsur == 1) {
							ArrayList<String> excessinvarray = new ArrayList<>();
							excessinvarray = invoicedao.getExcessInvDetails(
									conn, getHidrefno(), getExcessamount());
							int saperateInvInsert = invoicedao
									.saperateInvInsert(sqldate,
											getCmbreftype(), getHidrefno(),
											getCldocno(), getInvoicetoacno(),
											getExcessamountacno(), getTotal(),
											getDiscount(), getExcessamount(),
											getNettotal(), getRemarks(),
											session, request, getMode(),
											getFormdetailcode(), getBrchName(),
											excessinvarray, conn, "0", "0",
											getTaxtotal(), Integer.parseInt(getDocno()),
											getInvoicetoacno());
							if (saperateInvInsert <= 0) {
								setData(getDocno() + "", "", sqldate);
								setRoundamt("0");
								setMsg("Not Saved");
								return "fail";
							}*/
						conn.commit();
						setData(getDocno() + "",
								request.getAttribute("WSINVVOCNO").toString(),
								sqldate);
						setRoundamt(invoicedao.getRoundAmount(getDocno()));
						//System.out.println("Round Save:" + getRoundamt());
						setMsg("Successfully Saved");

						return "success";
					} else {
						//System.out.println("========== action edit===="+getDocno()+ "  "+sqldate);
						setData(getDocno() + "", "", sqldate);
						setRoundamt("0");
						setMsg("Not Saved");
						return "fail";
					}
				}
				else if (mode.equalsIgnoreCase("D")) {
					ArrayList<String> invoicearray = new ArrayList<>();
					/*for (int i = 0; i < getGridlength(); i++) {
						String temp = requestParams.get("invoicearray" + i)[0];
						invoicearray.add(temp);
					}*/
					boolean status = invoicedao.delete(sqldate, getCmbreftype(),
							getHidrefno(), getCldocno(), getInvoicetoacno(),
							getExcessamountacno(), getTotal(), getDiscount(),
							getExcessamount(), getNettotal(), getRemarks(),
							session, request, getMode(), getFormdetailcode(),
							getBrchName(), invoicearray, conn, getTaxpercent(),
							getTaxamount(), getTaxtotal(),
							getHidchksaperateinvoice(), getTempinvoicetoacno(),
							Integer.parseInt(getDocno()),getRoundamt());
					//System.out.println("Returned Edit Value:"+status);
					if (status) {
						conn.commit();
						setData(getDocno() + "",
								request.getAttribute("WSINVVOCNO").toString(),
								sqldate);
						setRoundamt(invoicedao.getRoundAmount(getDocno()));
						//System.out.println("Round Save:" + getRoundamt());
						setMsg("Successfully Deleted");
						setDeleted("DELETED");
						return "success";
					} else {
						//System.out.println("========== action edit===="+getDocno()+ "  "+sqldate);
						setData(getDocno() + "", "", sqldate);
						setRoundamt("0");
						setMsg("Not Deleted");
						return "fail";
					}
				}
				conn.close();
			}
		} catch (Exception e) {

			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return "fail";
	}

	public String printAction() throws ParseException, SQLException, Exception {
		try {
			ClsWSInvoiceDAO invoicedao = new ClsWSInvoiceDAO();
			ClsWSInvoiceBean bean = new ClsWSInvoiceBean();
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpSession session = request.getSession();
			HttpServletResponse response = ServletActionContext.getResponse();
			String doc = request.getParameter("docno");
			String brhid=request.getParameter("branch");
			String jobcarddocno = request.getParameter("jobcarddocno");    
			int header=Integer.parseInt(request.getParameter("header"));
			String dtype = "MNT";

			bean = invoicedao.printDetails(doc, request);
			setUrl(objcommon.getPrintPath(dtype));
			setLblremarks(bean.getLblremarks());
			setLblrefno(bean.getLblrefno());
			setLbldate(bean.getLbldate());
			setLblinvno(bean.getLblinvno());
			setLblclient(bean.getLblclient());
			setLbladdress(bean.getLbladdress());
			setLblemail(bean.getLblemail());
			setLblmobile(bean.getLblmobile());
			setLblvehicle(bean.getLblvehicle());
			setLblbranch(bean.getLblbranch());
			setLblprintname("Tax Invoice");
			setLblcompaddress(bean.getLblcompaddress());
			setLblcompname(bean.getLblcompname());
			setLblcomptel(bean.getLblcomptel());
			setLblcompfax(bean.getLblcompfax());
			setLbltotal(bean.getLbltotal());
			setLbltax(bean.getLbltax());
			setLblnetamount(bean.getLblnetamount());
			setLblamountwords(bean.getLblamountwords());
			setLblcheckedby(bean.getLblcheckedby());
			setLblfinaldate(bean.getLblfinaldate());
			setLblclienttrn(bean.getLblclienttrn());
			setLblcomptrn(bean.getLblcomptrn());
			setLblproformaamountwords(bean.getLblproformaamountwords());
			setLblproformanetamount(bean.getLblproformanetamount());
			setLblproformatax(bean.getLblproformatax());
			setLblproformatotal(bean.getLblproformatotal());
			setLblround(bean.getLblround());
			setLblchassis(bean.getLblchassis());
			setLblproformaround(bean.getLblproformaround());
			setVehdetails(bean.getVehdetails());
			setPolicereportno(bean.getPolicereportno());
			setLpo(bean.getLpo());
			setClaim(bean.getClaim());
			setBrand(bean.getBrand());
			setLblregno(bean.getLblregno());
			setModel(bean.getModel());
			setWoroundof(bean.getWoroundof());
			setAmtinwords(bean.getAmtinwords());
			setPreparedby(bean.getPreparedby());
			setExcessamount(bean.getExcessamount());
			setLblkilometer(bean.getLblkilometer());
			setLbljobdate(bean.getLbljobdate());
			setLblcompremarks(bean.getLblcompremarks());
			setLblcarfarevehicle(bean.getLblcarfarevehicle());
			setLblsparequery(bean.getLblsparequery());
			
			if (objcommon.getPrintPath(dtype).contains(".jrxml") == true) {

				ClsConnection conobj = new ClsConnection();

				System.out.println("inside");
				param = new HashMap();
				Connection conn = null;
				conn = conobj.getMyConnection();
	    	     Statement stmt = conn.createStatement();
	    	     ClsAmountToWords objamount=new ClsAmountToWords();  
				String reportFileName = "WorkshopInvoice";
			    int proformaconfig=0;  
				try {
					String imgpath3 ="",path1="",imgpal="",amountinwords="";
					String imgpath = request.getSession().getServletContext()
							.getRealPath("/icons/epic.jpg");
					imgpath = imgpath.replace("\\", "\\\\");
					String imgpath1 = request.getSession().getServletContext()
							.getRealPath("/icons/epic.jpg");
					imgpath1 = imgpath.replace("\\", "\\\\");
					String imgpath2 =request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
					imgpath2 = imgpath2.replace("\\", "\\\\");
                    if(header==1){
					imgpath3 =request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
					imgpath3 = imgpath3.replace("\\", "\\\\");
                    }
                    String strsql2="select imgpath from my_brch where doc_no='"+brhid+"'";          
		    	     ResultSet rs2=stmt.executeQuery(strsql2);          
		    	     while(rs2.next()){         
		    	    	 path1=rs2.getString("imgpath");         
		    	     }
		    	     Double servicetot=0.0,partstot=0.0,nettotal=0.0,vatamt=0.0;
		    	     String strsql3="select coalesce(total,0) total,coalesce(vatamt,0) vatamt from(select round(sum(m.taxtotal),2) total,round(sum(m.taxamount),2) vatamt from ws_invm m where m.doc_no='"+doc+"' group by doc_no)a";  
		    	     System.out.println("strsql3=="+strsql3);
		    	     ResultSet rs3=stmt.executeQuery(strsql3);          
		    	     while(rs3.next()){         
		    	    	 amountinwords=objamount.convertAmountToWords(rs3.getString("total"));  
		    	    	 vatamt=rs3.getDouble("vatamt");  
		    	    	 nettotal=rs3.getDouble("total");    
		    	     }
		    	     String strsql4="select method from gl_config where field_nme='WSJCProforma'";   
		    	     System.out.println("strsql4=="+strsql4);
		    	     ResultSet rs4=stmt.executeQuery(strsql4);          
		    	     while(rs4.next()){          
		    	    	 proformaconfig=rs4.getInt("method");               
		    	     }
		    	     
		    	     String addition="";
		 			 String straddition="select group_concat(distinct t.addition) addition from ws_invm m left join ws_invcalctemp t on m.doc_no=t.invno where m.doc_no="+doc;
		 			 System.out.println(addition+"==="+straddition);
		 					ResultSet rsadd=stmt.executeQuery(straddition);
		 					while(rsadd.next()){
		 						addition=rsadd.getString("addition");
		 					}
		    	     String detailsql="";
		 			 if(proformaconfig==1){  
		 				detailsql="select @j:=@j+1 as slno,b.* from(select 'Services' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount from ("+
		 						" select @i:=0 count,lab.strjobdesc description,round(lab.invoiceamt,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
		 						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
		 						" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+jobcarddocno+" and lab.addition='"+addition+"' and card.status=3 and lab.confirmed=1 and lab.approved=1 union all "+
		 						" select @i:=0 count,extra.description,round(extra.amount,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
		 						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_jccextra extra "+
		 						" on card.doc_no=extra.jobcarddocno where card.doc_no="+jobcarddocno+" and card.status=3  and coalesce(extra.jobcarddocno,0)<>0)a union all"+
		 						" select 'Parts' type,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount from ("+
		 						" select @j:=0 count,if(spare.description='',m.productname,spare.description) description,round(spare.customeramt,2) amount,est.voc_no from ws_jccspare spare left join ws_jobcard card on spare.jobcarddocno=card.doc_no left join "+
		 					" ws_estm est on (card.reftype='EST' and card.refno=est.doc_no)  left join my_main m on m.psrno=spare.psrno "+
		 					" where card.doc_no="+jobcarddocno+" and spare.addition='"+addition+"' and card.status=3)a)b,(select @j:=0) r";
		 			}
		 			else{
		 				detailsql="select @j:=@j+1 as slno,b.* from(select 'Services' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount from ("+
		 						" select @i:=0 count,lab.strjobdesc description,round(lab.total,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on "+
		 						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
		 						" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+jobcarddocno+" and lab.addition='"+addition+"' and card.status=3 and lab.confirmed=1 and lab.approved=1 )a union all"+
		 						" select 'Parts' type,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount from ("+
		 						" select @j:=0 count,spare.description,round(spare.approvedvalue,2) amount,est.voc_no from ws_jobcard card left join ws_estm est on"+
		 							" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estspare spare on est.doc_no=spare.rdocno  where card.doc_no="+jobcarddocno+" and spare.addition='"+addition+"' "+
		 							" and card.status=3)a)b,(select @j:=0) r";            
		 			}
		 			System.out.println("detailsql--->>>"+detailsql);
		 			
		 			String strservie="select round(sum(coalesce(lab.invoiceamt,0)),2) servicetot from ws_jobcard card inner join ws_estm est on (card.reftype='EST' and card.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno  where card.doc_no="+jobcarddocno+" and lab.addition='"+addition+"'";
		 			System.out.println(strservie+"==="+strservie);
		 			ResultSet rsser=stmt.executeQuery(strservie);
		 			while(rsser.next()){
		 					servicetot=rsser.getDouble("servicetot");
		 			}
		 			String strparts="select round(sum(coalesce(customeramt,0)),2) partstot from ws_jccspare where jobcarddocno="+jobcarddocno+" and addition='"+addition+"'";
		 			System.out.println(strparts+"==="+strparts);  
		 			ResultSet rsparts=stmt.executeQuery(strparts);
		 			while(rsparts.next()){
		 				partstot=rsparts.getDouble("partstot");  
		 			}  
		 			param.put("lumsumlabour", servicetot);
		 			param.put("lumsumparts", partstot);
		 			param.put("totallumsum", partstot+servicetot);      
		 			param.put("vatamt", vatamt);
		 			param.put("nettotal", nettotal);
		 			param.put("amountwords", objamount.convertAmountToWords(nettotal+""));     
		    	    imgpal =request.getSession().getServletContext().getRealPath(path1);  
		    	    imgpal = imgpal.replace("\\", "\\\\");
		    	    param.put("detailsql", detailsql); 
		    	    param.put("imgpal", imgpal);   
                    param.put("docno", doc);   
					param.put("complogo", imgpath);
					param.put("compfooter", imgpath1);
                    param.put("imgheader", imgpath2);
                    param.put("imgheader22", imgpath3);
					param.put("wsqry1", bean.getWsinvqry());
					param.put("wsqry2", bean.getWsjobqry());
					param.put("wsqry3", bean.getWsspareqry());
					param.put("spareqry", bean.getLblsparequery());
					
                    param.put("companyname", bean.getLblcompname());
					param.put("companyaddress", bean.getLblcompaddress());
					param.put("comptel", bean.getLblcomptel());
					param.put("compfax", bean.getLblcompfax());
					param.put("comptrn", bean.getLblcomptrn());

					param.put("excesscharge",bean.getExcessamount());
					param.put("customer", bean.getLblclient());
					param.put("invno", bean.getLblinvno());
					param.put("cltrnno", bean.getLblclienttrn());
					param.put("address", bean.getLbladdress());
					param.put("date", bean.getLbldate());
					
					param.put("mobno", bean.getLblmobile());
					param.put("jcno", bean.getLblrefno());
					param.put("email", bean.getLblemail());
					param.put("veh",bean.getLblcarfarevehicle());
					param.put("vehicles", bean.getLblvehicle());
					param.put("vehicle", bean.getVehdetails());
					param.put("chasisno", bean.getLblchassis());
					param.put("comptrnno", bean.getLblcomptrn());
					param.put("regno", bean.getLblregno());
					param.put("model", bean.getModel());
					param.put("brand", bean.getBrand());
                    param.put("totalfancy", bean.getTotalfancy());
                    param.put("total", bean.getLbltotal());
					param.put("vat", bean.getLbltax());
					param.put("roundoff", bean.getLblround());
					param.put("netamt", bean.getLblnetamount());
					param.put("amtwords", bean.getLblamountwords());
                    param.put("preparedby", bean.getPreparedby());
					param.put("ptotal", bean.getLblproformatotal());
					param.put("pvat", bean.getLblproformatax());
					param.put("proundoff", bean.getLblproformaround());
					param.put("pnetamt", bean.getLblproformanetamount());
					param.put("pamtwords", bean.getLblproformaamountwords());
					param.put("remarks", bean.getLblremarks());
                    param.put("netamount", bean.getWoroundof());
					param.put("processedby", bean.getLblcheckedby());
					param.put("printedby", session.getAttribute("USERNAME"));
					param.put("receivedby", bean.getLblrecievedby());
					param.put("fdate", bean.getLblfinaldate());
					param.put("policereportno", bean.getPolicereportno());
					param.put("claimno", bean.getClaim());
					param.put("lpono", bean.getLpo());
					param.put("fancyclaimno", bean.getLblclaimnofancy());
					param.put("fancylpono", bean.getLbllponofancy());
					param.put("amountinwords", bean.getAmtinwords());
					param.put("customerfancy", bean.getLblclientfancy());
					param.put("cltrnnofancy", bean.getLblclienttrnfancy());
					param.put("addressfancy", bean.getLbladdressfancy());
					param.put("jobcarddate", bean.getLbljobdate());
					param.put("kilometer", bean.getLblkilometer());
					param.put("compremarks", bean.getLblcompremarks());
					param.put("puser", session.getAttribute("USERNAME"));
					param.put("amountinwordspal", amountinwords);  
					System.out.println("actionnnnnn"+bean.getAmtinwords()+bean.getWoroundof());
					JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath(dtype)));
					JasperReport jasperReport = JasperCompileManager
							.compileReport(design);
					generateReportPDF(response, param, jasperReport, conn);
				} catch (Exception e) {
					e.printStackTrace();
					conn.close();
				} finally {
					conn.close();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}

	private void generateReportPDF(HttpServletResponse resp, Map parameters,
			JasperReport jasperReport, Connection conn) throws JRException,
			NamingException, SQLException, IOException {
		byte[] bytes = null;
		bytes = JasperRunManager.runReportToPdf(jasperReport, parameters, conn);
		resp.reset();
		resp.resetBuffer();

		resp.setContentType("application/pdf");
		resp.setContentLength(bytes.length);
		ServletOutputStream ouputStream = resp.getOutputStream();
		ouputStream.write(bytes, 0, bytes.length);

		ouputStream.flush();
		ouputStream.close();

	}
}
