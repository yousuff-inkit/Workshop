package workshopapp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
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
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
import com.workshop.gateinpassmaster.ClsGateInPassBean;
import com.workshop.gateinpassmaster.ClsGateInPassDAO;

public class ClsWorkshopAppAction extends ActionSupport{
	ClsWorkshopAppDAO dao=new ClsWorkshopAppDAO();
	
	private String username,password,mode,msg,docno;
	private Map<String, Object> param=null;
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	
	public String saveAction()throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
//		System.out.println("====== "+getUsername()+"==="+getPassword()+"===="+mode);
		String appredirect=request.getParameter("appredirect")==null?"":request.getParameter("appredirect").toString();
		if(appredirect.trim().equalsIgnoreCase("1")){
			JSONObject objuserdata=dao.getLoggedUserData(session,request);
			setMode(objuserdata.getString("mode"));
			setUsername(objuserdata.getString("username"));
			setPassword(objuserdata.getString("password"));
		}
		String mode=getMode();
		if(mode.equalsIgnoreCase("A")){
			boolean status=dao.userLogin(getUsername(),getPassword(),session,request);
			setMode(getMode());
			setUsername(getUsername());
			setPassword(getPassword());
			if(status){
				return "success";
			}
			else{
				return "fail";
			}
		}
		
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  int doc=Integer.parseInt(request.getParameter("docno"));
		  ClsGateInPassBean bean=new ClsGateInPassBean();
		  ClsGateInPassDAO gatedao=new ClsGateInPassDAO();
		  ClsCommon objcommon=new ClsCommon();
		  ClsConnection objconn=new ClsConnection();
		 String  formcode= request.getParameter("formdetailcode");
		 ArrayList<String> uploadpicsarray=dao.getUploadPicsData(doc);
		 bean=gatedao.getPrint(doc,request,formcode);
		 
		 System.out.println("hiiiiiiiii");
	  
      if(objcommon.getPrintPath2(formcode).contains(".jrxml")==true)
		   {
		     HttpServletResponse response = ServletActionContext.getResponse();
             Connection conn = null;
		    			 try {
		    				 
		    				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/workshoplogo.png");
		    			     imgpath=imgpath.replace("\\", "\\\\");
		    			     String carimg=request.getSession().getServletContext().getRealPath("/icons/carinoutimg.png");
		    			     carimg=carimg.replace("\\", "\\\\");
		    			     String signatureimg=request.getSession().getServletContext().getRealPath("/icons/carinoutimg.png");
		    			     signatureimg=signatureimg.replace("\\", "\\\\");
		    			     System.out.println("Signature IMg:"+signatureimg);
		    				    param = new HashMap();
		    			        conn = objconn.getMyConnection();
		    			        param.put("docno", doc); 
		    			        param.put("compname",bean.getLblcompname());
		    			        param.put("headerimg", imgpath);
		    			        param.put("carimg", carimg);
		    			        param.put("puser", session.getAttribute("USERNAME"));
		    			        param.put("signature", signatureimg);
								int uploadpic1status=0,uploadpic2status=0,uploadpic3status=0,uploadpic4status=0,uploadpic5status=0,
		    			        	uploadpic6status=0,uploadpic7status=0,uploadpic8status=0;
		    			        for(int i=0,j=1;i<uploadpicsarray.size();i++,j++){
		    			        	if(j<=8){
		    			        		param.put("uploadpic"+j,uploadpicsarray.get(i));
		    			        		if(j==1){
		    			        			uploadpic1status=1;
		    			        		}
		    			        		else if(j==2){
		    			        			uploadpic2status=1;
		    			        		}
		    			        		else if(j==3){
		    			        			uploadpic3status=1;
		    			        		}
		    			        		else if(j==4){
		    			        			uploadpic4status=1;
		    			        		}
		    			        		else if(j==5){
		    			        			uploadpic5status=1;
		    			        		}
		    			        		else if(j==6){
		    			        			uploadpic6status=1;
		    			        		}
		    			        		else if(j==7){
		    			        			uploadpic7status=1;
		    			        		}
		    			        		else if(j==8){
		    			        			uploadpic8status=1;
		    			        		}
		    			        		
		    			        	}
		    			        }
		    			        
		    			        param.put("uploadpic1status",uploadpic1status+"");
		    			        param.put("uploadpic2status",uploadpic2status+"");
		    			        param.put("uploadpic3status",uploadpic3status+"");
		    			        param.put("uploadpic4status",uploadpic4status+"");
		    			        param.put("uploadpic5status",uploadpic5status+"");
		    			        param.put("uploadpic6status",uploadpic6status+"");
		    			        param.put("uploadpic7status",uploadpic7status+"");
		    			        param.put("uploadpic8status",uploadpic8status+"");

		    			
		    			       			      
		    			      
		    	JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath2(formcode)));
		        JasperReport jasperReport = JasperCompileManager.compileReport(design);
		        //getting company corresponding config
		        String  strmailconfig="select method from gl_config where field_nme='GIPMail'";
		        ResultSet rsmailconfig=conn.createStatement().executeQuery(strmailconfig);
		        int mailconfig=0;
		        while(rsmailconfig.next()){
		        	mailconfig=rsmailconfig.getInt("method");
		        }
		        
		        String remail="",bccemail="",print="1",subject="Workshop GIP";
		        String strgetemail="select coalesce(ac.mail1,gip.email) clientemail from ws_gateinpass gip left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM' where gip.doc_no="+doc;
		        ResultSet rsgetemail=conn.createStatement().executeQuery(strgetemail);
		        while(rsgetemail.next()){
		        	remail=rsgetemail.getString("clientemail");
		        }
		        if(mailconfig==1){
		        	//PAL
		        	subject="PAL Auto - Vehicle Acknowledgement";
		        }
		        generateReportPDF(response, param, jasperReport, conn);
		        if(!remail.trim().equalsIgnoreCase("")){
		        	generateReportEmail(param,jasperReport, conn,remail,bccemail,print,subject,doc+"",session);
		        }
		        
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
		    	
		    	private void generateReportEmail (Map parameters, JasperReport jasperReport, Connection conn, String remail,String bccemail, String print, String subject,String insp,HttpSession session)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  		  byte[] bytes = null;
		          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		          EmailProcess ep=new EmailProcess();
		      	Statement stmtrr=conn.createStatement();
		      	  
		      	String fileName="",path="", formcode="GIP",filepath="",path1=""; 
		      	//getting company corresponding config
		        String  strmailconfig="select method from gl_config where field_nme='GIPMail'";
		        ResultSet rsmailconfig=conn.createStatement().executeQuery(strmailconfig);
		        int mailconfig=0;
		        while(rsmailconfig.next()){
		        	mailconfig=rsmailconfig.getInt("method");
		        }
		      	String host="", port="", userName="", password="", recipient="", message="please find the attached Workshop GIP details",docnos="1";
		      	if(mailconfig==1){
		      		//PAL
		      		message="Dear Sir/Madam,<br><br>Please find attached your vehicle acknowledgment slip.<br>Have a nice day!<br><br><br>Regards,<br><br>Team PAL Auto";
		      	}
		      	String strSql1 = "select imgPath from my_comp";

		    		ResultSet rs1 = stmtrr.executeQuery(strSql1);
		    		while(rs1.next ()) {
		    			path1=rs1.getString("imgPath");
		    		}
		    		path=path1.replace("\\", "/");
		    		String userid=session.getAttribute("USERID")==null?"1":session.getAttribute("USERID").toString();
		    		String strSql3 = "select mail,mailpass,smtpserver,smtphostport from my_user where doc_no='"+userid+"'";
		  		ResultSet rs3 = stmtrr.executeQuery(strSql3);
		  		while(rs3.next ()) {
		  			userName=rs3.getString("mail");
		  			port=rs3.getString("smtphostport");
		  			host=rs3.getString("smtpserver");
		  			password=ClsEncrypt.getInstance().decrypt(rs3.getString("mailpass"));
		  		}
		    		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		  		java.util.Date date = new java.util.Date();
		  		String currdate=dateFormat.format(date);
		  		
		  		
		  		DateFormat dateFormat2 = new SimpleDateFormat("dd_MM_yyyy");
		  		java.util.Date date2 = new java.util.Date();
		  		String currdate2=dateFormat2.format(date2);
		  		//subject="Fleet status Epic Rent a car "+currdate2+" 8:00";
		  		subject=subject+"  "+currdate2;
		    		fileName = "WorkshopGIP"+currdate+".pdf";
		    		filepath=path+ "/attachment/"+formcode+"/"+fileName;

		    		File dir = new File(path+ "/attachment/"+formcode); 
		    		dir.mkdirs();
		    		
		    		CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
		    		
		    		stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
		    		System.out.println("CALL fileAttach");
		    		stmtAttach.setString(1,"VIP");
		    		stmtAttach.setString(2,insp);
		    		stmtAttach.setString(3,"1");
		    		stmtAttach.setString(4,"1");
		    		stmtAttach.setString(5,path+ "/attachment/"+formcode+"/"+fileName);
		    		stmtAttach.setString(6,fileName);
		    		stmtAttach.setString(7,"print");
		    		stmtAttach.setString(8,"1");
		    		stmtAttach.executeQuery();
		    		int no=stmtAttach.getInt("srNo");
		    		
		    		FileOutputStream fos = new FileOutputStream(filepath);
		      	fos.write(bytes);
		      	fos.flush();  
		      	fos.close();
		      	
		      	File saveFile=new File(filepath);
		  		SendEmailAction sendmail= new SendEmailAction();
		  		//String[] remails=remail.split(",");
		  		
		  		ep.sendEmailwithpdfBCC(host, port, userName, password,remail, "",bccemail,subject, message, saveFile,docnos);
		             
		    }
	
}
