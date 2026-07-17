package com.workshop.wsestimation;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.connection.*;
import com.controlcentre.masters.vehiclemaster.vehicle.ClsVehicleBean;
import com.common.*;

import net.sf.json.JSONArray;

public class ClsWSEstimationDAO {
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
			strsql="select convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' Reg No: ',coalesce(gate.regno,''),' Plate Code: ',"+
			" coalesce(gate.pltid,''),' YoM: ',coalesce(yom.yom,''),' Others: ',coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no,gate.voc_no,"+
			" gate.date,gate.cldocno,gate.regno,ac.refname,concat(coalesce(ac.refname,''),' , Address: ',coalesce(ac.address,''),' , Telephone: ',coalesce(ac.per_tel,''),' , Mobile: ',"+
			" coalesce(ac.per_mob,''),' , Mail: ',coalesce(ac.mail1,''),' , Contact Person ',coalesce(ac.contactperson,'')) userdetails from ws_gateinpass gate left join my_acbook "+
			" ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join gl_vehbrand "+
			" brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on "+
			" gate.yom=yom.doc_no where gate.status=3 and gate.processstatus=1 and approvalreq=1 and backjob=0"+sqltest;
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
	public JSONArray getComplaints(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select comp.compname complaint,gate.desc1 description,comp.doc_no complaintid from ws_gateinpassd gate left join gl_complaint comp on gate.complaintid=comp.doc_no where gate.rdocno="+docno;
			System.out.println("+++++++++++++"+strsql);
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
	
	public JSONArray getLabourSearchData(String jobdocno,String jobtype,String date,String id) throws SQLException{
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
				sqltest+=" and t.type like '%"+jobtype+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			strsql="select m.desc1 jobdesc,m.doc_no,m.date,m.stdrate hrs,m.stdcostperhr rate,t.type jobtype,m.jobid from ws_jobmaster m left join ws_jobtype t on m.jobid=t.doc_no where m.status=3"+sqltest;
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
	public int insert(String gatedocno, String sparepartstotal,
			String labourtotal, String discount, String esttotal, Date sqldate,
			ArrayList<String> sparepartsarray,
			ArrayList<String> labourcostarray, HttpSession session,
			HttpServletRequest request, String mode, String formdetailcode,
			String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0,vocno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtEst = conn.prepareCall("{call WSEstimationDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEst.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtEst.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtEst.setDate(1,sqldate);
			stmtEst.setString(2,gatedocno);
			stmtEst.setString(3,sparepartstotal);
			stmtEst.setString(4, labourtotal);
			stmtEst.setString(5,discount);
			stmtEst.setString(6,esttotal);
			stmtEst.setString(7,formdetailcode);
			stmtEst.setString(8,mode);
			stmtEst.setString(9,session.getAttribute("USERID").toString());
			stmtEst.setString(10,brchName);
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
				int sparecount=0,labourcount=0;
				Statement stmt=conn.createStatement();
				for(int i=0;i<sparepartsarray.size();i++){
					String temp[]=sparepartsarray.get(i).split("::");
					sparecount++;
					
					String strsql="insert into ws_estspare(rdocno, srno, psrno, qty, rate, markupper, total, remarks, addition, confirmed, approved)values("+
					""+docno+","+sparecount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+(temp[5].equalsIgnoreCase("undefined")?"":temp[5])+"',0,0,0)";
					int gridinsert=stmt.executeUpdate(strsql);
					if(gridinsert<=0){
						errorstatus=1;
						return 0;
					}
				}
				for(int i=0;i<labourcostarray.size();i++){
					String temp[]=labourcostarray.get(i).split("::");
					labourcount++;
					String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved)values("+
					""+docno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+(temp[5].equalsIgnoreCase("undefined")?"":temp[5])+"',0,0,0)";
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
	public boolean edit(String gatedocno, String sparepartstotal,
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
					CallableStatement stmtEst = conn.prepareCall("{call WSEstimationDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtEst.setInt(12, Integer.parseInt(vocno));
					stmtEst.setInt(11, Integer.parseInt(docno));
					stmtEst.setDate(1,sqldate);
					stmtEst.setString(2,gatedocno);
					stmtEst.setString(3,sparepartstotal);
					stmtEst.setString(4, labourtotal);
					stmtEst.setString(5,discount);
					stmtEst.setString(6,esttotal);
					stmtEst.setString(7,formdetailcode);
					stmtEst.setString(8,mode);
					stmtEst.setString(9,session.getAttribute("USERID").toString());
					stmtEst.setString(10,brchName);
					int updateval=stmtEst.executeUpdate();
					int errorstatus=0;
					if(updateval<0){
						errorstatus=1;
						return false;
					}
					else{
						int sparecount=0,labourcount=0;
						Statement stmt=conn.createStatement();
						String strdeletespare="delete from ws_estspare where rdocno="+docno;
						int deletespare=stmt.executeUpdate(strdeletespare);
						if(deletespare<0){
							errorstatus=1;
							return false;
						}
						String strdeletelabour="delete from ws_estlabour where rdocno="+docno;
						int deletelabour=stmt.executeUpdate(strdeletelabour);
						if(deletelabour<0){
							errorstatus=1;
							return false;
						}
						for(int i=0;i<sparepartsarray.size();i++){
							String temp[]=sparepartsarray.get(i).split("::");
							sparecount++;
							
							String strsql="insert into ws_estspare(rdocno, srno, psrno, qty, rate, markupper, total, remarks, addition, confirmed, approved)values("+
							""+docno+","+sparecount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+(temp[5].equalsIgnoreCase("undefined")?"":temp[5])+"',0,0,0)";
							int gridinsert=stmt.executeUpdate(strsql);
							if(gridinsert<=0){
								errorstatus=1;
								return false;
							}
						}
						for(int i=0;i<labourcostarray.size();i++){
							String temp[]=labourcostarray.get(i).split("::");
							labourcount++;
							String strsql="insert into ws_estlabour(rdocno, srno, jobid, hrs, rate, markupper, total, remarks, addition, confirmed, approved)values("+
							""+docno+","+labourcount+","+temp[0]+","+temp[1]+","+temp[2]+","+temp[3]+","+temp[4]+",'"+(temp[5].equalsIgnoreCase("undefined")?"":temp[5])+"',0,0,0)";
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
					CallableStatement stmtEst = conn.prepareCall("{call WSEstimationDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtEst.setInt(12, Integer.parseInt(vocno));
					stmtEst.setInt(11, Integer.parseInt(docno));
					stmtEst.setDate(1,sqldate);
					stmtEst.setString(2,gatedocno);
					stmtEst.setString(3,sparepartstotal);
					stmtEst.setString(4, labourtotal);
					stmtEst.setString(5,discount);
					stmtEst.setString(6,esttotal);
					stmtEst.setString(7,formdetailcode);
					stmtEst.setString(8,mode);
					stmtEst.setString(9,session.getAttribute("USERID").toString());
					stmtEst.setString(10,brchName);
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
	
	public  ClsWSEstimationBean getViewDetails(String docno) throws SQLException {
		ClsWSEstimationBean bean = new ClsWSEstimationBean();
		Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			
			String strsql="select m.doc_no docno,m.voc_no vocno,m.date,round(m.sparetot,2) sparepartstotal, round(m.labouttot,2) labourcosttotal, round(m.discount,2) discount, round(m.nettotal,2) nettotal,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
			" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
			" ' , Contact Person ',ac.contactperson) userdetails from ws_estm m left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no where m.status=3 and m.doc_no='"+docno+"'";
			
			ResultSet resultSet = stmt.executeQuery(strsql);
			
			while (resultSet.next()) {
				bean.setDocno(resultSet.getString("docno"));
				bean.setVocno(resultSet.getString("vocno"));
				bean.setDate(resultSet.getString("date"));
				bean.setSparepartstotal(resultSet.getString("sparepartstotal"));
				bean.setLabourtotal(resultSet.getString("labourcosttotal"));
				bean.setDiscount(resultSet.getString("discount"));
				bean.setEsttotal(resultSet.getString("nettotal"));
				bean.setGatevehicledetails(resultSet.getString("vehicledetails"));
				bean.setGatedocno(resultSet.getString("gatedocno"));
				bean.setGatevocno(resultSet.getString("gatevocno"));
				bean.setGateuserdetails(resultSet.getString("userdetails"));
			}
			
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
	
	public JSONArray getMasterSearch(String gatevocno,String cldocno,String clientname,String docno,String date,String id) throws SQLException
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
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and n.voc_no like '%"+docno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			
			strsql="select m.doc_no,m.voc_no,m.date,round(m.sparetot,2) sparepartstotal, round(m.labouttot,2) labourcosttotal, round(m.discount,2) discount, round(m.nettotal,2) nettotal,"+
			" convert(concat(coalesce(brd.brand_name,''),' ',coalesce(model.vtype,''),' ',coalesce(yom.yom,''),' Others: ',"+
			" coalesce(gate.vehother,'')),char(200)) vehicledetails,gate.doc_no gatedocno,gate.voc_no gatevocno,gate.cldocno,gate.regno,ac.refname,"+
			" concat(ac.refname,' , Address: ',ac.address,' , Telephone: ',ac.per_tel,' , Mobile: ',ac.per_mob,' , Mail: ',ac.mail1,"+
			" ' , Contact Person ',ac.contactperson) userdetails from ws_estm m left join ws_gateinpass gate on m.gipno=gate.doc_no left join"+
			" my_acbook ac on (gate.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehplate plate on gate.pltid=plate.doc_no left join"+
			" gl_vehbrand brd on gate.brdid=brd.doc_no left join gl_vehmodel model on gate.modid=model.doc_no left join gl_yom yom on"+
			" gate.yom=yom.doc_no where m.status=3"+sqltest;
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
	
	public JSONArray getSparepartsData(String docno,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select * from ( select spare.qty,spare.rate,spare.markupper markuppercent,spare.total,spare.remarks,bd.brandname brand,bd.doc_no brdid,m.psrno partdocno,m.part_no partno,m.productname description,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.out_qty)"+
			" outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as stock,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice"+
			" from ws_estspare spare left join my_main m on spare.psrno=m.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
			" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
			" where m.status=3 and  spare.rdocno="+docno+" group by i.prdid  order by i.date) a";
			System.out.println("Spare Parts: "+strsql);
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
			String strsql="select m.desc1 jobdesc,m.doc_no,m.date,lab.hrs,lab.rate,t.type jobtype,lab.markupper markuppercent,lab.total,lab.remarks, "+
			" lab.jobid from ws_estlabour lab left join ws_jobmaster m on (lab.jobid=m.doc_no ) left join ws_jobtype t on m.jobid=t.doc_no "+
			" where m.status=3 and lab.addition=0 and lab.rdocno='"+docno+"'";
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
}
