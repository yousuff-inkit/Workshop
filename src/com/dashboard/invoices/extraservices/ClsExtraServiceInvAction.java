package com.dashboard.invoices.extraservices;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Map;

import javassist.compiler.ast.Stmnt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsExtraServiceInvAction {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	private int invgridlength;
	private String mode;
	private String cmbbranch;
	private String periodupto;
	private String msg;
	private String detail;
	private String detailname;
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public String getPeriodupto() {
		return periodupto;
	}
	public void setPeriodupto(String periodupto) {
		this.periodupto = periodupto;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getDetailname() {
		return detailname;
	}
	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}
	
	public String saveAction() throws ParseException, SQLException{
//		System.out.println("Inside Action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsExtraServiceInvDAO exservicedao=new ClsExtraServiceInvDAO();
		Map<String, String[]> requestParams = request.getParameterMap();
		Connection conn=null;
		try{
		String splitacno[]=exservicedao.getInvmodeAcno().split("::");
		
		int accacno=0,extrainsuracno=0,otheracno=0;
		java.sql.Date docdate=null;
		ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
		accacno=Integer.parseInt(splitacno[0]);
		extrainsuracno=Integer.parseInt(splitacno[1]);
		otheracno=Integer.parseInt(splitacno[2]);
		Calendar now = Calendar.getInstance();
		docdate=ClsCommon.changeStringtoSqlDate(now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+"."+now.get(Calendar.YEAR));
		String mode=getMode();
		
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> invoicearray= new ArrayList<>();
			
			for(int i=0;i<getInvgridlength();i++){
				
				String temp=requestParams.get("testinvoice"+i)[0];
				
				invoicearray.add(temp);
				
				
			}
			int val=0;
			java.sql.Date invoicedate=null;
			for(int i=0;i<getInvgridlength();i++){
				ArrayList<String> newarray=new ArrayList<>();
				ArrayList<String> dataarray=new ArrayList<>();
				
				String arraysplit[]=invoicearray.get(i).split("::");
				int  docno=Integer.parseInt(arraysplit[0]);
				int agmtno=Integer.parseInt(arraysplit[1]);
				String agmttype=arraysplit[2];
				String cldocno=arraysplit[3];
				String acno=arraysplit[4];
				invoicedate=ClsCommon.changetstmptoSqlDate(arraysplit[5]);
//				System.out.println("Check Array Data:"+docno+"***"+agmtno+"***"+agmttype+"***"+cldocno+"****"+acno);
				dataarray=exservicedao.getServiceRequestData(docno,getCmbbranch());
				if(Double.parseDouble(dataarray.get(0))>0.0){
					newarray.add("2"+"::"+accacno+"::"+"Extra Service Invoice of Accessories of Agreement:"+agmtno+"::"+1+"::"+dataarray.get(0)+"::"+dataarray.get(0));
				}
				if(Double.parseDouble(dataarray.get(1))>0.0){
					newarray.add("7"+"::"+extrainsuracno+"::"+"Extra Service Invoice of Extra Insurances of Agreement:"+agmtno+"::"+1+"::"+dataarray.get(1)+"::"+dataarray.get(1));
				}
				if(Double.parseDouble(dataarray.get(2))>0.0){
					newarray.add("12"+"::"+otheracno+"::"+"Extra Service Invoice of Others of Agreement:"+agmtno+"::"+1+"::"+dataarray.get(2)+"::"+dataarray.get(2));
				}
				String note="";
				if(agmttype.equalsIgnoreCase("RAG")){
					note="Extra Service Invoice of Rental Agreement "+agmtno;
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					note="Extra Service Invoice of Lease Agreement "+agmtno;
				}
				
				 val=manualdao.insert(conn,newarray, agmttype, docdate,cldocno,agmtno,note,note, invoicedate, invoicedate, getCmbbranch(),
						session.getAttribute("USERID").toString(),session.getAttribute("CURRENCYID").toString(), mode,acno , "INV###7", "INV","1");
				if(val>0){
						int updateval=exservicedao.updateInvNo(conn,docno,val,getCmbbranch());
						if(updateval>0){
							conn.commit();
							setDetail("Invoices");
							setDetailname("Extra Services");
							setMsg("Successfully Saved");		
						}
						else{

							 setDetail("Invoices");
								setDetailname("Extra Services");
								 setMsg("Not Saved");
						}
					
				}
				else{

					 setDetail("Invoices");
						setDetailname("Extra Services");
						 setMsg("Not Saved");
				}

			}
			if(val>0){
				return "success";
			}
			else{
				return "fail";
			}
			
		}
		
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return "fail";
		}
	
}
