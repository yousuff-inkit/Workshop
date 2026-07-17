<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%ClsConnection connDAO=new ClsConnection(); %>

<%	


 
	String masterdocno=request.getParameter("doc");
 	Connection conn = null;
 	try{
 		conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select psstatus from gl_vmcostm where doc_no='"+masterdocno+"' ";
//System.out.println("----------"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	String status="";
	//String id="";
	if(rs.next()) {
		status=rs.getString("psstatus");
					
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
  
