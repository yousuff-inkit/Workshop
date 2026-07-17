package com.dashboard.workshop.goodsissue;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.testng.reporters.jq.ResultsByClass;

import net.sf.json.JSONArray;

import com.connection.*;
import com.common.*;
/* 
 * import com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO;*/

public class ClsGoodsIssueDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getPartsData(String id,String fromdate,String todate,String srvcadvisor) throws SQLException{
		JSONArray partsdata=new JSONArray();
		
		if(!id.equalsIgnoreCase("1")){
			return partsdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and srvcm.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and srvcm.date<='"+sqltodate+"'";
			}
			if(!srvcadvisor.equalsIgnoreCase("") && !srvcadvisor.equalsIgnoreCase("undefined")){
				sqltest+=" and parts.rdocno="+srvcadvisor;
			}
/*			String strsql="select srvcm.doc_no srvcdocno,main.psrno partdocno,main.part_no partno,main.productname,part.qty,u.unit,main.munit as unitdocno,"+
			" sum(i.out_qty) outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,sum(i.op_qty) as totqty,i.stockid as"+
			" stkid,i.cost_price unitprice from  gl_worksrvcadvisorm srvcm left join gl_worksrvcadvisorparts part on part.rdocno=srvcm.doc_no"+
			" left join my_main main on part.productdocno=main.psrno  left join my_unitm u on main.munit=u.doc_no left join my_prodattrib at"+
			" on(at.mpsrno=main.doc_no) left join my_prddin i on(i.psrno=main.psrno and i.prdid=main.doc_no and i.specno=at.mspecno) where"+
			" srvcm.status=3"+sqltest+" group by i.prdid  order by i.date ";*/
			/*sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) */
			String strsql="select srvc.doc_no srvcdocno,at.mspecno as specid,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,m.psrno partdocno,m.psrno prodoc,"+
			" parts.qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qutval,"+
			" sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"+
			" sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty))*i.cost_price savecost_price,i.cost_price from gl_worksrvcadvisorm srvc left join"+
			" gl_worksrvcadvisorparts parts on srvc.doc_no=parts.rdocno left join my_locm loc on srvc.brhid=loc.brhid left join"+
			" my_main m on parts.productdocno=m.psrno left join my_unitm u on"+
			" m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no inner join"+
			" my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid=srvc.brhid ) where parts.rdocno="+srvcadvisor+" and"+
			" m.status=3 and i.brhid=srvc.brhid and  i.locid=loc.doc_no group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0"+
			" order by i.prdid,i.date";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			partsdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return partsdata;
	}
	
	public JSONArray getSrvcAdvisorData(String id,String fromdate,String todate,String srvcadvisor) throws SQLException{
		JSONArray srvcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return srvcdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and srvcm.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and srvcm.date<='"+sqltodate+"'";
			}
			if(!srvcadvisor.equalsIgnoreCase("") && !srvcadvisor.equalsIgnoreCase("undefined")){
				sqltest+=" and srvcm.doc_no="+srvcadvisor;
			}
			String strsql="select a.doc_no locationid,ac.cldocno,srvcm.brhid,srvcm.doc_no,srvcm.date,case when gatem.agmtexist=1 and gatem.newdriver=0 then dr.name when gatem.agmtexist=0 and gatem.newdriver=0 then sal.sal_name else gatem.drivername end drivername,veh.fleet_no,veh.reg_no,"+
			" tech.name technician,bay.name bay,agmt.doc_no agmtno,agmt.voc_no agmtvocno,ac.refname from gl_worksrvcadvisorm srvcm left join "+
			" gl_worktechnician tech on srvcm.technicianid=tech.doc_no left join gl_workbay bay on srvcm.bayid=bay.doc_no left join gl_workgateinpassm "+
			" gatem on srvcm.gateinpassdocno=gatem.doc_no left join gl_vehmaster veh on gatem.fleet_no=veh.fleet_no left join gl_lagmt agmt on "+
			" gatem.fleet_no=agmt.perfleet left join my_acbook ac on (ac.cldocno=gatem.cldocno and ac.dtype='CRM') left join gl_drdetails dr on (gatem.driverid=dr.dr_id and dr.dtype='CRM' and gatem.agmtexist=1) left join my_salesman sal on (gatem.driverid=sal.doc_no and sal.sal_type='DRV' and gatem.agmtexist=0) left join (select doc_no,brhid from my_locm "+
			" loc group by brhid limit 1) a on (a.brhid=srvcm.brhid) left join gl_worksrvcadvisorparts parts on srvcm.doc_no=parts.rdocno where srvcm.status=3 "+
			" and srvcm.issuestatus<>1 and parts.rdocno is not null "+sqltest+" group by srvcm.doc_no order by srvcm.doc_no";
			
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			srvcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return srvcdata;
	}

	public JSONArray getSrvcAdvisorSearchData(String id,String fromdate,String todate) throws SQLException{
		JSONArray srvcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return srvcdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and srvcm.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and srvcm.date<='"+sqltodate+"'";
			}
			String strsql="select srvcm.doc_no,srvcm.date,veh.fleet_no,veh.reg_no,tech.name technician,bay.name bay from gl_worksrvcadvisorm srvcm left join"+
			" gl_worktechnician tech on srvcm.technicianid=tech.doc_no left join gl_workbay bay on srvcm.bayid=bay.doc_no left join"+
			" gl_workgateinpassm gatem on srvcm.gateinpassdocno=gatem.doc_no left join gl_vehmaster veh on gatem.fleet_no=veh.fleet_no left join"+
			" gl_lagmt agmt on gatem.fleet_no=agmt.perfleet left join gl_worksrvcadvisorparts parts on srvcm.doc_no=parts.rdocno where srvcm.status=3 "+
			" and srvcm.issuestatus<>1 and parts.rdocno is not null "+sqltest+" group by srvcm.doc_no order by srvcm.doc_no";
			
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			srvcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return srvcdata;
	}
	public int insert(Date sqlfromdate, Date sqltodate,
			ArrayList<String> partsarray, HttpSession session,
			HttpServletRequest request, String mode,String srvcdocno,int brhid,int locationid,int cldocno,int fleetno) throws SQLException {
		// TODO Auto-generated method stub
		int issuedocno=0;
		Connection conn=null;
		try{
	//		ClsGoodsissuenoteDAO goodsdao=new ClsGoodsissuenoteDAO();
			conn=objconn.getMyConnection();
			int type=getType(conn);
			int costtype=getCostType(conn);/*
			*/
			for(int i=0;i<partsarray.size();i++){
				System.out.println("Check Grid: "+partsarray.get(i));
			}
			System.out.println("Client Doc: "+cldocno);
			
		/*	issuedocno=goodsdao.insert(sqltodate, "BWGI-"+srvcdocno, "Goods Issue of Service Advisor "+srvcdocno, 0.0, session, mode, "GIS", request, partsarray, locationid, cldocno, 0,
					type, costtype, fleetno);
		*/	
			if(issuedocno<=0){
				return 0;
			}
			else{
				
				conn.setAutoCommit(false);
				Statement stmt=conn.createStatement();
				int errorstatus=0;
				for(int i=0;i<partsarray.size();i++){
					String temp[]=partsarray.get(i).split("::");
					String strsql="update gl_worksrvcadvisorparts set issueqty="+temp[3]+",issuestatus=1,issuedocno="+issuedocno+" where rdocno="+srvcdocno;
					int updateval=stmt.executeUpdate(strsql);
					if(updateval<=0){
						errorstatus=1;
						conn.close();
						return 0;
					}
					
				}
				String strupdatestatus="update gl_worksrvcadvisorm set issuestatus=1 where doc_no="+srvcdocno+" and status=3";
				int updatestatus=stmt.executeUpdate(strupdatestatus);
				if(updatestatus<=0){
					errorstatus=1;
					conn.close();
					return 0;
				}
				if(errorstatus==0){
					conn.commit();
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
		return issuedocno;
	}

	private int getCostType(Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select costtype from my_costunit where status=1 and costgroup='Fleet'";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				docno=rs.getInt("costtype");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return docno;
	}

	private int getType(Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select doc_no from my_issuetype where status=3 and type='Material'";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				docno=rs.getInt("doc_no");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return docno;
	}
}
