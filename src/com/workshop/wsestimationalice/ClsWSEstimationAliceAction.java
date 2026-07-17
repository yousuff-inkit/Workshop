package com.workshop.wsestimationalice;

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
import com.common.ClsNumberToWord;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.workshop.wsestimation.ClsWSEstimationBean;
import com.workshop.wsestimation.ClsWSEstimationDAO;

public class ClsWSEstimationAliceAction extends ActionSupport{

	ClsWSEstimationAliceDAO estimationdao=new ClsWSEstimationAliceDAO();
	ClsCommon objcommon=new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsWSEstimationBean bean=new ClsWSEstimationBean();
	ClsWSEstimationAliceBean been=new ClsWSEstimationAliceBean();
	private String docno,vocno,date,gatedocno,gatevocno,gateuserdetails,gatevehicledetails,sparepartstotal,labourtotal,discount,esttotal,mode,msg,deleted,brchName,formdetailcode,servicestotal,servicesdiscount,netservices,hidchklumsum,lumsumamount;
	private int complaintgridlength,sparePartsNewGridlength,labourcostgridlength;
	
	
	
	public String getHidchklumsum() {
		return hidchklumsum;
	}
	public void setHidchklumsum(String hidchklumsum) {
		this.hidchklumsum = hidchklumsum;
	}
	public String getLumsumamount() {
		return lumsumamount;
	}
	public void setLumsumamount(String lumsumamount) {
		this.lumsumamount = lumsumamount;
	}
	public String getServicestotal() {
		return servicestotal;
	}
	public void setServicestotal(String servicestotal) {
		this.servicestotal = servicestotal;
	}
	public String getServicesdiscount() {
		return servicesdiscount;
	}
	public void setServicesdiscount(String servicesdiscount) {
		this.servicesdiscount = servicesdiscount;
	}
	public String getNetservices() {
		return netservices;
	}
	public void setNetservices(String netservices) {
		this.netservices = netservices;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public String getGatedocno() {
		return gatedocno;
	}
	public void setGatedocno(String gatedocno) {
		this.gatedocno = gatedocno;
	}
	public String getGatevocno() {
		return gatevocno;
	}
	public void setGatevocno(String gatevocno) {
		this.gatevocno = gatevocno;
	}
	public String getGateuserdetails() {
		return gateuserdetails;
	}
	public void setGateuserdetails(String gateuserdetails) {
		this.gateuserdetails = gateuserdetails;
	}
	public String getGatevehicledetails() {
		return gatevehicledetails;
	}
	public void setGatevehicledetails(String gatevehicledetails) {
		this.gatevehicledetails = gatevehicledetails;
	}
	public String getSparepartstotal() {
		return sparepartstotal;
	}
	public void setSparepartstotal(String sparepartstotal) {
		this.sparepartstotal = sparepartstotal;
	}
	public String getLabourtotal() {
		return labourtotal;
	}
	public void setLabourtotal(String labourtotal) {
		this.labourtotal = labourtotal;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	public String getEsttotal() {
		return esttotal;
	}
	public void setEsttotal(String esttotal) {
		this.esttotal = esttotal;
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
	public int getComplaintgridlength() {
		return complaintgridlength;
	}
	public void setComplaintgridlength(int complaintgridlength) {
		this.complaintgridlength = complaintgridlength;
	}
	
	public int getSparePartsNewGridlength() {
		return sparePartsNewGridlength;
	}
	public void setSparePartsNewGridlength(int sparePartsNewGridlength) {
		this.sparePartsNewGridlength = sparePartsNewGridlength;
	}
	public int getLabourcostgridlength() {
		return labourcostgridlength;
	}
	public void setLabourcostgridlength(int labourcostgridlength) {
		this.labourcostgridlength = labourcostgridlength;
	}
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private Map<String, Object> param = null;       
	public void setData(String docno,String vocno,java.sql.Date sqldate){
		setDocno(docno);
		setVocno(vocno);
		setDate(sqldate.toString());
		setGateuserdetails(getGateuserdetails());
		setGatevehicledetails(getGatevehicledetails());
		setGatedocno(getGatedocno());
		setGatevocno(getGatevocno());
		setSparepartstotal(getSparepartstotal());
		setLabourtotal(getLabourtotal());
		setDiscount(getDiscount());
		setEsttotal(getEsttotal());
		setServicesdiscount(getServicesdiscount());
		setServicestotal(getServicestotal());
		setNetservices(getNetservices());
		setHidchklumsum(getHidchklumsum());
		if(getLumsumamount()!=null && !getLumsumamount().equalsIgnoreCase("")){
			setLumsumamount(getLumsumamount());
		}
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("view")){
		String id=request.getParameter("id");
	    String modee=request.getParameter("mode");
	    String docno=request.getParameter("docno");
	    String gipnoo=request.getParameter("gipnoo");
	    
	    System.out.println("gip=="+gipnoo);
	    /*System.out.println("===="+id+"mode--"+modee+"gipno---"+gipnoo+"docnooo"+docno);*/
	    if(id.equalsIgnoreCase("2")){
	    	
	    mode=modee;
	    
		if(mode.equalsIgnoreCase("view")){
	    int doc_no=(Integer.parseInt(docno));
	    int gip_no=(Integer.parseInt(gipnoo));
	 	been=estimationdao.viewdetails(doc_no,gip_no);
		
		
			
			setDocno(docno);
			setGatedocno(been.getGatedocno());
			setGatevocno(gipnoo);
			setVocno(been.getVocno());
			setGateuserdetails(been.getGateuserdetails());
			setGatevehicledetails(been.getGatevehicledetails());
			setServicesdiscount(been.getServicesdiscount());
			setNetservices(been.getNetservices());
			//System.out.println("dsfdnfhd"+been.getNetservices());
			return "success";
		}
		
		
		
		}
	    }
		
		
		
		if(!mode.equalsIgnoreCase("view")){
			java.sql.Date sqldate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(getDate());
			}
			ArrayList<String> sparepartsarray=new ArrayList<>();
			ArrayList<String> labourcostarray=new ArrayList<>();
			
			if(getHidchklumsum().equalsIgnoreCase("")){
				setHidchklumsum("0");
			}
			if(mode.equalsIgnoreCase("A")){
			
				for(int i=0;i<getSparePartsNewGridlength();i++){
					String temp=requestParams.get("sparepartsarray"+i)[0];
					sparepartsarray.add(temp);
				}
				for(int i=0;i<getLabourcostgridlength();i++){
					String temp=requestParams.get("labourcostarray"+i)[0];
					labourcostarray.add(temp);
				}
				int insertval=estimationdao.insert(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getServicesdiscount(),
						getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount());
				if(insertval>0){
					setData(insertval+"",request.getAttribute("WSESTVOCNO").toString(),sqldate);
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData(insertval+"","",sqldate);
					setMsg("Not Saved");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
			 
				for(int i=0;i<getSparePartsNewGridlength();i++){
				String temp=requestParams.get("sparepartsarray"+i)[0];
				sparepartsarray.add(temp);
				}
				for(int i=0;i<getLabourcostgridlength();i++){
					String temp=requestParams.get("labourcostarray"+i)[0];
					labourcostarray.add(temp);
				}
				boolean status=estimationdao.edit(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getDocno(),getVocno(),
						getServicesdiscount(),getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount());
				if(status){
					setData(getDocno(),getVocno(),sqldate);
					setMsg("Updated Successfully");
					return "success";
				}
				else{
					setData(getDocno(),getVocno(),sqldate);
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				boolean status=estimationdao.delete(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getDocno(),getVocno());
				if(status){
					setData(getDocno(),getVocno(),sqldate);
					setMsg("Successfully Deleted");
					return "success";
				}
				else{
					setData(getDocno(),getVocno(),sqldate);
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		}
	return "fail";
	}
	
	public String printAction() throws ParseException, SQLException,Exception{
		  System.out.println("In print Action1");  
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  String voc=request.getParameter("estDocno");
		  String docno=request.getParameter("docno");  
		  String brhid=request.getParameter("branch");
		  String gatedocno=request.getParameter("gatedocno");
		  //been=estimationdao.getPrint(voc);     
		  Double amount=0.0;
		  String amount1="",amountwords="";   
		  System.out.println("In print Action2");    
		  if(objcommon.getPrintPath("EST").contains(".jrxml")==true){         
		     HttpServletResponse response = ServletActionContext.getResponse();
             Connection conn = null;
		    		
             try{
			          	     conn = connDAO.getMyConnection();
				    	     Statement stmt = conn.createStatement();
				    	     ClsNumberToWord ns=new ClsNumberToWord();       
				    	     
				    	     String strsql="select round(sum(amount),2) amount,format(sum(amount),2) amount1 from(select lab.total amount,1 gp from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no  where m.status=3 and lab.addition=0 and lab.rdocno='"+docno+"' union all select approvedvalue amount,1 gp from ws_estspare where addition=0 and rdocno='"+docno+"')a group by gp";     
				    	     ResultSet rs=stmt.executeQuery(strsql);          
				    	     while(rs.next()){         
				    	    	 amount=rs.getDouble("amount");  
				    	    	 amount1=rs.getString("amount1");         
				    	     }
                             amountwords=ns.convertNumberToWords(amount);  
                             System.out.println(amount1+"==="+amountwords);   
		    				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");  
		    			     imgpath=imgpath.replace("\\", "\\\\");
		    				 param = new HashMap();
		    			     param.put("vocno", voc); 
		    			     param.put("docno", docno); 
		    			     param.put("brhid", brhid); 
		    			     param.put("total", amount1);
		    			     param.put("amountwords", amountwords);          
		    			     param.put("imgpath", imgpath);       
		    			     
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath("EST")));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);   
		        generateReportPDF(response, param, jasperReport, conn);
              }catch (Exception e){
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
