
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	ClsConnection connDAO=new ClsConnection();
	String fleet_no=request.getParameter("fleet_no");
 	Connection conn = null;
 	try{
 		conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select coalesce(round(kmin),'') kmin from gl_vmove where fleet_no='"+fleet_no+"' and status='IN'   and doc_no=(select max(doc_no) from gl_vmove where fleet_no='"+fleet_no+"' and status='IN')";
//System.out.println("----------"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	String status="";
	//String id="";
	if(rs.next()) {
		status=rs.getString("kmin");
					
  		} 
	response.getWriter().write(status);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
 	}
	catch(Exception e){
		
			conn.close();
			
		} 
  
  %>
  
