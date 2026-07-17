package com.operations.agreement.rentalclosesayara;
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

import org.apache.poi.ss.formula.functions.WeekNum;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.creditnote.ClsCreditNoteDAO;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;
import com.sms.SmsAction;
import com.operations.agreement.rentalagreement.ClsRentalAgreementDAO;


public class ClsRentalCloseSayaraDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	//Method for Search Detailed Document Starts here
	public   ClsRentalCloseSayaraBean getViewDetails(String agreementno,int docno) throws SQLException {
		// TODO Auto-generated method stub
		
		ClsRentalCloseSayaraBean bean=new ClsRentalCloseSayaraBean();
		Connection conn = null;
		
		try {
		
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String strSql="select coalesce(rclosem.orgregcardcollect,0) orgregcardcollect,coalesce(agmt.orgregcard,0) orgregcard,plate.code_name platecode,coalesce(rclosem.desc1,'') closedesc,rclosem.agmtbranch,rclosem.locid,agmt.voc_no vocno,rclosem.voc_no voucherno,coalesce(agmt.desc1,'') desc1,rclosem.date,rclosem.cldocno,rclosem.colstatus,rclosem.coldrid,rclosem.colfuel,rclosem.coldate,rclosem.coltime,rclosem.chkinid,"+
					" rclosem.rlaid,round(rclosem.colchg,2) colchg,round(rclosem.colkm,2) colkm,round(rclosem.daysused,2) daysused,rclosem.hrsused,round(rclosem.totalkm,2) totalkm,round(rclosem.excesskm,2) excesskm"+
					" ,round(rclosem.inkm,2) inkm,rclosem.infuel,rclosem.indate,"+
					" rclosem.intime,rclosem.fleet_no,veh.flname,veh.reg_no,drv.sal_name driver,chk.sal_name checkin,rla.sal_name rentalagent,"+
					" ac.refname,ac.address,ac.per_mob,ac.mail1,clr.color,grp.gname from gl_ragmtclosem rclosem left join gl_ragmt agmt on rclosem.agmtno=agmt.doc_no"+
					" left join  my_salesman drv on(drv.doc_no=rclosem.coldrid and "+
					" drv.sal_type='DRV') left join my_salesman chk on(chk.doc_no=rclosem.chkinid and chk.sal_type='CHK') left join my_salesman rla on "+
					" (rla.doc_no=rclosem.rlaid and rla.sal_type='RLA') left join my_acbook ac on(rclosem.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh"+
					" on(rclosem.fleet_no=veh.fleet_no) left join my_color clr on(veh.clrid=clr.doc_no) left join gl_vehgroup grp"+
					" on(veh.vgrpid=grp.doc_no) left join gl_vehplate plate on veh.pltid=plate.doc_no where rclosem.doc_no="+docno;
			ResultSet resultSet = stmt.executeQuery(strSql);
			while(resultSet.next()){
				bean.setHidchkorgregcard(resultSet.getString("orgregcard"));
				bean.setHidchkorgregcardcollect(resultSet.getString("orgregcardcollect"));
				bean.setCmbagmtbranch(resultSet.getString("agmtbranch"));
				bean.setVoucherno(resultSet.getInt("voucherno"));
				bean.setVocno(resultSet.getString("vocno"));
				bean.setClientid(resultSet.getString("cldocno"));
				bean.setHidchkcollection(resultSet.getString("colstatus"));
				bean.setChaufferid(resultSet.getString("coldrid"));
				bean.setHidcmbcollectfuel(resultSet.getString("colfuel"));
				bean.setCmbcloseloc(resultSet.getString("locid"));
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
				bean.setHidfleet(resultSet.getString("fleet_no"));
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
				
			}
			stmt.close();
			conn.close();
			return bean;
		}
		catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		finally{
			conn.close();
		}
conn.close();
		return bean;
		}
	
	//Method for Search Detailed Document Ends here

	
	
	public   JSONArray getSearchDetails() throws SQLException {
		 Connection conn=null;
			
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmtTarif = conn.createStatement();
				String strSql="select doc_no,date,agmtno from gl_ragmtclosem where status<>7";
	        	//System.out.println(strSql);
				ResultSet resultSet = stmtTarif.executeQuery(strSql);
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
	
	
	//Method for Search Details - Grid Starts Here
    public   JSONArray mainSearch(HttpSession session,String sclname,String smob,String rno,String flno,String sregno,String smra,String branch,String allbranch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	    	
       // String brnchid=session.getAttribute("BRANCHID").toString();
    	//System.out.println("name"+sclname);
    	
    	String sqltest="";

    	Connection conn =null;
		try {
			conn=objconn.getMyConnection();
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
    		sqltest=sqltest+" and r.fleet_no like '%"+flno+"%'";
    	}
    	if(!(sregno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and v.reg_no like '%"+sregno+"%'";
    	}
    	if(!(smra.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and agmt.mrano like '%"+smra+"%'";
    	}
    	 sqltest+=" and r.status<>7";
    	 
    	 if(allbranch.equalsIgnoreCase("1")){
    		 
    	 }
    	 else{
    		 if(!branch.equalsIgnoreCase("")){
    			 sqltest+=" and r.brchid="+branch;
    		 }
    	 }
    	System.out.println(sqltest);
    	Statement stmtVeh7 = conn.createStatement ();
				String str1Sql="select "+allbranch+" allbranch,r.voc_no voucherno,agmt.voc_no,r.agmtno,r.doc_no,r.fleet_no,v.reg_no,a.RefName,a.per_mob,agmt.mrano from gl_ragmtclosem r left join gl_ragmt agmt on r.agmtno=agmt.doc_no "+
						" left join gl_vehmaster v on v.fleet_no=r.fleet_no left join my_acbook a on (a.cldocno= r.cldocno and a.dtype='CRM') where 1=1 "+sqltest+" group by r.doc_no";
				//System.out.println("=========="+str1Sql);
				ResultSet resultSet = stmtVeh7.executeQuery (str1Sql);
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
		conn.close();
        return RESULTDATA;
    }
    
  //Method for Search Details - Grid Ends Here
    
    
    
    
    //Method for Reload Calculation Grid Details Starts Here
	public   JSONArray getCalcData_view(String agmtno) throws SQLException {
		 Connection conn=null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase(null)){
				agmtno="0";
			}
				if(!(agmtno.equalsIgnoreCase("0"))){
					Statement stmtcalc = conn.createStatement();		
				
	/*        	String strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
						" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote"+
						" from gl_invmode m left join"+
						" (select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
						" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
						" gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 group by idno"+
						" union all"+
						" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
						" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
						" gl_rcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0"+
						" union all"+
						" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
						" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
						" gl_rcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";
	        	
	        	
	        	*/
					
					Statement stmtclosecal=conn.createStatement();
					//Determining closecal in gl_config;if 1=>Start Date taken as Invoice Date,Otherwise 0=>Start Date taken as Agreement Out Date 
					String strclosecal="select method from gl_config where field_nme='closecal'";
					int closecal=0;
					ResultSet rsclosecal=stmtclosecal.executeQuery(strclosecal);
					while(rsclosecal.next()){
						closecal=rsclosecal.getInt("method");
					}
					
					String stradv="select (select advchk from gl_ragmt where doc_no="+agmtno+") advchk,"+
					" (select count(*) from gl_invm where rano="+agmtno+" and ratype='RAG' and manual=2) advcount,"+
					" (select rentaltype from gl_rtarif where rdocno="+agmtno+" and rstatus=5) createtype,"+
					" (select rentaltype from gl_ragmtclosed where rdocno="+agmtno+" and rentaltype not in ('Discount','Net Total')) closetype";
					int advchk=0,advcount=0;
					String createtype="",closetype="";
					ResultSet rsadv=stmtclosecal.executeQuery(stradv);
					while(rsadv.next()){
						advchk=rsadv.getInt("advchk");
						advcount=rsadv.getInt("advcount");
						createtype=rsadv.getString("createtype");
						closetype=rsadv.getString("closetype");
					}
					if(advchk==1 && advcount==1 && (!(createtype.equalsIgnoreCase(closetype)))){
						closecal=0;
					}
					
					stmtclosecal.close();
					String strSql="";
					//If closecal in gl_config is zero ie;Start Date is taken as Agreement Out Date
					if(closecal==0){
						strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
								" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote from gl_invmode m left join"+
								" (select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
								" gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 group by idno"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
								" gl_rcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
								" gl_rcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";	
					}
					//If closecal in gl_config is zero ie;Start Date is taken as Invoice Date
					else if(closecal==1){
					
					/*	strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoice,if((r.total-r.invoiced)>0,"+
								" (r.total-r.invoiced),0) invoiced,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote"+
								" from gl_invmode m left join"+
								" (select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,"+
								" if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
								" gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1 group by idno"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
								" gl_rcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from"+
								" gl_rcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1 ) r on(m.idno=r.idno) where r.idno is not null";
					*/
					
						strSql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,0 invoice,r.creditnote from gl_invmode m left join "+
								" (select r.idno,r.qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,"+
								" 0 invoice,sum(cnote) creditnote from gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+"  and afterclose=0 and"+
								" rowno>=(select min(rowno) from gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1)"+
								" group by idno"+

								" union all select r.idno,r.qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,"+
								" 0 invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_rcalc r where r.idno in(8,14) and "+
								" rdocno="+agmtno+" and afterclose=0  and rowno>=(select min(rowno) from gl_rcalc r where r.idno not in(8,14) and rdocno="+agmtno+" and afterclose=0 "+
								" and calcstatus=1) "+
								" union all select r.idno,r.qty,coalesce(sum(amount),0) total,"+
								" sum(invoiced) invoiced,0 invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote from gl_rcalc r "+
								" where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and rowno>=(select min(rowno) from gl_rcalc r where r.idno not in(9,15) "+
								" and rdocno="+agmtno+" and afterclose=0 and calcstatus=1) ) r on(m.idno=r.idno) where r.idno is not null";
					}
					
					//System.out.println("================= "+strSql);
				ResultSet rstotalview = stmtcalc.executeQuery(strSql);
				 if(rstotalview!=null) {
					 RESULTDATA=objcommon.convertToJSON(rstotalview);
					 
				 }
				 stmtcalc.close();
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
	  //Method for Reload Calculation Grid Details Ends Here
	
	
	
	//Method to load Reference tarif ie;Tarif Rates other than selected tarif in agreement starts here
	public   JSONArray getReferenceTarif(String agmtno) throws SQLException {
		Connection conn=null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase(null)){
				agmtno="0";
			}
			if(!(agmtno.equalsIgnoreCase("0"))){
			Statement stmtRef = conn.createStatement();
	        	String strSql="select rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg from gl_rtarif where "+
	        	" rdocno="+agmtno+" and rstatus not in(5,6,7) and rentaltype<>(select rentaltype from gl_rtarif where rdocno="+agmtno+" and rstatus=5) order by rstatus";
	        	//System.out.println(strSql);
				ResultSet rsRef = stmtRef.executeQuery(strSql);
//				System.out.println("========="+stmtRef);
				 if(rsRef!=null) {
					 RESULTDATA=objcommon.convertToJSON(rsRef);
				 }
				 stmtRef.close();
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
	
	
	//Method to load Reference tarif ie;Tarif Rates other than selected tarif in agreement ends here

	
	//Method to reload Total Grid ie;Final Selected Tarif Details starts here
	public   JSONArray getTotalData_view(String agmtno) throws SQLException {
		 Connection conn=null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase(null)){
				agmtno="0";
			}
			if(!(agmtno.equalsIgnoreCase("0"))){
					Statement stmtTotal2 = conn.createStatement();
					String strSql="select rentaltype,rate ,cdw,pai,cdw1 ,pai1 ,gps,babyseater,cooler,exkmrte ,exhrchg,chaufchg  from gl_ragmtclosed where status<>7 and rdocno="+agmtno;
//	        	System.out.println(strSql);
				ResultSet rstotal2 = stmtTotal2.executeQuery(strSql);
				 if(rstotal2!=null) {
					 RESULTDATA=objcommon.convertToJSON(rstotal2);
					 
				 }
				 stmtTotal2.close();
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
	
	
	//Method to reload Total Grid ie;Final Selected Tarif Details starts here
	
	
	
	
	/*public   JSONArray getAgmtno(String docno,String fleet,String regno,String client,String date,String mobile) throws SQLException {
	    List<ClsRentalCloseBean> rentalclosebean = new ArrayList<ClsRentalCloseBean>();
		//java.sql.Date sqlStartDate = objcommon.changeStringtoSqlDate(date);
		//System.out.println("Date"+sqlStartDate);
		Connection conn =null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest="";
			//System.out.println();
			if(!(docno.equalsIgnoreCase("0"))){
				sqltest=" and m1.doc_no="+docno;
			}
			if(!(fleet.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m1.fleet_no like '%"+fleet+"%'";
			}
			if(!(regno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m2.reg_no like '%"+regno+"%'";
			}
			if(!(client.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m3.refname like '%"+client+"%'";
			}
			if(!(mobile.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m3.per_mob like '%"+mobile+"%'";
			}
			java.sql.Date sqlsearchdate=null;
			if(!(date.equalsIgnoreCase(""))){
				sqlsearchdate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqlsearchdate!=null){
				sqltest=sqltest+" and m1.date='"+sqlsearchdate+"'";
			}
//			System.out.println("Default SqlTest:"+sqltest);
			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			JSONArray jsonArray = new JSONArray();
			 String strSql = "select coalesce(m1.desc1,' ') desc1,coalesce(round(if(m1.delstatus=1,m1.delchg,0),0),0) deliverychg,m3.acno,m2.fueltype,mov.dout,m1.doc_no,m1.date,m1.fleet_no,"+
			 			" m1.otime,m1.okm,br.branchname,m2.flname,m2.reg_no,c1.color,g1.gid,m3.cldocno,m3.refname,m3.address,m3.mail1,m3.per_mob,m1.delstatus,m1.okm"+
			 			" from gl_ragmt m1 left join gl_vehmaster m2 on m1.fleet_no=m2.fleet_no left join"+
			 			" my_color c1 on m2.clrid=c1.doc_no left join gl_vehgroup g1 on m2.vgrpid=g1.doc_no left join my_acbook m3 on"+
			 			" m1.cldocno=m3.cldocno and m3.dtype='CRM' left join my_brch br on m1.brhid=br.doc_no left join gl_vmove mov on "+
			 			"(mov.rdtype='RAG' and mov.rdocno=m1.doc_no )where m1.clstatus=0 "+sqltest+" group by m1.doc_no";
			String strSql="select coalesce(m1.desc1,' ') desc1,coalesce(round(if(m1.delstatus=1,m1.delchg,0),0),0) deliverychg,m3.acno,m2.fueltype,M1.OdATE,"+
" m1.doc_no,m1.date,m1.fleet_no,m1.otime,m1.okm,br.branchname,m2.flname,m2.reg_no,c1.color,g1.gid,m3.cldocno,m3.refname,m3.address,"+
" m3.mail1,m3.per_mob,m1.delstatus,m1.okm from gl_ragmt m1 left join gl_vehmaster m2 on m1.fleet_no=m2.fleet_no left join"+
" my_color c1 on m2.clrid=c1.doc_no left join gl_vehgroup g1 on m2.vgrpid=g1.doc_no left join my_acbook m3 on"+
" m1.cldocno=m3.cldocno and m3.dtype='CRM' left join my_brch br on m1.brhid=br.doc_no  where m1.clstatus=0 AND M2.TRAN_CODE!='CU'";	
//			 System.out.println("CHECKING SQL"+strSql);
				ResultSet resultSet = stmt.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
				System.out.println("RESULTDATA=========>"+RESULTDATA);
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
		
		

	}*/
	
	
	//Method to select Agreement while Closing starts here
	
	public JSONArray getAgmtno(String docno,String fleet,String regno,String client,String date,String mobile,String branch) throws SQLException {
		//java.sql.Date sqlStartDate = objcommon.changeStringtoSqlDate(date);
		//System.out.println("Date"+sqlStartDate);
		Connection conn =null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest="";
			//System.out.println();
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=" and m1.voc_no="+docno;
			}
			if(!(fleet.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m1.fleet_no like '%"+fleet+"%'";
			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m2.reg_no like '%"+regno+"%'";
			}
			if(!(client.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m3.refname like '%"+client+"%'";
			}
			if(!(mobile.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m3.per_mob like '%"+mobile+"%'";
			}
			java.sql.Date sqlsearchdate=null;
			if(!(date.equalsIgnoreCase(""))){
				sqlsearchdate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqlsearchdate!=null){
				sqltest=sqltest+" and m1.date='"+sqlsearchdate+"'";
			}
//			System.out.println("Default SqlTest:"+sqltest);
			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			 String strSql = "select coalesce(m1.orgregcard,0) orgregcard,plate.code_name platecode,m1.voc_no,coalesce(m1.desc1,' ') desc1,coalesce(round(if(m1.delstatus=1,m1.delchg,0),0),0) deliverychg,m3.acno,m2.fueltype,m1.odate,"+
					 	" m1.doc_no,m1.date,m1.fleet_no, m1.otime,m1.okm,br.branchname,m2.flname,m2.reg_no,c1.color,g1.gid,m3.cldocno,m3.refname,m3.address,"+
					 	" m3.mail1,m3.per_mob,m1.delstatus,m1.okm from gl_ragmt m1 left join gl_vehmaster m2 on m1.fleet_no=m2.fleet_no left join my_color c1"+
					 	" on m2.clrid=c1.doc_no left join gl_vehgroup g1 on m2.vgrpid=g1.doc_no left join gl_vehplate plate on m2.pltid=plate.doc_no left join my_acbook m3 on m1.cldocno=m3.cldocno and"+
					 	" m3.dtype='CRM' left join my_brch br on m1.brhid=br.doc_no where m1.clstatus=0 and m2.tran_code<>'CU' and m1.status=3 and m1.brhid="+branch+" "+sqltest+" order by m1.doc_no";
//			System.out.println("Agmt Search Query:"+strSql);	
			 ResultSet resultSet = stmt.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
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
	
	
	//Method to select Agreement while Closing Ends here
	
	
	
	//Method to Reload Traffic Details Corresponding to Agreement starts here
	
	public   JSONArray getTrafficdata(String agmtno) throws SQLException {
	  
	    JSONArray TRAFFICDATA=new JSONArray();
	   Connection conn =null;
	  
		try {
			conn=objconn.getMyConnection();
				//agmtno=agmtno==null?"0":agmtno;
			if(agmtno.equalsIgnoreCase(null)||agmtno.equalsIgnoreCase("")){
				agmtno="0";
			}
			//System.out.println("Agmtno in traffic:"+agmtno);
			if(!(agmtno.equalsIgnoreCase("0"))){
				Statement stmtStatement = conn.createStatement();
				String strSql="select regno,ticket_no,time,traffic_date,fleetno,amount,inv_no,trim(desc1) desc1 from gl_traffic where ra_no="+agmtno+" and rtype in('RA','RD','RW','RF','RM')";
	      //  System.out.println("Traffic Query"+strSql);
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

	//Method to Reload Traffic Details Corresponding to Agreement starts here
	
	//Method to get Details of Driver for Collection starts here
	
	public   JSONArray getCollect() throws SQLException {
	  
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmtCollect = conn.createStatement();
				//agmtno=agmtno==null?"0":agmtno;
	        	String strSql="select doc_no,sal_name,lic_no,lic_exp_dt from my_salesman where sal_type='DRV' and status<>7";
	        	//System.out.println(strSql);
				ResultSet resultSet = stmtCollect.executeQuery(strSql);
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
		
		
	    return RESULTDATA;
	    
	}
	//Method to get Details of Driver for Collection ends here
	
	
	
	//Method to get  Details of Checkin starts here
	public   JSONArray getCheckIn() throws SQLException {	  
	    JSONArray CheckData=new JSONArray();
	   Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmtCheck = conn.createStatement();
				//agmtno=agmtno==null?"0":agmtno;
	        	String strSql="select doc_no,sal_name from my_salesman where sal_type='CHK' and status<>7";
	        	//System.out.println(strSql);
				ResultSet rscheckin = stmtCheck.executeQuery(strSql);
				CheckData=objcommon.convertToJSON(rscheckin);
				stmtCheck.close();
				conn.close();
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
	//Method to get  Details of Checkin ends here
	
	
	//Method to get  Details of Rental Agent starts here

	public   JSONArray getRentalAgent() throws SQLException {
	  
	    JSONArray RentalData=new JSONArray();
	    Connection conn =null;
		
		try {
			conn=objconn.getMyConnection();
			Statement stmtrental=conn.createStatement();
				//agmtno=agmtno==null?"0":agmtno;
	        	String strrental="select doc_no,sal_name from my_salesman where sal_type='RLA' and status<>7";
	        	//System.out.println(strSql);
				ResultSet rsrental = stmtrental.executeQuery(strrental);
				RentalData=objcommon.convertToJSON(rsrental);
				stmtrental.close();
				conn.close();
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
	
	//Method to get  Details of Rental Agent Ends here
	
	
	//Method to get Agreement Tarif Data as selected in agreement Creation starts here
	
	public   JSONArray getAgmtTarifData(String agmtno) throws SQLException {
		Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			 conn=objconn.getMyConnection();
			 Statement stmtagmt = conn.createStatement();
	        	String strSql="select rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest ,exkmrte ,oinschg ,exhrchg,chaufchg ,"
	        			+ "chaufexchg  from gl_rtarif where rdocno='"+agmtno+"' and rstatus in(5,6,7) group by rstatus";
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
	
	//Method to get Agreement Tarif Data as selected in agreement Creation ends here
	
	
	//Method to Calculate Final Tarif Details
	
	public   JSONArray getTotalData(String useddays,String usedhours,String totalkm,String agmtno,String rentaltype,
			String agmtdate,String closedate,String closecalflag,java.sql.Date closeinvdate,String temp) throws SQLException,NullPointerException {
		
	    JSONArray RESULTDATA=new JSONArray();
if(!temp.equalsIgnoreCase("1")){
	    	//System.out.println("Inside: "+temp);
	    	return RESULTDATA;
	    }
		Connection conn=null;
	    try{
		conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select weekend from gl_ragmt where doc_no="+agmtno+"");
			int weekend=0;
			while(rs.next()){
				weekend=rs.getInt("weekend");
			}
			
			stmt.close();
			conn.close();
		    	if(weekend==1){
		    		conn=objconn.getMyConnection();
		    		Statement stmtday=conn.createStatement();
		    		java.sql.Date sqlagmtdate=null;
		    		java.sql.Date sqlclosedate=null;
		    		String stragmtdate="";//Agreement Date
		    		String strclosedate="";//Close Date
		    		String startday="";//Tarif Start Date
		    		String endday="";//Tarif End Date
		    		int daysdiff=0;
		    		int gpw=0;
		    		String calctype="";
		    		double gpwvalue=0.0;
		    		String endtime="";
		    		
		    		//COnverting agreement & closedate int sqlformat
		    		if(!(agmtdate.equalsIgnoreCase("") && agmtdate.equalsIgnoreCase("0"))){
		    			sqlagmtdate=objcommon.changeStringtoSqlDate(agmtdate);
		    		}
		    		if(!(closedate.equalsIgnoreCase("") && closedate.equalsIgnoreCase("0"))){
		    			sqlclosedate=objcommon.changeStringtoSqlDate(closedate);
		    		}
		    		
		    		String strday="select (select method from gl_config where field_nme='gpw') gpw,(select value from gl_config where field_nme='gpw') "+
		    				" gpwvalue,dayname('"+sqlagmtdate+"') agmtdate,dayname('"+sqlclosedate+"') closedate ,st_day startday,ed_day endday,"+
		    				" datediff('"+sqlclosedate+"','"+sqlagmtdate+"') datedif,ed_time endtime from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
		    		ResultSet rsday=stmtday.executeQuery(strday);
		    		while(rsday.next()){
		    			stragmtdate=rsday.getString("agmtdate");
		    			strclosedate=rsday.getString("closedate");
		    			startday=rsday.getString("startday");
		    			endday=rsday.getString("endday");
		    			daysdiff=rsday.getInt("datedif");
		    			gpw=rsday.getInt("gpw");
		    			gpwvalue=rsday.getDouble("gpwvalue");
		    			endtime=rsday.getString("endtime");
		    		}
		    		
		    		double drate=0.0,dcdw=0.0,dpai=0.0,dcdw1=0.0,dpai1=0.0,dgps=0.0,dbabyseater=0.0,dcooler=0.0,dkmrest=0.0,dexhrchg=0.0,dexkmrte=0.0,dchaufchg=0.0;
		    		String strdefault="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg"+
		    				" from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
		    		//System.out.println("Default Query:"+strdefault);
		    		ResultSet rsdefault=stmtday.executeQuery(strdefault);
		    		while(rsdefault.next()){
		    			drate=rsdefault.getDouble("rate");
		    			dcdw=rsdefault.getDouble("cdw");
		    			dpai=rsdefault.getDouble("pai");
		    			dcdw1=rsdefault.getDouble("cdw1");
		    			dpai1=rsdefault.getDouble("pai1");
		    			dgps=rsdefault.getDouble("gps");
		    			dbabyseater=rsdefault.getDouble("babyseater");
		    			dcooler=rsdefault.getDouble("cooler");
		    			dexhrchg=rsdefault.getDouble("exhrchg");
		    			dexkmrte=rsdefault.getDouble("exkmrte");
		    			dchaufchg=rsdefault.getDouble("chaufchg");
		    		}
		    		java.sql.Date enddate=null;
		    		int exdaydiff=0;
		    		
		    		String sqltest="";
		    		int startno=0;
	    			int endno=0;
	    			String straddweek="";
	    			String getweek="select (select doc_no from gl_weekdays where weekday='"+startday+"') startno,(select doc_no from gl_weekdays where weekday='"+endday+"') endno";
	    			ResultSet rsweek=stmtday.executeQuery(getweek);
	    			while(rsweek.next()){
	    				startno=rsweek.getInt("startno");
	    				endno=rsweek.getInt("endno");
	    			}
	    			String test="";
    				if(startno>endno){
    					test="+1";
    				}
    				/*ResultSet rscheck=stmtday.executeQuery("select startdate-enddate tarifdiff from (select"+
    						" (select doc_no from gl_weekdays where weekday='"+startday+"')startdate,"+
    						" (select doc_no from gl_weekdays where weekday='"+endday+"')enddate)a");
    				System.out.println("select startdate-enddate tarifdiff from (select"+
    						" (select doc_no from gl_weekdays where weekday='"+startday+"')startdate,"+
    						" (select doc_no from gl_weekdays where weekday='"+endday+"')enddate)a");
    				int tarifdiff=0;
    				while(rscheck.next()){
    					tarifdiff=rscheck.getInt("tarifdiff");
    				}*/
    				
    				int tarifdiff=0;
    				tarifdiff=startno-endno;
		    		if(stragmtdate.equalsIgnoreCase(startday) && strclosedate.equalsIgnoreCase(endday) && daysdiff<=7){
		    		//Returning the default tarif
//		    			System.out.println("Inside Default");
		    			sqltest=" and rstatus=7";
		    		}
		    		else if(stragmtdate.equalsIgnoreCase(startday) && !strclosedate.equalsIgnoreCase(endday) && daysdiff<=7){
		    		//Gets the correct tarif which meets the agmtdate and closedate
//		    			System.out.println("Pick Other Tarif");
		    			String strgetothertarif="select rstatus,rentaltype from gl_rtarif where rdocno="+agmtno+" and rstatus in (1,2,3,4) and st_day='"+stragmtdate+"' and ed_day='"+strclosedate+"'";
		    			ResultSet rsother=stmtday.executeQuery(strgetothertarif);
		    			boolean check=false;
		    			while(rsother.next()){
		    				check=true;
		    				sqltest=" and rstatus="+rsother.getInt("rstatus")+"";
		    				rentaltype=rsother.getString("rentaltype");
		    			}
		    			if(check==false){
		    				
//		    				System.out.println("Inside False");
			    			String strgetend="select datediff('"+sqlclosedate+"',enddate) exday,enddate from ("+
			    					" select STR_TO_DATE(concat(year('"+sqlagmtdate+"'),week('"+sqlagmtdate+"'),'"+endday+"'), '%X%V %W') enddate)a";
//			    			System.out.println("Day Diff Query:"+strgetend);
			    			ResultSet rsend=stmtday.executeQuery(strgetend);
			    			while(rsend.next()){
			    				enddate=rsend.getDate("enddate");
			    				exdaydiff=rsend.getInt("exday");
			    			}
			    			sqltest=" and rstatus=7";

			    				
			    			/*if(daysdiff<=tarifdiff){
			    				exdaydiff=0;
			    			}*/
		    			}
		    		}
		    		else{
		    			//Gets the difference between tarif end day and agmt Close day
		    			
		    			
		    			if(startno>endno){
		    				straddweek="+1";
		    			}
		    			String strgetend="select datediff('"+sqlclosedate+"',enddate) exday,enddate from ("+
		    					" select STR_TO_DATE(concat(year('"+sqlagmtdate+"'),week('"+sqlagmtdate+"')"+straddweek+",'"+endday+"'), '%X%V %W') enddate)a";
//		    			System.out.println("Day Diff Query:"+strgetend);
		    			ResultSet rsend=stmtday.executeQuery(strgetend);
		    			while(rsend.next()){
		    				enddate=rsend.getDate("enddate");
		    				exdaydiff=rsend.getInt("exday");
		    			}
		    			sqltest=" and rstatus=7";
		    			
		    		}
		    		
		    		//Final Query
		    		//Extra day charge is mapped to extra hour charge
		    		/*String strtarif="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,if("+exdaydiff+">0,exhrchg*"+exdaydiff+",0) exhrchg,"+
		    		//If extra day then extraday charge+extraday charge*extra day
		    		
		    		" chaufchg,chaufexchg,st_day startday,ed_day enday from gl_rtarif where rdocno="+agmtno+" "+sqltest;*/
		    		
		    		double hours=Double.parseDouble(usedhours);
		    		if(daysdiff<=tarifdiff){
	    				exdaydiff=0;
	    			}
		    		if(gpw==1 && hours>gpwvalue){
		    			exdaydiff=exdaydiff+1;
		    		}
//		    		System.out.println("Hours:"+hours);
//		    		System.out.println("Gpw:"+gpw);
//		    		System.out.println("Gpwvalue:"+gpwvalue);
//		    		System.out.println("Exdaydiff:"+exdaydiff);
//		    		System.out.println("Agmtdiff:"+daysdiff);
//		    		System.out.println("Tarifdiff"+tarifdiff);
		    		
		    		
		    		String strgetfinal="select '"+rentaltype+"' rentaltype,if("+drate+">0,round(rate,0),0) rate,if("+dcdw+">0,round(cdw,0),0) cdw,"+
		    		" if("+dpai+">0,round(pai,0),0) pai, if("+dcdw1+">0,round(cdw1,0),0) cdw1,if("+dpai1+">0,round(pai1,0),0) pai1,if("+dgps+">0,round(gps,0),0) gps,"+
		    		" if("+dbabyseater+">0,round(babyseater,0),0) babyseater, if("+dcooler+">0,round(cooler,0),0) cooler,if("+dchaufchg+">0,round(chaufchg,0),0) chaufchg,"+
		    		" if("+dexhrchg+">0,if("+exdaydiff+">0 and "+gpw+"=1 ,exhrchg*"+exdaydiff+",0),0) exhrchg,round(if("+dexkmrte+">0,("+totalkm+"-kmrest)*exkmrte,0),2) "+
		    		" exkmrte,round("+totalkm+"-kmrest,2) excesskm,"+
		    		" '"+calctype+"' calctype,if("+exdaydiff+">0 and "+gpw+"=1,"+exdaydiff+",0) finalhours from gl_rtarif where rdocno="+agmtno+sqltest+" union "+
		    		" select 'Discount' rentaltype,0.00 rate,0.00 cdw,0.00 pai, 0.00 cdw1,0.00 pai1,0.00 gps,0.00 babyseater,0.00 cooler,0.00 chaufchg,0.00 exhrchg,0.00 "+
		    		" exkmrte,0 excesskm,'"+calctype+"' calctype,0.0 finalhours from gl_rtarif where rdocno="+agmtno+sqltest+" union "+
		    		" select 'Net Total' rentaltype,if("+drate+">0,round(rate,0),0) rate,if("+dcdw+">0,round(cdw,0),0) cdw,if("+dpai+">0,round(pai,0),0) pai,"+
		    		" if("+dcdw1+">0,round(cdw1,0),0) cdw1,if("+dpai1+">0,round(pai1,0),0) pai1,if("+dgps+">0,round(gps,0),0) gps,if("+dbabyseater+">0,"+
		    		" round(babyseater,0),0) babyseater,if("+dcooler+">0,round(cooler,0),0) cooler,if("+dchaufchg+">0,round(chaufchg,0),0) chaufchg,"+
		    		" if("+dexhrchg+">0,if("+exdaydiff+">0 and "+gpw+"=1,exhrchg*"+exdaydiff+",0),0),round(if("+dexkmrte+">0,("+totalkm+"-kmrest)*exkmrte,0),2) exkmrte,"+
		    		" round("+totalkm+"-kmrest,2) excesskm,'"+calctype+"' calctype,if("+exdaydiff+">0 and "+gpw+"=1,"+exdaydiff+",0) finalhours from gl_rtarif where rdocno="+agmtno+sqltest;
		    		System.out.println("Final Weekend Query: "+strgetfinal);
		    		ResultSet rsfinal=stmtday.executeQuery(strgetfinal);
		    		RESULTDATA=objcommon.convertToJSON(rsfinal);
		    		stmtday.close();
		    		conn.close();
		    		return RESULTDATA;
		    		
		    	
		    	}
		
		
	    	conn=objconn.getMyConnection();
			Statement stmtrentaltype=conn.createStatement();
	    	String defaulttarif=rentaltype;
			String excesskm="0";
			int tempconv=0;
			int invtype=0;
			String strinvtype="";
			Statement stmtinvtype=conn.createStatement();
			ResultSet rsinvtype=stmtinvtype.executeQuery("select invtype from gl_ragmt where doc_no="+agmtno);
			while(rsinvtype.next()){
				invtype=rsinvtype.getInt("invtype");
			}
			
			
		double dailyrate=0.0,weeklyrate=0.0,fortnightrate=0.0,monthlyrate=0.0,netrate=0.0;
		
		//Query for getting default rates of all tarifs Starts here
		
			String strrentaltype="select (select rate from gl_rtarif where rdocno="+agmtno+" and rstatus=1)dailyrate,"+
				" (select rate  from gl_rtarif where rdocno="+agmtno+" and rstatus=2)weeklyrate,"+
				// " (select rate  from gl_rtarif where rdocno="+agmtno+" and rstatus=3)fortnightrate,"+
				" (select rate  from gl_rtarif where rdocno="+agmtno+" and rstatus=3)monthlyrate,(select rate from gl_rtarif where rdocno="+agmtno+" and rstatus=7) netrate";
			ResultSet rsrentaltype=stmtrentaltype.executeQuery(strrentaltype);
	
			while(rsrentaltype.next()){
				dailyrate=rsrentaltype.getDouble("dailyrate");
				weeklyrate=rsrentaltype.getDouble("weeklyrate");
				netrate=rsrentaltype.getDouble("netrate");
				//fortnightrate=rsrentaltype.getDouble("fortnightrate");
				monthlyrate=rsrentaltype.getDouble("monthlyrate");
			}
			stmtrentaltype.close();
		if(rentaltype.equalsIgnoreCase("Daily")){
			dailyrate=netrate;
		}
		else if(rentaltype.equalsIgnoreCase("Weekly")){
			weeklyrate=netrate;
		}
		else if(rentaltype.equalsIgnoreCase("Monthly")){
			monthlyrate=netrate;
		}
		//Query for getting default rates of all tarifs Starts here
	
		//Query for getting monthcalvalue from gl_config starts here
		Statement stmtmonthcal=conn.createStatement();
	int monthcalvalue=0;
	int monthcalmethod=0;
	double takenvalue=0.0;
	String selectedtarif="";
	String strmonthcal2="select method,value from gl_config where field_nme='monthlycal'";
	ResultSet rsmonthcal2=stmtmonthcal.executeQuery(strmonthcal2);
	while(rsmonthcal2.next()){
		monthcalmethod=rsmonthcal2.getInt("method");
		monthcalvalue=rsmonthcal2.getInt("value");
	}
	String strgetmonthcal="";
	
	if(monthcalmethod==1){
		strgetmonthcal="SELECT DAY(LAST_DAY('"+agmtdate+"')) monthdays";
		ResultSet rsgetmonthcal=stmtmonthcal.executeQuery(strgetmonthcal);
		while(rsgetmonthcal.next()){
		monthcalvalue=rsgetmonthcal.getInt("monthdays");
		}
	}
	//stmtmonthcal.close();
	//Query for getting monthcalvalue from gl_config starts here
	
	//Calculation for Grace Period Starts here
	
	String calctype="";
	double freehours=0.0;
	double days=0.0,hours=0.0;
	/*double hoursdec=Double.parseDouble(usedhours.split(".")[1]);*/
	days=Double.parseDouble(useddays==""?"0":useddays);
	hours=Double.parseDouble(usedhours==""?"0":usedhours);
	
	Statement stmtTarif = conn.createStatement();
	String strconfig="select (case when "+hours+"<=(select value from gl_config where field_nme='gp') then 'nothing' when "+hours+" <(select value from gl_config"+
			" where field_nme='gph') then 'hourly' when "+hours+"<(select value from gl_config where field_nme='gpd') then 'halfday'"+
			" else 'fullday' end )calc,value from gl_config where field_nme='gp'";
//System.out.println("Grace Query:"+strconfig);
	
	
	ResultSet rsconfig=stmtTarif.executeQuery(strconfig);

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




double cal=0.0;
double finalhours=0.0;
double hrchg=0.0;
//hours=Math.round(hours);

String temptime[]=usedhours.replace(".",":").split(":");
int temphours=Integer.parseInt(temptime[0]);
int tempminutes=Integer.parseInt(temptime[1]);
if(calctype.equalsIgnoreCase("hourly")){

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
// one days add if days is zero starts
ResultSet rsinvcount=stmtmonthcal.executeQuery("select count(*) invcount from gl_invm where rano="+agmtno+" and ratype='RAG' and status=3");
int invcount=0;
while(rsinvcount.next()){
	invcount=rsinvcount.getInt("invcount");
}
if(days==0 && hours>0 && invcount==0){
	days=days+1;
}

//one days add if days is zero ends
//useddays=useddays+cal;	
System.out.println("Calculated Grace Period Type: "+calctype+"     Cal: "+cal);
//Calculation for Grace Period Ends here
	

//Query for getting Convertion Method from gl_config
	int tconvmethod=0,closecal=0,delcal=0,delstatus=0;
	java.sql.Date odate=null;
	Statement stmttconv=conn.createStatement();
	String strtconv="select (select method from gl_config where field_nme='tconv')method,(select method from gl_config where field_nme='closecal')closecal,"
			+ "(select method from gl_config where field_nme='delcal')delcal,(select delstatus from gl_ragmt where doc_no="+agmtno+")delstatus,(select odate from gl_ragmt where doc_no="+agmtno+")odate";
	ResultSet rstconv=stmttconv.executeQuery(strtconv);
	while(rstconv.next()){
		tconvmethod=rstconv.getInt("method");
		closecal=rstconv.getInt("closecal");
		delcal=rstconv.getInt("delcal");
		delstatus=rstconv.getInt("delstatus");
		odate=rstconv.getDate("odate");
	}
	stmttconv.close();
	java.sql.Date tempdeldate=null;
	if(delcal==1 && delstatus==1){
		Statement stmtdelmov=conn.createStatement();
		String sqldelmov="select din from gl_vmove where repno=0 and trancode='DL' and rdtype='RAG' and rdocno="+agmtno;
		ResultSet rsdelmov=stmtdelmov.executeQuery(sqldelmov);
		while(rsdelmov.next()){
			tempdeldate=rsdelmov.getDate("din");
		}
	}
	tempdeldate=tempdeldate==null?odate:tempdeldate;
	/*'"+objcommon.changeStringtoSqlDate(agmtdate)+"'*/
/*"select if("+closecal+"=1 and "+closecalflag+"<>1 and invdate>if("+delcal+"=1 and "+delstatus+"=1,'"+tempdeldate+"',odate),1,0) conv from gl_ragmt where doc_no="+agmtno;*/
	
	
	
	java.sql.Date agmtdate1=null,closedate1=null;
	

	if(!((agmtdate.equalsIgnoreCase("0"))||(agmtdate.equalsIgnoreCase("")))){
		agmtdate1=objcommon.changeStringtoSqlDate(agmtdate);
	}
	if(!((closedate.equalsIgnoreCase("0"))||(closedate.equalsIgnoreCase("")))){
		closedate1=objcommon.changeStringtoSqlDate(closedate);
	}
	
	//Deciding last day
		java.sql.Date invfromdate=null;
		Statement stmtlastday=conn.createStatement();
		//System.out.println("select if("+days+"<0,DATE_SUB(invdate,interval 1 MONTH),invdate) invfromdate from gl_ragmt where doc_no="+agmtno);
		String strlastday="";
		if(invtype==1){
			strlastday="select '"+closedate1+"' invfromdate from gl_ragmt where doc_no="+agmtno;
		}
		else if(invtype==2){
			strlastday="select if("+days+"<0,DATE_SUB(invdate,interval 1 MONTH),invdate) invfromdate from gl_ragmt where doc_no="+agmtno;
		}
		else{
		strlastday="select '"+closedate1+"' invfromdate from gl_ragmt where doc_no="+agmtno;
		}
		ResultSet rslastday=stmtlastday.executeQuery(strlastday);
		while(rslastday.next()){
			invfromdate=rslastday.getDate("invfromdate");
		}
	/*String strcloseconv="select if("+closecal+"=1 and "+closecalflag+"<>1 and '"+closeinvdate+"'>'"+agmtdate1+"',1,0) conv";
//	System.out.println("Close Convertion Query: "+strcloseconv);
	Statement stmtcloseconv=conn.createStatement();
	ResultSet rscloseconv=stmtcloseconv.executeQuery(strcloseconv);
	int convconfig=0;
	while(rscloseconv.next()){
		convconfig=rscloseconv.getInt("conv");
	}
	stmtcloseconv.close();
	*/
	
	//Query for getting default selected tarif details as in agreement starts here
	Statement stmtdefault=conn.createStatement();
	double drate=0.0,dcdw=0.0,dpai=0.0,dcdw1=0.0,dpai1=0.0,dgps=0.0,dbabyseater=0.0,dcooler=0.0,dkmrest=0.0,dexhrchg=0.0,dexkmrte=0.0,dchaufchg=0.0;
	String strdefault="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg"+
			" from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
	//System.out.println("Default Query:"+strdefault);
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
		dexhrchg=rsdefault.getDouble("exhrchg");
		dexkmrte=rsdefault.getDouble("exkmrte");
		dchaufchg=rsdefault.getDouble("chaufchg");
	}
	stmtdefault.close();
	//System.out.println("Days:"+days);
	//Query for getting default selected tarif details as in agreement ends here
	
	
	
	//Query for determining if extra charges are calculated for cdw,pai,supercdw,superpai starts here
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

//Query for determining if extra charges are calculated for cdw,pai,supercdw,superpai ends here
	double rate=0.0,cdw=0.0,pai=0.0,cdw1=0.0,pai1=0.0,gps=0.0,babyseater=0.0,cooler=0.0,kmrest=0.0,exkmrte=0.0,oinschg=0.0,exhrchg=0.0,chaufchg=0.0,chaufexchg=0.0;
	String sqltest="";
//System.out.println("Check TempConv:"+tempconv);

	
	int rentalno=0;
	String strsql="";
	
	double day=0.0,month=0.0,year=0.0;
	int lastday=0;
	String strgetmonth="";
	String strmonthcal="";
	
	//Convertion Methodology Starts Here
	if(Integer.parseInt(closecalflag)==1){
		
	if(rentaltype.equalsIgnoreCase("Daily")){
		if(tconvmethod==1){
			if(days<=6){
						double value=dailyrate*days;
							if(value>weeklyrate){
									takenvalue=weeklyrate;
									rentaltype="Weekly";
									tempconv=0;
							}
							else{
									takenvalue=value;
									rentaltype="Daily";
									tempconv=1;
								}
					}
			else if(days>6 && days<monthcalvalue){
						double value=(weeklyrate/7)*days;
						if(value>monthlyrate){
							takenvalue=monthlyrate;
							rentaltype="Monthly";
							tempconv=0;
						}
						else{
							takenvalue=value;
							rentaltype="Weekly";
							tempconv=1;
						}
					}
			else if(days>=monthcalvalue){
						takenvalue=(monthlyrate/monthcalvalue)*days;
						rentaltype="Monthly";
						tempconv=1;		
			}
			}
		if(tconvmethod==0){
				takenvalue=dailyrate*days;
				rentaltype="Daily";
				tempconv=1;
			}
		}
			
		if(rentaltype.equalsIgnoreCase("Weekly")){
			if(tconvmethod==1){
				if(days>=monthcalvalue){
					
					double value=(monthlyrate/monthcalvalue)*days;
					takenvalue=value;
						rentaltype="Monthly";
						tempconv=1;
						System.out.println("Check:1");
				}
				else if(days>7 && days<monthcalvalue){
					
					double value=(weeklyrate/7)*days;
					System.out.println("Value:"+value);
					if(value>monthlyrate){
						takenvalue=monthlyrate;
						rentaltype="Monthly";
						tempconv=0;
						System.out.println("Check:2");
					}
					else{
						takenvalue=value;
						rentaltype="Weekly";
						tempconv=1;
						System.out.println("Check:3");
					}
				}	
			}
			
			if(days<7){
				double value=dailyrate*days;
				if(value>weeklyrate){
					takenvalue=weeklyrate;
					rentaltype="Weekly";
					tempconv=0;
					System.out.println("Check:4");
				}
				else{
					takenvalue=value;
					rentaltype="Daily";
					tempconv=1;
					System.out.println("Check:5");
				}
			}				
		}
			
		if(rentaltype.equalsIgnoreCase("Monthly")){
			// System.out.println("Check Used Days:"+useddays+" Monthly Rate:"+monthlyrate+" Daily Rate:"+dailyrate+" MonthcalValue:"+monthcalvalue);
			if(days>monthcalvalue){
				double value=(monthlyrate/monthcalvalue)*days;
						takenvalue=value;
						rentaltype="Monthly";
						tempconv=1;
			}
			else if(days>=7 && days<monthcalvalue){
				double value=(weeklyrate/7)*days;
				if(value>monthlyrate){
					takenvalue=monthlyrate;
					rentaltype="Monthly";
					tempconv=1;
				}
				else{
					takenvalue=value;
					rentaltype="Weekly";
					tempconv=1;
				}
			}
			else if(days<7){
				double value=dailyrate*days;
				if(value>weeklyrate){
					takenvalue=weeklyrate;
					rentaltype="Weekly";
					tempconv=0;
				}
				else{
					takenvalue=value;
					rentaltype="Daily";
					tempconv=1;
				}
			}
		}

		//Convertion Methododlgy Ends Here

	//Getting the No of days corresponding to Monthlycal 
	
	//System.out.println("Used Days"+useddays);
		
		
		
	if(defaulttarif.equalsIgnoreCase(rentaltype)){
		sqltest=" and rstatus=7";
			
		}
		else{
			sqltest=" and rentaltype='"+rentaltype+"'";
		}
	
		
	/*if(tconvmethod==1){
	rentaltyprentaltypeif;
	}*/

/*	String strmonthly="select (case when 1=(select method from gl_config where field_nme='monthlycal') then 'monthlycal' else (select value from"+
		" gl_config where field_nme='monthlycal') end )dayscalc,method from gl_config where field_nme='monthlycal'";
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
		
	}*/
	
	if(monthcalmethod==0){
		rentalno= monthcalvalue;
	}
	if(rentaltype.equalsIgnoreCase("daily")){
		rentalno=1;
	}
	if(rentaltype.equalsIgnoreCase("weekly")){
		rentalno=7;
	}
	if(rentaltype.equalsIgnoreCase("fortnightly")){
		rentalno=14;
	}
	
	
	//Override
	

//System.out.println("Cal Value:"+cal);
	
	if((rentaltype.equalsIgnoreCase("Daily"))||(rentaltype.equalsIgnoreCase("weekly"))||(rentaltype.equalsIgnoreCase("fortnightly"))||((monthcalmethod==0)&&(rentaltype.equalsIgnoreCase("monthly")))){
		cdwdays=days;
		paidays=days;
		cdw1days=days;
		pai1days=days;
			if(extracdw==0){
				cdwdays=cdwdays-cal;
				}
			if(extrapai==0){
				paidays=paidays-cal;
				}
			if(extracdw1==0){
				cdw1days=cdw1days-cal;
				}
			if(extrapai1==0){
				pai1days=pai1days-cal;
				}
		
		System.out.println("Days Cal:"+days  +"========="+ rentalno);
			//If Convertion=true ie;tconv in gl_config=1
		System.out.println("Cdwdays: "+cdwdays);
		if(tconvmethod==0){
			strsql="select "+(days/rentalno)+"*rate tarif,"+(cdwdays/rentalno)+"*cdw cdw,"+(paidays/rentalno)+"*pai pai,"+(cdw1days/rentalno)+"*cdw1 scdw,"+
					+(pai1days/rentalno)+"*pai1 spai,"+(days/rentalno)+"*gps gps,"+(days/rentalno)+"*babyseater babyseater,"+(days/rentalno)+"*cooler cooler,"+
					+(days/rentalno)+"*chaufchg chaufferchg,("+totalkm+"-("+(days/rentalno)+"*kmrest))*exkmrte exkmrte,("+totalkm+"-("+(days/rentalno)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
			System.out.println("Cheq 0==="+strsql);
		}
		 else if(tempconv==1){
		strsql="select "+(days/rentalno)+"*rate tarif,"+(cdwdays/rentalno)+"*cdw cdw,"+(paidays/rentalno)+"*pai pai,"+(cdw1days/rentalno)+"*cdw1 scdw,"+
				+(pai1days/rentalno)+"*pai1 spai,"+(days/rentalno)+"*gps gps,"+(days/rentalno)+"*babyseater babyseater,"+(days/rentalno)+"*cooler cooler,"+
				+(days/rentalno)+"*chaufchg chaufferchg,("+totalkm+"-("+(days/rentalno)+"*kmrest))*exkmrte exkmrte,("+totalkm+"-("+(days/rentalno)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
		System.out.println("Cheq 1==="+strsql);
		
		}
		//If Convertion=false ie;tconv in gl_config=0
		//If Convertion is false ie;do not convert
		else if(tempconv==0){
		/*strsql="select "+days+"*rate tarif,"+days+"*cdw cdw,"+days+"*pai pai,"+days+"*cdw1 scdw,"+days+"*pai1 spai,"+days+"*gps gps,"+days+"*babyseater babyseater,"+days+"*cooler cooler,"+days+"*chaufchg chaufferchg,("+totalkm+"-("+(days)+"*kmrest))*exkmrte exkmrte,"+
				"("+totalkm+"-("+(days)+"*kmrest)) excesskm from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";*/
			
			strsql="select rate tarif,cdw cdw,pai pai,cdw1 scdw,pai1 spai,gps gps,babyseater babyseater,cooler cooler,chaufchg chaufferchg,("+totalkm+"-("+(days/rentalno)+"*kmrest))*exkmrte exkmrte,"+
					"("+totalkm+"-("+(days/rentalno)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
					
		/*	strsql="select "+(days/rentalno)+"*rate tarif,"+(cdwdays/rentalno)+"*cdw cdw,"+(paidays/rentalno)+"*pai pai,"+(cdw1days/rentalno)+"*cdw1 scdw,"+
					+(pai1days/rentalno)+"*pai1 spai,"+(days/rentalno)+"*gps gps,"+(days/rentalno)+"*babyseater babyseater,"+(days/rentalno)+"*cooler cooler,"+
					+(days/rentalno)+"*chaufchg chaufferchg,("+totalkm+"-("+(days/rentalno)+"*kmrest))*exkmrte exkmrte,("+totalkm+"-("+(days/rentalno)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+"  and rstatus=7";
		*/
		}
		System.out.println("Normal Query: "+strsql);
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
    		//oinschg=rsnormal.getDouble("oinschg");
    		exhrchg=rsnormal.getDouble("exhrchg");
    		chaufchg=rsnormal.getDouble("chaufferchg");
    		
		}
	}
	
	// Calculating value based on monthcalvalue and rentaltype is Monthly
	
	
	if(monthcalmethod==1 &&(rentaltype.equalsIgnoreCase("Monthly"))){
		
		//if(tempconv==1){
//		System.out.println("check agmt dat in total:"+agmtdate1);
		strgetmonth="select a.months,DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+agmtdate1+"',INTERVAL a.months month) ) days from ("+
				" select if(day('"+agmtdate1+"')>day('"+closedate1+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )) months) a";
//		System.out.println("Months Duration Query: "+strgetmonth);
		//	}
		
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
		
		//if(invtype==1){
			
			
		//}
		/*else if(invtype==2){
			strinvtype="select day(last_day('"+invfromdate+"')) lastday";
		}
		else{
			strinvtype="select day(last_day('"+invfromdate+"')) lastday";
		}*/
		
		/**
		 * total applicable days taken should be from date months only
		 */
		strinvtype="select day(last_day('"+invfromdate+"')) lastday";
		ResultSet rscheck3=stmtinvtype.executeQuery(strinvtype);
		while(rscheck3.next()){
			lastday=rscheck3.getInt("lastday");
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
		
		//System.out.println("Days Cal:"+day);
		
		//Only if Convertion is true
		if(tempconv==1){
			
			//Query for Calculating duration of agreement
		strmonthcal="select (("+month+"*rate)+((coalesce("+day/lastday+",0))*rate)) tarif,(("+month+"*cdw)+((coalesce("+cdwdays/lastday+",0))*cdw)) cdw,"+
				"(("+month+"*pai)+((coalesce("+paidays/lastday+",0))*pai)) pai,(("+month+"*cdw1)+((coalesce("+cdw1days/lastday+",0))*cdw1)) scdw,"+
				"(("+month+"*pai1)+((coalesce("+pai1days/lastday+",0))*pai1)) spai,(("+month+"*gps)+((coalesce("+day/lastday+",0))*gps)) gps,"+
				"(("+month+"*babyseater)+((coalesce("+day/lastday+",0))*babyseater)) babyseater,(("+month+"*cooler)+((coalesce("+day/lastday+",0))*cooler)) cooler,"+
				"(("+month+"*chaufchg)+((coalesce("+day/lastday+",0))*chaufchg)) chaufferchg,("+totalkm+"-(("+month+"*kmrest)+((coalesce("+day/lastday+",0))*kmrest)))*exkmrte exkmrte,"+
				" ("+totalkm+"-(("+month+"*kmrest)+((coalesce("+day/lastday+",0))*kmrest))) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+
				"  "+sqltest+"";
		System.out.println("Month calculation query with tempconv1: "+strmonthcal);
	
		}
		//If Convertion is false
		else if(tempconv==0){
	
			strmonthcal="select rate tarif,cdw cdw,pai pai,cdw1 scdw,pai1 spai,gps gps,babyseater babyseater,cooler cooler,chaufchg chaufferchg,("+totalkm+"-("+(days)+"*kmrest))*exkmrte exkmrte,"+
						"("+totalkm+"-("+(days)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
			
		}
		System.out.println("Monthly Query with tempconv0"+strmonthcal);
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
    		exkmrte=rsmonthcal.getDouble("exkmrte");
    		excesskm=rsmonthcal.getDouble("excesskm")+"";
    		//oinschg=rsmonthcal.getDouble("oinschg");
    		exhrchg=rsmonthcal.getDouble("exhrchg");
    		chaufchg=rsmonthcal.getDouble("chaufferchg");
    		
		}
		rentalno=lastday;
	}
	}
	else if(Integer.parseInt(closecalflag)==0){	
				
		if(defaulttarif.equalsIgnoreCase(rentaltype)){
			sqltest=" and rstatus=7";
				
			}
			else{
				sqltest=" and rentaltype='"+rentaltype+"'";
			}
		if(monthcalmethod==0){
			if(rentaltype.equalsIgnoreCase("daily")){
				rentalno=1;
			}
			if(rentaltype.equalsIgnoreCase("weekly")){
				rentalno=7;
			}
			if(rentaltype.equalsIgnoreCase("fortnightly")){
				rentalno=14;
			}
			if(rentaltype.equalsIgnoreCase("Monthly")){
				rentalno=monthcalvalue;	
			}
			
			Statement checkmonth=conn.createStatement();
			strgetmonth="select a.months,DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+agmtdate1+"',INTERVAL a.months month) ) days from ("+
					" select if(day('"+agmtdate1+"')>day('"+closedate1+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
					" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
					" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )) months) a";
			ResultSet rscheckmonth=checkmonth.executeQuery(strgetmonth);
			while(rscheckmonth.next()){
				month=rscheckmonth.getDouble("months");
				day=rscheckmonth.getDouble("days");
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
				System.out.println("===== "+days+"======"+rentalno);
			strmonthcal="select "+(days/rentalno)+"*rate tarif,"+(cdwdays/rentalno)+"*cdw cdw,"+(paidays/rentalno)+"*pai pai,"+(cdw1days/rentalno)+"*cdw1 scdw,"+
					+(pai1days/rentalno)+"*pai1 spai,"+(days/rentalno)+"*gps gps,"+(days/rentalno)+"*babyseater babyseater,"+(days/rentalno)+"*cooler cooler,"+
					+(days/rentalno)+"*chaufchg chaufferchg,("+totalkm+"-(("+month+"*kmrest)+(("+day/rentalno+")*kmrest)))*exkmrte exkmrte,("+totalkm+"-(("+month+"*kmrest)+(("+day/rentalno+")*kmrest))) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
			System.out.println("cheq2 :"+strmonthcal);
		}
		else if(monthcalmethod==1){
		/*			
			strgetmonth="select a.months,DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+agmtdate1+"',INTERVAL a.months month) ) days from ("+
					" select if(day('"+agmtdate1+"')>day('"+closedate1+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
					" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
					" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )) months) a";*/
//			System.out.println("Closeinvdate:"+closeinvdate);
			if(closeinvdate!=null){
				strgetmonth="select DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+closeinvdate+"',INTERVAL 0 month) ) days,0 months";	
//				System.out.println("Month Query: "+strgetmonth);
				ResultSet rsgetmonth=stmtTarif.executeQuery(strgetmonth);
				while(rsgetmonth.next()){
					day=rsgetmonth.getDouble("days");
					month=rsgetmonth.getDouble("MONTHS");
					lastday=rsgetmonth.getInt("lastday");
				}
				
				if(invtype==1){
					strinvtype="select day(last_day('"+invfromdate+"')) lastday";
					
				}
				else if(invtype==2){
					strinvtype="select day(last_day('"+invfromdate+"')) lastday";
				}
				System.out.println("Last day query:"+strinvtype);
				ResultSet rscheck1=stmtinvtype.executeQuery(strinvtype);
				while(rscheck1.next()){
					lastday=rscheck1.getInt("lastday");
				}
			}
	
//			System.out.println("Here Months Duration Query: "+strgetmonth);
			//	}
			
			/*String strgetmonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday, DATEDIFF( '"+closedate+"',if(a.months>0,LAST_DAY(DATE_ADD( '"+agmtdate1+"',INTERVAL a.months month)),"+
					" DATE_ADD('"+agmtdate1+"',INTERVAL a.months month))) days from (select if(day('"+agmtdate1+"')>day('"+closedate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
					" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )) months) a";*/
//			System.out.println("Month Difference"+strgetmonth);
			
			
			String strgetexcesskmdur="select a.months,DAY(LAST_DAY('"+closedate1+"')) lastday, DATEDIFF( '"+closedate1+"', DATE_ADD('"+agmtdate1+"',INTERVAL a.months month) ) days from ("+
					" select if(day('"+agmtdate1+"')>day('"+closedate1+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
					" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate1+"' ),"+
					" EXTRACT( YEAR_MONTH FROM '"+agmtdate1+"' ) )) months) a";
			System.out.println("Excess Find Query: "+strgetexcesskmdur);
			double excessday=0.0,excessmonth=0.0;
			int excesslastday=0;
			Statement stmtexcesskmdur=conn.createStatement();
			ResultSet rsgetexcesskmdur=stmtexcesskmdur.executeQuery(strgetexcesskmdur);
			while(rsgetexcesskmdur.next()){
				excessday=rsgetexcesskmdur.getDouble("days");
				excessmonth=rsgetexcesskmdur.getDouble("MONTHS");
				excesslastday=rsgetexcesskmdur.getInt("lastday");
			}
			
			if(invtype==1){
				strinvtype="select day(last_day('"+invfromdate+"')) lastday";
				
			}
			else if(invtype==2){
				strinvtype="select day(last_day('"+invfromdate+"')) lastday";
			}
			ResultSet rscheck2=stmtinvtype.executeQuery(strinvtype);
			while(rscheck2.next()){
				excesslastday=rscheck2.getInt("lastday");
			}
//			System.out.println("///////////////////////"+day+"::"+lastday+"::"+closedate1);
			stmtexcesskmdur.close();
			java.sql.Date deldate=null;
			java.sql.Date agmtoutdate=null;
			java.sql.Date tempnocreditdate=null;
			Statement stmtdel=conn.createStatement();
			ResultSet rsdel=stmtdel.executeQuery("select (select mov.din from gl_vmove mov left join gl_ragmt agmt "+
			" on (mov.rdocno=agmt.doc_no and mov.rdtype='RAG') where mov.rdtype='RAG' and mov.rdocno="+agmtno+" and mov.trancode='DL' and mov.repno=0) din,(select odate from gl_ragmt where doc_no="+agmtno+") outdate ");
			while(rsdel.next()){
				deldate=rsdel.getDate("din");
				agmtoutdate=rsdel.getDate("outdate");
			}
			if(deldate!=null && delcal==0){
				tempnocreditdate=deldate;
			}
			else{
				tempnocreditdate=agmtoutdate;
			}
			
			String stradv="select (select advchk from gl_ragmt where doc_no="+agmtno+") advchk,"+
			" (select count(*) from gl_invm where rano="+agmtno+" and ratype='RAG' and manual=2) advinvcount,"+
			" (select day(last_day('"+tempnocreditdate+"'))) startdays";
			int advchk=0,advinvcount=0,startdays=0;
			ResultSet rsadv=stmtdel.executeQuery(stradv);
			while(rsadv.next()){
				advchk=rsadv.getInt("advchk");
				advinvcount=rsadv.getInt("advinvcount");
				startdays=rsadv.getInt("startdays");
			}
			long nocreditdiff=closedate1.getTime()-tempnocreditdate.getTime();
			long nocreditdatediff=nocreditdiff/(24*60*60*1000);
			if(nocreditdatediff<startdays && advchk==1 && advinvcount==1){
				//System.out.println("Inside no credit");
				day=0;
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
			excessday=excessday+cal;
			//System.out.println("Days: "+day+"           Cal: "+cal);
			if(rentaltype.equalsIgnoreCase("Monthly")){
				System.out.println("Days:::"+day+"::::::Lastday:::"+lastday);
			strmonthcal="select (("+month+"*rate)+((coalesce("+day/lastday+",0))*rate)) tarif,(("+month+"*cdw)+((coalesce("+cdwdays/lastday+",0))*cdw)) cdw,"+
					"(("+month+"*pai)+((coalesce("+paidays/lastday+",0))*pai)) pai,(("+month+"*cdw1)+((coalesce("+cdw1days/lastday+",0))*cdw1)) scdw,"+
					"(("+month+"*pai1)+((coalesce("+pai1days/lastday+",0))*pai1)) spai,(("+month+"*gps)+((coalesce("+day/lastday+",0))*gps)) gps,"+
					"(("+month+"*babyseater)+((coalesce("+day/lastday+",0))*babyseater)) babyseater,(("+month+"*cooler)+((coalesce("+day/lastday+",0))*cooler)) cooler,"+
					"(("+month+"*chaufchg)+((coalesce("+day/lastday+",0))*chaufchg)) chaufferchg,exhrchg from gl_rtarif where rdocno="+agmtno+" "+
					"  "+sqltest+"";
			
			System.out.println("Month calculation query: "+strmonthcal);
			
			Statement stmtexcesskm=conn.createStatement();
			String strexcesskm="select ("+totalkm+"-(("+excessmonth+"*kmrest)+((coalesce("+excessday/excesslastday+",0))*kmrest)))*exkmrte exkmrte,"+
					" ("+totalkm+"-(("+excessmonth+"*kmrest)+((coalesce("+excessday/excesslastday+",0))*kmrest))) excesskm from gl_rtarif where rdocno="+agmtno+" "+
					"  "+sqltest+"";
			System.out.println("Excess Query "+strexcesskm);
			System.out.println("excess day: "+excessday);
			System.out.println("excess lastday: "+excesslastday);
			ResultSet rsexcesskm=stmtexcesskm.executeQuery(strexcesskm);
			while(rsexcesskm.next()){
				exkmrte=rsexcesskm.getDouble("exkmrte");
	    		excesskm=rsexcesskm.getDouble("excesskm")+"";
			}
			stmtexcesskm.close();
		}
			else{
				if(rentaltype.equalsIgnoreCase("daily")){
					rentalno=1;
				}
				if(rentaltype.equalsIgnoreCase("weekly")){
					rentalno=7;
				}
				if(rentaltype.equalsIgnoreCase("fortnightly")){
					rentalno=14;
				}
				strmonthcal="select "+(day/rentalno)+"*rate tarif,"+(cdwdays/rentalno)+"*cdw cdw,"+(paidays/rentalno)+"*pai pai,"+(cdw1days/rentalno)+"*cdw1 scdw,"+
						+(pai1days/rentalno)+"*pai1 spai,"+(day/rentalno)+"*gps gps,"+(day/rentalno)+"*babyseater babyseater,"+(day/rentalno)+"*cooler cooler,"+
						+(day/rentalno)+"*chaufchg chaufferchg,("+totalkm+"-("+(day/rentalno)+"*kmrest))*exkmrte exkmrte,("+totalkm+"-("+(day/rentalno)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
				System.out.println("Check Query:  "+strmonthcal);
				
				if(tempconv==0){
					strmonthcal="select rate tarif,cdw cdw,pai pai,cdw1 scdw,pai1 spai,gps gps,babyseater babyseater,cooler cooler,chaufchg chaufferchg,("+totalkm+"-("+(days)+"*kmrest))*exkmrte exkmrte,"+
							"("+totalkm+"-("+(days)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
				}
				Statement stmtexcesskm=conn.createStatement();
				ResultSet rsexcesskm=stmtexcesskm.executeQuery(strmonthcal);
				while(rsexcesskm.next()){
					exkmrte=rsexcesskm.getDouble("exkmrte");
		    		excesskm=rsexcesskm.getDouble("excesskm")+"";
				}
			}
		
		}
		
		System.out.println("Strmonthcal:"+strmonthcal);
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
    		exhrchg=rsmonthcal.getDouble("exhrchg");
    		chaufchg=rsmonthcal.getDouble("chaufferchg");
    		
		}
		rentalno=lastday;
	
	}
	
	//System.out.println("Hoours For Grace Period Calculation"+hours);
	/*String strconfig="select (case when "+hours+"<=(select value from gl_config where field_nme='gp') then 'nothing' when "+hours+" <(select value from gl_config"+
			" where field_nme='gph') then 'hourly' when "+hours+"<(select value from gl_config where field_nme='gpd') then 'halfday'"+
			" else 'fullday' end )calc,value from gl_config where field_nme='gp'";
ResultSet rsconfig=stmtTarif.executeQuery(strconfig);
String calctype="";
double freehours=0.0;
if(rsconfig.next()){
while(rsconfig.next()){
	calctype=rsconfig.getString("calc");
	freehours=rsconfig.getDouble("value");
}
}
double cal=0.0;
double finalhours=0.0;
double hrchg=0.0;
if(calctype.equalsIgnoreCase("hourly")){
	finalhours=hours-freehours;
	hrchg=finalhours*exhrchg;
	cal=0;
}
if(calctype.equalsIgnoreCase("halfday")){
	//System.out.println("Calctype"+calctype);
	cal=0.5;
}
if(calctype.equalsIgnoreCase("fullday")){
	cal=1;
}*/
//System.out.println("Connection conn:"+conn);
//System.out.println("Connection Status:"+conn.isClosed());
Statement stmtTarif2=conn.createStatement();
/*if(rentaltype.equalsIgnoreCase("")){
	rentaltype="0";
}*/
if(agmtno.equalsIgnoreCase("")){
	agmtno="0";
}
if(exkmrte<0){
	exkmrte=0.0;
}

	//Final Calculated Query


String strgrace="select '"+rentaltype+"' rentaltype,if("+drate+">0,round("+rate+",0),0) rate,if("+dcdw+">0,round("+cdw+",0),0) cdw,if("+dpai+">0,round("+pai+",0),0) pai,"+
		" if("+dcdw1+">0,round("+cdw1+",0),0) cdw1,if("+dpai1+">0,round("+pai1+",0),0) pai1,if("+dgps+">0,round("+gps+",0),0) gps,if("+dbabyseater+">0,round("+babyseater+",0),0) babyseater,"+
		"if("+dcooler+">0,round("+cooler+",0),0) cooler,if("+dchaufchg+">0,round("+chaufchg+",0),0) chaufchg,if("+dexhrchg+">0,"+finalhours+"*exhrchg,0) exhrchg,round(if("+dexkmrte+">0,"+exkmrte+",0),2) exkmrte,round("+excesskm+",2) excesskm,'"+calctype+"' calctype,"+finalhours+" finalhours from gl_rtarif where rdocno="+agmtno+sqltest+
" union select 'Discount' rentaltype,0.00 rate,0.00 cdw,0.00 pai,"+
		" 0.00 cdw1,0.00 pai1,0.00 gps,0.00 babyseater,"+
		"0.00 cooler,0.00 chaufchg,0.00 exhrchg,0.00 exkmrte,0 excesskm,'"+calctype+"' calctype,"+finalhours+" finalhours from gl_rtarif where rdocno="+agmtno+sqltest+
"  union select 'Net Total' rentaltype,if("+drate+">0,round("+rate+",0),0) rate,if("+dcdw+">0,round("+cdw+",0),0) cdw,if("+dpai+">0,round("+pai+",0),0) pai,"+
		" if("+dcdw1+">0,round("+cdw1+",0),0) cdw1,if("+dpai1+">0,round("+pai1+",0),0) pai1,if("+dgps+">0,round("+gps+",0),0) gps,if("+dbabyseater+">0,round("+babyseater+",0),0) babyseater,"+
		"if("+dcooler+">0,round("+cooler+",0),0) cooler,if("+dchaufchg+">0,round("+chaufchg+",0),0) chaufchg,if("+dexhrchg+">0,"+finalhours+"*exhrchg,0) exhrchg,round(if("+dexkmrte+">0,"+exkmrte+",0),2) exkmrte,round("+excesskm+",2) excesskm,'"+calctype+"' calctype,"+finalhours+" finalhours from gl_rtarif where rdocno="+agmtno+sqltest;
			System.out.println("Final Query"+strgrace);
			
			ResultSet resultSet = stmtTarif2.executeQuery(strgrace);
			if(resultSet!=null){
				RESULTDATA=objcommon.convertToJSON(resultSet);
				//System.out.println("TOTAL RESULTDATA=========>"+RESULTDATA);
			}
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
/*	public   double funGetMonthCal(int monthcalmethod, int useddays, double monthcalvalue, double monthlyrate, Date sqlagmtdate, Date sqlclosedate){
		double finalamt=0.0;
		if(monthcalmethod==0){
			finalamt=(useddays/monthcalvalue)*monthlyrate;
		}
		return 0;
	}*/
	public   JSONArray getCalcData(String agmtno,String tarif,String cdwtotal,String acctotal,String chauffer,String excesskmchg,String excesshrchg,String temp
			,HttpSession session,String usedhours,String clientid,String fuel,String deliverychg,String collectchg,String outdate,String indate,
			String cmbinfuel,HttpServletRequest request,String exkm,java.sql.Date closeinvdate,String closecalflag,String calctype,String useddays,String rentaltype) throws SQLException {
		ClsRentalCloseSayaraBean bean=new ClsRentalCloseSayaraBean();

	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			if(agmtno.equalsIgnoreCase("")||agmtno.equalsIgnoreCase(null)){
				  agmtno="0";
			  }
			  
			double salamount=0.0;
			double salikratetemp=0.0;
			double saliksrvctemp=0.0;
			double salikamttemp=0.0;
			double trafficamounttemp=0.0;
			double trafficcounttemp=0.0;
			double trafficsrvctemp=0.0;
			int nocreditstatus=0;
			java.sql.Date fromdate=null,todate=null;
			if(!(outdate.equalsIgnoreCase("")||outdate.equalsIgnoreCase("0"))){
				fromdate=objcommon.changeStringtoSqlDate(outdate);
			}

			if(!(indate.equalsIgnoreCase("")||indate.equalsIgnoreCase("0"))){
				todate=objcommon.changeStringtoSqlDate(indate);
			}
		
				conn.setAutoCommit(false);
				Statement stmtTarif = conn.createStatement();
				if(collectchg.equalsIgnoreCase("")){
					collectchg="0";
				}
				if(usedhours.equalsIgnoreCase("")){
					usedhours="0";
				}
				double colchg=Double.parseDouble(collectchg==""?"0":collectchg);
				double delchg=Double.parseDouble(deliverychg==""?"0":deliverychg);
				
				Statement stmtclosecal=conn.createStatement();
				String strcloseconfig="select (select method from gl_config where field_nme='closecal') method,(select advchk from gl_ragmt where doc_no="+agmtno+") "+
				" advchk,(select count(*) from gl_invm where rano="+agmtno+" and ratype='RAG' and manual=2) advinvcount";
				int closecalmethod=0,advchk=0,advinvcount=0;
				ResultSet rsclosecal=stmtclosecal.executeQuery(strcloseconfig);
				while(rsclosecal.next()){
					closecalmethod=rsclosecal.getInt("method");
					advchk=rsclosecal.getInt("advchk");
					advinvcount=rsclosecal.getInt("advinvcount");
				}
				//stmtclosecal.close();
				
				if(closecalmethod==1){
					delchg=0;
					Statement stmt=conn.createStatement();
					ResultSet rsdel=stmt.executeQuery("select coalesce(delchg,0) delchg from gl_ragmt where doc_no="+agmtno+" and del_invno=0");
					while(rsdel.next()){
						delchg=rsdel.getDouble("delchg");
					}
					stmt.close();
				}
				
				
				
				/*
				Statement stmtconfig=conn.createStatement();
				String strconfig="select (case when "+usedhours+"<=(select value from gl_config where field_nme='gp') then 'nothing' when "+usedhours+" <(select value from gl_config"+
						" where field_nme='gph') then 'hourly' when "+usedhours+"<(select value from gl_config where field_nme='gpd') then 'halfday'"+
						" else 'fullday' end )calc,value from gl_config where field_nme='gp'";
				
//				System.out.println("Check Grace:"+strconfig);
				ResultSet rsconfig=stmtconfig.executeQuery(strconfig);
				String calc="";
				while(rsconfig.next()){
					calc=rsconfig.getString("calc");
				}*/
				
				//Method for get Quantity
				
				/*
				if(calc.equalsIgnoreCase("fullday")){
//					System.out.println("Check Date_add:select DATE_ADD('"+todate+"',INTERVAL 1 DAY) fdate");
					ResultSet rsconfig2=stmtconfig.executeQuery("select DATE_ADD('"+todate+"',INTERVAL 1 DAY) fdate");
					while(rsconfig2.next()){
						todate=rsconfig2.getDate("fdate");
					}
					
					
				}*/
				String calc=calctype;
				String daysused="";
				long nocreditdiff=0;
				long nocreditdatediff=0;
				
				if(fromdate!=null && todate!=null){
					nocreditdiff=todate.getTime()-fromdate.getTime();
					nocreditdatediff=nocreditdiff / (24 * 60 * 60 * 1000);
				}
				

				if(todate!=null && fromdate!=null){
					
					if(closecalmethod==1){
						fromdate=closeinvdate;
					}
					long diff=todate.getTime()-fromdate.getTime();
					long datediff = diff / (24 * 60 * 60 * 1000);
					
					ResultSet rsinvcount=stmtclosecal.executeQuery("select count(*) invcount from gl_invm where rano="+agmtno+" and ratype='RAG' and status=3");
					int invcount=0;
					while(rsinvcount.next()){
						invcount=rsinvcount.getInt("invcount");
					}
					
					
					if(datediff!=0){
						daysused=datediff+" D";
					}
					java.sql.Date deldate=null;
					java.sql.Date agmtoutdate=null;
					java.sql.Date tempnocreditdate=null;
					Statement stmtdel=conn.createStatement();
					int delcal=0;
					ResultSet rsdel=stmtdel.executeQuery("select (select method from gl_config where field_nme='delcal') delcal,(select mov.din from gl_vmove mov left join gl_ragmt agmt "+
					" on (mov.rdocno=agmt.doc_no and mov.rdtype='RAG') where mov.rdtype='RAG' and mov.rdocno="+agmtno+" and mov.trancode='DL' and mov.repno=0) din,(select odate from gl_ragmt where doc_no="+agmtno+") outdate ");
					while(rsdel.next()){
						deldate=rsdel.getDate("din");
						agmtoutdate=rsdel.getDate("outdate");
						delcal=rsdel.getInt("delcal");
					}
					if(deldate!=null && delcal==0){
						tempnocreditdate=deldate;
					}
					else{
						tempnocreditdate=agmtoutdate;
					}
					
					String stradv="select (select advchk from gl_ragmt where doc_no="+agmtno+") advchk,"+
					" (select count(*) from gl_invm where rano="+agmtno+" and ratype='RAG' and manual=2) advinvcount,"+
					" (select day(last_day('"+tempnocreditdate+"'))) startdays";
					int startdays=0;
					ResultSet rsadv=stmtdel.executeQuery(stradv);
					while(rsadv.next()){
						startdays=rsadv.getInt("startdays");
					}
					if(nocreditdatediff<startdays && advchk==1 && advinvcount==1){
						
						daysused=useddays+" D";
						closecalmethod=0;
						nocreditstatus=1;
						
					}
					System.out.println("Rentaltype: "+rentaltype);
					if(rentaltype.equalsIgnoreCase("Daily")){
						daysused=useddays+" Days";
					}
					else if(rentaltype.equalsIgnoreCase("Weekly")){
						double tempnum=Integer.parseInt(useddays)/7;
						int weeknumber=(int)tempnum;
						int daysnumber=(Integer.parseInt(useddays))-(weeknumber*7);
						if(weeknumber>0){
							daysused=weeknumber+" Weeks";
						}
						if(daysnumber>0){
							daysused+=" "+daysnumber+" Days";
						}
					}
					else if(rentaltype.equalsIgnoreCase("Monthly")){
						daysused="1 Month";
					}
					if(calc.equalsIgnoreCase("fullday")){
						daysused=daysused+" 1 D Extra";
					}
					
					else if(calc.equalsIgnoreCase("halfday")){
						daysused=daysused+" 0.5 D Extra";
					}
					if(datediff==0 && Double.parseDouble(usedhours)>0 && invcount==0){
						if(nocreditstatus!=1){
							datediff=datediff+1;	
						}
						
					}
				/*	java.sql.Date invtempdate=null;
					Statement stmtcheck=conn.createStatement();
					ResultSet rscheck=stmtcheck.executeQuery("select invdate from gl_ragmt where doc_no="+agmtno+"");
					while(rscheck.next()){
						invtempdate=rscheck.getDate("invdate");
					}*/
//					System.out.println("========from========"+fromdate+"==========todate========="+todate);
		
				request.setAttribute("daysused", daysused);
//				System.out.println("Check Request Value:"+request.getAttribute("daysused").toString());
				}
				if(temp.equalsIgnoreCase("1")){
				
				//System.out.println("SLQMODE"+sqlmode);
			
				String strSql="";
				strSql="select idno,description from gl_invmode order by idno";
				ResultSet result=stmtTarif.executeQuery(strSql);
				//System.out.println(strSql);
				String desc[] = new String[30];
				
				int i=0;
				while(result.next()){
					desc[i]=result.getString("idno");
					//System.out.println("IDNO Check:"+desc[i]+"iii:"+i+"::"+result.getString("description"));
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
				else{
					strtestdelcal="";
				}
				
				String strfuelchg="select mov.fleet_no,sum(coalesce(fin-fout,0.0)) tfuel,(select tcap from gl_vehmaster where fleet_no=mov.fleet_no) capacity,"+
						"(select fueltype from gl_vehmaster where fleet_no=mov.fleet_no) fueltype "+
						" from gl_vmove mov where mov.rdocno="+agmtno+" and mov.rdtype='RAG' and status='IN' "+strtestdelcal+" group by mov.fleet_no";
			
				System.out.println("Fuel Query:"+strfuelchg);
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
//					System.out.println("Check Total Fuel:"+rsfuelchg.getDouble("tfuel"));
					fuelsum+=((rsfuelchg.getDouble("tfuel")*frate)*rsfuelchg.getDouble("capacity"));
					temptfuel+=rsfuelchg.getDouble("tfuel");
					System.out.println("Final Fuel Sum:"+fuelsum+"Total Fuel:"+rsfuelchg.getDouble("tfuel")+"Capacity:"+rsfuelchg.getDouble("capacity")+"Rate:"+frate);
				}
				
//System.out.println("fuelsum b4 current:"+fuelsum);
				String strfuel2="select "+cmbinfuel+" fin,fout,veh.tcap,if(veh.fueltype='P',"+prate+","+
						" "+drate+") ratevalue from gl_vmove mov left join gl_vehmaster veh on"+
						" mov.fleet_no=veh.fleet_no where rdocno="+agmtno+" and rdtype='RAG' and mov.status='OUT'";
				System.out.println("Remain fuel query:"+strfuel2);
				ResultSet rsfuel2=stmtTarif.executeQuery(strfuel2);
				double remainfuel=0.0;
				while(rsfuel2.next()){
					//remainfuel=rsfuel2.getDouble("fout")-rsfuel2.getDouble("fin");
					//Override
					remainfuel=rsfuel2.getDouble("fin")-rsfuel2.getDouble("fout");
					
					fuelsum=fuelsum+(remainfuel*rsfuel2.getDouble("tcap")*rsfuel2.getDouble("ratevalue"));
					System.out.println("Remainfuel:"+remainfuel+"Capacity:"+rsfuel2.getDouble("tcap")+"Value:"+rsfuel2.getDouble("ratevalue")+"fuelsum:"+fuelsum);
				}
				fuelsum=fuelsum*-1;
				fuelqty=temptfuel+remainfuel;
				/*if(fuelsum<0){
				fuelsum=fuelsum*-1;
				}*/
				int salikcount=0;
				int trafficcount=0;
				/*	String sqltestsalik="";
				String sqltesttraffic="";
				if(!(outdate==null && indate==null)){
					sqltestsalik=" and sal_date between '"+fromdate+"' and '"+todate+"'";
					sqltesttraffic=" and traffic_date between '"+fromdate+"' and '"+todate+"'";
				}*/
				
				String strsqltest="";
				
				String strasd="select method from gl_config where field_nme='closecal'";
				Statement stmtasd=conn.createStatement();
				ResultSet rsasd=stmtasd.executeQuery(strasd);
				int salikclosecalmethod=0;
				while(rsasd.next()){
					salikclosecalmethod=rsasd.getInt("method");
				}
				if((closecalmethod==0 && nocreditstatus==1) || closecalmethod==1){
					strsqltest=" and inv_no=0";
				}
				
				//closecalmethod==0 && nocreditstatus=1
				
				String strsalik="select COALESCE(sum(amount),0.0) amount,count(*) count,amount salamount from gl_salik where amount>0 and isallocated=1 and ra_no="+agmtno+" and"+
						" rtype in('RA','RD','RW','RF','RM')  and sal_date <='"+todate+"' "+strsqltest;
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
				
				String strtraffic="select  count(*) trafficcount,COALESCE(sum(amount),0.0) trafficamt from gl_traffic where emp_type='CRM' and amount>0  and isallocated=1 and ra_no="+agmtno+" and "+
						" rtype in ('RA','RD','RW','RF','RM') and traffic_date <='"+todate+"' "+strsqltest;
//				System.out.println(strtraffic);
				ResultSet rstraffic=stmtTarif.executeQuery(strtraffic);
				double trafficamt=0.0;
				while(rstraffic.next()){
					trafficamt=rstraffic.getDouble("trafficamt");
					trafficcount=rstraffic.getInt("trafficcount");
				}
				
				
				//Fetching Dubai Gov Traffic Acknowledge Fees
				ClsCommon objcommon=new ClsCommon();

				double trafficfees=objcommon.getTrafficFees(Integer.parseInt(agmtno),fromdate,todate,"RAG","1");
				
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
//					System.out.println("Salik srv Query:"+saliksrv);
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
//					System.out.println("Inside Traffic Percent:"+finaltrafficsrvc);
					}
					if(trafficmethod==0){
						String trafficsrvchg="select value from gl_config where field_nme='trafficsrv'";
						ResultSet rstrafficsrvchg=stmtTarif.executeQuery(trafficsrvchg);
						while(rstrafficsrvchg.next()){
							trafficsrvc=rstrafficsrvchg.getDouble("value");
							//finaltrafficsrvc=trafficamt*trafficsrvc;
							finaltrafficsrvc=trafficcount*trafficsrvc;
						}
						System.out.println("Inside Traffic Value:"+finaltrafficsrvc);
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
				System.out.println("Final TrafficSRVC:"+finaltrafficsrvc);
				trafficsrvctemp=finaltrafficsrvc;
				trafficcounttemp=trafficcount;
//				System.out.println("Check Salik And Traffic:"+salikamt+":::::::::::"+trafficamt);
				ArrayList<String> rcalcarray= new ArrayList<String>();
//				System.out.println("Tarif Check:"+tarif);
				
				Statement stmtadddriver=conn.createStatement();
				
				
				String stradddriver="";
				if(closecalmethod==1){
					stradddriver="select coalesce(addrchg,0) addrchg from gl_ragmt where doc_no="+agmtno+" and addr=1 and addr_invno=0";
				}
				else{
					stradddriver="select coalesce(addrchg,0) addrchg from gl_ragmt where doc_no="+agmtno+" and addr=1";	
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
						" insp.reftype='RAG' and refdocno="+agmtno+" and invno=0 and insp.amount>0 and insp.status=3";
				double damageamount=0.0;
				ResultSet rsdamage=stmtdamage.executeQuery(strdamage);
				while(rsdamage.next()){
					damageamount=rsdamage.getDouble("amount");
					}
					stmtdamage.close();
					
				//Code for damage Amount Ends Here				
				
				System.out.println("asdsadasdasdasdasda"+salikamt+"::::"+saliksrvcchg);
				/*double tempnum=Integer.parseInt(useddays)/7;
				int weeknumber=(int)tempnum;
				int daysnumber=(Integer.parseInt(useddays))-(weeknumber*7);*/
				
				
				if((Double.parseDouble(tarif))!=0){
					//System.out.println("Check"+session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[0]+"::"+tarif+"::"+daysused+"::0::0::");
				rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[0]+"::"+tarif+"::"+daysused+"::0::0::"+null);
				}
				if((Double.parseDouble(cdwtotal))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[16]+"::"+cdwtotal+"::"+daysused+"::0::0::"+null);	
				}
				if((Double.parseDouble(acctotal))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[1]+"::"+acctotal+"::"+daysused+"::0::0::"+null);	
				}
				if((Double.parseDouble(chauffer))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[2]+"::"+chauffer+"::"+daysused+"::0::0::"+null);	
				}
				//System.out.println("Excess kmchg in dao:"+Double.parseDouble(excesskmchg));
				if((Double.parseDouble(excesskmchg))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[3]+"::"+excesskmchg+"::"+exkm+"::0::0::"+null);	
				}
				if((Double.parseDouble(excesshrchg))!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[4]+"::"+excesshrchg+"::"+usedhours+"::0::0::"+null);	
				}
				if(salikamt!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[7]+"::"+salikamt+"::"+salikcount+"::0::0::"+null);	
				}
				if(saliksrvcchg!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[13]+"::"+saliksrvcchg+"::"+salikcount+"::0::0::"+null);	
				}
				if(trafficamt!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[8]+"::"+trafficamt+"::"+trafficcount+"::0::0::"+null);	
				}
				if(finaltrafficsrvc!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[14]+"::"+finaltrafficsrvc+"::"+trafficcount+"::0::0::"+null);	
				}
				if(deliverycollectchg!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[5]+"::"+deliverycollectchg+"::1::0::0::"+null);	
				}
				if(fuelsum>0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[10]+"::"+objcommon.Round(fuelsum, 2)+"::"+fuelqty+"::0::0::"+null);	
				}
				if(add_driverchg!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[11]+"::"+add_driverchg+"::1::0::0::"+null);
				}
				if(damageamount!=0){
					rcalcarray.add(session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[9]+"::"+damageamount+"::"+daysused+"::0::0::"+null);
				}
				Statement stmtrcalcdelete=conn.createStatement();
				System.out.println("Here before loop");
				for(int z=0;z<rcalcarray.size();z++){
					System.out.println(rcalcarray.get(z));
				}
				String strrcalcdelete="delete from gl_rcalc where calcstatus=1 and rdocno="+agmtno+"";
				int deleteval=stmtrcalcdelete.executeUpdate(strrcalcdelete);
				
				for(int j=0;j< rcalcarray.size();j++){
					String[] rcalc=rcalcarray.get(j).split("::");
				
						int rval=rcalcinsert(rcalc[0],rcalc[1],rcalc[2],rcalc[3],rcalc[4],rcalc[5],rcalc[6],rcalc[7],rcalc[8],stmtTarif);
						if(rval<=0){
							conn.close();
							return RESULTDATA;
						}
				
				}
				conn.commit();
				}


				String finalsql="";
				System.out.println("nocredit:"+nocreditstatus);
				
				/**
				 * closecalmethod is made 0 when no credit status exist so added condition if(closecalmethod==0 && nocreditstatus==0){
				 * before was considering closecalmethod only
				 */
				if(closecalmethod==0 && nocreditstatus==0){
					
					System.out.println("closecalc0");
					/*
					if(nocreditstatus==1){
						finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
								" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,0,0)*-1 creditnote,r.salamount,r.salikrate,"+
								" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
								" (select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,0,0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
								" gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 group by idno"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,0,0)*-1 creditnote,"+salamount+" salamount,"+salikratetemp+" salikrate,"+saliksrvctemp+" saliksrvc,"+salikamttemp+" salikamt,0 trafficamt,0 trafficsrvc from"+
								" gl_rcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,0,0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,"+trafficamounttemp+" trafficamt,"+trafficsrvctemp+" trafficsrvc from"+
								" gl_rcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";	
					
	
					}
					else{*/
						finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
								" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote,r.salamount,r.salikrate,"+
								" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
								" (select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
								" gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 group by idno"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,"+salamount+" salamount,"+salikratetemp+" salikrate,"+saliksrvctemp+" saliksrvc,"+salikamttemp+" salikamt,0 trafficamt,0 trafficsrvc from"+
								" gl_rcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0"+
								" union all"+
								" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
								" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,"+trafficamounttemp+" trafficamt,"+trafficsrvctemp+" trafficsrvc from"+
								" gl_rcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0) r on(m.idno=r.idno) where r.idno is not null";	
											
//					}
				
				
				
				
				}
				else if((closecalmethod==0 && nocreditstatus==1) || closecalmethod==1){
					finalsql="select r.idno,m.acno,r.qty,r.total,m.description,r.invoiced invoiced,if((r.total-r.invoiced)>0,"+
							" (r.total-r.invoiced),0) invoice,if((r.total-r.invoiced)<0,(r.total-r.invoiced),0)*-1 creditnote,r.salamount,r.salikrate,"+
							" r.saliksrvc,r.salikamt,r.trafficamt,r.trafficsrvc from gl_invmode m left join"+
							" (select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_rcalc r where r.idno not in(8,9,14,15) and rdocno="+agmtno+" and afterclose=0 and calcstatus=1 group by idno"+
							" union all"+
							" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,"+salamount+" salamount,"+salikratetemp+" salikrate,"+saliksrvctemp+" saliksrvc,"+salikamttemp+" salikamt,0 trafficamt,0 trafficsrvc from"+
							" gl_rcalc r where r.idno in(8,14) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1"+
							" union all"+
							" select r.idno,(select qty from gl_rcalc where rowno=max(r.rowno)) qty,coalesce(sum(amount),0) total,sum(invoiced) invoiced,if((sum(amount)-sum(invoiced))>0,"+
							" (sum(amount)-sum(invoiced)),0) invoice,if((sum(amount)-sum(invoiced))<0,(sum(amount)-sum(invoiced)),0)*-1 creditnote,0 salamount,0 salikrate,0 saliksrvc,0 salikamt,"+trafficamounttemp+" trafficamt,"+trafficsrvctemp+" trafficsrvc from"+
							" gl_rcalc r where r.idno in(9,15) and rdocno="+agmtno+" and afterclose=0  and calcstatus=1 ) r on(m.idno=r.idno) where r.idno is not null";
				
				}
				System.out.println("Final Calculate Query"+finalsql);
				ResultSet finalresult=stmtTarif.executeQuery(finalsql);
				if(finalresult!=null){
				RESULTDATA=objcommon.convertToJSON(finalresult);
					stmtTarif.close();
				conn.close();
				return RESULTDATA;
				}
				
				//stmtTarif.close();
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
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		}
	public   int rcalcinsert(String rcalc0,String rcalc1,String rcalc2,String rcalc3,String rcalc4,String rcalc5,String rcalc6,String rcalc7,String rcalc8,Statement stmtTarif){
		String strinsert1="insert into gl_rcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate,calcstatus)values('"+rcalc0+"','"+rcalc1+"',"+
				"'"+rcalc2+"','"+rcalc3+"','"+rcalc4+"','"+rcalc5+"','"+rcalc6+"','"+rcalc7+"',"+rcalc8+",1)";
//				System.out.println("Sql Rcalc:"+strinsert1);
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
	/*session.getAttribute("BRANCHID").toString()+"::"+agmtno+"::RAG::"+desc[10]+"::"+fuelsum+"::"+fuelqty+"::0::0::"+null*/
	public   int rcalcedit(String rcalc0,String rcalc1,String rcalc2,String rcalc3,String rcalc4,String rcalc5,String rcalc6,String rcalc7,String rcalc8,Statement stmtTarif){
		String strupdate1="update gl_rcalc set brhid='"+rcalc0+"',rdocno='"+rcalc1+"',dtype='"+rcalc2+"',idno='"+rcalc3+"',amount='"+rcalc4+"',qty='"+rcalc5+"',invoiced='0',invno='0',invdate=null where calcstatus=1 and "+
				"rdocno='"+rcalc1+"' and idno='"+rcalc3+"'";
//				System.out.println("Sql rcalc:"+strupdate1);
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
			String creditnotesum, HttpServletRequest request,String collectchg,String brchname,String branchsearch,String closelocation,String description,String hidchkorgregcardcollect) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		//HttpServletRequest request=ServletActionContext.getRequest();
		int agmtvocno=0;
		String mrano="";
		Statement stmtagmtvoc=conn.createStatement();
		String stragmtvoc="select voc_no,coalesce(refno,'') refno from gl_ragmt where doc_no="+agreementno;
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
			ResultSet rstest2=stmttest2.executeQuery("select fleet_no from gl_vmove where rdocno="+agreementno+" and rdtype='RAG' and status='OUT'");
			while(rstest2.next()){
				hidfleet=rstest2.getString("fleet_no");
			}
			stmttest2.close();
			Statement stmtsrvcacno=conn.createStatement();
			int saliksrvcacno=0;
			int trafficsrvcacno=0;
			java.sql.Date invtempdate=null;
			int damageflag=0,damagedoc=0;
			ResultSet rsacno=stmtsrvcacno.executeQuery("select (select acno from gl_invmode where idno=14)acno,(select acno from gl_invmode where idno=15)trafficsrvcacno,"+
					" (select invdate from gl_ragmt where doc_no="+agreementno+") fromdate");
			while(rsacno.next()){
				saliksrvcacno=rsacno.getInt("acno");
				
				trafficsrvcacno=rsacno.getInt("trafficsrvcacno");
				
			}
			
			
			invtempdate=outdate;
			if(invtempdate.compareTo(indate)>0 || invtempdate.compareTo(indate)==0){
				invtempdate=indate;
			}
			String qty2="";
						ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
						ClsCreditNoteDAO creditdao=new ClsCreditNoteDAO();
						int agmtno=Integer.parseInt(agreementno);
						ArrayList<String> newarray=new ArrayList<>();
						/*System.out.println("Checking Request Attribute:"+request.getAttribute("daysused").toString());*/
						if(calcarray.size()>0){
						 qty2=calcarray.get(0).split("::")[3];
						for(int i=0;i<calcarray.size();i++){
							System.out.println(calcarray.get(i));
						String[] invoicenew=calcarray.get(i).split("::");
						if(Double.parseDouble(invoicenew[5])>0){
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
							else{
								//invoice[3] instead objcommon.getMonthandDays(indate, invtempdate, conn)
								newarray.add(invoicenew[0]+"::"+invoicenew[1]+"::"+invoicenew[2]+"::"+invoicenew[3]+"::"+invoicenew[5]+"::"+invoicenew[5]);	
							}
							
							if(invoicenew[0].equalsIgnoreCase("10")){
								damageflag=1;
								Statement stmtdamagedoc=conn.createStatement();
								String strgetdamagedoc="select insp.doc_no from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno where "+
						" insp.reftype='RAG' and refdocno="+agmtno+" and invno=0 and insp.amount>0 and insp.status=3";
								ResultSet rsdamagedoc=stmtdamagedoc.executeQuery(strgetdamagedoc);
								while(rsdamagedoc.next()){
									damagedoc=rsdamagedoc.getInt("doc_no");
								}
								stmtdamagedoc.close();
							}
						}
						
						}
//						System.out.println(newarray);
						String note=objcommon.changeSqltoString(invtempdate) +" to "+objcommon.changeSqltoString(indate) +" for Rental Agreement no "+agmtno;
						int invval=0;
						if(newarray.size()>0){
							
							invval=manualdao.insert(conn,newarray, "RAG", closedate, clientid, agmtno, note, note, invtempdate, indate, branchsearch,
								session.getAttribute("USERID").toString(), session.getAttribute("CURRENCYID").toString(), mode, clientacno, "INV###3", "INV",qty2);
//						System.out.println("Invoice Value:"+invval);
						if(invval<=0){
							System.out.println("////////////////Invoice Error/////////////");
							conn.close();
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
						}
						
						//Statement stmtinvoice=conn.createStatement();
						for(int z=0;z<newarray.size();z++){
							System.out.println("asdasd "+newarray.get(z));
						}
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
							System.out.println("////////////////Currency Error Session/////////////");
							conn.close();
							return 0;
						}
						
						Statement stmtcredit=conn.createStatement();
						
						for(int i=0;i<calcarray.size();i++){
							String[] credit=calcarray.get(i).split("::");
							//System.out.println("creditDAO"+credit[6]);
							if(Double.parseDouble(credit[6])>0){
							double baseamt=(Double.parseDouble((String) (credit[6].equalsIgnoreCase("undefined") || credit[6].isEmpty()?0:credit[6])))*testcurrate;
							double amt=(Double.parseDouble((String) (credit[6].equalsIgnoreCase("undefined") || credit[6].isEmpty()?0:credit[6])));
						
							creditarray.add((credit[1].equalsIgnoreCase("undefined") || credit[1].isEmpty()?0:credit[1])+"::"+session.getAttribute("CURRENCYID").toString()+"::"+testcurrate+"::"+"true"+"::"+amt+"::"+"Credit Note for Rental Agreement no "+agreementno+""+"::"+baseamt+"::"+"6"+"::"+hidfleet);				
							
							}
							
						//System.out.println("array in rental"+creditarray.get(0));
						}
						
//							System.out.println("Invoice Insertion Success");
							//System.out.println("checking creditnote"+closedate+":"+agreementno+":"+testcurrate+":"+ Integer.parseInt(clientacno)+":"+session.getAttribute("CURRENCYID").toString()+":"+Double.parseDouble(creditnotesum)+":"+mode);
							if(creditarray.size()>0){
							int crval=creditdao.insert(conn,closedate, "CNO", agreementno, testcurrate, "Credit Note for Rental Agreement no "+agmtvocno+""+mrano, Integer.parseInt(clientacno),  session.getAttribute("CURRENCYID").toString(), Double.parseDouble(creditnotesum), 
									Double.parseDouble(creditnotesum),"RAG",Integer.parseInt(agreementno), creditarray, session, request, mode);
							
							if(crval<=0){
								System.out.println("////////////////Credit Note Error/////////////");
								conn.close();
								return 0;
							}
							
							if(crval>0){
//								System.out.println("Credit Note Insertion Success");
								for(int i=0;i<calcarray.size();i++){
									String[] credit=calcarray.get(i).split("::");
									if(Double.parseDouble(credit[6])>0){
								String strcredit="insert into gl_rcalc(brhid,trno,rdocno,dtype,idno,cnote,cnoteno,cnotedate,qty)values("+
									"'"+branchsearch+"','"+request.getAttribute("tranno").toString()+"','"+agreementno+"','RAG','"+(credit[0].equalsIgnoreCase("undefined") || credit[0].isEmpty()?0:credit[0])+"',"+
										"'"+(credit[6].equalsIgnoreCase("undefined") || credit[6].isEmpty()?0:credit[6])+"','"+crval+"','"+closedate+"','"+qty2+"')";
								int crcalc=stmtcredit.executeUpdate(strcredit);
								if(crcalc<=0){
									System.out.println("////////////////Rcalc Credit Note Insertion Error/////////////");
							conn.close();
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
						if(cmbcollectfuel.equalsIgnoreCase("")||cmbcollectfuel.equalsIgnoreCase(null)){
							cmbcollectfuel="0";
						}
						if(cmbrentalagent.equalsIgnoreCase("")||cmbrentalagent.equalsIgnoreCase(null)){
							cmbrentalagent="0";
						}
						if(collectchg.equalsIgnoreCase("")){
							collectchg="0";
						}
						if(hidchkcollection.equalsIgnoreCase("")){
							hidchkcollection="0";
						}
						cmbcollectfuel=cmbcollectfuel==null?"0":cmbcollectfuel;
						/*if(collectchg==null){
							collectchg="0";
						}*/
						CallableStatement stmtClose = conn.prepareCall("{call rentalCloseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
						 stmtClose.setString(10,cmbcheckin);
						 stmtClose.setString(11,cmbrentalagent);
						 stmtClose.setDouble(12,Double.parseDouble(useddays));
						 stmtClose.setString(13,usedhours);
						 stmtClose.setString(14,totalkm);
						 stmtClose.setString(15,excesskm);
						 stmtClose.setString(16,inkm);
						 stmtClose.setString(17,cmbinfuel);
						 stmtClose.setDate(18,indate);
						 stmtClose.setString(19,intime);
						 stmtClose.setString(20,session.getAttribute("USERID").toString());
						 stmtClose.setString(21,brchname);
						 stmtClose.setString(23,mode);
						 stmtClose.setInt(24, Integer.parseInt(hidfleet));
						 stmtClose.setDouble(25,Double.parseDouble(collectchg));
						 stmtClose.setString(27,branchsearch);
						 stmtClose.setString(28,closelocation);
						 stmtClose.setString(29,description);
//						 System.out.println(stmtClose);
						 stmtClose.executeQuery();
				mval=stmtClose.getInt("docNo");
				voucherno=stmtClose.getInt("voucherno");
				request.setAttribute("VOUCHERNO", voucherno);
						if(mval<=0){
							System.out.println("////////////////Main Document Error/////////////");
							conn.close();
							return 0;
						}
						if(mval>0){
							Statement stmtorgreg=conn.createStatement();
							String strorgreg="update gl_ragmtclosem set orgregcardcollect=1 where doc_no="+mval;
							int updateorgreg=stmtorgreg.executeUpdate(strorgreg);
							if(updateorgreg<0){
								conn.close();
								return 0;
							}
						}
//						System.out.println("R Agmt CloseM Success"+mval);
							Statement stmt=conn.createStatement();
						int movdoc=0;
						String selectmovdoc="select doc_no from gl_vmove where rdocno='"+agreementno+"' and rdtype='RAG' and status='OUT'";
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
						String sql="update gl_ragmt set clstatus=1 where doc_no="+agreementno;
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
							String strlocid="select min(doc_no) doc_no from my_locm where brhid="+brchname+" and status<>7";
							ResultSet rslocid=stmtloc.executeQuery(strlocid);
							int closelocid=0;
							while(rslocid.next()){
								closelocid=rslocid.getInt("doc_no");
							}
							closelocid=Integer.parseInt(closelocation);
							Statement stmtveh=conn.createStatement();
							//(select if(dtype='VEH','UR','NR'))
							String strveh="update gl_vehmaster set status='IN',tran_code='UR',a_br="+brchname+",a_loc="+closelocid+"  where fleet_no="+hidfleet;
							int vehval=stmtveh.executeUpdate(strveh);
							if(vehval<=0){
								System.out.println("////////////////Vehicle Master Error/////////////");
								conn.close();
								return 0;
							}
							Statement stmtac=conn.createStatement();
							String strac="update my_acbook set rostatus=if(rostatus=0,0,rostatus-1)  where cldocno="+clientid+" and dtype='CRM'";
//							System.out.println("Acbook str:"+strac);
							int acval=stmtac.executeUpdate(strac);
							if(acval<0){
								System.out.println("////////////////my_acbook Error/////////////");
								conn.close();
								return 0;
							}
							stmtac.close();
							String strmov="";
							if(hidchkcollection.equalsIgnoreCase("1")){
							strmov="update gl_vmove set status='IN',din='"+collectdate+"',tin='"+collecttime+"',kmin='"+collectkm+"',fin='"+cmbcollectfuel+"',"+
									"ibrhid='"+brchname+"',ilocid="+closelocid+",ireason='Rental Close',iaccident=0,"+
									" ttime='"+totalmin+"',tkm=(select "+collectkm+"-kmout ),tfuel=(select "+cmbcollectfuel+"-fout )where doc_no="+movdoc+" and rdtype='RAG'";
							}
							else{
								strmov="update gl_vmove set status='IN',din='"+indate+"',tin='"+intime+"',kmin='"+inkm+"',fin='"+cmbinfuel+"',"+
										"ibrhid='"+brchname+"',ilocid="+closelocid+",ireason='Rental Close',iaccident=0,"+
										" ttime='"+totalmin+"',tkm=(select "+inkm+"-kmout ),tfuel=(select "+cmbinfuel+"-fout )where doc_no="+movdoc+" and rdtype='RAG'";
							}
//								System.out.println("Mov Update Query"+strmov);
							int movval=stmt.executeUpdate(strmov);
							if(movval<0){
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
									String gridsql="insert into gl_ragmtclosed(rdocno,brhid,rentaltype,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,exkmrte,exhrchg,chaufchg)values("+
											"'"+agreementno+"','"+brchname+"','"+(close[0].equalsIgnoreCase("undefined") || close[0].isEmpty()?0:close[0])+"',"+
											"'"+(close[1].equalsIgnoreCase("undefined") || close[1].isEmpty()?0:close[1])+"','"+(close[2].equalsIgnoreCase("undefined") || close[2].isEmpty()?0:close[2])+"',"+
											"'"+(close[3].equalsIgnoreCase("undefined") || close[3].isEmpty()?0:close[3])+"','"+(close[4].equalsIgnoreCase("undefined") || close[4].isEmpty()?0:close[4])+"',"+
											"'"+(close[5].equalsIgnoreCase("undefined") || close[5].isEmpty()?0:close[5])+"','"+(close[6].equalsIgnoreCase("undefined") || close[6].isEmpty()?0:close[6])+"',"+
											"'"+(close[7].equalsIgnoreCase("undefined") || close[7].isEmpty()?0:close[7])+"','"+(close[8].equalsIgnoreCase("undefined") || close[8].isEmpty()?0:close[8])+"',"+
											"'"+(close[9].equalsIgnoreCase("undefined") || close[9].isEmpty()?0:close[9])+"','"+(close[10].equalsIgnoreCase("undefined") || close[10].isEmpty()?0:close[10])+"',"+
											"'"+(close[11].equalsIgnoreCase("undefined") || close[11].isEmpty()?0:close[11])+"')";
//									System.out.println("Sql"+gridsql);
									 gridsqlval = stmt.executeUpdate (gridsql);
									if(gridsqlval<=0){
										//System.out.println("Return 0 gridsqlval");
										System.out.println("////////////////Ragmt closed Error/////////////");
										conn.close();
										return 0;
									}
								}
								}
							if(gridsqlval>0){
								conn.commit();
								SmsAction sms=new SmsAction();
								ClsRentalAgreementDAO ragmtdao=new ClsRentalAgreementDAO();
								ArrayList<String> smsdetails=new ArrayList<>();
								smsdetails=ragmtdao.getSmsDetails(clientid,conn);
								sms.doSendSms(smsdetails.get(0),smsdetails.get(1),"0.0",mval+"",closedate+"","RAC", session.getAttribute("BRANCHID").toString().trim());

								stmt.close();
								stmtClose.close();
								conn.close();
								return mval;	
							}
		}
		}
		catch(Exception e){
			e.printStackTrace();
		conn.close();
		return 0;
		}
		finally{
			conn.close();
		}
		//conn.close();
		System.out.println("////////////////Main Data Error/////////////");
		return 0;
	}
	public int getCloseMethod() throws SQLException {
		// TODO Auto-generated method stub
		int config=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strconfig="select method from gl_config where field_nme='closecal'";
			Statement stmtconfig=conn.createStatement();
			ResultSet rsconfig=stmtconfig.executeQuery(strconfig);
			while(rsconfig.next()){
				config=rsconfig.getInt("method");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return config;
	}

	
	
	public int delete(int docno, String agreementno,HttpSession session,String mode,String hidfleet,String branch) throws SQLException {
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
			
			ResultSet rsmax=stmtmov.executeQuery("select rdocno,rdtype from gl_vmove where doc_no="+maxdoc+"");
			while(rsmax.next()){
				temptype=rsmax.getString("rdtype");
				temprdocno=rsmax.getInt("rdocno");
			}
			System.out.println(temptype+"::::"+temprdocno+"::::"+agreementno);
			if(temptype.equalsIgnoreCase("RAG") && temprdocno==(Integer.parseInt(agreementno))){
			//System.out.println(temptype=="RAG" && temprdocno==(Integer.parseInt(agreementno)));
			System.out.println("Inside");
			CallableStatement stmtdelete=conn.prepareCall("{call rentalCloseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtdelete.setInt(22, docno);
			stmtdelete.registerOutParameter(26, 0);
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
			 stmtdelete.setString(21,branch);
			 stmtdelete.setString(23,mode);
			 stmtdelete.setInt(24, Integer.parseInt(hidfleet));
			 stmtdelete.setDouble(25,Double.parseDouble("0"));
			 stmtdelete.setString(27,"0");
			 stmtdelete.setString(28,"0");
			 stmtdelete.setString(29,"0");
			 int val=stmtdelete.executeUpdate();
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


	public JSONArray getTotalDataSayara(String useddays,String usedhours,String totalkm,String agmtno,String rentaltype,
			String agmtdate,String closedate,String closecalflag,java.sql.Date closeinvdate,String temp) throws SQLException,NullPointerException {
		JSONArray totaldata=new JSONArray();
		if(!temp.equalsIgnoreCase("1")){
	    	//System.out.println("Inside: "+temp);
	    	return totaldata;
	    }
		Connection conn=null;
		try{
			
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int monthcalmethod=0,monthcalvalue=0;
			java.sql.Date sqlclosedate=null;
			String strmonthcal="select method,value from gl_config where field_nme='monthlycal'";
			ResultSet rsmonthcal=stmt.executeQuery(strmonthcal);
			while(rsmonthcal.next()){
				monthcalmethod=rsmonthcal.getInt("method");
				monthcalvalue=rsmonthcal.getInt("value");
			}
			if(!closedate.equalsIgnoreCase("") && closedate!=null){
				sqlclosedate=objcommon.changeStringtoSqlDate(closedate);
			}
			if(monthcalmethod==1){
				String strmonthcalvalue="select day(last_day('"+sqlclosedate+"')) monthcalvalue";
				ResultSet rsmonthcalvalue=stmt.executeQuery(strmonthcalvalue);
				while(rsmonthcalvalue.next()){
					monthcalvalue=rsmonthcalvalue.getInt("monthcalvalue");
				}
			}
			System.out.println("Monthcalvalue: "+monthcalvalue);
			String calctype="";
			double freehours=0.0;
			double days=0.0,hours=0.0;
			days=Double.parseDouble(useddays==""?"0":useddays);
			hours=Double.parseDouble(usedhours==""?"0":usedhours);			
			Statement stmtTarif = conn.createStatement();
			String strconfig="select (case when "+hours+"<=(select value from gl_config where field_nme='gp') then 'nothing' when "+hours+" <(select value from gl_config"+
					" where field_nme='gph') then 'hourly' when "+hours+"<(select value from gl_config where field_nme='gpd') then 'halfday'"+
					" else 'fullday' end )calc,value from gl_config where field_nme='gp'";
			//System.out.println("Grace Query:"+strconfig);
			
			ResultSet rsconfig=stmtTarif.executeQuery(strconfig);
			while(rsconfig.next()){
				calctype=rsconfig.getString("calc");
				freehours=rsconfig.getDouble("value");
			}

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

			double cal=0.0;
			double finalhours=0.0;
			double hrchg=0.0;
			//hours=Math.round(hours);

			String temptime[]=usedhours.replace(".",":").split(":");
			int temphours=Integer.parseInt(temptime[0]);
			int tempminutes=Integer.parseInt(temptime[1]);
			if(calctype.equalsIgnoreCase("hourly")){

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

			
			//Query for getting default selected tarif details as in agreement starts here
			Statement stmtdefault=conn.createStatement();
			
			double drate=0.0,dcdw=0.0,dpai=0.0,dcdw1=0.0,dpai1=0.0,dgps=0.0,dbabyseater=0.0,dcooler=0.0,dkmrest=0.0,dexhrchg=0.0,dexkmrte=0.0,dchaufchg=0.0;
			String strdefault="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg"+
					" from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
			//System.out.println("Default Query:"+strdefault);
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
				dexhrchg=rsdefault.getDouble("exhrchg");
				dexkmrte=rsdefault.getDouble("exkmrte");
				dchaufchg=rsdefault.getDouble("chaufchg");
			}
			stmtdefault.close();
			//System.out.println("Days:"+days);
			//Query for getting default selected tarif details as in agreement ends here
			
			
			
			//Query for determining if extra charges are calculated for cdw,pai,supercdw,superpai starts here
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
		cdwdays=days;
		paidays=days;
		cdw1days=days;
		pai1days=days;
			if(extracdw==0){
				cdwdays=cdwdays-cal;
				}
			if(extrapai==0){
				paidays=paidays-cal;
				}
			if(extracdw1==0){
				cdw1days=cdw1days-cal;
				}
			if(extrapai1==0){
				pai1days=pai1days-cal;
				}
		String stramountdecide="";
		String sqltest="";
		String temprentaltype="";
		double tarif=0.0,cdw=0.0,pai=0.0,scdw=0.0,spai=0.0,gps=0.0,babyseater=0.0,cooler=0.0,chaufferchg=0.0,excesskm=0.0,exkmrte=0.0,exhrchg=0.0;
		double tempnum=0.0,tempnumcdw=0.0,tempnumpai=0.0,tempnumcdw1=0.0,tempnumpai1=0.0;
		int weeknumber=0,daysnumber=0,weeknumbercdw=0,daysnumbercdw=0,weeknumberpai=0,daysnumberpai=0,weeknumbercdw1=0,daysnumbercdw1=0,weeknumberpai1=0,daysnumberpai1=0;
		
		if(days>=monthcalvalue){
			
			if(rentaltype.equalsIgnoreCase("Monthly")){
				sqltest+=" and rstatus=7";
			}
			else{
				sqltest+=" and rstatus=4";
			}
			temprentaltype="Monthly";
			stramountdecide="select rate tarif,cdw,pai,cdw1 scdw,pai1 spai,gps,babyseater,cooler,chaufchg chaufferchg,0 excesskm,0 exkmrte,exhrchg from gl_rtarif where rdocno="+agmtno+""+sqltest;
			ResultSet rsamountdecide=stmt.executeQuery(stramountdecide);
			while(rsamountdecide.next()){
				tarif=rsamountdecide.getDouble("tarif");
				cdw=rsamountdecide.getDouble("cdw");
				pai=rsamountdecide.getDouble("pai");
				scdw=rsamountdecide.getDouble("scdw");
				spai=rsamountdecide.getDouble("spai");
				gps=rsamountdecide.getDouble("gps");
				babyseater=rsamountdecide.getDouble("babyseater");
				cooler=rsamountdecide.getDouble("cooler");
				chaufferchg=rsamountdecide.getDouble("chaufferchg");
				exkmrte=rsamountdecide.getDouble("exkmrte");
				excesskm=rsamountdecide.getDouble("excesskm");
				exhrchg=rsamountdecide.getDouble("exhrchg");
			}
		}
		else{
			
			if(days<7){
				temprentaltype="Daily";
			}
			else if(days>=7 && days<monthcalvalue){
				temprentaltype="Weekly";
			}
			if(temprentaltype.equalsIgnoreCase(rentaltype)){
				sqltest+=" and rstatus=7";
			}
			else{
				sqltest+=" and rentaltype='"+temprentaltype+"' and rstatus<>5";
			}
			tempnum=days/7;
			weeknumber=(int)tempnum;
			daysnumber=((int)days)-(weeknumber*7);
			
			tempnumcdw=cdwdays/7;
			weeknumbercdw=(int)tempnumcdw;
			daysnumbercdw=((int)cdwdays)-(weeknumbercdw*7);
			
			tempnumpai=paidays/7;
			weeknumberpai=(int)tempnumpai;
			daysnumberpai=((int)paidays)-(weeknumberpai*7);
			
			tempnumcdw1=cdw1days/7;
			weeknumbercdw1=(int)tempnumcdw1;
			daysnumbercdw1=((int)cdw1days)-(weeknumbercdw1*7);
			
			tempnumpai1=pai1days/7;
			weeknumberpai1=(int)tempnumpai1;
			daysnumberpai1=((int)pai1days)-(weeknumberpai1*7);
			
			/*stramountdecide="select (("+weeknumber+"*rate)+((coalesce("+daysnumber+",0))*rate)) tarif,(("+weeknumbercdw+"*cdw)+((coalesce("+daysnumbercdw+",0))*cdw)) cdw,"+
				"(("+weeknumberpai+"*pai)+((coalesce("+daysnumberpai+",0))*pai)) pai,(("+weeknumbercdw1+"*cdw1)+((coalesce("+daysnumbercdw1+",0))*cdw1)) scdw,"+
				"(("+weeknumberpai1+"*pai1)+((coalesce("+daysnumberpai1+",0))*pai1)) spai,(("+weeknumber+"*gps)+((coalesce("+daysnumber+",0))*gps)) gps,"+
				"(("+weeknumber+"*babyseater)+((coalesce("+daysnumber+",0))*babyseater)) babyseater,(("+weeknumber+"*cooler)+((coalesce("+daysnumber+",0))*cooler)) cooler,"+
				"(("+weeknumber+"*chaufchg)+((coalesce("+daysnumber+",0))*chaufchg)) chaufferchg,("+totalkm+"-(("+weeknumber+"*kmrest)+((coalesce("+daysnumber+",0))*kmrest)))*exkmrte exkmrte,"+
				" ("+totalkm+"-(("+weeknumber+"*kmrest)+((coalesce("+daysnumber+",0))*kmrest))) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
			*/
			
			if(weeknumber>0){
				String sqltest2="";
				if(temprentaltype.equalsIgnoreCase("Weekly") && temprentaltype.equalsIgnoreCase(rentaltype)){
					sqltest2=" and rstatus=7";
				}
				else{
					sqltest2=" and rstatus=2";
				}
				stramountdecide="select (("+weeknumber+"*rate)) tarif,(("+weeknumbercdw+"*cdw)) cdw,"+
						"(("+weeknumberpai+"*pai)) pai,(("+weeknumbercdw1+"*cdw1)) scdw,"+
						"(("+weeknumberpai1+"*pai1)) spai,(("+weeknumber+"*gps)) gps,"+
						"(("+weeknumber+"*babyseater)) babyseater,(("+weeknumber+"*cooler)) cooler,"+
						"(("+weeknumber+"*chaufchg)) chaufferchg,("+totalkm+"-(("+weeknumber+"*kmrest))*exkmrte) exkmrte,"+
						" ("+totalkm+"-(("+weeknumber+"*kmrest))) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+sqltest2;
				System.out.println(stramountdecide);
				ResultSet rsamountdecideweek=stmt.executeQuery(stramountdecide);
				while(rsamountdecideweek.next()){
					tarif=rsamountdecideweek.getDouble("tarif");
					cdw=rsamountdecideweek.getDouble("cdw");
					pai=rsamountdecideweek.getDouble("pai");
					scdw=rsamountdecideweek.getDouble("scdw");
					spai=rsamountdecideweek.getDouble("spai");
					gps=rsamountdecideweek.getDouble("gps");
					babyseater=rsamountdecideweek.getDouble("babyseater");
					cooler=rsamountdecideweek.getDouble("cooler");
					chaufferchg=rsamountdecideweek.getDouble("chaufferchg");
					exkmrte=rsamountdecideweek.getDouble("exkmrte");
					excesskm=rsamountdecideweek.getDouble("excesskm");
					exhrchg=rsamountdecideweek.getDouble("exhrchg");
				}
			}
			if(daysnumber>0){
				String sqltest2="";
				if(temprentaltype.equalsIgnoreCase("Daily") && temprentaltype.equalsIgnoreCase(rentaltype)){
					sqltest2=" and rstatus=7";
				}
				else{
					sqltest2=" and rstatus=1";
				}
				stramountdecide="select (("+daysnumber+"*rate)) tarif,(("+daysnumbercdw+"*cdw)) cdw,"+
						"(("+daysnumberpai+"*pai)) pai,(("+daysnumbercdw1+"*cdw1)) scdw,"+
						"(("+daysnumberpai1+"*pai1)) spai,(("+daysnumber+"*gps)) gps,"+
						"(("+daysnumber+"*babyseater)) babyseater,(("+daysnumber+"*cooler)) cooler,"+
						"(("+daysnumber+"*chaufchg)) chaufferchg,("+totalkm+"-(("+daysnumber+"*kmrest))*exkmrte) exkmrte,"+
						" ("+totalkm+"-(("+daysnumber+"*kmrest))) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+sqltest2;
				System.out.println(stramountdecide);
				ResultSet rsamountdecideday=stmt.executeQuery(stramountdecide);
				while(rsamountdecideday.next()){
					tarif+=rsamountdecideday.getDouble("tarif");
					cdw+=rsamountdecideday.getDouble("cdw");
					pai+=rsamountdecideday.getDouble("pai");
					scdw+=rsamountdecideday.getDouble("scdw");
					spai+=rsamountdecideday.getDouble("spai");
					gps+=rsamountdecideday.getDouble("gps");
					babyseater+=rsamountdecideday.getDouble("babyseater");
					cooler+=rsamountdecideday.getDouble("cooler");
					chaufferchg+=rsamountdecideday.getDouble("chaufferchg");
					exkmrte+=rsamountdecideday.getDouble("exkmrte");
					excesskm+=rsamountdecideday.getDouble("excesskm");
					exhrchg+=rsamountdecideday.getDouble("exhrchg");
				}
			}
		}
		/*System.out.println("Tarif: "+tarif);
		System.out.println(weeknumber+" Weeks and "+daysnumber+" Days");
		String strkm="";
		int rentalno=0;
		System.out.println("TempRentalType: "+temprentaltype);
		if(temprentaltype.equalsIgnoreCase("Daily")){
			rentalno=1;
		}
		else if(temprentaltype.equalsIgnoreCase("Weekly")){
			rentalno=7;
		}
		else if(temprentaltype.equalsIgnoreCase("Monthly")){
			rentalno=monthcalvalue;
		}
		System.out.println("Days: "+days);
		System.out.println("Rental : "+rentalno);
		strkm="select ("+totalkm+"-("+(days/rentalno)+"*kmrest))*exkmrte exkmrte,("+totalkm+"-("+(days/rentalno)+"*kmrest)) excesskm,exhrchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
		System.out.println(strkm);
		ResultSet rskm=stmt.executeQuery(strkm);
		while(rskm.next()){
			excesskm=rskm.getDouble("excesskm");
			exkmrte=rskm.getDouble("exkmrte");
		}*/
		java.sql.Date sqlagmtdate=null;
if(!agmtdate.equalsIgnoreCase("") && agmtdate!=null){
	sqlagmtdate=objcommon.changeStringtoSqlDate(agmtdate);
}		
		
/*
Statement stmtexcesskm=conn.createStatement();
int monthdiff=0,daysdiff=0;
double allowedkm1=0.0,allowedkm2=0.0,totalallowedkm=0.0;
java.sql.Date monthuptodate=null;
System.out.println("Testing");
int excessrentalno=0;
java.sql.Date sqlagmtdate=null;

if(rentaltype.equalsIgnoreCase("Daily") || rentaltype.equalsIgnoreCase("Weekly")){
	if(rentaltype.equalsIgnoreCase("Daily")){
		excessrentalno=1;
	}
	else if(rentaltype.equalsIgnoreCase("Weekly")){
		excessrentalno=7;
	}
	String strdaysdiff="select datediff('"+sqlclosedate+"','"+sqlagmtdate+"') daysdiff";
	System.out.println(strdaysdiff);
	ResultSet rsdaysdiff=stmtexcesskm.executeQuery(strdaysdiff);
	while(rsdaysdiff.next()){
		daysdiff=rsdaysdiff.getInt("daysdiff");
	}
	String strallowedkm="select kmrest*("+daysdiff+"/"+excessrentalno+") allowedkm2 from gl_rtarif where rdocno="+agmtno+sqltest;
	System.out.println(strallowedkm);
	ResultSet rsallowedkm=stmtexcesskm.executeQuery(strallowedkm);
	while(rsallowedkm.next()){
		allowedkm2=rsallowedkm.getDouble("allowedkm2");
	}
	totalallowedkm=allowedkm2;
}
else if(rentaltype.equalsIgnoreCase("Monthly")){
	
	String strmonthdiff="SELECT TIMESTAMPDIFF(MONTH,'"+sqlagmtdate+"','"+sqlclosedate+"') monthdiff,day(last_day('"+sqlclosedate+"')) closelastday";
	System.out.println(strmonthdiff);
	ResultSet rsmonthdiff=stmtexcesskm.executeQuery(strmonthdiff);
	while(rsmonthdiff.next()){
		monthdiff=rsmonthdiff.getInt("monthdiff");
		if(monthcalmethod==1){
			excessrentalno=rsmonthdiff.getInt("closelastday");
		}
		else{
			excessrentalno=monthcalvalue;
		}
	}
	String strmonthadd="select date_add('"+sqlagmtdate+"',interval "+monthdiff+" month) monthadddate";
	System.out.println(strmonthadd);
	ResultSet rsmonthadd=stmtexcesskm.executeQuery(strmonthadd);
	while(rsmonthadd.next()){
		monthuptodate=rsmonthadd.getDate("monthadddate");
	}
	String strdaysdiff="select datediff('"+sqlclosedate+"','"+monthuptodate+"') daysdiff";
	System.out.println(strdaysdiff);
	ResultSet rsdaysdiff=stmtexcesskm.executeQuery(strdaysdiff);
	while(rsdaysdiff.next()){
		daysdiff=rsdaysdiff.getInt("daysdiff");
	}
	System.out.println("Days Diff: "+daysdiff);
	String strallowedkm="select kmrest*("+daysdiff+"/"+excessrentalno+") allowedkm2,kmrest*"+monthdiff+" allowedkm1 from gl_rtarif where rdocno="+agmtno+sqltest;
	System.out.println(strallowedkm);
	ResultSet rsallowedkm=stmtexcesskm.executeQuery(strallowedkm);
	while(rsallowedkm.next()){
		allowedkm1=rsallowedkm.getDouble("allowedkm1");
		allowedkm2=rsallowedkm.getDouble("allowedkm2");
	}
	totalallowedkm=allowedkm1+allowedkm2;
	
}
System.out.println("Total Km"+totalkm);
System.out.println("Total Allowed Km"+totalallowedkm);
excesskm=(Double.parseDouble(totalkm)-totalallowedkm);
String strexcesskmrate="select round("+excesskm+",2) excesskm,round(round("+excesskm+",2)*exkmrte,2) exkmrte from gl_rtarif where rdocno="+agmtno+sqltest;
System.out.println(strexcesskmrate);
ResultSet rsexcesskmrate=stmtexcesskm.executeQuery(strexcesskmrate);
while(rsexcesskmrate.next()){
	excesskm=rsexcesskmrate.getDouble("excesskm");
	exkmrte=rsexcesskmrate.getDouble("exkmrte");
}
*/

		int monthno=0,weekno=0,dayno=0;
		java.sql.Date sqlextraclosedate=null;
		Statement stmtexcesskm=conn.createStatement();
		String strextraclosedate="select if("+cal+"=1,date_add('"+sqlclosedate+"',interval 1 day),'"+sqlclosedate+"') extraclosedate";
		ResultSet rsextraclosedate=stmtexcesskm.executeQuery(strextraclosedate);
		while(rsextraclosedate.next()){
			sqlextraclosedate=rsextraclosedate.getDate("extraclosedate");
		}
		CallableStatement stmtexcesscall = conn.prepareCall("{CALL DateDifference(?,?,?,?,?)}");
		stmtexcesscall.setDate(1, sqlagmtdate);
		stmtexcesscall.setDate(2, sqlextraclosedate);
		stmtexcesscall.registerOutParameter(3, java.sql.Types.INTEGER);
		stmtexcesscall.registerOutParameter(4, java.sql.Types.INTEGER);
		stmtexcesscall.registerOutParameter(5, java.sql.Types.INTEGER);
		stmtexcesscall.execute();
		monthno=stmtexcesscall.getInt("finalmonthno");
		weekno=stmtexcesscall.getInt("finalweekno");
		dayno=stmtexcesscall.getInt("finaldayno");
		System.out.println(sqlagmtdate+"/////"+sqlextraclosedate);
		System.out.println("Month No: "+monthno);
		System.out.println("Week No: "+weekno);
		System.out.println("Day No: "+dayno);
		double totalallowedkm=0.0,remainingkm=0.0;
		double dailykmrest=0.0,weeklykmrest=0.0,monthlykmrest=0.0,dailykmrate=0.0,weeklykmrate=0.0,monthlykmrate=0.0;
		String strexcesskm="select (select kmrest from gl_rtarif where rdocno="+agmtno+" and rstatus=1) dailykmrest,"+
		" (select kmrest from gl_rtarif where rdocno="+agmtno+" and rstatus=2) weeklykmrest,"+
		" (select kmrest from gl_rtarif where rdocno="+agmtno+" and rstatus=3) monthlykmrest,"+
		" (select exkmrte from gl_rtarif where rdocno="+agmtno+" and rstatus=1) dailykmrate,"+
		" (select exkmrte from gl_rtarif where rdocno="+agmtno+" and rstatus=2) weeklykmrate,"+
		" (select exkmrte from gl_rtarif where rdocno="+agmtno+" and rstatus=3) monthlykmrate";
		ResultSet rsexcesskm=stmtexcesskm.executeQuery(strexcesskm);
		while(rsexcesskm.next()){
			dailykmrest=rsexcesskm.getDouble("dailykmrest");
			weeklykmrest=rsexcesskm.getDouble("weeklykmrest");
			monthlykmrest=rsexcesskm.getDouble("monthlykmrest");
			dailykmrate=rsexcesskm.getDouble("dailykmrate");
			weeklykmrate=rsexcesskm.getDouble("weeklykmrate");
			monthlykmrate=rsexcesskm.getDouble("monthlykmrate");
		}
		if(monthno>0){
			totalallowedkm+=(monthno*monthlykmrest);
		}
		if(weekno>0){
			totalallowedkm+=(weekno*weeklykmrest);
		}
		if(dayno>0){
			totalallowedkm+=(dayno*dailykmrest);
		}
		remainingkm=Double.parseDouble(totalkm)-totalallowedkm;
		
		String strcalculatekm="select if("+remainingkm+">0,"+remainingkm+"*exkmrte,0) exkmrte from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
		ResultSet rscalculatekm=stmtexcesskm.executeQuery(strcalculatekm);
		while(rscalculatekm.next()){
			exkmrte=rscalculatekm.getDouble("exkmrte");
		}
		if(exkmrte<0){
			exkmrte=0.0;
		}
		//Setting 30% Discount of Rate on 12-03-2017
		double normalrate=0.0,discountrate=0.0,netrate=0.0;
		String strdiscountrate="select a.rate,a.discountrate,a.rate-a.discountrate netrate from (select "+tarif+" rate,("+tarif+"*(30/100)) discountrate )a";
		ResultSet rsdiscountrate=stmt.executeQuery(strdiscountrate);
		while(rsdiscountrate.next()){
			normalrate=rsdiscountrate.getDouble("rate");
			discountrate=rsdiscountrate.getDouble("discountrate");
			netrate=rsdiscountrate.getDouble("netrate");
		}
		System.out.println(strdiscountrate);
		String strgrace="select '"+temprentaltype+"' rentaltype,if("+drate+">0,round("+normalrate+",0),0) rate,if("+dcdw+">0,round("+cdw+",0),0) cdw,if("+dpai+">0,"+
		" round("+pai+",0),0) pai,if("+dcdw1+">0,round("+scdw+",0),0) cdw1,if("+dpai1+">0,round("+spai+",0),0) pai1,if("+dgps+">0,round("+gps+",0),0) gps,"+
		" if("+dbabyseater+">0,round("+babyseater+",0),0) babyseater,if("+dcooler+">0,round("+cooler+",0),0) cooler,if("+dchaufchg+">0,"+
		" round("+chaufferchg+",0),0) chaufchg,if("+dexhrchg+">0,"+finalhours+"*exhrchg,0) exhrchg,round(if("+dexkmrte+">0,"+exkmrte+",0),2) exkmrte,"+
		" round("+remainingkm+",2) excesskm,'"+calctype+"' calctype,"+finalhours+" finalhours from gl_rtarif where rdocno="+agmtno+sqltest+
		" union select 'Discount' rentaltype,"+discountrate+" rate,0.00 cdw,0.00 pai,0.00 cdw1,0.00 pai1,0.00 gps,0.00 babyseater,0.00 cooler,0.00 chaufchg,0.00 exhrchg,"+
		" 0.00 exkmrte,0 excesskm,'"+calctype+"' calctype,"+finalhours+" finalhours from gl_rtarif where rdocno="+agmtno+sqltest+
		"  union select 'Net Total' rentaltype,if("+drate+">0,round("+netrate+",0),0) rate,if("+dcdw+">0,round("+cdw+",0),0) cdw,if("+dpai+">0,round("+pai+",0),0) pai,"+
		" if("+dcdw1+">0,round("+scdw+",0),0) cdw1,if("+dpai1+">0,round("+spai+",0),0) pai1,if("+dgps+">0,round("+gps+",0),0) gps,if("+dbabyseater+">0,"+
		" round("+babyseater+",0),0) babyseater,if("+dcooler+">0,round("+cooler+",0),0) cooler,if("+dchaufchg+">0,round("+chaufferchg+",0),0) chaufchg,"+
		" if("+dexhrchg+">0,"+finalhours+"*exhrchg,0) exhrchg,round(if("+dexkmrte+">0,"+exkmrte+",0),2) exkmrte,round("+remainingkm+",2) excesskm,'"+calctype+"' calctype,"+
		" "+finalhours+" finalhours from gl_rtarif where rdocno="+agmtno+sqltest;
		System.out.println("Final Query"+strgrace);
		ResultSet rsfinal=stmt.executeQuery(strgrace);
		totaldata=objcommon.convertToJSON(rsfinal);
		stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return totaldata;
		
	}
}
