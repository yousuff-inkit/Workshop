package com.dashboard.marketing.leaseapplicationfollowup;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.marketing.leaseapplicationfollowup.ClsleaseApplicationFollowupDAO;
import com.dashboard.marketing.leaseapplicationfollowup.ClsleaseApplicationFollowupBean;
import com.mailwithpdf.SendEmailAction;

@SuppressWarnings("serial")
public class ClsleaseApplicationFollowupAction extends HttpServlet {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection connDAO = new ClsConnection();

	ClsleaseApplicationFollowupDAO leaseDAO= new ClsleaseApplicationFollowupDAO(); 
	ClsleaseApplicationFollowupBean pintbean = new ClsleaseApplicationFollowupBean();
		
	  private String brchName;
	
    private String vendor,ldate; 



	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getLdate() {
		return ldate;
	}
	public void setLdate(String ldate) {
		this.ldate = ldate;
	}
	
	
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;
	
	
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("srno"));
		 
		
		 pintbean=leaseDAO.getPrint(doc);
		 ArrayList<String> arraylist = leaseDAO.getPrintdetails(doc,request);
		 
		
		  //cl details
		 
		 setLblprintname("Vehicle Purchase Order");
		  
		 setVendor(pintbean.getVendor());
		 setLdate(pintbean.getLdate());
		 
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	 

	   
		 return "print";
		 }	
	
	public void printActionJasper() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
		String sno=request.getParameter("srno")==null?"0":request.getParameter("srno");
		String pntsno=request.getParameter("printsrno")==null?"0":request.getParameter("printsrno");
		String pntdoc=request.getParameter("printdocno")==null?"0":request.getParameter("printdocno");
		String pntbrh=request.getParameter("printbrhid")==null?"0":request.getParameter("printbrhid");
		String cldoc=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
		int srno=Integer.parseInt(sno);
		int printsrno=Integer.parseInt(pntsno);
		int printdocno=Integer.parseInt(pntdoc);
		int printbrhid=Integer.parseInt(pntbrh);
		String email=request.getParameter("email")==null?"":request.getParameter("email");
		 String print = request.getParameter("print");
		 int cldocno=Integer.parseInt(cldoc);
	//	pettyCashBean=pettyCashDAO.getPrint(request,docno,branch,header);
		
		String reportFileName = "print_vehrequest";
		 param = new HashMap();
		 Connection conn = null;
		 try {
	          
             	 conn = connDAO.getMyConnection();
             //	Statement stmtPC = conn.createStatement();
            	
        	 param.put("printname", "VEHICLE REQUEST and RELEASE FORM");
        	 
        	 String detailsql="select trim(a.RefName) client,brd.brand_name  brand,model.vtype model,req.allotno,req.chasisno from gl_leaseappm la "
        	 		+ " left join  gl_leasecalcreq req on la.reqdoc=req.leasereqdocno left join gl_vehbrand brd on req.brdid=brd.doc_no "
        	 		+ "left join gl_vehmodel model on  req.modid=model.doc_no "
        	 		+ "left join my_acbook a on a.cldocno=la.cldocno and a.dtype='CRM' and a.status=3 "
        	 		+ "where  la.status=3 and la.brhid="+printbrhid+" and req.lastatus=1 and la.doc_no="+printdocno+" and req.reqsrno="+printsrno+" ";
        	 
        	 String gridsql="select @id:=@id+1 as srno,a.* from (select CONCAT('BRAND : ',brd.brand_name,' & MODEL : ',m.vtype, "
        	 		+ "COALESCE(CONCAT(' & VSB No : ',req.allotno),' ')) typeofvehicle,round(req.landedcost,2) landedcost,round(req.margin,2) margin,"
        	 		+ "round(req.daimlersupport,2) daimlersupport,"
        	 		+ "round((req.landedcost+req.margin-req.daimlersupport),2) invoiceprice from gl_leaseappd d left join gl_vehmodel m on d.modid=m.doc_no "
        	 		+ "left join gl_vehbrand brd on d.brdid=brd.doc_no left join gl_leasecalcreq req on req.leasereqdocno=d.leasereqdocno "
        	 		+ "and req.reqsrno=d.reqsrno left join gl_blaf bf on req.srno=bf.rdocno and bf.lastatus=0 and bf.ladocno!=0 "
        	 		+ "left join gl_vehmaster v on v.fleet_no=bf.fleet where d.brhid="+printbrhid+" "
        	 				+ "and d.rdocno="+printdocno+" and d.reqsrno="+printsrno+") a,(select @id:=0)r;";
        	/* String gridsql="select @id:=@id+1 as srno,a.* from (select round(totalcost,2) totalcost,round(advance,2) advance,d.leasemonths,"
        	 		+ "d.installments,round(installmentpermonth,2) installmentpermonth,"
        	 		+ "CONCAT('BRAND : ',brd.brand_name,' & MODEL : ',m.vtype, COALESCE(CONCAT(' & VSB No : ',req.allotno),' ')) typeofvehicle"
        	 		+ " from gl_leaseappd d left join gl_vehmodel m on d.modid=m.doc_no left join gl_vehbrand brd on d.brdid=brd.doc_no"
        	 		+ " left join gl_leasecalcreq req on req.leasereqdocno=d.leasereqdocno and req.reqsrno=d.reqsrno"
        	 		+ " left join gl_blaf bf on req.srno=bf.rdocno and bf.lastatus=0"
        	 		+ " left join gl_vehmaster v on v.fleet_no=bf.fleet"
        	 		+ " where d.brhid="+printbrhid+" and d.rdocno="+printdocno+" and d.reqsrno="+printsrno+") a,(select @id:=0)r;";*/
        	 
        	// System.out.println("==grid=="+gridsql);
	             param.put("detailsql", detailsql);
	             param.put("gridsql", gridsql);
	             param.put("printby", session.getAttribute("USERNAME").toString());
                       JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/marketing/leaseapplicationfollowup/" + reportFileName + ".jrxml"));
     	 
     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportPDF(response, param, jasperReport, conn, email, print,session,srno,cldocno);
                 
      
             } catch (Exception e) {

                 e.printStackTrace();

             }
		 finally{
				conn.close();
			}	 
         
				}
	
	  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email, String print,HttpSession session,int srno,int cldocno)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  
		  byte[] bytes = null;
          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
          resp.reset();
          resp.resetBuffer();
          
          resp.setContentType("application/pdf");
          resp.setContentLength(bytes.length);
          ServletOutputStream ouputStream = resp.getOutputStream();
          
          if(print.equalsIgnoreCase("1")) {
          
	          ouputStream.write(bytes, 0, bytes.length);
	          ouputStream.flush();
	          ouputStream.close();
          } else {
        	
        	 Statement stmtleaseapp =conn.createStatement();
        	  
        	String fileName="",path="", formcode="BLAF",filepath=""; 
        	String strSql1 = "select imgPath from my_comp";

      		ResultSet rs1 = stmtleaseapp.executeQuery(strSql1);
      		while(rs1.next ()) {
      			path=rs1.getString("imgPath");
      		}

      		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
    		java.util.Date date = new java.util.Date();
    		String currdate=dateFormat.format(date);
    		
      		fileName = "LAVehicleReleaseRequest"+currdate+".pdf";
      		filepath=path+ "/attachment/"+formcode+"/"+fileName;

      		File dir = new File(path+ "/attachment/"+formcode);
      		dir.mkdirs();
      		
      		FileOutputStream fos = new FileOutputStream(filepath);
        	fos.write(bytes);
        	fos.flush();
        	fos.close();
        	
        	File saveFile=new File(filepath);
			/*SendEmailAction sendmail= new SendEmailAction();
			String msg=sendmail.SendTomail(saveFile,formcode,email);
			if(msg=="success")
			{
			String	insql="insert into blaf_email (clientid, reqcalsrno, date, sender) values("+cldocno+","+srno+",NOW(),'"+session.getAttribute("USERID").toString()+"')";
			stmtleaseapp.executeUpdate(insql); 
			}*/
			
          }
               
      }
	
	
	
}
