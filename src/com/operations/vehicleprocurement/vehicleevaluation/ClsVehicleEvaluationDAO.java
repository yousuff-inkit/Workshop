package com.operations.vehicleprocurement.vehicleevaluation;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicleprocurement.purchaserequest.ClsvehpurchasereqBean;
import com.operations.vehicleprocurement.vehicleevaluation.ClsVehicleEvaluationBean;


public class ClsVehicleEvaluationDAO
{
	
	ClsConnection ClsConnection=new ClsConnection();



	Connection conn;
	
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsVehicleEvaluationBean bean = new ClsVehicleEvaluationBean();
	
	public JSONArray clientDetailsSearch() throws SQLException {
		
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		
		ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	

	public int insert(Date sqlStartDate, int cldocno,int Carval,String Cmbbrand,String Model,int Cmbyom,int Cmbcolor,
			int Cmbinterior,int Cmbtransition,String Txtchno,String Txtengno,int Txtodno,int Cmbcondition,HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request)  throws SQLException {
		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon ClsCommon=new ClsCommon();
		
		try{
			int docno;
		
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtvehev= conn.prepareCall("{call vahevaluationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtvehev.registerOutParameter(17, java.sql.Types.INTEGER);
			
			stmtvehev.setDate(1,sqlStartDate);
			stmtvehev.setInt(2,cldocno);
			stmtvehev.setInt(3,Carval);
			stmtvehev.setString(4,Cmbbrand);
			stmtvehev.setString(5,Model);
			stmtvehev.setInt(6,Cmbyom);
			stmtvehev.setInt(7,Cmbcolor);
			stmtvehev.setInt(8,Cmbinterior);
			stmtvehev.setInt(9,Cmbtransition);
			stmtvehev.setString(10,formdetailcode);
			stmtvehev.setString(11,Txtchno);
			stmtvehev.setString(12,Txtengno);
			stmtvehev.setInt(13,Txtodno);
			stmtvehev.setInt(14,Cmbcondition);
			stmtvehev.setString(15,session.getAttribute("USERID").toString());
			stmtvehev.setString(16,session.getAttribute("BRANCHID").toString());
			stmtvehev.setString(18,mode);
			stmtvehev.executeQuery();
			docno=stmtvehev.getInt("docNo");	
			request.setAttribute("docno", docno);
			if(docno<=0)
			{
				conn.close();
				return 0;
				
				
			}
			
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtvehev.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
	


	public boolean edit(int docno,Date sqlStartDate, int cldocno,int Carval,String Cmbbrand,String Model,int Cmbyom,int Cmbcolor,
			int Cmbinterior,int Cmbtransition,String Txtchno,String Txtengno,int Txtodno,int Cmbcondition,HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request) throws SQLException {
		
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtvehev= conn.prepareCall("{call vahevaluationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			//System.out.println(stmtvehev);
			stmtvehev.setInt(17,docno);
			stmtvehev.setDate(1,sqlStartDate);
			stmtvehev.setInt(2,cldocno);
			stmtvehev.setInt(3,Carval);
			stmtvehev.setString(4,Cmbbrand);
			stmtvehev.setString(5,Model);
			stmtvehev.setInt(6,Cmbyom);
			stmtvehev.setInt(7,Cmbcolor);
			stmtvehev.setInt(8,Cmbinterior);
			stmtvehev.setInt(9,Cmbtransition);
			stmtvehev.setString(10,formdetailcode);
			stmtvehev.setString(11,Txtchno);
			stmtvehev.setString(12,Txtengno);
			stmtvehev.setInt(13,Txtodno);
			stmtvehev.setInt(14,Cmbcondition);
			stmtvehev.setString(15,session.getAttribute("USERID").toString());
			stmtvehev.setString(16,session.getAttribute("BRANCHID").toString());
			stmtvehev.setString(18,mode);
			
			int aaa=stmtvehev.executeUpdate();
					
			//System.out.println(aaa);
			
						
			if (aaa > 0) {
				conn.commit();
				stmtvehev.close();
				conn.close();
				//System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno,Date sqlStartDate, int cldocno,int Carval,String Cmbbrand,String Model,int Cmbyom,int Cmbcolor,
			int Cmbinterior,int Cmbtransition,String Txtchno,String Txtengno,int Txtodno,int Cmbcondition,HttpSession session, String mode,
			String formdetailcode, HttpServletRequest request) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtvehev= conn.prepareCall("{call vahevaluationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtvehev.setInt(17,docno);
			stmtvehev.setDate(1,sqlStartDate);
			stmtvehev.setInt(2,cldocno);
			stmtvehev.setInt(3,Carval);
			stmtvehev.setString(4,Cmbbrand);
			stmtvehev.setString(5,Model);
			stmtvehev.setInt(6,Cmbyom);
			stmtvehev.setInt(7,Cmbcolor);
			stmtvehev.setInt(8,Cmbinterior);
			stmtvehev.setInt(9,Cmbtransition);
			stmtvehev.setString(10,formdetailcode);
			stmtvehev.setString(11,Txtchno);
			stmtvehev.setString(12,Txtengno);
			stmtvehev.setInt(13,Txtodno);
			stmtvehev.setInt(14,Cmbcondition);
			stmtvehev.setString(15,session.getAttribute("USERID").toString());
			stmtvehev.setString(16,session.getAttribute("BRANCHID").toString());
			stmtvehev.setString(18,mode);
			
			int aaa=stmtvehev.executeUpdate();
					
			//System.out.println(aaa);
			
						
			if (aaa > 0) {
				conn.commit();
				stmtvehev.close();
				conn.close();
				//System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
	 
	public  JSONArray searchmaster(HttpSession session,String docnoss,String client,String datess,String chno,String aa) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	  return RESULTDATA;
	     }
	    String brcid=session.getAttribute("BRANCHID").toString();
	    
	    
	    java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and v.doc_no like '%"+docnoss+"%'";
    	}
    	if((!(client.equalsIgnoreCase(""))) && (!(client.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and my.refname like '%"+client+"%'  ";
    	}
    	if((!(chno.equalsIgnoreCase(""))) && (!(chno.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and v.chno like '%"+chno+"%'  ";
    	}
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and v.date='"+sqlStartDate+"'";
    	} 
    	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				 
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select v.doc_no,v.cldocno,v.date,v.chno,v.model,v.engineno,v.carvalue,v.odkm,v.odkm,"
	        			+ "my.refname from gl_vehevaluation v "
	        			+ "left join my_acbook my on my.cldocno=v.cldocno and dtype='CRM' where v.status=3 "+sqltest );
	        	//System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
			}
			
			conn.close();
			return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
		 
	public  ClsVehicleEvaluationBean getViewDetails(int docno) throws SQLException {
		//System.out.println("inside the view option");
		ClsVehicleEvaluationBean bean = new ClsVehicleEvaluationBean();
		Connection conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
        	String str="select yom,intrcolor,trans,conditions,brdid,clrid from gl_vehevaluation where doc_no="+docno;
        	//System.out.println(str);
        	ResultSet resultSet = stmtVeh.executeQuery (str);
			
			while (resultSet.next()) {
//				System.out.println(resultSet.getString("FLNAME"));
				
            	bean.setHidcmbcolor(resultSet.getInt("clrid"));
            	bean.setHidcmbbrand(resultSet.getString("brdid"));
            	bean.setHidcmbcondition(resultSet.getInt("conditions"));
            	bean.setHidcmbinterior(resultSet.getInt("intrcolor"));
            	bean.setHidcmbtransition(resultSet.getInt("trans"));
            	bean.setHidcmbyom(resultSet.getInt("yom"));
            	/* bean.setHidcmbrlsbranch(resultSet.getString("ibrhid"));bean.setHidcmbrlsloc(resultSet.getString("ilocid"));
            	bean.setHidreleasedate(resultSet.getString("releasedate"));
            	bean.setHidreleasetime(resultSet.getString("releasetime"));
            	bean.setFileno(resultSet.getString("fileno"));
            	bean.setInsurmember(resultSet.getString("insur_member"));
            	bean.setTrackid(resultSet.getString("track_id"));
            	
            	bean.setCmbrentalstatus(resultSet.getString("renttype"));
            	
            	bean.setReleasefleet(bean.getFleetno());
            	String temp=resultSet.getString("fstatus");
//            	
            	bean.setFuelcapacity(resultSet.getString("tcap"));
            	bean.setHidcmbfueltype(resultSet.getString("fueltype"));*/
//            	System.out.println("aaa"+bean.getFleetname());
//            	listBean.add(bean);
            	//System.out.println(listBean);
			}
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return bean;
	}
	public  ClsVehicleEvaluationBean getPrint(int docno) throws SQLException {
		ClsVehicleEvaluationBean bean = new ClsVehicleEvaluationBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select v.cldocno,co.color,yo.yom,vb.brand_name,my.refname,my.per_mob,DATE_FORMAT(v.date,'%d %m %Y') date,v.model,v.chno,"
						+ " v.engineno,v.odkm,if(v.intrcolor=1,'beige',if(v.intrcolor=2,'gray',if(v.intrcolor=3,'white','black'))) intrcolor,"
						+ " if(v.trans=1,'Manual','Automatic') trans,"
						+ " if(v.conditions=1,'NotStarting',if(v.conditions=2,'Good Condition',if(v.conditions=3,'Good And Running',if(v.conditions=4,'Normal And Running','Excellent')))) conditions from gl_vehevaluation v"
						+ " left join my_acbook my on my.cldocno=v.cldocno and dtype='CRM'"
						+ " left join gl_vehbrand vb on vb.doc_no=v.brdid left join gl_yom yo on yo.doc_no=v.yom"
						+ " left join my_color co on co.doc_no=v.clrid where v.doc_no="+docno);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	  
			    	   bean.setLblbrand(pintrs.getString("brand_name"));
			    	    bean.setLblmodel(pintrs.getString("model"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblyom(pintrs.getString("yom"));
			    	    bean.setLblcolor(pintrs.getString("color"));
			    	    bean.setLblintrcolor(pintrs.getString("intrcolor"));
			    	    bean.setLbltrans(pintrs.getString("trans"));
			    	    bean.setLblchno(pintrs.getString("chno"));
			    	    bean.setLblengineno(pintrs.getString("engineno"));
			    	    bean.setLblodo(pintrs.getString("odkm"));
			    	    bean.setLblclient(pintrs.getString("refname"));
			    	    bean.setLblcontact(pintrs.getString("per_mob"));
			    	    bean.setLblcond(pintrs.getString("conditions"));
			       }
				

				stmtprint.close();
				
				


		
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	} 
	
	
	 
}
