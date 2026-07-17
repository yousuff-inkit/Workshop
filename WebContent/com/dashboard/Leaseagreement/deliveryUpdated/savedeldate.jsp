
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



	String rentaldoc=request.getParameter("rentaldoc");
    String rentaldate=request.getParameter("rentaldate");
	String fleetno=request.getParameter("fleetno");
	String del_Driverid=request.getParameter("drid");
	String del_KM=request.getParameter("del_KM");
	String del_Fuel=request.getParameter("del_Fuel");
	String deldateOut=request.getParameter("jqxDeliveryOut");
	String deltimeOut=request.getParameter("jqxDelTimeOut");
    String group=request.getParameter("group");
    String vlocation=request.getParameter("vlocation");
    
    String branchval=request.getParameter("branchval");
    
    String cldocno=request.getParameter("cldocno");
    
    String chktype=request.getParameter("chktype");
    
    int  cldoc=Integer.parseInt(cldocno);
   	
	java.sql.Date sqldeldate=ClsCommon.changeStringtoSqlDate(deldateOut);
	java.sql.Date sqlrentaldate = ClsCommon.changeStringtoSqlDate(rentaldate);
	 String upsql=null;
	 Connection conn=null;
	 int val=0;
	 String docno="";
	 int aa=0;
	 
	 CallableStatement stmtUpdaterent = null;
	 try{
		 if(chktype.endsWith("LAG"))
		 {
				
			
			conn=ClsConnection.getMyConnection();
			stmtUpdaterent = conn.prepareCall("{CALL leasedelupdateDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtUpdaterent.setDate(1,sqlrentaldate);
			stmtUpdaterent.setString(2, "");
			stmtUpdaterent.setString(3,fleetno);
			stmtUpdaterent.setDate(4,sqldeldate);
			stmtUpdaterent.setString(5,deltimeOut);
			stmtUpdaterent.setString(6,del_KM);
			stmtUpdaterent.setString(7,branchval.trim());
			stmtUpdaterent.setString(8,del_Fuel);
		    stmtUpdaterent.setString(9,rentaldoc);
		    stmtUpdaterent.setString(10,vlocation);
		    stmtUpdaterent.setInt(11,cldoc);
		   	stmtUpdaterent.setString(12,"DLY");
	
		    
			 aa=stmtUpdaterent.executeUpdate();
			 docno=stmtUpdaterent.getString("docNo");
			  stmtUpdaterent.close();
		 }
		 
		 else
		 {
				
				conn=ClsConnection.getMyConnection();
				
				Statement stmt=conn.createStatement();
				String refno="0";
				String sqls="select rdocno  from gl_vehcustody where doc_no='"+rentaldoc+"' ";
				
				ResultSet rs=stmt.executeQuery(sqls);
				if(rs.next())
				{
					refno=rs.getString("rdocno");
				}
				stmt.close();
				
				//System.out.println("---------rentaldoc-------"+rentaldoc);
				//System.out.println("---------refno-------"+refno);
				
				CallableStatement delupdate=conn.prepareCall("{call vehCustodyDelupdate(?,?,?,?,?,?,?,?,?,?)}");
				delupdate.setString(1,del_Driverid);
				delupdate.setString(2,null);
				delupdate.setDate(3,sqldeldate);
				delupdate.setString(4,deltimeOut);
				delupdate.setString(5,del_KM);
				delupdate.setString(6,del_Fuel);
				delupdate.setString(7,rentaldoc);
				delupdate.setString(8,refno);
				delupdate.setString(9,fleetno);
				delupdate.setString(10,session.getAttribute("USERID").toString().trim());
				 aa=delupdate.executeUpdate();
				 delupdate.close(); 
			
		 }
		 

	
	if(aa>0)
	
	{
		
		Statement stmt1=conn.createStatement();
		String sqlsave="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+rentaldoc+",'"+branchval+"','BLVDU',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		stmt1.executeUpdate(sqlsave);
		stmt1.close();
		response.getWriter().write(docno);
	
	}
		}catch(Exception e){
			
			conn.close();
			e.printStackTrace();
		}

	
		 
	 
	 	//System.out.println("aaaaaa"+accode);
	        
				conn.close();
	 	  
	    
	
	%>
