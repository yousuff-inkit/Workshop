package com.workshop.evaluation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsEvaluationAction extends ActionSupport{
    
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsEvaluationDAO DAO= new ClsEvaluationDAO();
	ClsEvaluationBean bean;
	
	private String txtcarmaker,txtmodel,txtyearofmake,txtchassisno,txtnoofcylinders,txtspecification,txtengineno,txttransmission,txtwarranty,txtmileage,txtinterior,txtexterior,txtevaluatedfor,txtremakrs,txtbillingamt,txtmarketprice,date,docno,masterdocno; 
	private String formdetailcode,cldocno;
	private String mode;
	private String hiddate;
	private String deleted;
	private String msg;
	public String getCldocno() {
		return cldocno;
	}
	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}
	public String getTxtcarmaker() {
		return txtcarmaker;
	}
	public void setTxtcarmaker(String txtcarmaker) {
		this.txtcarmaker = txtcarmaker;
	}
	public String getTxtmodel() {
		return txtmodel;
	}
	public void setTxtmodel(String txtmodel) {
		this.txtmodel = txtmodel;
	}
	public String getTxtyearofmake() {
		return txtyearofmake;
	}
	public void setTxtyearofmake(String txtyearofmake) {
		this.txtyearofmake = txtyearofmake;
	}
	public String getTxtchassisno() {
		return txtchassisno;
	}
	public void setTxtchassisno(String txtchassisno) {
		this.txtchassisno = txtchassisno;
	}
	public String getTxtnoofcylinders() {
		return txtnoofcylinders;
	}
	public void setTxtnoofcylinders(String txtnoofcylinders) {
		this.txtnoofcylinders = txtnoofcylinders;
	}
	public String getTxtspecification() {
		return txtspecification;
	}
	public void setTxtspecification(String txtspecification) {
		this.txtspecification = txtspecification;
	}
	public String getTxtengineno() {
		return txtengineno;
	}
	public void setTxtengineno(String txtengineno) {
		this.txtengineno = txtengineno;
	}
	public String getTxttransmission() {
		return txttransmission;
	}
	public void setTxttransmission(String txttransmission) {
		this.txttransmission = txttransmission;
	}
	public String getTxtwarranty() {
		return txtwarranty;
	}
	public void setTxtwarranty(String txtwarranty) {
		this.txtwarranty = txtwarranty;
	}
	public String getTxtmileage() {
		return txtmileage;
	}
	public void setTxtmileage(String txtmileage) {
		this.txtmileage = txtmileage;
	}
	public String getTxtinterior() {
		return txtinterior;
	}
	public void setTxtinterior(String txtinterior) {
		this.txtinterior = txtinterior;
	}
	public String getTxtexterior() {
		return txtexterior;
	}
	public void setTxtexterior(String txtexterior) {
		this.txtexterior = txtexterior;
	}
	public String getTxtevaluatedfor() {
		return txtevaluatedfor;
	}
	public void setTxtevaluatedfor(String txtevaluatedfor) {
		this.txtevaluatedfor = txtevaluatedfor;
	}
	public String getTxtremakrs() {
		return txtremakrs;
	}
	public void setTxtremakrs(String txtremakrs) {
		this.txtremakrs = txtremakrs;
	}
	public String getTxtbillingamt() {
		return txtbillingamt;
	}
	public void setTxtbillingamt(String txtbillingamt) {
		this.txtbillingamt = txtbillingamt;
	}
	public String getTxtmarketprice() {
		return txtmarketprice;
	}
	public void setTxtmarketprice(String txtmarketprice) {
		this.txtmarketprice = txtmarketprice;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getMasterdocno() {
		return masterdocno;
	}
	public void setMasterdocno(String masterdocno) {
		this.masterdocno = masterdocno;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {    
		this.hiddate = hiddate;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	private Map<String, Object> param=null;  
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	java.sql.Date dates ;                 
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		//System.out.println("IN ACTION "+mode);
		dates = commonDAO.changeStringtoSqlDate(getDate());       
	    
	       
		if(mode.equalsIgnoreCase("A")){
						int val=DAO.insert(dates,getMasterdocno(),getFormdetailcode(),getTxtbillingamt(),getTxtcarmaker(),getTxtchassisno(),getTxtengineno(),getCldocno(),getTxtexterior(),getTxtinterior(),getTxtmarketprice(),getTxtmileage(),getTxtmodel(),getTxtnoofcylinders(),getTxtremakrs(),getTxtspecification(),getTxttransmission(),getTxtwarranty(),getTxtyearofmake(),session,request);      
						//System.out.println("Action="+val);
						int vocno=(int)request.getAttribute("vocno");       
						if(val>0){    
						    setMasterdocno(val+"");
						    setDocno(vocno+"");       
							setData();    
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");         
							return "fail";
						}				
		}              
		else if(mode.equalsIgnoreCase("E")){
			int val=DAO.edit(dates,getMasterdocno(),getDocno(),getFormdetailcode(),getTxtbillingamt(),getTxtcarmaker(),getTxtchassisno(),getTxtengineno(),getCldocno(),getTxtexterior(),getTxtinterior(),getTxtmarketprice(),getTxtmileage(),getTxtmodel(),getTxtnoofcylinders(),getTxtremakrs(),getTxtspecification(),getTxttransmission(),getTxtwarranty(),getTxtyearofmake(),session,request);      
						//System.out.println("Action="+val);
						if(val>0){    
						    setMasterdocno(val+"");
						    setDocno(getDocno());       
							setData(); 
							setMsg("Updated Successfully");
						    return "success";
						}
						else{
							setData();
							setMsg("Not Updated");
							return "fail";
						}
		}  
		else if(mode.equalsIgnoreCase("D")){     
			int val=DAO.delete(dates,getMasterdocno(),getDocno(),getFormdetailcode(),getTxtbillingamt(),getTxtcarmaker(),getTxtchassisno(),getTxtengineno(),getCldocno(),getTxtexterior(),getTxtinterior(),getTxtmarketprice(),getTxtmileage(),getTxtmodel(),getTxtnoofcylinders(),getTxtremakrs(),getTxtspecification(),getTxttransmission(),getTxtwarranty(),getTxtyearofmake(),session,request);      
			//System.out.println("delete="+val);
					if(val>0){    
						    setMasterdocno(val+"");
						    setDocno(getDocno());      
							setData();    
							setDeleted("DELETED");
							setMsg("Successfully Deleted");
							return "success";
					}else{
							setData();
							setMsg("Not Deleted");
							return "fail";   
					}   
		}else if(mode.equalsIgnoreCase("View")){
				bean=DAO.getViewDetails(getMasterdocno());   
				
				setCldocno(bean.getCldocno());   
			    setDocno(bean.getDocno());
			    setHiddate(bean.getHiddate());
			    setTxtbillingamt(bean.getTxtbillingamt());
			    setTxtcarmaker(bean.getTxtcarmaker());
			    setTxtchassisno(bean.getTxtchassisno());
			    setTxtengineno(bean.getTxtengineno());
			    setTxtevaluatedfor(bean.getTxtevaluatedfor());     
			    setTxtexterior(bean.getTxtexterior());
			    setTxtinterior(bean.getTxtinterior());
			    setTxtmarketprice(bean.getTxtmarketprice());
			    setTxtmileage(bean.getTxtmileage());
			    setTxtmodel(bean.getTxtmodel());
			    setTxtnoofcylinders(bean.getTxtnoofcylinders());
			    setTxtremakrs(bean.getTxtremakrs());
			    setTxtspecification(bean.getTxtspecification());
			    setTxttransmission(bean.getTxttransmission());
			    setTxtwarranty(bean.getTxtwarranty());
			    setTxtyearofmake(bean.getTxtyearofmake());
				return "success";
			}   
			return "fail";
}

			public void setData() {         
				setTxtbillingamt(getTxtbillingamt());
				setTxtcarmaker(getTxtcarmaker());
				setTxtchassisno(getTxtchassisno());
				setTxtengineno(getTxtengineno());
				setTxtevaluatedfor(getTxtevaluatedfor());
				setTxtexterior(getTxtexterior());
				setTxtinterior(getTxtinterior());
				setTxtmarketprice(getTxtmarketprice());
				setTxtmileage(getTxtmileage());
				setTxtmodel(getTxtmodel());
				setTxtnoofcylinders(getTxtnoofcylinders());
				setTxtremakrs(getTxtremakrs());
				setTxtspecification(getTxtspecification());
				setTxttransmission(getTxttransmission());
				setTxtwarranty(getTxtwarranty());
				setTxtyearofmake(getTxtyearofmake());
				setCldocno(getCldocno());     
			}
			public String printAction() throws ParseException, SQLException{ 
				//System.out.println("IN PRINT");
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				String docno=request.getParameter("docno");  
				String branch=request.getParameter("branch");    
				String amount="",imgpath="",address="",comp="",tel="",fax="",brch="",location="",cmpname="",printedby="",vocno="",date="",aedamt="";      
				ResultSet rs=null,rss=null;      
			    HttpServletResponse response = ServletActionContext.getResponse();     
					 param = new HashMap();      
						Connection conn = null;
						Statement stmt =null;
					 try {	
						    conn = connDAO.getMyConnection();      
							stmt=conn.createStatement();
							ClsAmountToWords objamt=new com.common.ClsAmountToWords();   
							/*String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
							ResultSet rs123 = stmt.executeQuery(sql123);    
							while(rs123.next()){
								printedby=rs123.getString("USER_NAME");   
							}
							String sql="select c.imgpath,b.branchname,c.company,c.tel,c.fax,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
									+ "b.cmpid=c.doc_no where b.doc_no="+branch+" group by brhid";   
							ResultSet resultSet = stmt.executeQuery(sql);    
							while(resultSet.next()){
								comp=resultSet.getString("company");
								tel=resultSet.getString("tel");
								fax=resultSet.getString("fax");
								brch=resultSet.getString("branchname");
								location=resultSet.getString("location");             
							}*/
							String sql1="select  voc_no, date_format(date,'%d.%m.%Y') date,round(coalesce(marketprice,0),2) amount,format(coalesce(marketprice,0),2) amount2 from ws_evalm where status=3 and doc_no="+docno+"";   
							//System.out.println("print main--->>>"+sql1); 
							ResultSet rs1 = stmt.executeQuery(sql1);    
							while(rs1.next()){
								vocno=rs1.getString("voc_no"); 
								date=rs1.getString("date"); 
								aedamt=rs1.getString("amount");
								amount=rs1.getString("amount2");
							}    
							//String sqlstr="select 'Car Maker (Brand)' descs,carmaker detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Model' descs,model detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Year of Make' descs,yearofmake detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Chassis Number' descs,chassisno detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Number of Cylinders' descs,cylinders detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Engine Number & Capacity' descs,engineno detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Transmission' descs,transmission detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Specification' descs,specification detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Remaining dealer Warranty' descs,warranty detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Mileage' descs,mileage detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Interior Color & Condition' descs,interior detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Exterior Color & Condition' descs,exterior detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Evaluated Market Price' descs,format(marketprice,2) detail from ws_evalm where status=3 and doc_no="+docno+" union all select 'Other Remarks' descs,remarks detail from ws_evalm where status=3 and doc_no="+docno+"";             
							String sqlstr="select a.* from(select 'Car Maker (Brand)' descs,carmaker detail,doc_no from ws_evalm where status=3  union all select 'Model' descs,model detail,doc_no from ws_evalm where status=3  union all select 'Year of Make' descs,yearofmake detail,doc_no from ws_evalm where status=3  union all select 'Chassis Number' descs,chassisno detail,doc_no from ws_evalm where status=3  union all select 'Number of Cylinders' descs,cylinders detail,doc_no from ws_evalm where status=3  union all select 'Engine Number & Capacity' descs,engineno detail,doc_no from ws_evalm where status=3  union all select 'Transmission' descs,transmission detail,doc_no from ws_evalm where status=3  union all select 'Specification' descs,specification detail,doc_no from ws_evalm where status=3  union all select 'Remaining dealer Warranty' descs,warranty detail,doc_no from ws_evalm where status=3  union all select 'Mileage' descs,mileage detail,doc_no from ws_evalm where status=3  union all select 'Interior Color & Condition' descs,interior detail,doc_no from ws_evalm where status=3  union all select 'Exterior Color & Condition' descs,exterior detail,doc_no from ws_evalm where status=3  union all select 'Evaluated Market Price' descs,format(marketprice,2) detail,doc_no from ws_evalm where status=3  union all select 'Other Remarks' descs,remarks detail,doc_no from ws_evalm where status=3)a where a.doc_no="+docno+"";
							imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");         
					        imgpath=imgpath.replace("\\", "\\\\");      
					        //String user=session.getAttribute("USERNAME").toString();
					        System.out.println("in...."+imgpath);
					        String aedamtdesc=objamt.convertAmountToWords(aedamt);
					        param.put("imgpath",imgpath);
					        param.put("date",date);   
					        param.put("docno",vocno);
					        param.put("sqlstr",sqlstr);  
					        param.put("aedamtdesc",aedamtdesc); 
					        param.put("amount",amount);    
					        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/workshop/evaluation/evaluationprint.jrxml"));  
		  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);   
		  	                generateReportPDF(response, param, jasperReport, conn);        
			               } catch (Exception e) {         

			                 e.printStackTrace();
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