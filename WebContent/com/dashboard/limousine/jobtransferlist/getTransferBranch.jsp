<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = null;
try{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select branchname,doc_no from my_brch where cmpid='"+session.getAttribute("COMPANYID")+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	String branch="",branchId="";
	while(rs.next()) {
				branch+=rs.getString("branchname")+",";
				branchId+=rs.getString("doc_no")+",";
  		} 
	if(branch.length()>0){
		branch=branch.substring(0, branch.length()-1);	
	}
	
	stmt.close();
	response.getWriter().write(branchId+"####"+branch);
	

}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
	%>
  
