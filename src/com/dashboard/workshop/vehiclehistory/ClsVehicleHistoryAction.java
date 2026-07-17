package com.dashboard.workshop.vehiclehistory;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.dashboard.operations.ClsOperationsBean;
import com.dashboard.operations.ClsOperationsDAO;
import com.opensymphony.xwork2.ActionSupport;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsVehicleHistoryAction extends ActionSupport{
	
	ClsCommon objcommon=new ClsCommon();
	ClsVehicleHistoryDAO vehhistoryDAO= new ClsVehicleHistoryDAO();
	ClsVehicleHistoryBean vehhistoryBean;
	ClsConnection objconn=new ClsConnection();
	
	//Print
	private double grandtotal;
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblcashtotal;
	private String lblcardtotal;
	private String lblchequetotal;
	private String lblnetbalance;
	private String lblcustname,lblAddress,lblphone,lblemail,lblregno,lblchassis,lblbrand,lblmodel,lblyom;
	
private String url;
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getLblcustname() {
		return lblcustname;
	}
	public void setLblcustname(String lblcustname) {
		this.lblcustname = lblcustname;
	}
	public String getLblAddress() {
		return lblAddress;
	}
	public void setLblAddress(String lblAddress) {
		this.lblAddress = lblAddress;
	}
	public String getLblphone() {
		return lblphone;
	}
	public void setLblphone(String lblphone) {
		this.lblphone = lblphone;
	}
	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getLblregno() {
		return lblregno;
	}
	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}
	public String getLblchassis() {
		return lblchassis;
	}
	public void setLblchassis(String lblchassis) {
		this.lblchassis = lblchassis;
	}
	public String getLblbrand() {
		return lblbrand;
	}
	public void setLblbrand(String lblbrand) {
		this.lblbrand = lblbrand;
	}
	public String getLblmodel() {
		return lblmodel;
	}
	public void setLblmodel(String lblmodel) {
		this.lblmodel = lblmodel;
	}
	public String getLblyom() {
		return lblyom;
	}
	public void setLblyom(String lblyom) {
		this.lblyom = lblyom;
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getLblservicetax() {
		return lblservicetax;
	}
	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}
	public String getLblpan() {
		return lblpan;
	}
	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}
	public String getLblcashtotal() {
		return lblcashtotal;
	}
	public void setLblcashtotal(String lblcashtotal) {
		this.lblcashtotal = lblcashtotal;
	}
	public String getLblcardtotal() {
		return lblcardtotal;
	}
	public void setLblcardtotal(String lblcardtotal) {
		this.lblcardtotal = lblcardtotal;
	}
	public String getLblchequetotal() {
		return lblchequetotal;
	}
	public void setLblchequetotal(String lblchequetotal) {
		this.lblchequetotal = lblchequetotal;
	}
	public String getLblnetbalance() {
		return lblnetbalance;
	}
	public void setLblnetbalance(String lblnetbalance) {
		this.lblnetbalance = lblnetbalance;
	}
	
	
public double getGrandtotal() {
		return grandtotal;
	}
	public void setGrandtotal(double grandtotal) {
		this.grandtotal = grandtotal;
	}


private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String printActionRepairType() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();;
		String branch = request.getParameter("branchval");
		String regno = request.getParameter("regno");
		String pltid = request.getParameter("pltid");
		String frmDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		String dtype=request.getParameter("dtype").toString();
		ClsCommon ClsCommon=new ClsCommon();
		java.sql.Date sqlFromDate = null;
	    java.sql.Date sqlToDate = null;
	    String sqld="",sql="",sql1 = "",sql11 = "",sql2 = "",sql13 = "";
		String sqltest="";
	       
		if(!(frmDate.equalsIgnoreCase("undefined")) && !(frmDate.equalsIgnoreCase("")) && !(frmDate.equalsIgnoreCase("0"))){
			sqlFromDate = ClsCommon.changeStringtoSqlDate(frmDate);
	    }
	    if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
	    	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
	    }
	    

        if(sqlFromDate!=null){
			sqltest+=" and gate.date>='"+sqlFromDate+"'";
		}
		if(sqlFromDate!=null){
			sqltest+=" and gate.date<='"+sqlToDate+"'";
		}
        if(!pltid.equalsIgnoreCase("")){
        	sqltest+=" and gate.pltid='"+pltid+"'";
        }
       //setUrl(objcommon.getBIBPrintPath(dtype));

		vehhistoryBean=vehhistoryDAO.getPrint(request,branch,frmDate,toDate,regno,pltid,"");
	setLblcompname(vehhistoryBean.getLblcompname());
	setLblcompaddress(vehhistoryBean.getLblcompaddress());
	setLblprintname(vehhistoryBean.getLblprintname());
	setLblprintname1(vehhistoryBean.getLblprintname1());
	setLblcomptel(vehhistoryBean.getLblcomptel());
	setLblcompfax(vehhistoryBean.getLblcompfax());
	setLblbranch(vehhistoryBean.getLblbranch());
	setLbllocation(vehhistoryBean.getLbllocation());
	setLblcustname(vehhistoryBean.getLblcustname());
	setLblAddress(vehhistoryBean.getLblAddress());
	setLblphone(vehhistoryBean.getLblphone());;
	setLblemail(vehhistoryBean.getLblemail());
	setLblregno(vehhistoryBean.getLblregno());
	setLblchassis(vehhistoryBean.getLblchassis());
	setLblbrand(vehhistoryBean.getLblbrand());
	setLblmodel(vehhistoryBean.getLblmodel());
	setLblyom(vehhistoryBean.getLblyom());
	
	    
	    System.out.println("inside jrxml");
	    HttpServletResponse response = ServletActionContext.getResponse();
	    	 
		 param = new HashMap();
		 Connection conn = null;
		 
		 String reportFileName = "Vehicle History";
		 int vehval=0;	
		 String strSqldetail="";
		 ClsConnection conobj=new ClsConnection();
		 conn = conobj.getMyConnection();
		 Statement stmt=conn.createStatement();
		 try {      
			 /*  param.put("termsquery",gatebean.getTermQry());
	                
	         param.put("descQry",gatebean.getDescQry());
	         */
	       //  System.out.println("product++++++++++"+productQuery);
	         String imgpath=request.getSession().getServletContext().getRealPath("/icons/carfarehead1.jpg");
	        	imgpath=imgpath.replace("\\", "\\\\");    
	          param.put("imgpath", imgpath);
	          
	          
	          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	        	imgpath2=imgpath2.replace("\\", "\\\\");    
	          param.put("imgfooterpath", imgpath2);
	          
	          String vehsql="select coalesce(method,0) method from gl_config where field_nme='alicevehiclehistoryprint'";
		      ResultSet rs4 = stmt.executeQuery(vehsql);
		      while(rs4.next()){ 
				vehval=rs4.getInt("method");
			  }
	          if(vehval==1){
	        	   strSqldetail="select @i:=@i+1 srno,CONCAT('  ',a.date,'    JC No- ',a.jobcard,'    Milage-',a.kmin,' Service Advisor - ',a.sal_name) dtjobcardkmin,lbsrno,a.* from(select 1 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Complaint' type,coalesce(wsa.sal_name,'') sal_name,"
        		            + " concat(c.compname,' - ',d.desc1) desc1 ,0 qty , 0 amt, 0 amount,'' lbsrno from "
							 +" ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
							+" left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) "
							 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
							 +" inner join ws_gateinpassd d on gate.doc_no=d.rdocno "
							+" inner join gl_complaint c on c.doc_no=d.complaintid where regno="+regno+" "+sqltest+" "
							+" union all "
							+" select 2 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Parts' type,'' sal_name,if(coalesce(m.productname,'')='',sp.description,m.productname) desc1 ,qty , round(customeramt,2) amt,format(round(customeramt,2),2) amount,'' lbsrno "
							+" from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
							+" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
							+"inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno left join my_main m on m.psrno=sp.psrno where regno="+regno+" "+sqltest+" "
							+" union all "
							+" select 3 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Service' type,'' sal_name, concat(jt.type ,' - ', jm.desc1) desc1,hrs qty,"
							+ " round(invoiceamt,2) amt,format(round(invoiceamt,2),2) amount,lab.srno lbsrno from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
							 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno "
							 +" inner join ws_jobmaster jm on jm.doc_no=lab.jobid inner join ws_jobtype jt on jt.doc_no=jm.jobid where regno="+regno+" "+sqltest+" ) a ,(select @i:=0) as i  order by jobcard,onum";

	          }else{
	        	   strSqldetail="select @i:=@i+1 srno,CONCAT('  ',a.date,'    JC No- ',a.jobcard,'    Milage-',a.kmin,' Service Advisor - ',a.sal_name) dtjobcardkmin,lbsrno,a.* from(select 1 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Complaint' type,coalesce(wsa.sal_name,'') sal_name,"
        		            + " concat(c.compname,' - ',d.desc1) desc1 ,0 qty , 0 amt, 0 amount,'' lbsrno from "
							 +" ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
							+" left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) "
							 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
							 +" inner join ws_gateinpassd d on gate.doc_no=d.rdocno "
							+" inner join gl_complaint c on c.doc_no=d.complaintid where regno="+regno+" "+sqltest+" "
							+" union all "
							+" select 2 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Parts' type,'' sal_name, m.productname desc1 ,qty , round(customeramt,2) amt,format(round(customeramt,2),2) amount,'' lbsrno "
							+" from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
							+" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
							+"inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno inner join my_main m on m.psrno=sp.psrno where regno="+regno+" "+sqltest+" "
							+" union all "
							+" select 3 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Service' type,'' sal_name, concat(jt.type ,' - ', jm.desc1) desc1,hrs qty,"
							+ " round(invoiceamt,2) amt,format(round(invoiceamt,2),2) amount,lab.srno lbsrno from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
							 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno "
							 +" inner join ws_jobmaster jm on jm.doc_no=lab.jobid inner join ws_jobtype jt on jt.doc_no=jm.jobid where regno="+regno+" "+sqltest+" ) a ,(select @i:=0) as i  order by jobcard,onum";

	          }
	        String sparesql="select r.name,round(sum(a.spareamount),2) spamt,round(sum(a.labamount),2) labamt,round(sum(a.spareamount)+sum(a.labamount),2) net from(select repairtype,(round(customeramt,2)) spareamount,0 labamount from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno where regno='"+regno+"' and gate.date>='"+sqlFromDate+"' and gate.date<='"+sqlToDate+"' and gate.pltid='"+pltid+"' union all select repairtype,0,(round(invoiceamt,2)) labamount from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno where regno='"+regno+"' and gate.date>='"+sqlFromDate+"' and gate.date<='"+sqlToDate+"' and gate.pltid='"+pltid+"' ) a left join ws_gartype r on r.row_no=a.repairtype group by r.name";	
	             
	        System.out.println("grid qry---------------"+sparesql);
	          param.put("sparesql",sparesql);   
	          param.put("compname", vehhistoryBean.getLblcompname());
	          param.put("compaddress", vehhistoryBean.getLblcompaddress());
	          param.put("printname", vehhistoryBean.getLblprintname());
	          param.put("comptel", vehhistoryBean.getLblcomptel());
	          param.put("compfax", vehhistoryBean.getLblcompfax());
	          param.put("compbranch", vehhistoryBean.getLblbranch());
	          param.put("location", vehhistoryBean.getLbllocation());
	          param.put("name", vehhistoryBean.getLblcustname()); 
	          param.put("address", vehhistoryBean.getLblAddress());
	          param.put("mobile", vehhistoryBean.getLblphone());
	          param.put("email", vehhistoryBean.getLblemail());
	          param.put("regno", vehhistoryBean.getLblregno());
	          param.put("chasis", vehhistoryBean.getLblchassis());
	          param.put("brand", vehhistoryBean.getLblbrand());
	          param.put("model", vehhistoryBean.getLblmodel());
	          param.put("yom", vehhistoryBean.getLblyom());
	          param.put("vehiclehissql",strSqldetail);
	          param.put("partstot", vehhistoryBean.getPartstotal());
	          param.put("servicetot", vehhistoryBean.getServicetotal());
	          param.put("grandtotal", vehhistoryBean.getGrandtotal());
	
	          System.out.println("--"+getGrandtotal());
	          
	          
	       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
	     //   System.out.println("pathhhhhhhhhhhhhhhhhhh"+commDAO.getPrintPath(dtype));  
         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/workshop/vehiclehistory/vehicleHistoryRepairType.jrxml"));
    	 
         JasperReport jasperReport = JasperCompileManager.compileReport(design);
        generateReportPDF(response, param, jasperReport, conn);
  

} catch (Exception e) {

  e.printStackTrace();
  conn.close();
}
		 finally{
			 conn.close();
		 }
		 return "print";
	}
	public String printActionA() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();;
		String branch = request.getParameter("branchval");
		String regno = request.getParameter("regno");
		String pltid = request.getParameter("pltid");
		String frmDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		String cmbrepairtype=request.getParameter("cmbrepairtype")==null?"":request.getParameter("cmbrepairtype").toString();
		 String dtype=request.getParameter("dtype").toString();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
			String sqld="",sql="",sql1 = "",sql11 = "",sql2 = "",sql13 = "";
			String sqltest="";
	       
			if(!(frmDate.equalsIgnoreCase("undefined")) && !(frmDate.equalsIgnoreCase("")) && !(frmDate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(frmDate);
	        }
	        if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
	        }
		 
	        if(sqlFromDate!=null){
				sqltest+=" and gate.date>='"+sqlFromDate+"'";
			}
			if(sqlFromDate!=null){
				sqltest+=" and gate.date<='"+sqlToDate+"'";
			}
	        if(!pltid.equalsIgnoreCase("")){
	        	sqltest+=" and gate.pltid='"+pltid+"'";
	        }
	        String strgridcondition="";
	        if(!cmbrepairtype.equalsIgnoreCase("")){
	        	sqltest+=" and gate.repairtype="+cmbrepairtype;
	        	strgridcondition+=" and gate.repairtype="+cmbrepairtype;
	        }
	        setUrl(objcommon.getBIBPrintPath(dtype));
	
			vehhistoryBean=vehhistoryDAO.getPrint(request,branch,frmDate,toDate,regno,pltid,cmbrepairtype);
		setLblcompname(vehhistoryBean.getLblcompname());
		setLblcompaddress(vehhistoryBean.getLblcompaddress());
		setLblprintname(vehhistoryBean.getLblprintname());
		setLblprintname1(vehhistoryBean.getLblprintname1());
		setLblcomptel(vehhistoryBean.getLblcomptel());
		setLblcompfax(vehhistoryBean.getLblcompfax());
		setLblbranch(vehhistoryBean.getLblbranch());
		setLbllocation(vehhistoryBean.getLbllocation());
		setLblcustname(vehhistoryBean.getLblcustname());
		setLblAddress(vehhistoryBean.getLblAddress());
		setLblphone(vehhistoryBean.getLblphone());;
		setLblemail(vehhistoryBean.getLblemail());
		setLblregno(vehhistoryBean.getLblregno());
		setLblchassis(vehhistoryBean.getLblchassis());
		setLblbrand(vehhistoryBean.getLblbrand());
		setLblmodel(vehhistoryBean.getLblmodel());
		setLblyom(vehhistoryBean.getLblyom());
		
	
		
		/*System.out.println("path ="+objcommon.getBIBPrintPath("BVH"));
		System.out.println("path ="+objcommon.getBIBPrintPath("BVH").contains(".jrxml"));
		*/
		if(objcommon.getBIBPrintPath("BVH").contains(".jrxml")==true)
		   	   
		   {
			  System.out.println("inside jrxml");
			    HttpServletResponse response = ServletActionContext.getResponse();
			    	 
				 param = new HashMap();
				 Connection conn = null;
				 
				 String reportFileName = "Vehicle History";
				 int vehval=0;	
				 String strSqldetail="";
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
				 Statement stmt=conn.createStatement();
				 try {      
					 /*  param.put("termsquery",gatebean.getTermQry());
			                
			         param.put("descQry",gatebean.getDescQry());
			         */
			       //  System.out.println("product++++++++++"+productQuery);
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/carfarehead1.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imgpath", imgpath);
			          
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          
			          String vehsql="select coalesce(method,0) method from gl_config where field_nme='alicevehiclehistoryprint'";
				      ResultSet rs4 = stmt.executeQuery(vehsql);
				      while(rs4.next()){ 
						vehval=rs4.getInt("method");
					  }
			          if(vehval==1){
			        	   strSqldetail="select @i:=@i+1 srno,CONCAT('  ',a.date,'    JC No- ',a.jobcard,'    Milage-',a.kmin,' Service Advisor - ',a.sal_name) dtjobcardkmin,lbsrno,a.* from(select 1 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Complaint' type,coalesce(wsa.sal_name,'') sal_name,"
		        		            + " concat(c.compname,' - ',d.desc1) desc1 ,0 qty , 0 amt, 0 amount,'' lbsrno from "
									 +" ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
									+" left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) "
									 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
									 +" inner join ws_gateinpassd d on gate.doc_no=d.rdocno "
									+" inner join gl_complaint c on c.doc_no=d.complaintid where regno="+regno+" "+sqltest+" "
									+" union all "
									+" select 2 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Parts' type,'' sal_name,if(coalesce(m.productname,'')='',sp.description,m.productname) desc1 ,qty , round(customeramt,2) amt,format(round(customeramt,2),2) amount,'' lbsrno "
									+" from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
									+" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
									+"inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno left join my_main m on m.psrno=sp.psrno where regno="+regno+" "+sqltest+" "
									+" union all "
									+" select 3 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Service' type,'' sal_name, concat(jt.type ,' - ', jm.desc1) desc1,hrs qty,"
									+ " round(invoiceamt,2) amt,format(round(invoiceamt,2),2) amount,lab.srno lbsrno from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
									 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno "
									 +" inner join ws_jobmaster jm on jm.doc_no=lab.jobid inner join ws_jobtype jt on jt.doc_no=jm.jobid where regno="+regno+" "+sqltest+" ) a ,(select @i:=0) as i  order by jobcard,onum";

			          }else{
			        	   strSqldetail="select @i:=@i+1 srno,CONCAT('  ',a.date,'    JC No- ',a.jobcard,'    Milage-',a.kmin,' Service Advisor - ',a.sal_name) dtjobcardkmin,lbsrno,a.* from(select 1 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Complaint' type,coalesce(wsa.sal_name,'') sal_name,"
		        		            + " concat(c.compname,' - ',d.desc1) desc1 ,0 qty , 0 amt, 0 amount,'' lbsrno from "
									 +" ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
									+" left join my_salesman wsa on (gate.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA' and wsa.status=3) "
									 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
									 +" inner join ws_gateinpassd d on gate.doc_no=d.rdocno "
									+" inner join gl_complaint c on c.doc_no=d.complaintid where regno="+regno+" "+sqltest+" "
									+" union all "
									+" select 2 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Parts' type,'' sal_name, m.productname desc1 ,qty , round(customeramt,2) amt,format(round(customeramt,2),2) amount,'' lbsrno "
									+" from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
									+" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) "
									+"inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno inner join my_main m on m.psrno=sp.psrno where regno="+regno+" "+sqltest+" "
									+" union all "
									+" select 3 onum,regno,pltid,date_format(job.date,'%d-%m-%Y') date,job.voc_no jobcard,kmin,'Service' type,'' sal_name, concat(jt.type ,' - ', jm.desc1) desc1,hrs qty,"
									+ " round(invoiceamt,2) amt,format(round(invoiceamt,2),2) amount,lab.srno lbsrno from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no "
									 +" inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno "
									 +" inner join ws_jobmaster jm on jm.doc_no=lab.jobid inner join ws_jobtype jt on jt.doc_no=jm.jobid where regno="+regno+" "+sqltest+" ) a ,(select @i:=0) as i  order by jobcard,onum";

			          }
			        String sparesql="select r.name,round(sum(a.spareamount),2) spamt,round(sum(a.labamount),2) labamt,round(sum(a.spareamount)+sum(a.labamount),2) net from(select repairtype,(round(customeramt,2)) spareamount,0 labamount from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno where regno='"+regno+"' and gate.date>='"+sqlFromDate+"' and gate.date<='"+sqlToDate+"' and gate.pltid='"+pltid+"' "+strgridcondition+" union all select repairtype,0,(round(invoiceamt,2)) labamount from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno where regno='"+regno+"' and gate.date>='"+sqlFromDate+"' and gate.date<='"+sqlToDate+"' and gate.pltid='"+pltid+"' "+strgridcondition+") a left join ws_gartype r on r.row_no=a.repairtype group by r.name";	
			             
			        System.out.println("grid qry---------------"+sparesql);
			          param.put("sparesql",sparesql);   
			          param.put("compname", vehhistoryBean.getLblcompname());
			          param.put("compaddress", vehhistoryBean.getLblcompaddress());
			          param.put("printname", vehhistoryBean.getLblprintname());
			          param.put("comptel", vehhistoryBean.getLblcomptel());
			          param.put("compfax", vehhistoryBean.getLblcompfax());
			          param.put("compbranch", vehhistoryBean.getLblbranch());
			          param.put("location", vehhistoryBean.getLbllocation());
			          param.put("name", vehhistoryBean.getLblcustname()); 
			          param.put("address", vehhistoryBean.getLblAddress());
			          param.put("mobile", vehhistoryBean.getLblphone());
			          param.put("email", vehhistoryBean.getLblemail());
			          param.put("regno", vehhistoryBean.getLblregno());
			          param.put("chasis", vehhistoryBean.getLblchassis());
			          param.put("brand", vehhistoryBean.getLblbrand());
			          param.put("model", vehhistoryBean.getLblmodel());
			          param.put("yom", vehhistoryBean.getLblyom());
			          param.put("vehiclehissql",strSqldetail);
			          param.put("partstot", vehhistoryBean.getPartstotal());
			          param.put("servicetot", vehhistoryBean.getServicetotal());
			          param.put("grandtotal", vehhistoryBean.getGrandtotal());
			
			          System.out.println("--"+getGrandtotal());
			          
			          
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			     //   System.out.println("pathhhhhhhhhhhhhhhhhhh"+commDAO.getPrintPath(dtype));  
	            JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/workshop/vehiclehistory/"+objcommon.getBIBPrintPath(dtype)));
	        	 
	             JasperReport jasperReport = JasperCompileManager.compileReport(design);
	            generateReportPDF(response, param, jasperReport, conn);
	      

	  } catch (Exception e) {

	      e.printStackTrace();
	      conn.close();
	  }
				 finally{
					 conn.close();
				 }
		   }
			 return "print";
 }	
		
	public String printActionPartWise() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();;
		String branch = request.getParameter("branchval");
		String regno = request.getParameter("regno");
		String pltid = request.getParameter("pltid");
		String psrno = request.getParameter("psrno");
		String frmDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		String cmbrepairtype=request.getParameter("cmbrepairtype")==null?"":request.getParameter("cmbrepairtype").toString();
		 String dtype=request.getParameter("dtype").toString();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        
			String sqld="",sql="",sql1 = "",sql11 = "",sql2 = "",sql13 = "";
			String sqltest="";
	       
			if(!(frmDate.equalsIgnoreCase("undefined")) && !(frmDate.equalsIgnoreCase("")) && !(frmDate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(frmDate);
	        }
	        if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
	        }
		 
	        if(sqlFromDate!=null){
				sqltest+=" and ws.date>='"+sqlFromDate+"'";
			}
			if(sqlFromDate!=null){
				sqltest+=" and ws.date<='"+sqlToDate+"'";
			}
	        if(!pltid.equalsIgnoreCase("")){
	        	sqltest+=" and ws.pltid='"+pltid+"'";
	        }
	        if(!psrno.equalsIgnoreCase("")){
	        	sqltest+=" and m.psrno='"+psrno+"'";
	        }
	        String strgridcondition="";
	        /*if(!cmbrepairtype.equalsIgnoreCase("")){
	        	sqltest+=" and gate.repairtype="+cmbrepairtype;
	        	strgridcondition+=" and gate.repairtype="+cmbrepairtype;
	        }*/
	        setUrl(objcommon.getBIBPrintPath(dtype));
	
			vehhistoryBean=vehhistoryDAO.getPrint(request,branch,frmDate,toDate,regno,pltid,cmbrepairtype);
		setLblcompname(vehhistoryBean.getLblcompname());
		setLblcompaddress(vehhistoryBean.getLblcompaddress());
		setLblprintname(vehhistoryBean.getLblprintname());
		setLblprintname1(vehhistoryBean.getLblprintname1());
		setLblcomptel(vehhistoryBean.getLblcomptel());
		setLblcompfax(vehhistoryBean.getLblcompfax());
		setLblbranch(vehhistoryBean.getLblbranch());
		setLbllocation(vehhistoryBean.getLbllocation());
		setLblcustname(vehhistoryBean.getLblcustname());
		setLblAddress(vehhistoryBean.getLblAddress());
		setLblphone(vehhistoryBean.getLblphone());;
		setLblemail(vehhistoryBean.getLblemail());
		setLblregno(vehhistoryBean.getLblregno());
		setLblchassis(vehhistoryBean.getLblchassis());
		setLblbrand(vehhistoryBean.getLblbrand());
		setLblmodel(vehhistoryBean.getLblmodel());
		setLblyom(vehhistoryBean.getLblyom());
		
	
		
		/*System.out.println("path ="+objcommon.getBIBPrintPath("BVH"));
		System.out.println("path ="+objcommon.getBIBPrintPath("BVH").contains(".jrxml"));
		*/
		
			  System.out.println("inside jrxml");
			    HttpServletResponse response = ServletActionContext.getResponse();
			    	 
				 param = new HashMap();
				 Connection conn = null;
				 
				 String reportFileName = "Vehicle History";
				 int vehval=0;	
				 String strSqldetail="";
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
				 Statement stmt=conn.createStatement();
				 try {      
					 /*  param.put("termsquery",gatebean.getTermQry());
			                
			         param.put("descQry",gatebean.getDescQry());
			         */
			       //  System.out.println("product++++++++++"+productQuery);
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/carfarehead1.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imgpath", imgpath);
			          
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          
			        /*  String vehsql="select coalesce(method,0) method from gl_config where field_nme='alicevehiclehistoryprint'";
				      ResultSet rs4 = stmt.executeQuery(vehsql);
				      while(rs4.next()){ 
						vehval=rs4.getInt("method");
					  }*/
			         
			        	   strSqldetail="select @i:=@i+1 srno,h.regno,h.product,h.job,date_format(h.jdate,'%d-%m-%Y')date,h.kmin kms,if(coalesce((h.kmval-h.kmchk),0)*-1<0,0,coalesce((h.kmval-h.kmchk),0)*-1)kminterval,if(coalesce(DATEDIFF(h.dateval,h.datechk),0)*-1<0,0,coalesce(DATEDIFF(h.dateval,h.datechk),0)*-1) dateinterval"
                                      + " from(select a.psrno,a.regno,a.product,a.job,a.jdate,@g as dateval,@j as kmval,a.kmin,coalesce(round(@j:=(@j-@j)+a.km1,2),0) as kmchk,"
                                      + "coalesce(@g:=(@g-@g)+a.jdate,0) as datechk from(select ws.date,m.psrno,ws.regno,m.part_no,concat(coalesce(m.productname,''),'-',m.part_no)product,coalesce(sp.jobcarddocno)job,"
                                      + "wj.date jdate,ws.kmin,ws.kmin km1 from ws_gateinpass ws inner join ws_estm spare on ws.doc_no=spare.gipno  inner join ws_jobcard wj on spare.doc_no=wj.refno and reftype='est' "
                                      + "inner join ws_jccspare sp on wj.doc_no=sp.jobcarddocno inner join my_main m on m.psrno=sp.psrno where regno="+regno+" and ws.regno="+regno+"  "+sqltest+" )as a,(select @j:=0) as j,(select @g:=0) as g,(select @i:=0) as i order by a.psrno,a.date)h";

			        
			        //String sparesql="select r.name,round(sum(a.spareamount),2) spamt,round(sum(a.labamount),2) labamt,round(sum(a.spareamount)+sum(a.labamount),2) net from(select repairtype,(round(customeramt,2)) spareamount,0 labamount from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_jccspare sp on job.doc_no=sp.jobcarddocno where regno='"+regno+"' and gate.date>='"+sqlFromDate+"' and gate.date<='"+sqlToDate+"' and gate.pltid='"+pltid+"' "+strgridcondition+" union all select repairtype,0,(round(invoiceamt,2)) labamount from ws_gateinpass gate inner join ws_estm est on est.gipno=gate.doc_no inner join ws_jobcard job on (job.reftype='EST' and job.refno=est.doc_no) inner join ws_estlabour lab on est.doc_no=lab.rdocno where regno='"+regno+"' and gate.date>='"+sqlFromDate+"' and gate.date<='"+sqlToDate+"' and gate.pltid='"+pltid+"' "+strgridcondition+") a left join ws_gartype r on r.row_no=a.repairtype group by r.name";	
			             
			        System.out.println("partwise grid qry---------------"+strSqldetail);
			         // param.put("sparesql",sparesql);   
			          param.put("compname", vehhistoryBean.getLblcompname());
			          param.put("compaddress", vehhistoryBean.getLblcompaddress());
			          param.put("printname", vehhistoryBean.getLblprintname());
			          param.put("comptel", vehhistoryBean.getLblcomptel());
			          param.put("compfax", vehhistoryBean.getLblcompfax());
			          param.put("compbranch", vehhistoryBean.getLblbranch());
			          param.put("location", vehhistoryBean.getLbllocation());
			          param.put("name", vehhistoryBean.getLblcustname()); 
			          param.put("address", vehhistoryBean.getLblAddress());
			          param.put("mobile", vehhistoryBean.getLblphone());
			          param.put("email", vehhistoryBean.getLblemail());
			          param.put("regno", vehhistoryBean.getLblregno());
			          param.put("chasis", vehhistoryBean.getLblchassis());
			          param.put("brand", vehhistoryBean.getLblbrand());
			          param.put("model", vehhistoryBean.getLblmodel());
			          param.put("yom", vehhistoryBean.getLblyom());
			          param.put("vehiclehissql",strSqldetail);
			        /*  param.put("partstot", vehhistoryBean.getPartstotal());
			          param.put("servicetot", vehhistoryBean.getServicetotal());
			          param.put("grandtotal", vehhistoryBean.getGrandtotal());*/
			
			          System.out.println("--"+getGrandtotal());
			          
			          
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			     //   System.out.println("pathhhhhhhhhhhhhhhhhhh"+commDAO.getPrintPath(dtype));  
	            JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/workshop/vehiclehistory/VehHisParts.jrxml"));
	        	 
	             JasperReport jasperReport = JasperCompileManager.compileReport(design);
	            generateReportPDF(response, param, jasperReport, conn);
	      

	  } catch (Exception e) {

	      e.printStackTrace();
	      conn.close();
	  }
				 finally{
					 conn.close();
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
		
		
		
	}