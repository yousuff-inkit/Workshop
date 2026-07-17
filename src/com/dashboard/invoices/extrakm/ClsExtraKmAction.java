package com.dashboard.invoices.extrakm;

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
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsExtraKmAction {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

ClsExtraKmDAO extrakmdao=new ClsExtraKmDAO();
private int invgridlength;
private String mode;
private String hidclient;
private String msg;
private String detail;
private String detailname;
private String chkkm;
private String chkfuel;
private String hidchkkm;
private String hidchkfuel;
private String chkexkm;
private String chkexfuel;
private String hidchkexkm;
private String hidchkexfuel;
private String hidchkall;
private String chkall;
public ClsExtraKmDAO getExtrakmdao() {
	return extrakmdao;
}
public void setExtrakmdao(ClsExtraKmDAO extrakmdao) {
	this.extrakmdao = extrakmdao;
}
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
public String getChkkm() {
	return chkkm;
}
public void setChkkm(String chkkm) {
	this.chkkm = chkkm;
}
public String getChkfuel() {
	return chkfuel;
}
public void setChkfuel(String chkfuel) {
	this.chkfuel = chkfuel;
}
public String getHidchkkm() {
	return hidchkkm;
}
public void setHidchkkm(String hidchkkm) {
	this.hidchkkm = hidchkkm;
}
public String getHidchkfuel() {
	return hidchkfuel;
}
public void setHidchkfuel(String hidchkfuel) {
	this.hidchkfuel = hidchkfuel;
}
public String getChkexkm() {
	return chkexkm;
}
public void setChkexkm(String chkexkm) {
	this.chkexkm = chkexkm;
}
public String getChkexfuel() {
	return chkexfuel;
}
public void setChkexfuel(String chkexfuel) {
	this.chkexfuel = chkexfuel;
}
public String getHidchkexkm() {
	return hidchkexkm;
}
public void setHidchkexkm(String hidchkexkm) {
	this.hidchkexkm = hidchkexkm;
}
public String getHidchkexfuel() {
	return hidchkexfuel;
}
public void setHidchkexfuel(String hidchkexfuel) {
	this.hidchkexfuel = hidchkexfuel;
}
public String getHidchkall() {
	return hidchkall;
}
public void setHidchkall(String hidchkall) {
	this.hidchkall = hidchkall;
}
public String getChkall() {
	return chkall;
}
public void setChkall(String chkall) {
	this.chkall = chkall;
}


public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		String stracno="";
		//System.out.println("Inside Action");
		setHidchkkm(getHidchkkm()==null?"0":getHidchkkm());
		setHidchkfuel(getHidchkfuel()==null?"0":getHidchkfuel());
		setHidchkexfuel(getHidchkexfuel()==null?"0":getHidchkexfuel());
		setHidchkexkm(getHidchkexkm()==null?"0":getHidchkexkm());
		setHidchkall(getHidchkall()==null?"0":getHidchkall());
		ArrayList<String> invoicearray=new ArrayList<>();
		ArrayList<String> newarray=new ArrayList<>();
		ArrayList<String> kmarray=new ArrayList<>();
		ArrayList<String> fuelarray=new ArrayList<>();
		int exkmacno=0,fuelacno=0;
		String[] invoice;
		java.sql.Date fromdate=null,todate=null;
		stracno="select (select acno from gl_invmode where idno=4) exkmacno,(select acno from gl_invmode where idno=11) fuelacno";
		ResultSet rsacno=stmt.executeQuery(stracno);
		while(rsacno.next()){
			exkmacno=rsacno.getInt("exkmacno");
			fuelacno=rsacno.getInt("fuelacno");
		}
		for(int i=0;i<getInvgridlength();i++){
	
			String temp=requestParams.get("exkminvoice"+i)[0];
			
			invoicearray.add(temp);
			//System.out.println(temp);
//			System.out.println("Check 1st Loop");
		}
		ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
		if(getMode().equalsIgnoreCase("A")){
		
		for(int j=0;j <getInvgridlength();j++){
			conn.setAutoCommit(false);
			newarray=new ArrayList<>();
			invoice=invoicearray.get(j).split("::");
			
			fromdate=ClsCommon.changetstmptoSqlDate(invoice[2]);
			todate=ClsCommon.changetstmptoSqlDate(invoice[3]);
			int agmtno=Integer.parseInt(invoice[0]);
			String agmttype=invoice[1];
			double excesskm=Double.parseDouble(invoice[7]);
			double exkmrte=Double.parseDouble(invoice[8]);
			double exkmamt=Double.parseDouble(invoice[9]);
			double excessfuel=Double.parseDouble(invoice[10]);
			double fuelrate=Double.parseDouble(invoice[11]);
			double exfuelamt=Double.parseDouble(invoice[12]);
			String userid=session.getAttribute("USERID").toString();
			String cldocno=invoice[6];
			String qty2=ClsCommon.getMonthandDays(todate, fromdate, conn);
			String note=ClsCommon.changeSqltoString(fromdate) +" to "+ClsCommon.changeSqltoString(todate) +" for Rental Aggrement no "+agmtno;
			String branchid=invoice[13];
			String currencyid=invoice[14];
			String acno=invoice[4];

			//When Km is invoiced as Normal
			if(getHidchkexkm().equalsIgnoreCase("0") && getHidchkkm().equalsIgnoreCase("0")){
				if(exkmamt>0){
					newarray.add("4"+"::"+exkmacno+"::"+note+"::"+excesskm+"::"+exkmrte+"::"+exkmamt);
				}
				
			}
			
			//When Fuel is invoiced as normal
			if(getHidchkexfuel().equalsIgnoreCase("0") && getHidchkfuel().equalsIgnoreCase("0")){
				if(exfuelamt>0){
					newarray.add("11"+"::"+fuelacno+"::"+note+"::"+excessfuel+"::"+fuelrate+"::"+exfuelamt);
				}

			}
			
			if(getHidchkkm().equalsIgnoreCase("1") && getHidchkexkm().equalsIgnoreCase("0")){
				if(exkmamt>0){
					kmarray.add("4"+"::"+exkmacno+"::"+note+"::"+excesskm+"::"+exkmrte+"::"+exkmamt);
				}
			}
			if(getHidchkfuel().equalsIgnoreCase("1") && getHidchkexfuel().equalsIgnoreCase("0")){
				if(exfuelamt>0){
					fuelarray.add("11"+"::"+fuelacno+"::"+note+"::"+excessfuel+"::"+fuelrate+"::"+exfuelamt);
				}
			}
			
//			System.out.println("New Array Size:"+newarray.size());
//			System.out.println("km Array Size:"+kmarray.size());
//			System.out.println("Fuel Array Size:"+fuelarray.size());
			if(newarray.size()>0){
//				System.out.println("New Array");
				int val=manualdao.insert(conn, newarray, agmttype, todate,cldocno,  agmtno, note, note, fromdate, todate, branchid, userid, currencyid,"A",  acno, "INV###10", "INV", qty2);
				//System.out.println("+invoice No: "+val);
				if(val>0){
//					System.out.println("New Array Success");
					if(exkmamt>0 && getHidchkexkm().equalsIgnoreCase("0") && getHidchkkm().equalsIgnoreCase("0")){
//						System.out.println("Inside Normal Km Update");
						Statement stmtupdate=conn.createStatement();
						String strkmupdate="update gl_vmove mov set km_invno="+val+" where mov.status='IN' and mov.rdtype='"+agmttype+"' and mov.rdocno="+agmtno+" and mov.km_invno=0";
//						System.out.println(strkmupdate);
						int kmval=stmtupdate.executeUpdate(strkmupdate);
//						System.out.println("Kmval "+kmval);
						if(kmval<=0){
							setDetail("Invoices");
							setDetailname("Extra Km and Fuel");
							setMsg("Not Generated");
							return "fail";
						}
						
					}
//				System.out.println(exfuelamt+":::"+getHidchkexfuel());
				//	System.out.println(exfuelamt+":::"+getHidchkexfuel()+":::"+getChkfuel());
					if(exfuelamt>0 && getHidchkexfuel().equalsIgnoreCase("0") && getHidchkfuel().equalsIgnoreCase("0")){
//						System.out.println("Inside Normal Fuel Update");
						Statement stmtupdate=conn.createStatement();
						String strkmupdate="update gl_vmove mov set fuel_invno="+val+" where mov.status='IN' and mov.rdtype='"+agmttype+"' and mov.rdocno="+agmtno+" and mov.fuel_invno=0";
						int fuelval=stmtupdate.executeUpdate(strkmupdate);
						if(fuelval<=0){
//							System.out.println("Normal Fuel Update Error");
							setDetail("Invoices");
							setDetailname("Extra Km and Fuel");
							setMsg("Not Generated");
							return "fail";
						}
					}	
			}
			}
//			System.out.println("Outside NewArray");
				if(kmarray.size()>0){
//					System.out.println("Inside Km ");
					int kmval=manualdao.insert(conn, kmarray, agmttype, todate,cldocno,  agmtno, note, note, fromdate, todate, branchid, userid, currencyid,"A",  acno, "INV###10", "INV", qty2);
//					System.out.println("Kmval: "+kmval);
					if(kmval>0){
						if(exkmamt>0 && getHidchkkm().equalsIgnoreCase("1") && getHidchkexkm().equalsIgnoreCase("0")){
//							System.out.println("Inside Saperate Km Update");
							Statement stmtupdate=conn.createStatement();
							String strkmupdate="update gl_vmove mov set km_invno="+kmval+" where mov.status='IN' and mov.rdtype='"+agmttype+"' and mov.rdocno="+agmtno+" and mov.km_invno=0";
							int kmvalue=stmtupdate.executeUpdate(strkmupdate);
							if(kmvalue<=0){
//								System.out.println("Km Update Error");
								setDetail("Invoices");
								setDetailname("Extra Km and Fuel");
								setMsg("Not Generated");
								return "fail";
							}
							
						}
					}
				}
				
				if(fuelarray.size()>0){
//					System.out.println("Insdie Fuel");
					int fuelval=manualdao.insert(conn, fuelarray, agmttype, todate,cldocno,  agmtno, note, note, fromdate, todate, branchid, userid, currencyid,"A",  acno, "INV###10", "INV", qty2);
//					System.out.println("FuelVal: "+fuelval);
					if(fuelval>0){
						if(exfuelamt>0 && getHidchkfuel().equalsIgnoreCase("1") && getHidchkexfuel().equalsIgnoreCase("0")){
							try{
//							System.out.println("Inside Saperate Fuel Update");
							Statement stmtupdatefuel=conn.createStatement();
							String strfuelupdate="update gl_vmove mov set fuel_invno="+fuelval+" where mov.status='IN' and mov.rdtype='"+agmttype+"' and mov.rdocno="+agmtno+" and mov.fuel_invno=0";
//							System.out.println(strfuelupdate);
							int fuelvalues=stmtupdatefuel.executeUpdate(strfuelupdate);
//							System.out.println("fuel Values: "+fuelvalues);
							if(fuelvalues<=0){
//								System.out.println("Fuel Update error");
								setDetail("Invoices");
								setDetailname("Extra Km and Fuel");
								setMsg("Not Generated");
								return "fail";
							}
							}
							catch(Exception e){
								e.printStackTrace();
							}
						}
					}//End of fuelval
				}//End Fuel array if

				conn.commit();
	
			
			
	}//End of For Loop
		setDetail("Invoices");
		setDetailname("Extra Km and Fuel");
		setMsg("Successfully Generated");
		return "success";
	}//End of mode A
	}//End of Try block
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
return "fail";
	}
}
