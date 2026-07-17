package com.workshop.setup.jobmaster;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobMasterAction {
	
	private String date, cmbjobtype, description,hidcmbjobtype,stdrateperhr,stdhr;
	private String mode,msg,deleted,formdetailcode;
    private int docno,jobgridlength;
	ClsCommon objcom=new ClsCommon();
	ClsConnection objconn= new ClsConnection();
	ClsJobMasterDAO jmdao=new ClsJobMasterDAO();
	
	
	
	
	public int getJobgridlength() {
		return jobgridlength;
	}

	public void setJobgridlength(int jobgridlength) {
		this.jobgridlength = jobgridlength;
	}

	public String getStdrateperhr() {
		return stdrateperhr;
	}

	public void setStdrateperhr(String stdrateperhr) {
		this.stdrateperhr = stdrateperhr;
	}

	public String getStdhr() {
		return stdhr;
	}

	public void setStdhr(String stdhr) {
		this.stdhr = stdhr;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getHidcmbjobtype() {
		return hidcmbjobtype;
	}

	public void setHidcmbjobtype(String hidcmbjobtype) {
		this.hidcmbjobtype = hidcmbjobtype;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getCmbjobtype() {
		return cmbjobtype;
	}

	public void setCmbjobtype(String cmbjobtype) {
		this.cmbjobtype = cmbjobtype;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	

	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		java.sql.Date sqldate=null,sqlindate=null;
		//if(!mode.equalsIgnoreCase("view")&& !mode.equalsIgnoreCase("D")){
			
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcom.changeStringtoSqlDate(getDate());
			}
		//}
		//if(!mode.equalsIgnoreCase("view")){
			/*java.sql.Date sqldate=null,sqlindate=null;
			if(getDate()!=null && !getDate().equalsIgnoreCase("")){
				sqldate=objcom.changeStringtoSqlDate(getDate());
			}
			*/
			
			if(mode.equalsIgnoreCase("A")){
				
				Map<String, String[]> requestParams = request.getParameterMap();
				ArrayList<String> jobarray= new ArrayList<String>();
				for(int i=0;i<getJobgridlength();i++){
					String temp1=requestParams.get("jobgriddesc"+i)[0];
					jobarray.add(temp1);
				}
				
				int insertval=jmdao.insert(getCmbjobtype(),getDescription(),sqldate,getMode(),getFormdetailcode(),getStdhr(),getStdrateperhr(),jobarray,session, request);
				if(insertval>0){
					//setData(insertval,sqldate,sqlindate);
					setDocno(insertval);
					setHidcmbjobtype(getCmbjobtype());
					setDate(sqldate.toString());
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					//setData(0,sqldate,sqlindate);
					setDocno(insertval);
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Not Saved");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("E")){
				
				Map<String, String[]> requestParams = request.getParameterMap();
				ArrayList<String> jobarray= new ArrayList<String>();
				for(int i=0;i<getJobgridlength();i++){
					String temp1=requestParams.get("jobgriddesc"+i)[0];
					jobarray.add(temp1);
				}
				
				boolean status=jmdao.edit(getDocno(),getCmbjobtype(),getDescription(),sqldate,getMode(),getFormdetailcode(),getStdhr(),getStdrateperhr(),jobarray,
						session,request);
				if(status){
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Updated Successfully");
					return "success";
				}
				else{
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Not Updated");
					return "fail";
				}
			}
			
			else if(mode.equalsIgnoreCase("D")){

				boolean status=jmdao.delete(getDocno(),getMode(),session,request);
				if(status){
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					//setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					return "success";
					
				}
				else{
					//setData(Integer.parseInt(getDocno()),sqldate,sqlindate);
					setDocno(getDocno());
					//setDate(sqldate.toString());
					setHidcmbjobtype(getCmbjobtype());
					setMsg("Not Deleted");
					return "fail";
				}
			}
			
		//}
	return "fail";
	
		
	}	

	
	

}
