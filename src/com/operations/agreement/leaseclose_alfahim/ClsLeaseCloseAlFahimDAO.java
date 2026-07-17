package com.operations.agreement.leaseclose_alfahim;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.testng.reporters.jq.ResultsByClass;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.invoices.lease.ClsLeaseInvoiceDAO;
import com.dashboard.invoices.leasealfahim.ClsLeaseInvoiceAlFahimDAO;
import com.finance.transactions.creditnote.ClsCreditNoteDAO;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;
import com.operations.agreement.leaseclose.ClsLeaseCloseBean;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsLeaseCloseAlFahimDAO {
	ClsCommon objcommon =new ClsCommon();
	ClsConnection objconn=new ClsConnection();
public  JSONArray accountstatementSearch(String rentaldocval) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
     
    Connection conn =null;
try {
  conn=objconn.getMyConnection();
 Statement stmtVeh4 = conn.createStatement ();
/* String sql="select j.acno,j.doc_no transno,j.tr_no,j.tranid,j.dtype transtype,j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,  CONVERT(if(j.ldramount>0,"+
 " round((j.ldramount*1),2),''),CHAR(100)) debit,  CONVERT(if(j.ldramount<0,round((j.ldramount*-1),2),''),CHAR(100)) credit,if(j.description='0','',j.description)"+
 " description  from my_jvtran j inner join gl_lagmt r   on j.rdocno=r.doc_no and rtype='LAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and "+
 " c.acno=j.acno  where  j.status=3 and  j.rdocno="+rentaldocval+"  and j.rtype='LAG'   union all ( select acno,transno,tr_no,tranid,transtype,trdate,rentaldoc,rentaltype,"+
 " if(sum(gr.debit)=0,'',round(sum(gr.debit),2)),if(sum(gr.credit)=0,'',round(sum(gr.credit),2)),if(description='0','',description) description    from "+
 " (select j1.acno,j1.doc_no transno,j1.tr_no,j1.tranid,j1.dtype transtype,j1.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,   CONVERT(if(j1.ldramount>0,"+
 " round((j1.ldramount*1),2),''),CHAR(100)) debit,   CONVERT(if(j1.ldramount<0,round((j1.ldramount*-1),2),''),CHAR(100)) credit,j.ldramount,if(j1.description='0','',"+
 " j1.description) description  from my_jvtran j inner join   my_outd d on d.ap_trid=j.tranid inner join my_jvtran j1 on d.tranid=j1.tranid  inner join gl_lagmt r "+
 " on j.rdocno=r.doc_no and j.rtype='LAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno   where  j.status=3 and  j.rdocno="+rentaldocval+" "+
 " and j.rtype='LAG' and j1.tr_no is not null group by j1.doc_no) gr group by gr.tranid) order by trdate";*/
 
 
 /*
	String sql="select a.*,if(a.transtype in ('INV','INS','INT'),m.voc_no,a.transno) transno  from (select j.acno,j.doc_no transno,j.tr_no,j.tranid,j.dtype transtype,j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,  "
			+ "	CONVERT(if(j.ldramount>0,round((j.ldramount*1),2),''),CHAR(100)) debit,  CONVERT(if(j.ldramount<0,round((j.ldramount*-1),2),''),   CHAR(100)) credit, "
			+ " if(j.description='0','',j.description) description  from my_jvtran j inner join gl_lagmt r  "
			+ "  	on j.rdocno=r.doc_no and rtype='LAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno  "
			+ "   where  j.status=3 and  j.rdocno='"+rentaldocval+"' 	and j.rtype='LAG'  union all  "
			+ "     ( select acno,transno,tr_no,tranid,transtype,trdate,rentaldoc,rentaltype,   if(sum(gr.debit)=0,'',round(sum(gr.debit),2)),if(sum(gr.credit)=0,'',round(sum(gr.credit),2)) "
			+ " ,if(description='0','',description) description   	from  (select j1.acno,j1.doc_no transno,j1.tr_no,j1.tranid,j1.dtype transtype,j1.date trdate,j.rdocno rentaldoc,j.rtype rentaltype, "
			+ "    CONVERT(if(j1.ldramount>0,round((j1.ldramount*1),2),''),CHAR(100)) debit, 	CONVERT(if(j1.ldramount<0,round((j1.ldramount*-1),2),''),CHAR(100)) credit,j.ldramount,if(j1.description='0','',j1.description)  "
			+ "  description  from my_jvtran j inner join  	my_outd d on d.ap_trid=j.tranid      inner join my_jvtran j1 on d.tranid=j1.tranid  inner join gl_lagmt r  "
			+ "   	on j.rdocno=r.doc_no and j.rtype='LAG' inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno    "
			+ "    	where  j.status=3 and j.rdocno='"+rentaldocval+"' and j.rtype='LAG'   and j1.tr_no is not null group by j1.doc_no) gr group by gr.tranid)) a "
			+ "  left join gl_invm m on m.dtype=a.transtype and a.transno=m.doc_no order by trdate ";
 */
 
 	//#Second select is for selecting applied  reciepts		  
 String sql="select a.*,if(a.transtype in ('INV','INS','INT'),m.voc_no,a.transno) transno  from (select j.acno,j.doc_no transno,j.tr_no,j.tranid,"+
			" j.dtype transtype,j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,CONVERT(if(j.ldramount>0,round((j.ldramount*1),2),''),CHAR(100)) "+
			" debit,CONVERT(if(j.ldramount<0,round((j.ldramount*-1),2),''),CHAR(100)) credit,if(j.description='0','',j.description) description"+
			" from my_jvtran j inner join gl_lagmt r on (j.rdocno=r.doc_no and rtype='LAG') left join my_acbook c on (r.cldocno=c.cldocno and"+
			" c.dtype='CRM' and c.acno=j.acno) left join (select acno from my_account where codeno='rsecurity') h on j.acno=h.acno"+
			" where j.status=3 and j.rdocno="+rentaldocval+" and j.rtype='LAG' and (c.doc_no is not null or h.acno is not null) union all"+
			" ( select acno,transno,tr_no,tranid,transtype,trdate,rentaldoc,rentaltype,   if(sum(gr.debit)=0,'',round(sum(gr.debit),2)),"+
			" if(sum(gr.credit)=0,'',round(sum(gr.credit),2)),if(description='0','',description) description   	from  ("+
			" select j1.acno,j1.doc_no transno,j1.tr_no,j1.tranid,j1.dtype transtype,j1.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,"+
			" CONVERT(if(j1.ldramount>0,round((j1.ldramount*1),2),''),CHAR(100)) debit,CONVERT(if(j1.ldramount<0,round((j1.ldramount*-1),2),''),"+
			" CHAR(100)) credit,j.ldramount,if(j1.description='0','',j1.description) description  from my_jvtran j inner join my_outd d on "+
			" d.ap_trid=j.tranid inner join my_jvtran j1 on d.tranid=j1.tranid  inner join gl_lagmt r on (j.rdocno=r.doc_no and j.rtype='LAG' )"+
			" inner join my_acbook c on (c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno ) where j.status=3 and j.rdocno="+rentaldocval+" and j.rtype='LAG' "+
			" and j1.tr_no is not null group by j1.doc_no) gr group by gr.tranid)) a left join gl_invm m on m.dtype=a.transtype and "+
			" a.transno=m.doc_no";
 

 
 
 /*String sql="select doc_no transno,dtype transtype,date trdate,rdocno rentaldoc,rtype rentaltype,description, "
   + "CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(100)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(100)) credit "
   + " from my_jvtran  where  status=3 and  rdocno='"+rentaldocval+"' and rtype='LAG' " ;
 */
// System.out.println("sql"+sql);
 
 ResultSet resultSet = stmtVeh4.executeQuery(sql);
 RESULTDATA=objcommon.convertToJSON(resultSet);
 stmtVeh4.close();
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
//System.out.println(RESULTDATA);
     return RESULTDATA;
 }
public JSONArray trafficinvoSearch(String rentaldoc) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
     
    Connection conn =null;
try {
 conn=objconn.getMyConnection();
 Statement stmtVeh8 = conn.createStatement ();
       
 /*String sql="select regno,ticket_no,time,traffic_date,fleetno,amount,inv_no,source  "
		   + "  from gl_traffic where ra_no='"+rentaldoc+"' and rtype in('RA','RD','RW','RF','RM') and inv_no is not null and inv_no>0";
 */
 
	String sql="select t.regno,t.ticket_no,t.time,t.traffic_date,t.fleetno,t.amount,i.voc_no inv_no,t.source " 
			+ " from gl_traffic t left join gl_invm i on i.doc_no=t.inv_no 	where t.ra_no=='"+rentaldoc+"' and  "
					+ " t. rtype in('LA','LC') and inv_no is not null and inv_no>0 " ;
 
 ResultSet resultSet = stmtVeh8.executeQuery(sql);
 RESULTDATA=objcommon.convertToJSON(resultSet);
 stmtVeh8.close();
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
//System.out.println(RESULTDATA);
     return RESULTDATA;
 }
public JSONArray trafficNotinvoSearch(String rentaldocs) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
     
    Connection conn =null;
try {
  conn=objconn.getMyConnection();
 Statement stmtVeh4 = conn.createStatement ();
 
/* String sql="select regno,ticket_no,time,traffic_date,fleetno,amount,source  "
		   + "  from gl_traffic where ra_no='"+rentaldocs+"' and rtype in('RA','RD','RW','RF','RM') and (inv_no is null or inv_no=0) ;";
 */
 
 String sql="select regno,ticket_no,time,traffic_date,fleetno,amount,source  "
			+ "  from gl_traffic where ra_no='"+rentaldocs+"' and rtype in('LA','LC') and (inv_no is null or inv_no=0) ;";
	
 
 ResultSet resultSet = stmtVeh4.executeQuery(sql);
 RESULTDATA=objcommon.convertToJSON(resultSet);
 stmtVeh4.close();
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
//System.out.println(RESULTDATA);
     return RESULTDATA;
 }
public JSONArray getReplacedVehicle(String agmtno) throws SQLException {
  
    JSONArray ReplaceData=new JSONArray();
    Connection conn=null;
	
	try {
		conn = objconn.getMyConnection();
		Statement stmtreplace = conn.createStatement();
			agmtno=agmtno==null?"0":agmtno;
			String strSql="select rep.ofleetno,rep.odate,rep.otime,rep.indate,rep.intime,rep.rfleetno infleetno,rep.doc_no repdoc,v.reg_no regnoin,veh.reg_no regnoout"+
					" from gl_lagmt agmt left join  gl_vehreplace rep on agmt.doc_no=rep.rdocno left join gl_vehmaster v on v.fleet_no=rep.rfleetno   left join gl_vehmaster veh "+
		        	" on veh.fleet_no=rep.ofleetno  where rep.status<>7 and rep.rtype='LAG' and agmt.doc_no="+agmtno+" order by rep.doc_no DESC";
//        	System.out.println("Replace Query:"+strSql);
			ResultSet rsreplace = stmtreplace.executeQuery(strSql);
			ReplaceData=objcommon.convertToJSON(rsreplace);
			stmtreplace.close();
	}

	catch(Exception e){
		e.printStackTrace();
		//conn.close();stmtTarif.close();
		conn.close();
		return ReplaceData;
		  
	}
	finally{
		conn.close();
	}
	//System.out.println("RESULTDATA=========>"+RESULTDATA);
	
	conn.close();
    return ReplaceData;
    
}
	public  ClsLeaseCloseAlFahimBean getViewDetails(String agreementno,int docno) throws SQLException {
		// TODO Auto-generated method stub
		
		ClsLeaseCloseAlFahimBean bean=new ClsLeaseCloseAlFahimBean();
		Connection conn=null;
		try {
			//System.out.println("Here in view dao");
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String strSql="select coalesce(plate.code_name,'') platecode,coalesce(rclosem.desc1,'') closedesc,rclosem.locid,rclosem.agmtbranch,agmt.doc_no agmtno,rclosem.doc_no,agmt.voc_no,rclosem.voc_no voucherno,coalesce(agmt.desc1,'') desc1,rclosem.date,rclosem.cldocno,rclosem.colstatus,round(rclosem.colkm,2) colkm,rclosem.coldrid,rclosem.colfuel,rclosem.coldate,rclosem.coltime,"+
					" rclosem.chkinid,rclosem.rlaid,round(rclosem.colchg,2) colchg,round(rclosem.daysused,2) daysused,rclosem.hrsused,round(rclosem.totalkm,2) totalkm,"+
					" round(rclosem.excesskm,2) excesskm,round(rclosem.inkm,2) inkm,rclosem.infuel,rclosem.indate,rclosem.intime,rclosem.fleet_no,"+
					" veh.flname,veh.reg_no,drv.sal_name driver,chk.sal_name checkin,rla.sal_name rentalagent,ac.refname,ac.address,ac.per_mob,ac.mail1,"+
					" clr.color,grp.gname from gl_lagmtclosem rclosem left join gl_lagmt agmt on rclosem.agmtno=agmt.doc_no left join my_salesman drv"+
					" on(drv.doc_no=rclosem.coldrid and drv.sal_type='DRV') left join my_salesman chk on(chk.doc_no=rclosem.chkinid and chk.sal_type='CHK')"+
					" left join my_salesman rla on (rla.doc_no=rclosem.rlaid and rla.sal_type='RLA') left join my_acbook ac on(rclosem.cldocno=ac.cldocno"+
					" and ac.dtype='CRM') left join gl_vehmaster veh on(rclosem.fleet_no=veh.fleet_no) left join my_color clr on(veh.clrid=clr.doc_no)"+
					" left join gl_vehgroup grp on(veh.vgrpid=grp.doc_no) left join gl_vehplate plate on veh.pltid=plate.doc_no where rclosem.doc_no="+docno;
			System.out.println("View Sql:"+strSql);
			ResultSet resultSet = stmt.executeQuery(strSql);
			while(resultSet.next()){
			bean.setCmbcloseloc(resultSet.getString("locid"));
				bean.setHidcmbagmtbranch(resultSet.getString("agmtbranch"));
				bean.setVocno(resultSet.getString("voc_no"));
				bean.setVoucherno(resultSet.getInt("voucherno"));
				bean.setAgreementno(agreementno);
				bean.setDocno(docno);
				bean.setClientid(resultSet.getString("cldocno"));
				bean.setHidchkcollection(resultSet.getString("colstatus"));
				bean.setChaufferid(resultSet.getString("coldrid"));
				bean.setHidcmbcollectfuel(resultSet.getString("colfuel"));
				
				if(resultSet.getDate("coldate")!=null){
				bean.setHidcollectdate(resultSet.getDate("coldate").toString());
				}
				bean.setCollectkm(resultSet.getString("colkm"));
				bean.setHidcollecttime(resultSet.getString("coltime"));
				bean.setHidcheckin(resultSet.getString("chkinid"));
				bean.setCheckin(resultSet.getString("checkin"));
				bean.setHidrentalagent(resultSet.getString("rlaid"));
				bean.setRentalagent(resultSet.getString("rentalagent"));
				/*bean.setHidcmbcheckin(resultSet.getString("chkinid"));
				bean.setHidcmbrentalagent(resultSet.getString("rlaid"));*/
				bean.setHidfleet(resultSet.getString("fleet_no"));
				bean.setUseddays(resultSet.getString("daysused"));
				bean.setUsedhours(resultSet.getString("hrsused"));
				bean.setTotalkm(resultSet.getString("totalkm"));
				bean.setExcesskm(resultSet.getString("excesskm"));
				bean.setInkm(resultSet.getString("inkm"));
				bean.setHidcmbinfuel(resultSet.getString("infuel"));
				if(!(resultSet.getDate("indate")==null)){
				bean.setHidindate(resultSet.getDate("indate").toString());
				}
				bean.setHidintime(resultSet.getString("intime"));
				String temp=resultSet.getString("fleet_no");
				temp=temp+" ,"+resultSet.getString("flname");
				temp=temp+" ,Reg No:"+resultSet.getString("reg_no");
				temp=temp+" ,Color:"+resultSet.getString("color");
				temp=temp+" ,Group:"+resultSet.getString("gname");
				temp=temp+" ,Plate Code:"+resultSet.getString("platecode");
				bean.setVehicle(temp);
				String temp1=resultSet.getString("refname");
				temp1=temp1+",Address:"+resultSet.getString("address");
				temp1=temp1+",Mail ID:"+resultSet.getString("mail1");
				temp1=temp1+",Mobile:"+resultSet.getString("per_mob");
				bean.setClient(temp1);
				bean.setHidclosedate(resultSet.getDate("date").toString());
				bean.setChauffer(resultSet.getString("driver"));
				bean.setDescription(resultSet.getString("closedesc"));
				bean.setCollectchg(resultSet.getString("colchg"));
				//System.out.println("Fuel "+resultSet.getString("infuel"));
				stmt.close();
				conn.close();
				return bean;
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
	public JSONArray getCheckIn() throws SQLException {
	  
	    JSONArray CheckData=new JSONArray();
	    
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmtCheck = conn.createStatement();
				//agmtno=agmtno==null?"0":agmtno;
	        	String strSql="select doc_no,sal_name from my_salesman where sal_type='CHK' and status<>7";
	        	//System.out.println(strSql);
				ResultSet rscheckin = stmtCheck.executeQuery(strSql);
				CheckData=objcommon.convertToJSON(rscheckin);
				stmtCheck.close();
		}

		catch(Exception e){
			e.printStackTrace();
			//conn.close();stmtTarif.close();
			conn.close();
			return CheckData;
			  
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		
		conn.close();
	    return CheckData;
	    
	}
	public JSONArray getRentalAgent() throws SQLException {
	  
	    JSONArray RentalData=new JSONArray();
	    
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmtrental=conn.createStatement();
				//agmtno=agmtno==null?"0":agmtno;
	        	String strrental="select doc_no,sal_name from my_salesman where sal_type='RLA' and status<>7";
	        	//System.out.println(strSql);
				ResultSet rsrental = stmtrental.executeQuery(strrental);
				RentalData=objcommon.convertToJSON(rsrental);
				stmtrental.close();
		}

		catch(Exception e){
			e.printStackTrace();
			//conn.close();stmtTarif.close();
			conn.close();
			return RentalData;
			  
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		
		conn.close();
	    return RentalData;
	    
	}
	public  JSONArray getSearchDetails() throws SQLException {
		 Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmtTarif = conn.createStatement();	
				String strSql="select doc_no,date,agmtno from gl_lagmtclosem where status<>7";
	        	//System.out.println(strSql);
				ResultSet resultSet = stmtTarif.executeQuery(strSql);
				if (!resultSet.isBeforeFirst() ) {    
					conn.close();
					return RESULTDATA;
					} 
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtTarif.close();
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
	public JSONArray mainSearch(HttpSession session,String sclname,String smob,String rno,String flno,String sregno,String searchdate,String branch,String allbranch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	    	
       // String brnchid=session.getAttribute("BRANCHID").toString();
    	//System.out.println("name"+sclname);
        Connection conn=null;
		try {
					
    	String sqltest="";
    	java.sql.Date sqldate=null;
    	if(!(searchdate.equalsIgnoreCase(""))){
    		sqldate=objcommon.changeStringtoSqlDate(searchdate);
    	}
    	if(sqldate!=null){
    		sqltest=sqltest+" and l.date='"+sqldate+"'";
    	}
    	if(!(sclname.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.RefName like '%"+sclname+"%'";
    	}
    	if(!(smob.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.per_mob like '%"+smob+"%'";
    	}
    	if(!(rno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and agmt.voc_no like '%"+rno+"%'";
    	}
    	if(!(flno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and (agmt.tmpfleet like '%"+flno+"%' or agmt.perfleet like '%"+flno+"%')";
    	}
    	if(!(sregno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and veh.reg_no like '%"+sregno+"%'";
    	}
		sqltest+=" and l.status<>7";
    	/*if(!(smra.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and agmt.mrano like '%"+smra+"%'";
    	}*/
    	 if(allbranch.equalsIgnoreCase("1")){
    		 
    	 }
    	 else{
    		 if(!branch.equalsIgnoreCase("")){
    			 sqltest+=" and l.brchid="+branch;
    		 }
    	 }
        
     conn = objconn.getMyConnection();
				Statement stmtVeh7 = conn.createStatement ();
				String str1Sql="select l.voc_no voucherno,agmt.voc_no,l.doc_no,l.agmtno,if(agmt.perfleet=0,tmpfleet,perfleet) fleet_no,a.refname,a.per_mob,veh.reg_no,l.date from gl_lagmtclosem l left join gl_lagmt agmt on"+
						" (l.agmtno=agmt.doc_no) left join gl_vehmaster veh on (if(agmt.perfleet=0,tmpfleet,perfleet)=veh.fleet_no) left join my_acbook a"+
						" on (a.cldocno= l.cldocno and a.dtype='CRM') where 1=1 "+sqltest+" group by l.doc_no";
				//System.out.println("=========="+str1Sql);
				ResultSet resultSet = stmtVeh7.executeQuery(str1Sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVeh7.close();
				conn.close();
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
	public  JSONArray getCalcData_view(String agmtno) throws SQLException {
		 
			
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn=null;
		try {
		conn=objconn.getMyConnection();	

		Statement stmtclosecal=conn.createStatement();
		//Determining closecal in gl_config;if 1=>Start Date taken as Invoice Date,Otherwise 0=>Start Date taken as Agreement Out Date 
		String strclosecal="select method from gl_config where field_nme='closecal'";
		int closecal=0;
		ResultSet rsclosecal=stmtclosecal.executeQuery(strclosecal);
		while(rsclosecal.next()){
			closecal=rsclosecal.getInt("method");
		}
		stmtclosecal.close();
		String strSql="";
		
		if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase(null)){
				agmtno="0";
			}
			if(!(agmtno.equalsIgnoreCase("0"))){
				Statement stmtCalcview = conn.createStatement();
				
				
				
				
					if(closecal==0){
				
					strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
							" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote from gl_invmode m left join"+
							" (select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
							" gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1 group by idno"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
							" gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
							" gl_lcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";
					
					
				}
				
				else if(closecal==1){
				/*	strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoice,if((r.total-r.invoiced)>0,"+
							" (r.total-r.invoiced),0) invoiced,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote"+
							" from gl_invmode m left join"+
							" (select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,"+
							" if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
							" gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1 group by idno"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
							" gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
							" gl_lcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1 ) r on(m.idno=r.idno) where r.idno is not null";
*/
					
					strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,0 invoice,r.creditnote from gl_invmode m left join "+
							" (select r.idno,(select qty from gl_lcalc	where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,"+
							" 0 invoice,sum(cnote) creditnote from gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+"  and afterclose=0 and"+
							" rowno>=(select min(rowno) from gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1)  and calcstatus=1"+
							" group by idno"+

							" union all select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,"+
							" 0 invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_lcalc r where r.idno in(8,14) and "+
							" rdocno="+agmtno+" and afterclose=0  and rowno>=(select min(rowno) from gl_lcalc r where r.idno not in(8,14) and rdocno="+agmtno+" and afterclose=0 "+
							" and calcstatus=1) "+
							" union all select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,"+
							" sum(invoiced) invoiced,0 invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_lcalc r "+
							" where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and rowno>=(select min(rowno) from gl_lcalc r where r.idno not in(9,15) "+
							" and rdocno="+agmtno+" and afterclose=0 and calcstatus=1) ) r on(m.idno=r.idno) where r.idno is not null";
				
				
				
				}	        	
        	
	        	
//	        	System.out.println("Calc Query View:"+strSql);
	        	/*System.out.println("Statement Calc:"+stmtcalc);
	        	System.out.println("connection Calc:"+conn);*/
					strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,r.invoice,r.creditnote,r.salamount,r.salikrate,"+
							" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
							" (select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount)+sum(cnote),0) total,sum(invoiced)"+
							" invoiced,sum(amount) invoice,sum(cnote) creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1 group by idno"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount)+sum(cnote),0) total,sum(invoiced)"+
							" invoiced,sum(amount) invoice,sum(cnote) creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount)+sum(cnote),0) total,sum(invoiced)"+
							" invoiced,sum(amount) invoice,sum(cnote) creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_lcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1 ) r on(m.idno=r.idno) where r.idno is not null";
						System.out.println(strSql);
					
				ResultSet rstotalview = stmtCalcview.executeQuery(strSql);
				 if(rstotalview!=null) {
					 RESULTDATA=objcommon.convertToJSON(rstotalview);
					 
				 }
				 stmtCalcview.close();
				}
				 conn.close();
				 return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
	}
	public JSONArray getReferenceTarif(String agmtno) throws SQLException {
		 
			
		 //Statement stmtRef = conn.createStatement();
		
	    JSONArray REFDATA=new JSONArray();
	  Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtRef=conn.createStatement();
			// if(conn!=null){
				// stmtRef= conn.createStatement();
			// }
				
	        	String strSql="select rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg from gl_rtarif where "+
	        	" rdocno="+agmtno+" and rstatus not in(5,6,7) and rentaltype<>(select rentaltype from gl_rtarif where rdocno="+agmtno+" and rstatus=5) order by rstatus";
//	        	System.out.println("Reference Tarif Sql"+strSql);
//	        	System.out.println("asd==========="+stmtRef);
				ResultSet rsref = stmtRef.executeQuery(strSql);
				if(rsref!=null){
				REFDATA=objcommon.convertToJSON(rsref);
				}
//				System.out.println("=============================");
			//	rsref.close();
				//stmtRef.close();
				stmtRef.close();
				conn.close();
				
				return REFDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return REFDATA;

		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	
	}
	public  JSONArray getTotalData_view(String agmtno) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn=null;
	    try {
	    	conn=objconn.getMyConnection();
		if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase("0") || agmtno.equalsIgnoreCase(null)){
			conn.close(); 
			return RESULTDATA;
		}
	    
		
			if(!(agmtno.equalsIgnoreCase("0"))){
				Statement stmtTotalview = conn.createStatement();
			
	        	String strSql="select rentaltype,rate ,cdw,pai,cdw1 ,pai1 ,gps,babyseater,cooler,exkmrte ,chaufchg  from gl_lagmtclosed where  status=3 and rdocno="+agmtno;
//	        	System.out.println("=====getTotalData_view========"+strSql);
				ResultSet rstotalview = stmtTotalview.executeQuery(strSql);
				if(rstotalview!=null){
						RESULTDATA=objcommon.convertToJSON(rstotalview);
				}
				stmtTotalview.close();	
			}
					
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
		 
		 conn.close();
		 return RESULTDATA;
	}
	public  JSONArray getAgmtno(String docno,String fleet,String regno,String client,String date,String mobile,String branch) throws SQLException {
		//java.sql.Date sqlStartDate = objcommon.changeStringtoSqlDate(date);
		//System.out.println("Date"+sqlStartDate);
		 Connection conn =null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
		conn=objconn.getMyConnection();
		Statement stmtAgmtno=conn.createStatement();
				
			String sqltest="";
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=" and m1.voc_no="+docno;
			}
			/*if(!(fleet.equalsIgnoreCase("")||fleet.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m1.tmpfleet like '%"+fleet+"%'";
			}*/
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
			}
			if(!(client.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+client+"%'";
			}
			if(!(mobile.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}
			if(!(fleet.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and (m1.tmpfleet like '%"+fleet+"%' or m1.perfleet like '%"+fleet+"%')";
	    	}
			java.sql.Date sqlsearchdate=null;
			if(!(date.equalsIgnoreCase(""))){
				sqlsearchdate=objcommon.changeStringtoSqlDate(date);
			}
			if(!(sqlsearchdate==null)){
				sqltest=sqltest+" and m1.date='"+sqlsearchdate+"'";
			}
//			System.out.println("Default SqlTest:"+sqltest);
			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			JSONArray jsonArray = new JSONArray();
			 String strSql = "select plate.code_name platecode,br.branchname,m1.voc_no,coalesce(m1.desc1,'') desc1,m1.doc_no,m1.date,m1.cldocno,m1.acno,round(m1.delivery,0) delivery,coalesce(round(if(m1.delstatus=1,m1.delchg,0),0),0) deliverychg,if(m1.perfleet=0,m1.tmpfleet,m1.perfleet) fleet_no"+
					 ",ac.refname,ac.address,ac.mail1,ac.per_mob,c.color,grp.gname gid,v.reg_no,v.flname from gl_lagmt m1"+
					 " left join gl_vehmaster v on (m1.tmpfleet=v.fleet_no or m1.perfleet=v.fleet_no) left join my_color c on"+
					 " (v.clrid=c.doc_no ) left join gl_vehgroup grp on(v.vgrpid=grp.doc_no ) left join gl_vehplate plate on v.pltid=plate.doc_no left join"+
					 " my_acbook ac on (m1.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vmove mov on "
					 + "(m1.doc_no=mov.rdocno and mov.rdtype='LAG') left join my_brch br on m1.brhid=br.doc_no where m1.clstatus=0 and v.tran_code<>'CU' and m1.brhid="+branch+" "+sqltest+" group by m1.doc_no";
			 //System.out.println("CHECKING SQL"+strSql);
				ResultSet rsagmtno = stmtAgmtno.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(rsagmtno);
				stmtAgmtno.close();
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
		
		conn.close();
	    return RESULTDATA;
	}
	public  JSONArray getTrafficdata(String agmtno) throws SQLException {
	    
	    JSONArray TRAFFICDATA=new JSONArray();
	    
	  Connection conn=objconn.getMyConnection();
		try {
			conn = objconn.getMyConnection();	
				//agmtno=agmtno==null?"0":agmtno;
			if(agmtno.equalsIgnoreCase(null)||agmtno.equalsIgnoreCase("")){
				agmtno="0";
			}
			//System.out.println("Agmtno in traffic:"+agmtno);
			if(!(agmtno.equalsIgnoreCase("0"))){
				Statement stmtStatement = conn.createStatement();
				String strSql="select regno,ticket_no,time,traffic_date,fleetno,amount,inv_no,trim(desc1) desc1 from gl_traffic where ra_no="+agmtno+" and rtype in('LA','LC')";
//	        System.out.println("Traffic Query"+strSql);
				ResultSet rstraffic=stmtStatement.executeQuery(strSql);
	        	if(rstraffic!=null){
	        		TRAFFICDATA=objcommon.convertToJSON(rstraffic);
	        		
	        	}
				stmtStatement.close();
			}
				conn.close();
			   return TRAFFICDATA;
			
		}
	catch(Exception e){
			e.printStackTrace();
			conn.close();
			return TRAFFICDATA;
			  
		}
		finally{
			conn.close();
		}
		
	    
	}
	public  JSONArray getCollect() throws SQLException {
	  
	    JSONArray RESULTDATA=new JSONArray();
	    
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmtCollect = conn.createStatement();
				//agmtno=agmtno==null?"0":agmtno;
	        	String strSql="select doc_no,sal_name,lic_no,lic_exp_dt from my_salesman where sal_type='DRV' and status<>7";
	        	//System.out.println(strSql);
				ResultSet resultSet = stmtCollect.executeQuery(strSql);
				if (!resultSet.isBeforeFirst() ) {    
					conn.close();
					return RESULTDATA; 
					} 
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtCollect.close();
		conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			//conn.close();stmtTarif.close();
			conn.close();
			return RESULTDATA;
			  
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		
		conn.close();
	    return RESULTDATA;
	    
	}
	public  JSONArray getAgmtTarifData(String agmtno) throws SQLException {
	   Connection conn =null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmtagmt = conn.createStatement();
	        	String strSql="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest ,exkmrte ,chaufchg ,"+
	        			" chaufexchg  from gl_ltarif where rdocno="+agmtno;
	        	//System.out.println(strSql);
	        	ResultSet rsagmt = stmtagmt.executeQuery(strSql);
				if(rsagmt!=null){
					RESULTDATA=objcommon.convertToJSON(rsagmt);
				}
					
				stmtagmt.close();
					conn.close();
					return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
		
	}
	public  JSONArray getTotalData(String useddays,String usedhours,String totalkm,String excesskm,String agmtno,String rentaltype,
			String agmtdate,String closedate,java.sql.Date closeinvdate) throws SQLException {
		//System.out.println("Here in java");
		JSONArray RESULTDATA=new JSONArray();
		Connection conn=null;
		try{
			
			conn=objconn.getMyConnection();
		if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase("0")){
			conn.close(); 
			return RESULTDATA;
		}
			/*	if(useddays.equalsIgnoreCase("0")){
			conn.close(); 
			return RESULTDATA;
		}*/
		
		if(agmtdate==null){
			conn.close(); 
			return RESULTDATA;
		}
		if(closedate==null || closedate.equalsIgnoreCase("0")){
			conn.close(); 
			return RESULTDATA;
		}
		rentaltype="Monthly";
//		System.out.println("Check Agreement No:"+agmtno);
		String defaulttarif=rentaltype;

		
		Statement stmtTarif = conn.createStatement();
		
		Statement stmtrentaltype=conn.createStatement();
	    
		
	Statement stmtmonthcal=conn.createStatement();
	int monthcalvalue=0;
	int monthcalmethod=0;
	double takenvalue=0.0;
	String selectedtarif="";
	String strmonthcal2="select method,value from gl_config where field_nme='lesmonthlycal'";
	ResultSet rsmonthcal2=stmtmonthcal.executeQuery(strmonthcal2);
	while(rsmonthcal2.next()){
		monthcalmethod=rsmonthcal2.getInt("method");
		monthcalvalue=rsmonthcal2.getInt("value");
	}
	rsmonthcal2.close();
	String strgetmonthcal="";
	java.sql.Date agmtdate1=null,closedate1=null;
	if(!((agmtdate.equalsIgnoreCase("0"))||(agmtdate.equalsIgnoreCase("")))){
		agmtdate1=objcommon.changeStringtoSqlDate(agmtdate);
	}
	if(!((closedate.equalsIgnoreCase("0"))||(closedate.equalsIgnoreCase("")))){
		closedate1=objcommon.changeStringtoSqlDate(closedate);
	}
	if(monthcalmethod==1){
		strgetmonthcal="SELECT DAY(LAST_DAY('"+agmtdate1+"')) monthdays";
		ResultSet rsgetmonthcal=stmtmonthcal.executeQuery(strgetmonthcal);
		while(rsgetmonthcal.next()){
		monthcalvalue=rsgetmonthcal.getInt("monthdays");
		}
	}
	stmtmonthcal.close();
	int tconvmethod=0;
	
	//double monthcal=funGetMonthCal(monthcalmethod,Integer.parseInt(useddays),monthcalvalue,monthlyrate,sqlagmtdate,sqlclosedate);
	
	
	//Getting the No of days corresponding to Monthlycal 
	int rentalno=0;
	double days=0.0,hours=0.0;
	//System.out.println("Used Days"+useddays);
	if(useddays.equalsIgnoreCase("")){
		useddays="0";
	}
	if(usedhours.equalsIgnoreCase("")){
		usedhours="0";
	}
	if(!(useddays.equalsIgnoreCase("0"))){
		days=Double.parseDouble(useddays);
	}
	if(!(usedhours.equalsIgnoreCase("0"))){
		hours=Double.parseDouble(usedhours);
	}
	
	
	
/*	//Determining From Date to Calculate corresponding upload value in gl_ragmt
		Statement stmtupload=conn.createStatement();
		
		String strupload="select if(upload='up' and uploaddate is not null,uploaddate,odate) fromdate from gl_lagmt where doc_no="+agmtno;
		ResultSet rsupload=stmtupload.executeQuery(strupload);
		if(rsupload.next()){
			agmtdate1=rsupload.getDate("fromdate");
		}
		stmtupload.close();
		
		*/
	
	
	int closecal=0,delcal=0,delstatus=0;
	java.sql.Date odate=null;
	Statement stmttconv=conn.createStatement();
	String strtconv="select (select method from gl_config where field_nme='tconv')method,(select method from gl_config where field_nme='closecal')closecal,"
			+ "(select method from gl_config where field_nme='delcal')delcal,(select delstatus from gl_lagmt where doc_no="+agmtno+")delstatus,(select outdate from gl_lagmt where doc_no="+agmtno+")odate";
	ResultSet rstconv=stmttconv.executeQuery(strtconv);
	while(rstconv.next()){
		tconvmethod=rstconv.getInt("method");
		closecal=rstconv.getInt("closecal");
		delcal=rstconv.getInt("delcal");
		delstatus=rstconv.getInt("delstatus");
		odate=rstconv.getDate("odate");
	}
	//System.out.println("Closecal: "+closecal+"::::::odate: "+odate+":::::::closeinvdate: "+closeinvdate);
	stmttconv.close();
	java.sql.Date tempdeldate=null;
	if(delcal==1 && delstatus==1){
		Statement stmtdelmov=conn.createStatement();
		String sqldelmov="select din from gl_vmove where repno=0 and trancode='DL' and rdtype='LAG' and rdocno="+agmtno;
		ResultSet rsdelmov=stmtdelmov.executeQuery(sqldelmov);
		while(rsdelmov.next()){
			tempdeldate=rsdelmov.getDate("din");
		}
	}
	tempdeldate=tempdeldate==null?odate:tempdeldate;
	
		
	
	

	
	String strcloseconv="select if("+closecal+"=1,1,0) conv";
	//System.out.println("Close Convertion Query: "+strcloseconv);
	Statement stmtcloseconv=conn.createStatement();
	ResultSet rscloseconv=stmtcloseconv.executeQuery(strcloseconv);
	int convconfig=0;
	while(rscloseconv.next()){
		convconfig=rscloseconv.getInt("conv");
	}
	stmtcloseconv.close();
	String strmonthly="select (case when 1=(select method from gl_config where field_nme='lesmonthlycal') then 'monthlycal' else round((select value from"+
			" gl_config where field_nme='lesmonthlycal'),0) end )dayscalc,method from gl_config where field_nme='lesmonthlycal'";
	ResultSet rsmonthly=stmtTarif.executeQuery(strmonthly);
	String monthlycalc="";
	String value="";
	int value1=0;
	if(rsmonthly.next()){
		monthlycalc=rsmonthly.getString("method");
		value=rsmonthly.getString("dayscalc");
		if(!(value.equalsIgnoreCase("monthlycal"))){
			value1=Integer.parseInt(value);	
		}
		
	}
	rsmonthly.close();
//	System.out.println("Rental type========"+rentaltype);
//	System.out.println("Selected Tarif========"+selectedtarif);
	if(monthlycalc.equalsIgnoreCase("0")){
		rentalno=value1;
	}
	
	String strsql="";
	Statement stmtdefault=conn.createStatement();
	double drate=0.0,dcdw=0.0,dpai=0.0,dcdw1=0.0,dpai1=0.0,dgps=0.0,dbabyseater=0.0,dcooler=0.0,dkmrest=0.0,dexhrchg=0.0,dexkmrte=0.0,dchaufchg=0.0;
	String strdefault="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,chaufchg,chaufexchg"+
			" from gl_ltarif where rdocno="+agmtno+"";
	ResultSet rsdefault=stmtdefault.executeQuery(strdefault);
	while(rsdefault.next()){
		drate=rsdefault.getDouble("rate");
		dcdw=rsdefault.getDouble("cdw");
		dpai=rsdefault.getDouble("pai");
		dcdw1=rsdefault.getDouble("cdw1");
		dpai1=rsdefault.getDouble("pai1");
		dgps=rsdefault.getDouble("gps");
		dbabyseater=rsdefault.getDouble("babyseater");
		dcooler=rsdefault.getDouble("cooler");
		//dexhrchg=rsdefault.getDouble("exhrchg");
		dexkmrte=rsdefault.getDouble("exkmrte");
		dchaufchg=rsdefault.getDouble("chaufchg");
	}
	rsdefault.close();
	stmtdefault.close();
	String calctype="";
	String strconfig="select (case when "+hours+"<=(select value from gl_config where field_nme='gp') then 'nothing' when "+hours+" <(select value from gl_config"+
			" where field_nme='gph') then 'hourly' when "+hours+"<(select value from gl_config where field_nme='gpd') then 'halfday'"+
			" else 'fullday' end )calc,value from gl_config where field_nme='gp'";
//	System.out.println("Grace Period Query:"+strconfig);
ResultSet rsconfig=stmtTarif.executeQuery(strconfig);

double freehours=0.0;
while(rsconfig.next()){
	calctype=rsconfig.getString("calc");
	freehours=rsconfig.getDouble("value");
}



//Rough Checking for hour charge





						Statement stmtrough=conn.createStatement();
						String strrough="select (select method from gl_config where field_nme='gp')gpmethod,(select value from gl_config where field_nme='gp')gpvalue,"+
								"(select method from gl_config where field_nme='gph')gphmethod,(select value from gl_config where field_nme='gph')gphvalue,"+
								"(select method from gl_config where field_nme='gpd')gpdmethod,(select value from gl_config where field_nme='gpd')gpdvalue";
						ResultSet rsrough=stmtrough.executeQuery(strrough);
						int gpmethod=0,gphmethod=0,gpdmethod=0;
						double gpvalue=0.0,gphvalue=0.0,gpdvalue=0.0;
						while(rsrough.next()){
							gpmethod=rsrough.getInt("gpmethod");
							gpvalue=rsrough.getDouble("gpvalue");
							gphmethod=rsrough.getInt("gphmethod");
							gphvalue=rsrough.getDouble("gphvalue");
							gpdmethod=rsrough.getInt("gpdmethod");
							gpdvalue=rsrough.getDouble("gpdvalue");
						}
						calctype="";
						if(gpdmethod==1 && gpdvalue<=hours){
							calctype="fullday";
						}
						if((gphmethod==1 && gphvalue<=hours) && ((gpdmethod==1 &&  gpdvalue>hours) || (gpdmethod==0)) ){
							calctype="halfday";
						}
						if((gpmethod==1 && gpvalue<=hours) && ((gphmethod==1 && gphvalue>hours) || (gphmethod==0))  && ((gpdmethod==1 &&  gpdvalue>hours) || (gpdmethod==0))){
							calctype="hourly";
						}
						
						
//Rough Checking for hour charge ends here


//System.out.println("Calctype:"+calctype);
rsconfig.close();

double cal=0.0;
double finalhours=0.0;
double hrchg=0.0;

String temptime[]=usedhours.replace(".",":").split(":");
int temphours=Integer.parseInt(temptime[0]);
int tempminutes=Integer.parseInt(temptime[1]);
if(calctype.equalsIgnoreCase("hourly")){
	//System.out.println("FreeHours: "+freehours);
	//System.out.println("Hours: "+temphours);
	if(tempminutes>0){
		temphours=temphours+1;
	}
	finalhours=temphours-freehours;
	cal=0;
}
if(calctype.equalsIgnoreCase("halfday")){
	//System.out.println("Calctype"+calctype);
	cal=0.5;
}
if(calctype.equalsIgnoreCase("fullday")){
	cal=1;
}
days=days+cal;



int extracdw=0,extracdw1=0,extrapai=0,extrapai1=0;
double cdwdays=0.0,paidays=0.0,cdw1days=0.0,pai1days=0.0;
String strenabled="select (select method from gl_config where field_nme='extracdw') extracdw,(select method from gl_config where"+
		" field_nme='extrapai') extrapai,(select method from gl_config where field_nme='extracdw1') extracdw1,(select method"+
		" from gl_config where field_nme='extrapai1') extrapai1";
ResultSet rsenabled=stmtTarif.executeQuery(strenabled);
while(rsenabled.next()){
	extracdw=rsenabled.getInt("extracdw");
	extrapai=rsenabled.getInt("extrapai");
	extracdw1=rsenabled.getInt("extracdw1");
	extrapai1=rsenabled.getInt("extrapai1");
}


double rate=0.0,cdw=0.0,pai=0.0,cdw1=0.0,pai1=0.0,gps=0.0,babyseater=0.0,cooler=0.0,kmrest=0.0,exkmrte=0.0,oinschg=0.0,exhrchg=0.0,chaufchg=0.0,chaufexchg=0.0;

double day=0.0,month=0.0,year=0.0;
int lastday=0;
String strgetmonth="";
String strmonthcal="";
double excessday=0.0,excessmonth=0.0;
int excesslastday=0;
if(convconfig==0){
	
	
	if(((monthlycalc.equalsIgnoreCase("0")&&(rentaltype.equalsIgnoreCase("monthly"))))){
	
		cdwdays=days;
		paidays=days;
		cdw1days=days;
		pai1days=days;
			if(extracdw==1){
				cdwdays=cdwdays+cal;
				}
			if(extrapai==1){
				paidays=paidays+cal;
				}
			if(extracdw1==1){
				cdw1days=cdw1days+cal;
				}
			if(extrapai1==1){
				pai1days=pai1days+cal;
				}
			
		days=days+cal;
	
			
		strsql="select "+(days/rentalno)+"*rate tarif,"+(cdwdays/rentalno)+"*cdw cdw,"+(paidays/rentalno)+"*pai pai,"+(cdw1days/rentalno)+"*cdw1 scdw,"+
				+(pai1days/rentalno)+"*pai1 spai,"+(days/rentalno)+"*gps gps,"+(days/rentalno)+"*babyseater babyseater,"+(days/rentalno)+"*cooler cooler,"+
				+(days/rentalno)+"*chaufchg chaufferchg,("+totalkm+"-("+(days/rentalno)+"*kmrest))*exkmrte exkmrte,("+totalkm+"-("+(days/rentalno)+"*kmrest)) excesskm from gl_ltarif where rdocno="+agmtno;
//		System.out.println("Normal Query"+strsql);
		ResultSet rsnormal=stmtTarif.executeQuery(strsql);
		while(rsnormal.next()){
			rate=rsnormal.getDouble("tarif");
    		cdw=rsnormal.getDouble("cdw");
    		pai=rsnormal.getDouble("pai");
    		cdw1=rsnormal.getDouble("scdw");
    		pai1=rsnormal.getDouble("spai");
    		gps=rsnormal.getDouble("gps");
    		babyseater=rsnormal.getDouble("babyseater");
    		cooler=rsnormal.getDouble("cooler");
    		//kmrest=rsnormal.getDouble("kmrest");
    		exkmrte=rsnormal.getDouble("exkmrte");
    		excesskm=rsnormal.getDouble("excesskm")+"";
    		//exhrchg=rsnormal.getDouble("exhrchg");
    		chaufchg=rsnormal.getDouble("chaufferchg");
    		
		}
		rsnormal.close();
	}
	
	
	if(monthlycalc.equalsIgnoreCase("1")&&(rentaltype.equalsIgnoreCase("Monthly"))){
		
		 strgetmonth="select a.months,DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+agmtdate1+"',INTERVAL a.months month) ) days from ("+
				" select if(day('"+agmtdate1+"')>day('"+closedate1+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )) months) a";
		/*String strgetmonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday, DATEDIFF( '"+closedate+"',if(a.months>0,LAST_DAY(DATE_ADD( '"+agmtdate1+"',INTERVAL a.months month)),"+
				" DATE_ADD('"+agmtdate1+"',INTERVAL a.months month))) days from (select if(day('"+agmtdate1+"')>day('"+closedate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )) months) a";*/
//		System.out.println("Month Difference"+strgetmonth);
		ResultSet rsgetmonth=stmtTarif.executeQuery(strgetmonth);
		while(rsgetmonth.next()){
			
			day=rsgetmonth.getDouble("days");
			month=rsgetmonth.getDouble("MONTHS");
			lastday=rsgetmonth.getInt("lastday");
		}
		

		cdwdays=day;
		paidays=day;
		cdw1days=day;
		pai1days=day;
			if(extracdw==1){
				cdwdays=cdwdays+cal;
				}
			if(extrapai==1){
				paidays=paidays+cal;
				}
			if(extracdw1==1){
				cdw1days=cdw1days+cal;
				}
			if(extrapai1==1){
				pai1days=pai1days+cal;
				}
		day=day+cal;
		
			
	rsgetmonth.close();
	if(Double.isNaN(day)){
		conn.close();
		return RESULTDATA;
	}
	if(Double.isNaN(month)){
		conn.close();
		return RESULTDATA;
	}
		//System.out.println("Extra Connfig Days:"+cdwdays+"::"+paidays+"::"+cdw1days+"::"+pai1days+"Cal:"+cal);
//		System.out.println("Day:"+day+"Month:"+month+"Last Day:"+lastday);
		if(day==0 && lastday==0){
			conn.close();
			return RESULTDATA;
		}
		strmonthcal="select (("+month+"*rate)+(("+day/lastday+")*rate)) tarif,(("+month+"*cdw)+(("+cdwdays/lastday+")*cdw)) cdw,"+
				"(("+month+"*pai)+(("+paidays/lastday+")*pai)) pai,(("+month+"*cdw1)+(("+cdw1days/lastday+")*cdw1)) scdw,"+
				"(("+month+"*pai1)+(("+pai1days/lastday+")*pai1)) spai,(("+month+"*gps)+(("+day/lastday+")*gps)) gps,"+
				"(("+month+"*babyseater)+(("+day/lastday+")*babyseater)) babyseater,(("+month+"*cooler)+(("+day/lastday+")*cooler)) cooler,"+
				"(("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)) chaufferchg,("+totalkm+"-(("+month+"*kmrest)+(("+day/lastday+")*kmrest)))*exkmrte exkmrte,"+
				" ("+totalkm+"-(("+month+"*kmrest)+(("+day/lastday+")*kmrest))) excesskm from gl_ltarif where rdocno="+agmtno+" ";
//		System.out.println("Monthly Query"+strmonthcal);
		
		
		rentalno=lastday;
		
	}
	
	
	
}
else if (convconfig==1) {
	//System.out.println("MonthcalMethod: "+monthcalmethod);
	//System.out.println("ConvConfig: "+convconfig);
	
	if(monthcalmethod==0){
		rentalno=monthcalvalue;
		cdwdays=days;
		paidays=days;
		cdw1days=days;
		pai1days=days;
			if(extracdw==1){
				cdwdays=cdwdays+cal;
				}
			if(extrapai==1){
				paidays=paidays+cal;
				}
			if(extracdw1==1){
				cdw1days=cdw1days+cal;
				}
			if(extrapai1==1){
				pai1days=pai1days+cal;
				}
		days=days+cal;
		strmonthcal="select "+(days/rentalno)+"*rate tarif,"+(cdwdays/rentalno)+"*cdw cdw,"+(paidays/rentalno)+"*pai pai,"+(cdw1days/rentalno)+"*cdw1 scdw,"+
				+(pai1days/rentalno)+"*pai1 spai,"+(days/rentalno)+"*gps gps,"+(days/rentalno)+"*babyseater babyseater,"+(days/rentalno)+"*cooler cooler,"+
				+(days/rentalno)+"*chaufchg chaufferchg,("+totalkm+"-("+(days/rentalno)+"*kmrest))*exkmrte exkmrte,("+totalkm+"-("+(days/rentalno)+"*kmrest)) excesskm from gl_ltarif where rdocno="+agmtno;
		
	}
	else if(monthcalmethod==1){
		if(closeinvdate!=null){
			strgetmonth="select DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+closeinvdate+"',INTERVAL 0 month) ) days,0 months";	
			//System.out.println("Month Query: "+strgetmonth);
			ResultSet rsgetmonth=stmtTarif.executeQuery(strgetmonth);
			while(rsgetmonth.next()){
				day=rsgetmonth.getDouble("days");
				month=rsgetmonth.getDouble("MONTHS");
				lastday=rsgetmonth.getInt("lastday");
			}
		}
		//System.out.println("Calculated Days: "+day);
		String strgetexcesskmdur="select DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+agmtdate1+"',INTERVAL 0 month) ) days,0 months";
		
		
		Statement stmtexcesskmdur=conn.createStatement();
		ResultSet rsgetexcesskmdur=stmtexcesskmdur.executeQuery(strgetexcesskmdur);
		while(rsgetexcesskmdur.next()){
			excessday=rsgetexcesskmdur.getDouble("days");
			excessmonth=rsgetexcesskmdur.getDouble("MONTHS");
			excesslastday=rsgetexcesskmdur.getInt("lastday");
		}
		stmtexcesskmdur.close();
		
		cdwdays=day;
		paidays=day;
		cdw1days=day;
		pai1days=day;
			if(extracdw==1){
				cdwdays=cdwdays+cal;
				}
			if(extrapai==1){
				paidays=paidays+cal;
				}
			if(extracdw1==1){
				cdw1days=cdw1days+cal;
				}
			if(extrapai1==1){
				pai1days=pai1days+cal;
				}
		day=day+cal;
		excessday=excessday+cal;
		//System.out.println("Days: "+day+"           Cal: "+cal);
		
		strmonthcal="select (("+month+"*rate)+(("+day/lastday+")*rate)) tarif,(("+month+"*cdw)+(("+cdwdays/lastday+")*cdw)) cdw,"+
				"(("+month+"*pai)+(("+paidays/lastday+")*pai)) pai,(("+month+"*cdw1)+(("+cdw1days/lastday+")*cdw1)) scdw,"+
				"(("+month+"*pai1)+(("+pai1days/lastday+")*pai1)) spai,(("+month+"*gps)+(("+day/lastday+")*gps)) gps,"+
				"(("+month+"*babyseater)+(("+day/lastday+")*babyseater)) babyseater,(("+month+"*cooler)+(("+day/lastday+")*cooler)) cooler,"+
				"(("+month+"*chaufchg)+(("+day/lastday+")*chaufchg)) chaufferchg,("+totalkm+"-(("+month+"*kmrest)+(("+day/lastday+")*kmrest)))*exkmrte exkmrte,"+
				" ("+totalkm+"-(("+month+"*kmrest)+(("+day/lastday+")*kmrest))) excesskm from gl_ltarif where rdocno="+agmtno+" ";
		
		

		Statement stmtexcesskm=conn.createStatement();
		//System.out.println("Excess Month: "+excessmonth+"//////////ExcessDay: "+excessday+"/////////////ExcessLastDay: "+excesslastday);
		String strexcesskm="select ("+totalkm+"-(("+excessmonth+"*kmrest)+(("+excessday/excesslastday+")*kmrest)))*exkmrte exkmrte,"+
				" ("+totalkm+"-(("+excessmonth+"*kmrest)+(("+excessday/excesslastday+")*kmrest))) excesskm from gl_ltarif where rdocno="+agmtno;
		//System.out.println("Excess Km Query: "+strexcesskm);
		ResultSet rsexcesskm=stmtexcesskm.executeQuery(strexcesskm);
		while(rsexcesskm.next()){
			exkmrte=rsexcesskm.getDouble("exkmrte");
    		excesskm=rsexcesskm.getDouble("excesskm")+"";
		}
		stmtexcesskm.close();

		
		
		
	}
	
	
	
}


ResultSet rsmonthcal=stmtTarif.executeQuery(strmonthcal);
while(rsmonthcal.next()){
	rate=rsmonthcal.getDouble("tarif");
	cdw=rsmonthcal.getDouble("cdw");
	pai=rsmonthcal.getDouble("pai");
	cdw1=rsmonthcal.getDouble("scdw");
	pai1=rsmonthcal.getDouble("spai");
	gps=rsmonthcal.getDouble("gps");
	babyseater=rsmonthcal.getDouble("babyseater");
	cooler=rsmonthcal.getDouble("cooler");
	//kmrest=rsmonthcal.getDouble("kmrest");
	if(monthcalmethod!=1){
		exkmrte=rsmonthcal.getDouble("exkmrte");
		excesskm=rsmonthcal.getDouble("excesskm")+"";	
	}
	//oinschg=rsmonthcal.getDouble("oinschg");
	//exhrchg=rsmonthcal.getDouble("exhrchg");
	chaufchg=rsmonthcal.getDouble("chaufferchg");
	
}
rsmonthcal.close();
rentalno=lastday;



double termamt=0.0;
int termmonth=0;

	/*			ResultSet rsgettermmonth=stmtTarif.executeQuery("select timestampdiff(Month,agmtstartdate,DATE_SUB('"+closedate1+"',INTERVAL 1 DAY)) monthdiff from (select case when delivery=1 then "+
					" deldate else outdate end agmtstartdate from gl_lagmt where doc_no="+agmtno+")a");
				System.out.println("select timestampdiff(Month,agmtstartdate,DATE_SUB('"+closedate1+"',INTERVAL 1 DAY)) monthdiff from (select case when delivery=1 then "+
					" deldate else outdate end agmtstartdate from gl_lagmt where doc_no="+agmtno+")a");
			while(rsgettermmonth.next()){
				month=rsgettermmonth.getInt("monthdiff");
			}
			if(month==0){
			month+=1;
			}
			String strtermmaxmonth="select max(mnthto) maxmonth from gl_ltermcl where rdocno="+agmtno;
			int termmaxmonth=0;
			ResultSet rsmaxmonth=stmtTarif.executeQuery(strtermmaxmonth);
			while(rsmaxmonth.next()){
				termmaxmonth=rsmaxmonth.getInt("maxmonth");
			}
			String termcalc="select if("+month+"="+termmaxmonth+",0,amt) amt from gl_ltermcl where rdocno="+agmtno+" and "+month+" between mnthfrm and mnthto";
			System.out.println("Premature Month: "+month);
			System.out.println("Premature Query: "+termcalc);
			ResultSet rstermcalc=stmtTarif.executeQuery(termcalc);
			while(rstermcalc.next()){
				termamt=rstermcalc.getDouble("amt");
				termmonth=(int)month;
			}
			
			rstermcalc.close();
	*/
		java.sql.Date termagmtdate=null;
		String strtermdate="select if(delivery=1,deldate,outdate) agmtdate from gl_lagmt where doc_no="+agmtno;
		ResultSet rstermdate=stmtTarif.executeQuery(strtermdate);
		while(rstermdate.next()){
			termagmtdate=rstermdate.getDate("agmtdate");
		}
		/*
		 * removed by nitin on request from stefan
		 * 23-07-2017
		 * 
		 * String strterm="select timestampdiff(month,'"+termagmtdate+"','"+closedate1+"') termmonth,date_sub(date_add('"+termagmtdate+"',interval mnthto month), interval 1 day)>'"+closedate1+"' status,amt  from gl_ltermcl where rdocno="+agmtno;	
		System.out.println(strterm);
		ResultSet rsterm=stmtTarif.executeQuery(strterm);
		while(rsterm.next()){
			if(rsterm.getInt("status")==1){
				termamt=rsterm.getDouble("amt");
				termmonth=rsterm.getInt("termmonth");
				break;
			}
		}*/
	
	//System.out.println("Hoours For Grace Period Calculation"+hours);

//System.out.println("Connection conn:"+conn);
//System.out.println("Connection Status:"+conn.isClosed());
Statement stmtTarif2=conn.createStatement();
if(rentaltype.equalsIgnoreCase("")){
	rentaltype="0";
}
if(agmtno.equalsIgnoreCase("")){
	agmtno="0";
}
if(excesskm.equalsIgnoreCase("")){
	excesskm="0";
}
if(exkmrte<0){
	exkmrte=0.0;
}
if(Double.parseDouble(excesskm)<0){
	excesskm="0";
}
//System.out.println("KMREST FINAL:"+((month*kmrest)+((day/lastday)*kmrest)));
			String strgrace="select 'Total' rentaltype,if("+drate+">0,round("+rate+",0),0) rate,if("+dcdw+">0,round("+cdw+",0),0) cdw,if("+dpai+">0,round("+pai+",0),0) pai,"+
					" if("+dcdw1+">0,round("+cdw1+",0),0) cdw1,if("+dpai1+">0,round("+pai1+",0),0) pai1,if("+dgps+">0,round("+gps+",0),0) gps,if("+dbabyseater+">0,round("+babyseater+",0),0) babyseater,"+
					"if("+dcooler+">0,round("+cooler+",0),0) cooler,if("+dchaufchg+">0,round("+chaufchg+",0),0) chaufchg,round(if("+dexkmrte+">0,"+exkmrte+",0),2) exkmrte,round("+excesskm+",2) excesskm,"+termamt+" termamt,"+termmonth+" termmonth,'"+calctype+"' calctype,"+finalhours+" finalhours  from gl_ltarif where rdocno="+agmtno+""+
					" union select 'Discount' rentaltype,0.00 rate,0.00 cdw,0.00 pai,"+
					" 0.00 cdw1,0.00 pai1,0.00 gps,0.00 babyseater,"+
					"0.00 cooler,0.00 chaufchg,0.00 exkmrte,0 excesskm,"+termamt+" termamt,"+termmonth+" termmonth,'"+calctype+"' calctype,"+finalhours+" finalhours  from gl_ltarif where rdocno="+agmtno+""+
					"  union select 'Net Total' rentaltype,if("+drate+">0,round("+rate+",0),0) rate,if("+dcdw+">0,round("+cdw+",0),0) cdw,if("+dpai+">0,round("+pai+",0),0) pai,"+
					" if("+dcdw1+">0,round("+cdw1+",0),0) cdw1,if("+dpai1+">0,round("+pai1+",0),0) pai1,if("+dgps+">0,round("+gps+",0),0) gps,if("+dbabyseater+">0,round("+babyseater+",0),0) babyseater,"+
					"if("+dcooler+">0,round("+cooler+",0),0) cooler,if("+dchaufchg+">0,round("+chaufchg+",0),0) chaufchg,round(if("+dexkmrte+">0,"+exkmrte+",0),2) exkmrte,round("+excesskm+",2) excesskm,"+termamt+" termamt,"+termmonth+" termmonth,'"+calctype+"' calctype,"+finalhours+" finalhours  from gl_ltarif where rdocno="+agmtno;
//			System.out.println("Final Query"+strgrace);
			
			ResultSet resultSet = stmtTarif2.executeQuery(strgrace);
			if(resultSet!=null){
				RESULTDATA=objcommon.convertToJSON(resultSet);
//				System.out.println("TOTAL RESULTDATA=========>"+RESULTDATA);
			}
			resultSet.close();
			conn.close();
			stmtTarif.close();
			stmtTarif2.close();
			return RESULTDATA;
			
	    
	    
	    }
	catch(Exception E1){
		E1.printStackTrace();
		conn.close();
		return RESULTDATA;
	}
		finally{
			conn.close();
		}
	
	}
/*	public  double funGetMonthCal(int monthcalmethod, int useddays, double monthcalvalue, double monthlyrate, Date sqlagmtdate, Date sqlclosedate){
		double finalamt=0.0;
		if(monthcalmethod==0){
			finalamt=(useddays/monthcalvalue)*monthlyrate;
		}
		return 0;
	}*/
	public  JSONArray getCalcData(String agmtno,String tarif,String cdwtotal,String acctotal,String chauffer,String excesskmchg,String excesshrchg,String temp
			,HttpSession session,String usedhours,String clientid,String fuel,String termamt,String deliverychg,String collectchg,String outdate,String indate,
			String cmbinfuel,String exkm,String termmonth,java.sql.Date closeinvdate,String calctype) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	    try {
	    	conn = objconn.getMyConnection();
	    	if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase(null)){
	    		agmtno="0";
	    	}
	    
	    
		conn.setAutoCommit(false);
		Statement stmtTarif = conn.createStatement();
		Statement stmtcalctest=conn.createStatement();
		
			double salamount=0.0;
			double salikratetemp=0.0;
			double saliksrvctemp=0.0;
			double salikamttemp=0.0;
			double trafficamounttemp=0.0;
			double trafficcounttemp=0.0;
			double trafficsrvctemp=0.0;
			java.sql.Date fromdate=null,todate=null;
			if(!(outdate.equalsIgnoreCase("")||outdate.equalsIgnoreCase("0"))){
				fromdate=objcommon.changeStringtoSqlDate(outdate);
			}
			Statement stmtclosecal=conn.createStatement();
			String strcloseconfig="select method from gl_config where field_nme='closecal'";
			int closecalmethod=0;
			ResultSet rsclosecal=stmtclosecal.executeQuery(strcloseconfig);
			while(rsclosecal.next()){
				closecalmethod=rsclosecal.getInt("method");
			}
			stmtclosecal.close();
			
			//Determining From Date to Calculate corresponding upload value in gl_ragmt
			/*Statement stmtupload=conn.createStatement();
			
			String strupload="select if(upload='up' and uploaddate is not null,uploaddate,odate) fromdate from gl_ragmt where doc_no="+agmtno;
			ResultSet rsupload=stmtupload.executeQuery(strupload);
			if(rsupload.next()){
				fromdate=rsupload.getDate("fromdate");
			}
			stmtupload.close();
			*/
			if(!(indate.equalsIgnoreCase("")||indate.equalsIgnoreCase("0"))){
				todate=objcommon.changeStringtoSqlDate(indate);
			}
			//System.out.println("Agmt"+agmtno+"Taarif"+tarif+"Cdw"+cdwtotal+"Acc"+acctotal+"Chauffer"+chauffer+"Excesskm"+excesskmchg+"ExcessHr"+excesshrchg);
				
				if(collectchg.equalsIgnoreCase("")){
					collectchg="0";
				}
				if(deliverychg.equalsIgnoreCase("")){
					deliverychg="0";
				}
				if(usedhours.equalsIgnoreCase("")){
					usedhours="0";
				}
				double colchg=Double.parseDouble(collectchg);
				double delchg=Double.parseDouble(deliverychg);
				
				if(closecalmethod==1){
					delchg=0;
					Statement stmt=conn.createStatement();
					ResultSet rsdel=stmt.executeQuery("select coalesce(delchg,0) delchg from gl_lagmt where doc_no="+agmtno+" and del_invno=0");
					while(rsdel.next()){
						delchg=rsdel.getDouble("delchg");
					}
					stmt.close();
				}
				
				
				
				
				Statement stmtconfig=conn.createStatement();
				String strconfig="select (case when "+usedhours+"<=(select value from gl_config where field_nme='gp') then 'nothing' when "+usedhours+" <(select value from gl_config"+
						" where field_nme='gph') then 'hourly' when "+usedhours+"<(select value from gl_config where field_nme='gpd') then 'halfday'"+
						" else 'fullday' end )calc,value from gl_config where field_nme='gp'";
				
//				System.out.println("Check Grace:"+strconfig);
				ResultSet rsconfig=stmtconfig.executeQuery(strconfig);
				String calc="";
				while(rsconfig.next()){
					calc=rsconfig.getString("calc");
				}
				String daysused="";
				calc=calctype;
				long diff=0;
				long datediff=0;
				if(todate!=null && fromdate!=null){
					if(closecalmethod==1){
						fromdate=closeinvdate;
					}
					 diff=todate.getTime()-fromdate.getTime();
					 datediff = diff / (24 * 60 * 60 * 1000);
//					System.out.println(datediff);
					
					daysused=datediff+" D";
					if(calc.equalsIgnoreCase("fullday")){
						daysused=daysused+" 1 D Extra";
					}
					
					else if(calc.equalsIgnoreCase("halfday")){
						daysused=daysused+" 0.5 D Extra";
					}
			}
				if(calc.equalsIgnoreCase("fullday")){
//					System.out.println("Check Date_add:select DATE_ADD('"+todate+"',INTERVAL 1 DAY) fdate");
					ResultSet rsconfig2=stmtconfig.executeQuery("select DATE_ADD('"+todate+"',INTERVAL 1 DAY) fdate");
					while(rsconfig2.next()){
						todate=rsconfig2.getDate("fdate");
					}
				}
				
				
				/*daysused=objcommon.getMonthandDays(todate,fromdate,conn);*/
					
				if(temp.equalsIgnoreCase("1")){
				
				//System.out.println("SLQMODE"+sqlmode);
			
				String strSql="";
				strSql="select idno from gl_invmode order by idno";
				ResultSet result=stmtTarif.executeQuery(strSql);
				//System.out.println(strSql);
				String desc[] = new String[30];
				
				int i=0;
				while(result.next()){
					desc[i]=result.getString("idno");
					//System.out.println("IDNO Check:"+desc[i]);
					i++;
				}
				double prate=0.0,drate=0.0;
				
				Statement stmtfuelrate=conn.createStatement();
				String strsqlrate="select (select method from gl_config where field_nme='fuelrate') method,(select method from gl_config where field_nme='delcal') delcal";
				ResultSet rsfuelrate=stmtfuelrate.executeQuery(strsqlrate);
				int fuelmethod=0;
				int delcal=0;
				while(rsfuelrate.next()){
					fuelmethod=rsfuelrate.getInt("method");
					delcal=rsfuelrate.getInt("delcal");
				}
					stmtfuelrate.close();
					
					String sqlfuel="";
					if(fuelmethod==1){
						sqlfuel="select if((select method from gl_config where field_nme='prate')=1,(select value from gl_config where field_nme='prate'),0.00) prate,"+
								" if((select method from gl_config where field_nme='drate')=1,(select value from gl_config where field_nme='drate'),0.00)drate";	
					}
					else if(fuelmethod==0){
						sqlfuel="select ptlchg prate,deslchg drate from gl_fuelcharge where status<>7 and doc_no=(select max(doc_no)"+
								" from gl_fuelcharge where '"+todate+"' between frmdate and todate)";
					}
					
					//System.out.println("Fuel Sql:"+sqlfuel);
					ResultSet rsfuel=stmtTarif.executeQuery(sqlfuel);
					while(rsfuel.next()){
						prate=rsfuel.getDouble("prate");
						drate=rsfuel.getDouble("drate");
					}
					String strtestdelcal="";
					if(delcal==0){
						strtestdelcal=" and trancode!='DL'";
					}	
					
				/*if(!(fuel.equalsIgnoreCase("0"))){
				String sqlfuel="select if((select method from gl_config where field_nme='prate')=1,(select value from gl_config where field_nme='prate'),0) prate,"+
						" if((select method from gl_config where field_nme='drate')=1,(select value from gl_config where field_nme='drate'),0)drate";
				ResultSet rsfuel=stmtTarif.executeQuery(sqlfuel);
				while(rsfuel.next()){
					prate=rsfuel.getDouble("prate");
					drate=rsfuel.getDouble("drate");
				}
				} 

				String strfuelchg="select coalesce(mov.tfuel,0) tfuel,mov.fleet_no,(select tcap from gl_vehmaster where fleet_no=mov.fleet_no) capacity,"+
						"(select fueltype from gl_vehmaster where fleet_no=mov.fleet_no) fueltype from gl_vmove mov"+
						" where mov.rdocno="+agmtno+" and mov.rdtype='RAG' and tfuel<>0";
				ResultSet rsfuelchg=stmtTarif.executeQuery(strfuelchg);
				double fuelsum=0.0;
				while(rsfuelchg.next()){
					double rate=0.0;
					if(rsfuelchg.getString("fueltype").equalsIgnoreCase("P")){
						rate=prate;
					}
					else{
						rate=drate;
					}
					fuelsum+=(rsfuelchg.getDouble("tfuel")*rsfuelchg.getDouble("capacity")*rate);
				}
				System.out.println("Final Fuel Sum:"+fuelsum);*/
				//System.out.println("Fuel in Dao:"+fuel);
				
				//System.out.println("Prate:"+prate+"Drate:"+drate);
				String strfuelchg="select mov.fleet_no,coalesce(sum(fin-fout),0.0) tfuel,(select tcap from gl_vehmaster where fleet_no=mov.fleet_no) capacity,"+
						"(select fueltype from gl_vehmaster where fleet_no=mov.fleet_no) fueltype "+
						" from gl_vmove mov where mov.rdocno="+agmtno+" and mov.rdtype='LAG' and status='IN' "+strtestdelcal+" group by mov.fleet_no";				//System.out.println("Fuel Query:"+strfuelchg);
				ResultSet rsfuelchg=stmtTarif.executeQuery(strfuelchg);
				double fuelsum=0.0;
				double frate=0.0;
				double fuelqty=0.0;
				double temptfuel=0.0;
				while(rsfuelchg.next()){
				
					if(rsfuelchg.getString("fueltype").equalsIgnoreCase("P")){
						frate=prate;
					}
					else{
						frate=drate;
					}
					fuelsum+=((rsfuelchg.getDouble("tfuel")*frate)*rsfuelchg.getDouble("capacity"));
					temptfuel+=rsfuelchg.getDouble("tfuel");
//					System.out.println("Final Fuel Sum:"+fuelsum+"Total Fuel:"+rsfuelchg.getDouble("tfuel")+"Capacity:"+rsfuelchg.getDouble("capacity")+"Rate:"+frate);
				}
//				System.out.println("fuelsum:"+fuelsum);
				String strfuel2="select "+cmbinfuel+" fin,fout,veh.tcap,if(veh.fueltype='P',"+prate+","+drate+") ratevalue "+
						" from gl_vmove mov left join gl_vehmaster veh on"+
						" mov.fleet_no=veh.fleet_no where rdocno="+agmtno+" and rdtype='LAG' and mov.status='OUT'";
				ResultSet rsfuel2=stmtTarif.executeQuery(strfuel2);
				double remainfuel=0.0;
				while(rsfuel2.next()){
					remainfuel=rsfuel2.getDouble("fin")-rsfuel2.getDouble("fout");
					fuelsum=fuelsum+(remainfuel*rsfuel2.getDouble("tcap")*rsfuel2.getDouble("ratevalue"));
//				System.out.println("Remainfuel:"+remainfuel+"Capacity:"+rsfuel2.getDouble("tcap")+"Value:"+rsfuel2.getDouble("ratevalue")+"fuelsum:"+fuelsum);
				}
				fuelsum=fuelsum*-1;
				fuelqty=temptfuel+remainfuel;
				int salikcount=0;
				int trafficcount=0;
				
				
				String strsqltest="";
				
				if(closecalmethod==1){
					strsqltest="  and inv_no=0";
				}
				
				
				String strsalik="select COALESCE(sum(amount),0.0) amount,count(*) count,amount salamount from gl_salik where amount>0 and isallocated=1 and ra_no="+agmtno+" and"+
						" rtype in('LC','LA') and sal_date <='"+todate+"'"+strsqltest;
				//System.out.println(strsalik);
				
				ResultSet rssalik=stmtTarif.executeQuery(strsalik);
				double salikamt=0.0;
				while(rssalik.next()){
					salikamt=rssalik.getDouble("amount");
					salikcount=rssalik.getInt("count");
					salamount=rssalik.getDouble("salamount");
				}
				String srvcsalik="select method from gl_config where field_nme='srvcchgsalik'";
				//System.out.println(srvcsalik);
				ResultSet rssrvcsalik=stmtTarif.executeQuery(srvcsalik);
				int srvcsalikmethod=0;
				if(rssrvcsalik.next()){
					srvcsalikmethod=rssrvcsalik.getInt("method");
				}
				
				
				
				
				
				String strtraffic="select   COALESCE(sum(amount),0.0) trafficamt,count(*) count  from gl_traffic where amount>0 and isallocated=1 and emp_type='CRM' and ra_no='"+agmtno+"' and"+
						" rtype in('LC','LA') and traffic_date <='"+todate+"'"+strsqltest;
				//System.out.println(strtraffic);
				ResultSet rstraffic=stmtTarif.executeQuery(strtraffic);
				double trafficamt=0.0;
				while(rstraffic.next()){
					trafficamt=rstraffic.getDouble("trafficamt");
					trafficcount=rstraffic.getInt("count");
				}
				
								//Fetching Dubai Gov Traffic Acknowledge Fees
				ClsCommon objcommon=new ClsCommon();

				double trafficfees=objcommon.getTrafficFees(Integer.parseInt(agmtno),fromdate,todate,"LAG","1");
				
				if(trafficfees>0){
					trafficamt=(trafficamt+trafficfees);
				
				}
				
				
				
				
				
				int srvcdefault=0;
				double salikrate=0.0,trafficrate=0.0;
				String stracbook="select ser_default,per_salikrate,per_trafficharge from my_acbook where cldocno='"+clientid+"' and dtype='CRM' and status<>7";
				ResultSet rsacbook=stmtTarif.executeQuery(stracbook);
				while(rsacbook.next()){
					srvcdefault=rsacbook.getInt("ser_default");
					if(srvcdefault==0){
						salikrate=rsacbook.getDouble("per_salikrate");
						trafficrate=rsacbook.getDouble("per_trafficharge");
					}
				}
				int trafficmethod=0;
				double trafficapply=0.0;
				double trafficsrvc=0.0;
				double trafficsrvcper=0.0;
				double trafficpercalc=0.0;
				double finaltrafficsrvc=0.0;
				if(srvcdefault==1){
					String saliksrv="select if((select method from gl_config where field_nme='saliksrv')=1,(select value from gl_config where field_nme='saliksrv'),0)"+
							" saliksrv  from gl_config where field_nme='saliksrv'";
					ResultSet rssaliksrv=stmtTarif.executeQuery(saliksrv);
					while(rssaliksrv.next()){
						salikrate=rssaliksrv.getDouble("saliksrv");
					}
					
					String strtrafficsrv="select method,value from gl_config where field_nme='trafficsrvapply'";
					ResultSet rstrafficsrvapply=stmtTarif.executeQuery(strtrafficsrv);
					while(rstrafficsrvapply.next()){
						trafficmethod=rstrafficsrvapply.getInt("method");
					trafficapply=rstrafficsrvapply.getDouble("value");
					}
					
					if(trafficmethod==1){
					String 	trafficsrvchgper="select value from gl_config where field_nme='trafficsrvper'";
					ResultSet rstrafficsrvchgper=stmtTarif.executeQuery(trafficsrvchgper);
					while(rstrafficsrvchgper.next()){
						trafficsrvcper=rstrafficsrvchgper.getDouble("value");
						trafficpercalc=trafficamt*(trafficsrvcper/100);
						finaltrafficsrvc=trafficpercalc;
					}
					}
					if(trafficmethod==0){
						String trafficsrvchg="select value from gl_config where field_nme='trafficsrv'";
						ResultSet rstrafficsrvchg=stmtTarif.executeQuery(trafficsrvchg);
						while(rstrafficsrvchg.next()){
							trafficsrvc=rstrafficsrvchg.getDouble("value");
							finaltrafficsrvc=trafficcount*trafficsrvc;
						}
					}
					
					if(trafficmethod==2){
						if(trafficpercalc<=trafficapply){
							finaltrafficsrvc=trafficapply;
						}
						else{
							finaltrafficsrvc=trafficpercalc;
						}
					}
				}
				else{
//					System.out.println("Check traffic srvc:::"+trafficrate+":::"+trafficcount);
					finaltrafficsrvc=trafficrate*trafficcount;		//Traffic Service Charge from my_acbook according to client
				}
				double saliksrvcchg=salikcount*salikrate;
				double deliverycollectchg=delchg+colchg;
				salikratetemp=salikrate;
				saliksrvctemp=saliksrvcchg;
				salikamttemp=salikamt;

				trafficamounttemp=trafficamt;
				trafficsrvctemp=finaltrafficsrvc;
				trafficcounttemp=trafficcount;
				ClsLeaseInvoiceDAO leaseinvdao=new ClsLeaseInvoiceDAO();
				ArrayList<String> firstinvarray=leaseinvdao.checkFirstInvoice(Integer.parseInt(agmtno),2);
				double firstinvamount=Double.parseDouble(firstinvarray.get(0));
				int firstinvcount=Integer.parseInt(firstinvarray.get(1));
				if(excesshrchg.equalsIgnoreCase("undefined")){
					excesshrchg="0";
				}
				if(termamt.equalsIgnoreCase("")){
					termamt="0";
				}
				
				Statement stmtadddriver=conn.createStatement();
				String stradddriver="";
				if(closecalmethod==1){
					stradddriver="select coalesce(addrchg,0) addrchg from gl_lagmt where doc_no="+agmtno+" and addr=1 and addr_invno=0";
				}
				else{
					stradddriver="select coalesce(addrchg,0) addrchg from gl_lagmt where doc_no="+agmtno+" and addr=1";
				}
				ResultSet rsadddriver=stmtadddriver.executeQuery(stradddriver);
				double add_driverchg=0.0;
				while(rsadddriver.next()){
					add_driverchg=rsadddriver.getDouble("addrchg");
				}
				stmtadddriver.close();	
				
//Code for Get damage amount  for invoicing if there any starts here
				
				Statement stmtdamage=conn.createStatement();
				String strdamage="select coalesce(insp.amount,0) amount from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno where "+
						" insp.reftype='LAG' and refdocno="+agmtno+" and invno=0 and insp.amount>0 and insp.status=3";
				double damageamount=0.0;
				ResultSet rsdamage=stmtdamage.executeQuery(strdamage);
				while(rsdamage.next()){
					damageamount=rsdamage.getDouble("amount");
					}
					stmtdamage.close();
					
				//Code for damage Amount Ends Here		
				
				//Calculate jv till duedate & inv from duedate to closedate
				int duedatediff=0,closedatediff=0,closedatemonthend=0;
				java.sql.Date sqlduedate=null;
				Statement stmt=conn.createStatement();
				String strduedate="select if(per_name=1,date_add(outdate,interval 12*per_value month),date_add(outdate,interval per_value month)) "+
				" duedate from gl_lagmt where doc_no="+agmtno;
				ResultSet rsduedate=stmt.executeQuery(strduedate);
				while(rsduedate.next()){
					sqlduedate=rsduedate.getDate("duedate");
				}
				java.sql.Date calcdate=null;
				if(todate.compareTo(sqlduedate)>0){
					calcdate=sqlduedate;
				}
				else{
					calcdate=todate;
				}
				String strdatediff="select datediff('"+calcdate+"',invdate) duedatediff,datediff('"+todate+"','"+calcdate+"') closedatediff,day(last_day('"+indate+"')) closedatemonthend from gl_lagmt where doc_no="+agmtno;
				System.out.println("Date Difference:"+strdatediff);
				ResultSet rsdatecheck=stmt.executeQuery(strdatediff);
				while(rsdatecheck.next()){
					duedatediff=rsdatecheck.getInt("duedatediff");
					closedatediff=rsdatecheck.getInt("closedatediff");
					closedatemonthend=rsdatecheck.getInt("closedatemonthend");
				}
				double jvtarif=0.0,jvcdw=0.0,jvacc=0.0,jvchauffer=0.0;
				double invtarif=0.0,invcdw=0.0,invacc=0.0,invchauffer=0.0;
				System.out.println("Tarif :"+tarif);
				System.out.println("Date Diff :"+datediff);
				System.out.println("Due Date Diff :"+duedatediff);
				jvtarif=((Double.parseDouble(tarif))/datediff)*duedatediff;
				jvcdw=(Double.parseDouble(cdwtotal)/datediff)*duedatediff;
				jvacc=(Double.parseDouble(acctotal)/datediff)*duedatediff;
				jvchauffer=(Double.parseDouble(chauffer)/datediff)*duedatediff;
				invtarif=(Double.parseDouble(tarif)-jvtarif);
				invcdw=(Double.parseDouble(cdwtotal)-jvcdw);
				invacc=(Double.parseDouble(acctotal)-jvacc);
				invchauffer=(Double.parseDouble(chauffer)-jvchauffer);
				
				ArrayList<String> rcalcarray= new ArrayList<String>();
				
				if((Double.parseDouble(tarif))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[0]+"::"+invtarif+"::"+daysused+"::0::0::"+null+"::"+jvtarif);
				}
				if((Double.parseDouble(cdwtotal))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[16]+"::"+invcdw+"::"+daysused+"::0::0::"+null+"::"+jvcdw);	
				}
				if((Double.parseDouble(acctotal))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[1]+"::"+invacc+"::"+daysused+"::0::0::"+null+"::"+jvacc);	
				}
				if((Double.parseDouble(chauffer))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[2]+"::"+invchauffer+"::"+daysused+"::0::0::"+null+"::"+jvchauffer);	
				}
					
					
					if((Double.parseDouble(excesskmchg))!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[3]+"::"+excesskmchg+"::"+exkm+"::0::0::"+null+"::"+0.0);	
					}
					if((Double.parseDouble(excesshrchg))!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[4]+"::"+excesshrchg+"::"+daysused+"::0::0::"+null+"::"+0.0);	
					}
					if(salikamt!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[7]+"::"+salikamt+"::"+salikcount+"::0::0::"+null+"::"+0.0);	
					}
					if(saliksrvcchg!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[13]+"::"+saliksrvcchg+"::"+salikcount+"::0::0::"+null+"::"+0.0);	
					}
					if(trafficamt!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[8]+"::"+trafficamt+"::"+trafficcount+"::0::0::"+null+"::"+0.0);	
					}
					if(finaltrafficsrvc!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[14]+"::"+finaltrafficsrvc+"::"+trafficcount+"::0::0::"+null+"::"+0.0);	
					}
					if(deliverycollectchg!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[5]+"::"+deliverycollectchg+"::1::0::0::"+null+"::"+0.0);	
					}
					if(fuelsum>0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[10]+"::"+objcommon.Round(fuelsum,2)+"::"+fuelqty+"::0::0::"+null+"::"+0.0);	
					}
					if(Double.parseDouble(termamt)!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[15]+"::"+termamt+"::1::0::0::"+null+"::"+0.0);	
					}
					if(firstinvamount!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[17]+"::"+firstinvamount+"::"+firstinvcount+"::0::0::"+null+"::"+0.0);
					}
					if(add_driverchg!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[11]+"::"+add_driverchg+"::1::0::0::"+null+"::"+0.0);
					}
					if(damageamount!=0){
						rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::LAG::"+desc[9]+"::"+damageamount+"::"+daysused+"::0::0::"+null+"::"+0.0);
					}
					
					
					Statement stmtrcalcdelete=conn.createStatement();
					String strrcalcdelete="delete from gl_lcalc where calcstatus=1 and rdocno="+agmtno+"";
					int deleteval=stmtrcalcdelete.executeUpdate(strrcalcdelete);

					for(int j=0;j< rcalcarray.size();j++){
						String[] rcalc=rcalcarray.get(j).split("::");
					
							int rval=lcalcinsert(rcalc[0],rcalc[1],rcalc[2],rcalc[3],rcalc[4],rcalc[5],rcalc[6],rcalc[7],rcalc[8],rcalc[9],stmtTarif);
							if(rval<=0){
								conn.close();
								return RESULTDATA;
							}
					
					}
					conn.commit();
					
					/*for(int j=0;j< rcalcarray.size();j++){
						String[] rcalc=rcalcarray.get(j).split("::");
						String test="select rdocno from gl_lcalc where calcstatus=1 and rdocno="+agmtno+" and idno="+rcalc[3];
						//System.out.println(test);
						ResultSet rstest=stmtTarif.executeQuery(test);
						if(rstest.next()){
							int rval=lcalcedit(rcalc[0],rcalc[1],rcalc[2],rcalc[3],rcalc[4],rcalc[5],rcalc[6],rcalc[7],rcalc[8],stmtTarif);
							if(rval<=0){
								conn.close(); 
								return RESULTDATA;
							}
						}
						else{
							int rval=lcalcinsert(rcalc[0],rcalc[1],rcalc[2],rcalc[3],rcalc[4],rcalc[5],rcalc[6],rcalc[7],rcalc[8],stmtTarif);
							if(rval<=0){
								conn.close(); 
								return RESULTDATA;
							}
						}
			
					}*/
				}
			
				/*String finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0, (r.total-r.invoiced),0)"+
						" invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote from gl_invmode m left join (select r.idno,r.qty,"+
						" coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0, (sum(amount)-sum(invoiced)),0) invoice,"+
						" if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_lcalc r where r.idno not in(8,9,14,15)"+
						" and rdocno="+agmtno+" and afterclose=0 group by idno union all select r.idno,r.qty,coalesce(sum(amount),0) total,sum(invoiced)"+
						" invoiced,if((sum(amount)-sum(invoiced))>0, (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,"+
						" (sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0  union all select"+
						" r.idno,r.qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0, (sum(amount)-sum(invoiced)),0)"+
						" invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_lcalc r where r.idno in(9,15)"+
						" and rdocno="+agmtno+" and afterclose=0 ) r on(m.idno=r.idno) where r.idno is not null";*/
				String finalsql="";
				if(closecalmethod==0){
					finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
							" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote,r.salamount,r.salikrate,"+
							" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
							" (select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 group by idno"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,"+salamount+" salamount,"+salikratetemp+" salikrate,"+saliksrvctemp+" saliksrvc,"+salikamttemp+" salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,"+trafficamounttemp+" trafficamt,"+trafficsrvctemp+" trafficsrvc from"+
							" gl_lcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";
				}
				else if(closecalmethod==1){
					finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
							"(r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote,r.salamount,r.salikrate,"+
							" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
							"(select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1 group by idno"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,"+salamount+" salamount,"+salikratetemp+" salikrate,"+saliksrvctemp+" saliksrvc,"+salikamttemp+" salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1"+
							" union all"+
							" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,"+trafficamounttemp+" trafficamt,"+trafficsrvctemp+" trafficsrvc from"+
							" gl_lcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1 ) r on(m.idno=r.idno) where r.idno is not null";
				}
				
/*				String finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
						" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote,r.salamount,r.salikrate,"+
						" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
						" (select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
						" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
						" gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 group by idno"+
						" union all"+
						" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
						" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,"+salamount+" salamount,"+salikratetemp+" salikrate,"+saliksrvctemp+" saliksrvc,"+salikamttemp+" salikamt,0 trafficamt,0 trafficsrvc from"+
						" gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0"+
						" union all"+
						" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
						" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,"+trafficamounttemp+" trafficamt,"+trafficsrvctemp+" trafficsrvc from "+
						" gl_lcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";*/
				
				finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,r.invoice,r.creditnote,r.salamount,r.salikrate,"+
				" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
				" (select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount)+sum(cnote),0) total,sum(invoiced)"+
				" invoiced,sum(amount) invoice,sum(cnote) creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
				" gl_lcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1 group by idno"+
				" union all"+
				" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount)+sum(cnote),0) total,sum(invoiced)"+
				" invoiced,sum(amount) invoice,sum(cnote) creditnote,"+salamount+" salamount,"+salikratetemp+" salikrate,"+saliksrvctemp+" saliksrvc,"+salikamttemp+" salikamt,0 trafficamt,0 trafficsrvc from"+
				" gl_lcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1"+
				" union all"+
				" select r.idno,(select qty from gl_lcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount)+sum(cnote),0) total,sum(invoiced)"+
				" invoiced,sum(amount) invoice,sum(cnote) creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,"+trafficamounttemp+" trafficamt,"+trafficsrvctemp+" trafficsrvc from"+
				" gl_lcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1 ) r on(m.idno=r.idno) where r.idno is not null";
			
				ResultSet finalresult=stmtcalctest.executeQuery(finalsql);
				/*if (!finalresult.isBeforeFirst() ) {    
					conn.close(); 
					return RESULTDATA;
					} 
				if(finalresult==null){
					conn.close(); 
					return RESULTDATA;
				}*/
				if(finalresult!=null){
					RESULTDATA=objcommon.convertToJSON(finalresult);	
				}
				
			
				stmtTarif.close();
				stmtcalctest.close();
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
		return RESULTDATA;
		//stmtTarif.close();
		
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		}
	public  int lcalcinsert(String rcalc0,String rcalc1,String rcalc2,String rcalc3,String rcalc4,String rcalc5,String rcalc6,String rcalc7,String rcalc8,String rcalc9,Statement stmtTarif){
		String strinsert1="insert into gl_lcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate,calcstatus,cnote)values('"+rcalc0+"','"+rcalc1+"',"+
				"'"+rcalc2+"','"+rcalc3+"','"+rcalc4+"','"+rcalc5+"','"+rcalc6+"','"+rcalc7+"',"+rcalc8+",1,"+rcalc9+")";
//				System.out.println("Sql Lcalc:"+strinsert1);
				 int val;
			
				 try {
					val = stmtTarif.executeUpdate(strinsert1);
				
				if(val<=0){
					return 0;
				}
				
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return 0;
				}
				return 1;
					}
	
	public  int lcalcedit(String rcalc0,String rcalc1,String rcalc2,String rcalc3,String rcalc4,String rcalc5,String rcalc6,String rcalc7,String rcalc8,Statement stmtTarif){
		String strupdate1="update gl_lcalc set brhid='"+rcalc0+"',rdocno='"+rcalc1+"',dtype='"+rcalc2+"',idno='"+rcalc3+"',amount='"+rcalc4+"',qty='"+rcalc5+"',invoiced='0',invno='0',invdate=null where calcstatus=1 and "+
				"rdocno='"+rcalc1+"' and idno='"+rcalc3+"'";
//				System.out.println("Sql Lcalc:"+strupdate1);
				 int val;
				try {
					val = stmtTarif.executeUpdate(strupdate1);
				
				if(val<=0){
					return 0;
				}
				
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return 0;
				}
				
				return 1;
					}
	public int insert(String agreementno,String clientid,String hidchkcollection,String collectkm,String cmbcollectfuel,Date collectdate,String collecttime,String cmbcheckin,
			String inkm,String cmbinfuel,Date indate,String intime,String cmbrentalagent,String useddays,String usedhours,String totalkm,String excesskm,HttpSession session,
			ArrayList<String> closearray,Date closedate,String mode,String chaufferid, ArrayList<String> calcarray,Date outdate,String clientacno,String hidfleet,
			String creditnotesum, HttpServletRequest request,String hidcheckin,String hidrentalagent,String collectchg,String branch,String agmtbranch,
			String cmbcloseloc,String description,int alfahimstatus) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		//HttpServletRequest request=ServletActionContext.getRequest();
		
		if(alfahimstatus==1){
			Statement stmt=conn.createStatement();
			java.sql.Date calculatedclosedate=null,agmtoutdate=null,sqllastpytdate=null;
			int monthno=0;
			int tempmonthno=0,tempmonthtype=0;
			String strclosedate="";
			String agmtvoucher="";
			java.sql.Date sqlinvdate=null;
			String strgetagmtvalues="select invdate,voc_no,per_value,per_name,outdate,DATE_FORMAT('"+closedate+"','%d.%m.%Y') strclosedate from gl_lagmt where doc_no="+agreementno;
			ResultSet rsagmtvalues=stmt.executeQuery(strgetagmtvalues);
			while(rsagmtvalues.next()){
				sqlinvdate=rsagmtvalues.getDate("invdate");
				agmtvoucher=rsagmtvalues.getString("voc_no");
				tempmonthno=rsagmtvalues.getInt("per_value");
				tempmonthtype=rsagmtvalues.getInt("per_name");
				agmtoutdate=rsagmtvalues.getDate("outdate");
				strclosedate=rsagmtvalues.getString("strclosedate");
			}
			if(tempmonthtype==1){
				monthno=tempmonthno*12;
			}
			else if(tempmonthtype==2){
				monthno=tempmonthno;
			}
			String strcalculateddate="select date_add('"+agmtoutdate+"', interval "+monthno+" month) calculateddate ";
			ResultSet rscalculateddate=stmt.executeQuery(strcalculateddate);
			while(rscalculateddate.next()){
				calculatedclosedate=rscalculateddate.getDate("calculateddate");
			}
			
			/*
			int lastsrno=0;
			String strgetpytlastdate="select date,srno from gl_leasepytcalc where srno=(select max(srno) from gl_leasepytcalc where rdocno="+agreementno+" and markstatus<>0 and status=3)";
			System.out.println(strgetpytlastdate);
			ResultSet rsgetpytlastdate=stmt.executeQuery(strgetpytlastdate);
			while(rsgetpytlastdate.next()){
				sqllastpytdate=rsgetpytlastdate.getDate("date");
				lastsrno=rsgetpytlastdate.getInt("srno");
			}
			if(sqllastpytdate==null){sqllastpytdate=indate;}
			ClsLeaseInvoiceAlFahimDAO objleaseinv=new ClsLeaseInvoiceAlFahimDAO();
			
			String revenueacno=objleaseinv.getRevenueAcno();
			ArrayList<String> journalarray=new ArrayList<>();
			ArrayList<String> invoicearray=new ArrayList<>();
			double currate=objleaseinv.getCurrencyRate(session);
			double totaljvamt=0.0;
			String txtrefno=objleaseinv.getRevenueJVID();
			String desc="Lease Revenue passed as JVT from Lease Close on "+strclosedate;
			double rentalamt=0.0,accamt=0.0,insuramt=0.0,chaufamt=0.0;
			int rentalacno=0,accacno=0,insuracno=0,chaufferacno=0,revenueidno=0;
			double revenuesum=0.0;
			double nextshedulevalue=0.0;
			revenueidno=getRevenueIdno(conn);
			System.out.println("Closeing Date: "+indate);
			System.out.println("Contract end Date: "+calculatedclosedate);
			System.out.println("Last Payment Date: "+sqllastpytdate);
			System.out.println("compare1: "+indate.compareTo(calculatedclosedate));
			System.out.println("compare2: "+indate.compareTo(sqllastpytdate));
			if(indate.compareTo(calculatedclosedate)<0){
				if(indate.compareTo(sqllastpytdate)>0){
					lastsrno++;
					String strnextschedulevalue="select amount from gl_leasepytcalc where srno="+lastsrno;
					System.out.println(strnextschedulevalue);
					ResultSet rsnextschedule=stmt.executeQuery(strnextschedulevalue);
					while(rsnextschedule.next()){
						nextshedulevalue=rsnextschedule.getDouble("amount");
					}
				}
					journalarray=new ArrayList<>();
					invoicearray=new ArrayList<>();
					for(int i=0;i<calcarray.size();i++){
						String calc[]=calcarray.get(i).split("::");
						if(calc[0].equalsIgnoreCase("1") || calc[0].equalsIgnoreCase("2") || calc[0].equalsIgnoreCase("3") || calc[0].equalsIgnoreCase("17")){
							revenuesum+=Double.parseDouble(calc[5]);
						}
						if(calc[0].equalsIgnoreCase("1")){
							rentalamt=Double.parseDouble(calc[5]);
							rentalacno=Integer.parseInt(calc[1]);
						}
						if(calc[0].equalsIgnoreCase("2")){
							accamt=Double.parseDouble(calc[5]);
							accacno=Integer.parseInt(calc[1]);
						}
						if(calc[0].equalsIgnoreCase("3")){
							chaufamt=Double.parseDouble(calc[5]);
							chaufferacno=Integer.parseInt(calc[1]);
						}
						if(calc[0].equalsIgnoreCase("17")){
							insuramt=Double.parseDouble(calc[5]);
							insuracno=Integer.parseInt(calc[1]);
						}
						if(calc[0].equalsIgnoreCase("4") || calc[0].equalsIgnoreCase("11") || calc[0].equalsIgnoreCase("16")){
							invoicearray.add(calc[0]+"::"+calc[1]+"::"+calc[3]+"::"+calc[5]);
						}
						
					}
					if(nextshedulevalue>0.0){
						invoicearray.add(revenueidno+"::"+revenueacno+"::"+"1"+"::"+nextshedulevalue);
					}
					//Passing JVT
					if(revenuesum>0){
						journalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+revenuesum+"::"+revenuesum*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");	
					}
					if(rentalamt>0){
						journalarray.add(rentalacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+rentalamt*-1+"::"+(rentalamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					if(accamt>0){
						journalarray.add(accacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+accamt*-1+"::"+(accamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					if(chaufamt>0){
						journalarray.add(chaufferacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+chaufamt*-1+"::"+(chaufamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					if(insuramt>0){
						journalarray.add(insuracno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+insuramt*-1+"::"+(insuramt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					
					
					
					System.out.println("Printing Journal Array");
					for(int i=0;i<journalarray.size();i++){
						System.out.println(journalarray.get(i));
					}
					System.out.println("Printing Invoice Array");
					for(int i=0;i<invoicearray.size();i++){
						System.out.println(invoicearray.get(i));
					}
					//Temperory Return False
					int status=1;
					if(status==1){
						return 0;
					}
					if(revenuesum>0){
						int jvtval=insertAlFahimJournalVoucher(closedate, "JVT", txtrefno, desc, revenuesum, revenuesum, journalarray, session, request,conn);
						if(jvtval>0){
							int revenueinsert=objleaseinv.journalInvoiceInsert(Integer.parseInt(agreementno), "LAG", indate,indate, branch, session.getAttribute("CURRENCYID").toString(), 
									session.getAttribute("USERID").toString(), clientid,indate, chaufamt,rentalamt, accamt, insuramt, revenuesum, revenueacno, jvtval+"",
									rentalacno, accacno, insuracno, chaufferacno);
							if(revenueinsert<=0){
								return 0;
							}
							int costupdateval=objleaseinv.getJVCostCodeUpdate(jvtval, "JVT");
							if(costupdateval<0){
								return 0;
							}
							//Updating Rdocno and rtype in my_jvtran
							int updatejvrtype=stmt.executeUpdate("update my_jvtran set rdocno="+agreementno+",rtype='LAG' where doc_no="+jvtval+" and dtype='JVT'");
							if(updatejvrtype<0){
								return 0;
							}
						}	
					}
					
					
					if(invoicearray.size()>0){
						int invoiceval=customInvoiceInsert(agreementno,indate,"LAG",branch,session,clientid,invoicearray,conn);
						if(invoiceval<=0){
							return 0;
						}
					}
					
					 * Not need commented nitin
					 * String strjvsum="select (select sum(dramount) from my_jvtran where rdocno="+agreementno+" and rtype='LAG' and acno="+revenueacno+")  jvrevenuesum,"+
							" (select sum(amount)  from gl_revenuem where rdocno="+agreementno+" and rdtype='LAG') revenuesum";
							double jvsum=0.0,revenuesum1=0.0;
							ResultSet rsjvsum=stmt.executeQuery(strjvsum);
							while(rsjvsum.next()){
								jvsum=rsjvsum.getDouble("jvrevenuesum");
								revenuesum1=rsjvsum.getDouble("revenuesum");
							}
							double mainjvsum=jvsum+revenuesum1;
							int prematureacno=getPrematureAcno(conn);
							if(mainjvsum!=0.0){
								ArrayList<String> jvjournalarray=new ArrayList<>();
								jvjournalarray.add(prematureacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+mainjvsum*-1+"::"+(mainjvsum*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
								jvjournalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+mainjvsum+"::"+mainjvsum*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
								int excessjvt=insertAlFahimJournalVoucher(closedate, "JVT", txtrefno, desc, mainjvsum, mainjvsum, jvjournalarray, session, request,conn);
								if(excessjvt<=0){
									return 0;
								}
							}
			}
			else if (indate.compareTo(calculatedclosedate)==0) {
					journalarray=new ArrayList<>();
					invoicearray=new ArrayList<>();
					for(int i=0;i<calcarray.size();i++){
						String calc[]=calcarray.get(i).split("::");
						if(calc[0].equalsIgnoreCase("4") || calc[0].equalsIgnoreCase("11") || calc[0].equalsIgnoreCase("16")){
							invoicearray.add(calc[0]+"::"+calc[1]+"::"+calc[3]+"::"+calc[5]);
						}
						if(calc[0].equalsIgnoreCase("1") || calc[0].equalsIgnoreCase("2") || calc[0].equalsIgnoreCase("3") || calc[0].equalsIgnoreCase("17")){
							revenuesum+=Double.parseDouble(calc[5]);
						}
						if(calc[0].equalsIgnoreCase("1")){
							rentalamt=Double.parseDouble(calc[5]);
							rentalacno=Integer.parseInt(calc[1]);
						}
						if(calc[0].equalsIgnoreCase("2")){
							accamt=Double.parseDouble(calc[5]);
							accacno=Integer.parseInt(calc[1]);
						chaufamt=Double.parseDouble(calc[5]);
								}
						if(calc[0].equalsIgnoreCase("3")){
						chaufferacno=Integer.parseInt(calc[1]);
						}
						if(calc[0].equalsIgnoreCase("17")){
							insuramt=Double.parseDouble(calc[5]);
							insuracno=Integer.parseInt(calc[1]);
						}
					}
					if(invoicearray.size()>0){
						int invoiceval=customInvoiceInsert(agreementno,indate,"LAG",branch,session,clientid,invoicearray,conn);
						if(invoiceval<=0){
							return 0;
						}
					}
					//Passing JVT
					if(revenuesum>0){
						journalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+revenuesum+"::"+revenuesum*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");	
					}
					if(rentalamt>0){
						journalarray.add(rentalacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+rentalamt*-1+"::"+(rentalamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					if(accamt>0){
						journalarray.add(accacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+accamt*-1+"::"+(accamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					if(chaufamt>0){
						journalarray.add(chaufferacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+chaufamt*-1+"::"+(chaufamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					if(insuramt>0){
						journalarray.add(insuracno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+insuramt*-1+"::"+(insuramt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
					}
					
					if(revenuesum>0){
						int jvtval=insertAlFahimJournalVoucher(closedate, "JVT", txtrefno, desc, revenuesum, revenuesum, journalarray, session, request,conn);
						if(jvtval>0){
							int revenueinsert=objleaseinv.journalInvoiceInsert(Integer.parseInt(agreementno), "LAG", indate,indate, branch, session.getAttribute("CURRENCYID").toString(), 
									session.getAttribute("USERID").toString(), clientid,indate, chaufamt,rentalamt, accamt, insuramt, totaljvamt, revenueacno, jvtval+"",
									rentalacno, accacno, insuracno, chaufferacno);
							if(revenueinsert<=0){
								return 0;
							}
							int costupdateval=objleaseinv.getJVCostCodeUpdate(jvtval, "JVT");
							if(costupdateval<0){
								return 0;
							}
							//Updating Rdocno and rtype in my_jvtran
							int updatejvrtype=stmt.executeUpdate("update my_jvtran set rdocno="+agreementno+",rtype='LAG' where doc_no="+jvtval+" and dtype='JVT'");
							if(updatejvrtype<0){
								return 0;
							}
						}	
					}
			}
			else if(indate.compareTo(calculatedclosedate)>0){
				journalarray=new ArrayList<>();
				invoicearray=new ArrayList<>();
				for(int i=0;i<calcarray.size();i++){
					String calc[]=calcarray.get(i).split("::");
					
					if(calc[0].equalsIgnoreCase("4") || calc[0].equalsIgnoreCase("11") || calc[0].equalsIgnoreCase("16") || calc[0].equalsIgnoreCase("17") || calc[0].equalsIgnoreCase("1") || calc[0].equalsIgnoreCase("2") || calc[0].equalsIgnoreCase("3")){
						invoicearray.add(calc[0]+"::"+calc[1]+"::"+calc[3]+"::"+calc[5]);
					}
				}
				
				if(invoicearray.size()>0){
					int invoiceval=customInvoiceInsert(agreementno,indate,"LAG",branch,session,clientid,invoicearray,conn);
					
					if(invoiceval<=0){
						conn.close();
						System.out.println("/////////custom invoice error //////////");
						return 0;
					}
				}
				
				
				
				journalarray=new ArrayList<>();
				invoicearray=new ArrayList<>();
				
				//Calculate jv till duedate & inv from duedate to closedate
				int duedatediff=0,closedatediff=0,closedatemonthend=0;
				String strdatediff="select datediff('"+calculatedclosedate+"',invdate) duedatediff,datediff('"+indate+"','"+calculatedclosedate+"') closedatediff,day(last_day('"+indate+"')) closedatemonthend from gl_lagmt where doc_no="+agreementno;
				System.out.println("Date Difference:"+strdatediff);
				ResultSet rsdatecheck=stmt.executeQuery(strdatediff);
				while(rsdatecheck.next()){
					duedatediff=rsdatecheck.getInt("duedatediff");
					closedatediff=rsdatecheck.getInt("closedatediff");
					closedatemonthend=rsdatecheck.getInt("closedatemonthend");
				}
				
				
				for(int i=0;i<calcarray.size();i++){
					System.out.println("Row in Array: "+calcarray.get(i));
					String calc[]=calcarray.get(i).split("::");
					System.out.println("Normal Amount: "+calc[5]);
					if(calc[0].equalsIgnoreCase("4") || calc[0].equalsIgnoreCase("11") || calc[0].equalsIgnoreCase("16")){
						
						invoicearray.add(calc[0]+"::"+calc[1]+"::"+calc[3]+"::"+calc[5]);
					}
					if(calc[0].equalsIgnoreCase("1") || calc[0].equalsIgnoreCase("2") || calc[0].equalsIgnoreCase("3") || calc[0].equalsIgnoreCase("17")){
						revenuesum+=Double.parseDouble(calc[5]);
						double amount=(Double.parseDouble(calc[5])*duedatediff)/closedatemonthend;
						System.out.println("JV Amount: "+amount);
						revenuesum+=amount;
						if(closedatediff>0){
							double amountinvoice=(Double.parseDouble(calc[5])*closedatediff)/closedatemonthend;
							System.out.println("Invoice Amount: "+amountinvoice);
							if(amountinvoice>0){
								invoicearray.add(calc[0]+"::"+calc[1]+"::"+closedatediff+" Days"+"::"+amountinvoice);
							}
						}
					}
					if(calc[0].equalsIgnoreCase("1")){
						double amount=(Double.parseDouble(calc[5])*duedatediff)/closedatemonthend;
						rentalamt=amount;
						rentalacno=Integer.parseInt(calc[1]);
					}
					if(calc[0].equalsIgnoreCase("2")){
						double amount=(Double.parseDouble(calc[5])*duedatediff)/closedatemonthend;
						accamt=amount;
						accacno=Integer.parseInt(calc[1]);
					chaufamt=Double.parseDouble(calc[5]);
							}
					if(calc[0].equalsIgnoreCase("3")){
						double amount=(Double.parseDouble(calc[5])*duedatediff)/closedatemonthend;
						chaufferacno=Integer.parseInt(calc[1]);
						chaufamt=amount;
					}
					if(calc[0].equalsIgnoreCase("17")){
						double amount=(Double.parseDouble(calc[5])*duedatediff)/closedatemonthend;
						insuramt=amount;
						insuracno=Integer.parseInt(calc[1]);
					}
				}
				if(invoicearray.size()>0){
					int invoiceval=customInvoiceInsert(agreementno,indate,"LAG",branch,session,clientid,invoicearray,conn);
					if(invoiceval<=0){
						return 0;
					}
				}
				//Passing JVT
				if(revenuesum>0){
					journalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+revenuesum+"::"+revenuesum*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");	
				}
				if(rentalamt>0){
					journalarray.add(rentalacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+rentalamt*-1+"::"+(rentalamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
				}
				if(accamt>0){
					journalarray.add(accacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+accamt*-1+"::"+(accamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
				}
				if(chaufamt>0){
					journalarray.add(chaufferacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+chaufamt*-1+"::"+(chaufamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
				}
				if(insuramt>0){
					journalarray.add(insuracno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+insuramt*-1+"::"+(insuramt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");	
				}
				
				if(revenuesum>0){
					int jvtval=insertAlFahimJournalVoucher(closedate, "JVT", txtrefno, desc, revenuesum, revenuesum, journalarray, session, request,conn);
					if(jvtval>0){
						int revenueinsert=objleaseinv.journalInvoiceInsert(Integer.parseInt(agreementno), "LAG", indate,indate, branch, session.getAttribute("CURRENCYID").toString(), 
								session.getAttribute("USERID").toString(), clientid,indate, chaufamt,rentalamt, accamt, insuramt, totaljvamt, revenueacno, jvtval+"",
								rentalacno, accacno, insuracno, chaufferacno);
						if(revenueinsert<=0){
							return 0;
						}
						int costupdateval=objleaseinv.getJVCostCodeUpdate(jvtval, "JVT");
						if(costupdateval<0){
							return 0;
						}
						//Updating Rdocno and rtype in my_jvtran
						int updatejvrtype=stmt.executeUpdate("update my_jvtran set rdocno="+agreementno+",rtype='LAG' where doc_no="+jvtval+" and dtype='JVT'");
						if(updatejvrtype<0){
							return 0;
						}
					}	
				}
		
		
				
				
				
			
			 * not needed nitin
			 * 	String strjvsum="select (select sum(dramount) from my_jvtran where rdocno="+agreementno+" and rtype='LAG' and acno="+revenueacno+")  jvrevenuesum,"+
						" (select sum(amount)  from gl_revenuem where rdocno="+agreementno+" and rdtype='LAG') revenuesum";
						double jvsum=0.0,revenuesum1=0.0;
						ResultSet rsjvsum=stmt.executeQuery(strjvsum);
						while(rsjvsum.next()){
							jvsum=rsjvsum.getDouble("jvrevenuesum");
							revenuesum1=rsjvsum.getDouble("revenuesum");
						}
						double mainjvsum=jvsum+revenuesum1;
						int prematureacno=getPrematureAcno(conn);
						if(mainjvsum!=0.0){
							ArrayList<String> jvjournalarray=new ArrayList<>();
							jvjournalarray.add(prematureacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+mainjvsum*-1+"::"+(mainjvsum*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
							jvjournalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+mainjvsum+"::"+mainjvsum*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
							int excessjvt=insertAlFahimJournalVoucher(closedate, "JVT", txtrefno, desc, mainjvsum, mainjvsum, jvjournalarray, session, request,conn);
							if(excessjvt<=0){
								System.out.println("///////// error insertAlFahimJournalVoucher//////////");
								return 0;
							}
						}
			}*/
			/*
			
			
			
			
			
			
			if(indate.compareTo(calculatedclosedate)<0){
				
				//getting sum corresponding to jvtra
				
				
				
				
				if(indate.compareTo(sqllastpytdate)==0){
					for(int i=0;i<calcarray.size();i++){
						String calc[]=calcarray.get(i).split("::");
						
						if(calc[0].equalsIgnoreCase("4") || calc[0].equalsIgnoreCase("11") || calc[0].equalsIgnoreCase("16")){
							invoicearray.add(calc[0]+"::"+calc[1]+"::"+calc[3]+"::"+calc[5]);
						}
						else{
							
						}
						System.out.println("Inside loop");
					}
					int invoiceval=customInvoiceInsert(agreementno,indate,"LAG",branch,session,clientid,invoicearray,conn);
					if(invoiceval<=0){
						return 0;
					}
					else{
						}
				}
				else if(indate.compareTo(sqllastpytdate)<0){
					//Pass JVT of
					
					for(int i=0;i<calcarray.size();i++){
						String calc[]=calcarray.get(i).split("::");
						double amount=Double.parseDouble(calc[5]);
						double amountparty=Double.parseDouble(calc[5])*-1;
						
						if(calc[0].equalsIgnoreCase("1") || calc[0].equalsIgnoreCase("2") || calc[0].equalsIgnoreCase("3") || calc[0].equalsIgnoreCase("17")){
							totaljvamt+=Double.parseDouble(calc[5]);
							
							journalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+amount+"::"+amount*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
							journalarray.add(calc[1]+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+amountparty+"::"+amountparty*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
						}
						else if(calc[0].equalsIgnoreCase("4") || calc[0].equalsIgnoreCase("11") || calc[0].equalsIgnoreCase("16")){
							invoicearray.add(calc[0]+"::"+calc[1]+"::"+calc[3]+"::"+calc[5]);
						}
						else{
							
						}
						if(calc[0].equalsIgnoreCase("1")){
							rentalacno=Integer.parseInt(calc[1]);
							rentalamt=Double.parseDouble(calc[5]);
						}
						else if(calc[0].equalsIgnoreCase("2")){
							accacno=Integer.parseInt(calc[1]);
							accamt=Double.parseDouble(calc[5]);
						}
						else if(calc[0].equalsIgnoreCase("3")){
							chaufferacno=Integer.parseInt(calc[1]);
							chaufamt=Double.parseDouble(calc[5]);
						}
						else if(calc[0].equalsIgnoreCase("17")){
							insuracno=Integer.parseInt(calc[1]);
							insuramt=Double.parseDouble(calc[5]);
						}
					}
					
					int jvtval=objjournal.insert(closedate, "JVT", txtrefno, desc, totaljvamt, totaljvamt, journalarray, session, request);
					if(jvtval>0){
						int revenueinsert=objleaseinv.journalInvoiceInsert(Integer.parseInt(agreementno), "LAG", indate,indate, branch, session.getAttribute("CURRENCYID").toString(), 
								session.getAttribute("USERID").toString(), clientid,indate, chaufamt,rentalamt, accamt, insuramt, totaljvamt, revenueacno, jvtval+"",
								rentalacno, accacno, insuracno, chaufferacno);
						if(revenueinsert<=0){
							return 0;
						}
						int costupdateval=objleaseinv.getJVCostCodeUpdate(jvtval, "JVT");
						if(costupdateval<0){
							return 0;
						}
						//Updating Rdocno and rtype in my_jvtran
						int updatejvrtype=stmt.executeUpdate("update my_jvtran set rdocno="+agreementno+",rtype='LAG' where doc_no="+jvtval+" and dtype='JVT'");
						if(updatejvrtype<0){
							return 0;
						}
					}
				
					//Invoice of extrakm,fuel,premature
					
					int invoiceval=customInvoiceInsert(agreementno,indate,"LAG",branch,session,clientid,invoicearray,conn);
					if(invoiceval<=0){
						return 0;
					}
					else{
						}
			}
				else if(indate.compareTo(sqllastpytdate)>0){
					
				}
				String strjvsum="select (select sum(dramount) from my_jvtran where rdocno="+agreementno+" and rtype='LAG' and acno="+revenueacno+")  jvrevenuesum,"+
				" (select sum(amount)  from gl_revenuem where rdocno="+agreementno+" and rdtype='LAG') revenuesum";
				double jvsum=0.0,revenuesum=0.0;
				ResultSet rsjvsum=stmt.executeQuery(strjvsum);
				while(rsjvsum.next()){
					jvsum=rsjvsum.getDouble("jvrevenuesum");
					revenuesum=rsjvsum.getDouble("revenuesum");
				}
				double mainjvsum=jvsum+revenuesum;
				int prematureacno=getPrematureAcno(conn);
				if(mainjvsum!=0.0){
					ArrayList<String> jvjournalarray=new ArrayList<>();
					jvjournalarray.add(prematureacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+mainjvsum*-1+"::"+(mainjvsum*-1)*currate+"::"+"1"+"::"+"-1"+"::"+"0"+"::"+"0");
					jvjournalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+mainjvsum+"::"+mainjvsum*currate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"0");
					int excessjvt=objjournal.insert(closedate, "JVT", txtrefno, desc, mainjvsum, mainjvsum, jvjournalarray, session, request);
					if(excessjvt<=0){
						return 0;
					}
				}
			}*/
		
			
			int idno=0,acno=0;
			double invamt=0.0,revenueamt=0.0,revenuesum=0.0;
			ClsLeaseInvoiceAlFahimDAO objleaseinv=new ClsLeaseInvoiceAlFahimDAO();
			
			String revenueacno=objleaseinv.getRevenueAcno();
			ArrayList<String> journalarray=new ArrayList<>();
			ArrayList<String> invoicearray=new ArrayList<>();
			double currate=objleaseinv.getCurrencyRate(session);
			double totaljvamt=0.0;
			String txtrefno=objleaseinv.getRevenueJVID();
			String desc="Lease Revenue passed as JVT from Lease Close of Agmt "+agmtvoucher+" on "+strclosedate;
			double rentalamt=0.0,accamt=0.0,insuramt=0.0,chaufamt=0.0;
			int rentalacno=0,accacno=0,insuracno=0,chaufferacno=0,revenueidno=0,revenuegrtype=0,rentalgrtype=0,accgrtype=0,chauffergrtype=0,insurgrtype=0;
			String strcalc="select (select gr_type from my_head where doc_no="+revenueacno+") revenuegrtype,head.gr_type,calc.amount invoice,calc.cnote revenue,calc.idno,calc.qty,inv.acno from gl_lcalc calc left join gl_invmode inv on calc.idno=inv.idno left join my_head head on inv.acno=head.doc_no where rdocno="+agreementno+" and calcstatus=1";
			ResultSet rscalc=stmt.executeQuery(strcalc);
			while(rscalc.next()){
				idno=rscalc.getInt("idno");
				acno=rscalc.getInt("acno");
				invamt=rscalc.getDouble("invoice");
				revenueamt=rscalc.getDouble("revenue");
				revenuegrtype=rscalc.getInt("revenuegrtype");
				if(idno==1 || idno==2 || idno==3 || idno==17){
					revenuesum+=revenueamt;
					
				}
				if(idno==1){
					rentalamt=revenueamt;
					rentalacno=acno;
					rentalgrtype=rscalc.getInt("gr_type");
				}
				if(idno==2){
					accamt=revenueamt;
					accacno=acno;
					accgrtype=rscalc.getInt("gr_type");
				}
				if(idno==3){
					chaufferacno=acno;
					chaufamt=revenueamt;
					chauffergrtype=rscalc.getInt("gr_type");
				}
				if(idno==17){
					insuramt=revenueamt;
					insuracno=acno;
					insurgrtype=rscalc.getInt("gr_type");
				}
				if(invamt>0){
					invoicearray.add(idno+"::"+acno+"::"+rscalc.getString("qty")+"::"+rscalc.getString("qty")+"::"+invamt+"::"+invamt);
				}
			}
			
			//Passing JVT
			int costcode=0,costtype=0;
			if(revenuesum>0){
				
				journalarray.add(revenueacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+revenuesum+"::"+revenuesum*currate+"::"+"0"+"::"+"1"+"::"+costtype+"::"+costcode);	
			}
			if(rentalamt>0){
				
				journalarray.add(rentalacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+rentalamt*-1+"::"+(rentalamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+costtype+"::"+costcode);	
			}
			if(accamt>0){
				
				journalarray.add(accacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+accamt*-1+"::"+(accamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+costtype+"::"+costcode);	
			}
			if(chaufamt>0){
				
				journalarray.add(chaufferacno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+chaufamt*-1+"::"+(chaufamt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+costtype+"::"+costcode);	
			}
			if(insuramt>0){
				
				journalarray.add(insuracno+"::"+desc+"::"+session.getAttribute("CURRENCYID").toString()+"::"+currate+"::"+insuramt*-1+"::"+(insuramt*-1)*currate+"::"+"1"+"::"+"-1"+"::"+costtype+"::"+costcode);	
			}
			
			if(revenuesum>0){
				int jvtval=insertAlFahimJournalVoucher(closedate, "JVT", txtrefno, desc, revenuesum, revenuesum, journalarray, session, request,conn,agmtbranch);
				if(jvtval>0){
					int revenueinsert=objleaseinv.journalInvoiceInsert(Integer.parseInt(agreementno), "LAG", indate,indate, agmtbranch, session.getAttribute("CURRENCYID").toString(), 
							session.getAttribute("USERID").toString(), clientid,indate, chaufamt,rentalamt, accamt, insuramt, totaljvamt, revenueacno, jvtval+"",
							rentalacno, accacno, insuracno, chaufferacno,conn,"JVT",request);
					if(revenueinsert<=0){
						return 0;
					}
					/*int costupdateval=objleaseinv.getJVCostCodeUpdate(jvtval, "JVT");
					if(costupdateval<0){
						return 0;
					}*/
					//Updating Rdocno and rtype in my_jvtran
					int updatejvrtype=stmt.executeUpdate("update my_jvtran set rdocno="+agreementno+",rtype='LAG' where doc_no="+jvtval+" and dtype='JVT'");
					if(updatejvrtype<0){
						return 0;
					}
				}	
			}
			
			if(invoicearray.size()>0){
				/*int invoiceval=customInvoiceInsert(agreementno,indate,"LAG",branch,session,clientid,invoicearray,conn);
				if(invoiceval<=0){
					return 0;
				}*/
				ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
				String note="Lease Close Invoice of Agmt No "+agmtvoucher+"";
				int invoiceval=manualdao.insert(conn,invoicearray, "LAG", closedate, clientid, Integer.parseInt(agreementno), note, note, sqlinvdate, closedate, agmtbranch,
						session.getAttribute("USERID").toString(), session.getAttribute("CURRENCYID").toString(), mode, clientacno, "INV###5", "INV","");
				if(invoiceval<=0){
					return 0;
				}
			}
			
			int mval=0;
			int voucherno=0;
			//System.out.println("datein:"+indate);
			if(chaufferid.equalsIgnoreCase("")){
				chaufferid="0";
			}
			if(cmbcollectfuel==null){
				cmbcollectfuel="0";
			}
			if(cmbcollectfuel.equalsIgnoreCase("")){
				cmbcollectfuel="0";
			}
			if(hidchkcollection.equalsIgnoreCase("")){
				hidchkcollection="0";
			}
			cmbcollectfuel=cmbcollectfuel==null?"0":cmbcollectfuel;
			hidrentalagent=hidrentalagent==null?"0":hidrentalagent;
			hidcheckin=hidcheckin==null?"0":hidcheckin;
			if(hidrentalagent.equalsIgnoreCase("")){
				hidrentalagent="0";
			}
			if(hidcheckin.equalsIgnoreCase("")){
				hidcheckin="0";
			}
			if(collectchg.equalsIgnoreCase("")){
				collectchg="0";
			}
			CallableStatement stmtClose = conn.prepareCall("{call leaseCloseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtClose.registerOutParameter(22, java.sql.Types.INTEGER);
			stmtClose.registerOutParameter(26, java.sql.Types.INTEGER);
			stmtClose.setDate(1,closedate);
			 stmtClose.setString(2,agreementno);
			 stmtClose.setString(3,clientid);
			 stmtClose.setString(4,hidchkcollection);
			 stmtClose.setString(5,chaufferid);
			 stmtClose.setString(6,collectkm);
			 stmtClose.setString(7,cmbcollectfuel);
			 stmtClose.setDate(8,collectdate);
			 stmtClose.setString(9,collecttime);
			 stmtClose.setString(10,hidcheckin);
			 stmtClose.setString(11,hidrentalagent);
			 stmtClose.setDouble(12,Double.parseDouble(useddays));
			 stmtClose.setString(13,usedhours);
			 stmtClose.setString(14,totalkm);
			 stmtClose.setString(15,excesskm);
			 stmtClose.setString(16,inkm);
			 stmtClose.setString(17,cmbinfuel);
			 stmtClose.setDate(18,indate);
			 stmtClose.setString(19,intime);
			 stmtClose.setString(20,session.getAttribute("USERID").toString());
			 stmtClose.setString(21,branch);
			 stmtClose.setString(23,mode);
			 stmtClose.setInt(24, Integer.parseInt(hidfleet));
			 stmtClose.setDouble(25,Double.parseDouble(collectchg));
			 stmtClose.setString(27,agmtbranch);
			 stmtClose.setString(28,cmbcloseloc);
			 stmtClose.setString(29,description);
//			 System.out.println("8888888888888888  "+stmtClose);
			 stmtClose.executeQuery();
	mval=stmtClose.getInt("docNo");
	voucherno=stmtClose.getInt("voucherno");
	request.setAttribute("VOUCHERNO",voucherno);
			if(mval<=0){
				conn.close();
				System.out.println("////////////////Main Document Error/////////////");
				return 0;
			}
//			System.out.println("Lease Close:"+mval);
			int movdoc=0;
			String selectmovdoc="select doc_no from gl_vmove where rdocno='"+agreementno+"' and rdtype='LAG' and status='OUT'";
			ResultSet rsselectmovdoc=stmt.executeQuery(selectmovdoc);
			while(rsselectmovdoc.next()){
				movdoc=rsselectmovdoc.getInt("doc_no");
			}
			String sqltotal="";
			if(hidchkcollection.equalsIgnoreCase("1")){
				sqltotal="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60  totalmin from (select  cast(concat('"+collectdate+"',' ','"+collecttime+"')"+
						" as datetime) ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where"+
						" doc_no='"+movdoc+"' )m";
			}
			else{
				sqltotal="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60  totalmin from (select  cast(concat('"+indate+"',' ','"+intime+"')"+
						" as datetime) ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where"+
						" doc_no='"+movdoc+"' )m";
			}
			
			//System.out.println("Totalmin Query"+sqltotal);
			ResultSet rstotal=stmt.executeQuery(sqltotal);
			double totalmin=0.0;
			while(rstotal.next()){
				totalmin=rstotal.getDouble("totalmin");
			}
			/*String sqlidle="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60  idletime from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
					" cast(concat('"+datein+"',' ','"+timein+"')as datetime)ts_dout  from gl_vmove where doc_no='"+movdoc+"')m";
			System.out.println("Idle Query"+sqlidle);
			ResultSet rsidle=stmt.executeQuery(sqlidle);
			double idlemin=0.0;
			while(rsidle.next()){
				idlemin=rsidle.getDouble("idletime");
			}*/
			String sql="update gl_lagmt set clstatus=1 where doc_no="+agreementno;
			int val=stmt.executeUpdate(sql);
			cmbinfuel=cmbinfuel==null?"0":cmbinfuel;
			String strloc="select olocid from gl_vmove where doc_no="+movdoc+"";
			ResultSet rsloc=stmt.executeQuery(strloc);
			int locid=0;
			if(rsloc.next()){
			locid=rsloc.getInt("olocid");
			}
			if(val>0){
			
			Statement stmtloc=conn.createStatement();
				String strlocid="select min(doc_no) doc_no from my_locm where brhid="+branch+" and status<>7";
				ResultSet rslocid=stmtloc.executeQuery(strlocid);
				int closelocid=0;
				while(rslocid.next()){
					closelocid=rslocid.getInt("doc_no");
				}
				closelocid=Integer.parseInt(cmbcloseloc);
				Statement stmtveh=conn.createStatement();
				//(select if(dtype='VEH','UR','NR'))
				String strveh="update gl_vehmaster set status='IN',tran_code='UR',a_br="+branch+",a_loc="+closelocid+" where fleet_no="+hidfleet;
				int vehval=stmtveh.executeUpdate(strveh);
				if(vehval<=0){
					conn.close();
					System.out.println("////////////////Vehicle Master Error/////////////");
					return 0;
				}
				Statement stmtac=conn.createStatement();
				String strac="update my_acbook set lostatus=if(lostatus=0,0,lostatus-1)  where cldocno="+clientid+" and dtype='CRM'";
				int acval=stmtac.executeUpdate(strac);
				if(acval<0){
					conn.close();
					System.out.println("////////////////my_acbook Error/////////////");
					return 0;
				}
				stmtac.close();
				String strmov="";
				if(hidchkcollection.equalsIgnoreCase("1")){
					strmov="update gl_vmove set status='IN',din='"+collectdate+"',tin='"+collecttime+"',kmin='"+collectkm+"',fin='"+cmbcollectfuel+"',"+
							"ibrhid='"+branch+"',ilocid="+closelocid+",ireason='Lease Close',iaccident=0,"+
							" ttime='"+totalmin+"',tkm=(select "+collectkm+"-kmout ),tfuel=(select "+cmbcollectfuel+"-fout )where doc_no="+movdoc+" and rdtype='LAG'";
				}
				else{
					strmov="update gl_vmove set status='IN',din='"+indate+"',tin='"+intime+"',kmin='"+inkm+"',fin='"+cmbinfuel+"',"+
							"ibrhid='"+branch+"',ilocid="+closelocid+",ireason='Lease Close',iaccident=0,"+
							" ttime='"+totalmin+"',tkm=(select "+inkm+"-kmout ),tfuel=(select "+cmbinfuel+"-fout )where doc_no="+movdoc+"  and rdtype='LAG'";
				}
				
//				System.out.println("Mov Update Query"+strmov);
				int movval=stmt.executeUpdate(strmov);
//				System.out.println("Mov Val:"+movval);
				if(movval<=0){
					System.out.println("////////////////Update Vmove Error/////////////");
					conn.close();
					return 0;
				}
				int gridsqlval=0;
				if(movval>=0){
					
					//System.out.println("Inside movval");
					for(int i=0;i<closearray.size();i++){
						//System.out.println("Inside for loop");
						String[] close=closearray.get(i).split("::");
						String gridsql="insert into gl_lagmtclosed(rdocno,brhid,rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,exkmrte,chaufchg)values("+
								"'"+agreementno+"','"+branch+"','"+(close[0].equalsIgnoreCase("undefined") || close[0].isEmpty()?0:close[0])+"',"+
								"'"+(close[1].equalsIgnoreCase("undefined") || close[1].isEmpty()?0:close[1])+"','"+(close[2].equalsIgnoreCase("undefined") || close[2].isEmpty()?0:close[2])+"',"+
								"'"+(close[3].equalsIgnoreCase("undefined") || close[3].isEmpty()?0:close[3])+"','"+(close[4].equalsIgnoreCase("undefined") || close[4].isEmpty()?0:close[4])+"',"+
								"'"+(close[5].equalsIgnoreCase("undefined") || close[5].isEmpty()?0:close[5])+"','"+(close[6].equalsIgnoreCase("undefined") || close[6].isEmpty()?0:close[6])+"',"+
								"'"+(close[7].equalsIgnoreCase("undefined") || close[7].isEmpty()?0:close[7])+"','"+(close[8].equalsIgnoreCase("undefined") || close[8].isEmpty()?0:close[8])+"',"+
								"'"+(close[10].equalsIgnoreCase("undefined") || close[10].isEmpty()?0:close[10])+"',"+
								"'"+(close[11].equalsIgnoreCase("undefined") || close[11].isEmpty()?0:close[11])+"')";
//						System.out.println("L Agmt CloseD Sql:"+gridsql);
						 gridsqlval = stmt.executeUpdate (gridsql);
						if(gridsqlval<=0){
							//System.out.println("Return 0 gridsqlval");
							System.out.println("////////////////Lagmt closed Error/////////////");
							conn.close(); 
							return 0;
						}
					}

					
					if(gridsqlval>0){
						conn.commit();
						stmtveh.close();
						stmt.close();
						stmtClose.close();
						conn.close();
						return mval;	
					}
}
		}
		
	
		}
		else{
		
			int agmtvocno=0;
			String mrano="";
		Statement stmtagmtvoc=conn.createStatement();
		String stragmtvoc="select voc_no,coalesce(refno,'') refno from gl_lagmt where doc_no="+agreementno;
		ResultSet rsagmtvoc=stmtagmtvoc.executeQuery(stragmtvoc);
		while(rsagmtvoc.next()){
			agmtvocno=rsagmtvoc.getInt("voc_no");
			mrano=rsagmtvoc.getString("refno");
		}
		if(!mrano.equalsIgnoreCase("")){
			mrano=" ("+mrano+")";
		}
		stmtagmtvoc.close();
		
		
		
		
		Statement stmttest2=conn.createStatement();
		ResultSet rstest2=stmttest2.executeQuery("select fleet_no from gl_vmove where rdocno="+agreementno+" and rdtype='LAG' and status='OUT'");
		while(rstest2.next()){
			hidfleet=rstest2.getString("fleet_no");
		}
		stmttest2.close();
		Statement stmtsrvcacno=conn.createStatement();
		int saliksrvcacno=0;
		int trafficsrvcacno=0;
		java.sql.Date invtempdate=null;
		int damageflag=0,damagedoc=0;
		ResultSet rsacno=stmtsrvcacno.executeQuery("select (select acno from gl_invmode where idno=14) acno,(select acno from gl_invmode where idno=15) trafficsrvcacno,"+
				"(select invdate from gl_lagmt where doc_no="+agreementno+") fromdate");
		while(rsacno.next()){
			saliksrvcacno=rsacno.getInt("acno");
			trafficsrvcacno=rsacno.getInt("trafficsrvcacno");
		}
		
		invtempdate=outdate;
		if(invtempdate.compareTo(indate)>0 || invtempdate.compareTo(indate)==0){
			invtempdate=indate;
		}
						ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
						ClsCreditNoteDAO creditdao=new ClsCreditNoteDAO();
						int agmtno=Integer.parseInt(agreementno);
						ArrayList<String> newarray=new ArrayList<>();
						String qty2="";
						if(calcarray.size()>0){
						qty2=calcarray.get(0).split("::")[3];
						for(int i=0;i<calcarray.size();i++){
						String[] invoicenew=calcarray.get(i).split("::");
						if(Double.parseDouble(invoicenew[5]==null || invoicenew[5].equalsIgnoreCase("undefined")?"0":invoicenew[5].toString())>0){
							if(invoicenew[0].equalsIgnoreCase("8")){
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[7]+"::"+invoicenew[10]);
								newarray.add("14"+"::"+saliksrvcacno+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[8]+"::"+invoicenew[9]);
							
								/*newarray.add("14"+"::"+saliksrvcacno+"::"+note+"::"+salikcount+"::"+salrate+"::"+invoice[12]);*/
							
							}
							else if(invoicenew[0].equalsIgnoreCase("9")){
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[11]+"::"+invoicenew[11]);
								newarray.add("15"+"::"+trafficsrvcacno+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[12]+"::"+invoicenew[12]);
							}
							else if(invoicenew[0].equalsIgnoreCase("4")){
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[5]+"::"+invoicenew[5]);
							}
							else if(invoicenew[0].equalsIgnoreCase("11")){
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[5]+"::"+invoicenew[5]);
							}
							else if(invoicenew[0].equalsIgnoreCase("16")){
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[5]+"::"+invoicenew[5]);
							}
							else if(invoicenew[0].equalsIgnoreCase("18")){
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[5]+"::"+invoicenew[5]);
							}
							else{
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[5]+"::"+invoicenew[5]);	
							}
							
							if(invoicenew[0].equalsIgnoreCase("10")){
								damageflag=1;
								Statement stmtdamagedoc=conn.createStatement();
								String strgetdamagedoc="select insp.doc_no from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno where "+
						" insp.reftype='LAG' and refdocno="+agmtno+" and invno=0 and insp.amount>0 and insp.status=3";
								ResultSet rsdamagedoc=stmtdamagedoc.executeQuery(strgetdamagedoc);
								while(rsdamagedoc.next()){
									damagedoc=rsdamagedoc.getInt("doc_no");
								}
								stmtdamagedoc.close();
							}
							
						}
						}
						}
						String ledgernote=""+objcommon.changeSqltoString(invtempdate)+" to "+objcommon.changeSqltoString(indate)+" for Lease Aggreement no "+agmtno;
						String invnote=""+objcommon.changeSqltoString(invtempdate)+" to "+objcommon.changeSqltoString(indate)+" for Lease Aggreement no "+agmtno;
						int invval=0;
						if(newarray.size()>0){
						invval=manualdao.insert(conn,newarray, "LAG", closedate, clientid, agmtno, ledgernote, invnote, invtempdate, indate, agmtbranch,
								session.getAttribute("USERID").toString(), session.getAttribute("CURRENCYID").toString(), mode, clientacno, "INV###5", "INV",qty2);
						
//						System.out.println("Invoice Value:"+invval);
					/*	if(invval>0){
							Statement stmtsalik=conn.createStatement();
							String strupdatesalik="update gl_salik set inv_no="+invval+",status=1 where ra_no="+agmtno+" and rtype in('LC','LA') and status in(3,0) and sal_date between '"+outdate+"' and '"+indate+"'";
							int val=stmtsalik.executeUpdate(strupdatesalik);
							if(val<0){
								conn.close();
								return 0;
							}
						}*/
						if(invval<=0){
							conn.close();
							System.out.println("////////////////Invoice Error/////////////");
							return 0;
						}
						if(damageflag==1){
							
							String strupdatedamge="update gl_vinspm set invno="+invval+" where doc_no="+damagedoc+" and status<>7";
							Statement stmtupdatedamage=conn.createStatement();
							int updatedamageval=stmtupdatedamage.executeUpdate(strupdatedamge);
							if(updatedamageval<0){
								conn.close();
								System.out.println("////////////////Update Damage Error/////////////");
								return 0;
							}
						}
						}
						Statement stmtinvoice=conn.createStatement();
						
						ArrayList<String> creditarray= new ArrayList<>();
						Statement stmttest=conn.createStatement();
						ResultSet rscurr=stmttest.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+ session.getAttribute("CURRENCYID").toString()+"'");
						int testcurid=0;
						double testcurrate=0.0;
						if(rscurr.next()){
							testcurid=rscurr.getInt("doc_no");
							testcurrate=rscurr.getDouble("c_rate");
						}
						else{
							conn.close();
							System.out.println("////////////////Currency  Error Session/////////////");
							return 0;
						}
						Statement stmtcredit=conn.createStatement();
						if(calcarray.size()>0){
						for(int i=0;i<calcarray.size();i++){
							String[] credit=calcarray.get(i).split("::");
							//System.out.println("creditDAO"+credit[6]);
							if(Double.parseDouble(credit[6]==null || credit[6].equalsIgnoreCase("undefined")?"0":credit[6])>0){
							double baseamt=(Double.parseDouble((String) (credit[6].equalsIgnoreCase("undefined") || credit[6].isEmpty()?0:credit[6])))*testcurrate;
							double amt=(Double.parseDouble((String) (credit[6].equalsIgnoreCase("undefined") || credit[6].isEmpty()?0:credit[6])));
							
							
							
							creditarray.add((credit[1].equalsIgnoreCase("undefined") || credit[1].isEmpty()?0:credit[1])+"::"+session.getAttribute("CURRENCYID").toString()+"::"+testcurrate+"::"+"true"+"::"+amt+"::"+"Credit Note  for Lease Agreement No "+agmtvocno+""+"::"+baseamt+"::"+"6"+"::"+hidfleet);				
							
							}
							
						//System.out.println("array in rental"+creditarray.get(0));
						}
						}
						if(creditarray.size()>0){
//							System.out.println("checking creditnote"+closedate+":"+agreementno+":"+testcurrate+":"+ Integer.parseInt(clientacno)+":"+session.getAttribute("CURRENCYID").toString()+":"+Double.parseDouble(creditnotesum)+":"+mode);
							int crval=creditdao.insert(conn,closedate, "CNO", agreementno, testcurrate, "Credit Note  for Lease Agreement No "+agmtvocno+""+mrano, Integer.parseInt(clientacno),  session.getAttribute("CURRENCYID").toString(), Double.parseDouble(creditnotesum), 
									Double.parseDouble(creditnotesum),"LAG",Integer.parseInt(agreementno), creditarray, session, request, mode);
//							System.out.println("Credit val:"+crval);
							if(crval<0){ 
								conn.close();
								System.out.println("////////////////Credit Note Error/////////////");
								return 0;
							}
							if(crval>=0){
								for(int i=0;i<calcarray.size();i++){
									String[] credit=calcarray.get(i).split("::");
//									System.out.println("Credit:"+Double.parseDouble(credit[6]));
									if(Double.parseDouble(credit[6])>0){
										
								String strcredit="insert into gl_lcalc(brhid,trno,rdocno,dtype,idno,cnote,cnoteno,cnotedate,qty)values("+
									"'"+agmtbranch+"','"+request.getAttribute("tranno").toString()+"','"+agreementno+"','LAG','"+(credit[0].equalsIgnoreCase("undefined") || credit[0].isEmpty()?0:credit[0])+"',"+
										"'"+(credit[6].equalsIgnoreCase("undefined") || credit[6].isEmpty()?0:credit[6])+"','"+crval+"','"+closedate+"','"+(credit[3].equalsIgnoreCase("undefined") || credit[3].isEmpty()?0:credit[3])+"')";
								int crcalc=stmtcredit.executeUpdate(strcredit);
								if(crcalc<=0){
									conn.close();
									System.out.println("////////////////Lcalc credit note insertion Error/////////////");
									return 0;
								}
									}
								}
								//trno=Integer.parseInt(request.getAttribute("tranno").toString());
								
							}
							
							
						}
						int mval=0;
						int voucherno=0;
						//System.out.println("datein:"+indate);
						if(chaufferid.equalsIgnoreCase("")){
							chaufferid="0";
						}
						if(cmbcollectfuel==null){
							cmbcollectfuel="0";
						}
						if(cmbcollectfuel.equalsIgnoreCase("")){
							cmbcollectfuel="0";
						}
						if(hidchkcollection.equalsIgnoreCase("")){
							hidchkcollection="0";
						}
						cmbcollectfuel=cmbcollectfuel==null?"0":cmbcollectfuel;
						hidrentalagent=hidrentalagent==null?"0":hidrentalagent;
						hidcheckin=hidcheckin==null?"0":hidcheckin;
						if(hidrentalagent.equalsIgnoreCase("")){
							hidrentalagent="0";
						}
						if(hidcheckin.equalsIgnoreCase("")){
							hidcheckin="0";
						}
						if(collectchg.equalsIgnoreCase("")){
							collectchg="0";
						}
						CallableStatement stmtClose = conn.prepareCall("{call leaseCloseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						stmtClose.registerOutParameter(22, java.sql.Types.INTEGER);
						stmtClose.registerOutParameter(26, java.sql.Types.INTEGER);
						stmtClose.setDate(1,closedate);
						 stmtClose.setString(2,agreementno);
						 stmtClose.setString(3,clientid);
						 stmtClose.setString(4,hidchkcollection);
						 stmtClose.setString(5,chaufferid);
						 stmtClose.setString(6,collectkm);
						 stmtClose.setString(7,cmbcollectfuel);
						 stmtClose.setDate(8,collectdate);
						 stmtClose.setString(9,collecttime);
						 stmtClose.setString(10,hidcheckin);
						 stmtClose.setString(11,hidrentalagent);
						 stmtClose.setDouble(12,Double.parseDouble(useddays));
						 stmtClose.setString(13,usedhours);
						 stmtClose.setString(14,totalkm);
						 stmtClose.setString(15,excesskm);
						 stmtClose.setString(16,inkm);
						 stmtClose.setString(17,cmbinfuel);
						 stmtClose.setDate(18,indate);
						 stmtClose.setString(19,intime);
						 stmtClose.setString(20,session.getAttribute("USERID").toString());
						 stmtClose.setString(21,branch);
						 stmtClose.setString(23,mode);
						 stmtClose.setInt(24, Integer.parseInt(hidfleet));
						 stmtClose.setDouble(25,Double.parseDouble(collectchg));
						 stmtClose.setString(27,agmtbranch);
						 stmtClose.setString(28,cmbcloseloc);
						 stmtClose.setString(29,description);
//						 System.out.println("8888888888888888  "+stmtClose);
						 stmtClose.executeQuery();
				mval=stmtClose.getInt("docNo");
				voucherno=stmtClose.getInt("voucherno");
				request.setAttribute("VOUCHERNO",voucherno);
						if(mval<=0){
							conn.close();
							System.out.println("////////////////Main Document Error/////////////");
							return 0;
						}
//						System.out.println("Lease Close:"+mval);
							Statement stmt=conn.createStatement();
						int movdoc=0;
						String selectmovdoc="select doc_no from gl_vmove where rdocno='"+agreementno+"' and rdtype='LAG' and status='OUT'";
						ResultSet rsselectmovdoc=stmt.executeQuery(selectmovdoc);
						while(rsselectmovdoc.next()){
							movdoc=rsselectmovdoc.getInt("doc_no");
						}
						String sqltotal="";
						if(hidchkcollection.equalsIgnoreCase("1")){
							sqltotal="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60  totalmin from (select  cast(concat('"+collectdate+"',' ','"+collecttime+"')"+
									" as datetime) ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where"+
									" doc_no='"+movdoc+"' )m";
						}
						else{
							sqltotal="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60  totalmin from (select  cast(concat('"+indate+"',' ','"+intime+"')"+
									" as datetime) ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where"+
									" doc_no='"+movdoc+"' )m";
						}
						
						//System.out.println("Totalmin Query"+sqltotal);
						ResultSet rstotal=stmt.executeQuery(sqltotal);
						double totalmin=0.0;
						while(rstotal.next()){
							totalmin=rstotal.getDouble("totalmin");
						}
						/*String sqlidle="select  TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60  idletime from (select  cast(concat(din,' ',tin) as datetime) ts_din,"+
								" cast(concat('"+datein+"',' ','"+timein+"')as datetime)ts_dout  from gl_vmove where doc_no='"+movdoc+"')m";
						System.out.println("Idle Query"+sqlidle);
						ResultSet rsidle=stmt.executeQuery(sqlidle);
						double idlemin=0.0;
						while(rsidle.next()){
							idlemin=rsidle.getDouble("idletime");
						}*/
						String sql="update gl_lagmt set clstatus=1 where doc_no="+agreementno;
						int val=stmt.executeUpdate(sql);
						cmbinfuel=cmbinfuel==null?"0":cmbinfuel;
						String strloc="select olocid from gl_vmove where doc_no="+movdoc+"";
						ResultSet rsloc=stmt.executeQuery(strloc);
						int locid=0;
						if(rsloc.next()){
						locid=rsloc.getInt("olocid");
						}
						if(val>0){
						
						Statement stmtloc=conn.createStatement();
							String strlocid="select min(doc_no) doc_no from my_locm where brhid="+branch+" and status<>7";
							ResultSet rslocid=stmtloc.executeQuery(strlocid);
							int closelocid=0;
							while(rslocid.next()){
								closelocid=rslocid.getInt("doc_no");
							}
							closelocid=Integer.parseInt(cmbcloseloc);
							Statement stmtveh=conn.createStatement();
							//(select if(dtype='VEH','UR','NR'))
							String strveh="update gl_vehmaster set status='IN',tran_code='UR',a_br="+branch+",a_loc="+closelocid+" where fleet_no="+hidfleet;
							int vehval=stmtveh.executeUpdate(strveh);
							if(vehval<=0){
								conn.close();
								System.out.println("////////////////Vehicle Master Error/////////////");
								return 0;
							}
							Statement stmtac=conn.createStatement();
							String strac="update my_acbook set lostatus=if(lostatus=0,0,lostatus-1)  where cldocno="+clientid+" and dtype='CRM'";
							int acval=stmtac.executeUpdate(strac);
							if(acval<0){
								conn.close();
								System.out.println("////////////////my_acbook Error/////////////");
								return 0;
							}
							stmtac.close();
							String strmov="";
							if(hidchkcollection.equalsIgnoreCase("1")){
								strmov="update gl_vmove set status='IN',din='"+collectdate+"',tin='"+collecttime+"',kmin='"+collectkm+"',fin='"+cmbcollectfuel+"',"+
										"ibrhid='"+branch+"',ilocid="+closelocid+",ireason='Lease Close',iaccident=0,"+
										" ttime='"+totalmin+"',tkm=(select "+collectkm+"-kmout ),tfuel=(select "+cmbcollectfuel+"-fout )where doc_no="+movdoc+" and rdtype='LAG'";
							}
							else{
								strmov="update gl_vmove set status='IN',din='"+indate+"',tin='"+intime+"',kmin='"+inkm+"',fin='"+cmbinfuel+"',"+
										"ibrhid='"+branch+"',ilocid="+closelocid+",ireason='Lease Close',iaccident=0,"+
										" ttime='"+totalmin+"',tkm=(select "+inkm+"-kmout ),tfuel=(select "+cmbinfuel+"-fout )where doc_no="+movdoc+"  and rdtype='LAG'";
							}
							
//							System.out.println("Mov Update Query"+strmov);
							int movval=stmt.executeUpdate(strmov);
//							System.out.println("Mov Val:"+movval);
							if(movval<=0){
								System.out.println("////////////////Update Vmove Error/////////////");
								conn.close();
								return 0;
							}
							int gridsqlval=0;
							if(movval>=0){
								
								//System.out.println("Inside movval");
								for(int i=0;i<closearray.size();i++){
									//System.out.println("Inside for loop");
									String[] close=closearray.get(i).split("::");
									String gridsql="insert into gl_lagmtclosed(rdocno,brhid,rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,exkmrte,chaufchg)values("+
											"'"+agreementno+"','"+branch+"','"+(close[0].equalsIgnoreCase("undefined") || close[0].isEmpty()?0:close[0])+"',"+
											"'"+(close[1].equalsIgnoreCase("undefined") || close[1].isEmpty()?0:close[1])+"','"+(close[2].equalsIgnoreCase("undefined") || close[2].isEmpty()?0:close[2])+"',"+
											"'"+(close[3].equalsIgnoreCase("undefined") || close[3].isEmpty()?0:close[3])+"','"+(close[4].equalsIgnoreCase("undefined") || close[4].isEmpty()?0:close[4])+"',"+
											"'"+(close[5].equalsIgnoreCase("undefined") || close[5].isEmpty()?0:close[5])+"','"+(close[6].equalsIgnoreCase("undefined") || close[6].isEmpty()?0:close[6])+"',"+
											"'"+(close[7].equalsIgnoreCase("undefined") || close[7].isEmpty()?0:close[7])+"','"+(close[8].equalsIgnoreCase("undefined") || close[8].isEmpty()?0:close[8])+"',"+
											"'"+(close[10].equalsIgnoreCase("undefined") || close[10].isEmpty()?0:close[10])+"',"+
											"'"+(close[11].equalsIgnoreCase("undefined") || close[11].isEmpty()?0:close[11])+"')";
//									System.out.println("L Agmt CloseD Sql:"+gridsql);
									 gridsqlval = stmt.executeUpdate (gridsql);
									if(gridsqlval<=0){
										//System.out.println("Return 0 gridsqlval");
										System.out.println("////////////////Lagmt closed Error/////////////");
										conn.close(); 
										return 0;
									}
								}
			
		}
							if(gridsqlval>0){
		//						conn.commit();
								stmtcredit.close();
								stmtinvoice.close();
								stmttest.close();
								stmttest2.close();
								stmtveh.close();
								stmt.close();
								stmtClose.close();
								conn.close();
								return mval;	
							}
		}
		}
		}
		catch(Exception e){
			e.printStackTrace();
		conn.close();
		System.out.println("////////////////Exception Error/////////////");
		return 0;
		}
		finally{
		conn.close();
		}
		conn.close();
		System.out.println("////////////////Outer Error/////////////");
		return 0;
	}

	
	
	private int getRevenueIdno(Connection conn) {
		// TODO Auto-generated method stub
		int idno=0;
		try{
			Statement stmt=conn.createStatement();
			String strsql="select idno from gl_invmode where description='LEASE CHARGES' and status=1";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				idno=rs.getInt("idno");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return idno;
	}
	private int getPrematureAcno(Connection conn) {
		// TODO Auto-generated method stub
		int prematureacno=0;
		try{
			Statement stmt=conn.createStatement();
			String stracno="select acno from gl_invmode where idno=16 and status=1";
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				prematureacno=rsacno.getInt("acno");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		return prematureacno;
	}
	private int customInvoiceInsert(String agreementno, Date indate,
			String string, String branch, HttpSession session, String clientid,
			ArrayList<String> invoicearray,Connection conn) {
			System.out.println("Inside customInvoiceInsert");
			int maxdocno=0;
		try{
			Statement stmt=conn.createStatement();
			int docmethod=0,maxtrno=0,clientacno=0;
			String vocno="";
			int srno=1;
			ClsLeaseInvoiceAlFahimDAO objlease=new ClsLeaseInvoiceAlFahimDAO();
			double currate=objlease.getCurrencyRate(session);
			int fleetno=0;
			String agmtvoucher="";
			//Getting Max Doc no from gl_invm,deciding factor of voc_no from gl_config,trno from my_trno,Client Acno from my_acbook
			String strmaxdocno="select (select perfleet from gl_lagmt where doc_no="+agreementno+") fleetno,"+
			" (select voc_no from gl_lagmt where doc_no="+agreementno+") agmtvoucher,(select coalesce(max(doc_no)+1,1)  from gl_invm) maxdocno,"+
			" (select method from gl_config where field_nme='Yeardocno') docmethod ,(select (max(trno)+1) from my_trno) maxtrno,"+
			" (select acno from my_acbook where cldocno="+clientid+" and dtype='CRM') clientacno";
			ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
			
			while(rsmaxdocno.next()){
				maxdocno=rsmaxdocno.getInt("maxdocno");
				docmethod=rsmaxdocno.getInt("docmethod");
				maxtrno=rsmaxdocno.getInt("maxtrno");
				clientacno=rsmaxdocno.getInt("clientacno");
				fleetno=rsmaxdocno.getInt("fleetno");
				agmtvoucher=rsmaxdocno.getString("agmtvoucher");
			}
			System.out.println("TRNO: "+maxtrno);
			String strvocno="";
			if(docmethod==1){
				strvocno="select concat(1,BRANCHID,DATE_FORMAT('"+indate+"', '%y'),LPAD(coalesce(max(SUBSTRING(voc_no FROM 5 FOR 8))+1,1),5,0)) vocno from gl_invm "+
				" where brhid="+branch;
			}
			else if(docmethod==0){
				strvocno="select coalesce((max(voc_no)+1),1) vocno from gl_invm where brhid="+branch;
			}
			ResultSet rsvocno=stmt.executeQuery(strvocno);
			while(rsvocno.next()){
				vocno=rsvocno.getString("vocno");
			}
			System.out.println("insert into my_trno(trno,userno,trtype,brhid,edate)values("+maxtrno+","+session.getAttribute("USERID").toString()+",'INV',"+branch+",now())");
			int trnoinsert=stmt.executeUpdate("insert into my_trno(userno,trtype,brhid,edate)values("+session.getAttribute("USERID").toString()+",'INV',"+branch+",now())");
			if(trnoinsert<=0){
				return 0;
			}
			else{
				String note="Lease Close Invoice of Agmt No "+agmtvoucher+"";
				String strinvminsert="insert into gl_invm(brhid,doc_no,voc_no,date,ratype,cldocno,rano,ldgrnote,invnote,curid,acno,tr_no,dtype,fromdate,todate,status,userid)"+
						" values("+branch+","+maxdocno+","+vocno+",'"+indate+"','LAG',"+clientid+","+agreementno+",'"+note+"','"+note+"',"+session.getAttribute("CURRENCYID").toString()+""+
						" ,"+clientacno+","+maxtrno+",'INV','"+indate+"','"+indate+"',3,"+session.getAttribute("USERID").toString()+")";
				System.out.println(strinvminsert);
				int invminsert=stmt.executeUpdate(strinvminsert);
				/*if(invminsert>0){
					String strupdatesalik="update gl_salik set inv_no="+maxdocno+",inv_type='INV',status=1 where ra_no="+agmtno+" and  isallocated=1 and rtype "+rtype+" and "+
							" sal_date<='"+todate+"' and inv_no=0";	
				}*/
				if(invminsert<=0){
					return 0;
				}
				else{
					String strdataloginsert="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+maxdocno+","+branch+",'INV',now(),"+session.getAttribute("USERID").toString()+",'A')";
					int dataloginsert=stmt.executeUpdate(strdataloginsert);
					if(dataloginsert<=0){
						return 0;
					}
					else{
						for(int i=0;i<invoicearray.size();i++){
							String invoice[]=invoicearray.get(i).split("::");
							String strcheckgrtype="select gr_type from my_head where doc_no="+invoice[1];
							ResultSet rscheckgrtype=stmt.executeQuery(strcheckgrtype);
							int grtype=0;
							while(rscheckgrtype.next()){
								grtype=rscheckgrtype.getInt("gr_type");
							}
							int costcode=0,costtype=0;
							if(grtype==4 || grtype==5){
								costcode=fleetno;
								costtype=6;
							}
							String strinvdinsert="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values("+(i+1)+","+branch+","+maxdocno+","+maxtrno+","+invoice[0]+",'"+invoice[2]+"',"+invoice[3]+","+invoice[1]+","+invoice[3]+")";
							int invdinsert=stmt.executeUpdate(strinvdinsert);
							if(invdinsert>0){
								String strlcalcinsert="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values("+branch+","+maxtrno+","+agreementno+",'LAG',"+invoice[3]+","+maxdocno+",'"+indate+"',"+invoice[0]+",'"+invoice[2]+"',"+invoice[3]+")";
								int insertlcalc=stmt.executeUpdate(strlcalcinsert);
								
								if(insertlcalc<=0){
									return 0;
								}
								else{
									double amount=Double.parseDouble(invoice[3])*-1;
									double partyamount=Double.parseDouble(invoice[3]);
									String strjventrycompany="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
									" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,costtype,costcode)values('"+maxtrno+"','"+invoice[1]+"',"+amount+","+
									" "+currate+",'"+session.getAttribute("CURRENCYID").toString()+"',0,1,'"+(i+1)+"','"+branch+"','"+note+"',0,'"+indate+"',"+
									" 'INV','"+amount*currate+"','"+maxdocno+"','"+invoice[2]+"','"+currate+"','5',1,0,3,'"+agreementno+"','LAG',"+costtype+","+costcode+")";
									System.out.println(strjventrycompany);
									int jventrycompany=stmt.executeUpdate(strjventrycompany);
									if(jventrycompany<=0){
										return 0;
									}
									else{
										String strjventryparty="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,"+
										" ldramount,doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,costtype,costcode)values('"+maxtrno+"','"+clientacno+"',"+partyamount+","+
										" "+currate+",'"+session.getAttribute("CURRENCYID").toString()+"',0,-1,'"+(i+2)+"','"+branch+"','"+note+"',0,'"+indate+"',"+
										" 'INV','"+partyamount*currate+"','"+maxdocno+"','"+invoice[2]+"','"+currate+"','5',1,"+clientid+",3,'"+agreementno+"','LAG',0,0)";
										System.out.println(strjventryparty);
										
										int jventryparty=stmt.executeUpdate(strjventryparty);
										if(jventrycompany<=0){
											System.out.println("last jvtran insert");
											return 0;
										}	
										else{
											if(grtype==4 || grtype==5){
												int tranid=0;
												String strgettran="SELECT TRANID FROM my_jvtran where TR_NO="+maxtrno+" and acno="+invoice[1];
												ResultSet rsgettran = stmt.executeQuery(strgettran);
												while (rsgettran.next()) {
													tranid = rsgettran.getInt("TRANID");
												}
												String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+invoice[1]+","+costtype+","+invoice[3]+","+srno+","+fleetno+","+tranid+","+maxtrno+")";
												System.out.println("costran entry : "+strcostinsert);
												int costinsert = stmt.executeUpdate(strcostinsert);
												if(costinsert<=0){
													    stmt.close();
														return 0;
												}
												srno++;
											}
										}
									}
								}
							}
						}
						
					}
				}
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		
		System.out.println("maxdocno     "+maxdocno);
		// TODO Auto-generated method stub
		return maxdocno; 
	}
	public int getClosecal() throws SQLException {
		// TODO Auto-generated method stub
		int config=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement  stmtconfig=conn.createStatement();
			String strconfig="select method from gl_config where field_nme='closecal'";
			ResultSet rsconfig=stmtconfig.executeQuery(strconfig);
			while(rsconfig.next()){
				config=rsconfig.getInt("method");
			}
			stmtconfig.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return config;
	}
	
	
	public int delete(int docno, String agreementno, HttpSession session,
			String mode, String hidfleet, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtmov=conn.createStatement();
			int temprdocno=0;
			String temptype="";
			//System.out.println("Fleet:"+hidfleet);
			int maxdoc=0;
			String strmov="select max(doc_no) maxdoc from gl_vmove where fleet_no="+hidfleet;
			ResultSet rsmov=stmtmov.executeQuery(strmov);
			while(rsmov.next()){
				maxdoc=rsmov.getInt("maxdoc");
			}
//			System.out.println(strmov);
			
			ResultSet rsmax=stmtmov.executeQuery("select rdocno,rdtype from gl_vmove where doc_no="+maxdoc+"");
			while(rsmax.next()){
				temptype=rsmax.getString("rdtype");
				temprdocno=rsmax.getInt("rdocno");
			}
//			System.out.println("select rdocno,rdtype from gl_vmove where doc_no="+maxdoc+"");
//			System.out.println(temprdocno+"::"+agreementno);
			if(temptype.equalsIgnoreCase("LAG") && temprdocno==(Integer.parseInt(agreementno))){
				 CallableStatement stmtdelete=conn.prepareCall("{call leaseCloseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				 stmtdelete.setInt(22, docno);
				 stmtdelete.setInt(26, 0);
				 stmtdelete.setDate(1,null);
				 stmtdelete.setString(2,agreementno);
				 stmtdelete.setString(3,"0");
				 stmtdelete.setString(4,"0");
				 stmtdelete.setString(5,"0");
				 stmtdelete.setString(6,"0");
				 stmtdelete.setString(7,"0");
				 stmtdelete.setDate(8,null);
				 stmtdelete.setString(9,"0");
				 stmtdelete.setString(10,"0");
				 stmtdelete.setString(11,"0");
				 stmtdelete.setDouble(12,Double.parseDouble("0"));
				 stmtdelete.setString(13,"0");
				 stmtdelete.setString(14,"0");
				 stmtdelete.setString(15,"0");
				 stmtdelete.setString(16,"0");
				 stmtdelete.setString(17,"0");
				 stmtdelete.setDate(18,null);
				 stmtdelete.setString(19,"0");
				 stmtdelete.setString(20,session.getAttribute("USERID").toString());
				 stmtdelete.setString(21,brchName);
				 stmtdelete.setString(23,mode);
				 stmtdelete.setInt(24, Integer.parseInt(hidfleet));
				 stmtdelete.setDouble(25,Double.parseDouble("0"));
				 stmtdelete.setString(27,"0");
				 stmtdelete.setString(28,"0");
				 stmtdelete.setString(29,"0");
				 int val=stmtdelete.executeUpdate();
//				 System.out.println("Check:"+val);
				 if(val>0){
					 conn.commit();
					 return 1;
				 }
				 else{
					 return 0;
				 }
			}
			else{
				return -1;
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
	
	public int insertAlFahimJournalVoucher(Date journalVouchersDate, String formdetailcode1, String txtrefno, String txtdescription, double txtdrtotal, double txtcrtotal,
			ArrayList<String> journalvouchersarray, HttpSession session,HttpServletRequest request,Connection conn,String agmtbranch) throws SQLException {
		System.out.println("Jv :"+txtdrtotal+"/////"+txtcrtotal);
		
		try{
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString();
			String company=session.getAttribute("COMPANYID").toString();
			int total = 0;String formdetailcode ="",referenceId="";
			branch=agmtbranch;
			if(formdetailcode1.contains("-")){
				String[] parts = formdetailcode1.split("-");
				formdetailcode = parts[0]; 
				referenceId = parts[1];
			}else{
				formdetailcode=formdetailcode1;
				referenceId="0";
			}
			
			if(txtdrtotal<0){
				txtdrtotal=txtdrtotal*-1;
			}
			
			if(txtcrtotal<0){
				txtcrtotal=txtcrtotal*-1;
			}
			
			CallableStatement stmtJVT = conn.prepareCall("{CALL jvmaDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtJVT.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtJVT.registerOutParameter(12, java.sql.Types.INTEGER);
			
			stmtJVT.setDate(1,journalVouchersDate); //Date
			stmtJVT.setString(2,txtrefno); //Ref No
			stmtJVT.setString(3,txtdescription); //Description
			stmtJVT.setDouble(4,txtdrtotal); //Dr Total
			stmtJVT.setDouble(5,txtcrtotal); //Cr Total
			stmtJVT.setString(6,formdetailcode);
			stmtJVT.setString(7,company);
			stmtJVT.setString(8,branch);
			stmtJVT.setString(9,userid);
			stmtJVT.setString(10,referenceId);//Distinguishing Reference Id
			stmtJVT.setString(13,"A");
			int datas=stmtJVT.executeUpdate();
			if(datas<=0){
				stmtJVT.close();
				conn.close();
				return 0;
			}
			int docno=stmtJVT.getInt("docNo");
			int trno=stmtJVT.getInt("itranNo");
			request.setAttribute("tranno", trno);
			//journalVouchersBean.setTxtjournalvouchersdocno(docno);
			if (docno > 0) {

				/*Journal Voucher Grid Saving*/
				for(int i=0;i< journalvouchersarray.size();i++){
				String[] journalvoucher=journalvouchersarray.get(i).split("::");
				
				 if(!journalvoucher[0].equalsIgnoreCase("undefined") && !journalvoucher[0].equalsIgnoreCase("NaN")){
				 int icldocno=0,ilapply=0,trid=0,count=0,approvalStatus=0;
				 
				 String sql=("select cldocno,lapply from my_head where doc_no="+(journalvoucher[0].equalsIgnoreCase("undefined") || journalvoucher[0].isEmpty()?0:journalvoucher[0]));
				 ResultSet resultSet = stmtJVT.executeQuery(sql);
				 
				 while (resultSet.next()) {
				 icldocno=resultSet.getInt("cldocno");
				 ilapply=resultSet.getInt("lapply");
				 }
				
				String sqls="select count(*) as icount from my_apprmaster where status=3 and dtype='"+formdetailcode+"'";
				 ResultSet resultSets = stmtJVT.executeQuery(sqls);
				 
				 while (resultSets.next()) {
					 count=resultSets.getInt("icount");
				 }
				 
				 if(count==0){
					 approvalStatus=3;
				 } else if(count>0 && referenceId.equalsIgnoreCase("1")) {
					 approvalStatus=0;
				 } else if(count>0 && !(referenceId.equalsIgnoreCase("1"))) {
					 approvalStatus=3;
				 }
				 
				String sql2="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
						+ "dTYPE,brhId,tr_no,STATUS)VALUES('"+journalVouchersDate+"','"+txtrefno+"','"+docno+"',"
						+ "'"+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim())+"',"
						+ "'"+(journalvoucher[1].trim().equalsIgnoreCase("undefined") || journalvoucher[1].trim().equalsIgnoreCase("NaN") || journalvoucher[1].trim().isEmpty()?0:journalvoucher[1].trim())+"',"
						+ "'"+(journalvoucher[2].trim().equalsIgnoreCase("undefined") || journalvoucher[2].trim().equalsIgnoreCase("NaN") || journalvoucher[2].trim().isEmpty()?0:journalvoucher[2].trim())+"',"
					    + "'"+(journalvoucher[3].trim().equalsIgnoreCase("undefined") || journalvoucher[3].trim().equalsIgnoreCase("NaN") || journalvoucher[2].trim().equals(0) || journalvoucher[3].trim().isEmpty()?1:journalvoucher[3].trim()).toString()+"',"
					    + "'"+(journalvoucher[4].trim().equalsIgnoreCase("undefined") || journalvoucher[4].trim().equalsIgnoreCase("NaN") || journalvoucher[4].trim().isEmpty()?0:journalvoucher[4].trim())+"',"
					    + "'"+(journalvoucher[5].trim().equalsIgnoreCase("undefined") || journalvoucher[5].trim().equalsIgnoreCase("NaN") || journalvoucher[5].trim().isEmpty()?0:journalvoucher[5].trim())+"',0,"
					    + "4,"+(i+1)+",'"+ilapply+"','"+icldocno+"',"
					    + "'"+(journalvoucher[3].trim().equalsIgnoreCase("undefined") || journalvoucher[3].trim().equalsIgnoreCase("NaN") || journalvoucher[3].trim().isEmpty()?0:journalvoucher[3].trim())+"',"
					    + "'"+(journalvoucher[7].trim().equalsIgnoreCase("undefined") || journalvoucher[7].trim().equalsIgnoreCase("NaN") || journalvoucher[7].trim().isEmpty()?0:journalvoucher[7].trim())+"',"
					    + "'"+(journalvoucher[8].trim().equalsIgnoreCase("undefined") || journalvoucher[8].trim().equalsIgnoreCase("NaN") || journalvoucher[8].trim().equalsIgnoreCase("") || journalvoucher[8].trim().isEmpty()?0:journalvoucher[8].trim())+"',"
					    + "'"+(journalvoucher[9].trim().equalsIgnoreCase("undefined") || journalvoucher[9].trim().equalsIgnoreCase("NaN") || journalvoucher[9].trim().equalsIgnoreCase("") || journalvoucher[9].trim().isEmpty()?0:journalvoucher[9].trim())+"',"
					    + "'"+formdetailcode+"','"+branch+"','"+trno+"',"+approvalStatus+")";
				System.out.println(sql2);
				int data = stmtJVT.executeUpdate(sql2);
				if(data<=0){
					stmtJVT.close();
					conn.close();
					return 0;
				}
				
				 String sql3="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim());
				 ResultSet resultSet2 = stmtJVT.executeQuery(sql3);
				    
				 while (resultSet2.next()) {
				 trid = resultSet2.getInt("TRANID");
				 }
				
				 if(!journalvoucher[8].equalsIgnoreCase("undefined") && !journalvoucher[8].trim().equalsIgnoreCase("0")){
				 String sql4="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim())+","
				 		+ ""+(journalvoucher[8].trim().equalsIgnoreCase("undefined") || journalvoucher[8].trim().equalsIgnoreCase("NaN") || journalvoucher[8].trim().equalsIgnoreCase("") || journalvoucher[8].trim().isEmpty()?0:journalvoucher[8].trim())+","
				 	    + ""+(journalvoucher[5].trim().equalsIgnoreCase("undefined") || journalvoucher[5].trim().equalsIgnoreCase("NaN") || journalvoucher[5].trim().isEmpty()?0:journalvoucher[5].trim())+","+(i+1)+","
				 	    + ""+(journalvoucher[9].trim().equalsIgnoreCase("undefined") || journalvoucher[9].trim().equalsIgnoreCase("NaN") || journalvoucher[9].trim().isEmpty()?0:journalvoucher[9].trim())+","+trid+","+trno+")";
				 System.out.println("journal voucher costran entry : "+sql4);
				 int data2 = stmtJVT.executeUpdate(sql4);
				 if(data2<=0){
					    stmtJVT.close();
						conn.close();
						return 0;
					  }
				 	}
				 }
			}
				
				String sqltestrahis="select ldramount as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSetrahis = stmtJVT.executeQuery(sqltestrahis);
			    
				 while (resultSetrahis.next()) {
					 total=resultSetrahis.getInt("jvtotal");
					 System.out.println("JVTOTAL:"+total);
				 }
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtJVT.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0){
					
					stmtJVT.close();
					
					System.out.println("JV SUCCESS");
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtJVT.close();
					    return 0;
				    }
			}
			
			stmtJVT.close();
			
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 
	 }
		return 0;
	}

}
