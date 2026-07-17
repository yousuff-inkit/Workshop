package com.workshop.wsjobcard_fancy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ibm.icu.text.SimpleDateFormat;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.workshop.wsestimationnew.ClsWSEstimationNewBean;

public class ClsWSJobCardAction extends ActionSupport{

	ClsCommon objcommon=new ClsCommon();
	ClsWSJobCardDAO jobcarddao=new ClsWSJobCardDAO();
	ClsConnection connDAO = new ClsConnection();
	ClsWSJobCardBean been=new ClsWSJobCardBean();
	private String brchName,docno,vocno,date,promdate,user,promtime,msg,deleted,formdetailcode,brchname,cmbreftype,refno,hidrefno,regno,cldocno,vehicledetails,userdetails,mode;
	private String lblreftype,lblrefvocno,lbldate,lblvocno,lblcldocno,lblclientname,lblclientaddress,lblclientmobile,lblclientemail,lblregno,lblplatecode,lblbrand,lblmodel,lblchassis,lblyom,lblmileage,lblserviceadvisor;
	private String lblcompname,lblcompaddress,lblprintname,lblbranch,lbllocation,lblcomptel,lblcompfax,lblcomptrn;
	private String hidcmbreftype;
	private String hidpromtime;
	private String lbldates, lbluser, lblcolor,cdate, gipdate, lblgipno;
	private String estdocno;
	

	
	public String getEstdocno() {
		return estdocno;
	}

	public void setEstdocno(String estdocno) {
		this.estdocno = estdocno;
	}

	public String getLblgipno() {
		return lblgipno;
	}

	public void setLblgipno(String lblgipno) {
		this.lblgipno = lblgipno;
	}


	public String getHidpromtime() {
		return hidpromtime;
	}

	public void setHidpromtime(String hidpromtime) {
		this.hidpromtime = hidpromtime;
	}

	public String getGipdate() {
		return gipdate;
	}

	public void setGipdate(String gipdate) {
		this.gipdate = gipdate;
	}

	public String getLblcolor() {
		return lblcolor;
	}

	public void setLblcolor(String lblcolor) {
		this.lblcolor = lblcolor;
	}

	public String getLbluser() {
		return lbluser;
	}

	public void setLbluser(String lbluser) {
		this.lbluser = lbluser;
	}

	public String getLbldates() {
		return lbldates;
	}

	public void setLbldates(String lbldates) {
		this.lbldates = lbldates;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}

	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public String getLblserviceadvisor() {
		return lblserviceadvisor;
	}

	public void setLblserviceadvisor(String lblserviceadvisor) {
		this.lblserviceadvisor = lblserviceadvisor;
	}

	public String getLblmileage() {
		return lblmileage;
	}

	public void setLblmileage(String lblmileage) {
		this.lblmileage = lblmileage;
	}

	public String getLblreftype() {
		return lblreftype;
	}

	public void setLblreftype(String lblreftype) {
		this.lblreftype = lblreftype;
	}

	public String getLblrefvocno() {
		return lblrefvocno;
	}

	public void setLblrefvocno(String lblrefvocno) {
		this.lblrefvocno = lblrefvocno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblvocno() {
		return lblvocno;
	}

	public void setLblvocno(String lblvocno) {
		this.lblvocno = lblvocno;
	}

	public String getLblcldocno() {
		return lblcldocno;
	}

	public void setLblcldocno(String lblcldocno) {
		this.lblcldocno = lblcldocno;
	}
	
	
	public String getLblclientname() {
		return lblclientname;
	}

	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}

	public String getLblclientaddress() {
		return lblclientaddress;
	}

	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}

	public String getLblclientmobile() {
		return lblclientmobile;
	}

	public void setLblclientmobile(String lblclientmobile) {
		this.lblclientmobile = lblclientmobile;
	}

	public String getLblclientemail() {
		return lblclientemail;
	}

	public void setLblclientemail(String lblclientemail) {
		this.lblclientemail = lblclientemail;
	}

	public String getLblregno() {
		return lblregno;
	}

	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}

	public String getLblplatecode() {
		return lblplatecode;
	}

	public void setLblplatecode(String lblplatecode) {
		this.lblplatecode = lblplatecode;
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

	public String getLblchassis() {
		return lblchassis;
	}

	public void setLblchassis(String lblchassis) {
		this.lblchassis = lblchassis;
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

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno) {
		this.vocno = vocno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getBrchname() {
		return brchname;
	}

	public void setBrchname(String brchname) {
		this.brchname = brchname;
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


	
	public String getPromdate() {
		return promdate;
	}

	public void setPromdate(String promdate) {
		this.promdate = promdate;
	}

	public String getPromtime() {
		return promtime;
	}

	public void setPromtime(String promtime) {
		this.promtime = promtime;
	}	
	
	public String getRegno() {
		return regno;
	}

	public void setRegno(String regno) {
		this.regno = regno;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getVehicledetails() {
		return vehicledetails;
	}

	public void setVehicledetails(String vehicledetails) {
		this.vehicledetails = vehicledetails;
	}

	public String getUserdetails() {
		return userdetails;
	}

	public void setUserdetails(String userdetails) {
		this.userdetails = userdetails;
	}
	
	public String getHidrefno() {
		return hidrefno;
	}

	public void setHidrefno(String hidrefno) {
		this.hidrefno = hidrefno;
	}
	
	
	
	public String getgipdate() {
		return gipdate;
	}

	public void setgipdate(String gipdate) {
		this.gipdate = gipdate;
	}
	
	
	public String getcdate() {
		return cdate;
	}

	public void setcdate(String cdate) {
		this.cdate = cdate;
	}
	
	
	public String getuser() {
		return user;
	}

	public void setuser(String user) {
		this.user = user;
	}
	
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private Map<String, Object> param = null;
	
	
	
	public void setData(String docno,String vocno,java.sql.Date sqldate,java.sql.Date promdate){
		setDocno(docno);
		setVocno(vocno);
		setDate(sqldate+"");
		setCmbreftype(getCmbreftype());
		setHidcmbreftype(getCmbreftype());
		setRefno(getRefno());
		setHidrefno(getHidrefno());
		setRegno(getRegno());
		setPromdate(promdate.toString());
		setEstdocno(getEstdocno());
		setLblgipno(getLblgipno());
		System.out.println("promdate --> "+getPromdate());
		setPromtime(getPromtime());
		setHidpromtime(getPromtime());
		setLblcolor(getLblcolor());
		setgipdate(getgipdate());
		setVehicledetails(getVehicledetails());
		setUserdetails(getUserdetails());
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		try{
			if(mode.equalsIgnoreCase("view")){
				String id=request.getParameter("id");
				String modee=request.getParameter("mode");
				String docno=request.getParameter("docno");
				if(id.equalsIgnoreCase("2")){
					mode=modee;
					System.out.println(docno);
					if(mode.equalsIgnoreCase("view")){
						int doc_no=(Integer.parseInt(docno));
						setHidrefno(docno);
						setVocno(docno);
						been=jobcarddao.viewdetails(doc_no);
						setDate(been.getDate());
						setRegno(been.getRegno());
						setRefno(been.getRefno());
						setCmbreftype(been.getCmbreftype());
						setPromdate(been.getPromdate());
                        setPromtime(been.getPromtime());
                        setHidpromtime(been.getPromtime());
						setVehicledetails(been.getVehicledetails());
						setUserdetails(been.getUserdetails());
						setCldocno(been.getCldocno());
						return "success";
					}
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		if(!mode.equalsIgnoreCase("view")){
			java.sql.Date sqldate=null;
			java.sql.Date promdate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(getDate());
			}
			if(getPromdate()!=null && !getPromdate().equalsIgnoreCase("")){
				promdate=objcommon.changeStringtoSqlDate(getPromdate());
			}
			if(mode.equalsIgnoreCase("A")){
				int insertval=jobcarddao.insert(getCmbreftype(),getHidrefno(),sqldate,session,request,promdate,getPromtime(),mode,getFormdetailcode(),getBrchName());
				if(insertval>0){
					setData(insertval+"",request.getAttribute("WSJOBCARDVOCNO").toString(),sqldate,promdate);
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData(insertval+"","",sqldate,promdate);
					setMsg("Not Saved");
					return "fail";
				}
			}
		}
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException,Exception{
		
			 HttpServletRequest request=ServletActionContext.getRequest();
			 HttpSession session=request.getSession();
			
			 System.out.println("Inside Print Action");
		     SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");     
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate = objcommon.changeStringtoSqlDate(formatter.format(curDate));
		     String printdate = objcommon.changeSqltoString(cdate);
             String lbluser =(String) session.getAttribute("USERNAME");
		     System.out.println(formatter.format(curDate)+"=="+cdate);	     
			 ClsWSJobCardDAO jobcarddao=new ClsWSJobCardDAO();
			 ClsWSJobCardBean bean=new ClsWSJobCardBean();
			 String doc=request.getParameter("docno");
			 String refno=request.getParameter("refno");
			 String brhid=request.getParameter("branch");
			 String gatedocno=request.getParameter("gatedocno");
			 String estdocno=request.getParameter("estdocno");
			 //String addition=request.getParameter("addition");
			 String addition="All";
			 bean=jobcarddao.printDetails(doc,request,addition);
			 setLblreftype(bean.getLblreftype());
			 setLblrefvocno(bean.getLblrefvocno());
			 setLbldate(bean.getLbldate());   
			 setLblvocno(bean.getLblvocno());
			 setLblcldocno(bean.getLblcldocno());   
			 setLblclientname(bean.getLblclientname());
			 setLblclientaddress(bean.getLblclientaddress());
			 setLblclientemail(bean.getLblclientemail());
			 setLblclientmobile(bean.getLblclientmobile());
			 setLblregno(bean.getLblregno());
			 setLblplatecode(bean.getLblplatecode());
			 setLblchassis(bean.getLblchassis());
			 setLblbrand(bean.getLblbrand());
			 setLblmodel(bean.getLblmodel());
			 setLblyom(bean.getLblyom());
			 setLblbranch(bean.getLblbranch());
			 setLblprintname(bean.getLblprintname());
			 setLblcompaddress(bean.getLblcompaddress());
			 setLblcompname(bean.getLblcompname());
			 setLblcomptel(bean.getLblcomptel());
			 setLblcompfax(bean.getLblcompfax());
			 setLblmileage(bean.getLblmileage());
			 setLblserviceadvisor(bean.getLblserviceadvisor());
			 setLblcomptrn(bean.getLblcomptrn());
			 setLblcolor(bean.getLblcolor());
			 setGipdate(bean.getGipdate());
			 setPromdate(bean.getPromdate());
             setHidpromtime(bean.getPromtime());
			 System.out.println("Promdate-->"+getPromdate());
			 setcdate(printdate);
			 setLbluser(lbluser);
			 setLbldates(printdate);  
			 setLblgipno(bean.getLblgipno());
			 System.out.println("GIP No-->"+lblgipno);
			 if(objcommon.getPrintPath("JBC").contains(".jrxml")==true)
			   {
			     HttpServletResponse response = ServletActionContext.getResponse();
	               Connection conn = null;
			    			 try {
			    				 
			    				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
			    			     imgpath=imgpath.replace("\\", "\\\\");
			    			     
			    				    param = new HashMap();
			    			                conn = connDAO.getMyConnection();
			    			        param.put("docno", doc); 
			    			        param.put("regno", bean.getLblregno());
			    			        param.put("pltid", bean.getLblplatecode());
			    			        param.put("imgheader", imgpath);
			    			        param.put("estdocno", estdocno);
			    			        param.put("gatedocno", gatedocno);
			    			        param.put("printedby", lbluser);
			    			        param.put("brhid", brhid);
			    			        param.put("refno", refno);
			    			            
			    			        System.out.println("PATH-->"+objcommon.getPrintPath("JBC")); 
			    			        System.out.println("=="+request.getSession().getServletContext().getRealPath(objcommon.getPrintPath("JBC")));  
			    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath("JBC")));
			        JasperReport jasperReport = JasperCompileManager.compileReport(design);
			        generateReportPDF(response, param, jasperReport, conn);
			        } catch (Exception e) {
			          e.printStackTrace();
			        }
			    	  finally{
			    	  conn.close();
			    	}

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
			    					ouputStream.close();
			    					ouputStream.flush();
			    	     
			    	}


}
