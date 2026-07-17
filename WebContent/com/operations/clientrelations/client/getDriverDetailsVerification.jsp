<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String driverdetails=request.getParameter("driverdetails")==null?"0":request.getParameter("driverdetails");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
		String AlreadyExists="0",DriverName="";
		
		String strSql = "select method from gl_config where field_nme='crmDriverDetailsVerification'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String method="";
		while(rs.next()) {
			method=rs.getString("method");
		}
		
		if(method.equalsIgnoreCase("1")) {
			
			String aa[]=driverdetails.split(",");

		 	ArrayList<String> driverarray= new ArrayList<String>();
		 	
		    for(int i=0;i<aa.length;i++) {

		    	String temp="";
		 	 	String bb[]=aa[i].split("::");
		 
		 	 	if(bb.length==1 && bb[0].trim().equalsIgnoreCase("")){
			    	AlreadyExists="1";
			    	break;
			    }
		 	 	
		 	 	for(int j=0;j<bb.length;j++){ 
		 			 temp=temp+bb[j]+" ::";
		 		}
		 	 	
		 		driverarray.add(temp);
		 	 
		   } 
		 

		    if(driverarray.size()>0) {
		    	
			String sql ="";
			
			for(int k=0;k<driverarray.size();k++) {
				
				 String[] drivearray=driverarray.get(k).split("::");  
			     
			     if(!drivearray[0].equalsIgnoreCase("undefined") && !drivearray[0].equalsIgnoreCase("NaN")){

			    	 
			    	 DriverName=""+(drivearray[0].trim().equalsIgnoreCase("undefined") || drivearray[0].trim().equalsIgnoreCase("NaN")|| drivearray[0].trim().equalsIgnoreCase("")|| drivearray[0].isEmpty()?"0":drivearray[0].trim())+"";
			    	 
			    	 if(!drivearray[1].equalsIgnoreCase("undefined") && !drivearray[1].equalsIgnoreCase("NaN")){
			    	
			    		 String  mobileno=""+(drivearray[1].trim().equalsIgnoreCase("undefined") || drivearray[1].trim().equalsIgnoreCase("NaN")|| drivearray[1].trim().equalsIgnoreCase("")|| drivearray[1].isEmpty()?"0":drivearray[1].trim())+"";
			    		 
			    		 if(mobileno.equalsIgnoreCase("0")) {
			    			 AlreadyExists="2";
			    			 break;
			    		 }
			    		 
				    	 if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
				 			sql = "select * from gl_drdetails where dtype='CRM' and mobno<>'0' and mobno='"+mobileno+"'";
				 		 } else if(mode.equalsIgnoreCase("E") && !(docno.equalsIgnoreCase(""))){
				 			sql = "select * from gl_drdetails where dtype='CRM' and mobno<>'0' and mobno='"+mobileno+"' and doc_no!="+docno+"";
				 		 }
				 		 ResultSet rs1 = stmt.executeQuery(sql);
				 		
				 		 while(rs1.next()) {
				 			AlreadyExists="3";
				 			break;
				 		 } 
			 		
				 		 
				 		 if(AlreadyExists.equalsIgnoreCase("0")) {
				 			 
				 			if(!drivearray[2].equalsIgnoreCase("undefined") && !drivearray[2].equalsIgnoreCase("NaN")){
				 				
				 				 String  licenceno=""+(drivearray[2].trim().equalsIgnoreCase("undefined") || drivearray[2].trim().equalsIgnoreCase("NaN")|| drivearray[2].trim().equalsIgnoreCase("")|| drivearray[2].isEmpty()?"0":drivearray[2].trim())+"";
					    		 
					    		 if(licenceno.equalsIgnoreCase("0")) {
					    			 AlreadyExists="4";
					    			 break;
					    		 }
					    		 
						    	 if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
						 			sql = "select * from gl_drdetails where dtype='CRM' and dlno<>'0' and dlno='"+licenceno+"'";
						 		 } else if(mode.equalsIgnoreCase("E") && !(docno.equalsIgnoreCase(""))){
						 			sql = "select * from gl_drdetails where dtype='CRM' and dlno<>'0' and dlno='"+licenceno+"' and doc_no!="+docno+"";
						 		 }
						    	 
						 		 ResultSet rs2 = stmt.executeQuery(sql);
						 		
						 		 while(rs2.next()) {
						 			AlreadyExists="5";
						 			break;
						 		 } 
				 			}
				 		 }
			    	}
			    	 
			     }
			     
			}
		 }
			
		}
		
		response.getWriter().write(AlreadyExists+"####"+DriverName);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  