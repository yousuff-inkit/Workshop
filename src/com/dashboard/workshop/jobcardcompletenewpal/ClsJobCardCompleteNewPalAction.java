package com.dashboard.workshop.jobcardcompletenewpal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
import com.connection.ClsConnection;


public class ClsJobCardCompleteNewPalAction {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection clsConnection=new ClsConnection();
	ClsJobCardCompleteNewPalDAO jobdao=new ClsJobCardCompleteNewPalDAO();
	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String strlabourarray;
	private String strpartsarray;
	private String strextraarray;
	private String estdocno,docno;
	private String brhid;
	private String lblcompname,lblcompaddress,lblprintname,lblbranch,lbllocation,lblcomptel,lblcompfax;
	private String lbldate,lblinvno,lblrefno,lblclient,lbladdress,lblmobile,lblemail,lblvehicle,lblchassis;
	private String lblcheckedby,lblrecievedby,lblfinaldate;
	private String lbltotal,lbltax,lblnetamount,lblamountwords,lblroundoff,lblprintpath,url;  
	public String getLblprintpath() {
		return lblprintpath;
	}

	public void setLblprintpath(String lblprintpath) {
		this.lblprintpath = lblprintpath;
	}


	private String lblcomptrn,lblclienttrn;
	private String claimno,lpono,lpoamount;
	
	
	public String getLblroundoff() {
		return lblroundoff;
	}

	public void setLblroundoff(String lblroundoff) {
		this.lblroundoff = lblroundoff;
	}

	public String getClaimno() {
		return claimno;
	}

	public void setClaimno(String claimno) {
		this.claimno = claimno;
	}

	public String getLpono() {
		return lpono;
	}

	public void setLpono(String lpono) {
		this.lpono = lpono;
	}

	public String getLpoamount() {
		return lpoamount;
	}

	public void setLpoamount(String lpoamount) {
		this.lpoamount = lpoamount;
	}

	public String getStrextraarray() {
		return strextraarray;
	}

	public void setStrextraarray(String strextraarray) {
		this.strextraarray = strextraarray;
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

	public String getBrhid() {
		return brhid;
	}

	public void setBrhid(String brhid) {
		this.brhid = brhid;
	}

	public String getEstdocno() {
		return estdocno;
	}

	public void setEstdocno(String estdocno) {
		this.estdocno = estdocno;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
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

	

	public String getStrlabourarray() {
		return strlabourarray;
	}

	public void setStrlabourarray(String strlabourarray) {
		this.strlabourarray = strlabourarray;
	}

	public String getStrpartsarray() {
		return strpartsarray;
	}

	public void setStrpartsarray(String strpartsarray) {
		this.strpartsarray = strpartsarray;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		ArrayList<String> labourarray=new ArrayList<>();
		ArrayList<String> partsarray=new ArrayList<>();
		ArrayList<String> extraarray=new ArrayList<>();
		if(!getStrpartsarray().equalsIgnoreCase("")){
			String temppartsarray[]=getStrpartsarray().split(",");
			for(int i=0;i<temppartsarray.length;i++){
				partsarray.add(temppartsarray[i]);
			}
		}
		if(!getStrlabourarray().equalsIgnoreCase("")){
			String templabourarray[]=getStrlabourarray().split(",");
			for(int i=0;i<templabourarray.length;i++){
				labourarray.add(templabourarray[i]);
			}
		}
		if(!getStrextraarray().equalsIgnoreCase("")){
			String tempextraarray[]=getStrextraarray().split(",");
			for(int i=0;i<tempextraarray.length;i++){
				extraarray.add(tempextraarray[i]);
			}
		}
		String mode=getMode();
		if(mode.equalsIgnoreCase("A")){
			int val=jobdao.insert(getEstdocno(),getDocno(),getBrhid(),labourarray,partsarray,
					extraarray,session,request,mode,getLpono(),getClaimno(),getLpoamount());
			if(val>0){
				setDetail("Workshop");
				setDetailname("Job Card Complete");
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Workshop");
				setDetailname("Job Card Complete");
				setMsg("Not Saved");
				return "fail";
			}

		}
		return "fail";
	}
	
	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String printAction() throws ParseException, SQLException,Exception{
		
		 try{
			 //System.out.println("Inside Print Action Pal");
			 ClsJobCardCompleteNewPalBean bean=new ClsJobCardCompleteNewPalBean();
			 HttpServletRequest request=ServletActionContext.getRequest();
			 HttpSession session=request.getSession();
			 String doc=request.getParameter("docno");
			 String jobcarddocno = request.getParameter("jobcarddocno"); 
			 bean=jobdao.printDetails(doc,request);
			 setLblprintpath(bean.getLblprintpath());
			// System.out.println("print path--->>>"+bean.getLblprintpath());   
			 
			 String printpath=objcommon.getBIBPrintPath("BWJC");
			 //System.out.println("====="+printpath);
			 if(printpath==null || printpath.equalsIgnoreCase("")){
				 printpath="proformaPrintPal.jsp";
			 }
			 setUrl(printpath);
			 setLblrefno(bean.getLblrefno());
			 setLbldate(bean.getLbldate());
			 setLblinvno(bean.getLblinvno());
			 setLblclient(bean.getLblclient());
			 setLbladdress(bean.getLbladdress());
			 setLblemail(bean.getLblemail());
			 setLblmobile(bean.getLblmobile());
			 setLblvehicle(bean.getLblvehicle());
			 setLblbranch(bean.getLblbranch());
			 setLblprintname("Proforma Invoice");
			 setLblcompaddress(bean.getLblcompaddress());
			 setLblcompname(bean.getLblcompname());
			 setLblcomptel(bean.getLblcomptel());
			 setLblcompfax(bean.getLblcompfax());
			 setLbltotal(bean.getLbltotal());
			 setLbltax(bean.getLbltax());
			 setLblnetamount(bean.getLblnetamount());
			 setLblroundoff(bean.getLblroundoff());
			 setLblamountwords(bean.getLblamountwords());
			 setLblcheckedby(bean.getLblcheckedby());
			 setLblfinaldate(bean.getLblfinaldate());
			 setLblclienttrn(bean.getLblclienttrn());
			 setLblcomptrn(bean.getLblcomptrn());
			 
			 if(getUrl().contains(".jrxml")==true)
			   {
				    //System.out.println("inside jrxml");
				    HttpServletResponse response = ServletActionContext.getResponse();
				    Connection conn=clsConnection.getMyConnection();
					String team21detailsql="select type,desc1,format(amount,2) amount,qty,rate from(select  qty, rate,'Services' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount from ("+
	 						" select @i:=0 count,lab.strjobdesc description,round(lab.invoiceamt,2) amount,est.voc_no,round(lab.hrs,2) qty, round(lab.rate,2) rate from ws_jobcard card left join ws_estm est on "+
	 						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
	 						" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+doc+"  and card.status=3 and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1  and upper(lab.strjobtype)!='SUBLET'   union all  "+
	 						" select @i:=0 count,extra.description,round(extra.amount,2) amount,est.voc_no,'' ,''  from ws_jobcard card left join ws_estm est on "+
	 						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_jccextra extra "+
	 						" on card.doc_no=extra.jobcarddocno where card.doc_no="+doc+" and card.status=3  and coalesce(extra.jobcarddocno,0)<>0 ) a union all "+
	 						" select  qty, rate,'Sublet' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount from ( select @i:=0 count,lab.strjobdesc description,round(lab.invoiceamt,2) amount,est.voc_no,round(lab.hrs,2) qty, round(lab.rate,2) rate from ws_jobcard card left join ws_estm est on  (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m  on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+doc+"  and card.status=3 and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1 and upper(lab.strjobtype)='SUBLET') a  union all "+
	 						" select qty,rate,'Parts' type,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount from ("+
	 						" select @j:=0 count,if(spare.qty=0,'',round(spare.qty,0)) qty,if(spare.qty=0,'',round(spare.customeramt/spare.qty,2)) rate,if(spare.description='',m.productname,spare.description) description,round(spare.customeramt,2) amount,est.voc_no from ws_jccspare spare left join ws_jobcard card on spare.jobcarddocno=card.doc_no left join "+
	 					" ws_estm est on (card.reftype='EST' and card.refno=est.doc_no)  left join my_main m on m.psrno=spare.psrno "+
	 					" where card.doc_no="+doc+"  and card.status=3 and spare.chkcomplete=1)a)b";  
					//System.out.println("=========== "+team21detailsql);
					

					String liwadetailsql="select type,desc1,round(amount,2) amount,qty,rate,discount,vatamount,vatpercent,netamount from(select  qty, rate,'Services' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount,discount,vatpercent,vatamount,netamount from ("+
	 						" select @i:=0 count,lab.strjobdesc description,round(lab.hrs*lab.rate,2) amount,est.voc_no,round(lab.hrs,2) qty, round(lab.rate,2) rate,round(coalesce(lab.jobdiscount+lab.distservicediscount,0),2) discount,round(lab.jobvatamount,2) vatamount,round(coalesce(lab.jobvatpercent,0),2) vatpercent,round(lab.jobnetamount,2) netamount from ws_jobcard card left join ws_estm est on "+
	 						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
	 						" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+doc+"   and card.status=3 and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1 and upper(coalesce(lab.strjobtype,''))!='SUBLET') a union all "+
	 						" select  qty, rate,'Sublet' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount,discount,vatpercent,vatamount,netamount from ( select @i:=0 count,lab.strjobdesc description,round((lab.invoiceamt+lab.jobdiscount+lab.distservicediscount),2) amount,round(coalesce(lab.jobdiscount+lab.distservicediscount,0),2) discount,round(lab.jobvatamount,2) vatamount,round(coalesce(lab.jobvatpercent,0),2) vatpercent,round(lab.jobnetamount,2) netamount,est.voc_no,round(lab.hrs,2) qty, round(lab.rate,2) rate from ws_jobcard card left join ws_estm est on  (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m  on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+doc+"  and card.status=3 and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1 and upper(coalesce(lab.strjobtype,''))='SUBLET' ) a  union all "+
	 						 " select qty,rate,'Parts' type,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount,discount,vatpercent,vatamount,netamount from ("+
							 " select @j:=0 count,if(s.qty=0,'',round(s.qty,2)) qty,if(s.rate=0,'',round(s.rate,2)) rate, s.description,if(s.sptotal+spdiscount=0,'',round(s.qty*s.rate,2)) amount ,  if(s.spdiscount+s.distsparediscount=0,'',round(s.spdiscount+s.distsparediscount,2)) discount ,if(s.spvatamount=0,'',round(s.spvatamount,2))  vatamount, if(s.spvatpercent=0,'',round(s.spvatpercent,2))  vatpercent,if(s.spnetamount=0,'',round(s.spnetamount,2))  netamount, m.voc_no " +
							" from  ws_jobcard card left join ws_estm m on  (card.reftype='EST' and card.refno=m.doc_no) left join ws_jccspare sp on m.doc_no=sp.estdocno left join ws_estspare s on s.rowno=sp.detdocno  left join ws_estmadd d on m.doc_no=d.estdocno  where   card.doc_no="+doc+" and (s.description!='null' and s.description is not null) and sp.lumsumstatus=0 union all"+
							 " select @j:=0 count,if(sp.qty=0,'',round(sp.qty,2)) qty,if(sp.esttotal=0,'',round(sp.esttotal,2)) rate, sp.description,"+
							" if(sp.esttotal=0,'',round(esttotal,2)) amount ,  if(sp.esttotal-sp.customeramt>0,round(sp.esttotal-sp.customeramt,2),'') discount ,"+
							" if(sp.customeramt=0,'',round(sp.customeramt*0.05,2))  vatamount,"+
							" if(sp.customeramt=0,'',5)  vatpercent,if(sp.customeramt=0,'',round(sp.customeramt*1.05,2))  netamount, m.voc_no  from  ws_jobcard card"+
							" left join ws_estm m on  (card.reftype='EST' and card.refno=m.doc_no) left join ws_jccspare sp on m.doc_no=sp.estdocno"+
							" left join ws_estmadd d on m.doc_no=d.estdocno  where card.doc_no="+doc+" and sp.lumsumstatus>0)a)b";
					//System.out.println("liwadetailsql=========== "+liwadetailsql);
					
					Statement stmt = conn.createStatement();
					String addition="";
					int taxconfig=0,vat_per=0;
					String straddition="select coalesce((select vat_per from gl_taxdetail where curdate() between fromdate and todate and vat_per!=0),0) vat_per,(select method from gl_config where field_nme='tax') taxconfig,(select group_concat(distinct t.addition) addition from ws_invm m left join ws_invcalctemp t on m.doc_no=t.invno where m.doc_no="+doc+") addition ";
		 			 //System.out.println(addition+"==="+straddition);
		 					ResultSet rsadd=stmt.executeQuery(straddition);
		 					while(rsadd.next()){
		 						addition=rsadd.getString("addition");
		 						taxconfig=rsadd.getInt("taxconfig");
		 						vat_per=rsadd.getInt("vat_per");
		 						if(vat_per<=0){
		 						    taxconfig=0;
		 						}
		 					}
					
		 					Double grossvat=0.0;
			 				Double grossnovat=0.0;
							/*String liwagross ="select sum(grossvat) grossvat,sum(grossnovat) grossnovat from( select if(vatpercent=5,sum(amount)-sum(discount),0) grossvat,if(vatpercent=0 or vatpercent='',sum(amount)-sum(discount),0) grossnovat from(select type,desc1,format(amount,2) amount,qty,rate,discount,vatamount,vatpercent,netamount from(select  qty, rate,'Services' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount,discount,vatpercent,vatamount,netamount from ("+
			 						" select @i:=0 count,lab.strjobdesc description,round((lab.invoiceamt+lab.jobdiscount),2) amount,est.voc_no,round(lab.hrs,2) qty, round(lab.rate,2) rate,round(coalesce(lab.jobdiscount,0),2) discount,round(lab.jobvatamount,2) vatamount,round(coalesce(lab.jobvatpercent,0),2) vatpercent,round(lab.jobnetamount,2) netamount from ws_jobcard card left join ws_estm est on "+
			 						" (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m "+
			 						" on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+doc+"   and card.status=3 and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1 and upper(lab.strjobtype)!='SUBLET') a union all "+
			 						" select  qty, rate,'Sublet' type,convert(concat(a.voc_no,'-S',@i:=@i+1),char(25)) srno,a.description desc1,a.amount,discount,vatpercent,vatamount,netamount from ( select @i:=0 count,lab.strjobdesc description,round((lab.invoiceamt+lab.jobdiscount),2) amount,round(coalesce(lab.jobdiscount,0),2) discount,round(lab.jobvatamount,2) vatamount,round(coalesce(lab.jobvatpercent,0),2) vatpercent,round(lab.jobnetamount,2) netamount,est.voc_no,round(lab.hrs,2) qty, round(lab.rate,2) rate from ws_jobcard card left join ws_estm est on  (card.reftype='EST' and card.refno=est.doc_no) left join ws_estlabour lab on est.doc_no=lab.rdocno left join ws_jobmaster m  on lab.jobid=m.doc_no left join ws_jobtype t on m.jobid=t.doc_no where card.doc_no="+doc+"  and card.status=3 and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1 and upper(lab.strjobtype)='SUBLET' ) a  union all "+
			 						 " select qty,rate,'Parts' type,convert(concat(a.voc_no,'-P',@j:=@j+1),char(25)) serialno,a.description,a.amount,discount,vatpercent,vatamount,netamount from ("+
									 " select @j:=0 count,if(s.qty=0,'',round(s.qty,2)) qty,if(s.rate=0,'',format(s.rate,2)) rate, s.description,if(s.sptotal+spdiscount=0,'',round((s.sptotal+spdiscount),2)) amount ,  if(s.spdiscount=0,'',format(s.spdiscount,2)) discount ,if(s.spvatamount=0,'',format(s.spvatamount,2))  vatamount, if(s.spvatpercent=0,'',round(s.spvatpercent,2))  vatpercent,if(s.spnetamount=0,'',format(s.spnetamount,2))  netamount, m.voc_no " +
									" from  ws_jobcard card left join ws_estm m on  (card.reftype='EST' and card.refno=m.doc_no) left join ws_estspare s on s.rdocno=m.doc_no  left join ws_estmadd d on m.doc_no=d.estdocno  where   card.doc_no="+doc+" and (s.description!='null' and s.description is not null) order by s.srno )a)b)c group by vatpercent)d ";*/
			 				String liwagross="select sum(grossvat) grossvat,sum(grossnonvat) grossnonvat from ("+
							" select if(coalesce(t.taxable,1)=1 and "+taxconfig+"=1,lab.invoiceamt,0) grossvat,if(coalesce(t.taxable,1)=0 or "+taxconfig+"=0,lab.invoiceamt,0) grossnonvat from ws_jobcard card"+
							" left join ws_estm est on (card.reftype='EST' and card.refno=est.doc_no)"+
							" left join ws_estlabour lab on (est.doc_no=lab.rdocno and lab.confirmed=1 and lab.approved=1 and lab.chkcomplete=1)"+
							" left join ws_jobtype t on lab.jobid=t.doc_no where card.doc_no="+doc+" and card.status=3 union all"+
							" select if("+taxconfig+"=1,coalesce(sp.customeramt,0),0) grossvat,if("+taxconfig+"=0,coalesce(sp.customeramt,0),0) grossnonvat from ws_jobcard card"+
							" left join ws_estm est on (card.reftype='EST' and card.refno=est.doc_no)"+
							" left join ws_jccspare sp on (est.doc_no=sp.estdocno and sp.chkcomplete=1)"+
							" where card.doc_no="+doc+" and card.status=3) base";
			 				System.out.println("liwagross=========== "+liwagross);
							
					ResultSet rs6=stmt.executeQuery(liwagross); 
		    	     while(rs6.next()){
		    	    	 grossvat=rs6.getDouble("grossvat");
		    	    	 grossnovat=rs6.getDouble("grossnonvat");
		    	         
		    	     }
		    	    
		    	
		    	     
				
		 			Double sumofservice=0.0,sumofparts=0.0,sumofsublet=0.0,sumofconsumable=0.0,dis=0.0;
		 			String strservice1="select coalesce(round(sum(coalesce(lab.invoiceamt,0)),2),0.0) servicetot from ws_jobcard card inner join ws_estm est on (card.reftype='EST' and card.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno  where card.doc_no="+doc+"  and lab.chkcomplete=1 and upper(coalesce(lab.strjobtype,''))!='SUBLET'";
		 			//System.out.println("strservice1"+"==="+strservice1);
		 			ResultSet rsser1=stmt.executeQuery(strservice1);
		 			while(rsser1.next()){
		 				sumofservice=rsser1.getDouble("servicetot");
		 			}
		 			//second change
		 			Double sumofservice2=0.0,sumofparts2=0.0,sumofsublet2=0.0,sumofconsumable2=0.0,dis2=0.0;
		 			String strservice12="select coalesce(round(sum(coalesce(lab.total,0)),2),0.0) servicetot from ws_jobcard card inner join ws_estm est on (card.reftype='EST' and card.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno  where card.doc_no="+doc+"  and lab.chkcomplete=1 and upper(coalesce(lab.strjobtype,''))!='SUBLET'";
		 			//System.out.println("strservice1"+"==="+strservice1);
		 			ResultSet rsser12=stmt.executeQuery(strservice12);
		 			while(rsser12.next()){
		 				sumofservice2=rsser12.getDouble("servicetot");
		 			}
		 			
		 			String strparts1="select coalesce(round(sum(coalesce(customeramt,0)),2),0.0) partstot from ws_jccspare where jobcarddocno="+doc+"  and chkcomplete=1 and upper(description)!='CONSUMABLES'";
		 			//System.out.println("strparts1"+"==="+strparts1);  
		 			ResultSet rsparts1=stmt.executeQuery(strparts1);
		 			while(rsparts1.next()){
		 				sumofparts=rsparts1.getDouble("partstot");  
		 			}
		 			//second change
		 			String strparts12="select coalesce(round(sum(coalesce(esttotal,0)),2),0.0) partstot from ws_jccspare where jobcarddocno="+doc+"  and chkcomplete=1 and upper(description)!='CONSUMABLES'";
		 			//System.out.println("strparts1"+"==="+strparts1);  
		 			ResultSet rsparts12=stmt.executeQuery(strparts12);
		 			while(rsparts12.next()){
		 				sumofparts2=rsparts12.getDouble("partstot");  
		 			}
		 			
		 			String strservice2="select coalesce(round(sum(coalesce(lab.invoiceamt,0)),2),0.0) servicetot from ws_jobcard card inner join ws_estm est on (card.reftype='EST' and card.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno  where card.doc_no="+doc+" and lab.chkcomplete=1 and upper(coalesce(lab.strjobtype,''))='SUBLET'";
		 			//System.out.println("strservice2"+"==="+strservice2);
		 			ResultSet rsser2=stmt.executeQuery(strservice2);
		 			while(rsser2.next()){
		 				sumofsublet=rsser2.getDouble("servicetot");  
		 			}
		 			String strservice22="select coalesce(round(sum(coalesce(lab.total,0)),2),0.0) servicetot from ws_jobcard card inner join ws_estm est on (card.reftype='EST' and card.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno  where card.doc_no="+doc+" and lab.chkcomplete=1 and upper(coalesce(lab.strjobtype,''))='SUBLET'";
		 			//System.out.println("strservice2"+"==="+strservice2);
		 			ResultSet rsser22=stmt.executeQuery(strservice22);
		 			while(rsser22.next()){
		 				sumofsublet2=rsser22.getDouble("servicetot");  
		 			}
		 			String strparts2="select coalesce(round(sum(coalesce(customeramt,0)),2),0.0) partstot from ws_jccspare where jobcarddocno="+doc+"  and chkcomplete=1 and upper(description)='CONSUMABLES'";  
		 			//System.out.println("strparts2"+"==="+strparts2);  
		 			ResultSet rsparts2=stmt.executeQuery(strparts2);
		 			while(rsparts2.next()){
		 				sumofconsumable=rsparts2.getDouble("partstot");      
		 			}
		 			
		 			String strparts22="select coalesce(round(sum(coalesce(customeramt,0)),2),0.0) partstot from ws_jccspare where jobcarddocno="+doc+"  and chkcomplete=1 and upper(description)='CONSUMABLES'";  
		 			//System.out.println("strparts2"+"==="+strparts2);  
		 			ResultSet rsparts22=stmt.executeQuery(strparts22);
		 			while(rsparts22.next()){
		 				sumofconsumable2=rsparts22.getDouble("partstot");      
		 			}
		 			
		 			// String strdiscount="select sparediscount+servicesdiscount+discount dis from ws_estm m left join ws_jobcard j on m.doc_no=j.refno where j.doc_no="+doc;  
		 			String strdiscount="select e1.dis+e.dis dis from (select coalesce(sum(sparediscount+servicesdiscount),0) dis from ws_estmadd m where jobcarddocno="+doc+") e1,(select coalesce(sparediscount+servicesdiscount+discount,0) dis from ws_estm m left join ws_jobcard j on m.doc_no=j.refno where j.doc_no="+doc+") e";
		 			//System.out.println(strdiscount);  
		 			ResultSet rsdis=stmt.executeQuery(strdiscount);
		 			while(rsdis.next()){
		 				dis=rsdis.getDouble("dis");      
		 			}
		 			String strdiscount2="select e1.dis+e.dis dis from (select coalesce(sum(sparediscount+servicesdiscount),0) dis from ws_estmadd m where jobcarddocno="+doc+") e1,(select coalesce(sparediscount+servicesdiscount+discount,0) dis from ws_estm m left join ws_jobcard j on m.doc_no=j.refno where j.doc_no="+doc+") e";
		 			ResultSet rsdis2=stmt.executeQuery(strdiscount2);
		 			while(rsdis2.next()){
		 				dis2=rsdis2.getDouble("dis");      
		 			}

				    param = new HashMap();
				    param.put("grossamounttax",grossvat);
		    	    param.put("grossamountnontax",grossnovat);
		    	    
		    	    //System.out.println(grossvat+" =========== "+grossnovat);
				    param.put("vehiclehissql","");
					param.put("docno", doc);
					param.put("puser", "");
					param.put("amountinwordspal", bean.getLblamountwords());  
					String imgpal =request.getSession().getServletContext().getRealPath(bean.getLblprintpath());  
			        imgpal = imgpal.replace("\\", "\\\\");
				    param.put("imgpath", imgpal);
				    
				    ClsAmountToWords objamount=new ClsAmountToWords();
					param.put("team21detailsql", team21detailsql);
					param.put("liwadetailsql",liwadetailsql);
					param.put("sumofservice", sumofservice);
					param.put("sumofservice2", sumofservice2);
					param.put("discount", dis);
					
					double disval = objcommon.Round(sumofparts+sumofservice+sumofconsumable+sumofsublet-dis,2) - objcommon.Round(sumofparts2+sumofservice2+sumofconsumable2+sumofsublet2,2);
					//System.out.println("disval="+disval);
					param.put("discount2",disval);
					param.put("sumofparts", sumofparts);
					param.put("sumofparts2", sumofparts2);
					param.put("totallumsum", sumofparts+sumofservice+sumofconsumable+sumofsublet);
					param.put("totallumsum2", sumofparts2+sumofservice2+sumofconsumable2+sumofsublet2);
					param.put("subtotal", objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)),2));
					param.put("subtotal2", objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)),2));
					
					String estprintpath=objcommon.getPrintPath("EST");
					System.out.println(estprintpath);
					if(estprintpath.contains("V3")){
					    if(taxconfig==1){
					        param.put("vatamt", objcommon.Round(((grossvat)*0.05),2));
	                        param.put("nettotal", objcommon.Round(((grossvat*1.05)+grossnovat),2));
	                        param.put("amountwords", objamount.convertAmountToWords(objcommon.Round((grossvat*1.05)+grossnovat,2)+""));
	                        param.put("amountinwords", objamount.convertAmountToWords(objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)*1.05),2)+""));
	                        param.put("nettot",objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)*1.05),2));
					    }
					    else{
					        param.put("vatamt", objcommon.Round((0),2));
	                        param.put("nettotal", objcommon.Round(((grossvat)+grossnovat),2));
	                        param.put("amountwords", objamount.convertAmountToWords(objcommon.Round((grossvat)+grossnovat,2)+""));
	                        param.put("amountinwords", objamount.convertAmountToWords(objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)),2)+""));
	                        param.put("nettot",objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)),2));
					    }
						
					}
					else{
						param.put("vatamt", objcommon.Round(((grossvat-dis)*0.05),2));
						//System.out.println("grossvat=="+grossvat+"==nogrossvat=="+grossnovat+"==discount=="+dis);
						param.put("nettot", objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)*1.05),2));
						param.put("nettotal", objcommon.Round(((grossvat*1.05)+grossnovat)-dis,2));
						param.put("amountinwords", objamount.convertAmountToWords(objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)*1.05),2)+""));
						param.put("amountwords", objamount.convertAmountToWords(objcommon.Round(((grossvat*1.05)+grossnovat)-dis,2)+""));
					}
					//System.out.println(objcommon.Round(((sumofparts+sumofservice+sumofconsumable+sumofsublet-dis)*1.05),2));
					
					param.put("sumofsublet", sumofsublet);
					param.put("sumofsublet2", sumofsublet2);
					param.put("sumofconsumable", sumofconsumable);
					
					
		    	     Double sumofserviceli=0.0,sumofpartsli=0.0,sumofsubletli=0.0, sumofconsumableli=0.0,totalli=0.00,totallumsumli=0.00,nettotalli=0.00;
		    		 Double partsli=0.0;
			 			Double vatamtli=0.00;
	                     Double consumablesli=0.0; 
	                     Double discountli=0.00;
		    	     String strsql5=" select sum(totallumsumli) totallumsumli, sum(vatamtli) vatamtli, sum(nettotalli) nettotalli,sum(discountli) discountli,sum(totalli) totalli  from (select sum(sptotal) totallumsumli,sum(spvatamount) vatamtli, sum(spnetamount) nettotalli, sum(spdiscount) discountli , sum(sptotal - spdiscount) totalli from ws_estspare where rdocno="+doc+" and addition in ("+addition+")  union all "
		    	    		 +" select sum(jobtotal) total, sum(jobvatamount) vatamt, sum(jobnetamount) nettotal, sum(jobdiscount) discount, sum(jobtotal - jobdiscount) total from ws_estlabour where rdocno="+doc+" and addition in ("+addition+")   ) a " ;	
		 			 //System.out.println("strsql5="+strsql5);
		    	     ResultSet rs5=stmt.executeQuery(strsql5);   
                     
		    	     
		    	     
                     ClsAmountToWords amtwords=new ClsAmountToWords();
                     String amountwordsli="";
		    	     while(rs5.next()){   
		    	    	 totallumsumli=rs5.getDouble("totallumsumli"); 
		    	    	 vatamtli=rs5.getDouble("vatamtli"); 
		    	    	nettotalli=rs5.getDouble("nettotalli");   
		    	    	 discountli=rs5.getDouble("discountli"); 
		    	    	// totalli=rs5.getDouble("totalli");  
		    	    	 totalli=totallumsumli-discountli;
		    	    	// System.out.println(nettotalli+"==net=="+discountli);  
		    	    	// nettotalli=vatamtli+totalli;

		    	     }

					
				   // System.out.println("bfore print "+getUrl()+"==="+bean.getLblprintpath());
				    JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
			    	JasperReport jasperReport = JasperCompileManager.compileReport(design);
			        generateReportPDF(response, param, jasperReport, conn);
			   }
		 }
		 catch(Exception e){
			 e.printStackTrace();
		 }
		 return "print";
	}


	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null;
	    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	      resp.reset();
	    resp.resetBuffer();
	    
	    resp.setContentType("application/pdf");
	    resp.setContentLength(bytes.length);
	    ServletOutputStream ouputStream = resp.getOutputStream();
	    ouputStream.write(bytes, 0, bytes.length);
	   
	    ouputStream.flush();
	    ouputStream.close();
	   
	         
	}		
	
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
