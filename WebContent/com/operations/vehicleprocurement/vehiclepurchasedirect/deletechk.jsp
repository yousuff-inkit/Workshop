<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String docno=request.getParameter("srno");
 	Connection conn = null;
 	ClsConnection ClsConnection=new ClsConnection();

try{
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	int fleet_no=0;
	int result=0;
 
	String strSql1 = "select count(*) result from gc_assettran a  where fleet_no in (select fleet_no from gl_vpurdird d where rdocno='"+docno+"')group by a.fleet_no ";
	
//System.out.println("-----strSql1----"+strSql1);
		ResultSet rs1 = stmt.executeQuery(strSql1);
		
		if(rs1.next())
		{
			result=rs1.getInt("result");
			
		}
		
		if(result>1)
		{
			
			val=1;	
		}
		
		
		
	
   
	
	stmt.close();
	conn.close();
	//System.out.println("---------val-------"+val);
	
	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>