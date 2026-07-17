
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

<%@page import="com.operations.agreement.rentalagreement.*"%>



<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

ClsRentalAgreementDAO rentalAgmtDAO= new ClsRentalAgreementDAO();

	String docnos=request.getParameter("docno");
	String clientdrs=request.getParameter("clientdrs")==null||request.getParameter("clientdrs")==""?"":request.getParameter("clientdrs");

String deldr=request.getParameter("deldrvss")==null||request.getParameter("deldrvss")==""?"0":request.getParameter("deldrvss");

String rantalagts=request.getParameter("rantalagt");

String chkouts=request.getParameter("chkout");

String deliverys=request.getParameter("delivery")==null||request.getParameter("delivery")==""?"0":request.getParameter("delivery");

String chuefs=request.getParameter("chuef")==null||request.getParameter("chuef")==""?"0":request.getParameter("chuef");

String delcharge=request.getParameter("delcharge")==null||request.getParameter("delcharge")==""?"0":request.getParameter("delcharge");


String fleetno=request.getParameter("fleetnos");
String branchids=request.getParameter("branchids");

String dateout=request.getParameter("dateout");
String timeout=request.getParameter("timeout");
String mrano=request.getParameter("mrano")==null?"0":request.getParameter("mrano");
java.sql.Date rentaldateout=null;

if(!(dateout.equalsIgnoreCase("undefined"))&&!(dateout.equalsIgnoreCase(""))&&!(dateout.equalsIgnoreCase("0")))
	{
	rentaldateout=ClsCommon.changeStringtoSqlDate(dateout);
		
	}



	int docno=Integer.parseInt(docnos);
	
	int delivery=Integer.parseInt(deliverys);
	int chuef=Integer.parseInt(chuefs);
	
//	System.out.println("------docno--------------"+docno);
	
	int deldrid=Integer.parseInt(deldr);
	
	int rantalagt=Integer.parseInt(rantalagts);

	
	int chkout=Integer.parseInt(chkouts);
	
	 
	

	 Connection conn=null;
		CallableStatement stmtrentalagmt = null;
	 int val=0;
	 //1
	 	java.sql.Date masterdate= null;
						 
	 	java.sql.Date outdate= null;
		String outtime="";
						
		java.sql.Date duedate= null;
		String	duetime="";
						
	 
		String branch="";
	//	String fleet_no="";
		String tdocno="";
		String acno="";
		String insuex="";
		String invtype="";
		int advchk=0;
		String delchg="";
		String grpid="";
		String cldocno="";
		String rentaltype="";
		String remarks="";
		int sagid=0;
		
		String refname="";
		
	//2
		String aloc="";
		String fin="";
		String kmin="";
		 delchg=delcharge;
//3

int sal_id=0;
ArrayList<String> ragmttariffarray= new ArrayList<String>();
 
ArrayList<String> paymentarray= new ArrayList<String>();
ArrayList<String> driverarray= new ArrayList<String>();

				 try{
						
				 conn=ClsConnection.getMyConnection();
				
			Statement stmt1 = 	conn.createStatement();	
					
					String sql1="select  grpid,curdate() masterdate,remarks,rtype,brhid,fleet_no,tdocno,acno,insuex,invtype,advchk,locid,round(delchg) delchg,sagid,frmDate,FrmTime,todate,toTime,cldocno from gl_bookingm where doc_no='"+docno+"' ";
					
				//System.out.println("-----"+sql1);			
					ResultSet rs1=stmt1.executeQuery(sql1);
					
					if(rs1.next())
					{
						
					    grpid=rs1.getString("grpid");
						 masterdate=rs1.getDate("masterdate");
						 
						 outdate=rs1.getDate("frmDate");
						 outtime=rs1.getString("FrmTime");
						
						 duedate=rs1.getDate("todate");
						 duetime=rs1.getString("toTime");
						
						 
						 branch=rs1.getString("brhid");
						 //fleet_no=rs1.getString("fleet_no");
						 tdocno=rs1.getString("tdocno");
						 acno=rs1.getString("acno");
						 insuex=rs1.getString("insuex");
						 invtype=rs1.getString("invtype");
						 advchk=rs1.getInt("advchk");
				    	
						
						 cldocno=rs1.getString("cldocno");
						 rentaltype=rs1.getString("rtype");
						 remarks=rs1.getString("remarks");
						 sagid=rs1.getInt("sagid");
						
						
					}
					stmt1.close();
					
					Statement stmt2 = 	conn.createStatement();		
					String sql2="select v.a_loc,m.fin,round(m.kmin) kmin from gl_vehmaster v left join gl_vmove m on v.fleet_no=m.fleet_no where m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and v.fleet_no='"+fleetno+"'";	
					//System.out.println("-----"+sql2);	
                      ResultSet rs2=stmt2.executeQuery(sql2);
					
					if(rs2.next())
					{
						
						aloc=rs2.getString("a_loc");
						 fin=rs2.getString("fin");
						 kmin=rs2.getString("kmin");
				
				
						
						
					}
					stmt2.close();
					
					

					Statement stmt3 = 	conn.createStatement();		
					String sql3="select a.sal_id,a.refname from my_acbook a  left join my_salm m on a.sal_id=m.doc_no where a.dtype='CRM' and a.cldocno='"+cldocno+"'";	
					//System.out.println("-----"+sql3);	
                      ResultSet rs3=stmt3.executeQuery(sql3);
					
					if(rs3.next())
					{
						
						sal_id=rs3.getInt("sal_id");
						
						refname=rs3.getString("refname");
						
						
					}
					stmt3.close();
				

					Statement stmt4 = 	conn.createStatement();		
					String sql4="select rdocno,brhid,gid,rentaltype,rate,cdw,pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg, chaufchg, chaufexchg,rstatus from gl_btarif where rdocno='"+docno+"' order by rstatus";	
					//System.out.println("-----"+sql4);
                      ResultSet rs4=stmt4.executeQuery(sql4);
					
					while(rs4.next())
					{
						
				
                           
						ragmttariffarray.add(rs4.getString("rentaltype")+" :: "+rs4.getString("rate")+" :: "+rs4.getString("cdw")+" :: "
						+rs4.getString("pai")+" :: "+rs4.getString("cdw1")+" :: "+rs4.getString("pai1")+" :: "+rs4.getString("gps")
						+" :: "+rs4.getString("babyseater")+" :: "+rs4.getString("cooler")+" :: "+rs4.getString("kmrest")+" :: "+rs4.getString("exkmrte")
						+" :: "+rs4.getString("oinschg")+" :: "+rs4.getString("exhrchg")+" :: "+rs4.getString("chaufchg")+" :: "+rs4.getString("chaufexchg")
						+" :: "+rs4.getString("rstatus"));	
						
						
					}
				
					
					stmt4.close();
					
				
			
					//String sql5="select payment,mode,amount,acode,cardno,expdate,recieptno,brhid,payid,doc_no,card,paytype,cardtype  from gl_bpyt where rdocno='"+docno+"'";	
					//System.out.println("-----"+sql5);
                     /*   ResultSet rs5=stmt5.executeQuery(sql5);
					
					while(rs5.next())
					{
						
					
						paymentarray.add(rs5.getString("payment")+" :: "+rs5.getString("mode")+" :: "+rs5.getString("amount")+" :: "+rs5.getString("acode")
								+" :: "+rs5.getString("cardno")+" :: "+rs5.getString("expdate")+" :: "+rs5.getString("card")
								+" :: "+rs5.getString("cardtype")+" :: "+rs5.getString("paytype")+" :: "+""+" :: "+rs5.getString("payid"));	
					}
					stmt5.close();
					 */
		 
					
					driverarray.add(""+clientdrs);
					session.setAttribute("BRANCHID", branch);
			
		String delchgs="";	
			if(delivery==1)
			{
				delchgs=delchg;
			}
			else
			{
				delchgs="0";
			}
			
			//System.out.println("---ssssssssssssssssssssssss----"+delchgs);
					
					int val1=rentalAgmtDAO.insert(masterdate,fleetno,cldocno,sal_id,"0",
							acno,0,"0",delivery,chuef,
							deldrid,driverarray,kmin,fin,rentaldateout,timeout,sagid,
							rantalagt,chkout,duedate,timeout,
							ragmttariffarray,""+branchids,tdocno,invtype,insuex,
							paymentarray,mrano,"0",fleetno,aloc,grpid,rentaltype,
							advchk,"A",session,"RAG",request,refname,delchgs,remarks,0,"0","0");	
					//System.out.println("------val1--------------"+val1);
						    if (val1>0) {
						    	int vocnois=0;
						    	Statement vocnostmt = 	conn.createStatement();		
								String sqlsssss="select voc_no  from gl_ragmt where doc_no='"+val1+"'";	
								
				                      ResultSet vocnors=vocnostmt.executeQuery(sqlsssss);
					               
				                  	while(vocnors.next())
									{
										
				                  		vocnois=vocnors.getInt("voc_no");
									  
								
									}
				                  	vocnostmt.close();
				                  	
				        	    	int bookvocnois=0;
				                 	Statement bookvocnostmt = 	conn.createStatement();		
									String booksqlsssss="select voc_no  from gl_bookingm where doc_no='"+docno+"'";	
									
					                      ResultSet bookvocnors=bookvocnostmt.executeQuery(booksqlsssss);
						               
					                  	while(bookvocnors.next())
										{
											
					                  		bookvocnois=bookvocnors.getInt("voc_no");
										  
									
										}
					                  	bookvocnostmt.close();
							    	
						    	
						    	Statement stmt6=conn.createStatement();	
						      String updatesql="update gl_bookingm set rano='"+val1+"' where doc_no='"+docno+"'";
						 //   System.out.println("---------"+updatesql);
				               stmt6.executeUpdate(updatesql);
				               stmt6.close();
				               
				               
				       		Statement stmt12 = 	conn.createStatement();		
							
							
							String sql12="INSERT INTO gl_rpyt(payment,mode,amount,acode,cardno,expdate,card,cardtype,paytype,payid,brhid,rdocno,recieptno) 	select  payment,mode,amount,acode,cardno,expdate,card,cardtype,paytype,payid,brhid,'"+val1+"',recieptno  from gl_bpyt where rdocno='"+docno+"'";
							//System.out.println("-----"+sql12);
							stmt12.executeUpdate(sql12);
				               
				               
				           	int repno=0; 
				           	int tranno;
					String payment=""; 
					String book="Booking -"+bookvocnois+" "+"RA";
				               Statement stmt5 = conn.createStatement();		
								
								String sql5="select payment,recieptno  from gl_bpyt where rdocno='"+docno+"'";	
							    //  System.out.println("---5--"+sql5);
			                      ResultSet rs5=stmt5.executeQuery(sql5);
								
								while(rs5.next())
								{
									
								repno=rs5.getInt("recieptno");
								
								payment=rs5.getString("payment");
								
								  Statement stmt10 = 	conn.createStatement();		
								String sql6="update gl_rentreceipt set paydesc=Concat('"+book+"',' ','"+vocnois+"',' ','"+payment+"'),rtype='RAG',aggno='"+val1+"',desc1=Concat('"+book+"',' ','"+vocnois+"',' ','"+payment+"') where srno='"+repno+"'";	
								//System.out.println("---6--"+sql6);
			                      stmt10.executeUpdate(sql6);
			                      
			                      
			                      Statement stmt7 = 	conn.createStatement();				
									
						    		String sql7="select tr_no  from gl_rentreceipt where srno='"+repno+"'";	
								//System.out.println("---7--"+sql7);
				                      ResultSet rs7=stmt7.executeQuery(sql7);
					               
				                  	while(rs7.next())
									{
										
									tranno=rs7.getInt("tr_no");
									  Statement stmt8 = 	conn.createStatement();		
									  String sql8="update my_jvtran set rdocno='"+val1+"',rtype='RAG',description=Concat('"+book+"',' ','"+vocnois+"',' ','"+payment+"') where tr_no='"+tranno+"'";	
									//  System.out.println("--8---"+sql8);
				                      stmt8.executeUpdate(sql8);
				                      stmt8.close();
								
									}
				                  	stmt7.close();
			                   
								}
						
								stmt5.close();    
								
						
								
								   String  qreftype=""; 	
				                  	int qrefno=0;
				             	   String  ereftype=""; 	
				                  	int erefno=0;
					                
					                
					                
					                
					            	
				                 	Statement qotstmt = conn.createStatement();		
									String qotsql="select reftype,refno from gl_bookingm where doc_no='"+docno+"'";	
							
					                      ResultSet qotrs=qotstmt.executeQuery(qotsql);
						               
					                  	if(qotrs.next())
										{
											
					                  		qrefno=qotrs.getInt("refno");
					                  		qreftype=qotrs.getString("reftype");
									
										}
					                  	
					                  if(qreftype.equalsIgnoreCase("QOT"))	
					                	  
					                  {
					                	  String updateqot="update gl_quotm set clstatus=5 where DOC_NO='"+qrefno+"'";
				
									      qotstmt.executeUpdate(updateqot);  
					                  
										  String enqsql="select ref_type,ref_no from gl_quotm  where DOC_NO='"+qrefno+"'";	
						
						                  ResultSet enqrs=qotstmt.executeQuery(enqsql);
							               
						                  	if(enqrs.next())
											{
												
						                  		erefno=enqrs.getInt("ref_no");
						                  		ereftype=enqrs.getString("ref_type");
										
											}
						                  	
						                  	if(ereftype.equalsIgnoreCase("CEQ"))	
							                	  
							                  {
							                	  String updateenq="update gl_enqm set clstatus=5 where DOC_NO='"+erefno+"'";
							   
											      qotstmt.executeUpdate(updateenq);  
							                  
												  
								                  	
								                  	
							                  } 	
							                  	
						                  	
					                  } 	
					                  	
					                  	
					                  	
					                  	
					                  	qotstmt.close();
					                  	
					               
					                  	
								
								//----------------------------------------------------------------------------------
				               
								int vocno=0;
								
								 Statement vocstmt = 	conn.createStatement();		
								String sqlssss="select voc_no  from gl_ragmt where doc_no='"+val1+"'";	
								
				                      ResultSet vocrs=vocstmt.executeQuery(sqlssss);
					               
				                  	while(vocrs.next())
									{
										
				                  		vocno=vocrs.getInt("voc_no");
									  
								
									}
				                  	vocstmt.close();
				             
				                  	
								conn.close();
								
							
								
								response.getWriter().print(vocno);
					        
				       		}
						    
						    
						    
							}catch(Exception e){
								
								 e.printStackTrace();
								conn.close();
								 response.getWriter().print("NO");	
							}
					
						
							 
				
						    
						
						%>
