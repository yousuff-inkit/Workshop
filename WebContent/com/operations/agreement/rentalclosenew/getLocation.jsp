<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
 	Connection conn = null;
	String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
	ClsConnection objconn=new ClsConnection();
 	try{
 		conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select loc_name,doc_no from my_locm where status<>7 and brhid="+branch;
	ResultSet rs = stmt.executeQuery(strSql);
	String location="";
	String id="";
	while(rs.next()) {
		location+=rs.getString("loc_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	if(location.length()>0){
		location=location.substring(0, location.length()-1);	
	}
	
	stmt.close();

	response.getWriter().write(location+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
	%>