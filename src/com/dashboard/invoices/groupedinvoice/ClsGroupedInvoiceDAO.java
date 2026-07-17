package com.dashboard.invoices.groupedinvoice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceAction;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;

public class ClsGroupedInvoiceDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


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
	  finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
    	}
    	
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" l.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and l.doc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    		
    		
    	}
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.doc_no,r.voc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where 1=1 "+sqltest+" group by doc_no");
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select l.doc_no,l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no");	
					

					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
					
		    	}
				stmtinv.close();
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

	 public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	     	
	      	
	     	String sqltest="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.cldocno='"+cldocno+"'";
	    	}
	    	if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and m.ratype='"+rentaltype+"'";
	    	}
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		if(rentaltype.equalsIgnoreCase("RAG")){
	    			sqltest=sqltest+" and r.voc_no="+agmtNo+"";
	    		}
	    		else if(rentaltype.equalsIgnoreCase("LAG")){
	    			sqltest=sqltest+" and l.voc_no="+agmtNo+"";
	    		}
	    		
	    	}
	    	if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"+clstatuss+"' )";
	    	}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
				
	            	if(branchval.equalsIgnoreCase("a"))
	            	{
	
	            		
	            		String sql ="select if(m.ratype='RAG',r.voc_no,l.voc_no) refvocno,m.doc_no,m.voc_no,h.description acname,h.account acno,m.doc_no,m.ratype,m.rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
	            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
	            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic , "
	            				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid not in (9,15,8,14,2,17,1)),' '),char(50)) other , if(m.ratype='RAG',r.mrano,l.manualra) mrano "
	            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
	            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
	            				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno   where m.status=3 "
	            				+ " and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";
	       System.out.println("============"+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	            		 stmtVeh.close();
	            	}
	            	else{	
	            		
	            		String sql ="select  if(m.ratype='RAG',r.voc_no,l.voc_no) refvocno,m.doc_no,m.voc_no,m.doc_no,h.description acname,h.account acno,m.doc_no,m.ratype,m.rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
	            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
	            				+ "convert(coalesce((select total from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic , "
	            				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid not in (9,15,8,14,2,17,1)),' '),char(50)) other ,if(m.ratype='RAG',r.mrano,l.manualra) mrano "
	            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
	            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
	            				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno   where m.status=3 "
	            				+ " and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' and m.brhid='"+branchval+"' "+sqltest +" group by d.rdocno order by m.doc_no";
	
	            	    // System.out.println("========2===="+sql);
	     
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	         	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	         	stmtVeh.close();
	            	}
	          
	            	
     				conn.close();
			}
			catch(Exception e){
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    

	 
	 
	 
	 
		public  ClsGroupedInvoiceBean getPrint(String cldocno,String fromdate,String todate,String rentaltype,String agmtno,String clstatus,String griddocno) throws SQLException {
		 	ClsGroupedInvoiceBean bean = new ClsGroupedInvoiceBean();
		 	Connection  conn =null;
		 	 HttpServletRequest request=ServletActionContext.getRequest();
		 	ArrayList<ClsGroupedInvoiceAction> employees = new ArrayList();
		try {
			conn= ClsConnection.getMyConnection();
			 ClsNumberToWord obj=new ClsNumberToWord();
			 String strinvtest="";
			 System.out.println(griddocno);
			 if(!(griddocno.equalsIgnoreCase(""))){
				 strinvtest=" and inv.doc_no in("+griddocno+")";
			 }
			 java.sql.Date sqlfromdate = null;
		        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     		
		     	}
		     	else{
		     
		     	}

		        java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     		
		     	}
		     	else{
		     
		     	}
		     	
		     	String sqltest="";
		     	
		    	if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
		    		sqltest=sqltest+" and inv.ratype='"+rentaltype+"'";
		    	}
		    	if(!(agmtno.equalsIgnoreCase("")|| agmtno.equalsIgnoreCase("NA"))){
		    		if(rentaltype.equalsIgnoreCase("RAG")){
		    			sqltest=sqltest+" and agmt.voc_no="+agmtno+"";
		    		}
		    		else if(rentaltype.equalsIgnoreCase("LAG")){
		    			sqltest=sqltest+" and lagmt.voc_no="+agmtno+"";
		    		}
		    	}
		    	if(!(clstatus.equalsIgnoreCase("") || clstatus.equalsIgnoreCase("NA"))){
		    		sqltest=sqltest+" and (agmt.clstatus='"+clstatus+"' or lagmt.clstatus='"+clstatus+"' )";
		    	}
		    	if(sqlfromdate!=null && sqltodate!=null){
		    		sqltest=sqltest+" and inv.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
		    	}
			Statement stmtinvoice = conn.createStatement ();
			String strSql="";
			ArrayList<Double> totalarray=new ArrayList<>();
			ArrayList<String> totalstringarray=new ArrayList<>();
			String strtotal="select round(sum(coalesce(total,0)),2) total,inv.doc_no from gl_invm inv left join gl_invd on doc_no=rdocno left join "+
			" gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG') left join gl_lagmt lagmt on(inv.rano=lagmt.doc_no and inv.ratype='LAG') where "+
			" inv.cldocno="+cldocno+" "+sqltest+strinvtest+" and inv.status<>7 order by doc_no";
			System.out.println(strtotal);
			ResultSet rstotal=stmtinvoice.executeQuery(strtotal);

			while(rstotal.next()){
				totalarray.add(rstotal.getDouble("total"));
				totalstringarray.add(rstotal.getString("total"));
			}
			
			strSql="select  concat(inv.cldocno,' - ',DATE_FORMAT(inv.date,'%Y%m%d')) invserial,coalesce(dr.name,dr1.name) driven,round(sum(invd.total),2) total,"+
					" round(sum(invd.total),2) nettotal,inv.fromdate sqlfromdate,inv.todate sqltodate,br.branch,year(inv.date) dateyear,agmt.pono,DATE_FORMAT(CURDATE(),'%d/%m/%Y')"+
					" finaldate,cur.code,cmp.company,cmp.address ,cmp.tel,cmp.fax,br.branchname,ac.refname,ac.com_mob,ac.per_mob,ac.fax1,dr.name,"+
					" inv.doc_no, DATE_FORMAT(inv.date,'%d/%m/%Y') date,inv.rano,DATE_FORMAT('"+sqlfromdate+"','%d/%m/%Y') fromdate,"+
					" DATE_FORMAT('"+sqltodate+"','%d/%m/%Y') todate,inv.acno, inv.ratype,if(inv.ratype='RAG',agmt.ofleet_no,veh.fleet_no) ofleet_no,"+
					" coalesce(if(inv.ratype='RAG',agmt.mrano,lagmt.manualra),'') mrano,coalesce(DATE_FORMAT(agmt.odate,'%d/%m/%Y'),"+
					" DATE_FORMAT(lagmt.outdate,'%d/%m/%Y')) agmtdate,veh.flname,veh.reg_no,plt.code_name,auth.authname,ac.address cladd,ac.address2 cladd1,lc.loc_name,u.user_name"+
					" from gl_invm inv left join gl_invd invd on inv.doc_no=invd.rdocno"+
					" left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"+
					" left join gl_lagmt lagmt on(inv.rano=lagmt.doc_no and inv.ratype='LAG')"+
					" left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"+
					" left join gl_vehmaster veh on ((agmt.ofleet_no=veh.fleet_no  and inv.ratype='RAG') or ((select if(perfleet=0,tmpfleet,perfleet) fleet from gl_lagmt"+
					" where doc_no=inv.rano)=veh.fleet_no and inv.ratype='LAG'))"+
					" left join gl_vehplate plt on veh.pltid=plt.doc_no"+
					" left join gl_vehauth auth on veh.authid=auth.doc_no"+
					" left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno"+
					" left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno"+
					" left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
					" left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
					" left join my_brch br on inv.brhid=br.doc_no"+
					" left join my_comp cmp on br.cmpid=cmp.doc_no"+
					" left join my_curr cur on cmp.curid=cur.doc_no"+
					/*" left join my_locm loc on loc.brhid=br.doc_no and loc.doc_no=(select min(doc_no) from my_locm)"+*/
					" inner join my_locm l on l.brhid=br.doc_no"+
					" inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no)"+
					" left join my_user u on u.doc_no=inv.userid where inv.cldocno="+cldocno+" "+sqltest+strinvtest;
			
			System.out.println("Print query:"+strSql);
			/*String strSqldetail="select invd.sr_no,imod.description,invd.units,invd.amount,invd.total from gl_invd invd left join gl_invmode imod on "+
								" invd.chid=imod.idno where invd.rdocno >="+fromno+" and invd.rdocno<="+tono+"";
			//System.out.println("Detail"+strSqldetail);
*/			
			 ArrayList<ArrayList<String>> printdet=new ArrayList<>();
			 ArrayList<ArrayList<String>> printfleetmaster=new ArrayList<>();
			 ArrayList<ArrayList<String>> printsalikmaster=new ArrayList<>();
			 ArrayList<ArrayList<String>> printtrafficdubaimaster=new ArrayList<>();
			 ArrayList<ArrayList<String>> printtrafficelsemaster=new ArrayList<>();
			ResultSet resultSet = stmtinvoice.executeQuery (strSql);
			int i=0;
			while(resultSet.next()){
				String fleet="";
				fleet="Fleet :"+resultSet.getString("ofleet_no");
				fleet=fleet+" "+resultSet.getString("flname");
				fleet=fleet+" Reg No :"+resultSet.getString("reg_no");
				fleet=fleet+" "+resultSet.getString("code_name");
				fleet=fleet+" "+resultSet.getString("authname");
				/*String lbltotal,String lblnetamount,
				String lblamountwords,String lblcheckedby,String lblrecievedby,String lblfinaldate*/
				/*String lblinvno,String lblclient,String lblaccount,String lbldate,String lbladdress1,String lblrano,String lbladdress2,String lbllpono,
				String lblmrano,String lblmobile,String lblratype,String lblphone,String lblcontractstart,String lbldriven,String lblinvfrom,String lblinvto,String lblcontractvehicle*/
								ArrayList<String> printdetin=new ArrayList<String>();
								   printdetin=getPrintdetails(cldocno,sqlfromdate,sqltodate,rentaltype,agmtno,clstatus,strinvtest);
								   printdet.add(printdetin);
				
								   /*		ArrayList<String> printfleet=new ArrayList<>();
									printfleet=getFleetdetails(resultSet.getString("rano"),resultSet.getDate("sqlfromdate"),resultSet.getDate("sqltodate"),resultSet.getString("ratype"));
									printfleetmaster.add(printfleet);
									
										ArrayList<String> salikdet=new ArrayList<>();
									salikdet=getSalikDetails(resultSet.getString("doc_no"));
									printsalikmaster.add(salikdet);
									
									ArrayList<String> trafficdetdubai=new ArrayList<>();
									trafficdetdubai=getTrafficDetailsDubai(resultSet.getString("doc_no"));
									printtrafficdubaimaster.add(trafficdetdubai);
									
									ArrayList<String> trafficdetelse=new ArrayList<>();
									trafficdetelse=getTrafficDetailsElse(resultSet.getString("doc_no"));
									printtrafficelsemaster.add(trafficdetelse);*/
					
				//	System.out.println("SALIK SIZE:"+salikdet.size());
				employees.add(new ClsGroupedInvoiceAction(resultSet.getString("invserial"),resultSet.getString("refname"),resultSet.getString("acno"),resultSet.getString("date"),
						resultSet.getString("cladd"),resultSet.getString("rano"),resultSet.getString("cladd1"),resultSet.getString("pono"),resultSet.getString("mrano"),
						resultSet.getString("per_mob"),resultSet.getString("ratype"),resultSet.getString("com_mob"),resultSet.getString("agmtdate"),resultSet.getString("driven"),
						resultSet.getString("fromdate"),resultSet.getString("todate"),fleet,resultSet.getString("company"),resultSet.getString("address"),
						resultSet.getString("tel"),resultSet.getString("fax"),"Summary",resultSet.getString("branchname"),totalstringarray.get(0),totalstringarray.get(0),
						resultSet.getString("code")+" "+obj.convertNumberToWords(totalarray.get(0))+" Only",resultSet.getString("user_name") ,resultSet.getString("finaldate"),0,
						resultSet.getString("branch"),resultSet.getString("dateyear"),0,0,resultSet.getString("loc_name"),resultSet.getString("code")));
				i++;
				bean.setLbllocation(resultSet.getString("loc_name"));
				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLblprintname("Invoice");
				bean.setLblclient(resultSet.getString("refname"));
				bean.setLblphone(resultSet.getString("com_mob"));
				bean.setLblmobile(resultSet.getString("per_mob"));
				bean.setLblfax(resultSet.getString("fax1"));
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLblinvno(resultSet.getString("doc_no"));
				bean.setLblbranchcode(resultSet.getString("branch"));
				bean.setLbldateyear(resultSet.getString("dateyear"));
				bean.setLbldate(resultSet.getString("date").toString());
				bean.setLblrano(resultSet.getString("rano"));
				bean.setLblinvfrom(resultSet.getString("fromdate").toString());
				bean.setLblinvto(resultSet.getString("todate"));
				String ac="";
				ac=resultSet.getString("acno");
				//ac=ac+" "+resultSet.getString("description");
				bean.setLblaccount(ac);
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
				bean.setLblmrano(resultSet.getString("mrano"));
				}
				bean.setLblcontractstart(resultSet.getString("agmtdate").toString());
				
				bean.setLblcontractvehicle(fleet);
				bean.setLblratype(resultSet.getString("ratype"));
				bean.setLbltotal(totalstringarray.get(0));
				bean.setLblnetamount(totalstringarray.get(0));
				bean.setLbldriven(resultSet.getString("driven"));
				bean.setLbladdress1(resultSet.getString("address"));
				bean.setLbladdress2(resultSet.getString("cladd1"));
				bean.setLblfinaldate(resultSet.getString("finaldate").toString());
				bean.setLbllocation(resultSet.getString("loc_name"));
				if(resultSet.getString("ratype").equalsIgnoreCase("RAG")){
				bean.setLbllpono(resultSet.getString("pono"));
				}
				   bean.setLblamountwords(resultSet.getString("code")+" "+obj.convertNumberToWords(totalarray.get(0))+" only");
				   
					
			}
			request.setAttribute("FLEETPRINT", printfleetmaster);
				request.setAttribute("INVPRINT", printdet); 
				request.setAttribute("SALIKPRINT", printsalikmaster);
				request.setAttribute("TRAFFICPRINTDUBAI", printtrafficdubaimaster);
				request.setAttribute("TRAFFICPRINTELSE", printtrafficelsemaster);
				request.setAttribute("TRIAL", employees);
			//	System.out.println("Check Fleet Details: "+printfleetmaster);
				conn.close();
				}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return bean;
	}
		
		
		public  ArrayList<String> getPrintdetails(String cldocno,java.sql.Date sqlfromdate,java.sql.Date sqltodate,String rentaltype,
				String agmtno,String clstatus,String strinvtest) throws SQLException {
			ArrayList<String> arr=new ArrayList<String>();
			Connection conn =null;
			try {
				conn= ClsConnection.getMyConnection();
				Statement stmtinvoice = conn.createStatement ();
				String strSqldetail="";
				String sqltest="";
		     	String sqlcommon="";
		    	if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
		    		sqlcommon=sqlcommon+" and inv.ratype='"+rentaltype+"'";
		    	}
		    	if(!(agmtno.equalsIgnoreCase("")|| agmtno.equalsIgnoreCase("NA"))){
		    		if(rentaltype.equalsIgnoreCase("RAG")){
		    			sqltest=sqltest+" and rag.voc_no="+agmtno+"";
		    		}
		    		else if(rentaltype.equalsIgnoreCase("LAG")){
		    			sqltest=sqltest+" and lag.voc_no="+agmtno+"";
		    		}
		    	}
		    	if(!(clstatus.equalsIgnoreCase("") || clstatus.equalsIgnoreCase("NA"))){
		    		sqltest=sqltest+" and (rag.clstatus='"+clstatus+"' or lag.clstatus='"+clstatus+"' )";
		    	}
		    	if(sqlfromdate!=null && sqltodate!=null){
		    		sqlcommon=sqlcommon+" and inv.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
		    	}
		    	if(!(strinvtest.equalsIgnoreCase(""))){
		    		sqlcommon=sqlcommon+" "+strinvtest;
		    	}
		    	String sqlfleet="";
/*		    	strSqldetail="select coalesce(r.contractfleet,'') contractfleet,coalesce(r.refno,'') refno,r.refvoc,r.voc_no,r.rdocno,r.chid,r.rano,r.ratype,r.units,round(r.amount,2) amount,round(r.total,2) total,m.description from gl_invmode m"+
		    		" left join (select if(inv.ratype='RAG',agmt.ofleet_no,if(lagmt.perfleet=0,lagmt.tmpfleet,lagmt.perfleet)) contractfleet,if(inv.ratype='RAG',agmt.refno,lagmt.refno) refno,if(inv.ratype='RAG',agmt.voc_no,lagmt.voc_no) refvoc,inv.voc_no,r.chid,inv.rano,inv.ratype,r.rdocno,r.units,round(r.amount,2) amount,round(coalesce(sum(total),0),2) total"+
		    		" from gl_invd r left join gl_invm inv on r.rdocno=inv.doc_no left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"+
		    		" left join gl_lagmt lagmt on (inv.rano=lagmt.doc_no and inv.ratype='LAG') where r.chid not in(8,9,14,15) and inv.cldocno="+cldocno+" "+sqltest+""+
		    		"  group by chid,ratype,rdocno"+
		    		" union all"+
		    		" select if(inv.ratype='RAG',agmt.ofleet_no,if(lagmt.perfleet=0,lagmt.tmpfleet,lagmt.perfleet)) contractfleet,if(inv.ratype='RAG',agmt.refno,lagmt.refno) refno,if(inv.ratype='RAG',agmt.voc_no,lagmt.voc_no) refvoc,inv.voc_no,r.chid,inv.rano,inv.ratype,r.rdocno,r.units,round(sum(r.amount),2),round(coalesce(sum(total),0),2) total from gl_invd r"+
		    		" left join gl_invm inv on r.rdocno=inv.doc_no left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"+
		    		" left join gl_lagmt lagmt on (inv.rano=lagmt.doc_no and inv.ratype='LAG') where r.chid in(8,14) and inv.cldocno="+cldocno+" "+sqltest+""+
		    		" group by ratype,rdocno"+
		    		" union all"+
		    		" select if(inv.ratype='RAG',agmt.ofleet_no,if(lagmt.perfleet=0,lagmt.tmpfleet,lagmt.perfleet)) contractfleet,if(inv.ratype='RAG',agmt.refno,lagmt.refno) refno,if(inv.ratype='RAG',agmt.voc_no,lagmt.voc_no) refvoc,inv.voc_no,r.chid,inv.rano,inv.ratype,r.rdocno,r.units,round(r.amount,2),round(coalesce(sum(total),0),2) total from gl_invd r"+
		    		" left join gl_invm inv on r.rdocno=inv.doc_no left join gl_ragmt agmt on (inv.rano=agmt.doc_no and inv.ratype='RAG')"+
		    		" left join gl_lagmt lagmt on (inv.rano=lagmt.doc_no and inv.ratype='LAG')where r.chid  in(9,15) and inv.cldocno="+cldocno+" "+sqltest+""+
		    		" group by ratype,rdocno"+
		    		" ) r on(m.idno=r.chid) where r.chid is not null order by r.rdocno";
*/
		    	/*round(sum(coalesce(a.total,0)),2) total;
		    	a.ratype,a.rano,a.date,a.dtype,a.fromdate,a.todate,a.total,
		    	if(a.ratype='RAG',rag.voc_no,lag.voc_no) agmtvocno,if(a.ratype='RAG',rag.refno,lag.refno) mrano,
		    	contractveh.reg_no contractregno,curveh.reg_no currentregno;
		    	left join gl_vehmaster curveh on (curveh.fleet_no=(select fleet_no from gl_vmove where doc_no in
		    	(select max(doc_no) from gl_vmove mov where mov.rdocno=a.rano and mov.rdtype=a.ratype and '2015-12-30' between dout and
		    	coalesce(din,'2016-01-30'))));
		    	select a.ratype,a.rano,a.date,a.dtype,a.fromdate,a.todate,round(sum(coalesce(a.total,0)),2) total,
		    	if(a.ratype='RAG',rag.voc_no,lag.voc_no) agmtvocno,coalesce(if(a.ratype='RAG',rag.refno,lag.refno),'') mrano,
		    	contractveh.reg_no contractregno from (
		    	select invd.rdocno,inv.ratype,inv.rano,inv.date,inv.dtype,inv.fromdate,inv.todate,round(sum(coalesce(total,0)),2) total from gl_invm inv left join gl_invd invd
		    	on inv.doc_no=invd.rdocno where inv.status<>7 and inv.cldocno=17 and invd.chid not in(8,9,14,15) and
		    	inv.date between '2015-12-30' and '2016-01-30'  and inv.doc_no in(6086,6087,6088)  group by ratype,rdocno union
		    	select invd.rdocno,inv.ratype,inv.rano,inv.date,inv.dtype,inv.fromdate,inv.todate,round(sum(coalesce(total,0)),2) total from gl_invm inv left join gl_invd invd
		    	on inv.doc_no=invd.rdocno  where inv.status<>7 and inv.cldocno=17 and invd.chid in(8,14) and inv.date between '2015-12-30' and
		    	'2016-01-30'  and inv.doc_no in(6086,6087,6088)  group by ratype,rdocno  union all
		    	select invd.rdocno,inv.ratype,inv.rano,inv.date,inv.dtype,inv.fromdate,inv.todate,round(sum(coalesce(total,0)),2) total from gl_invm inv left join gl_invd invd
		    	on inv.doc_no=invd.rdocno where inv.status<>7 and inv.cldocno=17 and invd.chid in(9,15) and
		    	inv.date between '2015-12-30' and '2016-01-30'  and inv.doc_no in(6086,6087,6088)  group by ratype,rdocno)a
		    	left join gl_ragmt rag on (a.ratype='RAG' and a.rano=rag.doc_no) left join gl_lagmt lag on (a.ratype='LAG' and a.rano=lag.doc_no)
		    	left join gl_vehmaster contractveh on (if(a.ratype='RAG',rag.ofleet_no=contractveh.fleet_no,lag.perfleet=contractveh.fleet_no))
		    	 group by ratype,rano;
		    	left join gl_vehmaster curveh on
		    	(if(a.ratype='RAG',rag.fleet_no=contractveh.fleet_no,if(lag.perfleet=0,lag.tmpfleet=contractveh.fleet_no,lag.perfleet=contractveh.fleet_no)))
		    	 ;
		    	select * from gl_invm where doc_no=6087;
		    	select * from gl_vmove mov where mov.rdocno=24 and mov.rdtype='RAG' and '2015-12-30' between dout and
		    	coalesce(din,'2016-01-30')
		    	;*/
		    	
		    	strSqldetail=" select a.fromdate sqlfromdate,a.todate sqltodate,a.invno,a.ratype,a.rano,date_format(a.date,'%d-%m-%Y') date,a.dtype,date_format(a.fromdate,'%d-%m-%Y') fromdate,"+
		    			" date_format(a.todate,'%d-%m-%Y') todate,round(sum(coalesce(a.total,0)),2) total,"+
		    			" if(a.ratype='RAG',rag.voc_no,lag.voc_no) agmtvocno,coalesce(if(a.ratype='RAG',rag.refno,lag.refno),'') mrano,"+
		    			" contractveh.reg_no contractregno from ("+
		    			" select inv.voc_no invno,invd.rdocno,inv.ratype,inv.rano,inv.date,inv.dtype,inv.fromdate,inv.todate,round(sum(coalesce(total,0)),2) total from gl_invm inv left "+
		    			" join gl_invd invd on inv.doc_no=invd.rdocno where inv.status<>7 and invd.chid not in(8,9,14,15) and inv.cldocno="+cldocno+" "+sqlcommon+""+
		    			" group by ratype,rdocno union"+
		    			" select inv.voc_no invno,invd.rdocno,inv.ratype,inv.rano,inv.date,inv.dtype,inv.fromdate,inv.todate,round(sum(coalesce(total,0)),2) total from gl_invm inv left "+
		    			" join gl_invd invd on inv.doc_no=invd.rdocno  where inv.status<>7 and invd.chid in(8,14)  and inv.cldocno="+cldocno+" "+sqlcommon+"  group by ratype,rdocno  union all"+
		    			" select inv.voc_no invno,invd.rdocno,inv.ratype,inv.rano,inv.date,inv.dtype,inv.fromdate,inv.todate,round(sum(coalesce(total,0)),2) total from gl_invm inv left "+
		    			" join gl_invd invd on inv.doc_no=invd.rdocno where inv.status<>7 and invd.chid in(9,15)  and inv.cldocno="+cldocno+" "+sqlcommon+"  group by ratype,rdocno)a"+
		    			" left join gl_ragmt rag on (a.ratype='RAG' and a.rano=rag.doc_no) left join gl_lagmt lag on (a.ratype='LAG' and a.rano=lag.doc_no)"+
		    			" left join gl_vehmaster contractveh on (if(a.ratype='RAG',rag.ofleet_no=contractveh.fleet_no,lag.perfleet=contractveh.fleet_no))"+sqltest+
		    			" group by rdocno";
		    	
		    	
		    	
		//	System.out.println("Detail Print Query:"+strSqldetail);
			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);
			
			int rowcount=1;
			
			while(rsdetail.next()){
			
					String temp="";
					String currentreg=getCurrentFleetDetail(rsdetail.getString("rano"),rsdetail.getString("ratype"),rsdetail.getDate("sqlfromdate"),rsdetail.getDate("sqltodate"));
					/*temp=rowcount+"::"+rsdetail.getString("rdocno")+"::"+rsdetail.getString("rano")+"::"+rsdetail.getString("ratype")+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("total");*/
					//temp=rowcount+"::"+rsdetail.getString("voc_no")+"::"+rsdetail.getString("refvoc")+"::"+rsdetail.getString("refno")+"::"+rsdetail.getString("ratype")+"::"+rsdetail.getString("contractfleet")+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("units")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("total");
					temp=rowcount+"::"+rsdetail.getString("date")+"::"+rsdetail.getString("dtype")+"::"+rsdetail.getString("invno")+"::"+rsdetail.getString("agmtvocno")+"::"+rsdetail.getString("mrano")+"::"+rsdetail.getString("contractregno")+"::"+currentreg+"::"+rsdetail.getString("fromdate")+"::"+rsdetail.getString("todate")+"::"+rsdetail.getString("total");
					arr.add(temp);
					rowcount++;
		
		}
			stmtinvoice.close();
			conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			// TODO Auto-generated method stub
			return arr;
		}

		public  String getCurrentFleetDetail(String agmtno,String agmttype,java.sql.Date sqlfromdate,java.sql.Date sqltodate) throws SQLException{
			
			Connection conn=null;
			String regno="";
			try{
				conn=ClsConnection.getMyConnection();
				Statement stmtcurrent=conn.createStatement();
				String strmaxdoc="select coalesce(max(doc_no),0) maxdoc from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"'"+
			" and dout between '"+sqlfromdate+"' and '"+sqltodate+"'";
//				System.out.println(strmaxdoc);
				int maxdoc=0;
				ResultSet rsmaxdoc=stmtcurrent.executeQuery(strmaxdoc);
				while(rsmaxdoc.next()){
					maxdoc=rsmaxdoc.getInt("maxdoc");
				}
				if(maxdoc==0){
					strmaxdoc="select coalesce(max(doc_no),0) maxdoc from gl_vmove where rdocno="+agmtno+" and rdtype='"+agmttype+"'";
					rsmaxdoc=stmtcurrent.executeQuery(strmaxdoc);
					while(rsmaxdoc.next()){
						maxdoc=rsmaxdoc.getInt("maxdoc");
					}
				}
				String strcurrentfleet="select veh.reg_no from gl_vmove mov left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no where  mov.doc_no="+maxdoc;
				
				ResultSet rscurrent=stmtcurrent.executeQuery(strcurrentfleet);
				
				while(rscurrent.next()){
					regno=rscurrent.getString("reg_no");
					}
				stmtcurrent.close();
			}
			catch(Exception e){
				e.printStackTrace();
				
			}
			finally{
				conn.close();
			}
			return regno;
			
		}
		public  ArrayList<String> getFleetdetails(String lblrano,java.sql.Date fromdate,java.sql.Date todate,String lblratype) throws SQLException {
			// TODO Auto-generated method stub
			Connection conn=null;
			ArrayList<String> fleetarray=new ArrayList<>();
				try {
					String strfleetdetails="select distinct mov.fleet_no,veh.flname,veh.reg_no,DATE_FORMAT(mov.dout,'%d/%m/%Y') dout,COALESCE(DATE_FORMAT(mov.din,'%d/%m/%Y '),'') "+
							" din from gl_vmove mov left join gl_vehmaster veh on (mov.fleet_no=veh.fleet_no ) where mov.rdocno="+lblrano+" and mov.rdtype='"+lblratype+"' and mov.repno<> 0 and mov.trancode<>'DL'"+
							" and ((dout >='"+fromdate+"' and dout <='"+todate+"') or (din >='"+fromdate+"' and din <='"+todate+"'))";
						conn=ClsConnection.getMyConnection();
					
					Statement stmtfleetdetails = conn.createStatement();
//					System.out.println("Fleet Query:"+strfleetdetails);
				ResultSet rsfleetdetails=stmtfleetdetails.executeQuery(strfleetdetails);
				while(rsfleetdetails.next()){
					String temp=rsfleetdetails.getString("fleet_no")+"  "+rsfleetdetails.getString("flname")+"  "+"Reg No:"+rsfleetdetails.getString("reg_no")+"  "+"From Date:"+rsfleetdetails.getString("dout")+"  "+"To Date:"+rsfleetdetails.getString("din");
					fleetarray.add(temp);
				}
				conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
			return fleetarray;
		}
		
}
