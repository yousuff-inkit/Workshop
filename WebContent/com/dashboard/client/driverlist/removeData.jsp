<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="java.sql.CallableStatement"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmtCRM = conn.createStatement();

		String cldocno=request.getParameter("cldocno");
		String selecteddrivers=request.getParameter("selecteddrivers");
		String branch=request.getParameter("branch");
		int val=1,clientdocno=0,driverid=0;
		
		/*Selecting Driver-Id*/
		ArrayList<String> dridarray=new ArrayList<String>();
		String sql = "select cldocno,dr_id,name,nation,mobno,dlno,issfrm,DATE_FORMAT(issdate,'%d.%m.%Y') issdate,DATE_FORMAT(dob,'%d.%m.%Y') dob,sr_no,ltype,DATE_FORMAT(led,'%d.%m.%Y') led,passport_no,DATE_FORMAT(pass_exp,'%d.%m.%Y') pass_exp,visano,DATE_FORMAT(visa_exp,'%d.%m.%Y') visa_exp,DATE_FORMAT(hcissdate,'%d.%m.%Y') hcissdate,DATE_FORMAT(hcled,'%d.%m.%Y') hcled,hcdlno from gl_drdetails where cldocno="+cldocno+" and dr_id in ("+selecteddrivers+")";
		ResultSet rs = stmtCRM.executeQuery(sql);
		
		while(rs.next()) {
			dridarray.add(rs.getString("cldocno")+"::"+rs.getString("dr_id")+"::"+rs.getString("sr_no")+"::"+rs.getString("name")+"::"+rs.getString("nation")+"::"+rs.getString("mobno")+"::"+rs.getString("dlno")+"::"+rs.getString("issfrm")+"::"+rs.getString("issdate")+"::"+rs.getString("dob")+"::"+rs.getString("ltype")+"::"+rs.getString("led")+"::"+rs.getString("passport_no")+"::"+rs.getString("pass_exp")+"::"+rs.getString("visano")+"::"+rs.getString("visa_exp")+"::"+rs.getString("hcissdate")+"::"+rs.getString("hcled")+"::"+rs.getString("hcdlno"));
		} 
		/*Selecting Driver-Id Ends*/
		
		if(dridarray.size()>0){
			  
			  for(int i=0;i<dridarray.size();i++){
				  
				  clientdocno=Integer.parseInt(dridarray.get(i).split("::")[0]);
				  driverid=Integer.parseInt(dridarray.get(i).split("::")[1]); 
				   
				  /*Checking Driver in Rental Agreement*/
				  String sql1 = "select count(*) driverinagmt from gl_rdriver rd left join gl_ragmt rag on rd.rdocno=rag.doc_no where rag.clstatus=0 and rag.status=3 "
						      + "and rd.status=3 and rd.cldocno="+clientdocno+" and rd.drid="+driverid+"";
				  ResultSet rs1 = stmtCRM.executeQuery(sql1);
					
				  int driverinragmt=0,driverinlagmt=0;
				  while(rs1.next()) {
					  driverinragmt=rs1.getInt("driverinagmt");
					  if(rs1.getInt("driverinagmt")==0) {
					  	val=1;
					  }
				  } 
				  /*Checking Driver in Rental Agreement Ends*/
				  
				  if(driverinragmt==0) {
					  
					  /*Checking Driver in Lease Agreement*/
					  String sql2 = "select count(*) driverinagmt from gl_ldriver ld left join gl_lagmt lag on ld.rdocno=lag.doc_no where lag.clstatus=0 and lag.status=3 "
						      + "and ld.status=3 and ld.cldocno="+clientdocno+" and ld.drid="+driverid+"";
				  	  ResultSet rs2 = stmtCRM.executeQuery(sql2);
				  
				  	  
					  while(rs2.next()) {
						  driverinlagmt=rs2.getInt("driverinagmt");
						  if(rs2.getInt("driverinagmt")==0) {
							  	val=1;
						  }
					  } 
					  /*Checking Driver in Lease Agreement Ends*/
					  
				  }
				  
				  if(driverinragmt==0 && driverinlagmt==0) {
					  
					    java.sql.Date issdate=(dridarray.get(i).split("::")[8]==null || dridarray.get(i).split("::")[8].trim().equalsIgnoreCase("null") || dridarray.get(i).split("::")[8].trim().equalsIgnoreCase("") ||  dridarray.get(i).split("::")[8].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dridarray.get(i).split("::")[8].trim()));
					    java.sql.Date dob=(dridarray.get(i).split("::")[9]==null || dridarray.get(i).split("::")[9].trim().equalsIgnoreCase("null") ||dridarray.get(i).split("::")[9].trim().equalsIgnoreCase("") ||  dridarray.get(i).split("::")[9].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dridarray.get(i).split("::")[9].trim()));
					    java.sql.Date led=(dridarray.get(i).split("::")[11]==null || dridarray.get(i).split("::")[11].trim().equalsIgnoreCase("null") || dridarray.get(i).split("::")[11].trim().equalsIgnoreCase("") ||  dridarray.get(i).split("::")[11].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dridarray.get(i).split("::")[11].trim()));
						java.sql.Date passexp=(dridarray.get(i).split("::")[13]==null || dridarray.get(i).split("::")[13].trim().equalsIgnoreCase("null") ||dridarray.get(i).split("::")[13].trim().equalsIgnoreCase("") ||  dridarray.get(i).split("::")[13].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dridarray.get(i).split("::")[13].trim()));
						java.sql.Date visaexp=(dridarray.get(i).split("::")[15]==null || dridarray.get(i).split("::")[15].trim().equalsIgnoreCase("null") ||dridarray.get(i).split("::")[15].trim().equalsIgnoreCase("") ||  dridarray.get(i).split("::")[15].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dridarray.get(i).split("::")[15].trim()));
						java.sql.Date hcissdate=(dridarray.get(i).split("::")[16].trim()==null || dridarray.get(i).split("::")[16].trim().equalsIgnoreCase("null") ||dridarray.get(i).split("::")[16].trim().equalsIgnoreCase("") ||  dridarray.get(i).split("::")[16].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dridarray.get(i).split("::")[16].trim()));
						java.sql.Date hcled=(dridarray.get(i).split("::")[17].trim()==null || dridarray.get(i).split("::")[17].trim().equalsIgnoreCase("null") ||dridarray.get(i).split("::")[17].trim().equalsIgnoreCase("") ||  dridarray.get(i).split("::")[17].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(dridarray.get(i).split("::")[17].trim()));
						
					    CallableStatement stmtCRM1 = conn.prepareCall("INSERT INTO gl_drdeletedetails(cldocno,doc_no,dr_id,sr_no,branch,name,nation,mobno,dlno,issfrm,issdate,dob,ltype,led,passport_no,pass_exp,visano,visa_exp,hcissdate,hcled,hcdlno,dtype) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						
						stmtCRM1.setString(1,dridarray.get(i).split("::")[0]);//cldocno
						stmtCRM1.setString(2,dridarray.get(i).split("::")[0]);//doc_no
						stmtCRM1.setString(3,dridarray.get(i).split("::")[1]);//dr_id
						stmtCRM1.setString(4,dridarray.get(i).split("::")[2]);//srno
						stmtCRM1.setString(5,branch);//branch
						stmtCRM1.setString(6,dridarray.get(i).split("::")[3]);//name
						stmtCRM1.setString(7,dridarray.get(i).split("::")[4]);//nation
						stmtCRM1.setString(8,dridarray.get(i).split("::")[5]);//mobno
						stmtCRM1.setString(9,dridarray.get(i).split("::")[6]);//dlno
						stmtCRM1.setString(10,dridarray.get(i).split("::")[7]);//issfrm
						stmtCRM1.setDate(11,issdate);//issdate
						stmtCRM1.setDate(12,dob);//dob
						stmtCRM1.setString(13,dridarray.get(i).split("::")[10]);//ltype
						stmtCRM1.setDate(14,led);//led
						stmtCRM1.setString(15,dridarray.get(i).split("::")[12]);//passport_no
						stmtCRM1.setDate(16,passexp);//passexp
						stmtCRM1.setString(17,dridarray.get(i).split("::")[14]);//visano
						stmtCRM1.setDate(18,visaexp);//visaexp
						stmtCRM1.setDate(19,hcissdate);//hcissdate
						stmtCRM1.setDate(20,hcled);//hcled
						stmtCRM1.setString(21,dridarray.get(i).split("::")[18]);//hcdlno
						stmtCRM1.setString(22,"CRM");
					    int data = stmtCRM1.executeUpdate();
						
					    if(data>0) {
							/*Deleting from gl_drdetails*/
							String sql4="delete from gl_drdetails where cldocno="+cldocno+" and dr_id="+dridarray.get(i).split("::")[1]+"";
							int data1=stmtCRM.executeUpdate(sql4);
							/*Deleting from gl_drdetails Ends*/
					    }
				  }	
			  }
			 val=3;
		}
		
		String sql5="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+cldocno+"','"+branch+"','BDL',now(),'"+session.getAttribute("USERID").toString()+"','D')";
		int data= stmtCRM.executeUpdate(sql5);
		
		response.getWriter().write(val);
		
		stmtCRM.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
%>