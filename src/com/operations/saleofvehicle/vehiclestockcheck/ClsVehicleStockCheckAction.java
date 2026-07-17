package com.operations.saleofvehicle.vehiclestockcheck;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsVehicleStockCheckAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();

	ClsVehicleStockCheckDAO vehicleStockCheckDAO= new ClsVehicleStockCheckDAO();
	ClsVehicleStockCheckBean vehicleStockCheckBean;

	private int txtvehstockcheckdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxStockCheckDate;
	private String hidjqxStockCheckDate;
	private int txtreadytorent;
	private int txtunrentable;
	private int txttotal;
	private String txtremarks;
	
	//Stock Check Grid
	private int gridlength;
	
	public int getTxtvehstockcheckdocno() {
		return txtvehstockcheckdocno;
	}

	public void setTxtvehstockcheckdocno(int txtvehstockcheckdocno) {
		this.txtvehstockcheckdocno = txtvehstockcheckdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getJqxStockCheckDate() {
		return jqxStockCheckDate;
	}

	public void setJqxStockCheckDate(String jqxStockCheckDate) {
		this.jqxStockCheckDate = jqxStockCheckDate;
	}

	public String getHidjqxStockCheckDate() {
		return hidjqxStockCheckDate;
	}

	public void setHidjqxStockCheckDate(String hidjqxStockCheckDate) {
		this.hidjqxStockCheckDate = hidjqxStockCheckDate;
	}

	public int getTxtreadytorent() {
		return txtreadytorent;
	}

	public void setTxtreadytorent(int txtreadytorent) {
		this.txtreadytorent = txtreadytorent;
	}

	public int getTxtunrentable() {
		return txtunrentable;
	}

	public void setTxtunrentable(int txtunrentable) {
		this.txtunrentable = txtunrentable;
	}

	public int getTxttotal() {
		return txttotal;
	}

	public void setTxttotal(int txttotal) {
		this.txttotal = txttotal;
	}

	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date stockCheckDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsVehicleStockCheckBean bean = new ClsVehicleStockCheckBean();
		stockCheckDate = ClsCommon.changeStringtoSqlDate(getJqxStockCheckDate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Stock-Check Grid Saving*/
			ArrayList<String> stockcheckarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				stockcheckarray.add(temp);
			}
			/*Stock-Check Grid Saving Ends*/
			
						int val=vehicleStockCheckDAO.insert(stockCheckDate,getFormdetailcode(),getTxtreadytorent(),getTxtunrentable(),getTxttotal(),getTxtremarks(),stockcheckarray,session,mode);
						if(val>0.0){
							
							setTxtvehstockcheckdocno(val);
							setHidjqxStockCheckDate(stockCheckDate.toString());
							setTxtreadytorent(getTxtreadytorent());
							setTxtunrentable(getTxtunrentable());
							setTxttotal(getTxttotal());
							setTxtremarks(getTxtremarks());
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setHidjqxStockCheckDate(stockCheckDate.toString());
							setTxtreadytorent(getTxtreadytorent());
							setTxtunrentable(getTxtunrentable());
							setTxttotal(getTxttotal());
							setTxtremarks(getTxtremarks());
							
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
			/*Updating Stock-Check Grid */
			ArrayList<String> stockcheckarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				stockcheckarray.add(temp);
			}
			/*Updating Stock-Check Ends*/
			
			boolean Status=vehicleStockCheckDAO.edit(getTxtvehstockcheckdocno(),getFormdetailcode(),stockCheckDate,getTxtreadytorent(),getTxtunrentable(),getTxttotal(),getTxtremarks(),stockcheckarray,session,mode);
			if(Status){

				setTxtvehstockcheckdocno(getTxtvehstockcheckdocno());
				setHidjqxStockCheckDate(stockCheckDate.toString());
				setTxtreadytorent(getTxtreadytorent());
				setTxtunrentable(getTxtunrentable());
				setTxttotal(getTxttotal());
				setTxtremarks(getTxtremarks());
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtvehstockcheckdocno(getTxtvehstockcheckdocno());
				setHidjqxStockCheckDate(stockCheckDate.toString());
				setTxtreadytorent(getTxtreadytorent());
				setTxtunrentable(getTxtunrentable());
				setTxttotal(getTxttotal());
				setTxtremarks(getTxtremarks());
				
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){

			boolean Status=vehicleStockCheckDAO.delete(getTxtvehstockcheckdocno(),getFormdetailcode(),session);
			if(Status){
				
				setTxtvehstockcheckdocno(getTxtvehstockcheckdocno());
				//setHidjqxStockCheckDate(stockCheckDate.toString());
				setTxtreadytorent(getTxtreadytorent());
				setTxtunrentable(getTxtunrentable());
				setTxttotal(getTxttotal());
				setTxtremarks(getTxtremarks());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtvehstockcheckdocno(getTxtvehstockcheckdocno());
				//setHidjqxStockCheckDate(stockCheckDate.toString());
				setTxtreadytorent(getTxtreadytorent());
				setTxtunrentable(getTxtunrentable());
				setTxttotal(getTxttotal());
				setTxtremarks(getTxtremarks());
				
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		/*else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			cashPaymentBean=ClsVehicleStockCheckDAO.getViewDetails(session,getTxtcashpaydocno());
			
			setJqxCashPaymentDate(cashPaymentBean.getJqxCashPaymentDate());
			setTxtrefno(cashPaymentBean.getTxtrefno());
			
			setTxtfromdocno(cashPaymentBean.getTxtfromdocno());
			setTxtfromaccid(cashPaymentBean.getTxtfromaccid());
			setTxtfromaccname(cashPaymentBean.getTxtfromaccname());
			setHidcmbfromcurrency(cashPaymentBean.getHidcmbfromcurrency());
			setTxtfromamount(cashPaymentBean.getTxtfromamount());
			setTxtfrombaseamount(cashPaymentBean.getTxtfrombaseamount());
			setTxtdescription(cashPaymentBean.getTxtdescription());
			
			setTxttodocno(cashPaymentBean.getTxttodocno());
			setTxttotranid(cashPaymentBean.getTxttotranid());
			setTxttotrno(cashPaymentBean.getTxttotrno());
			setHidcmbtotype(cashPaymentBean.getHidcmbtotype());
			setTxttoaccid(cashPaymentBean.getTxttoaccid());
			setTxttoaccname(cashPaymentBean.getTxttoaccname());
			setHidcmbtocurrency(cashPaymentBean.getHidcmbtocurrency());
			setTxttorate(cashPaymentBean.getTxttorate());
			setTxttoamount(cashPaymentBean.getTxttoamount());
			setTxttobaseamount(cashPaymentBean.getTxttobaseamount());
			setTxtapplyinvoiceamt(cashPaymentBean.getTxtapplyinvoiceamt());
			setTxtapplyinvoiceapply(cashPaymentBean.getTxtapplyinvoiceapply());
			setTxtapplyinvoicebalance((cashPaymentBean.getTxtapplyinvoicebalance()));
			
			setTxtdrtotal(cashPaymentBean.getTxtdrtotal());
			setTxtcrtotal(cashPaymentBean.getTxtdrtotal());
			setFormdetailcode(cashPaymentBean.getFormdetailcode());
			
			return "success";
		}*/
		return "fail";
    }

		public  JSONArray searchDetails(HttpSession session,String username,String docNo,String date){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= vehicleStockCheckDAO.vstcMainSearch(session, username, docNo, date);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}

}

