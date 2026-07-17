<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	int vadacno=0,vehacno=0;
	double purchasecost=0.0,currate=0.0;
	String userid=session.getAttribute("USERID").toString();
	String curid=session.getAttribute("CURRENCYID").toString();
	String strsql="select (select acno from my_account where codeno='VAD') vadacno,(select acno from my_account where codeno='VEH') vehacno,"+
	" (select prch_cost from gl_vehmaster where fleet_no="+fleetno+") purchasecost,"+
	" (select c_rate from my_curr where doc_no="+curid+") currate";
	System.out.println("Select: "+strsql);
	ResultSet rsacno=stmt.executeQuery(strsql);
	while(rsacno.next()){
		vadacno=rsacno.getInt("vadacno");
		vehacno=rsacno.getInt("vehacno");
		purchasecost=rsacno.getDouble("purchasecost");
		currate=rsacno.getDouble("currate");
	}
	double amount=purchasecost;
	double partyamount=purchasecost*-1;
	
	
	int maxtrno=0;
	//Inserting to my_trno
	String strtrnoinsert="insert into my_trno(USERNO, TRTYPE, brhId, edate, transid)values("+userid+",'BLVR',"+branch+",now(),0)";
	System.out.println("trno: "+strtrnoinsert);
	int trnoinsert=stmt.executeUpdate(strtrnoinsert);
	if(trnoinsert<=0){
		errorstatus=1;
	}
	else{
		ResultSet rsmaxtrno=stmt.executeQuery("select max(trno) maxtrno from my_trno");
		while(rsmaxtrno.next()){
			maxtrno=rsmaxtrno.getInt("maxtrno");
		}
		
		//Inserting into master
		String strinsertmaster="insert into gl_vehreturn(date,agmtno,fleetno,status)values(CURDATE(),"+agmtno+","+fleetno+",3)";
		System.out.println("Master: "+strinsertmaster);

		int insertmaster=stmt.executeUpdate(strinsertmaster);
		if(insertmaster<=0){
			errorstatus=1;
		}
		else{
			//Inserting to JV
			int maxdocno=0;
			ResultSet rsmaxdocno=stmt.executeQuery("select max(doc_no) maxdoc from gl_vehreturn where fleetno="+fleetno+" and agmtno="+agmtno);
			while(rsmaxdocno.next()){
				maxdocno=rsmaxdocno.getInt("maxdoc");
			}
			int i=1;
			
			String strjvinsert1="insert into my_jvtran(tr_no,acno,dramount,rate,curId,out_amount,trtype,id,ref_row,brhid,description,yrId,cldocno,date,dTYPE,"+
			" stkmove,ldramount,doc_no,LAGE,ref_detail,lbrrate,status,costtype,costcode)values("+maxtrno+","+vadacno+","+amount+","+currate+","+curid+","+
			" 0.0,9,1,"+i+","+branch+",concat('Vehicle Return of ',"+fleetno+"),0,0,CURDATE(),'BLVR',0,"+amount*currate+","+maxdocno+",0,concat('BLVR',' - ',"+maxdocno+"),"+
			" "+currate+",3,6,"+fleetno+")";
			System.out.println("jv1: "+strjvinsert1);

			int jvinsert1=stmt.executeUpdate(strjvinsert1);
			if(jvinsert1<=0){
				errorstatus=1;
			}
			else{
				i++;
				String strjvinsert2="insert into my_jvtran(tr_no,acno,dramount,rate,curId,out_amount,trtype,id,ref_row,brhid,description,yrId,cldocno,date,dTYPE,"+
						" stkmove,ldramount,doc_no,LAGE,ref_detail,lbrrate,status,costtype,costcode)values("+maxtrno+","+vehacno+","+partyamount+","+currate+","+curid+","+
						" 0.0,9,-1,"+i+","+branch+",concat('Vehicle Return of ',"+fleetno+"),0,0,CURDATE(),'BLVR',0,"+partyamount*currate+","+maxdocno+",0,concat('BLVR',' - ',"+maxdocno+"),"+
						" "+currate+",3,6,"+fleetno+")";
				System.out.println("jv2: "+strjvinsert2);

				int jvinsert2=stmt.executeUpdate(strjvinsert2);
				if(jvinsert2<=0){
					errorstatus=1;
				}
				else{
					ResultSet rsgettran=stmt.executeQuery("select tranid from my_jvtran where tr_no="+maxtrno+" and id=1");
					int tranid=0;
					while(rsgettran.next()){
						tranid=rsgettran.getInt("tranid");
					}
					i=1;
					String strcosttraninsert1="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+vadacno+",6,"+amount+","+i+","+tranid+",0,"+fleetno+","+maxtrno+")";
					System.out.println("cost1: "+strcosttraninsert1);

					int costinsert1=stmt.executeUpdate(strcosttraninsert1);
					if(costinsert1<=0){
						errorstatus=1;
					}
					else{
						i++;
						String strcosttraninsert2="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+vehacno+",6,"+partyamount+","+i+","+tranid+",0,"+fleetno+","+maxtrno+")";
						System.out.println("cost2: "+strcosttraninsert2);
						int costinsert2=stmt.executeUpdate(strcosttraninsert2);
						if(costinsert2<=0){
							errorstatus=1;
						}
						else{
							String strasset1="insert into gc_assettran(date,Doc_no,TR_NO,fleet_no,acno,dramount,brhid,Ttype,FTYPE,depr,days)values(CURDATE(),"+maxdocno+","+maxtrno+","+fleetno+","+vadacno+","+amount+","+branch+",'VSI',1,0,0)";
							System.out.println("asset1: "+strasset1);

							int asset1=stmt.executeUpdate(strasset1);
							if(asset1<=0){
								errorstatus=1;
							}
							else{
								String strasset2="insert into gc_assettran(date,Doc_no,TR_NO,fleet_no,acno,dramount,brhid,Ttype,FTYPE,depr,days)values(CURDATE(),"+maxdocno+","+maxtrno+","+fleetno+","+vehacno+","+partyamount+","+branch+",'VSI',1,0,0)";
								System.out.println("asset2: "+strasset2);

								int asset2=stmt.executeUpdate(strasset2);
								if(asset2<=0){
									errorstatus=1;
								}
								else{
									String strupdateveh="update gl_vehmaster set fstatus='Z' where fleet_no="+fleetno;
									System.out.println("vehupdate: "+strupdateveh);

									int updateveh=stmt.executeUpdate(strupdateveh);
									if(updateveh<0){
										errorstatus=1;
									}
									else{
										String strupdateagmt="update gl_lagmt set vehreturnstatus=1 where doc_no="+agmtno;
										int updateagmt=stmt.executeUpdate(strupdateagmt);
										if(updateagmt<0){
											errorstatus=1;
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
	
	if(errorstatus!=1){
		conn.commit();
		
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>