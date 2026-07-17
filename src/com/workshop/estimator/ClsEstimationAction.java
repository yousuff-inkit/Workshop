package com.workshop.estimator;

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
import com.opensymphony.xwork2.ActionSupport;
import com.workshop.wsestimation.ClsWSEstimationBean;
import com.workshop.wsestimation.ClsWSEstimationDAO;

public class ClsEstimationAction extends ActionSupport{

	ClsEstimationDAO estimationdao=new ClsEstimationDAO();
	ClsCommon objcommon=new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsEstimationBean been=new ClsEstimationBean();
	private String docno,vocno,date,gatedocno,gatevocno,gateuserdetails,gatevehicledetails,sparepartstotal,labourtotal,discount,esttotal,mode,msg,deleted,brchName,formdetailcode,servicestotal,servicesdiscount,netservices,hidchklumsum,lumsumamount;
	private int complaintgridlength,sparePartsNewGridlength,labourcostgridlength;
	private String header,notes,internalremarks,chkservicelumsum,hidchkservicelumsum,servicelumsumamt,chkrandomlumsum,hidchkrandomlumsum,randomlumsumamt;
	private String estimatedays,gipdatetime;
	private String gipclaimno,gipinsurcomp;
	private String brhid;
	private String sparetotal,sparediscount,netspare,clientdet,vehicledet,txtdesc;   
	
	public String getClientdet() {
		return clientdet;
	}
	public void setClientdet(String clientdet) {
		this.clientdet = clientdet;
	}
	public String getVehicledet() {
		return vehicledet;
	}
	public void setVehicledet(String vehicledet) {
		this.vehicledet = vehicledet;
	}
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
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
	    
	    //System.out.println("gip=="+gipnoo);
	    /*System.out.println("===="+id+"mode--"+modee+"gipno---"+gipnoo+"docnooo"+docno);*/
	    if(id.equalsIgnoreCase("2")){
	    	
	    mode=modee;
	    
		if(mode.equalsIgnoreCase("view")){
	    int doc_no=(Integer.parseInt(docno));
	    int gip_no=(Integer.parseInt(gipnoo));
	 	been=estimationdao.viewdetails(doc_no,gip_no);
	 		setTxtdesc(been.getTxtdesc());  
	 		setClientdet(been.getClientdet());
	 		setVehicledet(been.getVehicledet());  
	 		setDate(been.getDate());
	 		setBrhid(been.getBrhid());
	 		//System.out.println("Branch Set:"+getBrhid());
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
				int insertval=estimationdao.insert(getGatedocno(),getSparepartstotal(),getLabourtotal(),getDiscount(),getEsttotal(),sqldate,
						sparepartsarray,labourcostarray,session,request,mode,getFormdetailcode(),getBrchName(),getServicesdiscount(),
						getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount(),getHeader(),getNotes(),getInternalremarks(),
						getHidchkservicelumsum(),getServicelumsumamt(),getHidchkrandomlumsum(),getRandomlumsumamt(),getEstimatedays(),
						getGipdatetime(),getGipclaimno(),getSparetotal(),getSparediscount(),getNetspare(),getClientdet(),getVehicledet(),getTxtdesc());
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
						getServicesdiscount(),getServicestotal(),getNetservices(),getHidchklumsum(),getLumsumamount(),getHeader(),getNotes(),
						getInternalremarks(),getHidchkservicelumsum(),getServicelumsumamt(),getHidchkrandomlumsum(),getRandomlumsumamt(),
						getEstimatedays(),getGipdatetime(),getGipclaimno(),getSparetotal(),getSparediscount(),getNetspare(),getClientdet(),getVehicledet(),getTxtdesc());
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
		  //System.out.println("In Team 21 print Action");  
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  String voc=request.getParameter("estDocno");
		  String docno=request.getParameter("docno");  
		  String brhid=request.getParameter("branch");
		  String gatedocno=request.getParameter("gatedocno");
		  String addition=request.getParameter("addition");
		  String withvat=request.getParameter("withvat");
		  String printchk=request.getParameter("printchk"); 
		  //System.out.println("printchk====="+printchk); 
		  //been=estimationdao.getPrint(voc);     
		  Double amount=0.0,lumsumlab=0.0,lumsumpart=0.00,lumsumpart1=0.00,vatamt=0.00,sublet=0.00,consumables=0.0,discount=0.0,discount1=0.0,discount2=0.0,total1=0.00,nettotal1=0.00;     
		  String amount1="",amountwords="",path1="",header="",notes="",total="0.00",nettotal="0.00";
		  int chklab=0,chkpart=0;
		   
		  if(objcommon.getPrintPath("ESR").contains(".jrxml")==true){
			 //System.out.println("In print Action"); 
		     HttpServletResponse response = ServletActionContext.getResponse();
             Connection conn = null;
		    		
             try{
			          	     conn = connDAO.getMyConnection();
				    	     Statement stmt = conn.createStatement();
				    	     ClsAmountToWords ns=new ClsAmountToWords();            
				    	     param = new HashMap();
				    	     String strsql="select round(sum(amount),2) amount,format(sum(amount),2) amount1 from(select lab.total amount,1 gp from ws_estimationlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no  where m.status=3 and lab.rdocno='"+docno+"' union all select approvedvalue amount,1 gp from ws_estimationspare where rdocno='"+docno+"')a group by gp";  
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
				    	    /* String strsql3="select a.* from(select (select round(sum(lab.total),2) amount from ws_estimationlabour lab where lab.rdocno='"+docno+"' and lab.addition='"+addition+"' group by lab.rdocno) labsum,(select round(sum(approvedvalue),2) amount from ws_estimationspare where rdocno='"+docno+"' and addition='"+addition+"'  group by rdocno) partsum)a";
                             System.out.println("strsql3="+strsql3);  
                             ResultSet rs3=stmt.executeQuery(strsql3);          
				    	     while(rs3.next()){         
				    	    	 lumsumlab1=rs3.getDouble("labsum"); 
				    	    	 lumsumpart1=rs3.getDouble("partsum");          
				    	     }*/         
				    	     String strsql4="select '' header,'' notes,round(coalesce(m.chkservicelumsum,0),2) chkservicelumsum,round(coalesce(m.servicelumsumamt,0),2) lumsumlab,round(coalesce(m.chklumsum,0),2) chklumsum,round(coalesce(m.lumsumamount,0),2) lumsumparts from ws_estimationm m where m.doc_no='"+docno+"'"; 
				    	     //System.out.println("strsql4="+strsql4);       
                             ResultSet rs4=stmt.executeQuery(strsql4);            
				    	     while(rs4.next()){         
				    	    	 header=rs4.getString("header");
				    	    	 notes=rs4.getString("notes");   
				    	     }
				    	     String strsql9 ="select sum(approvedvalue) partstotal from ws_estimationspare where rdocno='"+docno+"' and addition='"+addition+"'and description<>'Consumables'";
				    	     //System.out.println("strsql9="+strsql9);       
                             ResultSet rs9=stmt.executeQuery(strsql9);            
				    	     while(rs9.next()){         
				    	    	 lumsumpart=rs9.getDouble("partstotal"); 
				    	     }
				    	     param.put("header", header);
				    	     param.put("notes", notes);  
				    	     
				    	     String strsql5="select (select round(coalesce(approved,0),2) from ws_estimationspareamt where description='Total Parts Cost' and rdocno='"+docno+"') partstotal,(select round(coalesce(approved,0),2) from ws_estimationspareamt where description='Total Services Cost' and rdocno='"+docno+"') servicetotal,(select round(coalesce(approved,0),2) from ws_estimationspareamt where description='Sub Total' and rdocno='"+docno+"') subtotal,(select round(coalesce(approved,0),2) from ws_estimationspareamt where description='VAT' and rdocno='"+docno+"') vatamt,(select round(coalesce(approved,0),2) from ws_estimationspareamt where description='Net Total with VAT' and rdocno='"+docno+"') nettotal";
				    	     //System.out.println("strsql5="+strsql5);     
                             ResultSet rs5=stmt.executeQuery(strsql5);             
				    	     while(rs5.next()){   
				    	    	 lumsumpart1=rs5.getDouble("partstotal");      
				    	    	 lumsumlab=rs5.getDouble("servicetotal"); 
				    	    	 total=rs5.getString("subtotal");   
				    	    	 vatamt=rs5.getDouble("vatamt"); 
				    	    	 nettotal=rs5.getString("nettotal"); 
				    	    	 total1=rs5.getDouble("subtotal");   
				    	    	 nettotal1=rs5.getDouble("nettotal"); 
				    	     }
				    	     
				    	     /* TEAM 21*/  
				    	     String strsqls1="select sum(amount) amount from(select lab.total amount,upper(lab.strjobtype) type from ws_estimationlabour lab where lab.rdocno='"+docno+"' and upper(lab.strjobtype)='SUBLET')a group by a.type";
				    	     //System.out.println("sublet ="+strsqls1);
				    	     ResultSet rss1=stmt.executeQuery(strsqls1);            
				    	     while(rss1.next()){         
				    	    	 sublet=rss1.getDouble("amount");    
				    	     }
				    	     String strsqls4="select sum(amount) amount from(select lab.approvedvalue amount,upper(description) type from ws_estimationspare lab where lab.rdocno='"+docno+"' and upper(description)='CONSUMABLES')a group by a.type";
				    	     //System.out.println("Consumables ="+strsqls4);
				    	     ResultSet rss4=stmt.executeQuery(strsqls4); 
				    	     
				    	     while(rss4.next()){         
				    	    	 consumables=rss4.getDouble("amount");      
				    	     }
				    	     String sqldis=" select coalesce(discount,0)+coalesce(servicesdiscount,0)+coalesce(sparediscount,0) discount from ws_estimationm where doc_no='"+docno+"'";
				    	     //System.out.println("discount ="+sqldis);   
				    	     ResultSet rsdis=stmt.executeQuery(sqldis);            
				    	     while(rsdis.next()){         
				    	    	 discount=rsdis.getDouble("discount");      
				    	     }
				    	     String sqldis2=" select coalesce(discount,0)+coalesce(sparediscount,0) discount2 from ws_estimationm where doc_no='"+docno+"'";
				    	     //System.out.println("discount ="+sqldis2);   
				    	     ResultSet rsdis2=stmt.executeQuery(sqldis2);            
				    	     while(rsdis2.next()){         
				    	    	 discount2=rsdis2.getDouble("discount2");      
				    	     }
				    	     String sqldis1=" select coalesce(discount,0)+coalesce(servicesdiscount,0) discount1 from ws_estimationm where doc_no='"+docno+"'";
				    	     //System.out.println("discount ="+sqldis1);   
				    	     ResultSet rsdis1=stmt.executeQuery(sqldis1);            
				    	     while(rsdis1.next()){         
				    	    	 discount1=rsdis1.getDouble("discount1");      
				    	     }
				    	     param.put("sumofsublet", sublet);  
				    	     //param.put("sumofconsumable", consumables-discount1);  
				    	     param.put("sumofconsumable", consumables);
				    	     double servicesum=(lumsumlab-sublet)+discount1;
				    	    param.put("sumofservice", (lumsumlab-sublet)+discount1);
				    	     //param.put("sumofservice",lumsumlab);
				    	   //param.put("sumofparts", lumsumpart-consumables);
				    	     param.put("sumofparts", lumsumpart);
				    	     param.put("discount", discount); 
				    	     param.put("discount1",discount1);  
				    	    
				    	     /* TEAM 21*/  
				    	       
				    	     param.put("sublet", sublet);   
				    	     param.put("lumsumlabour", lumsumlab-sublet);  
				    	     param.put("lumsumparts", lumsumpart);  
				    	     double subtotal=(sublet+consumables+servicesum+lumsumpart)-discount;
				    	    // param.put("totallumsum", (total1-lumsumpart1)+lumsumpart);  
				    	     double vatamount=subtotal*0.05;
				    	     ClsCommon objcommon=new ClsCommon();
				    	     vatamount=objcommon.Round(vatamount, 2);
				    	     param.put("totallumsum", subtotal);
				    	     param.put("vatamt", vatamount);
				    	     //param.put("vatamt",vatamt);
				    	     //param.put("nettotal", (nettotal1-lumsumpart1)+lumsumpart); 
				    	     param.put("nettotal", subtotal+vatamount); 
				    	     //System.out.println("-------sublet---------"+ sublet);
				    	     //System.out.println("-------consumables---------"+ sublet);
				    	     //System.out.println("-------servicesum---------"+ sublet);
				    	     //System.out.println("-------subtotal---------"+ sublet);
				    	     //System.out.println("-------subtotal---------"+ subtotal);
				    	     //System.out.println("---------discount-------"+discount);
				    	     String branch="",compname="",compaddress="",comptel="",compfax="",location="";       
				    	     String companysql = "select c.company,b.address,b.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno,b.doc_no from ws_estimationm r left join my_brch b on  "
				 					+ "r.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no left join my_locm l on l.brhid=b.doc_no left join (select min(lo.loc) loc,lo.loc_name, "
				 					+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"   
				 					+ docno + "' ";  
				 			 //System.out.println("----------------"+companysql);
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
					         if(withvat.equalsIgnoreCase("1")){   
					        	 amountwords=ns.convertAmountToWords(nettotal);     
					        	 printpath=objcommon.getPrintPath2("ESR");
					         }else{
					        	 amountwords=ns.convertAmountToWords(total); 
					        	 printpath=objcommon.getPrintPath("ESR");          
					         }
                              
                            // System.out.println(amount1+"==="+amountwords);     
		    				 String imgpath=request.getSession().getServletContext().getRealPath(path1);     
		    			     imgpath=imgpath.replace("\\", "\\\\");
		    			     //System.out.println("imgpath==="+imgpath);
		    				
		    			     param.put("vocno", voc); 
		    			     param.put("docno", docno); 
		    			     param.put("brhid", brhid); 
		    			     param.put("total", amount1);
		    			     param.put("amountwords", amountwords);          
		    			     param.put("imgpath", imgpath);   
		    			     param.put("addition", addition);  
		    			     param.put("puser", session.getAttribute("USERNAME"));
		    			     param.put("printchk", printchk);
		    			    // System.out.println("printpath--->>>"+printpath);
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(printpath)); 
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
