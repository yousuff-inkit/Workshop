package com.workshop.estimationv3;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.common.ClsNumberToWord;
import com.common.ClsAmountToWords;  
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.workshop.wsestimation.ClsWSEstimationBean;
import com.workshop.wsestimation.ClsWSEstimationDAO;

public class ClsEstimationV3Action extends ActionSupport{

	ClsEstimationV3DAO estimationdao=new ClsEstimationV3DAO();
	ClsCommon objcommon=new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsEstimationV3Bean been=new ClsEstimationV3Bean();
	private String docno,vocno,date,gatedocno,gatevocno,gateuserdetails,gatevehicledetails,sparepartstotal,labourtotal,discount,esttotal,mode,msg,deleted,brchName,formdetailcode,servicestotal,servicesdiscount,netservices,hidchklumsum,lumsumamount;
	private int complaintgridlength,sparePartsNewGridlength,labourcostgridlength;
	private String header,notes,internalremarks,chkservicelumsum,hidchkservicelumsum,servicelumsumamt,chkrandomlumsum,hidchkrandomlumsum,randomlumsumamt;
	private String estimatedays,gipdatetime;
	private String gipclaimno,gipinsurcomp;
	private String brhid;
	private String sparetotal,sparediscount,netspare;
	private String hidcmbentitytype,cmbentitytype;
	private String distservicediscount,distsparediscount;
	private String packagename,packagedocno;
	
	
	public String getPackagename() {
		return packagename;
	}
	public void setPackagename(String packagename) {
		this.packagename = packagename;
	}
	public String getPackagedocno() {
		return packagedocno;
	}
	public void setPackagedocno(String packagedocno) {
		this.packagedocno = packagedocno;
	}
	public String getDistservicediscount() {
		return distservicediscount;
	}
	public void setDistservicediscount(String distservicediscount) {
		this.distservicediscount = distservicediscount;
	}
	public String getDistsparediscount() {
		return distsparediscount;
	}
	public void setDistsparediscount(String distsparediscount) {
		this.distsparediscount = distsparediscount;
	}
	public String getHidcmbentitytype() {
		return hidcmbentitytype;
	}
	public void setHidcmbentitytype(String hidcmbentitytype) {
		this.hidcmbentitytype = hidcmbentitytype;
	}
	public String getCmbentitytype() {
		return cmbentitytype;
	}
	public void setCmbentitytype(String cmbentitytype) {
		this.cmbentitytype = cmbentitytype;
	}
	public String getSparetotal() {
		return sparetotal;
	}
	public void setSparetotal(String sparetotal) {
		this.sparetotal = sparetotal;
	}
	public String getSparediscount() {
		return sparediscount;
	}
	public void setSparediscount(String sparediscount) {
		this.sparediscount = sparediscount;
	}
	public String getNetspare() {
		return netspare;
	}
	public void setNetspare(String netspare) {
		this.netspare = netspare;
	}
	public String getBrhid() {
		return brhid;
	}
	public void setBrhid(String brhid) {
		this.brhid = brhid;
	}
	public String getGipclaimno() {
		return gipclaimno;
	}
	public void setGipclaimno(String gipclaimno) {
		this.gipclaimno = gipclaimno;
	}
	public String getGipinsurcomp() {
		return gipinsurcomp;
	}
	public void setGipinsurcomp(String gipinsurcomp) {
		this.gipinsurcomp = gipinsurcomp;
	}
	public String getGipdatetime() {
		return gipdatetime;
	}
	public void setGipdatetime(String gipdatetime) {
		this.gipdatetime = gipdatetime;
	}
	public String getEstimatedays() {
		return estimatedays;
	}
	public void setEstimatedays(String estimatedays) {
		this.estimatedays = estimatedays;
	}
	public String getInternalremarks() {
		return internalremarks;
	}
	public void setInternalremarks(String internalremarks) {
		this.internalremarks = internalremarks;
	}
	public String getChkservicelumsum() {
		return chkservicelumsum;
	}
	public void setChkservicelumsum(String chkservicelumsum) {
		this.chkservicelumsum = chkservicelumsum;
	}
	public String getHidchkservicelumsum() {
		return hidchkservicelumsum;
	}
	public void setHidchkservicelumsum(String hidchkservicelumsum) {
		this.hidchkservicelumsum = hidchkservicelumsum;
	}
	public String getServicelumsumamt() {
		return servicelumsumamt;
	}
	public void setServicelumsumamt(String servicelumsumamt) {
		this.servicelumsumamt = servicelumsumamt;
	}
	public String getChkrandomlumsum() {
		return chkrandomlumsum;
	}
	public void setChkrandomlumsum(String chkrandomlumsum) {
		this.chkrandomlumsum = chkrandomlumsum;
	}
	public String getHidchkrandomlumsum() {
		return hidchkrandomlumsum;
	}
	public void setHidchkrandomlumsum(String hidchkrandomlumsum) {
		this.hidchkrandomlumsum = hidchkrandomlumsum;
	}
	public String getRandomlumsumamt() {
		return randomlumsumamt;
	}
	public void setRandomlumsumamt(String randomlumsumamt) {
		this.randomlumsumamt = randomlumsumamt;
	}
	public String getHeader() {
		return header;
	}
	public void setHeader(String header) {
		this.header = header;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
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
		setPackagedocno(getPackagedocno());
		setPackagename(getPackagename());
		setHidcmbentitytype(getCmbentitytype());
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
		setSparediscount(getSparediscount());
		setSparetotal(getSparetotal());
		setNetspare(getNetspare());
		setHidchklumsum(getHidchklumsum());
		setEstimatedays(getEstimatedays());
		setGipinsurcomp(getGipinsurcomp());
		setGipclaimno(getGipclaimno());
		if(getLumsumamount()!=null && !getLumsumamount().equalsIgnoreCase("")){
			setLumsumamount(getLumsumamount());
		}
		setGipdatetime(getGipdatetime());
		setHeader(getHeader());
		setNotes(getNotes());
		setInternalremarks(getInternalremarks());
		setHidchkservicelumsum(getHidchkservicelumsum());
		setHidchkrandomlumsum(getHidchkrandomlumsum());
		if(getRandomlumsumamt()!=null && !getRandomlumsumamt().equalsIgnoreCase("")){
			setRandomlumsumamt(getRandomlumsumamt());
		}
		if(getServicelumsumamt()!=null && !getServicelumsumamt().equalsIgnoreCase("")){
			setServicelumsumamt(getServicelumsumamt());
		}
		setDistservicediscount(getDistservicediscount());
		setDistsparediscount(getDistsparediscount());
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
	 		setHidcmbentitytype(been.getHidcmbentitytype());
	 		setDate(been.getDate());
	 		setBrhid(been.getBrhid());
	 		System.out.println("Branch Set:"+getBrhid());
	 		setPackagedocno(been.getPackagedocno());
	 		setPackagename(been.getPackagename());
	 		setGipclaimno(been.getGipclaimno());
	 		setGipinsurcomp(been.getGipinsurcomp());
	 		setSparediscount(been.getSparediscount());
	 		setSparetotal(been.getSparetotal());
	 		setNetspare(been.getNetspare());
			setHeader(been.getHeader());
			setNotes(been.getNotes());
			setInternalremarks(been.getInternalremarks());
			setDocno(been.getDocno());
			setGatedocno(been.getGatedocno());
			setGatevocno(been.getGatevocno());
			setVocno(been.getVocno());
			setGateuserdetails(been.getGateuserdetails());
			setGatevehicledetails(been.getGatevehicledetails());
			setServicesdiscount(been.getServicesdiscount());
			setNetservices(been.getNetservices());
			setEstimatedays(been.getEstimatedays());
			setGipdatetime(been.getGipdatetime());
			setHidchklumsum(been.getHidchklumsum());
			setLumsumamount(been.getLumsumamount());
			setHidchkservicelumsum(been.getHidchkservicelumsum());
			setServicelumsumamt(been.getServicelumsumamt());
			setHidchkrandomlumsum(been.getHidchkrandomlumsum());
			setRandomlumsumamt(been.getRandomlumsumamt());
			setDistservicediscount(been.getDistservicediscount());
			setDistsparediscount(been.getDistsparediscount());
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
			if(getHidchkservicelumsum().equalsIgnoreCase("")){
				setHidchkservicelumsum("0");
			}
			if(getHidchkrandomlumsum().equalsIgnoreCase("")){
				setHidchkrandomlumsum("0");
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
				ClsEstimationV3Action masteraction=new ClsEstimationV3Action();
				masteraction.setPackagedocno(getPackagedocno());
				masteraction.setPackagename(getPackagename());
				int insertval=estimationdao.insert(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getServicesdiscount(),
						getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount(),getHeader(),getNotes(),getInternalremarks(),
						getHidchkservicelumsum(),getServicelumsumamt(),getHidchkrandomlumsum(),getRandomlumsumamt(),getEstimatedays(),
						getGipdatetime(),getGipclaimno(),getSparetotal(),getSparediscount(),getNetspare(),getCmbentitytype(),
						getDistservicediscount(),getDistsparediscount(),masteraction);
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
				ClsEstimationV3Action masteraction=new ClsEstimationV3Action();
				masteraction.setPackagedocno(getPackagedocno());
				masteraction.setPackagename(getPackagename());
				boolean status=estimationdao.edit(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getDocno(),getVocno(),
						getServicesdiscount(),getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount(),getHeader(),getNotes(),
						getInternalremarks(),getHidchkservicelumsum(),getServicelumsumamt(),getHidchkrandomlumsum(),getRandomlumsumamt(),
						getEstimatedays(),getGipdatetime(),getGipclaimno(),getSparetotal(),getSparediscount(),getNetspare(),
						getCmbentitytype(),getDistservicediscount(),getDistsparediscount(),masteraction);
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
		String addition=request.getParameter("addition");
		String withvat=request.getParameter("withvat");
		String printchk=request.getParameter("printchk"); 
		String mail=request.getAttribute("mail")==null || request.getAttribute("mail").toString().equalsIgnoreCase("")?"0":request.getAttribute("mail").toString();
		if(mail.trim().equalsIgnoreCase("1")){
			voc=request.getAttribute("estDocno")==null?"":request.getAttribute("estDocno").toString();
			docno=request.getAttribute("docno")==null?"":request.getAttribute("docno").toString();
			brhid=request.getAttribute("branch")==null?"":request.getAttribute("branch").toString();
			gatedocno=request.getAttribute("gatedocno")==null?"":request.getAttribute("gatedocno").toString();
			addition=request.getAttribute("addition")==null?"":request.getAttribute("addition").toString();
			withvat=request.getAttribute("withvat")==null?"":request.getAttribute("withvat").toString();
			printchk=request.getAttribute("printchk")==null?"":request.getAttribute("printchk").toString();
			String mailsource=request.getAttribute("mailsource")==null?"":request.getAttribute("mailsource").toString();
			if(mailsource.equalsIgnoreCase("Dispatch")){
				voc=request.getAttribute("estvocno")==null?"":request.getAttribute("estvocno").toString();
				docno=request.getAttribute("estDocno")==null?"":request.getAttribute("estDocno").toString();
				printchk=request.getAttribute("type")==null?"":request.getAttribute("type").toString();
			}
		}
		System.out.println(voc+"::"+docno+"::"+brhid+"::"+gatedocno+"::"+addition+"::"+withvat+"::"+printchk+"::"+mail); 
		//been=estimationdao.getPrint(voc);     
		double amount=0.0,lumsumlab=0.0,lumsumpart=0.00,total=0.00,vatamt=0.00,nettotal=0.00,sublet=0.00,consumables=0.0,discount=0.0;     
		String amount1="",amountwords="",path1="",header="",notes="";
		int chklab=0,chkpart=0;
		DecimalFormat df = new DecimalFormat("0.00");
		if(objcommon.getPrintPath("EST").contains("")==true){
			System.out.println("In print Action Est pal"); 
		    HttpServletResponse response = ServletActionContext.getResponse();
            Connection conn = null;
            try{
            conn = connDAO.getMyConnection();
	    	Statement stmt = conn.createStatement();
	    	
	    	     ClsNumberToWord ns=new ClsNumberToWord();
	    	     ClsAmountToWords amtwords=new ClsAmountToWords();
	    	     param = new HashMap();
	    	     String strsql="select round(sum(amount),2) amount,format(sum(amount),2) amount1 from(select lab.total amount,1 gp from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no  where m.status=3 and lab.addition="+addition+" and lab.rdocno='"+docno+"' union all select approvedvalue amount,1 gp from ws_estspare where addition="+addition+" and rdocno='"+docno+"')a group by gp";     
	    	     System.out.println();
	    	     ResultSet rs=stmt.executeQuery(strsql);          
	    	     while(rs.next()){         
	    	    	 amount=rs.getDouble("amount");  
	    	    	 amount1=rs.getString("amount1");         
	    	     }
	    	     
	    	     String strsql2="select imgpath from my_brch where doc_no='"+brhid+"'";          
	    	     ResultSet rs2=stmt.executeQuery(strsql2);          
	    	     while(rs2.next()){         
	    	    	 path1=rs2.getString("imgpath");         
	    	     }  
	    	     /*String strsql3="select a.* from(select (select round(sum(lab.total),2) amount from ws_estlabour lab where lab.rdocno='"+docno+"' and lab.addition='"+addition+"' group by lab.rdocno) labsum,(select round(sum(approvedvalue),2) amount from ws_estspare where rdocno='"+docno+"' and addition='"+addition+"'  group by rdocno) partsum)a";
                 System.out.println("strsql3="+strsql3);  
                 ResultSet rs3=stmt.executeQuery(strsql3);          
	    	     while(rs3.next()){         
	    	    	 lumsumlab=rs3.getDouble("labsum"); 
	    	    	 lumsumpart=rs3.getDouble("partsum");          
	    	     }    */     
                 String strsql4="select if("+addition+">0,coalesce(a.header,''),coalesce(m.header,'')) header,if("+addition+">0,coalesce(a.notes,''),coalesce(m.notes,'')) notes,if("+addition+">0,a.chkservicelumsum,m.chkservicelumsum) chkservicelumsum,if("+addition+">0,round(coalesce(a.servicelumsumamt,0),2),round(coalesce(m.servicelumsumamt,0),2)) lumsumlab,if("+addition+">0,a.chklumsum,m.chklumsum) chklumsum,if("+addition+">0,round(coalesce(a.lumsumamount,0),2),round(coalesce(m.lumsumamount,0),2)) lumsumparts,if("+addition+">0,round(coalesce(a.randomlumsumamt,0),2),round(coalesce(m.randomlumsumamt,0),2)) lumsumrandom from ws_estm m left join ws_estmadd a on m.doc_no=a.doc_no and a.addition="+addition+" where m.doc_no='"+docno+"'";     
                 System.out.println("strsql4="+strsql4);     
                 ResultSet rs4=stmt.executeQuery(strsql4);      
                 double lumsumrandom=0.0;
	    	     while(rs4.next()){         
	    	    	 header=rs4.getString("header");
	    	    	 notes=rs4.getString("notes");
	    	    	 lumsumlab=rs4.getDouble("lumsumlab"); 
	    	    	 lumsumpart=rs4.getDouble("lumsumparts"); 
	    	    	 lumsumrandom=rs4.getDouble("lumsumrandom");
	    	     }
	    	     param.put("header", header);
	    	     param.put("notes", notes);
	    	     
	    	     //String strsql5="select (select coalesce(approved,0) from ws_estspareamt where description='Total Parts Cost' and addition="+addition+" and gatedocno='"+gatedocno+"') partstotal,(select coalesce(approved,0) from ws_estspareamt where description='Total Services Cost' and addition="+addition+" and gatedocno='"+gatedocno+"') servicetotal,(select coalesce(approved,0) from ws_estspareamt where description='Sub Total' and addition="+addition+" and gatedocno='"+gatedocno+"') subtotal,(select coalesce(approved,0) from ws_estspareamt where description='VAT' and addition="+addition+" and gatedocno='"+gatedocno+"') vatamt,(select round(coalesce(approved,0),2) from ws_estspareamt where description='Net Total with VAT' and addition="+addition+" and gatedocno='"+gatedocno+"') nettotal";
	    	     String strsql5=" select sum(total) subtotal, sum(vatamt) vatamt, sum(nettotal) nettotal  from (select sum(sptotal) total, sum(spvatamount) vatamt, sum(spnetamount) nettotal from ws_estspare where rdocno="+docno+" and addition="+addition+"  union all "
	    	    		 +" select sum(jobtotal) total, sum(jobvatamount) vatamt, sum(jobnetamount) nettotal from ws_estlabour where rdocno= "+docno+" and addition="+addition+"  ) a " ;
	    	     System.out.println("strsql5="+strsql5);     
                 ResultSet rs5=stmt.executeQuery(strsql5);             
	    	     while(rs5.next()){   
//				    	    	 lumsumpart=rs5.getDouble("partstotal");      
//				    	    	 lumsumlab=rs5.getDouble("servicetotal"); 
	    	    	 total=rs5.getDouble("subtotal");   
	    	    	 vatamt=rs5.getDouble("vatamt"); 
	    	    	 nettotal=rs5.getDouble("nettotal");   
	    	     }
	    	     
	    	     /* TEAM 21*/  
	    	     double parts=0.0,lab=0.0;
	    	     String strsqls1="select sum(amount) amount,sum(lab) lab,sum(flatserviceamt) flatserviceamt,sum(flatsubletamt) flatsubletamt from(select round(if(upper(lab.strjobtype)='SUBLET',lab.hrs*lab.rate,0),2) flatsubletamt,if(upper(lab.strjobtype)!='SUBLET',lab.hrs*lab.rate,0) flatserviceamt,upper(lab.strjobtype) type , if(upper(lab.strjobtype)='SUBLET',lab.total,0) amount , if(upper(lab.strjobtype)!='SUBLET',lab.total,0) lab,rdocno from ws_estlabour lab where lab.addition="+addition+" and lab.rdocno='"+docno+"' )a group by rdocno";
	    	     System.out.println("Service Query:"+strsqls1);
	    	     ResultSet rss1=stmt.executeQuery(strsqls1);            
	    	     while(rss1.next()){
	    	    	 if(withvat.equalsIgnoreCase("3") || withvat.equalsIgnoreCase("4")){
	    	    		 sublet=rss1.getDouble("flatsubletamt");    
		    	    	 lab=rss1.getDouble("flatserviceamt");
	    	    	 }
	    	    	 else{
	    	    		 sublet=rss1.getDouble("amount");    
		    	    	 lab=rss1.getDouble("lab");
	    	    	 }
	    	     }
                 //grosstax
	    	     
	    	     double grossvat=0.0;
                 double grossnovat=0.0;
	    	     String strsql6=" select sum(grossvat) grossvat, sum(grossnovat)  grossnovat from(select if(spvatpercent=5,sum(nettotal),0) grossvat,if(spvatpercent!=5,sum(nettotal),0) grossnovat  from (select spnetamount-spvatamount nettotal,spvatpercent from ws_estspare where rdocno='"+docno+"' and addition="+addition+"  union all  select jobnetamount-jobvatamount nettotal,jobvatpercent from ws_estlabour where rdocno='"+docno+"' and addition="+addition+"  ) a group by spvatpercent)b";
	    	     System.out.println("strsql6="+strsql6);
	    	     ResultSet rs6=stmt.executeQuery(strsql6); 
	    	     while(rs6.next()){
	    	    	 grossvat=rs6.getDouble("grossvat");
	    	    	 grossnovat=rs6.getDouble("grossnovat");
	    	     }
	    	     param.put("grossamounttax",objcommon.Round(grossvat+lumsumlab+lumsumpart+lumsumrandom,2));
	    	     param.put("grossamountnontax",objcommon.Round(grossnovat,2));
	    	     
	    	     //grossvat ends// 

	    	     String strsqls4="select sum(amount) amount,sum(parts) parts,round(sum(flatconsumables),2) flatconsumables,round(sum(flatparts),2) flatparts from(select if(upper(description)='CONSUMABLES',lab.qty*lab.rate,0) flatconsumables,if(upper(description)!='CONSUMABLES',lab.qty*lab.rate,0) flatparts,rdocno,if(upper(description)='CONSUMABLES',lab.approvedvalue,0) amount,if(upper(description)!='CONSUMABLES',lab.approvedvalue,0) parts,upper(description) type from ws_estspare lab where lab.addition="+addition+" and lab.rdocno='"+docno+"' )a group by a.rdocno";
	    	     System.out.println("Parts Query:"+strsqls4);
	    	     ResultSet rss4=stmt.executeQuery(strsqls4);            
	    	     while(rss4.next()){
	    	    	 if(withvat.equalsIgnoreCase("3") || withvat.equalsIgnoreCase("4")){
	    	    		 consumables=rss4.getDouble("flatconsumables");
		    	    	 parts=rss4.getDouble("flatparts");
	    	    	 }
	    	    	 else{
	    	    		 consumables=rss4.getDouble("amount");
		    	    	 parts=rss4.getDouble("parts");
	    	    	 }
	    	    	   
	    	     }
	    	     String sqldis="";
	    	    /* if(addition.equalsIgnoreCase("0")){
	    	    	 sqldis=" select coalesce(discount,0)+coalesce(servicesdiscount,0)++coalesce(sparediscount,0) discount from ws_estm where doc_no='"+docno+"'";
	    	     }
	    	     else {*/
	    	    	 // sqldis=" select  coalesce(servicesdiscount,0)+coalesce(sparediscount,0) discount from ws_estmadd where doc_no='"+docno+"' and addition="+addition+" ";
	    	    	 sqldis=" select sum(amt) discount from (select sum(spdiscount)+sum(distsparediscount) amt from ws_estspare where rdocno='"+docno+"' and addition="+addition+" union all select sum(jobdiscount)+sum(distservicediscount) from ws_estlabour where rdocno='"+docno+"' and addition="+addition+" ) a";
	    	    // }
	    	     System.out.println("discount v3 ="+sqldis);
	    	     ResultSet rsdis=stmt.executeQuery(sqldis);            
	    	     while(rsdis.next()){         
	    	    	 discount=rsdis.getDouble("discount");      
	    	     }
	    	     param.put("sumofsublet", sublet);  
	    	     param.put("sumofconsumable", consumables);  
	    	     param.put("sumofservice", lab+lumsumlab);  // lumsumlab-sublet 
	    	     param.put("sumofparts", parts+lumsumpart);  // lumsumpart-consumables
	    	     param.put("discount", discount);  
	    	     /* TEAM 21*/  
	    	       
	    	     param.put("sublet", sublet);   
	    	     param.put("lumsumlabour", lumsumlab-sublet);  
	    	     param.put("lumsumparts", lumsumpart);   
	    	     param.put("totallumsum", total+lumsumlab+lumsumpart+lumsumrandom);  
	    	     System.out.println("Lumsum:"+lumsumlab+"::"+lumsumpart+"::"+lumsumrandom);
	    	     double lumsumvatamt=(lumsumlab+lumsumpart+lumsumrandom)*0.05;
	    	     System.out.println("Lumsum VAT:"+lumsumvatamt);
	    	     param.put("vatamt", objcommon.Round((vatamt+lumsumvatamt),2));
	    	     System.out.println("VAT:"+(vatamt+lumsumvatamt));
	    	     param.put("nettotal", objcommon.Round(nettotal+lumsumlab+lumsumpart+lumsumrandom+lumsumvatamt,2));       
	    	     System.out.println("Net:"+(nettotal+lumsumlab+lumsumpart+lumsumvatamt));
	    	     String branch="",compname="",compaddress="",comptel="",compfax="",location="";
	    	     String companysql = "select c.company,b.address,b.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno,b.doc_no from ws_estm r left join my_brch b on  "
	 					+ "r.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no left join my_locm l on l.brhid=b.doc_no left join (select min(lo.loc) loc,lo.loc_name, "
	 					+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"   
	 					+ docno + "' ";  
	 			 System.out.println("----------------"+companysql);
	 			 ResultSet resultsetcompany = stmt.executeQuery(companysql);
	 			 while (resultsetcompany.next()) {
		 			branch=resultsetcompany.getString("branchname");
		 			
		 			compname=resultsetcompany.getString("company");
		 			if(resultsetcompany.getString("company").equalsIgnoreCase("PAL AUTO GARAGE")&& resultsetcompany.getInt("doc_no")!=3){
		 				compname=resultsetcompany.getString("company")+" (Br.)";
			    	   }
		 			compaddress=resultsetcompany.getString("address");
		 			comptel=resultsetcompany.getString("tel");
		 			compfax=resultsetcompany.getString("fax");
		 			location=resultsetcompany.getString("location");     
	 			  } 
	    	      param.put("compname",compname);
		          param.put("compaddress",compaddress);
		          param.put("comptel",comptel);
		          param.put("compfax",compfax);
		          param.put("branch", branch);
		          param.put("location", location);
		          String printpath="";
		          
		          System.out.println(nettotal+"=====amountinwords===="+objcommon.Round(nettotal,2)+"==="+objcommon.round(nettotal, session));
		         if(withvat.equalsIgnoreCase("1")){   
		        	 //amountwords=ns.convertNumberToWords(nettotal);
		        	 amountwords=amtwords.convertAmountToWords(df.format(objcommon.Round((nettotal+lumsumlab+lumsumpart+lumsumvatamt+lumsumrandom),2))+"");    
		        	 printpath=objcommon.getPrintPath2("EST");
		         }
		         else if(withvat.equalsIgnoreCase("0")){   
		        	 //amountwords=ns.convertNumberToWords(nettotal);
		        	 amountwords=amtwords.convertAmountToWords(df.format(objcommon.Round((total+lumsumlab+lumsumpart+lumsumrandom),2))+"");    
		        	 printpath=objcommon.getPrintPath("EST"); 
		         }
		         else if(withvat.equalsIgnoreCase("3")){
		        	 amountwords=amtwords.convertAmountToWords(df.format(objcommon.Round((nettotal+lumsumlab+lumsumpart+lumsumvatamt+lumsumrandom),2))+"");
		        	 printpath=objcommon.getPrintPath2("EST"); 
		        	 String[] pathstr=printpath.split("[.]", 0);
					 printpath=pathstr[0]+"NormalTax.jrxml";  
		        	 //printpath="com/workshop/estimationv3/estimationTaxLiwalandAutocareNormal.jrxml"; 
		        	// printpath="com/workshop/estimationv3/estimationTaxRoprinceNormal.jrxml"; 
			     }else if(withvat.equalsIgnoreCase("4")){
			    	 amountwords=amtwords.convertAmountToWords(df.format(objcommon.Round((total+lumsumlab+lumsumpart+lumsumrandom),2))+"");
			    	 printpath=objcommon.getPrintPath("EST"); 
			    	 String[] pathstr=printpath.split("[.]", 0);
					 printpath=pathstr[0]+"Normal.jrxml";  
			    	 //printpath="com/workshop/estimationv3/estimationLiwalandAutocareNormal.jrxml";
			    	 //printpath="com/workshop/estimationv3/estimationRoprinceNormal.jrxml";
			     }else{
		        	 //amountwords=ns.convertNumberToWords(total); 
		        	 amountwords=amtwords.convertAmountToWords(df.format(objcommon.Round(total,2))+"");    
		        	 printpath=objcommon.getPrintPath("EST");        
		         }    
                  
                 System.out.println(amount1+"==="+amountwords);     
				 String imgpath=request.getSession().getServletContext().getRealPath(path1);     
			     imgpath=imgpath.replace("\\", "\\\\");
			     
			     String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        imgpath2=imgpath2.replace("\\", "\\\\");    
					param.put("imgheader", imgpath2);
			        String imgpath5=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
					imgpath5=imgpath5.replace("\\", "\\\\");    
					param.put("imgfooter", imgpath5);
			     
					String bankdetails="select name, address, beneficiary, account, ibanno, swiftcode, city, country from cm_bankdetails ";
					 ResultSet rsbank=stmt.executeQuery(bankdetails);
					 while(rsbank.next()){
						 param.put("beneficiary",rsbank.getString("beneficiary"));
						 param.put("accountno",rsbank.getString("account"));
						 param.put("ibanno",rsbank.getString("ibanno"));
						 param.put("bankname",rsbank.getString("name"));
						 param.put("bankbranch",rsbank.getString("address"));
						 param.put("swiftcode",rsbank.getString("swiftcode"));
						 param.put("bankcity",rsbank.getString("city"));
						 param.put("bankcountry",rsbank.getString("country"));
					 }	
					
			     String imgpathroyal=request.getSession().getServletContext().getRealPath("/icons/royallogo.png");  
			     imgpathroyal=imgpathroyal.replace("\\", "\\\\");
			     String imgpathroyaldesign=request.getSession().getServletContext().getRealPath("/icons/designpattern.png");  
			     imgpathroyaldesign=imgpathroyaldesign.replace("\\", "\\\\");
			     String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/royalfooter.png");
			     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
			     String watermarkroyal=request.getSession().getServletContext().getRealPath("/icons/watermarkroyal.png");
			     watermarkroyal=watermarkroyal.replace("\\", "\\\\");
			     //System.out.println("imgpath==="+imgpath);
				
			     param.put("vocno", voc); 
			     param.put("docno", docno); 
			     param.put("brhid", brhid); 
			     param.put("total", amount1);
			     param.put("amountwords", amountwords);          
			     param.put("imgpath", imgpath);   
			     param.put("imgpathfooter",imgpathfooter);
			     param.put("imgpathroyal", imgpathroyal);
			     param.put("watermark", watermarkroyal);
 			     param.put("imgpathroyaldesign", imgpathroyaldesign);
			     param.put("addition", addition);  
			     param.put("puser", session.getAttribute("USERNAME"));
			     param.put("printchk", printchk);
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(printpath));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);  
		        if(mail.trim().equalsIgnoreCase("1")){
		        	generateReportEmail(response, param, jasperReport, conn,docno,session,brhid,request);
		        }
		        else{
		        	generateReportPDF(response, param, jasperReport, conn);
		        }
		        
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
		    				  //System.out.println(Arrays.toString(bytes));
		    				  resp.reset();
		    					resp.resetBuffer();
		    					
		    					resp.setContentType("application/pdf");
		    					resp.setContentLength(bytes.length);
		    					ServletOutputStream ouputStream = resp.getOutputStream();
		    					ouputStream.write(bytes, 0, bytes.length);
		    					ouputStream.close();
		    					ouputStream.flush();
	}
	
	private void generateReportEmail (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn,String docno,HttpSession session,String brhid,HttpServletRequest request)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
	
		try{
			byte[] bytes = null;
		    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		    //System.out.println("Bytes:"+bytes.toString());
		    //System.out.println(Arrays.toString(bytes));
		  	Statement stmt=conn.createStatement();
		  	String fileName="",path="", formcode="EST",filepath=""; 
		  	//Deleting Existing Internal Attachments
		  	String strgetattach="select path from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999";
		  	ResultSet rsgetattach=stmt.executeQuery(strgetattach);
		  	while(rsgetattach.next()){
		  		String deletepath=rsgetattach.getString("path");
		  		File deletefile = new File(deletepath);
		  		deletefile.delete();
		  	}
		  	int deleteFileEntry=stmt.executeUpdate("delete from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999");
		  	
		  	String host="", port="", userName="", password="", recipient="", message="",docnos="1";
		  	String strSql1 = "select imgPath from my_comp";
			ResultSet rs1 = stmt.executeQuery(strSql1);
			while(rs1.next ()) {
				path=rs1.getString("imgPath");
			}
			//path=path.replace("\\", "/");
			String srno="";
			String strSql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"'";
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				srno=rs.getString("srno");
			}
			
			fileName = formcode+"-"+docno+"-"+srno+".pdf";
			filepath=path+ "\\attachment\\"+formcode+"\\"+fileName;

			File dir = new File(path+ "\\attachment\\"+formcode); 
			dir.mkdirs();
			JasperPrint print = JasperFillManager.fillReport(jasperReport, parameters);
		  	JasperExportManager.exportReportToPdfFile(print, filepath);	
			
		    CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
			stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtAttach.setString(1,formcode);
			stmtAttach.setString(2,docno);
			stmtAttach.setString(3,session.getAttribute("BRANCHID")==null?brhid:session.getAttribute("BRANCHID").toString());
			stmtAttach.setString(4,session.getAttribute("USERNAME").toString());
			stmtAttach.setString(5,path+"\\attachment\\"+formcode+"\\"+fileName);
			stmtAttach.setString(6,fileName);
			stmtAttach.setString(7,"");
			stmtAttach.setString(8,"999");
			stmtAttach.executeQuery();
			int no=stmtAttach.getInt("srNo");
			if(no<=0){
				System.out.println("Insert Error");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
}

}
