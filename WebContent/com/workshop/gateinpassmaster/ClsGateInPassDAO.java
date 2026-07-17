package com.workshop.gateinpassmaster;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.salesmanmaster.checkin.ClsCheckinBean;
import com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionBean;
import com.sales.Sales.salesInvoice.ClsSalesInvoiceBean;
import com.sms.SmsAction;

public class ClsGateInPassDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray getRepairType(String docno,String branch,String id) throws SQLException{
		JSONArray repairdata=new JSONArray();
		if(!id.equalsIgnoreCase("1") && !id.equalsIgnoreCase("2")){
			return repairdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			if(id.equalsIgnoreCase("1")){
				strsql="select row_no docno,name from ws_gartype";
			}
			else{
				strsql="select rep.name,rep.row_no docno,coalesce(grep.doc_no,0) grepdocno from ws_gartype rep left join ws_giprepairtype grep on (rep.row_no=grep.repairdocno and grep.gipdocno="+docno+") group by rep.row_no";
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			repairdata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return repairdata;
	}
	public JSONArray clientDetailsSearch(String clientname,String docno,String check,String id,String email,String mobile) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    System.out.println(id);
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtclient = conn.createStatement();
			
	    	    String sql = "";
	    	    String sqll ="";
	    	    
	            if(!(clientname.equalsIgnoreCase(""))){
	             sql=sql+" and ac.refname like '%"+clientname+"%'";
	            }
	            if(!(docno.equalsIgnoreCase(""))){
	                sql=sql+" and ac.cldocno like '%"+docno+"%'";
	            }
	            if(!(email.equalsIgnoreCase("undefined"))&&!(email.equalsIgnoreCase(""))&&!(email.equalsIgnoreCase("0"))){
	            	sql=sql+" and ac.mail1 like '%"+email+"%'";
	    		}
	            if(!(mobile.equalsIgnoreCase("undefined"))&&!(mobile.equalsIgnoreCase(""))&&!(mobile.equalsIgnoreCase("0"))){
	            	sql=sql+" and ac.per_mob like '%"+mobile+"%'";
	    		}
	            
	            if(id.equalsIgnoreCase("1")){
	            	System.out.println(id);
				/*sqll = "select w.regno,ac.refname,ac.cldocno,ac.contactPerson,ac.mail1,ac.per_mob,ac.per_tel, "
						+ "concat(coalesce(ac.address,''),'  ',coalesce(ac.address2,'')) as address"
						+ " from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no left join ws_gateinpass w on w.cldocno=ac.cldocno where ac.dtype='crm' and ac.status=3"
						+ " and cat.status=3 and cat.insurance!=1"+sql;*/
	            
	            	sqll = "select ac.refname,ac.cldocno,ac.contactPerson,ac.mail1,ac.per_mob,ac.per_tel, "
							+ "concat(coalesce(ac.address,''),'  ',coalesce(ac.address2,'')) as address"
							+ " from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.dtype='crm' and ac.status=3"
							+ " and cat.status=3 and cat.insurance!=1"+sql;
	            }
	            if(id.equalsIgnoreCase("2")){
	            	sqll = "select refname,cldocno from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.dtype='crm' and ac.status=3"
							+ " and cat.status=3 and cat.insurance=1"+sql;
	            }
	            System.out.println(sqll);
				ResultSet resultSet1 = stmtclient.executeQuery(sqll);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtclient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	public int insert(Date sqldate, int docno,String cldocno,int clname,int clientid,String description,int apprchk,int backjob,
		String vehusername,String vehusrmobile,String vehusermail,String vehuserothers,String vehregno,String vehplatecode,int cmbbrand,
		int cmbmodel,int cmbyom,String vehothers,int vehkm, String cmbfueltype,int cmbrepairtype,Date sqlestdate,String esttime, 
		String maintenanceremarks,String policereport,Date sqlpolicedate,String policestation,int cmbinsutype,int cmbfaulttype,
		String claim,String lpo,double lpoamount,int exceschk,double excesamount, ArrayList<String> complaintarray,
		HttpSession session, HttpServletRequest request, String mode,String formdetailcode,String brchName,String refno,
		int movno,int luxury,String marketingperson,String serviceadvisor,String insuranceservivor,String referencedby,
		String servicepackage,String teammaster,String cmbpriority, String cmbcolor, Date sqlregexpirydate,String chkvirtual,ArrayList<String> reparray) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("======"+session);
		System.out.println("inside insert"+mode);
		int val=0;
		int vall=0;
		 int errorstatus=0;
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);

			CallableStatement stmtGate = conn.prepareCall("{call gateInPassDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtGate.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtGate.registerOutParameter(39, java.sql.Types.INTEGER);
			stmtGate.setDate(1,sqldate);
			stmtGate.setString(2,brchName);
			stmtGate.setString(3,cldocno);
			stmtGate.setInt(4, clname);
			stmtGate.setInt(5,clientid);
			stmtGate.setString(6,description);
			stmtGate.setInt(7,apprchk);
			stmtGate.setString(8,vehusername);
			stmtGate.setString(9,vehusrmobile);
			stmtGate.setString(10,vehusermail);
			stmtGate.setString(11,vehuserothers);
			stmtGate.setString(12,vehregno);
			stmtGate.setString(13,vehplatecode);
			stmtGate.setInt(14,cmbbrand);
			stmtGate.setInt(15,cmbmodel);
			stmtGate.setInt(17,cmbyom);
			stmtGate.setString(18,vehothers);
			stmtGate.setInt(19,vehkm);
			stmtGate.setString(20,cmbfueltype);
			stmtGate.setInt(21,cmbrepairtype);
			stmtGate.setDate(22,sqlestdate);
			stmtGate.setString(23,esttime);
			stmtGate.setString(24,maintenanceremarks);
			stmtGate.setString(25,policereport);
			stmtGate.setDate(26,sqlpolicedate);
			stmtGate.setString(27,policestation);
			stmtGate.setInt(28,cmbinsutype);
			stmtGate.setInt(29,cmbfaulttype);
			stmtGate.setString(30,claim);
			stmtGate.setString(31,lpo);
			stmtGate.setDouble(32,lpoamount);
			stmtGate.setInt(33,exceschk);
			stmtGate.setDouble(34,excesamount);
			stmtGate.setString(35,session.getAttribute("USERID").toString());
			stmtGate.setInt(36,backjob);
			stmtGate.setString(37,mode);
			stmtGate.setString(38,"GIP");
			stmtGate.setString(40,refno);
			stmtGate.setInt(41,movno);
			stmtGate.setInt(42,luxury);
			stmtGate.executeQuery();
			int vocNo=stmtGate.getInt("vocNo");
			val=stmtGate.getInt("docNo");
			request.setAttribute("vocNo", vocNo);
			if(val>0){
				Statement stmt=conn.createStatement();
				String strupdate="update ws_gateinpass set chkvirtual="+chkvirtual+",colorid="+cmbcolor+",regexpirydate='"+sqlregexpirydate+"',priority="+cmbpriority+",marketingperson="+(marketingperson.equalsIgnoreCase("")?"0":marketingperson)+",serviceadvisor="+(serviceadvisor.equalsIgnoreCase("")?"0":serviceadvisor)+",insurancesurvivor="+(insuranceservivor.equalsIgnoreCase("")?"0":insuranceservivor)+",referencedby="+(referencedby.equalsIgnoreCase("")?"0":referencedby)+",servicepackage="+(servicepackage.equalsIgnoreCase("")?"0":servicepackage)+",teammaster="+(teammaster.equalsIgnoreCase("")?"0":teammaster)+" where doc_no="+val;
				System.out.println("Update GIP Query: "+strupdate);
				int updateval=stmt.executeUpdate(strupdate);
				if(updateval<=0){
					errorstatus=1;
					return 0;
				}
				System.out.println(complaintarray.size());
				for(int i=0;i<complaintarray.size();i++){
					String temp[]=complaintarray.get(i).split("::");
					
					String strsql="insert into ws_gateinpassd (rdocno,srno,desc1,complaintid)values("+val+","+(i+1)+",'"+temp[1]+"','"+temp[0]+"')";
					System.out.println(strsql);
					int detailval=stmt.executeUpdate(strsql);
					if(detailval<=0){
						errorstatus=1;
					}
				}
				for(int i=0;i<reparray.size();i++){
					String repairdocno=reparray.get(i);					
					String strsql="insert into ws_giprepairtype(gipdocno,repairdocno,status)values("+docno+","+repairdocno+",3)";
					System.out.println(strsql);
					int detailval=stmt.executeUpdate(strsql);
					if(detailval<=0){
						errorstatus=1;
					}
				}
				int smsconfig=0;
		        String  strsmsconfig="select method from gl_config where field_nme='sms'";
		        ResultSet rssmsconfig=conn.createStatement().executeQuery(strsmsconfig);
		        while(rssmsconfig.next()){
		        	smsconfig=rssmsconfig.getInt("method");
		        }
		        if(smsconfig==1){
		        	SmsAction smsaction=new SmsAction();
		        	int estdocno=0,gipdocno=0;
		        	String strgetmobile="select gip.brhid,gip.doc_no gipdocno,date_format(gip.date,'%d.%m.%Y') basedate,ac.cldocno,coalesce(if(coalesce(ac.per_mob,'')='',gip.mobile,ac.per_mob),gip.mobile) clientmobile,coalesce(if(coalesce(ac.refname,'')='',gip.username,ac.refname),gip.username) clientname from ws_gateinpass gip left join my_acbook ac on gip.cldocno=ac.cldocno and ac.dtype='CRM' where gip.doc_no="+val;
			        System.out.println(strgetmobile);
		        	ResultSet rsgetmobile=conn.createStatement().executeQuery(strgetmobile);
			        String mobile="",clientname="",basedate="",brhid="";
			        while(rsgetmobile.next()){
			        	mobile=rsgetmobile.getString("clientmobile");
			        	clientname=rsgetmobile.getString("clientname");
			        	cldocno=rsgetmobile.getString("cldocno");
			        	basedate=rsgetmobile.getString("basedate");
			        	gipdocno=rsgetmobile.getInt("gipdocno");
			        	brhid=rsgetmobile.getString("brhid");
			        }
			        
		        	String smsstatus=smsaction.doSendSms(session, mobile, clientname, cldocno, "0.0", gipdocno+"", basedate, "GIP", brhid, conn);
		        	System.out.println(smsstatus);
		        	if(smsstatus.equalsIgnoreCase("success")){
		        		//System.out.println("SMS Success");
		        	}
		        	
		        }
			}
			if(errorstatus!=1){
				conn.commit();
				return val;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			if(description.equalsIgnoreCase("GIP created from APP")){
				try{
					String imgpath=request.getAttribute("IMGPATH")==null?"":request.getAttribute("IMGPATH").toString();
					File apperrorfile = new File(imgpath+"//attachment//app-errorlog.txt");
				    if (apperrorfile.createNewFile()) {
				    } else {
				    }
				    //FileWriter myWriter = new FileWriter(imgpath+"//attachment//app-errorlog.txt");
				    String currenterr=e.getMessage();
				    Files.write(Paths.get(imgpath+"//attachment//app-errorlog.txt"),currenterr.getBytes(), StandardOpenOption.APPEND);
				    //myWriter.write(currenterr);
				    //myWriter.close();
				}
				catch(IOException ie){
					ie.printStackTrace();
				}
			}
			conn.close();
		}
		finally{
			conn.close();
		}
		return val;
	}

	public int edit(Date sqldate, int docno,int vocno,String cldocno,int clname,int clientid,String description,int apprchk,int backjob,
		String vehusername,String vehusrmobile,String vehusermail,String vehuserothers,String vehregno,String vehplatecode,int cmbbrand,
		int cmbmodel,int cmbyom,String vehothers,int vehkm, String cmbfueltype,int cmbrepairtype,Date sqlestdate,String esttime, 
		String maintenanceremarks,String policereport,Date sqlpolicedate,String policestation,int cmbinsutype,int cmbfaulttype,
		String claim,String lpo,double lpoamount,int exceschk,double excesamount, ArrayList<String> complaintarray,HttpSession session, 
		HttpServletRequest request, String mode,String formdetailcode,String brchName,String refno,int movno,int luxury,String marketingperson,
		String serviceadvisor,String insuranceservivor,String referencedby,String servicepackage,String teammaster,String cmbpriority, 
		String cmbcolor, Date sqlregexpirydate,String chkvirtual,ArrayList<String> reparray) throws SQLException {
		// TODO Auto-generated method stub
		//System.out.println("-=-=-=-=-=-=-=-=-"+docno);
		int val=0;
		int errorstatus=0;
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtcheck=conn.createStatement();
			String str="select coalesce(processstatus,0) processstatus from ws_gateinpass where doc_no="+docno+" and status<>7";
			ResultSet rs=stmtcheck.executeQuery(str);
			int processstatus=0;
			while(rs.next()){
				processstatus=rs.getInt("processstatus");
				
			}
			if(processstatus==1){
				
			}
			else{
				errorstatus=1;
				val=-1;
			}
			if(processstatus==1){
				CallableStatement stmtGate = conn.prepareCall("{call gateInPassDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtGate.setInt(16,docno);
				stmtGate.setInt(39,vocno);
				stmtGate.setDate(1,sqldate);
				stmtGate.setString(2,brchName);
				stmtGate.setString(3,cldocno);
				stmtGate.setInt(4,clname);
				stmtGate.setInt(5,clientid);
				stmtGate.setString(6,description);
				stmtGate.setInt(7,apprchk);
				stmtGate.setString(8,vehusername);
				stmtGate.setString(9,vehusrmobile);
				stmtGate.setString(10,vehusermail);
				stmtGate.setString(11,vehuserothers);
				stmtGate.setString(12,vehregno);
				stmtGate.setString(13,vehplatecode);
				stmtGate.setInt(14,cmbbrand);
				stmtGate.setInt(15,cmbmodel);
				stmtGate.setInt(17,cmbyom);
				stmtGate.setString(18,vehothers);
				stmtGate.setInt(19,vehkm);
				stmtGate.setString(20,cmbfueltype);
				stmtGate.setInt(21,cmbrepairtype);
				stmtGate.setDate(22,sqlestdate);
				stmtGate.setString(23,esttime);
				stmtGate.setString(24,maintenanceremarks);
				stmtGate.setString(25,policereport);
				stmtGate.setDate(26,sqlpolicedate);
				stmtGate.setString(27,policestation);
				stmtGate.setInt(28,cmbinsutype);
				stmtGate.setInt(29,cmbfaulttype);
				stmtGate.setString(30,claim);
				stmtGate.setString(31,lpo);
				stmtGate.setDouble(32,lpoamount);
				stmtGate.setInt(33,exceschk);
				stmtGate.setDouble(34,excesamount);
				stmtGate.setString(35,session.getAttribute("USERID").toString());
				stmtGate.setInt(36,backjob);
				stmtGate.setString(37,mode);
				stmtGate.setString(38,"GIP");
				stmtGate.setString(40,refno);
				stmtGate.setInt(41,movno);
				stmtGate.setInt(42,luxury);
				val=stmtGate.executeUpdate();
				
				if(val>=0){
					Statement stmt=conn.createStatement();	
					cmbcolor=cmbcolor==null?"0":cmbcolor;
					cmbpriority=cmbpriority==null?"1":cmbpriority;
					String strupdate="update ws_gateinpass set colorid="+cmbcolor+",regexpirydate='"+sqlregexpirydate+"',priority="+cmbpriority+",marketingperson="+(marketingperson.equalsIgnoreCase("")?"0":marketingperson)+",serviceadvisor="+(serviceadvisor.equalsIgnoreCase("")?"0":serviceadvisor)+",insurancesurvivor="+(insuranceservivor.equalsIgnoreCase("")?"0":insuranceservivor)+",referencedby="+(referencedby.equalsIgnoreCase("")?"0":referencedby)+",servicepackage="+(servicepackage.equalsIgnoreCase("")?"0":servicepackage)+",teammaster="+(teammaster.equalsIgnoreCase("")?"0":teammaster)+" where doc_no="+docno;
					System.out.println("Update GIP Query: "+strupdate);
					int updateval=stmt.executeUpdate(strupdate);
					if(updateval<0){
						errorstatus=1;
						return 0;
					}
					String strdelete="delete from ws_gateinpassd where rdocno="+docno;
					int deleteval=stmt.executeUpdate(strdelete);
					/*if(deleteval>0){*/
					System.out.println("Array Size :"+complaintarray.size());
					for(int i=0;i<complaintarray.size();i++){
						String temp[]=complaintarray.get(i).split("::");

						String strsql="insert into ws_gateinpassd(rdocno,srno,desc1,complaintid)values("+docno+","+(i+1)+",'"+temp[1]+"',"+temp[0]+")";
						System.out.println(strsql);
						int detailval=stmt.executeUpdate(strsql);
					
						if(detailval<=0){
							errorstatus=1;
						}
					}
					String strdeleterep="delete from ws_giprepairtype where gipdocno="+docno;
					int deleterep=stmt.executeUpdate(strdeleterep);
					
					for(int i=0;i<reparray.size();i++){
						String repairdocno=reparray.get(i);					
						String strsql="insert into ws_giprepairtype(gipdocno,repairdocno,status)values("+docno+","+repairdocno+",3)";
						System.out.println(strsql);
						int detailval=stmt.executeUpdate(strsql);
						if(detailval<=0){
							errorstatus=1;
						}
					}
				/*}*/
				}
				if(errorstatus!=1){
					conn.commit();
					return val;
				}
				else{
					return 0;
				}
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return val;
	}

	public int delete(int docno, String brchName,String mode,HttpSession session, HttpServletRequest request)throws SQLException {
		// TODO Auto-generated method stub
		
		System.out.println("''''''docno''''''"+docno);
		int errorstatus=0;
		
		
		Connection conn=null;
		
		int val = 0;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			Statement stmt = conn.createStatement ();
			  
			 String upsql="update ws_gateinpass set status=7 where doc_no='"+docno+"'";
		
				 int vall= stmt.executeUpdate(upsql);
				 System.out.println(upsql);
				 if(vall>0){
					 String sql="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brchName+"','GIP',now(),'"+session.getAttribute("USERID").toString()+"','D')";
				
					 val=stmt.executeUpdate(sql);
					 System.out.println(sql);
				 }

			if(val>=0){
				conn.commit();
				return val;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			
			conn.close();
		}
		return val;
	}
	
	
	public JSONArray getComplaints(String docno,String branch,String id) throws SQLException{
		JSONArray complaintdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return complaintdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select det.complaintid complaintdocno,det.desc1 description,comp.compname complaint from "+
			" ws_gateinpassd det left join gl_complaint comp on det.complaintid=comp.doc_no where "+
			" det.rdocno="+docno;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			complaintdata=ClsCommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return complaintdata;
	}
	
	public   JSONArray getComplaint() throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=ClsConnection.getMyConnection();
					
			Statement stmtmanual = conn.createStatement ();
			strSql="select compname,doc_no docno from gl_complaint where status<>7";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_namess,String dates,
			String mobile,String regno,int id,String refno,String brhid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		if(id!=1){
			return RESULTDATA;
		}
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

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();

 //System.out.println("datadatadata"+dates);

		java.sql.Date sqlDate=null;


		String sqltest="";

		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and gatm.voc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_namess.equalsIgnoreCase("undefined"))&&!(Cl_namess.equalsIgnoreCase(""))&&!(Cl_namess.equalsIgnoreCase("0"))){

			sqltest=sqltest+" and ac.refname like '%"+Cl_namess+"%'";
		}
		
		if(!(mobile.equalsIgnoreCase("undefined"))&&!(mobile.equalsIgnoreCase(""))&&!(mobile.equalsIgnoreCase("0"))){

			sqltest=sqltest+" and gatm.mobile like '%"+mobile+"%'";
		}
		
		if(!(regno.equalsIgnoreCase("undefined"))&&!(regno.equalsIgnoreCase(""))&&!(regno.equalsIgnoreCase("0"))){

			sqltest=sqltest+" and gatm.regno like '%"+regno+"%'";
		}
		
		if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))){
			sqlDate = ClsCommon.changeStringtoSqlDate(dates);
			sqltest=sqltest+" and gatm.date='"+sqlDate+"'";
		}
		if(!(refno.equalsIgnoreCase("undefined"))&&!(refno.equalsIgnoreCase(""))&&!(refno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and gatm.refno like '%"+refno+"%'";
		}
		if(!brhid.equalsIgnoreCase("")){
			sqltest=sqltest+" and gatm.brhid="+brhid;
		}

		Connection conn = null;
		ResultSet resultSet =null;
		try {

			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			/*String str1Sql=("select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,m.date,m.reviseno,m.ref_type,CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,material,"
					+ " labour, machine, netTotal,mp.jobtype as activity,mp.tr_no as activityid from cm_prjestm m left join cm_estactivity ea on(m.tr_no=ea.doc_no) left join cm_prjmaster mp on(mp.tr_no=ea.activityid) "
					+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where 1=1 "+sqltest+" ");*/

			String str1Sql="select gatm.chkvirtual,gatm.colorid,gatm.regexpirydate,coalesce(grp.gname,'') gname,gatm.priority,gatm.marketingperson marketingpersonid, gatm.serviceadvisor serviceadvisorid, "+
						" gatm.insurancesurvivor insurancesurvivorid,gatm.referencedby referencedbyid, gatm.servicepackage servicepackageid, gatm.teammaster "+
						" teammasterid,coalesce(wmp.sal_name,'') marketingperson,coalesce(wsa.sal_name,'') serviceadvisor,coalesce(wis.sal_name,'') insurancesurvivor,coalesce(wrb.sal_name,'') "+
						" referencedby,coalesce(wsp.name,'') servicepackage,coalesce(wtm.grpcode,'') teammaster,m.doc_no etmdocno,cd.doc_no jobdocno,ac.refname name,ac.contactPerson,ac.mail1,ac.per_mob,ac.per_tel,"
					+ " concat(coalesce(ac.address,''),'  ',coalesce(ac.address2,'')) as address,acc.refname compny,gatm.doc_no,gatm.voc_no,gatm.date,gatm.cldocno,gatm.insurancecomp,gatm.insurcldocno,gatm.desc1,gatm.approvalreq,"
					+ " gatm.username,gatm.luxury,gatm.refno,gatm.email,gatm.mobile,gatm.other,gatm.regno,gatm.pltid,gatm.brdid,gatm.modid,gatm.yom,gatm.vehother,gatm.kmin,"
					+ " gatm.fuel,gatm.repairtype,gatm.estdeldate,gatm.estdeltime,gatm.mainremarks,gatm.policerep,gatm.policerepdate,gatm.stationname,"
					+ " gatm.insutype,gatm.faulttype,gatm.claim,gatm.lpo,gatm.movno,gatm.lpoamount,gatm.excess,gatm.excessamt,gatm.backjob from ws_gateinpass gatm"
					+ " left join my_acbook ac on ac.cldocno=gatm.cldocno and ac.dtype='CRM' "
					+ " left join my_acbook acc on acc.cldocno=gatm.insurcldocno and acc.dtype='CRM' left join (select m.gipno,m.doc_no,count(*) cnt from  ws_estm m where m.status=3 group by m.doc_no) m on gatm.doc_no=m.gipno"
					+ "  left join (select cd.refno,cd.reftype,cd.doc_no,count(*) cnt from  ws_jobcard cd where cd.status=3 group by cd.doc_no) cd on (gatm.doc_no=cd.refno and cd.reftype='GIP')"
					+" left join my_salesman wmp on (gatm.marketingperson=wmp.doc_no and wmp.sal_type='WMP')"
					+" left join my_salesman wsa on (gatm.serviceadvisor=wsa.doc_no and wsa.sal_type='WSA')"
					+" left join my_salesman wis on (gatm.insurancesurvivor=wis.doc_no and wis.sal_type='WIS')"
					+" left join my_salesman wrb on (gatm.referencedby=wrb.doc_no and wrb.sal_type='WRB')"
					+" left join ws_servicepackage wsp on gatm.servicepackage=wsp.doc_no"
					+" left join ws_teammasterm wtm on gatm.teammaster=wtm.doc_no"
					+" left join gl_vehmodel model on gatm.modid=model.doc_no "
					+" left join gl_vehgroup grp on model.groupid=grp.doc_no"
					+ " where gatm.status=3 "+sqltest+"  group by gatm.doc_no order by gatm.voc_no";

						System.out.println("==refmainsearchload==="+str1Sql);
			if(id>0){
				resultSet = stmtenq1.executeQuery(str1Sql);

			}
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){

			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray ReisterDetailsSearch(String cldocno,String id,String regno) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(id.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtclient = conn.createStatement();
			
	    	    String sql = "";
	    	    String sqll ="";
	    	    
	            if(!(cldocno.equalsIgnoreCase(""))){
	             sql=sql+" and gip.cldocno="+cldocno+"";
	            }
	           
	            if(!(regno.equalsIgnoreCase("undefined"))&&!(regno.equalsIgnoreCase(""))&&!(regno.equalsIgnoreCase("0"))){
	            	sql=sql+" and gip.regno like '%"+regno+"%'";
	    		}
	           
				/*sqll = "select ws.regno,ws.other chasis,ws.pltid,ws.brdid,ws.modid,ws.yom,"
						+ " ws.kmin,ws.fuel,ws.repairtype,ws.vehother remarks from ws_gateinpass ws where 1=1"+sql;
	            */
	            sqll="select gip.regno,gip.other chasis,gip.pltid,gip.brdid,gip.modid,gip.yom,gip.kmin,gip.fuel,gip.repairtype,gip.vehother remarks "+
	            " from ws_gateinpass gate inner join (select max(doc_no) maxdoc,cldocno from ws_gateinpass group by cldocno,regno) maxgate on "+
	            " maxgate.cldocno=gate.cldocno and maxgate.maxdoc=gate.doc_no left join ws_gateinpass gip on gip.doc_no=maxgate.maxdoc and "+
	            " maxgate.cldocno=gip.cldocno where gip.status<>7 and gip.outdate is not null"+sql;
	            System.out.println(sqll);
				ResultSet resultSet1 = stmtclient.executeQuery(sqll);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtclient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	 public    ClsGateInPassBean getPrint(int docno, HttpServletRequest request,String formcode) throws SQLException {
		   ClsGateInPassBean bean = new ClsGateInPassBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();
	        	
/*				String resql=("select m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct',if(m.rdtype='CEQ','Sales Enquiry','Sales Quotation')) type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
				" from my_qotm m left join my_head h on h.doc_no=m.acno   where   m.doc_no='"+docno+"'");
				*/
			/*    int type=2;
				 
				 if(formcode.equalsIgnoreCase("CASH"))
				 {
					 type=1;
					 
				 }
				    
				*/
			
				String resql=("select ws.priority,concat(coalesce(ws.pltid,''),'  ',coalesce(ws.regno,'')) as regno,ws.date,ws.doc_no jobno,"
						+ " concat(coalesce(br.brand_name,''),'  ',coalesce(md.vtype,'')) as type,ac.refname customer,u.user_name person,ws.other chasisno"
						+ " ,ws.vehother engineno,y.yom model,CURDATE() as currdate"
						+ " from ws_gateinpass ws left join gl_vehbrand br on br.doc_no=ws.brdid"
						+ " left join gl_vehmodel md on md.doc_no=ws.modid "
						+ " left join my_acbook ac on ac.cldocno=ws.cldocno "
						+ " left join my_user u on u.doc_no=ws.userid "
						+ "left join gl_yom y on y.doc_no=ws.yom where   ws.doc_no='"+docno+"'");
				
				 
			 System.out.println("---resql----"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
			    	
			    	   bean.setCmbpriority(pintrs.getString("priority"));
			    	   bean.setLblrvehicleno(pintrs.getString("regno"));
			    	   bean.setLbldate(pintrs.getString("date"));
			    	   bean.setLbljobno(pintrs.getString("jobno"));
			    	   bean.setLbltype(pintrs.getString("type"));
			    	   bean.setLblcustomer(pintrs.getString("customer"));
			    	   bean.setLblperson(pintrs.getString("person"));
			    	   bean.setLblchasisno(pintrs.getString("chasisno"));
			    	   bean.setLblengineno(pintrs.getString("engineno"));
			    	   bean.setLblmodel(pintrs.getString("model"));
			    	   bean.setLbltodat(pintrs.getString("currdate"));
	   	 }
				

				stmtprint.close();
				
				 Statement stmt10 = conn.createStatement ();  
				    String  companysql="select b.branchname,c.company,b.address,c.address compaddress,b.tel,c.fax,l.loc_name location,b.doc_no from ws_gateinpass r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

                         System.out.println("++++"+companysql);
			         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	   if(resultsetcompany.getString("company").equalsIgnoreCase("PAL AUTO GARAGE")&& resultsetcompany.getInt("doc_no")!=3){
				    		   bean.setLblcompname(resultsetcompany.getString("company")+" (Br.)");
				    	   }
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	  
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("compaddress"));
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   
				    	   
				       } 
				     stmt10.close();
				
				
				       
				   
				     
				     
				     
				    
						
						
						
					//	 System.out.println("====grndtotal=2="+grndtotal);
						
						 
					
					 
					
					System.out.println("=========close==========");
					 
				
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
	 public ArrayList<String> getUploadPicsData(int doc) throws SQLException{
			// TODO Auto-generated method stub
			ArrayList<String> imgarray=new ArrayList<>();
			Connection conn=null;
			try{
				conn=ClsConnection.getMyConnection();
				Statement stmt=conn.createStatement();
				String strsql="select doc.path from ws_gateinpass gip left join my_fileattach doc on (doc.dtype='GIP' and doc.doc_no=gip.doc_no)"+
				" where gip.doc_no="+doc+" and substring_index(doc.path,'GIP',-1)<>substring_index(gip.signature,'GIP',-1) and gip.vehimage not like concat('%',doc.filename,'%')";
				System.out.println(strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					imgarray.add(rs.getString("path"));  
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return imgarray;
		}
	
	 public  JSONArray getMarketingPersonData(String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn=ClsConnection.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	String sqldata="select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description from my_salesman "+
	            			" sal left join my_head head on (sal.acc_no=head.doc_no) where status=3 and sal_type='WMP'";
	            	
					ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					 return RESULTDATA;

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 public  JSONArray getServiceAdvisorData(String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn=ClsConnection.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	String sqldata="select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description "+
	            			" from my_salesman sal left join my_head head on (sal.acc_no=head.doc_no) where status=3 and sal_type='WSA'";
	            	
					ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					 return RESULTDATA;

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 
	 public  JSONArray getInsuranceSurvivorData(String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
			try {
					conn=ClsConnection.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	String sqldata="select ac.cldocno,ac.refname,sal.doc_no,sal.sal_code,sal.sal_name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description "+
	            			" from my_salesman sal left join my_head head on (sal.acc_no=head.doc_no) left join my_acbook ac on (sal.cldocno=ac.cldocno and ac.dtype='CRM') left join my_clcatm cat on (ac.catid=cat.doc_no and cat.status=3 and cat.insurance=1) where sal.status=3 and sal.sal_type='WIS'";
	            	
					ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					 return RESULTDATA;

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 
	 public JSONArray getReferencedByData(String id) throws SQLException {
		 JSONArray data=new JSONArray();
		 if(!id.equalsIgnoreCase("1")){
			 return data;
		 }
		 Connection conn = null;
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtSalesAgent = conn.createStatement();
		        	
					ResultSet resultSet = stmtSalesAgent.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.mail,m2.description "+
					" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='WRB'");
					data=ClsCommon.convertToJSON(resultSet);
					stmtSalesAgent.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		    return data;
		}
	 
	 
	 public  JSONArray getServicePackageData(String id) throws SQLException {
			
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
		    	return RESULTDATA;
		    }
		    Connection conn = null;
		   
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtrelode = conn.createStatement();
		        	
				//	String resql=("select docno, mtype, name, DATE_FORMAT(date,'%d.%m.%Y') date from gl_vrepm where status=3 ");
					
					String resql=("select doc_no,code,name,amount, date from ws_servicepackage where status=3 ");
					
					ResultSet resultSet = stmtrelode.executeQuery(resql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtrelode.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		    return RESULTDATA;
		}
	 
	 
	 public JSONArray getTeamMasterData(String id) throws SQLException {
			JSONArray RESULTDATA = new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Connection conn =null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt =conn.createStatement();

				String sqltest="";
			
				ResultSet resultSet = stmt.executeQuery ("select m.grpcode,m.description desc1,m.doc_no docno,m.ismulemp,m.serteamuserlink teamuserlinkid,u.user_name teamuserlinkname from ws_teammasterm m left join my_user u on u.doc_no=m.serteamuserlink where m.status=3 "+sqltest+"");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return RESULTDATA;
		}
}
