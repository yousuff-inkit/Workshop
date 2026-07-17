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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;	
 
String masterdocno=request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno");

String docno=request.getParameter("vocno")==null?"0":request.getParameter("vocno");
String pricetottals=request.getParameter("total")==null?"0":request.getParameter("total");
String deldates=request.getParameter("deldate")==null?"0":request.getParameter("deldate");
String venderaccount=request.getParameter("venacc")==null?"0":request.getParameter("venacc");

String invno=request.getParameter("invno")==null?"0":request.getParameter("invno");
String vehpurinvDate=request.getParameter("vehpurinvDate")==null?"0":request.getParameter("vehpurinvDate");

String loanamount=request.getParameter("loanamount")==null?"0":request.getParameter("loanamount");
String loanaccdocno=request.getParameter("loanaccdocno")==null?"0":request.getParameter("loanaccdocno");

 

java.sql.Date deldate=null;
java.sql.Date vehpurinvDates=null;

String descs="INV-"+""+invno+""+":-Dated :- "+vehpurinvDate;  
 
deldate=ClsCommon.changeStringtoSqlDate(deldates);
vehpurinvDates=ClsCommon.changeStringtoSqlDate(vehpurinvDate);

double pricetottal=Double.parseDouble(pricetottals);

	try{
	conn=ClsConnection.getMyConnection();   
	
	conn.setAutoCommit(false);
   	Statement stmt = conn.createStatement(); 
   	String refdetails="VPU"+""+docno;
   	
   	
  int 	trr=0;
   	
   	String dates="";
   	String so="select coalesce(tr_no,'0') trano,date  from  gl_vpurm where doc_no='"+masterdocno+"'";
   	
   	 
   	
	ResultSet sos = stmt.executeQuery(so);
	
	if (sos.next()) {

		trr=sos.getInt("trano");	
		dates=sos.getString("date");
		
     }
	String sqlop="delete from my_jvtran where tr_no='"+trr+"' and status=7";
   
	int chk=stmt.executeUpdate(sqlop);
   	
 
	
     
    
      int tranno=0;
	
				String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
			
				ResultSet tass = stmt.executeQuery (trsql);
				
				if (tass.next()) {
			
					tranno=tass.getInt("trno");		
					
			     }
				

			
	 
			 

			 
				String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
				
				int dd=stmt.executeUpdate(trnosql);
			     
						 if(dd<=0)
							{
								conn.close();
								
								
							}
			 
				 
			 
			
			 
			 String vendorcur="0"; 
			 double venrate=0.00;
			 
			 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
			   ResultSet tass11 = stmt.executeQuery (sqls10);
			   if(tass11.next()) {
			
				   vendorcur=tass11.getString("curid");	
				 
					
			        }
			 
			 
		     String currencytype="";
		     String sqlss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
		        +"where  coalesce(toDate,curdate())>='"+deldate+"' and frmDate<='"+deldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
		     //System.out.println("-----2--sqlss----"+sqlss) ;
		     ResultSet resultSet33 = stmt.executeQuery(sqlss);
		         
		      while (resultSet33.next()) {
		    	  venrate=resultSet33.getDouble("rate");
		     currencytype=resultSet33.getString("type");
		                      }
		      
			   double	dramount=pricetottal*-1; 
			   
				 
			   double ldramount=0;
			   if(currencytype.equalsIgnoreCase("D"))
			   {
			   
	           	
	           	 ldramount=dramount/venrate ;  
			   }
			   
			   else
			   {
				    ldramount=dramount*venrate ;  
			   }
			   
 
			
			 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+vehpurinvDates+"','"+refdetails+"',"+masterdocno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'VPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",7)";
		     
			   //	System.out.println("--sql1----"+sql1);
			 int ss = stmt.executeUpdate(sql1);

		     if(ss<=0)
				{
					conn.close();
				 
					
				}
		     
		     int acnos=0;
		     String curris="0";
		     double rates=0.00;
		     
		    
		     
		   String sql2="select  acno from my_account where codeno='VEH'";
		   //System.out.println("-----4--sql2----"+sql2) ;

           ResultSet tass1 = stmt.executeQuery (sql2);
			
			if (tass1.next()) {
		
				acnos=tass1.getInt("acno");		
				
		        }
			
			
			
			 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
			   //System.out.println("-----5--sqls3----"+sqls3) ;
			   ResultSet tass3 = stmt.executeQuery (sqls3);
				
				if (tass3.next()) {
			
					curris=tass3.getString("curid");	
					 
					
			              }
				String currencytype1="";
				 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
					        +"where  coalesce(toDate,curdate())>='"+deldate+"' and frmDate<='"+deldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				 //System.out.println("-----6--sqlveh----"+sqlveh) ;
					     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
					         
					      while (resultSet44.next()) {
					    	  rates=resultSet44.getDouble("rate");
					      currencytype1=resultSet44.getString("type");
					                 } 
				 
					      
					      double ldramounts=0 ;     
					      if(currencytype1.equalsIgnoreCase("D"))
					      {
					      
			                   ldramounts=pricetottal/venrate ;  
					      }
					      
					      else
					      {
					    	   ldramounts=pricetottal*venrate ;  
					      }
		     
			 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 		+ "values('"+vehpurinvDates+"','"+refdetails+"',"+masterdocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'VPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",7)";
		     
		     
			// System.out.println("---sql11----"+sql11) ; 
		 
				 int ss1 = stmt.executeUpdate(sql11);

			     if(ss1<=0)
					{
						conn.close();
						//return 0;
						
					}
		     
			
			     
			     double dramountss=Double.parseDouble(loanamount);
			     
				   double ldramountss=0;
				   if(currencytype.equalsIgnoreCase("D"))
				   {
				   
		           	
					   ldramountss=dramountss/venrate ;  
				   }
				   
				   else
				   {
					   ldramountss=dramountss*venrate ;  
				   }
				   
			     
			 	
				 String sqlss10="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 		+ "values('"+vehpurinvDates+"','"+refdetails+"',"+masterdocno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramountss+","+ldramountss+",0,1,3,0,0,0,'"+venrate+"',0,0,'VPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",7)";
			     
				  //System.out.println("-----3--sql1----"+sql1) ;
				 int ss11 = stmt.executeUpdate(sqlss10);

			     if(ss11<=0)
					{
						conn.close();
					 
						
					}
			     
			     
			     
			    String curriss="0";

				 String sq="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+loanaccdocno+"'";
				 
				   ResultSet ts = stmt.executeQuery (sq);
					
					if (ts.next()) {
				
						curriss=ts.getString("curid");	
						 
						
				              }
					String currencytype2="";
					 String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						        +"where  coalesce(toDate,curdate())>='"+deldate+"' and frmDate<='"+deldate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curriss+"'";
					  
						     ResultSet resultSet441 = stmt.executeQuery(sqlveh1);
						         
						      while (resultSet441.next()) {
						    	  rates=resultSet441.getDouble("rate");
						    	  currencytype2=resultSet441.getString("type");
						                 } 
					 
						      double  pricetottalval=dramountss*-1;
						      double ldramountsval=0 ;     
						      if(currencytype2.equalsIgnoreCase("D"))
						      {
						      
						    	  ldramountsval=pricetottalval/venrate ;  
						      }
						      
						      else
						      {
						    	  ldramountsval=pricetottalval*venrate ;  
						      }
			     
				 String sqlup="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+vehpurinvDates+"','"+refdetails+"',"+masterdocno+",'"+loanaccdocno+"','"+descs+"','"+curriss+"','"+rates+"',"+pricetottalval+","+ldramountsval+",0,-1,3,0,0,0,'"+rates+"',0,0,'VPU','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",7)";
				     
				 //  	System.out.println("--sqlup----"+sqlup);
			 
					 int ss12 = stmt.executeUpdate(sqlup);

				     if(ss12<=0)
						{
							conn.close();
							 
							
						}
			     	     
			     
			     
			     
			     
			     
			 	String sqlupdates="update gl_vpurm set tr_no='"+tranno+"' where doc_no='"+masterdocno+"' ";	
				
				int lastval=stmt.executeUpdate(sqlupdates);
				
				if(lastval<=0)
				{
					conn.close();
					
				}
		
/* 		
		String upsql="update gl_vmcostm set trno="+trno+" where doc_no="+docno;
		stmtmaint.executeUpdate(upsql);
		 
	
	 */
			
		response.getWriter().print(tranno);
	 conn.commit();
		conn.close(); 
		
		 
	}
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(0);
    	
    }
	 	
	 	
	 	
%>



