package com.dashboard.invoices.damages;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.invoices.lease.ClsLeaseInvoiceBean;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsDamageInvAction {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	private int invgridlength;
	private String mode;
	private String hidclient;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	
	
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String saveAction() throws ParseException, SQLException{
	//	System.out.println("Inside Action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ArrayList<String> invoicedoc= new ArrayList<>();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		ClsLeaseInvoiceBean bean=new ClsLeaseInvoiceBean();
	Connection conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	String sqlacno="select (select acno from gl_invmode where idno=10) damageacno,(select acno from gl_invmode where idno=21) exinsuracno";
	Statement stmt=conn.createStatement();
	ResultSet rsacno=stmt.executeQuery(sqlacno);
	int damageacno=0,exinsuracno=0;
	while(rsacno.next()){
		damageacno=rsacno.getInt("damageacno");
		exinsuracno=rsacno.getInt("exinsuracno");
			}
	
	//stmt.close();
//	System.out.println("Mode:"+mode);
	if(mode.equalsIgnoreCase("A")){
	//	System.out.println("Inside Action Mode A");
		ArrayList<String> invoicearray= new ArrayList<>();
		ArrayList<String> newarray= new ArrayList<>();
		
	//	System.out.println("inside tarifsave");
		String[] invoice = null;
		java.sql.Date fromdate=null,todate=null;
		for(int i=0;i<getInvgridlength();i++){
			//ClsTarifBean tarifbean=new ClsTarifBean();
		//	System.out.println("request =========="+requestParams.get("testinvoice"+i)[0]);
			String temp=requestParams.get("testinvoice"+i)[0];
			
			invoicearray.add(temp);
			
		//	System.out.println("Check 1st Loop");
		}
		String tempratype="";
			for(int j=0;j <getInvgridlength();j++){
			//	System.out.println("INVLENGTH"+getInvgridlength());
				invoice=invoicearray.get(j).split("::");
				fromdate=ClsCommon.changetstmptoSqlDate(invoice[2]);
				todate=ClsCommon.changetstmptoSqlDate(invoice[3]);
				int agmtno=Integer.parseInt(invoice[0]);
				String qty="1";
				
				String note="";
				if(invoice[1].equalsIgnoreCase("RAG")){
					note="Damage Invoice for Rental Aggreement no "+agmtno;
					
				}
				if(invoice[1].equalsIgnoreCase("LAG")){
					note="Damage Invoice for Lease Aggreement no "+agmtno;
				}
				tempratype=invoice[1];
			newarray.add("10"+"::"+damageacno+"::"+note+"::"+qty+"::"+invoice[4]+"::"+invoice[4]);
		//	System.out.println("Check 2nd Loop");
		if(!invoice[10].equalsIgnoreCase("") && invoice[10]!=null && !invoice[10].equalsIgnoreCase("0")){
				newarray.add("21"+"::"+exinsuracno+"::"+note+"::"+qty+"::"+invoice[10]+"::"+invoice[10]);
				
			}
			
	 Date date1=new Date();
		String pattern = "dd.MM.yyyy";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);
		String date2 = formatter.format(date1);
		java.sql.Date dates=ClsCommon.changeStringtoSqlDate(date2);
		//System.out.println(dates);
		ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
		//System.out.println("Check"+dates+":"+invoice[0]+":"+getHidclient()+":"+fromdate+":"+todate+":");
	//	System.out.println("array======= "+newarray);
		
		String branchid=invoice[6];
		String currencyid=invoice[7];
		String userid=session.getAttribute("USERID").toString();
		String cldocno=invoice[5];
		String qty2="1";
		String docno=invoice[8];
		String acno=invoice[9];
		
		if(tempratype.equalsIgnoreCase("RPL") || tempratype.equalsIgnoreCase("NRM")){
			Statement stmtactualdata=conn.createStatement();
			String getactualdata="";
			if(tempratype.equalsIgnoreCase("RPL")){
			getactualdata="select rep.rtype,rep.rdocno,if(rep.rtype='RAG',ragmt.cldocno,lagmt.cldocno) cldocno,if(rep.rtype='RAG',ragmt.acno,lagmt.acno) acno,"
					+ "if(rep.rtype='RAG',ragmt.brhid,lagmt.brhid) brhid "+
					" from gl_vehreplace rep left join gl_ragmt ragmt on (rep.rdocno=ragmt.doc_no and rep.rtype='RAG') left join gl_lagmt lagmt on "+
					" (rep. rdocno=lagmt.doc_no and rep.rtype='LAG') where rep.doc_no="+invoice[0];	
			}
			else if(tempratype.equalsIgnoreCase("MOV")){
				getactualdata="";
			}
			
			ResultSet rsactualdata=stmtactualdata.executeQuery(getactualdata);
			while(rsactualdata.next()){
				tempratype=rsactualdata.getString("rtype");
				agmtno=rsactualdata.getInt("rdocno");
				cldocno=rsactualdata.getString("cldocno");
				acno=rsactualdata.getString("acno");
				branchid=rsactualdata.getString("brhid");
			}
		}
		
		int val=manualdao.insert(conn,newarray, tempratype, todate,cldocno,agmtno,note,note, fromdate, todate, branchid,userid,
				currencyid, mode,acno , "IND###"+invoice[8]+"", "INV",qty2);
					 if(val>0){
						 Statement stmtinsp=conn.createStatement();
						 String strinsp="update gl_vinspm set invno="+val+",invtype='INV' where doc_no="+docno+" and status<>7 and brhid="+getCmbbranch();
						 int inspval=stmtinsp.executeUpdate(strinsp);
						 if(inspval<=0){
							 conn.close();
							 return "fail";
						 }
						 Statement stmtlog =conn.createStatement();
						 String strlog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values"+
				" ("+val+",'"+branchid+"','BIDA',now(),'"+session.getAttribute("USERID").toString()+"','A')";
						 int logval=stmtlog.executeUpdate(strlog);
						 if(logval>0){
							 ResultSet rsinvdoc=stmt.executeQuery("select voc_no from gl_invm where doc_no="+val+"");
							if(rsinvdoc.next()){
								invoicedoc.add(rsinvdoc.getString("voc_no"));
							}
						 conn.commit();
						 setDetail("Invoices");
						setDetailname("Damages");
						 setMsg("Successfully Saved");
						 stmtlog.close();
						 conn.close();
						 }
						 
	}
					 else{
						 setDetail("Invoices");
							setDetailname("Damages");
						 setMsg("Not Saved");
						 
						 conn.close();
						 return "fail";
					 }
					 newarray=new ArrayList<>();
			}
		}
		if(invoicedoc.size()==1){
		setMsg("Inv No "+invoicedoc.get(0)+" Successfully Generated");
	}
	else if(invoicedoc.size()>1){
		setMsg("Inv From "+invoicedoc.get(0)+" To "+invoicedoc.get(invoicedoc.size()-1)+" Successfully Generated");
	}
	return "success";
}

}
