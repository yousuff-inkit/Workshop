<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

System.out.println("hee");
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select branchname,doc_no from my_brch where cmpid='"+session.getAttribute("COMPANYID")+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	/* System.out.println(strSql); */
	String brnch="",brnchId="";
	while(rs.next()) {
				brnch+=rs.getString("branchname")+",";
				brnchId+=rs.getString("doc_no")+",";
  		} 
	brnch=brnch.substring(0, brnch.length()-1);
	/* response.getWriter().write(brch.toString()); */ 
	response.getWriter().write(brnchId+"####"+brnch);
	stmt.close();
	conn.close();
  %>
  
