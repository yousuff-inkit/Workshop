package com.dashboard.vehicle.vehiclepickup;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.replacement.ClsReplacementBean;

public class ClsVehiclePickUpDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(String agmtno, String cmbagmttype, String fleet_no,
			Date indate, String intime, String inkm, String cmbinfuel,String cmbbranch,HttpSession session,String cldocno,String mode,String pickdesc) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int docno=0;
			if(inkm.equalsIgnoreCase("")){
				inkm="0";
			}
			if(cmbinfuel.equalsIgnoreCase("")){
				cmbinfuel="0";
			}
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtPickUp = conn.prepareCall("{CALL vehPickupDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtPickUp.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtPickUp.setString(1,cmbagmttype);
			stmtPickUp.setString(2,agmtno);
			stmtPickUp.setString(3,cldocno);
			stmtPickUp.setString(4, fleet_no);
			stmtPickUp.setDate(5,indate);
			stmtPickUp.setString(6,intime);
			stmtPickUp.setString(7,inkm);
			stmtPickUp.setString(8,cmbinfuel);
			stmtPickUp.setString(9,session.getAttribute("USERID").toString());
			stmtPickUp.setString(10,cmbbranch);
			stmtPickUp.setString(12,mode);
			stmtPickUp.setString(13,pickdesc);
			stmtPickUp.executeQuery();
			docno=stmtPickUp.getInt("docNo");
			if(docno>0){
				conn.commit();
				stmtPickUp.close();
				conn.close();				
				return docno;
			}
			else{
				stmtPickUp.close();
				conn.close();
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
		return 0;
	}

	
	public JSONArray getPickUpData(String branch) throws SQLException {
		//java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
		//System.out.println("Date"+sqlStartDate);
		Connection conn =null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			JSONArray jsonArray = new JSONArray();
			/**/
			 String strSql = "select veh.flname,pick.doc_no,ac.refname,ac.per_mob,pick.fleet_no,veh.reg_no,if(pick.agmttype='RAG',ragmt.odate,lagmt.outdate) startdate,"+
					 " if(pick.agmttype='RAG',ragmt.otime,lagmt.outtime) starttime,if(pick.agmttype='RAG',ragmt.okm,lagmt.outkm) startkm,"+
					 " if(pick.agmttype='RAG',ragmt.ofuel,lagmt.outfuel) startfuel,pick.pdate,pick.ptime,pick.pkm,pick.pfuel from gl_vehpickup pick left join gl_ragmt ragmt on (pick.agmttype='RAG' and pick.agmtno=ragmt.doc_no) left join"+
					 " gl_lagmt lagmt on (pick.agmttype='LAG' and pick.agmtno=lagmt.doc_no) left join my_acbook ac on (pick.cldocno=ac.cldocno and"+
					 " ac.dtype='CRM') left join gl_vehmaster veh on pick.fleet_no=veh.fleet_no where pick.status=3";
//			System.out.println("Pickup Query:"+strSql);	
			 ResultSet resultSet = stmt.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		
	    return RESULTDATA;
	}
	
	
	
	
	public  ClsVehiclePickUpBean getPrint(int docno) throws SQLException {
		 ClsVehiclePickUpBean printbean = new ClsVehiclePickUpBean();
		 Connection conn = null; 
		 try {
			 conn = ClsConnection.getMyConnection();
	       Statement stmtpaint = conn.createStatement();
	       String strSql="";
	     /* strSql=("select coalesce(dr.name,dr1.name) drivenby,coalesce(r.description,'') description,deldrv.sal_name deldriver,coldrv.sal_name coldriver,"+
	    		  " outloc.loc_name outloc,inloc.loc_name inloc,v.flname infleetname,v1.flname outfleetname,loc.loc_name,r.delstatus delstatus1,r.clstatus,"+
	    		  " usr.user_name,opusr.user_name openuser,main.branchname mainbrch,inbr.branchname inandcolbrch,outbr.branchname outanddelbrch,st.st_desc,"+
	    		  " ac.acno,ac.refname,r.reptype,r.DOC_NO,DATE_FORMAT(r.DATE,'%d-%m-%Y') DATE,if(r.RTYPE='RAG','Rental','Lease') rtype,r.RDOCNO,r.RFLEETNO,"+
	    		  " DATE_FORMAT(r.RDATE,'%d-%m-%Y') RDATE,r.RTIME,round(r.RKM) rkm,r.RFUEL 'RFUEL',r.RLOCID,r.TRANCODE,r.REPTYPE,r.USERID,"+
	    		  " r.OBRHID,r.OLOCID,r.OFLEETNO,DATE_FORMAT(r.ODATE,'%d-%m-%Y') odate,r.OTIME,round(r.OKM) okm,r.ofuel 'ofuel',"+
	    		  " if(r.DELSTATUS=0,'NO','YES') delstatus ,r.DELDRVID,r.DELTIME,DATE_FORMAT(r.DELDATE,'%d-%m-%Y') DELDATE,round(r.DELKM) delkm,"+
	    		  " r.DELFUEL 'DELFUEL',r.DELAT,DATE_FORMAT(r.INDATE,'%d-%m-%Y') indate,r.INTIME,round(r.INKM) inkm,r.INFUEL 'infuel',r.INLOC,"+
	    		  " r.CLSTATUS,r.CLDRVID,DATE_FORMAT(r.CLDATE,'%d-%m-%Y') cldate,r.CLTIME,round(r.CLKM) clkm,r.CLFUEL 'CLFUEL', v.flname,"+
	    		  " concat(au.authid,'-',p.code_name,'-',v.reg_no) reg_no , concat(au1.authid,'-',p1.code_name,'-',v1.reg_no) reg_no2 from"+
	    		  " gl_vehreplace r left join gl_vehmaster v on v.fleet_no=r.rfleetno  left join gl_vehplate p on p.doc_no=v.pltid left join"+
	    		  " gl_vehauth au on au.doc_no=v.authid left join gl_vehmaster v1 on v1.fleet_no=r.OFLEETNO  left join gl_vehplate p1 on"+
	    		  " p1.doc_no=v1.pltid left join gl_vehauth au1 on au1.doc_no=v1.authid left join my_brch main on r.rbrhid=main.doc_no"+
	    		  " left join my_brch inbr on r.INBRHID=inbr.doc_no left join my_brch outbr on r.OBRHID=outbr.doc_no left join my_locm loc on"+
	    		  " r.rlocid=loc.doc_no left join gl_ragmt agmt on (r.rdocno=agmt.doc_no and r.rtype='RAG') left join gl_lagmt lagmt on"+
	    		  " (r.rdocno=lagmt.doc_no and r.rtype='LAG') left join my_acbook ac on (((agmt.cldocno=ac.cldocno and r.rtype='RAG' and ac.dtype='CRM') or (lagmt.cldocno=ac.cldocno and r.rtype='LAG'))"+
	    		  " and ac.dtype='CRM') left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno"+
	    		  " left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
	    		  " left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
	    		  " left join gl_status st on st.status=r.trancode  left join my_user usr on usr.doc_no=r.userid"+
	    		  " left join my_user opusr on opusr.doc_no=r.outuserid left join my_locm outloc on r.olocid=outloc.doc_no left join my_locm inloc"+
	    		  " on r.inloc=inloc.doc_no left join my_salesman deldrv on (r.deldrvid=deldrv.doc_no and deldrv.sal_type='DRV') left join my_salesman"+
	    		  " coldrv on (r.cldrvid=coldrv.doc_no and coldrv.sal_type='DRV' )where r.doc_no="+docno+" ");*/
	       strSql="select coalesce(pick.desc1,'') pickdesc,DATE_FORMAT(if(pick.agmttype='RAG',ragmt.date,lagmt.date),'%d-%m-%Y') vradate,agmtbr.branchname agmtbranch,"+
	    		  " pickbr.branchname pickbranch,agmtloc.loc_name,pick.agmttype,if(pick.agmttype='RAG',ragmt.voc_no,lagmt.voc_no) agmtno,ac.cldocno,ac.acno,ac.refname,coalesce(coalesce(dr.name,dr1.name),'')"+
	    		  " drivenby,coalesce(if(pick.agmttype='RAG',ragmt.desc1,lagmt.desc1),'') description,pick.doc_no,DATE_FORMAT(pick.DATE,'%d-%m-%Y') DATE,"+
	    		  " pick.fleet_no,veh.flname,concat(auth.authid,'-',plate.code_name,'-',veh.reg_no) reg_no,DATE_FORMAT(if(pick.agmttype='RAG',"+
	    		  " ragmt.odate,lagmt.outdate),'%d-%m-%Y') startdate,if(pick.agmttype='RAG',ragmt.otime,lagmt.outtime) starttime,"+
	    		  " round(if(pick.agmttype='RAG',ragmt.okm,lagmt.outkm),2) startkm, if(pick.agmttype='RAG',ragmt.ofuel,lagmt.outfuel) startfuel,"+
	    		  " DATE_FORMAT(pick.pdate,'%d-%m-%Y') pdate,pick.ptime,round(pick.pkm,2) pkm,pick.pfuel from gl_vehpickup pick left join gl_ragmt ragmt on "+
	    		  " (pick.agmtno=ragmt.doc_no and pick.agmttype='RAG') left join gl_lagmt lagmt on (pick.agmtno=lagmt.doc_no and pick.agmttype='LAG') "+
	    		  " left join my_acbook ac on (pick.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_rdriver rdr on ragmt.doc_no=rdr.rdocno left join gl_ldriver "+
	    		  " ldr on lagmt.doc_no=ldr.rdocno left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM') left join gl_drdetails"+
	    		  " dr1 on ((ragmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV') left join my_brch agmtbr on (if(pick.agmttype='RAG',"+
	    		  " ragmt.brhid=agmtbr.doc_no,lagmt.brhid=agmtbr.doc_no)) left join my_locm agmtloc on (if(pick.agmttype='RAG',"+
	    		  " ragmt.locid=agmtloc.doc_no,0)) left join gl_vehmaster veh on pick.fleet_no=veh.fleet_no left join gl_vehauth auth on"+
	    		  " veh.authid=auth.doc_no left join gl_vehplate plate on plate.doc_no=veh.pltid left join my_brch pickbr on pick.brhid=pickbr.doc_no"+
	    		  " where pick.doc_no="+docno;
		       
	      // concat('On',' ',DATE_FORMAT(edate, '%d-%m-%Y'),' ','at',' ',DATE_FORMAT(edate, '%H:%i')) opendate

	       ResultSet resultSet = stmtpaint.executeQuery(strSql); 
	       
	      ClsCommon common=new ClsCommon();
	       while(resultSet.next()){
	    	  printbean.setLblagmtbranch(resultSet.getString("agmtbranch"));
	    	  printbean.setLblpickbranch(resultSet.getString("pickbranch"));
	    	  printbean.setLblagmtloc(resultSet.getString("loc_name"));
	    	  printbean.setLblagmttype(resultSet.getString("agmttype"));
	    	  printbean.setLblvrano(resultSet.getString("agmtno"));
	    	  printbean.setLblclientacno(resultSet.getString("acno"));
	    	  printbean.setLblrefname(resultSet.getString("refname"));
	    	  printbean.setLbldrivenby(resultSet.getString("drivenby"));
	    	  printbean.setLblagmtdesc(resultSet.getString("description"));
	    	  printbean.setLbldocno(resultSet.getString("doc_no"));
	    	  printbean.setLbldate(resultSet.getString("date"));
	    	  printbean.setLblfleet_no(resultSet.getString("fleet_no"));
	    	  printbean.setLblflname(resultSet.getString("flname"));
	    	  printbean.setLblregno(resultSet.getString("reg_no"));
	    	  printbean.setLblstartdate(resultSet.getString("startdate"));
	    	  printbean.setLblstarttime(resultSet.getString("starttime"));
	    	  printbean.setLblstartkm(resultSet.getString("startkm"));
	    	  printbean.setLblstartfuel(common.checkFuelName(conn, resultSet.getString("startfuel")));
	    	  printbean.setLblpdate(resultSet.getString("pdate"));
	    	  printbean.setLblptime(resultSet.getString("ptime"));
	    	  printbean.setLblpkm(resultSet.getString("pkm"));
	    	  printbean.setLblpfuel(common.checkFuelName(conn, resultSet.getString("pfuel")));
	    	   printbean.setLblvradate(resultSet.getString("vradate"));
	    	  printbean.setLblpickdesc(resultSet.getString("pickdesc"));
	       }
	       
	       stmtpaint.close();
	       
	       
	       Statement stmtinvoice10 = conn.createStatement ();
		    String  companysql="select c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname from gl_vehreplace r  "
		    		+ " left join my_brch b on r.rbrhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

		    
	         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   
		  
		    	   printbean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   printbean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   printbean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   printbean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   printbean.setFax(resultsetcompany.getString("fax"));
		    	   printbean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
	       
	       
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	      conn.close();
	      }
		 finally{
				conn.close();
			}
	      return printbean;
	     }


	public boolean delete(int docno,String mode,HttpSession session,String cmbbranch) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtPickUp = conn.prepareCall("{CALL vehPickupDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtPickUp.setInt(11,docno);
			stmtPickUp.setString(1,null);
			stmtPickUp.setString(2,null);
			stmtPickUp.setString(3,null);
			stmtPickUp.setString(4, null);
			stmtPickUp.setDate(5,null);
			stmtPickUp.setString(6,null);
			stmtPickUp.setString(7,null);
			stmtPickUp.setString(8,null);
			stmtPickUp.setString(9,session.getAttribute("USERID").toString());
			stmtPickUp.setString(10,cmbbranch);
			stmtPickUp.setString(12,mode);
			stmtPickUp.setString(13,null);
			int val=stmtPickUp.executeUpdate();
			
			if(val>0){
				conn.commit();
				stmtPickUp.close();
				conn.close();				
				return true;
			}
			else{
				stmtPickUp.close();
				conn.close();
				return false;
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


}
