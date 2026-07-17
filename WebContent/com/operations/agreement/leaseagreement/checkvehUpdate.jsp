<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

Connection conn = null;

ClsConnection connDAO= new ClsConnection();
try
{

	String masterdocno=request.getParameter("masterdocno");
 	 conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select vehupdate from gl_lagmt where doc_no='"+masterdocno+"'  ";

	ResultSet rs = stmt.executeQuery(strSql);

	String status="";
 
	if(rs.next()) {
		status=rs.getString("vehupdate");
					
  		} 
	response.getWriter().write(status);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
}


catch(Exception e)
{
	conn.close();
}
	
	  
  
  %>
  
