package com.workshop.estimator;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;

import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class ClsEstimationDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getGateInPassData(String gatedocno,String cldocno,String clientname,String 
			regno,String date,String id,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and gate.voc_no like '%"+gatedocno+"%'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and gate.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+regno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and gate.date='"+sqldate+"'";
			}
			if(!brhid.equalsIgnoreCase("")){
				sqltest+=" and gate.brhid="+brhid;
			}
			strsql="select coalesce(insur.refname,'') gipinsurcomp,coalesce(gate.claim,'') gipclaimno,date_format(dat.edate,'%d.%m.%Y %H:%i') gipdatetime,convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',"+
			" coalesce(gate.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no,gate.voc_no,"+
			" gate.date,gate.cldocno,gate.regno,ac.refname,concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',"+
			" coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_gateinpass gate left join my_acbook "+
			" ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_vehbrand "+
			" brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no left join my_acbook insur on (gate.insurcldocno=insur.cldocno and insur.dtype='CRM') inner join datalog dat on (dat.brhid=gate.brhid and dat.doc_no=gate.doc_no and dat.dtype='GIP' and dat.entry='A') where gate.status=3 and gate.processstatus=1 and approvalreq=1 and backjob=0"+sqltest;
			System.out.println("==== "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
		
	}
	public JSONArray getLabourcostData(String docno,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select lab.seqno,lab.strjobdesc jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,lab.strjobtype jobtype,lab.markupper markuppercent,lab.total,lab.remarks, "+
			" lab.jobid from ws_estimationlabour lab left join ws_jobmaster m on (m.status=3 and lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
			" where lab.addition=0 and lab.rdocno='"+docno+"' and lab.lumsumstatus=0 order by seqno";
			System.out.println("Labour Data:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getSparepartsAmountData(String docno,String id) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();  
			String strsql="select description,taxpercent vatpercent,genuine genuinetotal,market markettotal,used usedtotal,approved approvedtotal from ws_estimationspareamt where status=3 and addition=0 and rdocno="+docno;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getLabourSearchData(String jobdocno,String jobtype,String date,String id,String gatedocno,String jobtypename) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!jobdocno.equalsIgnoreCase("")){
				sqltest+=" and m.doc_no like '%"+jobdocno+"%'";
			}
			if(!jobtype.equalsIgnoreCase("")){
				sqltest+=" and m.desc1 like '%"+jobtype+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			if(!jobtypename.equalsIgnoreCase("")){
				sqltest+=" and t.type like '%"+jobtypename+"%'";
			}
				strsql="select m.desc1 jobdesc,m.doc_no,m.date,m.stdrate hrs,m.stdcostperhr rate,t.type jobtype,m.jobid from ws_jobmaster m left join ws_jobtype t on m.jobid=t.doc_no where m.status=3"+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return data;
	}
	
	public JSONArray getJobTypeInputData(String id)throws SQLException{  
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select t.doc_no,t.type jobtype from ws_jobtype t where t.status=3";
			System.out.println("Job Type Input Query==="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
		
	}
	public JSONArray getSparepartsData(String docno,String id) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select description, rate sprate, qty, genuinerate, marketrate, usedrate, genuinetotal, markettotal, usedtotal, approval, approvedvalue from ws_estimationspare where addition=0 and rdocno="+docno+" order by srno";
			System.out.println("Spare==="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public int insert(String gatedocno, String sparepartstotal,
			String labourtotal, String discount, String esttotal, Date sqldate,
			ArrayList<String> sparepartsarray,
			ArrayList<String> labourcostarray, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode,
			String brchName, String servicesdiscount, String servicestotal, String netservices, 
			String hidchklumsum, String lumsumamount, String header,String notes,String internalremarks,String hidchkservicelumsum,
			String servicelumsumamt,String hidchkrandomlumsum,String randomlumsumamt,
			String estimatedays,String gipdatetime,String gipclaimno,
			String sparetotal, String sparediscount, String netspare, String clientdet,String vehicledet,String description) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0,vocno=0;
		try{
			estimatedays=estimatedays==null || estimatedays.trim().equalsIgnoreCase("undefined") || estimatedays.trim().equalsIgnoreCase("")?"":estimatedays.trim();
			gipdatetime=gipdatetime==null || gipdatetime.trim().equalsIgnoreCase("undefined") || gipdatetime.trim().equalsIgnoreCase("")?"":gipdatetime.trim();
			gipclaimno=gipclaimno==null || gipclaimno.trim().equalsIgnoreCase("undefined") || gipclaimno.trim().equalsIgnoreCase("")?"":gipclaimno.trim();
			
			sparetotal=sparetotal==null || sparetotal.trim().equalsIgnoreCase("undefined") || sparetotal.trim().equalsIgnoreCase("")?"0":sparetotal.trim();
			sparediscount=sparediscount==null || sparediscount.trim().equalsIgnoreCase("undefined") || sparediscount.trim().equalsIgnoreCase("")?"0":sparediscount.trim();
			netspare=netspare==null || netspare.trim().equalsIgnoreCase("undefined") || netspare.trim().equalsIgnoreCase("")?"0":netspare.trim();
			
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtEst = conn.prepareCall("{call EstimatorDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");  
			stmtEst.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,gatedocno.trim().equalsIgnoreCase("")?"0":gatedocno);  
			stmtEst.setString(3,"0");
			stmtEst.setString(4, "0");
			stmtEst.setString(5,"0");
			stmtEst.setString(6,"0");
			stmtEst.setString(7,formdetailcode);
			stmtEst.setString(8,mode);
			stmtEst.setString(9,session.getAttribute("USERID").toString());
			stmtEst.setString(10,brchName);
			stmtEst.setString(13,servicestotal);
			stmtEst.setString(14,servicesdiscount);
			stmtEst.setString(15,netservices);
			stmtEst.setString(16, hidchklumsum);
			stmtEst.setString(17, lumsumamount);
			stmtEst.setString(18, clientdet);
			stmtEst.setString(19, vehicledet);
			stmtEst.setString(20, description);     
			stmtEst.executeQuery();
			docno=stmtEst.getInt("docNo");
			vocno=stmtEst.getInt("vocNo");
			request.setAttribute("WSESTVOCNO", vocno);
			int errorstatus=0;
			if(docno<=0){
				errorstatus=1;
				return 0;
			}
			else{
				Statement stmt=conn.createStatement();
				gipclaimno=gipclaimno==null || gipclaimno.trim().equalsIgnoreCase("") || gipclaimno.trim().equalsIgnoreCase("undefined")?"":gipclaimno.trim();
				gipdatetime=gipdatetime==null || gipdatetime.trim().equalsIgnoreCase("") || gipdatetime.trim().equalsIgnoreCase("undefined")?"":gipdatetime.trim();
				estimatedays=estimatedays==null || estimatedays.trim().equalsIgnoreCase("") || estimatedays.trim().equalsIgnoreCase("undefined")?"":estimatedays.trim();
				header=header==null || header.trim().equalsIgnoreCase("") || header.trim().equalsIgnoreCase("undefined")?"":header.trim();
				notes=notes==null || notes.trim().equalsIgnoreCase("") || notes.trim().equalsIgnoreCase("undefined")?"":notes.trim();
				internalremarks=internalremarks==null || internalremarks.trim().equalsIgnoreCase("") || internalremarks.trim().equalsIgnoreCase("undefined")?"":internalremarks.trim();
				hidchkservicelumsum=hidchkservicelumsum==null || hidchkservicelumsum.trim().equalsIgnoreCase("") || hidchkservicelumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkservicelumsum.trim();
				servicelumsumamt=servicelumsumamt==null || servicelumsumamt.trim().equalsIgnoreCase("") || servicelumsumamt.trim().equalsIgnoreCase("undefined")?"0":servicelumsumamt.trim();
				hidchkrandomlumsum=hidchkrandomlumsum==null || hidchkrandomlumsum.trim().equalsIgnoreCase("") || hidchkrandomlumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkrandomlumsum.trim();
				randomlumsumamt=randomlumsumamt==null || randomlumsumamt.trim().equalsIgnoreCase("") || randomlumsumamt.trim().equalsIgnoreCase("undefined")?"0":randomlumsumamt.trim();
				String strupdateest="update ws_estimationm set sparetotal="+sparetotal+",sparediscount="+sparediscount+",sparenettotal="+netspare+",claimno='"+gipclaimno+"',gipdatetime='"+gipdatetime+"',estimatedays='"+estimatedays+"',header='"+header+"',notes='"+notes+"',internalremarks='"+internalremarks+"',chkservicelumsum="+hidchkservicelumsum+",servicelumsumamt="+servicelumsumamt+",chkrandomlumsum="+hidchkrandomlumsum+",randomlumsumamt="+randomlumsumamt+" where doc_no="+docno;
				int updateest=stmt.executeUpdate(strupdateest);
				if(updateest<=0){
					System.out.println("Master Update Error");
					errorstatus=1;
					return 0;
				}
				int sparecount=0,labourcount=0;
				
				for(int i=0;i<sparepartsarray.size();i++){
					String temp[]=sparepartsarray.get(i).split("::");
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
					temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();
					sparecount++;
					String strsql="insert into ws_estimationspare(rdocno, srno,description, qty, rate, approvedvalue, addition, confirmed, approved)values("+
					""+docno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+",0,1,0)";
					System.out.println(strsql);
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
						return 0;
					}
				}
				
				for(int i=0;i<labourcostarray.size();i++){
					String temp[]=labourcostarray.get(i).split("::");
					labourcount++;
					temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"0":temp[0].trim();
					temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
					temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
					temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();
					temp[4]=temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null||temp[4].isEmpty()?"0":temp[4].trim();
					temp[5]=temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null||temp[5].isEmpty()?"":temp[5].trim();
					String strjobtype=temp[6].trim().equalsIgnoreCase("")||temp[6].trim().equalsIgnoreCase("undefined")||temp[6]==null||temp[6].isEmpty()?"":temp[6].trim();
					String strjobdesc=temp[7].trim().equalsIgnoreCase("")||temp[7].trim().equalsIgnoreCase("undefined")||temp[7]==null||temp[7].isEmpty()?"":temp[7].trim();
					String seqno=temp[8].trim().equalsIgnoreCase("")||temp[8].trim().equalsIgnoreCase("undefined")||temp[8]==null||temp[8].isEmpty()?"":temp[8].trim();
					if(seqno.trim().equalsIgnoreCase("")){
						seqno=labourcount+"";
					}
					String strsql="insert into ws_estimationlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved,strjobtype,strjobdesc,seqno)values("+
					""+docno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',0,1,0,'"+strjobtype+"','"+strjobdesc+"',"+seqno+")";
					System.out.println(strsql);
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
						return 0;
					}
				}
				if(errorstatus==0){
					conn.commit();
					return docno;
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
		return 0;
	}
	public boolean edit(String gatedocno, String sparepartstotal,String labourtotal, String discount, 
		String esttotal, Date sqldate,ArrayList<String> sparepartsarray,ArrayList<String> labourcostarray, 
		HttpSession session,HttpServletRequest request, String mode, String formdetailcode,
		String brchName, String docno, String vocno,  String servicesdiscount, String servicestotal, 
		String netservices,String hidchklumsum,String lumsumamount, String header,String notes,
		String internalremarks,String hidchkservicelumsum,String servicelumsumamt,String hidchkrandomlumsum,
		String randomlumsumamt,String estimatedays,String gipdatetime,String gipclaimno,
		String sparetotal, String sparediscount, String netspare, String clientdet,String vehicledet,String description) throws SQLException {   
		// TODO Auto-generated method stub
			Connection conn=null;
			try{   
				estimatedays=estimatedays==null || estimatedays.trim().equalsIgnoreCase("undefined") || estimatedays.trim().equalsIgnoreCase("")?"":estimatedays.trim();
				gipdatetime=gipdatetime==null || gipdatetime.trim().equalsIgnoreCase("undefined") || gipdatetime.trim().equalsIgnoreCase("")?"":gipdatetime.trim();
				gipclaimno=gipclaimno==null || gipclaimno.trim().equalsIgnoreCase("undefined") || gipclaimno.trim().equalsIgnoreCase("")?"":gipclaimno.trim();
				
				sparetotal=sparetotal==null || sparetotal.trim().equalsIgnoreCase("undefined") || sparetotal.trim().equalsIgnoreCase("")?"0":sparetotal.trim();
				sparediscount=sparediscount==null || sparediscount.trim().equalsIgnoreCase("undefined") || sparediscount.trim().equalsIgnoreCase("")?"0":sparediscount.trim();
				netspare=netspare==null || netspare.trim().equalsIgnoreCase("undefined") || netspare.trim().equalsIgnoreCase("")?"0":netspare.trim();
				
				
				conn=objconn.getMyConnection();
				conn.setAutoCommit(false);
				CallableStatement stmtEst = conn.prepareCall("{call EstimatorDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtEst.setInt(12, Integer.parseInt(vocno));
				stmtEst.setInt(11, Integer.parseInt(docno));
				stmtEst.setDate(1,sqldate);
				stmtEst.setString(2,gatedocno.trim().equalsIgnoreCase("")?"0":gatedocno);
				stmtEst.setString(3,sparepartstotal);
				stmtEst.setString(4, labourtotal);
				stmtEst.setString(5,discount);
				stmtEst.setString(6,esttotal);
				stmtEst.setString(7,formdetailcode);
				stmtEst.setString(8,mode);
				stmtEst.setString(9,session.getAttribute("USERID").toString());
				stmtEst.setString(10,brchName);
				stmtEst.setString(13,servicestotal);
				stmtEst.setString(14,servicesdiscount);
				stmtEst.setString(15,netservices);
				stmtEst.setString(16, hidchklumsum);
				stmtEst.setString(17, lumsumamount);
				stmtEst.setString(18, clientdet);
				stmtEst.setString(19, vehicledet);
				stmtEst.setString(20, description);     
				int updateval=stmtEst.executeUpdate();
				int errorstatus=0;
				if(updateval<0){
					errorstatus=1;
					return false;
				}
				else{
					Statement stmt=conn.createStatement();
					
					//Reseting Job Card Save Status
					String strresetjob="update ws_estimationm est inner join ws_jobcard job on (est.doc_no=job.refno and job.reftype='EST') set job.savestatus=0 where est.doc_no="+docno;
					int updateresetjob=stmt.executeUpdate(strresetjob);
					
					gipclaimno=gipclaimno==null || gipclaimno.trim().equalsIgnoreCase("") || gipclaimno.trim().equalsIgnoreCase("undefined")?"":gipclaimno.trim();
					gipdatetime=gipdatetime==null || gipdatetime.trim().equalsIgnoreCase("") || gipdatetime.trim().equalsIgnoreCase("undefined")?"":gipdatetime.trim();
					estimatedays=estimatedays==null || estimatedays.trim().equalsIgnoreCase("") || estimatedays.trim().equalsIgnoreCase("undefined")?"":estimatedays.trim();
					header=header==null || header.trim().equalsIgnoreCase("") || header.trim().equalsIgnoreCase("undefined")?"":header.trim();
					notes=notes==null || notes.trim().equalsIgnoreCase("") || notes.trim().equalsIgnoreCase("undefined")?"":notes.trim();
					internalremarks=internalremarks==null || internalremarks.trim().equalsIgnoreCase("") || internalremarks.trim().equalsIgnoreCase("undefined")?"":internalremarks.trim();
					hidchkservicelumsum=hidchkservicelumsum==null || hidchkservicelumsum.trim().equalsIgnoreCase("") || hidchkservicelumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkservicelumsum.trim();
					servicelumsumamt=servicelumsumamt==null || servicelumsumamt.trim().equalsIgnoreCase("") || servicelumsumamt.trim().equalsIgnoreCase("undefined")?"0":servicelumsumamt.trim();
					hidchkrandomlumsum=hidchkrandomlumsum==null || hidchkrandomlumsum.trim().equalsIgnoreCase("") || hidchkrandomlumsum.trim().equalsIgnoreCase("undefined")?"0":hidchkrandomlumsum.trim();
					randomlumsumamt=randomlumsumamt==null || randomlumsumamt.trim().equalsIgnoreCase("") || randomlumsumamt.trim().equalsIgnoreCase("undefined")?"0":randomlumsumamt.trim();
					
					String strupdateest="update ws_estimationm set sparetotal="+sparetotal+",sparediscount="+sparediscount+",sparenettotal="+netspare+",claimno='"+gipclaimno+"',gipdatetime='"+gipdatetime+"',estimatedays='"+estimatedays+"',header='"+header+"',notes='"+notes+"',internalremarks='"+internalremarks+"',chkservicelumsum="+hidchkservicelumsum+",servicelumsumamt="+servicelumsumamt+",chkrandomlumsum="+hidchkrandomlumsum+",randomlumsumamt="+randomlumsumamt+" where doc_no="+docno;
					int updateest=stmt.executeUpdate(strupdateest);
					if(updateest<=0){
						System.out.println("Master Update Error");
						errorstatus=1;
						return false;
					}
					int sparecount=0,labourcount=0;
					
					String strdeletespare="delete from ws_estimationspare where rdocno="+docno+" and addition=0";
					int deletespare=stmt.executeUpdate(strdeletespare);
					if(deletespare<0){
						errorstatus=1;
						return false;
					}
					String strdeletelabour="delete from ws_estimationlabour where rdocno="+docno+" and addition=0";
					int deletelabour=stmt.executeUpdate(strdeletelabour);
					if(deletelabour<0){
						errorstatus=1;
						return false;
					}
					for(int i=0;i<sparepartsarray.size();i++){
						String temp[]=sparepartsarray.get(i).split("::");
						sparecount++;
						temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"":temp[0].trim();
						temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
						temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
						temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();
						sparecount++;
						String strsql="insert into ws_estimationspare(rdocno, srno,description, qty, rate, approvedvalue, addition, confirmed, approved)values("+
						""+docno+","+sparecount+",'"+temp[0]+"',"+temp[1]+","+temp[2]+","+temp[3]+",0,1,0)";
						System.out.println(strsql);
						int gridinsert=stmt.executeUpdate(strsql);
						if(gridinsert<=0){
							errorstatus=1;
							return false;
						}
					}
					for(int i=0;i<labourcostarray.size();i++){
						String temp[]=labourcostarray.get(i).split("::");
						labourcount++;
						temp[0]=temp[0].trim().equalsIgnoreCase("")||temp[0].trim().equalsIgnoreCase("undefined")||temp[0]==null||temp[0].isEmpty()?"0":temp[0].trim();
						temp[1]=temp[1].trim().equalsIgnoreCase("")||temp[1].trim().equalsIgnoreCase("undefined")||temp[1]==null||temp[1].isEmpty()?"0":temp[1].trim();
						temp[2]=temp[2].trim().equalsIgnoreCase("")||temp[2].trim().equalsIgnoreCase("undefined")||temp[2]==null||temp[2].isEmpty()?"0":temp[2].trim();
						temp[3]=temp[3].trim().equalsIgnoreCase("")||temp[3].trim().equalsIgnoreCase("undefined")||temp[3]==null||temp[3].isEmpty()?"0":temp[3].trim();
						temp[4]=temp[4].trim().equalsIgnoreCase("")||temp[4].trim().equalsIgnoreCase("undefined")||temp[4]==null||temp[4].isEmpty()?"0":temp[4].trim();
						temp[5]=temp[5].trim().equalsIgnoreCase("")||temp[5].trim().equalsIgnoreCase("undefined")||temp[5]==null||temp[5].isEmpty()?"":temp[5].trim();
						String strjobtype=temp[6].trim().equalsIgnoreCase("")||temp[6].trim().equalsIgnoreCase("undefined")||temp[6]==null||temp[6].isEmpty()?"":temp[6].trim();
						String strjobdesc=temp[7].trim().equalsIgnoreCase("")||temp[7].trim().equalsIgnoreCase("undefined")||temp[7]==null||temp[7].isEmpty()?"":temp[7].trim();
						String seqno=temp[8].trim().equalsIgnoreCase("")||temp[8].trim().equalsIgnoreCase("undefined")||temp[8]==null||temp[8].isEmpty()?"":temp[8].trim();
						if(seqno.trim().equalsIgnoreCase("")){
							seqno=labourcount+"";
						}
						String strsql="insert into ws_estimationlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved,strjobtype,strjobdesc,seqno)values("+
								""+docno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+temp[5]+"',0,1,0,'"+strjobtype+"','"+strjobdesc+"',"+seqno+")";
						int gridinsert=stmt.executeUpdate(strsql);
						if(gridinsert<=0){
							errorstatus=1;
							return false;
						}
					}
					if(errorstatus==0){
						conn.commit();
						return true;
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
			return false;
	}
	
	public boolean delete(String gatedocno, String sparepartstotal,
			String labourtotal, String discount, String esttotal, Date sqldate,
			ArrayList<String> sparepartsarray,
			ArrayList<String> labourcostarray, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode,
			String brchName, String docno, String vocno) throws SQLException {
		// TODO Auto-generated method stub
				Connection conn=null;
				try{
					conn=objconn.getMyConnection();
					conn.setAutoCommit(false);
					CallableStatement stmtEst = conn.prepareCall("{call EstimatorDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");  
					stmtEst.setInt(12, Integer.parseInt(vocno));
					stmtEst.setInt(11, Integer.parseInt(docno));
					stmtEst.setDate(1,sqldate);	
					stmtEst.setString(2,gatedocno.trim().equalsIgnoreCase("")?"0":gatedocno);
					stmtEst.setString(3,sparepartstotal);
					stmtEst.setString(4, labourtotal);
					stmtEst.setString(5,discount);
					stmtEst.setString(6,esttotal);
					stmtEst.setString(7,formdetailcode);
					stmtEst.setString(8,mode);
					stmtEst.setString(9,session.getAttribute("USERID").toString());
					stmtEst.setString(10,brchName);
					stmtEst.setString(13,"0");
					stmtEst.setString(14,"0");
					stmtEst.setString(15,"0");
					stmtEst.setString(16,"0");
					stmtEst.setString(17,"0");
					stmtEst.setString(18, "");
					stmtEst.setString(19, "");   
					stmtEst.setString(20, "");    
					int updateval=stmtEst.executeUpdate();
					int errorstatus=0;
					if(updateval<0){
						System.out.println("Master Error");
						errorstatus=1;
						return false;
					}
					if(errorstatus==0){
						conn.commit();
						return true;
					}
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				return false;
	}
	
	public JSONArray getMasterSearch(String gatevocno,String cldet,String vehdet,String docno,String date,String id,
			String brhid,String regno) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!gatevocno.equalsIgnoreCase("")){
				sqltest+=" and gate.voc_no like '%"+gatevocno+"%'";
			}
			if(!cldet.equalsIgnoreCase("")){
				sqltest+=" and m.clientdet like '%"+cldet+"%'";
			}
			if(!vehdet.equalsIgnoreCase("")){
				sqltest+=" and m.vehicledet like '%"+vehdet+"%'";     
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and m.voc_no like '%"+docno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and gate.regno like '%"+regno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			if(!brhid.equalsIgnoreCase("")){
				sqltest+=" and m.brhid="+brhid;
			}
			strsql="select  m.clientdet,m.vehicledet,m.description,round(coalesce(m.sparetotal,0),2) sparetotal,round(coalesce(m.sparediscount,0),2) sparediscount,round(coalesce(m.sparenettotal,0),2) netspare,coalesce(insur.refname,'') gipinsurcomp,coalesce(m.claimno,'') gipclaimno,coalesce(m.gipdatetime,'') gipdatetime,coalesce(m.estimatedays,'') estimatedays,m.header,m.notes,m.internalremarks,m.chkservicelumsum,round(m.servicelumsumamt,2) servicelumsumamt,m.chkrandomlumsum,round(m.randomlumsumamt,2) randomlumsumamt,m.chklumsum,round(m.lumsumamount,2) lumsumamount,m.doc_no,m.voc_no,m.date,round(m.servicestotal,2) servicestotal, round(m.servicesdiscount,2) servicesdiscount, round(m.netservices,2) netservices,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ','Reg No ',coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
			" concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),"+
			" ' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_estimationm m left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no left join my_acbook insur on (insur.cldocno=gate.insurcldocno and insur.dtype='CRM') where m.status=3"+sqltest;
			System.out.println("master search--->>>"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public ClsEstimationBean viewdetails(int docno,int vocno) throws SQLException
	{
		ClsEstimationBean been=new ClsEstimationBean();
		Connection conn=null;
		
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="";
			String sqltest="";
			
			
			strsql="select m.clientdet,m.vehicledet,m.description,round(coalesce(m.sparetotal,0),2) sparetotal,round(coalesce(m.sparediscount,0),2) sparediscount,round(coalesce(m.sparenettotal,0),2) netspare,coalesce(m.brhid,0) estbrhid,coalesce(insur.refname,'') gipinsurcomp,coalesce(m.claimno,'') gipclaimno,coalesce(m.gipdatetime,'') gipdatetime,coalesce(m.estimatedays,'') estimatedays,m.header,m.notes,coalesce(m.internalremarks,'') internalremarks,"+
			" m.chkservicelumsum,round(m.servicelumsumamt,2) servicelumsumamt,m.chkrandomlumsum,round(m.randomlumsumamt,2) randomlumsumamt,m.chklumsum,round(m.lumsumamount,2) lumsumamount,m.doc_no,m.voc_no,m.date,round(m.servicestotal,2) servicestotal, round(m.servicesdiscount,2) servicesdiscount, round(m.netservices,2) netservices,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ','Reg No ',coalesce(gate.regno,''),' ',coalesce(gate.pltid,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
			" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
			" ' , Contact Person ',ac.contactperson) userdetails from ws_estimationm m left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no left join my_acbook insur on (insur.cldocno=gate.insurcldocno and insur.dtype='CRM') where m.status=3 and m.doc_no="+docno;
			System.out.println("viewdetails--->>>"+strsql);  
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()) {
				been.setTxtdesc(rs.getString("description"));  
				been.setClientdet(rs.getString("clientdet"));
				been.setVehicledet(rs.getString("vehicledet"));
				been.setSparetotal(rs.getString("sparetotal"));
				been.setSparediscount(rs.getString("sparediscount"));
				been.setNetspare(rs.getString("netspare"));
				been.setDate(rs.getDate("date").toString());
				been.setBrhid(rs.getString("estbrhid"));
				been.setGipdatetime(rs.getString("gipdatetime"));
				been.setEstimatedays(rs.getString("estimatedays"));
				been.setGateuserdetails(rs.getString("userdetails"));
				been.setGatedocno(rs.getString("gatedocno"));
				been.setGatevocno(rs.getString("gatevocno"));
				been.setDocno(rs.getString("doc_no"));
				been.setVocno(rs.getString("voc_no"));
				been.setGatevehicledetails(rs.getString("vehicledetails"));
				been.setServicesdiscount(rs.getString("servicesdiscount"));
				been.setNetservices(rs.getString("netservices"));
		  		been.setHeader(rs.getString("header"));
		  		been.setNotes(rs.getString("notes"));
		  		been.setInternalremarks(rs.getString("internalremarks"));
		  		been.setGipinsurcomp(rs.getString("gipinsurcomp"));
		  		been.setGipclaimno(rs.getString("gipclaimno"));
		  		been.setHidchkservicelumsum(rs.getString("chkservicelumsum"));
		  		if(been.getHidchkservicelumsum().trim().equalsIgnoreCase("1")){
		  			been.setServicelumsumamt(rs.getString("servicelumsumamt"));
		  		}
		  		been.setHidchkrandomlumsum(rs.getString("chkrandomlumsum"));
		  		if(been.getHidchkrandomlumsum().trim().equalsIgnoreCase("1")){
		  			been.setRandomlumsumamt(rs.getString("randomlumsumamt"));
		  		}
		  		been.setHidchklumsum(rs.getString("chklumsum"));
		  		if(been.getHidchklumsum().trim().equalsIgnoreCase("1")){
		  			been.setLumsumamount(rs.getString("lumsumamount"));
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
		return been;
	}
	public JSONArray getPartsData(String id,String partno,String prdctnme,String stock,String unit) throws SQLException{
		JSONArray partsdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return partsdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			//System.out.println("++++++++++"+unit);
			if(!(partno.equalsIgnoreCase("undefined"))&&!(partno.equalsIgnoreCase(""))&&!(partno.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.part_no like '%"+partno+"%'";
	        }
			if(!(prdctnme.equalsIgnoreCase("undefined"))&&!(prdctnme.equalsIgnoreCase(""))&&!(prdctnme.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.productname like '%"+prdctnme+"%'";
	        }
			if(!(stock.equalsIgnoreCase("undefined"))&&!(stock.equalsIgnoreCase(""))&&!(stock.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.balqty like '%"+stock+"%'";
	        }
			if(!(unit.equalsIgnoreCase("undefined"))&&!(unit.equalsIgnoreCase(""))&&!(unit.equalsIgnoreCase("0"))) {
				sqltest+=sqltest+" and a.unit like '%"+unit+"%'";
	        }
			String strsql="select * from ( select bd.brandname,m.fixingprice,m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,'' qty,sum(i.out_qty)"+
			" outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice"+
			" from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
			" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
			" where m.status=3 group by i.prdid  order by i.date) a where 1=1 " +sqltest+" ";
			
			//System.out.println(strsql);
			
			ResultSet rs=stmt.executeQuery(strsql);
			partsdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return partsdata;
	}   
}
