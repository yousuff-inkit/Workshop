
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


	String valfleet=request.getParameter("valfleet");
	String dateout=request.getParameter("dateout");
	String timeout=request.getParameter("timeout");
	
	ClsCommon commonDAO=new ClsCommon();
	ClsConnection connDAO= new ClsConnection();
 


java.sql.Date sqloutdate=null;

if(!(dateout.equalsIgnoreCase("undefined"))&&!(dateout.equalsIgnoreCase(""))&&!(dateout.equalsIgnoreCase("0")))
	{
	sqloutdate=commonDAO.changeStringtoSqlDate(dateout);
		
	}
	else{

	}

	 String upsql=null;

	 int val=0;
	 int docval=0;

	 Connection conn=null;

	 try{

	 
    conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
		
				 /*   upsql="select cast(concat(v.dout,concat(' ',v.tout)) as datetime) dtout,cast(concat(v.din,concat(' ',v.tin)) as datetime) dtin, cast(concat('"+sqloutdate+"',concat(' ','"+timeout+"')) as datetime) agmtdt , (select cast(concat(vm.din,concat(' ',vm.tin)) as datetime) dtin from gl_vmove vm where rdtype='veh' and fleet_no='"+valfleet+"') reldt from gl_vmove v where fleet_no='"+valfleet+"' having (agmtdt  between dtout and dtin) and (agmtdt>reldt)"; */

		upsql="select cast(concat('"+sqloutdate+"',concat(' ','"+timeout+"')) as datetime) agmtdt ,cast(concat(vm.din,concat(' ',vm.tin)) as datetime) dtin from gl_vmove vm where doc_no=(select max(doc_no) from gl_vmove  where  fleet_no='"+valfleet+"' and status='IN') having agmtdt<dtin";		   
				  
	//System.out.println("------upsql-----"+upsql);		 
				 ResultSet resultSet = stmt.executeQuery(upsql);
				 
				   while (resultSet.next()) {
				    	
				    	val=1;
				    }		  
				   String upsql1="select status from gl_vmove vm where doc_no=(select max(doc_no) from gl_vmove where  fleet_no='"+valfleet+"') " ;		   
				//	System.out.println("------upsql1-----"+upsql1);	
				   ResultSet reSet = stmt.executeQuery(upsql1);   
				   
					
				   
				   while(reSet.next()) {
				    	
					   
					   if(reSet.getString("status").equalsIgnoreCase("OUT"))
						   
					   {
				    	val=1;
					   }
				    }		  
		
		 if(val==1)
		 {
		 response.getWriter().print(val);
		 }
		 else
		 {
		response.getWriter().print(val); 
		 }
	 	
	 	stmt.close();
	 	conn.close();
	 	  
	 }
	 catch(Exception e){
			
			conn.close();
			
		} 

	%>
