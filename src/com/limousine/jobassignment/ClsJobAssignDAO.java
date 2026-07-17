package com.limousine.jobassignment;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.limousine.limobooking.ClsLimoBookingDAO;
import com.operations.vehicletransactions.movement.ClsMovementDAO;

import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class ClsJobAssignDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public JSONArray getBookCounterData(String date,String id,String branch) throws SQLException{
		JSONArray counterdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return counterdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			
			String strsql="select book.doc_no,ac.refname from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join"+
			" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" where book.status=3 and book.date<='"+sqldate+"' and  (tran.assignstatus=0 or hours.assignstatus=0) and book.detailstatus<>3 group by book.doc_no"; 
			System.out.println("COUNT === "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			counterdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return counterdata;
	}
	
	public JSONArray getDetailData(String bookdocno,String id,String branch) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select book.doc_no,book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,"+
			" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on"+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates"+
			" pickup on (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand"+
			" brd on tran.brandid=brd.doc_no left join gl_vehmodel model on (tran.modelid=model.doc_no) where book.status=3 and book.detailstatus<>3 and book.doc_no="+bookdocno+" and"+
			" (tran.assignstatus=0) and (tran.transferbranch=0 or tran.transferbranch="+branch+") and tran.masterstatus<>4 union all"+
			" select book.doc_no,book.cldocno,book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type,hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress,brd.brand_name brand,"+
			" model.vtype model,hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join"+
			" my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no)"+
			" left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehbrand"+
			" brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) where book.status=3 and"+
			" book.doc_no="+bookdocno+" and (hours.assignstatus=0) and (hours.transferbranch=0 or hours.transferbranch="+branch+") and hours.masterstatus<>4 ";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			detaildata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
	public JSONArray getDriverData(String docno,String name,String mobile,String license,String date,String id)throws SQLException{
		JSONArray driverdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return driverdata;
		}
		Connection conn=null;
		try{
			String sqltest="";
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and doc_no like '%"+docno+"%'";
			}
			if(!name.equalsIgnoreCase("")){
				sqltest+=" and sal_name like '%"+name+"%'";
			}
			if(!mobile.equalsIgnoreCase("")){
				sqltest+=" and mobile like '%"+mobile+"%'";
			}
			if(!license.equalsIgnoreCase("")){
				sqltest+=" and lic_no like '%"+license+"%'";
			}
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqldate!=null){
				sqltest+=" and date like '"+sqldate+"'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,sal_name name,lic_no license,date,mobile from my_salesman where sal_type='DRV' and status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			driverdata=objcommon.convertToJSON(rs);
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return driverdata;
	}
	public JSONArray getFleetData(String fleetno,String fleetname,String brand,String model,String group,String allfleets,String gridbrandid,String gridmodelid,String id,String regno) throws SQLException{
		JSONArray fleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return fleetdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(allfleets.equalsIgnoreCase("0")){
				sqltest+=" and veh.brdid="+gridbrandid+" and veh.vmodid="+gridmodelid;
			}
			else if(allfleets.equalsIgnoreCase("1")){
				System.out.println("Inside All Fleets");
				if(!fleetno.equalsIgnoreCase("")){
					sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
				}
				if(!fleetname.equalsIgnoreCase("")){
					sqltest+=" and veh.flname like '%"+fleetname+"%'";
				}
				if(!brand.equalsIgnoreCase("")){
					sqltest+=" and veh.brdid="+brand;
				}
				if(!model.equalsIgnoreCase("")){
					sqltest+=" and veh.vmodid="+model;
				}
				if(!group.equalsIgnoreCase("")){
					sqltest+=" and veh.vgrpid="+group;
				}
				if(!regno.equalsIgnoreCase("")){
					sqltest+=" and veh.reg_no like '%"+regno+"%' ";
				}
			}
			
			String strsql="select veh.reg_no ,veh.fleet_no,veh.flname,brd.brand_name brand,model.vtype model,grp.gname from gl_vehmaster veh left join gl_vehbrand brd on"+
			" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no where"+
			" veh.statu=3 and veh.status='IN' and veh.limostatus=1 "+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			fleetdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return fleetdata;
	}







	public int insert(Date sqluptodate, String cmbprocess, String hiddriver,
			String fleetno, String cmbtransferbranch, int bookdocno,
			int detaildocno, HttpSession session, String mode, String formdetailcode,String brchname, HttpServletRequest request, String type)throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		int vocno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtassign=conn.createStatement();
			
			CallableStatement stmtJob =conn.prepareCall("{call limoJobAssignDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtJob.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtJob.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtJob.setDate(1, sqluptodate);
			stmtJob.setInt(2, bookdocno);
			stmtJob.setInt(3, detaildocno);
			stmtJob.setString(4, cmbprocess);
			stmtJob.setString(5, hiddriver==null || hiddriver.equalsIgnoreCase("")?"0":hiddriver);
			stmtJob.setString(6, fleetno==null || fleetno.equalsIgnoreCase("")?"0":fleetno);
			stmtJob.setString(7, cmbtransferbranch==null || cmbtransferbranch.equalsIgnoreCase("")?"0":cmbtransferbranch);
			stmtJob.setString(8, "0");
			stmtJob.setString(9, mode);
			stmtJob.setString(10, formdetailcode);
			stmtJob.setString(11, brchname);
			stmtJob.setString(12, session.getAttribute("USERID").toString());
			stmtJob.setString(13, session.getAttribute("COMPANYID").toString());
			stmtJob.executeQuery();
			docno=stmtJob.getInt("docNo");
			vocno=stmtJob.getInt("voc");
			if(docno<=0){
				return 0;
			}
			else{
				String strassignupdate="";
				String strbranchtran="";
				/*  1-Branch Transfer
		    	2-Assignment
		    	3-External Vendors  */
				
				if(cmbprocess.equalsIgnoreCase("1")){
					if(type.equalsIgnoreCase("Transfer")){
						strbranchtran="update gl_limobooktransfer set transferbranch="+cmbtransferbranch+" where doc_no="+detaildocno;
					}
					else if(type.equalsIgnoreCase("Limo")){
						strbranchtran="update gl_limobookhours set transferbranch="+cmbtransferbranch+" where doc_no="+detaildocno;
					}
					int updatebranch=stmtassign.executeUpdate(strbranchtran);
					if(updatebranch<0){
						return 0;
					}
				}
				else if(cmbprocess.equalsIgnoreCase("2")){
					
					if(type.equalsIgnoreCase("Transfer")){
						strassignupdate="update gl_limobooktransfer set assignstatus=1,masterstatus=3,assignedfleet="+fleetno+",assigneddriver="+hiddriver+" where doc_no="+detaildocno;
					}
					else if(type.equalsIgnoreCase("Limo")){
						strassignupdate="update gl_limobookhours set assignstatus=1,masterstatus=3,assignedfleet="+fleetno+",assigneddriver="+hiddriver+" where doc_no="+detaildocno;
					}
					int assignval=stmtassign.executeUpdate(strassignupdate);
					if(assignval<=0){
						return 0;
					}
					else{
						/*//Getting details for movement insertion
						java.sql.Date sqlcurrentdate=null;
						String jobname="";
						String strgetmovdetails="select doc_no,kmin,fin,CURDATE() currentdate from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no="+fleetno+")";
						Statement stmt=conn.createStatement();
						ResultSet rsmovdetails=stmt.executeQuery(strgetmovdetails);
						String maxmovdoc="",maxmovkm="",maxmovfuel="";
						while(rsmovdetails.next()){
							maxmovdoc=rsmovdetails.getString("doc_no");
							maxmovkm=rsmovdetails.getString("kmin");
							maxmovfuel=rsmovdetails.getString("fin");
							sqlcurrentdate=rsmovdetails.getDate("currentdate");
						}
						String strjobdetails="";
						if(type.equalsIgnoreCase("Transfer")){
							strjobdetails="select concat(bookdocno,' - ',docname) jobname from gl_limobooktransfer where doc_no="+detaildocno;
						}
						else if(type.equalsIgnoreCase("Limo")){
							strjobdetails="select concat(bookdocno,' - ',docname) jobname from gl_limobookhours where doc_no="+detaildocno;
						}
						ResultSet rsjobdetails=stmt.executeQuery(strjobdetails);
						while(rsjobdetails.next()){
							jobname=rsjobdetails.getString("jobname");
						}
						String strvehtrancode="select (select tran_code from gl_vehmaster where fleet_no="+fleetno+") tran_code,(select doc_no from my_locm where brhid="+brchname+""+
						" and status=3 limit 1) locid";
						String vehtrancode="",outlocation="";
						ResultSet rsveh=stmt.executeQuery(strvehtrancode);
						while(rsveh.next()){
							vehtrancode=rsveh.getString("tran_code");
							outlocation=rsveh.getString("locid");
						}
						String remarks="Limousine movement of type "+type+" for "+jobname;
						String outuser=session.getAttribute("USERID").toString();
						ClsMovementDAO movdao=new ClsMovementDAO();
						int movinsert=movdao.insert(sqlcurrentdate, dateout, fleetno, outlocation, timeout, maxmovkm, maxmovfuel, "TR", hiddriver, remarks, 
						outuser, null, 0, null, 0.0, null, null, "A", session, 0, 0, 0, 0,0, "MOV", brchname, vehtrancode);*/
						
						//2016-09-20::2016-09-10::1010348::5::10:28::62666.00::0.125::TR::1::Checking Values for Limousine::::null::0::null::0.0::null::null::
						//A::session::0::0::0::0::0::MOV::1::RR
						
					}
				
				}
				conn.commit();
				request.setAttribute("VOCNO", vocno);
				return docno;	
			}
				
			}
		
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}
}
