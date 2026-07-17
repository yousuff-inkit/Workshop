package com.operations.marketing.leasecalculatoralfahim;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.AddressException;
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
import com.mailwithpdf.SendEmailAction;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import com.opensymphony.xwork2.ActionSupport;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;




public class ClsLeaseCalcAlFahimAction extends ActionSupport  {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLeaseCalcAlFahimDAO calcdao=new ClsLeaseCalcAlFahimDAO();
	private int docno;
	private int vocno;
	private String date;
	private String hiddate;
	private String leasereqdoc;
	private String hidleasereqdoc;
	private int reqgridlength;
	private String mode;
	private String msg;
	private String deleted;
	private String brchName;
	private String formdetailcode;
	private String lbldate;
	private String lbldocno;
	private String lblleasereqdocno;
	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname;
	private String url;
	private String submitstatus;
	private int typeonelength;
	private String leasereqclient,clientmob;
	
	
	private String lblclient,lblclientaddress,lblmob,lblemail,lbltypep,lblbranch;

	private int docvals,firstarray,secarray;

	private String  lbllocation;
	
	private String terms1,generalterms,terms2;
	
	private String lblcstno,lblservicetax,lblpan,lbltinno;

	
	
	
	public String getLeasereqclient() {
		return leasereqclient;
	}
	public void setLeasereqclient(String leasereqclient) {
		this.leasereqclient = leasereqclient;
	}
	public String getClientmob() {
		return clientmob;
	}
	public void setClientmob(String clientmob) {
		this.clientmob = clientmob;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
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
	public String getLbltinno() {
		return lbltinno;
	}
	public void setLbltinno(String lbltinno) {
		this.lbltinno = lbltinno;
	}
	public String getTerms1() {
		return terms1;
	}
	public void setTerms1(String terms1) {
		this.terms1 = terms1;
	}
	public String getGeneralterms() {
		return generalterms;
	}
	public void setGeneralterms(String generalterms) {
		this.generalterms = generalterms;
	}
	public String getTerms2() {
		return terms2;
	}
	public void setTerms2(String terms2) {
		this.terms2 = terms2;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblmob() {
		return lblmob;
	}
	public void setLblmob(String lblmob) {
		this.lblmob = lblmob;
	}
	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getLbltypep() {
		return lbltypep;
	}
	public void setLbltypep(String lbltypep) {
		this.lbltypep = lbltypep;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public int getDocvals() {
		return docvals;
	}
	public void setDocvals(int docvals) {
		this.docvals = docvals;
	}
	public int getFirstarray() {
		return firstarray;
	}
	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}
	public int getSecarray() {
		return secarray;
	}
	public void setSecarray(int secarray) {
		this.secarray = secarray;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	public int getTypeonelength() {
		return typeonelength;
	}
	public void setTypeonelength(int typeonelength) {
		this.typeonelength = typeonelength;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getVocno() {
		return vocno;
	}
	public void setVocno(int vocno) {
		this.vocno = vocno;
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
	public String getLeasereqdoc() {
		return leasereqdoc;
	}
	public void setLeasereqdoc(String leasereqdoc) {
		this.leasereqdoc = leasereqdoc;
	}
	public String getHidleasereqdoc() {
		return hidleasereqdoc;
	}
	public void setHidleasereqdoc(String hidleasereqdoc) {
		this.hidleasereqdoc = hidleasereqdoc;
	}
	public int getReqgridlength() {
		return reqgridlength;
	}
	public void setReqgridlength(int reqgridlength) {
		this.reqgridlength = reqgridlength;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
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
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLblleasereqdocno() {
		return lblleasereqdocno;
	}
	public void setLblleasereqdocno(String lblleasereqdocno) {
		this.lblleasereqdocno = lblleasereqdocno;
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSubmitstatus() {
		return submitstatus;
	}
	public void setSubmitstatus(String submitstatus) {
		this.submitstatus = submitstatus;
	}
	
	
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqldate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		System.out.println("mode: "+mode);
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> reqarray=new ArrayList<>();
			//ArrayList<String> typeonearray=new ArrayList<>();
			for(int i=0;i<getReqgridlength();i++){
				String temp=requestParams.get("testreq"+i)[0];
				reqarray.add(temp);
			}
			/*for(int i=0;i<getTypeonelength();i++){
				String temp=requestParams.get("calc"+i)[0];
				typeonearray.add(temp);
			}*/
			int val=calcdao.insert(sqldate,getHidleasereqdoc(),reqarray,session,getBrchName(),getMode(),getFormdetailcode(),request);
			if(val>0){
				setDocno(val);
				setVocno(Integer.parseInt(request.getAttribute("VOCNO").toString()));
				setDate(sqldate.toString());
				setLeasereqdoc(getLeasereqdoc());
				setHidleasereqdoc(getHidleasereqdoc());
				System.out.println(getLeasereqdoc()+"////"+getHidleasereqdoc());
				setSubmitstatus("1");
				setClientmob(getClientmob());
				setLeasereqclient(getLeasereqclient());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDocno(val);
				setVocno(Integer.parseInt(request.getAttribute("VOCNO").toString()));
				setDate(sqldate.toString());
				setLeasereqdoc(getLeasereqdoc());
				setHidleasereqdoc(getHidleasereqdoc());
				setClientmob(getClientmob());
				setLeasereqclient(getLeasereqclient());
				setMsg("Not Saved");
				setSubmitstatus("1");
				return "fail";
			}
		}
		return "fail";
	}
	
	public String printAction() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsLeaseCalculatorBean bean=new ClsLeaseCalculatorBean();
		String docno=request.getParameter("docno");
		bean=calcdao.getPrint(docno,request);
		
		setUrl(objcommon.getPrintPath("LEC"));
		setLbldate(bean.getLbldate());
		setLbldocno(bean.getLbldocno());
		setLblleasereqdocno(bean.getLblleasereqdocno());
		setLblprintname("Lease Calculator");
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcompname(bean.getLblcompname());
		setLblcomptel(bean.getLblcomptel());
		setLblclient(bean.getLblclient());
		setLblclientaddress(bean.getLblclientaddress());
		setLblmob(bean.getLblmob());
		setLblbranch(bean.getLblbranch());
		setLbllocation(bean.getLbllocation());
		return "print";
	}

	


	public String printQotAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 // HttpServletResponse response=ServletActionContext.getResponse();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		  String ckhval=request.getParameter("ckhval")==null?"NA":request.getParameter("ckhval");
		  ClsLeaseCalcAlFahimBean pintbean = new ClsLeaseCalcAlFahimBean();
		 pintbean=calcdao.getPrintQot(doc,request);

		 
		
		  //cl details
		 

	    setLblclient(pintbean.getLblclient());
	    setLblclientaddress(pintbean.getLblclientaddress());
	    setLblmob(pintbean.getLblmob());
	    setLblemail(pintbean.getLblemail());
	    //upper
	    setLbldate(pintbean.getLbldate());
	    setLbltypep(pintbean.getLbltypep());
	    setDocvals(pintbean.getDocvals());
		 
	/*	request.setAttribute("details",arraylist); */
		
		
	    setLblprintname("Quotation for vehicle Leasing");
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());


	   setFirstarray(pintbean.getFirstarray());
	   setSecarray(pintbean.getSecarray());
	   

	   setGeneralterms(pintbean.getGeneralterms());
	   setTerms1(pintbean.getTerms1());
	   setTerms2(pintbean.getTerms2());
	   
	   
		   if(ckhval.equalsIgnoreCase("test"))
		   {
			   
		
			 // Calendar now = Calendar.getInstance();
			 Calendar now = GregorianCalendar.getInstance();
			 
			SimpleDateFormat df = new SimpleDateFormat("HH");
			String formattedDate = df.format(new Date());
			//System.out.println(formattedDate);
			 
			 String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

				     
			 return SUCCESS; 
		   }
		   else
		   {
			  setLblcstno(pintbean.getLblcstno());
		 	   setLblservicetax(pintbean.getLblservicetax());
			  setLblpan(pintbean.getLblpan());
			   setUrl(objcommon.getPrintPath("QOT"));
			  return "print";   
		   }
		 
		 }	
	

public void jasperPrintAction() throws ParseException, SQLException{
	
	
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
    HttpServletResponse response = ServletActionContext.getResponse();
    
    
	//System.out.println("=============hai");
	
	String lee=request.getParameter("leasereqdoc")==null?"0":request.getParameter("leasereqdoc");
	//System.out.println("leeeeeeeeee"+lee);
    
    int doc=Integer.parseInt(request.getParameter("docno"));
    int leasereqdoc=Integer.parseInt(lee);
    String print=request.getParameter("print");
    String email=request.getParameter("email");
  // System.out.println("print="+print+"doc+-"+doc);
    
    ClsLeaseCalcAlFahimBean bean = new ClsLeaseCalcAlFahimBean();
	
	 ClsLeaseCalcAlFahimDAO DAO= new  ClsLeaseCalcAlFahimDAO();
	  bean=DAO.getPrintQot(doc,request);
	  
	  String reportFileName = "QutForVehLeas";
		 param = new HashMap();
		  Connection conn = null;
		 try {
	            
          
         
         
           conn = objconn.getMyConnection();
                 
         
           param.put("lblclient",bean.getLblclient());
           param.put("lblcompname",bean.getLblcompname());
           param.put("lbltel",bean.getLblcomptel());
           param.put("lblfax",bean.getLblcompfax());
           param.put("lblbranch",bean.getLblbranch());
           param.put("lbllocation",bean.getLbllocation());
           param.put("lbldate",bean.getLbldate());
           param.put("savedby",bean.getSavedby());
           param.put("printby", session.getAttribute("USERNAME"));
           
         
	          
           
           String monthlypay="select 'Vehicle Insurance' as include,'The Vehicle will have comprehensive Insurance Covering accidental"
           		+ " damage,Fire and Theft.'as Coverage "
           		+ " union all select 'Vehicle Servicing' as include,'All Servicing is included as per the routine intervals of "
           		+ "the manufacturers guidlines.'as Coverage "
           		+ " union all select 'Maintenance' as include,'Standard Maintenance is included in the Lease "
           		+ " Covering most mechanical faults and failure.'as Coverage "
           		+ "union all select 'Replacement Vehicle' as include,'A replacement vehicle is provided "
           		+ " for all routine service work and in the event of mechanical failure or break down.  'as Coverage "
           		+ "union all select 'Registration Fee' as include,'All Registration Fees are covered within the lease.'as Coverage "
           		+ " union all select 'Roadside Assistance' as include,'Your vehicle will have 24 Roadside assistance"
           		+ " in the event of a break down.'as Coverage";
           param.put("monthlypay", monthlypay);
           
           String rentQury="select @i:=@i+1 as srno,a.* from (select yr.yom,DATE_FORMAT(req.leasefromdate,'%d-%m-%Y') leasefromdate,brd.brand_name, "
           		+ "req.spec spec, brand,model.vtype model,coalesce(clr.color,'') color,req.leasemonths,"
           		+ "round(req.excesskmrate,2) excesskmrate,round(req.kmpermonth,0) kmpermonth,grp.gname, coalesce(round(req.totalvalue/req.leasemonths,2),'') rentpermonth "
           		+ " from gl_leasecalcreq req left join gl_vehbrand brd on req.brdid=brd.doc_no "
           		+ " left join gl_vehmodel model on req.modid=model.doc_no left join "
           		+ "my_color clr on req.clrid=clr.doc_no left join gl_lcgm lcg on "
           		+ "(req.brdid=req.brdid and req.modid=lcg.modid) left join "
           		+ " gl_vehgroup grp on (lcg.grpid=grp.doc_no) left join my_vendorm vnd on"
           		+ " (req.dealerid=vnd.doc_no) left join gl_vehauth auth on "
           		+ "(req.authid=auth.doc_no) left join gl_yom yr on(req.yomid=yr.doc_no) "
           		+ "where req.status=3 and req.rdocno="+doc+") a,(select @i:=0) r";
           param.put("rentQury", rentQury);
           // System.out.println("rentQury++++++"+rentQury);
           
	 
	 
	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
   	imgpath=imgpath.replace("\\", "\\\\");    
     param.put("imgpath", imgpath);
     
 //  System.out.println("param========"+param);
     
	    
     	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/operations/marketing/leasecalculatoralfahim/" + reportFileName + ".jrxml"));
    // 	  System.out.println("param222========"+param);
     	JasperReport jasperReport = JasperCompileManager.compileReport(design);
     	generateReportPDF(response, param, jasperReport, conn,email,print,doc,leasereqdoc,session);

	      	
					}
		 catch (Exception e) {
			  
             e.printStackTrace();

         }finally{
 			conn .close();
 		}

}
private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email, String print,int doc,int leasereqdoc,HttpSession session)throws JRException, NamingException, SQLException, IOException, MessagingException, javax.mail.MessagingException {
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
       
        Statement stmtLeaseCalc=conn.createStatement();
         
       String fileName="",path="", formcode="LEC",filepath=""; 
       String strSql1 = "select imgPath from my_comp";

      ResultSet rs1 = stmtLeaseCalc.executeQuery(strSql1);
      while(rs1.next ()) {
       path=rs1.getString("imgPath");
      }

      DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
    java.util.Date date = new java.util.Date();
    String currdate=dateFormat.format(date);
    
      fileName = "LeaseQuotation"+currdate+".pdf";
      filepath=path+ "/attachment/"+formcode+"/"+fileName;

      File dir = new File(path+ "/attachment/"+formcode);
      dir.mkdirs();
      
      FileOutputStream fos = new FileOutputStream(filepath);
       fos.write(bytes);
       fos.flush();
       fos.close();
       
       File saveFile=new File(filepath);
       SendEmailAction sendmail= new SendEmailAction();
       //String msg=sendmail.SendTomail(saveFile,formcode,email);
       ClsLeaseCalculatorBean bean = new ClsLeaseCalculatorBean();
       
       String msg=sendmail.SendTomail( saveFile,formcode,email,String.valueOf(doc),session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),bean.getLblclient());
		 if(msg=="success")
		 {
			 String st1="insert into lec_email (leasecalcno, reqcalsrno, date, sender) values ("+doc+","+leasereqdoc+",NOW(),'"+session.getAttribute("USERID").toString()+"')";
			 stmtLeaseCalc.executeUpdate(st1);
		 }
 
        }
             
    }


}
