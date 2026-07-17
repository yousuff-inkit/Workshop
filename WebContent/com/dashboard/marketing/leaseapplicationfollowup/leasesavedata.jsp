
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	String statval=request.getParameter("statval");
	String srno=request.getParameter("srno");
	String podate=request.getParameter("podate");
	String purdealer=request.getParameter("purdealer");
	//String qty=request.getParameter("qty");

String brndid=request.getParameter("brndid");
String yes_no=request.getParameter("yes_no");
	String modid=request.getParameter("modid");
	String nmonth=request.getParameter("nmonth");
	String vcost=request.getParameter("vcost");

	String dealer=request.getParameter("dealer");
	String fleetdoc=request.getParameter("fleetdoc");
	String fleetno=request.getParameter("fleetno");
	String resval=request.getParameter("resval");
	String purcost=request.getParameter("purcost");
	String fleetdate=request.getParameter("fleetdate");
	String leaseappdoc=request.getParameter("leaseappdoc");
	String vendacno=request.getParameter("vendacno")==null || request.getParameter("vendacno")=="" ?"0": request.getParameter("vendacno");
	String allocno=request.getParameter("allocno");
	String invno=request.getParameter("invno")==null || request.getParameter("invno")=="" ?"0": request.getParameter("invno");
	String allotno=request.getParameter("allotno");
	String allotrmk=request.getParameter("allotrmk");
	String vehrmk=request.getParameter("vehrmk");
	String chassisno=request.getParameter("chassisno");
	String lasrno=request.getParameter("lasrno");
	String costval=request.getParameter("costval");
	String extraval=request.getParameter("extraval")==""|| request.getParameter("extraval")==null?"0":request.getParameter("extraval");
	String costrslt=request.getParameter("costrslt");
	 Connection conn=null;

	 try{

java.sql.Date sqlpodate=null;
java.sql.Date sqlfleetdate=null;
if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0")))
	{
	sqlpodate=ClsCommon.changeStringtoSqlDate(podate);
		
	}
	else{

	}
if(!(fleetdate.equalsIgnoreCase("undefined"))&&!(fleetdate.equalsIgnoreCase(""))&&!(fleetdate.equalsIgnoreCase("0")))
{
	sqlfleetdate=ClsCommon.changeStringtoSqlDate(fleetdate);
	
}
else{

}
 String upsql=null,selsql=null,insql=null,fleetsql=null,sqllastat=null,lasql=null;

	 int val=0;
	 int updqty=0;
	 int laqty=0;
	 int laupdqty=0;
	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	 if(statval.equalsIgnoreCase("NA"))
	   {
		
		   upsql="update  gl_leasecalcreq  set lastatus=1,allotno='"+allotno+"',chasisno='"+chassisno+"' where srno='"+srno+"' ";
	  	   val= stmt.executeUpdate(upsql);
	  	 insql="insert into gl_blaf (rdocno, remarks,lastatus) values('"+srno+"','NA - "+allotrmk+"',0)";
		 val= stmt.executeUpdate(insql); 
	  }
	 else if(statval.equalsIgnoreCase("VR"))
	   {
		
		 if(yes_no.equalsIgnoreCase("0")){
		   upsql="update  gl_leasecalcreq  set prchcost="+costrslt+",vehcost="+costval+",vehextracost="+extraval+",lastatus=2 where srno='"+srno+"' ";
		   System.out.println("upsql==="+upsql);
		   val= stmt.executeUpdate(upsql);
		   insql="insert into gl_blaf (rdocno, remarks,lastatus) values('"+srno+"','VR - "+vehrmk+"',1)";
		   val= stmt.executeUpdate(insql); 
		 }
		 if(yes_no.equalsIgnoreCase("1")){
		    String up_lastatus=" update gl_leasecalcreq set lastatus=6 where srno='"+srno+"'";
		   //System.out.println("up_lastatus==="+up_lastatus);
		   val= stmt.executeUpdate(up_lastatus); 
		   insql="insert into gl_blaf (rdocno, remarks,lastatus) values('"+srno+"','VR - "+vehrmk+"',6)";
		   val= stmt.executeUpdate(insql); 
		 }		     
	  }
	 else if(statval.equalsIgnoreCase("PO"))
	   {
		
		   upsql="update  gl_leasecalcreq  set po_date='"+sqlpodate+"',po_dealer='"+purdealer+"',lastatus=3 where srno='"+srno+"' ";
		 val= stmt.executeUpdate(upsql);
		 insql="insert into gl_blaf (rdocno,lastatus) values("+srno+",2)";
		 val= stmt.executeUpdate(insql); 
		     
	  }

	   else  if(statval.equalsIgnoreCase("FU"))
	   {
		   ResultSet resultSet=null,tass=null,trns=null,tass99=null,tass1=null,lastatrs=null;
		   Double amount=Double.parseDouble(purcost);
		   Double dramount=amount*-1;
		  
		   upsql="select upd_quantity from gl_leasecalcreq where srno='"+srno+"' ";
		   resultSet = stmt.executeQuery(upsql);
		   
		    if (resultSet.next()) {
		    	updqty=resultSet.getInt("upd_quantity");
		    }	 
		    updqty++;
		   selsql="update  gl_leasecalcreq  set upd_quantity='"+updqty+"' where srno='"+srno+"' ";
			
		     val= stmt.executeUpdate(selsql);
		     
		     sqllastat="select round(lp.qty-req.upd_quantity) subqty from gl_leaseappm la left join  gl_leasecalcreq req on la.reqdoc=req.leasereqdocno left join gl_lprd lp on lp.rdocno=req.leasereqdocno and lp.sr_no=req.reqsrno where req.lastatus=3 and req.srno='"+srno+"'";
		     lastatrs = stmt.executeQuery(sqllastat);
			   
			    if (lastatrs.next()) {
			    	laqty=lastatrs.getInt("subqty");
			    }	 
		     if(laqty==0)
		     {
		    	 lasql="update  gl_leasecalcreq  set lastatus=4 where srno='"+srno+"' ";
			   val= stmt.executeUpdate(lasql);
			     
		     }
		     /**
		     * depr date will be updated from lease agreement create
		     ,depr_date='"+sqlfleetdate+"' */
		     
		     fleetsql="update  gl_vehmaster  set insur_member="+allocno+",puchstatus=1,residual_val='"+resval+"',prch_dte='"+sqlfleetdate+"',prch_cost='"+purcost+"' where doc_no='"+fleetdoc+"' ";
				
		     val= stmt.executeUpdate(fleetsql);
		   
			   
		     insql="insert into gl_blaf (rdocno, brand, model, no_months, veh_cost, fleet, dealer,residual_val,inv_no,lastatus,reqcal_srno) values('"+srno+"','"+brndid+"','"+modid+"','"+nmonth+"','"+vcost+"','"+fleetno+"','"+dealer+"','"+resval+"','"+invno+"',3,'"+lasrno+"')";
			 val= stmt.executeUpdate(insql); 
			 //asset tran
			 int assetdoc=0;
			 int acnos=0;
		
		      int tranno=0,trannos=0;
		      String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
				
				tass = stmt.executeQuery (trsql);
				
				if (tass.next()) {
			
					tranno=tass.getInt("trno");		
					
			     }
				String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
					
					stmt.executeUpdate(trnosql);
					 String trnossql="SELECT max(trno) trno FROM my_trno m";
						
						trns = stmt.executeQuery (trnossql);
						
						if (trns.next()) {
					
							trannos=trns.getInt("trno");		
							
					     }	
				
			 
			 String sql99="select coalesce((max(doc_no)+1),1) docno from gc_assettran";
				   tass99 = stmt.executeQuery (sql99);
											
						if (tass99.next()) {
										
							assetdoc=tass99.getInt("docno");		
												
						     }
			 String sql2="select acno from my_account where codeno='VEH'";
			
					  tass1 = stmt.executeQuery (sql2);
							if (tass1.next()) {
										
								acnos=tass1.getInt("acno");		
											
							   }
						
			 String sqla="INSERT INTO gc_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no) VALUES ('"+sqlfleetdate+"','"+assetdoc+"','"+fleetno+"', "+acnos+",'"+amount+"','"+session.getAttribute("BRANCHID").toString()+"','FAD',1,'"+trannos+"')";
		
		  stmt.executeUpdate(sqla);
		  
		  String sqljvpos="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+sqlfleetdate+"','LQT-"+leaseappdoc+"-"+allocno+"-INV:"+invno+"',"+leaseappdoc+","+acnos+",'LQT-"+leaseappdoc+"-"+allocno+"-INV:"+invno+"',1,1,"+amount+","+amount+",0,1,3,0,0,0,1,6,'"+fleetno+"','BLAF','"+session.getAttribute("BRANCHID").toString()+"',"+trannos+",3)";
		
		  stmt.executeUpdate(sqljvpos);
	
		  
	   String sqljvneg="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
		 		+ "values('"+sqlfleetdate+"','LQT-"+leaseappdoc+"-"+allocno+"-INV:"+invno+"',"+leaseappdoc+","+vendacno+",'LQT-"+leaseappdoc+"-"+allocno+"-INV:"+invno+"',1,1,"+dramount+","+dramount+",0,-1,3,0,0,0,1,6,'"+fleetno+"','BLAF','"+session.getAttribute("BRANCHID").toString()+"',"+trannos+",3)";

	   stmt.executeUpdate(sqljvneg);
			 
	   }				
		 	conn.commit();
	 	 response.getWriter().print(val);
	 	stmt.close();
	 	
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 			 response.getWriter().print(2);
	 		}
	
	%>
