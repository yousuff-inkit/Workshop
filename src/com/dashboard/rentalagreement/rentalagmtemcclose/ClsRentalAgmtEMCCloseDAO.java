package com.dashboard.rentalagreement.rentalagmtemcclose;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

import net.sf.json.JSONArray;

public class ClsRentalAgmtEMCCloseDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public   JSONArray clientSearch(HttpSession session,String clname,String mob,String lcno,String passno,String nation,String dob,String idno) throws SQLException {
	   	 JSONArray RESULTDATA=new JSONArray();
/*
	   
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
	   	        
	    	   
	      String brid=session.getAttribute("BRANCHID").toString();
	     	*/
	    	
	    
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    
	    	if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = objcommon.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and c.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and (c.per_mob like '%"+mob+"%' or d.mobno like '%"+mob+"%')  ";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno like '%"+lcno+"%'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no like '%"+passno+"%'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like '%"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	    	if(!idno.equalsIgnoreCase("")){
		    	sqltest=sqltest+" and d.visano='"+idno+"'";
		    } 
	    	 Connection conn=null;
			try {
					 conn = objconn.getMyConnection();
					Statement stmtVeh8 = conn.createStatement ();
	            	
					int method=0;
					
					String chk="select method  from gl_config where field_nme='Clientinvchk'";
					ResultSet rs=stmtVeh8.executeQuery(chk); 
					if(rs.next())
					{
						
						method=rs.getInt("method");
					}
					
					
					
					
					
			/*		String clsql= ("select distinct a.pcase,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(coalesce(a.address,''),'  ',coalesce(a.address2,'')) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ "left join gl_drdetails d on d.cldocno=a.cldocno where a.dtype='CRM' and a.status=3 " +sqltest);
					String clsql= ("select distinct "+method+" method, a.advance,a.invc_method,a.pcase,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(coalesce(a.address,''),'  ',coalesce(a.address2,'')) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ "left join gl_drdetails d on d.cldocno=a.cldocno and d.dtype=a.dtype where a.dtype='CRM' and a.status=3 " +sqltest);*/
				
					String clsql= ("select distinct "+method+" method,d.visano idno,coalesce(round(a.balance,2),0) outstanding,c.cldocno,c.advance,c.invc_method,c.pcase,d.dob,d.dlno,d.nation,"+
					" d.name drname,c.contactPerson,c.mail1,trim(c.RefName) RefName,c.per_mob,concat(coalesce(c.address,''),'  ',coalesce(c.address2,'')) as address ,"+
					" c.per_tel,c.codeno,c.acno,m.doc_no,trim(m.sal_name) sal_name from my_acbook c left join ("+
					" select sum(j.dramount) balance,j.acno from my_jvtran j left join my_head h on h.doc_no=j.acno and h.atype='AR' where"+
					" j.status=3 and j.yrid=0 group by j.acno) a on c.acno=a.acno left join my_salm m on c.sal_id=m.doc_no and m.status<>7"+
					" left join gl_drdetails d on d.cldocno=c.cldocno and d.dtype=c.dtype where c.dtype='CRM' and c.status=3 " +sqltest);
					
					//System.out.println("-------------"+clsql);
						
		
					
					ResultSet resultSet = stmtVeh8.executeQuery(clsql);
					
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtVeh8.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	
	public JSONArray getAgmtData(String branch,String date,String id) throws SQLException{
		JSONArray agmtdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return agmtdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("") && date!=null){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqldate!=null){
				sqltest+=" and agmt.date<='"+sqldate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			String str="select coalesce(veh.calibrationkm,0)+coalesce(veh.cur_km,0) totalkm,agmt.doc_no,agmt.voc_no,ac.refname,veh.flname,veh.reg_no,veh.fleet_no,agmt.odate outdate,agmt.otime outtime,agmt.okm outkm,agmt.emcjobcard,agmt.emccourtesydays,"+
			" agmt.emcrate,agmt.ddate duedate,agmt.dtime duetime from gl_ragmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
			" gl_vehmaster veh on agmt.fleet_no=veh.fleet_no where agmt.status=3 and agmt.clstatus=0"+sqltest;
			ResultSet rs=stmt.executeQuery(str);
			agmtdata=objcommon.convertToJSON(rs);
			return agmtdata;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return agmtdata;
	}
	public int insert(String cmbbranch, Date sqlindate, String intime,
			String inkm, String cmbinfuel, String total, String courtesy,
			String amount, String discount, String netamount, String salikamt,
			String saliksrvcamt, String trafficamt, String trafficsrvcamt,
			String salikcount, String trafficcount, HttpSession session, 
			HttpServletRequest request, String mode, String formdetailcode,
			String agmtno,String useddays,String usedhours) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int rentalacno=0,salikacno=0,trafficacno=0,saliksrvcacno=0,trafficsrvcacno=0,courtesyacno=0,clientacno=0,cldocno=0,fleetno=0,discountacno=0;
			double outkm=0.0;
			java.sql.Date sqloutdate=null;
			String stracno="select (select acno from gl_invmode where idno=1) rentalacno,(select acno from gl_invmode where idno=8) salikacno,"+
			" (select acno from gl_invmode where idno=9) trafficacno,(select acno from gl_invmode where idno=14) saliksrvcacno,"+
			" (select acno from gl_invmode where idno=15) trafficsrvcacno,(select acno from gl_invmode where idno=27) courtesyacno,"+
			" (select head.doc_no from gl_ragmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') inner "+
			" join my_head head on ac.acno=head.doc_no where agmt.doc_no="+agmtno+") clientacno,(select agmt.cldocno from gl_ragmt "+
			" agmt where agmt.doc_no="+agmtno+") cldocno,(select agmt.fleet_no from gl_ragmt agmt where agmt.doc_no="+agmtno+") fleetno,"+
			" (select acno from gl_invmode where idno=13) discountacno,(select agmt.okm from gl_ragmt agmt where agmt.doc_no="+agmtno+") outkm,"+
			" (select agmt.odate from gl_ragmt agmt where agmt.doc_no="+agmtno+") outdate";
			//System.out.println(stracno);
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				rentalacno=rsacno.getInt("rentalacno");
				salikacno=rsacno.getInt("salikacno");
				trafficacno=rsacno.getInt("trafficacno");
				saliksrvcacno=rsacno.getInt("saliksrvcacno");
				trafficsrvcacno=rsacno.getInt("trafficsrvcacno");
				courtesyacno=rsacno.getInt("courtesyacno");
				clientacno=rsacno.getInt("clientacno");
				cldocno=rsacno.getInt("cldocno");
				fleetno=rsacno.getInt("fleetno");
				discountacno=rsacno.getInt("discountacno");
				outkm=rsacno.getInt("outkm");
				sqloutdate=rsacno.getDate("outdate");
			}
			
			ArrayList<String> invoicearray=new ArrayList<>();
			invoicearray.add("1"+"::"+rentalacno+"::"+" "+"::"+useddays+"::"+Double.parseDouble(total)+"::"+Double.parseDouble(total));
			invoicearray.add("27"+"::"+courtesyacno+"::"+" "+"::"+useddays+"::"+courtesy+"::"+courtesy);
			if(Double.parseDouble(discount)>0){
				invoicearray.add("13"+"::"+discountacno+"::"+" "+"::"+useddays+"::"+discount+"::"+discount);
			}
			if(Double.parseDouble(salikamt)>0){
				invoicearray.add("8"+"::"+salikacno+"::"+" "+"::"+salikcount+"::"+"4"+"::"+salikamt);	
				invoicearray.add("14"+"::"+saliksrvcacno+"::"+" "+"::"+salikcount+"::"+"1"+"::"+saliksrvcamt);	
			}
			if(Double.parseDouble(trafficamt)>0){
				invoicearray.add("9"+"::"+trafficacno+"::"+" "+"::"+trafficcount+"::"+trafficamt+"::"+trafficamt);	
				invoicearray.add("15"+"::"+trafficsrvcacno+"::"+" "+"::"+trafficcount+"::"+trafficsrvcamt+"::"+trafficsrvcamt);
			}
			double totalkm=Double.parseDouble(inkm)-outkm;
			String userid=session.getAttribute("USERID").toString();
			String currencyid=session.getAttribute("CURRENCYID").toString();
			int invoiceval=emcInvoiceInsert(conn, invoicearray, "RAG", sqlindate, cldocno, agmtno, "", "", sqloutdate, sqlindate, 
			cmbbranch, userid, currencyid, mode, clientacno, "INV###3", "INV", "",Double.parseDouble(netamount));
			//Closing Part
			if(invoiceval<=0){
				conn.close();
				return 0;
			}
			String invoicevoucher=getInvoiceVoucher(conn,invoiceval);
			System.out.println("Inv Voucher:"+invoicevoucher);
			if(!invoicevoucher.equalsIgnoreCase("")){
				request.setAttribute("INVVOUCHER", invoicevoucher);
			}
			System.out.println("Inv Voucher:"+request.getAttribute("INVVOUCHER").toString());
			CallableStatement stmtClose = conn.prepareCall("{call rentalCloseDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtClose.registerOutParameter(22, java.sql.Types.INTEGER);
			stmtClose.registerOutParameter(26, java.sql.Types.INTEGER);
			stmtClose.setDate(1,sqlindate);
			 stmtClose.setString(2,agmtno);
			 stmtClose.setString(3,cldocno+"");
			 stmtClose.setString(4,"0");
			 stmtClose.setString(5,"0");
			 stmtClose.setString(6,"0");
			 stmtClose.setString(7,"0");
			 stmtClose.setDate(8,null);
			 stmtClose.setString(9,"0");
			 stmtClose.setString(10,"0");
			 stmtClose.setString(11,"0");
			 stmtClose.setDouble(12,Double.parseDouble(useddays));
			 stmtClose.setString(13,usedhours);
			 stmtClose.setString(14,totalkm+"");
			 stmtClose.setString(15,"0");
			 stmtClose.setString(16,inkm);
			 stmtClose.setString(17,cmbinfuel);
			 stmtClose.setDate(18,sqlindate);
			 stmtClose.setString(19,intime);
			 stmtClose.setString(20,session.getAttribute("USERID").toString());
			 stmtClose.setString(21,cmbbranch);
			 stmtClose.setString(23,mode);
			 stmtClose.setInt(24,fleetno);
			 stmtClose.setDouble(25,Double.parseDouble("0.0"));
			 stmtClose.setString(27,cmbbranch);
			 stmtClose.setString(28,"0");
			 stmtClose.setString(29,"");
			 stmtClose.executeQuery();
			 docno=stmtClose.getInt("docNo");
			 int voucherno=stmtClose.getInt("voucherno");
			 request.setAttribute("VOUCHERNO", voucherno);
			 if(docno<=0){
				System.out.println("////////////////Main Document Error/////////////");
				conn.close();
				return 0;
			}
			
			int movdoc=0;
			String selectmovdoc="select doc_no from gl_vmove where rdocno='"+agmtno+"' and rdtype='RAG' and status='OUT'";
			ResultSet rsselectmovdoc=stmt.executeQuery(selectmovdoc);
			while(rsselectmovdoc.next()){
				movdoc=rsselectmovdoc.getInt("doc_no");
			}
			String sqltotal="";
			
				sqltotal="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60  totalmin from (select  cast(concat('"+sqlindate+"',' ','"+intime+"')"+
						" as datetime) ts_din, cast(concat(dout,' ',tout)as datetime)ts_dout,kmout,fout from gl_vmove where"+
						" doc_no='"+movdoc+"' )m";
			
			//System.out.println("Totalmin Query"+sqltotal);
			ResultSet rstotal=stmt.executeQuery(sqltotal);
			double totalmin=0.0;
			while(rstotal.next()){
				totalmin=rstotal.getDouble("totalmin");
			}
			
			String sql="update gl_ragmt set clstatus=1 where doc_no="+agmtno;
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
				String strlocid="select min(doc_no) doc_no from my_locm where brhid="+cmbbranch+" and status<>7";
				ResultSet rslocid=stmtloc.executeQuery(strlocid);
				int closelocid=0;
				while(rslocid.next()){
					closelocid=rslocid.getInt("doc_no");
				}
				//closelocid=Integer.parseInt(closelocation);
				Statement stmtveh=conn.createStatement();
				//(select if(dtype='VEH','UR','NR'))
				String strveh="update gl_vehmaster set status='IN',tran_code='UR',a_br="+cmbbranch+",a_loc="+closelocid+"  where fleet_no="+fleetno;
				int vehval=stmtveh.executeUpdate(strveh);
				if(vehval<=0){
					System.out.println("////////////////Vehicle Master Error/////////////");
					conn.close();
					return 0;
				}
				Statement stmtac=conn.createStatement();
				String strac="update my_acbook set rostatus=if(rostatus=0,0,rostatus-1)  where cldocno="+cldocno+" and dtype='CRM'";
//				System.out.println("Acbook str:"+strac);
				int acval=stmtac.executeUpdate(strac);
				if(acval<0){
					System.out.println("////////////////my_acbook Error/////////////");
					conn.close();
					return 0;
				}
				stmtac.close();
				String strmov="";
				
					strmov="update gl_vmove set status='IN',din='"+sqlindate+"',tin='"+intime+"',kmin='"+inkm+"',fin='"+cmbinfuel+"',"+
							"ibrhid='"+cmbbranch+"',ilocid="+closelocid+",ireason='Rental Close',iaccident=0,"+
							" ttime='"+totalmin+"',tkm=(select "+inkm+"-kmout ),tfuel=(select "+cmbinfuel+"-fout )where doc_no="+movdoc+" and rdtype='RAG'";
				
//					System.out.println("Mov Update Query"+strmov);
				int movval=stmt.executeUpdate(strmov);
				if(movval<0){
					System.out.println("////////////////Update Vmove Error/////////////");
					conn.close();
					return 0;
				}
		
				conn.commit();
				return docno;
			}
		return 0;
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		finally{
			conn.close();
		}
		
	}
	
	
	private String getInvoiceVoucher(Connection conn, int invoiceval) throws SQLException {
		// TODO Auto-generated method stub
		String voucher="";
		try{
			Statement stmt=conn.createStatement();
			String strvoucher="select coalesce(voc_no,'') voc_no from gl_invm where doc_no="+invoiceval;
			ResultSet rsvoucher=stmt.executeQuery(strvoucher);
			while(rsvoucher.next()){
				voucher=rsvoucher.getString("voc_no");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return voucher;
	}
	public int emcInvoiceInsert(Connection connold, ArrayList<String> invoicearray, String cmbagmttype, Date sqlindate, int hidclient, String agmtno, 
			String ledgernote, String invoicenote, Date sqloutdate, Date sqlindate2, String cmbbranch, String userid, String currencyid, String mode,
			int clientacno, String dtype, String formdetailcode, String qty2,double amount) throws SQLException{
			int aaa=0;
			try{
				double courtesyamt=0.0,discountamt=0.0;
				int courtesyacno=0,discountacno=0;
				java.sql.Date date=sqlindate;
				 int salikcount=0,trafficcount=0;
				 String salikqty="",trafficqty="";
				 ClsManualInvoiceDAO invdao=new ClsManualInvoiceDAO();
				int invdescconfig=0;
				ClsManualInvoiceBean invoicebean=new ClsManualInvoiceBean();
				String note="";
				note=ledgernote;

				int invoicetypeno=0;	//For Determining from where it was invoiced

				int advance=0,invtypeno=0;	//For Determining Month End Advance
				String rtype="";
				String salikdesc="";
				String trafficdesc="";
				Statement stmtacperiod=connold.createStatement();
				java.sql.Date duedate=null;
				duedate=sqlindate;
				String origin=dtype.contains("###")?dtype.split("###")[1]:"";
				String damagedtype=dtype.contains("###")?dtype.split("###")[0]:"";
				String damageinspno="";
				if(damagedtype.equalsIgnoreCase("IND")){
					invoicetypeno=6;
					damageinspno=dtype.split("###")[1];
					//origin="";

				}
				else{
					invoicetypeno=Integer.parseInt(dtype.contains("###")?dtype.split("###")[1]:"");
				}
				//	System.out.println("Invoice Type Code: "+invoicetypeno);
				int agmtvocno=0;
				String agmtrefno="";
				Statement stmtagmtvoc=connold.createStatement();
				String stragmtvoc="";
				String agmtregno="";
				String agmtplate="";
				if(cmbagmttype.equalsIgnoreCase("RAG")){
					stragmtvoc="select agmt.voc_no,coalesce(agmt.refno,'') refno,veh.reg_no,plt.code_name from gl_ragmt agmt left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.doc_no="+agmtno;
				}
				else if(cmbagmttype.equalsIgnoreCase("LAG")){
					stragmtvoc="select agmt.voc_no,coalesce(agmt.refno,'') refno,veh.reg_no,plt.code_name from gl_lagmt agmt left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no)  left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.doc_no="+agmtno;
				}
				if(!stragmtvoc.equalsIgnoreCase("")){
					ResultSet rsagmtvocno=stmtagmtvoc.executeQuery(stragmtvoc);
					while(rsagmtvocno.next()){
						agmtvocno=rsagmtvocno.getInt("voc_no");
						agmtrefno=rsagmtvocno.getString("refno");
						agmtregno=rsagmtvocno.getString("reg_no");
						agmtplate=rsagmtvocno.getString("code_name");
					}
				}


				double damageamount=0.0;
				String strdelchg="";
				String straddrchg="";
				java.sql.Date tempfromdate=null;
				int testtrno=0;
				//System.out.println(date+"//////"+hidclient+"////"+agmtno+"///"+cmbagmttype);

				String stracperiod="select DATE_ADD(if("+sqlindate+" is null,null,'"+sqlindate+"'), INTERVAL (select period2 from my_acbook where cldocno="+hidclient+" and dtype='CRM') DAY) duedate";
				//System.out.println(stracperiod);
				ResultSet rsacperiod=stmtacperiod.executeQuery(stracperiod);
				while(rsacperiod.next()){
					duedate=rsacperiod.getDate("duedate");
				}
				//System.out.println("Duedate:"+duedate);
				tempfromdate=sqloutdate;
				if(!(origin.trim().equalsIgnoreCase("1"))){

					if(cmbagmttype.equalsIgnoreCase("RAG")){
						strdelchg="select (select if(delivery=1,coalesce(delchg,0),0) from gl_ragmt where doc_no="+agmtno+" and del_invno=0) del,(select acno from gl_invmode where idno=6) delacno ";
						straddrchg="select (select coalesce(if(addr=1,addrchg,0),0) addrchg from gl_ragmt where doc_no="+agmtno+" and addr_invno=0 and clstatus=0) addrchg,(select acno from gl_invmode where idno=12) others";
					}
					else if(cmbagmttype.equalsIgnoreCase("LAG")){
						strdelchg="select (select if(delivery=1,coalesce(delchg,0),0) from gl_lagmt where doc_no="+agmtno+" and del_invno=0) del,(select acno from gl_invmode where idno=6) delacno ";
						straddrchg="select (select coalesce(if(addr=1,addrchg,0),0) addrchg from gl_lagmt where doc_no="+agmtno+" and addr_invno=0 and clstatus=0) addrchg,(select acno from gl_invmode where idno=12) others";

					}
					else{

					}
					double delchg=0.0;
					int delacno=0;
					Statement stmtdelchg=connold.createStatement();
					ResultSet rsdelchg=stmtdelchg.executeQuery(strdelchg);
					while(rsdelchg.next()){
						delchg=rsdelchg.getDouble("del");
						delacno=rsdelchg.getInt("delacno");
					}
					stmtdelchg.close();
					double addrchg=0.0;
					int othersacno=0;
					Statement stmtaddrchg=connold.createStatement();
					ResultSet rsaddrchg=stmtaddrchg.executeQuery(straddrchg);
					while(rsaddrchg.next()){
						addrchg=rsaddrchg.getDouble("addrchg");
						othersacno=rsaddrchg.getInt("others");
					}
					int delflag=0,addrflag=0;
					for(int z=0;z<invoicearray.size();z++){
						String strcheckdel=invoicearray.get(z).split("::")[0];
						if(strcheckdel.equalsIgnoreCase("6")){
							delflag=1;
							break;
						}
					}
					for(int z=0;z<invoicearray.size();z++){
						String strcheckaddr=invoicearray.get(z).split("::")[0];
						if(strcheckaddr.equalsIgnoreCase("12")){
							addrflag=1;
							break;
						}
					}
					if(delchg>0 && delflag==0 && (!formdetailcode.equalsIgnoreCase("INS") && !formdetailcode.equalsIgnoreCase("INT"))){
						invoicearray.add("6"+"::"+delacno+"::"+note+"::1::"+delchg+"::"+delchg);
					}
					if(addrchg>0 && addrflag==0 && (!formdetailcode.equalsIgnoreCase("INS") && !formdetailcode.equalsIgnoreCase("INT"))){
						invoicearray.add("12"+"::"+othersacno+"::"+note+"::1::"+addrchg+"::"+addrchg);
					}

					//dtype=session.getAttribute("Code").toString();

					Statement stmtcheck=connold.createStatement();
					String strcheck="";
					//Adds 1 Date to From Date if invoice type is Monthly 
					if(invoicearray.get(0).split("::")[0].toString().equalsIgnoreCase("1")){
						if(cmbagmttype.equalsIgnoreCase("RAG") ){
							strcheck="select if((select '"+sqloutdate+"')>agmt.odate,DATE_ADD('"+sqloutdate+"',INTERVAL 1 DAY),(select '"+sqloutdate+"')) fromdate from"+
									" gl_ragmt agmt where  agmt.doc_no="+agmtno+" and agmt.invtype=1";
						}
						if(cmbagmttype.equalsIgnoreCase("LAG")){
							/*strcheck="select if((select count(*) from gl_invm inv left join gl_lagmt agmt on inv.rano=agmt.doc_no where inv.status<>7 and inv.rano="+agmtno+""+
							" and inv.ratype='LAG' and agmt.inv_type=1)>0,(select DATE_ADD('"+fromdate+"',INTERVAL 1 DAY)),(select '"+fromdate+"')) fromdate";*/

							strcheck="select if((select '"+sqloutdate+"')>agmt.outdate,DATE_ADD('"+sqloutdate+"',INTERVAL 1 DAY),(select '"+sqloutdate+"')) fromdate from"+
									" gl_lagmt agmt where  agmt.doc_no="+agmtno+" and agmt.inv_type=1";
						}
						System.out.println("Invoice Date Check Query:"+strcheck);
						ResultSet rscheck=stmtcheck.executeQuery(strcheck);
						if(rscheck.next()){
							tempfromdate=rscheck.getDate("fromdate");
						}
					}


					if(cmbagmttype.equalsIgnoreCase("RAG")){
						note=objcommon.changeSqltoString(tempfromdate) +" to "+objcommon.changeSqltoString(sqlindate) +" for Rental Agreement no "+agmtvocno;
						rtype=" in ('RA','RD','RW','RF','RM')";
						salikdesc="Salik Invoice for Rental Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
						trafficdesc="Traffic Invoice for Rental Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
					}
					else if(cmbagmttype.equalsIgnoreCase("LAG")){
						note=objcommon.changeSqltoString(tempfromdate) +" to "+objcommon.changeSqltoString(sqlindate) +" for Lease Agreement no "+agmtvocno;
						rtype=" in ('LA','LC')";
						salikdesc="Salik Invoice for Lease Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
						trafficdesc="Traffic Invoice for Lease Agreement "+agmtvocno+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
					}
					
					if(invoicetypeno==6 && invdescconfig==1){
						String strdamagefleet="select insp.rfleet fleet_no,insp.reftype,veh.reg_no,plt.code_name from gl_vinspm insp left join gl_vehmaster veh on insp.rfleet=veh.fleet_no left join gl_vehplate plt on veh.pltid=plt.doc_no where insp.doc_no="+damageinspno;
						ResultSet rsdamagefleet=stmtcheck.executeQuery(strdamagefleet);
						String  damagefleet="";
						String agmtreftype="";
						String damageregno="";
						String damageplate="";
						while(rsdamagefleet.next()){
							damagefleet=rsdamagefleet.getString("fleet_no");
							agmtreftype=rsdamagefleet.getString("reftype");
							damageregno=rsdamagefleet.getString("reg_no");
							damageplate=rsdamagefleet.getString("code_name");
						}
						String damageagmttype="";
						if(agmtreftype.equalsIgnoreCase("RAG")){
							damageagmttype="Rental";
						}
						else if(agmtreftype.equalsIgnoreCase("LAG")){
							damageagmttype="Lease";
						}
						note=" Damage Invoice for fleet "+damagefleet+" of "+damageagmttype+" Agreement "+agmtvocno+" with Reg No "+damageregno+" and Plate Code "+damageplate;
					}

					
					if(!agmtrefno.equalsIgnoreCase("")){
						note+=" ("+agmtrefno+")";
					}
					
					if(invdescconfig==1 && invoicetypeno!=6){
						note+=" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
					}

					//Checking Agreement is Monthend Advance
					String stradv="";
					if(cmbagmttype.equalsIgnoreCase("RAG")){
						stradv="select invtype,advchk from gl_ragmt where doc_no="+agmtno;
					}
					else if(cmbagmttype.equalsIgnoreCase("LAG")){
						stradv="select inv_type invtype,adv_chk advchk from gl_lagmt where doc_no="+agmtno;
					}
					Statement stmtadv=connold.createStatement();
					ResultSet rsadv=stmtadv.executeQuery(stradv);
					while(rsadv.next()){
						advance=rsadv.getInt("advchk");
						invtypeno=rsadv.getInt("invtype");
					}




					if(advance==1 && invtypeno==1 && (origin.equalsIgnoreCase("2") || origin.equalsIgnoreCase("3") || origin.equalsIgnoreCase("4") || origin.equalsIgnoreCase("5"))){
						date=tempfromdate;
					}

				}//Closing for Origin
				CallableStatement stmtManual = connold.prepareCall("{call invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				if(invdescconfig==1){
					if(formdetailcode.equalsIgnoreCase("INS")){
						for(int i=0;i< invoicearray.size();i++){
							String[] invoice=invoicearray.get(i).split("::");
							if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
								salikqty=invoice[3];
							}
						}
						String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
						//Overridden for WORLDRAC on 04/05/2017
						String strfromdate="",strtodate="";
						if(sqloutdate!=null){
							strfromdate=objcommon.changeSqltoString(sqloutdate);
						}
						if(sqlindate!=null){
							strtodate=objcommon.changeSqltoString(sqlindate);
						}
						note=salikqty+" Saliks of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
					}
					else if(formdetailcode.equalsIgnoreCase("INT")){
						for(int i=0;i< invoicearray.size();i++){
							String[] invoice=invoicearray.get(i).split("::");
							if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
								trafficqty=invoice[3];
							}
						}
						String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
						//Overridden for WORLDRAC on 04/05/2017
						String strfromdate="",strtodate="";
						if(sqloutdate!=null){
							strfromdate=objcommon.changeSqltoString(sqloutdate);
						}
						if(sqlindate!=null){
							strtodate=objcommon.changeSqltoString(sqlindate);
						}
						note=trafficqty+" Traffics of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno+" and Plate Code "+agmtplate;
					}
				}
				
				stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
				stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
				stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
				stmtManual.setDate(1,date);
				stmtManual.setString(2,cmbagmttype);
				stmtManual.setString(3,hidclient+"");
				stmtManual.setInt(4, Integer.parseInt(agmtno));
				stmtManual.setString(5,note);
				stmtManual.setString(6,note);
				stmtManual.setString(7,currencyid);
				stmtManual.setString(8,clientacno+"");
				stmtManual.setDate(9,tempfromdate);
				stmtManual.setDate(10,sqlindate);
				stmtManual.setString(11,formdetailcode);
				stmtManual.setString(12,userid);
				stmtManual.setString(13,cmbbranch);
				stmtManual.setString(16,mode);
				//		System.out.println(stmtManual);
				stmtManual.executeQuery();
				aaa=stmtManual.getInt("docNo");
				testtrno=stmtManual.getInt("vtrNo");
				//request.setAttribute("tranno", testtrno);
				//	System.out.println("inv vocno"+stmtManual.getInt("voucher"));
				Statement stmtinvoice;
				int testcurid=0;
				double testcurrate=0.0;
				stmtinvoice = connold.createStatement();
				//System.out.println("Currency"+currencyid);

				ResultSet rscurr=stmtinvoice.executeQuery("select c_rate,doc_no from my_curr where doc_no='"+currencyid+"'");
				if(rscurr.next()){
					testcurid=rscurr.getInt("doc_no");
					testcurrate=rscurr.getDouble("c_rate");
				}
				else{
					System.out.println("Currency Error");
					return 0;
				}


				Statement stmtupdatemanual=connold.createStatement();
				String strupdatemanual="update gl_invm set manual="+invoicetypeno+" where doc_no="+aaa;
				int updatemanual=stmtupdatemanual.executeUpdate(strupdatemanual);
				if(updatemanual<0){
					return 0;
				}

				double salikamt=0.0,trafficamt=0.0,generalamt=0.0;
				double otherincome=0.0;
				double salikldr=0.0,trafficldr=0.0,generalldr=0.0;
				double smsamount=0.0;
				int srno=1,ismssend=0;
				int tempno=1;
				for(int i=0;i< invoicearray.size();i++){

					String[] invoice=invoicearray.get(i).split("::");
					//System.out.println(Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString()));
					//System.out.println(testcurrate);
					/*double testldramt=testcurrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
					double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
					partydramt=objcommon.Round(partydramt, 2);
					double partyldramt=testldramt*-1;
					//double testamt=(double)invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5];
					//System.out.println("Invoice[5]:"+invoice[5]);
					String strqty=invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?"0":invoice[3];
					String temptot=invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?"0":invoice[5];
					String temprate=invoice[4].equalsIgnoreCase("undefined") || invoice[4].isEmpty()?"0":invoice[4];
					if(invoice[0].equalsIgnoreCase("10")){
						damageamount=Double.parseDouble(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?"0":invoice[5]);
						//System.out.println("Dmg Amt: "+damageamount+"////"+invoice[4]+"////"+invoice[5]);
					}*/
					
					double totalamt=0.0;
					if(invoice[0].equalsIgnoreCase("13") || invoice[0].equalsIgnoreCase("27")){
						totalamt=Double.parseDouble(invoice[5])*-1;
						if(invoice[0].equalsIgnoreCase("13")){
							discountamt=Double.parseDouble(invoice[5]);
							discountacno=Integer.parseInt(invoice[1]);
						}
						else if(invoice[0].equalsIgnoreCase("27")){
							courtesyamt=Double.parseDouble(invoice[5]);
							courtesyacno=Integer.parseInt(invoice[1]);
						}
					}
					else{
						totalamt=Double.parseDouble(invoice[5]);
					}
						 String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+cmbbranch+"','"+aaa+"'"+
								 ",'"+testtrno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?"0":invoice[3])+"',"+totalamt+",'"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+totalamt+")";
						 System.out.println(" Invd Sql"+sql);
						 int resultSet = stmtinvoice.executeUpdate (sql);
						 if(resultSet>0){


							 if((!origin.trim().equalsIgnoreCase("1"))){
								 if((Integer.parseInt(invoice[0])==9)|| (Integer.parseInt(invoice[0])==15)){

									 ismssend=1;
									 smsamount=smsamount+Double.parseDouble(invoice[5]);

								 }
							 }


							 if(!(origin.trim().equalsIgnoreCase("1"))){
								 if(invoice[0].equalsIgnoreCase("12") && Double.parseDouble(invoice[5])>0){
									 Statement stmtupdateaddr=connold.createStatement();
									 String strupdateaddr="";
									 if(cmbagmttype.equalsIgnoreCase("RAG")){
										 strupdateaddr="update gl_ragmt set addr_invno="+aaa+" where doc_no="+agmtno;
									 }
									 else if(cmbagmttype.equalsIgnoreCase("LAG")){
										 strupdateaddr="update gl_lagmt set addr_invno="+aaa+" where doc_no="+agmtno;
									 }
									 int updateval=stmtupdateaddr.executeUpdate(strupdateaddr);
									 if(updateval<0){
										 return 0;
									 }
									 stmtupdateaddr.close();
								 }


								 if(invoice[0].equalsIgnoreCase("6") && Double.parseDouble(invoice[5])>0){
									 String strdelivery="";
									 Statement stmtdelivery=connold.createStatement();
									 if(cmbagmttype.equalsIgnoreCase("RAG")){
										 strdelivery="update gl_ragmt set del_invno="+aaa+" where doc_no="+agmtno;
									 }
									 else if(cmbagmttype.equalsIgnoreCase("LAG")){
										 strdelivery="update gl_lagmt set del_invno="+aaa+" where doc_no="+agmtno;
									 }
									 int delval=stmtdelivery.executeUpdate(strdelivery);
									 if(delval<=0){
										 return 0;
									 }
								 }
							 }//Closing for Origin
							 if(cmbagmttype.equalsIgnoreCase("RAG")){
								 String strSqlrcalc="";
								 if(!(origin.trim().equalsIgnoreCase("1"))){
									 strSqlrcalc="insert into gl_rcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+cmbbranch+"','"+testtrno+"',"+
											 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";
								 }
								 else{
									 strSqlrcalc="insert into gl_rcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+cmbbranch+"','"+testtrno+"',"+
											 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
								 }

								 //System.out.println(strSqlrcalc);
								 int rcalcval=stmtinvoice.executeUpdate(strSqlrcalc);

								 if(rcalcval<=0){
									 System.out.println("Rcalc Error");
									 return 0;
								 }


							 }
							 if(cmbagmttype.equalsIgnoreCase("LAG")){
								 String strSqlrcalc="";
								 if(!(origin.trim().equalsIgnoreCase("1"))){
									 strSqlrcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty)values('"+cmbbranch+"','"+testtrno+"',"+
											 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"')";
								 }
								 else{
									 strSqlrcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+cmbbranch+"','"+testtrno+"',"+
											 "'"+agmtno+"','"+cmbagmttype+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+aaa+"','"+date+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
								 }
								 //System.out.println(strSqlrcalc);
								 int rcalcval=stmtinvoice.executeUpdate(strSqlrcalc);

								 if(rcalcval<=0){
									 System.out.println("Lcalc Error");
									 return 0;
								 }
							 }
						 }
						 else{
							 System.out.println("Invd Error");
							 return 0;
						 }
						 double invtype=0;
						 String todatecalc="";
						 int monthcalmethod=0;
						 int monthcalvalue=0;
						 //		System.out.println("Origin: "+origin+"//////");

						 //Extra Block for updating agmt invtodate in case of agreement started in monthend
						 Statement stmtdelcal=connold.createStatement();
						 int delcal=0;
						 //Deciding outddate or deliverydate
						 String strdelcal="select method from gl_config where field_nme='delcal'";
						 ResultSet rsdelcal=stmtdelcal.executeQuery(strdelcal);

						 while(rsdelcal.next()){
							 delcal=rsdelcal.getInt("method");
						 }
						 String strcheckdate="";
						 java.sql.Date temptodate=null;
						 //when delivery date must be considered
						 if(delcal==0){
							 if(cmbagmttype.equalsIgnoreCase("RAG")){
								 strcheckdate="select if(delivery=1 and delstatus=1,(select min(din) from gl_vmove where rdocno="+agmtno+" and rdtype='RAG' and "+
										 " trancode='DL' and repno=0),odate) temptodate from gl_ragmt where doc_no="+agmtno;	
							 }
							 else if(cmbagmttype.equalsIgnoreCase("LAG")){
								 strcheckdate="select if(delivery=1 and delstatus=1,(select min(din) from gl_vmove where rdocno="+agmtno+" and rdtype='LAG' and "+
										 "  trancode='DL' and repno=0),outdate) temptodate from gl_lagmt where doc_no="+agmtno;	
							 }

						 }
						 //When Outdate is considered
						 else{
							 if(cmbagmttype.equalsIgnoreCase("RAG")){
								 strcheckdate="select odate temptodate from gl_ragmt where doc_no="+agmtno;
							 }
							 else if(cmbagmttype.equalsIgnoreCase("LAG")){
								 strcheckdate="select outdate temptodate from gl_lagmt where doc_no="+agmtno;
							 }
						 }
						 //System.out.println("Check Date Query: "+strcheckdate);
						 ResultSet rstemptodate=stmtdelcal.executeQuery(strcheckdate);
						 while(rstemptodate.next()){
							 temptodate=rstemptodate.getDate("temptodate");
						 }

						 int samedatestatus=0;
						 String strchecksame="";
						 int startday=0;
						 int closestatus=0;
						 //System.out.println("Check invtype: "+invtype);
						 if(cmbagmttype.equalsIgnoreCase("RAG")){
							 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select invtype,clstatus from gl_ragmt where doc_no="+agmtno);
							 if(rsgetinvtype.next()){
								 invtype=rsgetinvtype.getDouble("invtype");
								 closestatus=rsgetinvtype.getInt("clstatus");
							 }
						 }
						 else if(cmbagmttype.equalsIgnoreCase("LAG")){
							 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select inv_type,clstatus from gl_lagmt where doc_no="+agmtno);
							 if(rsgetinvtype.next()){
								 invtype=rsgetinvtype.getDouble("inv_type");
								 closestatus=rsgetinvtype.getInt("clstatus");
							 }
						 }



						 if(invtype==2){
							 //Checking Out Date and Month End of Out date is same
							 strchecksame="select if('"+temptodate+"'=last_day('"+temptodate+"'),1,0) samedatestatus,day('"+temptodate+"') startday";
							 //System.out.println("Check Same Date Query: "+strchecksame);
							 ResultSet rssamedatestatus=stmtdelcal.executeQuery(strchecksame);
							 while(rssamedatestatus.next()){
								 samedatestatus=rssamedatestatus.getInt("samedatestatus");
								 startday=rssamedatestatus.getInt("startday");
							 }
						 }
						 //Extra Block for updating agmt invtodate in case of agreement started in monthend Ends





						 if(!(origin.trim().equalsIgnoreCase("1"))){
							 if(cmbagmttype.equalsIgnoreCase("RAG") &&  invoice[0].equalsIgnoreCase("1") && Double.parseDouble(invoice[5])>0){
								 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select invtype from gl_ragmt where doc_no="+agmtno);
								 if(rsgetinvtype.next()){
									 invtype=rsgetinvtype.getDouble("invtype");
								 }
								 //Overridden for EMC
								 invtype=1;
								 String tempdate="'"+sqlindate+"'";
								 String sqlra="";
								 if(cmbagmttype.equalsIgnoreCase("RAG")){
									 sqlra="select method,value from GL_CONFIG WHERE FIELD_NME='monthlycal'";
								 }
								 else{
									 sqlra="select method,value from GL_CONFIG WHERE FIELD_NME='lesmonthlycal'";
								 }

								 ResultSet rsgetmonthcal=stmtinvoice.executeQuery(sqlra);
								 while(rsgetmonthcal.next()){
									 monthcalmethod=rsgetmonthcal.getInt("method");
									 monthcalvalue=rsgetmonthcal.getInt("value");
								 }
								 if(monthcalmethod==1){
									 if(invtype==1){
										 todatecalc="SELECT LAST_DAY(DATE_ADD('"+sqlindate+"',INTERVAL 1 month))";
									 }
									 if(invtype==2){
										 todatecalc="DATE_ADD('"+sqlindate+"',INTERVAL 1 month)";
									 }
								 }
								 else if(monthcalmethod==0){
									 if(invtype==1){
										 todatecalc="SELECT LAST_DAY(DATE_ADD('"+sqlindate+"',INTERVAL 1 month))";
									 }
									 if(invtype==2){
										 todatecalc="DATE_ADD('"+sqlindate+"',INTERVAL '"+monthcalvalue+"' DAY)";
									 }
									 /*todatecalc="SELECT DATE_ADD('"+todate+"',INTERVAL '"+monthcalvalue+"' DAY)";*/
								 }

								 //Checks Out Date and MonthEnd is same
								 if(samedatestatus==1  && invtype==2 && monthcalmethod==0){

									 todatecalc="select LAST_DAY(("+todatecalc+"))";

									 todatecalc="select  if("+startday+">(select day(("+todatecalc+"))),"+
											 " (SELECT DATE_ADD('"+sqlindate+"',INTERVAL 1 month)),(select LAST_DAY((SELECT DATE_ADD('"+sqlindate+"',INTERVAL 1 month)))))";	

								 }
								 if(samedatestatus==0){
									 if(invtype==2){
										if(monthcalmethod==1){
										 int remainday=0;
										 int sameday=0;
										 //	System.out.println("Todatecalc b4: "+todatecalc);
										 Statement stmtremain=connold.createStatement();
										 //	System.out.println(startday);
										 String check="select if("+startday+">(select day(("+todatecalc+"))),"+startday+"-(select day(("+todatecalc+"))),0) remainday,if(day("+todatecalc+")=day(last_day("+todatecalc+")),1,0) sameday";

										 //System.out.println("Get Remainday Query: "+check);
										 ResultSet rsremain=stmtremain.executeQuery(check);
										 while(rsremain.next()){
											 remainday=rsremain.getInt("remainday");
											 sameday=rsremain.getInt("sameday");
										 }
										 if(sameday==1){
											 //	System.out.println("Inside Lastday");
											 todatecalc="select last_day("+todatecalc+")";
										 }
										 else if(remainday>0){
											 todatecalc="select date_add("+todatecalc+",interval "+remainday+" day)";
											 //System.out.println("check todatecalc: "+todatecalc);
										 }
										 else {
											 //	System.out.println("/////////Else//////////");
										 }

										 stmtremain.close();
										}
									}
								 }

								 //			System.out.println("Final Todatecalc: "+todatecalc);
							if(invtype!=3){
								 if(closestatus==0){
									 String strupdate="update gl_ragmt set invdate='"+sqlindate+"',invtodate=("+todatecalc+") where doc_no="+agmtno;
									 System.out.println("Update Query"+strupdate);
									 int agmtupdate=stmtinvoice.executeUpdate(strupdate);
									 //System.out.println("Agmt Update Value"+agmtupdate);
									 if(agmtupdate<0){
										 System.out.println("Update Ragmt Error");
										 return 0;
									 }
								 }
							}	 
							 }



							 if(cmbagmttype.equalsIgnoreCase("LAG")  && invoice[0].equalsIgnoreCase("1")  && Double.parseDouble(invoice[5])>0){
								 ResultSet rsgetinvtype=stmtinvoice.executeQuery("select inv_type from gl_lagmt where doc_no="+agmtno);
								 if(rsgetinvtype.next()){
									 invtype=rsgetinvtype.getInt("inv_type");
								 }
								 String tempdate="'"+sqlindate+"'";
								 ResultSet rsgetmonthcal=stmtinvoice.executeQuery("select method,value from GL_CONFIG WHERE FIELD_NME='monthlycal'");
								 while(rsgetmonthcal.next()){
									 monthcalmethod=rsgetmonthcal.getInt("method");
									 monthcalvalue=rsgetmonthcal.getInt("value");
								 }
								 if(monthcalmethod==1){
									 if(invtype==1){
										 todatecalc="SELECT LAST_DAY(DATE_ADD('"+sqlindate+"',INTERVAL 1 month))";
									 }
									 if(invtype==2){
										 todatecalc="DATE_ADD('"+sqlindate+"',INTERVAL 1 month)";
									 }
								 }
								 else if(monthcalmethod==0){
									 if(invtype==1){
										 todatecalc="SELECT LAST_DAY(DATE_ADD('"+sqlindate+"',INTERVAL 1 month))";
									 }
									 if(invtype==2){
										 todatecalc="DATE_ADD('"+sqlindate+"',INTERVAL '"+monthcalvalue+"' DAY)";
									 }
								 }

								 if(samedatestatus==1 && invtype==2 && monthcalmethod==0){
									 todatecalc="select LAST_DAY(("+todatecalc+"))";

									 todatecalc="select if("+startday+">(select day(("+todatecalc+"))),"+
											 " (SELECT DATE_ADD('"+sqlindate+"',INTERVAL 1 month)),(select LAST_DAY((SELECT DATE_ADD('"+sqlindate+"',INTERVAL 1 month)))))";	

								 }

								 /*if(samedatestatus==0){
						if(invtype==2){
						int remainday=0;
						int sameday=0;
						Statement stmtremain=connold.createStatement();
						String check="select if("+startday+">(select day(("+todatecalc+"))),"+startday+"-(select day(("+todatecalc+"))),0) remainday,if(day("+todatecalc+")=day(last_day("+todatecalc+")),1,0) sameday";

						System.out.println("Get Remainday Query: "+check);
						ResultSet rsremain=stmtremain.executeQuery(check);
						while(rsremain.next()){
							remainday=rsremain.getInt("remainday");
							sameday=rsremain.getInt("sameday");
						}
						if(sameday==1){
							todatecalc="select last_day("+todatecalc+")";
						}
						else if(remainday>0){
							todatecalc="select date_add("+todatecalc+",interval "+remainday+" day)";
								System.out.println("check todatecalc: "+todatecalc);
						}
						else {
							System.out.println("/////////Else//////////");
						}

						stmtremain.close();

					}
					}*/



								 if(closestatus==0){
									 String strupdate="update gl_lagmt set invdate='"+sqlindate+"',invtodate=("+todatecalc+") where doc_no="+agmtno;

									 int agmtupdate=stmtinvoice.executeUpdate(strupdate);
									 if(agmtupdate<0){
										 System.out.println("Lagmt Error");
										 return 0;
									 }
								 }
							 }

							 if(!(origin.trim().equalsIgnoreCase("1"))){
								 if(invoice[0].equalsIgnoreCase("18") && Double.parseDouble(invoice[5])>0){
									 Statement stmtotherincome=connold.createStatement();
									 //System.out.println("Inside Other Income Update SQL");
									 String strotherincome="update gl_lothser set invno="+aaa+",invstatus=1 where rdocno="+agmtno+" and invstatus=0";
									 int otherincomeval=stmtotherincome.executeUpdate(strotherincome);
									 if(otherincomeval<0){
										 //				System.out.println("OtherIncome Update error");
										 //connold.close();
										 System.out.println(" Update Other Income Error");
										 return 0;
									 }
								 }

							 }

						 }//Closing for Origin



						 if(invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("14")){
							 salikamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
							 salikcount++;
							 salikqty=invoice[3];
						 }

						 else if(invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("15")){
							 trafficamt+=Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5]));
							 trafficcount++;
							 trafficqty=invoice[3];
						 }
						 //trafficldr=testcurrate*trafficamt;

						 else{
							 if(invoice[0].equalsIgnoreCase("13") || invoice[0].equalsIgnoreCase("27")){
								 System.out.println("General Amount:"+invoice[5]);
								 generalamt=objcommon.Round(generalamt+Double.parseDouble((String) (invoice[5].equalsIgnoreCase("undefined")?0:invoice[5])),2);
							 }

							 System.out.println("Check General Amount:"+generalamt);
						 }
						 salikldr=testcurrate*salikamt;
						 trafficldr=testcurrate*trafficamt;
						 generalldr=testcurrate*generalamt;
						 totalamt=0.0;
						 double ltotalamt=0.0;
						 String sqljv2="";
						 int rsjv2=0;
						 if(invoice[0].equalsIgnoreCase("1") || invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("14") || invoice[0].equalsIgnoreCase("15")){
							 if(invoice[0].equalsIgnoreCase("1") || invoice[0].equalsIgnoreCase("8") || invoice[0].equalsIgnoreCase("9") || invoice[0].equalsIgnoreCase("14") || invoice[0].equalsIgnoreCase("15")){
								 totalamt=Double.parseDouble(invoice[5])*-1;
							 }
							 else{
								 totalamt=Double.parseDouble(invoice[5]);
							 }
							 ltotalamt=totalamt*testcurrate;
						 sqljv2="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								 "doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+testtrno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
								 "'"+totalamt+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(i+1)+"',"+
								 "'"+cmbbranch+"','"+note+"',"+
								 "0,'"+date+"','INV','"+ltotalamt+"','"+aaa+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
								 "'"+testcurid+"','5',1,0,3,'"+agmtno+"','"+cmbagmttype+"')";
						 System.out.println("SqlJV2"+sqljv2);
						 rsjv2=stmtinvoice.executeUpdate(sqljv2);
						 }
						 if(rsjv2>0){

							 Statement stmtcostentry=connold.createStatement();
							 String strcostentry="select costentry from gl_invmode where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1]);
							 int costentry=0;
							 ResultSet rscostentry=stmtcostentry.executeQuery(strcostentry);
							 while(rscostentry.next()){
								 costentry=rscostentry.getInt("costentry");
							 }
							 if(costentry==1){
								 Statement stmtgettran=connold.createStatement();
								 String strgettran="select tranid from my_jvtran where acno="+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+" and tr_no="+testtrno;
								 //	System.out.println("GetTran Query:"+strgettran);
								 ResultSet rsgettran=stmtgettran.executeQuery(strgettran);
								 int temptranid=0;
								 while(rsgettran.next()){
									 temptranid=rsgettran.getInt("tranid");
								 }
								 int count=0;
								 ArrayList<String> costmovarray=new ArrayList<String>();
								 Statement stmtcostmov=connold.createStatement();
								 double temptimediff=0.0;
								 String tempcostfleet="";
								 String strtemptimediff="select (TIMESTAMPDIFF(second,'"+sqloutdate+" 00:00:00' ,'"+sqlindate+" 23:59:59'))/(60*60) temptimediff";
								 Statement stmttemptimediff=connold.createStatement();
								 //			System.out.println("TemptimeDiff Sql:"+strtemptimediff);
								 ResultSet rstemptimediff=stmtcostmov.executeQuery(strtemptimediff);
								 while(rstemptimediff.next()){
									 temptimediff=rstemptimediff.getDouble("temptimediff");

								 }
								 //			System.out.println("TimeDiffer In Hours:"+temptimediff);
								 stmttemptimediff.close();
								 String strcostmov="";
								 if(damagedtype.equalsIgnoreCase("IND")){
									 strcostmov="select 0 hourdiff,rfleet fleet_no from gl_vinspm where doc_no="+damageinspno;
									 //System.out.println("Damage Get Cost Entry Query: "+strcostmov);
								 }
								 else{
									 strcostmov="select sum(aa.hourdiff) hourdiff,aa.fleet_no from("+
											 " select (TIMESTAMPDIFF(second,dout ,din))/(60*60) hourdiff,fleet_no,kk.repno from ("+
											 " select repno,fleet_no,if(dout<'"+sqloutdate+"',cast(concat('"+sqloutdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout) as datetime))"+
											 " dout,tout,if(din>'"+sqlindate+"',cast(concat('"+sqlindate+" 23:59:59') as datetime),cast(coalesce(concat(din,' ',tin),'"+sqlindate+" 23:59:59') as datetime)) din,tin"+
											 " from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"'  and trancode<>'DL'  and (dout between '"+sqloutdate+"' and '"+sqlindate+"' or  coalesce(din,'"+sqlindate+"')"+
											 " between '"+sqloutdate+"' and '"+sqlindate+"')) kk)aa group by aa.fleet_no ";
									 /*String strcostmov="select (TIMESTAMPDIFF(second,dout ,coalesce(din,'"+todate+"')))/(60*60) hourdiff,fleet_no,kk.repno from ("+
						" select repno,fleet_no,if(dout<'"+fromdate+"',cast(concat('"+fromdate+" 00:00:00') as datetime),cast(concat(dout,' ',tout)"+
						" as datetime)) dout,tout,if(din>'"+todate+"',cast(concat('"+todate+" 23:59:59') as datetime),cast(concat(din,' ',tin) as datetime))"+
						" din,tin from gl_vmove where rdocno="+agmtno+" and rdtype='"+cmbagmttype+"' and (dout between '"+fromdate+"' and '"+todate+"' or "+
						" coalesce(din,'"+todate+"') between '"+fromdate+"' and '"+todate+"') group by fleet_no )kk";*/
									 //System.out.println("Cost Mov Sql:"+strcostmov);
								 }
								 ResultSet rscostmov=stmtcostmov.executeQuery(strcostmov);
								 int counter=0;
								 while(rscostmov.next()){

									 //count=rscostmov.getInt("repno");
									 //	if(count==0){
									 costmovarray.add(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
									 //System.out.println(rscostmov.getString("hourdiff")+""+"::"+rscostmov.getString("fleet_no"));
									 counter++;
									 /*	}
					if(count>0){
						double tempamt=(Double.parseDouble(rscostmov.getString("hourdiff"))/temptimediff)*partydramt;
						costmovarray.add(tempamt+""+"::"+rscostmov.getString("fleet_no"));

					}*/


								 }
								 stmtcostmov.close();
								 Statement stmtcostinsert=connold.createStatement();
								 for(int j=0;j<costmovarray.size();j++){
									 //				System.out.println("============================================="+i);
									 if(counter==1){

										 String costmov=costmovarray.get(j);
										 String costmovamt=costmov.split("::")[0];
										 String costmovfleet=costmov.split("::")[1];
										 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
												 ",6,"+totalamt+","+srno+","+temptranid+",0,"+costmovfleet+","+testtrno+")";
										 //System.out.println("Insert Costtran Sql:"+strcostinsert);
										 srno++;
										 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
										 if(costinsertval<0){
											 //connold.close();
											 System.out.println("Cost Insert Error");
											 return 0;
										 }

									 }
									 else if(counter>1){
										 String costmov=costmovarray.get(j);
										 String costmovamt=costmov.split("::")[0];
										 String costmovfleet=costmov.split("::")[1];
										 double amt=(Double.parseDouble(costmovamt)/temptimediff)*totalamt;
										 //System.out.println("Total Amt:"+amt+":::costmovamt="+costmovamt+":::::::::TempTime Diff="+temptimediff+":::::::::Amount="+partydramt);
										 String strcostinsert="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values('"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"'"+
												 ",6,"+amt+","+srno+","+temptranid+",0,"+costmovfleet+","+testtrno+")";
										 //			System.out.println("Insert Costtran Sql:"+strcostinsert);
										 srno++;
										 int costinsertval=stmtcostinsert.executeUpdate(strcostinsert);
										 if(costinsertval<0){
											 //connold.close();
											 System.out.println("Cost Insert Error2");
											 return 0;
										 }

									 }
								 }
								 stmtcostinsert.close();

							 }
							 else{

							 }

						 }	

						 else{
							 //			System.out.println("General Jvtran error");
							 //connold.close();
							 System.out.println("Jvtran Error");
						//	 return 0;
						 }


					 //}
					 tempno++;	
				}

				if(ismssend>0){

					//sendSMS(aaa+"", cmbbranch, dtype, smsamount+"", hidclient,"",connold);

				}

				if(salikamt>0){
					//		System.out.println("SalikAMt: "+salikamt+"::::::::::::::::Origin: "+origin.trim().equalsIgnoreCase("")+"========="+origin.trim()+"////////");
					if(!(origin.trim().equalsIgnoreCase("1"))){
						Statement stmtsalik=connold.createStatement();
						//System.out.println("Heere inside salik");
						String strupdatesalik="";
						if(invoicetypeno==8){
							strupdatesalik="update gl_salik set inv_no="+aaa+",inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1 and rtype "+rtype+" and "+
									" sal_date>='"+sqloutdate+"' and sal_date<='"+sqlindate+"' and inv_no=0";	
						}
						else{
							strupdatesalik="update gl_salik set inv_no="+aaa+",inv_type='INV',status=1 where ra_no="+agmtno+" and  isallocated=1 and rtype "+rtype+" and "+
									" sal_date<='"+sqlindate+"' and inv_no=0";	
						}
						//		System.out.println("Update Salik:"+strupdatesalik);
						int val=stmtsalik.executeUpdate(strupdatesalik);
						if(val<0){
							System.out.println("Salik Update Error");
							//connold.close();

							return 0;
						}


					}//Closing for origin (salik update)
					String saliknote=""+salikqty+" Saliks";
					/*String saliknote=note;*/
					if(invdescconfig==1){
						String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
						//saliknote="Salik Charges "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno+" NOS - "+salikcount;
						//Overridden for WORLDRAC on 04/05/2017
						String strfromdate="",strtodate="";
						if(sqloutdate!=null){
							strfromdate=objcommon.changeSqltoString(sqloutdate);
						}
						if(sqlindate!=null){
							strtodate=objcommon.changeSqltoString(sqlindate);
						}
						saliknote=salikqty+" Saliks of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+""+" with Reg No "+agmtregno;
					}
					String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+clientacno+"',"+
							"'"+salikamt+"','"+testcurrate+"','"+testcurid+"',0,1,8,"+
							"'"+cmbbranch+"','"+saliknote+"',"+
							"0,'"+date+"','"+formdetailcode+"','"+salikldr+"','"+aaa+"','"+qty2+"',"+
							"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
					//System.out.println("SqlJV"+sqljv);
					int rsjv=stmtinvoice.executeUpdate(sqljv);
					if(rsjv>0){

					}
					else{
						System.out.println("Jvtran salik Error");
						return 0;
					}
				}

				if(trafficamt>0){
				//	System.out.println("==trafficamt==="+trafficamt);
				//	System.out.println("==origin.trim()==="+origin.trim());
					String temptrafficdesc="";
					if(!(origin.trim().equalsIgnoreCase("1"))){
						Statement stmttraffic=connold.createStatement();
						String strupdatetraffic="";
						if(invoicetypeno==9){
							strupdatetraffic="update gl_traffic set inv_no="+aaa+",inv_desc='"+trafficdesc+"',inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1  and rtype "+rtype+"  and traffic_date>='"+sqloutdate+"' and traffic_date <= '"+sqlindate+"' and inv_no=0";	
						}
						else{
							strupdatetraffic="update gl_traffic set inv_no="+aaa+",inv_desc='"+trafficdesc+"',inv_type='INV',status=1 where ra_no="+agmtno+" and isallocated=1  and rtype "+rtype+"  and traffic_date <= '"+sqlindate+"' and inv_no=0";
						}
//						System.out.println("strupdatetraffic :"+strupdatetraffic);
						//System.out.println("Update Traffic:"+strupdatetraffic);
						int val=stmttraffic.executeUpdate(strupdatetraffic);
						//System.out.println("Update Traffic Val:"+val+":::"+strupdatetraffic);
						if(val<0){
							System.out.println("Traffic Update Error");
							//connold.close();
							return 0;
						}
						
						
						try
						{
							String  traffic_date="";
							
							String sql="select concat(ticket_no,' - ',DATE_FORMAT(traffic_date, '%d-%m-%Y')) trafficdesc,concat(ticket_no,' REG.NO ',regno ,' at ',DATE_FORMAT(traffic_date, '%d-%m-%Y'),' ',time) as trdates from gl_traffic t where inv_no='"+aaa+"'";
							Statement stmt=connold.createStatement();
							ResultSet rs1 = stmt.executeQuery(sql);

//							System.out.println("select concat(ticket_no,' against ',regno,' at ',DATE_FORMAT(traffic_date, '%d-%m-%Y'),' ',time) as trdates from gl_traffic t where inv_no='"+aaa+"'");

							int k=0;
							while(rs1.next())
							{
								
								if(k==0){
									traffic_date=rs1.getString("trdates");
									temptrafficdesc+=rs1.getString("trafficdesc");
								}
								else{
									traffic_date=traffic_date+","+rs1.getString("trdates");
									temptrafficdesc+=","+rs1.getString("trafficdesc");
								}

								k++;

							}
							
							rs1.close();
							//sendSMS(aaa+"", cmbbranch, dtype, trafficamt+"", hidclient,traffic_date,connold);
						}catch(Exception e){e.printStackTrace();}


					}//Closing for origin (Traffic Update)

					String trafficnote=""+trafficqty+" Traffics";
					//String trafficnote=note;
					if(invdescconfig==1){
						// System.out.println("Inside Traffic Description");
						String temprenttype=cmbagmttype.equalsIgnoreCase("RAG")?"RA":"LA";
						//trafficnote=temptrafficdesc+" - "+temprenttype+" - "+agmtvocno+" MRA - "+agmtrefno;
						//Overridden for WORLDRAC on 04/05/2017
						String strfromdate="",strtodate="";
						if(sqloutdate!=null){
							strfromdate=objcommon.changeSqltoString(sqloutdate);
						}
						if(sqlindate!=null){
							strtodate=objcommon.changeSqltoString(sqlindate);
						}
						trafficnote=trafficqty+" Traffics of "+temprenttype+" - "+agmtvocno+" from "+strfromdate+" to "+strtodate+" with Reg No "+agmtregno;
					}
					// System.out.println("description ==== "+trafficnote);
					String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+clientacno+"',"+
							"'"+trafficamt+"','"+testcurrate+"','"+testcurid+"',0,1,9,"+
							"'"+cmbbranch+"','"+trafficnote+"',"+
							"0,'"+date+"','"+formdetailcode+"','"+trafficldr+"','"+aaa+"','"+qty2+"',"+
							"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
					//	System.out.println("SqlJV"+sqljv);
					int rsjv=stmtinvoice.executeUpdate(sqljv);
					if(rsjv>0){

					}
					else{
						System.out.println("Jvtran Traffic Error");
						//connold.close();
						return 0;
					}
				}


				//Tax Portion Starts Here
				//	System.out.println("Default General Amount:"+generalamt);
				generalamt+=amount;
				generalldr=generalamt*testcurrate;
				if(!(origin.trim().equalsIgnoreCase("1"))){
					Statement stmtchecktax=connold.createStatement();
					String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+hidclient+" and dtype='CRM') clienttaxmethod";
					//System.out.println(strchecktax);
					ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
					int taxstatus=0;
					int clienttaxmethod=0;
					while(rschecktax.next()){
						taxstatus=rschecktax.getInt("taxmethod");
						clienttaxmethod=rschecktax.getInt("clienttaxmethod");
					}
					int igststatus=0;
					if(taxstatus==1 && clienttaxmethod==1){
							//System.out.println("Inside TaxDetail");
						String strigst="select igststatus from gl_ragmt where doc_no="+agmtno;
						ResultSet rsigst=stmtchecktax.executeQuery(strigst);
						while(rsigst.next()){
							igststatus=rsigst.getInt("igststatus");
						}
						// Getting amount in which tax is applicable
						Statement stmtgettax=connold.createStatement();
						String strtaxapplied="select total from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+aaa;
						ResultSet rsapplied=stmtgettax.executeQuery(strtaxapplied);
						double generalamttax=0.0;
						while(rsapplied.next()){
							generalamttax+=rsapplied.getDouble("total");
						}	
						String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+date+"' between tax.fromdate and tax.todate";
						double setpercent=0.0;
						double vatpercent=0.0;
						ResultSet rsgettax=stmtgettax.executeQuery(strgettax);
						double vatval=0.0,setval=0.0;
						ArrayList<String> temptaxarray=new ArrayList<>();
						while(rsgettax.next()){
							setpercent=rsgettax.getDouble("set_per");
							vatpercent=rsgettax.getDouble("vat_per");
							vatval=(generalamttax*(vatpercent/100));
							setval=generalamttax*(setpercent/100);
							setval=objcommon.Round(setval, 2);
							vatval=objcommon.Round(vatval, 2);
							//System.out.println("SET:"+setval);
							//System.out.println("VAT:"+vatval);
							if(igststatus==1){
								if(rsgettax.getInt("idno")==21){
									if(setval>0.0){
										temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+setval+"::"+rsgettax.getString("description"));
										generalamt+=setval;
									}
								}
							}
							else{
								if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
									if(vatval>0.0){
										temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
										generalamt+=vatval;
									}
								}
							}
						}
						/*for(int z=0;z<temptaxarray.size();z++){
							System.out.println(temptaxarray.get(z));
						}*/
						if(setpercent>0.0 || vatpercent>0.0){
							
							/*if(damageamount>0){
								//System.out.println("Damage amount: "+damageamount+"//////General Amount: "+generalamt);
								vatval=((generalamt-damageamount)*(vatpercent/100));	

							}
							else{
								vatval=(generalamttax*(vatpercent/100));
							}*/
							
							//generalamt=generalamt+setval;

							generalamt=objcommon.Round(generalamt, 2);

							
						//	generalamt=generalamt+vatval;
							generalamt=objcommon.Round(generalamt, 2);
							generalldr=generalamt*testcurrate;

							Statement stmtgetinvmode=connold.createStatement();
							/*String strgetinvmode="select (select acno from gl_invmode where idno=19) setacno,(select acno from gl_invmode where idno=20) vatacno";
							ResultSet rsinvmode=stmtgetinvmode.executeQuery(strgetinvmode);
							
							while(rsinvmode.next()){
								temptaxarray.add(19+"::"+rsinvmode.getString("setacno")+"::"+setval+"::"+"SET");
								temptaxarray.add(20+"::"+rsinvmode.getString("vatacno")+"::"+vatval+"::"+"VAT");
							}*/
							int tempsrno=invoicearray.size()+1;
							for(int j=0;j<temptaxarray.size();j++){
								String[] tax=temptaxarray.get(j).split("::");
								Statement stmttaxinvd=connold.createStatement();
								if(Double.parseDouble(tax[2])>0){
									String strtaxinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+cmbbranch+"','"+aaa+"'"+
											",'"+testtrno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
												//System.out.println("Invd Sql:"+strtaxinvd);
									int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
									if(taxinvdval>0){
										String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
										"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+testtrno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
										"'"+Double.parseDouble(tax[2])*-1+"','"+testcurrate+"','"+testcurid+"',0,-1,'"+(tempsrno)+"',"+
										"'"+cmbbranch+"','"+note+"',"+
										"0,'"+date+"','"+formdetailcode+"','"+(Double.parseDouble(tax[2])*testcurrate)*-1+"','"+aaa+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
										"'"+testcurid+"','5',1,'"+hidclient+"',3,'"+agmtno+"','"+cmbagmttype+"')";
										tempsrno++;
										Statement stmttaxjv=connold.createStatement();
										//System.out.println("Jvtran Sql:"+strtaxjv);
										int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
										if(taxjvval>0){

										}
										else{
											System.out.println("Jvtran Tax Error");
											return 0;
										}
										stmttaxjv.close();
										stmttaxinvd.close();
									}
									else{
										System.out.println("Tax Invd Error");
										return 0;
									}
								}
							}
							stmtchecktax.close();
							stmtgetinvmode.close();
							stmtgettax.close();
						}

					}


				}//Closing for origin (Tax)
				//If Tax Method is Disabled in gl_config
				if(generalamt>0){

					double ramt=Math.round(generalamt);
					double ramtldr=ramt*testcurrate;
					double discount = (generalamt-ramt);
					discount=objcommon.Round(discount, 2);
					/*discount=Math.round(discount*-1);*/
					//System.out.println("Check:"+Math.scalb(discount, 2));
					double discountldr=discount*testcurrate;
					// System.out.println("R Amt:"+ramt+"::::::::::Discount:"+discount+"General Amt:"+generalamt);
					// discount a/c jvtran  discount*-1   
					Statement stmtdiscount=connold.createStatement();
					String strdiscount="select acno discountacno from gl_invmode where idno=13";
					ResultSet rsdiscount=stmtdiscount.executeQuery(strdiscount);
					int  discac=0;
					while(rsdiscount.next()){
						discac=rsdiscount.getInt("discountacno");
					}
					if(discount!=0.0){
						Statement stmtdiscjv=connold.createStatement();
						Statement stmtdiscinvd=connold.createStatement();
						String sql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(tempno+1)+"','"+cmbbranch+"','"+aaa+"'"+
								",'"+testtrno+"','13','1','"+(discount*-1)+"','"+discac+"','"+(discount*-1)+"')";
						int discinvd=stmtdiscinvd.executeUpdate(sql);
						if(discinvd<=0){
							stmtdiscinvd.close();
							stmtdiscjv.close();
							stmtdiscount.close();
							connold.close();
							return 0;
						}
						stmtdiscinvd.close();
						//			System.out.println(" Invd Sql"+sql);
						int discid=0;
						if(discount>0.0){
							discid=1;
						}
						else if(discount<0.0){
							discid=-1;
						}
						String sqljvdisc="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+discac+"',"+
								"'"+discount+"','"+testcurrate+"','"+testcurid+"',0,"+discid+",1,"+
								"'"+cmbbranch+"','Discount',"+
								"0,'"+date+"','"+formdetailcode+"','"+discountldr+"','"+aaa+"','"+qty2+"',"+
								"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
						int discval=stmtdiscjv.executeUpdate(sqljvdisc);
						if(discval<=0){
							stmtdiscjv.close();
							stmtdiscount.close();
							connold.close();
							return 0;

						}
						stmtdiscjv.close();
						stmtdiscount.close();
					}

					/*String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+clientacno+"',"+
							"'"+ramt+"','"+testcurrate+"','"+testcurid+"',0,1,1,"+
							"'"+cmbbranch+"','"+note+"',"+
							"0,'"+date+"','"+formdetailcode+"','"+ramtldr+"','"+aaa+"','"+qty2+"',"+
							"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
							System.out.println("General Jv sql:"+sqljv);
					int rsjv=stmtinvoice.executeUpdate(sqljv);
					if(rsjv>0){
								System.out.println("Inside general jv");	
					}
					else{
						System.out.println("General jvtran error");
						//connold.close();
						return 0;
					}*/
					if(courtesyamt>0){
						String sqljvcourtesy="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+courtesyacno+"',"+
								"'"+courtesyamt+"','"+testcurrate+"','"+testcurid+"',0,1,1,"+
								"'"+cmbbranch+"','"+note+"',"+
								"0,'"+date+"','"+formdetailcode+"','"+(courtesyamt*testcurrate)+"','"+aaa+"','"+qty2+"',"+
								"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
								//System.out.println("Courtesy Jv sql:"+sqljvcourtesy);
						int jvcourtesy=stmtinvoice.executeUpdate(sqljvcourtesy);
						if(jvcourtesy>0){
									//System.out.println("Inside Courtesy jv");	
						}
						else{
							System.out.println("Courtesy jvtran error");
							//connold.close();
							return 0;
						}
					}
					if(discountamt>0){
						String sqljvdiscount="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+discountacno+"',"+
								"'"+discountamt+"','"+testcurrate+"','"+testcurid+"',0,1,1,"+
								"'"+cmbbranch+"','"+note+"',"+
								"0,'"+date+"','"+formdetailcode+"','"+(discountamt*testcurrate)+"','"+aaa+"','"+qty2+"',"+
								"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
								//System.out.println("Discount Jv sql:"+sqljvdiscount);
						int jvdiscount=stmtinvoice.executeUpdate(sqljvdiscount);
						if(jvdiscount>0){
									//System.out.println("Inside Discount jv");	
						}
						else{
							System.out.println("Courtesy Discount error");
							//connold.close();
							return 0;
						}
					}
					if(amount>0){
						String sqljvclientamt="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
								"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+testtrno+"','"+clientacno+"',"+
								"'"+amount+"','"+testcurrate+"','"+testcurid+"',0,1,1,"+
								"'"+cmbbranch+"','"+note+"',"+
								"0,'"+date+"','"+formdetailcode+"','"+(amount*testcurrate)+"','"+aaa+"','"+qty2+"',"+
								"'"+testcurid+"','5',1,"+hidclient+",3,'"+agmtno+"','"+cmbagmttype+"','"+duedate+"')";
								//System.out.println("Courtesy Jv sql:"+sqljvclientamt);
						int jvclientamt=stmtinvoice.executeUpdate(sqljvclientamt);
						if(jvclientamt>0){
					//				System.out.println("Inside Client jv");	
						}
						else{
							System.out.println("Client JV error");
							//connold.close();
							return 0;
						}
					}
					stmtdiscount.close();

					}	
				
				
//				System.out.println("no====="+aaa);
				invoicebean.setDocno(aaa);
				/*String testjv1="select dramount from my_jvtran where tr_no="+testtrno;
				ResultSet rstestjv1=stmtinvoice.executeQuery(testjv1);
							 System.out.println("Test Sum Jvtran"+testjv1);
					while(rstestjv1.next()){
					System.out.println("jv vvalue"+rstestjv1.getDouble("dramount"));
					}*/
				if (aaa > 0) {
						
					//			System.out.println("InvNo > 0");

					String testjv="select sum(coalesce(dramount,0)) dramount from my_jvtran where tr_no="+testtrno;
					ResultSet rstestjv=stmtinvoice.executeQuery(testjv);
					//			System.out.println("Test Sum Jvtran"+testjv);
					while(rstestjv.next()){
						//	System.out.println("jv vvalue"+rstestjv.getDouble("dramount"));
						if(rstestjv.getDouble("dramount")==0.00){
							//	System.out.println("testjv"+rstestjv.getDouble("dramount"));
							//	System.out.println("Success"+invoicebean.getDocno());

							stmtinvoice.close();
							stmtManual.close();
							//	connold.close();
							return aaa;
						}
						else{
							stmtinvoice.close();
							stmtManual.close();
							//connold.close();
							System.out.println("Jv tally Error");
							return 0;
						}
					}

				}

		}
		catch(Exception e){
			e.printStackTrace();
			connold.close();
		}
		finally{
			
		}
		return 0;
	}

}
